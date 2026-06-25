Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2795CDE001
	for <u-boot@archiver.kernel.org>; Thu, 25 Jun 2026 14:38:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 796068495B;
	Thu, 25 Jun 2026 16:38:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="X2xOutxo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE0BC8495B; Thu, 25 Jun 2026 16:38:53 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B700584704
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 16:38:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-bec423a5265so515334866b.1
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 07:38:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782398330; cv=none;
 d=google.com; s=arc-20260327;
 b=qLVCnP8VMzNKGY/EbSOm8Iovm22OgEMmPJy3XT2qYQobMy/PRECLNIf+rmPHI068c7
 7llLODLUuK/zLO8vSnf/JW8HiDeerbmEdI2W1/qWJrxMk0/8yQFXWCsN0UK0M99eLyrF
 SD192Y6Ssmq8s1lN4M1Uh0QJHTAWe8BP2NN2aKU5rkqBH3GwVopk0QK+Yr+O/cIHRwPR
 s5EDHk46QqUNON3fBN7G/oNTOUxDsPyUoMjUzYCKxMhYmgQT9E4z5rfrZbCXov5wIBkZ
 KExS3x1aF4kIjl2MTWZvxEmxKK6ipLgmiKR1Sqye+6oP4rOh9icVK2lpVO4dE9ONRu4C
 kSQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=vBvS+noZBaZQ0N/vcZ2iv5jpinv2pzBbpanpbZzuseU=;
 fh=eIExS0ApvoHXzoHaeZPvhgA2i643iHXhJkaiwQaioTU=;
 b=dx6rizMIgYtRzNNl4HAagQypdDyVOPVBGwZVCcFyjIHfFCt/FnOnuwgMQRGNvvKKCz
 69ETGIPbc1LVs/ovgRmI5l+qvfE2sFL8VRXjdo6u9SlvG2sz5iYnEt8oG2AOeTdjyR2p
 zZZJy1uwHu10glit6z2SggUNaSR/4fB/LNbypKCxK8lXUPdtRg/XzfKBS8g3oTZgO9tF
 Y59GE1uvJDhU2k+Imy02L8gEIM+pD0Hcf4tp1e0YtI0RouZ4KCnE5LZA1PC5CoQ/PWMI
 DLGkiSib3eSUL1VwKrQKs7vVzcXbLmqijNmY1CoqthGPMG9JYLUwIkHCMDCswA1DW7wU
 3Yog==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782398330; x=1783003130; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vBvS+noZBaZQ0N/vcZ2iv5jpinv2pzBbpanpbZzuseU=;
 b=X2xOutxo7Hn72kGEOpe2r5YC4eg/JuHhq1M2ncA/VayLlpj4FREh54op74XNACxffZ
 tbnX0hhkCIorjiM7YeUbnDj7drs7B67MEKaIACxqmsSZgI+1Ge4vX2d1UOLZJ9udtq5Q
 Sa38rmyWy9AW5TFEMsQMbvuanBJ5YkW10/XAI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782398330; x=1783003130;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vBvS+noZBaZQ0N/vcZ2iv5jpinv2pzBbpanpbZzuseU=;
 b=aSqTWUhGqm6fd8hh+e0dXVzXhfTMblnNnAviK4ElPlJAd5g0b4iJrAS7Zt4YLkKs97
 6yjZK11dLJ6wzjO54JuMbutQAAF1g3Lss/bsDX78VsoJuR67THNxss2EnJee7KqPebpF
 wtToGipEAHcOFPrrjMXC9TwjMuMxnr1KVhQdF4UF30oeeRS0u1nQVJGt2tRFRATeYTjI
 blbK6p1UJ8TzE1r5j9+wtggAl4wUtMqBZ+JoBftQwCA0i7WZKct6/5BpGobXlgYaMNH8
 JjsBuiXY3S0SwKfRvDxp1jbiQh/U0eQcZvs7DI7uLORxWUrF0Uo9nsCdW1ana1r5qtwG
 gAbA==
X-Gm-Message-State: AOJu0YyhA+oFeXpG0Nt64C8LRfTE9FLVlqT/7lZgKl8vZ5bVP/C/uJuP
 /C7C1SeRZQ2mLvBBYT/SwTxckuAVu/ah+Id3zMhzyPYK3d9FFvCW2J2Stj33pznMTLRj0HQ7XCj
 Mt2jNpXbDHirG+8RcpiF8LH+HyRDsY7eU14GJyGY9GYQr18y0CuTwig==
X-Gm-Gg: AfdE7cl7KeB4XE5nHCL3pWsnN/Vte4srpfFbIs76N/d2fT2UpxHhdUmM5FOKjITz2fY
 AHoBhoA4ENtyAoYkvORl2i4cmSRxqS7/RLQTFWcINWVeEJdtLm4J53L4hRKyVrHehDtbcAAvCF0
 dwtZ4eS6rzkdFwGRZZ90vaz8wbbnfsNvIJmgP0CUG5th94WBfmKrO7Q9y+BNZA52JPHgyab1clh
 L5N8U1XghGEAQHbiMtcEk6qidJXnrjrlHCmPzTUqOGcc9U2BXtXhW2Fp715yIGe8ovBfdf/bQ==
X-Received: by 2002:a17:907:d5a2:b0:c12:1992:2caa with SMTP id
 a640c23a62f3a-c1219923919mr38474966b.4.1782398330108; Thu, 25 Jun 2026
 07:38:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260625122325.834568-1-jamie.gibbons@microchip.com>
 <20260625122325.834568-2-jamie.gibbons@microchip.com>
In-Reply-To: <20260625122325.834568-2-jamie.gibbons@microchip.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 25 Jun 2026 15:38:36 +0100
X-Gm-Features: AVVi8CfsbtH0B6rFLxXyXEpYLA4UeeRUs-h9_5el98lmYXL3hKw3LTaayNiEbi8
Message-ID: <CAFLszTig25Z38Hoc=nf=6fGq=wXuxtf8MGGKJvN6vudFpqiQkQ@mail.gmail.com>
Subject: Re: [PATCH 1/8] cmd: rng: fix error handling for dm_rng_read()
To: jamie.gibbons@microchip.com
Cc: u-boot@lists.denx.de
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

Hi Jamie,

On 2026-06-25T12:23:17, Jamie Gibbons <jamie.gibbons@microchip.com> wrote:
> cmd: rng: fix error handling for dm_rng_read()
>
> The rng command treated any non-zero return value from dm_rng_read() as
> an error, even though the API returns the number of bytes read on
> success.
>
> Update the error handling to only report a failure when dm_rng_read()
> returns a negative error code, or when a short read occurs.
>
> This fixes false "Reading RNG failed" messages when RNG drivers
> successfully return data.
>
> Signed-off-by: Jamie Gibbons <jamie.gibbons@microchip.com>
>
> cmd/rng.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

> diff --git a/cmd/rng.c b/cmd/rng.c
> @@ -62,7 +62,7 @@ static int do_rng(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>       n = min(n, sizeof(buf));
>
>       err = dm_rng_read(dev, buf, n);
> -     if (err) {
> +     if (err < 0 || err != n) {
>               puts(err == -EINTR ? 'Abort\n' : "Reading RNG failed\n");
>               ret = CMD_RET_FAILURE;
>       } else {

Not quite. The contract in include/rng.h is:

    Return:     0 if OK, -ve on error

and every existing driver (arm_rndr, sandbox_rng, stm32_rng, etc.)
returns 0 on success, not the byte count. With this change those
drivers will hit err != n and the command will print 'Reading RNG
failed' for every successful read.

The real problem is that the new mpfs_rng driver in patch 4 returns
len on success instead of 0. Fix it there - make mpfs_rng_read()
return 0 on success like the rest of the uclass.

If you want to change the uclass contract to "returns bytes read"
(matching Linux hwrng semantics), that is a much bigger change: update
dm_rng_read()'s kerneldoc, convert every in-tree driver, and update
all callers (cmd/rng.c, boot/fdt_support.c, lib/uuid.c, efi_loader,
etc.). It should not be slipped in via a one-line cmd/rng.c tweak.

Also, n is size_t and err is int, so err != n is a signed/unsigned comparison.

Regards,
Simon
