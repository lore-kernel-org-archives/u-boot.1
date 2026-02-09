Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95A6DE7E0BC
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 18:00:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F1FB83CB5;
	Mon,  9 Feb 2026 18:59:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Vy4P+1qK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C1E6480325; Mon,  9 Feb 2026 18:59:51 +0100 (CET)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD34C83C5E
 for <u-boot@lists.denx.de>; Mon,  9 Feb 2026 18:59:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-59dd4b602bfso6171215e87.1
 for <u-boot@lists.denx.de>; Mon, 09 Feb 2026 09:59:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770659989; x=1771264789; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=85Lv1e1fVUDFDygGz5NFZ7GCsrJSKuuGxv4yigorkWE=;
 b=Vy4P+1qKoEAvzhnQN8Nt+L/glqnFuN8UttgH4PnyOFHgf5BlBUIFKA5CpIOQwYw6AW
 3plkCd7kBl8DdMJOiC+1YDGr0DWnzHWqRSamUreXwBX8BXYtK0kLho6vaTBHjo+tYcRA
 SYzYRXBRPQs9tjV53TTUs2swmWmjykqr/thLkDDIy/GgSg/4j9aVjLJwpZhZsO0X7uMS
 k/Ha7nMIvDKomi35dF57zkHCGHJmJGiOpt7hE7Qfw9+d9uk3zxSz6D3WQxdGGP/csjEF
 Y5/rTBpRBIYPiLTGYTUGtY2ML8tboN1eTYj9kI/tQWVxEry63V3raF+c4xPfhORMQcWH
 XWpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770659989; x=1771264789;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=85Lv1e1fVUDFDygGz5NFZ7GCsrJSKuuGxv4yigorkWE=;
 b=MivzDwvdG7n/t9asm5jre1o7Ir+FbZwlc4Y8moh0tKyxcwwQfX/O/qgDGa61voZq6N
 h/SPKUk5EHrJXWEyVBMznCsX1l9nGdHCxaF5MjKgkjPQaxKcg+IN/EjW3LO5t/YccSVp
 t4I5vcOCDsf7KLEdiqmyX5liRct8qQ5XOjhcOoVqqKdTIYmXxF2P581Ecf/jJshZcxaT
 rrhX7780PFeFNBu1NA73qbSrWgZh2tjZr0OXHjUkwtMjIfcakR+K6ojzdyFXdLBdfnci
 O4JG/5niNzFAj73Xy6KZvh7DG4VZLG2INhCBd1I+66hbbR+PWkzyQEqTsMKOOZ5FC5cS
 aWeA==
X-Gm-Message-State: AOJu0Yz03BIGMpEkdNw8rzau50LIRUBSlBSUJpBvd0P75GIeblmymtWv
 Hwy1UbDnRubcXv3eIs88YreHW0GvqBcUGqoF84KMfqH44ZXdSThJ5zSPPId6Ew==
X-Gm-Gg: AZuq6aIGvOZ8f5IGVogEREjIcykrg/TzwGxKd9HRrq8yWxkh9HGLbMc5MIfiB0+J+jj
 F0zR6i5oaGQazNoz0kkyYLQ+uLMz6NJ+vGFG8h6AFWsMkuyepNhTced0Q79ZL2DNJzqR33Iv8ph
 A3xRXZEGNKAWFCbALBqCIcWM+8epfvXFjdP1aGaOhCK2DICQuyDK2suXv6oxVzm54jZ+uGmYU13
 nDvwc9I4kT/1TagiqEosnh6+Gl/3agAvwkse75rtLnyQDj3N1j07E8In9JFwfe843a2ISS2Z9pB
 pvsi7HuS+8EPuupIr84lyiQf+m+5MkhTZA2IZqQ3ozvTx6XJRCaiW+Kl2FzSexcr+GyAaCeR/O9
 O0Ap669vim5nDtnKYspLB1ydY/74m52WrOvKBN8gGM6oYsXKyOJnWt2g8hir2PysVC51Ac2LmgT
 Xo
X-Received: by 2002:a05:6512:10d1:b0:59e:3e25:d19d with SMTP id
 2adb3069b0e04-59e4514a09emr3955559e87.23.1770659989031; 
 Mon, 09 Feb 2026 09:59:49 -0800 (PST)
Received: from xeon ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-59e44e21c9fsm2756688e87.77.2026.02.09.09.59.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 09:59:48 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>, Ion Agorria <ion@agorria.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 2/3] ARM: tegra: ap: add default fallback for Tegra20 SKU
Date: Mon,  9 Feb 2026 19:59:35 +0200
Message-ID: <20260209175937.32010-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260209175937.32010-1-clamor95@gmail.com>
References: <20260209175937.32010-1-clamor95@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Ion Agorria <ion@agorria.com>

Until now all Tegra chips except Tegra20 had a fallback if SKU is not
known. This caused issues previously when certain SKU wasn't known. Add a
fallback for Tegra20 aligning it with other Tegra SoC generations.

Signed-off-by: Ion Agorria <ion@agorria.com>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 arch/arm/mach-tegra/ap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-tegra/ap.c b/arch/arm/mach-tegra/ap.c
index ba67cbb1447..4d66de1e937 100644
--- a/arch/arm/mach-tegra/ap.c
+++ b/arch/arm/mach-tegra/ap.c
@@ -77,6 +77,8 @@ int tegra_get_chip_sku(void)
 		case SKU_ID_AP25E:
 		case SKU_ID_T25E:
 			return TEGRA_SOC_T25;
+		default:
+			return TEGRA_SOC_T20;
 		}
 		break;
 	case CHIPID_TEGRA30:
-- 
2.51.0

