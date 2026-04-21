Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA733F5A8CA
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 00:05:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64A51842E1;
	Tue, 21 Apr 2026 02:05:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=traverse.com.au
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=traverse.com.au header.i=@traverse.com.au header.b="O7pMXmjw";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="co2xZc95";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 894E1842E7; Tue, 21 Apr 2026 02:05:09 +0200 (CEST)
Received: from fout-b2-smtp.messagingengine.com
 (fout-b2-smtp.messagingengine.com [202.12.124.145])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A36C3842CD
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 02:05:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=traverse.com.au
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=matt@traverse.com.au
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfout.stl.internal (Postfix) with ESMTP id 4C9861D0027E;
 Mon, 20 Apr 2026 20:05:00 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Mon, 20 Apr 2026 20:05:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=traverse.com.au;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm1;
 t=1776729900; x=1776816300; bh=63Z3pjhwo1U/VqZ70EwM4KkAzNUT4M4f
 Swdgo3jWMxI=; b=O7pMXmjw9xKu8PKQTgnNt2bIOsD3XcBeZAgX5nBK5SI5Ghmq
 F+NBtt3PvB/ZO0GX3LD2mcSrGLDe/DmXc/p4PlK9uEU+7KirnkMCju4d8ounTniz
 lZj1GNfgUKhw1vu3GHr8HM1h9fICgC3D+pOTI7eoSubAvYr07j7dvfdSb7nnW0k8
 X/kGWTdjV8bLwZKVz6hhMtp1vL/70eL7YktOpFDske33hIsxwEVx15XuBta+iiA8
 wIIPHOb1JnejRtWS1smqeghs4yu8iiuCDMp4WfcMifzucbzY9nWkS/k6ELT/Pwbw
 ZBrfn4PkoCxvnHeyyogOLm+1UCENwNCZL3J9vQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776729900; x=
 1776816300; bh=63Z3pjhwo1U/VqZ70EwM4KkAzNUT4M4fSwdgo3jWMxI=; b=c
 o2xZc95pdfKk2I1LmcxkwdGOFxP8dp0ui92OFckvhLc+A9D/WUnpMyooJOT2Fgr1
 +PsYkI3x7c9JGU9pg+432c82IzE/E2Y7zH6KORofTS2KOGqwAh8Z88uEyqqMsSl8
 eSqVq75AS578GOPXcKumb9jupgfi1VHmasygsc3AanLYO+ha9uvdN1AZ6owYQEI0
 doyTr7Q2csZ6EcVboNr0K4mb9vb79laPPzLZR8CeE1sWP0CoMz1WjAyFxnwJ9NBh
 EEum9lQpMaLicLrDiLdrf67UG0rxb9lTRjW1mMdefpcTO6YofdCoXM4HYiT7ixwk
 PitkFa+sFRtH3GqXSoAxw==
X-ME-Sender: <xms:LL_maQ3KFqm7Kb5bTXLY-ENZh1qXOMOx95fgkEyt6nqT8m9bqLhNhg>
 <xme:LL_maQBrxA_W9_7TmzTJoSpML2p1j13_0aXzsrNi__M2XK2dpboz3XzOrImXM2RuL
 nGE1tniF5r8hYC9gLEiMWZf99hLDDX4B_HVoc2kPxh7Bh8wrvQdbg>
X-ME-Received: <xmr:LL_madK-Q1RM7HcEgnBmoSPfjUX-Wtb6KrOQ39I7EUCRCc6-Xb0k2kNB0AchxDwNumoly2s0Ut9Ut9IEw_qTyx-Dg9FoatCwj6h5ZflD-TMu6Io1kVc-vfeJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdehleeludcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomhepofgrthhhvgif
 ucfotgeurhhiuggvuceomhgrthhtsehtrhgrvhgvrhhsvgdrtghomhdrrghuqeenucggtf
 frrghtthgvrhhnpeffvddthfeklefffffgjeekfeetueehhfeigfffgfekudeujeehffet
 ffeltefgheenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehmrghtthesthhrrghvvghrshgvrdgtohhmrdgruhdpnhgspghrtghpthhtohepledp
 mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgrughmrghrrghordgsvghgrghrih
 esrghmugdrtghomhdprhgtphhtthhopehquhgvnhhtihhnrdhstghhuhhliiestghhvghr
 rhihrdguvgdprhgtphhtthhopehmihgthhgrlhdrshhimhgvkhesrghmugdrtghomhdprh
 gtphhtthhopehmrghrvghkrdhvrghsuhhtsehmrghilhgsohigrdhorhhgpdhrtghpthht
 ohepuhdqsghoohhtsehlihhsthhsrdguvghngidruggvpdhrtghpthhtohepphgvnhhgrd
 hfrghnsehngihprdgtohhmpdhrtghpthhtoheplhhukhgrshiirdgtiigvtghhohifshhk
 ihesthhhrghumhgrthgvtgdrtghomhdprhgtphhtthhopehtrhhinhhisehkohhnshhulh
 hkohdrtghomhdprhgtphhtthhopehmrghtthesthhrrghvvghrshgvrdgtohhmrdgruh
X-ME-Proxy: <xmx:LL_maZmhgtX3eYkFOi0WiyPdVe-29uIg_FyHo1iviqfBR65UNiPsxQ>
 <xmx:LL_maWZA4bWIbhskAJdpG90cgWx8bDjk02QuIoAdX9BAkNWWuLqXtA>
 <xmx:LL_maV_2lxo5ggHeAC8fA7Ncs2bxk7SsXm5QQJ0tOXapHzk7DvOBUQ>
 <xmx:LL_maVZ5R88G8lyl_Fi8APZeHzmwaxvEXfj9l5G19Rvt82bMosuY9A>
 <xmx:LL_maWoOWWm-ceHwiQKz_ZhrjBU9uvBpZsqYJo57By7FPxw8AWrosrIW>
Feedback-ID: i426947f3:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Apr 2026 20:04:57 -0400 (EDT)
From: Mathew McBride <matt@traverse.com.au>
Date: Tue, 21 Apr 2026 10:04:37 +1000
Subject: [PATCH v2 4/8] configs: ten64: enable OF_FIXUP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260421-ten64-add-usb5744-v2-4-eaa81288e393@traverse.com.au>
References: <20260421-ten64-add-usb5744-v2-0-eaa81288e393@traverse.com.au>
In-Reply-To: <20260421-ten64-add-usb5744-v2-0-eaa81288e393@traverse.com.au>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, 
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Michal Simek <michal.simek@amd.com>, Marek Vasut <marek.vasut@mailbox.org>, 
 Padmarao Begari <padmarao.begari@amd.com>, Peng Fan <peng.fan@nxp.com>, 
 Mathew McBride <matt@traverse.com.au>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776729881; l=712;
 i=matt@traverse.com.au; s=20260115; h=from:subject:message-id;
 bh=A7nCwd4yaq65ggBh3nPXmjW77PSn45vF8Ld1MgfxNP4=;
 b=/CariYO/2Y/6xZeBFa70L99LkiYZ60u5Dp8E9lrMOWlY2GxGggqpDrF1c0o7FMKrdTvQxYXiF
 NN8LRBKmmN0AQuVkgpFYdHjJHrMaLml9W/SZso7pIcM4pcFg68e5Ps/
X-Developer-Key: i=matt@traverse.com.au; a=ed25519;
 pk=SM+aGm9Y2fPJ2prfH/b5lab73fTBrKL5UsJwdzv7Pbg=
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

We have added board_fix_fdt to remove elements from U-Boot's
internal FDT related to the USB hub, so COFNIG_OF_FIXUP needs
to be enabled to utilize it.

Signed-off-by: Mathew McBride <matt@traverse.com.au>
---
 configs/ten64_tfa_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/ten64_tfa_defconfig b/configs/ten64_tfa_defconfig
index a65209e8335..0254aa6b4a5 100644
--- a/configs/ten64_tfa_defconfig
+++ b/configs/ten64_tfa_defconfig
@@ -21,6 +21,7 @@ CONFIG_FIT_VERBOSE=y
 CONFIG_BOOTSTD_FULL=y
 CONFIG_BOOTSTD_BOOTCOMMAND=y
 CONFIG_DISTRO_DEFAULTS=y
+CONFIG_OF_BOARD_FIXUP=y
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_USE_BOOTARGS=y

-- 
2.52.0

