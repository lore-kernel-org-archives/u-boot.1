Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08A15CAC58E
	for <u-boot@archiver.kernel.org>; Wed, 10 Sep 2025 23:54:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9792583253;
	Thu, 11 Sep 2025 01:53:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="VjlUkY3H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57E4783253; Thu, 11 Sep 2025 01:53:54 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43A088329F
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 01:53:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IsQr7kB2yQMwSqAAVJmQAquEA5kqvS/5YnTTpr9mVc0Ff7CnD8V934XCcgQouhC2zzIr7MBm3eZTLJQi3wEe0GgykvxKdg5QuuyiWKSjr2BzzxUSHmruGv1kHdpQ6QOskwuTSIhro666q56kGxjdzYPV7DQ/OVEuSFhDYf49uN3ckdA7knHIJ/KAm3cesigVRL0hwcIFpixKVzu04JcV9lqt65prTqMB4d4N4A7bL7vYcxqBKFIynPyV9Sp/dTBchuAG0gDNd//jjV8YDP393FnualuXdSPjmx1xdQTCB1HxxSFxkzFcSoXas6nyqTLtU49IfCswRC7/ydWxydWGIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oYezzVucglBpHdekTuujbsCyzQhVUUj7p7HX7row3wM=;
 b=tVtAY5/pbM9ucM4W1mFp5vujERKCnzOP7ntnifY6DhPYaeuSurs1hlbp33swbxw5dqseNmzr0fbFMVlW0DqdijbJDm9yQHbKROuSi3vCEIZ41jyOGX+/qAG1YE3TqNZP1znp1y2whAcMJju4MYq1m09yJT6IwrxX3O9X8RU2fsvVuwzEDG/UGWDGVbi2o0XnoiDqG9AdWWdQrZ/gOFFtJk3/jACIejgg8cPXiicmo26klDjWR8fACvNejTjaRtP4N7lvNIba3Iu/y1l1m0PBIShbQfN3/z6CmE74caemTUjNSQIvrDGqDKrP8xfILKgoxXQdEiRe4tNlvTBjqTTF7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oYezzVucglBpHdekTuujbsCyzQhVUUj7p7HX7row3wM=;
 b=VjlUkY3H9qrYl91fpqxirdNVo+Zw4cOcbdZXj7IXNmTNpCREvcC8ksCEDMsxHfHA3BaW8a7SsVcqccxl8nSXVH46Ll0XiOa4irqnidK1098lV/lRoCTzjSQGtcYI6HPWlPAWeS0GvsdSWwQu0BhD2l/6WRCiMCTuG14knVDNl0RD5bXnEWjUI+jJnBOw4dEqNiaYPXMLMNdwzXu/hOWigp7/VM5K73r5aZBmMuD4JXT4YwNzXBtgbi1fHGZW+vFR8lF84xXCKYilyvQH20+K277nJT9ILgrntR+tLdf7E+G4v7bDwDGkP/II6E0tCUNFYy8Ub772P1hxT8qdSpisEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AS8PR04MB8850.eurprd04.prod.outlook.com (2603:10a6:20b:42d::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.15; Wed, 10 Sep
 2025 23:53:50 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9115.010; Wed, 10 Sep 2025
 23:53:50 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Mon, 01 Sep 2025 18:48:01 +0800
Subject: [PATCH v1 2/8] imx95: Add get_reset_reason() to retrieve the
 LM/system last booted/shutdown reasons
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250901-imx94-v1-2-c85ae7cdd95c@oss.nxp.com>
References: <20250901-imx94-v1-0-c85ae7cdd95c@oss.nxp.com>
In-Reply-To: <20250901-imx94-v1-0-c85ae7cdd95c@oss.nxp.com>
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>, 
 Alice Guo <alice.guo@nxp.com>
Cc: u-boot@lists.denx.de, Alice Guo <alice.guo@oss.nxp.com>, 
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: MAXP287CA0008.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::18) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AS8PR04MB8850:EE_
X-MS-Office365-Filtering-Correlation-Id: edf85dc2-e31f-4f45-870e-08ddf0c54a44
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|52116014|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YmI0cE1kR2FHenNncmF0S0ZpK0xkR3RaUTJjN2RkaTZVd0hUbnJhWVBkV1pD?=
 =?utf-8?B?Q09GUDZONnRBRkNxM2tjaGpmR1d0ME4vOWpZWDl2VzJkNGhtbXExNUprQ1RO?=
 =?utf-8?B?aS8xSlJ5ajVkUVRONVZDM2dYajlWS2JyZHZ4Z3F1VXFSOFdjR0picFBkajdN?=
 =?utf-8?B?NHZZY3I3bGNVQXM2Vy9LT0d3WW9SZ01RK1FFaDBLbkQxODY1YVBSOUJWM2M2?=
 =?utf-8?B?b3gxbHFaRGIzY1JCaHMrUFFXcFVMNTVaZU5mK1BMTzBnWktzK1pvN3BVQ3o4?=
 =?utf-8?B?L1pkWU5TeVpOVFFnWlpibWYyZ2xQQ3k3UndzdEN5d2NwWDN2bGJ5N2gxbDdQ?=
 =?utf-8?B?c010WWpwTjhiM3hBMUNodnc2L2xjeE9mSlRUS3FIZHdkUTZGVmxOSWI1QzJo?=
 =?utf-8?B?L3FEbjNXbWkwSGYxZTFLZmMycG5hR1pVT2svcDhld1Z3MjRGZW5uem05bElw?=
 =?utf-8?B?RGdnZmR1U2F0cjNsUFRoVUVvd1p0L0hGQm91WjhwbER0Sk90QmJRSkd2blVy?=
 =?utf-8?B?OXlmZWo1L3ltVEhkejh2Y29TbU5OVUFrM1RwZTF2TTlJVW0wSjFxZmNmNXpG?=
 =?utf-8?B?Ukx0T1ZpcVhpNXRsNGFhYjdzOWo5NEJLL1R1TWIzbUhIUFBOTEtXdUNTdldZ?=
 =?utf-8?B?THMyWnBsK2NQSjVyR1VPNEk1RFlzem5JSG8yL1dWWmdqQ2kzak4zZUZ0RGsz?=
 =?utf-8?B?Q1M3c1BveEpGajJ2blRabzdrNzRBOEtuVEtNakhXUUpKRFp2bHJEckloNmpq?=
 =?utf-8?B?eFFGeWJ4UXJudTkrbUJrNE5sb1pvRTYxRGI4Sk1vMkZ4b2w4SHluRkxvcVAy?=
 =?utf-8?B?TEVzU2hRdm5yQVEzc1RXV2dWbUtWb3dhU3ZXOE42QXF3eFRHMEg2OTBCVnd4?=
 =?utf-8?B?VzRLY3UrLytMRnk0L1VOWlExVWxsVU1Sem80d2ovV0IwcHhJbkl2NXJpV2cx?=
 =?utf-8?B?by9DU2FsZi96aHlIL2p4cjRFMGo3ZTZkam1VK0FUb2dIZlNKVXhsRXl6aEFZ?=
 =?utf-8?B?dW5HLzl0VXpiMGlKS0xxOFY2YzdHQVFOTU9kUXpzc2I2bjFiQ3F1NlVRRGcx?=
 =?utf-8?B?Nm5PYTdWMURQS0FYQVNTUWtVSTRBeis3YWY1VmtyYnNieHRQWEpkeUJvb1RB?=
 =?utf-8?B?aEszU1ZVSGNZeFBETkNMQmROK1lzSmZCbVdEa0ZhczYzck9KcGoyVDBnQkk2?=
 =?utf-8?B?OVNENUxsWnRZcFF5MkZFTkZ5RnpyNE1VTWhETWI0Wnljd2h6SGdUZ1JodnlW?=
 =?utf-8?B?dlVkZlc5ZGloWlpyK0RBYWZ0cnR2WFFnekFDL3Z3VUd5a0Z4dHBVR3p2RzJY?=
 =?utf-8?B?RDd3NVRjN0tnb0F6L1NRUVNBQzhqbGs5eXhiZXpJTnFIQ1dTYnVIMHRNejVZ?=
 =?utf-8?B?UU1aMjZMS2JmUWpCY2JZbWlOVmdNOVF2TWlGWGVGTTAvRUdTRy90clErTDFp?=
 =?utf-8?B?QnZpTVZhMFJ6NmdwWHJqQ3RNdWFIYWVhclJydnBiY0NGUVJISmo4cER3QmlN?=
 =?utf-8?B?aUIveFJETWxTRGo3dm5ZU3pjUWVtOWcyNTV4NSs0cHg2V29ORnZKZmttQXBa?=
 =?utf-8?B?Z3Z5ZmR5UVZ0YStzaWpOUlBvMFhCMzNQTjJOMW9mMjh5MnhlNkxsditSZVhm?=
 =?utf-8?B?WmdDbGJHbzlyTFh5SEpwMnpuUGNvZnVZM3dnbWRUUnE2TUp3ZldkaXluL3lv?=
 =?utf-8?B?ZHRQcG56TUljTlB4TXhZejVsYXBOQjhMUVVVYThPM1VtVjVHR2xzK2xMbzBT?=
 =?utf-8?B?OFFHK1VNYTdWUEpOdFhTRG9OenVydnVWSGdqVi9GZ1l5RTV5SHcrODMrSVJm?=
 =?utf-8?B?MDlGVEcyYUgwQzBITWdZVXk2c2dBQ3hvVUF6anZGZmJZbWMrQm1MWmU5NFpk?=
 =?utf-8?B?aHFxK3JLR3NqV20zMk1XMlNjbVR1aUJONFJ1SnJNZm5VYWEzaUZRZ0ZNdXla?=
 =?utf-8?B?UWVsRzJyRjl6cDd6dFNEK1NXcjVpVW9mZEtVVXZKL2txMUFzd2hEV0JlbW9K?=
 =?utf-8?Q?qc0bhdAenmazRB7M0Sz2Aj74bkEIKI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(52116014)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V0txMklrc3pEam1FYzVjWWJVQmNCNG83OU9WdEEyK1BVc0xvd2k5aXFVRXda?=
 =?utf-8?B?ZUdRaU1weGcyWGEySHRzT0lvRUI3ZjJLdjlWTWhLbjJ5Q0U0UFJzN0s5QUJv?=
 =?utf-8?B?cXREOENySHZzR3RmU0tCZ2M2azlZZ0hZZXhlOTVtMDlISmNHUERtZ3hMNFdO?=
 =?utf-8?B?SFl2YXdWNGRobDVVVGtEa3p0R3RQUUo5eHhGWWE3djQ5Ny9vTWdZYStiaVhi?=
 =?utf-8?B?RGJrbjMwVGJlaHFMSVRsZkQ4aDErNU1QczNER09VRkpjSHk2YXRLN1FSdmNV?=
 =?utf-8?B?clQzT1hjZnlGajZtRk4wbmFZU1NrRDh5SzhCTmp0bWFiRU40L1RQOFNRTVBX?=
 =?utf-8?B?UjB5OXZMbXduOEdCd3VrbU5yYWhsS3FVY1lJa2VlQ29IN3Y5LzZFeis4OEVM?=
 =?utf-8?B?cXJkQU5tb0EyMXcwUlRCMEZqbTVUbUcxeXlMeDlNRjNaV2xLY0JSbSsyOXB3?=
 =?utf-8?B?Wk9TUlc3cjBxUGo2ODB0VFJqVzNPQlc3ZlBwUUtoUlJONm1MSTN2OFFFNmtF?=
 =?utf-8?B?akRUUG05Y01QK3UwNm9STUFaS2doVEkxYlhoRHlDaCtEeVQ0NFFHVmNLUkJU?=
 =?utf-8?B?U0hUbVNhRWxISVBzRGpwWjdISkR1cFRiYXB1aFlwcmlTaEpJV1Z1VXh2SS9x?=
 =?utf-8?B?T0lMbDI5VTVZZnk1VDkzOUwzckRhdkM1M3JrQXpFcUlhcGNYL3BVdDR1d3Ft?=
 =?utf-8?B?ZmxPVFp3UzFwOXRad2NyeXhVNkZQS2lUNHNsTjFzY3pNbm0vcUJpdHpFVDR0?=
 =?utf-8?B?NlhPTWw2Nk53OW94T2F4Z0VVcmhsV2M1ZUtaRG9MTFNnUy9xL1NjQjgvQ2Qz?=
 =?utf-8?B?UXBjaUZWNUFEeGZqM3ZjYnh5YnpIWlp1SEtIaVdHM0d1NVVNZHcxUkxYamFt?=
 =?utf-8?B?T3c1Q2x2NklONXNidWRLem5IMnBTWUdDVWgyUjdrMTZLQWIvNUFYNlZlZFBS?=
 =?utf-8?B?U25iV2ZFYjlGd3BaR29jaGx5MnJuRUUraFB0VnlkSGpHaXIxQUhkQWgyeU8z?=
 =?utf-8?B?ZEhHditKWkw4RlY5UG9PUDdFa2FZZ1pHRlNHOU5TUVFsRGdaeVhyemphMTBT?=
 =?utf-8?B?MlJOVkJ0OUthVUFlZGR5U1VlbUdBYlFoVTFNNUtxVEJscHJ4NHVYRWpuZXJU?=
 =?utf-8?B?WnZRK2czV3VFNHhSVnBvelRwMURYZXdhUE9rYXlEQkFZdmpJRlJxbFY2b0VO?=
 =?utf-8?B?SUV1VFZWUEgvUndaZkJMMk41WTJKNThVc01MWll0by8rZ0V0MWU5dzV4c25M?=
 =?utf-8?B?UStQdmVzbHQveGJlN3N5b3hFaVg0UTd3MHNMWTBEazlVbmMxQ2hEYk1BTkUv?=
 =?utf-8?B?bmh3ZjRoWXZhSUZSdXhTL0c1bTFsRUtGdEExUVNGWXd6UHJBMC8zK0FqWEkr?=
 =?utf-8?B?WExpUWVyLzl2Nzh4ZHgxMTF4eWd5WjdUV1hiL3gxSEZpdkw4d1hiOU8rYmlR?=
 =?utf-8?B?UnIrdENCTFhGK0QvTmRxK3Q4emJmcmJpaTNuOHFEOW4xamFyVmhXUzJVOXdo?=
 =?utf-8?B?VDVqWjRwaW1PWVBkTU54R3lJTjR5emdvWDUva2Q0Y0N4UEp6RjdHQlFuUUhC?=
 =?utf-8?B?UDJIMWJQVmtyUU9rQ2RwaklVZzVQYmpaZ0Zjd2pYQXl4UmM4Q2pSUFplckIz?=
 =?utf-8?B?emJvTktkY1VGSGZPWXBGZXhCYTdqSEJtb1ROMk90UmVLZTVYT1NTdEYzckcx?=
 =?utf-8?B?N0NadmZoVE1DazhSUUZ3TEtQbk5veWdlTDErZWhJNFdkWFkwbnZURFVFT2VH?=
 =?utf-8?B?Z0llQWNUeDZNVGVqaUJvM3VuL2YyVVBtV0RQQitBL1c2Q2hSK21VSjBQN0xv?=
 =?utf-8?B?amYrMkh1VWJtU2ZQeHRJQzJ2dHo4Tm1rbzN6VUdhdUdlcnhQaUttdmtHU1NB?=
 =?utf-8?B?djhObjZJcUZHRkp0MmVmdFNQZFlDeDd0VTNkNUNoK1VCRlpFQ0V1U1pDSWVE?=
 =?utf-8?B?SUJLc0sxMVpoMncwc0RoSDBBUDJsTVlPbDVMMnBzd0VpcVBIK0VqbHk2VWtO?=
 =?utf-8?B?c3ZicjVINVVkNlpxb3FYZkNkUXRiUUhRYitSS1JaS1V1akRJTE1jVHl4bkRh?=
 =?utf-8?B?TTFHcVNtUHFXTzBhclc4VkpsTTlDaTlaUUdPYmhmT2NSYTJFNWE0aEp0KzBX?=
 =?utf-8?Q?AWN8nLXhu+2gwPDzCgbZBcGsQ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edf85dc2-e31f-4f45-870e-08ddf0c54a44
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 23:53:50.3323 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pBidQtzZKuhJkz1AYw8wvcZniEgoyl4mo0MW/3J5G9f6V82qLChQ7n/ki3CO7FVOsZQpKTyp5bb6yWw+YQqZUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8850
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

System Manager provides the last booted and shutdown reasons of the
logical machines (LM) and system using the SCMI misc protocol (Protocol
ID: 0x84, Message ID: 0xA). This path adds get_reset_reason() to query
and print these reasons in SPL and U-Boot.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Ye Li <ye.li@nxp.com>
---
 arch/arm/include/asm/arch-imx9/sys_proto.h |   1 +
 arch/arm/mach-imx/imx9/scmi/soc.c          | 117 +++++++++++++++++++++++++++++
 board/freescale/imx95_evk/spl.c            |   3 +
 include/scmi_nxp_protocols.h               |  55 ++++++++++++++
 4 files changed, 176 insertions(+)

diff --git a/arch/arm/include/asm/arch-imx9/sys_proto.h b/arch/arm/include/asm/arch-imx9/sys_proto.h
index 455aa95339e..dead7a99a66 100644
--- a/arch/arm/include/asm/arch-imx9/sys_proto.h
+++ b/arch/arm/include/asm/arch-imx9/sys_proto.h
@@ -21,6 +21,7 @@ int m33_prepare(void);
 int low_drive_freq_update(void *blob);
 
 enum imx9_soc_voltage_mode soc_target_voltage_mode(void);
+int get_reset_reason(bool sys, bool lm);
 
 #define is_voltage_mode(mode) (soc_target_voltage_mode() == (mode))
 
diff --git a/arch/arm/mach-imx/imx9/scmi/soc.c b/arch/arm/mach-imx/imx9/scmi/soc.c
index f973652d0cb..43f516d3d7f 100644
--- a/arch/arm/mach-imx/imx9/scmi/soc.c
+++ b/arch/arm/mach-imx/imx9/scmi/soc.c
@@ -17,8 +17,10 @@
 #include <env_internal.h>
 #include <fuse.h>
 #include <imx_thermal.h>
+#include <linux/bitfield.h>
 #include <linux/iopoll.h>
 #include <scmi_agent.h>
+#include <scmi_nxp_protocols.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -468,6 +470,114 @@ err:
 	printf("%s: fuse read err: %d\n", __func__, ret);
 }
 
+static char *rst_string[32] = {
+	"cm33_lockup",
+	"cm33_swreq",
+	"cm7_lockup",
+	"cm7_swreq",
+	"fccu",
+	"jtag_sw",
+	"ele",
+	"tempsense",
+	"wdog1",
+	"wdog2",
+	"wdog3",
+	"wdog4",
+	"wdog5",
+	"jtag",
+	"cm33_exc",
+	"bbm",
+	"sw",
+	"sm_err", "fusa_sreco", "pmic", "unused", "unused", "unused",
+	"unused", "unused", "unused", "unused", "unused", "unused",
+	"unused", "unused",
+	"por"
+};
+
+int get_reset_reason(bool sys, bool lm)
+{
+	struct scmi_imx_misc_reset_reason_in in = {
+		.flags = MISC_REASON_FLAG_SYSTEM,
+	};
+
+	struct scmi_imx_misc_reset_reason_out out = { 0 };
+	struct scmi_msg msg = {
+		.protocol_id = SCMI_PROTOCOL_ID_IMX_MISC,
+		.message_id = SCMI_IMX_MISC_RESET_REASON,
+		.in_msg = (u8 *)&in,
+		.in_msg_sz = sizeof(in),
+		.out_msg = (u8 *)&out,
+		.out_msg_sz = sizeof(out),
+	};
+	int ret;
+
+	struct udevice *dev;
+
+	ret = uclass_get_device_by_name(UCLASS_CLK, "protocol@14", &dev);
+	if (ret)
+		return ret;
+
+	if (sys) {
+		ret = devm_scmi_process_msg(dev, &msg);
+		if (out.status) {
+			printf("%s:%d for SYS\n", __func__, out.status);
+			return ret;
+		}
+
+		if (out.bootflags & MISC_BOOT_FLAG_VLD) {
+			printf("SYS Boot reason: %s, origin: %ld, errid: %ld\n",
+			       rst_string[out.bootflags & MISC_BOOT_FLAG_REASON],
+			       out.bootflags & MISC_BOOT_FLAG_ORG_VLD ?
+			       FIELD_GET(MISC_BOOT_FLAG_ORIGIN, out.bootflags) : -1,
+			       out.bootflags & MISC_BOOT_FLAG_ERR_VLD ?
+			       FIELD_GET(MISC_BOOT_FLAG_ERR_ID, out.bootflags) : -1
+			       );
+		}
+		if (out.shutdownflags & MISC_SHUTDOWN_FLAG_VLD) {
+			printf("SYS shutdown reason: %s, origin: %ld, errid: %ld\n",
+			       rst_string[out.bootflags & MISC_SHUTDOWN_FLAG_REASON],
+			       out.bootflags & MISC_SHUTDOWN_FLAG_ORG_VLD ?
+			       FIELD_GET(MISC_SHUTDOWN_FLAG_ORIGIN, out.bootflags) : -1,
+			       out.bootflags & MISC_SHUTDOWN_FLAG_ERR_VLD ?
+			       FIELD_GET(MISC_SHUTDOWN_FLAG_ERR_ID, out.bootflags) : -1
+			       );
+		}
+	}
+
+	if (lm) {
+		in.flags = 0;
+		memset(&out, 0, sizeof(struct scmi_imx_misc_reset_reason_out));
+
+		ret = devm_scmi_process_msg(dev, &msg);
+		if (out.status) {
+			printf("%s:%d for LM\n", __func__, out.status);
+			return ret;
+		}
+
+		if (out.bootflags & MISC_BOOT_FLAG_VLD) {
+			printf("LM Boot reason: %s, origin: %ld, errid: %ld\n",
+			       rst_string[out.bootflags & MISC_BOOT_FLAG_REASON],
+			       out.bootflags & MISC_BOOT_FLAG_ORG_VLD ?
+			       FIELD_GET(MISC_BOOT_FLAG_ORIGIN, out.bootflags) : -1,
+			       out.bootflags & MISC_BOOT_FLAG_ERR_VLD ?
+			       FIELD_GET(MISC_BOOT_FLAG_ERR_ID, out.bootflags) : -1
+			       );
+		}
+
+		if (out.shutdownflags & MISC_SHUTDOWN_FLAG_VLD) {
+			printf("LM shutdown reason: %s, origin: %ld, errid: %ld\n",
+			       rst_string[out.bootflags & MISC_SHUTDOWN_FLAG_REASON],
+			       out.bootflags & MISC_SHUTDOWN_FLAG_ORG_VLD ?
+			       FIELD_GET(MISC_SHUTDOWN_FLAG_ORIGIN, out.bootflags) : -1,
+			       out.bootflags & MISC_SHUTDOWN_FLAG_ERR_VLD ?
+			       FIELD_GET(MISC_SHUTDOWN_FLAG_ERR_ID, out.bootflags) : -1
+			       );
+		}
+	}
+
+	return 0;
+}
+
 const char *get_imx_type(u32 imxtype)
 {
 	switch (imxtype) {
@@ -478,6 +588,13 @@ const char *get_imx_type(u32 imxtype)
 	}
 }
 
+int print_cpuinfo(void)
+{
+	get_reset_reason(false, true);
+
+	return 0;
+}
+
 void build_info(void)
 {
 	u32 fw_version, sha1, res = 0, status;
diff --git a/board/freescale/imx95_evk/spl.c b/board/freescale/imx95_evk/spl.c
index 08f4da0bb73..3d64097b4c7 100644
--- a/board/freescale/imx95_evk/spl.c
+++ b/board/freescale/imx95_evk/spl.c
@@ -5,6 +5,7 @@
 
 #include <asm/arch/clock.h>
 #include <asm/arch/mu.h>
+#include <asm/arch/sys_proto.h>
 #include <asm/mach-imx/boot_mode.h>
 #include <asm/sections.h>
 #include <hang.h>
@@ -65,5 +66,7 @@ void board_init_f(ulong dummy)
 	debug("SOC: 0x%x\n", gd->arch.soc_rev);
 	debug("LC: 0x%x\n", gd->arch.lifecycle);
 
+	get_reset_reason(true, false);
+
 	board_init_r(NULL, 0);
 }
diff --git a/include/scmi_nxp_protocols.h b/include/scmi_nxp_protocols.h
new file mode 100644
index 00000000000..fe6ecd6a7cf
--- /dev/null
+++ b/include/scmi_nxp_protocols.h
@@ -0,0 +1,55 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/*
+ * Copyright 2025 NXP
+ */
+
+#ifndef _SCMI_NXP_PROTOCOLS_H
+#define _SCMI_NXP_PROTOCOLS_H
+
+#include <asm/types.h>
+#include <linux/bitops.h>
+
+enum scmi_imx_protocol {
+	SCMI_IMX_PROTOCOL_ID_MISC = 0x84,
+};
+
+#define SCMI_PAYLOAD_LEN	100
+
+#define SCMI_ARRAY(X, Y)	((SCMI_PAYLOAD_LEN - (X)) / sizeof(Y))
+
+#define SCMI_IMX_MISC_RESET_REASON	0xA
+
+struct scmi_imx_misc_reset_reason_in {
+#define MISC_REASON_FLAG_SYSTEM		BIT(0)
+	u32 flags;
+};
+
+struct scmi_imx_misc_reset_reason_out {
+	s32 status;
+	/* Boot reason flags */
+#define MISC_BOOT_FLAG_VLD	BIT(31)
+#define MISC_BOOT_FLAG_ORG_VLD	BIT(28)
+#define MISC_BOOT_FLAG_ORIGIN	GENMASK(27, 24)
+#define MISC_BOOT_FLAG_O_SHIFT	24
+#define MISC_BOOT_FLAG_ERR_VLD	BIT(23)
+#define MISC_BOOT_FLAG_ERR_ID	GENMASK(22, 8)
+#define MISC_BOOT_FLAG_E_SHIFT	8
+#define MISC_BOOT_FLAG_REASON	GENMASK(7, 0)
+	u32 bootflags;
+	/* Shutdown reason flags */
+#define MISC_SHUTDOWN_FLAG_VLD		BIT(31)
+#define MISC_SHUTDOWN_FLAG_EXT_LEN	GENMASK(30, 29)
+#define MISC_SHUTDOWN_FLAG_ORG_VLD	BIT(28)
+#define MISC_SHUTDOWN_FLAG_ORIGIN	GENMASK(27, 24)
+#define MISC_SHUTDOWN_FLAG_O_SHIFT	24
+#define MISC_SHUTDOWN_FLAG_ERR_VLD	BIT(23)
+#define MISC_SHUTDOWN_FLAG_ERR_ID	GENMASK(22, 8)
+#define MISC_SHUTDOWN_FLAG_E_SHIFT	8
+#define MISC_SHUTDOWN_FLAG_REASON	GENMASK(7, 0)
+	u32 shutdownflags;
+	/* Array of extended info words */
+#define MISC_MAX_EXTINFO	SCMI_ARRAY(16, u32)
+	u32 extInfo[MISC_MAX_EXTINFO];
+};
+
+#endif

-- 
2.43.0

