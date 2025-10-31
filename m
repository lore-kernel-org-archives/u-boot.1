Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E92FCCF9EE
	for <u-boot@archiver.kernel.org>; Fri, 31 Oct 2025 04:10:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DAA4383642;
	Fri, 31 Oct 2025 05:10:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GbKPn3Lm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 04AD083887; Fri, 31 Oct 2025 05:10:51 +0100 (CET)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB99C8331F
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 05:10:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7c53f916ef1so634329a34.1
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 21:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761883847; x=1762488647; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gmVPUJW11LjCrF8G8HDcsry37awCC1dZ/wEVNJAywg0=;
 b=GbKPn3LmOmidN0DitCEIRTtcGH2xs5B/8qor0UfhM/IhKZ5us8nVNzNDTL2FFc0LPm
 Rx2kv1WifcysaKIQMENYmaRqr3AMTRV6z2n08cJEg3kteQmh3fRe811QnpbWYh2koFzV
 pHGZxZWdTM0/6TDggqKT5zrUU9tP2izU1Q9tF7vDtEsKzDa9rt4Ys40XUtzQYWw4IEoL
 GNMjH8eMamke2HLkyuXu9HKoArBrdu4bVVCS8P6MWYD+diGkBr3BdGpydZFDqQsk/3QH
 gec5iR8YmthORqpLfTlNnoFZhJoqxtAZt/ZObt4CiHJ/bQ6stCDIB0OPlLOrX3ycZcMu
 yz5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761883847; x=1762488647;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gmVPUJW11LjCrF8G8HDcsry37awCC1dZ/wEVNJAywg0=;
 b=YYMD2O/a1pJ1g9RHwkFRBRxk6gx5IIeQQZ6l4Iwsx1V1U70yeyKKbBoK1h4EFDOStS
 2bnzNzhNkKiUXP2h5H8C+mY9gzf7NyxUzkRG4lt3CgTSt8xiG2eGaHVRPve8nz4JmB71
 AojJR4G3Ur8WTtDR9pt/2ppgXVOprOdRaXpP2oeEKci5XHjYoBIWcNCOhjxaYy2ZgqqO
 egN3zyqLa17XL8woiL+JXbrEaH8/McresrdOvfkH83Z257n0na8C+SIF93+HxZOYMHeL
 55R6gyfFqHDQEMBnrRpsTpZRQ+GKEW1KLed/aS8d1swh6Uo+kCHpB06g1wIifWHJ9iuV
 kb2Q==
X-Gm-Message-State: AOJu0Yy9Reow5R8pLaC6OTGuQNqAS2dPmul7bppvG/X/N7+0u+oDeErS
 IZXDr6Pax2JACNe+OZs+f6UnXsuwCpOH3fexXLbLu7ulhY4uIjzx+uISdTWNFcHxCJ0A/YJxOnC
 6l9g4eOu6BJHejF9+bb9NVoAKjrXDj4Pgg44N
X-Gm-Gg: ASbGncvmJ7R8hl00Df1s94qR2hlXgFiMce7gDHHFaCgWheVwl4qubJIHIUEALvq9k0v
 I/r6YJ1ueiQu6ilN3lmXoG6bfjzY+y6FRy6c4F6pcPZHzrEhHxZe/D/mtj3wo2FM11PGVdNK4XP
 XQHH38CFDmBp7T/qxSlPQhuuWZeJ4KvZdnrvApjUqPn5bIMCPYQmVD3h4wM7aJ8kG9O00UzcQ8z
 S4jX1OYuqwz+FLg1u2QF0jB8T+2QMMk7VGx3yVmvVMjo3vEAkTh5Yb5mP79
X-Google-Smtp-Source: AGHT+IGART6Y1wQXOngGjcfjJ4Pp9rl5OGctyiRe8wmTtoW17mhtIykQi+U83Y3KKhS4vZ7meX/s5f/8cgp2a9Xn0/I=
X-Received: by 2002:a05:6808:4482:b0:44d:a58c:1966 with SMTP id
 5614622812f47-44f95f91ac9mr1021757b6e.56.1761883847413; Thu, 30 Oct 2025
 21:10:47 -0700 (PDT)
MIME-Version: 1.0
From: Sune Brian <briansune@gmail.com>
Date: Fri, 31 Oct 2025 12:10:36 +0800
X-Gm-Features: AWmQ_bnxBpqHEovP91GlLPtNaFYTGguuN86Pj9nZZPmtUTUZHSpX-VPmJgDf7Xs
Message-ID: <CAN7C2SArdbhag_56MwOMGoaEYSLiHbHHo3KFhUS5U03ntEJbGA@mail.gmail.com>
Subject: [DEBUG] rk3399-nanopi-neo4: SPL SD init may report -5 due to SD
 power-on timing
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
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

Hello U-Boot maintainers,

While testing mainline U-Boot (v2026.01-rc1-00070-ge34d01d23e45) on the
FriendlyARM NanoPi NEO4 (RK3399), I observed that SPL sometimes fails to
initialize the SD card with the following message:

    spl: mmc init failed with error: -5
    SPL: failed to boot from all boot devices

After investigation, the root cause appears to be related to the **SD card
power rail (`vcc3v0_sd`) timing during SPL startup**. On the NanoPi NEO4,
the SD slot is powered via GPIO0_A1 to a fixed 3.0=E2=80=AFV supply. SPL ma=
y attempt
MMC initialization **before this supply has fully stabilized**, resulting i=
n
a generic I/O error (`-5`). The SD card itself and the controller are
functioning correctly once the supply is stable.

**Workarounds / fixes observed:**
- Add a small delay after enabling `vcc3v0_sd` before SPL starts MMC init.
- Ensure the regulator is fully powered and stable at SPL start.

This appears to be a **hardware/platform-specific power-on timing issue**
rather than a device tree or software bug, but documenting it would help
users encountering similar errors on the NanoPi NEO4.

**Hardware:** FriendlyARM NanoPi NEO4
**SoC:** Rockchip RK3399
**U-Boot version:** v2026.01-rc1-00070-ge34d01d23e45
**Reproducibility:** 100% with SD boot

Best regards,
Brian
