Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D066FCCA470
	for <u-boot@archiver.kernel.org>; Wed,  1 Oct 2025 00:53:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04CB1802C1;
	Wed,  1 Oct 2025 02:53:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="LaDhqpQY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AECC4807C0; Wed,  1 Oct 2025 02:53:14 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4DC7680107
 for <u-boot@lists.denx.de>; Wed,  1 Oct 2025 02:53:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4cbxHV2VN7z9tf6;
 Wed,  1 Oct 2025 02:53:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1759279990;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GCrtmL/I6Gwe3JucUYWP2KEyymYx/zyw/flg7s7yht0=;
 b=LaDhqpQYq1bcQVd2IUNZ7CnG8max7ggJpur6FzrW+yScY5Cm/WZazs5MPGDMiNYwAJ3hh4
 FJ4FPaf8rLxa/rPXF7ZzUVLP6BF1Yu1q1k/GzVwv37ZbxbbUwUq/PMdbFfKtFYEuZR7O4N
 u84fgXoNKyVN9OuClCHl8QuS+qGUTWSFyytU9RhmBMBG7TB21W5fHSbw4jnYdYxrjjUfIr
 jdQycBFYm0rs/FI1NtzfQm+jZ9mPaNED76t/gD/vX7MG08wnsxP19VrKcQdQDVnK/cBFJd
 wDyzu3TWmnvnGlrGbXFEebDBAubGilonqrCFfHSJR8uXVxZv+My03NChk/e85Q==
Message-ID: <025f7ea1-8710-4f99-b0ac-3f86c163d7dd@mailbox.org>
Date: Wed, 1 Oct 2025 02:53:08 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/3] apple: Set up file system firmware loader
To: Mark Kettenis <mark.kettenis@xs4all.nl>
Cc: kettenis@openbsd.org, u-boot@lists.denx.de, trini@konsulko.com
References: <20250929195241.70351-1-kettenis@openbsd.org>
 <20250929195241.70351-2-kettenis@openbsd.org>
 <c7163cf3-b108-45a1-8b03-0a09a0429032@mailbox.org>
 <87ms6cdmh1.fsf@bloch.sibelius.xs4all.nl>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <87ms6cdmh1.fsf@bloch.sibelius.xs4all.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: adk35gjcbo6mgfk6fpxm68rk8tpyy4w3
X-MBO-RS-ID: 81022f305cbfc268e92
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

On 9/30/25 4:49 PM, Mark Kettenis wrote:

Hi,

>> Maybe try request_firmware_into_buf_via_script() instead ?
>>
>> That might make this more flexible /wrt firmware location and user
>> preferences.
> 
> I'm not sure about that.  For one thing, I thought there was a push to
> move away from scripts.

There was ? This script based firmware loader interface is in fact new, 
it allows users to provide the firmware whichever way they see fit. If 
the firmware loader should be locked down, that is up to the user.

> At least that was a major driver for
> replacing distroboot with bootstd.  Granted, the motivation for that
> was secure/trusted/verified boot, which is something I personally
> don't care all that much about.
> 
> Writing a script that implements the logic of asahi_esp_devpart() is
> also not trivial.  Especially because there are no actual working
> examples of such a script in U-Boot.  At least I can't find any
> definitions of the "mt7987_i2p5ge_load_pmb_firmware",
> "mt7987_i2p5ge_load_dspbit_firmware" or
> "mt7988_i2p5ge_load_pmb_firmware" scripts that are used by
> drivers/net/phy/mediatek/mtk-2p5ge.c.  And that is currently the only
> driver that uses request_firmware_into_buf_via_script().

R-Car Gen4 PCIe is being switched over to that interface too.

The script looks something like this:

renesas_rcar_gen4_load_firmware 'env set 
renesas_rcar_gen4_load_firmware_addr 0x54000000 && load mmc 0:1 
${renesas_rcar_gen4_load_firmware_addr} lib/firmware/rcar_gen4_pcie.bin 
&& env set renesas_rcar_gen4_load_firmware_size ${filesize}'

> I'd prefer to keep using request_firmware_into_buf() until there is an
> actual use case that requires more flexibility.  For now I'm not aware
> of any hardware besides the Apple M2 and M2 Pro machines that have an
> ASMedia PCI XHCI controller that requires loading firmware.

My use case for the PCIe controller was loading the firmware from 
another location (tftp) during development.
