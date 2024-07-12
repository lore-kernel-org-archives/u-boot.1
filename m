Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDCC1C3DA4D
	for <u-boot@archiver.kernel.org>; Fri, 12 Jul 2024 09:48:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3024588754;
	Fri, 12 Jul 2024 11:48:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="rAAxRNyP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC75D886E7; Fri, 12 Jul 2024 11:48:19 +0200 (CEST)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on2072f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::72f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83C4A87FF7
 for <u-boot@lists.denx.de>; Fri, 12 Jul 2024 11:48:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SDjpvhJcUTgWbvXg6MfpfePUBB4FXDJq1Uc05Mp9RGy33sZ+NLMQDEF9LvKUF93bAwDZPTJx4eJ3YBhGE5MCdzqa+a3GKkVvsZIJhROn/Nl9ChrozO4o0kH6iC6gHH1EvxqsBqXrY1yEuVyNIcKf/S9/qeU/SiJNwkX/Of2poVpEhgyE//JEpPVdU0JfHgu7yPMU/NMGDF85TwaPrY7WUc1KKIZyhEbKC92LsmJwv0EYu4KiCZmFTz0B6E8wG/vgQu+xHlDSww/g53WRWujb6xQciLT7apalx7OJoDAioXA3/mbAh3iGra/2qvuNOGNwoJTbIfc/M3Xq+1g7AS96kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N/bLARL2a/R92l4UUBLS43hwJplwsx7KiwNcyymc36Y=;
 b=yb3nXRZh+aLJgYBFswRq+BEmfjqlpPto3YDfzGsrV5b4o82hzQn8tMg/EwY5tQfQpD5XzVx1QxHuFEfxpMPl3vVOTwgzeIvUJtFfZYOTDjSFBJhOwSpUJmKVCVEyt2xgvgV0SJHZk9gWoqgEEAMYn1tLwKm2IBXql8uBkpcxt2A+ajRFDjItlXuo62WTBjvDGgngZpjk7r0zQvMiXqto3Sim5qhHpwPJ0ZrV+YjQ1Khb3rqpPWMoX4DSY7eFAzGyIgcV/197gndiFsR5Z/hvenwaVapjRYkFOEMEvyviQxWAV9rTBgXgfxX2PTN3CJbj5uQN4dbAWlzbvpw7pnhhYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N/bLARL2a/R92l4UUBLS43hwJplwsx7KiwNcyymc36Y=;
 b=rAAxRNyPrpxqvNqbGEoaT7tvHBXRaI2ZWRlgwVPTfIIwuZ1A5i+9gzxtaNDwnQqraOpLo0dDNpA3zOrKO+Feop4qYhrSdSXPN3ncAt0On+LlmXyiqmOoBGk55QIYUQlwwK6GekIYuHb1S01gFvfxK7pHefOnR4KAkvLjRI40KUyd6d8lx/N5BjqIDZNljvfDLU7dgxxTA4oEX9VcVHLIPvvazce3Epuf2HZY7AMrfNa/JktszghBAleOFG3T5j9semWtUAX5Nt+Ry2fRXgNVID3pFeZkSUmPcSsoLpT69KlMqQCphMFBGnWhMCLHV7wSYWZ77/gHLRDTqW6VIoSEgQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by GV1PR08MB8216.eurprd08.prod.outlook.com (2603:10a6:150:5f::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Fri, 12 Jul
 2024 09:48:12 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%5]) with mapi id 15.20.7762.020; Fri, 12 Jul 2024
 09:48:12 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, u-boot@lists.denx.de
Cc: Peter Robinson <pbrobinson@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v3] net/tftp: make tftpput working with servers that do not
 use OACK
Date: Fri, 12 Jul 2024 13:47:54 +0400
Message-Id: <20240712094754.2901920-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0036.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:151::23) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|GV1PR08MB8216:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b7020d2-b78d-455d-801b-08dca257be74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cJ587I81+8EeDAyPEw1Bul8bZl45yTb+1ryZK/6GGEZ0LMzxNDhYzf2kGFIJ?=
 =?us-ascii?Q?HKpk/WaCqZyDd5PIybzQU5TM7lhz9E5dJPzDRtjeyEOi2iYO+WxH5fLFDsPF?=
 =?us-ascii?Q?GooYCi2SzCjhFkL+9vH+k9uONtjlcybFfr1VgpO5XSTLf3IiyFSTCVQyv4HJ?=
 =?us-ascii?Q?qsiKPgLHzlcbwOv8g7pY3HoVDg3llDGSH31IhSC37cFFDvqmslqDN9cKZQ1W?=
 =?us-ascii?Q?O+Rbmr09znYa+AX3pwPdtaJezsWoeXCYNczVKFHO9D40kvhEjwWzsLvY8+b7?=
 =?us-ascii?Q?vXmeKriZNVy5S3KwQL5KhFJTn8B7MvAiDbQkqyBO1PZV20uv210Pga+4itPH?=
 =?us-ascii?Q?h8c3RPaVWcwsYUEeh2VHJ1OsGnd08LGe4f80bmsqb59DR2KpB8z4EGVjZ55N?=
 =?us-ascii?Q?oTKMU1zJbTrLsSeFPNIngIY9nZDWIULg2Yltd1SDCEfXpJsVSadEbq2MasTU?=
 =?us-ascii?Q?BmtXvuvFEORl7p6e/UcojQ5usD5/Wk9FKCSL4ELTS6eaEOGkRDGJRMEkpVRt?=
 =?us-ascii?Q?WJdNl8vUK208ic61gkMx2/UYlqAR+0R4kMOgJGO1wRnS8+zD+3CZCyKDKtTz?=
 =?us-ascii?Q?3Qayqs8ZaJ3tcxrV4QKn0lxL+EUZe0kb9s1rtI6G2Kbmk2D9NV+ZnjjAiJwi?=
 =?us-ascii?Q?q9wpK3a0LKkc/klYuAI5/tq6Xbqzm8yVkYHCTpfC5lRXmJEKV59eVfkNCMMg?=
 =?us-ascii?Q?mxSSQJqeLqnWdr6gZBiRgppUcvLhZKYv6YU79cEzHJKi8uPB0EhMCRuiLxX5?=
 =?us-ascii?Q?QuWeUAcwXMFABSyZqrnH0dYkcISb2bkadLbAHhk0O5KdEkEOBIqsYz9Reu9l?=
 =?us-ascii?Q?1c3tN89qJ/hne+LtZxfUU0fTWgAINNUJYTp089Tz+Ur8ksnf+atDGTXLKuKM?=
 =?us-ascii?Q?cf9SUHkJLSH5hqfigrdeMKISbP07FT2+jBq2H471OB2pR4+K83xlmuPLH97E?=
 =?us-ascii?Q?13FIzPqhhOVljPewWez5F+pHXdlu+jg8R7XgxWiHd8Xc8c+NBoqxPB3pa/Ad?=
 =?us-ascii?Q?y/VOBBODjgy8sNs/2YM7xdXGKoxEbQdGIS0O7GGiiEUiKhKmcJOiF5xGg6rK?=
 =?us-ascii?Q?TGXcGA4Vhw6fm/nfn9YXbBD8cPiCrpKrhZDZSxAkg52CFnxjq5756ZDmhEK/?=
 =?us-ascii?Q?u2H0b2K6yMI6Ein9v05KLVFvrEKgant0HayYq4/PXZK48PrNxti+5zWUIOFC?=
 =?us-ascii?Q?5x24fnf4kpDiwQkxVIRJp8JRPZMiRN8BlD6r1EWkzNtKmpprH/6Q3UeNKdwN?=
 =?us-ascii?Q?g9QtzgfGPLjieQxQ5jUaR5oWAROOnQdpLXTQMgwbNrgksa6xuX8aF7hSZ/fY?=
 =?us-ascii?Q?We2lv61bwOdwM1YwoS/nN0fPkhQRhVD3RKZKRABE4Yysz7v+Ziz4mkjZz5zE?=
 =?us-ascii?Q?F90b4iU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LPiU75G/R220wxRRrNBzUSdz/MR6VGAf8w8Yj2bbh8YhsRjmHa7yIuSCP9nN?=
 =?us-ascii?Q?SVn6i7kdpYsC60l8ZoZBEE0ruSoOP6bTBFifRwYQOD69pojm15r9G6K+EvLa?=
 =?us-ascii?Q?aiz4v0ioNaFoMiutjonz0UTi9Sq2AwW4FsvGWkfMpEhZt2UQVksVOAwqcUeG?=
 =?us-ascii?Q?OgcFrypUcO9xE5fVFjjn2AGJz0OobwZk7CaN15Fop13HhiNMIt2VX19THh8z?=
 =?us-ascii?Q?ba+FSAFed4RD/Q/lwr4AgywZAv9twiIQ99uN4A9xsdJombYseSKkvDD39IDT?=
 =?us-ascii?Q?PuIIOrtCQAF1gZkG8LfULYMtdWDDN4KV40logVK0J985pd3WLo5X+q4PqN9C?=
 =?us-ascii?Q?cS22HegK6XVcbtWMEVudGpqgEutjmpGjrFX9zp+mvpenY0ZpKo3+upswdsBg?=
 =?us-ascii?Q?DNFfrGAPd5sU/UnrvA2mTHZbtYsnz77PlJhcnBBknhsxEdXjl9fROPd0iFve?=
 =?us-ascii?Q?HuMNMfUXlp+hoBXbGOQZ3QBWuG6OJROyEjmKlhzpiYYzciK30VD+qgLMCOaO?=
 =?us-ascii?Q?M/h+B9a4PHuCTHbRpMmZZr3yiyuDtynZdxznQWCZrfO14ZscM9OZX59Vlmzq?=
 =?us-ascii?Q?PO+PUOTtxOdPR0mwaqtFaMKLZLDd81fAzXpoi+g4mJb1hQ5d3EX/Mi2bTjKS?=
 =?us-ascii?Q?NkLXyzkvfTqMZYQRhRbzRyfz8BA6Wos3Db9VZ9zL/BlsE8MsmvEPhMT8mfFC?=
 =?us-ascii?Q?esc74XlldaC3C1OXNitBLcYcIaUMC1Xjwi7Id1cX6Byjy9ibGGrhLt5Rwbi7?=
 =?us-ascii?Q?qyTct2hQKIZOkfBAStC8q1RMPrzplyn0Kc5WZv0SPFuCZxuhUfbJUrQL6nTR?=
 =?us-ascii?Q?mrwyISYzfZldrSlLUSGkgvBtPMObw2TZ00qNhlwP1yk1UjyUZo2Dew2e54Lg?=
 =?us-ascii?Q?R+wIkPTP544gnAr6169noJQn5EvgaBiLEiaPBqfiAf+mPqk0LKPkxv5KOflI?=
 =?us-ascii?Q?wgyw3vnPFDhGGGHCX9Z8JhAx/Zodt/OiJBLIzKQmtMP20cmxOvlD/iN0jUjB?=
 =?us-ascii?Q?Jma+jC8vqrhvfSK6h+4k808dl5UqYmvofWXnr4QLEyA73OA3KNrWroHgJ1PM?=
 =?us-ascii?Q?yrzSgQvowZvAuNqVIZZQjYh1p5AA/alsusKVg3jcn02oHTW9ogY83cDuh+s1?=
 =?us-ascii?Q?k58IZZSJyQ4RL9tJDsHMYoMaM3JQEiTTNQ7iyNBdIXhNSvYK6+g7wGzT28LN?=
 =?us-ascii?Q?heiUAfdb8cyejeOjl9K/Y+m9FzUFEAJEpzRgUafs5nCyYlBdBQcNiB2ufJwe?=
 =?us-ascii?Q?T4nQxIu579ZJkfQAYtJWT7MaNd0VV12s7LjmTrGz+hed8fB3MEnMBGL/j8Rj?=
 =?us-ascii?Q?BNPELiDYd2nM+ek4JmTxEPdPtR/r7NLeZz9oRPVqzKDz2tlF8+asResGufXN?=
 =?us-ascii?Q?hPf+NX24Rf4t5p+CAosjHGOL9RIWoz6GpNxhf02NB2MvUhah7r3YH8FhrS4Y?=
 =?us-ascii?Q?DMZo6D1VwoZRdAqoTnkfKPdISmAWXQfKuoxPDQ79IKxtCH9RBiZ8p1yA1bY8?=
 =?us-ascii?Q?Id2gnfn6VhaVvz7AM55dbaocL+QI4ELvd9EnpIGh+e5fLGbQEL8MNdAYM55j?=
 =?us-ascii?Q?mcWMqT+1iSW6moOq+k8FOTAFk95dDqN2n4xwuRB7Vk4hFQ8SSKN1Wq3+IlDz?=
 =?us-ascii?Q?Ew=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b7020d2-b78d-455d-801b-08dca257be74
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 09:48:12.4751 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8OUnyOjAFFazdEAFjeB/mCJg27CLFvmFctk50krhGz3AMIQi0WTINDTTSowipvWBwdbjHd7Pnz0IaZ432+sHtL4fR0zqUQI/03QdRszRU3k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8216
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

Option Acknowledgment (OACK) is an extension of TFTP protocol (see rfc2347).
Not all tftp servers implements it. For example it does not supported by
tftpd server from debian-11 (https://packages.debian.org/bullseye/tftpd).

Starting the "tftpput $loadaddr $size out_file" command with such server
will results in the following packets flow:

192.168.27.3   192.168.27.1   TFTP   Write Request, ...
192.168.27.1   192.168.27.3   TFTP   Acknowledgement, Block: 0
192.168.27.3   192.168.27.1   TFTP   Write Request, ...
192.168.27.1   192.168.27.3   TFTP   Acknowledgement, Block: 0
192.168.27.3   192.168.27.1   TFTP   Write Request, ...
192.168.27.1   192.168.27.3   TFTP   Acknowledgement, Block: 0
192.168.27.1   192.168.27.3   TFTP   Acknowledgement, Block: 0
192.168.27.1   192.168.27.3   TFTP   Acknowledgement, Block: 0
...

so, no data transfer happening.

Here is a packets flow for tftp-server with OACK support
(tftpd-hpa: https://packages.debian.org/stable/tftpd-hpa)

192.168.27.3   192.168.27.1   TFTP   Write Request, ...
192.168.27.1   192.168.27.3   TFTP   Option Acknowledgement, ...
192.168.27.3   192.168.27.1   TFTP   Data Packet, Block: 1
192.168.27.1   192.168.27.3   TFTP   Acknowledgement, Block: 1
192.168.27.3   192.168.27.1   TFTP   Data Packet, Block: 2
192.168.27.1   192.168.27.3   TFTP   Acknowledgement, Block: 2

and this time data transfer starts normally.

As we can see there is no OACK packet in the first case. Investigating
an isssue we'll find out:

1) tftp_start() sets

      tftp_state = STATE_SEND_WRQ;

2) on OACK tftp_handler() sets

      tftp_state = STATE_DATA;

   and send a first DATA packet.

3) on ACK tftp_handler() will call a tftp_send() function.
   tftp_send() will

   * tftpd with OACK support:

       Current state is STATE_DATA, so transmittion of data packet will
       happen.

   * tftpd without OACK support

      Current state is STATE_SEND_WRQ, so retransmission of WRQ packet
      will happen. Thus tftpd-server will retransmit an ACK.

      This will repeats until timeout happens.

      According to RFC1350 this is wrong. We should start data transfer
      instead of WRQ retransmission.

This patch fix an issue, so tftpput works fine with both types of servers.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
v2 change:
 * add more bug details

v3 change:
 * provide detailed analysis of an issue.
---
 net/tftp.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/tftp.c b/net/tftp.c
index 6b16bdcbe4c..0b72134fbdb 100644
--- a/net/tftp.c
+++ b/net/tftp.c
@@ -493,8 +493,15 @@ static void tftp_handler(uchar *pkt, unsigned dest, struct in_addr sip,
 				tftp_prev_block = tftp_cur_block;
 				tftp_cur_block = (unsigned short)(block + 1);
 				update_block_number();
-				if (ack_ok)
+				if (ack_ok) {
+					if (block == 0 &&
+					    tftp_state == STATE_SEND_WRQ){
+						/* connection's first ACK */
+						tftp_state = STATE_DATA;
+						tftp_remote_port = src;
+					}
 					tftp_send(); /* Send next data block */
+				}
 			}
 		}
 #endif
-- 
2.39.2

