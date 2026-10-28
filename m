Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C716606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 07:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=tU+IZ21J;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=cetzUpKe
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 51DEC60600;
	Wed, 28 Oct 2026 07:37:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id t-e7Y5bRmLZw; Wed, 28 Oct 2026 07:37:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9ECB160658
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793173034;
	b=Z0RvpnqU9ZfQCUT+rTn0WEKnDLrPfT+phNx4FHnVfmAUmXdf6eebZ1LjwkAL/AKicz2E
	 9G+uX0Ixrg59oa8FYlIFHfxAPPYy6bSRlB7fl5VFcP7pWKzeWYBlDGRR3CpJnWOSEwyup
	 A4+Gz6cGRHEt1IV362aIxyl7LM4neGz9B4ahDQpG3ZsH/DlBssUsCx8TTwolc+/QZjGhi
	 HW1GzoYSvQxsMb93OQXQsNvbDPL9UHHIhyj6K5LDBUzCkCovPFAlmUW0Pp/HlpAv2q0Fx
	 HP4usp1iWfAa3JAnH0TPIgQgoBX0yS5EBZCOt7UlbL5bv7rnQF4TbHKy/zgtv5S1GPw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793173034;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=KVOpSbYiqqGmLyVOKO/YJSSfGENRbcRlPhEyQx3drks=;
	b=fq308vG1s3j+Vkya9dT10tIjMniO0BBhyZ1F1+U+EhkMNXhAJmcwjL+jtYfW2Dl6GKAX
	 WIVh7W+9/vZuFmLp+25zAIyW+ONOO73p37EoYcrOObJ9nKJ0PhQUXInwbkV4R68D+UH4n
	 jZMz9nEfDG/y16r8yFq5UWk+VtWQ1hOe4GpBEcw5c5ExRpvbhoPhvc4OLZZ/graaAX3ka
	 M7nyKxfmy+sT1Z6OBDfYRyE9R4IjLIKixLuv+Wh8qHq0M0k95BxoGUJdoT+MVK4KtDwzl
	 c4A+ReyEGMcQEaRoPa5fs/F19k1Prgqv7MaUcamvVIF+Nx1TcXUpPaphWBGu17A56ow==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=cetzUpKe;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793173034;
	bh=KVOpSbYiqqGmLyVOKO/YJSSfGENRbcRlPhEyQx3drks=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tU+IZ21J93jEGxEO6cDTEHMTDKvY8zd8WfTRRcw4E4B0I7v5gltCNR7WEuLWbuf8M
	 5R9gvLuYMx82NkKtPc7ijkb9VVB0w0+nKO3g80mCiuWlkdp7siOM9XmqPIEJrgH61I
	 cP3bdcacwgRRWGo/C6yTvJZLA+d6EvCeVE16kQpZ1UDRZUtuxF7Q9DniyQVbPLLtW+
	 nCcM8qYTg0yaP0EKugad/XcJeTJkFMrfXsQ/aLEx6bBNAgYBw+mRF9AicuDuxVJ9z9
	 Q8lvFfZzBTsSHqA/Y3IfBwfziM/C+6cImquYrRGLZdr7+9CCpaqK3pNSubHeapjbs0
	 1JujOnM16/FwQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9ECB160658;
	Wed, 28 Oct 2026 07:37:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id E92874BC
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 07:37:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E686660658
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 07:37:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WdW5KVg2yX9f for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 07:37:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1D4AF60600
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::535"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793173032;
 b=qpFcSMprXn8l0nCtfgbGIourJI/44+fHohbqeczmvB5P9HgnV9jItIRauG5MkqbRG2dg
 3931WTziPayUYnjaspmgB0mGA9dTIWXdrTdfL/6IdDBzLaib/WPbp9rd4cnOOIsEXiCTd
 p/6I6voUn3gTk+pYXPYUUotrUF55eMe/O7dN1M0mbmfv7mULTq6arKGFHC7UzaMge1JBV
 k3HDquAKFCaSxZkDEi48hEANieith75hLY64/tqkvdmvbsu1Qt8SAC6mp/5yY9+XNejW2
 Cd5uJVaaX4V5qdV7v8mSxqIwzODX/XyTxgHLqnIVGEFeDaOwao9RNZyQw+Pg7y430xQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793173032;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=KVOpSbYiqqGmLyVOKO/YJSSfGENRbcRlPhEyQx3drks=;
 b=rTu7NHOY86RXmhuQ2d9ZGUbZLYN7i8DFgMsTz9H2drfjiPjQiyygfc03QLVpe3zT2LWD
 Ep3bcYhrFURMDRYlRqdQhYhX+V4lKBLp8aIossbVK24D8Koivx0oEFJC1vCbaL5MVzL3J
 YQ2CxFUOEOkvgiuWp/g+rhCHOOFbh7gGGylHNZ8VsC+DnjVp0py1KLin25InmHZ1UeK7Y
 GRJJ/GLg0uh6OSG05coEDMxpvaI5mt9p9tYUyyB9y/LAWvBxHkdnD30Ld5izLl0V9x541
 PBM63htsMVgvo6tlXK9ggoqqPEdQhRsSvf7QZfXvFflclMb1w0ohduSBrBaz16uPtrw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=cetzUpKe; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::535"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::535; helo=mail-ed1-x535.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=cetzUpKe
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1D4AF60600
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 07:37:11 +0000 (UTC)
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-6b4883643ccso892408a12.1
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 00:37:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793173029; cv=none;
 d=google.com; s=arc-20260327;
 b=dlSb6rwgnc0LSJrtDvYrj8xQIjk1V0pX8FR//voM830YVJXFlmb8gGeTM3Y9OqdIv/
 kQa1AIEMKBtPZZC+eViqHpnekf6Yyj5gLLfRBzRRjAKPA1gQCPP4ZgRZkPFR3q2onRbw
 vFvJcBb2W2t84lgidXtgodC1R0lXVXsaVVr52+GUhsiHsV3jLh6Bvy/yAc2C+ojiuo6i
 rIUdd9KXjjlUawpgP2Xuz7z6aJSMVCLQ/oJ4Dt66eUmv+M6N9hBnecCdz5keoqixaXRL
 qv5vVdRT+W972ECLok0qB+B6oDYJjLEXO4XklEOhskZlxJhdRByijKHBBZtr6AIJ+YY5
 b6tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=KVOpSbYiqqGmLyVOKO/YJSSfGENRbcRlPhEyQx3drks=;
 fh=E5ncwAXvj+1TEgtZiDwgPsBtKE5ROoQWMd3lePOvwso=;
 b=fKbm2JLKLjBFDVnilZRyiD1di5ii0YJ8f8vFJRtzPs/gCh3EBW/0QUfW0IN2BB7Vee
 FT4WDeDDYKN1De02A4LtipJYEkLbVrQAjGGoIm9FJCPG3m/AXV072A6lJcj7iY/4nyuN
 0oibA1OKmwb+yeawzqkwMN6rf7Dwr8jgScTwkjf3EAfaDVXgVFl/RIH4/f5CJJ5ZTjyy
 nLPw4UdCpIkazWXvLjykOYfqSBBGdFT7x5sKNPyAgvh3piixQAxRtFoXo47UvvmHkNpk
 lDezoDlD8sRWADS09uW6cc9ppjA3LBMGYOCUKlacdspyQErZzu9sMQLHcDQcauD/l5vi
 gwDA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793173029; x=1793777829;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=KVOpSbYiqqGmLyVOKO/YJSSfGENRbcRlPhEyQx3drks=;
 b=cetzUpKe9ZM867hPmffWb2DRlzOHrQYXSN6x/f86bghpqjdHLJ0RlU9girysZOgdKH
 T1SN0dixUftl0JqUgqwaJM7EjSZvousb1z4LLqNPz52+lZ5augLgZN2eEflLCEwfUpA3
 qaZysy2ehnOgDrY5QEiTF7UQB2dGOIF+fZOrI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793173029; x=1793777829;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=KVOpSbYiqqGmLyVOKO/YJSSfGENRbcRlPhEyQx3drks=;
 b=xOuIlvPe+LbIBSO7qS6Cjb5uL8KI7GW4P2vPnTttNmOgcIzLox4jhEJn3OB8SDXv+h
 A47GnYZ9gBuVcbhTuemW7T4S7XybWcVGwnINKdWQWs9vN9IBQvrP0wTuXeMDbTyiUJQ6
 NUvceYgkafQQsRvk8hXQ+1l4u8Ekb6/diQ2usmu9OPQWk5BXHOb7fUOHULivwOzJZ0pj
 Rq6Ovm2MJzoIZA/zuApX6OaB4+MUPruyghDFbagNnFkNKHwsZljMvUgNFw6hPxwBpVYM
 oEOV7iy/kw0J98mM1X58vGXxGGz1EiBNrqsk2QniOz3F/fvslzuyhQswlfzBdZ3SlyrB
 L5rg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzNa/GEl1wSI8XDK80RJnYxYGkC2eSw+sV1s/cDBiYv9/gpAYcpCx0vusS9zeEplWLznamPf6c=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYI7vfdj8Sc7x7evG5G9SlEeYvRpVHzMFr+EeZvV76/fT05jriIv
 j3AnidIF7n68XiRrK+i0eM3WH1OuY1C65UMUSLSyd9CkcTDOaXylM8IYFQ2r+zMrw/kE0rTHWV0
 Ehz6stW0XehKXRy3iRzlHmUk5bI24lj1zaREagdWM
X-Gm-Gg: AYBFou2tCIawC5sjRYbSwIhzW+g303KV54LN9VNQl2CQ9AyVGUDA8SYklHV/XC4+0Qf
 LZ1Ps0q2vSWpIKu82KumoC2rkz/Wkp3ITKE16qxieSAedRsiHZBdk/zkiKQ+6p4eoUByZD0uDfi
 OCKZb5QDPhhf7FxrzKupWxEyJOKSJpV1MPQ26PfQGFjpjhxzAxqLkzOzWLg051r7dV/tUQ6Ga/c
 3aFUN0x3il8rqN9RnL1RfVIkVafrUQxrk2riKAy96YM1i1lfJBwYZTdQyPFMcqomCo4c2ViZ/Fj
 so+AAXARi1LtNKwG5GWs6CokqYSrP8Q+Jo17qBCHRQ97+Oa70JrjAecY3DtgxRS+Mvqlte7uX15
 zbgKQ+YsKTxcl8l6JWCo6PpdzRgvkaws8w2E=
X-Received: by 2002:a05:6402:6d0:b0:6af:bc82:e126 with SMTP id
 4fb4d7f45d1cf-6b49cc1c3aemr594877a12.44.1793173029447; Wed, 28 Oct 2026
 00:37:09 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 28 Oct 2026 00:37:08 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 28 Oct 2026 02:23:21 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261027185337.51168-1-oss.patchbox@gmail.com>
References: <20261027185337.51168-1-oss.patchbox@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 28 Oct 2026 00:37:08 -0700
X-Gm-Features: AclHuK-PBVSZdg5CmWBy7T1ob_7BWIydpzEMu03-iZ_IowCkA4RPto6OpBd-2pk
Message-ID: <CAFLszThPNOJFqHrGBxyNYDQG4jtocBtyx_1LYukaezm=jMH7JA@mail.gmail.com>
Subject: Re: [PATCH] virtio: free device name when the driver is not configured
To: oss.patchbox@gmail.com
Cc: Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>, 
 u-boot@lists.u-boot-project.org
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-27T18:52:31, Yuho Choi <oss.patchbox@gmail.com> wrote:
> virtio: free device name when the driver is not configured
>
> virtio_uclass_post_probe() duplicates the name for the child device with
> strdup() and passes it to device_bind_driver(). If the driver for the
> reported device type is not built, device_bind_driver() returns -ENOENT
> and the function returns 0 without freeing the name. Ownership of the
> name only passes to the device through device_set_name_alloced() after
> a successful bind.
>
> This happens on each probe of a virtio transport whose device type is
> listed in virtio_drv_name[] but whose driver is disabled, e.g. a
> virtio-9p device on a QEMU target without CONFIG_VIRTIO_9P, or the
> virtio-blk node of the sandbox test device tree, as sandbox_defconfig
> does not enable CONFIG_VIRTIO_BLK.
>
> Free the name on this path as well.
>
> Fixes: 8fb49b4c7a82 ("dm: Add a new uclass driver for VirtIO transport devices")
> Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
>
>  drivers/virtio/virtio-uclass.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
