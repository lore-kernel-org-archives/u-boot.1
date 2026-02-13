Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4097EF99E2
	for <u-boot@archiver.kernel.org>; Fri, 13 Feb 2026 22:53:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D94B783AA9;
	Fri, 13 Feb 2026 23:53:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="e/rrTjwQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AFDDD83AAB; Fri, 13 Feb 2026 23:53:13 +0100 (CET)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 963E783015
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 23:53:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-895341058b1so18970356d6.3
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 14:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771023190; x=1771627990; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=y2vgbbYNxb1YE5Afaqb43J+kLQpyTfQKmkxu81ZpN4A=;
 b=e/rrTjwQgWCsT2KYpOFzn4s9GAYh1Se9MSL+8VtvIApPG/I1lQg7YEEDJi3589Vid7
 9vPAW8J+pi94N2jy6TVTLIGHw4PIusIo26f2U+p9cg5d6ZJZCsjnQsbqe8YkNIikp5p6
 feeC3Hsz965BECLJ9Uf3n21G4KZJbtssXxHZm6nqPxFTOe6GsRnFuAjF3VrptZb6g4wq
 32HttDzGgSAE6H1VoLqpBVQiy8rSDK8/opvVWQ0yLdhFx9B4vk6BrBsjwZlTyu6vsIeO
 pNyjsEMcDa8rDJzTsvhsLIomXlpUbwyV0Mpm8Hyu5HhMs449uu5eqo2dnXOdtai/JvH0
 wgvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771023190; x=1771627990;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y2vgbbYNxb1YE5Afaqb43J+kLQpyTfQKmkxu81ZpN4A=;
 b=c51WiWoENoestZHZh/scuC6dIO3ZXQk8VM3k1hjTXwwN+peQgpykazGrBBO1stMgao
 TOEGQ9DzHu/v/y+eNcuhYO3P65I26i3UnCjpAsUhiqlIUV/LkcnHAwDLtL6D6bxf2rP3
 LuiTrP4RGzAKRkXXqBfjAwOCMjrcs3LbM7FPLlBlcsd5th9VUkzK9jHD+2CkibGdksr6
 HXuMzxKYxQnMKxJLHVzZA+w0MLqsnD2rwTMX0+rR/ieJC2gJJueGR4DJZ+mupqkmzQbD
 0KynIzhksJVgK7iCM+uXdAG/Tjb2xB9mXcd23C1Abs32jH+ZrMOAKdHxaWQ2ZD7StSDo
 j7HQ==
X-Gm-Message-State: AOJu0YxWtyMzhRy2WgjkXbn4byqKYWFzyUzvxVmys0gf3Mp6mNI1N7iw
 B0cSQt4omP5h0ef+Seqe0j3losXVbnNVui/p3omQUEM7scnDOXEbwmS4L4EQ9Q==
X-Gm-Gg: AZuq6aLcJdVmDH+6rkGT/eekPBT3NW2TaNERDqTMu4we9qHVuQqPo4AnTdh8MrhlL6d
 9MvKoBv08DdlskZMC1q0ohBKVO3hL3m19Zf+iC7wB+nQcooX+eBdxnwWG8hkVgNhvKtPvrE/rgW
 QLG2b66olEIATeQwkcF5+li+DgWY9xU9WcmpeoFHa4gyevY1bzDIwE4/jD0itrxO6zz2bJVnbjV
 QGM0wtG2TfywOKkxE8zROMfdzYVj5MZruUzSI7jwZR5z2xBAWNGfpmOEAGkaa1RmKd8CEVntlN0
 xXnjsmm+XTa/5s6Nw+7oUPGhmazZenn+RTXGtHF55vR7Egi0r7DMIxhH8WEo6YFD/vxcvAUOpqK
 Pv8EaMNWtLJcAeyfhSVo8WbHNqrhFMyJMom1bc7nL7YMAeUxXk7qy3xAUBMjyLecPjgoLJGYt+4
 QobIqz14BgrtVn3YltSpwUhCWvCX7fmtTG04whOhkxk3aIJbAdfkECPZ9bPMHPUgwYxm1u1BWKD
 6DR4kMAZUE=
X-Received: by 2002:ad4:5962:0:b0:894:7e6f:f92c with SMTP id
 6a1803df08f44-897404c91a0mr17612636d6.58.1771023190269; 
 Fri, 13 Feb 2026 14:53:10 -0800 (PST)
Received: from ubuntu.localdomain (174-138-202-16.cpe.distributel.net.
 [174.138.202.16]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-506847ed9c4sm72845731cf.8.2026.02.13.14.53.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Feb 2026 14:53:10 -0800 (PST)
From: Raymond Mao <raymondmaoca@gmail.com>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@riscstar.com>,
 Raymond Mao <raymondmaoca@gmail.com>, Tom Rini <trini@konsulko.com>,
 Mark Kettenis <kettenis@openbsd.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Baocheng Su <baocheng.su@siemens.com>,
 Li Hua Qian <huaqian.li@siemens.com>, Jan Kiszka <jan.kiszka@siemens.com>,
 Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v6 0/6] Implement all missing SMBIOS types required by distro
 tooling
Date: Fri, 13 Feb 2026 17:52:45 -0500
Message-Id: <20260213225254.2544596-1-raymondmaoca@gmail.com>
X-Mailer: git-send-email 2.25.1
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

From: Raymond Mao <raymond.mao@riscstar.com>

This series finish the last missing puzzle of required SMBIOS types by:
1) Fixing duplicated handles when multiple instances exist in one type;
2) Implementing the rest of required types 9/16/17/19;
3) Adding version control when printing properties for all types.

Type 9/16/17/19 are generally DT-based, the idea is to write these tables
using a hybrid approach:
Explicit DT definitions under existing '/smbios/smbios' take precedence,
with fallback to scan and interpret values from the entire DT.

Moreover, all below APIs:
smbios_get_val_si()
smbios_get_u64_si()
smbios_add_prop_si()
are on top of sysinfo, thus allow vendors to get values from other
subsystems by implementing their own sysinfo driver if needed.

Raymond Mao (6):
  smbios: Fix duplicated smbios handles
  smbios: add support for dynamic generation of Type 9 system slot
    tables
  smbios: add support for dynamic generation of Type 16 table
  smbios: add support for dynamic generation of Type 17 table
  smbios: add support for dynamic generation of Type 19 table
  smbios: print the properties only when they exist in a specified
    version of spec

 arch/arm/dts/smbios_generic.dtsi |   12 +
 cmd/smbios.c                     |  365 +++++++++-
 drivers/sysinfo/smbios.c         |    5 +
 include/smbios.h                 |  151 ++++
 include/smbios_def.h             |  250 +++++++
 include/sysinfo.h                |    4 +
 lib/smbios.c                     | 1151 +++++++++++++++++++++++++++++-
 7 files changed, 1905 insertions(+), 33 deletions(-)

-- 
2.25.1

