Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9EAEE8536A
	for <u-boot@archiver.kernel.org>; Fri,  3 Apr 2026 13:22:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C0F5840AB;
	Fri,  3 Apr 2026 15:22:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="C+n07baR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB160840BE; Fri,  3 Apr 2026 15:22:08 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E95A383DC9
 for <u-boot@lists.denx.de>; Fri,  3 Apr 2026 15:22:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-b982518b73fso294450166b.1
 for <u-boot@lists.denx.de>; Fri, 03 Apr 2026 06:22:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775222526; cv=none;
 d=google.com; s=arc-20240605;
 b=kh44eFCFl8gByINaAcpkAarmhVEQ1LlhWWXV6WZXVXDb0HZ744h+m+3yVUwhJCtBoq
 bFCPICYNnXt6TYVRV7+xe766u3sdw3HNnbaDhJb6Upb2TdQIeDZTmMGvmPEmyb9UY3jH
 uEPzoBXikcoI42HQXaQZn95e2Nrv6XN0cIqNmwRFCDaR9/O1E3LlROMu2UuqY0TIwD0H
 8TPmPQClPEsqAxB69/V/hWwUF/V3IQFoLWw6poBtKp5xY0uewpf+BPg/YC1hjuP590zZ
 B+nQuudiS9rNhsyaKS8v4y9xw5QUI/DFmlV8SbPTO17SUBjyPR1z0mSq00MmqbYeyP5J
 1ujQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=j9dMIh+0L/7Jy5htshT+H6N0DXPXpIDGRGCI4xR3cdE=;
 fh=2Ai/DF/OygrgX5KD/xptwaXayaptkAAlqyY5KCXDcm8=;
 b=Xq/DO3CTKzcICATWVs4hhJLJsY9lioQrY9Bc4/mP9EFOCbvcsqKuhZnQV5U8t7fTGd
 5JKWrGWoVlf07NWUXWOcGOVk+mcWpiE9jSmxiv5xaqHhg1aOgrxihEJmGoG6wh9XPS9E
 RktPg9J1UDWSu+1tH1ROTp3dmczsBPR3cxgXI/4kWwmljiIcp2Cw8Lk8xYgPcYc6Y2wj
 YWJ3GqQ3FVggwNVQO4WAtG/OD2YNuIvsmcpzWUnrt/JQcBo21QyuEI3p0O2IC+efhSM2
 HvR9J6oRASZy723woLz5Z4Ds3zl9y4EgVzBh4DT4vyaNY4p3Ht4qjH8Bcr7E7SWggv5u
 v2aQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775222526; x=1775827326; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=j9dMIh+0L/7Jy5htshT+H6N0DXPXpIDGRGCI4xR3cdE=;
 b=C+n07baRupM8cjwjACByCdY7s5WzY3BXPNarJlCGvhwYbX8tQKI1XWIvw136nl0Ru2
 4yr7n5DNbGxOMEn5YbB5qnA9sQsRQEBrofqFUBWcz6WDhkxt6yRle2btwZVqZDjMYMmg
 vA1oVzDYOVWemhqsCESkqaBBvNkIhrR135F28=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775222526; x=1775827326;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j9dMIh+0L/7Jy5htshT+H6N0DXPXpIDGRGCI4xR3cdE=;
 b=J25rkRjhh7SpwSnwEEd7QICTjpy29Htp3+kKEAs9nF0hu2it30nDxVRqGTRg0OOmh1
 e2E3VI7MnpWSfCbJQkzpIKMMjKkIRXzt/BIWdQzdUCBpSpN6g+yMdo72QuEMlvDRuc4d
 KpnA7E7FAwWXNaAQOCrB1tSoXHyZvSItpGRTSK0zKzwXb/bUc5DSkfsthx2DVz1YsCPe
 CjpBAQjMG9TAPDi87SjhxvOhpsktk2a8GWzKjsiNNJ+iTPKcaRJWgx3w5RwQtSyQIuTk
 ikYEPZO/NCmnC+/MpHdVrC3srutUj1Fjh3rrQis0qO50SHLqtY0HNrD1beBE475vbJcj
 hHGA==
X-Gm-Message-State: AOJu0YzNwMbTJ0zu5QAgnkOAzVTL+eSAZR6PKlXMFK41D0IkYau1y687
 yZzSYWJgV2zIxxDc64fQrlch4jopMKZHe+um0XSKzVRgNhcR/r1x7+h8Su/Ry/9z4oNw24vQIIK
 wkS/kb9E3p4htQUr5fPaFsuG/01ME0UaHjOQZNgRK
X-Gm-Gg: AeBDievVs0oI9Ec6WiAXWcumDjNzUDsM+LcrwK7H50vjpbEvr+/mQuVLcYfCP7F9doA
 iT0XqKEdjjAGQ1Igs6ZvPw7F4UsHcMAGo+aJH2D/X4IkO90x4j7eg7Fw3waUdUMBnfRPabtjcIu
 grJIIljOjhjSdRWOGAkbJR3UXzMIxtTWHyTreiPeetJCVn2ks3649YnI0v8+u9lN45EfEe2RF8z
 ZZE3CCv7VnAABLI6GNgMN/z+31Eb4oh6dM0YgeldTbhvNUHodsAb8ZbKer2E/9rzPa2MapqcnLm
 8/eIZintX9FwC5tT
X-Received: by 2002:a17:906:6a10:b0:b9c:1667:e17 with SMTP id
 a640c23a62f3a-b9c674229a9mr151240566b.7.1775222526220; Fri, 03 Apr 2026
 06:22:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260403073251.1051533-1-paul.henrys_ext@softathome.com>
 <20260403075528.1150196-1-paul.henrys_ext@softathome.com>
 <20260403075528.1150196-2-paul.henrys_ext@softathome.com>
In-Reply-To: <20260403075528.1150196-2-paul.henrys_ext@softathome.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 3 Apr 2026 07:21:52 -0600
X-Gm-Features: AQROBzA225IYMQH_l8giCKpwrApTMbtvPavKyIUGER3MjMUvgUEfgBJ-bPvXKmg
Message-ID: <CAFLszTiQQ2rGrNcuQ_oQPb8xBt72XZ-Sq88bkZ0eDK9x7X8SBQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] binman: Generate preload header and sign data only
 once
To: paul.henrys_ext@softathome.com
Cc: u-boot+nodisclaimer@lists.denx.de, sjg+nodisclaimer@chromium.org, 
 trini+nodisclaimer@konsulko.com, alpernebiyasak+nodisclaimer@gmail.com, 
 philippe.reynes+nodisclaimer@softathome.com, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi Paul,

On 2026-04-03T07:55:27, Paul HENRYS <paul.henrys_ext@softathome.com> wrote:
> binman: Generate preload header and sign data only once
>
> To optimize preload generation, generate the header and signatures only
> after all data has been collected. This avoids signing the data multiple
> times.
>
> Since header_size is known upfront (from __init__), set the preload
> header size in ObtainContents() to avoid an extra packing pass when
> ProcessContentsUpdate() detects the size changed from 0 to header_size.
>
> This reduces unnecessary repacking and signing operations.
>
> Signed-off-by: Paul HENRYS <paul.henrys_ext@softathome.com>

> diff --git a/tools/binman/etype/pre_load.py b/tools/binman/etype/pre_load.py
> @@ -152,14 +152,14 @@ class Entry_pre_load(Entry_collection):
> +    def ObtainContents(self):
> +        """Only set the known size of the preload header. The data will be
> +        generated later on in ProcessContents() when the data from every entries
> +        can be retrieved.
> +        """
> +        self.contents_size = self.header_size
> +        return True

Setting contents_size without calling SetContents() is unusual. Most
entry types provide placeholder data so GetData() returns something
valid rather than None. While section.py handles None by substituting
pad bytes, this feels like relying on a side-effect.

Please can you call SetContents() with placeholder data of header_size
length instead, similar to image_header? That would be more consistent
with other entry types.

Also the docstring should have the summary on the first line per
Python conventions.

Regards,
Simon
