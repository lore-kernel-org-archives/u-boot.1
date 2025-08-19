Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90B38CA0EE6
	for <u-boot@archiver.kernel.org>; Tue, 19 Aug 2025 22:03:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F4AD82B07;
	Wed, 20 Aug 2025 00:03:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="U18pJUpA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38EC382E37; Wed, 20 Aug 2025 00:03:23 +0200 (CEST)
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com
 [IPv6:2607:f8b0:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA63A80FA1
 for <u-boot@lists.denx.de>; Wed, 20 Aug 2025 00:03:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robertcnelson@gmail.com
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-b4716fa7706so3959321a12.0
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 15:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755640999; x=1756245799; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EEfuM0Dypm8irmMy0vK6hbbI3OY0SI9myRw2+HOvxIQ=;
 b=U18pJUpAL26qH10fn9R82oL/Yu0V3A6iVDNfDece+K5FQRZTcnFTpUEZ8iifVEP3Fy
 D8hN6IgGszhHjHQc4cb/pv43+w8lZllUvxiTSILniDEVFqkUbyZYZhjk4t73ib0IQLoo
 k4VePmzJDgm/G/p1MFx4zYd7j77jZ977WjVJzaIytyaU5NRgxmU3Q7+r/b4OLdtwKBtB
 fM2rC0/35SlNFa2D0IVhfBOnOhpn3/QLdhVHih3Omt+6aJVF1KylnkAGagdZnfL3n0ly
 cgux85RE8P7w60SAXZvYH9DTKmQXXLmoRAx/zlbt/2rsHUVogsD/3eGUlDqOoD6M6Wrq
 JT+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755640999; x=1756245799;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EEfuM0Dypm8irmMy0vK6hbbI3OY0SI9myRw2+HOvxIQ=;
 b=lSCjzLt6LMNZgPZyan4QlOvQJPVy7vjUHszVfNnVKDkGFGlbrHNX05PWKEaerdgVWp
 rXdAWTDYnQ/NHM+RovWtw1BVDHxe0dyRwC34qZxBTbKd2l81B78bvvGzsBW9KW3iZMuP
 akoHhITrDgz5BKWMwCoMPvhkBWQIgcYkgqJpL+o/QLkH3HK3DKl+jhuEkRafsY91KooK
 XlR0KVpSzr7T312usa67i0ZCtTXT1912Ms6RnVH/QTT6+g7Wy6WlUNFYUjf0VW7lS/sv
 +0hgCol+i35+/bygoGwUdAJF67LlOupsIw1IZs7vjDipAH2yqRIMrFQY0k+N4K+qPUWh
 9CuQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFBLO+/FoTM8gGnQmqHvS5510uLKuJVS+xAZbqHY5iO1Pqrb5DLey84gBzsl5/flTRozGEwQM=@lists.denx.de
X-Gm-Message-State: AOJu0Yz7NbGFt9UUvlVHwE7aDJ8NKOfnoQZ/rSuJ8yzsTYNXULUeF8P6
 g1dbQr3NXEdsmyoRa1AH59JTKpOGo2n38w3Jfh5fdxtasHPsQiDxcj2AArK7/Z9x+gmwMOciIOV
 HCfaWORxIaYfZc8siJr0sOvAMErKn5PE=
X-Gm-Gg: ASbGncuEmNXXTDbLuu+9UDKna3VCYxSn4+Etx+Aa2ujtUHOblSJrjayR+IxN0KGOKLO
 7vB9GicR0hx9focFGBIYolHKGlZbcz/B8AlsgmRmHj9c964ZSkAih9AliaV6jSVXFzKWZyH9P5q
 RyDt99UKfKUnKQMDAQGU914NGeG8RTu1WeB0BzZT8gMLQexA6UfljjJto/oasaeMr75jf+aWMsV
 s+A6yLVlwV4olCn9DHxz5t1+ZFUGuw=
X-Google-Smtp-Source: AGHT+IE0kGh1B275owAGX1694KuOIU/nTyKWNcAJNqeKmKgjlEiuU+mjnLGGBdo7lRydxM+9knopwjyKJ/ocn0FOqwI=
X-Received: by 2002:a17:90b:4a:b0:31e:ec02:2297 with SMTP id
 98e67ed59e1d1-324e13d9101mr968036a91.19.1755640998747; Tue, 19 Aug 2025
 15:03:18 -0700 (PDT)
MIME-Version: 1.0
References: <20240627082949.357089-1-sjg@chromium.org>
 <20240627082949.357089-9-sjg@chromium.org>
 <yh7ro6sfsbjh.fsf@twin.sascha.silbe.org>
 <20250818141704.GW124814@bill-the-cat>
 <yh7rjz2z3eae.fsf@brick.sascha.silbe.org>
In-Reply-To: <yh7rjz2z3eae.fsf@brick.sascha.silbe.org>
From: Robert Nelson <robertcnelson@gmail.com>
Date: Tue, 19 Aug 2025 17:02:51 -0500
X-Gm-Features: Ac12FXx2gGdNdiLqIxcnhCqQqB99TrF9FkgNgQxSvJAF71qehhe9YJtnT-lUQgQ
Message-ID: <CAOCHtYgDAjkQNcwQecLgBuk6GqKiEuhhMpxh-W9K-UB=VYvKTA@mail.gmail.com>
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

On Tue, Aug 19, 2025 at 4:52=E2=80=AFAM Sascha Silbe
<sascha-ml-reply-to-2025-3@silbe.org> wrote:
>
> flash-kernel has no way of knowing whether the boot loader used to boot
> will be the stock boot loader or the one shipped in the u-boot-omap
> Debian package (if installed and manually copied to SD card / eMMC by
> the user). Did all BBB rev C boards ship with an U-Boot version that had
> FIT image support? The oldest version I could find on the BBBs I have
> running and reachable via SSH is U-Boot 2015.10-00001-g143c9ee (probably
> shipped in 2017).

Good News, rev C is almost completely out of production!

BeagleBoard finally ran out of NXP tda998x's, so we had to change the
HDMI framer.  (NXP last time buy'ed these pre covid, so
BeagleBoard.org scrapped the barrel finding every last one..)

The newer Rev D, now has an ITE HDMI framer in place of NXP's.

I wish I could tell you exactly what build SeeedStudio placed in the
eMMC, but I'm also waiting for a full (untouched) production board to
show up from a 3rd party shop to personally verify..

It's probably: v2022.04:
https://github.com/beagleboard/u-boot/tree/v2022.04-bbb.io-am335x-am57xx

PS, Debian 13 has a breaking kmod change, so even if you get
flash-kernel to run, update-initramfs will fail. ( kmod.initramfs-hook
forgot about armhf's special abi )..  Here's the diff we are carrying
at Beagle... https://github.com/beagleboard/repos-armhf/commit/d1601faa1c5b=
25628a483eae3f806c4370fd02fa

Regards,

--=20
Robert Nelson
https://rcn-ee.com/
