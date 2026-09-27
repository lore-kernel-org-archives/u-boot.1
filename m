Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BD85C9832F
	for <u-boot@archiver.kernel.org>; Sun, 27 Sep 2026 15:08:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 00B79810B5;
	Sun, 27 Sep 2026 15:08:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AN8k3tFqk5QB; Sun, 27 Sep 2026 15:08:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 241898104C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790521713;
	b=okkKy2AuinTLWzaRF/10P0/haIBRod5RuI2xiSc9nAb9vECAZ+hhK7H7owYPNzTkf/KC
	 5ez341JqYlAXsqirHeAXRLHjooLvvjzYeY251MyLWz+LwTkn8TeLOZW6Tuh+jIewW9RWz
	 UkyH1WlxSZs+2gqQEWws2YNEmjol3FG1K+9zkdsnRnUrme0jw94V1efMEdRQhB43exF6X
	 UNQaMmME39Yqk0/OxUz0uFJvXlx4nvJZ+NAs908Hdf+amZUEen45acfW6yoC/KmMz/kGp
	 m14fenD777ClXiINLHmsi6QGdbdbBirh6u6FuP0QmKpUjwXfUORurePUCzNr6X1ZA2g==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790521713;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ez6kJvIFe2zaWspUD1XLe1bFTxtGe7OOaj2RNFdGl6Q=;
	b=KKZLWYvzf8lgY4ytdZiWdrFDoQNCwhxJhm7D7nuUkaGqLysQJFNgkb3G3wUZeOrYtijb
	 o5GMWYxRsoMbPQLkz6uGfGU8slNDJ+Kk9GQ330r6OPzxODfy2pckrgkjF61jJGljTBwLk
	 xVD1qQrYOeV8aZYD3HbD6aIdGT5aJypCRrQJxF+hP2crSCfCMs2mJHEz4/V38uljfRqOq
	 33DNyTOR1CDrAP9xaMLk9dgbCG0zCCT9YT15gNedOMDEWM7HzgYsy3QbiBJj9S9kBMati
	 lYimBARi74K6KtB4WuGS3yCyf+huWI2/YcHCWwpwvuJldfOLUOAWuSCYZmZy95hWBag==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790521713;
	bh=ez6kJvIFe2zaWspUD1XLe1bFTxtGe7OOaj2RNFdGl6Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=C0MuFitwwhEbQY/6DIbAOV5X9XbgzQN6PmfkPhHUWCRefl0Zf4fjBjxdfu2WZv3Cn
	 k3hCaGjB6eC/r/p5IaZM+KLjSFR6aWZ0hLfjEaC0aqBT2/6vnyI19O83hDHKgu56zP
	 X65Z8kQug9fS5totRNEDAnga4OY6z7Qm5+dcobd21QmsbEG3gDkiIafCjnv0IeG8Be
	 8uKb/K3LCm6ioPaosX9W+cvkIZwOutCNJmIs8xRdV42uLZ5OihLgJ6SgN6IRg8mgJe
	 5Yf6hIaeUWSiq1zDOPgDPJJdTRW7VZkwBWquN/fJAj2PjAkOrehnmPlYSktGHMzpnM
	 eEliiYT/ZkBXA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 241898104C;
	Sun, 27 Sep 2026 15:08:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 57415329
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 15:08:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 482AA606B9
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 15:08:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tXO9hOatYHBp for <u-boot@lists.u-boot-project.org>;
 Sun, 27 Sep 2026 15:08:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 466F2606B1
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:33::d"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790521710;
 b=pzPO4+fKgi0Mr/2mfK9PoOz2HTwMdDIawxCmynfQjzHkjwySFmfsny2ALCX3zDlU+Na2
 DDRx/do4EeDGcE1OwiP9HpD0p2pwK7NSnk6qvgNpUcdnkMEsmw6NLStsYfXVxLhK68DNq
 a6/NeGu2uaakTpXsWvF6MOmygnOpmGxD6hk3e7dmeHJBdfNGaNdMOHRWEUWYhtbH4HeA3
 Ms5yEIjrjrofHR4QvThB2Hcy5gcZOc3ae2c602cb38aIB8WCi38ZxdqD/oLrtB0C9Ii5/
 gmKyLCGCR6lEqOToxrWdiU7lU3YXu53iW1eSPUtvYxghqrLlMNOjCNLM+RL0fsRN5Yg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790521710;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=ez6kJvIFe2zaWspUD1XLe1bFTxtGe7OOaj2RNFdGl6Q=;
 b=eqTOLK+cZZN3C63swGnD4e0Uph87CRjFlSmcSrmaNbZ6Cjo7Wpo5eUPM/UeBG3J+qUwt
 aXii7RK0tjlQLx5tZiYKomCzJ238ZpOBhifVItGUluP7vj3SGdE51XcBZnkBH621HEg2J
 TlcrojYLTxMU4bVc5ll151VkuECpFAzmtXKHtQsJmBLmGckKiwoC5/DFXGkZgdYjitxA7
 4ctZ0KU8oiTZQEqqja0K+np1IC+y0XVA1UjM2Ry3a8L8/zC/csGtQKbaWjZWq6GIpnPYo
 TiKDYYVAlwE/QINXvbDmjjVVGNyw4rTdmy05/w0umY92QbtmsRR43sKq6YhJPoTAkbA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=V4cIWkQE; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:33::d"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:33::d;
 helo=mail-ed2-x0d.google.com; envelope-from=sjg@chromium.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=V4cIWkQE
Received: from mail-ed2-x0d.google.com (mail-ed2-x0d.google.com
 [IPv6:2a00:1450:4864:33::d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 466F2606B1
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 15:08:29 +0000 (UTC)
Received: by mail-ed2-x0d.google.com with SMTP id
 4fb4d7f45d1cf-6ac62c88c7cso1120945a12.0
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 08:08:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790521708; cv=none;
 d=google.com; s=arc-20260327;
 b=rsc4uJmXcukOvYFzJ1ijz4/ifYFM5gLfeXc7SXy+gXO61iC6usrRGmuHFsuC7PIYTn
 rbOMWgE8j3lvOv3TzLAflYStQ7nMikPpxqJZS4sCjypDgS/0lE2rI6x+wFl0mptmUbf3
 URsBkUuhQhTMdlOAxXgo1ncJxmGSHvWDMNuv0LHaRuao/7FuQlIXabJMg+qSyIrI+aZA
 +S/kdvJhL+FooUdXla/z9spirEgtwLXubpOkOx0bUARqLNkwRPFXeT1OKEegkmKop0I7
 puMEGnVTdXr1oGkdelOuyM79k0YnP97bieXvsr2Fz8n5mOkw4ym1a4V1p1k9H1H5X3li
 OZ3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ez6kJvIFe2zaWspUD1XLe1bFTxtGe7OOaj2RNFdGl6Q=;
 fh=xA3QUIufGSObllNJe3KRPsCc/uVVnPJKVcxH2m7KdZ0=;
 b=IxL+5u9JfkkTn9VSaB2z6pQVTjsfJHsGRwpz/z8USIYMQ2NWIUPSU0AcBOweJ/H1NV
 0GDALZl0TnUv++WHTIbgrpynaWfN8qh90KxJ9eGKDQZMfpMFQC1LaLTWtQS3cTejca6K
 tnpPYdr3CXdPMbTbfhpX08ivlM6IehL3ASEwqdTn4kuk3l55ooQfe7sx5Aibdo9VJJg/
 RPFZf+NTSMGQtuD1kiQQPol1//Whhuh+ARpC2BZ/PBKNn8Dev96dszzAmQsjDjqqqCNx
 frlbR6TdQ14bDKC9tQogu/Aoceuytj+Be2oJrOehzGyyJfWWmG+YHz5mSEta+nrPTZAU
 JRqA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1790521708; x=1791126508;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ez6kJvIFe2zaWspUD1XLe1bFTxtGe7OOaj2RNFdGl6Q=;
 b=V4cIWkQEa4By25S1kyESucWXaLaXSH5jotoIGlF78ON7xzIdQIc4R+fl64rIXNkwHR
 KpEgtAzctuAeC+JYyDvyJFZ2bl+Q2Rav9bLqziikKKQTNGcrc/CZktTzEIq9kSoEhEmv
 9X/cHlOvRqS/fea+i5LhLFca5x23kIkqfoD/4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790521708; x=1791126508;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ez6kJvIFe2zaWspUD1XLe1bFTxtGe7OOaj2RNFdGl6Q=;
 b=s/Qb5isaEnDRLwNLANsGgsnP0cfT9+M4HALhaev/gE07dB5HhgNP205ttF5Pi5zko3
 e0OzcCH4p6XR3lluZ+KJnBdMq+8eWy+AxL2q8810ZxpD22Byrn8M5G9OpijvYNcZU68l
 WVd9T31ccNiPxxUOBhAoX6cNxMvs+QqcOutgRZpd3f1mxyaYR2J7t+qmHs4sGjYk/Vpn
 eEiMFQDJAm2m8HbMKp5fv65/eUZN7pG+cCarmNyw+4PsWYe65TWdWKsdh1ZTH/mxpbay
 GP+jj3jDHKCpASJY5nDQYbPQdEFVKAIjnnnWpta2mAmL+rg3gQBplDW0204cCFmCcF6C
 gVjg==
X-Gm-Message-State: AFq9FYK5MsHcvQGXI2+kQHQt4WvCnLLGAoHLJUTEaIENoVv4wTRCcqFy
 t6D8lVohW9JaJYW40cb4Vx7rzRbhyNmOwssvKJbzZ5fQd5B/sw5HllBwPp0UD0WJiewwvDfOHVj
 uwHGjdTG/b+zYVJNJUJQj6YJaNnUHebBXq/HzHp66
X-Gm-Gg: AYBFou1/EHNd6Aaq9N3NkDw9/nclqBmzYYZy+RNelvI84m66ELj/nijBiOW6lx/u7mo
 /R6mH1OamR8n1z5kgA/tHiCwpmiwdSPZRFhbmY2EuGLSa9KAmQkUijif/soqx5v9opZ/PXMUXwl
 Avrn/rN/9nrqQ3SHf38IW/I4+/U7PnRQpMEpaHtEhdFBcuvjJJaEojy+kqVY3canjpNmQrHy6bL
 3ZuNmdiyd03+6HwJqYbGX7a1ViWqN9dlFaK3XlKNj+ceM8+oyvcraNLTL38FnzoxNCJfye8v4J6
 OkSVMwIjxJMwLQy/xc8Kyi5GS7QZsIP+TuNbJgxdshQM7v1BWxW3GRuZEBHpIQWx
X-Received: by 2002:a05:6402:3806:b0:6a9:df42:8cba with SMTP id
 4fb4d7f45d1cf-6aae8f3906amr5678822a12.32.1790521707877; Sun, 27 Sep 2026
 08:08:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260925105432.0F27E68C4E@verein.lst.de>
In-Reply-To: <20260925105432.0F27E68C4E@verein.lst.de>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 27 Sep 2026 09:08:16 -0600
X-Gm-Features: AclHuK_pdUYq7jXcdcD5il7Gq6HYpCRqVaI_NmjBvV7WLkQOX6HrC-TaVnEWYFU
Message-ID: <CAFLszTgrRsqbPgi2SY51mF3o-bd7fgJn7KkpVtD1OJ_kV4s9YA@mail.gmail.com>
Subject: Re: [0/8] Almost complete Raspberry Pi 5 support
To: duwe@lst.de
Cc: u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Torsten,

On 2026-09-25T10:54:32, Torsten Duwe <duwe@lst.de> wrote:

> The next three patches are simply the RP1 components for their
> respective subsystems; and then I pick up Volodymyr's idea to use
> board_late_init to stitch RP1 and PCIe together. In the long run, it
> might turn out necessary to enhance U-Boot's probing architecture to
> handle alternating cycles of device tree and PCI probed devices in
> general.

Thanks for putting this together! I'm really looking forward to having
U-Boot fully functional on this board. When I run it on rpi5 I see:

...
PCIe BRCM: link down
PCIe BRCM: link up, 5.0 Gbps x4 (!SSC)
Net:   No ethernet found.

PCIe BRCM: link down
starting USB...
USB XHCI 1.10
USB XHCI 1.10
USB DWC2
Resetting EP 0...
Resetting EP 3...
WARN endpoint is halted
Resetting EP 2...
WARN endpoint is halted
Resetting EP 3...
WARN endpoint is halted
Resetting EP 0...
Resetting EP 3...
WARN endpoint is halted
Resetting EP 2...
WARN endpoint is halted
Resetting EP 3...
WARN endpoint is halted
Resetting EP 0...
Resetting EP 3...
WARN endpoint is halted
Resetting EP 2...
WARN endpoint is halted
Resetting EP 3...
WARN endpoint is halted
Resetting EP 0...
Resetting EP 3...
WARN endpoint is halted
Resetting EP 2...
WARN endpoint is halted
Resetting EP 3...
WARN endpoint is halted
Resetting EP 0...
Resetting EP 3...
WARN endpoint is halted
Resetting EP 2...
WARN endpoint is halted
Resetting EP 3...
WARN endpoint is halted
 ** fs_devread read error - block
Bus usb@200000: 2 USB Device(s) found
Bus usb@300000: 2 USB Device(s) found
Bus usb@480000: 1 USB Device(s) found
       scanning usb for storage devices... 2 Storage Device(s) found
Hit any key to stop autoboot: 0
U-Boot> nvme scan
U-Boot> nvme detail
U-Boot> usb stor
  Device 0: Vendor: USB      Rev: 1100 Prod: Flash Disk
            Type: Removable Hard Disk
            Capacity: 30720.0 MB = 30.0 GB (62914560 x 512)
  Device 1: Vendor:  USB Rev: 1.00 Prod:  SanDisk 3.2Gen1
            Type: Removable Hard Disk
            Capacity: 29358.0 MB = 28.6 GB (60125184 x 512)
U-Boot>

So it seems that my S2Pi + NVMw is not detected? Which board are you using here?

Also, I'm not sure if you see the warnings/resetting messages above?

> mfd: add support for RPi5 RP1 chip MFD

The patch order feels backwards - the MFD is the parent that carries
the PCI IDs and instantiates the clk and gpio children, yet it lands
as patch 6, after its children in patches 4 and 5. Please reorder so
the MFD comes first, followed by clk and gpio, then the
board_late_init glue if needed. That also makes each intermediate
state easier to bisect.

Also it would be good to mention in doc/board/broadcom/raspberrypi.rst
mentions that NVMe, RP1 GPIO and USB now work on RPi5, or what is
still missing (network boot).

Regards,
Simon
