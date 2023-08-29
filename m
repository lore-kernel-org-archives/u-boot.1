Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0CB5C83F18
	for <u-boot@archiver.kernel.org>; Tue, 29 Aug 2023 21:38:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3395864D8;
	Tue, 29 Aug 2023 23:38:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="uunGSJNm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AEC8184788; Tue, 29 Aug 2023 23:38:10 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6BF1864D8
 for <u-boot@lists.denx.de>; Tue, 29 Aug 2023 23:38:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=robh@kernel.org
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id A30CF62A57
 for <u-boot@lists.denx.de>; Tue, 29 Aug 2023 21:38:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F28BC43395
 for <u-boot@lists.denx.de>; Tue, 29 Aug 2023 21:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1693345085;
 bh=bZfz2phEmCJxQGXRumw4s2nqkXSdSl33NAnzl+eZ1ZM=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=uunGSJNm89QwVxNPQ6Nh11wphe9DhPiyeyiv2cR8dMNLwcXpkLNxtkC8QvEDuhwxZ
 mj7XpDRKCmv6dGxSaA5X3N/oNWrOoX/WnaBGPHb9MSg5a8828ET/BsRp0xVn3AXjkD
 cfAlPpUjJbsIbYpsKPQT2SB/V2LaX4Aj0m2499a73pBT4fNCx1eYNn//gzBSqM2lA8
 nrpspBmqvywVC4yQYFHlRVI7nNnpMSRF5GZ9OQfYjbkfzqirxo03PX1ZBOJOCwWMsn
 Ko8r6qggJOXfnivZ8BY9aIpIh/rNblv2Qtpet/Cjk1t5Od47D7JHO9ywEmFLEHX919
 NOapeEiLrFf7Q==
Received: by mail-lj1-f172.google.com with SMTP id
 38308e7fff4ca-2bcc14ea414so75053571fa.0
 for <u-boot@lists.denx.de>; Tue, 29 Aug 2023 14:38:05 -0700 (PDT)
X-Gm-Message-State: AOJu0YzC0MZ82IAShP7quhYLUs2MFMN6DxpKibj+uJr2DAk0zRZEUrd9
 n+tvEvlf46JZpErWl0awIPljdRPMjdBJNv1f5g==
X-Google-Smtp-Source: AGHT+IHB0NW0jBHCyCbqErE9944KT8lOUEIQ7JDot6AAVoaFIgShclAt6U2wVpOQkDXO6T6Sc6veW9YeqGOgOMUtRdw=
X-Received: by 2002:a2e:6e10:0:b0:2bc:fc2e:766f with SMTP id
 j16-20020a2e6e10000000b002bcfc2e766fmr323885ljc.37.1693345083531; Tue, 29 Aug
 2023 14:38:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230829191812.135759-1-sjg@chromium.org>
 <20230829191812.135759-4-sjg@chromium.org>
In-Reply-To: <20230829191812.135759-4-sjg@chromium.org>
From: Rob Herring <robh@kernel.org>
Date: Tue, 29 Aug 2023 16:37:51 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLFX9PpMcJBv2yZXRpQyQ-h1DrGyApE0+AAYN2LCCj7Kg@mail.gmail.com>
Message-ID: <CAL_JsqLFX9PpMcJBv2yZXRpQyQ-h1DrGyApE0+AAYN2LCCj7Kg@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] memory: Add ECC property
To: Simon Glass <sjg@chromium.org>
Cc: devicetree@vger.kernel.org, Dhaval Sharma <dhaval@rivosinc.com>, 
 Mark Rutland <mark.rutland@arm.com>, Gua Guo <gua.guo@intel.com>,
 Tom Rini <trini@konsulko.com>, 
 U-Boot Mailing List <u-boot@lists.denx.de>, ron minnich <rminnich@gmail.com>, 
 Ard Biesheuvel <ardb@kernel.org>, Lean Sheng Tan <sheng.tan@9elements.com>, 
 Maximilian Brune <maximilian.brune@9elements.com>,
 Chiu Chasel <chasel.chiu@intel.com>, 
 lkml <linux-kernel@vger.kernel.org>, Yunhui Cui <cuiyunhui@bytedance.com>, 
 linux-acpi@vger.kernel.org, Guo Dong <guo.dong@intel.com>
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

On Tue, Aug 29, 2023 at 2:18=E2=80=AFPM Simon Glass <sjg@chromium.org> wrot=
e:
>
> Some memories provides ECC correction. For software which wants to check
> memory, it is helpful to see which regions provide this feature.
>
> Add this as a property of the /memory nodes, since it presumably follows
> the hardware-level memory system.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> (no changes since v3)
>
> Changes in v3:
> - Add new patch to update the /memory nodes
>
>  dtschema/schemas/memory.yaml | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/dtschema/schemas/memory.yaml b/dtschema/schemas/memory.yaml
> index 1d74410..981af04 100644
> --- a/dtschema/schemas/memory.yaml
> +++ b/dtschema/schemas/memory.yaml
> @@ -34,7 +34,14 @@ patternProperties:
>          description:
>            For the purpose of identification, each NUMA node is associate=
d with
>            a unique token known as a node id.
> -
> +      attr:

Kind of vague.

> +        $ref: /schemas/types.yaml#/definitions/string-array
> +        description: |
> +          Attributes possessed by this memory region:
> +
> +            "single-bit-ecc" - supports single-bit ECC
> +            "multi-bit-ecc" - supports multiple-bit ECC

"supports" means corrects or reports? Most h/w supports both, but only
reports multi-bit errors.

> +            "no-ecc" - non-ECC memory

Don't define values in free form text.

This form is difficult to validate especially when non-ECC related
attr's are added to the mix as we can't really define which
combinations are valid. For example how do we prevent:

attr =3D "single-bit-ecc", "multi-bit-ecc";

Or maybe that's valid? If so, how would we express that?

Why do we need "no-ecc"? Is that the same as no "attr" property?

I think it's better if we have 'ecc-type' or something? Or generally,
a property per class/type of attribute.

Rob
