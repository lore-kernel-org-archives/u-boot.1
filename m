Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A14BC83F17
	for <u-boot@archiver.kernel.org>; Wed,  6 Sep 2023 14:48:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32D4D865A8;
	Wed,  6 Sep 2023 16:48:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XxX7aA/s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C61058696B; Wed,  6 Sep 2023 16:48:35 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 244C5865A0
 for <u-boot@lists.denx.de>; Wed,  6 Sep 2023 16:48:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-51a52a7d859so2242970a12.0
 for <u-boot@lists.denx.de>; Wed, 06 Sep 2023 07:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694011712; x=1694616512; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VM31Omv2VF1wbkMub+dDYlOZRCfHD1+o+lV3RVrjZoc=;
 b=XxX7aA/sKiZkOzYvOuZlehpCE9vmX0L8HbI56+fsfjPxWAy+pWXg0z8CDIcMla9myr
 8lLH4YC24BuQhCbJKiHR08GmBa+pUfQv3iZBKqzrCwJJ1b06gKbWS7yLrFaSUj5Cnuyp
 zNckrUggtLyQkH771Ii1aWl68s8Ljc0UD7icY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694011712; x=1694616512;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VM31Omv2VF1wbkMub+dDYlOZRCfHD1+o+lV3RVrjZoc=;
 b=WH56nzlzDMwc3X5sZV9/IThbIKd+mC1ziTAabRHnnyLq1qBqawCZdrLow21N7t/p3U
 uX+XYlaJigsrf+dLta5vLSowA6yhzwe+vNaeF/cE6uEaCVSBZ8M14MbfumZK03KmEnCO
 iH6Cogh51kDBLOh51CU4M84FIS6RYCapm0F7K7EvL9dAVJ9YoNaTr7D4NU6iuq18wXhg
 0SPDLWiikMiCTZ66b6G/QaYE+WTmNNOk0MYNbtxsaIiZDzgAaqcwu8u65Qu6+e4snGuS
 sd/k4zyOa81L+QdGfTj2znBh0EaI14AeOiqr9+iyytOFkZos6CidcBcZgoyvu7CnJZox
 MEqg==
X-Gm-Message-State: AOJu0YyMD+lZYU8zmi3RF8FV28xAbT8IIaS9Wv/eiEhsU9qmrahZTrrL
 DljJE5xasywK+2tYDZl6P6ZTQxy5B62C+09suRlfbQ==
X-Google-Smtp-Source: AGHT+IHNMWaasVkgp44pFNPVHkyJontSd/vvGQZX5Wxd2x9pX7I8Zx1MV/UPgxQHR/mIRxbiRhQ5295jv/BnGFJcWSk=
X-Received: by 2002:a17:906:9754:b0:9a5:9b93:d60d with SMTP id
 o20-20020a170906975400b009a59b93d60dmr3084119ejy.36.1694011712458; Wed, 06
 Sep 2023 07:48:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230829191812.135759-1-sjg@chromium.org>
 <20230829191812.135759-4-sjg@chromium.org>
 <CAL_JsqLFX9PpMcJBv2yZXRpQyQ-h1DrGyApE0+AAYN2LCCj7Kg@mail.gmail.com>
 <CAMWxwJ13-itCyyKaH21nncaX2OUesGwpfMNHocvDEKHzZ1_F4Q@mail.gmail.com>
In-Reply-To: <CAMWxwJ13-itCyyKaH21nncaX2OUesGwpfMNHocvDEKHzZ1_F4Q@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 6 Sep 2023 08:48:16 -0600
Message-ID: <CAPnjgZ2NacjTmMB4fUL+ttAmMvn+3oJS8fA+Lu94zgMOt4rKCw@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] memory: Add ECC property
To: Lean Sheng Tan <sheng.tan@9elements.com>
Cc: Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, 
 Dhaval Sharma <dhaval@rivosinc.com>, Mark Rutland <mark.rutland@arm.com>,
 Gua Guo <gua.guo@intel.com>, 
 Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>, 
 ron minnich <rminnich@gmail.com>, Ard Biesheuvel <ardb@kernel.org>, 
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

Hi Sheng,

On Wed, 6 Sept 2023 at 08:47, Lean Sheng Tan <sheng.tan@9elements.com> wrot=
e:
>
> Hi Rob,
> Sorry for missing this:
> regarding your question on whether if the memory can support both single-=
bit and multi-bit ECC, i think the answer is yes.
> @Dong, Guo or @Chiu, Chasel could you help to confirm on this?

I sent a v5 series which breaks these out into separate properties.

Regards,
Simon

>
> Thanks.
>
> Best Regards,
> Lean Sheng Tan
>
>
>
> 9elements GmbH, Kortumstra=C3=9Fe 19-21, 44787 Bochum, Germany
> Email: sheng.tan@9elements.com
> Phone: +49 234 68 94 188
> Mobile: +49 176 76 113842
>
> Registered office: Bochum
> Commercial register: Amtsgericht Bochum, HRB 17519
> Management: Sebastian German, Eray Bazaar
>
> Data protection information according to Art. 13 GDPR
>
>
> On Tue, 29 Aug 2023 at 23:38, Rob Herring <robh@kernel.org> wrote:
>>
>> On Tue, Aug 29, 2023 at 2:18=E2=80=AFPM Simon Glass <sjg@chromium.org> w=
rote:
>> >
>> > Some memories provides ECC correction. For software which wants to che=
ck
>> > memory, it is helpful to see which regions provide this feature.
>> >
>> > Add this as a property of the /memory nodes, since it presumably follo=
ws
>> > the hardware-level memory system.
>> >
>> > Signed-off-by: Simon Glass <sjg@chromium.org>
>> > ---
>> >
>> > (no changes since v3)
>> >
>> > Changes in v3:
>> > - Add new patch to update the /memory nodes
>> >
>> >  dtschema/schemas/memory.yaml | 9 ++++++++-
>> >  1 file changed, 8 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/dtschema/schemas/memory.yaml b/dtschema/schemas/memory.ya=
ml
>> > index 1d74410..981af04 100644
>> > --- a/dtschema/schemas/memory.yaml
>> > +++ b/dtschema/schemas/memory.yaml
>> > @@ -34,7 +34,14 @@ patternProperties:
>> >          description:
>> >            For the purpose of identification, each NUMA node is associ=
ated with
>> >            a unique token known as a node id.
>> > -
>> > +      attr:
>>
>> Kind of vague.
>>
>> > +        $ref: /schemas/types.yaml#/definitions/string-array
>> > +        description: |
>> > +          Attributes possessed by this memory region:
>> > +
>> > +            "single-bit-ecc" - supports single-bit ECC
>> > +            "multi-bit-ecc" - supports multiple-bit ECC
>>
>> "supports" means corrects or reports? Most h/w supports both, but only
>> reports multi-bit errors.
>>
>> > +            "no-ecc" - non-ECC memory
>>
>> Don't define values in free form text.
>>
>> This form is difficult to validate especially when non-ECC related
>> attr's are added to the mix as we can't really define which
>> combinations are valid. For example how do we prevent:
>>
>> attr =3D "single-bit-ecc", "multi-bit-ecc";
>>
>> Or maybe that's valid? If so, how would we express that?
>>
>> Why do we need "no-ecc"? Is that the same as no "attr" property?
>>
>> I think it's better if we have 'ecc-type' or something? Or generally,
>> a property per class/type of attribute.
>>
>> Rob
