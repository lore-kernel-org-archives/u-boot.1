Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BC44C61CE8
	for <u-boot@archiver.kernel.org>; Mon,  9 Jun 2025 17:00:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED2EA82998;
	Mon,  9 Jun 2025 19:00:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eUNgUfIg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E346882AA7; Mon,  9 Jun 2025 19:00:43 +0200 (CEST)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EEE05826AA
 for <u-boot@lists.denx.de>; Mon,  9 Jun 2025 19:00:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-54afb5fcebaso5520857e87.3
 for <u-boot@lists.denx.de>; Mon, 09 Jun 2025 10:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749488441; x=1750093241; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8UXOoY1K3ALEhKmEBm5Rohis1FW+guIkuqcWeHBQYiE=;
 b=eUNgUfIg2caXCBowN4WliNbQ8eXn9i/vPsm2xhvWzAm/CuCjgDMi7mLUq1mK6AC2YV
 0QRsO26Hj/tp1FdIDm3QQW7EgMK403PYKxVJGnG0Hk0BIcAslvNSpL5973rlnbOHYkaj
 ZZ/uThYCa9pTJ2sI+RNpFYp51LbUnUojeCZ7rfi6lfMNZUX4jPpnNhUL2cOo8ZoZC4yB
 7faAO5JWbdVfhvOohqX8uvWNHLuF5jXHlbcCAe/jHWtn7WZ7i7BxV0R7GecUjTsFtCvF
 FcHV9TLQwIGUMI+LUn+Y/0foi7szpNZazeMs3wu20MNbyum72rPyQ7SwT8+sBNNFm0nk
 /BuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749488441; x=1750093241;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8UXOoY1K3ALEhKmEBm5Rohis1FW+guIkuqcWeHBQYiE=;
 b=Y0GGdywooUdPJD9KsE+gJ00gieAv6zC8PvUAPFpQECG/TIzlSzCVlTs80sJ9oFVxAd
 LhUBFh7oCj6lkIVVjixmYqXJzMX2n9XPtdjePjrQNQ5R44mB7qfwh8VirQW83nNDaey4
 GC8Y79Y/fM4G+IfA5Zbmhe9LYOJBAzEZrUMnlF4mgWeUYN0Ozj2gjsRyD4KZRtSZPjYO
 l6vt+oYi8oieg/qntUZpEgItF7/WP4Iyi8wAVUPwZiNNYO/V28iF6AYA7S2eQerppHGd
 UIXOEast3Uem2xAmyTzrUawYHhat4a1D1EwItXi/TnGG7IrAUQva60/FRN9CmcdS9pC1
 qCQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvo+dNUpEYW8Wg38CarKKXiJSuJeCujAH8058KVw5KdHwF+nxSmO0QKXokAAJOI5YwS6saMBo=@lists.denx.de
X-Gm-Message-State: AOJu0YxPh7xrE6JfKc+PlicA35sMbkcJvqELZyK/xTabt4cy7RE6ME7Y
 3f9ep61YwaLOPzLj5y/BLiKemPRRnumVyJX9ekGYamSNyUzlNMAhPpwS2Yi+utnokeGrn4UZOJN
 eEe+qBxhPt/4QXDeiPkBNmM6ND4ZOTwbzVg==
X-Gm-Gg: ASbGncu5eTEzTNaKPSKPKpDvfGXtacF1wzjtzPJtWweznLjIxBuW8de/lbCt7KikP2p
 4l0phnGm1YqXpbQjGwh0AeRfdLjUwdKxmxGaAl+1Dj88lr+RtcEaMZUZhr4u+TRm5vImWqhF54D
 ahPKJRolUxlhepzh/Ipy5PWbR3LyZfVimVm1Q0Qia98BUHNaBTmXvLRG6DZnyuhB3c
X-Google-Smtp-Source: AGHT+IFrAtWLthd3n4Um20Kw4PTIc5fksO/NfrsTgTjP1lg2Hp8wLbfA/moK9UfBtyjuZktahKYdo7EQRWHITpMn7VU=
X-Received: by 2002:a05:6512:2510:b0:553:33b3:b944 with SMTP id
 2adb3069b0e04-55366d3f628mr4104381e87.54.1749488440270; Mon, 09 Jun 2025
 10:00:40 -0700 (PDT)
MIME-Version: 1.0
References: <20250605105244.619858-1-festevam@gmail.com>
 <20250605142519.GX1382132@bill-the-cat>
In-Reply-To: <20250605142519.GX1382132@bill-the-cat>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 9 Jun 2025 14:00:29 -0300
X-Gm-Features: AX0GCFur6n_4yEugq4rD6xGZ8Hm77bjpvnBrQEwNZCSP2bX-abJ9LdyUQz-dNtU
Message-ID: <CAOMZO5APk=D_Fb5MfaCAQm4UGnqHTBtN+O19kCpAJdzmEqrHUQ@mail.gmail.com>
Subject: Re: [PATCH] Revert "caam: Fix CAAM error on startup"
To: Tom Rini <trini@konsulko.com>
Cc: gaurav.jain@nxp.com, olaf.baehring@draeger.com, peng.fan@nxp.com, 
 tharvey@gateworks.com, u-boot@lists.denx.de
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

Hi Tom,

On Thu, Jun 5, 2025 at 11:25=E2=80=AFAM Tom Rini <trini@konsulko.com> wrote=
:

> I would like to wait a day or two before merging this, to give the
> original author a chance to chime in but I would like to see this for
> -rc4 this coming Monday (unless there's an active thread on fixing the
> problem for everyone, in which case we just need that resulting fix for
> the release..). Thanks all!

You can go ahead and apply this one directly.

I don't have any other patches for the master branch at the moment.
