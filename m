Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C7E0C79F99
	for <u-boot@archiver.kernel.org>; Sun,  6 Sep 2026 12:18:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3FA6660623;
	Sun,  6 Sep 2026 12:18:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ueod9YrexdxE; Sun,  6 Sep 2026 12:18:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 74E7560616
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788697091;
	b=e0O0mRF/9dmHcP+4BXxv3s4fz1ErnbUraxnRN85SiH54BF3bDYZ7jcuQgXgp4G1uB4q8
	 r2vtaAGE0nxuRPp0lkXQ2GpI3ZJLQvhiIB654QOpkjpxRRbZVAr+Wspgz+/YrTUufu+1g
	 XRUJi4hxPXoacQr6ojknGPDeTgGGpdkhMArTSMAtzHvzKA6+prrv/fFG4B5LLVFVdB8I7
	 K51QKsLf8/UBJFVT9TrOdWg0XDgDCuLyiHpPuFhE0+prZkJYlz2yRn0If5aJcP0NI4QwB
	 LHx2dShDkehTHcJUyIVApiqNOsd/CfPCBlpIhg5Grf96JI2HLOyKKL4Kh6kdeN5oVig==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788697091;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=z7veq1qrP4AzQjq9z/E0MF6cLJS1i92OKnEQyaGtg40=;
	b=NysAGXypwyYBSz4ZiUPjwxO+ta3x1kbApnE6couYVnlgnjFY3ctiWZb5v1XD2j/mqsB/
	 +hjnTX+HxFxZuNHEa8QQTS+rTp6l9bncA9ZLRJ7tDToslMcvOBs3rDnSl00FgxxVIPNGj
	 Yt3i60Xbd2KhWN2tttGztMjDI/HOfWo830SXxmjGOOWtTrQNZE2HpuLHwi1y8F3eQhdy4
	 H+uW+fAR6+s8i+w6ujZDpZM2tV8XlzeDgW7Xrx4RqNci9UtGQTERyz88p7iztvfrxivD3
	 mL9H4YzEjqJdG0+DLgh2mS3G75mW1BsK7wN0Klr/SSyPYp0MrszXnDFV/hcMydzYHlA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788697091;
	bh=z7veq1qrP4AzQjq9z/E0MF6cLJS1i92OKnEQyaGtg40=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AfiWtIRLC5XPNb1w3/tl8FQQ/gIJlYqNVfcLOCe8Y2eXQBxV+F/z0HkSnv90f8Xvc
	 d8cZbgp7TtBTAFTeyG6hqeH0R0fhFmI42ZmFJ/UNPv5GzcKuIvJkMR2R91ryO3xU7B
	 /HM1aU3VsantDFaLTw7QWjFaDEtQbHmngPi6kJIdpSFIRo3BKn5ahyVakQ1+5KQpJN
	 VzEn7xlCHgxuwlnKGgrYAsXCrRx3RysznJbshND7yMnh7bsoNtG5xjas60Aa+I0sEL
	 BasAvFb6dahnQL0qC+o7NTh83QPEjHV4I+hR+vSmbTkcXItKSmuKAMMwn9Z2BqACUC
	 YlQsrg0gHXUjw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 74E7560616;
	Sun,  6 Sep 2026 12:18:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id ED237970
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 12:18:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C3AD480D9C
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 12:18:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pXHmuyqs9pVj for <u-boot@lists.u-boot-project.org>;
 Sun,  6 Sep 2026 12:18:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 98AC680BD6
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788697089;
 b=Q8dDqT+hPFf8NjyKbZJp25J3BzHn8mKa6CgUDCWHP8RHTEQQr1my5YTEAG+2pher8/uH
 2u2RemoaPyMWrEvi5Pgm2dUGRw6dg5b2Pdm9VXC2X7iNNtcAyczHg9nYG9jRtrOY9ZCol
 rvoRkZ688TDnHe5Vb5+Bk/cY+WiclVm1xNWQ/mj5dkTZ3vtDYtOCkPeiVb6C9LUwiyvPF
 B5/DRVr+yRnWtFhTsYHZ9lMEScBGpRmrebHeGMXEOadHVI1xJmDdYbzF2BlMnmvuX7A4T
 alWTAayD3TOyTKNtr+HyhU86JWHlABOSeUENOqkMmUd1+gUATnjCw6qfJbKJ+uZW+mQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788697089;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-Spam-Info:
 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=z7veq1qrP4AzQjq9z/E0MF6cLJS1i92OKnEQyaGtg40=;
 b=UmSF+EnMsww0EicWAwaHwiLQ2xMmsvrypInW4/wLo+zzegbagOpv3LEOD7quIb6yiu4e
 cKAzMfvhR+deNa0af/Fx7vgXMPrSjZF33avgivmsoDfAdwg8Mev86wzBybsZ9IMJkPzkN
 3SxLNqUd4NS3OdrEwnOSlWmxI2M6FE7unQWDOkFS4Zt/d9MUFAktooI+pcORmsvLGBJOF
 QqWsibK7Wu+pFigfalV8zpxGICb4CvD7Vjm6Cc+/ygtG1GbtpG+IuTdWH9op2SQIaSTk9
 CDqSRxjFQ5mjURsAdkiy+hwk7VEYoguw0WxHcMDssapcTM1+Vc34gd3AF3dyCrDIIRw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=ouWP0hg4; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=W5A6iJCg; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=ouWP0hg4; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=W5A6iJCg
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 98AC680BD6
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 12:18:08 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 685NxHVT344391
 for <u-boot@lists.u-boot-project.org>; Sun, 6 Sep 2026 12:18:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=z7veq1qrP4A
 zQjq9z/E0MF6cLJS1i92OKnEQyaGtg40=; b=ouWP0hg4DwfA0r6+OLSnPubw7Vj
 uufvv/XVWaqdl8YFD7z5G30gs8Sx1+/DXMoOZxSoAQ5V3Ct183FECc2B/pm9Q5P2
 Gw49vEFrK6+PIjYNVTQUe2cvVsau5k4qrh+tp7Wi7XmEGi3LmlAfjGQNm9xsfejO
 dNsfmd86CzYPXScMdqrVOf3keDR1phnq1C74eksS+yNdDn24k1He384ILRYjJ6MP
 t2vJAgjeyWmn7iJCWI3SrytKDYZrh6zRuM1MeqJaDEfBMf9WS82bfYIdz1Tyuzqd
 L87sxVzuffH6gKWW69k3WMXKBdMAevS2bbIdI3B7h73PD6Cv+3To6QBRseg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gga1s3jtm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Sun, 06 Sep 2026 12:18:06 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cbb92868263so2143145a12.2
 for <u-boot@lists.u-boot-project.org>; Sun, 06 Sep 2026 05:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788697086; x=1789301886;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=z7veq1qrP4AzQjq9z/E0MF6cLJS1i92OKnEQyaGtg40=;
 b=W5A6iJCgu4q7tBwH7/nMbn+jKaI7NplNelsDJ/rh0XXQPvUjMdEqZfQ0pSc2spWujG
 20wfcR8IpOrm4FoEClwP/QPXsXqvpWasS387ZHGeHFC8NVfyjOSO/rjuxNXuGAnmmpv0
 DU5d/knuue4bZQ5UHTicw997IOwiY69kv0bzHjR0IYIPWQNZ30Ku3yYl/hSk1irk57hm
 V0T9n/S1Lhskfc2v1IPqvpyQrDehlQnEQKkWTIcm4919ZADmgn7XFkhSOeKZXYlwcXHP
 0ZZQfM10j7nCw/fBDKFZNZzkQ5war5PQUtTzXERp/pEahqQW776TSURUywoqMNSjRpua
 xm5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788697086; x=1789301886;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=z7veq1qrP4AzQjq9z/E0MF6cLJS1i92OKnEQyaGtg40=;
 b=Q2URRnxpgSWOInRk9FcRMEQGYa72N1bgiZqnQokDPZNFNsRSlSvrVpJceJKzEPIXY+
 BxahDfsfGJ51Wzmd2NOAp678mnFjbfI9bsuhop4FCTYhjFhc0T75RjQOzdGytnc/3pk4
 sLvzuJ9b4x9yRhHMC6Qx99b3ugFd/OxltcdAZazGed3sxBkcFTnwiSYx6LpDwc/OUo+P
 bhgwLYqtWdEdG9PMmhNtfOMV6+HC0vitccsc72bRmbZQbxSOVDhu7PPN1Nsf2ftzoh/p
 nZNyj4wSreZh4QvnFNTXHiwJDXky5FPck+ogvbOLhulghirsKo0lnCUFjkaKQKYVRBIP
 GCTQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzd/hRssyHKj6mdpoIlQrwKyZ2MM2B06lGqVB2IVFxGocFIRwyxQBSOWCvBTcBWWHFwk33ISGo=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++ldbuzWFOcr08YCEvlW3Kxf6RqV+oWN7G1n0RAI2F/DwSsqYSrj
 528jF326S4L7LGjQmwEb7PuLOSs8s/bFzqK4piQDGMSEc7Wo1Lz4dO2nV6tEB0eQKQQPy5QrJFs
 9DzM0YXIRWrwtYQkC3G3lSL+rc2C7LPCNBwEzno11P1KXv1fsWTWqkyQabVzmizntBwg+5Rk=
X-Gm-Gg: AYBFou00QDlK7EEvifIaadzI4P7+oyoHmAPnkvdyiMIULYaMULuXvNx8q3rHt8zTVNZ
 tck4Q8/etqTqdtJDMNN5gnLDfOIk//EvhnzClJXWbdLFUehEzVy2LaI7SDcIk9zohRxQ+geDk7m
 kMKGPjm04iuP4670ede9rT1D14qI2HT5pUYWaghaZydRTIOT8t7iQPDJqBUuiZOPoXW2NI0A8/h
 tROdJMJ0GTwvOy33FpS6oS46iAbp6gtEoAoPU7KFIaDyrXUCGWIotY2qz4bZFug6eAN5eizS608
 rJTZux8eCSHmp6+SQz3AvidVEFglrgsbo0TTuKk9oTvgqK1zIkZqG1TvNPHjER5Nb6L9YmNi0Vv
 pc2ucjpVYFGMzqhMPwS8Wk+VV2VC9PykRqWekXRAYNFie9I+2t9H5puUgnbmqEsbgVHPIKz1NPU
 Qg6ZV/flrXsrXAeCqOhjw=
X-Received: by 2002:a17:90b:3149:b0:393:194d:5366 with SMTP id
 98e67ed59e1d1-39b2618060cmr27208378a91.10.1788697086289; 
 Sun, 06 Sep 2026 05:18:06 -0700 (PDT)
X-Received: by 2002:a17:90b:3149:b0:393:194d:5366 with SMTP id
 98e67ed59e1d1-39b2618060cmr27208330a91.10.1788697085849; 
 Sun, 06 Sep 2026 05:18:05 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14332405e92sm11768639c88.8.2026.09.06.05.18.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Sep 2026 05:18:05 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, xypron.glpk@gmx.de,
 aswin.murugan@oss.qualcomm.com, varadarajan.narayanan@oss.qualcomm.com,
 quentin.schulz@cherry.de, balaji.selvanathan@oss.qualcomm.com,
 dlechner@baylibre.com, vincent.stehle@arm.com, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v2 1/4] efi_loader: skip fs probe for non-ESP GPT partitions
Date: Sun,  6 Sep 2026 17:47:48 +0530
Message-Id: <20260906121751.3550628-2-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260906121751.3550628-1-aswin.murugan@oss.qualcomm.com>
References: <20260906121751.3550628-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=WMBPmHsR c=1 sm=1 tr=0 ts=6a9d59fe cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=KavJIdows_Zzsu0KXw0A:9 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA2MDEzNiBTYWx0ZWRfXwiLjUB/4PhjJ
 mHAz0LA6ZhN9kjRrp+rTDfOyTNqGJMcpr69BaTLNREN3B7JZBIK7+1I2LOsn4FxqWg6z3Ltcp53
 NEaPI5FMR2O+JWWW5tnCDP8KX0gWXd8=
X-Proofpoint-GUID: owXLd-Ps3RsJ36fdLuvlhJdj5SAm1xWU
X-Proofpoint-ORIG-GUID: owXLd-Ps3RsJ36fdLuvlhJdj5SAm1xWU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA2MDEzNiBTYWx0ZWRfX4e09HQX16e0g
 S7022Jc5FM+Kj+efErkr3R3ycWxUgiGAG3jP8F+bpksXL5Kl1en0SFou+PsUF2c738rTt8rpZQK
 GX8OKJJsDkYJL970Kc20voCZsxc8Vzq1ZQcdZ2UL7Ozpr2LAXnvIqvpGyChf9cGGZqK+Rv9Soov
 EmECpMD0Ox2Kt1lA0L9BZp+bWjAigvMuxCtK+2Rn5iplnfcPFfanfSUVQBE53OnNG+QJdo7XvPZ
 /LS5qnMmxY42bPTPCkXd1tOzZYZM87Irt+13FpKIa7I6qajQ7VbMZWieVazf4T3HlUOPS4Eklan
 Ha5ryDbKR/cR2YPUdXKpTCTQHgslAzqnaXPuwVMZicQp1S+D/giwdDP9pBsnDWaCgoYKkWHaTDU
 BTSBwn/PehhjgdEdpGlxYNbbfYFMjMI6NIiNe6PY0+VpCGI3M5bnKvDD6o4erVG9l3wV3u+DI9o
 MeEsnRv2m6TH/Udc/Sw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-05_08,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 spamscore=0 impostorscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609060136
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

efi_disk_add_dev() runs efi_fs_exists() on every GPT partition as
soon as its block device probes, even for raw partitions that are
never opened as a filesystem before boot. Only the ESP needs this
probe for boot, so skip it for other GPT partitions.

~170ms saved on Qcom SoC bootup time.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 lib/efi_loader/efi_disk.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/efi_loader/efi_disk.c b/lib/efi_loader/efi_disk.c
index 4a3ace3a304..4fd53fb598a 100644
--- a/lib/efi_loader/efi_disk.c
+++ b/lib/efi_loader/efi_disk.c
@@ -529,8 +529,12 @@ static efi_status_t efi_disk_add_dev(
 	/*
 	 * On partitions or whole disks without partitions install the
 	 * simple file system protocol if a file system is available.
+	 *
+	 * Skip the filesystem probe for non-ESP GPT partitions: only the ESP
+	 * is ever opened as a filesystem before boot.
 	 */
 	if ((part || desc->part_type == PART_TYPE_UNKNOWN) &&
+	    (!part_info || (part_info->bootable & PART_EFI_SYSTEM_PARTITION)) &&
 	    efi_fs_exists(desc, part)) {
 		ret = efi_create_simple_file_system(desc, part, diskobj->dp,
 						    &diskobj->volume);
-- 
2.34.1

