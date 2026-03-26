Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20165106F304
	for <u-boot@archiver.kernel.org>; Thu, 26 Mar 2026 08:39:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D57683CF5;
	Thu, 26 Mar 2026 09:39:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="G+FKIwHB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2CC4083F00; Thu, 26 Mar 2026 09:39:16 +0100 (CET)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C3E87838BB
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 09:39:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-66970715adbso1319836a12.3
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 01:39:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774514353; cv=none;
 d=google.com; s=arc-20240605;
 b=Pf6F0JcVsJqENMnQ8m6qEo3cfxjxtUzHvs+0GqwAQfP8AqcJWLlOwtU8nqrkpTh3CB
 rPEtooLBJ4DphQSfN52+aYfcKYmbuFQhmFEx8gSV5f1H+35D3bX+ZWVYZdRXe0yKBnG3
 FsgRS7JbNSdvNe94iIGbhpeLQ/iT2LwRJ+QtSdV1ZMKdu66+W/oY0qxGAxSnFML2EkKB
 UlcWmLL1S0ZhaRnwW8OE5Y4mEWzFXlW1CUenYkXNlkeb07F6/eQaVLUnt8MX4kVzWczR
 LO2hTRvQB2GW1PXdAkXw4wlbOHbzjcxiKU7EwDrc5P5I6SyOszBHOcaBooCxU2Ezjd8b
 HK3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=IuL6InvL3v0CMIn/z++V6AmKw0Hhuh2DygZcYSQfouA=;
 fh=3YBEyUAJcFHPir+epSX6WoqVXRtrTcGZXcwKxBnomaA=;
 b=Ycpk9YV+ATxsXnAcszhShNgCd0tDWPKeWQF9cXEC6LwxhpL20IoaTkDvOQj3wosTwH
 f/5JlkVpdfJt9Domosd4/bPXLCpLAAqLUXLM2+U/6MuALXDA6N7+hC4GUaUn2MDGOq00
 P5RtPZQMYCwqQ0pUaPw6DUIHzScK4BsANN/oLH+pW8jjzIRSs/WlK44K/Q455SJ+f0oS
 8xLV3OMnMJFSzpEjoJblwZF8IrOdNspqsY0KBLr1Haxfg9EHPkWAc3/o/jbK5cjYcTgQ
 vcTBoYr9KG8H/C2Vpbaq0gY4R+z2/YwWsFKCPWcgddhLQVxbyIRofmu7HyaY2N96T2Rt
 6agQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774514353; x=1775119153; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=IuL6InvL3v0CMIn/z++V6AmKw0Hhuh2DygZcYSQfouA=;
 b=G+FKIwHBsqfuEbiXdsQ2EwX5nZsylnSGIlh3jzyH+zMI7WkgVJ+5gbJgpEc2u4n7tc
 +2QS0g7euPsgY78qDKb8LBknCgUCZTzdcsOSTNMCPOFd8RPDZm5R8nxajwE6JxrkqtI6
 Xxe4eTvK+VrOCFlarWcgcl7juU8AZ6LC1TfAXBWKX9ve+jNsaSbeBDMkRy4Cyvvaid4L
 QUSoD1TjWBFsCyC2ir0NRDP8N1jxcqDFpflRYHk8mVM/pHo3hGJBm7vLTbwJbPIHo03T
 N4Z5LEBVY7QfQkWq5Ed+VvqLnc0Ic7huNYOyjXPf4e6AJ881INjECEzzNwn8nkB+Rfee
 sKSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774514353; x=1775119153;
 h=to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IuL6InvL3v0CMIn/z++V6AmKw0Hhuh2DygZcYSQfouA=;
 b=HWfbkZg4XcrjJjxyrmDODdYYJVw9dfP/vFewsz7w/lD97V29l+2zocYMmonQoOsZrY
 n+SX6DjXJXBeKNZ3OZHbkWCr9xZmhniqSYcVa+jWJ6Mtu/RnsBpoPlVOowV8fB0uf9jH
 aopvdb0nnuOt9QhNPQQkp1lCgtFU3XD3OSR8MTplTTh3JRr/6ZKv7OiQXI7511GcYPcj
 ED7PCf0By3c7Pvl6JLpgvicAp2+xEZbbey2Uc6mHyzyus/BDaKY3l/vd93drPWAxoUk0
 WEe5Y6Phb1K+iTdAT82K3QrU7dDlDxjuuRVrMlTsKvv5owzw9d4s5Jx6mqFGU9iCT2tM
 4g5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpMZgKctEOuF5bG1C74CE66d6PoE6zEGdrp/qYTsktXTrcMyoT9nsZPUSwrJp6CdfyZFt40XQ=@lists.denx.de
X-Gm-Message-State: AOJu0YyS9IZhy5NmEfJHQEX2rROgLKkwhhMwC31PBpBOkkItUaUGPUPT
 NNzdwtDPxP/i5W/fsVEJqMf53dXUEwvBLCfUd5XxnGhL0/9ymgXgKSBUKn8rDXzTYI4J12NyAcc
 RBbaXo+07RQrsXJRN1nhx644zKXvNKuM=
X-Gm-Gg: ATEYQzx34bdToZswu3rJ13+lniwK48olGHeztVPHN/Tn+tllurRkPEwMKc5aszg+rh/
 4E2fxtfAeuKXl8HJ3eE6nW7USO4tNh34bDqWiykhlz5Ol7aOmQwbA5/WwEGe3QjjRoXP4CnSRbO
 dn8uvVhr81j1yuWY9+SJ7FLAMaaMvDLqUYB5KekDNcZdandZls10Hfj79k4uT3kI/b49UKlDkJR
 SJiT3rJKluWiJH64dldFnUg71OimR4MqUArruApBL3TdlyCd0q9vStcrkrP3GyJPNtWAP5wdW0C
 juabhGEQNV7+ExgLJfND8VP+SaNTgguONx7Ym4fLHZyrcJxJ2vQgN82By0cFLJbVUdXRGHlanip
 9VoXh4LOVxKEgkql5+iZ8grVt0/Gjz1MGPD0Z+ipOwAreAopJ0jItkbfWscK6raK3FVIUlozNHo
 lMxQ/ffOoeNMI=
X-Received: by 2002:a05:6402:458d:b0:66a:199d:138 with SMTP id
 4fb4d7f45d1cf-66a82672d92mr4047059a12.20.1774514353120; Thu, 26 Mar 2026
 01:39:13 -0700 (PDT)
MIME-Version: 1.0
From: Peter Robinson <pbrobinson@gmail.com>
Date: Thu, 26 Mar 2026 08:38:59 +0000
X-Gm-Features: AQROBzClumcywhEgxD9q7OJ1judX2dM-mImp21pzRhnKqsiYK3KEl7Gx3cXXWz8
Message-ID: <CALeDE9P4wDZ+yRSTnA5fWZgw8YOmEbr9gvc=snNVJ38TX9aTZw@mail.gmail.com>
Subject: Pull request: rpi-2026.04 rc5
To: Matthias Brugger <mbrugger@suse.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
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

Hi Tom,

Please pull the updates for the Raspberry Pi.

Updates for RPi for 2026.04-rc5:

- rpi: Update the naming for bcm2712 SoC RevD naming
- arm: bcm: Include missing errno.h

The following changes since commit
eb95914b9f5886b7ca0eaa2dbcd8a66bb8e5f81a

https://source.denx.de/u-boot/custodians/u-boot-raspberrypi.git
tags/rpi-2026.04-rc5
