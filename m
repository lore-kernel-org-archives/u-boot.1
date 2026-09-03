Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EF4FC61DD3
	for <u-boot@archiver.kernel.org>; Thu,  3 Sep 2026 05:20:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5F1B68107F;
	Thu,  3 Sep 2026 05:20:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5_AkG3b3PzSR; Thu,  3 Sep 2026 05:20:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 57F2281028
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788412856;
	b=j75p4cnknFFwBlDSqHsnmEpZLtJzW11xWdQ0Fqd9uq/+RyA8NXiLX18gYJvMMGwn+zVm
	 WNh7yGgAxuVo0iOYq+5mZJpKemyZ0QTP3zQVOvjqyODJLftnKpHl3PnmFUn9X5QiBFmaZ
	 NWgr3LdUBEdtw69jceEf+cLNpeWVOlUTAeBT5vuOFQh46UJR5whAHnBI/Sr9UZyFdQZIr
	 yMoPXTRwbO0gqtyIzbXntorUOPNIkrm4y2aV0N08EXp3N1FmNZIPuZNBOEszRr0wED6g4
	 hY8wW9uz2V9/LeyL0s8H6YU8TAuUZ1kiMMqfssiGznw9wjr/b+QWY4ggex2+IKHUrZw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788412856;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Ff5SZdHoKRTPC6HI9oSW2+TdfJeDWRECIjtNN8q/Of4=;
	b=WSqAk58wYt388hJKqQrJu92xs4abS7iljHXRoiTF8s5TNy4mS2RX8tjFw9PH/dFnl7NM
	 v4r9BY2TJ+o9x5uoiUXaMJN6iSgI4J1TMVmKoZXsRNnUPWl5F9e0wKVb0dUGI6wUpyhow
	 +aAZDbtuAGJjgnVUhmkbkzlZESwZiL0llyFA8dEsENvynA+flDuPs0hB+mYAJL7rZ+1sP
	 hglrOVRApFPxPsEZL1P0IPRyU1k4r9M1HJ7CP5htRJiYDCWt3/80zi2p4OJ9Wy8hNqTSf
	 +vJoqHWEcX64Cyf1F0x7a49c8TYMHzZWZU/GEhFcBVCT1OpOHBURcvz0//97TlyUPMw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NOROEZFa;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=JEL1Ted9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788412856;
	bh=Ff5SZdHoKRTPC6HI9oSW2+TdfJeDWRECIjtNN8q/Of4=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=plY0y3NHIYz487c/eqBXUOVcDiPWb2mul7fUWe5qxKVxfYk5MBGbKKGd1ScucPtg4
	 mqX5JhYtj/E5SWbLYuTN0sUj45VDw5l/dib1PDSdoCbNdw4gASh6hS/n1tYJVcc+iG
	 pbbhBqd4VXsgS7imk9pEd2Ysg+5kZ5DlvLLgEtr4GrnSgebqFYzxbmeK3b/Yq1bZSn
	 NJKfCawFsvOTqPlHAs78acaQD3DkSlG3bUrqsfmbGN9RWq4CBnJnnCOYJ1Kl2sSoiF
	 6fY2hQR2D87rrjJ5tHj5GKPhWlK7T+XX9bwO/UwOoBgD4eKkWEFBVFVWdwr64gqcgE
	 z+MAg2GFDbw4w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 57F2281028;
	Thu,  3 Sep 2026 05:20:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 3C826D5C
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 05:20:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2192481028
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 05:20:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id i8k461sDNGuX for <u-boot@lists.u-boot-project.org>;
 Thu,  3 Sep 2026 05:20:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 99D5B81016
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788412853;
 b=GC8N8BHPILUAVi4pwRkngPUgVIzLrHXKVPayajleiqQLbe/rNWsP4iGmMDGh2tBIz9ih
 VwM+Nq71iOBNPKz6ijkKTnBKbDUrWLdCFAeCv2X5CaIYobTZKLzQM5jkJpSdc5wXYsWQo
 JY2O8vtndQNI5nNQsxYOn2i+RcZyTBpdl8tGv/lcyllGccjQ1sNsVLLtjyfufYgYqUZqD
 xziAv9lorVcvAcl1N7JZeASdnH7y1hedlXD6GZsuQAY74y1qVzaE4huotrlx9t3808NvM
 kP8jbqziB5bhLOQabcA2tSecfzCRVvKs7tizxaVgfQ599xApqN50hqd1zVI+/OyIfJg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788412853;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
 X-Authority-Analysis:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=Ff5SZdHoKRTPC6HI9oSW2+TdfJeDWRECIjtNN8q/Of4=;
 b=FmG7vFpVlGIJWW6O3FWyBdBIlIedJAt8nEGThhEqjGwb3e3f7lepZuJqk5EQBBfKIMaV
 au5FZ3yeWkxwb4QWLYeQBVnCndmvX6Mg/Oz8wjpFs+/iM/GR0uJrdF8CdLN2K3O0+zLpw
 8l30l2JKXNFr7c4xSMPlbDOo15bDPXrFSUfgkeXpqtg65eHtUQgTXnMv6nS+lQpN6sGhI
 tJMY4VKnx9bj7C9vNm20wYbL+sw6Zc0LTohj4zAspHne/+O3XMTwX+aMGTkRZZ12KDhjC
 LbL79yZNhDC75oCv++cTmemuo0gUFmZXxvLt/o9V9QarRrnLRA4k35Oc7f1t6a14DTQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=NOROEZFa; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=JEL1Ted9; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=NOROEZFa; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=JEL1Ted9
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 99D5B81016
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 05:20:52 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6834F3BA3599227
 for <u-boot@lists.u-boot-project.org>; Thu, 3 Sep 2026 05:20:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=Ff5SZdHoKRTPC6HI9oSW2+
 TdfJeDWRECIjtNN8q/Of4=; b=NOROEZFaR04eHL1M0GUm4YEbKf2kxydDhBCz+8
 fMHYJ92eqBkMLjabrzTPxPxWz0aGFs550T3d+nYINSbSmksptRkEuqLjukSxN0TG
 0xFPCPXh7Vk/57hxoCDumHG2hLnbq7KTH/ZiEmcjOg6vOD22iIVFe4PllqM1qg6/
 BbJMlIXK4e6ekbqTKG3jHvUzv0Fi+l78MXibosOfivxYwVSlHx8hlh5ZFSdsNj0S
 Y+cKTYIOWjox3N0Jwzi3izzcjrWBFiV4cET/uDTjl3AaRNdWL3dooO5LtDBoRUIF
 RY8hkREzCTPHEnvKQnYpuF8W+8GAqU6GiGUKwTTXt1TP6NRA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gf1pyg6c4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 03 Sep 2026 05:20:51 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2d6f80c76e6so32535265ad.3
 for <u-boot@lists.u-boot-project.org>; Wed, 02 Sep 2026 22:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788412851; x=1789017651;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Ff5SZdHoKRTPC6HI9oSW2+TdfJeDWRECIjtNN8q/Of4=;
 b=JEL1Ted9FQu3+YXX7uQy5d1HZ0Oqqlu0lYm6syAIjbBFx8qdC0TpoqZtWmgQJnQFln
 vqerJzrtO0v3PSQTHY4Zm0EFgMLC0pxwsPxohEifyFQ4PAVNIkVlVo21kVjlsuvV1Tib
 qUrwZqZ47nxgl19AXDFycP73teGFfxyf0msoc93LfD68BSArO/noTubOpszqU6ZCQ7I6
 tSuH0INTmOulW2pCUoDTPy8j8rnJBTPkv0i2lmAkZEGmBVBmiQCBr7Amav4vH0Yr2fNr
 m2zl5Yopwu3aU5ouOkCnFd1rGXfuTC1g1CL3AnovcWPgfoyVuVVG2Y3TLYABFpOp+Ysq
 Dcfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788412851; x=1789017651;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Ff5SZdHoKRTPC6HI9oSW2+TdfJeDWRECIjtNN8q/Of4=;
 b=eU3FRTdg+JnEzOjInX51II6MZPUsmWiBN40npqOf4PhuYYtrsAtIYmwIb6S60Zzi22
 DxfSYIqTmCuQ1/5jI5VZEQC5QaJe08X2HNB4m9UN/VC8LKAewdDlAzU6Z7irNRSkF4bD
 3uvRVzOTIbrBJ2fcYCk1K2qoD3xm/e53Oa1VcgSeP9xrQVXbH0ga789e/wvA0pYk+3VT
 +iCfKS1RSSgjKBUxVNhvQOVbe0Q0L6upX7gMQ234kEorjKl4STNBYgzgqQqli7gEIWVX
 jMEQaIKlOE10ZL/WaY4oj3MHmFC4DdTTEudnxCdWK9w/cbG6fXd8frfSTYLxdtgGtQdT
 QOeQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByplW3wQANzBCbFOK5So0ssjzkcBKmbpKVAhDzSlqZ2PhQXVYScVETmkswPO1PYwKHnxqIGekU=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++l1PMn0K5zFXuaJ8GfX4umuoHW7N8GpEK+d+aHI1qKcHgBZssYo
 uotyJfapsq4R9Wpz8y5nvY4BfjvhXZWnTaym0jJvGy83RbENDbK20U4RKNkjinSLQSbkSamtX1D
 mESFpo8hiiQCxEZEACsGmFEcoBhyBEsF2/M132j0Kw3PLjRmEom3YNPkC80mEYEwoAouHqyc=
X-Gm-Gg: AYBFou2qowbQOFZR0zFm07abjs0+4Ljqjh4GUs+4rOHJKGqXPQnSu1BSfz/P7tOO87Z
 RcZ6kK76z8Udiu6oMDAwwXtQdReqc3pxqfUNLwt+eT85H3m+1M66RojGc9IDHxg+ORb7rNhToqw
 BcS9i516t2VdG+kpIkKTPp46YOIKOd+BJBExUklMG8PvRXjl5eohT91dxxtyKNnuUHjuQWt98me
 XBBp9u1fuvZMXRqn3X/btvBG3pMpjlpTjcmNgNzP/atVeemj6OBQdjhOKW58ZByFMxHy9UjpYxi
 RDoFXMU/m0ZDNxF6y8uXe5PxiKC2IrFdFRK12/0QOp+M1euiyU/Eka6iOFzODlbULRhMuKeUE0/
 qZWZDY/6vvgE2PG0DC0kAcIIlLq2mK0TJiTUatI4fNT26osJECRzIJGZNGV/JH+VeL+L41pWQj+
 weJoVn4+V86MsJAqXzlafnBl1eLhcL
X-Received: by 2002:a17:90b:2d0b:b0:398:9be8:ea66 with SMTP id
 98e67ed59e1d1-39aee1b7937mr15233364a91.19.1788412851165; 
 Wed, 02 Sep 2026 22:20:51 -0700 (PDT)
X-Received: by 2002:a17:90b:2d0b:b0:398:9be8:ea66 with SMTP id
 98e67ed59e1d1-39aee1b7937mr15233316a91.19.1788412850737; 
 Wed, 02 Sep 2026 22:20:50 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3325621af3bsm2903644eec.21.2026.09.02.22.20.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 22:20:46 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Thu, 03 Sep 2026 10:50:41 +0530
Subject: [PATCH] mach-snapdragon: skip serial# env set if already present
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-snapdragon-serialno-write-once-v1-1-887c200f7b14@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAKgDmWoC/x2NQQqDMBAAvyJ7diFNQKtfKR7CZtWFspFNqQXx7
 40e5zAzBxQ24QJjc4DxV4pkrfBoG6A16sIoqTJ45zs3OI9F45YsLlnxUuNbM+4mH8asxNhTT4E
 oPLuQoEY241l+9+A1necfEUq+T3AAAAA=
X-Change-ID: 20260902-snapdragon-serialno-write-once-7c7c3cc3863d
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Michael Srba <Michael.Srba@seznam.cz>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788412843; l=1259;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=KP9EL+c1FjRph8Q1eJdwKh0nYyVgiETrUxzfCK/vCFg=;
 b=0tyq9qeBlq1KBGbJBdVGeY8eGUvVazIso88F2qJIg3KQPIxLC57Q2X7uyzlGslqz4SGQIxr4E
 fSAV5tPcc+tA7ubZXg/LSAflIAabjweTjUBLPeHUgDUlKWIfXxyXEdf
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDA0NSBTYWx0ZWRfXxNQlkf7UwDbB
 ZdtS5n+oc11bID7P5I6SHQCWwbQBo2IBpva8LGuj6Nag2hDE0ETcVlScj5BFGjonDfNPSwHeplL
 AxBLd/cLwlAdzO20XXhNsROwqG51VQEuBiPbXHDUFPu7OWZ+WLc5ms216kijzTXVnHlv9nosMCY
 CBgeDINXRzr74AyGziEfVTT9aXHzC4w/9GpI2A2LtynPGJ/hjd850/EayMdiV1Al3oCAXLeqWG0
 3FrjfLXuPgOFWYmk4P3JMDWcAitnVrP/P1fpwHDxdvivGToru6dTAKYIDj+itVjWNdvN4Q8E8WM
 NapZ3MFrcaQsBDlAY0P9/3tPlbXeORs2aU2vtyzBuhRwWrTLkYQaHeGUHv9eob9bW8rikTuFB4/
 4kA9vCDFcuiU66sOLBd3bVXIWXk/4rfPkg7kuyIMQjCU8tlXIMTJyQOfpBZRvkWrTKoXm499+2S
 h4PsOug44/wSy1f3DCg==
X-Proofpoint-ORIG-GUID: zfdb9-lNeFlG8TyQIDJk95ssMhL5ta7J
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDA0NSBTYWx0ZWRfXxL4jclO/mSGE
 RreHBTKHbpWp+uGKZ4KbgjwV2UmcVRpO818+sDEAXIOyb8OzvitxeJ/Lb3hOOpaow8naC3ze5ac
 n2coEJxv19ewdtki7siEQggj2zaRpqA=
X-Proofpoint-GUID: zfdb9-lNeFlG8TyQIDJk95ssMhL5ta7J
X-Authority-Analysis: v=2.4 cv=DMO/JSNb c=1 sm=1 tr=0 ts=6a9903b3 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=1VxDqnHFAAAA:8 a=EUspDBNiAAAA:8 a=8iM2h7900MNVWf4ZitEA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22 a=aZ5uHUMKh6B-zo3GvD48:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_01,2026-09-02_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 suspectscore=0 adultscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030045
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

serial# is flagged write-once (ENV_FLAGS_VARACCESS_PREVENT_OVERWR), so
setting it again after it has been loaded from a saved environment
gives following unnecessary error logs, which can be avoided.

  ## Error: Can't overwrite "serial#"
  ## Error inserting "serial#" variable, errno=1

Return early from qcom_set_serialno() if serial# is already set.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
This patch depends on https://git.u-boot-project.org/u-boot/u-boot/-/commit/7c957182640da775ae6dd7a9456b6a6a8532c4ed mmerged in u-boot/next.
---
 arch/arm/mach-snapdragon/board.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
index 80bf510d31f..e8653460707 100644
--- a/arch/arm/mach-snapdragon/board.c
+++ b/arch/arm/mach-snapdragon/board.c
@@ -208,6 +208,9 @@ void qcom_set_serialno(void)
 	const char *cmdline;
 	char serial[32];
 
+	if (env_get("serial#"))
+		return;
+
 	if (!qcom_socinfo_init())
 		return;
 

---
base-commit: b55d2b12d3a88d003a9911adc8d96e4921f67ad1
change-id: 20260902-snapdragon-serialno-write-once-7c7c3cc3863d

Best regards,
-- 
Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

