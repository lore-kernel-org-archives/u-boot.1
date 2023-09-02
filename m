Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4607CA0FF8
	for <u-boot@archiver.kernel.org>; Sat,  2 Sep 2023 07:54:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27F4B847D9;
	Sat,  2 Sep 2023 09:54:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="B+bxM1Tt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41D568669D; Sat,  2 Sep 2023 09:54:16 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5633B81FA8
 for <u-boot@lists.denx.de>; Sat,  2 Sep 2023 09:54:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1693641251; x=1694246051; i=xypron.glpk@gmx.de;
 bh=nlNkDgD08phYqmAnM12DOUTgXnFbVGt1njvei7wrwns=;
 h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
 b=B+bxM1TtHZhkqQrhFNlgLJGYubEmP+UvIEq2o6vWjZ9OBcEEdwnmkYHa7tSCSye4FwJI3AO
 wT77R0EmjMVL5+YvxrCa3k/RrBR6Shj1tkM8/b0aCQALmlJVKXSd90bKdeJMjM+cno4xIbEhq
 07z2QFv5jjbsJJTv4fch6wF37esAvc2DEC/XJVtkOB+Cx1IyMnkpwteTQwrnMe4045KypmBrV
 3jos+kL1kH+XmEFbQuODeYY+UxCesbpBzoP2YsIEQOYGYlCN5sdYtq/kszKbETH2I2B+lvEw6
 tmrKQqvpABuUwBn4ZxH9sAPi6x52YdLYHnR3+B+mVMihiivY8pcg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([62.143.244.162]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MN5iZ-1qM3ew0Wmb-00J1oW; Sat, 02
 Sep 2023 09:54:11 +0200
Message-ID: <a4e2444c-f534-4824-a3ef-fa4c819edfed@gmx.de>
Date: Sat, 2 Sep 2023 09:55:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US, de-DE
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Joshua Watt <jpewhacker@gmail.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [MASTER] Pull request doc-2023-10-rc4-2
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2RZm/pMEWtLuQnO3H3Ug7/wU0W4uYdpYdrCat1ZHLKllRYs8IGG
 Tz/Yj2GVVdi2+OwZ8zQcmLnhyE5SONw2ScFLwoSjBHaFkcdXoEAVd/VAXgafMISFQvdJ+hK
 yOKYbnWXwG0FKLWjGsbo0USDBrn7Bzs/3QbKUUoRGRH0epOkHtXLAW+w917GmcT/UEcRedg
 H38Rui2bHrxRf3/3aT/Nw==
UI-OutboundReport: notjunk:1;M01:P0:6V5X7SV4tyY=;1aHXff+qHfROrZUVkyFS+pMjjVU
 YV2ySP2CzT2YVc5cJAi1mqdiTLlzbOQAQkXhe8W33wiwg8K2yhhgvkCLliu47Sk66FjfMi3Co
 GI7YOiO3k26R1EjCp3MY4DAB7L0WeFTF7VWsz5lIRuz52q6VSMFYqJ67aYEpXsmGXOPsKPRjc
 HSNS05IchDqpIwVm3bltIV0JQYsMWXsBBHN5djrV4gzEMOabw4eBhqXKB03PhqQ/Toc62VQjf
 prCL+QpK4FfjUAI0uaYhNIA9cUexDkxWmchaPmdA6RvSdo3NqFzSsf+A6+NMXYhMJ/lrz9siT
 PUkhxI7Sq5nxQRfVdFMp5fb1aVNWK5v6IuffKOPwtsAVILpX5XcKuGoAf1WMQqeLdONB4dCKq
 dKq0FGyeClg6hA+dMPjW3/mRSsuDK63apFZgm3j+1LIobVx/qgzTHJuXHEIjpX9WmCf7Ncxq5
 dL6kAFWvt57eWGR8wyMerKJGnxw/uGAboHnmCOeAdvSV7swSseVgKPi7BuQtz3bWSDDjo8bDG
 +Yv4gfUbEUaGOsGnfLU08yEVvir7dCWClT3i9rNPAF3kD9o8dXe4P0ZGw2igEKMW2HC0i6+fp
 SYtcCtkH57sajS9B80onygbRrBGUvQCbUIk1ScddlJfykEoeXedBal0eFaXwE/XmoIDSaSziX
 ilXo54fP9/Kmtdq/j0png/gs1x2S+rHfOZmX3Zf2FgWriWAodJhnGm8O6qHlKjojNvRbB5Sfd
 Z9mMrhwI3JY4ObE9BAgbWUTk+Lim5Ch0ng8+vbZrJcT9nnPv1Xm7pHrMZKMda+XsjHyTAZBL5
 xaWPPz/+PLhyLRhhjC4SEtYXqnFKg0YJJTEF4oQwifBfUb94Zt1dVQu41pHAs9BwrVNPiqHee
 0mCYKa//Aje1YP95yCL++ZIoNd8oqCfFgQj8ed2+gqZXOavA+bl6h8VLat+krVuitawQvIMOs
 J3P05ZJjgt8unJMZ7hrI82JUR8U=
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

The following changes since commit 0fe0395922d859730eb7ddfcff6ed8d3ac4b293=
7:

   Merge branch '2023-08-28-assorted-important-fixes' (2023-08-29
10:06:08 -0400)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-efi.git
tags/doc-2023-10-rc4-2

for you to fetch changes up to 44c5d7764bf458ef0a8093ddf3422dfebbf7b00c:

   doc: Add gpt command documentation (2023-09-02 09:44:04 +0200)

=2D---------------------------------------------------------------
Pull request doc-2023-10-rc4-2

* Man-page for gpt command
* Fix long text help of gpt command
* Add events to HTML documentation
* Update Toradex documentation

=2D---------------------------------------------------------------
Heinrich Schuchardt (3):
       dm: event: document all events
       doc: add events.h to documentation
       video: fix typo in video_sync_all documentation

Joshua Watt (2):
       cmd: gpt: Remove confusing help text
       doc: Add gpt command documentation

Marcel Ziswiler (2):
       doc: board: toradex: minor documentation update
       doc: board: toradex: verdin-am62: document update u-boot wrapper

  cmd/gpt.c                           |   2 -
  doc/api/event.rst                   |   9 ++
  doc/api/index.rst                   |   1 +
  doc/board/toradex/apalis-imx8.rst   |  22 ++++-
  doc/board/toradex/colibri-imx8x.rst |  31 ++++--
  doc/board/toradex/colibri_imx7.rst  |  38 ++++----
  doc/board/toradex/verdin-am62.rst   |  22 ++++-
  doc/board/toradex/verdin-imx8mm.rst |   9 +-
  doc/board/toradex/verdin-imx8mp.rst |   9 +-
  doc/usage/cmd/gpt.rst               | 184
++++++++++++++++++++++++++++++++++++
  doc/usage/index.rst                 |   1 +
  include/event.h                     |  97 +++++++++++++++++--
  include/video.h                     |   2 +-
  13 files changed, 372 insertions(+), 55 deletions(-)
  create mode 100644 doc/api/event.rst
  create mode 100644 doc/usage/cmd/gpt.rst
