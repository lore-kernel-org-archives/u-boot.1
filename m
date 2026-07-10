Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62116C43458
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 18:11:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7ABCE84A92;
	Fri, 10 Jul 2026 20:11:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="boM/Uts5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9838984ADD; Fri, 10 Jul 2026 15:24:20 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 037D784ABE
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 15:24:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=imullins@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783689856;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=HXNP0K0s5YjkCIWIS4agNFhbIYjeHhbMWbu0njJKxsU=;
 b=boM/Uts5dfZ/zSqBRTit9dZK6W9Bq/rLkpi0xuYJvOuFKVhaf60yJNeSvRsZT1tD/wjGWn
 Mx+hwPEhux7HoBj9Qa1xEX/btX03XDIeLnz7xYUk2WVJvVSivqoZzfMpp24KiyUsgKT4Tr
 6Q7G62mq86XwqPUgqddlLZlJqoWr+D8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-387-U1gNxWHUOS-xiMkKPwmEkA-1; Fri, 10 Jul 2026 09:24:15 -0400
X-MC-Unique: U1gNxWHUOS-xiMkKPwmEkA-1
X-Mimecast-MFC-AGG-ID: U1gNxWHUOS-xiMkKPwmEkA_1783689854
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-493c20d0468so14828965e9.1
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 06:24:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783689854; x=1784294654;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=HXNP0K0s5YjkCIWIS4agNFhbIYjeHhbMWbu0njJKxsU=;
 b=oxTVnzeeTRwlyE+Y1C4xikCxff9o1pRTEN+RR0FaDCMxeYUVTSa8Og27YA+ZiePVBo
 vUlc7krc+hONxHR+ufBS1LQgqbAdV0r8wfiuGgC/Y24LCVrueXUGCdmBoeVU6xq7gHHK
 CgmXg1vr+jk2Z3yCpvM1J4UFiCoUvjPsg9UdUPyjt/VjC2bqy3IfUJiz/P0nbEni0STS
 Ex2cxL7N7Y37qBG1wdzd8JwbNkHIPUSYZAAnYQcWRY2Ykd7FZdIRunasadr/9khBh5VI
 A2SvYxOo9yZaiUMdzo8gKaS+cn6IbubnL3EKI/cTiTGDMaVKnON3jZKFgaoQiwUfvEIF
 p5aQ==
X-Gm-Message-State: AOJu0YwULXSImUPREYubUCvZNoHHeKmEBxQ2vw5pt2xxvRUqnAmKJLGj
 A9NDY5kB8ii7u779CqrSMG/ofDBMuKr3WWKYQCpV+n/8rhCxMISKBi6ykyZTLkzjFNyoYivk4yO
 bHDVztScO87z9jRy6Xl5ky3GRgqPjOrCViugJkk/Tfzm3IKor/mHQaIA=
X-Gm-Gg: AfdE7cl61f8UOmEwmqePso6E8a5WNZSR7WTzW9M3vbhqmHn6PdHHgXw3ukNfG28BKyz
 CZ1llEigePJjMiFE1zVQ+zVInZr9l3ShPqx7d5AueaGkvkgo3iT+FCWRlFdtRlDOm3MFUoJoIBg
 tY2kWK55fL78FXmeGUOBhnpMBXTbbaaWQqbTRykUS+trtvT2JRiEhZxSz+6TkPadOaRjEaUe/ZH
 GoRgoSFej+P1Z3L5wJxd4QiFbS4u0uLrSgzOocmoOOXgnW3/7QgY5ZhfprkIETKNK4BNUp0klPU
 8YYPYSKzzy1fBSMe84y2813FJGnNnlzsNNC6T5Tj1SeHy016TkralvchMnrIc5kS4u7XcHd1XT4
 JOk0IG6j3/7NafnrINJvzpANySzTz+b7MPKXmMzikTQ==
X-Received: by 2002:a05:600c:828a:b0:493:efb8:6726 with SMTP id
 5b1f17b1804b1-493f11edf48mr46925465e9.15.1783689854294; 
 Fri, 10 Jul 2026 06:24:14 -0700 (PDT)
X-Received: by 2002:a05:600c:828a:b0:493:efb8:6726 with SMTP id
 5b1f17b1804b1-493f11edf48mr46925025e9.15.1783689853865; 
 Fri, 10 Jul 2026 06:24:13 -0700 (PDT)
Received: from [192.168.68.133] (33b7f9ad.skybroadband.com. [51.183.249.173])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493f2e77c2esm41527715e9.2.2026.07.10.06.24.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 06:24:13 -0700 (PDT)
From: Ian Mullins <imullins@redhat.com>
Subject: [PATCH 0/2] efi: Implement EFI Security Architecture protocols
Date: Fri, 10 Jul 2026 14:23:07 +0100
Message-Id: <20260710-efi_security_protocol-v1-0-a06cef90057b@redhat.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIADzyUGoC/x2MWwqAIBAArxL7naARva4SEWZrLYTGWlFId0/6H
 JiZCAGZMECXRWC8KJB3CVSegVm1W1DQnBgKWVSyVlKgpTGgOZmOZ9zZH974TVRTayeJzaxLBan
 dOXn3/+2H9/0AZ0h8pmcAAAA=
X-Change-ID: 20260710-efi_security_protocol-6b9fb0e8da41
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Ian Mullins <imullins@redhat.com>, 
 Enric Balletbo i Serra <eballetbo@kernel.org>, 
 Enric Balletbo Serra <eballetb@redhat.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Michal Simek <michal.simek@amd.com>, 
 =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
 Simon Glass <sjg@chromium.org>, Peter Robinson <pbrobinson@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Shantur Rathore <i@shantur.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Sughosh Ganu <sughosh.ganu@arm.com>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Udit Kumar <u-kumar1@ti.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2698; i=imullins@redhat.com;
 h=from:subject:message-id; bh=gtSE3iLsDSqcoENsAD5VGFLzKeH3/OL55aLeBvwZ9qc=;
 b=owEBbQKS/ZANAwAKAdSOKmyUBwJWAcsmYgBqUPJ66YcEz202N9ENQxFf/nT4Ja0MsopjYda+4
 +IU3V18n+2JAjMEAAEKAB0WIQTdLPzJ05Wjhy4Uwd3UjipslAcCVgUCalDyegAKCRDUjipslAcC
 ViavD/98W+WkOSUb6p5yVt+QETeCIWaqKrF10frOObeHTfuN22VPvMF7qNucw7Tbma5MimFk4Cn
 0grrgFGonkEkgDmQ6QJ/wONLn48kEm2KCgxfhehAnhQKA1/bUQFPI34aqoy//m0i7UUsoTR3v/B
 Xcl6Dqm7QS+RAgMQpYsu8yb6MjD88iDWrI9kYYQG6LwH5G4MnIJVbsbyxZ0bjfqLaNYAB94Leq8
 25DSBAPOn3m1R2jyPNeJIY60ao+Zyr2c11EKiaXw6H1WcihLoJ2hsWkaqeBXgo7zT3gaJ0FObIl
 JIIo6iT4zOqEJk9CIBFKYd+gofX7DVrZuc0wrRqge7yeBiDFOFvj2HBecaV73D5RLP0hrA0d9J6
 k3cC2gRjtrW3bDrMDDwXOjRyUUSdATqZNsDYZQPBbLbHJHgdpk+63Q/km+k76x/TM409PylJSRN
 uIwhAAlKagOLdzho5p/09+8kxaTCLPMBE8X1EoUOnMChmztVGJ9IrV86Pp7N1+m9uORJpWanuyP
 YLa+r1c0H8O+0To5rkrhliacRh+jGJFYZuOc46M7IyqhxFi1zl8Xm8AAfK9KUn0rMDAGgwwSVs6
 CFdY0aOAe8hd/wbeL6i+1c7vwcJ3CQ3GivK/zTSW5enUVNDZbqeoD0rcB8/IxjkMz3UlrYJhjrG
 7u8mEVpUUcAw9oQ==
X-Developer-Key: i=imullins@redhat.com; a=openpgp;
 fpr=DD2CFCC9D395A3872E14C1DDD48E2A6C94070256
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3aHoFi8R3o2TLktdd4PIAaIp1rGMUsbGmXoH7lH9Iy4_1783689854
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Fri, 10 Jul 2026 20:11:14 +0200
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

This series implements the EFI_SECURITY_ARCH_PROTOCOL and
EFI_SECURITY2_ARCH_PROTOCOL. The primary motivation is to support EFI
applications like systemd-stub in Unified Kernel Images (UKI) so they
can temporarily override authentication for embedded payloads.

Note: This work was originally authored by Enric Balletbo i Serra. 
I am submitting it upstream on his behalf with additional testing.

---
Testing Performed

I have validated these patches across various secure boot scenarios on 
both physical hardware and emulators to ensure the new overrides work 
without regressing standard secure boot enforcement.

Hardware: Renesas R-Car S4 (EBBR UKI boot)
- [PASS] Unsigned image, Secure Boot disabled, without patch
  (Boots)
- [PASS] Unsigned image, Secure Boot compiled (not enforcing),
  without patch (Boots)
- [PASS] Signed image, Secure Boot enforcing, without patch
  (Fails to boot as expected)
- [PASS] Signed image, Secure Boot enforcing, with patch
  (Boots successfully)
- [PASS] Signed image (wrong keys), Secure Boot enforcing, with patch
  (Fails to boot as expected)

Emulator: QEMU (qemu UKI boot)
- [PASS] Unsigned image, Secure Boot disabled, without patch
  (Boots)
- [PASS] Unsigned image, Secure Boot enabled, without patch
  (Boots)
- [PASS] Signed image, Secure Boot enabled, without patch
  (Fails to boot as expected)
- [PASS] Signed image, Secure Boot enabled, with patch
  (Boots successfully)

Signed-off-by: Ian Mullins <imullins@redhat.com>

---
Enric Balletbo i Serra (2):
      efi_loader: implement EFI Security Architecture protocols
      efi_selftest: add tests for security architecture protocols

 include/efi_api.h                                  |  30 +++
 include/efi_loader.h                               |  15 +-
 lib/efi_loader/Kconfig                             |  11 ++
 lib/efi_loader/Makefile                            |   1 +
 lib/efi_loader/efi_boottime.c                      |   3 +-
 lib/efi_loader/efi_image_loader.c                  |  31 ++-
 lib/efi_loader/efi_security.c                      |  99 ++++++++++
 lib/efi_loader/efi_setup.c                         |   7 +
 lib/efi_selftest/Makefile                          |   1 +
 lib/efi_selftest/efi_selftest_security_arch.c      | 110 +++++++++++
 .../py/tests/test_efi_secboot/README.security_arch | 208 +++++++++++++++++++++
 .../tests/test_efi_secboot/test_security_arch.py   |  73 ++++++++
 12 files changed, 580 insertions(+), 9 deletions(-)
---
base-commit: 913fedc816570c07bfc7f9c4046dc2a3a55e4099
change-id: 20260710-efi_security_protocol-6b9fb0e8da41

Best regards,
-- 
Ian Mullins <imullins@redhat.com>

