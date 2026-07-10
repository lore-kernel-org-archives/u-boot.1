Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB6A3C43458
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 15:56:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9B3984AAE;
	Fri, 10 Jul 2026 17:56:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="aHC9kQ49";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88F6784AC9; Fri, 10 Jul 2026 17:56:42 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4DAFE84A73
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 17:56:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7e6b5737bb2so900711a34.1
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 08:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1783698999; x=1784303799; darn=lists.denx.de;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=aqXSo9Hg+pJhWWI2vv2bxbgmva6bEq85NBHywXxEj8U=;
 b=aHC9kQ491qjssdRpT2cc+9n738ZRh3DkO70KejpVnIRW2rGMhxjhMMqE/vkmDvv80F
 0EhGD/rEVhV9ttB7QKaJd4glo9JhH9JGo1ui1P1jhgvse2h1gi6jeOMIBb0nFeEI28Zb
 HkFWU57R0scCyy/DaNOckLSLfaFHbqaRqtvhk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783698999; x=1784303799;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=aqXSo9Hg+pJhWWI2vv2bxbgmva6bEq85NBHywXxEj8U=;
 b=TpsGFvKmDcmap5HVFHBYAkh2n91zw8Ud6nTS6/ykIfLSZm3a8+P3//iKCF01D15iP8
 1kdTohKuryhDLjUrncZOjS7vM26+LpSUOpXj/17Pv5vxcVltrNZ2+AgBd8+mdk/7ToG3
 msu1WbfRMx48St3Y8byENDLhfiVDGc+ild5Nj0PmVA3i6C3yjTUxsRJrfzW49IAtVoYg
 6XJ9Yi45YLb8DtwKn6SeL26TP6nIC+UZow8WzRCFSk2UwhiF3STDFw2f1qFYYe+18l8Z
 zM8ScEJZ5mg7beMW0hUTb9XP2e0A7QDTAJVz1VF92YHeKOb9eOysYcjn8smSeNKSC8gA
 yLyw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+2y7GIm0i4daqAyZVVDqMB0q3KnRHW9xXKHzWOScXXlDE+30lr6vmliZN4lEmt6X9yrZnqnHU=@lists.denx.de
X-Gm-Message-State: AOJu0Yz7NXBGhJ4wkpCAznSgyGcoGA+eAyVNV3WjItu0NvaWMNBkN+rV
 mHiiFz8daLlh8u3zAErO/g0S1zCODrjftfMBh/JbYPTTEvH4vkKLALg1yDhrt/Lytq5BmLtHiWT
 Z2oflbYs=
X-Gm-Gg: AfdE7cm6EvfgQTQaCGjzx662EmN7w8nOs7axDduhu0/HNd38p6kWIVYFWDjsB7/t1bR
 0msWLIIUMfh65b15VjYD/gWOG2aeJB3+/9ClAhPmUFo+LKVnr80biTPQIhpAaTX5fEyzpak0OW+
 0f+/0s4oN2zvQ75rMC00ppbrzZFpr9eKsypqPzhqUNYbVCbjrE4U29qcRkaG/dF7SSiWy2ptwlg
 UMh/oEAfiuyhIKgjqEPPLabOrnJ346F2fPbddegPpOOm45kFYURMfQRUco5Wkiu7qvZW0rl4KF8
 zbChQPg1NF4uzlRBuask2pDvp1wXncjjytavp+I18uZbfBFVE/scKd3+5YBk50saXkr60Xr5rRm
 XqPKE0Ci8DUuPfLhh1/ighvR3vgLPglkP54Kxa8eeKjgZS8UuANA6bLB6nI/CNHqX8vmsRd1N2o
 tuMLiKjyqyULnn/hHYiMZ5L4ItSVwhX/3aGarqboze6LD2rWzrO919k7wKjwFZDMe0Gut5Ej1Ye
 3wybgp3QPLRYReTqiBwQgkdR8lAswErapvCTA==
X-Received: by 2002:a05:6830:6c11:b0:7d9:7201:1acf with SMTP id
 46e09a7af769-7ebd00cbd30mr8117856a34.5.1783698998927; 
 Fri, 10 Jul 2026 08:56:38 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7ebcae206e2sm6634630a34.2.2026.07.10.08.56.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 08:56:38 -0700 (PDT)
Date: Fri, 10 Jul 2026 09:56:36 -0600
From: Tom Rini <trini@konsulko.com>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Heiko Schocher <hs@nabladev.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 08/11] Kconfig: i2c: Depend on correct xPL symbol
Message-ID: <20260710155636.GL749385@bill-the-cat>
References: <20260708220540.3368825-1-jonas@kwiboo.se>
 <20260708220540.3368825-9-jonas@kwiboo.se>
 <20260709015247.GR749385@bill-the-cat>
 <f544cab6-1db6-481b-8f91-06cc2fb6829b@kwiboo.se>
 <20260710135030.GI749385@bill-the-cat>
 <ec6db006-bd05-4621-a9e6-cba6dd9690bd@kwiboo.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="cMkGnV0jQd/yJGmu"
Content-Disposition: inline
In-Reply-To: <ec6db006-bd05-4621-a9e6-cba6dd9690bd@kwiboo.se>
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


--cMkGnV0jQd/yJGmu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 10, 2026 at 05:39:08PM +0200, Jonas Karlman wrote:
> Hi Tom,
>=20
> On 7/10/2026 3:50 PM, Tom Rini wrote:
> > On Thu, Jul 09, 2026 at 09:12:24AM +0200, Jonas Karlman wrote:
> >> Hi Tom,
> >>
> >> On 7/9/2026 3:52 AM, Tom Rini wrote:
> >>> On Wed, Jul 08, 2026 at 10:05:34PM +0000, Jonas Karlman wrote:
> >>>
> >>>> Change to depend on the xPL symbol instead of the SUPPORT_xPL symbol=
 to
> >>>> only make the xPL_SYS_I2C_LEGACY symbols available when xPL is enabl=
ed.
> >>>>
> >>>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> >>>> ---
> >>>>  drivers/i2c/Kconfig | 4 ++--
> >>>>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>>>
> >>>> diff --git a/drivers/i2c/Kconfig b/drivers/i2c/Kconfig
> >>>> index ab5af17858c8..125dc84819e6 100644
> >>>> --- a/drivers/i2c/Kconfig
> >>>> +++ b/drivers/i2c/Kconfig
> >>>> @@ -78,14 +78,14 @@ config SYS_I2C_LEGACY
> >>>> =20
> >>>>  config SPL_SYS_I2C_LEGACY
> >>>>  	bool "Enable legacy I2C subsystem and drivers in SPL"
> >>>> -	depends on SUPPORT_SPL && !SPL_DM_I2C
> >>>> +	depends on SPL && !SPL_DM_I2C
> >>>>  	help
> >>>>  	  Enable the legacy I2C subsystem and drivers in SPL.  This is use=
ful
> >>>>  	  in some size constrained situations.
> >>>> =20
> >>>>  config TPL_SYS_I2C_LEGACY
> >>>>  	bool "Enable legacy I2C subsystem and drivers in TPL"
> >>>> -	depends on SUPPORT_TPL && !SPL_DM_I2C
> >>>> +	depends on TPL && !TPL_DM_I2C
> >>>>  	help
> >>>>  	  Enable the legacy I2C subsystem and drivers in TPL.  This is use=
ful
> >>>>  	  in some size constrained situations.
> >>>
> >>> Building on the last email, I think these might need to be
> >>> [ST]PL_FRAMEWORK not [ST]PL.
> >>>
> >>
> >> I have mostly tested this series with additional changes that alias
> >> putc()/puts() to printch()/printascii() in xPL builds when
> >> common/console.o is unavailable and DEBUG_UART=3Dy, patches that will
> >> be sent as a separate series.
> >>
> >> It is possible such change may have hidden some latent issues, now
> >> trying to push a branch that contains changes that ends at the patches
> >> included in this series, but due to timeouts it was not possible prior
> >> to sending this reply.
> >>
> >> This patch can also be dropped if it causes any issues, I only added it
> >> after a search for SUPPORT_xPL and noticed that these depends seem to =
be
> >> incorrect. SUPPORT_xPL is used to tell if xPL can be enabled or not,
> >> not if xPL is enabled/disabled.
> >=20
> > I don't want to drop this, but there are a handful of platforms that
> > change:
> > 10: Kconfig: i2c: Depend on correct xPL symbol
> >    aarch64: (for 1/1 boards) all -60.0 text -60.0
> >             ls1043aqds_tfa : all -60 text -60
> >                u-boot: add: 0/-1, grow: 0/-1 bytes: 0/-60 (-60)
> >                  function                                   old     new=
   delta
> >                  board_early_init_f                          68      64=
      -4
> >                  i2c_early_init_f                            56       -=
     -56
> >=20
> > Can you please look in to it and see what needs to be changed? Thanks.
>=20
> From a quick look this size change may be caused due to use of an
> 'imply SPL_SYS_I2C_LEGACY' instead of using an 'imply SYS_I2C_LEGACY'
> in arch/arm/cpu/armv8/fsl-layerscape/Kconfig.
>=20
> 'config MACH_SUN8I_R40' is another platform that also possible miss
> an 'imply SYS_I2C_LEGACY' to match other similar sunxi platforms.
>=20
> Building this target I also noticed some more SPL_<name> symbols that
> may be missing a 'depends on SPL':
>=20
>   > grep CONFIG_SPL .config
>   # CONFIG_SPL_SYS_L2_PL310 is not set
>   # CONFIG_SPL is not set
>   # CONFIG_SPL_SYS_STDIO_DEREGISTER is not set
>   # CONFIG_SPL_NVMEM is not set
>   CONFIG_SPL_SYS_NAND_SELF_INIT=3Dy
>   # CONFIG_SPL_PHY_ATHEROS is not set
>   # CONFIG_SPL_PHY_TI_DP83867 is not set
>   # CONFIG_SPL_LZMA_SIZE_OPTIMIZATION is not set
>=20
> Should possible add 'depends on' to some of them in a v2.

Great, thanks!

--=20
Tom

--cMkGnV0jQd/yJGmu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCalEWMAAKCRAr4qD1Cr/k
CjjeAQD04Zz50AR/Eh79g9yo973Yf+X214IPDixU0H6vn08TgQD9EjfvqpBQS6Ml
Zc02YxOXnLDQVbhBchzh5ORx4kKCjgI=
=5xZJ
-----END PGP SIGNATURE-----

--cMkGnV0jQd/yJGmu--
