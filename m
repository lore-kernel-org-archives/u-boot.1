Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F40DCAC5AC
	for <u-boot@archiver.kernel.org>; Wed, 24 Sep 2025 02:12:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29BF883445;
	Wed, 24 Sep 2025 04:12:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="nghyFL1E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 926F480107; Wed, 24 Sep 2025 04:11:58 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A494180107
 for <u-boot@lists.denx.de>; Wed, 24 Sep 2025 04:11:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ye.li@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VAGiWrCuuUOtAZyPDPA0/Kl7rtMr6RSyQ3LvrW+FVQjCconhzetZ0Ade9UBFvSH6abr+iEBLWxtJVxFaIIFoZKRgpGQLKOlfvTDVa6RNbBdPtrnIjD+2I58CxgUbPi5zxtQrDR1hBb6jk0X29bXeV+WD20tWerlHnnnYBItqduIAJKa74RN+oc4kY0d7cFsgqG0Af5nfj7eVdo4DdSBO8U33RN45poLz6LlVmIVnu/dppEI0c0R6cD2tG4NN9j7lo8oxp30xVrMzX98jRXmUvzBObxHsygRc23A6tHMF4f42GSlTHpUuhYamnVJpElOGDVzbMUGLLKHNdSekPk9N0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NyRwGxBE4rxV2lLA6x+SCpT8lTN4rJw/Y8U4BIcihAc=;
 b=D1HL59H5rjxIBM5kIhsAPe8gzA16FaEpg4eO0GACX9GXOjhdm3QFBj4jScOwhiFYP6og4ejPJ2TDADzSrakRJ1d8kGpr/pk1nNG8chTkB3CWfW9ZqlDn+CYWFe5CHVuJLDQVOx7hnlnqZzJGHD17xmdd+fL9LzCMD+n/C9KGrhNtw6qxXG60WuIeTmB8FbmJ8HBp51l64vmb5ZengmJl+FokTEF9jrLd5y9NnJQ1DM1ORbvkNf8YWGxI7HkWAh1kzKiWQmiwB3hNQ++u/32T8ao2uUMQqzxjMd2mWIC+iioQy2OkrvipIqzB4HffLP6l0SD1DFglPyGDNPaiDkPtFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NyRwGxBE4rxV2lLA6x+SCpT8lTN4rJw/Y8U4BIcihAc=;
 b=nghyFL1Ea14y0rhonLK1WzmdoribMPvVls0xgnHTCq9Pnh5Xs41qi0B0yd4/yVi0gg+6hmQU/Mdhic4Ho13QqbZQl9JYfzt0GOrhY2Ya9krvct1Yl3pbOsq5DRi37Mhx/XgpvSI63TyPJkEUVc/rewDEKYspKOEpw/qd1wfZWOoRvQm3Dn3Cl7W92qrZWnbGRCD4VyJfJetESceGQS/3D/A36xWQwgir3mbmGQwTHxMYREXhMvMQgAyKUrstUn6Wpr5QEE+M0HYczTWD/j2TG4b08olzA4+BxlX4mzD5xS4ZS9HpoUradqnSPCrpYJ0NUOIyM4EAvE+YR7AAN7Y14A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com (2603:10a6:20b:4ec::5)
 by AS4PR04MB9459.eurprd04.prod.outlook.com (2603:10a6:20b:4eb::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Wed, 24 Sep
 2025 02:11:55 +0000
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90]) by AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90%7]) with mapi id 15.20.9160.008; Wed, 24 Sep 2025
 02:11:55 +0000
From: Ye Li <ye.li@nxp.com>
To: u-boot@lists.denx.de,
	jagan@amarulasolutions.com,
	festevam@gmail.com
Cc: peng.fan@nxp.com, uboot-imx@nxp.com, alice.guo@nxp.com, ye.li@oss.nxp.com
Subject: [PATCH v2 3/4] spi: nxp_fspi: Support i.MX8DXL flexspi
Date: Wed, 24 Sep 2025 10:11:26 +0800
Message-Id: <20250924021127.2866184-3-ye.li@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250924021127.2866184-1-ye.li@nxp.com>
References: <20250924021127.2866184-1-ye.li@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SGXP274CA0014.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::26)
 To AS4PR04MB9436.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ec::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9436:EE_|AS4PR04MB9459:EE_
X-MS-Office365-Filtering-Correlation-Id: d9caf849-715a-4f48-8936-08ddfb0fbbe5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|42112799006|19092799006|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V1MrVm15am5ackRhMGZUbkI0OStpVkJqYkVXdnY3TngxL2NhTkFmTVNWOWpR?=
 =?utf-8?B?OEoxY1N0bjV6SVZmQS9wdW9IcWlwd1pCMGRvVHlIM25IY29DbE5DUTFTcjBa?=
 =?utf-8?B?TW80T2RkbFMxamVqOFN2ZUtJaXFPRFVuWThBcUVPRFVzUFVQRTJ1WFZzV0xI?=
 =?utf-8?B?Nnc1Vis1cFNQSkMreGRXVkNOSVdRVEhuUm42WUtJMlNQVmVDdDRPOVFCc252?=
 =?utf-8?B?Q1hQWE9Cb0s5N1pYMkx0ei9NZHFIN2RsVGl3V3RlK08zenVjZzJkcjRxOHl5?=
 =?utf-8?B?RTB5QlRXL0svdmtsRC95eFN5dVd3VVhpS3VLMVZsWkk3dnJxeE1TUk8xajhk?=
 =?utf-8?B?ZVVsMUZaNlpHc29QMXB0bmpGYTN0SEpDUGRXRFNoUkkveDJXWCsxWkRuRmla?=
 =?utf-8?B?eUhjZ3M5Z3E3blhYN2RjWmsxZVBJKzV1Zitrd2hReUQ0VXpHbFh4MXlybGg2?=
 =?utf-8?B?S1ZXSFArcUJyeE9DMkNqSUNrSnVjb0ZvU0ZRUGJnVCtUdG0xdm1wanNFOHJE?=
 =?utf-8?B?U0Rqc3hCY1hMM2tLQ3JuZTJicmsxK2VQcWdtQXl4dXVuOGlXbzBFWmpFQ094?=
 =?utf-8?B?NkNWTWxFOEFCZ1QxaTcrNG02M2xiMTQyT0hrdm43VDk3SW5CcXZoNmw4a0Yy?=
 =?utf-8?B?SHpWUXIrS3JPbXNVS2xpcUNpQ1p1b2hQZVRjL2VKbXd1dVJWSlordzdDNDV5?=
 =?utf-8?B?UkVOUUtycE9rVFJObTJaZEFkblQ2cSt0cUpOR2xRWkNWMVlSelROcHVZMWFE?=
 =?utf-8?B?azkzRWVjemx2am40QkVvQjcrSkN0SHNZRWlSYnZ2NVE0cHVzVnZkVnBUTnZT?=
 =?utf-8?B?T2JpNnVsZ3hsbkhDREZZdldGanFKbUdNN0RQZnZlMmtnbzJDcWdqUmRyaUhX?=
 =?utf-8?B?QW16eFh4aFpBUDRjdi9YNU0ySEs4MFIySGlOVUtaNm5jTXlic3g1N25lVVRa?=
 =?utf-8?B?ckFUTEZiWHF5RHkzS24wY2NTRkpwSGFkMkcvSU9VYVoyTmJ1ZGtJRDdzWVIz?=
 =?utf-8?B?U0wyZWRVUTl4RUxEL0xlQ0RHSTN0aVphTnEwWlNiRmVLcWt2NlpkTytUYzhI?=
 =?utf-8?B?NzVQV0g4aHlBNFZYTTVqQVU1cm1mSTljYUdPMWxHU0NTM3N0OTI0d1g1WFZt?=
 =?utf-8?B?ckY2NGgvTk53a1Irck5qU2IzZFpoTWVrcStuVG1Xc081Vk1jVmNuZTFldUVL?=
 =?utf-8?B?VHVmZXZSb2lONDQvd2xYa0xEUU4zOTRvVXNkZ2YvKytPaUQ1bHRGOUpFQytj?=
 =?utf-8?B?Ry9NN3UyUDYyN21yREVMZEJKZzJESWFZVlU2T0Q3bWZqM09MQjlVN0pkVUpI?=
 =?utf-8?B?bk1MZlhJOHdmMU9iVWxBZTIxZE5yOXppVjV1TFc2bGlIWWpLUGN3RXFMMlFK?=
 =?utf-8?B?alZQc3pabXdiQjNwaEhOd251OGllU1d5N1ZJb0liZmQ1THdaTWRmUE9JTUU2?=
 =?utf-8?B?LzhOVXcrNjFITkY3SDE3c04zRFIvWGx1bE1DdmxWazFsN0ZCZW00eFNhVGhh?=
 =?utf-8?B?SHNNbldaZzlwbWtybzF5NmdjcWozendOY2VsUWswc2FFaS85T1BZV0dJSytO?=
 =?utf-8?B?SlFsekJmWmxGMllLUlkzWU5oTGJnaDhGSmUvSC92SGFyb05MOERQVFZwZDVG?=
 =?utf-8?B?ZGFRYlFjM21mZGdjdjk5MHV1Vml5d1VVMmZIY0VhSENJRTNadHFFTE5RU09x?=
 =?utf-8?B?bVkxbklNSzBiOFhpTTlFVzdWV1lYbFNEeGlmZEZDTlRlRjA3Yzl1Z1BYYktx?=
 =?utf-8?B?YlVnbDNJdVF2WjNPVTlCYUlyTzVMNFdnMTJ5bHpsZnNsOGI4cGVBaUpVMTdT?=
 =?utf-8?B?T1VRM29lQkFzRHcvQlBGSUUxMVRJUmlWeEdZZlczOUx4MlhlMHRYL0F1YUtp?=
 =?utf-8?B?UE56bFVhbFNhZzlUSkVQdDBxY3o4MG02MHVGdm1ncFdleXJ1MlBrNmxjaG1w?=
 =?utf-8?B?WHE4a053QzJjaU9LZWM2enZJOTVodTBXNTV5c1F2S0lqaHkxNU1jR0ZreVJJ?=
 =?utf-8?B?YnRzaGRtcDdBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR04MB9436.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(42112799006)(19092799006)(1800799024)(376014)(52116014)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmsxSGlza3hzdXlaYzNKOHNtZXlIclZJdG51dFBVVVlCQXlaNGEvbTFUYjVR?=
 =?utf-8?B?dXpJd29KMXdaR1M0Mmg5dTFUWUk5VElqVURoUnNwR1phdkw1NTY4RitCcG5k?=
 =?utf-8?B?RTJ1RVVVWURBQVBVOENnY080WDhEWUtWTGdxVHdGT0RQWFk1VjdtTGJCRThK?=
 =?utf-8?B?L0k0VWI1eHBvUW90Q1A1dmorZUdLbjNIWklMRXE1NUZma29ybWdKWEltSVlI?=
 =?utf-8?B?cHRhQkNVbDlxNHA0S2lwMTdJNzZSMlpicXNGMFBhT1dsOHdCcWp0cGoxdkVi?=
 =?utf-8?B?WlA5Y3RsR2dyMWJ5SDdSb2N3MDQxOXVaR1FhMksrcVhyRmR3SHFpQ0Q0RURD?=
 =?utf-8?B?b21TS0t6WkQxL2doTkhpZTlUQWlTa3E4R1BPNFpPS1EvZkFlMHlQUjMrOTR3?=
 =?utf-8?B?YXl6bkM2eGN2UEwvVndIRkc0UTRZc3FVOWZ6UGk3RUNZbUpPbFBkaHdWMkRk?=
 =?utf-8?B?UU15ckh1NzVkMFMxaFJrVUpzMEdOWS9rNEE3NmNXSDdTWk5pakhCOEljRXZ2?=
 =?utf-8?B?cXhzWGtVUjRuREJNaFJtOUVSSVJUeGxGenFmUStnbGFKYzBiU1E2R2pmbWph?=
 =?utf-8?B?YzhwUGpXVVlGNExaWjFvdlEyNEpDbjliYit5eFVpUjJ2WDhONDUzYk5TTzAv?=
 =?utf-8?B?bFFaVW01NkxXWHN6TmlGeC8rU1JLYVZoa0ZIanZST2NRaUErSGtrakVxUjQ2?=
 =?utf-8?B?SnpNeE5kS0tRN29MOE9qTFJWU2s2ZEd3TlEzS0dFOGswMmlFM0wxdzJDRmhv?=
 =?utf-8?B?S01RUHgvc3F4S0hEakNQZTdFMllZVjE4a0JYS09VTTJxS09pQnhFVytVWWt5?=
 =?utf-8?B?R04wRm9STlVJaHMzQnBhQTlRbDBkRVptNU0vVURxNnBNSTRLMmFxcmtkNUQw?=
 =?utf-8?B?TzBWemNWbFdzWGxSeFRHRlRZYUVwUEI0TnBzbnc3andraksxbTJaOStORDBN?=
 =?utf-8?B?dWJLZW5ndUFhSlpDUFBkMDBvYVJZeC8rcnpJd2duZGhlWnUrTTlmMWdxY24x?=
 =?utf-8?B?RFkrTWJ4bFE5NCttZUpwTUVrdmsxZFhpQS8rZlB0WFdndy85amtFUjRtNzhi?=
 =?utf-8?B?aTRFUG0rdnovdTVESTJUTjNnUENkNTZFZjU5cndvY3Y5aTk1cjV0UEJmU1VN?=
 =?utf-8?B?UlQ4SFM4YVVNcUdNUUpWeW51NklkbFhlQTc0aEEyQy9kL3Z4aVJqaXRtMmZT?=
 =?utf-8?B?b3dqWFdVM3l5L0dTQndKMlBLcEZVeEFscnIzSkplb0kzcmd3RGFtZ3FYWno1?=
 =?utf-8?B?QlV5cGl1S3ZFUnFXazJjcm9LOGlLalNLNWJUeUtLZVlPb0hqVFpBOXg4QWRR?=
 =?utf-8?B?R2dXYUx4OHdWTFZHRDJiajFOVUZMMi9lcXlYSW1aNUxvZElBMTBrNE10L3M0?=
 =?utf-8?B?UXNGT0hsK2VVcG1ybnZWaTNManNNS3JqRmo5QnRzbTBMdDhtZC8yTmgwNnAx?=
 =?utf-8?B?emJpVng4cnZlaTM0azdPOTJqT0UyWkwwdDVWREVaVzRvY1VMcVI3T2Y2U0pF?=
 =?utf-8?B?T1J0ODFBVVhyWUxFQklIQ0lYdDB5Qm9CaW9HbmthMjk4V0wxY1JUNjhYKzkx?=
 =?utf-8?B?a1RnUE9OdDFBMkJ2c3g2Z3BDYmtjYTUvQmtTSjVOa25HaVd6K2l5SVZaRXhS?=
 =?utf-8?B?TlZBUUZxWWdtbHR5STc4OVF2RERkYzJpd3YrNTBpTTQ5UlJXRjl2YWhKd3p3?=
 =?utf-8?B?U2NyN3JyNFpmaXNFZDNEK3FTeWQrc2J1TEJsdU1OeG55aXFDajhiWG52dlZ0?=
 =?utf-8?B?SW1MYmFYL2ZMSWhQYzVFQjdGSko3K3VoWXhZVlhvR1BwVS9RODcwMGJLTGJm?=
 =?utf-8?B?Qk50NDlIcmlkcnVib2lraUMwNmdqdnFRV05GMFczN1pjM0pzWUtyU3l3QWpB?=
 =?utf-8?B?K2lwMU0vc1BLTnpHVUxHT09DbFJVaisyTnJ0TEI0Nm03SzBveUVScWN4dHYz?=
 =?utf-8?B?TnFvdkRYc1hlSnE1bkV6dG8wTWEwRHlhOVpXemMyU1oyRGh0dC9rWTlqZmt1?=
 =?utf-8?B?QStqM2h1N2hlYVUzWGZ1N1Q3bTY4VTdwS2xGaFlJZ210am42TTNoNVN6SE1O?=
 =?utf-8?B?aEk4OGkyWXJZZGtOMk5kcUZVN1MrVTBwSnhod1NDNkxWb3BDWlVJaEhJSFk3?=
 =?utf-8?Q?65/DtSheETQiXlhLIWoRP1faQ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9caf849-715a-4f48-8936-08ddfb0fbbe5
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9436.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 02:11:55.4300 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7xCO+eEIUuBnuMShtKDeF5xLrO0vwHUJ6pqxxxiz55di6st0cn6cnjKmRZezvdw4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9459
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

According to i.MX8DXL A1 errata ERR050601, concurrent read accesses
from the A35 cores to the peripherals within the LSIO subsystem
(region 0_5DXX_XXXX) and address spaces in the regions
[0_0000_0000 – 0_1BFF_FFFF] and [4_0000_0000 – 4_3FFF_FFFF] can collide
and cause data corruption in the returned data, with no failure report.
Even a single A35 core accessing both these regions can trigger the issue
because an A35 core can have more than one parallel read operation in
progress.

The flexspi0 AHB memory is in LSIO region mentioned in above errata.
So we can't use AHB read, only can read data from FIFO.
Add the compatible string for 8DXL and use a flag for the IPS read.

Signed-off-by: Ye Li <ye.li@nxp.com>
---
 drivers/spi/nxp_fspi.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/spi/nxp_fspi.c b/drivers/spi/nxp_fspi.c
index 6e2aee4672b..3dfb54b1968 100644
--- a/drivers/spi/nxp_fspi.c
+++ b/drivers/spi/nxp_fspi.c
@@ -346,6 +346,15 @@ static const struct nxp_fspi_devtype_data imx8qxp_data = {
 	.little_endian = true,  /* little-endian    */
 };
 
+static const struct nxp_fspi_devtype_data imx8dxl_data = {
+	.rxfifo = SZ_512,       /* (64  * 64 bits)  */
+	.txfifo = SZ_1K,        /* (128 * 64 bits)  */
+	.ahb_buf_size = SZ_2K,  /* (256 * 64 bits)  */
+	.quirks = FSPI_QUIRK_USE_IP_ONLY,
+	.lut_num = 32,
+	.little_endian = true,  /* little-endian    */
+};
+
 struct nxp_fspi {
 	struct udevice *dev;
 	void __iomem *iobase;
@@ -1091,6 +1100,7 @@ static const struct udevice_id nxp_fspi_ids[] = {
 	{ .compatible = "nxp,imx8mm-fspi", .data = (ulong)&imx8mm_data, },
 	{ .compatible = "nxp,imx8mp-fspi", .data = (ulong)&imx8mm_data, },
 	{ .compatible = "nxp,imx8qxp-fspi", .data = (ulong)&imx8qxp_data, },
+	{ .compatible = "nxp,imx8dxl-fspi", .data = (ulong)&imx8dxl_data, },
 	{ .compatible = "nxp,imxrt1170-fspi", .data = (ulong)&imxrt1170_data, },
 	{ }
 };
-- 
2.37.1

