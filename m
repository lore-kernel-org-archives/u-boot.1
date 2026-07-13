Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92653C43458
	for <u-boot@archiver.kernel.org>; Mon, 13 Jul 2026 13:04:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C93484B2C;
	Mon, 13 Jul 2026 15:04:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JudTD7IK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45D0184B32; Mon, 13 Jul 2026 15:04:35 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5756084AE7
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 15:04:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-69a50b818c8so5135883a12.2
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 06:04:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783947873; cv=none;
 d=google.com; s=arc-20260327;
 b=l3Dd/TtQhpYKrywKmxAbs+4hWyhQM3qZtYb+nEPiP9rcQg1uL/M+MZmPv6whi+xRkf
 JJBZ2IB8bqLrmHCX0LaxQy8XFG5gKbPDomWT9VR25jc6UhwR77RU1E33yANvRS1AuA4V
 ptTSWYfCEPpNq5GKTXlz3rPOoQNpgkFWubuaenbI8qhnnQ9QJbHrECn3iw72qemlMiCI
 Y4pf0zM3Z+SCAe3D8hSMmG5vtJASh5zIQcEqS9vofqgVu05stHKSp/S/jdm+meDGaEMr
 6JZqvsBZPpDx0GmQUpTBnFvVgZL/fuRhSj8tTV3IaTCJZH4d0AH2TOoZWNZGkk47PY/H
 fdPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=jqvCcZS86CV+TZ2GKKzKq3eJiGwLBVt/8AeXKjt+v9g=;
 fh=jnwz153dv0mEWNPP+l0sk86bBHtibaH9LsAOloRTON8=;
 b=iCVb0d3mJXm1skZeoAVnqH+IYgFFFjEuyZ7pGhyb4JIKsAKvVaauTNoeVL4/FsI/M/
 VHr+Jhx65spBPj8VDBz0G5oUEZcOB1mjSEUfFwPqAK+/0Kg2poqzJ8YzU2927n+c37an
 Ceseno+im+hezbxyIwVwLEbAeCjiP2Jj11PTuX5eLGSgNdTm7jiZmNafx35YKrBpql/D
 aEW0IJeWzfluhNT9GHVHdHaU54oDe/ACm4cYB/KKoXYK25WlcFgyxBdrlQWms4j6p/3K
 NTItcoLt1Qstc1ktSIzWR2lzXhhlVQj68AhjXrxJvcqvJi+XSkCuaNGvS7PjKhzL5rpa
 KS7w==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783947873; x=1784552673; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=jqvCcZS86CV+TZ2GKKzKq3eJiGwLBVt/8AeXKjt+v9g=;
 b=JudTD7IKaMpsxcb7+JOYs+vJdCr16zIPX+i5uWri+sJPyppQd732vgLgJfK6d1+6KF
 mvqDgWZDDa7zNCyOciu/kaz0pG001gGXuL61navFvKvOJMSI5HQNZkMWfZKULQqwhc+Y
 S4V/y44HPSnXy2G8j6zcj6LNJHDDKptQpDlVs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783947873; x=1784552673;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jqvCcZS86CV+TZ2GKKzKq3eJiGwLBVt/8AeXKjt+v9g=;
 b=aeMSLtvdJKtWuGG7gYA55WuqHHHvD9eBMTzDUW0uFJpAN7XJbn4zDCHyyCXWk/rT6y
 kE1aBGx3T66Th17HSG/AcEbi2BdTQ38ZMfwG7lnVcf/DZQFPKgJ3l3FNjiqFnC+gJgxj
 ECDkpxGwIOc+ORctNyLIXZWyvCtQwJWFpIr5p3ic+gmLGw6c/CytXXRiB8JUfBxV75Y6
 SGDjLgg0YRF8JwbBlCCSkhDcRXMCZnZfE68K7Xx/yUjB0NYQxvJmTm5frh5luCX8b3a1
 8DEzMdJXI/A4Pfqgrmw+mtEfB1B7Bf0SPB6kVxkcZRQzA3J+CvoOtCIrGmhA9h4vbsrq
 C6Dg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqlHATVUlw60R96IXK6wgcBeoGPuimIos1BEOddx3V6+nwI4JaC4f30w5rHAI3B4RrdM5zmuYg=@lists.denx.de
X-Gm-Message-State: AOJu0Yw2CLkejwf/s10QE7RuuAtZ3EjktJrULbS3oFexWEVtjm37SknQ
 OD/u/T81lC/Hhz+BDwgqnTld+K5aY+6g5i4nOPTRNmjQ93ZIYHzobbBlBsIDxQWH5BZqDQdDxK6
 tcBcR1XiX7yL7AVosY+Kv9BtxT1OpV5OoUnpkimQj
X-Gm-Gg: AfdE7ck5q0IatiCNpLm9heXQE06509Wd8BwpLc2hJctvTgrhU6qYMaZMlwcOPLOF1ub
 wK5GVN6p/IsFS3qOMXj0PrdxqPHvYjhVXjhATwRPtOfkLmGvDnj2+lRb9rC9fWz64Xc+xX7Gb9j
 cS4zpnahBHIT0Ohzo+JyyfH2ZHqvhJjsxuE3EjMYfJ8Jg1htuH2tomVzbNE0dNeklCwXK82hec/
 qu+tzk3hrfJM9ZWeYFFf5GDKTP70fYfu9S4gduaizMupNAZBtgruIGAvAyU7rx8bDtgUnpBLl9B
 K61ipg==
X-Received: by 2002:a05:6402:3546:b0:69a:f82:ccdc with SMTP id
 4fb4d7f45d1cf-69c5f0eafefmr3808505a12.19.1783947872828; Mon, 13 Jul 2026
 06:04:32 -0700 (PDT)
MIME-Version: 1.0
References: <c386c38c-4abf-4ac6-b9a1-a007438c0c5d@gmail.com>
In-Reply-To: <c386c38c-4abf-4ac6-b9a1-a007438c0c5d@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 13 Jul 2026 07:04:21 -0600
X-Gm-Features: AUfX_mzEWf6ZLRcBPv_RWgG-ugg1pYDzuQReApjYbNX7Bxs6tjRNoUlXz47ua1E
Message-ID: <CAFLszTi=2md1KVuwBemVsuU59pxOhaCJ_b2dKnkannRnkgJx8w@mail.gmail.com>
Subject: Re: [PATCH v1] mtd: nand: raw: rockchip_nfc: fix ecc setup
To: jbx6244@gmail.com
Cc: u-boot@0leil.net, kever.yang@rock-chips.com, sjg@chromium.org, 
 dario.binacchi@amarulasolutions.com, michael@amarulasolutions.com, 
 trini@konsulko.com, u-boot@lists.denx.de
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

Hi Johan,

On 2026-07-12T15:56:07, Johan Jonker <jbx6244@gmail.com> wrote:
> mtd: nand: raw: rockchip_nfc: fix ecc setup
>
> The Rockchip boot ROM only checks for nand chip 0 and with
> reduced ecc strength. Currently only the read page functions
> have a condition check added. Fix by adding the same condition
> to all read and write page functions.
>
> The NAND_IS_BOOT_MEDIUM option was introduced more recently
> then this driver. Use it to behave identical with the Linux
> driver.
>
> Fixes: b12dc5d6fa76 ("mtd: nand: NFC drivers for RK3308, RK2928 and other=
s")
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> Tested-by: H=C3=BCseyin BIYIK <boogiepop@gmx.com>
>
> drivers/mtd/nand/raw/rockchip_nfc.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)

> The NAND_IS_BOOT_MEDIUM option was introduced more recently
> then this driver. Use it to behave identical with the Linux
> driver.

Typos: 'then' should be 'than', and 'identical' should be 'identically to'.

> diff --git a/drivers/mtd/nand/raw/rockchip_nfc.c b/drivers/mtd/nand/raw/r=
ockchip_nfc.c
> @@ -624,8 +626,8 @@ static int rk_nfc_read_page_raw(struct mtd_info *mtd,
> -     if ((page < (pages_per_blk * rknand->boot_blks)) &&
> -         nfc->selected_bank =3D=3D 0 &&
> +     if ((chip->options & NAND_IS_BOOT_MEDIUM) &&
> +         (page < (pages_per_blk * rknand->boot_blks)) &&

The commit message only mentions adding the condition to all read and
write page functions, but this patch also drops the existing
selected_bank =3D=3D 0 check from both read functions, so chip-selects
other than 0 on a boot-medium chip now get the boot ROM layout too. I
suspect that is intentional (reads and writes must use the same
layout), but it sits oddly with the first sentence, which stresses
that the boot ROM only checks chip 0. Please can you mention this in
the commit message and explain why it is correct?

These are just wording changes, so:

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
