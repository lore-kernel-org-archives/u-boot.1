Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68A47C02185
	for <u-boot@archiver.kernel.org>; Fri, 17 Jan 2025 07:29:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A32DD806D8;
	Fri, 17 Jan 2025 08:29:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KJp7Cc/P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 610A48074B; Fri, 17 Jan 2025 08:29:10 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61C3F80312
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 08:29:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-ab322ecd75dso325041366b.0
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 23:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737098948; x=1737703748; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=A8JhqKvn3JoNmWOIVPt2eit0Lp75NbFSn92T1l4YIp0=;
 b=KJp7Cc/PjGbvUQKTrq393tEYjuvP0d+nZOBczB34GzM0x5rqPliVw4CkwdUTxlLZdj
 wPtQCZZRYzwql9bfUHcLU8lE5WJexdVWh7doMe8QS/8VkJ/j40MXtNRvt17qxKr3hxoy
 /BXE9p+ggyWtAi8vfnu8XcHXeI4UmY1crNd8jx9khs3BWJX19X3vLYgpys/3ZP7cLWL8
 qnoADG865sK9gQ3wfT5UepQFrnf7Zwvy8qugEofURR1T6Z2sQZF1c/KrRKfyGoLgSNCT
 OnD3tsVo4U3fBr9of//lpfsnRNmLXuFAL62pTCCbq7hnx+aLNdwD0Of9ZzPFn3yiQipJ
 AUtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737098948; x=1737703748;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A8JhqKvn3JoNmWOIVPt2eit0Lp75NbFSn92T1l4YIp0=;
 b=U8vnBRzeGxu0xwwxtZYEhsuBfCCfjjQya2WIlH+q8dgrp4yOtpVE8qscnh9oUZN8wV
 Yfn46bpKV7xy95WN6NYZqNZwmxNGIVxw+qlmPhQthET2ng1GxQOVOWSkFID2whSZm0O+
 8NYzzN4+2+faX7noSj28VwKoYvI7iJXP9TTth8Fjs7DyS8N5gCyK6KzJnuvlMUKdW2Rh
 L7Xngw+Qz2a1U6wwCtyUNJ2naJKQqy6JWClB91ZmHthaoNkcFmfvrXHoY8ABrXYCXriE
 0cBfrl0nN3d20EoBswpEdCgzKoYRMDuDJLVNcXoTCKSFaaPYZRAaNCBiUu+r4bUjy01S
 FPjw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/u8InBX+TGsCmUeXFajHlEZGOJM67SHC59rKIP5NfCCOc8qizUWbHjMr6buyVWTQW1vDxNSk=@lists.denx.de
X-Gm-Message-State: AOJu0Yw7TaUTgiv9+n6V56dPrwetl6XbfW6OK+pLy1LT/RJaGs3wwjOO
 ZYcdTsIIePIirtYSb/LYHGTmhxOaDg1uziaGIwPcR7iPhVTN891W2QVLkCt+OMQ=
X-Gm-Gg: ASbGnctS2m+32YllOG9MaJH0R9cML6s2LJRaE5rB/MzwOR9rm/xyQG4TIvCrlyV2wqL
 eHJAJLZUiHSl8pfThmZRTmERTIOs0zFQsLvNcAMfqkk4pBx01bsikh/eAsf5Op2BhekWxD4UcLt
 B+OUD7GFk4MfMepSbT433ZbrNL+AidqK/VGU6JDKS/VVa/kMNOONL7yaCnBMlCUjWvZVbrjYI6L
 4fXTDYsnPkq8PsjSgd21URzrxA38rwV4jge6jmxOpTM1eud+IkjEcJa8I+6xDmVfB17IgMurl0=
X-Google-Smtp-Source: AGHT+IGQ/UH+fvukiDQpE4KRzr8k9kN+7HFgBUFJikdtylSSHrD93wr9Q+ZF2ZeChQDOcpLqPYcycQ==
X-Received: by 2002:a17:907:86a9:b0:ab3:2aaa:3804 with SMTP id
 a640c23a62f3a-ab38cd95643mr102351366b.27.1737098947809; 
 Thu, 16 Jan 2025 23:29:07 -0800 (PST)
Received: from lion.localdomain ([2a02:8109:888d:ff00:ca7f:54ff:fe52:4519])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab384ce2105sm125404866b.67.2025.01.16.23.29.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 23:29:07 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Fri, 17 Jan 2025 08:28:57 +0100
Subject: [PATCH 2/2] drivers: remove bogus DM_FLAG_PROBE_AFTER_BIND flags
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250117-clarify-probe-after-bind-v1-2-273f046ce5dd@linaro.org>
References: <20250117-clarify-probe-after-bind-v1-0-273f046ce5dd@linaro.org>
In-Reply-To: <20250117-clarify-probe-after-bind-v1-0-273f046ce5dd@linaro.org>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Michal Simek <michal.simek@amd.com>, Stefan Roese <sr@denx.de>
Cc: Marek Vasut <marex@denx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de, 
 Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1107;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=/Gd7+VkPvg6RoR/+w/fhx48dROeAxase75ipX65snkg=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhvQutv0nDYpdJ81+cE730HLzxWsi7Jp1gi/8bXym+Hal9
 f5NR/r8O0pZGAQ5GGTFFFnETyyzbFp72V5j+4ILMHNYmUCGMHBxCsBErhozMnR8qlYrjhNkmrAt
 0pTDtMsl+O4nDWf/lD2lXO+Ea7jStzP8lZjqUCtqM0FL6Jz7htTKDf0TD99ekxGk95jZq+Hvnbf
 5bwE=
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

Some drivers set DM_FLAG_PROBE_AFTER_BIND, this does nothing since it's
only every applied on a per-device basis.

Remove the flags.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/mailbox/zynqmp-ipi.c  | 1 -
 drivers/watchdog/da9063-wdt.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/mailbox/zynqmp-ipi.c b/drivers/mailbox/zynqmp-ipi.c
index 713d93a200c4..851aa737c03e 100644
--- a/drivers/mailbox/zynqmp-ipi.c
+++ b/drivers/mailbox/zynqmp-ipi.c
@@ -269,6 +269,5 @@ U_BOOT_DRIVER(zynqmp_ipi) = {
 	.name = "zynqmp_ipi",
 	.id = UCLASS_NOP,
 	.of_match = zynqmp_ipi_ids,
 	.probe = zynqmp_ipi_probe,
-	.flags = DM_FLAG_PROBE_AFTER_BIND,
 };
diff --git a/drivers/watchdog/da9063-wdt.c b/drivers/watchdog/da9063-wdt.c
index b7216b578630..ec9bc0330114 100644
--- a/drivers/watchdog/da9063-wdt.c
+++ b/drivers/watchdog/da9063-wdt.c
@@ -144,6 +144,5 @@ U_BOOT_DRIVER(da9063_wdt) = {
 	.name = "da9063-wdt",
 	.id = UCLASS_WDT,
 	.of_match = da9063_wdt_ids,
 	.ops = &da9063_wdt_ops,
-	.flags = DM_FLAG_PROBE_AFTER_BIND,
 };

-- 
2.48.0

