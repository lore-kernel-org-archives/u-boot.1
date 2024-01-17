Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57CBAC47DA2
	for <u-boot@archiver.kernel.org>; Wed, 17 Jan 2024 15:24:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B86888753C;
	Wed, 17 Jan 2024 16:24:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="2R53+oPd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="s8X0yDqr";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cHQV4lJe";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4lq8ACPm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E661986E88; Wed, 17 Jan 2024 16:24:09 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 13E50870B4
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 16:24:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=iivanov@suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8D1F41FD4E;
 Wed, 17 Jan 2024 15:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1705505044; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZJE1Jri0S40fTmylW602a6CDzo1ujDgB1L3iFRmFNc8=;
 b=2R53+oPd4SV3PfmNDXs5e7EfFLYVelrMiN/8Jg+CTmyIAKHAiSgWi6m8KBxI6RtbV962FI
 YpQ4L0sqJx1gAn5rhrMnReIewHd7mN94Fuax6Ug4pCLlA4uqPFAN6Fu0AX/zF++7/VMEI1
 7C+vgdwuDvBg2bDCEAfrtaizEDMSGTw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1705505044;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZJE1Jri0S40fTmylW602a6CDzo1ujDgB1L3iFRmFNc8=;
 b=s8X0yDqrP4cjfliu9DFTjTS8NxKxDMyzVvcd+QhMZkQnZyXbcHnmkbgipaY7t1QQfmSsWU
 o5kDJs/3y/VHfnAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1705505042; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZJE1Jri0S40fTmylW602a6CDzo1ujDgB1L3iFRmFNc8=;
 b=cHQV4lJeANapbhwVkwsiVyzLtnbLMuM25t0xkR2Xa0Xl512azWlFN1MPHztzhOfVomQPg7
 QPq/vlI9twBYsRpLmIOaOC0PLodQqek4f7nP2tXqaq4Msj9TCkK/z+P2uf39hzw+ZANwXT
 dco6Qlekptrv1K57XpG3Qvnh5ju6+JA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1705505042;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZJE1Jri0S40fTmylW602a6CDzo1ujDgB1L3iFRmFNc8=;
 b=4lq8ACPmHdoWoo2pqW2T54AGqwffS0eiitj0YXtdiHXhX7YwTTylSHq6nLqNo0HTLVkVNl
 BrLyKkn1cu7BgHCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 66F9213800;
 Wed, 17 Jan 2024 15:24:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 1aKLFhLxp2UwGAAAD6G6ig
 (envelope-from <iivanov@suse.de>); Wed, 17 Jan 2024 15:24:02 +0000
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6\))
Subject: Re: [PATCH v4 0/6] rpi5: initial support
From: "Ivan T. Ivanov" <iivanov@suse.de>
In-Reply-To: <4DCC64E0-F0E4-4AF6-8E81-62B156E81554@jens-maus.de>
Date: Wed, 17 Jan 2024 17:23:51 +0200
Cc: u-boot@lists.denx.de
Content-Transfer-Encoding: quoted-printable
Message-Id: <2303FFA8-E2FA-4AA4-AE67-FF5E904D21DD@suse.de>
References: <BD4D4B77-9C54-4FD7-8EEF-A65E674E0747@jens-maus.de>
 <sfo77vzvmblyv5g5ek6uc6oxrf5n7dcp3vsw2g2lvfnnrlyaft@kc6s7vvspwvz>
 <4DCC64E0-F0E4-4AF6-8E81-62B156E81554@jens-maus.de>
To: Jens Maus <mail@jens-maus.de>
X-Mailer: Apple Mail (2.3731.700.6)
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=cHQV4lJe;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=4lq8ACPm
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-6.01 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[]; MV_CASE(0.50)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim]; BAYES_HAM(-3.00)[100.00%];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; RCPT_COUNT_TWO(0.00)[2];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,jens-maus.de:email,raspberrypi.com:url];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[]
X-Rspamd-Queue-Id: 8D1F41FD4E
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

> On 17 Jan 2024, at 17:13, Jens Maus <mail@jens-maus.de> wrote:
>=20
> Hi,
>=20
>> Am 17.01.2024 um 16:07 schrieb Ivan T. Ivanov <iivanov@suse.de>:
>>=20
>> On 01-12 14:10, Jens Maus wrote:
>>>=20
>>> Hi Ivan,
>>>=20
>>> first of all, thanks for the updated rpi5 patchset. However, I am =
unable to reproduce that it is actually working as you suggest. Could =
you please quickly elaborate on your test environment and the test =
config.txt for the RaspberryPi5? Here I have compiled U-Boot 2024.01 =
with your patches applied and using the =E2=80=9Erpi_arm64_defconfig=E2=80=
=9C, put the u-boot.bin file on the sd card and then added =
=E2=80=9Ekernel=3Du-boot.bin=E2=80=9C to the config.txt file. The =
environment I am using is a buildroot-based system which boots nicely =
with the default RaspberryPi boot loader and a RaspberryPi5. However, as =
soon as I replace the =E2=80=9Ekernel=3DImage=E2=80=9C line with =
=E2=80=9Ekernel=3Du-boot.bin=E2=80=9C the system stalls and there is no =
HDMI output (nor any console output) with the u-boot 2024.01 version and =
your patches applied.
>>>=20
>>=20
>> Yes, I am using rpi_arm64_defconfig for building the U-Boot.
>> And as I wrote in the cover letter I am using openSUSE Tumbleweed
>> image[1], [2]. Once you copy image to uSD card mount EFI uSD
>> partition and copy new u-boot.bin over existing one. That
>> it is. Just make sure you clearly sync, unmount the card.
>> You can find config.txt file in the EFI partition.
>=20
> That=E2=80=99s in fact exactly what I was also trying in addition to =
get u-boot running with your patches in my own buildroot-based =
environment. So I was also exactly using this Tumbleweed rpi4 image and =
simply replaced the u-boot.bin file with my own build version which I =
built with your patches applied and using the rpi_arm64_defconfig as the =
build config. However, there is still no output on any of the HDMI =
ports. Haven=E2=80=99t tried to see if there is any serial output on the =
special UART debug port of the rpi5. Should there be any output at all?

Unfortunately on RPi5 they moved UART debug port to
separate connector [1], [2].=20

Let me update my Tumbleweed image and check again.

Just to reiterate that if not properly syncing
content to uSD card could have strange side effects.=20

Regards,
Ivan

[1] =
https://www.raspberrypi.com/documentation/computers/raspberry-pi-5.html
[2] https://www.youtube.com/watch?v=3DkP2S3JUH-qk=
