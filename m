Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB70FC88E72
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 09:19:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4E8C360835;
	Thu, 17 Sep 2026 09:19:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MYkNdXjfmKa7; Thu, 17 Sep 2026 09:19:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 805896083A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789636791;
	b=WqvbPStLzn2PVgJ4qDCj1b14DRdQOlQVMX+hz+G/vS9TL5nQqQZJtruIIxDSocRMkncG
	 RjGx31WA4bgFr9kCIwwPrwQyWHJxikD7jq3/KfPodiYp6v7H6BgBilqP4HMNyP324XaI6
	 B06Sx9hGGPZv9vmQTxLxaxrBwFqU2nmEIjH5OluDNP7i/kLSObDMN/SLE83JqW3aWE4f5
	 AXuvYCt8rS34MSk3YAUsMVY8M5g8nUPegjsmKooL8Fp1SrQNkQ1x3o++g9IT+hGZ4pgb4
	 O1/b7LIs9oved6liekHEtDCk/ny0vdcjWG1gfTnVIRhe/Epyw0PPlC4hts7+l+6KaHg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789636791;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ogBUQW5iaOBglE2TB+CNb7zNRIkXiA2l0I+ygbBuo/8=;
	b=Z1aD/0UNlHJpt1CSzDne6CeSSjaJbVtfcGS7rtkmAQQx4J7FHZygg0/dZy689i3JNS+h
	 4NJGk/cYHFhybZh83G68wlp2ofYhtOou2iX+un7HQc5TH4ONrO3SZfAl7f2yyqzDcN2ZE
	 bPPmYZy5QEnnByT8u9XQ8nTaUhft+iunUASXZL2tf/JglNgJHFiOooblGJ4bgfSa2gf8O
	 u26OldxcADP1VGnBzHwIWRKRGllzzgQ8Talht/9/MavDQSesj/ePQGGae3RJ9BnpFRByi
	 fZK5sjgekzXHulR6b2TDzd9zXaO6fkyMr6v7h+8U2Gdcpbf07GYM2xGBkZVF0NoQZ0Q==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789636791;
	bh=ogBUQW5iaOBglE2TB+CNb7zNRIkXiA2l0I+ygbBuo/8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LK0JO0MM5k+T6X6BxrGwyZ4MJgB1ys9b6mnu05A6ufLxFV+XkSHs5A/oHnAiMKTaa
	 t5UIojWGtbImA4t7zzCc1MIZtPCvZ98ZOm6C9bX+R3GLURTylYlOXdiNRhB6fOcxFt
	 K2JWGhk+NGs2HQ6G0w0eNpZExDHE8TNOi1ScKx9QMjsyvP/0nevmgMeLr5JCZd2U+r
	 H4nbAFn5mIVSoEqxFWSkIwX88tz1QwoUUKRIFCrdxoLLVL9RFsUDGNh2PzaLP8wh2W
	 cYgURuEKMWcw9gi9LCSBPT2JD9iBbt7Q+2e4Q37yJ4538KCLljg54P2Spt8evHF+Yf
	 T/WbwpAKBBpFA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 805896083A;
	Thu, 17 Sep 2026 09:19:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 98AB3362
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 09:19:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 963C4401F2
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 09:19:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lSze77rttX2p for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 09:19:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org D7FB8400F3
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789636790;
 b=YU6fL2Rvm40hmVKdzT3D0rinOxDpdOKY+z1jzyNFLHLpoRwIidWlfgHQMxx5U5D3RDmI
 9E0dVInxxKFtbnR/xKmBePNj34JZUy341FiR9eg5Fps9Qt3ueCNsP1CtvyRqrgWP3CiUL
 qJ6vgQQh0driL9xMxGWuLcCFZEOVNTWVWYW5MsA8NmumPV2Eb7U62/sfVIC/+X6EOUECI
 8onut+vqOPs6OXvi/oiXGQZ3RMZSdAbgRk39yl+NqhEneNpQP4puNP31X5zWg3ExwiM6N
 A7Fs3PpBc/JhBqK4Vhfs+V0ORJKzXhJJNZEjiDQ5gwdSH/qWX/DYMYMr/SglxELKFqw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789636790;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:Date:From:To:Cc:Subject:Message-ID:
 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=ogBUQW5iaOBglE2TB+CNb7zNRIkXiA2l0I+ygbBuo/8=;
 b=IAfSRyoG3vBTdhW4BM1lTaPQob3OCnmCzuQXCQgKKYAM43FyPFG47pg3qwts9XAoEKw4
 0r6w1ABqshvt4HB2vKz1EY46e+A4O9muL2ij0vVlPxSCjTC42aTePY9nYhhYmBTUxYsgC
 JkJLUmWsq1egeE3xyp5UFzF1qAukpCglmvNEFcetNQYXcycaZRxMwuqN3ym+MoxeFlHU4
 ucGHCTYUVy0QMrv3h/fm0gES0rgT/wIa5WuTv1LQySqkLRyJyjnaZmUuW3QZuy3jrVTRh
 GUOKESHnVB7YXOjmMgzzYAjxtNw/IOzlWiNAVFYfQv/DUe3xsYyoibJxAgGPwScPGhw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=SoGfFaet; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Q6FoVlIr; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=varadarajan.narayanan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=SoGfFaet; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Q6FoVlIr
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D7FB8400F3
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 09:19:49 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68H610gs902451
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 09:19:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=ogBUQW5iaOBglE2TB+CNb7zN
 RIkXiA2l0I+ygbBuo/8=; b=SoGfFaet/nFiJ9rC9sCAmS8d+qwBNiBlgP76rXJm
 QyoZ12E14bD9RbnyXyJWhTPafqPXVtNiHkEyMB1dObaOtWlign0UxvAgQxxLDmPJ
 WRIdvN1zEjQksgVegxBHnpf48CdInLwEHfS2EOOQi1EJlp3Ca9BCCrbAerm4DSjR
 6ougw8KluVRKkYeYoq46XERzTNo9UDIY09FNZ06Wh+thX+PTH3AdbJWFbnSCCpdb
 P23Xh4IwcU1ROimrn14k9AAzznEKqzN567dx/uis4O+ZpGLZuco2HcCHC2V5hc0k
 CK66oi10Zqxd3F3Lmv3F5NKb8eKrL6O645L4XWSI3i8q+w==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gqy2d3mh5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 09:19:48 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-39e3c10ac70so1211344a91.2
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 02:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789636788; x=1790241588;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ogBUQW5iaOBglE2TB+CNb7zNRIkXiA2l0I+ygbBuo/8=;
 b=Q6FoVlIrpWJrjg9hVBCW0mSxaDM0lG+rTaxSPaTGXid22WZGBAyotkViulG56QselI
 SYAqw00R7fcKct7ghHT4K+GVvaUUL0KzoUCyuQ5nrokcNNCN7uZVXUFQutruxypd+2Eq
 +Z9S7LlEuJ7drIO6T57JtXmZ0Xa4i43L16nd0VI8ovp24pPhj6Df1TNT9yxB73LtCjH+
 hafUv4SSAONevpHml1aYwaYRNZsMTkiAZGBdBKpSpVK+cI6bLq0ktgreKc7CIc7b9JhP
 4iIN3QyLAFKe9r1ALlzRXTmu+tPShDxqK2bJtg/WV5NibfT2ZNlawFE38jNB5yp1rOSu
 4DcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789636788; x=1790241588;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ogBUQW5iaOBglE2TB+CNb7zNRIkXiA2l0I+ygbBuo/8=;
 b=zs9X3Fu0dJ09pEYbntAE3kiF2eTW6fWdDgpLX+heEZWIWyCm3eRgbqZAC9u0NPpyOK
 W7tAjKiVYBjxR1G7wtYS6ArzJxzp8SIcQ877WbfjqEYff6f3kkxuzmpBl5OkfBzejGd/
 yA23dTUkkf+jkZzY6ThMvu5TBECmapujaplaOxCmwZZuyzoGxSrIXjO6kC6X+3jN37cC
 7lXhf+s0z3uhdWAZ4SmFqozMadL6CU+GxriSuqaN4tCRJqVeZa0uIUpXKkgJCXRsadjt
 N/emN7yYQ8zJo3TQTiz8gejqRBAyMlwfXq7xsQxNlm/Gl6WDcBQyS9xGFuK/YQCyCP4A
 XK/g==
X-Gm-Message-State: AFuF++mdO/xA4iudU2bBX8XFf7x4oV8FnyLSFGsSoqWAG0v+Fr140VNJ
 v90hmj7NsRO3oY/1csz0V84WRhJKc9udWdlwBLKDY4x/ZNWrYsL7SdIFnXqJiq/o9mAGBK1l/UH
 m+UtRVz3ufSK9Cq/0xhFBaydt6zH4cVCD6OK26If8vbczycsT20IDopiPrQdbzN56BZzLPog=
X-Gm-Gg: AYBFou2xESN1Ah0+OD40AEi56WivZLwuYadwi6Kwk3OxjtWvK/cf6KUeDjtwtCGQHW9
 eTXctRfintyLxbp0jK8dYqDxocscn9mxKpcPm6nKPCgRP0+rBXigh5VuV7W4wt3TAjY22NTkYUw
 VGO65Gf00iPjz+ifjG4vWA+zLisGGp3783RERDqv9qrrcUxSRTuF0CAU53FEWLgB7CfeCDwn0ih
 JddCuFHSYa12+Cxkid2opiTsHk+w/yJQ8KMekEYoFw1gVfwTL7jgDytYu78eHTRAjVKLKUtSF02
 2XbhY14BLk67DgjLFBIXISYW8CM61aO+hS5XaU3DIxF4GyDiSV4FkZrXlI3th2XPNsqNk4XIdCw
 6uxZaIzfYbI8N1qDUrYLaLTIfhkBQs1qwJruvazsxevk47EInGR/Q30jYccBl05/C+hPEOilEve
 JcUpZ4UVcGkRzl/iPSpnBoZvbmS+6B1Q==
X-Received: by 2002:a17:90b:1a88:b0:396:6344:3b63 with SMTP id
 98e67ed59e1d1-39e1e27dfe7mr13263931a91.2.1789636785847; 
 Thu, 17 Sep 2026 02:19:45 -0700 (PDT)
X-Received: by 2002:a17:90b:1a88:b0:396:6344:3b63 with SMTP id
 98e67ed59e1d1-39e1e27dfe7mr13263714a91.2.1789636783845; 
 Thu, 17 Sep 2026 02:19:43 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33c13f09408sm3309888eec.7.2026.09.17.02.19.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 02:19:43 -0700 (PDT)
Date: Thu, 17 Sep 2026 14:49:36 +0530
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>
Cc: u-boot@lists.u-boot-project.org, u-boot@lists.denx.de,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Dmitrii Merkurev <dimorinny@google.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Adrian Freihofer <adrian.freihofer@siemens.com>,
 Heiko Schocher <hs@nabladev.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] fastboot: block: add 'oem set-block-target' command and
 runtime override
Message-ID: <aquwqGzPns7S28eG@hu-varada-blr.qualcomm.com>
References: <20260917-series2-fastboot-block-target-v1-1-fc8328bc2d12@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917-series2-fastboot-block-target-v1-1-fc8328bc2d12@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: wSzGB8kKmwF618tnPNWoHvertbMOXXMn
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDEyNyBTYWx0ZWRfX9b6V6CZxhJm7
 OGGZeFowiOoXvkZJfDkDZodAP07V0SZ+zoWyPJnikRYPoYuHG3OnUWcNGG8JyZTXDV+NxkhniIB
 hM2eEKHVuKllT7utk3ta2B+6bW1Rd6c=
X-Authority-Analysis: v=2.4 cv=HbeB3SE8 c=1 sm=1 tr=0 ts=6aabb0b4 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=hGYiyGD5QL9WgGXy0OYA:9 a=CjuIK1q_8ugA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: wSzGB8kKmwF618tnPNWoHvertbMOXXMn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDEyNyBTYWx0ZWRfX1q/dqQOPIcAK
 kZIH6gn6uSpAsblUeMlxqys9RApBbJ8EQRWfTGy57ehoJ1XTweQ9iEZgNLZHiZcfdWnqJ4q2Rd8
 czt0M/Wm6uT8KHVoth0euj4YN0v4s23zTtDbkoiBjGzhkvuf2kKw/V0zG2iBOwkZJgl+yt3S5sS
 6ilJghFIqyAxGBBs3vi1u/x1f2GfuCAOOaGzwonpthG8yHqeghzuocrA+DiAHkTAmtaut5+j8PC
 bwkOfChSKqpuZfN9xzdBaK0vFvY+jrqEY8t/aIUPiihIi38h9MQSMVfSd3Usie+VOfZYZRaBT7F
 YNbvAmTa0GtOeUy8C/r3JqwJt8+unfd/9ZxM+5Ot86LcytpVcrRr318vcucJN/bnszjxt35BFRI
 wO7d3/g6/M8BvFbwcYTSfkynpbVH07+qFnGsU9jHb+NuIZAk7ztXCpe4kC/bBUVPoHXgALClteD
 +D5aGu6Wb6pVhANdn3Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_01,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 malwarescore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609170127
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

[...]

> +static const char *fb_block_interface(void)
> +{
> +	if (!IS_ENABLED(CONFIG_FASTBOOT_FLASH_BLOCK))
> +		return NULL;
> +
> +	if (block_interface_override[0])
> +		return block_interface_override;
> +
> +	return config_opt_enabled(CONFIG_FASTBOOT_FLASH_BLOCK,
> +				  CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME, NULL);

If CONFIG_FASTBOOT_FLASH_BLOCK was not enabled, the code wouldn't have
reached here. The first if check would have caught it. So a plain return
CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME would suffice.

> +}
> +
> +/**
> + * fb_block_device() - Resolve the block device number to use
> + *
> + * Returns the runtime override set via fastboot_block_set_target() if one
> + * is active, otherwise falls back to the build-time config default.
> + */
> +static int fb_block_device(void)
> +{
> +	if (!IS_ENABLED(CONFIG_FASTBOOT_FLASH_BLOCK))
> +		return -1;
> +
> +	if (block_device_override >= 0)
> +		return block_device_override;
> +
> +	return config_opt_enabled(CONFIG_FASTBOOT_FLASH_BLOCK,
> +				  CONFIG_FASTBOOT_FLASH_BLOCK_DEVICE_ID, -1);
> +}

Same as above.

[...]

> +static void __maybe_unused oem_set_block_target(char *cmd_parameter, char *response)
> +{
> +	char interface[16] = { 0 };
> +	int device = -1;
> +	char *space;
> +
> +	if (!cmd_parameter) {
> +		fastboot_fail("Expected command parameter", response);
> +		return;
> +	}
> +
> +	space = strchr(cmd_parameter, ' ');
> +	if (space) {
> +		size_t len = space - cmd_parameter;
> +
> +		if (len >= sizeof(interface)) {
> +			fastboot_fail("interface name too long", response);
> +			return;
> +		}
> +		memcpy(interface, cmd_parameter, len);
> +		interface[len] = '\0';
> +		device = simple_strtoul(space + 1, NULL, 10);

simple_strtol since device is int?

Thanks
Varada

[...]
