Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D84ADC25B77
	for <u-boot@archiver.kernel.org>; Fri, 17 May 2024 22:10:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51950885E4;
	Sat, 18 May 2024 00:09:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="MsxYFTta";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="lE19xbJD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A28B1885DC; Sat, 18 May 2024 00:09:36 +0200 (CEST)
Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com
 [103.168.172.147])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB6A2882CF
 for <u-boot@lists.denx.de>; Sat, 18 May 2024 00:09:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
 by mailfout.nyi.internal (Postfix) with ESMTP id E7A8A13814EF;
 Fri, 17 May 2024 18:09:32 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute6.internal (MEProxy); Fri, 17 May 2024 18:09:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1715983772;
 x=1716070172; bh=f9RJ36sX8SAsAspZh86VjaznR7vuuOOF017xPEwY1Zc=; b=
 MsxYFTtayNm171SKbKdHW5jo70cJgQrqWOtbOWgWfojqwVnMR6Z/grPqmqFYTrxo
 ffbh3jS7JdATVYeXQ21ciVeSrgVLb0PlHkZMulzBbCxJtdOFz3EPi6UrGZm/YzSw
 qjBwAlESCKUaido1rVILMSMIIe7BXLTUXAnO+aIQaiXEOxw+frhGTI050NfKSkTk
 y7d/ChV9QdZRlIWYtidPAnKgRQ3K1wZ6zFBuFk8oGL5Epm8VtaOSt5KlrFbwPLiH
 6YSV1xmvMR7rmCjwc9B+BZBIE7SnqY7ecLVBJDavPorXI1kFf6sj8jwg1K8inTuZ
 hHBZeeyi0ydU5gw+sj7PHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1715983772; x=
 1716070172; bh=f9RJ36sX8SAsAspZh86VjaznR7vuuOOF017xPEwY1Zc=; b=l
 E19xbJDh4N2t02UPGlQ15arrEGIMJCN/N0uCWZoK8ng9uu6dkaO55WIfLV7L/lRL
 2xE3CTFtXoccuLOWS8jN54NMuUDsXU7iXVBBaINFT1eSkUOuKDhAsVHiczV/ailu
 Ldwkn35IdSw0AHPORRLDSfl5yGtO8zJvUT4nsDf7zcCdE7+xEQJC07G4VHya1zEK
 YAwzTz2GtPDeguUjq4lSyyAlZG5+8e82Dhpoq3WDREkLQElNZ3Sh7e87PbVskiTA
 LV3AD8kgVsOx5U1YbyWDuUuMK9TF7oU4Sk7VGQA6/1eYnp8i+bsT/5CJIbMeD3I1
 cL86/DKCpRgW9ckJn0AlQ==
X-ME-Sender: <xms:nNVHZmW7Fg8K5k8To1TFHnCuVAz-A89N2o1aDbfFSky0b4JqRhHf1g>
 <xme:nNVHZimkHHgZphCbrsZoxdpC4S4mv-joVRjMXh7xcb13qbrrEmfJLkj0XBEJ9hp2I
 JUuNIVBL5EtRzDnpZM>
X-ME-Received: <xmr:nNVHZqYT27q73uGPLohlIlQFrRwbzsIlEg8PtSVEuvjdGUQE3m-yLWQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehhedgtdeiucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
 gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
 cuggftrfgrthhtvghrnhepvdekiefhfeevkeeuveetfeelffekgedugefhtdduudeghfeu
 veegffegudekjeelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
 hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:nNVHZtXt2bjuRziKSKW-Md1gBmBxbfIhrCGLV0ON34YIBNAM2evASQ>
 <xmx:nNVHZglmF7PRB5d0P3xOTfPAUKItbeU27LyJmyJsSY7LzDXe1w3mzw>
 <xmx:nNVHZick1aWTIACKsdYIo_7ZjNJyUk2L6PMNa6dC_GGV9-o2R8NEyQ>
 <xmx:nNVHZiEAzbImr8OgRy6dizQG0x0tX56xg-fG8L16iFTCEkz0x-jMtg>
 <xmx:nNVHZubDbXfDnKS2glm5irZSFbbST0dKgbhkgl-H_mXLeQ8maS-5u5IY>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 May 2024 18:09:31 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Fri, 17 May 2024 23:09:28 +0100
Subject: [PATCH 2/3] EFI: Make EFI loader depend sandbox HOST_ARCH
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240517-sandbox-hostarch-kconfig-v1-2-716c146635c9@flygoat.com>
References: <20240517-sandbox-hostarch-kconfig-v1-0-716c146635c9@flygoat.com>
In-Reply-To: <20240517-sandbox-hostarch-kconfig-v1-0-716c146635c9@flygoat.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1118;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=rEmujuOwsi/1eJM03/w+0Z/Zuzk9b/dzlFtnuX+I1qA=;
 b=owGbwMvMwCHmXMhTe71c8zDjabUkhjT3q7NuTZMsshZ4MfdT1ZbJd52+hNmfN/U3OnPqeP0Et
 RPCHJVuHaUsDGIcDLJiiiwhAkp9GxovLrj+IOsPzBxWJpAhDFycAjARt6sM/9NftG/Zp7V+edYh
 Z8fIjYVPBbd/ENhoM7d395w7pYpLN9oxMuzbn+i7Zt69NwfOeHTYLDhVefFWmf3l94c3Ktp22b0
 oOsEDAA==
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

Since EFI loader on sandbox requires some architecture
code, make it depend on HOST_ARCH to ensure it's only
compiled on desired host.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 lib/efi_loader/Kconfig | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
index 430bb7f0f7dc..54d180fe31c1 100644
--- a/lib/efi_loader/Kconfig
+++ b/lib/efi_loader/Kconfig
@@ -1,11 +1,14 @@
 config EFI_LOADER
 	bool "Support running UEFI applications"
-	depends on OF_LIBFDT && ( \
+	depends on OF_LIBFDT && (( \
 		ARM && (SYS_CPU = arm1136 || \
 			SYS_CPU = arm1176 || \
 			SYS_CPU = armv7   || \
 			SYS_CPU = armv8)  || \
-		X86 || RISCV || SANDBOX)
+		X86 || RISCV) || \
+		(SANDBOX && (HOST_ARCH_X86 || HOST_ARCH_X86_64 || \
+			     HOST_ARCH_ARM || HOST_ARCH_AARCH64 || \
+			     HOST_ARCH_RISCV32 || HOST_ARCH_RISCV64)))
 	# We need EFI_STUB_64BIT to be set on x86_64 with EFI_STUB
 	depends on !EFI_STUB || !X86_64 || EFI_STUB_64BIT
 	# We need EFI_STUB_32BIT to be set on x86_32 with EFI_STUB

-- 
2.34.1

