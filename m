Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EC49FF885C
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 17:44:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C62A183FF5;
	Sat, 25 Apr 2026 19:44:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EoZPBi1z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B803384099; Sat, 25 Apr 2026 19:44:23 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21F46839D9
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 19:44:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-b9c3a9fe80fso1303957666b.3
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 10:44:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777139060; cv=none;
 d=google.com; s=arc-20240605;
 b=D9jpYtrhchtQXTO8mZLBnP9ZDigDzUDUk1QVA9mC+qxxB7f9mRu0o2K3NvQnOLLSgg
 YZtzlCv/Tlg1vNjo0Nko2oH42PAMpIEZP7YFnxxxfgQK9AoKgFODWYvxP2vmVPHPolgE
 Iw4iBbS2T6UDy9yoS/ZvUAUq3OK+Sz+TkHCkptjehQFw2zIRayYYZf5rxShVADCBiZMD
 Vh8HPLL/oy8cNoXZcwdOQX4UQL5d9veyxreRt3ooMw1l/Ek9FrKcZR8WY42mY1NRsU8O
 euc1GLCvc2xCIlwbyF7Z4KWynFDTgQdV9ZEEyp1N7aeC1HTo8LqdpWvLy5XoyYX4mXHM
 rToA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Xle9QJh/RM+zA0Ux2vM9d7bPxom3MTunr5DFc5mUH5k=;
 fh=gXGkhr1MrhK2wEDleHYXVHAigNGe1Sk0dnbdYi9qgxA=;
 b=b3xg7RwbTD+Ue599TOZYuncZex4qgSpxZs3hsFE5/wNQ9mDVWzY4WutsiePIVinP/e
 zMRX7gh1Ci+lreO+Hki2QxGSCSokiAmL0wCv3qxL085jhObAl+5CsQdkNE8qTeIzVGFp
 lZ3cjbdMYlITOI4HrROxfZfDiCyJpXjY1vV8p3IyYR/4dBOiZP3WwEqZ7OPLs4zAr2EG
 La9x2H/aQn7ewYWlo1Xyi895UrFMrJc6573J0b/ZPkgH64zGeq1H3K3G0BkbY8DUq4aB
 gVqoehQuZU652uQVwoeGkEhcE3uPurK+kC2bzmjvmwhex/f3fPT8qLNobct3m54gokAi
 1CKw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777139060; x=1777743860; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Xle9QJh/RM+zA0Ux2vM9d7bPxom3MTunr5DFc5mUH5k=;
 b=EoZPBi1zTU2KiGsu4mXNTIZysdg1PM3om7EEM6V0b7tbNaC+b4lA+DAN0MebdQ/56u
 3cqoB1Mt0CYk0RpbTxmc3x1DA/mElSzrCT3DDNae+8a9V2O7nZ9jwMd8Q9DvlQhnmX5G
 FVGfKNjncXfbZcEPJeQjFrtnzKRWcKYerHRKI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777139060; x=1777743860;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xle9QJh/RM+zA0Ux2vM9d7bPxom3MTunr5DFc5mUH5k=;
 b=g1z95b23Gxirfyg74+wdQ9BeWT4zkOINS03eaCL5p0R56Ml4R7hU+wwt49DbPlRSjf
 0BY/KzacpTFU+dfMM2P0CNd/d1Re3GfYFlmpN7w/N17GzsENDjA4mdCgwXniAxpK+R2L
 i8IJZLGrHt31IgVV/KBot5GI56z/0nUB0GxZd4bQ6H8fZq6QXQpy9UvZlv5qB+BZGve+
 kICQT3yz80K8T33cLyIZEUknOLaBpp2ER0u2m6bm3BTfC0jCgi/fA8fF0Ts2vlHVAGB4
 TooHPEmj/zwqRbCQyRGDdPP9r7jxmSPkZ95v1XeCA2rdGtwIxoi9Y8zJpNI7hnVhPUoo
 UR1g==
X-Gm-Message-State: AOJu0YxV5oJ4R/GFkYv1ZXkV9Alcv/qmQ6PE5+9PpEzOLembpSDMN2hc
 w8xdX86cGyU8ku1OtucQTGgFScuoV5J5u9PZY/ddcLfo47nvdsV3RgQYenb684cAF8QFU319NIJ
 Kn8a+SPR7kx0gO1NaI369VCok5tmUJvwlg6n9HPfMPHVWt8/6KpysUQ==
X-Gm-Gg: AeBDiesR2BH8ECLbRsrHW4JSkKKsrJjS2pdg1qgxcvAUdLjl1CBHEV3VreTEgJCQ9KA
 gn8q96pFk9hqRpBxCACUfaV78iBN4pa9c5YHXEz6CsxZHO3II9c/KkCpZYjzFOExYSS/1Pss7Gr
 pt+0TMyepLdhSu8CGpjL60nDYM2DH8g2VnQk9sVW6qLCbSsSTKoJR6it7GcOks0Yj0ZvyoxB0zR
 XtDjwL3SYlh3U2JCVoP6DVInXW5Xy2K37n9yEK8ERvWOJkXVFkmN5mnK16GVqcP5QJ5c3GXzLFa
 7HR/9ubr4nBP7JfWurew
X-Received: by 2002:a17:907:a688:b0:b94:a1d4:ceff with SMTP id
 a640c23a62f3a-ba41adf8eb9mr1253267866b.35.1776895033995; Wed, 22 Apr 2026
 14:57:13 -0700 (PDT)
MIME-Version: 1.0
References: <f8f4e639-0e73-4d14-828a-92dbfe5526ba@cherry.de>
In-Reply-To: <f8f4e639-0e73-4d14-828a-92dbfe5526ba@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 23 Apr 2026 09:57:00 +1200
X-Gm-Features: AQROBzAUS1TkeShpy4fKRxS3FwFIhFO-kQf2xQXVf4sa9EK20p0v7A9MJVkj9i8
Message-ID: <CAFLszTjWZ9DBKVui_2EE-nSg8K+5eC9V8jvwp638dLeyp_p6vw@mail.gmail.com>
Subject: Re: Couple of clang warnings for Rockchip boards
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Xuhui Lin <xuhui.lin@rock-chips.com>, 
 Heiko Stuebner <heiko@sntech.de>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>
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

Hi Quentin,

On Thu, 23 Apr 2026 at 01:26, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>
> Hi all,
>
> I'm looking into force-enabling CONFIG_WERROR for all Rockchip SoCs.
> First, let me know if this is a bad idea :)

I don't like it, as it makes development slower. I like to see all the
warnings created by a change and tend to fix them iteratively. We
already have a warning check in CI. A better approach is to

Can you use: KCFLAGS=-Werror

either in your environment or on the 'make' cmdline?

>
> gcc version 15.2.1 20250808 (Red Hat Cross 15.2.1-1) (GCC) for both ARM
> and Aarch64 machines report no warnings (built with a config fragment
> enabling CONFIG_WERROR).
>
> For clang, I went for cross-compiling using either
> make HOSTCC=clang CROSS_COMPILE=arm-linux-gnu- CC=clang O=build/ ...
> or
> make HOSTCC=clang CROSS_COMPILE=aarch64-linux-gnu- CC=clang O=build/ ...
>
> First things first, I can't even build any of the Aarch32/ARM with clang
> for some reason, so this only applies for Aarch64 Rockchip platforms.
>
> Some platforms couldn't be built due to hitting the max TPL limit (e.g.
> PX30).

It's interesting that clang code is larger than gcc. There was a time
that I thought clang would replace gcc. But clang is much slower and
if it doesn't provide code-size benefits, I'm not sure that will
happen. We all use it as an lsp though, at least.

>
> clang version 21.1.8 (Fedora 21.1.8-4.fc43) (or clang version 22.1.1
> (Fedora 22.1.1-2.fc44), doesn't matter) issues three warnings:
>
> 1. Chromebooks EC fails to build:
> In file included from
> /home/qschulz/work/upstream/u-boot/drivers/misc/cros_ec.c:21:
> In file included from
> /home/qschulz/work/upstream/u-boot/include/cros_ec.h:12:
> /home/qschulz/work/upstream/u-boot/include/ec_commands.h:3578:2: error:
> field  within 'struct ec_params_charge_state' is less aligned than
> 'union ec_params_charge_state::(anonymous at
> /home/qschulz/work/upstream/u-boot/include/ec_commands.h:3578:2)' and is
> usually due to 'struct ec_params_charge_state' being packed, which can
> lead to unaligned accesses [-Werror,-Wunaligned-access]
>   3578 |         union {
>        |         ^
>
> The following
>
> diff --git a/include/ec_commands.h b/include/ec_commands.h
> index 23597d28b2c..c5f9777c0c7 100644
> --- a/include/ec_commands.h
> +++ b/include/ec_commands.h
> @@ -3575,7 +3575,7 @@ enum charge_state_params {
>
>   struct __ec_todo_packed ec_params_charge_state {
>         uint8_t cmd;                            /* enum charge_state_command */
> -       union {
> +       union __ec_todo_packed {
>                 struct __ec_align1 {
>                         /* no args */
>                 } get_state;
>
> seems to fix it. The upstream EC git repo
> (https://chromium.googlesource.com/chromiumos/platform/ec) has a commit
> with more changes, see 65da9cc08766 ("include/ec_commands.h: Fix
> unaligned access warnings"). It doesn't apply cleanly (and I haven't
> looked into other patches to backport for this to apply cleanly). I'm
> not sure what we're supposed to do here? I also don't have a Chromebook
> to test.

It should be possible to backport this, to avoid divergence. I could
look at that if you like.

For now you could use a #pragma just around the header include, or in cros_ec.c

I don't think you need to worry about the struct going wrong, so long
as the size remains the same. There are two Chromebooks in the SJG lab
you can try it with: bob and kevin

>
> 2. RK3528, RK3576 and RK3588 boards fail with (replace rk3528 in path
> for the other SoCs)
>
> /home/qschulz/work/upstream/u-boot/arch/arm/mach-rockchip/rk3528/rk3528.c:98:45:
> error: value size does not match register size specified by the
> constraint and modifier [-Werror,-Wasm-operand-widths]
>     98 |         asm volatile("msr cntfrq_el0, %0" : : "r"
> (CONFIG_COUNTER_FREQUENCY));
>        |                                                    ^
> include/generated/autoconf.h:372:34: note: expanded from macro
> 'CONFIG_COUNTER_FREQUENCY'
>    372 | #define CONFIG_COUNTER_FREQUENCY 24000000
>        |                                  ^
> /home/qschulz/work/upstream/u-boot/arch/arm/mach-rockchip/rk3528/rk3528.c:98:32:
> note: use constraint modifier "w"
>     98 |         asm volatile("msr cntfrq_el0, %0" : : "r"
> (CONFIG_COUNTER_FREQUENCY));
>        |                                       ^~
>        |                                       %w0
>
> Note that all Rockchip SoCs have CONFIG_COUNTER_FREQUENCY set to 24000000.
>
> The cntfrq_el0 register is 64b
> (https://developer.arm.com/documentation/ddi0601/2026-03/AArch64-Registers/CNTFRQ-EL0--Counter-timer-Frequency-Register?lang=en),
> though the top 32b are reserved. Android decided to ignore this warning
> in the Little Kernel with
> https://android.googlesource.com/kernel/lk/+/923541d4c23565a47d020d84202a6f77d22fc149%5E%21/.
>
> I tried to follow clang's recommendation and switch this to %w0 but it
> fails with:
>
> /tmp/rk3588-a0a4b8.s: Assembler messages:
> /tmp/rk3588-a0a4b8.s:87: Error: operand mismatch -- `msr cntfrq_el0,w9'
> /tmp/rk3588-a0a4b8.s:87: Info:    did you mean this?
> /tmp/rk3588-a0a4b8.s:87: Info:          msr cntfrq_el0, x9
> clang: error: assembler command failed with exit code 1 (use -v to see
> invocation)
>
> I tried casting CONFIG_COUNTER_FREQUENCY into a u64 and it builds and no
> magic smoke when booting a board. Whether this is the proper fix, I
> don't know, but the warning is then gone. We could also decide to ignore
> the warning like for Android's Little Kernel (where and how much this is
> used is unclear as the repo isn't seeing much activity).
>
> The register documentation indicates this is not used by the hardware at
> all, so even if it was broken, we probably wouldn't see a difference?

Similar to what Tom says...does this work?:

asm volatile("msr cntfrq_el0, %0" : : "r"
  ((u64)CONFIG_COUNTER_FREQUENCY));

>
> 3. Boards building USB TCPM fail with
>
> In file included from
> /home/qschulz/work/upstream/u-boot/drivers/usb/tcpm/tcpm-uclass.c:12:
> In file included from
> /home/qschulz/work/upstream/u-boot/include/usb/tcpm.h:12:
> /home/qschulz/work/upstream/u-boot/include/usb/pd.h:212:2: error: field
> within 'struct pd_message' is less aligned than 'union
> pd_message::(anonymous at
> /home/qschulz/work/upstream/u-boot/include/usb/pd.h:212:2)' and is
> usually due to 'struct pd_message' being packed, which can lead to
> unaligned accesses [-Werror,-Wunaligned-access]
>    212 |         union {
>        |         ^
>
> This file is apparently adapted from upstream Linux, where the code is
> identical for that struct. So not sure what to do here.

Maybe add __packed ?

Regards,
Simon
