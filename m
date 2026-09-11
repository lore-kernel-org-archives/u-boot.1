Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E49BC88E50
	for <u-boot@archiver.kernel.org>; Fri, 11 Sep 2026 09:32:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B3B1080ED3;
	Fri, 11 Sep 2026 09:32:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lOlfyKNMLFD3; Fri, 11 Sep 2026 09:32:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org F28C9811B9
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789119149;
	b=ZtlG7O2iiiv8rVwtG+Zwrk4AEkJ2jo4O6cozLgoWtdvTwcULRLffpnYhQpdlkdzUNpcN
	 VJewiEQNeFGAJfK1ZUblUGl00tWLLBAw4bnUtYSmMxJr7EGoYPgaiZq/6KT6+ikT5Mf6c
	 suoy+ueQZCzZDnz1E4dC+0RaiYzf30Txo5N2SmWfM9h7tU2EfeIHYO1kwXYt48OM4DyiI
	 W2xEUBghlFBQE6hs0MshsXDRgcIVSZuyM+fOhbVma/fEuiGbMxSU746f5b05kTlkyXuMc
	 ABGerUx7F+A6GMANmEplOkmBpS+3NUkKvbrTo7gBXhSxLmZnoXYbKGVRP7CA0ZsyPjQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789119149;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=cNOjAemKvyw2RWEr20qymsmfat1KFPtRbkoWRY50Hmk=;
	b=Z90zTCgCIGIaorW4dm1zTaeiQQ27NBhcGTfcmdLlmlNwFpQdX7dd19eRxlCke/Cu++0Q
	 LbeIVBq78Z7rYyEr/ZgHuuUKAV+VVv2XiusRgwyst+nHlfQpmxaB/EL8RtmDdLcsXJWl+
	 qZX1tfwfLtbNz37Bm51Gi/g7Yi2Z0qnqwD4jRpfaGssj7NAZoFgfHgyQPIBWUj+iNEdqK
	 paW6ihq05GDHGSjWVpQhQgvaMhRffT9nF7Bd7+0/vQunKjWwO+x79pXQmYtNB9kCb3pqH
	 pRT/+mJ4zTfyur9ugOuSzj3p/8DGbm1/V5NcXyEarc0WYlzqMLzj0dd1AXSEU4j/ZvA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789119149;
	bh=cNOjAemKvyw2RWEr20qymsmfat1KFPtRbkoWRY50Hmk=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=us6h8znbW4GOkgDxR7ouu7434UAagpwHfy+EvoA/Goxa75/gpyD3020ekUi1RnRNM
	 YVYXWBfial4eIDVDOMlNbRPWwbKOow8A3TqzgX5+KQVG7UIrVNiRRq37gjQp86pu+l
	 Shsx4ugAOmClBagzSql/MDS1TlE2j63JKL+5R5yASRLEK1H40gP3ap0zwn7KmSuNQr
	 6X56WbzGffz9WnlxurSTf26Jo962pkBSfBZCSbrtqkbrsaeGqa2IR6ZzMgNBiie551
	 pzlSPmmDdKS3hmAUyuZk6jbfkfPkmt6VKYr+m4nHKXZPrxkSLeVKZ4PE8ltlUyZx8l
	 p9cyN3iKZwheQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id F28C9811B9;
	Fri, 11 Sep 2026 09:32:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9ABB52D0
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 09:32:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8C71840143
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 09:32:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SV3k8GB3DB2D for <u-boot@lists.u-boot-project.org>;
 Fri, 11 Sep 2026 09:32:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org DD33C400E6
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789119147;
 b=eczdsvvo4B0GniCd2y78bymUVSLB29N62ot4tdjF3frERgq+8X9LxgySg7RSt2AdPNsy
 NTakxONPHMT3Z1B0dJkonzTz6DeqIikYuoB/f9q83TjPdoBZqnQ7GfSkP6pWD4V4w4cq1
 zXFEDIjwNQWKVa3mn2CiJYEMAThMmm6Lr3/i1KlGsSH1eRAn0myRA1g8hD/ezoPJFlhRU
 7Xle0izI3JUEXm0TUYyTfe+z10kXPtnB/h408heIP9LPfCvlJd71nijtNAv0lWbbuRzuP
 QEggt9k0qGZ+VYETE6zjOAX6R29ZBGKb/eEMEAh2N9gsTJSTypgPtAeS3Kx8nLm0BiA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789119147;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:MIME-Version:
 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=cNOjAemKvyw2RWEr20qymsmfat1KFPtRbkoWRY50Hmk=;
 b=jndeZbASopQ001M7myZhTfTb0N6uQyiFqy5VrDAUCqxkPrHUxm72bBBYejuTIqxajElg
 7i6hTJ6uk56o4PKxGmns5arcLS/7KvhlTx8zg9hm+pJU+ciYn2D1K7AmubNyj5GU1OOqe
 Rgan/k1Cor3h9tm3009AeG9iWHTuddUmOLkmirYxzfKCNQfQht+ueGjX4rix0ukCBDPqY
 tzv7h4/Q/Oh7Z9D6pVFytRL4unKMhklG42VQFyePucjzC/SBLYKVe5k1xA/XgcNVXtr+t
 huWlvl3NLj+/pFZcrN4jM3YwpzKYLnOk16W7at9/uCdFd0c5ee+rGjhKBm/bB/lAh1A==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=PO5S4TZz; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=KzJ77XcP; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=PO5S4TZz; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=KzJ77XcP
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DD33C400E6
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 09:32:25 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68B7kfeQ3366287
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 09:32:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=cNOjAemKvyw2RWEr20qymsmfat1KFPtRbko
 WRY50Hmk=; b=PO5S4TZzjce9vaNpfXK3rOQCjI/sKKKJ9WPzNosJ4SX9Dog2j81
 +wsiE+U8t3GKb0LAiwFXt5jLMFL63byG55sfBS/JwUDriu9uzonI5OANpaFkAvBd
 xJaA73PqcZMSXmgahNXEphTYZQDKRDlwR4ICjpCUAzWoXKTt5kF7EQSuGxrqDuxL
 811rdqQYuowpSorarvOWv+pdgV8Qtraf20OrKRTm1pMQBo7NVGm52VKHjwMWn0dQ
 0Pz7gyr7ilOF3DLmD6Px2ufDdKrrsBk7H7WXQYIeyphsZyqWF6EHjGucoZRN/dEB
 w0DI99XzJC05Mb+vLltAHNHO6OtABJfAqxw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gm1k2b590-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 09:32:24 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c85798977dcso1208520a12.0
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 02:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789119144; x=1789723944;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=cNOjAemKvyw2RWEr20qymsmfat1KFPtRbkoWRY50Hmk=;
 b=KzJ77XcP/Meb8MUCkVkZKbgx+H4KSdtFa3w/vLAgxSnsFiNQhOxNkgFn63DGEXz8hk
 VY1fZ1CGc0yrqDDJzh01aEvgG7kuapBUlIdWI0MxMjF2IwTy26jawJtu1Qzu4TYgbZgp
 JCLizY3pgWA3wk0w8p6EIT/glDaL/vfSNu3G1OfXv1Ppnet+8Y6YIR0HAZK2X0rT627Y
 3BjIYDZ6r/DwFA19yvAvBZf2zHwnomOj3yKG32GL/jFxf7sNuT5PxAQxegf+dHBN0/rZ
 JdEON0/M4tQGRdd95T0UI48C6ieHGtcSt1NNuCOmoU4aNd08fYsF1VTa5BUKZj5sUc+N
 n4tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789119144; x=1789723944;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=cNOjAemKvyw2RWEr20qymsmfat1KFPtRbkoWRY50Hmk=;
 b=n/12Jhi2L94UTCTt4T+ZqDeInobTfakqj1HZFy5O2HYOnOJA5XIjOcXqZvCDXU1qdh
 E31l0vakcKk8xxv0KK9wjzxpDj8apDtW8RCNBhvEc+cxPxcpu3gnOwkgf7d0fMBWMdPu
 9hK3cfQnoqA/8m5WkuooDpCAr59C1yPbzW+MFfo7OWr0Lw+6TFgCJ0vSLZ5+xZlX6uSi
 3ZKqfVNXC3eicCjPo9gXL9dmWo9vLWtE2PiKe+oCHNwdjDRzKH0COllO4OArYyFf4tys
 PExz0FssTF9qWcmBhQNmV0bQD5i9N2xA8E9LyGpgh6tZlJWpgO+utXaO11HyZwJBTrRH
 pIpA==
X-Forwarded-Encrypted: i=1;
 AKwUvByvo6/6/4PSby7b8NDauRP+YKgoPPJXkYKpEuHvEKFduTCFTw2Xrke3B0uuZLpsO6qumHOJnOk=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kFTZ4oYfo3R34rUMqBrxCI7Zod7hpvXFBEqkY42r7Ux3gRFVJ0
 3TBDMxIHN+hZl9czlnnYdfx1ckTBY9cXdGHwqMLZvOlr09CpcoH6EPjOw2S8bah9vGKZgvSjVC3
 PTYblTH44S9FDXjKMLPOSn04Ifg84k3bsjb1x7/n2V4nqNhJBfKUxp18Gyw40Mkr/fg/7IU0=
X-Gm-Gg: AYBFou1JjeC+q0oBxLwv+Xm6r6R5FsXWc201ZD8Q8+D0VYqtXjl0bPifU4c1LQgYEUg
 hsaYa/3pnUkPB64lM3kKGrxMimEZ3CIRvIVAgEjyh95gfO/i4I2U01ypt+ukkKcilKLAu06PRxk
 kSczhiOH+h1PvnYGn1hHIcTOcvpClsoO2b+FpIQIANG3IHNOuueg7nkY3EUV9DYRegqrgm9mXJ+
 nl6CaJT4nVPfG8prQTRyzPnLHYt4q1P6d7YNXoodUK0JMMch3lTsmYahRu51SDaWUlneiLkt4C9
 DTZX0AQXmW+y6aivb2tM+qTStbZYdPdJ9KO66iDnIg5EmdSy4BtDZVOq5xikLQk5flb0UvnNHTR
 AVE5ZfKjEHqMXyFl1+6auq4JXFR+Xt/86mPGmjvlUgHk+KYYv+2gKL3bM29t4RxVSJqDnYIro2x
 C1JFURONx3VCcXuHnF0Pc=
X-Received: by 2002:a17:90b:2d03:b0:38e:67e1:15b with SMTP id
 98e67ed59e1d1-39d9bc3f8c8mr5292878a91.6.1789119143834; 
 Fri, 11 Sep 2026 02:32:23 -0700 (PDT)
X-Received: by 2002:a17:90b:2d03:b0:38e:67e1:15b with SMTP id
 98e67ed59e1d1-39d9bc3f8c8mr5292828a91.6.1789119143366; 
 Fri, 11 Sep 2026 02:32:23 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4f739b5sm5154940eec.25.2026.09.11.02.32.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 02:32:22 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, aswin.murugan@oss.qualcomm.com,
 trini@konsulko.com, quic_varada@quicinc.com,
 balaji.selvanathan@oss.qualcomm.com, dlechner@baylibre.com,
 u-boot-qcom@groups.io, u-boot@lists.u-boot-project.org
Subject: [PATCH v1] Revert "configs: qcs615/qcs9100: Enable watchdog autostart"
Date: Fri, 11 Sep 2026 15:02:10 +0530
Message-Id: <20260911093210.1351573-1-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=cM11IVeN c=1 sm=1 tr=0 ts=6aa3caa8 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=pmjaIY_BoWR4lm-OTTMA:9 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: GlUedTNFkNpE1WzKxNkyM0yHhmNMFybC
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDEzMiBTYWx0ZWRfXyRdFadSdxuon
 dHj2eNnB0tqKP2gfw0wBtyTfwyomwj1henJ2ToZPpo5r/60MWp5qa8blVLY08CMlaEJSn3RvZd9
 y6JzbRpEXSmeLZAHS/absbpDOFnOUKY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDEzMiBTYWx0ZWRfX1xtvviwMcRRt
 j1a61vQxziKEXdvcwT8HLoCQIym24ZGlIpdUks77UwUGrsJlyaMPsVcNu7cpmBpKfVFE3LDHAJv
 oLASXUeCSckze3rruBSeIPtQrW2+HirINilTlTtzdTkEKWX4IOkCdXuck8jg3GymwMvmOBOmzR+
 te49N6NPNjNeU5OLHd2P/7kTz+xOEzPD+WVGjz0HLCs4nwz848HNfbVVZg/S8XywI9jPokkhm2A
 0p3L1PWOAxTgbaELQlEuZ6TvZjrNsyZeYheX/GEREKA+Gw084zfKd9MjhgpafZqCB4/Y5aqa2Mo
 tVjnWYPlHUMh928C3U4/VYvgl5tl3TfRq4p7VN/z/NkpK/mqpisAOmsNrCxpUg5uW8ij4QbKJ+n
 F1z3CG4flZYmdYZGPRLLx6WrygPklM8sGeqVZlwqFq8i6zz0suhx7neOcAW51BIsIfSu36dHrcU
 7ppgkcp5m1YcGi77HMA==
X-Proofpoint-ORIG-GUID: GlUedTNFkNpE1WzKxNkyM0yHhmNMFybC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_03,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609110132
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

This reverts commit a50e32bae6abc8d86d4fa6fff9a1c8f5c88baa4f.

The watchdog is not required during normal U-Boot operation on
these platforms and can be enabled by users if needed.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 configs/qcom_qcs615_defconfig  | 2 --
 configs/qcom_qcs9100_defconfig | 2 --
 2 files changed, 4 deletions(-)

diff --git a/configs/qcom_qcs615_defconfig b/configs/qcom_qcs615_defconfig
index e060fac3726..27666a8129d 100644
--- a/configs/qcom_qcs615_defconfig
+++ b/configs/qcom_qcs615_defconfig
@@ -22,5 +22,3 @@ CONFIG_REMAKE_ELF=y
 CONFIG_TEXT_BASE=0x9fc00000
 
 CONFIG_FASTBOOT_BUF_ADDR=0xa1600000
-
-CONFIG_WATCHDOG_AUTOSTART=y
diff --git a/configs/qcom_qcs9100_defconfig b/configs/qcom_qcs9100_defconfig
index efd6c63f212..082106157bb 100644
--- a/configs/qcom_qcs9100_defconfig
+++ b/configs/qcom_qcs9100_defconfig
@@ -14,5 +14,3 @@ CONFIG_ENV_IS_IN_SCSI=y
 CONFIG_ENV_SCSI_PART_UUID="71cb9cd0-acf1-b6cb-ad91-be9572fe11a9"
 # CONFIG_ENV_IS_DEFAULT is not set
 # CONFIG_ENV_IS_NOWHERE is not set
-
-CONFIG_WATCHDOG_AUTOSTART=y
-- 
2.34.1

