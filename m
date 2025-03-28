Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6610FC28B20
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 05:03:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DC3D8082A;
	Fri, 28 Mar 2025 06:03:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1743138211;
	bh=FA0NNsN2u3mNoW/DdIk+u1JP7vzPwO8hf6a9l0b9SFo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=O9qDf7ycLmdhKAa+2TZZCQH/dCucZGSLnAULIv8pD3ZdcZmMj0taixPNxmXtZVcdp
	 vg4CnT3Ty9OLgvFxpIBQZC5m49/a+nhS5ftKoPTKbfb6SQIy/1Ye22nQWrsQwUwJez
	 G3snGLejlNXLqW9Fn2CievstMK53Q+qrs5JQzOrNgU4BOyUfhD+GvZHk64JyVkZ+ce
	 +Mi+02dX8JumY8OfD76Id4e8hhZ8WwJqWX/C/yoV+v4Bt7+d4a0UL2DzVHUuR+slBI
	 S7Z/ybJvQD4PXfZHLMES2f2fC95ycfQqQvA2ArzrCDdpjvx2/5rncChcHtzAiOW5em
	 cyjvZDG3Wb4zQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0EA12809A4; Fri, 28 Mar 2025 06:03:31 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 04BB3805C8
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 06:03:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="BqfR1N67"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 63577102EBA52; Fri, 28 Mar 2025 06:03:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1743138207;
 h=from:reply-to:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=FA0NNsN2u3mNoW/DdIk+u1JP7vzPwO8hf6a9l0b9SFo=;
 b=BqfR1N67GcLESQRWFXCZI4Jor9uCSvA2OeFFG2CphgpWGzu0vBSN0oEueqlWIQiwsW2dbr
 5/piuYJFR0Zo5KbZcaBfu4TUzpDNVmDBQT1mrzSkM/uIEka1Cfj/A58SDSOTLQXDGeF+16
 X5ALS1n3XMORp65nhkSysHVmFF2g5vMNR2dPJVf/woOfcF3SVVQE6gOrlAjVW8+TUSpcH+
 rKuSiwEh/Wh3LXR4IGt5rtkxNcCxpoKOsvIXKl4ToavgIpMEF9aA7+9NYejbZSC5Z7Nw6+
 389r8fQ/G3RpMefH6WZg00QmfN5VwmtRY6lQDVZohQMDTXtmkCT3GKKl2DnlDw==
Message-ID: <8309fe3b-c096-b1a3-5ad8-a441afca19b5@denx.de>
Date: Fri, 28 Mar 2025 06:03:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 12/18] mtd: ubi: annotate fallthrough
Content-Language: en-US
To: Andre Przywara <andre.przywara@arm.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Kyungmin Park <kmpark@infradead.org>
Cc: Marek Vasut <marex@denx.de>, Michal Simek <michal.simek@amd.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
References: <20250327153313.2105227-1-andre.przywara@arm.com>
 <20250327153313.2105227-13-andre.przywara@arm.com>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <20250327153313.2105227-13-andre.przywara@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Reply-To: hs@denx.de
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello Andre,

On 27.03.25 16:33, Andre Przywara wrote:
> The UBI code uses an implicit switch/case fallthrough when handling two
> related cases of bad header errors. Also there is a switch/case for unit
> prefix handling (G/M/K), which accumulates multiplications.
> 
> Add our "fallthrough;" statement-like macro before the respective labels
> in both cases, to avoid a warning when GCC's -Wimplicit-fallthrough
> warning option is enabled.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>   drivers/mtd/ubi/attach.c | 1 +
>   drivers/mtd/ubi/build.c  | 3 +++
>   2 files changed, 4 insertions(+)

Reviewed-by: Heiko Schocher <hs@denx.de>

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
