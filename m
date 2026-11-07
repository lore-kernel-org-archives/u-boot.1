Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9C2606A326
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 12:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=vfBKR9D1;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=DkILByga;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=aov+C+jh
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 67A79812A0;
	Sat,  7 Nov 2026 12:53:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jiKU6d0DjQ6E; Sat,  7 Nov 2026 12:52:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6FE9A81298
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794055979;
	b=QtHsnla+gLHwKbfrWA/D+/w5QVmb4X9IDe5Lv4mleqzpwfzfZWtPsIJF+UYyj5Ts1wYX
	 03MjF53TxEe5B1tPGr1t6tU6CoXQd/iA/LK8hN6j/KsleRH4vw/iXFUv3KjiMecEk8jW9
	 LC+fgYcCBLYA7nPbgPWWVFg8EWb2VtV7izyz2NcVqk1SRI1mx6InlKoMElHrAV1KAZdCm
	 4IxNc77KpiFIib14tS8FwnBkqo42E5H10v9VgZpyUDBzzEgTphvC4Vzoh95ljT5eqLHFW
	 yuT+mTpfBEERsiHZJwBbCMGrxxo91OsRlrtXeHw7b9oW7CUycaPproGV6rWmnbdjQpw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794055979;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=8qTSHr0m67QMPa/EqV0y2dO1jXwxh9GvKMgaQ60VwQc=;
	b=qPoIJAB//mVb6m9rPQHheHyeHoW6z2Gegh0kr95lthCg8AZcyvHrqsDDsNOwh2vA3i6E
	 IVQfw8S9zap4gpq46jZDIzbWTZw54fxhem6FB9GScydIaNcFJ0PI/G4ETw+1jlL+tR6om
	 /koZlVFIeSbeGAv0ps/nNT9BH6V0gmaeSGlIcq05mIgbR3RGwtOXrhz5gGJbt4pUWiVJ+
	 msu8MzOSm/Rnqn8B4n96uzm81S5n/q8PAifTulKXl4jdjgeCf4tFUgx4qQM+ijIlw9ngu
	 j44DaN5mSEtNgtv6IUU+oKFtFNWIlgZjoI+n5AWw8Yf47I5/9uBWBK0r70/e5he07DQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=DkILByga;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=aov+C+jh;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794055979;
	bh=8qTSHr0m67QMPa/EqV0y2dO1jXwxh9GvKMgaQ60VwQc=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=vfBKR9D19JW7v6U8DTahe4e77ZzBNZ4gIOjowQ711ZphQJtMWugnbuCSPqQAQyC1S
	 DOYu+ap/rzRJDuy72QiahQB81MAJHX19Tat2f7tI8Y9+XF3CkhwA8q5jB/Imr41evK
	 dxWYcVMOwJGHXQhgRydOahMqCcxHTaOLN+IBz4pSEeXpgMRVEyF1o1AzbzVLGxeax0
	 I1z+Jtk/Bwv4JWb9qv6Pt/eT6zOycHeA2K1NvYvDkMeg6Zpy84i8nIyVDla+OxHpqk
	 ZWXloEDQs+DXaO1CtFWDnMFXbfp6zIRwGes5nHUwPrIZy3j5HYNljVhR0bcxoF/UEP
	 ePXh+kngNww4w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6FE9A81298;
	Sat,  7 Nov 2026 12:52:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8295634D
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 12:52:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8642681238
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 12:52:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SjpZZ4--5VFD for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 12:52:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1CA44811DA
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=DkILByga; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=aov+C+jh
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1CA44811DA
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 12:52:55 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A7C0SjF3752874
 for <u-boot@lists.u-boot-project.org>; Sat, 7 Nov 2026 12:52:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=8qTSHr0m67QMPa/EqV0y2d
 O1jXwxh9GvKMgaQ60VwQc=; b=DkILByga5UQIJ8edxYqFIWyt1k/oZVkSy4S5tm
 T82OGFWMyNEJZN9itu9k4dyu0r247d7sHbRfx2PCiFzj/+Efam3umyfIiNsO4vkX
 iIvqDgNYvAnHb11am0pHsZPh6NnrJ3IPnkHF8wuMB0T1yBNUj4qzqT2RhK3nfh33
 Qt4YYm4ltpSwJLGfsMl8yuO73DL28HnzPs4pSnjZDb6akPLlen4SSL1349XxiAoE
 z3eihag7BkUbEG+RhizC2D3YdMqb2LgP/i4fURe1eR8jLuYHwU88Lw6X7v7n9fzl
 MRiC024aGmlrEviOC1hTiisX4u81VcH3ZNAh7WnZAy6AQ39A==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hstxs929k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Sat, 07 Nov 2026 12:52:55 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93f6f4fe531so293527785a.0
 for <u-boot@lists.u-boot-project.org>; Sat, 07 Nov 2026 04:52:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794055974; x=1794660774;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=8qTSHr0m67QMPa/EqV0y2dO1jXwxh9GvKMgaQ60VwQc=;
 b=aov+C+jhLjdAlmBA1iCcgmh6NW5hCFn67BY8nTWIC69Ta8OZxw3Psx/aFgsJpzbVU2
 oe7mUhQcyHwFpWqGr2mTditEYsD86rCUhK9b2K02/F4KqyWm06CIGTX9HCuUgzlr/hDP
 omKFeLibFtzqA4nWAl0s9mexgWD0LRVLIZMxu9QE8VApKnodPoProyGOP5MrSGfTBLd7
 GUqj2hDaBtLt5DQgIAFMxR5JKWnop2HhlJ7C7J3H2WDdAzkm9mZvKPOhGZnhih4qt5fy
 SknhT0l3UpskXIldr3OLMMfCADfkn93AlL+s8yjC0eSTQLzq2enGM5+WHgMLv/i6DdLE
 Y9Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794055974; x=1794660774;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=8qTSHr0m67QMPa/EqV0y2dO1jXwxh9GvKMgaQ60VwQc=;
 b=RzUFYdHkPS1BRhFIF3QegnjhjPFlRKgLRuaboxDpofmwr5DHOPmFnS5b/Q/MrcVbUk
 DrUj8pt7jOS4LrnQMaVwWAm5pee6s95CK3uLnXlJYLEfckJGr2O7QHyHF2Q0eTFttSDx
 j5buYeHyqHEm1rFhMXg16WQqrqcwcCISao2/XcUYEc1aveKEcs4Ue90TQq3PkYhujI12
 oNUnsYt4v/XltBfLZ2Bu9/pf+a+Ba7W+AANIuwWAp8eIwadsvfeRZ+R1d0FFbuh0R6cJ
 eBPM0dzkvfhsH4x2W+hqw+VsSKu7hIZSsq9Bpk4OJwgWH5xjX3s+chOsGXDO0xVDJAI6
 PgnA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzRvOLxn+ueDXLB9i/4zWHD+awW6rJJHQURMxE2DwPTObxCsSYUOtLRRYnfkpUx9Qn/XFF8W+I=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+EAbhUBR0MVKtuk+KY7kexF5X7vnd1lTP3m3S2ZvCSW9f1Ronx
 3dwRMWked3+jDEx2IvhHavl2X5S50uNip1stnenySI28AHdO8DMRD0HxmN3W6D0K8e6G2iPnWK0
 tCldx4B6/X41XmEqm64E8y2oxEuvruYaPwYlcCU/mvn15/PS8tXvSw/FWcEZMNFCIH4x7TJ6mkg
 Tyhow=
X-Gm-Gg: AYBFou1rTzDm3gltnlA0wfzY1ZalZ9AMen6LH4PwwIxNR+j+uO8b4ewXyKfg3Yzb1v/
 OLZc/7KswB87jFLmT9CPElTzGA4ZHi9qc0yunvMw2/EowG5BYxtN2kcCqkGZiLtcQoetc2IS0Uq
 Exii7+NaliXW/9IJslqKg3ksMdvHMGX7WJGpqASej88VgszGsu/QdwpJFCEtNz0FEXuDKe4Q+Ht
 7jl4Zm4w9xVSo443M6wx55xrgg7o9DucS+6/zSlnBWjY4VsrPu/bqBRQa0n6zahf9jPbN3zWGSt
 yOKxTPJqv9lgI+kjwLz+ejWHxeDf/HrhzFQqURe+0t+qRYVQ39Djy7kls3ircJRexMnw9NbbDGq
 pr6mf6JsH9IjlvVwwSxFnPVwZ6rPqRo54tkOuhVnJoU/EjxXnD6ir6OCwBGFCWnKCTZgfVcBii8
 aH/tDhcIDSdYp+
X-Received: by 2002:a05:620a:a410:10b0:947:7f9b:f841 with SMTP id
 af79cd13be357-9477f9bfa3fmr13181585a.31.1794055973961; 
 Sat, 07 Nov 2026 04:52:53 -0800 (PST)
X-Received: by 2002:a05:620a:a410:10b0:947:7f9b:f841 with SMTP id
 af79cd13be357-9477f9bfa3fmr13180185a.31.1794055973533; 
 Sat, 07 Nov 2026 04:52:53 -0800 (PST)
Received: from [127.0.1.1] (93-159-22-70.cgnat.inetia.pl. [93.159.22.70])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4d356c3692sm148599966b.66.2026.11.07.04.52.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Nov 2026 04:52:52 -0800 (PST)
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Subject: [PATCH 0/5] test: cover the AVB lock state and preloaded verification
Date: Sat, 07 Nov 2026 13:52:48 +0100
Message-Id: <20261107-upstream-avb_tests_b4-v1-0-9177277458f9@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MTQqAIBBA4avErBM0wqCrRMRYY82iHxyTQLp70
 vJbvJdBKDAJ9FWGQImFz6PA1BXMGx4rKV6KodGNNUZ36r4kBsJdYXJTJIkyuVahJm9xRrRugdJ
 egTw//3cY3/cD3ugbqGcAAAA=
X-Change-ID: 20261107-upstream-avb_tests_b4-a0ef6acaa6bd
To: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Jens Wiklander <jenswi@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: r2jg6ZiItopIQFDxq1uWescbr-O0xgR9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA3MDA1MSBTYWx0ZWRfX2ziw0VEPQ6CW
 uJjIODVwd5JnOw7f1VZNMYdygaCFr5EIda50RQaneMlojd6jBT1/g4xsaBvHkOSWyhInctKVJ6F
 jhKcmrna1K/P80uR8tRPvSiZvRMfop0=
X-Authority-Analysis: v=2.4 cv=dZMVTnXe c=1 sm=1 tr=0 ts=6aef1f27 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=ySe+0nHqNG5yihRO1pIWsw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=cvxoKbtclGhIrPdh2noA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA3MDA1MSBTYWx0ZWRfX23MxGa+7PSph
 E67VEpc1rCnvX16GJnNiNS2DfuTfjXDxLQQA+T/AdDujuE9i6AhKgT0iqk20t60lzwWrSoHfG9P
 tC1e6QahlGMHa7W1BGLbKZ5fXDIwn0Mz8xekczbwFsEAaUiMVwvTPBTH4LTKM2nEAVIVpQK3QUt
 RdLvUSD5ZZ0ChpxlrCCrZ2VsSnmF0MziVHLOgTIHpxlzh/XsAHkNtUu1oEUzJrL0itWU5wUFc3n
 dAmFey5XIsGO4NSq3IzWPVkRiseJ3gRrK1dB9mOdzH2L/Gg6q8TdKSWY7PBqTj/KIKbBsN8/fG5
 g4JLLcnFcmZDLoWo6v/lLJfhRtVE6/E/52cvgHJRlFRt77p6AILDxoaNs5mGa5pDoY0Izysz6bx
 vWgpAtHtsWKI4dXU6hDwNVwe2k87OOawHCCLyluol7pHMPetWb0A6xSxS5knTdlVy5axWhXYmoG
 oCeMBQ/X1JvhPRBBU7w==
X-Proofpoint-GUID: r2jg6ZiItopIQFDxq1uWescbr-O0xgR9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-07_04,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 spamscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611070051
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

The AVB lock/unlock series [1] came without tests. Add them for the hex
persistent value commands, avb lock/unlock, the verification of
preloaded partitions used by the Android bootmeth, and fastboot's
flashing lock/unlock/get_unlock_ability.

Patch 1 fixes the sandbox TEE, which cut persistent values short at
the first zero byte, so that binary values can be tested. The last patch
enables FASTBOOT_CMD_FLASHING on sandbox, which the fastboot test needs.

The lock/unlock test checks that the stored rollback indexes are cleared
on a lock state change, as AVB requires. The sandbox TA emulation does
that, but OP-TEE's AVB TA currently keeps them; that needs fixing in
OP-TEE.

[1] https://lore.kernel.org/r/20261023-upstream-avb_lock_unlock_b4-v5-0-6453a6f63028@oss.qualcomm.com

Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
---
Igor Opaniuk (5):
      tee: sandbox: keep zero bytes in persistent values
      test: avb: test the hex persistent value commands
      test: avb: test the lock and unlock commands
      test: avb: test verification of preloaded partitions
      test: dm: fastboot: test the flashing commands

 MAINTAINERS                            |   1 +
 configs/sandbox_defconfig              |   1 +
 drivers/tee/sandbox.c                  |  17 +++-
 test/boot/Makefile                     |   1 +
 test/boot/avb.c                        | 106 ++++++++++++++++++++++++
 test/dm/fastboot.c                     | 144 +++++++++++++++++++++++++++++++++
 test/py/tests/test_android/test_avb.py |  78 ++++++++++++++++++
 7 files changed, 345 insertions(+), 3 deletions(-)
---
base-commit: cdafa8448ed4487f663ad9e026116a9baf8ca688
change-id: 20261107-upstream-avb_tests_b4-a0ef6acaa6bd

Best regards,
-- 
Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>

