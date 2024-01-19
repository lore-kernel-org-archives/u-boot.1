Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3971DC4725D
	for <u-boot@archiver.kernel.org>; Fri, 19 Jan 2024 05:29:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F41F087B5F;
	Fri, 19 Jan 2024 06:29:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="ocIiPgHg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="VCFPrlyX";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ocIiPgHg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="VCFPrlyX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02F7487B8F; Fri, 19 Jan 2024 06:29:21 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 00F50875C5
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 06:29:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=iivanov@suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4CE7A1FD0D;
 Fri, 19 Jan 2024 05:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1705642158; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c52IQJkprNc84m8E1WJa8SBtNgSKZrcCeuvI9v8IwGM=;
 b=ocIiPgHgBoGQPKy24eS2shkqSz6RgpH0fPoP36zcBkV35mSASZ/9Q/XdYlNRPy75QSXOOg
 tNh3oBWpsk22qlRRo9ArW9CYxn0rKxmS5fxpMbIpxD+brrAAMJ77d2LAE/OokuuWUa8lOr
 YvVnvKY3pz6AY+cOfOys6CFQWxDW088=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1705642158;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c52IQJkprNc84m8E1WJa8SBtNgSKZrcCeuvI9v8IwGM=;
 b=VCFPrlyXGrcF6kiFS5Myq/Aa9rdK2ilUdTbKK27e/aPmM6gQ9CDnvKIQITyn1z+jcXMnwP
 buEhBEDtEe7kwrCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1705642158; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c52IQJkprNc84m8E1WJa8SBtNgSKZrcCeuvI9v8IwGM=;
 b=ocIiPgHgBoGQPKy24eS2shkqSz6RgpH0fPoP36zcBkV35mSASZ/9Q/XdYlNRPy75QSXOOg
 tNh3oBWpsk22qlRRo9ArW9CYxn0rKxmS5fxpMbIpxD+brrAAMJ77d2LAE/OokuuWUa8lOr
 YvVnvKY3pz6AY+cOfOys6CFQWxDW088=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1705642158;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c52IQJkprNc84m8E1WJa8SBtNgSKZrcCeuvI9v8IwGM=;
 b=VCFPrlyXGrcF6kiFS5Myq/Aa9rdK2ilUdTbKK27e/aPmM6gQ9CDnvKIQITyn1z+jcXMnwP
 buEhBEDtEe7kwrCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3135D13777;
 Fri, 19 Jan 2024 05:29:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id DNGGCa4IqmXEEgAAD6G6ig
 (envelope-from <iivanov@suse.de>); Fri, 19 Jan 2024 05:29:18 +0000
Date: Fri, 19 Jan 2024 07:29:17 +0200
From: "Ivan T. Ivanov" <iivanov@suse.de>
To: Jens Maus <mail@jens-maus.de>
Cc: u-boot@lists.denx.de
Subject: Re: Re: [PATCH v4 0/6] rpi5: initial support
Message-ID: <zmxxqxlbhdhngu36ft4yrqxtjkmvalvhbgbl2uzsj2jgnq7zje@qtncpq2nss57>
References: <BD4D4B77-9C54-4FD7-8EEF-A65E674E0747@jens-maus.de>
 <sfo77vzvmblyv5g5ek6uc6oxrf5n7dcp3vsw2g2lvfnnrlyaft@kc6s7vvspwvz>
 <4DCC64E0-F0E4-4AF6-8E81-62B156E81554@jens-maus.de>
 <2303FFA8-E2FA-4AA4-AE67-FF5E904D21DD@suse.de>
 <A796E025-0F6E-4FF7-BA4D-2F52CD763B4B@jens-maus.de>
 <9AFD4C3E-E1B7-4EA7-8589-7060A2747732@suse.de>
 <5C0A3CD4-2591-4266-B9CC-7EC38C6A88C3@jens-maus.de>
 <454FB8E4-52A8-482D-8671-5650F8C4773C@suse.de>
 <A26CEBAE-9950-4304-B3A2-1BAB4035437A@jens-maus.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="rxj5ydmnonlpxmhi"
Content-Disposition: inline
In-Reply-To: <A26CEBAE-9950-4304-B3A2-1BAB4035437A@jens-maus.de>
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ocIiPgHg;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=VCFPrlyX
X-Spamd-Result: default: False [-0.81 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[multipart/mixed,text/plain,text/x-patch];
 HAS_ATTACHMENT(0.00)[]; DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; RCPT_COUNT_TWO(0.00)[2];
 MX_GOOD(-0.01)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+,1:+,2:+];
 MID_RHS_NOT_FQDN(0.50)[]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-0.00)[22.76%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 4CE7A1FD0D
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


--rxj5ydmnonlpxmhi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 01-18 18:18, Jens Maus wrote:
> 
> > I am afraid you will have to connect that UART debug cable and share
> > what is the memory map on your device :-)
> 
> No problem.

Thanks, but could you apply attached patch and send me
the logs when there is HDMI monitor connected to the board
and one when cable is unplugged.

Regards,
Ivan



--rxj5ydmnonlpxmhi
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-fdtdec-hack-Show-DRAM-size-parameters.patch"

From f9e039d3febbb046fe06f72731e7ba558927aa55 Mon Sep 17 00:00:00 2001
From: "Ivan T. Ivanov" <iivanov@suse.de>
Date: Fri, 19 Jan 2024 07:22:39 +0200
Subject: [PATCH] fdtdec: hack: Show DRAM size parameters

---
 lib/fdtdec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/fdtdec.c b/lib/fdtdec.c
index b2c59ab381..84cbd82cdb 100644
--- a/lib/fdtdec.c
+++ b/lib/fdtdec.c
@@ -1107,7 +1107,7 @@ int fdtdec_setup_memory_banksize(void)
 		gd->bd->bi_dram[bank].size =
 			(phys_size_t)(res.end - res.start + 1);
 
-		debug("%s: DRAM Bank #%d: start = 0x%llx, size = 0x%llx\n",
+		printf("%s: DRAM Bank #%d: start = 0x%llx, size = 0x%llx\n",
 		      __func__, bank,
 		      (unsigned long long)gd->bd->bi_dram[bank].start,
 		      (unsigned long long)gd->bd->bi_dram[bank].size);
-- 
2.35.3


--rxj5ydmnonlpxmhi--
