Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D5E3D5D693
	for <u-boot@archiver.kernel.org>; Thu,  7 Nov 2024 21:53:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D03E088DB6;
	Thu,  7 Nov 2024 22:53:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.b="tPgBaSJK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="t2ScEpqD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC07D89246; Thu,  7 Nov 2024 16:01:19 +0100 (CET)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC5ED89293
 for <u-boot@lists.denx.de>; Thu,  7 Nov 2024 16:01:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=namcao@linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1730991677;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lkugnngs4hy2THmLYjCUdSsijCIQW5weUplOaJdqlYQ=;
 b=tPgBaSJKouoKd9E44Q0o1vPEeDXX52EkEJtAxSFrGgvvgT6iJAPRTYB+uddon5m94/9Pha
 aZBo4fyOsghR90DJLDhudAqr54ho0uUI44qkNjJ1TeQTs/gtu1F0WdGsIGVK1l8Izu3g1c
 0ZNM4E/rcquVUpCwe8Pl48dl9TYu17B/VmKuwFVimC7WyiYlmnkJjQTocUDNhJY8IzLZuE
 ZmfBv4/Z18NzYjW5HyamY5QpXMCwpBAk7K3J+vV2S/1BqWMduuFQo8NF32NRbpvzFSPZqq
 DsLrV7gfFicDGYyI4TgUjpeD+GlBq6AQXorC7JYYQN59VdbcldCaQ2RrwuP1RQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1730991677;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lkugnngs4hy2THmLYjCUdSsijCIQW5weUplOaJdqlYQ=;
 b=t2ScEpqDre9xPW8Iu/N5s/ajZe/1AgyAV0ylbk2eBDwXDAHLWafs6Sa3yD8D+N//j95XTN
 KkLmLCX5YP/VqtDA==
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Ion Agorria <ion@agorria.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Nam Cao <namcao@linutronix.de>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Sean Anderson <seanga2@gmail.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Javier Fernandez Pastrana <javier.pastrana@linutronix.de>,
 u-boot@lists.denx.de
Subject: [PATCH v2 1/2] boot: extlinux: Fix unaligned buffer for reading data
 from file system
Date: Thu,  7 Nov 2024 16:01:05 +0100
Message-Id: <1eb402380414c2b8f1b25d0c63d894efefce4ab9.1730988601.git.namcao@linutronix.de>
In-Reply-To: <cover.1730988601.git.namcao@linutronix.de>
References: <cover.1730988601.git.namcao@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 07 Nov 2024 22:53:17 +0100
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

extlinux_read_bootflow() allocates a buffer to read from file system
without any alignment.

But for some block devices which transfer data via DMA, ARCH_DMA_MINALIGN
alignment is required. For example, due to misaligned buffer, the below
boot failure is observed.

=3D> boot
CACHE: Misaligned operation at range [9efa25f8, 9efa27f8]
CACHE: Misaligned operation at range [9efa25f8, 9efa27f8]
CACHE: Misaligned operation at range [9efa25f8, 9efa27f8]
CACHE: Misaligned operation at range [9efa25f8, 9efa27f8]
** Booting bootflow 'mmc@2194000.bootdev.part_1' with extlinux
Ignoring unknown command: =EF=BF=BDD=EF=BF=BD=EF=BF=BD=EF=BF=BDD=EF=BF=BD=
=EF=BF=BD
Boot failed (err=3D-14)

Change the buffer alignment to ARCH_DMA_MINALIGN.

Fixes: 31aefaf89a5b ("bootstd: Add an implementation of distro boot")
Signed-off-by: Nam Cao <namcao@linutronix.de>
Tested-by: Javier Fernandez Pastrana <javier.pastrana@linutronix.de>
---
v2:
  - use ARCH_DMA_MINALIGN to be consistent with bootmeth_script [Simon]

 boot/bootmeth_extlinux.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/boot/bootmeth_extlinux.c b/boot/bootmeth_extlinux.c
index ae0ad1d53e3..ac046705033 100644
--- a/boot/bootmeth_extlinux.c
+++ b/boot/bootmeth_extlinux.c
@@ -8,6 +8,7 @@
=20
 #define LOG_CATEGORY UCLASS_BOOTSTD
=20
+#include <asm/cache.h>
 #include <common.h>
 #include <bootdev.h>
 #include <bootflow.h>
@@ -127,7 +128,7 @@ static int extlinux_read_bootflow(struct udevice *dev, =
struct bootflow *bflow)
 		return log_msg_ret("try", ret);
 	size =3D bflow->size;
=20
-	ret =3D bootmeth_alloc_file(bflow, 0x10000, 1);
+	ret =3D bootmeth_alloc_file(bflow, 0x10000, ARCH_DMA_MINALIGN);
 	if (ret)
 		return log_msg_ret("read", ret);
=20
--=20
2.39.5

