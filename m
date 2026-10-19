Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 291BCCCF2D6
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 10:50:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D887A406B0;
	Mon, 19 Oct 2026 10:50:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jy891TN4ArXF; Mon, 19 Oct 2026 10:50:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1C2D4405BB
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792407039;
	b=VVhzvqWuj0K4BvBuGiyQsk5YvXkr78VfvcQqzX3OBX6QvY8mLmxAHfLcVP5TU1FnPgOg
	 IhQNY3t7VwykblWbC0r1baXdkKEApSiI1z/QCDFpOYJkq8f+hiEJeFfl26kdhQawaTooC
	 KVqG/gcBUSXb5xhQM1p9lBfxHl6hSJzJanN8eV3jyh4wgrs2XaAiqmOm7QmAvpVVmS2ia
	 H7woM+pyS8WV1aKoATT2zAsN2DWhPcVDAmm3/36L7PYHK/5jFXc6udIgQAS5ukwhGoS0b
	 lI/Zv6yIp23afuk1ywnKOFVnpDsqYsE7FrfLB1PtMMazE259EjYBoC2Lw3HaD2z1tGA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792407039;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=6grycjgTydQDtEQD0kB1Y8CCpwqRGjNdAjhp8Cev6Y8=;
	b=edec8/G8sHeYutxTgtYvklQT7Odb3ipxYoD1Q3FAd9PhtWwMSG+sliPuClUaOvhbqCuV
	 nsQwr0VCa11X055/kmffO+wzL8S3yfvhNeLHf/I0cP17KBp1SW+OU0U0T9gSCLM6pT8Ci
	 +oU/Wlpzqq80qjBeq5LFxwNtxT6EzsIPeFea3j4PdPf/EU4y8aWE2icQt6N8ImuoFMgNp
	 Sikofbl7o1V0DDCxVeR6u9OHBw0IZDUrs7TO8RpNqugIfATAyM2DNagt85oQWQWHacsGW
	 FdbRf44YI/KTokoq8w727oYbfPVcLCN2NkjiqwBAiWbQ9WBrvx4UwotupTpXr9aKnww==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792407039;
	bh=6grycjgTydQDtEQD0kB1Y8CCpwqRGjNdAjhp8Cev6Y8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Lb15jmhF7FJzz4xAFh3K/QY7SnxKFZSw+nUjZMqmcgEjTveQrso/YrtBfEFe817jv
	 2um5fiZMRcHx37O0d+1Nc6g42ruYhU56sPmQGhAtjb58ZQpO5o2mkoeBeEzvQwYBiH
	 ck/0DmvUdkv5YG5wXpgMh6cltQECW3R8WFQiAdGMXmfV43L0w2dht0Ug0stqekJO7f
	 Onr0eLrHRHfzauJ/RsCNYgpnh1Wj2kH87qFNLIyNaTFB7D6v7yITdiJlxRKE2nDCIc
	 QYpMXYDQ3WTRkfL3/419yD6iZFvgSARaqTiR/P+sQHpbQoisoaoQRXyyo2rXB5sHGF
	 SkJ1VhAMkiKxA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1C2D4405BB;
	Mon, 19 Oct 2026 10:50:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 53F08263
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:50:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 45BA380F28
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:50:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zKP4maaeeCdF for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 10:50:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A7AB080D2D
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792407036;
 b=reU98LyON/Teqd5InRzvhPFr6n155KJ64/o5MnSF8AdhcnYBr8qVLHfPwCdsev0JW/PJ
 UTMv2rCFK7Z1VRNKEQZdSc+CCjRXQgj1lgTyO7//D+NU8l3SplEOtG/G+4+TpylYvRT9P
 E9HVc6jAjWYbh5g4Qxdng2jgHciqkPf5P/XgVDU0bCIvrnoNPVUSowbsaYUQc9xmjEl2X
 3mQqwqA+Shzt3fDVCqB4TnOg2LLZJWDly5Zl2nZz6Si96GoMuGQHfSGgVp0UR2SvrvKdH
 zY8E+ZJfn2tVUK8LjC0BqR9iHf7BYdobA6w5nIi3uKiYtkZMf4D7C77h6+XbNKr1/gQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792407036;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=6grycjgTydQDtEQD0kB1Y8CCpwqRGjNdAjhp8Cev6Y8=;
 b=XTcEK2KcN3gnTiEB+yH3G/FHoj0B7QlB4OkVo/2aK89E2nE8wOxd0cCK58p2RrFvCzDC
 A2ZZGdGLLhSUEz/ffe70QABfeweZEnwDyLC7CcOCe8wEgNaC9SvaiTQrrNW+OhBdaNFOi
 /Ei1cS4ibc6pwf8gpXRjD3BNRgNM5Z+SNZm9FNgGMQfgiTR6OMmHpJFRcqV+nRGPvX33B
 wmswml7qVhykLenEkXY1EUqsYhhnnOluQoA4aAAfePHkHEqain4s7SVODFoVG47lS2G5z
 RORYVZLCmVbVrNJrN9yrIG+8vrCZWKodp894ehrDtmH389QpMlJraMc4En3gslyiIHg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=l4JEIlPi; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=I0ZOLUK4; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=l4JEIlPi; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=I0ZOLUK4
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A7AB080D2D
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:50:35 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J8OlLe2234089
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:50:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6grycjgTydQDtEQD0kB1Y8CCpwqRGjNdAjhp8Cev6Y8=; b=l4JEIlPiKUB5Dmkm
 C2M7xXsXvDrDNafbc6KxfXwMvzhUxC/CYfnW8AXA1ITo/OxKeVapPaX3PymRQIR4
 6HlQF7fGiaxS9vUKmWGdfqSml08xSakENVNOKbvZay0OyKzmygAi8H5k8jNtvn6k
 QuIGqHb5zOzvivB6awTdzQRZ+775iQYkQ2fJPLzvIJPo1+RRE63TnDEnksy3h3WA
 JnfVq9TewKkKrqygltRQZ+dYEi0gSyqBoPLMkfrh4BDU+Kts82ptZskNyW04Ww9a
 Nz1qpSnGn48z2xCASsA8zfI9nN09bZV2RO96NRHxhCK9eiHi6bRqcalKCR3x/GP4
 mjpf3Q==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf3x8q5b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:50:35 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-35a4d2e39acso5029377eec.1
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 03:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792407034; x=1793011834;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6grycjgTydQDtEQD0kB1Y8CCpwqRGjNdAjhp8Cev6Y8=;
 b=I0ZOLUK499N9FACcMtF8j8bqQZ8nZL98cVqtpaG7p4ob3lce3Z3zeN8JaLDoOwp6XY
 uUDaiBAgDxU1GmtD+ZKWaF1ktLfNWHjLgixWstIWd28uYZ0RmMtGaGywZ6j6g/hjGM1K
 8YEpLsCoQ4i1XmACEa0KLt+XatOXbQVcx6W2awqArvVfN4GfAJmly7HqN0an4qt6iPF6
 ehTcqhCXP9Pku3QNpAcxkgRBMhwsiiaaUVI4mEn9KJrFo4VcPLPwhoHQpJx0B8ReWXPX
 T0xn+1wVUHxMSQE/lDstWM16cImf1KWplb7ZjwNQpxkuBpSoc05bMTp1d5klEUy4o0xp
 5BPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792407034; x=1793011834;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6grycjgTydQDtEQD0kB1Y8CCpwqRGjNdAjhp8Cev6Y8=;
 b=Cauh0h8mZZy+u0Vu961EwxTCKLlxu21ea6pSO8C10SHQMRwqrYAbjUHINZwOvP+jYk
 +u079rW7guMoyzROazmWzE7Ul4sSitt0b/8E1/A6QqPIZfFt/E/9mG+p6cohtzsuM9Yt
 S5cPjjUSXLtD/CxfVZN3Zt3JqrS8oLivbTMm7DP8CH2PxwN8akoVK+vzq2QjYXDRluKa
 dLDs8bkE5AwbdBIb6N9I+smP3lvFxYJ3RKrr2Ool7N2oWxHHV+eEXoE4NLsX8//Gp2MB
 RZNWDq/P3nrKRoXKgbfrbjuPyacXP9UmXy2y3e030/D9tMkGvnO0ydwBpj22/bX/QXPq
 WHew==
X-Gm-Message-State: AFq9FYIT8Afj2FKuEiRf5rBjC3yA2omRbAjTl7+XRe+MFB6WQmqaj3vR
 t+8DuJM9OAFya3Wmx0xgS00zzADiOi5gEwNaAM7AJzRzrao9YEidvPI9Sl2WBwdNtAfSZfmXEME
 cos2Tdvwn52elCdvqjuc2dL/CC291FmdBBae+1572urGlMo/8UUfWfqPa2+7lVfHug3tY/LI=
X-Gm-Gg: AYBFou2F5vcGJXX7MraFNm2hbEaZc7E28UNLb28/zGgw/HQwGDw39VZ1SM9wA49hEic
 Te81+BjDrLPkppAGNf3I7rol2TMS65W3kzK5Sawx0QTsDg/QRNkT6jq71rX8akdu64M688sFjVJ
 zvwUIA2zaA6kUaJ7ARA8JSINPMTrKEKPNcKnUoZ7EgQSatBnCqaycM7pn/kYpB+dA1Lzavhzgk+
 9y4SIdsz0XElPKGc6k3/oscQMv7zydLJGM85E+MyBBICypNMNfUvq6KA4Vn0pCXkK0PhliOPbfq
 x63Kdkxs9K+1qY2XrZgNxOM+0dtEWu+RPhP9/F/C12Rpj8noFuSwrhDX32vrVTNbOSKrndjPZVH
 7he8+MeyzGxPi+x8/3tawXq1vQS48yhe7HbQzzQ2LMm0XSk4CjdjWVjHiGET/i9Ev7aAevIVOfC
 vfdcmX7M0jrwUj7+wtrPJq439Ry/8z
X-Received: by 2002:a05:701b:2608:b0:185:9384:31b5 with SMTP id
 a92af1059eb24-18593843236mr9109197c88.45.1792407034443; 
 Mon, 19 Oct 2026 03:50:34 -0700 (PDT)
X-Received: by 2002:a05:701b:2608:b0:185:9384:31b5 with SMTP id
 a92af1059eb24-18593843236mr9109140c88.45.1792407033634; 
 Mon, 19 Oct 2026 03:50:33 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-183190aa3ebsm25187828c88.8.2026.10.19.03.50.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 03:50:32 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 16:18:57 +0530
Subject: [PATCH v4 2/9] lib: update charset.o build rule to use SPL_UFS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-spl_ufs-v4-2-61432d0b258c@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792407009; l=924;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=wo2L312OYWaZ3UMlKCQ8+s7Kl0PikJO+E/8nBxc/X7o=;
 b=NxB8C+IHqIN8K4aPvK0vVKnciQhLxhWTKJAMr0SFFYhTsQrsDL3b/2S2QJftEalHUjEtjAEt4
 ETRisKGiEZxALSXkCAPMcvWEUH3iJzzQfVxEqADXtZPDzuqMHWp/iQa
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-ORIG-GUID: bjhEK1CLaAuGkVeaKEwXI4W44Jxab0nq
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA0MyBTYWx0ZWRfX34yT7pbBnUEB
 amzU8wJDCmacycEJ/H7EwxFGnyuryCweyH+i4SFOFfHcwYz7Cw1XnRGakjAayxErVw5ORx6q1Mx
 EyJMJTy9PM3PZq9lDxwdu0Dj10B4tqU=
X-Authority-Analysis: v=2.4 cv=XPOl2ghE c=1 sm=1 tr=0 ts=6ad5f5fb cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=k-42gJp3AAAA:8 a=EUspDBNiAAAA:8 a=jAPzq1VG95-kpb0582AA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22 a=uCSXFHLys93vLW5PjgO_:22
X-Proofpoint-GUID: bjhEK1CLaAuGkVeaKEwXI4W44Jxab0nq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA0MyBTYWx0ZWRfX/qrQ6/zf1w/w
 FKXZLWkSyZGHUzuqwojdvxtit7+3gf36E3drNzptNQYOePs/lWsXILFKw6UmWmexQDkrQE7mLrd
 zS6TlRdH8nfuTFM4qJKwqlxRyvyc+N3ttAn8PA4LK3B9lYgQ/Usp3XWYcxyQv6tgyVUPEOEJQ5L
 EuAuhlcbkqz9tmRUnKP9LnsiI3+hFbRoj3VQFAu8egdDJSnOUQewoMHYfe2l/jqznsLfEsTti/n
 konBzdz/eXjPQyB4QVrufFAEaQl2XHvopKuRz94WtcFELFXIFGMoV/EA1rsmF+JeBOtSqecVJgp
 tJuYtmX7rhd2gGUbh7tcsbdfXtYTOH3Zp3OsBuyg84u8Lm5r4+Uuh/Ai09Wp9YnB2qBQPpETmIT
 qWvhWTkZG4SQ8goTOo+cBFXwzIdzd7mkTrS9hjfjG+Cr7M6jMfq0EP8Ois4v7rRY318i3EaIcU4
 3LiwjPEBQk8MaITOwGQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 phishscore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
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

Update lib/Makefile to reference CONFIG_$(PHASE_)UFS instead of
CONFIG_$(PHASE_)UFS_SUPPORT for the charset.o build rule, following
the rename of SPL_UFS_SUPPORT to SPL_UFS.

Reviewed-by: Tom Rini <trini@konsulko.com>
Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v4:
- No code changes, order of this commit is changed

Changes in v3:
- No changes in v3
---
 lib/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/Makefile b/lib/Makefile
index 30092dd4a04..0901804323a 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -150,7 +150,7 @@ else
 obj-$(CONFIG_$(PHASE_)SPRINTF) += vsprintf.o
 endif
 obj-$(CONFIG_$(PHASE_)STRTO) += strto.o
-obj-$(CONFIG_$(PHASE_)UFS_SUPPORT) += charset.o
+obj-$(CONFIG_$(PHASE_)UFS) += charset.o
 else
 # Main U-Boot always uses the full printf support
 obj-y += vsprintf.o strto.o

-- 
2.34.1

