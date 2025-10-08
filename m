Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C0EACCA470
	for <u-boot@archiver.kernel.org>; Wed,  8 Oct 2025 04:22:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E0958394E;
	Wed,  8 Oct 2025 06:22:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Lesg03J9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F3D483979; Wed,  8 Oct 2025 06:22:10 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32A87839D9
 for <u-boot@lists.denx.de>; Wed,  8 Oct 2025 06:22:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7b97ce4fc60so2144743a34.0
 for <u-boot@lists.denx.de>; Tue, 07 Oct 2025 21:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759897327; x=1760502127; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a3eGw+0rBzG4LjA4wOaZmx9NttOkpocJX7PFz6vCmf0=;
 b=Lesg03J9C27QpmncnUBr9NHehhTPXfQrK5TyrVCXVzOakWbOI3KURp/K/2Npfusp+8
 VA93b5H5mB+6FtOSqY/R8qxsFK0zLVlKEBjxuPtMdm3w5cwKTMU1kzC/LQGlQ/Y10VRM
 HCqhuSxVRbkoKVig2Egg72Z7XzhhOKuOgNR2Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759897327; x=1760502127;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a3eGw+0rBzG4LjA4wOaZmx9NttOkpocJX7PFz6vCmf0=;
 b=PC/UwGHDE3e0reAvJV2AHMhcvGZWz4PLhTJ6xlPXQAz8rAYpaaD07kmZBnRRRHQt5G
 Rgccfoc7pvjpTqSmNOXudCCg4uNXtxxlYrD/fy9fWwDQCggsuO9qbc0961k7UWp6LJtW
 6YvgOKrMpSZblwjkmtcMiCMQ9/7ZUE4eztPMThLgdlo5exjXaWG5GJUS4QuU/xeDWNdt
 V64wmpEs+vsZIP6RLPboVMbR7pCs70CxErbRlDTJTRJ2QeuRH2Z/Tc7eHUHa57tqWYwV
 uO+bNz3LPZ8DvIj3DQFp7JSn1tViY09g+l5y7PkVUfSof3f4hXQNim/5PhQSsxACYM/2
 aA4g==
X-Gm-Message-State: AOJu0YyVM27BFiH+ZmGbOH6afBMCV7c0ostdKzKuQL2daFm1dZ2Ebt5l
 xjZYzzjd7a2p4eRs3JUqRh/gDDjKYlyAt6kkBvUOkG5oPo4Ix5RT70CfYKvP23brjNFkcHWEzJa
 uk70P/Zw=
X-Gm-Gg: ASbGnctx+9JRIV88jZch47+qvXa4VNIPI2E2IMofhvcULfLhwwKgxRs202gBuIZ5/Oo
 IQ6cEnTZFzyfYeSs4EkgvNo+jFi18dsJEksOBGCP2RNr4hwXRQ3t1xrnfx+xbTRUWlyZUf+ilIt
 8XHexJ5qzOyeB9xHJF7ZtcxRDN11301Kb7pepz4hfWAFDNOZCpvAEyLHuen3oE6XmdOQLy6b8n2
 qjtX5jI5YNb5Mv/1NHBm8yhKdX7hJCAsM6ElRewV6vNYlqqm6k7x8Gg5M4TxutSa/yVUaElB9rp
 XDuZKfy6Qm/hONM+9vfEXWjQcX9+3C1Q6mSIEoWO81/5cGnHSooCfMgnOCvdrP5IqqqxSr8WtcS
 hxmt6uo3DpHjrnV8ewuvApFupNb0boN0MsT68wMuPW2CNXt2HQuFJR6prDU/vNuRkuohTS+jXL2
 eq6ZH834QN
X-Google-Smtp-Source: AGHT+IE8y/VG/4aYXz3JtUKgqII4ywA7bPsUm6QeXK3DzswkMlGPFQF56yastMPa+fi0STvDQnmZpg==
X-Received: by 2002:a05:6830:6084:b0:7b9:f432:dbaf with SMTP id
 46e09a7af769-7c0df7e5895mr1059687a34.23.1759897326940; 
 Tue, 07 Oct 2025 21:22:06 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-64e1bc7f424sm3818016eaf.17.2025.10.07.21.22.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Oct 2025 21:22:06 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: =?utf-8?q?Carlos_L=C3=B3pez?= <carlos.lopezr4096@gmail.com>, 
 Aristo Chen <jj251510319013@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
In-Reply-To: <20250925134804.66689-1-marek.vasut+renesas@mailbox.org>
References: <20250925134804.66689-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH] mkimage: Add help text for bundling TFA BL31 in
 mkimage -f auto
Message-Id: <175989732553.1794629.10094517268929790920.b4-ty@konsulko.com>
Date: Tue, 07 Oct 2025 22:22:05 -0600
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

On Thu, 25 Sep 2025 15:47:35 +0200, Marek Vasut wrote:

> Add missing help text for the -y and -Y parameters of mkimage.
> 
> 

Applied to u-boot/master, thanks!

[1/1] mkimage: Add help text for bundling TFA BL31 in mkimage -f auto
      commit: e560735558e313be8e883f9efcf729997df8b30e
-- 
Tom


