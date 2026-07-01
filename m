Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7E39C43458
	for <u-boot@archiver.kernel.org>; Wed,  1 Jul 2026 12:07:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3651684867;
	Wed,  1 Jul 2026 14:07:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mqnoR6f0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE33684BC5; Wed,  1 Jul 2026 14:07:40 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91F60841F2
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 14:07:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-698823a9881so621723a12.2
 for <u-boot@lists.denx.de>; Wed, 01 Jul 2026 05:07:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782907658; cv=none;
 d=google.com; s=arc-20260327;
 b=GYm4plp3nLELuIDBlHKD9VwYqsgEMgXT4ASeOoBZPZ9UOXeuzQetAZMkuLKkxqssRp
 3kPOOa+d/nRVyVmSfZ2cO1NKkJFvAwem85NpZf5vORQks9I7bFSRZ9X8oxoLh7xCGc6/
 PIB/PukV3tRatvEwVbGc/qIM3ySLw7i+4fIC9M017a30+Vr5Meb9EUpWtcglXkUbnu73
 G+y3eAirb/ig25dGSsM22QMQoPJItoXvhGXeE4TvbmpN14qUvYyFtzuEp4ShLrjeBQL9
 QlJjuSOYOsV15ZAfeboM7PuJRviybrJQI95AnJfloYaAHSEhh8X/+AFveLd/JppMaZRR
 dwig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=U2itC+jbovZewhS3cMXEdswTO6lL3i9B0J0TXGmTsDs=;
 fh=zinS25VRE/Gw3ysJDNix/TPq0b+jh8vhEgV/+pLUoYg=;
 b=Jm9aGewM6Ah0gbKKMB48dCcz6RMvcE1WSfErW7yac+JlNo4b94OHVOZrqYsQ/37ZZx
 O+rDONbo/+IlhX3Nw4sCg8EOwFnbj5a2E2vOJlLHV/BeC9Z3elhJaVz4FA0lHwjQ4OVU
 SwgYWFlHKxauMYWy2lCauJBYMUBC/gMJZjF1RTRMxT/mlVzFlpMUZCY39H9/s8vbnpOl
 A+rRZE+WLtaLjOj17kDRohuB1TrikvHOApNKxKXNb/MIcAWsx9LY/KDMztTEFXOH3wuF
 r1+CcAl3Nc0Yx+LD5i5UXE6q/aHopkXwEFQnsSLDL3P7xotnzBquaKOEqcSvYVzW3btp
 aShw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782907658; x=1783512458; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=U2itC+jbovZewhS3cMXEdswTO6lL3i9B0J0TXGmTsDs=;
 b=mqnoR6f0yItvjK390bmTQAUhuBIYOQZ6AQ18HRVt+JPPisax//HqveeJeJjfGonAlG
 cc2RzX5PXs+KLar2W2HsDO5g52HZowsI+DErKji0Dzo/37ekuFrHV6Jj8l3l88QxVYXY
 x5inw2LEaVRn1MV4SfR8R8UvRFyWo9vlPKiX0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782907658; x=1783512458;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U2itC+jbovZewhS3cMXEdswTO6lL3i9B0J0TXGmTsDs=;
 b=mZC/FeL0uQcQJ6hDSXoliyGQlVxyqkfoVX7eR59ePWD7TbrgDGwWyh9L+4HQ2gHZ6K
 +2nIW54lfCcoSlVJApCnrCiP61CWoEpTr3qSd9ZKJLvZvjRbKYQxjlErcsOuDDr8cZJp
 QOLY6iNP108fX4u2MJ9oi+JZEIxyWRY6IwplbBPC8gQ65crG3q1ukAizTRQucKmiXU6x
 4MhAzxnZPGlttSaBz744ewU+yZExNeD6AgbZq/Cv6Stgh8DVBzNISq3FfCCQFya7T5HC
 N4LBKQhIJb8CdHlPoGsrFMLJGrHcKM/LjijeJOdLhIys0WMZk322l2T38jl4QEKdZLaQ
 MxYw==
X-Gm-Message-State: AOJu0Yx67TMvrVE2znE3AMQtmZW2y4J/qW5ekXt/mwPKXXNBOSQ1qoFe
 qToYiw65VoU5gdmcZ8EKPoDQsS4SbwJvTmniTB+ZIz9xPhS8KbFANA7W2Nef8QK9yJmGulY25yS
 Zad7Dv4cGm8K5KgEOgDgiDYudujQ5/64KzbM1GSoy
X-Gm-Gg: AfdE7cmGHamuzkil0orDLqRM3qJe2fIrUB47eQXnORZtSt+yq/C5sO7dDScQOZgnWk2
 S1nZkHbz08h50s19iQqclmndfoLu766XPsmAazNcrnVes4cgEyH8rcromK3GZ/rE4ckh6rq5SFh
 DInRN8c8KhWeYHm8y9g/eCLMvR5rQaxS5nF9NkZZEvlfLEoSK1xOvLsldBDcALT0nrVJn6Tnz34
 5CjzdsKlVojV9hkSrkwv+kLJZkgaUi1whMXw/Tf1SorVMjdcJySLAfbjH50ChEymKRfSUfDZg==
X-Received: by 2002:a05:6402:380a:b0:696:8f45:4ae7 with SMTP id
 4fb4d7f45d1cf-6989f319c50mr639604a12.13.1782907657985; Wed, 01 Jul 2026
 05:07:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260629-binman_template_phandle_copy_fix-v1-1-196f95a13388@ti.com>
In-Reply-To: <20260629-binman_template_phandle_copy_fix-v1-1-196f95a13388@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 1 Jul 2026 13:07:26 +0100
X-Gm-Features: AVVi8CdoLKCf-ykyO_cQN3RKGGWjrYmllXDIofx5fG-MdufYiRkjFV8mOCNDaeE
Message-ID: <CAFLszTggZ57jZw2r10COgm42SgPZUpKXoe_1uEzaX48KtGVYig@mail.gmail.com>
Subject: Re: [PATCH] fdt: fix phandles not copying when using templates
To: Anshul Dalal <anshuld@ti.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
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

Hi Anshul,

On Mon, 29 Jun 2026 at 11:49, Anshul Dalal <anshuld@ti.com> wrote:
>
> The phandles used inside a template were not being copied to the node
> inserting the template, leading to a missing phandle error.
>
> The following example can be used to reproduce the issue:
>
> &binman {
>   some_template: template-0 {
>     ti-secure-rom {
>       content = <&some_data>;
>       keyfile = "some_key";
>     };
>     some_data: blob-ext {
>       optional;
>     };
>   };
>   output-bin {
>     insert-template = <&some_template>;
>   };
> };
>
> With the error 'binman: Node '/binman/output-bin/ti-secure-rom': Cannot
> find node for phandle 103' observed.
>
> Signed-off-by: Anshul Dalal <anshuld@ti.com>
> ---
>  tools/dtoc/fdt.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/dtoc/fdt.py b/tools/dtoc/fdt.py
> index 991a36b98796..6c3449095194 100644
> --- a/tools/dtoc/fdt.py
> +++ b/tools/dtoc/fdt.py
> @@ -780,7 +780,7 @@ class Node:
>              parent = self.GetFdt().LookupPhandle(phandle)
>              tout.debug(f'adding template {parent.path} to node {self.path}')
>              for node in parent.subnodes.__reversed__():
> -                dst = self.copy_node(node)
> +                dst = self.copy_node(node, True)

I believe this is the one you pinged about on irc?

Please can you add a test for this new behaviour.

>
>              tout.debug(f'merge props from {parent.path} to {self.path}')
>              self.merge_props(parent, False)
>
> ---
> base-commit: 63f6cc8ba618396cb9c0161bb5c6d217604ae1d0
> change-id: 20260629-binman_template_phandle_copy_fix-956bc3ce48d6
>
> Best regards,
> --
> Anshul Dalal <anshuld@ti.com>
>

Regards,
Simon
