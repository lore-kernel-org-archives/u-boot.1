Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBC3BC282EC
	for <u-boot@archiver.kernel.org>; Fri, 14 Mar 2025 20:10:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3724A81ECD;
	Fri, 14 Mar 2025 21:10:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=mainlining.org header.i=@mainlining.org header.b="o0AOFcPa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 723AB81F49; Fri, 14 Mar 2025 19:36:18 +0100 (CET)
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22F0981E92
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 19:36:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mainlining.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrian@mainlining.org
Received: from [172.20.123.186] (xdsl-78-35-81-182.nc.de [78.35.81.182])
 by mail.mainlining.org (Postfix) with ESMTPSA id 82CFEBBAC0;
 Fri, 14 Mar 2025 18:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mainlining.org;
 s=psm; t=1741977375;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tOQgmIC5QceO+KtTKM6E9Ch8udwYqzcrOWbow4eVQUQ=;
 b=o0AOFcPayWyC495aBAqOw2/zn25OS3Rjlrq9B4Sn27YU97abR8CVK+Tkw47gw9bs4DOm02
 nBOEdFrBRMhX5PFEp6isFRbSgliF1p3lDWYNLXvEIj9ZthaqEot5E362Pv1tQRg3ycQ6uD
 gIp81OuiK7jp4W/UYnSSSF/E59DcpfhCkHTKV4vfK0JCcIV20/kz2qTfIyFfKeeGSNlxUr
 /uGOvq18gZW8JviInUcTMoZ1cy3bldS9CfUb8mETK2ZrsSN7JH62YlrKWqRm4PeLmvhy5W
 ed+L1sRkmXI6ilmDsLAVtDE0QdmLDeWBiV9m0No0k1b4nF823jXDJ7m45WOs5Q==
Message-ID: <269344d3-f8ad-4ae2-ab26-ff376f1f7960@mainlining.org>
Date: Fri, 14 Mar 2025 19:36:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] Better smartphone support (Qualcomm)
To: Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
References: <20250311-qcom-phones-v2-0-83dcd88a6a87@linaro.org>
Content-Language: en-US
From: Jens Reidel <adrian@mainlining.org>
In-Reply-To: <20250311-qcom-phones-v2-0-83dcd88a6a87@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Fri, 14 Mar 2025 21:10:25 +0100
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

On 3/11/25 1:31 PM, Caleb Connolly wrote:
> Improve support for running U-Boot on [Qualcomm] smartphones, with:
> 
> * A boot menu which can be entered by holding power during boot
> * Hang on panic (so errors can be read on the display)
> * Serial gadget which can be enabled by holding volume down or via
>    boot menu
> 
> In its current form, U-Boot's boot menu is perfectly adequate, however
> once an option is picked U-Boot will never return to the menu, always to
> the CLI.
> 
> On a phone (with no keyboard), dropping to the CLI effectively makes the
> device unusable until manually rebooted, since there is no way to run
> any commands...
> 
> To rectify this, let's revive CONFIG_BOOT_RETRY for the hush parser and
> add an option CONFIG_RETRY_BOOTCMD to run the contents of "bootcmd".
> This provides for a flexible menu system which we can enter and exit.
> See qcom-phone.env in patch 1 for more details.
> 
> Finally, provide some rough-ish documentation to describe how Qualcomm
> phone support works and outline some debugging steps for when UART and
> the framebuffer are unavailable.
> 
> ---
> Changes in v3:
> - Minor wording/clarification improvements in docs
> - Introduce CONFIG_RETRY_BOOTCMD rather than changing the default
>    behaviour.
> - Enable some more gadgets in the phone config fragment.
> - Link to v2: https://lore.kernel.org/u-boot/20241004-qcom-phones-v2-0-c7ab67ac3043@linaro.org
> 
> Changes in v2:
> - Fix CONFIG_BUTTON_REMAP_PHONE_KEYS name in qcom-phone.config
> - Add Tom and Simon to CC
> - Link to v1: https://lore.kernel.org/r/20240831-qcom-phones-v1-0-08614edd8e35@linaro.org
> 
> ---
> Caleb Connolly (4):
>        board/qualcomm: introduce phone config
>        cli_hush: support running bootcmd on boot retry
>        bootretry: check for bootretry variable changes
>        doc: board/qualcomm: describe phone support and bringup
> 
>   board/qualcomm/qcom-phone.config |  17 ++++++
>   board/qualcomm/qcom-phone.env    |  49 ++++++++++++++++
>   boot/Kconfig                     |   7 +++
>   boot/bootretry.c                 |   2 +
>   common/cli_hush.c                |   6 +-
>   common/cli_hush_upstream.c       |   6 +-
>   doc/board/qualcomm/board.rst     |   5 ++
>   doc/board/qualcomm/index.rst     |   1 +
>   doc/board/qualcomm/phones.rst    | 122 +++++++++++++++++++++++++++++++++++++++
>   9 files changed, 211 insertions(+), 4 deletions(-)
> ---
> base-commit: 78f8c8c58f7d3f7c3a26af4afbd08aba21c14c90
> 
> Caleb Connolly <caleb.connolly@linaro.org>
> 

I've tested this on a Xiaomi Mi 9T / Redmi K20 (xiaomi-davinci, Qualcomm 
SM7150) with a handful of patches on top for SM7150 support.

I had to manually enable the following configs for USB serial gadget to 
work, so I suggest enabling them like others already pointed out:
CONFIG_DM_USB_GADGET=y
CONFIG_USB_FUNCTION_ACM=y

Also, for EFI boot to work I added the following configs, not sure which 
ones were actually making the difference:
CONFIG_EFI_RT_VOLATILE_STORE=y
CONFIG_EFI_SET_TIME=y
CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
CONFIG_EFI_CAPSULE_ON_DISK=y
CONFIG_EFI_IGNORE_OSINDICATIONS=y
CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y

With those enabled, everything works as expected and is comfortable to 
navigate. Thanks for your work!

Tested-by: Jens Reidel <adrian@mainlining.org> # xiaomi-davinci

Best regards,
Jens
