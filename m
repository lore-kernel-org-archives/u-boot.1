Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B86AC54E67
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 10:17:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1512C88094;
	Thu, 28 Mar 2024 11:17:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="X7OGbfNb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3EDF08811C; Thu, 28 Mar 2024 11:17:09 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15E7E87DE6
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 11:17:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id E0A8C3FB79
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 10:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1711621018;
 bh=S89lXJ+y4JHe2jhuQFI0bVygTF9EAOGNoaGktUKF/gg=;
 h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type;
 b=X7OGbfNb3XgpR+jLz1R772C40D7hbQK8NqZQdykEsgnfcbFDS4USSSRzbjimHAeMw
 mKwp0Ta0s+cQwfqK/lu0v7hK1S10C3nDAdLfgEY9dLS++vmIpf4gqJglgL6+xk08EK
 PCMu7q6z5+OdWTCHXonDas23PuTcs2/fCdSyp/SoEjQb+0YvkBCE58ovlEoHo5r1YZ
 fPf2RLLzeekFZStH1qJqoKtAPLk+d+/aRu2oa3/qZa3naJ8YmKfL3vLoFoIX/hlTAI
 L7MpJgYd3J8CWFqC3Qi3RNvPToDlaE3fYu7lt7yVXDMC4vfYBZjL182mioOoesT7aS
 VjADajdLt7fvA==
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3418412a734so448619f8f.0
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 03:16:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711621018; x=1712225818;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=S89lXJ+y4JHe2jhuQFI0bVygTF9EAOGNoaGktUKF/gg=;
 b=Uf1uhtERUkqISqk/90f7kVD+an2ih+zCHgVE41Q0w2gqn3gyVZi7F7U+J5gkPVhNLR
 y2jQqRJLKLQRtOtm30YYprjCvNd4yx6j/0wd+WRn+mkcXY8vzbOA8V6PiQyXuR8ZDbxf
 wqnJBvg4Uu0NkkKEYi87XwrOLHLnUhRpdmgZO76R3BlGvV22sbmRrX3RBf522tv4SHxw
 pWBN9rldKkuTJJYV0imEQatlp5jTAusRaZopAZD7NpHkXwtPQBCuMfG4QIJ+xx+Gxq2u
 Z3q4Sv6/AGTZnx2uDJCS98lw+2CkgBV5UInPzcnujM98Hq/+AP77+jUaxlirV11SiW7v
 mgPw==
X-Gm-Message-State: AOJu0Yxzk8ep1JgfkV+HsFFxUGot65oGcRXPAvHvx2aYjC6VlDGXAdr1
 xM9RfGJ95ojreTsSTfT0iDjsoQnJ5Z+EdUc2n7TkJ45zuxR9a6xxx8Qedpd2PSsGEC21dijvKsW
 xuza0EM2z2CHm4P4LvaJUIprjHpX4cTG+4BywABxI+iyZ7x6+kxLqwQfNkOHnK/GopJBilJgzEu
 0=
X-Received: by 2002:a5d:4903:0:b0:33d:b2d6:b3a6 with SMTP id
 x3-20020a5d4903000000b0033db2d6b3a6mr1836742wrq.48.1711621018476; 
 Thu, 28 Mar 2024 03:16:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+pm51e8ZgvF5GmWx5dd/h1IlHJkXSWXvHvo/cG1TavVa4hG3MtJ5tW2Gg+ETjOrQzg+lSwg==
X-Received: by 2002:a5d:4903:0:b0:33d:b2d6:b3a6 with SMTP id
 x3-20020a5d4903000000b0033db2d6b3a6mr1836725wrq.48.1711621018025; 
 Thu, 28 Mar 2024 03:16:58 -0700 (PDT)
Received: from [192.168.123.126]
 (ip-062-143-245-032.um16.pools.vodafone-ip.de. [62.143.245.32])
 by smtp.gmail.com with ESMTPSA id
 v28-20020a5d591c000000b00341d4722a9asm1356809wrd.21.2024.03.28.03.16.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Mar 2024 03:16:57 -0700 (PDT)
Message-ID: <e2c1b7e5-ee38-4427-ab03-48a68d41b044@canonical.com>
Date: Thu, 28 Mar 2024 11:16:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [NEXT] Pull request acpi-next-20240328
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Dear Tom,

The following changes since commit ab8d9ca3044acf51d8ff3bf3c4718c48f30ad606:

   Merge tag 'v2024.04-rc5' into next (2024-03-25 22:15:47 -0400)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-efi.git 
tags/acpi-next-20240328

for you to fetch changes up to 6eca28b61af1835e70a6feb86f86a0b18b1708c6:

   smbios: fill wake-up type (2024-03-27 09:23:30 +0100)

Gitlab CI showed no issues:
https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/20081

----------------------------------------------------------------
Pull request acpi-next-20240328

ACPI:

* rename fields rename aslc_id, aslc_revision to match ACPI specification
* remove duplicate declaration of acpi_fill_header()
* document fields of HETP table
* MAINTAINERS: add include/acpi/ to ACPI

SMBIOS:

* provide wake-up type in SMBIOS table
* display wake-up type in smbios command

----------------------------------------------------------------
Heinrich Schuchardt (6):
       acpi: rename aslc_id, aslc_revision
       MAINTAINERS: add include/acpi/ to ACPI
       acpi: document HETP table
       acpi: remove duplicate declaration of acpi_fill_header()
       cmd: smbios: type 1 wake-up time, family
       smbios: fill wake-up type

  MAINTAINERS               |  1 +
  arch/x86/lib/acpi_nhlt.c  |  2 +-
  arch/x86/lib/acpi_table.c |  8 ++--
  cmd/acpi.c                |  2 +-
  cmd/smbios.c              | 25 ++++++++++++-
  include/acpi/acpi_table.h | 95 
++++++++++++++++++++++++++++++-----------------
  include/smbios.h          | 27 ++++++++++++++
  lib/acpi/acpi_table.c     |  4 +-
  lib/acpi/ssdt.c           |  2 +-
  lib/smbios.c              |  1 +
  test/dm/acpi.c            |  6 +--
  11 files changed, 124 insertions(+), 49 deletions(-)
