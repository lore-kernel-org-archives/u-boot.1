Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40104CD6E48
	for <u-boot@archiver.kernel.org>; Thu, 13 Nov 2025 12:52:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E5F383F98;
	Thu, 13 Nov 2025 13:52:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="CQ5Uzwk9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE83583F98; Thu, 13 Nov 2025 13:52:33 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C494F839B7
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 13:52:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 8BE51108FF1; Thu, 13 Nov 2025 13:52:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1763038349;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=caIywPJ72iVbUC+HuwhNcuAY1Wi8ks6TLeQ4fR1eEnQ=;
 b=CQ5Uzwk94ubYE2OaGOxymCE4RTtQCeTiKgmib4LGyySF97BVZjA3fIlCj1K4eQWCjHSpET
 XMYNP8Go36v56k48YpJbs/FHHKvNKdwm5cRpPFCWtYSwzmiq1FgKSyyx0ZbLXj+GJiI/An
 CYLDSpJAw6SccxTraaIe0xBKqiFEc3KLkuri5yARZocGojG/CVqgQPrroz0VCAQgH2NIXs
 mdQ188hABvmYGEZ6b4J1nnvsyQ8SlY0iDzfEChUXgJD0Ac/OJN8jk7DMNqny0H2AYOmsCf
 pFQdD5NoJTyJTlWFW4ce+KYC6Tvei1qund3AUd3jD3l29U4MG8rjF60nBwLIjw==
Message-ID: <34249203-6c09-06b2-3d8b-3389e7fe34f7@nabladev.com>
Date: Thu, 13 Nov 2025 13:52:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 1/2] sandbox: Fix DT compiler address warnings in sandbox
 DTs
Content-Language: en-US
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Christian Marangi <ansuelsmth@gmail.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Simon Glass
 <sjg@chromium.org>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>
References: <20251113115658.947953-1-marek.vasut+renesas@mailbox.org>
From: Heiko Schocher <hs@nabladev.com>
In-Reply-To: <20251113115658.947953-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Hello Marek,

On 13.11.25 12:56, Marek Vasut wrote:
> Trivially fix the following warnings in sandbox DTs, which show up with
> DTC 1.7.2. Fill in the missing address and adjust emulated I2C address
> to fit the 7bit address limit:
> 
> "
> arch/sandbox/dts/sandbox.dtsi:138.30-140.5: Warning (i2c_bus_reg): /i2c@0/sandbox_pmic: I2C bus unit address format error, expected "40"
> arch/sandbox/dts/sandbox.dtsi:146.18-161.5: Warning (i2c_bus_reg): /i2c@0/emul: I2C bus unit address format error, expected "ff"
> arch/sandbox/dts/sandbox.dtsi:148.4-17: Warning (i2c_bus_reg): /i2c@0/emul:reg: I2C address must be less than 7-bits, got "0xff". Set I2C_TEN_BIT_ADDRESS for 10 bit addresses or fix the property
> "
> 
> "
> arch/sandbox/dts/.test.dtb.pre.tmp:912.18-926.5: Warning (i2c_bus_reg): /i2c@0/emul: I2C bus unit address format error, expected "ff"
> arch/sandbox/dts/.test.dtb.pre.tmp:913.4-17: Warning (i2c_bus_reg): /i2c@0/emul:reg: I2C address must be less than 7-bits, got "0xff". Set I2C_TEN_BIT_ADDRESS for 10 bit addresses or fix the property
> arch/sandbox/dts/.test.dtb.pre.tmp:928.30-931.5: Warning (i2c_bus_reg): /i2c@0/sandbox_pmic: I2C bus unit address format error, expected "40"
> "
> 
> Fix up pmic test to match.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Christian Marangi <ansuelsmth@gmail.com>
> Cc: Dinesh Maniyam <dinesh.maniyam@altera.com>
> Cc: Guillaume La Roque <glaroque@baylibre.com>
> Cc: Heiko Schocher <hs@nabladev.com>
> Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Svyatoslav Ryhel <clamor95@gmail.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de
> ---
>   arch/sandbox/dts/sandbox.dtsi | 6 +++---
>   arch/sandbox/dts/test.dts     | 6 +++---
>   test/dm/pmic.c                | 4 ++--
>   3 files changed, 8 insertions(+), 8 deletions(-)

Good catch, thanks!

Reviewed-by: Heiko Schocher <hs@nabladev.com>

bye,
Heiko
-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
