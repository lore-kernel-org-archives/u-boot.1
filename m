Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08129C44512
	for <u-boot@archiver.kernel.org>; Thu, 16 Jul 2026 23:25:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D93EA84DAF;
	Fri, 17 Jul 2026 01:25:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IjV2iF3g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5B9484DCA; Fri, 17 Jul 2026 01:25:13 +0200 (CEST)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4D0584DAF
 for <u-boot@lists.denx.de>; Fri, 17 Jul 2026 01:25:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-44aeefa1c00so1377194fac.0
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 16:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1784244310; x=1784849110; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Yq2XO3Yu74eJYWy0nbv3y4oJ1WQGD8jk5CbzGnfkXkM=;
 b=IjV2iF3gg/l6r3BXy332doFdWd8VcdgFcbGhwL1hrwRDiSq1N8fYoZ5ZxwfVPyPxoA
 oNWtrGg9Xk020P2C6H8CEFHtCmLZRU5KHT9VSUTTKj/YoPJZNETUv16SQ/nJ0I/pvjzf
 UKu4svuH0X6bfiiKSgGRcT8yi2cza4k7fMAzg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784244310; x=1784849110;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Yq2XO3Yu74eJYWy0nbv3y4oJ1WQGD8jk5CbzGnfkXkM=;
 b=ngQlnV2K9D3uznRoQeKSVdUGbuxG2zSQQa4EOOFGuHHw4SQHnkcXgFLFx5TIadZUhs
 pPaU7oDrVJ+XtCT7WmmFpnHgFn4tWBwOR9+1quhQ+cRXjy0c5ZHgkHbeKsUi7jSKUZv6
 36kiVP2IfCakyLU+OHKtDIShjnESI08eNxSzR5wC4r8p6HDnq73BIYfo2o4RGvzGwu/d
 pAOmdXcQwp+bHaXWHU1iqYYSOKMmTX6unbqpUvAzQk1+FLYRGs767wXuEq6B0UxE3ERP
 yFrgTZiyi53LVf//fk0In+yu9Jm1xhn2gajZsLY81R5lVCRSuUlKnLcCgAdAAN+AouiS
 D9lA==
X-Gm-Message-State: AOJu0Ywp+27Jbp2yJl0pCjSNk2zmJpjEl4K/nPjjwlVdkopy2utC5CMd
 IsHIH0JGGCmfxcro4WD6F4xGcjOlLy+9Z7fUnK84wouyxJfwOZlkOo1aE1K+Fluhoys=
X-Gm-Gg: AfdE7cmm0pHI/ueASVauNwKHRhr44H3d2BpxdB4AJ89FzLgwZ4m8e1hLnwHVdE7pjhg
 KjtI/wuuFg4myKHQk9RQrxM8SN0rR8wfqT9LOOyBTrJ1gF0wjPFSZ1t9Krjo7nid0AoCU9P4fhX
 XsXG3/7P15MOg2oRTjtMSuHRU3lifcOjNEaKrRIqIvwH4gkHrl3HpVmdJXh1+c/2AQv+izUWkC0
 lWP915rURVXMZiblFt0u3OFXP3vb6jox49+0/JvJYK60+4MH0BdHCCIGXSEE3LqpyhMIIHFNdy7
 LuTPe9dOf/aQJVxFzVQ1QWHlrt86FX+i7nDLWhuwO1kqIUB6hrzODn78vSaRRL+wcOLF1yCkOi3
 d3oeZ6FDlCJ1oAX7uxNa9YCHRr3gLmAR5j93DUX6R/jhGBryknqFCRPeKAbWCdtJksMwq0q3/Yl
 yOjH2V/xfkN2+KpoZHgGT2puQZn4YaSSzVp72Ljon7LpwPyGnaMlM02oAiNIZDfzV+JekXQie4O
 g58wgkhsFVXNrKatcgaPVMtjQ==
X-Received: by 2002:a05:6870:b14e:b0:448:47cb:da96 with SMTP id
 586e51a60fabf-4568c616893mr80492fac.4.1784244310546; 
 Thu, 16 Jul 2026 16:25:10 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4568da4ab47sm27308fac.0.2026.07.16.16.25.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 16:25:10 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>, 
 "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>, 
 Rasmus Villemoes <ravi@prevas.dk>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Romain Gantois <romain.gantois@bootlin.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Markus Schneider-Pargmann <msp@baylibre.com>, 
 Yannick Fertre <yannick.fertre@foss.st.com>, Peng Fan <peng.fan@nxp.com>
In-Reply-To: <20260703-dm-core-v1-0-076d395bded4@nxp.com>
References: <20260703-dm-core-v1-0-076d395bded4@nxp.com>
Subject: Re: [PATCH 0/4] dm: core: misc fixes
Message-Id: <178424430880.1470194.10643571364618939025.b4-ty@konsulko.com>
Date: Thu, 16 Jul 2026 17:25:08 -0600
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

On Fri, 03 Jul 2026 17:11:23 +0800, Peng Fan (OSS) wrote:

> A few misc fixes to dm core. More information could be found in each
> commit. Patch list:
>  dm: core: free old name in device_set_name to prevent leak
>  dm: core: Correct calloc arguments
>  dm: core: fix wrong strlen check in of_add_subnode
>  dm: core: free fdt when fdt_create_empty_tree failure
> 
> [...]

Applied to u-boot/main, thanks!

[1/4] dm: core: free fdt when fdt_create_empty_tree failure
      commit: e871bb2463fbd6c06b6d771d9201c6d6f4abf947
[2/4] dm: core: fix wrong strlen check in of_add_subnode
      commit: 65e1e66a3a38e21128582bec3b93c35548e60687
[3/4] dm: core: Correct calloc arguments
      commit: 0af2ed57a3e9c34775602ea70d5c9829c4e830c6
[4/4] dm: core: free old name in device_set_name to prevent leak
      commit: e1f345abf4c0df94ef6c5eca400a440c16b47d81
-- 
Tom


