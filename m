Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7C04D609A1
	for <u-boot@archiver.kernel.org>; Tue, 16 Dec 2025 14:59:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EDAC6839D7;
	Tue, 16 Dec 2025 15:59:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="L0lyM+fA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8229A83A5A; Tue, 16 Dec 2025 15:59:40 +0100 (CET)
Received: from mail.thorsis.com (mail.thorsis.com [IPv6:2003:a:e28:26e4::10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31F1483923
 for <u-boot@lists.denx.de>; Tue, 16 Dec 2025 15:59:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 20A741484458; Tue, 16 Dec 2025 15:59:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
 t=1765897177; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 in-reply-to:references; bh=tHx0RLj/UrEN/KzB6dqjB+bPVxdXY8wAPitCTlC6nuw=;
 b=L0lyM+fAMKbWHBP7IFSzpSO0z8R16yNeaGtY2wHcJiKwPx7oCbTu347dH9OtAA+zV1YKmn
 sdoaolu8QIGqBmQOLKF7DX7hYVdtW5XskTz/rTiSBFTMepNLsPjNmiTWy+dxmpKqwgchaw
 8i1lTF52HcMjKwYpP3zJhxtMMBqWuqz2Yirc1RjRo7Ei0KeHNXBtuwuH9DJAWgQK/ujBta
 +Lpthjcn4aNbBNOtszSc0rAO3L4erZtewSr6UIzUDkxq+QxprfXEyiunDUZSYnjkHaIlY/
 ISaB8rg2lotRHl1MpUnwo9CcCS83EPqWDEtNnBJys0IMEBHKP5Ms3D6nrJcUAg==
Date: Tue, 16 Dec 2025 15:59:31 +0100
From: Alexander Dahl <ada@thorsis.com>
To: Patryk <pbiel7@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: Standard Boot integration - script validation before execution
Message-ID: <20251216-left-mournful-0bdb19f7c060@thorsis.com>
Mail-Followup-To: Patryk <pbiel7@gmail.com>, u-boot@lists.denx.de
References: <CA+DkFDbQr40f2V8eKD5cSECVTM6aZyeZNxbZMqT4SeQJjMu3fQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+DkFDbQr40f2V8eKD5cSECVTM6aZyeZNxbZMqT4SeQJjMu3fQ@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Last-TLS-Session-Version: TLSv1.3
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

Hello Patryk,

disclaimer: migrating from distro boot to standard boot for our boards
is on my todo list, but I have not looked into standard boot, yet.

Am Tue, Dec 16, 2025 at 03:13:59PM +0100 schrieb Patryk:
> Hi
> I would like to integrate Standard Boot on our custom board based on
> NXP LS1028a, as it currently uses a so-called distro boot.
> Normally I would just follow the instructions in the doc about
> converting from distro boot to standard boot, but things are in fact a
> bit more complicated. My board supports dual rootfs following the A/B
> update scheme, so I need a place where I can check the boot state,
> boot counter and so on, so as to set the final rootfs partition to
> pass to the kernel. That's actually not a problem - I can just use the
> bootmeth script and put all the logic there. The problem is that on a
> production system, the devics will be protected by the Secure Boot
> procedure, so the script to be executed should also be verified before
> the execution. 

Reminds me on the problems I faced when trying to implement Secure
Boot with A/B rootfs.  IIRC there were two things I ended up doing:

1. putting the boot script in a separate volume outside of rootfs and
the A/B scheme.

2. use signed FIT image for the boot script instead of the old
fashioned U-Boot script, enable CONFIG_FIT_SIGNATURE, and disable (!)
CONFIG_LEGACY_IMAGE_FORMAT.

Not sure how this plays together with standard boot, but once you
instruct U-Boot to only accept signed FIT images, that also applies
for scripts put into a FIT image.

Greets
Alex

> In the current solution (distro boot), the boot
> command, first loads the script, then calls esbc_validate over the
> script header and if the validation passes it sources the script so
> the OS can be loaded. In current bootmeth_script there is no place (or
> I'm not aware of) that would allow me to do vendor-specific validation
> over the script. What would you advise in this case? Is there any way
> to "inject" some plugins into the existing boot methods, like  e.g. a
> plugin that would be overriding or adding some functionalities to
> existing bootmeth_script? I can of course patch the existing
> bootmeth_script with a command that would perform the validation but
> this would no longer be a generic boot method. Or perhaps should I
> create my own boot method?
> 
> I would be grateful for any suggestion
> Best regards
> Patryk
