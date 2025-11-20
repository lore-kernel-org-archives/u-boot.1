Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5236CF8548
	for <u-boot@archiver.kernel.org>; Thu, 20 Nov 2025 06:54:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7FEE83FF8;
	Thu, 20 Nov 2025 07:54:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="MjW473u5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A4648404D; Thu, 20 Nov 2025 07:54:12 +0100 (CET)
Received: from mx-relay15-hz2.antispameurope.com
 (mx-relay15-hz2.antispameurope.com [83.246.65.157])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1462C83E0E
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 07:54:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=0412a300e1=max.merchel@ew.tq-group.com
ARC-Authentication-Results: i=1; mx-gate15-hz2.hornetsecurity.com 1; spf=pass
 reason=mailfrom (ip=94.100.132.6,
 headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com
 smtp.helo=hmail-p-smtp01-out04-hz1.hornetsecurity.com; dmarc=pass
 header.from=ew.tq-group.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=boGL6egLKkXw/4LgMCvV9N+UV+HFO1AFQFGkzbKxhmc=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1763621649;
 b=D0KRFQz1QAMZwZpunRDQAJ+PsEyC3mSPKnkThDNeHRzmUPjhoQIgVxofUJz91r+M+uNGbC60
 fUdRb4kBf1eCMxc+1Xf/Ciau2avDWVLpC2Zij8PbEeCT04RCEU0Zd7LKcm33DUWsFobx00F2lPJ
 A0uopX1OhG+GVv59BpvFdcKFCC2KXSXTl2FSGE2BCuZPxiPSw2dfpcc0Gp8ElfJcfgzqcllcWfV
 B+fSUN0eEH7mBTRBDrhFpALNVpK/sMDlJv51wsVJ12+1bRnbOoppbNoySn0VnvNtWTBXzCqSOwd
 NRhpakBYXULp3BhbOu7LjsHOJKszjHKD18FqW+w51gAiA==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1763621649;
 b=Ll9B+E7XWIRLOkL+mBP+v0GKjNLTf6S+J/b4p6xQ3SDkqeWlt3TFfsFKmCBfMpyzT3KQ2BA5
 f/fdwhnFLItf+UGrA4dtDBS5mJ0B95iH/Ndq+Tq/dlS/NzFmiRHK0/AxOYVEPMKx00qgu+wP5YC
 AUWr0NcHbrBByYXXX6ohLI/oTCZ27rPND1excI3Y9qTTy7T46p2ZeKnWgAGzQvuGyhOd/5r2V6M
 zHynfHPWIxIUUvrcH0W8N+219IorcLho1mecC8yBC4dUHwmCEdPWepWipTPPjXbzfNuR3t/tkAu
 i8YuINm0JGbfmkFtzzXe5zNE5K/RLiXD2ZVV7Weqyh1Tg==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by
 mx-relay15-hz2.antispameurope.com; Thu, 20 Nov 2025 07:54:09 +0100
Received: from [10.123.75.134] (host-82-135-125-110.customer.m-online.net
 [82.135.125.110]) (Authenticated sender: max.merchel@ew.tq-group.com)
 by hmail-p-smtp01-out04-hz1.hornetsecurity.com (Postfix) with ESMTPSA id
 52044220D72; Thu, 20 Nov 2025 07:54:02 +0100 (CET)
Message-ID: <b8e5c4a2-8338-404d-9650-0a12ad8c5cdc@ew.tq-group.com>
Date: Thu, 20 Nov 2025 07:51:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tqma6: Stop disabling device tree relocation
To: Tom Rini <trini@konsulko.com>
Cc: Markus Niebel <Markus.Niebel@tq-group.com>, u-boot@lists.denx.de
References: <20251118180433.591487-1-trini@konsulko.com>
Content-Language: en-US
From: Max Merchel <max.merchel@ew.tq-group.com>
In-Reply-To: <20251118180433.591487-1-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-cloud-security-sender: max.merchel@ew.tq-group.com
X-cloud-security-recipient: u-boot@lists.denx.de
X-cloud-security-crypt: load encryption module
X-cloud-security-Mailarchiv: E-Mail archived for: max.merchel@ew.tq-group.com
X-cloud-security-Mailarchivtype: outbound
X-cloud-security-Virusscan: CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on
 mx-relay15-hz2.antispameurope.com with 4dBpwp47HVz2Fb1X
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1,
 IP=94.100.132.6
X-cloud-security-Digest: 5454fd455e8a6a0910e8f764609accf5
X-cloud-security: scantime:1.825
DKIM-Signature: a=rsa-sha256;
 bh=boGL6egLKkXw/4LgMCvV9N+UV+HFO1AFQFGkzbKxhmc=; c=relaxed/relaxed;
 d=ew.tq-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1763621648; v=1;
 b=MjW473u5+vixPd4zTkBmEhaAtAOIoHx0Jn09lOPrb9HjSD+xxSbW7P4pUQAbuX8/hhPlXEMs
 0P0GlktUaNa8+Jlqf8yOlslQoZwpnW1KZcEc4diaCvfj5Rbr/A5mJszWz6NTnY/EjTZtcbK7/JG
 CAym+fYiA6yD0Joq6LpOPZBJze6W9YpsZAr1o2Wese7zhyU17W0K84TS542C44VmvP7+hILeSN/
 +dZ9zvIKOApRykcPG6eEa4ek1Alx5kkvEeySjWrhv67/6x63fAHV3o2W0mEE8FdKJychPIKqJcy
 PvaNXaC7KvBjo5Pc5yKGjJu7ZezUVG6+yOs9a7ZPB3ISA==
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



Am 18.11.25 um 19:04 schrieb Tom Rini:
> Remove setting of fdt_high to ~0, which disables device tree relocation,
> from the default environment. Doing so prevents U-Boot from correcting
> problems such as having an unaligned device tree and leads to various
> failure modes in the OS.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> If there is some window of memory that must be used for where the device
> tree is relocated to, bootm_low + bootm_size (or often just bootm_size)
> or bootm_mapsize are the correct way do this. Please see
> doc/usage/environment.rst for more details.
> 
> Cc: Markus Niebel <Markus.Niebel@tq-group.com>
> ---
>   include/configs/tqma6.h | 1 -
>   1 file changed, 1 deletion(-)
> 
Acked-by: Max Merchel <Max.Merchel@ew.tq-group.com>

-- 
Best regards,
Max

TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
http://www.tq-group.com/

