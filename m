Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36173E95A7E
	for <u-boot@archiver.kernel.org>; Sat,  7 Oct 2023 23:21:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55C2A86F18;
	Sun,  8 Oct 2023 01:14:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LASuIsa2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C55A486EE5; Sun,  8 Oct 2023 01:12:21 +0200 (CEST)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9FA6D86EBF
 for <u-boot@lists.denx.de>; Sun,  8 Oct 2023 01:12:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-59f6441215dso40756347b3.2
 for <u-boot@lists.denx.de>; Sat, 07 Oct 2023 16:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696720299; x=1697325099; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=uoZr7jSRE1HADXb7/6yCEBtP/0yjStMWTIr10liyt4U=;
 b=LASuIsa2jPjY2E19SEr7WiuBvC6QyZBBe5ATROlBZ1BDASF0p0v2wcDUNwa9+AhgrF
 1lLeBo718CyYjogSbdqGNbq5kY5akFvf31uuyvhaS+pNvROwh4TUf6kqbnSwI7DNom2P
 28/nwALeJj9C4YMJS+xhHM8UWXjYHhKajtqKs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696720299; x=1697325099;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uoZr7jSRE1HADXb7/6yCEBtP/0yjStMWTIr10liyt4U=;
 b=AuiyXc+K8v7r0zS80Dd90jup9bEc0Frm5w0qx+iT0aTAtt7d95g3dzk6hFIYkbMknT
 4sObS2f3aRosZeMhtxn0l7ms3w8Pa09k9YNeu6Dk3G0DHbaY2VlF68FWqFNfYplJbbqb
 dZxUhyXThhpc5tttBRrTxXYdH1461ISZX5P1TekGklsMB6WdDXviFe1+1jvV5R1ikZs3
 rt2jhdIA8Wrq8nCBgiTMCTB7KlX0DNeUFyBuKgVDovWX9jPJeWGYLqR4EbwCK7C69oRi
 SBN6h9YxbPJO4n2hba6v3XW98RXf6W70ELlefZhjV1yBnilLlv2iyKEpC2RbqNAnSbNJ
 co5A==
X-Gm-Message-State: AOJu0Yzvw5xnmbcORHf0OybDLT7DJtIYIr51asJd4rv+XX531eJRaCpg
 T5lb71T8MVPpFma2sleiD0g+2kCotFwenQBUFsYTSA==
X-Google-Smtp-Source: AGHT+IGKJTUggEsui4lnQM1jIUrmP5QQQ1Da/ONkc3i2YLG1IKm1DvmlpOoTU1zKq5pwCumpFQgsrZ+2WZk2piXFvFI=
X-Received: by 2002:a0d:cf01:0:b0:59b:54b5:7d66 with SMTP id
 r1-20020a0dcf01000000b0059b54b57d66mr12125918ywd.34.1696720299301; Sat, 07
 Oct 2023 16:11:39 -0700 (PDT)
MIME-Version: 1.0
References: <20231004112722.416877-1-sughosh.ganu@linaro.org>
 <20231004112722.416877-4-sughosh.ganu@linaro.org>
In-Reply-To: <20231004112722.416877-4-sughosh.ganu@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 7 Oct 2023 17:09:48 -0600
Message-ID: <CAPnjgZ0_8FqJEarNvE6RN218PJWUGu1W0_f3iVjzBTibpQ1KFg@mail.gmail.com>
Subject: Re: [PATCH 3/5] binman: capsule: Use dumped capsule header contents
 for verification
To: sughosh.ganu@linaro.org
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>, 
 Tom Rini <trini@konsulko.com>
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

Hi Sughosh,

On Wed, 4 Oct 2023 at 05:27, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> The various fields of a generated capsule are currently verified
> through hard-coded offsets. Use the dump-capsule feature for dumping
> the capsule header contents and use those for capsule verification.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
>  tools/binman/ftest.py | 95 ++++++++++++++++++++++++-------------------
>  1 file changed, 54 insertions(+), 41 deletions(-)

This looks good apart from a few nits below. However, the tests fail for me.

>
> diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
> index 8e419645a6..2b8871ab7e 100644
> --- a/tools/binman/ftest.py
> +++ b/tools/binman/ftest.py
> @@ -121,9 +121,11 @@ COMP_BINTOOLS = ['bzip2', 'gzip', 'lz4', 'lzma_alone', 'lzop', 'xz', 'zstd']
>  TEE_ADDR = 0x5678
>
>  # Firmware Management Protocol(FMP) GUID
> -FW_MGMT_GUID = 'edd5cb6d2de8444cbda17194199ad92a'
> +FW_MGMT_GUID = '6DCBD5ED-E82D-4C44-BDA1-7194199AD92A'
>  # Image GUID specified in the DTS
> -CAPSULE_IMAGE_GUID = '52cfd7092007104791d108469b7fe9c8'
> +CAPSULE_IMAGE_GUID = '09D7CF52-0720-4710-91D1-08469B7FE9C8'
> +# Windows cert GUID
> +WIN_CERT_TYPE_EFI_GUID = '4AAFD29D-68DF-49EE-8AA9-347D375665A7'

Please use lower-case hex

>
>  class TestFunctional(unittest.TestCase):
>      """Functional tests for binman
> @@ -7223,52 +7225,63 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
>          self.assertRegex(err,
>                           "Image 'image'.*missing bintools.*: bootgen")
>
> +    def _GetCapsuleHeaders(self, data):

This should have a function comment so it is clear what it is doing, returning.

> +        capsule_file = os.path.join(self._indir, 'test.capsule')
> +        tools.write_file(capsule_file, data)
> +
> +        out = tools.run('mkeficapsule', '--dump-capsule', capsule_file)
> +        lines = out.splitlines()
> +
> +        re_line = re.compile(r'^([^:\-\t]*)(?:\t*\s*:\s*(.*))?$')
> +        vals = collections.defaultdict(list)
> +        for line in lines:
> +            mat = re_line.match(line)
> +            if mat:
> +                vals[mat.group(1)] = mat.group(2)
> +
> +        return vals
> +
[..]

Regards,
Simon
