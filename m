Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0055EC4167B
	for <u-boot@archiver.kernel.org>; Tue,  5 Dec 2023 02:43:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68C36869F7;
	Tue,  5 Dec 2023 03:43:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="lm/EfTU4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2E8986C68; Tue,  5 Dec 2023 03:43:42 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 382FF865D0
 for <u-boot@lists.denx.de>; Tue,  5 Dec 2023 03:43:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id A7CF43F65A
 for <u-boot@lists.denx.de>; Tue,  5 Dec 2023 02:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1701744217;
 bh=FQYrvZyd80LKSAvoo+Vz+csyA5kO4SapuB9L5bFHPzE=;
 h=Content-Type:Message-ID:Date:MIME-Version:To:Cc:From:Subject;
 b=lm/EfTU4q/Vf5IHUrVtOog8Yu0r9ajBFhIBDHkRTex8Y02MT8TjSiNv9ab0MPCvkD
 xO3oMgpy+J6fr8WF4wQLPVmcy5eFOnyoavszH+bA0IJSqOcXbxdN4iESpT/JWnt+Jk
 fuN1Fled9OThwIYpeADXhaj85kKVsmal3ZhXraFsY1VC66NggAy734oCxp6Ax36W0y
 gBgptRZz/9qRC2lUZ8EhHukn68P66HCO5p3hncOfhvHAhiFJv30TaqaNcRUXY+tlcV
 6q8wETVsfXztecMMOa1bgWaT4Er6dvMOygJRY80114M8Ow7SlbbxDPgI0WJnDcwpOi
 4SthKSF9+5bTQ==
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-33342e25313so1803776f8f.3
 for <u-boot@lists.denx.de>; Mon, 04 Dec 2023 18:43:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701744217; x=1702349017;
 h=subject:from:cc:to:content-language:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FQYrvZyd80LKSAvoo+Vz+csyA5kO4SapuB9L5bFHPzE=;
 b=n91nNOmS0xm90xt1Dprvj2Ip6KLEvtiGMjH0gxGpUDH9sEnBkzEgbB6mGYeBd+Tvda
 fGM+xtc2au1p8v3G42/KFYoXXdw6tfNHY2VY3vEvtMTz2o/KYKhyhe3V7HVWbuzOcKjd
 9nqoJgJCZRPiXSP17Kr0t9NxMLIWCKUCKlTaVzvTB+cEC6V/OpG/Phf+RxughcCGaepk
 +0hzfRed8aj/8thyxoJ+bs4jrb3n2Mq0fsWk4xgEf9fWws7x2gPgkCs5/n6giAFqLHcy
 sYg2vPZg6dkGqPx2xB8U9iUSULotA6hvbiMbvN9FtfJ1jQ/W7jMYfsACtdfVI2/CRTgP
 qxmg==
X-Gm-Message-State: AOJu0YwVquvAcpapM6SlwoRQOiMU4nVQ4A+02iYYpw2lOo8uT2y5J2U1
 dA4jKB6M4J0ByuRcVbAE/nsVmEnZg1p1x+3E24qToKNPtfALTLngGhit0VhQrNLZsEWvwdSAo/M
 l2tWrLD6r0guS/kDxJrMShHCAO9hS/9M=
X-Received: by 2002:a5d:5504:0:b0:333:3be1:84f7 with SMTP id
 b4-20020a5d5504000000b003333be184f7mr2117728wrv.92.1701744217020; 
 Mon, 04 Dec 2023 18:43:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGcsLW+yBJa0IkDVAyXBRP4hhmgHVvHro3YSMsNKsOzzTIqRJfZV6UzfmFJCX3En+zZRo8FLw==
X-Received: by 2002:a5d:5504:0:b0:333:3be1:84f7 with SMTP id
 b4-20020a5d5504000000b003333be184f7mr2117720wrv.92.1701744216689; 
 Mon, 04 Dec 2023 18:43:36 -0800 (PST)
Received: from [192.168.123.94] (ip-178-202-040-247.um47.pools.vodafone-ip.de.
 [178.202.40.247]) by smtp.gmail.com with ESMTPSA id
 u13-20020a5d514d000000b0033343bb21a0sm5445891wrt.93.2023.12.04.18.43.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Dec 2023 18:43:36 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------lgq0zOVtJxGSzRhygT9zZdLL"
Message-ID: <90412dba-5f89-4cfd-aee4-05092a81e394@canonical.com>
Date: Tue, 5 Dec 2023 03:43:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US, de-DE
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <masahisa.kojima@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: Pull request efi-2024-01-rc5
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

This is a multi-part message in MIME format.
--------------lgq0zOVtJxGSzRhygT9zZdLL
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Tom,

The following changes since commit 2f0282922b2c458eea7f85c500a948a587437b63:

   Prepare v2024.01-rc4 (2023-12-04 13:46:56 -0500)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-efi.git 
tags/efi-2024-01-rc5

for you to fetch changes up to 6805b4dbad72a6e9180426c50f6db6e2681430c0:

   efi_loader: Make DisconnectController follow the EFI spec (2023-12-05 
01:38:56 +0100)

Gitlab CI did now show any issues:
https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/18800

----------------------------------------------------------------
Pull request efi-2024-01-rc5

Documentation:

* Update and correct support notes on clang
* sandbox: Fix VPL instructions

UEFI:

* Fix a bug in DisconnectController
* Provide better error messages for missing CONFIG_EFI_CAPSULE_ESL_FILE
* Create EFI memory reservations when booting via ACPI
* Make ACPI tables accessible in EFI app

----------------------------------------------------------------
Heinrich Schuchardt (1):
       efi_loader: create memory reservations in ACPI case

Ilias Apalodimas (1):
       efi_loader: Make DisconnectController follow the EFI spec

Masahisa Kojima (1):
       scripts/Makefile.lib: print error when no public key is specified

Mattijs Korpershoek (1):
       doc: sending_patches.rst: s/Superseeded/Superseded

Simon Glass (3):
       sandbox: Fix VPL instructions
       efi: Collect the ACPI tables in the app
       efi: Correct display of table GUIDs

Tom Rini (1):
       doc: clang: Update and correct support notes

  cmd/bootefi.c                   | 25 +++++++++------------
  cmd/efi_common.c                |  4 +---
  doc/arch/sandbox/sandbox.rst    | 50 
++++++++++++++++++++++++++++++++++++++---
  doc/build/clang.rst             | 22 +++++++++---------
  doc/develop/sending_patches.rst |  4 ++--
  lib/efi/efi_app.c               | 24 +++++++++++++++++---
  lib/efi_loader/Makefile         |  2 --
  lib/efi_loader/efi_boottime.c   | 27 +++++++++-------------
  scripts/Makefile.lib            |  5 +++++
  9 files changed, 106 insertions(+), 57 deletions(-)
--------------lgq0zOVtJxGSzRhygT9zZdLL
Content-Type: text/plain; charset=UTF-8; name="test.txt"
Content-Disposition: attachment; filename="test.txt"
Content-Transfer-Encoding: base64

VGhlIGZvbGxvd2luZyBjaGFuZ2VzIHNpbmNlIGNvbW1pdCAyZjAyODI5MjJiMmM0NThlZWE3
Zjg1YzUwMGE5NDhhNTg3NDM3YjYzOgoKICBQcmVwYXJlIHYyMDI0LjAxLXJjNCAoMjAyMy0x
Mi0wNCAxMzo0Njo1NiAtMDUwMCkKCmFyZSBhdmFpbGFibGUgaW4gdGhlIEdpdCByZXBvc2l0
b3J5IGF0OgoKICBodHRwczovL3NvdXJjZS5kZW54LmRlL3UtYm9vdC9jdXN0b2RpYW5zL3Ut
Ym9vdC1lZmkuZ2l0IHRhZ3MvZWZpLTIwMjQtMDEtcmM1Cgpmb3IgeW91IHRvIGZldGNoIGNo
YW5nZXMgdXAgdG8gNjgwNWI0ZGJhZDcyYTZlOTE4MDQyNmM1MGY2ZGI2ZTI2ODE0MzBjMDoK
CiAgZWZpX2xvYWRlcjogTWFrZSBEaXNjb25uZWN0Q29udHJvbGxlciBmb2xsb3cgdGhlIEVG
SSBzcGVjICgyMDIzLTEyLTA1IDAxOjM4OjU2ICswMTAwKQoKLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpQdWxsIHJl
cXVlc3QgZWZpLTIwMjQtMDEtcmM1CgpEb2N1bWVudGF0aW9uOgoKKiBVcGRhdGUgYW5kIGNv
cnJlY3Qgc3VwcG9ydCBub3RlcyBvbiBjbGFuZwoqIHNhbmRib3g6IEZpeCBWUEwgaW5zdHJ1
Y3Rpb25zCgpVRUZJOgoKKiBGaXggYSBidWcgaW4gRGlzY29ubmVjdENvbnRyb2xsZXIKKiBQ
cm92aWRlIGJldHRlciBlcnJvciBtZXNzYWdlcyBmb3IgbWlzc2luZyBDT05GSUdfRUZJX0NB
UFNVTEVfRVNMX0ZJTEUKKiBDcmVhdGUgRUZJIG1lbW9yeSByZXNlcnZhdGlvbnMgd2hlbiBi
b290aW5nIHZpYSBBQ1BJCiogTWFrZSBBQ1BJIHRhYmxlcyBhY2Nlc3NpYmxlIGluIEVGSSBh
cHAKCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0KSGVpbnJpY2ggU2NodWNoYXJkdCAoMSk6CiAgICAgIGVmaV9sb2Fk
ZXI6IGNyZWF0ZSBtZW1vcnkgcmVzZXJ2YXRpb25zIGluIEFDUEkgY2FzZQoKSWxpYXMgQXBh
bG9kaW1hcyAoMSk6CiAgICAgIGVmaV9sb2FkZXI6IE1ha2UgRGlzY29ubmVjdENvbnRyb2xs
ZXIgZm9sbG93IHRoZSBFRkkgc3BlYwoKTWFzYWhpc2EgS29qaW1hICgxKToKICAgICAgc2Ny
aXB0cy9NYWtlZmlsZS5saWI6IHByaW50IGVycm9yIHdoZW4gbm8gcHVibGljIGtleSBpcyBz
cGVjaWZpZWQKCk1hdHRpanMgS29ycGVyc2hvZWsgKDEpOgogICAgICBkb2M6IHNlbmRpbmdf
cGF0Y2hlcy5yc3Q6IHMvU3VwZXJzZWVkZWQvU3VwZXJzZWRlZAoKU2ltb24gR2xhc3MgKDMp
OgogICAgICBzYW5kYm94OiBGaXggVlBMIGluc3RydWN0aW9ucwogICAgICBlZmk6IENvbGxl
Y3QgdGhlIEFDUEkgdGFibGVzIGluIHRoZSBhcHAKICAgICAgZWZpOiBDb3JyZWN0IGRpc3Bs
YXkgb2YgdGFibGUgR1VJRHMKClRvbSBSaW5pICgxKToKICAgICAgZG9jOiBjbGFuZzogVXBk
YXRlIGFuZCBjb3JyZWN0IHN1cHBvcnQgbm90ZXMKCiBjbWQvYm9vdGVmaS5jICAgICAgICAg
ICAgICAgICAgIHwgMjUgKysrKysrKysrLS0tLS0tLS0tLS0tCiBjbWQvZWZpX2NvbW1vbi5j
ICAgICAgICAgICAgICAgIHwgIDQgKy0tLQogZG9jL2FyY2gvc2FuZGJveC9zYW5kYm94LnJz
dCAgICB8IDUwICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tCiBk
b2MvYnVpbGQvY2xhbmcucnN0ICAgICAgICAgICAgIHwgMjIgKysrKysrKysrLS0tLS0tLS0t
CiBkb2MvZGV2ZWxvcC9zZW5kaW5nX3BhdGNoZXMucnN0IHwgIDQgKystLQogbGliL2VmaS9l
ZmlfYXBwLmMgICAgICAgICAgICAgICB8IDI0ICsrKysrKysrKysrKysrKysrLS0tCiBsaWIv
ZWZpX2xvYWRlci9NYWtlZmlsZSAgICAgICAgIHwgIDIgLS0KIGxpYi9lZmlfbG9hZGVyL2Vm
aV9ib290dGltZS5jICAgfCAyNyArKysrKysrKystLS0tLS0tLS0tLS0tCiBzY3JpcHRzL01h
a2VmaWxlLmxpYiAgICAgICAgICAgIHwgIDUgKysrKysKIDkgZmlsZXMgY2hhbmdlZCwgMTA2
IGluc2VydGlvbnMoKyksIDU3IGRlbGV0aW9ucygtKQo=

--------------lgq0zOVtJxGSzRhygT9zZdLL--
