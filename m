Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A6E0C27C4F
	for <u-boot@archiver.kernel.org>; Thu, 13 Jun 2024 11:37:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A9F4888F0;
	Thu, 13 Jun 2024 13:37:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="Kn7MAYIz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 068BA888F2; Thu, 13 Jun 2024 13:37:43 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7EEA888EE
 for <u-boot@lists.denx.de>; Thu, 13 Jun 2024 13:37:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1718278655; x=1718883455; i=xypron.glpk@gmx.de;
 bh=dNrmLPdqI2xOQ7bDFaqenJTpJv94rtro6ov2h9i/Fmc=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
 Subject:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=Kn7MAYIzlMBBbNZ0r6WaWerGZr8+5OU5QVXR6VhLNoQsej1gHcO/+Vkad52rUjxq
 pRSqimbfenCMAARPb5NcueBhAAeIXS3j8Gw0rpgYATfcfkw9oEwA9ZyhQ9tthvfJe
 vnS32EHY3u3YnW+UVm6G2UMGYQE2aZ3n5/UDtR6QLOuewvwS/kXPr5FKMOYTNWXbB
 reK80zXHeVsDkO9v8M0ei0tbktwYMUtCnK5B10a0+vFnMkNUKDXBeqKnDzGj7QPg0
 BQ568852Mx/JRzRZ3WXmnaG/QWV+MFlUyR5JAMyIgVwxyiYSp4pIthyQsi+R6dJVd
 mRGTAeGQZax/Lb4nvQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.126] ([178.202.41.25]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MS3il-1roo0j49cp-00Ndhx; Thu, 13
 Jun 2024 13:37:35 +0200
Message-ID: <7e881715-31d5-4407-bd51-fc527cb82c33@gmx.de>
Date: Thu, 13 Jun 2024 13:37:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>, Weizhao Ouyang <o451686892@gmail.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Pull request efi-2024-07-rc5 for branch master
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EpS/fbbkD3YIh7HDwLy/ipDfQK+vIKwf0Bi/HSDRmgC3rQlo9qm
 8IyHIyDBCjeCBzuHvBC9raS3J6Kcx5i0Hhs1ewixt4sd9UUIkPbGxclxuRILDOoHf9h7/ri
 lQ/a+YmrPVbVAjnBgP4spNZJY1NpN7aB2Zld3JoQahXEqLaIFCuQCdYafCFarAwxjAOBItY
 EUZvYe3q0S8MQtcRXy7bA==
UI-OutboundReport: notjunk:1;M01:P0:G5hkBukUEgI=;/OhfavLy6wc7FNzth5HWs0NtnZb
 Gn/Gk1/Hc1nh1WHi8bcaEkXw0hFTax/XK/clZft4Q4F7YsA+bcGlJgn13nWdbFxKneKfrf2Qu
 A2MlkOmJYDlg1lMXJ3bykWpUcyp2TuufIq93Bdvt1RCF5PK6V2Mt6yd23bAcO5lrEtBOQw4Ct
 EaoQEg9Ydu8yxCKzenITIar44Ez5kgBapGC0+rOipmu8vahx2FcVs9db6N2HWSeNztc9c4EKS
 8oxUTgDbnKFIZneaTx6dwrNmv2imJ7hgFSa3Mo8KTzzELEMzUBsPbZgPqUhLuOpA4KB8AGqa8
 5d9/wZ9rwVIpYdXULAruXrQ/qUdHagTN/LGr7wuGQ3U+S/8M/WC4/27ry/yLULMWMhNiMWLNY
 KoXYBknWb6RTkhKNxbqIx88JR7MASPlDGwdB6wC9Llwt0yuB2JlcdDkxw9pVpc/ZImOsO8GI5
 BwlJUpSx2qBr4xEXPGE/ckECsajV63skEdOMLc6661JVlyJV4ljsn0BegW2dnb+HQxok7rZv8
 TwGpe8s8BfzSJeemAoq71T6iWaBGJYxyMxv+k17HnP5cISItzLuGUNhR6VZ3Gj2RmNTLoNWvH
 KH75kmH5A5ekSpvIPgueA0tVLdPCR86UQZ5XEVJ8YWsk46MUst4vZ+uNSvww98dCs1dDZo5R0
 lYW18naNl7YWWXO7apDbkWJATwJBgYRa8xaufiNZf52zIISmgoRqunMg/C5brfaDns2OLhzVB
 LSO/FZPCse+CiFIBQ9uO4zbEwZ8IBfeHugpoesa20AsIw8DtezvP7JcOdng7Wu0REgYcHfnM2
 JBrji6ZGG36KhzfvjnddfoUM1dKTzoPz2CrcQu+iX5Eng=
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

The following changes since commit 1ebd659cf020843fd8e8ef90d85a66941cbab6e=
c:

   Merge tag 'u-boot-dfu-20240606' of
https://source.denx.de/u-boot/custodians/u-boot-dfu (2024-06-06 08:24:15
-0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-efi.git
tags/efi-2024-07-rc5

for you to fetch changes up to f3b6228ef4ee6918a9e1ec1db399ede057308a13:

   doc/sphinx, test/py: Update requests module to 2.32.2 (2024-06-10
15:05:30 +0200)

Gitlab CI showed no issues:
https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/21060

=2D---------------------------------------------------------------
Pull request efi-2024-07-rc5

Documentation:

* update build dependency Python request module to version 2.32.2
* fix typos

UEFI:

* Correct signature check when appending to EFI variables.

=2D---------------------------------------------------------------
Mattijs Korpershoek (1):
       doc: cmd: bootmeth: Fix extlinunx -> extlinux typo

Michal Simek (1):
       efi_loader: Fix capsule_esl.dtsi.in comment style

Tom Rini (1):
       doc/sphinx, test/py: Update requests module to 2.32.2

Weizhao Ouyang (1):
       efi_loader: Fix EFI_VARIABLE_APPEND_WRITE hash check

  doc/sphinx/requirements.txt                    |  2 +-
  doc/usage/cmd/bootmeth.rst                     |  2 +-
  lib/efi_loader/capsule_esl.dtsi.in             |  4 ++--
  lib/efi_loader/efi_variable.c                  |  6 +++---
  test/py/requirements.txt                       |  2 +-
  test/py/tests/test_efi_secboot/conftest.py     | 10 ++++++++++
  test/py/tests/test_efi_secboot/test_authvar.py |  4 ++--
  test/py/tests/test_efi_secboot/test_signed.py  | 10 +++++-----
  8 files changed, 25 insertions(+), 15 deletions(-)
