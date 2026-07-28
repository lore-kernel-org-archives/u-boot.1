Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2928CC531F9
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 11:18:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E613740978;
	Tue, 28 Jul 2026 11:18:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VDYcIz_3g0ZH; Tue, 28 Jul 2026 11:18:28 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1DE3E40964
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785237508;
	bh=sHfXweiG1GFNWJwbmYS2xyQae1iPSsy8GZfHPYn/8qE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aRT8KT1qYl7VA9txw8FQBffmIrDpVE3aKNj90VbnKWTBP8gD+tdD4ZfFKDRcRt/LN
	 1j+5qW49HW/U8241UkFGYGZERCaQumkkfbzZ0BujUrnrBO1CtdrpS3KUDcsPjFHJ0t
	 Km+IcFbD7ilZBNukoL08gfNcYnN6LkDwZK3FT+VG9SGBSOTl/bJ//qP0k5jlDuSk61
	 ymbyHecTkK9OvzfAy+YRguJOFC135teB3c32kLfunfDINqPW+7V85AxChxyGCRuwmb
	 X+dJ6dlptX2fZpGGg0sTsYtNiGLy9AqX1AxlUsb07hW166R3UkXdko2DdyUoXfZqD6
	 vke1aHD7us10w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1DE3E40964;
	Tue, 28 Jul 2026 11:18:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 13EF6350
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:18:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EF29960724
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:18:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nSQF_9dBbc1M for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 11:18:26 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::536; helo=mail-ed1-x536.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 0BCC860674
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0BCC860674
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0BCC860674
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:18:25 +0000 (UTC)
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-69e8ea2783aso5099045a12.3
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 04:18:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785237504; cv=none;
 d=google.com; s=arc-20260327;
 b=UkC5mysvi/VIzdq+LC7dMwrZdOWJqSUVldlNANxNsauH8v5Zdi1ffX8uSq7NdAdacr
 GnzOi6IKbzx8WnTcaZ9+TxqLKQqIf+0zOtMn0RCCtyXQ8CmFcoVYoMABvAaT7pDLTv/u
 /96RirooeCfQzu7w4FhQZFXLgU8BUf0+DzUmMEn3e60mApGuoJjRAZlJvrCZ2zNacsz3
 hXgetJW0ZUNm0F+wSSMuK5au6ZmoOdpFSsTulTs6EWSeTBOS+vnHnOwvRT89jJiMgNAC
 FPGPxQCHggYs8J6U4yEF5Q19SFz0AbJYFw/0jplc995PSIMzqPJ9COfCTDeRQqV1pzWw
 1hbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=sHfXweiG1GFNWJwbmYS2xyQae1iPSsy8GZfHPYn/8qE=;
 fh=5M9cRk65zL3LcSWXE9L6dvoV0I5H5nNquwGkaMhxR1Q=;
 b=gTQ6JE/pbi8tDi3mvitxhT5zq+2U03LSJFr8eirTzO6/5F1c3ZjTqQf4kBnFAF057m
 AzGV3L9WyUAHhhHcWajb4NGVh18sqY5TjD7r6xGLFS1qF2g3vh4mkJKEjYAkSss5pvpC
 f3RNlDvL09ceZi8tL8YdCXGbzzPdKpdNPrfyoksFSTZJ8wX9EiY/IfZEbuTYN0lru8ls
 J+imImqjxzAbH44FENYHK9/daklGZljZyEI5IDJh9zg7r4AkSJyHuqkVa+oFFfoUejD+
 Blsi9zT3hFt8CopV7aeSSxX2aTtDClRWg32nAVtOv7das0iuEcR/QlcdHjfkphdM+Oag
 12/g==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785237504; x=1785842304;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=sHfXweiG1GFNWJwbmYS2xyQae1iPSsy8GZfHPYn/8qE=;
 b=FfssNKpJhF4P0OCk/EV3PMepVLXA8n8l3nas0zqs3RQA6Yj/gsX/vhBlRTKGvEcQ5l
 B4kC5IpSQCAp3d5o0cVI37RLzc3PRx17dSib/CYX2Z8lsP/BHIWpr3gQKByt9PTMIaUq
 I61CJiWdKVHWbxnEv9YnDq4Pl29dFtszWdnIM3w276Zt3E2Z+g+49MTpfGcMaC0H4y+q
 es2io2QQAD86MkExPMtk6oQLTtmBqMi7lzrTatH2sffFtH3IK4crtuAMoYSX8lL/Vcar
 Pq6ZI6Ss81UCMcz/NATP8blcmG373NaFdm+Krtthv1iKzN4Wt25hh3GIuBiPzFx0GqY5
 ohfg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoXLTeT08DDxgaC8wtekMXm/hi9EQkCmyaWKnuTI8ZUxAIqnzRuiy3blWgGxjOXyjBel+rjQ+g=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YxmAEZAu/7InphScN9JjVXN3ckfF1QPY6FaFREeaExLrMBCFOuk
 d/LU/a04H5pdM2kKG8hlt98cXY91qsBg6wN2LZXv3TAMar2DUUJedHRnE8JTiiuPaWWRf+Fc/Le
 baMzbiOTPp31Cvob0Rrlnusf/4Yrf0tMx/MIuju4/
X-Gm-Gg: AR+sD10T7cGlLsscVXMGZTeCNZJOEYnRrRDb0CfJrTCdGtdBqoQjcBPNIEO41T6S/UD
 j6H6V/5YSyyBuT4Q6td2hikN5IVd9NxbEztIkDy5DAgRBDIrxphzWKe6pO4YSbKvhWROfCpjnMU
 nTcRy0jLo/DAVvpzKdHr9/fub5Va22sgAg/KDZs4L7bE9EXX4QoL35iNdrL1GYFaVgyqtQnVYVP
 dn07Gq5F5bXvn8cWU0XO9y6hUvEApWiQoFdlUTV8/QHXjeKN6iFaNILlhnp
X-Received: by 2002:a05:6402:194e:b0:691:7054:8c6b with SMTP id
 4fb4d7f45d1cf-6a034a9e9demr950294a12.19.1785237503930; Tue, 28 Jul 2026
 04:18:23 -0700 (PDT)
MIME-Version: 1.0
References: <20250914110021.4103-1-aristo.chen@canonical.com>
 <20260721152110.283998-1-aristo.chen@canonical.com>
 <20260721152110.283998-3-aristo.chen@canonical.com>
In-Reply-To: <20260721152110.283998-3-aristo.chen@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 28 Jul 2026 05:18:08 -0600
X-Gm-Features: AUfX_myOiNvcdA_raYPeYK1sKO8jzgg-enpZPCoNRJ60FRdSC8EorOeUFbBvCKI
Message-ID: <CAFLszTiLg4VUv7Bm1aGWFq921MyqOZR1rJww2dykvCO6qOZGpg@mail.gmail.com>
Subject: Re: [PATCH v3 2/7] binman: Fix FIT image overlap issues
To: Aristo Chen <aristo.chen@canonical.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>, 
 u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785237504; x=1785842304;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sHfXweiG1GFNWJwbmYS2xyQae1iPSsy8GZfHPYn/8qE=;
 b=ggHgvpi8tuKR0P22OATT6FAQw+OrSRiZhQ7TKfvtuSJaJ73le7dlExcjHIBX03nvTF
 QFvBcm9UHZg4xZ4v7neZbmZZs4KU3BrvZJzZr/6K5YW1YsFaD/NG0+9b4DrfBrMzKN2h
 36bned6Bp6bQ+N207kpEJNh6LF+Qt3i6D51Pc=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=ggHgvpi8
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

On 2026-07-21T15:21:05, Aristo Chen <aristo.chen@canonical.com> wrote:
> binman: Fix FIT image overlap issues
>
> Several binman test fixtures describe FIT images whose configuration
> references both a u-boot firmware image loaded at address 0x0 with a
> size of 0x2e bytes and a split-elf atf image whose first segment is
> loaded at 0x10, so the two images overlap in memory. The upcoming
> mkimage load address overlap check refuses to build such images,
> which makes the tests that run these fixtures through mkimage fail.
>
> Move the u-boot load and entry addresses to 0x2000, clear of the atf
> segments taken from elf_sections.lds, in the fixtures used by
> testFitFirmwareLoadables, testFitSignSimple,
> testFitSignNoSignatureNodes, testFitSignEngineSimple,
> testFitSignEncryptEngine, testFitSignPKCS11Simple,
> testFitSignPKCS11Object, testFitSignMultipleKeyPaths and
> testKeyNameHintIsPathSimpleFit.
>
> Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
>
> tools/binman/test/fit/firmware_loadables.dts             | 4 ++--
>  tools/binman/test/fit/key_name_hint_dir_signature.dts    | 4 ++--
>  tools/binman/test/fit/signature.dts                      | 4 ++--
>  tools/binman/test/fit/signature_engine.dts               | 4 ++--
>  tools/binman/test/fit/signature_engine_encrypt.dts       | 4 ++--
>  tools/binman/test/fit/signature_engine_pkcs11.dts        | 4 ++--
>  tools/binman/test/fit/signature_engine_pkcs11_object.dts | 4 ++--
>  tools/binman/test/fit/signature_multi_key.dts            | 4 ++--
>  tools/binman/test/fit/signature_no_nodes.dts             | 4 ++--
>  9 files changed, 18 insertions(+), 18 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
