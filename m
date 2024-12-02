Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECFC7D78305
	for <u-boot@archiver.kernel.org>; Mon,  2 Dec 2024 10:33:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FD6688E17;
	Mon,  2 Dec 2024 11:33:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="EjN83lI2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vBerEQDe";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="EjN83lI2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vBerEQDe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4131488EDA; Mon,  2 Dec 2024 11:33:27 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C25488C91
 for <u-boot@lists.denx.de>; Mon,  2 Dec 2024 11:33:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=schwab@suse.de
Received: from hawking.nue2.suse.org (unknown [10.168.4.11])
 by smtp-out2.suse.de (Postfix) with ESMTP id 5A3B91F444;
 Mon,  2 Dec 2024 10:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1733135602; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=J48IYXR5AWsxSb3gX0DwCX/oFe7M9w3Puv2tKXlk85Y=;
 b=EjN83lI2KccpQN62q/yD5hF0inf0TWviDgSUnnZGXZMmMORRVNnmgCY3qEgNn6ukRkABI/
 p6VzyyvOWERv4naFOKOuroMiA1Fu/4+onMOUyFMVZj2tTF1aDMbL9iNmjxRitKmZwhC377
 P3IlJfeH0whiqJ6AoyT5ae6CP41E2ls=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1733135602;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=J48IYXR5AWsxSb3gX0DwCX/oFe7M9w3Puv2tKXlk85Y=;
 b=vBerEQDeAyzR8d9Qex6oaiWkDj0VYcEYud8QZv+eEI85vvyVXzm8oXGhWv/D+NvSV2ShVK
 VpvHkZoEtdlXQGDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1733135602; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=J48IYXR5AWsxSb3gX0DwCX/oFe7M9w3Puv2tKXlk85Y=;
 b=EjN83lI2KccpQN62q/yD5hF0inf0TWviDgSUnnZGXZMmMORRVNnmgCY3qEgNn6ukRkABI/
 p6VzyyvOWERv4naFOKOuroMiA1Fu/4+onMOUyFMVZj2tTF1aDMbL9iNmjxRitKmZwhC377
 P3IlJfeH0whiqJ6AoyT5ae6CP41E2ls=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1733135602;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=J48IYXR5AWsxSb3gX0DwCX/oFe7M9w3Puv2tKXlk85Y=;
 b=vBerEQDeAyzR8d9Qex6oaiWkDj0VYcEYud8QZv+eEI85vvyVXzm8oXGhWv/D+NvSV2ShVK
 VpvHkZoEtdlXQGDQ==
Received: by hawking.nue2.suse.org (Postfix, from userid 17005)
 id 4B6954A04FA; Mon,  2 Dec 2024 11:33:22 +0100 (CET)
From: Andreas Schwab <schwab@suse.de>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: u-boot@lists.denx.de,  E Shattow <lucent@gmail.com>,  Minda Chen
 <minda.chen@starfivetech.com>
Subject: Re: 2025.01-rc2 fails to boot on VisionFive2
In-Reply-To: <7610b940-63ae-4b52-a71e-555b2d2db35e@canonical.com> (Heinrich
 Schuchardt's message of "Thu, 21 Nov 2024 18:21:22 +0100")
References: <mvm8qtnv310.fsf@suse.de>
 <8d4e3685-8082-4b74-828f-05ccee5ac8e0@canonical.com>
 <mvmfrnko8tk.fsf@suse.de>
 <7610b940-63ae-4b52-a71e-555b2d2db35e@canonical.com>
Date: Mon, 02 Dec 2024 11:33:22 +0100
Message-ID: <mvmplmaml1p.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.20 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCVD_NO_TLS_LAST(0.10)[];
 MIME_GOOD(-0.10)[text/plain]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 ARC_NA(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FREEMAIL_CC(0.00)[lists.denx.de,gmail.com,starfivetech.com];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; MIME_TRACE(0.00)[0:+];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_ONE(0.00)[1];
 MID_RHS_MATCH_FROM(0.00)[]; TO_DN_SOME(0.00)[]
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

> That ls works does not mean that the file system is not corrupted.

This obviously has nothing to do with the file system:

StarFive # load mmc 1 0x40200000 efi/boot/bootriscv64.efi
167936 bytes read in 14 ms (11.4 MiB/s)
StarFive # load mmc 1 0x100000000 efi/boot/bootriscv64.efi 
mmc fail to send stop cmd
Error reading cluster
Failed to load 'efi/boot/bootriscv64.efi'
StarFive # load mmc 1 0x40200000 efi/boot/bootriscv64.efi 
 ** fs_devread read error - block
 ** fs_devread read error - block
Can't set block device

Only a reset can revive the MMC interface.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
