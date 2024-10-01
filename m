Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0497CEACF1
	for <u-boot@archiver.kernel.org>; Tue,  1 Oct 2024 18:21:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A0D689271;
	Tue,  1 Oct 2024 20:21:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="s4BB0F+X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46DD689207; Tue,  1 Oct 2024 20:21:21 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20718.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::718])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CC818926E
 for <u-boot@lists.denx.de>; Tue,  1 Oct 2024 20:21:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yCZaly60Kg5/pPijq6sRlOrwwGTPE9xOwhxDf7IqVpHtrCTCOJoVTOuFadUFPMuArpSTqd86c10HLGhHmTa5f+8NEmLvotxQRIUYFIOpOBb8pvCNTXHWGsedqBidgxt3ydXgPd5WTS4HDNplRJbQ5dIvFnhMmcK+UzstH4VOJPU6cSD84Vq2TTZhJOuj2dVUiDrvbWNJryeJy+f96u2zpYb3rEhfsi0+1Gd7b/iVakiIICIERqxJthYoUxVHYTnW3bxeoV1eICgDMoQsgBmi2beqbcEOpBA5S4u6wCo0mf5jmAoN/IEVrk1STDQtTrt0JGflBnlmWySnZx1gYT7Fqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BEz99YBS3mgQpsbqTk31psHOSp1vBUbPdtOGEPpO9Vk=;
 b=U78RBinXPMjXCzO1ZzuAAYX/8YbKFaYv3dvxBJssS9kfoYGmsWo5+6SGs4SAzB8rtpow9z3LdJ4Te4UTcT/orNuGK8t0z/qohcVkLIEosb/ouYXycGYIQnAy0ae7VJDX6t6MD/khOCzL4C8C7JfQYBQxYvvja/WjT+852sBWwtwxFdLEpevyNiCHOoyP3nnf23d8y2El6oBJUHvPv99kLztjQkn3AQhHKsgCaqjn2LITevnQhkF511P+irYi7bkP8GaxyZCjVbwz8Uv/NswooqEjXveviAM70rlXCREbkktKeg4VF//KcpGiShm42wlCzjsLRx7l9LTzsjRHGr/vow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BEz99YBS3mgQpsbqTk31psHOSp1vBUbPdtOGEPpO9Vk=;
 b=s4BB0F+XPGiXjgZU+3N5EP78ad4x892lf6Su4pUx9X5e6Sl0UEsZufwzDUMnywnKRK/v7ZMtbiO3llelH+4PjAQOZPg3H+Pgsz1sst/s1sV8vCprflqMjNFrTXGwHIlUz6CVmzDjDIbRO0HxZ2lBIekVhZVw2aUm/SBH7SOLRUpxHBoQibGOFoNOx4Zj8JR9QJa/7rpvxZuSELKm8weo960Jhd/R0J0RBLGzTYG5JgdjPo8JI1o9OLtIHyy6zJmWqMctOO7617yTqmjsQefV6e7HCxJnADib1TuQgUJujY7ugOz2IWMVDNIPHUit0BdQW9e3NhSvWEqqWFWXyrFZYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PAVPR08MB9188.eurprd08.prod.outlook.com (2603:10a6:102:30a::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15; Tue, 1 Oct
 2024 18:21:17 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.8026.014; Tue, 1 Oct 2024
 18:21:17 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Anand Moon <linux.amoon@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sean Anderson <seanga2@gmail.com>, Baruch Siach <baruch@tkos.co.il>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH v9 01/13] net/tcp: fix TCP options processing
Date: Tue,  1 Oct 2024 21:20:55 +0300
Message-ID: <20241001182107.907828-2-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241001182107.907828-1-mikhail.kshevetskiy@iopsys.eu>
References: <20241001182107.907828-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVX0EPF00014AE7.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::311) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PAVPR08MB9188:EE_
X-MS-Office365-Filtering-Correlation-Id: 16445417-a316-4953-eac9-08dce245d726
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|52116014|1800799024|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?a8Tr0XoIFDgVJUHj3E64k9atGzI/3B4rD8eXrle2ixSztJ2G2G0vS5zikvi8?=
 =?us-ascii?Q?PYYlbMTTx0aVGua0UZQBvJenYxkZ3MZYkBxq1Uu3wdw2q7fWwtaib6sQJLak?=
 =?us-ascii?Q?SsPrLiTqaDkspFWbNeMGVcpFFoOI8z2x/q05VgVzPGzGXmZoMeTH6PH203it?=
 =?us-ascii?Q?Gz1dZshPgWJ8i8nBs6AXS6Ip4o+IIg5LlElnXQsVds29V+c9T4ATkPq8dvgw?=
 =?us-ascii?Q?eu/8yJZXlXMZGfH+25Per0k4DVL0P7j59deHGJCXJr8EFfpvo+ovVZUxonIC?=
 =?us-ascii?Q?03EbuR6MdaQYyguHf/OuPk77i6OKenG0thko4Kqs6vYpwtifbK1IdJBq1i1v?=
 =?us-ascii?Q?/FkuKwVwg5gyV5kgpa2nnqYlDkF/Lelr7xLeBMDLXT0mrkYgwXwRSgQKRWwT?=
 =?us-ascii?Q?KIaO0hmp994bnoCLEL7TWLiYTXw+qxt71GzOAR/F8zfqw5pysDsbVImBZRy1?=
 =?us-ascii?Q?PDTW5gWYiif8Zxh7sYjHqpwEtpgAfljCpQ+zSvYGDo3R5lEeUN7bAhiNZoZW?=
 =?us-ascii?Q?vl6/xR6MIb87fmyOvSr64/fR1W7UhpaKYCv272fX4FmlCQfjE0ca6/VUIi3X?=
 =?us-ascii?Q?DoBtdMcZDAkHnwHwLf3nArAdNNFb/5R77W14+TaRCgqCl/5rPKfPUmEWmX/X?=
 =?us-ascii?Q?lbBOZZAHEz/srS240FPksVu4L1SuB8guaq4Am0RhCLWA9BrLAaRx2JYf0slX?=
 =?us-ascii?Q?EtqnDKvfS3Sa2VnaZtViNvYX66OW7AaJ8Qy2PWGbRWh8qvJ32gOSCHYlcpc6?=
 =?us-ascii?Q?Qt9Hh2pTvXmMN3yycWhRZA4ifyxrVXLmpIPAjFrVjcZrXT7qBqFoV3AOXCVv?=
 =?us-ascii?Q?vlrbVrAMDLv54GMPEoiUhU2NiOmIqsH5OrRpVAambH9f3Nssb1L1eqAxfPAR?=
 =?us-ascii?Q?WNnAprbLrHnbNYPDSCM2jjkgP3lphOOSuIy6+mAOK9MmOXSIvnVe6FUAFbST?=
 =?us-ascii?Q?ALtbGpDqztH/r3vQi34pYg5qKpLVR7eJLlbVrPHQsJeMkFvM3DjGpv9BaND/?=
 =?us-ascii?Q?RPZoBd1Yssi0ZmVhpW+49cYWdRCZ9oBJnT0OtXqBzF6jFoAyNUyEg50u6eSp?=
 =?us-ascii?Q?/fZPZZocsOpftoFzwoY68PhQNzMyfAIF4UaRQunlbI4SZ8EIW/BTDeF8aW7g?=
 =?us-ascii?Q?UF7pP2A5DmsgmLeLurwUhY5kZ6/Yjb3CCPxbukWHNGL1ZWqDiIcOAcwc1H57?=
 =?us-ascii?Q?WVmhJrv90Z6ki/mivGEA4D+R1KtcgL2lGd5076kW89LqLkeuJwf6sYlz94hg?=
 =?us-ascii?Q?swMEIqpVdXCrX4wLRZTkHBIANuYCDXasqPHoZZUFd0b2q2h6NfBMgypbglKR?=
 =?us-ascii?Q?e7yd1yqgdRZCZM6ftDMXX8j33Wv/+MfI7lP6jxMeWHdQJKz+e+8PCU6ZFMET?=
 =?us-ascii?Q?sMCpYZ4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(52116014)(1800799024)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DfbZEUt34v5njPflptTHdtRxWL9Hr7i/E8/U9wrwlsVFeOtg4bdiPpvJYRpk?=
 =?us-ascii?Q?ZLCFCY1qwFH15z4nuNruNdlSGziYD+0MLCfpDlS7aKBPBjBnxvzNTSWHDmOz?=
 =?us-ascii?Q?GEP3Hsse78ahanC2/XKuq3cwqOtJQpZnjKTcH9TeuQ4Rl77IWn82hTw+wfw+?=
 =?us-ascii?Q?/dav0EsIem+1xn8++R5xQmzv3qJenw+bn7Cp4gTmny0IwLeaN9R8rDZMsGXy?=
 =?us-ascii?Q?qErl0ifsVIrrygySb8eLTnyKP+vvmXuUGU7p1akOIS1TJKjp+FxsxB9U2IdH?=
 =?us-ascii?Q?AaS0mLJp4u4/nFi/u8H+plDLvtRLo6W6Ov11VgnToy0rb2W9FZZvCcUBYqkM?=
 =?us-ascii?Q?Pv2jtOV1Fm02o4X97zjVG/imd1+/PhG2iFQqo+uEBrl+LSRQxtmePf41kgWm?=
 =?us-ascii?Q?o1PPMAJCJwyDiobvSGsKPkoZLBTfC4sLXphgGb2WE26CJ9tdDPg89SFwelMH?=
 =?us-ascii?Q?cUFgwE1ZTTnfSFvpTAnADHJDGgslVboL39uJmVW4HWtnCtWgIEU/kCzNMP+M?=
 =?us-ascii?Q?TPDBpCLk3fBNrrOeImg1SRfCttMikhPZ+k2hr072mzxYQ5AHY4s6F2ON+zJk?=
 =?us-ascii?Q?P52i1isNadFXkzZTKUQRBwfNsKh92cAsmSB2gxLxfDHUpXzl9ccznrh3Jw0A?=
 =?us-ascii?Q?MaDMBTx5XHe2NYBEpSA/KC21/sR7f5NmrBaLuZA+JhTu6fc3C5hirTio2Zcs?=
 =?us-ascii?Q?bxo3jmMXaGLMoXxiYzDZ/4eHCC4B0PRffA5kSkf0eS3uYCDiO0+Vbw5NkYUw?=
 =?us-ascii?Q?al7cduggWdDOxSdLoy4aP3RWAIhFlbpM2VKiMoVbblgNJ3ySVlTRIXWCTTgg?=
 =?us-ascii?Q?P4Txv/SM6oH3eTSQDCLBYNjb0XwxTyHvZAfFYz8tdZOwez8NVK/LyPyeE8u4?=
 =?us-ascii?Q?NVXD9dAeKzO6s4ERQ2ePYqxRl/ZvVDweUO+yINkJomfMVSwazyVcHHq0MH9y?=
 =?us-ascii?Q?iaNqrRWYco/Pi7y0Y4EgjVOfD4lE8h6YS5bHCPHSmOpZsLM3OqY2o7p47ru/?=
 =?us-ascii?Q?/rwQVXhvmyY20tUFa3ZbGlwB3O+VyK9iTlrPelpHrBXINQqngNwvCzeod6oD?=
 =?us-ascii?Q?i4ybkd/CQfLL4A9sRw06FAaVLoi6Hmr3hTCNa2C4+kDiUgguLSQvz8e4RDFm?=
 =?us-ascii?Q?VQJvknBb++tWQc3kr/XoffW+O0HqaBY3uJInH03tBrv/iHkXefOvuxGfT+Y7?=
 =?us-ascii?Q?/i3ul+txbovtflD27udDH5P+8OAeb8nWCnE3Oocy7u7ypP1ymYc1ILZBplQA?=
 =?us-ascii?Q?SAAS6bvRvzu+CEuoxqw+ziVVy8IkI0BGluyzhotn6NlVgYpIll2vgRbqM9Lo?=
 =?us-ascii?Q?BsKlU+m8VqyM00BNKPPh9l+dPAgpodvKrxr+Mbka8vvKEQzkMMNkuGn+z0Ir?=
 =?us-ascii?Q?MthDIp/KJraNV2H1JywBzPPLKWglbdKTrr8Tm8ukUQwWDY6PH49v7JsK1tIh?=
 =?us-ascii?Q?PfD+13v2Y5n1oDVmJ+3H3Pq1K5GEl1ZEUdr4GNg5FZZ1rWfavClytQJT8/fx?=
 =?us-ascii?Q?ra9V8Lfc0Lxdy5zu3Se1VdxnFCeV4IYuTzGowpHNRclK8Lq1TabNQWYrMbSO?=
 =?us-ascii?Q?FqYCt610WdJ64vBB15RAv34mnELCSTETaySbVDFVJzAA28B2YM4YU1LD+eXG?=
 =?us-ascii?Q?aA=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 16445417-a316-4953-eac9-08dce245d726
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 18:21:17.1616 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cGhRNbuo9jRAgv04+7cCYH8m+1IN8l52hrpUyG70yOlUpJA+w8zuV6PW4NuHE03LbRgK0zRDkRtDS8aVvVhyb/nv6muoD7SBKHRFMMr/Zq4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9188
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

