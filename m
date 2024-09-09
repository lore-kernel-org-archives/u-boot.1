Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BF61ECE57E
	for <u-boot@archiver.kernel.org>; Mon,  9 Sep 2024 22:27:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CAAC88A2D;
	Tue, 10 Sep 2024 00:27:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="wrZFU5qO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F0D888E5B; Tue, 10 Sep 2024 00:27:38 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2070d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::70d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50ACC88E5E
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 00:27:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uFsXRwI3dx1AnAtII7eSgSp7YF4WowEP6sOlxXwTc6IcjmrpTHeJcsyh/Z5mXT44QZZ2bdvtbm3QO0nFyMd6fWzywIc7h/MLeaZjO9ntmAzXySku4Bjg7ToHMXvEoYC9/2rYLI6bz7aKNk4nMGWjbGpBlX5DfkEEWPVCr0N31wF/2SWC+Ks4fWg0GRSYt99YWt99pqmeHyq8m5MkQNJoFybBgQsZbIUwJjswYs5zO1/Z/ZUS3IHdLsWKKHogqMe9gqoXzvlRv5Q+kfrDMq3hKubm53FC71YD2jn8qeOQkewdBlojfQ0+eka0qdpZ+qW1SbJGMRu8eoEZf64Wnk72pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BEz99YBS3mgQpsbqTk31psHOSp1vBUbPdtOGEPpO9Vk=;
 b=Xldqzhg3tMIcsN1jtfatLfK+HHIp1rsVd+f1qVDyAF+k3lPMj8bWyU34scpNcFPXGE5o64iprSRTAjPw33QYdVkjk7Z3YgM/rLwRKDvzFRLKtjJZ9FGHTXIVSzp9fE4W4vkeIkj2ZcHZTuSYwezlQSGNLMSRSQVr1s9frc85anVVS/hAt/ErNzU+MJClHPoKwf+h4MB8R3HwCWuDiDnMJKmKvhr304AOBBTjw5uLzF8SDPGGk/5tbScQXiM6e3zJtFVw8EF/q54vDgYZwxHN7AdUkA6ZHkbiU3oHW7wJwSwwoe+Ke+bjGMwKBryD0BEkvcMM0KjZU/MwMKW0jSUpVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BEz99YBS3mgQpsbqTk31psHOSp1vBUbPdtOGEPpO9Vk=;
 b=wrZFU5qOpSFj5G8SB83NilJ0eCb4ln1PelTuhz5N57k5wd+sIhbe6wTAiOtx7tlU17ggNHcvJr78ILkdxfsYqhPtgpNub0ZGMTWNhsc4tQhMP0I+0K/oB0xYOdKMzXdpDmVMQdnbZAj4RpfjxtUfrikq5gtBhx51ydQZmBlUdTjIefUnNza6FMzYjeOMfpLLws3jjs6wD3lAbJVhB3EDiUdJPO04vybkMW5c72IhdI/boO+iRE+giV/5r4Zm/unDjixZZaK2IaOahFaRBsDq5j2phneVg1bVXx27QxDTBK/TXIPK/DST/kJFA41uhMYHz7slJxM0jzjWK7AFYVNrcw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DB9PR08MB8722.eurprd08.prod.outlook.com (2603:10a6:10:3d2::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.15; Mon, 9 Sep
 2024 22:27:30 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.7962.014; Mon, 9 Sep 2024
 22:27:30 +0000
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
Subject: [PATCH v6 01/12] net/tcp: fix TCP options processing
Date: Tue, 10 Sep 2024 01:27:09 +0300
Message-ID: <20240909222720.2563118-2-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: 85f68382-e1b3-4160-8741-08dcd11e974e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|52116014|1800799024|366016|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yX6RKpl1YvWssCouez7lqF4MoJngSt4Pz8b7B8LW1Z8tM+SzIbiMUZuqrkai?=
 =?us-ascii?Q?4eiYXIVpFrqlVAt9MDmuM80l4nnZQ074e6crMsvKoWcKNN6EQ8CYHPcwRXQ6?=
 =?us-ascii?Q?qyHWCeu/y/ordr6gruDQcQZRy3QagWbrUJR/OzQtpznKVGiZtPfexwWvMEGr?=
 =?us-ascii?Q?m3CLVkXfmPVK8TC0M4+LAggprOyjCyOXhrJ8RRh9ExE4z+CVM7AFJF3wlJMc?=
 =?us-ascii?Q?JvAsZFXOAs7nECUdmfoDb9CAdgyl99eRMIWm5Y7oHsaGATkqaGXv/U6S2C1h?=
 =?us-ascii?Q?ZwybdY9POQ9E0y62qL8yW0kggXaafwLUVgO9WETzWHSIC1loHBJ5YRGQD/ZC?=
 =?us-ascii?Q?no3nF8rhcOJBF9JvYm1tytcT9gcPtIRDFD9SuCBof3sH+VT6GZLroXPGqDs4?=
 =?us-ascii?Q?4MlIB3u41/mNDRRJaURSkCToXu7ZVVUhAC2XaLT3G3ku9jPsALtiBifH3qEN?=
 =?us-ascii?Q?P3GwTLnm/XX78dvFz2NKet8JfGrLzJurdS+lFAA0L9e3GgZNCF0pi7o4fLtp?=
 =?us-ascii?Q?8lgDkAO+myV8mqJGIq4tasZyyk6VPpX+zwWDoEHnlCcV+VHcWdZBAoHzeuiH?=
 =?us-ascii?Q?AXCIDCxtDZZANsPcjB1j1WUiPeRJwDMQWJvMDwE84s+WTA0w6MSE94CLvxSL?=
 =?us-ascii?Q?BytP1Cf71XXpRgRD9jKAgMCblClnriU+ADFMdm/cgzVce3W6tgnWAKeRoSIE?=
 =?us-ascii?Q?xa+9q+UZgXZO09sQIQJzt8p9nx5Uo9jBTqNmZIoISqNdFe5Y4SgSLWFLpP1Q?=
 =?us-ascii?Q?JCag5Z1TA9TRr7PYxLm81TqDJX87u+OxuCZI0ObTvkWDUj4+9Lx1FIHXoLiT?=
 =?us-ascii?Q?j9iYL2DiPTYeVvJul+R3Ivj8LdJLo0/1qjSBdhMQG6QBbcQRRRdUioLJ5s5G?=
 =?us-ascii?Q?pujjU3gkDTu/ku7jGkySRXhQg/gDzsU+LPcKw5XYFf6mS+7vNwWAmwfnQuEa?=
 =?us-ascii?Q?gv3Pvg7Kw9jxqkuzz9oidJu9h2jCr7BowyotnFk5vv7Qgbl0fp5ByOR3Vu7V?=
 =?us-ascii?Q?4lvTU8d+xOb5nhGyX61uiTqRAdWSDbcGiLqXpnEY6ts4i2O0SaZjFnyrDeWX?=
 =?us-ascii?Q?s3zMsdnMN6YFPDV3mxyWX90saxgzHFDjcLKLSVquXUMBzJf+pkchCzgf5xIW?=
 =?us-ascii?Q?rrtdky8aNU6wBEwm/kS3wZzniTAyF9E7z33kB2xvUJg7jCwJ7RDk68vrazx5?=
 =?us-ascii?Q?LkjMg4fgUj/J/glJZ7grbiV95rNcsWdujbnCbUSEOVbLLDvWuOWy0iwwYZPf?=
 =?us-ascii?Q?+V4rgkJhtLA0i0CedXYu/czwd0cfs8Dwza+jsUKDMzKDaWbQZtd3seC3C3ug?=
 =?us-ascii?Q?LVADh2A6FUfOOlzq8so25DVzBIY59eHX9wXSPinYCY9UvrXQ7ZCoYKATCKr2?=
 =?us-ascii?Q?k0UQ7tPDkW18GA072xvIXV1fgbTDiBwm4cmB/t551n3vVsgB2KDvjatqdLCn?=
 =?us-ascii?Q?0YGwOBabq64=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KbYKjmuDk1TkoeC6U+S3jkwhieei0aBYhsvoIlgaIEE4Ob4cKbi69WSPq6YE?=
 =?us-ascii?Q?pZYtjwMKLI0wjCuhCPPmFa3a082gpgJuUuKRrwGypHtoJKQPXpmmy7t51CPk?=
 =?us-ascii?Q?xBagtjpsiGkRsZJgU4okXBrlzerG39vQvvcIHddj32HMBfreKbdcPtOfQXgY?=
 =?us-ascii?Q?rGVnyMOZk2FrHe9aK2BSNpJ6s+HB8lkplCm+jCIWw0Wd2yIByVlZBV0L+vnU?=
 =?us-ascii?Q?bXQ7cRVCO+5FUALDQIEfNiJBjltDo2esnkWpk33eEQD5w9XtUBwendglB34Y?=
 =?us-ascii?Q?CG/k3DXB0bp5Ob3q5uAmUSSLrSTUJcmIRf0wTB9JCg0aIGfgs/Lam6RqonQx?=
 =?us-ascii?Q?itarbjArTpnZgwrYX18iXNQAKQ8tOwvYu21ZhMQ6eBGnUHOQGgeSoqbzHwTj?=
 =?us-ascii?Q?HD4lZ2rzMipvT+t2bz37vvzKQJ7B/U42I54fWQE+cLUd023Ztf1EB1XUrhaa?=
 =?us-ascii?Q?Rl8CjoHXAoobkcQRe4mpHrCVRiLxOsL7YL/z6RnTlBKOpIxc241Pr9q2CRkW?=
 =?us-ascii?Q?hTI5496Zr/94ES+dWAnTmKResqwwud4c5gpp98zGV74q79HsDddhnl2UmC7P?=
 =?us-ascii?Q?qDy5rR4WYYgxrjshVXrnC0RlBwtn4qAC4OACZZo0wma/nGHqkZGE4lhSSlsD?=
 =?us-ascii?Q?AjkkbRHIM1d95iAYNxjOhwmGTOoTP0EiHao3fAlbdkQ12akTZD2l8UpOjova?=
 =?us-ascii?Q?Z4kRjwaPV78+A57pt06GqnDXOBs/VVn47ABl+8lDa71kkCHZQvv6GPxZwvGU?=
 =?us-ascii?Q?tsysSYp0b2uEmg0Z/qElXudBMPZib37nxXhEAvOPJan8OPYFv0B/tXb04whg?=
 =?us-ascii?Q?ZkOvLPpeCl3eU4UpnL69ZYmXI6PGPel/inNhXjY4oEQd1nYYa7urh2p3AEUZ?=
 =?us-ascii?Q?+fCmJZMsi/Xhl4MPTD9eFUQP5OEG/TT2PhSmrLHDPAcv4mQwf5uXSB7fK/oc?=
 =?us-ascii?Q?Otx7CfKvm0bSWg+SckI5rMtozQvYNHqGL1o9qgxZ9fCeIkMUZEIJ4c5BkXTH?=
 =?us-ascii?Q?HVcPLkMRLz4zilnEJmUjafpe6ozdOGaJ3zyTMvRyIjI39FCaw+VPeCrfCgVg?=
 =?us-ascii?Q?TC+Oz1t24VcVyC0BWjBgs2hZf2KMuf8LIxig+/6zIHuQ2Ho2N5KUwh0lMwQ4?=
 =?us-ascii?Q?bWJSUjif9klxbrcl3sr+kAro3Ik2iy/PrvQ1gwzELnncvmO81AeC0zyBkilF?=
 =?us-ascii?Q?+7PXzc1eWkt/93mbRpab9Nn17D6waa5jYWnBmJ49Z90g2wlhVg0a7Tt6/J4T?=
 =?us-ascii?Q?6PJgsm41OYBdMNKrqPFf/onr+zQQw20oZON+m8SkVdoeCTMGXqq10GP7sRQv?=
 =?us-ascii?Q?BH8nbTLRmdvwoiUOmQ/vxVuzqwj/Y5gggsE9wFUMp7Qsz4Th0XoYM/Vmmsb3?=
 =?us-ascii?Q?Dj8HuLDzETN4FPMEh/2jm2ivXAQIUCBe3HFX7t0bZ95aIrlcLcJjfp3oIknO?=
 =?us-ascii?Q?YvMtzhz7GqQLil9D7BU9StNjIgKc9znKYJSNDAFAB/xaOeiwi9T1MAmkp0U7?=
 =?us-ascii?Q?EuG28lWiIwxjEkWeHav3hkoOn9zFqqIe/qI4ABWoRbcJXwRcuIkaFZNzX/Mw?=
 =?us-ascii?Q?UOTr3r6vhw++pIY2pArpu98GIbPGmzpsDS+v0c0ooAGG4Iwx/7RaMaH3M+dU?=
 =?us-ascii?Q?hA=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 85f68382-e1b3-4160-8741-08dcd11e974e
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 22:27:30.0078 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: piE7bpzWSF82e1gOy13iqMQ8mCDGEIIDjAMAiC5IIKMn1mCYgKggtY9fSAk3tmBGfkWdyDdaqwtzhLyWjSLPBvujasyUSx8eX7WyloBZ4nY=
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

Current TCP code may miss an option if TCP_O_NOP option was used before
it for proper aligning.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 net/tcp.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/tcp.c b/net/tcp.c
index b0cc8a1fe3e..3e3118de450 100644
--- a/net/tcp.c
+++ b/net/tcp.c
@@ -475,7 +475,7 @@ void tcp_parse_options(uchar *o, int o_len)
 	 * NOPs are options with a zero length, and thus are special.
 	 * All other options have length fields.
 	 */
-	for (p = o; p < (o + o_len); p = p + p[1]) {
+	for (p = o; p < (o + o_len); ) {
 		if (!p[1])
 			return; /* Finished processing options */
 
@@ -490,12 +490,14 @@ void tcp_parse_options(uchar *o, int o_len)
 		case TCP_O_TS:
 			tsopt = (struct tcp_t_opt *)p;
 			rmt_timestamp = tsopt->t_snd;
-			return;
+			break;
 		}
 
 		/* Process optional NOPs */
 		if (p[0] == TCP_O_NOP)
 			p++;
+		else
+			p += p[1];
 	}
 }
 
-- 
2.45.2

