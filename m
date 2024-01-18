Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E7BEC4707B
	for <u-boot@archiver.kernel.org>; Thu, 18 Jan 2024 08:33:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD4E287B8B;
	Thu, 18 Jan 2024 09:33:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="ktDIso3D";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lqCN577+";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ktDIso3D";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lqCN577+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 025A987B8D; Thu, 18 Jan 2024 09:33:32 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE03D87835
 for <u-boot@lists.denx.de>; Thu, 18 Jan 2024 09:33:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=iivanov@suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 56E5A222AE;
 Thu, 18 Jan 2024 08:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1705566809; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eupFwodEK1AmfK0OdIovKSWo02CODqjDl1ZZC6mxS4M=;
 b=ktDIso3Dvlk0oki7sNJ+nE5aqFDh2jSpOppqlZzKRfUFb7xvzCzvCwfv94BsVqXoj7tsUm
 aFz8YN8TrE2mDSDahexE5PvL5Khzf4gl3DtBm/iqqGbr2A/7dl4oAGGT9hjUxmNE1KXH4J
 ccYbCpFdcxL4XU7J5tge/Ye7S2GzY2o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1705566809;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eupFwodEK1AmfK0OdIovKSWo02CODqjDl1ZZC6mxS4M=;
 b=lqCN577+kFGBPAuAEPTIXUJJf40B8lirZw8igcno3awPIEDk7y/hp8BcKMrgV3q9Fzf1mh
 /JXSLBEO+FKpjVCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1705566809; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eupFwodEK1AmfK0OdIovKSWo02CODqjDl1ZZC6mxS4M=;
 b=ktDIso3Dvlk0oki7sNJ+nE5aqFDh2jSpOppqlZzKRfUFb7xvzCzvCwfv94BsVqXoj7tsUm
 aFz8YN8TrE2mDSDahexE5PvL5Khzf4gl3DtBm/iqqGbr2A/7dl4oAGGT9hjUxmNE1KXH4J
 ccYbCpFdcxL4XU7J5tge/Ye7S2GzY2o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1705566809;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eupFwodEK1AmfK0OdIovKSWo02CODqjDl1ZZC6mxS4M=;
 b=lqCN577+kFGBPAuAEPTIXUJJf40B8lirZw8igcno3awPIEDk7y/hp8BcKMrgV3q9Fzf1mh
 /JXSLBEO+FKpjVCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2F37B136F5;
 Thu, 18 Jan 2024 08:33:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id TK7+CFniqGUgKAAAD6G6ig
 (envelope-from <iivanov@suse.de>); Thu, 18 Jan 2024 08:33:29 +0000
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6\))
Subject: Re: [PATCH v4 0/6] rpi5: initial support
From: "Ivan T. Ivanov" <iivanov@suse.de>
In-Reply-To: <5C0A3CD4-2591-4266-B9CC-7EC38C6A88C3@jens-maus.de>
Date: Thu, 18 Jan 2024 10:33:18 +0200
Cc: u-boot@lists.denx.de
Content-Transfer-Encoding: quoted-printable
Message-Id: <454FB8E4-52A8-482D-8671-5650F8C4773C@suse.de>
References: <BD4D4B77-9C54-4FD7-8EEF-A65E674E0747@jens-maus.de>
 <sfo77vzvmblyv5g5ek6uc6oxrf5n7dcp3vsw2g2lvfnnrlyaft@kc6s7vvspwvz>
 <4DCC64E0-F0E4-4AF6-8E81-62B156E81554@jens-maus.de>
 <2303FFA8-E2FA-4AA4-AE67-FF5E904D21DD@suse.de>
 <A796E025-0F6E-4FF7-BA4D-2F52CD763B4B@jens-maus.de>
 <9AFD4C3E-E1B7-4EA7-8589-7060A2747732@suse.de>
 <5C0A3CD4-2591-4266-B9CC-7EC38C6A88C3@jens-maus.de>
To: Jens Maus <mail@jens-maus.de>
X-Mailer: Apple Mail (2.3731.700.6)
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-0.80 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; MV_CASE(0.50)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 NEURAL_HAM_LONG(-1.00)[-1.000]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
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

> On 18 Jan 2024, at 1:06, Jens Maus <mail@jens-maus.de> wrote:
>=20
> Hi,
>=20
>> Am 17.01.2024 um 17:45 schrieb Ivan T. Ivanov <iivanov@suse.de>:
>>=20
>> I have aarch64 based machine at hand running openSUSE,
>> thus I am building U-boot =E2=80=9Cnatively=E2=80=9D, no =
cross-compiling.
>>=20
>> $ make rpi_arm64_defconfig
>> $ make
>=20
>> I just dumped latest Tumbleweed[1] to uSD card and copied
>> u-boot.bin to EFI. I can see the HDMI output.
>=20
> I actually just did that. Installed a fresh Tumbleweed on a microSD =
card, booted it up with a rpi4 and after installing all necessary build =
tools I applied your patches to u-boot 2024.01 sources, and then =
executed these two commands to let it compile a u-boot.bin file which I =
then put in /boot/efi to replace the u-boot.bin which is/was already =
there. Then I pulled the SD card and moved it over to the RaspberryPi5 =
in trying to get it booted up. However, again no HDMI output at all and =
unfortunately also the serial output on the debug probe does not show =
U-boot popping up at all. Interestingly, using the patched u-boot.bin =
with a RaspberryPi4 still works and it boots up perfectly fine, but not =
with the RaspberryPi5 I have here.=20
>=20
> Any idea why this might be the case here while you report that the =
above mentioned procedure works for you? In fact, the RaspberryPi5 I =
have here is a 8GB model and with the rpi-eeprom version from 2024/01/05 =
[1] in case this might be relevant.

EEPROM version on mine device is older[1], but I suspect that size of
the RAM is what make a difference, mine have only 4GB of RAM.

I am afraid you will have to connect that UART debug cable and share
what is the memory map on your device :-)

Regards,
Ivan

[1] RPi: BOOTSYS release VERSION:30de0ba5 DATE: 2023/10/30 TIME: =
16:45:10=
