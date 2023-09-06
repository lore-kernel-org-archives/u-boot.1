Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAC3DEE14B0
	for <u-boot@archiver.kernel.org>; Wed,  6 Sep 2023 16:45:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DF2D86407;
	Wed,  6 Sep 2023 18:45:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="Zba77lLN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BAA0866DA; Wed,  6 Sep 2023 16:47:04 +0200 (CEST)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6224C865A0
 for <u-boot@lists.denx.de>; Wed,  6 Sep 2023 16:47:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sheng.tan@9elements.com
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-500a8b2b73eso5877685e87.0
 for <u-boot@lists.denx.de>; Wed, 06 Sep 2023 07:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1694011620; x=1694616420; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kJDaEC3Wlgjr3oWTC8L8kZMB7winxAI5Z3RfzH8a3Xs=;
 b=Zba77lLNdzl5T9Bl7hzyip2+jZLLLt/egUFpCBaLXOp34U+a3DxCrZLE1sldSoBU+C
 gaPzTEg5dgVVD9dTyrLwn5ldCSVC3Linwahl7JuHa0LbQC6L1zaG3fRuvBMFp9Xq+svy
 R24Vl4jrBrFfCjfBNMFLw//jDZCf31PvrdkVamrbdpZQXrUjPYElord1t5G6X/Twq6Pd
 lKtSTMT0Bat0/ay3MCqGOpWyES5IiVjDIREo7uUZHevLiaAZNRQzJ4ilH2Yhk5ZLBjcI
 6O4Aks6wtYii75R/RpnXgPEGRPBKik3cxZXzcfdhW8mt8xdI+7ZRaMMsI2DoUvGf3213
 CwuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694011620; x=1694616420;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kJDaEC3Wlgjr3oWTC8L8kZMB7winxAI5Z3RfzH8a3Xs=;
 b=PjZcvSddKJLKBhw96auymPIOeZNNFurnBons8QVrBX7aSmPSJkIZZEKlQ2K/a2Xelx
 o8JuAVSi2Rm4t+dJBLdufNcHluSIj9iQfXSQMRfLi6YRvjdSoP6S18UB02lTYunzZZva
 nrIokJhVOe6dJ9BFXdTpsGLJIgkBnAl06iLNrJsGUvSBGB8mXA98tw+o3aZ9J9PD7ILg
 b7zHc8W3tK5/pEm+cw3jjh4+3QiANTcxQPHGt98mpo4znmJH7dOSEbmCnse1t/N3BhX2
 w5GoXR5Ofe2FhxGZOmCzhMU4IQC02aUeJ6dkBo3Gp6sfcCKvALkJ633BfBf5ncmGM+bj
 Nv5A==
X-Gm-Message-State: AOJu0YxGS19PrTlpEvIq282ZKraA55CT0stsAk8+lsd88KZ9fGUnnW0L
 av+sGozi1rNM1yjwzx0OnxwTHbnAN7jEJ6muOVcS5g==
X-Google-Smtp-Source: AGHT+IFwXyYGspdcXUnamyNxrN3dOiCXcr9c7v5awlGvBAkHfbVcc3GxQ0kzAimsciq+DvKNAowptmQzMUldn1AmwEo=
X-Received: by 2002:ac2:4299:0:b0:500:bd75:77cf with SMTP id
 m25-20020ac24299000000b00500bd7577cfmr2035580lfh.17.1694011619899; Wed, 06
 Sep 2023 07:46:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230829191812.135759-1-sjg@chromium.org>
 <20230829191812.135759-4-sjg@chromium.org>
 <CAL_JsqLFX9PpMcJBv2yZXRpQyQ-h1DrGyApE0+AAYN2LCCj7Kg@mail.gmail.com>
In-Reply-To: <CAL_JsqLFX9PpMcJBv2yZXRpQyQ-h1DrGyApE0+AAYN2LCCj7Kg@mail.gmail.com>
From: Lean Sheng Tan <sheng.tan@9elements.com>
Date: Wed, 6 Sep 2023 16:46:23 +0200
Message-ID: <CAMWxwJ13-itCyyKaH21nncaX2OUesGwpfMNHocvDEKHzZ1_F4Q@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] memory: Add ECC property
To: Rob Herring <robh@kernel.org>
Cc: Simon Glass <sjg@chromium.org>, devicetree@vger.kernel.org, 
 Dhaval Sharma <dhaval@rivosinc.com>, Mark Rutland <mark.rutland@arm.com>,
 Gua Guo <gua.guo@intel.com>, 
 Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>, 
 ron minnich <rminnich@gmail.com>, Ard Biesheuvel <ardb@kernel.org>, 
 Maximilian Brune <maximilian.brune@9elements.com>,
 Chiu Chasel <chasel.chiu@intel.com>, 
 lkml <linux-kernel@vger.kernel.org>, Yunhui Cui <cuiyunhui@bytedance.com>, 
 linux-acpi@vger.kernel.org, Guo Dong <guo.dong@intel.com>
X-Mailman-Approved-At: Wed, 06 Sep 2023 18:45:33 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Rob,
Sorry for missing this:
regarding your question on whether if the memory can support both
single-bit and multi-bit ECC, i think the answer is yes.
@Dong, Guo <guo.dong@intel.com> or @Chiu, Chasel
<chasel.chiu@intel.com> could you
help to confirm on this?

Thanks.

Best Regards,
*Lean Sheng Tan*



9elements GmbH, Kortumstra=C3=9Fe 19-21, 44787 Bochum, Germany
Email: sheng.tan@9elements.com
Phone: *+49 234 68 94 188 <+492346894188>*
Mobile: *+49 176 76 113842 <+4917676113842>*

Registered office: Bochum
Commercial register: Amtsgericht Bochum, HRB 17519
Management: Sebastian German, Eray Bazaar

Data protection information according to Art. 13 GDPR
<https://9elements.com/privacy>


On Tue, 29 Aug 2023 at 23:38, Rob Herring <robh@kernel.org> wrote:

> On Tue, Aug 29, 2023 at 2:18=E2=80=AFPM Simon Glass <sjg@chromium.org> wr=
ote:
> >
> > Some memories provides ECC correction. For software which wants to chec=
k
> > memory, it is helpful to see which regions provide this feature.
> >
> > Add this as a property of the /memory nodes, since it presumably follow=
s
> > the hardware-level memory system.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > (no changes since v3)
> >
> > Changes in v3:
> > - Add new patch to update the /memory nodes
> >
> >  dtschema/schemas/memory.yaml | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/dtschema/schemas/memory.yaml b/dtschema/schemas/memory.yam=
l
> > index 1d74410..981af04 100644
> > --- a/dtschema/schemas/memory.yaml
> > +++ b/dtschema/schemas/memory.yaml
> > @@ -34,7 +34,14 @@ patternProperties:
> >          description:
> >            For the purpose of identification, each NUMA node is
> associated with
> >            a unique token known as a node id.
> > -
> > +      attr:
>
> Kind of vague.
>
> > +        $ref: /schemas/types.yaml#/definitions/string-array
> > +        description: |
> > +          Attributes possessed by this memory region:
> > +
> > +            "single-bit-ecc" - supports single-bit ECC
> > +            "multi-bit-ecc" - supports multiple-bit ECC
>
> "supports" means corrects or reports? Most h/w supports both, but only
> reports multi-bit errors.
>
> > +            "no-ecc" - non-ECC memory
>
> Don't define values in free form text.
>
> This form is difficult to validate especially when non-ECC related
> attr's are added to the mix as we can't really define which
> combinations are valid. For example how do we prevent:
>
> attr =3D "single-bit-ecc", "multi-bit-ecc";
>
> Or maybe that's valid? If so, how would we express that?
>
> Why do we need "no-ecc"? Is that the same as no "attr" property?
>
> I think it's better if we have 'ecc-type' or something? Or generally,
> a property per class/type of attribute.
>
> Rob
>
