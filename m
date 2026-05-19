Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10CF1CD4F5B
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 20:05:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB88784874;
	Tue, 19 May 2026 22:05:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YZ4/AlTK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B79284944; Tue, 19 May 2026 19:22:36 +0200 (CEST)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E99F684932
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 19:22:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-439bdbc86b1so1953657fac.1
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 10:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1779211352; x=1779816152; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=y8O9bAFfGlLzyoV9OsAPKDxIAnbKdpNoyD0/5BP2K8Y=;
 b=YZ4/AlTKEnpVppbZUiv4Uu0us52lrS4/zutwAwpwoqNNjrr7GY51Z9aSx/HZzhUqPU
 cE92IX0nWXxzSwFzBWscDyfc1vJ6JObx7qqDT5o5SKev+w4CdSq6bAqkMoEo2TnT5XKw
 Iq/qF9UDT32LqoO5i8O9RMI4oePFGDYgCmWQI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779211352; x=1779816152;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y8O9bAFfGlLzyoV9OsAPKDxIAnbKdpNoyD0/5BP2K8Y=;
 b=cmn5seKNxfnlWLAqbshCIodHIlkXfFmCi3ZhwYI8R+fy2TMJha5EihAEStAjJwHy5t
 okPrVtr9ViPDwkql4Te1fgadVaREOZbiVuYUS3hcqz82kj/M3auJluVF1qKjR9AhNisM
 DU7mHoB66xK6VZKNWd7KUAGQYjpKbPN0B8i5rRy+/XXQReIE1UqDpE+VYJs1ybw6nR7W
 iM8fB02hfUvpMYky1LWRfxZs3HSf93L6WC15SyKwd9N2AYxBYiAiQq2ayOwzlvRskocO
 a75CsaPOnraO9AKO9o+1j6lTnUZcHm1w3O/yqHA5zhkyyn35k/xKBHKXhUa/yQhZ7E0e
 Q4PA==
X-Gm-Message-State: AOJu0YwTZdJOHr1z2e1nRlHHMBbhv4Poa3wara5Y1484YFIt+ziM1LrV
 Ub8oi9eidI7huObRQZso4d3ahKPegFv9gI/fDPD0QRwttl5UhMOOKNF0g7xZcY6mW/g=
X-Gm-Gg: Acq92OFb6QJSR6Vwcv8RDuHscWeEEAvO3UVpZiJVp/rwuxl6ovFvWEdgV+w9T4Mk5Lt
 PIMQZJTWppZPe4t8l9T8k7sfVdzoJ7krdKjyCxpq/TPcKR6FHKxnTFDKZLE/XPXqYBTEIrl7xBG
 ul+96UlhjSZssZyDogRSGRdPDm7bGc657XWBNBYCm8cB2j+cX4+i5yuHX5tA4tqSlyltF1fNOOY
 Mtp3xR5zvpjU9ZyisvEcIptJRVamyKisHJ6vY+5nEa3yO/HuC3WDndVo29tulG6xK3ufeNt3iP3
 W6tVJ1zti9vtIOV+efitQic/AKnIUnaEC/jcKN7hrov2ud3z0XrqCxYsmYpupBgc2u/RYn2ZlQh
 QMVFvjGGRwHF2s4sTNfrJx8IiuTbYQ9kGUuL4DoWnu4yqZNUGwVu8aBGKv5pqKHaLqxkPB1KNSe
 fS6KUwaJAtak0K3bZdlXzmIKHLobJkpq1uGyCoM+jRQ/2Ol36O6q9Pdeun2ncrt7M5Nl5AD29UI
 geEaEsKjdfR53Amfjt6G15V8eZJ2brWFb06UOJtZqWHhUc7tpnfap3a8Yo4vg==
X-Received: by 2002:a05:6870:1797:b0:435:486c:f2fc with SMTP id
 586e51a60fabf-439f94bfe19mr13075560fac.18.1779211352539; 
 Tue, 19 May 2026 10:22:32 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-43a946f3b20sm7006369fac.0.2026.05.19.10.22.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 10:22:31 -0700 (PDT)
Date: Tue, 19 May 2026 11:22:25 -0600
From: Tom Rini <trini@konsulko.com>
To: michael.srba@seznam.cz
Cc: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Anshul Dalal <anshuld@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Andrew Davis <afd@ti.com>,
 Hrushikesh Salunke <h-salunke@ti.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Ye Li <ye.li@nxp.com>, Andre Przywara <andre.przywara@arm.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, Dhruva Gole <d-gole@ti.com>,
 Kaustabh Chakraborty <kauschluss@disroot.org>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Heiko Schocher <hs@nabladev.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Lukasz Majewski <lukma@denx.de>,
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Michal Simek <michal.simek@amd.com>, Yao Zi <me@ziyao.cc>,
 Peter Korsgaard <peter@korsgaard.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Tingting Meng <tingting.meng@altera.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Alice Guo <alice.guo@nxp.com>, George Chan <gchan9527@gmail.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Alexey Charkov <alchark@gmail.com>, Ronald Wahl <ronald.wahl@legrand.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Subject: Re: [PATCH v8 07/12] mach-snapdragon: Kconfig: changes / additions
 to support SPL
Message-ID: <20260519172225.GD1858239@bill-the-cat>
References: <20260516-qcom_spl-v8-0-69b55c9abffe@seznam.cz>
 <20260516-qcom_spl-v8-7-69b55c9abffe@seznam.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="9ZY6LVpLd4UV/IBu"
Content-Disposition: inline
In-Reply-To: <20260516-qcom_spl-v8-7-69b55c9abffe@seznam.cz>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Tue, 19 May 2026 22:05:20 +0200
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


--9ZY6LVpLd4UV/IBu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 16, 2026 at 08:19:56PM +0200, michael.srba@seznam.cz wrote:

> From: Michael Srba <Michael.Srba@seznam.cz>
>=20
> Select SUPPORT_SPL so SPL build can be enabled, disable SYSRESET_PSCI in =
SPL.
> (SPL runs in EL3, so if SPL itself doesn't provide PSCI, nothing else wil=
l.)
>=20
> Also select (SPL_)OF_LIVE and DM_EVENT/SPL_EVENT, which are needed to fix=
 up
> upstream dt to make usb work.
>=20
> Mirror u-boot proper selections like GPIO and pinctrl to ensure consistent
> behavior, and select SPL_SPRINTF, SPL_LIBCOMMON_SUPPORT etc for similar
> reasons.
>=20
> Signed-off-by: Michael Srba <Michael.Srba@seznam.cz>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> ---
>  arch/arm/Kconfig                 | 33 ++++++++++++++++++++++++++++++++-
>  arch/arm/mach-snapdragon/Kconfig | 10 ++++++++++
>  2 files changed, 42 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 850768282ce..255d2035cdc 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1136,6 +1136,7 @@ config ARCH_SNAPDRAGON
>  	bool "Qualcomm Snapdragon SoCs"
>  	select ARM64
>  	select DM
> +	select DM_EVENT if USB_DWC3_GENERIC
>  	select DM_GPIO
>  	select DM_SERIAL
>  	select DM_RESET

After looking in to what's going on here more, this should be:
	select EVENT if OF_LIVE

And is a standalone bug fix. The event in question here lives in
arch/arm/mach-snapdragon/of_fixup.c and is for both USB things and
OP-TEE things (so USB_DWC3_GENERIC is wrong), but desired even if U-Boot
doesn't use USB as the linux kernel will consume this device tree, if I
recall correctly. But next, this only fires on EVT_OF_LIVE_BUILT and not
one of EVT_DM_POST_INIT_[FR] which is what DM_EVENT gates.

All of that said, what exactly is the failure to build you saw in your
series, without the above? I do worry there's something else further
going on here. Thanks!

--=20
Tom

--9ZY6LVpLd4UV/IBu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCagycTgAKCRAr4qD1Cr/k
CrIHAQD1C9Cqj5W54jtjuetKgB7YYC4XKTokzLi/gbQGxW8F7AD+Mnd99MtWesr/
JGmA+e6dt6F4v5zqd7nw+Jw8akUnqg4=
=R4uo
-----END PGP SIGNATURE-----

--9ZY6LVpLd4UV/IBu--
