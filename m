Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFD58C02180
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 13:30:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A3A180756;
	Wed, 15 Jan 2025 14:29:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="StPAjvE6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E24380753; Wed, 15 Jan 2025 14:29:43 +0100 (CET)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on2062f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::62f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56AF6800C2
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 14:29:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=COKvMoSNZiqkDHgnZXUQ7bFwahwV5Dq6mKX+w6QYuqqBa7OW2Nuq13kdaVCZ12eDU3tbuXn1ibff/Z03vISkho/29fwxo4xvAdZe37ZidiXCL35L1oG9I3N+q1VSfD7GMJyPQCS+fy1WNVTKf+3sdOl5W1uTvTB+vKZ8yPhADh62HqZ33UYDaF/JtKw2fC8KQOI9W/57FQ4HM2gebUPJ/MEAgaPhk4TPQ3vYPvJSPSWtT8wRa1q3ULlh2VdywydiC0ciKDLwCRj0Fe/ddkbRgcHwSOHoUa7p4aCSLK2Dpga9JuKrQAz+oXWDyrqEpn7cYqPyfSq6quxTLPX76O6EVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aKCB1yfDAmx03l0mhXjOjDppFlvblqH2PWIwM7ocSCM=;
 b=FnUe3Mq4EkIiQLzCqERQLmGJw19HeVdGMzi94yZ+nhwTq30hl8OgkFw7rsqJK7O41fTRPIx+qf6OusFtCTdxTzMZkmM10Kev6TlAub3tKS0i7lMbxDrcVFh3lzoFXv0yvLytn7g1iHkrYvByvmJhwj7dbYKhKhrZ3ZhwyioKDGfLDO87VKY/hf3jRVEdnSo6RsPSe7uvzgqLYK5Og7+rjJTqsTkS1ldG+66ucmPNn3betlC2NtvZwt2ABxNIDvl97ml18HtE6fDMguvZ5m84Yu1lEF0+Nb+quP1gitg0Z0eIKuoLUTQ7TOECm97It4csILxTDyXryCg3X0NcKMO6pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aKCB1yfDAmx03l0mhXjOjDppFlvblqH2PWIwM7ocSCM=;
 b=StPAjvE6P3MeP1UP+1HPC2vdFMOQ6OJqyFtrSgNweSXqdFXYNPLRxGdw+C+rWAkapeuwTGAZCgy+h9Loyv8MFjgkXj0CpTDHy+IS6/pQpBikbX9vEmDanc2BMTB3JY9kVUnpK1W9+ETWox6g8UWgwRpnpfYmEPOyleFp+9zgOqbPRA4sRFH17+KhNijRJCxmhygWt7hjjjRUYNY9ZoYIqak3+5dB3aRYwqC/TF4GbWiOKOqqiPQcZq4ygTCW610OkeU4M4Dm5/rZdXKM+2R7oRSzGUkiIcysoXQlwm8Y+3hYF8zC+FQARlx+5ze8cJMupfjxsNjVwlUQ3nx6S3Xbaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AM8PR04MB7764.eurprd04.prod.outlook.com (2603:10a6:20b:244::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Wed, 15 Jan
 2025 13:29:33 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%5]) with mapi id 15.20.8335.017; Wed, 15 Jan 2025
 13:29:33 +0000
From: Alice Guo <alice.guo@oss.nxp.com>
Date: Wed, 15 Jan 2025 21:28:53 +0800
Subject: [PATCH v4 06/20] scmi_protocols: add SCMI Performance domain
 management protocol message IDs
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250115-imx95-v1-6-93b28a514dea@oss.nxp.com>
References: <20250115-imx95-v1-0-93b28a514dea@oss.nxp.com>
In-Reply-To: <20250115-imx95-v1-0-93b28a514dea@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, marex@denx.de
Cc: u-boot@lists.denx.de, tharvey@gateworks.com, 
 Alice Guo <alice.guo@nxp.com>, Peng Fan <peng.fan@nxp.com>, 
 Ye Li <ye.li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736947742; l=1209;
 i=alice.guo@oss.nxp.com; s=20250115; h=from:subject:message-id;
 bh=BJ/qxA9lxg2nGm+vMp5VJshGwywLmhm+kcwTDcL9kMY=;
 b=lSmXb3qlO3aKoOAWtHTnhkBxqUDXq//4nAqsfyx0zwBMVxXxnBXB21BopBJaDZ10KpkrIrGg5
 NdwxVrLCM57B0sIKjtklAccnJyEBTpmVeqWb7KGCbSSRi0WqiMupFh1
X-Developer-Key: i=alice.guo@oss.nxp.com; a=ed25519;
 pk=MQFotjdbgvdbpnpHmN/PUzfJXX0wchusR4L7yfs2VZQ=
X-ClientProxiedBy: SG3P274CA0022.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::34)
 To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AM8PR04MB7764:EE_
X-MS-Office365-Filtering-Correlation-Id: b5c75c4e-fb38-4e0a-07da-08dd3568a5a5
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|7416014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Sjc4bkh2MjZmY1k0TWQyY0dOMkgxdGVxUEtiTnFpOXdydlFmd2F0QzNWTVBj?=
 =?utf-8?B?S2dwUGEyK2VQdFgxeWkxT3NQTjZ2eGZSTDJxQnYzNXFNYzRKNEs5MUVWUFRy?=
 =?utf-8?B?Y2N2Z2kvT1ZtK1Z3QkdIWjBKYUJtNGlHcGt3Tk9GZ0l4cE1EZjkrOWY1T3pQ?=
 =?utf-8?B?ZjN5Qi84OXZuWktQUm1Bc1M0blZpdzlDR3J0SVUvWWd5NEJTRk1ac0lLUGFO?=
 =?utf-8?B?ZERPVUt6dDF3ZVlXbmN2cWV6Q3prcGRSaGJUdklHVVFHc1B3L3ZGcVVhTUJB?=
 =?utf-8?B?NWVlNmRBUVk4aFJUbmdQemVGSUVKMlBKcXVaeGl6Yk5vWCtTdjNhVUk0QUZu?=
 =?utf-8?B?WW1hck9zdHdzYXo3RktSNnp6bXVDWityb0twVXZFKyt1MVd2UllLbFRJa1Ny?=
 =?utf-8?B?YU5NRFdHVlQ0dmFnREM1VEhBRGphclZWZEFzbndOckliQmM2NmdDbGFDdzZm?=
 =?utf-8?B?UVBTNTk5T2hHY3NjNTdyMWJwZTlIUUJSTWpzdmU3S043ZW83ZVJncUlMNlVH?=
 =?utf-8?B?aGJIOGdDTHFPSldHSFBiMEsrdCtiR01FbVA4N2lISzUxTjdxRy9UOWpsSmpx?=
 =?utf-8?B?d05mZ3VJa3U2ZklEaXhrb0FzOWdIbW10SEx0M0EzUHlCcE9XMGNtVzhhL0Qv?=
 =?utf-8?B?b2tLU0loNUlEZWNtQk5SOHdXU2wrVEptNmg0elUxdWVpNkU2Qlpjam44R0xK?=
 =?utf-8?B?a0R2U0l0K3IvZDNBMXJxYi9XbmNnYldSL2ZuQlBMRndYWmdTSlIwL3FGMzFJ?=
 =?utf-8?B?MFBUNzByczlmMmJyTWxZZXlXNDFBa0ZmTnlUS3NtYVlsa2tyYnp2RHlXSnF3?=
 =?utf-8?B?WElZWCtpMWpqUnNCMDd5K3BUb1N4L05ZTVVMSG9ocGhua1dxUXZOSEZuMlhj?=
 =?utf-8?B?SlNoR1ZWYlJNRkdlVVNpamZ4RVBIVmtHNklmMXd4QWF1Q1FiZGhpVmZPV2Ir?=
 =?utf-8?B?OHZxTmZuVUZGcDZZbm5Wb3RHOG1Ga1UyQzhuN1Q5bGprYUdaWER2QW5DY3Nt?=
 =?utf-8?B?UTdhRmpTV3VmTndIYjUyRGxwNVJuc1ZKVVp3M3RGWWM0S1V0dEpLU2U5VUpF?=
 =?utf-8?B?ZFByVHhCOHpyVm5Cd0dDaC9VLzJCMGJ2ajRFWVcxUVQ2Vk1JQzMyOTRqQnhX?=
 =?utf-8?B?WURrcXhIZkZsNkdZYUFBM3ZGYVhyckFDL1FxVUo4MzIrRWtjV0lIeWNFSUVh?=
 =?utf-8?B?WWxIOWRuZE03Rmp0VEV3NEZMdXdPWEgzWVJyaGtkR3UybmlmeFdUcGl5UnJr?=
 =?utf-8?B?UlZRUTJuM21VYjZkQ2Y1eTBNMFVFWlJ1MGhWNURIdGN0YW44bzdBRnFmSDY4?=
 =?utf-8?B?ajUxWk1MWVVlRThhM2t6THVOMlF4MTk4RUZscHh0OHdDL0J3eUlKSGU4cW5n?=
 =?utf-8?B?dGRFNS9pUE5YNThJOHNBb0x0ZmxOcERPNUFxRVl1T0lyZCtJci9lUzhTbDBm?=
 =?utf-8?B?eXZFZUh1aVEyQVd4WEQ4K0pEbjlGMkZacXI2L3dyR2xScktuWGkyOUdyZm5T?=
 =?utf-8?B?MlJkaTlHR2JuSzJra3dualZRMFNCY0l5SmIrdHVLelB2QXZMMjEvd0hUcC9t?=
 =?utf-8?B?RUprV1F0bENuQ0dJL3k5ZHdhTktlZkE3WTBXbStrcFpxKzJWZ2xvWGprNzZQ?=
 =?utf-8?B?YURvai9WZ1k3a0x0aGRyQ0YrTDVodEd3V2l5MjNVUWw3T3BhOCtlQmM1RjZr?=
 =?utf-8?B?ME9XZVI2Tk9mdTR5dmZoYitsM1pDWGhXY3poM1JwWnNpV1I0Znl6T1lMMWlx?=
 =?utf-8?B?aks0SzhuZzhvcSsyMTF3TDBFZmVsdVlSbVg2TFpPSVVhdHMrSlBqS0tJTXN5?=
 =?utf-8?B?MXRQUCtLWUlPTHlJK08xRjJnZ204UFBSbUQ2YVJjM2V5bGhsdHkvWlRFYUxl?=
 =?utf-8?B?a3c5SFhES1JiZEx6WVY3RlNyTm0xdWU0aGp0amhsMFI1MVhKMHpZTGpya2JK?=
 =?utf-8?Q?pYqdH++JA0u0pa+Tj2QYJh/aPkfgR/a9?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(376014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2dmcUVOS01BVldObllSVkdOMFZFSDBxYTFlV2JZQkc2VDl5VzhBWVQyazgw?=
 =?utf-8?B?dEg3WURPR3pUdFNpOGQzU1pJOExTenQ4T3Vkc25uWTNlVWVLYkZKdGswZDVO?=
 =?utf-8?B?Q2dPMHJ2R0w2dXUreGVHVVZTbUtMc2Z3b25FSzlaaHdBb21sUkw5RjRLNXVG?=
 =?utf-8?B?eHlFOUlIRWpsbVdBUGg5LzV6QjF3NFp5RGFoeDF1SE5UYTlNa0VPb1VxY0lX?=
 =?utf-8?B?SzJXb2dyanMvR3plRG1TUDdmeDByVEYzNlJWNFZmWGZMeWJwQThYUWZQd1l0?=
 =?utf-8?B?Q1FJV295N1gzQ1IvaUxncXJYaUJweHhpbmdWUnBPM3BJY1ArSm13dUpGYkVL?=
 =?utf-8?B?ZUZQdEFRUnpBbjE5dldPb2kxeFZQK1V2VmRRVEd5QmsyWG1Ra3BLeXF4NHZP?=
 =?utf-8?B?c1J3NHcrOEEydURtZlA3elVqQzdNMlZ1VnlmZXJReit4T0ttQmJhMU9pRzZ0?=
 =?utf-8?B?c004ZTlRNlJUYTBERGJMbGJJUXkxa0xwTVBZTzFySEJqTkxMcStqTE9iemVF?=
 =?utf-8?B?TUM4M3dHdlFJZmdWSTRHd1dJeDR6R0RGUmFSM0tsY1FKemFzZlYzcnVpQTJ2?=
 =?utf-8?B?TjRlSC9zMnNiUTlwaHowNXg5N0ZPZHFxMTBESTNRcm53dnU0bmdXa1p4VVRW?=
 =?utf-8?B?dXd6MG5iQ2w1Rm1jSC94citYRFgxTlZRSG9zaFRYRytDNVpsWkp5S0JqRUVH?=
 =?utf-8?B?aDhpd0M3QXV1TFhNSC9oa0hERVhwWXRoYzhmVktCaVZiVzZWL3E4OU1FWG9i?=
 =?utf-8?B?eDBmRURSTndvVzBVbUFVWnJ5RG16MW1BNVJaT2wzRXJrRktnek81am5PUFU4?=
 =?utf-8?B?OThRbGdaNlNXUTd1bGg5SkNkT1lKM2N1eE0vU0hodENDRFZjY3lwWHNkckk0?=
 =?utf-8?B?YkF5L05LeEtyWUp3OFhOYUplNi9HZHhXNUhYMzNoZ3RYam1HNWpNOVNRdjdv?=
 =?utf-8?B?MkZKSXZZdHhVQkxsS2pZWHMvUmdHcEV0ZlU3aFpGbGJiUkJreFV4ck5JN2JI?=
 =?utf-8?B?b1haVUExSEsyN3hpSWFGV01yWURmaEpaUTNJTHVCc2hEWHJzWGNXbksrYXIz?=
 =?utf-8?B?L3pydzBUR2J6UWRZekt3L1R4d2dHVHBPQTFLeXRmVTl1WHJ4aXdoblpQMUpS?=
 =?utf-8?B?WllRd0hpMDYyU1IzOU9TNWdLZy9EVXBjZDRpM0hPbUF6ZTRnKzlXamQ2bUhw?=
 =?utf-8?B?alNVcENCSXpVaVNEU1Q1TzN4UnlYeGpIczBKZVIxWGZ5dVFjUGlHdnJ0K29E?=
 =?utf-8?B?dGRKcUpkSWdNQml6K3dSbDkyV1gwWmVVT0trV2VycG5pQnk4cldMUGZLL0cr?=
 =?utf-8?B?R2JDZUQrY3JSVHMxQTFqbnBuc3M2VFI3b1pVbGZGWCt4Q3cwV2o4aUVFWk5i?=
 =?utf-8?B?RE5LKzFGL1RQUm1TMEdocFNYdTlrdFUwK0dZS3JuZ0pYVFNTYloxdGV6MU1V?=
 =?utf-8?B?Uy9ZbUZKUEJmVjJmckd6RFpRRXZKUitPajFnYkpEQXA4QVNReHI1b2lScTZz?=
 =?utf-8?B?UHljb3dud204eklLU2VVeHcrY2VjaGZpRHViZU85NmFmWFNLS2FZeFRMdk1N?=
 =?utf-8?B?K28wNk9oMTN3NnNLMzZEcy9rWi9RcVRRdlBkOHNjb3VicjhYK1NkTjQ0TU14?=
 =?utf-8?B?VUFsZ1hmWGxYemFYTU85YlZCOUMxSG04RjlJMFpBdkRycmhuT1NhdHdlcnBh?=
 =?utf-8?B?UUs1YlllR0R5bmUwTzJ0UUk3OXoySmxrWGZUMHVDR2t2SmJaQmVLZFBMSDB3?=
 =?utf-8?B?TStvT2pVeVdTSUVKRURZQjNuSDBEYUV5TFRTQS90M0puV1pNTU1tY1hnVU5M?=
 =?utf-8?B?V2NrOUdIRXVoaHdrMTVZRmpjL2ZSWis4ZTl2OGVVcyt3YlVaSHRSRDg0NGE1?=
 =?utf-8?B?cGxyYWVJeDd1ZGtJdFdZK3FFVlZRemtaTndFendrR3J3bFF5dzdxRVVrQk8z?=
 =?utf-8?B?Sm1RTUVia3kva21uc1RSN0hZWExOOGVHY3NuRHFxamk2TmtsVjlVdHh2SWNh?=
 =?utf-8?B?Wm5UVUxVVzVHbExWdGFKbis3NTlVcTRXdzRxSWtBdnVjN2N2UmZDZlJDUVI0?=
 =?utf-8?B?SkNwSWRsd2tDZkFCY095dGVEMjE3dkpMN3pEYnJ2cERBT01TUVZVUlozbEY4?=
 =?utf-8?Q?CPSxGh03/MUlF+8F/ubYJ/hFG?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5c75c4e-fb38-4e0a-07da-08dd3568a5a5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 13:29:32.9768 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wggBankBixMEQnvDmAoHO6fg5uHHrnrTBDC4Wg2H9L8ZP/uDSynvNkmGy6soSM/veS+n15Hg48NBeRartOjxXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7764
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

SCMI Performance domain management protocol is intended for performance
management of groups of devices or APs that run in the same performance
domain. The functionality provided by the callee-side can be used by
passing the corresponding message_id.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Ye Li <ye.li@nxp.com>
---
 include/scmi_protocols.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/scmi_protocols.h b/include/scmi_protocols.h
index 6cda1f00df1f6baf6db65a28b4cab114f8540a4b..08c86a642844570424dddbfcf9670d1e6757d8d1 100644
--- a/include/scmi_protocols.h
+++ b/include/scmi_protocols.h
@@ -1044,4 +1044,22 @@ struct scmi_pinctrl_config_set_out {
 	s32 status;
 };
 
+/* SCMI Perf Protocol */
+enum scmi_perf_message_id {
+	SCMI_PERF_DOMAIN_ATTRIBUTES = 0x3,
+	SCMI_PERF_DESCRIBE_LEVELS = 0x4,
+	SCMI_PERF_LIMITS_SET = 0x5,
+	SCMI_PERF_LIMITS_GET = 0x6,
+	SCMI_PERF_LEVEL_SET = 0x7,
+	SCMI_PERF_LEVEL_GET = 0x8
+};
+
+struct scmi_perf_in {
+	u32 domain_id;
+	u32 perf_level;
+};
+
+struct scmi_perf_out {
+	s32 status;
+};
 #endif /* _SCMI_PROTOCOLS_H */

-- 
2.34.1

