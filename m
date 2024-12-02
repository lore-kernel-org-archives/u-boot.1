Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7D43D7830E
	for <u-boot@archiver.kernel.org>; Mon,  2 Dec 2024 11:58:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBB5B88FDE;
	Mon,  2 Dec 2024 12:58:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="luym7ZaV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="yK3ng3EC";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="j4/upeFE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GnWcnzrS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 959F68910C; Mon,  2 Dec 2024 12:58:07 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7885A88FD2
 for <u-boot@lists.denx.de>; Mon,  2 Dec 2024 12:58:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=schwab@suse.de
Received: from hawking.nue2.suse.org (unknown
 [IPv6:2a07:de40:a101:3:92b1:1cff:fe69:ddc])
 by smtp-out1.suse.de (Postfix) with ESMTP id C9D05211BB;
 Mon,  2 Dec 2024 11:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1733140685; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GRb0fGgLKSQs1ADa440iLB2gROiDGTcTDK/kHJRla8Y=;
 b=luym7ZaVcT2Ex3VoEeoPoxT+Xgf7B0zi7g1C2qM2YRONr9PmaFAZU9u74Ava4Gx10imlK8
 Mrbr+8mHtoIXaqP5N/MeFLYeqt+6ZUOpq8CgnpxZdM8qJqh0Ep/U27gvb3yIMDE4MG4fLR
 E04U/bh6eWJU1R19f7G5RsDVj2yxak0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1733140685;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GRb0fGgLKSQs1ADa440iLB2gROiDGTcTDK/kHJRla8Y=;
 b=yK3ng3ECrepUYO67ar1Nm+exkttO4TlyaxnSIIIxLgbZIBHhMGA8ohGIdWwg8X7/3lQCfl
 Qsmx4j6U2aEmWjBA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="j4/upeFE";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=GnWcnzrS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1733140684; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GRb0fGgLKSQs1ADa440iLB2gROiDGTcTDK/kHJRla8Y=;
 b=j4/upeFEmrezqykOgyPktPAkYxO8x5HWMCYg+LqxNRo1Xikw/4spspuQ6GJdWa/WX3YVhz
 G9lmxYSnbZRzEBRiJ7iGw1psecp0AfSlhOCRfzSunuX2/codffvr7sWnf8gI94UVijDqY3
 Y9LNHDun8D3x9azAM8eeE86WN6g2itg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1733140684;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GRb0fGgLKSQs1ADa440iLB2gROiDGTcTDK/kHJRla8Y=;
 b=GnWcnzrSXbMuX/pC8E8QcRmZLdlXevv9d75otE+E4KannSSe5ZoTLhc/JwKarivLxwQcI5
 rcJYOgZVJKNfKkCg==
Received: by hawking.nue2.suse.org (Postfix, from userid 17005)
 id B8F7B4A04FA; Mon,  2 Dec 2024 12:58:04 +0100 (CET)
From: Andreas Schwab <schwab@suse.de>
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de,  Heinrich Schuchardt <xypron.glpk@gmx.de>,  E
 Shattow <lucent@gmail.com>,  Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] lmb: prohibit allocations above ram_top even from same
 bank
In-Reply-To: <20241202070624.1295497-1-sughosh.ganu@linaro.org> (Sughosh
 Ganu's message of "Mon, 2 Dec 2024 12:36:24 +0530")
References: <20241202070624.1295497-1-sughosh.ganu@linaro.org>
Date: Mon, 02 Dec 2024 12:58:04 +0100
Message-ID: <mvmfrn6mh4j.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [14.32 / 50.00]; SPAM_FLAG(5.00)[];
 NEURAL_SPAM_LONG(3.50)[1.000]; BAYES_HAM(-3.00)[99.99%];
 HFILTER_HOSTNAME_UNKNOWN(2.50)[];
 NEURAL_SPAM_SHORT(2.03)[0.676]; RDNS_NONE(2.00)[];
 ONCE_RECEIVED(1.20)[];
 HFILTER_HELO_IP_A(1.00)[hawking.nue2.suse.org];
 HFILTER_HELO_NORES_A_OR_MX(0.30)[hawking.nue2.suse.org];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_NO_TLS_LAST(0.10)[]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MIME_TRACE(0.00)[0:+];
 DIRECT_TO_MX(0.00)[Gnus/5.13 (Gnus v5.13)]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; RCVD_COUNT_ONE(0.00)[1];
 FREEMAIL_CC(0.00)[lists.denx.de,gmx.de,gmail.com,konsulko.com];
 RCPT_COUNT_FIVE(0.00)[5]
X-Spamd-Bar: ++++++++++++++
X-Rspamd-Queue-Id: C9D05211BB
X-Rspamd-Action: add header
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam: Yes
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

On Dez 02 2024, Sughosh Ganu wrote:

> There are platforms which set the value of ram_top based on certain
> restrictions that the platform might have in accessing memory above
> ram_top, even when the memory region is in the same DRAM bank. So,
> even though the LMB allocator works as expected, when trying to
> allocate memory above ram_top, prohibit this by marking all memory
> above ram_top as reserved, even if the said memory region is from the
> same bank.

This fixes the boot failure on the VisionFive2 board as reported in
<mvm8qtnv310.fsf@suse.de>.

Tested-by: Andreas Schwab <schwab@suse.de>

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
