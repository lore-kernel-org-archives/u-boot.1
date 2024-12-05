Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A01ACE7716C
	for <u-boot@archiver.kernel.org>; Thu,  5 Dec 2024 10:58:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3ABD8919A;
	Thu,  5 Dec 2024 11:58:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="SpebVT2F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1742E89411; Thu,  5 Dec 2024 11:58:06 +0100 (CET)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9A2D890D5
 for <u-boot@lists.denx.de>; Thu,  5 Dec 2024 11:58:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-aa62f1d2b21so24842166b.1
 for <u-boot@lists.denx.de>; Thu, 05 Dec 2024 02:58:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733396283; x=1734001083; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TB+QQ+YtaHxivyA1YBlOLFjNOSUJmYuZKWAtGFJcA88=;
 b=SpebVT2FCo9EcMR5CerSv7WZoYxQQ4sDifdlzzqTalGv7U44YuKxeoAOBhozPNtcMA
 H5acGEem/yp+9CotPI7GPNM9cj5kEiSqJOiCllzpNEJ346/26gmE/oOZ7pN6M4iG9ipJ
 fkPnjsMxTPHdW58hOwm7Ubvpjf1aK7Dr8qMqe+v79O8CDJMlu7G0Y5+XfzuMnYDFL0Ex
 jYSiaqR+lCl9omOKObn/vWBuuJ/sYyPFD6pO3JGytMUCfZ+0fqaOw5zr6mojJym/YYtN
 aK9x1Ox+iCELtf+sz5MDZYr6DVN0C2dsmpIdCbaV74zx3O/1FsLvN3gYbOyj6h1AYp2S
 67ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733396283; x=1734001083;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TB+QQ+YtaHxivyA1YBlOLFjNOSUJmYuZKWAtGFJcA88=;
 b=wwIITSC7xTGmqC+SBIrhxk7VVZqykIp06Cj9QWfofZtSPgBXgO0pxZzNBTqk+A5N3C
 uGTV9ikyZkU4wkDfYTb4BLQwqV3OT180s3Er4XxOeVx9llaoi1XQpQ5/oqGNr88FjGaX
 OWlNDeo/FCs1KnMNAmlkp6BZGN5ckyIfuJQK/u3Z8P9ol3fe92Ad7j6sJevRKiF3g8C1
 yhRtc9TDC5m4GxvG0nL+M/kuUrMfB5zlD/Ryy2HDGFrg6OAyZJnbmo3N+LQvLwzLu8Gp
 4H/VbL1Em/DBiDDKaaJOrf8GZS/NF3pQGwB50GNH6DFv0hGCXFx5Tj4P7a1K4QiLP+Wg
 uJTA==
X-Gm-Message-State: AOJu0YykRE/u1JUSSE+oqnj7PFRXyKhtj2I3Cpp0LtgLtcaQrifhvuMF
 ntgXCxttQiUUNuN2STJj2ls32ET7NY2VSBasBkoSPc5O54KT67SlJ9Sn/J4oJR45R/iaIb3eL7p
 s
X-Gm-Gg: ASbGnctZoOIc09mQ0eNEqG3jU0kCilfA3BLPNBVjaglX/1cjysAhXklYKOTuajxx93R
 wOrTkZkECBokEfYJ2FaTNpdFUNjg002QqjMBzfQIgpuQs3hKuRpwA7Njh7k/X9DR47+/ywB5m8/
 LND8Fs8HzHo6q9XG28BD7GZhpro4Uajy6x+hApBzeE5u27kw5xaQls6Rr8EapbOJ2nKUZ/bAkuX
 O9mCA1+U0//q4dPImSYAx+AsLg3MSJNAZ8DZ5/gXjHuo3V/hSUl+Yu2ezLx29roG/yMeuOuLFFv
 mDd2TArOHiHxPqpsoWRWOvxbSZw=
X-Google-Smtp-Source: AGHT+IHtLO4JMfzplvJPYraND7DnbErF6JZCVIO1/1vQhRe9Yopm5GB/WIPm3e2oT61ScrhRC8+CQQ==
X-Received: by 2002:a17:906:311b:b0:a9e:b287:2813 with SMTP id
 a640c23a62f3a-aa5f7cabf18mr871767266b.5.1733396283219; 
 Thu, 05 Dec 2024 02:58:03 -0800 (PST)
Received: from localhost.localdomain (ppp176092181030.access.hol.gr.
 [176.92.181.30]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa625e5c764sm76241666b.20.2024.12.05.02.58.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 02:58:02 -0800 (PST)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: u-boot@lists.denx.de,
	trini@konsulko.com
Cc: xypron.glpk@gmx.de,
	ilias.apalodimas@linaro.org,
	sjg@chromium.org
Subject: Pull request for efi-master-05122024
Date: Thu,  5 Dec 2024 12:57:59 +0200
Message-ID: <20241205105800.1953747-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hi Tom

The following changes since commit f96e5133184aac377b54bd61f8abf78710f2ee56:

  Merge branch 'master' of https://gitlab.denx.de/u-boot/custodians/u-boot-samsung (2024-12-03 12:37:20 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-tpm/ tags/efi-master-05122024

for you to fetch changes up to 1d9aa4a283daa1e609130b5457c9857d62f1d1cb:

  lmb: Fix the allocation of overlapping memory areas with !LMB_NONE (2024-12-05 09:01:44 +0200)

The lmb patches are soaking in the mailing list for more than a week and
unfortunately haven't been reviewed. All the our sefltests pass though
and the SCT is fixed so hopefully I haven't missed anything. The change should
be harmless apart from some extra delay when someone is trying to allocate an
already allocate area with identical flags.

The CI at https://source.denx.de/u-boot/custodians/u-boot-tpm/-/pipelines/23719
looks fine. Please pull!

/Ilias

----------------------------------------------------------------
Two fixes for the EFI subsystem coming via the TPM tree as agreed by Heinrich

The LMB patch fixes a failure in SystemReady testing. Nothing bad happens
without the patch in the device operation, but the return values are wrong
and SCT tests fail for MemoryAllocationServicesTest category.

The second is a shielding the device against mistakes in the definition of
struct members needed by the capsule update mechanism. Instead of crashing,
print a human readable message of what's wrong.

----------------------------------------------------------------
Ilias Apalodimas (2):
      efi_loader: Check for a valid fw_name before auto generating GUIDs
      lmb: Fix the allocation of overlapping memory areas with !LMB_NONE

 lib/efi_loader/efi_firmware.c |  4 ++++
 lib/lmb.c                     |  9 ---------
 test/lib/lmb.c                | 22 +++++++++++++++++++++-
 3 files changed, 25 insertions(+), 10 deletions(-)
