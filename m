Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F2FDEDE998
	for <u-boot@archiver.kernel.org>; Wed, 11 Sep 2024 07:23:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CD7B891F3;
	Wed, 11 Sep 2024 09:23:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="czRe1hp+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 548CB891EF; Wed, 11 Sep 2024 09:23:07 +0200 (CEST)
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de
 [130.133.4.66])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F805891FB
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 09:23:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=physik.fu-berlin.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=glaubitz@zedat.fu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
 Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=YxfH4SCp64Sp4wc5CgzohiYmiVXioy+W0BhB/7y3sOw=; t=1726039385; x=1726644185; 
 b=czRe1hp+kqpgQF6Tva9+N+ctCxrc2rgN0T0XoWjodTTZ0KEJhpHVqBL1HasGQraqcYxHvFw1ynA
 1dM4mUfJ4EvdVT0e+xiHzrY3/4R26+klqqrxW63UVk/4SxJ8W+46qFMBmNJhB3Ua6mUw9dua0sFs9
 6YiaYv7YMzc85Hhz0HGb9Ee9GZIdLlS6i+jy8ak7+2ror2D/B219Dyk+/7z982QLpgB8U4eWlXST3
 uq1E5Cf7YDlIY5pjiZz+mBK0WEE8Pos4K3n79mHCB2Wvnu1nF2ESaqXcXD9/MSQrXHdUDD1HcBNXZ
 FrQCLnKY6RsbI9kqQGPWEkb+V6nrPvEDJVXw==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
 by outpost.zedat.fu-berlin.de (Exim 4.98) with esmtps (TLS1.3)
 tls TLS_AES_256_GCM_SHA384
 (envelope-from <glaubitz@zedat.fu-berlin.de>)
 id 1soHgu-0000000464M-0e3R; Wed, 11 Sep 2024 09:23:04 +0200
Received: from p5b13a8f8.dip0.t-ipconnect.de ([91.19.168.248]
 helo=[192.168.178.20]) by inpost2.zedat.fu-berlin.de (Exim 4.98)
 with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (envelope-from <glaubitz@physik.fu-berlin.de>)
 id 1soHgt-00000000evk-3vyO; Wed, 11 Sep 2024 09:23:04 +0200
Message-ID: <2c133f811fca225a0f796b8b94b16e63b33e56a6.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] sh: cache: Fill in invalidate_icache_all()
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>, Marek Vasut
 <marek.vasut@mailbox.org>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>,  u-boot@lists.denx.de, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>,  Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Linux-sh list <linux-sh@vger.kernel.org>
Date: Wed, 11 Sep 2024 09:23:03 +0200
In-Reply-To: <CAMuHMdVvHtVmH+YP=m20U9-buXKi1+Kwcrkf8vWhQYagcg4JRQ@mail.gmail.com>
References: <20240910001612.88569-1-marek.vasut+renesas@mailbox.org>
 <20240910172151.GG4252@bill-the-cat>
 <1cd4c1c1-b709-43aa-aff8-14cb1d21aee2@mailbox.org>
 <CAMuHMdVvHtVmH+YP=m20U9-buXKi1+Kwcrkf8vWhQYagcg4JRQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 91.19.168.248
X-ZEDAT-Hint: PO
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

Good morning Geert,

On Wed, 2024-09-11 at 09:19 +0200, Geert Uytterhoeven wrote:
> Hi Marek,
>=20
> On Tue, Sep 10, 2024 at 7:55=E2=80=AFPM Marek Vasut <marek.vasut@mailbox.=
org> wrote:
> > On 9/10/24 7:21 PM, Tom Rini wrote:
> > > On Tue, Sep 10, 2024 at 02:15:58AM +0200, Marek Vasut wrote:
> > >=20
> > > > Implement invalidate_icache_all() by clearing all V bits in
> > > > IC and OC. This is done by setting CCR cache control register
> > > > ICI and OCI bits.
> > > >=20
> > > > Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> > > > ---
> > > > Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > > > Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> > > > Cc: Tom Rini <trini@konsulko.com>
> > > > Cc: u-boot@lists.denx.de
> > > > ---
> > > >   arch/sh/cpu/sh4/cache.c | 11 +++++++----
> > > >   1 file changed, 7 insertions(+), 4 deletions(-)
> > > >=20
> > > > diff --git a/arch/sh/cpu/sh4/cache.c b/arch/sh/cpu/sh4/cache.c
> > > > index d3c480e79ed..99acc599965 100644
> > > > --- a/arch/sh/cpu/sh4/cache.c
> > > > +++ b/arch/sh/cpu/sh4/cache.c
> > > > @@ -33,8 +33,9 @@ static inline void cache_wback_all(void)
> > > >      }
> > > >   }
> > > >=20
> > > > -#define CACHE_ENABLE      0
> > > > -#define CACHE_DISABLE     1
> > > > +#define CACHE_ENABLE                0
> > > > +#define CACHE_DISABLE               1
> > > > +#define CACHE_INVALIDATE    2
> > > >=20
> > > >   static int cache_control(unsigned int cmd)
> > > >   {
> > > > @@ -46,7 +47,9 @@ static int cache_control(unsigned int cmd)
> > > >      if (ccr & CCR_CACHE_ENABLE)
> > > >              cache_wback_all();
> > > >=20
> > > > -    if (cmd =3D=3D CACHE_DISABLE)
> > > > +    if (cmd =3D=3D CACHE_INVALIDATE)
> > > > +            outl(CCR_CACHE_ICI | ccr, CCR);
> > > > +    else if (cmd =3D=3D CACHE_DISABLE)
> > > >              outl(CCR_CACHE_STOP, CCR);
> > > >      else
> > > >              outl(CCR_CACHE_INIT, CCR);
> > > > @@ -103,7 +106,7 @@ void icache_disable(void)
> > > >=20
> > > >   void invalidate_icache_all(void)
> > > >   {
> > > > -    puts("No arch specific invalidate_icache_all available!\n");
> > > > +    cache_control(CACHE_INVALIDATE);
> > > >   }
> > > >=20
> > > >   int icache_status(void)
> > >=20
> > > Thanks for filling this in, I wasn't sure how the implementation woul=
d
> > > look from a quick skim of the linux kernel code.
> > I believe it should look like the above, but lemme CC Geert to be on th=
e
> > safe side.
>=20
> I have no idea.  I removed the corresponding (but incomplete) code
> from Linux in commit 25c7d77d695a4104 ("sh: boot: Remove sh5 cache
> handling"), as it was a relic of sh5 cache handling.
>=20
> SH4 cache handling seems to be buried deeper. At least the above
> matches for invalidation:
>=20
> arch/sh/mm/cache-sh4.c- /* Flush I-cache */
> arch/sh/mm/cache-sh4.c: ccr =3D __raw_readl(SH_CCR);
> arch/sh/mm/cache-sh4.c- ccr |=3D CCR_CACHE_ICI;
> arch/sh/mm/cache-sh4.c: __raw_writel(ccr, SH_CCR);

Odd, I haven't received the original mail.

@Marek: Could you resent your patch CC'ing the current maintainers of arch/=
sh?

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
