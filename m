Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49EB7D7877B
	for <u-boot@archiver.kernel.org>; Thu, 21 Nov 2024 15:25:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ADB4A891AF;
	Thu, 21 Nov 2024 16:25:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="RPQY2oyz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="XC8ocf7r";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RPQY2oyz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="XC8ocf7r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3EF75891C4; Thu, 21 Nov 2024 16:25:01 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1DCAA891AB
 for <u-boot@lists.denx.de>; Thu, 21 Nov 2024 16:24:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=schwab@suse.de
Received: from hawking.nue2.suse.org (unknown
 [IPv6:2a07:de40:a101:3:92b1:1cff:fe69:ddc])
 by smtp-out1.suse.de (Postfix) with ESMTP id 7FFF721923;
 Thu, 21 Nov 2024 15:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1732202698; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UNrl5ZEANpbbHMI7JP2Kt8KM9MCQ4NvoOzdhroltUso=;
 b=RPQY2oyze7H0/36dZoRXa/dqkabLPj0jNO+f49Npfl3xwo9a+0NFUliOg3xJp8J0mMEO3R
 XRWEiBgqgYLohLzqJI7GmgFJHLts0e6nkN4E7vbyjcua9RCIxAuKLC+V+zWk/qPsvaGB93
 upnILytbANg93YmPOBLMrQa7/HGOJ6Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1732202698;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UNrl5ZEANpbbHMI7JP2Kt8KM9MCQ4NvoOzdhroltUso=;
 b=XC8ocf7rpCkfhQI4XMz6y9C00I4R6XiP0UlUjwmgBjMT5ZIwybz/GbM5vQqpdTKpmMsqVl
 JUQdK4ryup8ZzhBw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=RPQY2oyz;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=XC8ocf7r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1732202698; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UNrl5ZEANpbbHMI7JP2Kt8KM9MCQ4NvoOzdhroltUso=;
 b=RPQY2oyze7H0/36dZoRXa/dqkabLPj0jNO+f49Npfl3xwo9a+0NFUliOg3xJp8J0mMEO3R
 XRWEiBgqgYLohLzqJI7GmgFJHLts0e6nkN4E7vbyjcua9RCIxAuKLC+V+zWk/qPsvaGB93
 upnILytbANg93YmPOBLMrQa7/HGOJ6Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1732202698;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UNrl5ZEANpbbHMI7JP2Kt8KM9MCQ4NvoOzdhroltUso=;
 b=XC8ocf7rpCkfhQI4XMz6y9C00I4R6XiP0UlUjwmgBjMT5ZIwybz/GbM5vQqpdTKpmMsqVl
 JUQdK4ryup8ZzhBw==
Received: by hawking.nue2.suse.org (Postfix, from userid 17005)
 id D8E614A055F; Thu, 21 Nov 2024 16:24:55 +0100 (CET)
From: Andreas Schwab <schwab@suse.de>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Minda Chen <minda.chen@starfivetech.com>,  Ilias Apalodimas
 <ilias.apalodimas@linaro.org>,  Rick Chen <rick@andestech.com>,  Leo
 Yu-Chi Liang <ycliang@andestech.com>,  Hal Feng
 <hal.feng@starfivetech.com>,  Tom Rini <trini@konsulko.com>,  Chanho Park
 <chanho61.park@samsung.com>,  Aurelien Jarno <aurelien@aurel32.net>,  Nam
 Cao <namcao@linutronix.de>,  Jaehoon Chung <jh80.chung@samsung.com>,  E
 Shattow <lucent@gmail.com>,  u-boot@lists.denx.de
Subject: Re: [PATCH 0/2] configs: JH7110: enable EFI_LOADER_BOUNCE_BUFFER
In-Reply-To: <20241121142522.59059-1-heinrich.schuchardt@canonical.com>
 (Heinrich Schuchardt's message of "Thu, 21 Nov 2024 15:25:20 +0100")
References: <20241121142522.59059-1-heinrich.schuchardt@canonical.com>
Date: Thu, 21 Nov 2024 16:24:55 +0100
Message-ID: <mvmjzcwobi0.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [2.59 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 HFILTER_HOSTNAME_UNKNOWN(2.50)[]; RDNS_NONE(2.00)[];
 ONCE_RECEIVED(1.20)[];
 HFILTER_HELO_IP_A(1.00)[hawking.nue2.suse.org];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 HFILTER_HELO_NORES_A_OR_MX(0.30)[hawking.nue2.suse.org];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.994]; RCVD_NO_TLS_LAST(0.10)[];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 RCPT_COUNT_TWELVE(0.00)[13];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 DIRECT_TO_MX(0.00)[Gnus/5.13 (Gnus v5.13)];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 FREEMAIL_CC(0.00)[starfivetech.com,linaro.org,andestech.com,konsulko.com,samsung.com,aurel32.net,linutronix.de,gmail.com,lists.denx.de];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 RCVD_COUNT_ONE(0.00)[1];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email]
X-Rspamd-Queue-Id: 7FFF721923
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Bar: ++
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

On Nov 21 2024, Heinrich Schuchardt wrote:

> Our MMC driver for JH7110 boards only supports reading to the low 4 GiB of
> memory. Booting boards with more memory requires EFI_LOADER_BOUNCE_BUFFER.

That doesn't change the situation with the booting problem I have.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
