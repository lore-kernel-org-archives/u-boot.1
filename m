Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FD82C5B572
	for <u-boot@archiver.kernel.org>; Mon, 17 Aug 2026 09:11:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DE40D60721;
	Mon, 17 Aug 2026 09:11:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OW539XmpP9ej; Mon, 17 Aug 2026 09:11:43 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 102606071C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786957903;
	bh=niw8TJqwNE117A+eo/v+peYDMYoIz3mtDtREhGbkm7E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uHI34OKBffCop5qnSle/jZvaHMD4wpn3KVfkHyZAlj9l8v6zQ8t5hwn8yJ2w+rx0f
	 1lW8s7hxIXB3u3mNUBOly/Qcmr1JyqNBKSUBznuVxo7k+wMMOmbhrK3P7OvlC6ao/A
	 clrxI1wRzJT+3ARF1VXl4stVlkRFTDlB8lg4LK8M/N0YhFqWcIDOuaIhFIGvg5a9Zk
	 TeFG6BYl7Jud38+mdGe5u8JMb12IjflE5A5yWMkEqnhdXWa6WyYDXqZWOCzPVHTv+v
	 ZYDsfbX8dGTM6IvGukXhjPlU0qeu5AAq10CYCnbOWhQaO2ibKmxID/ZT0q6/TuYoIo
	 qtINYXK0oqdKA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 102606071C;
	Mon, 17 Aug 2026 09:11:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id CEAE6147
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 09:11:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B4BE4400EC
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 09:11:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fUMqQ0OeqQfj for <u-boot@lists.u-boot-project.org>;
 Mon, 17 Aug 2026 09:11:41 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org E7A6B40087
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E7A6B40087
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=mjqCFLwy
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E7A6B40087
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 09:11:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 08298601DE;
 Mon, 17 Aug 2026 09:11:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 432D11F000E9;
 Mon, 17 Aug 2026 09:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786957899;
 bh=niw8TJqwNE117A+eo/v+peYDMYoIz3mtDtREhGbkm7E=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=mjqCFLwy0W2Ovl5vqoGJiz9yBrJP/pkMSKz03DCE5N1CWz/qu7/Tf3EUjmfZ787aE
 jVsraU5rXXpAH9xq0o9yycq7lag7dI5qr4S0zGoWyaZwoky0XgCLZYNMB1givV/oAU
 T12Mrm2owp8EEXoCl3dJ0bJGll1McddSwtg1AS88tTwH1JN3j7Sq9Thqjkm+27tZey
 r+G7jNGzoZb2q7SN39SPFoYZ+b4ZE/AH9dE0K9HI/ImMfuC5i2GcCR7Efym8PU1RCL
 WOYZodmrIf8hZUm/8lIYXLU76RnEfxZM+KhWyFGF19WgC1YEoYET1VlEV9SiAmsYqW
 HTJcTLKPYPW4w==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Carlo Caione <ccaione@baylibre.com>, u-boot@lists.u-boot-project.org,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: Suhrid Subramaniam <Suhrid.Subramaniam@mediatek.com>, =?utf-8?B?TWFj?=
 =?utf-8?B?cGF1bCBMaW4gKOael+aZuuaWjCk=?= <Macpaul.Lin@mediatek.com>,
 =?utf-8?B?UGFibG8gU3VuICjlravmr5Pnv5Qp?=
 <pablo.sun@mediatek.com>, Arnaud Ferraris <arnaud.ferraris@collabora.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, Sam Day
 <me@samcday.com>, Quentin Schulz <quentin.schulz@cherry.de>, Carlo Caione
 <ccaione@baylibre.com>, David Lechner <dlechner@baylibre.com>, Vitor Sato
 Eschholz <vsatoes@baylibre.com>, Lukasz Majewski <lukma@denx.de>, Marek
 Vasut <marex@denx.de>, Peng Fan <peng.fan@nxp.com>, Jaehoon Chung
 <jh80.chung@samsung.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Julien Masson <jmasson@baylibre.com>, Alexey Charkov <alchark@gmail.com>,
 Adrian Freihofer <adrian.freihofer@siemens.com>, Francois Berder
 <fberder@outlook.fr>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Vincent Jardin
 <vjardin@free.fr>, Peter Robinson <pbrobinson@gmail.com>
Subject: Re: [PATCH RFC v3 3/5] fastboot: make shared configuration checks
 phase-aware
In-Reply-To: <20260731-ccaione-upstream-spl-fastboot-v3-3-dbea3ff4529e@baylibre.com>
References: <20260731-ccaione-upstream-spl-fastboot-v3-0-dbea3ff4529e@baylibre.com>
 <20260731-ccaione-upstream-spl-fastboot-v3-3-dbea3ff4529e@baylibre.com>
Date: Mon, 17 Aug 2026 11:11:37 +0200
Message-ID: <87cxvhi01i.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Carlo,

Thank you for the patch.

On Fri, Jul 31, 2026 at 10:29, Carlo Caione <ccaione@baylibre.com> wrote:

> Fastboot currently builds only for U-Boot proper, so its source and
> Makefile rules test CONFIG_FASTBOOT_* directly. The same checks would
> select U-Boot-proper options when these files are compiled for another
> phase, potentially compiling unavailable backends or using the wrong
> configuration values.
>
> Use CONFIG_IS_ENABLED(), CONFIG_VAL() and CONFIG_$(PHASE_) consistently
> for code and object selection. The empty phase prefix preserves the
> existing U-Boot-proper configuration and behavior while making the
> shared implementation safe to reuse from SPL.
>
> Signed-off-by: Julien Masson <jmasson@baylibre.com>
> Signed-off-by: Vitor Sato Eschholz <vsatoes@baylibre.com>
> Signed-off-by: Carlo Caione <ccaione@baylibre.com>

Sorry for the review delays.

> ---
>  drivers/Makefile              |  2 +-
>  drivers/fastboot/Makefile     |  8 ++++----
>  drivers/fastboot/fb_block.c   |  9 ++++-----
>  drivers/fastboot/fb_command.c | 31 +++++++++++++++++--------------
>  drivers/fastboot/fb_common.c  |  4 ++--
>  drivers/fastboot/fb_getvar.c  | 14 +++++++-------
>  drivers/fastboot/fb_mmc.c     | 36 ++++++++++++++++++------------------

Shouldn't the newly created drivers/fastboot/fb_usb.c be converted as
well?
From what I can see in there, we have:
IS_ENABLED(CONFIG_CMD_FASTBOOT_ABORT_KEYED) which should become:
CONFIG_IS_ENABLED(CMD_FASTBOOT_ABORT_KEYED)


>  7 files changed, 53 insertions(+), 51 deletions(-)
>
> diff --git a/drivers/Makefile b/drivers/Makefile
> index 43d0ba33281..43d03479146 100644
> --- a/drivers/Makefile
> +++ b/drivers/Makefile
> @@ -12,6 +12,7 @@ obj-$(CONFIG_$(PHASE_)DMA) += dma/
>  obj-$(CONFIG_$(PHASE_)DMA_LEGACY) += dma/
>  obj-$(CONFIG_$(PHASE_)DFU) += dfu/
>  obj-$(CONFIG_$(PHASE_)EXTCON) += extcon/
> +obj-$(CONFIG_$(PHASE_)FASTBOOT) += fastboot/
>  obj-$(CONFIG_$(PHASE_)GPIO) += gpio/
>  obj-$(CONFIG_$(PHASE_)DRIVERS_MISC) += misc/
>  obj-$(CONFIG_$(PHASE_)SYSRESET) += sysreset/
> @@ -93,7 +94,6 @@ obj-y += block/
>  obj-y += cache/
>  obj-$(CONFIG_CPU) += cpu/
>  obj-y += crypto/
> -obj-$(CONFIG_FASTBOOT) += fastboot/
>  obj-$(CONFIG_FWU_MDATA) += fwu-mdata/
>  obj-y += misc/
>  obj-$(CONFIG_MMC) += mmc/
> diff --git a/drivers/fastboot/Makefile b/drivers/fastboot/Makefile
> index 32e8e072c88..12008ac05e2 100644
> --- a/drivers/fastboot/Makefile
> +++ b/drivers/fastboot/Makefile
> @@ -4,8 +4,8 @@ obj-y += fb_common.o
>  obj-y += fb_getvar.o
>  obj-y += fb_command.o
>  obj-$(CONFIG_USB_FUNCTION_FASTBOOT) += fb_usb.o

Same question here, should CONFIG_USB_FUNCTION_FASTBOOT move to a phase
specific as well?

The rest looks good.
Thanks
Mattijs

