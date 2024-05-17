Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56B3AC25B77
	for <u-boot@archiver.kernel.org>; Fri, 17 May 2024 22:09:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A29088204;
	Sat, 18 May 2024 00:09:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="dUc0bgXk";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="hMgX9430";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB8A5885D4; Sat, 18 May 2024 00:09:34 +0200 (CEST)
Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com
 [103.168.172.147])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB58587DEA
 for <u-boot@lists.denx.de>; Sat, 18 May 2024 00:09:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailfout.nyi.internal (Postfix) with ESMTP id 7EA6F1380255;
 Fri, 17 May 2024 18:09:30 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute1.internal (MEProxy); Fri, 17 May 2024 18:09:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:message-id:mime-version:reply-to
 :subject:subject:to:to; s=fm1; t=1715983770; x=1716070170; bh=I4
 qZBzg5fV2wE2rBHWjuEtWfLLBh0dCKIFNH4ujR3I0=; b=dUc0bgXkaCSJV0OSNl
 1+ZrH66hBQX/FUJuyPa78CLITl6EgBWkdYSXPiUCyHOAtPlNHlQrO9VNn4qP/GJs
 TV5zmXpbdq3dykw73xAN7p6tFpv6fO/lAOOvvs7H4YpjnkQMlMjZNowhBMSaLxtz
 PsT/BxmjVX6FC/QU6YMzbZEuUXKKOh8OtkryXsDf8GB7y6lKa6T1p/exYmtOjHOw
 qQkMGCUQTWc0jdWcp9gRVizlgl1OTlRmaCJkYO0yRgPVeCGaLnH0EXohOHq/UVNc
 ybDpy3jmFc2UWDri/nHGARSjnF4iU84OodXDjCnBtj16CoCcKx7//zXdXSw+ovFM
 ga2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm3; t=1715983770; x=1716070170; bh=I4qZBzg5fV2wE
 2rBHWjuEtWfLLBh0dCKIFNH4ujR3I0=; b=hMgX94304YYPJ2dlgeYJ3zCa83vMc
 LEom/48tHk+r9MrQ2uGaf8h1XKzPR4HbfaVGnzFkWhZrls2fsTaV6yvCrAHCpt2m
 9LQfC+gYX+v2kB/KhaBS6VkWfNtbJI9AJPA6VrdUkuX/KAki10MdjZZlaYfd1GIj
 pH4BainE84zwzZp+nx17+ZrlyN85fWNuUh70AwfnyLHVEopng9kf63KjF6MyqObx
 fRfYhZU5WpoK8julbKcLSt6VxT3kZ7XyDR+LczR1PUE6h+qn5wp2gnpqOtwDAb92
 KD5jSZ5GaCh0lEu/mV0C63aBA+RsVTooVCq/Z31kLuVKITblJDtKryCLg==
X-ME-Sender: <xms:mtVHZhWQMFN2NjSpaU5ycCVzbF2w3mSmd6XYqdcJSHUYvDwMsJmOUQ>
 <xme:mtVHZhlTcl4zhcPNmCmqAPRzhgvzIDnjY9wlfvjx_YupdbEumATKqbVWNzjSMkjo3
 RtG7gJ-9IBUNKHAh28>
X-ME-Received: <xmr:mtVHZtYvwi31yFdeNIEd-8LAcU3EaV_KswWW82yDJhEbpDrys_Tgjr0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehhedgtdeiucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffufffkgggtgffvvefosehtjeertdertdejnecuhfhrohhmpeflihgrgihu
 nhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqnecugg
 ftrfgrthhtvghrnhepgfevffejteegjeeflefgkeetleekhfeugfegvdeuueejkeejteek
 kedvfffffedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghruf
 hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehf
 lhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:mtVHZkUO1OSMzpB-lD_ubr6I5uJuFkCW7cVX7je72QZ2LdaDVM8_lA>
 <xmx:mtVHZrnV-yxqrXqpNXZuybjiXNJ2SFO75FuxUO_NcWgHVqDQ5eiqYw>
 <xmx:mtVHZhfSsF4GA5rF-SMTWK_Yq9-dcZBoxLbr67T28ZxdRkHD2_Tcbw>
 <xmx:mtVHZlGv2z8BQhw4VwvVAd9gIHLbkl3rbnfiTLadoEriL2Qx_Dh7xQ>
 <xmx:mtVHZpYkZlWzZ9NdXFKd5vJXFsVKfzbxJgZMeua8qm0frA7C1cj8swSO>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 May 2024 18:09:29 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 0/3] sandbox: HOST_ARCH improvements
Date: Fri, 17 May 2024 23:09:26 +0100
Message-Id: <20240517-sandbox-hostarch-kconfig-v1-0-716c146635c9@flygoat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJbVR2YC/x3MQQqEMAxA0atI1hOoYlXmKjKL2KY2CO3QiAji3
 S0u3+L/C5SLsMK3uaDwISo5VbSfBlyktDKKr4bOdL2x7YhKyS/5xJh1p+Iibi6nICuSHciGySy
 j8VDzf+Eg57uef/f9AMgZNKlqAAAA
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1683;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=BHopRBsNpZE9hMbqgAFgNbIVEsAM0lpYi6NyNMC9om4=;
 b=owGbwMvMwCHmXMhTe71c8zDjabUkhjT3q7NKmF/UPfveYsk0ccp7jlnL5u+zmh+/+t+d7A9v3
 XTXbRVx7ShlYRDjYJAVU2QJEVDq29B4ccH1B1l/YOawMoEMYeDiFICJuDoy/A/m9Hi79cW0wtkS
 YptVn7WuPzX9+nb+3ia799lCzW+aOLQZ/oocZf52zYhxQtPuyk+akjqH702XnO3Ao33++KP1DNO
 1RbgB
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

Hi all,

This series is in respond to a review comment [1] I got from Heinrich.

It moved detection of HOST_ARCH to Kconfig, which allows us to control
options based on HOST_ARCH.

It further improved detection and configuration of SDL2 so that it can
work with cross toolchain provided sysroot.

Tested on x86_64, cross compile and loosely tesed with qemu-user on
riscv64, arm, aarch64.

Thanks

[1]: https://lore.kernel.org/u-boot/2CD8D385-F0A9-4A1B-827D-1C55CD7E32ED@gmx.de/

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
Jiaxun Yang (3):
      sandbox: Move HOST_ARCH detection to Kconfig
      EFI: Make EFI loader depend sandbox HOST_ARCH
      sandbox: Use pkg-config to detect and config sdl2

 Makefile                                          | 27 ++---------------------
 arch/sandbox/Kconfig                              | 25 ++++++++++++++++++++-
 arch/sandbox/config.mk                            | 17 +++++++-------
 arch/sandbox/lib/crt0_sandbox_efi.S               | 14 ++++++------
 arch/sandbox/lib/reloc_sandbox_efi.c              | 14 ++++++------
 doc/arch/sandbox/sandbox.rst                      |  6 -----
 include/efi_default_filename.h                    | 14 ++++++------
 include/host_arch.h                               | 26 ----------------------
 lib/efi_loader/Kconfig                            |  7 ++++--
 lib/efi_selftest/efi_selftest_miniapp_exception.c |  6 ++---
 10 files changed, 63 insertions(+), 93 deletions(-)
---
base-commit: ad7dce5abd49ef3b5c93da5303e15449c8c162b4
change-id: 20240517-sandbox-hostarch-kconfig-a56a5f80b70d

Best regards,
-- 
Jiaxun Yang <jiaxun.yang@flygoat.com>

