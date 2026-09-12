Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C4DEC88E53
	for <u-boot@archiver.kernel.org>; Sat, 12 Sep 2026 12:34:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id ABE966060A;
	Sat, 12 Sep 2026 12:34:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vWDx4D-KNJV8; Sat, 12 Sep 2026 12:34:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 9863D60614
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789216485;
	b=HD48TZdUrlOyc2imcOt748Z2GxEGpRcWlIEPUrZOTq4xqO+wJUMnkuIrEl/bkiY8NngW
	 BuCOeOERZnlSHM/tLkv/UWqjIpqpcmsRDp3gdxzroAiI4lilkhHs5ofeFHyWuVY0unSEc
	 +sHt/qc6AZeUxOct1FNGtfopZGvOzUkTuoLL+4xyCqVYtE8U+fCyj/1B9bpy5Z+Vsfb7/
	 MWqfqIDjK4zHnUhUQVGuEzvjScrku4MtTWQILtToKelTFJLjtZhQMp6I+sBVJ4d6j8rmc
	 PsUKM5JXc9lGMoh1sQRVDpdY4FN6J4TRHMo/iw+/8j/zjg0zfg1LIkiv+JXp7gCVq4g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789216485;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=I9tOkTIK1/RCUDJBVq6n49eUn9HuVVQM8r3Xvk3A03o=;
	b=dWawn+9qvE7E/d07O0jSrRGZM0bUFLnSyvfmuH9/7eLfu8ORBn/qopx3YbmBkSA2IYdl
	 Ig/KeGdwP0FM26M1Js31f7m1uDEZeHIq2t+4EzT1r7GddrshCeEqmykIpsX4Ob4A7ZJyc
	 vCnjVJUbwSZw6cxHH5ER/FKsaK2r5f+iA2Mgy0WC38zdKu4KxtYRItyjfEF3gn8WzqII6
	 0mWG9LgEeZmj0COFPTFlOnTba2IYCyewJbto/m/gTjNLu3pTNxn0bLfpxdtL1CExffmdM
	 vfn+Sa42wqJkSWQhMpcaIu/C8q5zxDb/jNsdw8hhCyJshNDTAHrBKziolgnkVhGFIbQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=kklJBwgP;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bbiI7EJS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789216485;
	bh=I9tOkTIK1/RCUDJBVq6n49eUn9HuVVQM8r3Xvk3A03o=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=uHCf2MjybczQD0rRlsx9nj/V/jtLgGY3gHLtI95nzXsQwweU5OIy+6FPNi/C2gnS7
	 IiPwhfRRSVxxauBGU05jKy8TehEjXrZnZTDjtBPxs5YVmuRV1WrSk9zKjsVvsKmOfP
	 QSmm2Kjptd708GY950Dq2BBjtka7pD2HSsLwhVm71x45VIkVbP5asPq4fSXoZoya/U
	 nf+EGvKC1WgtpBbiTDtc3nUxgNkaLQlF0bD5ZpgNxJ8r4pEm53KKFq+7SZpNa0Fe/c
	 OtckLOT2BdocRnDvV9rjdq6WOUMOIkQomf3SFoke/r6AbNihAMhQn3xbHqghMxaS0e
	 DhpypWWyWDLgg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9863D60614;
	Sat, 12 Sep 2026 12:34:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id E360B29B
 for <u-boot@lists.u-boot-project.org>; Sat, 12 Sep 2026 12:34:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C9A8960614
 for <u-boot@lists.u-boot-project.org>; Sat, 12 Sep 2026 12:34:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gp_TNLLTqWcv for <u-boot@lists.u-boot-project.org>;
 Sat, 12 Sep 2026 12:34:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org A314F6060A
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789216483;
 b=UU4gJ0l4brh0LXV3ZvTd9ax2lxxjPHhipknwuoeAhUhuvqb2HMSwukFnGPzg4taK+IrQ
 LGIiT7bcAFMGTAxsMA66XSHUnpuw12VJY9dneSoGDMRZ0BwP5IPLU6WeyU+VPWztvteqR
 u3dd7PlM3xxyYnuEWOG9ofbIMzEegWRSgpDbXNQy0BEGE1X5GDdTGyANemoxvV659l4HT
 RLLbeN3Bpf+wySDan2vp7GLoVE/xD+z/23HzX+ScSuGh5EnlW7qOEHzE21nVXhkSQYqL7
 OciomHF+CFNwg+z9PuLiY6YxoqgvVjCAPoNG1yRel7RJt179IcTm5Ar5N5Lmxqqgu+Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789216483;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=I9tOkTIK1/RCUDJBVq6n49eUn9HuVVQM8r3Xvk3A03o=;
 b=T/Jj3nxR1SNjbhkjuH5kgCBFVnSLc7VyJv+fBm5SG3MplZmAnNkgD9gqMTnYP5byLdeK
 Vwm+3VdPcKfDuXM4s7uj5G2+ulPqkuNU0tJt3obZv5Sgx11PtY5RJMgBoT5aYY2r9PbjW
 O7RB4G2xk0FE0h9UOCSkMQgYsg/1smOdIS3FOOC/Dw70aExUfCvK/I+M9a0Hkp/ofsU2J
 fVD3Gud/VPEKubdZVESIJSNSq3ZG1WaNK4ME2plhWdLLDFWSPvaDyLnB05b2kzX16Z+6Z
 xmEUNBUlsMskmBomGu5XERi1VYWOqiWww9VvCw9wRxSUjmXTvhC0dIu0Kp7wL/Zt/Aw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=kklJBwgP; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=bbiI7EJS; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=kklJBwgP; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=bbiI7EJS
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A314F6060A
 for <u-boot@lists.u-boot-project.org>; Sat, 12 Sep 2026 12:34:43 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68CBdTGM2933483
 for <u-boot@lists.u-boot-project.org>; Sat, 12 Sep 2026 12:34:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=I9tOkTIK1/RCUDJBVq6n49
 eUn9HuVVQM8r3Xvk3A03o=; b=kklJBwgP+BPumSkR/oGJkHQZ/Lp8b/UH8dKew3
 a1fnpAUuCWTJ6OgEo6oInrOuT4hOdforkXdg07ovckxy4Fu9aBp5lR166wfg7uGD
 f8xyFKo9+4ZALFCApvmoGNAJDB+YX+Zf/tZi+XxLGNruYn3261sZleoSgh2SReiK
 KLOomsfErf8xCSE/4Lq7yYbBITfW1Gfw1Xk/xmMmm9VTTvVfSNHk//6Y+gY5jj4A
 06x16Z+jJmX1aQYFapkxPZ1KwskHyDEOmlBgz2MMKk1+1Zaia+3Sudryg99RR5si
 6zFZqAx0LkzCsIpl7MLa6Z9fVsfCcqhJJJS4NtW9YMTdLeIA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmy9d0xh0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Sat, 12 Sep 2026 12:34:42 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2d63bad3d09so30018415ad.3
 for <u-boot@lists.u-boot-project.org>; Sat, 12 Sep 2026 05:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789216482; x=1789821282;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=I9tOkTIK1/RCUDJBVq6n49eUn9HuVVQM8r3Xvk3A03o=;
 b=bbiI7EJScbq0oeo9TWMm3VZWFonjhTnCfReDdGL1/qAeLTD3aiqs09rJNSs9oscuM8
 iywFrN17qxZP7StJXaz5e6PZyfLBHWrmrOEUsOZ5IcogyMEoUQHQ6t+eRQHgM9P6nl0B
 pF7UG7iugehA6TGupSQbWd+x11/GtUPnAPJiqQtrGmI3f9Wpbc7IyqhwbbJtuXQidNe3
 DhN1KaBrmhwC0Snla4Fceh/SzS2q4kLMLQG9cCaLJyEhtKW5skgSCb7Bt7BXR/btwrTa
 Nj/4jthWs9OSTI/oo2FZtqkefYlXghH+o0DVaGMXG5V2j3gyVjovOxVsubfbad1d11PO
 2Yfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789216482; x=1789821282;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=I9tOkTIK1/RCUDJBVq6n49eUn9HuVVQM8r3Xvk3A03o=;
 b=barQH+LAwOf//bm0HRjextJiRImnqY5yisdERRN+cvFHdnxjFeHfArUGDaRoFqp614
 KdfrqMif5QNZ/NtStL4wrC3/YjOqMWKHNk4VQUxbdfRKE2yEArrU20Oshyn/F8cZZTc4
 G4BrvPwfku88AZFuMYQf/EVIVugp6ZoN8CE9NuHSJ5SIzxJAoqmogvItR2ZSCwb9N5Zy
 TzbptH9VfoTe8xqtZ4eZAJoSpvIgSmIfdHexdK8NTHdMZFdQ5qJRnu3U2vsTirMDfg+G
 xz411K2dkzfDJlUd8RmGPf4it4Ntn8+hOjS2S40hVwSZ/dzP7rf6nC5gsDgSGkCy4HuQ
 xKTg==
X-Gm-Message-State: AFuF++li6NvRC0N/qXAnJNs6solgFfv5/rsITLMoDg5mQBnbrbJZ0Fug
 qwGro6BEUTdlFMksr8sYFAglYkLCUJVRnStt9CUhdEJO8h8p4lK3VFKc7EnPhSkJOhCePSgNwQC
 90r+WDYs4eVaLoXWPMjl7zZKf5e9CruegEutC9Kwc9qxfSLcqMEce/HL+GdF0o8yAMvAiSZI=
X-Gm-Gg: AYBFou0WXTA6kARBkjI+HUYFdlRS1JE6mNHv8g/ys1YNRdos4E3fpH2cKG3iEQAqoly
 PzUZs8be0SxcW8hTDHBVSpg9ruBPhXTzVZ32ABjz0OIgWKaFKSmxMnn6urRaVsMX/2Ddz0NKVLq
 0FqQ8zyIksmS8V/GwPWP8OUJTbJnJ+xuPLKUxCS4YgA+Z7HUqp8SbQBumYVYo81Wvhw0F2p/LgH
 7qSWfKcXd3sIK3PWD0Y1A0mAskQiIbvf3PTRJy+sJcYaQmCWdb+Ci0muk5x+nCuaLzHbwGCLqgK
 8PbktU7VJSm0D4/iq8Fw0bvxg4J0/Vcgt7pcokWzqlBg+KKWwKlSeBbar3VzzF7ebrlqK7rJV05
 29vBejU6l+jlSzZN2LuSRX39bmL5AKDmZFE77C73TsFP5wGQXTZWLFyI7EuC0aJz19smx2tBnl6
 JOnKGa59jspR7flv2+mqk4pPlo8mB6
X-Received: by 2002:a17:90a:e7cc:b0:398:e436:384 with SMTP id
 98e67ed59e1d1-39dbbe86048mr4836395a91.1.1789216481599; 
 Sat, 12 Sep 2026 05:34:41 -0700 (PDT)
X-Received: by 2002:a17:90a:e7cc:b0:398:e436:384 with SMTP id
 98e67ed59e1d1-39dbbe86048mr4836351a91.1.1789216481180; 
 Sat, 12 Sep 2026 05:34:41 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14365ba71cesm13278438c88.13.2026.09.12.05.34.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 05:34:40 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Sat, 12 Sep 2026 18:04:35 +0530
Subject: [PATCH v2] lib: lmb: return -EFAULT for partial bank-boundary overlap
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260912-lmb-alloc-addr-efault-v2-1-0a796adfd99d@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIANpGpWoC/4WNQQ6CMBBFr0Jm7RA6RCuuvIdhMbRFmhSKLTQaw
 t2tXMDNT95P/vsbRBOsiXArNggm2Wj9lIFOBaiBp6dBqzMDVXSpmkqiGztk57xC1jqg6Xl1CzI
 1JEizJKEhb+dgevs+vI8282Dj4sPnuEni1/4zJoECJZ87WSuqxVXdfYzla2Wn/DiWOaDd9/0L1
 yzeesEAAAA=
X-Change-ID: 20260907-lmb-alloc-addr-efault-a29212da721d
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jonas Karlman <jonas@kwiboo.se>, Randolph Sapp <rs@ti.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789216478; l=2472;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=Bz4Rbjz/Dw9SZcKM0aKshYt/ZJnWSIb8818au5LxD5E=;
 b=Iu7By1q+7b+UXk+yU+c+4i/06CshlDb5rfxBqpttXKyXpSivphCw4WRFZ21a5L+YJ4XKHh9iw
 uQq+ui5CzbHCKmM2zyu8qbMdpl0hneBdZTxE6tQNO7CnI7kd+y3yL5D
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEyMDE4MSBTYWx0ZWRfX6+FU/vxLJ+Qy
 vxZUFlQSZsslsSymWqTl8XFCR2Q83v3z3erVNOY90+E1FWgIxT3HrzP6gC0uJCys4YwsPC9mLAV
 fQGMYzSMs7SGV6l/RZ3HiuoXgUQUQoo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEyMDE4MSBTYWx0ZWRfX5Ca+MRqGPSpv
 8xGnaICCuVS38DX18burgOQ1YFHDqtrCq+TF1DmcBO6xeDVdiX+ECaZSzA4+Kv9T3gz3ctMvvtF
 MRyvAg7BUGXWtNSE5Bj5cBjq1xO43oZCWvNZpmtFUs7aVcOKK0cnIqLPzYI+4YgDVlXGI1PA4u9
 CF78Jb6BbkVKnv8imnBkhasFPFEueTAl+NrSR9N5t3jv13vVFTRoxJ+nww3CzH0sjk0ImHjHTk3
 Y9bcDnQ/UbbUSwD2FaNRAkkIZQIl6A6jKkJDXZnfWYaE3eV9jff0YWwz5SvaAoSTL3ulzcZlfsY
 0aA/DsRq/QRlo+UfDsWCz/++qDsw++HIlMu1/n4eiSsmTcZsjlYeC/duFxZp98tu+3Se7s9GGzk
 ha7tzJ73w8TnmyVl/1Hr5WRDryotFRBt2Xa+Kyf4Jlt4wayfHshwRu2QE4X/mCk0F1fmlq87PWk
 ytIb5vxTAyM5WhZtJGw==
X-Authority-Analysis: v=2.4 cv=IOSXmQvG c=1 sm=1 tr=0 ts=6aa546e2 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=MJGjRZuvdFrGBqEyE64A:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: 2AFCD6Lm_L-7nDzq4by62IretW7Zh4yt
X-Proofpoint-GUID: 2AFCD6Lm_L-7nDzq4by62IretW7Zh4yt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-12_04,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609120181
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

_lmb_alloc_addr() currently returns -EINVAL when a reservation overlaps
an available memory bank but extends beyond the bank boundary. It
returns -EFAULT when the reservation does not overlap any available
memory bank.

From LMB's perspective, neither request can be satisfied because the
requested reservation is not fully contained within an available region.
Callers therefore cannot make practical use of the distinction.

boot_fdt_handle_region() treats -EFAULT as a non-fatal condition and
silently skips the reservation, while -EINVAL causes a boot-time error
message to be printed. For bank-boundary overlap cases this message is
misleading because no internal LMB error has occurred; the reservation
simply does not fit within available memory.

Return -EFAULT for the partial-overlap case as well and update the
corresponding unit tests

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v2:
- Reworded the commit message to explain why the overlap is not a
  serious error and why it could be ignored
- Link to v1: https://lore.kernel.org/u-boot/20260907-lmb-alloc-addr-efault-v1-1-7a5b73c2318c@oss.qualcomm.com/
---
 lib/lmb.c      | 2 --
 test/lib/lmb.c | 4 ++--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/lib/lmb.c b/lib/lmb.c
index ca00047f624..745410a8895 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -752,8 +752,6 @@ static int _lmb_alloc_addr(phys_addr_t base, phys_size_t size, u32 flags)
 				      base + size - 1, 1))
 			/* ok, reserve the memory */
 			return lmb_reserve(base, size, flags);
-
-		return -EINVAL;
 	}
 
 	return -EFAULT;
diff --git a/test/lib/lmb.c b/test/lib/lmb.c
index 168c66ae649..e6c05a492df 100644
--- a/test/lib/lmb.c
+++ b/test/lib/lmb.c
@@ -781,9 +781,9 @@ static int test_alloc_addr(struct unit_test_state *uts, const phys_addr_t ram)
 		ret = lmb_alloc_addr(ram_end, 1, LMB_NONE);
 		ut_asserteq(ret, -EFAULT);
 		ret = lmb_alloc_addr(ram_end - 1, 2, LMB_NOMAP);
-		ut_asserteq(ret, -EINVAL);
+		ut_asserteq(ret, -EFAULT);
 		ret = lmb_alloc_addr(ram_end - 1, 2, LMB_NOOVERWRITE);
-		ut_asserteq(ret, -EINVAL);
+		ut_asserteq(ret, -EFAULT);
 	}
 	if (ram != 0) {
 		ret = lmb_alloc_addr(ram - 1, 1, LMB_NONE);

---
base-commit: 509312dc5386ff4c5adabf53a573abca0aac4ce5
change-id: 20260907-lmb-alloc-addr-efault-a29212da721d

Best regards,
-- 
Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

