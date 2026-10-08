Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C10B0CA600F
	for <u-boot@archiver.kernel.org>; Thu,  8 Oct 2026 09:49:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 853ED81292;
	Thu,  8 Oct 2026 09:49:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bimJkWs0dwdu; Thu,  8 Oct 2026 09:49:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org AB0FC8128B
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791452991;
	b=O7VRwltUNUCirhaZHW+dMdSC2mmCH/jQN9wCPPYhyEZUNDmcVuFsAXWBZhiA+idiy89y
	 YZWfcxXywQbffUXn+lNHmWVcKpVhEYXcbZ2sbSFMwCJdo6hRQQ/ogFYXqnaFAeZn1PgIK
	 G75ziEQHXCOHE7xAPiRdJLW/kkaZtPVrYl+hQ7YeyftYo8gIG9BbHvzKqf7KKE/ARw6vh
	 dEl4VEpmf8N+RNzeJIOkLpPmYOLJkb2GS4IG7bj8ZmfnRdycTiT/LtOUDsJbHPb5ygnX7
	 FBDOptYl/8zYVP496e7f7LuFSP0u4kw5qAWKVPtqx9L6f/asYG0wr0Cnw7J4nFHgUOg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791452991;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=+0lxLpCVJYJJhi0tn/ZKaHgAExPnkRUaPKR68E7J6GY=;
	b=WGoiis8Ux0zEsqLk83e+ZjG2HW9Bsrrg9gPZCPBTY3CPn2spqxa3anmlNIXRR7wLST4l
	 bSOtCfQOKvNYwb8o8Nmd40ENsXOze2e53dmwXtFOGPAmH84/vQX1fM3NC0PfFh1X6cX+p
	 W/DXd1hdouO88mqsCq2hOpCdlcJicy/ziXxhiU2KPH9wD0iO7NzucOzSCFSqwTffq3/+v
	 5vs3G/oLY4gey811rEdKqtr3RGPUCS2Xcf02NQGlpuzyXMZseKsJvK73FsAnbs6fPW1RP
	 QY3/rt7O0T7vtgGI3/gg8b/2UbLNNQnjFBvbwX559IVXj1afzANQns7CtZ0XixcJMbA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Pa+G3a7F;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=AD8hj7Sk;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791452991;
	bh=+0lxLpCVJYJJhi0tn/ZKaHgAExPnkRUaPKR68E7J6GY=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=1B6gO+W6vQupaTR+snwMQHyNzR5d1TgGp2h5MsxnXnV+f7AVT+VBePvY2KSgrpuLM
	 DLjDWaQzK5UrQBSCP8aBGFXkDku27qEVHjIzFryTqQ4A3+cYNlg0Ih/NDHoMsmzSA7
	 rsZDe8XkEkDoKaodQkzJx9tWt17TVjxEQuNBT+s3CygfUb2NQ99Fpx+NIzerY+pGQ3
	 G1FsGYnk/WwpbwsiFa8dxIju/efHwGNgQF1kO26hIAqEaMDv600ajYiC1bIsg9OebB
	 HABTa79W3I8v0tovZ2h3juxhksmpAsYyJYp7XRzd7PSvqwhHjSsrzmEq+vVwHfBnY1
	 yHpQwF8945vVg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id AB0FC8128B;
	Thu,  8 Oct 2026 09:49:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id AD1EF1D2
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 09:49:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9360B8122C
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 09:49:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CtZc2xXRLvgZ for <u-boot@lists.u-boot-project.org>;
 Thu,  8 Oct 2026 09:49:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 798A781200
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791452977;
 b=ImK5wrEVAI+9A5e63hU0dIWZjItZmjb35z5ivHyzoc2fOfgV+I8sls+TBUskBzwTs5CM
 l8FPGQ3JOhw1Nfi8hwCOnBhtwF7G2sQdUOUcUOE4aIlRTCCF8vyDm2pl8TsYI1S07S4Fm
 q5YYWOK9QbvJaQ1ev21YvNcY3wRZf4DLILbk402L5CACBV/3VXCylJSJZP0oPJTup+ouZ
 lJQrdwYSNcjaxU3XCBKYZGHsnL5UF15EY6ELDUMiHdenpYFpFgogoBUmHFTVcs1+O0zqm
 qpPWu1z0z0ocAa7nEN6/cczoTBtpshqcDoSUisXPoGgTMhE1WsGdOTxv4nc023WXagg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791452977;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=+0lxLpCVJYJJhi0tn/ZKaHgAExPnkRUaPKR68E7J6GY=;
 b=V4mGbYVpY1q/LLkY9xb4+c5gjpVgpsbYDKzMEBx+l82T0AKnQzeuOoKEN2a0IFlpnl+x
 /v+G+3ZhY2GP+7R7j0UFTCJOj0Hsx2FZLL/JHcbMCMrlnTxV330HNoFIaovYZZvTE6GbT
 w2+3eMqvSYV0Rx3/1ZaXy/GiFhWyJHmnKLyftwN7UWWcNRKqlxWuLchJXVNdn/zL8l57d
 5JqtSEnUKUvLQ5tDKR02+3sc9x8LYarIlQPExcKod/jkRK2Dl4b94+KJntrem5WcexO82
 nTtU+w14IqMO+/XEt++febOJ/503d36AC3CWsGOph4PMt9klMvOnnVdKN5rkKqp196A==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=Pa+G3a7F; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=AD8hj7Sk; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=abhilash.v@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=Pa+G3a7F; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=AD8hj7Sk
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 798A781200
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 09:49:37 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6987K3Vl3190828
 for <u-boot@lists.u-boot-project.org>; Thu, 8 Oct 2026 09:49:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=+0lxLpCVJYJ
 Jhi0tn/ZKaHgAExPnkRUaPKR68E7J6GY=; b=Pa+G3a7FeesAxREfgLRhiFmafah
 sjKa5AtXpLYRCi8E3/a9RMAtu3l8C/H55tNKlNZL5aYUlW9H6ORrxob8yi9rFes9
 qaUmwzcS/6JwJ3Qi6heagtIAbaYi27rwycx+Cw/EbLDJSDezEiZphVbpdd6MEXx1
 C1Wd8kg8uk2UxAE/N/MzCJ4sj3eB1Z1C49b1RIChc7XHIep9KmPbHnTLTdSn4Gxr
 YrCWoXqhaee8O3PqbW4+yIuxe3Mb3VtlwMckRI5IH+3HJKiCnnkiD+jjs2F3+yx4
 nNl2Dt27Gp8R72Vp4DseVBSrc4D81arh/sQJ7aw/yG/bh2Ce2tFX+2QX9dg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5xe6aadn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 08 Oct 2026 09:49:36 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-30bcb065bfdso9855265eec.0
 for <u-boot@lists.u-boot-project.org>; Thu, 08 Oct 2026 02:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791452976; x=1792057776;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=+0lxLpCVJYJJhi0tn/ZKaHgAExPnkRUaPKR68E7J6GY=;
 b=AD8hj7SkBVrl7MSRgYH8qbqeyjOCSuOghOtuVf7wK6/cA7TaY718/Ba4EAT0oDMyxk
 qXfA8v3/LI2JCAOoQszrf0+fykkTD05p4J8/ACduUhAWu9q1rVQ2Uqhis39biE/qz5Ll
 qMt1FqfO9Lk6F0TMDUgW1J0Es6qrj8x3RIqKE8ADpd9oiAj7WlQ6KbScMmxqeZ4nfiiC
 WeTLasCqQW8bTt9MyQ2WcvnNH1h84C9CG9khgyxwrC3JhWfuk0DFABe044ZeAW/nYb0J
 aCq8QWhKKlwqv7UaMLaoIZ/ZgsHYqxw+pPclTU5l8k6qDEcJBIMt83JTg75JtdZvta9c
 cJrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791452976; x=1792057776;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=+0lxLpCVJYJJhi0tn/ZKaHgAExPnkRUaPKR68E7J6GY=;
 b=FGKq8KOdCGQyYlZX58FeDRI6mmvvBOoDw2xP4ify6LnWdtnm6ayw5Ro4v5O8k/BBJD
 WIMUD5hjXCKg+lIwadmeWqMpmgen5i/sfdZVh+F6SKiRKaIo7dbll62bvP5H31ZsMjXn
 4H/g8IjiB8TxA1r/dFa0NPSRizPHnG0SwTZ20y3c6kLV6UWM9wQhE3TKFT+KWca51NLr
 LU2O+OwD8GIzh85e65ay/4U5FCNh9M0aOYQtEomcgT/SOgyyECCTKb5xEAe72ggx/4Pa
 GgRjNp7PnZPE2DoN3QS1HW3hQn3tS8wi+RJpWVcWRDxyTwoQ4B7my3z7MYq36LfspsJn
 c02Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBziwfk0zlTDNoj+9IzPi57UUYjNgEp6LYhwv4RZ8zsAVEN/y1OQvEwAEQBIOvtrXgV9dL3dg4I=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lxkAgvbUpxpIyfgkdVOGkP0o1z5NUNOCT8v7R7H4qFlp9vaDb3
 BYOGVN70DVlBuC2agJpLcmBASh0UEO4Ch4d7N3X9PomxmlQhM+/cH349X1IJFqY35OI2KWye6L/
 HP1HhX0Yn6qLPqvpaRSFaStyFmFWrR50BRSL0kO8PAONv1z6pM9WR9TdHKD9YUeXeo/1utFY=
X-Gm-Gg: AYBFou3Y3wAMaj3hUxkiYNcsSEXaMZamPuE1VQ7QuiN+EnBKr61+cmvd8EtjHCV9R5p
 QCUOpkak2fAyPj3RhAUkfuTVvIj+xNDQ1RKo31baRMXxPG+T9YDzK86jKfwETUPRzKGuPcJL/AH
 PfPCQK1k298EIHnRL2VK35x/feAbEi0GOZf5Ky7Ut6rQpw8mBvTjCj5P1nJgjwSO/pXz1vV+d3J
 prPqxcrebmZ7dLS6KeDANSMMoDvrDQUPNZWyBETv/nw0SviSqd2Se0NyoGdHl5hIypC0VW2AMrr
 pfujvvD9FTQhw3b+7c8VEOij8kRXZ8PHuzRGZ2NF9z27t6EFA85l1xHfx+4smf3H2aqoHGGZxwQ
 JZqAxUyz9CHaWWMycRkokTXXi30CVkQB2cImJ8rMCzSLQIVM=
X-Received: by 2002:a05:701b:4588:10b0:158:b944:b20 with SMTP id
 a92af1059eb24-162041de5a4mr5901238c88.11.1791452975841; 
 Thu, 08 Oct 2026 02:49:35 -0700 (PDT)
X-Received: by 2002:a05:701b:4588:10b0:158:b944:b20 with SMTP id
 a92af1059eb24-162041de5a4mr5901201c88.11.1791452975273; 
 Thu, 08 Oct 2026 02:49:35 -0700 (PDT)
Received: from hu-abhiv-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-16375a1f898sm9977818c88.0.2026.10.08.02.49.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 02:49:35 -0700 (PDT)
From: Abhilash V <abhilash.v@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org,
 aswin.murugan@oss.qualcomm.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, lukma@nabladev.com,
 peng.fan@nxp.com, jh80.chung@samsung.com, tanmay.kathpalia@altera.com,
 abhilash.v@oss.qualcomm.com, sjg@chromium.org, Michael.Srba@seznam.cz,
 varadarajan.narayanan@oss.qualcomm.com, luca.weiss@fairphone.com,
 nikroks@mainlining.org, balaji.selvanathan@oss.qualcomm.com,
 jbx6244@gmail.com, u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: [PATCH v4 12/13] arm: dts: shikra: retain SPL dependencies in IQS
 overlay
Date: Thu,  8 Oct 2026 02:49:11 -0700
Message-Id: <20261008094912.419090-13-abhilash.v@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261008094912.419090-1-abhilash.v@oss.qualcomm.com>
References: <20261008094912.419090-1-abhilash.v@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: xlXyyaNQ50e548fVII3FAObDdG17yVRz
X-Authority-Analysis: v=2.4 cv=HcWB3SE8 c=1 sm=1 tr=0 ts=6ac76730 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=qkSexMeQyOevtdx1QFIA:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: xlXyyaNQ50e548fVII3FAObDdG17yVRz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDAzOSBTYWx0ZWRfX5ot/NjkWCZSP
 XBw14Bqz7AiYOXtcg+Lz2ICZXXoueyZXxEWkKRO7gsmAdUJTeQetU3IkkqcTNIWiDvAAtD2qx09
 lxcmB8djx1xqGpkdEeKi8QVHqq2H+FqXbcejgNk5jr0xoYlqG2uXy1Ie7d0gkm+y5G4qpTjL6bl
 ckjYhi1D7OmixvR/bP8KV8CXw/YzSnqVK2IsNnIubsPQ73Oa9cWZLFAcWpqhHWxgaVx1ehIo6PH
 kJvEtbP0MbIJAW+Xpigx0I3In4xpC5e7lm6189wUd95ee5KeO7dMeSPMxts3hdwxdHvoMgApYCn
 TFxr9dxiVin2wRTmUnVJtnNPIaYkjXbOBH0i8Gv85keUCP07uLnoUAxvX8eOrIyyZ/FwULrpFPZ
 GclPpk4kbmG8LcuNPwmHYp+fAt0tBeOFK9cAqY4U5oBWvGDV3n6vvbiDJbyhxVF3RpkDuYVxCCD
 eEJTAwYIa6mVfxEy7Dw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDAzOSBTYWx0ZWRfX23ma7yuYGv6S
 w9UpheBUMhHEB9zJYGTidakqUXdUA88cdnbd9p+DNSCyA5k6eAKYm1udlXCopnExHUicQ4uVmV5
 SnZenX6voBjqqeqQIS4cVgnMCBoGw7s=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_03,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 spamscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610020000
 definitions=main-2610080039
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

From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>

U-Boot proper uses the IQS device tree on Shikra. Retain the SPL console,
QUP firmware storage, MMC, clock, pinctrl, and power dependencies in the
same overlay.

Signed-off-by: Abhilash V <abhilash.v@oss.qualcomm.com>
Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 arch/arm/dts/shikra-iqs-evk-u-boot.dtsi | 42 +++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm/dts/shikra-iqs-evk-u-boot.dtsi b/arch/arm/dts/shikra-iqs-evk-u-boot.dtsi
index e807b91ef1f..a1e506f7dff 100644
--- a/arch/arm/dts/shikra-iqs-evk-u-boot.dtsi
+++ b/arch/arm/dts/shikra-iqs-evk-u-boot.dtsi
@@ -20,3 +20,45 @@
 &usb_qmpphy {
 	status = "okay";
 };
+
+/* Keep the console and QUPFW storage paths in the SPL device tree. */
+&gcc {
+	bootph-all;
+};
+
+&tlmm {
+	bootph-all;
+};
+
+&qup_uart0_default {
+	bootph-all;
+};
+
+&sdc1_state_on {
+	bootph-all;
+};
+
+&sdc1_state_off {
+	bootph-all;
+};
+
+&sdhc_1 {
+	bootph-all;
+};
+
+&qupv3_0 {
+	bootph-all;
+};
+
+&uart0 {
+	bootph-all;
+};
+
+/* Retain the RPM clock and power-domain providers for boot consumers. */
+&rpmcc {
+	bootph-all;
+};
+
+&rpmpd {
+	bootph-all;
+};
-- 
2.34.1

