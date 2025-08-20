Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 647BACA0EE4
	for <u-boot@archiver.kernel.org>; Wed, 20 Aug 2025 15:03:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BACCD81E13;
	Wed, 20 Aug 2025 17:03:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="df1B59m5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED1D082B07; Wed, 20 Aug 2025 17:03:35 +0200 (CEST)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56F37801DD
 for <u-boot@lists.denx.de>; Wed, 20 Aug 2025 17:03:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robertcnelson@gmail.com
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-24458272c00so66557475ad.3
 for <u-boot@lists.denx.de>; Wed, 20 Aug 2025 08:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755702212; x=1756307012; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b3KoY5thk0kYxlYopfLcd4socsJK/8l9RzVSEsm1gP4=;
 b=df1B59m5bj1uVm3dkkSTQpDMBj7+kP5opqhpNenqY/ThdHRfyidoMCNk6OIp/J1El6
 dfl0Epe2a3G/ZKJBwAgK2T/HmVLvphW8FjXS5GZNbZRFeuh4J10bL7KzoddJIjQELuKU
 nnc11OwevW52oO5i3UR0vjhcbI4/yA2icTS5UUj5cJA4NAg+ul81RHxLk9VlaLtBtdJn
 qsdNQPZ1eR6LAXnkaUe2+1nPs5NBrtOJJwxGrHhVvlzKN/WOvn+RK2ohUzoZhTUQ03xT
 A4R9I4O+QCIkSHKQQqAL4cgQsTlm3URgTSmh56TRgV/gCmkL0Qhsk3ZDv4phjLeJmJ24
 xBFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755702212; x=1756307012;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b3KoY5thk0kYxlYopfLcd4socsJK/8l9RzVSEsm1gP4=;
 b=QtKnPFWFqDY+mnzXx/AzVmawZ5zRgS+i9Ehnt1c4aSG69wmGW/1X+EUUfiBm/U1iA+
 pN2g05DCS/6qSbq+umg4HQh6RdtJtjbnem7Pd57ArmsdgKO4GKuBEmj3NwMNgBFL8iEB
 TDRqet+YqnsOGCwcZ9L2Ywl+x46P5k4GPuBwK6KCfIf7bvPD4YDLitLXp2JaDQuE/U24
 ZUUWROg2hCbtWpHduq6gAIiv6fEa/QbRGZghMG9pIMTjlVh36ULYUUcqPlG4eoDbTl/D
 cbqaLwIdU2XAXMK8k1vjD0GVrVzJM0/s1nFyPpetgARVZUnoXMncV3zbOfVuL6+qQxzW
 nMQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfe9cZByX0YsDq2OyDiXgPB2PFlBuFruUwxxUadpXgS3gNIOiFysHrHffVX+nPyryTL+jH6WQ=@lists.denx.de
X-Gm-Message-State: AOJu0YxZqCVN4nRM8YEEs7k34HTR82SoMrlrWLpmq45WqqLdCC6OKTxJ
 B+F3BQgg9ivZidUzVYZQqCHA4EVjCP+Eud/EC9zQXMEmdUfNptF4WIlfhmfEyBocrZEe5N+VPLj
 wKMciqOYsmamTi7wDKZU1d9vQuHyO4Kk=
X-Gm-Gg: ASbGncv8NOzmBt8EMWeZMpr12gD88PtSeMNrNWNB5JvZCvhX5BVZrpbt1VO3asoX7Mq
 yI7EDlHiheVXAIeOQSIPZVZ20q4dcn+fxQRXSlqoCnUJmVK+ut+K0ft1aNA/F9A2KVoN3rUQzqu
 rvgKkIAsESQzeyVlUxlTZ2WeqpB28tgRyi9eQz7u54PYrhxgCu0KOYVZ2swWvemJTnawC+aviC9
 01r488myA==
X-Google-Smtp-Source: AGHT+IGSI3kBJTigxJ/Mqs40t+5AMhx6Q1i+O+0LFWOkhFJ3xmhKzGcKkvbHU3ZLdtrB+AKwXb+XE9fnlFFu6HcxPOU=
X-Received: by 2002:a17:903:1b47:b0:240:70d4:85c3 with SMTP id
 d9443c01a7336-245ef0fe513mr39684255ad.9.1755702145181; Wed, 20 Aug 2025
 08:02:25 -0700 (PDT)
MIME-Version: 1.0
References: <20240627082949.357089-1-sjg@chromium.org>
 <20240627082949.357089-9-sjg@chromium.org>
 <yh7ro6sfsbjh.fsf@twin.sascha.silbe.org>
 <20250818141704.GW124814@bill-the-cat>
 <yh7rjz2z3eae.fsf@brick.sascha.silbe.org>
 <CAOCHtYgDAjkQNcwQecLgBuk6GqKiEuhhMpxh-W9K-UB=VYvKTA@mail.gmail.com>
In-Reply-To: <CAOCHtYgDAjkQNcwQecLgBuk6GqKiEuhhMpxh-W9K-UB=VYvKTA@mail.gmail.com>
From: Robert Nelson <robertcnelson@gmail.com>
Date: Wed, 20 Aug 2025 10:01:57 -0500
X-Gm-Features: Ac12FXzZtqdtapO3Qa7qBhN1IALAMFAnQLVn6hSKBZBVbvwDv4_9aEdwQzt2gLc
Message-ID: <CAOCHtYjbXg8R4PtN8t5+ZevvCuOVoGKmxPdHPUkVrOpyXXS5TA@mail.gmail.com>
Subject: Re: legacy image format on BBB / Debian (was: Re: [PATCH v6 8/8] Drop
 the special am335x_boneblack_vboot target)
To: Sascha Silbe <sascha-ml-reply-to-2025-3@silbe.org>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
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

On Tue, Aug 19, 2025 at 5:02=E2=80=AFPM Robert Nelson <robertcnelson@gmail.=
com> wrote:
>
> On Tue, Aug 19, 2025 at 4:52=E2=80=AFAM Sascha Silbe
> <sascha-ml-reply-to-2025-3@silbe.org> wrote:
> >
> > flash-kernel has no way of knowing whether the boot loader used to boot
> > will be the stock boot loader or the one shipped in the u-boot-omap
> > Debian package (if installed and manually copied to SD card / eMMC by
> > the user). Did all BBB rev C boards ship with an U-Boot version that ha=
d
> > FIT image support? The oldest version I could find on the BBBs I have
> > running and reachable via SSH is U-Boot 2015.10-00001-g143c9ee (probabl=
y
> > shipped in 2017).
>
> Good News, rev C is almost completely out of production!
>
> BeagleBoard finally ran out of NXP tda998x's, so we had to change the
> HDMI framer.  (NXP last time buy'ed these pre covid, so
> BeagleBoard.org scrapped the barrel finding every last one..)
>
> The newer Rev D, now has an ITE HDMI framer in place of NXP's.
>
> I wish I could tell you exactly what build SeeedStudio placed in the
> eMMC, but I'm also waiting for a full (untouched) production board to
> show up from a 3rd party shop to personally verify..
>
> It's probably: v2022.04:
> https://github.com/beagleboard/u-boot/tree/v2022.04-bbb.io-am335x-am57xx

First rev_d showed up on our discord channel, they got them at mouser..

Seeed flashed: `U-Boot SPL 2022.04-gc6f4cf7d (Apr 24 2025 - 03:22:59 +0000)=
`

(from: https://github.com/beagleboard/u-boot/tree/v2022.04-bbb.io-am335x-am=
57xx
)

Regards,

--=20
Robert Nelson
https://rcn-ee.com/
