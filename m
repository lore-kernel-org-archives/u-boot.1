Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9FF606A319
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 07:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=k4xlT3ut;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=pqadu2XO;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kdDntRnu
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E560F81090;
	Wed, 21 Oct 2026 07:02:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aanIJVmr6e_W; Wed, 21 Oct 2026 07:02:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D989C80E01
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792566129;
	b=R/BMYiJVAJy9zziXUH4qoCZHbsbbnDKSURKIaYXs8bSa50H1CyjPBHK53nnRhRAjvl0U
	 ZY9rLax95Ujoum+K2P1jjsg47ajPm2rbi7J8RT9DT0bjG2zxl1Bc9+mtURgXFslxj3T0d
	 IYY//keLwWP3leCesCSCayDn1KqPKyRVlMUTTAeUVVcR53VaS2LUs9+9sRbBORmwU5Mpi
	 y0WxShg5vKUvxZTEGa2j/r0Cbhyt/kYQLjArQf6eSThRRiiO+Vwa53HX4mFXNhvbR7fFX
	 oZmT4rWYtLOWwROPxnRwew62iisWZxVnliVZquWmycaQoi43imc4bPrEB09QzE6TIPA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792566129;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=qQ+vqIX8XvLW8Z9KqmWta1bI55TFayz2M3I/ZqY85cA=;
	b=WBst+HYFQgJcK0K1tPVRUp+l9QIdmaTIYmzCl7BS7cL6m4WBNc+amYrzOYjocA0t/jI/
	 aFGfezLhvd26gLGKZjDT8NDxelhgbHLUK2L7uVgGJdkTjBL/lSVGOr7rbnXta7z+mciHs
	 d5SmaL7sVJT+BW3j2Iwi9/0y9tYRr9p/KHpLHm+c3/DD4KcDb8DTgLYS579ZAshdwvXVs
	 jXMtL2sU1+uiRbiI7i5oQrGF/EjoC4eXAqa81oP0GjW6yyhfeAthUrzhFZAzpUAkpjGWZ
	 5xYaNK9aoI5X4lp62hwkLDp4O1sLdxtQP3+EXA116hXjxlCTAbFdn4Ytlwrs1+Werzw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792566129;
	bh=qQ+vqIX8XvLW8Z9KqmWta1bI55TFayz2M3I/ZqY85cA=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=k4xlT3utD3uRCID0hBrwdA97vwL08tnMTOMhbh81FujXoA4anEeDyLlMhCUsawMxH
	 kAExig9EFV4kORrsslapZqij5liDWGrX2Wn56bshE7lTk6J/OQwnRMWnWzuR2ex8E+
	 Q/B11o3AZ7efb1GDQe7h+WvZ9G/V88UGI/msynBQkU+lgUa+GZgESGmJbspbFZXDZf
	 j4YnZTIJ6Ri+Hzj/eLDRQyw4cKQHWgR6dZ4hKyYSK8RxbP5w2lFdPJ/6Fsi8q7Dkl9
	 XIVU9EpOf7BEdY/BE6CHL7zFRRXpl3FfWifCIkBazFPH4pML/PLMbYS13t6PWJPotX
	 EP8MXE3lJqr6w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D989C80E01;
	Wed, 21 Oct 2026 07:02:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id D4EA7995
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 07:02:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B9EEB40077
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 07:02:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id D1YyzAtfd96H for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 07:02:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org C491240060
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792566125;
 b=TXI0jtnksWWcsrt4+ylYhyjl3P9VVLpPL8UYkhPIK5m5d/2fgANi69KCxgywuQv8cqlq
 K1BtogDlwAms/LdzXjqxaodLjfAHdR6H4oAFwx9SzjZ1x1CnifypAW1vmdvrfFaJhEcE/
 m0vOuIvAKNjQJz910Q2cdgdRMQjUGSfAlTLl2pvXXFYRLVmwZ2lN5sg8ckGQ8OPBlVcvz
 tjZPRmhLnLOAVwVJ1vqC1DE0lPpyqSg+8kslpgXPqdCtMcE/3i9CkwI7HRh8l0m2cR/vk
 QEnlQ2/reHEk4j4hFAv/m74HL/8S3RF5nOXOxihvXicI/O+9t4CM3ogoMRGRg4YfacQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792566125;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=qQ+vqIX8XvLW8Z9KqmWta1bI55TFayz2M3I/ZqY85cA=;
 b=GgKGbK1fSBqPVRtqpltzvzdme+afH8pwiGVWbGDGphSiyNqYEHkHFf013Vt7hSiaoUc8
 H3K3QqoolBrbPldW5zOYX/zLtNuTD9jl8kOIgaVLCxFIfx7GGDNyFjQehiP4CehTMwcjh
 +U66rIcpAY7jw2Y6PNyubpHLoGY04jEjB12CzFU2XnBd962gCUaZ4/kQI7hpTXUEIUhDz
 I8WPgywY9/H+QxSD6Y5JqIRe/s/uzE5bRtcMoo9RmkcwFZ3EIvA/uJOwcSFUCz/E5Gn6S
 Dxw01oRfn83ZcWVPMJXp3F1gmc65H7VY2qJIUZDkrrNeMv2Rgfy2NH4VusJIsk4MTww==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=pqadu2XO; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=kdDntRnu; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=pqadu2XO; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=kdDntRnu
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C491240060
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 07:02:05 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69L5jLag3929522
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 07:02:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=qQ+vqIX8XvLW8Z9KqmWta1
 bI55TFayz2M3I/ZqY85cA=; b=pqadu2XOqdID8CZiTMEh8QGZSblqXBkKzDnDTj
 bXvz9PN22MLNPRqunJHT0VpaTP0UDdEZ6kHCPfz8FSktR8NMgTrDvWVJLKqVq+tR
 3vLMeHMspHFj15jwFHIGqzbtQia5oHJmFeXX5AfPc6O8Tog1VqcubEnUCrgk9PV1
 17gQPv+u44uCfEHatXbWRRBRshPTVsJvkJni5j/wgfedm7G001kIyQ1j/v7g4GW2
 OM3PTmPxO61WDJ3OrskgX55WVj8Wp3KJa25x9k68v1sbS1JRP9ceV4Tb+9H6kdSo
 EFQ5VeTX5k+KcbRaKfP071+GPCi0MbCekuDYcBFoKON/AXgA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4he7h2c1cb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 07:02:04 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-35cbea41088so755986eec.1
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 00:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792566124; x=1793170924;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=qQ+vqIX8XvLW8Z9KqmWta1bI55TFayz2M3I/ZqY85cA=;
 b=kdDntRnur3jfIZVWp61o8HX2BAHO/kFrNWUsODK2V8plAY+snaiwYaNy6KOI793o5G
 SLc6uwlQvoTihmHsQy6j0+0WLk8ObClxDng5kgZ1n/yNNH/Vq2rZz3Dtb10JP0JIzP6K
 wvc3SE8+TMEJsXfKtHef8xiMraRaF/2+O+TGhKajpvwQW5oOjj3CId6gV3KgPfi3+70g
 gT7V3cDAjDLFXE0oDA2x/0Bn7nMb2Wqx/njYd+1vGcZ9skcug3JicOy/7jEbVZyztz69
 i7Ei9lX57AkqKBT2lxynQ1GfV0aI67gSF8IzOtW88AQ1unP7c6iHHzXuXb6EhDnAhwmL
 uOyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792566124; x=1793170924;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=qQ+vqIX8XvLW8Z9KqmWta1bI55TFayz2M3I/ZqY85cA=;
 b=PRImo6Gc1ALFx/XU/h3kRmaOghMkDvc6FeIpilNgrPDoNbDoerA+wEhIyjkUW2sOeL
 8yIdjdKMzrxsMwTyUlqE2iF3zCBGcRaGex+5FdfRvRY78QwBo3t4m3CxbSp7ZH5kv5RV
 Rs3in5/8K53Xwxthpe8odId2Ov6irdnTB5Utlh1oit+cGP3HhLpPHJ2bvcCmF0UrHUNF
 PD4EENHTpYupChL4g/Jg9lUEd0YPvMIag+l3RZyj5tnbTJqYhm9vg5vX1xaPthuI/7Ik
 d059kc0EX5u35YgKyFRyWVuQQwTwXL+le/Dp28J5SZTIDcsYFJsY+PikUwu0IEIL0p3q
 k9dw==
X-Gm-Message-State: AFq9FYJXK/mjmKDbaGjky8VRlRYyxHgl/u1scuBSTcD+QoPB+RG5quss
 oaDn2k8IZ6fb2C3TN3jKeCCbgeaVwUBc5RcShQCl5BiJskQ+wtV09Wp9jGD4oAVjZ4oG6ESQ9g2
 GMHt/pYY/z6KHrqiRi3i1Bc0hIn6FFN35hVB6VVRA6gztmXDxHqoBbHqkHNdXt9vkp0MqFJ8=
X-Gm-Gg: AYBFou00ZLHjTL4qOwZjiqnVopUeS29FxEKG6R10a4zOXvEpRFsldrbp/auGeoXh8Vq
 D2lcVIPhFIDINWPvK6Zt5175JbXrbscymkAZXj9o3ZEvSaAWdv6jh6xM/Uvbh8GT1ESdhx9B8UV
 EP6uriZkIzcBOHqm1J8KtyR/xoosHPhinkN3IY44lnmNh8SOhDiwxM0C1y8tnKeMxxjSN+TjO+Z
 ecIeOnwRX3estPEFl4GM9Z8UbnGsg5Kpmw3/nUiJSSjzq2N1cfJkutbew9NmVJWyoosqJOUX0gC
 1viFB4J0olOiH5TB3Eh8GKEXWR8LbMlxE6LTpoTbGPp0xCOOYLr1h/5x2C4pUIZRlO5mTGiOzt0
 bKIVW3Jp3M2kZahTU1QSZ7pROTqIrr3N0a95XwdfM0TIcpS7p8mprGh6j52jqJvVcHXRMnYqm0m
 duvc41jNiQ1uyQETizV8dDZGFhxHJY
X-Received: by 2002:a05:693c:8954:10b0:33c:16f1:2e11 with SMTP id
 5a478bee46e88-3674c63d95dmr2175511eec.7.1792566124049; 
 Wed, 21 Oct 2026 00:02:04 -0700 (PDT)
X-Received: by 2002:a05:693c:8954:10b0:33c:16f1:2e11 with SMTP id
 5a478bee46e88-3674c63d95dmr2175480eec.7.1792566123413; 
 Wed, 21 Oct 2026 00:02:03 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3673b1d0ab7sm4814197eec.0.2026.10.21.00.02.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 00:02:03 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Wed, 21 Oct 2026 12:31:57 +0530
Subject: [PATCH] dts: monaco-evk-u-boot: keep vreg_l8a always-on
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261021-rpmh-regulator-refcount-v1-1-c9cbcc71d6a8@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAGRj2GoC/x2MQQqAMAwEvyI5W2irWPAr4kFrtAFtJVURxL8bv
 M0w7D6QkQkztMUDjBdlSlHElAX4MMQFFU3iYLVtjLZG8b4Fxbic63AkFpp9OuOh0Ew16tFXziH
 IepdC9//c9e/7AXq7vE1pAAAA
X-Change-ID: 20261021-rpmh-regulator-refcount-e1d4e0bc377e
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792566121; l=1746;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=nOo17NXahhtmrPWRi2g0/D83iT4v0pUwLSrFPxMQxWc=;
 b=Qc22s8DyMw7ALaGLhPJWh9rDlVTR/+1Zx/xMP0xX0PN7FTo07mQ1zWVtM+FzDUltqUbFpba7P
 mgyVuXKpSrMDX2NEDQggypjU2zVI++1C9Fkoi3oOvM78LXiEOc23H2t
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-GUID: awDU0OkN3l7KuO59GY-7luJ1xXl6fp__
X-Proofpoint-ORIG-GUID: awDU0OkN3l7KuO59GY-7luJ1xXl6fp__
X-Authority-Analysis: v=2.4 cv=EuJHPicA c=1 sm=1 tr=0 ts=6ad8636c cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=1VxDqnHFAAAA:8 a=k-42gJp3AAAA:8
 a=KKAkSRfTAAAA:8 a=RA6_yvRmrimG5oJFIL4A:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22 a=aZ5uHUMKh6B-zo3GvD48:22 a=uCSXFHLys93vLW5PjgO_:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAyNyBTYWx0ZWRfX7dsJFrVtNWQ9
 CBkbVKPV+PEJCej7LRJ1kiiK5RvCaEk1Fgps+0munloL5Q/N780cX8RjmWaNydUJMdOK88OX4Qk
 XtNwBLaYYKYfCw16ANGhnR1BHeTWjXw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAyNyBTYWx0ZWRfX12h2EK/Lq+e/
 Wb2vTwowagwpjwsLIdEKBl18LnpPtBWOIJnsav/MdYS7A0LdeUH1TL7+Xgu0zRIgQPr/46lgFQb
 qyK0nAwj3UTt/VK/d39R/XyJ06lnNz4BmYGyCuEgiu1J4QTRSuXOWypm4b3hZVW9hw2B7Q3LmXt
 fzziXCTVSYPFb4BrguqtiGpKMRFolfOy+vY98qAeMt3oKqquBfyd3liUvuAz0DQg+0CIIsN1MJF
 5I0GReIjzq0GQaBSTwxrsvcmRMX5IlYGb7f0JlDVsr8bc559UgdWXOU+Ishp/MjrUykyAn0WRMh
 UMF36sOP13FPqjrLD2V4v/tcuQrPIPdd6mi7Srpp6rE7dPpWGxXtIJc2u4a0O360UEfCSik1Z+a
 xlNNf+Tv+vnIFvVagWbhPR0Xpi6qZ1IMsU6lqf5v5yIASbQYtpErSjgR5M5iU6Ktbs556fDTMvs
 kXArM22xdMHDnoy6Y4Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-21_02,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 clxscore=1015 spamscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210027
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

vreg_l8a supplies both UFS (ufs_mem_hc vcc-supply) and eMMC (sdhc_1
vmmc-supply) in Monaco-evk. mmc_power_cycle() calls mmc_power_off()
before mmc_power_on(), so the first thing eMMC init does is a disable
that was never paired with an enable from the eMMC. Even with UFS
holding its own vote on the rail, that disable takes the RPMh
regulator use count from one to zero and the rail drops while the UFS
link is up. Every UFS command after that fails with OCS errors and
UTP timeouts.

A use count cannot tell which consumer a disable belongs to, so it does
not help here. Mark the rail always-on in the U-Boot dtsi instead, so
regulator_set_enable() rejects the disable.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
This series depends on https://lore.kernel.org/u-boot/20261021-b4-monaco-v4-0-c90f0c01d312@oss.qualcomm.com/
---
 arch/arm/dts/monaco-evk-u-boot.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/dts/monaco-evk-u-boot.dtsi b/arch/arm/dts/monaco-evk-u-boot.dtsi
new file mode 100644
index 00000000000..e2b636f46a0
--- /dev/null
+++ b/arch/arm/dts/monaco-evk-u-boot.dtsi
@@ -0,0 +1,8 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+&vreg_l8a {
+	regulator-always-on;
+};

---
base-commit: 62c9805d8d57cad407f0295879cc9a6182da464a
change-id: 20261021-rpmh-regulator-refcount-e1d4e0bc377e

Best regards,
-- 
Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

