Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C27CFC88E72
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 09:19:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 876D840689;
	Thu, 17 Sep 2026 09:19:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HSqJZadC7-OJ; Thu, 17 Sep 2026 09:19:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org BB140406A7
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789636786;
	b=e74FUJgXhu5nRsW2R1O71ngQeq+uSL9F79qFsMcCJ3XnER9atD0JnHhKNSi5M5zlvmXc
	 6Q8g6Tn8nTK5svRqIG7UYKPVECPHVSujFKX/Vk4LzHCbfhBMaGOd9xdL616N8O5Z+PLXl
	 hunx0FblhKaiOo2+hZ25hmbG+e89IStLFhnM+4OLzRmfAdhqpIPYP/0u7bAwTzdBXq8AW
	 kzjb6WR5czTAoCR6BaRh3dwXfUeL4sfevj4tzYPwAVJALxC+dvjBzSeL67JkWVnBJUwHF
	 WPaeYTwgOHMJMmbH8N9qdsqsfpOn9hS0SFTOsx5qq7fc0s1z5WCv96/78jtvot4YHAQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789636786;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=0BFSJNvPmMyG65Vr4ESneLRQ7XaoYN3FkrKAQboQXJw=;
	b=LrMztEvBJbjsVC1io2SHcQSTpnMiQ4hfmg6ibjSDJ11vsdOnh/A21pd9J5G6CXcZcRBI
	 xTIbHm2jGbkMdF1OPsTVjAe3AxwxrkDtZJ0qrvfHHkzrVPKzZeNmmQZDXKV5+czf7BkZT
	 I29vKNlp+ceRxJcXnR9kZbEbifY24lM3akalUuyfeKzaENcDXE3U8f06FGWdF4RK6rYuk
	 l8jv96CGPzp2GPBgRZVTpoTRng2iABlUTacTlJzJm60ECvuqIREfba3aYVbR3WxKyNQSj
	 yRa8ntEu51+JecaIDssj3kwKFN+j3SzAcjZ5R/MKekUWe9VHoFex8qNo8izdoE2OKIQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789636786;
	bh=0BFSJNvPmMyG65Vr4ESneLRQ7XaoYN3FkrKAQboQXJw=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ro4t62lcnXtp5CBmWVD3jtOavotiNPY6itn6NiAXSIA2DBxMi/KpVQ/TCIa5FFXCp
	 oqOIPMWXfsNNnxoJyXQW0S5Nbs+loT/5KFYEcSxgXbwsFE+xfpJuoHIaJO7p7bpVTl
	 0VXGL/tKk6uKkfeThWn4sJdf4DynXrdvl+oenjgeinsQ3HOMFZrXfBLl3ZZxFftorf
	 lVw2ie8+5osulc4fOeNBOprlBrfklGxC3VShlYuMUFCm1ZyMnHXbjzoRbvYs+dX0QI
	 msim0GtO3nMeZhwCfLGGMLSEGAl2NA8Wt/WFcB3XRycMQY5pFTmzrQSV2OpWLmdX3D
	 EJTCSzzbtew1g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BB140406A7;
	Thu, 17 Sep 2026 09:19:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id A9BFA422
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 09:19:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8F65B80EEE
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 09:19:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2o2C0VA4EZzH for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 09:19:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org D605980DAE
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789636785;
 b=Dv8mHSohau2ccWMCG3UAh0GhEsOfgfoLZkBiwrFMEyFRa3XY1ozo1Ecdjke80OrKO7VU
 AkcjGEw5lN1BDfZ2DkjRcDQJ5DsY/h9S3uszG5UyabCTEztlqukZB9V1wr3BwEacHfUVs
 tfDGvfXKZExxuEdATt4UHxEqkhbkPTur/B4qFeI52DyqrkRGquA4DZdwb1XbgvH0DvNC/
 rLL3kEx6U0QtuspHzFF+KzneKaL/lOrCI+cUvVdmsClPWrsUGipzb3ovK4WSgzYIqsCnV
 sc95Ix4ubyDzlbmkOKkCm3tBSycKIMNkoo8Ql5l3jeg+xv5xzEh5sxl5d4BtEpa3QeA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789636785;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=0BFSJNvPmMyG65Vr4ESneLRQ7XaoYN3FkrKAQboQXJw=;
 b=hUFetJVzgju91Uf1MDCWKPP8b4eQ42TR27ZCtK2eT+Q+/WHzjRtIiHEJmkzJz6JHH1CR
 yFSYE9t9dJZJG/lRqnD3980stoxwMcgPoznIwzdVm5wniLhwAlgYU6EwVwLd0Pq5hQfBG
 ZigQKJeGLkjCrqT97+nSSSUm3sv5PvF0e1es2q3Godo76JlEVkQDQYQHfd2Go7Md13LfZ
 Lw8hIk3tRTCVm+R7dCx7WPK11cI3Nu1y9F/QLXUqAszPINPyH+3+MBPDl6QZMaD0PisvK
 TH/a4Pz4Qkq0NWZwmKle/kOYau6BwrQiFAqH70ZkWA+OPg9TouyvjeLInh2X5YXAx6A==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=VmqTgGpC; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=bCVamN2D; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=VmqTgGpC; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=bCVamN2D
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D605980DAE
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 09:19:43 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68H60VBC1211843
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 09:19:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=0BFSJNvPmMyG65Vr4ESneLRQ7XaoYN3FkrK
 AQboQXJw=; b=VmqTgGpC0syIJ3FZba9t+RmGlliYhHzkajDZAlc2byeb7WIlbc1
 e7jfNi5TGlxO3jImX/7rDhTTWUgME/7kZqyMdt4wzZVCeqpFDL/xyTmJHJkOSWvf
 /hPFtmQInttmQer9me9cJRXlIJGZHsN6kNph15dRg2BVt+HtFx6L0QtV8MTG5BGV
 z8CEA9evIxdB0SCad23PqY3PPed2++f8ICxQMDJedNF/o3ZZ/Yn7aXffQ6KD4+bD
 1MUPRewfmBegO4MQCeqf+VHf/43NeCW5dW1SYO6unq7VxntwUh5DLvRphuUjN47i
 JSVYX152XamjVvgIjyMykBjExrciP6fpj7Q==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gqxaybrt9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 09:19:42 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-39deb05ef51so1034406a91.3
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 02:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789636782; x=1790241582;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=0BFSJNvPmMyG65Vr4ESneLRQ7XaoYN3FkrKAQboQXJw=;
 b=bCVamN2DqbH+lnSNs0XfVcH2jAMoNugZ9AYk5Dnn6fZU+JEq5UmCpyQP1QyL5xeeWQ
 e/IY3BKVLUPxC5m2Gra77RJQxKFDPSIokJJJhV88ZQTrt5Z2Ptt/pf8XFUe3NFT5aSiH
 jumcM9jwkYsWhgLFZHzpfj9Ra58OgU+XGWcfmV/ZSkwqQQh9QJg23XkKmCqVcGGuD+to
 AnCJ6xruxmwwdtMIzmq7/ucGgFWLR+o1qWr5INaQ6rZ3MSxWfn7elYag5w4Gpcwjp8Re
 Y1ZA4kiQy+n+gfwWj9dcjn3jTld7E+kLc5P4MbnSqYEVbnVtETi789+KXfLYj7bSKQjS
 SaYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789636782; x=1790241582;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=0BFSJNvPmMyG65Vr4ESneLRQ7XaoYN3FkrKAQboQXJw=;
 b=GL3GuC9HMppxW9oLY3JZY9OmIY3qZ5d6uo39xpHn/Dr6Y8z/wQLy23Mt7aynFz34D0
 fXMe46RH+ty6mJjbm8NsgcgVL2n3ustuXPJVnjEqGRALiR5Av4q/mDXVW/85w1Qus2yR
 pyiw68mGKlwEtuGiSiL20g8J1PoA6elYHBjrGKPQpmzJ2ruAZOKxL3iIn4DLo8+K68OE
 DTqY9Je7ADN0JKUaCNSFWpC/eZuyk04JaOHrclSmdWnWr6Bhh0YY6abYyG+SOWrI2QcX
 OG5PxDDvuqcxT/jaxK0uYY77RqfCnLWARunuF6JzJhOzwegmoa698WHjMU203dH86WGZ
 DUig==
X-Forwarded-Encrypted: i=1;
 AKwUvBzVRAGslXsnpOvHGgnBNk2pBGtVFz4ohhBn0h/cQFXeV63U+BM0wcGuwmtihxXo0diRhNOkZyE=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lRJWMjTZTpy4JT2zSqOqrGp2dfO34umD485w6MoCuTa2vq7JbC
 YtsiOJmVO5BJ+jVB/RG1BGTxeWqYhq7xTh3bSE6qmdfoPKK/CJ0qFn/LqkGdwfiO4uz74907mB/
 iEny1S1t8o7fb0O28++J+Gex6jJ/oNViKngsP5amPWc3B1Rvcr8u8rg4MD0hbRcVHxILr6qM=
X-Gm-Gg: AYBFou040wNNP5fuCU2z2YYLZl+Q5KxNPLikItDOnKaAHoPU6s+JgCO5hFWH/ecH83T
 A8eC18AUHkLI7Fav225Fk+3spHWvvaG8Dre6BHGnD+0ZxZVjAAQxw//dDx1gRSoO5yC1F3Sa4bZ
 O66CtLdwYTvH+hu/+yUDmjQixlRjB3VuE7plOXebWJC3whTtjTNeaozUbVUqz5nyvvKnx6vuPWU
 B573DObhSrvaho3CUGdE85jlGrABMKDoCGOjytVuTCqdESyK57VPZ5X1eLIi+HeIBmZ1f1tu6gR
 8QWn+d6V+K6X14D/Kp540VW48dITJijJ2qs0sTwUYnZEnvkq6bvFXfJnbbhRMXHrWex3+cOgM8J
 1N88tjRSCFiYYucvcLkZ0zUY2ZoMCvtXjVzyh/Mg2L4twJd9l9vywEB33eObb+kZvVTwuTChizQ
 WqF1msZvoxSL06MHq3TpQ=
X-Received: by 2002:a17:90b:5785:b0:39d:6f12:fd47 with SMTP id
 98e67ed59e1d1-39e1e50f73cmr20489085a91.20.1789636781646; 
 Thu, 17 Sep 2026 02:19:41 -0700 (PDT)
X-Received: by 2002:a17:90b:5785:b0:39d:6f12:fd47 with SMTP id
 98e67ed59e1d1-39e1e50f73cmr20489003a91.20.1789636781178; 
 Thu, 17 Sep 2026 02:19:41 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf5b1d335sm15730580eec.28.2026.09.17.02.19.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 02:19:40 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, anshuld@ti.com,
 linux@smankusors.com, aswin.murugan@oss.qualcomm.com,
 u-boot-qcom@groups.io, u-boot@lists.u-boot-project.org
Subject: [PATCH v1] mach-snapdragon: map DRAM bank gaps to avoid
 reserved-memory MMU failures
Date: Thu, 17 Sep 2026 14:49:32 +0530
Message-Id: <20260917091932.4150797-1-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDEyNyBTYWx0ZWRfXzpwPYAx6NWT6
 iTaFTqgcDksbFb/46qb2QsimwYG/ibX5mjja0NuBLaIZ0RksyW2+GsQBbOtZEGYrPKHtoToEAMx
 dtJn1ii1idubnh36epjYW+Fxxc9cFMdpZ42hRVmYstZ8C6ihxNcsmrpoj+VlEQCp6a6g79+P225
 C5NQqSbsigBdQnfLLVV3uAO9ApkrYEjpz57EezSqmWOLIgbvGfh5CnFep32fA58BJuAnDQ/oGWy
 8GN7JI1TCkmQvZAYjGuMUI/DYTVOZx/20VrnwR81iQHyLV/41GE14RZi+TGppTtcOO+6tQSa/kj
 lQkZFcdANI5sfrQnl5g0ZfSSzrpkRay6Nn648mENBsQr3Nl7/TideOw1egxvusOpCESe1KJx8u5
 JijlXeFFJn5XOQlwfxIOAcfzB4WJ0KWc55M3+FT/m2jbBd4sWXSprNcX6NMxl8ZLbSHFfhJ2sJl
 5hWRSqnOAhbofTQSynw==
X-Proofpoint-GUID: hOHfaaf_N6eYoSe5U1kGIX6BUUIwXwhu
X-Authority-Analysis: v=2.4 cv=EoJHPicA c=1 sm=1 tr=0 ts=6aabb0ae cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=aOmuNyZN-MWBdTUAh-gA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: hOHfaaf_N6eYoSe5U1kGIX6BUUIwXwhu
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDEyNyBTYWx0ZWRfXxtWQqJD8T8WJ
 tdZhpmg0jbMk9vDsEe0HKNPlykFFbxZS1V0mY5GYQbZyxEC2TjoOXShebZfJ8FYOTy6dB7tFqf6
 Ke41BN4IW008/Sdz2eIzh0nYCBGEGy0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_01,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609170127
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

build_mem_map() leaves gaps between DRAM banks unmapped, causing
configure_reserved_memory() to fail when a reserved-memory node
falls within such a gap. Map inter-bank gaps as MT_DEVICE_NGNRNE
regions and reserve space for the additional MMU entries.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 arch/arm/mach-snapdragon/board.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
index 35735f1551c..6d25d8ea599 100644
--- a/arch/arm/mach-snapdragon/board.c
+++ b/arch/arm/mach-snapdragon/board.c
@@ -39,7 +39,11 @@ DECLARE_GLOBAL_DATA_PTR;
 
 enum qcom_boot_source qcom_boot_source __section(".data") = 0;
 
-static struct mm_region rbx_mem_map[CONFIG_NR_DRAM_BANKS + 2] = { { 0 } };
+/*
+ * Space for one entry per DRAM bank, one entry per inter-bank gap,
+ * plus the peripheral block entry and the terminator.
+ */
+static struct mm_region rbx_mem_map[2 * CONFIG_NR_DRAM_BANKS + 2] = { { 0 } };
 
 struct mm_region *mem_map = rbx_mem_map;
 
@@ -584,6 +588,7 @@ int board_late_init(void)
 static void build_mem_map(void)
 {
 	int i, j;
+	phys_addr_t prev_end;
 
 	/*
 	 * Ensure the peripheral block is sized to correctly cover the address range
@@ -599,12 +604,33 @@ static void build_mem_map(void)
 			 PTE_BLOCK_NON_SHARE |
 			 PTE_BLOCK_PXN | PTE_BLOCK_UXN;
 
-	for (i = 1, j = 0; i < ARRAY_SIZE(rbx_mem_map) - 1 && gd->dram[j].size; i++, j++) {
+	/*
+	 * Map gaps between DRAM banks as device memory. These regions
+	 * are not usable RAM but must remain mapped for attribute updates.
+	 */
+	i = 1;
+	prev_end = gd->dram[0].start;
+	for (j = 0; i < ARRAY_SIZE(rbx_mem_map) - 1 && gd->dram[j].size; j++) {
+		if (gd->dram[j].start > prev_end) {
+			mem_map[i].phys = prev_end;
+			mem_map[i].virt = mem_map[i].phys;
+			mem_map[i].size = gd->dram[j].start - prev_end;
+			mem_map[i].attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+					   PTE_BLOCK_NON_SHARE |
+					   PTE_BLOCK_PXN | PTE_BLOCK_UXN |
+					   PTE_BLOCK_RO;
+			i++;
+			if (i >= ARRAY_SIZE(rbx_mem_map) - 1)
+				break;
+		}
+
 		mem_map[i].phys = gd->dram[j].start;
 		mem_map[i].virt = mem_map[i].phys;
 		mem_map[i].size = gd->dram[j].size;
 		mem_map[i].attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) | \
 				   PTE_BLOCK_INNER_SHARE;
+		prev_end = gd->dram[j].start + gd->dram[j].size;
+		i++;
 	}
 
 	mem_map[i].phys = UINT64_MAX;
-- 
2.34.1

