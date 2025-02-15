Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 551ADC021A0
	for <u-boot@archiver.kernel.org>; Sat, 15 Feb 2025 12:00:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82F1780EEF;
	Sat, 15 Feb 2025 13:00:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RtQ57s24";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C51080F1C; Sat, 15 Feb 2025 13:00:00 +0100 (CET)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31F8080E88
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 12:59:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5e04861e7a6so8730a12.1
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 03:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739620798; x=1740225598; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ILZR9Hpr4rCYQusxbcedpmvMybXBxNkEy20SgMYmBMQ=;
 b=RtQ57s24r7QOl7pf7zpPx8zrp3UggqBgwDVTC7N2gcThJZH/gMJ5hTzAietBBgxkZz
 S44vl9VJWHT0m1I5U0C28BFDsUEbZhOY6kUk4jivpGkdb0Vo/pg04SNGVtGf/pyWsD/g
 2fSDulXimCsb6mW1Y9wodvYxW1W3WTjzoz7iM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739620798; x=1740225598;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ILZR9Hpr4rCYQusxbcedpmvMybXBxNkEy20SgMYmBMQ=;
 b=NfcOEwOr3JNYEFYcq7J+5OcEk5tC0B0NHcWQIIKfqxVtpiVE6+BS8Aw8n1T3ChpN+9
 hYDupKYry19RPlCj9GsRlVLeD8Ek2QOf6PWmfKr5zE+Zmf+x3+XKTajSS1TtzmcSockN
 Hav6vTL57S8vN45pjoANG99Cf6uIG9PZWdGdTd6+vQb1q4Hm2QoDTZZduq6+ZcCnGxJb
 vBPWH+LYa7xKLJkdGqczBOOon8yiWyLcuFH90O1ADn59g34fY/koKESh2GkNEZSgbU5w
 b3//aU+fYZSvG9AwThWKQSlNjEqHS8FE57qEAtPULurDqktBq5J1q8TarERzZMuov1Xs
 h47w==
X-Gm-Message-State: AOJu0Yw+RVAev+juhZ2euf7D9zdjnha1icEG0Vk3lr69vScpYXnrZQGt
 SCOhm3tf+ZFR6SVYBQcvEipgoJR5xJVTwHSOgv3hw6V3d3P62OAbANyt/fCZyj5X99H2xiyUuZg
 qNlLgSXrgTDnGIK2MMFwBe983rRMQnugQu3V4khPZnVrmQ08=
X-Gm-Gg: ASbGnctGw2e7I6xrM4sBz5zKHWD8a9IPU+ShSgrElou9F8dLacIs6OwUUPCYE1831k0
 0h490ySs+XvhewvWmSYmBzfxwaevE2ILSP7cxkZI1y0l0oNQ2rcLEcHdCD9msyqbun6tWpw/brQ
 ==
X-Google-Smtp-Source: AGHT+IEwXv9AG/6uTvpzHy2v6i/PdLnZBgkya/3Y71+sSiaNBImr8fdMcjUjOCCUwF6ZWxA3DMcPA7Z9g/CD73xt8+k=
X-Received: by 2002:a17:906:4794:b0:ab7:bcc0:906a with SMTP id
 a640c23a62f3a-abb70d3fdf5mr238958566b.20.1739620797604; Sat, 15 Feb 2025
 03:59:57 -0800 (PST)
MIME-Version: 1.0
References: <20241120104029.886860-1-paul.henrys_ext@softathome.com>
 <CAFLszTi1eue=sm0Mv6Q4cTB-ATE6oD6qMFkJJWPAbc=NiWK1Ew@mail.gmail.com>
 <e4474aad-e2f6-4213-ba5d-c54ad4cb3059@softathome.com>
In-Reply-To: <e4474aad-e2f6-4213-ba5d-c54ad4cb3059@softathome.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 15 Feb 2025 04:59:45 -0700
X-Gm-Features: AWEUYZnf9xxAYvMc-9CcJS9QR7FJg-NU2_6JPQTaeKMFrqH9sksPxobjNWmlGzA
Message-ID: <CAFLszThEm4MzG6sj0QrHiyAS=B5xQtj0wjnkQ34OStuyFu7WfA@mail.gmail.com>
Subject: Re: [PATCH 1/1] tools: binman: etype: Allow to replace 'NAME' in node
 names
To: Paul HENRYS <paul.henrys_ext@softathome.com>
Cc: u-boot@lists.denx.de, paul.henrysd+nodisclaimer@gmail.com
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

Hi Paul,

On Thu, 21 Nov 2024 at 03:53, Paul HENRYS
<paul.henrys_ext@softathome.com> wrote:
>
> Hi Simon,
>
> On 20/11/2024 14:35, Simon Glass wrote:
> > This Mail comes from Outside of SoftAtHome: Do not answer, click links or open attachments unless you recognize the sender and know the content is safe.
> >
> > Hi Paul,
> >
> > On Wed, 20 Nov 2024 at 03:40, Paul HENRYS
> > <paul.henrys_ext@softathome.com> wrote:
> >> This change allows to replace both 'SEQ' and 'NAME' keywords by respectively a
> >> sequence number and the name of the FDT to provide more flexibility in the node
> >> name for the device trees included in the FIT.
> > This seems OK to me, but it would help to understand the motivation
> > better. Can you expand this a bit?
> The rational behind this change is because some projects uses some kind
> of board data to look for the right config in a FIT image in U-Boot. The
> default sequence number (config-1, config-2...) does not make it easy to
> retrieve the right config in such a case. For instance, OpenWrt uses the
> script "scripts/mkits.sh" to create an ITS passed to mkimage, where the
> config node names can be customized when supporting multiple configs and
> typically uses the device tree name appended to "config-".
> The idea is thus to provide the flexibility in binman to use the
> traditional scheme with the sequence numbers (config-1, config-2...) or
> use NAME instead (e.g. config-myboard1, config-myboard2...) or a
> combination of both.

Sorry, I dropped this for ages.

You should use the compatible string, not the node name. What kind of
board is this?

> >
> >> Signed-off-by: Paul HENRYS <paul.henrys_ext@softathome.com>
> >> ---
> >>   tools/binman/etype/fit.py | 1 +
> >>   1 file changed, 1 insertion(+)
> >>
> >> diff --git a/tools/binman/etype/fit.py b/tools/binman/etype/fit.py
> >> index e0c1ac08d8..b9ebc3afd0 100644
> >> --- a/tools/binman/etype/fit.py
> >> +++ b/tools/binman/etype/fit.py
> >> @@ -732,6 +732,7 @@ class Entry_fit(Entry_section):
> >>                   # Generate nodes for each FDT
> >>                   for seq, fdt_fname in enumerate(self._fdts):
> >>                       node_name = node.name[1:].replace('SEQ', str(seq + 1))
> >> +                    node_name = node_name.replace('NAME', fdt_fname)
> >>                       if self._fdt_dir:
> >>                           fname = os.path.join(self._fdt_dir, fdt_fname + '.dtb')
> >>                       else:
> >> --
> >> 2.43.0
> > Please update the documentation (near the top of this file) and
> > regenerate entries.rst
> >
> > It also needs a test so that coverage passes (binman test -T)...
> Ok. I am going to update the documentation and add a test.
> >
> > [..]
> >
> > Regards,
> > Simon
> Regards,
> Paul

Regards,
Simon
