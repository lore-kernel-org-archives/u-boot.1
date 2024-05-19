Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BB30C25B77
	for <u-boot@archiver.kernel.org>; Sun, 19 May 2024 20:54:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4AEEE8822D;
	Sun, 19 May 2024 22:53:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="eL3jpBdm";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="nHN3m9Z1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D5F88813F; Sun, 19 May 2024 22:53:56 +0200 (CEST)
Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com
 [103.168.172.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C83C87E0B
 for <u-boot@lists.denx.de>; Sun, 19 May 2024 22:53:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailfout.nyi.internal (Postfix) with ESMTP id 26A5513803B4;
 Sun, 19 May 2024 16:53:51 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute1.internal (MEProxy); Sun, 19 May 2024 16:53:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:message-id:mime-version:reply-to
 :subject:subject:to:to; s=fm2; t=1716152031; x=1716238431; bh=Xt
 6TtxJM89SSm8S9rYb0bBDcfvCkE8lV5qNnkClhZBw=; b=eL3jpBdm5NvGehjZPV
 8A1yj+AouUIYNgMBnCAhbDMKbWOXkelT3hYltQeHa0E1/3intLqpp0llvShdC7bV
 Qj7UGxZhiF+T7k82ySzniYv/X7dU6AP6f9FgCfHTh1ING21JClS5onoODsPPskAw
 FJCYMFfUP9P+6XGOlO7YFHtWulcFxAg/memNKNqmSQoq2lYKTKnK2DwQefJkQXBA
 MbLTNpR9UJVjuynnK66NQ9hupFPg5So5q9BHc7694cVT7i05orbXOiaJB8Z1r4IC
 5aZ67HxJhxh5jexzMBVQs2XytUq/0NmTpkncfK+h3yQGz7TmTi1eccrX64fW8phv
 f5YQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm1; t=1716152031; x=1716238431; bh=Xt6TtxJM89SSm
 8S9rYb0bBDcfvCkE8lV5qNnkClhZBw=; b=nHN3m9Z1Rtu50T9nu2b1vpU7JAz6P
 ZI12GiNyx2UBJL0zQhUNOuyCkR2DYgwDpCEq0g/Vq+OkS2+y/Gpb7cx5mbn7hqf1
 WZe8xxCZYd12+2iyoTMdqFApti4AsjNzTpOwWEQbRpZWKKZyl6iM2f3HjYF7NYZw
 FPE/++m34ZuhhQMZykS2MY5aMOGAkK+irTflR6bQtjoHwpkuwsaGDomZmyDcRhcz
 7Iu6bX5uV+SPbN1nDEStibxKdMR3KPwPgv8w+DYG0Bz5LA35kize9hkBeASSiRbR
 qkD4sQxx08KzooBMH5Vcx/lKMQ9fdgYb6/TLEfgceMco6OzK4nxFGp05A==
X-ME-Sender: <xms:3mZKZh1JCvroWvuRs1DhHYbnAknf8T4bYNxaNzhzobWs4k5dRriKUQ>
 <xme:3mZKZoFLw4ikQW7UUqVZG_3chXLl7MdgN6ozcUDC2yUjZLhyxxcTs7OcwFagV2TjL
 CDvR8EIJ_OsnuFKLwM>
X-ME-Received: <xmr:3mZKZh5kSSGF7WKyQ6I1oIYt3-mMo3Y4pJ343aVIly-vxaD3RRCiln8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehkedgudehvdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpefhufffkfggtgfgvfevofesthejredtredtjeenucfhrhhomheplfhirgig
 uhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqeenuc
 ggtffrrghtthgvrhhnpeelleehgeevgedtvefgfeevgfevveefheejhfekjeeiveethfeg
 geeivefggeegudenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrh
 fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghes
 fhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:3mZKZu0AvrCbivics4UcYvaPJbE8WIom8uKZGIj6exlyyjTpfB2mCw>
 <xmx:3mZKZkEXe5J_vZlmRZQTz8TbR8wz6tszP08aOgoY3u6klNWx1qngVg>
 <xmx:3mZKZv_oH0RMSvjUxa-Iv82q9PaHz6-0hBzrme48cjPqOiVDFmeGRQ>
 <xmx:3mZKZhngnAzT-IVxnoMfGU76rOiqQFNlCHJZFtTxB0YxmGvjkY_IMQ>
 <xmx:32ZKZp4vwD0abbXvBqbAjWCNk5BrSSj0faXTAs0rv1HmrahKURYDB5Sh>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 19 May 2024 16:53:49 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 00/10] xtensa: Enable qemu-xtensa board
Date: Sun, 19 May 2024 21:53:47 +0100
Message-Id: <20240519-qemu-xtensa-v1-0-8fff0cb11c19@flygoat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANtmSmYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDU0NL3cLU3FLdipLUvOJEXdO0JEvTpCQTc5NUSyWgjoKi1LTMCrBp0bG
 1tQDD6K1DXQAAAA==
To: u-boot@lists.denx.de, Sean Anderson <sean.anderson@seco.com>
Cc: Max Filippov <jcmvbkbc@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Sumit Garg <sumit.garg@linaro.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3100;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=LjyXmTRZpZ9cfEHbF+MierMhPmfobD63ozrH8ErRUjU=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhjSvtHv9tXbWr1PTw4K3tPxVFPy76PHN9uiUE8EzCrx3P
 4toj1rSUcrCIMbFICumyBIioNS3ofHigusPsv7AzGFlAhnCwMUpABMJCWb4Z1x7ysiSM+LQ/Mgr
 xUfXHfqgxuhnfLy6r85qTZlTCXMtOyPDgUWTDlgyTPLhTXjL9zR4+gJm9fe8EzpnTNyqxdNlfcS
 CDwA=
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

This series enabled qemu-xtensa board.

For dc232b CPU it needs to be built with toolchain[1].

This is a side product of me investigating architectures
physical address != virtual address in U-Boot. Now we can
get it covered under CI and regular tests.

VirtIO devices are not working as expected, due to U-Boot's
assumption on VA == PA everywhere, I'm going to get this fixed
later.

My Xtensa knowledge is pretty limited, Xtensa people please
feel free to point out if I got anything wrong.

Thanks
[1]: https://github.com/foss-xtensa/toolchain/releases/download/2020.07/x86_64-2020.07-xtensa-dc232b-elf.tar.gz

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
Jiaxun Yang (10):
      xtensa: Move dram_init to xtfpga board file
      xtensa: Correct define of _end symbol
      xtensa: Implement phys virt conversion for PTP_MMU
      xtensa: Define PLATFORM_ELFFLAGS
      xtensa: Bring in semihosting headers and config options
      drivers: serial: Add xtensa semihosting driver
      drivers: cpu: Add xtensa CPU driver
      dts/upsteam: Add Makefile for xtensa
      board: emulation: New board qemu-xtensa
      doc: New documentation for qemu-xtensa

 arch/xtensa/Kconfig                              |  32 +++++++
 arch/xtensa/config.mk                            |   3 +
 arch/xtensa/cpu/cpu.c                            |   5 -
 arch/xtensa/cpu/u-boot.lds                       |   2 +
 arch/xtensa/include/asm/addrspace.h              |   2 +
 arch/xtensa/include/asm/io.h                     |  32 +++++++
 arch/xtensa/include/asm/ldscript.h               |   1 -
 arch/xtensa/include/asm/platform/simcall-gdbio.h |  34 +++++++
 arch/xtensa/include/asm/platform/simcall-iss.h   |  73 ++++++++++++++
 arch/xtensa/include/asm/platform/simcall.h       | 110 +++++++++++++++++++++
 board/cadence/xtfpga/xtfpga.c                    |   5 +
 board/emulation/qemu-xtensa/Kconfig              |  41 ++++++++
 board/emulation/qemu-xtensa/MAINTAINERS          |   7 ++
 board/emulation/qemu-xtensa/Makefile             |   5 +
 board/emulation/qemu-xtensa/qemu-xtensa.c        |  60 ++++++++++++
 configs/qemu-xtensa-dc232b_defconfig             |  32 +++++++
 doc/board/emulation/index.rst                    |   1 +
 doc/board/emulation/qemu-xtensa.rst              |  33 +++++++
 drivers/cpu/Kconfig                              |   6 ++
 drivers/cpu/Makefile                             |   1 +
 drivers/cpu/xtensa_cpu.c                         | 117 +++++++++++++++++++++++
 drivers/serial/Kconfig                           |  18 +++-
 drivers/serial/Makefile                          |   1 +
 drivers/serial/serial_xtensa_semihosting.c       |  79 +++++++++++++++
 dts/upstream/src/xtensa/Makefile                 |  14 +++
 include/configs/qemu-xtensa.h                    |  34 +++++++
 26 files changed, 741 insertions(+), 7 deletions(-)
---
base-commit: 3be9f399e911cfc437a37ac826441f1d96da1c9b
change-id: 20240519-qemu-xtensa-5fb95bb474e9

Best regards,
-- 
Jiaxun Yang <jiaxun.yang@flygoat.com>

