Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28666C25B74
	for <u-boot@archiver.kernel.org>; Fri, 24 May 2024 13:02:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78B3C88653;
	Fri, 24 May 2024 15:02:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="IEK6XgHy";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="olDdqdcj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3882A8865D; Fri, 24 May 2024 15:02:46 +0200 (CEST)
Received: from fhigh4-smtp.messagingengine.com
 (fhigh4-smtp.messagingengine.com [103.168.172.155])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 54A3C88545
 for <u-boot@lists.denx.de>; Fri, 24 May 2024 15:02:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id 059F11140083;
 Fri, 24 May 2024 09:02:42 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute4.internal (MEProxy); Fri, 24 May 2024 09:02:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:message-id:mime-version:reply-to
 :subject:subject:to:to; s=fm2; t=1716555762; x=1716642162; bh=os
 On4B9QTW6Q4sue7adG3dpXC8viQ7abevhm634vj6s=; b=IEK6XgHyGOfVCeS9xy
 3+Gq4nPsQxBNu4Xpy5IkLJXRSghvUzaUw4lJPMqBvLag1D/0NPpZtw9TS0Zfz0kH
 9aDP8pzvoH5U2muhsIzLf7L3v1VkaUea1LHAQx0ltFd0UuOg08XoWGXFvhHfHSjf
 1JLTRqh/HZVGhqMLWNGAyEHQ7atLDSDVpvi0kqKYYR8DpaYaOZbVgOd9511lksLS
 ncYHjYjT95g67hMIsDggflBuwlBXjfiWP8gg08fKV3kOAqFFRzHLFzLLCuNKBzO6
 xxTvWwGUhUpT3Xb/yrPSw6ggBd1h77sjhNVwi8BPdJpqIRH+QxozSTK98IpD8ho4
 h3ag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm1; t=1716555762; x=1716642162; bh=osOn4B9QTW6Q4
 sue7adG3dpXC8viQ7abevhm634vj6s=; b=olDdqdcj0rSD8L/cx0mRwWIOFvE7k
 UO4C0xMf6gSp79qLd3tmmObRYchsQ6w2PKB5Mwo1gRB71sD4CJmoA3V4xovDea5O
 uhVYlZ36QQq1DsoAd4nscNRkZ6+wgMhBf0PzuyI5IlrOglnAGD/1rALx4gyvC9a4
 6p8cFaMgz3K21avC0LFrEaWbOlQrIqnnvWeTUZ1FZP8Of6WdTwZ83BGqrBF1jU1V
 1hEJdyCxsOJcZ+nP54B4M4KBDl4t9FN0h7wMgrQ/R93KJ6uNlX8d5keaQ/XqbkNA
 uk+7vcin7gGBD3rpOpk75jDUlZYkkQUcRXfp9BG4Dj/WtDAFW5sYPAwRA==
X-ME-Sender: <xms:8Y9QZqGIZ0dFeXva64kdv8Tj8miHB_vQXZR35iWNIqopl_t8mWSyqg>
 <xme:8Y9QZrXuN0Y3xUhMT382VXhegKLP6S_BdutjOpvzqpcXLb6odcso2hCUYDIl4j_BU
 b0LsKEZwpnQANyCkh8>
X-ME-Received: <xmr:8Y9QZkKZgyJtpgkomKTADERUuLdi87uVFjDSWQdULNGmiaL_mwl2ojI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeikedgheeiucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffufffkgggtgffvvefosehtjeertdertdejnecuhfhrohhmpeflihgrgihu
 nhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqnecugg
 ftrfgrthhtvghrnhepgfevffejteegjeeflefgkeetleekhfeugfegvdeuueejkeejteek
 kedvfffffedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghruf
 hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehf
 lhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:8Y9QZkH5dLdMvVCWhhQR3WjiqKxGNlXG4ygf4scTG8bV9wP8pR7qkQ>
 <xmx:8Y9QZgVL7payXgqVcpia2ad688Fayq09QB3IOstyW35wf2orTygtWQ>
 <xmx:8Y9QZnMLX1rX9dq35AQLPbbaF34YTi4yZZP6Ysv38rKOkbBCR491-g>
 <xmx:8Y9QZn3DYpnktWJq6dqMvWqR9wFozj3jC8Dform_jGfn1D3VNTL5NA>
 <xmx:8Y9QZiJYvOTkLPbCRMCnSt17TUxkX9vm6GQSIIwFqsvpLHrvvGz6IECd>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 May 2024 09:02:40 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v2 0/2] virtio_gpu driver and relevant fix
Date: Fri, 24 May 2024 14:02:38 +0100
Message-Id: <20240524-virtio_gpu-v2-0-b198c35b1fd2@flygoat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAO6PUGYC/03M0QqDIBiG4VuJ/3gOU0vZ0e5jxNAy+2HLUCeL6
 N7ngsEO3w++Z4NoA9oIl2qDYDNG9HMJdqqgn/TsLMGhNDDKBG1qTjKGhP7ulhfRxojBtqpRVEE
 5LMGO+D6wW1d6wph8WA8719/1x8h/JteEkpY33CgpJOvldXyszut07v0Tun3fPy4zef2mAAAA
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1537;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=C1jhz7MjZ5+PwfHg82hbAbv7EpWuDZTPFAJMb2nckyY=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrSA/g9tgs4qJ3S+f+zbp/h0t9kmgceKfhyTBC6HvvpzZ
 OX/x8IrOkpZGMS4GGTFFFlCBJT6NjReXHD9QdYfmDmsTCBDGLg4BWAiDj8YGaYsfPRO5mSH1VO3
 Xz1eT3Y7JSj/OyIkJCH7vePeqe6vM4wZ/llo/vB5kf5WOzPGzstRcM2Fr453PVymM54PC1Q/9KY
 gkhcA
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

This series added support for virtio-gpu device, it has been
tested on QEMU riscv64 and aarch64.

I also fixed a problem in EFI GOP so it works with EFI applications
as well.

There is a problem remaining. virtio_init() is being called too
late to allow virtio-gpu to be selected as a vidconsole. My current
appraoch is to register virtio_init in init_sequence_r, just after
pci_init. Is this a viable approach? Should I introduce a config
like CONFIG_VIRTIO_INIT_R to allow it to be selected by boards?

Thanks

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
Changes in v2:
- Fix left over in previous version (endian, unused variable)
- Fix Kconfig text
- Link to v1: https://lore.kernel.org/r/20240517-virtio_gpu-v1-0-6353b87472c7@flygoat.com

---
Jiaxun Yang (2):
      virtio: New virtio_gpu driver
      efi: gop: Mark pixel_format as BLTONLY if we have sync hook

 drivers/virtio/Kconfig         |  29 +++
 drivers/virtio/Makefile        |   1 +
 drivers/virtio/virtio-uclass.c |   1 +
 drivers/virtio/virtio_gpu.c    | 302 +++++++++++++++++++++++++++++
 drivers/virtio/virtio_gpu.h    | 428 +++++++++++++++++++++++++++++++++++++++++
 include/efi_api.h              |   1 +
 include/virtio.h               |   4 +-
 lib/efi_loader/efi_gop.c       |   8 +-
 8 files changed, 772 insertions(+), 2 deletions(-)
---
base-commit: 21aa37ec1cd4a12e01e0e863ec9e99d703ce4d52
change-id: 20240513-virtio_gpu-abb4de685808

Best regards,
-- 
Jiaxun Yang <jiaxun.yang@flygoat.com>

