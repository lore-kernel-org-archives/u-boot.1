Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F0E0C6FA8F
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 12:52:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0708D8645B;
	Thu, 24 Aug 2023 14:51:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KjBkt7Ly";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D3B38865A4; Thu, 24 Aug 2023 13:54:19 +0200 (CEST)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com
 [IPv6:2a00:1450:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6C5F864B7
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 13:54:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rsultanov89@gmail.com
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2b9d07a8d84so103456071fa.3
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 04:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692878056; x=1693482856;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=AnUbJDDcGDgCtoxjEzdC4Z1XZaJStCTsLnzA4/YyZvM=;
 b=KjBkt7LyLN8ZD8zaxf4v5r1LKjfeZYnUSZGXqDKRdfkQTMgv8XWSe9fW9ww/zDpNmW
 o6rQYfs+l6xmJ4sPEkAqSC/2A5wEyyMtQ+00quOmf85UbXbCWK/QDgSn3rhpQE+3cSKL
 xZamrPbPPXMUkWdwIdQcFjJUCSO0sg8qPDB4Uz34wPBA7wvkA5jDLFj9uqCkyEjGP557
 BU6BFQqZ/QHoImaTU34aohzKI1z4OXxTgcAd2DajquGZyYtCuT7ZGoFHqacE9pq4QQYH
 dJMYbmOnbGueXSekvELlBoVNzXWJy8t94h9HCb722SPh2Qdl84RjIPWtokAiq1nMU0f3
 xrjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692878056; x=1693482856;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AnUbJDDcGDgCtoxjEzdC4Z1XZaJStCTsLnzA4/YyZvM=;
 b=Wc1rhZ4S/mwlUz7kF6I/4KBlBa9ZOV7YAkWLyMSAoK0ytyYnXsB1ZoyYLxCTmioPyQ
 BanEejCCnh5zf+VIqgyd5wP3MUQydawyk7ioXWntpOjhYTkPtLp8np4aMM0tvWRegwbY
 aBUVb45MJXI9QvqWQOYkdbuKclNuG2hN3kM9FeO9sHLXEMTSos+94h//19whwYJulct+
 72zBo/Bo5eX9rb1YpR58O+4WrOvB5cM8FNCDkDmTwkg7302XR+Fopp28eYKEK3TcKDuU
 4AFv/oIMBeapy0odMd3KzZM4uWbZsQcg5l1hU4OdqeIMftVxYF92F4THp95Cj4q6pywD
 DuJQ==
X-Gm-Message-State: AOJu0YyeLO5miD9kiP5HMkSQRwiF2scuq/LTKEbD7Mg7l2oCKIk0Aokb
 irvvhhN77zs7KrMdFApcqnysuEXEdtbehMhiq/emvWoLs5Y=
X-Google-Smtp-Source: AGHT+IFhJNosVuPVuOTRy0oQdbP5Vp/+l5oQgJsjRCDbN8AZTS6i8AHTnUB+iaUa/KDkAw8CInDjzwt9XINT3vLFeEs=
X-Received: by 2002:a2e:b714:0:b0:2b6:e2aa:8fbc with SMTP id
 j20-20020a2eb714000000b002b6e2aa8fbcmr11447481ljo.8.1692878055530; Thu, 24
 Aug 2023 04:54:15 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?B?0KDRg9GB0YLQsNC8INCh0YPQu9GC0LDQvdC+0LI=?=
 <rsultanov89@gmail.com>
Date: Thu, 24 Aug 2023 14:54:45 +0300
Message-ID: <CAKsbxdE8YZRVR4jzcpqWs5K_Y9O298RfH=AqrU0=4CEjLs+U1Q@mail.gmail.com>
Subject: u-boot-hi3518ev200
To: u-boot@lists.denx.de
X-Mailman-Approved-At: Thu, 24 Aug 2023 14:51:29 +0200
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

Hello!
I'm studying Embedded Development. Now I'm trying to build u-boot for
*Hi3518EV200
*using sources from your repository:
https://github.com/49handyman/u-boot-hi3518ev200

When I enter the command
*make hi3518ev200_defconfig*
I get an answer
**** Can't find default configuration
"arch/../configs/hi3518ev200_defconfig"!*

In the */configs* directory, I only see the *hi3518ev200.h* file

Can you please tell me how to assemble u-boot for *Hi3518EV200*?

Thank you.

----
Best Regards,
Rustam
