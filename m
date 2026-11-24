Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF20606A326
	for <u-boot@archiver.kernel.org>; Tue, 24 Nov 2026 17:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=OMI7KsMH;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Vf5WO7WT;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=U9k5MSIP
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9AAB480BD6;
	Tue, 24 Nov 2026 17:03:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kmJAv9YKsDMe; Tue, 24 Nov 2026 17:03:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 494068081C
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795539809;
	b=fIavaXRndOTVykARtRzAIW3ya5t7SdsCBM3nImZTNebQapApAmj6mzlRi8BEl6+hIMx9
	 irKNjb+OkQ6B1h0s/ftkAiLFHevCMrLEdKEzlRL3dQEp1bcC3uM24L9mJJ+nOZX+0s2YC
	 VWiSs1XeZhE+z67UZoYp90kW93PkuTUsMHKYqA+jOOZW1wNzyUVkNH0+KayQKnbC1tQ16
	 kc7uY3bJ3saZmsxWA0pE9U6RkQlOkRtNMj3aSPpz0ChlHia1RrQ+kASdcCvQ002xgoYCk
	 gu3FJc/BuMzusuCh0YLpL2uvYk9f5EA15GLh5YGxQ2YheFyFelLysmHOkYibzi82KzA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795539809;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Comment:Received:Received:
	 Received:Received:DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-Virus-Scanned:
	 X-Virus-Status:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=UAQY95CzBi1k6EqWXBIHWehA1abhCRw0GaZ7/0Fh/B0=;
	b=ZQj3kR/T5svnPHH0dI12JlC9WZYGKNN7p0o5UaPdUvEGMcGAYeG++u+nk6d3Czud5yU+
	 uZSUL3J9zYfLTwJCiIPFrkghKnXwiaf3JcggqX6zkzWdXmcg/FEdoWGy+MFITLicC361M
	 irya9N5ECqKvYYOZ4iAHOrqqan6uTKUM0HxhBYOEU37uhjqHNqBJTiGspJOI5j43uXSwf
	 0JF8FQAIV0F1pkN+/nnB2TMf9M2eceSjDAIbb9M9ihCLmogRJbo33d20wdKfpotLygRA3
	 SL0jtsAsn4eobNTlPlkMS3R+Yno/A5R1HmNbLMJmksA4R8DdnQ5QULS3W2hXPfH2sdg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=fail smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Vf5WO7WT;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=U9k5MSIP;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795539809;
	bh=UAQY95CzBi1k6EqWXBIHWehA1abhCRw0GaZ7/0Fh/B0=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=OMI7KsMHh9Nw5YR+w7cn8pzXdBLtLOzZ+OzYy46UtCd6gNua0ejXUJ9he3IKCncF8
	 4rDTb9Z/mYdYevcChh8N+MuwFCjmp/ProNYSJQ5lLTfNGGeSYHfFDdKiiAOayRu2X0
	 vkL63lLCUr7uugPCRWwbK0/BPQ9o7GQe/Y6SKJRGJipGAQ1B3CEGw+V5UNLGNwa8O/
	 n7HHZy0a+JJiywqLv65IkAfjpIsNNaUqTB2HWEatb5SQNNCPt9tzQwwtHAAn1yYBW0
	 raAQzwG3Ml6BYekmNHnkvgxDGdWGGqLaxV/zNEmpQMTl+QChlmhUD3Qjd/wz6aK+KJ
	 e757FzptBeT3g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 494068081C;
	Tue, 24 Nov 2026 17:03:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id D78F4371
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 17:03:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BDFF680724
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 17:03:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nAGaVoSxwHgb for <u-boot@lists.u-boot-project.org>;
 Tue, 24 Nov 2026 17:03:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3A89580702
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2a01:238:438b:c500:173d:9f52:ddab:ee01"
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 spf=fail smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=Vf5WO7WT; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=U9k5MSIP
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3A89580702
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 17:03:25 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id B19FB84717; Tue, 24 Nov 2026 18:03:22 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A6BD83B4B
 for <u-boot@lists.denx.de>; Tue, 24 Nov 2026 18:03:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AOFLA0Z1696943
 for <u-boot@lists.denx.de>; Tue, 24 Nov 2026 17:03:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=UAQY95CzBi1k6EqWXBIHWe
 hA1abhCRw0GaZ7/0Fh/B0=; b=Vf5WO7WTf+Z8NrI1noMFtRV2amn71UPkp/5yc3
 6pyZ7Y7LIysRqgNjcQ6lJDlRjlqQZarBDHFJPqH0R5tK4a7pgip3IXMY9mAPYViH
 Pggv5SU9M1RIkwpfV2MeVV3Qn4JdqIxNhZ0+iov5NT0zNTYysgg0o377vpc5Res2
 xo4i5AJgqdeKALo/mtVZ2TiW+fzujwGfCEmqaRR711kctPBoRcJj6oh4A9s1C0oy
 BoA4Xx14S/yaIxGm83U0gu6X9xwUnogihkV8M3Tg8Vva+EXFVRAiPt9X9KzlhkMh
 PxEb1NSRS6PgLkI953Qid/iGfJtPYKYgwnlMHchhrGQ1Qspw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5b80144t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 24 Nov 2026 17:03:08 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-386ad819860so2694582eec.0
 for <u-boot@lists.denx.de>; Tue, 24 Nov 2026 09:03:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795539787; x=1796144587; darn=lists.denx.de; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=UAQY95CzBi1k6EqWXBIHWehA1abhCRw0GaZ7/0Fh/B0=;
 b=U9k5MSIPZFRJN/gJgnum4CmWfpxKsSPGHKI3U97A/PeOi9QwffLjK7Hgd2DicPmvrN
 Tyb8+Ixz8r4NNkWVvnKScduEt7WD2V3EWErV5kxC9q8hZ95MQqH6nCQkXBOXLsLZfth8
 bbqsPCpp8x8XDOySsMfSI4SBaOF6i1nj1XIRmbm3oYX6vP8JeCAV6+CbMO0D5I9vi62V
 BDE1nroZBG9+pZgyGvIBEeJZzzl4IiqdmA0JGi3exk1vuSxmmjFCjZcuJgR7IEaBXyZw
 tYlWG6M4DwuNkJoeW0LisyyFySC6NggSG4KYg5LLL5PBgKP1zxgkM/TRpxXIJ9hcwC4a
 /Hyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795539787; x=1796144587;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=UAQY95CzBi1k6EqWXBIHWehA1abhCRw0GaZ7/0Fh/B0=;
 b=kBQgAtYKcOYinVzm57MZ34bbG1DfbkTX/v86Q5DY79dhqqwJXImnyX5eTYceyLZ35c
 ls1qP/VylqDB/yLWj0wuzPNUkqkfPDKRvK1rEVRGMB4CvhU1zrvS3lTt/dG2ff250/KB
 ZTgqLlSYoW20IM1rM0IKZ11IEisEm0pE/bmtVRoEsvGpsJ5VQOTKnklOEoIQ4lkz7Z+U
 5GtpcMrCAfTDWevNeaNNKS9WLNHZv7EL2r/rXWv4w6TNL0+KUBr1o8jNOAY+aFo9JEhZ
 T1tSC8g6Hd6vdrs37QLGyvq9Hm6q3s0z1mEtC2Tblif3zB20nMTVUHbv+FDkuKdFPxMv
 eAIA==
X-Gm-Message-State: APuU4Z9NrtjueCwsh+ytdJdZzsWr0bKAboQxkqXcheGT3mZUMTJiiUbf
 RWr7F+633qrqJeNb1qwwzfMqUpzvsJJ8J5Mn54cI/0/pq+JGK94azPdsMvWzD1yc4lBd5WZTUH+
 vauEEtawEZfUy/p4avOonD7iCYKdUOsOQulq/H+PEz9Qy0xS4aQVWhr17
X-Gm-Gg: AZFdTZfKF5Nu2Y2UdqIj216Li5TdnNIwvZ9uW5mWmQEtsRqd4+v0FGhUskq6MX6cjxu
 BrypeqtpZ1843QW9d9DFRYP/BnwKKZ0+jYtXdteqI3J66dPsJzGOFtlITN+HaEkoAZPqipINM54
 8BdSrmMrnvD3EoiC/GoAHhpJ8aWDfbX9gib2nqoI80lNl8Vr0ihXYddnOT0WQBLaLotlHdx8ra4
 4y7LTf74cGB6pm+/aARqldyGhGH7gH9b9xHTq2AqPrKWbzJnLq5niA0jl8tYHbOajBCB4XrcLhG
 xxyGUxFYG0z9KKlJTJtIoYzKE6WMK2EgCysvAAUnEvgzjR/PReYlNEtgs7ied5SSGcM7ABJ2mHS
 LTTQjlwMEzPEyhBA5+kikhYKOrpoYLz+ewxljqV9vh7UHQuhxPLkEovxZBREhGoUDWOdgONNM29
 s5EmY5QFwb9VMLrhQB95+lVYv9J1Qtp2QR1nhGCSWsihamYJGdfgTkVMMZdxFBM9+KYGlBJImCH
 A99
X-Received: by 2002:a05:693c:8083:b0:377:678:2309 with SMTP id
 5a478bee46e88-3856ef47a98mr16731380eec.15.1795539786128; 
 Tue, 24 Nov 2026 09:03:06 -0800 (PST)
X-Received: by 2002:a05:693c:8083:b0:377:678:2309 with SMTP id
 5a478bee46e88-3856ef47a98mr16731339eec.15.1795539785461; 
 Tue, 24 Nov 2026 09:03:05 -0800 (PST)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-386aa203267sm20385488eec.0.2026.11.24.09.03.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 09:03:04 -0800 (PST)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Tue, 24 Nov 2026 22:32:59 +0530
Subject: [PATCH] lib: sparse: Reject sparse images that are shorter than
 they claim
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261124-sparse-bounds-check-v1-1-2382566b6a0b@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAELDBWsC/x3MMQqAMAxA0atIZgO2qINXEYcYUw1ClQZFkN7d4
 viG/18wSSoGQ/VCkltNj1jg6gp4o7gK6lIMvvG9c75FOymZ4HxccTHkTXhHpp5mH7gJHUEpzyR
 Bn/86Tjl/piQFkmUAAAA=
X-Change-ID: 20261124-sparse-bounds-check-ca6ab2fc0f5a
To: u-boot@lists.denx.de
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Yao Zi <me@ziyao.cc>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heiko Schocher <hs@nabladev.com>,
 Adrian Freihofer <adrian.freihofer@siemens.com>,
 Francois Berder <fberder@outlook.fr>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795539781; l=10405;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=8wDr2vANYTqCAmHYJn77tGKjO/u/C6I+R2SLNq0rn1o=;
 b=6WyDqW02srBD4eOFG0Gd3FWYZV+tkZVRmx0XOzICLYHvLB5KaoACywMx+dsHNKfLXy9KdlfXb
 IOdHxJKg2SrDGnHF0Tdbay833U4vdxf/9ZcayqA05IEfvmyYi7fi5hT
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA2NiBTYWx0ZWRfX+vVvGPEYi252
 sxwCn/tB0VyP4URPKeH3Eh0oaEzkt+de5UTKVzbh2j3F1cxpFjUKQFnBRn31wlJ4jK8/LIP1/ZQ
 Glpa5hkALxAgNU3P7JrCjyzpbIlBUkWqSmMEZPzMM6Bwtbh+3LKD54yIoYX/NfolPCyjcaw3ZX4
 MzcgpYOEWCx8StcN0lnd3b1xwzFUsI3H0ExmcBMJDanYDPzanEzdcEZ6TzzhHAAyuGGa6b0wEn/
 t/krQZ4OHzbtQC6lISyXknOI2RD4tJu/sbdb76oYlW/uneVlBcwdPZbKlInhRysmaK2Mp99EAKH
 k4oFdgu3MII2FX7h7ewvQne5B2Ye4ERlNVPns6cWJOrvks5XjqGb/NrnPtKiUKUu1tOG2IKsX5m
 z2bzCNNYVoPI95BFvLbpz9HLzOOFl3O8Q0P03hJgteLuWRwFGAoqI2Ca5ht9PbyMTK+hrHyD3/J
 oXUkoSLeuGQ01bPOMzA==
X-Authority-Analysis: v=2.4 cv=K5W3jCWI c=1 sm=1 tr=0 ts=6b05c34c cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=4jTMW6JteTqhnkpk/0HAEgArVtw=:19 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8 a=N7r6uV1igFY2_0fety8A:9
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: Tjl9KAMcb7torByjYVx-XGDBZybOxuPG
X-Proofpoint-GUID: Tjl9KAMcb7torByjYVx-XGDBZybOxuPG
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA2NiBTYWx0ZWRfX6Y0mpBPYIoRA
 m0YI2pN7ePYfde5FgKkqt938caSGKRMcwtocE37S6sNVaKd3BjhLeXeLby/NDX9eCLJ8L4bT0Sc
 vlg0uDi4HB8C97RNSMDv8xuL1wWc6Js=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_04,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1011
 priorityscore=1501 spamscore=0 suspectscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240066
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_FAIL,
	SPF_HELO_NONE,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

write_sparse_image() walks the sparse header's total_chunks without
knowing how many bytes were actually downloaded. If the image data ends
early, it keeps reading chunk headers from whatever is left in the
download buffer and treats that stale data as a chunk, so the user only
sees a misleading "Unknown chunk type: 0x14" error. A stale RAW or FILL
header could also make it read and write data from past the end of the
download.

This happens in practice: when host fastboot splits a raw image whose
size is not a multiple of the 4096 byte sparse block size, libsparse
cannot write the trailing "don't care" chunk. It reports
"write_sparse_skip_chunk: don't care size ... is not a multiple of the
block size" but still sends the sparse header with the original
total_chunks, so the stream is one chunk short.

Pass the size of the downloaded data to write_sparse_image() and check
the sparse header, each chunk header and the data of RAW and FILL chunks
against it. A short image now fails with "sparse image truncated"
instead of reading past the end of the data.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 cmd/mmc.c                       |  2 +-
 drivers/fastboot/fb_block.c     |  8 +++---
 drivers/fastboot/fb_mmc.c       |  3 ++-
 drivers/fastboot/fb_nand.c      |  2 +-
 drivers/fastboot/fb_spi_flash.c |  2 +-
 include/fb_block.h              |  4 ++-
 include/image-sparse.h          | 13 +++++++++-
 lib/image-sparse.c              | 57 ++++++++++++++++++++++++++++++++++++++---
 8 files changed, 78 insertions(+), 13 deletions(-)

diff --git a/cmd/mmc.c b/cmd/mmc.c
index 81b1ca4ad84..8afccded47f 100644
--- a/cmd/mmc.c
+++ b/cmd/mmc.c
@@ -434,7 +434,7 @@ static int do_mmc_sparse_write(struct cmd_tbl *cmdtp, int flag,
 	sparse.mssg = NULL;
 	sprintf(dest, "0x" LBAF, sparse.start * sparse.blksz);
 
-	if (write_sparse_image(&sparse, dest, addr, NULL))
+	if (write_sparse_image(&sparse, dest, addr, 0, NULL))
 		return CMD_RET_FAILURE;
 	else
 		return CMD_RET_SUCCESS;
diff --git a/drivers/fastboot/fb_block.c b/drivers/fastboot/fb_block.c
index 51d1abb18c7..183b2395d18 100644
--- a/drivers/fastboot/fb_block.c
+++ b/drivers/fastboot/fb_block.c
@@ -285,7 +285,8 @@ void fastboot_block_write_raw_image(struct blk_desc *dev_desc,
 }
 
 void fastboot_block_write_sparse_image(struct blk_desc *dev_desc, struct disk_partition *info,
-				       const char *part_name, void *buffer, char *response)
+				       const char *part_name, void *buffer,
+				       u32 download_bytes, char *response)
 {
 	struct fb_block_sparse sparse_priv;
 	struct sparse_storage sparse;
@@ -304,7 +305,7 @@ void fastboot_block_write_sparse_image(struct blk_desc *dev_desc, struct disk_pa
 	       sparse.start);
 
 	sparse.priv = &sparse_priv;
-	err = write_sparse_image(&sparse, part_name, buffer,
+	err = write_sparse_image(&sparse, part_name, buffer, download_bytes,
 				 response);
 	if (!err)
 		fastboot_okay(NULL, response);
@@ -321,7 +322,8 @@ void fastboot_block_flash_write(const char *part_name, void *download_buffer,
 
 	if (is_sparse_image(download_buffer)) {
 		fastboot_block_write_sparse_image(dev_desc, &part_info, part_name,
-						  download_buffer, response);
+						  download_buffer, download_bytes,
+						  response);
 	} else {
 		fastboot_block_write_raw_image(dev_desc, &part_info, part_name,
 					       download_buffer, download_bytes, response);
diff --git a/drivers/fastboot/fb_mmc.c b/drivers/fastboot/fb_mmc.c
index 9bc782ccd02..e6f3bdde696 100644
--- a/drivers/fastboot/fb_mmc.c
+++ b/drivers/fastboot/fb_mmc.c
@@ -468,7 +468,8 @@ void fastboot_mmc_flash_write(const char *cmd, void *download_buffer,
 
 	if (is_sparse_image(download_buffer)) {
 		fastboot_block_write_sparse_image(dev_desc, &info, cmd,
-						  download_buffer, response);
+						  download_buffer, download_bytes,
+						  response);
 	} else {
 		fastboot_block_write_raw_image(dev_desc, &info, cmd, download_buffer,
 					       download_bytes, response);
diff --git a/drivers/fastboot/fb_nand.c b/drivers/fastboot/fb_nand.c
index 6df3917e129..3203c4f9441 100644
--- a/drivers/fastboot/fb_nand.c
+++ b/drivers/fastboot/fb_nand.c
@@ -211,7 +211,7 @@ void fastboot_nand_flash_write(const char *cmd, void *download_buffer,
 
 		sparse.priv = &sparse_priv;
 		ret = write_sparse_image(&sparse, cmd, download_buffer,
-					 response);
+					 download_bytes, response);
 		if (!ret)
 			fastboot_okay(NULL, response);
 	} else {
diff --git a/drivers/fastboot/fb_spi_flash.c b/drivers/fastboot/fb_spi_flash.c
index 691be7c7ef7..2b17536ffb5 100644
--- a/drivers/fastboot/fb_spi_flash.c
+++ b/drivers/fastboot/fb_spi_flash.c
@@ -191,7 +191,7 @@ void fastboot_spi_flash_write(const char *cmd, void *download_buffer,
 		       sparse.start);
 
 		ret = write_sparse_image(&sparse, cmd, download_buffer,
-					 response);
+					 download_bytes, response);
 	} else {
 		printf("Flashing raw image at offset " LBAFU "\n",
 		       part_info.start);
diff --git a/include/fb_block.h b/include/fb_block.h
index 189c708e2f0..9caee5cb23e 100644
--- a/include/fb_block.h
+++ b/include/fb_block.h
@@ -86,10 +86,12 @@ void fastboot_block_write_raw_image(struct blk_desc *dev_desc,
  * @info: Partition we're going write to
  * @part_name: Name of partition we're going write to
  * @buffer: Downloaded buffer pointer
+ * @download_bytes: Size of the downloaded data
  * @response: Pointer to fastboot response buffer
  */
 void fastboot_block_write_sparse_image(struct blk_desc *dev_desc, struct disk_partition *info,
-				       const char *part_name, void *buffer, char *response);
+				       const char *part_name, void *buffer,
+				       u32 download_bytes, char *response);
 
 /**
  * fastboot_block_flash_write() - Write image to block device for fastboot
diff --git a/include/image-sparse.h b/include/image-sparse.h
index 282a0b25649..5d05f0044f2 100644
--- a/include/image-sparse.h
+++ b/include/image-sparse.h
@@ -40,5 +40,16 @@ static inline int is_sparse_image(void *buf)
 	return 0;
 }
 
+/**
+ * write_sparse_image() - write a sparse image to storage
+ *
+ * @info: storage description and callbacks
+ * @part_name: name of the partition being written, for messages
+ * @data: sparse image in memory
+ * @data_sz: size of the sparse image in bytes, or 0 if unknown. When set,
+ *	chunks that would be read beyond it are rejected
+ * @response: fastboot response buffer, or NULL
+ * Return: 0 on success, -1 on error
+ */
 int write_sparse_image(struct sparse_storage *info, const char *part_name,
-		       void *data, char *response);
+		       void *data, size_t data_sz, char *response);
diff --git a/lib/image-sparse.c b/lib/image-sparse.c
index 09225692e9b..94568ab2522 100644
--- a/lib/image-sparse.c
+++ b/lib/image-sparse.c
@@ -106,9 +106,23 @@ write_fail:
 	return -1;
 }
 
-int write_sparse_image(struct sparse_storage *info,
-		       const char *part_name, void *data, char *response)
+/**
+ * sparse_overrun() - check whether a read would go past the downloaded data
+ *
+ * @data: current read position
+ * @end: end of the downloaded data, or NULL if the size is unknown
+ * @need: number of bytes about to be read from @data
+ * Return: true if reading @need bytes at @data runs past @end
+ */
+static bool sparse_overrun(const void *data, const void *end, u64 need)
+{
+	return end && (data > end || need > (u64)(end - data));
+}
+
+int write_sparse_image(struct sparse_storage *info, const char *part_name,
+		       void *data, size_t data_sz, char *response)
 {
+	const void *end = data_sz ? data + data_sz : NULL;
 	lbaint_t blk;
 	lbaint_t blkcnt;
 	lbaint_t blks;
@@ -127,6 +141,15 @@ int write_sparse_image(struct sparse_storage *info,
 
 	fill_buf_num_blks = CONFIG_IMAGE_SPARSE_FILLBUF_SIZE / info->blksz;
 
+	if (!info->mssg)
+		info->mssg = default_log;
+
+	if (data_sz && data_sz < sizeof(sparse_header_t)) {
+		printf("%s: Sparse image truncated\n", __func__);
+		info->mssg("sparse image truncated", response);
+		return -1;
+	}
+
 	/* Read and skip over sparse image header */
 	sparse_header = (sparse_header_t *)data;
 
@@ -139,8 +162,11 @@ int write_sparse_image(struct sparse_storage *info,
 		data += (sparse_header->file_hdr_sz - sizeof(sparse_header_t));
 	}
 
-	if (!info->mssg)
-		info->mssg = default_log;
+	if (sparse_overrun(data, end, 0)) {
+		printf("%s: Sparse image truncated\n", __func__);
+		info->mssg("sparse image truncated", response);
+		return -1;
+	}
 
 	debug("=== Sparse Image Header ===\n");
 	debug("magic: 0x%x\n", sparse_header->magic);
@@ -169,6 +195,15 @@ int write_sparse_image(struct sparse_storage *info,
 	/* Start processing chunks */
 	blk = info->start;
 	for (chunk = 0; chunk < sparse_header->total_chunks; chunk++) {
+		if (sparse_overrun(data, end,
+				   max_t(u32, sparse_header->chunk_hdr_sz,
+					 sizeof(chunk_header_t)))) {
+			printf("%s: Sparse image truncated at chunk %u of %u\n",
+			       __func__, chunk, sparse_header->total_chunks);
+			info->mssg("sparse image truncated", response);
+			return -1;
+		}
+
 		/* Read and skip over chunk header */
 		chunk_header = (chunk_header_t *)data;
 		data += sizeof(chunk_header_t);
@@ -200,6 +235,13 @@ int write_sparse_image(struct sparse_storage *info,
 				return -1;
 			}
 
+			if (sparse_overrun(data, end, chunk_data_sz)) {
+				printf("%s: Raw chunk data truncated\n",
+				       __func__);
+				info->mssg("sparse image truncated", response);
+				return -1;
+			}
+
 			if (blk + blkcnt > info->start + info->size) {
 				printf(
 				    "%s: Request would exceed partition size!\n",
@@ -227,6 +269,13 @@ int write_sparse_image(struct sparse_storage *info,
 				return -1;
 			}
 
+			if (sparse_overrun(data, end, sizeof(uint32_t))) {
+				printf("%s: Fill chunk data truncated\n",
+				       __func__);
+				info->mssg("sparse image truncated", response);
+				return -1;
+			}
+
 			fill_buf = (uint32_t *)
 				   memalign(ARCH_DMA_MINALIGN,
 					    ROUNDUP(

---
base-commit: ece349ade2973e220f524ce59e59711cc919263f
change-id: 20261124-sparse-bounds-check-ca6ab2fc0f5a

Best regards,
-- 
Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

