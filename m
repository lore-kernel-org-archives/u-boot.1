Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32B3FCD5BDE
	for <u-boot@archiver.kernel.org>; Wed, 27 May 2026 01:18:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ABCA3848AA;
	Wed, 27 May 2026 03:18:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ETEUpOFn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2F7184908; Wed, 27 May 2026 03:18:06 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5FE9884869
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 03:18:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-bd8f9889a8cso1324257566b.1
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 18:18:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779844684; cv=none;
 d=google.com; s=arc-20240605;
 b=i5UKCHglMUtFWgJugaAgDU0GIDbyoLaIumWvzJJQkOPvFjDkYGcAI4mxj1taRo2Ahp
 TDGFE7CwO/DqT46ORR1jSxJshU6sRRWGefbMFNoY8vjtiHDjYqwC05cUFE40Yq945nfC
 +XalJ1Jk8du8F2cTPo1+KAS1E4XkV7dsTl4fuZUg6b10C3eUsDEVrPKIp+xZzjkDoPFf
 qX/ak43ca54Yt/wYMen0QdTfz/3TZ7TX6E3KfMb5UVfx5P2ubK/z36Lrez2PowK20k6w
 KwSbhXLttHN1TEcHnSlfLRLtWYNIcg/R8+D05GAdX/dh4BNQFT0R218gmsnfoj3N+euF
 cbow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=005ZUHMEWgLT4A0YDW3gOBvIfxbhNRgQzzMQvuxvR04=;
 fh=7HzJ9BBBx4iZa4XdRLXOksY74UmWuqL7h1CjcfaRqlM=;
 b=CaBIqpU/VYmyOnaROHd9Mj/MdcVaeA8OAafws9GebaWT/S4e8LUx9tKMCxnzDCb8p1
 u6vndxEBw1+1c/Hzd62yi50nzatDuKLFvZZEBVD61XtPDh0iMZLSRIaM3Z6iSzGPDQMw
 N7Libzui06hkzeZR2elXPuQh3Dp/fMVgJm4acDQuE6D+uOI9r75VMNGDKMs29jDvwJM6
 9O87jZHNefBXTGVag8DB8QFU2/mFc3Q+a5U+mi1+oISZ0k62EwFYt/ULxlSK4OZh0EVR
 hBeDYfzM0YCPi5moimB6h7n2wjFAZqqeoiMHDhxgZrndaMDSDir3cf1dLUzQcAtMnjEv
 WUzQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779844684; x=1780449484; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=005ZUHMEWgLT4A0YDW3gOBvIfxbhNRgQzzMQvuxvR04=;
 b=ETEUpOFnm/kZBsfbdmGDCIaxmZgwFPCWSgcfMgeOkgLZn1E7ZMPNzPkMIqzL1iAt08
 YdigEI6zLFpQKgVf+w59hLkbx+1oTTB1fvsWtXiCPKOv1gAEWdKsbSTRnrdwDk295B5U
 31CbMxl1mPWR0FlTMnCwObm7pgmq8HEPh48h8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779844684; x=1780449484;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=005ZUHMEWgLT4A0YDW3gOBvIfxbhNRgQzzMQvuxvR04=;
 b=bnbBdZ6zmL//vJRvNJTPIEA/V0FAWdctENBW026uvgilRXfKtJqfIcBiQajKJUhrtO
 I7VsxUsm7jyrEzAad+0E6WsiHDBq9scYhL1kJ0tMEjzsd/T18Mc8C53v0mS2dX7c2Ue5
 HRb5eq5FMgdtUSHVLz8290iFAegWuZZyCyRF+X75g/+BRNlxonALTTWQeOc0T8MMrAbR
 ohunBM/n/BSbPr0PjtAVh93i3S4FZOL3A842VjAOC2CrPIQDBrwcJ3oYHIneBqTlyycz
 /y8Hekk0evN8iLpTUovlILfStkQ9mSm2DVAdfsVgxKhY1rGyGhZVdxeQbPEvQY1+DFws
 ApOg==
X-Gm-Message-State: AOJu0YwtjdtMcpzXcCuGGkGn4ovt+SRWFBlx97ROtdR4G77Vu+3ninvh
 ipFJrw/NW9vyZKechkC0KeGPVGqbvIMKuDxKxpnckqDJvazQgs+vs5LZ5nHfw+SohVZqRH9040r
 JgZ/ZGxo/jVhzrPAT+4V3or8lZ1vzqiD6WEFimnTjQ/zV0yP8VxEKb0nPcRC/LX+t
X-Gm-Gg: Acq92OGmCCEZLgA7yTsTIpkK/Lb0LZR02PdGYsaEq5UCUi6Zp22rYLog3G3Kr9x7X/s
 naM+aRbb2mh5+e3vYbp8d4bRMfXswBby8EipWu7gEN7LThiS7bPu41BNO4yvDOtpAzNFF5WA7sH
 7EIg0H4UI+vDTg3QRjn1DrcL20DJ5mDhRV3pzrbho3k8E4Sn+4pp7+KysPXV9QFHUsn/PiiyFKM
 n3p50qkt3iADh8Gaz5SE7exK8DNk0qdrMJlcRY2LisNssTAAUBHIyQW6hS75K6wHb47Cy13j2qM
 ZoeDZ+tsY5Zci1Vk
X-Received: by 2002:a17:907:78c:b0:bae:8734:18b4 with SMTP id
 a640c23a62f3a-bdd23600037mr1199821466b.16.1779844683815; Tue, 26 May 2026
 18:18:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260526-devfdt-net-v1-0-be3597b85b5e@nxp.com>
 <20260526-devfdt-net-v1-5-be3597b85b5e@nxp.com>
In-Reply-To: <20260526-devfdt-net-v1-5-be3597b85b5e@nxp.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 26 May 2026 20:17:44 -0500
X-Gm-Features: AVHnY4JOP4Rc3lp2n0b37_poc8blP_x4kMpd7QP1ijEyvdlk2s5JI9tLJv-IdFk
Message-ID: <CAFLszTgtWYFe5_u81dS2e32vaRM9hUmk_M3C+v5C+QNH9D89nw@mail.gmail.com>
Subject: Re: [PATCH 5/6] net: mvpp2: Use dev_read_addr_index_ptr()
To: peng.fan@oss.nxp.com
Cc: u-boot@lists.denx.de, Jerome Forissier <jerome.forissier@arm.com>, 
 Tom Rini <trini@konsulko.com>, Peter Robinson <pbrobinson@gmail.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Heiko Schocher <hs@nabladev.com>,
 Simon Glass <sjg@chromium.org>, Marek Vasut <marek.vasut+usb@mailbox.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Rasmus Villemoes <ravi@prevas.dk>, Peng Fan <peng.fan@nxp.com>
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

Hi Peng,

On 2026-05-26T07:25:09, Peng Fan (OSS) <peng.fan@oss.nxp.com> wrote:
> net: mvpp2: Use dev_read_addr_index_ptr()
>
> Use dev_read_addr_index_ptr() which supports both live device tree and
> flat DT backends, avoiding direct dependency on devfdt_* helpers.
>
> No functional changes.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>
> drivers/net/mvpp2.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

> diff --git a/drivers/net/mvpp2.c b/drivers/net/mvpp2.c
> @@ -5346,8 +5346,7 @@ static int mvpp2_probe(struct udevice *dev)
>       if (priv->hw_version == MVPP21) {
>               int priv_common_regs_num = 2;
>
> -             port->base = devfdt_get_addr_index_ptr(
> -                     dev->parent, priv_common_regs_num + port->id);
> +             port->base = dev_read_addr_index_ptr(dev->parent, priv_common_regs_num + port->id);

Please keep the wrap to stay within 80 columns:

   port->base = dev_read_addr_index_ptr(dev->parent,
                                        priv_common_regs_num + port->id);

Regards,
Simon
