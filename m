Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F91606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 10:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=GIiXbA62;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=NcQSnrsc
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2342A809EE;
	Wed, 28 Oct 2026 10:14:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LH0fXG4I1Z4x; Wed, 28 Oct 2026 10:14:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 66CBA80AA1
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793182479;
	b=IydeiPA9wgZdUTPWtcHxmgMOHjlnq3o8XGZ7sElrFExcLbWwgkA9u9yFLaMB94SLKZaW
	 m0dmWZLM82dIwZVSK3AtEyYIDbeapfBPFf72y4KZDRrZ7JlZ7Ck26EV5jvVXN40Nz/O2C
	 VQqIQJZlvHc9nfZFGi3ZSqdgF/Tjbk2Z8QL3xCE1q+xoi3PbU5+VLAvmXbNsEPLOEgBJt
	 F0zXyQRIr9EkwY90v2D9WnQp/vhjs/5zqqFpjz3P4wnGN02vuarMFPdqQm9j0zB2bmEHU
	 bmfR4KM1htdZ7+b9D4ExpMNIXPJDVjW/+angKWpA/8Drv+Km6CuPWhjlA9pMh5AbGdg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793182479;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 from:In-Reply-To:References:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=PUsSNgzrLpgYiXD+thwlTpNq3IatIORYNszTHycqhUs=;
	b=ZaAHoGO2qpNc8I4enrWyTI65HQECBvoGglhlg8p4q56R4IY3xU7oo0e+GWnudVg5S3Ui
	 Guv6hRBeWTFgeothFM8qH6/I79ENJ8D0/knn466jIcVy/h5MuL6/wZSrAeEiNu7FZcePx
	 hJRd4UzVhX25VOSCQEGkN5o16krWRH4kdFGYAtvFnxwk5tSF6F/TqPoLLmiKMPnGMyZQQ
	 prXRiSnyiaDDgENGsuiAPy0uB4xsgyuQqGMCYEn1BnWXbwHTYQUT2iBoTa0vd0j0+7yk9
	 j7O3kZy9sFxfkZTkgvZFJcv2lzvd/drRCLUorTEe4l+F8HCwLWP/qpfVG/dcYykNkNg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793182479;
	bh=PUsSNgzrLpgYiXD+thwlTpNq3IatIORYNszTHycqhUs=;
	h=from:In-Reply-To:References:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GIiXbA62vCZPEP2IY9nVd72RdS4VTRKNc1l1F4rce5t6420/TltmR2q2klG8ju2QW
	 tzIIpFktpnkqeebQxgmkuRBTsqqmtgzYwj5dXC4ruT3gSymIze6jTav2oZKCoWU1Cl
	 UjZEZZOZ42VqvqmKuE70ZOMTMekS4uN7XCLT/ukK7m2LCG3eSAamlXE5I5mGBsyowv
	 gXmu77NzvMmCSOQF2LZG/czMFQz1VmwZp1lWKAzoxdt2kc/ZeCLrjnqNEWOTJl2/Sf
	 sWGzqPS4yqvNQjcH66gJag9dTj4xbKfOBnjtvkhezc1o+0g80tJ1wm8EmSyjqr6AjH
	 pKzc5EAAL0m7Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 66CBA80AA1;
	Wed, 28 Oct 2026 10:14:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id DF8CD235
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 10:14:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D18D340535
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 10:14:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id c-7bi1Jf_Hko for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 10:14:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C99244048A
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::52b"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793182477;
 b=mRgrJJIjWwpT8gUsgc9oT8viGW0pe/R4lUJLAFGQ0Ezdno9I7WMuXWSOP23k6CNC4Zoz
 Sm6+XdYREhwWEDEI8gAkNBz8jfDCwzyyvqzUGZeMOxqZn9iBAY+rt7I0VSfoWZ120e5gK
 y1kESyimaYF45s4mXtE0CxbddUkoPb/9VJuf65lfMrFHzuocza6s69a08l7MrqrvC7ceS
 DIZBhvTeD07AZtrWkGzC0EUP1MGYgudD+/XBhoMgR7bgzTFDYfvEkZqO5exWw7ykiS2Q/
 85YyhTVGN7Cd32DdKJSNSxSwDDlYC23gZLzZAr6jx/xVxVZIOMV7yB25frIk9fgaf6g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793182477;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:from:In-Reply-To:References:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=PUsSNgzrLpgYiXD+thwlTpNq3IatIORYNszTHycqhUs=;
 b=IYuIDsupNQRIuQ0tF8R6wmfurBiF1WzcQ1/sB3u4tpyGawKPZa+AvNrq+1VtTh31Fuu0
 uq3eEl6ii3uvaUMp/XYrzHLGG2dkYPZE3WGt9uqz5gMGV2+LizPmBKi2yV9VFnBohOh4x
 5Naq6ssYOcFDzA6J5rLtgFaEUXQ9pmnHcVeJr9w2dj79qB0BgJyFGUkdT8tTO3BjNrAwX
 FZQ2OCEedBZf/dpIBZWmzcSJNrD8+N0QHbfC8l5PK70xPgNTR61Tsm/4Qhe3mpFndIrCu
 /0gDyUespXSBx+PZePGYAluXTUGdjJqA7PLfAqWoNGvpcAnivsFE+vyKHxsqTW7hXfg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=NcQSnrsc; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::52b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52b; helo=mail-ed1-x52b.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=NcQSnrsc
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C99244048A
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 10:14:36 +0000 (UTC)
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-6b1aa2848d2so1409342a12.3
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 03:14:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793182474; cv=none;
 d=google.com; s=arc-20260327;
 b=EE2bewQQNyC1WbOd1J8WhL3MjVBibjdEuLQ8a6ZyifP2LX4rX+1qDFzkYLoTRVDDtM
 kJZTdmKynMjDF93HcnmTUXh7ucqgjfQ7HscZ3S4wawb/V9XnxNlfA3MRh5E16x9ohWhR
 jCdVBMKX6L/OJkl62uUMpvwfl1kB/FYao55PYrRXF+73kswnMvNGcJDiJ0KuewHIKy4I
 +ZupH9JD4RNrnl4mztaxBEabJ3IL+Q2Qz22fjP1xnkSWch8sX/1fhecgR8TOVxxHRbhH
 HNXKul5hNUAvVYnGsJ8WfbuRfFFcuePtWr8KrCUvPUslLDw6GeKwxeY3DIwoBQGK3znI
 Nj3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:references:in-reply-to:from
 :mime-version:dkim-signature;
 bh=PUsSNgzrLpgYiXD+thwlTpNq3IatIORYNszTHycqhUs=;
 fh=snprARz0S91AdrdX+Q4bMLNsBlRNtrtd0Vl7inAWxLg=;
 b=a+Fu8sJPFi6Gpuu3JkPjPP0oKqQKSi2bo4C8c/ZJ5U0lJduvxSIn+0e7Wc2uqp4MfT
 hBdRgMT03+IbOjmjKHW0j71GKGeqHsf3U5D3EP1pocC7Y5fNSqdg75dQI0lkqsfWkASz
 aStXBw8rl+cVZ0H0jeop/z9PXMep29XW/zRlPLwEuIadLj50UvsWkCi+ww6zuJMSBf/9
 plM5eht/PKQI9bwTuDJXkxtgYBbR8ZO/GkQ2ViPbQkEME28GZk1L9GMsZTAzUv8VhzBd
 lF6KHWElH4ekPVy1ZawrlBeCFHcmVW7CBsNMX64t8+rPkKxlLFR/SQ6fnEwZO7AOI/Ih
 pWzw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793182474; x=1793787274;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:references:in-reply-to
 :from:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=PUsSNgzrLpgYiXD+thwlTpNq3IatIORYNszTHycqhUs=;
 b=NcQSnrscydUZuPek6cnKTx1bDwyx9cbl+fN4BNxHiILL133l6hH0t0NtjNZhwWIYB4
 /gayCaX9eIZ0lm572hPE8aRYNu+8OhgJZE0JMyjvhNb+KVKQYQwUoR3fcJ3NNTuFqrhD
 lt64JRcmsXUTVsJZ8LpvtPz0Ftw/H0fHwLsTA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793182474; x=1793787274;
 h=content-type:cc:to:subject:message-id:date:references:in-reply-to
 :from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=PUsSNgzrLpgYiXD+thwlTpNq3IatIORYNszTHycqhUs=;
 b=LdzRIjclX766jp968OpM6ALLrwehDA8kCJHiy95uZtemQcw7E3F3NuOGtZETCwXGxA
 cdai/z0GglvTzMlFAtFzjsLpBaBaqDG/pEhlS2pAnPsWulZzqueN1ScKV25Q+NqPSYFq
 BDPmu5IhORMvrJ+Z3tmv1kXRZEiiO1bgnRnTXQLwLCE6NS+L8q+n8zusJ5kLfpjEANkv
 P6ZFS/H4zmTFvThBx9AqrVrJhN2sgleR03u4aQq6JjDsWJ3DNiZ4vN1t7KKKco1ah/OP
 fSvVJSqfbDVYUgn83KMh/xVDKkc2GEKWQuFkv/2yp4Tijvjmz2Ed2oaLrk9VOyuAmzfy
 OFIw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxAwg3b3rfoeYpOs/QBqhk8DEviig5dRg5NJEoZTjOch2g1QShPQV5eo812HBl6RApkDZ0n540=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLNy1cdqwre3nVnQkDXH4WUalIE6H7f+n5Jiy42fqXLGqlEuv2l
 eCyv46ovHEY/Nc5pF/gzrwHy5fY7mbj7Csjd16bdNhCJpTLWvvvAB+OFYCx+7BUvAIIW1pbyDCf
 AkaGGLVKG3UYUnmalkpHg4T9Iz3CqIxLeond6RYS3U0mQ8gnEooiFkA==
X-Gm-Gg: AYBFou2PTzpttg+rda0lCe6Gg4WH/xni6oqtzQtEOxVUsCwWTevQY6JOPpy4O9QQ8yK
 nBhRkwep53dqvQPuvTcX3YW2fWKxaDT1beZ45t5BtJxQx0nn9RPLsLJpQVAJutQfcZEol3txkZ8
 Y2bQoyMZ3+tlObQUJI5mrs0cb+JrefhjX8KRFe3KjFXKKc0Vl7tae0XBbrC2DhmkRc21+YJeWvC
 eiXT+nshaRlYWS91/hRBO9HZPqzfyq0X+pLAoONNRkPuYEirFgOZNY0dVn9E76oqyuIgVCgxvm0
 likGpcxaVL2XG5eQfc7VSgDuCGdzBhHXI4or7e8F93bgyS4826/Dsl2SIhzNYFjujLdDjAsAG5D
 XDxxvgXMMy5sQi63VICMXP0hFwJGxAk3TeaE=
X-Received: by 2002:aa7:cd49:0:b0:6b4:203:a183 with SMTP id
 4fb4d7f45d1cf-6b49cc10d44mr836443a12.36.1793182474418; Wed, 28 Oct 2026
 03:14:34 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 28 Oct 2026 03:14:32 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 28 Oct 2026 03:14:31 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
from: Simon Glass <sjg@chromium.org>
In-Reply-To: <20261028090311.2509067-1-juuso.rinta@nokia.com>
References: <CAFLszTgi50TT2pFmGHNUpN7qsBdD2PKWEj=wR_DCFNX4-z7p0g@mail.gmail.com>
 <20261028090311.2509067-1-juuso.rinta@nokia.com>
Date: Wed, 28 Oct 2026 03:14:32 -0700
X-Gm-Features: AclHuK_eRYdAxsxWAF5p3buIcPwNKXcSiIxb9VfU2hlfiMf-RdismJpIa3y1nlw
Message-ID: <CAFLszTi3xg1KuU2yv6Qw82rwMGR+psAL3VwdZx342UBU59bhYA@mail.gmail.com>
Subject: Re: [PATCH 7/7] test: wdt: add tests for wdt_get_timeout(), wdt
 gettimeout and warning print
To: Juuso Rinta <juuso.rinta@nokia.com>
Cc: jonas@kwiboo.se, jonathan@joggee.fr, stefan.roese@mailbox.org, 
 trini@konsulko.com, u-boot@lists.u-boot-project.org, yuriz@vodafonemail.de
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
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Juuso,

Juuso Rinta <juuso.rinta@nokia.com> wrote:

> What do you think would be the way to go here? Since currdev is static in
> cmd/wdt.c, clearing it from the test would need a small helper in cmd/wdt.c.
> Alternatively I could also replace the static pointer with a static char
> currdev_name[64] and resolve the device by name in each subcommand, rejecting
> names that don't fit. That would fix the stale pointer in the command itself.
> It touches more of cmd/wdt.c, but I could add it as a separate patch before the
> tests in v2. What do you think?

Yes, it's better to fix it in the command with a separate patch than
to add a test-only helper.

I suggest storing the sequence number instead of the name. The nvme,
scsi and virtio commands already work this way. Use 'static int
currdev_seq = -1', set it from dev_seq() in 'wdt dev' and have
check_currdev() call uclass_get_device_by_seq() to return the device.
That way there is no fixed-size buffer and no length check. If the
device has gone away, the lookup fails cleanly and you can print the
existing 'use wdt dev first' message.

pmic, regulator, pinmux and tcpm have the same static-pointer pattern.
You don't need to fix them in this series. For now, test/cmd/pmic.c
selects the device at the start of every test, so please do the same
in the new wdt tests rather than relying on state from an earlier one.

Regards,
Simon
