Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44A3DC25B7C
	for <u-boot@archiver.kernel.org>; Fri, 24 May 2024 15:38:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 944418884D;
	Fri, 24 May 2024 17:38:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cqSbPP+y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57C558884D; Fri, 24 May 2024 17:38:28 +0200 (CEST)
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com
 [IPv6:2607:f8b0:4864:20::833])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D37C388651
 for <u-boot@lists.denx.de>; Fri, 24 May 2024 17:38:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-43fb02e28a2so6002621cf.0
 for <u-boot@lists.denx.de>; Fri, 24 May 2024 08:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1716565105; x=1717169905; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=pB+T1eh19rc5pxKEefw+kpnJ6eFv1D4vva4V4QENqZA=;
 b=cqSbPP+y6a+7fnSnbXD0yoauFP6Ajl1bCzPPnoJTprHXa2I1qargPcX6nEa4H6q76t
 vSLNSevjabDcQv76N+tsJoLcpxNO2T5Q5on35mQqJYMXBH071ZDO10nS6Lg36A2TcVp5
 9kqIsm8ayBP84vxzP2ok2SfU3qOPnrphFT70w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716565105; x=1717169905;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pB+T1eh19rc5pxKEefw+kpnJ6eFv1D4vva4V4QENqZA=;
 b=ksDLf2wjzIMzXCDuxZT8+7hHe+dZ05fUGWjScSOyrL1lYqJvsuOkvueuFjl8KrAkNn
 t+S81U5AjHJuyD5gD1IakA8BHP861DuHQagPe62PNU9TceGuOpSkIi53L0SUnGzJXMji
 R0UGkhUPyBcYcOodbgOBg6NYiAZLvWbIHGjLUqB2oFWwDPiVOo8MJXov/KyqhTS8GVzJ
 nZH+uI6m26I0Jk/GYCvUFanfjDwFbN71xeOOPX1VkcYNGfRLtgYFpnUnOZnjq5dGDjUn
 RgLyBJz65n5TZ4KEruRL4PaeYNDKUzQ7FqZvoeSd16aIMPQuBskp0RZ94rDHf40KtmRN
 lHIw==
X-Gm-Message-State: AOJu0YzcoYoB44hr9xpgcMp+Fee7j3L0YVTDZjHj75EFhUoS4DRD6ekm
 RtpBjV2kXh29cf6q7SW68JekYIiMOfYnBXZxAujlOCSiPNp1spCuQwbFK6OaHro=
X-Google-Smtp-Source: AGHT+IH9pfVa75QNF9SqPv0ivUavluxRURFGeqAphsN5bHEb2s5AhiiybntR+KpJDEbuo4m9pLvqjA==
X-Received: by 2002:a05:622a:144d:b0:43a:7c0d:8921 with SMTP id
 d75a77b69052e-43fb0f094e7mr27691511cf.53.1716565104652; 
 Fri, 24 May 2024 08:38:24 -0700 (PDT)
Received: from bill-the-cat ([189.178.170.52])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-43fb18325bcsm9014321cf.53.2024.05.24.08.38.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 May 2024 08:38:24 -0700 (PDT)
Date: Fri, 24 May 2024 09:38:21 -0600
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Maxim Uvarov <muvarov@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Bin Meng <bmeng@tinylab.org>
Subject: Re: [PATCH 12/15] configs: add qemu_arm64_lwip_defconfig
Message-ID: <20240524153821.GB2568172@bill-the-cat>
References: <cover.1716393035.git.jerome.forissier@linaro.org>
 <67ac1063406f022ccc35b94ba41317b6e9ee8b3e.1716393035.git.jerome.forissier@linaro.org>
 <20240523150246.GO2568172@bill-the-cat>
 <0684e59c-523b-4b6f-9ed2-138122c8c127@linaro.org>
 <20240524150808.GZ2568172@bill-the-cat>
 <50cc2e57-a582-494e-a6a4-94ff5efea422@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="RB0T67lkkvJToIil"
Content-Disposition: inline
In-Reply-To: <50cc2e57-a582-494e-a6a4-94ff5efea422@linaro.org>
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


--RB0T67lkkvJToIil
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 24, 2024 at 05:30:45PM +0200, Jerome Forissier wrote:
>=20
>=20
> On 5/24/24 17:08, Tom Rini wrote:
> > On Fri, May 24, 2024 at 12:09:33PM +0200, Jerome Forissier wrote:
> >>
> >>
> >> On 5/23/24 17:02, Tom Rini wrote:
> >>> On Wed, May 22, 2024 at 06:00:12PM +0200, Jerome Forissier wrote:
> >>>
> >>>> Add qemu_arm64_lwip_defconfig which was created from
> >>>> qemu_arm64_defconfig with CONFIG_NET_LWIP enabled.
> >>>>
> >>>> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> >>>> ---
> >>>>  configs/qemu_arm64_lwip_defconfig | 70 ++++++++++++++++++++++++++++=
+++
> >>>>  1 file changed, 70 insertions(+)
> >>>>  create mode 100644 configs/qemu_arm64_lwip_defconfig
> >>>>
> >>>> diff --git a/configs/qemu_arm64_lwip_defconfig b/configs/qemu_arm64_=
lwip_defconfig
> >>>> new file mode 100644
> >>>> index 0000000000..c8dadbce37
> >>>> --- /dev/null
> >>>> +++ b/configs/qemu_arm64_lwip_defconfig
> >>>> @@ -0,0 +1,70 @@
> >>>> +CONFIG_ARM=3Dy
> >>>> +CONFIG_POSITION_INDEPENDENT=3Dy
> >>>> +CONFIG_ARCH_QEMU=3Dy
> >>>
> >>> Setting aside that I would like lwip to default to y, at least in the
> >>> first few iterations (so that testing is easier),
> >>
> >> I could certainly do this. By creating a new defconfig, my goal was to
> >> minimize the impacts on existing use cases.
> >=20
> > Yes but then it makes it harder to out of the box see what the deltas
> > are.
> >=20
> >>> this should be using
> >>> the #include method rather than duplicating the whole config.
> >>
> >> I've done that for v2. Let me know if you still prefer I change
> >> qemu_arm64_defconfig instead.
> >=20
> > This is fine for v2, yeah. Once that's posted I'll grab everything and:
> > - Throw it at the small HW lab I have
> > - Enable it by default for everyone and throw it at CI
>=20
> At this point you can expect quite a few failures (unresolved symbols to
> begin with) because so many parts of the network-related code peek & poke
> various parts of the net implementation without formally depending on NET
> (i.e., !NET_LWIP). Some more work is clearly needed to port to lwIP, how
> much is probably something the CI run will help understand.

OK, thanks for setting expectations. And FYI if you hadn't seen:
https://docs.u-boot.org/en/latest/develop/ci_testing.html you can
trigger them yourself, but Azure sometimes just has issues if we get a
slow runner sometimes.

--=20
Tom

--RB0T67lkkvJToIil
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZQtGYACgkQFHw5/5Y0
tyzoYwv+KyDNNFb2nL8JsksyiWeolkVATdyG9v0ILKvQOC96ovBYWo22pCebiLvq
zY/fg1xfu7EbQJJ57hSZCFpvwk02VfcaWYwE2VuJvIuKDnxgCL+SMXlRc5Zxhd2c
CBRrjiKYfJHziIPg7BbjvRJdeAqo3p+LXJlBxKFlcIfREWuyuGB2czmZ3Ly/Z+JL
qzDprFx9QB1ggdxcRQPeCrAt01yYdFTRikemlfj8azGH60FkDqxeK70Ox2sFAOs6
v6IiRaU7Ez+oV3nvgmUcco8m/2SE1KifDFvrbRVen3EXJ6YqysDmBTAPZ03OMiMt
qrUurHD96l5wmexvXKafH8x3HVFMHeI8K94ylT5pW1FS8cCmAdbGqOz+3aCj+82I
LtilRI2zjL9XEjJVETiAWoS0zOXGctnniltZ4hADCJ8GXEtyBoC2F01jaEHTRZIb
vjXG/w2SeOL2aQCUaSUXTw92224ShYdKgsOoSVLk/zCbP76m/LI/bleX7VJOhdWe
HiOnOWoW
=B8Me
-----END PGP SIGNATURE-----

--RB0T67lkkvJToIil--
