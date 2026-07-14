Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99F54C44508
	for <u-boot@archiver.kernel.org>; Tue, 14 Jul 2026 17:56:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0077184D6F;
	Tue, 14 Jul 2026 19:56:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IOu3IMTr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A85E84D6F; Tue, 14 Jul 2026 19:56:16 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1CC9B84D62
 for <u-boot@lists.denx.de>; Tue, 14 Jul 2026 19:56:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7e9f1f24cbcso994107a34.0
 for <u-boot@lists.denx.de>; Tue, 14 Jul 2026 10:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1784051773; x=1784656573; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Kpg7oUg5zQW0NqmVdOhCzG3FW7mZVGBZhxVbHEO1COs=;
 b=IOu3IMTrybTWa3rfucOJtNmp/VK8MdtH1Y8ZulVL1epVkbbHO1CSjMKxFkMJq1LtRD
 JHVMu/DwrxcevgXubJwIqIjpSJIJKCa0jrQCbLXpouToIOc/e8qJ55tAz8DbLm61T0Hw
 2yX6CnQ2nkpNs+Q4PtYHssvuBUUbuPPu0a/iQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784051773; x=1784656573;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Kpg7oUg5zQW0NqmVdOhCzG3FW7mZVGBZhxVbHEO1COs=;
 b=rb/0feIEj8WdWJvezsA2lewubN3qY8xmmO/J7uFeN1ghZsc2gLo4OZ7xXUfWFE5JEY
 C87tNIv6EfBVFcIeorZZWhRHP2RSR/GeRFdpfH+vKq+l1L9SSYSxUKl1RDwGxbzr7703
 4qapMmnjsFMqwDki660ABv129vmUdYYqm01YHF9nNfQq9VHLJn4JDy2UWf8wbLei6cav
 Wn2LLkVcWybkM6bxiPiMWRGWOT9twg0+xFFqk2G2ujgHNFkS5DO5nf3ZKMtLSNXjO7sH
 BFq4gjgpS7UI+sCF4mY1mH8eAzfGmz71hF+vCuygz8xXlVGV6fJhjz46RTbL0txUvgVG
 FUKQ==
X-Gm-Message-State: AOJu0YxfWkWfzYVXROPY7sPwiTiKA23NjesUXiRRGymCy1s85QrSBY6v
 z6rEUma1rkPUvK+HzX3pg8GNPMkiEed2DdYM/0sYD/KZ8stxayPBqVwPQRVs6F/HhuY=
X-Gm-Gg: AfdE7cmEA7C+MY+LvxjzU9xUM8B/wu3tjmrsUHiWCIER4hilCOz+hx2M/HSckY3dqLK
 qMO0hKkNZiqVqLEMUrCOlycwFQCWVMKbHe53s3+aHetvf/fia7Kg7KEJrCkYSgw4BtbETGgU2Uo
 OHlhfuePcaDWfPx3/8tGvmneY0BM/OZzVXU/l6XXmUh9xFxguQABKd1tx97cIYmfE7J6QUUjdd+
 +gbfWWr5OpyN8sq3o2R+FapNw20eEMKSZzWYdDE2LjaXK5yu1P1DAWCcYH1wOnzIyK6rtO5kAUJ
 q9qMUokR6Dcw75BMUppZlGY8YioYDqtcS8UGq1gVxVGXjWbgy8yYNmYvnl4vrv9BBh097MFBRsJ
 qxsprIBryJh+S4IzyKWNSD9J+0HXvhQfs6SLZ2hxiHOEe0vGIotF5qvCIGA0YZlUk8VlTWNzeAe
 ALWGi65QA/GuG3icmWqcSTaiF+B05PcTYwVFJd9QbqspzR6k7ZnE25e1F/017hE6w1QraWQ1BoY
 +d5UqDoR/JTF46/b/yRaw6NOdmVvjV8jaN1
X-Received: by 2002:a9d:6a10:0:b0:7e6:c8e:89f3 with SMTP id
 46e09a7af769-7ebf26576d9mr7728867a34.6.1784051772876; 
 Tue, 14 Jul 2026 10:56:12 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7ebcae206e2sm15597648a34.2.2026.07.14.10.56.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 10:56:12 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: u-boot@lists.denx.de, Vincent Jardin <vjardin@free.fr>, 
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>, 
 Jonas Karlman <jonas@kwiboo.se>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
In-Reply-To: <alWfg8sSsnypWW5Z@nxa18884-linux-1.ap.freescale.net>
References: <alWfg8sSsnypWW5Z@nxa18884-linux-1.ap.freescale.net>
Subject: Re: [GIT PULL] Please pull mmc-for-2026.10-rc1
Message-Id: <178405177153.3971373.5372490935603949234.b4-ty@konsulko.com>
Date: Tue, 14 Jul 2026 11:56:11 -0600
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

On Tue, 14 Jul 2026 10:31:31 +0800, Peng Fan wrote:

> Please pull mmc-for-2026.10-rc1
> 
> ----------------------------------------------------------------
> Add PMBUS regulator, thermal and test
> Add regulator helper to set voltage within an acceptable range
> Update dw_mmc to use in-spec voltage range for vqmmc
> Fix regulator_enable/disable() macros
> Clear LPUART OR STAT in tstc to avoid hang
> Add MAINTAINERS entry for SDHCI
> ----------------------------------------------------------------
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


