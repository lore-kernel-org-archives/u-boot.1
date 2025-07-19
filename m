Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80E5CC83F34
	for <u-boot@archiver.kernel.org>; Sat, 19 Jul 2025 10:47:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1F8183693;
	Sat, 19 Jul 2025 12:47:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="H807UgQq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0044483479; Sat, 19 Jul 2025 12:47:06 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2169983693
 for <u-boot@lists.denx.de>; Sat, 19 Jul 2025 12:47:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1752922023; x=1753526823; i=xypron.glpk@gmx.de;
 bh=oGCAQBWvfh0TLGdS/KbiOZp/z3hQpKhItWY0qnvu2So=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
 Subject:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=H807UgQqLLlyNLs4GLAJWufaoe6vKNND/jLp0CXCVs56QyRUP/W45shnBCr818qp
 kkh3zaKhWwVRuXglghNwuFtUD15jDNIdyaa+Hda/Jv/MXOxx1T5028xkP9udRGbg5
 NpIlhn4kx6k41pdV2gbK4EotBdlBEDz9hFmXJu1s1QVQt4RZMuoO1pgsg+QZDk58B
 zN3xmiIatIrzN4yZEmaZwDQGcsRgird5WM3p1WFtrfRFbKUxztG+NGt3iRTs/urdB
 E6qCiXjPUA4wLUIaAQq1AIahBmOvOxbIIzeKzcbE2XeFqg8pSetVsZA1Duvossvt4
 TQioJQCopRZhkpTWrw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.84.190.42] ([37.109.45.122]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MWRRZ-1u58xx3RLH-00IbSC; Sat, 19
 Jul 2025 12:47:03 +0200
Message-ID: <64e80782-bb7d-4b2b-ae42-82e7077ed4ca@gmx.de>
Date: Sat, 19 Jul 2025 12:46:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Fiona Klute <fiona.klute@gmx.de>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Pull request doc-202510-rc1
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LuZTX87DeqgCcxm0DRv3bOfEMP880uW1ajTYaUuKVUD7wIzuahi
 fQ/nRYQKXCSiAQkdzX0jfGJJqBWUjRuc23hJnKpreC1wXfx9Zp/O2LWaPJqXQ7hFlw5XJuK
 nsvzULSe8VroEt1z8qgcdTkJ5o++RISwz8F734xpUvhnAkA4vSSr+lR8qaivndcVmWe8Tv+
 QmvCXdmYQz1n8Qp8Y5bJg==
UI-OutboundReport: notjunk:1;M01:P0:WiySwRltWr8=;5j4Ho0H6cDiw20Y6tqfQAIbro1E
 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
 KlZ/bGLi5/yXauw0+fj9HFE=
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

The following changes since commit bd0ade7d090a334b3986936d63a34001d99722a=
d:

   kbuild: Don't mandate gcc as the host compiler (2025-07-18 12:22:24=20
-0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-efi.git=20
tags/doc-202510-rc1

for you to fetch changes up to 4caf13f9a679fd52cd56952795e5ecd4ea315519:

   doc: PXE: mention extlinux.conf and sysboot (2025-07-19 12:37:40 +0200)

=2D---------------------------------------------------------------
Pull request doc-202510-rc1

Documentation:

* describe Dragonwing IQ8 board building/flashing
* move PXE README into HTML documentation
* PXE: mention extlinux.conf and sysboot
* correct references in x86-fit-boot.rst

=2D---------------------------------------------------------------
Balaji Selvanathan (1):
       doc: board: qualcomm: document Dragonwing IQ8 board building/flashi=
ng

Fiona Klute (3):
       doc: move PXE README into usage documentation
       doc: PXE usage: move environment variables to a separate section
       doc: PXE: mention extlinux.conf and sysboot

Heinrich Schuchardt (1):
       doc: correct references in x86-fit-boot.rst

  doc/README.pxe                 | 292 ----------------------------------
  doc/board/qualcomm/index.rst   |   7 +-
  doc/board/qualcomm/iq8.rst     |  43 +++++
  doc/usage/fit/x86-fit-boot.rst |   7 +-
  doc/usage/index.rst            |   1 +
  doc/usage/pxe.rst              | 346=20
+++++++++++++++++++++++++++++++++++++++++
  6 files changed, 398 insertions(+), 298 deletions(-)
  delete mode 100644 doc/README.pxe
  create mode 100644 doc/board/qualcomm/iq8.rst
  create mode 100644 doc/usage/pxe.rst
