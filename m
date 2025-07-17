Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF7D6C83F1A
	for <u-boot@archiver.kernel.org>; Thu, 17 Jul 2025 13:24:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 18B20833D7;
	Thu, 17 Jul 2025 15:24:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=northern.tech
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=northern.tech header.i=@northern.tech header.b="O7t5e+fb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A34E583390; Thu, 17 Jul 2025 11:27:45 +0200 (CEST)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EFB538334A
 for <u-boot@lists.denx.de>; Thu, 17 Jul 2025 11:27:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=northern.tech
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=josef.holzmayr@northern.tech
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-32b4dc9be5eso1005081fa.0
 for <u-boot@lists.denx.de>; Thu, 17 Jul 2025 02:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=northern.tech; s=google; t=1752744461; x=1753349261; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3cg8bSc+hxhTlhM9+VRGxLi+1Js+1ulsvEmPTd04aLM=;
 b=O7t5e+fbGuwd3Y/H6kiPfWY2ZEgAHd+UXBzSaO1JRGXsws3cg1+fF16pukx8T1OcBk
 geOZEt87iApS21Cc/6DOGwWiV9GEUp3OR/782i6vZyFafv6xXWiXT6Lq+lcm93w55/pU
 XnrqQxLKf2sjzncq/Ds2dFdePBjz+wgE2QXeWcLL6y7BACJ+4rfRwtvq7z8/ZmHdU/BJ
 AC4ThYZiOJk45+n1NTX9Fu7ug6KS3ToYO1mkr1/ubCHC9/xXYI7I46x6VDOqyPfspLVm
 qPhe9sI9FlLqv7YiRcv4/W7AJAzQ+ypNfdiL1hgLuEfVwD2+wdg0dw9oSKrUID0P4nTr
 C18g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752744461; x=1753349261;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3cg8bSc+hxhTlhM9+VRGxLi+1Js+1ulsvEmPTd04aLM=;
 b=vp/gqC7Kfodpp+YJquezGDgSjbrA1XuAmiBdvqPbqGCRGNpTi9T1ohbti5vI2CrPcW
 WD/LxU0yXl8V0rztlxUJ7nd4EFngZbWtJY2dPmCfS0n0anOnwEg8AYyYdISVi8fEH3A2
 dWI0v8oYWXNJ8TrdctmHPcg8q2ZNydpSMxL118oyJc3gLVENPdCbu+ibAS1oKhzJpzCT
 3pQm9zJ3M69oqFlp4qVVRoWgds/DQPMePj24vc2KpIOWeV8WrNIozjaM2N2eAQee9KYX
 JeGpEWUmoYDyuDqK13jdIxiuuw5XXTQ73vs92EmAjDYiM7CVL5q1taN6LraLsLDeYiUc
 S3RQ==
X-Gm-Message-State: AOJu0YwolJ80bNzB04yu/dbiB+0edwc0MemroP3kAffVQ4UhgPnj0uMN
 8GbTZJcXv8OIHSqjiJ/zZIjI3HVt6IHMc1jE6uXp76Xgk2EoIwiMkRxYz2u2GYlOkRZnmYZXjmO
 XdkorvBe+rM/EdmlT14zHksf6I5WEhaEjqccHD7+cfZ4SMp+8CcFv5v7XSHqsQTNp5AmAZp0RDO
 z8zEJFt1plIVQoKocltdoubW9cJKwHfs8p
X-Gm-Gg: ASbGnctMDhkvQBbWcZ6e53pFYir6VdDe50juZju2dkijLI3QxPsLyKAwtys3+ZBPMPO
 aPwrTKHOgm3e+skIU5xixiKby//DJZfURGutpMjlilfKpf/e7qXTXMxO8gIkUO8/Ck5O5nZKphX
 p6ibvFRtzBsvI2pQ4tds6KGBN2BCOEd/HmuIUOKU9UPyssyyMGI/0ugtFkG+Fs/NcC1YuGgx++7
 ekP3Q==
X-Google-Smtp-Source: AGHT+IHP0ehqMTs8WZS3KHKO6shf6d0FBF2d8McxTKcYxysEyRHvEKm5XgexIwkOPcDZgz+X3ZIklV3vT+ds84Omb6M=
X-Received: by 2002:a05:6512:1450:20b0:553:50c9:c8a9 with SMTP id
 2adb3069b0e04-55a233586a8mr503149e87.8.1752744461063; Thu, 17 Jul 2025
 02:27:41 -0700 (PDT)
MIME-Version: 1.0
References: <20250712185227.17100-1-kettenis@openbsd.org>
 <175270411042.2648161.17574452616601901369.b4-ty@konsulko.com>
In-Reply-To: <175270411042.2648161.17574452616601901369.b4-ty@konsulko.com>
From: Josef Holzmayr <josef.holzmayr@northern.tech>
Date: Thu, 17 Jul 2025 11:27:28 +0200
X-Gm-Features: Ac12FXymk1mp9DXL7mcHYtnHPmEjDcL5SaAq3-hYSa7RnJ56midN8jGKxe15Fs0
Message-ID: <CA+AKJpHxRGD6Bvdv8FmC4_mn94nUjU6N2X5wivyBRpzQ_x0Zvw@mail.gmail.com>
Subject: Re: [PATCH] board: vexpress_ca9x4: Enable D-cache and MMU
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Mark Kettenis <kettenis@openbsd.org>,
 liviu.dudau@foss.arm.com
X-Mailman-Approved-At: Thu, 17 Jul 2025 15:24:12 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Thanks Mark and Tom!

Just so I understand it correctly, this patch means that after the next
u-boot release we can continue to use the  vexpress-ca9 emulation as long
as we also make sure QEMU is current? If so, do you happen to know which
minimum version would apply?

Greetz,
*Josef Holzmayr* (he/him)
Developer Enablement Expert
Mender <https://mender.io/> | GitHub
<https://github.com/theyoctojester> | Mender
Hub <https://hub.mender.io>
<https://www.linkedin.com/company/northern.tech>
<https://twitter.com/northerntechhq> <https://northern.tech> Northern.tech
<https://northern.tech> | Securing the world's connected devices


On Thu, Jul 17, 2025 at 12:15=E2=80=AFAM Tom Rini <trini@konsulko.com> wrot=
e:

> On Sat, 12 Jul 2025 20:52:27 +0200, Mark Kettenis wrote:
>
> > Enable the D-cache, which will also enable the MMU.  The latter
> > make sure we don't do unaligned access on Strongly-ordered memory,
> > which has UNPREDICTABLE behaviour according the architecture
> > definition.  This fixes using U-Boot with recent versions of
> > QEMU's vexpress-ca9 emulation.
> >
> >
> > [...]
>
> Applied to u-boot/master, thanks!
>
> [1/1] board: vexpress_ca9x4: Enable D-cache and MMU
>       commit: 3b4604a40b9fd61b87e9d059fc56f04d36f1a380
> --
> Tom
>
>
>
