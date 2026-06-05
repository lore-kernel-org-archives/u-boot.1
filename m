Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C241DCD6E79
	for <u-boot@archiver.kernel.org>; Fri,  5 Jun 2026 12:51:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43238848F5;
	Fri,  5 Jun 2026 14:51:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="fVulvoFV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96B818490B; Fri,  5 Jun 2026 14:51:45 +0200 (CEST)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 644AB84879
 for <u-boot@lists.denx.de>; Fri,  5 Jun 2026 14:51:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-8cceb2ecc03so15451486d6.3
 for <u-boot@lists.denx.de>; Fri, 05 Jun 2026 05:51:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780663902; cv=none;
 d=google.com; s=arc-20240605;
 b=c2jdrhPOPvkmBn+gX8P/BYJYWvIL71hCPDsI1Pk6JMQlt5WizF64OluaJwLvy7VXyi
 9Si9DbWWCtyeKrhDirYkk/QASG2XfkbpeeLV2cRkvMcc41I4raaIK/nNr/grEUlDPN0h
 pfNLQG2RkkXLxtIsejn669GWIO6KA02Ysw+9tq2Yz5MdvRvx/gy87GI8F5so8Texn74l
 QybDWkZViYlolUx82Jyl1B87r7hMgixG9feAlCc3gTKEJPV6jXrKM12Z3/eW0qolnd1Z
 E5f5xCObNPpBW59tMc6NHUlkmWM8tOqbB6/0WzprV7aA9O95bHxNL3jmjoi0elkPbEp9
 w/Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=bcjugRmxe2gWleAiakhIaHW+nZbytyoIQkrYLuBfYsw=;
 fh=pBLyCMePk/vY4OUijzYT3sqeMRG6XeUGmGrP0Cq9Cto=;
 b=GTslDTDKVlZrkB/Kp5RVXdXQoxexqQe0b5mz8c8IPhWhrkZ/4wLwRxKmyA/+vPpN5g
 kE81ZS0ot11cKY0lCb+nH8Lyi+Ga+64HVpGi6VVtRu8Jsm7SlwOzC+Bjnq2N5LEsfQd0
 f/GPQ64E/8AcuOMmfKSfMAPCVXSvGSYdnJMDDOcQJZC9Scw7BJb37W5p/REhzigkCQM2
 p3Te7MHSEtMq3u/uRk/eSPZrLNhol3/jfrmPPSv6+uX1f6SX8VR8e+WzCmm6NnQTylW6
 XY4LWKI+OpTW3MnKEv/kjBgtfU5aYtAflPl54Idk9af8G6Tj+TJW4AF7u0T40TJfIuEv
 irMw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1780663902; x=1781268702; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bcjugRmxe2gWleAiakhIaHW+nZbytyoIQkrYLuBfYsw=;
 b=fVulvoFV1VIeJPaMy9swUb/RcoQXWgrv4t0o81FmKzqLN3dGV/CAZ+G7m2wc3qkj1c
 nXc0rigba5ZeGqctInnrBg52/c3TQuKH3tijNxnq7Kiegix4E331PRDwKY81oo/wB0RW
 aLT/aZp5yMs7N2o5wrEwg0XMr1klHu8Vp0GzgVz1WdWrPW2WDX+llRE/v8zrZ94ejAgu
 vb5PaowR7+KYFO4eaaFRUpYvk0/DZpTnsnZ9K1qHn+ZNAcA8laNJty2aPjeIHr5nWf8Q
 yS6SZB4X8sLaqYJnxO+KrlZeW75UKkeLLLCU9VkkN4kT5ewPH9JztMTyz/k6PWH8BSbv
 HUVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780663902; x=1781268702;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bcjugRmxe2gWleAiakhIaHW+nZbytyoIQkrYLuBfYsw=;
 b=JGzxBZbrysW5eMK39rWlxXdF3fPjakvf0J/NFIhK/+Z0uE2L40caj+72tP28MpMfLG
 YjAh4UfJaAzc+4PXThYHLb2qshvnHByP5dnVxIrvj0vnLl3g/wXCzv8WhnpHHWf5ZNw4
 L8KckwAqvaM+MOseU3vsuHcGYGuzZiLiIB/hNC6VqUsAoycE5NsAgmWy3F8cbdNTIJSR
 AM5Glix8945zdTAk2+9ae0q+b5q33IA+xiZELfDpfmbaDu0boxDWEDXMLvHA5NQ3wfTw
 MKMk1wqwyIzfvIGxCvJNWvhPIlOXa1MuYSsBeykvPKpN/e4UMgAUzUyOB7XecT57kAap
 ZNBQ==
X-Gm-Message-State: AOJu0YyVIabLBsmB2KRThtibcmfyRDPGhfqcLRphZurFX7wtOvKif+n4
 n770QhcgB0saHTqXhdB6BPyxSZxxFkjGmBiW+zm3lW8gNe47N8UxFp+tHTrGZxYwuJRlr9OamK6
 C1Cd+F2ypbcxL4s7KBvpYdfcMt4fAntH9C/bVR8pJgQ==
X-Gm-Gg: Acq92OEOHqgYCEFzj/1ARtkXGm7Ol/Zb0J0S2IwiCScnp+IZxD7EFxtUNnzNdyp9LvL
 QR+QZP3jle56TIbPQWVVo94Fty9fsGX6cKo7m4BoPzayboe84Xf6ceSAfhesiDfwnEEnIxxkAJJ
 jeW/hxEex7onTUOyYs8JuQnoyGhJGLHqp3/neOXbtP0K+LYMypi8QE9E7dk96/KtpMxCdPOhkGb
 dsZobUbNvInk3LgEyVIytZU+Q/SwrAUmJaCMQycbNDQzHz1mOaf1sJdWn+AGfkDDfyKmzoDgeYv
 hsHVlGlKy0Aecw==
X-Received: by 2002:a05:6214:301a:b0:8cc:f0e0:f90b with SMTP id
 6a1803df08f44-8cee629be9emr54569166d6.40.1780663901835; Fri, 05 Jun 2026
 05:51:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260602162233.2418471-1-rmandrad@gmail.com>
In-Reply-To: <20260602162233.2418471-1-rmandrad@gmail.com>
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 5 Jun 2026 14:51:31 +0200
X-Gm-Features: AVVi8CdzH9Mo_wmo2uL4XI_j_iUz1DrTBUa2pl-OLFrSL3AYWvdblQ0ms1NLsl0
Message-ID: <CAMknhBFeV8qio29t1zNhoBNdumbWh2ErOE99dQEphDKZN8GodQ@mail.gmail.com>
Subject: Re: [PATCH] arm: mediatek: mt7988: restore full DRAM bank reporting
To: Rudy Andram <rmandrad@gmail.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com, ryder.lee@mediatek.com, 
 weijie.gao@mediatek.com, chunfeng.yun@mediatek.com, 
 igor.belwon@mentallysanemainliners.org, jstephan@baylibre.com, 
 GSS_MTK_Uboot_upstream@mediatek.com, emanuele.ghidoli@toradex.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, Jun 2, 2026 at 6:24=E2=80=AFPM Rudy Andram <rmandrad@gmail.com> wro=
te:
>
> MT7988 detects the full installed DRAM in dram_init(), but after
> commit bddd6bbef3dc ("arm: mediatek: mt7988: drop dram_init_banksize()")
> it fell back to the generic dram_init_banksize() implementation.
>
> That generic path populates bd->bi_dram[0].size with
> get_effective_memsize(), which is capped by CFG_MAX_MEM_MAPPED. On
> MT7988 this limits the exported DRAM bank to 3 GiB even when 8 GiB is
> installed.

Can we just remove the #define CFG_MAX_MEM_MAPPED (and the header file
that contains it)? Or is it used somewhere else?
