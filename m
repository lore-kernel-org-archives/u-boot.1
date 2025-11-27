Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BEDBCFD2F6
	for <u-boot@archiver.kernel.org>; Thu, 27 Nov 2025 10:46:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5677D84372;
	Thu, 27 Nov 2025 11:46:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="ARTPumnx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F72584374; Thu, 27 Nov 2025 11:46:24 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 825B184332
 for <u-boot@lists.denx.de>; Thu, 27 Nov 2025 11:46:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nrusow52qdqph1+2pevFRrgGth3dKAndPLbvcu70gLrlxzY0T8qCXDitak8Qc48oYDvoWH3EKEkdbh0l3GeP8x/xY0oB5DqBRhXEOG0lMOEd7ZKnCHOsRt5zERTOCY6OOVD289eraV+UczcYZlgfgdD20QrMHRYT5L2odk/2sr7rRjl4KMNJa2F1I1+1ZQo4r0ucuudMweVlMH6y2Ck3S7g3bPq1X5v+OVU8WQJL182N62rv42Uw0y8sSmZKLsDRZ1r4c+k544Suu+7cXLKtvgzCdPpxd2v9SrH7Zy/udYpCZy3ynoIprwys4zPN3ti3UO9rZ1MqNHSDD++HjiY4PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h2wV93BKIYHZM45R1+Kcq9Hdqx1Qk524v/j36Yy+nOc=;
 b=ctaH6Ro/1rtJglMbyeT9sSYA5G81BDqJJK2fIu2oUogFmyXuA7yZs1bjI0M9nJaNi4nOKifuCkvQS1auWO7Gy5su7sWS+5So6cMMBfdqqo+vzuInhTulB1eeingxdInPLsH60Plov6tExtLmeP/7S78vRn2Jr6BvHYAtbe7mPqO1Thmw8xbgt1jnEVkHoh+QoSGf+pmmVMCfd8mypqlCF427tcKc+9ZMPMQGnJKCPjKU9VX9+tst0xC3Bs1x/U1nSVSuQu/2rPixe+ha63/+wDbLrbnn9jhiO2SpZrBtyApJ2wByGRYc3E3joEm4cAAAU/V0sljjvoQhCwENxL6p7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h2wV93BKIYHZM45R1+Kcq9Hdqx1Qk524v/j36Yy+nOc=;
 b=ARTPumnxXQBkGGAOZgXGZWIfBOjAlUIDwTRdPSl2M21S+Z7H+yUTux7CosCPJMkRK+BP91f0q9AgOjnMUgu4/MSX0mKSAvEcBGLTIMGTPjuW9BUvag9DLPYR8WeytZiYkROREQZXDfEjhJmgR2oTC/SUWSpqe330wHZcb1KbhvE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by AS1PR04MB9632.eurprd04.prod.outlook.com (2603:10a6:20b:477::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Thu, 27 Nov
 2025 10:46:19 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad%4]) with mapi id 15.20.9366.012; Thu, 27 Nov 2025
 10:46:19 +0000
Message-ID: <53057b6b-12b2-498c-aea6-88f535c0b096@cherry.de>
Date: Thu, 27 Nov 2025 11:45:25 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] Raxda Rock Pi 4A serial console output stops prematurely
From: Quentin Schulz <quentin.schulz@cherry.de>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Jonas Karlman <jonas@kwiboo.se>, Jagan Teki <jagan@amarulasolutions.com>,
 Heiko Stuebner <heiko@sntech.de>
References: <e7b7b905-4a6c-4342-b1a5-0ad32a5837cf@gmx.de>
 <94561b0d-8203-4210-b599-93070eb934cf@cherry.de>
 <89385ade-7d7d-4a8c-b929-f4eb47e254cc@gmx.de>
 <4fcde736-c5e1-4800-8b75-ab87c0dd8b0a@cherry.de>
Content-Language: en-US
In-Reply-To: <4fcde736-c5e1-4800-8b75-ab87c0dd8b0a@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: WA2P291CA0033.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::13) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|AS1PR04MB9632:EE_
X-MS-Office365-Filtering-Correlation-Id: 87c02a96-ed2c-4cc3-a51a-08de2da23281
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?emZob3VlS1dRWXljUVNHUy9pbzBKWUhOQ1ozNXN0VE0wY3p1VGhaN3F1bUJ5?=
 =?utf-8?B?MkVqbGtnZ0U3YnNXN0ZVbnk0bjM1Qk9GR3RzYnU3cXV2cFlUNzV0czdGTnVD?=
 =?utf-8?B?NzJTa2U2WW1iUVZ0aitzdVQvSFZyWTBnQnFyMURyejhINzBpZjZweVJoeGFr?=
 =?utf-8?B?VnB1ajQwTU9hazUvZTJUN2RUaHF6MkZzeHNEelNTV0cvRjJvYWdzdmZ0WXcy?=
 =?utf-8?B?eEZVZjNaQWpDdWN6RGJ0UEhkK2ZHVmNRbUdVMzhERTU2RWNLd2MzSzJTcU5p?=
 =?utf-8?B?ZEt5VStDVUpuZVJFLzEzaE1BTWRMTGUrcEFlWTFCTU1IRlk4OTY4UlpwZVBs?=
 =?utf-8?B?Q0NHUCtXRFU1WDhwTGt0MWczYnkvMkc1eXkyWWhwNlFoSUNiN3lIYWNTLzNN?=
 =?utf-8?B?a2NtOW5kUTZpM24raDFnVzBzN0xKM2pROEdWeHoyRFE0Z08vL3JuTWcvSi9j?=
 =?utf-8?B?T1JQTi9nQWhlU0dNaWZ5b0lyVThOL2tpRlVPT1hyaWhoMkVWcS84bDFYYzJz?=
 =?utf-8?B?VEV6MXJRNzZKNW8vaFJaTFU2NGgxM0h4UHF0R0IrSmtpaHpBMXh4V1hyUVRt?=
 =?utf-8?B?UXAzcVlINWovZGkyYU11dElZa2Irb0hpNGFMdHJWckF4WVNXT0JjamNGUUdD?=
 =?utf-8?B?V081THZxc3JTK1IyWWd2TVJzT1JnOG5iQkw5VUVNbUpEc2pRTGFHSnBLcUVE?=
 =?utf-8?B?MkdnNHhBSE1Ra1RzRUw3WC82Znk4MjhIczV2TmduSGEzWU5HQWo2SU0wVTd5?=
 =?utf-8?B?Q3JlSHc4RnY2amx2NlVVZDNyWXlCZkppYVVldzZuMVhoeHFiWmVFWDJJQUFR?=
 =?utf-8?B?V3JvTlNuQU1Zd2N0NmNTeDduOW4xREN5NmJFUXV3QzhvMEQ4SktUZ1RQRDZy?=
 =?utf-8?B?WnVRbXkxb3NPQUM2TWJ4Q2NvMW1idjJTcHdkZkJIV2JvbHNYZk9OUmMxUkpT?=
 =?utf-8?B?Wk9zUjZINnBiRUxna3p5VkI3a1o0bTRnUVZhL2lzVVRXSmNmREpJeFpIVDRK?=
 =?utf-8?B?Y0xEZ2V4VHpnejZLcFJsQnBJN1U4TTZiTVd2bTRaUWFCV04yMlduenNuQVVI?=
 =?utf-8?B?MzdvelQwS0NROVYwdGNzaEluOGRDcE9tV1g1cGQ1Y2hSSXRzazh2WWNWUEhZ?=
 =?utf-8?B?Ymo2ZmJjSmhzYUNjTW13dzF0RzZ0QXF1aHI2V083UzRicjV5U0RPV29MTXgz?=
 =?utf-8?B?U1RuZlU2cEtlK3Q4VVE2MFc2MCs0UllHaVFjdlBOWXJmb1c0YXRUWDhvNno3?=
 =?utf-8?B?dlk5NWV3MFl1UlJYdjBRU1N2SmpvdVU2Tm5CcFd5MW5zdFp4U2huNDRiL2VG?=
 =?utf-8?B?KzAwcmlaa0FpSWFoM1R1bUFjUkxyWWQ4OUZsWVBoQVN6T3ppREJwZkdXNlI0?=
 =?utf-8?B?SHJZdFl0enkyQ2JLZ2VFMXovRlE0aHVYRUwxd0pGSXNvcnVwbHdQRTgwQTRT?=
 =?utf-8?B?MW12TjdrRVBnQnorZWNtZ1llMkk1SDdQTGhUbFRuRFhnanBLTEl1UTIyaVJ1?=
 =?utf-8?B?U1ZpVndTNkYxaHdLdXZkZXFJOXRQTkkzZlRYV2t1S0JIVEJ1VFFxN0pMSjE4?=
 =?utf-8?B?QnJWT1dEa0Rna0psZzUxVGplek8vQVJIKzVsWWFBSHVzSXZKR1k4WDlacmVi?=
 =?utf-8?B?OWJGTGlRMXV3T2tzc2lNOVRVTWk2a2lISVNLSG9CWkRKeXpVNUNWRWlac1Bk?=
 =?utf-8?B?b3NFb3dmaDVRYXJPUWhKVXpDVks3WllMSlZIUmFYTkVMd0YzVUFFY01XMkho?=
 =?utf-8?B?aEV6ZWM3anJwZktmT2kraVhWTjZJNGdqK3I3QUowS08xTG1NUnRwb1QzUVlP?=
 =?utf-8?B?azVhejU2MzhXWVdvRWRRcDBSL0R6WVRRaW1kZXg5SEoxSnhrVkZhVGI0WHk4?=
 =?utf-8?B?aVA0ZUlHazZDTk1GOGcvTzJaajFja1RUTDJTL1hwMkdvYlBNWmYra1FMR0hx?=
 =?utf-8?Q?ftICquHYTOy3pvFMWMdbeoegbQLvLo5p?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NTNYellaNmNTRktuaDgxZWlybW94aE5MeEw1SjNSQlVQNkZJSFcycHR6TzRt?=
 =?utf-8?B?MlZGT3pyM3p1MkptWEFMRzNFNENvUHVHYVptRitIWkFLWWpMV21wS005aW1t?=
 =?utf-8?B?d1lYckhOZnMzTW83WVAwM2JPb3NjM0ZBeG83bVIvNXV2K2kyRHRUeXFGMDhn?=
 =?utf-8?B?UGZobU5weENZMnlBNDVKK0p2aGZ1Y3hLRFl4a2RrcXhLWEhMMUozZldSd1Na?=
 =?utf-8?B?RUdoaUJVeWV0Q1NCUUlYWVVVcVg5dkR5b2V6Wk4rOVNyZ1FqMDVSY1ozd2hS?=
 =?utf-8?B?UEduem1DNU5GY3dzSExsOHVHYkNQbHVnZFF6YysxaFUya29nVnY3ZXhtZ3hm?=
 =?utf-8?B?TlVhMGhuZjl6UUN4VnR4TkJlSEJNa0piRng2ejBLZTYrVFJuRjFjNnMra0FB?=
 =?utf-8?B?SU1MeFRRVFZFc0h1K2xJYk8xbmdQSXgvUk05b01venZzR01aQ3JSVU94SlVz?=
 =?utf-8?B?MTlXWUlyWWZUT3RBM25LN0kzc0FVOXFuWTRlWk5JQ1o4MWJ0VzVYS2RZTHJu?=
 =?utf-8?B?UWNNVHhmVEswbVFacXdRanZaY0dNWGpMczFWUzh1czBTcjh2aHF6bXJBQUVn?=
 =?utf-8?B?ODBvUHUzMUNHUjFIK0hNL3AzWTZOSEtYZkdhQzBtQnE3QlhlMWVWT3Jhbm4r?=
 =?utf-8?B?cnVNMGFsUWpselM1YkRtVGFsTUNQVEMzN3JpQkg2Vk1CUS9ZVU1HUmtMZTJU?=
 =?utf-8?B?aUJtZGpPc09GcFFpbHJZOGordm12UWRKYXVKckpLc1FYV3o4ckdHbmkwL09D?=
 =?utf-8?B?YlJmN3ptT1RtSzJhajc2R0lHZXIvRVV3aGQ0aG5xZ2lqZTBGTnMyWkJaMkJ0?=
 =?utf-8?B?RDNTR0diY2RkYlhwZWRwOHZPcU5UUWJ1Q0dDZmVCSTJQSVZoelIreXRlOWZU?=
 =?utf-8?B?SmdDWUlwaHVXR0h5clpuVDNOSjcyTE9zaUg3Nk1FcFJ3M3lnV012a3ZqYXJn?=
 =?utf-8?B?Y1hpaWVlZ0Z4eVE2T0MzRXBwcHoxblFObks3c28vbVM3TmdnU01LLzJBLzhR?=
 =?utf-8?B?b1cwNGJ1L0JJaHBTUDgzYlBnMEZNNWlWc0hrT0s3SlNMbHVmZnVFTmZJOThZ?=
 =?utf-8?B?d2ZoT1hVQ0NFdDhQM28yeUFrZWFVMnMzYnpENldrM0pIdDNQS1MzZ09IRUF5?=
 =?utf-8?B?bTZnSy9UcXhHWktOdVQ3NklFSW5mVGg2RmVSZld0R0lqcyszZGdFalEva1dx?=
 =?utf-8?B?enZBNWJoS0ErbEZlYXZwQ1pSTjdKc2VpSUhiblFWcTRqUG4zcDZoa0RoeHpw?=
 =?utf-8?B?c1M3dUExblpYa2lvKzZzVG1JdGtKbUM5NUpxakpaQi82S1V6Yjk5bkFwczBy?=
 =?utf-8?B?ZEFTMjNkV25salVZQnpZb3pSeXZsdldOMEFtaEdwRUZYZE5uWURiU1dCUEdq?=
 =?utf-8?B?NGFHUFptbWRYSFJBcG00Q2taZS9YZlJacm1TbEFaQ3lkNXhtWEl6RkZoUTdH?=
 =?utf-8?B?bTc3V0xzSEpFWEdiZzJxRTNpSnhKYldJZzRCSFBZTnplc1FGSDduUnBTMzdp?=
 =?utf-8?B?VG4xUGVxREdBVjZranE2cUxtdjZMaXJxU29SZVorWGhHK1FSNjJaVmpQaXI0?=
 =?utf-8?B?SmRKYmRZc1JQUVBpRVlwLzRUVzlsWXNvQ1cyU0MwcWhNaC9ENDBXa0dKaUJH?=
 =?utf-8?B?cjQvT1NZcjFJL2tnYVIwSmxqaDhxbzJOaUtCRTVLRzJzUUNqbUsydGN1VGN2?=
 =?utf-8?B?bzByQkFIZSs1SktGbWI3aW5VaG4vMVZFMytwRmNqSFJnM0Jqb3NTelJYNVVP?=
 =?utf-8?B?YzVOelVuY29EVit5YXlpcER3dmp1VUJxY05ZTUhiNUZkTXk3dXpZazlraGRk?=
 =?utf-8?B?ZjlnSWpzN2IweWtZNkpqajJGTWZPQWZXRjdoMGRkc0orRUJsUllJcUd1ZjQx?=
 =?utf-8?B?dXByVmNXRitidlhENk5ueDhqY1M5NXJtLy9Va21MdGErczM3eFRFbEl0SzFt?=
 =?utf-8?B?ZjZ6ejhxWm9rV3U3UHAyVFh2cnE3OW8zOUR4MWdCSGtnSTNoR3RPNGlQcGI2?=
 =?utf-8?B?cmY3MFEyTUdmb0UrTWRNaTdJRDAxc3pWUzFXa1c3RHpQMHpyOVg0bEtrd2tq?=
 =?utf-8?B?bmhSZ3dhcTN4b1ZlQWFaZ2h4U0lTcGJCYkJxQjJnRGx4NHRQdE9vVFlXNm40?=
 =?utf-8?B?ZytXUndXQjRwQ0VRS0M1QmQrMEVGMlgwVnlwMFFhQlZXS0lOdmlPRzBRazN5?=
 =?utf-8?B?dVE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 87c02a96-ed2c-4cc3-a51a-08de2da23281
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2025 10:46:19.0122 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ALI2gdZYAJakgzcI2i59dyfrw9NwBvEEwBatxxoikpfjOSVi/5zcshCukjeZAHg1y1j0td7jwHwDW2ZoJoUxaSpCBBt4if/qsQLUnwGtmUI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9632
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

On 11/27/25 11:35 AM, Quentin Schulz wrote:
> Hi Heinrich,
> 
> On 11/26/25 5:46 PM, Heinrich Schuchardt wrote:
>> On 11/26/25 16:00, Quentin Schulz wrote:
>>> Hi Heinrich,
>>>
>>> On 11/25/25 7:02 PM, Heinrich Schuchardt wrote:
>>>> Hello Jagan, hello Heiko,
>>>>
>>>> When testing U-Boot origin/master on my Raxda Rock Pi 4A serial 
>>>> console output stops after "PMIC:  RK808". The same can be observed 
>>>> with v2025.01.
>>>>
>>>> The serial console works as expected if I disable 
>>>> CONFIG_ROCKCHIP_IODOMAIN.
>>>>
>>>
>>> It is I believe implied here but asking for confirmation. The board 
>>> doesn't actually boot right? It's not that the serial console is 
>>> gone, it's that the device is stuck?
>>
>> Hello Quentin,
>>
>> Thank you for looking into this.
>>
>> The device boots I. But the serial console output becomes mute and I 
>> cannot send keystrokes via the serial console.
>>
> 
> Uh. That is *weird*.
> 
>>>
>>>> The problem seems to be specifically related to the bt656-supply. 
>>>> Removing the line below also fixes serial console output:
>>>>
>>>> diff --git a/drivers/misc/rockchip-io-domain.c b/drivers/misc/ 
>>>> rockchip- io-domain.c
>>>> index a0573c52193..b0d78f2d4b4 100644
>>>> --- a/drivers/misc/rockchip-io-domain.c
>>>> +++ b/drivers/misc/rockchip-io-domain.c
>>>> @@ -239,7 +239,7 @@ static const struct rockchip_iodomain_soc_data 
>>>> soc_data_rk3328 = {
>>>>   static const struct rockchip_iodomain_soc_data soc_data_rk3399 = {
>>>>          .grf_offset = 0xe640,
>>>>          .supply_names = {
>>>> -               "bt656-supply",         /* APIO2_VDD */
> 
> Reading the code and this diff again, this you shouldn't do at all. The 
> offset in the array is the bit offset for the IO domain setting in the 
> GRF at offset 0xe640. So by removing this line, you configured APIO2 IO 
> domain with APIO5 settings (audio-supply).
> 
> It would be better to write NULL instead, so that the others are tried 
> and we can pinpoint the faulty one.
> 
>>>>
>>>
>>> The UART2 (which I assume is the serial you're using for the console) 
>>> isn't on that IO domain. And there doesn't seem to be anything 
>>> important to booting on APIO2 domain according to Rock 4A schematics[1].
>>>
>>> bt656-supply also doesn't seem to be anything special. LDO5 (vcc_3v0) 
>>> on RK808, which is using VCC10 (vcc10-supply) which is a fixed 
>>> regulator whose parent supply is also a fixed regulator. So I am not 
>>> sure what could be going wrong there.
>>
>> In the schema LD05 on the RK808 is connected to VCC_1V5.
>>
> 
> Sorry, I meant to say LDO8.
> 
>> With any of the following values I can enter commands via serial 
>> console but still get no output. So none of the voltages seems to be 
>> the correct one.
>>
>> diff --git a/dts/upstream/src/arm64/rockchip/rk3399-rock-pi-4.dtsi b/ 
>> dts/upstream/src/arm64/rockchip/rk3399-rock-pi-4.dtsi
>> index 046dbe32901..f15b5b63815 100644
>> --- a/dts/upstream/src/arm64/rockchip/rk3399-rock-pi-4.dtsi
>> +++ b/dts/upstream/src/arm64/rockchip/rk3399-rock-pi-4.dtsi
>> @@ -517,7 +517,7 @@
>>
>>   &io_domains {
>>          audio-supply = <&vcca1v8_codec>;
>> -       bt656-supply = <&vcc_3v0>;
>> +       bt656-supply = <&vcc_1v5>;
>> or
>> +       bt656-supply = <&vcc_0v9>;
>> or
>> +       bt656-supply = <&vcc_1v8>;
>>
>>>
>>> RK3399 Puma and RockPro64 have APIO2 set to 1.8V vs 3.0V for Radxa 
>>> Rock 4A. Puma boots master reaches U-Boot CLI with the IO domain 
>>> driver compiled in.
>>>
>>> Can you check the error paths (all the ones with a continue;) in 
>>> rockchip_iodomain_probe()? Which ones do you enter for which supply?
>>>
>>> Not sure where to start debugging tbh.
>>
>> I found the driver by setting CONFIG_LOG=y and log level 7.
>>
>> Here is how the console output ends. Do you have access to a board or 
>> do you need further debug output?
>>
>> ofnode_find_subnode: regulator-state-mem: regulator-state-mem: 
>> regulator-state-mem
>> regulator-state-mem
>> ofnode_read_bool: regulator-off-in-suspend: true
>> ofnode_read_u32_index: regulator-suspend-microvolt: of_read_u32_index: 
>> regulator-suspend-microvolt: (not found)
>> ofnode_read_prop: assigned-clock-rates: <not found>
>> ofnode_read_u32_index: regulator-min-microvolt: of_read_u32_index: 
>> regulator-min-microvolt: (not found)
>> ofnode_read_u32_index: regulator-max-microvolt: of_read_u32_index: 
>> regulator-max-microvolt: (not found)
>> ofnode_read_u32_index: regulator-init-microvolt: of_read_u32_index: 
>> regulator-init-microvolt: (not found)
>> ofnode_read_u32_index: regulator-min-microamp: of_read_u32_index: 
>> regulator-min-microamp: (not found)
>> ofnode_read_u32_index: regulator-max-microamp: of_read_u32_index: 
>> regulator-max-microamp: (not found)
>> ofnode_read_u32_index: regulator-ramp-delay: of_read_u32_index: 
>> regulator-ramp-delay: (not found)
>> ofnode_read_bool: regulator-force-boot-off: false
>> ofnode_find_subnode: regulator-state-mem: regulator-state-mem: 
>> regulator-state-mem
>> regulator-state-mem
>> ofnode_read_bool: regulator-off-in-suspend: true
>> ofnode_read_u32_index: regulator-suspend-microvolt: of_read_u32_index: 
>> regulator-suspend-microvolt: (not found)
>> ofnode_read_prop: assigned-clock-rates: <not found>
>> ofnode_read_u32_index: regulator-min-microvolt: of_read_u32_index: 
>> regulator-min-microvolt: (not found)
>> ofnode_read_u32_index: regulator-max-microvolt: of_read_u32_index: 
>> regulator-max-microvolt: (not found)
>> ofnode_read_u32_index: regulator-init-microvolt: of_read_u32_index: 
>> regulator-init-microvolt: (not found)
>> ofnode_read_u32_index: regulator-min-microamp: of_read_u32_index: 
>> regulator-min-microamp: (not found)
>> ofnode_read_u32_index: regulator-max-microamp: of_read_u32_index: 
>> regulator-max-microamp: (not found)
>> ofnode_read_u32_index: regulator-ramp-delay: of_read_u32_index: 
>> regulator-ramp-delay: (not found)
>> ofnode_read_bool: regulator-force-boot-off: false
>> ofnode_find_subnode: regulator-state-mem: regulator-state-mem: 
>> regulator-state-mem
>> regulator-state-mem
>> ofnode_read_bool: regulator-off-in-suspend: true
>> ofnode_read_u32_index: regulator-suspend-microvolt: of_read_u32_index: 
>> regulator-suspend-microvolt: (not found)
>> ofnode_read_prop: assigned-clock-rates: <not found>
>> ofnode_read_prop: assigned-clock-rates: <not found>
>> ofnode_read_u32_index: bt656-supply: of_read_u32_index: bt656-supply: 
>> 0x7a (122)
>> rockchip_iodomain io-domains: bt656-supply: Regulator LDO_REG8 at 
>> 3000000 uV
>> ofnode_read_u32_index: audio-supply: of_read_u32_index: audio-supply: 
>> 0x91 (145)
>> rockchip_iodomain io-domains: audio-supply: Regulator LDO_REG1 at 
>> 1800000 uV
>> ofnode_read_u32_index: sdmmc-supply: of_read_u32_@L@@p0b@HHb```Hp0 p0   $
>>
> 
> This seems to highlight the issue is rather audio-supply.
> 
> And indeed, audio-supply should be vcc_3v0 and not vcca1v8_codec.
> 

Mmmmmm, upstream kernel has 8240e87f16d1 ("arm64: dts: rockchip: fix 
audio-supply for Rock Pi 4"). So it seems it "fixed" something.

So before I send a revert to the kernel and start an endless thread, can 
you test locally that the following indeed fixes it?

diff --git a/arch/arm/dts/rk3399-rock-pi-4-u-boot.dtsi 
b/arch/arm/dts/rk3399-rock-pi-4-u-boot.dtsi
index 4861574636e..dccc469a507 100644
--- a/arch/arm/dts/rk3399-rock-pi-4-u-boot.dtsi
+++ b/arch/arm/dts/rk3399-rock-pi-4-u-boot.dtsi
@@ -14,6 +14,10 @@
  	};
  };

+&io_domains {
+	audio-supply = <&vcc_3v0>;
+};
+
  &sdhci {
  	cap-mmc-highspeed;
  	mmc-ddr-1_8v;


Cheers,
Quentin
