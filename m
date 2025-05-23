Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D688FC54ED0
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 16:58:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7CF0B835A2;
	Fri, 23 May 2025 18:56:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LkpZ5mot";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F1C0832D8; Fri, 23 May 2025 18:49:17 +0200 (CEST)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4019583278
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 18:49:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-72c13802133so10631a34.3
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 09:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748018954; x=1748623754; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=8GgH3x17b+kfVmY23exqp8fJeXKC/0dpH+n6CnviikA=;
 b=LkpZ5motqlz3jLhE8TbmoUKzyArn56BeWrIjkz5wd1Orsvlwdiv2fAFHecw1gJ1FaW
 Ff/ZF/Vb8i54fW/8az2bpMs8zsk5vsCxXiy2XbMrmYbx/E5awZFhHccNO6+vaErpStea
 Jw4AnsB6XlEqImam4apWdSKOAh3N+Nd4JcfII=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748018954; x=1748623754;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8GgH3x17b+kfVmY23exqp8fJeXKC/0dpH+n6CnviikA=;
 b=ZFjUUL5askdUrxqtW0vNx1TQ9BwheewBI7h1X89hf5Ae0zTO90CC+mQwSD0t/C3Fii
 uaaJAWKWoRTXOjEbHEFrEnwBDLyHXvLA/UeXOw7JqSSJ3qqd6P6YQhorn7wejalA4W/5
 +iLql67C3d976h4aDoI8jaoz1sKhg7Gdr7vHVc/XU1EebHj6Igegk7qt689LGfvGsRRk
 0DzcgPh5L5+/gpDdYNfkFGWCHS9p5vV64TeNj7ESgscjBlMMvFC1RTb3Wjg4KjBnBD0A
 gpSwDN08jlrftT870SQQ3D/ftJHo8OPlRVulP/z1LX8xDRZD/La2Gr3uHSrh2/6hyM8G
 EnIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmCk4qe/q5TseFuCYSH16If9hz8dh1Wl9XA8uHF8xiAkXYl8sqzxaZ6CE7mcRGrvX3pTo1BpQ=@lists.denx.de
X-Gm-Message-State: AOJu0YwCEoEgMIls1shyzFJvGyq+WKqI7W9bFKafdmF5XLiKQo5BOVDS
 T7ZdXGYkOpDkVDccS4RQg2HAbpeDVsLCyyjXySoGdleZDhQJkj1JoxM/eBN2C2x3j5M=
X-Gm-Gg: ASbGncuAekek17XgZdNC1QbB5LXEZUM2cKnyjq+U16mX+YNSU3uibsCVEnqXEQamC/S
 aFl7IsuKKlrID8R5JdMPvGTeeflwD7+FL3gEkQFJRdwXaMhW9DjJa/UQVunfdzlZCRR7c278NR8
 BQpZWD3jnNhJl83DySzZGJvZImWJQy/zb+OeVCyP1pR2j4+umJsTeA9jZa6nujhHeCB5V1vD6Wf
 QN/wWPO2Vm0oqY2y/JopMDobNk853vIqPMAGfvXvSYNsgcOuk3pemwSpTm92wg5rAy2/iRrve6Z
 sHAh3qzmGceKFHXnGAVg4n+WU240SFH9ywQQDEUAs60kb9VnZrZ6FrpeOuReFS6j3mU80V8urK5
 d53+P+YPwQESr
X-Google-Smtp-Source: AGHT+IGU/DGUrI+EhaqI+SUK4NIdKAFtdqSFo/PHNqaOv0CECnufKJz4VdJxnPvSXMwvhdCeJEDRaA==
X-Received: by 2002:a05:6830:2588:b0:72b:89ca:5120 with SMTP id
 46e09a7af769-7355d0708e8mr222123a34.8.1748018953869; 
 Fri, 23 May 2025 09:49:13 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-734f6b60081sm2914331a34.56.2025.05.23.09.49.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 May 2025 09:49:13 -0700 (PDT)
Date: Fri, 23 May 2025 10:49:09 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Adriano Cordova <adrianox@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Christian =?utf-8?Q?Kohlschu=CC=88tter?= <christian@kohlschutter.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Eddie James <eajames@linux.ibm.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Hiago De Franco <hiago.franco@toradex.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Janis Danisevskis <jdanisevskis@aurora.tech>, Janne Grunau <j@jannau.net>,
 Jeremy Compostella <jeremy.compostella@intel.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Maks Mishin <maks.mishinfz@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Marek Vasut <marex@denx.de>, Matthew Garrett <mgarrett@aurora.tech>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michal Simek <michal.simek@amd.com>, Moritz Fischer <moritzf@google.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Pawel Kochanowski <pkochanowski@sii.pl>,
 Peter Robinson <pbrobinson@gmail.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Raymond Mao <raymond.mao@linaro.org>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tim Harvey <tharvey@gateworks.com>,
 Vincent =?iso-8859-1?Q?Stehl=E9?= <vincent.stehle@arm.com>,
 Weijie Gao <weijie.gao@mediatek.com>, Yao Zi <ziyao@disroot.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH 00/10] efi: Move some efi-loader code into a new shared dir
Message-ID: <20250523164909.GV100073@bill-the-cat>
References: <20250523130651.1329593-1-sjg@chromium.org>
 <3b23fc9d-345f-4945-b89d-153a18f5828d@gmx.de>
 <CAFLszTjofbRtjXxfR6MmnHP0hYcpg+pgLKLYDXN2KxLZ2rNPHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="wtOWNM/bP126BM3U"
Content-Disposition: inline
In-Reply-To: <CAFLszTjofbRtjXxfR6MmnHP0hYcpg+pgLKLYDXN2KxLZ2rNPHQ@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Fri, 23 May 2025 18:56:12 +0200
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


--wtOWNM/bP126BM3U
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 23, 2025 at 05:36:52PM +0100, Simon Glass wrote:
> Hi Heinrich,
>=20
> On Fri, May 23, 2025, 15:19 Heinrich Schuchardt <xypron.glpk@gmx.de> wrot=
e:
> >
> > On 23.05.25 15:06, Simon Glass wrote:
> > > Some functions provided in lib/efi_loader are actually useful for the
> > > app as well. This series refactors the Kconfig and directories a litt=
le
> > > so that code is easier to share.
> > >
> > > As a starting point, it moves some filename and device-path functions=
 to
> > > the new directory.
> > >
> > > The next step would be to move device-path code over, but this will n=
eed
> > > some discussion.
> >
> > Hello Simon,
> >
> > Overall the ideas in this series look fine to me. But this series does
> > not apply to origin/next.
> >
> > Applying: efi_loader: Separate device path into its own header
> > Patch failed at 0001 efi_loader: Separate device path into its own head=
er
> > error: patch failed: cmd/efidebug.c:8
> > error: cmd/efidebug.c: patch does not apply
> > error: patch failed: include/efi_loader.h:967
> > error: include/efi_loader.h: patch does not apply
> > error: patch failed: lib/efi_loader/efi_bootmgr.c:12
> > error: lib/efi_loader/efi_bootmgr.c: patch does not apply
> > error: patch failed: lib/efi_loader/efi_device_path.c:10
> > error: lib/efi_loader/efi_device_path.c: patch does not apply
> > error: patch failed: lib/efi_loader/efi_helper.c:6
> > error: lib/efi_loader/efi_helper.c: patch does not apply
> >
> > Please, resend the series based on origin/next.
> >
> > Patches that are not based on upstream U-Boot cannot be reviewed via
> > this mailing list.
>=20
> The app is quite behind in Tom's tree due to rejected series.

It was not "Rejected", it was "Changes Requested", please stop
mis-representing things.

> In fact
> the app is pretty limited on x86 and there is no Arm app at all.
>=20
> My current plan is to move forward and eventually Tom might take it
> via a pull request.
>=20
> Do you have any other ideas?
>=20
> Perhaps this is something we could put on the agenda for a future call.

There's nothing to discuss in a future call as step one is "post patches
against mainline".

--=20
Tom

--wtOWNM/bP126BM3U
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgwpwUACgkQFHw5/5Y0
tyxa/gv/clIEoU6CZbHKjUIVDPgJz2aFlNhDyXmu779p4fyncvMndNRki7CgoM4C
VZHVk9M47rMkmKFu4dOEnBpoaM8VMerWnX+sXr/dHkXWlKDMdePbPCR2bcnF+hJb
0VVdo8lUNFnO2crAeU/viXuWDmFCUgY2jjwAFipL2UwqGpaiiMqZ2YLaQQHHucaq
iakhm/SxYrF9e8eWwjOf1ZV9BkUcc6SHVbqohDTZjFqneSSsw3qGCJdF2c4Km2Zs
iD/KLUKvqwAWyDk6eXgU/VOcH940t7LFv6deuqT0il5EPgqLuxefzcq4gFWtsl+j
ZZ7ZppyJ1NpZx9W9t8CvjRolUduaE5QLBF87Yvb2z8JsE4ZekJBFnfpW1Nlus3qU
XUAqALrmm0Uci/SuQHZ6buXWnKprgXDW9yEU3MFQTpYN8y/akyxY0Lvv0Y6QhUwQ
t0nIcT4kneWNmfP2kfNQelcRqsm7KklL01QSyLf0nX/D2sk+Bxbajp/hAd4EerOH
4PAGqHU3
=He5j
-----END PGP SIGNATURE-----

--wtOWNM/bP126BM3U--
