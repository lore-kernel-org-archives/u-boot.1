Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82D87CD98CF
	for <u-boot@archiver.kernel.org>; Fri, 12 Jun 2026 18:21:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C4228063E;
	Fri, 12 Jun 2026 20:21:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SiizQYzn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D15B84704; Fri, 12 Jun 2026 20:21:53 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7554E8056B
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 20:21:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-68ced97b6eeso2054453a12.0
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 11:21:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781288511; cv=none;
 d=google.com; s=arc-20240605;
 b=GopOs0c/kvBNHxfPfVrXqpkc5RIHt6IaiIDa9vkC7E50Kgxd+Cclq78/365pQn5din
 fs7yoHCzidVnXgGOOPTGfAYb/TIHYrHxL/t0uqxFW893uqDWfWqkS5tlWtJgvDiiMZFV
 k7LZ8X+3lO4rjI6PY1k48i8RHyTg+OeiBgSFadApL/ZPFORmXW9La9O9RXbQZL2zvj29
 t5OUue69A7CgzEdvPR5/4QX3CLPG3iJKgs5imv8Et7vkFUBWpz2JNJ9rBAIuYPE0SN7/
 2R2YM5Anz0q2EgwPT0zZvEAm4lGpSEgP9pVRliPV+FuG88zsSRhjnnbF9HWX5a4khzjE
 VfrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Gknu/8GyFZTyqSBMK/OLmF5yPFVbfOFmzMyvxUWIS08=;
 fh=dHTNQ/m7aJHmEr43KkSE3Ik6dnbDcxqVFUG8Mql68SI=;
 b=UNhEn9w0an4SXGobNP2jNKVDEir0fZ1Hyd7xPLq1Ih1iwgFirT7qhdvsg5QMhz4/zz
 IYgx6FF1AGl6ZhdHzbaH7jA6wCjpU59fGIHj7N4tGrOqbQGsC3uLWUqT6R2WW6qTD8Z+
 eev0F8Gmr+g0YJQ6sbocE/sTRbazHbco+eKU3Ox6mj+SvQpoJWofs4tkktdc7BUdYsL3
 nITgrF4jIEhyI364si0vFCMGyKpgTGuzLv5wGL88cICfUzXXzBbdTEVi/CIsl2uMJNgN
 YMVXwZFVw/2FHwPHI+l5GmF7+IXnhKlSUE2JSuSCyNpm6UmofAgcSV4im/mVvSTwPfY6
 Sc5Q==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1781288511; x=1781893311; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Gknu/8GyFZTyqSBMK/OLmF5yPFVbfOFmzMyvxUWIS08=;
 b=SiizQYznNVLZ6E+vBjaRy1GyX2GUxHsfPrZBoDOEPBB/B05FfNII9Ny76j/WS67HUA
 8RPmpZOKsV9t7JCUwxj29Uab80sGQNR6cDpaRMwYpVAijr0BKRRFTghbqdCTlmqPh3F2
 RY1yy4GSMasDrTvGVLsk7UECw8kcMd1HgjSjA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781288511; x=1781893311;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gknu/8GyFZTyqSBMK/OLmF5yPFVbfOFmzMyvxUWIS08=;
 b=C0/w8eY9kyYUgy+UfxYkH5wTIg83V0o6m83fse+ftte7TSIeeU97S/V6wDpEhI8Tz0
 8tuWsm6zXmcvcgBjKHbDY69jCGi76Or0O/fN3X8uDhKT8axnJMBaO4Q/6Byzrw6TV4Ce
 iTA7VaIUc+4dy78eBvmT34JKNOsxlixtfMVz6574FMTh214wXUzLfugov+CNDET5ySrE
 NwTMr5R8bA9vufYbiNv16Ce1govWdn9zA0bD6K/JxUlYALwjMn/7D6elAYCLucKddsca
 E5r/u39Zag1v3c7zQESA/7/TMMAe1AtxLfbajJmW3btKyffnvO/CwhH7HjO2SgRv4z93
 nvHA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+WbShitqLVqhEqJ5LyADF5VCs4SQEkZquEoGoTqiir3oPrEeea5e9pB02l7+w/rFVgoQtTAEw=@lists.denx.de
X-Gm-Message-State: AOJu0YzxMj3IvnkzYCOq2V3su6AI7oRtYMRO9xV1Zx89wxZSfe8eAj2J
 Xe7JQG96bQzLxy8QdKBvRUzpVWxSNATUSsO101J3aL0y/khpfongIBK04zRy6giisJ2h5g3qpr9
 rc2B+jJ8KJdEcNTWD2/KPGI5YJGid7a2XDPHyO0BL
X-Gm-Gg: Acq92OFC2b3YzUIDaDVJeKe3XXTDmtaqbXzDI7jsOudkY+SMF+Yb77oISn8EcvLWil6
 dcRKTysP29oPBEldaZleB0mFyZp/CCMsAqMI4/nXLAUnfUFptBR57hU44B5XgmJmTVe6LeOnXeM
 12Hfpc+krkvSaS+ggikjk3ZGMEU7+se+n72pNwH93L/zuFOAXdlGTAEfooT5IAfVwz/BGwpGF2F
 IpnE2HoObRPPQ9i8R2e9+VwLUHLJnhZRabJOp60OVZ2lBoYo0UTSnNM0275tbR78iv2J9E7TBVI
 xtDRzg==
X-Received: by 2002:a05:6402:5205:b0:691:ad29:ea27 with SMTP id
 4fb4d7f45d1cf-69378a18b19mr1983142a12.14.1781288510858; Fri, 12 Jun 2026
 11:21:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260609131611.46399-1-ilias.apalodimas@linaro.org>
 <20260609131611.46399-6-ilias.apalodimas@linaro.org>
In-Reply-To: <20260609131611.46399-6-ilias.apalodimas@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 12 Jun 2026 12:21:38 -0600
X-Gm-Features: AVVi8Cc-AKaOW6lKLbPavg7CnGMqMySZ9mmKLvmzVrdrFko-B9OhdUPQFj8-0Kw
Message-ID: <CAFLszThG+jRH=cru6-+mtdeOoCMcK+P_Ub-zNgbQP9hrfWDtiw@mail.gmail.com>
Subject: Re: [PATCH v6 5/7] common: Add an option to relocate on ram top
To: ilias.apalodimas@linaro.org
Cc: trini@konsulko.com, marek.vasut+renesas@mailbox.org, jonas@kwiboo.se, 
 anshuld@ti.com, sjg@chromium.org, christophe.leroy@csgroup.eu, 
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

Hi Ilias,

On 2026-06-09T13:15:42, Ilias Apalodimas <ilias.apalodimas@linaro.org> wrote:
> common: Add an option to relocate on ram top
>
> Right now we only relocate u-boot to the top of the first
> memory bank unless the board specific code overwrites it.
> This is problematic when loading big binaries as it
> fragments the contiguous memory space for no apparent reason.
>
> On certain platforms, it is currently not possible to relocate U-Boot
> above the 32bit boundary, due to various dependencies on content located
> below the 32bit boundary. One such example is ethernet, where the packet
> buffer built into U-Boot binary is placed below the 32bit boundary and
> allows loading of data via ethernet even above 32bit boundary due to
> memory copy from the packet buffer to the destination location.
>
> A previous patch moves the bi_dram[] info from bd to gd and make
> the memory bank information available early. So move the
> dram_init_banksize() INITCALL before the relocation address calculation
> and use it to derive the address.
>
> Also add a Kconfig option and allow the common code to relocate U-Boot
> [...]
>
> Kconfig          | 14 ++++++++++++++
>  common/board_f.c | 29 +++++++++++++++++++++++++----
>  2 files changed, 39 insertions(+), 4 deletions(-)

> diff --git a/Kconfig b/Kconfig
> @@ -503,6 +503,20 @@ config SKIP_RELOCATE_CODE_DATA_OFFSET
> +config RELOC_ADDR_TOP
> +     bool "Relocate to the topmost memory address"
> +     depends on EXPERT

This is already inside the if EXPERT block (just before 'endif #
EXPERT'), so the depends line is redundant. I might be on the wrong
branch.

Reviewed-by: Simon Glass <sjg@chromium.org>
Tested-by: Simon Glass <sjg@chromium.org>  # Radxa ROCK 5B

Regards,
Simon
