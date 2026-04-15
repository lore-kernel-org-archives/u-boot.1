Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0850AF4213F
	for <u-boot@archiver.kernel.org>; Wed, 15 Apr 2026 18:33:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1B28841D5;
	Wed, 15 Apr 2026 20:33:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="ho/B+Io5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D66C68420C; Wed, 15 Apr 2026 20:33:12 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 612E4841D7
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 20:33:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4838c15e3cbso67344855e9.3
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 11:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1776277990; x=1776882790;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z3+8nQO1lWNU/GNjJEORKTlW5YmWXTKb1BAPU2O6ctU=;
 b=ho/B+Io5/cfsE9tPqpO8uc3DhV+s6hRF7GRt3drM3HCkUMNnQ5imYoCiLH6rF0QeSd
 AEqOKdu0uP2ootaH7sJxhIHk371lqR9P5B9zUAoCobLlDkg6bthV7m6sAJ75S7htAhGt
 fjE29CNxElUT+7NFa4j2ZKBSTlSBmjWnIUHyg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776277990; x=1776882790;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=z3+8nQO1lWNU/GNjJEORKTlW5YmWXTKb1BAPU2O6ctU=;
 b=VXrlu68IRhGlGB8UW4rVujl+7Ak4jciYKhQME2NAIPr8F0VaaYjl4yJHsEFumUIX6u
 ImpIFTu5/8hk0ovbntbPFjJlSTW/MzIDdXqXRbUXr5GTQ5mdPX+DMhEL60S2eAXi8/9y
 mBJ7uB9WXGizus6VfO3ph865DX2nBZmeLdIP/AAv2M07rRW8SZH/3VMl/Xvb5gFzAZBk
 l728yLH/k0F2BjKgGphRNwJeoMNVL/7f/f54QBz0k0tty25BcnjUHTMhAGNlgzkcJnGw
 Q77yuOmwP6n4O2NE8AsN5pdsLoSL/95VwTul0GVnMdeMxjhTWjba5+whRzkiLKBAN64z
 v8kA==
X-Gm-Message-State: AOJu0Yykf1h/r0icWy5ysLtj1jQfmoOX9wnJrAjTppprU8P21lMUxhm4
 2uz7EIlBlQ2Ghoiy1tmT59V5xPbAfR51UaxGeym9jJEvxXgk9TLJ01/zS7MgP58hKDKwLnitMLO
 I77uS
X-Gm-Gg: AeBDieutoSZwULeaT8r+1Zt9XW+dQufIGGgA6ZAYE4e+fnyA7CVWY7pE0zwL8Io5DAd
 fC1tGFwWzVJvklz1qA5vQ+OykeuGerXXTUuAbvswYIFosypMc0dHwyWKysiY0w4v4089N//fOwD
 /SuGO7BQRqtynyl7tV6f4S6CFYAzyLk1mphBdsq3GDRw3sph36y87EkzK5kHhA9hA/x3P6E0OVp
 Hdyjv+HLqvIJbKmGHfWy+frR3KJ1I7yEmQD+kgijT2sKtgTFMmal4BbIgBgO0q2SYigkWP7GZzi
 kqE+JgG//MsGG6c/GseNOb2BXoVeKLzpx15HHd8rdKZ9LMyh3yeBEFO/EFtAwZKkH4ZQ6VUXVu0
 qPXMHfaJUOdqUjKqTJdH3PJkmPg3a3tCFuU2qi0ef20QF3VKkYzRIGi8kiC/2FWow1plG3Ih4ES
 YucZWH6PG10ap599KoqpgKnhfQv9qzVVXyzJkjV1jd3t2M/BGOO/1ZxfqcXRrW7hLsc8JKlBZg0
 W0JNMelYnmu9YfFDPrBqDPAAtuqVG6NME/t1sjLaYB90gYBcGWbicm2ug==
X-Received: by 2002:a05:600c:46cb:b0:488:c51f:e04e with SMTP id
 5b1f17b1804b1-488d67f3a0fmr314282065e9.13.1776277989582; 
 Wed, 15 Apr 2026 11:33:09 -0700 (PDT)
Received: from dario-ThinkPad-P14s-Gen-5.amarulasolutions.com ([2.196.40.93])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488f0e72980sm34953115e9.5.2026.04.15.11.33.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2026 11:33:08 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Simon Glass <sjg@chromium.org>, John Toomey <john.toomey@amd.com>,
 Padmarao Begari <padmarao.begari@amd.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <ravi@prevas.dk>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 4/7] cmd: part: support lookup by UUID
Date: Wed, 15 Apr 2026 20:31:31 +0200
Message-ID: <20260415183250.3031030-5-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260415183250.3031030-1-dario.binacchi@amarulasolutions.com>
References: <20260415183250.3031030-1-dario.binacchi@amarulasolutions.com>
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

The 'part' command currently allows looking up a partition only by its
number or name.

Extend the 'number', 'start', and 'size' subcommands to support looking
up the partition via its UUID. Unlike names, UUIDs guarantee unique
partition identification, avoiding ambiguity.

The logic is updated to check if the provided string is a valid UUID
before falling back to a name-based search. The help strings for these
subcommands are updated accordingly.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Reviewed-by: Simon Glass <sjg@chromium.org>

---

Changes in v3:
- Add Reviewed-by tag of Simon Glass

Changes in v2:
- Update commit message.
- Update help for 'part start', 'part size' to mention UUID.

 cmd/part.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/cmd/part.c b/cmd/part.c
index 5e520d707f39..3191d5861fdb 100644
--- a/cmd/part.c
+++ b/cmd/part.c
@@ -144,6 +144,10 @@ static int do_part_info(int argc, char *const argv[], enum cmd_part_info param)
 		err = part_get_info(desc, part, &info);
 		if (err)
 			return 1;
+	} else if (uuid_str_valid(argv[2])) {
+		part = part_get_info_by_uuid(desc, argv[2], &info);
+		if (part < 0)
+			return 1;
 	} else {
 		part = part_get_info_by_name(desc, argv[2], &info);
 		if (part < 0)
@@ -517,13 +521,13 @@ U_BOOT_CMD(
 	"      flags can be -bootable (list only bootable partitions)\n"
 	"part start <interface> <dev> <part> <varname>\n"
 	"    - set environment variable to the start of the partition (in blocks)\n"
-	"      part can be either partition number or partition name\n"
+	"      part can be either partition number, UUID or name\n"
 	"part size <interface> <dev> <part> <varname>\n"
 	"    - set environment variable to the size of the partition (in blocks)\n"
-	"      part can be either partition number or partition name\n"
+	"      part can be either partition number, UUID or name\n"
 	"part number <interface> <dev> <part> <varname>\n"
-	"    - set environment variable to the partition number using the partition name\n"
-	"      part must be specified as partition name\n"
+	"    - set environment variable to the partition number using the partition UUID or name\n"
+	"      part must be specified as partition UUID or name\n"
 	"part name <interface> <dev> <part> <varname>\n"
 	"    - set environment variable to the partition name using the partition number\n"
 	"      part must be specified as partition number\n"
-- 
2.43.0

