Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50E3EC021A4
	for <u-boot@archiver.kernel.org>; Wed, 12 Feb 2025 11:39:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0E8F80C72;
	Wed, 12 Feb 2025 12:39:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=fiona.klute@gmx.de header.b="i1dvOdEX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B539780C6E; Wed, 12 Feb 2025 12:39:27 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1D3480BAA
 for <u-boot@lists.denx.de>; Wed, 12 Feb 2025 12:39:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fiona.klute@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1739360362; x=1739965162; i=fiona.klute@gmx.de;
 bh=8teBz8FelTJu4715Fq/LhUwirD0PxKLunnaQ4ZIxUZ4=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
 MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=i1dvOdEX8trwreMcY1XyGy2XAXovZ1TCIzxNC3iMDZEG7jNBqHEU8FTwmreXvfat
 r82qIS1+BgYUcpzd0cvxTPyKeti7Eh5maEeoAzyP73vwgFgFZzHnlDRcpIV+oEWOn
 weNzMR+oRa+FTMriMK3nT5PTl0hfrBQRP5BF/y9sX7K4LIJtpryiRtuow4s6DTnyj
 wVXzw4Z2/FSigB3ZQ67u2ghKogCTc20a3ujrwCz0FvlmnxV0NSDimyBaAYiApSwyI
 2J2ISuvrFNDN1cTbtA4rl1rCMCeoOexLxOHAryzrzuby5HiWn7zVUSPf03VEzsxc2
 MrHdHi/Ilz1Ajsu6Nw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from haruka.lan ([85.22.102.52]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MF3DM-1tbcZO3EL2-008HrY; Wed, 12
 Feb 2025 12:39:22 +0100
From: Fiona Klute <fiona.klute@gmx.de>
To: u-boot@lists.denx.de
Cc: Matthias Brugger <mbrugger@suse.com>,
 Peter Robinson <pbrobinson@gmail.com>, Tom Rini <trini@konsulko.com>,
 Fiona Klute <fiona.klute@gmx.de>
Subject: [PATCH 1/2] Raspberry Pi: Keep warnings from firmware in DT, if any
Date: Wed, 12 Feb 2025 12:39:01 +0100
Message-ID: <20250212113902.1495183-1-fiona.klute@gmx.de>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:jMAbaL60iUIh8SkyCPpx+6UlJuP0PEzODDC60JpPJATj9bRRSc5
 2GD2bb/bQ+ONXKQ25k0pV1Iq4I7wmVT2Z4U9UYiU6U9m6PDRtrn5+/E8Sxa18/07/w5Mc57
 16sZzHV4e7iMzIEPlh6uTR9ZFHFZgiCUNHqMdEIcc17F8+yH8+myc2vFnnJ1UE7EKFoFAD3
 WgMY/Ze3K+3FlbSuEa1TQ==
UI-OutboundReport: notjunk:1;M01:P0:azo6yGencX0=;RsO33kbXlaMQ1gVKpzfCBje+2fO
 V1SHzTXGsrvLUTGAR2xVSJhS2fUR1wyq6hqGUOhxD0w4sMKmooXlZ1CXsTp748Nod8ZKVRKIK
 4jy9ocWd00m5dL10G84P4a6oGC8N/4LAlpPRZesMZumhl0111tg94qVH7zflGIajUhk0QxWPH
 LpiuibS/55Uyr2uPVXZNnnLm7kcIT6T2v5lFjauwAPug6jSX9ey60ns1SWVtfKBzYyvHhBCm9
 QjNP8OgndRda75Ongt6HYHM6QhqOkFdrt9gnGtdZSes0L4KGB31HWRTTKSsBavHmfNZUVC4mo
 TDEwOYEwm0iOwCVhBhx5C555KskcfYqHLjxG3k/UCP+eaUNkcKL8fHUvFHAwATAC1KSHdnEGp
 lR5OWEXVT5QjcUPltUISh5Lav5ZTT3nJZDj/DdAos/9ez49I60G3CzZtakm619DmYKU2xEmEi
 jR+qPCJtDypFP+FctM+dXhExZOV0pOd44S5vRwneeTFeSswAiMG91ixD0Repu+zXTrAtOWs23
 zqs/9O/xoW8qaj4NXFyXCAL5I8LsyZr2/XXQM1LT8/e00Ic6qfwFRb1gAm2U9n0J7901J1mTo
 CESf4hFUU2C1+7NREMpg7M14/Pn1wy5fj4j+NbKuZexp6j5s/wL/ikzcqC5M7O11b/MU5Zv67
 6tM6t7x5ezwDOlTZeV4wXw7yNv+2ruW2VgsvVqmaBBcL5ytJ/PAUYVqpmNuMjWHm31B9NQsv9
 HB19/SIrn+tLIqmi3w3C6VseX9JEWMwEqbLkqMWRXEpjPSV0yLYMa1i3+RG9+r/XXVEHem7yd
 rU3UbUrU4FVwybOyjGubg4LGy+KYsBVrqg/i2kGRf/K67Jgr67b7XxrgvhD0WYHaJ7OwNn8WS
 fBAMy/yeM49MXtR6QEUZQv9jtiGXA2LLFUz/I41I8EjYQ5fIduM2cSGOWF3dj9kd9OkymSpPo
 ncnb1u2sw70aajveoRLxJcmb3JCAjDqsVpQqLyQPCGdLbz4AR8cT3h/atg3m9H7H7BiCuUzLV
 l7YO4qn+YvEdFHowpUzeN/ycN0ssJcvgyS9UBqYK3EmVj1QUEyJAXs+ODMMVjxgarME+AxER3
 4lRIfGVw+qW+2Ftu2SZ82QMKGckJDFdK/AhwvZ4WmcP9uVJDohrnI8BtY+59AOyohzdWGUxEl
 Fc3owWLe9I2zd8ZxiSj1G+GDqEYHfxSvG5Di7pVsXN0L4Fu0XKjBX6pOXPtuA8+RzToq+pZfu
 79DZc9yLQwBv9l1itd2wY8gVqN+3fa8tUgyqF8wkYwciiYs0dTOKxG22Wvu8wqufHbkzvAYAN
 YpdegVqivyKoA9cWnzXBcTJiy5hPlXEMHVJPbrNxEP9g5qNffR3AuMQuMXdPPl7Q23V4JiOpC
 2o2lZKSVJWP6wjeS4LtweEZwcKDW5oJk0AWQ23e/k7VhdCek4RgDUUj8T/KC+rucq2NoN1LAn
 Apgx8Rw==
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

VGhlIC9jaG9zZW4vdXNlci13YXJuaW5ncyBwcm9wZXJ0eSBpcyBjcmVhdGVkIGJ5IHRoZSBSUGkg
ZmlybXdhcmUgaWYKdGhlcmUgYXJlIHdhcm5pbmdzIHRvIHJlcG9ydCwga2VlcCBpdCB0byBtYWtl
IGRlYnVnZ2luZyBlYXNpZXIuCgpGb3IgZXhhbXBsZSwgaWYgdGhlIGZpcm13YXJlIGNvbmZpZy50
eHQgY29udGFpbnMKImR0b3ZlcmxheT1lcnJvci1leGFtcGxlIiBhbmQgdGhhdCBleGFtcGxlIHJl
ZmVyZW5jZXMgYW4gdW5kZWZpbmVkCnN5bWJvbCAiJm5vc3VjaGRldiIgdGhlIHdhcm5pbmcgY2Fu
IGJlIHJlYWQgYWZ0ZXIgYm9vdDoKCiQgY2F0IC9wcm9jL2RldmljZS10cmVlL2Nob3Nlbi91c2Vy
LXdhcm5pbmdzCmR0ZXJyb3I6IGNhbid0IGZpbmQgc3ltYm9sICdub3N1Y2hkZXYnCkZhaWxlZCB0
byByZXNvbHZlIG92ZXJsYXkgJ2Vycm9yLWV4YW1wbGUnCgpTaWduZWQtb2ZmLWJ5OiBGaW9uYSBL
bHV0ZSA8ZmlvbmEua2x1dGVAZ214LmRlPgotLS0KIGJvYXJkL3Jhc3BiZXJyeXBpL3JwaS9ycGku
YyB8IDMgKysrCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEv
Ym9hcmQvcmFzcGJlcnJ5cGkvcnBpL3JwaS5jIGIvYm9hcmQvcmFzcGJlcnJ5cGkvcnBpL3JwaS5j
CmluZGV4IDY0NzcxNjEyN2M3Li42Y2E3Y2Q3NGVmZiAxMDA2NDQKLS0tIGEvYm9hcmQvcmFzcGJl
cnJ5cGkvcnBpL3JwaS5jCisrKyBiL2JvYXJkL3Jhc3BiZXJyeXBpL3JwaS9ycGkuYwpAQCAtNjE2
LDYgKzYxNiw5IEBAIHZvaWQgIHVwZGF0ZV9mZHRfZnJvbV9mdyh2b2lkICpmZHQsIHZvaWQgKmZ3
X2ZkdCkKIAkvKiBrZXJuZWwgYWRkcmVzcyByYW5kb21pc2F0aW9uIHNlZWQgYXMgcHJvdmlkZWQg
YnkgdGhlIGZpcm13YXJlICovCiAJY29weV9wcm9wZXJ0eShmZHQsIGZ3X2ZkdCwgIi9jaG9zZW4i
LCAia2FzbHItc2VlZCIpOwogCisJLyogd2FybmluZ3MgZnJvbSB0aGUgZmlybXdhcmUgKGlmIGFu
eSkgKi8KKwljb3B5X3Byb3BlcnR5KGZkdCwgZndfZmR0LCAiL2Nob3NlbiIsICJ1c2VyLXdhcm5p
bmdzIik7CisKIAkvKiBhZGRyZXNzIG9mIHRoZSBQSFkgZGV2aWNlIGFzIHByb3ZpZGVkIGJ5IHRo
ZSBmaXJtd2FyZSAgKi8KIAljb3B5X3Byb3BlcnR5KGZkdCwgZndfZmR0LCAiZXRoZXJuZXQwL21k
aW9AZTE0L2V0aGVybmV0LXBoeUAxIiwgInJlZyIpOwogfQotLSAKMi40Ny4yCgo=
