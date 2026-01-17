Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99D11C9830D
	for <u-boot@archiver.kernel.org>; Sat, 17 Jan 2026 00:26:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1124F83980;
	Sat, 17 Jan 2026 01:25:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="uISRVuSV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0B7983980; Sat, 17 Jan 2026 01:25:31 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81D45839E8
 for <u-boot@lists.denx.de>; Sat, 17 Jan 2026 01:25:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=f646=7W=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1768609527; bh=PXF6M4WvxRzCO9JoaS5ce4msKuGb0rcJpQyAGNwa+9M=;
 b=uISRVuSVO/yyBtSJDiX+7CpbAbwmpAl62tqXshOU6RraktHKwTpg02yOpvxJlGYn6b4SMSQ+J
 Iou5UJyx1FjKPmQSh6t9HqF2auqUEBdVRrNDVzH593BKouWhOkDGhiWl1iEy7Et28V+MSyigi60
 TlnOLnp3tTxgFbsjL69ryTD3JwvvD000FiX3B6Ok/4gIdrMrSAyKgJ3k7BzbY1eKBdttbNlggiR
 lE0w77bEhlDNk+KgrFj+GLhjhipHE/rwt01yhUaObQfxjV37kgjX1R8GOUnduGSUlBbBslm/LXZ
 3lmDNLnE6gjPwFOp7iB7VFAWzArEgcz1Skwx9SSX1ynA==
X-Forward-Email-ID: 696ad6f275104fdab5e8c3cf
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
Subject: [PATCH 6/6] net: lwip: nfs: Prefer nfsserverip over serverip when set
Date: Sat, 17 Jan 2026 00:24:42 +0000
Message-ID: <20260117002452.1026310-7-jonas@kwiboo.se>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260117002452.1026310-1-jonas@kwiboo.se>
References: <20260117002452.1026310-1-jonas@kwiboo.se>
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

Prefer use of a 'nfsserverip' env var before falling back to 'serverip'
when using the nfs command. Similar to how the 'tftpserverip' env var
is preferred over 'serverip' by the tftp command.

This also updates the error message to closer match the error message
used by the lwIP tftp command when a server ip is not set.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 net/lwip/nfs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/lwip/nfs.c b/net/lwip/nfs.c
index 1812bbda68e5..c3b819a091ec 100644
--- a/net/lwip/nfs.c
+++ b/net/lwip/nfs.c
@@ -247,10 +247,12 @@ int do_nfs(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 		}
 	}
 
+	if (!server_ip)
+		server_ip = env_get("nfsserverip");
 	if (!server_ip)
 		server_ip = env_get("serverip");
 	if (!server_ip) {
-		log_err("*** ERROR: 'serverip' not set\n");
+		log_err("error: nfsserverip/serverip not set\n");
 		ret = CMD_RET_FAILURE;
 		goto out;
 	}
-- 
2.52.0

