Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98589CCA470
	for <u-boot@archiver.kernel.org>; Tue,  7 Oct 2025 17:58:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1AF283858;
	Tue,  7 Oct 2025 19:58:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="R7Z5hVY7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EBCB7838AA; Tue,  7 Oct 2025 19:58:55 +0200 (CEST)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0A1583837
 for <u-boot@lists.denx.de>; Tue,  7 Oct 2025 19:58:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7b00927607eso4320524a34.0
 for <u-boot@lists.denx.de>; Tue, 07 Oct 2025 10:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759859932; x=1760464732; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=nxtqpHs4DjnmHtZ484EuBQ3PS0gm++cuAMVaGIYJlQQ=;
 b=R7Z5hVY77UzXsmmqny30yO69pn65BdTrB7McvYTTP7Ppc/wby12EQyPSy1wrCnpfcO
 lG9jRSdkd80TbeuUs/jldZ4l7eWc8xHgocDk6nMKODD7UiKBlXfCpUVAZiF7ScrJBjGc
 QcFes34D+md+Q/w9cQXZnwL8Yqixlvf+Fl2ns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759859932; x=1760464732;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nxtqpHs4DjnmHtZ484EuBQ3PS0gm++cuAMVaGIYJlQQ=;
 b=opbMcwy3XPSh1Yk+MDY1RAZL1vvlTC5Z+yyoHNckbo9AJky3d9QfsbMo+9tg8928oG
 p3Y9hVihQL+kYlhwoOOGM70EE4rARm4G6gjX1W9G6OwDiQCq8Rx32IUrNVhoBhNqHj6f
 8BbegmDFoYYfp15hfHESxQT4PEOlqUTyvJwSxferSHPSKso679sIK8Mf67fr6TQVEZ92
 MUwzFgftodW0SPMg182GMKJP7sPoLGTY6w6b9uO7FpAFx/hqUhsrEo3CMZxYL85qo5Q0
 vLaR+vgOvDB29d6FtM/OklCA8Ei2KsOrKcd+WIyFSOVRSRb+/oN91DWCvP6CFt3xuwbF
 T0gg==
X-Gm-Message-State: AOJu0YwkxdTGO2jUVm/BhWwavSDKIJDv5pFGxw2jUuZqaS46MsjVZFvq
 VGFXTLWGdl4gC+Q8Kf2+OvNnL4yV9NTnV3Ncppo6mOv7+nVls4jFMhcHb6leEl/TL1jUO1++Xui
 YFIwK/8w=
X-Gm-Gg: ASbGncttlcl4vzWCsZ4yUZltueV1ymRbotDIbg75AIMomNOrbXpuJc/9e2R2ty6IdhS
 68ozyDy5tdVRO/5QF5OoQEVM2qe3lK6TYOSejiz4C3U0m4oLJiCDgFsL07eI3vaaiju78jU3vsQ
 shOdBFH8uSBEgASTy52iC8lv42n+7PM5nIDXlT29tLGni6LXTBHJRTm1855iQ2q74tsnHf9y6Uc
 OtyOaXlHqaWwHDADJbqhlAqmo8NvnJa/IxBF5ybJCDwvO8sPAv5pv+1Kh90bX4YBkgpXZSbn2t4
 nk/iXKMrWk9F4IQkGOIdwvRJQw6wl1g4Gl6/Vbi2KJbyiK2/92Zlu1HeNC+T9c7lwPDPbbqxcIx
 DuVYWEyJEg0FVKEDP0tjiAaict5RX2MzDRTi48uErgWK2wuNzElAkRKmfIJbEZ/w4IG7K/WI+7N
 dyB+jv9vPo8yTKVu+FRFgq
X-Google-Smtp-Source: AGHT+IHcalI3PIIPqXBhBKwTHfCtH5G6GnHxglI7hORzhq5MAENXpr9DCfhlRqWgS2yTc3Hn/wCByw==
X-Received: by 2002:a05:6830:6017:b0:745:4823:df18 with SMTP id
 46e09a7af769-7c0df7d9f88mr382536a34.28.1759859932056; 
 Tue, 07 Oct 2025 10:58:52 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7bf3f6102f2sm5051630a34.6.2025.10.07.10.58.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Oct 2025 10:58:51 -0700 (PDT)
Date: Tue, 7 Oct 2025 11:58:49 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Subject: Re: [PATCH v2 06/17] boot: Add a new test for global bootmeths
Message-ID: <20251007175849.GN298503@bill-the-cat>
References: <20251001212649.3263574-1-sjg@chromium.org>
 <20251001212649.3263574-7-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="TPKVOiBHIDRWJm4k"
Content-Disposition: inline
In-Reply-To: <20251001212649.3263574-7-sjg@chromium.org>
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


--TPKVOiBHIDRWJm4k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 01, 2025 at 03:26:31PM -0600, Simon Glass wrote:

> These have different behaviour from normal bootmeths and we are about to
> enhance it. So add a test and also an extra check in bootflow_iter()
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
[snip]
> @@ -388,6 +390,49 @@ static int bootflow_iter(struct unit_test_state *uts)
>  BOOTSTD_TEST(bootflow_iter, UTF_DM | UTF_SCAN_FDT | UTF_CONSOLE);
> =20
>  #if defined(CONFIG_SANDBOX) && defined(CONFIG_BOOTMETH_GLOBAL)
> +
> +/* Check iterating through available bootflows to test global bootmeths =
*/
> +static int bootflow_iter_glob(struct unit_test_state *uts)
> +{
> +	struct bootflow_iter iter;
> +	struct bootflow bflow;
> +
> +	bootstd_clear_glob();
> +
> +	/* we should get the global bootmeth initially */
> +	ut_asserteq(-EINVAL,
> +		    bootflow_scan_first(NULL, NULL, &iter, BOOTFLOWIF_ALL |
> +					BOOTFLOWIF_SHOW, &bflow));
> +	bootflow_show(0, &bflow, true);

Here is the one call of bootflow_show outside of where show_bootflow is
called today, and bootflow_show is called by the end of this series.

> +	ut_asserteq(3, iter.num_methods);
> +	ut_assert(iter.doing_global);
> +	ut_asserteq(2, iter.first_glob_method);
> +
> +	ut_asserteq(2, iter.cur_method);
> +	ut_asserteq(0, iter.part);
> +	ut_asserteq(0, iter.max_part);
> +	ut_asserteq_str("firmware0", iter.method->name);
> +	ut_asserteq(0, bflow.err);
> +	bootflow_free(&bflow);
> +
> +	/* next we should get the first non-global bootmeth */
> +	ut_asserteq(-EPROTONOSUPPORT, bootflow_scan_next(&iter, &bflow));
> +
> +	/* at this point the global bootmeths are stranded above num_methods */
> +	ut_asserteq(2, iter.num_methods);
> +	ut_asserteq(2, iter.first_glob_method);
> +	ut_assert(!iter.doing_global);
> +
> +	ut_asserteq(0, iter.cur_method);
> +	ut_asserteq(0, iter.part);
> +	ut_asserteq(0, iter.max_part);
> +	ut_asserteq_str("extlinux", iter.method->name);
> +	ut_asserteq(0, bflow.err);

Nothing in the rest of this test is checking the output of strings, and
nor should it since the test is checking the struct itself to be as
expected. Am I missing something? If not, I don't think we should bother
with the previous patch.

--=20
Tom

--TPKVOiBHIDRWJm4k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaOVU1QAKCRAr4qD1Cr/k
CopoAPoCiY14gLd+WdXBmqd82hY9AXhe100M5Jp+qB9hEWVnQAD/ZTZtV3JZzsIy
znkuzCsAmPsRS89Pbi7pfsjYhFmUIAU=
=dxFc
-----END PGP SIGNATURE-----

--TPKVOiBHIDRWJm4k--
