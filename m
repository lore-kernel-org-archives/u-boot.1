Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C440FC4345F
	for <u-boot@archiver.kernel.org>; Fri, 26 Apr 2024 06:10:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 38D0C88FB3;
	Fri, 26 Apr 2024 08:10:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="JiWHZgjh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 860238908C; Fri, 26 Apr 2024 08:10:35 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A75F88F35
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 08:10:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-56e477db7fbso2526726a12.3
 for <u-boot@lists.denx.de>; Thu, 25 Apr 2024 23:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714111833; x=1714716633; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=mTNYO/ovQ9PxWFEGcpb51BScsAELL9ZHM5aGg0e4z5Q=;
 b=JiWHZgjhuqyw+xh0viMQFDc6Q6flC4t+PWy/FG5MN6U4shjm3uX1Jm6QMqPraFXiUV
 CItijPuexGO7bh7xbBBJwHv3FNPiXZwJMxOQ/6UPabVo7M/YaLSARJh9KjbhUQLLVzRp
 kju2O+4S+4lKMntcuZy81YjgrQ03IbBq6UURdy815ZgzcmIw1hBQwq+NQlbB2fpOciaE
 kkpDrY+DhsgTmWfUF6PixIG6P/4Ck7ablTZMFkLv693/Suf8l13KcpESiCZD7YAPsoUV
 bR8h0c6Y/bCJVGMjCH3USms0JmdK20vu+sP6PELaoSTSMVchw942bBPIv3GPMR2og8v5
 K+1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714111833; x=1714716633;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mTNYO/ovQ9PxWFEGcpb51BScsAELL9ZHM5aGg0e4z5Q=;
 b=lHauvCLj1/VK9UvF6YQMMi/XmG51OP/22LDUnHB1G75pZ0nnqZw2Ex+36eQ6iLbhM6
 jAyA2kwQy/7mQexNCjEO9KJCd+nkmG6yAfGwqI8oBF0qERz+pC7tKFenJPS7n6e9QSSo
 /szWf/nNMYwkr/aCGvNHoYBe0hpKzeUgHClyzwseDpwIKxFu0oMIfa4W9TSLZdgsZEYB
 UrKHoAjH63COvt8eFLjpqiahavjUa2J+O0hrj/KNly14Qa+b8vdmyvNNt+7y0sFs1VH6
 lJHOGDTaO0Qc13c4eagtNCQ9ZcjmIY0iDde9sWfNfOXhaagnnc05vjFD/uDzxDCp9qBJ
 qcDQ==
X-Gm-Message-State: AOJu0YxC5OgipUBOvE0fpELWEGxpA59jjHEA0DMOxYZcAIChFQmA9GmU
 KmNCwgBd29qVNXHwLl03YkzUYJUxoiBIwEWDmZARL0pz1Q0i5lDdMsoGUa4Y36o=
X-Google-Smtp-Source: AGHT+IEOlK3fEIqdu02p5XPd2pih8GlWY2oohvGCCGtuQzX95+poDdIrpysgs1Kx/x8keiuEh8BfDg==
X-Received: by 2002:a17:906:6a8d:b0:a58:308:274c with SMTP id
 p13-20020a1709066a8d00b00a580308274cmr1212883ejr.21.1714111832782; 
 Thu, 25 Apr 2024 23:10:32 -0700 (PDT)
Received: from hera (ppp089210108048.access.hol.gr. [89.210.108.48])
 by smtp.gmail.com with ESMTPSA id
 z2-20020a17090665c200b00a55bbc4fd16sm5346398ejn.48.2024.04.25.23.10.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Apr 2024 23:10:32 -0700 (PDT)
Date: Fri, 26 Apr 2024 09:10:29 +0300
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: Michal Simek <michal.simek@amd.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Tom Rini <trini@konsulko.com>, Richard Hughes <hughsient@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Jonas Karlman <jonas@kwiboo.se>, FUKAUMI Naoki <naoki@radxa.com>,
 chris.obbard@collabora.com, Paul Liu <paul.liu@linaro.org>,
 Heiko Thiery <heiko.thiery@gmail.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Michael Walle <michael@walle.cc>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>
Subject: Re: Capsule GUIDs and LVFS
Message-ID: <ZitFVXtpcjFuQbGi@hera>
References: <CAC_iWjJNHa4gMF897MqYZNdbgjFG8K4kwGsTXWuy72WkYLizrw@mail.gmail.com>
 <f3abe7a1-72bd-4d63-89b4-3a8f742a5d73@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3abe7a1-72bd-4d63-89b4-3a8f742a5d73@amd.com>
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

On Thu, Apr 25, 2024 at 09:18:31AM +0200, Michal Simek wrote:
> Hi,
>
> On 4/25/24 08:19, Ilias Apalodimas wrote:
> > Hi,
> >
> > Richard maintains LVFS & fwupd, commonly used for firmware upgrades.
> > We recently discussed the U-Boot status and supported devices since
> > fwupd supports capsule updates.
> > In order to be able to support capsule updates via LVFS manufacturers
> > should bind their GUIDs to their devices. Any ODM/OEM creating a board
> > based on the original device must use his own
> > GUIID to avoid confusion. If not we would end up with different
> > devices reusing the same GUIDs and upgrading their firmware with a
> > different one.
> >
> > Looking at the defined GUIDS for capsule updates defined in board
> > support files I found the following
> >
> > Richard, the following GUIDs should at least issue a warning in LVFS
> > since they only work for QEMU & Sandbox internally.
> > Sandbox SANDBOX_UBOOT_IMAGE_GUID 09d7cf52-0720-4710-91d1-08469b7fe9c8
> > Sandbox SANDBOX_UBOOT_ENV_IMAGE 5a7021f5-fef2-48b4-aaba-832e777418c0
> > Sandbox SANDBOX_FIT_IMAGE_GUID 3673b45d-6a7c-46f3-9e60-adabb03f7937
> > QEMU QEMU_ARM_UBOOT_IMAGE_GUID f885b085-99f8-45af-847d-d514107a4a2c
> > QEMU QEMU_ARM64_UBOOT_IMAGE 058b7d83-50d5-4c47-a195-60d86ad341c4
> >
> > I've cc'ed all the people I could find in board specific MAINTAINER files.
> > Can you respond to Richard with the proper company name & board name
> > so we can bind the following GUIDs to a vendor properly?
> > Richard any guidance on how this should be done properly is
> > appreciated, since I am not too aware of LVFS internals.
> >
> > Advantech IMX8MP_RSB3720A1 b1251e89-384a-4635-a806-3aa0b0e9f965
> > Advantech IMX8MP_RSB3720A1_6G b5fb6f08-e142-4db1-97ea-5fd36b9be5b9
> >
> > Compulab IMX8MM_CL_IOT_GATE 7a32a939-ab92-467b-9152-74771b95e646
> > Compulab MX8MM_CL_IOT_GATE_OPTEE_FIT 0bf1165c-1831-4864-945e-ac3d3848f499
> >
> > Kontron KONTRON_PITX_IMX8M_FIT_IMAGE_GUID c898e959-5b1f-4e6d-88e0-40d45cca1399
> > Kontron KONTRON_SL_MX8MM_FIT_IMAGE_GUID d488e45a-4929-4b55-8c14-86cea2cd6629
> > Kontron KONTRON_SL28_FIT_IMAGE_GUID 86ebd44f-feb8-466f-8bb8-890618456d8b
> >
> > Radxa ROCKPI_4B_IDBLOADER_IMAGE_GUID 02f4d760-cfd5-43bd-8e2d-a42acb33c660
> > Radxa ROCKPI_4B_UBOOT_IMAGE_GUID 4ce292da-1dd8-428d-a1c2-77743ef8b96e
> > Radxa ROCKPI_4C_IDBLOADER_IMAGE_GUID fd68510c-12d3-4f0a-b8d3-d879e1d3a540
> > Radxa ROCKPI_4C_UBOOT_IMAGE_GUID b81fb4ae-e4f3-471b-99b4-0b3da549ce13
> >
> > Socionext DEVELOPERBOX_FIP_IMAGE_GUID 7d6dc310-52ca-43b8-b7b9-f9d6c501d108
> > Socionext DEVELOPERBOX_FIP_IMAGE_GUID2 880866e9-84ba-4793-a908-33e0b916f398
> >
> > STMicroelectronics STM32MP_FIP_IMAGE_GUID 19d5df83-11b0-457b-be2c-7559c13142a5
> > This seems to use the same GUID for multiple device variants. This
> > needs to be fixed
> >
> > AMD/Xilinx XILINX_BOOT_IMAGE_GUID 20c5fba5-0171-457f-b9cd-f5129cd07228
>
> this is versal GUID
>
> > AMD/Xilinx XILINX_UBOOT_IMAGE_GUID cf9ecfd4-938b-41c5-8551-1f883ab7dc18
> > ditto
>
> And this is ZYNQMP one but that's just a note.

Ah thanks, I know you already added the correct ones on the excel, pasting
the update list here as well

IMX8MP_RSB3720A1 b1251e89-384a-4635-a806-3aa0b0e9f965
IMX8MP_RSB3720A1_6G b5fb6f08-e142-4db1-97ea-5fd36b9be5b9
IMX8MM_CL_IOT_GATE 7a32a939-ab92-467b-9152-74771b95e646
IMX8MM_CL_IOT_GATE_OPTEE_FIT 0bf1165c-1831-4864-945e-ac3d3848f499
QEMU_ARM64_UBOOT_IMAGE 058b7d83-50d5-4c47-a195-60d86ad341c4
KONTRON_PITX_IMX8M_FIT_IMAGE_GUID c898e959-5b1f-4e6d-88e0-40d45cca1399
KONTRON_SL_MX8MM_FIT_IMAGE_GUID d488e45a-4929-4b55-8c14-86cea2cd6629
KONTRON_SL28_FIT_IMAGE_GUID 86ebd44f-feb8-466f-8bb8-890618456d8b
ROCKPI_4B_UBOOT_IMAGE_GUID 4ce292da-1dd8-428d-a1c2-77743ef8b96e
ROCKPI_4C_IDBLOADER_IMAGE_GUID fd68510c-12d3-4f0a-b8d3-d879e1d3a540
ROCKPI_4C_UBOOT_IMAGE_GUID b81fb4ae-e4f3-471b-99b4-0b3da549ce13
SANDBOX_UBOOT_IMAGE_GUID 09d7cf52-0720-4710-91d1-08469b7fe9c8
SANDBOX_UBOOT_ENV_IMAGE 5a7021f5-fef2-48b4-aaba-832e777418c0
SANDBOX_FIT_IMAGE_GUID 3673b45d-6a7c-46f3-9e60-adabb03f7937
DEVELOPERBOX_FIP_IMAGE_GUID 7d6dc310-52ca-43b8-b7b9-f9d6c501d108
DEVELOPERBOX_FIP_IMAGE_GUID2 880866e9-84ba-4793-a908-33e0b916f398
STM32MP_FIP_IMAGE_GUID 19d5df83-11b0-457b-be2c-7559c13142a5
XILINX_BOOT_IMAGE_GUID_ZYNQMP de6066e8-0256-4fad-8238-e406e274c4cf
XILINX_UBOOT_IMAGE_GUID_ZYNQMP cf9ecfd4-938b-41c5-8551-1f883ab7dc18
XILINX_BOOT_IMAGE_GUID_ZYNQ 1ba29a15-9969-40aa-b424-e86121618664
XILINX_UBOOT_IMAGE_GUID_ZYNQ 1a5178f0-87d3-4f36-ac63-3b31a23be305

Thanks
/Ilias
>
> What has to happen at least in our case when LVFS is used, we need to
> generate new GUIDs for every board because we can't use the same GUIDs for
> all boards.
>
> Thanks,
> Michal
