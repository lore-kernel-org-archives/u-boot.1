Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C64AFC35FFA
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 17:27:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 097EA815D1;
	Wed, 19 Mar 2025 18:27:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="X04WcIrA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CBE08193A; Wed, 19 Mar 2025 18:27:54 +0100 (CET)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4EE6D803CC
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 18:27:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-54acc04516cso1065413e87.1
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 10:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742405271; x=1743010071; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YUyEOHzMN/V1W9Q/pagC3CPIadRq7K3wT2x3wdxAZWw=;
 b=X04WcIrAZ3Tf+CA087NPteb9Af3hnmYngPtR7qk+GKFS3jWIKKzt+aSuSBWB93WCh2
 LaqOEnafgXWp3KKbvM2L4482bcHELJpekMY9lIfhGA/UIqHHq4Dk/jpjuyY5tT1NrD8O
 wWzQ+4bnWwo49fZVLWKmSwZxjUB2+wjiySOGN1jqEEFc+4sF6Y8ByN0WK7h5zDvC5mPA
 N5mzHl6gO/WpY65Q3/xOcjgeArvcEMlvimux6Aegitmf6z3TEE3tElQ0IDe7UsBrOQfr
 II6pvOVcS7ajcfqHx6ZJCl8ixmpWhaf7utF1Xm4mW9MpooZBZ6tzfiR1cfLrheFOdbM5
 NFng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742405271; x=1743010071;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YUyEOHzMN/V1W9Q/pagC3CPIadRq7K3wT2x3wdxAZWw=;
 b=oX9bW2sS+21E/QVce8tmQfahaWgYFqjWwiHWu/p2Qqy38WvhdrKtlpP5sjG/1vm97o
 d5uvg/lqLjd1VBlAy9mHjRrTRlHhQyCpoRRHaTzX7NGpd1OC3dPMOhcMjht/NyU8MP/O
 fGJ/qFIIMzBLA1kyY6WNTKVsayUWfriYUj3THGOWvwISYA8t28dSCGLKWYQXr6TjgbbF
 Kd564KvuUNCUzpz0JD2FS6VqVipwfTxeaBvD78y/KIHKGGm6QZvVK7EpIptF3dLNm9xy
 r5mhfzGm6FbU5Lr4LZnT/OH3tMjleFyNy6lK85em57DDZN4XHvEnL2cLlTshOf58Ma7p
 1MgQ==
X-Gm-Message-State: AOJu0Yw6pB+ObRUcDuw/bL+fHil6B1Uh+5udfl03EFOepaMrn7+l1VQF
 h7GLz1hRR+DifGK4HzvyYNg8SvoIoJfEsX5ESKwfDim1OHFGCXRbhXPB64ieoG7XcXfIV+wO6yk
 teRIfPjxddngmsDfUz2Fwy4uYSm8=
X-Gm-Gg: ASbGncvjFTDBGUKquFiaIwwE1Ix7B0rn094Ix2Mf0S6t2dr6yV/asx7GCrX/47rY2G2
 ZoXEVI8WoRh/+EP06n6dSxuR0sjkuJwppy8uQc6cP8DncJqRAVPcbb2GDMDW4nchjpj5T8hUH9z
 fDJrmNqLKNf7GJPOXY0cIvu8Vb2QVRMvcnNfCYT4/qk34UIiDo2Spow0ODSA==
X-Google-Smtp-Source: AGHT+IEnpH0qlK3wtxxardgZKfgP+CsvWO1P64quMlKzaQYYx0YL8/GanzhZBM08PgQs2lC33eEsE9dyyUO38MuTMYw=
X-Received: by 2002:a05:6512:1288:b0:545:3032:bc50 with SMTP id
 2adb3069b0e04-54acb1b7d36mr1591746e87.19.1742405271154; Wed, 19 Mar 2025
 10:27:51 -0700 (PDT)
MIME-Version: 1.0
References: <20250318233849.587520-1-aford173@gmail.com>
 <20250318233849.587520-2-aford173@gmail.com>
 <CAOMZO5Ah3zG50Do_kGx=63RmX16hFrrgzsBk6Zgm6tQoB-VTLg@mail.gmail.com>
 <CAHCN7xKd2geEkK77kYBp1jQJpiM_NNpTPP43ONNYsUNgEtaVrA@mail.gmail.com>
In-Reply-To: <CAHCN7xKd2geEkK77kYBp1jQJpiM_NNpTPP43ONNYsUNgEtaVrA@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 19 Mar 2025 14:27:38 -0300
X-Gm-Features: AQ5f1Jo_UoVrnx89vsDxjl2eivltWHUF8fi2AL8Djc1qtYdcIHW_me_QeW_SamM
Message-ID: <CAOMZO5C2dnenrhcUgRaKYuYPtDbKgvXQO4JQT34GPXfek1Mh8Q@mail.gmail.com>
Subject: Re: [PATCH V3 01/10] clk: imx6q: Properly handle imx6qp ECSPI clk_sels
To: Adam Ford <aford173@gmail.com>
Cc: u-boot@lists.denx.de, aford@beaconembedded.com, 
 Michael Trimarchi <michael@amarulasolutions.com>, Peng Fan <peng.fan@nxp.com>, 
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, 
 Stefano Babic <sbabic@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Emil Kronborg <emil.kronborg@protonmail.com>,
 Tim Harvey <tharvey@gateworks.com>, 
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, Peter Robinson <pbrobinson@gmail.com>
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

On Wed, Mar 19, 2025 at 1:39=E2=80=AFPM Adam Ford <aford173@gmail.com> wrot=
e:

> Sorry about all the noise.
>
> I think I forgot to type 'git add' before the "git commit --amend" so
> the fix didn't get applied, but because the same file was shown in the
> commit message, it looked like the fix was in place.  I'll have to
> confirm when I get back to my build machine.
>
> I'll manually build a few more mx6 platforms and try to spend some
> more time trying to figure out the CI/CD tools.

I have manually fixed patches 1 and 2 and now CI is happy with the series.

No need to resend it.
