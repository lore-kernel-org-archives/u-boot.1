Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A58EEEC2A8
	for <u-boot@archiver.kernel.org>; Mon, 23 Feb 2026 22:48:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B94AB83C39;
	Mon, 23 Feb 2026 23:48:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="G6K1Eoqa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B71083C6E; Mon, 23 Feb 2026 23:48:26 +0100 (CET)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1413183935
 for <u-boot@lists.denx.de>; Mon, 23 Feb 2026 23:48:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-45f04f1348cso3111749b6e.1
 for <u-boot@lists.denx.de>; Mon, 23 Feb 2026 14:48:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1771886903; x=1772491703; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xf0zc0Qx7t0izTSaX3lzlg36KND10qpePn3B/H/QlP8=;
 b=G6K1EoqamqKQHwO958PbfA58ZsK65Q0oRzJ7fGm7RH4yBAL8oi3pechj0FOC4Yycz4
 XCvULfaVgh2KrgHx7TPDMGqnYmJGtwRzg7oIWvVbf9zsxEuKWcaUScaYfo30V7vBVFAG
 3tTPWv330RJCOi8XAxEKTR88qi8WqQqtatjxU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771886903; x=1772491703;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xf0zc0Qx7t0izTSaX3lzlg36KND10qpePn3B/H/QlP8=;
 b=e82n4s+Ebg28lod7Ym+/irRqwFlsOAVaDYfCkEytv0v/9RntRpAoFQYunXNkx1L4gV
 bQhbzzUwAqsTKFVRWPbLE3KNJ9Crnaqq35DvdjxwOVyTLoffDt/PzWVNdu2bgmvwzUFr
 1GeMad/fUWFni+FwbCXDIl4gFXfbbjtabn1n8ZL4N0vJCdcqVDEJJyynlJ0FT2TMU3i+
 LDAqSaWRX2mL7Fb6yMqfEaHa4lzt984iuI2Id8O9x11bcbpQYb0IpHgPfhQdNzhLedAS
 oMKPRdKVXZ617DXldtx0zDNcQ6J8nV6sCXG6bY7p6E7T+DzQJE0J52ptIAK/jjiWYVef
 nNRQ==
X-Gm-Message-State: AOJu0Yy9nFjk0BIlztyvZ86ph3hnAlTgN9XX5TCbO6mE4k/mmq72Ai2l
 SxEYoBq5u/LTsdxGzAyG26au1tlQu/fG1RfabdQh93+/YX1urlyO7HLI44eybs6CRs8=
X-Gm-Gg: AZuq6aK5iBbDAmpyKrZz5lWQe2pml/lqwTHPJkiao7tm12MACdOaQyJPNC9zHQZo09c
 vN26Q7uS+S/ujBhGM6QyScbGIUggZ0ClBf8dm0rDWLxZB64HWKZ8fnmcRkeYOyHR1CLOG4fZXUj
 0iyTa1ewqTJKyhPB/rYBdWJyyksNOw8lcXV+HvphKel6ZKAX1T8myKAhKcaL0I+txxMvKnI8zNJ
 jXPv1lrBKDWobcgxzrBthFPcYcwXjqbTgTTvP2G08aV30SpfZ2UEtS04PqiJyBgwXCObaSUlQ5l
 B/MpcP43MWDmKFmEOfLqhm5SlGzMAcRbqB+/YhzAnowtW/z9pkKunMQDrm1BMPqfRoSdO9WNMZ/
 yV2UZpSOPpRYMqm64BMkARwvz4B8iEzmvVbaagw24XFBmTRVbvgHp+nCyTV0p9ttsLKM6cisbNR
 frwTNEHo4kNTH1+BNKJY2QkYOFCxoQ2LnJS4/8AvXwkwXmUyyehwiqVdEwkEQUSUg0TE8u71u67
 PnuVPfvAu5aF54QmruWuAeaY8WjjDz39AtcMabAAlLRzcnR7w==
X-Received: by 2002:a05:6808:c1ea:b0:45f:4973:7700 with SMTP id
 5614622812f47-4644635b13amr5558577b6e.31.1771886902789; 
 Mon, 23 Feb 2026 14:48:22 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4644a17aea2sm5929413b6e.12.2026.02.23.14.48.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 14:48:22 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Paresh Bhagat <p-bhagat@ti.com>
Cc: praneeth@ti.com, vigneshr@ti.com, c-shilwant@ti.com, s-k6@ti.com, 
 nm@ti.com, afd@ti.com
In-Reply-To: <20260209072820.2576854-1-p-bhagat@ti.com>
References: <20260209072820.2576854-1-p-bhagat@ti.com>
Subject: Re: [PATCH 0/2] am62dxx-evm: Add SPI flash support
Message-Id: <177188690177.4021327.2262520320063905334.b4-ty@konsulko.com>
Date: Mon, 23 Feb 2026 16:48:21 -0600
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

On Mon, 09 Feb 2026 12:58:18 +0530, Paresh Bhagat wrote:

> This series enables SPI flash support for the AM62DX EVM platform.
> 
> The first patch enables the required SPI flash configuration options in
> both A53 and R5 defconfigs, including Cadence QSPI driver support, SFDP
> support, and Spansion S28HX-T flash compatibility.
> 
> The second patch adds the necessary device tree configuration for the R5
> SPL to support OSPI flash access during the boot process.
> 
> [...]

Applied to u-boot/next, thanks!

[1/2] arm: dts: k3-am62d2-r5: Add DMA and OSPI configuration
      commit: b45bdb822c29a2fd854fe0429e3f92c64982a57f
[2/2] configs: am62dx_evm: Enable SPI flash support
      commit: 75acda482cea93eff975c0b33117a89715ec28d7
-- 
Tom


