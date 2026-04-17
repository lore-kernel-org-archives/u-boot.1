Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11B24F8DFF9
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 18:29:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5EDEB8422D;
	Fri, 17 Apr 2026 20:29:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OXqquvP4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 77B1C8428C; Fri, 17 Apr 2026 20:29:42 +0200 (CEST)
Received: from mail-oa1-x44.google.com (mail-oa1-x44.google.com
 [IPv6:2001:4860:4864:20::44])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 134C2839D9
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 20:29:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x44.google.com with SMTP id
 586e51a60fabf-4043b27ddeaso610583fac.1
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 11:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1776450579; x=1777055379; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1VoinpXJvCRNpuqRWKZmu3RHyqR6qUstV/uJ+yRzk20=;
 b=OXqquvP4y9ForJFGm7HB5xuHbyECO81l+ItvWLgVZsR/n/2pdL1UCnaiZoKRCTG5zz
 rjH58uULSeKOh2eQiQs0IlTeZ1u23cbfVgCl3lTM66i4TKV81iXVoJUCQRiLvtl6iLej
 w5VaHNs3JGy71A1uTpJ9Z36ye2LWzm/2Ncs38=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776450579; x=1777055379;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1VoinpXJvCRNpuqRWKZmu3RHyqR6qUstV/uJ+yRzk20=;
 b=RGlvvVJBFwdSOPWAM3nM2/BuWASCSgzOcmkHR7ep5Sqcn2WJjAAojASeoCKiJuqsiB
 ix4Ab58MPno76ed2wKWCAM5nIni3xpD1oTHT8qT04p5MHiWkyDR9C2M6rd744qA0VXJn
 1BcQVh40Xhx9nm7VxfDnOlmR4hG8ze5sN0VBw7ffZpeRgBV3xuhri0GXNDjMCYHpKbnc
 nBqVmBqVGyKzURZT28VUO+ZV2RqDi7bbdb+a9CqhWsYKrJjPcXrPa+wisidxzXoSdcKW
 WSjQ25qP52Fg9cv5hlCBmPTGgHclbFwEmT8fuxlRAu0bVTkzNfdHcMK/IsK9D60KaVrD
 LPww==
X-Gm-Message-State: AOJu0YwEyjjnVapEGiaKqlpIz3jG99Tit37+1DQZH2cYCaMe/mPylYYX
 nnFNUJINS/aRmdptxDLqb8CK/A/ksnqNxS49h8/ioik1e3pM3/sLp6JLpsnflsJZh7A=
X-Gm-Gg: AeBDiev+WInLoFxNf1zyinSanZJlz6evWNOsE/YhYBiwu06mDB83iwWwLzT7Gzhzz0x
 KfB7K+vRaAWAEmNhZTq8vlFB0yrqREOwB10kqdqMepj3f4Wl8nHfupoI85L2VpETN2OlcxzChin
 WSB7iAUGKtpXmglHE/KykVU/NvdxKJyg5zqbcRZlr1lPmoRuktUMjJVX+tdzXdB9SokDkNu48M0
 pmSP7hLYvZx4WGQ6AMWlSTYobcNFEDhtrwHowZfmKw7Cq45ge5TervG6QrIS4MAVne2yPW0US5m
 mYkSpQZ5nrcqE6h/zm7eX+QlSwk/Iub03wP/ki/ltcEy3PepaiCBddByRG7ivzrq9BRR+aIib3N
 YYvY+bH23jzF72vnQZiBpTi8+S9ZOBJqEA4sJscKkLEC/QVlpwGe6X9Zh4W85RKeZd/SfmkUpeG
 LiExifOHaN0libJ9Fk/RsZohN8FYO1mHRbHXGK49x5IYlBzljrXsh1GFk5MPJdHzWKpw2VCVSbb
 QLoQx7anABSi8sWweZzenWRG6DzvjJHMHy52MUib/BH3kWxIzgYLE0ScrlS
X-Received: by 2002:a05:6871:4b08:b0:409:bd2b:91a3 with SMTP id
 586e51a60fabf-42adeda9e44mr2379678fac.32.1776450578641; 
 Fri, 17 Apr 2026 11:29:38 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-42b9ac6f2a3sm2004954fac.16.2026.04.17.11.29.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 11:29:38 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>, 
 Michael Opdenacker <michael.opdenacker@rootcommit.com>, 
 Simon Glass <sjg@chromium.org>, 
 "Matwey V. Kornilov" <matwey.kornilov@gmail.com>, 
 Michal Simek <michal.simek@amd.com>
In-Reply-To: <3bde3ed6-6baa-4d52-a743-d9bb8de36382@gmx.de>
References: <3bde3ed6-6baa-4d52-a743-d9bb8de36382@gmx.de>
Subject: Re: Pull request for efi-2026-07-rc1
Message-Id: <177645057709.805241.5253061263128526090.b4-ty@konsulko.com>
Date: Fri, 17 Apr 2026 12:29:37 -0600
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

On Fri, 17 Apr 2026 10:01:58 +0200, Heinrich Schuchardt wrote:

> The following changes since commit 70fd0c3bb7c26d42f24d10145dd5f3168ac92eac:
> 
>    x86: there is no CONFIG_UBOOT_ROMSIZE_KB_12288 (2026-04-14 14:21:55
> -0600)
> 
> are available in the Git repository at:
> 
>    https://source.denx.de/u-boot/custodians/u-boot-efi.git
> tags/efi-2026-07-rc1
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


