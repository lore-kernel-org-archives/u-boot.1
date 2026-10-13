Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79251CC6B0A
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 05:33:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 437B880C76;
	Tue, 13 Oct 2026 05:33:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JPajbAA1Aqld; Tue, 13 Oct 2026 05:33:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8143A80C72
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791869593;
	b=Tq/DWwV+1d4V1Ka1pdpcOr3kwi/XySUGGId43oIOADEThzvqx81RLMvSqsOttyg2LDaR
	 PIfKMFSuuTYCm9aT+TwgxAOrI6BndYJnz6fZj67wa4JLlxxvUkJYO8ldAKFMb/9Z5tY9l
	 +hS3/9Seg0wUQhLgA7Qxl0RUd1FryVOZpHNXErJhMBMhLuPhm4fWEtwU2i4cDjONat7+a
	 I4HS3sbOkoo0Jgwiauf/O1OVj+81+P5zLDrmqbixgCG4QpZr8INDlwoOZFAweN2DHnPAu
	 WnNgNwCnjqBgA8TSwnc0I5zod+SoKnBnOtVjHohLyBovPqPvhS8x1PLk7P78iXE/P+w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791869593;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=doWJbh7FqialYmi81CmpvlL5mjRVCir1a9mrILO97bc=;
	b=a8jY8PGFBn6KVbzn6ha1kl73r3wmcYTS7C5IdOiqVOwlWSRGHvTe1JvR18uhYjwKqEUm
	 zR2G/rrXlKJsYsvTz0BkX6lhv7IyZlj9zXdiRFV7TcgcfWgKlK+l7Lrp5NOvULrKUQkbZ
	 UUSZBCakHrk1TuxSDEl/uKV+uzHxNPg95J3HP2IuqKKlOKHItxNSeGviw6o/GXhnuULTy
	 a85w3YIgl94DJM7y361PJWVHVrkzbZtsRd5Ak/Wye+ND1LzNQvRps6EOSHK9XRnAE9+X8
	 JhFocFwUILBQ7lWRYXvuEoN4ouZm6830qisn+DesMoBS6Zw45Zv6R8SYQw7N/Yil7sw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791869593;
	bh=doWJbh7FqialYmi81CmpvlL5mjRVCir1a9mrILO97bc=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=At1TRZZ3yNX4B54ICuoYillk5oWBlgXUDz/Wz63nIBdlcTKXk6LQRw8WfchtgHOEH
	 lQCRMWmXMpcgVrlBGCJWz/bAB9noyWJ9mXm3XDbAbrOdhUXoizUHsRB+RPT/ZtIPB/
	 aFQwFR4gqLvtS4Gk9y+5+EJRwn7oMcFvGtUiAOkHMeXsF3u3KQK9NhClShxdUykrYD
	 a5sSC/p2BrJBkMWS2s/dCpMeYlEp1CE5dHFwNDXUd9GK7Jo0ogQcADI6Yw/xV9WwVn
	 CNy/1yVZrO9rs/zEL5uiGegpBjKol2UwViu0Rbg33YC4IW+83EjiC6yqaNJUjlfnqO
	 Z0f2IQBBzVyvQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8143A80C72;
	Tue, 13 Oct 2026 05:33:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 7714D4DD
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 05:33:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 68B274008E
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 05:33:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sFNQO5sjawP5 for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 05:33:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 9E45740068
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791869587;
 b=F808H/b8AJt6aYci5UHXryuBtbxn+tD4L+v7+Ivuasw0sxymXdhoL0Gjb3a3Rw5MwfUI
 O/FnwX93ykpP5qlkxJxwqs/smZBHCeuQDtbIfw4cmzRU4GShs+7hdYf7jd2t28JSwuv7s
 jtkumqlm2zMfsFMvJXGgLpIgrtOuIF+X17n30/qp6cTUx7ZeWXlaesIWnOCH18koWyy0x
 cPK82l2QzsDD5ixeeZoUu+ec0fC5+xqnaFlDaZoiFvq8Um0aOnv8yO6Ga3CSEH1H22y2N
 kvLs2wPlMkEwsHVX83aCfzVSuJwkYQot7G3eT/4jrjOa8SeCmpqOtcav0uplvKtCNCw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791869587;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=doWJbh7FqialYmi81CmpvlL5mjRVCir1a9mrILO97bc=;
 b=m1NhKB95LzWk3vz4uxcboJwOOFoCaPQXuANap7FwUKq2Bv7lj/I13o63ZowXm9rdkB32
 5J58m3Wtlv+40uzHrsNZCVsFc1aDmUosJpgv3ALol2b39QoocUOZpBVGs3lj8TaOQbmZ/
 NRDq4ih5Cw/rFRovlLF1bFBzgWYEGxUXWC7+8cI1J6ALMtWkhQjZjuhmcyLoNY65lCre/
 4tBHL9d2s+aBxzNGPySqixItvO/wKwA+6Jt8ek0itMHtRYWv/V5iYcSTAqLDmB3eDCR4k
 U7auxt8Xgq9NLwK8WYUbakWbVE/O2eh0bUFv9YxIjc6ut5LBbu/f04iG0VG04SiJnVQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=Y7dqquG1; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=FLlSd5Lo; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=abhilash.v@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=Y7dqquG1; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=FLlSd5Lo
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9E45740068
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 05:33:07 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69D217St408988
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 05:33:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=doWJbh7Fqia
 lYmi81CmpvlL5mjRVCir1a9mrILO97bc=; b=Y7dqquG1vZUTqHFLkjJDhuycEB5
 HESgYcfnpk5i7Krxxg7eU1D7SA5JiSfCOEXv2nd3K+QXNZ978sWoKtYbQihViGE9
 dmphtkx2FP4WSfHrI8+rVsye8yD6RUSeMZEj0hJwBksTLySEP4cZB74gDHknz5l3
 UEDPDVSCKbYzHwNcOzK8D+5Y9SXMW39lP7dczrcAFAgaASz5jnFViJwom2SxmbNS
 nOcCMCS2i21ilLvXgaM1bNAXT22DGsYcIKbsv0JcR5zVMVMDtQ/0aEMiE3YY1834
 upQaMMjE/PFRlX9nYt1O+S3ydRgZyaXuL0O99PrUTGevaEJN5Ywpuz5VdAA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8wffmakt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 05:33:06 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-35cbea41088so210047eec.1
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 22:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791869585; x=1792474385;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=doWJbh7FqialYmi81CmpvlL5mjRVCir1a9mrILO97bc=;
 b=FLlSd5LoNvyTrKb6n72ile8HsbnbeUQGBV0dgf2ppEOfTIajPXcr1si4HWMd9qjCoD
 cHtSOKhpuWYNq7f5ynGSIThdrmAV1BkCfSnzKrALmBZo0zu8gp7zaoOLIcb7JEBq3b57
 dOvjEbG8I3Fl32SxjBKmP2aLMNrF0Bn1Cv9aVwaJ9C15tQ4hF1tRdEgOYNpMOjuN8suz
 pcS/+7n+aPOJSN55JEXs3K8O6rvDeQlS+wcrTmGI5awdqOWmP0nexB0LeH0zn3Xurffu
 KQDpnbHdaBUgsjQIk9zaFhiq4ZBm9zgl7tt0lVjuMDwFC9o+KISoEEBfwPBXf+xIi9x3
 PeWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791869585; x=1792474385;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=doWJbh7FqialYmi81CmpvlL5mjRVCir1a9mrILO97bc=;
 b=ImMJdZWj9GTeSL1HJW+tq5TZmpuiWO7MiJ807udHT3O3OikeKkdijBD4qWmMS0g3GB
 A9kkbM+a3hDNZdgZjPckqDOu38UorAoS14AeWBOppOPqOFuU48CnSrjML1wYw01gZ9zt
 GJnB5EY8bJ4x4+DMpGXodKwJWFFGf/hRgIpzBT5V5jP4qFdV26JOT/b4barKtLqbnxk2
 s4+3PNatn7M2XUYFbNZ/BJnUFQA/n4ygnyDGOHDbY/sIrWWYgRk1dyM2ZC1FTh8RJEkI
 uriaeqm1G56kkGL1Kot/VXq8nqJEB+rd7ajQ+Agtgba7Gl//o0ef/IZwobmz93gqoSVr
 c0Xw==
X-Forwarded-Encrypted: i=1;
 AKwUvBywaKa6fsqnLcsPCLmKB0gu9MgbDxFiwyM/6UrFMVryFhNW/otstT0shns6sXRHL59qPEq2wZM=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYITDhZZSRuYmaj6ybeC0eMuzUH2LJPlQLL0YG11+zYPsnoY9NyU
 ETlMHtpYb2gnU8oVAnOqs0/4Hbg6XAMgVPnp2nD6UAJA/lBARtngI4IOQ71OysI9RVm/jbr88Yk
 Pu9lzuOR+FKKIOPiMTzmDPaQQp7jgVvpNbD1FsqjtyAbt3Kymll+4+bAEYdzrY+LLuTomCRU=
X-Gm-Gg: AYBFou3L/Z/t9JZPcWT07P1mJN770S18JuIGsB9BBzIUgj6prf6UcyI+wX48OYgeq5t
 h9vY6ImnycmdAYjJ7Ul7GI5LQyxMNvdJOWLBbUS5jWxCEEFiOEy/wq+CGjTiKobhOdiDvEz7154
 Q9KvY8ktKAT5SakOWpNkpwp73DGOfT3HRFgU/T5jhVrGAuPvClZCIMEZOeeiupust4LucYuzamJ
 iE+7zaqvW9gKInEufh2rJexzlls0xGh7AI0r7RSQ+RMMWmFYJG5+e/dcI5zN09jVaNVZ6r6w5Tk
 dKlKOlKXvxO4udyDCWtJDZs7Fk6EknrGOC2m5pDiuuo5ILHsPCXor5k0fZuuRwK5sejLUkX1ALw
 BZGd9XMTunDt5nSe5T7y4EOA5yM9X5uqgJ1uV4AwqOzs7NXA=
X-Received: by 2002:a05:7300:881a:b0:351:29c8:643 with SMTP id
 5a478bee46e88-3537dfb8649mr19077902eec.18.1791869584988; 
 Mon, 12 Oct 2026 22:33:04 -0700 (PDT)
X-Received: by 2002:a05:7300:881a:b0:351:29c8:643 with SMTP id
 5a478bee46e88-3537dfb8649mr19077849eec.18.1791869584269; 
 Mon, 12 Oct 2026 22:33:04 -0700 (PDT)
Received: from hu-abhiv-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-353810403e9sm39727670eec.2.2026.10.12.22.33.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 22:33:04 -0700 (PDT)
From: Abhilash V <abhilash.v@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org,
 aswin.murugan@oss.qualcomm.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, lukma@nabladev.com,
 peng.fan@nxp.com, jh80.chung@samsung.com, tanmay.kathpalia@altera.com,
 abhilash.v@oss.qualcomm.com, Michael.Srba@seznam.cz, sjg@chromium.org,
 balaji.selvanathan@oss.qualcomm.com,
 varadarajan.narayanan@oss.qualcomm.com, nikroks@mainlining.org,
 luca.weiss@fairphone.com, nathbappai@gmail.com, jbx6244@gmail.com,
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: [PATCH v2 07/13] clk: qcom: enable Shikra QUP wrapper clocks
Date: Mon, 12 Oct 2026 22:32:38 -0700
Message-Id: <20261013053244.2954876-8-abhilash.v@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261013053244.2954876-1-abhilash.v@oss.qualcomm.com>
References: <20261013053244.2954876-1-abhilash.v@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDAyMSBTYWx0ZWRfX8M5Mtkc8Lhpf
 t0ny2m9l3ulEB4a91RFsTuQcYfFw1d+kvn5bfEODfKLAPRne90F4qVK9M4m0MaPw1exKMA0RdaA
 STrlwLNo4s950/wNj3PRU2vRFvK9OtKrroPK2mmBAL7jmow+CsmV0V0QVY5Xao938ZnmQeEnXQG
 cte5X25zVnKWI17VPxQeUuBtT+9MsoH9UwGtydKyaMi2mIPxJtxV8fnqLdmsruI0N+9QusSmJey
 4dvvPHyewfAnRa9rP1onR4MlbI5KQhEwC8X2kuXcxay2Vgv1dIFUfTe39oJIZtdx8QXfDqdVrGD
 6Y6azAgDIhD0KfVUdoeBZBTKkPVQDJ0jNQXjBr1oNh8pLVSmO3PjvhnWKIkY29bbuP0zay/8yig
 iXl7Rlyuf36NKk4wwERRZYQdiCeKfowz7WVGePcxUUXMf9dgPOJ7qu8lNkU21KuMBK7sl3Xu1zF
 EKMcrsmqWFLNrfhoJkA==
X-Proofpoint-GUID: F_9fBdMPolJ8zlXru-cGG4PvIV6NF1Ds
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDAyMSBTYWx0ZWRfX5tNm/VMrKYhE
 jae3RsgvqaDJAJmMmPDpNHB6Q/y25tyTLA3xMv7g8+mCRHCVTAs5ZyRazQn0gZd3ogZCBNNY3oa
 xK4sZNTd8YZ/nF0L3RLV5bsRip4JTVg=
X-Authority-Analysis: v=2.4 cv=ZcWIpcVA c=1 sm=1 tr=0 ts=6acdc292 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=mb1s1FuMAeZDaavxsqsA:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: F_9fBdMPolJ8zlXru-cGG4PvIV6NF1Ds
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 suspectscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130021
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

Enable QUP wrapper CORE and CORE_2X clocks whenever
its master or slave AHB clock is enabled. The wrapper
requires these clocks for serial-engine register access.

Signed-off-by: Abhilash V <abhilash.v@oss.qualcomm.com>
---
 drivers/clk/qcom/clock-shikra.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/clk/qcom/clock-shikra.c b/drivers/clk/qcom/clock-shikra.c
index 94501b838fc..a74d529f4cf 100644
--- a/drivers/clk/qcom/clock-shikra.c
+++ b/drivers/clk/qcom/clock-shikra.c
@@ -315,6 +315,18 @@ static int shikra_enable(struct clk *clk)
 
 	debug("%s: clk %ld: %s\n", __func__, clk->id, shikra_clks[clk->id].name);
 
+	switch (clk->id) {
+	case GCC_QUPV3_WRAP_0_M_AHB_CLK:
+	case GCC_QUPV3_WRAP_0_S_AHB_CLK:
+		/*
+		 * The wrapper's core clocks are required along with its AHB
+		 * clocks, but are not listed in the wrapper's clock specifiers.
+		 */
+		qcom_gate_clk_en(priv, GCC_QUPV3_WRAP0_CORE_CLK);
+		qcom_gate_clk_en(priv, GCC_QUPV3_WRAP0_CORE_2X_CLK);
+		break;
+	}
+
 	return qcom_gate_clk_en(priv, clk->id);
 }
 
-- 
2.34.1

