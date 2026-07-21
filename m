Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C410EC4451C
	for <u-boot@archiver.kernel.org>; Tue, 21 Jul 2026 20:05:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 64384608AC;
	Tue, 21 Jul 2026 20:05:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id soMi_Yvz4kaC; Tue, 21 Jul 2026 20:05:54 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6AD7560632
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784664354;
	bh=97QvHZvYo2MZvhZAfBIPJpC/5/aItDrstOHjiZH1XTE=;
	h=Date:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=rbiz/mFnQgCdlU10eBJQYf+kO7zMHUe7fyJKdpPd9ohcpLZDVRHocf315GJus3lHf
	 qE5enaPHe5S+nRqjtk+yDhlVadIFgyab2F31+r9TvuTPlHr7yb4vo1aTPQWpijaKzg
	 wvUQKjj+8Ngo4vFawpSC+UNik+ei8N41EDrETSbnkSySrhi7DGu+ZF5oKD+4/P2ljm
	 p6UtUF1sx4RyFk66etY+JtEL/Qcw3Wzb89C8y8fraZ5NRd6Va7Ykcqj7Qfp5+Vmijh
	 YaKRQopVL70K0TK5bWVGwVwkKkKOYE4yjd4fWcR/dBBTxAeAiZbBARFCSCOGaD8I7+
	 dM1Gxd+lBEKew==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6AD7560632;
	Tue, 21 Jul 2026 20:05:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id BE57142A
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 20:05:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A7F4A40838
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 20:05:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vS3JJI5l0N4P for <u-boot@lists.u-boot-project.org>;
 Tue, 21 Jul 2026 20:05:51 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=109.224.244.104;
 helo=mail-244104.protonmail.ch; envelope-from=sputnik@on-the-web.ch;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 1870040828
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1870040828
Received: from mail-244104.protonmail.ch (mail-244104.protonmail.ch
 [109.224.244.104])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1870040828
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 20:05:48 +0000 (UTC)
Date: Tue, 21 Jul 2026 20:05:26 +0000
To: "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>
Cc: Alexey Charkov <alchark@flipper.net>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Tom Rini <trini@konsulko.com>, Jonas Karlman <jonas@kwiboo.se>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Xuhui Lin <xuhui.lin@rock-chips.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 0/7] rockchip: fix boot from SDMMC on RK3576
Message-ID: <-mj8gZELtrWJeeFLCaw39rL0jrHYwmGDsHwx9fof5bU-yF18H0CThDfILBU7eQ-8AdiYZfBrbAti-LfJkf0Ky5lyuxNU8zDJAjJTZBszN1Q=@on-the-web.ch>
In-Reply-To: <20260713-rk3576-boost-v1-0-9d23aa08f674@flipper.net>
References: <20260713-rk3576-boost-v1-0-9d23aa08f674@flipper.net>
Feedback-ID: 61562450:user:proton
X-Pm-Message-ID: a1a6705f3acd770a58e1dc822bd5852ca49b1498
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg=pgp-sha512;
 boundary="------e3298fda1f76595bb1e3e4cfd50bab8cc3407502b8d503fa292bd35448a28e5a";
 charset=utf-8
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=on-the-web.ch; 
 s=protonmail2; t=1784664332; x=1784923532;
 bh=97QvHZvYo2MZvhZAfBIPJpC/5/aItDrstOHjiZH1XTE=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=P/QNkJJ2hifZHaJPnTUXKiHiKiU4tRqIX8QU8FQUrGc2QOHXfArKJkhKJ6o9PA8/C
 TIernXZXp7USr1pkdSkM9QnOdJl8ms4csUle02QcBuA0TfbEvoGyusZqNSmylxZ+oB
 TQLpI5YX9H8CZknupaFEu+1YxdQVY1UFT/O5uz4HbwraLnv0YywFLI5zjv8KPbV2xd
 6UBvaNe8cJTtDeA6JbPAlmNnO5PCYej8Fbd0TlLuyLXqy5WVkTIJw0/OY164okYeq9
 2b515D+Zt2fsqGhR+aBFFg5fhAImusdCQilFlTf+F1b7wHN78byiiH7XBrluW6r2xY
 KToc92D31iBGg==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=on-the-web.ch
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=on-the-web.ch header.i=@on-the-web.ch
 header.a=rsa-sha256 header.s=protonmail2 header.b=P/QNkJJ2
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
From: Martin Herren via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Martin Herren <sputnik@on-the-web.ch>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------e3298fda1f76595bb1e3e4cfd50bab8cc3407502b8d503fa292bd35448a28e5a
Content-Type: multipart/mixed;boundary=---------------------10dfa767e30a95720b2fbdf37f414991

-----------------------10dfa767e30a95720b2fbdf37f414991
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8

Hej Jonas and Alexey,

On Monday, July 13th, 2026 at 12:03 PM, Alexey Charkov <alchark@flipper.ne=
t> wrote:

> This aims to upstream Jonas Karlman's long-standing patch series fixing
> the boot from SDMMC on RK3576, which requires a hotfix to the boot ROM's
> global state area before any SDMMC reads are initiated to avoid clobbing
> the ROM's state and breaking the boot process.
> =


> The preparatory patches for the image tools are submitted verbatim from
> Jonas' version, while the "boost" code doing the actual hotfix is
> converted from using a pre-built tiny binary to a from-source build usin=
g
> the existing U-Boot build system.
> =


> From-source build also alleviates the problem with parallel out-of-tree
> builds, which could skip the pre-built binary but which always pick up t=
he
> from-source build.
> =


> Tested on a number of RK3576 boards, including the Rockchip RK3576 EVB1,
> ArmSoM Sige5, FriendlyElec NanoPi M5, Luckfox Omni3576, Radxa Rock 4D an=
d
> Flipper One, all of which fail to boot from SDMMC without this series bu=
t
> boot fine with it applied.

Thanks for the original patch and reviving it with this v2 !

Comes really at the right time as I'm trying to add Yocto support for the =
Radxa 4D board.

Successfully tested this serie on my Radxa 4D board, even if already repor=
ted as tested.

Tested it on v2026.07 where it applies directly.
Also tested it on v2026.04, in this case 2 additional patches from Jonas a=
lready in v2026.07 must be backported, then it also applies without proble=
ms (little fuzz).

In both situations, once flashed to SPI it boots fine from SD !

Now no need to use the 'WiP' commit on Jonas' branch anymore with the pre-=
built boost.bin as it is now built with the added commit in new serie.

Still SPL is not able to load U-boot proper from SPI (probe failing) and f=
alls back to SD. Saw a few WIP commits on Jonas' kwiboo branches that look=
 like handling that, couldn't get that to work yet. Anyway that is out of =
scope of this patch. So for the scope of this patch it does what it's expe=
cted to do.

Will happily test a potential future v3 if that might be of any help.

Thanks and best regards,

Martin

> =


> I've also done some JTAG debugging of the boot process, and the single-
> word write which the boost binary performs to the SRAM at 0x3ff803b0
> appears to be relocating the base of the SDMMC IDMAC DMA descriptor buff=
er
> to the top of SRAM, which prevents large multi-page SDMMC reads from
> overrunning adjacent ROM state and thus breaking the boot process. A
> comment has been added to the boost code to reflect this.
> =


> Signed-off-by: Alexey Charkov <alchark@flipper.net>
> ---
> Jonas Karlman (7):
>       rockchip: mkimage: Split size_and_off and size_and_nimage
>       rockchip: mkimage: Print image information for all embedded images
>       rockchip: mkimage: Print boot0 and boot1 parameters
>       rockchip: mkimage: Add option to change image offset alignment
>       rockchip: mkimage: Add support for up to 4 input files
>       rockchip: mkimage: Add option for image load address and flag
>       rockchip: mkimage: Add rk3576 align and sd-card workaround
> =


>  arch/arm/mach-rockchip/rk3576/Makefile       |  10 +
>  arch/arm/mach-rockchip/rk3576/rk3576-boost.c |  31 +++
>  tools/rkcommon.c                             | 290 +++++++++++++++++---=
-------
>  tools/rkcommon.h                             |   2 -
>  4 files changed, 228 insertions(+), 105 deletions(-)
> ---
> base-commit: 6741b0dfb41dc82a284ab1cff4c58af6ef2f3f9c
> change-id: 20260713-rk3576-boost-58a5f47e74e3
> =


> Best regards,
> --
> Alexey Charkov <alchark@flipper.net>
> =


> =


-----------------------10dfa767e30a95720b2fbdf37f414991--

--------e3298fda1f76595bb1e3e4cfd50bab8cc3407502b8d503fa292bd35448a28e5a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wrsEARYKAG0Fgmpf0PcJEIiu+thqKlAPRRQAAAAAABwAIHNhbHRAbm90YXRp
b25zLm9wZW5wZ3Bqcy5vcmextHFr7tEZCEuCoUeVxkAVikfTSDZDx9ccCNVg
8YzFcRYhBCYHlZbYUMXC4ILtW4iu+thqKlAPAADYKQD+O9fzwxwazX12e6Sj
4jjHnHuszMbDfIPNizeLrgh5JrgBALRw+lbPRSFHPc8tHLg13g/iou4ydWU9
bn9VkOAJS0kN
=Xox6
-----END PGP SIGNATURE-----


--------e3298fda1f76595bb1e3e4cfd50bab8cc3407502b8d503fa292bd35448a28e5a--

