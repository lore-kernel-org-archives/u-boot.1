Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79EF1F53D81
	for <u-boot@archiver.kernel.org>; Mon, 16 Mar 2026 18:07:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AAC9A84118;
	Mon, 16 Mar 2026 19:07:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bnlIj8YL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9925D84132; Mon, 16 Mar 2026 19:07:38 +0100 (CET)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38F2F84082
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 19:07:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7d7b8461c32so415200a34.3
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 11:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773684455; x=1774289255; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OJEo2c3n9QnSb9com3+dLmWfZUSOrJ2DlmvRTgUi/H8=;
 b=bnlIj8YLmjibC++rfJj8y6Im7o1LPccZaetUx0Wj+AplW3QBYmfMur6y4PRfCZVE3Q
 DtIVA+jXsUUskZZ7OWrtTpDYxoL9/VeuI+Yk/wixxozZTsxBS2Qpu2bo7/H1yWOw/LFf
 TtvAxBKltSSSfbCD6PPHEMt9WXM3jECKfFhhQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773684455; x=1774289255;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OJEo2c3n9QnSb9com3+dLmWfZUSOrJ2DlmvRTgUi/H8=;
 b=JJkLA0mqsdiHmUUcjGJ8ljTGsxDFihElduQEjmnJEQjRvFSflYAlAZpz3exsQhabJy
 DKzQSgAFYxk47Us01kKPvSSWxM+TIRJfoC79f0Xc66zJoYgcEqbKD3uKhgW9SlnsQzh7
 RmyGWQeRrkgQKPAlBzRHJSP7ZdCzck51UhNCIiKFVBC2RvW31R0ofJPByPo1M2FSrq6H
 dhdG+oRruGUoiCfHgkoob2RW71giiw1VFHpFJqnpUAdVqIlYQIP7bAW72RS/pWmBw3Ry
 Jbfg5pqnDm+F/c4tset09bkjg2SfOkuhdwBJdy1W6gTB1QQAvjVq54Rkqvh63TAdcIda
 g4fQ==
X-Gm-Message-State: AOJu0YxUYkEk2EOMBzepHsp8WUMubavo9y8i4RZM7N+SBKhD/MZbluEI
 knXlbNv/abgP9GKS/dLa9oXc+UCkdXSbL16vwRaUbk6C4A1EuZWcM2+djdl4S0l03Po=
X-Gm-Gg: ATEYQzyqJMi7rqJ0wyAa9r+CZnRmK8cNZ3TtDo/fMHTTO/+naE8py0IG5gt8WZSiPj4
 ycsbsewvSs8HCH6CFVBO3MWhAtUFrqiFpO3Qn2caBxHskb+rFu6QWSKNpZN0oHLTnujpGObNfVC
 ShGpi22sZrhUBRdb2hxn3Mq5S+jizEwVFArb2oDwyleRPZhf15tCe2D5pyNjrXgZfwvdpytbefx
 zzXzpLKOM2VCPhpdzYeJtFOhLtjjG4SV3xnOzJfhV2Nq7jUZEp5Wvjc9IzX9b29TdivaC+9wvsn
 hiMFVcvnrmISPYb+FBXVpp6nqbaER1c6MmYDrkRyLXUcE9FaDY6SnTEp4pJKLvAs5dfvH9nrgpR
 lJGx/tQed11ntGyxWeP/w99/PyYkvsVl1NYl5JHKvDpK6WReOypRpZGbGbGsvnxDi7j3oISGWLT
 ncdvqg+PxXM+iGtW5AkOjw50H8QAsn6+S9YLwSTTDZ+GaPwOBXlhbvDbEk43uhgx9ZWC5JxidpT
 l9NFs0jCKPHCG9ssAuM2BkMRFZJRNKFAg6y2M5IHaRiCZw=
X-Received: by 2002:a05:6830:7003:b0:7d7:4ab4:ff2c with SMTP id
 46e09a7af769-7d78246ad89mr9317442a34.4.1773684454822; 
 Mon, 16 Mar 2026 11:07:34 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d76ac32913sm13255393a34.5.2026.03.16.11.07.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 11:07:34 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Mahammed Sadik Shaik <s-sadik@ti.com>
Cc: Raghavendra Vignesh <vigneshr@ti.com>, 
 Bajjuri Praneeth <praneeth@ti.com>, Paresh Bhagat <p-bhagat@ti.com>, 
 Bryan Brattlof <bb@ti.com>, Andrew Davis <afd@ti.com>, 
 Romain Gantois <romain.gantois@bootlin.com>
In-Reply-To: <20260211094919.571885-1-s-sadik@ti.com>
References: <20260211094919.571885-1-s-sadik@ti.com>
Subject: Re: [PATCH v2] configs: Add fragment config for snagfactory tool
Message-Id: <177368445377.2276702.15624923424492172647.b4-ty@konsulko.com>
Date: Mon, 16 Mar 2026 12:07:33 -0600
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

On Wed, 11 Feb 2026 15:19:19 +0530, Mahammed Sadik Shaik wrote:

> Introduce a new fragment configuration in u-boot to enable support for
> the snagfactory tool [1], used for factory flashing of boards. Snagfactory
> tool first recovers the board via USB DFU (peripheral boot), and then
> uses fastboot to flash given binaries/images to MMC or other on-board
> memory via USB. The fragment config can be used to generate boot binaries
> for board recovery. This fragment config needs to be added additionally,
> while building a53 images for USB DFU boot.
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] configs: Add fragment config for snagfactory tool
      commit: 948ccdc82f594c1a76ed97a2adee55b21097f03e
-- 
Tom


