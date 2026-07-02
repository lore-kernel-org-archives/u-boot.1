Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D916C43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 10:53:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC34984975;
	Thu,  2 Jul 2026 12:53:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DIdXqYw6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B822584987; Thu,  2 Jul 2026 12:53:24 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71A7D846FD
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 12:53:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-697cee2eb6dso1560117a12.0
 for <u-boot@lists.denx.de>; Thu, 02 Jul 2026 03:53:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782989602; cv=none;
 d=google.com; s=arc-20260327;
 b=G0y1nnLE/VBgmQ9fyBLqP9yk0iEGnLdlr7EWPUkIL575YMRoOyTrws+p0xkFH017mk
 0CtsCEjzNdxPS6Bcn65Y97bu8qRxCo/acc6TjOAOM8WouDDOlFXu5ZMq7ptmkM9ojh39
 BOLTPcTXYKu6d7FPtLhgcelrvI4IsWH+JPfovyFJfrNBoAnpCeqkMW7uIbv5j4w5+Mez
 19y0SZBm5ScyQoQQItqnUSntOo5bD8mObmcsKkWWzjwbmuWTFbzAHsJyGdNytggbOYfJ
 ATzcRdyW7tl6TQxMIpce2JTeC5v4cJ3lSW8c3eJxsTtrv7DVti3/8IYvF8sLsjkTC4P1
 WM9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=W7XL8mOwgF35A9Ria9khPFZNhtNFH8PfCnphuN5HxO0=;
 fh=GrsTyR8LMRYViDHb/OPOCbOSfTAuGGCHFd0zTJZB9sE=;
 b=BnNY9rBDwQGiCKXyEM/9dnM8eGyeqbbcLKLkXbaTOor2e5k4Bbc+kF0Uh/pCs3Jy9E
 bKky/6wxx00rw02eJhlbYEFtL4srfPBkNKgFt7cdQSh8EDl2B1uCT86abJStr2oKxTHI
 N/1N4dxM83Yvfb4XLFa5mBvQP4Wl6O5N33u044HcvSvYkl9sjczGaq85IFxcPDU7H8aU
 tP1qRmoOeGZvbZwJ1tCs4gepctJwC1jR8ThEamnzrjLW9t7XTdIfOKb/3nGCiSp0dK46
 JF+hF6B6XNhavKWeG/QZfd9YVK4XwyYaG+5F0cPgfaaD0hKjT6QlKa1Z1E49ECGoMsXA
 GdTw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782989602; x=1783594402; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=W7XL8mOwgF35A9Ria9khPFZNhtNFH8PfCnphuN5HxO0=;
 b=DIdXqYw623ttEBUmpHe9bLKbbR0CIcbXvEd1HuJW7L2i6xtGPn5a+abebO1fN9z2fE
 N05o2qR/knrg9OqF79FUIFV6QAEbmrMQ9gIblytCwTD/A/44ogyots/9WEMfIwzbPgaA
 Qgv5swmU0IGD9UWDD/kFTzCD3mqU+BJSzDaak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782989602; x=1783594402;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=W7XL8mOwgF35A9Ria9khPFZNhtNFH8PfCnphuN5HxO0=;
 b=qbdkpIp1akHZ33A2OMxTIWo7XkIuRHsYn3lWZu4hcXMvpOIE+Nj1LaTao+CvP12qhp
 UDHFfiHe3U+uqhiBF8h0GC1W7Apeq3fZgUtWBLZM6SAvCxV2lOxWcH3/mrV+3dJGuaar
 62bdATsmxoqT4rLLyIV2dgcNyENbWESHLax2Rg1bxeuwWlnTcdfyWt9OewdepFfmC6ph
 Kjr9P25gs/c3JHfvMnjKcJn9X3qp0xG0vCQuZLiZJEoAqI44c1dqTOSGwFFnue9xWnSg
 dUpBbfjEZSCn0yEA2X+g3/6nh23CmIK4E9/ILFlTR81zttzYp0j5eHVS1YXkkQbQdL/A
 5KvQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp3vRsT0tA5NBFLjPOSs0gcuW6MRNa/6jhOkSxsM3Df2OkcLYhk1nuq1W3Cf0oPm1Xi4FNs3T0=@lists.denx.de
X-Gm-Message-State: AOJu0YyR0/ndrLTMev2/u869BHlHWWXj+A/mHfewIGZBb/DAFO59qfzQ
 JDzT33RBNtJvSaQ8lr12AxL23pOQ/UFVqB38RpRnWGXmIZiY/H4d9r6c6sKODLZQ3bZvVMEo83L
 fiSxsa2gwjW1v4o2cKaCt6MtQ+sT++qgzNhaaXtXN
X-Gm-Gg: AfdE7cl/aNurs9yidV6Y0w6ibAWbZWaoXadRpZ/7XOqQRlbpvCJD5FiIBIpGTvNPhCF
 z+z9RAxemi6zZVBRalMOp8ZNFLBVFUSNtgYk7m0sHmBwskPkwP8scNq6UZGz1rMqvPzUt3j3yhR
 yIl1eARb2D/XniiR85aegvIqI2W0lfX0fX1uCm7F5DBW/rQp/QTnt+csi7e/pbAt8bUjXwunr8G
 D4JbOOgm49/QSznTQpR3uCDq73urjT66wsmRMyxKjD9LtV1WFGNSxfN5hmAW13GjATZJ5mLCQ==
X-Received: by 2002:a05:6402:42c6:b0:695:f580:a66f with SMTP id
 4fb4d7f45d1cf-698a2cda40dmr2154759a12.21.1782989601868; Thu, 02 Jul 2026
 03:53:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260702055744.2164975-1-mikhail.kshevetskiy@iopsys.eu>
 <20260702055744.2164975-3-mikhail.kshevetskiy@iopsys.eu>
In-Reply-To: <20260702055744.2164975-3-mikhail.kshevetskiy@iopsys.eu>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 2 Jul 2026 11:53:05 +0100
X-Gm-Features: AVVi8Cd19Q3Z2PWgN-FatFedmgD5px5esrqxeewDC5Xn0e4TXdBCWB8KN1PkqKY
Message-ID: <CAFLszTg4ZuiEdQkfTZcomtcWxSN+f1CKvE+Hikk+EHWghPaKYg@mail.gmail.com>
Subject: Re: [PATCH v14 02/18] bitfield: Add less-checking __FIELD_{GET,
 PREP}()
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
 Benjamin Larsson <benjamin.larsson@genexis.eu>
Content-Type: text/plain; charset="UTF-8"
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

Hi Mikhail,

On 2026-07-02T05:57:27, Mikhail Kshevetskiy
<mikhail.kshevetskiy@iopsys.eu> wrote:
> bitfield: Add less-checking __FIELD_{GET,PREP}()
>
> The BUILD_BUG_ON_MSG() check against '~0ull' works only with "unsigned
> (long) long" _mask types.  For constant masks, that condition is usually
> met, as GENMASK() yields an UL value.  The few places where the
> constant mask is stored in an intermediate variable were fixed by
> changing the variable type to u64 (see e.g. [1] and [2]).
>
> However, for non-constant masks, smaller unsigned types should be valid,
> too, but currently lead to "result of comparison of constant
> 18446744073709551615 with expression of type ... is always
> false"-warnings with clang and W=1.
>
> Hence refactor the __BF_FIELD_CHECK() helper, and factor out
> __FIELD_{GET,PREP}().  The later lack the single problematic check, but
> are otherwise identical to FIELD_{GET,PREP}(), and are intended to be
> used in the fully non-const variants later.
>
> [1] commit 5c667d5a5a3ec166 ("clk: sp7021: Adjust width of _m in
>     HWM_FIELD_PREP()")
> [...]
>
> include/linux/bitfield.h | 36 ++++++++++++++++++++++++++++--------
>  1 file changed, 28 insertions(+), 8 deletions(-)

> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Link: https://git.kernel.org/torvalds/c/5c667d5a5a3ec166 [1]
> Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
> Reviewed-by: David Lechner <dlechner@baylibre.com>

Reviewed-by: Simon Glass <sjg@chromium.org>

Please can you add your own Signed-off-by at the end of the chain?

It's a bit confusing that you seem to refer to Linux commit hashes in
the commit. So maybe this should have a Cherry-picked-from: line
indicating it came from Linux?

Regards,
Simon
