Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6871BC3ABB2
	for <u-boot@archiver.kernel.org>; Tue, 17 Sep 2024 02:33:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D00A88F32;
	Tue, 17 Sep 2024 04:31:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="U0FhU2Ob";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E040488EAD; Tue, 17 Sep 2024 04:31:22 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170120003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1664988E9F
 for <u-boot@lists.denx.de>; Tue, 17 Sep 2024 04:31:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VNYztpv5ajMJ7Roj115R8aTBC8lDk+5/IrjvsaLPxDZPTzh87cmL8Wok8WQMXZAYcZE/DKuGiaEMPrbtPmsJVE05HoKuBbhrpxiOjNsYT/uLusiQ++ThqZVIdsv/sYyW2tUjXq4XeXOxI+dopvfMhECvt7FObjQqn86a3Ef/Ve538zQx1UkLdpg0jzE3WidmDeczb27jVVYrbmLy4+/qVL3xdllo3jdU0ytb61IBr4HWB83l9Sj1sPj12gg4bqnRUKNsJXDW+VjJolXa/Mm5pvH3NJbvsZM5+8so7mm1YXrZe1XchIZcEKGZMqMJT4aCbsqUNANdygsSjf7jEuTdhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k12xFh5xt3MrKOQtPN3dyioJpnWSfiWM3lrFmEutnkI=;
 b=GxBy2wBsMMXt9gnwQHlRPHIDxPnx3s3F3mSnuTF3mBp4yRxdPN6hoDcs58a9ZN0VXWYP1F2/0kuc32AOZbICBz+aebLkqElWHwjwL9PBHlkl2SRKKkpBTNs413QdFQKPyVi6DUW/NTHN/U4b4CAobR0xUmjP5HPn2ByWc3VONkPm0v+sXseGvV03co/IGjwcIdDmC+o33PcO83otBgVp9XAHUhB8rW2zt/ne16B0YuVmVLVA+fReSC0XFFL00hId/p6LozM6I9DR+Es+hHGfDpBAGYglFSYl3xRkwa7e3mcuVt5NfsopR4bj7WBDq0DHh16kkMOJ54FL69MFkyXMiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k12xFh5xt3MrKOQtPN3dyioJpnWSfiWM3lrFmEutnkI=;
 b=U0FhU2Obhkhfw81to9imHeIWtCechXpwefpsdIwicG7twwMcnZ0hKukOTgTghUNn2z/pw5YZjZLFumgIaOyNFHCB7ADT0rkEPwMyw3meK43cTBwtYFkvA+Q5RjjVFlam0kG0LQuWtzRH3lFke3OVCrOfapbW/mZDXWuCx2vwe+sY6P27xP2JdxYCnuepLMLU+nPQtvb+4chU7cXIZDW3aEj2KqAUPIkLXfoxY0VIx2dSMwlumxMXu8IIg7qRigfn23C75RmMzQZXj54LZBh1ZwL49lhjrKJGUjllxsUNweyw5sL2BzhBiOFX4bxuEf1bzGpo/OX4bG+O8UPRY9pMAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GVXPR04MB10451.eurprd04.prod.outlook.com (2603:10a6:150:1ea::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Tue, 17 Sep
 2024 02:31:13 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7962.022; Tue, 17 Sep 2024
 02:31:13 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 17 Sep 2024 11:34:08 +0800
Subject: [PATCH 16/21] imx9: trdc: cleanup code
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240917-imx9-update-v1-16-4fe8effc937e@nxp.com>
References: <20240917-imx9-update-v1-0-4fe8effc937e@nxp.com>
In-Reply-To: <20240917-imx9-update-v1-0-4fe8effc937e@nxp.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.1
X-ClientProxiedBy: SI2PR01CA0009.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::18) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|GVXPR04MB10451:EE_
X-MS-Office365-Filtering-Correlation-Id: 11b4b9f4-5475-46ba-476a-08dcd6c0cc68
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?KzE3dVpUNTNqQjN5a1JBaW1FVC8wSVRYWTlNdHJwakZ1Y2VWOVJtMmkzRHps?=
 =?utf-8?B?MHF2MW5Wakd0dVpXZTFidm9MZlQ5TW1IWU9HV3JpU3RGL2pqU1piUEsvSkVW?=
 =?utf-8?B?SnlzK0pGbDBBNE1pWjZCNHJWVmViQTF1czIxZFZuT2RBVTBycHBvWFVQZEF6?=
 =?utf-8?B?djlvWTdYLzk1L3FjU1o3c3MvdWVwMWdzU0xFMnpLckh3enNvdHJLOXl0TzBT?=
 =?utf-8?B?NkN2NlF4a0VITWJrb1V0T2Y1S0V2V08zV3JNSGt6RTdsNXBXMTNQSXpaZ2Rj?=
 =?utf-8?B?TWthL2N5akRpZ0FXR1o4VFU1ekJsRzFYQURJL3RQYWRMTERscEs4ejJpUmp4?=
 =?utf-8?B?Z2c1MjY4eit0bFdHc2oxRGdVNDNtTFBZeThKZVI3ME1lbVJWZWp3SjhFVFU1?=
 =?utf-8?B?ajJqVDI3YzBEdjNwd2Z6cnhWWll4SUFoTkI1Yng3Z09CU0dnVWdkVXRVb2hC?=
 =?utf-8?B?UW9wY25rNHR5QVdDbkRFVVFhWktTQ2tnUncwNkJkZXUrUENsblhMb2ZhTVRw?=
 =?utf-8?B?THdyVFhNM1dXMnZhU2NZdzJVOUhEVmFyZ2sxNE5JOEVtQWJMcUN6Zk9uQ3Za?=
 =?utf-8?B?WjJmVmlrSkJBYjF2TmoxVkI1Z2k0bXV1eTA5ZEVzOS9SWVd0cUhUbndKOVl4?=
 =?utf-8?B?U0I4eFl1RERWUE1DdjM5bDhxOHFOcXVJSnlnd2p2WjNKNzVhWnNkTnMvbU1K?=
 =?utf-8?B?ZlNlekE1TEh3ZlV6aENXVGZ6ZTlXVkUzWUp2dDlpYUVJL25vVWxSYnprWUQ0?=
 =?utf-8?B?Q20xMXlBWFdHamRVTkpMTEgrSmZIcHhmTTFhQU81UWVqMy96SlhvM3h0VHNr?=
 =?utf-8?B?SkdZcENRRW0zVm5pK0RBU25heFFDWjJ4cEIwaFZ2S2NUZjNKb2lXYnhGNVA2?=
 =?utf-8?B?d3hwdUxaME4yUlZ2MkdjT0dWRlJGTEk1K2NPV0MrYlAxNVJicFNHYjZib3JJ?=
 =?utf-8?B?QmpCQVg4bm10NUIxa3FoNks2bG15ekk2YTlUcWRMWTExaDJYaUxYOEJ3YVBT?=
 =?utf-8?B?Yy9PQ0hVWWNpMjhIYzVteVFPeEY2M2hySDBHRDQzQUdkUkRDZ2ZHMmdtTHI2?=
 =?utf-8?B?LzdJbFFQSUU1YitBdWduU3E3aFZRRTU5Mkl5bU5QcmRWR0Y2VDZWNVVRQkIx?=
 =?utf-8?B?VFJadkVpRDdQZ3FLVU1Bc09lUGNOZnRoWXhIcU01OVZWYzdiR043TDBzaXdm?=
 =?utf-8?B?aTZ5ZU9Hckx5NEJFWXhSdWdhUXg0TFlXQzN3K05IUTZyNkxpNHhuNEY3Q1Ez?=
 =?utf-8?B?QjArVW51UStWcWo2M3ozK093aTliN0NTOTVYZUZ1Y1BlaTJaMUxPcGZvZzJH?=
 =?utf-8?B?am0xVGdnQVQ3WC96WVlONlloMGprLzJzRUp4UncrRlNCdHptWnQ0TDRFT0xn?=
 =?utf-8?B?NHlZNHBmN2k3RGZvUmRycmZWc2k3TE9OUnVXS0krd0JrZ3ZrZGZrWUkrcG1M?=
 =?utf-8?B?bHF0clFhcy9sUzRTRkdNT2Z3alBNWVVmNkRxWCtPdHlHT1p0OFFqVENnUFFo?=
 =?utf-8?B?ZEhCVVdUS3VBM050NUZSWU1lempTZVRiZzRpb2J6WXlkQ2lsazVCcmUvc1cz?=
 =?utf-8?B?WHJWUUh4UTJ5OHREVkc4V0pablY1ODlxc2Z1djUvUmR5d0poWnVFMm5ZMVVk?=
 =?utf-8?B?M2Y3VmJwS0pDamYrdURweWN0VDYwWEMzd3VkRXFycGhEb2V0WXRPamJxRDFt?=
 =?utf-8?B?SVM2UlhkaVJTRnEzTG01NXNvOWpsdEVWOThxQVpUdFZoaEw2ZGJId0FjVmkz?=
 =?utf-8?B?cENyWTY2U05VWFBZc29IV3VoYTg1ZWxib21ubW1zQUJnMG12ZjFmeThteFRM?=
 =?utf-8?B?YVJ2Z3p5T1B1MWdhNzF5UmtWcGwwMWpXVTNBMGR5SElwRnZPelFQSU9UQ2Vk?=
 =?utf-8?B?cEgwbDIwc2ZmdDJUbzFPWDJ6aGpZR3BRZTNvWXEvN3NCVUE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YzVNM2ZNb1h0RlZkK0JxYzlVUUk2Q2xwcU9GSGxzNG1IUG1mR3cvMGhIUkZz?=
 =?utf-8?B?c1ZDb1NSVUttM2hsaGx2eHYyN0ljc0lMYkRvOTNDc1lia0dyR3pkUlByd1h2?=
 =?utf-8?B?bm53QmlCL0s5L0Q1cXFSdFBXczdqWnVDbE95NFo0NTBML0NORWVoS3NWU0la?=
 =?utf-8?B?QUdYdHFPVEJYT3NSMmk0UjVaU25rUEh0VFZqemdDa1BwcXJoNkZPV1JpcTZO?=
 =?utf-8?B?cXJBbGsxaHUweTdseExWeC9pV2U3eVhzcWY3Z2pKS0k2Q3RGYnpQOWhSZ0hl?=
 =?utf-8?B?ak85MDJxUjJkNE50NExNRkVncFlWa1ZwK3pjMm0rLzRDOTg2L3kzNC9pR1J2?=
 =?utf-8?B?Si9PNXJPVEphRjI0cFdkT09BTFl0Qzk2YndOblBwaGcwSUtGaHMrWCtmZUJu?=
 =?utf-8?B?N0szeHYrTXhpcHNlWXVRRjB2S2lqeSszQTBEV3c1bzdITjlVM3JUMGpVK3Zz?=
 =?utf-8?B?YWpLaVdidlN5dFkyWmhDVVpvenp4T3g4TDVkQXo1UHAvYzZKbTN0WkdQTS8z?=
 =?utf-8?B?OWcyNVJJaVg1OFVTSVh5ZXA4UVVlWWRWSnIwNmpxaVZpVWYySVREdmNDMWlX?=
 =?utf-8?B?cU1VbWVGV05uWVY0WE1HTnVhR2lCL0dOUmtvVEVNYlZYeHNyTkJQNFFmS1Er?=
 =?utf-8?B?Q0cxaUxNU2RBejVKdHBRNkc1R0w3VFlSMDBscS9VOEM5WGJKNTFYamJXcjFt?=
 =?utf-8?B?ZFFYV0RRdytzS2pCdkFhM1pTanRNckVLWnNIeEhaYnJNTjNtVnpnb3dQOC9r?=
 =?utf-8?B?cTVnVUNZUjl4WXFOaFdMeU8wdUhBL1NhQ29reUlCaGd6Vit0ZkJvQkZ4WkFL?=
 =?utf-8?B?NXVmenJqcm8rZ3hJczF3OTZBWHdwQUp2eGJLYVlqaXBJNmFGYTJuNHBpREEz?=
 =?utf-8?B?S3FEa2syTm5yNnBla3dyZytRQ3QyV3o5UmlPTEt5dWlxcWtQUFRnZFhQTHhU?=
 =?utf-8?B?SHU5OENNcTJZZ2t1L1M2dHR3QkpEMHdXVWZ0Y1VldjE3VzkwMlNkUDVCUWth?=
 =?utf-8?B?RGdINE9pc2grT3VEbnlqMHFDK29TU3VTUmRDZi8wb21hclBUUmoxQXkvNnpS?=
 =?utf-8?B?MUpWM0QyZXdVQ2JFd0JxUktmSU5PR01oc0NtNFY2ZDc2MzN3dUxDUlllRzFx?=
 =?utf-8?B?VEgveDdhdXd5RTlZR28yT1FrZldUd3UzYTFwMnN1aS96NnM0blFPR2pEcjVq?=
 =?utf-8?B?VEptMXZqNHRnSDJCRjBHS2x5TUU1Uk5HSkNPTkNVV3I0Z2hNS1N3U2NvWmQ1?=
 =?utf-8?B?T0Y3L01WMEdhK0xHelVNM3BFZmRIM0xReG9yVTJ6QmtqNlJCTXQwUG9xT3o3?=
 =?utf-8?B?VUp4K2ZnN0k4dTZCTERDb29uL2pRTnNjUW92VjlXWGpKS2hmZTZuU2N4QzBj?=
 =?utf-8?B?VnlhUUJsd3c4YkcvYjZPM2JhY3RkOVptZzRuVXMrU0J0dHZXZ0pUWElGZ0N0?=
 =?utf-8?B?UEM4bS9KN1dMMmtkaXU2aTVkbWdaN0FFU0JEcTE4c2hQcTdTWlEvV3VZOHJr?=
 =?utf-8?B?cGtxVUczMk9rVENrUGZPTnNycTZBQkJPNzZDeitGOTJjdWtnWXBkQ2k0WHF2?=
 =?utf-8?B?dURIZGttN1I1cFE4eUE1cnUvZ0EyL2Fvc29hRzhsWnppVlVQT2lFanp2ekdw?=
 =?utf-8?B?RG9YWkhlZUVxbGNuengyUC9JMXdJVjdhOTVlYmhEd2swZlRXNDZicStCRnha?=
 =?utf-8?B?ZW9GcVZFek5KTjZKWFo5a3MyTjhXRGJURXlHZmpFdjlKak9oZC8vb2pwU2NB?=
 =?utf-8?B?NFBxbWswTkhEeXpJbitiS21TYm1KYXBkcEJmOVB2MFlFY1duMTRwWndmaWgv?=
 =?utf-8?B?VDB6cTRpcEh2SVE2akZwK1VqeWltaktPRXVWMlNaR0RNbS9aanJwM1NRU3ly?=
 =?utf-8?B?T1JwdW5RTEc4M0J6K2tWYTkvY1RVMTRPdkJNbHEvN1U3dllOS1hqVis1dCtC?=
 =?utf-8?B?dkxtbUs0c01sNVJOaTN3Nk82NWw2RTdMYTA0d0Z1NG1Zc1dUTEJYZkpSVW4r?=
 =?utf-8?B?Smo3RUJ1eDFlMTlWNC9DQVV5dDVLbXRsb0FpYWNYdUNrZ2NweFZXZGQ5YlZn?=
 =?utf-8?B?cVhGeUFab3pLWjJ3cHZMbU41cStZUjhKa01pSkpNYXRlR2ZGcTM0VldlRFlR?=
 =?utf-8?Q?Afblx2zh6Fc7AeGnXgbMQbU5M?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11b4b9f4-5475-46ba-476a-08dcd6c0cc68
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2024 02:31:13.1927 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2agIDSS6B//uQkIbR8L73HlyTTywQY9BqVBgj0lv2b0uYvkPVTxVzU70ej8+VKSEyPAkiLW0ZGjiI4o4eIB/1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10451
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

Replace magic number with meaningful macros.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/include/asm/arch-imx9/imx-regs.h |   5 +
 arch/arm/mach-imx/imx9/trdc.c             | 156 ++++++++++++++++++------------
 2 files changed, 101 insertions(+), 60 deletions(-)

diff --git a/arch/arm/include/asm/arch-imx9/imx-regs.h b/arch/arm/include/asm/arch-imx9/imx-regs.h
index fb6de533d12..44f6a95f23b 100644
--- a/arch/arm/include/asm/arch-imx9/imx-regs.h
+++ b/arch/arm/include/asm/arch-imx9/imx-regs.h
@@ -50,6 +50,11 @@
 #define BCTRL_GPR_ENET_QOS_INTF_SEL_RGMII        (0x1 << 1)
 #define BCTRL_GPR_ENET_QOS_CLK_GEN_EN            (0x1 << 0)
 
+#define TRDC_AON_BASE		(0x44270000UL)
+#define TRDC_WAKEUP_BASE	(0x42460000UL)
+#define TRDC_MEGA_BASE		(0x42810000UL)
+#define TRDC_NIC_BASE		(0x49010000UL)
+
 #define MARKETING_GRADING_MASK	GENMASK(5, 4)
 #define SPEED_GRADING_MASK	GENMASK(11, 6)
 
diff --git a/arch/arm/mach-imx/imx9/trdc.c b/arch/arm/mach-imx/imx9/trdc.c
index 8cdb28459a3..ae1a46d1331 100644
--- a/arch/arm/mach-imx/imx9/trdc.c
+++ b/arch/arm/mach-imx/imx9/trdc.c
@@ -4,12 +4,13 @@
  */
 
 #include <log.h>
+#include <div64.h>
+#include <hang.h>
 #include <linux/errno.h>
 #include <asm/io.h>
 #include <asm/types.h>
 #include <asm/arch/imx-regs.h>
 #include <asm/arch/sys_proto.h>
-#include <div64.h>
 #include <asm/mach-imx/ele_api.h>
 #include <asm/mach-imx/mu_hal.h>
 
@@ -19,6 +20,25 @@
 #define MBC_NUM(HWCFG) (((HWCFG) >> 16) & 0xF)
 #define MRC_NUM(HWCFG) (((HWCFG) >> 24) & 0x1F)
 
+enum {
+	/* Order following ELE API Spec, not change */
+	TRDC_A,
+	TRDC_W,
+	TRDC_M,
+	TRDC_N,
+};
+
+/* Just make it easier to know what the parameter is */
+#define MBC(X)			(X)
+#define MRC(X)			(X)
+#define GLOBAL_ID(X)		(X)
+#define MEM(X)			(X)
+#define DOM(X)			(X)
+/*
+ *0|SPR|SPW|SPX,0|SUR|SUW|SWX, 0|NPR|NPW|NPX, 0|NUR|NUW|NUX
+ */
+#define PERM(X)			(X)
+
 struct mbc_mem_dom {
 	u32 mem_glbcfg[4];
 	u32 nse_blk_index;
@@ -364,68 +384,84 @@ void trdc_early_init(void)
 {
 	int ret = 0, i;
 
-	ret |= release_rdc(0);
-	ret |= release_rdc(2);
-	ret |= release_rdc(1);
-	ret |= release_rdc(3);
+	ret |= release_rdc(TRDC_A);
+	ret |= release_rdc(TRDC_M);
+	ret |= release_rdc(TRDC_W);
+	ret |= release_rdc(TRDC_N);
 
-	if (!ret) {
-		/* Set OCRAM to RWX for secure, when OEM_CLOSE, the image is RX only */
-		trdc_mbc_set_control(0x49010000, 3, 0, 0x7700);
+	if (ret) {
+		hang();
+		return;
+	}
+
+	/* Set OCRAM to RWX for secure, when OEM_CLOSE, the image is RX only */
+	trdc_mbc_set_control(TRDC_NIC_BASE, MBC(3), GLOBAL_ID(0), PERM(0x7700));
 
-		for (i = 0; i < 40; i++)
-			trdc_mbc_blk_config(0x49010000, 3, 3, 0, i, true, 0);
+	for (i = 0; i < 40; i++) {
+		trdc_mbc_blk_config(TRDC_NIC_BASE, MBC(3), DOM(3), MEM(0), i,
+				    true, GLOBAL_ID(0));
 
-		for (i = 0; i < 40; i++)
-			trdc_mbc_blk_config(0x49010000, 3, 3, 1, i, true, 0);
+		trdc_mbc_blk_config(TRDC_NIC_BASE, MBC(3), DOM(3), MEM(1), i,
+				    true, GLOBAL_ID(0));
 
-		for (i = 0; i < 40; i++)
-			trdc_mbc_blk_config(0x49010000, 3, 0, 0, i, true, 0);
+		trdc_mbc_blk_config(TRDC_NIC_BASE, MBC(3), DOM(0), MEM(0), i,
+				    true, GLOBAL_ID(0));
 
-		for (i = 0; i < 40; i++)
-			trdc_mbc_blk_config(0x49010000, 3, 0, 1, i, true, 0);
+		trdc_mbc_blk_config(TRDC_NIC_BASE, MBC(3), DOM(0), MEM(1), i,
+				    true, GLOBAL_ID(0));
 	}
 }
 
 void trdc_init(void)
 {
 	/* TRDC mega */
-	if (trdc_mrc_enabled(0x49010000)) {
+	if (trdc_mrc_enabled(TRDC_NIC_BASE)) {
 		/* DDR */
-		trdc_mrc_set_control(0x49010000, 0, 0, 0x7777);
+		trdc_mrc_set_control(TRDC_NIC_BASE, MRC(0), GLOBAL_ID(0), PERM(0x7777));
 
 		/* ELE */
-		trdc_mrc_region_config(0x49010000, 0, 0, 0x80000000, 0xFFFFFFFF, false, 0);
+		trdc_mrc_region_config(TRDC_NIC_BASE, MRC(0), DOM(0), 0x80000000,
+				       0xFFFFFFFF, false, GLOBAL_ID(0));
 
 		/* MTR */
-		trdc_mrc_region_config(0x49010000, 0, 1, 0x80000000, 0xFFFFFFFF, false, 0);
+		trdc_mrc_region_config(TRDC_NIC_BASE, MRC(0), DOM(1), 0x80000000,
+				       0xFFFFFFFF, false, GLOBAL_ID(0));
 
 		/* M33 */
-		trdc_mrc_region_config(0x49010000, 0, 2, 0x80000000, 0xFFFFFFFF, false, 0);
+		trdc_mrc_region_config(TRDC_NIC_BASE, MRC(0), DOM(2), 0x80000000,
+				       0xFFFFFFFF, false, GLOBAL_ID(0));
 
 		/* A55*/
-		trdc_mrc_region_config(0x49010000, 0, 3, 0x80000000, 0xFFFFFFFF, false, 0);
+		trdc_mrc_region_config(TRDC_NIC_BASE, MRC(0), DOM(3), 0x80000000,
+				       0xFFFFFFFF, false, GLOBAL_ID(0));
 
 		/* For USDHC1 to DDR, USDHC1 is default force to non-secure */
-		trdc_mrc_region_config(0x49010000, 0, 5, 0x80000000, 0xFFFFFFFF, false, 0);
+		trdc_mrc_region_config(TRDC_NIC_BASE, MRC(0), DOM(5), 0x80000000,
+				       0xFFFFFFFF, false, GLOBAL_ID(0));
 
 		/* For USDHC2 to DDR, USDHC2 is default force to non-secure */
-		trdc_mrc_region_config(0x49010000, 0, 6, 0x80000000, 0xFFFFFFFF, false, 0);
+		trdc_mrc_region_config(TRDC_NIC_BASE, MRC(0), DOM(6), 0x80000000,
+				       0xFFFFFFFF, false, GLOBAL_ID(0));
 
 		/* eDMA */
-		trdc_mrc_region_config(0x49010000, 0, 7, 0x80000000, 0xFFFFFFFF, false, 0);
+		trdc_mrc_region_config(TRDC_NIC_BASE, MRC(0), DOM(7), 0x80000000,
+				       0xFFFFFFFF, false, GLOBAL_ID(0));
 
 		/*CoreSight, TestPort*/
-		trdc_mrc_region_config(0x49010000, 0, 8, 0x80000000, 0xFFFFFFFF, false, 0);
+		trdc_mrc_region_config(TRDC_NIC_BASE, MRC(0), DOM(8), 0x80000000,
+				       0xFFFFFFFF, false, GLOBAL_ID(0));
 
 		/* DAP */
-		trdc_mrc_region_config(0x49010000, 0, 9, 0x80000000, 0xFFFFFFFF, false, 0);
+		trdc_mrc_region_config(TRDC_NIC_BASE, MRC(0), DOM(9), 0x80000000,
+				       0xFFFFFFFF, false, GLOBAL_ID(0));
 
 		/*SoC masters */
-		trdc_mrc_region_config(0x49010000, 0, 10, 0x80000000, 0xFFFFFFFF, false, 0);
+		trdc_mrc_region_config(TRDC_NIC_BASE, MRC(0), DOM(10), 0x80000000,
+				       0xFFFFFFFF, false, GLOBAL_ID(0));
 
 		/*USB*/
-		trdc_mrc_region_config(0x49010000, 0, 11, 0x80000000, 0xFFFFFFFF, false, 0);
+		trdc_mrc_region_config(TRDC_NIC_BASE, MRC(0), DOM(11), 0x80000000,
+				       0xFFFFFFFF, false, GLOBAL_ID(0));
 	}
 }
 
@@ -504,78 +540,78 @@ void trdc_dump(void)
 
 	printf("TRDC AONMIX MBC\n");
 
-	trdc_mbc_control_dump(0x44270000, 0, 0);
-	trdc_mbc_control_dump(0x44270000, 1, 0);
+	trdc_mbc_control_dump(TRDC_AON_BASE, MBC(0), GLOBAL_ID(0));
+	trdc_mbc_control_dump(TRDC_AON_BASE, MBC(1), GLOBAL_ID(0));
 
 	for (i = 0; i < 11; i++)
-		trdc_mbc_mem_dump(0x44270000, 0, 3, 0, i);
+		trdc_mbc_mem_dump(TRDC_AON_BASE, MBC(0), DOM(3), MEM(0), i);
 	for (i = 0; i < 1; i++)
-		trdc_mbc_mem_dump(0x44270000, 0, 3, 1, i);
+		trdc_mbc_mem_dump(TRDC_AON_BASE, MBC(0), DOM(3), MEM(1), i);
 
 	for (i = 0; i < 4; i++)
-		trdc_mbc_mem_dump(0x44270000, 1, 3, 0, i);
+		trdc_mbc_mem_dump(TRDC_AON_BASE, MBC(1), DOM(3), MEM(0), i);
 	for (i = 0; i < 4; i++)
-		trdc_mbc_mem_dump(0x44270000, 1, 3, 1, i);
+		trdc_mbc_mem_dump(TRDC_AON_BASE, MBC(1), DOM(3), MEM(1), i);
 
 	printf("TRDC WAKEUP MBC\n");
 
-	trdc_mbc_control_dump(0x42460000, 0, 0);
-	trdc_mbc_control_dump(0x42460000, 1, 0);
+	trdc_mbc_control_dump(TRDC_WAKEUP_BASE, MBC(0), GLOBAL_ID(0));
+	trdc_mbc_control_dump(TRDC_WAKEUP_BASE, MBC(1), GLOBAL_ID(0));
 
 	for (i = 0; i < 15; i++)
-		trdc_mbc_mem_dump(0x42460000, 0, 3, 0, i);
+		trdc_mbc_mem_dump(TRDC_WAKEUP_BASE, MBC(0), DOM(3), MEM(0), i);
 
-	trdc_mbc_mem_dump(0x42460000, 0, 3, 1, 0);
-	trdc_mbc_mem_dump(0x42460000, 0, 3, 2, 0);
+	trdc_mbc_mem_dump(TRDC_WAKEUP_BASE, MBC(0), DOM(3), MEM(1), 0);
+	trdc_mbc_mem_dump(TRDC_WAKEUP_BASE, 0, 3, 2, 0);
 
 	for (i = 0; i < 2; i++)
-		trdc_mbc_mem_dump(0x42460000, 1, 3, 0, i);
+		trdc_mbc_mem_dump(TRDC_WAKEUP_BASE, MBC(1), DOM(3), MEM(0), i);
 
-	trdc_mbc_mem_dump(0x42460000, 1, 3, 1, 0);
-	trdc_mbc_mem_dump(0x42460000, 1, 3, 2, 0);
-	trdc_mbc_mem_dump(0x42460000, 1, 3, 3, 0);
+	trdc_mbc_mem_dump(TRDC_WAKEUP_BASE, MBC(1), DOM(3), MEM(1), 0);
+	trdc_mbc_mem_dump(TRDC_WAKEUP_BASE, 1, 3, 2, 0);
+	trdc_mbc_mem_dump(TRDC_WAKEUP_BASE, MBC(1), DOM(3), MEM(3), 0);
 
 	printf("TRDC NICMIX MBC\n");
 
-	trdc_mbc_control_dump(0x49010000, 0, 0);
-	trdc_mbc_control_dump(0x49010000, 1, 0);
-	trdc_mbc_control_dump(0x49010000, 2, 0);
-	trdc_mbc_control_dump(0x49010000, 3, 0);
+	trdc_mbc_control_dump(TRDC_NIC_BASE, MBC(0), GLOBAL_ID(0));
+	trdc_mbc_control_dump(TRDC_NIC_BASE, MBC(1), GLOBAL_ID(0));
+	trdc_mbc_control_dump(TRDC_NIC_BASE, MBC(2), GLOBAL_ID(0));
+	trdc_mbc_control_dump(TRDC_NIC_BASE, MBC(3), GLOBAL_ID(0));
 
 	for (i = 0; i < 7; i++)
-		trdc_mbc_mem_dump(0x49010000, 0, 3, 0, i);
+		trdc_mbc_mem_dump(TRDC_NIC_BASE, MBC(0), DOM(3), MEM(0), i);
 
 	for (i = 0; i < 2; i++)
-		trdc_mbc_mem_dump(0x49010000, 0, 3, 1, i);
+		trdc_mbc_mem_dump(TRDC_NIC_BASE, MBC(0), DOM(3), MEM(1), i);
 
 	for (i = 0; i < 5; i++)
-		trdc_mbc_mem_dump(0x49010000, 0, 3, 2, i);
+		trdc_mbc_mem_dump(TRDC_NIC_BASE, MBC(0), DOM(3), MEM(2), i);
 
 	for (i = 0; i < 6; i++)
-		trdc_mbc_mem_dump(0x49010000, 0, 3, 3, i);
+		trdc_mbc_mem_dump(TRDC_NIC_BASE, MBC(0), DOM(3), MEM(3), i);
 
 	for (i = 0; i < 1; i++)
-		trdc_mbc_mem_dump(0x49010000, 1, 3, 0, i);
+		trdc_mbc_mem_dump(TRDC_NIC_BASE, MBC(1), DOM(3), MEM(0), i);
 
 	for (i = 0; i < 1; i++)
-		trdc_mbc_mem_dump(0x49010000, 1, 3, 1, i);
+		trdc_mbc_mem_dump(TRDC_NIC_BASE, MBC(1), DOM(3), MEM(1), i);
 
 	for (i = 0; i < 3; i++)
-		trdc_mbc_mem_dump(0x49010000, 1, 3, 2, i);
+		trdc_mbc_mem_dump(TRDC_NIC_BASE, MBC(1), DOM(3), MEM(2), i);
 
 	for (i = 0; i < 3; i++)
-		trdc_mbc_mem_dump(0x49010000, 1, 3, 3, i);
+		trdc_mbc_mem_dump(TRDC_NIC_BASE, MBC(1), DOM(3), MEM(3), i);
 
 	for (i = 0; i < 2; i++)
-		trdc_mbc_mem_dump(0x49010000, 2, 3, 0, i);
+		trdc_mbc_mem_dump(TRDC_NIC_BASE, MBC(2), DOM(3), MEM(0), i);
 
 	for (i = 0; i < 2; i++)
-		trdc_mbc_mem_dump(0x49010000, 2, 3, 1, i);
+		trdc_mbc_mem_dump(TRDC_NIC_BASE, MBC(2), DOM(3), MEM(1), i);
 
 	for (i = 0; i < 5; i++)
-		trdc_mbc_mem_dump(0x49010000, 3, 3, 0, i);
+		trdc_mbc_mem_dump(TRDC_NIC_BASE, MBC(3), DOM(3), MEM(0), i);
 
 	for (i = 0; i < 5; i++)
-		trdc_mbc_mem_dump(0x49010000, 3, 3, 1, i);
+		trdc_mbc_mem_dump(TRDC_NIC_BASE, MBC(3), DOM(3), MEM(1), i);
 }
 #endif

-- 
2.35.3

