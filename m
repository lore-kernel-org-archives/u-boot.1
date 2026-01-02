Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F441FC6165
	for <u-boot@archiver.kernel.org>; Fri,  2 Jan 2026 23:24:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59DEE83C29;
	Sat,  3 Jan 2026 00:23:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tcYPsaYL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8CEE842CC; Sat,  3 Jan 2026 00:23:52 +0100 (CET)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C17483AAD
 for <u-boot@lists.denx.de>; Sat,  3 Jan 2026 00:23:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-3ec3cdcda4eso9083632fac.1
 for <u-boot@lists.denx.de>; Fri, 02 Jan 2026 15:23:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1767396229; x=1768001029; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ggt71fVmcn6+RkpgL5iq62PhukXFUKIe+zNj1tnGAXE=;
 b=tcYPsaYLWzJaDnX0M2dIs2OK15SnZdIH79vWzuCt4VMUWU+Xmn2/qX0NBBtcDI+dyZ
 JJw5bQjN3WndosmMVSm2fLU3JwKYlM98S6wjdlKe+pHM73dJvI7njy2eW3RPs9zjX/qc
 set6hRoaw/xK3zJYSMJBPCtGHKtr21H4mZ2IA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767396229; x=1768001029;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ggt71fVmcn6+RkpgL5iq62PhukXFUKIe+zNj1tnGAXE=;
 b=pzcbO+0QMz912UEeQvfRIzJ+rQtMWTCFTiSbEmMABx+mO02RDjcs/gIZLNZExulJhh
 Yq5O3BzZCPLkfPMDhHERwIZsOKYppMCPYIi1PX3M3vn7Ho85v8i8CJyKO8fZFuP+K4v9
 Tid3ng6WtZnnr2uO7u/W0L6NDFdIMM/lP60vDE5tMaXgobYh+CB/RYyvgF+loEVW577D
 okt4QuoXJD5FrO3fK55e468n0n8c+/Ptn7dUALasUE3+YKEBt9jN4lzijkMPNEdB5qZR
 47bh0uDEXoIVIXfq0f/kMcWj2n05JWmNljkd/HP47NzyutwfUzNnbTBbFGmREOZHsyoM
 F0pQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMuj2A0wz82roozfKbXcojmNxNkrQb05v9PpMYKW1c+lI7vCfZH/+kHwDl/5x15eJH+D+zpvM=@lists.denx.de
X-Gm-Message-State: AOJu0Yx+8jdPTIszmQUGeaP0LFzi5OG94lKMkunpe+sd59jxhrAv5KOs
 0dm0iLbML2TgPw/55u/IA4jbUmzVsuRvK4CQJjdwIKOeAQSeYsnk0KT3lgrMppQxPtw=
X-Gm-Gg: AY/fxX6pljR6Btvv32PzM82MxnOWLtxLJ3SwNge0voq7J3j4MUdeArktuE8afRLnCrU
 /DorARri4rgQqgbOPalBKm0zotYtodiV+eRgSh4j9zOu0SjiBflZoAm/8lzt0qB8DldgTRAcPWW
 56GdJrWETiZdlVPtlcR6Q2sEBcn4uPpT+WAv7q+JxTJPVEs89pcyye8GMUKx7SwK04ipRA5gxlM
 yKY/Tx/oX+4MA8EsASVthTvCqQ8gEpmt4qygtx4iMdLa9zF94YFEaA60teYfI0v3Bj6rt3PfkNB
 7xBhvzvKUNZCzbNo83rR/KwM/g66G0XxI03tX6nPbIMQfJ1AE28OPk9ApI/OQR+W6K2nfsU3N52
 7+iaauGrWRleTLHHYWtJuHG0xGYYZdD7bvuq6fdTUi1gXT6Mqk7TeDvhjJnYpp9QZDOY7IRB9El
 JE+ztudLFGpg0RKIvCUVkG2qAmMiuUycL0G2Jl15pAcvrhbdYgdPyJ7aR++HQe+eNX37tZVVDlp
 ZDsHAgOYDoLujLztuhDX66YX25t9rbk+vlXvKmxikiUGAX+
X-Google-Smtp-Source: AGHT+IEV7Bxr0hh2bEK1Am4NmmnAFt64eG9nHEm0kzz+hxiurpyxDWobalZS+JGRDLK9GztWMxuUww==
X-Received: by 2002:a05:6870:b01b:b0:3ec:a4ed:cf4a with SMTP id
 586e51a60fabf-3fda5615ce2mr18144363fac.7.1767396228787; 
 Fri, 02 Jan 2026 15:23:48 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3fdaa4e0d18sm24711983fac.0.2026.01.02.15.23.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Jan 2026 15:23:48 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de, 
 Quentin Schulz <foss+uboot@0leil.net>
Cc: Michal Simek <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20251218-bdinfo-lwip-v2-1-f6188a2f376a@cherry.de>
References: <20251218-bdinfo-lwip-v2-1-f6188a2f376a@cherry.de>
Subject: Re: [PATCH v2] cmd: bdinfo: fix incorrect Kconfig options check
 for print_eth()
Message-Id: <176739622762.296893.18146732022570531453.b4-ty@konsulko.com>
Date: Fri, 02 Jan 2026 17:23:47 -0600
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

On Thu, 18 Dec 2025 11:59:58 +0100, Quentin Schulz wrote:

> CMD_NET_LWIP has never existed so it cannot be right. I'm guessing the
> intent was to allow print_eth() to be called when NET_LWIP is defined
> (NET means "legacy networking stack" as opposed to NET_LWIP which is the
>  newest (and incompatible) stack). There probably was some mix-up
> between CMD_NET and NET options.
> 
> The dependency on CMD_NET seems unnecessary as it seems perfectly fine
> to run bdinfo without CMD_NET (build and run tested). So let's instead
> make the dependency on NET || NET_LWIP.
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] cmd: bdinfo: fix incorrect Kconfig options check for print_eth()
      commit: 747a24b2291b9f4b3c399737087280322eaad7c5
-- 
Tom


