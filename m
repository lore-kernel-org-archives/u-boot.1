Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63440606A319
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 13:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=VXSN5Gpc;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=ZPoyF6vc
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 413DC608B4;
	Wed, 21 Oct 2026 13:07:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id W6-4EetmExbD; Wed, 21 Oct 2026 13:07:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4B0B8607D1
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792588027;
	b=iQ5aGOdfZqlWZXqiGjnCtOX8av5yc+VQPVlsnXaP6a9nNuYrhksgX4IjccjleALQ+BQP
	 mag61zK2N4O2/F7lrJn9S4fwOdUSStMOklyC05maA/xVWLpErMPbkuqhHlWDrgC0Qdrhx
	 G5l3GYpVXixk0D71ywzXBb/TDfjRcRYE+GO+z4A7KLp2w9HnJE8FE4dpNnuJioRpgE27S
	 +Epq3qn4rLWvwFOvvwMz87Ppz6fN7b588rb6bC1kEB3nEsJYmrgWEVzi7V1kV7IBRpqwX
	 CRby+IqtpX1lbFZpqrTqTJ8a97uXMWcuFsV7JJTcPuwYqK4YGPfnGS8eDIUhx/pgkOg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792588027;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=YdjeIOw+KAyov2jf5VdnWhcO7YyG0rzUF/iK0UqmXLI=;
	b=NoO0x3XHb8zOR45P3mNEoKdsjEAs3iYVf6erxYEWn9KD17gVAEgHxiUdss+ok4Wczntz
	 4UeThEVzuMCEYmLFC6M0yV1w9smxdpZASsZkoaYLJ+y/EAamMLXAAbT2GjoFP8B5MkChT
	 WY3IuvfUDKCSht1rEDs2v7yCYxZLaGl7rMERdEY7sqibM05a6EYF1pB2ohvuV0+mmHvC7
	 w4UNbTjg+HdEnl7NFUnXXcnL3emkc+D53voWuYMJ3OTQclg/pygt1bfwZ6dscK7ihux02
	 w42b7/gXg0RHsQO1QiyhJK3Rv1PE4biU2R86m0xbMZcx1o8Dhw/cAIn73Vylp6pm4og==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=ZPoyF6vc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792588027;
	bh=YdjeIOw+KAyov2jf5VdnWhcO7YyG0rzUF/iK0UqmXLI=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VXSN5GpcOzvP4degehj6UuqWc6qT0d4RyTj6f8Pi5rFhw9PSsiitv7TfgsJ5YXoKo
	 FNfn7oJYU7WqQKBV8vuA2lZrNf8Opa0iHAC0APWqxRHJiRw+1HZMe2pOM1nI1tNG/x
	 aYSKZ1wvg+RXYXFgga6bpTVypke55ppPMyDwsY2U4MaEbqKoEMQeLOFLCd7JMiJsjU
	 fIY4K32ARHGO91+8BVaMcunIDYBbeKdlsyftmnAhcmAp/cfHsimJ+AD++aqgjKhKCx
	 p0faQz7bPkkZNPSwogQLmNXNMaxZmOAxzW0rYS3oDaQqFXXUiCVYa/teP3mlhpKkuf
	 CdIJpznBRHVlg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4B0B8607D1;
	Wed, 21 Oct 2026 13:07:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 18DAB3A4
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 13:07:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0960160719
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 13:07:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id naAD8YeBaZE0 for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 13:07:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org EC1B5605F1
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::532"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792588021;
 b=J41uMBXVoDSHwxDOZo7xtbAAnpRso9eeA6sQcDCUPF7oZKaETdtndajIbRAs/MP/ERKS
 d6/a1fEdYshNcSVQCKo/xhrB42cC3cnmNP08CQfpHxIqcj5Ue1o4EoMS4Q0+XN4LPRcMa
 FSqY51UKrggY/y/j04k5+oZj0JO8pQMGfL2XOg73+5IMam+AAAjDMA/u0qi+jh0lHgsdl
 Vr1VSoydx1tMBA09TQBzzjFqfEfMF+3fvT6a1NSmz7UvYf9r4k4RiZ6nAHZXq0wJ86iPb
 13pAx9Bwot9WWs2dyfjuuRizNHQAoyrQkPbMDnszEupT10/EI5Vw9pDxhUtYBykBdIA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792588021;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=YdjeIOw+KAyov2jf5VdnWhcO7YyG0rzUF/iK0UqmXLI=;
 b=Rul/oQoAAAAbPkieDTqhIddjsfhjD8kkL1wlyc5Vga23lJNNH3hxrAs4YFXyABBBrjP2
 Ne4bZ7lyv9ZQQukyyn+HXDNVvEHSM+6iYuGPXqc0y6E95oe6Tf6moNu+uVEehkaJiLW3v
 3+zA5CY8A/uZv5ysEQ8pruK6uq7qxPIA6vZ+s7MHIIjEu7gkIIjrFNoldRz2reRb+yjpj
 3FFBnD91AdbFA2t9YFZN0y1jp0//8UiNYRGgC5Qkfn+LgA+Hc/rKQx/TazV/zv1lrmku/
 g4L8SQi4s/QzFJbl/rFh3yZP3CdA5u8/PwVXBBV3WhwpCGmfb0pvaS/vGKqiz5b+4jQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=ZPoyF6vc; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::532"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::532; helo=mail-ed1-x532.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=ZPoyF6vc
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EC1B5605F1
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 13:07:00 +0000 (UTC)
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-6b1ab2ad719so1111303a12.3
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 06:07:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792588018; cv=none;
 d=google.com; s=arc-20260327;
 b=llpmKFQYUAQEY7RMqB2ucYjjRl2hFKQmklEn8K3a84+LADhd5Zcp4jaFsDpfqmrARn
 uSGXLxr6q3oulkBw1hLa57I2Q/yNvdLY7Cge2o+CdUY/VyJNCRuhFTbOt0oZ9j67TodS
 h5OY1STjtii+bfKfl2rATHYUdQxsPgOhylQXSALF5dJoyILmWd2sV4WG5DZ/KtQeO5Da
 ZqOU0GEeDnIoZJwBeatVYS9V8+HlhqnM1xPOQICRDHk+vIDt1GqJrBiqtqBBvmq8q89C
 QcMRo1P7eK7U/crK84ElMdCIly9vf/onBRQ/TYu9eGuZ9uOg/YSqMioXApzGRPTtKfdv
 k8zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=YdjeIOw+KAyov2jf5VdnWhcO7YyG0rzUF/iK0UqmXLI=;
 fh=QSz2LWxXxIlE5sVY3cc6rCrz5I3EPoPd6wg5hM7ii44=;
 b=EwD7Y7tG6pGOSWQLWqyRIz2y8Aqb7rrpqPXmv43AaDkcLylrS7lh7m173wgGXU/XNf
 zhoRnYjZ3FSnU5uRzz/y0sbFrHp0LLiUQDVqOEk2eyfgY8a7rQVH2Zz7vHOyfRI6dg1V
 vqYHiZXi9CNySVt4MK0EaeQ3bMiJe4gNWmEmC9h9O2dkjgYF/hEqCHeQlaHpr4ZQahM8
 zPyoR4IlP09tFrjIoUW8ATemM0q3DsvM7n4zMeCfpu28Gp5+SHeDwxlq0Y1L+kVbuVea
 MgrWufFTeUU8eIn406pPDCBMnpWUpDB3EhJ8/gjFR4RhVewqGKybQGTJqiVBFUzUPfZh
 ffqg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792588018; x=1793192818;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=YdjeIOw+KAyov2jf5VdnWhcO7YyG0rzUF/iK0UqmXLI=;
 b=ZPoyF6vc4ot4Wg395gvVdlsjkF8E0IsrKVnEVO8/Po/VdKoD0sq9rQ4n53wGCRHXYe
 dpVeNfeCgmqZU5mkej0S1UUIksxP9bKXt3v4FI33QShdWNC3S0RSsjCH0ziw5+dWnJzs
 M/I/ZBBYGDXaJ59YtS91ZpoLbB5ZpV8b83mxA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792588018; x=1793192818;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=YdjeIOw+KAyov2jf5VdnWhcO7YyG0rzUF/iK0UqmXLI=;
 b=Hr7jWnFXHJuWCpMd/MvWRn3juQ1xbnPJZGifhlcRx1GchxX8tG5bCtdNwZv8FbS6DK
 tc5Qevwn2VxRwz6PyEO0xQtJ9uIwhKNG8aTY7mCLvJZcekr4CGRrprsOiqWiJm93vwA8
 qLDPJbmpXE8O0WN1lNQEf4GmQQ8mLNReORG9Gg00KpMRJv9tLNZZh7pW2eUOOQmMzx92
 CNXrXQF8bACN1WU6XXRQBPDvu/5avVKQ+8nKNMsJomIxzM+jb8DeihhegPr5yeFC5EAU
 dXMkTftpUrbt9+MR198dKcU6XywtPufo4U0RhGnyBJYM0gETDda4t0QUVNLseKBT3dVV
 Os+g==
X-Gm-Message-State: AFq9FYKMjFq9AvbC/CY2ioTgCe6NrQd16NtVX1NxxCEknldZFC9rmv5q
 BYJJpRQfGMqiaYfBqwgQLi55jPDXTTZCwbrox8BhyYkkN4LVBkb742coGXzK5hq9cfsBj3JuQEH
 zbv8xlwz8OZOYXOHdIlp26IFAB/gsLyC2YCBKSQV/
X-Gm-Gg: AYBFou1TGIpl5u85Jtor20gq3ZFdKj3Zl8rQa1iHCJt/ZHLbLpGDFx1rv8OrLwBJ/bp
 VvoGfZWQH/jsaJIXTf5WLybu4dNqRM8n3afoIlGs5+dXFpot9LcXqvvTdNJcLCTM9OXYdg7lTne
 kXvwkQsRicvK/VxzLKqM/LPFo1a3U083zo4fyfLinn6sn0UQBhlbsPOBvJM4/ygqWzN2Tu2e2jp
 0tpQE1ACrykikT5MHLOxoVu9onIEQe7+nvwCRRUaTvOHwUzepYmuFdAKUY1yPBTPoRox7JaPhLT
 aeYkLMVtdPgsVmK3xTs/Nc1B4paSn6zc090WZ777iBe/Iv0Zh+jDNoJtUzq/dJS64iwuY/bJezl
 9fWIcPjN8Q7dKvjG16QzgnNVtfKCdv7fx2hI=
X-Received: by 2002:a05:6402:28c8:b0:6b1:ba86:5f43 with SMTP id
 4fb4d7f45d1cf-6b408eb5c9cmr1277364a12.19.1792588018570; Wed, 21 Oct 2026
 06:06:58 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 21 Oct 2026 13:06:57 +0000
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 21 Oct 2026 11:42:32 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261013130235.3172204-2-hyyoxhk@163.com>
References: <20261013130235.3172204-1-hyyoxhk@163.com>
 <20261013130235.3172204-2-hyyoxhk@163.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 21 Oct 2026 13:06:57 +0000
X-Gm-Features: AclHuK-OLbWW917DP8-6abBD061aYhqDR3NMJQ8vtguJH8Iu0t8SNcRFgJDegLk
Message-ID: <CAFLszThRSWZg6T410jc6PSfKrBLWMnFk_+ywJ-fsdg-hFhsYOA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] image: Bound legacy script parsing by the image
 size
To: hyyoxhk@163.com
Cc: u-boot@lists.u-boot-project.org, sjg@chromium.org, trini@konsulko.com, 
 alchark@flipper.net, daniel@makrotopia.org, jbx6244@gmail.com, 
 quentin.schulz@cherry.de
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi He,

On 2026-10-13T13:02:35, He Yong <hyyoxhk@163.com> wrote:
> image: Bound legacy script parsing by the image size
>
> The legacy script parser ignores its size argument and walks a length
> table until it finds a zero word. A malformed image can run this walk
> past the image buffer or declare a script longer than the remaining data.
>
> Check known header and payload sizes before CRC verification, bound the
> length-table walk by the declared payload, and check the script length.
> When the caller does not know the buffer size, as with source, still use
> the header's declared data size to bound the length table and contents.
>
> Add C regression tests for both verification settings and for source.
>
> Signed-off-by: He Yong <hyyoxhk@163.com>
>
>  boot/image-board.c | 30 ++++++++++++++++++++-
>  include/image.h    |  3 ++-
>  test/boot/image.c  | 77 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 108 insertions(+), 2 deletions(-)

> diff --git a/boot/image-board.c b/boot/image-board.c
> @@ -988,15 +988,26 @@ int image_locate_script(void *buf, int size, const char *fit_uname,
> +	/* Format detection checks the FDT header, not just its magic. */
> +	if (size && size < sizeof(struct fdt_header)) {
> +		puts("Truncated script image\n");
> +		return 1;
> +	}

Since this check applies to FIT images too, it would be worth passing
the size along in the FIT case as well, i.e. fit_check_format(fit_hdr,
size ? size : IMAGE_SIZE_INVAL) - with FIT_FULL_CHECK the FIT is then
bounded by the real buffer rather than by its own totalsize. This
could be a follow-up, but it may let patch 2 drop some of its own
fdt_check_full() handling. What do you think?

> diff --git a/test/boot/image.c b/test/boot/image.c
> @@ -100,3 +104,76 @@ static int test_image_phase(struct unit_test_state *uts)
> +	for (verify = 0; verify < 2; verify++) {
> +		ut_assertok(env_set("verify", verify ? "yes" : "no"));

The test leaves 'verify' set when it finishes, and if an assertion
fails in the first pass it stays at 'no' for later tests. Please can
you clear it at the end with env_set('verify', NULL)?

> diff --git a/test/boot/image.c b/test/boot/image.c
> @@ -100,3 +104,76 @@ static int test_image_phase(struct unit_test_state *uts)
> +
> +BOOTSTD_TEST(image_legacy_script_bounds, UTF_DM | UTF_SCAN_FDT);

This test doesn't use driver model or the devicetree, so the flags can
be 0, as with the other tests in this file. Please also drop the blank
line before BOOTSTD_TEST(), to match the rest of the file.

Regards,
Simon
