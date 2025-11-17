Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EDF8CEACEF
	for <u-boot@archiver.kernel.org>; Mon, 17 Nov 2025 11:35:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5ED8583A8F;
	Mon, 17 Nov 2025 12:35:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="txCgr/Ip";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D05783AEF; Mon, 17 Nov 2025 12:35:47 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADE2C83A79
 for <u-boot@lists.denx.de>; Mon, 17 Nov 2025 12:35:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 0A59C43A74;
 Mon, 17 Nov 2025 11:35:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09A0DC19424;
 Mon, 17 Nov 2025 11:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1763379342;
 bh=errEPKmVU443T87zDll2uDD86YwWxTF8l3+UlW0p45M=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=txCgr/IpstNi67SKdKEwwnWUprbQ5OdZS6LHyPxhOxYhsQITQudV6XkoFskqgS68p
 Jp1rUJLWFDBHqzQCkgn3d91Un1RrIA5ghZaDF7xXm37fj+Hk0U7s4MEu+AjzG/rWoc
 JKAC2a870swoYnR638EVMMdAfSFm2+j6ogbYX9X8TuTUBlNZq4h3i4ZTb/r/F4d6Sm
 ybBCD8F/Kxl8k1WrBUl26zuIf9D3DwMuVPjOLh6YNXyk9lN5C0mad/xZjBGXj3js6V
 4ZA8rEAvV27yCLI++hS2rbM22jvFcpqQja+D/xYIBJ4wJ9AaTnN+lkiXNs8pB6whjx
 LdFXQrfZKKzxw==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Marek Vasut <marek.vasut@mailbox.org>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de,
 Aaron Kling <webgeek1234@gmail.com>, Eddie Kovsky <ekovsky@redhat.com>,
 George Chan <gchan9527@gmail.com>, Julien Masson <jmasson@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Nicolas Belin
 <nbelin@baylibre.com>, Sam Day <me@samcday.com>
Subject: Re: [PATCH 1/2] boot: android: Always use 8-byte aligned DT with
 libfdt
In-Reply-To: <385cdc16-cf73-443b-a0a1-440e233d4506@mailbox.org>
References: <20251112011717.360045-1-marek.vasut+renesas@mailbox.org>
 <CAFLszTjofjQ_zmwJrGZ-sLejQ=x=-8tyqr4SBPYgt3683GVAbQ@mail.gmail.com>
 <20251113193816.GP6688@bill-the-cat>
 <CAFLszTjwpoCwCKKvJX5cZMLK480EK-=BWaFd5A6yLMrfsVWC6g@mail.gmail.com>
 <20251113200527.GQ6688@bill-the-cat>
 <CAFLszTjydNqmo=6qLv--m4fB07QzWd01XHGY3hxgTEbarJF-VA@mail.gmail.com>
 <20251113203654.GR6688@bill-the-cat>
 <385cdc16-cf73-443b-a0a1-440e233d4506@mailbox.org>
Date: Mon, 17 Nov 2025 12:35:38 +0100
Message-ID: <875xb828ol.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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

On Thu, Nov 13, 2025 at 22:42, Marek Vasut <marek.vasut@mailbox.org> wrote:

> On 11/13/25 9:36 PM, Tom Rini wrote:
>
> Hello everyone,
>
>>>> Which is different from disagreeing with your specific feedback about
>>>> how we get there, to be clear.
>> 
>> And again, since your feedback to this patch was "Don't?", I'm saying we
>> need to. But the rest of your feedback was structural on moving towards
>> resolving it and so I assume Marek will respond.
>
> The "blast radius" are these patches, that's all that tripped the tests:
>
>   - boot: android: Always use 8-byte aligned DT with libfdt
>   - test/py: android: Point fdt command to aligned addresses
>   - test/py: Use aligned address for overlays in 'extension' test
>   - sandbox: Fix DT compiler address warnings in sandbox DTs
>   - sandbox: Fix DT compiler pin warnings in sandbox DTs
>   - boot: Assure FDT is always at 8-byte aligned address
>   - arm: qemu: Eliminate fdt_high and initrd_high misuse
>   - efi_loader: Assure fitImage from capsule is used from 8-byte aligned 
> address
>   - MIPS: Assure end of U-Boot is at 8-byte aligned offset
>
> Regarding last minute alignment, the problem with this android image 
> seems to be in the android image itself, which packs in badly aligned 
> FDT. We therefore have to copy it out and realign.

Yes, the Android tools do not handle alignment by default. This is
stated in the Android docs [1].

Also see [2] on how a boot.img is usually structured.

In any case, if DT spec mandates alignement, I think it's good to
enforce the spec in the code.

[1] https://source.android.com/docs/core/architecture/dto/partitions#cfg-create
[2] https://source.android.com/docs/core/architecture/dto

>
> -- 
> Best regards,
> Marek Vasut
