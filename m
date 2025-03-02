Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3E82C19F32
	for <u-boot@archiver.kernel.org>; Sun,  2 Mar 2025 08:11:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F44880540;
	Sun,  2 Mar 2025 09:11:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="pwWTQqJJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 818AE8058A; Sun,  2 Mar 2025 09:11:42 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B08E803CC
 for <u-boot@lists.denx.de>; Sun,  2 Mar 2025 09:11:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1740903099; x=1741507899; i=xypron.glpk@gmx.de;
 bh=beHq3oqj8pSeVYbUL1hVmUkWohZ5LDZn5wS/NpgErw8=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
 Subject:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=pwWTQqJJ2aDHgbbXhr9SM2Ap3REj8HEdHDrm5TYsdxnTgAFCB8puIUGhg/3HV6eH
 1ICPbApxGkoj0/unfj5ZXU23+Nk9fQFdCS31XOlhvQiIB42Zso4nZLNeM4L2k2hQc
 NPv5ljxdDIYiZbpy8RO0rj3PSFyh5Q5N9ak2B/UlJVXT3pVOivf9Li/ZrjiUMQ7OQ
 sIO877ehb0/NqDuZbqB0Y8sGOcSBVzVDkm5HpYKVzp0yAkgrIosP2Hpb6lKbbjI46
 rKnysaAzFNjUOP7ELV6BWZ/02or7hwPJbp66s4Y0FKGmVjGvYjp11ittvTjYqofXU
 ICzv33pjTSxz2mVGVA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([5.147.80.91]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N3se2-1t6tUR1u4G-00xUvN; Sun, 02
 Mar 2025 09:11:39 +0100
Message-ID: <9e777fab-8183-4938-b578-cf0f26936f18@gmx.de>
Date: Sun, 2 Mar 2025 09:11:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Adriano Cordova <adriano.cordova@canonical.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Pull request efi-2025-04-rc4
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:s5Vx8C4D2MosWrkw7Yjj18pHR0gdih5xO3SrAKJv8GW293nd21D
 dgQI7GI9qENzzQEelYGPKIINJ+bq/EoxCyG4nSTFarRwiMApEe4z+Eu3zHBzOrCioTnKwZF
 pGnVJAfu3N7z3CxDszWztjOKA0Ey1QTQd6eMt3AWVvIVstMM43SjDPsIGINQwfJMQtUyP0L
 R8UYyOkRce7daloD0A7FQ==
UI-OutboundReport: notjunk:1;M01:P0:3+u6DW8Sd2s=;cVP+/+SJ/qXASeGt/Njaz/l9dfT
 qi3Czwf9Q9yEr7Wzo7gOUKQeMV5FOCLJnOL5CGHTBRrT446vrbUsYZUdQ4CLaBuE0KupU00VJ
 YkTHafukO9rTGZTNPm3QOxuRd3zx3jGWxl/1sIJ4HOTFNG1GPv8rH7dVsVFTRHe+LU4e5S1IR
 RnkDu4LqmtCMTUtqdb4iD4cbqs0GWH4AMwgbW+Vc9cmVNRU+J+DQVeznuulLC8SRv0I64nPDz
 nc7XTbpj36uCW+YCEBjPf0+7DZKE5hlQhT9ATPq0dI8vS5oFtnR1hIZ98KXJUv79o+GC43O+D
 pfX12DUTYi2RVQH/YHvX7pPE0lw2nU96A1iUrpdrc78kLSydq1dUDf+PltZ6392yl46bu7XGn
 dXov33bGREwrL3+b2/vpwS6YYWl07SEysNTNaliE5+mVnpjGzLrRGWN1Ry8EV7Jpm8IQWAvzA
 EolPQGU+gsTBRLlaRqYdIW2xSipfIEGUBe+zWRySjanIMJ6P4eRyf2PvmRQjMmTDUEaOpfe2p
 y9WHKi+544DVfgfUG7vFUVNOQCiG8Ajca+UjGVMJLJsTq/Z+uqnt5ilc7yWfutfgaLRAgkdj3
 rwWZI5fi6YgcyyQBaMGeZB+xgJRmv4lCEGM833N3FdqJVUtOD0NjsXilU5aOIzb4WASe41Kkn
 eMhrFl3zLDG3pAJBMOEymrdX3jrkGprkg3qG00GrGpZX5Xp0YOknwjxyBFcYeki6Vki7ps0dX
 WIMhN7Md+aCgLUpecd4aFIv/BCWSgIDOByLXBPtdi2K8YS/2oztEq3Z/fPo3+3wUSd9+7kk2y
 ooDolyPqlUkKR4jhHN37GvWXMFhWgKN4sogoNM8k8iLuhO1rwGWGU9gijk57VUY3rlKKlcgeK
 fcNoxUt/IhHI34ipQMDgm9FHjEAF+iy4ucLBUJKMu9EO9CYnPaW9ZUy4iUpXyUiDD7ri6b+9Q
 nTSGdjFbAm4TbgemIs1pKOgNopk0dGpMI0F136VBhyWuQyfWrBB/VptFrYcwf5Hx7c0uJij/h
 JhgNNahsB2vcATBX0zhx51dRggUjLFfcJs2uA5qvuTHnVjhE/n2zOylCZqCRQme4NZ29a3Suh
 yMSoOHZKuI35vdhfUUQJaTzmTstQ+f7/zPeJX6QXdXWJrc4At+0+fAkq7BX+IHJ2APLtPa1nb
 wn61b+6DB2vxwfdw8jvBRCuHOnnbPGXrVcFKmu6ckCpI6/ByzWduGZF5HyUmxprFWdZ6nyfz5
 yuWPZ98AOSW3Islj6UNNO35Fdz4J9P8sjbCwAWC7WWEGUb0pO4PZh8NcHuqTEMFkXclEzT9tP
 vCPJoLbfa3ED5NISbTpxZt805HdTuaRQMnReTKogtEjkFTy9ekjQWE3aYoQHmvjo2jiJ6bEVT
 EEiCdaThgdftMjVSZGUxHK0lpq5wANsRn6aD9Z9cp2L13BhfbFdAZWX0tr
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

The following changes since commit b78f8677cde8b1dde31b66f5b780f2e9b62fba7=
f:

   arch: arm: dts: k3-am642-phycore-som-binman: Add custMpk to overlays
(2025-02-27 08:07:38 -0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-efi.git
tags/efi-2025-04-rc4

for you to fetch changes up to 32a6c5eac0004bcfbb75d7ff9e9d627aca0e2852:

   legacy-net: wget: fix wget_info handling after new tcp legacy stack
(2025-02-28 15:26:05 +0100)

Gitlab CI showed no issues:
https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/24904

=2D---------------------------------------------------------------
Pull request efi-2025-04-rc4

UEFI:

* let efi_net_set_dp properly update the device path

Network:

* avoid buffer overflows in wget_info with legacy TCP stack

=2D---------------------------------------------------------------
Adriano Cordova (2):
       efi_loader: efi_net: let efi_net_set_dp properly update the
device path
       legacy-net: wget: fix wget_info handling after new tcp legacy stack

  lib/efi_loader/efi_net.c | 61
+++++++++++++++++++++++++++++++++++++++++-------
  net/wget.c               | 18 ++++++++------
  2 files changed, 63 insertions(+), 16 deletions(-)
