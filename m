Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 659AACD5BA4
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 12:57:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C689184812;
	Tue, 19 May 2026 14:56:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="Gusd5vRz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 99C018465A; Tue, 19 May 2026 11:01:15 +0200 (CEST)
Received: from mail-yx1-xb134.google.com (mail-yx1-xb134.google.com
 [IPv6:2607:f8b0:4864:20::b134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F131384119
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 11:01:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=guodong@riscstar.com
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-65c7a459105so3436026d50.0
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 02:01:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779181271; cv=none;
 d=google.com; s=arc-20240605;
 b=MEEjEiykiEmE6EHLMgwpke84nQv4SHXKD/Eb0D/tnvfbSKtszw9DlI1MuVW/ZFRZCf
 +pANnvPs8s41pZg8MPqKEAbPTYvhoCNz8SH6pZ0njWGncMprhMCQFt5Toz3N+gUt5OQH
 1CsdVd0QIGRqEXQXaGSc6/TQE5gAC0fzVWTz7O9IKVX6al0g3qRHt60iyn1h1Vb4gLo3
 iTAkQ7WFPQOTpXsQ3SMAGtHA50s1AMjlXEqKFXWh+5qgRtb8q0B6agiHqNiYnO3R8b5j
 Jpe97Eyc4VK68qZ97xWVWU/QgSN84jEniWX2bFVgBXdvuAYJCVDF4LHtbcaqLGtjeGWp
 ugAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=NUZGif8F/XP7kXB96WrhMTcAqAMvUXt/XApti0YOHcw=;
 fh=DU9cf0Oo0HHGEMTJtCU4FEP6er5jOf6g+4CyRHytRlI=;
 b=FZ913MBSSCHFmuQ93Uvw3B34hcbcm1JbS46AjPffyy6E+abRVSaU07w+Vr7xcynwlw
 i4ajY5J66EuJAGfYGP0bEMhEd++z8JNMa7igZAjwzwU7pF3JL7GN3dN5p1zfrBu2fUM7
 FnAYyvRfZXvf2J80qCmh934dzWASsyxg6R1+WCp1qDAdNrTRjeYkYNkwSMBkUHLGbTC6
 QR29JSlf425Jgjp2anPdHw+6+r++k626tDgyGhNRmo7aIHH6YipGrNW5ojW4lqDL2agx
 99LL4NMXQowYKcwYwREgnXxK/gygKjg3cW1k+q0CdDglYRziwYxVhnMNWNbWYyZK5V+K
 OypQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1779181271; x=1779786071;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NUZGif8F/XP7kXB96WrhMTcAqAMvUXt/XApti0YOHcw=;
 b=Gusd5vRzhlk2chlhhn9m6//Sarl8vLBtP2LikQPG1aeAlscnWajWo4ZXxVkpfXkzIO
 ZS7fbO46c8XJeU1Ay7TEs9MgYEjnmaTD6FL0fveWOHuCKrCFDXoK5kjHhE2/fPZgw8Gg
 G0q0Zj/E2ie/fJ/5cxnwnv4BA/SVlJ0aWHKvGA43Z9J5y1oNZ0+vD8XqMHheJVdGVtK5
 mHV9eKe1uSd4/KfCQ1/0BJAuUXAatEYc8bZrhRO+5kCYRPL39+GYs6XVZ/o3mzzz6M1R
 JNbowUdcw670ZWvGxi6dejQixsBIIv6qbZuAFbxdz3lFIbbYj9dUr1OzxxAlsudUiulh
 BR0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779181271; x=1779786071;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NUZGif8F/XP7kXB96WrhMTcAqAMvUXt/XApti0YOHcw=;
 b=Tttq6mghCr9RoMr+bAoK7aK9gARCQzkWMlA8NeIISuCEJN6zKK98zMrCJobK3ePAGf
 YJHmUK07868cUzHuAVTUD19278BLgfS4F3bBrTeGMW1m03J4pFQvtsooELuT3z0Tawo7
 EMIqlO1UlI1LGyUN87KFb5+Vk12AO0Ni+Ueql7XuLnFRTemfsZn0KSQ5hVahCV4PpJPU
 L+4XBRu9G+biqv5ebMNVZJXLJDmNFZkysxtuVDzXLCavldTg9XyQDtFv2IK2H9dnhWz3
 +Xrh2VRrPKV4xTFFOAw7vX9vr7j27VmHSQlY+fj35JmU+K5JEt8S99xtpenVISfOtwzg
 fSNQ==
X-Gm-Message-State: AOJu0Yyy1hN5yfuCFeLo1YmtIgZ5uFarYvRhDtB9x3mtel5HqN8ZI8U/
 QIz5bgG8QXHpdfaCeosSExesESOkWP1K+ZMeWzoG12kBLFpQeTcLk3ILd8cC4aJCJO4ENo/OjVv
 UN4lDDkhKMNL0bjUiu4l520EC0ZO/a1ysOkKCWFHvoQ==
X-Gm-Gg: Acq92OG87NY9I0Ll7YMUwhYXjNBvxZSz/KoTHH3qINJt98Nkwfunb69/6tpBaRQ1Ssk
 Uy+CevTK6ZUCfy53kQRA/wyV1Ph1ljNQfezy36vSay5d2LHvtpUOird6W030rrLjljqyX2aEWXd
 Qk4Q97lye53OhB4KrZfK4zoeh8E76A0fqAiOS1QtkszptDgYjLgKivaDYkEK419DiVIctlB9Q+k
 kc9vzTwq8B3LKydLg1W8Yyf4P3EvAQ5pDQQsqN4qwnnmF34CSW2/uTOQ/VmB48dc4YCysTLwMDo
 ZyRRPHxw4XuOU/B3NXvheCKP6QuXQzYZ+vlLK5vg9Lh2m5RKsZkp6ygk
X-Received: by 2002:a05:690e:250b:10b0:657:a6a4:6ee2 with SMTP id
 956f58d0204a3-65e21483a73mr11769108d50.3.1779181271498; Tue, 19 May 2026
 02:01:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260519-b4-k1-spl-bring-up-v4-0-3915a2a904c1@riscstar.com>
 <20260519-b4-k1-spl-bring-up-v4-1-3915a2a904c1@riscstar.com>
 <CANAwSgTNtPsn66vpXRFuh0Qtjq62T5NyAp8XQM10DxbxPASc+A@mail.gmail.com>
In-Reply-To: <CANAwSgTNtPsn66vpXRFuh0Qtjq62T5NyAp8XQM10DxbxPASc+A@mail.gmail.com>
From: Guodong Xu <guodong@riscstar.com>
Date: Tue, 19 May 2026 17:01:00 +0800
X-Gm-Features: AVHnY4LuppldESo2lVv_DS-DLzCdMB0p-qQyEBKVAtresYpbiX7tShgMbiBgNY4
Message-ID: <CAH1PCMZp83uMZ2WSYhuvfvc52tE+k8VcFUPCXXk0ciF5nCzJRg@mail.gmail.com>
Subject: Re: [PATCH v4 01/14] spacemit: k1: support multi-board infrastructure
To: Anand Moon <linux.amoon@gmail.com>
Cc: u-boot@lists.denx.de, Kongyang Liu <seashell11234455@gmail.com>, 
 Yixun Lan <dlan@gentoo.org>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Michal Simek <michal.simek@amd.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Yao Zi <me@ziyao.cc>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, Peter Korsgaard <peter@korsgaard.com>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Raymond Mao <raymond.mao@riscstar.com>, 
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
 Kever Yang <kever.yang@rock-chips.com>, 
 Finley Xiao <finley.xiao@rock-chips.com>, Rick Chen <rick@andestech.com>, 
 Conor Dooley <conor.dooley@microchip.com>, u-boot-spacemit@groups.io, 
 Vincent Legoll <legoll@online.fr>, Huan Zhou <pericycle.cc@gmail.com>, 
 Jamie Gibbons <jamie.gibbons@microchip.com>, 
 Randolph Sheng-Kai Lin <randolph@andestech.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Peng Fan <peng.fan@nxp.com>, Heiko Schocher <hs@nabladev.com>, 
 Casey Connolly <casey.connolly@linaro.org>,
 Justin Swartz <justin.swartz@risingedge.co.za>, 
 Jaehoon Chung <jh80.chung@samsung.com>, David Lechner <dlechner@baylibre.com>, 
 Julien Masson <jmasson@baylibre.com>, Macpaul Lin <macpaul.lin@mediatek.com>, 
 Henrik Grimler <henrik@grimler.se>, Kory Maincent <kory.maincent@bootlin.com>, 
 Anshul Dalal <anshuld@ti.com>, Bo-Chen Chen <rex-bc.chen@mediatek.com>, 
 Justin Klaassen <justin@tidylabs.net>, Guodong Xu <guodong.xu@riscstar.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 19 May 2026 14:56:05 +0200
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

Hi, Anand

On Tue, May 19, 2026 at 1:24=E2=80=AFPM Anand Moon <linux.amoon@gmail.com> =
wrote:
>
> Hi Guodong,
>
> Thanks,
>
> On Tue, 19 May 2026 at 04:08, Guodong Xu <guodong@riscstar.com> wrote:
> >
> > From: Raymond Mao <raymond.mao@riscstar.com>
> >
> > Restructure K1 SoC support to handle multiple boards through a single
> > configuration:
> >
> > 1. Rename bananapi-f3_defconfig to spacemit_k1_defconfig.
> > 2. Move all K1 board files to board/spacemit/k1/.
> > 3. Replace TARGET_BANANAPI_F3 with TARGET_SPACEMIT_K1 and rename the
> >    board's <board>.h header to k1.h.
> >
> > Eliminates the need for board-specific defconfigs while maintaining
> > hardware compatibility.
> >
> > Signed-off-by: Raymond Mao <raymond.mao@riscstar.com>
> > Signed-off-by: Guodong Xu <guodong@riscstar.com>
> >
>
> :~/mainline/u-boot/risc-v/u-boot-riscv$  b4 am
> 20260519-b4-k1-spl-bring-up-v4-0-3915a2a904c1@riscstar.com
> Looking up https://lore.kernel.org/all/20260519-b4-k1-spl-bring-up-v4-0-3=
915a2a904c1@riscstar.com/
> Grabbing thread from
> lore.kernel.org/all/20260519-b4-k1-spl-bring-up-v4-0-3915a2a904c1@riscsta=
r.com/t.mbox.gz
> Analyzing 15 messages in the thread
> Looking for additional code-review trailers on lore.kernel.org
> Analyzing 51 code-review messages
> Checking attestation on all messages, may take a moment...



> ---
>   [PATCH v4 1/14] spacemit: k1: support multi-board infrastructure
>   [PATCH v4 2/14] spacemit: k1: enable SPL with debug UART
>   [PATCH v4 3/14] configs: k1: enable early timer support
>   [PATCH v4 4/14] clk: spacemit: k1: prune SPL clock tree
>   [PATCH v4 5/14] configs: k1: add default option for clock driver in SPL
>   [PATCH v4 6/14] dts: k1: enable clocks in SPL
>   [PATCH v4 7/14] board: k1: initialize clock and serial devices in SPL
>   [PATCH v4 8/14] i2c: k1: add I2C driver support
>   [PATCH v4 9/14] spacemit: k1: add TLV EEPROM support in SPL
>   [PATCH v4 10/14] spacemit: k1: Add DDR firmware support to SPL
>   [PATCH v4 11/14] power: pmic: add support for Spacemit P1 PMIC
>   [PATCH v4 12/14] power: regulator: add support for Spacemit P1 SoC
>   [PATCH v4 13/14] board: k1: enable pmic in spl
>   [PATCH v4 14/14] doc: spacemit: add K1 SPL build and test guide
>   ---
>   NOTE: install dkimpy for DKIM signature verification
> ---
> Total patches: 14
> ---
> Cover: ./v4_20260519_guodong_riscv_spacemit_k1_add_spl_support.cover
>  Link: https://patch.msgid.link/20260519-b4-k1-spl-bring-up-v4-0-3915a2a9=
04c1@riscstar.com
>  Base: base-commit 52ec53db8f18ed476f30de3799067652948eba28 not known, ig=
noring
>        git am ./v4_20260519_guodong_riscv_spacemit_k1_add_spl_support.mbx
> amoon@Dell-5430:~/mainline/u-boot/risc-v/u-boot-riscv$ git am
> ./v4_20260519_guodong_riscv_spacemit_k1_add_spl_support.mbx
> Applying: spacemit: k1: support multi-board infrastructure
> error: patch failed: configs/bananapi-f3_defconfig:6
> error: configs/bananapi-f3_defconfig: patch does not apply
> Patch failed at 0001 spacemit: k1: support multi-board infrastructure

Thanks for trying to apply this =E2=80=94 and sorry the cover-letter depend=
ency
wasn't more visible.

The v4 SPL series depends on my K1 clock/reset/dts migration series,
which is still under review and not yet in mainline.  The cover letter
mentions it in reference [1]:

  https://lore.kernel.org/u-boot/20260510-b4-k1-clk-reset-upstream-dts-v1-0=
-db0b0503ee44@riscstar.com/
[1]

Apply both series in order on origin/master:

  b4 am 20260510-b4-k1-clk-reset-upstream-dts-v1-0-db0b0503ee44@riscstar.co=
m
  git am ./20260510_*.mbx          # migration: 8 patches

  b4 am 20260519-b4-k1-spl-bring-up-v4-0-3915a2a904c1@riscstar.com
  git am ./v4_*.mbx                # SPL: 14 patches

I just re-verified the above on current u-boot/master (38dbe637c9d, post
efi-2026-07-rc3); both series apply cleanly without conflicts.

A combined branch with both stacks is also at:

  https://github.com/docularxu/u-boot/tree/b4/k1-spl-bring-up-v4

Build and test instructions are in patch 14/14
(doc/board/spacemit/k1-spl.rst).

Thanks again for trying it out. Your Tested-by would be very welcome once
you have it building.

BR,
Guodong

> hint: Use 'git am --show-current-patch=3Ddiff' to see the failed patch
> hint: When you have resolved this problem, run "git am --continue".
> hint: If you prefer to skip this patch, run "git am --skip" instead.
> hint: To restore the original branch and stop patching, run "git am --abo=
rt".
> hint: Disable this message with "git config set advice.mergeConflict fals=
e"
> amoon@Dell-5430:~/mainline/u-boot/risc-v/u-boot-riscv$
>
> I could not apply these changes to the U-Boot mainline
> Could you rebase the series on the U-Boot master branch?
>
> Thanks
> -Anand
>
