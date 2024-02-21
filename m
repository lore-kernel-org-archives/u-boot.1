Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43424C54787
	for <u-boot@archiver.kernel.org>; Wed, 21 Feb 2024 11:34:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 392C187E19;
	Wed, 21 Feb 2024 12:33:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QPrJjjvs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2319E87E19; Wed, 21 Feb 2024 12:33:57 +0100 (CET)
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com
 [IPv6:2607:f8b0:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56CDB87964
 for <u-boot@lists.denx.de>; Wed, 21 Feb 2024 12:33:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-5cfcf509fbdso1941576a12.1
 for <u-boot@lists.denx.de>; Wed, 21 Feb 2024 03:33:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708515228; x=1709120028; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7Mav+MNOAmd1BTMiV0+i7ERkAx/qP8tew4eMSqBancU=;
 b=QPrJjjvsomvDqTKQKeBAYGYbZuM9S2c8TJtIKsAZb7n0FO29v5Riuhupa/gkBD5M2R
 ajS+ly2cz/meTzoz4FWV90an4Glc3ujohhn4Oc05vIZHdE919oilTBjZ9YcdDM56LYBc
 ho1ePfpcRKh8sACn4btHZSQ76PywVyJO+r/0aRNeFS1P/wgWpH6Mr2ilMTpWKzi2WhZW
 EN8RAt3T9Lwm+kV+7nB/35XM3jrhkynR5HtSU3qdDfac/j6v34WyI18r8/lbRLIbnB1r
 A9cU7h7NRVyX2VPYFs+R0N0s3dknzFyq+J/ZrPanoWz3K/LufKilsTRBbMFzndJT6HjZ
 YxrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708515228; x=1709120028;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7Mav+MNOAmd1BTMiV0+i7ERkAx/qP8tew4eMSqBancU=;
 b=pyZHFOsaoYZGGPV2FLZGOt23/7r1MddDxS/K3rlSNGISnu0iUXKhWfV0T/VpoWi93d
 nTMRbv3tnV+WbcnCEn9A9oui9mHZel+7MzQO8HWJEcBeMaWNbEuFAorLBaIOtn/XSbDq
 SmxEfaoJCIkQlTTCAEyf48WMBA550owtG2Egu23B4tUzwrYUu0Bb/CgxgUN7rgnghb6Q
 IHzGYu6jMWefOvM1N87XzTqreBDLKw2jQQgYZqUV7FYOCs/dz03BRATt/VgTIgofB6fZ
 4PVi9mld9bUMblP44eJIf2ABzf2wstKn8V19eh1ngGsMvP0/FLWVJlSqZ/nTEoqtf66c
 QnPw==
X-Gm-Message-State: AOJu0Yw2YCqkqlvaGBYUZ7O7fer6MTrl6YLnZNSNSGSPjOL5uD89RcD8
 2X+CehLIc3C/S6JYKLDIWfs2PmzWYWVh1+H6VfaWoR5+49DK5DflSHLPrHK7NwtHRYZ7KgOIfiQ
 xxfbnfcgxqpNaiH6q5arpG8m+yzM=
X-Google-Smtp-Source: AGHT+IESEP2xUcbdTaTKGanyEtxmW3hy3DycBKG6B+5+FexMTZTcHC2YRk0Jr0kwGWKJIjkracwRIFB695JvsORwxWE=
X-Received: by 2002:a05:6a20:a10b:b0:1a0:c2b5:fd9d with SMTP id
 q11-20020a056a20a10b00b001a0c2b5fd9dmr1215878pzk.1.1708515228583; Wed, 21 Feb
 2024 03:33:48 -0800 (PST)
MIME-Version: 1.0
References: <CAF1iuRr6q15aApGB8zPb8M7yWrUahT8H0BjDHnWRp1_Q__KDng@mail.gmail.com>
In-Reply-To: <CAF1iuRr6q15aApGB8zPb8M7yWrUahT8H0BjDHnWRp1_Q__KDng@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 21 Feb 2024 08:33:38 -0300
Message-ID: <CAOMZO5DNS47yxpeoJNHK-M1jDwCXtSR3+D+SRRb1np2UyAYLxw@mail.gmail.com>
Subject: Re: ECDSA related PRs
To: Bob Wolff <bob.wolff68@gmail.com>
Cc: u-boot@lists.denx.de
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

Hi Bob,

On Wed, Feb 21, 2024 at 8:30=E2=80=AFAM Bob Wolff <bob.wolff68@gmail.com> w=
rote:
>
> Hi there,
> I have two separate but related pull requests I'd like to contribute. The=
y
> both have to do with ECDSA support.
> - The simple one is a lack of null-pointer check that can cause a crash i=
n
> certain situations. Easy peasy.
> - The less simple one (and hopefully not too controversial) adds an ecdsa
> verify driver (UCLASS_ECDSA) which utilizes tinycrypt to do the crypto wo=
rk.
>
> Please advise on how best to proceed. Happy to work within the confines o=
f
> what works best for the larger group.

Please send your patches to the U-Boot mailing list via git send-email
as described at:
https://docs.u-boot.org/en/latest/develop/sending_patches.html
