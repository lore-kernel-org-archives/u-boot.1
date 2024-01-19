Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBB28C4725D
	for <u-boot@archiver.kernel.org>; Fri, 19 Jan 2024 14:24:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 23A0C87BBC;
	Fri, 19 Jan 2024 15:24:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="CWxMBXIZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2/NAWl3m";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="CWxMBXIZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2/NAWl3m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1FD0687BFD; Fri, 19 Jan 2024 15:24:17 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F01287A2A
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 15:24:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=iivanov@suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A615F1F7E5;
 Fri, 19 Jan 2024 14:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1705674254; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZCXssiROMo6SrD6dudrM8ibLuA3nZ99+1mo/VomG1yg=;
 b=CWxMBXIZqGM2rb0fOE5dH4RjA6iVgqilpHVgCejVeiwraaqGQOkCgo4v4X0H/5wqwD/nL+
 ed0mK8yalgrrv1uy/HiLH4wHtV6JmMBEphdGClKPsCDUFLIsRnRenuP6PSIZkO0QAk/EWC
 Ts2IS9rSzwMCZ/qTX1lJnfsAdZCdVvA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1705674254;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZCXssiROMo6SrD6dudrM8ibLuA3nZ99+1mo/VomG1yg=;
 b=2/NAWl3mC9qc37LBt+UULI4PReCnu2s7uDlofN48kiQJCB0FQPHZJh7XAPFiXC5hADduX5
 rkITdeOHZTvJaNDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1705674254; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZCXssiROMo6SrD6dudrM8ibLuA3nZ99+1mo/VomG1yg=;
 b=CWxMBXIZqGM2rb0fOE5dH4RjA6iVgqilpHVgCejVeiwraaqGQOkCgo4v4X0H/5wqwD/nL+
 ed0mK8yalgrrv1uy/HiLH4wHtV6JmMBEphdGClKPsCDUFLIsRnRenuP6PSIZkO0QAk/EWC
 Ts2IS9rSzwMCZ/qTX1lJnfsAdZCdVvA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1705674254;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZCXssiROMo6SrD6dudrM8ibLuA3nZ99+1mo/VomG1yg=;
 b=2/NAWl3mC9qc37LBt+UULI4PReCnu2s7uDlofN48kiQJCB0FQPHZJh7XAPFiXC5hADduX5
 rkITdeOHZTvJaNDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 73D9C136F5;
 Fri, 19 Jan 2024 14:24:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 47O2GQ6GqmWMMAAAD6G6ig
 (envelope-from <iivanov@suse.de>); Fri, 19 Jan 2024 14:24:14 +0000
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6\))
Subject: Re: [PATCH v4 0/6] rpi5: initial support
From: "Ivan T. Ivanov" <iivanov@suse.de>
In-Reply-To: <25AB43C7-829F-4F62-AC8E-3284B22ACB03@jens-maus.de>
Date: Fri, 19 Jan 2024 16:24:03 +0200
Cc: Stefan Wahren <wahrenst@gmx.net>,
 u-boot@lists.denx.de
Content-Transfer-Encoding: quoted-printable
Message-Id: <E7BFDAEE-00A9-463A-AF73-75101AFF2BC6@suse.de>
References: <454FB8E4-52A8-482D-8671-5650F8C4773C@suse.de>
 <A26CEBAE-9950-4304-B3A2-1BAB4035437A@jens-maus.de>
 <zmxxqxlbhdhngu36ft4yrqxtjkmvalvhbgbl2uzsj2jgnq7zje@qtncpq2nss57>
 <DCAD0173-2377-4B89-92EB-F38ED1CA938B@jens-maus.de>
 <03bbe9ad-7cc6-491d-8bd9-631f1cf04f39@gmx.net>
 <418F8AAE-136A-44A0-80C3-D01FFE00EC2E@jens-maus.de>
 <sjmi6dftbgx56isfyjtaryehzq2iollwxm2etlspiygehh3n6v@k4ws56nsbgfn>
 <6C9E5E0C-9C27-45A4-886F-8B8C641EF7A3@jens-maus.de>
 <ejituxf7ggiu2ciswrwoeqqjytb7mj2vn6gkxllywtnlm4aefi@br4zq7rfytlo>
 <3FB75D28-9BF9-4518-8BF1-519C884516F7@jens-maus.de>
 <fa7j66z5r7pul6zp5ljcntrb7xbazqxesz6wysrslrpxxhpafc@krztduo6pjm6>
 <25AB43C7-829F-4F62-AC8E-3284B22ACB03@jens-maus.de>
To: Jens Maus <mail@jens-maus.de>
X-Mailer: Apple Mail (2.3731.700.6)
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=CWxMBXIZ;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="2/NAWl3m"
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.19 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 MV_CASE(0.50)[]; FREEMAIL_ENVRCPT(0.00)[gmx.net];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; TO_DN_SOME(0.00)[];
 BAYES_HAM(-0.18)[70.11%]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 FREEMAIL_CC(0.00)[gmx.net,lists.denx.de]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
X-Rspamd-Queue-Id: A615F1F7E5
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



> On 19 Jan 2024, at 16:08, Jens Maus <mail@jens-maus.de> wrote:
>=20
>=20
>> Am 19.01.2024 um 15:06 schrieb Ivan T. Ivanov <iivanov@suse.de>:
>>=20
>> On 01-19 14:54, Jens Maus wrote:
>>>=20
>>>> Am 19.01.2024 um 14:46 schrieb Ivan T. Ivanov <iivanov@suse.de>:
>>>>=20
>>>> Same here, expect that they are more memory banks, of course.
>>>> It is really strange that you don't seen even single message
>>>> from the U-Boot..
>>>=20
>>> Indeed. Not a single line, nor any U-Boot logo or anything on HDMI. =
Do you see any debug output on the serial debug probe connection to the =
rpi5?
>>=20
>> Yes, there is even small submarine on the top right side of the =
screen
>> while U-Boot is running.
>=20
> On the HDMI port, right? But what about the serial UART output?=20

Yes, I can see serial output from U-Boot. I am using one of these
simple USB<->UART cables. You can see serial output when you boot
with RPiOS, when you use "Raspberry Pi Debug Probe=E2=80=9D, right?

Ivan=
