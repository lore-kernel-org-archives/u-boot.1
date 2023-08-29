Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CA1BC6FA8F
	for <u-boot@archiver.kernel.org>; Tue, 29 Aug 2023 21:05:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E6F883F7F;
	Tue, 29 Aug 2023 23:05:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="iiB+mNUp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 554F686405; Tue, 29 Aug 2023 23:05:25 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7EACE80770
 for <u-boot@lists.denx.de>; Tue, 29 Aug 2023 23:05:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=robh@kernel.org
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 8E9D061031
 for <u-boot@lists.denx.de>; Tue, 29 Aug 2023 21:05:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83ABCC43391
 for <u-boot@lists.denx.de>; Tue, 29 Aug 2023 21:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1693343119;
 bh=JFvftynlWSpx2Z07NIHz5LNL4Jx2zBCJhehgL9bvydA=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=iiB+mNUpSoyWK4nP+SYz4igNO0RzsjxQPmyX06RAeDRf/ArYKrX5rGrH5mrzm6sq2
 LmOAuiLVRFvZ55jbFT+rmpPlJar3fLlKlcG5yvby52X7+P0KEDv3KvhpJHJ43xnXSc
 X/+qkaOv45GbJReT2EG9/f+bCcL9avcrtBwMrtgnnkyp6z5Kl5b0seo67HKtr1jyxt
 paqrWQzvQOjSWmxczmguuAWqlPAm0sV5SM9FUeQTLzBba5kuKJ/sGs8qU+9PNkgdH5
 4vSPqYGsmOB7zc32FcQ4T+oiPFV0/UEPzfKOUDZ2eFlY6BZ8Iwr+divQEgSHZL7gl2
 yeSfFqh7lZ5xw==
Received: by mail-lj1-f180.google.com with SMTP id
 38308e7fff4ca-2b9f0b7af65so72225541fa.1
 for <u-boot@lists.denx.de>; Tue, 29 Aug 2023 14:05:19 -0700 (PDT)
X-Gm-Message-State: AOJu0YxWzzU4Lkt0gQCVzE3+UGjZlMPa9uBtlvBar4lrV0uQbl2cJuMA
 eLyUMsyia3JZUE6YIaGIT4xinQAfyJKKqFpWRA==
X-Google-Smtp-Source: AGHT+IH/2nk4OWk7vLoTXXAxI4zCPN6UHpyrVHeHQbqFQEb5An/vtxt64lCxLTzYyqgWoFhn7ZDJ4hVE8qGkaKVkpe0=
X-Received: by 2002:a2e:a16b:0:b0:2bc:c490:10cf with SMTP id
 u11-20020a2ea16b000000b002bcc49010cfmr395430ljl.18.1693343117338; Tue, 29 Aug
 2023 14:05:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230829191812.135759-1-sjg@chromium.org>
 <20230829191812.135759-2-sjg@chromium.org>
In-Reply-To: <20230829191812.135759-2-sjg@chromium.org>
From: Rob Herring <robh@kernel.org>
Date: Tue, 29 Aug 2023 16:05:04 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKVRoB4W31yuSQxc5hVt2pV6zY9y-scqdoxKLpFpe349Q@mail.gmail.com>
Message-ID: <CAL_JsqKVRoB4W31yuSQxc5hVt2pV6zY9y-scqdoxKLpFpe349Q@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] Bring in other reserved-memory files
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
> Add those files from v6.5 which are already converted to yaml.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> Changes in v4:
> - New patch
>
>  .../schemas/reserved-memory/framebuffer.yaml  |  52 +++++++
>  .../reserved-memory/google,open-dice.yaml     |  46 ++++++
>  .../reserved-memory/memory-region.yaml        |  40 +++++
>  .../nvidia,tegra210-emc-table.yaml            |  31 ++++
>  .../nvidia,tegra264-bpmp-shmem.yaml           |  47 ++++++
>  dtschema/schemas/reserved-memory/phram.yaml   |  47 ++++++
>  .../schemas/reserved-memory/qcom,cmd-db.yaml  |  46 ++++++
>  .../reserved-memory/qcom,rmtfs-mem.yaml       |  55 +++++++
>  dtschema/schemas/reserved-memory/ramoops.yaml | 144 ++++++++++++++++++
>  .../reserved-memory/shared-dma-pool.yaml      |  97 ++++++++++++
>  10 files changed, 605 insertions(+)

I don't think I want all of these in dtschema. Certainly not vendor
specific ones. Generally, if it's not something we'd put in the spec,
then I don't want it in dtschema. The u-boot stuff so far has been an
exception.

Probably a good rule is if it has a compatible, then it doesn't go
into dtschema. Though there's some exceptions already.

>  create mode 100644 dtschema/schemas/reserved-memory/framebuffer.yaml

Maybe

>  create mode 100644 dtschema/schemas/reserved-memory/google,open-dice.yam=
l

No

>  create mode 100644 dtschema/schemas/reserved-memory/memory-region.yaml

Yes

>  create mode 100644 dtschema/schemas/reserved-memory/nvidia,tegra210-emc-=
table.yaml
>  create mode 100644 dtschema/schemas/reserved-memory/nvidia,tegra264-bpmp=
-shmem.yaml

No

>  create mode 100644 dtschema/schemas/reserved-memory/phram.yaml

Depends on mtd.yaml in the kernel, so no.

>  create mode 100644 dtschema/schemas/reserved-memory/qcom,cmd-db.yaml
>  create mode 100644 dtschema/schemas/reserved-memory/qcom,rmtfs-mem.yaml

No.

>  create mode 100644 dtschema/schemas/reserved-memory/ramoops.yaml

Probably not.

>  create mode 100644 dtschema/schemas/reserved-memory/shared-dma-pool.yaml

Maybe.

Rob
