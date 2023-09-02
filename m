Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E702CA0FF6
	for <u-boot@archiver.kernel.org>; Sat,  2 Sep 2023 00:10:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 952CA86824;
	Sat,  2 Sep 2023 02:09:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="MBQpCyq1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A31EF86703; Sat,  2 Sep 2023 02:09:40 +0200 (CEST)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8823C86741
 for <u-boot@lists.denx.de>; Sat,  2 Sep 2023 02:09:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-500cefc3644so4554149e87.3
 for <u-boot@lists.denx.de>; Fri, 01 Sep 2023 17:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20221208; t=1693613375; x=1694218175; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ivhm+yta0ikWx+7oXCA10CasE+z03E7xKHYz3nclnKA=;
 b=MBQpCyq1gAEdedPKjOhzBYEVX7Bt443ykmFmb8O3DLRONdWzpU3lXJ6M94od/qs1GR
 WAqloCR8eZL7W1e7MApQyMiABaFU1F57JOghkShf3vY/1jpPzIPkmyGu40Q1qFM2Yeuz
 IVbTRHso5oDWsqT1OTHnfw4DUG0S8nGJV0cPCqB3yEBUq8mkIq671T6PACV6bgewwnis
 EJGB8//jo3GMQaSRxzxrRz6oa3U90dVmCPnUipguin4V9KlwcvSWaZTXdIW0yuICsIfZ
 P2m4PvH9NJHXhbFdNu8b/05FnshNe0OnLv7FKkI6kzRfO5Oo3oE4dd2u8FrzdS9fOp+i
 6kpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693613375; x=1694218175;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ivhm+yta0ikWx+7oXCA10CasE+z03E7xKHYz3nclnKA=;
 b=hiHL37lgsQ3iUDwFEpDf27CG9NbPDJGAnINHLRtyoKsIwZGWN+ZPU8k0nTp9UjXNXv
 Bnj+n/ByFG5NOiTWiWNqkaffyRjWyzeC7NYxAL0x/OcEy0wOWjt0JS/kPUD5wQEsV8kF
 jv2Y+HWi2AlzhCli9AkHg4PoBaF48Ih+9s1bfJRauu4NzZ6zkHv787z8bMOpPFKv8Qud
 N8r9MtdF/2lsqyogHlSLDNsBnqRpdEj2J/wevnGMeVldMj5hOy6odypmF9Cdzxb3SbZM
 dz/kD6lIN3WZSFYfxvrKKas+dnhJ3kRJprD2UEugjaYJDWHXtlFU+5/6u/3Ei/ohUSSm
 cOKg==
X-Gm-Message-State: AOJu0YyN+zTQ40M7O3/e3w8EpXWvPIiZvmrv95Yz4StqUrKAXpUYnZOi
 9bBcngGrEZtEV20x2izfXGjodyIJ443bXWPxumGnag==
X-Google-Smtp-Source: AGHT+IGErWCyBR3rlom0F5utqKHY3ExqQmB/qOSK5L61TXzR/eBaVcRLmdM/s+RRD7nyVUhr9WReZN1Ps2TZrncMXeQ=
X-Received: by 2002:a05:6512:3603:b0:4f8:6dfd:faa0 with SMTP id
 f3-20020a056512360300b004f86dfdfaa0mr2339221lfs.2.1693613374547; Fri, 01 Sep
 2023 17:09:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230901142859.1569900-1-paul.barker.ct@bp.renesas.com>
In-Reply-To: <20230901142859.1569900-1-paul.barker.ct@bp.renesas.com>
From: Simon Glass <sjg@google.com>
Date: Fri, 1 Sep 2023 18:09:14 -0600
Message-ID: <CAPnjgZ01dutg5934yaquG7LeFvTComvG1R+mAtWnb=ndJ5zK-g@mail.gmail.com>
Subject: Re: [PATCH] env: Improve ENV_OFFSET help message
To: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: u-boot@lists.denx.de, Joe Hershberger <joe.hershberger@ni.com>
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

On Fri, 1 Sept 2023 at 08:29, Paul Barker <paul.barker.ct@bp.renesas.com> wrote:
>
> When reading Kconfig help messages to understand ENV_OFFSET and
> ENV_OFFSET_REDUND, developers may not realise that they need to also
> look at the chosen ENV_IS_IN_* options to see how the offsets will be
> interpreted.
>
> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
> ---
>  env/Kconfig | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
