Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C17AEFF885A
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 14:08:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B79E84150;
	Tue, 28 Apr 2026 16:08:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aoA9g3WR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB95484255; Tue, 28 Apr 2026 16:08:19 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CFB7F83FB5
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 16:08:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-b941762394aso1574091766b.1
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 07:08:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777385297; cv=none;
 d=google.com; s=arc-20240605;
 b=Ysb4bRskkqkW736tqy1O9evxarBW13mAUxwomLmbCcYgKEg1H1Y7iyBlkWNb6pQHZB
 A8SkTbNMsx9fK2/DwywhgbAuhiu4HeAK5T/5GH1GhooghGpY2ojYq7rr5UUoNLOdSZE9
 uvZuTm4wkf9/Wb1SDAsbaU137ABKBFsYvwdbu88j7Fe1jQNFvMbKLdh1kCffrn1EN3dI
 oN/07RZfxUgLtSDKe4PEmDrd/FHaqIR4bpdHE5ztnwM+3N4LfaMJF688VvIS8sffXTTy
 aSM34q/Rti2hT5HLAiVJ1R/brh4JU6MhQn2BbWX4T2kPcUVkqVTgvdYcObSV0uSbNTbV
 wvYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=k5TcjNjxERFq6XEmN/dCFs7IU3BVqoH0Db+cUsIq6R8=;
 fh=fJAGB8LvxCJalDRE+ziaXIW21+gD5jSCb0B1QEwHsvE=;
 b=A99AMfXezqa0cfpfDAcog4kn/kqqQb6WX6pAVU3YmahNMqrsQeppK95P2P8U7WDXid
 QqNqDjldJzzp64DVvgBgdFGT6RylZlDErvEevKl5f4M1hF43q7xO+sMAVPs3qsnyazWD
 GDsD1xy4Xfnt8Bk5DmFbC8v4GmeeQ+UBlZuredJTtS3fb9/xwbx8mvauRlrMA1hqBPnm
 JY9kcsmt2QRgsothki1J0zz6fpLE36Pf9Zg2bVjAoSvPCFaWTeCwkRyxmzUhaeXW7mag
 NvEb0ZPfo1m39MRPQLLpVntvRSekLpWxVYm1z1nr/308IT8AtZwMrEr//dr3GlbtZdoe
 10dQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777385297; x=1777990097; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=k5TcjNjxERFq6XEmN/dCFs7IU3BVqoH0Db+cUsIq6R8=;
 b=aoA9g3WRP/O5dWO05V7Ozy2Fr8xD3UReou1m+nPaj53VaOIz7JsdIqk7+3xDOm4QdU
 bgl4S4zZtdvd0ULPyf+zcy0+APeXGTpgZiNqDMuh72YriwoN0/I1iF2d4T5Mt0tWabWl
 P3RSHZRD/e7FqECjHIUGYd7ioU5GpXnzpwMwQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777385297; x=1777990097;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k5TcjNjxERFq6XEmN/dCFs7IU3BVqoH0Db+cUsIq6R8=;
 b=Lu/BULjOmZMEGl092n537rnZTF/abWrZd4SjHEUg5iJpFKC2cALyB/02qRnOcUh2w/
 rg5Bxz4xkgrJ2c5FPzmacWFWQD01D9YD2XnlxzuIrMuozlsiVfcXSTv9kynDGA1vtHi3
 hRZ7/fy9Ub2MvLbXilxsKbCv4AEEGgY5BryyHFvR94vMhzU29JXNkj6IS+thV6CtY2mV
 /9KExxBZ/lqHCeiRM0GsLqnnNPnwwGdTjBw/AAsieqEln4RWutyUNa1pxkF83wwJWlmX
 sjs6verAj9/111+NBEzta3KgjMK9Rol0reyYqQWg4z3br73oKlMLeTDjanvxATI510Pz
 sMOg==
X-Gm-Message-State: AOJu0YydlZEO516UyLq3TV9lPNzQSxRpAyUFiY2S2HNDTX4pltxRnSYD
 j997EihuptsE0CpZ/8tE/2XJ1Vwm+Z+oqeokLKbNVK5WD8Cj0eybNLHqx5yXW0MttN+sGpKDmon
 ec3V+MRjGCbasFWw0Dpc4pyXfVTv1l5qbhn7XjYvvQ/je+DsoYX4=
X-Gm-Gg: AeBDievhRIpHCteNwW7JxSbB66hyw/C1wA0Q82UNz/nAhYhfuSW7+WyGvRIx/QVEr5S
 o19p2DFbW6iPSsMRVRQy5rRHIwA8UqdXDWLCx9cWrlmCwxescsjaGxIQ4u/nnB0ffl7GZxJNk1T
 EybuvCHwFhqgS2igprZ4Pzg14MYSogPkiVt/ECF9zO40pza8yR50UkSuUK0IhZlnnkwIlOHsmLn
 N2AVCjQY9mIuJKYEYbmo98/YnrXqHETaRuYie1z4PD0aHFl21hQO5IgyZNrL+1EHX3i6akdKUbR
 cZAmbd4IIUfdLPFW
X-Received: by 2002:a17:907:874b:b0:ba8:e7d5:6a7a with SMTP id
 a640c23a62f3a-bb804537637mr175179266b.40.1777385297197; Tue, 28 Apr 2026
 07:08:17 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1777272283.git.weijie.gao@mediatek.com>
 <dd48da7aa5d821b56528824bfd4b57e014947a03.1777272283.git.weijie.gao@mediatek.com>
In-Reply-To: <dd48da7aa5d821b56528824bfd4b57e014947a03.1777272283.git.weijie.gao@mediatek.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 28 Apr 2026 08:08:05 -0600
X-Gm-Features: AVHnY4L4GXKp3qM7-VVdRd8fUCTgRT75oXyITBRiMxwwskAxDTi03nqc9dAEjdA
Message-ID: <CAFLszThT-jyw5OjAkZGWpKKi0d0NARL8O1f6etR7YUCOvWc_vQ@mail.gmail.com>
Subject: Re: [PATCH v3 09/10] ubi: add comments for exported ubi API functions
To: weijie.gao@mediatek.com
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

Hi Weijie,

On 2026-04-27T07:09:11, Weijie Gao <weijie.gao@mediatek.com> wrote:
> ubi: add comments for exported ubi API functions
>
> This patch adds comments for exported ubi command API functions.
>
> Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
>
> include/ubi_uboot.h | 86 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 86 insertions(+)

> diff --git a/include/ubi_uboot.h b/include/ubi_uboot.h
> @@ -47,14 +47,100 @@
> + * ubi_part() - attach UBI to MTD partition
> + * @part_name: name of the MTD partition to attach
> + * @vid_header_offset: VID header offset (string)
> + *
> + * This function detaches any existing UBI device, then probes for the
> + * specified MTD partition, and then scans it to initialize UBI.
> + *
> + * @vid_header_offset is optional and is usually set to NULL.
> + *
> + * Return: 0 on success, 1 if partition not found, or -ve on error.
> + */
> int ubi_part(const char *part_name, const char *vid_header_offset);

Most error paths in this file return positive errno values, so '-ve on
error' is not quite right. Please double-check and document the actual
convention.

> diff --git a/include/ubi_uboot.h b/include/ubi_uboot.h
> @@ -47,14 +47,100 @@
> + * ubi_volume_read() - read data from UBI volume
> + * @volume: name of the volume to read from
> + * @buf: buffer to hold the read data
> + * @offset: start offset for reading
> + * @size: number of bytes to read
> + *
> + * This function reads data from the specified UBI volume. If @size is zero,
> + * the function reads the entire volume content starting from @offset.
> + *
> + * Return: 0 on success, or -ve on error.
> + */
> int ubi_volume_read(const char *volume, void *buf, loff_t offset, size_t size);

Same here early-exit paths return positive errno (ENODEV, EBUSY,
EBADF, ENOMEM) while the read loop negates ubi_eba_read_leb()'s error.
Better to normalise to one convention, and please be consistent across
all of these.

> diff --git a/include/ubi_uboot.h b/include/ubi_uboot.h
> @@ -47,14 +47,100 @@
> + * This function creates a new UBI volume with the specified parameters.
> + * If @size is negative, all available spaces will be used.
> + * if @vol_id is negative, volume ID will be selected and assigned by UBI.
> + *
> + * Return: 0 on success, or -ve on error.
> + */
> int ubi_create_vol(const char *volume, int64_t size, bool dynamic, int vol_id,

>                  bool skipcheck);

Capitlal I on 'If'. Also 'all available spaces' reads better as 'all
available space'. Also worth mentioning that @vol_id should be
UBI_VOL_NUM_AUTO for auto-assignment.

> diff --git a/include/ubi_uboot.h b/include/ubi_uboot.h
> @@ -47,14 +47,100 @@
> + * ubi_detach() - detach UBI from MTD partition
> + *
> + * This function performs the cleanup of the UBI subsystem to make sure the
> + * MTD partition can be safely used by other purpose, or be attached again
> + * with ubi_part().
> + *
> + * Any mounted UBIFS will be unmounted automatically.
> + *
> + * Return: 0 on success.
> + */
> int ubi_detach(void);

'used by other purpose' should be 'used for another purpose'. Since
this only ever returns 0, you could say 'Return: 0' and drop 'on
success'.

Regards,
Simon
