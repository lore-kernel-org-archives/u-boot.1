Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75A57C3DA66
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 03:29:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B01A6864B4;
	Thu, 24 Aug 2023 05:29:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ow3itMMe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2442C80727; Thu, 24 Aug 2023 05:29:30 +0200 (CEST)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F370864DD
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 05:29:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jpewhacker@gmail.com
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2bcc187e0b5so58146901fa.1
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 20:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692847767; x=1693452567;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jhUYjVfW4Prq/Ym/d27VmZ+BGqoDf3e78BP82khjlj4=;
 b=ow3itMMeeYR/hYyYYiqpGLbBDYvYHut1EiUftUwC1A0j1JNG/ZPY6Ujy5umNPrUgqx
 OvhYv8LmBV9TLNhiMji2DOsq1vaHA117lU3w1LfPaKAQQpi5MEOjGRuYwDeTJKg7JPzy
 Uo50ep4upLJOrngld9eNqvgRBfnypArw/G/7j3EA8C1WyeJia2C1JeXJ6BxvSWVG0WHR
 /+IGVkKm/0eD+iMQBd/7Szv8QveLFcXfl9rEPM+vLB+MTQFfrbxzFljxjIfHhSfMI7zr
 BZedIeqRaa0+cp5N1rrQWpOiDg4gtR8FdredEIBogIOkB+djLcUdMgjYwnIHpTWrY0WS
 LpXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692847767; x=1693452567;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jhUYjVfW4Prq/Ym/d27VmZ+BGqoDf3e78BP82khjlj4=;
 b=HV/8OGlalvEPprtKlhHckiufPC6QchVP7no7CfvKi850sdXOtTN8wLIOsY7zF/mIs6
 6XP/q6IgrxUYBlzUoOaccySKkbGRpFt8nfi0oTzjmUBg5VGpFP0m13kZjLSjJ4a8QwxQ
 zoO0jvHzKMKu/12IYQ5o0V9/XKqIh19wImKqtfRpXaky5mpQGBjAmS8Mm9JwSm40FFu2
 VgPKjq3IXigYgEKisJ42702w7eafGYCNn8c7kZxtt1KJZgjjhc4ZioZ/lOf72kQZvk2T
 p6RrJ3lvnhyuHR/qiErfGhD9JsrikDzDtN6RPyuR7KH31CL40tFjZ+iZ8WltEB8Cetow
 m4Dw==
X-Gm-Message-State: AOJu0Yzt6VAV0Pr25LIRsC4hSQZwJF03yCZ0aUTOhyFG7uvwoWZ8OvcV
 9OCKcphDDR/sjBcSpPCRURePtDcN+X6Nr5/wbbliLx5k
X-Google-Smtp-Source: AGHT+IEz5X88ue1xhJT4jBESll4Psy55hH+xvxuR3KSEcuwPmJ4cnBwXjkMwsHej7posWOpZDSo44Sl6ypDsOiHgnrQ=
X-Received: by 2002:a2e:9656:0:b0:2b9:aa4d:3728 with SMTP id
 z22-20020a2e9656000000b002b9aa4d3728mr10207487ljh.29.1692847766386; Wed, 23
 Aug 2023 20:29:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230815162726.1524958-1-JPEWhacker@gmail.com>
 <20230823164755.2874792-1-JPEWhacker@gmail.com>
 <20230823164755.2874792-4-JPEWhacker@gmail.com>
 <CAPnjgZ3Zorddu5krWzPjdZ34LcDUgP47PLmWGZp1MRDpYxG9mA@mail.gmail.com>
In-Reply-To: <CAPnjgZ3Zorddu5krWzPjdZ34LcDUgP47PLmWGZp1MRDpYxG9mA@mail.gmail.com>
From: Joshua Watt <jpewhacker@gmail.com>
Date: Wed, 23 Aug 2023 21:29:14 -0600
Message-ID: <CAJdd5Gb-dg2grdYLkoWwozq9JGEbktCnuzH3pOro4x7mipeuyw@mail.gmail.com>
Subject: Re: [PATCH v2 3/8] tests: gpt: Remove test order dependency
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Enric Balletbo i Serra <eballetb@redhat.com>
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

On Wed, Aug 23, 2023 at 5:59=E2=80=AFPM Simon Glass <sjg@chromium.org> wrot=
e:
>
> Hi Joshua,
>
> On Wed, 23 Aug 2023 at 10:48, Joshua Watt <jpewhacker@gmail.com> wrote:
> >
> > Re-create a clean disk image for each test to prevent modifications fro=
m
> > one test affecting another
> >
> > Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
> > ---
> >  test/py/tests/test_gpt.py | 20 ++++++++------------
> >  1 file changed, 8 insertions(+), 12 deletions(-)
>
> I suppose this is OK, but is it expensive in terms of time?

There wasn't a noticeable slowdown in test execution time on my
(admittedly powerful) workstation.

>
> Reviewed-by: Simon Glass <sjg@chromium.org>
>
> Regards,
> Simon
