Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F12A7CD3439
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 15:33:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DB4584ADD;
	Thu,  7 May 2026 17:33:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bY7YAQYU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FC0A84B43; Thu,  7 May 2026 17:33:25 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3DDC084A79
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 17:33:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-65c0891f4e9so1586535a12.1
 for <u-boot@lists.denx.de>; Thu, 07 May 2026 08:33:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778168003; cv=none;
 d=google.com; s=arc-20240605;
 b=hFqABWLufcc+/eqPENjBKiXQTZ3vnBB640RlBmjRbJ/nQho3mxOUgq+hXw+4FVThpA
 OUT5BpkU5X8rUy/z4iVLykDS771ZVUKFMnfpdzC97FkuIQ6+TCBzMALnGhpVURAm4BC/
 zmSHLzz+8V5wGf/h4Ay4cW6TiL5MBiwyq0mdpaqSDrZTUW5tdKMtB++/8nmD2oWcYQoA
 wWNW0Ij7RrQKtVyNDhsRtTN3cQejzYBnZm5LtygdcBlBNtYUN/htoYnuh9UjiUs8Tohm
 LMhID3cakE2kP7CoxP/HJwBHJIvAH7V3h6jE6n9kRqKE+Ct0bTrq8km4LusWc6usKYLH
 mE0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ZA4aZg6uaViPQqMeubANzU/zWClANNOChEdvUpfYwiE=;
 fh=XMGPZOvrWPTh4jxpYqp7bf2uJCORZqdYFHSCmuIYfc4=;
 b=XZeLJ/F6GIyQ0Zy/9noVcqpdEuFcRCAMZvf4mq21voz7nVHSU4Cly7rdLpquiAcha9
 Nt4JLoh0OZCuVdAhB7KH6Edai4YvG10p0G/ohfvYrF/CA1ROVflO/BlULpumjUkCqxWU
 LvbV7jaDVQDrByjhLAjmwR10xEz//iQCazOpbGb9k+4oCY3WxrhMjH3hrFqi1S5FgNEt
 cNxcWOYlNvstZX5Yu6PSu+mt7nIPIAGw1aI+Mk7m/QSMvciR65190iPuiSjWDoCaqzuG
 bscS2jIpMAwrAbBXXmTyBCM74VrGEQNUbSL5xWabkAkcDvNUiQ0iBvErekP0y8+KNzdO
 viAA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778168003; x=1778772803; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZA4aZg6uaViPQqMeubANzU/zWClANNOChEdvUpfYwiE=;
 b=bY7YAQYUytnZ3R5Oj5eXjN00sV7fXZlE0GGjfb6ftc0BMSdwGdy3U7GVA3zP6dxHk5
 /T1t/tWeZRvzwQ1oYkOD/XhVCPhRrwD0djc57crmp89YihjP+PaKMBIjiyeFwUn6ZDkD
 f94/iu12rJK6SUSFfkokm67r1Akiaoq3jup1Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778168003; x=1778772803;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZA4aZg6uaViPQqMeubANzU/zWClANNOChEdvUpfYwiE=;
 b=sAJu/Gz9mHSTNF7ticyILLwZ4H+lxNW7YoC8ttiaiytxIn89rgznWTp7Ip1PuRH/7D
 AyyvIRCP/yangCjzm7why8+qqz0h3Ly+zQxGEXi2FVP6G7/hOpw3g37bmUMiWOJiurDI
 Gizebn9GUpqVhiwKlNY+tQZbyzn6T+gsIRdc9tbIquaL74c4Vj/ury8ywkFwfFux99vP
 XmcLIaQX/0+wcAOnhYEpiHGHM/DHc9RtN/Ls/7le3JEadYUjKVrOq0su7mvjS/qtNFzG
 307YA5KeSzFxQQawwczHSB82nBJxbWR/xeC560iaG7zkUGG9OwiYmgEOFHadjD+x8GPV
 KvYA==
X-Gm-Message-State: AOJu0Yy7B4AkbEbSXGzT3m0hl8IUafT0uNLceg/EoddNELD/7t4BTGzh
 QUhqCqIEATdb93YNMmPUkdA0azIiJN8NFlsgyw+qUyMdB3zXVgekDyUcGqIWlJGev4b0+A/jsrF
 w20RmEthV6OF+81NKlPSTX81Fr15DRobh6W1e/mxf
X-Gm-Gg: AeBDieslY0nt0fDIx7xiBbJN5FFPNVHF4ZT1iEi0TCUT3WtZ8qkHkRc64wxj73kaRRk
 rHCpTsmds4w6WWdOHcNLfADeZSX6SLVTkZFvj3dh8ok/5tYRW4vIti6NZppIb7YHAKZCklPquQU
 X87sq3HAfEljjhygw/XwCu3N6L2rDpJF8O9y3TWaKeGQ1MxekPFYxG5e0/zG0Kz7PeExuWDkWYX
 +int7kSEIqCtuHZucNgLHdDG6d0BEwKnkmpMAh2QfzoAN07GrX/YJLAwhICP8EWur9uWS0SpD7F
 9PApNIZ34N1oBbFFMig9QHaPiLo=
X-Received: by 2002:a17:907:c06:b0:bc3:5164:ea82 with SMTP id
 a640c23a62f3a-bc56ae2c6d4mr537747266b.1.1778168002438; Thu, 07 May 2026
 08:33:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260430122629.606153-1-ludwig.nussel@siemens.com>
 <20260430142602.v2.1.5f8ce2dc2b00328d29e64be2684b10d9f52c6a7b@changeid>
 <CAFLszTiTCsLgdAasexCb5Gv1zkdAo6m47D2MEgYxqwpkfAZoNA@mail.gmail.com>
 <79f3438d-a6d9-48a8-8cdf-01dde7b5e2b1@siemens.com>
In-Reply-To: <79f3438d-a6d9-48a8-8cdf-01dde7b5e2b1@siemens.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 7 May 2026 09:33:10 -0600
X-Gm-Features: AVHnY4Jsft0ib12aYKgm8zxyadRuPmkNh_HEBoiID5kXuraioVUkUl5xEr83J30
Message-ID: <CAFLszTg_EFGf6CTJsNdnFiJrxYKm8799ZDA+wEgLYXEqQ-3_xA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] qemu: overlay signature nodes
To: Ludwig Nussel <ludwig.nussel@siemens.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Patrick Rudolph <patrick.rudolph@9elements.com>
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

+Patrick Rudolph

Hi Ludwig,

On Wed, 6 May 2026 at 09:29, Ludwig Nussel <ludwig.nussel@siemens.com> wrote:
>
> On 5/4/26 14:26, Simon Glass wrote:
> > On 2026-04-30T12:25:59, Ludwig Nussel <ludwig.nussel@siemens.com> wrote:
> >> qemu: overlay signature nodes
> >> [...]
> >> diff --git a/board/emulation/qemu-arm/qemu-arm.c b/board/emulation/qemu-arm/qemu-arm.c
> >> @@ -147,7 +147,38 @@ int dram_init_banksize(void)
> >>   int board_fdt_blob_setup(void **fdtp)
> >>   {
> >>        /* QEMU loads a generated DTB for us at the start of RAM. */
> >> -     *fdtp = (void *)CFG_SYS_SDRAM_BASE;
> >> +     void *qemu_fdt = (void *)CFG_SYS_SDRAM_BASE;
> >> +     int ret;
> >> +
> >> +     if (!*fdtp)
> >> +             goto out;
> >
> > This runs the opposite direction to qemu-sbsa, which uses the U-Boot
> > DT as the base and overlays the QEMU DT onto it (see
> > fdtdec_board_setup() in board/emulation/qemu-sbsa/qemu-sbsa.c). Done
> > this way, any node in U-Boot's built-in DT that shares a name with a
> > QEMU node (/cpus, /memory, /chosen, ...) will have its properties
> > merged into QEMU's, potentially clobbering the hardware description.
> > If this is correct, please explain in the commit message why the merge
> > runs in this direction.
>
> IIUC the FDT patching happens before relocation. QEMU starts u-boot from
> a ROM at address 0 so writing to the embedded DT does not work. QEMU's
> provided DT is at a writable RAM location so patching that one works.
>
> I don't know which direction makes more sense really. If you say merging
> QEMU's DT into U-Boot's is better then board_fix_fdt() could be used for
> the merging I guess. Looks like that could work with
> CONFIG_OF_INITIAL_DTB_READONLY and CONFIG_OF_BOARD_FIXUP set.

Hmmm now I am wondering how this actually works with sbsa. As you
point out it's hard to see how the fdtdec_board_setup() works before
relocation...I don't have the energy to dig into it, though.

The whole this is quite messy due to QEMU's assuming that firmware
does not care about the DT. Since this approach seems to work we can
always revisit it later if problems come up.

So how about you tidy up the other things and add my:

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
