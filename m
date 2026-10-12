Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C871BCA9ED1
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 14:11:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6D5BA6067D;
	Mon, 12 Oct 2026 14:11:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kZCbcFafedtJ; Mon, 12 Oct 2026 14:11:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 81FEC60643
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791814295;
	b=oaA5CSyiEuVIVaBYDpGf8wJNOZ6x59gpAxviEMW7NCi2a0P6SqQMSERtzDrVf7CPlDST
	 jof03pNB+UzymEyXT/NIpxu21hZSP1+KDAr8LgOyVuhVNdM4Wq63rdyq4GGRo0aRXbAqg
	 Y5CJhLpKyp89nQEUrS7h2bKMgFzsuOGwIsGcAiIj+PRXwHRNFq3fk/R+kQDqetvclYYjP
	 fFzP9R27Bh8DfZGMlYO7o6+xEyb3k9ulgmdkgndqeut/Bpsqe1vclyrcaBLHM+EzWHTLx
	 mM0cE6U6DuhJId30wHRG1hATQvHXqqbBYr5YEbinSKVGlIUz3u2wX8uim/OQzI9JcRA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791814295;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=bR3bqs7qBF/tz4OgMOK6u+1G5qjZBdIzLN9gZYxb/ho=;
	b=KisTHVdkbgPcyynVRODc+4VsWOgSHlVUssiTlc2oULHQZ9MPkNaE0bPh0/2ew9kuSSjJ
	 7RQ7XZiTnS4eyZGi39s5oiE5WBgDvf+Dzd2S+eSuhzg24XKQzN9VUiJwXCugVZEBVYQvw
	 VL5bV6porQfzTvHpU4NSKLvQIsYI1gnZqEMLnWSGm9hy4o4jfRWCqe4HdeqMb50dxZVXn
	 i/Yqix/lIi95TUc39gD93f0PBBIthWvMTgTff78bvfbhDhNHlfgyrHsNbmxIB7QkD65Wm
	 QAYPw9ooY6VUIHEyu3RlVQpBIzX+ajhcrSQmzDG8tuWd113kDZSl2aeeZ+b1Vd6qM0g==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791814295;
	bh=bR3bqs7qBF/tz4OgMOK6u+1G5qjZBdIzLN9gZYxb/ho=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gplAos+zC91JjTeK/hMxIdAvB+RxR06LhjjppRaNt6FGQyDtXBqzd1ULyphVmakX4
	 yDnXiTNGaNqSwo7Sfl/F/S2qMZKIbloOh1pKyWlgCmgp+b6vR3kj/BOPmhoIj1dhPU
	 4ETjV6tQmxmTwOYacb9x4a8hlbIs+H9ZBdmRtTqFJ93TpeRbpbvTpDFcb7f4QgI/JG
	 YTjDawPVDD2yz3wPdRnvGJ6wl3zJnIYfBdaOf/xV5zGG6Z7F0vrlp6VYAUd4sg+42h
	 GMQwVq0JUKH3gGwH3dDaSJEozWbF6e34LQ/qUnLGNUJwz7JU60fXl3kmIefZsr56dW
	 AVh/uexNvnWfg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 81FEC60643;
	Mon, 12 Oct 2026 14:11:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 56E04179
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 14:11:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4873480D6E
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 14:11:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id F6pMUebnYKwS for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 14:11:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 91AFF80CDC
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::52c"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791814290;
 b=oiuIp+7p9gdPsImhYQWUhmVF3FYOryPidUxQv5R4rhd+KksuMKvhFhRAuSM353Dy18WC
 0owM1xM3+WVcuFlPRFyBbFsnR3E9UTv1vzb4kkhD3bwWm4AKhYHnklstlGVdY8+6b9klT
 bXNA2tulLrXxVH62oUmZeTc5EZ7qpvfa06qvgOshxRisCfq6QrxOWvH0c7sT/4MQB/ZSf
 /nllW0H1IssskPWd6bS86FJFqDU440Eco/U5D5XtrzAfnI+Je2bHTD0EqlCcqzU7qzsOG
 js7l6zXAH6EQNZUULu/sM6UEi7o7dWk12JstgVr0IRNkfT0Ucu7sI4qFw5RFIE9MkBQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791814290;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=bR3bqs7qBF/tz4OgMOK6u+1G5qjZBdIzLN9gZYxb/ho=;
 b=Ka01csfic5CpHmswVC9lt8Ewap0wlSsVJSGZVZKADU66GL0iRuym5JSiu8t4Xx2+GDxq
 an04YETYcvlBL6zxi1OLGOIHQpjnXm3GKRsmx5DNxxs7YJnStMZhSBpTPuUyePtPxyEEv
 /1CESp/vHn+v7jea4QOe8gJ8mOzpY3ptJmWY7xKPudeaI/ZhGMgPL1Rqd9jEZTleRBTfh
 UBHocJN8XYPETR39tjjDCUjKHTEfPfqxqKI0zMsrBGbShx0p7F1paWFggF9vhB0vd5CTc
 2LpIMOmzc7IwnVzPQEBMnzEh8vMbGyChHLhYISZglCrmx3FURg7ryFuXcC/NMJYdMFQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=Nhoqdz+F; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::52c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::52c; helo=mail-pg1-x52c.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=Nhoqdz+F
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com
 [IPv6:2607:f8b0:4864:20::52c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 91AFF80CDC
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 14:11:30 +0000 (UTC)
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-cd3310348d2so1728591a12.1
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 07:11:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791814289; cv=none;
 d=google.com; s=arc-20260327;
 b=eWMG+9fK2QVALTu3U00vjM9CKP0waEiCLoGcl7WnKyM0172EZ5t6PFPr19PKwt8wXI
 sFAWz6GZFIoQPMIPmLx1m3sGEV0kmUZA/FdQDHRy9d44iIgHM5t9b8isBYlT/fyuAewT
 NjbblqS53WHAV6bkgkE4Wu9853gIeTNgG14LrdhRhF8vJlgGsHkJ0QtwxS1Nmn9LxMab
 FqJ8l5DJ/xxQZ+H0Gh7KiTM/lVnOQ2tmGADiRyyBIWG4C6fuJfXy/3epONypIpoKTqbR
 o5pzdWcSryGuEbFhuDaHMKtH4uGrnyOdnloKdRdwdohTzCaiABy6ayxIOjZnO49K+VBh
 ZWfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=bR3bqs7qBF/tz4OgMOK6u+1G5qjZBdIzLN9gZYxb/ho=;
 fh=O6yyDpq51zTRjYTvyWS96c+vjtmCfJXCgqOToRtEnC0=;
 b=ofbk6MdYx+voeTxtJzjH/LAsFy8Ejw87cWYpjc5Ck4uduOl4C9+Ygc1iP+zQ89+3cG
 4dDg9JIyMNnNbWeHz02KvMrYj1U8MDb8LIcVY+KWQK/EQQn92x/jl3OL1vRjMGG3HAl8
 0afRJJzVP9fuMMsT12oblQYzYGKPOQWMxt2QBSZF30oHKIDVtYRelNiycDBQdaD3LXGp
 ypksdJLOXCG8yj7+CMPC+p5pxM/6TTHFUwo7FujP2ANZqjf+QEyBtNeufnUBjTBNilgy
 02PH9tOnLlX6P4nL/Ik0vtmpjfnR7MtNXI6tP1vzrIB2ouMsZdJTsL97kexy4mMHdLvG
 aDNg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1791814289; x=1792419089;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=bR3bqs7qBF/tz4OgMOK6u+1G5qjZBdIzLN9gZYxb/ho=;
 b=Nhoqdz+FeBM26Bh6TEWuKwJloVGJDfK37zLsrYM+DB6HKFwguD4bkkmCozduIRLeU1
 czjz7WMQW1QwwKOGbDqiMFsb3QmTc7LQC76uDIV1bHe9b9mA50fExKg8k/SkLhFDI+3r
 kO9bXJypH4RR//kXOVu6Smcqk/HFYvk1ciMqU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791814289; x=1792419089;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=bR3bqs7qBF/tz4OgMOK6u+1G5qjZBdIzLN9gZYxb/ho=;
 b=zGZdKD8s3AaDsHgMz57MK9e+HtpJZ/VL7KOOGlJEDEUu069YkRhkUcYNSv+3KLM+vM
 9N+qWgg4+wDfH+q6Tbn56GCZOZVJ/1QpmPAY5P07RJH80kO89pXDdsLUABmFYJeUpLFa
 rONgrWUnWPTNCh/syf6hr12RE7PiHNrOOdhv0MGdQUBBlSgc5wn/NmB7HSueX6elYsqs
 lbOnJdMhq/z3FPK9k7oSP5tvvGxqz4c1rSO7XrM978oZMMziYjQVfy58fOcN/0U46e/P
 kJVij9K7EG4JbxwnkwFtBQrnTCCn4zDDRHXMX21GmDpFq33GIhlxWWZX0qj0oeg7eUGg
 Qxqg==
X-Gm-Message-State: AFq9FYJqlouwwEQeHB9S4z16TWPrQDHEoOyrLtnVzaVW/gvD9oA2KWAX
 OJsBIb767TOoGt2MDMIUt0b5XO5TzBlZsPLGuc/do8UEKTovAfgsPJ+DmOaC10Ncg+PS2kxumn1
 eOuCTIxueQac4rec5g7NdkR+FUj/aQ4SOhbc+triH
X-Gm-Gg: AYBFou2+6caFDKIygjKT5n6snZ1CGOuHmJn5eLNZP/sIWfo9P7McmOl2uN44Oras6kt
 SdDDCAnRGYR6kPupRXTgWf/uJyNAEf5J8zgDmyx67VqFvJf7mXfcF+zRIDfMWQAePD5xxt8iwQB
 DnGxQfBeubCbqcH+HV4yIgBuHVESa+k7tWMV1P1meLatKGDqmjgGT6PR7HkztnsKafy+FA0IH8y
 We+tmuFKWHwxGAQpQf3fWDVUy23pgXtEvFUQmrJlbSgyLE/QNEWMi33JjJp/23A6V4dYaq6aRQa
 /yto11aP39cMGAEphnEGLbUB2UsQJHVZ0MxQ5NfRRWfufWrz6mZUEmc67si7Za2fhxg=
X-Received: by 2002:a17:90a:d44d:b0:3a2:bb9f:f87d with SMTP id
 98e67ed59e1d1-3ab3a9f2d87mr5544136a91.21.1791814289515; Mon, 12 Oct 2026
 07:11:29 -0700 (PDT)
MIME-Version: 1.0
References: <20261011152235.8842-1-aristo.chen@canonical.com>
 <20261011152235.8842-6-aristo.chen@canonical.com>
In-Reply-To: <20261011152235.8842-6-aristo.chen@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 12 Oct 2026 15:10:43 +0100
X-Gm-Features: AclHuK8KhrzcuQ1diZ04g1DrQLLvK17eKy78EgdAKhYVCpX0fraRYaAkpN0GyGg
Message-ID: <CAFLszTgpXzY20gjzHpAU1eNH-+w4QVaA-t5Ee7-0Wz0MVJhArg@mail.gmail.com>
Subject: Re: [PATCH v1 5/5] test: py: cover invalid external data properties
 in fit_import_data()
To: aristo.chen@canonical.com
Cc: u-boot@lists.u-boot-project.org, trini@konsulko.com, sjg@chromium.org, 
 anton@binarly.io, pranavkasthuri@gmail.com
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

Hi Aristo,

On 2026-10-11T15:21:13, Aristo Chen <aristo.chen@canonical.com> wrote:
> test: py: cover invalid external data properties in fit_import_data()
>
> Build an external-data FIT, then point one image's data-offset far past
> the end of the file and, separately, make its data-size run a few bytes
> past the end, re-processing the result with mkimage -F each time. Both
> must be rejected with a diagnostic naming that image. Previously the
> first crashed mkimage and the second silently imported the bytes beyond
> the end of the file as image data.
>
> Also check that a FIT whose images are all empty, which mkimage -E -p
> writes with data-position past the end of the file, still re-processes,
> since an empty region has nothing to read.
>
> Finally, now that the import reads the properties through the FIT
> accessors, check that an empty data-offset or data-size is skipped like
> a missing property, so that the hashing stage reports the image instead
> of the import reading it from the bytes that follow it.

I don't think this is quite right. Before patch 4 the import used
fdtdec_get_int(), which already returns the default for a property
shorter than an int (see the 'len >= sizeof(int)' check in
lib/fdtdec_common.c). So the import never read an empty property, and
patch 4's commit message says as much ('as it already did for a
shorter one'). What this test actually guards is patch 2. Once the
import skips the image, the hashing stage in tools/image-host.c calls
fit_image_get_data(), which without patch 2 would read the following
FDT tag as the offset or size and carry on. Please can you reword this
paragraph to say so?

>
> Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
>
> test/py/tests/test_fit_import_data.py | 91 ++++++++++++++++++++++++++++++++++-
>  1 file changed, 90 insertions(+), 1 deletion(-)

> diff --git a/test/py/tests/test_fit_import_data.py b/test/py/tests/test_fit_import_data.py
> @@ -113,3 +118,87 @@ def test_fit_import_data_missing_offset(ubman):
> +    # An empty property must be skipped like a missing one, so that the
> +    # hashing stage reports the image, rather than read from the bytes
> +    # that follow it, which would import a few bytes or the wrong data
> +    for prop in ('data-offset', 'data-size'):

Same here: 'import a few bytes' was never possible for an empty property.

The case that patch 4 does change in fit_import_data() is a property
longer than one cell. fdtdec_get_int() accepts it and uses the first
cell, but the accessors now reject it. Please can you add a two-cell
data-offset and data-size (e.g. fdtput -t i ... 0 0) so that the
import change itself is covered? The test name and docstring could
then be widened from 'shorter than one cell' to 'not exactly one
cell'.

Regards,
Simon
