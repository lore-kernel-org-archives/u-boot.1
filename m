Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 287CDC27C53
	for <u-boot@archiver.kernel.org>; Sat, 22 Jun 2024 16:46:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 894D88803E;
	Sat, 22 Jun 2024 18:46:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="MpNukfOV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27C0B881A1; Sat, 22 Jun 2024 18:46:19 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E03ED87A09
 for <u-boot@lists.denx.de>; Sat, 22 Jun 2024 18:46:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1719074776; x=1719679576; i=xypron.glpk@gmx.de;
 bh=ZC6P5B6vldrpelVeWqX9oh3VX28Dv5yDzd91VZCAVKc=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
 Subject:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=MpNukfOVNPVpSOXL1rKrp05ti1DWK072s9mOZsdMC9MZds0vCbWaPkJSwYstWe5V
 BUdi0a5ZVnp1/f7DQnjD3uq2yaBDOi8SoS1UJz9oBnJWvyxxGCNe7cqtJfRGlmcW7
 xU7q5GviyBy7W7azHYrseRCb8WXBbZCkfzL7/5tipjDA9Vz7ZUkBngaNy0ZIYCEtY
 G6x1fKk4xj5JbhuC8dE0+s+yXlgsG9/kblWczcxYsf2CWLN/xtOOnRUJHVug77T+a
 y59kXgv/8jPwW6oRWlK+Z9wQTjhSmIRXbTHx2ZIA44rsmOPI7FhvUDxHO+A8Y3Mtt
 3aHky+V46m4qYyqy5w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.126] ([178.202.41.25]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MUXtY-1ruYmV3WKW-00Q6XT; Sat, 22
 Jun 2024 18:46:15 +0200
Message-ID: <35bcd226-5ab9-490f-8a7c-e190aea647dc@gmx.de>
Date: Sat, 22 Jun 2024 18:46:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Pull request doc-2024-07-rc5-2
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wXsZoSmhGamft2HKSZu8F1Zup5cZ81K1m1kMMmb3mwcQkkBDcbg
 vBa79xIz8+e0yaDL0Be+fMD3to3b6Ld8C/ZzYMnYd+6CnPohvECbz6rOSXxhAhO+oM9SNv5
 P3Xg5ZS0SKi0zSodwWqHgsWSWwfFO45O46Qbr76euSq8qEzfQ6Ymkg1pjIvLKnUhmmy+5cn
 f+4gKDVczoP/68aI6PoIQ==
UI-OutboundReport: notjunk:1;M01:P0:Zcxned1d1f4=;01IHp7to6jGe2t1XX/upLtD8/Je
 AvDVCGwr+p3TpGNnY3YahQZTODsoJzCqpdAyz823UT1u7EpuHEqo1DoCWvu21BQPpv0Bqop8x
 tPeSiq8r96uI2mogRt58JwAWPSHJ2+H+LM7jfbZrMGassgJzVwYcw+lRCieZ1zmj9W1nUszRY
 aPsFKokW56Q5e9BTrcWt5EnmmGsJ+dcycH3wo8AJ3+mHqM7wEhp2w+XMFfkdoG3aGGdUscu8o
 xu9Vp1KOIgjgbhsyHGwpI4KdNl7HrEu7p2DJwYO66EeQWqPCJsosdFgnYs7tAg4bH2QDeLnLx
 RezhPd4wt89TKRp6T/ySrsXJpZxnk1g+OmJVJztrJoJAp7n4xS8R7ONi7GdMY5DkeqKGgYh6V
 suBD/dV3l7KdVWTZMk25LUTVzxpL992/gJX9z50g55wV+EOe1HjQlwmaCe+nVIKKvm3ZbUy67
 uqdDpNQqGCx98vPudKM06/xVGmuKdxzbDuag3o85nzZy4J/3QYMZpwuFlUsktcRm52FyBo0XF
 Z6z55THl/FidMbtPFgkmLaGF8yJhXYjkJsf3LM6JIFxyxu2iqKc9avnSPvtUCQx3DnuVMeFPV
 fdugjyqZYjLTXbCWL9mqluH9LlDVs0lu8rbjq5cKzrIJPCCKyzUpXItuxXUb9IgqRUcg0SgMv
 +mh6OFIQtvkJ0mC9+vL17LxzkDycK6lBT5bUDhjuwoM63So8iga/7n4Ta5j59D4c9pQvXf3Xi
 cuENSpM8R0IMAw6BJiIFIplQos2Jtm2yMmMXoIYH9kyQK5NL38xXEgQnt8DlCdFNgBqO0KwV5
 X/A2+Yr1myYrYQRnYTulXginkDXM+rxPNrFYUasXoU3bA=
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

The following changes since commit fe2ce09a0753634543c32cafe85eb87a625f76c=
a:

   Merge branch 'master' of
https://source.denx.de/u-boot/custodians/u-boot-watchdog (2024-06-18
08:34:56 -0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-efi.git
tags/doc-2024-07-rc5-2

for you to fetch changes up to 271ca9ef8a37b8668b9858638175ac2da5c152df:

   doc: board: ti: Add capsule documentation for TI K3 devices
(2024-06-22 17:04:19 +0200)

Gitlab CI showed no issues:
https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/21289

=2D---------------------------------------------------------------
Pull request doc-2024-07-rc5-2

Documentation:

* Fix broken references to pytest suite and test writing
* Fix links to FIT documentation
* Add capsule documentation for TI K3 devices

=2D---------------------------------------------------------------
Alexander Dahl (2):
       doc: develop: testing: Fix broken reference to pytest suite help
       doc: develop: testing: Fix reference to test writing section

Heinrich Schuchardt (3):
       cmd: link to doc/usage/fit/x86-fit-boot.rst
       doc: FIT links in develop/uefi/uefi.rst
       boot: links to FIT documentation in Kconfig

Jonathan Humphreys (1):
       doc: board: ti: Add capsule documentation for TI K3 devices

  boot/Kconfig              |  6 +++---
  cmd/Kconfig               |  2 +-
  doc/board/ti/k3.rst       | 29 +++++++++++++++++++++++++++++
  doc/develop/testing.rst   |  4 ++--
  doc/develop/uefi/uefi.rst |  4 ++--
  5 files changed, 37 insertions(+), 8 deletions(-)
