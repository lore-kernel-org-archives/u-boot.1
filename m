Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB10606A680
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 13:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=WVlE6p+W;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JDPVhseJ
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DC2FD811C5;
	Thu, 26 Nov 2026 13:33:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NRhgPt4g9R7w; Thu, 26 Nov 2026 13:33:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 81B16811A5
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795700027;
	b=sNwefenwj37W6ix/YcKMvHIK+HDakBn2Y56xvQmaBoHlRUbDQG8zrPtPYDgTkKyB5d3Q
	 nxpr0FI5oGRgCGP89aIiO8bBwrGBGLOQ/LtIdqif/NPXX3JAkdBLzs8Oxqf6wi5oW038g
	 rfmE5JbbjG+5zfRyBz0DL5I0dXmJC9XhosR31bPHnAHA8xYlC1ZghNyR3+YLknKqc5E+j
	 XA7mIsRF5ISV3CmlrsAGE7FwWVelxBZ8g++dxcF5XYo+mJd4i/BPHsnQhcRPWL0q0hyYf
	 5Qjm/Q4bHtn9Cbe1PK2mWL+F3EFLELwqN7i2/cX+xxPcSXxULkJ2TO5/UyS0IwnUP9Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795700027;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=FofOUSAW3Eoqj2dlOXaHR0i8DLCt7yIzJ6ZGd0OUweQ=;
	b=UDabIFNFkhXjusr93Uy7evBz1F2YO9vLQ/FU+dVBe2fs44+D5FKkr4kxtuMJJ+GDWYTL
	 GsxiKERp5CuYBQSuFJu4FxTl8HDKs6ZeJwwSdbO0HEfr7yeTUT1wr5H0IOmE2zT/ZAv84
	 nS2LOMyfUK73Mr4AiugB3trqSulBnZRoudtJcvOPyyS7CjhYxYARr6jm30EO6+pLoeLns
	 +AlwpfInuZ1JgJWCaOsm0GQju7kuiHjXgAaohghfXPK9Zed/1R0xSgGPYsgzHWQmuo+By
	 aOuyF9l6LVPvVVNQloDEpdF3hZgVo4MNIo8sKRsZNsSebYSiJnVqFItKhT/LmCrTeZg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JDPVhseJ;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795700027;
	bh=FofOUSAW3Eoqj2dlOXaHR0i8DLCt7yIzJ6ZGd0OUweQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WVlE6p+WfLnh7UIMKhk5aIyOu9HDdJ5VXiyCXc56xZ/1vLtbxSHBbOs+FYuhRzhuQ
	 e0dVzqwLEC5BPyr3codWQDyWw9KmWxZBGValyIky+j4NCOmXzzlpqEfOwiBAggP5ia
	 n57WqOYJtCgAi6oqBUfNhJVqIqVPpY7TTqyNtdaMETd2IFiztleMIFOEh4WnVY6Jva
	 JdTQH0f1CH6MOxZYuFTEr68hd6hAwN1fEAF45MKwtm0M60CHpvUY2SCgFfY3io3d8B
	 f2qsmCJ7auYwGI6qmWp6dAA8/jUUsjx9jwHvwKkuQQspNUmsnAeDbF5fqXgzGiOnc5
	 y5rVuM6UVbZwA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 81B16811A5;
	Thu, 26 Nov 2026 13:33:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id F2DEC32D
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 06:53:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D906981004
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 06:53:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fIIEj6Dl42f6 for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 06:53:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 91DCC809C0
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c30"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c30; helo=mail-oo1-xc30.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=JDPVhseJ
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 91DCC809C0
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 06:53:40 +0000 (UTC)
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-6d68de53053so4928128eaf.0
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 22:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795676019; x=1796280819;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FofOUSAW3Eoqj2dlOXaHR0i8DLCt7yIzJ6ZGd0OUweQ=;
 b=JDPVhseJRKDCjeuZHqk+/mhQgHuO6u/9WMSY0Hg2sZVkyQMN1Bfznu9+I51lBMXboY
 mIPO0NznqGAp4JeAtBOcj9je26YVa1ntW2OmVV+OCETm0nuiklTK02HVHmRTW/qmK8E4
 Qkc+yMAwblT+HLc/EYBd0jYnHM69q4z4v16hvRKaN1HDQifliO53i2vgJsw24UlISGvj
 rUIp0McXA19DoG9cBHqbSuChvI6QsGkCtMV4ywRs/6HgOVu3E7iNIlCATlDdNoonynP5
 sthfnYpDDBEIyYeqcZ5acVHX6Hu62UX1R2k9v7SagPH2fEeN0hYTgWcATjX78f/8NWq+
 LDIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795676019; x=1796280819;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FofOUSAW3Eoqj2dlOXaHR0i8DLCt7yIzJ6ZGd0OUweQ=;
 b=fSraRSsTart6gf4fg8/LZVKN+m5eyt+H4aIwMveoq0RxadPJKJuEH2KHJohXGz0cFF
 ToJKoUq7wHPUmLi6GKaRTzK9Ichk3QH98C5dgE3DtGvWDw6IlWSfeHXtwbduN00lVAHw
 h6QbKFrhAqx1Zb3l9pInOZ2njSL2ycGA1TaelsCi3lvCTmRoAuz6EtzbjVjOu5enviHS
 YLpe7YiA6WV5PCLRATaQ6SJEGFzOZUP+IpFf7gBrcOB++xs2DV20g6qKc3Ouyzi1XcPy
 vw3g5vSkQAc1h/6e61SUmTRPJ/cDNKBmgpUyF7xRJQhwAxkfxAU9hMAkHTI/OqedE85k
 v2Dg==
X-Gm-Message-State: APuU4Z+iRx1u8ZR8SRle2TNvIKh0k9ZHLdeMNkGEcO8B+v777Tny68Yl
 L6QdctPSTSTXE5vKCi2hHP1tj7lzg8wNvDQBQvGvU0o78DwFQBzKNzjM
X-Gm-Gg: AZFdTZfTp7bbEjeGQNl5ziCm5ZqreGugLtv+LHrCumGMliYzXVU+4ip/lgmtBvjnzOW
 EJDN6VCGvkWqMm/HhMhW66PT6BTpEfK1YVNvTRdwEfTl/zv/yxgSeZpMYElb8ZndmgR2LZusc80
 b9DvOIjZ/6Dp5raVSNh2sH5q4YokevJQNHyewDnDi9q7wUXArVdhR0+0NGiBP0U7h4rhnUt+LZ1
 g497fhqN/B9virnn+377ZRx3342Rc+DvB64b0rPBS4R7Od2yPbV00lCK4wi49K2ERwnZOFP9OTT
 J/Op//+lYdMpTFdwDMgPJ4WzNPs+H/6sHSb9oty13Lm+Fw2kE8tQDq7j17wS3wa3iV1Gjaij34x
 8FE0ubr7akAfuEs0fbwv+fB6GU1/PSupnU062P8gn2nGZ6uEe88qap1VfJAZ7jIdyDVFvcAkw1E
 b/329yN5Wh0cwwUAoZPifhebZkiTObBRcF9DGQ5NZCk7Bi7mdTF8DiroX1TOF3sKwy9qfU+cQfc
 BOAc9Mr4HgRiHcy+YbY5DnxMUIT4fgSwlixD+fqhF4Mv1Rtnwg9kv03GXpE+2yOtNdHjuxPW98O
 YP6Kmk9zBx8aJ0O73TyNQhi+vHFbWlP19fAGzU9SSecqJ9tVUQ/F2Pljx7gca4UBOTo39E33j5o
 RpqPxHP1ROvaAKYXHUYwZP2iFalHCzj+iSWxkpDzoqumlOlJU0FArZDWPlr1TQwZTsSjuPXFY4E
 AL9TbHFJBs4uBzCkLu7OBMq+ShvDiKEk5hRDt6nLYuLbESCysE8fK5Nr2cQxoiOqcoXnX0ctq5
X-Received: by 2002:a05:6820:571c:10b0:6cd:3fdc:a932 with SMTP id
 006d021491bc7-71b3958daaamr11080872eaf.79.1795676019097; 
 Wed, 25 Nov 2026 22:53:39 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-86385358ca2sm31041a34.21.2026.11.25.22.53.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 22:53:38 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Wed, 25 Nov 2026 23:53:05 -0700
Subject: [PATCH 16/19] spl: net: load a boot image with lwIP
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261125-submit-lwip-network-boot-v1-v1-16-63df291d9392@gmail.com>
References: <20261125-submit-lwip-network-boot-v1-v1-0-63df291d9392@gmail.com>
In-Reply-To: <20261125-submit-lwip-network-boot-v1-v1-0-63df291d9392@gmail.com>
To: Jerome Forissier <jerome.forissier@arm.com>, 
 Heiko Stuebner <heiko@sntech.de>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Johan Jonker <jbx6244@gmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Piyush Paliwal <piyushthepal@gmail.com>, 
 Mateusz Furdyna <mateusz.furdyna@nokia.com>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, David Lechner <dlechner@baylibre.com>, 
 Michael Srba <Michael.Srba@seznam.cz>, Peng Fan <peng.fan@nxp.com>, 
 Carlo Caione <ccaione@baylibre.com>, Daniel Golle <daniel@makrotopia.org>, 
 Alexey Charkov <alchark@flipper.net>, Anton Ivanov <anton@binarly.io>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Petr Hodina <petr.hodina@protonmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Alessandro Rubini <rubini@gnudd.com>, 
 Mingtian Li <limingtian@email.szu.edu.cn>, 
 Romain Gantois <romain.gantois@bootlin.com>, kongchen <3305708832@qq.com>, 
 Anshul Dalal <anshuld@ti.com>, Andre Przywara <andre.przywara@arm.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Shahriyar Jalayeri <shahriyar@byteray.co.uk>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Aristo Chen <aristo.chen@canonical.com>, Heiko Schocher <hs@nabladev.com>, 
 Francesco Valla <francesco@valla.it>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.17-dev
X-Mailman-Approved-At: Thu, 26 Nov 2026 13:33:17 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Let Ethernet SPL boot use the same IPv4 address acquisition and TFTP
transfer as U-Boot proper. The loader needs a nonempty file in RAM:
leave the decision to boot it to SPL, regardless of the interactive
autoload and autostart settings.

Make the in-memory environment writable if the backend exposes only the
built-in defaults. DHCP and BOOTP need to publish the filename and
addresses for TFTP. Use the SPL vendor-class identifier and require a
reusable malloc pool for packet buffers.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 common/spl/Kconfig         | 10 ++++++++--
 common/spl/spl_net.c       | 13 ++++++++++++-
 include/net-lwip.h         |  1 +
 lib/Makefile               |  2 +-
 lib/lwip/u-boot/lwipopts.h | 14 +++++++-------
 net/Makefile               |  2 +-
 net/lwip/Makefile          |  5 +++++
 net/lwip/dhcp.c            | 28 ++++++++++++++++++++++------
 net/lwip/net-lwip.c        |  2 +-
 test/dm/lwip_dhcp.c        | 23 ++++++++++++++++++++---
 test/image/spl_load_net.c  | 43 +++++++++++++++++++++++++++++++++++--------
 11 files changed, 113 insertions(+), 30 deletions(-)

diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index 4930ecb0861..19b5d9f30f8 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -1177,7 +1177,10 @@ config SPL_DM_SPI_FLASH
 
 config SPL_NET
 	bool "Support networking"
-	depends on NET_LEGACY
+	depends on NET_LEGACY || NET_LWIP
+	depends on !NET_LWIP || (SPL_DM && SPL_LIBGENERIC_SUPPORT && SPL_ENV_SUPPORT)
+	depends on !NET_LWIP || (SPL_SYS_MALLOC && !SPL_SYS_MALLOC_SIMPLE)
+	depends on !NET_LWIP || (CMD_TFTPBOOT && (CMD_BOOTP || CMD_DHCP))
 	select SPL_USE_TINY_PRINTF_POINTER_SUPPORT if SPL_USE_TINY_PRINTF
 	help
 	  Enable support for network devices (such as Ethernet) in SPL.
@@ -1187,7 +1190,10 @@ config SPL_NET
 	  SPL_ETH.
 
 config SPL_NET_LEGACY
-	def_bool y if SPL_NET
+	def_bool SPL_NET && NET_LEGACY
+
+config SPL_NET_LWIP
+	def_bool SPL_NET && NET_LWIP
 
 config SPL_NET_VCI_STRING
 	string "BOOTP Vendor Class Identifier string sent by SPL"
diff --git a/common/spl/spl_net.c b/common/spl/spl_net.c
index 1cdb7027ef2..27c7170133b 100644
--- a/common/spl/spl_net.c
+++ b/common/spl/spl_net.c
@@ -13,8 +13,11 @@
 #include <spl.h>
 #include <spl_load.h>
 #include <net.h>
+#include <asm/global_data.h>
 #include <linux/libfdt.h>
 
+DECLARE_GLOBAL_DATA_PTR;
+
 #if defined(CONFIG_SPL_ETH) || defined(CONFIG_SPL_USB_ETHER)
 static ulong spl_net_load_read(struct spl_load_info *load, ulong sector,
 			       ulong count, void *buf)
@@ -39,7 +42,11 @@ static int spl_net_load_image(struct spl_image_info *spl_image,
 
 	env_init();
 	env_relocate();
-	env_set("autoload", "yes");
+	/* The nowhere backend leaves SPL's default environment read-only. */
+	if (CONFIG_IS_ENABLED(NET_LWIP) && !(gd->flags & GD_FLG_ENV_READY))
+		env_set_default(NULL, 0);
+	if (!CONFIG_IS_ENABLED(NET_LWIP))
+		env_set("autoload", "yes");
 	rv = eth_initialize();
 	if (rv == 0) {
 		printf("No Ethernet devices found\n");
@@ -47,7 +54,11 @@ static int spl_net_load_image(struct spl_image_info *spl_image,
 	}
 	if (bootdev->boot_device_name)
 		env_set("ethact", bootdev->boot_device_name);
+#if CONFIG_IS_ENABLED(NET_LWIP)
+	rv = net_lwip_load_bootfile();
+#else
 	rv = net_loop(BOOTP);
+#endif
 	if (rv < 0) {
 		printf("Problem booting with BOOTP\n");
 		return rv;
diff --git a/include/net-lwip.h b/include/net-lwip.h
index 8b64f32b913..65d6ab4af12 100644
--- a/include/net-lwip.h
+++ b/include/net-lwip.h
@@ -106,6 +106,7 @@ void net_lwip_dhcp6_poll(void);
 int net_lwip_ip6_prepare(struct net_lwip_ctx *ctx, ip_addr_t *dest);
 #endif
 int net_lwip_tftp_download(struct net_lwip_ctx *net, int argc, char *const argv[]);
+int net_lwip_load_bootfile(void);
 
 /**
  * wget_validate_uri() - varidate the uri
diff --git a/lib/Makefile b/lib/Makefile
index 925cb619807..9ce701075dc 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -104,7 +104,7 @@ obj-$(CONFIG_$(PHASE_)OF_REAL) += fdtdec_common.o fdtdec.o
 
 obj-$(CONFIG_$(PHASE_)MBEDTLS_LIB) += mbedtls/
 
-obj-$(CONFIG_NET_LWIP) += lwip/
+obj-$(CONFIG_$(PHASE_)NET_LWIP) += lwip/
 
 ifdef CONFIG_XPL_BUILD
 obj-$(CONFIG_SPL_YMODEM_SUPPORT) += crc16-ccitt.o
diff --git a/lib/lwip/u-boot/lwipopts.h b/lib/lwip/u-boot/lwipopts.h
index ab3b39a198f..5ce6b166f73 100644
--- a/lib/lwip/u-boot/lwipopts.h
+++ b/lib/lwip/u-boot/lwipopts.h
@@ -60,9 +60,9 @@
 #define NO_SYS                          1
 
 #define LWIP_IPV4			1
-#define LWIP_IPV6			IS_ENABLED(CONFIG_IPV6)
-#define LWIP_IPV6_SEND_ROUTER_SOLICIT	IS_ENABLED(CONFIG_IPV6_ROUTER_DISCOVERY)
-#define LWIP_IPV6_AUTOCONFIG		IS_ENABLED(CONFIG_IPV6_ROUTER_DISCOVERY)
+#define LWIP_IPV6			CONFIG_IS_ENABLED(IPV6)
+#define LWIP_IPV6_SEND_ROUTER_SOLICIT	CONFIG_IS_ENABLED(IPV6_ROUTER_DISCOVERY)
+#define LWIP_IPV6_AUTOCONFIG		CONFIG_IS_ENABLED(IPV6_ROUTER_DISCOVERY)
 #define LWIP_ND6_RDNSS_MAX_DNS_SERVERS	(IS_ENABLED(CONFIG_IPV6_ROUTER_DISCOVERY) && \
 					 IS_ENABLED(CONFIG_DNS) ? DNS_MAX_SERVERS : 0)
 /* A 64-bit reassembly pointer does not fit in the fragment header. */
@@ -113,13 +113,13 @@
 
 #define IP_DEFAULT_TTL                  255
 
-#if defined(CONFIG_PROT_ICMP_LWIP)
+#if CONFIG_IS_ENABLED(PROT_ICMP_LWIP)
 #define LWIP_ICMP                       1
 #else
 #define LWIP_ICMP                       0
 #endif
 
-#if defined(CONFIG_PROT_RAW_LWIP)
+#if CONFIG_IS_ENABLED(PROT_RAW_LWIP)
 #define LWIP_RAW                        1
 #else
 #define LWIP_RAW			0
@@ -211,7 +211,7 @@
 
 #define LWIP_IGMP                       0
 
-#if defined(CONFIG_PROT_DNS_LWIP)
+#if CONFIG_IS_ENABLED(PROT_DNS_LWIP)
 #define LWIP_DNS                        1
 #define DNS_TABLE_SIZE                  1
 #else
@@ -229,7 +229,7 @@
  * CONFIG_PROT_TCP_LWIP is not defined
  */
 #define TCP_MSS                         1460
-#if defined(CONFIG_PROT_TCP_LWIP)
+#if CONFIG_IS_ENABLED(PROT_TCP_LWIP)
 #define LWIP_TCP                        1
 #define TCP_WND                         CONFIG_LWIP_TCP_WND
 #define LWIP_WND_SCALE                  1
diff --git a/net/Makefile b/net/Makefile
index fb06ccdb38d..929b9ae9874 100644
--- a/net/Makefile
+++ b/net/Makefile
@@ -49,5 +49,5 @@ obj-$(CONFIG_CMD_WOL) += wol-common.o
 obj-y += net-common.o
 endif
 
-obj-$(CONFIG_NET_LWIP) += lwip/
+obj-$(CONFIG_$(PHASE_)NET_LWIP) += lwip/
 obj-$(CONFIG_NET_9P) += 9p/
diff --git a/net/lwip/Makefile b/net/lwip/Makefile
index ac17ebe87f2..539092190e4 100644
--- a/net/lwip/Makefile
+++ b/net/lwip/Makefile
@@ -1,9 +1,13 @@
 ccflags-y += -I$(srctree)/lib/lwip/lwip/src/include -I$(srctree)/lib/lwip/u-boot
 
 obj-$(CONFIG_$(PHASE_)DM_ETH) += net-lwip.o
+ifdef CONFIG_XPL_BUILD
+obj-$(CONFIG_$(PHASE_)NET_LWIP) += dhcp.o tftp.o
+else
 ifneq ($(filter y,$(CONFIG_CMD_BOOTP) $(CONFIG_CMD_DHCP)),)
 obj-y += dhcp.o
 endif
+
 obj-$(CONFIG_DNS) += dns.o
 obj-$(CONFIG_$(PHASE_)CMD_CDP) += cdp.o
 obj-$(CONFIG_CMD_DHCP6) += dhcp6.o
@@ -19,3 +23,4 @@ $(obj)/builtin_cacert.c: $(CONFIG_WGET_BUILTIN_CACERT_PATH:"%"=%) FORCE
 	$(call if_changed,bin2c,builtin_cacert)
 obj-y += builtin_cacert.o
 endif
+endif # !CONFIG_XPL_BUILD
diff --git a/net/lwip/dhcp.c b/net/lwip/dhcp.c
index b756199541b..a4b1d236f67 100644
--- a/net/lwip/dhcp.c
+++ b/net/lwip/dhcp.c
@@ -931,7 +931,7 @@ out:
 }
 
 static int bootp_run(struct cmd_tbl *cmdtp, int flag, int argc,
-		     char *const argv[], bool bootp)
+		     char *const argv[], bool bootp, bool download_only)
 {
 	struct net_lwip_ctx net = {};
 	struct dhcp_options *options;
@@ -964,7 +964,14 @@ static int bootp_run(struct cmd_tbl *cmdtp, int flag, int argc,
 		      sizeof(net_boot_file_name));
 
 	hostname = IS_ENABLED(CONFIG_BOOTP_SEND_HOSTNAME) ? env_get("hostname") : NULL;
-	vendor = env_get("bootp_vci") ?: CONFIG_BOOTP_VCI_STRING;
+	vendor = env_get("bootp_vci");
+	if (!vendor) {
+#ifdef CONFIG_SPL_BUILD
+		vendor = CONFIG_SPL_NET_VCI_STRING;
+#else
+		vendor = CONFIG_BOOTP_VCI_STRING;
+#endif
+	}
 	if ((hostname && strlen(hostname) > 255) || strlen(vendor) > 255) {
 		log_err("BOOTP/DHCP hostname/vendor class exceeds 255 bytes\n");
 		return CMD_RET_FAILURE;
@@ -1014,8 +1021,8 @@ static int bootp_run(struct cmd_tbl *cmdtp, int flag, int argc,
 		acquisition_timeout = ret == -ETIMEDOUT;
 		if (!ret) {
 			autoload = env_get("autoload");
-			if ((autoload && !strcmp(autoload, "NFS")) ||
-			    env_get_yesno("autoload") == 0)
+			if (!download_only && ((autoload && !strcmp(autoload, "NFS")) ||
+					       env_get_yesno("autoload") == 0))
 				break;
 			if (!IS_ENABLED(CONFIG_CMD_TFTPBOOT)) {
 				log_err("Cannot autoload with TFTP: command is disabled\n");
@@ -1056,6 +1063,8 @@ static int bootp_run(struct cmd_tbl *cmdtp, int flag, int argc,
 
 	if (ret)
 		return CMD_RET_FAILURE;
+	if (IS_ENABLED(CONFIG_SPL_BUILD) || download_only)
+		return downloaded && net_boot_file_size ? CMD_RET_SUCCESS : CMD_RET_FAILURE;
 	if (!downloaded) {
 		autoload = env_get("autoload");
 		if (!autoload || strcmp(autoload, "NFS"))
@@ -1073,10 +1082,17 @@ static int bootp_run(struct cmd_tbl *cmdtp, int flag, int argc,
 
 int do_dhcp(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
-	return bootp_run(cmdtp, flag, argc, argv, false);
+	return bootp_run(cmdtp, flag, argc, argv, false, IS_ENABLED(CONFIG_SPL_BUILD));
 }
 
 int do_bootp(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
-	return bootp_run(cmdtp, flag, argc, argv, true);
+	return bootp_run(cmdtp, flag, argc, argv, true, IS_ENABLED(CONFIG_SPL_BUILD));
+}
+
+int net_lwip_load_bootfile(void)
+{
+	char *const argv[] = { "bootp", NULL };
+
+	return bootp_run(NULL, 0, 1, argv, !IS_ENABLED(CONFIG_CMD_DHCP), true) ? -EIO : 0;
 }
diff --git a/net/lwip/net-lwip.c b/net/lwip/net-lwip.c
index 3a9a5a42716..075d5b1716f 100644
--- a/net/lwip/net-lwip.c
+++ b/net/lwip/net-lwip.c
@@ -1126,7 +1126,7 @@ static int net_lwip_rx(struct udevice *udev, struct netif *netif)
 			if (!net_lwip_accept_vlan(packet, len))
 				goto release;
 
-			if (IS_ENABLED(CONFIG_CMD_WOL))
+			if (CONFIG_IS_ENABLED(CMD_WOL))
 				net_lwip_wol_receive(netif, packet, len);
 
 			pbuf = alloc_pbuf_and_copy(packet, len);
diff --git a/test/dm/lwip_dhcp.c b/test/dm/lwip_dhcp.c
index d7e1360d2de..f6af57a3647 100644
--- a/test/dm/lwip_dhcp.c
+++ b/test/dm/lwip_dhcp.c
@@ -19,6 +19,7 @@
 struct dhcp_handoff_test {
 	const char *offer;
 	bool fail;
+	bool empty;
 	bool timeout;
 	bool dhcp_alive;
 	bool rx_burst;
@@ -123,6 +124,7 @@ static int dhcp_handoff_tx(struct udevice *dev, void *packet, unsigned int len)
 	struct dhcp_handoff_test *test = priv->priv;
 	struct ethernet_hdr *eth = packet, *reply_eth;
 	struct ip_udp_hdr *ip, *reply_ip;
+	unsigned int tftp_len = test->empty ? 4 : 6;
 	u8 *data;
 
 	if (test->rx_burst && netif_dhcp_data(netif_default) &&
@@ -167,14 +169,14 @@ static int dhcp_handoff_tx(struct udevice *dev, void *packet, unsigned int len)
 	reply_ip = (void *)(reply_eth + 1);
 	memset(reply_ip, 0, IP_UDP_HDR_SIZE);
 	reply_ip->ip_hl_v = 0x45;
-	reply_ip->ip_len = htons(IP_UDP_HDR_SIZE + 6);
+	reply_ip->ip_len = htons(IP_UDP_HDR_SIZE + tftp_len);
 	reply_ip->ip_ttl = 64;
 	reply_ip->ip_p = IPPROTO_UDP;
 	reply_ip->ip_src = ip->ip_dst;
 	reply_ip->ip_dst = ip->ip_src;
 	reply_ip->udp_src = htons(1234);
 	reply_ip->udp_dst = ip->udp_src;
-	reply_ip->udp_len = htons(UDP_HDR_SIZE + 6);
+	reply_ip->udp_len = htons(UDP_HDR_SIZE + tftp_len);
 	reply_ip->ip_sum = compute_ip_checksum(reply_ip, IP_HDR_SIZE);
 	data = (void *)(reply_ip + 1);
 	put_unaligned_be16(test->fail ? 5 : 3, data);
@@ -187,7 +189,7 @@ static int dhcp_handoff_tx(struct udevice *dev, void *packet, unsigned int len)
 	data[4] = 'x';
 	data[5] = 0;
 	priv->recv_packet_length[priv->recv_packets++] =
-		ETHER_HDR_SIZE + IP_UDP_HDR_SIZE + 6;
+		ETHER_HDR_SIZE + IP_UDP_HDR_SIZE + tftp_len;
 
 	return 0;
 }
@@ -289,6 +291,21 @@ static int dhcp_handoff_check(struct unit_test_state *uts,
 	ut_assertok(env_set("nfsserverip", NULL));
 	ut_assertok(env_set("tftpdstp", NULL));
 	ut_assertok(env_set("tftpsrcp", NULL));
+	if (IS_ENABLED(CONFIG_CMD_TFTPBOOT)) {
+		*test = (struct dhcp_handoff_test){ .offer = "u-boot.img" };
+		ut_assertok(env_set("autoload", "NFS"));
+		ut_assertok(env_set("autostart", "yes"));
+		ut_assertok(net_lwip_load_bootfile());
+		ut_asserteq(1, test->tftp);
+		ut_asserteq(0, test->nfs);
+		ut_asserteq(2, net_boot_file_size);
+		ut_asserteq_str("u-boot.img", test->filename);
+		ut_assertnull(netif_default);
+		test->empty = true;
+		ut_asserteq(-EIO, net_lwip_load_bootfile());
+		ut_asserteq(0, net_boot_file_size);
+		ut_assertok(env_set("autostart", "no"));
+	}
 	ut_assertok(dhcp_autoload_retries(uts, test));
 	for (i = 0; i < 4; i++) {
 		*test = (struct dhcp_handoff_test){ .offer = "offered.bin" };
diff --git a/test/image/spl_load_net.c b/test/image/spl_load_net.c
index 4af6e21b8b9..0030dd52459 100644
--- a/test/image/spl_load_net.c
+++ b/test/image/spl_load_net.c
@@ -4,11 +4,15 @@
  */
 
 #include <dm.h>
+#include <env.h>
 #include <spl.h>
 #include <test/spl.h>
 #include <asm/eth.h>
 #include <test/ut.h>
 #include "../../net/bootp.h"
+#if CONFIG_IS_ENABLED(NET_LWIP)
+#include <lwip/prot/dhcp.h>
+#endif
 
 /*
  * sandbox_eth_bootp_req_to_reply()
@@ -55,17 +59,34 @@ static int sandbox_eth_bootp_req_to_reply(struct udevice *dev, void *packet,
 	memcpy(eth_recv->et_src, priv->fake_host_hwaddr, ARP_HLEN);
 	ipr->ip_sum = 0;
 	ipr->ip_off = 0;
-	net_write_ip(&ipr->ip_dst, net_ip);
-	net_write_ip(&ipr->ip_src, priv->fake_host_ipaddr);
+	ipr->ip_dst.s_addr = htonl(0xffffffff);
+	ipr->ip_src = priv->fake_host_ipaddr;
 	ipr->ip_sum = compute_ip_checksum(ipr, IP_HDR_SIZE);
 	ipr->udp_src = ip->udp_dst;
 	ipr->udp_dst = ip->udp_src;
+	ipr->udp_xsum = 0;
 
 	bpr->bp_op = OP_BOOTREPLY;
-	net_write_ip(&bpr->bp_yiaddr, net_ip);
-	net_write_ip(&bpr->bp_siaddr, priv->fake_host_ipaddr);
-	copy_filename(bpr->bp_file, CONFIG_BOOTFILE, sizeof(CONFIG_BOOTFILE));
+	bpr->bp_yiaddr = net_ip;
+	bpr->bp_siaddr = priv->fake_host_ipaddr;
+	copy_filename(bpr->bp_file, CONFIG_BOOTFILE, sizeof(bpr->bp_file));
 	memset(&bpr->bp_vend, 0, sizeof(bpr->bp_vend));
+#if CONFIG_IS_ENABLED(NET_LWIP)
+	if (IS_ENABLED(CONFIG_CMD_DHCP)) {
+		/* lwIP sends the DHCP message type as its first option. */
+		u8 *options = (u8 *)bpr->bp_vend;
+		u8 type = bp->bp_vend[6];
+
+		if (type != DHCP_DISCOVER && type != DHCP_REQUEST)
+			return -EAGAIN;
+		memcpy(options, bp->bp_vend, 6);
+		options[6] = type == DHCP_DISCOVER ? DHCP_OFFER : DHCP_ACK;
+		options[7] = DHCP_OPTION_SERVER_ID;
+		options[8] = 4;
+		memcpy(options + 9, &priv->fake_host_ipaddr, 4);
+		options[13] = DHCP_OPTION_END;
+	}
+#endif
 
 	priv->recv_packet_length[priv->recv_packets] = len;
 	++priv->recv_packets;
@@ -171,8 +192,8 @@ static int sandbox_eth_tftp_req_to_reply(struct udevice *dev, void *packet,
 	ipr->ip_ttl = 255;
 	ipr->ip_p = IPPROTO_UDP;
 	ipr->ip_sum = 0;
-	net_copy_ip(&ipr->ip_dst, &ip->ip_src);
-	net_copy_ip(&ipr->ip_src, &ip->ip_dst);
+	ipr->ip_dst = ip->ip_src;
+	ipr->ip_src = ip->ip_dst;
 	ipr->ip_sum = compute_ip_checksum(ipr, IP_HDR_SIZE);
 
 	ipr->udp_src = htons(TFTP_TID);
@@ -234,7 +255,13 @@ static int spl_test_net(struct unit_test_state *uts, const char *test_name,
 	struct udevice *dev;
 	int ret;
 
-	net_server_ip = string_to_ip("1.1.2.4");
+	if (CONFIG_IS_ENABLED(NET_LWIP) && IS_ENABLED(CONFIG_BOOTP_SERVERIP)) {
+		/* This configuration takes the TFTP server from the environment. */
+		env_set_default(NULL, 0);
+		ut_assertok(env_set("serverip", "1.1.2.4"));
+	} else {
+		net_set_server_ip(string_to_ip("1.1.2.4"));
+	}
 	ret = do_spl_test_load(uts, test_name, type,
 			       SPL_LOAD_IMAGE_GET(0, BOOT_DEVICE_CPGMAC,
 						  spl_net_load_image_cpgmac),

-- 
2.53.0

