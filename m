Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B41DCF4485A
	for <u-boot@archiver.kernel.org>; Fri, 10 Apr 2026 13:33:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3565A8412A;
	Fri, 10 Apr 2026 15:32:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="FyDVQTHd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 77F7A8419C; Fri, 10 Apr 2026 15:32:56 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8EF8E83DC9
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 15:32:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-488ab2db91aso30303255e9.3
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 06:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1775827974; x=1776432774;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=uOlP9ehqKD0nJx09UK1ubBUZO9S/PHd9NFMrxofHz2E=;
 b=FyDVQTHdOnc2ubknRG8P91D2wbhnQWehoeh0CN6WIKKOz9HPN4Ef2Ayo4TId1/e81s
 6VzlSt0mAw35D8I0NOQ/KJC4C4B1OTQxU/a7zNcdBYDuNG4tBS8L6blJWIbcXQbiD6be
 F75WapRV6kNIFW3NlnY8fwgzrnK7mR1Ka9V18TsD9/dyJ9kyKK/GvVok5T1KwOizFObh
 wrScH7TjxDQWi3icdLttOghJ77chbBqIM8KtHhPV1oaLyCvm3tiYQxogiJrR5Qz/3GH/
 OFdDcN9PnU5O6o2NInuRhj70qghzjaoHoPZuFCgrKF9r5M40l2ROAzpC9xDdG+XjsfJ5
 qwBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775827974; x=1776432774;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=uOlP9ehqKD0nJx09UK1ubBUZO9S/PHd9NFMrxofHz2E=;
 b=OPP5EjXyPAa5T9q4WFuOHqMtI9/PXEL/uQmt7KyR8L9TBDE2aiWM/8/MULsac7EH9K
 tinVSy8MzUyCIfrFX4BIvevLCi1KVYNKwYXD4mwfdCklh2qvna31/TCliyaLndeCA2Uc
 wOPKsKj0BreCUWX0TWc851NZUVkUezlFwPqiyGy3LFyWUed8IigBvGj6rtW0D97uUOb4
 91+rOY3j1KbihHnG1KY2e+maSWiBTJXm3WExvthd5dUPjHvz4nTU2FKLa02v9YY/QZXm
 SFXdDae3V+FojtwHH8pJWoWpJunqMW3XY+0NNMVlzONJvHqqc2zD2cnFI0tsmqePkPvT
 t9mA==
X-Gm-Message-State: AOJu0Ywg8DSlLIpLP1tFuxIgFBr/RD26QCTwqNfDGVImBzYxMxt5Fj7H
 BbTkQLbR6KvZrhnhmqYEw1Dddto+aEzjAJG03snk1HEuixznf0jXG/TXaZw657fPknEcPvceItF
 YxEbP
X-Gm-Gg: AeBDiesZK5h/8eQUpcMy2KyXX+GhLB7f1gQpCNcA0QXgBEh3R8nokATHEnR/ts5wz+v
 i5Qf3Wp2LR1FVMOp8vxcUd+dakZP5vZgSfRvgIyLhgL98FHsfQgo85xaD5N/RDtWQnCH7Ss+VWx
 l5AEbjc5f7Gd99C/gQ7zgSnabyQTAzEZ4o04qxPIa6v5awrqbDdiN4CpZXQbXMzofeswDGgzq1g
 ci3V25k8QN5lrMO1qYNmt/v9U8l1lNRdgOm7FVPKkzx4UxILzrNoDwhLtVGEheScsHoM4kDkKbf
 dIRp2nXQg7pLzYy50+oiHQHhlQtGDIkwlJYuB0xHVvxVKyelWkmiAvb6M4I4q46koHEqPrnICLG
 AvzvWSnfXMD+g/lJ8xa7zK089/lIC3NTTAwJrmVUb4KCollGtVkvhO6x/i+tE7Z/RWJsuPe/W5K
 C6f4GJWMuaLyPxo8pE3e+A
X-Received: by 2002:a05:600c:8591:b0:486:fab9:a578 with SMTP id
 5b1f17b1804b1-488d67eca69mr31339335e9.11.1775827973981; 
 Fri, 10 Apr 2026 06:32:53 -0700 (PDT)
Received: from localhost ([2001:4091:a246:8598:4c79:7b44:ca74:c5de])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488d5cfeb2dsm22318765e9.0.2026.04.10.06.32.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2026 06:32:53 -0700 (PDT)
From: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Date: Fri, 10 Apr 2026 15:31:43 +0200
Subject: [PATCH v5 03/12] include: configs: am335x_evm: Enable vidconsole
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260410-topic-am33-evm-oftree-v2026-01-v5-3-4b9c7aca0e3e@baylibre.com>
References: <20260410-topic-am33-evm-oftree-v2026-01-v5-0-4b9c7aca0e3e@baylibre.com>
In-Reply-To: <20260410-topic-am33-evm-oftree-v2026-01-v5-0-4b9c7aca0e3e@baylibre.com>
To: u-boot@lists.denx.de, Marc Murphy <marc.murphy@sancloud.com>
Cc: Tom Rini <trini@konsulko.com>, Rasmus Villemoes <ravi@prevas.dk>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Romain Gantois <romain.gantois@bootlin.com>, 
 Parvathi Pudi <parvathi@couthit.com>, 
 Basharath Hussain Khaja <basharath@couthit.com>, 
 Paul Barker <paul.barker@sancloud.com>, "Andrew F. Davis" <afd@ti.com>, 
 Simon Glass <sjg@chromium.org>, Anshul Dalal <anshuld@ti.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=795; i=msp@baylibre.com;
 h=from:subject:message-id; bh=JamhYeju5KMhfYyut+kFM1iQJRDwSL3iLX9TNaqcHj4=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhswbv89fCQk3XjW5/2H5qbgZvOJs8TdNHzZ6FFa/3Tjzt
 6uYrrplRykLgxgXg6yYIktnYmjaf/mdx5IXLdsMM4eVCWQIAxenAExkQRjD/7ibZRU+N//lMNVr
 7StbW2rCbypeZRGRPCEuKkf9b8+tRIZ/GhsS1TdWFszWv18Uss6tjslhtphy2bWHdvt3Jr8SiY/
 jAAA=
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
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

Enable vidconsole for the am335x-evm board.

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>
Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
---
 include/configs/am335x_evm.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/configs/am335x_evm.h b/include/configs/am335x_evm.h
index d2164b41d6d6e74c7da0554b966ad5ee1f78e8b2..babf065bc3ea8c63f562ecfb07080f471b489fcb 100644
--- a/include/configs/am335x_evm.h
+++ b/include/configs/am335x_evm.h
@@ -83,6 +83,8 @@
 	"fdtfile=undefined\0" \
 	"finduuid=part uuid mmc 0:2 uuid\0" \
 	"console=ttyO0,115200n8\0" \
+	"stdout=serial,vidconsole\0" \
+	"stderr=serial,vidconsole\0" \
 	"partitions=" \
 		"uuid_disk=${uuid_gpt_disk};" \
 		"name=bootloader,start=384K,size=1792K," \

-- 
2.53.0

