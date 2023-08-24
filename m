Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F4BEC83003
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 21:53:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AEA8886977;
	Thu, 24 Aug 2023 23:53:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=web.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=jan.kiszka@web.de header.b="mxSk8Aty";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F42086986; Thu, 24 Aug 2023 23:53:28 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDE0586532
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 23:53:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=web.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1692913999; x=1693518799; i=jan.kiszka@web.de;
 bh=2R/h4/Rp4fsCqk//Ay5tqXNQsRcKXnJVoe4DqQcjYhc=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=mxSk8Aty1fkzvJlAJBjaGh2LeoYTK5afs44k+0H+QdhVueWnGq6/7K7c3mV6lw8Z8TzW6Pz
 fKHVrjWAxOksusbb/rT4/sG2AX+zxbKcjaNpBg7R6i4aCQqF79xRvFe1cqCicvubKliRIg1Th
 TBEbFXhOzGkWqnr2P7FpMwt94kCgLEDGacuYncbtEAqXIEv7J9JPyFTIUIHoW2BqtohdDfTBx
 QX1ksPcTvpidGvEO56wIF3fOcM055a2xYHxDLxYBLS4oxRbnROpuJ9EX/PJxk/IBZzo4YWtfD
 sBWOvluBZ+ltc7oD3rQg954Jf9VHTc0BzLGtpwUyz5h1sSHINI5A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.20] ([88.71.58.97]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MCoku-1qQWq71Rui-009CK1; Thu, 24
 Aug 2023 23:53:19 +0200
Message-ID: <c93b19ed-43fe-44a2-9726-371fb9d2f825@web.de>
Date: Thu, 24 Aug 2023 23:53:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH] board: ti: am62x: beagleplay: Disable semi-functional PSCI
 reset support
Content-Language: en-US
To: Nishanth Menon <nm@ti.com>, Neha Francis <n-francis@ti.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@google.com>
Cc: Bryan <bb@ti.com>, Praneeth <praneeth@ti.com>, Andrew <afd@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>, Vignesh <vigneshr@ti.com>,
 u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@baylibre.com>
References: <20230824031101.3460411-1-nm@ti.com>
 <20230824031101.3460411-17-nm@ti.com>
From: Jan Kiszka <jan.kiszka@web.de>
In-Reply-To: <20230824031101.3460411-17-nm@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WBWfnX6vZ4I1COz048IEnPWqpehiyA7R6yobb9GKh3IH4kQCx1P
 IHQhhTvqzTSbetPQWOAudQj6Wk6oQJ+WDk3u0hYHUpMNiPa/q6c30O5mgtlpsHgWb3jLVuS
 tQzw7IAJmmlPCh69bvE8bhttHt6izwoJO/ywLKc9g829rJyH5kvbWefP9v4qfn2fxDS5qw/
 +vMY72jpn8NW3WVmy6dmw==
UI-OutboundReport: notjunk:1;M01:P0:PIvZNFEL7Ck=;XaD+GDk8/FIoq0J5M/cW4mMr7ua
 V6p0vdeYiwNiNENDbuu/K02A1DBDlA65fhO0tLbXhDxedDjNGy1xDrzd1n3aNSgcOr0ZJTIIJ
 JptCRntTkZSUKkiosZyLw1nCyUsOnEeO9Vpo/ula+Leb+gWPToauBuLc6l5xIYFb3Jxdl2IU9
 PibedFQ9C9q86ooujtX92CM27fmMmDBypd5jLx0r3df7m5cfxGok2smo7DinpZWjrOMs71acS
 JVL5S/6Nubmwf56l+q+6igDqvoyG0wmXtRBtEBd+s9x+qeBIfCXDfiZK0FQ6HxnOAAcoUVPpl
 gP2wWeqei8E6qfu+SYhGb+BoDsWhnjwa6sF3ixfNsi3C16LiXv/7lcf/RrZCY1CDIucjRv+pM
 OdBsc5f47UYWUuLaZ2zlI7S2adlEnjYdhzTV+rUwX/TzY7NHyxN7i2brTowq1HS3EtHQ9qpTN
 VpmpZYAePPn6DnJkYTznhCk2s2OyCc+bW94Oq4idUzUlVS17ZCMdh16MMDSieQOZCrZcyWfdL
 RFRXPYsAKgKCEvyv0a7lrCs7HAqJcGtzbWBR78EaK7mo+HUWV2io+GL4cJhJXMfyjzwPWVT3f
 SSLAgDExRd4a83b6iJgjyRZ4bVjf8Iu7ORrlZiBxOvG177AsrLoKkp049AW+7W6x/CZxjqgo6
 B4ayFazg0NOhEK8xkFekOXhfzR3xZLqN3kZYB9PXSI/G0RKCpIq5vV9lC4g9Mdm493dwrRF3a
 nWNrPFXEbSdBXe0eioG0qsYX3Cq9zzE5kAgeysm1oCUWDKz7o6pskhFJafypC0od/bLUsm5oc
 O2ftwryrKxI7mYtySvZs437vwtECW5JkCWrkQj7BE4gfRxFhxvdrKev28ABjjJGAreuf9+Url
 lzWWZii3GoidfCHqh5lS1JgpTxe37NmpL+uxJG5lSoiF9iYkNK41sAfnbJ8JJijeCmAIcQFT7
 VLAbzg==
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

From: Jan Kiszka <jan.kiszka@siemens.com>

At this point, system shutdown is not supported by the DM firmware that
TF-A calls. As we can't de-select only this feature, declare complete
PSCI reset support as non-functional so that we don't signal incomplete
support to the OS via EFI runtime services. This makes power-off under
Linux work again when booting via EFI.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
=2D--
 board/ti/am62x/beagleplay_a53.config | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/board/ti/am62x/beagleplay_a53.config b/board/ti/am62x/beaglep=
lay_a53.config
index 967f794446d..8b0f671bc9e 100644
=2D-- a/board/ti/am62x/beagleplay_a53.config
+++ b/board/ti/am62x/beagleplay_a53.config
@@ -53,3 +53,5 @@ CONFIG_SPI=3Dn
 CONFIG_SPI_FLASH=3Dn
 CONFIG_SPL_DM_SPI_FLASH=3Dn
 CONFIG_SPL_SPI_FLASH_SUPPORT=3Dn
+# DM firmware lacks support for shutdown
+# CONFIG_PSCI_RESET is not set
=2D-
2.35.3
