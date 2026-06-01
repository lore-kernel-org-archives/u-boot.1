Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F06A0CD6E55
	for <u-boot@archiver.kernel.org>; Mon,  1 Jun 2026 14:58:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D3178494D;
	Mon,  1 Jun 2026 16:58:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JhF/H1TE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 108B884956; Mon,  1 Jun 2026 16:58:50 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35B758493E
 for <u-boot@lists.denx.de>; Mon,  1 Jun 2026 16:58:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-bed4cc46252so167084566b.3
 for <u-boot@lists.denx.de>; Mon, 01 Jun 2026 07:58:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780325928; cv=none;
 d=google.com; s=arc-20240605;
 b=TSQGQrcSGn2gRrXf+mNKP7TNMSCY/8wSRNF8D6Drmq/NtvINXUwzqq46aCgd4FMie+
 BIU9MBgbb8cjdyIQWNmaT1VssZ0sdFpyhKU/nZdG8EflQHK86rD+TUTWQrKreVmKzLxf
 +OKXgGm0QuNkOL+NSDXsrnk6D3w3Mx3if/bv5e8vsgZQlQIj7urSI2R8BMzoJlhEsqjV
 oHyOsj7eeqAOrfOLY6yJCju3XJLq3ubewYz7/7/v+WXFc5FPn9KXX0My8WHOfwZfqsQH
 VNTbLbS3g1VY5n9gQTRLNN8kaDWXj1QXyZJmTg867qKV7c2doy0mgYBlM+DeNfr293fr
 AJ/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Vj+ueBfbKFWKudr+TY9sFwv8YRYA7Rg3bpHTaaWNI50=;
 fh=aCaOJZgkkxSl3kG1DMjk4JErljQ5rHgaDbhrsapChVo=;
 b=dN6hdB9amqTn/NmODOD0+7MC88ezHhmXaCx3dTjzQ5AaTIwHCVBZjoK5pEChQICLZG
 Q2cPFfGt254lpqFv/eJKGZWadiQyfaaaCUtiFRU56uMO1Pjtoo1Tb4HQbvDXSVIWPqSa
 9aAb0COIiZmo95d9KCxoasnYB2v9NQavMJ9dMQDS07mPg9fnbDTISRhQuexFkKeckPe9
 +MxrwL8hs389YY2uP9ixdhVgy1nrSiogZGRBmUMdLj6UIERbPxSjNhoq0UMWeHQ849gY
 tYLQmWLohqeI3arkUtZ5p5oIjbm++CH70FiDOVfm7/B6Ztt+RS2/lzLmLwhtq2oU3k4w
 Jxhg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1780325928; x=1780930728; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Vj+ueBfbKFWKudr+TY9sFwv8YRYA7Rg3bpHTaaWNI50=;
 b=JhF/H1TEwuIiHBTm5nqNQsgZ392nZuGosX/P5Tvgs78O4XSSUqFOBbWBWkNmsmdOVS
 i6Nprzmw8jnkraX7IcXyHB6iQ1TEBQR/CmVWEuDgit3pE1CzvvNB5dSMAIkGcC9b27f6
 etoJQ+leD+DQC3nNSM0BXBAe6j12Smh6MhDJo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780325928; x=1780930728;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vj+ueBfbKFWKudr+TY9sFwv8YRYA7Rg3bpHTaaWNI50=;
 b=lBDMG7tAQOa3fggq9yxe6+2rI7wOFkfAIJfiGUBOHo7FDsEum1a2XaOjNQ3VEpst7A
 8GuUcmnP2EZ0MRvSHJjNHq75+5RRDW7CVBOiIRJUcCI/Ui2idym3WBEma7cYBzgI0uLH
 YPckWurZpD01IiSCkKoLWKFUBt1Xerg+EUImWqklvco5BxNhdL357R3eMn7Rr2s6vSbX
 OnqNDI6fCk92keTFkzGNeMWMv9Vb/RArIdw5A7TgXzfv8G1zkFCTrnH1SEqU/D6n4Mbr
 oA8OHJaAqelc9svywEyZ/568nExS2biU5Gaxn/Gt7d9D9XO+3ZtfdFkRR01VfovMTVXS
 dzLA==
X-Gm-Message-State: AOJu0YxFpl+SP0OV/wTSxdogW9DyNPGQM9QuMJQPMTvnG8b9SXfoI4S3
 M5iHBtjkXVOaIAyfYyM9MlTjG3gt1Hv1CwXhwpiV2oyTSbDC23LPTqdV7QJykWQbhPrrG9FwUYI
 ge7C+c9FJIQgURAojamg/wznjpGATfP6TLDi5vL1k
X-Gm-Gg: Acq92OHwLbGyEMLP7h/+hXzICYubrE6daWG3O+PvwgPNY3ZYztCOBZj4kaUnSmrs+/r
 HQeDFW5bF60RtkCfCzFb0zGt6zYq9EKlmjMJhvz/LypkXZccoRFAEPSArHZ7mK7dSnEDuTgPHgq
 wt7/QZ2aQknuYy//OKKC9KoWCBN3dqrINalRL8NwLOrPxnROFMYXe4gT9GVq+viGeo1MsnBxgYC
 X3A2Xn9d91Y1MP7rS6rncos/TnKHwEY1a++GHYlwTFr7HRz9bXWGsVoUuCFypJUgzIhFe37LjUy
 zZ9KQVuZMZYR1KrS
X-Received: by 2002:a17:907:7f8f:b0:bed:6e53:bb16 with SMTP id
 a640c23a62f3a-bed6e53c9e9mr310112266b.43.1780325927642; Mon, 01 Jun 2026
 07:58:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260526-devfdt-usb-v1-0-a4e22b23bfae@nxp.com>
 <20260526-devfdt-usb-v1-5-a4e22b23bfae@nxp.com>
In-Reply-To: <20260526-devfdt-usb-v1-5-a4e22b23bfae@nxp.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 1 Jun 2026 08:58:29 -0600
X-Gm-Features: AVHnY4IJu7AxrwjSKo1jlUSFO2QP9sJmZw5xOlRx6w9zHYLS_eMmq-OzKdznboY
Message-ID: <CAFLszTgtOANT93vfmL+zbN7gHptaLgDE=ywhdXA7vJV+ZZfKag@mail.gmail.com>
Subject: Re: [PATCH 5/6] usb: mtu3: Use dev_remap_addr_name()
To: peng.fan@oss.nxp.com
Cc: u-boot@lists.denx.de, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Marek Vasut <marek.vasut@mailbox.org>, 
 Tom Rini <trini@konsulko.com>, Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>,
 Kory Maincent <kory.maincent@bootlin.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, Julien Stephan <jstephan@baylibre.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Peter Robinson <pbrobinson@gmail.com>,
 Peng Fan <peng.fan@nxp.com>
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

On 2026-05-26T09:09:56, Peng Fan (OSS) <peng.fan@oss.nxp.com> wrote:
> usb: mtu3: Use dev_remap_addr_name()
>
> Use dev_remap_addr_name() which supports both live device tree and flat DT
> backends, avoiding direct dependency on devfdt_* helpers.
>
> No functional changes
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>
> drivers/usb/mtu3/mtu3_plat.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
