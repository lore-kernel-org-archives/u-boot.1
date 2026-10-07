Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A71ACA5FFC
	for <u-boot@archiver.kernel.org>; Wed,  7 Oct 2026 18:14:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D670B60BB2;
	Wed,  7 Oct 2026 18:14:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 478hf-79daRQ; Wed,  7 Oct 2026 18:14:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org E701060B6B
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791396880;
	b=g6S9/J6hTRtBVOSMQqsfMHORWG5AXzWT4sKrjyhjiL3DDbs2ftFR/+o1GhEfthPY8ZP4
	 EOWY1WW7FZFGY7A8eLMlsh4LADzBTCMXlEnW/fbdhY8WzznSXWEk6DNEYPL5O0mdSfLsQ
	 bI423UPToCa6eWnt3KDVS03c9tCFlQ/ggm8IbB47khxlLYjrdxbpc5bc3n3TgA8tcgu0v
	 c480j0x/5uo8PyKfkObjGlJb/O/NlzcHZ3sTrxwduQndXq9p7/CcpKrQqflke8rIPC9/F
	 A7DUiecE8Fep5J8ha+Vmg/p6kyjb2agKnOMH/LxikYdSN22GiJlGNfssP8pkZ/y3E4Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791396880;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=QT8sSsW31XC57ofgwy9iqhtwopoR+Is9Z1Y8A6etXuM=;
	b=VHeXYCBAoum/uMplT00oiwnrgpneJ0UiIQwaabTr7MfgsNp6zYc6J6nUibhoMWTjgNMw
	 Y+tAtuWG8qQf1tkC8di4wg9MI9XxYKGB4OhYOa/CzI7TQO0G6XpRjz63GIQAqOxK9G4YD
	 Wce8DwH06+tZaiJTMLWIufbFhdUTohHX/EK8amQbT+9ezcrwLp1PLyQNDSA0IKY70/ulw
	 neFo5aHUAIei7eemauGWqjwXi2KFA+LS6rUq+tOtOYItNVTXc7LIKWsslvzAZAbEefiAW
	 tNtCv5T8nBrQVh8KzCivNb2oqz15Hj+vC3wnwMVV0jRcFEUJAb+lnXVmJHM+uyFiXEQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791396880;
	bh=QT8sSsW31XC57ofgwy9iqhtwopoR+Is9Z1Y8A6etXuM=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=QVC3f7HojVNHPzEwHJEmEi25ejp+tMUNhD/JEgYpB7eNNqwabU9kTTXin0BnSenb+
	 7a6efzBVEYwbM391gkzjsG/G0utLb/iHq8k8a22zRzpJXV06vhFe4+pkvcvl3bUULX
	 P+eXJTA0gutQWPavVniRYVG7gl6AGAswApP+eLmBa/jiC5Y4HCCnRdDmy/f4WlsiPY
	 7Lq56JQl3alINi8j5lWiAH1M/2a9az4MQ2pJRN0YJm8Hlhms3f72jGY9+pmR2IUuZ6
	 kQROTPycxONrs6+QrYs523BkdLCxkJ69sJXrrs0RTR+2Ex9w+zaYYrqJ7wH3TUd3Gt
	 Otc7tqw58qyHw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E701060B6B;
	Wed,  7 Oct 2026 18:14:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 14DF332F
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 17:50:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0CECC868A5
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 17:50:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hY5RiTQQgQfX for <u-boot@lists.u-boot-project.org>;
 Wed,  7 Oct 2026 17:50:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org BFA6486B0D
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791394946;
 b=hD6erlbw282DPSPcz95KSHI9GDS1mPGjDhzZ4Ag9R5sZcuGoQfu2mxhbQc/JFrjtnEAR
 cYiOv7yv4q4GTmE/XzewZeqUD3zKdDhC3HHiWDP6d8kFMd0XugmrFJ/D7ZnbIpl9tLFtb
 iKyDDPmVl51JmBR+nux1fd8QeNL3fwPAQi+gQgps7RP42qIvN3VJWsAmPtvHEa+7So+Qv
 ErkdZe23qI/VOVdBklVqE3NDAgfaFWJxVqMVTervOXx5IbA+XzJXrEtI/07JN9ku1xfYu
 GOhxng2irg//PBoTvDD3OU9aQdntcCBUx/WMXp9zWm6PdJFh246k5lTRSz/yijAtk3Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791394946;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=QT8sSsW31XC57ofgwy9iqhtwopoR+Is9Z1Y8A6etXuM=;
 b=qbVCCFWuBhNhTcf/YaShMu3uyfEJxjH0OiMwmnU6s+ILtuHTBUfNWJ88XlB/SqKS/B4i
 TBEGxjnwSr3DmzeZpUnf91wXgmJ057wYpQV0zu5QHE/Hg/2pgJzCJpgi391MAbaSoAOFE
 o8y7giwhzrgUAbHw3Sx2qIv2i1iEjEjbTelbdG87OPHodD224d39UUlYKT20Nw6RFD/ib
 4Vb8MixiuI1Jjz7dubjjPjTvKVocs8U6vn6bo5A08AHJqaSdChWIt1yD8Ff/VaQ1mt/2f
 5YyGChG//2nZZc3+LG6Ga7NX0YTlUE3h16nhsbyfGA5R2HNXt66BeoHK7zPP6oalLbg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=QcymMzf2; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=hXc0+ZW9; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=gurumoorthy.santhakumar@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=QcymMzf2; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=hXc0+ZW9
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BFA6486B0D
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 17:42:25 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 697EtVEr3646970
 for <u-boot@lists.u-boot-project.org>; Wed, 7 Oct 2026 17:42:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=QT8sSsW31XC57ofgwy9iqhtwopoR+Is9Z1Y
 8A6etXuM=; b=QcymMzf2PUAwHB6CKOCeJ+CToVMBlwUJxJj09r7jqdQoR3fc2AM
 auq8U0Dmql6qrHOg/WyjiTOYvhtU7dlPQyTgXZbnVXGbQJJuDEGeoQi/b6nkojL5
 TeRIHNVzzbyVhzSKHw07AYN1PuEkwyosCYP/By9hi15wAaUURtYkHCLM9Uqf1Wov
 le2/JFSeIizmNEVdLHJn6yLkAywf5cm2T7wiv3EVvJVUXwQ0Puro3hJ+J0f101nE
 Zddj18wUW7XNoTrTRv0ZuKQ99vHnvC+rmDRuTAoVuuLiMY2QiQgGmWGgHuAWjTvW
 abZgVhfZcz2SVZDQtJkVj8KhPimaBKb37Lw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5c1s3dmp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 07 Oct 2026 17:42:25 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-34ef0362d95so8047219eec.1
 for <u-boot@lists.u-boot-project.org>; Wed, 07 Oct 2026 10:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791394944; x=1791999744;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=QT8sSsW31XC57ofgwy9iqhtwopoR+Is9Z1Y8A6etXuM=;
 b=hXc0+ZW9D27hdQjSTZDnTIf4vd19MITTCSwDviWgc/kr93KdeRPQ7yUzIOpRRYWD10
 8fzwZ/FEo9u16BmQRfMKCfwcUFv1+qYX6gbfZ/KB4Fn5Y+b9NS3bhY3qCfCnKIub9vKa
 BhY5ZSP1JVn97MXmAIaCAHkKFxoFsnuXzxTQsw5TIOJBtFKnzOFYXGRXbx0woCs1IhGg
 xXvKK7YUfYw5wjz4hylhfUZ3z7T9qKL0jNQw8UTXaYysHhicdxHu7Xcr27AzxyFhexH0
 hi/erT7cytQhJxfwpLER2su0xOi9U7MV3noTgpm7t6UGG/Iq+WtDYv+JZ1LA2Nha1a/3
 yHfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791394944; x=1791999744;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=QT8sSsW31XC57ofgwy9iqhtwopoR+Is9Z1Y8A6etXuM=;
 b=vjHzJ7pVOeYTnKqDhCioLpkiNc6IYgq3tqqziThhBeDA4pngW+ntivpufKn8aXCqNM
 wvuseL0jCiax4pRGFHIQ8h+2Me+vWlF12B707dOtnXLNoZpwsJKuSIcar37d9YEarhuH
 P326k0pL28jVzZ9n5yn2ZW22cjzdzUK5SrE2INhHPjM/vrZKbTvhUowdSxCUHvJT4Tsp
 iqoOPLteVoa79jINwsnAqf/vmsREJtx+KZTtDa1SE9t5rE4nMP86pCmBnqxw/5cigILz
 X7gEz7Z4sjnB8jFs+spp1CL8RT1TQatjCftJGUE6plB1Owh5wGSsNTyhVPZP8NHL5z5n
 lr0w==
X-Forwarded-Encrypted: i=1;
 AKwUvBwFQIw5Lu8j2AFPhlDEBk9Btc8aN8DV7YNwbAl1jdsngcWmxmc96ofGcACS7ZckjaEdPinJM0g=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJg5/I4y6hBnJuUUpL04oKSyYFQ/A7Ol983Gu//erb61tltgVOy
 D5aocJla2AWRLct/S0ks4ghhe9vlNKhaxgl6AKcSUmfkI3WRxAsSTm4bhsvzhkqFk3uA7ESj5ri
 AwVjYQTGuJVtUJkCQkOEIWIYNq1xWcBpQEjkhk5OIHlTyRdhphjpahBCHOfWD4l2S7HJbdqE=
X-Gm-Gg: AYBFou05pvJwxldG5s2NlY0qlBqzMDp6fCGZulCbIbs5IFKwZNzp4c0HfHqpXrsQHrf
 /+9+sLxDvGEagj2hQTkg0YOH6fOKSRx3yicmxrjAg4JRz/VhhHl04ACQD4SwtJFlHNMF7/5ZqZt
 WyL1qbZRjKvTJw4VlpOgvE9kDsAnNVWkrw9gHcmxW9cmoveL20mW3XdF0zxHWJL2NaQDDAYRFbj
 06yeON209/96asjyJBH6Mn8IDh+og47EUCwyQCIANxXPx1LrCHBaGrN35wVNS7DGqVssl1+dMMr
 NanEUp03cX9dmdnAdEdKit1FNvlAoK8j53QTkwvFDcQ795P816TcMuCi0ijpLqBgtWaI5Uop8ZV
 MPj1k/7KozAez4H8GFWZkERirIkQkYkfrafcQu/nscA4aS3S8rbjanJi8D7PLK2A4QoZD7ZFHAb
 dKGGwx2XND21R9LELUhQLcLfBrfARnUfFF5A==
X-Received: by 2002:a05:7300:c00b:20b0:34d:7ae5:8d78 with SMTP id
 5a478bee46e88-3515de084a6mr3780504eec.31.1791394944469; 
 Wed, 07 Oct 2026 10:42:24 -0700 (PDT)
X-Received: by 2002:a05:7300:c00b:20b0:34d:7ae5:8d78 with SMTP id
 5a478bee46e88-3515de084a6mr3780435eec.31.1791394943569; 
 Wed, 07 Oct 2026 10:42:23 -0700 (PDT)
Received: from hu-gsanthak-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3515abb779dsm8486756eec.1.2026.10.07.10.42.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 10:42:22 -0700 (PDT)
From: Gurumoorthy Santhakumar <gurumoorthy.santhakumar@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org, peng.fan@nxp.com,
 jh80.chung@samsung.com, tanmay.kathpalia@altera.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, lukma@nabladev.com, hs@nabladev.com,
 gurumoorthy.santhakumar@oss.qualcomm.com, Michael.Srba@seznam.cz,
 balaji.selvanathan@oss.qualcomm.com, aswin.murugan@oss.qualcomm.com,
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: [PATCH v1 0/5] i2c: qcom: Add GENI I2C support for IPQ5424
Date: Wed,  7 Oct 2026 23:11:46 +0530
Message-Id: <20261007174151.2590649-1-gurumoorthy.santhakumar@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: PzYiJbaX-qEOpe_hdWoQMvMjvWSUudf1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA3MCBTYWx0ZWRfX4hg4pgdcQwEv
 xwkltuhPQOt7urJHKm2eh3tgGpEDnV/GUKA8PZ+tTTUwvWykxSGwNzUm+zbsyPo6Tgr2R9k/ivl
 Vbypax5TtMu8b/UqshbnqjxBpCLcivlYEj9Hoi0p3MATDt5LEInEhJorwe9b0rPlcHbzkguOZT1
 mLuIwDaDJRKIiIUyu/KwTjGZipFBHCR/ymKyt88vWAEglTILRXayxQE7yom/amoMb94MwAMK1/t
 +S8864RXDafSEPhZiJVn+7pPjOi0DORJCBSP285ddESr6e7gWoA8bnnAGar7sZMXPaeqOQ7nxS5
 14IXIUj9QQsaPkceQ8yGcCVPinpNo4Rfgk8xTLYsxg9h4/3nXK1tYEavLUddtMeOJtSYNEtCTVI
 S8HDXu/S4CU3HZaTqq0sk28WaQsrcWq+lfqlRVF3sCy2PvIxSzcsTxPjfCwtse9b9LCrAMZwMKD
 JkmodRe7hZ2GHnJmjHg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA3MCBTYWx0ZWRfX8Obp0E4BieZv
 /L9FFp6efilgDJvyps1uUgLcjKewC1jbvO/1TOuYqTKT2kG5XNUXOYSM3k27ZskxqOi89fir4T1
 DKA2oChrrcsQHSrfo/ilsM40FqSxhC0=
X-Proofpoint-GUID: PzYiJbaX-qEOpe_hdWoQMvMjvWSUudf1
X-Authority-Analysis: v=2.4 cv=NatzRGD4 c=1 sm=1 tr=0 ts=6ac68481 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=bC5BLFOhLheNTHVVHVwA:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_05,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 clxscore=1011 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070070
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

Add GENI I2C support for the IPQ5424 RDP466 platform.

This series depends on the following patch,
misc: qcom_geni: Add minicore support
Link: https://lore.kernel.org/u-boot/20261005-spl-v10-1-c4ca29bf27ed@oss.qualcomm.com/

Gurumoorthy Santhakumar (5):
  i2c: geni: Add 32MHz clock and chip probing support
  arm: dts: ipq5424-rdp466: Add GENI I2C nodes
  clk: qcom: Add RCG post-divider rate helper
  clk: qcom: ipq5424: Add GENI I2C clocks
  configs: ipq5424: Enable GENI I2C support

 arch/arm/dts/ipq5424-rdp466-u-boot.dtsi | 65 +++++++++++++++++++++
 configs/qcom_ipq5424_mmc_defconfig      |  6 +-
 drivers/clk/qcom/clock-ipq5424.c        | 25 ++++++++
 drivers/clk/qcom/clock-qcom.c           | 23 ++++++++
 drivers/clk/qcom/clock-qcom.h           |  3 +
 drivers/i2c/geni_i2c.c                  | 76 +++++++++++++++++++++----
 6 files changed, 187 insertions(+), 11 deletions(-)

-- 
2.34.1
