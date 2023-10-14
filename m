Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86305CDB47E
	for <u-boot@archiver.kernel.org>; Sun, 15 Oct 2023 07:49:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED49886ED1;
	Sun, 15 Oct 2023 09:26:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="M90tLhP+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C92586B68; Sun, 15 Oct 2023 09:26:09 +0200 (CEST)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D0E086ED1
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 09:25:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-27d0a173e61so2180054a91.0
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 00:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697354723; x=1697959523; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Te/82gIt08mZpMXhPAzFRakbOh0JwmPe9k/KO2XJmvU=;
 b=M90tLhP+msbVmPJUas9MDJ40HAScx/ND8p6nOdSAK3fiFnk8g+fPxcrHo7gFj8IprX
 U9cUZNYSAYfC/XJbBS1qSTagT7V9F3r9Z7rGOrdTQ5uXjnBkEdMTV3RRXzUZ0ib8kE4x
 HhVhMyym057eTJZmQ11RpD7+flXSyRgqM+W4w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697354723; x=1697959523;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Te/82gIt08mZpMXhPAzFRakbOh0JwmPe9k/KO2XJmvU=;
 b=QpawaH0UOqKHoXSnvGcGq6KeavCs0j7Jy7wfT3q2VM4ee6cacXQsR4kO4AwwtoXPur
 811mqe+pJ94ywbkr7c/yellVPFcV1CVWLzy1he8I2fAexa6V+CEScvTHPNQKq0LhlKCi
 vlGPAzDvgOT0yZP8MLZDsMKVJRMIzM4K6IdYlQW3id26LWP/22gB5u5grq/hg8oyGlbg
 p8uzknZA/2No+xUpjWwXvsnJ/YNTaBUgIK1Ra0dqZNtG3MdoMa5IBuzmycBDNDpLPrR2
 JYWlD4IZyP9WZmL/wV0K7s21KiVFC/Vhh7MqAiAHNMYqpm04r0YziYKFOC3s8mALsV3v
 I1pA==
X-Gm-Message-State: AOJu0YzL24g02cf9jGnk+lCPw/AQj6DHnsAaqP1t+k1xUeU9RSUH2o6s
 lsDRK7qNykK3TGKIGMhAhxFbDqnXtHuEiXjntGJ8mA==
X-Google-Smtp-Source: AGHT+IGM/cf1AAb/8Optn1QSFFuuhaBOxYPOaQX6wBSHm4S1jvBcWdRid/vWfGUPTX6hTuRnVpdxLw==
X-Received: by 2002:ad4:5310:0:b0:653:5960:8959 with SMTP id
 y16-20020ad45310000000b0065359608959mr29406085qvr.41.1697294972430; 
 Sat, 14 Oct 2023 07:49:32 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-0f48.res6.spectrum.com.
 [2603:6081:7b00:6400::f48]) by smtp.gmail.com with ESMTPSA id
 g9-20020ad45109000000b0065b231b2cb4sm1670416qvp.105.2023.10.14.07.49.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Oct 2023 07:49:31 -0700 (PDT)
Date: Sat, 14 Oct 2023 10:49:30 -0400
From: Tom Rini <trini@konsulko.com>
To: Francois Berder <fberder@outlook.fr>
Cc: u-boot@lists.denx.de, patrick.delaunay@foss.st.com
Subject: Re: [PATCH] firmware: scmi: Fix clearing variable
Message-ID: <20231014144930.GX3119521@bill-the-cat>
References: <PAWP194MB2055B50F4E55CA0A416DE2E2DACDA@PAWP194MB2055.EURP194.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="3kIsmCWTWPDl4FP7"
Content-Disposition: inline
In-Reply-To: <PAWP194MB2055B50F4E55CA0A416DE2E2DACDA@PAWP194MB2055.EURP194.PROD.OUTLOOK.COM>
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


--3kIsmCWTWPDl4FP7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 10, 2023 at 07:44:32PM +0200, Francois Berder wrote:

> The sess variable in open_channel was not entirely
> cleared to zero at the start of this function.
>=20
> This commit ensures that the entire struct is cleared.
>=20
> Signed-off-by: Francois Berder <fberder@outlook.fr>

Applied to u-boot/master, thanks!

--=20
Tom

--3kIsmCWTWPDl4FP7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUqqnoACgkQFHw5/5Y0
tyzwtAv/d6MYMlpUA1GsaSq7OSKTPAskGSRw+MESokBNaUGbqBzc/R4aMGc3Ox3j
zZ2eHosaI7mXiEiytlCnUCKWbmjrQc6Ao9eGypVuloPZfQN78CbVj21M258sCD7O
Om3HLiLA0o7yOL901GHm7+1e6uIAsia3Bof02mmyX1W89ig9Pa66ro65EJ1yUP8d
Nb7QwXPVKl0j8f9cUe0lsUGrjMCpT4527F9jpuzCWFfgOwUnmVzgq+6kSzxb5pD+
KDo2rO6M+fVnJOialaRwTJkY7j6X8Hj26fgvevr2lVxAQrHTIVEqUlPDbkKfUA/R
RNn1h9S8OQ+ei/BrmAsyhABdBcTPVZ6F0HmIArCYMjhNbo4GgsWzgbTJtpsKxFh2
VZ0Jvp4NG4Pye6bCpADEIrRE2NeI5/6y/B+TgKwSlg1xFn5ONMSlZnMi+c19qfxU
QbNSwrDIqSFAPzN5/wC6cv36T825iCUxksxsVdmog3TVehVXWZlWVgACXsrngcwX
VOBlCBR7
=DmdS
-----END PGP SIGNATURE-----

--3kIsmCWTWPDl4FP7--
