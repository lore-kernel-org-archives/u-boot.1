Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ED14C61DE2
	for <u-boot@archiver.kernel.org>; Sun, 30 Aug 2026 08:44:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A71CC60638;
	Sun, 30 Aug 2026 08:44:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vx71unFTgtrk; Sun, 30 Aug 2026 08:44:12 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788079452;
	bh=28uNolks8Q6RWBVASHe1jspRuE+OGT2tW1ms8K1UzWI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BktnwRgZZ4kuKiyGh153ZXanfO1425LUO9U0lp35XO4vfL3+MVwk4mH9MGtmmBL0v
	 qP+0w4q0FaAYc5nZ3T9HCJLnJycLB5cIhKvfGEPaScy0wLFuvke59Wkrpt87a3Clzl
	 55UF6Dq2s/BLoRkmm0xrKEV2umIxewuyF5xX08RxCyKa4BRR6mjy7RNrii2t103zTt
	 RPhZ70Z81wC3h9ywavbUw8mWLShd4tgw1wKZAJg+MKpRImk5mPS/2aNeeBid+E04Fc
	 IS8UVFRLgCIk69hI9SldaudVYGlHLXSw6tmhOobPTquwA5+h7ryoe9pVbxT5YIwnK6
	 NgE7EzaJ+axgQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B3B806061D;
	Sun, 30 Aug 2026 08:44:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4C80E3DA
 for <u-boot@lists.u-boot-project.org>; Sun, 30 Aug 2026 08:44:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 32D1F400BB
 for <u-boot@lists.u-boot-project.org>; Sun, 30 Aug 2026 08:44:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5cn1XoMtSE9q for <u-boot@lists.u-boot-project.org>;
 Sun, 30 Aug 2026 08:44:08 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.120;
 helo=smtp-relay-canonical-0.canonical.com;
 envelope-from=heinrich.schuchardt@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=H0csRP/d
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0E75940050
 for <u-boot@lists.u-boot-project.org>; Sun, 30 Aug 2026 08:44:07 +0000 (UTC)
Received: from LT03.fritz.box (ip-084-119-040-110.um24.pools.vodafone-ip.de
 [84.119.40.110])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 4CCC4430A0; 
 Sun, 30 Aug 2026 08:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1788079445;
 bh=28uNolks8Q6RWBVASHe1jspRuE+OGT2tW1ms8K1UzWI=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=H0csRP/dRpqDD4KqFVyTiVGbj7czlnthfG2TToXIg8k7fW8bKIaKLtY4uz8/2J+Yz
 clmMm6vrI/UmaqZIAdEWWAd3nGbXrq8a3Lq4aY1np5rtRjQdKtcsVLF/CGsutuyYOR
 YznEGw+1qUThVP+AHb+dAxYrWhwV9srp9/oflc+UrMLEl9njPjNGcMgy7SA06BZr1L
 xqOkLwcju+8116rWVGP9fGySQuSOqBL6W1o5mSGRMVhIAb9bGWqNLvRTR9bC/GQC35
 Gv/sGplpjF9t2K4dQXKNAZX7XtQ5uZLD8zEjNv0bG++XHs6VjSVjyckQhjCSBPZ9vy
 8y7/Yr3g+Fd6ztUvaBw8J6z+VX1vt7SfTbo2tZSMh4W+JNlVFcPPt57FE1QJuUJLLW
 MWgSw4Z/EWIxvUe88+5izbieqnbC/Qnpdm99Hj0vEmTqfPNYOLm5VvhWHrAbOTHZkR
 UeQqJvbE8LTP4YAjril7mo+h24h9HHktjtrM21/L7WjcsncX94ZpcMiD74YisZFdop
 Zke9veatT+PcUqvBZ3Gwtbl+EJ4viLrEVdQ5mhW6gvBU1Bub3/K/CTh1wwK7qdEqLc
 sJKwiIj8JSjTTEBseY7Ly55pnIFccv3M38PQS2hwJami/Lyka+JWaTiU9MKEzauy1+
 0hIWm+McyY8oQNH3lc7K1Fbg=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Denis Mukhin <dmukhin@ford.com>,
 u-boot@lists.u-boot-project.org,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 1/2] efi_loader: remove debug in platform_get_rng_device
Date: Sun, 30 Aug 2026 10:43:59 +0200
Message-ID: <20260830084400.250238-2-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260830084400.250238-1-heinrich.schuchardt@canonical.com>
References: <20260830084400.250238-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

All callers already write messages.

* In efi_rng_register we have a log_warning().
* In get_rng() we have an EFI_PRINT() statement.

These different message types are adequate as get_rng() runs inside the API
and efi_rng_register() runs on the U-Boot cli level.

Remove the duplicate debug message in platform_get_rng_device()

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v2:
	remove the message instead of replacing it
---
 lib/efi_loader/efi_rng.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/lib/efi_loader/efi_rng.c b/lib/efi_loader/efi_rng.c
index 7810b4e47ea..e920eec9d7b 100644
--- a/lib/efi_loader/efi_rng.c
+++ b/lib/efi_loader/efi_rng.c
@@ -30,10 +30,8 @@ __weak efi_status_t platform_get_rng_device(struct udevice **dev)
 	struct udevice *devp;
 
 	ret = uclass_get_device(UCLASS_RNG, 0, &devp);
-	if (ret) {
-		debug("Unable to get rng device\n");
+	if (ret)
 		return EFI_DEVICE_ERROR;
-	}
 
 	*dev = devp;
 
-- 
2.53.0

