Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A22ACD80BD
	for <u-boot@archiver.kernel.org>; Tue, 10 Oct 2023 12:24:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED0D481FA8;
	Tue, 10 Oct 2023 14:24:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="kgo8zV0o";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Yh9ELM/u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E15E486380; Tue, 10 Oct 2023 14:24:01 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED28D81420
 for <u-boot@lists.denx.de>; Tue, 10 Oct 2023 14:23:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=schwab@suse.de
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id AFF5321862;
 Tue, 10 Oct 2023 12:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1696940639; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OyDHbOum9Qhbv39jCg9W0xm8WJiUXesSaGXyBZu9s0E=;
 b=kgo8zV0oE6Banj5xyl5yBFPqlpKXMlvx+H9pLE5mE4mJmfG5FusOC824QwkaeYD3OS7Hel
 ixvd8g6iB1B1gpsxWRc/5WnMTTc3ISDVc1eaX2tl8nS8gcI9O9NPnX5D+OIFjpYUbDxCre
 fpRfR/vTBXLd6FVYTOsni6287nP4API=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1696940639;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OyDHbOum9Qhbv39jCg9W0xm8WJiUXesSaGXyBZu9s0E=;
 b=Yh9ELM/uxX1hlDs3sB2utkRKfJfAojrXTSWUt37OJ7JOatcvk1gvuOLPvpH6XAL1S5Y1E0
 36Dw+xf9e2jUv9Ag==
Received: from hawking.nue2.suse.org (unknown [10.168.4.11])
 by relay2.suse.de (Postfix) with ESMTP id 2654C2C437;
 Tue, 10 Oct 2023 12:23:58 +0000 (UTC)
Received: by hawking.nue2.suse.org (Postfix, from userid 17005)
 id 011A94A03A9; Tue, 10 Oct 2023 14:23:58 +0200 (CEST)
From: Andreas Schwab <schwab@suse.de>
To: Yanhong Wang <yanhong.wang@starfivetech.com>
Cc: <u-boot@lists.denx.de>,  Rick Chen <rick@andestech.com>,  Leo
 <ycliang@andestech.com>,  Joe Hershberger <joe.hershberger@ni.com>,
 "Ramon Fried" <rfried.dev@gmail.com>,  Torsten Duwe <duwe@lst.de>,
 Leyfoon Tan <leyfoon.tan@starfivetech.com>,  "samin . guo"
 <samin.guo@starfivetech.com>,  Walker Chen <walker.chen@starfivetech.com>,
 "Hal Feng" <hal.feng@starfivetech.com>
Subject: Re: [PATCH v5 10/11] ram: starfive: Read memory size information
 from EEPROM
In-Reply-To: <20230615093652.23161-11-yanhong.wang@starfivetech.com> (Yanhong
 Wang's message of "Thu, 15 Jun 2023 17:36:51 +0800")
References: <20230615093652.23161-1-yanhong.wang@starfivetech.com>
 <20230615093652.23161-11-yanhong.wang@starfivetech.com>
X-Yow: Everybody is going somewhere!!  It's probably a garage sale
 or a disaster Movie!!
Date: Tue, 10 Oct 2023 14:23:58 +0200
Message-ID: <mvmlecaoech.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
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

On Jun 15 2023, Yanhong Wang wrote:

> StarFive VisionFive 2 has two versions, 1.2A and 1.3B, each version of
> DDR capacity includes 2G/4G/8G, a DT can not support multiple
> capacities, so the capacity size information is recorded to EEPROM, when
> DDR initialization required capacity size information is read from
> EEPROM.

Does that acutally work?  I see that read_eeprom fails in SPL.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
