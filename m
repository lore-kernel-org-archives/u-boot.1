Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00F8606A31A
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 08:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Mv38lWEq;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=iS48BNrw
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7F01460895;
	Sat, 31 Oct 2026 08:34:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PRC_4KwwPilS; Sat, 31 Oct 2026 08:34:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D59BB60A96
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793435673;
	b=Gu3UDyexxEt6/YAJdfGjVTo17Gqv/csveIcL2pI8iuMV0avNnH9G27qkVpHXLxue6DvN
	 0apy9ReiN6xbY5w/6tCICP78xUAgMHNeJyyOpUic+CGUMFDDHj7BTsgPlcAERIfbhJ5yE
	 zothORTan24VfKnpDQKYE1TXNm81JhFlMtzYmwnXIXKQ1byanPjKNQx9LJS/bRerUOia3
	 G57xuZ33PfZJXe48aDulXHyzm/Ccq5+MAD42CSq1aUowt+GqPMcIqvqPbnVSceOpiLhGE
	 fZfDNfejSgfVhHjImk3U36UnSltqKSpZ8OEZ1Q2cS3ZDrj90eeE2tVYhq2Q60JNjZrw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793435673;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=5kjvsRUNU2Dz+ws4ZNGIJe5ZpWOoTEPgqocMmaH98uc=;
	b=dMSVm8LFlhRPaiclWaAKWJZUWfTbeeLJ/l+X3mFFQ+nfJ9yM+kRLE27A3di8GHbKjWbA
	 sY0RL+XJJuvbkQ+3/+BF3FIAji3MsaDvrmfJrKHtjG/8A04H/jE2LR13tFQbOONENW84/
	 Fdzl9GmG6NBSZIdIqU1J6DcbhwyquATgiPgNKOBubfg031jbOOkcV1YOQ8CsbGvo4EbtZ
	 zWp6upPMFCPNlJqBcz6DJ2xfG77RC9tENxlWXt5nBwYOSnADnrfB9voK5hozDIt/fM0ZH
	 pKYKxavN2+RicdfZtHIKjFqHpxVwp6ybN2n04Aya4ujP1AgUTZi9jwVI0O+38hPnfkg==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793435673;
	bh=5kjvsRUNU2Dz+ws4ZNGIJe5ZpWOoTEPgqocMmaH98uc=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Mv38lWEqytP+vRgWZdLl4Ko6bT1WR5EXaQoEtGSspwy1ObFDdp/PV8KZOoPW/99yz
	 Kh2yRBRvTQxXJTvO5VZOgFffR7BwdSd+MwMNCE0Ze6J4uy7sGne6pr94BYcAY5WC6G
	 ttfbhDDkXK+DnTGz20Et7tIzqVHOHEeUoynjmbp/OF4kuA5Ide6z44fqgn536Ox5nM
	 ZqfrkL8OzOjWIE2bXJrKmFnr7tDb1l7LJrwXCKMd4TcXa0MGwwibLzBOiVgnKsJvH/
	 pdAo+a+ame+iWe9+ZnuHsR0/TDfE2h7kgW5aoH1y9R4cGSjqBTLze0GHkKW5sGjRUb
	 43d/5NDL1sAmg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D59BB60A96;
	Sat, 31 Oct 2026 08:34:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 649844BC
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 08:34:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4AEEC400C7
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 08:34:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2as2fIsDlHsN for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 08:34:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org A63AF40057
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::102c"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793435670;
 b=jPGdb4TEwS+huMouPdGBwMZUxw5Tnm3SZ+lRtV5pWH48r/NjzWi7IKA5N/xLbEZKBUxa
 p7JRED+qst1qscsJv2GmvRgEbQE/2W1AxKrpsH4BuOK5QamJ1FzDpmSERPk85JSCdHtrB
 y5aeROlLYyFHXjRgEJ4OlChiIjggx+/nmjPtTIBW/Xeo5HooPcOie6iwnQZIIy4AzBIZK
 q94RXznQnmfo3sRIaa0upLwp07yyasAT4BarHT7KYqulFD13+VWuQp9Sb8khUIj27oLOJ
 w63kp1JcwFvsTFZ0PkaiZqsEcM/o8/v9XsvmC7jPL1G1gZewjuJNIvKeLtaHkyVBKww==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793435670;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=5kjvsRUNU2Dz+ws4ZNGIJe5ZpWOoTEPgqocMmaH98uc=;
 b=UprPRQcJF4N8pnq4qAHO8CInpZ8QY3KRbeLqq6l7uzRIE8NtP+CICxCzpunkSzEH1gpQ
 bSmJpL911jfjjMTnRg7A2NYx15gtQSN+Vjw7eOr9CuomPesZaOv0ZGf3g0GlbXfNyYlPo
 HyhjaynNfYayHWJ6m2Zyje2AzT8yKGi3CrYCAbQDRwM/tZH9A4+gH3dLRnFfoCZkME4PZ
 xiKyjELM+ccxnz4ppR5cCpc5VQH6QjZ61zkGU82kIApTZYMKtQkmL+Av/gfSPKiEVb46J
 +3eIZxVKuAMpzUGwY5brEPso+dResSJbDtzOzazre1yPpr0VCkwQoBapNqrIbN4lzCw==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=iS48BNrw; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::102c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::102c; helo=mail-pj1-x102c.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=iS48BNrw
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A63AF40057
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 08:34:29 +0000 (UTC)
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-3ad41b47541so1275693a91.1
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 01:34:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793435669; cv=none;
 d=google.com; s=arc-20260327;
 b=ZvKrEGzxCS98PsUqmtnUue79VK6v53wECJ/UaJAjhE3zaEFl6zpYLWuhe8DhjAjUt5
 7oiwDAIvb/eQAIla0bgy9Dy13JdwPHAfdQ5RKqf5WuTB4QM/8O6nAmz+mBRNrdaOvTiU
 6UB1BCQb9w2XB7I3H2srKwVg05z0NcvtOrzJQhByi1vmCxLLBdhYT35dGQPRkVQM0hOH
 OBbGTBvPOJDzxzCbfeJvLB60TerJC4qKXDjK7Nh/TIxmipBmYLNivVZgCf59khNjlO7a
 62pBI7FHMekcE2XZuLIWdRiV4AzMP5cmREghsfa9z6BVs2eVLdPy0zdzNudIdANplD2H
 fBdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=5kjvsRUNU2Dz+ws4ZNGIJe5ZpWOoTEPgqocMmaH98uc=;
 fh=VN98Y0auae+gfOO5vPHq5BCDyz+eiCJJZ2MVhrlBNbY=;
 b=ebvNbydFOpoThviba5Mt3pb44ThahO2z8gAUr04irk4zM/tHBCKiKIoPWiz7psMhJv
 xM0zxW9kNR0yQKW3fanNy43H0WH62k+rK72XTiSbFsAUlk2QCoCZzwz6m6RyR0HxP/+k
 jxV0eaGajTnBgkm/zV0OKxfUcXIQC3r5kdHzrTooyHLNUGx2XiOwgNWn4q/ns6hvbASR
 UtOzodrdJksD1Bc5gLckBqaLW4LJUJ8k/M/JVl2UZrQJ3ncu8AHzRBRkD1TpxFc089Fv
 3Ry54xzwCRTjcOZETi9r3A4o3OuLIzOmUaiq5DeyHgH4GswRuKAxc2fVPxrCUzo16MSv
 Ux4A==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793435669; x=1794040469;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=5kjvsRUNU2Dz+ws4ZNGIJe5ZpWOoTEPgqocMmaH98uc=;
 b=iS48BNrwfrLdeWlpalKar8R7mClhxUyyfTtmag2iKTAkH5iWWCDDB0AercDEPWwm+9
 +wOjQK3udbb97dskzF8FopyCPFW/5TwLdV2QFsuNqabDnVXIURa5/JzfiLNjHYSkVtam
 2CSsQAi5aGtewXPIMniFo8v65yuk7zl+kEs9w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793435669; x=1794040469;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=5kjvsRUNU2Dz+ws4ZNGIJe5ZpWOoTEPgqocMmaH98uc=;
 b=RDYdBopAGlHHq64RJDcbIW8yrBBFqZ7M1zMM24JFWMOSNDikOBV4CSgC+hG7fPwKzl
 iN8nCsHgll7yvwcymMWgm7zXr1FvGoEwRormDKcTqj8+4mtGlqWVHFGt01YQ4PyKV1fE
 3Zo+TjjqIsW7ju6upVkmzb1x7c9bFwt9w7HCIarIpR15JxSxYEnQumi2CkV6hAGGGDVe
 cJ87d3XOdKCW6vgRKH5ZP7FDqBSzLeI9V/pOCOZFInYsjv60yv6tUuyfeh8/pEETCDY7
 siAa7YkqeT27pAtaqxpnW7F2QeBkGwzBWENTOFZU36b3dGaN+4qljs7x7Vf0cCr9o/uH
 5ZSA==
X-Gm-Message-State: AFq9FYKkotdesQqp0MVyvLfJV8PY0ieI1dXDt4k8zcyg+C8qZLo4wvX3
 vY4QIkXcyVTwRoNsAgot42fID5nXD65apkIq8qtIWgoiFf6gggxMMS7zEzXdvEetqNvj1ss435x
 sao+C1zjR0LvWOpYz813Sdw21U6iWMHkbcLJS23oU
X-Gm-Gg: AYBFou32RiYxMFXRf21F5TS5mD/BQ4N/jRUcqvh7zqwpZ6lGhFfVEx9mjEBhrs6u5Q/
 r4T4Da/HuAxVXlB+5tLVBpkw0MFlsUdkvI8YUZ55LXlJQdU2u632ipzFZNsQMNUOIkilIQjZWzq
 e+NNiIbGaqJm0LeFlaEvrgTnJAScSy0oVMyqoYlF9ldiiA6cgM5uQt37DScsoZ4S1UpMq5IELOr
 RzPmK/+BRrWdeC+/OdYuMB5NWbaRyHOBWVo4hq/E6UuMbX6eHoGKdCdFpLCKEvflpZyRbC2+TXt
 dfJPqpIOmt3kigF2T2FT8HIZauoVrrM8eDFTmj3bNGtWWjraxnJ5CQ6tzFWQdUkmsej3BWlSArR
 5ZV81XhKBfFLAQcpkLuaGsDqVsVaTnSaoIT2HUU6f7jhVj7+Y3Mb9XsZZe9Lha+LY3ztKWUc=
X-Received: by 2002:a17:90b:2d8b:b0:3ab:c80:9370 with SMTP id
 98e67ed59e1d1-3ae89724ae3mr3333337a91.20.1793435668652; Sat, 31 Oct 2026
 01:34:28 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 01:34:23 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 02:34:31 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261030143843.467968-4-felix.moessbauer@siemens.com>
References: <20261030143843.467968-1-felix.moessbauer@siemens.com>
 <20261030143843.467968-4-felix.moessbauer@siemens.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 31 Oct 2026 01:34:23 -0700
X-Gm-Features: AclHuK9vdDdLXpUfh-Ao3CaX3jX2EzN9X6x3thI-6_CqT63LQuZXUjpA8viFz_U
Message-ID: <CAFLszTiCk5f3DynyUC=iAV5Nf2DApFYeX26gWcfrJy5O0g33vA@mail.gmail.com>
Subject: Re: [PATCH 3/3] doc: uefi: describe EFI_TIMESTAMP_PROTOCOL
To: felix.moessbauer@siemens.com
Cc: u-boot@lists.u-boot-project.org, xypron.glpk@gmx.de, 
 ilias.apalodimas@linaro.org, jan.kiszka@siemens.com
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-30T14:38:40+11:00, Felix Moessbauer
<felix.moessbauer@siemens.com> wrote:
> doc: uefi: describe EFI_TIMESTAMP_PROTOCOL
>
> Let users know that the protocol exists and how to disable it.
>
> Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
>
>  doc/develop/uefi/uefi.rst | 13 +++++++++++++
>  1 file changed, 13 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
