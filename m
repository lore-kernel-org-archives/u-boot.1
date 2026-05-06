Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C28FBCD342C
	for <u-boot@archiver.kernel.org>; Wed,  6 May 2026 09:59:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0BAAF84897;
	Wed,  6 May 2026 11:59:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="QiBgWGCi";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="QiBgWGCi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 36748848AE; Wed,  6 May 2026 11:59:31 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 668948488B
 for <u-boot@lists.denx.de>; Wed,  6 May 2026 11:59:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Jerome.Forissier@arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=UDboV8BI6Whbv/mBFnxRiUqGCDWtVHjDgSdDckNCmfTRPY9uKvgTpnJ8mvqUulYH6xLgezGRNzx2V/8NTyU+bWxeGRxCH72Kk5i4wFZtQCGxTKx6saizURnFQd2ZKEQ+Le53rdmu7IervxOnuxSwcyokZPnnk1TaFU7Nr6dVTf9M8thbHIkn+349trQh/hOJta43tbSprDlPiZlAcd3TSF14V/2fzZbHKwFXhczTKKEiW8+M+K/+dNdBaFxJt80Chad427vHAZaj0mYOUD2vgTKcvqg/UY2KJi23t07Ve8lQKJ2Gks4/dtewNyliBPTE87aW4u+juuYUm6HRmavJHQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MrZFsAyXt/RSkEiO6s2M+lS6X1z8rpc7E7nHwfJD2L0=;
 b=LFOTmy6rfB9etUvDGYoYqFg3AydlOOncNCHGPwsWr6Grdju/gx4RbNeqbY2LSxqjJssNcNJE5sd5ZwYoR2UCSpnS2YcVSRMLExHPipW2tTchPA4UUQ1cVfHLRTilcVI1MZeKPXyOBTE1//VFnrsv0YzZnx5pRnu9sakmCt2TbGJMZJIfvvz38LDa2ufd7/qOiW4nC7qglACDqnLp5up//Vc7+Xsc81KZMItPrpg53Pes+L92RQTWvoHLs70szdsWVp44H3AMxci0Z3J1kLcutkYN/DezuVlnD/F58rbrzDILp0cJ7ah/HEIyuaC91t26wfRCGNdI0ijEvKlVvsiiUA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=konsulko.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MrZFsAyXt/RSkEiO6s2M+lS6X1z8rpc7E7nHwfJD2L0=;
 b=QiBgWGCiiAiGYchg4khJ7qoQT5uB6ItsBvOEGDQc15iCgI+sqMt0JUdaoej3E9RdGbCqXGLZML5btRI7M2qMC/AiTVlF5SSu5J6h8SqdzN4CETeb1d7Zl9pmi4hGHGEMD9qJHgJ4UaUr4/FQsRjkyG6RLkOQ7escsh7/I5guhms=
Received: from AS9PR06CA0132.eurprd06.prod.outlook.com (2603:10a6:20b:467::15)
 by AS8PR08MB8826.eurprd08.prod.outlook.com (2603:10a6:20b:5bb::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 09:59:22 +0000
Received: from AMS1EPF00000044.eurprd04.prod.outlook.com
 (2603:10a6:20b:467:cafe::dd) by AS9PR06CA0132.outlook.office365.com
 (2603:10a6:20b:467::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.15 via Frontend Transport; Wed,
 6 May 2026 09:59:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS1EPF00000044.mail.protection.outlook.com (10.167.16.41) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.9
 via Frontend Transport; Wed, 6 May 2026 09:59:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uJOYpijEyiB0J11wQrp2Kba5ICQEsFfKJCMnjlzlCjL+3ZRzfEm/K1oqkRlK9uar5YFfbdysdM/jbnLtYISDxasXoZc6HWr7F2q3EhHI8Cwnnxby2rmOx7iAgNKFViU6U1Pp3ZLwujJ8AhUnNytV1UKAsmQmt39jeQD2ebrsCtLOKTfkF2WLxvO1Zr6d9IXbGiyo1OUiK8bHa8dCj6NeELWJ400v1jW++QoTaCTSMvoc0LbpakwFczW7lZ0WPWRvw6na/9zjB+WCTejXosghtcKYtnncQKrg87nASzOD06uNWyj9ePcj1hls35STNkQ0Mh/1XELY2Kj88pNUdHA4Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MrZFsAyXt/RSkEiO6s2M+lS6X1z8rpc7E7nHwfJD2L0=;
 b=uBJ290dr0oOW+uEj+QC3a53EJ0kNJX7ia/w813YIeNoKJONYhSCBVjWvqsLnzxciVhmA3K9UwgL2mqMCB6oEVsHf2eLYbD/j5OL49T/M7rA2Bv4AHQMbzlMJdj79LoYtLz3+ml+gXfUQBd6Vo+Vyjd9m2LqoEkPreu+SgOdRzNGaTG+u4KxVmQazEaJJwj3q/NJMS457zI1rtuUMcn8/vNIWSEWFAllIvKCDOeBQBDEVzQumpC9S2bKMOyTWeNLH89C3NMTqLdKG6+p1kMfACRhp/a/v+sGA4Ewsv7/fVAgo4HOz5FfVoLM1udy3ACeZOE60xil57BK3MYZzGUCJtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MrZFsAyXt/RSkEiO6s2M+lS6X1z8rpc7E7nHwfJD2L0=;
 b=QiBgWGCiiAiGYchg4khJ7qoQT5uB6ItsBvOEGDQc15iCgI+sqMt0JUdaoej3E9RdGbCqXGLZML5btRI7M2qMC/AiTVlF5SSu5J6h8SqdzN4CETeb1d7Zl9pmi4hGHGEMD9qJHgJ4UaUr4/FQsRjkyG6RLkOQ7escsh7/I5guhms=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by PA6PR08MB10661.eurprd08.prod.outlook.com
 (2603:10a6:102:3ce::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Wed, 6 May
 2026 09:58:14 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%3]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 09:58:14 +0000
Message-ID: <bc4236ee-057c-4fd3-930e-3c613e55ef19@arm.com>
Date: Wed, 6 May 2026 11:58:13 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, nd@arm.com
From: Jerome Forissier <jerome.forissier@arm.com>
Subject: Please pull net-20260506
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0051.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:34a::18) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|PA6PR08MB10661:EE_|AMS1EPF00000044:EE_|AS8PR08MB8826:EE_
X-MS-Office365-Filtering-Correlation-Id: 379a4cc2-afb9-4d71-5c44-08deab56259e
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|376014|366016|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info-Original: 0YqNzRqTzpSdtFi0BO7xoV+CWDGX5eb2wYNgJ+xrUz0SMItazGVYyDY4ESVFYBhOGSMe3kGhAs4ZL/FKu9+agycrMnBuix1n9kEvIC2Y2mXF75zZ8XqGXKaWlRom6NNqck5g61bjoLUgKkARtrfqXqEKOOYm1VgG1yjGlfeTt5sSbZBmMyk1oE9kS6dpZacq1uvKMuOq14CevuHzd1eUWYwDnWc/WmYVtEclWszRknyVo+iKTxE3aHuNEkv5mNu1Dh8KQMA5EMtWENWHuzc7VoswN6Hcb2jj4n1NZzxN++IE4vAer5iQY/2ZydfBL5j8s0DVjBCXjTxlKtQvRQz6XBkeOc1QmHHEM3NQQtcIZn29ntvASliI2Z0joidEddVBLoJeq1PPS5k0q/vbqFz0IzJdYaAhm1N3otFcLodcFbzNIrOOGrmGQhhJVc/cEkGafQ8h9A9NxxrTxr24Z+tLvtEYc5PR5sAn6beW4/IJV/lRWlQniqkQ3DJGTszXBcZH+p7DMRmeZuKuY46bvtaKfVPZs16jhP7JtJT9PRpIDI8omBnrLadWA7A69bIF7ckt4XskKVyRTnQqnhs83Ym7JAISqDPpzSKYaOyzdqYG8zR4Nkw8pnoiKyXrQBjhtlDrutiTXFSlBcjupUh5nM+5GA==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(18002099003); DIR:OUT;
 SFP:1101; 
X-Exchange-RoutingPolicyChecked: eGWZ33MJm3cTcvK1mDXm6E4HmdstlEaFtcESCWDXtoWhhFj7D3s/H5eFNRREdc/EBiwxbumAk/17YrCAH9Py4N8MAQ41TOs3/QxyQjMR8ioVOnJjUr4BiVENX2UADbHTzBXcYQpYkPjYdMqIcCkHcHECXWGWJoQoBXhbD/xbk9Kg2Rf6cW5bpNB7QpXBtMC46yIsJSTO/2JPOG9MNPICrqa6yYrexLiVHvMXfadN546PaRjif0+KneoYlCio53tfLTrY3XEKFlfC8FOMrIyDqJT5eIaAe6nlRx36t1JzZKlycnRegnAXwKSMEoBI1+/yAUdKXvAf20xOhSkSqi5X8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR08MB10661
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AMS1EPF00000044.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 560850da-6f33-4779-999d-08deab55fd76
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|14060799003|35042699022|82310400026|376014|36860700016|13003099007|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: LPFiECW3HTzUerhFPKYUvvnHKmUGcIHen1F6GllPw0wq2b05ZWhfiH3LF0yvlXBKo8wjBou30v8XJZJnR9icSSfzgBqDs6gIRAPBqJfwc8EWlQEYTnPZMXal80u7kZFUOoHtPRvgE8tZX0rqtgATbAza2MSXZX0XEXORwWMHbciSQH1yhASCAgI4+VG96g+LtnV++oCt9uykU5ZSCyES4pxGQUvFArXpakzgVfJIdl83HqcwN0pQ8dTfAPFkAuH/pHx2CsHsk7Xsvu4oEFGT5zIa8AAVdK2SjvQix6/0UF4UubYSWbTyx/l48z/t+VIaOUCAnVJXo0pcxvA16okR5nMBZJtTmlAa3O4g/5cGlGlUuAJxwqfQA/SSVMy1L/FFQJ4fEubDWw5rYX5Namgi+KAsPBb9YrZLHLbak0MbqwOX6Gq1XuXKlbzMhx5pj6EVPkt+tESakNdbUeHnpH53pk+8GR90gvIec3/Ap5azwI97IS1/LU4RiG4pSdG21iWz7NuIn75b61lRcc6kpaoJX3H8KJzlpGd8A2qiKTLvt2ypTwUzIieAD/3jbo3+AdygDRpBCMdD5Rh7GlfqUGZXmFsPZVj8c3NL2dQx16GsuVcJQ96MM6mqsdXk8xtuXKX0a7ukkZ3vPoYEIlzB6upmtmrYZ1GgMxchMxZH8Yz5XP/f+QQ2wAwSkAD4XryjkWYQ
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(14060799003)(35042699022)(82310400026)(376014)(36860700016)(13003099007)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 1z6F+BW07NdA1EBA6NqQtUt0PYocYzSd/V9sMh9Q6HUTtsU7ffvWs68kBn3gloZ4GEL5phkcXBWkrWq5jjB4VXZP9UaavsxzCB+56cWyVgDi/eihmRZA6VaI+u12Z4vLy5h25V0XZGjVsu6tF8R1D7U6SaaaKxTA7bEAbiXKQ9duWwMYJ3pCZdNtvAFk93uIFrbkNI+wWj3ybRcXvoDIfSgkUogMydEw7WQim1vqbS0NuPJJ9i2WDNsPelxuBvTGGtrt0cFq7HWdSMOBciQxYGk++Cku2tT9QaJXiWxvsvYSgu6Sdu9b2HMSFXiNPOrtm/DTSgtIJd7HYRScDSjxZAFI0QO0sj/zVNwndU0cR+32LZ7Q3AynWol6+ucndIU87prbn4wwlpF3Tt2zRmOu8AAP7GZYCxr2h1r+7J1HmbPyU/d+KBumTX8IYWzaip7z
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 09:59:21.9238 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 379a4cc2-afb9-4d71-5c44-08deab56259e
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS1EPF00000044.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8826
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

Hi Tom,

The following changes since commit ae8987f4e690f397f507c4b1efabd68b3ed08db6:

  Merge patch series "binman: Fix preload signing with encrypted FIT" (2026-05-05 10:37:16 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-net.git/ tags/net-20260506

for you to fetch changes up to 5245bdc98b9fff46e4bcec2e44e915be44824537:

  net: phy: mscc: add support for the VSC8572 (2026-05-06 11:07:22 +0200)

----------------------------------------------------------------
Pull request net-20260506.

net:
- phy: dp83867: default to 2ns delay if unspecified in device-tree
- nfs: fix buffer overflow in nfs_readlink_reply()
- cpsw: Add cpsw-switch DT binding support
- phy: add common PHY polarity properties support
- phy: adin: add support for the ADIN1200 phy
- macb: support for instances with less features
- phy: mscc: add support for the VSC8572

net-lwip:
- wget: correct diagnostic output

----------------------------------------------------------------
Charles Perry (1):
      net: phy: mscc: add support for the VSC8572

Christian DREHER (4):
      net: macb: include arch/clk.h only when necessary
      net: macb: use SA1 for MAC filtering on GEM
      net: macb: do not set user_io when it does not exist
      net: macb: add gigabit implementation for fixed-link

Heinrich Schuchardt (3):
      net: lwip/wget: missing linefeed in diagnostic output
      net: lwip/wget: don't print content size twice
      net: lwip/wget: don't print progress bar when silent

Lucien.Jheng (3):
      phy: add common PHY properties support
      net: phy: airoha: air_en8811: use standard rx-polarity/tx-polarity properties
      test: dm: add PHY common props unit tests and sandbox DT nodes

Markus Schneider-Pargmann (TI) (4):
      net: cpsw: Fix error message
      net: cpsw: Remove compat string argument
      net: cpsw: Use driver data for phy_sel
      net: cpsw: Support new cpsw-switch DT bindings

Rasmus Villemoes (1):
      net: phy: adin: add support for the ADIN1200 phy

Sebastian Josue Alba Vives (1):
      net: nfs: fix buffer overflow in nfs_readlink_reply()

Siddharth Vadapalli (1):
      net: phy: dp83867: default to 2ns delay if unspecified in device-tree

 arch/sandbox/dts/test.dts            |  60 +++++++++++++++++++++++++++++++++++++++++++++
 configs/sandbox_defconfig            |   1 +
 drivers/net/macb.c                   |  94 ++++++++++++++++++++++++++++++++++++++++++++++++++++------------------
 drivers/net/macb.h                   |   2 ++
 drivers/net/phy/adin.c               |  13 ++++++++++
 drivers/net/phy/airoha/Kconfig       |   1 +
 drivers/net/phy/airoha/air_en8811.c  |  60 +++++++++++++++++++++++++++++++++------------
 drivers/net/phy/dp83867.c            |  16 +++---------
 drivers/net/phy/mscc.c               |  11 +++++++++
 drivers/net/ti/cpsw.c                | 188 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------------------------------
 drivers/phy/Kconfig                  |   8 ++++++
 drivers/phy/Makefile                 |   1 +
 drivers/phy/phy-common-props.c       | 286 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/phy/phy-common-props.h |  69 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 net/lwip/wget.c                      |  18 +++++++-------
 net/nfs-common.c                     |   4 +++
 test/dm/Makefile                     |   1 +
 test/dm/phy_common_props.c           | 319 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 18 files changed, 1045 insertions(+), 107 deletions(-)
 create mode 100644 drivers/phy/phy-common-props.c
 create mode 100644 include/linux/phy/phy-common-props.h
 create mode 100644 test/dm/phy_common_props.c

CI link: https://source.denx.de/u-boot/custodians/u-boot-net/-/pipelines/30007

Thanks,
-- 
Jerome
