Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98B63CD37AD
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 16:41:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33C9084D5B;
	Fri,  8 May 2026 18:41:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OnALTjww";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5848C84D98; Fri,  8 May 2026 18:41:57 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8407D84D42
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 18:41:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-b9382e59c0eso353825166b.0
 for <u-boot@lists.denx.de>; Fri, 08 May 2026 09:41:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778258515; cv=none;
 d=google.com; s=arc-20240605;
 b=WFgQOcWk00qTTmf97kiFp3TWzhJjP7DRPw8ikTUMdNhC9TN+YFI02HY+zzhm0N1g9+
 vvpxdcBwzNyaPDYz5ExldL1Wson6Uoh1urG3wQUwg4x8nJFmbUd4wt/IPuZyLVtCb9Gs
 MtfwHJegxp+Frlo6o9hpHfuz0bBWt9lWXcb2zH0ldstszFG0CYJeGbGgWkQA/7xa/nPx
 2qVL5d865tCtVYXDI9ohDEp8mSp+guptvLdJVOmp1n8oBB33oSbNLQOotR9DjNWDffA0
 PafvORiq3/PV3u9wUjdCEq03wWJiVAW6DWhfTvdZvCkqRVnM4fGB3T4v5GGV8iXF0Wl/
 tkLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=4oFc2Q7jEGJ4uvF5oDQAqKLvoSBQhR7fdvv+AajUKuQ=;
 fh=7+NugGQ2fjuifNFbboBIeXRgPjkONDOweWugJxHsSfY=;
 b=M/COoJWQiMkI0pVeok+DeKANZikjEdh6+4Krm9LN+LRa483QmexrSOF0WNqxjjnLoR
 iu5E3bmLUPOw9EscYUrbQsNFgsNzoSzLX0RBHDrJxkBfdyHKlB+0M5OEkDDkE28sIVI8
 Xc7cEQuQYdVEY0OtprHUlD16OBvFzljyp+5/bNHU/H+n5En44+gV7qDrlKJENNs67anY
 +WoHpzwHKQJFC88GdmOrsCJJ42YUR63/YVDgPaK9pYjK07vGsZfn1XbWtbDCxlISSiQM
 4mXXjFjuXthEWVhR6H7Tg4v5LZQflm4idfh/lvcT8lFfYrnT3QwTEKSSX2AGEwZHIEPn
 gh/g==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778258515; x=1778863315; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4oFc2Q7jEGJ4uvF5oDQAqKLvoSBQhR7fdvv+AajUKuQ=;
 b=OnALTjwwYKXm1SMXg1i/f8EtRP62SffPbOZAnZ0b2G5gpJlNpam5YDO4/J+bm+aWcc
 eZgSa6eeMbmzGnw2/lnestug84xmQBnGe6APEpZNJ1zy/81hmmYtudEAs3/IyPR1s7+R
 mOzeHwgs3vhurhWTHDV8o2NJDzbADyL2rEy8E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778258515; x=1778863315;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4oFc2Q7jEGJ4uvF5oDQAqKLvoSBQhR7fdvv+AajUKuQ=;
 b=So5Oa2Iwcg8JJ85r3sJQ1qUPDOq884bSeg1NsLHLPXycNKzZnFCnIHVpsrHtB3qOB1
 iDNXrWSYG0uiJP9epbt46oFEsldA8WvJvQfYFYq+PsZO/C4QfySGyZVHa22iwejKhsYK
 aCa1kDo7dbGUv6E9Jdf71SnMN1I/3DISoeJ4zV6oHZYXt4I1ZK7FYogwTenc1zXrOiPc
 elTihd3YjYsZlsoC70DYnF+t1qGjYHHHfgAgwG+kiHXij3HgNzjZ/3YojvuDj2FmDxrw
 5fpYWjPQyobBTKs79IgpCIh5cxNi2qy0FU/WHjAdXgcYiFoNK1hz+8d5O7TZZGq7XIMk
 QnHg==
X-Gm-Message-State: AOJu0YxJwh9vQeiooR22wMWiAtMh1C5ERBGiC0Je0khyop5IKSgqRm1V
 p2A30JdXCg5P0pjG9VwwtGd+g4Yv5UWYQZtxUzy5V47uEOcXMK0vQalKWXRbmCPGhacQ5W0eCrb
 7EV2gd38c3CjgOmPij0L7O5kCaEfr38kT9sApNEUz
X-Gm-Gg: AeBDieuErXgMkhlHS13ixv2k3aEG8bTazfq+IUWajkWi2E3yEeIJMGbAl0cmr7IB6Rk
 mt8lZZ6WZSghzGBQGl6bfXGcXIc2bqOT3ob3RhMuEg8jERjDnb2TJ8FlDsvbHNYzETkJGZS/Cqt
 9+q4sBMwOiVtb3cjiCrNLGZxxS8LK5y4O2AsiodRk39tyQ6dAKmi96bmsNoj4byH3OVRrwUljK5
 43x1FzeKHX/EiE6E/bfTmtDi0M6xx7iDD14xQicsa7G6UyVWvGYvv4l57sl18OpZdswZzPik7NI
 0RghZ/JKkARcCEUV
X-Received: by 2002:a17:906:9f8a:b0:ba0:fd75:9c58 with SMTP id
 a640c23a62f3a-bc56d717ed5mr821103066b.32.1778258514833; Fri, 08 May 2026
 09:41:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260507164225.59325-1-marek.vasut+renesas@mailbox.org>
 <20260507164225.59325-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260507164225.59325-2-marek.vasut+renesas@mailbox.org>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 8 May 2026 10:41:42 -0600
X-Gm-Features: AVHnY4IG44ptgu_MFo865QBRimq0BRIZBiB5n2MwrzB_dU7zrfhOlIJeLU7Datg
Message-ID: <CAFLszTi4zgfpVW1_OUkpVjGBj2S=x8XReByOHUbA3qjA3BJOdA@mail.gmail.com>
Subject: Re: [PATCH 2/3] ata: bootstd: Staticize and constify driver ops
To: marek.vasut+renesas@mailbox.org
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
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

Hi Marek,

On 2026-05-07T16:42:06, Marek Vasut <marek.vasut+renesas@mailbox.org> wrote:
> ata: bootstd: Staticize and constify driver ops
>
> Set the ops structure as static const. The structure is not accessible
> from outside of this driver and is not going to be modified at runtime.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>
> drivers/ata/sata_bootdev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

> diff --git a/drivers/ata/sata_bootdev.c b/drivers/ata/sata_bootdev.c
> @@ -37,7 +37,7 @@ static int sata_bootdev_hunt(struct bootdev_hunter *info, bool show)
>       return 0;
>  }
>
> -struct bootdev_ops sata_bootdev_ops = {
> +static const struct bootdev_ops sata_bootdev_ops = {
>  };

Perhaps use 'ata: sata_bootdev:' for the subject, to match the other
two patches.

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
