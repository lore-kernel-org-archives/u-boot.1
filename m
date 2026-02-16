Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA8CEE7BDA9
	for <u-boot@archiver.kernel.org>; Mon, 16 Feb 2026 12:09:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A8A980FA1;
	Mon, 16 Feb 2026 13:09:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="N8CDFkqL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C72BB83AAB; Mon, 16 Feb 2026 13:09:24 +0100 (CET)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42D198063E
 for <u-boot@lists.denx.de>; Mon, 16 Feb 2026 13:09:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-797d36fdb96so5727247b3.1
 for <u-boot@lists.denx.de>; Mon, 16 Feb 2026 04:09:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771243761; cv=none;
 d=google.com; s=arc-20240605;
 b=b6EJVLKxZFWT3nSlG9VZstY+uyE9gGS1Y5aDqv81RqElwSOqDx4UyRYHBMr0TGA87I
 3EghBerev6eyt97+FfPLb2nJzNVO7Tn7PaqdeWK9MrL/1Tyien5r+7x/gMngUZZDj9xq
 UdEE1KPwuYcmTu3Godg1QCuJ11sbKMMzOGZlGW0yktGYVaG+iFeE9jdpnwkM+I+ftgXR
 7siQokIgAvMYYtW1JpjpyyTXQM0/4gz641La7F0AN3BdgiWL4Z1NpW6j1BVOf86CSs5z
 sO/aI9RMfKlAOVWQf2yJXQPxTvIAdKdaktwSiBIYStCDBklszAlcwGtweU5pjF37XioX
 gyLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=z3tuLjgqJvO5tiCFoKq5ax3tipwaLZHId047AamqAk4=;
 fh=5DmQ4CIV7EtPGXxp0Jvb/Po9rSCEfYfzmSlEeODDAWA=;
 b=QbZjm9jvEFE3XQljbMJpYSEYABZRFIa6QPj42lwlQQLhklbEb+BPKnnxWMtY8+yTV5
 59udBTFLyLb+Ji8oSKFZuU7zckjTnKO8k9F4sv29tcroFV5ZsT1/94U8quwFZzG0BjFV
 nCX0cpfmLkDMxZAfH4o9BiKHt2gbfpTpq6E0nYLpxSGkMYzny/lLeYUk31VogcDu7aQa
 GiJYozVkEdIHOkHaT4X3nVYAbOZWOWRaaeAqQJ6h4Axw2a3mDbXLA9vpm3pjcWw69rpo
 quZrt9kqQcTM1K+cFx1HcSvEfOUrwIZXxgQq3chuF0DeinAFn6etm9iN2W/Knme8iwzL
 kJ/w==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771243761; x=1771848561; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=z3tuLjgqJvO5tiCFoKq5ax3tipwaLZHId047AamqAk4=;
 b=N8CDFkqLMSo/HZOK2lWtzxHXKaJILjXnwjzWGiIqIz4tSywsB081zQI7zForJeqxuD
 KwRwHyRgJHLP5SAb2nykVqjGJDXXfJaC1jFO48M6KJ/8Qafcp6CTM+5DCWR43LEfnwXw
 Uu+D+p/1HtX6yZ0EbZ0t7K5XsyIMGRhV0d5GBe0CJZe28OidTXALSIsDysJDkigUTzkK
 2X7QrTTSmLIQ2XKpiAsmZZvRLQA27BWKevIuk6nRzgSEf+42tzyW6B+U8Kh1hL1W4yyR
 zM4lAfhi2LHA9Pvbm4J/t77u/iST1/ceJmuc1zupGUTe+EbAVuHcf8kzjRVrmMA5NIWg
 EiXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771243761; x=1771848561;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z3tuLjgqJvO5tiCFoKq5ax3tipwaLZHId047AamqAk4=;
 b=LfUW/3oK/iItwC5V0nzsuxUkLEohiwotVg1J97LTs93yt7WI7v1cxiOMWWDDN+2T9a
 imUpFeQxRgLoYLudCxMZexj9hakFaQyyp3px3TMnI3svw0dtfUuaTTip2iZlOwbKeUOt
 ERyMtshAVOPWwr03fqsismTNJnUPm1TSvc6M3JQ12+x+KNhFFea477sqWLrL/9CE8/+1
 2nPqr8M7o+BtBKQi7qWq/6mJ7LaNqPJzOvis8yolms/lAvcInZO5dK5yCibhjJQYn6o3
 Snsbwm6c3324250OT6rgcYchHB06vgx/+XWlecQfWkOnfdINvWgJm0n5ohyM2zkphr+n
 nZWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqyjjXP1CXG88qN55lgORlGrrlSImra1ZzCOtoKobEXbznZN5zXACVPyer5MDYWcC/Pblsk7w=@lists.denx.de
X-Gm-Message-State: AOJu0Yx+kH4VxldldZ0cAS07uH96UFDVQ7vARRr3wb/F+b7SIDKMSurf
 KpEXsRxQxFVMouNQwgCdHTnEyUUMOygekpJRCjy7x6eDgOqNVlAtOazFVN9nuLIsBB/sfQkjmmr
 KBtSFf4gNTBzTsjYtr1ZwvOQuF+8CXUJOJ1DqWn8xtw==
X-Gm-Gg: AZuq6aJ31HARvxwrCfTJPwd8lW3/zXfMwof9P2p3dBt74gd6N76SIrTo/VEWegkHB+z
 6BBYPae0Ss0O9yQJWPFsEDycGtQHY6/m2/cK26xFF6dP1/8kE4I64f2H9I9TWZ/FxCNTsJM/cSY
 bE5aGqWK32/mLA41lmlT03a+oa5L0apLhS3PtFCg5Cxcb4TVTKqEhW4kVX/w0dIWYjz5y9jQ18X
 1B7ADq4R04mtymycVE07s4z3Ko12Icchu4VcygMS/DFuO5QEa/e8BAdRjvMpEUoXM953kgkKFjr
 5buMaNA3Ex+mWSYYOl5GkBKFwJ9mBZ7aEf0q+cmNoXR6c/4rFP1TpcTqrMt7UUglD4gelOOa2lG
 Hpn5dXlh6YJ7fpZsIPAeNHxuEThyffVH4n+I/y2d66RtCu1HBi/EfpkwDtxyQV7WuRjtuT7K0BO
 do0iNgfACbVPJeB1gS0iMffIJmFXPwogNZnB+tY9xfcPBolcW6KXoJ1PgRVLlOGRUpcixTjonxo
 tS3fj0J9epX6zEF/sqJz5hETEnvwEcBLMgmWWzqKUJlIhoUUXDHRozcXeYyWZ1Clk3Dnl9d5uss
 k8FUQWlHl2BCiDeenuXXZ/8Z8kAtasVOyRFLKSRZynz3bI+D9/5ur+o=
X-Received: by 2002:a53:d015:0:b0:64a:d18a:66c3 with SMTP id
 956f58d0204a3-64c202f1584mr5626766d50.48.1771243760557; Mon, 16 Feb 2026
 04:09:20 -0800 (PST)
MIME-Version: 1.0
References: <cover.1770825377.git.michal.simek@amd.com>
 <35ddf2fe394ee55c66f349dc5cc33fe1dda8f864.1770825377.git.michal.simek@amd.com>
 <1508c7be-0700-43ec-adfa-29ea16081b2f@gmx.de>
 <e5c63fcb-c88b-4550-bf5c-de46a66db0a2@amd.com>
 <E2042B0B-0842-4FC0-B4A8-49D195E5A532@gmx.de>
In-Reply-To: <E2042B0B-0842-4FC0-B4A8-49D195E5A532@gmx.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 16 Feb 2026 14:08:44 +0200
X-Gm-Features: AZwV_Qgt3Yf37u0GunfPMDP6fxSW_2NC8UjQhh8_-I1E_jDWwl3WX36hFA8VSx4
Message-ID: <CAC_iWjLuCLQ7qNajbY_i-sVZdc2J+8rNPgsA56A7q1O8x3EEaw@mail.gmail.com>
Subject: Re: [PATCH v8 4/4] efi_vars: Implement SPI Flash store
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Michal Simek <michal.simek@amd.com>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
 Shantur Rathore <i@shantur.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Jonathan Humphreys <j-humphreys@ti.com>, Simon Glass <sjg@chromium.org>, 
 Sughosh Ganu <sughosh.ganu@arm.com>, Tom Rini <trini@konsulko.com>, 
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>, git@amd.com,
 u-boot@lists.denx.de
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

On Mon, 16 Feb 2026 at 13:39, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> Am 16. Februar 2026 08:24:19 MEZ schrieb Michal Simek <michal.simek@amd.com>:
> >
> >
> >On 2/15/26 09:48, Heinrich Schuchardt wrote:
> >> On 2/11/26 16:56, Michal Simek wrote:
> >>> From: Shantur Rathore <i@shantur.com>
> >>>
> >>> Currently U-Boot uses ESP as storage for EFI variables.
> >>> Devices with SPI Flash are used for storing environment with this
> >>> commit we allow EFI variables to be stored on SPI Flash.
> >>>
> >>> https://github.com/rhboot/efivar
> >>> is not updated to support this location that's why you can mimic it by
> >>> running:
> >>> dd if=/sys/firmware/efi/efivars/VarToFile-b2ac5fc9-92b7-4acd-aeac-11e818c3130c \
> >>>     of=/tmp/vars skip=4 bs=1
> >>> flashcp /tmp/vars /dev/mtdX
> >>>
> >>> where mtdX should match location defined by
> >>> CONFIG_EFI_VARIABLE_SF_OFFSET/CONFIG_EFI_VAR_BUF_SIZE.
> >>>
> >>> Signed-off-by: Shantur Rathore <i@shantur.com>
> >>> Signed-off-by: Michal Simek <michal.simek@amd.com>
> >>> Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on AML-S905D3-CC
> >>> Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> >>>
> >>> ---
> >>>
> >>> Changes in v8:
> >>> - Add missing EFI_VARIABLE_SF_STORE dependency to EFI_VARIABLE_SF_DEVICE_INDEX
> >>>
> >>> Changes in v7:
> >>> - sed -i 's/efi_var_from/efi_var_from_storage/g'
> >>>
> >>> Changes in v6:
> >>> - sed -i 's/efi_var_read/efi_var_from/g'
> >>> - sed -i 's/efi_var_write/efi_var_to_storage/g'
> >>>
> >>> Changes in v4:
> >>> - Extend Kconfig description
> >>> - Extend commit message and describe efivar missing part
> >>> - use unify methods for reading/writing variable
> >>>
> >>> Changes in v3:
> >>> - Fixed compiler warnings.
> >>>
> >>> Changes in v2:
> >>> - Refactored efi_var_file to move common parts out as requested
> >>> - Changed ifdefs to use CONFIG_IS_DEFINED
> >>> - Fixed typos
> >>>
> >>>   lib/efi_loader/Kconfig      | 35 +++++++++++++-
> >>>   lib/efi_loader/Makefile     |  1 +
> >>>   lib/efi_loader/efi_var_sf.c | 92 +++++++++++++++++++++++++++++++++++++
> >>>   3 files changed, 127 insertions(+), 1 deletion(-)
> >>>   create mode 100644 lib/efi_loader/efi_var_sf.c
> >>>
> >>> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> >>> index 579eed658801..0f6f927ddaf1 100644
> >>> --- a/lib/efi_loader/Kconfig
> >>> +++ b/lib/efi_loader/Kconfig
> >>> @@ -124,6 +124,24 @@ config EFI_VARIABLE_FILE_STORE
> >>>         Select this option if you want non-volatile UEFI variables to be
> >>>         stored as file /ubootefi.var on the EFI system partition.
> >>> +config EFI_VARIABLE_SF_STORE
> >>> +    bool "Store non-volatile UEFI variables in SPI Flash"
> >>> +    depends on SPI_FLASH
> >>> +    help
> >>> +      Select this option if you want non-volatile UEFI variables to be
> >>> +      stored in SPI Flash.
> >>> +
> >>> +      Define CONFIG_EFI_VARIABLE_SF_OFFSET as offset in SPI Flash to use as
> >>> +      the storage for variables. CONFIG_EFI_VAR_BUF_SIZE defines the space
> >>> +      needed.
> >>> +
> >>> +      Note that SPI Flash devices have a limited number of program/erase
> >>> +      cycles. Frequent updates to UEFI variables may cause excessive wear
> >>> +      and can permanently damage the flash device, particularly on SPI NAND
> >>> +      or low-end SPI NOR parts without wear leveling. This option should be
> >>> +      used with care on such systems, and is not recommended for platforms
> >>> +      where UEFI variables are updated frequently.
> >>> +
> >>>   config EFI_MM_COMM_TEE
> >>>       bool "UEFI variables storage service via the trusted world"
> >>>       depends on OPTEE
> >>> @@ -153,7 +171,7 @@ endchoice
> >>>   config EFI_RT_VOLATILE_STORE
> >>>       bool "Allow variable runtime services in volatile storage (e.g RAM)"
> >>> -    depends on EFI_VARIABLE_FILE_STORE
> >>> +    depends on EFI_VARIABLE_FILE_STORE || EFI_VARIABLE_SF_STORE
> >>
> >> Hello Michal,
> >>
> >> If the backend store is SPI flash, we should not publish the variable "RTStorageVolatile" at runtime as currently defined.
> >>
> >> For the background see this commit for the efivar library:
> >>
> >> https://github.com/rhboot/efivar/commit/68daa04654acbe1bbaa17ebfc23c371b39e69c6b
> >>
> >> The first three patches look correct to me and I will add them to a merge request for efi-next.
> >
> >Do I read it that when I don't allow to select EFI_RT_VOLATILE_STORE you will be fine with the patch itself?
>
> This was my only concern.

Thinking about it again, this is the right thing to do right now.
efivar will try to create a file in the ESP if the speacial variables
in linux are found. So we are better off disabling this option for SPI
variables atm

Cheers
/Ilias
>
> Maybe setting the file name to /dev/mtd/by-name/<partition name> would work with efivar. But I have not tested it.
>
> In U-Boot we could replace EFI_VARIABLE_SF_DEVICE_INDEX, SIZE, and OFFSET by a partition name, too. That way it would be the common device-tree for U-Boot and Linux controlling the placement of the variables store.
>
> >
> >
> >> The usage of efi_var_mem_ins() and efi_var_mem_del() when SetVariable() does not change anything is not flash-friendly. Michal, do you want to have a look at this area?
> >
> >That's known limitation describe in EFI_VARIABLE_SF_STORE Kconfig Note.
>
> This could be a topic for future work.
>
> Best regards
>
> Heinrich
>
