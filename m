Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 759FDC5DF6D
	for <u-boot@archiver.kernel.org>; Sat, 15 Aug 2026 13:01:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E9CA181237;
	Sat, 15 Aug 2026 13:01:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lHAE6UHCVS6p; Sat, 15 Aug 2026 13:01:23 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6E6B480FAF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786798881;
	bh=1XEBQ3uzR69M2nBOFTBjrzenv3EgWoQiRYWZo+q7syw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cwgCQ/lMhb/n023jQ2FkCSCYqPTZa7aH9FMp60R4IeO1ICQbOg8GPprHtGtoflnBM
	 S+KwpA33e9WJTFWbWYBem5VsPpoJwj2dYr8MLz0fK1lXCO9p45bWkCe/pTII8ou/BA
	 Z5qw3v4IBfjto39Rm8t4WH/FO2JhkZLkY8WVwIvXCyePGCocsWqUpS0fXk8On21kgB
	 P3s+ubs+ivRiRRXNDnIQWfq5b5e36+A2d/625nwS385JCY5BCaKq0N9z9CFwiUW+iy
	 BlpOWoUr8kkjOx5Fbf6Nc0qIcy8CuaSAgwBikpd7q5417fwE2PE1V0rNQklx3qdVY3
	 WVlHjmtfQtS5Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6E6B480FAF;
	Sat, 15 Aug 2026 13:01:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 25B49282
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 05:48:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1802F60DC7
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 05:48:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id S-u17HPuMTVI for <u-boot@lists.u-boot-project.org>;
 Sat, 15 Aug 2026 05:48:41 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::330; helo=mail-ot1-x330.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 5A1EE60A50
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5A1EE60A50
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=m8TXn0YF
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5A1EE60A50
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 05:48:41 +0000 (UTC)
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7e6b5737bb2so2221963a34.1
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 22:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786772920; x=1787377720;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1XEBQ3uzR69M2nBOFTBjrzenv3EgWoQiRYWZo+q7syw=;
 b=m8TXn0YFdx+o7jmCi8TFvNrps/4IMkg6aR9RzRcf5e9UEnO/worN64PHs8s1YLOdTD
 3b+alK/Yav4RXHJjIapUZFRB4HPOga0M3vbDfAwXSlKei0nv/mmAmDfNCPIKFGzxel0I
 FoPchXI+oEhCAP6rY0Efi151ujDANs1WsoSgQ9XOns8TtPqeWie1V2kmc8GwpuOx5bnc
 6zMfxC/OjjZUDQ2mjlaLAVStFzR7gTBOe4xviP289fuLeJ4IP8o+gB8Jp+htg17Iysio
 RoPTXIScDS7FpvOVQ8K7Rg2OHITgEV4/nnqYCo0LqcD5OLCLZ/kesCxY0CmNxADNy3VG
 m04A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786772920; x=1787377720;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1XEBQ3uzR69M2nBOFTBjrzenv3EgWoQiRYWZo+q7syw=;
 b=lVdUMjuFh6uDWyh2b0DIwE72Kwcw9eivNPIa1Wp0zPvWjPLeXiJ2C2awCFnL5NLkva
 ZTcOgtghhlad3IVks/RoAJzr7P2spWR5viy2qnDSbadle+facYfiURg4whA928A0Ho4B
 zQ9cZ+38qjh38uCSS4DXGMpW9J9pBB3ilri83GGHJ6J/4T56/F8QRBrNcqnnTOLW+xOl
 V86Z4ca18bjZs9KrwbixY8qzlYoiqjTMNn1yYZTQq9x2QCFurFKY8SmNkCYg4t8yzK4a
 1kRvUe7FcWZptCUsfKBU/uEFYEHu8o+gJ6BHJiZEGJ8llURR1YTDxxdNK4m/9ct8c0IM
 HX9A==
X-Forwarded-Encrypted: i=1;
 AHgh+RqZ9/Is/QwTut2BvfR76BzHFvHAviE36DazSTuRsdT+3bym4UtcjlpgKoUefLaOMOdGDjCS1mc=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yxu8Q63vSJFJOk/O6cJSxTjzofrM6Rks3T05eBdQy72187R+q8t
 yUWpFV+semP15ZXyQS3RQsCAsoSnBWoyfnSDJ09IbzYdTEQRRi/atNQy
X-Gm-Gg: AR+sD10WC4R4P0afu6gLXo/iHE+xZ8lz7VBf5wA4YKQCcPkOaW/YOVbyXTe8XQVLqdW
 oAQ4F4Qcnj0psB6pjtlJdoiKxRBvgbIWisZHUd7JOwZIFtoLVKgrKdeyChxypzJvbm+QvqEPC1w
 XURjyKcHp8tLLleStV+i4CqNfOSavrV2FcpU0OwBGIhXCw+1l2hxE/P7XL4UdYEBo4WNxpcwO3L
 7Flsi8vZny2YkTCX2/eUkWIzBrsPmWklMZmmeOXxqAeg4r8Ni9uDGYb2go0Yad27Yc5X7hjS3PH
 nh6ASVcx2zaZBSuo9IVm46DBHqOc8Pb0G1IKtmJ1M1MWbKIrbbprzo4UdPd/Dq9sDnSbMOhNv75
 in80PpQjo3T+UGN+bVCuvS4CY/RMmNVrOFVw6ozuX0Dk2EmF4meblFNxGOIaHRli8cIp6UwoOqd
 V+vFpcWMTeByq5D1j6PUKyoZHtzPxlCr8PdSNo9Gw4ymAf6QXfyoshMplf2W9E5Z3QiIj+d+mtH
 GlcPpxUm4cjyVxf3Qh0ut17xCksB/Uy/aiHOkdaQtLFNytXZM0glknmUl58Y7QHEf5UwFP9fno0
 iy2plqvlKJuoaszFeIRJfYXA+HvbSBj/iZ1FM45ylCD5zjXMHJHafB5L4SbmwnnAusP5ldSj8oY
 nsf1HhrK033fF5RgD
X-Received: by 2002:a05:6830:6996:b0:7e7:16b9:e274 with SMTP id
 46e09a7af769-7f3de5270a1mr10692069a34.8.1786772920125; 
 Fri, 14 Aug 2026 22:48:40 -0700 (PDT)
Received: from [127.0.1.1] (184-96-154-59.hlrn.qwest.net. [184.96.154.59])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f3e86282a6sm2780166a34.18.2026.08.14.22.48.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 22:48:39 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 14 Aug 2026 23:48:08 -0600
Subject: [PATCH v8 01/15] cmd: aes: fix DM operation handling
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-submit-ce-series-v2-v8-1-fe9212431a94@gmail.com>
References: <20260814-submit-ce-series-v2-v8-0-fe9212431a94@gmail.com>
In-Reply-To: <20260814-submit-ce-series-v2-v8-0-fe9212431a94@gmail.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>, Ion Agorria <ion@agorria.com>, 
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>, 
 u-boot@lists.u-boot-project.org
Cc: Chen-Yu Tsai <wens@kernel.org>, Samuel Holland <samuel@sholland.org>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Thierry Reding <treding@nvidia.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Quentin Schulz <u-boot@0leil.net>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Marek Vasut <marek.vasut@mailbox.org>, Rasmus Villemoes <ravi@prevas.dk>, 
 Rasmus Villemoes <rv@rasmusvillemoes.dk>, 
 Aristo Chen <aristo.chen@canonical.com>, Anton Ivanov <anton@binarly.io>, 
 Daniel Golle <daniel@makrotopia.org>, Francois Berder <fberder@outlook.fr>, 
 Peng Fan <peng.fan@nxp.com>, Patrice Chotard <patrice.chotard@foss.st.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Randolph Sapp <rs@ti.com>, 
 Jonas Karlman <jonas@kwiboo.se>, 
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>, 
 Alexey Charkov <alchark@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heiko Schocher <hs@nabladev.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Anshul Dalal <anshuld@ti.com>, Johan Jonker <jbx6244@gmail.com>, 
 Francesco Valla <francesco@valla.it>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Michael Walle <mwalle@kernel.org>, 
 Andre Przywara <andre.przywara@arm.com>, Lukasz Majewski <lukma@denx.de>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 E Shattow <e@freeshell.de>, Enric Balletbo i Serra <eballetbo@kernel.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Lucas Dietrich <ld.adecy@gmail.com>, David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, 
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Mateusz Furdyna <mateusz.furdyna@nokia.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Heiko Stuebner <heiko@sntech.de>, Vincent Jardin <vjardin@free.fr>, 
 Raymond Mao <raymondmaoca@gmail.com>, Yao Zi <me@ziyao.cc>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Sat, 15 Aug 2026 13:01:17 +0000
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

The DM AES command path takes operation-specific arguments after the
common arguments. argv[1] holds the mode, "ecb" or "cbc", while argv[2]
holds the requested operation, "enc" or "dec".

The DM path checked argv[1] for the operation, so the ecb and cbc
commands always returned CMD_RET_USAGE before running. Parse argv[2]
instead.

Fixes: b01444aa14cf ("cmd: aes: Add support for DM AES drivers")
Reviewed-by: Svyatoslav Ryhel <clamor95@gmail.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v1 -> v2:
  - Limit the patch to the argv parsing fix  (suggested by Simon Glass)
  - State that the commands always returned usage
    (suggested by Simon Glass)
  - Add a Fixes tag  (suggested by Simon Glass)
---
 cmd/aes.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/cmd/aes.c b/cmd/aes.c
index 3fd83013ffe..edcd87cf11b 100644
--- a/cmd/aes.c
+++ b/cmd/aes.c
@@ -175,9 +175,9 @@ int cmd_aes_ecb(int argc, char *const argv[], u32 key_len)
 	if (ret)
 		return ret;
 
-	if (!strncmp(argv[1], "enc", 3))
+	if (!strncmp(argv[2], "enc", 3))
 		enc = 1;
-	else if (!strncmp(argv[1], "dec", 3))
+	else if (!strncmp(argv[2], "dec", 3))
 		enc = 0;
 	else
 		return CMD_RET_USAGE;
@@ -223,9 +223,9 @@ int cmd_aes_cbc(int argc, char *const argv[], u32 key_len)
 	if (ret)
 		return ret;
 
-	if (!strncmp(argv[1], "enc", 3))
+	if (!strncmp(argv[2], "enc", 3))
 		enc = 1;
-	else if (!strncmp(argv[1], "dec", 3))
+	else if (!strncmp(argv[2], "dec", 3))
 		enc = 0;
 	else
 		return CMD_RET_USAGE;

-- 
2.53.0

