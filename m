Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72D10C43458
	for <u-boot@archiver.kernel.org>; Thu,  9 Jul 2026 15:18:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA7FB84B88;
	Thu,  9 Jul 2026 17:18:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="QUpq+W11";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BC5A84B9B; Thu,  9 Jul 2026 17:18:26 +0200 (CEST)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F80B84B77
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 17:18:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 1723B117C81; Thu,  9 Jul 2026 17:18:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1783610303;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=fk9rpVhxbFmFfwS4DfNsFsfI7CGDWs90rPVMfB49AmU=;
 b=QUpq+W11Vq6FECbuNOVfvULPzlf3k4k8B1klkon2V5PeZ2NVcxRG4Yg0aEw7CNf57e8bRe
 pjHb/647v5TCUblF/kCZ6BAtQycGNAeil1Ac8d+e0HecNe94VC3ES2FkLe5EAwfJLfBufb
 jgmy5bP9RnRcH80Lral5Ecp7m30iCxdGTM3f+vktntAROb4qHsGHx7oQ+BZ6FTYN3PGdJ/
 Xc+GFypjD0x8siXVlTWa1A0U+hvYU8aS+KyPTVxepovBFKRkL/xFWsKqvAgUixX0F5uym3
 OhlMaomC6owsyPoWSESJoPHBZErLGxZOHtGeNAF2NF4vdnuPXjN30+K1w6COiw==
Message-ID: <ef429e32-2b06-a6df-91be-d720ac62e5ab@nabladev.com>
Date: Thu, 9 Jul 2026 17:17:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2] cmd: kconfig: i2c: add missing I2C API dependency
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>, Julien Stephan <jstephan@baylibre.com>
Cc: u-boot@lists.denx.de,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>,
 Peter Robinson <pbrobinson@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Andrew Goodbody <andrew.goodbody@linaro.org>
References: <20260702-cmd-i2-add-dm-i2c-dependency-v2-1-e048ab426191@baylibre.com>
 <20260702163358.GA749385@bill-the-cat>
From: Heiko Schocher <hs@nabladev.com>
In-Reply-To: <20260702163358.GA749385@bill-the-cat>
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

Hello Julien,

On 02.07.26 18:33, Tom Rini wrote:
> On Thu, Jul 02, 2026 at 05:26:57PM +0200, Julien Stephan wrote:
> 
>> CMD_I2C relies on either the Driver Model I2C API or the legacy I2C
>> API, but its Kconfig currently does not enforce either dependency.
>>
>> As a result, enabling CMD_I2C without DM_I2C or SYS_I2C_LEGACY can lead
>> to link errors due to unresolved i2c_* symbols.
>>
>> Require either DM_I2C or SYS_I2C_LEGACY to prevent unsupported
>> configurations while preserving support for legacy platforms.
>>
>> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> 
> Reviewed-by: Tom Rini <trini@konsulko.com>
> 

Applied to u-boot-i2c.git

Thanks!

bye,
Heiko
-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
