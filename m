Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9AD1FF8873
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 14:04:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6FD38485D;
	Wed, 29 Apr 2026 16:04:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="H0/JklXH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E976184868; Wed, 29 Apr 2026 16:04:42 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93E6984837
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 16:04:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-b8f97c626aaso1201589466b.2
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 07:04:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777471479; cv=none;
 d=google.com; s=arc-20240605;
 b=lGpYjXgaojvdgeQbD50DyqeUycoCKkk8Qivr72hJtBRIV0EYOM55COGsuNNRkNLqSS
 8Rc/5KyVvB1kUaOTbUrZUH7IELYhGl3buRUZFd7eqmqY7rEVT+Ok16zJK6W5Z/XXXGjl
 JP0wsxboTkbpOESpu8P1wc/lMdLubpvc0N8ZM2M+KsIah9zjlanZQAmztApMq5uDQPtK
 BmRdEF0TzMm8IOQ+KLykIE6laI13UMJ5/grxd5v5XAu7/eBgcjJubUrOCW9y5n1UkMge
 Vvty+cUdXduXFnf4PdN1dKeuiTbqtTXsh+eWYG1FfkextvRlU6IijBuDesny9HJNu1il
 u/XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=+JERTxsey5mBZaQD1l7YC0K4x6TKsiGPVi+w8Z+9arY=;
 fh=OF00omt3W5XkTWoy8yz+VALjHs5aNJpNm30/GdQrL1I=;
 b=TV3wAQhSN6WKxIpext6pKz2jtblHe16QuhWgAuH7YR8+uNzu2t5XYxUnEs0wIdoGe8
 dC13r38HyMNvPRuUMZUefy+iZGVMHcyIWlTWQUXTDDFJkXhyKYg70mvseE3B+o5sEQuw
 ZnQZnCjraMsNI4ip2R3o4JF4Gs8uxRt/S1uF33x6HD5EXMzJOdgnpd2EAr+ndjVo/Q/g
 bkxX01+g4sQonXdQp7DAirgTKJrLNk1f80bTzUW6OAzGmj7BA2DA1S2MlcpOErwbMyq3
 oBB7Kwxf8CMivOl1wOJXrNuTmunB0IF5lktSz7I++wPGshVlOK8waYhuO/G2C1Kh1rGi
 7R5g==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777471479; x=1778076279; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+JERTxsey5mBZaQD1l7YC0K4x6TKsiGPVi+w8Z+9arY=;
 b=H0/JklXHlzw39m4wyhH0nC0EKzsYKjANohgUBFRake3F9Q6LpEBD3afzITItglK7MO
 ynL58Ud7JaXQfPANSr2wKFgdshBii7PqrLdMNEBFcIVbde+yYmYdN0M5lQreJeyXGoJR
 UUCPs+fdxwLN4tAT/hDdAbOVN1sejMC2immqo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777471479; x=1778076279;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+JERTxsey5mBZaQD1l7YC0K4x6TKsiGPVi+w8Z+9arY=;
 b=L00dEwQRR9yH+rg6e55Han6frSLmtkA5qR2hHmm3xFZB/YPX9QPsCcEp+iME6f+Qms
 VItux9JdP+0D4A9Pes8/kwazAWGwYmZeDyoh8iAciGjpY5nF28Us2ALYrhdZTvI6eIAs
 3QY/vJ7T6GFXS1Tus+PM3r9NnqhiddswX2BBxJmEKRYIIiIpKKTw24PVV5bwrkEgcdro
 Eqe3c/07UKq69vGHqmW9jTdOaz/vJ9PSKgcwGYTg8EaQ+ZlrrmJp7xQznpCQjEGlctWg
 GW533sYZVsO57S8If4p50yHe2imlC3myLy5HA4ofXO3bJodgbHVmHV41K2JQgU8QPayI
 7J/Q==
X-Gm-Message-State: AOJu0YwrJPF8VR1YXmQ6sdDuOoMLxg9TSDxyYk8xa1VnvEWa5m7Lthdy
 hU/PtCnfEMI/JKSXk4vDJulnoqHOQLgX4lhCpStIklrYKylsZsNEseDygIseJksKYbTBsJnfqUZ
 giS8lH6fskc4iQSVzzXdwQatIXukViLNhmz3U8keW
X-Gm-Gg: AeBDieuSKZu50dAKbZtqbkLr0H5MfSMixRTsytpD1Pj2ywOz7+kK1fQIYtIaTOPaCUH
 dACbpIVneHh5eEA6e1MdDgwtCRpBQDhCOuc7fZWKPuMVmbgUMDLK/nC5h2yUXxDpbiAFAI1bhO2
 Kh+WgyvjLUH9ayTHFyQ4EupOhsZzlMjpJrTg0o3rAzBXQW+tudcL6GcVF0zcv2sQGDkQ0QwIupl
 BJJZ6sU4u+FP+1O7T3keCGOBdwcF50ZMxtPpLgWvMqoYENFIP/wftElszx9aqLrfKm/7XN46u1G
 50eOWZMHD51CHmVV
X-Received: by 2002:a17:907:3e9b:b0:b9d:e301:20db with SMTP id
 a640c23a62f3a-bb80472800emr526822266b.25.1777471478860; Wed, 29 Apr 2026
 07:04:38 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1776954004.git.jcethrid@gmail.com>
 <80621463fd15e2eca9fb138110bb18ebbf2351d9.1776954004.git.jcethrid@gmail.com>
In-Reply-To: <80621463fd15e2eca9fb138110bb18ebbf2351d9.1776954004.git.jcethrid@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 29 Apr 2026 08:04:27 -0600
X-Gm-Features: AVHnY4K0wX9QrXhm78pec5S9lH3ktKBuE1t0KlpBHt6G9k9WhZcWLXpC5nGfBIQ
Message-ID: <CAFLszTg28FzEqMzLrXpX+9rNc=iLOwbGHtbQ-ig72NPHdqy72w@mail.gmail.com>
Subject: Re: [PATCH v5 02/15] mach-sc5xx: Remove update commands from default
 environment
To: jcethrid@gmail.com
Cc: u-boot@lists.denx.de, malysagreg@gmail.com, trini@konsulko.com, 
 linux@analog.com, philip@philipmolloy.com, sjg@chromium.org, 
 Caleb Ethridge <caleb.ethridge@analog.com>
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

Hi Caleb,

On 2026-04-23T14:24:50, Caleb Ethridge <jcethrid@gmail.com> wrote:
> mach-sc5xx: Remove update commands from default environment
>
> Remove the update_spi family of commands from the U-boot
> environment. These commands are not standard in U-boot,
> and boot media programming has moved to Linux, so the
> commands can be safely removed.
>
> Signed-off-by: Caleb Ethridge <caleb.ethridge@analog.com>
>
> board/adi/sc573-ezkit/sc573-ezkit.env           |  2 -
>  board/adi/sc584-ezkit/sc584-ezkit.env           |  2 -
>  board/adi/sc589-ezkit/sc589-ezkit.env           |  2 -
>  board/adi/sc589-mini/sc589-mini.env             |  2 -
>  board/adi/sc594-som-ezkit/sc594-som-ezkit.env   |  2 -
>  board/adi/sc594-som-ezlite/sc594-som-ezlite.env |  2 -
>  board/adi/sc598-som-ezkit/sc598-som-ezkit.env   |  2 -
>  board/adi/sc598-som-ezlite/sc598-som-ezlite.env |  2 -
>  configs/sc573-ezkit_defconfig                   |  2 -
>  configs/sc584-ezkit_defconfig                   |  2 -
>  configs/sc589-ezkit_defconfig                   |  2 -
>  configs/sc589-mini_defconfig                    |  2 -
>  include/env/adi/adi_boot.env                    | 53 -------------------------
>  13 files changed, 77 deletions(-)

> diff --git a/include/env/adi/adi_boot.env b/include/env/adi/adi_boot.env
> @@ -1,9 +1,7 @@
>  /*
>   * A target board needs to set these variables for the commands below to work:
>   *
> - * - adi_stage2_offset, the location of stage2-boot.ldr on the SPI flash
>   * - adi_image_offset, location of the fitImage on the SPI flash
> - * - adi_rfs_offset, location of the RFS on the SPI flash
>   * - loadaddr, where you want to load things
>   * - jffs2file, name of the jffs2 file for update, ex adsp-sc5xx-tiny-adsp-sc573.jffs2
>   */

The jffs2file bullet should go too, right? - its only consumer is
update_spi_rfs, which this patch removes. Also the jffs2file= lines in
each board's *.env could be dropped

> diff --git a/configs/sc573-ezkit_defconfig b/configs/sc573-ezkit_defconfig
> @@ -6,9 +6,7 @@ CONFIG_SPL_GPIO=y
>  CONFIG_DM_GPIO=y
>  CONFIG_SPL_SYS_MALLOC_F_LEN=0x10000
>  CONFIG_SPL_SERIAL=y
> -CONFIG_SC5XX_UBOOT_OFFSET=0x20000
>  CONFIG_SC5XX_FITIMAGE_OFFSET=0xE0000
> -CONFIG_SC5XX_ROOTFS_OFFSET=0x6E0000

The commit message only mentions the update_spi commands, but the
patch also strips
adi_stage2_offset/adi_rfs_offset/imagefile/init_ethernet from the env
and removes CONFIG_SC5XX_UBOOT_OFFSET/CONFIG_SC5XX_ROOTFS_OFFSET from
the defconfigs. Please can you expand the message to cover this, or
perhaps split the patches.

Note that it should be wrttten as 'U-Boot'

Regards,
Simon
