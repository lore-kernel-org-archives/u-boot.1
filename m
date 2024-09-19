Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E06DCE8D67
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 09:53:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F6868910F;
	Thu, 19 Sep 2024 11:53:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="eB9JfzsP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9R0mCRR7";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="V/EPfYR1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ouvEqVoA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65AB78912E; Thu, 19 Sep 2024 11:53:17 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4685E8910F
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 11:53:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=iivanov@suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 81D282088C;
 Thu, 19 Sep 2024 09:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1726739594; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=axYEzYi1JchMOgQ+7Nbxj60o25xupQVAg67sn/bJQYs=;
 b=eB9JfzsPMUPKmG2mHWWYL60H4RYVca+p7ejFq96r6oJhu/HiXkgk4BeGstFG3ErP8dwpYL
 eBQIvuJvMCGw1T7SKArT5zZ8fjSqXNa2L1bB4oSkbLewYFZ66hr2Fbnivvvs+AjHFLN+tS
 0LUwkBOH1MGKzcpKbSS/t6n66Tl8Wrg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1726739594;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=axYEzYi1JchMOgQ+7Nbxj60o25xupQVAg67sn/bJQYs=;
 b=9R0mCRR7tmC3xR7TwGX5ubEuVHfxmG88WpDQaou00OG4ktXbxw5Ta9nByeqYlv9u7tB8Xp
 nzuQNlD1SRcIm9BA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="V/EPfYR1";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ouvEqVoA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1726739593; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=axYEzYi1JchMOgQ+7Nbxj60o25xupQVAg67sn/bJQYs=;
 b=V/EPfYR1XCPQLtx0V99Yoth+VqY6D7uZce+NEFZHuwQN2fYKda3RIi10EEx/TYofWkRY6e
 /HLTKXwnjJiInVoNcFDn8xZ9a8/az3driKA2MnH+eCAGGEY9n0mGye2N0pqK/wVl4ybZgE
 w5ZixkO8qg+e/Bk24khfGy+Qh2isd18=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1726739593;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=axYEzYi1JchMOgQ+7Nbxj60o25xupQVAg67sn/bJQYs=;
 b=ouvEqVoAHwSdAAWkRFh+KIuqdh9a8fRrYNjFfWqJ9wPTjTSsqkNbACz9ucW5gEBHORMLbj
 BCp/oXLt1aK1FnCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EF0D513A5F;
 Thu, 19 Sep 2024 09:53:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8kJmN4j062bieQAAD6G6ig
 (envelope-from <iivanov@suse.de>); Thu, 19 Sep 2024 09:53:12 +0000
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.1\))
Subject: Re: [PATCH v4 0/6] rpi5: initial support
From: "Ivan T. Ivanov" <iivanov@suse.de>
In-Reply-To: <9943877347134e40cee8c0d9cc7f641c@agner.ch>
Date: Thu, 19 Sep 2024 12:52:58 +0300
Cc: Matthias Brugger <mbrugger@suse.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Dmitry Malkin <dmitry@bedrocksystems.com>,
 Thomas Fitzsimmons <fitzsim@fitzsim.org>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Anatolij Gustschin <agust@denx.de>,
 wahrenst@gmx.net, florian.fainelli@broadcom.com, u-boot@lists.denx.de,
 =?utf-8?B?SmFuIMSMZXJtw6Fr?= <sairon@sairon.cz>
Content-Transfer-Encoding: quoted-printable
Message-Id: <B1136352-B9D3-4990-B5E5-7C318809C957@suse.de>
References: <20240110122908.31612-1-iivanov@suse.de>
 <9943877347134e40cee8c0d9cc7f641c@agner.ch>
To: Stefan Agner <stefan@agner.ch>
X-Mailer: Apple Mail (2.3776.700.51.11.1)
X-Rspamd-Queue-Id: 81D282088C
X-Spamd-Result: default: False [-6.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MV_CASE(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.net]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_TWELVE(0.00)[12];
 MIME_TRACE(0.00)[0:+]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FREEMAIL_CC(0.00)[suse.com,gmail.com,bedrocksystems.com,fitzsim.org,nxp.com,samsung.com,denx.de,gmx.net,broadcom.com,lists.denx.de,sairon.cz];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.de:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[agner.ch:email, imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, suse.de:dkim, suse.de:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
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


Hi Stefan,

> On 19 Sep 2024, at 12:36, Stefan Agner <stefan@agner.ch> wrote:
>=20
> Hi Ivan,
>=20
> I am looking into enabling NVMe boot support using U-Boot on Raspberry
> Pi 5. Which brings me to some questions wrt PCIe support (see below).
>=20
> On 2024-01-10 13:29, Ivan T. Ivanov wrote:
>>=20


>> * I am dropping PCIe patch for now. I made some progress on porting =
changes
>>  from vendor Linux tree to U-Boot. Unfortunatly testing it is little =
bit
>>  tricky. They are many devices behind PCIe, but more or less all of =
them
>>  requires missing either "reset-controller" or "clock-controller" or
>>  "pin-controller" drivers. I was able to probe "cdns,macb" device, =
but
>>  access to ethernet PHY over MDIO bus is stucking. Then I ported
>>  "raspberrypi,rp1-adc" driver from vendor Linux tree, but it requires
>>  missing clock. And on top of that machine that I used for developing =
this
>>  crashed and I lost my PCIe changes :-|. Anyway.
>=20
> Have you tried using a M.2 HAT? This likely won't require much in =
terms
> of enabling the device.
>=20
> You write that you made some progress, is that compared to v3? Do you
> mind sharing the latest version of your patches?


No further progress on PCIe for U-Boot from my side was made, sorry.

Stan is working on adding support for 2712 PCIe in Linux [1]. Perhaps
once this is complete we can work on adding U-Boot support for the same,
unless someone don=E2=80=99t beat us, of course.=20

Regards,
Ivan

