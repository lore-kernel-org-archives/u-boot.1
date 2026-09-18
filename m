Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52126C982D2
	for <u-boot@archiver.kernel.org>; Fri, 18 Sep 2026 05:22:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5489560BAF;
	Fri, 18 Sep 2026 05:22:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mw6Utx8XlDdr; Fri, 18 Sep 2026 05:22:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 3B29360BD3
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789708949;
	b=JnU1cqnPYuaReQeQzzCS/9/ShoudnvkAcACbfXfEwsiA5ot/NoVvzZe70ObU2r7h9CE6
	 DVVxqBozUHRP0bPwxi8mt9/c3WgGG9NdaPWQqeo4komvPz9QiACJAP0ysrHNMjE4QGkQm
	 B6Q9Jf5Iyl73QLm9yTK3xKCLn1iOweuF8az64Z0pGnP1cRXfznTHWEPCUFrzbLOjcJXjZ
	 mlYmfFdF3Xgi4N5dCz5dpJq7qfCYC7DlPOX3MvvdUid3NWawsN5xxIkxMk00pJjeLz7WF
	 lBoNgB5Ysbjarl9ngqPjfa6L9WniWbGrHNvnNBNX51wDef1VeTbLCqfR+qhVI/iu/2A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789708949;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=RA5+y99DwxKxe/Rq5TmKQ9mSTyubI4BSEsBFlOATwNg=;
	b=V9W5q476Wjy15pyJkDcLKLx860HlOQOZxcIIdzZue/v58dNDrDM/ChBmF+A97dpKbcGf
	 QLc24vqSsBA58Vah75s2CI1j7TYfqsp0FfQiDROMRsB+27y4irxeQoXAKqbk5dFkvvXgJ
	 kGn30XC8nmWrSe+2+antS87ka4Qzk0fndQuAkB+cNTvutnCsoq1hchetPYdDErcZYKT2F
	 k8qqPhO35/U/F79Xm5DYDTcDJpiZIj487wU4RTUgHAQNaH33HtSIAqEmmQDLBB7l12cF0
	 4pSqdxCxgHGF0SAr8U8xKfiVABtnvTISu+aR+0Ehke6y3qJ07CXlNOnGSfoC+YrgN5w==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789708949;
	bh=RA5+y99DwxKxe/Rq5TmKQ9mSTyubI4BSEsBFlOATwNg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=B0ljuAoIVcLyGXR3fQsnBWOuy8YvtnU0M3djnO5w/CH5Us3317S6WVB2NRCnl9unR
	 lUeFZTAYeTvZvPqSBV+9Ubd2/L5dlXzycAkt6tLk0ZhbGmEgHWR9JW+rfMLkDvMjBa
	 65ERGamBNGtRoaABLwHhQ8oZnKfJqFug2A6hWg4h3XhCbDqT7V84b7zP+Kw2VG35Yu
	 aqixzAZnur55Tvc2TIcm9Q4869AoZLOTDW660wcXqLB/O0m+n+ftxxHsG+oX/1i9FM
	 MCR1GIEs7CiqOhqq+mUGh92RCLv9fFr6Qi3rK5pfxt1AJa/5vGkIH0rnvWToWbZ272
	 4MqR6nkc20g0w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3B29360BD3;
	Fri, 18 Sep 2026 05:22:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8091013D
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 05:22:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 669BD809B4
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 05:22:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DEATq6dL6qgH for <u-boot@lists.u-boot-project.org>;
 Fri, 18 Sep 2026 05:22:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 8EDE780994
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789708946;
 b=MzEhem7Cj4vdc1L3rKpFb4AwhJ/aOr8IkXFpZu2ezo1gF/Uc3QgX3wFPm8aoPdnXT6oZ
 OPQdU71VWZdX9VNBcSFzyC4t+9WuQ4bqmGq/T8zlg0YwSEGCqXtkwdMgJbN+IzNzG7Ypw
 2at4fRKCoCWYEPMqsSRdyh1K8hIs/UDa+e1Oku2UVS+SaSqEbUlCvmeNVZYrPt4aAm2Sy
 f2wVPVt9lLuuowQZsvBpoDMDRjZB1PwWPPuAv/AbI6EH1Y3kfQ+q5l4ew0CoYv7ETr1Hm
 CLDuCDwBGGLrVe27WYuN9z+fFSaXindWJ9RJiD6ljAN4YmnwTng+k2NcjZCTxMDcotQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789708946;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=RA5+y99DwxKxe/Rq5TmKQ9mSTyubI4BSEsBFlOATwNg=;
 b=tSvytnXINJRetaB04is0skpJ9zeACmVVaVUJCyLKOlzpIbuT8+epOlS5OjI/ngjkTJVc
 CLQ1KVTO1orWEgzfwmYVbcNsUgi57gm6SRn3bZ1/2dyAE6y8SWtpswJciM9hhKvokpVKi
 mEx/WSj+j/6hGWP8QtKUEsjGsFD5OBIUBhaxtddcTR2GArXQEbVC8+h+tvW405VB0S+lh
 QYSKj50kXr+oAgP9sspx/Lc0LnnMwlgSBLt17CqjEtM8bHz6/sffGFrex7fbx8guuOI5M
 sGS3yV5LCF+U8B+mC8gZUpahjrqrw/gKIY/21BmCQLJ6LAtTxPObrf8aym5MOI/qldQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b="VjA/+IBy"; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=atdltyRb; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=vandhiadevan.karunamoorthy@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=VjA/+IBy; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=atdltyRb
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8EDE780994
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 05:22:25 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68I2UVaS2972525
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 05:22:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 RA5+y99DwxKxe/Rq5TmKQ9mSTyubI4BSEsBFlOATwNg=; b=VjA/+IByG/BSTvbx
 L3QJZtTHdtquDjBGnzmMEMIO9TgxI6ARTtBTTnIOid0TjJ8RYajUJR5P0bE8HgCM
 Y39YaoUtcAr4+ArBpRto+NjQFfCRuxaXcmQy+4hgwWMdE9i+WIIrJ+E/oUMo0a29
 UUx6en7H4hME94TyT8GY7qqlKeURtO0pjY3WIfh+bSezsctRoRs+KJoKK8LS6WRM
 lqTGCTTvhsUZoKC+t0SldlAHlVslFt97Rk/MIHQ6Aj+8uIw5EctrUUM8ILxJ2qtD
 7HjtzF+XmRPj7RXcldDkSSF/O38wWAvSQml0U1suyWkjzBFCYVPUdsjstcd51yn+
 QkeQPg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4grrjdsfq2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 05:22:25 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2db87f759c5so8411135ad.1
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 22:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789708944; x=1790313744;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RA5+y99DwxKxe/Rq5TmKQ9mSTyubI4BSEsBFlOATwNg=;
 b=atdltyRbRNB1GhOjHoj1HxiVCv6OFt9BIbUpjs4YZN8FqYbYrBFw8x2tmfmX6999qo
 2jn9u+azyCMCrgomRm8hxCsr8z3cT2PzKGF1OdGUk3A2BY1mkLdpyHg33U4bBj/wiBWz
 sGgUjI6dbTFbvus5VqPsllTc2sVUFDuBo68gCxaggIveO5E9oxq/WErkYC8cfBLmtA/h
 ZgwzzXkOlbkSEU4OeAGRTAeLIa8QwccOl+tclmzMr7zP31Z330sdw3LoiAwfcGnq2Exs
 SqW1UVK5mET+R/XT2MzqDdw+Tf07cqeSaJE3I83yC4SCjySFqfMAfHwpCa9mH0Xo+jdx
 4KQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789708944; x=1790313744;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RA5+y99DwxKxe/Rq5TmKQ9mSTyubI4BSEsBFlOATwNg=;
 b=DFTLZfQDbCLmHCkxuHc4YFesDf+9xGIHCV8udho5PIoMXJNbwx+sLMfnjRO6i08Xuy
 0HNN7OKwXjl5D6qolAao2HxQD1tAXDhivwlvP0nDg0g5hv+v1eJrhS84l+xo0f4WU0kH
 bZoMWn/Z3Me+syBLNwf+vXvZnEumZlWGn4m65Lve5xVjIeOhXLMf4HKgMj6FFUQAN3Za
 8KiH8FQxR4hrRf9NG2Hr4dpCu80L3SxGIVnI3SrTBVjG/5NoeFyIjiKDBWme0Uf8HYxB
 33RDUzB9D+QrnNfmbaxAN2ZpKod6neT55GELVfWphFpY2MseDqMgoNg9/3Q5wigSYLrh
 yklg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwQMl2EJRMkjhCJtUhl9vagBe/4nbNHHDXoJ/sqdHzZwoX9uDGRbTbLj05IvTHJG24q0XJ3q8U=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kVETmy3tQX5Po7zcz+Smc/t1Y0XJpCg1fljAjFwshsWgNSV9nK
 Y47U/Dqn0Ohw6rlHcjTArAQiM3JenF7z/d/1E43IL4yzGfnpEUGMLV0VuMWfq8s3A48kqrDtEg7
 Eoqr2fxeYdSsOROJmKhBYqpb4v1ZffsVA/v78ctDGZZQFJYHCj8Fepq1DubDStCDYDYCmuNk=
X-Gm-Gg: AYBFou0WVMxlwocnIxr+ogMMxWlLNO4ytbciSrgGfOljd1i7HkDaKP33DNzFdnfh9+V
 FJy7jYZQqROC5iKSGyM8m2ofZOEvshGN70tGkURtHtndVf/J8Im0mtIrJaKUPF/tENfSZW4TkVj
 Qx1gvB8xXysoBiNkWPQt0nQABi/iMCFUmEF3ner2J/e3MQR9U9OuBS9i6c1HjoLf/+q/ycEhGU3
 EBfPQ3WCC6VndiPCVhMR20cebSErVVYvefc+fNR5K74T4zdxC8jw9Kch2SfIjM9OAM0SsL91U2v
 4mhSAviZrPQTbx4mp2tyTudfd0QUF5Oc/wuJxmSkKuJZ3t3vF5rQxEjEWP+81IDv0mKovAw7wOc
 rk2Zv8ieeg0HIOZlg1xIjHMoG0YpYkInZSV5nhTUmKloij3VIQxElRX6Vaq86SzHx630bjeMCbT
 UciubgYdvz78Dn6Yv2BvnHWAk14TYLvEAV61++9Cc=
X-Received: by 2002:a17:903:1a03:b0:2dd:78d1:65c9 with SMTP id
 d9443c01a7336-2ddb1b8d978mr32014985ad.19.1789708944445; 
 Thu, 17 Sep 2026 22:22:24 -0700 (PDT)
X-Received: by 2002:a17:903:1a03:b0:2dd:78d1:65c9 with SMTP id
 d9443c01a7336-2ddb1b8d978mr32014415ad.19.1789708943762; 
 Thu, 17 Sep 2026 22:22:23 -0700 (PDT)
Received: from hu-vkarunam-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33c286dc939sm1162060eec.6.2026.09.17.22.22.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 22:22:23 -0700 (PDT)
From: Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>
Date: Fri, 18 Sep 2026 10:52:11 +0530
Subject: [PATCH 1/3] fastboot: spi: add 'oem spi-nor-init' command
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-series3-oem-spi-nor-init-v1-1-319dfeed6c2c@oss.qualcomm.com>
References: <20260918-series3-oem-spi-nor-init-v1-0-319dfeed6c2c@oss.qualcomm.com>
In-Reply-To: <20260918-series3-oem-spi-nor-init-v1-0-319dfeed6c2c@oss.qualcomm.com>
To: u-boot@lists.denx.de, u-boot@lists.u-boot-project.org,
 Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Dmitrii Merkurev <dimorinny@google.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Adrian Freihofer <adrian.freihofer@siemens.com>,
 Heiko Schocher <hs@nabladev.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789708933; l=6300;
 i=vandhiadevan.karunamoorthy@oss.qualcomm.com; s=20260817;
 h=from:subject:message-id; bh=7FptuSS6nKme10+yEEMXERgy7c049gsvQNBjY+jULvk=;
 b=+k+zXLD20DTFnBSCKiOL1f4MTuD19g/08DRwDYzCifkNxvh/gES7Lf66Hq8RewKRtQhOoc/c/
 dMEUJlidFu+BWFuxbdlI+rH8+MKNJ94Sy/nSYc9uWrkdWWsaarhIs48
X-Developer-Key: i=vandhiadevan.karunamoorthy@oss.qualcomm.com; a=ed25519;
 pk=2EVV7DmKqYX4wxSlXPB5QBt44JjomLlz/wTW2AL4H6I=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDA2OSBTYWx0ZWRfXxRZWxsiTT/HD
 qQ5USSabDts6NQrLaN6wQhx01VTD41Zn7FFPDRpHlPA6tbIvNTzmBUdMTIu1vQntYJpIaZjmZpy
 yAcemliOfjmUwLQdDrFFdWLYvxirYX8KscLJ+MMFnrLO4yw79VWe30hRoIZ31ri3nqWd5n4GFAo
 9D4sxLW52Pv1zXxR5ee3oPcxjPP9swBu3pp7oI0fcRsSKO5x0SvxjshByH0Yn049+IOrkF7IWfn
 LTWlWZKqH8/dSCZnOqr8QyFNCsDo2IAB8QcX7QeHOWK6Kj0aQS/LGUC6dXYkKQpVBHaleU6DSLy
 k0eK/C21ULEhuYueqmCugTVs8DG9gocClsiOwLKS8KBMHaH6iGMnwff7U81gIGcFyl/FEeu1rr9
 XAI8UTIB3og8+vMUbp37mpyXz4rCeoNbezVDdfZeTQIPUlh7BEq2JARPpaVJC0KZMuH1HEWPmXs
 jwOIQXhj5LHqLrx2CCQ==
X-Proofpoint-ORIG-GUID: NlLCkJH5n8UFcehZBg5v0Xo0jtw3ebi7
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDA2OSBTYWx0ZWRfX6n41xjSEi5pC
 rvTzXnsm8Yu6lmhOO+SxiYW98NcwiBFiS/J4wD2D930FrkjOtpAdkneHTviMXQqCgtxU7bCFblZ
 fq6fM44t3fU2LC8yWNWEcfsb4RplD1s=
X-Authority-Analysis: v=2.4 cv=J9Q/fwnS c=1 sm=1 tr=0 ts=6aacca91 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=xct9wBpx4OdK92ZhXKkA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: NlLCkJH5n8UFcehZBg5v0Xo0jtw3ebi7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_01,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 clxscore=1015 suspectscore=0
 phishscore=0 priorityscore=1501 bulkscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609180069
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Add an "oem spi-nor-init" fastboot command that probes the default
SPI flash device, so its driver's probe() can run now if it hasn't
already.

On some boards, the SPI flash device fails to come up at boot
because it depends on a one-time, driver-external step that isn't
available yet (e.g. something that must first be flashed by
fastboot itself). Bringing it up later just needs that step redone
before the device is probed. To do that redo without hardcoding any
SoC-specific call into generic fastboot code, add a weak
fastboot_oem_spi_nor_reinit() hook that runs immediately before the
probe. The default implementation is a no-op; SoC-specific code may
override it.

This is useful on boards where the SPI flash device is not usable
until fastboot has flashed something it depends on. It is intended
to be used together with "oem set-block-target" once the device has
been brought up.

Signed-off-by: Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>
---
 drivers/fastboot/Kconfig      | 11 +++++++++
 drivers/fastboot/fb_command.c | 55 +++++++++++++++++++++++++++++++++++++++++++
 include/fastboot.h            | 13 ++++++++++
 3 files changed, 79 insertions(+)

diff --git a/drivers/fastboot/Kconfig b/drivers/fastboot/Kconfig
index c7e0509eaad..bb8184f6fb3 100644
--- a/drivers/fastboot/Kconfig
+++ b/drivers/fastboot/Kconfig
@@ -236,6 +236,17 @@ config FASTBOOT_CMD_OEM_SET_BLOCK_TARGET
 	  CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME /
 	  CONFIG_FASTBOOT_FLASH_BLOCK_DEVICE_ID build-time defaults.
 
+config FASTBOOT_CMD_OEM_SPI_NOR_INIT
+	bool "Enable the 'oem spi-nor-init' command"
+	depends on DM_SPI_FLASH
+	help
+	  Add support for the "oem spi-nor-init" command from a client. This
+	  probes the default SPI-NOR device, letting its driver's probe()
+	  run now that a dependency it needs may have just been flashed.
+	  Use together with "oem set-block-target" on boards where SPI-NOR
+	  is not usable until after fastboot has flashed something it
+	  depends on.
+
 config FASTBOOT_GPT_NAME
 	string "Target name for updating GPT"
 	depends on (FASTBOOT_FLASH_MMC || FASTBOOT_FLASH_BLOCK) && EFI_PARTITION
diff --git a/drivers/fastboot/fb_command.c b/drivers/fastboot/fb_command.c
index a015669c43a..2d09b2e65e9 100644
--- a/drivers/fastboot/fb_command.c
+++ b/drivers/fastboot/fb_command.c
@@ -5,6 +5,7 @@
 
 #include <command.h>
 #include <console.h>
+#include <dm.h>
 #include <env.h>
 #include <fastboot.h>
 #include <fastboot-internal.h>
@@ -13,6 +14,7 @@
 #include <fb_nand.h>
 #include <fb_spi_flash.h>
 #include <part.h>
+#include <spi.h>
 #include <stdlib.h>
 #include <vsprintf.h>
 #include <linux/printk.h>
@@ -46,6 +48,7 @@ static void oem_bootbus(char *, char *);
 static void oem_console(char *, char *);
 static void oem_board(char *, char *);
 static void oem_set_block_target(char *, char *);
+static void oem_spi_nor_init(char *, char *);
 static void run_ucmd(char *, char *);
 static void run_acmd(char *, char *);
 
@@ -126,6 +129,11 @@ static const struct {
 		.dispatch = CONFIG_IS_ENABLED(FASTBOOT_CMD_OEM_SET_BLOCK_TARGET,
 					      (oem_set_block_target), (NULL))
 	},
+	[FASTBOOT_COMMAND_OEM_SPI_NOR_INIT] = {
+		.command = "oem spi-nor-init",
+		.dispatch = CONFIG_IS_ENABLED(FASTBOOT_CMD_OEM_SPI_NOR_INIT,
+					      (oem_spi_nor_init), (NULL))
+	},
 	[FASTBOOT_COMMAND_UCMD] = {
 		.command = "UCmd",
 		.dispatch = CONFIG_IS_ENABLED(FASTBOOT_UUU_SUPPORT, (run_ucmd), (NULL))
@@ -648,3 +656,50 @@ static void __maybe_unused oem_set_block_target(char *cmd_parameter, char *respo
 	else
 		fastboot_okay(NULL, response);
 }
+
+/**
+ * fastboot_oem_spi_nor_reinit() - Vendor hook for SPI-NOR re-init.
+ *
+ * This is a default weak implementation, which may be overridden in
+ * SoC-specific code. It runs before the default SPI-NOR device is probed,
+ * and can be used to redo any one-time, driver-external bring-up that the
+ * device's own probe() cannot repeat on its own.
+ *
+ * Return: 0 on success, or a negative error code.
+ */
+int __weak fastboot_oem_spi_nor_reinit(void)
+{
+	return 0;
+}
+
+/**
+ * oem_spi_nor_init() - Execute the OEM spi-nor-init command
+ *
+ * @cmd_parameter: Pointer to command parameter
+ * @response: Pointer to fastboot response buffer
+ *
+ * Runs the SPI-NOR reinit hook, then probes the default SPI-NOR device.
+ * Useful when SPI-NOR is not usable until after fastboot has flashed
+ * something it depends on.
+ */
+static void __maybe_unused oem_spi_nor_init(char *cmd_parameter, char *response)
+{
+	const int bus = config_opt_enabled(CONFIG_DM_SPI_FLASH, CONFIG_SF_DEFAULT_BUS, 0);
+	const int cs = config_opt_enabled(CONFIG_DM_SPI_FLASH, CONFIG_SF_DEFAULT_CS, 0);
+	struct udevice *bus_dev, *new;
+	int ret;
+
+	ret = fastboot_oem_spi_nor_reinit();
+	if (ret) {
+		fastboot_fail("SPI-NOR vendor reinit failed", response);
+		return;
+	}
+
+	ret = spi_get_bus_and_cs(bus, cs, &bus_dev, (struct spi_slave **)&new);
+	if (ret) {
+		fastboot_fail("failed to probe SPI-NOR", response);
+		return;
+	}
+
+	fastboot_okay(NULL, response);
+}
diff --git a/include/fastboot.h b/include/fastboot.h
index 13dcdf919bc..3d444e125d8 100644
--- a/include/fastboot.h
+++ b/include/fastboot.h
@@ -52,6 +52,7 @@ enum {
 	FASTBOOT_COMMAND_OEM_CONSOLE,
 	FASTBOOT_COMMAND_OEM_BOARD,
 	FASTBOOT_COMMAND_OEM_SET_BLOCK_TARGET,
+	FASTBOOT_COMMAND_OEM_SPI_NOR_INIT,
 	FASTBOOT_COMMAND_ACMD,
 	FASTBOOT_COMMAND_UCMD,
 	FASTBOOT_COMMAND_COUNT
@@ -106,6 +107,18 @@ void fastboot_okay(const char *reason, char *response);
  */
 int fastboot_set_reboot_flag(enum fastboot_reboot_reason reason);
 
+/**
+ * fastboot_oem_spi_nor_reinit() - Vendor hook for SPI-NOR re-init
+ *
+ * Called by the "oem spi-nor-init" command before probing the default
+ * SPI-NOR device. The default implementation is a no-op; SoC-specific
+ * code may override it to redo any one-time, driver-external bring-up
+ * that the device's own probe() cannot repeat on its own.
+ *
+ * Return: 0 on success, or a negative error code.
+ */
+int fastboot_oem_spi_nor_reinit(void);
+
 /**
  * fastboot_set_progress_callback() - set progress callback
  *

-- 
2.34.1

