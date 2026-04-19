Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37E30EA7190
	for <u-boot@archiver.kernel.org>; Sun, 19 Apr 2026 14:33:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D84D0842C2;
	Sun, 19 Apr 2026 16:33:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="iwAe511b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D42183B99; Sun, 19 Apr 2026 16:33:04 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6BD8384286
 for <u-boot@lists.denx.de>; Sun, 19 Apr 2026 16:33:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-488d2079582so25260995e9.2
 for <u-boot@lists.denx.de>; Sun, 19 Apr 2026 07:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1776609182; x=1777213982;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oAoP9NlzWltH1g0ieIPWcLlhZGE6FDHWvuaN/OvBd5Y=;
 b=iwAe511bOuGRYLYY3U2NWra8PIDeaPwveOP2zXljjgLvaPN4gJzcpGhLjcRsW1Fo3U
 ej+3XxL+paE1q3Abel7lgltvUXUYt1LVc41TKHXwdR05V22pZdUSSvEWs0iWBDYX8rgZ
 zx1RJxl9NfF9pXe5V+fLmY+xW64aeAr3nIru8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776609182; x=1777213982;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oAoP9NlzWltH1g0ieIPWcLlhZGE6FDHWvuaN/OvBd5Y=;
 b=UkAv9aPv2CcMz6umw2caRpg5h24LVpf3X2yFRNrF6/vAQnCcN7bbRoH9dZuqM4VQYh
 M2yedVuN3/kX3nXKB9syelrFDkt54HoI/HiUriLhRnUc0GMvu34j+bUUSoF1L5PY+Z+3
 M8P53ewAcHnlyLLWHKmLyZrTIIUHhpLfd9HequYq4OjmdOkhulk5yZ31w7uYRhht96Ha
 GYj4jSfE0cpeurSAj7wciH7Saqjl483QPZdNYq/r1aQM5r3JcC28Nqsi0XouVRmKEvPH
 NuIJgTFWoGuuGWAE3xyzB+pn8wl2E4v4Fx05wwY7zOxn4flNOLmyv4BIzk3tDQLbNADd
 n0GQ==
X-Gm-Message-State: AOJu0YwPMMI9OnKOG7MfbPP9fI+8FwPr9S31ejORszcVN2FASAcRgpiQ
 KqvdfP4J2cbloM/ZjXsvuRgPFG8QyomhXfPWdNNY1t3osTqLwY5NK+IK5P2V5s65FBpS5yZPFmK
 zLMcw
X-Gm-Gg: AeBDieuUDCBrONYF6fKKQdcJJOlzGkrFzvNz09GKw29SgnOE/mjaVJLHRdTb7TFjl2t
 f984/O43FJLvSRsD75DGBF63DeKwuDEf4yPb/K+D+LOjr4YYaINm+l0iOj4XLyVXFi004AETm+E
 DOKqXkd5Kh0P1KU4N1woG7xApv9at7FLPeiMaX92YQ1Hg/eQpTkmBa42TXtgFap5EQfb+sWV/vU
 dLY4GIFey8ZJL/RwGhC09nOPj25ONhVvdKui7exVyWPF0aKQ6Y9KfeF/CD+kQwmR3ucC0If6aGE
 V1z8/j2PGu2D6MtXtG8mLrXy8AJ/5vRW3C+x6mLNUQQNrh1Wl6rg3TheEsojO+S/OZTOYxage7g
 /EtfdDyu2i43nKSiBVXRJpm/qoZrpzWL3LNRyXA8N/W8CpPcExCVIpt0g3vs9bmCovviqbWgU1W
 90Zmtdj1KElIe7c9R3JSZw4RAjsFoDjymlSUc4mC0Se0qk973l3WFcEcuKFi7ZBIhVKctX3WYyn
 zBmybPwO4wPFedvPK1Cj6fE1qrO1mSLi73xBSGFjBvJBSWI6d8tLCtSfC/73Hr8f76i1xEL2VaV
 nsfXt/n31Qth+30JZYyO4m6HO1RB20Ey
X-Received: by 2002:a05:600c:314b:b0:488:c282:e78c with SMTP id
 5b1f17b1804b1-488fb77870fmr136331995e9.19.1776609181607; 
 Sun, 19 Apr 2026 07:33:01 -0700 (PDT)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-79-20-97-39.retail.telecomitalia.it. [79.20.97.39])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fb755938sm86864245e9.3.2026.04.19.07.32.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Apr 2026 07:33:01 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Simon Glass <sjg@chromium.org>, John Toomey <john.toomey@amd.com>,
 Padmarao Begari <padmarao.begari@amd.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <ravi@prevas.dk>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 4/8] cmd: part: support lookup by UUID
Date: Sun, 19 Apr 2026 16:31:44 +0200
Message-ID: <20260419143247.437733-5-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260419143247.437733-1-dario.binacchi@amarulasolutions.com>
References: <20260419143247.437733-1-dario.binacchi@amarulasolutions.com>
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

(no changes since v3)

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

