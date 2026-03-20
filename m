Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C9811098796
	for <u-boot@archiver.kernel.org>; Fri, 20 Mar 2026 15:09:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F50484008;
	Fri, 20 Mar 2026 16:09:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qqIb2yjX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EFB2384010; Fri, 20 Mar 2026 16:09:34 +0100 (CET)
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com
 [IPv6:2607:f8b0:4864:20::c31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F26E83FFF
 for <u-boot@lists.denx.de>; Fri, 20 Mar 2026 16:09:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-67baf20e8c2so274258eaf.3
 for <u-boot@lists.denx.de>; Fri, 20 Mar 2026 08:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774019371; x=1774624171; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=vypP5FMiNTVA6057pEyRk0YVHq+tlwl/GSTFrXkkB30=;
 b=qqIb2yjXO7BjZNqPVPo31kzVo7AaqgoklLB1xVRG8iftv7FzzfzYh7oUBroNvo5JU4
 hwihmqqrTDXlR+Rcv+bq1HUMe60dA8NfaQfDkMccwY6US5z0dtHdJ4HEgXaIdvWnHty2
 kBNL/SoxVVanmUIH+8UeORkBXZyfZT49FcUGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774019371; x=1774624171;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vypP5FMiNTVA6057pEyRk0YVHq+tlwl/GSTFrXkkB30=;
 b=eyHz7zOi9KNF18CTtww3oZNT1A+yHtRlnuhg1+VE7wuB27/y+AuZllMvnj4nK67PvR
 /6AM6PIV5noRBzmO8IwjG5PBqwgojas2YQwa+akCrClxNMIuAF4BUMTIopfROJEMDeow
 Ei1UFh2TCIRzMHkWGNJOEVhLWMG2AObqKQ3IJFYTFOOvwV0Z2ENJsAAYR1rmijyFObFx
 8Omcbxuub8mmMT5EFn6dJEpXIk1gsKuoriGOEFa0Wg3XPFJTfhuDnZcJPXLc8aOAVIFr
 kZ/dK3mxR527Amu/X70Drrlnbl7He+8G2efVDQ23K8FGglHDhBAV4kCWBmhLc49LoTNm
 bw9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCkgWa7A5K+pmAOt8WtfNg77DptHkNHDBdKL0+FLrSClVhrY32qMOF7VoAx8al/t0yowOUFrY=@lists.denx.de
X-Gm-Message-State: AOJu0Yz1JQC5Z5sXEOQOj1GKiM13l8k2NnQ4iCQprVihspxp6ix4AzXN
 e5S05f47nyMw4c3+b/jb0G6iUPSTK3fj8qSc+RWSGN6S7YwPazIKgulFBhEBFPNiqaM=
X-Gm-Gg: ATEYQzxOL35IzALBm5tlibeYFE8go6OcOhWintnchf03WN/+T7sesLzYMLj83iUcXMX
 jvQlucuXRkJ1xdJGtUOeYtwpJPaZh00XO7Li3G2frhfLcpCF5sxhjfS9G9rBGnUoCX+FeQUaze7
 8n1TmyhG85VAZqxIsldnp9nw/O0+gfBYQ7oRyzqJtaU0IN9fYbYfzcVXPbhqez3glIJozYw+Smv
 KSGUWazRgXtfECdv2JKj6LdT/+q9NIeT8xq7TwhxVg46EQfFRIOyLP9uWltC2Upddac4CL7MgCg
 JujKZqZPVBeWmGBUE5xqtVjhCXRKBkfMNF6FOFjF8d6s7mrlL+xydj+lWfqQIrnQF1k3WaBWWdW
 j8OI7Lfglo5HHrlKObVMiB25qtTk2RhYpIEuc4y40UYSZyPlueDAYuWpcofDn1nFmgmGyfc62jI
 8cMSk82xdQ3eCKAd9fNOBh0rvwXg5QrNzAuWc3u/kzvZv8ZWl/EDuA2gXvQ0ieB+md2YYnlPSDs
 FWquynknNAWEZ4tcAyXH/KahOC9If7tjw5e4+6wJa7uWAGm
X-Received: by 2002:a05:6820:62a:b0:67b:f4a3:b796 with SMTP id
 006d021491bc7-67c22f958e7mr2136599eaf.55.1774019370694; 
 Fri, 20 Mar 2026 08:09:30 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-67c251a58dfsm1277241eaf.0.2026.03.20.08.09.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 08:09:29 -0700 (PDT)
Date: Fri, 20 Mar 2026 09:09:27 -0600
From: Tom Rini <trini@konsulko.com>
To: Ferass El Hafidi <funderscore@postmarketos.org>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de,
 Lukasz Majewski <lukma@denx.de>,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Paul Barker <paul@pbarker.dev>,
 Dai Okamura <okamura.dai@socionext.com>, linux@analog.com,
 uboot-snps-arc@synopsys.com, u-boot-amlogic@groups.io,
 uboot-stm32@st-md-mailman.stormreply.com,
 Sumit Garg <sumit.garg@kernel.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Stephen Boyd <swboyd@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Paul Sajna <sajattack@postmarketos.org>,
 Marek Vasut <marex@denx.de>
Subject: Re: [PATCH RFC 15/40] clk: restrict clk/imx to MACH_IMX
Message-ID: <20260320150927.GB502704@bill-the-cat>
References: <20260319-casey-ccf-upstream-v1-0-4df2ee2226da@linaro.org>
 <20260319-casey-ccf-upstream-v1-15-4df2ee2226da@linaro.org>
 <tc612f.1958x6s93grqj@postmarketos.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="NLjqDhp4BzK24ULp"
Content-Disposition: inline
In-Reply-To: <tc612f.1958x6s93grqj@postmarketos.org>
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


--NLjqDhp4BzK24ULp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 19, 2026 at 09:25:14PM +0000, Ferass El Hafidi wrote:
> On Thu, 19 Mar 2026 20:56, "Casey Connolly via groups.io" <casey.connolly=
=3Dlinaro.org@groups.io> wrote:
> > Only build IMX clocks when MACH_IMX is enabled, otherwise IMX clock
> > drivers get compiled for all platforms with CLK_CCF enabled.
> >=20
> > Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
> > ---
> > drivers/clk/Makefile | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
> > index 5f0c0d8a5c28..f96d57a3223a 100644
> > --- a/drivers/clk/Makefile
> > +++ b/drivers/clk/Makefile
> > @@ -15,9 +15,9 @@ obj-$(CONFIG_$(PHASE_)CLK_STUB) +=3D clk-stub.o
> >=20
> > obj-y +=3D adi/
> > obj-y +=3D airoha/
> > obj-y +=3D analogbits/
> > -obj-y +=3D imx/
> > +obj-$(CONFIG_$(PHASE_)MACH_IMX) +=3D imx/
>=20
> I think this is not necessary. drivers/clk/imx/Makefile already requires
> that imx config options be enabled for the driver to be compiled in.

Almost all of them do. I see:
$ rg obj.*CLK_CCF drivers/clk/
drivers/clk/Makefile
10:obj-$(CONFIG_$(PHASE_)CLK_CCF) +=3D clk.o clk-divider.o clk-mux.o clk-ga=
te.o
11:obj-$(CONFIG_$(PHASE_)CLK_CCF) +=3D clk-fixed-factor.o
61:obj-$(CONFIG_SANDBOX_CLK_CCF) +=3D clk_sandbox_ccf.o

drivers/clk/exynos/Makefile
10:obj-$(CONFIG_$(PHASE_)CLK_CCF)       +=3D clk.o clk-pll.o

drivers/clk/imx/Makefile
5:obj-$(CONFIG_$(PHASE_)CLK_CCF) +=3D clk-gate2.o clk-pllv3.o clk-pfd.o

But exynos is guarded by CONFIG_CLK_EXYNOS to start with. So I think
this is right, and also something that could just be standalone and
picked up shortly as it's a build cleanup.

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--NLjqDhp4BzK24ULp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCab1jIwAKCRAr4qD1Cr/k
CjdCAQCgnFWFQ/O1pXOo/rj9vi9RzSILtD9BX3tunzOiyXst+QEA9c8UGn0xwevE
3kHJZ86ibblj5T9B/MJ/PecPqlx1Jgo=
=GY9m
-----END PGP SIGNATURE-----

--NLjqDhp4BzK24ULp--
