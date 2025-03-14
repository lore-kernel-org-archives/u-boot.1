Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DEFFC282DE
	for <u-boot@archiver.kernel.org>; Fri, 14 Mar 2025 02:21:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66C9980F70;
	Fri, 14 Mar 2025 03:21:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="rd9PPiA0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D539180F6B; Fri, 14 Mar 2025 03:21:28 +0100 (CET)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on20616.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2408::616])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9BE958058A
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 03:21:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=muhammad.hazim.izzat.zamri@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pe3MuYIzPXLPTbLuYmdMypwPf+6ioBgzgbuPzoav+4H3NjuTF61suorOkzGgwuoTZemeCoFcbBdQwawmw2BzyFgTeyQzqibDE7NjAkvGAzpIlw92x8C3dKV2LWp6OSx8xR9gMWsVqiLxuwxNV9SrQSu03XQXHUdh+J/MsitGhaRLD8COPtLGGwOT5epXArf433Qy22Cz3ga1m0+FCOqn13eXz1k3j7aqrbp6CS1L9hSCi/NO1K5qVs1SRwhnhb/DwfblFkDWs5VTV6vzNrXNoDYOn2KlcnE01JXydllzLsnZn/6wihI++dov2XjwT/3jZWOH0+kro+kwa00Oa7TGLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=30Ly+Cku3eMAMInZixgSboHogL3Iz1pxckJGqxJbSKQ=;
 b=Vi62M9yKZ2VIJn+cHtWpDSSeM8iKIGdEoMBfmS4Lz7WcsG19K/yoJ7IdlF4kH9c9frzamaFGcjcsdxunkJCxfEsOweHiJ8qjd+PPvxp+wzh/VyuvIuQXvHJ1eajDuMjZD8emNhNPQCPSW7hzIqJaIM5P6Y6S/Vbn5Mzne3BSZI17rmQUhfhahh1sqt3vfrDDGpMPymzt79bqz2Qzt8qdYrssag2lxzLQFXg9CI+wDFhruWtJmvfxR2soSBvNUIpt0F5B9rgjcew6QHF3sxsvuN8yzbWvv08Jdizl3Ce3FD5ODKH+c1sD9t0FVXY3WWDGfwy70+Sqd8f3Uvx6GTVIfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=30Ly+Cku3eMAMInZixgSboHogL3Iz1pxckJGqxJbSKQ=;
 b=rd9PPiA0jzLtgkaNnBJX+bk0AUQxDDeQW1BlJtLtLGWGX3MCJNCNrhO0ArmOdj96skBYASa2TA01zDX9xugJox7je1X9JRjO3qpoQLaKJ4/KQOkQAae7CLj9diSEMyLWo521ch4WSmZl9IRs/nbf2D36qQ6pvFz3/C/gl2Ts1zP8VhwhT75IDaMeeDA7urra6B/bqbZXgIFuyoKzPpgw4H5OVxHxEModGsIU+dsp1lz7i4VSidH4gC+BpMZ+69cmwgKQQD3j7O1bZcVOLiuOaLcyHBVTN+HWq2pw67Rwy817+GCabXxtYKIrDG2kYGP95THwoE0tdMYQHW8F4XDpHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SA3PR03MB7491.namprd03.prod.outlook.com (2603:10b6:806:3a0::10)
 by MN2PR03MB5296.namprd03.prod.outlook.com (2603:10b6:208:1e8::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.28; Fri, 14 Mar
 2025 02:21:23 +0000
Received: from SA3PR03MB7491.namprd03.prod.outlook.com
 ([fe80::8a2a:76a5:d9a0:c191]) by SA3PR03MB7491.namprd03.prod.outlook.com
 ([fe80::8a2a:76a5:d9a0:c191%3]) with mapi id 15.20.8511.026; Fri, 14 Mar 2025
 02:21:23 +0000
From: muhammad.hazim.izzat.zamri@altera.com
To: u-boot@lists.denx.de
Cc: Michal Simek <michal.simek@amd.com>, Tom Rini <trini@konsulko.com>,
 Marek <marex@denx.de>, Simon <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong <tien.fong.chee@altera.com>, Dinesh <dinesh.maniyam@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>,
 Alif <alif.zakuan.yuslaimi@altera.com>,
 Hazim <muhammad.hazim.izzat.zamri@altera.com>,
 Tingting Meng <tingting.meng@altera.com>
Subject: [PATCH v1 0/2]  Add FPGA configuration when booting Linux
Date: Thu, 13 Mar 2025 19:19:51 -0700
Message-Id: <20250314021953.18379-1-muhammad.hazim.izzat.zamri@altera.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0262.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::27) To SA3PR03MB7491.namprd03.prod.outlook.com
 (2603:10b6:806:3a0::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR03MB7491:EE_|MN2PR03MB5296:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f12566f-f3d7-45ee-1058-08dd629eea44
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4SPafCgS2i9d4Wq0u4KiV43uz/7xDfvGAqlKR8QKQew+oWxuO8UWtADcuPMZ?=
 =?us-ascii?Q?EMgohS45FMKdhXVspUng2ELl9xHLfc03Y/yFjcXGS/ZYvHrQNx/DBU9H3wkc?=
 =?us-ascii?Q?xiZqvnrkCKjgd+Jlbp9saxSFK/qm4L2Dyp7IPQTf90ThXUJgO6YPlcX0S7j6?=
 =?us-ascii?Q?OeWmLQXyRdDZK8W/Z64Sao+el3prni3Gi18eMIuoHicj5gcfkeKmpwRbCFVK?=
 =?us-ascii?Q?9M08++U14dSEb5RjNWWRX1BnEY19bURBY2NJt8EW2Vr9z3gQUeR6DI8Cjzn+?=
 =?us-ascii?Q?5iXb/Y6x/HwUojYxpqrfRRaWDpLtu0V+Dky+eYTzWSLv8uFTp6W0VWgRiuRk?=
 =?us-ascii?Q?fpMrHnUDohD3sDx3tQSaV4wACiobzNCNjNNHqCNjdtQ8ijdxKNcm7p32Y32L?=
 =?us-ascii?Q?eI8WsGqlCQBPOwSU4qwVBxLRXvQscBnxmS5zOEmC5WYDUZLRKtR5u1XUC2aI?=
 =?us-ascii?Q?tKTd35z3wIhpqxeq1RZ/DMjhb+oFeSMY9zlzBzt/5ul0c2H97/6OXQyMlTCD?=
 =?us-ascii?Q?ovVo6cbtIk4n5QpEF1XHPV7CsINs5T22EiEvJURYCz1VRsKUpsSEuh/vhc2S?=
 =?us-ascii?Q?tBLvQMGW+LRQMYvuC+L8Vwd7BwhztMzqCL29vd4RFACncPfVXwABkjyldAbv?=
 =?us-ascii?Q?ZuTeoo34LodhBeXYTkLo5gnmvmWFwDMk861bnc7acJS9nY3DSiu9s6bLQKMN?=
 =?us-ascii?Q?MiCm1RCNvbgAgChz7XkES727IV/K07tOtNfo9cz2e/wwhhr31IHfTlnyGpXg?=
 =?us-ascii?Q?eFJFoxMgXf3oFO1LJ+fL729LzOFARyqQhxIS+2lmSDbaPRabTmQP/jMjr36c?=
 =?us-ascii?Q?RpBUiOB6Jcnhbljlidahby4oxi9vhqDEOM67k9iDmCKnXY7fc+mv8POK+2cf?=
 =?us-ascii?Q?jcVdqfqToleO3+aJBM6mjis+gJV6Jp9fqK8Ka1aW0TJTeCWrpGO0d4MfKkG+?=
 =?us-ascii?Q?2xFom47r26XS+lloBdFaLpIzKCKL5AqZPafNyBTOrCTkP2Z67k9HHiwrvwTe?=
 =?us-ascii?Q?tMYAPThk7BHgOEMhT6o+DHffv+rIAhRzK//095gHfZwp4Cr4SZOEf1AwHgB5?=
 =?us-ascii?Q?o2yQneW9N9tFg9W1QwKam/UPpBELUdSZOXUEOce1Xi32Jt1KTlXUSAkrEqsO?=
 =?us-ascii?Q?9yGt+udQ6EglEHk+qF3HRrL1Tn/jYYsNO/7VKeBHbhzwF3S+KWp5K9tn7oEk?=
 =?us-ascii?Q?k5Lg2Yml2krdXpjRkFQ3cQbn2xs7QQz0T/o1TmoT7fNG32AS20Rk48fgBmDk?=
 =?us-ascii?Q?7zXtCQa9TKc6IEeWg2NqVxI43G28tEp2SWsdav9to4Ggjt8QS62T5/D1ssbt?=
 =?us-ascii?Q?onQ+FpKUF02OnGLQkDScC1qlBcDoSy5U+oUc5od8UrcK/JmdVEJtACPbVVNS?=
 =?us-ascii?Q?AO8Kd2O6k0dyV3DvEW/Hedbg/OaY?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR03MB7491.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HxfgpjgqnkjFGrsdS83Whs0kIacdVi3DTcoCf+6I8d1qVrzENy0RbcfvarOE?=
 =?us-ascii?Q?g0nqnoO6M+9hC8azx95jobl2BErI4qhK/V9mv7knQ0zU9iQQ4S/wXGJGvAsi?=
 =?us-ascii?Q?g86t9M7hruHFNf2KnG0FThv5+7VQLjsCAFAGrIcegdisHCCnyasInpMvdPge?=
 =?us-ascii?Q?UFhkCQmk6OlszT21AzjXcCLUM3NMmDp5SCF7O3HiqF5OIomQMsh9Hj8wz/+G?=
 =?us-ascii?Q?+Z2FGy3oHQUHhkI85pacl9e7tW/Jl33344ZE9x2TeLv1dIaFaDH28y3b1RAe?=
 =?us-ascii?Q?Il9AW3ZPQ4S0FOVMTPM3IUDNGuktKrR6ZHi64n6sjzJJd5bpKVn+cxbo+Lb2?=
 =?us-ascii?Q?GZbVhmvRfzFGlfMS1Zt/sK0g9Y8uYXP916Y+RBA37z/JI5/4YDVos3zG6O59?=
 =?us-ascii?Q?ScHYVnrCjgq2L5tqTljUOl7RxvUNDqsdJOxGm8dtxtgcbjATa/24ga6YY6ik?=
 =?us-ascii?Q?rVJjN0EGLSFe96XgO9JIlG/xwxeqcCqBlQW0X5Oq3jNYOkXNOIgVil/HdTFr?=
 =?us-ascii?Q?ndxTlzGoXThRGIrz5teOsHUMeTX/W5PwJNTFk83blSqHX1ByGy7RRWOg1JwF?=
 =?us-ascii?Q?OsWe50/4HJNkikW9AbqapNDR0DoFFtPgFa5ynrYTobYT7/l5l6pWzpXFJ0PO?=
 =?us-ascii?Q?L6mhzpp7QSP3LOHYxlEn/7lJRri/AmuZvQGy7bj+SULj8PC0qdH4Dk8fi+zQ?=
 =?us-ascii?Q?WaW+gv48CkijNK7KcVgdHAnhLATeaSoHrytgKGJCs8UUEbXuScfq/FTzBBc/?=
 =?us-ascii?Q?mG5g6Yn6h2902699acICOHRZoiGJUMmeI9/CxFHtlvwYhhiE1u+slTMSj+hC?=
 =?us-ascii?Q?SpeOS16snGVQvcEu2qn3AXJmN8agBEkR3P+TeugQqw1TBycTmf1Z6+7d8qhQ?=
 =?us-ascii?Q?ExvO8sZ0/kMUWMg8lW06vCPR06rhHuv0qAMeyGNm+P4P4GHfxiFl6Dm/2eX5?=
 =?us-ascii?Q?1Ven7zflTjEgzzuvj6zLQ8Pd3KFYZHqtsJCojTbYUHAVmeitfuoaV7nJgEoG?=
 =?us-ascii?Q?jVhRNKjwyc1M3SVvnOhSARFgOgGAbPYPZY7270SoIG+d4AiDRC75XW2Tqjku?=
 =?us-ascii?Q?M0ZdmLWdBLn0bR2hBcHgGBX3OnuJu372fI6N87eBENxDw8eMY8WdMo2IoclQ?=
 =?us-ascii?Q?ZglXS93Q3vt4Ho29OZjiIUPUlOThJbR36NsN+eTRERdHzl5XHXDtiUBa2Gfe?=
 =?us-ascii?Q?1UTRsqoMVwkAzgNFzL1bwPN4lLt8lhATtM2LwNzsDzNLyE+JCp05uKTkQEfJ?=
 =?us-ascii?Q?5fzeXsDAnDVZ3tqDCQviqIDJ8Xq1iR27eAdeQVey4xAz7hWOsJGu31QKtUdT?=
 =?us-ascii?Q?dULlsS1gO67p06ZexcLVnENj7d6mhaf3sJ3NHUsljdkUACVEpJkrzLw755Xs?=
 =?us-ascii?Q?eu7Ows/qRqOpnKIzdxNo6dGwtPFdVRU+fI57BTDSU7Q75WilNewzm3Atnv2+?=
 =?us-ascii?Q?AhbN2qtaUuH+kooKAsEPHs9MzcRpXMgq4BY9IWuCu0Z3pf8c4i76JYOjA4wn?=
 =?us-ascii?Q?qe+/R33PWrzATOe51IIXOm6IUM0pjdMmWfjqAfMTXnJGLzKMF2rfFkkxewrd?=
 =?us-ascii?Q?/0ueFxb9xhlVK88CQ3eux7GjxURGWg5lZT08TEXPnO180mReH2LBzkhdEzQ0?=
 =?us-ascii?Q?WsvolYo8YKCXWoJI4zjxS0U=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f12566f-f3d7-45ee-1058-08dd629eea44
X-MS-Exchange-CrossTenant-AuthSource: SA3PR03MB7491.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 02:21:23.3411 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AVQtLR72LMbu/j44dMm9tV/BeFIAKx7eiKnuoybEOtCvqt8vhxY0gBOAUpHAM8TkuFZMc/z5ilOBQQJOTcD7OFtekqWK5+0GNBTXbQfm3vjg1fhpKaS9DPnidlSVV5rn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB5296
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

From: Muhammad Hazim Izzat Zamri <muhammad.hazim.izzat.zamri@altera.com>

This patchset enable the capability to automatically perform
FPGA configuration when booting Linux FIT image via bootm command.
The FPGA configuration bitstream shall be packed within the
FIT image.

Second patch is to add additional flag to check whether an FPGA
driver is able to load a particular FPGA bitstream image.

Both patch have been tested and able to boot U-boot using
debugger and QSPI boot.

Muhammad Hazim Izzat Zamri (2):
  drivers: fpga: Add FPGA configuration during bootm for Intel SOCFPGA
  drivers: fpga: Follow mainline to pass compatible flags to fpga_load

 drivers/fpga/altera.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

--
2.25.1

