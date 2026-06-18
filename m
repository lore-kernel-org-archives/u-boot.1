Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42323CD98F2
	for <u-boot@archiver.kernel.org>; Thu, 18 Jun 2026 13:09:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97429847C3;
	Thu, 18 Jun 2026 15:09:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jTPHxRCf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C13918460E; Thu, 18 Jun 2026 15:09:31 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DBED28499C
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 15:09:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-695f5ae95e1so878544a12.2
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 06:09:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781788169; cv=none;
 d=google.com; s=arc-20240605;
 b=IK7Pdon3zYAz/3Ifo6eZnCnprMmTrQUZhalqhpHIrUMGIZSF42awBD/48X9mswxcaV
 HgaWaw8hqEpOJb5vPkn547Ne2YkBI8DR9AwIc0Qcro8P7lNzIP00CrSHR9rttwaXS6sF
 reVQBF1cbdC/XRoF68FtJnp63ZCmD05yuevN4nRtM0Q814tyireJn+mTvqAIF0mTVIa3
 PWU+iiKKgxK+dQ+Ov4TReBINshaApmV/tDCp2kZXIUbxAPkxotYLvxocclRG9FpDu8HY
 Tpjctr2PnIFsKwPMfdhV1Yt3jB4sN0wNgXoqqL/ljFDSm8jIsvEJrts8A4hTFjAHyTle
 zLuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=yeXsTXHyzB6MJAjHSvl1Akab/5DUxmC5B5ciCPITkok=;
 fh=6ILcjaCPxFU0o2uokYJ+boEjPeGZWg073HPUeaVo6z8=;
 b=BapDt4ScenVoGbE9uwNyjpGuo2HoChht37CTXPZVgxvWjVXMwfCcUFtjM9kPi+Q8BB
 xib2Q+DOwGHOeGt72xIxE1KxAE8ukJRrgz8pIzGknWDp5vB01uW2ObH8DzOpbntkTmrL
 u8T3oz0zCn3AtLoQcYCxa/pItaCgrN0YEy0TIAhxQZOR23mKZquCjz5d5fGbQnlMypm2
 XAPZuYT83uSYX+/rEyidSGfjPYsgRBT/RdPmh1AwTigoz1cYYD8C/Hk5sZrPhoHPt8wn
 NUodjxZgJUaXLH7t3bdBmauSW/MzrUKMgcBB9yr2W1Oc1yvagf8AMFZK9SVPPfAmZcrv
 YMJA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1781788169; x=1782392969; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yeXsTXHyzB6MJAjHSvl1Akab/5DUxmC5B5ciCPITkok=;
 b=jTPHxRCfSkkuuIBkw1flvusiG04xj7P7V1DS0ExM+5UPaxienYZTY+a9XVWDbTBqXK
 IbN88lq9eTDXkN1UfdSeUAq2MJ9o3MmbkKa2V8rfpflYs81cTi3KRcZfk+RNm/qtishQ
 4MQ1MW/na0lxRRyueL1lCHokn+52Y33I934G0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781788169; x=1782392969;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yeXsTXHyzB6MJAjHSvl1Akab/5DUxmC5B5ciCPITkok=;
 b=FU9gCjF7Bm+eieqjojKgexs/mXFyuiBO/2+x7Aq+GmBdXf6R7XzBDPCkEVunokxpdo
 koRSzwyf4gh2XSUG4jnonzuNUjSAIN85FJa52MHBd4d5SbT0EOeeKWTtZ7oEepZ0QulV
 hGT9SI3FfDXf5FUDAZWDcHCyYQf835TtPjrhOHS8K1UPiM7Eo7/0vE1yQaZlpT3p7S12
 19gz1IJlkQ/6ONlOukHH2CmA7isyPcK8sE8p8m2kHOE1jWs9qd6Xuy1FMyVWry8qKTZO
 D0ym1EE251kk3C1JOMKiAihVnK/xMBxA8DdUV/KnDgzI9cInkz4KZvB3Uh4ix5AXBTwK
 Af/Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ9FzMqk4vMp83MmEIIWBbIGpaOek1wPOXQPTpavK5EpwHKBDibv1PXU8O1saa6DXUVRR3Ih7Co=@lists.denx.de
X-Gm-Message-State: AOJu0Yxn/3wbTkVxTxS7Y4y9XVMCiM8eOVu50Prg8UkrfFztxJMFr2xm
 Y835BoFUC/diCI1WTSD4GKlGVylXRwtykZ4mLG89zn0zfJGNwqmeuG8I8mvOm7lO95t94gpevH3
 lNwXXmpdwepTsSQd9k5Pj6TwPKQU5ZXZlHKvyr4jD
X-Gm-Gg: AfdE7clztgvLVVVTlpK7VnYM8b9dUtlfpD5XuN9rusDIiZ0FUh98nY8amMRTks82tFO
 TjgGax23NophzcJMcCKwR8BaQyBnAcq1cgHZwdbqwcqN3YDmljKvLvQ75VXcv6Qzp9UOR1Ampkj
 LS5zQlpAvakjzVRB0yEeRg1xJ5tFVtLuWON5+26FJSn095Sr4BgS/mtXlBcUvSB6x5EsUfc1s9f
 FK6Z/5aFWYZQAvR1QlplL0KfV3M7zNrtROEx4sv7NaHGmQ5SNrR92gQiIyDftiMavenjT4mtQ==
X-Received: by 2002:a05:6402:280e:b0:687:3580:fc26 with SMTP id
 4fb4d7f45d1cf-695476e2faemr4746802a12.13.1781788169365; Thu, 18 Jun 2026
 06:09:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260601134310.2452454-1-philippe.reynes@softathome.com>
 <20260601134310.2452454-7-philippe.reynes@softathome.com>
 <CAFLszTjx=CJxjp-ji+n2MF2znfeN5zPQhTO1TnBhLE3J_WMRpw@mail.gmail.com>
 <01441137-deb3-4322-b5b3-b27ebc63f351@softathome.com>
In-Reply-To: <01441137-deb3-4322-b5b3-b27ebc63f351@softathome.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 18 Jun 2026 14:09:13 +0100
X-Gm-Features: AVVi8CccSN2hp6U9rsI3pkFBG8-CWh0_D3Xsa0puqcKpyekRCtIK7lPAjYUJ0T4
Message-ID: <CAFLszTgct63tEGccK=W=rXK31dNcC=50upi-X0uVsDCHvs14-A@mail.gmail.com>
Subject: Re: [PATCH v8 06/15] test: dm: ecdsa.c: clean this test as software
 ecdsa is now implemented
To: Philippe Reynes <philippe.reynes@softathome.com>
Cc: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com, 
 trini@konsulko.com, simon.glass@canonical.com, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Philippe,

On Thu, 18 Jun 2026 at 12:02, Philippe Reynes
<philippe.reynes@softathome.com> wrote:
>
> Hi Simon,
>
> Le 12/06/2026 =C3=A0 20:32, Simon Glass a =C3=A9crit :
> > This Mail comes from Outside of SoftAtHome: Do not answer, click links =
or open attachments unless you recognize the sender and know the content is=
 safe.
> >
> > Hi Philippe,
> >
> > On 2026-06-01T13:42:58, Philippe Reynes <philippe.reynes@softathome.com=
> wrote:
> >> test: dm: ecdsa.c: clean this test as software ecdsa is now implemente=
d
> >>
> >> The test ecdsa was done when ecdsa was only supported by hardware.
> >> So it wasn't possible to test ecdsa on sandbox, and there is a test
> >> to check that ecdsa is not supported on sandbox.
> >> Now, there is a software implementation of ecdsa. So we add a test
> >> to verify that ecdsa_verify may be used on sandbox.
> >>
> >> Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
> >> Reviewed-by: Raymond Mao <raymondmaoca@gmail.com>
> >>
> >> test/dm/ecdsa.c | 107 ++++++++++++++++++++++++++++++++++++++++++++++++=
++------
> >>   1 file changed, 97 insertions(+), 10 deletions(-)
> > Reviewed-by: Simon Glass <sjg@chromium.org>
> >
> > with nits below
>
> Thanks a lot for this feedback.
> Do you prefer that I send a v9 or is this v8 acceptable please ?

Yes v8 is fine, these are just nits in case you do re-issue for some
other reason.

Regards,
Simon
