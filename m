Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3373CA9EC5
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 07:44:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 530CE6061A;
	Mon, 12 Oct 2026 07:44:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TuZLjJlzceDB; Mon, 12 Oct 2026 07:44:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 041AB60602
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791791081;
	b=NPvwA+Kf3y7uMdaQA2YeIWfOADxyDWFcrPqS09b9V/He/oBguTLPa2ihuIx0rh0sboi2
	 J7+VL55mTGvF5Qm9RwxuuWxNwtl9Xx7CW5io1+l64OSnRTtXj+CtkMaJHeSuCTMV6goC+
	 TOyd+vofwn8fs6TaWc2JI6ZUbDJsxlMfu7WAF7hv1UVvT+MFUAnUqEACDQhQjZLrQKrLn
	 AUKoXHrvFj7mC5uItcACPs/KCJHO6cANLfFm/zmsx8k1ZyWX9p3i23EMyyHLVFGp/ZeR0
	 lY40vCpB2aiTUOOkQHPytwprdYDtLZcAANiBPDbGgwLOO36LL0r+jzWDM4KA40yLxBg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791791081;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=WMXrAcZznjhm/X9X5d2x9IqRQTgO9qarG+vo4uTKaew=;
	b=Jg0Od9+Iu1QhaObXQLUnN9EtyQ1JNgRFAuZ69vOcR4ic42nY7g0QhJc9sSosAA+8L+XV
	 cGs09MJEB6tlFA+WzbW5otfqd/LkAkKvkyshU7VyMeJnTFla6bwZ6gfHgYkh/IUDdLGno
	 sRJYyKBw4/TTULv5JORGcMgmiIOD4Q7J/jNB9WB6z2a+y3m6nFYSXOlen1ZyNIt1FMvtp
	 I3K4PvaN+YendEt9pIPikgqL9lK3l7EJQFtydCZuJciUefJ08TX8+qNiOnmONHN9tLTlx
	 DkHWmrfEl3MTFbqwccHkpdRTxkceljgkJX7vchWy06hDUIQquhMrCNCZDMn7AdS2vdg==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791791081;
	bh=WMXrAcZznjhm/X9X5d2x9IqRQTgO9qarG+vo4uTKaew=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CTAB9EueZJ0ITcKZIZDdwDst3J4EsJ2zt05OGigXG1QCCwGFkugFPgzPVOUMdSOb0
	 LnThpcHE9ntU67QkwJ5e+08hilRQxtLhPyI3PZ7agygnnHaHVmSfUAqnMqHclRAY8n
	 +WPD99nizX7ArBLsjZBRAsDygOVJDn/5cUTJUVVOCQ8K2fX2HbNtNWQwIJqhLt5BXi
	 w5C2YqztuI489h7zQfO33eA1IAzDl4Yw8fcmc5PpWxoBcloNohvSXDrkaoWnGKhdIY
	 3XkOKITpJRtWWF2iVwP4CyyaKsKemxjlGZQHVXKTnxH5Q3kLG6q3eYXnNH6cuR2rPx
	 jPF0rkosXUiGA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 041AB60602;
	Mon, 12 Oct 2026 07:44:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id E5E3675
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 07:44:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DF42880CC5
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 07:44:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id N6cdxUMgx7cs for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 07:44:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6B90A80AB2
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::534"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791791077;
 b=l5kZLVBQgDxTbrhbct266g1h47pU2uuAzhps/3t8WmQHv5MuIMnSeshrjNf+PxJZmsEe
 RdHB1Pjx6iDMDzi123pl0M+sAMNVRjqGgGor55O6ZuvWjVHhPua5ap5xNBWESKaS/aKQG
 Gu87MAypKkjjtnDfRT6yREvHDtCuxTaCXjIouf0OdKNoE8ogPKwoCl+PZd7D70NgrLUxU
 Bm/FL3vP09lM0U5c8g/HvjULXrFwrfTpml5byBiUABXYpU0fyy2foBhpZKfxA2eOFkq4k
 O6P11xHmE2EtAUKL9sflBiF8ONK5QFwjeMW9K/iLgQYjX0kPzI2dOj+wijaRQjBNKgw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791791077;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=WMXrAcZznjhm/X9X5d2x9IqRQTgO9qarG+vo4uTKaew=;
 b=KG8Z0FCxeE9tIq7dBmc3DCArBCeahgB/MSeeMfW2hzKxEg6BV+6WOBvESNZz8Rhe18J3
 3DBJHE3/s15wUpJfa4dkVeoe7bUdroB8nYgCvEpHPoz7vx1rHlOhdJ3UulMig5VZWE9gk
 iAvDQ/gA5zf24GgJgeiYJ5dhJ8Ahja7fFrZGb6kmMi7fS+sPlGNRDYSA0i5j9bSqi6N9z
 AEiAuVNCVdXy9eBDpLks6dXOTUFvbc10eiSCSQyM/NIC3Be3BK8ELJm2maUXuAMCMtVkF
 7cnxFVOwDVQrmrmtniXzfT7vZXSK5XJYYw4EcH4a+jV4YWz4p7sYcIMxclj1EErCltA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=KsxVwx3H; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::534"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::534; helo=mail-ed1-x534.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=KsxVwx3H
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6B90A80AB2
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 07:44:36 +0000 (UTC)
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-6b1afcd2d23so1005400a12.1
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 00:44:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791791075; cv=none;
 d=google.com; s=arc-20260327;
 b=Frqi01eJm/tmNgR60fG7djFO9FRAJXAzV4bAGandvJ3YRVt/J52IhjJpGLNLTj40bQ
 hvM8pIHZ3oAt30HLyUtx5Oex3vwYvcCvCoqdNVQ5GciPE0MRD8jzeWy2w3CrEzWFqpO6
 fTJtZyJjssflfXTA+QxyP+maaxCnRkz9/xR98kgp4KE1B+glpGWLbctoTeDCw6vnDobd
 OSF1HBRLwZWo1owEP/4uHKMd0nOLY+KrMF62d7Ytc0qh//x2WyFofqHnp8Fl+OMRaV/o
 fvF6hCgIcsR6Msv8+C9Di9We7xK+pGixCq5vtlvB3qyQFZ/C1HiRcze3izs7pwSwrfiJ
 Gbhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=WMXrAcZznjhm/X9X5d2x9IqRQTgO9qarG+vo4uTKaew=;
 fh=QSz2LWxXxIlE5sVY3cc6rCrz5I3EPoPd6wg5hM7ii44=;
 b=a/Gz1/BkNxb5WmjNTFlQhDAimrRB34wDI8OfGXQ8vrIGDPk8nioHoeAWdfAs+RytbQ
 s38lhOv79aWW7yr7bbEvPEJXtKzqIITulTPvKutn2aCLlqRPZ/QW0cHdTYffY5PCBSq8
 6VH+ViwRnhWfZ951902NhPYz208yD5Spnc6I6Drd3pj3rwghhkB8LJZxsFkMu+VtTmGV
 dLWoorJ1eqqR3rM/Drq+9tYbNq6ZIbA56wO1IZHDj32WN45nnDveeiacO5XYAtjrR9ZB
 SdYp1viQlydrQ3UHly5/ChcWa6SzXtG8nCB6NinXqMJdjeaVGZmhsSTQzm+VEcn24bgh
 sAGw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1791791075; x=1792395875;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=WMXrAcZznjhm/X9X5d2x9IqRQTgO9qarG+vo4uTKaew=;
 b=KsxVwx3HHzHa3LVtjlaeuQHVTTpWtVa8RATSAu041PBJA7mSOl0C4TSxZulXwh29T/
 kmh+hVFKqMStKFzCph6gGn1Wvu1IQkbQvnOGVDdUkKbqvpy77lEL3p+BiRXw+1XYNOdV
 SVpSfa10wsR+upUQjOQOYRC5SrDkkT9jzHlVs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791791075; x=1792395875;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=WMXrAcZznjhm/X9X5d2x9IqRQTgO9qarG+vo4uTKaew=;
 b=xhvinS0rIpMRlPIoNISYFy4L4uPtCdd0zYsHqtmJxPSU21ckM3YmjOnsiB+FMVnOd7
 jHOrJixjaQoB1dpZKsEYMNVgp//ylwZlK44yzJ4eE3jlimfAe9K5G2xuGI5VSOeH9JjW
 iocdcujRy/P2H+5+6MwbmQXiuQrxvZ4NSyy8BcnNuIB4GVnPyIFbVoZuifUuPXmx6tnA
 FgFUirhxjlK8fIJqYVeAj7yF+LfLFrXbyTCqC8I/amKEHaXGny2MLKH+9TYRFy7ieijO
 R3NIptLzH2qzKmLCJ6GCqILRZGEBbJyTOKtzppv60A4i9+zlX0z0GqrZ6/HsvBvEJM3d
 fHiQ==
X-Gm-Message-State: AFq9FYLtpbUvG8eJX61Z9kujPoqwG+6Qnv6hU+QmkZ65CKI0xzKfmTDn
 6I35snSfWSBLQ/aEsy7di8iMH67qPbA3DPUNkM4cHdWtJmmBx+rwMPqfysJWwfs4Bi+GsENjzZ3
 O81LNMK5wTM6UEOmHDZw37KGHo8l64ROv72zR8mNC
X-Gm-Gg: AYBFou0XFJud8dMxazRoZ7rrtu5OMCncoGs0GLV+HdUvegwNZmi4jEsJszYOBPrVO57
 zweGl4MhcPINuz4a25dS7Tuj1njbsmWRvYpL9ABBk4qlQWuP4ukmAjEThnYKMBRIkwKqz5woQfV
 AVRstWCinuBOu0N3KNLbeAzgf3XPcEhLu1Dj8fcBapcS/estBpTqDbFrs2gReAbPnXtnBzBAWzV
 cTG+UnBKpjc/U+rN1m3V/In7eJIQv8sr99RSQ8JPF4z/qyxy5duLmSkeysKqHrM9NZO6yQZMrqB
 fEPpqiRQIKX23eoMzzH9TO0PQEuBmRjKoSz5TeQ0idS3PDaGnBostW9A
X-Received: by 2002:a05:6402:5285:b0:6b1:497d:1c64 with SMTP id
 4fb4d7f45d1cf-6b17c293eccmr7805926a12.45.1791791074925; Mon, 12 Oct 2026
 00:44:34 -0700 (PDT)
MIME-Version: 1.0
References: <20261009151005.2870671-1-hyyoxhk@163.com>
In-Reply-To: <20261009151005.2870671-1-hyyoxhk@163.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 12 Oct 2026 08:44:23 +0100
X-Gm-Features: AclHuK-Dg4m8c0HmtbEgyyizsXgsNTjT5ki_yK1mNpwc8PZSO9o4snFAiOeNffg
Message-ID: <CAFLszTitXuRhtQkm7-xj6+9wwLGq_MQd_8ZVeYQx3fnxKS8qwA@mail.gmail.com>
Subject: Re: [PATCH] bootstd: Add a bootmeth for scripts in raw partitions
To: hyyoxhk@163.com
Cc: u-boot@lists.u-boot-project.org, sjg@chromium.org, trini@konsulko.com, 
 alchark@flipper.net, daniel@makrotopia.org, jbx6244@gmail.com, 
 quentin.schulz@cherry.de
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

Hi He,

On 2026-10-09T15:10:05, He Yong <hyyoxhk@163.com> wrote:
> bootstd: Add a bootmeth for scripts in raw partitions
>
> Some disk layouts store a U-Boot script image directly in a named
> partition, without a filesystem. The existing script bootmeth cannot
> find these images, so booting them requires a board-specific bootcmd.
>
> Add an optional script_raw bootmeth which matches a partition label and
> reads the image from the first block. Determine the image size from its
> header and check it against the partition size and a configurable limit
> before allocating and reading the complete image.
>
> Support legacy script images and FIT scripts with embedded data. Check
> legacy length-table bounds and validate the complete FIT before passing
> it to image_locate_script(). Reject FIT external data to avoid following
> references outside the loaded buffer. Use the existing script verification
> policy and share the script boot handler to set the device environment
> variables and execute the image.

Rejecting external data is unexpected behaviour, but I suppose it is
fair enough, since scripts are small and we don't expect any other
images in the FIT.

>
> Document the configuration and disk layout, and add sandbox tests for
> legacy and FIT execution, invalid images, size limits, partition labels

Philosophically speaking, it would be nice to extern the existing
bootmeth_script - did you consider that.

> [...]
>
> MAINTAINERS                               |   1 +
>  boot/Kconfig                              |  26 ++++
>  boot/Makefile                             |   1 +
>  boot/bootmeth_script.c                    |   4 +-
>  boot/bootmeth_script_raw.c                | 202 ++++++++++++++++++++++++++++++
>  doc/develop/bootstd/index.rst             |   1 +
>  doc/develop/bootstd/script_raw.rst        |  45 +++++++
>  doc/device-tree-bindings/bootmeth.txt     |   1 +
>  include/bootmeth.h                        |  12 ++
>  test/py/tests/test_bootmeth_script_raw.py |  97 ++++++++++++++
>  10 files changed, 388 insertions(+), 2 deletions(-)

> diff --git a/boot/bootmeth_script_raw.c b/boot/bootmeth_script_raw.c
> @@ -0,0 +1,202 @@
> +             lengths = buf + pos;
> +             len = fdt32_to_cpu(*lengths);
> +             do {
> +                     if (size - pos < sizeof(*lengths))
> +                             return -EINVAL;
> +                     pos += sizeof(*lengths);
> +             } while (*lengths++);
> +             if (!len || len > size - pos)
> +                     return -EINVAL;

This duplicates the legacy parsing in image_locate_script(), which
takes a size but ignores it, so its 'while (*data++);' loop can run
off the end of the buffer. Please can you add the bounds checks to
image_locate_script() instead, in a separate patch? Then the existing
script bootmeth and the 'source' command get the same protection, and
this bootmeth can just call image_locate_script(). What do you think?

> diff --git a/boot/bootmeth_script_raw.c b/boot/bootmeth_script_raw.c
> @@ -0,0 +1,202 @@
> +             if (size < pos + 2 * sizeof(*lengths) ||
> +                 image_get_data_size(hdr) != size - pos ||
> +                 !image_check_hcrc(hdr))
> +                     return -EINVAL;

The caller computes 'size' from image_get_data_size() and has already
checked the header CRC, so neither check can fail. The same applies to
the 'fdt_totalsize(buf) != size' check in the FIT branch. Please drop
these, so it is clearer which checks matter.

> diff --git a/boot/bootmeth_script_raw.c b/boot/bootmeth_script_raw.c
> @@ -0,0 +1,202 @@
> +     if (size < sizeof(struct fdt_header)) {
> +             ret = -EINVAL;
> +             goto out;
> +     }

This only applies to FIT but also runs for legacy images. Please move
it into the FIT branch above.

> diff --git a/boot/bootmeth_script_raw.c b/boot/bootmeth_script_raw.c
> @@ -0,0 +1,202 @@
> +     if (!bflow->blk || !bflow->part)
> +             return -ENOENT;
> +     desc = dev_get_uclass_plat(bflow->blk);
> +     ret = part_get_info(desc, bflow->part, &info);
> +     if (ret)
> +             return ret;

Please use log_msg_ret() for error returns here and on the 'goto out'
paths, as other bootmeths do. With so many rejection reasons, it helps
when debugging why a partition is skipped.

> diff --git a/doc/develop/bootstd/script_raw.rst b/doc/develop/bootstd/script_raw.rst
> @@ -0,0 +1,45 @@
> +Raw Script Bootmeth
> +==================

The underline is one character short, so Sphinx warns and 'make
htmldocs' fails in CI.

> diff --git a/test/py/tests/test_bootmeth_script_raw.py b/test/py/tests/test_bootmeth_script_raw.py
> @@ -0,0 +1,97 @@
> +@pytest.mark.boardspec('sandbox')
> +@pytest.mark.buildconfigspec('bootmeth_script_raw')

No defconfig enables CONFIG_BOOTMETH_SCRIPT_RAW, so CI always skips
this test. Please can you enable it for sandbox? Check that the
existing bootflow/bootmeth tests still pass, since they count the
auto-bound bootmeths. The test also needs
@pytest.mark.requiredtool('sgdisk'), as in test_ab.py.

bootmeths should be tested in C, in test/boot/bootflow.c, with a disk
image created by test/py/img/ - that is quicker than restarting U-Boot
for each case and avoids the manual 'bind bootstd 0
bootmeth_script_raw' step. See the docs here if you haven't already:

https://docs.u-boot-project.org/en/latest/develop/tests_writing.html

Regards,
Simon
