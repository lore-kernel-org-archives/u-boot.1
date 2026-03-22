Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60659FC72BE
	for <u-boot@archiver.kernel.org>; Sun, 22 Mar 2026 13:21:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C50A83FED;
	Sun, 22 Mar 2026 14:21:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AqR/E0Ng";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 962318407B; Sun, 22 Mar 2026 14:21:40 +0100 (CET)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5691583FDC
 for <u-boot@lists.denx.de>; Sun, 22 Mar 2026 14:21:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-5a281b091c2so3393936e87.0
 for <u-boot@lists.denx.de>; Sun, 22 Mar 2026 06:21:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774185697; cv=none;
 d=google.com; s=arc-20240605;
 b=HEA9T1UVGiwbw8mydIfaP2iFIiPAdw0ssbAGgDug1DN4T2WamOme+kjNVP08NYQD4a
 fsvNW65+Rafv3AdEJIeFCqFHkYXmlcp5UvpY4FaQuEVsqfW04IIwyMj1cpzL3P8GftUz
 Joa9w10K9SmuLAPgDspP+z6FphFKQyz4NHDIOkmMKLhqg0cjTWUGYP0u0p6w2yNLjYqI
 2r1sWDxVn+yTVdDMrfjcrb0ZSl2VSGziWrI3Sh0XYCB1Mmua4mExjmK+xbvO2b9SEDYL
 c/r3Qnd/ai9mJvtiZGNRKkHH2P574LH9YnxOdpLic3GB08hPo+2bgxucciHQbUzVKWCv
 V+hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=5NueTpfEx7f8c1ASX2d1xfSPuak5ucng52wA6/4QzBw=;
 fh=B2a/7gndh5UiQxieCAVIUysrqICh5zRePlp5tZ1+jfg=;
 b=jmiOJnIp2H9Zi6nu2XMYOOnOlS63qcX4UIZ5+NPr1foiSj9v66tN9//N0LRBgbeiPf
 OP6UMTjkr4g4zlg/WdZiGoruGZs+q9UQyGZahgn+4PV/Ko0JA2Ax3f19lE+DQkOaUgr9
 479oZM1BayXVSOumKa6K17+T2LXUp5DJX2WoHg0vHhel3AducGYbkxCz87QogxCzTqpU
 8luKFtEyzJ1fu93CScRxtz0exFaCeWHLmcYY/uNzX/cV0Nb7WIuSUQC4xExzDHi49biE
 rIzpqlyzUF/EdGA+fzl8iKPocb+CtuesGuBI6Zgb7/5B/fsAUPLgBcGJipmN4zOOjLuU
 FMIw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774185697; x=1774790497; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5NueTpfEx7f8c1ASX2d1xfSPuak5ucng52wA6/4QzBw=;
 b=AqR/E0NgbP+nJChO2qeFW19ziIrl28ZnnLEl1PaZFqfqWfVKRNjhfJJaQEqzUXEUpg
 +HuDmIlHgf1PqXsqpjOCMCVLwDHnJ9Rop7Ma1wUJd9hSBw6hNmYvM6Z1paOBgS/Q/1A4
 UX+DGPY4xt4dq5AZMUscNky90qoXHvAKAG3GRJMnY8b8bkM0CqYvqMqmyZeJ0M1O/Pp9
 m2VmO6XdVU2hVhPD5z+/t12FeWYnULvOK7GGz1GV7PqKVopgk/zZccCWLDKDlQbuLvl8
 hhRU2fEFhcX8A6YcTve1Yi3HyiWd2fuBoLvndSH4rgKPZOZ0bfZVRQW72Q3QQXlJHSZo
 AGhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774185697; x=1774790497;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5NueTpfEx7f8c1ASX2d1xfSPuak5ucng52wA6/4QzBw=;
 b=rB1U5uZQRIEoFwezGe8uAUHf8QKCuaGYVZeNN4fFWpRBlRjoZpS/VqI/DA31JgQ20P
 QwBGFlvj9MPy0hcAcuDnqi1uVxsgcpUsKNKSwhqO9v2++SLN6twd0sxzeQCZW16wFUEg
 atI2PNkXNFY2r229H9iU36w12xc2MU+6ytg7+xo3+EdAx8yA57casVi6C7h4vLQu5zkY
 amMQB1w2BNkL+3pcEyQttcV91utGZLSOqwJhkh6UAx+TFw9dmXM2TAfZynYK1rWawUp0
 mUPlhDEk8OvdEK6qgQW6RY10XXJMjwC7AEGMddWcXLYX0505JdqHH0aPbOIMxPgzxDCH
 G7Sg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfOINm3BnwBftQIzJARZcst674ZUP7d8IT1e3Y659hp/vikAxToYrKWBB3NgQH91k+eo0C/zw=@lists.denx.de
X-Gm-Message-State: AOJu0YylE+wYtSTtTaPjX8Rphvph6/0oXCzpxqQP/VYJmab4J593MaEI
 uQgCDpjjWN7qUfMYGjqkZnLxQBEnXdEABOVevFKkhc0IygB2JoOfRmYb3JO4Fvk6SoVGeerV7nX
 iM6iTsFnyorQwuFS7u+Mm14jBWOz3EWI=
X-Gm-Gg: ATEYQzyulJ65/ptmZ6463GXFNysmYtRdVq6SJsRvYCaHz+pqF5oHv+eLjq3Ra+IMA3M
 lhPefSTna6C9312X8ys+0VFQ4S6D5hO3MZr5D4VcDtWbmhmU5rI4MHeYjO4hCKHSNzU5peN15LV
 jdlxO1qcUof6I79g+IXJPHyUFMj0uEFK72oRbe97rp57aLT0q3izfFQzgUyPVjpPD4e4BniMlMl
 VV8XI2AvLTrCUJ5BiTmPv7sB4VLL9dx1WBwfrjzRL3DqO++UjVkHY3KrCkf8S+Do5dzJGYbDcUt
 oP91NaNF6R260AO9C/syvRvjZrnrfxCRFQqPjyDjg5lPxFeX796jv1ZoZl4m/h+1s3Pq5Oo=
X-Received: by 2002:a05:6512:1392:b0:59e:5c8f:a5 with SMTP id
 2adb3069b0e04-5a285b071bemr2676898e87.4.1774185697232; Sun, 22 Mar 2026
 06:21:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260312095711.3219756-1-Max.Merchel@ew.tq-group.com>
 <20260312095711.3219756-3-Max.Merchel@ew.tq-group.com>
In-Reply-To: <20260312095711.3219756-3-Max.Merchel@ew.tq-group.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sun, 22 Mar 2026 10:21:25 -0300
X-Gm-Features: AaiRm50I6o_-mRqZvbAwgKgw2nmB21j4G9fnoqhBVCR1InCMlJXAJi8T5bXDp8k
Message-ID: <CAOMZO5D8-wNEWRhvksBTN2pq3o8ES8GhdA=CiGHUcALKtfHdkw@mail.gmail.com>
Subject: Re: [PATCH 02/13] tqma6: remove board MAINTAINERS
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

Hi Max,

On Thu, Mar 12, 2026 at 6:58=E2=80=AFAM Max Merchel <Max.Merchel@ew.tq-grou=
p.com> wrote:
>
> All files are integrate in global MAINTAINERS.
>
> Signed-off-by: Max Merchel <Max.Merchel@ew.tq-group.com>

Please drop patches 1 and 2 as they cause CI failure:

WARNING: no maintainers for 'tqma6dl_mba6_mmc'
WARNING: no maintainers for 'tqma6dl_mba6_spi'
WARNING: no maintainers for 'tqma6q_mba6_mmc'
WARNING: no maintainers for 'tqma6q_mba6_spi'
WARNING: no maintainers for 'tqma6s_mba6_mmc'
WARNING: no maintainers for 'tqma6s_mba6_spi'
Cleaning up project directory and file based variables00:00
ERROR: Job failed: exit code 1

https://source.denx.de/u-boot/custodians/u-boot-imx/-/jobs/1407664

For v2, please make sure to run the series through CI.
