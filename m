Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71EC8D0BB6F
	for <u-boot@archiver.kernel.org>; Thu, 24 Oct 2024 08:37:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A443F892FD;
	Thu, 24 Oct 2024 10:37:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cMnWG9rd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A3DEE89333; Thu, 24 Oct 2024 10:37:43 +0200 (CEST)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE9E9890AE
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 10:37:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2f75c56f16aso5718841fa.0
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 01:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729759056; x=1730363856; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=q+ItNUxx6qdEeKden71T/y85dKdE5OPU8s47oCuT5Ig=;
 b=cMnWG9rdp6B+Nj262h9dJPzWCQY4wLNMyUuM/lZ0UmClhbcnqzDvZNIMGNkQvMqJUj
 jW+V5hahOHHXR8G7KqD+pDwx4quPzShRLFhWYB9taJRhrGw6TCUDQafkcPNPcVOLKf6b
 QXz3mU0ydQwIT7u8s741dhVwErZwYJ9h86fdmr46tO53cHG5fkck+BUzbSosL6/GYbWi
 7snmtzez0FDYM2wwLSdStooKakhwXuGowKRWTu7bXLJGdTMq1y4iypHRq8v8UrasSUDz
 F+mjHsdnQkOhSmIq+KuPvMGTPQaCt5z5qgSBvj6mVlWXj/2ZzBLwhc/LkZTWqN+Yvfk9
 ZAew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729759056; x=1730363856;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=q+ItNUxx6qdEeKden71T/y85dKdE5OPU8s47oCuT5Ig=;
 b=Tmc2XxjXCt6Sya9EgoynYrXXO6eNq/tZ14C9r9ptaxzGwo3PiijFxey/EHXkQKzzMR
 FlhKqP5IfpNtSn5Z392vBC+E2n/R2A6NoBlZX9CPQdX8zs69pQt88gAJopwysfjetYvH
 QcQY/Trra2qDjX6/Zi16qPxpfYR9+uGG+dHkK8MLQNhkps/nqfl1wBhDWuo/Fg+b/wxF
 x8vrd+J9gZo0AO6dwTO7Tck1Cyv2q4iRCCO3jpEsKSh3egnb9zLceIS9XLlv2Z4Fo0uk
 FYXs/N3J+tnjuIQTkYcA90Q+oW1ivoNIJ2ikeahwXPgWaG2bvfEtJFsAv1HxqECwuM7x
 k4Tw==
X-Gm-Message-State: AOJu0YzvbCSaQ7va7SWfpt27TK/K7nGC8NqiOu9aL/kIoNfYNLgMqB9d
 0Q6cGclVpwuqvkSxELecj1s7QsMec19T814E9lRsgjo1xO03UZ53kRfz4xRf7P/AafYj4JIH6PN
 yqlrAYhS+70p3i6+xCHCGlhKnk1A=
X-Google-Smtp-Source: AGHT+IEtOZLh3ObpL4apeHSRbZBxcUpqls9FoSI+T1PEEwcm1Dto0qnbdBKMQCSI91TP7Hk7eZXORIlVuLYdrcup+cY=
X-Received: by 2002:a05:651c:545:b0:2fb:8c9a:fe37 with SMTP id
 38308e7fff4ca-2fc9d30b200mr30179211fa.16.1729759055884; Thu, 24 Oct 2024
 01:37:35 -0700 (PDT)
MIME-Version: 1.0
References: <AS4PR08MB8167C4DB165AF2FB28C0751DC04D2@AS4PR08MB8167.eurprd08.prod.outlook.com>
In-Reply-To: <AS4PR08MB8167C4DB165AF2FB28C0751DC04D2@AS4PR08MB8167.eurprd08.prod.outlook.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Thu, 24 Oct 2024 09:37:23 +0100
Message-ID: <CALeDE9OCPGb9PK9evm=8bQyV9fWHrHd0TuOA6BSufT5mZLiX9g@mail.gmail.com>
Subject: Re: Patch for 2018 u-boot : Fix "EHCI timed out on TD - token=XXXX"
 error on ehci-hcd
To: Kumar Girish <girish.kumar@al-enterprise.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
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

Hi Kumar,

> I see the error ""scanning bus 1 for devices... EHCI timed out on TD - token=0x80008d80"

You don't mention any details of the device.

> From the denx site, I found the below patch. But it is for 2016 and 2017 u-boot version
> https://lists.denx.de/pipermail/u-boot/2020-March/401784.html

So the patch looks to be sent in 2020 so I'm not sure that's correct,
and looking at the thread the problem the patch is trying to address
were fixed another way and the referenced fixes landed in late 2019.

> Could you please provide me the patch which can be applied on 2018 u-boot
> Thank you for your support.

Is there a reason you can't use a newer U-Boot? The latest is 2024.10.
Have you tried that? Looking at the thread I suspect the problem is
fixed in a version later than late 2019.

Generally the U-Boot community is happy to help with problems but it's
not a free patch consulting house. Generally you're expected to try
the latest release and see if the problem still exists there, if for
some reason you can't move to the latest version, because it's a
vendor tree for example, you're likely better to go to the vendor that
owns the SDK for assistance, else there's a number of great companies
that offer paid consulting for U-Boot.

Peter
