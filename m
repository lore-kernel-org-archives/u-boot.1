Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A655EC53219
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 07:10:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4AB6981130;
	Wed, 29 Jul 2026 07:10:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Wf8nrDwMm2_O; Wed, 29 Jul 2026 07:10:41 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 58AA981119
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785309041;
	bh=sDeoFnTMGVzTQmq0W7H1/TyyOGhY4/HlKxDYVigrl7Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ubedxnI6QLEgm/TNu7LLCNUw033az/kkz9jpPBmLcNpP52iR1X+8OUmTyI4lv8/pp
	 35G4uBeB3OnNeh1mw1X9/XdDj0buJuDWi3O8fOaJlSLyr5Sq1kQFyAB+Ddoiy5MoYi
	 Z7JrKX/b5nktaf9bmswRU7ugWvhp/HE9d7QbeV7sXs+ynoHlyel01ZtEeaKxm+Cbd4
	 r0Acj7Arm87Wt9L6rvEAuD94BWy6xpC9ljuwuzzbuScE+trBTtPxD+J6gPdAK+Eu3T
	 g4E6oBjeOAg60jQZxXLeLOfLU0HZGwDFPz/2Oxc4HYDY9CzQOgUBwdAWhLT57z+GBZ
	 r/HJMAbmGzrwQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 58AA981119;
	Wed, 29 Jul 2026 07:10:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id DFCC145B
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 07:10:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D1F6D40A3B
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 07:10:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ns04_FGsmKCT for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 07:10:38 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::f29; helo=mail-qv1-xf29.google.com;
 envelope-from=pbrobinson@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 485B140B20
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 485B140B20
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 485B140B20
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 07:10:38 +0000 (UTC)
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-907ae240ac3so3148046d6.0
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 00:10:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785309037; cv=none;
 d=google.com; s=arc-20260327;
 b=B7494bfztvPEL7fO00fudtlTHcI8iVl4VWd6ofVy88/U3xW41IcSLgZM1OGV38NdUD
 zDKPasIHy7MHJGd7JsREE8kd4mRv4Y+YToTkaJSNuZTUhISrINH8uAn07n7QW6+4+Fxa
 KCJs64bTqwOwrym5sE/h3591DIg46A4odfv6eEhTadDzFtkDMQMGfw6CumTxBMGkUPoe
 TK4XSI7L6R6HWLIF743GdLlGZun0e4UNsfElCxR3PEyaVJzhVBT4cqJ1pNSttjfuarR+
 +Voh/YqV33tkEawgMjLXReQhP2ValEi9TtVPtQVkLVr5aAkKU27paV9Z9RCzA6pubR1V
 EMIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=sDeoFnTMGVzTQmq0W7H1/TyyOGhY4/HlKxDYVigrl7Y=;
 fh=aW1zuOF/2zGjmUXogeV5yF2BqU/n7q0kYg35J4ab9mU=;
 b=sumXqmta/tv+wYzzNMP0RQoYpN5Ii50pw0AGg2KzoUpS+CnKh+J4WdTWHhX+jinHLl
 v/A7HYqiWIpH/SBwUONsH1j02r5rhaS2W13GTNDb2sDwPmPnQxUUo2gM+brBzc3QaMaQ
 WTnyJLbp4EuyUoBjMaUhWc/zeYSKJa7jlWR5WY0gFMC/7SimoOZCrmxmndstMzOjLNur
 70TT2zbZWG7KmexAxeA0WvD2boufhHGch9CbFWMwsS1cr35J2Bj9BPfbRcTiWriVeDqY
 cI/asOZdjAfxIKVrBiY+mpvYLz2D1zHOTd5APZO8V69uT4CHWOyRfOAd7AaxfuczB8S5
 BsSA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785309037; x=1785913837;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=sDeoFnTMGVzTQmq0W7H1/TyyOGhY4/HlKxDYVigrl7Y=;
 b=tXSDssYmWJHbLWp0GuAzsa+i6JesvrA596Sf8/bHu0cVWypjohZofZDgQkK6WXCWhN
 H6w0ibSOz+qaUHBUvif+R3ExlFqzKt5GkdchmiReg0cNJDr6MV4FZEGiDsk2O5BBfpfa
 ErLnSfnb7QmtCKpnb1KR6vJa4g2josI98gRUl5M06VBh9gS00UW5lBc4HlRU6PKEPggj
 ASJqXseRevenh+3EEnCJmQkcVxhhji3QoBYwHXr9rbHc/Z20ked6FfbUwRRkwieAxoZg
 VaPnqRE6aVo1ZQvdhZQtOrI9Q3KzzoiynvHx53EyWuwhN/FTqeE2872SQFmzgV5/Slzo
 2nZg==
X-Gm-Message-State: AOJu0YxHXTgUgX9hD1nORmIJ+hVTCswD5RkNNPf082H5imApoY0rb6tn
 i2OFhNgDwCuOAHb1pXx5itx+6kcswivFMhfJnKrqO0P7oX4HCcZJP1zGyYYkPSdAM97PCbzsHKD
 H7Se4GRCYZ7CJtG0uG10cFcA0NMOnUxtJKGfH
X-Gm-Gg: AR+sD12B9+2pNvWA78m5Nl5CC480Ikp7reazADRa7jpdRqsJbm/hjTDld6Kp77Qz4Mp
 6+jdFhNsc+LdzMjp3fKJ0S5bvOkmOSxmgJQa1TD+lOV2O8BBm4PBsVx81gHrseF2WAlJS05JbwQ
 YolyhKBxTwV+zPhcrsYlY3eJHCcz6xMwovRSc9S7T52uhET7TpfZyiyuM6kJvNGOvFIe0+BVCyc
 hSYEgP7pVSpPAb03KQw92xYL22uTPDDxVjRPslOmu+wmH+UdVYCy831qgTYQSNVE85vw8lKxVzf
 7sX+NidUXs1qBkVF4FROiLLfkKcxi6Dn3JdZ2ID/ZIoBodMcVaoNIu/LLrUHOdMCSvmjM0kSUyN
 Mx2jsoHmlSCgXvwolfZRmWW1gERfT8mHs+WBKHsSLmZqrvJ3UY4PruxJerk/3WM+J44QzOkBDku
 NMqioWUtRnWHADnIGoLz1u14sXARYk8L7n9zM0cALQ
X-Received: by 2002:a05:6214:62e:b0:8ef:ab62:217f with SMTP id
 6a1803df08f44-9081706f849mr58619326d6.37.1785309036676; Wed, 29 Jul 2026
 00:10:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260728-ccaione-upstream-ebbr-v2-0-4efb529140d6@baylibre.com>
In-Reply-To: <20260728-ccaione-upstream-ebbr-v2-0-4efb529140d6@baylibre.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Wed, 29 Jul 2026 08:10:24 +0100
X-Gm-Features: AUfX_myhOrtP0zolnoB633S-6vpMx90P6KoxCJDlHwfkSSRGYxoGb-hQosbORac
Message-ID: <CALeDE9NR136ryqa1WZqy7edXcrP4e4FW_QbYTOeAAhd6rwPAyQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] firmware-owned devicetree for EBBR / SystemReady IR
To: Carlo Caione <ccaione@baylibre.com>
Cc: u-boot@lists.u-boot-project.org, Ahmad Fatoum <a.fatoum@barebox.org>, 
 David Lechner <dlechner@baylibre.com>, Julien Masson <jmasson@baylibre.com>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Quentin Schulz <u-boot@0leil.net>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Johan Jonker <jbx6244@gmail.com>,
 Randolph Sapp <rs@ti.com>, Daniel Golle <daniel@makrotopia.org>, 
 James Hilliard <james.hilliard1@gmail.com>,
 Aristo Chen <aristo.chen@canonical.com>, 
 Peng Fan <peng.fan@nxp.com>, Vincent Jardin <vjardin@free.fr>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785309037; x=1785913837;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sDeoFnTMGVzTQmq0W7H1/TyyOGhY4/HlKxDYVigrl7Y=;
 b=N5TYcPDQzdAzxHiQv9e0eJmkPpFZ9ZFc7bl48xNIuMO7KDDmR+aQr6tXUGdcltVVCM
 93wOwNcjsuo8pBp2sOmROur0PF05TClFfWw69BZ288D1kMnC+hcVpsDKtaA9cSuF/+y9
 2txA/jU7DOBDH5E385pDVDAc9Pqa4unf2YiAlMjfFIlt/89HGEwQDi/znW5fBdbP0CVu
 qZU8eNPXx9YFCBgFOaG8kJNYoK0Adb//2qACYBIGgp1ylrqBt6Y69+GiEU/4ORA31eoo
 ZUI2R/v5k3kxsjxzZEjJ1X0TgsAnLzZz26/o/PFFqcQRmFyOmBNr0uMLpND2bV10EOiV
 m8cQ==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=N5TYcPDQ
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

On Tue, 28 Jul 2026 at 14:21, Carlo Caione <ccaione@baylibre.com> wrote:
>
> EBBR-style firmware (SystemReady IR) owns the devicetree: the OS is

For reference it's no long SystemReady IR, but SystemReady DT [1] or
SystemReady DeviceTree.

[1] https://www.arm.com/architecture/system-architectures/systemready-compliance-program

> booted via UEFI and receives the devicetree from the firmware through
> the EFI configuration table instead of shipping its own. U-Boot has
> the handoff mechanism (efi_install_fdt()), but no generic way to say
> which devicetree the firmware owns or where it lives. As a result,
> platforms carry downstream commands to provide it.
>
> This series adds a generic loader for a firmware-owned devicetree FIT on
> a dedicated GPT partition:
>
> - one FIT ("fdt.itb" by default) carries the base devicetree and its
>   overlays. FIT configurations describe the valid combinations, so a
>   signed configuration authenticates the base, overlay set and ordering;
>
> - a standalone 'u-boot,firmware-fdt-block' control-DT node points to the
>   media device through a 'firmware-fdt-store' phandle. The node selects
>   a partition by type UUID and/or name;
>
> - 'fw_fdt_part' can pin an A/B partition and 'fw_fdt_config' can select
>   an explicit configuration. Otherwise compatible best-match against the
>   control devicetree is used, falling back to the FIT default. Configuration
>   chaining is rejected so each combination remains one authenticated unit;
>
> - one staging helper owns the EFI policy: use fdt_addr_r, enforce the
>   size cap and distinguish an absent source from a configured source
>   which failed. Both the EFI bootmeth and EFI boot manager use it;
>
> - once a source is configured, any failure to assemble the devicetree is
>   fatal rather than silently falling back to an unverified source. Every
>   image is verified up front so a corrupt overlay cannot be silently skipped.
>
> The loader itself does not depend on standard boot. EFI is its first
> consumer, but the source lookup, FIT selection, verification and overlay
> assembly are generic.
>
> Patch 1 makes an FDT passed to efi_bootmgr_run() outrank a Boot#### FDT,
> as an independent behaviour fix. Patch 2 adds the loader, binding,
> documentation and shared EFI staging policy. Patches 3 and 4 integrate
> the EFI bootmeth and boot manager. Patch 5 adds sandbox coverage.
>
> Signed-off-by: Carlo Caione <ccaione@baylibre.com>
> ---
> Changes in v2:
> - Make the loader independent of bootstd and describe EFI as its first
>   consumer.
> - Describe the source with a standalone compatible node which points to
>   the backing media through a phandle.
> - Rename 'boot_dtb' to 'fw_fdt_part' and document both environment
>   variables in doc/usage/environment.rst.
> - Factor EFI staging and fail-closed policy into one helper used by all
>   three call sites.
> - Track the assembled FDT's ownership explicitly and own the FIT filename.
> - Select FIT_BEST_MATCH and add explicit compatible-selection coverage.
> - Split the passed-FDT precedence change into its own first patch.
> - Build the entire sandbox source topology at runtime, store mmc11.img in
>   persistent_data_dir and add staging, configuration-chaining and corrupt
>   base/overlay fail-closed coverage.
> - Link to v1: https://patch.msgid.link/20260706-ccaione-upstream-ebbr-v1-0-e742cdd6abe5@baylibre.com
>
> ---
> Carlo Caione (5):
>       efi_loader: bootmgr: preserve a passed devicetree
>       boot: add a firmware-owned devicetree source
>       bootmeth: efi: use the firmware-owned devicetree
>       efi_loader: bootmgr: install the firmware-owned devicetree
>       test: boot: add firmware-FDT source tests
>
>  MAINTAINERS                               |   3 +
>  boot/Kconfig                              |  24 ++
>  boot/Makefile                             |   1 +
>  boot/bootmeth_efi.c                       |  45 +++-
>  boot/firmware_fdt.c                       | 420 ++++++++++++++++++++++++++++++
>  boot/image-fdt.c                          |   3 +-
>  boot/image-fit.c                          |   9 +-
>  configs/sandbox_defconfig                 |   1 +
>  doc/develop/uefi/firmware_fdt.rst         | 112 ++++++++
>  doc/develop/uefi/index.rst                |   1 +
>  doc/device-tree-bindings/firmware-fdt.txt | 150 +++++++++++
>  doc/usage/environment.rst                 |  11 +
>  include/firmware_fdt.h                    |  95 +++++++
>  include/image.h                           |   4 +-
>  lib/efi_loader/efi_bootmgr.c              |  39 ++-
>  test/boot/Makefile                        |   1 +
>  test/boot/firmware_fdt.c                  | 411 +++++++++++++++++++++++++++++
>  test/py/tests/test_ut.py                  | 181 +++++++++++++
>  18 files changed, 1492 insertions(+), 19 deletions(-)
> ---
> base-commit: b635d43bca429500cb8ef20aa151cb5773b9a8a5
> change-id: 20260706-ccaione-upstream-ebbr-206c30be3a3a
>
> Best regards,
> --
> Carlo Caione <ccaione@baylibre.com>
>
