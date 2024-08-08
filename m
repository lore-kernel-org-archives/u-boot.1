Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DB07C52D7B
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 00:01:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B0AE88BD6;
	Fri,  9 Aug 2024 01:59:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qt3PMB4j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 005DF88BD6; Fri,  9 Aug 2024 01:59:51 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F92287A09
 for <u-boot@lists.denx.de>; Fri,  9 Aug 2024 01:59:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a7a843bef98so170006066b.2
 for <u-boot@lists.denx.de>; Thu, 08 Aug 2024 16:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723161589; x=1723766389; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=WgBJo06YVMb8dLpylgA2lYh9LVLr1cX87NfXKpGySbs=;
 b=qt3PMB4jJA+ECWTmiK/P0x6gTnzi++kmTN2Vipo3DnPdoNouti1qk66ykMjylh9ozf
 05+LiqFdbT53hJ4dEQvdW06fkVG1li/KxmyBo06YXw10X86CuwoWBc1h1xZRvunzAr85
 jtQW/DTMEblEMKQ+ac+N1jGIjlhRehQuQCq440/HtOm3TAPMMcKq9nzRvjrg397ZYhQ0
 keURgvaCOH4X0W/gT/qoZAUxpgDQabiGP7d2DIRhrtlq/q6JISW/2KBOpnCwIKlShjKU
 f1apw0Ayw3DGI3jG6MAH8oYCLQJOdzENsZWX0PNgOraudee2nv+q8bNp9pBUPfO2nWFc
 RBZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723161589; x=1723766389;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WgBJo06YVMb8dLpylgA2lYh9LVLr1cX87NfXKpGySbs=;
 b=nZKTuapGZ3e8rLMiWeIabzyU+u6WM24OY1o+cydpCaIAMgp1PZni0eIbe/gXJqMkH5
 nweUk8QlNxn1k1iB0b7mzX+ol0crCx5g3i/j4/Wcpm8rM2LCn/hLCVApBdYLQ4cfOTyq
 PESojF7ZLfe/EOFZNkPGO8wShZQsbYKpCBub2xRYhDRoT6+PTiEc0zNSNoH+NRgAAZ7Y
 IgVYgJePAKCLdIfBfOIIW5z3W2oicRlKKpJNUG6lwJctiaWiSDr9J07nin1Gfuv/Djud
 ZVcpS+vLACcVndbnaolt+4bIrpOHjAHCG5Qn3OOA9zoDvHKHWVDsq1SlLSmi1j8ft8dy
 LD2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWlW7Y3AsM0H+OcT+iVdgByKoJ3DYaFk0yQhnF4jAL/w+AGf7VKokIj+QA4mR8PLTLKURyjvwNzt2m6OjzqEwT5IhrBWQ==
X-Gm-Message-State: AOJu0Yw+bQKUQsWtSYm+toIUkFmAdC8OBF7XfbTDoXEaZJnMwUL8SOp8
 Ma/In6flvZIePrEcP9o+JHTXu/413kAmFiVqhk4MEUvuhKfGC130wSJYjlZ7F+E=
X-Google-Smtp-Source: AGHT+IEOykOLuneX0Um/eNnARr8wPRDe5O696dzatkQdmAD04tDzUBy+xO3JfFv6M1v4qikwTNsEqA==
X-Received: by 2002:a17:906:f58a:b0:a7a:be06:d8e3 with SMTP id
 a640c23a62f3a-a8090e3cd30mr248174066b.46.1723161589589; 
 Thu, 08 Aug 2024 16:59:49 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::7424])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9d45423sm784047866b.134.2024.08.08.16.59.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Aug 2024 16:59:48 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Fri, 09 Aug 2024 01:59:34 +0200
Subject: [PATCH 11/11] qcom_defconfig: bump CONFIG_NR_DRAM_BANKS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240809-b4-snapdragon-improvements-v1-11-7c353f3e8f74@linaro.org>
References: <20240809-b4-snapdragon-improvements-v1-0-7c353f3e8f74@linaro.org>
In-Reply-To: <20240809-b4-snapdragon-improvements-v1-0-7c353f3e8f74@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=916;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=WS7c264fDxhTs31dn5TjMfqe5va8jMKSCBOGcwH9WMQ=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmtVvo0patOiEj1asJ4mCauiOnlwl4pgh/FCUPs
 38+JzIMFi6JAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZrVb6AAKCRAFgzErGV9k
 tiVwEACiJwNkAwqmExVsDMlXJJJltzgZhRPzgY3lWSJNwBL3nrXlmiHF/W+JkU3wQIdRa4AlI4T
 qMbdIHvJ8SbTgBtYZipUu9/JwUpwYBjTMnoM9UXtlbwb6XeT1GJuVmqov/20oq68ZtZ/YUZ0dyO
 qPRYR4k8ZurYl8aC4JMtout3MsS1AdRDjqeLZgi15am32yoWiUq4EjkEa2dqOKs9cAj6NrPH9xh
 nH/84e5zF5hCCcAum5qqU9jTzzG/afHktC0dFrBdbwPa6195w8XGp1umHqascw2CRYbGhXp0U6g
 8jA/6C7LvCpguazyrTOYv9YBGfAnvnwAEMpGlTZwpeSgenCNdloRLSTxRvmNTzILnMp2RTVfXJ0
 Kh4D9f3Dtg7inP453J8J0FLwAVARX3klwMgE2vuGutcbSV06rJWX7wcWxdzqlRRjM+nbaLYIn0g
 bYA/QVYYWXCy/1Q2lZ+M18VeNdOGJnHIxz5G7zuKEIZtDvCsMA1LGeMeeiLLcR2sbZh+SLP4dFM
 Oo5avxk7joxfe2LvxO9sZRqwHUTpFjtX9sratUDLkadjJlOIv63x2IGZCk4aCUeBcK5TDsSMyJt
 4ydOTDjBXVxHkt+3UEFrFkwlBhFSiO/4wXlVSPM3eaHeFYBa1VmoQgao7Qp4mJfgYplOI0y/8Bu
 LbhpyCsyCHSI6JA==
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Some newer boards end up with a bunch of holes in the memory map due to
how Qualcomm's hypervisor and ABL work. The end result is 14+ memory
regions.

Bump CONFIG_NR_DRAM_BANKS to 24 so we can handle these and any future
expansion easily.

Yes, this is ridiculous, but there is no other way.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 configs/qcom_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index 8852e83a52b6..24b71ba7be29 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -2,8 +2,9 @@ CONFIG_ARM=y
 CONFIG_SKIP_LOWLEVEL_INIT=y
 CONFIG_POSITION_INDEPENDENT=y
 CONFIG_SYS_INIT_SP_BSS_OFFSET=1572864
 CONFIG_ARCH_SNAPDRAGON=y
+CONFIG_NR_DRAM_BANKS=24
 CONFIG_DEFAULT_DEVICE_TREE="qcom/sdm845-db845c"
 CONFIG_SYS_LOAD_ADDR=0xA0000000
 CONFIG_BUTTON_CMD=y
 CONFIG_FIT=y

-- 
2.46.0

