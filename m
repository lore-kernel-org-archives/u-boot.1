Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41719D116F1
	for <u-boot@archiver.kernel.org>; Fri, 28 Nov 2025 14:07:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2E7484575;
	Fri, 28 Nov 2025 15:07:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YhaCAGSP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1DD784577; Fri, 28 Nov 2025 15:07:11 +0100 (CET)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B06FA84565
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 15:07:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-63c489f1e6cso2876583a12.1
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 06:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764338829; x=1764943629; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=yDMCIquly7j3icU8cMz2kaajCw9YEZVuoJwUbGgSxPY=;
 b=YhaCAGSP7Z+iG0slCMGVLwM/cDDEQycNsur8nG/S2Os9Y+m94l3SO+0TLnmkP1wrrp
 ZMzNUop8Me1/UKOnMFGb0mxNS7p3rMtXtdQd93N6b1UBvtM5ds0xpNxLmkwY7Fz3tY9a
 ZSXy3bOh+0Q6FFU4cyRXNnHQLMjpCr3oVebVoxa5lA+G6QzCD6rFF2AmFZYi8hrROaLt
 4RHBQOtxq8ayWm4it5aNsn1Tk9svoYz1ZZ2BNYBwqvEFUYZnEBCjlolMXq8uSr98Whhi
 emfuA1epwJMBBAmU39D+lzQecCKxTH4pZSAC2D8XpribnHRBZlyiQaABzeLbM/wEoVv3
 ZL/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764338829; x=1764943629;
 h=to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yDMCIquly7j3icU8cMz2kaajCw9YEZVuoJwUbGgSxPY=;
 b=lEznE5XkChD3ThZ0dz+z1zHMmikZOuu0xhjFZmsWa3Fg/gkLXuG2uF9I+NUZDGld6R
 Pv6L7eLVjVlwmVsIjNFaXNGIf7G0hI7H3AdqSKtS4U7i0oRjrSAANglr6J84SFQeuyGh
 /STG/UGv8xMADfEUjY4opxnha4o8Fl0IBuEEGG236UaAWgKWcOrfnR9cJ0chUrbrxwon
 BatCN1yli2sHpwFFsQF3AKSTNPHa8PrG5GrNefs9ikWpAImuzTcbWdQpfrHCTN2sCypq
 /qQz0vrMiUVWtop45xyfMwhouPczVOQFqKoQlAdOKI2DCqhXkcuJKZyHj721ceFm0DCc
 tNbg==
X-Gm-Message-State: AOJu0YxWamcPGi8rMORPi4SQT3suoQAnEuNBsgFLQrJ7/ugzjxfy5BhM
 Z1nae0D0bLWl45WUyD9KBjCITuuAKBrxxsEQKpIRz+zuZOA+whu53h4L4OnGL89cDvlU7encYMR
 wWMc2HirAQzWUVbs65mrNXw+zFBscGk1NH1nM
X-Gm-Gg: ASbGncsAfMSWY/CEh338AbzUiaFQx9TnyM3S95I863SJrWPvLX0ZW8I2lYOhsRiK7Ou
 BjW/sqQt90TVuTRhrhT4jrNhWzNGBp3fwSuvlrsKHijGaJVdK0GMr6p2RjZbLcKi1tS9my9kNsj
 +UsqYog2F//L7Y7+YaE3QuDuFWX/eQ0otILn52/NRz4AaboXYchaBjV4GmOcx9ooStKQlowVP9r
 uZLRW7qnsNR8cAGSXNlNCgnkRQtYbBEQpFT9JvNrAnfV2SC8ijYPO34ySo02E7PYzSLMXEMl5Aq
 75tlK4+ESKfkOsEp2nF1/UTmbiiD3JT0VWr5cZ51rsMUkXms1ItGTLgC3ANzrR1u23Ws8m02sel
 FqFo1ckAl8Cw0q309W5JW6dimOP5gArKQm4A2YJdeW8HwAo0Vl+HaFqXcUbzi7bP9
X-Google-Smtp-Source: AGHT+IE2MMaNVsnet4/4n/KlC6g8dNKy+IUSRk0ZN43x2T6zzCkmUeDE9xTYf8V2inc6qMTxca+rl6u/OZEXZBXqdEI=
X-Received: by 2002:a05:6402:1462:b0:640:b625:b920 with SMTP id
 4fb4d7f45d1cf-6455508090amr27313005a12.6.1764338828920; Fri, 28 Nov 2025
 06:07:08 -0800 (PST)
MIME-Version: 1.0
From: Peter Robinson <pbrobinson@gmail.com>
Date: Fri, 28 Nov 2025 14:06:57 +0000
X-Gm-Features: AWmQ_bnZLI826dbecTzizzNVhM8oCRBHXPWqRVA9t6hFehM3GNvKfihWk1ZPlgw
Message-ID: <CALeDE9MjchwyyuRahALK9EU=ie1BuAhBgP2M=hXt4LAmYBo3Rw@mail.gmail.com>
Subject: Pull request: rpi-2026.01
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, mbrugger@suse.com
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

Updates for RPi for 2026.01:
- rpi: Fix DRAM size reporting to show total RAM
- rpi: Use the U-Boot control FDT for fdt_addr
- pinctrl: bcm283x: Add GPIO pull-up/down control for BCM2835 and BCM2711
- rpi: Fix compilation with larger configs

The following changes since commit
c5e6d2ab7eba68cbfb600cdc131c0c375ced2ec9

https://source.denx.de/u-boot/custodians/u-boot-raspberrypi.git
tags/rpi-2026.01-rc3
