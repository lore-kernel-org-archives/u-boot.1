Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CDB3C021AA
	for <u-boot@archiver.kernel.org>; Mon, 17 Feb 2025 13:14:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B72D380C7E;
	Mon, 17 Feb 2025 14:14:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UKVa31j0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4790880017; Mon, 17 Feb 2025 14:14:31 +0100 (CET)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 27ED280C8F
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 14:14:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-abb90c20baeso171759966b.1
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 05:14:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739798068; x=1740402868; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=45cHEMCQc1fb6AdP3Rm6SSAh42i/WNCRnVfzh36bNKg=;
 b=UKVa31j0qxxd7b6AwXQE+c8MzP1N0wk+0dbruj9BL+zS1gsniCMH5aLp3FypirL9Bu
 y7MWnHEJCm7cZKauw+nOzpRJqPvcXKnKCjIKuYnGien3vEWV+0WiOlv3chx6MFtTIz6J
 fdJHTmpjEVbn3LKnAowNw5tInt5aU0mC9ze64=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739798068; x=1740402868;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=45cHEMCQc1fb6AdP3Rm6SSAh42i/WNCRnVfzh36bNKg=;
 b=fEMA8fQJ913iQRz+NgtDVm6edxI3Gnfr8GCh5w4E04tM/mUB+ItQiHqXP/dsLKTsLu
 90QDc8TM57VAk64gBMo9/HbLW3F7oEwuW8kwIgbDQYmckZXWylNrGodoZ9Zf1s4Nf4EC
 lRRAz5rBjQy4tsvr48zsuJ6POmUvZT4tjbWxiT9hDUfl+0p6OKyArytAYudTjBL61jbY
 IpT0cxw9kvMWim2pJ0pCAPlfLPBZTbcvcL5FqKNppA+4oW6NNnx0F5PQr/9vVDKKYqPI
 m26vGKdxCmqyPCsTGcccW/bTP6q2XF2EuqC+6YhbwzNXwbc4Qdjm7s6b0bFHt2Q2K3iP
 vwPw==
X-Gm-Message-State: AOJu0Yxaeoy721jUQZFSWQwaPoV6JMEX2lCryL0+Q7M/fAHC3Ko6RZYO
 JTF9rPxINj2Bmdy9p1o+XJKll/wG/c/qNUkkfH4ABvgHuEJaqrTw1DlopU9vzBSCAeGA7Yl1+aj
 N2PpeBPT7hWJ2lG3U0k6fQEkyonXJtV3/G8Hd
X-Gm-Gg: ASbGncsnCCfaCnB0j5TlechPzVqzjMNlqm8HECraNPBAMEuXyYZX0AvCnFUXKJDzgHx
 aLKu+m1M/cMuH0nAQS5zL2VcFMo+ygg1bBecYNBKYHFq7/KK83KxvtxzGYPrmU50JLGlnsMVhfg
 ==
X-Google-Smtp-Source: AGHT+IESyJfxr7bDFHXTRD7ftjROugj0d04K5u3Kzfvj+sKyqzVXbHkF3XzvB17z1PjXXBEYq4/LbONkyf+NRUETb8M=
X-Received: by 2002:a17:907:1c21:b0:ab7:83aa:b19 with SMTP id
 a640c23a62f3a-abb70d95945mr1077855766b.42.1739798067133; Mon, 17 Feb 2025
 05:14:27 -0800 (PST)
MIME-Version: 1.0
References: <20241120104029.886860-1-paul.henrys_ext@softathome.com>
 <CAFLszTi1eue=sm0Mv6Q4cTB-ATE6oD6qMFkJJWPAbc=NiWK1Ew@mail.gmail.com>
 <e4474aad-e2f6-4213-ba5d-c54ad4cb3059@softathome.com>
 <CAFLszThEm4MzG6sj0QrHiyAS=B5xQtj0wjnkQ34OStuyFu7WfA@mail.gmail.com>
 <95ed2380-f520-4334-bf67-0457a2bd5278@softathome.com>
In-Reply-To: <95ed2380-f520-4334-bf67-0457a2bd5278@softathome.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 17 Feb 2025 06:14:15 -0700
X-Gm-Features: AWEUYZlF-0t7oOwKq35AEImB2kfmAq9EvmZzv-F4S1vyD5Nh9nS-UPqMnnjM91c
Message-ID: <CAFLszTiS4n-CX6tXa4wUqE2GZHqVDMhd8cPwLpBMmk7=8mKv3g@mail.gmail.com>
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

On Mon, 17 Feb 2025 at 04:47, Paul HENRYS
<paul.henrys_ext@softathome.com> wrote:
>
> Hi Simon,
>
> On 15/02/2025 12:59, Simon Glass wrote:
> > Hi Paul,
> >
> > On Thu, 21 Nov 2024 at 03:53, Paul HENRYS
> > <paul.henrys_ext@softathome.com> wrote:
> >> Hi Simon,
> >>
> >> On 20/11/2024 14:35, Simon Glass wrote:
> >>> This Mail comes from Outside of SoftAtHome: Do not answer, click links or open attachments unless you recognize the sender and know the content is safe.
> >>>
> >>> Hi Paul,
> >>>
> >>> On Wed, 20 Nov 2024 at 03:40, Paul HENRYS
> >>> <paul.henrys_ext@softathome.com> wrote:
> >>>> This change allows to replace both 'SEQ' and 'NAME' keywords by respectively a
> >>>> sequence number and the name of the FDT to provide more flexibility in the node
> >>>> name for the device trees included in the FIT.
> >>> This seems OK to me, but it would help to understand the motivation
> >>> better. Can you expand this a bit?
> >> The rational behind this change is because some projects uses some kind
> >> of board data to look for the right config in a FIT image in U-Boot. The
> >> default sequence number (config-1, config-2...) does not make it easy to
> >> retrieve the right config in such a case. For instance, OpenWrt uses the
> >> script "scripts/mkits.sh" to create an ITS passed to mkimage, where the
> >> config node names can be customized when supporting multiple configs and
> >> typically uses the device tree name appended to "config-".
> >> The idea is thus to provide the flexibility in binman to use the
> >> traditional scheme with the sequence numbers (config-1, config-2...) or
> >> use NAME instead (e.g. config-myboard1, config-myboard2...) or a
> >> combination of both.
> > Sorry, I dropped this for ages.
> >
> > You should use the compatible string, not the node name. What kind of
> > board is this?
>
> No worries but you actually reviewed this change and it was integrated
> in the master branch in the commit a4345b193479.
>
> I agree that the compatibility property can be used and that might be a
> better practice but U-Boot current implementation also uses the
> configuration node names to select the configuration. Hereafter is my
> understanding of the implementation.
>
> The configuration name (spec) in the FIT image can be passed to the
> bootm command, typically with such a command: bootm 0x1000000#config-1.
>
> do_bootm() -> bootm_run_states() -> bootm_find_os() -> boot_get_kernel()
> -> genimg_get_kernel_addr_fit() -> fit_parse_conf()
>
> The above sequence retrieves the configuration name passed through the
> bootm arguments and stored in fit_uname_config.
>
> Later on, fit_image_load() is called in boot_get_kernel() and the
> previously configuration name stored in fit_uname_config can be used to
> retrieve the images to load. There are actually different solutions to
> retrieve the configuration and the images to be loaded:
>    * Using the compatibility information if provided and when
> CONFIG_FIT_BEST_MATCH is enabled. This happens when calling
> fit_conf_find_compat() if fit_uname_config is NULL
>    * Using the configuration node name when calling fit_conf_get_node()
> if no configuration could be previously found
>
> So basically, U-Boot current implementation allows to use both
> compatibility property and the config node name from the FIT but so far
> only a sequence number could be set (config-1, config-2...). The
> proposed changes allow to also set a name based on the device tree names.

As I think you have said here, the idea with 'bootm' is that it can
automatically select the right configuration, if CONFIG_FIT_BEST_MATCH
is enabled.

Thanks for the details above, it is a helpful summary.


>
> >
> >>>> Signed-off-by: Paul HENRYS <paul.henrys_ext@softathome.com>
> >>>> ---
> >>>>    tools/binman/etype/fit.py | 1 +
> >>>>    1 file changed, 1 insertion(+)
> >>>>
> >>>> diff --git a/tools/binman/etype/fit.py b/tools/binman/etype/fit.py
> >>>> index e0c1ac08d8..b9ebc3afd0 100644
> >>>> --- a/tools/binman/etype/fit.py
> >>>> +++ b/tools/binman/etype/fit.py
> >>>> @@ -732,6 +732,7 @@ class Entry_fit(Entry_section):
> >>>>                    # Generate nodes for each FDT
> >>>>                    for seq, fdt_fname in enumerate(self._fdts):
> >>>>                        node_name = node.name[1:].replace('SEQ', str(seq + 1))
> >>>> +                    node_name = node_name.replace('NAME', fdt_fname)
> >>>>                        if self._fdt_dir:
> >>>>                            fname = os.path.join(self._fdt_dir, fdt_fname + '.dtb')
> >>>>                        else:
> >>>> --
> >>>> 2.43.0
> >>> Please update the documentation (near the top of this file) and
> >>> regenerate entries.rst
> >>>
> >>> It also needs a test so that coverage passes (binman test -T)...
> >> Ok. I am going to update the documentation and add a test.
> >>> [..]
> >>>

Regards,
Simon
