Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30FF5CDB474
	for <u-boot@archiver.kernel.org>; Mon, 23 Oct 2023 09:44:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37D6E878BF;
	Mon, 23 Oct 2023 11:44:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="kPUAml3O";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NsO9s+Rp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C6B2878C0; Mon, 23 Oct 2023 11:44:43 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09D2B878B3
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 11:44:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=iivanov@suse.de
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A98201FE0D;
 Mon, 23 Oct 2023 09:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1698054280; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sLPYqWLlVkrf0hF6MKcy8FEVtjahhz6Mwvr6PpIt0no=;
 b=kPUAml3OyrigLPsbZn3vWq4hNp4uR8J/YAYjOA4pgMY/xnjZNUyducKStuTTpRc3LqGMMQ
 b0fsQmhqWyz7bEVbW+51SOsTtaqLaJg/m2sntNazd3a3m06uxhrSvGoHrV7XpS6V2pHckk
 +kAE4fqPlJu3ZuWnFNzIlX+FfHSuOaQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1698054280;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sLPYqWLlVkrf0hF6MKcy8FEVtjahhz6Mwvr6PpIt0no=;
 b=NsO9s+RpNaFY3dsmqPRlytUgDpmd/XVn7tZi9XI50Y29xep6F8BHFIwxC+YjBUEgUHBk8v
 R+hujc45W/YyvjAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9288E139C2;
 Mon, 23 Oct 2023 09:44:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id jfJ1IohANmWkSAAAMHmgww
 (envelope-from <iivanov@suse.de>); Mon, 23 Oct 2023 09:44:40 +0000
Date: Mon, 23 Oct 2023 12:44:40 +0300
From: "Ivan T. Ivanov" <iivanov@suse.de>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Guillaume Gardet <Guillaume.Gardet@arm.com>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 0/4] bootstd: Test and boot_targets improvements
Message-ID: <kdfpezftry3d77g2f7aeasv2akd4p2oiedv7zs4xkx4d3s62a4@7qqz2avrn42p>
References: <20231023070216.394709-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023070216.394709-1-sjg@chromium.org>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-4.13 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmx.de];
 MIME_GOOD(-0.10)[text/plain]; NEURAL_HAM_LONG(-3.00)[-1.000];
 RCPT_COUNT_FIVE(0.00)[5];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; NEURAL_HAM_SHORT(-1.00)[-1.000];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 MID_RHS_NOT_FQDN(0.50)[]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.53)[80.43%];
 FREEMAIL_CC(0.00)[lists.denx.de,gmx.de,arm.com,konsulko.com]
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

On 10-23 00:02, Simon Glass wrote:
> 
> This series makes another attempt to support things like "mmc" in the
> boot_targets variable. The previous attempt introduced a bug which made
> iteration fail.
> 
> New test coverage is provided for some previously untested behaviour, to
> prevent regressions.
> 
> 

Thank you! Booting RPi4 from USB and uSB looks fine now.
I have updated also our Bugzilla entry with the boot log.

Tested-by: Ivan T.Ivanov <iivanov@suse.de>

Regards,
Ivan

[1] https://bugzilla.suse.com/show_bug.cgi?id=1216036

> Simon Glass (4):
>   Revert "bootstd: Scan all bootdevs in a boot_targets entry"
>   bootstd: Expand boot-ordering test to include USB
>   bootstd: Correct logic for single uclass
>   bootstd: Scan all bootdevs in a boot_targets entry (take 2)
> 
