Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB61CC25B75
	for <u-boot@archiver.kernel.org>; Sun, 19 May 2024 12:58:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43E13886BA;
	Sun, 19 May 2024 14:57:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="LB7vd9rQ";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="SMOnUK8b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 094D8886B8; Sun, 19 May 2024 14:57:35 +0200 (CEST)
Received: from wfout6-smtp.messagingengine.com
 (wfout6-smtp.messagingengine.com [64.147.123.149])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9771886A7
 for <u-boot@lists.denx.de>; Sun, 19 May 2024 14:57:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailfout.west.internal (Postfix) with ESMTP id 38F981C000FB;
 Sun, 19 May 2024 08:57:30 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute5.internal (MEProxy); Sun, 19 May 2024 08:57:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1716123449;
 x=1716209849; bh=1Y+94ryjA/ZvNo99fCelahC2vqRokB1doMn3Rh9ABRY=; b=
 LB7vd9rQR2/qisl4DQVigO5PnmlBHt3pwQDacdpXuxLDQvuVB1FXa9BHKCOljL4c
 BhI8Hdp6MnRgWvTS7DLa6274mYeM7CnXqNhc10TxQuzuLCA9sxPl1EzYuSyvdKKK
 Uh6rhZ/DpppyzEyrgC+qXtWfTdfv2FVMndg9lUxbM9faBTmKAQabTiGMi5Kf36cD
 EJ9+I1YJHqKRqaeD/0hqCHGkJlI2CjYFWzD7HGME9LDQvNU2HxiDJGq+SKLrxPgG
 ZxdOfBeG9EjeLZXsnq043OPsFejML0cUoqzd2ax+fR1ZAycSzdZVgLDfuKjDREcN
 Txo9g5PEH65sBmp70jeoTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1716123449; x=
 1716209849; bh=1Y+94ryjA/ZvNo99fCelahC2vqRokB1doMn3Rh9ABRY=; b=S
 MOnUK8bCrouyjFBCL/dL2QyvUjiPdyY89yFIZwcNvNngiXM7ZZlgD2LTX7DF1ue8
 UtXc4dseqTtDhh/x1ZYwsSgPGCPrpfHKkPUTIPZn8YATFwAxqgg5dwlddiOYBM0W
 +0hD8joFjVw2O4iucIhOZDT+2daC51HTWRWoGI1iqDx674mZ3wneWPqyEl2IXpB1
 ojWK3NLXBKDFsWUnL+0ilqHYlL5RW136fS/12EIjH/JjcirlUA1V8brdxJFFXWwi
 YsltMzA36l4lU04UdnBicymYJ+bsi2Vb6/1f9YkaYOKmMKQIinsC/tdekzhZx4nP
 x90ucWULCOLU1z1dNkCmw==
X-ME-Sender: <xms:OfdJZiTipPz1cZZymUbRh9XqRQmJu2LEMVvv8BJ5gWNAcTzJth-Ixw>
 <xme:OfdJZny9hq6fTySWUoc7U3-XcIjWUKzCvrPEBunKgxCmLcyN743JxieMFRtbEQIPA
 RDejwpGAw8IrT54F8s>
X-ME-Received: <xmr:OfdJZv1tTIt4US0tIgIH95C-DPI2_xecD1uYRlWSxt-Jbdm5QqcD_S0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehkedgheeiucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
 gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
 cuggftrfgrthhtvghrnhepvdekiefhfeevkeeuveetfeelffekgedugefhtdduudeghfeu
 veegffegudekjeelnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilh
 hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:OfdJZuCOewqXebnQqynCyJhkShbXOwjxCPbnYtSdqf3lWWHy-VXqqQ>
 <xmx:OfdJZrjZvKuCHZ78bw4mCCFmh5x3Pej3D3JOwwtHNLgGXhsQFlzG6g>
 <xmx:OfdJZqqfipHad6ZLgoQJB2FicF4eBSoGSnsl_luQH6DQB00grrBwWw>
 <xmx:OfdJZuhIzpLgbOdT0LZJhsnCjBpZy3hlNe77pKl8efdzpu8iiVpVEQ>
 <xmx:OfdJZqW0ljdyN9wXPNrK8jKhOmZ3AGAXk3Np5MdzqAcOlPX1TyIcMiKq>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 19 May 2024 08:57:27 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Sun, 19 May 2024 13:56:55 +0100
Subject: [PATCH 10/13] lib/crc32: Don't perform byte swap for arm64 crc32b
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240519-aarch64-be-v1-10-75cc328eddfa@flygoat.com>
References: <20240519-aarch64-be-v1-0-75cc328eddfa@flygoat.com>
In-Reply-To: <20240519-aarch64-be-v1-0-75cc328eddfa@flygoat.com>
To: u-boot@lists.denx.de, uboot-snps-arc@synopsys.com
Cc: Tom Rini <trini@konsulko.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Ezequiel Garcia <ezequiel@collabora.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 Lars Povlsen <lars.povlsen@microchip.com>, 
 Horatiu Vultur <horatiu.vultur@microchip.com>, 
 Alexey Brodkin <alexey.brodkin@synopsys.com>, 
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=799;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=jHS/fiImHrkBoZxjfdR2NxF49dzJ5rVugNeqhV7Hwx4=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhjTP7wKS812/1vyRfqz5c+56F5fyFDXGKJ+VvIdnBHc/n
 sKXfL+/o5SFQYyLQVZMkSVEQKlvQ+PFBdcfZP2BmcPKBDKEgYtTACYycRYjw++ffpFBdzXeb+K+
 KMwg+0jmWqP28qIXHps/sX1NfBO+IZrhf3TiP9kF50oDrdVk1HuPXtKfGNhgHWM8bSPblonqv1d
 X8wEA
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
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

crc32b always calculate results in CPU's native endian,
so there is no need to perform any endian swap.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 lib/crc32.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/lib/crc32.c b/lib/crc32.c
index f36f1763064f..b991e477b31d 100644
--- a/lib/crc32.c
+++ b/lib/crc32.c
@@ -183,10 +183,9 @@ const uint32_t * ZEXPORT get_crc_table()
 uint32_t __efi_runtime crc32_no_comp(uint32_t crc, const Bytef *buf, uInt len)
 {
 #ifdef CONFIG_ARM64_CRC32
-    crc = cpu_to_le32(crc);
     while (len--)
         crc = __builtin_aarch64_crc32b(crc, *buf++);
-    return le32_to_cpu(crc);
+    return crc;
 #else
     const uint32_t *tab = crc_table;
     const uint32_t *b =(const uint32_t *)buf;

-- 
2.43.0

