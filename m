Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BC57C282EC
	for <u-boot@archiver.kernel.org>; Mon, 17 Mar 2025 10:45:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7127880107;
	Mon, 17 Mar 2025 11:45:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="XuVDduTa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8990180F4C; Mon, 17 Mar 2025 11:45:29 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C141800C2
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 11:45:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1742208326; x=1742813126; i=xypron.glpk@gmx.de;
 bh=bQJC7IXCkPPnRUUHkrG5WfWlUVHzT1rj9LrRfgLyKr8=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
 Subject:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=XuVDduTaoV+kCb/WhXLA6APBNbePn0ziPqkqgGPWgWLDzMuLA6cDmxzCBeQxduli
 vAxtwk2m7ePtMszh3CoaS57KyMiSvwJG5ss0KLv5zS8jlHg5gaCZlB2wxE1XJLv/J
 FFUkOIs+bqYlvZnbvOxtEvWXIueMNDWv0+AiHkOfAXGjDemrmh6VnARIDr5CCLGzq
 retkC2mPOSh2VoYyCcDJ09D9FLzPXc0FypG/kQZx64EaWTEmnqNmXc6JCmAkHrFM0
 JZ9WLt0sVqWf7cyi03gs92ShYIsnwS52og4Fz5K4vGhtVTO4Xp7NK8rrouzngPft4
 dnwbOvNxP9YMmUzt+g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.102] ([5.147.80.91]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MFsZ3-1tyjt33Tn5-009zxl; Mon, 17
 Mar 2025 11:45:26 +0100
Message-ID: <18d91439-12ba-41dc-8cc1-763486cf5143@gmx.de>
Date: Mon, 17 Mar 2025 11:45:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Marek Vasut <marex@denx.de>,
 Sam Edwards <cfsworks@gmail.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Pull request efi-2025-04-rc5
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:T/nTJh2wx3/cdL+EVg+YuMe6F3Fj1P7bQSXDImHpRqU/pFvsqy1
 /jqdSYDfaB6hE5TG6YyNDd4YVAKb77weh1H7LP+atPBwA9l2T469ttAVkuAd0TI5w9Km5DL
 qSgrXNrMqFYvGoYtDHbMiO6AeX4T6jeTN8PAaHR4CakySziAx2KUSGUsDyEgbUh3LOJpgNy
 DmdNueltXPQ/dUlDYDEng==
UI-OutboundReport: notjunk:1;M01:P0:5W2W0zpCsx0=;QW06VXYaqZB7z1nbwXd6TVT/yMx
 mrtxPAZAys5dX+/nQQIjW7gZakifDXHNB90bcqdoPik2Ic9pUhMUo3kdCYESTWoylMowxxGYv
 BgncpMrdYymYkwLEj3LuiWLxee4vHLtr8xFON3SVjKnomj/YsW6iJBksUh0fg10EXL1HUMjcL
 25/18PjMdRwcw3VTFALQ90MgzqDxFPy52xcxQAKUSi0QTrv5J4x5xFrBifzxuoDtXCI3Yewdq
 SXHdiZEhAc7ppHKmSabyzzac0qKDo35lMXLw3y5tLlRRafbkVgNwdDdya4JFZFdlZqP/aqt0B
 dR7ChHxIJOOrGsOdRlvbS58CgNN8oX2dyYSp4k1rKYKd9nfcYeUg+KWj9HUiV5sO5l+TFmWXQ
 FlcV0agW9BfF3mUGvVpVLa21lLj740MCWDQ4RKlZwkTlmOY5RC3WjpLEqDYzhi70RALgS9N/O
 3Qvq8RsIKFIqlRA5SS8qnAiuZ+q1gLAsjrDCN2ySeLIPMYchu8o7VVRHEFTtvLisJju9yf+he
 kQ9QHN99gb8UjjLJb3DKiImEdQeBFgH+T0bWW+OxTcdSkx8oyy6jyiq0O+kYo1cwBcXxcYlWi
 Z8WyqddGUx0fN3SK2Z0oKibSSHKbTXcnDzkuSLpHO03Eh92dbwohqEtI2sIPoN6v+qTj2PopN
 TUbzY8TLnBR37D8ieMu8lUBzmSIy39OVIvqF4I13bRceCV8niw3XehjpnZ56k/U4xqyMwcXXv
 OWg1zqPl/qoX0eK7CAZ5Y5vzs9dLW/XHN61N4uKVIhSjiAdLRIPdSMtcYp5z+avHccFvB9ozQ
 dVgwdkQcQuvcvAiFh3FDjMmaGNf4If3KaooIij8uKnyDnjD3onzX5ipy8u5GOfuY4mlgYuVf8
 ELwGb9V2RYQBHApnb07BvBG7svtPof76doTZlcIjC820UYBqn8yea9JldwXe8MA4UnnpM2PvK
 GSpcs5mlHL9iyVRaLsKqDRJUK6zXwpOWa2KTiRnBFdEINBu5TRsjVgEqmkzTXoLoW6lbwwFf6
 gmfUgNOp/KhNNpduAyegPXrV69E60nRNa14plRFHLhKJE5+GNrm8EzRphdAc/JKQ3GCBsesIP
 /HagwrT3HblXH8lkPddRPDmFoQ8k0Y0Gy9TpmZ0dm31yamnbLBpGozISpGE+sQOqZyrUXjnnz
 6gOCtx4ShDkFRAvXZbMNiELhmFVr7GgHCzypA4SSIUtauwiL3azuCx2wkkNZHQLf4g38oS+4I
 CIiSrGXnLML6NZi40BDL0tW4qDTSDK5ocKHhhpZtyfm4EvQK4whqt7Nj6bsH9SQNFkEP1C667
 sTbVQD3+qukTWD4j+pDUMth3838JvYFOgkWm3mPj/tcwnGiwHBLYeerU96c/2jpHkDK/lGwr2
 /KNnsQbBpE+UlGYIt4HGbC+q5UaL8Nm/uyN1NXQofiQO8rorTPiZ0xkH9aeZKQ5psYjDHz8PY
 wr+yyBd9Z0j1fXshqsCmTruHKd+E=
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

The following changes since commit 15d6518c942f0da13f9a7ceeadbd925c3317ec8=
d:

   ARM: dts: imx: Drop bogus regulator extras on DH i.MX6 DHCOM DRC02
(2025-03-13 15:22:48 -0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-efi.git
tags/efi-2025-04-rc5

for you to fetch changes up to 7f2fe3dda4ea5384eac4afadb8a4fe5d695e2ce1:

   scripts/Makefile.lib: efi: Preserve the .dynstr section as well
(2025-03-17 09:35:52 +0100)

Gitlab CI showed no issues:
https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/25196

=2D---------------------------------------------------------------
Pull request efi-2025-04-rc5

UEFI:

* Export _start symbol from crt0_*_efi stubs
* Move .dynamic out of .text in EFI
* scripts/Makefile.lib: Preserve the .dynstr section as well

Documentation:

* net: miiphybb: Convert documentation to rst

=2D---------------------------------------------------------------
Marek Vasut (1):
       net: miiphybb: Convert documentation to rst

Sam Edwards (3):
       arm: riscv: efi: Export _start symbol from crt0_*_efi stubs
       efi_loader: Move .dynamic out of .text in EFI
       scripts/Makefile.lib: efi: Preserve the .dynstr section as well

  arch/arm/lib/crt0_aarch64_efi.S |  1 +
  arch/arm/lib/crt0_arm_efi.S     |  1 +
  arch/riscv/lib/crt0_riscv_efi.S |  1 +
  doc/README.bitbangMII           | 39 ---------------------
  doc/develop/bitbangmii.rst      | 75
+++++++++++++++++++++++++++++++++++++++++
  doc/develop/index.rst           |  1 +
  lib/efi_loader/elf_efi.ldsi     |  6 ++--
  scripts/Makefile.lib            |  4 +--
  8 files changed, 84 insertions(+), 44 deletions(-)
  delete mode 100644 doc/README.bitbangMII
  create mode 100644 doc/develop/bitbangmii.rst
