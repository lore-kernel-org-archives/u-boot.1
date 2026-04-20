Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D333EA71B5
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 02:12:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 57D678419E;
	Mon, 20 Apr 2026 04:12:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cZ5QyTU2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3EB438419E; Mon, 20 Apr 2026 04:12:50 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4040683693
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 04:12:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-ba36357195bso276169966b.0
 for <u-boot@lists.denx.de>; Sun, 19 Apr 2026 19:12:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776651168; cv=none;
 d=google.com; s=arc-20240605;
 b=NV3xFlJ+hpQg3eI1LZYiSnc8/DfsZ8MkG0x3JFWHN/FEP90ko3S3DC4pfPx377JKLz
 YHJsUqPPPHBaCq38AAhOHUaYfPK3SkINSJTdeYcacDrNx9mTPxkVdk2galYXCN53BIPu
 bG8sWCobeQd5KjYh9IfOSmp2dZBDtvn+ftKnf0Srqdz968p3skRkTM3VYcOsXapizMBW
 TfHOd7RepVdyD00jsxoaWr2iXRxkbaxpXINT/zmE+bJw00t2hgI5fYIqivwyEcRUrwzE
 746nUanjyjgYaA+NG9JWMNhHdrCJ4MAFw2s2zOjqChLGsru2GwoBwr3CqxrWwB2nyGci
 9Tlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Lf6sO2eakSdUc0/Bjev2o7wT/j34bcgW9FNIOPY9Qe8=;
 fh=Uv/25pOELJ4QfN1/GRGMHMq2DkJf9qUhad18fLjtgiw=;
 b=RTwfDiZBuL/kuqIoQS4FzlzToivdeP5WMsGdy922zpkalvmilQ5kODyv8Xmuv5KRoK
 zERGPPpPYihzjrBzJE2CAIIzjtPMNGBKw25sunbpPT/8C0VfjT0UiltZz0jFB0cLQJzH
 woaQSf5YN6NONfUFh5HCrprihb1lQi956THQuAdssrNbm1qzymN9m2Luo6pOTplQvOvW
 Rbd1Ba5UGexzqz+VRBs0WsS2hEVQoV4XuhGdPE9LsPFtcdOTep3YHG5qiqh8muSJy76Y
 JdgLUj6aFq/fwmCSJFcUuleCh1FaK3z1G5gCwFUyH4itvTbbt7pbJISXt2Q/fAw/jU5w
 HNOA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776651168; x=1777255968; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Lf6sO2eakSdUc0/Bjev2o7wT/j34bcgW9FNIOPY9Qe8=;
 b=cZ5QyTU2V+HPK1hQ+sVxg0z7Y8sNlkDBg/D1rfhwQMUql1vwC+xoZ7d+6YudfVKTp0
 inajM0RscVhYVBSQ5D3PmPXzJmgcreJDV5BjIvCKMU67EakOcwe6TDNyj468MvIYMx6u
 rHp8j8+Z5ukduXs9oDqbTP0P4J+539b+ljer0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776651168; x=1777255968;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lf6sO2eakSdUc0/Bjev2o7wT/j34bcgW9FNIOPY9Qe8=;
 b=a/GFUfjrr2R33RS32BCLLkZOben34TbYf/QZFwrcLSZw+eK4b8moiMyGDDk0/SKQPT
 tXwbhFmpNgTqOSRcDAiyvIv+1HYqR5CA/Xqs35NFhFYnxbxqmDnEgYzmYOmXIe2X7c2L
 5vK5pcqR+JF9j8qoudUXhFf9fieJg1CbEGzvtE6JBewVpRoWaYbR27OdZAD76aIvfqkL
 +FUubAVZGt2avVvXufbc1zwQq6AHDQXw6keudxxVATz0Re32bygDdyEPvTSmWpkrXKes
 MBQOIpWcF9ZE2fxezufC618ie3VNyomiAsQMRrJ5nsGCkrfZz/yHxhV2BT7++JltFmW8
 N5tg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9E34b7HsvoV82wHScaLpUCegZRg56+7V7pcODep7rg+hxZjoKT09rTYnFn6Mpu9Y2et1g8bGY=@lists.denx.de
X-Gm-Message-State: AOJu0YxP71s0fN43BWC81mgAUDqidnHiom1MAGU78/+jYiZD1loW5MXH
 zBsuzVny1vLXcX9uZnNBWO8Uq3yb5xTedCmTy0tmsTu9cGkmqzEKNC5kxfvzRwhl2VRLbyQf28v
 R5SvZhsxQX8dMKM7ghZQgeBChHaEAc/s2IRb1JE3Z
X-Gm-Gg: AeBDiesqGsVbX7ybuDUPiYNsHHp5VBVxMyseJzjtzkl2jivUxjMQjSFk5+QmLk0ujCY
 rXC+L73hIIiIOSWD8p8gdaIfxLO9QD1y7SP8pNyyffPLwM5qUtHrApp1nLp+3novtJy/7xUK5ZT
 YsqE9QpCNYVBU2nxqaODPr/d/wwJzsnmmy+iRoz/JTBUvgukYS6o+n6TXWWShGLJMS8qGKCTqby
 ouasUKJA1jRqs/3j7eK6DWNuiDemexm2xHFdB7N3x8gySCG1eQ3un7frqApfGInJcr5zTrACnmD
 IRQPrcAbd8/OUy8FCA3R
X-Received: by 2002:a17:907:720f:b0:ba8:125a:951c with SMTP id
 a640c23a62f3a-ba8125ad0a5mr42769166b.13.1776651167653; Sun, 19 Apr 2026
 19:12:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260417130204.49896-1-philippe.reynes@softathome.com>
 <20260417130204.49896-11-philippe.reynes@softathome.com>
In-Reply-To: <20260417130204.49896-11-philippe.reynes@softathome.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 20 Apr 2026 14:12:28 +1200
X-Gm-Features: AQROBzBzK-iq4BCCZrCne2qQ399pHpzcDN82GyaigpuAIBveIm2tbiGq9gl-Hj4
Message-ID: <CAFLszTgCN+bNra+XexcAt7j=5W+d5R=u0bi3G0jFemfTDHRbmA@mail.gmail.com>
Subject: Re: [PATCH v4 10/14] tools: binman: pre-load: add support of ecdsa
To: philippe.reynes@softathome.com
Cc: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com, 
 trini@konsulko.com, simon.glass@canonical.com, u-boot@lists.denx.de
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

Hi Philippe,

On 2026-04-17T13:02:04, Philippe Reynes <philippe.reynes@softathome.com> wrote:
> tools: binman: pre-load: add support of ecdsa
>
> Right now, binman can only create pre-load header
> using rsa. We add the support of ecdsa.
>
> Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
>
> tools/binman/etype/pre_load.py                     | 76 +++++++++++++++++++---
>  tools/binman/ftest.py                              | 50 ++++++++++++++
>  tools/binman/test/ecdsa521.pem                     |  7 ++
>  tools/binman/test/security/pre_load_ecdsa.dts      | 22 +++++++
>  .../test/security/pre_load_ecdsa_invalid_algo.dts  | 22 +++++++
>  .../test/security/pre_load_ecdsa_invalid_key.dts   | 22 +++++++
>  .../test/security/pre_load_ecdsa_invalid_sha.dts   | 22 +++++++
>  7 files changed, 213 insertions(+), 8 deletions(-)

> diff --git a/tools/binman/etype/pre_load.py b/tools/binman/etype/pre_load.py
> @@ -27,6 +29,12 @@ RSAS = {
> +ECDSAS = {
> +    'ecdsa256': 256 / 8 * 2,
> +    'ecdsa384': 384 / 8 * 2,
> +    'ecdsa521': 132
> +}

For consistency, please can you use the same formula for ecdsa521?
Something like (521 + 7) // 8 * 2 would make it clearer that 132 =
ceil(521/8) * 2.

> diff --git a/tools/binman/etype/pre_load.py b/tools/binman/etype/pre_load.py
> @@ -151,6 +152,65 @@ class Entry_pre_load(Entry_collection):
> +    def _CreateHeaderEcdsa(self, hash_name, sign_name, key_name):
> +        # Check hash and signature name/type
> +        if hash_name not in SHAS:
> +            self.Raise(hash_name + " is not supported")
> +
> +        # Read the key
> +        key = ECC.import_key(tools.read_file(key_name))
> +
> +        # Check if the key has the expected size
> +        if key.pointQ.size_in_bytes() * 2 != ECDSAS[sign_name]:
> +            self.Raise("The key " + self.key_name + " don't have the expected size")

doesn't have

Also _CreateHeaderRsa() has the same issue.

> diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
> @@ -5895,6 +5895,56 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
> +    def testPreLoadEcdsa(self):
> +        """Test an image with a pre-load header using ecdsa key"""
> +        entry_args = {
> +            'pre-load-key-path': os.path.join(self._binman_dir, 'test'),
> +        }
> +        data = self._DoReadFileDtb(
> +            'security/pre_load_ecdsa.dts', entry_args=entry_args,
> +            extra_indirs=[os.path.join(self._binman_dir, 'test')])[0]
> +
> +        image_fname = tools.get_output_filename('image.bin')
> +        is_signed = self._CheckPreload(image_fname, self.TestFile("ecdsa521.pem"), "sha256,ecdsa521")

This line is quite long. Please can you break it across lines?

Also we should use single quotes for strings.

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
