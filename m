Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1002FEFB4D
	for <u-boot@archiver.kernel.org>; Fri, 27 Feb 2026 13:19:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BED7E83D1A;
	Fri, 27 Feb 2026 14:19:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="V2rycoxx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6491083CDF; Fri, 27 Feb 2026 14:19:33 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 204BB83AA9
 for <u-boot@lists.denx.de>; Fri, 27 Feb 2026 14:19:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1772198369; x=1772803169; i=xypron.glpk@gmx.de;
 bh=Is8bNsNJDP4LUIjz2ODX9Kea+sq+kqN53ztGjBCaFxo=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
 Subject:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=V2rycoxxXKrxHWlyLQuS+tfYBpdo+LzPwFuk8RvCvCYXWMIMIyaDxXwTRvXDKFW0
 rslhpq7INT/PAxZsXRwBm0ZkbxWi1jvDeS1g3CPP71tbDH2vsGMEd3w+urkGvS/Ei
 3hFHkMZKT4HwmyW85gGrG5TRNeZyE4+DQMr3ZvI32T9K/OhMbP7+F4/u+YQrB0egV
 YTRwAyhJqNYHq3qJVfcNqC6YRpP71830shTdexNbLt1evYdx9Rc6uwSz9ZDgaLjkO
 hnGvlejPgkBFTi7BzE+9VkJr3Q8V8AYNAbr3lkpQETdJ2OLaHn3JhnOjXjh993LfX
 21zMht0K7G5m8xgt/g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MMobU-1wEjaf1bRk-00UtYG; Fri, 27
 Feb 2026 14:19:29 +0100
Message-ID: <7e073f33-16ad-475e-9d28-54e8006f3a31@gmx.de>
Date: Fri, 27 Feb 2026 14:19:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <Vincent.Stehle@arm.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Pull request efi-2026-04-rc4
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AYYxBSiYVpKcuhc070Z/NvvEqadExFv5VfuUjYghNdGLqS3g296
 9PwkII2q4OuoZjL+jfVG8prYM4eJo2kDwumwnsxNw5rXkmazQADTiift2a93UsOFzjMe+ZV
 kQGNMJaRkxT6rzNYb9QWEF5rg+982EgjTym7B4vxEnt2NfnnKJpU4OA/3CZGaadA4iZEExH
 qqhnAcyAb7WDcO+CG337A==
UI-OutboundReport: notjunk:1;M01:P0:0uou0fS/u9M=;+GEj6ZOsm7ipooHMYvYJbEzMyQR
 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
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

The following changes since commit 437ea9f8be5afaebe2d8cbab6242f1182857f21=
e:

   Gitlab: Fix TEST_PY_TEST_SPEC for qemu-x86_64 in sjg-lab (2026-02-26=20
09:06:33 -0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-efi.git=20
tags/efi-2026-04-rc4

for you to fetch changes up to 89f6b9020db0960e219fc56d0d32aba82e42332a:

   efi_selftest: cosmetic: fix spelling in comments (2026-02-27 12:14:56=
=20
+0100)

Gitlab CI showed no issues:
https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/29389

=2D---------------------------------------------------------------
Pull request efi-2026-04-rc4

UEFI:

* Correct LoadImage() return code for invalid parameters
   and provide a test for it.
* Correct misspells in the test code.

=2D---------------------------------------------------------------
Vincent Stehl=C3=A9 (3):
       efi_loader: fix specific LoadImage() return code
       efi_selftest: test specific LoadImage() case
       efi_selftest: cosmetic: fix spelling in comments

  lib/efi_loader/efi_boottime.c                   | 8 ++++++--
  lib/efi_selftest/efi_selftest_loadimage.c       | 7 +++++++
  lib/efi_selftest/efi_selftest_manageprotocols.c | 8 ++++----
  3 files changed, 17 insertions(+), 6 deletions(-)
