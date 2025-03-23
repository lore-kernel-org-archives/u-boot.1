Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88B13C28B30
	for <u-boot@archiver.kernel.org>; Sun, 23 Mar 2025 23:53:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DEB82819B1;
	Mon, 24 Mar 2025 00:53:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1FB6681D3B; Mon, 24 Mar 2025 00:53:02 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 13C7D8186D
 for <u-boot@lists.denx.de>; Mon, 24 Mar 2025 00:53:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 02399106F;
 Sun, 23 Mar 2025 16:53:06 -0700 (PDT)
Received: from minigeek.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6E0AC3F58B;
 Sun, 23 Mar 2025 16:52:58 -0700 (PDT)
Date: Sun, 23 Mar 2025 23:52:35 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, Mikhail
 Kalashnikov <iuncuim@gmail.com>, u-boot@lists.denx.de,
 linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 28/34] sunxi: armv8: FEL: save and restore SP_IRQ
Message-ID: <20250323235235.62fde853@minigeek.lan>
In-Reply-To: <8544399.NyiUUSuA9g@jernej-laptop>
References: <20250323113544.7933-1-andre.przywara@arm.com>
 <20250323113544.7933-29-andre.przywara@arm.com>
 <8544399.NyiUUSuA9g@jernej-laptop>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

On Sun, 23 Mar 2025 13:26:34 +0100
Jernej =C5=A0krabec <jernej.skrabec@gmail.com> wrote:

> Dne nedelja, 23. marec 2025 ob 12:35:38 Srednjeevropski standardni =C4=8D=
as je Andre Przywara napisal(a):
> > Thanks for Jernej's JTAG debugging effort, it turns out that the BROM
> > expects SP_IRQ to be saved and restored, when we want to enter back into
> > FEL after the SPL's AArch64 stint.
> > Save and restore SP_IRQ as part of the FEL state handling. The banked
> > MRS/MSR access to SP_IRQ, without actually being in IRQ mode, was
> > introduced with the ARMv7 virtualisation extensions. The Arm Cortex-A8
> > cores used in the A10/A13s or older F1C100s SoCs would not support that,
> > but this code here is purely in the ARMv8/AArch64 code path, so it's
> > safe to use unconditionally.
> >=20
> > Reported-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> > Signed-off-by: Andre Przywara <andre.przywara@arm.com> =20
>=20
> I have sneaky suspicion that this is already the issue on H616, but I
> haven't yet confirmed.

That's actually a very good point: if we reset the core, SP_IRQ should
be reset as well - on all 64-bit SoCs, so also A64, H5, H6 and H616. We
are surely not in an IRQ handler when entering the SPL, so the stack
*content* is not relevant, but it should still point to some writable
memory. So I keep scratching my head how this worked so far. If I find
some time, I will try to dump the SP_IRQ content after reset, on those
SoCs.

> FWIW:
> Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Thanks for that!

Cheers,
Andre

>=20
> Best regards,
> Jernej
>=20
>=20
>=20

