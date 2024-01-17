Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE8FEC47258
	for <u-boot@archiver.kernel.org>; Wed, 17 Jan 2024 16:46:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0381187A4B;
	Wed, 17 Jan 2024 17:46:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="Vho33jez";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="eqgnJOHT";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ldSgnv+z";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="o+jA0teL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3BB5587A4B; Wed, 17 Jan 2024 17:46:09 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41CB686EF1
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 17:46:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=iivanov@suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id AF5EF221D0;
 Wed, 17 Jan 2024 16:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1705509966; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hf/nzheg1peCMo6lckAeMngj9m7iJYXtI6P2bBkn8EU=;
 b=Vho33jezgpvIC6KQmwuVUbEBH95dxECJTkfrbWflTLWhXpriC/6qb1/WkNPHMisD4MNYTe
 HWX/B5Ig6gScPMqMWEAIEDWx4XVBQMX9TCw4OAbrEc8aXfuux+36R9V1fCWKYWD1bfTUz+
 3/yE/kZxQ0P1hBWGzfwf7CKvdieMFh4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1705509966;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hf/nzheg1peCMo6lckAeMngj9m7iJYXtI6P2bBkn8EU=;
 b=eqgnJOHTCYyrGHdS3WtvNVxA+HVN+QJXXpXgroJeg6pUonKADSugH/Tj3YwXWjyNeF+8nv
 omJfTWkMes8AleCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1705509965; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hf/nzheg1peCMo6lckAeMngj9m7iJYXtI6P2bBkn8EU=;
 b=ldSgnv+zRV7DRSyD/K5nhV8KyULqD/1FRh3Teq94rIausgLyGdF46y3TU9/wkXXWFC70aD
 teHXoLT3yj+ILdH0dFXw9cc49OJlAMDP20GlU1weR3OdPSiyvl2owERNtHdzb7p0UdIv8i
 lYo+EqI81fpkBwiLg1XjXNX3zU9jkZg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1705509965;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hf/nzheg1peCMo6lckAeMngj9m7iJYXtI6P2bBkn8EU=;
 b=o+jA0teLKd7ED2B94UISnXrv2UN/UmQMdKBjSTEFnX0GU2oCCYQbsHju4ipoyr9d34ZXZB
 MEZ8nSY19ydMvLAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8A57513800;
 Wed, 17 Jan 2024 16:46:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id USZKH00EqGXbMgAAD6G6ig
 (envelope-from <iivanov@suse.de>); Wed, 17 Jan 2024 16:46:05 +0000
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6\))
Subject: Re: [PATCH v4 0/6] rpi5: initial support
From: "Ivan T. Ivanov" <iivanov@suse.de>
In-Reply-To: <A796E025-0F6E-4FF7-BA4D-2F52CD763B4B@jens-maus.de>
Date: Wed, 17 Jan 2024 18:45:54 +0200
Cc: u-boot@lists.denx.de
Content-Transfer-Encoding: quoted-printable
Message-Id: <9AFD4C3E-E1B7-4EA7-8589-7060A2747732@suse.de>
References: <BD4D4B77-9C54-4FD7-8EEF-A65E674E0747@jens-maus.de>
 <sfo77vzvmblyv5g5ek6uc6oxrf5n7dcp3vsw2g2lvfnnrlyaft@kc6s7vvspwvz>
 <4DCC64E0-F0E4-4AF6-8E81-62B156E81554@jens-maus.de>
 <2303FFA8-E2FA-4AA4-AE67-FF5E904D21DD@suse.de>
 <A796E025-0F6E-4FF7-BA4D-2F52CD763B4B@jens-maus.de>
To: Jens Maus <mail@jens-maus.de>
X-Mailer: Apple Mail (2.3731.700.6)
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-2.60 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-3.00)[100.00%];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[]; MV_CASE(0.50)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[jens-maus.de:email,suse.de:email];
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

> On 17 Jan 2024, at 17:30, Jens Maus <mail@jens-maus.de> wrote:
>=20
> Hi,
>=20
>> Am 17.01.2024 um 16:23 schrieb Ivan T. Ivanov <iivanov@suse.de>:
>>=20
>>> That=E2=80=99s in fact exactly what I was also trying in addition to =
get u-boot running with your patches in my own buildroot-based =
environment. So I was also exactly using this Tumbleweed rpi4 image and =
simply replaced the u-boot.bin file with my own build version which I =
built with your patches applied and using the rpi_arm64_defconfig as the =
build config. However, there is still no output on any of the HDMI =
ports. Haven=E2=80=99t tried to see if there is any serial output on the =
special UART debug port of the rpi5. Should there be any output at all?
>>=20
>> Unfortunately on RPi5 they moved UART debug port to
>> separate connector [1], [2].
>=20
> I know. In fact, I already have such a rpi debug probe [1] at my desk. =
Nevertheless, haven=E2=80=99t tried to fire up the rpi5 with your =
u-boot.bin to see if anything sensible comes up at that special UART =
debug port which could explain the stalling and no HDMI output I saw =
here last time I checked.
>=20
>> Let me update my Tumbleweed image and check again.
>=20
> Thx. Can you perhaps also elaborate on your build environment for that =
particular u-boot.bin build? Or perhaps put a binary of it somewhere so =
that I could check if it works with your u-boot.bin build.

I have aarch64 based machine at hand running openSUSE,
thus I am building U-boot =E2=80=9Cnatively=E2=80=9D, no =
cross-compiling.

$ make rpi_arm64_defconfig
$ make

I just dumped latest Tumbleweed[1] to uSD card and copied
u-boot.bin to EFI. I can see the HDMI output.

One thing which I forgot to mention is that once I see
Grub2 prompt I change console parameter from ttyS0 to ttyAMA0
and usually add =E2=80=9Cignore_loglevel earlycon=E2=80=9D.

Regards,
Ivan

[1] b66d5fa70e5cab998bc6000737015746c636e4b622397b407225b9de73f4a9be  =
openSUSE-Tumbleweed-ARM-XFCE-raspberrypi.aarch64.raw.xz=
