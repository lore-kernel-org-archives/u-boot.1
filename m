Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90E21CD98F0
	for <u-boot@archiver.kernel.org>; Thu, 13 Nov 2025 21:57:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D77F84057;
	Thu, 13 Nov 2025 22:57:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="qpKnYG27";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="VUZh+TIw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E4A2B84053; Thu, 13 Nov 2025 22:57:47 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD95583FFC
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 22:57:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4d6vJm5sh4z9v5v;
 Thu, 13 Nov 2025 22:57:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763071064;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ax8ivT25HxHS9ptWfOu/TLFxRdV6qC2lXeraBWMFJQU=;
 b=qpKnYG27zAkZFvcgtKqq+qhOvZJPqsHDrIqc70Wm9DZZU5iBVJTsZDFsmWyBSVzDnzknYe
 XY+DhuOeyT/s1eamP1eCwxgay9BMgTNnDomXmgd2/yUOSqEjhMyvNLE3FSulgxVXFFib6Y
 IVQrWovP2Eo9BScMow+ry4C4xB7wsRlXSxMkXlc9QIILOycmVfONT4IjkUvWuBHjZkkfxY
 9wyNr4mScHlb++YoV9zokea638Rkyu4tdPgu5McUCl/MVF5E6jxjbEYaV725V1SWxiZ3tB
 JCmrY2O13apjXrLTQYNwpFF/4IuvlgXxkM99QksAj6emYViwY+/r6zlLsCJ7Cg==
Message-ID: <385cdc16-cf73-443b-a0a1-440e233d4506@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763071063;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ax8ivT25HxHS9ptWfOu/TLFxRdV6qC2lXeraBWMFJQU=;
 b=VUZh+TIwqbLGP/QUO6DhQlOu01Ss6nfgvwrcinz9UwhGGnFkishKd3BEGcFgVLPeTjSNlF
 68KFPWtiZOKXJBKFKlK237HphUZH1eEvB+rE1f2LlL5T8juIfIYTptL6BYq3/+ZxYQgdaH
 p4jI2fjHKOtWyC9BfhZiTjiNQ6t9oL8oAEU/5eGeDgC1p/tDkO9aVMWdUQA5jyoEf8TM9K
 iobVuZDahr6kr+liD+xIrTIWww5MRUcxCnG4f/fcpZKWHGsEHbfDeY+9JKH7bMh8bPTPGY
 Pg64oljbKTNZ0FV3SN7gtLtp7ZSoW+YfpJy+eyr/cM/bJC3j0h6Zswq0DRb7oA==
Date: Thu, 13 Nov 2025 22:42:17 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] boot: android: Always use 8-byte aligned DT with
 libfdt
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de,
 Aaron Kling <webgeek1234@gmail.com>, Eddie Kovsky <ekovsky@redhat.com>,
 George Chan <gchan9527@gmail.com>, Julien Masson <jmasson@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Nicolas Belin <nbelin@baylibre.com>, Sam Day <me@samcday.com>
References: <20251112011717.360045-1-marek.vasut+renesas@mailbox.org>
 <CAFLszTjofjQ_zmwJrGZ-sLejQ=x=-8tyqr4SBPYgt3683GVAbQ@mail.gmail.com>
 <20251113193816.GP6688@bill-the-cat>
 <CAFLszTjwpoCwCKKvJX5cZMLK480EK-=BWaFd5A6yLMrfsVWC6g@mail.gmail.com>
 <20251113200527.GQ6688@bill-the-cat>
 <CAFLszTjydNqmo=6qLv--m4fB07QzWd01XHGY3hxgTEbarJF-VA@mail.gmail.com>
 <20251113203654.GR6688@bill-the-cat>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20251113203654.GR6688@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 15df9ee514a9daa1899
X-MBO-RS-META: 4hx1cd5r5bxaapcyiwirh7pgih89nezs
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

On 11/13/25 9:36 PM, Tom Rini wrote:

Hello everyone,

>>> Which is different from disagreeing with your specific feedback about
>>> how we get there, to be clear.
> 
> And again, since your feedback to this patch was "Don't?", I'm saying we
> need to. But the rest of your feedback was structural on moving towards
> resolving it and so I assume Marek will respond.

The "blast radius" are these patches, that's all that tripped the tests:

  - boot: android: Always use 8-byte aligned DT with libfdt
  - test/py: android: Point fdt command to aligned addresses
  - test/py: Use aligned address for overlays in 'extension' test
  - sandbox: Fix DT compiler address warnings in sandbox DTs
  - sandbox: Fix DT compiler pin warnings in sandbox DTs
  - boot: Assure FDT is always at 8-byte aligned address
  - arm: qemu: Eliminate fdt_high and initrd_high misuse
  - efi_loader: Assure fitImage from capsule is used from 8-byte aligned 
address
  - MIPS: Assure end of U-Boot is at 8-byte aligned offset

Regarding last minute alignment, the problem with this android image 
seems to be in the android image itself, which packs in badly aligned 
FDT. We therefore have to copy it out and realign.

-- 
Best regards,
Marek Vasut
