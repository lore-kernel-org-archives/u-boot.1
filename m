Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B6D3CCF9F8
	for <u-boot@archiver.kernel.org>; Mon,  3 Nov 2025 17:50:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4B73836D1;
	Mon,  3 Nov 2025 18:50:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="td6vvOqw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 78B6B838A5; Mon,  3 Nov 2025 18:50:15 +0100 (CET)
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C9478331F
 for <u-boot@lists.denx.de>; Mon,  3 Nov 2025 18:50:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-654e25cc7d7so2178880eaf.1
 for <u-boot@lists.denx.de>; Mon, 03 Nov 2025 09:50:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762192210; x=1762797010; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I8sbK6DSh6gQrjVAjWffZTSTGqSEbxUtMTPBMWHiayA=;
 b=td6vvOqwyTHfGO3NOMZ/rAPJgvpN9ILKrj/g7IBojgnI5/6TKAsCv18gYvx6fNqbMO
 +bdIlSjvIdOHVfIfOE9fod5gYeT3PBgEX1xYjZNGrohMSYlHR0cZwCNYaQkAnjie9+Rw
 +xBQscbIf5Z+YZHlffI9jq0zKmQoQLoQTL3eY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762192210; x=1762797010;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I8sbK6DSh6gQrjVAjWffZTSTGqSEbxUtMTPBMWHiayA=;
 b=jkOe1BDB8+DJOzGXLxoWPzAqs5e9jnYsUprtkf5QmaS0wUpI00aUrvXv2YkgJ/9dPq
 YjltasAkyMVKJBeFQvxHv1C/0OiHVLs4Zih18PLva7N3Bt3SqAxqjAQu3Lx/c/APQEV7
 64swJDrvFqkLyGOBxdjylc/b8KOctE9ZvscIxe5ToO6b93RGM079GeKa1IbnqIiokSjP
 hX5Is3VJye60Vi28F6LJyD+8NYMa3v+XDXfMfCTadbsA6+qs7zZkS8NyoWuqI4Y5FJn6
 9lNm2MYJ23PwRvumvYX8ttDAdZendKTCPR1Z0KT67u/HRR8rTS1pA77jFviUhdhSFLXV
 JyRw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVj3hbIOxJriIpiljoO+qtCKc2TpA1nAbhCOP2DwCr8V3QjYzQHbolPAiEM4Kq1k9RrHAlixpM=@lists.denx.de
X-Gm-Message-State: AOJu0YxeK3CqFSYN3Ou5AYPi2LgIy4/bGexwk5cxKj4K1sBRCimv/CQM
 VPPKJ48zlbjHxkBCJlByqvsc0Qdx7yEJulvl5iJz9yxyPJDnddPBj1MNSiw7xCJ+QbI=
X-Gm-Gg: ASbGncvziZP+lYizcB9QojrUT5dmI+kwtVziNVVVgQDwSEiXh+yW1wox2ggn+XpgtJE
 /KDfpXZ/IU1iv7GJf7R9SR+5tAFwfSKZb9gzgjYqE1SsDQ+7CH7R+f1JUqq12qWiUiVpqyVWypI
 KSoQV6o6KsmhI0pOCY0Hc0AEQWnpnYIAdx73nJXSrOPai742VfOoVbsjOrNWODgsX8kquL54wDn
 x6rzr7gugbh8fsu+Iu+dZCZNno5hRQdFb+NcM6JZj5pocVvIZLFNoH8HTTaApOrIJFauzI0gUSC
 VQpDCC6BEcB30iuC29MzH6XSrlQ+hXuF3fqCrlOM1hIAwBA2whzjh97WfNC6RhQ343nWdBZ+dhG
 neJSdbkLGGIOxqvCG/pNT3hQfJ/aF4o4vqueNCY5qTy5XrqAU1kyoIyoXD7A4dZ69AGvTnJmC83
 RFrVV/k8XjA7r4DPxhWc23vr6BTqa/uahiA2jW7v0hpPQJg2S+
X-Google-Smtp-Source: AGHT+IES3tWq+D+3gOX09DwOLefON9WPHIqsFqh0pROs9zAGJaJKoqLpskOFxwRwz5lOid3to0/JtA==
X-Received: by 2002:a05:6820:2008:b0:656:6e2f:628c with SMTP id
 006d021491bc7-6568a197d92mr5658162eaf.0.1762192209808; 
 Mon, 03 Nov 2025 09:50:09 -0800 (PST)
Received: from [127.0.1.1] (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-656ad42c713sm237826eaf.16.2025.11.03.09.50.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 09:50:09 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>, Jagan Teki <jagan@amarulasolutions.com>, 
 Andre Przywara <andre.przywara@arm.com>, 
 Hans de Goede <hdegoede@redhat.com>, Mario Six <mario.six@gdsys.cc>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>
Cc: Roger Quadros <rogerq@kernel.org>, Bajjuri Praneeth <praneeth@ti.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
In-Reply-To: <20251030-feature_sysboot_extension_board-v5-0-cfb77672fc68@bootlin.com>
References: <20251030-feature_sysboot_extension_board-v5-0-cfb77672fc68@bootlin.com>
Subject: Re: [PATCH v5 00/20] Convert extension support to UCLASS and adds
 its support to boot flows
Message-Id: <176219220832.3330001.8393354242838443950.b4-ty@konsulko.com>
Date: Mon, 03 Nov 2025 11:50:08 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Thu, 30 Oct 2025 17:44:53 +0100, Kory Maincent (TI.com) wrote:

> This series converts the extension board framework to use UCLASS as
> requested by Simon Glass, then adds extension support to pxe_utils
> and bootmeth_efi (not tested) to enable extension boards devicetree load
> in the standard boot process.
> 
> I can't test the imx8 extension scan enabled by the
> imx8mm-cl-iot-gate_defconfig as I don't have this board.
> I also can't test the efi bootmeth change as I don't have such board.
> 
> [...]

Applied to u-boot/master, thanks!

[01/20] MAINTAINERS: Add maintainer for extension board support
        commit: d7d05f86fc4c6f4f84a216a237c47a9bdba5c73f
[02/20] board: ti: Exclude cape detection from xPL builds
        commit: 4c9d907eef08f9c23c8136f4e957e2e5ed8028c2
[03/20] board: ti: Fix CAPE_EEPROM_BUS_NUM Kconfig dependency
        commit: 5b68f58a0883a897e44e8356061103784e49d046
[04/20] board: sunxi: Exclude DIP detection from XPL builds
        commit: 9279a00c3c8e32461c901219121e066c9866c8e6
[05/20] board: compulab: Exclude compulab extension board detection from XPL builds
        commit: 06199ca751199bc432f33f10a3992df27a3bdac7
[06/20] include: extension_board: Document the extension structure
        commit: 79cd6e78ff6387685e0ccb5f7382d808478155dc
[07/20] boot: Move extension board support from cmd/ to boot/
        commit: b7edeac950dae10759527a1ed0d1c306710ec9de
[08/20] boot: Add UCLASS support for extension boards
        commit: 78a06090f4860d52dfd1577619f53a7ec75122c9
[09/20] board: ti: Refactor cape detection code for readability
        commit: b2e7b1df3bb8c88a6d5e27f29e152d61f2ec8eb5
[10/20] board: ti: Convert cape detection to use UCLASS framework
        commit: 58a36be4ac8bc68ce6069eddcf8ee3fe2178404e
[11/20] board: sunxi: Refactor CHIP board extension code
        commit: 56cbcb1cc957870148c31a56237c07057d02c7ef
[12/20] board: sunxi: Convert extension support to UCLASS framework
        commit: 53e14e9c0c606f0684a3ddb09afebe4b5eb89926
[13/20] board: sandbox: Improve extension board scan implementation
        commit: 37c6cdb053573587afb57e09a2f5096b4b71c442
[14/20] board: sandbox: Convert extension support to UCLASS framework
        commit: 0487fbec7bd47a8c8685433d1bca260832c668a2
[15/20] board: compulab: Convert imx8mm-cl-iot-gate to UCLASS extension framework
        commit: 6f5b839d5ee1ace365c3c1ba571db7f57bb48433
[16/20] boot: Remove legacy extension board support
        commit: 2d12958ee71b5f400ff2045aebc9730e8e219340
[17/20] boot: extension: Move overlay apply custom logic to command level
        commit: f9b139342c4f6cc067df06692e6dcaa4ba2edafc
[18/20] boot: pxe_utils: Add extension board devicetree overlay support
        commit: 935109cd9e97b2f48b177b7c31373325deab44c0
[19/20] boot: bootmeth_efi: Refactor distro_efi_try_bootflow_files return logic
        commit: d3008a08d822d545d223e6ce53b0c590bb6c83a8
[20/20] boot: bootmeth_efi: Add extension board devicetree overlay support
        commit: e9dc6c12958fc5d909848fc3999e6be5df1cd3ae
-- 
Tom


