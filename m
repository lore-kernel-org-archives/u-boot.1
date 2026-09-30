Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 039ACCA5FB1
	for <u-boot@archiver.kernel.org>; Wed, 30 Sep 2026 08:34:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6615260862;
	Wed, 30 Sep 2026 08:34:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id A5IhtMw4akb2; Wed, 30 Sep 2026 08:34:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org A571760814
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790757245;
	b=PTtKHi8/5BG1i+ZZHSpzXB6LXgbl3pPWRo0H4bskDQGIYMZXGj2p8y1lUWn5I9j0drJC
	 0sPCogJqQQvhyWLezW7FsqQZTm8N28LFx5CrDYZfib/qwSv63/aCUlMNo1rR3NIC9ruJb
	 9E50yXidECvdh1wTFXvOJhoMvRBgiCH4icNdinDEHy7osT9cMeYf3UZh7Z+LZYAzcttrH
	 X1wokc4axUR5a1Zbtq7fHxb7tNcL3RU59YCFfNio4ipDvlz9zXxX1BkGK+/AuJQmNo+nY
	 MbHyzPZ3OxEALlweuu3YLuqdBeR4NPRrkEjwDmi/qIPDmTjh6KQggb2gnVS49fS2lWg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790757245;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=7pWGdhBgQKCZizM2Q8cOdhXboKZz6/YaeQ4e0BL5+GY=;
	b=N9dg70McZOMt+uTi2QJDscVktqYAY2/lfDi1tkj/KqjIyo98Em3IHUZ6PiPUY8B+/rfs
	 hDezGudZmiVhFh7A0HLHH6aiDqMn0PO+xGyP/t/UDA70WF3O9Ps2BNOyXoVlam74gsJcr
	 rooL72HzL5rzWV3EfCFOvQB2AmRgCoO3AvV3hVZ5vhOrs+B4bmxqCOrLSGVlterjJI78a
	 1+9hDTJADXZ4OXTslSJCZ1o9Go122xMIZrgZ021tgZt9zzE2jKku/6/EeSz3kEhieTTYt
	 zwywdHPzneQjnWFfzto/rGdcgS+KOZMb7c3dpHVd2plfQkSHigD+oGok/ZnEIeo6sLw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790757245;
	bh=7pWGdhBgQKCZizM2Q8cOdhXboKZz6/YaeQ4e0BL5+GY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=B+DKs4h3ERz6JPw5cQxt7nCS43cw5A9Y6RYfd0XTZoej7lytMSNrAq58uZ3/tbq9U
	 E6yElw6QXxNUXv7s1NtxzxLuP+3kkwjdudcGmMylNHDsYoDcrnQ5k7DcxcS7iq2dXh
	 OxWFPRCtBnqI4Wn2CVnZwbaHI3OEXhp4bhif0teV6+NANh4hu/BYP40sCA2dlTnGFL
	 Gu0n4fZIgSC3j7ak3KtsQhMjWHAaHVAZpceiDHRwHvO9yQD/O0hRSK4863xkxP/yQh
	 23YIar4kVg1s/zO3zg6hAy0xshHvZ1U8hv8dcJ6MvL7Aq2RNMLS62ot0WST6g1uBV+
	 K6pyoXGZwikxA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A571760814;
	Wed, 30 Sep 2026 08:34:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9C753282
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 08:34:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8E27E80ED4
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 08:34:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xm3Zz_2dBD7y for <u-boot@lists.u-boot-project.org>;
 Wed, 30 Sep 2026 08:34:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org C70A980DF8
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790757244;
 b=XQJ2T0AYzJYufbGBxSSGx7Ma4wjtA0Ar4kS4F7f6oOiU6CdRbpjR94hqreS734w8nEew
 kJEzkzImgc35RXe4tUQk0yYhWo8O6eFup/Th+q1xMNYUF4nAIzB17juVUo5HQffmUMwaZ
 VXnB+6tFDEOM6XKtfEy2atiw/HTo5spoUiIwagbJbbphVVDpv9hzR61R/19zjJL6W/rjW
 e3GLjwOj8TYyN5f3tu6raxtFmdi7iXDjvT5Cb1QRIzD9l+5KxYwvbOG7bMQdoItdpt5Wo
 ph5Zd8goslMEmJieUXMJqDlrIrg+eNJptJjFvxIzcZAY1IqjfhHisHBRPc4t/RuzuHA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790757244;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=7pWGdhBgQKCZizM2Q8cOdhXboKZz6/YaeQ4e0BL5+GY=;
 b=Gx33xXH37j/Kz9MPpPI013R/1ifppHoRgRkYBx+3JfFoZWqT1oyDV74fh1hXQVbJCuVq
 wA8W4Rqt+JfZAmYzjxdpEyzE4m9hYiLaY6iEo/39L64vp7OZSmv+QKthtq5RKhKSceMKd
 wDb1JqyOP0h1HhuJgvKtL3apCxrszypP+lEu71TY41+6NN8GJgtXABhPo2cppDWEQrsK5
 /7oM2djcZUFPRWRFRF/v8WPWCR8sfnTsaGZQ08XVuCffIReNL8d1hjnD94o3LDIa9RlDY
 4sUIQaovwK5U7tAKa5OspJkHv76ILyuq9xRBwx/jpJ/d1f0IeOm8e0DWZapxAEL2FVw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=ICSARjri; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=ODkl9GIq; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=sumit.dhami@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=ICSARjri; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=ODkl9GIq
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C70A980DF8
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 08:34:03 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68U7dWrf2819999
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 08:34:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=7pWGdhBgQKC
 ZizM2Q8cOdhXboKZz6/YaeQ4e0BL5+GY=; b=ICSARjrixMQx5PA62yYZ+Ailwby
 swm8/ECW4TyPwNyoaidmgiMCYMrMe2jJO5fFpvWHqPOdrVd4/KMa3ILnGBuVtEn4
 pRDQ0xq8JZJRX+5k16LMLeIySzIDwC5ZSwOSOm6TCOanMOme7Ig9e/npirqPjEZ0
 vur92jmclFoT+FSUHk5mJ/SQ+YjLnq++k7UNJWzogJkgMuscGZSCkISRQ2ZGZwRU
 N7k8SY6a8OvAtWNtk3i4g1ZkU/sgz31z+jT3h9uVkyg5cScPhUXZABvL1ZV+R2BK
 YnsuQthVux2tiEuzQ9GYESthJ9mP0zveQkEykwBnBg1szYKY8hrpnQ4fC9w==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0rj2sru6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 08:34:02 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-34344599f01so4379269eec.0
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 01:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790757241; x=1791362041;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7pWGdhBgQKCZizM2Q8cOdhXboKZz6/YaeQ4e0BL5+GY=;
 b=ODkl9GIqdtgzSoqjNngJQsX/+2a2d6Aud92HWR2CWNwIdVWxMLnnashLgTrPfKP8hL
 Z8ha4NYUB14LJSfC96zmSauxW98qhZ63a5bNF/k6X+BWA7g8LKiJiviaPC920Jbeu2rb
 jIxNAjsS6/5JsUrKkJIG6OyTNUxx04DF+uskkceoER22cIIHmkKp/z+9T17o13DESHIR
 +6xc8/TgMX+wDftoGM6JKm1PZA3+fLKw7TXuhLq1+QDDxH/gdE7xZMdA3CJGOcoBZX/u
 AbHSHbwH4Q2iMtmIacNuuImgRvTDLGjJ2lWmD3X0ukWWagiI/AY8Jb/3CP9rXyCm9Zc/
 E1XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790757241; x=1791362041;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=7pWGdhBgQKCZizM2Q8cOdhXboKZz6/YaeQ4e0BL5+GY=;
 b=BaMfqZ+ukK/iajJMOVD1cDV0p7uLFNeGx3sdWVZCFg/qE+sIRNGQoaMEwe6eAAvgk/
 JFNeUx/0QAjaH4D02QHPTFecGp3x7HfHYPZC7UAAxSo1EXelf4sRff7A8sn3Wx9Eog3x
 imoNZQurNQaQpsrIlmKMbOulQE/9CQ7VnBqNbRHxI3iQIBS19VJmKigV95faaMdsb5/K
 JNHZvXhElN4CQtS6q7/qprMGuQyWyKTkEeSXpHbVburyFyLhNGCMQbUr9faF8yJ0XQj+
 vRjGP/9qXaWRoyEK9vDWr/NnSUQ6Up3nbEyvTBSyyXN+LmlzrqB4wL/DczfRTRagiwbQ
 sbHg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxAEx0HPiX54D4iHjlDognP8awIDlPJNtDxqotNmhNdjOK1jYcLQNeqPVj0vsY8l8BA1nUooCk=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJHlIW1uTddEnBtiiHgvAWaPVRhBiAwNx9xw7GHvX6SZ49A16Hl
 cMlF6Wv2O+3s8eTn/dZQi3EMTybAgJXb297E1qhC/zZvo1T2AQKVdN/EURwZUqfkHBCTQvNixal
 NtoSi/MgUINnoRN0nbene7ku84hXPnAHaST0P1cqyZ+YcSIxeZb44wLSAe4ttu2HAmAh534E=
X-Gm-Gg: AYBFou2mhiIP1S8VLWF7PeYp7Hg/PtuTbl8VM54OGC/PWxr0o8KjKdFmvoLwqJU3ye0
 Kl81Yb/TR1joEKlKUsHVRlWN4nWfbp9pAEhED9rgVMUUNzOx5UkW4SRR44o0K45t2Mihi8z7kgz
 E1ELFBIEjgjyjLmD/+ZI86HsoYYQ8VOFbfzZRZs7h3Cg+dqk/6Q9H2aQkg9prMnf03AEWbsAm0h
 wZhdQRtM1AxGUCM1ImAMAAVGlcTuR4dVs3RgyxcG/0k9HKocdDzeJlkOkjiKMmzV75bwzS0VmLZ
 EdmKkZRcolDfiTvgUl440hwiL1FADFogXRxlx/BLqOEdnpI2NmNvUsL0llD+XHhT+hwKGj3nArE
 nSqrapRcd8cwjW+KVqFliUhX7m1NIPypjiuPFf2ajATKTJ/KNhGXh9HwcSfmWYl5kGDf+YrPWX/
 w3S3F+2MDToIXde3M=
X-Received: by 2002:a05:693c:2401:b0:346:d790:9e10 with SMTP id
 5a478bee46e88-34cdd68f73fmr848757eec.39.1790757241057; 
 Wed, 30 Sep 2026 01:34:01 -0700 (PDT)
X-Received: by 2002:a05:693c:2401:b0:346:d790:9e10 with SMTP id
 5a478bee46e88-34cdd68f73fmr848737eec.39.1790757240501; 
 Wed, 30 Sep 2026 01:34:00 -0700 (PDT)
Received: from hu-sdhami-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34cf5e423fasm2580119eec.26.2026.09.30.01.33.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 01:33:59 -0700 (PDT)
From: Sumit Singh Dhami <sumit.dhami@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org,
 Michael.Srba@seznam.cz, aswin.murugan@oss.qualcomm.com,
 balaji.selvanathan@oss.qualcomm.com, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Sumit Singh Dhami <sumit.dhami@oss.qualcomm.com>
Subject: [PATCH v1 2/2] mach-snapdragon: Kconfig: fix duplicate SYS_MALLOC_LEN
Date: Wed, 30 Sep 2026 14:03:39 +0530
Message-ID: <20260930083339.351584-3-sumit.dhami@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260930083339.351584-1-sumit.dhami@oss.qualcomm.com>
References: <20260930083339.351584-1-sumit.dhami@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 6GubYv4Q6oDswl0ET2LCXqb1D2LFkWoc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDAzMyBTYWx0ZWRfX9r5LDcBDiQZU
 wn8Y2l22z67+3ODPtJ8ZsIIkh2Dx/2CuGFtJIPOuA/aqFLX7tndEimVzfRbKNXUG9ZcuX9BeAjM
 ptC16+ji19JuAjADkCKxVTFYZVBxT0tnAsdQgHtTXrxlNdNjL0xyrWeUhrfdAMbbjravjjzZTFP
 GKtblIwLrnaJnSd2W32GE3QWPk9zg7yYfjl0rpcqvG44PgBPizIg3bzWhUwobovoS+cuwJAN8pt
 p7VyBj2YhZUoayso//KvQAMp0TFIOUKf2Q2Ol3vaNP5PsH5UdqRtpyv9Ms7TtL7c7mohl1jlU11
 fgD4QnxOGCkIzSF3dA+oE9EAo8PkDdtHsX7s3lLvKSIMGsHyhNq42VTzlKa05Nq2Lbjmnryu1XV
 e4HmJwOeDAoBj1yOAnnZXXpBxpcvnlUx/JbPCdi5mbMLumc/ix90iRSXJmAV0HuB5nElfzC3LwV
 x/3porr3FVSjjo6s4/A==
X-Proofpoint-GUID: 6GubYv4Q6oDswl0ET2LCXqb1D2LFkWoc
X-Authority-Analysis: v=2.4 cv=Ypya1IYX c=1 sm=1 tr=0 ts=6abcc97a cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=C3HNZMUa_JspV9skr5IA:9 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDAzMyBTYWx0ZWRfX8cuCs9KIq9l6
 eI0tM3uj3ZtboOQsBn3tN4WUIrV6ayf0LgFNd2W+0nUJpwmqGHmKcM9/xZjCM+KMbTv21PpQLfe
 dBAer6DWetf0ROfS1kXTK25L+vNZK9E=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 adultscore=0 impostorscore=0 spamscore=0 bulkscore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609300033
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

Remove the duplicate SYS_MALLOC_LEN config with default value
0x800000. Removing the SYS_MALLOC_LEN config with default value
0x10000000 create issue in transferring large images via fastboot.

Signed-off-by: Sumit Singh Dhami <sumit.dhami@oss.qualcomm.com>
---
 arch/arm/mach-snapdragon/Kconfig | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/Kconfig
index 45665eed2c8..fe53b0085ad 100644
--- a/arch/arm/mach-snapdragon/Kconfig
+++ b/arch/arm/mach-snapdragon/Kconfig
@@ -23,9 +23,6 @@ config SPL_SYS_MALLOC_F
 config SPL_SYS_MALLOC_F_LEN
 	default 0x2000
 
-config SYS_MALLOC_LEN
-	default 0x800000
-
 config LNX_KRNL_IMG_TEXT_OFFSET_BASE
 	default 0x80000000
 
-- 
2.55.0

