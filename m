Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78C64C61DBD
	for <u-boot@archiver.kernel.org>; Fri, 28 Aug 2026 18:07:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6919840629;
	Fri, 28 Aug 2026 18:07:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RVFZxUTAf_PB; Fri, 28 Aug 2026 18:07:13 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787940433;
	bh=gyXGStttv4GzxewQe4rJzRrGIbmTldDHhj4Urt4Esfs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uCc07TkXyoUP1ZFx7DIvf3NwjID86wq6YjDfVJYkjQ8+96WhStK9Pp08hM5Vg+mnr
	 eva4lIU/ytHBRYT8708thX35B3zyZW7cJUdtufsxwFHIC6VNOXBnlHA9FWlw5w0OTj
	 kBYMU6EkcHFTzOcy2vXGOkBS4oibYnJ0X68KQgf5NoE0R4oCbRdMsrBRH1RujI5x+a
	 ZFVq0nsA56mxOlm4g41l/2jLosUUjmcrClt29phomwWAQN6FyItHCGR4NfSEEinYov
	 XK1XYM2Gyu712GHVxU7kMu0E/ULE7PS6deWjq5qqeWmy/5gFyGihfFO90720AFs0nR
	 SlQd90GWaWLiw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 27A62402D3;
	Fri, 28 Aug 2026 18:07:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 29C23127
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 18:07:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D4F9080E53
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 18:07:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IU8MJZsWuw2D for <u-boot@lists.u-boot-project.org>;
 Fri, 28 Aug 2026 18:07:09 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32c; helo=mail-ot1-x32c.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=PTCUegWh
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6CDF780E52
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 18:07:08 +0000 (UTC)
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7e9ecd7216cso1265296a34.3
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 11:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1787940427; x=1788545227;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=gyXGStttv4GzxewQe4rJzRrGIbmTldDHhj4Urt4Esfs=;
 b=PTCUegWhwlSRBmOCuGL5pUB9veo5Upj/E2C2yEq/Iwk/WkCTOhUTrkpsrzUU3jgvIE
 P4TEVwMAxCKpOdXzLGyjeVdFb3uMtFu6Ph9F32IU6MKteyc+nk1Syq7PcPkTu521jKyZ
 tiLXUw4iADyUAL22LKBYJxTIKGQOZh+6yDxtA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787940427; x=1788545227;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gyXGStttv4GzxewQe4rJzRrGIbmTldDHhj4Urt4Esfs=;
 b=Z3kvNpLAN7u3N4E3oAlR0YKPChtOXIQxGyo7vJhGntU5aCv2r/MIRckHkfoJpDDQ56
 W3YKJekQxRsfrnmCCuw7LluRkCWTUKH79eVpcaLqYXTIV4F5RSq79iL+PhGCl1y971nT
 2FjHm1B3JKvoRDx7iUpemQxWwlVAM1RnSYLu+gA7N0p7WR8QZ/Wm1e6PaD6TMWT8JCTQ
 hi+xQ9CN+7SOm9usLnhyn/5lMYeo3eicXsS5KrVK9HYtCna+N15CaX7gKaso5hLSPg4s
 n4JKb0alUv5KjYKa9ju0vnR0EQvdH3TwGIS187no8IlOt0STL6RaZMgJorPeFLHbKLO2
 8pIg==
X-Gm-Message-State: AFuF++kWYC2RLkMBCcRebkPVva6hnFeWrM5mx2dW0B85k6YmGyWffTkU
 vXbEQ4Dnk5y9aOxf3JK76a/TZoHdK9FQrF8mPdmAvt36C587D6bg2IP+w2jWKqviKx0=
X-Gm-Gg: AR+sD13vYWyx/Y4PaClUrUMBCLszvcnPAedJVhozz5eZZc0C0du9fLh+/MNbKW5A97/
 a0DfivbAj5RNdms6c08cTgDjAGs7Bik10upr653gDyoN2ZS/TT/dXIK4VoGBt1/NnYodOXHtvI7
 +fvI+5Y5mprXvG+OXZlwdSdrbp6CgUH1t6E3yBv2nDw1TZ7hchVBNrub40GdpslPwKhH1MVo3yS
 bl7Moi9+9U0wdooxiSTrQk3lrbF2YuHKzBiLbfJrQY88Kjyx3Hl3lRWVJ2kqPdemr+h7hQO7tmJ
 vx0S/oXgGxy5aCSOpGYFjDFay8UIt20Th44Iny2hIRHFBQ2SEtg5iSWxhJOwIduetZ6ICWDJAnE
 m6fLY3NQsYcPlEFoKTur4TBeZ2ouvee8f5zUUIdnGzkpSiyz3EF2KM/ZCqctjWCSZ2AXPR+91V/
 lutd+099gmT4MUPNED2RaG8XNO5cLzVmno0WqOfTHQZtvC5T3yipjrjzb16GvrNjCVOeKG8zyF3
 NllHLH4c7V+ygIxnOG+gfUq4Y3zMzF8m7Vx49E5G7e2KKAOLQq+VfZ6wcngvXXAEawAPGvyT/8A
 O1v6RNQt5LtxZJs/h0u+
X-Received: by 2002:a05:6820:c2c6:20b0:6b1:3496:9ab with SMTP id
 006d021491bc7-6b1c661ff83mr6606473eaf.2.1787940427590; 
 Fri, 28 Aug 2026 11:07:07 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6b1ce3c487fsm2253417eaf.15.2026.08.28.11.07.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 11:07:06 -0700 (PDT)
Date: Fri, 28 Aug 2026 12:07:04 -0600
From: Tom Rini <trini@konsulko.com>
To: Suraj Kakade <suraj.hanumantkakade@amd.com>
Cc: u-boot@lists.u-boot-project.org, michal.simek@amd.com, git@amd.com,
 padmarao.begari@amd.com, Simon Glass <sjg@chromium.org>,
 Rasmus Villemoes <rv@rasmusvillemoes.dk>,
 Sumit Garg <sumit.garg@kernel.org>
Subject: Re: [PATCH] scripts: fix CONFIG_ARM64 conditional in
 upstream_dtsi_include
Message-ID: <20260828180704.GA239428@bill-the-cat>
References: <20260824044311.707734-1-suraj.hanumantkakade@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="lXAKAv44aMI3231m"
Content-Disposition: inline
In-Reply-To: <20260824044311.707734-1-suraj.hanumantkakade@amd.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org


--lXAKAv44aMI3231m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 24, 2026 at 10:12:55AM +0530, Suraj Kakade wrote:

> upstream_dtsi_include uses $(if (CONFIG_ARM64), ...), where
> "(CONFIG_ARM64)" is a literal string rather than a variable
> reference. Make evaluates it as the condition, which is always
> non-empty, so the arm64 upstream dtsi include directories are added
> unconditionally regardless of the target architecture.
>=20
> Use $(CONFIG_ARM64) so the condition correctly evaluates the Kconfig
> symbol, gating the arm64 include directories on the actual target
> configuration.
>=20
> Fixes: 3a4e5944c96c ("Makefile: Allow upstream DT subtree to provide DT i=
ncludes")
> Signed-off-by: Suraj Kakade <suraj.hanumantkakade@amd.com>
> ---
>  scripts/Makefile.lib | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> index 122c8e78204..24b1a581790 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -251,7 +251,7 @@ dtsi_include_list =3D $(strip $(u_boot_dtsi_options_d=
ebug) \
>  upstream_dtsi_include =3D $(addprefix -I, $(srctree)/dts/upstream/src/ \
>  	$(sort $(dir $(wildcard $(srctree)/dts/upstream/src/$(ARCH)/*/*))) \
>  	$(sort $(dir $(wildcard $(srctree)/dts/upstream/src/$(ARCH)/*/*/*))) \
> -	$(if (CONFIG_ARM64), \
> +	$(if $(CONFIG_ARM64), \
>  		 $(sort $(dir $(wildcard $(srctree)/dts/upstream/src/arm64/*/*))) \
>  		 $(sort $(dir $(wildcard $(srctree)/dts/upstream/src/arm64/*/*/*)))))
>  dtc_cpp_flags  =3D -Wp,-MD,$(depfile).pre.tmp -nostdinc                 =
   \

While the diagnosis makes sense, the fix is wrong. The use case that
needs to work is we have 32bit ARM platforms that require files found
under dts/upstream/src/arm64 because they are common to 32bit platforms.
The whole list of failing platforms is:
j721e_beagleboneai64_r5 am62x_beagleplay_r5 am67a_beagley_ai_r5
phycore_am62ax_r5 phycore_am62ax_r5_ethboot phycore_am62ax_r5_usbdfu
phycore_am62x_r5 phycore_am62x_r5_ethboot phycore_am62x_r5_usbdfu
phycore_am64x_r5 phycore_am68x_r5 am62ax_evm_r5 am62ax_evm_r5_ethboot
am62dx_evm_r5 am62px_evm_r5 am62px_evm_r5_ethboot am6254atl_evm_r5
am62x_evm_r5 am62x_evm_r5_ethboot am62x_lpsk_r5 am64x_evm_r5
am65x_evm_r5 am65x_evm_r5_usbdfu am65x_evm_r5_usbmsc j7200_evm_r5
j721e_evm_r5 j721e_sk_r5 am68_sk_r5 am68_sk_r5_ethboot j721s2_evm_r5
j722s_evm_r5 j722s_evm_r5_ethboot am69_sk_r5 am69_sk_r5_ethboot
j742s2_evm_r5 j784s4_evm_r5 aquila-am69_r5 verdin-am62_r5
verdin-am62p_r5 mt7623a_unielec_u7623_02 mt7623n_bpir2 socfpga_is1
socfpga_sr1500 socfpga_arria10 socfpga_arria5 socfpga_cyclone5
socfpga_mcvevk socfpga_ac501soc socfpga_ac550soc socfpga_dbm_soc1
socfpga_socrates socfpga_chameleonv3 socfpga_secu1 socfpga_vining_fpga
socfpga_de0_nano_soc socfpga_de1_soc socfpga_de10_nano
socfpga_de10_standard socfpga_sockit

--=20
Tom

--lXAKAv44aMI3231m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCapHORAAKCRAr4qD1Cr/k
CmqhAP96HnfhbQu/Fk9krTE/ZRqs3Q7n+MEgkMaRcZQbSJ4ZDAD9Hysc2GbAimGU
CrlKVY1CVcu3eZl6eqBFQ//PuPFZ0Ag=
=IC4p
-----END PGP SIGNATURE-----

--lXAKAv44aMI3231m--
