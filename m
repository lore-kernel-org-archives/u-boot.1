Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48A69FF8864
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 05:12:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 722AF846DE;
	Wed, 29 Apr 2026 07:12:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="D+WSScDB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 94C40846DD; Wed, 29 Apr 2026 07:12:11 +0200 (CEST)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazlp170110009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D8FC846CB
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 07:12:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r/e6dwZuFv1+7CjRtm4dJP1VrVdN1CRZRy2rKn/KEcQmxoOrh4ZeGOjGsBKu4JX1n6apQ2Db+Ps91+ZyPjin0qPrHBaEdP+CuEDUjKlvkQZ8ABPHUwr6HeYYUjOGgTdG3ARnrZ86yIRPkFQADGTT9kAo4ZgZx1HBsqTqI0gK6dVSXxrP64UKjRddkyl/KPF8sUZFDyyofVLUBSunPcosj42Y6Z2G58i2R7nOp3O75tS7/QJq9wXBUII9M5JP4BZp11saHyt4uEMKrTZQIS2BzNwvDn/hnujJ7TYyML5Oo4pLxNrTOrS6HUupTCDwB04rHptcZmS7kDCY+0vptrsP1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+lVw39HBXcZPSyf+lWfRmgdYogvXP50ug+GzdcyqpMU=;
 b=aGGc86b6dbdIinFxLmnJOjmj+s9k0oeaTsW47n9GGIAor3if7vFfsN12reDs0gUpAD9rwhM7NnN5t0iYGKfCv76xEhLjEhxqivqdFtUKeBB+CNhsYf3J/czS06lRzXyS1dwpnqELA8eHRZdaqD85zLLkfLsST7H7kzv1fALk0uD2k8iSys1ugOucK1FbrxAQq4WTS9kRsO7NdmT6WuFIruIT/Zir/A1j351f56tJjt7OrXWF/pUkhg6GgJ3MhGsV0udxWJsmAodGkMCxUpHG0gQ/DwwqbqRevrfwzuYx8kun4r+yvz0hf0ljgkxbxvbR1gIOpIoyhFl++lOwUbODMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+lVw39HBXcZPSyf+lWfRmgdYogvXP50ug+GzdcyqpMU=;
 b=D+WSScDBTqnihZevxzIX8a/Va1UWwNTj4TWGTCY/rtmCdT+a/tMRdudea+DlHFEIkx4jKNDXIl4UAZ5yMhar0di0Kk4RfWE64zbLg/r9CKPlVq1Epn/7+6NPPVFyS+TyN23u8RyQENO9/ie3hteYbxXFi5m99DT8T+cQ5/hdTsHagnmiWImv91PwROXM3Dek657qSRNNC807KbaequfCOnNzCFaxx8JSUKr55AEBrqmyNrxeVI3cvDdl7b30UCB/UvqmljNTZ166AJK+4DVCRbQctLaKc+mCuFDqT3Wm0Q/ITiEefTxZhbx0SvvdPWRyIQmjo4NVBFztch79Ss4Xmw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by DM6PR03MB5259.namprd03.prod.outlook.com (2603:10b6:5:245::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Wed, 29 Apr
 2026 05:12:06 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a%3]) with mapi id 15.20.9870.016; Wed, 29 Apr 2026
 05:12:05 +0000
From: dinesh.maniyam@altera.com
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Dinh Nguyen <dinguyen@kernel.org>,
 Heiko Schocher <hs@nabladev.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Peng Fan <peng.fan@nxp.com>,
 Wojciech Szamocki <wojciech.szamocki@nokia.com>,
 Maksim Kiselev <bigunclemax@gmail.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Tien Fong <tien.fong.chee@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Boon Khai <boon.khai.ng@altera.com>
Subject: [PATCH 0/3] arm: socfpga: arria10: Enable and fix I2C support
Date: Wed, 29 Apr 2026 13:11:15 +0800
Message-ID: <cover.1777439293.git.dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0064.namprd03.prod.outlook.com
 (2603:10b6:a03:331::9) To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|DM6PR03MB5259:EE_
X-MS-Office365-Filtering-Correlation-Id: 7821acee-d56f-409e-6455-08dea5adda53
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|55112099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: U5eZVz1j60JAkgP0oJWkrlkA8zVmeKlMYAMZfrVKiLD8sq4OcuymcQXorFWP0N2GMfAlV9L2dzJh4/rC2JPEbLv2hl6oX4b3afIkjLL9Dtm3fUlaigGootH87VXiVh7TLaNWZq7k2kTNgR0qk94UXtWLj5m/Zz72+ziQEA24+f8tc9zXZaoRLO/fLul2KyGGKv6Rs48QhQi4zd097gK5YAsi6nbSwoquJAmlXVlneCv8jSe/fRQSV3qOYBaJVDV+v2XfV4z+BK+M4qOBhzrkbGn9LsG/Oi7lT5Kp+nYKDLQHCttGinPcByv5FFoDYu/DW+ixylAdCfv9O8Yc1mZ1YTYEzcNCYSzuc9Jatk22c0flKhfamQ02ikzeVuL/uA74Zy+5gBncEi/lcRN7mEGciHj64IE1dzzq0WrJjKrOKhzZENS4AXYA+Sf7kwdKSO+9danXqdT4DpNbUzwhj2lbXtkMUPZNiYZbTlcBoHACFdy5fLqB4MSgyKSUxggCcH0Gfg96uIljKXQWdbhbZGn7P2g28dT0HDVtTqUgOMEZ//EB067NvWlxzBudZsMvKoxJdubL3HNZCTskSmB37qQQVm3Q0IWCxxjakGH9DojxotEsMkQLnPgLo0R3xeXPTNz8G6XAcvaUzpVQFfBoyxpD1eobgrMdW4ENPG/4m0QMVvoncsxmOlX8juG20rarA0BUnZokJqbTewmSYJOZ2rtL1nrWJMdFx71/0OkCzeLCzrI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(55112099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9QtcM+zOWK9dcwm+1xBmtKS+iMYx1LrB38OdSw0Fv0R0W5pcWNp7mbl3cp7Q?=
 =?us-ascii?Q?dDb9DGTmaCTaI2cSBQZicKTZI4p+pgO+fQqU9S/Tc8dikvImQqIodYtm7PAV?=
 =?us-ascii?Q?Zqble2NDTUILXNUzOoI2BlAuE1Da2oI9SBArgohL6+hbbmX2pOavkOSBff5X?=
 =?us-ascii?Q?6UdS1Opj40S6A+vl5J/pzvR6+ngZEH8KnJjk8LwNvkrcwSnFyM70ywcfuy9Z?=
 =?us-ascii?Q?zEQUztyDcPqXKfvQP+IUv5Y/1crSSQj8l8kUYZq6vhs+G7lsTPoTDRWiBvF8?=
 =?us-ascii?Q?odXNjVc28EsOlAmJfSbU+yvhGgRlCU98kmi35mZwkTM7DtwyZ4uSC9Dq9KvG?=
 =?us-ascii?Q?cKlOmCE1zHf7IFGF2bkMY9KAYxam1B4ZDi9/ukJeTwqA6ua8wi+qfYV5UMcV?=
 =?us-ascii?Q?QrdXlqMae7SAKPdiMPNfVt0S6dbLS8oUEDDgB5oVooesgOPsNo6X5iEMYW8I?=
 =?us-ascii?Q?cdDZj8YtkAVMS9Gq2eN/CLbMzj9Oo3rK/mLZKrQ4/IXaJpvNlE2svFEptdbO?=
 =?us-ascii?Q?RfKabg4UIxCapoCCsbpK6rWr0Ih+NMbxC6qHFstGAPlAlXbww2yOTriB4lyc?=
 =?us-ascii?Q?W1USwRJc05eUTsAzQ3VKxRuwihyweiJAPkBjay5eDZBImqmLYdGit5h64XBr?=
 =?us-ascii?Q?bphLwt3txaLuEp+oUnEwSuYm9zd9jBky6f6uSNjEwDaeJrqZL6nyCMtxpuTD?=
 =?us-ascii?Q?xCsHTiHuoEGexPK9/ssUbEVXHDdMSbLHxfP2AH+PpxT1Taiz+4ggPpsjLx4H?=
 =?us-ascii?Q?NUYx2tdtBHIgzOai87PqvdoU89DA7WDY3YIMFHY28CwKqNYofzWPKhG1I4Ni?=
 =?us-ascii?Q?q5kfOBSR1lTROkeC3/RDiny6NiucKJZX6UgFEWW/3FtEZ82OqT7SaPDl0Gis?=
 =?us-ascii?Q?qLtORYU+y1RHNxZTwssYDH6XRJ6wJV10fbXNbXtA9hbJwCM8BzB05bZylz7Y?=
 =?us-ascii?Q?tNeUYd8vKKGQ8tF5mw72+KX0N6gIUgAmKyIYL6cxFr7TCbgLPClYnPxOjgQ4?=
 =?us-ascii?Q?tIT6cv7n+7OBCvG1tqmO5taaeMFRiyBjb13eEEK9ngtM1XSgRnMOUz9ARsai?=
 =?us-ascii?Q?EtazE1XpgB157xlHZJx66lwCXNS44N58K6YG1tiQYez0pbacF9HethkpaO47?=
 =?us-ascii?Q?yQq6ud9JLqNgL7+81SCpMOSk/gQZ6tqE40JhgL+dpYx2TxE2xmttwcvDOjtp?=
 =?us-ascii?Q?o7E/KpPWl5Y09vg3F0P65N7A2PCR0clAztZ5GXhEuAPflGWAc/6Fqt4/LbVX?=
 =?us-ascii?Q?Y56HYa1Tx6zga6EnR6NKPh7q70FL11kBc+vFBR+8bsaksYwlT8a4whcUWAPQ?=
 =?us-ascii?Q?qvlRikz0N+EH8cLpEZdPBJEI4qWRUmHlpljPnVlGYFVKkJGGXuH6V+lO1lSb?=
 =?us-ascii?Q?T5BlgqsNH87bsin9iLLzLUjnASLao5T8OAiDqVwUcvklFisdPB8rlFZ2c/LQ?=
 =?us-ascii?Q?Nzbx7eGjG6vrtTJfU1gMQqa934zrZF+dhod9ApmQKZU2vAyuOYUHB9olQYgv?=
 =?us-ascii?Q?F/yWQIg3ul9T1kItWdP0dB+L7ky6jjKg13JpezN1yCKrej3joPdNRzd7RKAI?=
 =?us-ascii?Q?ofLhSuadh2CdDmfrC9lfY78kHKEi5HEhfRYtKp/eFxFixW3ezIdFrCNZ2IAP?=
 =?us-ascii?Q?l9XeTridlzd0FZmPiGbxP791ESjO3lg9A8S9iTkEZN96BUvZCT3VvRNMJWGP?=
 =?us-ascii?Q?EXLwGRxXrX1CUOmYWt3cWPyu+TTxCNEwJuNaFxO4SYKskhwhmcyTvMp1sCWa?=
 =?us-ascii?Q?4E7Ikf42Hh8kfAd56JWnaFIKN05uNfI=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7821acee-d56f-409e-6455-08dea5adda53
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 05:12:05.1170 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ksRPj29i0K5tjTYZtHROMnTggJK9Cvr8LwXDX6p0mQKsRJGxZwcJGFwzKvr2eW/fPFo4sKR9EAkdxRPOu4iJOsruVDtEA1gs2GNL9lsm8ts=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5259
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

From: Dinesh Maniyam <dinesh.maniyam@altera.com>

This series enables I2C support on the Intel Arria 10 SoCDK and fixes
two related issues observed when the I2C controller is actually used:

  1. The Linux DTS sets i2c-scl-falling-time-ns to a value that the
     U-Boot designware_i2c driver cannot consume on Arria 10. Override
     it in the U-Boot SoC dtsi to the maximum value allowed by the HW
     spec so the driver computes correct timings.

  2. The designware_i2c remove() callback disables l4_sp_clk, which is
     shared with several other peripherals on Arria 10/Cyclone V/etc.
     Disabling it on i2c removal corrupts those peripherals. Drop the
     clk_disable() call.

  3. Enable CONFIG_SYS_I2C_DW (which selects DM_I2C) and CONFIG_CMD_I2C
     in socfpga_arria10_defconfig so the driver is actually built and
     exercised by U-Boot's CI.

The patches originate from the Altera SoCFPGA downstream tree and
have been carried internally for several years. Tested on Arria 10
SoCDK (sdmmc boot variant); SPL/U-Boot build clean. 'make
savedefconfig' shows no diff introduced by these patches.

Dinesh Maniyam (3):
  arm: dts: a10: Correct i2c scl falling time
  i2c: designware_i2c: Remove clk disabled codes
  configs: socfpga_arria10_defconfig: Enable I2C as default

 arch/arm/dts/socfpga_arria10_socdk-u-boot.dtsi | 5 +++++
 configs/socfpga_arria10_defconfig              | 2 ++
 drivers/i2c/designware_i2c.c                   | 4 ----
 3 files changed, 7 insertions(+), 4 deletions(-)

-- 
2.43.7

