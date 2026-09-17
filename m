Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CDFAC982CD
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 06:59:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 08AA36075A;
	Thu, 17 Sep 2026 06:59:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3CQGCfu0TExg; Thu, 17 Sep 2026 06:59:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 2ED856062C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789628396;
	b=MNnVVawTEtfmcVxYRU41bTNDa7KkKFCRIsKAByR7ihRrkQbMxb2Rt+UEh00nnY68WUJ9
	 EHGHTi/8BYjiAylLIpzKfItWqx7U00/h1mx7s/ZB8i8+gsTbr4evYS6u9I9lb/u2bb8Ki
	 tw6fSK9kSR1pOsPG0p7riW0DPqJi0t3DM5Nhd85aBB416qQ3YUg3xXiAO7E8zlN/SkiWX
	 zmNwgcPc9P2pKW2A0tS7zryOFHRfrghnSiEj/v2YcJ5CeAoQaUmHgwzqDziV60iXByGT5
	 X/eQaxUTjp/jvnXLHJaqtammFWUbyQ2k1CeOSmqIt8QzdBu7C27QIJkolqe8KIcheEg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789628396;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=NE7yaktnQEiWCqYoRQwe8dzxSHj+ajguQ0tu6Hb2jsc=;
	b=Td75bIfiflhFTSeh/xnL+tTLypldNzlxr89URIrPy6Xb7eW9f+XVMrVXgI01HIn0a74g
	 SJJUwB3HrWFw1AkvTes2UJFq/dZ2Bp5hCHEsmAi9X6TvMTaTKIE88UTST72FSNTqtQorK
	 mf/RGEITtOcSADwOOSv8iALNzt7noI58pqX4Xh/8XMLsrUIxbuvo2MpP4d8c/cIEiQwGi
	 BNQhASngJ7nO0YfGm9tRhnDaMG9kKiBn/rp170LbXcCnCcuenRfGyDcFvjEnkwIEGnhWH
	 kiU9ZS7EtZycZAZBkw4CxL7HVhGUcLEeTCrwMdUDvkV3Pt0C8dwI5Wqp4uKFPgtBHqA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789628396;
	bh=NE7yaktnQEiWCqYoRQwe8dzxSHj+ajguQ0tu6Hb2jsc=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=OJt6dDvJWysSuKF9NhRbmI2fMgdy/B67uO2mgObzmV32sw9ncs7uTH1tvd5bIDMHj
	 esznejcbxLokU74HvOWEivzdll9Bgj6joYjMma3T1Dxkt0c9WJi+5fd4UMTiPUtdr0
	 b+dGIFrHtGN7EbHEKhDKULxYje159pew8V+6CvcnSTtWwZszIxBiUJZ50mb9NsN85L
	 /XiMQPcXL0nAysqLgIWgCZeGvpWOcPefHH3+W3vORVsCQ8IlFgkfg7jWXX5/iuAcoq
	 HA3UAWt+uVZBelLENk4IterZOj4u8luMFCIeAS5khGvUXUapx0vt0dMP1cvpZUDjpn
	 +Ad3PFvoSytig==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2ED856062C;
	Thu, 17 Sep 2026 06:59:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2844724D
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 06:59:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 19EA6406D4
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 06:59:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jjlOqwO6gTUZ for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 06:59:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 2AEDA406C4
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789628394;
 b=i4giGVngHDZz0KIQ2L/Q5MS0hKeuudTXXfHOCKk9dtqPV+a/diGYNp71/nxIg+IOeFgc
 ZwgU6NWj8LtgaetTxd/jEkD1CJihVxRJlfZSbvTJ68+4uAwsNRt2EbLJRXrnTxdB949OY
 Qb3OLRcsRsAhEpo6olGZcJ/xIw9sB4Mcp1euOU8ND96ZNlphwiGaPwOJ0oe5auCKnvTuM
 LjzNVLci/VOU7ysIXtCjzanMELbLAChK35gMMNwKmKDlFH+99/uN+mRSfIS2lltIWJs7F
 KBkwF6H2PEhRfU8mIlmZibeKoDShVIlvh/TmIqKFgv9bOyxTNj63EIADPZKtHa70hoA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789628394;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:From:Subject:Date:Message-Id:
 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=NE7yaktnQEiWCqYoRQwe8dzxSHj+ajguQ0tu6Hb2jsc=;
 b=SS3+AsTTI4K2druKAGhLcWAJhey/7ZFC/4R9BL+ir8J2+f5r4CTWaB4LKld1qjE+yEqm
 fr8oRNIpOa9w04Znxwlys1KHg0B8SeBVGQntcR7SS5Z0MnAzautatmVorJmz6DuCpEG+2
 4y010smdRr2df/OpMvYncNaBlUxv6aCchspBZZkNUlIE59rwnsBSAoSAGB0LlyLzQM1Dk
 mjsxnOAuTawbOG8lwg3MBuNIqGHoSyn9LlwNfoviCgW/1GDdvmIMEo2yPlDYcfWdRPOP4
 4yH6Qz1/vqAkxgwLAsFjgnkRbm4Yh1f4EI6949weoRQYukiNALxbv3XO51XwPJ5InDA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=T4vcu4FY; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=VMyFRiIx; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=vandhiadevan.karunamoorthy@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=T4vcu4FY; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=VMyFRiIx
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2AEDA406C4
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 06:59:53 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68H60kwA663559
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 06:59:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=NE7yaktnQEiWCqYoRQwe8d
 zxSHj+ajguQ0tu6Hb2jsc=; b=T4vcu4FYPZVzjSYU07jQKKsuFzOfdovr7v6hU+
 qtbUdYr+ZE90+KZDqc13VjB0m+ybM1N8IO8UigdJyBrvJxo4qgtXQnxARKdqTITU
 w/pJQP0uo3S0U52Io+Z6w3RxpZLM5y1msjDTVZjfYZ5KSZlZFeekmfO94UOKPpT+
 fs5S1MOAvb+Xg7QxOTtZ27Z1aZS91xWrHtbShuFp6eJ77Zylx+wuhcq8SZRaG7uB
 I42cHok1quszvZGS1szMYoRtnY9ZJ0bMq472GN4g2qNKEb+rIN+My7z6bwwkFe+N
 v0W4z7w+2a4NdNTVGExNHF2v2416GHbRWJ/4EaGm67RBRmfA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gqyga2rav-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 06:59:52 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cc11b5dd54dso1045279a12.3
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 23:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789628391; x=1790233191;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=NE7yaktnQEiWCqYoRQwe8dzxSHj+ajguQ0tu6Hb2jsc=;
 b=VMyFRiIxd4gYlCyof2g1gLbltFFZ04d3IvW7q+IgSz+M9nOitxMphDIzbY61lj42WE
 1pqF7aY85SOrA2zlD7yqJZNDNYHgVPP2zGags+ysznBIxN1RtGmgtTS/+R5WfzWVDoVE
 6JBSSO5PInP0XMsgjTXPWEXe8RH+vJKgwxXvR9LlBDVduGyeASpCvreT4vx++YEoPNj4
 Y858oIsQNqrvCO0utlRpK2oXIwS5zsNJF6cNnWsTucLJxckHsSNDMq+7qbUW3eWMVQQ0
 eKSVcn1KxA//U5kQLtPbJ2NKh4d+ZmLBDEcDHny1zK1uO2ITxdKeoysUZmGgM+/ofHFY
 4NkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789628391; x=1790233191;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=NE7yaktnQEiWCqYoRQwe8dzxSHj+ajguQ0tu6Hb2jsc=;
 b=NKPkgu62w/TI0AL0LatgKtzZ5RbMGnSOUWP9yN7BCpZ52oqeWhfLFpN6FGz3dtfyg1
 Nu/TwLPvBa/Hd6XtWdLnKTigUQjrlcA/UR1JRadG49WfoFy7yE+zJ+H+dYuocFVXr//p
 HNMcGo9Mv2waR0ysoLBf6XaURhWNkSVVjoWbFZJ8Mn1JTktpFwDm8KdlVSRiImeJDojq
 x4cBCzWEhdNTZwwUfb7lIHurhK4wjMDiw9qcaUq+wbeWcrX0Mr61c11D8fvsfdP2M3PT
 pd7E9YH5mPkuy1qWN5F60U+7LiCcBbYqESvj1H8xs5DBe29PkyysdgOm5NaVPhgUQW0U
 F0Rg==
X-Gm-Message-State: AFuF++k+gO4mQTz9mltRn8rYhfzLg6/Zo8iJ5I5KVFMYsNWhLCWdes+o
 ox7MQAMA0qYXlUTd9g10o+ayVqky7h5YmTGxHyCb12UPP4U4A8Mf5MZJg9NjidlRMr13zWsdGK8
 /TFbCPCNFi5LmgREJs4htgda5eaFsXmRsaiZXj9EaBPNwcFDwXdEsQVYy7lj9jPD3PduQlTY42d
 u2Z6I=
X-Gm-Gg: AYBFou2IwlbX2oaRaMIIhpldbKL+OlpuFL2qvGGW9SqNSmHlKxwfO9kL8TRzDuewHOg
 e2vzs06XnBtAAe2uSeVGPqEu/+eNrJYOo92OYp03FiZsrkVU+m+AWZJW0wiUAQo6+32Bjmkb+u3
 SdYeZFKJSCWQHljIvgCpI1v3qJCuC/n/2EIpkmcqDeyMbE2hpyyqvpeZpPqcoKHpyuRl4Hk+tHs
 CXn202NRiTqlgaqDVBsnNYA6AKzpnsdFIpFY6gzwNuT9cIB/4pDfbwag6izjRbWssu97F4dZ7FB
 vfHhzMtQY1gGzam2QH7fxENTuLo43qM7XyZm3T3tZtWfEfWDzZxvgu95OGdJ5YcZVbc99LthfAH
 L3wNTL0b9dM181J/X0iBHGfgUIP8+vzteMQRq/dSM8faRKdyFQzNVQCBlAcRuHDttsN5kEDlGtc
 S6Xl0Dq/rybbbaq1qi8oDKWq9ko9C/3RpiOdIlckA=
X-Received: by 2002:a05:6a21:4a8c:b0:3da:bea4:622c with SMTP id
 adf61e73a8af0-3dd5f7a9b8amr14366912637.19.1789628391566; 
 Wed, 16 Sep 2026 23:59:51 -0700 (PDT)
X-Received: by 2002:a05:6a21:4a8c:b0:3da:bea4:622c with SMTP id
 adf61e73a8af0-3dd5f7a9b8amr14366847637.19.1789628391043; 
 Wed, 16 Sep 2026 23:59:51 -0700 (PDT)
Received: from hu-vkarunam-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf5ac47cfsm11974416eec.17.2026.09.16.23.59.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 23:59:50 -0700 (PDT)
From: Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>
Subject: [PATCH 0/4] mtd: spi: Expose SPI-NOR as a GPT-capable MTD block device
Date: Thu, 17 Sep 2026 12:29:44 +0530
Message-Id: <20260917-series1-spinor-mtd-gpt-v1-0-d065abbc7454@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOCPq2oC/yXMQQqDMBCF4avIrB0wabDVq0gXGkc7BWPIpEWQ3
 N2oyw/e+3cQCkwCbbFDoD8Lry5DlQXYT+9mQh6zQVe6rl7a4L1XKJ7dGnCJI84+on3UjbFDo6b
 +CfnsA028XeHufVt+w5dsPGuQ0gHYHMALegAAAA==
X-Change-ID: 20260824-series1-spinor-mtd-gpt-c3694cb91fa7
To: u-boot@lists.u-boot-project.org,
 Takahiro Kuwano <takahiro.kuwano@infineon.com>
Cc: Tom Rini <trini@konsulko.com>, Vignesh R <vigneshr@ti.com>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Anurag Dutta <a-dutta@ti.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Udit Kumar <u-kumar1@ti.com>,
 Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789628386; l=3001;
 i=vandhiadevan.karunamoorthy@oss.qualcomm.com; s=20260817;
 h=from:subject:message-id; bh=pW6PfrTnH/1V610WfNQhORoGhXk9htJtWS4qIq9NL3o=;
 b=tY4RQX7Ciywg/em7c09zIcxOyPbWdKvqiLZvR/w3tAuchmO14xHz2/w4/HHYOIO0PN0+EvAvH
 87g6Jb5uCloDEJpiElPMUuvF+4nMoyx4J20E13D4Rx5htV14wZNIKb0
X-Developer-Key: i=vandhiadevan.karunamoorthy@oss.qualcomm.com; a=ed25519;
 pk=2EVV7DmKqYX4wxSlXPB5QBt44JjomLlz/wTW2AL4H6I=
X-Proofpoint-ORIG-GUID: 2EwqNnS_fFxraraQ5iy1ym_OZj7Yj3-C
X-Proofpoint-GUID: 2EwqNnS_fFxraraQ5iy1ym_OZj7Yj3-C
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDA5MyBTYWx0ZWRfXycVTAgn9X5Fo
 cIeCpP9SCuuQNKTfCaLV59ZKiUEIOZLsSUYyo26reOA1Sstr44SuSMO1WiFOsOvSQ2zujlQpEX5
 NFOKGfwVl9tBE4ldTD8Z1U60Sbvm4n8=
X-Authority-Analysis: v=2.4 cv=I9fw19gg c=1 sm=1 tr=0 ts=6aab8fe8 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=1VxDqnHFAAAA:8 a=bUQKSiCPAAAA:8 a=k-42gJp3AAAA:8 a=sozttTNsAAAA:8
 a=20KFwNOVAAAA:8 a=KKAkSRfTAAAA:8 a=iP-xVBlJAAAA:8 a=EUspDBNiAAAA:8
 a=xxJeFfIDsCm6jnx-WQYA:9 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
 a=aZ5uHUMKh6B-zo3GvD48:22 a=-fHZXUhsFbuwFN3fwQAr:22 a=uCSXFHLys93vLW5PjgO_:22
 a=cvBusfyB2V15izCimMoJ:22 a=lHLH-nfn2y1bM_0xSXwp:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDA5MyBTYWx0ZWRfX/bJt1JBIWg3X
 sF8Wk/pivE0xTY+bCczs5N5wusd8c54dXYKrDTVdE35IE8B/UVjo0B59mWxpoiAxUsbf6oYeuYH
 8nbzcDYFwXLBoTKKCgih7Dl7AX0QsEITGF+TlSKwRAfVwQTyh8dn93XYg8DBGhrk3mUBV/XhIy0
 EUBditLzrZrigM7vi/xVt7i1IpMY/x4Qwg5G94VhSumD1DpWTDEx657qCR2+HgN/srqBiOH/Q+E
 85GwCv6TVs7hmKHK1xDfGHqZddITuqFMwSqzyV/HG4cwLyLSn6xf6IbkhYC0htr7PwtGxvXI/Pt
 +Je81GLVS63hrhmO3kdoI+fVPLwNOo6HgvOnqF8NAaLkSO0CPWILzuLD4D7p/BfD42+RO9C5xdD
 QWoEM9pC981gFrdulqMn0p+0OCNHAgBtDlTvae6sPAbQ2ljpFM0YQkw/wdkqyq7JADzG8d8urB7
 iDPqUl+6ZZQn9TxpyFg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_01,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 clxscore=1011 bulkscore=0 phishscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609170093
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

This series lets SPI-NOR flash be exposed through the existing MTD
block (UCLASS_MTD) device, so it can be partitioned with a standard
GPT/MBR table and addressed like any other block device (e.g. by
fastboot, "part", or "gpt" commands), instead of requiring the
mtdparts= command-line partitioning scheme.

Patch 1 is a standalone bugfix: mtd_blk_probe() never set
bdesc->lba, so any MTD-backed block device reported zero blocks and
could not be scanned for a partition table. This affects all MTD
block devices, not just SPI-NOR.

Patch 2 wires sf_probe.c to bind the SPI-NOR device into the MTD
block subsystem via the existing mtd_bind() (no signature change),
using a fixed 4 KB logical block size (new CONFIG_MTD_BLOCK_SIZE
Kconfig value) instead of mtd_bind()'s 512-byte default, matching the
sector size GPT images are generated with.

Patch 3 fixes blk_get_devnum_by_uclass_idname() so a block device
whose declared uclass_id (UCLASS_MTD, set by mtd_bind()) differs
from its parent's uclass (UCLASS_SPI_FLASH) can still be looked up by
interface name -- required for the "mtd" interface to work at all
via the generic block lookup helpers.

Patch 4 is a standalone bugfix found while validating this series:
part_init() takes a fast path when a block device's part_type is
already cached (e.g. PART_TYPE_MTD from a prior probe), so a GPT
written via fastboot to a previously-probed SPI-NOR block device
kept reporting the stale MTD type instead of switching to EFI. Force
re-detection after writing a new GPT so the device is recognized
correctly on the next partition lookup.

No existing API signatures are changed and no new Kconfig-gated
behavior is introduced for devices that don't opt in.

---
To: u-boot@lists.u-boot-project.org
To: Takahiro Kuwano <takahiro.kuwano@infineon.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Vignesh R <vigneshr@ti.com>
Cc: Javier Martinez Canillas <javierm@redhat.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Anurag Dutta <a-dutta@ti.com>
Cc: Michael Trimarchi <michael@amarulasolutions.com>
Cc: Udit Kumar <u-kumar1@ti.com>
Signed-off-by: Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>

---
Vandhiadevan Karunamoorthy (4):
      mtd: mtdblock: fix lba not being set on MTD block devices
      mtd: spi: sf_probe: bind SPI-NOR into MTD block subsystem
      blk: uclass: dispatch UCLASS_MTD lookups by block descriptor
      disk: part_efi: force partition re-detection after GPT write

 disk/part_efi.c            |  2 ++
 drivers/block/blk-uclass.c |  3 +++
 drivers/mtd/Kconfig        |  9 +++++++++
 drivers/mtd/mtdblock.c     |  2 ++
 drivers/mtd/spi/sf_probe.c | 35 +++++++++++++++++++++++++++++++++++
 5 files changed, 51 insertions(+)
---
base-commit: a57e30ef46731309e7120d2900d294ac934f7609
change-id: 20260824-series1-spinor-mtd-gpt-c3694cb91fa7

Best regards,
--  
Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>

