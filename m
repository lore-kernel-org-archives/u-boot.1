Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE073CD4F49
	for <u-boot@archiver.kernel.org>; Fri, 22 Sep 2023 11:10:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68D6186AF7;
	Fri, 22 Sep 2023 13:10:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DSSZmjQd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52B3786199; Fri, 22 Sep 2023 04:40:11 +0200 (CEST)
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com
 [IPv6:2607:f8b0:4864:20::d29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44CE7833DE
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 04:40:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=samsong8610@gmail.com
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-79f8b2bfb2cso42516739f.1
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 19:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695350408; x=1695955208; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=GMDhamlNexp86gZqwzY9nGE+NcrKqrVJXhoV8Nj3nfI=;
 b=DSSZmjQd11dBjvNUP+crW1q1nv8B/pZw6x51tGFQz1x+hs3oF6GXqFz6DD5iQAfbPI
 27LL1va8LY0wHX1+zOMNQPBARvyn62hp7jwesS++0F605aTBO7NWIYeEDrGhvCNOyb52
 qdKKV8fJml/T6CWmEGpIurlNOOar6L2nAG7J0s5FAp6nYYkiggDW3+WT1JlLCWms0rw3
 M8NMdqNIUafLtV50opKVplPthRETNXvne1R09R7UontlfgwS6hmD0AKZo/e0R1V8AtNL
 P06WzsfU+NoLR5UeYcRT5xWiySW92epV05bQpLBdzuFRTI/ULafq5bnavK4b36NLGsmT
 5bjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695350408; x=1695955208;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GMDhamlNexp86gZqwzY9nGE+NcrKqrVJXhoV8Nj3nfI=;
 b=KY4oARXoQ8O6AVBRYifioXCXJFV03tp1GSMakusm0oAA1aJjbNO1Z5zApxU7VrgiI6
 RUIl2KtxuSN3ex9CxRtbteZeHpDAZhwJ1oKF3KcKCdgo0Bq2Qyu5gyCzxMZ8VjZ1IzHK
 eS+Rb+5k4nbIwe2cU4d8SWVZx8w0I6W1TcLK0/XYa+ddIxxaVDFowi17aYRCQlZNf/oQ
 4IBhZuESdnHfZ5XQf6nk4aw7kXms149yd1JTtrHRu+H84JGRWPyqvs5BIGezJWrXtIlF
 YJZ6mc+z3BwiCn0PMtXzye0KmNQy3Fu88s9n32cWArG/WSXmuIAb0VDDhz7NWnZrQHbI
 lGow==
X-Gm-Message-State: AOJu0YxGyb4AnhxfReo5ztqHdWttrogGVQq4JUWjtkfw1vV8uvcap75i
 iDS21R+kEjOpzmbIAnV2qiDpRv0nGQPOSjCo9WHBAajs2Q3NOg==
X-Google-Smtp-Source: AGHT+IFD0ehzbJZBApKnGjqgb1RTSwbHOTzXKxNKJi5BoYP7rfU+6H0mZcKHVfN5mWnoeQELkfxQ5dtPi9NPtkx0u04=
X-Received: by 2002:a5e:834c:0:b0:780:d031:bc42 with SMTP id
 y12-20020a5e834c000000b00780d031bc42mr7797652iom.16.1695350407801; Thu, 21
 Sep 2023 19:40:07 -0700 (PDT)
MIME-Version: 1.0
From: Song Sam <samsong8610@gmail.com>
Date: Fri, 22 Sep 2023 10:39:57 +0800
Message-ID: <CAE5Lu8PxCp8_vL9cuUPWdMWqDcbnVOpDrTN=1zy=HwSX2=6ofA@mail.gmail.com>
Subject: bootefi with initramfs
To: u-boot@lists.denx.de
X-Mailman-Approved-At: Fri, 22 Sep 2023 13:10:21 +0200
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi all,

I am currently in the process of booting the Linux kernel using the U-boot
'bootefi' command. However, I am facing an issue with the root file system
(rootfs) disk, which is not functioning properly. As a solution, I am
considering providing an initramfs to the kernel.

The problem I encountered is that the 'bootefi' command does not accept an
argument for the initramfs, unlike the 'bootm' command. Upon further
investigation, I noticed that the kernel attempts to load the initramfs
from the EFI tables. However, I have been unable to find any information on
how to define an initramfs table for EFI.

I would greatly appreciate any suggestions or guidance regarding this
matter.

Thank you,
Sam Song
