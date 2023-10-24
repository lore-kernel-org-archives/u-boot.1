Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA1A1C00A8F
	for <u-boot@archiver.kernel.org>; Tue, 24 Oct 2023 00:22:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9651987769;
	Tue, 24 Oct 2023 02:22:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="EYK6maDC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 218A18794F; Tue, 24 Oct 2023 02:22:04 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by phobos.denx.de (Postfix) with ESMTP id 4E7CB8702C
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 02:22:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=linux.microsoft.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanedmond@linux.microsoft.com
Received: from ovlvm106.redmond.corp.microsoft.com (unknown [131.107.147.185])
 by linux.microsoft.com (Postfix) with ESMTPSA id F1C6920B74C0;
 Mon, 23 Oct 2023 17:21:59 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com F1C6920B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1698106920;
 bh=OmS4SU12XNVAMHrPNUW+AnlDp640MPMAN6PWZ3esd90=;
 h=From:To:Cc:Subject:Date:From;
 b=EYK6maDC+aJsb/EqFplmbjCnZdMTO4W+tp1prq6AzTG7SY6upqUqkWkpPbedF4l/2
 S/DbSIQyh71pEdpijODcttVVVHNI8IltidabCOFaMBIqDdmnLyZ5A2t/8mKS5Ojyvj
 ad3kweFs6PVDBb2ndJ8+bAxYoqgJsUN3aT8DmWkE=
From: seanedmond@linux.microsoft.com
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, sjg@chromium.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org
Subject: [PATCH v2 0/3] BOOTP/DHCPv4 enhancements
Date: Mon, 23 Oct 2023 17:21:56 -0700
Message-Id: <20231024002159.74477-1-seanedmond@linux.microsoft.com>
X-Mailer: git-send-email 2.40.0
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

changes in v2:
- use env_get_ulong() to get environment variables

Sean Edmond (3):
  net: Get pxe config file from dhcp option 209
  net: bootp: BOOTP/DHCPv4 retransmission improvements
  net: bootp: add config option BOOTP_RANDOM_XID

 cmd/Kconfig | 11 ++++++++
 cmd/pxe.c   | 10 +++++++
 net/bootp.c | 78 ++++++++++++++++++++++++++++++++++++++++++-----------
 3 files changed, 84 insertions(+), 15 deletions(-)

-- 
2.40.0

