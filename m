Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B82C2EB597E
	for <u-boot@archiver.kernel.org>; Wed, 11 Feb 2026 09:05:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3DACB8367F;
	Wed, 11 Feb 2026 10:04:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="t7OUVhxo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5FCE83D9C; Wed, 11 Feb 2026 10:04:57 +0100 (CET)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B1A5831AC
 for <u-boot@lists.denx.de>; Wed, 11 Feb 2026 10:04:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-79639c2ceb6so35699387b3.1
 for <u-boot@lists.denx.de>; Wed, 11 Feb 2026 01:04:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770800693; cv=none;
 d=google.com; s=arc-20240605;
 b=DkEXdFGZ4TJr5ScCMa+eqc04uJlZmRQUb1eDgJGrLefdFBFw22XTYQ1CUM08MM9S6d
 ipytYcsUBSN/jg/xXnxg9k4Th0+C7DXArkO1PbLOOf2f9BmYbx49s4CTgP4xUaqbRSKq
 KQAZ9wJAdhkWGiVg86sybkQAl1WRFYfe6geO5e8vO5Me/fMKTG7pboUW7dZWiv6arHVb
 ghwyLhrS7eqwb4/cyCTJ0YMDAiFi5I15CIFMyaoZ5awxjHu2KkmX9IMorSTJkrogBOb+
 9wYZp9XQTx9kKTOUwjjeiQXhHuTHkLQIDCeRZul5fKhTzzEHQgkwcsI+HMsJFptPZ3Gt
 6pvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=U3j+u75DhLiplBiQcbGBN8DytRauKiZVC1xQhE9/fCw=;
 fh=v/hd5MoD/y/RXVl0l3/7iQ5vQl/uk63sbZqcPeiS7/E=;
 b=A4pZuvHbqxvaIcaoGYqcHCayknQ48TwHMBCr0K6ZSisYsezs0CIVR1CmnvQY1EWajS
 7QMgx2lHI3NebNHQ+91iENDJhInlYKHqjnWQHNGhc2Rtn6uJXEFpGkS8wEmJcW8nZqP+
 B5ssxyoVbHK2E76XO7Nm/wz5YHuIqElkF6ZOdFokMChclYjc8f5GfOBmtLhH8OmR4ovp
 fqAvZuncukU4Vqdt9Yy0EkLMqsnLWEBuoHDOnjbzzQ6ds/7T+rDXDEGZnRwwTCCApq26
 xe+NXfXIpdzMB0j8669ZzuZYr5sLS/TseMVUViH+Zbk+5/2PDV3SvZdU7IA8xDo6aBEP
 KPJA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770800693; x=1771405493; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U3j+u75DhLiplBiQcbGBN8DytRauKiZVC1xQhE9/fCw=;
 b=t7OUVhxoUXUgQR6dRG6/odMCu/pMzazXKj9zYQiCk69PQq/ySWgvPWq1ptUAUvX7QL
 UOnCTtK/s+WM7y/FnyOi9N6tF4v1HeMVwxCwOEr0Rr0iIHW43NQ14fq1CNpnPQYBGppQ
 XGMRIa7fQ2uMocHVUIkymByrvhW8tmk3bXaH7FBP8+wzfLg3orPBWeZyHYV7zsSlZa5j
 627I2v9UNk1gBppiA8Iytk2FNNn0aVyjCKDFr+L6XOEd9hk6d1csvNrKOliSUTWfMAnj
 EynWEIVDFTxGm7xDLixuCBA6sD4LEP+Zxn6ZZOV5QnK0lJxg46rKCqU3jK8Rnazp0eBm
 97ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770800693; x=1771405493;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=U3j+u75DhLiplBiQcbGBN8DytRauKiZVC1xQhE9/fCw=;
 b=A/f8hXMoX3Te06rAaGLJ4Owg/Ddjlj2VgRpBFVxNeaFT6UOntU77/6pY0ljh9JeoaO
 BTEvF9xC34y11CFbgK7ocfTSJUBld7Nn8SdDCb7VVdBUP0vxjtUZVh1ECHXwPL/eL/Bl
 vLSggtlra1RdJmxDy7ogiOtV5p88Ce63VQqaAjkq5iBzYUhyAhp2m1LbAfBVPBn8VOvI
 +Gwh734fReoiaXEusUwFv3oecu8fiJWmFKZKlNxIgSKV9ZEmAwBj1J38axQ6RUj4MkFq
 4MND4c1xc19Ad/sM/L3zMJsKaa9xwZoiuAWrz6xHdqWbN9asVH1o6/9Xv0pW4/AunBIu
 7zYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWO9DfBplUHJX0sy2s28PUPllYAqUaQLRYR1NfVdYejmuiQFo/M1Jbd04uhTdPUWOYTeSVJIg0=@lists.denx.de
X-Gm-Message-State: AOJu0Yw4Egrr99Ui9ZWZF0KeI9OxOPbg32QYR/CN1rVUjuJLhCLf4c+J
 Bzeswbygu+6CxoEq/am05Szst7NhqscpGAesLvLBxmdqEVBdL4jB8V7zR7yV8+BC30XqsofLKV+
 BzLpN9wJv8ZSiHUAACx1k5zoGNoCzm+/CY2a4QDmUNg==
X-Gm-Gg: AZuq6aJhn9J3+RtQ9ENYE8VfKwaSiLQ0s1LEBO/wtjNd4kLKLOs4ij7ERc9nKK/yoZ+
 jguh2H0wagO09RbXpgMpHawqSBgO4K+0iuW3kX8c25L97OV7/EJdxwhTskW+sHIvNXYeQcMcV6P
 dzf+wgI1XrNSrXk2Rmwp2qTTthQFxd8PAfk9YJMl6U+M2LKlW7iX7hJB+bCs5SFC2oyQtTJ5I3q
 7tluU5YrAwuvsGFeQ165v/TOtVMbhIJ0oTABEBkfrGBjWtUNi2WMSvxBjviQwD4ZG/0BTeq20w/
 G9IAsyp+1wgFbtqYHNB/U9w3sxiWwVWz1VocK4T+P1lk/H7GhqPYlMMrYoNqbRbG8Y0YodDK3n8
 aL2L4BLjXOJ77Xs53Zm9f0Sb/f1qgm9IFRVtpiT91df5MROma662FYIZdgXZJyqAfKvkIR64eBB
 A07VjbANrmWK4qet/N8cn/2sQtJwEzCGSRwn7T4gSTZeSzAjhtywvf6Gk4OG8yrHF3I4YozSDgC
 Z21wBsXlOiARq2cgcySUm28oj54rUBr1GerwppjOnilpQu71soakX9RiqApB9rnCKwEj4FcOIfj
 iraaB342vvKSe0yO3Y4mR5UGFeUvTwhw7BfiFFWN1iT6
X-Received: by 2002:a05:690c:e3cf:b0:794:795d:471d with SMTP id
 00721157ae682-7966a9ccb3dmr14781787b3.30.1770800693181; Wed, 11 Feb 2026
 01:04:53 -0800 (PST)
MIME-Version: 1.0
References: <20260114095654.736511-1-kory.maincent@bootlin.com>
 <20260114144918.GC3416603@bill-the-cat>
 <20260206151945.4448af9d@kmaincent-XPS-13-7390>
In-Reply-To: <20260206151945.4448af9d@kmaincent-XPS-13-7390>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 11 Feb 2026 11:04:17 +0200
X-Gm-Features: AZwV_Qh4jhDOmOp6puKOmsR7TX1NNowmaG0QWqa5lXOeoom0qrbeO4jjxxdBesQ
Message-ID: <CAC_iWj+XZ46w859tFJc4FSEX-AOUGgmbwe=1dyU8-bPG7+R3+g@mail.gmail.com>
Subject: Re: [PATCH] fwu-mdata: Allow multiple metadata storage drivers to be
 enabled
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 thomas.petazzoni@bootlin.com, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Sughosh Ganu <sughosh.ganu@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Kory

On Fri, 6 Feb 2026 at 16:19, Kory Maincent <kory.maincent@bootlin.com> wrot=
e:
>
> On Wed, 14 Jan 2026 08:49:18 -0600
> Tom Rini <trini@konsulko.com> wrote:
>
> > On Wed, Jan 14, 2026 at 10:56:53AM +0100, Kory Maincent wrote:
> >
> > > Change the Kconfig from a "choice" to a conditional block, allowing
> > > multiple FWU metadata storage drivers to be selected simultaneously
> > > instead of being mutually exclusive.
> > >
> > > This enables systems with FWU metadata on different storage types
> > > (e.g., both GPT-partitioned block devices and MTD devices) to have
> > > both drivers compiled in. The board can then select the appropriate
> > > driver at runtime based on the devicetree description.
> > >
> > > The change converts FWU_MDATA to a menuconfig and replaces the
> > > "choice/endchoice" block with "if FWU_MDATA/endif", making
> > > FWU_MDATA_GPT_BLK default to 'y' for backward compatibility.
> > >
> > > Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> >
> > Reviewed-by: Tom Rini <trini@konsulko.com>
>
> Hello,
>
> Any news on this patch? Does something prevent it to be merged?

I cc'ed Sughosh which maintains fwu. I can send a PR if we get an ACK

Thanks
/Ilias
>
> Regards,
> --
> K=C3=B6ry Maincent, Bootlin
> Embedded Linux and kernel engineering
> https://bootlin.com
