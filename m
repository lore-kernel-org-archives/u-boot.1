Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87F79C83F29
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 07:06:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F147C8655A;
	Thu, 31 Aug 2023 09:06:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Ck0XNuEc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF46C8657D; Thu, 31 Aug 2023 09:06:48 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ABCCF8655A
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 09:06:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-401d80f4ef8so4628685e9.1
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 00:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693465605; x=1694070405; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=06G2evSP27jaz3zJRbGbHKtTtwFOmZ8+0C8C00RzbL4=;
 b=Ck0XNuEc8F5ffo2KslN16IyF54i36pQQNb4jP6oLhKC2omCroIzvztVo7ALm/UIHrg
 bDIOtb6JYhVh/zRZ4Frmy1QyBs+pWqmwIadhQXzA3iyTVBF45T6rTkKdxpe1Auyqregw
 WghBcQs76gNXJ5TDu/KQg2VKC8TcNrsMj3S9M/4v6t3IR3WnW7S4QUe0sreMKVy18Jln
 SLtFpj/UktyiKZyX9Ho0wMEA7QpH5r81CnWxpRefw1Stb+4LFE6hIA0fI9zm+Y5AnSIC
 pFN5HQV/PRo/cAS2DtavMklsxNRME8/ksPTJofjgngkA1BF/pkFtnYvbOfuLGhQCLjzG
 DSjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693465605; x=1694070405;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=06G2evSP27jaz3zJRbGbHKtTtwFOmZ8+0C8C00RzbL4=;
 b=MIL6DXpk0oFvS7SIbJvFSdKHV7yfoy0ELDtVRyi79RBVnuSy0DT2Ka4h8iOZoP0D6i
 aA95CVJ7AyG/8ALuf4+iEFEoQ6tXxm1/WLfwSoa/ZucP+CSqdBlI8t2eTjQ7ewQrJCkr
 MbgscaZAmYPimpqOWg7Rfbh5NNwvDkpOZ7WwEa8EG939/yw+PLmj/FbmUy17DRuYBYzM
 N4NppG7nGO28EkLKMXflL6pY9Y3H8NngsoqFemIvTrSmXu7WZtPIX6U/uct2J0ELDfu5
 zB8imqjPVcc+QMuOvpDEVvP14f7TTMLHj4ZfgidhEppJBlaj+p76GAZWbEzJtWfVWc6y
 WnDg==
X-Gm-Message-State: AOJu0YwrdD04XthsVNZSANdo20J3PG1ULs3TUG8T5BP3FVueEpWTHpmh
 AvIu1srQtBDx0ZEUefRRa2yaAg==
X-Google-Smtp-Source: AGHT+IHm6/5AOdZm/4jrJBQ+3WRXipAVVypM3NLIXrK9vuYAMOhsCkZrF+f1Hx1dyBDMh0wULwGSfA==
X-Received: by 2002:a05:600c:210e:b0:3fe:e812:4709 with SMTP id
 u14-20020a05600c210e00b003fee8124709mr4149990wml.12.1693465605072; 
 Thu, 31 Aug 2023 00:06:45 -0700 (PDT)
Received: from hades (ppp089210246083.access.hol.gr. [89.210.246.83])
 by smtp.gmail.com with ESMTPSA id
 n5-20020a05600c294500b003fa96fe2bd9sm4175151wmd.22.2023.08.31.00.06.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 00:06:44 -0700 (PDT)
Date: Thu, 31 Aug 2023 10:06:42 +0300
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Baruch Siach <baruch@tkos.co.il>, Bin Meng <bmeng.cn@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerry Van Baren <vanbaren@cideas.com>,
 Michal Simek <michal.simek@amd.com>, Nikhil M Jain <n-jain1@ti.com>,
 Qu Wenruo <wqu@suse.com>, Stefan Roese <sr@denx.de>
Subject: Re: [PATCH 30/32] fdt: Allow the devicetree to come from a bloblist
Message-ID: <ZPA8AtGOel8pko6y@hades>
References: <20230830180524.315916-1-sjg@chromium.org>
 <20230830180524.315916-31-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230830180524.315916-31-sjg@chromium.org>
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

Hi Simon,

On Wed, Aug 30, 2023 at 12:05:01PM -0600, Simon Glass wrote:
> Standard passage provides for a bloblist to be passed from one firmware
> phase to the next. That can be used to pass the devicetree along as well.
> Add an option to support this.
> 
> Tests for this will be added as part of the Universal Payload work.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
>  common/bloblist.c                  |  2 ++
>  doc/develop/devicetree/control.rst |  3 ++
>  dts/Kconfig                        |  8 ++++++
>  include/bloblist.h                 |  5 ++++
>  include/fdtdec.h                   |  3 +-
>  lib/fdtdec.c                       | 44 ++++++++++++++++++++++--------
>  6 files changed, 52 insertions(+), 13 deletions(-)
> 
> diff --git a/common/bloblist.c b/common/bloblist.c
> index 6f2a4577708..b07ede11cfe 100644
> --- a/common/bloblist.c
> +++ b/common/bloblist.c
> @@ -48,9 +48,11 @@ static struct tag_name {
>  	{ BLOBLISTT_ACPI_TABLES, "ACPI tables for x86" },
>  	{ BLOBLISTT_SMBIOS_TABLES, "SMBIOS tables for x86" },
>  	{ BLOBLISTT_VBOOT_CTX, "Chrome OS vboot context" },
> +	{ BLOBLISTT_CONTROL_FDT, "Control FDT" },
>  
>  	/* BLOBLISTT_PROJECT_AREA */
>  	{ BLOBLISTT_U_BOOT_SPL_HANDOFF, "SPL hand-off" },
> +	{ BLOBLISTT_VBE, "VBE" },
>  	{ BLOBLISTT_U_BOOT_VIDEO, "SPL video handoff" },
>  
>  	/* BLOBLISTT_VENDOR_AREA */
> diff --git a/doc/develop/devicetree/control.rst b/doc/develop/devicetree/control.rst
> index cbb65c9b177..56e00090166 100644
> --- a/doc/develop/devicetree/control.rst
> +++ b/doc/develop/devicetree/control.rst
> @@ -108,6 +108,9 @@ If CONFIG_OF_BOARD is defined, a board-specific routine will provide the
>  devicetree at runtime, for example if an earlier bootloader stage creates
>  it and passes it to U-Boot.
>  
> +If CONFIG_OF_BLOBLIST is defined, the devicetree comes from a bloblist passed
> +from a previous stage.
> +

Is this bloblist in the format described in the firmware handoff [0] ?

> +config OF_BLOBLIST
> +	bool "DTB is provided by a bloblist"
> +	help
> +	  Select this to read the devicetree from the bloblist. This allows
> +	  using a bloblist to transfer the devicetree between  U-Boot phases.
> +	  The devicetree is stored in the bloblist by an early phase so that
> +	  U-Boot can read it.
> +

I dont think this is a good idea.  We used to have 4-5 different options
here, which we tried to clean up and ended up with two very discrete
options.  Why do we have to reintroduce a new one?  Doesn't that bloblist
have a header of some sort?  The bloblist literally comes from a previous
stage bootloader which is what OF_BOARD is here for. So why can't we just
read the header and figure out if the magic of the bloblist matches?

>  config OF_BOARD
>  	bool "Provided by the board (e.g a previous loader) at runtime"
>  	default y if SANDBOX || OF_HAS_PRIOR_STAGE
> diff --git a/include/bloblist.h b/include/bloblist.h
> index 080cc46a126..e16d122f4fb 100644
> --- a/include/bloblist.h
> +++ b/include/bloblist.h
> @@ -103,6 +103,11 @@ enum bloblist_tag_t {
>  	BLOBLISTT_ACPI_TABLES = 0x104,	/* ACPI tables for x86 */
>  	BLOBLISTT_SMBIOS_TABLES = 0x105, /* SMBIOS tables for x86 */
>  	BLOBLISTT_VBOOT_CTX = 0x106,	/* Chromium OS verified boot context */
> +	/*

[...]

> 
[0] https://github.com/FirmwareHandoff/firmware_handoff

Thanks
/Ilias
