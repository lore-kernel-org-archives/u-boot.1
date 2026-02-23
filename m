Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6665EE98E10
	for <u-boot@archiver.kernel.org>; Mon, 23 Feb 2026 10:02:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F08DC83DF3;
	Mon, 23 Feb 2026 11:02:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="b/p9ezZd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4125283BC9; Mon, 23 Feb 2026 09:42:24 +0100 (CET)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C2E88063E
 for <u-boot@lists.denx.de>; Mon, 23 Feb 2026 09:42:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id AD9E41A116B
 for <u-boot@lists.denx.de>; Mon, 23 Feb 2026 08:42:21 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 7BA255FD43;
 Mon, 23 Feb 2026 08:42:21 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id F10A110368EE9; Mon, 23 Feb 2026 09:42:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1771836140; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=X4FvhEX8B6Z0Ye/XIUhy9CD1O5RB7E16hqHJEBcsajM=;
 b=b/p9ezZdfBDGlfmGkWzfAkjy0tkgC15azkpY/WJm4A71gnY5PWjvf81tG1Dq+tHqHTPX5v
 vTbIAtA0xszmB17HqAR1TjVanIdRjqoqFxutUXVxxYYd/+P6Hsv9YuzMJ4yGCWipfckJ/H
 4bRdyiYIuTG2dXKsaK603sVb3zUpyeCBA5LEZFvoRXk6sOIqM8DVk5brYs26vwFuUFwGUT
 Q2VE7uRlFPSkybbdrm0jtWWvitVsJK3vmVSZbZfKaICVrQaJY8G8LFirE58Jy1yDaEdnFH
 hdsnQnqT0oTmh+wIRYvNZUgPOYRW06H32dMtIKeuIeGN0rPebTEC9pBMrpsxcg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Eric Kilmer <eric.kilmer@trailofbits.com>
Cc: u-boot@lists.denx.de,  jmcosta944@gmail.com,
 thomas.petazzoni@bootlin.com,  trini@konsulko.com
Subject: Re: [PATCH 1/1] fs/squashfs: fix heap buffer overflow in
 sqfs_frag_lookup()
In-Reply-To: <20260220194808.1146082-2-eric.kilmer@trailofbits.com> (Eric
 Kilmer's message of "Fri, 20 Feb 2026 14:48:08 -0500")
References: <20260220194808.1146082-1-eric.kilmer@trailofbits.com>
 <20260220194808.1146082-2-eric.kilmer@trailofbits.com>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Mon, 23 Feb 2026 09:42:19 +0100
Message-ID: <87zf4zrgus.fsf@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Mon, 23 Feb 2026 11:02:21 +0100
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

On 20/02/2026 at 14:48:08 -05, Eric Kilmer <eric.kilmer@trailofbits.com> wr=
ote:

> sqfs_frag_lookup() reads a 16-bit metadata block header whose lower
> 15 bits encode the data size. Unlike sqfs_read_metablock() in
> sqfs_inode.c, this function does not validate that the decoded size is
> within SQFS_METADATA_BLOCK_SIZE (8192). A malformed SquashFS image can
> set the size field to any value up to 32767, causing memcpy to write
> past the 8192-byte 'entries' heap buffer.
>
> Add the same bounds check used by sqfs_read_metablock(): reject any
> metadata block header with SQFS_METADATA_SIZE(header) exceeding
> SQFS_METADATA_BLOCK_SIZE.
>
> Found by fuzzing with libFuzzer + AddressSanitizer.
>
> Signed-off-by: Eric Kilmer <eric.kilmer@trailofbits.com>

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks!
Miqu=C3=A8l
