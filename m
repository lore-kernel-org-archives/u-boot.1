Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12CD5CA601F
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 18:13:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B7CE44094E;
	Fri,  9 Oct 2026 18:13:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OGA5JezvEbhE; Fri,  9 Oct 2026 18:13:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org ED1FB40911
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791569636;
	b=IqUNXD9I/0VqJxLUx9SHiEz8oRLFYCuBr1TfTbfkv5bGbpos9k6ux0VotvFzVJAQXdz4
	 Og6DhOq8dxI/rxIp7w2iTPbjeIct+/hFpoP0R7GUOgGuNYv0DrbKJAtdMLf+jVv9am4g8
	 upjvg0o8A8Vh9UNxSi0ndt2jioBkD9PjNsRC8ckVAIDeAKwz/MmRWm8ak9BwAPNY3mhw/
	 TalfGsO4rKrIvxHJXeUWJZ3SHGpm4mvheQYUtsX8n7nUKJFLL38TLhVcQzMXe9zPX6hyA
	 v6vo2UbBWOS70EuPGSIdOnyvQKoCgRgmX72Am/3Pqm5xVf0CklZO1NsCLIHtQp4B+yA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791569636;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=AHlBuWeF3JxXEfLgzHFfskDBmqZNH6KJoRQkA89DFEg=;
	b=MUW5W1F8L+FwBKoxltLRB41Nh18M/krV7AFiDXdc/a8xUHxq3gNSqthC/A2fylv6neI9
	 lY0f1Drnqluecq/MSRPGZ5r6vS6hlg6rZXS8eGZe2k5FMBfr8jrtDMPty3PJXPyroOSGj
	 BgK+Nm0C7fIAu9+CHJ/ZqxeUoXNd9pXryc7YpBQD3v680qKp81fEgwga+NI6BXHtKRJpI
	 wGQdYKaZ+t9i/xZvmzydFr7vMyGAuHj72HtNcM0gK55Oeuq8MnQet588CE4rgmQRIH4CJ
	 pIFgkfmZm5jK+5kE//Csv6BytynTqmGleH/UZpoSd6RRiVxxNy/ZQ5KQeyu1VJzM+pw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Ay7+kxKu;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=iNpQi9tw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791569636;
	bh=AHlBuWeF3JxXEfLgzHFfskDBmqZNH6KJoRQkA89DFEg=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PLTQeIj9+bRwtnrPEPqvPdFNgvPmm1G0qoF9KWJkFB2vU99HoHuw99+xFALyIlOXV
	 7NsRXLtgmzvIcztqp0FESRza8K3hjUYPwT4YjVqbfurE3TZXFYFtwVEQirxHvJgv2+
	 8Sg9FJR3Y0ipquyME60qjyIckwebY9BFMr99rbl1QIxn1kF+9McX81rmBfnBcUTT0S
	 o6VqMO7iE6ibjzsRgWW4OOrShfdeszo0vZQfjU23NyvidGHW50S9O7oHLbCpWhlCqb
	 VYC0hJT5cxqAT9oAGWJ7Q7Q0PMUFOf1pAzkzEJwM+XT5SKloQCwDFZMjVut49cGDu5
	 zIEG8fnrc60Ew==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id ED1FB40911;
	Fri,  9 Oct 2026 18:13:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3C7DD75
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 18:13:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 219C440911
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 18:13:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wAga_TiKHRpw for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 18:13:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 60215408C4
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791569634;
 b=Ge9JQ0hlHTbcqTwC/zH1kSdnG5/xq6N1nKuQg9SiYKrjSUOW/x41pQmC3l00f94o1xTR
 JSayxj6gXEdVT0XZ12DZXTuktmAD9DE3RKbSZaaglT2dO4bn980sbz3+BvHW7sSIICFz8
 hJYkF9hShbbFMKKX+PBg4Pa5k53rHOZ5dG7gaB5sywzrOUujHl3ktZ6x3Ko2Y+5jZc5zO
 emgnLbB0wZa2lqyJ1wOXbWFPcJdxlCMkumwIVykWYd8c29Zjw9N/qbugVLkaBqv4WDXOg
 ehIDILUB6mLy1bM6yyrQ6TmtQ4bXmrgkSPCYbue5ZRUmr/GIqKzzYmu/UTWmg/ixA/g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791569634;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=AHlBuWeF3JxXEfLgzHFfskDBmqZNH6KJoRQkA89DFEg=;
 b=lnC5ou2z1GH+hI8myBmhKbl8EdDOC29M48eQ8rOusid0iSp03r2PJOUTTRgAfrLgW5rB
 ktvIaA7m+b3hdAIguemf4Ov5uE5fjIHI1xgfy++HLrZxrRLmaBpyK/pEbBCNPbNKXsLck
 g1EqR+Q3hxom2UOeN8v3d3FibjhW5kgof2h8mKCmwEPUQ7fYtDnpaPVewCZZ5tWwkSji2
 wzVrUxkGQLXDPhttXM+QynROFljvdUV2+oBRHgPYaM/4y6JbPrSvBeyRKpwiK5BX9Vfnf
 7z/aqbZ3Gxmi71yazcKA+iJ0X32haAx5CJr4LpExpy4kiWHa/CqPv+TU4Nj9SOgNAUg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=Ay7+kxKu; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=iNpQi9tw; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=Ay7+kxKu; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=iNpQi9tw
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 60215408C4
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 18:13:53 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 699Hpnq52494165
 for <u-boot@lists.u-boot-project.org>; Fri, 9 Oct 2026 18:13:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=AHlBuWeF3Jx
 XEfLgzHFfskDBmqZNH6KJoRQkA89DFEg=; b=Ay7+kxKuNgc/FOp2fyGPKe/8d6p
 MIZdDRoMYau8rWBwlXfsdxvvkj390joGCgPECGS4NzHk41hrLfr80S90ckwxT2t4
 6kdDlULlCRkly6H/3TMi1cf2M0JB1irhvidUNPCYt7kwTiuMGXtxtKox/AJJX97Y
 JNpeMBYazKPPov07/i7dHiD+JvfyFwkzdI6m6pkhZUZiEnmaNCSxMWEfFOC2NElM
 +QcMSHR6ULHni63G092KlWFGRxD318KtjdrFn7wcs92p1kDZvyZXRq/tveuXm8Ex
 4H1kp8IPP5M87Y7lgoXNtlnlce/SRhG/NAZAn60/8dWwHbTa4mOcphbCaAg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h74t884ma-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 09 Oct 2026 18:13:52 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2df5a65671eso24374865ad.1
 for <u-boot@lists.u-boot-project.org>; Fri, 09 Oct 2026 11:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791569632; x=1792174432;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=AHlBuWeF3JxXEfLgzHFfskDBmqZNH6KJoRQkA89DFEg=;
 b=iNpQi9twDGXVcEetHDIn/TuNcZmhui5/yHamhE8AK+p28/gsSur8uJ3ueSuV6daOmY
 jDxM1ZuWULnZH0MTk1nNHHo8+k/zTGL+IIXuXvS/AjKr78fvolqfbZx4Fec8jgs5U7Zv
 XW6a1TCMLQx9cSUJ4sNLRqnHqa3j/mJx6ANzPD30WNusUxNt4kQDtQiA2vAYt0ixkO7x
 zCuAOGVASZZbT5ejzEqjHXFk8hBhynWbjtxkwXxPXlgTOIE0WR0SqZNKIbYdzyvnEGkG
 +xi9zvhcOKaKMKYO9WC4Ga1xbhqqHyx0apv7GkFu8PFwBfe6nCGZhMEiHX9rTWtpAmpE
 H67g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791569632; x=1792174432;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=AHlBuWeF3JxXEfLgzHFfskDBmqZNH6KJoRQkA89DFEg=;
 b=eS0DXS4f07fk60hZ9CHOwGfSGmpmm8t+tZIdg7sNHdSyeEEpllk+4lW+8t+kZNXOv+
 kWlwPblsz+LGdWsqoVH9thZiKX+WGV+QZY0Bc8HB2fMnXd0g78bHHJk0RKEunglfZ4DV
 ML3FNiZzkutOODSSkv2TGS6d4g7f/TQHtoq2TD+zfw/4EhgwGcWKENkyCd6rGEWD2tEY
 zu42DrhE2b5NRAczIAPSF5i4HawsXqTcWDV2zZqfjDhkePf387Gk/R4PBSqtKuPCWFz2
 EQrqxEOiZUch0FArYec6QmV4rnYacyHM+c8kA/KIfm1Sz8X2byRZmKLSwSYdf0k0yZOJ
 gPOA==
X-Forwarded-Encrypted: i=1;
 AKwUvBz8G22l/iMJL7GgazWwvD5NbEYAl5NPoxQdtFC94oJdAlBcu7D7r1uIutVFBkTVKUqx67Jr8d0=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLK0RCTyVC2XYyV5jws55dwbRIUeO4EC+MzvBIbTnHxTWBVPzgE
 i9XKDrkuTe0tKhMo53DurZZXWdX7FNbUcE/5wwfvKJlboxw2/NIE7i+A+5g9Atlpbb0YLPXUfil
 rC927pP9Hp9vwjQ6QKyT3uvX74qIW6swY33m1YL3FrvWKZxHrsUB1Ol8rYgYv1P6uqd9aWYg=
X-Gm-Gg: AYBFou16NxOqiwQKUYH1SP6fH9ly8PG1e/52RjLbterzGD5vm6fSru0EClIYfSrbyQe
 Z82j9lJD4TxdIaMpIM510Lm4AYKuXKG5pLNZZ8hlRRkXLzhcKr749dF1Z8X8HSu76EsfMxxiBEP
 PmC74SWPjIfNDlhG1YazXdkZw9la9gGBGv/NoeY6OxQojAVSrTS5rRGGKBHkw2cpme2f0hEg4zq
 fiUay9x6K+Qm27RLWARwfj4M7Iv8E3UOO8+xuVVhE2NJ4uR9kefn5aT+mN6huDjoVBOKDmWaGKD
 MzbUZSPMZPthwFqhqbL70FQM3iQiwOluK/xU11UI3Mtt+zysZ+VCTtEFxehVRZf21uqa46TSVXS
 idUe0Zx3O9fUIsiBAzWEWRlXyTi2wjRU1mbjgKJyze0kpiUH2U39MlRhAHHnY4RmEkld/RkYWJE
 l/UbfJH8eKNmEL+zg5eA==
X-Received: by 2002:a17:902:e748:b0:2e6:1c24:d5f2 with SMTP id
 d9443c01a7336-2e840542be6mr20225375ad.36.1791569631600; 
 Fri, 09 Oct 2026 11:13:51 -0700 (PDT)
X-Received: by 2002:a17:902:e748:b0:2e6:1c24:d5f2 with SMTP id
 d9443c01a7336-2e840542be6mr20225155ad.36.1791569631128; 
 Fri, 09 Oct 2026 11:13:51 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e8422e2aa4sm14599845ad.71.2026.10.09.11.13.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 11:13:50 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: sjg@chromium.org, trini@konsulko.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, seanga2@gmail.com,
 alchark@flipper.net, lucienzx159@gmail.com, daniel@makrotopia.org,
 michal.simek@amd.com, aswin.murugan@oss.qualcomm.com,
 nathbappai@gmail.com, Michael.Srba@seznam.cz, jbx6244@gmail.com,
 marcello.bauer@9elements.com, anshuld@ti.com,
 tan.siewert@9elements.com, james.hilliard1@gmail.com,
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: [PATCH RESEND v5 3/7] reboot-mode: add REBOOT_MODE_ENV_UPDATE option
Date: Fri,  9 Oct 2026 23:42:48 +0530
Message-Id: <20261009181252.2334254-4-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261009181252.2334254-1-aswin.murugan@oss.qualcomm.com>
References: <20261009181252.2334254-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA3MiBTYWx0ZWRfXwQ13AUK2ihQM
 XX2iR13oOdItPU3Z6ypjYJYTiBk9cADkswHUZEjVEHkn7VeE7lupptEKX8j7Q8V+bYOwyQv4ZlP
 HZ9VoGf9Fu2WutNRIJfuCbylEFqcigU=
X-Proofpoint-ORIG-GUID: X1GNw_IsNElgoaMAABduBtnmJKuJnBuJ
X-Authority-Analysis: v=2.4 cv=D9jSufRj c=1 sm=1 tr=0 ts=6ac92ee0 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=Was2I079b4wdTqC6JN4A:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: X1GNw_IsNElgoaMAABduBtnmJKuJnBuJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA3MiBTYWx0ZWRfX5KdeR+Ws0wmH
 NI5CuBiy5jfkb/GtHGBUIP9qarJu2tYFKLWo8JSeSHkbiQdvWvOIFEIyqgChyk9yC+yrw8E7QzA
 Rp4v8QA0MSxtt6Q/39SDihUo5Da2KCPbvhFtnCBmzk8mLRBMifhViaKyLdxYfwxfKSmg0OEaE8V
 c5xop1o/WS52lGMmhCd2re9S9bmucy46Pe2GMF5uoc0nxaXTHS9Pq14o4vq3WkC1xOP3elH6N+4
 k+gfbGu57GxXCVGNz5jCaEkvKqu/yFA8rl5UYhUH8MZ8byva739TdV6MPTIsWfAPJW77CuOnTCb
 TEjltXGGjUO4lG7+xLhpQC61NYkLhhSd4seMo8HsPklVD8wpwDBS0+zA2gDDRaagFA59fc+VHwM
 RrS2ARGvulqS7YcpNvbs04ffFZ2fKUwcHNu/WLf0BUlTxuNcKjI1CJ+K2th+1bO14sx2DedpB/4
 ZaOAcIFsCSVlobyJKLQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_05,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 phishscore=0 impostorscore=0 bulkscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610090072
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

Add REBOOT_MODE_ENV_UPDATE Kconfig option and implement
automatic reboot-mode env variable update at last stage init.

When enabled, the reboot-mode uclass registers an
EVT_LAST_STAGE_INIT event handler that probes the first
reboot-mode device and calls dm_reboot_mode_update() to set
the reboot-mode environment variable.

EVT_LAST_STAGE_INIT fires after the environment is fully
initialized.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 drivers/reboot-mode/Kconfig              |  8 +++++++
 drivers/reboot-mode/reboot-mode-uclass.c | 29 ++++++++++++++++++++++--
 2 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/drivers/reboot-mode/Kconfig b/drivers/reboot-mode/Kconfig
index 3fdb4218a8b..35f12e1bdfc 100644
--- a/drivers/reboot-mode/Kconfig
+++ b/drivers/reboot-mode/Kconfig
@@ -39,4 +39,12 @@ config REBOOT_MODE_NVMEM
 	  Use any kind of non-volatile memory (EEPROM, RTC, etc) to control the
 	  reboot mode.
 
+config REBOOT_MODE_ENV_UPDATE
+	bool "Automatically update reboot-mode env variable on boot"
+	depends on DM_REBOOT_MODE
+	help
+	  When enabled, the reboot-mode uclass will automatically call
+	  dm_reboot_mode_update() on the first reboot-mode device at last
+	  stage init.
+
 endmenu
diff --git a/drivers/reboot-mode/reboot-mode-uclass.c b/drivers/reboot-mode/reboot-mode-uclass.c
index 7cbe02eb4ed..976544d2810 100644
--- a/drivers/reboot-mode/reboot-mode-uclass.c
+++ b/drivers/reboot-mode/reboot-mode-uclass.c
@@ -6,6 +6,7 @@
 #include <dm.h>
 #include <dm/device_compat.h>
 #include <dm/devres.h>
+#include <event.h>
 #include <exports.h>
 #include <reboot-mode/reboot-mode.h>
 
@@ -116,9 +117,33 @@ int dm_reboot_mode_pre_probe(struct udevice *dev)
 	return 0;
 }
 
+/*
+ * reboot_mode_last_stage_init() - Update reboot-mode env variable at last
+ * stage init.
+ *
+ * Called via EVT_LAST_STAGE_INIT, which fires after the environment is fully
+ * initialized.
+ *
+ */
+static int reboot_mode_last_stage_init(void)
+{
+	struct udevice *dev;
+	int ret;
+
+	if (!CONFIG_IS_ENABLED(REBOOT_MODE_ENV_UPDATE))
+		return 0;
+
+	ret = uclass_first_device_err(UCLASS_REBOOT_MODE, &dev);
+	if (ret)
+		return 0;
+
+	return dm_reboot_mode_update(dev);
+}
+EVENT_SPY_SIMPLE(EVT_LAST_STAGE_INIT, reboot_mode_last_stage_init);
+
 UCLASS_DRIVER(reboot_mode) = {
-	.name	= "reboot-mode",
-	.id	= UCLASS_REBOOT_MODE,
+	.name		= "reboot-mode",
+	.id		= UCLASS_REBOOT_MODE,
 	.pre_probe	= dm_reboot_mode_pre_probe,
 	.per_device_plat_auto =
 		sizeof(struct reboot_mode_uclass_platdata),
-- 
2.34.1

