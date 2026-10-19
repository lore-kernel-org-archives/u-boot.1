Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D646DCCF2D6
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 10:50:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8DE3580F28;
	Mon, 19 Oct 2026 10:50:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7JuFGqrojSjB; Mon, 19 Oct 2026 10:50:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org BB81480F82
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792407045;
	b=jj2BqnTcXXTP4l4kA+uOTaa8fHC0iUpuw0vDo4U87eLMb3+DDcsBITrQhRCUomAN1u12
	 Mc1GiR03QtpzwaWHVxRFHmVt+b5svA0+npElyi7C1zEl5qmBO/WSe8x6WHpHqQbTF+YcK
	 hpuojeJCPF2K5IvyebV/ZCuYlVUJcHWET18EmehnApiRaVdRXX09k6czHRZXqDNefXm48
	 TaT3pv89EQkJyFE9BkXsosDt7LQmhdx7Ju0FVFqqB8Nx5jRuvnDvugYyfIYHUZ+GX0D4R
	 amSN6DRzXBNKO2V+4zMOOt4RuGO56tYXI2YEr1SAJ6/CWJNBlqrsblvGfG5EDLAibRg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792407045;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=GKS+4ORh5rym3JOK5atn5pTWycStajthwhQPTurM8Dg=;
	b=Auey0VLm6rc+KmMr/2pBdww3sz/Sjr6wAv0uDy4XkRj3rOe8pLVjN4/yqaKGESahm/Aw
	 pg9RHEI85+aYfLSJKmGCWCA/nWrb4W+pDceOLL0TCg/VXyEiFdj+CTmxC2xNiGF9xpNLR
	 trs4yQGw+LzoUjg462ZFX2a11E/mYb0vwhbAFM/aBOmSef2ZpaCTmiuRt3vrxDcaAp3p/
	 VEerkRtGwKhvTIHlde05jmjL89GoM5KOTpXsX6IaUS5B+cyahKuNega09vCyYi377Emfx
	 2dDK5lQe35pAX3jlO3awvyoYTlDoMs0fUiKWSCjkOoq4GFnJ5ndbY7uSMp7XcgKMdmA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792407045;
	bh=GKS+4ORh5rym3JOK5atn5pTWycStajthwhQPTurM8Dg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vmTEY9w28dwtRRLjxYrDVoO+mM6E9EtafGNPFl2j1zgbCUXiCiamrNFxJ8+tohjCp
	 R5o9R3UAm2tzeK84SCgpDqitcuka9FFKMMTqys4LDMscmO7LdvC/DN4hGxwtk6JGq+
	 NrhtHOadAZZQNUb9mfGghTJxAXt/uOT6HCYl5stURfQaW+DtuDO6CBrVbglESdkEWk
	 GXyVQWrRI+JQSFf5VCE9XI8rJ9hLFR37YcMTRyuUxKo5wxY6U/ggVxuOUPikNreoPQ
	 rRoiNV/nyRLA1dEJ0M9O57fG4mW89NkJO4uIQk7gakVSwq4of3Btq44kvYfahf1RCZ
	 oJoYbyOcRVlGA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BB81480F82;
	Mon, 19 Oct 2026 10:50:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id EA0101E9
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:50:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CFEE340781
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:50:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tkGmKcxf_Lu0 for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 10:50:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 346FD40779
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792407044;
 b=gensyprjzOMD9cOoGNmmspmd+yB4f7qTAUDZN4x5LHrhGX7bgxgAashpw3LzWXxXAqia
 ffpdOSSh4B1Diat8JEWvqPj8XvksnCZyc8IYXCURxAY/OjLmtwTdecwyGkw5ZzPRWkyxZ
 nFKLBraRL2v21owzAO1e36riJMSTTEBgNvCfJGxxKd4cUyU/SnoJ9L9SfkvwuEHeGF5/4
 hNDxJQV3s7kg9/dRQB0p6YUREVuI46DU882wm2u40fJhU8bUDiJJKyHcDOhTfAg4eyMPc
 6qULvxKx/tWfIWDf+gMGm1fWK4kONuB+XsfcqTbQQTh/g9T0fLF3KMmN7FdvW4AjGvA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792407044;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Authority-Analysis:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=GKS+4ORh5rym3JOK5atn5pTWycStajthwhQPTurM8Dg=;
 b=E6crepiU9H8tsaZdix5B4vji2ktXaLLVcLLFbHvdTas5iZqHFmF1W8YK/O3a1FuHfuyh
 CuEDFfKbGKRBvADgyiVRi/n4ModqtCFyoI4PQt9W7maPfmQWpIzU0JTCu9bhaZuSww1BU
 Kkhy/JJ9JSva/mak42UYkJRjoyUrAg2l/Qd/I1GKgm510qMCXRSRhmgy6CqIG3Ybvd+pT
 h1Ogh89YhblYLZ1o8gf7In9SzAMzHD1umUOXQeTell7xMcX4G+o4l7KiPfPbknASmUQv3
 u9I/VXnc+e3bnIQzkxq3k+N6qZs4jYuMDy5+iBcqcsjLy80QWbDBD4UAxiWkF72nIKg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b="VJcOlS/q"; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Hn+BNujN; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=VJcOlS/q; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Hn+BNujN
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 346FD40779
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:50:43 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J8OtDO3256621
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:50:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 GKS+4ORh5rym3JOK5atn5pTWycStajthwhQPTurM8Dg=; b=VJcOlS/qmEE5TgHr
 nmB6wSmcdeNfhb9rl+GbL9/0dNh8erNAKVt/XOwRf+aDYmt2T4hBaZFZ4hf8Ufz1
 2+pRNx9DdeAL2qFC5/ZiN8XVaWg+YS4KnmZYRmZFtPKIO60C9sOJn1f8UzLwbkBM
 IUtmwQvEob8lUxhSdYlpX3MKVK2fmhLE2/fzTfiUFYzfGjD4BXWY1XIAVh1trvz4
 7FsUl3Kjx9gjbWI2Aszi78rVK03o5LVjix4RRxcDiWwjmeoapSDrcgBcvPFe40Mj
 XyoXYg4x7RT2gMgAfGPMlKP44SDOAtE2ao+58MBbgKZ6GfWhiaXFPqPGGGx1euUv
 Gptm+g==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf3f8pjw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:50:42 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-35c3c370b17so4167248eec.0
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 03:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792407042; x=1793011842;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GKS+4ORh5rym3JOK5atn5pTWycStajthwhQPTurM8Dg=;
 b=Hn+BNujNgyUYLNI32cD3NFUBKLwMZswYANJU6Pz4f0wNXb6HgwKx7weOUEglZVqduC
 ug1ttS/dYBUPnvb+8VTlLJBKaChIqbSfnEqF6fRAxbv017Y11nPiU4ko7Oh9rAqqfB0c
 fp5Ls/165vkDWcjlKq0/8QE3ZWy2fWB/R1GXTVBqg6RggkTON7LJib2Mha5hQavWGyAH
 u1d6fs9b4KrLfSLDvtluPofgsLlpfMrbXYBn8BVVJzEMo1zkZRICz7UmUBgiM5jQvdpH
 N9+al5c9S1i8bb7JnkRSaDHOYqBTyI5dHRAjd6p3wgac/SXeme1PTu54+iUZzuMAbJnt
 9dNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792407042; x=1793011842;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GKS+4ORh5rym3JOK5atn5pTWycStajthwhQPTurM8Dg=;
 b=JWWTALyNz01kPKiNiyJZwiVZ7ygnnyHS2bGhItOSfdnbr3sjHJtaL1MRzJ/t0MXkeY
 gbUJ4cM0z54krfYNcTOtssHWdhPs0oeXPnyJYh2DM4VbACjByjEDokvPzXHl8DsSwczA
 6Ifg1PZtw3nxZW/3t9R89fL5DsqccG1TyL+27JfktrB9i2AL7it0xcCoHbkvrmQD5y2L
 EZ36Ip4LSEnXTVSFBbZJpezc0YU/K8br9q5aZebN0bCgGzAxYRwGDK6yM/G8tTipjOu5
 fmGEWIM/jFWgnhHyr6rM2lZLsrldAWpeRYyJ5NsJ3xBQfEFkmHShdGMVy4OS46/L6MSa
 39Cw==
X-Gm-Message-State: AFq9FYLKitcJILwyAamKj2mLdIJkYaYw99LSCn93TxiKLplaCUN9N40m
 cpHdwcFCU6j5tuFWQtPvc+cW9MYDPQcQf7USYw2WUdoHizh1qXpkNf9hueBvNRLQ1+3By9diwp8
 gUePb4VOObGcD9gzhjuVO0kGbrz/KnK01TNUIiTaAjiWTBUYVyORP3B+rU7jng8DiXKuY8+g=
X-Gm-Gg: AYBFou2yKW/u3KTGl8ycOK4v3o/Ug6+T3VZ2gsziR8tWiApfN3kEqvs6YBLuM1Fq7xR
 PEDuuTsCvibBJk0DnbNH69yaaA7hKM5mrKyljhX1hLUjFges4aRgkl+r+5Yf816ASySNl/iA+Mp
 vE/yRMOiw2an9+6imea9+SkQfRSDJnqnrUJpkQQfvO4BV7nQP77PdTt5oQRknqVHe5dpboFL6Py
 LY12+tb9eW7aAsKz7QzelnKdHrGhXcdyo+DMhQYN9AwHeWb3TMMYDhRLfoIbridZj5q5Vuxipe2
 1g3pOEX69JOk84TB1KPfk7RJ2nJZvNJxP1pmZavEguXXB84xw39CliX0+/3MBfEKBmZEyeLGjIW
 QRkrnMiS8zAqKar9r3LrDpeNqPZF2ktuWuQdW9NnrmM/dEfhzZhcj8fJjnFPmhU9H5IU8X2qMl0
 kmZRobedExdC2MpymuJNtp5XemellP
X-Received: by 2002:a05:701b:205b:10b0:169:9f67:a91b with SMTP id
 a92af1059eb24-18511eb675dmr10658853c88.12.1792407042112; 
 Mon, 19 Oct 2026 03:50:42 -0700 (PDT)
X-Received: by 2002:a05:701b:205b:10b0:169:9f67:a91b with SMTP id
 a92af1059eb24-18511eb675dmr10658799c88.12.1792407041489; 
 Mon, 19 Oct 2026 03:50:41 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-183190aa3ebsm25187828c88.8.2026.10.19.03.50.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 03:50:41 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 16:18:58 +0530
Subject: [PATCH v4 3/9] configs: rename SPL_UFS_SUPPORT to SPL_UFS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-spl_ufs-v4-3-61432d0b258c@oss.qualcomm.com>
References: <20261019-spl_ufs-v4-0-61432d0b258c@oss.qualcomm.com>
In-Reply-To: <20261019-spl_ufs-v4-0-61432d0b258c@oss.qualcomm.com>
To: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Johan Jonker <jbx6244@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Carlo Caione <ccaione@baylibre.com>, Anshul Dalal <anshuld@ti.com>,
 Petr Hodina <petr.hodina@protonmail.com>,
 Michael Srba <Michael.Srba@seznam.cz>, Jonas Karlman <jonas@kwiboo.se>,
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 David Lechner <dlechner@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Alexey Charkov <alchark@flipper.net>, Peng Fan <peng.fan@nxp.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792407009; l=1313;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=+41aDp2q1Gv5WUrf0lDG/bqvgEiSSbcfeUnd4g92jpg=;
 b=m1kUGHyRaeDatMYLZKDIZfVJBiPs2KBFfcx/oWplrp/85iq7FTiilQxlWKyXiCmrLKLvjOD7W
 7Lq4cwclrawAx2ypP4r2eo3SUFFB6RiIWiENLweJur7y5u2ihV+Sf1v
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-ORIG-GUID: NOjCG7-LpWrNWr7ye3Qs8kW6hLEbRCpO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA0MyBTYWx0ZWRfX0bNvnYFv3cVO
 0hqD7F3nk7+MKTFr3zPIn2S2bKQCez+zvJ5Y85IHZQNbw2jVaLcq4NyTLs7zhn0ZpT59ac+B5Bo
 Ee2QxloZWpfTUO3IJ7KjDev1Nju/yeQusX9ZDoDAaCjRtC2EYrhHYO4zoOVoxeRkiNpO6qS+NSd
 e/G0SvmA6nY5i6tiHMqTvuKxKJ+d8aF5h0p14OVU4/ohhXvkJ0s2woPpZ4AztG4Nn5uqifyS2Kt
 dj6kKljP/IffWOb8hAv/6mn1jDWlKDp1peYNfasQ2x5xShWYURgpoKkDeSVLfq8UiI1LyziX43c
 KAUt39LJtPzf+VRrFvfzhRYeEEqhJDsURlAt/7fTp67JrnvlNHt/y+EveQSgPvh+YLMQ1V0ma7/
 C26ua+vRxcbHvOrZ8iGGhQ9rLGczN/IGt+327Os+UnLaSEtdzOsfMHjX57f0FRxovmnLVXCA6Eu
 H8xhsMR/FISgfJsM5ig==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA0MyBTYWx0ZWRfXzJrcMVmExAPR
 /Ndr1vEfZc/uvcJBFy6HDKjiZV3PlJI30sPl6zeOUC5+uZQU38sSrK2DKoRzyUWhBpIOnfh9NHh
 Jbcvw+aeber7uu7kOqtwSeex+oGKW5A=
X-Proofpoint-GUID: NOjCG7-LpWrNWr7ye3Qs8kW6hLEbRCpO
X-Authority-Analysis: v=2.4 cv=OaANnRTY c=1 sm=1 tr=0 ts=6ad5f602 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=Yvbya3M1uE0sRtRQesYA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 bulkscore=0 adultscore=0 clxscore=1015
 malwarescore=0 suspectscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610190043
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

Update all board defconfigs to use the renamed SPL_UFS config
symbol instead of SPL_UFS_SUPPORT.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v4:
- No changes

Changes in v3:
- Added newly in v3
---
 configs/nanopi-m5-rk3576_defconfig | 2 +-
 configs/rock-4d-rk3576_defconfig   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/configs/nanopi-m5-rk3576_defconfig b/configs/nanopi-m5-rk3576_defconfig
index 88b6d0f9e86..edb71b87a7b 100644
--- a/configs/nanopi-m5-rk3576_defconfig
+++ b/configs/nanopi-m5-rk3576_defconfig
@@ -23,7 +23,7 @@ CONFIG_SPL_MAX_SIZE=0x40000
 CONFIG_SPL_DM_RESET=y
 CONFIG_SPL_SPI_LOAD=y
 CONFIG_SYS_SPI_U_BOOT_OFFS=0x60000
-CONFIG_SPL_UFS_SUPPORT=y
+CONFIG_SPL_UFS=y
 CONFIG_CMD_MEMINFO=y
 CONFIG_CMD_MEMINFO_MAP=y
 CONFIG_CMD_ADC=y
diff --git a/configs/rock-4d-rk3576_defconfig b/configs/rock-4d-rk3576_defconfig
index 93faf09962c..96527c3faa0 100644
--- a/configs/rock-4d-rk3576_defconfig
+++ b/configs/rock-4d-rk3576_defconfig
@@ -23,7 +23,7 @@ CONFIG_SPL_MAX_SIZE=0x40000
 CONFIG_SPL_DM_RESET=y
 CONFIG_SPL_SPI_LOAD=y
 CONFIG_SYS_SPI_U_BOOT_OFFS=0x60000
-CONFIG_SPL_UFS_SUPPORT=y
+CONFIG_SPL_UFS=y
 CONFIG_CMD_MEMINFO=y
 CONFIG_CMD_MEMINFO_MAP=y
 CONFIG_CMD_ADC=y

-- 
2.34.1

