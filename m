Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D5B2C36010
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 10:28:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D74A381E6C;
	Fri, 28 Mar 2025 11:28:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="NX64q9lM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 619C281E8C; Fri, 28 Mar 2025 11:28:52 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A3CD81E1F
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 11:28:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1743157722; x=1743762522; i=xypron.glpk@gmx.de;
 bh=AlVzTVLgBppSmLKwQ2+uFd6LbcbvohuSioTnz/Q0/bw=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=NX64q9lMw+3p7U7IKafY6mvUSKJ3QMnj96wmbbl9Y09lmCfmgDeTf+TiNubsgMLc
 gVUatUV/eMi8owAe26KY/03Qr+0BAwZ/7GSme+eohCmUVZ8ewO7/bGaMyibNqXIFj
 dj3y1quvqAcVAnyeIHVfVqTWkq4K6+dZWtSJ2a1k7/mLhHiEBLKtRTEAASjH98Nu9
 TLFxA1xzkVlGCGvH2jsiv4Moy3O5uynDoiQYJBCfNIR7L5mjoznipUpvX6bWPvd1u
 Ty5LFKNReW5m16Duy2WotR3i3tlypnhZ4d4J/T3Q5eW4HxvZQgVDl1fE7XloEfgcF
 V37/IkaoGh5b0tElFA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.102] ([5.147.80.91]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MLQxN-1tgAYr1h2Z-00Pwbp; Fri, 28
 Mar 2025 11:28:42 +0100
Message-ID: <734a1243-53d5-42da-8d51-bec687f83c5b@gmx.de>
Date: Fri, 28 Mar 2025 11:28:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/18] Annotate switch/case fallthrough cases
To: Andre Przywara <andre.przywara@arm.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
Cc: Marek Vasut <marex@denx.de>, Michal Simek <michal.simek@amd.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 Ramon Fried <rfried.dev@gmail.com>, Joe Hershberger
 <joe.hershberger@ni.com>, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Bin Meng <bmeng.cn@gmail.com>, Anatolij Gustschin <agust@denx.de>,
 Kyungmin Park <kmpark@infradead.org>, Heiko Schocher <hs@denx.de>,
 Jagan Teki <jagan@amarulasolutions.com>, Vignesh R <vigneshr@ti.com>,
 Tudor Ambarus <tudor.ambarus@linaro.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
References: <20250327153313.2105227-1-andre.przywara@arm.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250327153313.2105227-1-andre.przywara@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LiNqn2tkdFZcVdY2wmBCnY0d8rPi5b8RNxMLf4kS8LfW9q2r/zL
 Rm1JUzyfIczLwa37WsPghp+/rnRoPF32hDv4VCzF4iWYWy6n1mYjZysqRf0QR5JWjOgBMBL
 tZm374t5cAoTgiCHsFZZadQcxvvXNcmFtiv2FuLvDw230+VDQVz/Duin7AYb9UfF9zbD4Gz
 i/357MREYCbNJhmGv4c3w==
UI-OutboundReport: notjunk:1;M01:P0:c1DeQN7+Bt4=;QwsnNtm8Ol1pWaGhtdDPP7y+fix
 Gpe9I2ZU83dWpZsuCo9zf9RwDRY1o1SJpf2KVUhUbo5mul83F8YeJ7Wqk9flwCwnvpJPqOWHC
 Vfydxhry9E32B9M1lXjvDOrHWwnvOFliJKZJ8dI5IgoMph+RRjLIynWEspX0/tzpyv/8gVidx
 jzDB1XtaV2c1bQni6dPawFoDOKXcgR/1szBPYD0C/5rnbhgfnYt2smjlCFT6YQq4X0NDSiJrM
 j2mRlJhbwXRRFvdDP+aiYpoWRLIiyx8/AbN7uj9RodihV9cxOb14Jq2h2bULf0Zn7QvQ0AIi0
 bw+0h3y3coCs2SwlqWZ4feW/d5i6oJRKLWTpXAWeBECrN/J55LJgLCCYUxfyqSWYjQI6ZeIFJ
 bBKds494Vz2TjJGDoYu0JPriYe6Xw3fg1rhtmaeq6dpjBUayw+oDcUkLN2hE5WlZ53QA6+d1S
 +MikQLiU5ZZi2Ck5jTSiapk1xj7f1OnjdN/TLpm6Q5xIgtx7rKZExMxiAgKO2vinvPqBCGQWJ
 KJiJVkDSS03I1xXlTiojjcr11L7SqQkxmgXHGz/cOIORHoFS7b/39O/lkvyVR4WMKxkHSOko+
 WikBGdNjY7RvRKwT+DG2CEUf9mLC5rLpqlECNCI2umN3mDIloE2T5j0p648ZXIIRS2ua9nAZ5
 PVInXaTsDdVfkeWtVQFb8xXI3YXbLXh6vt5NtNGXGWBo4IL07ciIRT2Fz9hUynf5YJyqrWkzZ
 OURJEPNTcXpScp2oLWWyD04GdeRb5pHT3Tw1wRaNuIgqO38FRcMLZ2N4Sml+1nENAizmziRdO
 ZIPNA3OTb01jCY+0izUfuV3Dr3gd4wF9vyBZIySlvqlUkDOZNkALmCTR5x5+Ca4rIpubQzlX+
 dvObPzlUvqXhnH1c/A4O2MW+ruGhFWvc3JzqJaClGUxj0Q+j4JxXRfAEGBeIM8cZba3B0MWZG
 cnTjHZ7LNv4DZZG29ZvIBDeMawhNc3OM20Q7e4301nO9AC6tmUs4Wf1IHZ7lRF99kUbuCFZV1
 FwMsJ0nXWm1h4s9jIjG8LOij8Kga2ZSrlZBI/+cjsxEOwZjOgNT0YZuMzr6oJ+1NptMy2u20n
 8ggh1CvtZxz7Zd0wMusx0E5QhGxEbDDDWc1++Ls4TODnsIYbjvKxsMscgLXKtioljNN2TymgU
 JtAmzNpqHVbLHH7U/rCRkSgLbO6fXEe4hrS+FXdRw0Zdess7JHV31pWTvsgxzEUy//kAisxmR
 kkb8L8tr8klhVrxtDAe0Dyy/vEOuE/+hnxFZUK4jDf+YFSC4MsqvNWVui0ZP+1pfMkVFMM6+n
 N2D7Kq7gBwZVROWKLGidhgaSRw5pcWbPGzXf8hKoa8rEyK+hz8l6wQxc7q6siwp6SfPGDqrQl
 SoRO6bX4Pw17e0bb2jZeY2l6WdZHBF8CJEVmMh94N+6GjDvSFtaBAVUhAzX8W0fE9YOdsg06Q
 jVR3XzUmRU1r4skwhAmw5/jgesSI=
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

On 27.03.25 16:32, Andre Przywara wrote:
> C's implicit fallthrough behaviour in switch/case statements can lead to
> subtle bugs. Quite some while ago many compilers introduced warnings in
> those cases, requiring intentional fallthrough's to be annotated.
>
> So far we were not enabling that compiler option, so many ambiguities
> and some bugs in the code went unnoticed.
>
> This series adds the required annotations in code paths that the first
> stage of the U-Boot CI covers. There is a large number of cases left
> in the libbz2 code. The usage of switch/case is borderline insane there,
> labels are hidden in macros, and there are no breaks, but just goto's.
> Upstream still uses very similar code, without any annotations. I still
> am not 100% sure those are meant to fall through or not, and plan to do
> further investigations, but didn't want to hold the rest of the patches
> back. You can see for yourself by applying patch 18/18 and building for
> sandbox64, for instance.

Can we use something like

CFLAGS_REMOVE_bzlib.o =3D -Wimplicit-fallthrough

in the Makefile if that module is too hard to fix?

Best regards

Heinrich

>
> Because of this we cannot quite enable the warning in the Makefile yet,
> but those fixes are worth regardless, and be it to increase readability.
>
> Please not that those patches do not fix anything, really, they just add
> those fallthrough annotations, so the series is not really critical.
>
> Cheers,
> Andre
>
> Andre Przywara (18):
>    spl: mmc: properly annotate fallthrough
>    zlib: annotate switch/case fallthrough cases
>    gadget: f_thor: annotate switch/case fallthrough
>    use proper fallthrough annotations
>    net/net: fix switch/case fallthrough annotations
>    fastboot: annotate switch/case fallthrough case
>    net: sun8i-emac: annotate fallthrough
>    usb: ohci-hcd: annotate switch/case fallthrough
>    usb: xhci: annotate switch/case fallthrough properly (TBF)
>    video: annotate switch/case fall-through
>    net: e1000: annotate switch/case fallthrough
>    mtd: ubi: annotate fallthrough (TBF)
>    arm: mach-k3: am62p: annotate switch/case fallthrough
>    mtd: spi-nor-tiny: annotate switch/case fallthrough
>    mtd: rawnand: nand_base: annotate switch/case fallthrough
>    cmd: pmic: annotate switch/case fallthrough
>    cmd: spl: annotate switch/case fallthrough
>    [DO NOT MERGE] Makefile: enable switch/case fallthrough warnings
>
>   Makefile                              |  1 +
>   arch/arm/mach-k3/am62px/am62p5_init.c |  1 +
>   cmd/pmic.c                            |  1 +
>   cmd/spl.c                             |  2 ++
>   common/command.c                      |  2 +-
>   common/spl/spl_mmc.c                  |  1 +
>   drivers/fastboot/fb_command.c         |  1 +
>   drivers/mtd/nand/raw/nand_base.c      |  4 ++++
>   drivers/mtd/spi/spi-nor-tiny.c        |  1 +
>   drivers/mtd/ubi/attach.c              |  1 +
>   drivers/mtd/ubi/build.c               |  3 +++
>   drivers/net/e1000.c                   |  2 ++
>   drivers/net/sun8i_emac.c              |  1 +
>   drivers/usb/gadget/f_thor.c           |  1 +
>   drivers/usb/host/ohci-hcd.c           |  3 ++-
>   drivers/usb/host/xhci.c               |  2 +-
>   drivers/video/video-uclass.c          |  2 ++
>   lib/tiny-printf.c                     |  2 +-
>   lib/zlib/inflate.c                    | 21 +++++++++++++++++++++
>   net/net.c                             |  5 ++---
>   20 files changed, 50 insertions(+), 7 deletions(-)
>

