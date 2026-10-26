Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8E3606A31A
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 16:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=b6sB5zrZ;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=bSvoRCyD
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C76EC40574;
	Mon, 26 Oct 2026 16:14:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id E5fN1UYVHjSC; Mon, 26 Oct 2026 16:14:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2456240581
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793031264;
	b=JLRU/L7CRRPZzV+55ZpTq6oVW7o+qiNJT0coszUHM4b/v9Wsg1Xs1BMe6Jd/8YOjybO3
	 zn+EW+SPWVuDrrKOhWk+PuXd0iy0/movPw6X710xnGuIbpArqQkNgm04tZQPUpiwiaTdL
	 cNAjZh5nBdaX6qZCL+1XX4/qPxadZEEgwKAF9S8VagkUKXC++owiow6gzpQXqGg4z5jy/
	 StcBLeOkqRISp1wFYszkS25ssxMiOGq8DPmH6TAm8CkAxa5D2XyzoAO9g9Pq/52h0kmgg
	 RquC/tRBuiQGSNSMMZV9V7Ddzj0P5vikpXM/QJ5hMqgk//xzOcf8MkmFNF/pmHIbIVQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793031264;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=OXeWQh3UH/QbpsSK3u/bdVpRIgvJ3tgqNBxrH5FnCPs=;
	b=Bn/4qEy65G9uc7FiQAtFkNJshw9SDearebVI7B7vfkVXxnEEGbid9mXbsJBdc1ePr9+h
	 Ce0q0vPm1nDgH4g5jvrUrhUASJgFIiAZILW2Vqn9TqNe6gSeCF5VZVTlrQRZpBc279vxO
	 FOqRlQK3txuEp4DLVLLK4bt6RLA1U0SZA2X3wxIMpsQpAPG3ruBc6cPIKIsffBvsHc6WB
	 vwcPPndRlt5I8kPvnEP8Egu/C31op39SS9mRhLBVvqZUkBs4LgxiYB6aZVErYxX7cc6/a
	 EwTMVE3ZQaVUtbCSOkcBQrhwapE81YAkwMOXQ3jSp4qBqyFD3N5o/EDvEb/ichKweYg==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793031264;
	bh=OXeWQh3UH/QbpsSK3u/bdVpRIgvJ3tgqNBxrH5FnCPs=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=b6sB5zrZAKC/pxI1loCuBR3mdhhViLRmCjkW+jTkA2qKGAWierq1WG9o6CcKtzCDS
	 d95//4DZgBU3QpVI1VWkDxBffoFheu8ogx2rHKPRklnHCHuJDcsSNK/DN/4fB0qSAl
	 EwHCBOuvOkdtX+VzTT2Wab9h8+O6u1WL82pNxeVhXGOgbfRXRRCOonTn7Z5Zoimmac
	 NP7V9X15OI+FV1QwEdsbwo6SLfeR9oAycpFmMrzt2dvstMj4U8ZbCJDgBRywDq+TzS
	 t4U6QbRcWJjXIttgOOvRgz2Mkyh3jsecN+1D0wP6+v55Z8tiZNLvX6Fcgm15wOGhs3
	 AYIC2wscqqhOA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2456240581;
	Mon, 26 Oct 2026 16:14:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id EC4384BC
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 16:14:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E9CD660612
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 16:14:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JIMdeuIH0Rsm for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 16:14:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6209B605F7
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::529"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793031262;
 b=FIBn47B7unrNek9FSFVjjWNeuKy2a4ZwFhUTJ7VpjHw4+uTzPZjDBpnHMW9zvPFQ5WZq
 zgErrEgaRjrcQA9muLyoiV412GnQkeJK6/Rca5hLa9s2xHk9S9PGvZ2mXdlKe7XwL7DbO
 mO5QdcGTfFQdhajkFZ/QTvODmxy7U0tSwPMTfQALPjQ/ZxGLRZ2Lfoqa7IKt/KzijQMxM
 MB352vWZLGPPANL++7DFnlsB0fy68VFkcw0RtiHWThFMvN3z1d4UmQ+Yz3PPDPZ/ySltm
 uhCjneJqU7rgXtdru4/kmnYxphDlxhO3WMHbhpqqb7KDZcsvHIso0itOeuKJ1/wMf4A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793031262;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=OXeWQh3UH/QbpsSK3u/bdVpRIgvJ3tgqNBxrH5FnCPs=;
 b=abddQa199GDthC6IfBPFexevHaiDVU/yQAXYYo1+5iu2hBs71Mn4LERIfCJa+OqOXKjT
 FlS3pAd+lh6NodP60w4XDtrqlPCILrrHlB+AYLadpmXIr1n6xQl+JecpcupUV1vHWPcSU
 eTvke4NvtAGAEj/fdWzzKbXJYxhekLLR9xgXRL5p7Fi2eZGr6Kp4+4GQKbjp5/inKd9+0
 JYotqmzrKUpLmCKORB51V6T/g5xx55rnPWQeWPU1sdCqAFk9UqrMlZ0frCbQkM3lRIby2
 ou7iU/U+gbPoKUhITHX8tiauV1CnWrEzoHeWOIdjM9N3P6JdUAxI4wpOrSDCAtNY4tw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=bSvoRCyD; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::529"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::529; helo=mail-pg1-x529.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=bSvoRCyD
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com
 [IPv6:2607:f8b0:4864:20::529])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6209B605F7
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 16:14:21 +0000 (UTC)
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-cd61cef87f1so1028576a12.0
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 09:14:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793031261; cv=none;
 d=google.com; s=arc-20260327;
 b=OWwcbUudS5rX/5bY/0KDb7kKPtqc03Q7h1REb3U11kG/jPzZoGfBP+i4ZVJMqCJJgz
 W7bEzFwJ+GTyNMsfm4HgCC7S7j22V9yFlk4rSnmSL096cTDXnIP0mxGkDg12GB+TYxxy
 ZwXa7RS/kE9mDLsgIyA548CJ58kUjsLnajNlhfRFeVicJv19PW8gE9vqQLUa8zbWTZ4q
 zPg36hfxJT6miCxtcVJ78g4z8mWcta0uRfPM5F7waFVn0l8lgw1z3imXsl21hRX8yPAq
 VwQoM67tIgCG4rr8z3RtbNKJb9Y6VloAUqIrus4oHeWsuAs2CpUc+Gm7uNlkbIUAUUE7
 HBfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=OXeWQh3UH/QbpsSK3u/bdVpRIgvJ3tgqNBxrH5FnCPs=;
 fh=w9Ta6e6IxL2RIAn+g0BgirO0Um8SelF/7OsBxsfUm8A=;
 b=S6uQGAN8e9PSKbTI0RHr2vswAD+VSKVy7N2oiyXdjUPKvuqgBjqbVxnRp4uI0W1dpb
 vtLoCjn9d+U5sUgqbQ2tNJoxupyOeMN4OvfoPjfH26ZSev3t/rqqkX9tX+YH/ZuPm1bc
 3J33e/m4f2s0Kupt8CTwQUSgjphuZzgmZHRIKY3aIHL2+umenIKksdbOMlss9yXx8u2Z
 YqxPwjdMlbOvDWPt087PTTpxApGQID4LCbX8NrYco+dicqHjYurkQpJgF17+WqYhHbWP
 4fGi9Zzg4R650TuvmqhQUPrdoRv6wlmprK1TcBcHwB/tKvVIkHS7qq2X68bZ62XN6r6X
 oIQw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793031261; x=1793636061;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=OXeWQh3UH/QbpsSK3u/bdVpRIgvJ3tgqNBxrH5FnCPs=;
 b=bSvoRCyDVV+BAdvPcUc+zX9aeTlWlUsT5VlYs+mJdTJaVeAUC/raKzRRW0zdAQ0UGB
 n4o2CKMt8XQul+kK0fh6kVrdlgYpb2EzliYyMj/CqGiYnaDs6z7ANAhO47qy9foAmdZC
 uRHYz4pqjXWlAdEkMTngB3uLsSd4rQDDnOkJ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793031261; x=1793636061;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=OXeWQh3UH/QbpsSK3u/bdVpRIgvJ3tgqNBxrH5FnCPs=;
 b=NLUgHiF7Rezx3RjBvYNFGzXZatZedWdCR46oDRqmszsZfypFdZ1AqcyrL/gNygJunx
 /mC7HsoEfN+fERI9WMLkHzSMZL6EFFLORIKdm0/sTHVhuk3e8Uvo+xtxdSg1AnBckUS5
 rtNIWCRfODp35qcxLi/5MXrEAQ7g3YLX2g1eYE0v6SXs0xn3APbSduEbkPpeH6oRSC7B
 /vMhHxkrWuT46uahsbHo1+KB4jO8bE2V81LDCS1imDkkZQyGOJGWfCjwvlGdKLwpGqZq
 +dR+Od313ObG0MjfPh2dxENauxJAAqZsvLT7SheNj/fdzhfK61qZfMa681PlxpzPJNsz
 D1cQ==
X-Gm-Message-State: AFq9FYLtjySlmUpJ/2JULow8VyDD+qOrcBBqKKMdUz8v5ZrSQ46w9pSe
 SOilxahMmjNU2KNAps6PpLfm50l25SD7p1y0HdbEl2qpdTM23OX4/dmWli5rk+jeYjeWF1qwRGl
 I8LT7QmyowdfiZpwlq4x3F8WotYIXDKFxnYDW0s0v
X-Gm-Gg: AYBFou3Iu8rDeFr8ABrQjR0Wo3SrXLSj77I1pjAJweey0kY15D3O6zWvOz5uM0f+nKy
 vQ2QVaHGpxuhAm+oZkPAguNya+LDJzeeGtgvyf10fqtr7w/ZXMCWnTWuLwlTtnkgdUY7C/sz5Iu
 jVaYsSgQ1ovIKxt8CTK6LtTSeJfunTvRHiTv3eisD7sjUS6hgVKpF56AGNugsEynpbFSRI3dWjY
 NCjRzBC4/fcXh9Ychpr4UEZBChplIpYThap36Ycb15oVqPp7bjQyvkCKZZkCM4sXG8l4yyoBnhZ
 DsrUKGFgNyUPSD/Bd7myw4UBB0mmG2kA3htZE8gtte/bmiYfSZz2HMyP555YDezIvRlC34mWXn0
 MBpQEOcKvoJsMpHELeZLzdNVAe68758aMWpU=
X-Received: by 2002:a17:90b:1dc6:b0:3ab:be66:ddb6 with SMTP id
 98e67ed59e1d1-3adeae6caffmr5616539a91.20.1793031260754; Mon, 26 Oct 2026
 09:14:20 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 26 Oct 2026 09:14:16 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 26 Oct 2026 09:13:21 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <7292117110e4b5dee555f33c98140e529b865c64.1793020986.git.hyyoxhk@163.com>
References: <cover.1793020986.git.hyyoxhk@163.com>
 <7292117110e4b5dee555f33c98140e529b865c64.1793020986.git.hyyoxhk@163.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 26 Oct 2026 09:14:16 -0700
X-Gm-Features: AclHuK8k5XtbmyaRlWwHXPtRev4oTzYe6RCOxVfFp24I5BaynDloK_tQn7yGSoA
Message-ID: <CAFLszTj6+Dm6Qcz34Cm3vEjVhEAYH2BDZhWcTuSNK1u2TUD3NA@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] bootstd: Add a bootmeth for scripts in raw
 partitions
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
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi He,

On 2026-10-26T14:02:15, He Yong <hyyoxhk@163.com> wrote:
> bootstd: Add a bootmeth for scripts in raw partitions
>
> Some disk layouts store a U-Boot script image directly in a named
> partition, without a filesystem. Add a script_raw bootmeth to find these
> images without a board-specific bootcmd.
>
> Read the image size from the first block and bound it by the partition
> size and configured limit. Support legacy scripts and FIT scripts with
> embedded data, using the shared script parser for validation and the
> shared execution handler for booting.
>
> Keep raw-partition scanning independently selectable from filesystem
> script lookup. Document the configuration and self-contained FIT policy.
>
> Signed-off-by: He Yong <hyyoxhk@163.com>
>
>  MAINTAINERS                           |   1 +
>  boot/Kconfig                          |  26 ++++++
>  boot/Makefile                         |   1 +
>  boot/bootmeth_script_raw.c            | 152 ++++++++++++++++++++++++++++++++++
>  doc/develop/bootstd/index.rst         |   1 +
>  doc/develop/bootstd/script_raw.rst    |  51 ++++++++++++
>  doc/device-tree-bindings/bootmeth.txt |   1 +
>  7 files changed, 233 insertions(+)

> diff --git a/MAINTAINERS b/MAINTAINERS
> @@ -847,6 +847,7 @@ F:	include/bootflow.h
>  F:	include/bootmeth.h
>  F:	include/bootstd.h
>  F:	test/boot/
> +F:	test/py/img/script_raw.py

This file is only added in the next patch, so ideally you could move
the MAINTAINERS change there.

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
