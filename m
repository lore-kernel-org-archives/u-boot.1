Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADB4606D806
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 09:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=zjHqulqP;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GoCF/oeU;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=M+rSC3Nm
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 61549409B1;
	Fri,  6 Nov 2026 09:43:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hR1fsNInPbhL; Fri,  6 Nov 2026 09:43:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 65DAE409AF
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793958207;
	b=oazjS7M3bsrqVBggsS6NgHcr3/bMDktZ9U6SMqNM4Eiy++ErXE3vD559ia9hBYnvqpxr
	 AwOgGeLOegHP4MavPSfo1/y8xMDqlh9HmAEexgt5miDfAfRPQkxgZoTlsW32lMm8ir+H3
	 iyflRRHd0tgfFYoKAFtkoiRjIDS1YEsBjdxxEPOHE3aqCLvqZhIKYdPrpmd/Lt39OAuHa
	 0R2Abtmc5VjX3ajC9MA6UBF5Fvnfogl9uH1HGPtBk2qYiYBad/TZ23rKps1f84t4ALJ8p
	 vmwVZ7tVnMv45XYchV5Gb3CmfrnaqWnIyqB04jytYNWiiNBlSAfXPz3EqshTy8wRJnw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793958207;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=FyHUBBavs86EcHCaCG1RQBuvUQAN6dQtp+tBllSbayQ=;
	b=oX+2kbOrI8+rKTfbmL3bau0wDMiKKSz+9XB804EFumbrnrDYBaWzZuXq5cobJeaONSfc
	 EWhhJ7+/Yc9ZwNPj8kpcv/c4d/StTP+EkfFwlmt8a8T8032yGyBsLBMXpht65vvlVtwEG
	 TU38H0lxfW35zARkXVDrRRPmY6PvaS5kGI55IE5bFwX0jaQF5F8nykac1+khi/q4iB9HW
	 PILzoMD+cwvtqA8V8EMyWM7meV4B+Pu1oYBqWYtz/rvqmGBf9I9sZWTUesnRVpaQd/9lJ
	 ctJaOJk8VmuB9aZ/NwYEiX5CcRStG6by+6HsExBke8HkuatgN/AICSPn/incZPveDCw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793958207;
	bh=FyHUBBavs86EcHCaCG1RQBuvUQAN6dQtp+tBllSbayQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zjHqulqP228O39MKjVp1gDMV6sY/Fb6H7B7MhBy+BKxYeFiD8I12k6QDuF/21MLWB
	 PC1tnCvcH3Gm2beZ/qi+ofnDEmkTLbT0K2yzXx8mFzKQcWfpK2ZwE6T+AKlSBTED9V
	 xf+pko/Hb/fv5nqxLimVlyXVSp8CW0G0fudr1c74zktrtPdT3sDYmuhvZYqV3Ijccd
	 6m3l/QIBs9iS8LTVp/wZyE9BF30r2AEDfX1Qsbg7ZOusL9HAXOH1kpLNlYTV8ZGVnh
	 COgubJJXNaqzpFt/8KtCirEjr6gOJUOAG52w7ah8NI5yP4JRpxXSAA2LE2Q/XmEv7H
	 J6dJHn03TjqXA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 65DAE409AF;
	Fri,  6 Nov 2026 09:43:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0172C2AC
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 09:43:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E70B36069B
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 09:43:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VeObfNykQWeQ for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 09:43:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 39A1860640
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=GoCF/oeU; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=M+rSC3Nm
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 39A1860640
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 09:43:23 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A67R5dZ129121
 for <u-boot@lists.u-boot-project.org>; Fri, 6 Nov 2026 09:43:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 FyHUBBavs86EcHCaCG1RQBuvUQAN6dQtp+tBllSbayQ=; b=GoCF/oeUxBIR3HZz
 sry9/G8nO0dfsirpdaMOIFQV6f87UX6nkhBPHqM181P5BoyqUR05MRN0AIjXbZrW
 eX7TGeyBRYBmvzanFv0f3oGo1lCPvPyCSBWhmL+3a5km9fSiLldjTwKrgcA0+V2q
 B90tHtV4zBRpCZ+IGYhi8rdVPfS/8vBuwjClyGSchFK2mIi+2ozsbYtFIMPDyab2
 pSXU0Wd7B3BPLgPvCfYj5L5mTI7msDzhgfM4hjpoLTWbDCQFLjLOiospNymeRrBr
 zEk/+ptNHGWDCRE1Do9DVLjxKUlh9SLr8Ywlo+s7QADaVDxPY4ETGMFo53lIrSW9
 GOL0qw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hs3p9t68t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 09:43:23 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93f62934ef6so103039385a.3
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 01:43:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793958202; x=1794563002;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FyHUBBavs86EcHCaCG1RQBuvUQAN6dQtp+tBllSbayQ=;
 b=M+rSC3NmoH7uSFn2rQ0w2pzA68XCMRD4psCaRDBjkL+akozcIo+hOLTyxqtGfjRvHN
 IfzjRvE21UlbBm16Bkrchvl53uER3rfkA4lXql+47gQJq/Ruq0SrON0pxtVVXKPm8xAw
 lJruVFCdOeb/29aATrsHhUq4QgWpuAxcPexIQ1shxkowlP0N9q6gXPVc1eWlIskR6RxA
 f+UhOosyjLTtUa9qqml6m1gbZh0YhtG76dalZCCPGC98WGsdNS2z2Iz9iMZ3iugjv+f9
 r5xL6I+rMdNvOeC4hKQ5FnNJL4Cv326LsCAVOmPpfiqOI2UrOt4KwKoCXLvhAYzz/ywk
 520w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793958202; x=1794563002;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FyHUBBavs86EcHCaCG1RQBuvUQAN6dQtp+tBllSbayQ=;
 b=eiSv5EFQVELnoR/2RH04sdiOMeD0CgJ85oc8JkvZYpgJzsdPb2miKdK4GBRuVoF3tl
 nz3iTRe78J3RArFNCdQr+A9AScVu+JR2T2ifXPpizvrPN1AQIBCdMRIG+UI74curjZuE
 URIb9Cw7YqutozhMNjtYJTC79xbBNrBZPh0zu5tOyVFFxssfFW5G4eG69UzQhH3zX1+7
 PH4dOgvt+8IL386+toVyPXLi8LFW/n1/EhVGVNz3ecdNg/1Kq3dmiAfTENpkLw9fge2I
 EwQnKhn+K0LbahE/bfYeYyNLbmystGaHWABuA4hn4GQbdn9Q03FBxa97gwh2MExikQ/N
 8cuA==
X-Gm-Message-State: APuU4Z/W/CXKJZr6A0mQVOIDrm9JOeTPSVLp1rUsIX7eTQ0gPTSUG/A2
 QQpyvhqbtPLKdr3MLOqcsZ4fjZXynXlvz51QVZWLK3TXa6BZVlEkXKkvY+OjP0N0I6bUEnOQPaQ
 /FPl1EDLL7+pgVgmykZM8Hjq1xbxdgMNbitRwBeG0zxNunRAC+Xvlsktkuj5sThKTxEAGl8o=
X-Gm-Gg: AYBFou2NFH4NIh748Fl9bX6Yvya3vzc9j5IY2cTsX+99MpMVoZftmzH1VteZ9GCsmLb
 Ei0onGJeGYQlpBHRRPxEzCPmaqYMOMFyeTC76IfhSqDNigkSWY8qYoZX0fKLzBVRd2Ln77hfebe
 mj2qWVxOw0OYUKH3v1OydIhMUbdGPpzlEeVLYuKgodzB1bP4YxNg9FHrpDQDPd5FMjhJ87TLgi/
 vS6+2LpH/kfYSLjMrLQIOi/8x1PbN4OWBlP6KlJCLevDQKmB78DCwFFqgrfdS7cWkv96+kjpYu3
 MFHiMp68GLnGRBBBD5KR4V4QalZSLNxn87U/t0crIrVq9s4eTf//gUMLZl20MA2BGkqIvk5DNOj
 EqKZdlsVHbD9DueISHgfqXUQ1p2cQI5XUnYrs9d3uceRzQs1puAB80U8VU6oYCfxwj4Xt2SWYOZ
 5SOvOS6kgE3TDL
X-Received: by 2002:a05:620a:4628:b0:93f:2463:f784 with SMTP id
 af79cd13be357-945f350a772mr273004685a.66.1793958202176; 
 Fri, 06 Nov 2026 01:43:22 -0800 (PST)
X-Received: by 2002:a05:620a:4628:b0:93f:2463:f784 with SMTP id
 af79cd13be357-945f350a772mr273003385a.66.1793958201707; 
 Fri, 06 Nov 2026 01:43:21 -0800 (PST)
Received: from [127.0.1.1] (93-159-22-70.cgnat.inetia.pl. [93.159.22.70])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4d3562ec2csm64822366b.14.2026.11.06.01.43.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 01:43:20 -0800 (PST)
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Fri, 06 Nov 2026 10:42:43 +0100
Subject: [PATCH 11/14] configs: sandbox: enable the firehose command
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-firehose-v1-v1-11-e7591c12fc65@oss.qualcomm.com>
References: <20261106-firehose-v1-v1-0-e7591c12fc65@oss.qualcomm.com>
In-Reply-To: <20261106-firehose-v1-v1-0-e7591c12fc65@oss.qualcomm.com>
To: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@nabladev.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Marek Vasut <marek.vasut+usb@mailbox.org>,
 Johan Jonker <jbx6244@gmail.com>,
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>,
 Vitor Sato Eschholz <vsatoes@baylibre.com>,
 Carlo Caione <ccaione@baylibre.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Simon Glass <sjg@chromium.org>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>,
 Vincent Jardin <vjardin@free.fr>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Michael Srba <Michael.Srba@seznam.cz>,
 Biswapriyo Nath <nathbappai@gmail.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Rasmus Villemoes <rv@rasmusvillemoes.dk>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDAzOCBTYWx0ZWRfX3xWyCAvNVusg
 vgCWmyRIhlh7ETr5rRqjSfqC+bYW70iCAb2gHRQopeg8HjeoJkm+oqBJOuLBiSIYpiRaXKlouck
 TpYeznA+eCg7FUYBeQzq7EuElr/49+g=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDAzOCBTYWx0ZWRfX1B3filnssJ5i
 WAp9JaDiwHo8l7TtdOhAvOyh5RJ9dzpVPQy2huoaX132okXpyu6OO8FmVlWMr1x0qw+5VgC076m
 gaOtqH+RtN23se2vwqsurnxrLGvazvj6SA7OME5OKcIDvpDvUXWJJpleCoKqsX/dcRmj5hcdDq8
 ualxkBvr0wxknbLNk43aExYfKF0n5lIltTiDQZoU2D4GIo/QFPPZrvbcJBVIiyoeTGnp1s6PsHs
 eonhAEytgxewQL7Nq4I7qWtS58vTg7kDRMu88lB2tdfAJPwuXtjZGHtY2axR41MrTO9+vyvGJKJ
 8SX2aZ1FhkBTpkUCoBf34M8AYoHQMNPSPKD9z7GqzAX8/9qjWYPgprcuLIqdegXNM/2WSuLHR2w
 2YkP9FT9cp+quFQWlrSKzbptzmI7u+etWrI2Ejph/e26KtiPR+giKIf+n4A7LuUBi3oHMAwxjk6
 I+XhW/8zwrjQrs0UIyw==
X-Proofpoint-ORIG-GUID: 6LHyNLtD9v2Xb4fIqkkH8j752E7hJMbR
X-Authority-Analysis: v=2.4 cv=f6Pdl+yM c=1 sm=1 tr=0 ts=6aeda13b cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=ySe+0nHqNG5yihRO1pIWsw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=MqYgbl_MLcuh2LLqNG0A:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: 6LHyNLtD9v2Xb4fIqkkH8j752E7hJMbR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_02,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 bulkscore=0 phishscore=0
 adultscore=0 spamscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060038
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Build the Firehose function and command on sandbox, so that the parser
and the command can be tested there.

Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
---
 configs/sandbox_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index c63a4df8bef..05978d9fad5 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -108,6 +108,7 @@ CONFIG_CMD_REMOTEPROC=y
 CONFIG_CMD_SPI=y
 CONFIG_CMD_TEMPERATURE=y
 CONFIG_CMD_USB=y
+CONFIG_CMD_FIREHOSE=y
 CONFIG_CMD_RKMTD=y
 CONFIG_CMD_WDT=y
 CONFIG_CMD_WRITE=y

-- 
2.53.0

