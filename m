Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF36BC982E3
	for <u-boot@archiver.kernel.org>; Fri, 18 Sep 2026 20:07:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 688388135B;
	Fri, 18 Sep 2026 20:07:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ogT56uOIghjA; Fri, 18 Sep 2026 20:07:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 9986081354
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789762029;
	b=OT8M9linnFlSGbTUkZ5nJ+jV5/2HZeJZhgUA3Odj7qrstYOc4D7beC19IUcpNVvWdaie
	 tj5Q6wdZ6H/o7aXoc13gtlwMTB1PfhYtdriiSbd0SdCvapiGlFiFXYldKRppWbObhbeaT
	 Y/UZX+Vl9RBwtlx9G9Te3CyjgrcRhCFBT46AJyGV0pcVpMozLkBOFsyWViZo5n1eBv23S
	 /Nh9Yp1sIhUuCWw12pnyJkPLY2UOC7/FXTQfc4Tk09GXDelweZ4+BzzmTByQEEHmyv/DN
	 aF2I41gOQfrSS9DPShM3IM16WXiel1Aa/foHLjhD7YvGQcbfXBiPwY7HHZ+k28loEjg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789762029;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=da4OSJbJJy4q0SkrmoZYHMyBnjgsm8vo7ShiX9ekWG0=;
	b=dZ9XR4S/qJhyn0xxl2sC4P/ZQ6lUGLI8J+W+yN41lmrTe3+IUW/bXbo0KPo7+cduhsQa
	 4z8fYZW+dRu7hFFaHhEWXt9tZ+ffhkCSCFtkUgGIIUjW6td/MGC5HPGUprzMpbRSb7+cC
	 vExxnFwDAJK99J0fsAmTE1vKu3jzBEC1THFkv4kSJFnx2afto60LEMvPwbAP0+U0KfFqv
	 31oaBPnrhB3wejU24fTHBnmvXQrowvVSXXbmLfGqQgIQgylVeD/MQOcu3gFUy8cdMLwOJ
	 nbSpVzoAQnGnznqWxPZGQRrevGTlVYOJW6mOqxgIdq+SB/jzPYQLRJJ3bwb0hhFX8BA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789762029;
	bh=da4OSJbJJy4q0SkrmoZYHMyBnjgsm8vo7ShiX9ekWG0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OZ9jtRREpiyPZUUe8OlM0+jOFpf+HK9Se4L1jqyu+lZfw0aBw2wHNzjxi9TU+gP54
	 4uSjYKnFUP8jGLFbRSxpZxnIKgGlvUvjnagV2dIV7J2+5MzihYggUlWq9elG1BgI0E
	 Q8NNvrVPSRemIR8haLbocQkGCJvcVxRd/3lAdGPMg2ZYriOCgg8nRwh0OFSU+l/3cp
	 e/nUEg7ND5xZSb7yePV1k5XPqqSVAhhQcMWiCf5DJMKMzXDKA+ecH68CbIqjPWV51T
	 TsFnhNV3UoXHup95NB2RdJWZV8648PJTRs83Czp/9NXKNVN11RqytvX5qPEDDwkBsm
	 XY29/Bwyt4xDA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9986081354;
	Fri, 18 Sep 2026 20:07:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5FB2F224
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 20:07:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2F04560ED7
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 20:07:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9f1tQLWwFP-m for <u-boot@lists.u-boot-project.org>;
 Fri, 18 Sep 2026 20:07:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 6AFB660ED4
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789762020;
 b=OneATmhdlrlZ7oKEpa+oU/hkqGU5nnBJfDGggp+a/o4m0cHn3noTHz67WoMPgFt4GA6c
 1dqF7/QXpwkVgDXJ8VO1AegpRJtQ3L7xxjxVXUsl0ECaXGaPfpYr1rovqmLK0zdI/tu0n
 eDRm1dPGSmT+k7q62/N/K9pxMXcgInP0bglRoGy1TMUvc0o7nOUHqzB8gjBVixY8XAkvc
 VTIy9T9SvrMCgR5sHRUdQKMDrHQspmJMZa0sF8wM7p+EgQ4lwMjjEXgLKp+Okv0IRV25O
 K6n3vogJtf7ioB5UX62DA2bVHwVTFMZejhYZWgWlTcG99t5d/VvdUONUwfQtu4ChjwA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789762020;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
 X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=da4OSJbJJy4q0SkrmoZYHMyBnjgsm8vo7ShiX9ekWG0=;
 b=k+Gz9f74GbCdrxGqW+xK6RDUiIOA2Q34VBM3WDfE/1eY3TfmmkgnCPT5N7Cc+GyEil8+
 b+Pi7zJqcg57hWuhLdbtIwHjnCM3Di1wuYGv33I1SwP2b/RDtonwZZB5oT9mRZEGDUqC7
 QvgmVK4P36qpannA7fCwUNAmK6lSn7C0paBfx7v3Zjuz8FXJ6jE4UBX5OlZXeepY25Npf
 YGSoCydCTAQdTIDRb16mRpqhdyPXI7Pse5JjQvtvRxGBMKYcNvvd2pJstH+yQP3L5t+g9
 rnUYvZsICkz5fRFpOKIVN/ECxSIMJsAA3JNRdYMxsgiOu1pUJzXril0FkB8u3giq/3w==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=aubAIPAN; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=JQvRYh6e; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=jorge.ramirez@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=aubAIPAN; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=JQvRYh6e
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6AFB660ED4
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 20:06:59 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68II05UA831475
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 20:06:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=da4OSJbJJy4
 q0SkrmoZYHMyBnjgsm8vo7ShiX9ekWG0=; b=aubAIPANN96llxLwYAb/fzAydXX
 R0CbVjdPwDF1GQz9Ag5f9s5GeDxmtnNUA/Z9kpXnkMOaE6GaBmK+mmfBsivRrfbm
 rCXhjOPDjwJhRsq4t3Mep7DNe/GfsdIBTGP99ox3ejyGvh0IqcXA4VaVfHve0bjy
 2GqsD4J4ABBwMqvqlIOjXD6FZCbBKN9rRF3ryaP27OR9AhMkjIrsaUBBuuo+4lf5
 KUtEmG7V2S4dP1VWQBudMZyUVZySXb1aGsAT5224Xm9+tvu4vCmOJSCo2cvBjuao
 UUruD4yac6q9taDZuAUqruICVL76ThPmiueGgLiCLLWHJEf6d0UECUIRp0A==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gsa6mrfr2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 20:06:59 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-97e8be2221eso126632241.2
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 13:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789762018; x=1790366818;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=da4OSJbJJy4q0SkrmoZYHMyBnjgsm8vo7ShiX9ekWG0=;
 b=JQvRYh6e+qnRxh/y3xm1hr2ZnruFOdlWerIg82cjHoSlZBwBw3RnqBXcJCEErHmj0A
 V9o5bPZQbk0f+uqFMU2o7xE+WlxmCM8b0OHZb0H7XDo0P8GlEX31dyC3cYmdxSQcTLq2
 kSlxOHsR9xJ5r4kF4ZUPPXhZaLJ5NLfwDNN6MDD14FOmGAUxr6V8r3atyUbBuel0Zd2f
 1+9OUGgGK0ZYR+ZSyIttM75O8nM+EeThcwgtmHx64v0FHIYEbMaQv2aqF3LI8hy3T3qr
 A7vbF+Voj2DmEeSH1dFVLU/wkfDQ7YELGzugqwWGJ+AxHg5v26hn+tcJS6cc8jyZnASX
 KPZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789762018; x=1790366818;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=da4OSJbJJy4q0SkrmoZYHMyBnjgsm8vo7ShiX9ekWG0=;
 b=Nx73CEbooZtX44G/bNk57HSN/YB7z653i4vnEaPajF7lBk8p0uj1Qj2DK8rdmJpM+T
 fB0FMh6WZY/NzkF5OxCNzk/r/OJIDeC4e8KRVfseStlCJH8zOQr3eLcjhfMYOpY1To8y
 FxMdSXMZxI5SnVBJEONNOPTcWFvfoO6cABlH4leyIeCE1sma/V11IfHMyb4Wi9ZxmthU
 2BqgPzKLfn3WQeKyFNKA4IrTja5kHzjvjLc3NzYqxPVLBO682bBrvks5h9Lq6HMEp0oq
 WqaF92Vh1KTUNe17S2JIPqotLxhg5EJ4SDGOyAm0hu2Hq7oPFJazvjivkEmh5EQjfgHd
 CwuA==
X-Gm-Message-State: AFuF++ntH93TC3ZZtrlu8SPHRLw9TQmTeKoFuuAcfuLb1eWVf/1fwS1C
 sK1P5vSDbEEdkL9u9QCBJ2HRwBckJEidvxI9AV1BxYOretgzOv/Y1lVtKspz0fudTOBzaeo8yER
 nNSpz5tvKcNqN2S79c378LqUscP+gH/zqlEtXMuS9Ij5UWnJvO6dasfdikVdyab0NhHGywGQ=
X-Gm-Gg: AYBFou3KpiqoDaAlx+/UM0EDGqU0CtOMB9xk08iSylXxKWoRWYhRqwXMzq2TaGoMGpA
 zf3Gwm1ye/Oxm+3cIEvvlUMvIjsicBEkuStOnNrgQW4rXmg/8CGXo4ks+qqwttRwH87XX1D2SBg
 k9DNY1QGnQF4CWBnrua6gVzRY2q/YXRB50kaguJfQqqtR/mRn5gCq6O5kTevMk19n+aSUPmqG0s
 KLw40oLyRC2j7T4qG/he05DYTDpOTPl6Fe/TM0nDyEGHUeovOqSj1o9yJ92R+JZxut/m/LH6lY8
 eeokwrWYK5n8lKm8ZXbs5Uv1/i30MSAXKDS6GYziu/lTBjvkMkq1hcdWxvgFgARF2tdT8FyuPj5
 AhPbEdIkXqvScnYegzo0x3rm6D6J1LQ9cRbl9qYZKP3ix6vg=
X-Received: by 2002:a05:6122:1d9f:b0:5c8:2ad8:1484 with SMTP id
 71dfb90a1353d-5c9b58b9184mr2237842e0c.1.1789762018205; 
 Fri, 18 Sep 2026 13:06:58 -0700 (PDT)
X-Received: by 2002:a05:6122:1d9f:b0:5c8:2ad8:1484 with SMTP id
 71dfb90a1353d-5c9b58b9184mr2237815e0c.1.1789762017846; 
 Fri, 18 Sep 2026 13:06:57 -0700 (PDT)
Received: from trex (250.red-81-38-139.dynamicip.rima-tde.net. [81.38.139.250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48724596604sm1136798f8f.30.2026.09.18.13.06.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 13:06:57 -0700 (PDT)
From: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
To: jorge.ramirez@oss.qualcomm.com, dlechner@baylibre.com, trini@konsulko.com, 
 jens.wiklander@linaro.org, ilias.apalodimas@linaro.org,
 peng.fan@nxp.com, jh80.chung@samsung.com, tanmay.kathpalia@altera.com,
 neil.armstrong@linaro.org, bhupesh.linux@gmail.com, n-francis@ti.com,
 xypron.glpk@gmx.de, s-vadapalli@ti.com, michal.simek@amd.com,
 jbx6244@gmail.com, marek.vasut+renesas@mailbox.org,
 sumit.garg@oss.qualcomm.com, jens.wiklander@oss.qualcomm.com
Cc: u-boot@lists.u-boot-project.org
Subject: [PATCH v5 5/6] optee: rename rpmb.c to rpmb_emmc.c
Date: Fri, 18 Sep 2026 22:06:37 +0200
Message-ID: <20260918200641.2286077-6-jorge.ramirez@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260918200641.2286077-1-jorge.ramirez@oss.qualcomm.com>
References: <20260918200641.2286077-1-jorge.ramirez@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: OhDhFZIL2fne2Boif-SxckkAZdeziRKr
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDI5MCBTYWx0ZWRfX316NaX3sRhT2
 7NeqdBnhgs7GitiGYpkT9R2nAC89WldyKeCfATJdlQJ5yemYkhVvI2+zvldmGTAi5U3rP/G2wBb
 b1o0JEoF+BBkYrqu9p7l+/RnUwHF5ns=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDI5MCBTYWx0ZWRfX0vlXygt5OeQd
 BgYP5W5IIxKaivGDbJNV36WBK4dh5wllGITSNi0Yft9U7MLEiVG9NgS813kCKCCB5vskh8wnlHq
 uGvrgirnSx9puC9YMF6PH5W85K6y3pcvoVOZ2Qa98homcJ6ICilQYBCvMQVssBOUfUe2HnnJ5tb
 98dzIolxVSUsqqrrcIIUxRKo/FKlZUHfiYPp6DhOxQmfylwEQgP92UzUCdHqc2GXrDoSPVYqXc/
 B595Bt0mhryyAcGQLolJw0UOGKIwtviWr2gKSejoMUUED6Sd8QGPYMsu/CoPHcO2JANVb7j8nVX
 Sxsj17dUEp7wF1fuiclahbu0CMawUzewgPRE+7kJkW7SYTWeTW0BBmkr0jVRWt+xqBOjCVHaeCq
 6twbbWj5G28I37+mkwQW3eLjh+6Vn8yG3FBQPoIbWMeK2W8ti5qf0LDax35u3nGDQoDCjoajuHg
 1ZZe8dREo4dXrAv7nHw==
X-Proofpoint-GUID: OhDhFZIL2fne2Boif-SxckkAZdeziRKr
X-Authority-Analysis: v=2.4 cv=YYAodARf c=1 sm=1 tr=0 ts=6aad99e3 cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=N2KLPU99T7rsMuN2xAoQUA==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=E6ZNdhIRmaKDHt24uZgA:9 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_05,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 phishscore=0
 clxscore=1015 adultscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609180290
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

rpmb.c implements the legacy single-command RPMB supplicant, which is
eMMC-only. Rename it to rpmb_emmc.c to make room for a UFS backend.

No functional change.

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
---
 drivers/tee/optee/Makefile                | 2 +-
 drivers/tee/optee/{rpmb.c => rpmb_emmc.c} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename drivers/tee/optee/{rpmb.c => rpmb_emmc.c} (100%)

diff --git a/drivers/tee/optee/Makefile b/drivers/tee/optee/Makefile
index 36ac085ef42..d0c7f8dfb12 100644
--- a/drivers/tee/optee/Makefile
+++ b/drivers/tee/optee/Makefile
@@ -3,4 +3,4 @@
 obj-$(CONFIG_OPTEE) += core.o
 obj-y += supplicant.o
 obj-$(CONFIG_DM_I2C) += i2c.o
-obj-$(CONFIG_SUPPORT_EMMC_RPMB) += rpmb.o
+obj-$(CONFIG_SUPPORT_EMMC_RPMB) += rpmb_emmc.o
diff --git a/drivers/tee/optee/rpmb.c b/drivers/tee/optee/rpmb_emmc.c
similarity index 100%
rename from drivers/tee/optee/rpmb.c
rename to drivers/tee/optee/rpmb_emmc.c
-- 
2.54.0

