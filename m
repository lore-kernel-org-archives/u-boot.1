Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 696A4C98306
	for <u-boot@archiver.kernel.org>; Sat, 17 Jan 2026 00:25:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 824368367F;
	Sat, 17 Jan 2026 01:25:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="oqqnl9fy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADDA483935; Sat, 17 Jan 2026 01:25:09 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1FB183015
 for <u-boot@lists.denx.de>; Sat, 17 Jan 2026 01:25:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=f646=7W=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1768609504;
 bh=vEGEU6SdCwRqDa8gBwblhhRzh+3HK9rwS2Ovbyw5lgo=;
 b=oqqnl9fy0NWDbiYlx4oSMtn/Jb0/9960WR831PWE37DIi/fg6Sh+wOfJDB3FmSZnNfhp1ecMx
 FzvjPjD/oo38FbjBLy/ifqIyO15JE8Ah8ckxw8JEqsqzk++ot8OM5hOivfXvEYhljZjAgexHsTz
 dmC+1TUdLG70o+HQdrlz+DnF5DsAZBeU0H5Mh3+BWn0Ww6rMLXnoeF1L0Td0r1w0rw+7M059aB1
 gaV8su5dL5Hx7ZKwKaROIDWheCF9oCT/g0QSa4dP+fgFXL5us83dU24Lc34FmW9zbW6Rw1icc2d
 x4NrPbRXD58dgjO55KY19olmqiJdimTdVWhrB4AYqlZQ==
X-Forward-Email-ID: 696ad6db75104fdab5e8c2f3
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.2.8
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Jerome Forissier <jerome@forissier.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 0/6] net: lwip: Command fixes and improvements
Date: Sat, 17 Jan 2026 00:24:36 +0000
Message-ID: <20260117002452.1026310-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
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

This series fixes a minor issue with the lwIP dns command, print device
name from udevice in nfs command, changes to use ipaddr helper functions
instead of accessing the internal addr field.

It also ensure the DHCP siaddr field is saved to the 'tftpserverip' env
var so that correct next server is used for bootstrap.

Finally it make the nfs command behave in similar way as tftp in that
it will prefer to use 'nfsserverip' env var before falling back to use
'serverip' env var.

Jonas Karlman (6):
  net: lwip: dns: Fix print of resolved IP address
  net: lwip: nfs: Print device name based on current udevice
  net: lwip: dns: Call env_set() from dns loop instead of found callback
  net: lwip: Use ipaddr helpers
  net: lwip: dhcp: Save DHCP siaddr field to tftpserverip env var
  net: lwip: nfs: Prefer nfsserverip over serverip when set

 cmd/lwip/ping.c |  2 +-
 net/lwip/dhcp.c |  7 +++++--
 net/lwip/dns.c  | 24 +++++++++---------------
 net/lwip/nfs.c  | 13 ++++++++-----
 net/lwip/tftp.c |  2 +-
 5 files changed, 24 insertions(+), 24 deletions(-)

-- 
2.52.0

