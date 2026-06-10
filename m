Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA315CD8CB9
	for <u-boot@archiver.kernel.org>; Wed, 10 Jun 2026 10:53:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F44D84894;
	Wed, 10 Jun 2026 12:52:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=siemens.com header.i=ludwig.nussel@siemens.com header.b="NUjv6G+8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CAAE684894; Wed, 10 Jun 2026 12:52:56 +0200 (CEST)
Received: from mta-65-227.siemens.flowmailer.net
 (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A33D284843
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 12:52:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ludwig.nussel@siemens.com
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id
 20260610105249a047123170000207de for <u-boot@lists.denx.de>;
 Wed, 10 Jun 2026 12:52:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=ludwig.nussel@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=ELt1kSptxMTg19B5UG7udL5XiTZJxtUKNwVgvn4MPNg=;
 b=NUjv6G+8OfhbKH+IUUD2w3x1Bfvd8TEv6dO8XRwroAyxXwAIHdctucP5nJMG1BMPdmIE4O
 R5ZpYJCdl6L8mMjhGOtVY8scI4vxnUCrDRiq9hPNfQhC8scHE44LIwDkEPzfDFpIu5RrhZ62
 ZsJ2sM/EQJC7LmAFMABYyA8UDW/E5QxfmpR+ODYhiKIGXPLiiEF1fc/386UrHyYnXEZifFw6
 Nd2GBppSQefr1HOgMcR5ZUAuRhlWDNHFiuM5YKqWVf+fdNpwaSJglwcH8agAwky3UT9ovEls
 CvSBbOGzsIkthuzZWDwfDOZRYk5/tFSirnde6+3kqGbu9TXuxkppqcdA==;
From: Ludwig Nussel <ludwig.nussel@siemens.com>
To: u-boot@lists.denx.de
Cc: Ludwig Nussel <ludwig.nussel@siemens.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 David Lechner <dlechner@baylibre.com>, Heiko Schocher <hs@nabladev.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?UTF-8?q?Jo=C3=A3o=20Paulo=20Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 0/3] Improve U-Boot's TPM handling in the non-EFI case
Date: Wed, 10 Jun 2026 12:52:02 +0200
Message-ID: <20260610105243.193355-1-ludwig.nussel@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1328817:519-21489:flowmailer
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

U-Boot might be the first component to start the event log, eg when
used in qemu. So allocate and attach the TPM event log to the TPM
device if not initialized yet. The address is copied into the device
tree for the kernel so the event log is accessible from Linux
userspace too.

Changes in v2:
- fix return value handling
- imply DEVRES in config TPM
- use fdt_getprop for reading property
- don't wrap #include in #if
- fix memory leak in error case of tcg2_log_prepare_buffer
- handle NULL elog parameter in tcg2_measurement_term
- use CONFIG_TPM2_EVENT_LOG_SIZE
- pass log_size instead of position in dt

Ludwig Nussel (3):
  test: include mapmem.h explicitly
  tpm: print all PCRs from pcr_read
  tpm: allocate tpm event log if missing

 boot/bootm.c            |  18 +++---
 boot/image-fdt.c        |  69 +++++++++++++++++++++
 cmd/tpm-v2.c            |  69 +++++++++++++++------
 include/tpm-common.h    |   2 +
 include/tpm_tcg2.h      |   9 +--
 lib/Kconfig             |   1 +
 lib/tpm_tcg2.c          | 130 ++++++++++++++++++++++++++++++++--------
 test/boot/measurement.c |   1 +
 8 files changed, 239 insertions(+), 60 deletions(-)

-- 
2.43.0

base-commit: 888a0e381cc76b1af4d2fb6308a5b257a9625a21
branch: us-tpm2
