Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34351C35FF1
	for <u-boot@archiver.kernel.org>; Thu, 13 Mar 2025 22:45:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31CBD81BC5;
	Thu, 13 Mar 2025 23:44:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="AlxFGseQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC873817D3; Thu, 13 Mar 2025 23:44:57 +0100 (CET)
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com
 [IPv6:2607:f8b0:4864:20::834])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C18C580FF7
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 23:44:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-476a720e806so13943211cf.0
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 15:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741905894; x=1742510694; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XuyzHcLZtY0xtMPYgHqDKUuYk9+J4c4+w4eAvp1AivY=;
 b=AlxFGseQBcZIT8mEWvaHc1nzooKZHRzq4P4Q/v0NGqcpN6+yuQm1ocmt5fIi/U9zVc
 WOT/AXbMKZdE2aZhdlGnXrbmaTk9KhyTKfBnrWh4oiOls3NBrE87XNDsFZayIf1bu9Sp
 OoUicYnb5cakZGNfSvywtOBnLHYoHqaWBDbqU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741905894; x=1742510694;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XuyzHcLZtY0xtMPYgHqDKUuYk9+J4c4+w4eAvp1AivY=;
 b=pr3dUwNKN0JaR24XUopkSeniAUVNGLat+IElaTMexLxCsgI0z7nfBRa6M/+DIUIwFe
 zmrNG+6/weulsoph7S+sv24CArnP6FjQa42NwG6IsiJL+g19JGTKTHXl99t5R5G7uSZj
 ZuiSRGE0yNX9PC27MQ2d59lLa9pFkmMFBhmiwtKIjAIvxIiCvTBPjFBItzOxn3kzwGtm
 JGEuVrr8tkIK5XumHeNVcE6tfdHhCZHhPoPFfVoYm+0s8XvG/R8tvLGfm/dG3SFrTJbJ
 nGwJOCBU82SrrB9A/b1pjq/2Cx/OCmWUeko/HEQUt9daoQOimK3f6JB+hx9sLqJCdhIs
 kw/g==
X-Gm-Message-State: AOJu0YzpyR55BX6vKsxetzNGhn3KyCnrRbG3J2Bc3XvKn+wLTa7rbTOe
 8UyEpyqsf2uk8dVtZfT1Vsc/79FH6KRRGhCKs4UafTLBeHj1ogLwf5HDK8YKU+o=
X-Gm-Gg: ASbGnctIX+C6NI5cFi6gyX5WFfHChPWlyzqZfCXhDISyFxO7TdiE+wWprUzV9A1z9v/
 cLBdKd23wRmZhVGgyEGFOcn98ZyeIXFs96CcWuTPTG7rICQYo68gLUItx56t4/L/xQ6eL1E5uZU
 vPTDii+gS09j5YlD/ILRRfDs29/sQ8p4kwwwnD0eCLMBdL1fGdyGXDpbldnSHYdK1zlC8+5miys
 uyifbbwkPMmXylHKIWUVW+dyvnulY/+atZyU0P2xl25XnRb/gWJDE76VLSa+hAAY/A9blP+jtGk
 AY2PvzCZqkKri94Q58qbwwjkvjEw/NyNdyCeLQyhqXOU
X-Google-Smtp-Source: AGHT+IGNYtgAp4lqMKrhLJEZdSYs2ENKu2Q53zyfSdLmZYGwicScXuKu9x+O/pHg54U1tPBomXDM1A==
X-Received: by 2002:ac8:7e83:0:b0:471:83ac:98ba with SMTP id
 d75a77b69052e-476c813122dmr6546731cf.5.1741905894694; 
 Thu, 13 Mar 2025 15:44:54 -0700 (PDT)
Received: from [127.0.1.1] ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-476bb7f4f79sm14125251cf.61.2025.03.13.15.44.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Mar 2025 15:44:53 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marex@denx.de>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Andreas Geisreiter <ageisreiter@dh-electronics.de>, 
 Christoph Niedermaier <cniedermaier@dh-electronics.com>, 
 Fabio Estevam <festevam@gmail.com>, u-boot@dh-electronics.com
In-Reply-To: <20250311013430.510151-1-marex@denx.de>
References: <20250311013430.510151-1-marex@denx.de>
Subject: Re: [PATCH] ARM: dts: imx: Drop bogus regulator extras on DH i.MX6
 DHCOM DRC02
Message-Id: <174190589266.2150498.15274327836606915387.b4-ty@konsulko.com>
Date: Thu, 13 Mar 2025 16:44:52 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Tue, 11 Mar 2025 02:34:18 +0100, Marek Vasut wrote:

> The regulator extras should be placed in the USB H1 regulator node,
> the /regulator-usb-h1-vbus. They are already present there in the
> upstream DT, so delete this bogus node entirely.
> 
> 

Applied to u-boot/master, thanks!

[1/1] ARM: dts: imx: Drop bogus regulator extras on DH i.MX6 DHCOM DRC02
      commit: 15d6518c942f0da13f9a7ceeadbd925c3317ec8d
-- 
Tom


