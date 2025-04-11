Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA937C36010
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 08:10:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45D7D83F3D;
	Fri, 11 Apr 2025 10:10:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="HeWRf/wy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23D9083F3F; Fri, 11 Apr 2025 10:10:04 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20607.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::607])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29ECD83EDC
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 10:10:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VxZzfBQB5klXYWxUcpsjXiqyK4r6Um+YWKmcG/eTACYXtJibDo/7MTr4UpLt4FWR4x0g1pJR7rfNJMEr2GitfbhKp7ZyfqkbUaFeCU5zNoqL0SrGiqBrYaldtsBwMDqR09qqTzO2rWZT0xg2Baie7Qky/YowwsyTIStBsF5LTJFaY63E4tgGFISQumz/Rren4b4UqmJcNf5gN8WQkBbMwrJXcQsRvJ8cJPgQxzRtM75UIkMDVoF5443lxjEluLmXtnUGKDE1ES0i9PYgQLKJ/jBySpvkxvp8YXduMgmvezo6RkJDdoLBSaz6D9fkr39sy8eIIEJZIGDr9kkBUR2iag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9S4eiGDAPHPPb6K68CL2IzMs8hzHNDOBfE846iDVovc=;
 b=ARvA0NapWyoQcDKkl6Kg38w0PqjCd6Y38IukkKAQEQv1Rygxt1cUh/ywjYnlFAwxhq3N0sINO7lg3b+91IDsZkBpNUMbzr1MO6SBJ3MGQ7FsoJnfGpArFpGvN8MYNTWnQFT3GD9zEnDVjYzrWhggpGCCVG2QeALVeTzP0y2rJrS8WhZYA4lE4ZHx6M7FvUqNitezI0rGi8ouuGP2QvGLliKDlETsPzjlDnblh53bxBbyk589vQ+OnM4iR7Vrgm8+r7TCi5RQBw3Aj+2FUi4mLfL+b2/kO72IkFuIzi30sj90nBqXXR4fLRuOqnH+Ghq285Q7W4yPao98JQjmFQ6cqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9S4eiGDAPHPPb6K68CL2IzMs8hzHNDOBfE846iDVovc=;
 b=HeWRf/wyywrEaHsuSMFSZs+YrkbwE0BFDhcCdAf43/RoqHNKH0/xmjEZa/9u1T/kBu104TwGuXhvW38QJ49YsyPXgAwz7CoqfIFHiNIpJ5qlWWpvWD171DwrVPpJi5seZcJ83d8OYiIfacny4F6NXuFXZwGI5bsnoFEQiif9Rq7AQ9YGde3ZOIegzrFynnpQ4O0dtR/92MKA3BfFEkxIIVsQ2RfdQjhC4JLWsJP0VUQ3sG3R0hhLBC+AhOacRvZ/po/srShZsRDpISUKDvA7m1a6Cqg/LSkhVyEMAQAOtGvruzbO0LbdUolSoKiNhl15dXXO4ZWxjSUh/HfmUzeyHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AS8PR04MB7606.eurprd04.prod.outlook.com (2603:10a6:20b:23e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Fri, 11 Apr
 2025 08:10:00 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8632.024; Fri, 11 Apr 2025
 08:10:00 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: marex@denx.de, trini@konsulko.com, festevam@gmail.com, lukma@denx.de,
 seanga2@gmail.com, sjg@chromium.org, sbabic@denx.de,
 alpernebiyasak@gmail.com, alice.guo@nxp.com
Cc: u-boot@lists.denx.de, viorel.suman@nxp.com, ye.li@nxp.com,
 ranjani.vaidyanathan@nxp.com, peng.fan@nxp.com, frank.li@nxp.com,
 ji.luo@nxp.com, jindong.yue@nxp.com, Anton.Gres@ifm.com
Subject: [PATCH v9 04/20] scmi_protocols: add SCMI misc protocol protocol_id
 and message_id for getting the ROM passover data
Date: Fri, 11 Apr 2025 16:06:47 +0800
Message-ID: <20250411080707.602371-5-alice.guo@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250411080707.602371-1-alice.guo@oss.nxp.com>
References: <20250411080707.602371-1-alice.guo@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0009.apcprd06.prod.outlook.com
 (2603:1096:4:186::17) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AS8PR04MB7606:EE_
X-MS-Office365-Filtering-Correlation-Id: ca10bd58-386d-4ebc-05df-08dd78d0414d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|7416014|376014|366016|1800799024|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?olCOPlbFr1jsy4kesYzbVeqDSkXeOeic5v5KgsqTVJakzYfq6yfozf+SRoQM?=
 =?us-ascii?Q?c2QWvBICvuVxkFwEGYm551aj1iB3pftEn8dY9Jd/KHIRkw1AiI7PeBvFVG29?=
 =?us-ascii?Q?iZuT4UCps8OD5HeZTA1sulDIht8X+Lnuyx2N1G3bP+hHk7zMryor8nouwaJm?=
 =?us-ascii?Q?d1QKrBS2pm3HWYdCOUnQhDtGvvHSKkqGYFoR2INumgFhwB+iIqCnbUWu5TEA?=
 =?us-ascii?Q?DqtoOGmhxn9hWpoPZYfqrIphkIE6s/6tqjNXWExfi0Zkou7MoXyXI+yMORRP?=
 =?us-ascii?Q?dt5f5MAahokFbJgKsJjF5CTR5m9wrqtstN8nCZNcgOmJvU5FWF+qrkGG+ouw?=
 =?us-ascii?Q?rRG0TBh41w2N1u2UZhnYmZLMX7bdJHE+8Zkr1wTfQATZFqhMUpsI3rXrANpd?=
 =?us-ascii?Q?niqwyFSRgxhK6oRYOUlmlBIhdDRLP3c3iE5MLOuTRN8wqswm0Qm1yNzCnPJW?=
 =?us-ascii?Q?S/7GvD1mO/OSpe0OaJ875YIwfVaaZC6llLzhX/izM/rpNGYDYej/B74c2q6P?=
 =?us-ascii?Q?sWuiqQx6VuikTcj3nj5cQP5PJv31BER9yZtjn1B/mm/0BeAWrY3JqJtJryHx?=
 =?us-ascii?Q?gjH39PO/ffx4RXfI/5Aqg4V5Pvz2iMt9lxRk17vgcVPXmq/vP06qrFZkwWdj?=
 =?us-ascii?Q?Crak7EBsYLtbi9/ynHB74h/bdShGx+ptDf/tWIehRMyWK0s37oGXvCj92N5M?=
 =?us-ascii?Q?MzJFgXOdL5YwsvgxiFb3lq0wxAZ9oG9IMqAAn4ad3h1seQeGSiXcAuccW5vO?=
 =?us-ascii?Q?pZVwKJJSQaWCidYFYm7D4vdxSNLI+4DLsVYrBpnPULZh3O6I3KjY5vU4lLL+?=
 =?us-ascii?Q?j6foyONvSUwVoo98BFSiL61HTWnTgCQfXozjmA4odw1gdCSwFc//89uFpAo2?=
 =?us-ascii?Q?37dmjnfdOHy5qzbSnRYcUxfo7GhBE2MDAeGwnIZ/v4rGs6BqOHC7KaS+fCNE?=
 =?us-ascii?Q?P3Vn7V2/QfXp7fjRIr0WlT+yov4p5HXkp0WlMhrgf0XqGR1RDStgVH2royzz?=
 =?us-ascii?Q?Pj0e45Ky6wyAAvciJBzQtxcxGqHEdOD2qdDJe8z4X4iP33bO7o4skq0njh3T?=
 =?us-ascii?Q?uiASW6rgAK+MoKJ7ZwY3YwWX5QXoDyMyKTN8B6u8wFMimgmtq77M6KcdZeUv?=
 =?us-ascii?Q?A834bb8Te/LkAar7K1afq+A5IdpwJVzJdz+ni59wvFgQ6I+/SOD+uAU5WeVc?=
 =?us-ascii?Q?/Q05weYQJNeAL1JCL9FBt61wMmnl/jOJ87sZywea7OC5PEfiU0uEV8tTWEBq?=
 =?us-ascii?Q?1ruCyWyIwIMQjdUQvLNQQLuo4LAy+tWIUCeikUuFH1jgmdaY0eNKxoTqGQgH?=
 =?us-ascii?Q?nTHdlBO05mLqkTbANCp+44QdZohn9tvhEJq4y+m3KSMnbZwGh44C0NJ3EzMY?=
 =?us-ascii?Q?4Xnpid5n3z5aD33jy1s2jblXUNfS/dXAaHdN/8Rdye+8xOdvHTqPanJZXBRK?=
 =?us-ascii?Q?DsHIewA6k9RT+oxg3jHKP8A6tBHNJ+7/RRPJ64s8sW0DUxecfASoig=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(38350700014)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rAiPKCMiEY76gMrlm9DQOcZHeXuqO2QLTGdEIXtcN43E0Is6CHTjmYj9oAbu?=
 =?us-ascii?Q?uap8zwSvOi8ETT5u//sb76z9Dk9Ah2+d+ubL9IOlcj2BUT8grGVpKvRBPLyS?=
 =?us-ascii?Q?43o4b0idNN3IVvpxqwUbS0SMOO7owZ280jTfExZs+SzIeXOKM2LbxW0csiRG?=
 =?us-ascii?Q?HBO4StNnkD0FyapGWX/rUnetRXVca4IvWxPnzzBDUoWRkUKp0hEF47Kn8oBa?=
 =?us-ascii?Q?+EBufjH4MpgXolghigFCgjMW8oAfSNzL4+2fGI7lfwU0IZeL1kqJ5rL4gCQQ?=
 =?us-ascii?Q?MWAxxX1gJwXmuOftbOgT5Of+0FSWaIG+QbhNFw4RRJBNe2H+uAiqwJKFeKGN?=
 =?us-ascii?Q?9Vq/VLUfd/f0qGVHrkyYkq5ceREgc9Y+6Hjb2U/TXM5IOa8MFF3LoSALCs5u?=
 =?us-ascii?Q?b5QQ0LFszao5Kx5LLccTxG9kQtFhiR/9t8gBHQ+g1bRUp6JTn1mxe6oDvK4z?=
 =?us-ascii?Q?+u0Bt8xWfxQtGOlf0ezK31gteNT4KUN05sij9Ne0zlinRZ+7KH1fpzbCgQDd?=
 =?us-ascii?Q?EnTNM38kD12vjZlEPplt6WwZBoiGww5nSUOe8m9O3szMcPMi4j9MjMljtquw?=
 =?us-ascii?Q?36CfZs01UOVIjmFDdzTvtpx1KnUAE4Jq+zTx/4HmEcFSgO1Ki98pP7xMu4Le?=
 =?us-ascii?Q?D0WTiJ8N23RY3NixIK5Iwpl0ERJi0m1aeqfNRLus6SXz1zd9NOYpBGsEblcP?=
 =?us-ascii?Q?I1NqPxsKqxA3SnLlrY1cgwH8uoe0Qdr7HbZBnWyvoR5CepvlduUQoqJP4cPa?=
 =?us-ascii?Q?z6c4EtBRHp/MDEIiMBKMn/xjcOQfUkK7ut8C03h3Rcc5Oii8er6xm5ZpStza?=
 =?us-ascii?Q?1IZ3p582RwWlZhT4XEUHmE4uGYyESpdoXrh30LdGHXU2BHlFKA+o66xconI7?=
 =?us-ascii?Q?/T/AnDDACesTG4pX2p7lI0c/D4Uc6+6ZyFC5IrlmNWjipHLe/HqUa/rG/oFu?=
 =?us-ascii?Q?7hLq+m1iXM48jJaTNOtXqpybPJROXzSEyVnsnSOKnjv81zz8sA1JVrsRdVKL?=
 =?us-ascii?Q?Kt2Joak3iwBjBCewlySXyCsGWZMhjSVRiGhfyOQjSg/uwCJ5E2O7NdpQ2lZ8?=
 =?us-ascii?Q?z6tK3p7YPH/vwCeZCgbZKa2CMCIXQsIotmf5O1TSKL18VA2EwMt7WJomQT/g?=
 =?us-ascii?Q?ZJ6Y6kRn6C4wpErZVkrLBrabliKO45UNQrzsIz9xvF6dNA+gPkOpBXOW2+ec?=
 =?us-ascii?Q?sgeXfCLSO89mt4dmqjxl962lPek2HR9I8jIG2xRKOBkEzKbHmRQ2EHQX7OD3?=
 =?us-ascii?Q?yun4Ko4ul/UuomfoB6pW+mXZhj5JYg3AXLp32waI4A0KbdN4NWjTsgrjg9Uw?=
 =?us-ascii?Q?jXU+QrvPb+hMS+x0ZgJiQR9QO2PwL62sMu0CMZwMie5kbvOnEnwBacPgOn55?=
 =?us-ascii?Q?qH7yCGDV73RWL9ucxe7HrpQR9zWLgP2gOoWvQUd/Hxzj9z0I1Lt1ifhr24/H?=
 =?us-ascii?Q?Rj7O5EWW2SejB2LnN+zb3UizjWwjQMf2dKKeczO4MgyXW6a0a451XLVvw2iu?=
 =?us-ascii?Q?jxnW0GptoJo51qlvI89/iHJ3kQ11VONy/2nOfKDbrj1XTBB6JSxoWtD0DThW?=
 =?us-ascii?Q?IqJx+fU1Qr0u3r5zPPihX3E6KXQmzvesHYVg5hTK?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca10bd58-386d-4ebc-05df-08dd78d0414d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 08:10:00.4805 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jndo8Mh9L1vliKxXs8gmaHxxQKN2iGCoxFe8lz+xVeBjzgi+imkCsGCOrklIprXrjhloHUdM6wzBelxVtvmhpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7606
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

From: Peng Fan <peng.fan@nxp.com>

SCMI misc protocol is intended for miscellaneous functions which are
device specific and are usually defined to access bit fields. It is i.MX
specific. This patch adds SCMI misc protocol protocol_id and message_id
for getting the ROM passover data.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Ye Li <ye.li@nxp.com>
Reviewed-by: Marek Vasut <marex@denx.de>
---
 include/scmi_protocols.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/scmi_protocols.h b/include/scmi_protocols.h
index 279ebbad440..06de4a601f8 100644
--- a/include/scmi_protocols.h
+++ b/include/scmi_protocols.h
@@ -25,6 +25,7 @@ enum scmi_std_protocol {
 	SCMI_PROTOCOL_ID_RESET_DOMAIN = 0x16,
 	SCMI_PROTOCOL_ID_VOLTAGE_DOMAIN = 0x17,
 	SCMI_PROTOCOL_ID_PINCTRL = 0x19,
+	SCMI_PROTOCOL_ID_IMX_MISC = 0x84,
 };
 
 enum scmi_status_code {
@@ -50,6 +51,10 @@ enum scmi_discovery_id {
 	SCMI_PROTOCOL_MESSAGE_ATTRIBUTES = 0x2,
 };
 
+enum scmi_imx_misc_message_id {
+	SCMI_MISC_ROM_PASSOVER_GET = 0x7
+};
+
 /*
  * SCMI Base Protocol
  */
-- 
2.43.0

