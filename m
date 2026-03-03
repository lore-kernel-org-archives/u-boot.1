Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CA5FEC144C
	for <u-boot@archiver.kernel.org>; Tue,  3 Mar 2026 13:41:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD26983F7F;
	Tue,  3 Mar 2026 14:41:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Eerte0Sk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2ECA583F59; Tue,  3 Mar 2026 14:40:59 +0100 (CET)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C07EF83E7F
 for <u-boot@lists.denx.de>; Tue,  3 Mar 2026 14:40:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-65f812e0c83so10631298a12.2
 for <u-boot@lists.denx.de>; Tue, 03 Mar 2026 05:40:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772545256; cv=none;
 d=google.com; s=arc-20240605;
 b=S5OmQwhvbZrEuhqPQ4iI3jJUSGE6bFueh2L5oL7SDjv+NXWABOKZdfxqf54KjShrUM
 xZnClz0MxcrVyl/uT4iMsLONLPACfaIqyIwSp+dUlZOgtzSnKRMdgjIOBjwg6tA97iqb
 efg1aB29FQQNWpmbIwYJG+6v6TwtVfgZJLQjjXvTPl1GPsXMkx7sRFidt6OB4+jL/G7U
 2FXcCPxM1vgUUUZl3WwezGrpSVKmW9O+OdFnzMeKWxP/IEIqIC6E667JcpOgVSYytkGR
 eCpbdMg6QRm1ZZL1etscmSxP2sgynMiHe+JFpQ6L1gaEwOMqu7i3YsEDD8Kr8nIK0zof
 QD0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=zvcFX6R0rm2YP/xL6J+wOORv8fmomzQMRmCa9gEsVVw=;
 fh=zP/uJwo1R4mj5xLiISyT6imDqWUpxmReWtLDnhRt2Sc=;
 b=EZFgSeqB72NzQdNfOsomLCLBna0zB7Kw0c/1C42T19DWm+/Ejuk7PJRq+Rvk3dxXKy
 VMFIpqJ5ug5bYoKXGxGEJFOQvhyBnH95oNl+/N59+0Jmc/zIielWNgN49zRwnX89L5Yb
 EctUIDc/HUSK6/mZ1ZT/juHGhrmx4XYv9nytHvWGuYi4aqTJO8peCHkqNui8a7vqARWS
 EJqU4Bx+hPqXjJtLlaMiEA0kQg9vhdgddxE/bQrqwMf+WVMxmIC48T7m53MZXXCyVCI3
 ddMKTmm3abOCIesLaDAXG3qAcYVbcl0dqLyHYd0FzUjpXZ3iTt2mM9f6xrwYu9eTCJL8
 DKzw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1772545256; x=1773150056; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zvcFX6R0rm2YP/xL6J+wOORv8fmomzQMRmCa9gEsVVw=;
 b=Eerte0SkDbN1wQDLzOXC7wQbcNsDqs8t1ZMUjCKth/qEliR4699tTX2d0hwRLLgixr
 dlVFUUnXGDeR2l5+q0MGG0zePFlRhxBqicaPFp3lFOf4H6IxhiePFV9M9wzCNbvVCDFX
 RH18jbsr1K7qLsJyBvU9wXybaqn3q6QZKUvTU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772545256; x=1773150056;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zvcFX6R0rm2YP/xL6J+wOORv8fmomzQMRmCa9gEsVVw=;
 b=nuKj7Er8u0gqWHXEFR7rFn753Gtj2m3vlRXga/FGPQEvRQiNrmbiyVBGL/N6cDz5tY
 AZmXhsucquwZWZkhubYnfkqkSC51rgRUUTSUY4u1VFZjVMJc+1h7wMT8GrnpltiZrgvH
 qqgxasSeJfrYYAotmca1eJtFjlebfCD25MZEwGVZgfnDRdPQjAYXYwce1U5oxQrJkPxX
 7v1HNbPaRACa1odhwurff2y9ji22n02Abd4ALlRq9Lp/cmEHXKXqtAxeOaEP4A2qg9Vp
 cd6PgvJ7S0sp1/s8lpl59Bnadeq/jIsoa63m92b5CMmjQw1yNK+pZtgNwyx4+bgqICSn
 wBUg==
X-Gm-Message-State: AOJu0YxwBWgVjJcbmEZtwjYdsdxT/B6mDihpqHmVx326hag2gkSBsL4N
 xO0LYDzAh4kmdAS1jQKBz+jX4UAS1S4Y70kXlcot+X0AwNVQ1N2n8LTohPdmnmTWKpfufSugJ3y
 mcE6DDva6SHmiJ/RXL3Vasoo0K6No1ZT105LG5lwx
X-Gm-Gg: ATEYQzzXujvgkkUkNLfuSEfJ5DGdJ2RNzNqld0yVLitJi57eOzCDzMiUQ/heMHdngIi
 XLJu3ZfsBscbq9E7fSl8xlJ2Pyr0tBdk28r4qeZtIEuDqJSPxOMTiC8gF+XmUjCx8Pn5gihzbNq
 cR8oll0JEjbGh//InmC/T7SzOgjob1owguRW73kr++TIIa5CzsktOEsmZucK/eyWMFoaMYZlUZT
 Dk78mW8OoZjIjJAG2rWnGpBw14xefgQuaJ1mM1sN9z4wggtGBuAE15GvZ90MAP6C0EIJ1Ywjpjg
 a7l9GCwTrl2BCrRK
X-Received: by 2002:a05:6402:5245:b0:65a:46a2:ed23 with SMTP id
 4fb4d7f45d1cf-65fde4c0954mr11388128a12.28.1772545256180; Tue, 03 Mar 2026
 05:40:56 -0800 (PST)
MIME-Version: 1.0
References: <20260226234802.345968-1-sjg@chromium.org>
 <20260226234802.345968-5-sjg@chromium.org>
 <6a318143-7b58-4217-87f3-78fa6ef1348d@cherry.de>
In-Reply-To: <6a318143-7b58-4217-87f3-78fa6ef1348d@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 3 Mar 2026 06:40:43 -0700
X-Gm-Features: AaiRm52No_7ca4IBPDMdh_6KnHxCq6FGwgL8q6NyRRu8KXPNScVXOH5sBqdae7Y
Message-ID: <CAFLszTgX0VuV1PLjOj=nVnkyO+8g3vDTjxHB3Bss7a75nK8Ktw@mail.gmail.com>
Subject: Re: [RFC PATCH 04/16] binman: test: Move FIT image test files to
 test/fit/
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <simon.glass@canonical.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Aristo Chen <jj251510319013@gmail.com>, Bryan Brattlof <bb@ti.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>, 
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Yannic Moog <y.moog@phytec.de>
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

Hi Quentin,

On Tue, 3 Mar 2026 at 05:41, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>
> Hi Simon,
>
> On 2/27/26 12:47 AM, Simon Glass wrote:
> > From: Simon Glass <simon.glass@canonical.com>
> >
> > Move about 40 test files for FIT images (signing, external data,
> > split-elf, encryption, alignment, firmware loadables, templates) into
> > a fit/ subdirectory. Drop the numeric prefixes and the redundant fit_
> > filename prefix, and update all references.
> >
> > Rename the three signature.dts variants to have unique names:
> > signature.dts, signature_multi_key.dts and signature_no_nodes.dts.
> >
>
> What about aes256.bin, 340_rsa2048.key, dummy-rsa-engine.c,
> 340_dummy-rsa4096.crt, 340_openssl.conf, 340_softhsm2.conf, and dev.key?
>
> Can be done in a separate patch.
>
> > Signed-off-by: Simon Glass <simon.glass@canonical.com>
> > ---
> >
> >   tools/binman/ftest.py                         | 118 +++++++++---------
> >   .../test/{275_fit_align.dts => fit/align.dts} |   0
> >   .../{227_fit_bad_dir.dts => fit/bad_dir.dts}  |   2 +-
> >   .../bad_dir_config.dts}                       |   2 +-
> >   .../bad_oper.dts}                             |   0
> >   .../encrypt_data.dts}                         |   0
> >   .../encrypt_data_no_key.dts}                  |   0
> >   .../external.dts}                             |   0
> >   .../extract_replace.dts}                      |   0
> >   .../test/{170_fit_fdt.dts => fit/fdt.dts}     |   0
> >   .../fdt_compat.dts}                           |   0
> >   .../{333_fit_fdt_dir.dts => fit/fdt_dir.dts}  |   0
> >   .../fdt_list.dts}                             |   0
> >   .../fdt_missing_prop.dts}                     |   0
> >   .../fdt_name.dts}                             |   0
> >   .../fdt_oper.dts}                             |   0
> >   .../fdt_phase.dts}                            |   0
> >   .../firmware_loadables.dts}                   |   0
> >   .../binman/test/{161_fit.dts => fit/fit.dts}  |   0
> >   .../{219_fit_gennode.dts => fit/gennode.dts}  |   0
> >   .../image_subentry_alignment.dts}             |   0
> >   .../key_name_hint_dir_signature.dts}          |   0
> >   .../missing_blob.dts}                         |   0
> >   .../replace_sibling.dts}                      |   0
> >   .../test/{280_fit_sign.dts => fit/sign.dts}   |   0
> >   .../signature.dts}                            |   0
> >   .../signature_engine.dts}                     |   0
> >   .../signature_engine_encrypt.dts}             |   0
> >   .../signature_engine_pkcs11.dts}              |   0
> >   .../signature_engine_pkcs11_object.dts}       |   0
> >   .../signature_multi_key.dts}                  |   0
> >   .../signature_no_nodes.dts}                   |   0
> >   .../split_elf.dts}                            |   0
> >   .../subentry_bintool.dts}                     |   0
> >   .../subentry_hash.dts}                        |   0
> >   .../tee_os_opt.dts}                           |   0
> >   .../tee_os_opt_bad.dts}                       |   0
> >   .../template.dts}                             |   0
> >   38 files changed, 61 insertions(+), 61 deletions(-)
> >   rename tools/binman/test/{275_fit_align.dts => fit/align.dts} (100%)
> >   rename tools/binman/test/{227_fit_bad_dir.dts => fit/bad_dir.dts} (71%)
> >   rename tools/binman/test/{228_fit_bad_dir_config.dts => fit/bad_dir_config.dts} (71%)
> >   rename tools/binman/test/{224_fit_bad_oper.dts => fit/bad_oper.dts} (100%)
> >   rename tools/binman/test/{343_fit_encrypt_data.dts => fit/encrypt_data.dts} (100%)
> >   rename tools/binman/test/{344_fit_encrypt_data_no_key.dts => fit/encrypt_data_no_key.dts} (100%)
> >   rename tools/binman/test/{162_fit_external.dts => fit/external.dts} (100%)
> >   rename tools/binman/test/{240_fit_extract_replace.dts => fit/extract_replace.dts} (100%)
> >   rename tools/binman/test/{170_fit_fdt.dts => fit/fdt.dts} (100%)
> >   rename tools/binman/test/{334_fit_fdt_compat.dts => fit/fdt_compat.dts} (100%)
> >   rename tools/binman/test/{333_fit_fdt_dir.dts => fit/fdt_dir.dts} (100%)
> >   rename tools/binman/test/{284_fit_fdt_list.dts => fit/fdt_list.dts} (100%)
> >   rename tools/binman/test/{171_fit_fdt_missing_prop.dts => fit/fdt_missing_prop.dts} (100%)
> >   rename tools/binman/test/{345_fit_fdt_name.dts => fit/fdt_name.dts} (100%)
> >   rename tools/binman/test/{223_fit_fdt_oper.dts => fit/fdt_oper.dts} (100%)
> >   rename tools/binman/test/{335_fit_fdt_phase.dts => fit/fdt_phase.dts} (100%)
> >   rename tools/binman/test/{276_fit_firmware_loadables.dts => fit/firmware_loadables.dts} (100%)
> >   rename tools/binman/test/{161_fit.dts => fit/fit.dts} (100%)
> >   rename tools/binman/test/{219_fit_gennode.dts => fit/gennode.dts} (100%)
> >   rename tools/binman/test/{167_fit_image_subentry_alignment.dts => fit/image_subentry_alignment.dts} (100%)
> >   rename tools/binman/test/{355_key_name_hint_dir_fit_signature.dts => fit/key_name_hint_dir_signature.dts} (100%)
>
> This file doesn't exist. What is this series based on? I'm assuming
> https://lore.kernel.org/u-boot/20260225225040.2568118-1-sjg@chromium.org/
> but can you please specify series dependencies in the cover-letter so we
> don't have to guess. I'm also thinking the parent dependency have two
> patches we wouldn't need with this series here (rename and drop the
> number, patch 1 and 2 of the series).

Yes that's right. The commit hash is in the cover letter but the
branch name doesn't help very much! I need to update patman to include
the patch link as well. I could rework that series to drop the
renames, but the point of that series is really to fix the test
coverage.

Perhaps I should just combine the two series into one?

Regards,
Simon
