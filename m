Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9235CD216A3
	for <u-boot@archiver.kernel.org>; Tue, 15 Oct 2024 13:39:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2EA71881A5;
	Tue, 15 Oct 2024 15:39:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="HWManEit";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fnvqDPv/";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HWManEit";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fnvqDPv/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB2CC8839A; Tue, 15 Oct 2024 15:39:44 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0732C8814D
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 15:39:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=schwab@suse.de
Received: from hawking.nue2.suse.org (unknown
 [IPv6:2a07:de40:a101:3:92b1:1cff:fe69:ddc])
 by smtp-out2.suse.de (Postfix) with ESMTP id 610861FE44
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 13:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1728999582; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XH3sGkgADKNzuZmvxcgggiAmztWecUHSNL4Pv5wxiMk=;
 b=HWManEitaSGAG1btonIHKa1JY5CtrbH/2U4p1dzmO2aFCVcB26zCDhVtoF9xT6aWHBg3JW
 lc6XjlNKUFZUl9wHMIqRpc62ezbCkfnoocjpegO4s2cidZyd5G3zJew3o9k4ZjDXUNBBOa
 bRToMZ3n7ep2ozLQemwxLCcu07rqBFA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1728999582;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XH3sGkgADKNzuZmvxcgggiAmztWecUHSNL4Pv5wxiMk=;
 b=fnvqDPv/bTNAHYym7jG1q+0NYLZLIFRGfcO7EHo6ecz+PcBE0Nc81Cd2KuMLzwPMuVlX8a
 q+emFNRhlRVyUuAQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=HWManEit;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="fnvqDPv/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1728999582; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XH3sGkgADKNzuZmvxcgggiAmztWecUHSNL4Pv5wxiMk=;
 b=HWManEitaSGAG1btonIHKa1JY5CtrbH/2U4p1dzmO2aFCVcB26zCDhVtoF9xT6aWHBg3JW
 lc6XjlNKUFZUl9wHMIqRpc62ezbCkfnoocjpegO4s2cidZyd5G3zJew3o9k4ZjDXUNBBOa
 bRToMZ3n7ep2ozLQemwxLCcu07rqBFA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1728999582;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XH3sGkgADKNzuZmvxcgggiAmztWecUHSNL4Pv5wxiMk=;
 b=fnvqDPv/bTNAHYym7jG1q+0NYLZLIFRGfcO7EHo6ecz+PcBE0Nc81Cd2KuMLzwPMuVlX8a
 q+emFNRhlRVyUuAQ==
Received: by hawking.nue2.suse.org (Postfix, from userid 17005)
 id 4B1864A03D4; Tue, 15 Oct 2024 15:39:42 +0200 (CEST)
From: Andreas Schwab <schwab@suse.de>
To: u-boot@lists.denx.de
Subject: Re: 2024.10 fails to boot on starfive visionfive2
In-Reply-To: <mvmr08hy3um.fsf@suse.de> (Andreas Schwab's message of "Tue, 15
 Oct 2024 13:58:57 +0200")
References: <mvmr08hy3um.fsf@suse.de>
X-Yow: ...I think I'm having an overnight sensation right now!!
Date: Tue, 15 Oct 2024 15:39:42 +0200
Message-ID: <mvmmsj5xz6p.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [2.61 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 HFILTER_HOSTNAME_UNKNOWN(2.50)[]; RDNS_NONE(2.00)[];
 ONCE_RECEIVED(1.20)[];
 HFILTER_HELO_IP_A(1.00)[hawking.nue2.suse.org];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 HFILTER_HELO_NORES_A_OR_MX(0.30)[hawking.nue2.suse.org];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.18)[-0.920]; MIME_GOOD(-0.10)[text/plain];
 RCVD_NO_TLS_LAST(0.10)[]; MX_GOOD(-0.01)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DIRECT_TO_MX(0.00)[Gnus/5.13 (Gnus v5.13)];
 DKIM_TRACE(0.00)[suse.de:+]; RCPT_COUNT_ONE(0.00)[1];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 RCVD_COUNT_ONE(0.00)[1]; MID_RHS_MATCH_FROM(0.00)[];
 MIME_TRACE(0.00)[0:+]
X-Rspamd-Queue-Id: 610861FE44
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

As it turned out this is due to a defective local patch.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
