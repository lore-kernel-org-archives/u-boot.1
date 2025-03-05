Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7220C282EC
	for <u-boot@archiver.kernel.org>; Wed,  5 Mar 2025 14:17:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56E7E812D8;
	Wed,  5 Mar 2025 15:17:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UMqdnOiV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F09D81253; Wed,  5 Mar 2025 15:17:15 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D3FA808B6
 for <u-boot@lists.denx.de>; Wed,  5 Mar 2025 15:17:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-abf518748cbso796405166b.2
 for <u-boot@lists.denx.de>; Wed, 05 Mar 2025 06:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741184217; x=1741789017; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xETeRPZnVw9L82wifknHaXFHVtwj16w/Z4woug5A4Ow=;
 b=UMqdnOiVdu2pla1vpr+hOpJ83dLrSl7gPtj0lJ1p5mguqL8CoXdikRAYxHeyieFko2
 /gnkOgjQ70nRkzNkuuLZIHXZHk9ge4xKW1QXYkWnXMF34RJVoegrdp2+IR1tJTrDkpzb
 lU4nFWOPic+yud8mhjg/oYDRY/bpWSWm/IpNk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741184217; x=1741789017;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xETeRPZnVw9L82wifknHaXFHVtwj16w/Z4woug5A4Ow=;
 b=oNZq218N9J1LtMoiDUDDUYJyigsfIMv0mgZNy0+I7qVarAyThJTpfaCT7c0tf/g2Ck
 uwZhR0929Y+mb1gChfgETGc/RclWVpikXSgmxWlAxPFtvZFM+ybLqHw3oEE6mWDJZu3y
 kW5yLgSHw3zfOTYlvHgGhFfGwsjK6s994DUoalpV/+Jh9Ys7WCxYncOOjaBVz37d7BvP
 1t6rr4ZYgu1EN7BK6l1qevEp4hoXV42zu9VDej5giWW52WEZHvV1saFwRwuvrS17FPsc
 QZYyi1J/NRkR6D6fV34wSyYKDLK9ZKsn/HhV8j23OJdf4QhNlZ/jS5c9T9/xzfXGb6Rg
 lDlA==
X-Gm-Message-State: AOJu0YwkebGLm6w3hXcb+dqKDz5SVVhDsPlGTXhL4Aoq2Z78Kcrzuxo7
 2qix2+vwjlAQuutEIglCcKMWmdoakOoDz5bTfOqG5kTvRWhZ1PXZlnqFzBB7z6akYa8SDAz/bU3
 G4iON2yZXnt1/mbrMjn8EOOVcvgMXaCuYmfnt
X-Gm-Gg: ASbGncu8lY5v6GUX5WXSfD8lLcXycGkalcsiFy8y0TJx+zqMD+hVu/C24WUuQw8fHV3
 8hThjuaMGTgfyJhB5BCeWrpBEVgTZvMwas85AGTJFwguH1Xq2g3hgmSfeiLhlK/hIqmnHYjJ2ky
 qv1LrGtv7bIbn2ai6xdiFvKb6iOXs=
X-Google-Smtp-Source: AGHT+IFt6F6V/qezqLLlQ0q3DAexACBHIChj5N8zJhLQkFkAxC3CX3dfH03YjGk7f8Lbb9tExN4HqMum3zZSDRxUf5c=
X-Received: by 2002:a17:907:3dab:b0:ab3:2b85:5d5 with SMTP id
 a640c23a62f3a-ac20dafe7b2mr315898866b.49.1741184217239; Wed, 05 Mar 2025
 06:16:57 -0800 (PST)
MIME-Version: 1.0
References: <20250224212055.2992852-1-paul.henrys_ext@softathome.com>
 <20250224212055.2992852-6-paul.henrys_ext@softathome.com>
In-Reply-To: <20250224212055.2992852-6-paul.henrys_ext@softathome.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 5 Mar 2025 07:16:45 -0700
X-Gm-Features: AQ5f1Jpec4OO0AZWKX0zQZ7Z0IY-LuIReMyhnMN7cfAoVPmaN0iZEdYtqlB9mRs
Message-ID: <CAFLszTiOyOmCHXQioJHoSh+bjoVmH7sot9JvcCdss1ib99ZCTQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] binman: Authenticate the image when testing the
 preload signature
To: Paul HENRYS <paul.henrys_ext@softathome.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com, 
 paul.henrysd+nodisclaimer@gmail.com
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

On Mon, 24 Feb 2025 at 14:21, Paul HENRYS
<paul.henrys_ext@softathome.com> wrote:
>
> Use preload_check_sign to authenticate the generated image when testing the
> preload signature in testPreLoad().
>
> Signed-off-by: Paul HENRYS <paul.henrys_ext@softathome.com>
> ---
>  tools/binman/ftest.py | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
> index a553ca9e564..8cf867fd3fe 100644
> --- a/tools/binman/ftest.py
> +++ b/tools/binman/ftest.py
> @@ -762,6 +762,16 @@ class TestFunctional(unittest.TestCase):
>              return False
>          return True
>
> +    def _CheckPreload(self, image, key, algo="sha256,rsa2048",
> +                      padding="pkcs-1.5"):
> +        try:
> +            tools.run('preload_check_sign', '-k', key, '-a', algo, '-p',
> +                      padding, '-f', image)

This should be handled as a bintool - see testXilinxBootgenSigning()
for an example.

> +        except:
> +            self.fail('Expected image signed with a pre-load')
> +            return False
> +        return True
> +
>      def testRun(self):
>          """Test a basic run with valid args"""
>          result = self._RunBinman('-h')
> @@ -5781,9 +5791,14 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
>          data = self._DoReadFileDtb(
>              '230_pre_load.dts', entry_args=entry_args,
>              extra_indirs=[os.path.join(self._binman_dir, 'test')])[0]
> +
> +        image_fname = tools.get_output_filename('image.bin')
> +        is_signed = self._CheckPreload(image_fname, self.TestFile("dev.key"))
> +
>          self.assertEqual(PRE_LOAD_MAGIC, data[:len(PRE_LOAD_MAGIC)])
>          self.assertEqual(PRE_LOAD_VERSION, data[4:4 + len(PRE_LOAD_VERSION)])
>          self.assertEqual(PRE_LOAD_HDR_SIZE, data[8:8 + len(PRE_LOAD_HDR_SIZE)])
> +        self.assertEqual(is_signed, True)
>
>      def testPreLoadNoKey(self):
>          """Test an image with a pre-load heade0r with missing key"""
> --
> 2.43.0
>

Regards,
Simon
