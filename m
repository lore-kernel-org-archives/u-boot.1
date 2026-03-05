Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 822D2EF8FE4
	for <u-boot@archiver.kernel.org>; Thu,  5 Mar 2026 17:26:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 730CA83F98;
	Thu,  5 Mar 2026 18:26:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=janga.la
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=janga-la.20230601.gappssmtp.com header.i=@janga-la.20230601.gappssmtp.com header.b="wgAl8yXJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3D2B839A8; Thu,  5 Mar 2026 13:51:30 +0100 (CET)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 572D081E18
 for <u-boot@lists.denx.de>; Thu,  5 Mar 2026 13:51:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=janga.la
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=chris@janga.la
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2adbfab4501so35972925ad.2
 for <u-boot@lists.denx.de>; Thu, 05 Mar 2026 04:51:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772715087; cv=none;
 d=google.com; s=arc-20240605;
 b=SMIPY0zWIYvLu4NDB6HrpG0xnw2Wrp3b1AglaHweifBlOqHPfIIOP3AgxvWqBGvW8y
 Z8VB47ShNKpp5VzrRgkluO05GvkVE2fn2RA+O1KZ1WxY8EGTWvbWsQTkPnK34UMrD0IM
 bfX775sS1TcJmqV8GA6fiU19m4BFTVgPNiIT5sGy+rGPLd9KrrXdPPWhhgcG5YLM6XlF
 rtS6/LIgtGlQutbmmmpu0nA1XRIlLTSe1Zd5iuFrJ0kna3qaMpw0EfATGWJ6dX1FBcQN
 l7aUvJ4kDzwK8nBTIGmy4Zg7+jJC3EHBhXfeZZ5Z/6kH71ans9ZI+KSIb2m9t8wcU+IV
 r8Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=CqRKRFGg/hIPwKUcMgZXk7MH5IV5bvWABM3jV3f/rrU=;
 fh=ea3Lb1kmqTyoSSOGd3r79PdCdfQHXBjS15GzGXd6hwE=;
 b=iCEPUXfuv40HPhtjIE2Lcr0rW8p+hD9uThJyBd5VCYH9WN2pUwGu3tRlCedQd+/lbl
 tfWUzOTT83NcHiJlWCdIrRt8PdTbFPx0x4f4oOLdgkCSbvJxB4XdLGMl/Z9DoB/Ogk9v
 lHtiFCqfQi+O/y/nIqEteYxLUxukZfvkC0omUaXYEmz0NhTDscd/5V9FUsWqTffNta0g
 wpbx1thdO6rR1gVxjTg2t6Xa9PyHW4ZHdSc+6HYdpQGLyNhcCHCUxkxIGqAHC39NByoC
 a/IutuWlGrmSwRcBalizfvyxy5ddAkiZMHEOcstU5apcols/KzPa3hTt34QUZRdbEBRv
 RI4w==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=janga-la.20230601.gappssmtp.com; s=20230601; t=1772715087; x=1773319887;
 darn=lists.denx.de; 
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=CqRKRFGg/hIPwKUcMgZXk7MH5IV5bvWABM3jV3f/rrU=;
 b=wgAl8yXJLlx/Q5PI0+BL0J9CbsXLTwlsNSsgDkTvqtJwBAkgilO7AVioD2KflK4Uth
 yUpgK9myUVs6M9o2NkWh15PnK0axCOmXRT2Y6ZxQYhdtC4lgWs9D3Z2vsT1X0mGzgOjg
 kg77bS4UdgNDIwXZLFnNqxVFXsPSR0K08kqdlm2J4dycwrphnqHSaiF6EXMpX20M5pi9
 U+ZjukYnewig/HcaejHCgZkITbBsPh4P85WihbO2f5rBaKsddPKj9L/HNbDfn89Ovq+J
 j4VOsXQq5PRZXpNuokzMVYiNoDxZzzMn0wT31ZA7NdhMqjEHoUnGZ88BbnePSCveHtXi
 KdQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772715087; x=1773319887;
 h=to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CqRKRFGg/hIPwKUcMgZXk7MH5IV5bvWABM3jV3f/rrU=;
 b=H+EIzgonsXbTPRE3X3KaAMZ1M/YPRD2SaG9PFLtgt0iggac8pIXM1USMxGHP5jKhO+
 MlTUIOge550ZuXp2Pcv1wY1b6AWpCdR1Z751OmeQRPfe6S58+RI9txPZikFq4Ojd0Bf5
 0agFDC1qz02AgC0cCZy06PmApf0mSIaxZ0QyhQ7GK/71sS+yzwYLw8KaIpAU4E/M9TLw
 a18XC2xPcDXX8rte4yjizTZIgBLEtweJOv7pQT8e8g3AO9n9eLO0P1fZ64EZpyfw4T9v
 /tepFO8V7QSd+HiA4ba1gaLawCYodOvVQZJsZiObOi1lR0jDxaNexjQJ9JT/R+c/PWVM
 11xw==
X-Gm-Message-State: AOJu0YxDVtH+Jn1+t+vTT10OmWrkyL9LWbXvzDNqzBbE0CdxYzPqYUUG
 8+efbPPOv3EoTfUB6Q8khUqPT6Ol1A/iE76C2REyZ0Xw5xoBdvelHSh/86EUSVI0UT3W5AABZc/
 2mDJOWf3BIIo6K8lmnZ2Dr4gjDyOz2r5si9oeuCYUpeARV43iU6UM4kvNUQ==
X-Gm-Gg: ATEYQzxFZS0gpHxMYdm7ggGKRkj5OOzDoZhepYIsWpT4Ym1GF3ZYp7CwjxcodbEnrZc
 havTnKwuTJTXc1jk8wR1CZhFxQsl0i7zUwxOSYuLp3fEwx5V+4LsMEEVxzWls41hpFU3BwedmTW
 GZB0M5frP6MqlJvpUuVS4Sd4o2pOEcfgzgafx6TbAb7CMHhC0TI/KvR5FbH8yxVkDQUmk7oqDQ6
 yRy5ILBYR7makNPv1MlgdLUt6UwWeG1vgLreOKrB+vhGhuWR9ChKllV3KzJebsP5llFWJ96yh9w
 1JIjf7sGxQ6nS04IUE/GhVmGhjGRawC4w53i0ik=
X-Received: by 2002:a17:902:cec2:b0:2ae:7f49:b46f with SMTP id
 d9443c01a7336-2ae7f49b4d5mr239405ad.11.1772715086637; Thu, 05 Mar 2026
 04:51:26 -0800 (PST)
MIME-Version: 1.0
From: Chris Punt <chris@janga.la>
Date: Thu, 5 Mar 2026 12:51:16 +0000
X-Gm-Features: AaiRm53H-9meupVjdvH3L_4ko3a0cAwFtNoaWYtJiI9wRRB4WQ-RtCF8IDH8gn0
Message-ID: <CA+V_-YSfX5aExhhpXp3PMdbm8qseyJqTJc7Sm8vM2sB_br8i+Q@mail.gmail.com>
Subject: [QUESTION] CM5 / BCM2712: RP1 UART console support in U-Boot
To: u-boot@lists.denx.de
X-Mailman-Approved-At: Thu, 05 Mar 2026 18:26:35 +0100
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

Hi,

I'm working with a Raspberry Pi Compute Module 5 and trying to expose a
debug UART via GPIO 8/9 (UART3 on RP1).

In Linux this works using:
  dtoverlay=uart3-pi5
  dtoverlay=stdout-uart3

However I cannot get U-Boot console output on these pins.

My understanding is that access to these UARTs requires RP1 support
through the BCM2712 PCIe root complex, which does not yet appear to be
implemented in U-Boot.

Is it currently expected that RP1 UARTs cannot be used for the U-Boot
console on Pi5 / CM5?

Thanks
