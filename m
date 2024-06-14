Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10FEFC27C75
	for <u-boot@archiver.kernel.org>; Fri, 14 Jun 2024 12:19:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79C5588047;
	Fri, 14 Jun 2024 14:19:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=jookia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=jookia.org header.i=@jookia.org header.b="pKnpBZWl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B664889C4; Fri, 14 Jun 2024 14:19:29 +0200 (CEST)
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com
 [91.218.175.179])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 715B388047
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 14:19:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=jookia.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=contact@jookia.org
X-Envelope-To: jagan@amarulasolutions.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
 t=1718367565;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=D9hQ6WlvU0vFeeW2pR5wUjKIkVZ6J2mPIVmX/jQharo=;
 b=pKnpBZWlVRgIJpRbnAiSqCPZocUgFQj8rVX7DsjJVxR1vAEBAt0cl4mrbLuG1+q7SwA4J0
 o5tZi4Azv960bq7/25BjbpuPb/zP/qzsAyxVdw8G/0lmd20pUx1INhMk5B+MfWOeHLBX7i
 lyFPUL+0dF8H9X07iwqyRYkAAFImatsVYhRyWDZov+DLTE3ZckjHuVFxXy48THBQrIOxRy
 HhRSnhpTAIeOlKCgMh6ep0RPNuMpuoeokLP9ZggaXgZIYc3xOT1lLw9CV9y3SZkYj0OxTu
 Jg2apxqMYiI0JZDvB4iU7ZPmgxFOYme76B6trqSxdLtroFomu4EwHqvYloxP0g==
X-Envelope-To: agust@denx.de
X-Envelope-To: u-boot@lists.denx.de
X-Envelope-To: trini@konsulko.com
X-Envelope-To: contact@jookia.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: John Watts <contact@jookia.org>
Subject: [PATCH 0/5] video: add support for MIPI DBI interface
Date: Fri, 14 Jun 2024 22:18:40 +1000
Message-Id: <20240614-mipi_dbi-v1-0-946eb82f8533@jookia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACA1bGYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDMwND3dzMgsz4lKRM3cTUlERLizSjNMsUUyWg8oKi1LTMCrBR0bG1tQC
 C2TBuWgAAAA==
To: Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>, 
 Anatolij Gustschin <agust@denx.de>
Cc: u-boot@lists.denx.de, John Watts <contact@jookia.org>
X-Developer-Signature: v=1; a=openssh-sha256; t=1718367525; l=1871;
 i=contact@jookia.org; h=from:subject:message-id;
 bh=wf8ezQ7BQ2JOtkNtEbc5qEz6ic/6/FSDrH6lCOewNlY=;
 b=U1NIU0lHAAAAAQAAAEoAAAAac2stc3NoLWVkMjU1MTlAb3BlbnNzaC5jb20AAAAgPs7MDd2XR
 g2uRE9caV1lPPPeu0VzIG9fPrrVmYyAhLcAAAAEc3NoOgAAAAZwYXRhdHQAAAAAAAAABnNoYTUx
 MgAAAGcAAAAac2stc3NoLWVkMjU1MTlAb3BlbnNzaC5jb20AAABAss1Qs2DkOx6RHaTW+I4WDPt
 UfiL4NRDYeMkw24WhU25imGr09asYiHQ7oGMPdmjU1aH6aPI5MKUob3NuDoivDQUAAP+F
X-Developer-Key: i=contact@jookia.org; a=openssh;
 fpr=SHA256:/gEvgms/9HpbgpcH+K7O4GYXmqkP7siJx9zHeEWRZTg
X-Migadu-Flow: FLOW_OUT
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

Many simple RGB panels use a MIPI DBI interface over SPI, so this patch
adds support for this interface using an API compatible with Linux.

The MIPI DBI interface works similar to SPI using 8-bit words in the
format of: COMMAND DATA1 DATA2 ...
However the interface has two variations on this.

The first variation is implemented by this patch series: Using 9-bit
words, with the first bit signalling whether the word is a COMMAND or
DATA.

The second variation is not implemented by this series: A GPIO is held
at a value during an 8-bit word to indicate if it's a COMMAND or WORD.
Adding support for this wouldn't be too hard, but I don't have any
hardware to test it on.

Linux seems to not implement the specification correctly: It sets CS
inactive between words instead of keeping it active for the entire
transaction. I'm copying this behaviour to keep compatibility in porting
panels across from the kernel.

Signed-off-by: John Watts <contact@jookia.org>
---
John Watts (5):
      spi: Return old wordlen in spit_set_wordlen
      spi: Limit spi_set_wordlen to SPI_DEFAULT_WORDLEN
      spi: Implement spi_set_wordlen for driver model
      spi: softspi: Support setting wordlen
      video: add support for MIPI DBI interface

 drivers/spi/soft_spi.c   |  7 +++++
 drivers/spi/spi-uclass.c | 29 +++++++++++++++++++
 drivers/spi/spi.c        |  6 ++--
 drivers/video/Kconfig    |  6 ++++
 drivers/video/Makefile   |  1 +
 drivers/video/mipi_dbi.c | 70 ++++++++++++++++++++++++++++++++++++++++++++++
 include/mipi_dbi.h       | 73 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/spi.h            |  2 +-
 8 files changed, 191 insertions(+), 3 deletions(-)
---
base-commit: c0ea27bccfb7d2d37fd36806ac2a2f7389099420
change-id: 20240601-mipi_dbi-aeda98f2f9d5

Best regards,
-- 
John Watts <contact@jookia.org>

