Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C12AC43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 12:48:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7FE7084994;
	Thu,  2 Jul 2026 14:48:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZHAs20P0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 820D5849D2; Thu,  2 Jul 2026 12:53:44 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C28B846FD
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 12:53:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-698aa7ba320so945373a12.1
 for <u-boot@lists.denx.de>; Thu, 02 Jul 2026 03:53:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782989622; cv=none;
 d=google.com; s=arc-20260327;
 b=eszILJA2YcIgPCMSyDdXHUsqpeQS9gu7vIIut8jiBbWkNdCzESYbETMByEvgbadg8r
 xf6s2QJjIn51EZce4VryYRmYNiAff4xG7fBUuilvjJkLfMREZS1nd9O/LNfuT1DgDywj
 poNAZ4fm1vRac4FabUl6/jnG2r7Y+Y2uE8zLjvyQnbIRTo06Tu2UO1nh67Arp0K5j/XJ
 gE0gu+XX90nTDfxbi58ZrcMfpEokcAJeobU5pC4PIdFqor6nOxW5lRdP0o6ugg4KalkC
 1KbJsATx48vw3Ljnp2N1lYTfL3AaU6Qkh2MIwCyR+/X0Bn6jcgNI1itusOLTl+ohXMF9
 6heQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=0p5Xq4G20MyhfG+CAHgIpVno9tmHR9FDrhd28Kyolzg=;
 fh=uQ4N0EtOwQT/crSdNA1rWW3AFRz9SsynUfKgDyZlACA=;
 b=HJwDIXPNYAkCVviBLpHz1lhrFZkBhXkbhomY85dA8a3QNhjEW3vMCEMA7r73Qj3S5i
 gRV9PY3BcO+/Es30dWTAJxYDsKg4rCn4L4ACDNCvLaBhL/HrDuT8OXPD0HTqT0k+8DTy
 Leq0QUpNXrW25NAlIlQO5r6tpkm0iMoQRDTN+KEZFAtj0XkT+ViSKmm/nM5KMJsX8vX0
 xb5iHf9W1v0ZqmWIdFYeXLxy9FUpIH2gifeQCxwPcdL69J308zqVGNVp9K8HKXXDuAdW
 KafX6LlYFv9vONF1he3Cwyqr3h+GWwNbgXfQimxdloB5PQGC1YR1r5yb7cIHNvwVz5za
 v71Q==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782989622; x=1783594422; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0p5Xq4G20MyhfG+CAHgIpVno9tmHR9FDrhd28Kyolzg=;
 b=ZHAs20P0rdLbw5etUe2arAtu65AV5rbQ/ACNq2/WJcVstXm7+Z/PTbFKGupgVuD8/3
 TBE7pxLML0y1/aR6QxpLht+2HrmSJxngmQ8dFt9bmzTtv5WKgvAZraJt02MCEFaQGInG
 zxL1v2bNluj89nZNub1kJW0/TSl3uk6iv2Voc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782989622; x=1783594422;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0p5Xq4G20MyhfG+CAHgIpVno9tmHR9FDrhd28Kyolzg=;
 b=QtdPn5uFPwe0DYrE5F4xtFK2NHym+6IoVcf9r7Hi79bX9qcItH1xvJ5bk5fA0R5RpI
 qJKw74Qr6aHS70jwXu6pfpwBb8NPTrjM8R7HSe3Z2X0i88u6JHgK7jnPitVkNxvnKa+e
 M+R7N8IF56yyk6wVhOMk2pzqKwaSl5BUbPwt682EdD0OaFa42EkF0CVhHZvFDKy5Oath
 qjCTVp5wEvF6rOFu8D9zxi7TOECN1IbMQLTOgzTbEU53oQJ2ueqYdOcbx7UToVFhsD8T
 CWu268kpRY5QnF946ckFSp8AEh7b2GSJz2AQD54eFmFCDG7+Ke3QB7VIOQTjod//y9U9
 AC1g==
X-Forwarded-Encrypted: i=1;
 AHgh+RrVv14gjgN03mKtG49/fw5ncLX0Re7vn2IonP63kU9s1NnETs/+gKgJvRFUyMkSxbf+b6koCwY=@lists.denx.de
X-Gm-Message-State: AOJu0Yw+eqnR7Gjvt8qc0ayO/us6iuGHhVPg+iULRpHIHawJMiOtqLWR
 YQW4ihq+YJH2Z53HQn5NQIw75yd6JtPy5jeGzuERtLpLt0ACGDNXh4yNNkRtt/vtvcJgsYOBvKW
 NHM4gBinyEwcxltQxqAGDMLngJEefPr15AsJeQGdr
X-Gm-Gg: AfdE7clqrcb/NkaXAu2XB6//FGcZVo+yVzzdyLxDw0e4vbYWUHq8rtpd2Hp7Mob+zSh
 exiayH8zJADneBIUxE4As1SABomhEqWqZMzqTQuMuJ7NDg1tqE8Fh3kXSVdBapCiNeExCEe/nXt
 hi22FXHBuQIVGZBkDfzDF3/xgXIUxJK9cTi3YW0qSq1KTT+qSkrEia9n+NBfzkvEwnVQKN9t5bf
 Upp5yEYMlAjt9mWTBb+4HkydJh6mm9hZqSPhiRqxHnYSfMrALH4WNxJIHS2nkY69vV8MURg7Q==
X-Received: by 2002:a05:6402:3709:b0:697:fbe7:2028 with SMTP id
 4fb4d7f45d1cf-6989f16a5f4mr2461086a12.13.1782989622007; Thu, 02 Jul 2026
 03:53:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260702055744.2164975-1-mikhail.kshevetskiy@iopsys.eu>
 <20260702055744.2164975-4-mikhail.kshevetskiy@iopsys.eu>
In-Reply-To: <20260702055744.2164975-4-mikhail.kshevetskiy@iopsys.eu>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 2 Jul 2026 11:53:15 +0100
X-Gm-Features: AVVi8CeLBAKWKQx1A4wngDw4RAh8iF4qczQd_Cdu1m-M6hqPS9Hl0TzlmdK7WS8
Message-ID: <CAFLszTjiKwQnMUZTExsZyD65vOqYcrvVCihexPmLEEAo+N-Ndw@mail.gmail.com>
Subject: Re: [PATCH v14 03/18] bitfield: Add non-constant field_{prep,
 get}() helpers
To: mikhail.kshevetskiy@iopsys.eu
Cc: Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Christian Marangi <ansuelsmth@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>,
 Jerome Forissier <jerome.forissier@arm.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, Simon Glass <sjg@chromium.org>, 
 David Lechner <dlechner@baylibre.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Richard Genoud <richard.genoud@bootlin.com>,
 Andre Przywara <andre.przywara@arm.com>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Sean Anderson <sean.anderson@linux.dev>, Yao Zi <me@ziyao.cc>, 
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, u-boot@lists.denx.de, 
 Markus Gothe <markus.gothe@genexis.eu>, 
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>,
 Benjamin Larsson <benjamin.larsson@genexis.eu>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Crt Mori <cmo@melexis.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 02 Jul 2026 14:48:57 +0200
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

On 2026-07-02T05:57:27, Mikhail Kshevetskiy
<mikhail.kshevetskiy@iopsys.eu> wrote:
> bitfield: Add non-constant field_{prep, get}() helpers
>
> The existing FIELD_{GET,PREP}() macros are limited to compile-time
> constants.  However, it is very common to prepare or extract bitfield
> elements where the bitfield mask is not a compile-time constant.
>
> To avoid this limitation, the AT91 clock driver and several other
> drivers already have their own non-const field_{prep,get}() macros.
> Make them available for general use by adding them to
> <linux/bitfield.h>, and improve them slightly:
>   1. Avoid evaluating macro parameters more than once,
>   2. Replace "ffs() - 1" by __ffs(),
>   3. Support 64-bit use on 32-bit architectures,
>   4. Wire field_{get,prep}() to FIELD_{GET,PREP}() when mask is
>      actually constant.
>
> This is deliberately not merged into the existing FIELD_{GET,PREP}()
> macros, as people expressed the desire to keep stricter variants for
> increased safety, or for performance critical paths.
>
> Yury: use __mask within new macros.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Acked-by: Crt Mori <cmo@melexis.com>
> Acked-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> Acked-by: Richard Genoud <richard.genoud@bootlin.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Reviewed-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
> Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
> Reviewed-by: David Lechner <dlechner@baylibre.com>
>
> include/linux/bitfield.h | 59 +++++++++++++++++++++++++++++++++++++++++++=
+++++
>  1 file changed, 59 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
