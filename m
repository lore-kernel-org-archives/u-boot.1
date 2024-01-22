Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F8B3C4725D
	for <u-boot@archiver.kernel.org>; Mon, 22 Jan 2024 11:58:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52CE78797C;
	Mon, 22 Jan 2024 12:57:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="06biArMu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rIUGlBWy";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="06biArMu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rIUGlBWy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C6D3B879D5; Mon, 22 Jan 2024 12:57:38 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE34C8796E
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 12:57:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=iivanov@suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 55E721FBB3;
 Mon, 22 Jan 2024 11:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1705924656; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uI7mCYbyER6GIIrKlO3cGdwAtk/MgzvtF1yiRdEgHgY=;
 b=06biArMuVkYxxX3cxtvVVDDhgfT1LuzKlNKOiGKoqR29EN2CFg1SrT9gbUVNmGglDd1Dkj
 KN0HVuvMp4g8HVxrlSroT+qr1aNERS7AQDQm4MRs6MQ5PeMDdam54y41Ow2vLezWGKev2d
 1DOPYzDMUEWAJ46dmvBQGtZoxWhNT+o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1705924656;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uI7mCYbyER6GIIrKlO3cGdwAtk/MgzvtF1yiRdEgHgY=;
 b=rIUGlBWyXgPMcGmsbxV2H3echxU7UUoGq3OifpdLYvFMJuNYdDqkwUGl48kLxhTc93xg2C
 6B7K18J1LN8fgqAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1705924656; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uI7mCYbyER6GIIrKlO3cGdwAtk/MgzvtF1yiRdEgHgY=;
 b=06biArMuVkYxxX3cxtvVVDDhgfT1LuzKlNKOiGKoqR29EN2CFg1SrT9gbUVNmGglDd1Dkj
 KN0HVuvMp4g8HVxrlSroT+qr1aNERS7AQDQm4MRs6MQ5PeMDdam54y41Ow2vLezWGKev2d
 1DOPYzDMUEWAJ46dmvBQGtZoxWhNT+o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1705924656;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uI7mCYbyER6GIIrKlO3cGdwAtk/MgzvtF1yiRdEgHgY=;
 b=rIUGlBWyXgPMcGmsbxV2H3echxU7UUoGq3OifpdLYvFMJuNYdDqkwUGl48kLxhTc93xg2C
 6B7K18J1LN8fgqAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 24B3E139A2;
 Mon, 22 Jan 2024 11:57:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id E1dcBjBYrmVZJAAAD6G6ig
 (envelope-from <iivanov@suse.de>); Mon, 22 Jan 2024 11:57:36 +0000
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6\))
Subject: Re: [PATCH v4 0/6] rpi5: initial support
From: "Ivan T. Ivanov" <iivanov@suse.de>
In-Reply-To: <ebffa598-6945-4a03-abe4-fe519df5fbfd@gmx.net>
Date: Mon, 22 Jan 2024 13:57:25 +0200
Cc: Jens Maus <mail@jens-maus.de>,
 u-boot@lists.denx.de
Content-Transfer-Encoding: quoted-printable
Message-Id: <223DA3F8-B17B-44CF-B247-12DEBD100A75@suse.de>
References: <03bbe9ad-7cc6-491d-8bd9-631f1cf04f39@gmx.net>
 <418F8AAE-136A-44A0-80C3-D01FFE00EC2E@jens-maus.de>
 <sjmi6dftbgx56isfyjtaryehzq2iollwxm2etlspiygehh3n6v@k4ws56nsbgfn>
 <6C9E5E0C-9C27-45A4-886F-8B8C641EF7A3@jens-maus.de>
 <ejituxf7ggiu2ciswrwoeqqjytb7mj2vn6gkxllywtnlm4aefi@br4zq7rfytlo>
 <3FB75D28-9BF9-4518-8BF1-519C884516F7@jens-maus.de>
 <fa7j66z5r7pul6zp5ljcntrb7xbazqxesz6wysrslrpxxhpafc@krztduo6pjm6>
 <25AB43C7-829F-4F62-AC8E-3284B22ACB03@jens-maus.de>
 <E7BFDAEE-00A9-463A-AF73-75101AFF2BC6@suse.de>
 <FB66DFF3-03B0-4DA5-8916-AB80CA6C6EB5@jens-maus.de>
 <dvpwizpui6a52dfmy57ghv4zmplvgqvow6oec7x5opwzh63zzl@jehyglofr6yh>
 <489FBAE5-501A-49F6-894D-58BE5C5429CC@jens-maus.de>
 <A0746263-646C-40C6-A2A6-659C39385E8B@jens-maus.de>
 <246035ba-0090-4cc3-982e-1de837ec7340@gmx.net>
 <6E2D7E91-E869-48C6-8CE8-0B410A2B67B9@jens-maus.de>
 <ebffa598-6945-4a03-abe4-fe519df5fbfd@gmx.net>
To: Stefan Wahren <wahrenst@gmx.net>
X-Mailer: Apple Mail (2.3731.700.6)
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-0.80 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-0.00)[39.11%];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 MV_CASE(0.50)[]; FREEMAIL_ENVRCPT(0.00)[gmx.net];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; FREEMAIL_TO(0.00)[gmx.net];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
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

> On 20 Jan 2024, at 12:50, Stefan Wahren <wahrenst@gmx.net> wrote:
>=20
> Hi,
>=20
> Am 20.01.24 um 10:48 schrieb Jens Maus:
>> Hi,
>>=20
>>> Am 20.01.2024 um 10:22 schrieb Stefan Wahren <wahrenst@gmx.net>:
>>>=20
>>> Am 19.01.24 um 22:26 schrieb Jens Maus:
>>>> I actually do have some good and bad news:
>>>>=20
>>>> 1. Good news: I got u-boot finally showing up with my RaspberryPi5 =
8GB both on the HDMI and on the serial debug UART like you reported.
>>>>=20
>>>> 2. Bad news: I actually got it working by downgrading the =
rpi-eeprom to the same 2023/10/30 (VERSION:30de0ba5) version like you =
have.
>>>>=20
>=20
> One idea would be to enable early debug in U-Boot (no idea how to
> achieve this). I assume U-Boot crashes before it's able to print the
> first line, but it's hard to believe it crashes at the very first
> instruction of U-Boot. So with some luck we should be able to narrow
> done the cause.

I was able to enable early debug UART in U-Boot and I will try to
find what is happening, once I get some free cycles.

Regards,
Ivan=
