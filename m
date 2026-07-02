Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DE4AC43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 17:28:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95E1D84832;
	Thu,  2 Jul 2026 19:28:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YyItd7HY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9203848DC; Thu,  2 Jul 2026 19:27:04 +0200 (CEST)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C027684409
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 19:27:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-48b7df4b4ccso569726b6e.0
 for <u-boot@lists.denx.de>; Thu, 02 Jul 2026 10:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1783013221; x=1783618021; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=h8HclfS/Iod6jelJG/cIFMyTVAnjIvEImgyn99oxA3Q=;
 b=YyItd7HYCUyvbWwc8GZFOobf463Xok4ARCa6H71wznx0hn1qx0hOKCE/ECJtCdBBAb
 TYsiQ8JZvZ7oxUW2wa+Urla4tdOUpDr/joL2ZlGJneXvD6n2BCLHLcfSJy27FFo5CLqy
 94u9R7L92xb/yh00Zt6eEjsdW7WHeoNFt7zlo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783013221; x=1783618021;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h8HclfS/Iod6jelJG/cIFMyTVAnjIvEImgyn99oxA3Q=;
 b=EstfZpTExVHOa5SuoMXoZaczu+wdXTGOcqNi58pKa8F7FzEQPUMPVvCzEjd3qbzXiX
 KIYn8VG1QL6jLlebFCCyCggTIcIXQhK2hV33/e+ZumnKw9OkNqgAWYyJtqk8w857oc3V
 O3nD1WnYfabSWEibGiFoxJN0a5iDcTVm5rgBtppLEBhE00VxxU83R2BS3LYj1mteWdnl
 TU1tXgRymQGEStQ8FGOW/fk1StyJvTy4jSL23ox9KHBGCc4XbZrWYiA0q+uotlbaUdTn
 jHqik2CLB4DJ4oFbBRiBkwSIjQ5siZ03GBUCmTLcQK8gr0KE08Asx4mILITLEJzVdajO
 wVsA==
X-Gm-Message-State: AOJu0YwT3KDzqGHvKDvDWKY2xglTjsWIuLMHklCJ2Ljq0z4PoxC68dLv
 zdrbcJfqn7nhLSg3mZCPTXExsJ8VFxN/Ln1qeEcrp7n18FaMJFe0Ga+koyDtLIEKUPY=
X-Gm-Gg: AfdE7cn4rDvEEizC1xxbXx2z703tlRVtHaaYWtLCldWDkIgo5lbJSes4sCQ3cR0twJG
 EK6hvfWcWXDjEd5djderksR8eBA/4LySxVsl2jfVJkV3F5Po3TKuU2mtB4zmkOEMPfKd38yJJYy
 jqbywtkN159czt09i3JnnozlKHqBaOzZkrvObonulNDfQeUsQYzZiRSLQ4OfmtzTSlsg9uKn3pQ
 Tcz/ePm/KqdkenCcvP+CvaQHyMDpwsaJ6XSRma3dFuycpOr/noJPynoedtn38vw46xj+6wVB4A2
 HW+y6hjrDX5RI2tWc6VbWARNbe9BTeZsowk2OtCpxnvoK9d0QAGthzY4CenZnylMni1qMzJS7QT
 JPQJrn1TCn3wFwGgJoT3SFF0LaqQlR5Jo3aNXlFt5prNhXJTsU3ip0lI20bY3QRb2DSJ9lgqWRb
 sbO5tt3gCR687w3KpHIVfTNDvOf9s3An0PjGpJyWRE9my3TmNhak12LzETYTqW1F/pU8hUNKn+F
 1DJxY6VD3UZf7LuqkLWElJtnyp75orzpCBe44mF+B+EwaJX
X-Received: by 2002:a05:6808:19a9:b0:491:3c9a:c486 with SMTP id
 5614622812f47-497e1dcba8bmr484229b6e.27.1783013221400; 
 Thu, 02 Jul 2026 10:27:01 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-497d1af4bfcsm2006668b6e.12.2026.07.02.10.26.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 10:27:00 -0700 (PDT)
Date: Thu, 2 Jul 2026 11:26:56 -0600
From: Tom Rini <trini@konsulko.com>
To: Vincent Jardin <vjardin@free.fr>
Cc: u-boot@lists.denx.de, Alexey Charkov <alchark@gmail.com>,
 Alice Guo <alice.guo@nxp.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Anshul Dalal <anshuld@ti.com>, Bo-Chen Chen <rex-bc.chen@mediatek.com>,
 Brian Sune <briansune@gmail.com>, David Lechner <dlechner@baylibre.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Fabio Estevam <festevam@gmail.com>,
 Heiko Schocher <hs@nabladev.com>, Heiko Stuebner <heiko@sntech.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Julien Masson <jmasson@baylibre.com>,
 Julien Stephan <jstephan@baylibre.com>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Kuan-Wei Chiu <visitorckw@gmail.com>,
 "Lucien.Jheng" <lucienzx159@gmail.com>,
 Macpaul Lin <macpaul.lin@mediatek.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Marek Vasut <marek.vasut@mailbox.org>, Martin Schwan <m.schwan@phytec.de>,
 Mateusz Furdyna <mateusz.furdyna@nokia.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Michal Simek <michal.simek@amd.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Peng Fan <peng.fan@nxp.com>, Peter Robinson <pbrobinson@gmail.com>,
 Philip Molloy <philip.molloy@analog.com>,
 Pieter Van Trappen <pieter.van.trappen@cern.ch>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <ravi@prevas.dk>, Raymond Mao <raymond.mao@riscstar.com>,
 Simon Glass <sjg@chromium.org>, Stefan Roese <stefan.roese@mailbox.org>,
 Stefano Babic <sbabic@nabladev.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Subject: Re: [PATCH v1 0/7] pmbus: PMBus 1.x framework, CLI, regulator and
 thermal support
Message-ID: <20260702172656.GB749385@bill-the-cat>
References: <20260702171618.1773206-1-vjardin@free.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="F4MQ5gXkblnNzW8k"
Content-Disposition: inline
In-Reply-To: <20260702171618.1773206-1-vjardin@free.fr>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Thu, 02 Jul 2026 19:28:51 +0200
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


--F4MQ5gXkblnNzW8k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 02, 2026 at 07:15:44PM +0200, Vincent Jardin wrote:
>=20
> This series adds U-Boot's PMBus 1.x support as a small boot-time
> layer (not a hwmon clone):
>=20
>   - a decoder + transport library and the pmbus CLI command
>   - a shared UCLASS_REGULATOR adapter plus a catch-all driver for
>     compliant chips, add the MPS MPQ8785 per-chip driver
>   - a generic PMBus die-temperature UCLASS_THERMAL bridge
>   - migration of the shared NXP VID rail-trim code to this framework
>   - a sandbox PMBus chip emulator and "ut dm pmbus" unit tests that
>     exercise most subcommand of the CLI.
>=20
> The goal is to identify PMBus regulators at boot, print telemetry and
> decode chip alerts before the kernel takes over - no polling, no
> sysfs, no fan loops. Linux owns the runtime side.
[snip]
>  .../regulator/lltc,ltc3882.yaml               |  91 ++
>  .../regulator/mps,mpq8785.yaml                | 105 +++
>  doc/device-tree-bindings/regulator/pmbus.yaml |  65 ++
>  .../regulator/renesas,isl68233.yaml           | 105 +++

We should be using, and referencing, the unmodified versions of these
files in dts/upstream instead, thanks.

--=20
Tom

--F4MQ5gXkblnNzW8k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCakafWwAKCRAr4qD1Cr/k
Clq1AQC1QJoPc8QqFt1ckfstBzbaQoPbMW4MqgzkiGF+RJmqvAD/QQ+0IHrbD4H5
pJovU8eA6k3u+SngMyIegBuWzQEPTgk=
=co82
-----END PGP SIGNATURE-----

--F4MQ5gXkblnNzW8k--
