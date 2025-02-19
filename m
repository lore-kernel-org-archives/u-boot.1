Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECA44C021AA
	for <u-boot@archiver.kernel.org>; Wed, 19 Feb 2025 13:04:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BA9580F5F;
	Wed, 19 Feb 2025 14:04:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="TobS8aW9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7FF880C98; Wed, 19 Feb 2025 08:18:28 +0100 (CET)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c000::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9EFE0801DE
 for <u-boot@lists.denx.de>; Wed, 19 Feb 2025 08:18:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lYnV5CWztb167yI5JLHbpIC1aaDSY8k3xtcJbA8XEMWnKUJtEH2i2XP8KMURgshwSLBcKPi838dhg4jxIBGwhwgsi+97Lpguzm0yruP0ZV08DiiYDha1XBhsaADkXx87Va5+HozUKOzKc8n48LfEdYjpdbgpTAgM4yHPC0DtHg9JdzufDomM9JuRw60R1vPMcTNEVax3IYYh945Geo5S+7EZVe/srDfUUZd15tME6mwOMb6itW8oVhKmvtgMQ+O3wdsX4hAcXzbsVq0xlO5Rl6vpySZvR8K42t9bP/rRcMLsNpmdpQEAj56ZtT0YsFuoTLsaUnk/vkG3YQxYz1fjhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=loByOUHcjeIPZtjqwApKfgveMG526H4GTm3Stsot1YY=;
 b=ab6PJJcCuAGVJduO9qBZsqErcfBweuKVUFUz1B5RwqrLgQL9Hc81C5UnXagh2hreasWALhIxX5SDidK7DCy5X44wQ+dAZaglVLfs40z9kCuLzEyjnfo4V29qNsUA8iYi6WoWIkReJqpiqStM5N2Yw5Qw7z7Ga8G6tPjfQHIN9NxYkP+faMQqbm5erXPPB3/eMIDVOL8jG4fpLnroZtERPE2E624o+4S/LDU3e5vCziolmcvHEruKpidqucv6zcx5SQ/hLJq8MUhsqYPH2Q7/uhOpju8yHwiy3H7V5uZalQnU2bcjUHHKSUeAXSvqtSkNHUu/ST9/Q17Xv5dPZ7NtpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=loByOUHcjeIPZtjqwApKfgveMG526H4GTm3Stsot1YY=;
 b=TobS8aW9gkVHOtIcHuThniYk7U6kJ8dla8gRHQbwGIW221XhKvWx7aOlLiB7wWCNbMSL3JrUHJIBdEb6bsIgvsXoL2lM4b4/6YS637n4T/vp3A2QDsOvQxDpA252mTqQ26CEba5mCYsgx/rPgHnmG2WWifN+v/cCxL0vm9gbrScN5UMPyLGhlMJkvYGCzoDditsVqq7stng5omZK8dFmQRKd7yntuNxkDDfYxbBAPqj6dD8r/2aMg6/3+Z1QGXLtPEX/eAYCgtiQXk1SB7P8PGjx5ry2qb9HpMzZzdQc37qMC/2ER/wALUb4PUBa0vXgy6ueIIXQpZTgiPokOpixGA==
Received: from SN6PR03MB3583.namprd03.prod.outlook.com (2603:10b6:805:47::26)
 by PH0PR03MB6679.namprd03.prod.outlook.com (2603:10b6:510:be::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Wed, 19 Feb
 2025 07:18:23 +0000
Received: from SN6PR03MB3583.namprd03.prod.outlook.com
 ([fe80::263a:babf:7ed2:3fad]) by SN6PR03MB3583.namprd03.prod.outlook.com
 ([fe80::263a:babf:7ed2:3fad%3]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 07:18:23 +0000
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
To: "alif.zakuan.yuslaimi@intel.com" <alif.zakuan.yuslaimi@intel.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Marek Vasut <marex@denx.de>, Simon Goldschmidt
 <simon.k.r.goldschmidt@gmail.com>, "Yuslaimi, Alif Zakuan"
 <alif.zakuan.yuslaimi@altera.com>, "Meng, Tingting"
 <tingting.meng@altera.com>, "Ng, Boon Khai" <boon.khai.ng@altera.com>, "Hea,
 Kok Kiang" <kok.kiang.hea@altera.com>, "Zamri, Muhammad Hazim Izzat"
 <muhammad.hazim.izzat.zamri@altera.com>
Subject: RE: [PATCH v2 05/26] drivers: clk: agilex5: Set PLL to asynchronous
 mode
Thread-Topic: [PATCH v2 05/26] drivers: clk: agilex5: Set PLL to asynchronous
 mode
Thread-Index: AQHbgeAUibfWUKy9QECWYBRdCFvjJ7NOOSPA
Date: Wed, 19 Feb 2025 07:18:23 +0000
Message-ID: <SN6PR03MB35832CE26F3298B3A49C2969A7C52@SN6PR03MB3583.namprd03.prod.outlook.com>
References: <20250218083511.29249-1-alif.zakuan.yuslaimi@intel.com>
 <20250218083511.29249-6-alif.zakuan.yuslaimi@intel.com>
In-Reply-To: <20250218083511.29249-6-alif.zakuan.yuslaimi@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR03MB3583:EE_|PH0PR03MB6679:EE_
x-ms-office365-filtering-correlation-id: 84b8c97a-06bf-4359-5925-08dd50b598b2
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?YQmm71N6FHJ5vGyUBTsVgabDHBkyJPoEV+nktXtDkRPv0UGIG0xRX0NtaA5r?=
 =?us-ascii?Q?nKQv9ZRR9ee91h83TsnNql3pUGDLMF8kuahf4rVrrq+iVUHFuaMON1Ckpvbd?=
 =?us-ascii?Q?928anUtonGKgfp5Jf/qlSqWWq/7SyzVJeylrK0KR4B/buf38zcYiv+xi1llJ?=
 =?us-ascii?Q?PFiaFIKS2Zy8uMbxJkDOPaYKhlNWd/aODa7NkUr0mESdC3GGmgUBErlg4lEl?=
 =?us-ascii?Q?DKFXlYFTZqeo8T/B17tT3gYvD4T07G9jiJqRJGwSTSufPECaC5Okd+lWCc3f?=
 =?us-ascii?Q?fRNSY0YuT1Rq/dKlE5XuQSTB2Enl2idVQ7QVUyKEn6vcDyruVAsJTlrUnjLH?=
 =?us-ascii?Q?h3ssxse/FZiDdBBVnN71DsjZWfD84cT+Rd0C9+gOlOI/EsFENAjpcTWkvcwq?=
 =?us-ascii?Q?YOI6BRrzNTDTp3cI14Yjy69myOKStErYPVoFMZkxntDt9Sy7fcyQguKHtqAK?=
 =?us-ascii?Q?OOY5KI6V8S8pN3bRfkvM3VBCYcN2mCUR5G5l6JAjJicSZ0vL+njO3L3UhOyR?=
 =?us-ascii?Q?YBJIoUN5IgOzHeFU9q6O9z6sTTuOfg6aVoduQzNfk4DWyqfFLMq82SPP2Hwa?=
 =?us-ascii?Q?UcenxCSwxBX4CS5QhlOLflkUSS9dXIDAeZBSOMK4V3dsk3ewvGGIS0QsJl/l?=
 =?us-ascii?Q?s9UrgWKvs169XknD/XziE0QR93XB38r43aaj/J50lqfpblxxqRvybubi6H9n?=
 =?us-ascii?Q?GoScrz7zuYvV9NX98aqkzEClvcLdijUmAeNfau+I5Ay3bbuJbRMNLTl3frx1?=
 =?us-ascii?Q?EdBMtsxfzxu3tpemEidIGJ619ondO4DKH8tgVl6ar011gpldp2RRr6V8VOIM?=
 =?us-ascii?Q?aMh8IqRB5rKToXI1RXrwM52Xg1lhNFJjxkfw8ofO/sUKAvsIoSdu0FGv8uI6?=
 =?us-ascii?Q?lldpPZhb1YmjnutaHqY5CFvHUkWPlsBrjX0SUe08CH87/ECXqWA5Q0+0HYqr?=
 =?us-ascii?Q?hDZ+ZzezH6kgEnOYTSvGusS+boPUL3WLd4tXxISsLIQChCFd96dS8dz8RRk0?=
 =?us-ascii?Q?7UuJr6eK390leL2x/MaoUVt3nQLo+VFvZL38+B7JTlsbKeNPFgFWyhpdldUI?=
 =?us-ascii?Q?zEM1TZqwCWphFMVh0wbPu4h3/FHgCToueCNMvyVdQb2mtE7pNgt46paZJA+V?=
 =?us-ascii?Q?/7vG85qArR02h6dCbhe2EfCbn8NoErHLQn6iWVUCXUn1n0eGyXZapceifWZW?=
 =?us-ascii?Q?JVQ6l1Yzm2NqiiIeh/DBmZfrfGCaZUs6P8N7r6gDaq78rbJFNyW7H+483fFq?=
 =?us-ascii?Q?xkYhHtCvfg3lIvkvSD9qjJ67uAn5AEkY5FJFcy2snfPth+rg2JUc97KeSQ+L?=
 =?us-ascii?Q?29ojygibNJUbPDD/BpqOpGTQHlnA5YvjIhSMy75DxXB3oDre3qJnhJ6dcLz/?=
 =?us-ascii?Q?HEyUPQWH0Dkmtt4mhqJ2415Mp0RD2zqQxv/9DagyRufp6fwwyreuQUMRvGat?=
 =?us-ascii?Q?RHh/09IJNIy/mHcHEmb/4PMX581MkKGn?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3583.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KIbFXJSimdbFuVy8GZEgxbT3CdAqtxDOs/cevw1xRnWmegL41tFjQ6naaPOF?=
 =?us-ascii?Q?h8z4Mplzjx7EO2PzQQ7l6np9aTqhk/WBDT77MofGbQOwvOXSoc2qDeZn9QlP?=
 =?us-ascii?Q?hTuq0ET8zRot5s3AJMsgJx3SOXWlw/+EhDPbItB0TgFkWcjNE4bGFG0RVwpY?=
 =?us-ascii?Q?xOG8RhHA0jNA/zV5ZBKN6WWzQFolaiNt832ttgHBDFQvhuzrMAgYhU5GZGso?=
 =?us-ascii?Q?0kaPMEPLW94b5e7q9d4tCJTLKBDGKXe7tKP/lpwcgGeFRyh1x4jXVz7mhnwT?=
 =?us-ascii?Q?fITUVWcAkoZM65+XP4yHTpvAXg9NFMo9pVU7XwBTMMlgT4X6ey4Fal6kZZh9?=
 =?us-ascii?Q?6o1u2fxYsjosY3AcNKKfldK6C4oH1nsZ3Mk/xIh3ywzhW3oeQUkJ8lXRbKkr?=
 =?us-ascii?Q?llrr6Tr/zvw53SdHhR3t/Vk4kmt4E6gHgHdV0Vf1rYlDRnsQ/Lh8v9RtsMYV?=
 =?us-ascii?Q?zVMqdvqF+qvVupErgvGb2c5qR+Gi5U9IOy2JsxeRJOaiKjqhVM+EHhIsKWCY?=
 =?us-ascii?Q?CzvWRfBv90jbLvnU57EB8pSDPCVyT5/XQC9nw6J5gCLHgsuPq1oIRaKq07d9?=
 =?us-ascii?Q?zwMb+IOKpN55nAMHogXZxRuwQJDwidPMVKUAlAQPLlzyAhA6UmTAosOwFwpr?=
 =?us-ascii?Q?S68JgWId9EURYgXQt0EVN0us9CmEkdnPF1BYUkal9k7J6CJu5JIuJg/iXby+?=
 =?us-ascii?Q?wmJUlp7inWUYvRPvLKcgkeHMMOWUjACUi6B0HlpkFl1iFumBXuz06Y1AHLLS?=
 =?us-ascii?Q?TIXyQGYmGUPFyO+VOPBsESRpPJzLTma7teFRPqVDYtSaFi4/5wWxnK734YyO?=
 =?us-ascii?Q?56vj6D9T543QaREQXRJA0frSKAD1Rfzpv14kIOB6bRQo8XELIGOJXp64ZIx4?=
 =?us-ascii?Q?ru3Y+Pq32rKlleo/fDbL3cv+YPL8D1/qIqE2KrM5fBylXVSpO0L+GsdKxFSp?=
 =?us-ascii?Q?ZF+gthLiCIqdsd2xiA0968fbdpbXzo3k+6YXmMLuKk6NAQrCTUZwKJ543TGN?=
 =?us-ascii?Q?nh5/RgR570p2HDaUwG4dKlwtFs2GP3uiB+ogs3++J2ttjtr5Zbs1GaApJWMY?=
 =?us-ascii?Q?IK4OuMt+gsj5DQBYh2iqVDSDYLUTTrhz1MHec51+ruEP062wBvGGgHkVup/b?=
 =?us-ascii?Q?waU7+rivGpjlkiTTyCHFzG0GhEgNyAurihhUElGZ5AqXDtd/m62d/eQA0KtD?=
 =?us-ascii?Q?Cein2CYlbEwpGT6Wq+YJFQi34zBABD5u0D7VTm6zt1TGYsNC6VMKsT/ocO36?=
 =?us-ascii?Q?7ovxXw5tmBaacus51VIOJDZdBrpyPLRycq5BLpdkuTuvJP1t5rSVRNK8Pw87?=
 =?us-ascii?Q?dF74ddEL/RKeX/8+jWeoSDdMP0QWDm2maRUXSB2dY8uuh2wPJ7xD1ZrTlfwo?=
 =?us-ascii?Q?YdXandV/10JPjLtGajhA8X3tVsV7pEqRjf74W0mwbW2uaGO7w1DRoXaw9EDq?=
 =?us-ascii?Q?5eGag64TkniWZpvu+YKihoTBFSuLgZujg05hV/OInfs1eNOen70Idu9iuHQD?=
 =?us-ascii?Q?B0Ud6TFpxPAPNqN+jbr720zKXfzUHmvOEtWUnO1gNX/1avfLIxWA5NfewsSv?=
 =?us-ascii?Q?ULcNE7lDliY3agfmM3mXpTY5HlUbHEPo2EOf5FZm?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3583.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84b8c97a-06bf-4359-5925-08dd50b598b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2025 07:18:23.7140 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: izc68AcqRPanGUzB3foTzGV03jS+NIH/DCZpK0uE6VrI6ztwcma1avoGq8ZKR91XKbaRogKPq31v6svG10Oaj8JsXIGomNxxNMpcM5Cyqy4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6679
X-Mailman-Approved-At: Wed, 19 Feb 2025 14:04:13 +0100
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



-----Original Message-----
From: alif.zakuan.yuslaimi@intel.com <alif.zakuan.yuslaimi@intel.com>=20
Sent: Tuesday, February 18, 2025 4:35 PM
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>; Simon Goldschmidt <simon.k.r.goldschmidt@g=
mail.com>; Chee, Tien Fong <tien.fong.chee@altera.com>; Yuslaimi, Alif Zaku=
an <alif.zakuan.yuslaimi@altera.com>; Meng, Tingting <tingting.meng@altera.=
com>; Ng, Boon Khai <boon.khai.ng@altera.com>; Hea, Kok Kiang <kok.kiang.he=
a@altera.com>; Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@intel.com>; Zamri=
, Muhammad Hazim Izzat <muhammad.hazim.izzat.zamri@altera.com>
Subject: [PATCH v2 05/26] drivers: clk: agilex5: Set PLL to asynchronous mo=
de

From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@intel.com>

PLL frequency would overshoot from the original target in synchronous mode =
during low VCC voltage condition.

To resolve this issue, PLL is set to run on asynchronous mode instead of en=
abling synchronous mode in the clock driver.

Signed-off-by: Muhammad Hazim Izzat Zamri <muhammad.hazim.izzat.zamri@alter=
a.com>
Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
---
 drivers/clk/altera/clk-agilex5.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/clk/altera/clk-agilex5.c b/drivers/clk/altera/clk-agil=
ex5.c
index a284b562486..fb1e72ffc5c 100644
--- a/drivers/clk/altera/clk-agilex5.c
+++ b/drivers/clk/altera/clk-agilex5.c
@@ -72,15 +72,6 @@ static const struct {
 	u32 val;
 	u32 mask;
 } membus_pll[] =3D {
-	{
-		MEMBUS_CLKSLICE_REG,
-		/*
-		 * BIT[7:7]
-		 * Enable source synchronous mode
-		 */
-		BIT(7),
-		BIT(7)
-	},
 	{
 		MEMBUS_SYNTHCALFOSC_INIT_CENTERFREQ_REG,
 		/*
--
2.25.1

Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong

