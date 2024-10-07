Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B384FCF8870
	for <u-boot@archiver.kernel.org>; Mon,  7 Oct 2024 20:56:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B981D88618;
	Mon,  7 Oct 2024 22:56:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="ENVuC5R+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2379788618; Mon,  7 Oct 2024 22:55:58 +0200 (CEST)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CCD4688D25
 for <u-boot@lists.denx.de>; Mon,  7 Oct 2024 22:55:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O1zl2ulNxFCqY0FI2H++a8+FgNR0N4jkj1NBOw1zqlbOxfO2IvK/ImRKxcv1/G3MvBQRsSFoQSZbup6DDwcgSFn6V7LGwLLZJPQ/qLANQhfL1jYoNA4pF2UJ849PYd4qJc7B7Vs/FA1rVtkWGLk6z70pLQ1ll7e1BRgmdz4SSmrunxhhg2MhKDQJ9mPGpyWiPWQP6Rs7rQRcXR3MV4Jt1cS+pZZbOuLSau/0Mdm4Y0V0hlmuwXta5p/uJdzuiRbgpgF+sIMFgi/K2QiHcOoggFrp0HBIJRm3w8sNO+4Z0HEzbfzaFWKJl4ZsxZamKaI4sxnJobtDe0XmHSClHZdzog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BEz99YBS3mgQpsbqTk31psHOSp1vBUbPdtOGEPpO9Vk=;
 b=NI18QiYhoYjj6x7O3qGFeqGBhE5aq7Mn3UWM8uOZE+2nDzEI3oWYaoL7bVngslFfG6GnHSw5vYb/GPFf8ldXGI3hkgnXBPNm5Fa/JkpOVeHQ6W39jV1inYJiznJsKmwQObzeTwoGenxIe5E25jLHWslrFe/ywpus8J96w1YyP1/szXnLrmMfXxxAZ6iuCYYa0H4q0lM6vcafDwvspho8SFclFVl9Q3oQlYhlzMO6DvljRrTuPNOFsaw/HSUsUMTlJIu6eZ+Dbu/LAOCj/repA51bU3R+sm0iVgyC8VSXklXelg8TbbWdptSpoX8b1652kZvXr9qx8Qo2aBSEsuweQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BEz99YBS3mgQpsbqTk31psHOSp1vBUbPdtOGEPpO9Vk=;
 b=ENVuC5R+kJ8PAowSXWfWqP+hixMrr3ktivLXJmiv8MmNU5wm9bXIPKlLgugE2PvimMTBUo19v7Gct+5lZF3KAgqTSVOokmVlDl63lgcgUO9E+ACspWOzZWQNJI7/E/MlKpKteA31MChePXarmEK5mgEkhSIsRvPkRE2o9V8jrHDTcnEEwGdg5G0TE8nz05z+9YMp0G8NULMBMZZjYdJbh2mTTloFhlAvnjRLy80S8dFQyseFVjWSUtar05b/cvAUfvjJQ5W3mG52w2hlelrNYDcx9VYeKvXmVvRcR3kqvNh1mQ+odrpCdAeBjsxGbKaX2XUzHiF7+nTjhZapKp03Eg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS8PR08MB9018.eurprd08.prod.outlook.com (2603:10a6:20b:5b0::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20; Mon, 7 Oct
 2024 20:55:54 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.8026.020; Mon, 7 Oct 2024
 20:55:54 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sean Anderson <seanga2@gmail.com>, Baruch Siach <baruch@tkos.co.il>,
 Anand Moon <linux.amoon@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH v10 01/13] net/tcp: fix TCP options processing
Date: Mon,  7 Oct 2024 23:55:31 +0300
Message-ID: <20241007205543.1632499-2-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241007205543.1632499-1-mikhail.kshevetskiy@iopsys.eu>
References: <20241007205543.1632499-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0394.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:f::22) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS8PR08MB9018:EE_
X-MS-Office365-Filtering-Correlation-Id: 2550f6cd-272d-4185-b639-08dce7126f7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|52116014|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rkYbJZSMq7yMls1CzZtjQqlBuJiXUayA9SLJFHyFIXCxQvAo7zEMXm5FlHIF?=
 =?us-ascii?Q?twnaN1NEFGBF8tFfO1Zrid3vk07bapQR2DNB3uhq8JG3FDUs8jncW8oDxNyf?=
 =?us-ascii?Q?yHTIEcDmxBdGugLf7exMa65lmgEsPUPGDB0AGQNNJ9ouGcG0xk0JZg/JvUgI?=
 =?us-ascii?Q?kJkafdVr0/44NYrBpapIxxvFeR4pU25vFzPAnczj4n5MYD+JZ3ByUlvbg57i?=
 =?us-ascii?Q?BgfNIx7pibi/1wwDrYqm8PZxAMNV8ib1sqL/+indi4oiGweP+wFnVBwsvyLJ?=
 =?us-ascii?Q?TD3rgS0CfiZKYmoqQx6Gdb7nNfq3OT0orKZvCTnc4CrgIkud4ASPgbq0j3uH?=
 =?us-ascii?Q?45XXI9licxzScNJif/Vbb2rpvCAAZvZZMT3yTxdCxneiT00wM5LMLxskFSVO?=
 =?us-ascii?Q?PfBPWXAp35kdrWc5YD3JwBGzf56p3818cHUh9bAKAtOoD160H32xZyNyGKh2?=
 =?us-ascii?Q?OvvqBj/Ef0r7g3aXaTw1f5Lc3NMITiZLCaPZWhn3pImyI7AdwULjIaDJoY3B?=
 =?us-ascii?Q?q0zZPdM1FN16vTmzYWLwXIX2F7vYww5xYJ2OvUpEPC1W4hcUzAmgrf1WQYc7?=
 =?us-ascii?Q?hfUqWwfpzvScfi6OO25QS0Qjgm/hTsD7sFUMpanveYpVDXkQTrq9NwWlO9IS?=
 =?us-ascii?Q?RnaFHU4ZVFVo003znaX81zaCTZgv+eBEVhUarqBUJ3Kgfx+6lFkeWd/ns61I?=
 =?us-ascii?Q?CuN/9J2uwQQWm3k7Z9md9cvocInnyqFLmCivvjsxl0uZkd222TYSVY1gyPEO?=
 =?us-ascii?Q?8vnse1G9gZtwvtwKpTIbTENrHCuFyb+VDxwgeK5pR1q/Zk7JQOL2ooO7yExE?=
 =?us-ascii?Q?c6K1n6HklCwTyOt6f+6sN4YqjsJvTD18IboCOKkCzUAIzTVquHJbP+E58loU?=
 =?us-ascii?Q?SN4NH3HIGqfaoqrtoIzNb4DWUYu9SKMUm9qcqyRysGNPKerarGkn2DtybcVr?=
 =?us-ascii?Q?CrSTsENPqhQZ4ulgbKtp5Q6pBlxTlshW66KmKpyVc/dw1sY5P6eie2zN5Xks?=
 =?us-ascii?Q?Y53BnB5LI4UK6aZg634PDT2DmL1SEGrA6kVUysEodlOBxUVyGvldPDNYNuty?=
 =?us-ascii?Q?5tDTdqPmXtqGWj4bYMu1AVrSSSEGzrkO2BhPfcofmqmV9irzte19Uv8aRoPl?=
 =?us-ascii?Q?8jLcG6ATXEfJw+y1eFL7wGg5engUPZe/6XlMCFLsHUkedoqGxhIYGkg1BXtA?=
 =?us-ascii?Q?EslWdz09XjcXuPNvTyRtZuhD2xWOaG13j6gupRBswlpgPB5kKc7xbmateIFE?=
 =?us-ascii?Q?o3vCn0DC5wm12ZJYUss7mQPCiBECUywDkx0//3D1gfLNgdamHDRlgIQBu1Pf?=
 =?us-ascii?Q?dgTYAxNQ4ChCACGkfWXs3Q9WzSUwK/GbU/9m5eyyko+G7YMpa7ANIopXO965?=
 =?us-ascii?Q?zPwd8kU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(52116014)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2yXeUhFOr52sZaSMPbaZiU1u8Pd/16GopMIUGlMusUrupwXAIgbpvhBZoBS9?=
 =?us-ascii?Q?aAi+JFPJkgQJWkedX2TnT3fTgMLZDlbr086PImiiRjWMY0qkVK1mcujmk1mM?=
 =?us-ascii?Q?V1NngXcmb9KylWuMT0NgrDIaSDVs6wIbsCnQqBaUDiIOYVjQUtxcZ/0C6H6M?=
 =?us-ascii?Q?0qO8lnuEX8OVcRqAP2KV+X5sq50jZbMYicCFxb2tM8eYv2dmlj7e6atqbWNe?=
 =?us-ascii?Q?kNML7FXqTbINRtUwf846zb07h/y5xBJRSopNSh6ZahqK+syXtLDtttEzbs4o?=
 =?us-ascii?Q?zHA8xPHCI7FDo7RDO7ApnDB1nCOAiUE+AI5fSC8ry/tlUCvrEI7NSAdK7pEi?=
 =?us-ascii?Q?vhTboR2+H1mu8hbkiq+dfumI1LnVDhYxxt+X1luXddgyzn0HhSNB/zRzUtv/?=
 =?us-ascii?Q?4GAPq0HDUC54yJgJKu5C27wx7eTMDX4BJXMZEut/Mdv1FVGSb7MvtdTd2E7v?=
 =?us-ascii?Q?04MHl7QW3uxnierEuqQIxfjWWf7/fskA1JaW0uaDQF8JqxfxEQzBN4WvWp3R?=
 =?us-ascii?Q?KHtI3VLXclfRQbb1wXxufc7K64Mj82xY34Iu9Dd0YV9loncDyMOflBQ1Zw/4?=
 =?us-ascii?Q?CItOj5Nl0hvhK7DM2OYb8907Adk/MubxsuO1dN2UM5B+pIHBgJ8w/UeETxvA?=
 =?us-ascii?Q?TrSre3U7qFFi5R0ZGutrS6haknpIoD/dnZpGA2QylQexir+iyWBUay8MEQiS?=
 =?us-ascii?Q?78brfduPTZpxK+jJHhK5ex7Q9ERhX/NEAGaTpbO3AXMLFI6eeLUFpCN4RKoW?=
 =?us-ascii?Q?cNH57cZkwfW7FEfvwNcvguGSGt4sQXbegN2oSv51ZzKpgj55yxNuRXvLS8rO?=
 =?us-ascii?Q?wNykNFzsMETfYqp6dGf1RH6hD44S5MdtCgQ5fCGR+IFmMabcz6W1EFuHJ0hW?=
 =?us-ascii?Q?ldiW6qXqhFnOJQzGKUjO6ohIOCe7ZGxUG6Ot+EOLXS4GDmw7gO8dvgAFVUJ/?=
 =?us-ascii?Q?03YYeRTsotxBAmDVbwKoiWQY8ZsKYY+JPBohvJW3t/Qsl8fHCMzPWmQRQdMr?=
 =?us-ascii?Q?ENx2t7Ih5eULK2HXENvprhVo6t/BMJ7BtPb0pylTu164JJnl5elg4sOQ6J+e?=
 =?us-ascii?Q?dsmeWMzr9hUYcX+q9aYm0maexNd1rHofPtqPtNS7nxvrrFcGMZ4VtXaJPYKX?=
 =?us-ascii?Q?1rAvQFXXd4sUEIJcLiO6rmq7G0NX9CIEkY5QtppLzNMbrPyjZk7mqiB+b6Ju?=
 =?us-ascii?Q?PdOSROCcOh/WkDWNCLxhUfDuuOgKLTpGgaxL4XiLwgln0Gw0LOuNGtVsVndi?=
 =?us-ascii?Q?8+ukaGTgI2n38aZppJoLycDjhuaHGO5dxNRe1b08w7/+5DA0RATkOo2ZQqma?=
 =?us-ascii?Q?6ktyJCHyIF3Pn1j+9xDLvF+0YhnqfJd1L3qiGQvB//8JMlZnz7R4gp1tP6CO?=
 =?us-ascii?Q?h/jq1Ruvcw52qDp6M5cbuySR98K0fMBA7fze5zI0y8xqtAZKoBvnIMPqts+D?=
 =?us-ascii?Q?ben11GmHhZnvJDKhztDAnDN6Mgyzys2/EfonYESS4QWiCEZGJgvWP79ckarl?=
 =?us-ascii?Q?wx4squt63VxGnLIWlo/q7RNLs9uaHl+DWJst7nm1zgX6/NQV0qo9AVm1azlo?=
 =?us-ascii?Q?vSinjmr5n7FkqdBX0CrXAx6KZAvf3IgKzJjpE/eLYBRHlAuF8FlYYgk7moxy?=
 =?us-ascii?Q?0r0SJ0+eONo2hk615kluYAY=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 2550f6cd-272d-4185-b639-08dce7126f7b
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 20:55:54.7762 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q3tr08bIXyf16+eKQaF44Q+qfeSpTH5ykz5cHfWMTtEM7aNLnNuSIamBGW7+E2qvGHJaKLQmm7m7jQRHWRG4aHCPRems5TaN4yfQt5EGzJo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9018
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

