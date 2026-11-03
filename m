Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8329D606A327
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 13:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=cQy1Eft+;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Gt//GHR4;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Csb5h6c6
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 607486084E;
	Tue,  3 Nov 2026 13:44:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dZN0gzpiM0G1; Tue,  3 Nov 2026 13:44:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8DF5560834
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793713481;
	b=pfg2b6sif5+Lf5kqntkKW4j8qQgLKC/1br8W3N7pvrw0JilrAzqQ3a8iFTCz5IYf9+Dz
	 Mi5IM2+Q2djUdI3EM+d7BK3euPG3eqYmDBa4y9Tnm2VklWEYMfbq7coI9YprNWFJ1AqVR
	 oWM3h0StZyrn9k6mRVUMZfKkxKbO+kcQNXXUK8oCuZZDwR/DinQGSHguM5cB0Hr+bJWVs
	 jpl1npblTjkWAUSNkLGq1mVzbWc+sIh4rAHlK3n0OZ5++Ni0TKlFSheTzA5PAIeqIM2+6
	 a8BHpfoxDZOCO0jqc2nZOr6XL+65onuT2/KECibYJ4kEa4NEnKnCnGrHARMnGRSuN/A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793713481;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=bYRQxre5Cy0l3nj6KFSMbIXdezFNPHLn9OHEhtrLhuA=;
	b=ZiqBKR+ttR42o1dkVDTc5EcxD/qzlftU1LLsHOHjrBVc3nSe881vFpQ0ZKM/o/0/pTmm
	 l6mBiAoRKSEtw8nB5MGursl5lmGEjmVDK7ROdCfJwGs4mEuKjfLpni18YYNdjsY5ptQRD
	 IXC7cysgG1Om26QX7IX/CDkL/nW674wc9ZSm4RpweK5pKK1F7sUAjUzY7/bZjwrCEUzUx
	 PwugN+2/Y6hPxYUBAZ5pB3Kxlg5maSSP75cNBKbQGXnxVQkrT2NsJxGBj23ipzCH2U0SE
	 7epoWZumYzwO3brOM+1ggTaNJqvYeoTcg9weSI+j5EpkqUxziXcmkTrKt9RWxyeCm+A==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793713481;
	bh=bYRQxre5Cy0l3nj6KFSMbIXdezFNPHLn9OHEhtrLhuA=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cQy1Eft+vy0psC1X9upFfkGf+/Cm+Wc1urEJLYAXd2pvCJOugjyFiKTe0cFQYioCj
	 J96/y30x8ulDdyPVdT4gYQLvGO6BE1YBVXfSuINREe9rUj2uHdmmH69724bOUyBSRt
	 0jAqnge7xDEUczpOssf0E33Y72NdUj14kImg6mKd751h2euZQ1YFaTRMRZAYELRz3E
	 xpUaT6w/u4q3iZSKCawzNhBIZQH1pVGWr/FDgm14bCpnpq9x+T8sY6+j5g5cKP42+K
	 l9p3bHKHCndrdu9Yw9fsAM+xdRiazMpKKHjnadVZ11It+p2tAeIPWzO/+9sfxpLzbV
	 SDPphKXhvYFPw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8DF5560834;
	Tue,  3 Nov 2026 13:44:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2511A4BC
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 13:44:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0B3B680AED
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 13:44:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id b3SP-ME_Gk8w for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 13:44:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org BA0B281119
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793713478;
 b=AlLJqbtuFnJOL+saq4KbAzeLsxnInrvoLZNz3qI2G1Obn7O2W6c1jdb0C3R6d2PgVSLu
 lNCypEN/kK1cTADLzHe4Hn58ay3mgtLLI75Rrm9L/h3m/Pily4nsCrK1IJCHbmqtskI6R
 iEcCYhp4ZmGbL4uMgxaWZhLhG0GZRGMnvzfgb7fl5NGI2/oJXSv1IKlNGzDOSgNRgSLO9
 hj9Q5XB921mzAQbZA01/2UZviLY8WL/y8VRVK1KOF3RLbmDoP9OF0ujFgR4NjnJuGJfMn
 KfhZzynucFUojrys4ZuEZqKKwuAAvbHWDY+8ux53Zn1pRg3L79c6lMPCrtOH+t8D4nw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793713478;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-Spam-Info:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=bYRQxre5Cy0l3nj6KFSMbIXdezFNPHLn9OHEhtrLhuA=;
 b=GFtDWWSpexGAPVrB7dUST/0cRD0eB75JKv5XksYlVzznSMmVL6dsPJstQ5p9eU+hsy/N
 1zo7m9pZVGcqLTyeMCtxSkyRvUUgZa+5IXoSbYlD9EQCJ/+l0Na4cDMfySoTm0gXBONVR
 6SSPXNIVP7Cz+BqgXRNELqbe945QUC91OGXq4tsg6DeJLMEAgo/pqgieGeaerVli34fVG
 UX4/QXr5nVATZEHNVOF/t2VKwpJ+UbcEfYInY/OMMMjmputs2Iiuk5k9c5rVeypQvBNto
 mkBsDnE3cAexbqLWZwfzcgMeJz9EmiESF91OcXfomNzT3WqKkORZLcv5U1neWQ4Zcfg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b="Gt//GHR4"; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Csb5h6c6; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=Gt//GHR4; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Csb5h6c6
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BA0B281119
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 13:44:38 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A3DZJ0W4027591
 for <u-boot@lists.u-boot-project.org>; Tue, 3 Nov 2026 13:44:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=bYRQxre5Cy0
 l3nj6KFSMbIXdezFNPHLn9OHEhtrLhuA=; b=Gt//GHR4OrbzL+uIB2j7taZsAPv
 XULRI/YiET3GZSwRHOqPVLp8Pv/XiRmfi8Yzv0kLDY5wrFKnRITCQzW916LItTbJ
 LcRAIoBt57scqmFc8YgEcZZHgOJHDC5zNltcMSNjse7Aj/2cEdeIUu49Yyg/4D4S
 BBd307mTQhCtaYt7ZvSs+kQgoKBSXvMr2Jc6nuG0gCC+e2mUp+x6D9f0wG62pdvk
 lkuVnUsokb758pUxMD4XFNicbEEzlAdfStyj/WDP43QqlCnw+qeXeCbqebEmAq8E
 iaRzZZojSsR22pNyEt3Zw6rZyxl5l3BYu8I37iHKWvPZiKm38SBw0jC9z5A==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hq76dachr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 13:44:37 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-1b0d864826cso7506324c88.1
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 05:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793713477; x=1794318277;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=bYRQxre5Cy0l3nj6KFSMbIXdezFNPHLn9OHEhtrLhuA=;
 b=Csb5h6c6sFA1o7wvggIB4RuXprQDwwmJ+8T5aqlUgQGBZlVhxM4GBg6Uett+BWCbcn
 A4+ukYBp7tJ1zsRZnMMjCZgiD0VUGtIrav+QFktON/aXjARU1neyfOYkr6NsVHMhuZ0B
 d99d4/P+zY3d9jMDw4jPmztgBQFf2jX3QGwrG/gmNEkKE3XzEmVSFhAy7xbTQb7WSStp
 tBP56cQBbeBkoyWhgyMxrg9YFwhMrZXSXQxgNjKG2o3mgiE4rQMNYtQD1P3BhSkwBp6z
 tM2N80YHmczZ4XNQw/snNvHqxEKX6qUnitLf/wom08u3Ld5s/BSPGLuk56IljdzUjhty
 7DWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793713477; x=1794318277;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=bYRQxre5Cy0l3nj6KFSMbIXdezFNPHLn9OHEhtrLhuA=;
 b=GNhJujwftG1THYXF5ggr2T0R1Kq10gYdSqeZGe1pT6REEfvNY3AslRXcZKq/YHVTwW
 ikcp6XYZ2z0lkyYOb/t8sX6llmVWHyFLo1oUqdKNsoox+I926jhWJ+jgUX0x1c2isqfd
 OSV//EBABrjjX793uojelVm/3DtVRyhHnhxGl6UZZAeGiiJlX/GPCjt/dW6pSUnlpCdt
 1zYQsYl89Yt6MNiTQ7c91IuSE3/sqKOeSg+5QQzh5bpqLt8daw6gW8sLNI5s5yXBfYtH
 THEffPDIjAIkpJ3j/A9+Qgoee5e98B8lwAr0LLKyF0of6BwQECJZrwYDV9YDUAOS9jwa
 Eg9A==
X-Forwarded-Encrypted: i=1;
 AKwUvBxNVEKpDUHN7qFp96XNWVA3caiCDKWTFIPtZ+9NoGcxOTXQCovAyvI/IxKVeYmTRpYKZR5QqWA=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+O4S2kEErXuE1jWFfKthk8ynYSY5aUUUjDs0S+hSy4zA3xlyaV
 908aMILRo/3BzXbCSLJeuO9AvIVkmhsNxiLSldVsw5iv2PB2P1kYwgK4x/BmsQuzmRDMS98D9kc
 de+R9dtEbgzvbw//dD3TEUpe2W7A2N917SFlfNquIOv+vETgvtG0lrfmFO+JUgxs4wgPm0MY=
X-Gm-Gg: AYBFou1Bd6YL8CQpH/BWjATucKWORJCncwSKzJ1b8Bxb1w0aJotEhZol0st2Hs1nhEJ
 i76XE2Dd3rkxq2bO690gTmd+7Q2sEQEtw3vOoZLE0I2QPxcrm8Ppwhc9JdV2/9eRQN6qaAx0Yxb
 hEdiw74PDg24+N8aMWve3Gn2c7Qr4niPhIRS1OK6JuF1cF/Yeu2imRyLrEHyqjm2Z7jZqVW4EXJ
 JT7E/LWZ57Xwaycu9l/YQiAPXoo3OYHuK9q+4VKc0uBVm2xQ1JOdl6n76QMr53JKElVBpgwQSXa
 gh5NiYsaquMEhmxWAav3lmxFhJDKTxuLeDgkY6coQO9NZSoem91PWjG99r8rN4QYCZ2nGnE7dNL
 mi+V36Mb9kbfrM7QeTBHKqPyKU2dbSaxr2FX9p+TqPAn3bKTkt+8hlQln3XN+6J377t7aYVOITy
 jvZlZxOjr+LQWA5GboTwr6PqlKP6uxtWDHZWCndO0r1EAF1kXzs4WIicOPLFrKIjx6f3M7
X-Received: by 2002:a05:7022:ea4b:b0:1a7:979f:ecc0 with SMTP id
 a92af1059eb24-1ac5b7e1074mr19142152c88.27.1793713477039; 
 Tue, 03 Nov 2026 05:44:37 -0800 (PST)
X-Received: by 2002:a05:7022:ea4b:b0:1a7:979f:ecc0 with SMTP id
 a92af1059eb24-1ac5b7e1074mr19142118c88.27.1793713476476; 
 Tue, 03 Nov 2026 05:44:36 -0800 (PST)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b23f20d36csm7511194c88.11.2026.11.03.05.44.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 05:44:36 -0800 (PST)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com,
 aswin.murugan@oss.qualcomm.com, lukma@nabladev.com,
 marek.vasut+usb@mailbox.org, balaji.selvanathan@oss.qualcomm.com,
 Michael.Srba@seznam.cz, william.bright@imd-tec.com,
 nikroks@mainlining.org, anshuld@ti.com, jbx6244@gmail.com,
 dlechner@baylibre.com, nathbappai@gmail.com, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v5 6/9] tools: qcom: mkmbn: add Shikra board mappings
Date: Tue,  3 Nov 2026 19:13:48 +0530
Message-Id: <20261103134351.3532864-7-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261103134351.3532864-1-aswin.murugan@oss.qualcomm.com>
References: <20261103134351.3532864-1-aswin.murugan@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=KJTPn1Fo c=1 sm=1 tr=0 ts=6ae9e545 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=1LA7DHwFGBrveulqWMoA:9 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA1NCBTYWx0ZWRfX74qgJtvKgVrS
 53K7aKuq7Ztujp+atMvFFGplx+vO4Cs4XjgFsoz/5TvOlDKJ4Avs2kYhpv8AurnsQijp6zDQdm6
 Uyp4ko5l6WpmQsWqHuPVu034AS18WXI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA1NCBTYWx0ZWRfX3JONWOqSq4bg
 jTluN/z0osVwkMVg9yJ/NfTNwORBwaqnxRTN0CUdugr6SKDdFK+qjVnwB0Z+rBdMCAKoHxGX1AT
 8PMZ3dLLYyYpP/yjTkA9xfKVcD4Gqzhqzv+YfZJYu1D2gr8IjSAPRN9j2ff209lv7wEepyCjQmm
 8Osvw+t8elixnoOUMm7euMRKrjMDwoP8q+W7cmNMPVDy/qpsUbkXELkizXfHOmQ1uCztvff98PJ
 w1yYbQSSuldCzcxryg/YNJiyFi3W7QTflcjpaG5Ou8g5ur8r2jwsKlUouvzu+wonoT7XU6CEhuI
 rYKEiDzKIBcKZD+/w9FVxG+rPPIF88xibJWWDCB0a+uZPp10rZZxmiP9LrnbcNzOn0rpU703HCt
 UwL/hyxDCS7CSUQ1Enm8NcDvNiq9LYkaC5Uf7v7WPdjMf3CLmIfjwiOr6MHuP6b5z+6XyhNSrXx
 MygxIpsCVQniZVKCsVw==
X-Proofpoint-GUID: ZrqGCf0tyJtHLpucjj8SMhwYhBGU-oVg
X-Proofpoint-ORIG-GUID: ZrqGCf0tyJtHLpucjj8SMhwYhBGU-oVg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_02,2026-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611030054
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

Add mkmbn entries for the Shikra platform using both the board-specific
compatible string ("qcom,shikra-iqs-evk") and the generic platform
compatible string ("qcom,shikra").

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 tools/qcom/mkmbn/mkmbn.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/qcom/mkmbn/mkmbn.py b/tools/qcom/mkmbn/mkmbn.py
index e4484b539b0..704011ed27a 100755
--- a/tools/qcom/mkmbn/mkmbn.py
+++ b/tools/qcom/mkmbn/mkmbn.py
@@ -76,6 +76,7 @@ boards: dict[bytes, MbnData] = {
     b"qcom,qcs9100-ride-r3\0": MbnData(0xAF000000, 6, SwId.uefi),  # Dragonwing IQ9
     b"qcom,qcs8300-ride\0": MbnData(0xAF000000, 6, SwId.uefi),  # Dragonwing IQ8
     b"qcom,qcs615-ride\0": MbnData(0x9FC00000, 6, SwId.uefi),  # Dragonwing IQ6
+    b"qcom,shikra-iqs-evk\0": MbnData(0x9F400000, 6, SwId.uefi),  # Dragonwing IQ2
     # Fallback/generic matches since most boards for a platform will
     # use the same load address
     b"qcom,qcm6490\0": MbnData(0x9FC00000, 6, SwId.uefi),  # rb3gen2, rubikpi3
@@ -87,6 +88,7 @@ boards: dict[bytes, MbnData] = {
     b"qcom,qcs615\0": MbnData(0x9FC00000, 6, SwId.uefi),  # Dragonwing IQ6
     b"qcom,ipq5424\0": MbnData(0x8a380000, 6, SwId.aboot),
     b"qcom,ipq9574\0": MbnData(0x4A240000, 6, SwId.aboot),
+    b"qcom,shikra\0": MbnData(0x9F400000, 6, SwId.uefi),  # Dragonwing IQ2
 
     # msm8916/apq8016 has an "aboot" partition but the process is the same
     # They use header version 3.
-- 
2.34.1

