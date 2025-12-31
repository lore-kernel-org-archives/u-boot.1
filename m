Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD548EE6446
	for <u-boot@archiver.kernel.org>; Wed, 31 Dec 2025 14:46:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E207583936;
	Wed, 31 Dec 2025 15:46:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QbJPQPDb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D673B83979; Wed, 31 Dec 2025 15:46:18 +0100 (CET)
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com
 [IPv6:2607:f8b0:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F26383700
 for <u-boot@lists.denx.de>; Wed, 31 Dec 2025 15:46:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=pbiel7@gmail.com
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-bc4b952cc9dso9358979a12.3
 for <u-boot@lists.denx.de>; Wed, 31 Dec 2025 06:46:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767192375; x=1767797175; darn=lists.denx.de;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GyRGDyIEEOzBSsw4XTkXpbtKubwq+0N5niMT+kpfHxQ=;
 b=QbJPQPDbi5fbX2iD9nTbjDSN3iWCbzhPdheS+uxyF9E28TML/OoGfW4GxhjrxD6oia
 Mfywygbq1aKzhcyXxgrn7vlg8bJ/N7iYn036Q3OQFuBeRDFj3/5aJwx+/UoQfv3ij+6B
 yt8XiyuGXa12RdpjQxzxzq2ntFU3T0TA8QhA61hxSECmXHcpfBetEYnY7VWWfdgpwt+P
 4AtfRpLkWQBL8kQU3zi3ini2MZj1wNmgY7dBLuYMWBXkOtxodSiYJCblwAkBgJEm37af
 LvcquEu78pcCXk3bomDnJAFQyBobpa1AW8prP1joEBdMFPpneZpssYofvSHS6hNu53CN
 fVaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767192375; x=1767797175;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GyRGDyIEEOzBSsw4XTkXpbtKubwq+0N5niMT+kpfHxQ=;
 b=lS8uONZlc4Xp3bBziXEYv636p4eBh6AYyq+wkp80T+hhMflKnu7hG1AVVcKG+QnyCt
 cmh3Gg2+11r+Ua86B5+R32ZJz7GvDGafcDk3Q2P7gH94+0kT21cml/yXLkS6R92Eai3R
 CvDA2nkHdYlHryqYCECrd/F3dkXhah147hYBreiLZuAbDhArkqLSShobtQ6QcWGB+yS1
 0bRw0e4o0x0VpeNQ7dP/FAvoYbbyYc1Bx0E/i1/nOWMlTq1PrsgcHu/zWIIbWTGXNwH4
 PgfAJRLlHtRpqhhYPDErT+0B3otvVp9OUL7fh3/sYl4vaPcTHYJpGJHXx2TDt0M2pOFs
 RMAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUisgu+HJnZdWDZoYywg4Y3Diqy0tiv2RSMXwjQFC3fK9DM8D5UdN0qTVcmJfybErxUbHH9JJo=@lists.denx.de
X-Gm-Message-State: AOJu0YyPnn7ubS/q2PcoG4Iqv+M9snxmxV2N8v6Rj+5CzIT+FHvs8pHE
 iktN2vRaspFMOWSp/J0ca1dZfAPze1xiET2+SQinCujk+aheQQXrGQmU3zYcVVIxepWFSASqXaw
 Egxit558wk2gAspQR1rtcSDob5CeL3l0=
X-Gm-Gg: AY/fxX7NJGFd90m11PD4RpO7IqxLrG/2ty+CoMnGTT4szaByBcM1Gb4VqUUgPVkqRlM
 WYE/nhy1zu+JbBF2MntryioCKCusOeM5N4568wi7MSExYZYwhIVwYyvv8qTeGORlmHIQQfiNGFK
 HAJs30S9yMj/rEe22TKXBJDdWROgZ8GbRn3WT+Z5dQ+sGg+8EHQ/SNifTyQVruIFh1bWQHSN/67
 AaAyL3pnzVhGDusaj2tnLlVh/Tfy03j90H7fgLOFQesoB0hhBxGc5afhjg/p8kh/4p9Tw==
X-Google-Smtp-Source: AGHT+IHvwRUOh5k5XIMZQI+JCKqjYJWJFWdMsiThtJoOR6+K21HXqof9yHpp535c/B1Ep+7SrRk0pMT6hZ8cK4zBlh8=
X-Received: by 2002:a05:7300:d110:b0:2b0:4902:c560 with SMTP id
 5a478bee46e88-2b05ec73ec1mr25316452eec.26.1767192374439; Wed, 31 Dec 2025
 06:46:14 -0800 (PST)
MIME-Version: 1.0
References: <CA+DkFDbQr40f2V8eKD5cSECVTM6aZyeZNxbZMqT4SeQJjMu3fQ@mail.gmail.com>
 <20251216-left-mournful-0bdb19f7c060@thorsis.com>
In-Reply-To: <20251216-left-mournful-0bdb19f7c060@thorsis.com>
From: Patryk <pbiel7@gmail.com>
Date: Wed, 31 Dec 2025 15:46:02 +0100
X-Gm-Features: AQt7F2oIXupH4x0hbJBMaBEkE09QTgp2jQh83_VXfDyG5W5usOe-03Drl9pYtwU
Message-ID: <CA+DkFDZAgjL3amMoLqSTQbbKngeBk0EMBTciBDDKrxV-UsP=fg@mail.gmail.com>
Subject: Re: Standard Boot integration - script validation before execution
To: Patryk <pbiel7@gmail.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hello,

wt., 16 gru 2025 o 15:59 Alexander Dahl <ada@thorsis.com> napisa=C5=82(a):
> Reminds me on the problems I faced when trying to implement Secure
> Boot with A/B rootfs.  IIRC there were two things I ended up doing:
>
> 1. putting the boot script in a separate volume outside of rootfs and
> the A/B scheme.
>
> 2. use signed FIT image for the boot script instead of the old
> fashioned U-Boot script, enable CONFIG_FIT_SIGNATURE, and disable (!)
> CONFIG_LEGACY_IMAGE_FORMAT.
>
> Not sure how this plays together with standard boot, but once you
> instruct U-Boot to only accept signed FIT images, that also applies
> for scripts put into a FIT image.
>
> Greets
> Alex

As you suggested, I played a bit with the boot script and fit image
and indeed it's possible to include bootscript only in the fit image
thus verifying it using a verified boot mechanism. It can also be
loaded by the bootmeth_script. That solves part of my problem. Thanks
for that suggestion. I didn't know about it before. However this is
only part of the problem I'm trying to solve as I said and would be
grateful for other suggestions as well, but first I will outline what
I actually want to achieve.

I'm trying to implement firmware and software updates for my board,
but have some problems on how to approach it.
As a second stage bootloader (that gets loaded by the BootROM) I'm
using BL2 from TF-A. Its purpose is to load FIP (Firmware Image
Package) that contains BL31 (EL3 Runtime Services), BL32 (OPTEE), BL33
(U-BOOT). Then, once the u-boot is loaded it is supposed to load the
Linux kernel. Following my requirements I need to be able to update
almost all components namely: FIP (thus BL31, BL32, BL33), kernel
image (including bootscript) and rootfs.

TF-A supports something called PSA Firmware Update that allows the
selection of a FIP bank, just an ordinary A/B scheme where there are
FIP-A and FIP-B copies, and the selection happens through so-called
metadata. It also supports a boot counter that allows it to roll back
when the boot counter reaches max boot attempt. Up to this point
everything is quite straightforward.

Things get more complicated when the boot process reaches the u-boot
stage. As I pointed out I need to have two copies of kernel image and
boot script thus I need the following:
- bootscript-a
- fitImage-a (kernel image)
- bootscript-b
- fitImage-b (kernel image)
I am aware that I can embed the bootscript in the fitImage however, as
I said before my fitImage is stored on the disk in the encrypted form,
so the bootscript is used to decrypt the kernel image before loading.
I decided to follow A/B paths for each component thus the TF-A is the
source of the boot index.
The information about the boot index selected by TF-A (A or B) is
propagated to u-boot, so u-boot indeed has such information. The boot
index can be then used to select bootscript-a/fitImage-a or
bootscript-b/fitImage-b. However I'm not sure how to do this. I mean
it's not technically difficult, it's rather a matter of "how it should
be done correctly". What's more I want to make use of Standard Boot
instead of old distro boot. Looking at the Standard Boot methods there
is e.g. bootmeth_script available however I don't see how this could
work in my case. This bootmeth_script just simply looks for a
bootscript and if it finds it, then it loads it. As I said in my case
I have bootscript-a/b, not just a single bootscript. What's even worse
I cannot make separate boot partitions for boot-a and boot-b as the
only partitioning scheme available on my SoC is MBR which allows you
to create up to 4 partitions. I already reached this limit (boot,
root-a, root-b, data), so the only reasonable solution for me would be
to put the A/B artifacts in subdirectories under /boot part. To sum
this up - the only sensible solution that comes to my mind is to
create my own boot method that will use the TF-A provided boot index,
then will scan /boot partition looking for e.g. boot-a/boot-b
subdirectories (depending on the boot index) and the required
bootscript (wrapped into fit Image so that it can be verified by the
verified boot mechanism).
However, to be honest I'm not sure if this is the right solution.
Would be grateful for some suggestions.

BR
Patryk
