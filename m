Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1B55CA5FB1
	for <u-boot@archiver.kernel.org>; Wed, 30 Sep 2026 08:34:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6E71340841;
	Wed, 30 Sep 2026 08:34:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4aW8e2rrhII1; Wed, 30 Sep 2026 08:34:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org B15BE40849
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790757239;
	b=KqiY8QLhgY43MGxBm21R7OKAf9xlYRuYMtVGRm15fCSbnaL4O0fa+W9pb9UxZQNKXztm
	 BU9MkAiHvcFORdsSyn6JZEmmoaADVh4KgYDw1YM7pBVwCHHaHlz2sGuo8akEZO5AFPA1i
	 Qs2bH5EYUW28Mlq6ZLLkktSWgvzbZ9JpZPJu14bcWAHzBzdrZ0tB3jnFEIYCUUfLpuJDA
	 6FqxaYRPrbb7eQ+4jw4Gin187qvPodtAZtKAw+yD7lDiOxNTaSi7VgijXmX0cC/IrtMUJ
	 OcZ36aHB7bv2jkevS0G1P+0pdJJHUHF1BkeW0LYsyoqgmMofesAG1pUVKo3RHVLFNHQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790757239;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=mLO5cWWMKt9fbumMRGS5XNMud0yKKjqKdQP6XXY3RjY=;
	b=so81IYuCkoQC7uyJKXrervU/bKlP7e3lJWTTAA5nwmzriqhbk4BZY+b2KzMC33Y1f9wJ
	 VOcv32vxr7PQXeeNGup7T/79ahJ/cK38wXQs2LLkh6/XDInx99u8ELLdCsnVxCJKKuBdZ
	 ddjIm01dw9j6d2gTYzojngyRvMn5hrXJ3H2LTBwVaSOsX1iNaHzgdtVmuszE6/H9JMMem
	 KGbwFu8txuky5j+GtaJ+H4+UHruOLD+5ZXxTEG6kHCg2Mk7ipX9qZpJcdPj2OUiHmYmdL
	 YDJ6O5znh9ig2coqX2CcOOVuJkksV9ZLs4XfC1rHTP2pULyxirgVHzQWIsnaGboGEhw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790757239;
	bh=mLO5cWWMKt9fbumMRGS5XNMud0yKKjqKdQP6XXY3RjY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nabeLq3F5l9Q+y0yn+MV3/K3SF9wRL7sE8xmZq6OrhwPX5cHp8Wapmf+ZsqElE5tb
	 pvvG+81+IwYdZyQYItMEWrAkXlZbORWx+KJb/tSwRm+Ula7p9oNEU4fesWQODEncEA
	 o/TZhygTB/P0mzDDV03iiz8O0nG8MF69iy9sACNSJDi/9zMtrR+NRk7pdPimtwHNPJ
	 34idRC2RLeBZ8YP/22jRRsWAZOLLTiD7rIr8Y8c/Zvl5mCr13VARY7uQvehe+Zhots
	 KIXSYFCrZtxhN+K7ZBas/80jaVoOikpbLKhncD1dlLjcsKwOAkwiUXD/2zneRqOhTo
	 0XVY1bTnplw+Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B15BE40849;
	Wed, 30 Sep 2026 08:33:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 340B33D8
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 08:33:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2DDFE60814
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 08:33:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CPJ8N_TwJPpM for <u-boot@lists.u-boot-project.org>;
 Wed, 30 Sep 2026 08:33:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 681BB607BB
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790757237;
 b=lTYZDMdIopPbsa0OYTQ6SR1oxrg7COXA82hi02j/L17KDogLy6rHtHExQghjxw4wXFkA
 FG2UCEuBapAohT39b5Wwwhim9p999KKj4EyN9cBjU2gYuwAOwnC4JXo9xxazofILcO2Xu
 3AeUNY2090AgQUfjHvLMWMvELAVn5SZPuZT2veJ33dpUDGib50e0J0qOQnEQTlymgK56d
 Q2Mykpg1gpO5zxXkHg624CgRrjkIEtWHGyAvP+EEowsTWNtKNUdhjWk1AXGl0HZJ7o5UI
 DwZXeyZVLDsRI/ozLuB9c1qi1T7zLYHLJVz2+dcRdAVE7KYeQCNXhX/+cIlYu4/+kqw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790757237;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
 X-Authority-Analysis:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=mLO5cWWMKt9fbumMRGS5XNMud0yKKjqKdQP6XXY3RjY=;
 b=nZn58+y/ZW1Yuh8UXUY8FFb3h4cfxkOt9S0LgLKHcSHYTqYbwK6EA9yk3TBpqzLbKkMT
 66+XzgMJ4ZUBM8+hQqwoWq4s3GHhgWHGCQK73IQjVQg4NwWu7PaHx8Dy6trs+uQq8PRPx
 1tqQJ89gp7Y7RVxQaIP6VcNqMhyeQykJB/lBmwAKVHVi3xjcCfwpWYeaLHi7amq4YG9YH
 5lToFBXaQGXPSeZXIGl8vIPPrAg8f6KMJHYVp++aJMsnjpcdC9ZsUYWmdq1/2R2bMHb5Z
 RtKbQuJ8eI19LT/UeLuyfESZqVGMdTysWYmR0DNIczLNkp39sBO9Fe+480OUGpGPE2Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=LYx1MQrZ; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=OaizBxBR; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=sumit.dhami@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=LYx1MQrZ; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=OaizBxBR
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 681BB607BB
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 08:33:56 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68U7dVkT2119170
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 08:33:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=mLO5cWWMKt9
 fbumMRGS5XNMud0yKKjqKdQP6XXY3RjY=; b=LYx1MQrZFgJiXwa+fmsD+M+H6tk
 1WJmzT+xt8LYkQ85Iso3c/3UkXakCFBo/qn6WG5l5EaFRI72aEBmOBqGlbU6SiaV
 LyBFA2/J9kLpx0ko/0fO7wbBCtMg0JgRuP/zm/TQ21ADhAipi2ikPPf1VVtoXyCf
 sahON7wvz0+BihpR/zTnLCHW0nx24LhYIfrbZXyvBUrDPFmxzdBs7WZQnUAYM8V1
 A/JxLlznczoJmTSO09wSD+/fispTPtBl0XhiQvy8dozFpLktSiHpa/aBCP7en00E
 rZaJm0udlSs67D123lkTRVA127NaY98N/1Gi23mGTo7TJofSmo1Ep3/uRBw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0rhehs8v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 08:33:55 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-30c0d568830so10032096eec.1
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 01:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790757234; x=1791362034;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mLO5cWWMKt9fbumMRGS5XNMud0yKKjqKdQP6XXY3RjY=;
 b=OaizBxBRJAlbaWWEHbhFqAGEK6KTRcMOB+CvmRxNjxRjam6Q/C+XcpgUgHn0PZ7LdZ
 tNoOOrnWs1Gl5Zxry7Lb0YPEbzECm2GRXFm0YsyLKjSw4cVzZCfyrEeDz2ldZxcPmv2Q
 X1m+50Q+cNVTf+Wo+eJObXtQJ/o6P86B4oJgl4mWU0I+XJA99xsL0M9JZTib1rNXzlCU
 kiVgDH0+0Lfy0h2me3ZzlFP0xtJAk/nnMArZV3ZXNO8YfGGQIjIh4hAQ7lNQpvutd/jL
 /obGshz9s3G1IX7GPeL6iDhAVU7XdFYmalSGRo7ol5wrQ7pgJXqkOtJmXD7UWCb67Tlv
 O5ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790757234; x=1791362034;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=mLO5cWWMKt9fbumMRGS5XNMud0yKKjqKdQP6XXY3RjY=;
 b=e174bsptWjXW5CC8EbOAz6SCxpJxwrnqSC/+02IXcXD5zAXmAOGOX3ZZ4dGdHhL9J7
 L21GrtiM0BcCjgkP0ZrOIt2Kt/dk2Uax0ZEUfujPUr7FI3nRqTAnOstQuQvseO8HpCCw
 +OJLTymAfHMIzsqm2AFTW4PBA7hQbAMRG1TC/cdi17MbFWFONtXc78/r3CKjbrx5+DVb
 nFFBKVq91RdK/aKRUTV0QIFJXjOfd7dEPCsF3ZJOwWx0LX+1CAjMjBL1gd5OYfLkk2Q/
 b4l1Sd5ULMtsr4ik/ZO5DhIrih71aUwSemJTiHV7lXF9JBURLFhx+0Ba33eW6E+6z/Jw
 uOPQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBw2fJy5p+rF/sMb60RvqHTEihqfzEOHHrbH0FcKGIeCqaGlBxtd10KLd4O7H01dYwEVqHfqZmI=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKOAgTket8T5um660gy1tlntt4CRsjba3ttov8kE4p3wsV7WtAI
 Oi2LcmXZC1kutZSqsq8/fHELgEbChW8rCm3kuf3JIUBM1BN5+Zpid+XSnH2MoanIrJm0xb+Drn2
 gNysK0zXhrGptopTh6JbicQqqGVMRJRnnV83uHbYmrlFZs9kY1We4sWPXYzQErBCqblPrZpQ=
X-Gm-Gg: AYBFou0UNh8guPnv9eKZ37JNNLfGLloaS/br0cyhB3/DRiRD0CDmFG3iZj5Dmh+4Sbj
 r7OO8AxRngmHgxKZ7v1L75NB825SV3LmGYVPORYPzVbEu1ZBVGnfDxJ0EsVA4sov7ecdi92q65W
 ENrTmsDk05ES718on9G9DdnU5X2dIhD9RlmV4zObNNgdWhzHkLPS2QG37kwd2SDPlBb5IAFCJ5S
 eYDn2hW60nXIs6lIYVbYlH9t4hocvq2ilk79B1PSj/ga+E8sW555j8V3zc/VuKdWZ79skz3l2jT
 YTj4582fvDOdFTV/H4APKws9j3pLgP7g2C1G4LU7ccDoBcvdCehdNxC9bUni4UNasIEZsMIreTP
 o5Pulds+DpBosMAWzQe2xpphIC8mJnRJu3sEYMqT2svcfC8SPCHvgZKTXEmBEOTTJMXMZrOPVgF
 wgn7Zo+traAHJumUM=
X-Received: by 2002:a05:693c:4154:20b0:34b:c0ff:765a with SMTP id
 5a478bee46e88-34cd60f821fmr1065242eec.0.1790757234258; 
 Wed, 30 Sep 2026 01:33:54 -0700 (PDT)
X-Received: by 2002:a05:693c:4154:20b0:34b:c0ff:765a with SMTP id
 5a478bee46e88-34cd60f821fmr1065217eec.0.1790757233672; 
 Wed, 30 Sep 2026 01:33:53 -0700 (PDT)
Received: from hu-sdhami-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34cf5e423fasm2580119eec.26.2026.09.30.01.33.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 01:33:52 -0700 (PDT)
From: Sumit Singh Dhami <sumit.dhami@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org,
 Michael.Srba@seznam.cz, aswin.murugan@oss.qualcomm.com,
 balaji.selvanathan@oss.qualcomm.com, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Sumit Singh Dhami <sumit.dhami@oss.qualcomm.com>
Subject: [PATCH v1 1/2] Revert "mach-snapdragon: Kconfig: fix duplicate
 SYS_MALLOC_LEN"
Date: Wed, 30 Sep 2026 14:03:38 +0530
Message-ID: <20260930083339.351584-2-sumit.dhami@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260930083339.351584-1-sumit.dhami@oss.qualcomm.com>
References: <20260930083339.351584-1-sumit.dhami@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 0uS9O4jX3_KcFB4EPBT1rpIZXg7BMneF
X-Proofpoint-ORIG-GUID: 0uS9O4jX3_KcFB4EPBT1rpIZXg7BMneF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDAzMyBTYWx0ZWRfX5xgyq+szFAMJ
 TeFKx8dmp+M97zg61nkosp6b85mvvFhYqR+LtF2QJExE6sdo6ZbUI7g+49mDlb45AuCa1l5bc3B
 FcM11AXJRZVXsTg9kK+8QkhpElXQHxSY68if/GvsAcnms92of8Q9xAEa1dlcwr+rZSYaFliOzWA
 +hLc/K0+ixXU0/d3929PyqQeRYpV/OMQUyK5GcH9WRFm4MRuqYaXYX/GLYLFoMk42wc03g6p0nu
 QSnNsqTGloTF9feablocF/DLHiqyOhIHlAldbGx8np0GN4sEF1zgIWIQckzerfjknRbTgLNclh1
 YT3AB/yulQF4vKiQTwCMUcfcc1HAI3Lj1GGOhRvCd+xegmsQZHDAXSsXpILZAz98LaIbv/ZX3i6
 hl6nkI4klwqrinu669SYJCafDRDSVoihpqGhOXSnT8kBR2+p6ab8KGuY6zmuVAJkXGKvazRRuXo
 eROQDNC+zF7d0WxsY2g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDAzMyBTYWx0ZWRfXy1VWrM4B/PmA
 mOoYl+DbtqWrNL3gPcu1EfvcIhZ1F9lunLZlgaIS0d1VqvNbZFjVH/23cuzjfma1LlggWPFEesR
 g4bXNB/RGr8gsIc2nEYoGCihrcZ7kl0=
X-Authority-Analysis: v=2.4 cv=Tu1zFzXh c=1 sm=1 tr=0 ts=6abcc973 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=xrzjpn_8Mb7bfCBL5SEA:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300033
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

This reverts commit d3463a9ffcc685210cf305418582772c4b0253fb,
which cause "Malloc failed for: CHUNK_TYPE_RAW" error in
transferring large images via fastboot.

Signed-off-by: Sumit Singh Dhami <sumit.dhami@oss.qualcomm.com>
---
 arch/arm/mach-snapdragon/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/Kconfig
index ceebd679651..45665eed2c8 100644
--- a/arch/arm/mach-snapdragon/Kconfig
+++ b/arch/arm/mach-snapdragon/Kconfig
@@ -11,6 +11,9 @@ config SYS_VENDOR
 	  Based on this option board/<CONFIG_SYS_VENDOR>/<CONFIG_SYS_BOARD>
 	  will be used as the custom board directory.
 
+config SYS_MALLOC_LEN
+	default 0x10000000
+
 config SYS_MALLOC_F_LEN
 	default 0x2000
 
-- 
2.55.0

