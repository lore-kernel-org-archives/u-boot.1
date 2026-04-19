Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AD1BEA7188
	for <u-boot@archiver.kernel.org>; Sun, 19 Apr 2026 03:52:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A40183B99;
	Sun, 19 Apr 2026 05:52:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="K5iQKMz9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 634FE83BC8; Sun, 19 Apr 2026 05:52:22 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B4A2839D9
 for <u-boot@lists.denx.de>; Sun, 19 Apr 2026 05:52:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-ba699316b42so46120166b.3
 for <u-boot@lists.denx.de>; Sat, 18 Apr 2026 20:52:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776570740; cv=none;
 d=google.com; s=arc-20240605;
 b=NAGSyKjVEl3e9OuFXXKtB8NmsbyMZqT5NsGP3+isdh2oesz42k0697gls1536BtF3a
 kJZEihlS2SOBc3GZVpIHihKzfPgLaSsCllqejhIlPjXhRCtIY5umyfaIasUQ3ca7C7oe
 s5EVob+z1O2C1to6ktW8cYSDylVNxDFAG6wfX5GXpZZlSgME6vpHOQlSlCukKYvZHAES
 0Wg9E+YPdOu7XkzKwOcRs9OtjYUpKeOrHTiKvYV7Ve/lc+F2ZiiB0yPotb0WKYADw9if
 eARY29CZSSyJzKmulAVmKgVAk383MOYsiiIKO4mD5P6VumbUMCg5A2COCSu/6ZYPp8bj
 x/pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=5nlBR4SVNRdOMZBkZej1xo7bJ6p9cAkwBWBFIeWI9YY=;
 fh=7mWJvHRO8nLQEZ6tApC8Xy+dl+nkSNd90hlylQleSmw=;
 b=IoPeLZed0TRtkin8LSp6K9c1ywFutteF0ap4tj37Eiz1EMPdNgQ8zfP5VZBOk6DQ3w
 eidiabr/TO0Iy8dJ9OSTA2X6FyXDkTQSEs/uv0FKG9mSBLM15mq/fqRbHKTF5JbeR6sU
 U7wQjpLtzpNE+2JcTEcjVgdL+Ey51wNbsEhyVuyJ3ZmrHP8aTW2Tx8I7kNQG+DyMiTID
 qjui7we4vU06dOgmLbNmZ/5ZLoCmh7nxCnOwXtnGsgip5gCD5o7uf9ZVcWQ+lhB9CWoU
 1eKKVrAuReoPZq2esgHZE0PMmlJ8WnrPDR5aaJFzKXDKKDF89AoAvpinBiQVb7RxYlI/
 Lf7Q==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776570740; x=1777175540; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5nlBR4SVNRdOMZBkZej1xo7bJ6p9cAkwBWBFIeWI9YY=;
 b=K5iQKMz9rWWAa0bwYQoODKn1qzBTJfT2lQwqiEzb6983470JAUpkWddyaG6/gJjdbF
 CefZLWLSBfXghLNdxjA1KofgfrHJhAQFqFINu96/Dd2mYB+Ybq9AFiwlhH/PqIQecqsQ
 7Oovl76ChKAAQneKkjpI0x505h/rs7b5/RvN8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776570740; x=1777175540;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5nlBR4SVNRdOMZBkZej1xo7bJ6p9cAkwBWBFIeWI9YY=;
 b=A76uQr0++OOE/dtmub0XJjDBt+mmS1xdNoVUnYSmiqkg75uR5zFe2KhF0dWgX3imYg
 GdvFqVXGhT5qo4JxUGQFjlLsnerM6w3dL8qRVpnJbz5tVqDh1Qa8eV0/VUXlpvtisJKO
 nYhtItf9a9ScYMDo4ivs0W9bXPB77Ae3k5Vgrefz2WmenAVtzyYH3cVxCn6JrRnp+Di1
 5nfCwmo47xbngBcKmgRvos7936VrpMw8ub18bl4g/bY4u5fsLPFLKcueP6Sv+m0330uZ
 K8+QF+My75e6rtn24quntx7GIaF+APh4dd5uoUSRTb9vWVftGl1Y5JLmewLM2SkYPRis
 fpRg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9oPxMHA1RlNi6V65AQMnIlof4SysYWqIk917f0hiQGlZDBLWkvMzEPELqhpe4tqrydD+5f/lE=@lists.denx.de
X-Gm-Message-State: AOJu0Ywus/IEiIDMFRJ3/zF84FkzbofrM3WvTQD0nG+8xdeLLOca0Z1h
 eEqSF0kA/kxZx6bP1Yr7wVdDANF2YGVGV6JNga2Yoyec25jOMysjpP9AtmRxSp41WfOxtiduhcC
 30xyfB8SsZu8J3MbKXtfNcCcWIS21Fblg+Y+nE8aU
X-Gm-Gg: AeBDieupQnLwNSvROAF+lkMz1SAmtHAuwMoW+I3ZnkujdV/7+FNaJLL1lr0jAOuYvq7
 bDtoIyN+Tgnqu58oUxSlwYRUkOtS2mkeXNKp4YUp0WTbEpR7jbSCFzygjsFQlpPr5O0fSyb0jmK
 ZAp+qQu/Zhkmzo7n2QEhAcKjzaJ/0gP5v9VFhGLd1+kPnBTLKG/QopnOxoCfnFn7TO6RJF4ZXVK
 Hldl5d9xwLDuEGep/GHg2ae8DL16uXHZkm11j0feBnwDHOuIxC+tuIymL5KBqdONRIiPz23f8+E
 RUbal6vMyLu1vHpLBFLM
X-Received: by 2002:a17:907:9446:b0:ba5:a3a0:4a5f with SMTP id
 a640c23a62f3a-ba5a3a05c33mr170227066b.8.1776570739768; Sat, 18 Apr 2026
 20:52:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260413203555.1990337-1-rs@ti.com>
 <20260413203555.1990337-2-rs@ti.com>
In-Reply-To: <20260413203555.1990337-2-rs@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 19 Apr 2026 15:52:08 +1200
X-Gm-Features: AQROBzD7axnoUWbl3hFdVqHCBcn-mfxQlj8eZQzDTJJRzn7qUeZsX6z8HG9lrKQ
Message-ID: <CAFLszTgr17fYy=21eX7rZzV_ihcc+ZDssRsWtF+LbH-jtCUCaw@mail.gmail.com>
Subject: Re: [PATCHv3 1/6] lmb: allocation flags macro documentation
To: rs@ti.com
Cc: robertcnelson@gmail.com, ayush@beagleboard.org, 
 Erik.Welsh@octavosystems.com, anshuld@ti.com, bb@ti.com, trini@konsulko.com, 
 afd@ti.com, xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, 
 u-boot@lists.denx.de
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

Hi Randolph,

On 2026-04-13T20:35:52, Randolph Sapp <rs@ti.com> wrote:
> lmb: allocation flags macro documentation
>
> Update the allocation flags inline documentation to follow the kernel
> object like macro documentation.
>
> Signed-off-by: Randolph Sapp <rs@ti.com>
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>
> include/lmb.h | 30 +++++++++++++++++++++++++-----
>  1 file changed, 25 insertions(+), 5 deletions(-)

> diff --git a/include/lmb.h b/include/lmb.h
> @@ -19,16 +19,36 @@
> + * LMB Memory region attribute flag to indicate that there is no special
> + * requests for this region. Normally used as a placeholder value.

there are no special requests

Regards,
Simon
