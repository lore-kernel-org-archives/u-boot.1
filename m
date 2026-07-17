Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78918C4451B
	for <u-boot@archiver.kernel.org>; Fri, 17 Jul 2026 15:21:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5243984E2C;
	Fri, 17 Jul 2026 17:21:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZG+BLDmU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E56F84E36; Fri, 17 Jul 2026 17:21:39 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 901DD84E1F
 for <u-boot@lists.denx.de>; Fri, 17 Jul 2026 17:21:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-69e5f8a193bso1541279a12.2
 for <u-boot@lists.denx.de>; Fri, 17 Jul 2026 08:21:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784301696; cv=none;
 d=google.com; s=arc-20260327;
 b=rTNd8CFCI7FRkzC2/60H6bA0aZdskv6AXT9w17X6QSGkMHggMzfSb0dGksS8mIDCMR
 7/uxwRkimSYciPsxx7IMkWVjKpEEz/w0ECp106ifJiSNJIfFZ5F4xsHXDmJCEm/lBg8E
 Xxxx7DrAswQuZxknNu0f+HRTtuZaj0wNde6/1EozlqOtS4DAh7bBmjrRoRSkcEv5w+Py
 rLfTiHQ9x1qW6cF7Zu7Ma15Eg/rJypnR6Sv8JeVvhENiA0bSJaWx7w899jPQiqNQmUwx
 Ufbk7A4zouOv8D2zTeEhG9sVFpIO3S7KbIxW+3hpE+yWKG842Yp7YHAb2XKaYvDu/6rX
 9/JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=vN+qhWcAJpN58OCIbJqgIdgJMYKXBXKINx20vG7gBBs=;
 fh=FS43jQmGw96xWTfDffUvswPyPsuQ4FKbyI7t0mUcbKE=;
 b=GAoNK5BOovfcHJLz81UuvALpwaZOnfeYGNaRk8mvH1TjJP45Soh/awyx5w/e2E1uFj
 dSn9t4DvUkYcN+LoTWY+HSRMKgFIiIVcwted/mhNgGFPim/s9yWxKDLdMODpejeZUroj
 ubpdbnmOfOlBGHmzChoZ6WaKobHBNgzVuCt70g5tiN9Vgp6cfMffiP7KAr4JfJe1cZW9
 d9WYlCW5VEEjK2QTkOGVOSSetMZ5ee4YLmcHgHMdTK7SyKu+rE7E1PP0EcDm3AGwXKtm
 1X4mQdk1a472pXrWsghIgtVImOtqNnTx822C1cp0x9T2dqW1GvenylWDI90S6KYDnw8B
 NveQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1784301696; x=1784906496; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=vN+qhWcAJpN58OCIbJqgIdgJMYKXBXKINx20vG7gBBs=;
 b=ZG+BLDmUUvFTQUJivzHSnbs/2QhsYqKQTIzaUk2qevm3qLwmpBaxAuGHFpeY048zcs
 IjyTvAipdbnehzaCiNwtN1pNXcBxhtR+bRhGq1bdKlGundSzHq1hFOSfLd+bW4SBqiAE
 ZVDRcy4vUpYIq11Vc5GniNHPQ9dGiqcpLvlCc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784301696; x=1784906496;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=vN+qhWcAJpN58OCIbJqgIdgJMYKXBXKINx20vG7gBBs=;
 b=gqKVhbOb66N08fSZFa12IbE/FOAtPs2pTk7MP8zUliLHRJKptX7cZveM03iS1cvpIq
 8UFo2SrMQ0d28Xsl7auxZSblRCL0SsENuHbYXgflGjDMiPKI6iYtgLWIWbRMt/frMleI
 8KQzgGpcsOMShqj/86aj8yUOiiU3HXC9rTN/lKol1W/uu30qyieuATAau2FxPjXwmIUz
 12Mpw2gOoHAE+mVJvlEr3bmEcy2tV9ynjH0y0Mmp7+mm0B5tdauMAmKuv6iAL2/llpE2
 mOHttNpPvbCEDf3Cuqd1seAyp9NM/QL3im7gOMYpoPYro5ggIBz6GQELjiagDof87bPG
 +ZuA==
X-Gm-Message-State: AOJu0Yxf/4QrIKdYHN9zRTz0jAYvWzrbjhC59EeMn67iBqhzXwf0gK0g
 a6ylK6xhfWMpMBEDLGnY+rypx4vM58x5OkuzOuai9LPgzmN9w9sBYMKpfLIVYkYjHefxvNjWwc1
 hoSFdDCQRPVoU55HKGEZlY7UJzKVo/9/WA7uuY2tSM0X9QpYBh1Y=
X-Gm-Gg: AfdE7ckkPnHPAj7jJk/wNZOaGfv+pb4GN8Gk72Oc9TzLLgVArP5ZWbDnPvP4Gw47aMH
 kcmtVZInLMc0XC80pEsTMlBGRkRulf3i/3zNq94HZXUEBbt84DYP8x5RUfYwlJ+KaApDf0kxyiD
 L7r82sNuqouaeE5NiYvmbaxUHYbSvpON/RC3UL43KU7ou13yK8P7Uj0leMtm0ijt2TBAk0+U6U4
 lQzu+xHP9sB9x0nXIuUgmPMbEz75bfNfOkh6iAv93bfkapzf17hjqDN6pxV
X-Received: by 2002:a17:907:3f8b:b0:c12:5e3d:4023 with SMTP id
 a640c23a62f3a-c16b457b127mr146223366b.10.1784301695976; Fri, 17 Jul 2026
 08:21:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260709-binman_template_phandle_copy_fix-v2-1-6c4017eec04d@ti.com>
In-Reply-To: <20260709-binman_template_phandle_copy_fix-v2-1-6c4017eec04d@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 17 Jul 2026 09:21:23 -0600
X-Gm-Features: AUfX_my53CnnfJqt_HpfV121AcqULEyhvqsyn6qpLlphQO3W1Up7X93343S2oiQ
Message-ID: <CAFLszTg=FDzHHJnYEUmyZaS=AinA__8TztV43b8Own+TMgg++w@mail.gmail.com>
Subject: Re: [PATCH v2] fdt: fix phandles not copying when using templates
To: anshuld@ti.com
Cc: u-boot@lists.denx.de
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

On 2026-07-09T10:24:07, Anshul Dalal <anshuld@ti.com> wrote:
> fdt: fix phandles not copying when using templates
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
> [...]
>
> tools/binman/ftest.py                           | 17 +++++++++++++++++
>  tools/binman/test/fdt/template_phandle_copy.dts | 22 ++++++++++++++++++++++
>  tools/dtoc/fdt.py                               |  2 +-
>  3 files changed, 40 insertions(+), 1 deletion(-)

> fdt: fix phandles not copying when using templates

Please capitalise after the tag ('fdt: Fix ...'), as is usual in U-Boot.

> The phandles used inside a template were not being copied to the node
> inserting the template, leading to a missing phandle error.

Please use present tense ('are not copied') since the code is still in
this state before the commit.

> diff --git a/tools/dtoc/fdt.py b/tools/dtoc/fdt.py
> @@ -780,7 +780,7 @@ class Node:
>              for node in parent.subnodes.__reversed__():
> -                dst = self.copy_node(node)
> +                _ = self.copy_node(node, True)

This breaks an existing test in tools/dtoc/test_fdt.py which checks
that the phandle is not copied at this level:

    FAIL: test_copy_subnodes_from_phandles
(__main__.TestNode.test_copy_subnodes_from_phandles)
    ...
    AssertionError: 'phandle' unexpectedly found in
dict_keys(['compatible', 'bootph-all', 'reg', 'low-power', 'phandle'])

Please can you update that test to check the new behaviour, i.e. that
the phandle is copied? Since the change is in fdt.py it needs coverage
at that level, as well as the binman functional test. Please run the
dtoc tests before sending v2:

    ./tools/dtoc/test_fdt.py

The fix itself looks right to me - copy_node() already passes True for
its recursive calls, so the first level was the odd one out, and the
binman docs ('Dealing with phandles') already say that phandles in
templates are copied. It would be worth noting in the
copy_subnodes_from_phandles() docstring that the source nodes must be
removed before the tree is scanned, to avoid duplicate phandles.

There is no need to assign the return value to _ - just call
self.copy_node(node, True) directly.

> diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
> @@ -8552,5 +8552,22 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
> +    def testTemplatePhandleCopy(self):
> +        """Test if phandles are copied properly when inserting template"""
> +        _, _, _, out_dtb_fname = self._DoReadFileDtb("fdt/template_phandle_copy.dts")

Please use single quotes for strings, as elsewhere in this file, and
keep to 80 columns - this line is 85 characters and the two
assertEqual() calls below also overflow. See the nearby tests for the
usual continuation style, rather than putting the closing parenthesis
on its own line.

Regards,
Simon
