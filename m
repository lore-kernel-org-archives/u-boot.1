Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8204FC25B77
	for <u-boot@archiver.kernel.org>; Thu, 16 May 2024 23:03:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90D2E8823C;
	Fri, 17 May 2024 01:03:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="W2iUdFj1";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="EUBNnF6e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F104F88480; Fri, 17 May 2024 01:03:27 +0200 (CEST)
Received: from fhigh3-smtp.messagingengine.com
 (fhigh3-smtp.messagingengine.com [103.168.172.154])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C382E8823C
 for <u-boot@lists.denx.de>; Fri, 17 May 2024 01:03:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id 99D1711400C5;
 Thu, 16 May 2024 19:03:24 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute7.internal (MEProxy); Thu, 16 May 2024 19:03:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:message-id:mime-version:reply-to
 :subject:subject:to:to; s=fm1; t=1715900604; x=1715987004; bh=Os
 bgS7EZFsT5lTMJXGgzjtwlFhoXBNRtpMFiRe37dpM=; b=W2iUdFj1/RcrK9+U4j
 r6s2VEQZNPa2FKxq8TrJbsd7TvVmLxZEE/UFvXQcPNk+Su5q0un/mlnAMjIqcU+6
 1jm3t2keHmLkPqe31zdl7SeXC2p6LyG4XWls67TO1rqcG1djoOWMY9/9SPk5cEiX
 0seFqLOD5owm5RGil2hibCLyieo8ma3HjqO18oAsIKMsBWMJWWvFOQ9nSLEKtQOX
 xzGfoHGF9ssFPaxOcYNPhuesrXrlUNqjK5Eml7o1eOi9AiC6i3t8vQsYI+LNfuBi
 /PKpVwVLJDjAVhw/3lV/F8xqCX5Dcbvi9zaghPIqnCq5HIdLnP+b93I6ok89B2bS
 jRNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm3; t=1715900604; x=1715987004; bh=OsbgS7EZFsT5l
 TMJXGgzjtwlFhoXBNRtpMFiRe37dpM=; b=EUBNnF6ep63TFJ2TtRU0kXIZcUmoj
 vuGZ9ow2ko2qiNFhI0spBlVUmoUE1o/7sR/OexL3uD0e8n40sCylmj+D4zlFiEc6
 e5uCNsoKWdxHkL6LnqYSHvXjK7R9VJHT/i6eY+H3pIql4Fof6sLjw2ip8mrtJzoP
 v4jd6wDfa69kUJa1cN6DO76jR58s6OevEcJvVpCC41Y82VEo0xXHtO/jTfHRLSTp
 c0Ymn+txaY8amb3I5TNEU6ugwyD79Iu2fMiFDt/Dukc08bIYy4f718JTMQDSunZS
 UVQmF2i7YASt0AioKioajbFqmxs5CinwZsPfyzqezGsWWegEpdjbomtmQ==
X-ME-Sender: <xms:vJBGZmW2gfb57S7CEgHGbWv8pjN8cjQkpnQLqMgDJ0HYE37JY7OycQ>
 <xme:vJBGZimDK4KCZXttG9sZFRMkZ8DVGO1bAOKcVODvetcpvSctIIBO9pGMWISF6kibs
 98LTP1nux29KFchhTE>
X-ME-Received: <xmr:vJBGZqYGivM91YvsbNaMo_ULC78uUjLx06IgHqPDMFGjYcygJ_PEsyY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehvddgudeiucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffufffkgggtgffvvefosehtjeertdertdejnecuhfhrohhmpeflihgrgihu
 nhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqnecugg
 ftrfgrthhtvghrnhepudffffffhfeuheevhffgleevkeeugeetfeegieeijeehfeekheek
 veduveeigeeunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
 homhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:vJBGZtVkqQ3HQpp35hAV70h_PiZvTT3v4JG-953tLwQINfEVRvtklQ>
 <xmx:vJBGZgkRV-iqiaspiwIcC0QnHmcer2JHx2qiM6VAvoktOnOa58e3zQ>
 <xmx:vJBGZifzkintJzumml70jZlcnFC4GYCJwzi3LffkIa4oDqgHqQH2mw>
 <xmx:vJBGZiEjmCaFPS72Vj5vYfLw-dftzRprns4FianNWLEyo9HajeUSzQ>
 <xmx:vJBGZuZ-jcswH6qnOhI-xtMhAQWnzhfW4BVhN8x2IddFjMz8H3WJI09O>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 May 2024 19:03:23 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 0/2] virtio_gpu driver and relevant fix
Date: Fri, 17 May 2024 00:03:23 +0100
Message-Id: <20240517-virtio_gpu-v1-0-6353b87472c7@flygoat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALuQRmYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDU0Nj3bLMopLM/Pj0glLdxKQkk5RUMwtTCwMLJaCGgqLUtMwKsGHRsbW
 1AMhUrelcAAAA
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1339;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=EL55uLW471NbfslGB32lQrpg4Xfs35C+rlOE6HRtwS4=;
 b=owGbwMvMwCHmXMhTe71c8zDjabUkhjS3CXvN5jxZ4LL+Tf6lrc6zPwjypHGvv6NULT/DZk9D9
 lfujxdedJSyMIhxMMiKKbKECCj1bWi8uOD6g6w/MHNYmUCGMHBxCsBENq5h+Gfh9bNuuwbT7IWf
 Tp4o1jm7Y0Mzzw6jMJ7D138+ePdLQY6JkeH5W7b9hyK5bigffx2/fJ7piUP+X+TMLi3nTTOtTz5
 fcZkJAA==
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
Jiaxun Yang (2):
      virtio: New virtio_gpu driver
      efi: gop: Mark pixel_format as BLTONLY if we have sync hook

 drivers/virtio/Kconfig         |  29 +++
 drivers/virtio/Makefile        |   1 +
 drivers/virtio/virtio-uclass.c |   1 +
 drivers/virtio/virtio_gpu.c    | 298 ++++++++++++++++++++++++++++
 drivers/virtio/virtio_gpu.h    | 428 +++++++++++++++++++++++++++++++++++++++++
 include/efi_api.h              |   1 +
 include/virtio.h               |   4 +-
 lib/efi_loader/efi_gop.c       |   9 +-
 8 files changed, 769 insertions(+), 2 deletions(-)
---
base-commit: 21aa37ec1cd4a12e01e0e863ec9e99d703ce4d52
change-id: 20240513-virtio_gpu-abb4de685808

Best regards,
-- 
Jiaxun Yang <jiaxun.yang@flygoat.com>

