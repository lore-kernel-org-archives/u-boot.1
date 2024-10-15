Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17E86CFC299
	for <u-boot@archiver.kernel.org>; Tue, 15 Oct 2024 11:59:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E12E87BF4;
	Tue, 15 Oct 2024 13:59:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="EOkaAW3q";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="C2ECOD6P";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="EOkaAW3q";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="C2ECOD6P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7562387BF4; Tue, 15 Oct 2024 13:59:05 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A21D88753
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 13:58:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=schwab@suse.de
Received: from hawking.nue2.suse.org (unknown [10.168.4.11])
 by smtp-out2.suse.de (Postfix) with ESMTP id 0BD7F1FB9A
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 11:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1728993538; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type;
 bh=2qeuq7xVgcPhS3kZY/PcqHigVasWO4vGGuGCXK4u1uI=;
 b=EOkaAW3qbRkHETDxcD3Z2B7rM90kj/R9+t0+mo2yXlbEJumlsoVj+Jxp3W8ZFjCzYPV0wn
 /Bh5dBbYnAzJRj+hsK4OjQRuo4XcJr88LRbKGdWw2rx6IpOx8DjOA0BgKITTlnwh9Fuwdb
 4UxlFILWNDSuyyNyGRxz/fGoE8ozDkE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1728993538;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type;
 bh=2qeuq7xVgcPhS3kZY/PcqHigVasWO4vGGuGCXK4u1uI=;
 b=C2ECOD6PVvvaXEZZpB2VelkhCEc7Hy49L5nTR0mqPyAFWv/06+tPcsTMngoD7O4d/9CQgc
 LBIgqS4uTV9wL9AA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1728993538; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type;
 bh=2qeuq7xVgcPhS3kZY/PcqHigVasWO4vGGuGCXK4u1uI=;
 b=EOkaAW3qbRkHETDxcD3Z2B7rM90kj/R9+t0+mo2yXlbEJumlsoVj+Jxp3W8ZFjCzYPV0wn
 /Bh5dBbYnAzJRj+hsK4OjQRuo4XcJr88LRbKGdWw2rx6IpOx8DjOA0BgKITTlnwh9Fuwdb
 4UxlFILWNDSuyyNyGRxz/fGoE8ozDkE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1728993538;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type;
 bh=2qeuq7xVgcPhS3kZY/PcqHigVasWO4vGGuGCXK4u1uI=;
 b=C2ECOD6PVvvaXEZZpB2VelkhCEc7Hy49L5nTR0mqPyAFWv/06+tPcsTMngoD7O4d/9CQgc
 LBIgqS4uTV9wL9AA==
Received: by hawking.nue2.suse.org (Postfix, from userid 17005)
 id C7EC34A03D4; Tue, 15 Oct 2024 13:58:57 +0200 (CEST)
From: Andreas Schwab <schwab@suse.de>
To: u-boot@lists.denx.de
Subject: 2024.10 fails to boot on starfive visionfive2
X-Yow: Look!  A ladder!  Maybe it leads to heaven, or a sandwich!
Date: Tue, 15 Oct 2024 13:58:57 +0200
Message-ID: <mvmr08hy3um.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.20 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.981]; MIME_GOOD(-0.10)[text/plain];
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

Trying to boot 2024.10 on the starfive visionfive2 1.2a board from flash
fails:

U-Boot SPL 2024.10 (Oct 08 2024 - 07:10:55 +0000)
DDR version: dc2e84f0.
Trying to boot from SPI
SPI probe failed.
SPL: failed to boot from all boot devices
### ERROR ### Please RESET the board ###

I can boot 2024.10 successfully from SD card, but using it to flash
u-boot (no matter which version) will produce a bad flash:

Main section boot fail,use backup section

In order to produce a working boot from flash I have to use u-boot
2024.07 (or earlier) to reflash it.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
