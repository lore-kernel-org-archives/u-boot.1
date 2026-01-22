Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9DAAD6CFAB
	for <u-boot@archiver.kernel.org>; Thu, 22 Jan 2026 22:56:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F193783AEE;
	Thu, 22 Jan 2026 23:56:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ib7WO2MC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76A4F83B32; Thu, 22 Jan 2026 23:56:41 +0100 (CET)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F29B38397D
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 23:56:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-59b7be7496dso1606707e87.0
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 14:56:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769122598; cv=none;
 d=google.com; s=arc-20240605;
 b=bkr1cL/nhNUdWOLEnBB/uZI90L0D4Bku+28AFgC9BtSVa6lRBUKn3SI136L5XrMF0W
 3y9mBAZ5FYVyPYrYYxn2vAa1C0W+SBP6VPFZim81Pyu44SOpmBomRQRvmTdJ6eSEhWhj
 3p1gaPjcUrwHoXoyzChXYGsEN+d3euBF4MwH2jvBtEuiQz4mrWBEZM8+9bkqwg8YicIJ
 WTcC3x5K901lSiDqPp3dBeBscj+hcJD9YYFoHzDnevvrWHkB5aDTm3vD8qkxbwg4VUfN
 p5QzrqvTOiKUiJChKqtL9XhXBDBA9Hvrz+eaa9GVjILHczjolNa5JJGQ45z/Tqpj0dpu
 cf1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=xhUBY4rFFSMIqJA/84YUtl5rv9cT3HM5ehOLxLExYKg=;
 fh=TL5QBzXdR8CXgKVc43rDe0ZFtCIUroFWGgtt/z1FyQA=;
 b=B0P/UcDICWEWgNoJLonOG3wFm7GCdl6Y45r2qvESvOIs2KKslhv4aWCilU+IpONKuI
 BdJAzSs8cMe4Kkd+RTD8WG2pUhhXtMuCCwiws9iwOhch2+wr4UHcPmNo7K+bZB/OyRHU
 4ZGifqYf5d0xT0CXjX8P+pYbuztIh8I/2pR31QqVam6iSgjNsM0a/xiK1V/9PVo1e+LP
 bmgz0RkIuHARzBQMx3tGrGGUla1DYs5Xl5DkqfvNdaJubm0ysidXfTZvdVLBsNiLe5y+
 Cbj4zaLmcPaaBQPm2KSYsfhNJaQxGZaydahEH2+rEqRTYxBjQrGiVnAaHb92EGpnrqh3
 0RCA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769122598; x=1769727398; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xhUBY4rFFSMIqJA/84YUtl5rv9cT3HM5ehOLxLExYKg=;
 b=Ib7WO2MCgmVlq9ABfBydDVfTirEOy9AKzVb2f/4KEH2qjbiKk+llCqP+J76oetRlmh
 WQ0kNqbBfQ+aplo/+sKWI8DQn9fiftB5QJZ8sUDS44zOp0jmcAxkOAOZimkNySm/oJUE
 9JzSnCC7v/7bROjgqwZvzGVBz9kezSw8IFF5ZB+hHVwp64DY/AbSDFLaUmEM1K+8H0YB
 ISRcMGrp+wQkZWGsAvz8wvynrPoFaH1kjR6hMCm2pmc8VMvgnXO847WMtiMwjbQit9Li
 /VxUHCMnindJsirXBFSZPW2mWyaZW+W/monoJAp8suT+D+u6Cwnba3cAwgHj2Bibc3TJ
 xTgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769122598; x=1769727398;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xhUBY4rFFSMIqJA/84YUtl5rv9cT3HM5ehOLxLExYKg=;
 b=Iz/f7+/2jqtqeyAEMVgTvHTGNNTFpOvTvzpZsOucfaxtFTWLvcl84/N9iQEq7j8efF
 WBWfDxo3Mvwq8ZT92I6Up/D3qECb8c8Tn++pONz4bLGmoHd8Nrx4d8SWZD4hsG4J9SIC
 8wuE7KGIkhCVM/2bvTe2dkPtO8wdLTAtOOPMxUZ/pylAOmU4UCfFZbzWxNkEpt0OW/Wp
 uj5SuzFRicSdoWcHAff5WR1LG2B6EcGdv11tigqO24VCp5CTWa5oy+Cm/XtaIFfQ+M4B
 odPdMBkHmCL91tF9ELabVaK31Y9XLQUshlbymf/zOfRZwqCCLcuZ4uPtjEgydHUnye9Y
 7VAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXIQ6PHRh2feVGuHB9Nb9kytiOBfqNNN0+SvSlCQOYja1y7DKmpP+4aYz4q4kQMDrlbGLjRTbc=@lists.denx.de
X-Gm-Message-State: AOJu0Yx1g9I8l5TE2/47zdJHCCGsOPD0M6vvXUKQ98+mCEEqF5lOQfth
 WW6zLHYXWf8T6d2j9TeZe5LIIccx4ZCxfhw7KUjro7HzpY3OpH1z5DSkP32J9hJSCEW4HNtyFEQ
 eXHYmWzzsBllVxY2pVHZFA+6pUPDXtGY=
X-Gm-Gg: AZuq6aIt2Od+UkKbI6kbFwkYSdYCo2Sz/mIDDmj1qfKMaBNP2KQ7a9NLTY+jg2gO4O/
 3UForFbtbsjMU50qp9oHTXkPvaXeuW+ElOG7bsFCT6YBFfCdiXyVE59Y4xq/6lN1a+/W0w7gp1k
 F4gKe6O+x2mSGaMHmuLp2Iwdw9o2a/gAE8UuzJHS9q775Y5VAAR0VT9QfgoPdo33cnmyuz7/Gfy
 CfYXrn0Yhe3nTRetNGidkVEc64wqKQHpoHdAThRyzQrTcYEPYCA5f+gvJkLdpz2WDMYkSa7ZPXP
 19Q/s5xzJcwlYaCNtAzFXFfFi9E=
X-Received: by 2002:a05:6512:4022:b0:59d:e036:1465 with SMTP id
 2adb3069b0e04-59de4a2efacmr250071e87.41.1769122597917; Thu, 22 Jan 2026
 14:56:37 -0800 (PST)
MIME-Version: 1.0
References: <20260115222828.3931345-1-trini@konsulko.com>
 <20260115222828.3931345-3-trini@konsulko.com>
 <CAOMZO5DZNJ+=AP1spWCv7Ar6etf03H=DFVU=mXZcC7QFTGoh_Q@mail.gmail.com>
 <CAOMZO5COTa3ykhF8XZyzmJ0QZNotK4USo0LrH0XBJLogatfXFQ@mail.gmail.com>
 <040e129c-44ca-4a59-828f-d37c6e41d3b2@mailbox.org>
 <20260122142323.GX3416603@bill-the-cat>
 <CAOMZO5AZiBajXK1b6Mse9LPwHEzhJSM_-OcQs4BsnbXP3WzuxA@mail.gmail.com>
 <20260122191042.GD3416603@bill-the-cat>
 <CAOMZO5CJ4BAi95gjV8a=_W-Wu=zr1dMOoDOCB4yUVAzY2ARBUA@mail.gmail.com>
 <20260122194239.GF3416603@bill-the-cat>
In-Reply-To: <20260122194239.GF3416603@bill-the-cat>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 22 Jan 2026 19:56:26 -0300
X-Gm-Features: AZwV_QgHNgQvqA88C5y85EeCMFCrpjasdHY2yqKDishdvqnhmFpvGPMsNsQsGSk
Message-ID: <CAOMZO5BiQcp2HYJgrYnPQLn8Q52Z05FKjbqVKPXxKa8D3Cny5Q@mail.gmail.com>
Subject: Re: [PATCH 02/10] arm: Update linker scripts to ensure appended
 device tree is aligned
To: Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut@mailbox.org>,
 Kever Yang <kever.yang@rock-chips.com>, 
 u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Beleswar Padhi <b-padhi@ti.com>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Adam Ford <aford173@gmail.com>, Andre Przywara <andre.przywara@arm.com>,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, 
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
 Eugen Hristev <eugen.hristev@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jagan Teki <jagan@amarulasolutions.com>, 
 Joel Stanley <joel@jms.id.au>, Michal Simek <michal.simek@amd.com>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, Stefano Babic <sbabic@nabladev.com>
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

On Thu, Jan 22, 2026 at 4:42=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:

> OK. FWIW, I can't reproduce those linker messages about ".sdram" and
> ".sram", even when I point ROCKCHIP_TPL at the right binary file (per
> the docs).

I only see these messages if I force SPL_SEPARATE_BSS.

The board boots despite these messages.

> I think you need to figure out where the mismatch is between where the
> device tree is appended in the binary, and where it's expected to be, in
> the binary, and then why something is writing it to the incorrect spot.
> At run time, in xPL (and this is lib/fdtdec.c) we look at either
> _image_binary_end if SEPARATE_BSS is enabled, or __bss_end if not.
> Looking at the config, I see we are not SEPARATE_BSS here, so it needs
> to be at __bss_end. And in both works and fails branches (my own quick
> rebase -q origin/master), for me, __bss_end is the same location.

The dtb is placed at shifted-by-4 offset after the commit in Subject line:

With 8b0ebe054bb3  ("arm: Update linker scripts to ensure appended
device tree is aligned"):
$ hexdump -Cv spl/u-boot-spl.bin | grep 'd0 0d fe ed'
000029f0  d0 0d fe ed 00 29 05 db  8a 18 03 d2 43 6a 1b ba  |.....)......Cj=
..|
00015f10  00 00 00 00 d0 0d fe ed  00 00 0a 43 00 00 00 38  |...........C..=
.8|

Because of this shift the dtb cannot be found and the boot fails.

With 8b0ebe054bb3  ("arm: Update linker scripts to ensure appended
device tree is aligned") reverted"
$ hexdump -Cv spl/u-boot-spl.bin | grep 'd0 0d fe ed'
000029f0  d0 0d fe ed 00 29 05 db  8a 18 03 d2 43 6a 1b ba  |.....)......Cj=
..|
00015f10  d0 0d fe ed 00 00 0a 43  00 00 00 38 00 00 08 a8  |.......C...8..=
..|

Here the dtb is found and boot proceeds.
