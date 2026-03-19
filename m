Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 306B81090234
	for <u-boot@archiver.kernel.org>; Thu, 19 Mar 2026 14:25:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C23CC83FED;
	Thu, 19 Mar 2026 15:25:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="D/Zdee/Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE0C483EEF; Thu, 19 Mar 2026 15:25:12 +0100 (CET)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2DE783FF5
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 15:25:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-40ede943bf0so643054fac.2
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 07:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773930308; x=1774535108; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=PXMnBdpuojPY1Br6jhkVvEf7MZgbMax7zqhObCT9Zbg=;
 b=D/Zdee/QGvdI9ci33c8M+nFkkogASHhyHr5qTAlwAB6LFwvxeG16X5x3b12w9L1DGn
 BlxbDxpNSYsTQzR7RvnrTSVkuUWjdaBga5xSBGV3THNWiXs1iuDSshQBr1l1/kJRyuHN
 3XDOfg9t9+HMDAIv3yRU/xBPYhUSdQWDg4PTc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773930308; x=1774535108;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PXMnBdpuojPY1Br6jhkVvEf7MZgbMax7zqhObCT9Zbg=;
 b=IErUeHzRpmwJzQ21pjUGfU8J3o8o8DFCDUW7XN6IDpj2PEVwuSa7Mgk1jAzXtKOfgE
 qnoLvFPs0hRJIeZPHN05HNhTK09xu3GrzlDKCatibZgkdqJ8zFs5X3yBkPBwz1Repwnn
 aYvAZwNr6Dhy9Xqimw4diIQO9YfkLXtOOmTWFjflGDiSKbAA53eUOFX62iDZq+6Oc0K4
 QnWcmpWbWbYyNmqiPSwNNuMV7vKrDz42Dp+0Y9tG0xdLME5PjdK7CHiwIeb2BBqF+vbs
 v1T45aN8drWg+0FZhdSrh4sEwv200ppOmuIKug50a8Hq9hEqD9ksaUCBUtJnIFWkIPHj
 7W1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXMQa+mq7BfVtW6tOq1Afre3d1dvyrivNus9XzV5DBEgcffpy3HrM1ay9El5WWuRLktrFEaMH8=@lists.denx.de
X-Gm-Message-State: AOJu0YwFtzlvhY1iDSSd39pDWJaKT0CGloNLA/gBY7l8XzD7pNSPo8Nl
 KGC6PR1VxaHn8TYvVMjk71tkzFCHR9jQmwI8/J1cUw5cUT8muBiMfVr1qJvvB8cai98=
X-Gm-Gg: ATEYQzweHdjUX02naEwVOYfO3VxUUMEXK5DMoFhgqXv2D06T9nDo0BAtXYg20iTI45E
 t5Qw1jpKZ75lGc4VdRODeq5Ew6wl26CwqVfKEF+FUp8g04Vg7Nh9YMBV1/+LXyBzseEBUJyBATF
 Jo1+ksQDQ/xXGhQ/NFSsgKeeW4kiW0EyY8smDYe0EmUZp+EUV06XxZlgnEcDcwiBRlwrfKMXpnn
 6PyE4/4qzptkQlktNVnUkqF55HWhaZmvDJy0s95oCGJCJLoTG+oLu26C018+LDOVvLqD/GzKcHy
 b0x4Lo0b3iZTlQvHWOWOo6QwgL7A9dv978IcSCwiJXy8sX9He2Yr5lFX+3IzyycuXZa1k8jMst+
 wQMWCCK6q9suZ+sUwJRJMusloLS6VsPjJZSwuVkrrh+7tJVdWWXZlVF0r9tK5gRlpnRz7jl0IX8
 zZk3qHg2ZufyT3Xsh8HxS1XcIc/LaAzi8icA2+FBoKKng4+rb+FXcfFr59QZnHQRwVPSbCG2stC
 ufGMiQNQKudfpfTzntec+VPljd9HmzuGKB1X5h/uoJpa3Cp
X-Received: by 2002:a05:6871:2edf:b0:417:5b7a:704b with SMTP id
 586e51a60fabf-41bd3f627d8mr4924191fac.31.1773930308257; 
 Thu, 19 Mar 2026 07:25:08 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41bd2cd1ea7sm6087088fac.15.2026.03.19.07.25.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 07:25:07 -0700 (PDT)
Date: Thu, 19 Mar 2026 08:25:05 -0600
From: Tom Rini <trini@konsulko.com>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Michael Walle <mwalle@kernel.org>, Ashish Kumar <Ashish.kumar@nxp.com>,
 Priyanka Jain <priyanka.jain@nxp.com>,
 Kuldeep Singh <kuldeep.singh@nxp.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 2/3] configs: ls1021atsn: enable serial driver
Message-ID: <20260319142505.GS502704@bill-the-cat>
References: <20260318142949.2479033-1-mwalle@kernel.org>
 <20260318142949.2479033-3-mwalle@kernel.org>
 <20260319141919.7i4lvuivexnek2ni@skbuf>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="RA+XCdekdhK9YUgx"
Content-Disposition: inline
In-Reply-To: <20260319141919.7i4lvuivexnek2ni@skbuf>
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


--RA+XCdekdhK9YUgx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 19, 2026 at 04:19:19PM +0200, Vladimir Oltean wrote:
> On Wed, Mar 18, 2026 at 03:29:16PM +0100, Michael Walle wrote:
> > Switching to DM_SERIAL disabled any serial driver. Re-enable it again.
> >=20
> > Fixes: 191b10ac70d7 ("PowerPC / Layerscape: Finish migration to DM_SERI=
AL")
> > Signed-off-by: Michael Walle <mwalle@kernel.org>
> > ---
> >  configs/ls1021atsn_qspi_defconfig | 1 +
> >  1 file changed, 1 insertion(+)
> >=20
> > diff --git a/configs/ls1021atsn_qspi_defconfig b/configs/ls1021atsn_qsp=
i_defconfig
> > index e36d336d84b..37629d88c48 100644
> > --- a/configs/ls1021atsn_qspi_defconfig
> > +++ b/configs/ls1021atsn_qspi_defconfig
> > @@ -68,6 +68,7 @@ CONFIG_TSEC_ENET=3Dy
> >  CONFIG_NVME_PCI=3Dy
> >  CONFIG_PCIE_LAYERSCAPE_RC=3Dy
> >  CONFIG_DM_SERIAL=3Dy
> > +CONFIG_SYS_NS16550=3Dy
> >  CONFIG_SPI=3Dy
> >  CONFIG_DM_SPI=3Dy
> >  CONFIG_FSL_DSPI=3Dy
> > --=20
> > 2.47.3
> >=20
>=20
> Ok, in ls1021atsn_sdcard_defconfig it is selected by
> CONFIG_SPL_SYS_NS16550_SERIAL=3Dy. In ls1021atsn_qspi_defconfig it isn't
> selected.
>=20
> Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

And the ls1021atsn_qspi_defconfig example isn't great, ugh. There's
certainly other platforms I didn't migrate correctly in that commit,
I'll go take a look now.

--=20
Tom

--RA+XCdekdhK9YUgx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCabwHPgAKCRAr4qD1Cr/k
CjvAAP915CDmzCoxAn/M37G80GZUpuVw4051eKx+N/4nCKvTgwD+JnY77Ng0A/Ab
+eLwKtHFQZB4xJXjxtPHvk62xlXT8Ao=
=RxG3
-----END PGP SIGNATURE-----

--RA+XCdekdhK9YUgx--
