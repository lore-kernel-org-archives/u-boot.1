Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F08E7C25B75
	for <u-boot@archiver.kernel.org>; Wed, 15 May 2024 19:58:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 135E5882DC;
	Wed, 15 May 2024 21:58:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="QnUxVmbb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D3A2D882FE; Wed, 15 May 2024 21:58:13 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73CDF882DC
 for <u-boot@lists.denx.de>; Wed, 15 May 2024 21:58:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-41f9ce16ed8so71947775e9.0
 for <u-boot@lists.denx.de>; Wed, 15 May 2024 12:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1715803091; x=1716407891; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AwxEM5cCxdPozzvRejTbGlcXnNtEBM4GAg95F08wviY=;
 b=QnUxVmbbUDs5ojESCZxjbzfDVKPy5spF6PfgUL+nZraqCB5/Vuftr7brTrHcLgrW4K
 ZbrwIN+HYJTfqe+qtAEit8gJ2/mYOuiL+roAntd6vtngTMQu0zHh1vDwDuOvbEO9jhK/
 YZY6Gsz/i5N+UTGGrDocC2zv5vxGHAUxtVp4WL4FPqOWc6bhCSXON0ntY/oPkTtAKWNg
 A0Xz5EwFrxci4TV9UFPOP8RKhUojOZfCGhz2tGDo3SOgE5/drawPTGFJ1Yd79DdH1OEk
 5coWg2LQXZZqKbpsoG7YGfZ9yg62f6pfEWMsIRUvdK2DTzMh0ctolga1ySRO0Am7LAYC
 /qUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715803091; x=1716407891;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AwxEM5cCxdPozzvRejTbGlcXnNtEBM4GAg95F08wviY=;
 b=dXHvjbH9vlLnCaNYldZZcM0p4SB2nMOL54OsypGJudVSpwEDc5ooE9BKdocuk+B6eM
 0Lh8ArDLGQz4afRKnSomTM6vOnZ5RgtLb55Mhxi0K+WdM1gOAvMbtvbioEqXJKHPInPt
 deUplKYhtWI3Kma7IzD2Xc70pgt6NVqieS9QoaIEThrmwT7NNztkTcV7pOor3aGnHd1/
 b5Xg1KyoXRfTQLsxrM7NVtYw8suPirhbvSf2NGW95GcH1zdqBbcTiLXFufDvd3N0lnD4
 W2pq2FARBVV/1oFphOqiRBfXLq/Ry1gGFV0j5Hk/OOAtTBOSTF1xJtJ9tu1J6EabcY3U
 p5yg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUa//MmrwsW31YdMIHWCo/9na4WwPqi8jq4K1p1kz0K5QossHayteBkRc1Z7APF4hryCSRCdHPcFZ59oWQYfmsF4VYCvQ==
X-Gm-Message-State: AOJu0YzqggWh5dGSaL/OTpxe/O/NxenOG7GUtTPqLy27Dm9NKZod2vmD
 VSecejLzzYKqBBDHm/Da7UOCJ4KGKmk6uUQnklbYIY6x9wDm5H+2opmZvo9FcS9KzjeRM8OTRwJ
 yEdSBm9s1YiwxuJ6/9Q5W5Vh9Vwi948LXvcVYXg==
X-Google-Smtp-Source: AGHT+IFp+SvJHmfB60xwqBMt4rjSFOBp/xQTEm7p6tTcn1rb4WqUWLLqCBqSus7oBtvsjmB1PAWjvE/2Vu80DGkbeLM=
X-Received: by 2002:a5d:6e87:0:b0:34d:a9ff:7ebf with SMTP id
 ffacd0b85a97d-3504a73725bmr14714656f8f.22.1715803090859; Wed, 15 May 2024
 12:58:10 -0700 (PDT)
MIME-Version: 1.0
References: <20240515002248.2920155-1-tharvey@gateworks.com>
 <039c0adc-3014-4ae7-99b3-0df9e5366b79@denx.de>
 <b16b85dc-90bf-463b-a206-06d98c3c1f0e@gmx.de>
In-Reply-To: <b16b85dc-90bf-463b-a206-06d98c3c1f0e@gmx.de>
From: Tim Harvey <tharvey@gateworks.com>
Date: Wed, 15 May 2024 12:57:58 -0700
Message-ID: <CAJ+vNU2yjkFpz4-WUDzJtwnsm4yi4mLk3HMK6J7J_Y38c6C2Sw@mail.gmail.com>
Subject: Re: [PATCH] fdt: add kaslr-seed if DM_RNG is enabled
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Devarsh Thakkar <devarsht@ti.com>, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, Eddie James <eajames@linux.ibm.com>,
 Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, May 14, 2024 at 10:17=E2=80=AFPM Heinrich Schuchardt <xypron.glpk@g=
mx.de> wrote:
>
> On 5/15/24 02:50, Marek Vasut wrote:
> > On 5/15/24 2:22 AM, Tim Harvey wrote:
> >> If RANDOMIZE_BASE is enabled in the Linux kernel instructing it to
> >> randomize the virtual address at which the kernel image is loaded, it
> >> expects entropy to be provided by the bootloader by populating
> >> /chosen/kaslr-seed with a 64-bit value from source of entropy at boot.
> >
> > Thanks for working on this one, this is really nice.
>
> The general direction of always supplying a seed for KASLR is right. But
> there are some items to observe:
>
> We already have multiple places where /chosen/kaslr-seed is set, e.g.
> arch/arm/cpu/armv8/sec_firmware.c and board/xilinx/common/board.c.
>

Hi Heinrich,

Yes, Marek pointed out the same thing about de-duplicating code. I can
add a lib/kaslrseed.c with a fdt_kaslrseed function to deduplicate the
usage.

> Some boards are using the kaslrseed command to initialize
> /chosen/kaslr-seed from DM_RNG.
>
> It does not make sense to set it multiple times from different sources
> of randomness. I am missing the necessary clean-up in this patch.
>
> For CONFIG_ARMV8_SEC_FIRMWARE_SUPPORT=3Dy the right way forward could be
> moving sec_firmware_get_random() into the driver model. Tom is the
> maintainer for this code.

ok, I will not address arch/arm/cpu/armv8/sec_firmware.c and will
protect my implementation with 'if (IS_ENABLED(CONFIG_DM_RNG) &&
!IS_ENABLED(ARMV8_SEC_FIRMWARE_SUPPORT))'

>
> For Xilinx boards your patch obsoletes part of the code in
> ft_board_setup() of board/xilinx/common/board.c. CCing Michal as maintain=
er.
>

yes, I can remove that code to deduplicate as they are using
dm_rng_read() thus users of that must have CONFIG_DM_RNG enabled.

> The kaslrseed command similarly becomes obsolete with your patch and
> should be removed. 'git grep -n CMD_KASLR' indicates which defconfigs
> would be impacted.
>

There are several users of this command currently:
$ git grep CMD_KASLR configs/
configs/evb-rk3308_defconfig:CONFIG_CMD_KASLRSEED=3Dy
configs/imx8mm_data_modul_edm_sbc_defconfig:CONFIG_CMD_KASLRSEED=3Dy
configs/imx8mp_data_modul_edm_sbc_defconfig:CONFIG_CMD_KASLRSEED=3Dy
configs/imx8mp_dhcom_pdk2_defconfig:CONFIG_CMD_KASLRSEED=3Dy
configs/imx8mp_dhcom_pdk3_defconfig:CONFIG_CMD_KASLRSEED=3Dy
configs/roc-cc-rk3308_defconfig:CONFIG_CMD_KASLRSEED=3Dy
configs/rock-pi-s-rk3308_defconfig:CONFIG_CMD_KASLRSEED=3Dy
configs/xilinx_versal_net_virt_defconfig:CONFIG_CMD_KASLRSEED=3Dy
configs/xilinx_versal_virt_defconfig:CONFIG_CMD_KASLRSEED=3Dy
configs/xilinx_zynqmp_kria_defconfig:CONFIG_CMD_KASLRSEED=3Dy
configs/xilinx_zynqmp_virt_defconfig:CONFIG_CMD_KASLRSEED=3Dy

While I can deduplicate code by calling a shared function in that
command I don't feel like I should remove that command until the
maintainers of the boards above agree on removing it from their
defconfigs as they could have bootscripts that fail with the command
missing.

I could add a warning print in the kaslrseed command indicating that
the use of this command is no longer needed.

> label_boot_kaslrseed() needs review too.
>

yes, this can be deduplicated

> kaslr-seed is not compatible with measured boot if the device-tree is
> measured. When booting via EFI in efi_try_purge_kaslr_seed() we can
> safely remove the value because it is not used anyway; we provide the
> EFI_RNG_PROTOCOL instead. We also support measured boot via the legacy
> Linux entry point. See patch dec166d6b2c2 ("bootm: Support boot
> measurement"). We should not populate kaslr-seed if
> CONFIG_MEASURE_DEVICETREE=3Dy. CCing Eddie and Ilias as they have been
> working on measured boot.
>

board/raspberrypi/rpi/rpi.c:ft_board_setup copies /chosen/kaslr-seed
from an fdt apparently passed in from a lower level firmware stage.

should I check to see if /chosen/kaslr-seed exists and never overwrite
it or just let this get overwritten?

> >
> >> If we have DM_RNG enabled poulate this value automatically when
>
> nits
>
> %s/poulate/populate/
>

yes, I will fix that as well.

Thanks for the review!

Best Regards,

Tim
