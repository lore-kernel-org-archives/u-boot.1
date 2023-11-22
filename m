Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFBC6C61D99
	for <u-boot@archiver.kernel.org>; Wed, 22 Nov 2023 23:29:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3883587665;
	Thu, 23 Nov 2023 00:29:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E31887671; Thu, 23 Nov 2023 00:29:16 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by phobos.denx.de (Postfix) with ESMTP id 5C0C887656
 for <u-boot@lists.denx.de>; Thu, 23 Nov 2023 00:29:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none)
 header.from=microsoft.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=seanedmond@microsoft.com
Received: from ovlvm106.redmond.corp.microsoft.com (unknown [131.107.147.185])
 by linux.microsoft.com (Postfix) with ESMTPSA id D542020B74C0;
 Wed, 22 Nov 2023 15:29:09 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D542020B74C0
From: Sean Edmond <seanedmond@microsoft.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, Sean Edmond <seanedmond@microsoft.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Bin Meng <bmeng.cn@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Joe Hershberger <joe.hershberger@ni.com>, Marek Vasut <marex@denx.de>,
 Michal Simek <michal.simek@amd.com>, Ramon Fried <rfried.dev@gmail.com>,
 Roger Knecht <rknecht@pm.me>, Simon Glass <sjg@chromium.org>,
 Tobias Waldekranz <tobias@waldekranz.com>
Subject: [PATCH v6 0/3] BOOTP/DHCPv4 enhancements
Date: Wed, 22 Nov 2023 15:27:43 -0800
Message-ID: <20231122232812.823837-1-seanedmond@microsoft.com>
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

Changes in v6:
- CMD_BOOTP should "depends on LIB_RAND || LIB_HW_RAND"

Changes in v5:
- add change log to individual patches
- fix depends for BOOTP_RANDOM_XID:
  "depends on CMD_BOOTP && (LIB_RAND || LIB_HW_RAND)"

Changes in v4:
- rebase master and resolve conflicts
- default y for BOOTP_PXE_DHCP_OPTION (feedback from review)
- Add "select LIB_RAND" for "config CMD_BOOTP" (retransmission
  improvements require rand())

Changes in v3:
- add define for option 209 and rfc5071 reference
- Set RETRANSMIT_PERIOD_MAX_MS=60000
- Add randomization factor to retransmission timeout
- Add depends for BOOTP_RANDOM_XID

Changes in v2:
- use env_get_ulong() to get environment variables

Sean Edmond (3):
  net: Enhancements for dhcp option 209
  net: bootp: BOOTP/DHCPv4 retransmission improvements
  net: bootp: add config option BOOTP_RANDOM_XID

 cmd/Kconfig | 10 ++++++-
 cmd/pxe.c   |  2 ++
 net/bootp.c | 76 +++++++++++++++++++++++++++++++++++++++++------------
 net/bootp.h |  2 ++
 4 files changed, 72 insertions(+), 18 deletions(-)

-- 
2.42.0

