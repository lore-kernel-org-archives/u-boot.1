Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C0C0E7314F
	for <u-boot@archiver.kernel.org>; Mon,  2 Feb 2026 09:28:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5ADD583DCA;
	Mon,  2 Feb 2026 10:28:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="t1RUj6Hd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5431483DE0; Mon,  2 Feb 2026 10:28:22 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 36CDB83DA7
 for <u-boot@lists.denx.de>; Mon,  2 Feb 2026 10:28:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 85C3743D13;
 Mon,  2 Feb 2026 09:28:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2CD6C116C6;
 Mon,  2 Feb 2026 09:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1770024497;
 bh=wh0tjac2V1GuC8hwd8u3/JzEBa1OWkK5xtFmk5e0o7w=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=t1RUj6HdR3guyiJSk1q8AjLgpL9saLaK4ubAh+5itECPj4+Ewu0WRhswEjJVU5U3o
 SQpoZNrRGVrKwlSKdvTxHd1H9RyYzYD6FBAuWNDfPqM64MHOoma6S6Lcsp0v/mj2LN
 Vu4w20c37tajOrHW5uFzNmXJWmVCW41FohUx0mp7HgOfE2nRcxpT0wo7kHTkgurbi/
 R0B6gJA4SiquDO5OAZngOOam0/3EVIMcTERjnWkJBwslItObdZ8kgKO7F/uPzP+s4Y
 690LHMrLbLnwNk6rfCe7a1f6zhM9wqurJHqT4tfYzZ0z3YbmDTGUadsSnzk6+bR1RG
 mU89AhSrdbF7w==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Julien Stephan <jstephan@baylibre.com>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>
Cc: u-boot@lists.denx.de, GSS_MTK_Uboot_upstream
 <GSS_MTK_Uboot_upstream@mediatek.com>, Julien Masson
 <jmasson@baylibre.com>, Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao
 <weijie.gao@mediatek.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>, Igor
 Belwon <igor.belwon@mentallysanemainliners.org>, Tom Rini
 <trini@konsulko.com>, Macpaul Lin <macpaul.lin@mediatek.com>, Peng Fan
 <peng.fan@nxp.com>, Sam Protsenko <semen.protsenko@linaro.org>, David
 Lechner <dlechner@baylibre.com>
Subject: Re: [PATCH] board: mediatek: add MT8390 EVK board support
In-Reply-To: <CAEHHSvZaOWBS4gZAdNzHkKdgrH2kHw++zXrZKW7TtCmQn5JKWA@mail.gmail.com>
References: <20260123-add-genio-700-board-v1-1-274019c628d1@baylibre.com>
 <87343ooh89.fsf@kernel.org>
 <CAEHHSvZaOWBS4gZAdNzHkKdgrH2kHw++zXrZKW7TtCmQn5JKWA@mail.gmail.com>
Date: Mon, 02 Feb 2026 10:28:14 +0100
Message-ID: <87y0lblck1.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

On Mon, Feb 02, 2026 at 09:31, Julien Stephan <jstephan@baylibre.com> wrote:

> Le jeu. 29 janv. 2026 =C3=A0 11:17, Mattijs Korpershoek
> <mkorpershoek@kernel.org> a =C3=A9crit :
>>
>> Hi Julien,
>>
>> Thank you for the patch.
>>
>> On Fri, Jan 23, 2026 at 09:37, Julien Stephan <jstephan@baylibre.com> wr=
ote:
>>
>> > From: Julien Masson <jmasson@baylibre.com>
>> >
>> > This adds support for the MT8390 EVK board with the following
>> > features enabled/tested: Boot, UART, Watchdog and MMC.
>> >
>> > MT8390 is based on MT8188.
>> >
>> > Signed-off-by: Julien Masson <jmasson@baylibre.com>
>> > Signed-off-by: Julien Stephan <jstephan@baylibre.com>
>> > ---
>> >  board/mediatek/mt8390_evk/MAINTAINERS  |  5 +++++
>> >  board/mediatek/mt8390_evk/Makefile     |  3 +++
>> >  board/mediatek/mt8390_evk/mt8390_evk.c | 34 +++++++++++++++++++++++++=
+++++++++
>> >  configs/mt8390_evk_defconfig           | 27 +++++++++++++++++++++++++=
++
>> >  4 files changed, 69 insertions(+)
>> >
>> > diff --git a/board/mediatek/mt8390_evk/MAINTAINERS b/board/mediatek/mt=
8390_evk/MAINTAINERS
>> > new file mode 100644
>> > index 00000000000..73fc28b096e
>> > --- /dev/null
>> > +++ b/board/mediatek/mt8390_evk/MAINTAINERS
>> > @@ -0,0 +1,5 @@
>> > +MT8390 EVK
>> > +M:   Julien Masson <jmasson@baylibre.com>
>>
>> Since Julien Masson is marked as maintainer here, can we guarantee he
>> will be doing some testing/reviewing on patches for this particular
>> board?
>>
>> If not, maybe find another maintainer.
>>
>
> Hi Mattijs,
>
> I checked with Julien Masson and he wants to be maintainers, but I
> also added Macpaul Lin from Mediatek, as co-maintainer.
>
>> > +S:   Maintained
>> > +F:   board/mediatek/mt8390_evk/
>> > +F:   configs/mt8390_evk_defconfig
>>
>> Could we add this board to the MediaTek board documentation?
>>
>> https://docs.u-boot.org/en/latest/board/mediatek/index.html
>>
>> I know that doc is a bit outdated but it would be nice to improve it and
>> list this board.
>>
>> For me, that can be done in a future series/improvement.
>
> I forwarded the request to Mediatek internal teams, and they will
> handle this internally.
> With the Lunar new year vacation coming they won't be able to do this
> before end of February.
> Same for other new coming boards.

Ok, thank you. looking forward to see some doc updates !

>
> Cheers,
> Julien
>
>>
>> Thanks
>> Mattijs
>>
