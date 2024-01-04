Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DC54C47073
	for <u-boot@archiver.kernel.org>; Thu,  4 Jan 2024 12:19:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EBFEC87976;
	Thu,  4 Jan 2024 13:19:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nDxI4TNr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA66F87954; Thu,  4 Jan 2024 10:08:15 +0100 (CET)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 289B68795B
 for <u-boot@lists.denx.de>; Thu,  4 Jan 2024 10:08:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m.othacehe@gmail.com
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3368b9bbeb4so253090f8f.2
 for <u-boot@lists.denx.de>; Thu, 04 Jan 2024 01:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704359292; x=1704964092; darn=lists.denx.de;
 h=mime-version:user-agent:message-id:date:references:in-reply-to
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=OZm4xe6O1q8ldLyGW4x/p7Spnpbh1d9SZIxdlC6z3ko=;
 b=nDxI4TNrSNxTQkVqrGwYjWCBssJsvNXjM30+ue7bFxE+4udb2KWZwcu3rOvrLHagMQ
 IE7aF1Zvh/f2FHzcvaRfuVYLJJr/2YTRVoSQIlbrvO770yjqVgGB5/rsFl9ZA6JNwXOf
 7AwdqwMx+D8VcP/Ez+UF/WJ9uf9ir5zPN/fgRe1p2Ob95AY2ptFCCdsHezL64jnPRq3t
 5/cG4j7tjUJNJ4AaOcdiXAxR5xO7M+Y3JEgFWYZs1fSD+U6kxWkLTGzbvBIPt9jfTXKk
 c1vvLJkLj11AMeFPgm6Dy7QVP+7RcxJOc3RjkQcg7yE29ciX0Eh6MvVQgb5RgxLES2Ju
 a7QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704359292; x=1704964092;
 h=mime-version:user-agent:message-id:date:references:in-reply-to
 :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OZm4xe6O1q8ldLyGW4x/p7Spnpbh1d9SZIxdlC6z3ko=;
 b=jAlHQxtOzbNB7d03OoMzsM2WUsXjKcPx1y0G1TUT6McpNd6Wo7ve0waIMB2uwuwwCv
 GNUPqw44I7nzZXd/zK7y5ngD5mpWLXmTJCuaFBaHVuynJDaJWvxUEY4M2ghRbPxen6ew
 uWA6eOhKE0wChoG+aNr6vEw4AwPkvoi4G3kISXLaWwbBwtILNqo8X0AIF0fjYo0Ea4fq
 auYKjAYr4A7spa5vH5lFf094zDeln103tKA9v/iZ+6ySlPb4kabYhkAITXhSLoYTZd/A
 a1/Uz+YyBjjGALyBU16v6DYl62EBgubnalwQ4Eqq4sVuGvD/g+MxallKaI9m13sfQgmx
 9+ag==
X-Gm-Message-State: AOJu0YwEYpljGeYqp4BFhQN42PrEnhUA6qKWtkv60r9XyIjX+HpXTLS+
 PVv15W/PgIDxRO6fEAtApBh8r2rLyWo=
X-Google-Smtp-Source: AGHT+IHiPqT/LMLJd9MKzhlwr3IriyFRPvk/2mfnI2N6uDRvQI/ziT2YnRpCrh3qrVLRMFZzcGZxMA==
X-Received: by 2002:adf:e8c7:0:b0:334:b2da:ef43 with SMTP id
 k7-20020adfe8c7000000b00334b2daef43mr101660wrn.252.1704359291835; 
 Thu, 04 Jan 2024 01:08:11 -0800 (PST)
Received: from meije ([2a01:e0a:ab1:5c70:ddd3:fad7:e5a6:7e01])
 by smtp.gmail.com with ESMTPSA id
 c6-20020adfe706000000b0033342338a24sm32699794wrm.6.2024.01.04.01.08.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jan 2024 01:08:10 -0800 (PST)
From: Mathieu Othacehe <m.othacehe@gmail.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: Peng Fan <peng.fan@nxp.com>,  Tom Rini <trini@konsulko.com>,  Stefano
 Babic <sbabic@denx.de>,  "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH v3 3/3] Add imx93-var-som support
In-Reply-To: <CAOMZO5B-mrLdm1yYMEZq8+Gbn64VNua3fcmB2LfQ6AzOi5B8xg@mail.gmail.com>
 (Fabio Estevam's message of "Wed, 3 Jan 2024 16:31:34 -0300")
References: <20231229111701.10696-1-othacehe@gnu.org>
 <20231229111701.10696-4-othacehe@gnu.org>
 <CAOMZO5B-mrLdm1yYMEZq8+Gbn64VNua3fcmB2LfQ6AzOi5B8xg@mail.gmail.com>
Date: Thu, 04 Jan 2024 10:08:09 +0100
Message-ID: <87a5pl31qe.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Mailman-Approved-At: Thu, 04 Jan 2024 13:19:13 +0100
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


Hello Fabio,

> I applied this patch against U-Boot's next branch.
>
> I had to manually add:

I was testing on 2023.10. I rebased the series on `next` on my side. I
had to do something similar to fb2bdc4efcb in order to fix booting.

> $ git am ~/Downloads/Add-imx93-var-som-support.patch
> Applying: spl: binman: Disable u_boot_any symbols for i.MX93 boards
> Applying: mach-imx: Add i.MX93 binman support.
> Applying: Add imx93-var-som support
> .git/rebase-apply/patch:3025: new blank line at EOF.
> +
> warning: 1 line adds whitespace errors.

Fixed.

>> +#include "imx93-u-boot.dtsi"
>
> This file should be included by default. No need to manually include it.

I am not sure why but without this include, I have the following
warning:

binman: Device tree 'u-boot.dtb' does not have a 'binman' node

which seem to indicate that this include is needed.

> Not needed to be done in this series, but in the future, it would be
> nice to convert this wdog driver to DM.

Noted.

I will send a v4 that should take all remarks into account.

Thanks,

Mathieu
