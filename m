Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29C27C61CE8
	for <u-boot@archiver.kernel.org>; Sun, 15 Jun 2025 12:25:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A800F82C30;
	Sun, 15 Jun 2025 14:24:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Gmfpb4gs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4C4882C30; Sun, 15 Jun 2025 14:24:57 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF9B381E06
 for <u-boot@lists.denx.de>; Sun, 15 Jun 2025 14:24:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-adb2e9fd208so720227566b.3
 for <u-boot@lists.denx.de>; Sun, 15 Jun 2025 05:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749990295; x=1750595095; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=bZ0aOOzlqC6N5dZ5/A9TqKPR7tSftGvjOrQ/wyTLZEo=;
 b=Gmfpb4gshy1D4N/1xdTRuFSSPDs7eRpHbPcNk11T3+4V5OU5BZ+Ut0zgmfuZusW7LL
 kReuBH/gL7fld/nilfzQafQPZnqUF6MNiTOQ8lieMIFUufTWBhVZd7MGMSrlVcSK7XZr
 uaWZ/ZO8H/5wsraQfrpCO+rTKY0worWR4+kgFjAXzo83XAx2XirWOmjRkPEyFrCE10DL
 O7NwEQAey1AWy0cWBOP1JIghyWVuxH43uTMDbsQlbuZcbcv90Fs791sm2q822tiw4pVn
 kpvXGxfjoVHk5U9/uGKTeBcRNw5kjSN3KHY53gFdhHEk6jGFWBkZok1jQeSvdhwXm8Ls
 nYew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749990295; x=1750595095;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bZ0aOOzlqC6N5dZ5/A9TqKPR7tSftGvjOrQ/wyTLZEo=;
 b=YHAGqYv8UNxrWxb/pRkrov0VtAPaKieORJTFFkD/yh4ji9vSH5zB1KvV28frSbGf1k
 74R5DY5LJQNUTWQpXWSCR+ZPf4WEHnRJ14/cIMBbJ+3gvA0gn73vmkGEqZ/k9DCQhHjB
 VDsgz3Unyd1DQs/jqkkChkBx4OL+6CXNPOcO6YrJQwIeCt11QY85qJbchwv40UuFtW42
 SGPg3oBmqUOVEh1/sJGYjeZ88dlTUwapbcmAejwngF4CxiAUOU9RNQSo+rREOtTunhv0
 RqctG+3lu7vHnKJqUpE90GALW9pe1LnjsgaM+pUFHRpQXmYbfGXilXMOth4y1smPOBw9
 LVgQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfYtMSucsffjCnNVRb1Ii9nxS95InTVrFUTfzK3FqmssZCZvh1YJ+ogv0Xyt4Z5jOTUx1MZ0c=@lists.denx.de
X-Gm-Message-State: AOJu0YxQ4hpNQSsHB/cNLywBY7cj8SrW9F0hHLfl3Lsx+uPR6HixilgM
 QtVNvwrV/6kQJC33Tf4yaUDOo00/L3upgNIU2XlGCCe9u/LCigT8tIae05G/7raDmRLylNJplos
 07lBLeqgrGlyzeyIFcDVHh/PWPZdcP/1Iipo5
X-Gm-Gg: ASbGncuGBAWwsVIC4NhemOBC+b9bUYW/7qZwG21GAITC7QLy0Coe9HZMEsT1ZQNYoxg
 x9lxx7HsgKyoMtkOFoi4Lod564Qa1fOgy708/F4x8qIRLzmieudtaKuVDmX13wzZMS4wq2SEfYs
 B/ZHakWGDXaAbFXPQYmgpS8GzXQTphaazGZd5/wlCS86xrPN/Ku/BHE1quG8kdJzjEcRWnmVTZQ
 NtJBxb4ouQU3S0=
X-Google-Smtp-Source: AGHT+IGDF7mKmjvN88Lm+ewsBm+mrimB7Kuv+QPZvwTf0E2J5vU6q6XO4sD94yYG/2Qch1s1W7K2LiS8odgz9tGp58o=
X-Received: by 2002:a17:907:3dac:b0:ade:198c:4b6f with SMTP id
 a640c23a62f3a-adfad364957mr535739566b.1.1749990295106; Sun, 15 Jun 2025
 05:24:55 -0700 (PDT)
MIME-Version: 1.0
From: Peter Robinson <pbrobinson@gmail.com>
Date: Sun, 15 Jun 2025 13:24:44 +0100
X-Gm-Features: AX0GCFtYCQAoOhqvCPWNdoA7a0aIJ7g2OLzfBGcue10n5_FK1mPHJrZFIIryzng
Message-ID: <CALeDE9M_g9JSqZLbOv3Zh-HrDnnvOw1pA8Ky7opOBbL8DTZNiw@mail.gmail.com>
Subject: [GIT PULL] rpi: updates for v2025.07-rc5
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

The following changes since commit:
d7c449c3d83a986d61e38d1762433c0607caf5c5

   Prepare v2025.07-rc4

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-raspberrypi.git
tags/rpi-2025.07-rc4

for you to fetch changes up to 0cd85170cfbe843c0927305ecabc9f772a76f58c

Updates for RPi for 2025.07-rc5:

- configs: rpi: set NR_DRAM_BANKS to 8 to accommodate RAM on 16GB models
