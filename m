Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B20D606A31A
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 16:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=aXFdxJSd;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=MV06fs4V
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D41C140575;
	Mon, 26 Oct 2026 16:14:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ymHNNx84G6zx; Mon, 26 Oct 2026 16:14:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0A38540576
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793031250;
	b=pBQDsOWXRJQB1pdnPBfXxb6zE+Z82pFGwdjcJp58lacrMvNddRkOmOaRX63zzBTQaXyO
	 lE3kUCN58YZjrDTqtrrtCjN6iYT3PEve5k+1PeYjM3EVC81g4gFzsD5oSBOGZ7fvUpdQK
	 /SfZx2S1cg+y5OoQaAxFSn7Qm/46sc0H3iPY3LfyS4SApc/TABfrvV22zV2zUPjkQkjL2
	 HEABNYVEZIdefHize9eeylxbEV8800k2s06+zUzoqv9zfdOgkRMu/rDrF4O035z1PSyvd
	 YuNYk8CA7ngcZxN4d3dfjgkcNN+MwZnstgIGr2/Q0QiKncB1dXnL8iewODC78NYaNwg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793031250;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=FxD55ylom3FnuvebLwmBOQ4n0DO5ufKLPhrifJ2hHmU=;
	b=PJQWzol4DJUQrECSeMozYpkFFxHp0mSc+an/pbIFdaAxKR3DLbaaUUpHC3zocJvtDaS3
	 VBkxYdUA6BJDB7ioIqLH5sJRU3Qz5wG/5qpwl24wvatsv01uFvjDepPB+njf3sU+QwEkT
	 hERuWpwC2BkZEHBd2vCMoSAZ8GDPUAkND3B9R0h0AIiWoLeuXZNvCr0UFs4gYFdul6jDF
	 37zbg6feNuz5m8RbEhokeAX6L1H01kYV2v/hFsW07mBLMZ8FJlqpf+vO8mcjqPSC3gS+E
	 7TKXsRipC9SF97hTW52YeRv/S89+hOaefmbPBXoSPxwMtSP+R5ckueJidBopmQwShjQ==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793031250;
	bh=FxD55ylom3FnuvebLwmBOQ4n0DO5ufKLPhrifJ2hHmU=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aXFdxJSdPfX8nPkuVMplNXqsNkAQSfyqncLeg0hWx8LoX8z2eE+VQNhmaTYW3J0pf
	 imjaXAPGGJ/NF2ZcVpDkLjPaNphqjNgUCGR2woReyB2xUcVUkwHKsh7R8MzYnChAk0
	 ESyKK3n+fBMjwDdDxhhStM5DYTK8G39Q1PRyy7EYQIH42Jx4pLnssfKocRHfl2CxhN
	 4rL9TYP8usuFyPSOAlz1OPRuCrH/NQADNH6+fVpGADHHOudNyDwqQ4QST4vbE/w7RS
	 iop0mkzXHDpydKyUC/2QpJuwlhNogdwewCUgVsuD9ScixIre90Bkbt+r0OLuyrS/3r
	 6GUPWtldWJt+w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0A38540576;
	Mon, 26 Oct 2026 16:14:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id A3B9A356
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 16:14:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 895EC60612
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 16:14:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QNdJdSFdD5DX for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 16:14:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B2628605F7
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::52b"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793031247;
 b=LLNWSWH/XfnQ25D7NK4C5wphf/SFiLp5p0OJ7IzgMM48w3I4i53E4sooD5lPLoG51glF
 omwTdGgdEL6FKQQW1JzRqe34N9KAXUYt5kmc4UE0s4DuamaWSYFqpfNXze8kRfcQHe5tk
 YnTfSX9C/cjWu5n9k01KowG0GGdLmCqZ0rtfeKd4jrSB8wx7OMNVpiII/5GJ5O/PeFtdF
 hLtxAzq0OsxmlxqIOewVJrDSD9xLrBD4whbXd4JQY2YTJeRiHsqBiOhl1f9wxkXxZibr6
 Lu5H/fgyio3FsBtg1w1cBMKJVMeuNBzQ0x8zsuV1fgviAcoErLgBhq30t/qGY0VndHA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793031247;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=FxD55ylom3FnuvebLwmBOQ4n0DO5ufKLPhrifJ2hHmU=;
 b=GsMFnx8RBcHl+WQedOPc9MesN0mBklTj5QSq0IBWczT11gm5ZWDHgsKb/5+tAqU/h8HQ
 SVhqWEhmnLrrAfCx1fZb8rZnIZ9A2uM2s6Pmmr3WmteTePhphbPvjOMAxYf1I3A/iWkCA
 Si1xZEtyQA/t22gwcdV7I1AhZIFgoRejpoi42AmVlQqHQhKCbV7cKhGte3ZQSb03JUIea
 xGSy14x5XQdlX935XA//nTvry5IlBFdbXbkUzm0TBWO3775m05LsqreswBwBBl+Za2eJc
 tNKiOYelhV175NKsaEi/AsEdTmcNYs6XQEIU/Nw6gNaeG7kDfs0kCag+wRc3KfeCCKg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=MV06fs4V; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::52b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::52b; helo=mail-pg1-x52b.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=MV06fs4V
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com
 [IPv6:2607:f8b0:4864:20::52b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B2628605F7
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 16:14:07 +0000 (UTC)
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-cc4aa0246b7so1286225a12.3
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 09:14:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793031246; cv=none;
 d=google.com; s=arc-20260327;
 b=RoYcC4PWC8bI9yRYjJHtpSix+aBolN3rnnl3ey5JYi0Xb+AXUYHWKQas9YVm98w1eo
 1ay1dLUs++u6pkygFHDwrgDdv1sgkLBsAOoG75idj3kjTWqTLHBwRIKF6xZ+6ipehiNH
 DobDgSnVvY2htmWDXJroy3d+lPOhRKj3J1UYfSSDVyF1pMC0u/M5FNYqdJfaubJBsmHk
 6KZ+/ccyDivNiMNiHeAmaun03O869xqtu+/9X2Z1m5GxL3wX51fwS7ZRxkPrrbAaz6Ns
 MAPOJQXrfGttUPWFcHmtniqlufl0/FmnlYrLudcPn2VmE6sUdELokC6YPBrTH2dMD39J
 Ghxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=FxD55ylom3FnuvebLwmBOQ4n0DO5ufKLPhrifJ2hHmU=;
 fh=w9Ta6e6IxL2RIAn+g0BgirO0Um8SelF/7OsBxsfUm8A=;
 b=N+3wNNkWUnqWWGLe3GwmJ3FVvu0CXmChOZT1b71bJLn0a7/RJNsDiqMOl80M57FbI8
 QvyDAJzvg0rBQksN5dFq3wOplCcXWcAiQejiEDGKXdF2GC58fj3MVqUf76A7GT/ODpVf
 8a/NgdQ3JKgxGFpjuXMw2hQqNBJwBoJ6b30D2LPhuEpmCWNSUAONsXV/Xv0kq6pRoBBH
 A/yBeeTooeuYuw2gLFIDFJH7H9xmgGwWSuldZWkj7nEQ/DsG8ZTGA54JofGzSvcVdtuk
 vWdHQhb9ltRMLJOSfiwsD8vem0sHnGgGvFRniz8rLHpVH4SmVlQAvRcVQYLzAmyeEnDo
 YC5A==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793031246; x=1793636046;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=FxD55ylom3FnuvebLwmBOQ4n0DO5ufKLPhrifJ2hHmU=;
 b=MV06fs4V1QCfkhjUJUnO7lNL0jDTEbKHYt5vVje7p5fJu4fl565qnxYl54wLg4Hj3N
 g3rFDKtbQpGs1R9K76AbU3jIAelcPGKSgShcERDPEFL8Jm1B9KCxd0WAFQ0HDDXOG7ix
 ryaQv1FyNxC2SIg+zw2HGgHjJc/vrM4Kod5uc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793031246; x=1793636046;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=FxD55ylom3FnuvebLwmBOQ4n0DO5ufKLPhrifJ2hHmU=;
 b=AqYaZS+Nje6KpOpE1hY5ZFayZW5mAzvC5ZhKuKNrbU2vsGHq3xWm58bMpS1FShJz4g
 fcJWtKWwtD75LQJ/BshIS2vTDi2skxbgiRHc1DG3ABTVj1XjDuV0Xjl7KOJKvGCTLWT+
 EKvYOl4Oa8wJCaFK4Q4Sw+S2fQYb+/ePzxenY5lbOAsaKsElyFcVE7mJAn335RB/Omc2
 QbIPYyMXtIwCoX/iuQCdE7rZBnll5asjEq2ru3HWCJZAmnPBE18QfcICjne9aGsETXqy
 6V2QK9e7FkRi6aYXNoul+JCgLFFB6/zUi/FkuH/1X7EsrYQw1CXUDb9M9971zHer5X40
 aUGg==
X-Gm-Message-State: AFq9FYLaJC2gSV2Sg42UfDVGQ9THZdhP3POxWWlxvoui86FkJvuCMJ/3
 B+XqyQxa/0dfy9GMpGDhN8WzSJLg4QK3oPlfrRwZ5zMJOE8Ue3Qj8SkP5pbXLfuqQkyE7+1bdbg
 uo1BqJ82MJ7ctKLDQzop0Q5Gl9SUo4MS0eU6bBIth
X-Gm-Gg: AYBFou0dW1RY3N1tOQrF58yHLKqFAMCXZqrUDPDAOTGZx/gieXttj10TUxsQk368Qkl
 5O4lpyjRcLSbGCQb3HWZiY2eoXVlGK3CASC7yTtAaRwwJE2T2oCSebaedsvR9DNbyX5Ve+2Str4
 wUWooY+u59aCAsuB35bA7nWjxCy7JGiZi7MKgIubaRt7vETw8gnL+ijsqMMUTUGtmE+dEE8qmlT
 5yyeOdYimfmrG43q/T663mwvkltybOcFHC8woyFMZtZZ/1QXTT+k5EphOUAXCcmM+foN8n8ZtUB
 LlAYwWk63A9a693vwDgIcLqno+BrJRUe88rMZ7obJwi1br+Z542JQ5YZstsnpJTSuuAu9NchHs8
 DSyYm2m9sH6RzXACCLNEH3fPo+LxX91vhhJ8=
X-Received: by 2002:a17:90b:2b4f:b0:3ab:2ad1:f10a with SMTP id
 98e67ed59e1d1-3ade952f931mr5268787a91.0.1793031246348; Mon, 26 Oct 2026
 09:14:06 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 26 Oct 2026 09:14:03 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 26 Oct 2026 09:12:43 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <8226cb148063df42865fb3f0bdc832d747b8beea.1793020986.git.hyyoxhk@163.com>
References: <cover.1793020986.git.hyyoxhk@163.com>
 <8226cb148063df42865fb3f0bdc832d747b8beea.1793020986.git.hyyoxhk@163.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 26 Oct 2026 09:14:03 -0700
X-Gm-Features: AclHuK87Co62U85pFoH85P7FT7w10MW7TGDQQF379m-9Mfgmp7GgXOoVxW4nsB0
Message-ID: <CAFLszTgmZWjhuJ41RuVsGA+74OsdijWAynX07hydHX1=KgRoHA@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] image: Bound FIT script checks by the image size
To: hyyoxhk@163.com
Cc: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi He,

On 2026-10-26T14:02:15, He Yong <hyyoxhk@163.com> wrote:
> image: Bound FIT script checks by the image size
>
> FIT verification can follow malformed metadata or external-data offsets
> beyond a buffer whose size is known to the caller.
>
> Pass the known buffer size to fit_check_format() so FIT_FULL_CHECK
> validates the complete structure against the actual buffer. Reject
> external data in all subimages of known-size FITs before verification,
> even when verify is disabled. Keep these checks in the shared parser so
> filesystem and raw-partition scripts receive the same protection. Leave
> unknown-size FIT handling unchanged.
>
> Add C regression coverage with verification enabled and disabled, plus
> source coverage. Clear verify even when a test helper assertion fails.
>
> Signed-off-by: He Yong <hyyoxhk@163.com>
>
>  boot/image-board.c |  19 ++++++++-
>  test/boot/image.c  | 118 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 136 insertions(+), 1 deletion(-)

> diff --git a/boot/image-board.c b/boot/image-board.c
> @@ -1043,11 +1043,28 @@ int image_locate_script(void *buf, int size, const char *fit_uname,
> +			if (size) {
> +				int images, node;
> +
> +				/* Reject external data before any verification reads. */
> +				images = fdt_path_offset(fit_hdr, FIT_IMAGES_PATH);
> +				fdt_for_each_subnode(node, fit_hdr, images) {
> +					if (fdt_getprop(fit_hdr, node,
> +							FIT_DATA_OFFSET_PROP, NULL) ||
> +					    fdt_getprop(fit_hdr, node,
> +							FIT_DATA_POSITION_PROP, NULL)) {
> +						puts("External FIT script data is not supported\n");
> +						return 1;
> +					}
> +				}
> +			}

One thing I'd like to check before this goes in.. bootmeth_script
already passes bflow->size, which is the size of the whole file it
read. A FIT script built with 'mkimage -E' has its external data
inside that file, so it works today and would be rejected after this
patch. It also rejects the FIT if any other subimage (e.g. a kernel)
uses external data, even if that subimage is never used.

Since 'size' is known, it would be better to check that each image's
data-offset/data-position plus data-size lies within it, rejecting
only images that go past the end. fit_image_get_data() already does
similar range checks, so a size-aware version of that might be the
natural place. The raw bootmeth would still be safe, since anything
past fdt_totalsize() would fail the check. What do you think?

If you prefer to keep the blanket rejection, you should describe it in
the commit message and doc as a behaviour change for filesystem
scripts too, not just raw partitions. I'm not sure if it would affect
anyone, but I'm a bit nervous about it.

> diff --git a/boot/image-board.c b/boot/image-board.c
> @@ -1043,11 +1043,28 @@ int image_locate_script(void *buf, int size, const char *fit_uname,
> -			if (fit_check_format(fit_hdr, IMAGE_SIZE_INVAL)) {
> +			if (fit_check_format(fit_hdr,
> +					     size ? size : IMAGE_SIZE_INVAL)) {

With FIT_FULL_CHECK disabled, 'size' is ignored, so nothing stops
fdt_totalsize() from exceeding the buffer. It would be worth adding a
plain 'fdt_totalsize(fit_hdr) > size' check when size is non-zero. It
costs nothing and makes the subject line true in all configurations.

Regards,
Simon
