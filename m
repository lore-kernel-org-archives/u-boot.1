Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E293FA1FD9
	for <u-boot@archiver.kernel.org>; Wed, 22 Apr 2026 17:51:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C3B4842C4;
	Wed, 22 Apr 2026 19:51:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="c/PRZUX6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88FC9842D7; Wed, 22 Apr 2026 19:51:23 +0200 (CEST)
Received: from mail-oa1-x42.google.com (mail-oa1-x42.google.com
 [IPv6:2001:4860:4864:20::42])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EAAD884255
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 19:51:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x42.google.com with SMTP id
 586e51a60fabf-40f1ffba6a0so4060804fac.0
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 10:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1776880279; x=1777485079; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=TKjtqQWsZUwJWnj9Yuqm1QvfU9yEhcgCi0KdCsEvitw=;
 b=c/PRZUX6VylqVoTyIKnKMQwdmihXZb+rVykUYm5ZHsrj50ffr+Xsxtp1yhvLFBi7UE
 CjMYumo3/3ec24yMKs9A4ObDG+E58SzryazV+b5lNaEIPT1PLVTzlhNjCwFj0IJcemJ5
 yNVnHXCnqtTUbCjH/ktqy/pJo7Qdz4CTab/wQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776880279; x=1777485079;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TKjtqQWsZUwJWnj9Yuqm1QvfU9yEhcgCi0KdCsEvitw=;
 b=LEAICvOCCglmXfAxxW69Inl1inGJ2l8VYbnv36APTjQqq2bkS6QFeOSlHDf/RWzgyE
 HNwVYWaT6DfJmYzoKiGmC/PBNsT5tl2kqdUT4ezDILiyO7QkmW9LVv8CLYgXXzHOzMOv
 d6vSLsvxshZCuNCXNY8zQsu225qLLRwCdn2U6jnlvUm8P4KskBt6Pr/pKQ/9ZNj/TM9H
 TAUMzoE+79lnFqxQEpBPzE6qahyyUDPjCTscvAvJM1gMLYooCl2P2oEN2TXV7LZtuUT6
 uIIzulVdP0wrmkmLTmLD9THu0vW8jZzcnewAyTTflR/E3zuChpM7S+7T2NQ7BLiWxR0+
 3FvQ==
X-Gm-Message-State: AOJu0YwJxzz+xBm4ofNce+9oMU4CT5RSFkwSg6Q6wlLzu5+KHLq7hxp/
 iyXZNPG0si+ZpeUko86+TEHnFrMeQkjrxwuwzvwRSoX+p9U5OqKMyaTDAeathWDFHxY=
X-Gm-Gg: AeBDiev26hLm3AOQOYtvL9kg4XnLPgAkiRpfHLHO0xVz4pdQ83PWnigCAeE/x8aRBAN
 gjD3fAP0Papk/vlY77qeNdtopJ8TGP61lKZci2BK+dps5P7i/Bg0sueN76N1zQW2CufX4vgyD+I
 0Q2rCAWqQHuZBSJcuAsCxnvNS6Cr+YZjoIOdTPUEJg5mPjUr0mzf0toXGF+2GALMxdToMsPgqXG
 pTvxE+vv1w7Rnqmq4s66wuQiOHqZ8mjDeq9xuT+ypvTs+aUK9IfBFRndUCB/KCI+1YB1mELav+U
 h7ZkZrn1GoXkJd97ETxhA5K51EJYRmhq1YMwdsF/6aSq0oTekIxWLFrh+2A6O1aTNCu3AfDaeO2
 WsuxqbrdYVNT5XsejvUuK3/U9yl65EV0P3Ksh0BMRv6UxsdSwRtWfvNZ2sZ0OG3K3sCRInDRNv9
 VZxOHkoqX2z2zr7a4ZUJvjGTDDbmfDdZ4nqCfq/s7whISh8MWjbBMWeItUQlPGTxrWzZrAfjosC
 OHYo3vQcQLnvuxNpwPHNzajj0utTqctANoOsAP4w0du3+o5SSR1J5lf8wmCfg==
X-Received: by 2002:a05:6820:1891:b0:694:9fa0:aa4a with SMTP id
 006d021491bc7-6949fa0bc40mr3569033eaf.44.1776880279490; 
 Wed, 22 Apr 2026 10:51:19 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-694984114f5sm3504387eaf.7.2026.04.22.10.51.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 10:51:18 -0700 (PDT)
Date: Wed, 22 Apr 2026 11:51:16 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Xuhui Lin <xuhui.lin@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Dmitrii Sharshakov <d3dx12.xx@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: Couple of clang warnings for Rockchip boards
Message-ID: <20260422175116.GF41863@bill-the-cat>
References: <f8f4e639-0e73-4d14-828a-92dbfe5526ba@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="WiPuCqNHHhyqrAce"
Content-Disposition: inline
In-Reply-To: <f8f4e639-0e73-4d14-828a-92dbfe5526ba@cherry.de>
X-Clacks-Overhead: GNU Terry Pratchett
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


--WiPuCqNHHhyqrAce
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 22, 2026 at 03:25:55PM +0200, Quentin Schulz wrote:

> Hi all,
>=20
> I'm looking into force-enabling CONFIG_WERROR for all Rockchip SoCs. Firs=
t,
> let me know if this is a bad idea :)

This is how CI works, so this part should go fine.

> gcc version 15.2.1 20250808 (Red Hat Cross 15.2.1-1) (GCC) for both ARM a=
nd
> Aarch64 machines report no warnings (built with a config fragment enabling
> CONFIG_WERROR).
>=20
> For clang, I went for cross-compiling using either
> make HOSTCC=3Dclang CROSS_COMPILE=3Darm-linux-gnu- CC=3Dclang O=3Dbuild/ =
=2E..
> or
> make HOSTCC=3Dclang CROSS_COMPILE=3Daarch64-linux-gnu- CC=3Dclang O=3Dbui=
ld/ ...

I'm adding in Dmitrii here because I thought we had fixed clang builds
again rather recently, but I haven't put them in CI and I thought we
might also need another Kbuild re-sync for a few more things too.

> First things first, I can't even build any of the Aarch32/ARM with clang =
for
> some reason, so this only applies for Aarch64 Rockchip platforms.
>=20
> Some platforms couldn't be built due to hitting the max TPL limit (e.g.
> PX30).

I've also run in to this over the years trying to test clang and having
LTO not work, or be very much larger than expected. Just FYI.

> clang version 21.1.8 (Fedora 21.1.8-4.fc43) (or clang version 22.1.1 (Fed=
ora
> 22.1.1-2.fc44), doesn't matter) issues three warnings:
>=20
> 1. Chromebooks EC fails to build:
> In file included from
> /home/qschulz/work/upstream/u-boot/drivers/misc/cros_ec.c:21:
> In file included from
> /home/qschulz/work/upstream/u-boot/include/cros_ec.h:12:
> /home/qschulz/work/upstream/u-boot/include/ec_commands.h:3578:2: error:
> field  within 'struct ec_params_charge_state' is less aligned than 'union
> ec_params_charge_state::(anonymous at
> /home/qschulz/work/upstream/u-boot/include/ec_commands.h:3578:2)' and is
> usually due to 'struct ec_params_charge_state' being packed, which can le=
ad
> to unaligned accesses [-Werror,-Wunaligned-access]
>  3578 |         union {
>       |         ^
>=20
> The following
>=20
> diff --git a/include/ec_commands.h b/include/ec_commands.h
> index 23597d28b2c..c5f9777c0c7 100644
> --- a/include/ec_commands.h
> +++ b/include/ec_commands.h
> @@ -3575,7 +3575,7 @@ enum charge_state_params {
>=20
>  struct __ec_todo_packed ec_params_charge_state {
>  	uint8_t cmd;				/* enum charge_state_command */
> -	union {
> +	union __ec_todo_packed {
>  		struct __ec_align1 {
>  			/* no args */
>  		} get_state;
>=20
> seems to fix it. The upstream EC git repo
> (https://chromium.googlesource.com/chromiumos/platform/ec) has a commit w=
ith
> more changes, see 65da9cc08766 ("include/ec_commands.h: Fix unaligned acc=
ess
> warnings"). It doesn't apply cleanly (and I haven't looked into other
> patches to backport for this to apply cleanly). I'm not sure what we're
> supposed to do here? I also don't have a Chromebook to test.

I would just go with making the changes we need to make here, and cc'ing
some board maintainers for functional testing.

> 2. RK3528, RK3576 and RK3588 boards fail with (replace rk3528 in path for
> the other SoCs)
>=20
> /home/qschulz/work/upstream/u-boot/arch/arm/mach-rockchip/rk3528/rk3528.c=
:98:45:
> error: value size does not match register size specified by the constraint
> and modifier [-Werror,-Wasm-operand-widths]
>    98 |         asm volatile("msr cntfrq_el0, %0" : : "r"
> (CONFIG_COUNTER_FREQUENCY));
>       |                                                    ^
> include/generated/autoconf.h:372:34: note: expanded from macro
> 'CONFIG_COUNTER_FREQUENCY'
>   372 | #define CONFIG_COUNTER_FREQUENCY 24000000
>       |                                  ^
> /home/qschulz/work/upstream/u-boot/arch/arm/mach-rockchip/rk3528/rk3528.c=
:98:32:
> note: use constraint modifier "w"
>    98 |         asm volatile("msr cntfrq_el0, %0" : : "r"
> (CONFIG_COUNTER_FREQUENCY));
>       |                                       ^~
>       |                                       %w0
>=20
> Note that all Rockchip SoCs have CONFIG_COUNTER_FREQUENCY set to 24000000.
>=20
> The cntfrq_el0 register is 64b (https://developer.arm.com/documentation/d=
di0601/2026-03/AArch64-Registers/CNTFRQ-EL0--Counter-timer-Frequency-Regist=
er?lang=3Den),
> though the top 32b are reserved. Android decided to ignore this warning in
> the Little Kernel with https://android.googlesource.com/kernel/lk/+/92354=
1d4c23565a47d020d84202a6f77d22fc149%5E%21/.
>=20
> I tried to follow clang's recommendation and switch this to %w0 but it fa=
ils
> with:
>=20
> /tmp/rk3588-a0a4b8.s: Assembler messages:
> /tmp/rk3588-a0a4b8.s:87: Error: operand mismatch -- `msr cntfrq_el0,w9'
> /tmp/rk3588-a0a4b8.s:87: Info:    did you mean this?
> /tmp/rk3588-a0a4b8.s:87: Info:    	msr cntfrq_el0, x9
> clang: error: assembler command failed with exit code 1 (use -v to see
> invocation)
>=20
> I tried casting CONFIG_COUNTER_FREQUENCY into a u64 and it builds and no
> magic smoke when booting a board. Whether this is the proper fix, I don't
> know, but the warning is then gone. We could also decide to ignore the
> warning like for Android's Little Kernel (where and how much this is used=
 is
> unclear as the repo isn't seeing much activity).
>=20
> The register documentation indicates this is not used by the hardware at
> all, so even if it was broken, we probably wouldn't see a difference?

Can we define it as 24000000ULL? Maybe. If not 0x16e3600ULL with a
comment should work.

> 3. Boards building USB TCPM fail with
>=20
> In file included from
> /home/qschulz/work/upstream/u-boot/drivers/usb/tcpm/tcpm-uclass.c:12:
> In file included from
> /home/qschulz/work/upstream/u-boot/include/usb/tcpm.h:12:
> /home/qschulz/work/upstream/u-boot/include/usb/pd.h:212:2: error: field
> within 'struct pd_message' is less aligned than 'union
> pd_message::(anonymous at
> /home/qschulz/work/upstream/u-boot/include/usb/pd.h:212:2)' and is usually
> due to 'struct pd_message' being packed, which can lead to unaligned
> accesses [-Werror,-Wunaligned-access]
>   212 |         union {
>       |         ^
>=20
> This file is apparently adapted from upstream Linux, where the code is
> identical for that struct. So not sure what to do here.

I'm not sure either.

--=20
Tom

--WiPuCqNHHhyqrAce
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaekKkQAKCRAr4qD1Cr/k
ClmwAP9biF7/4vMue3kRtm9GpEc/npNbivec8PfZviFW7T7PiQEA2VkCSo0TOq5c
j7iiC9GQoFUJI56afaAToCNC+rrxtgc=
=Ti4n
-----END PGP SIGNATURE-----

--WiPuCqNHHhyqrAce--
