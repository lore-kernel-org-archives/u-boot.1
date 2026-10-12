Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D1EACA9ED1
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 05:35:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D319760640;
	Mon, 12 Oct 2026 05:35:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bbO87iw-nOxD; Mon, 12 Oct 2026 05:35:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2C8C860739
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791783328;
	b=M7rsf/ETRYStJH1x6Ti/6B12N7H4ij/RXoa1SS7Js8RYKW03pF/wL3In70NFhBnf5gKw
	 LdHq6X27QSemmqiY7KlNU7/oqU9leBct4abOgQRMv0wALNiM/QaQWmOEK2VwDyQoHS9Am
	 oHnho5hg9nzIdy8CtJkEWLRmQ8VRp/8TdDB3QE6LEJ4Y93T3NRFGYGy5z+Jt0uLP/Q0kb
	 0Jpl4DWQ0Yp2k4MU4idS7dHOyp4S+i4RyTN413XkTBgPa/0n09h1HBGH5E0LgLVjWhuUV
	 oSuXO1WCEjDsw14PQ4sG931a/0HgRSVBugwWrLZEGs+Zu/bxb+HdMR9YRkKDKBoM0cw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791783328;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=zH0KMzquOCu45yk9DRvJaDKdjUZVIhhoXDbnZB9TeZ0=;
	b=BtypEGlpSWN/jd/KpVV7hOp/VEANOe84j4zfqSK5nJzsW5DzaxNozT49ETljLJ7kvAJL
	 jqZHIjhGZiEuGXFD3ra5wg94hLU5JmKEIijywqUXpIZwEzL9pyfMrxZlvasSMwu0N90nV
	 S5JQ+qceeiqgMsib1yB3EiMHCWiixmorkbptBNEwX798dhpfrn0HV0Ox0xShn+azm8aUZ
	 7b3sVU8FBIys1wsLfPFlQxp+I1/q8t8Dls8+Jbf5sY3kd5WmowIKxB8UOplka+vvxe/al
	 JmklcFF1vr3yA69Bb5rxrZmqSQpqrt/60Mmqmq4kkSanldXf7ZbEw4+JSWe2gUFUJiw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791783328;
	bh=zH0KMzquOCu45yk9DRvJaDKdjUZVIhhoXDbnZB9TeZ0=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vZwayg6UEVTa3Da3TiAslDIpvkvAwKeiMXu3kslMpL7+c+71dKysRlirkvjy8i4Ov
	 nBNd4RM4pq7iaTNhD2UCwDb31MI77s0tkhVidFNoV8elJE9hD1xMtZLQPjKak2tlXE
	 nLXq5+OTQ98d3LNGxyOID5xT1z8ZSrQrdLwekgIpPV9IGdWZKDAJ9eTLAywpLgmD/B
	 p1pjeob6IE5rmxMoeAUaWlHE70exdmRlEp5iD+QpHsxJaWtIewH/Evs2m4ej5C86d/
	 /NVUkQwFC5dROhJfGEc/zYiaYhDEn3TTB/5MjvfHDsBfu1QHzwp5tgKlDhCmx5Wujt
	 PS9Ed6FVtat/A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2C8C860739;
	Mon, 12 Oct 2026 05:35:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id E8AFF9DF
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 05:35:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DABBF80CEB
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 05:35:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RgCrmwWp8Tmp for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 05:35:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0B7C5807EF
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791783310;
 b=oBJX3QXTxoOSuazoYd/YcSi7/7JNbTWYKJl6cna7QP/P8bED0nOPjW1OcyHLFcSnLduf
 2MNLWWrCyp+RtIkRukezez95QeSEdwkOkUMH9VZks63hn6s/ZJjGoGdGXKp9vb639lAvz
 a3dVCeh8XThXa/sQzleIkqRFKT1wCZBqWob7dT39EgDyOWwNHIqJVfAWbElkG5HMTdNGZ
 KOZdhAIoCwdx+HtqzlzyZCILM6A2C+nnYWxZuPl/7SRYjkNtwPfqWh7pEjyAc+i+Jr7uD
 73DN45la4bEwBKlNxwP2bdrR+yHrbitvnDwOILb0bxiD7vRXsZK72A8y/xZM0lc3kng==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791783310;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=zH0KMzquOCu45yk9DRvJaDKdjUZVIhhoXDbnZB9TeZ0=;
 b=PfIig1b+DPnwSduLiaxReFV9qdyIecP099+fsRxxAdXQQ5ilZEa02jP0I17rW0jCveRp
 8Z95O/2J2BUwSySSAN/ScsRmJdlnDhLSkvIk0A5mphVGWVPpU58NO8yV8K6uCyjfkOcWN
 c8wknT5HYQnsjbjGFouRnbq4CBVwrYo3DisdGFPdXU/2gzYcZtBG+qlB/UNPzwS4C2YSf
 EDwg3qCWHRATwWFEvuoBWcoxeec5o41qkMAQRnPnxe10yappEk41UzNHW6ES8kF1QHSY7
 pYnVyfYoO+tFTCuXuy+IEBV6KEAZNrbTvpucJa0lZo6MUDlVjpONr/Df5FwAf04XqTw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=ONKPI2ac; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Lh5ze4zF; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=abhilash.v@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=ONKPI2ac; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Lh5ze4zF
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0B7C5807EF
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 05:35:09 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69C5Pa441787032
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 05:35:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=zH0KMzquOCu
 45yk9DRvJaDKdjUZVIhhoXDbnZB9TeZ0=; b=ONKPI2aclH3q/Z911W9Vw4f0rzN
 4mksNVR5MamyJnFhlBdP1hn9UozkSUvTMfHVzKzfmVUu1Nl9YS5T9GsgLEDS8W18
 K1IF9XK1rrlDVfw7oIvcsm79BDnR2K60JkR1pRi40sGgmaBUA98cvlaZNINUaMJc
 Sm7VrNQ+RiBiHngtBgNlC2XctR5aW2SyJwMmeJs4VsfRkggm3DEqc348IW7wTHs6
 VGk/LS53zYAwDt5Lpx2Qd6ALFdJ4aFYqabftbP4gZ+Uud+yfTMbnjRXfldpAPpT0
 bpmefS7Qez/L2zseAt2p2Ev4TaJKQxNAM7KR8ExyS+BJ4qgC3JchHNiRT1A==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8sd1r114-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 05:35:08 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-30bcb065bfdso3306675eec.0
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791783307; x=1792388107;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=zH0KMzquOCu45yk9DRvJaDKdjUZVIhhoXDbnZB9TeZ0=;
 b=Lh5ze4zFMHnrR2SjtFx6PMKMFI+wtmvMQlwu80CB+DE6SMfXXmca+8QJYY2F3zlyNg
 L7z1m6qk11xn8UInpeeHFU1FqcGxsDwqyTDRwTEO+K1k584/58gJfb67W5LVTMVQHOWD
 I3Q2tomLHCeOkgMdfQzSgxm6AtaYJ+mktmEuGFNiG8Qb8jsgWTmUSSCJpxLr3Ds0ZmY7
 7lZ1TZrJD0LKyWDWqUK3BU+ttQ4yrIaX5wa9r9mhdsZA8UjBm5vcKq+8oC+KhiCBm+rH
 AK/CMiqkt5ehZX5uc4xNKTiLCiWhpnNWuVhyGbqdqX0H3JVqJhGGNqryKMeYj+moAIWv
 IKmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791783307; x=1792388107;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=zH0KMzquOCu45yk9DRvJaDKdjUZVIhhoXDbnZB9TeZ0=;
 b=aI/4YOarjFfjR0kgrZXs87HanFXStefox7M80x1OtThU6HvXMPTp+WagkOMYHolLgx
 UyKLobMCjF2gZXMvl24jgDEL86/NibWcYlRfYvUlrWQEI+CrUpbpo+bJtnPhjV0ebbFM
 yMgbnhPJ2AObaeDtM4bCUtx558UPYmtBzcZOMltTlxmSFD9VwTjhjMQ0bIx218FfNoi1
 rgH3XyPnpbqUF7upIcfSCv55q5rAwqxzCmagJCFryksfslilATgOz8UzmSpiJUlvLh5F
 v4NzrcKj7mh/z+HyCQrHmchh+yzloU6/ZeTpfk9q8ORMbiNKwp3sMV6ZPShp+VtpC0Pe
 JpuQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBw+j/0VWBUjGz9dJTCxqE41g6pKq5qRsKfWTOD7Dc0p84QxH5lETdMC6oWPripqbuZvA48URiE=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIq7YJePhYMTrSxx/Vl0Qbxocq1T/kG220beOnZaeSl9smevzE3
 Z1rsnPEWaGPQteE6/0vG/yqh+x5U+tLDGkDpbsWhxPS8WaN2BSKl81JVgDH/3p6kCPoB7OgoKVM
 HrHqvVwttB/KyphugtY/iZDqipID0qOQxLSGSeBqfaGC5pPWBdh9FCM1NF+3YuoV0Epp7f+M=
X-Gm-Gg: AYBFou1w7WZoUCX1ozXg/yG9vEsEe5o4Uj7EV442LUeM/T7Yzxr6SECn5RO7Bzli3sq
 OnHkyX9ie0nVMS1zoc22i4dFznTk2lJaBkclcbX6HwCjK/QbbfoWXCA80AC0PRraTV0w7+2eOlz
 75qjJdROJYQdk/+V2w2AJevJsDwSSwYQHl02OfN9+3SX1FajuzdgcVURqwYlH5ofAEcpHxwOl4I
 SXeoE0BIMDKc8cc2mFUYEqmHa+9yA8q2P17bcc1xKlw1NbYpgmulRJXBNVpQYznFXhK0unZBqsQ
 uuTSw1IQ7vcl3uOwQLaZxMjrX1891AJ4kQpfCGOENWpxu/LXtcKDPYbNYmcSxPdmJZVrjjy2IRz
 5ZLdD1vpA0R+v6u4EplULnC0xbMSh8Yic2LHAzo6Ea5ese8QV
X-Received: by 2002:a05:7300:828c:b0:35a:5e11:bf81 with SMTP id
 5a478bee46e88-35a5e211ce2mr3417448eec.21.1791783307341; 
 Sun, 11 Oct 2026 22:35:07 -0700 (PDT)
X-Received: by 2002:a05:7300:828c:b0:35a:5e11:bf81 with SMTP id
 5a478bee46e88-35a5e211ce2mr3417397eec.21.1791783306674; 
 Sun, 11 Oct 2026 22:35:06 -0700 (PDT)
Received: from hu-abhiv-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537cab27d5sm33446935eec.17.2026.10.11.22.35.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2026 22:35:06 -0700 (PDT)
From: Abhilash V <abhilash.v@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org,
 aswin.murugan@oss.qualcomm.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, lukma@nabladev.com,
 peng.fan@nxp.com, jh80.chung@samsung.com, tanmay.kathpalia@altera.com,
 abhilash.v@oss.qualcomm.com, sjg@chromium.org, Michael.Srba@seznam.cz,
 balaji.selvanathan@oss.qualcomm.com,
 varadarajan.narayanan@oss.qualcomm.com, luca.weiss@fairphone.com,
 nathbappai@gmail.com, jbx6244@gmail.com,
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: [PATCH v1 10/13] board: qualcomm: shikra: prepare QUP firmware in SPL
Date: Sun, 11 Oct 2026 22:34:49 -0700
Message-Id: <20261012053452.1567885-11-abhilash.v@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261012053452.1567885-1-abhilash.v@oss.qualcomm.com>
References: <20261012053452.1567885-1-abhilash.v@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: MjJBXuPnTWOEH0aIjd5mrW2m3nGFPrhl
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDAyMiBTYWx0ZWRfX0oTUbch+0bSk
 3RsoXN6BAtD7BFp99mOSJe9lX1o9I9Y6Xp2w2x2nxX7qXZPQSLmMY2xqO+dwBF1wCizdwSA9zq4
 mrq+0VPv1M3aCutkc0nFYFeY9/OD97s=
X-Authority-Analysis: v=2.4 cv=QtHLTlyd c=1 sm=1 tr=0 ts=6acc718c cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=nMXrJebM6ccVpyDcoNQA:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: MjJBXuPnTWOEH0aIjd5mrW2m3nGFPrhl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDAyMiBTYWx0ZWRfXyuSp9xwJQhPD
 OyEzswiDcERdb/5ql6C2BlGdvAIRrfJwV709wc1GanF+L9sYMz8evyjBa6zwsKrocUy6ZOHSMb5
 E2KfGz4G1LoQSsbIXbW1Be2QsRyJ1bMjiUKsIt4H4ohFVw1hR0KeN0jXve+qvRIgfMsLwi6nuDu
 pWkXRex58fB6/6tsaiyPQA0qpS9RYxzdQKbOp0CepUxbytdvEaP6G9h9pvkg4w8L8UB692izF0i
 cmjomfDV6WLYJ+uyIMOJ0YFwf+u2IwA0WC17E/94WjF95H1IK1anm/6leCfqsdYkFABVjRwJyJm
 74cYfxGcfz77B7wYbXSVh2Bq/ATIkN1En8ATlhFP4PwF3Wk196rH5ICXolDv5LQ+gcdMKqyosDw
 QCUxhmKpRBSq80gbEaqdxQHD5UImCWkeMoKWDHhFkFolLH+oeETLsnwj0bK/KxX4WO0udP1p3nk
 FV8mtDMKEZXyQ0bHIiA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_02,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 suspectscore=0 impostorscore=0 phishscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610120022
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

Prepare QUP firmware support before serial-engine children
are probed during SPL initialization.

Enable QUP wrapper clocks before firmware detection.
Initialize the boot MMC before the last-stage init event.

This makes QUP firmware available from the boot medium.
Release the dynamic firmware buffer after children are
probed so SPL can reserve memory for the MMU page table.

Signed-off-by: Abhilash V <abhilash.v@oss.qualcomm.com>
---
 board/qualcomm/shikra/spl-shikra.c | 118 +++++++++++++++++++++++++++++
 1 file changed, 118 insertions(+)

diff --git a/board/qualcomm/shikra/spl-shikra.c b/board/qualcomm/shikra/spl-shikra.c
index 9c7068497de..091a2a49e09 100644
--- a/board/qualcomm/shikra/spl-shikra.c
+++ b/board/qualcomm/shikra/spl-shikra.c
@@ -3,6 +3,7 @@
  * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 #include <blk.h>
+#include <clk.h>
 #include <cpu_func.h>
 #include <asm/io.h>
 #include <asm/sections.h>
@@ -16,6 +17,7 @@
 #include <malloc.h>
 #include <mach/qclib.h>
 #include <mach/spl.h>
+#include <mmc.h>
 #include <part.h>
 #include <spl.h>
 
@@ -148,6 +150,109 @@ enum {
 };
 
 #if defined(CONFIG_SPL_BUILD)
+/**
+ * shikra_prepare_qup_clocks() - Enable QUP wrapper clocks.
+ *
+ * Enable wrapper clocks before detecting the QUP firmware state.
+ *
+ * Return: 0 on success, or a negative error code.
+ */
+static int shikra_prepare_qup_clocks(void)
+{
+	struct clk_bulk clks;
+	struct uclass *uc;
+	struct udevice *dev;
+	int ret;
+
+	ret = uclass_get(UCLASS_MISC, &uc);
+	if (ret)
+		return ret;
+
+	uclass_foreach_dev(dev, uc) {
+		if (!device_is_compatible(dev, "qcom,geni-se-qup"))
+			continue;
+
+		ret = clk_get_bulk(dev, &clks);
+		if (ret)
+			return ret;
+
+		ret = clk_enable_bulk(&clks);
+		if (ret)
+			clk_release_bulk(&clks);
+
+		return ret;
+	}
+
+	return -ENODEV;
+}
+
+/**
+ * shikra_prepare_boot_mmc() - Initialize the boot MMC device.
+ *
+ * Make the boot MMC device available before loading QUP firmware.
+ *
+ * Return: 0 on success, or a negative error code.
+ */
+static int shikra_prepare_boot_mmc(void)
+{
+	struct udevice *dev;
+	struct mmc *mmc;
+	u8 boot_device_cfg;
+	int seq, ret;
+
+	boot_device_cfg =
+		(readl(IPQ_SPL_BOOTCFG_REG_ADDR) & IPQ_SPL_BOOTCFG_DEV_MASK) >>
+		IPQ_SPL_BOOTCFG_DEV_SHFT;
+
+	switch (boot_device_cfg) {
+	case IPQ_SPL_BOOTCFG_DEV_MMC:
+		seq = 0;
+		break;
+	case IPQ_SPL_BOOTCFG_DEV_SD_EMMC:
+		seq = 1;
+		break;
+	default:
+		return 0;
+	}
+
+	ret = uclass_get_device_by_seq(UCLASS_MMC, seq, &dev);
+	if (ret)
+		return ret;
+
+	mmc = mmc_get_mmc_dev(dev);
+	if (!mmc)
+		return -ENODEV;
+
+	return mmc_init(mmc);
+}
+
+/**
+ * shikra_release_qupfw() - Free the QUP firmware buffer.
+ *
+ * Free the dynamic QUPFW buffer before allocating the MMU table.
+ */
+static void shikra_release_qupfw(void)
+{
+#if !IS_ENABLED(CONFIG_QCOM_GENI_MINICORE)
+	struct uclass *uc;
+	struct udevice *dev;
+	void *fw;
+
+	if (uclass_get(UCLASS_MISC, &uc))
+		return;
+
+	uclass_foreach_dev(dev, uc) {
+		if (!device_is_compatible(dev, "qcom,geni-se-qup"))
+			continue;
+
+		fw = dev_get_priv(dev);
+		if (fw)
+			free(fw);
+		return;
+	}
+#endif
+}
+
 void board_init_f(ulong dummy)
 {
 	int ret = 0;
@@ -162,7 +267,20 @@ void board_init_f(ulong dummy)
 		goto fail;
 	}
 
+	ret = shikra_prepare_qup_clocks();
+	if (ret) {
+		pr_debug("failed to prepare QUP clocks (%d)\n", ret);
+		goto fail;
+	}
+
+	ret = shikra_prepare_boot_mmc();
+	if (ret) {
+		pr_debug("failed to prepare boot MMC (%d)\n", ret);
+		goto fail;
+	}
+
 	event_notify_null(EVT_LAST_STAGE_INIT);
+	shikra_release_qupfw();
 
 	preloader_console_init();
 
-- 
2.34.1

