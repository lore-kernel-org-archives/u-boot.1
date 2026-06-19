Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4444BCD98F2
	for <u-boot@archiver.kernel.org>; Fri, 19 Jun 2026 14:03:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC341849BF;
	Fri, 19 Jun 2026 16:03:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qIYurx1n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5DEBF84A04; Fri, 19 Jun 2026 16:03:28 +0200 (CEST)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99AB3847C3
 for <u-boot@lists.denx.de>; Fri, 19 Jun 2026 16:03:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Padmarao.Begari@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UPaJxqm2/2+91D+VCmryOboFDVOHsOU0zK5PCJ11kqHUalMkfS2iXVGTZutesfqfNG7AXqFybZNjU+ngPemGGFuPgSMvXAxkiknyy8vcSD3W47C1nFuldNnpz+DfTxhJYjLW4eGqSt/fEJUYP730nO+iIg/TlFBalPfrhKxhY3ETMRWE9faPVYIpvzZqBy4+vkrVi3z3KP/hzj8MDujLHToAWS9idKmfox841JT6/3abF5m8Q6LSoZLXqLQDeLwwoh0p5zZGZUwO1b3txXj1GNxA3kIesd3ELg0hLycxlEbM/kP9Q2u5TESO0j9YobrTvglVO5f6oBY3U9YpU82x+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xN4kLlMs6ZM4X35i1cEphAuu20NJny/sBOvveH6+/C0=;
 b=rn3GxU/rYy8EBl/2GEQJ61HTHG50xKiLFbSBtZFD0LNc2da+kKq2Om5TXo9FgiaFMp9tAKJnx0CuwsXQBflYNC7RJxtXpgIp4jyN/+zuqDSGY0xPKFqmAKdQwfwdM5FEhbgCt+TetXclEDfh4v0EkkI1xWvaUauRUyhCHliBlzpOwKXPVMJuD6N8gB/BfkboskZ2Wcd/rV1pTh2dx1GhQtDFR6Htkx+YHDiPmkDUUxmgVrt0HddEL91QO1z5sTwt/0/Mn6YXamM6heUcsfSWoiXgB3LzIIK5A7HuHcoryb2Xdf+0FeW3s8mWHMRU5wa+D2KTyV/JVz/a8ca7OBxVtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xN4kLlMs6ZM4X35i1cEphAuu20NJny/sBOvveH6+/C0=;
 b=qIYurx1nBzCL4ean2OcjmqkclmLMSDFqgkFfIhlDm1KfHe+Bt6N+e0H0Jfh01mw9gCfn4YJE/kmwrdGxq6MwPk0O4EwaZRfYeWH2YJfAfppncQr+NHMUsNOJkAkBCPEm5Qj8U9jeJmqriW5oKf/tj9ekQKKdihRlLLhLkPICCQ0=
Received: from PH0PR12MB7470.namprd12.prod.outlook.com (2603:10b6:510:1e9::20)
 by PH7PR12MB5654.namprd12.prod.outlook.com (2603:10b6:510:137::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Fri, 19 Jun
 2026 14:03:20 +0000
Received: from PH0PR12MB7470.namprd12.prod.outlook.com
 ([fe80::c3e8:ee3e:aae:e211]) by PH0PR12MB7470.namprd12.prod.outlook.com
 ([fe80::c3e8:ee3e:aae:e211%3]) with mapi id 15.21.0139.009; Fri, 19 Jun 2026
 14:03:18 +0000
From: "Begari, Padmarao" <Padmarao.Begari@amd.com>
To: "Takahiro.Kuwano@infineon.com" <Takahiro.Kuwano@infineon.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "Simek, Michal"
 <michal.simek@amd.com>
CC: "git (AMD-Xilinx)" <git@amd.com>, "vigneshr@ti.com" <vigneshr@ti.com>,
 "trini@konsulko.com" <trini@konsulko.com>
Subject: RE: [PATCH] mtd: spi-nor: fix dummy buswidth to use data bus width
Thread-Topic: [PATCH] mtd: spi-nor: fix dummy buswidth to use data bus width
Thread-Index: AQHc+ZCknqO4mGOKWkScz6Y9QxCKXrY6qgIAgAsyjlA=
Date: Fri, 19 Jun 2026 14:03:18 +0000
Message-ID: <PH0PR12MB7470627F309CB669976B8B1BECE22@PH0PR12MB7470.namprd12.prod.outlook.com>
References: <20260611105339.1595098-1-padmarao.begari@amd.com>
 <5b3457f2ed784f93ab00e3067d5b95ca@infineon.com>
In-Reply-To: <5b3457f2ed784f93ab00e3067d5b95ca@infineon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-06-19T12:33:35.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB7470:EE_|PH7PR12MB5654:EE_
x-ms-office365-filtering-correlation-id: 256b3781-7db5-4264-0e63-08dece0b83fd
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|56012099006|11063799006|3023799007|6133799003|22082099003|18002099003|4143699003|38070700021;
x-microsoft-antispam-message-info: HlJWxLNwNVP2FM6S4ypz6KLbAodzzJ/y7D3OHY10Sds/5U3sxyNjKHyPHp/5OSkEftlmrCMYfQE6FCgMYF5E1Jzoh9pkh1ybzzWZxsb/PTLv+sCuu/7WRaXw2QYu3Li3liHEUu3d1MFVYYGBzURcFcFOg/mj/VAKKaMDb1wX8jP3v4O6zypxEfF1Sc2XM9SzHXrY4KuYPHLgCNLD1/vyMUbTJnEOAWizce+2m//Bc2+rj6SbZyljIpJPBpIE71cEOHhM2Y/8y5On27c+RZAqbnEox4m5dxKxInXrLaB3UnGYOlj6DGQ5qkJOKLxOHXj0GXIlRekFKSIiIxcbwkaWV2Hkp3AE0Rm7PPtz3mYMBQ6299EMfA/ijlyzNStAYkX6VYg0TI4AYvToWmkXmn0tOz80uMBbmA3PA4LyoNHdrBSh7oRkBA6TyFUpy4GQ7OrkSaysqVEB/S/k7+nGjTRMA+71E46ir/+KLQLTRNdxcSy/8hDJJ3JhKveuCVlhJmhWJ2ByKAuvj6u8BK7Wt+ALgt7ccUhpcdv7aMN4FZd7XTscURwx33HcVf8Qp8uAvGhQp1qNm4BE6XgfwC1C96wkQPg8AHRONVJtybkuS9ku+C3h3UearJRn6P571uJWGsjLN3cI8TWxsjUGIhZzOVbeEuOom0ra8reNkFfQxw7XwDlyTTCWQUIZD5ZmDnxEkJ9jA8x80kKKGvMUJwmCnGK5RRNNsb0QDGXo8ueJ3fIzXhY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB7470.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(56012099006)(11063799006)(3023799007)(6133799003)(22082099003)(18002099003)(4143699003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?k1R9Jx7aNNc3r47AEwX8d5N7B8TAaSgaeWEKS5RAExOvGEdwtrWatZyqV03y?=
 =?us-ascii?Q?j0cQmIpryqhi8x4VG8WSIwLrbl37QjENlTbl7h10TXL+NijpnyKLmhYL2hzH?=
 =?us-ascii?Q?I+K0bR7HUJhZKQTRXVVB41skjhQftGEdL6kQDbGvuaoe9U42dAE2+ZH1p2CA?=
 =?us-ascii?Q?fM5sOSkoywZ4VABRZcrTt0fRgfdYFuUEzyh/MBpEo7fNtLGCc/CC5rPnDUjc?=
 =?us-ascii?Q?/DAC+wNZpikpIY9bG4NRXiTAuU4iyFRtzChh4Ccgt4eAyHWkqaETMgwin89o?=
 =?us-ascii?Q?tC2CE2VZtsORIInH0d7prDycewFmwgHC6mVVyO4NVS33S8pbw8aI5X8aq6wx?=
 =?us-ascii?Q?2i/EsCPE0adejg4jq4HPcmZAg7cdcxIdE/qtBjd2kLviXVXmfdUAzKMSM/cz?=
 =?us-ascii?Q?z80xjmzMgBwYJRFSetSVRMdVKcTD3LJHxWItiVP/rLEvMesY3/Rd/BXuk2C7?=
 =?us-ascii?Q?lummRtoEkRsIjM9QBDFGrUNTQkHHq7kTmPuJ4pgsHar3jTyH/TmSFkI/mRjJ?=
 =?us-ascii?Q?ESqE3HGgVP/5uaSDnCrFWmEfuOO+6Ja1kF5yPL4KN27HvEqSBYWWa+VOi9Te?=
 =?us-ascii?Q?/z4sqWZSm+n4sYjC8aRJGjvY0KUdyWW0kvUBx3d8RFiL1StXEfjZnMX6Bm0z?=
 =?us-ascii?Q?IE4aQlxh8HClvrujY4LpEInR1OaGLI0YCDCS4b60rLg2CF7hRni8jzNNt8Cc?=
 =?us-ascii?Q?JbJYGFQ3j0Rw/5fZ6tjTDNoVAE/BmyBqTsLg0FNHyxnu82baJvklJS5d2DQa?=
 =?us-ascii?Q?wIHXtC337wA6rZCRAeCp2828MpFf0N75euYLFfSISlUUxJMDKOL/Ht/v9xna?=
 =?us-ascii?Q?Px0f6hkT9tt8L5yXw5uwpk5vdoWna14J2zoZlQj6u3OQthCr3iG22omJqYaC?=
 =?us-ascii?Q?0R7q6aV3muFkR3yKhEhZhDehSy1YgVIeTprtFhNN/LrbA42i4jeg8Ztz3JX4?=
 =?us-ascii?Q?DKotJeViWPfcJC2S45/gRL0rR5mWMsgpJ0YCHUW2BX8Ukrc2xSD9eGiV3sdL?=
 =?us-ascii?Q?SP9k114D3rPBjQryLYgmEOwLPvLXpyuA/WQJtG5Lfxfg6qxBC9avJiZQrhC8?=
 =?us-ascii?Q?I5cmOYJSJAswSVH9gnNalTA/ZlmC1PUNyKadjPq/WA5zwvDIgr6n+lKtV93q?=
 =?us-ascii?Q?GeLozfbrwGEJSUXKdueD6teoy+jfVinTfO/a2HX0HJLwQ0KK6q0A2MNeL7rK?=
 =?us-ascii?Q?zmENhxFWP15WR+q+HyA3YcAwfst9M6mC6qqoMJNWykCK2mS+OUSDDAQJFtDU?=
 =?us-ascii?Q?U9QaZcstlGd8dji4pmfEGS3gmHPhLfEc2g2kXmjJQASmyfxVsiGmfd45XLjI?=
 =?us-ascii?Q?ysFPpeFT2zVJ2zSrqX4R/eOvxq2asHDGN6L4LsKBsW3wcUtCYSkFANHdC3zi?=
 =?us-ascii?Q?69oam/2WeDd2pvaojin8+Z3syegJX8YEYwZydIC6j/xPBmWKMJytFFXnaWVx?=
 =?us-ascii?Q?NDOb0PrKswnDN2p2ly1oEGiT9dosQWS6bN8/wO6Vpptvvf6Zae0Z3LAZTN+i?=
 =?us-ascii?Q?ubPqgeHbiVfSwQTx2DlaNlV6ajL84HRpGuj6pLh6KGcj63zr6dpZtPXHe2ZC?=
 =?us-ascii?Q?yS4mG8WI/vBHRL7PIAtuyhgNbgoUIBMBLtdDBk/uUQcJCzu9zG7BQGGT0VWv?=
 =?us-ascii?Q?BO9NCGhN+FFavI2jr/fsnS8chcGrheT+btoy+zIsRMCHWGd5vtCCqyxx3wO7?=
 =?us-ascii?Q?KPorWi8ALLhBDmKhV86Yf5QIN0nxlSOToZBawPM1zEO3yD97?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7470.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 256b3781-7db5-4264-0e63-08dece0b83fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2026 14:03:18.7465 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S32KI2en149ID+YsTRunWXFcyBWlEvnekUtlAhmTH4WD0YUCrLDEw0GFEUZM/bOZxISmpHZmN2mvnGgHKC0/mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5654
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

AMD General

Hi Takahiro,

We observed a data integrity issue with Quad SPI flashes on our AMD (Xilinx=
) FPGA
platforms during testing with mainline U-Boot. and this patch submitted to =
address the issue.
however, it is not required, my detailed response is provided below.

> From: Takahiro.Kuwano@infineon.com <Takahiro.Kuwano@infineon.com>
> Sent: Friday, June 12, 2026 3:04 PM
> To: Begari, Padmarao <Padmarao.Begari@amd.com>; u-boot@lists.denx.de;
> Simek, Michal <michal.simek@amd.com>
> Cc: git (AMD-Xilinx) <git@amd.com>; vigneshr@ti.com; trini@konsulko.com
> Subject: RE: [PATCH] mtd: spi-nor: fix dummy buswidth to use data bus wid=
th
>
> Hi,
>
> > In the current implementation, the dummy buswidth is set equal to the
> > address buswidth. In case of quad SPI (mode 1-1-4), where the address
> > width is 1, the dummy buswidth is also set to 1. Due to this, the
> > controller driver introduces 8 dummy cycles on the data line (D0) only
> > during a read operation.
>
> Doesn't the controller driver introduce 8 dummy 'clock' cycles that makes=
 all data
> lines (D3..D0) idle (typically High-Z) before reading?

You are correct, the commit message description is inaccurate. The flash
device drives all data lines (D3..D0) to High-Z during the dummy cycles.

The actual issue lies on the controller side. When the dummy GENFIFO entry
is configured in SPI mode (buswidth =3D 1), the Xilinx ZynqMP GQSPI control=
ler
actively drives the IO lines with fixed values during the dummy phase
(IO0 =3D 0, IO2 =3D 1, IO3 =3D 1).

When the data phase begins in QUAD mode, the controller must switch IO0, IO=
2,
and IO3 from output (controller-driven) to input (flash-driven). This direc=
tion
transition incurs a one-clock pipeline delay in the hardware. As a result,
during the first data clock, the stale controller-driven values (IO0 =3D 0,
IO2 =3D 1, IO3 =3D 1) are sampled instead of the actual flash data, corrupt=
ing
the first received byte.

When the dummy bus width is set equal to the data bus width (i.e., 4), the
GQSPI controller uses QUAD mode for the dummy GENFIFO entry. In this mode,
all four IO lines are released to High-Z during the dummy phase. This allow=
s
the direction switch to complete before the first data clock, ensuring corr=
ect
data capture.

However, instead of changing the dummy bus width to match the data bus widt=
h,
the proper fix is to address the one-clock delay in the ZynqMP GQSPI contro=
ller
driver.

Currently, in the zynqmp_gqspi driver, the function zynqmp_qspi_fill_gen_fi=
fo()
starts execution and waits for completion after each GENFIFO entry. This ca=
uses
the GENFIFO to become empty after the dummy entry. When the GENFIFO is empt=
y,
the hardware returns to an idle state with SPI-mode IO pin values (IO0 =3D =
0,
IO2 =3D 1, IO3 =3D 1). When the data entry is processed next, the first dat=
a clock
samples these stale values instead of the flash data.

Fix: Use zynqmp_qspi_write_gen_fifo() (write-only, without starting executi=
on)
for the command, address, and dummy entries so that they are queued togethe=
r in
the GENFIFO. The GENFIFO execution should be started only once when the dat=
a
entry is added. This ensures that all entries execute back-to-back without
interruption. As a result, the hardware pipeline prefetches the data entry
during the final dummy clock, and the IO direction switch completes cleanly
before the first data clock.

I have validated this approach and will send a patch for the ZynqMP GQSPI d=
river.
This patch can be ignored.

>
> >
> > Since 4 data lines are used in quad SPI mode, the dummy buswidth
> > should be set to 4. The controller driver computes the number of dummy
> > clock cycles as:
> >
> >   dummy_cycles =3D op->dummy.nbytes * 8 / op->dummy.buswidth;
> >
> > With dummy.buswidth corrected to 4, the controller produces 2 clock
> > cycles of dummy spread across all 4 data lines (D0-D3), which is
> > equivalent to 8 dummy bit-times, the same as before. This fix applies
> > to all bus width configurations (single, dual, quad and octal).
>
> MTD driver converts dummy cycles to dummy bytes by:
>
>     op.dummy.nbytes =3D (nor->read_dummy * op.dummy.buswidth) / 8;
>
> So, if you change the dummy.buswidth, the controller driver will get same=
 number of
> dummy_cycles.

Yes, You're correct.

Regards
Padmarao

>
> >
> > Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
> > ---
> >  drivers/mtd/spi/spi-nor-core.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/mtd/spi/spi-nor-core.c
> > b/drivers/mtd/spi/spi-nor-core.c index 937d79af64e..19446265cd5 100644
> > --- a/drivers/mtd/spi/spi-nor-core.c
> > +++ b/drivers/mtd/spi/spi-nor-core.c
> > @@ -264,7 +264,7 @@ void spi_nor_setup_op(const struct spi_nor *nor,
> >                 op->addr.buswidth =3D
> > spi_nor_get_protocol_addr_nbits(proto);
> >
> >         if (op->dummy.nbytes)
> > -               op->dummy.buswidth =3D spi_nor_get_protocol_addr_nbits(=
proto);
> > +               op->dummy.buswidth =3D
> > + spi_nor_get_protocol_data_nbits(proto);
> >
> >         if (op->data.nbytes)
> >                 op->data.buswidth =3D
> > spi_nor_get_protocol_data_nbits(proto);
> > --
> > 2.34.1
>
> Thanks,
> Takahiro

