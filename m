Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73994CD5BD1
	for <u-boot@archiver.kernel.org>; Mon,  1 Jun 2026 14:58:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08D3B8495C;
	Mon,  1 Jun 2026 16:58:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ALmh1fqY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BFED884956; Mon,  1 Jun 2026 16:58:43 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E55F08493E
 for <u-boot@lists.denx.de>; Mon,  1 Jun 2026 16:58:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-bd8d0e4e341so2378100766b.0
 for <u-boot@lists.denx.de>; Mon, 01 Jun 2026 07:58:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780325921; cv=none;
 d=google.com; s=arc-20240605;
 b=CTh4w5OtwachWJme6/7PTKwELyWDFTmhu0qkPfxU4eeDK/kd+9+yxqXB60MNBUmcDc
 ILDM22eie9gWS5dnVMiaXlgl0qzJRW9dv9BIQSW6ZEJr/L2QBf1TtOGbMo4LTWpH3XTG
 sOTBjzSb7yFcwWNdlBSziVSC1CnOZZZyUmppyET2a6QgzKzlFHxZNz71vhCPKd0tTkFo
 NuALudl8+z28U+H6uckVREuciWVtdHtRaDDsTk6a44Y5T/+hcQbdZF+mHgAKdNAG2k/9
 VWTrVm3DriYijCivp9dthE3BbnaGtWbTQ+C+8JXJpR+ZqYDHtCggTOSHB+xUsyKA3pTE
 4oNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=FnhESM+EpX23/sX7prBJfgkTB3PxFZ+FS/77ioRKK4E=;
 fh=aCaOJZgkkxSl3kG1DMjk4JErljQ5rHgaDbhrsapChVo=;
 b=KCJyUaa3QXLt9HGQdU2U3+fwnY6n2n4Ek3gkCSztZtho08WegEOiM6ZMBFO663HkRK
 /Uf45ydW1u8ad2eM812Eb+og2GnJ8IWHdCg2voQ3fK/YqIQWbHAkrTwsr7mtGExhoo2I
 Rlpzv2F9/AFADWlolNeaKwUSozGTeRnQzWdF7ke05Vt0j+3YiMSTd1rjEJvSJdU+CB6B
 xUsbAa1IMnROJSrGjtt5W6ZseiWPhOdS4sDMAXNHT6MDXY2jf+2u0Vv8ZAHZbnrHaRXw
 kva2g/Cqhr5T343zfEIJr8rTGgZ9F1cSlsgOMSIHPrneZbKkIGTyDb/t+A1WJR3zHzqc
 UHdw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1780325921; x=1780930721; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FnhESM+EpX23/sX7prBJfgkTB3PxFZ+FS/77ioRKK4E=;
 b=ALmh1fqYFnx2Qh8/RseTBhaI9yGg/DkxtgfJlfGws5z/+6WLRlsjldqmXgtXW6YMmG
 Xj1ReXyE8ViAEjftqYRfR1YoIduLX+HrYdjqDbGpfTESwj+/bGs2U7RUiqdlzUDW5qhW
 WFN4xTg3Cbg5GRpIxQ1Jk0GY/tpFNEgtvopwQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780325921; x=1780930721;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FnhESM+EpX23/sX7prBJfgkTB3PxFZ+FS/77ioRKK4E=;
 b=lYjB+7uFqxqESYZ6rIu4a+XlmES5aFGJlLw3ni9Z+X6wxfJLBuh/h2hNDwDz944vZv
 niowhoITStlris00CDcrFtcBmoHXYjfHcU91wLqukOkyHYPhtXm5PVYTc6fRqrr8YgoW
 +31h4MVnYYY0dBzB7xQvYBpvZnSXyYiPPiiEOAMyMOZbxklNE9EdDaiMy3G99Twjdc6f
 v/J7nzbLQsiW4rwR1R3XAK8FQnVGGdZuW3qW6U9c+pcCYjRtQF674VTCVIaMEu85XwL7
 Zl8vRSPJClBlHbW8u2r60E7EsRAZawtX0ck3pI937b9q0L7VYvF/7L1IUiWaD1b/QJ4b
 zmFQ==
X-Gm-Message-State: AOJu0YzAIE92bdpaqZj7emeJpWQJsemwDvJFHFLs6yw7c6hSAporM4Sk
 /M2erg6WCn1ZdA1yuY0swnybY7XN4s/ETNUHwXIRUrUwv9yVwWL6mLgPlAM2fQeXQS/Oi91OlX1
 0W8aShltjks+4rlZI4fX8SzjrLb6KobKV/+KDYJkA
X-Gm-Gg: Acq92OEIzRPoKZhRO0Y973rYqWiQ4PZox6GrAfufL5zIGuBGocRdgMjqDsuBBQpC2r7
 X2tkCSWIKFke4CDEOsvTVZ0moY6MRfc8YJKYR5a71TzzP/Gp7Ybaduj2Y5V1dq2SfZIfl7u2fJ+
 E6zu6hWvtW8dz2Idj78PF376QkP31ts9DbQg0Bjy1QlFpy0MwQcr6/J+HnwVDEbI39ph6eLCUVt
 NFiBCPrErgVEru2CbtOOFdxamPjzZNgvzROV0FLMeM0tSd1GeUmcz+XgV6tuFWgwFmd7MKPVk0G
 VLZS/EWZlH+/XKlt
X-Received: by 2002:a17:907:3e16:b0:bd4:6c96:f87b with SMTP id
 a640c23a62f3a-beab2082093mr629555766b.28.1780325921385; Mon, 01 Jun 2026
 07:58:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260526-devfdt-usb-v1-0-a4e22b23bfae@nxp.com>
 <20260526-devfdt-usb-v1-4-a4e22b23bfae@nxp.com>
In-Reply-To: <20260526-devfdt-usb-v1-4-a4e22b23bfae@nxp.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 1 Jun 2026 08:58:26 -0600
X-Gm-Features: AVHnY4KnQUQ6ibnqFRSzjTPYMwGlcwo08_tOmSa-O8vcZR3pXIQwvOk11qMbduM
Message-ID: <CAFLszTh=sBV_SHSMt5sF9OyeNhTRstTOv2Rxk0eGesjgE_90NQ@mail.gmail.com>
Subject: Re: [PATCH 4/6] usb: host: xhci: Use dev_remap_addr_name()
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
> usb: host: xhci: Use dev_remap_addr_name()
>
> Use dev_remap_addr_name() which supports both live device tree and flat DT
> backends, avoiding direct dependency on devfdt_* helpers.
>
> No functional changes
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>
> drivers/usb/host/xhci-mtk.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
