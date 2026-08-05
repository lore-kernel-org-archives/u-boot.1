Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ABBEC55ABF
	for <u-boot@archiver.kernel.org>; Wed,  5 Aug 2026 21:59:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3362480E29;
	Wed,  5 Aug 2026 21:59:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zraxss1vcEZ3; Wed,  5 Aug 2026 21:59:24 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B00C480E0F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785967164;
	bh=b/DEySmaDw06PaZtqea+HESyHxWcfhD3tae/CdXHBBU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HBMKhR5OiYAylVYnbrtX7B0fpUmBVXOVd28tuP3HGfpU5ZjRV6J+U9+Oklfg6hdXC
	 r3C7FtfxJN9Hpwz9lGiXCq3sY6tczP1DGryy4BBzKfWnaidAopKpqPVEkO8/hUP1Av
	 VFyE2hNSHVy2zSfKeZNe1+R9pZhA1UK3GeZKwH+xrxpsn7aypJGgLxdpffcaN0DcYd
	 EPGNQFFF5A7J3+R3AAacvKPNiNBAdek6jKYXvdv2rwn2MO9iL7bZ9GsPtTU2KIOIhh
	 H5pNyBFMR/NiC/360aLSDhFBvZZlwifOWWSBFT+gDylSB2IN7qvlIejJTFntDLtiYU
	 eNHIgGe12gcrg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B00C480E0F;
	Wed,  5 Aug 2026 21:59:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5663C2A8
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 21:59:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3CC3C40251
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 21:59:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jKabnKdjXXb9 for <u-boot@lists.u-boot-project.org>;
 Wed,  5 Aug 2026 21:59:22 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::102c; helo=mail-pj1-x102c.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 8108040249
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8108040249
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8108040249
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 21:59:22 +0000 (UTC)
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-38e347638adso1664191a91.0
 for <u-boot@lists.u-boot-project.org>; Wed, 05 Aug 2026 14:59:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785967162; cv=none;
 d=google.com; s=arc-20260327;
 b=IqmAhghmwjNNAB+oMW8mq0ZkgLR7TK9R1vTs+2UAoM0P9HpWRLT1GDx/BWAqne1W2i
 jb5ZS9KJxfy+eVMhJH86TwPgGHVcszEmBAoKbJBZs1g+tE847d/R9kyOLhLKy5b1c8CS
 Ugl1NPTg1ZBpG8WtmoxG0n47NkKOW1iB/8BA2wZpXSb1dNCG/CJh3PilFWQbHmwcPajG
 TNZn5FwxFO3/nU597uZNzWEir6sX930LxYyfDzZg+7rF3whbqhF9shZyn0gdOUQ5zI3s
 5UvaZsxA+fpIP0kwEc5KKaK8z165qlwMvzXbRBt0+2WGxfFC7ttRqXtpg6VOg/UcfSQy
 3cUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=b/DEySmaDw06PaZtqea+HESyHxWcfhD3tae/CdXHBBU=;
 fh=9FcJG/5ehgkA/kaIH0gZFSvUHKLT4aoWNYklYlu4sK4=;
 b=mOsIpKmOH9ZxUQ0G6yN5M5QgvUQCWTQD/kNvKtfS+c2vELRq8e3DKd3zj1h5FyO9X+
 +2E6pAJtfG14ExPQJ/JAj0y7kXNTeJNbzcme1VfqSXyrO34KRwhJmyi3LqVr+vd9UT79
 uEkW6BC08VsbtJcdhceJN0bAR2ux3n8jBkGdL3z1Rc4g7uVodPdrBI795CtuYtGuk9Vs
 ozdjuiFOxvTXLMOOMKdtcQivgxApMxwQAGn8wyZB0NeA035M0KGZtkj5NxpSAW0QO0aw
 MMAyb1TZb30vSDfQl0NNfXXnYIFQnbLWpd4bfxxjNKHD/I/RSRkUFnsGtWb8IWTGXAR5
 leWA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785967162; x=1786571962;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=b/DEySmaDw06PaZtqea+HESyHxWcfhD3tae/CdXHBBU=;
 b=Q3Zc2XhGq4elFWXXOaxDDDvvYqZDY1E83yZck20fsc5gW7TZs2CoRCvX+5kaJd183r
 5mAuvyjLCEuCmPx3yTmFTKfnTo54gAk5ThpSQOl4X25GnKk6KGtrJCXH/4ZV+tKb2Pxo
 b6XP3hLKw/OPeDKAFdFRS4Cdl1TKw5pu5Y5W41iMMtKp8M+zD0ZHi6IVEqkmjdPYScaz
 w3mXYRrflIFUmVSqizRb4cDoEx1+9hbmJA6DQUl2I3rDc5sblyPtXEe9S1SHcGB3EsBn
 WHms+wXX2sETzG2XFMk0QaR75QCqglk2XZfUiJZShdhlyaxi8byj9lM24sf5oM7BXyBk
 zXyQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq+f8USUAN4Q7A8qs7j2h2FEvBIkqIxSIde0d6YQJIcbeCOgb/FYdEs5IVIyqUxGH9oSOh100I=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YwyRgMJ080RAjIJ5sMKrq7WVc7YpivMh9Bbx/VxcY/21vIwJzh4
 WC5WmzWmrCwFE+MVU3zN3cSeFGvtTQulYuWCg0eCujyF3pSA/1qBBcBo23zX+QYUVkQW19tpkEA
 zEn05V57/S19l9QqfAglSWMm+234wsDGhPuPr3s+A
X-Gm-Gg: AR+sD13/8cfKZdQAKdp34oWD8xUa6L+M/mHdCbBtmeT8ERGqxfvIsPgqCdIikfggNvb
 0lP8xMhlnH3sLlXd6pmHIqxeZKp7Km3XF2aLqXa0yjyLTjf8+2mfZJ81j0/NU0ItXC4J4GcJUSm
 tCiLs3mIDZ3uBlvVK+uohmayNI8KNw9g638DpQ7PcHkorDz+1hr/35F/lW+94iqLCj6peLo1Dok
 B2SdQwxbUAr1ef0K5PGs6q0nsQWGvYBFXrZhjhebBChbSV6PZmit9sO+3Ia10ZgWbEKmL/CMpNV
 KXcH2mJ4F+sCg+64L27t3oDkFUx2zvxEgYoh43fM0QM=
X-Received: by 2002:a17:90b:3c06:b0:381:a766:efcc with SMTP id
 98e67ed59e1d1-3903c5bcd66mr10260826a91.14.1785967161659; Wed, 05 Aug 2026
 14:59:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260730-math64-resync-v1-0-8792d9119d49@flipper.net>
 <20260730-math64-resync-v1-4-8792d9119d49@flipper.net>
In-Reply-To: <20260730-math64-resync-v1-4-8792d9119d49@flipper.net>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 5 Aug 2026 15:58:59 -0600
X-Gm-Features: AUfX_mytF994F3Axej_-v46EluLbGow-MXCBMFi12UfpSIy7Y8qTJ3wYgR1NIJk
Message-ID: <CAFLszTjtp1ef6RS3BBgJR=U=AEcRdELchZMaZFgWP9S1eHdktQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] lib: div64: sync with Linux v7.1
To: alchark@flipper.net
Cc: Peng Fan <peng.fan@nxp.com>, u-boot@lists.u-boot-project.org, 
 Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785967162; x=1786571962;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=b/DEySmaDw06PaZtqea+HESyHxWcfhD3tae/CdXHBBU=;
 b=i+nFWiYvxfAtjrYIkQd481ROTaUzgbC77dARTcBBE1CGQHVVYwkGGXM7QxKL4Vio31
 2k4vrbRx2fvMJ/+++Vy2LE/PtSbNuL42cbK3fjz7sTZF7TZDjg/0efh+sAjtA9EY/PVO
 Ss3aqXwOvxIIoiF5ZMG+oBN5xdi4id2/ogoTA=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=i+nFWiYv
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 2026-07-30T18:40:37, Alexey Charkov <alchark@flipper.net> wrote:
> lib: div64: sync with Linux v7.1
>
> Bring the structure of this file in line with Linux v7.1
> lib/math/div64.c, so that future resyncs are a near-verbatim diff. No
> functional change: the compiled lib/div64.o is byte-identical before and
> after, verified by comparing objdump -d output for both
> evb-rk3288-rk808_defconfig (32-bit, where these out-of-line helpers are
> actually built) and generic-rk3576_defconfig (64-bit).
>
>  - Add the SPDX license identifier, as upstream did in commit
>    b24413180f56 ("License cleanup: add SPDX GPL-2.0 license identifier
>    to files with no license").
>
>  - Demote the kernel-doc blocks on div64_u64_rem() and div64_u64() to
>    plain comments and drop the one on div64_s64() entirely, following
>    upstream commit d28a1de5d112 ("math64: favor kernel-doc from header
>    files"). The kernel-doc for these lands in <linux/math64.h> in a
>    later patch of this series; keeping it in both places would only let
>    the two copies drift apart.
>
>  - Guard iter_div_u64_rem() with #ifndef iter_div_u64_rem, matching
>    upstream, so an arch can override it the same way it can override
>    the other helpers here.
>
> Two U-Boot-local deviations are kept deliberately and are now marked as
> such so that the next resync does not silently drop them:
>
>  - __div64_32() carries a no_instrument_function attribute, needed
>    because CONFIG_TRACE builds with -finstrument-functions and this
>    function is reachable from tracing code via do_div().
>
>  - The includes stay as they are. <linux/compat.h> provides U-Boot's
>    no-op EXPORT_SYMBOL() in place of upstream's <linux/export.h>, and
>    <linux/kernel.h> provides abs()/abs64() in place of upstream's
>    <linux/math.h>, which U-Boot does not have.
>
> The u32/u64 spelling is also left alone rather than converted to Linux's
> uint32_t/uint64_t: U-Boot's <div64.h> already made the opposite choice,
> and matching Linux here would make the two files inconsistent for no
> benefit.
>
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
>
> lib/div64.c | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
