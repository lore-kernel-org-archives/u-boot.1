Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2983C48BC3
	for <u-boot@archiver.kernel.org>; Wed, 21 Feb 2024 14:03:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9FDCB87E26;
	Wed, 21 Feb 2024 15:03:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nbwq9Otp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E56487E29; Wed, 21 Feb 2024 15:03:44 +0100 (CET)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8FF1787C0A
 for <u-boot@lists.denx.de>; Wed, 21 Feb 2024 15:03:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-512bd533be0so833244e87.0
 for <u-boot@lists.denx.de>; Wed, 21 Feb 2024 06:03:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708524215; x=1709129015; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cXCsRQK9Oe+JL7MCSNBXjmeqdqAULa4XloZodjRDwxE=;
 b=nbwq9OtphOYtuLBLbEkyHqXwpZSQpdvh/GHx5YAcE0+iuSDWZXv5Ej1mdk1hu42d4o
 YijT0kugOJQimvMPbK8oNYzOHJA3CU41kyvZl0Do0IPGCDYU9sujvpkInLr8YTd1eBAR
 Vw+qPMH3BvupAA9g4a6nM4LK5kheEBFu1YqmsLox2V/h8nd78WG9/qx7cwxFwcUA467k
 kqBX4bKbhr54nZhBomukuL15K3F/04bYsXnzvapwRI5+BVlyHMDSxijjyVqaaEwY3smT
 QEWb3vQRoW09SsLNkwvGFgBZRen1dvJF/99TuRqaL+YCws+JX7yu5kvP8lYeKlg+/2Tn
 rI/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708524215; x=1709129015;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cXCsRQK9Oe+JL7MCSNBXjmeqdqAULa4XloZodjRDwxE=;
 b=m4XT2YJnFqNU7PMTEzdz7i7QvcDNIDzFV51HWnGD40G7dhKRyctmpeEzJw6MTuIEwk
 icQ4ThTaVnVMlLungdkFpIJ+jo3SCaDkJ1bFqd4k42atOEWk0EdVjYVPSorm5x9FNF2R
 N+onrUzVeUvJrnpAUNbp4k4yO78SsLQB688t/48KAb01JKJOaPIc6ChfgAP+6tPzZn7E
 DFZHMma8HIY7X2inb7UPeO6V9XZZrJOnnmWOm1WhyYzr2jgjdFIt9amtbVviRrQusjew
 okZ4GVBkBDFf6Wb69Ss4OfvCWqGuJloh+RzISjLJShFzwiceObYJecrzsY8uht/j4lUI
 hUZw==
X-Gm-Message-State: AOJu0YxV+xzRkJzlr2yvts4nlwVy/oT8JifmGppeFifFtKKsFLJxRS49
 iNqkHAhYSeJayoRDFolfSthz/+CJKCk29XCEoIXxVbFhz1C7a0mhF/A/jdYKGIbz9YBBQt8Zs7X
 Fa8TAVMXeDtQuwAxk3upGhFsBTRQ=
X-Google-Smtp-Source: AGHT+IEhXUYvAB/mL3pQa+LXrjXlJ3ExU2UxhGE9KRCSuC33Kh0gmxNrCCZTRtQRGt51iz7r1QjX7vqcku0XSE1bcwI=
X-Received: by 2002:a19:2d44:0:b0:512:d8b0:2630 with SMTP id
 t4-20020a192d44000000b00512d8b02630mr90068lft.39.1708524214522; Wed, 21 Feb
 2024 06:03:34 -0800 (PST)
MIME-Version: 1.0
References: <CAF1iuRr6q15aApGB8zPb8M7yWrUahT8H0BjDHnWRp1_Q__KDng@mail.gmail.com>
In-Reply-To: <CAF1iuRr6q15aApGB8zPb8M7yWrUahT8H0BjDHnWRp1_Q__KDng@mail.gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Wed, 21 Feb 2024 14:03:23 +0000
Message-ID: <CALeDE9MSQwGU0JXs96egk8y8rc=f+JxtNm3U6u4Fxb8L+jWtkg@mail.gmail.com>
Subject: Re: ECDSA related PRs
To: Bob Wolff <bob.wolff68@gmail.com>
Cc: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

On Wed, 21 Feb 2024, 11:30 Bob Wolff, <bob.wolff68@gmail.com> wrote:

> Hi there,
> I have two separate but related pull requests I'd like to contribute. They
> both have to do with ECDSA support.
> - The simple one is a lack of null-pointer check that can cause a crash in
> certain situations. Easy peasy.
>

Just send that one on it's own

- The less simple one (and hopefully not too controversial) adds an ecdsa
> verify driver (UCLASS_ECDSA) which utilizes tinycrypt to do the crypto
> work.
>

Do we already use tiny crypt in the project, if not things like license
need to be taken into account in the context of the GPLv2

Please advise on how best to proceed. Happy to work within the confines of
> what works best for the larger group.
>
> Thanks,
> Bob Wolff
>
