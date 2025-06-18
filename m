Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20E6BC7115B
	for <u-boot@archiver.kernel.org>; Wed, 18 Jun 2025 07:31:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A30CF82BCD;
	Wed, 18 Jun 2025 09:30:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="CIpbuEBT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE25682B18; Wed, 18 Jun 2025 09:30:42 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DEB3982BCD
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 09:30:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RK9av1i5QCN/J6JDdEWHLxRYI66V9Kc50TE20JAv799fZOXAhlHQS2Xdv4BdCwQaQu26Js+IVs0JLxasfTD973ZPzfcQQ0ugemXv54R56ax9XsMCXQDoqa0mcBwj20CEoGTu+5bqiDpW5gLU0WtNR/Z7bkg0/6BShYsWYrQg525YlD5BcuqoEheZqq7mGu0ZLl4yu+Gjk4x3635L6k4AbB/POAtGIJ2ocGukFK1VYz9pfwdyeeB8SI/RiSZeVsa07SyacOb1DL+4lMHQjIWTCZTFS8wlYrWQJCsgCZXm2y5bvjgW+40hx/7OMhBaSd67lkEEXkBB/1rirBICZfJGow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+zZSzTxKA20AKQlDGWvAPo0uEU1OVe7Hb61vganiTSM=;
 b=tIWjbC8od4X+xTs2FZkojqJcwUwGUUodVPV6qjOx4TMJAqUzjkaQyR1ENQvanlYKVSCqzan6bFUjYXgpg3/Fs2paruRZtqyuW+MRVT4KHcomyw1ejDVVjsmrbeH8PYeoOXvHxqJUOc46aiDFuokHzr+2992rmFsA8YARXECYA3OROgC3GVrAF9Z2wIbXUOcBaVNc8wbBDGDE66JKivEt/l/SXsAVaHS4KWevJ6157Z+NA7sHl1KMCE/c/jnrGCnXhHmphehqOJkqfDRJ9NdVWxgAMjk65wl7KLJAqVhLib5yQ0bk47B9y5J2JRLmiQCc+JzLiXfdyrY+LtyTKhTmXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+zZSzTxKA20AKQlDGWvAPo0uEU1OVe7Hb61vganiTSM=;
 b=CIpbuEBTLDCdy9Qpo47e77+h74YTlehdHAA2Y9uEjMtT2woBvqOSbRJBg6/pqtzh5dcsVsemdyAHFkFhkKVzgFpMJ+o3o9rGA4oTHWWYinW5bm1mDJlN7CajZa73asVZ7rHFFOPqX6Iixzz8MYbrC+ZHDpAUQZ2l6xtfCIfI6+WzFnu1XIrWfZywxdgPWQF0ldPz/ywE3Jth/g7/yL04GqxLTarZszyvoHzT0rCq0WQT8ILMzafHVQbyS3/4kvG2nEcPwJNVG2HEPL5JhJMJnpJlPI+YBDrFQdVtb0GLsWkcbbjrYYuMRHxg3py7gd3QhV5NGmkqToTxAO3xns4rZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AS1PR04MB9454.eurprd04.prod.outlook.com (2603:10a6:20b:4d9::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.23; Wed, 18 Jun
 2025 07:30:38 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.8835.027; Wed, 18 Jun 2025
 07:30:38 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Wed, 18 Jun 2025 15:30:19 +0800
Subject: [PATCH v1 6/8] tools: imx8image: Add 2 new commands
 CMD_CNTR_VERSION and CMD_DUMMY_DDR
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250618-binman-v1-6-373e66c7a51f@oss.nxp.com>
References: <20250618-binman-v1-0-373e66c7a51f@oss.nxp.com>
In-Reply-To: <20250618-binman-v1-0-373e66c7a51f@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Alice Guo <alice.guo@nxp.com>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Peng Fan <peng.fan@nxp.com>
Cc: u-boot@lists.denx.de, Enric Balletbo i Serra <eballetb@redhat.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SG2PR01CA0191.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::6) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AS1PR04MB9454:EE_
X-MS-Office365-Filtering-Correlation-Id: fe421d17-cd1f-48b6-6785-08ddae3a05c4
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|376014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dDhxRW1MQWt5V05iWWMyTEc4b25uME9pbk5PMmNvWkxHL2JlcVowS3dwR2sz?=
 =?utf-8?B?MDlSVlIvalR5ZU9iYXVXaEl4aVVwdHBTeWdSZXR6MllXbVJpVlpTUlRwRDJk?=
 =?utf-8?B?YU1UUnp4V09IZmFjQVFSTlNmYlpqdUVCaWVEdk1DN2x5RThYbE9zUlBkMWM0?=
 =?utf-8?B?TGpnSnFwVTdkTzNRaUxBcWFKSEV1dEJmcWxwK2VFdFNhTUU5NW9yVlh0TStr?=
 =?utf-8?B?U2xUdHhSUlNacnNkQlNFTytQOEJCZmhCWmY3eGE1dUpYWXNLV2x0cXpQekph?=
 =?utf-8?B?NjNwYTVpTVJEYlNabDBRdVhIVXhpeG9kemxGZEZ6b3BhTHh1Vk5jSHhYMWRB?=
 =?utf-8?B?S0VEQ2sxbFNoSS91RE1RUGxBbWg4d2R5Q0EzbzRxWE5sRlRKREpnNDI5eWtu?=
 =?utf-8?B?YkQrbWg1b01DR0M0S0lHUjJPaUtoN2VacWNhREJwQWNscndMOFAwYzNjY3hV?=
 =?utf-8?B?TUcxenRPUlBVQWJwZWlVZ2E4eEMwZS9ZS3BvVGROSzB5RW5ETFJmdnJvSk1Q?=
 =?utf-8?B?STBrcEdvSjR4TzIrczRhS2NSb1NVaG1lNUxQdUMxa05RYzN4a3doNldNTGtC?=
 =?utf-8?B?WGw3N3V2NFQ0UmVuNDNDdVEvb2oyNEw0MHdlekRTYmliUnJBajRHcHdsWGRW?=
 =?utf-8?B?aXJzVXJ5dktZMUFKZmFtaG9PZlNuczRtcmtiVjdPYnV4Z2ttRGdGWWcwaStQ?=
 =?utf-8?B?RTJ4ZGh5Vzc0VXJ5VEppaEtqODlaVXZ3UnZyTXhFc1BFeW83ZlA1VHVXTkgv?=
 =?utf-8?B?ZFNRSVB5WTQyUnlYZ0U1UEhQSVN2M2UvTkwrVFVnRTBjUkZadjA0dC9QQUdU?=
 =?utf-8?B?d2FVQ3BzL3U4OU1TdUpyT0dkSEUwSTVBVmJmajVDL0dnWXV4N0xJSEFWMlov?=
 =?utf-8?B?VFdKSUptdFc0a3JlbmtMU0NvMkZ6MktqZHZYOXgvQnl5Wm43TjBNclVsRzlC?=
 =?utf-8?B?MjVSNmZHaDM5NFBoSjBrOG9yRkRZdk1sU0dPTUZmdVNrUDJyQlZzOER4OG1Q?=
 =?utf-8?B?blliS2tSS0VtRDNleVVNUW4waG9vaFNMaWoydGpYR0N6MTVaaFBOUFBISFVu?=
 =?utf-8?B?SVBGVmRLSHBOSmJjYk5zYS82K3B0dmRvM2xwN3NYTzRnbktvWVJEeDV5VDFI?=
 =?utf-8?B?NGN5cnNOL0o5dVhBTkFYNHlJTldtRzQ1T1dJUk0vOXJ2Vlp2Z01helYyTjU5?=
 =?utf-8?B?SytGc1FEUU9KeXpGUDRxOWtlQU54ZS9LOEdpUjFUWndubEY4RnVXY0VGQTUr?=
 =?utf-8?B?RkVkNVdPNUdHZ0w5b0JaRHlLMXRPbzJGQ1duWlpoUjd3ZUw3S2JXcE9iMW1s?=
 =?utf-8?B?Rmdic3FrMXRXb1VENGx4WmNOSDg0VHlEYm9UWlRaUlpyMi82aTFYWGhHdW5P?=
 =?utf-8?B?QzVVa1RBU2MyY0FObWt2d1V1b3JldDFPcVI0blJJdkNqZ0J4QTVTMzFPeWFD?=
 =?utf-8?B?NzJqSUdBY1J0N3UwNHJYQlNuZnZhNEFMbC9IbDdNbTZFb0UxalhabEQzOVZy?=
 =?utf-8?B?czhOa1NGWUFKd0g2UXBkWkRJYUMvNGQwWmswZHRnSVorMWplQnpxTWNxdVpy?=
 =?utf-8?B?b01JNUo2ODZxWi9CM3RLalVmVUZXMVdMT0x5dWRlb0lXUFdjdmJHb0htYWRH?=
 =?utf-8?B?U0FsNnJBQmo0ZUxVY3pETzZ4blQ5Q0JHaEh3NkZYUjVTSWRMSlVDOC9xbWxa?=
 =?utf-8?B?SEFNN0VYMklxZHpqVGd1Vmt1NGVwVjA3Ujh4eXBTRDVERDI0VmJoVmI5RHM2?=
 =?utf-8?B?dS8wbjlQZFlFTks5dE9ZNlVvMFdDTWhkSUdta2QyVzNiV3BvdTBsZWhKVm9L?=
 =?utf-8?B?YXBFaitwOXk5MlBTeko0ZmRYTFRRNmE2aitVNkc4UWVjTW1iZ0NxQ0FrYU9D?=
 =?utf-8?B?SEk1TmcwcHJmNVppQTQ5cTZOd3pCUVpFRHpWU2c3RFZodHpoREwwc1ZBeXJq?=
 =?utf-8?B?RnVzeExBQXU5UnVGenRrdEtNM0FrTmFTOTFNVDF6TEF0QzJBcDJRaHQ2UnpI?=
 =?utf-8?B?WEVtNWxSbEJ3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S1ppYmQ0NDljWTBEWTZQb1hZRGU4dnlSK1FocjRuaVl6QWZOVURzSUxCcjUv?=
 =?utf-8?B?MnllbDkrYXpveHlzN0JYa3BxdWNIVXpDS01yWFBIaisyMGFJZktlWmhDS0tk?=
 =?utf-8?B?VVV5cWlOUXI3KzR0UE5LSmZkRnNYUGJDNXZZVDNWRWpyUDV0NWo3N0tvaHZn?=
 =?utf-8?B?ZlBYaExaYWdNMGFEUWFSU2Y2S2xoak9OdlZ4SVcrL3JuT0kwaHN1NlNFLzRM?=
 =?utf-8?B?WUpCWUVQUGhzSFY0U0JyUTJETU5HU3NCdmNOWXk5dGtLalAvcHY3UkwrcWRZ?=
 =?utf-8?B?bmRTTmMwTElJUEpNQ2pyeEE4ZjFnSDNNdDhzdFlLWFYzOXAzV3hyR1FNTVU3?=
 =?utf-8?B?M0tFaFkyTnExM05MSTJrRzVyTnJ4ZDU2Ky9xUTJxSVUvczhkWkhuYkU1WjU0?=
 =?utf-8?B?MFg4ZXpMNC9yQ0JjU3lpTTZvREUyMVVkZGtxbWJwaUZLeTk4WGxPZFJUUFNN?=
 =?utf-8?B?T0c4dWZmWFVZZ1dSTENxS1lsNEhLQ2hVRkhTK05QSnpaK0xUZzh5K1EveXFG?=
 =?utf-8?B?Zkk4VEJWVWE1NFNaUzVheXhSRlBORlNpTGtXYm93ZXpURER0ZEk0LzFBdXhy?=
 =?utf-8?B?UExWSGVBM1FIMEc4L2UrU0d6VUFVSENMS2QxTmRjL1NYczJsSE1aY1g3d2lR?=
 =?utf-8?B?YW80TGRraEdUcVlLazNoNGI1V3ZocFJOMEdLdG8zTXEwRmJoMXA5ZzR4TTZ0?=
 =?utf-8?B?SktCc25FSm90Y1hLN3VadlFxd3BiMkFtbHEyV2RkMVRpWkRqZWpQckhKck1B?=
 =?utf-8?B?UFlyYkdBeGxDR3NMb0JJQVd0eTgyU0JLWUhkQnZFdFFYUE1JbXhDMlBOU1dv?=
 =?utf-8?B?N3M0NC9RbHpyWWFxUk1SMzBKSVF6Q0Y4ODNjY3AvV1ZINlpSODZ5aUJaUEJH?=
 =?utf-8?B?cVhkdStRQThLWm5UWWZNSTdpenFkY1VyRXo4MWtmTHFWV0RzcUVSR21OSmlk?=
 =?utf-8?B?ZGhKZW5wNmRpNHZuYnNTaWZBaHJNUS9pQkRZdGRvMEQ3YWpZdmhtcTVzNWhG?=
 =?utf-8?B?Vk84dC9iZzVPQkhPZ1JLVTNEaTJ4ZlFtMHJ6RnhDWHVqT2hkNVRtZ1B2bGhS?=
 =?utf-8?B?dkE3L2FOZjdjWEF2N2tkSTFJc0FOMm1pMFVHdGNObGNic05LNjlrU1RjNTQ2?=
 =?utf-8?B?eHNpbE0xUmJJZzU0enpMb1VtVThBc3RNMUpFUGg4K0tPVTEwUFFhbkpiSVB5?=
 =?utf-8?B?NHFNY24vUWprczAydUttcnJlSDFNYTk4cXpYRHE1UjA0WnhFYi9ER0V0VXRi?=
 =?utf-8?B?eVFaelk5TlpmVzVkSTZLWjJ4ZlY2TDBpS2dRQUxjSkR6SXEybmsyckJvOE9w?=
 =?utf-8?B?am1lZTB5V2huQTVYcnMzbXV0ZnljenVrazFQdDgzWWl3Z0F3ZUdXUjdsQVo2?=
 =?utf-8?B?TWlkVWxzZURUVkUxejhmNmRvbmhvK1NpQkpMNEtDZ2ZYcXF1cnZNYmZ1RmFN?=
 =?utf-8?B?bG84NEkveiszQk9rcEZJUG4wU1JJZFRYd1VDeUExTVh1dmFoc21yRW9nSHh5?=
 =?utf-8?B?MEl1SFVtaW9JODhZRmJVUHRNeHpzMFJrTmxvbUR0bk55TjdCcEJFNHNUTFRy?=
 =?utf-8?B?dVlEVW9LdVp6ZldFdFpPZjdxRi8xaVV3NU0yK0RLQ3ZUd012R0hqRWlMbHVP?=
 =?utf-8?B?UmVQMjZ1RnNreUprVzJPTkNiVC82U3YzcitpdDdDSXBIU2swcHVKM0ZwekNq?=
 =?utf-8?B?Qy9KRkpocmYyMjM1aXJFVXk4eFdnSEhsdEsrbHNCeUdHZVNkdHM5NWdPUnc4?=
 =?utf-8?B?bkxhS2hMUUZ5ek05WUFKa0tFSHdPazZ2VFhVUDRzVmVTZlJVQ3AwN3d4VnBH?=
 =?utf-8?B?OWcyd2FwZ3JaUzNqTUd2NXR2ZXlGR2tlSEFScm4wdFBNN0hNV09GajQweCtq?=
 =?utf-8?B?UmlaYnBQWmllSkthL2RVUE01ZEVSU00wcER0OGZmMTFrZDgwUnYrNmE5QlRO?=
 =?utf-8?B?MGJTVGZUUjdpS1NoWlZJZTY0c21iQ3J2cURlZTVYOWc2alJDTGlkTS9jQW1B?=
 =?utf-8?B?K2lRb29LTURWY2UvVVhNVnBPWWorOS8wQlMrN2E4L1JxUDRqK0xMa1lQeldl?=
 =?utf-8?B?WnRyUnRJMktTMk5FZXFxN2trUFdrY1VodWpxYzNFMFJSUmRkUWpzK293MTFw?=
 =?utf-8?Q?+oBDbIvDN3hDijF5b/hKhIGb1?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe421d17-cd1f-48b6-6785-08ddae3a05c4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 07:30:38.5693 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4F7CirvSgPQgRqsShmzQAvlNM6mGO3AO6Fq0X+cJ0bfRJ5/YtRsemkQVe0L6M4UFXFw7DTkziKg961VTKs6tUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9454
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

From: Alice Guo <alice.guo@nxp.com>

i.MX95 B0 uses image container format v2, and `one container header
occupies 0x4000, so that CMD_CNTR_VERSION needs to be added.

The purpose of CMD_DUMMY_DDR is to create a dummy image entry in boot
container prior the DDR OEI image entry. ROM reads the address of DUMMY
DDR image entry and passes it to DDR OEI in OEI entry function as
parameter value, in order to indicate the offset of training data with
the boot container.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 include/imx8image.h |  6 ++++++
 tools/imx8image.c   | 57 +++++++++++++++++++++++++++++++++++++++++------------
 2 files changed, 50 insertions(+), 13 deletions(-)

diff --git a/include/imx8image.h b/include/imx8image.h
index e0d25c5b6c9..d0e05811ff9 100644
--- a/include/imx8image.h
+++ b/include/imx8image.h
@@ -45,6 +45,7 @@
 #define DCD_ENTRY_ADDR_IN_SCFW		0x240
 
 #define CONTAINER_ALIGNMENT		0x400
+#define CONTAINER_PQC_ALIGNMENT		0x4000
 #define CONTAINER_FLAGS_DEFAULT		0x10
 #define CONTAINER_FUSE_DEFAULT		0x0
 
@@ -160,6 +161,8 @@ enum imx8image_cmd {
 	CMD_DATA,
 	CMD_DUMMY_V2X,
 	CMD_HOLD,
+	CMD_CNTR_VERSION,
+	CMD_DUMMY_DDR,
 };
 
 enum imx8image_core_type {
@@ -216,6 +219,8 @@ typedef enum option_type {
 	OEI,
 	DUMMY_V2X,
 	HOLD,
+	CNTR_VERSION,
+	DUMMY_DDR,
 } option_type_t;
 
 typedef struct {
@@ -262,6 +267,7 @@ typedef struct {
 #define IMG_TYPE_SENTINEL 0x06	/* SENTINEL image type */
 #define IMG_TYPE_PROV    0x07   /* Provisioning image type */
 #define IMG_TYPE_DEK     0x08   /* DEK validation type */
+#define IMG_TYPE_DDR_DUMMY 0x0D /* DDR training data dummy entry */
 #define IMG_TYPE_V2X_DUMMY 0x0E /* V2X Dummy image */
 
 #define IMG_TYPE_SHIFT   0
diff --git a/tools/imx8image.c b/tools/imx8image.c
index cad55fd3cf2..5a76643c06e 100644
--- a/tools/imx8image.c
+++ b/tools/imx8image.c
@@ -19,6 +19,7 @@ static bool dcd_skip;
 static image_t param_stack[IMG_STACK_SIZE];
 static uint8_t fuse_version;
 static uint16_t sw_version;
+static uint8_t cntr_version;
 static uint32_t custom_partition;
 static uint32_t scfw_flags;
 
@@ -57,6 +58,8 @@ static table_entry_t imx8image_cmds[] = {
 	{CMD_DATA,              "DATA",                 "new data",           },
 	{CMD_DUMMY_V2X,         "DUMMY_V2X",            "v2x",                },
 	{CMD_HOLD,              "HOLD",                 "hold",               },
+	{CMD_CNTR_VERSION,      "CNTR_VERSION",         "cntr version",       },
+	{CMD_DUMMY_DDR,         "DUMMY_DDR",            "ddr",                },
 	{-1,                    "",                     "",	              }
 };
 
@@ -157,6 +160,10 @@ static void parse_cfg_cmd(image_t *param_stack, int32_t cmd, char *token,
 		param_stack[p_idx].option = HOLD;
 		param_stack[p_idx].entry = (uint32_t)strtoll(token, NULL, 0);
 		param_stack[p_idx++].filename = NULL;
+		break;
+	case CMD_CNTR_VERSION:
+		cntr_version = (uint8_t)(strtoll(token, NULL, 0) & 0xFF);
+		break;
 	default:
 		break;
 	}
@@ -177,6 +184,8 @@ static void parse_cfg_fld(image_t *param_stack, int32_t *cmd, char *token,
 		if (*cmd == CMD_CONTAINER) {
 			fprintf(stdout, "New Container: \t%d\n", ++container);
 			param_stack[p_idx++].option = NEW_CONTAINER;
+		} else if (*cmd == CMD_DUMMY_DDR) {
+			param_stack[p_idx++].option = DUMMY_DDR;
 		}
 		break;
 	case CFG_CORE_TYPE:
@@ -588,7 +597,8 @@ static void set_image_array_entry(flash_header_v3_t *container,
 	img->offset = offset;  /* Is re-adjusted later */
 	img->size = size;
 
-	if (type != DUMMY_V2X) {
+	/* skip hash generation here if dummy image */
+	if (type != DUMMY_V2X && type != DUMMY_DDR) {
 		set_image_hash(img, tmp_filename, IMAGE_HASH_ALGO_DEFAULT);
 	}
 
@@ -632,6 +642,15 @@ static void set_image_array_entry(flash_header_v3_t *container,
 		img->entry = entry;
 		img->meta = meta;
 		custom_partition = 0;
+
+		if (container->num_images) {
+			/* if at least 2 images in container, [0] and [1] */
+			boot_img_t *ddr_dummy = &container->img[container->num_images - 1];
+			if ((ddr_dummy->hab_flags & 0x0F) == IMG_TYPE_DDR_DUMMY) {
+				ddr_dummy->offset = img->offset + img->size;
+				set_image_hash(ddr_dummy, "/dev/null", IMAGE_HASH_ALGO_DEFAULT);
+			}
+		}
 		break;
 	case AP:
 		if (soc == QX && core == CORE_CA35) {
@@ -751,6 +770,11 @@ static void set_image_array_entry(flash_header_v3_t *container,
 		img->entry = entry;
 		img->size = 0; /* dummy image has no size */
 		break;
+	case DUMMY_DDR:
+		img->hab_flags |= IMG_TYPE_DDR_DUMMY;
+		tmp_name = "DDR Dummy";
+		img->size = 0; /* dummy image has no size */
+		break;
 	default:
 		fprintf(stderr, "unrecognized image type (%d)\n", type);
 		exit(EXIT_FAILURE);
@@ -776,22 +800,27 @@ void set_container(flash_header_v3_t *container,  uint16_t sw_version,
 static int get_container_image_start_pos(image_t *image_stack, uint32_t align, uint32_t *v2x)
 {
 	image_t *img_sp = image_stack;
-	/*8K total container header*/
-	int file_off = CONTAINER_IMAGE_ARRAY_START_OFFSET;
+	/*
+	 * 8K total container header for legacy container, for version 2
+	 * container, the total container header is 0x4000 * 3 = 0xC000.
+	 */
+	int file_off = cntr_version ? 0xC000 : CONTAINER_IMAGE_ARRAY_START_OFFSET;
+	size_t size = cntr_version ? SZ_32K : SZ_4K;
+	uint32_t cntr_header_len = cntr_version ? CONTAINER_PQC_ALIGNMENT : FIRST_CONTAINER_HEADER_LENGTH;
 	FILE *fd = NULL;
 	flash_header_v3_t *header;
 	flash_header_v3_t *header2;
 	void *p;
 	int ret;
 
-	p = calloc(1, SZ_4K);
+	p = calloc(1, size);
 	if (!p) {
-		fprintf(stderr, "Fail to alloc 4K memory\n");
+		fprintf(stderr, "Fail to alloc %lx memory\n", size);
 		exit(EXIT_FAILURE);
 	}
 
 	header = p;
-	header2 = p + FIRST_CONTAINER_HEADER_LENGTH;
+	header2 = p + cntr_header_len;
 
 	while (img_sp->option != NO_IMG) {
 		if (img_sp->option == APPEND) {
@@ -801,7 +830,7 @@ static int get_container_image_start_pos(image_t *image_stack, uint32_t align, u
 				exit(EXIT_FAILURE);
 			}
 
-			ret = fread(header, SZ_4K, 1, fd);
+			ret = fread(header, size, 1, fd);
 			if (ret != 1) {
 				printf("Failure Read header %d\n", ret);
 				exit(EXIT_FAILURE);
@@ -813,11 +842,11 @@ static int get_container_image_start_pos(image_t *image_stack, uint32_t align, u
 				fprintf(stderr, "header tag mismatched \n");
 				exit(EXIT_FAILURE);
 			} else {
-				if (header2->tag != IVT_HEADER_TAG_B0) {
+				if ((header2->tag != IVT_HEADER_TAG_B0) && (header2->tag != 0x82)) {
 					file_off += header->img[header->num_images - 1].size;
 					file_off = ALIGN(file_off, align);
 				} else {
-					file_off = header2->img[header2->num_images - 1].offset + FIRST_CONTAINER_HEADER_LENGTH;
+					file_off = header2->img[header2->num_images - 1].offset + cntr_header_len;
 					file_off += header2->img[header2->num_images - 1].size;
 					file_off = ALIGN(file_off, align);
 					fprintf(stderr, "Has 2nd container %x\n", file_off);
@@ -839,7 +868,7 @@ static void set_imx_hdr_v3(imx_header_v3_t *imxhdr, uint32_t cont_id)
 
 	/* Set magic number, Only >= B0 supported */
 	fhdr_v3->tag = IVT_HEADER_TAG_B0;
-	fhdr_v3->version = IVT_VERSION_B0;
+	fhdr_v3->version = cntr_version ? 0x2 : IVT_VERSION_B0;
 }
 
 static uint8_t *flatten_container_header(imx_header_v3_t *imx_header,
@@ -921,6 +950,7 @@ static int build_container(soc_type_t soc, uint32_t sector_size,
 	char *tmp_filename = NULL;
 	uint32_t size = 0;
 	uint32_t file_padding = 0;
+	uint32_t cntr_header_len = cntr_version ? CONTAINER_PQC_ALIGNMENT : FIRST_CONTAINER_HEADER_LENGTH;
 	uint32_t v2x = false;
 	int ret;
 
@@ -978,6 +1008,7 @@ static int build_container(soc_type_t soc, uint32_t sector_size,
 			break;
 
 		case DUMMY_V2X:
+		case DUMMY_DDR:
 			if (container < 0) {
 				fprintf(stderr, "No container found\n");
 				exit(EXIT_FAILURE);
@@ -1023,7 +1054,7 @@ static int build_container(soc_type_t soc, uint32_t sector_size,
 		case NEW_CONTAINER:
 			container++;
 			set_container(&imx_header.fhdr[container], sw_version,
-				      CONTAINER_ALIGNMENT,
+				      cntr_version ? CONTAINER_PQC_ALIGNMENT : CONTAINER_ALIGNMENT,
 				      CONTAINER_FLAGS_DEFAULT,
 				      fuse_version);
 			scfw_flags = 0;
@@ -1073,9 +1104,9 @@ static int build_container(soc_type_t soc, uint32_t sector_size,
 		if (img_sp->option == APPEND) {
 			copy_file(ofd, img_sp->filename, 0, 0);
 			if (v2x)
-				file_padding += FIRST_CONTAINER_HEADER_LENGTH * 2;
+				file_padding += cntr_header_len * 2;
 			else
-				file_padding += FIRST_CONTAINER_HEADER_LENGTH;
+				file_padding += cntr_header_len;
 		}
 		img_sp++;
 	} while (img_sp->option != NO_IMG);

-- 
2.43.0

