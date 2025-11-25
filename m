Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E4D4D0E6E1
	for <u-boot@archiver.kernel.org>; Tue, 25 Nov 2025 13:46:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D17428404D;
	Tue, 25 Nov 2025 14:46:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="KmuPFQtd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35AE18405B; Tue, 25 Nov 2025 14:46:03 +0100 (CET)
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com
 [IPv6:2607:f8b0:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 823BD84047
 for <u-boot@lists.denx.de>; Tue, 25 Nov 2025 14:46:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-bde0f62468cso659801a12.2
 for <u-boot@lists.denx.de>; Tue, 25 Nov 2025 05:46:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1764078359; x=1764683159;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2x4fqO1hlAKvacURAGlYc+r3dCmh7zfT/nZMSNpooxw=;
 b=KmuPFQtdz9IOcBtUEDO0cuGF+X5VMAP+3McubM9lNdQoJvLY9cDRUyq2+3rPCGg+uV
 6vMP148zD9Po5s8SCuHQULwDi8u79l/AQId4AwKyXEXKObSX84tcv+FyP4G1Kc0h3rNY
 dMflXNrs4aYgPvyrjPGMWevemlQjkTXE2MBIg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764078359; x=1764683159;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2x4fqO1hlAKvacURAGlYc+r3dCmh7zfT/nZMSNpooxw=;
 b=j1wjMBpH5Crq7Nhb/9dkXp/ZaEtoxAQTQpMUNKNeklYtaVN0N2xaDNTr6eyzCXezFf
 Dd4DN65tP01yqXZjrxfSV2gYHl/TZyPbTKZy7xG0g1+mhT8qnYqPPexa2yrVe/K8mD4f
 5TYPqn/IlLdrFTZh1r8tyIAcIAFWOEAmhstPjds/ZrkBIIMn+c4jMfUDA9IFcj8do5r5
 Q7PXvLAXJ6nSgrn+KmHSBYyeiOPcNH68sUdwozgY+vrbSBuaCOLtxxBXOYDudmN1ShJn
 4PaBpwj1ui2ZOdm3wZDIxMyLspRRpDoE2fxeio5GI9VtCNUAACphNzYAfzFCJhoILp+C
 ziOQ==
X-Gm-Message-State: AOJu0YzZKtClRjTMZk+hOUinc7XoQpFkRxldmY5eEgs333TefINdx/51
 Tn4YHHmTY2WJ0C5UsiwYO3OlMgDbr2tRenm5VlO+TWMZAEElXmVj+oN5B62GkvPrwN0YgHMGAK3
 tRnpU5Yaj1JF/ea4ynF4an2I+R8l7sllbJcrzXt2ya32ROv9ce6dqf4VWbg==
X-Gm-Gg: ASbGncvMH4lxNjLgkFT+14Bsx1fup0hnwIWvM6LQt3RHIbGHgz9JQMnfc5y7D+dIAX4
 FKviYUup1V0yqTaVX+P6ljZetkPuEkziY6+V1wNjzhA5qNPc6oCpmlEd4ix23Vc1Fd2i36rPTG4
 QwmdjJ20gbWrAwZZ+baTduYoQh8gFoMx4ApMAdXDh62ZM206O7iTd5/E8w7qTNII2F9lfmu69kg
 oe+Jbuhc/sNwZuTGgTMXtFMu3LohpJ8IFpYWkZyZ8AkNTSSl71kevvHo3yIMGKZhY2ER7CY0jOQ
 NWKvab1qaioU6yD0uNBZSTesAQM=
X-Google-Smtp-Source: AGHT+IGIgZI9bjWYpV/KB3d04Lzwl5Cd+iVYcTAtNIlNI/gFrpSKJz7w9aXxT+kZMPt5SYBtpQIFqKj2qAx3tPxXdos=
X-Received: by 2002:a05:7300:fa0a:b0:2a6:9f14:848d with SMTP id
 5a478bee46e88-2a94186fb79mr1637727eec.19.1764078358865; Tue, 25 Nov 2025
 05:45:58 -0800 (PST)
MIME-Version: 1.0
References: <20251113030357.15397-1-dinesh.maniyam@altera.com>
In-Reply-To: <20251113030357.15397-1-dinesh.maniyam@altera.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Tue, 25 Nov 2025 14:45:45 +0100
X-Gm-Features: AWmQ_bn1MA-SJmwv_1_B6m_RhuKW78hK60C1yF3_C6h6scei9X7eU1zLNq0n7xk
Message-ID: <CAOf5uwkX9FYdd3BnGO9NE03C+ShZSCHFO1Rwcqw5CJVTT3S8CQ@mail.gmail.com>
Subject: Re: [PATCH] driver: nand: skip BBT scan during SPL to reduce size and
 complexity
To: dinesh.maniyam@altera.com
Cc: u-boot@lists.denx.de, Marek Vasut <marex@denx.de>, 
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, Andre Przywara <andre.przywara@arm.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Tien Fong <tien.fong.chee@altera.com>, Kok Kiang <kok.kiang.hea@altera.com>, 
 Boon Khai <boon.khai.ng@altera.com>, Alif <alif.zakuan.yuslaimi@altera.com>
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

Hi Dinesh

On Thu, Nov 13, 2025 at 4:04=E2=80=AFAM <dinesh.maniyam@altera.com> wrote:
>
> From: Dinesh Maniyam <dinesh.maniyam@altera.com>
>
> Guard the Bad Block Table (BBT) scanning with `#ifndef CONFIG_SPL_BUILD`
> to prevent running `chip->scan_bbt()` in SPL builds.
>
> The SPL only requires basic NAND read functionality to load the next
> stage and does not need full BBT management. Running the BBT scan in
> SPL unnecessarily increases code size, memory usage, and boot time.
>
> This change ensures the BBT is scanned only in U-Boot proper, where the
> full NAND subsystem and dynamic memory are available.
>
> Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
> ---
>  drivers/mtd/nand/raw/nand_base.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand=
_base.c
> index 48e3685d995..4dc2a19b8f6 100644
> --- a/drivers/mtd/nand/raw/nand_base.c
> +++ b/drivers/mtd/nand/raw/nand_base.c
> @@ -532,7 +532,9 @@ static int nand_block_checkbad(struct mtd_info *mtd, =
loff_t ofs, int allowbbt)
>         if (!(chip->options & NAND_SKIP_BBTSCAN) &&
>             !(chip->options & NAND_BBT_SCANNED)) {
>                 chip->options |=3D NAND_BBT_SCANNED;
> +#ifndef CONFIG_XPL_BUILD
>                 chip->scan_bbt(mtd);
> +#endif
>         }
>

Look at the file there are other points where this ifdef is used for
exactly the same reason and please check this commit

commit fa87360b3ae28639f72e1c665b0631436693f60f
Author: Roger Quadros <rogerq@kernel.org>
Date:   Tue Dec 20 12:21:57 2022 +0200

    mtd: rawnand: nand_base: Allow base driver to be used in SPL
without nand_bbt

    nand_bbt.c is not being built with the nand_base driver during SPL
    build. This results in build failures if we try to access any nand_bbt
    related functions.

    Don't use any nand_bbt functions for SPL build.

    Signed-off-by: Roger Quadros <rogerq@kernel.org>
    Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
    Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
    Link: https://lore.kernel.org/all/20221220102203.52398-3-rogerq@kernel.=
org

Michael

>         if (!chip->bbt)
> --
> 2.43.7
>


--
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com
