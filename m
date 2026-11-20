Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803F7606A691
	for <u-boot@archiver.kernel.org>; Fri, 20 Nov 2026 21:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=oCMwq+rr;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=oqJ4l0CP
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4AB998144C;
	Fri, 20 Nov 2026 21:21:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 47w-pzcZ8ZDK; Fri, 20 Nov 2026 21:21:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 945DF816D5
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795209665;
	b=dsHiPJcl0TKi2X4jEMPPuZoTOAoG/IsE0/TW+F7xBjVw+VE1QZGX8Zk7PAyTJeUaJOAs
	 dDoPRfPTjZxVQ/UI++7iW83MWlWBuPcLp5UuM2OGqDqGin3r9R2QxTR02ElDP6SL+W1ix
	 zbIQBNG+aiwMFjcxbxSC0zhl/rdDv8Sn/LR5BDk8puOntYCAXOZa8XV4UDLPWaEHi3sup
	 aTceHyYsrRtBkZZiKXA1CVpz76/7WGDyqWNWO0brINjXPcQZ+J0+ZjJqDD2XFpSIijRx9
	 hPDTyzkXA4Vm4a5tveRx9zcdAw07uQ9+NYiDocwT6av74fDIokvKpaW49Yk82uczRlA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795209665;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=/bp17v/3ZHhsoQMU6nx2J6BcLDJx76v/oDq4/FAEwGw=;
	b=UC8tUy25jmBgvitKrh/jICjxwHayjxQdd3od4e6NeYxwB0cZxUISffSbrYuzZb1SGK1f
	 0cPBurf6NQT3MjfCmw0ZonJ4G7ireHhUFgbu7pyAjx82kN+OkL75TZ10QNIltFha49YjU
	 O19SSnFPy46N/1eEUXnzwq/iNXEsvoXX4HXobOQiFwLffxxCVUjTZdnij6zFILEaMbKJs
	 8grcQdipgeZZDXGpI/0RJ/9VkYT3tIpW4tK3t3QvQu2RRzIxhdOytTy1yIEW5AbSA30sK
	 QyR7SDlvReXSwt3dDHA4EHP5E27n1rOtA+MVel/MIoYTV64E8AjzqmsyAEWNTIVE0XQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795209665;
	bh=/bp17v/3ZHhsoQMU6nx2J6BcLDJx76v/oDq4/FAEwGw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oCMwq+rruvMg7TIE1R8M1ep65+3YATCvZwsti83lXpAhsTRSu/oYNyKEi8Yxo6tdN
	 aV6rFKALcoMMAtq6j6izPTbVhM8t8Arx2/uCCWw1n1wyBhaniQr5lsujTJ7LQcQDsG
	 LE3NO3S9SyJWpl+dTWE93szxx0UbwvmutpTLliisy7ZtIyTiNe+wtnVwDsKPVZK41G
	 uFmkKkmGbBMLeQWfoabEh6T3xbXr3AIl8zwdFj3GyGD25CSdXAiYveodR9kh5C/olx
	 dCNp2cuJ6w766R1QNythTVzbIx6yOYx/12Hq1abW0bjASuY/hX0E8qh0XH5zja71Wt
	 IiM4esVEaAZFQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 945DF816D5;
	Fri, 20 Nov 2026 21:21:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 9551B9C1
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 21:21:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7B3B960E9E
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 21:21:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pTsN94_2W4Ak for <u-boot@lists.u-boot-project.org>;
 Fri, 20 Nov 2026 21:21:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9042260E9C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::b12b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::b12b; helo=mail-yx1-xb12b.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=oqJ4l0CP
Received: from mail-yx1-xb12b.google.com (mail-yx1-xb12b.google.com
 [IPv6:2607:f8b0:4864:20::b12b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9042260E9C
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 21:21:03 +0000 (UTC)
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-67db23d8892so1616785d50.2
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 13:21:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795209662; x=1795814462;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=/bp17v/3ZHhsoQMU6nx2J6BcLDJx76v/oDq4/FAEwGw=;
 b=oqJ4l0CP0lxjF4GLADmeTozdcf1p6KZV0NguvHU+h2wniu7irnHlo+axKhIY42n+QU
 Kpp1qa7Fvr7L0ni9z3UJ7pKE5yUVM9iSJvs3dKfZygX/3LfNyP53R1cOEOT59t7LtV/X
 eqokDXphCMiMsidWAeTs38JG52/l+R6li49NJvyJJp1wOFkMfnlsrRuOWneTPGAoFSYk
 Hy98SZMyAnD+sXHzBL/2ffAG4gVxnjRjEPTvYIMf6dGmLmvgdyfjjFyJKSM1JN45khAw
 gKjE1CuXeTm0zmmM5ASs2t4eZfragOJxz70VQjojdemWwHgkuhp7XuxT/g/im4CWeOXG
 oI7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795209662; x=1795814462;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=/bp17v/3ZHhsoQMU6nx2J6BcLDJx76v/oDq4/FAEwGw=;
 b=dEb+opweMrVzz/GEbYxUTYyKNsrs4PuV8alGLgCQUQ0fKaQDsGiK+KWLi9Nb0VtEUi
 qWE12LsYfMqG/fxayg/oRMi/6nnr7cqpIKoCQ0KslRZ2fbkUbcdUajJ+ZB91gMf0JuKv
 u1GTW5mTnJHep5tcq7nQyqXSjh3iI5zMjCTD1pLOhJ4h+zTeqQswKMGWKP1W2xGvxJ8Z
 UhDGRUBKEdDX2M5G2WDjW+3Q3XQzFUhQvsVHUyyuPhGM+MaCJvBnzw/8yvteZeSML9kz
 A4YyntdaMzFldPSBxlKIssXzt7G6/3ZHO3tNk8aCUla+WNsY23gFuRsXo042cbyPhvQ4
 Rvlw==
X-Gm-Message-State: APuU4Z8vBQkqAQQ4wlVK0g7FVLrc5vg7dOQeATcw4+Pv5ydbA5fu9BY6
 VS8hJVr6+avPjGe3RmdmyG1n7HtuJnwU/lBLH1IjK+RunxcV58qpHmipKh/6WZhu1QfmDaF2BRY
 0U2MZvlM1aR9IPaFUvgyCvT9J4h46AoKHbyuY+Pm5k3kMQEx2UyMx3zyMfQ==
X-Gm-Gg: AZFdTZd33uYcX9TCm2aZLgT/HvS5k3Lx9yFDxDPgR4+T2U7chhBPw3bOx2n7WSrUBU7
 wuJ3/8z/ckORLzXiE4pALf5cFel8DVCeH0TEAO5yMNWlPEc27CTxQqRemLGVB61iIcJ8Wn4i5qs
 Yq4gtio5mZKtgjSvXA1+mMkz+jyv9zc8GVPEUeAPYwq2Oy+jOip/FjaQcJK60P7J++kxcl1A0/s
 ZduGtiV+AIOR8LyAYTvQ/aDpZl9ne7Fd6BDFzKzA1R+mYXNwWv7HoKLmSSD7MfKTG401HkbgKIW
 2/z3D4BiQis+pJHe4hlHldQ8b/omlHVhA+mTI6WBb2s/7gE4IuFTQTlYXk10mJ195+riNhMiGdr
 UQw+BtIvDL2bVRZNtRkQTV5rwIb6nu+s3IVeumWRqTTXjv/YM6b4SMLO6DrumZBX/13BzW76anD
 t3JiGan1R6ZAkdLghysPgUK2zPEFKhmos9u7iuH6L4L3pNvkf7ngwjJ0wZurhAyotOTjkvkN2+U
 YqQUMAjAiBCS5YXCVk1Rd9cbc3d4xkJj7hw/Ryy3gfBp01PUszwo376hKx4dHjcXc1ZfsFcgYbr
 9IxsTbS+uC0tXiYCFCIffMssmwjbYneaQcHocN8BqdCiEEYw5quQwCmvvmqAnoBS4njzVrKtW+q
 pTRSJSVbGFSeZo55BmRSJqLUAwxLyHbtxW09p0ncQwqaq2uGJjBVhhLCTjk39fPwIfGg1ZIuN1J
 tGuxcLCVvJa3DThjcMNNumI/RqroMVDbbLPpcJqckVjyGhC2T2574KcqOTI5YGTxHfxLmm
X-Received: by 2002:a05:690e:4085:b0:67d:ad36:d42c with SMTP id
 956f58d0204a3-67df42b39eamr2556768d50.15.1795209661976; Fri, 20 Nov 2026
 13:21:01 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261120-apple-t603x-support-v2-0-606b4f5fadc5@jannau.net>
 <20261120-apple-t603x-support-v2-1-606b4f5fadc5@jannau.net>
In-Reply-To: <20261120-apple-t603x-support-v2-1-606b4f5fadc5@jannau.net>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 20 Nov 2026 23:20:26 +0200
X-Gm-Features: AclHuK9YCo6VcZCZmjmXNJz4X_tAXUrjkN_lG45o4-XNklGa59kRk_S3c5e06Bs
Message-ID: <CAC_iWjJLyyBxiukx5VofONZ7ni4+KDMFDD6XrdEzTdtk8Vvnig@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] doc: apple: Add Apple M3 as supported SoC
To: Janne Grunau <j@jannau.net>
Cc: u-boot@lists.u-boot-project.org, Mark Kettenis <kettenis@openbsd.org>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 asahi@lists.linux.dev, Anshul Dalal <anshuld@ti.com>
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 20 Nov 2026 at 20:53, Janne Grunau <j@jannau.net> wrote:
>
> Adding M3 (t8122) to the documentation was missed in commit a1a47eee6763
> ("arm: apple: Add Apple M3 (t8122) support").
> Since Apple silicon SoCs have switched to upstream DTS stop listing SoCs
> with device trees. The expectation is that u-boot support is added
> together with Linux support. So the device trees might lag a little
> behind. Since u-boot's dtbs are usually not used on Apple SoCs this is
> not an issue.
>
> Fixes: a1a47eee6763 ("arm: apple: Add Apple M3 (t8122) support")
> Signed-off-by: Janne Grunau <j@jannau.net>
> ---

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>  doc/board/apple/m1.rst | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/doc/board/apple/m1.rst b/doc/board/apple/m1.rst
> index 900c5e6d91ea..66ed247eca26 100644
> --- a/doc/board/apple/m1.rst
> +++ b/doc/board/apple/m1.rst
> @@ -9,6 +9,7 @@ the following SoCs work:
>
>   - Apple M1 SoC (t8103)
>   - Apple M2 SoC (t8112)
> + - Apple M3 SoC (t8122)
>   - Apple M1 Pro SoC (t6000)
>   - Apple M1 Max SoC (t6001)
>   - Apple M1 Ultra SoC (t6002)
> @@ -24,8 +25,8 @@ On these SoCs the following hardware is supported:
>   - NVMe storage
>   - USB 3.1 Type-C ports
>
> -Device trees are provided in dts/upstream/src/arm64/apple/ and available
> -for all M1 and M2 (t8103, t8112, t600x and t602x) devices.
> +Device trees are provided in dts/upstream/src/arm64/apple/ and available once
> +they are merged in the Linux kernel tree.
>
>  Building U-Boot
>  ---------------
> @@ -82,5 +83,7 @@ supported SoCs.
>       - Base Address
>     * - M1 (t8103) and M2 (t8112)
>       - 0x235200000
> +   * - M3 (t8122)
> +     - 0x2a1200000
>     * - M1 Pro/Max/Ultra (t6000/t6001/t6002) and M2 Pro/Max/Ultra (t6020/t6021/t6022)
>       - 0x39b200000
>
> --
> 2.56.1
>
