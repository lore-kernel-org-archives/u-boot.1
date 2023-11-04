Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39F19C4332F
	for <u-boot@archiver.kernel.org>; Sat,  4 Nov 2023 01:03:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 733CB8757D;
	Sat,  4 Nov 2023 02:01:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="oQ6QVSE+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C66F187450; Sat,  4 Nov 2023 02:00:45 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by phobos.denx.de (Postfix) with ESMTP id 4AC8787252
 for <u-boot@lists.denx.de>; Sat,  4 Nov 2023 02:00:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=linux.microsoft.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanedmond@linux.microsoft.com
Received: from ovlvm106.redmond.corp.microsoft.com (unknown [131.107.147.185])
 by linux.microsoft.com (Postfix) with ESMTPSA id 7703920B74C0;
 Fri,  3 Nov 2023 18:00:20 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7703920B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1699059620;
 bh=7B6JK6rwxPY4YKxMD/7jRDVjNa3jWi48Qh624aPDFAA=;
 h=From:To:Cc:Subject:Date:From;
 b=oQ6QVSE+HXnLUU0Ui3GnMZ6oNom6+KFzTWTzXl5SddXL7Xz8FfdqwnpJ7co+rp5Y/
 hBME/MB09oeCNEQB9nQhbywoWerzO3MYbrHUmVj82+in3qAfwYmGNeB/RP8Po3aKIp
 F3l8cIHuADfqTsxaLSe1cgjTaPm6jHoxI1vDcnO0=
From: seanedmond@linux.microsoft.com
To: u-boot@lists.denx.de
Cc: xypron.glpk@gmx.de, joe.hershberger@ni.com, rfried.dev@gmail.com,
 sjg@chromium.org, ilias.apalodimas@linaro.org
Subject: [PATCH v3 0/3] BOOTP/DHCPv4 enhancements
Date: Fri,  3 Nov 2023 18:00:02 -0700
Message-ID: <20231104010005.2483397-1-seanedmond@linux.microsoft.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

From: Sean Edmond <seanedmond@microsoft.com>

In our datacenter application, a single DHCP server is servicing 36000+ clients.
Improvements are required to the DHCPv4 retransmission behavior to align with
RFC and ensure less pressure is exerted on the server:
- retransmission backoff interval maximum is configurable 
  (environment variable bootpretransmitperiodmax)
- initial retransmission backoff interval is configurable 
  (environment variable bootpretransmitperiodinit)
- transaction ID is kept the same for each BOOTP/DHCPv4 request 
  (not recreated on each retry)

For our application we'll use:
- bootpretransmitperiodmax=16000
- bootpretransmitperiodinit=2000

A new configuration BOOTP_RANDOM_XID has been added to enable a randomized
BOOTP/DHCPv4 transaction ID.

Add functionality for DHCPv4 sending/parsing option 209 (PXE config file).
Enabled with Kconfig BOOTP_PXE_DHCP_OPTION.  Note, this patch was
submitted previously but this latest version has been enhanced to
avoid a possible double free().

changes in v3:
- add define for option 209 and rfc5071 reference
- Set RETRANSMIT_PERIOD_MAX_MS=60000
- Add randomization factor to retransmission timeout
- Add depends for BOOTP_RANDOM_XID

changes in v2:
- use env_get_ulong() to get environment variables

Sean Edmond (3):
  net: Get pxe config file from dhcp option 209
  net: bootp: BOOTP/DHCPv4 retransmission improvements
  net: bootp: add config option BOOTP_RANDOM_XID

Sean Edmond (3):
  net: Get pxe config file from dhcp option 209
  net: bootp: BOOTP/DHCPv4 retransmission improvements
  net: bootp: add config option BOOTP_RANDOM_XID

 cmd/Kconfig | 11 +++++++
 cmd/pxe.c   | 10 ++++++
 net/bootp.c | 93 ++++++++++++++++++++++++++++++++++++++++++++---------
 net/bootp.h |  2 ++
 4 files changed, 101 insertions(+), 15 deletions(-)

-- 
2.42.0

