Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D526CD4F5B
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 13:35:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE20F84704;
	Tue, 19 May 2026 15:35:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tDyZHFKP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE27184713; Tue, 19 May 2026 15:35:14 +0200 (CEST)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD728846DF
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 15:35:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-479dd56d016so2909735b6e.3
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 06:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1779197706; x=1779802506; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nmbJCD1v/KtZThd4yfikODF56RFNGRRxcm+njMxr/4Q=;
 b=tDyZHFKP5u5Uj2XawGzPDhvQgSufDoFjVuftZdbE7uj1RF7+0sDF8PgOvpt6lzJqkJ
 bHKPVu3f3boR0hWD+TGauWFewwz8GzX4XR1LrTVQ46zQ+WcW5TbtHdgfNE/ZRSAM+dAT
 aZoL0kzwbl4EIYh93hmd+QfnOLeVz44xQ+GnU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779197706; x=1779802506;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nmbJCD1v/KtZThd4yfikODF56RFNGRRxcm+njMxr/4Q=;
 b=ErQEXuTrrRG3vqqUwI+H4du97Qgm6Y5doNiwFv19noG5MmpH1SMKnwnje0f1Hm1/Se
 jfyrLGBTKh5WBxXgx10YK6JgZe2UUDe4DK6Z1LoeAeh5loSE2aFUjjyalVYyjoekGMx8
 NXsDHr3SXTlVVqtF70ZUsgNXSeXxcAcmnKm0sd2yrgcnP+I4YFIMfvG1xl7ukex+tGDQ
 LhGUOjQUI0xuYx1n5AcLhDHtTUuuI16oiILwpXqwj70K5/nDqLBcYmV3hyU2c4Q6Q3kB
 EziBmk3qFOOg+lQ5YWPjqT3O2W2lWVqjMiIyNn4i9VPqweZtWNMpEUy11LzNBcNcMX+I
 QeSw==
X-Gm-Message-State: AOJu0YzLQcyOQLZrL3s0UJUNXw3wzWL68KP95lvTJ/GRpwSlikdnCCLO
 dSTixTIUpzaUckp33seqpQUL59VFjexk3KwopfoQJxq7X41/VUTtCrN3YE5Nh3/IHe8=
X-Gm-Gg: Acq92OGxMqitEcU5aZX3RQw7SI6B0WAdlgXh2sRUDqv6kVcN4sNhdov+shl6o6ooP+Y
 bDWVvmziF5P1h+DjwRiqEjpqR/XO3qx6PAAsr2yxsk+TR79zecp2GFc3i3O+K66ixb6ehAU9Qhe
 c6dcKDmrjP2ROuXd4g4k972/kyxmHBnoJpOkCj+vAQhYTBO4t3tSIVT4zkEt3U1WxUwIkngN/PL
 DxbOsj+/eDTPD4nhgpx9sLa3o51Gd/6JqqcvMLyA6J9RPDMIpQqKZg5VYrTOPiH83W3O3fO5G61
 mYqctkTd7xctQyrUu3AELE7DJbYTqr9nDTgr0r7IqXmWO8HoO4CnAB5/XgNYoHoA0JEfipbb+co
 kyjTYLUgF9vF+6n8uOkl7Uu+8xcgxAx01yGBqs0Z526h+58bn1kQv0ztGqaHaD6iB8S676rpIyg
 oZ6LTWow5/n6cwP/35SKq2egvwL5onRd79B+MrX5qPjit4N3l23cdvl8jeSFchtfMoDpJxdWpbh
 i9BsJDULdAwLmA8hMQ2Bgrsx71xkHgOjdniQ6N3bWkeb1nhIWzwG0mLpNVV
X-Received: by 2002:a05:6808:67c1:b0:46a:c987:ba00 with SMTP id
 5614622812f47-482e5760189mr13144491b6e.32.1779197706532; 
 Tue, 19 May 2026 06:35:06 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55b7cd6c0sm10826569a34.4.2026.05.19.06.35.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 06:35:06 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Aspeed BMC SW team <BMC-SW@aspeedtech.com>, 
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, Joel Stanley <joel@jms.id.au>, 
 Lukasz Majewski <lukma@denx.de>, Ryan Chen <ryan_chen@aspeedtech.com>
In-Reply-To: <20260507164314.59373-1-marek.vasut+renesas@mailbox.org>
References: <20260507164314.59373-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH 1/4] clk: ast2500: Staticize and constify driver ops
Message-Id: <177919770552.672258.12006644666308311617.b4-ty@konsulko.com>
Date: Tue, 19 May 2026 07:35:05 -0600
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

On Thu, 07 May 2026 18:42:57 +0200, Marek Vasut wrote:

> Set the ops structure as static const. The structure is not accessible
> from outside of this driver and is not going to be modified at runtime.
> 
> 

Applied to u-boot/next, thanks!

[1/4] clk: ast2500: Staticize and constify driver ops
      commit: a8f49cc1938476486a800e23f410737a0701b5ad
[2/4] clk: ast2600: Staticize and constify driver ops
      commit: f23324e49ef15bcd1aa317f8555cd38aa01f1548
[3/4] clk: sunxi: Drop the extern
      commit: 368255a9a0a6076f88c7124f4d002485cc6ac059
[4/4] clk: sunxi: Staticize and constify driver ops
      commit: 31df5fc7d4c3a6588354d38f05fc5d20f22391d8
-- 
Tom


