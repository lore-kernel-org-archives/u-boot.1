Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4E20C25B74
	for <u-boot@archiver.kernel.org>; Sat, 18 May 2024 20:51:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC13C884FD;
	Sat, 18 May 2024 22:51:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="uFrFHsEN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9EE68852B; Sat, 18 May 2024 22:51:14 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85ABE884CD
 for <u-boot@lists.denx.de>; Sat, 18 May 2024 22:51:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1716065470; x=1716670270; i=xypron.glpk@gmx.de;
 bh=foqYz2GGjOzR4wIHmx307q3FrvZ8F/G0n9kr8PnBzKA=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
 Subject:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=uFrFHsEN3EyZkqyMlGG7c8srN7CMvEbp06q0eM2Ybt7m1YAOQt6xyTyHeq+5RKP8
 fw5Xs0gVa8kyJyc4EDvi/01qeOpktyMGRDDpc1+HILmOTMB7TleUphS8TvCBvTNao
 HRMEl8tXgekbpPEzgVJ9dZpHkDEvt99/8S6uHubdE3qKC/B1gcW4mrIyhezKtqF7V
 GLKzTeIh6UXP4sQKUJeBFCq47doZH9RI/j4IguHFPrlmDDqIT3niXJ44fjaeAkK9n
 gUwUa15x6GdOuF/QW8YZ9JjXOBgs3aS+10cvgfNY9+3dqAhyYzl3kP0jLvpQTD6Jq
 IUT6n23YT0tulfF6Dw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([62.143.245.32]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M8QS8-1sCojW1o5Q-00812T; Sat, 18
 May 2024 22:51:10 +0200
Message-ID: <63cd77fe-73aa-48e2-af4b-a3de9ea09d0a@gmx.de>
Date: Sat, 18 May 2024 22:51:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Weizhao Ouyang <o451686892@gmail.com>, Fiona Klute <fiona.klute@gmx.de>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Pull request efi-2024-07-rc3
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:W0ENrozdOd5dDQCIeYtqFxmblPUWS8aitkEzhno/XBB5ONCXvhN
 zfmuMb8mnxS1B4MhBLqztmjj7J0Mx7DtKBBSzpVL/L6p0FMJVrXSmhxU6CdAkW5Gagj96ns
 vmxfVShmFkzGuDRnriHmJ4FkGz0E9V8+OFMdrdBp9bsDKHWKKTvT5gNO/CNsslfaeYtxyNj
 dV9gD2AvzKoZIr8cbCkGw==
UI-OutboundReport: notjunk:1;M01:P0:epiESaBD7lo=;tDNyVyynaVzVOf7fMlSi+nzuwQu
 ktBw2uplEpeUr7ZTKZmWKdmGnjxgZUvHlSIbDB+lhKnXKNDRXKTjoJBFmxD39DJMRRiXQkL/h
 jrkBOBJrqmRIg5hsNI25XmcEK0Trqx+JxaFHv3uCiWbklyPR9/Xbse/NYc214wFRRYf41ZVI8
 HCPZ5kTIh13k1tyOO5qPUj3u+SvaggkbJjGHHD5wd6L7lyYxtSx0kvhzUvQqmEh0yEbAs1GWa
 E6rwwKuykl6Wc9iAFXtBCMPsA5VHRl6cTZJg41HV3EFVB8EYY5qj8Sru0t8AlWBGEhTBV3sdY
 VfNbO8UQ7cS852oqqXKq9Ed+gPhiZYx2+EAmVtoF+vuJGlXtT5xr8UcGlvMMI9bTuthD2ElFj
 25PEYcYLZyVsjiNepEnQSmjrCaQH7HfZx6JZYERvwOLPkkUOrpittsP15K+Y8oCQKR9lgkm14
 /IYegjPmEfl2yxFZB1YHSfdinXXusZdcIrZN8g0emA9FU/B9kDODn36f4fO1tQPN9vruIGMkk
 n7raGbSqsZI0O9C5osxG5XE4cUCTNU/A14tsmuE21/8ST/ikWu84/03+nwtIny+BOyBC9yUzH
 HzzNRb+ATSeiswWdSe+bIdSZf3b06GV1DtQ9FWTCMtqyrbx4oEfZ7KPhLJ1pfF5R8Uvk1fFB5
 BLP5SP3v+f/G9ilJrBaw3u3H973yS3Tj3fwA8YM/eyzvqFJQ7/V/TRQvBAPAPuGTCwGk+2sUp
 JfrGa8088vyudozNdNevoOg4tdpqOaEf+nFHSU0C5mq/YRYrdhGVpEwu43JobM+0OuywW0PvH
 14/oFFQTSH7vuQ/vEKYpc9Io2yzlxjIn8PVHmE78aOLLo=
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

The following changes since commit 3be9f399e911cfc437a37ac826441f1d96da1c9=
b:

   Init virtio before loading ENV from EXT4 or FAT (2024-05-17 13:18:43
-0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-efi.git
tags/efi-2024-07-rc3

for you to fetch changes up to 41145d93556e3f1d38e5147f4a6fc65610229ab4:

   doc: process.rst: Document device tree resync rules (2024-05-18
10:36:59 +0200)

Gitlab CI reported no issues:
https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/20753

=2D---------------------------------------------------------------
Pull request efi-2024-07-rc3

Documentation:

* improve netconsole documenation
* document device tree resync rules

UEFI:

* correct handling of signed variable append

=2D---------------------------------------------------------------
Fiona Klute (2):
       doc: Detailed example for netconsole setup
       doc: Update netconsole examples, mention stderr

Tom Rini (2):
       doc: process.rst: Use subsubheading for "Phases of the
Development Process"
       doc: process.rst: Document device tree resync rules

Weizhao Ouyang (1):
       efi_loader: Fix EFI_VARIABLE_APPEND_WRITE hash check

  doc/develop/devicetree/control.rst             |  9 +++--
  doc/develop/process.rst                        | 21 ++++++++---
  doc/usage/netconsole.rst                       | 49
+++++++++++++++++++++-----
  lib/efi_loader/efi_variable.c                  |  6 ++--
  test/py/tests/test_efi_secboot/conftest.py     | 10 ++++++
  test/py/tests/test_efi_secboot/test_authvar.py |  4 +--
  test/py/tests/test_efi_secboot/test_signed.py  | 10 +++---
  7 files changed, 83 insertions(+), 26 deletions(-)
