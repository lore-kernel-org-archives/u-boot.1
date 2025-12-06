Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B95A9D3B7D2
	for <u-boot@archiver.kernel.org>; Sat,  6 Dec 2025 13:35:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBB30839E2;
	Sat,  6 Dec 2025 14:35:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="j1mSv0pQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B86B839E4; Sat,  6 Dec 2025 14:35:51 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29C9F839DF
 for <u-boot@lists.denx.de>; Sat,  6 Dec 2025 14:35:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1765028146; x=1765632946; i=xypron.glpk@gmx.de;
 bh=qQ+xUncC8YRHVauV+yWZYSooPalKNOY2+SfW7Z76mTE=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:Subject:To:
 Cc:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=j1mSv0pQ2byQlxGBjoCYIycyqcJ9FvnZRSdEWXc/OIDGeadlnT7ig1sJoY3Af/Fb
 9HU2tAJLs0cT/kkAakZYXOsq1KB/cPw6FaaBxzBP7dqZ41Cvhk2pu6eSEVI/nzjHv
 XuwfTIjtoux/XsAT0z8Ch52XZdyw2vROIT3Bm1r+JQ5COblUICez/1P55RpfTvI2s
 BxKhWd9yuBwh+8kvacw/W8qiH4piKy4cEdyQvMrCHDed/bpSmVMkVMpVlj4VjiOlM
 r6oO58ZMIlBqGfSuPu3QCABxB9mMcXNu8YK2480DMgy5k1uyNLlAjTleHfEAsCugW
 kMh+6hOMNC9Bm1MDXA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.154] ([5.147.80.91]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mk0Ne-1vuaUL3mCO-00aZDi; Sat, 06
 Dec 2025 14:35:45 +0100
Message-ID: <f2df6326-f97c-4081-b862-eda657e50ce0@gmx.de>
Date: Sat, 6 Dec 2025 14:35:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Pull request efi-2026-01-rc4 for master branch
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 David Lechner <dlechner@baylibre.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uGL0LVpkkbuMLt1k2kVE9h8TN/cMhQLQKoZT33AYXAUQcg4uEeH
 kRj2O38I3Cq07ONctW5zW8htNX3I/qXkdZ8kl8mpnJNnX43TxZyIBOg6GOzpeAAEmBT6jwd
 cdqWOO0U0sGSQcidoXGD7VjoH3ho060b6C/CI2x7TizEZq1z173yKE8o78uWQu/67DXNWa3
 X3MCAw7caJs3Z81pCYwaA==
UI-OutboundReport: notjunk:1;M01:P0:ycvACHh9+iA=;aii8ktQf4oNW76Ik5EvCQPSdpjA
 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
 EpyHymic=
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

The following changes since commit c98b6a6dcd1fc7bcba081fc2353954e33de5053=
c:

   clk: Remove myself as a maintainer (2025-12-04 13:45:30 -0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-efi.git=20
tags/efi-2026-01-rc4

for you to fetch changes up to e5996e3ed350598c79cd7afaf6d4f0618598e390:

   doc: board: verdin-am62p: Fix boot log output (2025-12-06 12:04:57 +010=
0)

Gitlab CI shows no issues:
https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/28652

=2D---------------------------------------------------------------
Pull request efi-2026-01-rc4

Documentation:

* Correct and add missing pytest hook script environment variable names
* board: verdin-am62p: Fix boot log output
* Add a page for downloading the U-Boot logo with and without text

UEFI:

* Fix a memory leak when retrieving device paths from boot vars

=2D---------------------------------------------------------------
David Lechner (2):
       doc: pytest: fix hook script environment variable names
       doc: pytest: add missing hook script env vars

Francesco Dolcini (1):
       doc: board: verdin-am62p: Fix boot log output

Heinrich Schuchardt (2):
       tools/logos: Add U-Boot logo with text 'U-Boot'
       doc: add a page for downloading the U-Boot logo

Ilias Apalodimas (1):
       efi_loader: Fix a memory leak when retrieving device paths from=20
boot vars

  doc/board/toradex/verdin-am62p.rst    | 135 ++++++++--------
  doc/develop/pytest/usage.rst          |  16 +-
  doc/learn/index.rst                   |   1 +
  doc/learn/logo.rst                    |  20 +++
  lib/efi_loader/efi_capsule.c          |  34 +----
  tools/logos/u-boot_logo_with_text.svg | 280=20
++++++++++++++++++++++++++++++++++
  6 files changed, 383 insertions(+), 103 deletions(-)
  create mode 100644 doc/learn/logo.rst
  create mode 100644 tools/logos/u-boot_logo_with_text.svg
