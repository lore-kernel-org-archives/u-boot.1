Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F596FF886D
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 19:42:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5BD2583693;
	Mon, 27 Apr 2026 21:42:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OoU/1DzN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0306284150; Mon, 27 Apr 2026 21:42:33 +0200 (CEST)
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E05FA805D7
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 21:42:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-694891f8f75so4639205eaf.1
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 12:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1777318948; x=1777923748; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YVNjH1h/6N8rPLzrLBRaEUQuvvzjM52rBWY6bU22YDg=;
 b=OoU/1DzNfpiCakT8Ff0pi3vSnoX++7kcqMhckqbb3vcPUnx+6hlv9KIbj0kTM3d4DK
 pxLhXpBGcWucR7UjAh7YrwqBf7rxnr04YRG7tKnAdp/T5PB4NwT0F00XtXeKNHqYsrRg
 Y5dVFynFhMcN71zwAYvAlXQ1crzZ89MzBrPfc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777318948; x=1777923748;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YVNjH1h/6N8rPLzrLBRaEUQuvvzjM52rBWY6bU22YDg=;
 b=YO+PidstMyTCnBoOd34Fl5TOBg3sub58LT6wR3bnDIUOxtsG7KFUVM1AwC87s/bJk1
 MFmH39gntUwoiwFkXw1wh0nKf84iIrU0Wl6X6Ksyh6gJIRdzdzDeWn9Ww+rFLdlOq8U4
 4rBp6tbZHeWuBn1nlCJ1RXBCvrKcSRsZW4pXJc9IxrcfwbjRrvcvNeTvOGoow9dNgcjx
 sLwFNOo4fy35s0XSxDxi42CkKkLsKQpwvyxJBlWUnyM8VsRmImkHp8yqttpkcMSZLo+K
 QdxY2Iw53zo3hFyk1jqFlBHS6CbeGyLxAAsVE0LhhYf/b2H6jrkFogJ8RnsPaE8rffF+
 hRYg==
X-Gm-Message-State: AOJu0YyFHTJ5UTU4/PYJSm9j60Zs/vZYcpBbHcJ01CJLMusxw+iVDEtD
 9WsswPC6phN0t66kz1DRwYoiCb7HZtsbtqUNXBvafuvhnr/nsvJbk4YYzvdGJY28V1U=
X-Gm-Gg: AeBDiesBOn/UaB5WTvTevlqhbUqkOA4Mq0cOHC00RkheG8wa4RgI4/q4aLcNhSfMwyF
 +TYHM2om5NCkYfkyJcDr+0houJWx16H/WnXfaHwTqhzYWIio+evR5xz21rBkO55A7QqJkh4a8ru
 Mg+v249EOW0CxiPyYqfOv0oF9vY7mtDZg+s++fMuuhpFZtu4Nx1dxvhBQWrrIDrmoN1xze57Qms
 U3dR0aImqcc2p3+LubM9mxvM6Ep8HhSbo5OQ/zXsdBrBlE1pnqUqfsF3CK62wgCUlHMsDrWqx4o
 ll3lVYkuVF0i8kpgtiMXe+UMKhgaQOtLP3d3huiMSVuHS0NBLZEc8TsjbKeSRZCsKtt9r1EkTQH
 hVP1wdgHlZGtAuuEbSVL0U1Z4bihAt7lU6YYzBOtn37VQdzhXbd5AFxEXy0iHgyy7Hfwc5j99Dm
 fdC3FLkQLEkCruIdax6sv/oauTRtNqjmD0L/g2ACQVeWtcXWOs8VkRK8zYH9xHXI4WazIjsl6Or
 RZKefhagzWFpyUTUV0juTJWkKuTeSAIe0PmHgVMpnAiJxhKPEu4XUOP158p
X-Received: by 2002:a05:6820:16a2:b0:694:9103:3fcc with SMTP id
 006d021491bc7-6965ba304bdmr236627eaf.42.1777318948447; 
 Mon, 27 Apr 2026 12:42:28 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6965b94aa0esm187247eaf.6.2026.04.27.12.42.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 12:42:28 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Maximilian Brune <maximilian.brune@9elements.com>
Cc: andrew.goodbody@linaro.org, george.mccollister@konsulko.com, 
 Simon Glass <sjg@chromium.org>
In-Reply-To: <20260422125753.29574-1-maximilian.brune@9elements.com>
References: <20260416161305.24118-1-maximilian.brune@9elements.com>
 <20260422125753.29574-1-maximilian.brune@9elements.com>
Subject: Re: [PATCH v3] pci: correct PCI device enumeration to include all
 functions on device 0
Message-Id: <177731894763.3526444.2059542393521670231.b4-ty@konsulko.com>
Date: Mon, 27 Apr 2026 13:42:27 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Wed, 22 Apr 2026 14:57:53 +0200, Maximilian Brune wrote:

> Currently the implementation does not just skip all devices beside
> device 0, it also skips all functions (besides 0) on device 0. This
> broke basically all AMD platforms, since they have a lot of internal SOC
> devices behind these functions.
> 
> This was detected, because the XHCI controller and therefore the USB
> devices were not found by u-boot on AMD/crater platform.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] pci: correct PCI device enumeration to include all functions on device 0
      commit: 6ab5b5d2804b00d3253d09c6d8f829d918d2ed1c
-- 
Tom


