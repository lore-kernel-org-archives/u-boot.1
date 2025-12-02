Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3AD3CFD376
	for <u-boot@archiver.kernel.org>; Tue,  2 Dec 2025 05:36:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8983383DEC;
	Tue,  2 Dec 2025 06:36:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="Ngwqzpi+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5A8283C64; Tue,  2 Dec 2025 06:36:35 +0100 (CET)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazlp17011000f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c100::f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9532B83DE0
 for <u-boot@lists.denx.de>; Tue,  2 Dec 2025 06:36:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ePWK8lbjG4FDMiSgs1oPXNXRkWFbw99jHfWBbBVd0H7GCQ9zZcqpbMDDurGg8UvAi7ytS9xKY5l5x4T3lMRTbUFOQnKaHvQJ1jeUNVrTkzqgHicsgCrYewEq1SNHLVf5Ish78dBGgv8z7fs/rlsEtEcFstdYO/l7ExnZOokFyewLUEy/+9m9hKRzon0lvhM2M7vq8DzDYwlA8N72LFhPwAmg3pa0sIPo+2rtoLs9Rx4tH5/+MOkPxXpZ2A89EoV36JHW9m/zQocKA5hAaBoH2xgzvoSQqBes3U8w1LlfgMx0v01p6WCScLAUjapdU/agtusr7W1TTqdiNBrOw6QCJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UVnqgMAJCM4iY8KX0vXbS4LQfjBXvK9Xt8bPN0H/hvo=;
 b=uHsWRM/SrzTRCKu16YeukWuK/PA0DxYqpLjNXdqv/LOzzNyWuFkYYoIEAzTmstKnzyOsL6RPEEq2+PEfYedSORWFz6MSoOyj+Zu+Y/SqREef8CPDP9AHeDouxduhFmKkAnWrVWTRU3cUfTb2d4fs3F3E7i88MKGftvQDJOBmtT5mPZyDLZb/bM2QId9dgDeBD8xFk8cU59uNwaEAOdDjp+ZGCBhJg9z8OQToYHXoKdC4iqoD7vRT1FJ35pJY6mKKf0HzUMhHfLWqjlPNGINueL9NycVJGsJuUFyf4ETS9RsFG7ysp4lGtE9Sfkx5I7q2uYjmY6qNP7Wb8Hod488UtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UVnqgMAJCM4iY8KX0vXbS4LQfjBXvK9Xt8bPN0H/hvo=;
 b=Ngwqzpi+PUgszG9hIYlL0L7LUqehBnv0uZwpsbN0twUY1T/5UgR15QjBndrynVtBhdTXtpwUdqV8++ergxqYPiPmKeIGqZc4CluwWUibv7a7BoTTieNPKwIH5iawn8odjpTiLkZ8i5LpJ7na/JYhbq2VegRPWKLEAsL5UQQBUBFaVfUun7sN4aex6yH/vMuzfn7fGBwJJaI79mKBIoedhOFqkuOu1GQY4NFZkZFDOPT2E4+WHg4GirNh5k/zC4xv/owS79Pywm1/KCgbucqzv8Ap9lKAMUffYhvzneaMOnXKd9Tu51yUo/rj3ftH/6PBDHB0lXDJAiATl6QnWXN5nQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by IA1PR03MB8240.namprd03.prod.outlook.com (2603:10b6:208:5b3::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 05:36:30 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::d020:3494:f031:fc29]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::d020:3494:f031:fc29%6]) with mapi id 15.20.9388.003; Tue, 2 Dec 2025
 05:36:30 +0000
From: alif.zakuan.yuslaimi@altera.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@nabladev.com>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Brian Sune <briansune@gmail.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Subject: [resend v2 0/1] Enable random MAC address on CycloneV
Date: Mon,  1 Dec 2025 21:36:25 -0800
Message-ID: <20251202053626.6446-1-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR02CA0061.namprd02.prod.outlook.com
 (2603:10b6:a03:54::38) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|IA1PR03MB8240:EE_
X-MS-Office365-Filtering-Correlation-Id: c72a8d2a-1d06-4e09-ef7c-08de3164bef3
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZF69IvqlGnPrLG1gz72kY8SWfmPg97Z1A31d95DlRgo7iLIvHewqBJbvYKwI?=
 =?us-ascii?Q?xd8qQkFL6DeWsfCeVbG8NKGfLRTsk2BtcMwr3ryYILn/XEVxh+rtM40ZXZmm?=
 =?us-ascii?Q?LWwVH6ft2l7FGl8BGdAWHXaiuC74vpj5MSeDBYjIDEtTBK7CiaPGpbw1Gs6z?=
 =?us-ascii?Q?dYXRSYJuk/K0E/nO4/Z4AW7kssD54J6y1iHqEdiuCtquAQ5dWuSHNFApw0O+?=
 =?us-ascii?Q?GMaXq86K+qm8R6xw4Na89dpmTKItdkjN0xcRaWdBqQNS1bBoXy7y+ug6ZMuW?=
 =?us-ascii?Q?ndtiD3FOemGArSxv1t3EeYulAD9Tolf1aEo8YNQb1EIUTcwT39hTTYMn3NwW?=
 =?us-ascii?Q?TDt2VabRu358HE8uvbb3CMWrDXF2oeB8MoI11PPCcEyLdDl4Qqlap83B/9cn?=
 =?us-ascii?Q?OaBAiF/gWG8owc3trGBhFkpVnKdxknb2EGSUSHLEfFZ4PIflNuQEMIB1l2EI?=
 =?us-ascii?Q?VRd8IBiBbnN8nmW7VUgoAvH1geK3GO7AG51UvYDUDQxiP6m4uDxvaMv9ZAtN?=
 =?us-ascii?Q?53962Ab5R0GuIccWga6fCZb0HFRG2peN/sgrNtA9eUzjkRSct1qpkczKeQEF?=
 =?us-ascii?Q?Y12fVjrNHsaVAFCk0C0U2fbiAKJzcXg/iIBW1h1uCMIds8QnrLsWXT8WFmv3?=
 =?us-ascii?Q?EVTrkZrSsRPjC402kYuoabEZx/QIGyG19yVRk4qGtDE7BcSJOjD+SNIlHsIb?=
 =?us-ascii?Q?kAmc+F7xWVEnYsde2CKLhetFRZy1gsh76nwD/ASgdXReXDCRk8ogD65F+v+5?=
 =?us-ascii?Q?fQT8on2G91dsPqeM68r91SP2BiaYIPlUO4lA5SIhVJXwjxMaISfItw90kv80?=
 =?us-ascii?Q?zg6m/CkujeHi8HjFWCtH+5kH3MFcs+3tzHDBSDqIIMeHkhK8/3aiiR9wvWJs?=
 =?us-ascii?Q?VD2axw9EdOTOXwPca6tdOTGJ+BMhUIZFD6htn9Tn12IJVpuwHHKH/RdT0B2f?=
 =?us-ascii?Q?iovoxAE5wYW6R6lzObsrnCkCTPgeQ+4dx6K1f39zfBvApU8D2sDn4y+s2ZYN?=
 =?us-ascii?Q?kfMYVKDek4w/imUidNEaP6EMbQyCmwNNZeqPLLc+VjHb8XqCwF1CFrhDTkQy?=
 =?us-ascii?Q?7i6AoAEL1XJJF+lPlcQ1Vpszn7QER8F2Ljr13zntmvyZfTzFz7h/xw38k2Go?=
 =?us-ascii?Q?j5oNO+tBqKTmXTcWWTochHX4Cf3qGEy7On3BWJ5QLVJqs7qcebk5L3SnEMny?=
 =?us-ascii?Q?GeeB3GXVS+9OknhZyrUyC1ALDVAhPV0BUDhiNjBlEPS9Imjtu1zRbM8xbDSC?=
 =?us-ascii?Q?IzCh1TPJPCjVuhbFpZXdyq8cE/QNsUUfaBXnAwsUeG62F5l1YXUGkWmzJ+Eo?=
 =?us-ascii?Q?8Q8qQSeZZV45S1qM+K5mUGU1FJvLZ0RLXD88Tvgplhub6rzqN2iGKIHcfNO2?=
 =?us-ascii?Q?i5S9ejw0Gmsm/OuhdnvRvvd7pL2pX9prM2AobNXPNIGvqjaHfVeyePDTADg0?=
 =?us-ascii?Q?0mCGrcC4HEa5I38GLYdglIifp/OMHHyJOipkjxASrXGRV8187lAgpQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CRQQb/6UJ05XtqRjVCNeI4dvAbrCCcY1OJ1Ndq6G5EZ2U2O9BW8uHE1Rjkik?=
 =?us-ascii?Q?VKPNdmxFyyBirDnt6A2rkuUODLaE4FnSPue8wzMSPoCgtzu2VkbfFfTZxA0n?=
 =?us-ascii?Q?/MlTfnaTkXOK9t/gTQwk47p/X1dJcLS/Uq0Qn/w7UCNaKYjQFHFUmECGo9Pt?=
 =?us-ascii?Q?67lGyn8FlEESIdhZa12XUjRcmzTLKd8udfzMdpSBnqNpr5LRoIHolUngcdCp?=
 =?us-ascii?Q?qNpauQqiKTQsItlRsPNMIgV5nQzaT5f7sX8yLccgMPSUflnorRFeN6VHJwOY?=
 =?us-ascii?Q?LKSxerXv0RLC1ykZcAtcrH+XiXYFYXMSqj9WRsgR6BF5r737Ds3It+43DFiv?=
 =?us-ascii?Q?5LiZrd3A2UsrHPXFV7SLUrGcoG78357K+6HuffBfoYswXlsG/Cxd6VRlcQv8?=
 =?us-ascii?Q?2UKaQohrkW8fZEb1bubIlr2gTuIbyOqZADEiX1kkV8EQfJhSsahwG+nHB4xu?=
 =?us-ascii?Q?PNQsxX9QmqX6MFSpeB1VZ11iCfycEHVepe+yMdoeaTxih2TMAyIWLkqFthnV?=
 =?us-ascii?Q?1Rtsa2T36ov/QGmjXNw8l133zfm4ot5XUnWrCqP2UaJC4BUC8xnfPpYuyewp?=
 =?us-ascii?Q?RcP0si2EAs0lW6IMVwrrtOU6Qh9DIpm/269k5jXlpBxbebbPhsA6/XzeZ2RX?=
 =?us-ascii?Q?wOSoCTzhoTJDW6usI8lmWr3xlU11U8gDJUKaGcRQCk1rE5aBRSfRgt1Qo+oX?=
 =?us-ascii?Q?XU9d1oNIO8iMg5vmzz6YotN6UGyaHuCIbvcv1uyE7NxwR91qufnWSurJzwW8?=
 =?us-ascii?Q?3JERgnnOMmNJx7LVK0e/U5CSPJBrPlKX9gsq+N4izpAq7kEAigW6k5OWiwsZ?=
 =?us-ascii?Q?ooDiplWyGvKq+XNsY4JqbSI02klizF3etdEIeT+Rz2q7uYdetaLMTD1UfkWp?=
 =?us-ascii?Q?Iq0Pv5xMXdqB0NZTNnUOsn5cKqmdODUd7YjzwgbtgkdzcIQ0NYGPkZsnlWcI?=
 =?us-ascii?Q?qy0dBJkGwm8XS5updA1bpAr6Dm6aPUjdLh83xN8E3KLdTb+gvl4VT5t23EP3?=
 =?us-ascii?Q?P4IanW0a9KsvDbFGJ345FqNAQEF4jI5seQt4rEdWOSKBsyjR75hGBLNWW17q?=
 =?us-ascii?Q?047KLr5k4T+F6+7sbmYDW3LT4jiErutIyWTYkUdC/0509VA5BWsgcJ1hXVLg?=
 =?us-ascii?Q?+H2TqMjI7WHqc3Cv+IR/MNiOkBzde5CkusBbYGXjagLVKAttZwpUhcnPrRuB?=
 =?us-ascii?Q?NAI/+H+RPRZ0w20XyGzfpY/MbB1jDUUaZLv0vGnE1I4qxuilT0jwEvP0eTWw?=
 =?us-ascii?Q?43Cc+12NO3p1UvjzJdROUx6JYffHR5k0J3aI1kiGPO3qtv8/WLGxVWzQrku7?=
 =?us-ascii?Q?UqIgbJx4AULnJwxcapGULkMNBjTnQkVyyPinGO8JnM9GylcP759uxkMl+ggn?=
 =?us-ascii?Q?p9aFfl+Hjh1rY6HjsIME0Y4GCPG56VYGSyvvIbfqsBndpS8DsIYnDksAkbiV?=
 =?us-ascii?Q?iEJ10mWJjRgp2yU3hhFdjf23/pVJiA0ZxyenhugkadnNN9CRoldXOm7F3BPL?=
 =?us-ascii?Q?qlqFTCnBs3LUF+9dknwWMBbXJzBYS9m1k7D3BhHIn9BCMYgvnTtRam5nrIcM?=
 =?us-ascii?Q?wC76inG6dZUAYtvjZ1+Mbl3DEe2t1qPf/xQ2AIz6WuWi/lbPS3QvPOAZFOBN?=
 =?us-ascii?Q?wg=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c72a8d2a-1d06-4e09-ef7c-08de3164bef3
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 05:36:30.5104 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /mazhnmalI3geOiIAzGsco+TltYgpx6rJ3TkLBC+PRhLtLRBCYtI59C8FL+cJqg3mA3SssHj7JdfsM9c0+IgEfRetcBDBm+4wgi3e79t1z4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR03MB8240
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

From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>

Enable CONFIG_NET_RANDOM_ETHADDR to allow U-Boot to assign a random MAC
address during Ethernet initialization when a valid MAC is not programmed
in hardware.

This avoids network initialization failures and MAC address conflicts,
especially on boards used for development or shipped without a
factory-programmed MAC.

v1->v2:
--------
- Updated commit message with more details
- Removed duplicated CONFIG_DM_RESET=y

History:
--------
[v1]: https://patchwork.ozlabs.org/project/uboot/patch/20251125081316.17329-4-alif.zakuan.yuslaimi@altera.com/

Alif Zakuan Yuslaimi (1):
  configs: cyclone5: Enable random MAC address

 configs/socfpga_cyclone5_defconfig | 1 +
 1 file changed, 1 insertion(+)

-- 
2.43.7

