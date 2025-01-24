Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F4BAC02181
	for <u-boot@archiver.kernel.org>; Fri, 24 Jan 2025 07:12:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63A4C807E4;
	Fri, 24 Jan 2025 08:12:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="ZrAL+IxE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CB3E807FE; Fri, 24 Jan 2025 08:12:20 +0100 (CET)
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3EF0580780
 for <u-boot@lists.denx.de>; Fri, 24 Jan 2025 08:12:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id CD1F51483FF8; Fri, 24 Jan 2025 08:12:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
 t=1737702737;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0q9kt60WqOMaVXvtNf1rx0HBPl+4iikMmvZ7IpOVNLg=;
 b=ZrAL+IxEkU0hQ6b7y5+spAjVeqJtjs60J/9M4Jl0SytD4gxle4w7d/pmsoCk+CqnxE3pcR
 LuCGGZUg224QciVl+3R4uwopxwYfi31OKXtIkNrcKDRrQFqpWJG8RVvmDZZbR7WN++7PGn
 0vEc2y0aOTtWZHai5D78+TVhWjp1uzMOd4PYIaQAl5NffrGmjHoCtJLJ9gWagrPTuS9kI0
 Yv6H8uWeXv6zsJrHYpE2Oz4aEK60jv+NsxDKThyqnJM4ZG0pJ+fC1YLxtsf5JAKFBDSaGv
 gLz1Ldwy/VcTU57OQpWHOFWMLnm2dHkEYGTwFnHkE0V7fQC47UaakU98G8KYKg==
Date: Fri, 24 Jan 2025 08:12:11 +0100
From: Alexander Dahl <ada@thorsis.com>
To: Floyd Brown <flobro30101@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: mkenvimage CRC does not match the CRC of fw_setenv
Message-ID: <20250124-rocking-cattail-0c9f0fee3f92@thorsis.com>
Mail-Followup-To: Floyd Brown <flobro30101@gmail.com>, u-boot@lists.denx.de
References: <CAKiD1a9bH=0N3KZP6Hzbvznhueqb-Oob_zvtGky+g-EEix2+gg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKiD1a9bH=0N3KZP6Hzbvznhueqb-Oob_zvtGky+g-EEix2+gg@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
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

Hello Floyd,

Am Thu, Jan 23, 2025 at 02:04:03PM -0500 schrieb Floyd Brown:
> When I run the same file against both utilities, they do not produce
> the same CRC.
> 
> The CRC of fw_setenv matches what uboot has when the environment is
> created inside the image.

fw_setenv is Linux userland to write to flash on the running system,
right?  And mkenvimage produces an image file IIRC.

> Is this a known issue? If so, I am sorry to bring it up (but maybe
> remove mkenvimage...)

By chance: are your settings for redundant image the same?  For
fw_setenv this is set in file /etc/fw_env.config on the target system.
For mkenvimage you pass -r as parameter or not.

Greets
Alex

