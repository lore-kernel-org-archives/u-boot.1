Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E0C1F94CB3
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 22:14:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35C3F83AC5;
	Wed, 22 Apr 2026 00:14:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="r+yCFbOR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E8BD83AC5; Wed, 22 Apr 2026 00:14:26 +0200 (CEST)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170130001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10c::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3790B839D5
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 00:14:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=rs@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lCF9Mdx+d4SJpnu4LzJVa8CEL1gbQB67qj/xYfXXNs/sDUmpLQMV8hM60gzBCHw6Vd3qKu05T2+/V9vnLVNkgtglCccKSr5/0frM0Dx9uCzZOKU3CMmF6tU+LTFJr+Q70TLefHe6KKwoQedi9lOoyGQdyEbKeVXIGYhFR7mZSc1UnhyIIWB+905w7QTPG926puNnKxirz127KyugdSmPP5Ak6b6eaC+cI+f/vI3zCF1TZ+oH6B6yJQY/uD+jZyasRZCeDDBmaokieRRMcy5bAtC8uyNt86PawxLNLtHarW5XgojRa17srVhtlfau8moqJ8oOpZLfwdJO/4dJeuTMBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xvAGlGNN4hFFq0bvboPMfN5jk3YGvPcdecEwMvbeBx4=;
 b=U/a0NqliFOfDVro1PA+JBPjzyq+BuUdaJSSK1L7jWuI0TaOcrqyPbk8UENgWkuagoN/+g4SeNWeVPmomQaOanU0i3ctPI1ZOBsLjSRwoEy2qIMRPJ/1YNgyF6YvrKAOQYc0A2NB/voBtDXe+u7/YHSrO/0KsWicqICXkObCdVIoV1zOT+bEtCeRrSdZnFC9ph4sFzq80w5hZlnPUwJXa6lw/sMvMF1Z/bwq/cuZht5TSgWRqbVhcHXhAx7W6+NxdzG6K3KKloL/QC25z/yS8lhchaMIKPaB7mhNTJWC/DSZM7htYd38DSIj0qO1wr3yTtXgiIU/yP8jBnfXj+y2T5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xvAGlGNN4hFFq0bvboPMfN5jk3YGvPcdecEwMvbeBx4=;
 b=r+yCFbORjLBaz2/iCUQKN9bxZkjnrq9ilFNMBV6K5iqVUHUNfjiEyDZ3pBl7b0InpG056lswwhRoNpH4THAW0VftiQCVqHxCdnVO2f9kTGqh6ltKQDEioaoKE6ZACU8X2FIJt1wb0mmjmegNWVmNj2F9JWTjexgKCnO579dQQek=
Received: from BN1PR13CA0020.namprd13.prod.outlook.com (2603:10b6:408:e2::25)
 by IA1PR10MB5972.namprd10.prod.outlook.com (2603:10b6:208:3ec::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.17; Tue, 21 Apr
 2026 22:14:19 +0000
Received: from BN2PEPF000055E0.namprd21.prod.outlook.com
 (2603:10b6:408:e2:cafe::ae) by BN1PR13CA0020.outlook.office365.com
 (2603:10b6:408:e2::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.15 via Frontend Transport; Tue,
 21 Apr 2026 22:14:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BN2PEPF000055E0.mail.protection.outlook.com (10.167.245.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9870.4 via Frontend Transport; Tue, 21 Apr 2026 22:14:17 +0000
Received: from DFLE208.ent.ti.com (10.64.6.66) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 21 Apr
 2026 17:14:14 -0500
Received: from DFLE210.ent.ti.com (10.64.6.68) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 21 Apr
 2026 17:14:14 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 21 Apr 2026 17:14:14 -0500
Received: from localhost (rs-desk.dhcp.ti.com [128.247.81.39])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 63LMEEYU1020442;
 Tue, 21 Apr 2026 17:14:14 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 21 Apr 2026 17:14:14 -0500
Message-ID: <DHZ6GETQ2Z6C.2EZP9ISNJR0E7@ti.com>
CC: <robertcnelson@gmail.com>, <ayush@beagleboard.org>,
 <Erik.Welsh@octavosystems.com>, <anshuld@ti.com>, <bb@ti.com>,
 <trini@konsulko.com>, <afd@ti.com>, <xypron.glpk@gmx.de>,
 <ilias.apalodimas@linaro.org>, <u-boot@lists.denx.de>
Subject: Re: [PATCHv4 2/6] boot_fdt_add_mem_rsv_regions: free old dtb
 reservations
From: Randolph Sapp <rs@ti.com>
To: Simon Glass <sjg@chromium.org>, <rs@ti.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260420192520.1444749-1-rs@ti.com>
 <20260420192520.1444749-3-rs@ti.com>
 <CAFLszTggCLQPaJcRoxhjHOuRM10yW3pr8JjRj+LLA-ZupVOSjg@mail.gmail.com>
In-Reply-To: <CAFLszTggCLQPaJcRoxhjHOuRM10yW3pr8JjRj+LLA-ZupVOSjg@mail.gmail.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055E0:EE_|IA1PR10MB5972:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a2365cc-286f-48c4-0bc7-08de9ff35455
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: qH57Cre0VtLtdlqjZIfCXhsARTmyFBZZJLC49TLHx0EYA4l5oePLi9VABNttdbSI6qWS8Gt+tOMcDBZj5hTPlazAI3Nc+6TjIZQ+0wNIdleU+SEnaazFWBL2vDZooV7/i7G1qV7ua1Cs7mAEnYUIvUmp6jN3ilPigrzGZqitwEF9l7m6P6dCl8ZJi5VLR6O5mF2FljLSzo7lUV8rQM3O3JauRUx+HoxqbUZCePVVuMMRriJARoSK8Dz2gNGqypgj8WKBoHhpipOxOH9jUKb9OBRvBsonMr48hsqz9sQwgnxU29eQ/A4jlJuyssKjNDAQozmJXglAwQAVGz5kBbwoHdbrCMOF0mT0lnGmG2hl21YL25T0WM/fZptcP4R4zaZ/+6uNtfIzjQCJxcjiKwrd6A2S1S9orUhwgLwP9KJvjipr9lCe7yBhDlcDar0X09jsfQfSKG9Wu34Fc2xhKxN4ujaq52M8FZRZNSc0jj/KwQCYDCudA4JQ927QBOwQylvMyjIrvLr0nCpSGyqeobTfUHBzv05ub6VUmfGgp5ixuHlUUvyMxfL5o/Jooae4YpFNSHjV/40Ke3kkn8cQLQkK9Oy3buRibYoDsHgqHwjWeCQITQGDhCy1+FCwsYE7+Df0pHFBaDWMsgk7azCrBF7bPI/LdCxbrSkzZUqTF6VT3TN5FhMj7tmSo6o6M5FdYlJbKYk5Xwc0cFdpM4XnOzxmPuAG8koCNjzgCI+QDPM/1Jzqti/it++EZ2LUl88931Mnq5vqBDCDQczDhJ4XEIe3XA==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: HubBAUwnGdyQ2nTNC6eFfuDgzZpnWBrkjPz2ewy7H8GaUpXcoOl3sdOIiorb9hhvD3Z0ybGztctA/OxSOkngDLTTXBDwtQkZoNSK0+0yLVUMMgMQ8ejaL5N/n5xUAY0B7CuZnbl8PTcP/4mg7K9smfbjdEeiJU2OrDWLSS4DCNiicY3AIAb2NW7ZEJMQQd7OpoFsUrSOHgU1g2Pk9QUsx4cAO0bCRO2BpmlcpP01Wx0qjFHxcXKogIyDmnrFOIylvAsYKGjGeoGAOhDiGfAWxOrnJ/7aHt1HGZ5hYmReKANzGmzEu4Xl1rM7Yc+48SChT+X7AM4Kp8c/vz4016JzqhSYUSEq6ai3YFCmRfprITOYP2Oiv8+ZkiUDqnK9wiz4KnBObb/DXUuCd1J9OqOghaXQobNNwRBqec2arjIbTN48zEKsifPIzN/5jmZw6vo0
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 22:14:17.2700 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a2365cc-286f-48c4-0bc7-08de9ff35455
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055E0.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB5972
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

On Tue Apr 21, 2026 at 3:40 PM CDT, Simon Glass wrote:
> Hi Randolph,
>
> On 2026-04-20T19:25:18, Randolph Sapp <rs@ti.com> wrote:
>> boot_fdt_add_mem_rsv_regions: free old dtb reservations
>>
>> Add a free flag and an initial call to free allocations covered by the
>> global FDT. This assumes that all calls to boot_fdt_add_mem_rsv_regions
>> occur before the transition to the new device tree, thus we can access
>> the currently active device tree through the global data pointer.
>>
>> This allows us to clearly indicate to the user when a device tree
>> reservation fails. How we handle this can still use some improvement.
>> Right now we'll keep the default behavior and try to boot anyway.
>>
>> This functionality was broken in:
>> 5a6aa7d ("boot: fdt: Handle already reserved memory in boot_fdt_reserve_=
region()")
>>
>> Signed-off-by: Randolph Sapp <rs@ti.com>
>>
>> arch/mips/lib/bootm.c |  2 +-
>>  boot/bootm.c          |  2 +-
>>  boot/bootm_os.c       |  2 +-
>>  boot/image-board.c    |  2 +-
>>  boot/image-fdt.c      | 57 +++++++++++++++++++++++++++++++++++---------=
-------
>>  include/image.h       |  2 +-
>>  lib/lmb.c             |  2 +-
>>  7 files changed, 45 insertions(+), 24 deletions(-)
>
>> diff --git a/boot/image-fdt.c b/boot/image-fdt.c
>> @@ -69,35 +69,51 @@ static const struct legacy_img_hdr *image_get_fdt(ul=
ong fdt_addr)
>> +static void boot_fdt_reserve_region(u64 addr, u64 size, u32 flags, bool=
 free)
>>  {
>> -     long ret;
>> +     int ret;
>
> nit: perhaps keep this one 'long' since lmb_free() returns long ?
>
> Regards,
> Simon

Ugh, yeah though it should only return 0, -EEXIST, or -1 since that's all
lmb_add_region_flags returns. I'm not going to ask why that's the case.
