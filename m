Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31E5606A31D
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 09:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=OFUPO7FL;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=okUZzmsk;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=eLrBAq9+
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9FB0140911;
	Fri, 23 Oct 2026 09:47:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Hfdapq4nF8z5; Fri, 23 Oct 2026 09:47:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org DE7D340761
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792748850;
	b=B8uq0kwF8/+D2OoR0x6oAeJ60ksc8ROwoEbU/9ZwoerM4jYQ2PCzlmOhgheuDsNAL9AU
	 M/1mgS3wJ2IlWv7XZ26U2bNiXosjdV0/ucUIpcn/4HTuqsPPWacGyFZhdqntdSoqLXq/7
	 Lip0HqEvhamdifFghcO6ht0H68WURVcgTW71LyjGXQrh9fIqW4+MDFYg8IZTVWb1Nc8H/
	 zMajKvfdrp6Dk0Y5uji8xgJt2X1DBENEfMTUKOHlvlMQlf9L0/O0sx0V9IDv916Ob9OYy
	 qKGCudMipAG7raLUISRTF1S0VeOynNnyukuux6m/EPo1fhSPO2G6cOQxxaVg1tz8i5Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792748850;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=QrFp5HS1eDys7EqePKJx7ZOyX9g7vI+36Ier2Ecbxvc=;
	b=R1Z7qVrnSXhk80iGXCY5LEXDVEZiLYVnwM1mk47svqt8Vw1jUuzecI1vp9UvtW/igwoX
	 K7DATacs6uSgiTfkdgDX1Dmj/Mv5evuoh77+buF1al9bFgO4Rmhy5ivp9CQ3SI4DWyyP4
	 44n7iCcN5Woq8ktlzcYo0GP8BmSaxxH1C2m6pO4tD05yX2m8B2AGDpdohZSU52+qWx0QT
	 xgJQx5MFY67uJ++YB+ySmIOtjtIcm1YU83YBr5io0Z9rolBOv99hq8qdWDbdkXppRcjh6
	 0PmpvZYrNAykB7duR4etDFLZh+cUTsiBZYFX17s9RwrpE5/pIo8buID8tCngd6isqiQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=okUZzmsk;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=eLrBAq9+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792748850;
	bh=QrFp5HS1eDys7EqePKJx7ZOyX9g7vI+36Ier2Ecbxvc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OFUPO7FLEQMxkYV0k2MTCo/A1OTkrZBGQpgTOMLTInnIpnpRtnHga8svzJdy4Mq2b
	 lt0AC9zV7lgbRDKNhW+nPm6ePeSOc7x2bLqII//A9m0nAUzJEV2irY2jB4wWsW9Sgp
	 8gZZWcHGQ9WYHA+Jsgw1VWYE27meK3TyGT3guEUTBtEdzAQHKh03q6QDkRCFGuhcz0
	 WoTSdLmnNh6LdkxuQyQCSuWJMWFPWIoU+PKpPyBzc816aNnT1knqcq+7EpZaFWSYHC
	 88aXvgkYpTNsk62xjMvlEXeDH1d+m4RhKZqZ+LgqbkUIXUHuxck0UPYUhgxXXrOazT
	 RYovNTaAsaoxw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id DE7D340761;
	Fri, 23 Oct 2026 09:47:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6E32612C
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 09:47:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6BDB740761
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 09:47:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ddr_N6uRN3tE for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 09:47:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8043840721
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792748847;
 b=UHd0kYTluCrZjd+ioTibDa8y4JAun+LG9zu98WAvauxAtfCkFtXuo27kkZ28JKVNLx99
 XdeSCy/GUHdJfpIj4piZVRooikNbh9rZ+IlpT1U4nMfmzfETiIubx3jiTw5CtxLagjYi6
 YjZ6QC7TcrcmGzbzdZPCRYVFGdoEADvtmqmLnQpS1EcuAt096+JkQi4TYA1BVXEbRF8/f
 oUqUqUEV+fYsTqCCCu3o9TrNn4VAoGmFFEfzEnu2GIgRfnw8NNTXKvPG9s5j4bCcbjHss
 N/q1lifcdJaq5OIF+5OPejWIZeGw43yYwCdKXpCfKGExej935y7PviTabiMHSePL3bg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792748847;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=QrFp5HS1eDys7EqePKJx7ZOyX9g7vI+36Ier2Ecbxvc=;
 b=kIpdBb9oD7Mj1YKjFvDwheUTH19Y6NogXMpiAvGdG4psLwPNsfKKONbNS7xxD3D8ZdeV
 loASv+q+gHCxcMRvX4G0OC0HTvfrYE7ZLvvzSMtnVR7hJ1Rn4lySQiAwidD026P2A4s1m
 hjuGK1PWyxG6PW46BL/8VI5mcr2t7Z10ypwH3zo+5VedEbhkhmXjUOmXPCdGLK2OtE+RX
 XGexkcBLMkFPhG7FeWUmryVB28b32EncRQRfvjl1JJA7aGx95wqTnJn/h3km+Wl1ffSiF
 xQijXCS4UwjJ+Dst2XtA0PZaIPtiKCx6cVfVc7XvEzwVW0zsLTi6NgCE8ZSiro0i51g==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=okUZzmsk; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=eLrBAq9+; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=vandhiadevan.karunamoorthy@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=okUZzmsk; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=eLrBAq9+
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8043840721
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 09:47:26 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69N7FTIl2650391
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 09:47:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 QrFp5HS1eDys7EqePKJx7ZOyX9g7vI+36Ier2Ecbxvc=; b=okUZzmskWrsShB1F
 VzYrgTI7NYZjWYyuiTeof7tg55e6cPpSdw9oyAHnO6M7seAn9AYiinltrGTuOY3T
 uaZyuUQy1KSUyYN/bWjHykqT5nFWgN2Fy2PWp++JJFZgshQfAd8cgQUROg8oeWQa
 E5pjia7VF7c2FbQmhjMDuJFKzqoYRvBP22p2A1V0U0QJX6ARFMecW8PRhunknxyk
 effEuFsTmCJ+NmgWsTni5zpFr976HjkVoS05BL17zpRNAnJb77IsX/2b6QoZqyaS
 6qi7sPmp231hV09d+S/4sRaN336TLS6rbB3Tbh14VbEMB9Vbj9P1FgAdrQfIsaPa
 7FkXtg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmjb3uq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 09:47:25 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-3552883bd19so2300552eec.1
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 02:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792748845; x=1793353645;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QrFp5HS1eDys7EqePKJx7ZOyX9g7vI+36Ier2Ecbxvc=;
 b=eLrBAq9+m7tDgnvH3t+2n1/luqz+zFpMZNW9mPoI1KKiB6sakLLsngC9VTFn0BB54K
 Ib2pqHUD/jTZBJ+BbRCumj1U5gqe8eKL7TXyqSA6ahtg4UzvBLuOK8klZQSGjMmQczE+
 bT2Bda+CELZrOWyQCoEtw/C/CEPS/mZMsCOujHDTHEfA8sJcqpmlf4STjhuCQTI6Q3jT
 vvmEp/oJn4oKn9Fb2qnn39Wt5QvZNawP/50jfsNHj4zK1Xxt3qAMjiHqd4uDZrlNn40c
 9Q4vwQfJ4h1OtlvM1CXXPAHJ1eBmAP4RX9CO5dwb1asOGEdAKnJJWeshKIcwYxSQl9H+
 7u4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792748845; x=1793353645;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QrFp5HS1eDys7EqePKJx7ZOyX9g7vI+36Ier2Ecbxvc=;
 b=vHyUTgmKULAAWg9zoW/xjUWK9Ie0gQDq6BQj3/AAxT9tz2Ou0CNRroBNgAvO6uePIA
 kdpi1p/yIaqNyv7IZ1z+w/rsJgkFbBWxQ9rJWjN/S9B4XcBwb179jGNOdaYOX6Gig1e5
 R5P8KXP4mtG+FxF56Nao97YhbCFoIq9MwNuMJSHgIbSdTwOXKGTVmcgX9zd7YONFeGy7
 NxTrxP6Gs8fa0qdCZc4AblQzZJ86mjYoTRfZ+G1PGwWnvkyaiOg9oxNXM8dA4NPo3Xs3
 O73GYckCCHOzsA6AGtI3hDWNAMbuLJDGHe/1qS94MFVQebhmBuBh/6xaqRS97r5eTkAY
 +PZw==
X-Gm-Message-State: AFq9FYJKHu931EwQ0zpNTB8NBf50YX7bzZUnW6ZTQNT4mcylChdGIPxj
 5RQCJIrm1g225IGNzPfZNwYQf1Sl9d6J4w3jtchxAtpGJ0Apz06GPfVNZztYnDZ6ymdxSAzK75H
 WOhcO3GTZYitZTOJP+xRpEQVcBwg4QkbJSTSClwWFmUEescST5bO184K27U2Z/Ai7yBjpwVY=
X-Gm-Gg: AYBFou1gR3AcBr76i7euz/ES8C0XkQ5qWj62uyMSCpQRrhOFA59qV+RTbnQJf8L55nU
 2D9dhEWl603S2BNt9CeP+jEE4LY6CuCsYcy7etcdThubEUn6Pq5lUsnNPNupAEUNzOCKCWmYpO6
 AgjTfl/b88FJwHFOTWlX1oiQl0DCkhPf8kCUYSJrwx4C0g6bRUL4uOg2+PpV3bv7RK6Xno+bNWH
 kvSHWafgCdA5GpTse0aitog/vIdi0PhiqCv8FCstRWmtiLb8xFG0BtJqIRyQ5+E7GzcOsrOg9SM
 oMUFIMeqNjyqgVywckKxXY0RTSFUxjuYqbibO80nc7g9dqeyK9JSiCuLoReU7xea2zFnq0vnkfM
 +keAUCrMDBsLV51I+zLJ8rhDfWY7OLKTBMoOmsM5JJdY2mQIURpyoN+9elodTo9x2DogowtFEXQ
 F6MZkZaT3zxjq/anx1e6C9gMgFYUaOgw0Z9FuSrKw=
X-Received: by 2002:a05:7300:fb15:b0:35d:4185:5395 with SMTP id
 5a478bee46e88-369d975b13cmr2294244eec.16.1792748844778; 
 Fri, 23 Oct 2026 02:47:24 -0700 (PDT)
X-Received: by 2002:a05:7300:fb15:b0:35d:4185:5395 with SMTP id
 5a478bee46e88-369d975b13cmr2294209eec.16.1792748844251; 
 Fri, 23 Oct 2026 02:47:24 -0700 (PDT)
Received: from hu-vkarunam-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-369d9d892b1sm6071291eec.10.2026.10.23.02.47.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 02:47:23 -0700 (PDT)
From: Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 15:17:15 +0530
Subject: [PATCH v2 1/4] mtd: mtdblock: fix lba not being set on MTD block
 devices
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261023-series1-spinor-mtd-gpt-v2-1-5d29d32c1289@oss.qualcomm.com>
References: <20261023-series1-spinor-mtd-gpt-v2-0-5d29d32c1289@oss.qualcomm.com>
In-Reply-To: <20261023-series1-spinor-mtd-gpt-v2-0-5d29d32c1289@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792748836; l=1017;
 i=vandhiadevan.karunamoorthy@oss.qualcomm.com; s=20260817;
 h=from:subject:message-id; bh=T9fsNkvfhDvatX4qk06Z9bMctC/6dFj1+gM8K3pGBik=;
 b=BcMXSk1Z5K74wOjCBscmHl5t3RLeyTLGAnxmWdq2bt5cndvMl9TJM1+rPk3PeNEkW3inKLbOk
 61Cc6n/xdZ4Cp5jGWa6Ux8OsNGhCGUbDAVp1+Lo9zaiBGTuSUZOpRlX
X-Developer-Key: i=vandhiadevan.karunamoorthy@oss.qualcomm.com; a=ed25519;
 pk=2EVV7DmKqYX4wxSlXPB5QBt44JjomLlz/wTW2AL4H6I=
X-Proofpoint-GUID: JLxeMadzn1XUZfItwv5EYHKf-8C2b986
X-Authority-Analysis: v=2.4 cv=cPR1IVeN c=1 sm=1 tr=0 ts=6adb2d2d cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=BSfsrHN3kqvq7MAp68UA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDAzOCBTYWx0ZWRfX/iC12Cdm74RS
 2RMierD0FL7xJwEiE+CCmclBnXhFNS0fW5hJDpUajwtMvmuue/ury+X13y/PlV7UrR1OKd3+YDn
 OmxRAY5W/jo+/pBHefaBoPgEGRgSFsY=
X-Proofpoint-ORIG-GUID: JLxeMadzn1XUZfItwv5EYHKf-8C2b986
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDAzOCBTYWx0ZWRfX42vxKYkso3MO
 UbHxCUTFFAYok+7lHOFpAfJa2Dn2WJand0YhqP1fHcPlwjn1fa7mO4GChfglV/3uAd3pOrOOKqy
 dl04JWc90h6yRl0iBiNCHqOkEvCR3b3M1Wgdg+nvVRkz5XcXH8tp2xNzBOKeDfJ6r33SI/6eQbN
 2F4UjAQembwpG6z10AenugWfTMoiClV130F9cMcAz/BqxVlkHrn+uYK9mi+pMYn9JGEqU5r1y3u
 Bx7FQIRVoAn3KBb8ENR9yp0JOgikv/fzmLhZdlMpbjqojDB39bXhk05uxD5Atte7g+ix2G5mdzq
 C/uWPS/vVVTjBToeuLKlHgzC1hKtAljy8gW1/gN7BeQXuuWhRUkzpi1CIj+e0QNgqFTtwS3gNXd
 R+ta6C9B4nqEXvKkeH9I6FyB6I8jcJA1z9wYSMGPn6nEMQqry4DLNnCVpfrl8KFEOuTTE2QeOOw
 M7GSwUX3GOL9fw4zF2A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 suspectscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230038
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

mtd_blk_probe() never initializes bdesc->lba, so every MTD block
device reports a block count of zero regardless of the underlying
MTD device's actual size. This makes MTD block devices unusable for
partition table (GPT/MBR) scanning, since partition code relies on
lba to know the device's extent.

Set lba from the MTD device's size and the block descriptor's
blksz, mirroring how other block drivers populate this field during
probe.

Signed-off-by: Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>
---
 drivers/mtd/mtdblock.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mtd/mtdblock.c b/drivers/mtd/mtdblock.c
index 66a79b8c56a..27ba0830460 100644
--- a/drivers/mtd/mtdblock.c
+++ b/drivers/mtd/mtdblock.c
@@ -211,6 +211,8 @@ static int mtd_blk_probe(struct udevice *dev)
 		pr_warn("MTD device '%s' is NAND, please use UBI devices instead\n",
 			mtd->name);
 
+	bdesc->lba = lldiv(mtd->size, bdesc->blksz);
+
 	return 0;
 }
 

-- 
2.34.1

