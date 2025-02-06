Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 149E8C02198
	for <u-boot@archiver.kernel.org>; Thu,  6 Feb 2025 15:45:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86AB380944;
	Thu,  6 Feb 2025 16:45:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="FC6dYUY1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="k7Lw5brA";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GH2Bko1C";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="riN2me7c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2E6680737; Thu,  6 Feb 2025 16:45:28 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD4F580737
 for <u-boot@lists.denx.de>; Thu,  6 Feb 2025 16:45:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=schwab@suse.de
Received: from hawking.nue2.suse.org (unknown [10.168.4.11])
 by smtp-out2.suse.de (Postfix) with ESMTP id 4BC651F397
 for <u-boot@lists.denx.de>; Thu,  6 Feb 2025 15:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738856726; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type;
 bh=bTHTfVsZjQQH91IDXgtuEhS084RSUYaCuwNeoCKt2go=;
 b=FC6dYUY1wAA8S9zS65sajYlLYh1WsbixbYSKOuZ4u/BFFGnVMo2Llf1VxfO/OoyrSWF75I
 EqFrmPguRj49AYW2G6hMAVt2UtAjERsGPWuCDOJ5vgVMxadZJpvIpOyq0ul1hU/RioOU6Z
 kyXX2czu9gCt0sKikohdnDQSP7lEHN0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738856726;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type;
 bh=bTHTfVsZjQQH91IDXgtuEhS084RSUYaCuwNeoCKt2go=;
 b=k7Lw5brAbg+dV1GrsiL3kL8hR/+3/j3HHqX6/jNh5S2KRsbnD4blV9CEPpwHZL1D9C52Ko
 QOuIiI6Nrkwl0aAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738856723; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type;
 bh=bTHTfVsZjQQH91IDXgtuEhS084RSUYaCuwNeoCKt2go=;
 b=GH2Bko1CjpT/P/jShhMnKie82uJqGaK9GfMS3KKR/7nmoOM7dpQShvbFmSpoWhNo1LdD44
 KRCYj/v0r8IUtCCd1pKb2v5usM3emehCJxQdwTDJcEDDPJ63af46+tuvazQ0ns10em30fs
 dcLehsveVhsyedFt7jbWFsrid/io724=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738856723;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type;
 bh=bTHTfVsZjQQH91IDXgtuEhS084RSUYaCuwNeoCKt2go=;
 b=riN2me7ce1BVV/PLLZ1qhKhKBeB1aScsSr94gZhfx803PghsGtgHAsBAmAG8CXGmtm393m
 734ZwfMXyLvwq+Cg==
Received: by hawking.nue2.suse.org (Postfix, from userid 17005)
 id 3973E4AADB9; Thu,  6 Feb 2025 16:45:23 +0100 (CET)
From: Andreas Schwab <schwab@suse.de>
To: u-boot@lists.denx.de
Subject: 2025.04-rc1 breaks booting 6.13 on VisionFive 2 v1.2A
Date: Thu, 06 Feb 2025 16:45:23 +0100
Message-ID: <mvmikpn13ho.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.20 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_NO_TLS_LAST(0.10)[]; ARC_NA(0.00)[];
 RCPT_COUNT_ONE(0.00)[1]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_ONE(0.00)[1]; MID_RHS_MATCH_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_NONE(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid]
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

The last kernel messages are

[   18.318118] [     T49] platform 940000000.pcie: deferred probe pending: pcie-starfive: failed to get pcie phy
[   18.327846] [     T49] platform 9c0000000.pcie: deferred probe pending: pcie-starfive: failed to get pcie phy

and no MMC driver is loaded (dw_mmc_pltfm does not work).

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
