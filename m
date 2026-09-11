Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B424C88E53
	for <u-boot@archiver.kernel.org>; Fri, 11 Sep 2026 19:01:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B898440806;
	Fri, 11 Sep 2026 19:01:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PofqiFCVsGMB; Fri, 11 Sep 2026 19:01:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org B324640802
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789153280;
	b=KldU/ZlpFmoprb36qZTAPQVTh1ii5mmXMPw8LRyocygISFaBeoGh91e5SIOic78e9M9r
	 dH4sHiUIrAQ2gi5haAZ3CkDOKaGuliwU5dZX2WMUg57ZF0neLDfVGMdk+YqGZjbP3ixG5
	 pLDHonelg/NaAqgsnv5szN2xqpykdZcBCpRZX2pEqh6GU65iF9z5U7WEv0ogtJgw3blHn
	 8S/jNCc50bj7XFMR3O7TK2zyiQUS6RuAiwEEoQqPB264jfdZQ0Pc64D14AsccdMaGQUpV
	 UYyKZI0+gTqgcVL4ZqhEbXuZsurIqUDELmveY9LPJ5bCJITmczGOlTGhRpEmMtiOy8w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789153280;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=4TVgALyoi2/HW11+3piCmbgx4QRXvkzLVJHOF/gW7YY=;
	b=rYtCnCk++d6BsGGPQUfLK8F7LwZIzfYRgS70hzzdbCsNsBdpmqG+d1r95VDdMcFGZi6q
	 AetNKJRiG3HJMQbb4QQB/WWTeRh2E84HV15/UO2bwtyGNwKQbwmeU9+S+DD4nm+0cZ6+W
	 cGc5QbpgFwBTANKM0tPlTi4SpPi1nl7zpe93qLuyDwW+00WLIhoNRui/5EObFY7+nwJlI
	 8ok/oEyf5bA1HjAG2mpo3Ln/tSMZTK2SByF2e0JPo0jBDLelvXgEkposFqDgFnZZquDNV
	 Cqudh4UhHhWJpvKvnmP+tYFKA03dKT7mZI6zYK58Nwza6tNjLbKt3za7QHfkLTEp/Fw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789153280;
	bh=4TVgALyoi2/HW11+3piCmbgx4QRXvkzLVJHOF/gW7YY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zKgNG7LRvjaYJHPtPLvWF1ipvWhKqSk5lp9cBwu9qjPTuIdGsFNJhJsO3RgJx0moB
	 jF6kwYoUiwoqr/d9xnfJOGX0ilqcLrisqMS5y2dllWC6N21G8Csq3Fbl0L9hu1r6Mt
	 WdvrUQAf0tqDS9QK7wW7crbOp8FHFs2i694NRgQ2KRSdJ52Y2yAoPta6eVYz3/OQ5C
	 Wdx2KOOe/35qUWvJe2Mzl/p7K2AbntHRz1N8e+1p4TLDUzmPo3UDfz2LwPu+xT39y4
	 9jm42mKf6qXBqabiLBuLiQX3FP//ngvL9tu35BrTZN8H5qhxe/rL8li1ywmUSno7yA
	 ZGaURksp5rVoQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B324640802;
	Fri, 11 Sep 2026 19:01:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 183A672E
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 19:01:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F1A6780F30
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 19:01:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id daEhcPk9DsPf for <u-boot@lists.u-boot-project.org>;
 Fri, 11 Sep 2026 19:01:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org CE47580F1B
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::42"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789153278;
 b=NaLLsF7INTLTTJd0gc9ffBCLUZsfhvCrxC+YLmJCTfEfzb6Il955br3AiSZ79emaMHwe
 GQf77bXGivvrPZQ0F4c9vNjGQqAthFGgkb0t95+4vWo3X6+ez/x170iMztNxw4YNOOgFQ
 eJ0/kqDuU6qxfrLRnNE8ebZn7I7rUKIdGDy7R5RaXebGKdEPAJowOIynRQfc24u5iKHdG
 GA4CRBcpnrUlELqOZnV8ie82YDYa5A6NZIFih4ZLeph1ReiGYmpplasFVZ7gzqxHXN8w7
 /cNdBPkSWNkjmyRMNzF6Ii1MWnY6xvnzIU9kM26IMy9mOZed1htuWhMrbRz4oChklvA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789153278;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=4TVgALyoi2/HW11+3piCmbgx4QRXvkzLVJHOF/gW7YY=;
 b=CxDx6qN5ICBS7z+ckMuyT2TLmjbqQlLz+r1RrK2CYVYQp1uLh1mqAeCTJOIIYl50gdrj
 AO1YqRyCJSKQc+RakJtr5MDNxlf+hiI/k9pfZ0j2jeuitRD3k0hOLZm9o9VYer7iHMGgp
 X4YbkbhCuWPVBZ5xcMkvww8ylfVRbU1nbHE7QVYa08LlC1DukY/AFNWfoH+ZnFGXjBtfH
 /7nNd/VnD3L2ocjFUlwqLLxrbJ0jsqX4D5XCi83mtC5B3uxMSH30FvjvHaA3WGVRmrRS/
 lzWlpxE0aPMuSWfaWjGGD/NPVt/HCKayhHEG7ZaQj/WN5Kh033eWz7AMciFwL8j1OSA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=eBBWUPo6; 
 arc=none smtp.remote-ip="2001:4860:4864:20::42"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::42; helo=mail-oa1-x42.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=eBBWUPo6
Received: from mail-oa1-x42.google.com (mail-oa1-x42.google.com
 [IPv6:2001:4860:4864:20::42])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CE47580F1B
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 19:01:16 +0000 (UTC)
Received: by mail-oa1-x42.google.com with SMTP id
 586e51a60fabf-46556b9e02cso853592fac.1
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 12:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1789153275; x=1789758075;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4TVgALyoi2/HW11+3piCmbgx4QRXvkzLVJHOF/gW7YY=;
 b=eBBWUPo6ZV5KZmlR8fpTUollRHdRP9hN6+5MD/A1Wc+MF2roCMbdYD29QmBiJHsA64
 xUIn2eauPP6wAy5wxzYmGya3r/NmUjZBsVovsBTmD7gjWL03bRSmuPg4aDmhP676y3Ji
 bJQ0+sv7WDJJFlCpC2A6KL2XCBBWEQklmRkvw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789153275; x=1789758075;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4TVgALyoi2/HW11+3piCmbgx4QRXvkzLVJHOF/gW7YY=;
 b=MBHZay3LB04Lglr9GmxYQhQcgDHbcTSpmNB5PjVz2vOYe6mZL3AEvPwyxExVmM/jUH
 dalm6SVWNjXvP+FG4Hy6GFejf7CcXwmYOY1R5/BWZUolS3BTDf8/0/zkkx81vpO8xoid
 4UxUrYOK+RQpkxLkUOO2UaUHQ9FS700VLaHQ+Y3nEdP9FblXXuA23HeWsWC566MDiNU+
 BNfwPM1RscsZ+z+OjrayBXa8iH4a/ZBsNKI+Mve9Bl3MbJHDY0MJJvxCnde2xFpUvNUB
 savgCDuuAsCaWVtMc90XZmv1MuWnMM9KZdR7WzX+WbedOmWJfx/s24JY3Agd0uueiTx9
 fCAw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwWul9NKDTCQk+sVBUAjB2dnlP/MeWhGaWFCl1M23yIRdJiR9mY9/mOpq+ps/p/2Msgg4HuMn0=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mQBz/wZJR+Zl4jJMR6thyXWZvSoRtUqN5ACc8XIYhySSibkmrE
 Qo/Y9+KrLeK3aqbF5gB6efpXAHBr806oYruL2y4RR+xBwmXS0NlDRdrVYriYyI3C9qU=
X-Gm-Gg: AYBFou3Bwo2IiWF161C0ouc6mGumT1mEAsYncWQzlnbH/bCPiBhAr0SQHuAIrYeqs7i
 eiPQpWUSRik4p7lkEtM3cguOAvWK7g872e5P51iyqDIo+/X/Zt0YNTyY8mg2I21d5/fGFv/inV/
 +1J5JbHc/r8IwlLEXo71Ywihxain0wUbgl8klZKSxQlDB/3/k4y0Ure2frpBWveQRui0Vhisehu
 q37J5ERWb0cj/PDgEeyFH/Kg2GwKrH3u1kywpOaTd4FwQ5RPQzkpBJ+OCPUxfpAOLQLzawhZrKu
 P0l0PveLNlkkZt3Ke2KipysF5tAZqQmnIdH5F9CYVLxLk7/z6yGW3YiRKGM+WoAJqXnPFyr2jkR
 /C1VcLBy6Ay6B+AwuxcHFNr8wKCS//QD/R88bNv2entOAIxhmgejdq17ipqPb14W+3tGvuRiV3l
 hdkvpOac34aAeKrFuPqd9az1AF644GBYCCKmpEsfH/t/f/wL5DgDcMdr/xNOq3GWbrXxc1DPW5Z
 Lqr6oo6d83nDGvxwxb4az1qmwkev1CY1GBa+dAhDn23uJ4am3ipd/yBgultCSLngEBkjtVToLsD
 SLc2oec5X/VoviHmT44S
X-Received: by 2002:a05:6870:9a15:b0:46a:be8b:2487 with SMTP id
 586e51a60fabf-47c99000bf8mr5908697fac.14.1789153275449; 
 Fri, 11 Sep 2026 12:01:15 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-47df8bd0260sm2582329fac.8.2026.09.11.12.01.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 12:01:14 -0700 (PDT)
Date: Fri, 11 Sep 2026 13:01:11 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: phodina <petr.hodina@protonmail.com>, u-boot@lists.u-boot-project.org,
 Simon Glass <sjg@chromium.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Peng Fan <peng.fan@nxp.com>, Kory Maincent <kory.maincent@bootlin.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Kuan-Wei Chiu <visitorckw@gmail.com>,
 Raymond Mao <raymond.mao@riscstar.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Philip Molloy <philip.molloy@analog.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Markus Niebel <Markus.Niebel@ew.tq-group.com>,
 Alexey Charkov <alchark@gmail.com>, Heiko Schocher <hs@nabladev.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Anshul Dalal <anshuld@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 David Heidelberg <david@ixit.cz>, Petr Pavlata <petr@acrux.cz>
Subject: Re: [PATCH 1/4] common: Add command line parsing utilities
Message-ID: <20260911190111.GU1764417@bill-the-cat>
References: <20260911-b4-android-bootargs-carryover-v1-0-6ebb43da3df0@protonmail.com>
 <20260911-b4-android-bootargs-carryover-v1-1-6ebb43da3df0@protonmail.com>
 <17753947-74ac-4b42-8d94-436e7984e062@mailbox.org>
 <U6YrT3S_BQGuySCLDPjwnTxE9bvcH4uMX9vLfz5D0b32Kumb7X-TVcYowyUHmESFKNVU8jSLlDPqYQI9Y6owcWFWAicWEhCrB7lL4J1z6JE=@protonmail.com>
 <49a1bcfe-1aec-465d-b138-52b6803ce9c0@mailbox.org>
 <20260911185345.GT1764417@bill-the-cat>
 <a4899438-5010-4314-97c9-82ee72fb9e74@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="e83t+VeRggMcVElw"
Content-Disposition: inline
In-Reply-To: <a4899438-5010-4314-97c9-82ee72fb9e74@mailbox.org>
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


--e83t+VeRggMcVElw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 11, 2026 at 08:59:06PM +0200, Marek Vasut wrote:
> On 9/11/26 8:53 PM, Tom Rini wrote:
> > On Fri, Sep 11, 2026 at 08:46:30PM +0200, Marek Vasut wrote:
> > > On 9/11/26 8:39 PM, phodina wrote:
> > > > On Friday, September 11th, 2026 at 8:30 PM, Marek Vasut <marek.vasu=
t@mailbox.org> wrote:
> > > >=20
> > > > > On 9/11/26 8:18 PM, Petr Hodina via B4 Relay wrote:
> > > > > > From: Petr Hodina <petr.hodina@protonmail.com>
> > > > > >=20
> > > > > > Add a new utility library for parsing command line parameters in
> > > > > > key=3Dvalue format.
> > > > > Is this reinventing environment or UPL ?
> > > > >=20
> > > >=20
> > > > The target is a chainloaded environment. In this case u-boot runnin=
g on Android devices where you unfortunately don't have the possibility to =
use UPL.
> > > >=20
> > > > As stated above it's purpose is to simplify the operations on the c=
ommand line arguments from the previous stage and pass them to the next.
> > > >=20
> > > > Typical example is to remove the skip initramfs or extract the valu=
e for the panel to pick the right dtb (not part of this patch series)
> > >=20
> > > Is this something you could do in an U-Boot script using setexpr sub/=
gsub
> > > instead ?
> >=20
> > Yes, I would like to see how this gets used in implementation too, as
> > I'm wondering if we shouldn't just be also saving off something like
> > "prev_bl_bootargs" and leaving the rest to the board code to deal with.
> > Maybe we should also add the android-specific helpers in a new file
> > under an Android-related Kconfig as well.
> If this is key=3Dvalue pairs that get passed in in some chunk of memory, =
can
> 'env import' help here ?

No, from the whole series it's that we're being passed
https://www.kernel.org/doc/html/latest/arch/arm64/booting.html and then
dealing with parts of it. Some platforms do this today, even:
$ ./tools/qconfig.py -f SAVE_PREV_BL_FDT_ADDR
15 matches
a3y17lte a5y17lte a7y17lte coreprimevelte exynos-mobile qcm6490 qcom qcom_d=
ragonboard820c qcom_ipq5424_mmc qcom_ipq9574_mmc qcom_qcs615 qcom_qcs6490_r=
ubikpi3 qcom_qcs8300 qcom_qcs9100
qcom_sm8650

--=20
Tom

--e83t+VeRggMcVElw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaqRP9wAKCRAr4qD1Cr/k
CnEhAP9d0RsNTzUCsHvBSumJBezKpobyeqSjUsMHavFs2OawrQD/U7clvB08Mu8V
EaIR3Gup4tLIGgXl2/UmwrnM0M4ctQ8=
=Em/H
-----END PGP SIGNATURE-----

--e83t+VeRggMcVElw--
