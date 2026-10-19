Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 570E3CCF2D6
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 13:26:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 290AC80CC5;
	Mon, 19 Oct 2026 13:26:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hXke3Ve8vg60; Mon, 19 Oct 2026 13:26:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 47D2280D87
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792416373;
	b=N0fM+YNyA0MzO7XtD6LBfXMdQACfDyIM9nnc2rgmtEJNybeLBosmQEcAvhwqPbgOCO3m
	 IlJqdYUfb3VCFcbT0q49YLzwsVbHLIwN0X1fPEg+j+9GA1ojESj3ZBw5t1BVh/+F2+jSS
	 01acA9tvJMXQocvuUPSMt+nMc194nWYJ5Q7sFAkLRLLXaCpa+QxuRShM2BlKgM/VVh+1N
	 eA8r+dcyJ7wxHuLEzLyrNhzpXw4/DRY5mrTp09xk8fX5YjX+5TNGOrW4vvbtqIDx7IFpx
	 JuSPIxsHuys5KAjhRL5POSF8P8Rt4gbXOzIfMan22JjjPnjWlj310IdK3NUyGdziVaQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792416373;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=yPNJ03sCBSiBOIESRwAR1Fj6Hn5WXW7RWMfILplh09A=;
	b=theHG8Xisi0RY3ROrUCPjDZ2eqq5HnZHkLuhqEUgZlRm1XYHMcfpijGgnUxr1CL/JCUZ
	 9cWOQR4VUYzyY9WwrhLJbWtvz29kC8/m6TP1ZFaBEnHT2Yw2zhnfa1p/wC6pVh+wDSgg0
	 Isw6weetI0jf8gmOpTZmTH58vX7mtfpPisiFX8tLMhLVAhNMM7xFav7ZhsmGvGwf16gX5
	 8swWZBB7KB2c45G6zA1rrtHf88H5YWCNi+X8SF8QnxdIjUpQ87RhQuxRQg2G4EaVv3qjk
	 Z2EGsHYWjXk/PN2FPxD9RA+7h7Yywngi8X4PGNTgo8wJsXpZ4xSlXc+t9I4BudgcYfQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792416373;
	bh=yPNJ03sCBSiBOIESRwAR1Fj6Hn5WXW7RWMfILplh09A=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aPrHNf2gw6ZqbWza2MRZ+HFBBTNCvRfDYKeKpryAl9hZ5lvk8ImIGOCHY3gNS6kYy
	 br+RhN7NqLJ5fGIJBBwhIo/lBNGiGTi8yDcdu8w1q6y2HJV2eWvzraCgG0XTxZ1hLn
	 vC5PXRHwCNWh/0I2pIXtUc8ANCV2oe64qfTWfE3iY4poLxspWE8aSXZg3jMCWt5Pgp
	 i/AF64rbwbHPEjdmmptqvTmRpmD6nucG19LVO/O4q8WmrKOkHKuYqjV4hpoAjAoSjL
	 nobTojAZa/h4pGK7hoWILMbDCXlI9Fxj5jYw0/sawgUZJuM8Lux1kbmus8wX1+JzUy
	 m0JqQxKdD3e3w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 47D2280D87;
	Mon, 19 Oct 2026 13:26:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 162F723A
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 13:26:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 13B7E4010C
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 13:26:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id d4HXW6CrRn0u for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 13:26:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 14B984014E
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::531"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792416371;
 b=D1Alz7gFO1a15LXTYpDJ+a/Pn0XXYcisNVyoqE0/5uDxxW9xJuHghy75B3M8VT+nbuR3
 9b0P7pnUvF9KDiDLEVtiPWNj+P8Ivipf5lM67Uf8kR4FKq0m9wKiAgWWwLpqmMXbIYV3h
 cwLqBzho5gvrA+otzJKKoB8DkvCDnsU2uOs0ce8YbxRh1kRIlkbCZsK06m9ZkJGT541Iz
 BTLfdRJ3KafVNHy9krMZzVN8n2TYvURvfMRso4zBiG1b/2AY1INmJl6i5j24uX0aQ2821
 Ro5fjxpa5GB4DimBeNvtpO4rNOs8X75HJGGAEnvSlwFJ0fp92oyOcjahC+v19a5H8Eg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792416371;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=yPNJ03sCBSiBOIESRwAR1Fj6Hn5WXW7RWMfILplh09A=;
 b=L1PhvG80spUU8eSLsNKvzKDD8xV2QMge5oQVy8Ks7MFmq7nSJaOlJHCkZZ8P0bgphdYp
 prwiDenQu83eqMw4blDV8nObJHlgY/bpJ9Bu2CQfMZZLhXeQm6kXzu7R65WJ6cXfci2zU
 z8Di8pklymMjeigIDIcDrGbx7Sh8LUvX8P5EiwaztanVXD/W14Q5svo2VXGF1XWIFfjPx
 2ae/BpzX6B1nT5I/ZGAgGm+P0tRhTCuDF2Ie3EW63QxEMwRhQZZRtR+Ho75MNQXI+1xLA
 4COIOFbhIJ0Rib2I68yKEzbk1wOAfDYfoFjwevLG9IE5d+7UgX3HRMz73xl9vvFvcKw==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=OiKBe7Cn; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::531"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::531; helo=mail-ed1-x531.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=OiKBe7Cn
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 14B984014E
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 13:26:10 +0000 (UTC)
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-6b2237b596cso2858319a12.0
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 06:26:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792416369; cv=none;
 d=google.com; s=arc-20260327;
 b=pvscHhwB9vvY7FuDwzLcgkx82NFrZwR3wFSSeHIdJrGmBJqwQtKByzhYqAcU5pph76
 838LAc71Os6PjaQwsHMtxTHYc3VVmrYMRBar9tX1awRutFjT1pX4YaOeme/kUUV9qW2/
 2TZ2M47fGDMuPYawpCth1cOGA05oHFsCygIlFQn/7sGP+2QquGkDvhKoggGATOPFGMzZ
 0dTh8ebo7Jm3/eqOPF7K2TrZ5wI7OeankGwN1xDL6dn9Bu9r6IMJ4m/hJYId8vP0g1hF
 KEevaKDRBN0zP8/yUKPls9czY5gvU9JE0+O3vpfuRUnemuPXfh08W5NejPwsCiHBskAA
 frkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=yPNJ03sCBSiBOIESRwAR1Fj6Hn5WXW7RWMfILplh09A=;
 fh=CV/hZMDXZkAouVsA4eSR5lxDsEmWvDI1m8pddFi8Pq8=;
 b=YH7wZ9wCBX+CVu1AHzCeWku67yXOhuNi80YDJ9SD22iF20/KgUcERQ6vr6duZzpGI2
 TgzicYI5AY7HgJ2Azi60Kv1Zv0P7y2RRlImlaVg0C7yM8+B7VXl9durHly19uMc6Vwap
 fTjiY5/nKScvpTmoWI57oM5fbsHWqt666fUMzH31E/mmoZ164MHjePKgW3SbSBd1VWm9
 g2Mj5ScbXnBbQjzNdGPnfiugdimRKiKM8hmkFxQcWh3YnFArHZCOoLEu98dcY24+c+Hl
 pN812feYLLzqYr33hECOCp/Q+FMd5zroL7gdZaXQX0ahuljzfQp0WggIYCEW1ZMRg0eu
 Wdhw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792416369; x=1793021169;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=yPNJ03sCBSiBOIESRwAR1Fj6Hn5WXW7RWMfILplh09A=;
 b=OiKBe7CntLSYdi38JkX0hcAXSm6X+RyV5vQLj4BJQw2ppXqwC+Y5XZwlJuAFvx92gr
 oQhCfi9HDJakn6YCYte4EJbHWP9vW+GYhWq2FAtXDoRR9eHUcXJWZ+VbjD/rAJDz/UUK
 u/93awhKaloI6toUfKR+Lf8FTcQ5up2WAZS2Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792416369; x=1793021169;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=yPNJ03sCBSiBOIESRwAR1Fj6Hn5WXW7RWMfILplh09A=;
 b=W8XzI3rauFhLNNqf6v4Gmg+yc1ZxvPgvJTdgHKXz1DGDp4I659roATTPiFgJ0j7T+8
 mUUI9rJUCfBJmC2LKBuSvMi/uo0vIdxWhRBBLwpQ1oMR+huNEMmH8zYxi1/8THWUiYRg
 Hh9rwjmONl93IggcIsOkgo8dmEKNUrgA3LsoK4sCMk2OGzWxx+xpxJXDk/KnfPd+1ZYH
 mRB9an++Ge+4tZMrReZCWZi41C+WdYZC1XVwPs0/2HURFFatmwbsvXO1xRqVYVQCCO2f
 xkYWk88tcs+S3kgXVygX5gI3ReSXz/Vz7MAb7Hlh5dnITQSQ462rJ9VM5NZH6DrZdLKA
 SSiQ==
X-Gm-Message-State: AFq9FYJStInOcY8iHyxNA7ScVwOTT1/oxvaMrJZct8pKyp8g+sgPoPhk
 kQBUScKJlWd8Tez+QoJoWiJSzPvpVunNjYvE0VimG2IB94dP+DzyYdE5Vy//geSXyODgUSl4aW6
 qb5ydh/r0Qllz78mcU1ORLaDVLzwfBq7yoWi3WFS/
X-Gm-Gg: AYBFou1gfVHJiC8pRlzZkZQQOz9J14Nh+CAioqBfVsmpXUY5JbyapVfQwJGlDOQONsw
 IMW2puOrCMq7XbE2iv6hkz6e3GfiXwc0B0vfGNIfZtvgkeHvc1vNXBxvejduODronAtg6gYW8wt
 F1Kgj2KGrY3ATmuHxVHiFHHWEwveG4fy6gh6UtQCz3lYNcJKmTyeaiKuZkhHqNEm9u1XmWqfSay
 X4JyUQnKqweArCde4KmNZNl2CptRZ9s0dX5MYnM48ILIDS4QSzxlOmS9EChkE9GRAgRy6eAGIlk
 J1RehWsU+GT7VIuKupR8MrLxjsf77UC5NSRVFM/gYJEOCIG7qbJgbA==
X-Received: by 2002:a05:6402:3605:b0:6b1:b849:c7c7 with SMTP id
 4fb4d7f45d1cf-6b3a8134625mr4905578a12.2.1792416368689; Mon, 19 Oct 2026
 06:26:08 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 08:26:06 -0500
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 08:03:18 -0400
MIME-Version: 1.0
In-Reply-To: <20261017173458.226395-1-marek.vasut+renesas@mailbox.org>
References: <20261017173458.226395-1-marek.vasut+renesas@mailbox.org>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 19 Oct 2026 08:26:06 -0500
X-Gm-Features: AclHuK_LEmkGo0uywiV4W53TTrW48XyDnXN2y-odgfOlIr3_EzjUUmcwDykJudk
Message-ID: <CAFLszTgL+SZML5=ES_wzy7mO+ARRc2x_1TJNzhvsiF-XoD90rA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] kbuild: Pass -Eno-node_name_not_empty to DTC if
 supported
To: marek.vasut+renesas@mailbox.org
Cc: u-boot@lists.u-boot-project.org, 
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?B?SMOpY3RvciBPcsOzbiBNYXJ0w61uZXo=?= <zumbi@debian.org>, 
 Mattia Maldini <mattia512maldini@gmail.com>,
 Rasmus Villemoes <rv@rasmusvillemoes.dk>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Vagrant Cascadian <vagrant@debian.org>
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

On 2026-10-17T17:34:28, Marek Vasut <marek.vasut+renesas@mailbox.org> wrote:
> kbuild: Pass -Eno-node_name_not_empty to DTC if supported
>
> Since DTC 7c78c8542d73 ("Added empty node name check") , U-Boot binman
> use of placeholder node names such as @fdt-SEQ and @config-SEQ triggers
> DTC ERROR (node_name_not_empty). Inhibit the error, as these placeholder
> nodes are updated by binman and replaced by proper nodes, the encoding
> in DTB is temporary. Since -Eno-node_name_not_empty is only available in
> DTC 1.8.0 and newer, introduce "dtc-option" make function which is very
> similar to "cc-option" and other such Kbuild functions, and add the DTC
> option conditionally.
>
> This can be triggered on e.g. Debian Testing (as of 2026-09-07) when
> using system DTC to build a DT which include binman placeholder nodes:
>
> $ export DTC=/usr/bin/dtc
> $ $DTC --version
> Version: DTC 1.8.1
> $ r8a779g3_sparrowhawk_defconfig
> $ make -j$(nproc)
> ...
> ./arch/arm/dts/r8a779g0-u-boot.dtsi:61.16-70.9: ERROR (node_name_not_empty): /binman/section/u-boot/fit/images/@fdt-SEQ: Empty node name
> ./arch/arm/dts/r8a779g0-u-boot.dtsi:76.19-80.9: ERROR (node_name_not_empty): /binman/section/u-boot/fit/configurations/@config-SEQ: Empty node name
> ERROR: Input tree has errors, aborting (use -f to force output)
> Check /path/to/dts/upstream/src/arm64/renesas/.r8a779g3-sparrow-hawk.dtb.pre.tmp for errors
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>
>  scripts/Makefile.lib | 13 +++++++++++++
>  1 file changed, 13 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
