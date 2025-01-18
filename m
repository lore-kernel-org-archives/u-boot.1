Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B45FC02185
	for <u-boot@archiver.kernel.org>; Sat, 18 Jan 2025 08:00:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A05A78070C;
	Sat, 18 Jan 2025 09:00:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="O5G/VcMd";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="rPdtkBD0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1ADA8073D; Sat, 18 Jan 2025 09:00:26 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0D7480657
 for <u-boot@lists.denx.de>; Sat, 18 Jan 2025 09:00:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4YZptc300Wz9sn6;
 Sat, 18 Jan 2025 09:00:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1737187224;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DN0bZ+HV9gMagW1urmaDDZJ0YqOCSAqzoAQjG5rvJuY=;
 b=O5G/VcMdM+wOi3rqUqs5kQvVTlujhTziiib60DQq/Qzeuhw7W07ZIoS1ElCL9MtnUFYsKn
 Ld+5Yiszx+fyXqPVwSrhcSvv/b/Ms7HyxlmTfwl+B//FhM3HqgsSncFFE2EbmL0m5InQGs
 eBQpc65Vee3hSZfy2iX1TxaDXYi6Ur/fxMhWK+UivyaKviO16Duf8iDwJZ9sFpyK1zMz1A
 lvILrHGqYDDhoU0hlYItoBIAWQIoaXxyB9uGcE95Zm2bYX98LDURsuhdgBNMRJJXXwriX1
 tNm5vzTrRotpK9kBQpF7jOAZEnpbes8ckzCnMGb1pE1wZ/aMMul+miIWbee9xA==
Message-ID: <ce9f3420-b03c-4b27-b712-fe7a9dccebb0@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1737187222;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DN0bZ+HV9gMagW1urmaDDZJ0YqOCSAqzoAQjG5rvJuY=;
 b=rPdtkBD0lWvAj1k6lE1fElDK7Mhs8uy0JzxAss15qy5r7WUlBY0FTwxEUnY19ktn+ZoPIw
 rRawBVMeSDIaUs5OAu29a4dtmDoQsxqB+qakAP3+qYPBS8rDVhRFzRzwTVbZSZ23QGrplC
 azWy2xQIEPW3T020pRMhiSjOmhEiHmY99+svzxmFcq48XOOSHUfq8VNUmdBMOvlgBBqAri
 MvWAQbzFxDFzmGakzAd7kACdjbOA6mMEOJ8unzLBLeH47vFQkcE7mPMYlQXn7xwM0bEjGh
 b4IXybCpD/R4T1PLcn/mOAUGQB7guU+1T03nSXiOortkkvb1jAlJ81Skfu7Iaw==
Date: Sat, 18 Jan 2025 08:56:14 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 8/8] arm64: renesas: Deduplicate R-Car Gen3 and Gen4 SPL
To: Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Adam Ford <aford173@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
References: <20250112223528.179828-1-marek.vasut+renesas@mailbox.org>
 <20250112223528.179828-8-marek.vasut+renesas@mailbox.org>
 <b2ed3bad-9c9f-433e-979b-557d646978f3@cherry.de>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <b2ed3bad-9c9f-433e-979b-557d646978f3@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 8fey34mthb7aosxu31o17egwim5nh9kd
X-MBO-RS-ID: 627e35139eacccb9e0d
X-Rspamd-Queue-Id: 4YZptc300Wz9sn6
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

On 1/15/25 11:34 AM, Quentin Schulz wrote:

[...]

> Wondering if we couldn't use variables to make the Makefile a bit easier 
> on the eye (though not necessarily more readable)?
> 
> Something like
> 
> ifdef CONFIG_XPL_BUILD
> SPL_COMMON := spl
> else
> SPL_COMMON := common
> endif
> 
> obj-y += rcar64-$(SPL_COMMON).o
> 
> Then we could use it for gen3 and gen4 object files as well for example.
> 
> I really struggle to parse Makefile/C code when there are a lot of 
> ifdefs especially once they get nested, but maybe that's just me :)
What I would like even a bit more would be:

obj-$(!SYMBOL) +=

An inverted match, add stuff into build if symbol is not set.
