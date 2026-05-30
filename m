Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD767CD6E49
	for <u-boot@archiver.kernel.org>; Sat, 30 May 2026 14:16:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F71E84671;
	Sat, 30 May 2026 16:16:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="hD2CPjYs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7237A84693; Sat, 30 May 2026 16:16:43 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D4D58405A;
 Sat, 30 May 2026 16:16:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gSMjM6B3Yz9t65;
 Sat, 30 May 2026 16:16:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1780150599;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KyNoFhpqXLDDuw6wdS3kJlKFIG5DhTV/FOZweUxwZoo=;
 b=hD2CPjYsi9AOdkFkDdZqxdc2BPFWiMde8icG+om17ivBV1JBhldZa2Fc6m/5RioyeJMi3W
 Va9lI4GwbmQtzvbWDZbJlYIp4Q1eNhJF3rMtL49grICkEc9LQkb5YgbeE7+LjrB4uvzXt2
 SOjCv9hGt2sccJdzDXRO1hNCR+LWm3Wyr6/RwxocYhDOq9GxB5YyqLEu4IGsl7Lw04SiXS
 TbZtn9PNSbneBGuj5ClGaGr9E/rVc+BOGnrOFha+iGvj10pEyKfSaWE4qpt15+XVM+dzWT
 9qZvCPOOhTYGm2Vx0jRK///+lPCcPNLmDkSpjhALqtjkDNjvsgh7elRvZp4XnA==
Message-ID: <e7d1a88c-6542-40eb-b21b-b9382bdf5306@mailbox.org>
Date: Sat, 30 May 2026 16:16:34 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] lmb: Reinstate access to memory above ram_top
To: Tom Rini <trini@konsulko.com>
Cc: Peter Robinson <pbrobinson@gmail.com>, Gary Guo <gary@garyguo.net>,
 u-boot@lists.denx.de, Matthias Brugger <mbrugger@suse.com>,
 Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Holger Brunck <holger.brunck@hitachienergy.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Mark Kettenis <kettenis@openbsd.org>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, U-Boot <u-boot-bounces@lists.denx.de>
References: <20260127234856.1503030-1-marek.vasut+renesas@mailbox.org>
 <177343529761.1131472.9417054395876652663.b4-ty@konsulko.com>
 <DH9MF45X89KK.1CV4WUVTCTUO5@garyguo.net>
 <CALeDE9PARyt0iUvnfbSfz=rSA2RkQ1AcoaJpU=8RgnYivaPNEA@mail.gmail.com>
 <20260529154446.GC627328@bill-the-cat>
 <CALeDE9MAE6r3pFzNRDbwAXkkkWrZo_0gXEMTavmpnGjQBoxrVQ@mail.gmail.com>
 <c9e810ac-6c0e-4a66-bbae-d6557a26197b@mailbox.org>
 <20260530140644.GG627328@bill-the-cat>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260530140644.GG627328@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 78ysaqezk6nugwgbjd7aedyqfj9xrix5
X-MBO-RS-ID: da4a46eb3688ca11dd6
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

On 5/30/26 4:06 PM, Tom Rini wrote:

>> The revert is wrong as that breaks other things , like use of DRAM above 4
>> GiB boundary, which is exactly why this change was implemented. If RPi has
>> limitations, then those limitations should be imposed on RPi, not globally,
>> so add the LMB reservations on RPi.
> 
> Isn't the case you describe still a theoretical and not used in tree
> case?

No, this is used by the Sparrow Hawk board, which depends on it.

> And note that Ilias' patches to relocate to the top of memory also
> fail on Pi. So there's something to be debugged here and worked out
> before we add this seemingly enhanced behavior. Hence, the need to
> revert it for now until it can be fixed.
We still have two RCs to go, so I don't see the need for a hasty revert 
that breaks other systems, esp. if Ilias is looking into the RPi 
situation now, and I already offered a way to fix the RPi in the short 
term without breaking the other systems.
