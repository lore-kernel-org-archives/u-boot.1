Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3980CD6E55
	for <u-boot@archiver.kernel.org>; Mon,  1 Jun 2026 14:59:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A82084958;
	Mon,  1 Jun 2026 16:59:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AFp/e+Xc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1E14848D7; Mon,  1 Jun 2026 16:59:04 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E415D8493E
 for <u-boot@lists.denx.de>; Mon,  1 Jun 2026 16:58:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-68719234fd8so4224579a12.3
 for <u-boot@lists.denx.de>; Mon, 01 Jun 2026 07:58:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780325937; cv=none;
 d=google.com; s=arc-20240605;
 b=E2S3jKlaZuloyefFkYtH3XBU6jUq1ElYa9559qEGpV9+QJ+yUBEolx8XsmIzQamZID
 Mf3qWhpsrmhVtp/EgLdfah5R/9MnL34QuQZDz9kjG5ItmUEYiKMBUuAJpFeZHvTU3sJG
 pC2vcr/FyqgyrgNtTt5Ptxg03uw61h6vkqXB+lp3XfN2EydZ+337TL1ubom81rlzvTSI
 St0jnyi/SBQTWuKyWFR+ebPa75VkU8T5xGKOWQolD9g5Q8Y+Mdiyz76iX6qUT0YdZjs+
 CxRqy9X8/rjms++IBrqfW69s6zWx6VynWKHw046KnOtPrgsrKTAk9pEQEuhtO9VcCKxI
 k9iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=7kizQsamGMg4QjaEIJ/XmYX8mRpXo1OeNEgi3kCmNtI=;
 fh=aCaOJZgkkxSl3kG1DMjk4JErljQ5rHgaDbhrsapChVo=;
 b=bAVidwNowfkFEfPON5SUVaGM7UCUPkqJe26yoOGpfWZrE56dilwiYW7ZYbhshiyi+a
 +diGqawyrwLTCITQS4LeXkEXTln8SJfaE926iFg61UL5giqDwZHcsrQ3Zzysr4fJuzmL
 taYXA1neYMk+kaGSXVIup0I0uUNO76v4yk26HgNlY5xfTrRyV+uo1PefA188D1ndiR+p
 Oz0Q9C9/WOzRQKDMIwjwG6K5nZyVlW9EQoTORf0La25NxE3ADAQNydu4F1SQ3Er21W0b
 3nZ/IF28wpX0b0Ztb2YzRTplTkmG7Nt8pMAJjINk/Q4oYLuKwXIruPxt3FAgvEO+/pnw
 HcRg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1780325937; x=1780930737; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7kizQsamGMg4QjaEIJ/XmYX8mRpXo1OeNEgi3kCmNtI=;
 b=AFp/e+Xcay+C0YYhQI/GIhGuY8mRNocyG6dit3V1JyYFbXMzToeeH3KFCi4jdVVWyr
 3poSq6glUx20WCADGUV1HkbXYxNajffvPWh7AZr18zbwxxnnGw8G2xxV0K8bGayz6Pxx
 q1q5d/yTGAYyMX+e7X67Eg52MMUMHOi5o76oM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780325937; x=1780930737;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7kizQsamGMg4QjaEIJ/XmYX8mRpXo1OeNEgi3kCmNtI=;
 b=pN4IY+LsBgweEPLAxnYZq32jld+CEjSTB1XZErOCOOsZadcsNSzE5hWb3DKax1xv3j
 EcR5zI05wK7qyHXGTTZHkT+U6uht/ROK/joB8UB2DIP/Z1IE1IvKstmNwj9F+t44JyXU
 bQbsDrOQ3FTRlKSFe881fYAXhf3W/27EzHOhVBw7IiBaXB7oJDzl/axkelzV2fliiF+d
 bBBbBt+ZNPrrzZ2nJCwvK0YY6uEFOZrib0YwvjRheWKJxTTithPWjK2/y4+7mBEn/7cX
 LcQIZxtnfQLVPP4g+VgyIsQ9s8LpUW/o95N9wWezPEjXqr/Pl7U2U6e+XqkqKQOZJcv7
 fy5A==
X-Gm-Message-State: AOJu0YxngrCaPQnr58eqGY7lGqhoNs1uPaHaQSpqB0yOg5qvIwMGF03/
 9ZDIZjTaelLjpD9gDVPEp0eBQWsIPua4jFkLay3FeFWDSaLHd6F3oh9EJn82UswcXQz6rb2vGcj
 pHM+t1SOO90xvGCqcc+l3YRARH6izkR9xxKlkp2fc
X-Gm-Gg: Acq92OHjRpEPKkQLW00Q/j+qf5I7wzrYXIUmxfdsSZCOMMSQqYno2N5kpM+OVOZ7na9
 3/fIglS2FV0I+AlYy6BwpjWiRTzo0iBoQqSxzgZJjYmBOTfU2ewFD3b+ENpaDjcllUD7D5BxCYm
 BFXd2pTHZ6agsCU7neJYR9jXCRF3eKEPOh1Uoiyf7E94sfuysVTnv5HOGqd7aehqX0OADKE+3lM
 Gry2xgcvz10JwkotIHgExU5+eXHDbybRuRkHBoG0oXD9RzZarlj821bS+DVXLcn1IpXzTPdtCRx
 FnQGI4J93OVvR4l9
X-Received: by 2002:a17:906:4fc3:b0:bab:cab:c372 with SMTP id
 a640c23a62f3a-beab18aaa50mr544020366b.22.1780325937376; Mon, 01 Jun 2026
 07:58:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260526-devfdt-usb-v1-0-a4e22b23bfae@nxp.com>
 <20260526-devfdt-usb-v1-6-a4e22b23bfae@nxp.com>
In-Reply-To: <20260526-devfdt-usb-v1-6-a4e22b23bfae@nxp.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 1 Jun 2026 08:58:31 -0600
X-Gm-Features: AVHnY4KHv-6KlsN5NmKFnsIqMsjQ-lEO6T-5G-m0xzuoQAC-gIpfTzDUkATbgu4
Message-ID: <CAFLszThyK616f7t8CSXo7URngmnfKTBf826-cjeCMUrTMmX3iQ@mail.gmail.com>
Subject: Re: [PATCH 6/6] usb: xhci: mvebu: Use dev_read_addr_index()
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
> usb: xhci: mvebu: Use dev_read_addr_index()
>
> Use dev_read_addr_index() which supports both live device tree and flat DT
> backends, avoiding direct dependency on devfdt_* helpers.
>
> No functional changes.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>
> drivers/usb/host/xhci-mvebu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
