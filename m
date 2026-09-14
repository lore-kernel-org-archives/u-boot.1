Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93640C88E73
	for <u-boot@archiver.kernel.org>; Mon, 14 Sep 2026 20:39:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2AAD480AB2;
	Mon, 14 Sep 2026 20:39:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ggrfqaw6J2DQ; Mon, 14 Sep 2026 20:39:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 75B9A80AA1
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789418378;
	b=j4q6v9rHkGv8qA4hB1vU4RlIdmylfdy9UPOjK0PlOH3roz6u/y3RxLL2S7rkPFZe01af
	 RpplE71EdXirnO9D5OP9EC4RaU3s5pSWetPdGacJvTrtx99RAEJW1eqyX678hY4UaAAxM
	 cnMKasXSXymk1BGM4xq9QAL6XYO2dDKI1NjfJphjjTx6HYCOF8Zk//QpQiKqlCPSRdBrh
	 VuCagBezWTPOYjql7DR7zdlmViFyeabZsm0YD0q0WXF5pzve3mhJZESWWULSNpjfTJ7sx
	 PfyX0cUMG6dfDTrScbDUGxPnY7rLTtBxSzczgOtcLhW0EOXYhgvFeMzva1xMoczvMmQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789418378;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=THWL16fRBeS+PCba0zeYAa5sgNqtj/L0UiNGhzXHERo=;
	b=r3ibYsJsGJ3YDlYaZSgmpdrtY/ylAOPK1Pont2600ELkFnnPnfM5kmyw7BedePaMd2Gg
	 i8167fgs4J8LoY44q7B0VTrTrad4UV3xQHoV80pxzWpgsfoN+BRhY9ECnid5Xoog1Df0D
	 LVabMbdPbs1yuB6xiZLdHC1i6nsIwAcADDsJ7QfgbUojEjdRciFa9cDA/B8LHtkjn1T3W
	 yIDN1KbQ0OEJk7i5SyvEZZy2vC/vFLGatKhpZXwkBb3qkBI+kcDGdzy0v74nV9pFWgp8Z
	 gYWbdM8HLBDTGMTbb+Wb9FzVZhfBN0Oj9PV88QMxSaZcriT5pN/0fWHae925KDNIyNQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789418378;
	bh=THWL16fRBeS+PCba0zeYAa5sgNqtj/L0UiNGhzXHERo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=s5taLoBwUYpLFPHHinay5176ymS5cVtQyfmrdPYTv4b82JS48Y8vsS5KR4Vtec2Kk
	 AYhnZIbEUb29Aksyp/Dnl111+cbr8KNxgY9SZ02B0VxC3pPZFvACNs6nfhLXsaQwQB
	 PBteIhPFcRgmYu/LdEH5WEXwr0yD8RJhW30nQgREDIhA7jUFAVuCLmeqJ5bGP8UgVY
	 LQQLrT7i2vKk/rdMDAS1pXmrJpkFBK2SqGj9i9HecunqkN+CkOf5OaM+tnrdAU7Wpz
	 YHE2lJGr+JGtyHrpSRN29ozScY3tqadje09d86BZi7N+TTFEbXXeSZhtFu1GhMwCDV
	 PZK+3Vm1CIgpQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 75B9A80AA1;
	Mon, 14 Sep 2026 20:39:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id A7331EB
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 20:39:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 87B8740099
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 20:39:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qyx9uzlNCG-F for <u-boot@lists.u-boot-project.org>;
 Mon, 14 Sep 2026 20:39:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 6DFFC40076
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::235"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789418376;
 b=dFBUXoP0Ze/ESfXPIT+eBfqyOU7S7qGqmERlxgVinO2madhnbxDbev+q9/9dzyG3EjcM
 GbhKMIu54/OBOeN3vfJ0AOgiypqEWZnxkq1sCwiVSFTRTNeIByTT0fRcll+Z/6EjCf79X
 nrrpb4NIqKcGQQJkmYX+RQTNIGE8yQx6yX/cRRf6MjzCBVFLQQ+uSOxtiKkjI3blnFG7x
 LDax5gS29tCHsqTybgVQCx9sPnSVk7LnrZ9m+NcqR4t9LapdnJdGrDuDlo+Cq80JBLHyO
 fjpSivRIhpFdUIAJqj79wiZueS5Obpf71IoEGbb5hVoXTB5fn68bk3Phhugk3mF4Ffw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789418376;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=THWL16fRBeS+PCba0zeYAa5sgNqtj/L0UiNGhzXHERo=;
 b=pymZGVj36UiBonU9OTgotwX8Dps0HR4gE6wNdGqjuX7R0BVpiBzA06FHItxZON7eAbk8
 Zu/o7WQPaI2xUmdDkXlLPbHzs7Erro4M0NhJX+eCywh/AHCy1sPQIeDYpIkCYresj93/Z
 eJEVnalOVv3jnvcOAYddm1Dyf6jdr4rjjRPBEvRtpBnFF1JSQpZ6CIvkZZLi49ZQuxuh5
 X1CG4FjnxZAgVG8HJIynU5RQZCSNmhTlyLTQAgyFI6VBUIqauOsQM/dKn9zn+rdyZAOF5
 sCNYBo+JBsdanzEWk5fQ3QI1wKKk4ilaRA29Zv0WCOiZWV9/PHMTBq6ZJqzLG6c8ypQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=I0u90QPD; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::235"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::235; helo=mail-oi1-x235.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=I0u90QPD
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6DFFC40076
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 20:39:36 +0000 (UTC)
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-4b28d7c729fso2842607b6e.0
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 13:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1789418375; x=1790023175;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=THWL16fRBeS+PCba0zeYAa5sgNqtj/L0UiNGhzXHERo=;
 b=I0u90QPDqKNQw2EhC/E1bK2qmKhf1WKsc4OY1SKAfYLbfKmZnk51muxAiKQojxfmjC
 vcAUSZwbrEmdF4F5MWpu6m6YFEqth5HRyMoLYknygOcdhJCzJF/FdSFKmoPxHwBXtiDb
 UL0QYb+Nc/nSu14JZKRYLasr4A4Co6UDFWZh8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789418375; x=1790023175;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=THWL16fRBeS+PCba0zeYAa5sgNqtj/L0UiNGhzXHERo=;
 b=caEVraggyiru0WAf9zUHpAzKdl3yzXnu1GM2Vw9am8hbQhBU99c5+cN8eTBW5EsF0i
 YhJ0KfGhLo7yW8OE891qEBbFwcxE/XEv43+tOKIBRYZlQw2aiXSMHIt+/KwsDrzvt1Sc
 8wZkOxpIhlP4QkEAy11l+AW+OiAKOViXBlXQpauZG6liIaHsjo4ISpP2kojH7Zy0SoZ7
 o4KRacVyj136eT1brHM4RA7aEHp03QLdaiRkH5SFkYLr9puUmcXK6Xo2LNaBs6EUDEsK
 JQ0/X+9I5+IaCmXmExnfKd62bw5wh8wN0Zi4tehQ7Tfe8LjwfShKotrD6nY3Ad7sg+Yv
 NiSA==
X-Gm-Message-State: AFuF++kUIqnT+0V+UqqE5r4/ufspKP1KhTYjJHzJwFOcWialSZY7n7R/
 hrRvd3xWz62EhS7f3GGS/lwrXscA3S3sdLq+6Kmu7qOLdv7qNcloBGPTUl/0dgDxuT4=
X-Gm-Gg: AYBFou1PcWngx/wj0dvn7bcAON475rxQ+IIbqCCUqSSeM663KRuZdd8+XT++bxp1lpR
 Eg4Dz35lLKF5kb0ksDJ1kR2u5Zc50ZVnceOVUxGaVulBE8qCYYQMudMFlhkE+7dI2CXHPU6cSzy
 S9NCwYGp8ISltrSEQ9wrVetPB69dWNf28joM9py6f/WWyR4nzbE6ApgLmBG9YvO/nWWtX4mFYKw
 oyDL+Ts6xSUM7ERdcZsFsoVQ2UWqUpPtz7Wrxx4lzeLSxfSy4hzW1I+oqkKIirI0pLCrRmCRi8b
 G/QAHuTAJU1UEQJzApN3K8YJ8vjDX3P9lzrg7ORFcMSA9AMOjuZN6Tnl4Za4oMRhkRz8DDA5/B+
 c7T23OAZD4DbNOfZzcATsLmDFoTc8UWcFgtebaZkW1fay8ZhjagdB+aQ+/+S+Nst8WfVj2o51pa
 S9E9uzTeUKVnf7KzNB7SBcMf2NLzgxPoOtTKZeGmbZLt/Oj8JH+E9fxosVb97brvsRlTKb+86Xf
 8UX+nEmUlMXGq6e6pckXkahS0v4cURns9N2+JH/avE9Ri3oYVTH73B0crdPMRnIwepR87+YTUcu
 t0kuCer7X0NoDELVMy5D
X-Received: by 2002:a05:6808:1514:b0:4b9:e65b:8c33 with SMTP id
 5614622812f47-4c7b4cac43emr2644922b6e.33.1789418375071; 
 Mon, 14 Sep 2026 13:39:35 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4c3322e1baasm11848457b6e.16.2026.09.14.13.39.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 13:39:34 -0700 (PDT)
Date: Mon, 14 Sep 2026 14:39:31 -0600
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.u-boot-project.org, git@amd.com,
 Andre Przywara <andre.przywara@arm.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Aristo Chen <aristo.chen@canonical.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Heiko Schocher <hs@nabladev.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Kuan-Wei Chiu <visitorckw@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Marek Vasut <marek.vasut+usb@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 "moderated list:ARM STM STM32MP" <uboot-stm32@st-md-mailman.stormreply.com>
Subject: Re: [PATCH 2/2] Clean up emails from non-existing domains
Message-ID: <20260914203931.GA631895@bill-the-cat>
References: <08f68cd8c514140071090a846839632f8cae071c.1787560364.git.michal.simek@amd.com>
 <1b9532296bffb1918b90cfe61fb7692ea355d02f.1787560364.git.michal.simek@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="/Llwd5TOotmkQ+V6"
Content-Disposition: inline
In-Reply-To: <1b9532296bffb1918b90cfe61fb7692ea355d02f.1787560364.git.michal.simek@amd.com>
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


--/Llwd5TOotmkQ+V6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 24, 2026 at 10:32:52AM +0200, Michal Simek wrote:

> There are 5 domains which no longer exist. Remove all email addresses that
> reference them. Where such an address was the board's only maintainer, ma=
rk
> the board as Orphan.
>=20
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
>=20
> This was the way how to find if domain doesn't exist.
>=20
> git ls-files '*MAINTAINERS' 'MAINTAINERS' \
>   | xargs grep -hoE '[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}' \
>   | sed 's/.*@//' | tr 'A-Z' 'a-z' | sort -u \
>   | while IFS=3D read -r dom; do
>       if [ -z "$(dig +short MX "$dom")" ] && [ -z "$(dig +short A "$dom")=
" ]; then
>         echo "$dom"
>       fi
>     done

With Angelo's email being fixed, can you please v2 this patch? Thanks.

--=20
Tom

--/Llwd5TOotmkQ+V6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaqhbgwAKCRAr4qD1Cr/k
CgwdAQChhl18/1whCpfsvhM8TtiAQ+BlTC0liOik9b1MdX6ZdAD/U2gMmPQBN3TC
IPe9IxFonBABDytlmxke/5xjhilh2gI=
=YySm
-----END PGP SIGNATURE-----

--/Llwd5TOotmkQ+V6--
