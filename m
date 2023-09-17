Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51E0DC2BA1B
	for <u-boot@archiver.kernel.org>; Sun, 17 Sep 2023 00:14:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 921D786177;
	Sun, 17 Sep 2023 02:14:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="j1e7u0jD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F5248619A; Sun, 17 Sep 2023 02:14:12 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 17BFC85894
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 02:14:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1694909647; x=1695514447; i=xypron.glpk@gmx.de;
 bh=9hBvqbRi/xErzWhCcM3Vf8Hm11R4NLsjs+NHICid9AI=;
 h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
 b=j1e7u0jDZPvaaB/C7zQY8/c/gXmqpfNrGpHVs0iEFQVKU8vUeQ33kBdXGQYp8HxRXxOOTqooTtJ
 BzIw+xMBBS9TtkFWyB1a1Q4tI1H3DXvj7ZVltHgZuZ8ajnZbwdZPjsbJwiQMwvtSD/2jcdJXhFaLd
 SQ5NUAz9aFdMbx9cOjQi0QNpQrZ8S5di190aqo/XdONN7I8KntkEaN6fH1o8qivXyUmGOYE3QvEtn
 /qO8elopFUIoLEHmwkjbLxUZy7+3KcVNPjNsOZgq8RMJahIzx3wetwasky8RRzj24JvYmZIaJblPY
 pKhHm/BW9VP02DMOBwxxEAeRgYuqQFsFXa8A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([178.202.40.247]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MIwz4-1r0rET3Cg6-00KROM; Sun, 17
 Sep 2023 02:14:07 +0200
Message-ID: <64659cb4-8018-498c-b41b-e838877f62ab@gmx.de>
Date: Sun, 17 Sep 2023 02:14:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US, de-DE
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Jaewon Jung <jaewon8868@gmail.com>,
 Massimo Pegorer <massimo.pegorer+oss@gmail.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Pull request doc-2023-10-rc5-2
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PAFp5egR1qfLYdPzTmVA9D5Ix1zxnYx2tWjQRmBAR3nGt5CCcln
 tCQMTF04RfDPBYKRkLuFXtpjy/EqwPLG8/jNTHTmQKEyCCXC7Tk2zyPpk6ZC9IcVRDCE/cq
 /xe5Eh3wAD/tlm3FKa/SSfkqrdRsv9J4NIrTdCjgCBiWDROlZZ+8sSWWT2bhkykdNnwdb+v
 PQTkEVdAIlDkB9AMHPFmw==
UI-OutboundReport: notjunk:1;M01:P0:mJFNSB/HoPw=;CiKMBTyXI0q9JaMYmmMccpPw5p8
 xU5wzOtugKXDZtqqMTZlWut2eNmIbWpBbgw3yelNHtSsIbZ3mIOY0Gf5iYAbRUCz3sFASHm3R
 Hm2w9hWVJRXnczVfqT594m5pflnDhuqAeVFFyqpWErDmNznXgjrKY98q6TfILEGZ4fe31Cj5x
 +AOeJKaHv/Fvnyfgd6RVXrYdlcCs9J/w01SD1KJ7PK9CJkBlhzwD3NuiJoL+YodHCw2PscWmt
 qrWSTZVmgEGe3cMK5wlNi6l0cf7KAXfJiDiEah9vnhHWpzEU35gMoVYQ5pxr3BxE6SbJp5TEI
 RD1BvbYipcczL7rvHoevj4ES2rAEx2mMEggyum+pGnCptJUjB1MTRKLmxDq7Kcgtwf2lSIF+2
 y3q7ef0hkLlVWk9ZvVmDJ437eTtuiofCRUrEeQftRE5GVGuW4+4uML8eb5Rzy1YxC1IyztCQH
 T9Ss6id/3IvbyGTMP9gYpW5pklDFzo/GFCglghWhPZsQVKpkUqT7y88h4DPIVNGvlzsVz0/Ik
 zbbPOsHqnC6PbanXBz9i+gnk4fmHFa4pZsih75rDWbjq7KqHuGyB/cS7E+0/iacaAhfMc0vop
 Xpn39Uf5//PVcb0hkW7rFy6wPwHKqYD1HpxEAmc+Xk3ysihPn9i7/OhEY+xykrQKptzyaK6cw
 mqyUJPKOah98KiqxtH+m09PA9qq+jHyOvS58jDcCaaUcaLBrns48mvMYkKM6wWjTfa7cvQdcT
 iVKSlXEetdhlOe7b8PFHWN8fvDewxp8jAxhlfxMoDGRETmfB5yvkByuz22/TRQqlvgdnaKsFy
 qz6qwh8YO78r4Vcjj62vZ8hDyGQ8oMGERdR+82yJE2S1JOYVUN9YZ0Lrd8BrbpBJ6IYCNXloD
 4DFBS8IixlMiOi7qb8oR594eg8T1Vgh+0hcKFlEzAPaqCQ8qTUAYyEldHQxq2208g7E+BwQVj
 rmtJ1OV65Hx1cDVKAAfiYFx1FJg=
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

The following changes since commit 252592214f79d8206c3cf0056a8827a0010214e=
0:

   Merge tag 'doc-2023-10-rc5' of
https://source.denx.de/u-boot/custodians/u-boot-efi (2023-09-09 09:33:02
-0400)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-efi.git
tags/doc-2023-10-rc5-2

for you to fetch changes up to 8bd7d08407f986fe3c69f3e198f6f7152e12dea8:

   binman: doc: fix reference tag placement for Logging section
(2023-09-16 18:17:25 +0200)

Gitlab CI showed no issues:
https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/17746

=2D---------------------------------------------------------------
Pull request doc-2023-10-rc5-2

Documentation:

* fix code comments referring to doc/develop/expo.rst
* remove unused values from Chromebook kernel command line
* correct reference tag placement in tools/binman/binman.rst

Others:

* test: fix build dependency for event unit tests

=2D---------------------------------------------------------------
Heinrich Schuchardt (1):
       test: build dependency for event unit tests

Jaewon Jung (1):
       doc: delete unused values kernel command line

Massimo Pegorer (2):
       expo: Fix documentation reference
       binman: doc: fix reference tag placement for Logging section

  boot/expo_build.c                     | 6 +++---
  doc/board/google/chromebook_coral.rst | 4 ++--
  doc/usage/cmd/bootflow.rst            | 4 ++--
  include/expo.h                        | 2 +-
  test/common/Makefile                  | 2 +-
  tools/binman/binman.rst               | 2 +-
  6 files changed, 10 insertions(+), 10 deletions(-)
