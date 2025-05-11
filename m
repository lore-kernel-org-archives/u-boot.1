Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFD51C3ABC5
	for <u-boot@archiver.kernel.org>; Sun, 11 May 2025 12:30:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E24FC8091A;
	Sun, 11 May 2025 14:30:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="h+VqZvVa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 080F380ADF; Sun, 11 May 2025 14:30:44 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA1148070C
 for <u-boot@lists.denx.de>; Sun, 11 May 2025 14:30:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1746966641; x=1747571441; i=xypron.glpk@gmx.de;
 bh=UddG1Uwki5y6tFmfQV9B79xKzfiCTjAhQ4jFz4XD4+M=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
 Subject:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=h+VqZvVabPM945jtXPA0hzZh7FZmDYp4zF5VpyLcAOtloOmXYRR/u07q+Tva73vi
 zQd9euoVTBkveZjomhNYhuFD747ukwC4OaAUs9T7UNa8BuTYoE0lYCuNyChYNgR+D
 uXo4ZkjWlzutE4yQSudT541sjZPASv0422fqaNtVH0/M/N5gjWjsY17K9OQC1xuHh
 1pvxul7fWKy0mGTfOlri0q+k6xQBz4P1HT2bOZ5uYisIBcmfveNT39nLDAdEQnvXd
 5BS3xIyGt5n4tqz7HGk8KGFXSVhZBHCHh7Ia0suwym1OFE80R7nHx8RD8Fv6tHG6F
 14fyXWAinw3Jo3956A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.101.1.247] ([185.104.138.99]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MUowV-1uNGsI0feD-00RJa5; Sun, 11
 May 2025 14:30:41 +0200
Message-ID: <51013587-5ef3-46e5-9e7d-d045cca9c14f@gmx.de>
Date: Sun, 11 May 2025 14:30:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Adriano Cordova <adrianox@gmail.com>,
 Adriano Cordova Fedeli <adriano.cordova@canonical.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Pull-request efi-2025-07-rc3
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fy40QHLcmYxUq4hE2HxB2iIXzm2IiKZvU9V13Pk7bQBi2NJq1o/
 xVtCmeAB6CZJnczEyG5b/rY/ordRPuYWzkZcPb2ummMH5l3wd41+kXorUNae6AxzbdWKx3Q
 kutUxk/tgeNaXwzSFFsgvMA7d/l1cvAQPyu5y+GZbyq8SM/lzJlsLhYYjIk1zZN5/MQxr0N
 lBCwF2x/k6jeu1vDaoozg==
UI-OutboundReport: notjunk:1;M01:P0:olMJaDzLf/Y=;h7UHiQc3OlLPKylfNduB/n1fymh
 uH1PVb3NxBeb/WEbARY56quZb62ASuhiGIAAh7ho+uGfLT78DN5NncI8awxeWs08UT+QBtxbU
 eB2w70avoEmXInOozDDEALY20u4a109YbQBju9RFqaMZfcZayOyT0MfLjAkywJ97CKqimwA65
 2tT2bJ6VFqHsL6NYkc+xGTvOyX63bWuPyYYPW+eYhOQf48zVA3+1tqAXvMBM9aTA/8ZG7RP00
 3vpegYpuY4o7YixXZiFCu8HDpSKfAoP0seoEKP7TbrWFMy6AuE+jT1TuDNKuAp7cQX6+4HkrL
 jvA4Qu9DPx1glO4rVjZIYgO2hiOk5IYXAKshxyAQk7ARpNUsEM6VY0+gjNDiD9ytKyA6hxxHc
 6SMhDudNQA9aDeSgL0RlPV9PvJFlXu9XZvEKPKbFFYNi83AbRWNAt43WzdeweEF1LuJ0Y4bM3
 pEFVu7V8Baty182HNMWTYwU34lARfSjhf2MBJB8cIWof+A/m/IiNmGfIWVjVaHvdB9rXOOKOG
 bj/7vf2mOq60PHb98+ODgmzS8C6vby/Jlm5r7ezkY+QmMTosU+dBQICV2tS4kvHZWBVcmSx/G
 OY7+2J1CErnaxw7A5wAIemipx86YNeLWJlsD0piolbI26UWfl94fDoG1K2kbYN/uReIHF8aBy
 /Lb4++YzmypxBZ9Xb4VlNb6/PrY2l7TIBPlQBr+45TWFbv6cusou8b7iHW3tSNgx6+WGdHxXA
 EpKMLWZOXl2wMYfw5D+nPF1op8JAsj49aTTVYgFQluRi50BMNYSu6iY30iuUdl9IOd6woJ5sA
 2BrMRpy64cc2suHhQ2QMgeuGzSfjwU5WL+4TWjz1wkpOEcD4QSccWLjKCArdsjWz8MItyfARA
 FL9J3UZm0t1ZP+wOV3sd5MhrSlNuoZU6MWxgsup1R5T0iHgl/r83pz4G7EorcMDm4XxgnbFXp
 waWmYS9UQkq7kde5UKqvKCAenhIDSDAOAEilfvqcYBTFSnFRbo6qYDrynhhqr5BeQ8wpT1gkq
 4ByFnGmjOYeoka/PVn1YM/ly+rT4Vi59kP0VT+ED73bi0CiQb+0maQMmd9Ih3+LkUUM91WCwx
 C9lWSkiR67Ko5hWzIoiZtAxXbUow82N5WoK7P1hOfnxIEGT9fHwMhdNLtZlcT+zRLszIn14lX
 faabkIGWWJX9z2qMAYRVvhNh59DM20/0qn8UPG0LmBzqveH3gr4gsIAgoc0OOkWwf4UcKzWzv
 yYTKyNqmK0kacQ/WyvnuGZgHOkvoES/nFp67c3hPN9cakXXYB1nW0jqDcgOSJKHJxHXXyd9vw
 g/2zXvRTxv8yLpKlseIgWrlyZeJqskdE4GofiAuTZ2ceaKanNxz1O1bGoFMvUZ6MrCZoTHzPv
 vneM+hqGHXVKbXyhYFBDqZsR9qML7CVkK+r3vgHAOQ+dHSPRc2fZQqsOq1EObXxN2iOWg52bT
 KM7UbqYBz4aHO/6ecKP0RtsaZcIitL38YvseXZIT7H/WHVewsA2KZ7OhODV1qdbzNF+EfwTVd
 PrPl4zLVNMs/foA78bRbDQ1ELZs2fGkik7EqJV/rSmJzAXn1KVOFu5KJSHuj+UmRyiwTxdW1Z
 NzznmWWzvnaDSkDKVkpFa6xTDAcD+oyRDoDMalbyIF+y/iQlZZ0fGBiGbpiMaPw4nr0Jr98T9
 PctdBW2q7CJIyoMC1rL1MSh1Z3KRoO5gANAozMN0XQ/UwYKKzCmEdDNvUY+RcM72WxAlwVrRT
 UeAoOzSDtlT3TAFZH3BzP0fL4a++f4nE7lwLlkTlf5pC1fnoTWDCp0DCq9GZ0hKb0r+aEnUFP
 vozpnOnpHUEPy5u8pu3HZ1isZNRcy5i/gugVSvDalnmYHOMhvShYpf+D0k1ml1Qb580F+HThQ
 UQXMiCZYqqIMFMn0q7PpiQRPTdcD6Le87FcvbNLN9Z0HjcsAwrXuGBHfN9lEeuw0gQr9OXZb2
 CEnEPRjIRsC/EkIbVFSzbYoY2TOCWfabo9v8+9QTRMi3qJ+v0xY+BYp3cbGg/dQKGBRVqCwHK
 ouIgXjXWWd7N00qTkvhvaSPlacaUPbiLRtO/EWVq+l/UAswpkxvGEpfHITUxhobFtRrs6eXPD
 cEXd0DzWRUeoJlpnUOdWD5r+RhMCcrjSKThxbujJOlW7OfUemtpeao+7v4yZXLHlR/bReqPrJ
 1FI0ebfRTlZKHg6uVo9CseDCVwI4C4pi/ixO0eTAGl3VJTedndJkn7AYEr6HtI1SN9kRdoVWB
 SbsypXfGZcg9JIVODDdNZBxSX65aqpCcNQrhw+nbrTV7FJxM3OJbbcHJ17QbjFHnCHZhYbX1c
 hzSVsfzre3CT4io/+pkYhuNvKSZuECJCxdQm2l8XF1ZypnQnqJSwav30sii1JKsRktCiUMNWM
 ymkN/gS5MD+FLNmSGU+Ikva8uLqixqaHMc6Spc7XM4B2RvUI+s76nmf6dQJEh5SG5vOXZGkVN
 P8CjeGJ58Q2vHIwzsyWUeiQyzskRWYHltyBsE9rx/MVk34Voam4Wu2hyBmZfLXFD8FkLO55oS
 TW6vAqV2u8+lVzolh219IDTmjYh6gRUYUwjGiIVSqXVtO0kOwZAuqIrfpMWfFGSv3nZNR64eK
 uTntSh1ynjt1ZkQno+gZt/z6JK9rvJ1CSPwG2kW3xsvM3enMnmzQt3ZhSbVlwlLnHdHQv/nX3
 5Q/FsDGdGvrzvaRgaa2tawbF7hbzTrgk3zgHAFrIJpJMmEGdArozwD7Xn08yQmOUoqBD+jp/1
 XWR5SRRcu7QiNMSRz412XdaCncjzEDIM2A5DWrrG2pgzHb+0RsPWeJUDpFWCl0dXhqhgrR/M9
 2w9NKpmONK/QfIsMJa/cJJaO/izI0fWCFDXmW0oHRQ9GPoqMz7BByofb4tafrynfxCJOmPIQT
 adQW6SMBIQ8Hmavyi8VOTJmGbZ+AFpR1nWrF54cHH06SUa7zywKf2JS4huKs9jh9koouBkTAl
 Z7ZGI3M/AmIU02LYE+00Vf2td6859HXAQ0+uL6vtxUoiu5f2t9eqZo2YydXVUgLzPNFmehjrO
 ZGk6LVoSw5JVDbDodqbVhJnAQIjszFYO8+TvZTbaFj7Sdc7nugzETAyIW1NlkJAN1AEyVltsG
 daO+vo0Y0IaIY=
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

The following changes since commit feb55165233623648cb0a74953735b00ec6e322=
e:

   board: ti: sec-cfg.yaml: Fix OTP write_host_id order (2025-05-09=20
15:10:33 -0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-efi.git=20
tags/efi-2025-07-rc3

for you to fetch changes up to 8fdb8740b39b01d182137d437f2d1d16b526a4b5:

   test/py/test_efi_fit: test fdt and initrd (2025-05-11 13:30:36 +0200)

Gitlab CI showed no issues:
https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/26146

=2D---------------------------------------------------------------
Pull-request efi-2025-07-rc3

Documentation:

* Improve the pytest documentation
* u-boot-test-reset: mention power cycling
* describe u-boot-test-release
* correct link to QEMU
* describe that RISC-V supports semihosting

UEFI:

* link libggc via PLATFORM_LIBGCC to EFI binaries
* allow suppressing ANSI output in dtbdump.efi
* test/py/test_efi_fit: test fdt and initrd

=2D---------------------------------------------------------------
Adriano Cordova (3):
       scripts/Makefile.lib: add PLATFORM_LIBGCC to efi linking
       efi_loader: fix dtbdump output color and format
       test/py/test_efi_fit: test fdt and initrd

Heinrich Schuchardt (4):
       doc: u-boot-test-reset: mention power cycling
       doc: describe u-boot-test-release
       doc: correct link to QEMU
       doc: RISC-V supports semihosting

Tom Rini (10):
       doc: Start improving our pytest documentation
       doc: pytest: Framework for documenting tests and document=20
test_000_version
       doc: pytest: Document the test_net_boot test
       test: test_net_boot: Add more comments
       doc: pytest: Document the test_net test
       doc: pytest: Document the test_bootstage test
       doc: pytest: Document the test_efi_loader test
       doc: pytest: Document the test_bind test
       doc: pytest: Document the test_bootmenu test
       doc: pytest: Document the test_button test

Vincent Stehl=C3=A9 (1):
       cmd: nvedit: fix efi env -e -i command help

  .azure-pipelines.yml                             |   2 +-
  .gitlab-ci.yml                                   |   2 +-
  Makefile                                         |   3 +-
  cmd/nvedit.c                                     |   2 +-
  cmd/nvedit_efi.c                                 |   2 +-
  doc/conf.py                                      |   8 +-
  doc/develop/bootstd/qfw.rst                      |   2 +-
  doc/develop/ci_testing.rst                       |   2 +-
  doc/develop/index.rst                            |   2 +-
  doc/develop/pytest/index.rst                     |  27 ++++
  doc/develop/pytest/test_000_version.rst          |   8 +
  doc/develop/pytest/test_bind.rst                 |   8 +
  doc/develop/pytest/test_bootmenu.rst             |   8 +
  doc/develop/pytest/test_bootstage.rst            |   8 +
  doc/develop/pytest/test_button.rst               |   8 +
  doc/develop/pytest/test_efi_loader.rst           |   8 +
  doc/develop/pytest/test_net.rst                  |   8 +
  doc/develop/pytest/test_net_boot.rst             |   8 +
  doc/develop/{py_testing.rst =3D> pytest/usage.rst} |  12 +-
  doc/develop/testing.rst                          |   4 +-
  doc/develop/tests_writing.rst                    |   2 +-
  doc/sphinx/requirements.txt                      |   1 +
  doc/usage/semihosting.rst                        |  21 +--
  lib/efi_loader/dtbdump.c                         |  86 +++++++++--
  scripts/Makefile.lib                             |   2 +-
  test/py/tests/test_000_version.py                |  10 +-
  test/py/tests/test_bind.py                       |  12 ++
  test/py/tests/test_bootmenu.py                   |   4 +-
  test/py/tests/test_bootstage.py                  |  35 ++++-
  test/py/tests/test_button.py                     |   2 +
  test/py/tests/test_efi_fit.py                    | 156=20
++++++++++++++++----
  test/py/tests/test_efi_loader.py                 |  87 +++++------
  test/py/tests/test_net.py                        | 152 +++++++++--------=
=2D-
  test/py/tests/test_net_boot.py                   | 177=20
+++++++++++++----------
  34 files changed, 608 insertions(+), 271 deletions(-)
  create mode 100644 doc/develop/pytest/index.rst
  create mode 100644 doc/develop/pytest/test_000_version.rst
  create mode 100644 doc/develop/pytest/test_bind.rst
  create mode 100644 doc/develop/pytest/test_bootmenu.rst
  create mode 100644 doc/develop/pytest/test_bootstage.rst
  create mode 100644 doc/develop/pytest/test_button.rst
  create mode 100644 doc/develop/pytest/test_efi_loader.rst
  create mode 100644 doc/develop/pytest/test_net.rst
  create mode 100644 doc/develop/pytest/test_net_boot.rst
  rename doc/develop/{py_testing.rst =3D> pytest/usage.rst} (98%)

