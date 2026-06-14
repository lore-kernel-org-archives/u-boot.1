Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 550B2CD98D2
	for <u-boot@archiver.kernel.org>; Sun, 14 Jun 2026 12:57:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4F2484105;
	Sun, 14 Jun 2026 14:57:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cAVL7DEN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 70F438484C; Sun, 14 Jun 2026 14:57:07 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88DD083EEF
 for <u-boot@lists.denx.de>; Sun, 14 Jun 2026 14:57:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-68d232ed3f9so3722202a12.0
 for <u-boot@lists.denx.de>; Sun, 14 Jun 2026 05:57:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781441825; cv=none;
 d=google.com; s=arc-20240605;
 b=kZ7Bj6TmoJZuhinLgDiMCYEowV3sXBy+OF4vhQBOmC05ibtjFgKOF+oH0hxEBtjRSq
 HwYA3wdfMj+8UPcJOhoJB44EFKz6Ldt9o6GCmuW/2gfXCI3tpgcYkcAUiLreMjv2gPqI
 ZgoBnrxJdEd+yGvGpqMHdJKLU/7/u3PlZtsGb/J/i5shyBWFQD9p2j0oO/vh3K/SSLk5
 X8Sb34GXtD9x27DX6rYbyZaVFQut8u1dcz5PeUmYf7fhBjngB7tTl2ZjDwcW6ajA7HSK
 Mi1SHBkY7fsS8juja3WluI6fPiH/qQeumZ8BgU5wYZ3ELWQvs3xVDJ5H0/F+OBkN6ef/
 y3Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=FZzzWRRF7bcaPwoxCkH2tBNWYzEQiwDCPfGrc/eyszk=;
 fh=DYMU3dRED0rmVKTDqXRHxrZw93vonVJHh6vC8tHyRiY=;
 b=lKOTu43rfPYkT6PpeKQwOIh/vn9a7Crw33keUca/eEeH5SWkgFitlqCs+Ikk+aHkvm
 yHp3b9ubr87w+XbkvngUzzwP/yhsmEArPujN1OJczaI1QO/BGFj0xg1WZZzYUc93R9Te
 U60sMzcaOAKHpZ8aO3BTikLY0CcnNyfNkvp7WYZlFITadvQD8/hc4Q4QV+GxlEigtcze
 h5f0w+TKg1x6eLIP+TFZEBCDny7Xxpm4lMBrqw8hvjdOB2yv21FpulokwWrnY9HUwXJX
 ajpInpl/uRssyiq8t4hTR3KcNTBtfQ2Eyamqctn6AJNn2wlP9x5hLS1nqEYiNV4ai8Sh
 XRJw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1781441825; x=1782046625; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FZzzWRRF7bcaPwoxCkH2tBNWYzEQiwDCPfGrc/eyszk=;
 b=cAVL7DENAEqe8er1bqDNag975za4YBg6PTosM9vMselD4JWXA8tMRmgZlCna36BsXK
 87pqq5NJUvnOor/tr3ezkRRRnxiiVzjwtyJJpqTTvpcpA5aI0c2qdhuQBlmlxCE7F9Gy
 w7/4fHoCzMnAbi1WKmBiP8SrS1n36sVqzk5w4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781441825; x=1782046625;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FZzzWRRF7bcaPwoxCkH2tBNWYzEQiwDCPfGrc/eyszk=;
 b=pDFSc79MXppKF2gk8hONCG7nrwcfC93/9fNJaqzhBoGc0ayiVX7HEgNnXOEAKf4u0N
 aUAz8krGxkYxE84FpK/0uy/tPLNttZyXsuUJECyCnRTYQZt1Z3XY9LmUiYB0bYkRKGmd
 e0B2ea0KDhtUZYlxE3/ph3qKkC455/B83LGvzY26TgCO6S3ajjVCWXmgzS7BjtvihUAt
 16DjxM+qtU+UIfcJUdk05pJqxzGGAD2BMJqhVF6Iv2R3pc5HG7Ezvdr2jbaMjgy+JCHS
 hF+FxwtG+cc05mMfPyjBKL0jVIQts9dPp51JuHuHbwoKXEXlg2iNNMpgLvlE+0V4XMsX
 aaAw==
X-Gm-Message-State: AOJu0Yzl9e9zvh6gawH/4//Tn81Kez9ViE1imQ/PS8nLDLw+QbAmlAW8
 /pG3NDqB+dHcFQ4f0/OyWUmEE7Mhl+b7kkUXddSDNuNwSkc/24WE3DCV/0cewGrJnhuYq+KTC+1
 DP0bz/KwJnAcC9C2PGfPQ2XR/opTcZAzC3OTakQTF
X-Gm-Gg: Acq92OGrYmbkmRCeVQefB0IY81eEwn9v10/Tc8ZAPBEODeazLBmd4pNeo7/oCdxcIUe
 LUz67xbvwy89laCp9LmyEjCXBuqC7MjMvxPkFq6YTK4ZQfJIJUIfFnjTOyFdU30/W2dDqGVTLRG
 JpQd6aG7aB0/+XWPZrRY4WNGEDI+0sAqADTWm0tjDm1DTF21cO/OksmBrKkSV72hUcY00QHP7qv
 N+mVAfWEt++ls134LA6QpoL1VrN+MmBWwQyL2HIPJ4m3yrx/KhczBaMk7pyXjc8XR1RRQElWOjE
 8hqonA==
X-Received: by 2002:a05:6402:26d1:b0:691:affa:38bd with SMTP id
 4fb4d7f45d1cf-693784f7effmr4474113a12.3.1781441824986; Sun, 14 Jun 2026
 05:57:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260611014843.3735672-1-dmukhin@ford.com>
 <20260611014843.3735672-3-dmukhin@ford.com>
In-Reply-To: <20260611014843.3735672-3-dmukhin@ford.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 14 Jun 2026 06:56:52 -0600
X-Gm-Features: AVVi8CdIvnjh8FmqsJMi3iADVKdz24oJtRaH140Icvu0WcPk2eI5dvxR85lqoiM
Message-ID: <CAFLszThi8ZK=FXjL9psgKDHWPciRUiPCq1m3SfF48WDD6YpcLQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] bootdev: scan boot devices at each priority level
To: dmukhin@ford.com
Cc: u-boot@lists.denx.de, sjg@chromium.org, trini@konsulko.com
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

Hi Denis,

On 2026-06-11T01:48:41, None <dmukhin@ford.com> wrote:
> bootdev: scan boot devices at each priority level
>
> Currently, default 'bootflow scan -lb' will stop booting the board
> if any of high-level priority bootdevs cannot be hunted even if there

I think you mean 'higher-priority bootdevs fail to be hunted'.

> are bootdevs of lower priority.
>
> For example, if board has both NVMe (priority 4) and USB MSD devices
> (priority 5), and if NVMe bootdev hunt fails (in an event of bad NVMe
> firmware update), USB (may be recovery bootdev) is never hunted
> automatically, leaving the board in U-Boot prompt (user intervention
> is needed, e.g. something like 'bootflow scan usb' to hunt USB).
>
> Fix bootdev_next_prio() to scan bootdevs at the lower priority level
> by not exiting the scan loop early.
>
> Signed-off-by: Denis Mukhin <dmukhin@ford.com>
>
> boot/bootdev-uclass.c | 2 --
>  1 file changed, 2 deletions(-)

> diff --git a/boot/bootdev-uclass.c b/boot/bootdev-uclass.c
> @@ -669,8 +669,6 @@ int bootdev_next_prio(struct bootflow_iter *iter, struct udevice **devp)
>                                                       BOOTFLOWIF_SHOW);
>                               log_debug("- bootdev_hunt_prio() ret %d\n",
>                                         ret);
> -                             if (ret)
> -                                     return log_msg_ret('hun', ret);
>                       }
>               } else {
>                       ret = device_probe(dev);

The fix looks right - we can probably rely on the failing subsystem to
print a suitable message.

Regards,
Simon
