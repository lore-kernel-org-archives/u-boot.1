Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59482C48BC3
	for <u-boot@archiver.kernel.org>; Mon, 19 Feb 2024 08:31:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C48287DDF;
	Mon, 19 Feb 2024 09:31:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="GHqfGfkp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1lY10xlH";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="o4qytCjy";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7Xtxekee";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0EB287F1A; Mon, 19 Feb 2024 09:31:08 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 68F1B87D25
 for <u-boot@lists.denx.de>; Mon, 19 Feb 2024 09:30:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=iivanov@suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C5BB4222FB;
 Mon, 19 Feb 2024 08:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1708331456; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k2Tf5LSLcVMMFj6RMLVDyiiXZ7HyEx3GlVW9LJgRUE8=;
 b=GHqfGfkpIICNxdamK5eWuiTzfCrzCnTizjX99jpZ+4/2Eov5bYglilFg3bBNdDM5288IDK
 qKC8VzxEY3TLUZmtSigpcuG1XdB+nuHK17fPwbOMfsuXZsniozU7NTmFSspW2pmBvI4EqV
 UtMPGIPz1e50R9cRDZHS4gCrQkWU8Ds=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1708331456;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k2Tf5LSLcVMMFj6RMLVDyiiXZ7HyEx3GlVW9LJgRUE8=;
 b=1lY10xlHH9FSCWZhP0qotsopglzVAZhNDIPPXLnpQc2H1ePEYQw0dMrDgM8Yh+X7eAWFrU
 bNMmet8Bt0gWcKBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1708331454; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k2Tf5LSLcVMMFj6RMLVDyiiXZ7HyEx3GlVW9LJgRUE8=;
 b=o4qytCjyJ6mu4x1bFnuBb7sdDtFtuf3m6yclLBdgrH9FXcwfKJo0RK4dbD3USaNfR9crJk
 mghD4mlXl14D+4ugoI3npWA0JNp1WmgLzwXpRy1b1MBEYp8vfafmJ0uQS1gBIGnGboHZCe
 Fu8sCTizPnCg03Qs3qGV11yGYf/kTHY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1708331454;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k2Tf5LSLcVMMFj6RMLVDyiiXZ7HyEx3GlVW9LJgRUE8=;
 b=7XtxekeezrDcdaAh4695QZfS+/Cohx0FPqtMy10twNY5EUHHWvRLfJnKoLHt28xwwBzMkU
 owL8IMrbOD5W92Ag==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 82CC6139C6;
 Mon, 19 Feb 2024 08:30:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id enj5HL4R02WlQAAAn2gu4w
 (envelope-from <iivanov@suse.de>); Mon, 19 Feb 2024 08:30:54 +0000
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6.1.1\))
Subject: Re: Booting RPi5B with latest git
From: "Ivan T. Ivanov" <iivanov@suse.de>
In-Reply-To: <1031326949.2069496.1708196119886@mail.yahoo.com>
Date: Mon, 19 Feb 2024 10:30:43 +0200
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 John <therealgraysky@proton.me>
Content-Transfer-Encoding: quoted-printable
Message-Id: <B5482069-1D43-418D-8602-416585D1788C@suse.de>
References: <VhjYVKfXb22i7OLAE71TUsea5YoQHzRZl2a-pTntu6mAGWiAuixDG1380ukg9ag-1j7_JZUXh8mLYxId4j3mmvjopigOO6NgqVF0aBxC8Io=@proton.me>
 <1031326949.2069496.1708196119886@mail.yahoo.com>
To: Jojan <jjvazha@yahoo.com>
X-Mailer: Apple Mail (2.3731.700.6.1.1)
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=o4qytCjy;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=7Xtxekee
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.53 / 50.00]; TO_DN_EQ_ADDR_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
 TO_DN_SOME(0.00)[]; MV_CASE(0.50)[]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; FREEMAIL_TO(0.00)[yahoo.com];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 BAYES_HAM(-0.52)[80.37%]; MID_RHS_MATCH_FROM(0.00)[];
 ARC_NA(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FREEMAIL_ENVRCPT(0.00)[yahoo.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,mail-archive.com:url,2711.so:url]; 
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from]
X-Rspamd-Queue-Id: C5BB4222FB
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

> On 17 Feb 2024, at 20:55, Jojan <jjvazha@yahoo.com> wrote:
>=20
> For RPi 5B you need bcm2712 device tree . RPi4 uses 2711.So the e =
rpi_arm64_confi does not work for RPi5
> Also make sure that you have the changes  discussed here.[GIT PULL] =
rpi: updates for v2024.04 (mail-archive.com)

You don=E2=80=99t have to change rip_arm64_config file. For RPi5 device =
you
should have bcm2712-rpi-5-b.dtb in dtb directory on your boot drive.

You could get this file from "Raspberry Pi OS=E2=80=9D or openSUSE =
Tumbleweed
images, at least. You could compile it yourself from the vendor Linux
tree too.

Regards,
Ivan

