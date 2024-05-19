Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87A57C25B75
	for <u-boot@archiver.kernel.org>; Sun, 19 May 2024 19:56:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6CE788193;
	Sun, 19 May 2024 21:55:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="KcPqDOFU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2CF4088140; Sun, 19 May 2024 21:55:47 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 494C88817C
 for <u-boot@lists.denx.de>; Sun, 19 May 2024 21:55:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HI4CRH1JUFkVFAFtvsdC0o1IQq8wH8gsWzVdIyZ51NkPkMQ4H9oRUCimm0Q81yNtPBLbb9p10pv0xyV48bSpV1wUhLnvVo9jew1WP/Oqgrpph61dtIKw6gcMW2Z2RWcujgi7FlAUiho5fouQjowaaBb/5sgkNG1FwYgYdl9HDlRH8NM5sx/pOWA4rHQLVL5APiwT22gR6S5vB0zFAAucoipxARaiA2lm/okYA7qh/3fCF+K6w6n2x0gCB9s7SyhPHxRjpCZzdgVlP+lyzIJ9DnEPcXifjcfH7F/BHAckL406kGJZ5QEQWKp9kOwjWzJK5tJ6DRiYcWro6oEDzjYNCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=++IBGcmEXrY4oOAzH+rGJehNxoYwzxxX69ISpYNAY6E=;
 b=PCakpbrWp8aHb5s44awZE3h1qqCXuEZIyqF9+D3/iQiEL9jk1ATgsglWgX/mQq9VtoGoLNhj64jCZaZj/PDmQurn3ru3ck/qbav9bL7rjCZSZvzp/DAtVyKHNbRqhTqeND1Aj29ojjhf/x77Q6IHtCDL8iN/5yba/5XgUrsv11EkT/vNDQ8ObdqbIiwpTphypCVkmJ1mugxlnXV6aRMhDUycyivZpsRV7rvhp46E1TeLRYQlpJIknl2Sknjmuus5lYiCP+tlj0BX5YL70SydoEs5dLRxDW3sk1Yeo6CSoLzYYV96eBuryc8+RoLaTFtWCRtWPNp+ekCz7nRJ2MPanA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=++IBGcmEXrY4oOAzH+rGJehNxoYwzxxX69ISpYNAY6E=;
 b=KcPqDOFUCprGnRjgzckIyJgCP7Fvk6W64lXCLFqw9VIF0/NOzODit+E0tzdHoe72JJsRBkMG3BKtiffDtcHjN+I+hA4ziCkeTV0uTJTp3UbNzE8X5u1uGMF4e3Fj9zeWKVcfvcxWrmRq4KW5KmSfwmoglMIxog9CB2TxTk6ysL0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by AM0PR10MB3716.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:156::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Sun, 19 May
 2024 19:55:41 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691%3]) with mapi id 15.20.7587.030; Sun, 19 May 2024
 19:55:41 +0000
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: u-boot@lists.denx.de
Cc: Stefan Roese <sr@denx.de>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH v3 0/3] cyclic/watchdog patches
Date: Sun, 19 May 2024 21:55:29 +0200
Message-Id: <20240519195532.1648830-1-rasmus.villemoes@prevas.dk>
X-Mailer: git-send-email 2.40.1.1.g1c60b9335d
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0105.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::14) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|AM0PR10MB3716:EE_
X-MS-Office365-Filtering-Correlation-Id: 86cca745-b4dd-4955-36e1-08dc783da954
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|366007|376005|52116005|1800799015|38350700005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?I+eRGaz0+xJ7gqriNIso8nm0YAsEFnv7rt+fZe2v1l4EJn4/btAf84xqVjCA?=
 =?us-ascii?Q?1BygeCwBjMOXn6k7W8rOaMyf8TPbfanCPpDuxlL48GRF6Lp92+6QoBWtu/PC?=
 =?us-ascii?Q?jLUkRE7TOw5V4djJfCC2ZQdxab4Cpjp3HGicEXHvfM11IKuHtOocrXmiWq6i?=
 =?us-ascii?Q?iVF1FwsgfZPewRymtl1oJtHeJRaBszbA6137EbatlradWj4vxqLUvQhupQo1?=
 =?us-ascii?Q?d2zAZgawW5OOv1Hfc33eY6f+MpEBB+XUf8uxrhoDAFYcTN8chzXq/tfP5iXI?=
 =?us-ascii?Q?u3NcbxdSpDzT5/SXFRrE11a6tqIrJf32MIiXCGZX7gVFY8CeTInonBahWuqa?=
 =?us-ascii?Q?YBhET4wo2LyyhTaZwH9Mt0lA/zfE/W7gVPALh8TAzPRaZN/w5SfxdCC50OaP?=
 =?us-ascii?Q?RgIESKdowGZPoi/qwIpBkqK8wTbRggafD5aqEe0gZOqVu4H/Ef52/vnvj4r4?=
 =?us-ascii?Q?FhZo69pumMOGfryTVEJYSq9c9kqbBFvXNVgn1lbx35eorjYf4mOAZFi3DObg?=
 =?us-ascii?Q?1vj1GLf3kymGoG9/n3tAN336yIDts6VMGDPBU99TMiA5rKCLlnZYh/0/DxxY?=
 =?us-ascii?Q?DxsDQ3EFonUazjCK8oZpwHF0JDsm7RoxMhHHXRczLknOCdXqI5Z88IpuuAf+?=
 =?us-ascii?Q?5Eltk/c5YfcdrUWKMjUH7zAGaaf+PShA/QeAiH460asGT/y5XMKeuteoFiEx?=
 =?us-ascii?Q?E2HdXxwKavszxYfsdX4jqHY3Ko59i8B6+iMRIBOJdcjVTT46U563PsGEDTSa?=
 =?us-ascii?Q?4KU7+Zxp7QXT7/a0ftcRnd01B/JMfX35Y2Gmudg3SE2suJiYtz9tQKcRJH6L?=
 =?us-ascii?Q?mC0IHq/z5C8Agl7axAJ1C2yRtvAUd7javin/LC4tVboD6qWg/fDli7uLacYm?=
 =?us-ascii?Q?H8hy7TCJQydi7E/rsa49ILbG21Svvj+PFkNnuIvuZlfjw7TDYQOlvucDUHB+?=
 =?us-ascii?Q?N+Jmv1BQhrLVtKhyxTXXs6Q6JFslHgoWWPCqMGph0u5n+M3xGFqiiTLKzUGk?=
 =?us-ascii?Q?6hWeyMaBaL9w3nTay6CywCs+5HKMT7PVeUKgbddK/tpxIV4GDZstK9YSqHfR?=
 =?us-ascii?Q?uW/dgktwMek82SPADCnjOHc+u+YYPJ+0w2E5cvkl+tPP0k9zmZOENOhduFjb?=
 =?us-ascii?Q?clA9pCfGk2DN6SQNIOGka3xQli6UMOcbv8gZ8WlglF1z3aofb4A9QhlZ07T6?=
 =?us-ascii?Q?38XoK0q7d1kpAAhJa9tXhdIwLQIO+XNbuheoU+f/G8cJnE4gAdlx0WLF1Za+?=
 =?us-ascii?Q?hxNm2WPd87xqt6I7RVx0rcw/YEAdyNBiDP8hVjrEAw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(52116005)(1800799015)(38350700005); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0m5cGuPx08H4PXdeuN0/XdW9BGPYXsS5bbmCjPLoaxlk2lfdHoBz47r73hgQ?=
 =?us-ascii?Q?ztXh51L/zYFLQ/MPw3B706gXeprcQbolhgiOfxuSHKMRaVFYtVt61wihy0Z9?=
 =?us-ascii?Q?EDDv3uflk0MqvTBAbwR8DeP//aW7qoLu8vfKR6PSVelkbw2ZFzlD2OFsSpPC?=
 =?us-ascii?Q?efrnJGfsRlDzqnmsZ2Z9HuYbtgxxhjW/NJQMgNQBHo2cxfhcqaeYU05ZhReO?=
 =?us-ascii?Q?9MNvEbr3gSNBCe3E249VzIMdItFM6H92XH2Qv4/BPOc0ltcuku961tJTF6x0?=
 =?us-ascii?Q?AJS4NSviCh2PcdtDI7ap01rO1+sd9QRzNonNMZ1bzh6IvGHWAk57kWYwHz9F?=
 =?us-ascii?Q?zeUj/pVMfNaH4GBpQrsP0p6Jdmabwhm3H4atW3Cgkl6M5odoR+kwb360nmqv?=
 =?us-ascii?Q?fisUXgkr+2oGXdunFqbpDQvHWFlYuq9bRYVMaC9viWqguWa/PjZINZ3yURqN?=
 =?us-ascii?Q?9J6fQjyfGyESNwNA3xB3voOD93PAzvbeOo7dSPWKugE20X83FUbo+pqXYw2V?=
 =?us-ascii?Q?YG8LcXoFSY66f9nAbNlYJSHR4fHiyiX0m6OwDaaM0zckfR3zide/30WCmQ71?=
 =?us-ascii?Q?p5hJj3iRiJoeLD5QGezhtT5iD+FbIH1wAIflB8QjQ+wk7665pOdD0o2oDOb6?=
 =?us-ascii?Q?LykzbWWYsm3N7n7pDhsEOQLDLXUnmqAp3kfnXxifMfTo5fnJvi65FQQq33jy?=
 =?us-ascii?Q?KdMPBdEve0pVHTBdCFxuYXDTjoW6k7GjqS8mzTVgIs1Ka5eWjsvDR5DvZneb?=
 =?us-ascii?Q?DFj25Xk8lOn/+ToWM67HlsgX+iNZGrYYaHqaR6IMHWM0CXDVagFlH3ZjGitt?=
 =?us-ascii?Q?wQmX5PWR9O1s+zbdk7Eg3UQVuFao+DQZzoXItM9QD7qB2tIZormC8NaXV3QD?=
 =?us-ascii?Q?BtgLjOUjEOMAkRRBRfpdI/amwHFIwYoNuk//KvIx8DH/VYUgGvrXHM2q1un8?=
 =?us-ascii?Q?VJg7wCiFJsYDehwxunTfxOkcLrCrr9JMhDlhLCJ8yWhmh172YUY081aIAvwE?=
 =?us-ascii?Q?P6xTxzID1fJQqYxtxC/YvnBFvMTeg+MBPQqna6vo0bDs53zac28esCfX7wI/?=
 =?us-ascii?Q?ArU0zSPpRm+KIgMShyhVrLxGHCqq3566LaipVWmDIvKJ7IQ6ck/AfTuOvcuC?=
 =?us-ascii?Q?m53/6NDRthU+mX8gmD7m466H6z0+Qd11YE+kDauNCQjMpBexOGqXdtTKD4s9?=
 =?us-ascii?Q?KjXYI3SZWtlVzpJebAX0PBBb2SB3V5+C2jUPTGr67kPiQLuE6Ge37Bny4GTq?=
 =?us-ascii?Q?R/UKPjkmKOg02CeNaj0+geyG3FdFhJ7nWbX+bbjYTWXXwkqej3rkmyrA2ZQ0?=
 =?us-ascii?Q?9MqPO/4sdp1n2UpiTsocFubGEifbPOEzDoW2T91Dt464Su/wYBmtZk64GNGU?=
 =?us-ascii?Q?gws8aEi1iitq+K+ZqZ6MX9gDHc9+3jXSRHxqX7l7OQndCwdi/FW1DV4fmtsX?=
 =?us-ascii?Q?oKDLKAqKTuv23epatT6wsKnOXKHuyDlc+e8DA6nPWCFRMetfSVTBiibhEiB3?=
 =?us-ascii?Q?rpGj9JxWP+SFZA0xlF2CHK31P8WODvU1np797ijNT2HlbqwoZdpcAnsNTF/K?=
 =?us-ascii?Q?FqbFp23j7xhQGRttN8KKKKKbw7PjWFlpppVFOBU+Zx2w1AsCiav+ht+2y8ZD?=
 =?us-ascii?Q?cw=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 86cca745-b4dd-4955-36e1-08dc783da954
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2024 19:55:40.9925 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iWLq/VaGCJ0fkl+UV5IHBS5VE1wmiDUGNp2Luvn8H1qSRyl1WCLZqQI0zSg8+894WegYyor3JbjET338ej72zQIvrcrq/277r7K6FGGnGVY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3716
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

A bit of a mixed bag. I've been wanting to submit something like 3/3
for a while. So when I stumbled on Marek's patch
https://lore.kernel.org/u-boot/20240316201416.211480-1-marek.vasut+renesas@mailbox.org/
, I got reminded of that plan, and I think that patch could be more
readable if we adopt this model.

While actually doing those mostly mechanical changes, I stumbled on
two separate issues that probably want fixing regardless of the fate
of 3/3.

Mostly just compile-tested, and now also checked that at least the
sandbox test runs succesfully.

v3: Also update the unit test according to the new API.

v2: Add R-bs from Stefan. Fixup whitespace in the doc/ part. Rebase
to current master (676903c1b97), fixing trivial conflict with
301bac6047c8.

Rasmus Villemoes (3):
  cyclic: stop strdup'ing name in cyclic_register()
  wdt-uclass: prevent multiple cyclic_register calls
  cyclic: make clients embed a struct cyclic_info in their own data
    structure

 board/Marvell/octeon_nic23/board.c |  9 ++++---
 cmd/cyclic.c                       | 12 ++++------
 common/cyclic.c                    | 24 +++++--------------
 doc/develop/cyclic.rst             | 26 ++++++++++++--------
 drivers/watchdog/wdt-uclass.c      | 38 ++++++++++++++++--------------
 include/cyclic.h                   | 36 ++++++++++++++--------------
 test/common/cyclic.c               | 19 +++++++++------
 7 files changed, 83 insertions(+), 81 deletions(-)

-- 
2.40.1.1.g1c60b9335d

