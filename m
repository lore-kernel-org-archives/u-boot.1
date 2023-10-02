Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA8B0E784A6
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 01:42:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03DB8874DD;
	Mon,  2 Oct 2023 03:23:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GA9+qXxl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B26E9871A1; Mon,  2 Oct 2023 03:22:58 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2588E874A8
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 03:22:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-327b7e08456so887267f8f.2
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 18:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696209769; x=1696814569; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BZrOOEdPEPaRMShsFWWMUhsf62aZzQoC8Hj/uluZ/WM=;
 b=GA9+qXxlO/+G5Y0WazcbmXF5TgUexPOvvDy/mdgAHatyO5+zKC8xezG9UgXqcKcR+T
 pkxiJv/rVsFaykvPph0d4UUplASQS5wgUGLs4yRs5opStIs/4ZRugex4uXSfhwnDIVxy
 9qRxDyXb6PmGC8SP5M4x6ADmwc2YvyjukrVIc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696209769; x=1696814569;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BZrOOEdPEPaRMShsFWWMUhsf62aZzQoC8Hj/uluZ/WM=;
 b=rtJj1DAaK+kdLkJ37qmdmErLBf4sGVVgwUUVg9MXkZZoYQKLh6B/q03MWYyciZ86dI
 1yof+FtBdSBZxVEihDQvHxTMac0wyvFaCFZ/jfb3Ro37v0XXMeJ/hLuBUwLw0XCDQN+k
 ZJX7MMMINgH7eM87ty7cCIfTVb04T418cel1mxUPE6dtkGkAoU19J4hjdvIfTtc0WZhF
 W7Zr9wBTBQ2pDuOplbsY76a03rtrTFHEeu6OXcJz4lPagIZ2cG5btkAZhqWxQkPEza/d
 t9wYC6Le+i9F4OHmOHEhIFEv4zUTpiF1FTAC4jCH7tzht2McDe5FDAKMuk8TWrpMNNGI
 wiIw==
X-Gm-Message-State: AOJu0YxYDyLxup+ihQnsSd21O80ayUbYSGWhyugntB24YihldlB51p74
 vJMIj7YYdfq59oXpuvlsQgAlX3jBV3LWXNaALxZyIlixCBXr5y/7EyU=
X-Google-Smtp-Source: AGHT+IEXA0XL3HYkzgRhvqLLSAWGNT/945z8u06oZXIfpKHcbMkS2VMEx0GKQc8V9OSZ3bCRLk0BtPWnaEvdJx2w1iA=
X-Received: by 2002:a5d:630e:0:b0:31c:7ada:5e05 with SMTP id
 i14-20020a5d630e000000b0031c7ada5e05mr8980199wru.51.1696209769393; Sun, 01
 Oct 2023 18:22:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230926-binman-firewalling-v2-0-b1a084ec634d@ti.com>
 <20230926-binman-firewalling-v2-1-b1a084ec634d@ti.com>
In-Reply-To: <20230926-binman-firewalling-v2-1-b1a084ec634d@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 1 Oct 2023 19:17:07 -0600
Message-ID: <CAPnjgZ3nbg+NQU4CnMUQdwrwRru2AKXwGWNpgXO2cQfaEoP04g@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/8] dtoc: openssl: Add GetHexOctet method
To: Manorit Chawdhry <m-chawdhry@ti.com>
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, 
 Andrew Davis <afd@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 u-boot@lists.denx.de, 
 Udit Kumar <u-kumar1@ti.com>, Praneeth Bajjuri <praneeth@ti.com>,
 Kamlesh Gurudasani <kamlesh@ti.com>, Nishanth Menon <nm@ti.com>
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

Hi Manorit,

On Tue, 26 Sept 2023 at 01:58, Manorit Chawdhry <m-chawdhry@ti.com> wrote:
>
> HexOctet format is used by openssl for FORMAT:HEX,OCT property in x509
> certificates. Add a helper function to extract the integer numbers in
> HEX,OCT format to pass to openssl directly.
>
> Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> ---
>  tools/dtoc/fdt_util.py | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/tools/dtoc/fdt_util.py b/tools/dtoc/fdt_util.py
> index f1f70568cfef..d51dbf5633d0 100644
> --- a/tools/dtoc/fdt_util.py
> +++ b/tools/dtoc/fdt_util.py
> @@ -100,6 +100,26 @@ def EnsureCompiled(fname, tmpdir=None, capture_stderr=False):
>      command.run(dtc, *args, capture_stderr=capture_stderr)
>      return dtb_output
>
> +def GetHexOctet(node, propname, default=None):

What is a hex octet?

> +    """Get an integer from a property in hex octet form required by openssl
> +

You should mention what size property is permitted.

> +    Args:
> +        node: Node object to read from
> +        propname: property name to read
> +        default: Default value to use if the node/property do not exist
> +
> +    Returns:
> +        Integer value read as a String in Hex Octet Form
> +    """
> +    prop = node.props.get(propname)
> +    if not isinstance(prop.value, list) or len(prop.value) != 2:
> +        value = GetInt(node, propname)
> +    elif isinstance(prop.value, list) and len(prop.value) == 2:
> +        value = GetInt64(node, propname)

What if it is neither of those?

> +
> +    hex_value = '%x' % (value)
> +    return ('0' * (len(hex_value) & 1)) + hex_value

Can you do:

return f'{value:02x}'

?


> +
>  def GetInt(node, propname, default=None):
>      """Get an integer from a property
>
>
> --
> 2.41.0
>
