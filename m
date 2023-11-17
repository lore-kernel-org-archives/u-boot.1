Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE242C54FB9
	for <u-boot@archiver.kernel.org>; Fri, 17 Nov 2023 21:49:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5904B86EEE;
	Fri, 17 Nov 2023 22:49:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="mVQNhElu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CCCC2874B1; Fri, 17 Nov 2023 22:49:34 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by phobos.denx.de (Postfix) with ESMTP id 09A7286DA2
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 22:49:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=linux.microsoft.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanedmond@linux.microsoft.com
Received: from ovlvm106.redmond.corp.microsoft.com (unknown [131.107.147.185])
 by linux.microsoft.com (Postfix) with ESMTPSA id 0400A20B74C0;
 Fri, 17 Nov 2023 13:49:27 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0400A20B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1700257767;
 bh=eRA24gqDkLdedKtITzWXEQO/d5Ks+x9fMpFWglMa6+E=;
 h=From:To:Cc:Subject:Date:From;
 b=mVQNhEluFzYisKEmzKLU5kAAXsDS8iIvOb/WpLnGCdfC3YMXkvuwpG6ehvDV5MyLP
 3xR8ydUvdG0/VAaeySTJmkOeL0HSIUQVEVqjidbyQAtBpy1RqDCZvgqzLsTRTYzSL4
 O0GrEzNqBVNYaYXVGlX2msFJtViYgQJ/sNkqDw24=
From: seanedmond@linux.microsoft.com
To: u-boot@lists.denx.de
Cc: xypron.glpk@gmx.de,
	pbrobinson@gmail.com,
	trini@konsulko.com
Subject: [PATCH v4 0/3] [PATCH v4 0/3] [PATCH v3 0/3] BOOTP/DHCPv4 enhancements
Date: Fri, 17 Nov 2023 13:49:22 -0800
Message-ID: <20231117214925.138486-1-seanedmond@linux.microsoft.com>
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

Enhance DHCPv4 sending/parsing option 209 (PXE config file).  A previous
patch was accepted.  A new patch fixes a possible double free() and
addresses latest review comments.

changes in v4:
- rebase master and resolve conflicts
- change commit description for DHCP option 209 patch (this is now
  an enhancement patch)
- default y for BOOTP_PXE_DHCP_OPTION (feedback from review)
- Add "select LIB_RAND" for "config CMD_BOOTP" (retransmission
  improvements require rand())

changes in v3:
- add define for option 209 and rfc5071 reference
- Set RETRANSMIT_PERIOD_MAX_MS=60000
- Add randomization factor to retransmission timeout
- Add depends for BOOTP_RANDOM_XID

changes in v2:
- use env_get_ulong() to get environment variables

Sean Edmond (3):
  net: Additional fixes for dhcp option 209
  net: bootp: BOOTP/DHCPv4 retransmission improvements
  net: bootp: add config option BOOTP_RANDOM_XID

 cmd/Kconfig | 10 ++++++-
 cmd/pxe.c   |  2 ++
 net/bootp.c | 76 +++++++++++++++++++++++++++++++++++++++++------------
 net/bootp.h |  2 ++
 4 files changed, 72 insertions(+), 18 deletions(-)

-- 
2.42.0

