Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 578F1C43458
	for <u-boot@archiver.kernel.org>; Thu,  9 Jul 2026 19:15:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA52A84C15;
	Thu,  9 Jul 2026 21:15:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IWeY4J6q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0EC1A84C17; Thu,  9 Jul 2026 21:15:22 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3320384B3B
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 21:15:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-698562f10e7so239575a12.0
 for <u-boot@lists.denx.de>; Thu, 09 Jul 2026 12:15:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783624520; cv=none;
 d=google.com; s=arc-20260327;
 b=g0OZ/bgT2AJNc9fRDQE9bz207+pH0v6MagHCUIHlacmrH2iyN4CpocMiOfhHlu8yVo
 muZOQb8fCDz0ZKIfl9FUKzVpkwr06E3Pm1Z75iXDessXFx4UCnxLNxQhdr2xDuYBfITG
 igqEguUzCt0kMuL3KiCFfAqhqNDOnXc8OzufeYkHXvd+ICILExOMQDvWrWkW8fkUABiJ
 Lky0rtXMECknfmN1xoCtcvWXJMrsepE3YX0IeR2QpBhtJZid9LgTSY5I5kNdD4+g7H8U
 /WNfKSyYP98xhZYQZwucjue7oFtOXMMpXp8V+IBXgFJGHIHKLQVuRI1mvWI1r3gAzK5n
 N1mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=BB9E4ZQj8uuK+VSy/sfY/1m54W4qdLxzUQ5+hRaKgHw=;
 fh=cX2a5uS3m9+hU+YaZez7ihgAHbtevX6/NcttqBcYz7Q=;
 b=nDsKVz6DTdy2PjVp5TVweH084I/DS8dJeBmlxyazQTjr5oq4xW+4FyL4T/mk6MDQVJ
 PTP4SDWKrVnrLnxYt6T5nzaFolyrjZXVl5QgrrEBeu7e1LKSmW0KbP2UkLR4Q6Q/3A2Q
 KqE/p2bQ1CVz5QBrwaA48RxYNG2a/zT5rjlXJtYQeR4qJnjQtp+h7b93etDZR/zDEQtm
 4v52zHCiexrXagzAPAq3taN2GRU1/c/o8DSjI5OcOQQvOio0VksyNJp9BeLn8Bf6qwHi
 s42cIKZtYP+uVp37DwCKB4OVDlyYckBi1m1gFZOKvZ9czWm4au4F6l+8TB9H2aKtfONT
 iDvA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783624520; x=1784229320; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=BB9E4ZQj8uuK+VSy/sfY/1m54W4qdLxzUQ5+hRaKgHw=;
 b=IWeY4J6q4Pxv0mFPkh531SEXXfqRlORPQYKsZl6Yz/mm5VZoNq0nmc8Hu6XdemlVqW
 QGeMaY/wwOeWIZU8hUYAEbtj8Dsgxb4+Gio38WwdsZ+eJJ8CLRMfkpdulgOGcV9wjrsj
 M2r/g/k/rS+LHpFBlgK0aMLXCxspa70JQTbJU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783624520; x=1784229320;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BB9E4ZQj8uuK+VSy/sfY/1m54W4qdLxzUQ5+hRaKgHw=;
 b=W0hdc/KXpILvdgZ5O6JZGFPO/RGhsVndy2InvY5rPzykUsLePMWmLWGWfi2u9awbLD
 8bsvf6hgYLJsc2ddYz4GeBFzP5dfZlw9NwmYUxSC8llPbry774d5A0EPmI42zj0fdiq6
 uBHsEjwqFP7tQe5xtveovRbdSXVz8hcdiglsKJsiod9Pk/1+3tJCelvvMaGa/3J5RKaH
 Y4p02oAAbN8vpFDwHMYXsAFqshsam1+i5knasF02P6zK6sVMR0MLiLIomo5RAkoTRyYa
 tcAPml/pwijYjliv2WFxNbMSqBXGnIpxb3s59KEDTfwj2sFHnfcSL77nvqmG55AZS+ZS
 Jheg==
X-Gm-Message-State: AOJu0Yy2E2ZymcBN4LKf6Aecwl8Fa8zuBf8rKuAQOlS1LPQlTly5y+2b
 6D9RPhPBUrFkkJi6nn768oqPIH2+iIqlBAiaCzFIu65yqkKhoPeyO7ON3dd4wVxdUgZPWZApSAa
 1eI61TFvCi2PQ2PM6TUGBSfu3unsFE4i9hQChflQ1
X-Gm-Gg: AfdE7cm9IDPxxcnp0LDBPnWID83MFmzS3kpTzSaGVS/3RgO0Sl++gkaEC6xZJgnHmdV
 RvtjtcCuK5uldy74s0L4tS9cSBYs4h1+i6vCpL45b/35122cPKN0Z9UJd7q0LpjcU4YPlbGbl8F
 1nWBYHf5zm63DOCi3kRtw0YCURInU5DgO81TP/JuAXN7bE5rkdW8s2MS44lluyZU3DxjE9tArFj
 GdCbSWLQx7nxdsnbDobU5nkpLXLf9/GVwJNm7s6oN/Af1c/z7iniqwwtXeIcja5Esmq0Yc=
X-Received: by 2002:a05:6402:43c4:b0:699:e496:8711 with SMTP id
 4fb4d7f45d1cf-69ab449f84cmr3560759a12.34.1783624519684; Thu, 09 Jul 2026
 12:15:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260703-dm-core-v1-0-076d395bded4@nxp.com>
 <20260703-dm-core-v1-1-076d395bded4@nxp.com>
In-Reply-To: <20260703-dm-core-v1-1-076d395bded4@nxp.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 9 Jul 2026 13:15:04 -0600
X-Gm-Features: AUfX_mwscrflgxDraFduj2odCC2WFWPNkr0y1L3t5XRuTYboOWxdGb0NstlzCY4
Message-ID: <CAFLszTjppbc1zh_9OM0XTwLjNdvi0k5LocZMmY4Mc1bMP1dYNw@mail.gmail.com>
Subject: Re: [PATCH 1/4] dm: core: free fdt when fdt_create_empty_tree failure
To: peng.fan@oss.nxp.com
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, 
 Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
 Rasmus Villemoes <ravi@prevas.dk>, 
 Casey Connolly <casey.connolly@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Romain Gantois <romain.gantois@bootlin.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Markus Schneider-Pargmann <msp@baylibre.com>,
 Yannick Fertre <yannick.fertre@foss.st.com>, Peng Fan <peng.fan@nxp.com>
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

On 2026-07-03T09:11:23, Peng Fan <peng.fan@oss.nxp.com> wrote:
> dm: core: free fdt when fdt_create_empty_tree failure
>
> If fdt_create_empty_tree fails, the malloc-ed fdt buffer is never freed.
> Add free before the error return.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> Reviewed-by: Rapha=C3=ABl Gallais-Pou <raphael.gallais-pou@foss.st.com>
>
> drivers/core/ofnode.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
