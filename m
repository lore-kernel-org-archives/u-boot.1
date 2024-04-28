Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DB2AC4345F
	for <u-boot@archiver.kernel.org>; Sun, 28 Apr 2024 05:01:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D00E88189;
	Sun, 28 Apr 2024 07:01:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dxCF58G7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DEE46881FE; Sun, 28 Apr 2024 07:01:53 +0200 (CEST)
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com
 [IPv6:2607:f8b0:4864:20::a33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C2E50880F4
 for <u-boot@lists.denx.de>; Sun, 28 Apr 2024 07:01:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lucent@gmail.com
Received: by mail-vk1-xa33.google.com with SMTP id
 71dfb90a1353d-4dac112e192so1073136e0c.1
 for <u-boot@lists.denx.de>; Sat, 27 Apr 2024 22:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714280510; x=1714885310; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=4szKtLNmFSwEAr9/rJUzXoz/DqzhWXUQRtlSyt7KL10=;
 b=dxCF58G7GE5Mbl5yV6Q63EtltTJU3pbiMPxOPLnZd2M3D9EPYh8lYHUmVF5eq5iZqC
 bJgLxVhCC7F6jGqVfylwwxylXc9/Y4nbpqJrqL6q7zmD6JPs7ENXOa+1DRSCcXui1OyU
 Yx6NnYftimvNjOMAvgJ5/Ac8WWmyUjmqd7vtxsucQTBPlYHzHGC6h1YC8oEbDPd9Flt2
 mNnxV9aKXjHHuEDcSFNu5JQvfryfgmR5x51G7csCBJTve0CbK2dBYxI7e2MlcbsHr+bh
 N5WC0xAmiYgWDym2rMwKlTeD0ceSFnAbX89fftxCxVkA4wufGJ9bp/2AzFB3f6lNWoz5
 WA7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714280510; x=1714885310;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4szKtLNmFSwEAr9/rJUzXoz/DqzhWXUQRtlSyt7KL10=;
 b=JaZvDOgegg0LmqlC6Whhbv4ycdp1lO220DGUdR9pnl85OYIj1ob/8W4urdqEd7HcBq
 THrH506qG74lyTYspvfh92Pu51Q9dWUOglxDfTWqnEiLrMEiJkR1x7BYDbOy3dam+UC/
 D7o78shtTVXyKaMmCv45OJHLTAwqjYlq4BEPmdUxr7tpJuDqorGNzYUPFXHvFJdvzR/1
 u92EvwAs0W0p1OQxX04jXo7VsFaPz6oz1yoBq6FUR6FuqffwTIahEkepW/4WfhtZRv9w
 xwu2ev1gzhTt3K2jQuYC9GeYypuF9lE5P3sr7rGjWl8mqC4vDHtISKl5EHIuHUt9q7yp
 guXA==
X-Gm-Message-State: AOJu0YzALfVfzd4OePzKkfgRK7L9WJF17XmGj4j1ckyKYQG/MEYpzceP
 6J6pJPXJyjk6FzbKY4/sHiCr/YDU3B09AD/AXO4mxlMDkxcHeeoWA3wUWNS/d1bTBpR6+oCOvNs
 rg40Bm0I8O38UL/LPz3e1GU3d1Q+xi06vYoo=
X-Google-Smtp-Source: AGHT+IGFcujAhUqdxo6vfntVVddA+v74OT+JkbPcQTOK329u7E0iU8CK4c8VJrfjeeR4riEgwWk4U1cgcv+c+kHjGZQ=
X-Received: by 2002:a05:6122:4109:b0:4c9:98f8:83db with SMTP id
 ce9-20020a056122410900b004c998f883dbmr7686996vkb.5.1714280509493; Sat, 27 Apr
 2024 22:01:49 -0700 (PDT)
MIME-Version: 1.0
From: E Shattow <lucent@gmail.com>
Date: Sat, 27 Apr 2024 22:01:38 -0700
Message-ID: <CANV2PTM-Pd1wwsEJBrKjbRAcj70nAA_B3W5g4guKugbFJ46DEQ@mail.gmail.com>
Subject: How to improve eficonfig menu for users?
To: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

I suggest to flatten the eficonfig UI menu so it is easier for users
and avoid needing efidebug command for most situations.

Flatten the eficonfig menu:
Replace the UEFI Maintenance Menu with Change Boot Order as the UEFI
Maintenance Menu.
Add to UEFI Maintenance Menu a keypress to edit.
Add to UEFI Maintenance Menu a keypress to delete.
Relocate the Add Boot Option menu invocation into UEFI Maintenance
Menu above Save.
Relocate and replace the Delete Boot Option menu as a contextual
action into Edit Boot Option above "Save".

Quality of life for global boot order items:
Boot order items not represented by the Boot#### variable could be
displayed with some text suffix i.e. "... (EFI global)" to make it
clear that trying to edit may be no-op, and action of delete could
no-op or deactivate as likely what the user wants for trying to delete
an immutable boot option.

Avoid need of efidebug command to edit boot variables:
Add to UEFI Maintenance Menu a keypress to edit advanced. This would
be an alternate version of Edit Boot Option taking user input (as is
done for Optional Data) instead of file selection UI.

If it is too complicated to try and cross-reference boot order against
Boot#### variable then this can simply go to that existing sub-menu
for the same overall menu depth. Importantly the UEFI Maintenance Menu
would always show the boot order to the user so it will not be
overlooked as it is now.

Open for comments.

-E
