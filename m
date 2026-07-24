Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D7FFC531FA
	for <u-boot@archiver.kernel.org>; Fri, 24 Jul 2026 15:53:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 305B740A40;
	Fri, 24 Jul 2026 15:53:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wcyxSAvrKK-E; Fri, 24 Jul 2026 15:53:30 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6201F40B38
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784908410;
	bh=2eLRYYxT1+SMtbiPKuIvg/2Dovfg9eYxZs1HmQlTsv4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zd4qJtg/+QbCfB4GCANqrLLJ2hNjpGFlOP7F4F2uZuUiEHqbO2Kfrjv7NXKkXQD7q
	 f/KmKpb0ts9D/hVHmrxZUzf4b5WqGxE1qTOor47BjJ0ZdQBUZ9tpimzQVkVatzoMbs
	 48mIIvXZhUKp4R3E73Uybbp022eij7hBg69JARAHdLbbRuUD2azY4xvqfeBFkBbF+/
	 Sqh2GJ0194wyC1otOxHf9PrP4u/mq1/sLldUYSEZpysf7qTrVHOe8jOnQMAH4Xb1Ty
	 xCLbjy3dsXwLo5A6H6eeXlB1XWLpYDuksFnVql+RKwUgaF7/hveO4++qgELBpo7nY8
	 lRcDQyG2e65pg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6201F40B38;
	Fri, 24 Jul 2026 15:53:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6A79EEB
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 15:53:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5083C40B38
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 15:53:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GQiLLckgIjno for <u-boot@lists.u-boot-project.org>;
 Fri, 24 Jul 2026 15:53:28 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32e; helo=mail-ot1-x32e.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 7112C40A40
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7112C40A40
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7112C40A40
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 15:53:28 +0000 (UTC)
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7e9ef94c0e2so269913a34.3
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 08:53:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784908407; x=1785513207;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2eLRYYxT1+SMtbiPKuIvg/2Dovfg9eYxZs1HmQlTsv4=;
 b=jZ44l4hQR1luBD8SeGah2kilKM+0alPRREXhx/EJvWwpc5mYzgofW+RRCPO7KANuM1
 E4RaC+DQcIGD02QrMaaKJt2Zkltov0gqo2djOG1p41iEBpoSUmUP3uOnOpfXwwkh3qxT
 sPtRNvPFSN19ohNhB16/6liGiyFDPWvl38C1i9O3VOiS1kL7RYSM19iE6b9ddIWwQpEt
 NRrbUeaGA8bd8KJUc5Jfw8hAEwv9N01iLmMceXIGzON/2SHjUkeThYeEolCpVV4yE9qp
 IKrAJrpszE9qHQ7G1XaO5w1U72xnvRMAwuPjDvU1h4eBVF4kngJQEj22qgYyb0sOG9CI
 jsyw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrLR9aygXnE2TIQXt7tAw9v72x9uX20q56gwbbkyZ3QplCGPBaeO/CT0bJDLUIoEf624CUDRvM=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YxFLGWCU10NBT9rwfYPSc+OmJl2rc81BXTAKQi28IDCKgtQo6r+
 vdqDZ//Mw3D9yRio9EI0JlEH+O7nJPRM8rQ7W8QqUiheTJO52U2M0rOmMv0bX8VhFEgPup8/0lj
 ModtEv7Q=
X-Gm-Gg: AR+sD12R03D0e8ndJvAFxTpqmYWWctYrgVFRXwIy0FTXxoPeH6NR95ZVwTbhtcsKaj7
 nggKEIJJmSSlP9ML2l5JWQjnBv0sqHexL/JpEnVDEoGRbalgPy3kCtrh6NtOsvcfCb4fEpeVgNH
 NTDGlrcpNBaUqms4r/m8Q/nFBA+NiC0is576M/bghXR9fL9CN32IJZzEEYraYINj9h16dtLk4KI
 M1sv08ic9ikpjU7hsqatJLXpEW/CPRlc3i4UIG7MxkanNUsq8ZrehTrUz/cP/aurf0XE12TJ2CO
 TNhug80CjxQGMdDY1odF5EbBTna1xf6OJn6tWfew4AYqiy78vcH6bpdNQ9U0t1ydKY255r9gJ03
 7fGLywmua2lGy9tGpJkKv2HzKx/GEftcPe1yjx3Iyx6+to+VmRlB9xQkjTler99EMR8sMaUpJJu
 qcsowqPTHKJ/up9hQuHHyPDCgntwxpJSpjMpf9DnYCGdqfY5L0co4anLAoc3WGn32F6RIHYJ3il
 ucGt0DlOEkFEKslFcel/SUsGus=
X-Received: by 2002:a05:6830:368b:b0:7e7:7de:ca8a with SMTP id
 46e09a7af769-7ee43dfd097mr5859523a34.22.1784908407291; 
 Fri, 24 Jul 2026 08:53:27 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7ee29e0f876sm6116795a34.7.2026.07.24.08.53.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 08:53:26 -0700 (PDT)
Date: Fri, 24 Jul 2026 09:53:24 -0600
From: Tom Rini <trini@konsulko.com>
To: Carlo Caione <ccaione@baylibre.com>
Cc: sjg@chromium.org, quentin.schulz@cherry.de,
 u-boot@lists.u-boot-project.org, dlechner@baylibre.com,
 jstephan@baylibre.com, GSS_MTK_Uboot_upstream@mediatek.com
Subject: Re: [PATCH v2] fit: prefer the default configuration on best-match
 ties
Message-ID: <20260724155324.GE749385@bill-the-cat>
References: <20260709104940.75514-1-ccaione@baylibre.com>
 <DK6WQC5RS7VS.7LJNJHF6LZ2I@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7IG1vGB+FFIf0lNT"
Content-Disposition: inline
In-Reply-To: <DK6WQC5RS7VS.7LJNJHF6LZ2I@baylibre.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1784908407; x=1785513207;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2eLRYYxT1+SMtbiPKuIvg/2Dovfg9eYxZs1HmQlTsv4=;
 b=BaY4uVypaey2LMpxH6mFchLqzRiSJx1/RstzErC7EJIWZsgiTVLMpew73fcKi/ndyK
 PIeVH3rg0kyfJIOIpksk9vPPgqWI+fcx/V4a2SoXe/X+7M1MKcXsEDz9OkjpZe7qM6Ma
 gARtRCyItmn2d3dVb/1bZNGZ1pmFHf/5w999Q=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=BaY4uVyp
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>


--7IG1vGB+FFIf0lNT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2026 at 05:30:17PM +0200, Carlo Caione wrote:
> On Thu Jul 9, 2026 at 12:48 PM CEST, Carlo Caione wrote:
> > With CONFIG_FIT_BEST_MATCH, fit_conf_find_compat() selects the
> > configuration matching the most specific U-Boot compatible string; on
> > equal matches the first listed configuration wins and the configurations
> > node 'default' property is never consulted.
> >
> > A FIT whose configurations all share the same base devicetree compatible
> > (e.g. one manifest carrying a base tree plus overlay combinations for a
> > single board) therefore always boots the first configuration, silently
> > ignoring the default chosen by the manifest author.
> >
> > Break score ties in favour of the default configuration. A strictly
> > better compatible match still wins over it, and FITs without a default
> > keep the current first-listed behaviour.
> >
> > Reviewed-by: Simon Glass <sjg@chromium.org>
> > Reviewed-by: Tom Rini <trini@konsulko.com>
> > Signed-off-by: Carlo Caione <ccaione@baylibre.com>
>=20
> Hi Simon and Tom,
> any chance you can pick this up for the next release?

Ah, so I had read
https://github.com/open-source-firmware/flat-image-tree/pull/59#pullrequest=
review-4663326599
as requesting a change in wording, but I guess it was acknowledging a
change in wording you had done, so I should grab this soon then, yes,
thanks for the reminder.

--=20
Tom

--7IG1vGB+FFIf0lNT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCamOKcAAKCRAr4qD1Cr/k
CuElAP9+PpO+r5Ljn3BW7+iUxT97kRsLWWR2H2UIAK4QsX4SNwD+MnjzQOGrBvf1
DF+UhYse9GDdyqkN53m6JBSE80Ek3AU=
=CwTu
-----END PGP SIGNATURE-----

--7IG1vGB+FFIf0lNT--
