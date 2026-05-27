Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BF64CD5BD5
	for <u-boot@archiver.kernel.org>; Wed, 27 May 2026 05:47:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7044B83FB0;
	Wed, 27 May 2026 07:47:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mrjMREMw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A173683FF5; Wed, 27 May 2026 07:47:39 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 502678341A
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 07:47:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-68719234fd8so4960924a12.3
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 22:47:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779860857; cv=none;
 d=google.com; s=arc-20240605;
 b=WIaAtDkWnTfRAyUXQBq1g15hd7oboM44nymV0Om63t2FQgQZL/0j+Naa5bmpDYNHVn
 iDgRMN5vBZvjhoPBcCutR1KRpR3yPQOjdzOeWxQovUx0v5EtQ5848mWN2EEeh1E6ci+u
 ExfsWr7uw10afAcWjhbsDkuQKFthO2Mi5wN1aKtpRhzSns0RSr3XEfMPz1gqeAMvzz34
 Y85/GiAbN27OONKSrd5faKBemjSZLCaef+w2DMUmY3MKuylf34zcZ/hvi2ifhqRS2tD4
 p3BAcMJtTNBWI+T64SZK/yOcLTIYEPcTuFO9SZjC2RJ0m5uXRdhlxzkPZc3N+W1MIveJ
 0wCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=/jUNvORds75U/MlBhJ2OJQEWbUlgBVXVLoAIkp4ZS7A=;
 fh=pPa2lEbwH/cdP+P3XGY4wNDJtX7SR56qRWCtTpVxGsE=;
 b=WbNhSvuvaWddI7SNO14SZUc5oY8+jeaXT1dSuj35980us9lg1Z32C+3UtP0nBbd6S/
 FLdvyDZiLgCCkWaIIDabFej+gTXDTAKXqV7mHyEfTpsUwEoJd+oCS+xKMLr2zEWb6Pmt
 46SMgPnUQKUEt9HFAlLTJckdLGsPVA2W9fxA/dSZT6soCzJGK2NOoHOblahhkcya1RPZ
 EWhyfgQsJa9fZKQFIhW5tUinJwWCeymqJ22Gu2kDmU2J7WL1uTDdA1lXJD8IoXnzLZnQ
 d4ge8LpWM7yftYFRNfov0D+L/8Kd9p2adtfTftfjuQo2q+NGSSk5bVWlcYi3I/4C+Xf9
 r9QQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779860857; x=1780465657; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/jUNvORds75U/MlBhJ2OJQEWbUlgBVXVLoAIkp4ZS7A=;
 b=mrjMREMwjfmZq1reS0BizMFJdH7eCKv4UDsUyOveyni4TJNyvh2vjdpkxLgzcD0OZd
 UkayX6FQXe1CM/wJAtcKOOv9XPBkV0FnKbTQJuQ0ZvEZ0+T5/fu6sOmNz1z845lqNALd
 avTTnypm7MgrVvxRYFQSXHxvoLs7f2PXXx43c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779860857; x=1780465657;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/jUNvORds75U/MlBhJ2OJQEWbUlgBVXVLoAIkp4ZS7A=;
 b=Z6C1VtBVdFbcxeBbqw52jM6zfmZn32bc2PbIyACqpB9r5KSAngojOiHi/xiH3I/1Bu
 GPsD49VImFigjvZqZ6mWy++F/FkUBXM6pFyVPnqKpTxOLDcdLHcfKJEOnS15L8eW0XOg
 UWgF+e/nH+RFal/OuWyAO04oVGunhzZF+neKBsNlv4fH/ZWE7VNbq1vOKe9Vf27Ah3kX
 p3rYbGTjeBAZpwnmd73LNpJ9gayAOxiZw3uuRyIM2+GxOZ788bz9EZNWX2WZ7CZZ91I1
 vR/dHGyIsA5+Ru2/iPk6w8hjumppOLxob6uyFdQk+GtBvmw055QfrSUCzxlBHKcXc/r/
 IybA==
X-Forwarded-Encrypted: i=1;
 AFNElJ83qg3vEdToBJR03V+TcrEwKxK7K2MhvvRRzvFN/TjBS2pn2DSImsaFuL7r4YEUwb2VR42es0k=@lists.denx.de
X-Gm-Message-State: AOJu0YymPd0g23KhmhA+Jvhwx7X8jyp0/gUhaZ7upmeQdJIyrF3eZi4+
 Fv5wiBFPeXZhz7DypoTrx8dDPA+byk3OMPOLOLEzkBtW5kazjuXoK88uR/EPtP2ARTNYw/lMrb8
 mAWnBBz3Y1vYRGJXVr7iUBHv26h4UJD6hVTI9oygh
X-Gm-Gg: Acq92OEImzbTwdEjpYPzLJZviNzLrzRj3uVM2q2PXOi7zohnbZ21Z60IPWYAKMAYti4
 qquRpia89Ej9O6zTjJxR91OhQeUI2EX7r+tjxBDTY5lPyM1ATL48D90FXgmybohEKKIWYd01Fwp
 i6Y/Lpnmium8A3V15VpFXaRTXGC78tc2bUHhkWWWbiemWJ/HWYwvy2t06oKZ/3vateflWqFNpmv
 LX1h8bDiwpnEPSNufesM4Oej2HKYJifH5/mCqVgQDXrXjLjswP1xsWdY7jn7QMXEiSdKyLqChyP
 ahsNsw==
X-Received: by 2002:a17:907:75d9:b0:bbe:37ee:8a2b with SMTP id
 a640c23a62f3a-bdd279ce23fmr893927266b.33.1779860856620; Tue, 26 May 2026
 22:47:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260527-devfdt-spi-v1-0-37db1f6c168a@nxp.com>
 <20260527-devfdt-spi-v1-3-37db1f6c168a@nxp.com>
In-Reply-To: <20260527-devfdt-spi-v1-3-37db1f6c168a@nxp.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 27 May 2026 00:47:22 -0500
X-Gm-Features: AVHnY4LkiPNDt3g1T350wnO1Ob4pMhQvis_Cc3T7stvR2HphfhDTvpFPnMgFd14
Message-ID: <CAFLszThAjU91HME-QRxoYZnOuviqu1acKriJsHLBMoYF3HDMtA@mail.gmail.com>
Subject: Re: [PATCH 3/5] spi: mtk_snor: Use dev_read_addr_ptr()
To: peng.fan@oss.nxp.com
Cc: Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 u-boot@lists.denx.de, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Ryan Chen <ryan_chen@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, 
 Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Padmarao Begari <padmarao.begari@amd.com>, 
 Senthil Nathan Thangaraj <senthilnathan.thangaraj@amd.com>, 
 Naman Trivedi <naman.trivedimanojbhai@amd.com>,
 Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, Julien Stephan <jstephan@baylibre.com>, 
 "Noah.Shen" <noah.shen@mediatek.com>, Meiker Gao <ot_meiker.gao@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, Stefano Babic <sbabic@nabladev.com>, 
 Fabio Estevam <festevam@gmail.com>, Ye Li <ye.li@nxp.com>,
 Alice Guo <alice.guo@nxp.com>, Peng Fan <peng.fan@nxp.com>
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

On 2026-05-27T02:35:23, Peng Fan (OSS) <peng.fan@oss.nxp.com> wrote:
> spi: mtk_snor: Use dev_read_addr_ptr()
>
> Use dev_read_addr_ptr() which supports both live device tree and flat DT
> backends, avoiding direct dependency on devfdt_* helpers.
>
> No functional changes.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>
> drivers/spi/mtk_snor.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
