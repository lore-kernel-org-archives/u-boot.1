Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61355C53219
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 04:55:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2E833810A4;
	Wed, 29 Jul 2026 04:55:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id q55HobNg5kCF; Wed, 29 Jul 2026 04:55:34 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7EDB181068
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785300934;
	bh=1XEBQ3uzR69M2nBOFTBjrzenv3EgWoQiRYWZo+q7syw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eL7oCHT6jf5aJqarl363Pu0Ay6adOFc0gH10qtyEFjR0qVLb9skbZ/4Pee5PRd50G
	 NUxsGp6DXsR/3KmtnWhRyfek8PJjK3rmm9UfBROgBrQwVrU+wj7/LMIYyf4RocUjo2
	 62US7Rx9Y4O9Cqfyi8lSyHQz+dZmZpNIQb6jgbXmc0lxJ/FJmKZ9RoOK7r98q9kJWm
	 MPq8uOlDosVQOUIYAmSlPvmoINTCBtgsIqS7L6762ShJhm8BcSYCvsT6B18XycM3gv
	 SsZgMu5KwsBZ8ibxg/7Q1Y4sVNg9uosRCOwYiuJ0v8VzosxIPThsbDwAzrTmn9DFYM
	 q1UKQVQrDOo6w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7EDB181068;
	Wed, 29 Jul 2026 04:55:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4226B490
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 17:43:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2855E409BB
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 17:43:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OAwjLTeFcfXO for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 17:43:58 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32a; helo=mail-ot1-x32a.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 6C9A14096A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6C9A14096A
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6C9A14096A
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 17:43:58 +0000 (UTC)
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7eb64085c45so123661a34.2
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 10:43:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785260637; x=1785865437;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1XEBQ3uzR69M2nBOFTBjrzenv3EgWoQiRYWZo+q7syw=;
 b=gjxOZvz0k/KJAcu4ipYT8r09dleDSK1kniqqU66+0jT3j4ma2jNb0cih173taeYNBD
 F4GkhnQgtDhqS6l3AdG9cJevvldk9YTUqKj2NjgNJtu8VeTr7We1OyBdNpkx7dTYWTD6
 H6zsVyzGXbJPvZS1HKyNfu3qg4pSleApKdn0ZIaxggkKZEGgAWjgX7dyG5hCQh8EZu5J
 MdqQxLvWjvhVDA51h6N1Kypkb1NHJI1/kTndQzjODoxdKtORwpvVkqkYupMmDafFCNoe
 D9MHDXzFy9rKU9sXNk4CSRnsI5zlqbfYX1CQMIE8mSnMh5/l+9n+Ek/ditNCwTAAdkrr
 m8Nw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrE3pHbrSLcrHOpWZPGSGg6wysIm0S0jtwf02ZjMsmC/FAntyiMxczOlG1CIBwVMOHd+6pEmak=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yx0v5TR7SS/b3IEL9S9CZcuYUD0A90eYa5fYusdM4GA1OkNEbFB
 B1Ul6b912Ptfi85fjV1ewVaL1vGwupRkgPFt+wQkD+nlQihQQgJwfkA7
X-Gm-Gg: AR+sD12SY3ZwGchSwyMxePK5Sqe2Pomyez/efOKj0VIgDYLgB7zA7RAv/1KwSTCubeu
 ZelACBxv7u8O/PfvsnfKOWd0qy75bTUWzxRLqhWuz47Pj4lZODuQmzgPoaaRaK93R7hNKT0u60e
 rlqikk8jWjlBVAU2zqRIhuhtVYXUGDtV/91ExLTXaRnExyy8JFv1q6W2ijMuIGNmTF4YR1JkH8i
 558ysIl/GpMHrH1quMdaB00mpytbnVvmyKjrXNqNk1A+vkRrKDUM6WedfWq8wnUFRnDQH239uTt
 O4wlqrFN9P0SG3vzWjW6q7EGHoYfAIdyaQmcngbzwl4Nz0YyRdUFknW6UgFFXKAThj404jsKt2b
 6qPkS2iGL8b4LjMdgHmf9NcNtKLMF5XaVfFjO+VKDKlAyp8xO4DhEIe+WgoxeU47iY0hTHF/d26
 wT0G8AkRfrdltGdE8S/Hj2gR8XBdZryGvObK1k3hUgxZjbkS1da6EpBHab0iuvJjYWAQOyRgLEt
 qHO4NG4CmqNzCBYEVWdJbtgWGsyuvwR762MjYpG5LbbbZATZyyti26x
X-Received: by 2002:a05:6830:6585:b0:7d8:b269:e99b with SMTP id
 46e09a7af769-7efff243e9emr1793668a34.17.1785260637245; 
 Tue, 28 Jul 2026 10:43:57 -0700 (PDT)
Received: from [127.0.1.1] (71-218-31-69.hlrn.qwest.net. [71.218.31.69])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f00d94389dsm271103a34.21.2026.07.28.10.43.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 10:43:56 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 28 Jul 2026 11:41:44 -0600
Subject: [PATCH v6 01/13] cmd: aes: fix DM operation handling
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260728-submit-ce-series-v2-v6-1-80c1f7daffa5@gmail.com>
References: <20260728-submit-ce-series-v2-v6-0-80c1f7daffa5@gmail.com>
In-Reply-To: <20260728-submit-ce-series-v2-v6-0-80c1f7daffa5@gmail.com>
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
 Peng Fan <peng.fan@nxp.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Randolph Sapp <rs@ti.com>, Jonas Karlman <jonas@kwiboo.se>, 
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
 Heiko Stuebner <heiko@sntech.de>, Vincent Jardin <vjardin@free.fr>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Wed, 29 Jul 2026 04:55:22 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785260637; x=1785865437;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1XEBQ3uzR69M2nBOFTBjrzenv3EgWoQiRYWZo+q7syw=;
 b=XtmJPz9VR0onytawKq3WNtk3qVzRrWWaFb9DLXCBTB8eZVJX+d2cs80td/IkiPFQma
 hHxRmeqSRw9sb1ftKs35xJSeTpvwwxUfs3SxY72W8gBOhLysdcMlxbHjglsz51JiCeac
 /gpjjTwQELad4LxME9Xx3wVQRMdGZJ29j9rNoPd3bla7nYbVpa57FTENV3uX8bmpHMAo
 L4gbjMenjzsi0vY/E460Y++oRj/zw/ekHHSFqP9clazM8vTiWATRA4bOc7Zt8Cac5Cw0
 d3ZCRV8N2fetVlzyiS6BJpKfYVLpsY1rObRGjBwD+cPOB4ZEIc9LBJVfXPVsI37nQkTh
 Guhg==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=XtmJPz9V
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

