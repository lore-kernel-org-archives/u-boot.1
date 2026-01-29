Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B02ED358EF
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 09:39:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9520E83B64;
	Thu, 29 Jan 2026 10:39:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Tpi9vwJW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D94A80086; Thu, 29 Jan 2026 10:39:38 +0100 (CET)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7AC0E83B64
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 10:39:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YdWeouhBusF39Kf9SJOSMoAqE4oxcNLE0YCKZq/Ly67X0O1RJvE+lX8skFxsAdtFJOdJha9wWzLCrVflC9lQlf2DsS9ZzN/MvOwL1FmrSjzOYivP8ngZlLoaK31Lj57pj5EH4JX+LEulmjH6iT8wY6TwVRCG1xxeNrjwxE4WPTcVZEygkoxXn+iU2X4NeMQaKRxDv3DlKzHkCPGm3qJJsbqiGk8seVjZRcivOT/iKBDWwRvtoeFUjhW2PUvG6k+ZaFYcf1g/hPvbgcaDZtPAWJz28t+BrqNaRcYNieDphgamDble6SGbCUD9mV9ex4vw9ZvmHJnztEqYrzX09Y1G5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2DCxfyq28tVQjIWV0sGl6eSXVpvTPW8067JcTx8CdzA=;
 b=U9xouDL9oLOwRAJt2nsQk6W/wi0vm2n1Eut86x9ekDpplqpnbKsIY0GZKh4pid1kLUybhovIHTXv26/Kf96tcmLkEvl9ix0DBvQJ4b991l4cB9u18n1T14MjajOBBLfP04+pbNWpoMqnnQjU/fhaPjYUhl//+HaaeD9dP1ydPAVZCUPQ/wtlJhDTCORO7U25Pz3xKBhkcyBGwmrZXJDsIjY1Fko9zsdVnbfrVjDD1oaBXZbV7mDHa3uibIa6j0rCPKBCRWgrtWxZ5WRRYnZO9SCXNAAy9tpOAWu7Gn3fz1YQh5oTsIWn8UVGuinmRmXdD0SVMRi78XGXAbOjjaq2uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2DCxfyq28tVQjIWV0sGl6eSXVpvTPW8067JcTx8CdzA=;
 b=Tpi9vwJW3MkchTimX8MI+Ys7vRkqN30a9Mtv/ycZJLOh55HZu3jPQW1KJGusm4m7OlbPqtNA5h8FhHfj1fTWUqj9RCTFAQ8pLPjAIE/3LTqn0qd1q75Xty5i1h7d7ok/f/GiZbM16/5f9Nnt/NRK09jW3Jgt9aYpuliCnCUvwLAD103DO6kkxGs2vNlUn3daa5JMSEcqn9sVf0x7Vv646EOJIDd8uB64y3EisAnDC9yyrJoGha+z1YzJ4q8hTgqxr7mlFhu7v+EfWqNDG4+k0d3WqJ719nyuJ5vqQIXSscqHRu9Zfv+lqqyfTqW6pGxGtS2xmeVlxepumG58UZldfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GVXPR04MB10384.eurprd04.prod.outlook.com (2603:10a6:150:1dc::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.10; Thu, 29 Jan
 2026 09:39:33 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%5]) with mapi id 15.20.9564.006; Thu, 29 Jan 2026
 09:39:33 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 29 Jan 2026 18:54:05 +0800
Subject: [PATCH v2 03/12] imx8mp_evk: spl: Drop DECLARE_GLOBAL_DATA_PTR
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260129-imx-clean-v2-v2-3-1245ad2c3a01@nxp.com>
References: <20260129-imx-clean-v2-v2-0-1245ad2c3a01@nxp.com>
In-Reply-To: <20260129-imx-clean-v2-v2-0-1245ad2c3a01@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>
Cc: Alice Guo <alice.guo@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: SG2P153CA0023.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::10)
 To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|GVXPR04MB10384:EE_
X-MS-Office365-Filtering-Correlation-Id: dd816cc0-c9e8-4047-c152-08de5f1a4f00
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R2Zpb1hWRDYyUWxrcnMrWVFCMDhKa2FMbjZ6RzhXWnA1RG14WC82dFZSZHhj?=
 =?utf-8?B?aHg3M0ZKY0dRUDdEY1F5dnZhcmV6cmVjSjdVekU1aTZCaVl5bGVTdUx1R0tV?=
 =?utf-8?B?MUVTUi9KUTBpNzZYWlQyazNmdEI4N0Z1Qk5zT1RVeUw3NmhGdlNjUHNJVlA4?=
 =?utf-8?B?TUlrbFA0M1duTHFKK1RKWUJHZmNiRXMvNVVzODhSOGNWTDlKWTZRN1Zjdlls?=
 =?utf-8?B?dElvcHVMenp2ckJsZWVRZzNCdmNvcW9BM2tTZTRoYWJaVVhJWUdwZDMrckxt?=
 =?utf-8?B?VmJ5MEpCYUVuSXo4WWNYSGZCMjk4dU50dHNmZmlMRkxFNkl0L0ViMmlJQkRo?=
 =?utf-8?B?d3pNWEVCQ0h2Uk9QUjUydEd2aEFWWGJHY21uUDA2SXhoSW1PZEwzdlFhNjdr?=
 =?utf-8?B?cURzVUpGdlFPWUdhQWgrS0oyUnNpSjVkT1BvVC83MXg4TUNqQmY1YUE4OEc4?=
 =?utf-8?B?bDA0Z0ZNcFJvSFh6RzVwU1pKK2hwYnBuMXlxQTNNWnJwWW5vOFRLeER3R3RR?=
 =?utf-8?B?MjVvRnJoZ0VLMTRTZnNSb1k4ZFNXbGkzVEsvWk5Bb1kwRFdwUDV6QTZpMFdo?=
 =?utf-8?B?ZnB0U08vdFBmbEpVem9oOVhMQVphTjBiR3BRdzY2bmYrOGd4Y01Lb1E0MDRJ?=
 =?utf-8?B?Q1dQNmduRG9RK20vTzZlSkhscWk3Q2hQUTlpVEJBeTZ5TDhTQ3VXdGJEb1Z0?=
 =?utf-8?B?UWtzQno0YlhNUG1iTjJKcmZRUXV3QUYrZWZIbHhzN1d5VWhKWHZMOG11emhi?=
 =?utf-8?B?TWJER2ZrNVAwV1pGWVJjNUZDU1l5OXg5M3ZLN253S0UwcURiNlNHR2JyUGpP?=
 =?utf-8?B?ZkROUHp0TUNzS2F5bFBNcWdnOEh1WTJJcjVvdFR4aW13VFh0YTgvYjdyeHFs?=
 =?utf-8?B?OWkxQWZFeVBVQUxWSWJIVXBNOE54SVlIdkFZRm5HV215RWpwMWUxclBqL1kr?=
 =?utf-8?B?ci9sekRJK2V0OWNKRUdjSVY0NmkzUmJVZHVqaFQ0Z3htLys0U1g3RHpDRDJS?=
 =?utf-8?B?bFFHcWp5cGlML29tWGVGbXRVaFdiamhQVE5DNU53bjFWVnEyQzBjcVJBK2Fq?=
 =?utf-8?B?S0ltQzNraDdaS0dzWmduQU12OGZoUUxYNS82Qi8xYXlPM0MvVCt3US9oMWRu?=
 =?utf-8?B?aHFXWTYybzdLbU4zQjhSSHFOZ2xtQWlpZDg3NVRnbmczWGFvOEljRkFTL3ov?=
 =?utf-8?B?QmUrMkpYVGZsWEJiL3lXM2VOa3ZpN25hWnpaZHNVSHVMQWxMS0pZODA2YVVT?=
 =?utf-8?B?aEtmRWprZU1jd0JENkU4cXFteFdJS2RPSDYzdXlieGNrR2FMUEk2YW5uZ3hx?=
 =?utf-8?B?R21NaTBKZUY0VkVlY1UrWUE5aGZmZkFpQ0FTcjQ2dUtNck1yYkhjS09XV1FF?=
 =?utf-8?B?cHZTN3ljZ05xb1NCbjBUMFZ6Tjg2RVJ3RTlTT2xlbytUQklUMGk1cUN4OFpm?=
 =?utf-8?B?MXE1Z2dnUE1adEkrdjN4VmovRzdiR2VoNW9LakpOOTIreFBHdjh6TVJzN2Z4?=
 =?utf-8?B?TGR4TUp4SnIxTUJOVm5FR2UzTlZFaktoek9HUEw0ZGk3WTYrVkUwTmVPd1hX?=
 =?utf-8?B?SzduQlFVWVRZUlZ1OHNIQ3NVTGNFZ3lhSzFtakFUV1NLb04rcGxhQmg3SnBJ?=
 =?utf-8?B?Q0I1ZHY4akVZam1iSGJmN0paV0FFbUkwMGJ4WnlMdVdBLy84L3RZck82TGpR?=
 =?utf-8?B?NFZ3dXlxVXJ1a09rYkc3M1hZRW9PcGFrQllyWGJjdE1idExQcldKMkIxcjEw?=
 =?utf-8?B?dE1ndWEwWjc2b0xVRVdjdzIxenk3ZzhSL2QwZU5xZTE4QnR4ZmNDQjFqVTl4?=
 =?utf-8?B?U24zYmtiNkEya2tlWElieUxNV0FmT05OaDBURnFtbXRMQXMvTlNjcVpsZVJM?=
 =?utf-8?B?eHZSYzJEcjVMUmZPcEpQdVZKbk15R3N0TUM2TlZGYjM5VWd4VVV4VFdhRkNy?=
 =?utf-8?B?Sy9UbFI2M1VpQ016akViUEZXL1pmYmU3OHVtRlhqRy92amVMNmdpQ2g0WWZm?=
 =?utf-8?B?NkxtTW9XN2xhMnljUm94eTJLMzJBWCtUaVprT2J6dGJPMWxEeStCY0VubzNP?=
 =?utf-8?B?ZnNhMjVha25mMm0rSlpBaCsxeWdmQ1FXNXMyQ1U1TzZsMDdkbkNhS0tlV0Fn?=
 =?utf-8?B?RTFOUWxteExzTUlkSmtNQzBZMFZ2cFJ5ZFM5Q1U2N1JIOWRFN3h5RUpOalJQ?=
 =?utf-8?Q?GSFvwHPNI02LRb1pFwvZjJA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bXJIQlg3SFh6c0UxNlVVNWhEcnF6SHVPWHFDcmx0SkFpcVdZMWo5Q24yNUpF?=
 =?utf-8?B?Sm1oQW5NTEF2OWVNS3FaejVSWUZCeWNIZkRxUG1HRmxoMmNTYklRQVJQWklt?=
 =?utf-8?B?VjhVN3A4Q3NsVUUzOWRnYjdqNllIWk9DZXN6bHlocnVxZjhWbGZRNlJzdFBx?=
 =?utf-8?B?NU9yNVpyR0w3bHQrdDRPemt6cWRNUWFkaDR1enRVVkMya0Rpeks5QWJtMTB3?=
 =?utf-8?B?S0dydlg5TlFvZ05GSDlvMHFmSkpvZjIrQTJYZVpqWkUrT0dMd3c5cHpxQzhV?=
 =?utf-8?B?b04yQTJlbi9rQmY3QkhCczRZaDNkanBTUzBtS2h4VjBWUTNJdlVWTWFBRVJk?=
 =?utf-8?B?OFVsQWNZUUxtT1JVMmZJMVVNZUVxSGpGa3Y0NTM4UkwwaDNrR1hZenp2ZWt5?=
 =?utf-8?B?T3NpdGhyYm1MdTBnallSZWovV2ZYNjBQUEtNNFB4QjdCZ2t2eHl1Y09wSVNE?=
 =?utf-8?B?WVdyTmx0Y3FublZQNC94S2JhWFAzTCsrUDBCUEF6Qkc1U3UxSWNoREE0bVN5?=
 =?utf-8?B?TnMvcDY2UVVsTXlJdzQ5end0RTliUFl2b3oxVWd6RTVzUWh2SUplVGNMa0VX?=
 =?utf-8?B?czkyK2M0UFQ3SVV4RmxQTUhmRzVXLzMyZmJQakJZaGp0Y0NVMnhGQUozK0xK?=
 =?utf-8?B?M25QLzdZUGNvZzFZL3NZakFXOGxsOEIvUnBoRUlzd2U1Q2JWTFFwZGxUVzNa?=
 =?utf-8?B?S3Z2QzR3ZXZEeWNHQnN0UHlTZUJQOTh1UFB2MndPNXU1bUdBN2RLVktFNmQv?=
 =?utf-8?B?UzFpYk1mNHhscmYrb3dUcnB2N0tSYXZsdjNKTEJwQTdhSGxLV2JDbThkd2xK?=
 =?utf-8?B?Q3BHTWtvSkxlZTNZQy9lK2NScVIvOURmRWdNcEVKV1I0Y1ZqM2JtQU5ORVdQ?=
 =?utf-8?B?dEhSbXlTYURDS0ZIa0FwcHNFd2NjdHVJY29RMEJBQ3VrcUphV2o1dVV5NHB5?=
 =?utf-8?B?ZTJiZGNTbTRsRTVhdGZiMkhpNXdqQ09DNWM3emtmSTFKMDRXd3ltU2w0RkNV?=
 =?utf-8?B?WjFnZldDNk83a3ZuMzBXeE1oSG9GRXloNGFaTFg1TjFlTzVLWVlkVzd3T3RM?=
 =?utf-8?B?S3gzVXdBaFMwL293U2NFQW96aDd2UGJ2YjlFRElBZVBhNGFyVXV1c09xVEt0?=
 =?utf-8?B?bXR1eWxodnNZbkpFWmkrc0hTWnRaanc1ZHhNTEFtb3BqZkhBT0ZxdHpyQXpS?=
 =?utf-8?B?aWQ5YWxRcVEzTUhiMGtDc0VaTWFZbUIxMWxWZDFoZjFzVGFXdVNlaENWTWFp?=
 =?utf-8?B?YitwbE5NUU8xdXpHTTZXeUR4QjlzaHQ5RTBIa05QZm5sQ2hrSktKWThLTXZI?=
 =?utf-8?B?Nm9aMU1OVkRSci9oQjRGMDduRnFEYnlnSW16THB1U2kzT2F1RkdZdDVmL3F3?=
 =?utf-8?B?TW1zTER5UWJvWXBjZk9peVc4TEtvTThMakZIRE5lak1pb3ZLb1pDOUxydG5N?=
 =?utf-8?B?c1JpTlZBencvMHhaREtIWGd2K3MvUDdRcjNPZk8yZ0M3eXpmSy9rZEp3N0ZZ?=
 =?utf-8?B?VWtmSFBzM0UzbXRkRjR3Z2txMjQ5cVh6V0FtcFVhamtkL2JXbm1WTTdXcFFr?=
 =?utf-8?B?YUF5eS9TSzhUdGJWaFliWk5WSjk3VE5HUnhoNi9nRUdCdDNUemFSSExXbTdz?=
 =?utf-8?B?N2E3QmxVVHZrNkJJU2dZbDhFWERHN0FvMXhmNHQ2ZDJOU244c24zMmc5d3pJ?=
 =?utf-8?B?WVRmbmkvanVsR3I0NUcrZVYxMW9qMytSOVY1NG5EWVI3eVgvRUd6S2cxbmNZ?=
 =?utf-8?B?bU9oaHYwRmtUQzFtSDhPZU05SEYxOVJuMW84UnFKbEZlVndLTVZNRTlmdkJm?=
 =?utf-8?B?UjNuMmp3RHRjMWYwN3F2UG9Wd3R1YkR2VThSTFNSd1d6ZzVQWlRIbVZNd0Rh?=
 =?utf-8?B?SkxlRDVXRnBvQzIxZEQ5VnRaR29VQVZJQWxjZU5VV29oQTJTQVVrWldTMzVF?=
 =?utf-8?B?c2FpUnBIMG91cUZuS3JIZ0xiSGo0TnFlY0xpWU14aHFUVW5ERG1IT1R4a1ps?=
 =?utf-8?B?Uy9NMzVQOHg5UFhUUTZsOWpoaFd4V2lMNnRsOUU4V3d2SXFGQ1VPODI5czRE?=
 =?utf-8?B?YlZPamxQV0ViakE0dnlLSVNpZGtDR2s1OVhjVDVnNjhQZHZ3Myt6bHBHK1RF?=
 =?utf-8?B?WWNvN2puYkRGRkhIcFVCWjM0anV5RXFvektVc1Q0T2VNR1RlZktRbFdkMkNq?=
 =?utf-8?B?bytIaFE5a3FNTElVOExDcVFINHFSa0RydnVKek43Sm43TTV1LzVNaHptamsr?=
 =?utf-8?B?blBDajlaL1dqS1k1bE1odmpLU3VYM2ZsZ0ZpQTlwUnVzMUk0TDN4UGJhajM2?=
 =?utf-8?B?azE4L0pndm83TEJuTFRQQmZPcVgvTmJiQ0dLZ0NudERGclJtYjFudz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd816cc0-c9e8-4047-c152-08de5f1a4f00
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 09:39:33.4037 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t2OGMJtYuYmqzLZ4hXOZa+StwkihAOK0FxW185MSyfk33gFgGa33vcFue14fCCVRpKHCfq58ZPrSYrpX7TNTZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10384
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

There is no user of "gd", so drop DECLARE_GLOBAL_DATA_PTR.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 board/nxp/imx8mp_evk/spl.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/board/nxp/imx8mp_evk/spl.c b/board/nxp/imx8mp_evk/spl.c
index 552bf689228..4e6a5830b07 100644
--- a/board/nxp/imx8mp_evk/spl.c
+++ b/board/nxp/imx8mp_evk/spl.c
@@ -8,7 +8,6 @@
 #include <init.h>
 #include <log.h>
 #include <spl.h>
-#include <asm/global_data.h>
 #include <asm/arch/clock.h>
 #include <asm/arch/sys_proto.h>
 #include <asm/mach-imx/boot_mode.h>
@@ -18,8 +17,6 @@
 #include <dm/uclass.h>
 #include <dm/device.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 int spl_board_boot_device(enum boot_device boot_dev_spl)
 {
 	return BOOT_DEVICE_BOOTROM;

-- 
2.51.0

