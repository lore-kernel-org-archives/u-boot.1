Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 192E8E668B9
	for <u-boot@archiver.kernel.org>; Sun, 24 Nov 2024 15:34:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1AA1289046;
	Sun, 24 Nov 2024 16:34:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="t0melT57";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E454891A8; Sun, 24 Nov 2024 16:34:25 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EFCF789040
 for <u-boot@lists.denx.de>; Sun, 24 Nov 2024 16:34:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1732462461; x=1733067261; i=xypron.glpk@gmx.de;
 bh=O7wl/YoEmvSYSHC3kLWlxqywB01Ki3nUtT8P8oMmHTo=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
 Subject:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=t0melT57KLhKC6k/7LkqP8qH8R7+rZ/aKmYxT1EsDbSVtBBlKs9NiZT4nDG57ZEy
 2FczEy79IORIowJQ8LkFodGT1dkJFFuu5BuebAWxoNHD12A+WrZb2BcEbNGHSQDev
 2F4C84p4ZdarkwEvOrQgMyYywOsyZgqFun0YQT9iAMiuxMqrbMA+UB1bCcciR7GcV
 TIpcLHw6zFUl69XtZ4jTAxpTSW3LH9ea0khFoEmV+zHqhcLaMpi0qCYjC8hcJckms
 im2HBOeCxV/PXXOUboOVebVvAISqsDjWTDa6+ccv3dsIk0g03D8ey1G8dssXZ2ipE
 HDZiHZnk7IaTVbZzgg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([5.147.80.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M1ps8-1tHRY449X6-003dHb; Sun, 24
 Nov 2024 16:34:21 +0100
Message-ID: <ce72d064-807a-47a6-abb8-e9110c63b739@gmx.de>
Date: Sun, 24 Nov 2024 16:34:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [MASTER] Pull request efi-2025-01-rc3
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:i8th8YCJqBY9l0v5M5EBTFMxEFhAMdDgg6biJrvTcGaVtJjU7jw
 yThobwtdH27A+GKSzwLapXGtSnFZvvAc2NVBaWhVTmdmd7dZ8XxddChiK911cbmMJrE9F1e
 6ehiSnAMMUsKS77QH9PQdXxGjzUB+7drQamqyjKbdzVH1XrFpiqMaFYX/4oh/TbGnF6cDUx
 3FFcdrwuoFMkU78SGlUcA==
UI-OutboundReport: notjunk:1;M01:P0:VpbrNIMDvJE=;vU7fSUO6uPBjoVEkmrGMXNm1Cun
 cAXJHqlG36+VbMcKnpl3jxPbFPAxTbSww2LaqqtiMWZzM2ZfY5+x3OepZ5gUC6AQihfn1TY1y
 pZIVE2smbZwkyaf2wtv8uWNeMXoRZaxQajtjeQGO2byq+IV727hCkk4ZFb4SKTQMQuPEoyg3h
 p6KepY3fSLcPwbY9mNBl7EUJ8rfU54FKCI/BBkKcEvDsyr4ggKkEGUp1JHyg1+C4wyTJRO6HW
 chWThsPxSVXzuTwUjaYLrEKq2XYQfp7CWCMnkXdaX7jt1nJHK6Bfjez8EkFiRbB+spnBDWuYb
 IjHUGmhnNFAb8Mxz1/0RGWSplkI5LJWxSivkl1kL4flnNg5MUs0+tK3fKMgd5AonMjGpy2Nhj
 h8K8kX63jhxOICwaN5VtFQJucPxtqyrpt188r7MoL3AX2dmIsHnxucqKge1MtbqFTEPoAIobp
 grdOj5Wjv7S71eBH7GwP+coT5zInyqYBrWKpy3uYEVAUGxmqAjmkpg05Bnt/odfOSgI9CZM/d
 BzJW25K/RY4DXlqEGxAQgQ2LgNGyKJv+tY63YYcN4ctoGYKB0kqGiiIVI9znBZ/7K18Zw68cr
 NJAGtGH+qEpvVcZZ9aplaj37767hUNu7h5OBRs5cnqgEZ11U2DYXB5FLpOC5sOaEqp/mb0erg
 pccUhw9o7rL+/0ULRoeC6W30VlzYrDEPsgaR98O2nvWphHsv7NfzH7oN/OaHYAYRgNVRnem13
 VuvDDuhEtN6+T+Vo2fd8iQw1Eq8WgRL9BAiwx4q3OEmQ2xmIQLV9qAdlWV2Z8OtpDwIizmHNz
 tbQTkSMNTGPWkDUrpO89xVwNhkX6FwGYqBFEup0MskDf0jCBAqj/zY214hYq1k0ROiwrlCwzr
 +SLC5wUjxkaLXCsBzYr4ctaFq0VgnmnaEQYLLQY2JyX8hWw1Vg+EBfS4Ocuy4wH/C6kHPrjui
 zTys/u7bCWukZj7cLSyLX6UhyP1f4Sxjd8GC8FjNanuyGOPXp+HohUAduJJ0znL4AAFDEi0pv
 zqhf0cNsAf4c7jU97tlMrf0+tMvGPeibgUSzMSbCwLZHgS3clcq9i4vtrp5n34o1oFxUDONQm
 lTNICVdlI3K5hnt/p5WUrC+pjZbhut
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

The following changes since commit 52c0e5f8a39ef022ee5ab2dfd67661d1d34941c=
7:

   Merge branch '2024-11-22-assorted-fixes' (2024-11-22 15:04:54 -0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-efi.git
tags/efi-2025-01-rc3

for you to fetch changes up to 967d57ab592ce1bcab0785f8483b1b43c2d881aa:

   lmb: Correctly unmap and free memory on errors (2024-11-24 15:25:03
+0100)

Gitlab CI showed no issues:
https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/23529

=2D---------------------------------------------------------------
Pull request efi-2025-01-rc3

Documentation:

* document wget syntax enhancements with lwIP network stack
* move README.kconfig to HTML documentation
* remove redundant README.TPL

UEFI:

* simplify efi_tcg2_hash_log_extend_event()
* allow EFI_LOADER_BOUNCE_BUFFER on all architectures
* correctly unmap and free memory on errors

Other:

* enable EFI_LOADER_BOUNCE_BUFFER on StarFive VisionFive 2

=2D---------------------------------------------------------------
Heinrich Schuchardt (5):
       efi_loader: simplify efi_tcg2_hash_log_extend_event()
       doc: move README.kconfig to HTML documentation
       doc: remove README.TPL
       efi_loader: allow EFI_LOADER_BOUNCE_BUFFER on all architectures
       configs: JH7110: enable EFI_LOADER_BOUNCE_BUFFER

Ilias Apalodimas (1):
       lmb: Correctly unmap and free memory on errors

Jerome Forissier (1):
       doc: cmd: wget: document lwIP syntax

  configs/starfive_visionfive2_defconfig      |   1 +
  doc/README.TPL                              |  49 -----------
  doc/develop/index.rst                       |   1 +
  doc/{README.kconfig =3D> develop/kconfig.rst} | 124
+++++++++++++++-------------
  doc/usage/cmd/wget.rst                      |  76 ++++++++++++++---
  lib/efi_loader/Kconfig                      |   1 -
  lib/efi_loader/efi_memory.c                 |  15 ++--
  lib/efi_loader/efi_tcg2.c                   |   5 +-
  8 files changed, 143 insertions(+), 129 deletions(-)
  delete mode 100644 doc/README.TPL
  rename doc/{README.kconfig =3D> develop/kconfig.rst} (54%)
