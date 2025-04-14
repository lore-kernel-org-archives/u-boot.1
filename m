Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87B2CC369B2
	for <u-boot@archiver.kernel.org>; Mon, 14 Apr 2025 23:45:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B7F2F820B7;
	Tue, 15 Apr 2025 01:45:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=jms.id.au header.i=@jms.id.au header.b="EBMLy/oP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75C838214F; Tue, 15 Apr 2025 01:45:11 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DEF838209C
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 01:45:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=joel.stan@gmail.com
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-ac7bd86f637so1172165166b.1
 for <u-boot@lists.denx.de>; Mon, 14 Apr 2025 16:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=jms.id.au; s=google; t=1744674307; x=1745279107; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gCW7kwyzwgVa/R2oS/ngREu57yHyxsdC/caaDeH6o8g=;
 b=EBMLy/oPoszZ7RKtNo9E+8o3kiHQxZ4Rh1pCffnOrmPYo/+t8IL8UInDPKYvql3fo8
 23QPrMEMUVE3PGpbGDCFrCRTL2jU8KMaaqVEbGzqrFfFrfZsNzpj+Xc2F1Wi9r4QN6Lx
 RR31LKUqpAa4P/9w9+WK7Z7i2awU/ugOduPlQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744674307; x=1745279107;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gCW7kwyzwgVa/R2oS/ngREu57yHyxsdC/caaDeH6o8g=;
 b=MtgyzEz724n09GoND2lB/BeXZ+6nKlafXe0Em5VDk6Y9Hee30Y0Da8+IXKp5/ReGYI
 D3sHyDtMc21r2aVksf96kSgtHD0xCdiE2qu7lGrNI9rhfVoDUaok5fPNDMOVRl0AF4P1
 kjNBqTxYRB3YbCvBpUfPvnOAo7n3tP8hewbgsJSR6ngWciddsW1bixM9uYP6lN9ZKmNS
 8SNZqYhct1YKE754ujwT34LO7Pobbv/6K5hKrIljLw/bzaHqSD3RG+p2ZRQhc6ttgyfV
 BVt25WiMRexYtJC/uXxpuQMRXGkqHes63/CB9cCs3maEWrhwyJehtqqCS945kVHs7oQO
 k+yg==
X-Gm-Message-State: AOJu0YyzGNjDtzxHVaRD5iw8J26lJGvnmnGw3M/qiGW/gfw2t9gkQlOU
 2HIWcCQ2NhpAHxSqcRYMZEbD/RUOf0yifcCozwx7E8HHNz4OGe7j3plEYvHD0jAcegPtRCrM9AB
 2JRQq+UrmDejNxM0NTuEBX1hdBl8=
X-Gm-Gg: ASbGncsFaqDcwZVcQSMiCiVU35BUOUV+L4nMCDO0r5D9LOgnJsyh0ze47aIOAEJTSo6
 9PXOpimUD/gK9PQ8TMs/m/uZJa69/MSWP7SRPLO8vfxZc+dp4hwM5Qm/MRDk3jiy+L9cyrosDFu
 08T8R2y1J9+Whxlkf7w/I4Qg==
X-Google-Smtp-Source: AGHT+IGzWfJN0DCatKu1jHICRla6mrVZ4cnoJ/QQItlBmqKTdmf87LcYQRaoOJwPyo2monmlWX+FqwfWPvhVm5Wfaqc=
X-Received: by 2002:a17:907:3d0a:b0:ac1:dde7:b57f with SMTP id
 a640c23a62f3a-acb1688aaf6mr100994266b.23.1744674306711; Mon, 14 Apr 2025
 16:45:06 -0700 (PDT)
MIME-Version: 1.0
References: <20250414220439.529572-1-trini@konsulko.com>
In-Reply-To: <20250414220439.529572-1-trini@konsulko.com>
From: Joel Stanley <joel@jms.id.au>
Date: Tue, 15 Apr 2025 09:14:54 +0930
X-Gm-Features: ATxdqUGOYE5xQBgm6evJtHh49dCvsEYCexMekZlXTrHD3NwVQhZgDdTXCA3ckBA
Message-ID: <CACPK8XcXJS0X4kRWxncCjnbR1ADBprGXFsvgB63Bb7b81rHfnw@mail.gmail.com>
Subject: Re: [PATCH] Revert "CI: Disable evb-ast2600"
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Ryan Chen <ryan_chen@aspeedtech.com>, 
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
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

On Tue, 15 Apr 2025 at 07:34, Tom Rini <trini@konsulko.com> wrote:
>
> Upstream developers have been unable to replicate this failure exactly.
> Furthermore, with commit 8c98b57d72d5 ('Merge patch series "Static
> initcalls"') we have now replaced the part of the U-Boot code which the
> platform was hanging in when I was debugging. Moving forward, if we have
> a failure again the next steps are to upgrade QEMU (which should be done
> regardless).
>
> This reverts commit 8a2cf6307a2ccc09c39dde486b6d9375b78c82c2.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>

Thanks Tom! Sorry we couldn't help with the failure.

Acked-by: Joel Stanley <joel@jms.id.au>

> ---
> Cc: Ryan Chen <ryan_chen@aspeedtech.com>
> Cc: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
> Cc: Aspeed BMC SW team <BMC-SW@aspeedtech.com>
> Cc: Joel Stanley <joel@jms.id.au>
> ---
>  .azure-pipelines.yml | 4 ++++
>  .gitlab-ci.yml       | 7 +++++++
>  2 files changed, 11 insertions(+)
>
> diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
> index cb787d32f142..24b6661c9c94 100644
> --- a/.azure-pipelines.yml
> +++ b/.azure-pipelines.yml
> @@ -424,6 +424,10 @@ stages:
>            TEST_PY_BD: "evb-ast2500"
>            TEST_PY_ID: "--id qemu"
>            TEST_PY_TEST_SPEC: "not sleep"
> +        evb_ast2600:
> +          TEST_PY_BD: "evb-ast2600"
> +          TEST_PY_ID: "--id qemu"
> +          TEST_PY_TEST_SPEC: "not sleep"
>          vexpress_ca9x4:
>            TEST_PY_BD: "vexpress_ca9x4"
>            TEST_PY_ID: "--id qemu"
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index 5f3418e482fe..aa15e009b39e 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -331,6 +331,13 @@ evb-ast2500 test.py:
>      TEST_PY_ID: "--id qemu"
>    <<: *buildman_and_testpy_dfn
>
> +evb-ast2600 test.py:
> +  variables:
> +    TEST_PY_BD: "evb-ast2600"
> +    TEST_PY_TEST_SPEC: "not sleep"
> +    TEST_PY_ID: "--id qemu"
> +  <<: *buildman_and_testpy_dfn
> +
>  sandbox_flattree test.py:
>    tags:
>      - ${DEFAULT_AMD64_TAG}
> --
> 2.43.0
>
