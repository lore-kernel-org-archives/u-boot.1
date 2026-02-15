Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A57D4EF586C
	for <u-boot@archiver.kernel.org>; Sun, 15 Feb 2026 09:07:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E41983AA9;
	Sun, 15 Feb 2026 10:07:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="QDIBkJ9Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5519A83AB7; Sun, 15 Feb 2026 10:07:51 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F62280FA1
 for <u-boot@lists.denx.de>; Sun, 15 Feb 2026 10:07:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1771146456; x=1771751256; i=xypron.glpk@gmx.de;
 bh=bmU+zX1qYAjL6OVO1itRJ9YDDtGWC/qwb2o1D9cHtiE=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
 Subject:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=QDIBkJ9ZMnh2essJShbFPEQrqaNY9E/qG6Tw/WRlpJZZqQEb4Nx1N0BFv2fws/RV
 0NpEcfWf6t9XACEb8E0wH1Aois8arfUMRUOliDWtofkbod8Pvi9qrk3kTRIOR6xyi
 l5BM5dCkYDHUjNn9e5Z8LMQdmlhtCBoghFQ+vXfnQDu7tXziklOoRZuGR+aBf+lof
 ZGPN8+pCUomwClIHHDh5/bnGQWbNyDpsy4lAI88mRTuYnahVtDcRugoBuBknGPVS8
 QhLRmAKkz9jmMDBjZ8BBbmpZLOuuxmPJ744/9dYxKJQUmG3D2q0hN71mDz2qK1jLr
 VQuQv7xQ7GtQVmz+lQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.154] ([5.147.80.91]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MYvcA-1wDfSZ1SjY-00OfIZ; Sun, 15
 Feb 2026 10:07:35 +0100
Message-ID: <793a4158-ba45-4d1b-ae8b-3177fae1b4b9@gmx.de>
Date: Sun, 15 Feb 2026 10:07:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Pull request efi-2026-04-rc3
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RntlqF78WQ2TOOCKXWt9SlktySPtBsTH5s3nwk2ahxOZufdJso6
 lBWzlNHEbmrhI6fZoz4QpPERYLcXQlxj1oM/Dw/iS8M4UV0yQJp04HIatu6iL87I9Uu+1vy
 aepYb+Vgej+Of+kvBYGEuatW7ECH6kJX3vMMemj6gwXaxNdyDJO5PMHWIZb2sQ3rcqELvux
 s1EFzlTi+WQ21EY1b7++Q==
UI-OutboundReport: notjunk:1;M01:P0:l36t5KKHUkE=;YaLlfIgbkc7hbjW7r04oArJ5pSx
 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
 FFsZ0G769aRdsHtqSF07ax1HIu9OaiYSDpxdpC
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

The following changes since commit f9ffeec4bdcf1da655a0ffea482062adde78fee=
8:

   board: toradex: Make A53 get RAM size from DT in K3 boards=20
(2026-02-12 08:12:09 -0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-efi.git=20
tags/efi-2026-04-rc3

for you to fetch changes up to ca4eda24c64401eec477c4073e56d136d86f88b0:

   efi_loader: fix ecpt size computation (2026-02-15 08:30:57 +0100)

Gitlab CI showed no issues:
https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/29293

=2D---------------------------------------------------------------
Pull request efi-2026-04-rc3

UEFI:

* add missing EFI_CALL around tcg2 read_blocks calls
* fix ECPT table size computation

=2D---------------------------------------------------------------
Vincent Stehl=C3=A9 (2):
       efi_loader: add missing EFI_CALL around tcg2 read_blocks calls
       efi_loader: fix ecpt size computation

  lib/efi_loader/efi_conformance.c | 18 +++++++++---------
  lib/efi_loader/efi_tcg2.c        | 13 ++++++++-----
  2 files changed, 17 insertions(+), 14 deletions(-)
