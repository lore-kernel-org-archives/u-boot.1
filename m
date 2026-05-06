Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEAC2CD3436
	for <u-boot@archiver.kernel.org>; Wed,  6 May 2026 12:44:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4EC72848A1;
	Wed,  6 May 2026 14:44:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="hIo2y/wB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC5DC848BC; Wed,  6 May 2026 14:44:28 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1B178484F
 for <u-boot@lists.denx.de>; Wed,  6 May 2026 14:44:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1778071466; x=1778676266; i=xypron.glpk@gmx.de;
 bh=WUvgqpcZ0MLCDSWp3bai+0VENcSL0Uo85nyD+4J9seQ=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
 Subject:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=hIo2y/wBlPcykh9OwRktwnsfYV6cHFV3teQpOMze4vqaAff3zNhCIprBnuSJDKa7
 UHGCwpCcAhe8JPCmSJaz/70V6U0hCfgr9iyD4sDeLbsDHd3xJxMQOWHwla5ELfyZK
 q/+KvzGdFLUUJN28uEc5zgt57saKAg4QtH+HBQJugaKEAVlDyDL0mnj5IL/5391+8
 VKappwcB3Sr+EwbrFsn1fZHGysXszJiYb8LGWHlzAvbM0kmUhZIfQyjYm0DGRqY2p
 cqB//RnvyAhmQ9S4VUMWQ1PmdF3zKo6hflOOXarw8AAeg8D0f1HJF6u4h/3nAXWcY
 7VlWodXVnVr9uH5EXg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M26rD-1wI8dX1BOL-00D2Jm; Wed, 06
 May 2026 14:44:26 +0200
Message-ID: <c9e9c08b-1e29-424a-b83a-11a29a2a111b@gmx.de>
Date: Wed, 6 May 2026 14:44:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Randolph Sapp <rs@ti.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Pull request efi-2026-07-rc2-2
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4f0oZo+2Ha968DzU2bu9aU3PnMc8WWbm1gL6RSyvYvFtM2rSx3C
 eoewC5wHy/oC4dgN3ahI0SMBmzlK2WS+f0i3p0nDJLym2wDFpZnD51YWmtCME6vhDoVC+aE
 p9E+IkZMrcbjYWNhzUbKZn28Jvkhvc22eooVhJdchffBqmAhXBOg2ZRPTLgLAzhzbrUugQq
 mIYkhPO6hzkAn8FzUZsUg==
UI-OutboundReport: notjunk:1;M01:P0:yLEgZx5JmLk=;3GmYifPsKxx6lKyIpu0KvxNhhht
 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
 xGk6MBlB5giiz9Q==
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

The following changes since commit 57460fde4ba84d67de4066ee1141e89e8139ed2=
3:

   Merge branch 'master' of git://git.denx.de/u-boot-coldfire=20
(2026-05-04 14:41:59 -0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-efi.git=20
tags/efi-2026-07-rc2-2

for you to fetch changes up to b1c28ad5fafd95c183b26165e498354db41b755b:

   efi_mem_sort: use list_for_each_entry_safe instead (2026-05-05=20
16:29:08 +0200)

Gitlab CI showed no issues:
https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/29993

=2D---------------------------------------------------------------
Pull request efi-2026-07-rc2-2

UEFI:

* initialize variables in efi_dp_from_http()
* cmd: eficonfig: adjust struct eficonfig_entry, field key
* efi_dt_fixup: use fdtdec_get_bool() for reading boolean no-map property
* efi_selftest_memory: check for duplicates first
* simplify efi_mem_sort() using list_for_each_entry_safe

Others:

* lmb: document allocation flags constants

=2D---------------------------------------------------------------
Heinrich Schuchardt (2):
       efi_loader: initialize variables in efi_dp_from_http()
       cmd: eficonfig: adjust struct eficonfig_entry, field key

Randolph Sapp (4):
       lmb: allocation flags macro documentation
       efi_dt_fixup: use fdtdec_get_bool
       efi_selftest_memory: check for duplicates first
       efi_mem_sort: use list_for_each_entry_safe instead

  include/efi_config.h                   |  4 +--
  include/lmb.h                          | 30 ++++++++++++++++++----
  lib/efi_loader/efi_device_path.c       |  4 +--
  lib/efi_loader/efi_dt_fixup.c          |  3 +--
  lib/efi_loader/efi_memory.c            | 47=20
++++++++++++----------------------
  lib/efi_selftest/efi_selftest_memory.c | 21 ++++++++-------
  6 files changed, 56 insertions(+), 53 deletions(-)
