Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D10BECA9ED1
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 13:57:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2C85060665;
	Mon, 12 Oct 2026 13:57:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2lci2fzfxHse; Mon, 12 Oct 2026 13:57:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 67066605ED
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791813450;
	b=gymuDpE9Hvz5der5xRqsU1f1tseOIPLJHfDRoxX/Jr3KCgSP+Ndqx9+tLzllRwXGNfW/
	 CtxRg8lQkLV+urYmJHpJgQKiz0XZJPhHZGikEAk3zfCRf8ZeJFcHYlTseA/n/cZpsyJWg
	 1fh3DajqjYIlvOsdKkpCy0Ku1xieLzG9NkMYJnbgu/fSpaWLZbMEo2ELvaueEwamkUJoM
	 a1nClBehLd8lydDM1N8khnKH6zmbHu1gk60lnckqhwO78TgR/2cqkND+2s+G+HAZ1pRO7
	 wpoSxsKvkPSUPTin5x7X0zQVBK0qIu6+ghc2DLamu3ByxNKl9AFh8MXDuA1r7VPKLqQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791813450;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=2rqsDgrx9PpxqMYOTIOydtnaWg5zC/o2E+q3xCZ9M7U=;
	b=GSGGXOqxP/1cnAkgM562t9XrAoZ+heeN/psDp737YlgBmsFaV0GnCvWvmTQbyVi9errt
	 gYpJevDec0V8jxtcI09xpK4F9me0zkRNMB+qjSIHKMHBmGdYZvWgflZBfjPzVKogpnbbj
	 6HdzNefStUaVPwaFvLCUTBzPDKiNb4yyfzYGerYcIusA3RZ3+Bc1AI7Bxuwg9+IMKBm2K
	 /8IkscnlxlB8R31bZ3GuXnjbiTn/YnZZyA/HgvicBzjadaftc//0oqB2mMrGp5/vgua12
	 BtyG7t3blCyK8uDzq6o9x5xnl+vd4qYjRDPC7L8to4ScooOlxjEPcSBvX+/azn+OwHQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791813450;
	bh=2rqsDgrx9PpxqMYOTIOydtnaWg5zC/o2E+q3xCZ9M7U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AOlm745TFlHeS9nr5yu+GSvDck1cptKjqZqoNLfHbjMFTBElQCo4rWO2PQVEgINPT
	 3Q64NKCkrKNLVKwKaItIlmq+ap+1SQk99mdH2iX6QlCzjugEwfsbWfA81SOMo/18WE
	 +U+sGBZYNNZzXqcW/Wm0lkgdk0ZwQ9pr03uAUYf92htKVkem/gCbIS4VaNmD67ksq3
	 TznKJMBSO/2+YS0wERy+DLNIUqRv7P1aKGOc02qNAyemti9Aoo9ta/rIdz9hn8lWEl
	 A6oLO3OD/4NJgxSrnGXxWUXfSmEJLqqZUSQsx20SAy6JGqEuM14oq/y9cwkZrwIosF
	 WC34lcWPr1YFA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 67066605ED;
	Mon, 12 Oct 2026 13:57:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 7ABA0156
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 13:57:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 475E84010F
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 13:57:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id t6yPE-sCQSl6 for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 13:57:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org E782A4004D
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::631"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791813447;
 b=mZSVXlPUnlvC7RVytqrwRHNl0IiwMxm7fjO6JwkN3eVQXGjlznVNHFwA2k9Z0nDuei+V
 XC0rcCtJuxO3EZENi73sN37UeZBzm8KpEqx+Ay4IkBpcWRWB7pMeia9pj6l0mnO0Mzqab
 r881TGMqWqkyDjDElULlI/Z+e/5wE1RpMP6vk5I22+qXT0NnHbGeaIL8gdh+8I8nxKfwS
 JqQ8GuqdZHjn6DwJvhrpExHYQxAP50WmKVWbAmP/E6PUDOF9ve+U+N5kOVTue7YDDYrC4
 GSfKWrDLGuSHQ4tqgofFjn9WfsFHByFVvTxD7Mx+566nokA74LfkUenh8gx0YHtQCfQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791813447;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=2rqsDgrx9PpxqMYOTIOydtnaWg5zC/o2E+q3xCZ9M7U=;
 b=UyZX16pIWuFb1zC5M41nR6ovxUZCZgn4OYdcpQ7YZIYJHahKuDFst2tXvNXDuBnZdPhl
 +W5qCvUFHHYq2dqBm0qu+sSrE4Ht1w07BoK9pBMKTUpQVLcC3tOXJ1CN3f+xWxWJ0ldgd
 xXATWiF0JN5HYZcNIZMcFdomjMep+N78ieOfazb2mmqGfmSEGlB+odS5RI4oFafq+J9Ge
 hyfhAPCPPTAQDyfJefkksZK1wyxO3aQNtrWOVCYFIKQ4vPLvXtvczaLtSyXvmTN8/wQPB
 1q9HNNReScUKHROnVYaPB2AFttFRFHNKq6GL1wJzUZCXXQdSZYz58kixKW2XJpWwQwg==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=O9auoOh+; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::631"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::631; helo=mail-ej1-x631.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=O9auoOh+
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E782A4004D
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 13:57:26 +0000 (UTC)
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-c247f6687dcso296053366b.2
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 06:57:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791813444; cv=none;
 d=google.com; s=arc-20260327;
 b=SUd8q3R6IfjTNtoMu2xsL+FoLO2XQdoB3uFHtLP74R5zhbEizTbeWMaAiecUjNSLLX
 rDrnAAK77Ro4QZdBtfB3YOoluc6kDgb8Yiek8WxrvH9epygMhYzdJ3u69IIVCmaW8yLs
 uhIH2UtcoZF3ojaBMqYyo4465uTW+Z89MGZYuIrFkYFkLnw+nBBDojrmxZbAaTRyNvqV
 80XaXZW39Q1zhnUA81D7yNB0tgjdS2i13IloJMIMbZ1/qoE29Rn3PBviBv9w/pWRrYhM
 1dU3OuGNTjW0aO8fFbSJTU2NjMfzTkMOkgF3ZNb/nCOK46LPcvX5Bvmqp/VrDX8+/c/U
 dS8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=2rqsDgrx9PpxqMYOTIOydtnaWg5zC/o2E+q3xCZ9M7U=;
 fh=8kLy8Cchkv6HU01zDgapzB4SRbyqUfaRhLrjroAK5g4=;
 b=ABovB/j6K2g6z15De0is4y1Edp4vMuhKf92OjULKKyKRtSpc6z+GgZTm8wvO52ppsa
 o0/fUMqWnDg4/lufhhOXg3YXMfkWmXoFnTOXGqENy5P5xD5L41wL2eDodTDZjALqvUpF
 Mf/TpxO2kf66TryPgGHseiLMLE7Taor/tfuY79U7e1mF84508me4kUBVnF4J0lbHlT7f
 z3/koVczU8I+t+TnC93FJsbzjzUSwvFd0Ve+Xt5dHK68pBAv5TGKEuf6F4KrIkIeDCqD
 hltOWraXZl4M6aSSIy/o4wvZJnPj2LYQTse/RIvq53/jWZ10Itp7ONiTYQPczoigTA8+
 Qf4Q==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1791813444; x=1792418244;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=2rqsDgrx9PpxqMYOTIOydtnaWg5zC/o2E+q3xCZ9M7U=;
 b=O9auoOh+YGZqWnjs9ANzwNL2UURyXYD+3IWQdC9TOaGfvTfLYXkL16KN61rN7VDmbm
 ccuCENtwRmI5S/dWaVDCxTHjb0KrImhg8tq2JvQm8klP8xfUZ8HntnpKAZFC6VcOspWf
 WMMWxKvGdYaU4pE5PVO72bPhmcv6v9OmFMfiQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791813444; x=1792418244;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=2rqsDgrx9PpxqMYOTIOydtnaWg5zC/o2E+q3xCZ9M7U=;
 b=jpdso9G9DOrE6xuucP+3VKqhQJR7UI0OXfp/3bIz7sMjCVOE/vzJkJWQMZ/f7d1yaN
 97YYFXG4Fu2ijZXY5d2xItMDqiS+A1DM+iodq0LeQ/s5Eg9QZClbEqGZLTmjfkowBXLt
 DQEudhAELbP/WpYjRBBsjQ3XZNeDJGBVjM4URBLmgvW7Ymdk8gdG4KIZtJe+DJ/X0Kn8
 PdS73kv1J6uFcc0LDgSRm9LqTZomgIOp8Mv88WfAroyWkXzeWH1ByzE8wh7N9ygy/Z9f
 qSvlRck+pvX8TfX3a6YLqU451mXgJo5ry9XB94QIb8X26eOXVmprvjZ8qmF7HD2uJ+Ry
 vcFw==
X-Gm-Message-State: AFq9FYKLdTmFe9ZkpNZh/7y1fUOgiQ3wE7Yn/AQrmYP/BhxAccjD4Gz3
 8ueFdtld4vxKZLRnXytT6YsDX3DYQPyJEsxcr4lLG4Q3q510CNMIBn32VzeJGSOZvYDD8k55F4B
 D5jiWzUPCo1Wti+niOL2sUyfICOmXT1tqx2oYnLUX
X-Gm-Gg: AYBFou29pOAbBXsPWviSZfz/RiO5oj8kI3OOMgx3GL19ib3hp4ILIj4boAxjnf7hDqr
 92xljcVN0e6TLghy1WNhizPiwWmZOmT18qXoJB2XYMV9n9O9SZhKKbAEWhZ1PTY86Jvn51CkyQV
 UsHrwnLTrxTv2zmBdB5ZacX+jeGdIe8ksOk0XuvEGA1J+0zd9YsUAEGTJZnxzlmOOxfHQcCK8Wb
 /4yhOjGdFiwfwtCasVTOoGxzMljRl388/pkrkF/YyNJJKsMTM1OILBmXykG6PVUuSsQ8N6qECSq
 LnhEvTfKdFQDiPmTFapJmVEHY7ZkF9qK4qrqIPnLjkDGevNvEFLBrv9cEeHATbKKhw==
X-Received: by 2002:a17:906:c106:b0:c2d:bf61:24d1 with SMTP id
 a640c23a62f3a-c31a9a2919bmr852064266b.1.1791813444270; Mon, 12 Oct 2026
 06:57:24 -0700 (PDT)
MIME-Version: 1.0
References: <20261010-b4-binman-fit-fdt-compression-v1-0-4465558758cc@protonmail.com>
 <20261010-b4-binman-fit-fdt-compression-v1-1-4465558758cc@protonmail.com>
In-Reply-To: <20261010-b4-binman-fit-fdt-compression-v1-1-4465558758cc@protonmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 12 Oct 2026 14:57:08 +0100
X-Gm-Features: AclHuK_DOqYrijM_ZQL8EyDkufBcxFfx1J3gJEKnqo1xGHy35TJ7sINg45TSpRo
Message-ID: <CAFLszTjqGQe4eH3s0LN_5Y3R=joME8xCbSkQ7_XMRaG5ySiJtA@mail.gmail.com>
Subject: Re: [PATCH 1/4] binman: fit: Actually compress generated fdt images
To: petr.hodina@protonmail.com
Cc: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Marek Vasut <marex@nabladev.com>, 
 Wojciech Dubowik <Wojciech.Dubowik@mt.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Petr Pavlata <petr@acrux.cz>,
 David Heidelberg <david@ixit.cz>
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

Hi Petr,

On 2026-10-10T14:24:46, Petr Hodina via B4 Relay
<devnull+petr.hodina.protonmail.com@kernel.org> wrote:
> binman: fit: Actually compress generated fdt images
>
> Reads the node's "compression" property while generating each fdt
> node and actually compresses the data before writing it when the value
> isn't "none". Only "lzma" is implemented for now.

Please can you put the problem first?

Binman requires 100% test coverage for each commit, so you could
squash patches 2 and 3 into this one.

>
> Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
>
> tools/binman/etype/fit.py | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

> diff --git a/tools/binman/etype/fit.py b/tools/binman/etype/fit.py
> @@ -13,6 +13,7 @@ import os
>
>  from binman.entry import Entry, EntryArg
>  from binman.etype.section import Entry_section
> +from binman import bintool
>  from binman import elf

Please put this with the other 'from binman import' lines in
alphabetical order, i.e. before 'from binman import elf'.

> diff --git a/tools/binman/etype/fit.py b/tools/binman/etype/fit.py
> @@ -922,6 +926,14 @@ class Entry_fit(Entry_section):
> +                            if compression != 'none':
> +                                if compression != 'lzma':
> +                                    self.Raise(
> +                                        "Unsupported fdt compression "
> +                                        f"'{compression}' (only 'lzma' is "
> +                                        "implemented)")
> +                                comp = bintool.Bintool.create('lzma_alone')
> +                                data = comp.compress(data)

Creating the bintool on the fly bypasses AddBintools(), so 'binman
tool -l' and 'binman tool -f missing' don't know that this FIT needs
lzma_alone. It also skips the missing-tool handling: if lzma_alone is
not installed, run_cmd() returns None, so compress() returns None and
fsw.property('data', None) fails with a Python traceback instead of
the usual 'missing bintool' warning. Please can you follow what
Entry.CompressData() does: check is_present(), call
record_missing_bintool() if the tool is absent, and add a test for
that case.

To register the tool you could scan the generator nodes for a
'compression' property in AddBintools(), or just add lzma_alone there
unconditionally, as is done for mkimage and fdtgrep.

Also, why limit this to lzma? Entry.AddBintools() already maps every
algorithm binman supports to a bintool ({'lzma': 'lzma_alone', 'lzo':
'lzop'}, otherwise the same name), and SPL can load gzip-compressed
images as well as lzma ones. It should be easy to factor out that
mapping and support any algorithm, raising an error only for unknown
names. What do you think?

Finally, please can you update the generator-node documentation in the
Entry_fit docstring (and regenerate entries.rst) to say that
'compression' in an @fdt-SEQ image node now causes the .dtb to be
compressed?

Regards,
Simon
