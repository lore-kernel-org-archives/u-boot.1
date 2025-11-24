Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E55D4CFA466
	for <u-boot@archiver.kernel.org>; Mon, 24 Nov 2025 07:57:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE21683D00;
	Mon, 24 Nov 2025 08:57:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="oh3F6ezi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A161283D03; Mon, 24 Nov 2025 08:57:35 +0100 (CET)
Received: from mx-relay28-hz2.antispameurope.com
 (mx-relay28-hz2.antispameurope.com [94.100.136.228])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3098983BCF
 for <u-boot@lists.denx.de>; Mon, 24 Nov 2025 08:57:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=0416cdc3b4=max.merchel@ew.tq-group.com
ARC-Authentication-Results: i=1; mx-gate28-hz2.hornetsecurity.com 1; spf=pass
 reason=mailfrom (ip=94.100.132.6,
 headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com
 smtp.helo=hmail-p-smtp01-out03-hz1.hornetsecurity.com; dmarc=pass
 header.from=ew.tq-group.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=Fj4tmdCj55PUzujL/WNHKDVXKOJlVMOzMWUk/C6lDBQ=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1763971049;
 b=UZX0dRnVfqByeWJlcm+JEIR9m6pj6Pd7dTO81fiAL2vsh4+I2xd1nFlWZrP9iaIk5Vf2umd+
 /de7PE9/RYZEJFGalFRxcwQiLkogAbwknYWn2ijeo1NtElQVe3CuM3aQqI+1dSoYIVftRXsl8un
 tPkHLidAYgk7G6YD1U+lacPhEFVlraEsaQNfU+KqBca6wh1WATwtLRw4fnInL+xw3/kNqwWdboB
 3+qGQtX/24RojLZ5ibshuuyUZlZ3BFDy5s/rYYQF8F8U0iik4UVUQQaxJq1I+rQRTYQ2EN0/LkF
 nGQ+Ebipa7i2xnAIReXBBU8sjbH7ae/QYJclNLj9xznwg==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1763971049;
 b=MaKdgvP+fxrbnqK5HoiRgNPSi55VwESEac/yaOv6/PqAydr6+P+d15xykDn9iwIMuvztMzcu
 gA9W1F3E0mALfgykMKNhnMeA66b33Pjon/0KTEktoY0xmrOMP4lm0L26xq3afs/6g6HvXO+SdAj
 3xncUwEUDS+Atw+z/F3LcECLZtKEuTwkAk4dXn9IO66LFzaGYOfyMfjA0dkdaOgBTYAzqQgYFQ+
 4n5TnBDnOhyP/RHnmhtZKk55VzV9gI3VmHWeswOqb4IGJsTkqzfuqr1WdjsbQJsTktE7AjGrsqJ
 lE3iqREZF6z9887UKI9BLKoU+x2UjeedaUKrxyVIiQNXQ==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by
 mx-relay28-hz2.antispameurope.com; Mon, 24 Nov 2025 08:57:29 +0100
Received: from merchelm-W2.tq-net.de
 (host-82-135-125-110.customer.m-online.net [82.135.125.110])
 (Authenticated sender: max.merchel@ew.tq-group.com)
 by hmail-p-smtp01-out03-hz1.hornetsecurity.com (Postfix) with ESMTPSA id
 61964CC0CB6; Mon, 24 Nov 2025 08:57:15 +0100 (CET)
From: Max Merchel <Max.Merchel@ew.tq-group.com>
To: Markus Niebel <Markus.Niebel@ew.tq-group.com>,
 Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@denx.de>
Cc: Max Merchel <Max.Merchel@ew.tq-group.com>, Stefan Roese <sr@denx.de>,
 u-boot@lists.denx.de, u-boot@ew.tq-group.com
Subject: [PATCH v2 0/4] board: tqma6: non-functional changes
Date: Mon, 24 Nov 2025 08:55:22 +0100
Message-ID: <20251124075540.14930-1-Max.Merchel@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-cloud-security-sender: max.merchel@ew.tq-group.com
X-cloud-security-recipient: u-boot@lists.denx.de
X-cloud-security-crypt: load encryption module
X-cloud-security-Mailarchiv: E-Mail archived for: max.merchel@ew.tq-group.com
X-cloud-security-Mailarchivtype: outbound
X-cloud-security-Virusscan: CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on
 mx-relay28-hz2.antispameurope.com with 4dFJ7v5tRwz1QD6Q
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1,
 IP=94.100.132.6
X-cloud-security-Digest: c4e2d7d8f63e2c4a6e0a16bf0e5e2b9a
X-cloud-security: scantime:2.000
DKIM-Signature: a=rsa-sha256;
 bh=Fj4tmdCj55PUzujL/WNHKDVXKOJlVMOzMWUk/C6lDBQ=; c=relaxed/relaxed;
 d=ew.tq-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1763971048; v=1;
 b=oh3F6ezirdmpTkpVRf4w8lENIZxpRSpSt4mGajKY/XNRuDlY/DVz5ZrwbD4IMpgrbuvufRBv
 hPgSyUl3Kkq9gK+bGON3TryaslnPiRhZBsNnbd2bf3euqnrfHcMirlq5S2zm1sUyVa3x1w7CyHB
 Fx/mwIB+91x6GWueSZ1NE6P0nXi/AQQqWf4t9JECj89dF8ZksKJbsrncMUtNkHiLMnvkFI+usVf
 WkV1YlN4sGsS1p+n6jiCh0p37E5S0OXbYMZCH1d0W7wEQR1RGIwjeQmqrMMqyVNg8at3EcPFuMu
 2Y8c3u/CXQ/GX0m5qYjknB5cI8KTOsNtah/6fwLPkaePQ==
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

Hi all,

this series brings non-functional changes to the TQMa6.

Best regards,
Max

---

changes v2:
  - changed only commit
    board: [cosmetic] tqma6: adjust SPDX tag
    - correct copyright year
    - add forgotten file: board/tq/tqma6/tqma6_bb.h

Max Merchel (3):
  tqma6: Remove empty function tqma6_iomuxc_spi()
  board: [cosmetic] tqma6: adjust SPDX tag
  board: tqma6: update MAINTAINERS

Paul Gerber (1):
  board: tqma6: style fixes

 board/tq/tqma6/Kconfig       | 23 +++++++++++++++--------
 board/tq/tqma6/MAINTAINERS   |  3 ++-
 board/tq/tqma6/Makefile      |  7 +++++--
 board/tq/tqma6/clocks.cfg    |  7 +++++--
 board/tq/tqma6/tqma6.c       | 16 +++++-----------
 board/tq/tqma6/tqma6_bb.h    |  7 ++++---
 board/tq/tqma6/tqma6_mba6.c  | 10 ++++++----
 board/tq/tqma6/tqma6_wru4.c  | 13 +++++--------
 board/tq/tqma6/tqma6dl.cfg   |  6 ++++--
 board/tq/tqma6/tqma6q.cfg    |  6 ++++--
 board/tq/tqma6/tqma6s.cfg    |  6 ++++--
 include/configs/tqma6.h      |  6 ++++--
 include/configs/tqma6_mba6.h |  6 ++++--
 include/configs/tqma6_wru4.h |  2 +-
 14 files changed, 68 insertions(+), 50 deletions(-)

-- 
2.43.0

