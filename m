Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAE02F4612A
	for <u-boot@archiver.kernel.org>; Mon, 23 Mar 2026 14:32:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 293528408D;
	Mon, 23 Mar 2026 15:32:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UJdtdibP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45EC68416C; Mon, 23 Mar 2026 15:32:08 +0100 (CET)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0EED083DB6
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 15:32:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7d7eb85fb81so240700a34.0
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 07:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774276325; x=1774881125; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B6p1c2yorEEOodyCwXZ4OPqwlcFjmA+nJUfP3lFFchk=;
 b=UJdtdibPVm3M6BzztIA4GjHMkQgDck7406oNkc52xD/dWStfO4myM4S4UQ1gSgie9i
 TFYBPI7DspZIsD3QyqCHWDFBWI1Ayg2lbKbbz4+U9MKrJhBtNMl/JT56GkCi3AuCSTBc
 hbh3IU6RQSqlhofSETHH7gEjFLNdTyfb9BUZA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774276325; x=1774881125;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=B6p1c2yorEEOodyCwXZ4OPqwlcFjmA+nJUfP3lFFchk=;
 b=Y/LBdZtXyOSnzNylZJZMSKa32XkCuOlbpf8PN40pXohkjdGqy9EZYf3QzxUb0nM9SE
 zREUqA0mW/4eutgHok/anFhfWf8sNJUNcIxGSi/7o3OhnR3XFROWbh5roHuk5iu9O0DT
 9ZKzLJyJnxaaHQ3kSIrLQPSJ0TGV/SqDv7y1GjPynywZqAQzeJbIJpPOqB2qFX7Xzl6E
 XrbuW1G/7Z5/fSbna8q5vCp5iN6uNmQIezZAvT9pOWWK4tsAYqi9DneZTHE0o/ixtTc3
 anTbaq+hxJRGR1Z1YAGgwS+twf3+pjpE4pZli0SvGQe5LI1k72c5iwjpDoRoJys4HusH
 RlTw==
X-Gm-Message-State: AOJu0YyryJ4yz3IrY35lz2Vy05U3IzKU9XHu8ekOl9lCciHPdlpvyB4m
 emgchLnbN/UmZoM5QjVtQtRhZGjA8YUqqUl8QmsP8JLDy8PNuHoU58r45ALDjnnZMSVRzqMjL3o
 Dysi3ZNc=
X-Gm-Gg: ATEYQzxSIG5YEb+0aea74rU8+TkJP6uaZVKW3hTu0JCrmAQ1Kpk0UEjAbEItzE3N8dN
 NQKzgk9uvaIfzUuMDc9X0GA6Siwnevs5ecWwTa/SSDTfcXnIcpuhpT1B1iQlNBQNZhTNqGpFmlG
 aqUkV8orzqODl+xhFcLCMD3DelhTstnCpxckMT2QSzHcmzjBa5kEgdc7ivR6lrQxu7ccVf7HLoL
 mn7SuFX3GQzgk0LEQ4mjoWoqFZ0I6S0W7b6Vc2atyBOIs46Y3FeNzcSGZL7g20+bIs6zwOdno+i
 DJNtKWNkbqvglihl5mMEE9GL2ZABxwQUWVZ2AMGq4TpL3W+Wc0Rj2zIwiApO70eFMpCP4czNWKl
 z1QGlOMLtylVuN34C+uCepCKMHUeVOZXN3Rs7yGurkCM4A/X/nr0ez8kl9XcVFpbuoM/nU58nGx
 6asHfdXiA/nEBfh9lBViqJcZNVBoCc/CsoYVIp4dzwi+FL4549ehcA8UunxVOqEacsnRbPu8094
 yZ3fjYJSb31ue4nIELaDVwQdGAShAbEO6TJUptZ5y1N/fHmlfo=
X-Received: by 2002:a05:6830:8382:b0:7d7:ea04:6654 with SMTP id
 46e09a7af769-7d7eaeced6fmr8724407a34.15.1774276324674; 
 Mon, 23 Mar 2026 07:32:04 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d7eac17471sm10206484a34.7.2026.03.23.07.32.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 07:32:04 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH v2] reset: Correct dependencies for RESET_RZG2L_USBPHY_CTRL
Date: Mon, 23 Mar 2026 08:32:02 -0600
Message-ID: <20260323143203.2271987-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317012443.4162600-1-trini@konsulko.com>
References: <20260317012443.4162600-1-trini@konsulko.com>
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

As exposed by "make randconfig", we have an issue with the dependencies
for RESET_RZG2L_USBPHY_CTRL. As this functionally depends on
REGULATOR_RZG2L_USBPHY, express this dependency directly in Kconfig as
well.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Changes in v2:
- Make RESET_RZG2L_USBPHY_CTRL depend on REGULATOR_RZG2L_USBPHY as
  suggested by Marek

Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 drivers/reset/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 66911199c8ba..ebf484d9df4e 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -239,8 +239,7 @@ config RESET_AT91
 
 config RESET_RZG2L_USBPHY_CTRL
 	bool "Enable support for Renesas RZ/G2L USB 2.0 PHY control"
-	depends on DM_RESET
-	select REGULATOR_RZG2L_USBPHY
+	depends on DM_RESET && REGULATOR_RZG2L_USBPHY
 	help
 	  Enable support for controlling USB 2.0 PHY resets on the Renesas
 	  RZ/G2L SoC. This is required for USB 2.0 functionality to work on this
-- 
2.43.0

