Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA3B4C43458
	for <u-boot@archiver.kernel.org>; Fri,  3 Jul 2026 15:17:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26E64849BA;
	Fri,  3 Jul 2026 17:17:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lKsBEViu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57F2D84A35; Fri,  3 Jul 2026 17:17:06 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F165849AC
 for <u-boot@lists.denx.de>; Fri,  3 Jul 2026 17:17:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7e9f829d75aso344725a34.0
 for <u-boot@lists.denx.de>; Fri, 03 Jul 2026 08:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1783091822; x=1783696622; darn=lists.denx.de;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1VjC1i1YVEBF0/+zewxPVOjTa1HAa2BWLiwfgY6GNSc=;
 b=lKsBEViuvdGbOF51yuOyEPrOKHVVIJqyVFqL9ELA8lvE7I9ygdxyRs0O66L0IwygHq
 44eyKq4LZLBQV88WtFPJjpTLczncXp9piMJv/QFw9fED8jQ3z7ngLUSEKCGMke+0sa8h
 TUD4TbaPhoVigVnHko/IyzdZQFR+LDzyRJzUk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783091822; x=1783696622;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1VjC1i1YVEBF0/+zewxPVOjTa1HAa2BWLiwfgY6GNSc=;
 b=fzVEUwz5wY5ugYs8iuRmhIjbcEtVh1PDRZF+w0AQgI7R/FTwcleaGqHb1Jd783xMC9
 jn+SOAuA8k8JWDE1H8Oai98a3HhNHTkLyH8Sr8qsH9aDNCP3fotULk65cURXzEMaJNRf
 6au5VPwQxI/N1tZ8JSPJ94j04dNcAo0vtYVrsj6ij98cX/qaIg+8WrZ1kjpAPQUuQ/e9
 SMOyUzfzyE7VjjQHkhtHVuO8rsppw3J00FavQMTRE1zk/Ne0vd3csSJuMTxuyKnC2Jcq
 DRbeLlTV7RDsWyei1BR1xhTnhuNWdauiGi+ZgDvu9NClcxgL7IOtI6XyEQQB8F64hM8W
 WoSw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9WC5yDAYGA7hJHBKVEy/XYKgtUFC+zlyrvpxHGjEQo5ryb5aKIuhQw1YWN29yHGMJKlB0IAn8=@lists.denx.de
X-Gm-Message-State: AOJu0YzfrGb0J/9fu61jbUoV8mOPjwdCzufB7PPOnJ10At225hySpKDF
 v2GlZvE7DAbKLYKSuCmem0ps4WsgU5eCi/i6oCCgpBmum+3DMyLdt446rWgIqmIn3a0=
X-Gm-Gg: AfdE7ckc3PQ8IQZhdG2IJhaQ1wyMAS5NPD7D0fubHOSbdABlzKSVtyfPUl3P2jk5RYl
 57CZe/FJLVohO+hiEyPzxie054logKsUhXvR7VTnKXQ1FQsJbJgM2/RZu3hYfHIm3wo6MsQeTw6
 uubApl+93L5Wbq+FZy9sZ8QOi0MqPJcCpaPmBtMcVGXkkOKAKDUxb+GUK5BxVQYD4uaIk83mV8b
 ckcJ11BbvTDJ0xxsk0aNdYBYtK2jDM6TlWbqfxFsnXXJSe/NV3aZTBo45V7jOyeC53p3E13HyzA
 LQUReH9HhuryeXJvKiF2+opo6kVB0Qt8aMSyPpFEWksG3ZB9EJXCljdKtMZO0uIZCNRaakJgJUQ
 nRqRGW7P9GY6ifx3zaQgPIhi/54XnH3QS8YIboqn6vaH6H7Le5Py4uaHr6tFEesqqqdUBpZZbck
 CA5H0r2f99G98pWcr25k95D9+E+I3t9Eul6+ebr6mbHhOkdPzU/p7F91gtxDH47SdQ+/WO3+Eoe
 Y4+TnFkBROW8A9DJIMGbQGemzS/co5A1u1kkjCgrcYibgLW
X-Received: by 2002:a05:6820:81f:b0:69d:d87c:177 with SMTP id
 006d021491bc7-6a32dac3d39mr202539eaf.12.1783091821957; 
 Fri, 03 Jul 2026 08:17:01 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6a310375f67sm4220370eaf.9.2026.07.03.08.16.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2026 08:17:01 -0700 (PDT)
Date: Fri, 3 Jul 2026 09:16:57 -0600
From: Tom Rini <trini@konsulko.com>
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Christian Marangi <ansuelsmth@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Stefan Roese <stefan.roese@mailbox.org>,
 David Lechner <dlechner@baylibre.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Sean Anderson <sean.anderson@linux.dev>, Yao Zi <me@ziyao.cc>,
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andriy.shevchenko@intel.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, u-boot@lists.denx.de,
 Markus Gothe <markus.gothe@genexis.eu>,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>,
 Benjamin Larsson <benjamin.larsson@genexis.eu>
Subject: Re: [PATCH v14 02/18] bitfield: Add less-checking __FIELD_{GET,PREP}()
Message-ID: <20260703151657.GJ749385@bill-the-cat>
References: <20260702055744.2164975-1-mikhail.kshevetskiy@iopsys.eu>
 <20260702055744.2164975-3-mikhail.kshevetskiy@iopsys.eu>
 <CAFLszTg4ZuiEdQkfTZcomtcWxSN+f1CKvE+Hikk+EHWghPaKYg@mail.gmail.com>
 <20260702135918.GW749385@bill-the-cat>
 <0c01810a-8a14-4c9a-9599-38b135c7b7e1@iopsys.eu>
 <028d33d7-ba0f-4c6f-9c7c-a1757d5edb39@iopsys.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="QwkzL5XcVeDa6Od3"
Content-Disposition: inline
In-Reply-To: <028d33d7-ba0f-4c6f-9c7c-a1757d5edb39@iopsys.eu>
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


--QwkzL5XcVeDa6Od3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 03, 2026 at 02:18:08PM +0300, Mikhail Kshevetskiy wrote:
>=20
> On 7/3/26 14:07, Mikhail Kshevetskiy wrote:
> > On 7/2/26 16:59, Tom Rini wrote:
> >> On Thu, Jul 02, 2026 at 11:53:05AM +0100, Simon Glass wrote:
> >>> Hi Mikhail,
> >>>
> >>> On 2026-07-02T05:57:27, Mikhail Kshevetskiy
> >>> <mikhail.kshevetskiy@iopsys.eu> wrote:
> >>>> bitfield: Add less-checking __FIELD_{GET,PREP}()
> >>>>
> >>>> The BUILD_BUG_ON_MSG() check against '~0ull' works only with "unsign=
ed
> >>>> (long) long" _mask types.  For constant masks, that condition is usu=
ally
> >>>> met, as GENMASK() yields an UL value.  The few places where the
> >>>> constant mask is stored in an intermediate variable were fixed by
> >>>> changing the variable type to u64 (see e.g. [1] and [2]).
> >>>>
> >>>> However, for non-constant masks, smaller unsigned types should be va=
lid,
> >>>> too, but currently lead to "result of comparison of constant
> >>>> 18446744073709551615 with expression of type ... is always
> >>>> false"-warnings with clang and W=3D1.
> >>>>
> >>>> Hence refactor the __BF_FIELD_CHECK() helper, and factor out
> >>>> __FIELD_{GET,PREP}().  The later lack the single problematic check, =
but
> >>>> are otherwise identical to FIELD_{GET,PREP}(), and are intended to be
> >>>> used in the fully non-const variants later.
> >>>>
> >>>> [1] commit 5c667d5a5a3ec166 ("clk: sp7021: Adjust width of _m in
> >>>>     HWM_FIELD_PREP()")
> >>>> [...]
> >>>>
> >>>> include/linux/bitfield.h | 36 ++++++++++++++++++++++++++++--------
> >>>>  1 file changed, 28 insertions(+), 8 deletions(-)
> >>>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >>>> Link: https://git.kernel.org/torvalds/c/5c667d5a5a3ec166 [1]
> >>>> Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
> >>>> Reviewed-by: David Lechner <dlechner@baylibre.com>
> >>> Reviewed-by: Simon Glass <sjg@chromium.org>
> >>>
> >>> Please can you add your own Signed-off-by at the end of the chain?
> >>>
> >>> It's a bit confusing that you seem to refer to Linux commit hashes in
> >>> the commit. So maybe this should have a Cherry-picked-from: line
> >>> indicating it came from Linux?
> >> We don't use Cherry-picked-from (does anything?), we just mention what
> >> the upstream commit was.
> > There are several commits where something similar were used:
> >
> > 86a720aafce5b2 ("mtd: Introduce mtd_block_isreserved()")
> > [scottwood: Cherry-picked from Linux 8471bb73ba10ed67]
> > Signed-off-by: Scott Wood <scottwood@freescale.com>
> >
> > 88f95bbadda89b ("libfdt: Add fdt_next_subnode() to permit easy subnode
> > iteration")
> > (Cherry-picked from dtc commit 4e76ec79)
> > Acked-by: Gerald Van Baren <vanbaren@cideas.com>
> >
> > c9fbe861a2fc1c ("arm64: dts: allwinner: h616: Add r_i2c pinctrl nodes")
> > (cherry-picked from commit 1665557aa57c2140d014d68dfe1a1f92f9baac82)
> > Reviewed-by: Andre Przywara <andre.przywara@arm.com>
> >
> > 13f3b04f61aa6a ("mtd: add mtd_ooblayout_xxx() helper functions")
> > [Linux commit: 75eb2cec251fda33c9bb716ecc372819abb9278a]
> > [masahiro: cherry-pick more code from
> > adbbc3bc827eb1f43a932d783f09ba55c8ec8379]
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> >
> > 1fb87de83dd6e7 ("mtd: nand: Support controllers with custom page")
> > [Linux commit: 3371d663bb4579f1b2003a92162edd6d90edd089]
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> >
> > and so on

Yes, and to try and be clearer, none of these are using the literal tag
"Cherry-picked-from", which is what I was noting. Tags are not "free
form".

> I think we need some policy about cherry-picked commits. It should includ=
e:
> * who should be an author of cherry-picked commits
> * should or should not be original=A0=A0Signed-off-by/Reviewed-by/Acked-by
> be kept * how original commit should be referred

Yes, this has been done at:
https://docs.u-boot-project.org/en/latest/develop/sending_patches.html#attr=
ibuting-code-copyrights-signing

--=20
Tom

--QwkzL5XcVeDa6Od3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCakfSZQAKCRAr4qD1Cr/k
CnRTAP4qr0GJka8vI0ddgyilAJBz51ZE9V0hSo81Zgqn0EbaxgD+M8njUCBFuUt8
DoV1dqLSP/oh+W8BPsL9C2AM7Of5qAk=
=UiaN
-----END PGP SIGNATURE-----

--QwkzL5XcVeDa6Od3--
