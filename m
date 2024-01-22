Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7620BC47DAF
	for <u-boot@archiver.kernel.org>; Mon, 22 Jan 2024 14:16:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B7499878A1;
	Mon, 22 Jan 2024 15:16:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="RTJG0sH4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GH/EeNRU";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RTJG0sH4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GH/EeNRU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C44C877EC; Mon, 22 Jan 2024 15:16:38 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A8C087960
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 15:16:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=iivanov@suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 587281FC04;
 Mon, 22 Jan 2024 14:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1705932995; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bZnrwX/0XUrW7jCVtQiuo3XgOVwUJu7XbUOFgVGM8jo=;
 b=RTJG0sH4nrit36QHNL4LXRW86xcYiQXE1Jyv5D6bqLjN5LRTOo4DLv1MfRQzQsRkB+W7rG
 wSfNw2D6UnNNQJpUFWDttkXbBq22xtJKpd9xQfkCGDDwTbkwPc2E4v4LBV3ptt5WeNpOBY
 gQ1o84qy4rd1Lg2Ih4qotjs+OJrcsVA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1705932995;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bZnrwX/0XUrW7jCVtQiuo3XgOVwUJu7XbUOFgVGM8jo=;
 b=GH/EeNRUBdLUCOlglIUQu0rkNekLCKmiaPZcLpI8JLKcnutL2YF3yX7JdCY6ah3oHTIvkg
 zH6d/c1JQi6LUrCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1705932995; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bZnrwX/0XUrW7jCVtQiuo3XgOVwUJu7XbUOFgVGM8jo=;
 b=RTJG0sH4nrit36QHNL4LXRW86xcYiQXE1Jyv5D6bqLjN5LRTOo4DLv1MfRQzQsRkB+W7rG
 wSfNw2D6UnNNQJpUFWDttkXbBq22xtJKpd9xQfkCGDDwTbkwPc2E4v4LBV3ptt5WeNpOBY
 gQ1o84qy4rd1Lg2Ih4qotjs+OJrcsVA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1705932995;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bZnrwX/0XUrW7jCVtQiuo3XgOVwUJu7XbUOFgVGM8jo=;
 b=GH/EeNRUBdLUCOlglIUQu0rkNekLCKmiaPZcLpI8JLKcnutL2YF3yX7JdCY6ah3oHTIvkg
 zH6d/c1JQi6LUrCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2455D13995;
 Mon, 22 Jan 2024 14:16:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id dJ/1A8N4rmUNUgAAD6G6ig
 (envelope-from <iivanov@suse.de>); Mon, 22 Jan 2024 14:16:35 +0000
Date: Mon, 22 Jan 2024 16:16:34 +0200
From: "Ivan T. Ivanov" <iivanov@suse.de>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Jens Maus <mail@jens-maus.de>, u-boot@lists.denx.de
Subject: Re: Re: [PATCH v4 0/6] rpi5: initial support
Message-ID: <uwh4skanpw4c42t5iefqiawfns2wglxl4rizmaexeaetyvahf3@yibnd3owvcn2>
References: <25AB43C7-829F-4F62-AC8E-3284B22ACB03@jens-maus.de>
 <E7BFDAEE-00A9-463A-AF73-75101AFF2BC6@suse.de>
 <FB66DFF3-03B0-4DA5-8916-AB80CA6C6EB5@jens-maus.de>
 <dvpwizpui6a52dfmy57ghv4zmplvgqvow6oec7x5opwzh63zzl@jehyglofr6yh>
 <489FBAE5-501A-49F6-894D-58BE5C5429CC@jens-maus.de>
 <A0746263-646C-40C6-A2A6-659C39385E8B@jens-maus.de>
 <246035ba-0090-4cc3-982e-1de837ec7340@gmx.net>
 <6E2D7E91-E869-48C6-8CE8-0B410A2B67B9@jens-maus.de>
 <ebffa598-6945-4a03-abe4-fe519df5fbfd@gmx.net>
 <223DA3F8-B17B-44CF-B247-12DEBD100A75@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <223DA3F8-B17B-44CF-B247-12DEBD100A75@suse.de>
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=RTJG0sH4;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="GH/EeNRU"
X-Spamd-Result: default: False [0.17 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FREEMAIL_ENVRCPT(0.00)[gmx.net]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
 FREEMAIL_TO(0.00)[gmx.net]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 MID_RHS_NOT_FQDN(0.50)[]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-0.02)[54.58%];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 587281FC04
X-Spamd-Bar: /
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

Hi,

On 01-22 13:57, Ivan T. Ivanov wrote:
> > Am 20.01.24 um 10:48 schrieb Jens Maus:
> >> Hi,
> >> 
> >>> Am 20.01.2024 um 10:22 schrieb Stefan Wahren <wahrenst@gmx.net>:
> >>> 
> >>> Am 19.01.24 um 22:26 schrieb Jens Maus:
> >>>> I actually do have some good and bad news:
> >>>> 
> >>>> 1. Good news: I got u-boot finally showing up with my RaspberryPi5 8GB both on the HDMI and on the serial debug UART like you reported.
> >>>> 
> >>>> 2. Bad news: I actually got it working by downgrading the rpi-eeprom to the same 2023/10/30 (VERSION:30de0ba5) version like you have.
> >>>> 
> > 
> > One idea would be to enable early debug in U-Boot (no idea how to
> > achieve this). I assume U-Boot crashes before it's able to print the
> > first line, but it's hard to believe it crashes at the very first
> > instruction of U-Boot. So with some luck we should be able to narrow
> > done the cause.
> 
> I was able to enable early debug UART in U-Boot and I will try to
> find what is happening, once I get some free cycles.

Ok, this was relatively easy to find :-)

New versions of EEPROM firmware change “kernel”/U-Boot load address 
from 0x80000 to 0x200000. And because on RPi’s CONFIG_TEXT_BASE is
hardcoded to 0x80000 code run through the fields. 

Hopefully simple patch like bellow make it work fine in older and
newer EEPROM firmware versions.

Regards,
Ivan  

diff --git a/configs/rpi_arm64_defconfig b/configs/rpi_arm64_defconfig
index 11ede9435d..ce64f9554f 100644
--- a/configs/rpi_arm64_defconfig
+++ b/configs/rpi_arm64_defconfig
@@ -1,6 +1,7 @@
 CONFIG_ARM=y
 CONFIG_ARCH_BCM283X=y
 CONFIG_TEXT_BASE=0x00080000
+CONFIG_POSITION_INDEPENDENT=y

