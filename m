Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED953C47258
	for <u-boot@archiver.kernel.org>; Wed, 31 Jan 2024 13:34:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8C0387C44;
	Wed, 31 Jan 2024 14:34:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="X4Vrx9gS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08FBC87B5D; Wed, 31 Jan 2024 14:34:01 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B01987BDD
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 14:33:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id F147261764;
 Wed, 31 Jan 2024 13:33:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD2ACC433F1;
 Wed, 31 Jan 2024 13:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1706708037;
 bh=CWp2kefyq0Em3dBA8+mzl6N3f8UZ10L6fS1ed3Ke5B0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=X4Vrx9gSlhzjEH45cTxrWNTaVMxUkkWqu/a7O4EyzmLDF2JIUwmLmconH2/sJWqq9
 UW2SbcR/4ccBjcmeu3E5FZPeiy/GGLcpf1xNL7IJkpCKo2mbUvxV1Twy2VJZKDGEmW
 42WMmIKYzY6PYQSToGBCZ15KIPEMX0T6SzoeH63QI6M+/jp+a1wXtFBrLbGjZrs45L
 5VUBGQUXQ0IgQt+YxcdxbLRKvSyHx2GqlJiOoesQMNntcdw+TRXzhO1Ld0s9XJ86ap
 UXXSqx0FebBNalbb3zdoe5iYzKK/3kW+4gVC9/SnGsNdpyQ/WXk2A7xphlJqxqBRoc
 gmvYCdC6Y9Fdg==
From: Roger Quadros <rogerq@kernel.org>
To: trini@konsulko.com,
	nm@ti.com
Cc: vigneshr@ti.com, s-vadapalli@ti.com, srk@ti.com, r-gunasekaran@ti.com,
 u-boot@lists.denx.de, Roger Quadros <rogerq@kernel.org>
Subject: [PATCH 1/3] mux: autoprobe if "idle-states" present in device tree
Date: Wed, 31 Jan 2024 15:33:46 +0200
Message-Id: <20240131133348.182987-2-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240131133348.182987-1-rogerq@kernel.org>
References: <20240131133348.182987-1-rogerq@kernel.org>
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

Some platforms need the MUX state to be auto initialized at
boot time even if there are no explicit users for the MUX.
In these cases, the MUX device tree has "idle-states" property
which specifies what state the MUX should be initialized to.

So far we were relying on custom u-boot property "u-boot,mux-autoprobe"
to autoprobe such MUXes. This patch causes the MUX to autoprobe
if it has "idle-states" property in device tree.

This should allow us to stop using the custom "u-boot,mux-autoprobe"
property.

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 drivers/mux/mux-uclass.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mux/mux-uclass.c b/drivers/mux/mux-uclass.c
index c98576ceb8..8833888ded 100644
--- a/drivers/mux/mux-uclass.c
+++ b/drivers/mux/mux-uclass.c
@@ -318,7 +318,8 @@ int dm_mux_init(void)
 		return ret;
 	}
 	uclass_foreach_dev(dev, uc) {
-		if (dev_read_bool(dev, "u-boot,mux-autoprobe")) {
+		if (dev_read_bool(dev, "u-boot,mux-autoprobe") ||
+		    dev_read_bool(dev, "idle-states")) {
 			ret = device_probe(dev);
 			if (ret)
 				log_debug("unable to probe device %s\n",
-- 
2.34.1

