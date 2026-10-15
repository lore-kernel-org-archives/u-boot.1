Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C770CC6B33
	for <u-boot@archiver.kernel.org>; Thu, 15 Oct 2026 11:01:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D222B40795;
	Thu, 15 Oct 2026 11:01:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id r69iid0hhPjM; Thu, 15 Oct 2026 11:01:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org CF1BF4072F
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792062065;
	b=CxNPDpeKPQPNrh/csk1UzH1SnKB/4IaMgWg2GVdpsEEd9QUqZnpzovqZ9vDKs2sZjTPy
	 49wObfv76xxuRALcGdnZNU/Hx4E8cU/Su5umjrtS25kkd5vkm77D4wqMP7Zv+Y3LbvZgM
	 RAhgrisGUD30bHB3NOeWQUB56eP4unKR2Fkz17F/501IRkRpsSqn1KvaVW/QZOZzrjsHg
	 aG11O+cSzhuok24XY9kfbdL93BVZp97fmbNuCzXrYY4/5igV/HYmOGuTkbk177CjCAWC7
	 d94iQ1btUliJ8PsfkPA0z8vF7eXR9q4po7tW2pcfIamWtA/Uh2DhKSErSjGeYLp29HQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792062065;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=LEyHOXRxxbHWy7Gxt83S29ABYHnK3afwHwD3MwIPT5Y=;
	b=D8GlReaUjEJWiQEYT8dYKSX/UFojQUMdIatpgXhSSoeZx8di1AgwNQjHydTWRLFuyzK1
	 DNTYKj5N//HmrE7TnG61mGvRGPf7fXg5CHVHTVL4t3zFjE7MXmrfnJLKxSWwLaarOrm6X
	 inVKW+bqRE1qmZksYTQaHUdJ7BbIxOLbJ2Ixttg49TKT1UTV1jOsFRonSU7V4CfYuGOqR
	 8lvsdl93MJjRYo98WHe7ZcvJzNYAliprdLAFQSaVJKvCiwq3Y71RmuBcqiehmeU8GGBpq
	 kyFCv88rvze9LpYUXRZNCvgwuBNGxBvyIonv6T3C4x04Hq9w45BcoAWRCOGp59R0yVg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792062064;
	bh=LEyHOXRxxbHWy7Gxt83S29ABYHnK3afwHwD3MwIPT5Y=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=kfNhPhZ7ivDuBrjx0ro30V60kAUeAJ11ipUVV3SaTRUWZ6UE9q/jaLzwWJXz+LebY
	 HZGR4CeXw/wW7AApOz0PDUgufoR953EPcseTwm0xQIknjH2vi5+fnLE0NA+vtzCFmK
	 9cEQ8stMbFouwxTVEklQNLkqBm1NcHKqLMGHtE3beK3GnBtX77Aax4qv0Gh3k/GF3c
	 BqsfMMdDEor04JmajKpp0xLuEHQ0cqZGt+wqROE/E9eMNQchnGjf6yvYISAgxsoMmj
	 dBIDfP9ItzgG4WU9xPWuB/+BhHhOjHi1ICn7Kj8L4j1/RL92pGmYUgNNYXbD0bQPkK
	 +M3NwUPHyMSLw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id CF1BF4072F;
	Thu, 15 Oct 2026 11:01:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9427F75
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 11:01:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 91AD980F7B
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 11:01:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id f_WCnEQhD0Za for <u-boot@lists.u-boot-project.org>;
 Thu, 15 Oct 2026 11:01:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D45BD80F4A
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792062063;
 b=bvSAQbNUEGfv93r1q9KiJH4oF9VfzUr/Cq0EmeOWAWQcdOq6aBLx0PeMdAhEOUiIOafy
 mD83+yYlaBMyUJDy54W9YeiXfFaMv0FuC1OhO95PzA0pSUQXoZLF7RQD1gxVbQjVx67OP
 BrG9QBiAIESDPNFHpaE7/QhOor5j91K603pid8AGmWnHNpzvEffFmqeJe5NDBQ4CoLa+Z
 dniJPpt5hOhk3ani1vsM2oF8wTdwI7MEjdF6RDC+qvkEiWCxBxDMsFhEVtK2vmMo10pW2
 mtIiF8JSct3bY1NAUifjM6FtTb68rG+vNP+V6Qe/4rfk/0iJ7pZLcoqlAtiTG+Qk3Zw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792062063;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=LEyHOXRxxbHWy7Gxt83S29ABYHnK3afwHwD3MwIPT5Y=;
 b=UbxmyOPLFXiD8k1M+fPRKQ5xs5ZuNBUAwGTEvIVJ01XHg7HEP/yFW+QIcwSDZvUK97ZS
 cEPsLx+V0b2R/bVu4HC7OOl8MtrdVy705R0ZxiE29Wn1PkblZ64YUO6tUqE3hweAr/i0m
 1/me9Vrdfj9vjDxIp1QE1HLAEzkc2AlekXVPXA5FUIty86eLxsuwPSmo3gMXiB8S4ak/P
 HAZ4F8xX4fgx7zi0eZymBzyz1Ps3vw7z7C/fFubftbNDm/9TkLvn7HND2au4iOp1GanZl
 ZJKl5iWTGbGs+3x1u9Da1+NAPptO35KpvB2GP1DoVl+QiLZfJ53ZFMyKXRFtHxpqb2g==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b="bX/B4/on"; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=aX95kQHt; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=vandhiadevan.karunamoorthy@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=bX/B4/on; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=aX95kQHt
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D45BD80F4A
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 11:01:00 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69FAPeL94100213
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 11:01:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=LEyHOXRxxbHWy7Gxt83S29
 ABYHnK3afwHwD3MwIPT5Y=; b=bX/B4/onfwoGNKK5aGAd2+8PTXuzh9NXMpIiJf
 EoulXX5SdB15bs5f/NiJHWOAuE+f+uqLPs5JMggMnS8qPkd8zeAD/+LbesrzpuOo
 5nWN7wngNmqnKwVD4io7F7lUdasWby43iBSdzlvURVHaUDeExkmpFkzYWf7RRGAd
 /JkxGXiznd/pD34fb7x9JsSO8dXsgY+BIb4MlUJ+sr2I23NuGya+o/FyDEBPEbco
 nEr5tiX8Hu/4gNphBKLOszlj1woUGfhMsUKL/0zu3SUQkT3PBPsogwOMf82SIBkX
 H99eVPidSvO8/Dbssh3AGuMFtfj3d3TEzQsllKC5U7VicqNQ==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4haw2r8459-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 11:00:59 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-147be78cd56so20370255c88.1
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 04:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792062059; x=1792666859;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=LEyHOXRxxbHWy7Gxt83S29ABYHnK3afwHwD3MwIPT5Y=;
 b=aX95kQHtKTJvNiIG0k3jQXBfLKDGp/p8Lr9QYaIBpiztfUHKYakkORVl3KIpEgwCAy
 ken51IIOdbuDoSA9xkaP49t4tNg4C8OmRoH0BDninW/JuOoXDanBNDZWTt2nkOEIUz8Q
 21pVJxT7x3VybTmBcHtisIEYx40KmPyhEETBQDpy0IROry9JimLXtywiI3NyF4zsBvqK
 F0Mp/UOLpk8On6d3Tcqzm10Mc/eZJKRu3znhYphFFakNPtPQYluKvOxmLDpCcGUxvYmt
 n2S/xv3L5JIwKVEQpB0Wb3Y4D62cX2w6iZVfBYuiaBn+iclTdyNpwiqxjl3txQQIjYx7
 cmGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792062059; x=1792666859;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=LEyHOXRxxbHWy7Gxt83S29ABYHnK3afwHwD3MwIPT5Y=;
 b=bPeSEf1HvpPEr4TsDJBYVI6j10MTacT11uDvdOIwqL3q3fclMC8XcP4U2oNGuSn5kP
 wFno4mvFS9pB8ZoAhf/5ceKHjybKjpYXULm6X5zisn52TK4cCEAb6D/C+mUKg/BZLplQ
 D3piI5Zilozs6R2SFEAOA8rv10ezn+uLEcxQfvGEEao8M61vF//7d8/IxCMCSxHTolXY
 1oOdRfkgeiSAttYDynZaZtuHkTzATJ5sdImm+tXTkwaPOx+5UNDMQv4zRjykq2VD1YC6
 XgczG/wjC+ni+vGChjoqyqzD0FvJNV+CRkUD7b9I8HjpqflfqAmUZnIV2P6UvGMnwqwy
 KBFg==
X-Gm-Message-State: AFq9FYIiuhVWEAs1J2SULRLdiuo3m8HJpFO69Nw7c39V7IcLZEctn5iJ
 Kb2J5yTjM8NZ5DpMngk48ybU0j4dILxFAyqNq2ksJBX6Xs1PY1w4W+AOp6WEuEtArkVHcrIbAIk
 iQLjg4jnn+Q8rKi+45yfuSCzzYPwdmh5KvM1JGcZ3KppVpwAJqY+j322CrtilaWpYwz5ZLQeyJr
 RTzIA=
X-Gm-Gg: AYBFou0UjMy2rmf98bFdFFX+S0wdxyRsoKpHOp9hwf6+NNbD8PzMIXinNHD7EEIl+4K
 EmEcs7ls/+B9qqTJ3QDjRhe94ivN0saWdyV/sMt7VhXf0+J+yi1wwQBQ5DIYH12sTR/fMR5uK/S
 cL+fIOlQuB91wQORukTlG5VY0diXVIzPe+yYRvoib0208giOLTgJdC7H62KoHby6lgRBvJODI4s
 bspi2KbumKEZTOPok0WMxy4gxO9hKZt6qX+UQgNGpXYW04tAY6DtYhVKg5cUadZ+6ZqowvOSpNk
 uZIP0jrBpRD4bY9tniquAcXmDGl3JOWaTCOEZ/cg/Dpx9fH8Wbys9tC7D6qAwEqpuSEFEl1Hv/t
 0VYEnzSAis4Pn44SQnxf0XPJESFKjJML5f+z5TmoNfXQ4K7iMM/DO/DUZkGfBwiW2yreCkPVq1E
 9YtKj3WQd25qZa1/nxryAcRnz3KM61W+c4NnZUrw==
X-Received: by 2002:a05:701b:424f:20b0:151:7831:e401 with SMTP id
 a92af1059eb24-16a61789f95mr25952308c88.15.1792062057691; 
 Thu, 15 Oct 2026 04:00:57 -0700 (PDT)
X-Received: by 2002:a05:701b:424f:20b0:151:7831:e401 with SMTP id
 a92af1059eb24-16a61789f95mr25952252c88.15.1792062057017; 
 Thu, 15 Oct 2026 04:00:57 -0700 (PDT)
Received: from hu-vkarunam-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-169a1becefdsm54892149c88.7.2026.10.15.04.00.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 04:00:56 -0700 (PDT)
From: Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 16:30:51 +0530
Subject: [PATCH] arm: dts: lemans-evk: Add SPI-NOR flash node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-lemans-spi-nor-dts-v1-1-8c2e7330f1c4@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAGKy0GoC/yXMQQqDMBBA0avIrB1IoljtVcRFjGMdsVEysRTEu
 xvb5Vv8f4BQYBJ4ZgcE+rDw6hN0noGbrH8R8pAMRplKNbrChd7WC8rG6NeAQxQsrR4fThlqihp
 SuAUa+fubtt3fsvczuXif4DwvUAay/nYAAAA=
X-Change-ID: 20260916-lemans-spi-nor-dts-4a1f7c02e938
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792062052; l=1677;
 i=vandhiadevan.karunamoorthy@oss.qualcomm.com; s=20260817;
 h=from:subject:message-id; bh=Aa4AFn6TbCfbyZXUOdt9CSszeGQ8KVhLuwx2Da8TSC8=;
 b=2n7+UdEsJzlfLzk3BRe1VdqsE+KW7AJA/eeUFlL+Kb1bvGekSrI1FSiV5FTF1pUBbrj+hW/Wv
 2OJ58aeW2YuC9goX/v434/m9HurLCzYSqJCg6Buw11KZoq/39doyYjh
X-Developer-Key: i=vandhiadevan.karunamoorthy@oss.qualcomm.com; a=ed25519;
 pk=2EVV7DmKqYX4wxSlXPB5QBt44JjomLlz/wTW2AL4H6I=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA0MyBTYWx0ZWRfX3t7h7EIncRU9
 HAWqKfBAWq82jWp30T4/6yC382uyGqb02OSNsakjWmaCMZ6/VQ2Q6UB3jQQA38w1tPOBSgDNbGC
 AumnAlVC7Kq50TmFPtFRiedDdxVPiIA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA0MyBTYWx0ZWRfX4OX5LYWv3gxp
 0/VGykV6AxXWohBMQho88+eAycF01RvSkKbF4caGe3YewUcK5WlLfHCn5WPiTCRKT8+Fhvxs6YM
 VSGhT8MyPOG2URcSl3YHkiNlAKPHHjLVeJkXvWa2AOMFFX2jDGUBKSnp61WV2dF0CzRwPddVzOJ
 kvTDBqKNpreotpnxgsd4bPmP6TElIqIKJ8uG9gmvl5UNDfsNdrS8fhCNiihnwWjXok8Bym0dtPP
 Lexk0sD+QPz/hxqWYnDKjKy/g8GxOWh3kE3MT4bAcAbVrJIrVJQz4VVIS/a4NLa6aWzx0zAu6rs
 yKFzcgEGlHrv8NOEFM+4gFyBsEttMQcvDvNuiJ9Fq7xC9fXyEF+uQ33HBSmuKuKDMlBhBjSaW5L
 Gk8HuC2Piu1zCMn3LQL5NjWfu664UREIuCFe76mYo8I41DPrd+FClqDwK7qe6wldyOPUb4sZ2PG
 POrGW59agp5uSRsHKjQ==
X-Authority-Analysis: v=2.4 cv=BNMmP1QG c=1 sm=1 tr=0 ts=6ad0b26b cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=poP29n66LpQIKrTssMQA:9 a=QEXdDO2ut3YA:10
 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-GUID: F2gPjG9Mjwq9L4Nron5NBP87tNnswwnt
X-Proofpoint-ORIG-GUID: F2gPjG9Mjwq9L4Nron5NBP87tNnswwnt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150043
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

The SPI-NOR flash on the LeMans EVK is connected to SPI21 (QUPv3
wrapper 3, SE0) and routed to the SAIL hardware. The flash is used
only by U-Boot during EDL or recovery flows and therefore is not
described in the Linux device tree.

Describe the SPI-NOR flash in lemans-evk-u-boot.dtsi. Keep SPI21
disabled by default so that it does not affect the normal boot flow;
the recovery flow enables the controller when required.

Signed-off-by: Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>
---
 arch/arm/dts/lemans-evk-u-boot.dtsi | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/dts/lemans-evk-u-boot.dtsi b/arch/arm/dts/lemans-evk-u-boot.dtsi
index cdd3d32f61a..21733d8055e 100644
--- a/arch/arm/dts/lemans-evk-u-boot.dtsi
+++ b/arch/arm/dts/lemans-evk-u-boot.dtsi
@@ -17,3 +17,33 @@
 		      <0x0 0xd3500000 0x0 0x2cb00000>;
 	};
 };
+
+&tlmm {
+	qup_spi21_default: qup-spi21-state {
+		pins = "gpio13", "gpio14", "gpio15", "gpio16";
+		function = "sail_top";
+		drive-strength = <2>;
+		bias-disable;
+	};
+};
+
+&{/aliases} {
+	spi0 = &spi21;
+};
+
+&qupv3_id_3 {
+	bootph-all;
+};
+
+&spi21 {
+	assigned-clocks = <&gcc GCC_QUPV3_WRAP3_S0_CLK>;
+	assigned-clock-rates = <48000000>;
+
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <48000000>;
+		spi-tx-bus-width = <1>;
+		spi-rx-bus-width = <1>;
+	};
+};

---
base-commit: 9703d24aa2e5f2ca0793a47a25807eba53716792
change-id: 20260916-lemans-spi-nor-dts-4a1f7c02e938

Best regards,
--  
Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>

