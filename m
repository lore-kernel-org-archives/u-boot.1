Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D3EFC52D7B
	for <u-boot@archiver.kernel.org>; Sun, 11 Aug 2024 07:06:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B00587F7D;
	Sun, 11 Aug 2024 09:06:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="GfPxS7Ys";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C630F884BE; Sun, 11 Aug 2024 09:06:49 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95A3187DEA
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 09:06:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1723360005; x=1723964805; i=xypron.glpk@gmx.de;
 bh=VC5iUpfdhZu9AeCaf3CZJ0jBuz01eV8Y0NYUDJmxiMM=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
 Subject:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=GfPxS7YshEqJ4XkBSHWC4dTUU7cZ55x4UqPw+rXsujFRr4tbl4I4oOJCQdyFa4Ba
 0Ex2rDw445hSD0N7mx6npnvCPiNvy5EOwvHdXxcBRgH1n3JCknRlQac+b8AmCpE5G
 2fdLM9NHKtad0CAF4dj2CLox6eZUbrziZ17G5H0UFyDURj+HKZTlbNtvX0ZSLGub6
 RDIJx7gtHQ+Ep9YUIRoLcCwQMSr70MxGGJf+A90uUuWftGgSgL4tAJMr3BlTJH3/t
 H3/Wkpg1NkZDt+K7dts2bUn3ed5f9D8/uClVbrjIVMuz/geZ2ZreAMIQO9Uku4ivO
 WNRvlq7X7ckftV2zyA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.143.105] ([46.114.218.160]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MLi8g-1suZXx2g2i-00JaBY; Sun, 11
 Aug 2024 09:06:45 +0200
Message-ID: <7617b97a-c22b-417d-9ad1-66f6eb024c32@gmx.de>
Date: Sun, 11 Aug 2024 09:06:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Pull request efi-2024-10-rc3
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BXjs3lcUkjGO6Tt+VRFwrNv3cLn+dYmQegsebniNokXKku+DnM9
 4U/Ud3ko4TSNAkdAYjq0Ufbk3BXMpsoYiwufSsrjwnLy9jyaANuyq5M+fGphoduGDIkMDaf
 W5kTu0+yLuzSHthIqYOMAUnaYzBfAu8Vzo1OFxzD8m7DJv0/CguFSS84ydjtadWNryFhjz8
 XitUlInF7HfIZMWBWnlOQ==
UI-OutboundReport: notjunk:1;M01:P0:kCE/UKa56Vk=;dYzKz0zhIcuHToiZD8YKWlgB0ew
 CRGIvredlbNge1Ew+o7rI/DKAsk3RPKUUjCoRq130Oie+gi0Hnk5+o4lBrJjFuvIFOYQhmPk1
 MUj5kJyCsYeY65kYwMKh69Y0IBNQ/E8sStPVSiKdKpQqIuCXMSOcG7TvDkiZoPVxUOlFGuS4c
 u7sgKv20gOMEIhxKcwSkVh06cg1b265Ri1cmtoizjBX7q2FbNWWZt0K5JCMbu2FsbhAcX6Y14
 hHSNJrjVHoe9duboBIog3MH6VGDnV0MP/vNQd+wJmihKdzHbtDqosQN5UIHD0Mi+9JUa9EYBd
 LRMbPhmTWhvFFY0mDH98v3NvdYjK8b6b4zE90Emvyjw/ayoSEB+pe2qiLsSCQ9n5lEKXj1dXF
 8U4YIC0TzZuEp/ZCwaVqUCiezTx3uqdoeUvV+WPEYVy+te3wMx+iXnevfbJv1mSCm3pBvpOqK
 k6hdYSQ8ZcXBw5K4cp5V7Dxzm9+X3/bH4lOG58PFzsdADK35DIPRLxMtoWnGER2mMlmImwIbD
 WeyCjDZd8qpWBW2xQ+uFA9P/BYq3U77yor4RW6eCtDZzhFRC/TcdyLmLaE4hfBq2fF4Yn/Yvv
 957q6t3N4Rys84LeSDLpI30KorkVM+imUrCbDeG+op5cD/nE4l+r6mr3DyuV13fU4bEZ8y6sh
 2gUrG+5pafZ1bdyXgysME8o/G9EMbXSCpcWzotOmk6bk2NDaaXSjz1IYWkXdtroFDy6LWHJlu
 +iHVoNnkEwe5O5DE39PA35Ba6ahIwhMvAFls4bHS0v9UqykIvWHPpUDxCmIsl9I4yYKGQiKE1
 g9T44+xM8qd0A/1NAYiK6X95CWfFmWQJP6apQsLcC78wc=
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

The following changes since commit 7bd2559cb30a4e800db519e88a22a25f13c753e=
c:

   Merge tag 'tpm-master-09082024' of
https://source.denx.de/u-boot/custodians/u-boot-tpm.git (2024-08-09
14:00:04 -0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-efi.git
tags/efi-2024-10-rc3

for you to fetch changes up to 2956a84ba70176333743773c9a2bf0353add65c9:

   Makefile: don't use CFLAGS for environment text file (2024-08-11
07:54:58 +0200)

Gitlab CI showed no issues:
https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/21972

=2D---------------------------------------------------------------
Pull request efi-2024-10-rc3

UEFI:

* efi_loader: use list_count_nodes() in efi_protocols_per_handle()
* efi_loader: correct description of efi_get_distro_fdt_name
* boot: set correct block device name in set_efi_bootdev()
* configs: enable efidebug and EFI http boot on QEMU aarch64

Other:

* Makefile: don't use CFLAGS for environment text file

=2D---------------------------------------------------------------
Heinrich Schuchardt (4):
       efi_loader: use list_count_nodes() in efi_protocols_per_handle()
       efi_loader: correct description of efi_get_distro_fdt_name
       boot: set correct block device name in set_efi_bootdev()
       Makefile: don't use CFLAGS for environment text file

Ilias Apalodimas (1):
       configs: enable efidebug and EFI http boot on QEMU aarch64

  Makefile                      | 2 +-
  boot/bootmeth_efi.c           | 7 +++----
  configs/qemu_arm64_defconfig  | 2 ++
  lib/efi_loader/efi_boottime.c | 6 +-----
  lib/efi_loader/efi_fdt.c      | 2 +-
  5 files changed, 8 insertions(+), 11 deletions(-)

