Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D9E8ECE589
	for <u-boot@archiver.kernel.org>; Mon,  9 Sep 2024 22:28:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB77788E65;
	Tue, 10 Sep 2024 00:27:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="XpJCtNhs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA5DB88E9C; Tue, 10 Sep 2024 00:27:48 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2072b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::72b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F6E488E94
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 00:27:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hXaLLt3gfydFLPQb2UtJ/uol9HwMAczrwrK1X3RDPWNHdB530umIEqVaH/dYY84CJp0eudzoBeQj/XWkrkVicTb1NjQ/1nXHgvVxvXq6PST9rpFM8pfOa3low4kHKfjz/y/uukSIBzy36OJOtJ0OzBJ9cJCdGgSkmlmYvBhBOYJ6nPAma3c/nVwSSYtayNleoJT/Vgo5FzCrp/gLl10/u+JPgQ4I7nsHYdzYal497C+EnDrVbrFqANVcTPkVuv9gatKAFez8+wJXnLV5wRFjZ7CdEL1AbyPlKtBz2brxgw8wuL6cTbSyUZcoFb7H4tt2Ym+kYoAA4DYwYYFaL5tEIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a8Y+sO3XzNkNNs97CVkYahNCaM9Hf2RZbOzXe3uEzeg=;
 b=c25nM3EH+nshv/noNWdme1jkK3qvFFoJnqn4ZAJZvMiasqJ+At0/BQmM8XyPg2N8auk08GYY34YWHd6sOabsUUwFH/4WC9x0lcVRiQM1WMhLGftszZr5MCYs4ZpXWfgfOnst8Ul7HnCTGBcKnhv4UGnO4xS8RvRmoU71Btymq7DrG9807iDP96w4pnB9asHZ3MVKLvOPc9l24+F3DjdRPNL3sst/JQ7hhJLxt5dt0GlD9bTT0uhmEFS6WwEC1D9BXGK0Q64B092VwSUaRddwUDdkH69/oPAZCwdw5K5SXw0qg1AuInf2AhZGxP5rESXOhaGt19zs8it28gSp0Wu/Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a8Y+sO3XzNkNNs97CVkYahNCaM9Hf2RZbOzXe3uEzeg=;
 b=XpJCtNhsGj/LUAMfb+gcwp9/XeiBiCdYf39itjTjuQz9h+Md7Hfv5TQVEAGY1BWSYERG3ix7tV9/+wkvmuaOFNQTLces+YDPxPR08bEVojnqaiP1rNhwAG/EwcwovH8jp0F2jC0DsbvNXfTtRwS73zqd3Z3g2TzL+PEnfbEZYhnsUVGj8wtecvsh+HWwmAeM6uMDIEdt2D5m0nRS+pwOPiFkj1690RujYsAlVYRuMgJstNTOnQkyfEhEfZ4kCSSQmTDWa7YfwM4DxYeBk5X/UYVb3pNxE2OMqZvlWYAWtMTnPm+7sDfAKh9ORlgczNVMnwhhrvkErU2QjdIMmBlMPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DB9PR08MB8722.eurprd08.prod.outlook.com (2603:10a6:10:3d2::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.15; Mon, 9 Sep
 2024 22:27:40 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.7962.014; Mon, 9 Sep 2024
 22:27:40 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Michal Simek <michal.simek@amd.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Anand Moon <linux.amoon@gmail.com>, Marek Vasut <marex@denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sean Anderson <seanga2@gmail.com>, Baruch Siach <baruch@tkos.co.il>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>,
 Richard Weinberger <richard@nod.at>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, u-boot@lists.denx.de
Subject: [PATCH v6 08/12] net/tcp: simplify tcp header filling code
Date: Tue, 10 Sep 2024 01:27:16 +0300
Message-ID: <20240909222720.2563118-9-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240909222720.2563118-1-mikhail.kshevetskiy@iopsys.eu>
References: <20240909222720.2563118-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0178.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::6) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DB9PR08MB8722:EE_
X-MS-Office365-Filtering-Correlation-Id: 18700f95-8c16-4a2c-07de-08dcd11e9dc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|52116014|1800799024|366016|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cy8PfK/4/5Hjz3OU01YJcrOuF7Wf4pb2gysdaJQH7YuPiwqEij3wTgQU5Vko?=
 =?us-ascii?Q?d9a+doNzvV8ZIggWNfQiZ7RNxDyYXvfavAa13koh78NYtjJZcKuuNOzW3lZm?=
 =?us-ascii?Q?nV1LrVpYgvnhyR0B36f04rYFJKrKYgO7lX9zywDLn1F16Y2O4EvquTm2ktPo?=
 =?us-ascii?Q?46iRqRyNWQVZC2axyKra2zgPLQrjZo02Y5aH7KwRuQGIWwqBhr2sAq+J43dd?=
 =?us-ascii?Q?ilXus3hPs+EoFVm2Q6pMNEnhbYieTP1wyom8OBWNQP7tD6mztOV6aKvO+IQy?=
 =?us-ascii?Q?WRqMVAhmyfuqrDsuIkq6e4DRKsC5tPYTtQ0M+txkxtcZ1iznE9VjqLNZoazx?=
 =?us-ascii?Q?RvN3e8aYVD1itRSpvtFDX3u/s1UTDz8Fg9/G6PHsaTbuZlqy/JaG/3xR6gvs?=
 =?us-ascii?Q?HWudL9jZYRodpsx47hbrGV0bh+sY11HNgBc+j1Enz7pt/nOhizQD5WenZnG2?=
 =?us-ascii?Q?kTor//xRYpVJRIVSCDsLOH6ukjy3gSKAQlnRwSvONG+bnNqQZnRuZpVNMEA5?=
 =?us-ascii?Q?+SyFCKFwaCo+UFYu3Q4np3B66u2PXZNBn+uLFIng2OIvWwCPczvTWxl+OM/Q?=
 =?us-ascii?Q?JIAnqa7lzB/5DNEwWjJb+JtBkKE2K7LtjaPmEXC7Aq3abvZ8ljSBLVaW/13w?=
 =?us-ascii?Q?PLvKcbhrPBFz/L9B8YcZaj/IgM+m/XisEAuhY9McdLNUPbVciqxhfuBsZOwR?=
 =?us-ascii?Q?v1YBp3O4+CsbgTuOxLeTkzoqWXxxUJHFI2VV96hYxRnqOf2d2s6JM9WdzzyZ?=
 =?us-ascii?Q?R3HjGx8yAoBUncQqkCh/SWTsMRVia0L0cFB3+VtJPz5rvP7fmV+93SxiId1l?=
 =?us-ascii?Q?ZwRTI91Vi+3HmGuCEVXCZejCUjecEbe0EN3BWIs2QeguLa2WNhisuB9AVQqV?=
 =?us-ascii?Q?6b0P2kSBgyjjrXj85oNYINDN5/e2B/62SgZyPyEQcqsV4yPWHVBOhxZWNYU5?=
 =?us-ascii?Q?wDw/i5ccL7Ubu//+snW/fpMSwLcErzXYpw+/1X0z/DzX3spc5PrH/saIAxMC?=
 =?us-ascii?Q?0yQrNcd/+e85gKVgGR+bRnnadQrN8+emJ+q0xM0TxdPUJu5px8a7I+E8S142?=
 =?us-ascii?Q?e+j+9PS2nnkYyzLVFRXI/KDsfwy3i4aPyKYduYkgkKiigY2T/mhNaS1eoq7y?=
 =?us-ascii?Q?WXvxwnUe5vd8/y7aWFqlI09POqT/4tG7R8vxC3XziURe6OtifJiUShKCo+Eb?=
 =?us-ascii?Q?QOJPLkSSozI/V9FVyYR8fGyFg5I7kpnmkSxXcJ5YYetf/eP8GeXyY3CldMLl?=
 =?us-ascii?Q?5qIa5PwHK+OjMkTIlTIVbwm5bYCS8dRDzOCK9gLh6o6PMaVMeYvZ6vwLdpyW?=
 =?us-ascii?Q?t+OcsCS0Se3D72zhnw4AZt5BHM+z0c2V+zPGaNwUkIE60K8/XPv7anFEG70X?=
 =?us-ascii?Q?fRegT/RACYEANkWUJct4COpIRdMFUMP+qP/koGyw4xGzOoUOBQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6hjOru8/Z0We+BRSJ47x31Pr+RXzz89ZQzvExaPSIw7zqivqzp6VHNWhpV0X?=
 =?us-ascii?Q?Q6dK09zv4gUJo/5xORL+xruVocDCXpG3mpXXAb2QC8iuUxvqz/vLSXkDtTnC?=
 =?us-ascii?Q?rSy1oMKfX3Kkc++nyTU+yjEEK1OUya+y/QqtBzCx+IFn/GsKUvS6Twd3xGip?=
 =?us-ascii?Q?2qVxa3bWTH8JN4cHWhvOQk9XKOO3SVslb5UFKZSiniOXUiJ7zKLtC+cZDWiK?=
 =?us-ascii?Q?9YTzL3seKzWMstQgTwt/cOtJOnwbix0+fPhBoeFH5BWX0RKWCuNtfL7fGiGb?=
 =?us-ascii?Q?L1Gp5eFm7P3+XsBaZqWLCaiApfz/rb5L1sGFCzgGbRgcgTCFukGXwYZ1l6bz?=
 =?us-ascii?Q?JP8Bd1i7r/QuVsH0xkHlliJpOdeWNTeDljkSd9nGeZAhsGFt6GaEUrhLU9Km?=
 =?us-ascii?Q?4wMt1Tqln3ZXDaU7aTOuwFKTT3MVp25XGMtmSNIObIlhxmdzfnYFLMHH/wSr?=
 =?us-ascii?Q?R/26GGYTrLIgG2HHb/W0UNYOy7crQmzti2PeRiLOspuV858Iwwbi5ZIDucFj?=
 =?us-ascii?Q?QmNn1e1nPOFk9xNNYaxXuJfX0GzSgjIlnTKRmbSmEx+Xt1DgteS9k+BdrXYr?=
 =?us-ascii?Q?HulQ82IwNVF/KcQJ4iXjq+NGE1yDqebHRhg7MAVroBFtJIY/9a+/9MwC+Ysg?=
 =?us-ascii?Q?i0Ck4yLWpdhesyx6mzMeCkpG2Mz4klckKfTnJW3lTOC1Yb1XhtqlCyti/KJ1?=
 =?us-ascii?Q?HFi5dfy+aq6Fk+6VC6MZWxDFatkPtkIfsba/n0ONlGi2BQapYprpzbhBnBBg?=
 =?us-ascii?Q?5Ol1vhjWCFPa6BRYjSEsrJ06RDqX7/FZ9GrUx1xWqzN5KbGYtxGLNJbvV/70?=
 =?us-ascii?Q?KMfXDu28pPPKs4mxXM36CchCmwBNH49qLd0I71KjPOhq5z25up9Vo+//E2jR?=
 =?us-ascii?Q?Cz3c+VT73Q4L7lvdAdUnCmOorBn8ZWcTsc9AsegFXNFzj4xVz1JLqqDeXK8j?=
 =?us-ascii?Q?n93SOZyFjAJY+29yhv095zgJldpkIh2eDCIJ1G8IfGBymxeFoEbWTiUBD3lA?=
 =?us-ascii?Q?iU1YA++cxXtEt+EZlCuoDjKe94a3sC125biCL6t2LXIYHjgoHcpgAK68CpbB?=
 =?us-ascii?Q?7HmpO3Hd8bUtAZv+FjG8URWjhIgIv+ldYXjM7PA36KdGhIQA9rCQxiu1tys3?=
 =?us-ascii?Q?J6sDpPf5E+3hYFnHDaoIzoaw6yN4U+4xg5XqSUaMW0+jxjEWTy0kzfg6xwlY?=
 =?us-ascii?Q?XUI7ALnb6W+JdiK9KoF9MQ34o4fK42o5xawhZPRueWu2p0FDL3BLdxU+mXUd?=
 =?us-ascii?Q?yfgduUDSxgg/S4cCNaqpgFrZ5wSLYcp2F1RgPWlhX6qxcKHI8X6eDvI+vRoK?=
 =?us-ascii?Q?+eOtDsZE3L2Wnfa379Ae/hOxaPo+xIN8W+qDjBmcd6pYVE4Uv5XGYgUnzM3k?=
 =?us-ascii?Q?fZV7kjVfaVyyCEoKvq/JMMyPINvrtuUAWuxvZjGODeUbd0ZUoRNBbloXTg3Z?=
 =?us-ascii?Q?+L6LiByoW3BfxfQ2XHit6T2wa8QEdObXZqrwn9UdSrSMPwU48ssX/CjCq6dY?=
 =?us-ascii?Q?QoOgYhMEDv+UJQAvhVCAGra4XagBd2C55VtgxQyub/2X0u2BfHRvPj+U8pGk?=
 =?us-ascii?Q?r28zPzoP5QTI1YR1V7Cq8KfrrKjRqjgk3AByFNUYivlPx/n9hovagcjPdCZJ?=
 =?us-ascii?Q?Bw=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 18700f95-8c16-4a2c-07de-08dcd11e9dc4
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 22:27:40.7178 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4puwyyPKEDQ9m2yVh0nLXRoAEFXxzdSTvdWGP0S6ZARPHT+LTfiHeBNgGyKfVS80wkBsApzotylTZp2oONaxBNXVYAnFvxooOjH19KvMYJc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB8722
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

This patch:
 * remove useless code,
 * use a special function for pretty printing of tcp flags,
 * simplify the code

The behavior should not be changed.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 net/tcp.c | 74 ++++++++++++++++++++++++++++++-------------------------
 1 file changed, 41 insertions(+), 33 deletions(-)

diff --git a/net/tcp.c b/net/tcp.c
index 37dda6f84f9..0778c153aca 100644
--- a/net/tcp.c
+++ b/net/tcp.c
@@ -535,10 +535,41 @@ void net_set_syn_options(struct tcp_stream *tcp, union tcp_build_pkt *b)
 	b->ip.end = TCP_O_END;
 }
 
+const char *tcpflags_to_str(char tcpflags, char *buf, int size)
+{
+	int i, len;
+	char *orig = buf;
+	const struct {
+		int		bit;
+		const char	*name;
+	} desc[] = {{TCP_RST, "RST"}, {TCP_SYN, "SYN"}, {TCP_PUSH, "PSH"},
+		    {TCP_FIN, "FIN"}, {TCP_ACK, "ACK"}, {0, NULL}};
+
+	*orig = '\0';
+	for (i = 0; desc[i].name; i++) {
+		if (!(tcpflags & desc[i].bit))
+			continue;
+
+		len = strlen(desc[i].name);
+		if (size <= len + 1)
+			break;
+		if (buf != orig) {
+			*buf++ = ',';
+			size--;
+		}
+
+		strcpy(buf, desc[i].name);
+		buf += len;
+		size -= len;
+	}
+	return orig;
+}
+
 int tcp_set_tcp_header(struct tcp_stream *tcp, uchar *pkt, int payload_len,
 		       u8 action, u32 tcp_seq_num, u32 tcp_ack_num)
 {
 	union tcp_build_pkt *b = (union tcp_build_pkt *)pkt;
+	char buf[24];
 	int pkt_hdr_len;
 	int pkt_len;
 	int tcp_len;
@@ -548,55 +579,32 @@ int tcp_set_tcp_header(struct tcp_stream *tcp, uchar *pkt, int payload_len,
 	 *         4 bits reserved options
 	 */
 	b->ip.hdr.tcp_flags = action;
-	pkt_hdr_len = IP_TCP_HDR_SIZE;
 	b->ip.hdr.tcp_hlen = SHIFT_TO_TCPHDRLEN_FIELD(LEN_B_TO_DW(TCP_HDR_SIZE));
 
 	switch (action) {
 	case TCP_SYN:
 		debug_cond(DEBUG_DEV_PKT,
-			   "TCP Hdr:SYN (%pI4, %pI4, sq=%u, ak=%u)\n",
-			   &tcp->rhost, &net_ip,
-			   tcp_seq_num, tcp_ack_num);
+			   "TCP Hdr:%s (%pI4, %pI4, s=%u, a=%u)\n",
+			   tcpflags_to_str(action, buf, sizeof(buf)),
+			   &tcp->rhost, &net_ip, tcp_seq_num, tcp_ack_num);
 		net_set_syn_options(tcp, b);
 		pkt_hdr_len = IP_TCP_O_SIZE;
 		break;
-	case TCP_SYN | TCP_ACK:
-	case TCP_ACK:
-		pkt_hdr_len = IP_HDR_SIZE + net_set_ack_options(tcp, b);
-		b->ip.hdr.tcp_flags = action;
-		debug_cond(DEBUG_DEV_PKT,
-			   "TCP Hdr:ACK (%pI4, %pI4, s=%u, a=%u, A=%x)\n",
-			   &tcp->rhost, &net_ip, tcp_seq_num, tcp_ack_num,
-			   action);
-		break;
-	case TCP_FIN:
-		debug_cond(DEBUG_DEV_PKT,
-			   "TCP Hdr:FIN  (%pI4, %pI4, s=%u, a=%u)\n",
-			   &tcp->rhost, &net_ip, tcp_seq_num, tcp_ack_num);
-		payload_len = 0;
-		pkt_hdr_len = IP_TCP_HDR_SIZE;
-		break;
 	case TCP_RST | TCP_ACK:
 	case TCP_RST:
 		debug_cond(DEBUG_DEV_PKT,
-			   "TCP Hdr:RST  (%pI4, %pI4, s=%u, a=%u)\n",
+			   "TCP Hdr:%s (%pI4, %pI4, s=%u, a=%u)\n",
+			   tcpflags_to_str(action, buf, sizeof(buf)),
 			   &tcp->rhost, &net_ip, tcp_seq_num, tcp_ack_num);
+		pkt_hdr_len = IP_TCP_HDR_SIZE;
 		break;
-	/* Notify connection closing */
-	case (TCP_FIN | TCP_ACK):
-	case (TCP_FIN | TCP_ACK | TCP_PUSH):
-		debug_cond(DEBUG_DEV_PKT,
-			   "TCP Hdr:FIN ACK PSH(%pI4, %pI4, s=%u, a=%u, A=%x)\n",
-			   &tcp->rhost, &net_ip,
-			   tcp_seq_num, tcp_ack_num, action);
-		fallthrough;
 	default:
 		pkt_hdr_len = IP_HDR_SIZE + net_set_ack_options(tcp, b);
-		b->ip.hdr.tcp_flags = action | TCP_PUSH | TCP_ACK;
 		debug_cond(DEBUG_DEV_PKT,
-			   "TCP Hdr:dft  (%pI4, %pI4, s=%u, a=%u, A=%x)\n",
-			   &tcp->rhost, &net_ip,
-			   tcp_seq_num, tcp_ack_num, action);
+			   "TCP Hdr:%s (%pI4, %pI4, s=%u, a=%u)\n",
+			   tcpflags_to_str(action, buf, sizeof(buf)),
+			   &tcp->rhost, &net_ip, tcp_seq_num, tcp_ack_num);
+		break;
 	}
 
 	pkt_len	= pkt_hdr_len + payload_len;
-- 
2.45.2

