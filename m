Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75D6EC10F1A
	for <u-boot@archiver.kernel.org>; Thu, 25 Apr 2024 06:19:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D6AD88EF4;
	Thu, 25 Apr 2024 08:19:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="T/3OS+fF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74DBC88EF6; Thu, 25 Apr 2024 08:19:46 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E6B588EF2
 for <u-boot@lists.denx.de>; Thu, 25 Apr 2024 08:19:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-56e37503115so497348a12.1
 for <u-boot@lists.denx.de>; Wed, 24 Apr 2024 23:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714025984; x=1714630784; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=9ut19bRwG2fmkujRzCgC3FHO+3xt++a07yprq43roIQ=;
 b=T/3OS+fF38CB6swvkECS2zFHkMiYO/ZnXN5kHnIopVnpeo6ZgWX8z+EwDvdLPoLvl0
 g4hZnZMLrdoPq+gZXLd9FDsKukepv+kvxSPso2ZrFHUrOuOg9tL+mw4KaaYMu169bgyX
 Ztac4BOUK9oMSV5SaMNm1RlqZ6MZFiiDJG7nsYkAZzUXpd5m32/e4MoFat9690YtmdiI
 7y3+eKSTB3uvoOVrAz5TbBPiG+Pti1mQyUnAY3AID1NDhhycTPlLWFipL5R8KTQFqylM
 +I8f3d0uLIcdcaIAJtX49tBvXmDx9nMcUNLHHZ9lQCRi+V1ME85/Becxcd6aROXWb8V2
 lMIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714025984; x=1714630784;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9ut19bRwG2fmkujRzCgC3FHO+3xt++a07yprq43roIQ=;
 b=h+q1dnolR0JPhdVQV86U0oTGcrgN/7XPX+/iXkxzNFEshBI7+Qahc/32KjsIX77vFt
 /tuGzl57hHc+wiVLLfhCKqLcQoFoTTcRusSsVAG6/xrgXYmBwOZ3ozMblFgaGHzb4noz
 uqTY3hoeTybXvG0B8/nt5ExU9VtHgmlTKIcah75egd7eETmVmvvRqVHIO2XsInCWnqLf
 pcb+pyxpurUqoJmBdVKvYnRI/ZlTlcMaLD3wvYngr6a46vPLen3C6daxoyYXOTi917KY
 24evkeRc2lYj7Vy7kx3m0sFGjxXM7pcE4ommlIdDpsOgSKlSzRmnO0PZ+u3l6H7M+KeB
 zGmw==
X-Gm-Message-State: AOJu0YwxzjL7V0COj0vH2AVLD8XJsw93lMKZD/0Jzl9QuGbBrbFZBvF6
 Aic4OSwa4IrqlZoDLAk17Yf5G/mB4vV0ZUzuBgR08WxWPEtefH1U15yXI0440GsexCyxCNK137C
 /CDIg7hGU4CMIt5X9myyrfAS4KAgmuKen2nNsM/NTjU0OauJFO7iHFg==
X-Google-Smtp-Source: AGHT+IEYT4AocLYEhnXanfp+eQCj5ToVzkbHiGIH5Z0Cl1dTrnO61GjkT0qETOVZ7cFvvPC0HjlmJiy0pbDP5YZIumk=
X-Received: by 2002:a17:907:9689:b0:a52:3adb:e407 with SMTP id
 hd9-20020a170907968900b00a523adbe407mr3797677ejc.37.1714025983891; Wed, 24
 Apr 2024 23:19:43 -0700 (PDT)
MIME-Version: 1.0
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 25 Apr 2024 09:19:07 +0300
Message-ID: <CAC_iWjJNHa4gMF897MqYZNdbgjFG8K4kwGsTXWuy72WkYLizrw@mail.gmail.com>
Subject: Capsule GUIDs and LVFS
To: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Richard Hughes <hughsient@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Jagan Teki <jagan@amarulasolutions.com>, Jonas Karlman <jonas@kwiboo.se>, 
 FUKAUMI Naoki <naoki@radxa.com>, chris.obbard@collabora.com, 
 Paul Liu <paul.liu@linaro.org>, Heiko Thiery <heiko.thiery@gmail.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Michael Walle <michael@walle.cc>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>, 
 U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, 
 Michal Simek <michal.simek@amd.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi,

Richard maintains LVFS & fwupd, commonly used for firmware upgrades.
We recently discussed the U-Boot status and supported devices since
fwupd supports capsule updates.
In order to be able to support capsule updates via LVFS manufacturers
should bind their GUIDs to their devices. Any ODM/OEM creating a board
based on the original device must use his own
GUIID to avoid confusion. If not we would end up with different
devices reusing the same GUIDs and upgrading their firmware with a
different one.

Looking at the defined GUIDS for capsule updates defined in board
support files I found the following

Richard, the following GUIDs should at least issue a warning in LVFS
since they only work for QEMU & Sandbox internally.
Sandbox SANDBOX_UBOOT_IMAGE_GUID 09d7cf52-0720-4710-91d1-08469b7fe9c8
Sandbox SANDBOX_UBOOT_ENV_IMAGE 5a7021f5-fef2-48b4-aaba-832e777418c0
Sandbox SANDBOX_FIT_IMAGE_GUID 3673b45d-6a7c-46f3-9e60-adabb03f7937
QEMU QEMU_ARM_UBOOT_IMAGE_GUID f885b085-99f8-45af-847d-d514107a4a2c
QEMU QEMU_ARM64_UBOOT_IMAGE 058b7d83-50d5-4c47-a195-60d86ad341c4

I've cc'ed all the people I could find in board specific MAINTAINER files.
Can you respond to Richard with the proper company name & board name
so we can bind the following GUIDs to a vendor properly?
Richard any guidance on how this should be done properly is
appreciated, since I am not too aware of LVFS internals.

Advantech IMX8MP_RSB3720A1 b1251e89-384a-4635-a806-3aa0b0e9f965
Advantech IMX8MP_RSB3720A1_6G b5fb6f08-e142-4db1-97ea-5fd36b9be5b9

Compulab IMX8MM_CL_IOT_GATE 7a32a939-ab92-467b-9152-74771b95e646
Compulab MX8MM_CL_IOT_GATE_OPTEE_FIT 0bf1165c-1831-4864-945e-ac3d3848f499

Kontron KONTRON_PITX_IMX8M_FIT_IMAGE_GUID c898e959-5b1f-4e6d-88e0-40d45cca1399
Kontron KONTRON_SL_MX8MM_FIT_IMAGE_GUID d488e45a-4929-4b55-8c14-86cea2cd6629
Kontron KONTRON_SL28_FIT_IMAGE_GUID 86ebd44f-feb8-466f-8bb8-890618456d8b

Radxa ROCKPI_4B_IDBLOADER_IMAGE_GUID 02f4d760-cfd5-43bd-8e2d-a42acb33c660
Radxa ROCKPI_4B_UBOOT_IMAGE_GUID 4ce292da-1dd8-428d-a1c2-77743ef8b96e
Radxa ROCKPI_4C_IDBLOADER_IMAGE_GUID fd68510c-12d3-4f0a-b8d3-d879e1d3a540
Radxa ROCKPI_4C_UBOOT_IMAGE_GUID b81fb4ae-e4f3-471b-99b4-0b3da549ce13

Socionext DEVELOPERBOX_FIP_IMAGE_GUID 7d6dc310-52ca-43b8-b7b9-f9d6c501d108
Socionext DEVELOPERBOX_FIP_IMAGE_GUID2 880866e9-84ba-4793-a908-33e0b916f398

STMicroelectronics STM32MP_FIP_IMAGE_GUID 19d5df83-11b0-457b-be2c-7559c13142a5
This seems to use the same GUID for multiple device variants. This
needs to be fixed

AMD/Xilinx XILINX_BOOT_IMAGE_GUID 20c5fba5-0171-457f-b9cd-f5129cd07228
AMD/Xilinx XILINX_UBOOT_IMAGE_GUID cf9ecfd4-938b-41c5-8551-1f883ab7dc18
ditto

Regards
/Ilias
