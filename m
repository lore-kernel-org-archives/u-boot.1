Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F02E3FC72AD
	for <u-boot@archiver.kernel.org>; Sun, 22 Mar 2026 13:31:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8346183D71;
	Sun, 22 Mar 2026 14:31:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JoL/rPVF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B5A5805D7; Sun, 22 Mar 2026 14:31:14 +0100 (CET)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D12C840CC
 for <u-boot@lists.denx.de>; Sun, 22 Mar 2026 14:31:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-5a27c329e98so2543847e87.3
 for <u-boot@lists.denx.de>; Sun, 22 Mar 2026 06:31:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774186272; cv=none;
 d=google.com; s=arc-20240605;
 b=GtrBdiJMS6XS8Xf3FprIFZS8X7uxiMZoPl2oC5Gdf9R65t6saInAkY/3ajERnIIgAF
 TuihZidw4g8BqoTwQRCHhQme6QNAE92fJMrUkymYpFMru96apYdz1rMTB95PmjcxJjGx
 Z5s4A/Ju3VSJ3Cn2WiGuFjXZGDaJaOpkMfW9Ers0DEpm/MF2+lyUOQJTYbJ/gj94PT4I
 0LIXkoUnOix6P58ry2kYb6+iq4zfD4sLmbTR9ZNRGQqcNwgPex+mupLeeiwBO4IqWxvt
 Zlyw7ZiROSFI/C6k8Xz5XLa/G3qy8/qSx+G7l3EW+pB1LKtZUL1UN9JTFxwydX1qs0u/
 ujvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=AGOnVZIzJVJwtHMDC8pKuPHBHLeWpnkzsf/SxI5d6kw=;
 fh=v0Q2GEY7M08CKAhkkoXQjdBl9o1cQT+vQ9rafrWvpGA=;
 b=W5NKHPbZf1cJFSK3aU26FeLjQ+N80Kc5Gw9tLy+RmTqazLfc1zpV8EubjpfNLiResM
 x4WhKMrQmnjmiTuTLlOi6M9uwpO2GvV7SWfYpYpgxz0HJG3iYWnS9gmoVywENlEc7poO
 BC7CJE4kLGfZ/KeCQL6PXTEpOj9SMLLYpEPsqunuZS4rinU31mEXqAjWfJNk2i3apqNV
 PoECMNrRQGBnCzQxTAnJb1NNeDLU7oQ0+4URAPpQV4K+aWVp1AghJ4/EeeZIE4JGB6Ig
 CeTrI3O1XquuZgZ/mDhnq5mGin4zhObEF6c5HGCGQtVtbZ3DI064J7yJeM1LWyzuDbiu
 HTcQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774186272; x=1774791072; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AGOnVZIzJVJwtHMDC8pKuPHBHLeWpnkzsf/SxI5d6kw=;
 b=JoL/rPVF+5MaBwWE4usFD/myw9cLGLyploflNZ0uvQeqJdDvPWdcfwO53nrutiJ9hU
 aZK9/MQIeZO5R1UoYAN2TvGyoyMGTzUY3HnBRxxYwv7XcGqC3Bp83tmZaqp7wtTF2fVX
 10JNmmtmxzBesTdjsPUTGH2SkYW2kHzAGyw3/O1ArVAzga/o6r8SxonVZw8Z865aajG/
 OfMbPSUZAZvbUZ5V2iSg46abnfCdNjen82171Kkrx86VEQaN7qPKUMnwjSFtmUlc2wqB
 +gkXTcmKH5VzJ+gQh4jsSQcLvP7T5vn5s5kCSQb8L8dnXxhSGd8DvAD50XQrpo93HbEi
 is0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774186272; x=1774791072;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AGOnVZIzJVJwtHMDC8pKuPHBHLeWpnkzsf/SxI5d6kw=;
 b=F8UbUgBuOfJbxk/F9jq/r1WEjtDTHszf77B8R58j1P52AY+39XXmzLCF86lOgNQR1w
 90a1dLwtDcou9kMwpO9ala21iOaDh5xk7oRZ3U/eX+cNNPAZ4wW+HecaL7Rds3PsUqcg
 1zKmzueaWD7mqa2o2dRjwa5HWA6sEsyFNbNStCc4AtMAlTquuJgJJHiXBGHWud5RjYpE
 dUKBVGwvGba2Fh+7pLe/ia1k8bsgv30ggaGS2b5PGCUkvhluOXQVXLl1sjjv3w7/lsOW
 liX4SA9uExUwLJdcxhqUxkEP9v0mUJAxi6JmyAsUYAJ+TrLWu7iwWN4Ff5HVIj+sVD0N
 C2nQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVx69HJJAENTIYgVJ8y6lZJuhSP0oe23GVo0MJr1GpPubrc/oBArWf6J2wFB20pQgXJWuCe7eQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yy19Sq98cvTAQQRsTqu+0nbABlA5vzQUYwNxht+VARc/kk8Zyzx
 xzU4cK85fpASDthskGWAAy1u363B1zTwSES3t9X6KvD2lDNxgVLsENGTu5zAlmS9nqQEud4mHQQ
 SnZjwpC3CeFAHaZ2u7sOIFn8rxzOC4HA=
X-Gm-Gg: ATEYQzzfxvX75LOnWh+/8V1WIJnQmr3NZGpxioP5B8zT3iS+4pURrGsO4Par5J1FBKu
 1PA7M/NxedSGT9/QI52G88xMxFIouXncAQdaZYSKX36JmAFbZBVQnRjf+DweveJZb98ntJtN0lh
 jK5fYkc3twNyiNQpAZEZq04EyRVwxzVEwXi1csmedwJDs0pyI1zA8leztHf6RssKTJPToTpepVE
 l8G2o21VZKkz8Eaxqq2i1AWstyuU1YDfPyFzAy3kctvQaOTVrPFIVpC3MrfD237v0/e0z9rKhr2
 ObhwCugjgR01dWII0HE8gZAaWPLfgyR0A2kxzNXvpmfE7zGnUb7GWWFNnnup6iqFAlWnQAs=
X-Received: by 2002:a05:6512:1388:b0:5a2:8513:8a98 with SMTP id
 2adb3069b0e04-5a285b03660mr2649530e87.5.1774186271367; Sun, 22 Mar 2026
 06:31:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260312095711.3219756-1-Max.Merchel@ew.tq-group.com>
 <20260312095711.3219756-11-Max.Merchel@ew.tq-group.com>
In-Reply-To: <20260312095711.3219756-11-Max.Merchel@ew.tq-group.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sun, 22 Mar 2026 10:31:00 -0300
X-Gm-Features: AaiRm530B-fMuqbedXVQr08CZQ6sfLkkjAWQ2nUcFyNhFiWYmzmMHvSAlLHRhvM
Message-ID: <CAOMZO5BxXq-9toGKMUWge4vPwA0ZPrboVWCwQBFtCurWcLWtbg@mail.gmail.com>
Subject: Re: [PATCH 10/13] board/tq: Add common mmc API
To: Max Merchel <Max.Merchel@ew.tq-group.com>
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, u-boot@lists.denx.de,
 u-boot@ew.tq-group.com
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

On Thu, Mar 12, 2026 at 7:10=E2=80=AFAM Max Merchel <Max.Merchel@ew.tq-grou=
p.com> wrote:
>
> The default implementation reduces code duplication.

"Reduce code duplication by adding a default implementation".
