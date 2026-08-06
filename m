Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45DB5C56208
	for <u-boot@archiver.kernel.org>; Thu,  6 Aug 2026 13:20:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EEF9840657;
	Thu,  6 Aug 2026 13:20:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Gs2luJDBVXTZ; Thu,  6 Aug 2026 13:20:16 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8BA32405BD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786022416;
	bh=tWvL8usIUJwS0Iz/3n/dkdgNRsoCZ98QKsZufa54dR4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UoiAcwPvMf9ONpbQ6pNF/Huy2Nvuif5MpICq+7mnh5JST7q7PZ/QkVx6B0EfAdst5
	 kd7wfZNB7wmQHHa8COh206EKW8zihb5CAdyedAKaFQzftbUD5EXMt71ZDp6BSngxQl
	 eUkFg9m0b9Ty+HQpeR5gDHUYKQr3EcTjLFP8b+uAtVwgJg5X3QocozmQ5zvlAr8yZH
	 iDSpajZ/Lx71xUU4YBfUWx3zeF+k/JI5Qm4tlqs3brmovGjmykc7kW5oMg8/0rEmMn
	 SYVHv+lpQTpzaEYjhjvjX35PqfyA9Gfl4iLuyLSx01nEn8WoKpQeG2vF2JQ+X8Ak4Z
	 nPjgiJtlYpjNg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8BA32405BD;
	Thu,  6 Aug 2026 13:20:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1C6CB218
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 13:20:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 01BC54027C
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 13:20:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LQsF3E-NuKBC for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 13:20:14 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::530; helo=mail-ed1-x530.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 136AE40112
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 136AE40112
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 136AE40112
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 13:20:13 +0000 (UTC)
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-6a18e24ad25so1377733a12.1
 for <u-boot@lists.u-boot-project.org>; Thu, 06 Aug 2026 06:20:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786022412; cv=none;
 d=google.com; s=arc-20260327;
 b=sZvk84wlY00x/v+DcbuW/jKoeB4kosXy0SzwWvUY3BkbA+W5fmPF9oKFcKxTJU4q81
 n2q8fmXRkYQWZhAOUAP5UUkxelhNPUcEMyjy3bjuIPhxGl1tiYG4OuzePZNYILzZwDQ+
 94QdyTwyCcYoqPDTLa0aFxyAd+of2bxFiY1ggUcMAhlAsMnxQ3u0MW+WH+QCCfDBRKcR
 +cHHY2pKBdWWxSwk1rT/m483AcFStEevEAVN7qR/MjCsCpIwVgngg/xEE6ei77ZXSZny
 /9c1WP960JrHmjCa7hhLf0+51s4Yn2BdRmUqLj3FkBL8JumU8Fh0DZgyCJr6ld/2n8bE
 03gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=tWvL8usIUJwS0Iz/3n/dkdgNRsoCZ98QKsZufa54dR4=;
 fh=glD4piGlNxos0EA+GWLb7GfG3JXAKCSur0VU4kkUAHk=;
 b=bFbYd6/4nYp+zulmtnS/k3t7l8Zw7G8NdzPoJELXLDejmMofmWt/vsG9uD5p3Hoo4B
 Ygu3OI+nN4YFvjjb2HrNd8UJ8DwVgf6GS7SU1ZyT4bo4mGhIJNwC5K/tSkzybmu1UdBJ
 wDYYGPW7ijt6NbCD90bXFFvNCRKWxJXhttn9M7X3+6zJZW/lpnMFT57q8+ms5kifUDg4
 eyXDSBSbX4J3vg8akItlxXGiVry1Hayl4xdBAJNcVMg8Xg/URGqUhfehv1bwliQZNKcJ
 1ZJcj26feN0P6tMSMphrSSN7drUStMCvGb8UdyaAELHLxQCwoAdPvQlCNsCEttcet066
 yreA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786022412; x=1786627212;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=tWvL8usIUJwS0Iz/3n/dkdgNRsoCZ98QKsZufa54dR4=;
 b=qq3U7LKQ/jOPJq42EwHa7R7iz3COD2gu3ehh5Z/TIPgb4auOs8CfO8Ed6t1fwqlXCD
 1ZD76/PwH2VAv3YnC5F2TlUMd9mW4sUBnvPZJlYL+pOPLlFw5b2G1uiAIQfQbl9NwWcR
 /hTwArYq/bTzNTUoAJ/UsBsSfIgKeH105JBQ+eqIkrNk3kO1zdYK9AVpkFIyIlt9ntte
 pw3mspUb8pR3betnSdTi26bOuiLO+o8fSPt4Tbz4/JPEp2vc/FzkfItGhBqa76QVMa3I
 TVMwJq6kl/vu87q3Zv7IrUaK60BmMV43JeW8CKgkkonKT2Atqtstw3F6vWQ7V99ptzN5
 hGqQ==
X-Gm-Message-State: AOJu0YwF6k8lX4CnIjys4cFmfhGadoh7ypo0GVu/LoZr7/QTf9V8pqwk
 RxWDzU+mOqEzTvyMsAvv8kD1xfeDGkj3LqWrIzQKA6AIXsAYZ9DjdmGabUG5u4XWr4+gUSuPL2k
 ILsLwbzW6TPhFPzv0DOGjrm5Y/VJNc/9oEssP5xWf
X-Gm-Gg: AR+sD10afqOJ4sL04Jo+mBUcslYWvrGANoRaCDVIACPk9RO7WoLeEd5H1silgMbfNog
 G5sTsrtkwtoHpsRsEjtnbTudJsHT1YFF1nhnLe+pSPzrcaTNwG1/O+xSXDO1mieIVMAZe4RFypU
 dNRnJ97hx/pXR17qI2De8uIEwWqhjIE2a1oqo3Zr7VRkEc50eFYSBaMe3jN4mvOy3A6QGjIe/F4
 WsiKmFF8GXso9Vn+zo1r4MKKDpaf6wAFNo0E9+qs875duQ537bEc0M93ijbaWOzGJL9iASN4+ib
 HzOQdo0Z5sxLH31Wg9UswfsYP+LDrXwjZE1vmcCKkvg=
X-Received: by 2002:a05:6402:3222:b0:69c:72e2:a3d9 with SMTP id
 4fb4d7f45d1cf-6a14f26c0f4mr8278415a12.21.1786022411879; Thu, 06 Aug 2026
 06:20:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260806103720.1026454-1-aristo.chen@canonical.com>
 <20260806103720.1026454-3-aristo.chen@canonical.com>
In-Reply-To: <20260806103720.1026454-3-aristo.chen@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 6 Aug 2026 07:20:00 -0600
X-Gm-Features: AUfX_mybzeUL89rPGPgz3oCMM1dr32dniRMI6_BQGufcfN8b2eQQfTLP7_UcDGc
Message-ID: <CAFLszTgKTk2m0wMnWO4zKg2BdH+QkS8ZvtzA76BbNioPTMjfUQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] test: cmd: Add gzwrite chunk boundary regression test
To: Aristo Chen <aristo.chen@canonical.com>
Cc: u-boot@lists.u-boot-project.org, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1786022412; x=1786627212;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tWvL8usIUJwS0Iz/3n/dkdgNRsoCZ98QKsZufa54dR4=;
 b=PUbMIZvOlVQ3JpR2gr51v7NvfGzUA3ELF7YHmiE1m7oFmYd53mgqJT69B/wW1A6lAK
 cnSOvZ0sCKWDci8xYo3/mZI4qwpXbJu3m4zAVs+9W01m40kxUmHKam0DooG1QclbRUUt
 vLPG8Zboqxl+pAI02/nP0kUbl46nwphsoJ1lw=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=PUbMIZvO
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

Hi Aristo,

On 2026-08-06T10:36:59, Aristo Chen <aristo.chen@canonical.com> wrote:
> test: cmd: Add gzwrite chunk boundary regression test
>
> Add a deterministic regression test for the gzwrite() case where a
> decompression input chunk is exhausted at exactly the same time as
> the write buffer fills up. Build a gzip file by hand from two 1 KiB
> stored deflate blocks and pick a chunk size that covers exactly the
> first block header plus its payload, so that with a 1 KiB write
> buffer the first input chunk runs out precisely when the write buffer
> is full.
>
> Unlike the existing random data test, which only hits this corner
> case for rare byte patterns (about 1 percent of runs on sandbox64),
> this test fails 20 out of 20 runs without the preceding gunzip fix:
>
>   Error: inflate() returned -5
>
> and passed 100 out of 100 runs with it.
>
> Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
>
> test/cmd/unzip.c | 103 +++++++++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 101 insertions(+), 2 deletions(-)

> diff --git a/test/cmd/unzip.c b/test/cmd/unzip.c
> @@ -132,3 +140,94 @@ static int dm_test_cmd_zip_gzwrite(struct unit_test_state *uts)
> +     /* Input chunk: exactly one stored block header plus its payload */
> +     env_set_ulong("gzwrite_chunk", 5 + blk);
> +     ut_assertok(run_commandf("gzwrite mmc 9 %lx %zx %zx", loadaddr,
> +                              gzlen, blk));
> +     ut_assert_skip_to_line("\t%zu bytes, crc 0x%08x", rawsize, crc);
> +     env_set("gzwrite_chunk", NULL);

We should have assrrts on the env_set...() functions too.

If any earlier ut_assert*() fires between the env_set_ulong() and the
env_set(..., NULL), gzwrite_chunk leaks into subsequent tests. Ideally
we would put this code into its own function which does the core part,
then call ut_assertok() on a function with the test code. I'm not sure
how much this matters, though.

> diff --git a/test/cmd/unzip.c b/test/cmd/unzip.c
> @@ -132,3 +140,94 @@ static int dm_test_cmd_zip_gzwrite(struct unit_test_state *uts)
> +     const size_t blk = SZ_1K;
> +     const size_t rawsize = 2 * blk;
> ...
> +     u8 raw[2 * SZ_1K];

Please use rawsize (or sizeof(raw)) here rather than repeating 2 *
SZ_1K. Same for the 5 + blk chunk size - a named constant for the
stored-block header would make the intent clearer than the bare 5.

> diff --git a/test/cmd/unzip.c b/test/cmd/unzip.c
> @@ -132,3 +140,94 @@ static int dm_test_cmd_zip_gzwrite(struct unit_test_state *uts)
> +     ut_assertok(run_commandf("mmc read %lx 0 %zx", decaddr,
> +                              rawsize / 512));
> +     ut_assert_nextline("MMC read: dev # 9, block # 0, count %zu ... %zu blocks read: OK",
> +                        rawsize / 512, rawsize / 512);

Since you already have mmc_dev_desc, using mmc_dev_desc->blksz would
be more robust than the literal 512.

Regards,
Simon
