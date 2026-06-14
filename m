Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 443D1CD8CA8
	for <u-boot@archiver.kernel.org>; Sun, 14 Jun 2026 19:55:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7BD3B846A4;
	Sun, 14 Jun 2026 21:55:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="LIvLPEVD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ECACA8484C; Sun, 14 Jun 2026 20:58:12 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1A1183FEE
 for <u-boot@lists.denx.de>; Sun, 14 Jun 2026 20:58:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kauschluss@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 4E831270A5;
 Sun, 14 Jun 2026 20:58:10 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 76sSOjj4v1LJ; Sun, 14 Jun 2026 20:58:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1781463489; bh=jbnNYdasvTdX0t2WXs3DA/dpc8RPrNDrGHkhz72sSno=;
 h=Date:Cc:Subject:From:To:References:In-Reply-To;
 b=LIvLPEVDbp5G8qa+xfrlRAaImj8XwfcLnj0vc8Heklts6tWFmq40dcNb26N9XrgNY
 OwCOFfMF/dIbIJ+xoDaFVUhCiKD1rlBIBxV0Y6BV/8km9eQxO5RTI8GNViRjH/FmrF
 kSZ3AWv4OLOD456JrtaSzZTTNvuKgXezaSr3489McqlAQ0yc6dYyweh+Q7VEcYAXeG
 cl2/kToi8fbEM6HxkfbXJYGbCoQeM2AlsbieJ9kPSWaFVROxd1nc4ETqt0L0gPv9tU
 vLUKI7JsVsbQe3fiX3w2P7MsTageWEQ6SF8FM+kBCiqBsM0WUetkIXtRe/BM/ZChK2
 9hrCzyIhVwCtw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 15 Jun 2026 00:27:52 +0530
Message-Id: <DJ903HFCTCAF.2BQVFT5AQIJMG@disroot.org>
Cc: <u-boot@lists.denx.de>, "Tom Rini" <trini@konsulko.com>, "Alper Nebi
 Yasak" <alpernebiyasak@gmail.com>, "Quentin Schulz"
 <quentin.schulz@cherry.de>, "Bryan Brattlof" <bb@ti.com>, "Yannic Moog"
 <y.moog@phytec.de>, "Wojciech Dubowik" <Wojciech.Dubowik@mt.com>, "Yegor
 Yefremov" <yegorslists@googlemail.com>, "Patrice Chotard"
 <patrice.chotard@foss.st.com>, "Heinrich Schuchardt" <xypron.glpk@gmx.de>,
 "Marek Vasut" <marek.vasut+renesas@mailbox.org>, "Rasmus Villemoes"
 <ravi@prevas.dk>, "Javier Tia" <floss@jetm.me>, "Minkyu Kang"
 <mk7.kang@samsung.com>, "Kaustabh Chakraborty" <kauschluss@disroot.org>,
 "Henrik Grimler" <henrik@grimler.se>, "yan wang" <yan.wang@softathome.com>,
 "Marek Vasut" <marex@nabladev.com>, "Denis Mukhin" <dmukhin@ford.com>
Subject: Re: [PATCH v3 09/10] arch: arm: exynos: add j7xelte binman config
From: "Kaustabh Chakraborty" <kauschluss@disroot.org>
To: "Simon Glass" <sjg@chromium.org>, <me@samcday.com>
References: <20260610-android-binman-v3-0-710298a38fcc@samcday.com>
 <20260610-android-binman-v3-9-710298a38fcc@samcday.com>
 <CAFLszTiUp-araejNuKwR6h6cZK3GU33oPsg18wo0hUDhQ-5Rfg@mail.gmail.com>
In-Reply-To: <CAFLszTiUp-araejNuKwR6h6cZK3GU33oPsg18wo0hUDhQ-5Rfg@mail.gmail.com>
X-Mailman-Approved-At: Sun, 14 Jun 2026 21:55:28 +0200
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

On 2026-06-14 10:03 -06:00, Simon Glass wrote:
> Hi Sam,
>
> On 2026-06-10T01:27:41, Sam Day via B4 Relay
> <devnull+me.samcday.com@kernel.org> wrote:
>> arch: arm: exynos: add j7xelte binman config
>>
>> Note that, as of this commit, j7xelte does not yet exist in U-Boot's
>> upstream DTS tree. It was accepted into next so it should appear here
>> eventually.
>>
>> Link: https://lore.kernel.org/all/177209522223.26390.6219893536178441080=
.b4-ty@kernel.org/
>> Signed-off-by: Sam Day <me@samcday.com>
>>
>> arch/arm/dts/exynos7870-j7xelte-u-boot.dtsi | 26 +++++++++++++++++++++++=
+++
>>  1 file changed, 26 insertions(+)
>
>> diff --git a/arch/arm/dts/exynos7870-j7xelte-u-boot.dtsi b/arch/arm/dts/=
exynos7870-j7xelte-u-boot.dtsi
>> new file mode 100644
>> index 00000000000..0cd4c12a2e4
>> --- /dev/null
>> +++ b/arch/arm/dts/exynos7870-j7xelte-u-boot.dtsi
>
> As already mentioned the commit message only explains the caveat but
> does not say what the patch does. Please add a sentence describing the
> change - i.e. that this wires up binman to produce a DTBH+abootimg
> flashable for the j7xelte's S-BOOT.
>
> Just to check, is exynos7870-j7xelte.dts in the tree somewhere or is
> that coming later?

It's in next now, so it should be there by v7.2.x.

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/ar=
ch/arm64/boot/dts/exynos/exynos7870-j7xelte.dts?h=3Dnext-20260612

>
> Reviewed-by: Simon Glass <sjg@chromium.org>
>
> Regards,
> Simon

