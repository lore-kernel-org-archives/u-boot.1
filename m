Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37DECCA5FC1
	for <u-boot@archiver.kernel.org>; Sat,  3 Oct 2026 04:45:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CAB0240D8F;
	Sat,  3 Oct 2026 04:45:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9id9ftKRiTvY; Sat,  3 Oct 2026 04:45:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org DDE3E40D82
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791002710;
	b=Lk9eaFCmMdKzM2ja7/lZci6bfy6sXTM/2Yrgf7nqw/PAiezx9ER8nN4kp9fmHg5mYb6i
	 r0OrRkUmV7NAux5Mm1B2PCq2u49q+5SZtAtrtBdkeIuvOrgt5PROHley32iai05SWWLg7
	 1J5yC6Jj2eX5Wlm9ijSjoyNaQBOvC9pjPVCxf8Uku4uW6h0+QOK6gQqzPCQslxbbc5SXN
	 u0mQudJjJ0wwbmpw9QBcMSuEsfToi8AlC9OwJAAUwZ95hENyIF39DICOPHwfTzag6i6wV
	 Z/HUach/gELZk1T7dmrmErOf4h+/hrUx+DxDG4UFYVl4FbGkqiBqMKGVFGF0XNxTUQA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791002710;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=nmzQ8OMOH9/te4iqhE+5rsgyl8T8QA8FejJVmS0WnxQ=;
	b=YudBt6HTIhSY4DVScguiqrFXs5xu7ZmIDHgm0pPA1zqqHwYrzxdeWJT0XifX2fIa2XPr
	 ZaahBQ7oCgmf1M3T+y+xBlRdVA5Yn7qf9GoULwHtlBd3I9zZ129dqbO92lMBoPO5jbEKI
	 KrudTRabs8MTiWpwV7sewBTDmRHWd5/OOhqQ28i9ZC1LvWT3yKyvSPUOGZQXfAJSItRsV
	 am8nXHf8I4iwuVGlyWYjQoOOgaOqYXeuCaxCpzTjG6VzSnhTp4gPJ6pVYGxmjnCKHriZo
	 JH5vW+CUd013gCir1acII1r5Sg7WSz54OerLDzmXD5arKYnYFQPkXz1SqwwvuGnAUYA==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791002710;
	bh=nmzQ8OMOH9/te4iqhE+5rsgyl8T8QA8FejJVmS0WnxQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mIJmLZGItd82A4/HbMk/7m/buEngjybL5iTdMGgZuJ9R9dgzsKhTJQ/d2h770D97v
	 4YIyGdxMeBhyqiF48OlFQnsrkFnXk35UBmTSvQxcHl1NFAyy1RsPwOrTWBiEwP2wxZ
	 nn38DXpNKci52aWNfPGhZpVyJYQwa6gb3+b8l7W+HTaGjQgbFTDixnyxKPGaIJCFjX
	 44I9m/JD886lZGYZJ66UMjGyI5cOIr/CNdcFPNNbOig7dLIAr7JcUIMlYYWERYi1v9
	 nlH+hF2IDS7dEc33mk2ORLJoy71Amf882ZnqeuFx8TXYDQHB5RLsx4CwmQ4ZvF0b76
	 yanLf7i2yz6iw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id DDE3E40D82;
	Sat,  3 Oct 2026 04:45:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id BAF4E2E0
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 04:45:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id ACD8D400C7
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 04:45:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id x4T9qRTUOKdS for <u-boot@lists.u-boot-project.org>;
 Sat,  3 Oct 2026 04:45:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 9E2F840059
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::52e"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791002707;
 b=bA2xYD7JNmhXykZedzyl1KheWoOtpqrlsnWE/MplX1jQ930uAyQKLKtU1NFT0eS7YgiG
 cs9PiUlWBEycixE7qs9HqReYaWV4430E25MNJ7RzrOMx0iu07xyUmGc1OPN8MYTzByWV0
 InBVtqnfud25SqrwIDhtr5gdACf/4BtXuwLubGp6y2OzROpBuCa28wxRy1JJHnuEqlSP7
 mx0BFQ+2XeclUg1pK1Xzk3y27FzDFIY55F+HzxxWO9N8RH2o4vTdov1R1tP+3XvqpGFXk
 UN/Ykv9gVVYPngqNO2l9OiAtUmpwrLi+3INFq/TKDyfMKoM34vEQY3rMchCHrOtfZLg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791002707;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=nmzQ8OMOH9/te4iqhE+5rsgyl8T8QA8FejJVmS0WnxQ=;
 b=DKNS8aFJAzssjaxVaPZ8V8Teqade3yvLr6YQjjVnpgsgU3WeeDhYL3Wft/iHAlwG26uh
 PncJtsPYoulge5u0gx6910Zwcu0HmQskYkPG7qPgWOAqKG560E6fe+t+8FWCVECjXSHE8
 XawA0p4EZ4FfApBPbWTHVyB8bGw+ShlCNwzBgehSGTFZvn16N/dZJermby+z1d3iKC5+I
 gNKWFiO9Oi0owpWckCmS/0Avrtcatt5Gc9883ETiyFcfVg0O0V60hTLDOYovzAHPmHCIK
 2GVcMDCbrRdtmDUUcKwyXpuIyfgSLxAW+E0EUElqjBvad21Z/zPM1GqPSmcyyhcj2OQ==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=XqnB86V0; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::52e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52e; helo=mail-ed1-x52e.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=XqnB86V0
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9E2F840059
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 04:45:06 +0000 (UTC)
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-6aa850436d3so168232a12.2
 for <u-boot@lists.u-boot-project.org>; Fri, 02 Oct 2026 21:45:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791002704; cv=none;
 d=google.com; s=arc-20260327;
 b=j1imekMaLq4sJc4Ps+vS78eaoeJQeJAF+Fnv3Fm39qTH1a+MS40YfIvduSdDrOIOJI
 ZiFkQEKxE6dQBkjnyfL0i/wr8sZCj8BrwKjbexL8z18n5tcEbOOuaz2wogucUaiQv7OY
 gvChK6ZKO7FfpbdbFlUDAjYjtMlm4PoVfZaNL8yLFtlBoLA6M2SHXW+fl7DKuhAl7kPv
 TuZeZw+9ok72eEy8KD6jUgElZvCWO9OCH5GbGi1ukXb7eV0eKaQoE7DFVRM+NCRrapQU
 2PvQNYGZpEzoTmULTNqSSIhPTb5qe5ffATzFZd+S+4db2mmWYXy2c+sWsDjI5u94zD4q
 OTrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=nmzQ8OMOH9/te4iqhE+5rsgyl8T8QA8FejJVmS0WnxQ=;
 fh=gfhgsB5kmREgBC8popE1L/sKuos7PQJXqWzBBz+Q3JM=;
 b=hTrclQSzOFElWSC2WzpK6/9jueM7W/tlKexEwpR89OdssLbDKRl9Lb23MEp9pb5V95
 1g9u+E8R3cGGsXvM0TFTccv1EymCzrjlUNiTG/XLu9BFXv6AqHNFiUeEWneZoB6xfZ+P
 QRQw+hhNENqGQiU2QnvSb5rPvu8dlQsLArUdrGASwpFESGr98G9MQKxnOPNtnA+0TVRJ
 BsYp9QHQnm0kVqpVK4Oi4PFvu3dNzsaCZWC+4c4ce0kj5WwtbsklV9h0gyyW7vtj1Rg3
 bpZW+JHrcdcKNIhxXA0NxaKYAryfNFgopDrJ9DJDSn5KG1mOn8FdVP5ES4j43gevBTr5
 4jbA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1791002704; x=1791607504;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nmzQ8OMOH9/te4iqhE+5rsgyl8T8QA8FejJVmS0WnxQ=;
 b=XqnB86V061B4faK0Jjai+W1hXq8Muh95YSxB+kimSzIrFtvv2eImhCAwF+GLGxgIXq
 AItLXGcnsXbxzvWWs5GAK+3V6NpobuulJuSiQnhYurMw6AZWTARgoAmCsRuSF5v2j8ns
 872ZyQXtI7SXa2a9crRI6zF9EN3FMKhzKPjGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791002704; x=1791607504;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=nmzQ8OMOH9/te4iqhE+5rsgyl8T8QA8FejJVmS0WnxQ=;
 b=p+xWdPkTf4BO5n65ABNWC9Wt4XrdVG6BbxgRphniyDlKhn1Lc3r7QHypART/ONlgRH
 0tTN12+HSIFErse4hSxVzfUvV/DSG0aYIITgZfV4E/j2CpsxhXv0ULl/aoKvdObYGG8M
 zGN7YJYnvalIuF6k2+a3N+7ZV4BlioT+iP1bJdlqqQwkeSFc8uTr4Jr4qjjA1LfTTypP
 y305vR5IRVKe0oGr6ft4WzVsm1Ollq+PAzMqlEVsCPaN2XL9WmvH3HtXi2jlGwJhULVl
 O9TObJnIgXcPL2TohHRgPtkmDsQ4PvGKAnkbhagpynxjFZEDG9myZARbYL7z1AlF/gwc
 4zsw==
X-Gm-Message-State: AFq9FYKEbQUOyki+mxZj+Fkxkf2F/cf4LdTq7nAPdDepFTTybDTKAOlX
 N9CE9ZCNQvbYaNwH6KlDYejYe3F/M7DwMaw2qhmKxQgzAVBI0TC5Ol8OIhBNDVqyYVYjuHGpHKP
 BG/O1A1kFD4Lvxi6MGpzV9w3Gj9A98cBFV0/707q2
X-Gm-Gg: AYBFou2rli+fC+UYLTn4E3lTaPo07JLfOY/vJyDwGq53tnrNEwQPQQdQc76d3O0zTQD
 b2JqOoBQ+aU1akx09E8WjI3RWQZ1DO5YRmhNyA1uyLpedqtsslVrhb9seqT3FaZmmSklXtu3KxE
 Dkjc9NC8F35yUE8ZhTB9zhvPhqXVZKMNf+q4vmeXxbrsXjIbAKsBFAV8DzrGVhvjwd5EPHcdz/A
 acdfuf6aZ77KtipQwJ/LMK/DI/BqpxXTI/031NpB+CLn7Th5cgWHETFasCtb+r82ciiBYe+F/rB
 aDRrbEoTjXQNlqVs9sxxJnbvMTNuFgjbbAioPkSZfGN+x/ASjY9lUkqJ
X-Received: by 2002:a05:6402:50c9:b0:6aa:b341:3f9a with SMTP id
 4fb4d7f45d1cf-6afada2a77bmr1260956a12.39.1791002704025; Fri, 02 Oct 2026
 21:45:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260918-gpt-4k-v2-0-daefa4792e9f@flipper.net>
 <20260918-gpt-4k-v2-4-daefa4792e9f@flipper.net>
In-Reply-To: <20260918-gpt-4k-v2-4-daefa4792e9f@flipper.net>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 3 Oct 2026 05:44:51 +0100
X-Gm-Features: AclHuK_MaxdDgQdlTODEfKfTeVRwrc8vuJ9acsroPoCVwONA8AtJYetpiWUi1Bk
Message-ID: <CAFLszThsU0pdgvwGGbyr5YAjV1h6Xn7YnAkw_PJu8XRHCB8d6g@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] test: lib: Check the GPT round trip against a real
 block device
To: alchark@flipper.net
Cc: u-boot@lists.u-boot-project.org, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Denis Mukhin <dmukhin@ford.com>,
 Simon Glass <sjg@chromium.org>, Paul Burton <paulburton@kernel.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
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

Hi Alexey,

On 2026-09-18T12:13:49, Alexey Charkov <alchark@flipper.net> wrote:
> test: lib: Check the GPT round trip against a real block device
>
> lib_test_gpt_blksz() drives gpt_fill_header() and gpt_fill_pte() with a
> synthetic struct blk_desc. That is what lets it sweep block sizes no real
> device here can provide, but it also means it cannot reach anything that
> touches the medium, so the protective MBR, the header CRCs and every
> conversion behind them go unchecked.
>
> Add a companion test that backs a blkmap device with plain memory, writes
> a table with gpt_restore(), reads it back with gpt_verify_partitions()
> and parses it with part_get_info(), then checks that the backup header
> really did land in the last block. That covers set_protective_mbr(),
> is_pmbr_valid(), gpt_verify_headers(), is_gpt_valid() and
> part_get_info_efi().
>
> The two tests are complementary rather than alternatives: gpt_blksz
> covers the block size arithmetic across sizes a device cannot easily
> offer, gpt_blkmap covers the read and write paths a synthetic descriptor
> cannot reach. Neither replaces the sandbox tests in
> test/py/tests/test_gpt.py, which exercise the gpt command against images
> [...]
>
> test/lib/part_efi.c | 144 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 144 insertions(+)

> diff --git a/test/lib/part_efi.c b/test/lib/part_efi.c
> @@ -111,3 +114,144 @@ static int lib_test_gpt_blksz(struct unit_test_state *uts)
> +     ut_assertok(blkmap_create(GPT_TEST_LABEL, &dev));
> +     ut_assertok(blkmap_map_mem(dev, 0, lba, buf));
> +
> +     *bufp = buf;
> +     *devp = dev;

If blkmap_map_mem() fails here, the blkmap is left bound and buf is
leaked, since the caller never sees either of them. The same applies
to every ut_assert in lib_test_gpt_blkmap() after the device is
created.

This matters more than the usual leak-on-failure because this test
does not use UTF_DM, so the device stays under the real dm_root. After
one failure, every later run of 'ut lib' fails in blkmap_create() with
-EBUSY, which hides the original problem.

Please can you move the body of the loop into a helper, so that the
caller can do the blkmap_destroy() and free() regardless of the
result? What do you think?

> diff --git a/test/lib/part_efi.c b/test/lib/part_efi.c
> @@ -111,3 +114,144 @@ static int lib_test_gpt_blksz(struct unit_test_state *uts)
> +             /* two partitions, the second one running to the end */
> +             memset(parts, '\0', sizeof(parts));
> +             strcpy((char *)parts[0].name, "first");
> +             strcpy((char *)parts[1].name, "second");
> +             parts[0].size = 0x100;
> +             parts[1].size = 0x100;

The comment does not match the code. Both partitions are 0x100 blocks,
so on a 0x400-block disk the second one ends at 0x221, well short of
last_usable_lba. Running to the end needs a size of 0, which
gpt_verify_partitions() then skips in its size check.

I suspect the fixed size is what you want, so please can you just fix
the comment?

> diff --git a/test/lib/part_efi.c b/test/lib/part_efi.c
> @@ -111,3 +114,144 @@ static int lib_test_gpt_blksz(struct unit_test_state *uts)
> +             ut_assertok(part_get_info(desc, 1, &info));
> +             ut_asserteq_64(parts[0].size, info.size);
> +             ut_assertok(part_get_info(desc, 2, &info));
> +             ut_asserteq_64(parts[1].size, info.size);

Patch 2 fixes print_efiname(), but nothing here checks it.
gpt_verify_partitions() goes through gpt_convert_efi_name_to_char()
instead, so the name returned by part_get_info() is unchecked on
big-endian.

Please can you add a ut_asserteq_str() on info.name for each
partition? Checking info.start against the expected first_usable_lba
would be worthwhile too, since the start is not passed in and so
gpt_verify_partitions() skips that check.

Regards,
Simon
