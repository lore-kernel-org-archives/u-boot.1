Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37116CA601E
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 12:27:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 273F740848;
	Fri,  9 Oct 2026 12:27:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0sy4Oa9oCCAq; Fri,  9 Oct 2026 12:27:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3FAD940835
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791548877;
	b=dOHbhLdR0yLonxT/sxPHn9qyZVxqcnttzrdb6PyOnRHd90+PVWDrllaN/7UCNR0+C+n3
	 bGU7Qu6mH7nUklqM5r30wF7l5DrF9Ft7WV459jMC3lrklSCrM6dAcF8i2FRKJ5ewznwFj
	 DqJNRt6ZMPxW1UTXjA79jK3HEsBXTR8HMgncx21sWQCDyxTlM2hM+tUVG04dtzQLQgXCP
	 AMRTewPNPINfu1AjzRe+9aDqFgdWFNP23gtL0712zWS5sHVw55ICUKuAO9ENzsMZOiSae
	 oJR88NyRGLKWlqbjYxDoZN8G57eAf8CcdKzfO3o3ClxscDWc20dTQ8mq9b2K0dzSlDA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791548877;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=2NSkzE9Ze2EXnoGrHtCgQRP6JlNj7J5ROcl5Ff7heCg=;
	b=Ex8xPGUJlwU6/p+HgEGs7qKE2ggfME0tmJQCDTM+Zz88AM42pvpqdGV3etV0ZuJDN+VO
	 7zTbCuGczQtVec49RmwJrhx9QhrUdfjoPfo+RPy9632UHEvAEhoOYdJrTMf2n55uT3swD
	 XHqw6HMGcoIGTLErkFrK/XjigptheaakNAyFuFDL/o2X8WLtuIJot+1qdYWqRM/KbH+hE
	 gNRY1u8J4bBGXfSyNEPPhK3k005/yEfjI+61mSSKUgMCDVuq+xu7pJKz6E2gSsMvwZWRE
	 DXQHDhLKZ4o1O4KjsdFEoaD5z+46NJ+g2X3dz12SI6mYf1t7YODruhXekgrH2Fnap4w==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791548877;
	bh=2NSkzE9Ze2EXnoGrHtCgQRP6JlNj7J5ROcl5Ff7heCg=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LinZ79JSb0lI6yF9Y3xJAC1XdLd4gjsnGcWTmSKRG+OWpog/XPFnaZWDUS9GOf5ny
	 rtrBi1PdKZtkbDPU6cr+4WDl+CHtFGKo+B5Q1NHTCfN+633m5ZPu+Fs8S9Z1YxLBDG
	 PbIKIZTJLZM1TgQy52lbvnAF+MhjTbVEfkge9OkyfM2y4MSiN7ilIiAVAIKYeeKu0J
	 Zxl/ITwYoWdSo5YAk0l2RLraZgj1tvXz2KNz96lOf4tXtOYLcyZaxJ+H7pasNiibM4
	 H4mKNbouOHz+u/1AS49I8Q3GaCtn8Wg+jPISWM48SZ0A+Uixl9D+wj87GicAm41Zy6
	 43H131achVbCg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3FAD940835;
	Fri,  9 Oct 2026 12:27:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6729075
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 12:27:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 592F040098
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 12:27:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nXfoc2BM_O1a for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 12:27:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 82FAD40061
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791548875;
 b=DfVcCD3EyUPK++2A8oxZ7ZsuLPzBG0R7IF8iSWN/RqdFzAVCNXqGI/ElsHT67kH+kc3l
 h6P3JkMIsHxCUmnKto27MP420Ral5aF5a7wRgQvntBjU2X1NY7Wz8tR4o+SxcVGWZx8le
 /WSRwHMWOrFuatnapZLoP0tUPQ2M+2z8dfDstQjMDWxoFlAAky0N3N2iW9AGaCwL7vt1K
 ilfChYn8KqRvShmVfCxzk6oKNZwPk1FfsElhWkU34R6A+daLBqAGQ4JsgV5EufquopOAD
 DRoU3VOQVaieiFID9aWBrSOGzfR2pGQSuDTU1RiDTn2KBxyVgWGnJCbyiyX1J55Mkyw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791548875;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=2NSkzE9Ze2EXnoGrHtCgQRP6JlNj7J5ROcl5Ff7heCg=;
 b=sfT+34XhUPn2Ag1EyOOLidqNEJ8+ZlZ8RbEjRDrlnjCb0qBUswoP7770KAqC9oNCi5Ao
 w6F4Tr0tL3fUa+qub9AkJ1fKIytmOOBh03T3CzjdrQEd/RNCBrwjTTnu9rI2aSO8zHrin
 wpYrrByfv/gALCiTvEo1e1kCIT1R/F+dNZbBaZC9s1hxFWj3QDtKr2g0OX8tCDVE9xgK8
 QFKYvI2Hv2wO587th5kt7Cw/PYR8b0m+ojpTDWRXRJ9MlNDYR+GawK+p32Ja+sakDrAAl
 DGoYV7vqov32Sixq29J0ExBZcuGuHFqbrHC+Ix2HRzSwT41GYoy86ubhk3C/sAf0jIA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b="S+E/y9BT"; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=h+6ufm0S; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=badhrinath.s@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=S+E/y9BT; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=h+6ufm0S
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 82FAD40061
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 12:27:55 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6998KJDn1746859
 for <u-boot@lists.u-boot-project.org>; Fri, 9 Oct 2026 12:27:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=2NSkzE9Ze2E
 XnoGrHtCgQRP6JlNj7J5ROcl5Ff7heCg=; b=S+E/y9BTkw+ulgLXKpMlscrebw9
 hIi8xK7RznmwI0/a0986UIOrLdZp0bgrB79XL2vUQTTxJBFzJs8sPnX2nSxl/Z24
 61g7c43+/eqDR7XQeebyi6MZ+LpS1tm/OuoXfQUwJdfjUEoJ5atIFtCLUbE7quu/
 K3YmhNR7B4hhdcUSfpAFjsgw2tC7qA415pPG2+XjWeMezY+leFM0Jz6FJinRsy3b
 VC7QL3m8NNOtFNHLgHGfUgM2k/zEXAVtGx9d9aqUVZ+xOLYzQdgPFiL86eFNc/NI
 ix6YZ9m9xPboB+MDJKH5u+FsTGgNZl7nS1WVPJzA6W38Sx4xNC2SkJVAdwQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6ekvbtck-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 09 Oct 2026 12:27:53 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3823dcc1647so5173270a91.3
 for <u-boot@lists.u-boot-project.org>; Fri, 09 Oct 2026 05:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791548873; x=1792153673;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=2NSkzE9Ze2EXnoGrHtCgQRP6JlNj7J5ROcl5Ff7heCg=;
 b=h+6ufm0SlYhrhbWvXBK4JoAujFzGeiZVygd90MJOBEGwkCPwuSfAff9S+aVi/LQnef
 TLYCvZFRSNpAmDAtV+TOwRQSZvtbWTnXWQ7n5y8DD1e3b7iSz5IHz9irQc83RmTKQ8PA
 Dx639gexLSewmY05mWNV0kQfYqsgu5AbC1SJxGzWkTBzy+TvPsAEF7+UHPutAVKO8jWZ
 ggui5hzKqp4ngk+LG+1tU86IfRAde04weR+JvyA/bsFasKcHpc5Dki3Iy6wKWoRaZiXm
 JrNtiXoKeB4CE6YlG8fYLvV6GOtMD5hNCCKBSLDgeA6KO4l9nB+2f/we5H9Nmj+bZAYH
 +xUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791548873; x=1792153673;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=2NSkzE9Ze2EXnoGrHtCgQRP6JlNj7J5ROcl5Ff7heCg=;
 b=HVTfl0BIBSmMib7GPWkfxSGTupH0mPlgdwGZnWrxLz8ZYZqWS9HIe9EJlnmYSb3N6w
 OQP+SZbf//Agg16lEHNXSzD9JqdBJm1U2wlf9r+4+ZI27xHS+IRDQRd58dV0Esax3Izv
 3rU37EZGRyYpBMy+X1Pak7yA+KAn0rGHclq/pcdzoasQXnpEjrCvLc3ekENyMHiBzoth
 h2QUoUb8B6IH19/Cw7Hd7x4+xJFS7TG1G/GW3A7MzIr2ATpqRXG1Y4fTuB4rbiVNZZJw
 iMJq8eEhJAkUeJA3AYEDHCITnL75j9mR9RE15XkxaOeQJIX0rDxs/aruxXJS0C1vNaGD
 zoww==
X-Forwarded-Encrypted: i=1;
 AKwUvBylt1tBvQxsEHw/j+AWRqQTx6EEiM4g/l4hKEsIu6/kSXWmHtORD84e/kY9LJdiH5DAKdSTknI=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYL+k3Tdji31TNRcnprwpHqraAYdZeHFhC/4pMG8hGX5vyJW8oVW
 bILPz1lrnukq3Ps9l1GfQGUcb6cU5UyjTVKWZrwJyRBKm55Bz5Woi3vwA64o/JVMa7q5KD/y/cU
 jQnPiLurHfocw2H528jGa+5jJnypxErDSugxXwlN2ySVPgionsFrjuwrOwI0OWOj3OkDU40dqi2
 IXGlQ=
X-Gm-Gg: AYBFou2b3+74Dcqve8zkUXSyT0yH1T810eHGCDu99aIXQLHrY0as3G0rMJJEF5Pw5Vd
 AlO+x4PhyXxjulHcEbpyBADPo55mLsP7l5xOVUHrIN9QxvL4srXe8x7MjXNRM29bBTHTA3bQhrW
 epY0C7a7PbaxqWAI7cc3WvDdrMLO8uAFO8JDb5+4ND1kXZHEJSfdWILpuUs45xCDWuUM+xC6RXZ
 39uHLGN17YPI3Bn+5kYDos0Azkn78dWBjpgMmZZ3KrBH7gyxpx2OZqB/GKxXXC4ak3BYm6d8u4g
 GhybXzqeYdCNrlG7eXI+7haDLhmKdhbAtKvzRcUS1GPPfhvWjjr9xh0fmC49oyF9NN20StBIJmD
 9R5FCtrKvaqd6jTT6nONTPagO8wY+awqGBTE+Z8bJ0ys0/cwaDZyc3g81nVq5MECVwfV1Wegz0X
 nh60hTPMgVu/wHV57k0k4=
X-Received: by 2002:a17:90a:d605:b0:3ab:3131:5c65 with SMTP id
 98e67ed59e1d1-3ab3a236c8emr1604903a91.8.1791548872495; 
 Fri, 09 Oct 2026 05:27:52 -0700 (PDT)
X-Received: by 2002:a17:90a:d605:b0:3ab:3131:5c65 with SMTP id
 98e67ed59e1d1-3ab3a236c8emr1604863a91.8.1791548871719; 
 Fri, 09 Oct 2026 05:27:51 -0700 (PDT)
Received: from hu-badhrina-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ab371b2f2bsm3399497a91.15.2026.10.09.05.27.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 05:27:51 -0700 (PDT)
From: Badhrinath S <badhrinath.s@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, peng.fan@nxp.com,
 jh80.chung@samsung.com, tanmay.kathpalia@altera.com,
 lukma@nabladev.com, badhrinath.s@oss.qualcomm.com,
 nathbappai@gmail.com, nikroks@mainlining.org, luca.weiss@fairphone.com,
 xerikasxx@gmail.com, jbx6244@gmail.com,
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: [PATCH v7 1/4] clk: qcom: Add initial Clock driver for ipq9650
Date: Fri,  9 Oct 2026 17:57:33 +0530
Message-Id: <20261009122736.1185878-2-badhrinath.s@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261009122736.1185878-1-badhrinath.s@oss.qualcomm.com>
References: <20261009122736.1185878-1-badhrinath.s@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: wdEBYm6kk-NtzLpTQ0w4htF2dxMrDJCa
X-Authority-Analysis: v=2.4 cv=csYOAF4i c=1 sm=1 tr=0 ts=6ac8ddc9 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=DB69gxYeUc8pAmpVBpQA:9 a=c0c_lspPfvi_Ll8o:21 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA0OSBTYWx0ZWRfX5XoKNtDTcPiW
 RYw1PX6wMBQiEmDr5R0ekwdT68z1srYGXWh06eDq+9zrIR6/20o4BtajQC3D2OtF3C96i6aodUJ
 bBNigvo5g6AbjIs2v+ViIJ9/098p7oYHeYNBBCPJPhUwAi4qyeB4nNKD787QvQOG+FVnWfl9Tbz
 HuJTovEg1LxTTkPApnihqiNRViQl/pMTLliOmmzjbXEk30rWlzE1c3yjMlfaXSacpxa8MoN7KK7
 7zVGZhU9Z+P9Moe0diS07gmND1Mq+buetplDRyTMZzckINQmgoQDS5S0ea3lECJpjxi5Kc8qNE9
 LcsV+uPGPm432QStZ8LVTzPiZSMPWcY29XJFszkb2aCO98XEmzeej3gakOUQJzLI2OzqGXni3uh
 YV1YF0m++n0JGinSuTdpSzu5vaJuLMYskfNf9VEVKeykN+hQyNlqCzEQ/xHa4rts2jF8rMqgOA9
 GrpvScC5hIT7BN5qKww==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA0OSBTYWx0ZWRfX1Yjr2YTmg5SS
 S72EnzMlPHQ6ucGSGnps28c8KZ54HRNVRfD18uAjcD8ApvUsAJoL4GikR6qOjc22qjmt2SOjIAj
 dYhx2FDzqcfo06D7/RhVaCbQ8zT9br4=
X-Proofpoint-GUID: wdEBYm6kk-NtzLpTQ0w4htF2dxMrDJCa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_03,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 clxscore=1011 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610090049
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

Add initial set of clocks and resets for enabling U-Boot on ipq9650
based RDP platforms.

Signed-off-by: Badhrinath S <badhrinath.s@oss.qualcomm.com>
---
 drivers/clk/qcom/Kconfig         |  8 +++
 drivers/clk/qcom/Makefile        |  1 +
 drivers/clk/qcom/clock-ipq9650.c | 93 ++++++++++++++++++++++++++++++++
 3 files changed, 102 insertions(+)
 create mode 100644 drivers/clk/qcom/clock-ipq9650.c

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index 95b650831a39..1f4e1635d7bc 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -47,6 +47,14 @@ config CLK_QCOM_IPQ9574
 	  on the Snapdragon IPQ9574 SoC. This driver supports the clocks
 	  and resets exposed by the GCC hardware block.
 
+config CLK_QCOM_IPQ9650
+	bool "Qualcomm IPQ9650 GCC"
+	select CLK_QCOM
+	help
+	  Say Y here to enable support for the Global Clock Controller
+	  on the Qualcomm IPQ9650 SoC. This driver supports the clocks
+	  and resets exposed by the GCC hardware block.
+
 config CLK_QCOM_MILOS
 	bool "Qualcomm Milos GCC"
 	select CLK_QCOM
diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
index 1adca029b110..eb5686cec311 100644
--- a/drivers/clk/qcom/Makefile
+++ b/drivers/clk/qcom/Makefile
@@ -9,6 +9,7 @@ obj-$(CONFIG_CLK_QCOM_APQ8096) += clock-apq8096.o
 obj-$(CONFIG_CLK_QCOM_IPQ4019) += clock-ipq4019.o
 obj-$(CONFIG_CLK_QCOM_IPQ5424) += clock-ipq5424.o
 obj-$(CONFIG_CLK_QCOM_IPQ9574) += clock-ipq9574.o
+obj-$(CONFIG_CLK_QCOM_IPQ9650) += clock-ipq9650.o
 obj-$(CONFIG_CLK_QCOM_MILOS) += clock-milos.o
 obj-$(CONFIG_CLK_QCOM_QCM2290) += clock-qcm2290.o
 obj-$(CONFIG_CLK_QCOM_QCS404) += clock-qcs404.o
diff --git a/drivers/clk/qcom/clock-ipq9650.c b/drivers/clk/qcom/clock-ipq9650.c
new file mode 100644
index 000000000000..29c0c3fdf49f
--- /dev/null
+++ b/drivers/clk/qcom/clock-ipq9650.c
@@ -0,0 +1,93 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Clock drivers for Qualcomm ipq9650
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <clk-uclass.h>
+#include <dm.h>
+#include <linux/delay.h>
+#include <asm/io.h>
+#include <linux/bug.h>
+#include <linux/bitops.h>
+#include <dt-bindings/clock/qcom,ipq9650-gcc.h>
+#include <dt-bindings/reset/qcom,ipq9650-gcc.h>
+
+#include "clock-qcom.h"
+
+#define GCC_IM_SLEEP_CBCR			0x1834020u
+
+static ulong ipq9650_set_rate(struct clk *clk, ulong rate)
+{
+	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
+
+	switch (clk->id) {
+	case GCC_QUPV3_WRAP_SE6_CLK:
+		clk_rcg_set_rate_mnd(priv->base, priv->data->clks[clk->id].cbcr_reg,
+				     1, 2, 217, CFG_CLK_SRC_GPLL0, 8);
+		return rate;
+	case GCC_SDCC1_APPS_CLK:
+		clk_rcg_set_rate_mnd(priv->base, priv->data->clks[clk->id].cbcr_reg,
+				     5, 0, 0, CFG_CLK_SRC_GPLL2_MAIN, 16);
+		return rate;
+	}
+	return 0;
+}
+
+static const struct gate_clk ipq9650_clks[] = {
+	GATE_CLK_POLLED(GCC_SDCC1_AHB_CLK, 0x3303c, BIT(0), 0x3303c),
+	GATE_CLK_POLLED(GCC_SDCC1_APPS_CLK, 0x3302c, BIT(0), 0x33004),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP_SE6_CLK, 0x04018, BIT(0), 0x04004),
+};
+
+static int ipq9650_enable(struct clk *clk)
+{
+	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
+
+	if (clk->id >= ARRAY_SIZE(ipq9650_clks) || !ipq9650_clks[clk->id].reg)
+		return -EINVAL;
+
+	return qcom_gate_clk_en(priv, clk->id);
+}
+
+static const struct qcom_reset_map ipq9650_gcc_resets[] = {
+	[GCC_SDCC_BCR] = { 0x33000 },
+};
+
+static struct msm_clk_data ipq9650_gcc_data = {
+	.resets = ipq9650_gcc_resets,
+	.num_resets = ARRAY_SIZE(ipq9650_gcc_resets),
+	.clks = ipq9650_clks,
+	.num_clks = ARRAY_SIZE(ipq9650_clks),
+
+	.enable = ipq9650_enable,
+	.set_rate = ipq9650_set_rate,
+};
+
+static const struct udevice_id gcc_ipq9650_of_match[] = {
+	{
+		.compatible = "qcom,ipq9650-gcc",
+		.data = (ulong)&ipq9650_gcc_data,
+	},
+	{ }
+};
+
+static int ipq9650_clk_probe(struct udevice *dev)
+{
+	/* Enable the sleep clock needed for the MMC block reset */
+	writel(BIT(0), GCC_IM_SLEEP_CBCR);
+
+	return 0;
+}
+
+U_BOOT_DRIVER(gcc_ipq9650) = {
+	.name		= "gcc_ipq9650",
+	.id		= UCLASS_NOP,
+	.of_match	= gcc_ipq9650_of_match,
+	.probe		= ipq9650_clk_probe,
+	.bind		= qcom_cc_bind,
+	.flags		= DM_FLAG_PRE_RELOC | DM_FLAG_DEFAULT_PD_CTRL_OFF,
+};
-- 
2.34.1

