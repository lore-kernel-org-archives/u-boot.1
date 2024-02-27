Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E29AC5478C
	for <u-boot@archiver.kernel.org>; Tue, 27 Feb 2024 15:55:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D603187FAA;
	Tue, 27 Feb 2024 16:55:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="NSfTTxZN";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="CtKNuZKO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F1BB287FE3; Tue, 27 Feb 2024 16:55:31 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D2CF387F73
 for <u-boot@lists.denx.de>; Tue, 27 Feb 2024 16:55:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4TkhsF4rPYz9t2x;
 Tue, 27 Feb 2024 16:55:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1709049329;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YowR2Dv7ImjTIsolh9p6dMH7Bne9PzTAaD7SNqmKwO0=;
 b=NSfTTxZNMAI+y9E9iBwmrF1KuYKznvkqUy0cYgp1HRTg9fsSGaH1WtlZFcwYZodTEkMAaS
 hx5Q4YjkYzIlivoq8/wla7uyMuj6UB9OXf6hlKlX4yK9+DAmHmVsv28iR5RHUuWhu8i3FB
 a9c7xWVmvTGVhdHIPF7CTGvpGCks6a8sr6LinetFQbHOw9te5qEfxh6KG0xmvmdloOaWiS
 bw/FA0j8RUPG+H04vQnD9PlqCUxLPEiwLAmXUqsRjW10P7IEKY7e5VcC55FscN8zLjD0Dr
 X+FUiEEDdTx9o4nYdmodgFh2ysbF5Vt5UwRM/zT7B7WLVfH7r2h+GQ8tU6eOiw==
Message-ID: <bf768e09-e083-4a7e-ad50-886ef00e7573@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1709049327;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YowR2Dv7ImjTIsolh9p6dMH7Bne9PzTAaD7SNqmKwO0=;
 b=CtKNuZKOqqJIzK4ecCVK7N2ihn0QI1nscK7pdpWbR5228BslW+SE4YzEOKEFS+CBRDlU84
 tuiATXMMOl9Zd0+CaDJy0aRM0uvXcwqQZpU67iJmYU6poXbM7E6LYqczKV5VLSbc7zo2tn
 GCM0YDy4crCpQ3WoyxH0/DUQoy2vBPDM6BzqOTNG0FVcAovWEogITi/MRfKY8G97/0PcnO
 fsKgO8q53Th8+oH8kF1Jx0ugAtf5jR0rOP36sETTuiZR4UaaKi9k2Ak9LqptYwP5RIuj1e
 Dr5ckMuCSwyRhihvYeVbIRidq5X0Cx0rBJCNnZR9CCqyTd2n2m2YRylZzcJtRA==
Date: Tue, 27 Feb 2024 16:55:25 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v2 5/7] sysreset: Support reset via Renesas RAA215300 PMIC
Content-Language: en-US
To: Paul Barker <paul.barker.ct@bp.renesas.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: u-boot@lists.denx.de
References: <20240226150536.1690-1-paul.barker.ct@bp.renesas.com>
 <20240226150536.1690-6-paul.barker.ct@bp.renesas.com>
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20240226150536.1690-6-paul.barker.ct@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: qugpmirn9jmeih6djsjxy4njmwanuq3c
X-MBO-RS-ID: 195ee9dc7eb132caef8
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

On 2/26/24 4:05 PM, Paul Barker wrote:
> This patch adds support for resetting a board via the RAA215300 PMIC.
> 
> Note that the RAA215300 documentation names the available reset types
> differently to u-boot:
> 
>    * A "warm" reset via the RAA215300 PMIC will fully reset the SoC
>      (CPU & GPIOs), so this corresponds to SYSRESET_COLD.
>    
>    * A "cold" reset via the RAA215300 PMIC will cycle all power supply
>      rails, so this corresponds to SYSRESET_POWER.
> 
> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>

Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
