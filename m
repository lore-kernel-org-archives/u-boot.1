Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E219C0219B
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 20:24:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24BA9808AF;
	Sun,  9 Feb 2025 21:24:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=solid-run.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="bMLsyRKb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 04E0080141; Sun,  9 Feb 2025 21:24:16 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2070c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::70c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61BD2807D7
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 21:24:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=solid-run.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=josua@solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WEuuBfObjHu2a+OOznWqcGoHuOPaoXCm/683o7z7KUph6WyDdfSq/F83hKitnh7o/71L6w0ABUpHLzYRimykBrlG0Op6lTPXeLrhdi+MMjg8xLeESBcKdIW9HABXuEiXs7zFasemkzZzlQYW4cyUUDoUw8xHeeEPVobsT6E6AjIdohU2f11cn+FrR/gsy9a8IsqAC7mYqblPRKBkerkvtVNATfQdOrU/E8t0/PbfeatDfAvezHVQjCha3KBuUDJy9DywPJWKMUQx1ECgBICo1YXIL2bPPqsbJwdHxo2+79W4pTvnXNK4ajHlKbctPjMmCMAKXg4FatnuJyElUMKGEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kkVrjjXH2ZghdwpUUmB33oeESUM0H+goL5Ha+eMeUXU=;
 b=eAtPGgSBzWdHTfzBoRgWUoaCRVLp1mX6+iIXOhsiQmMEg2TeChZzmX4t7s2b6Wj1X4d3x1fHw7AS2RyyR038XhD71oJTq/yVvPM+UzPBbkPPBEFTII9d+u5GCED7ot6aQVHH+0Ej1ganS4VeQOVeIoqUnQOZcRBWtEINI1zaH/wyCJbxyW5p1b15fRARem3l5pbTE9jw6Nkmz/pOF3jYwJNdmAazQIEUgN2JwV1YPUVQRVlvn5xYM4UNMw+8MDEVmg0e93kcqOMzJEPVEpfInSrrY3tI1sJo+JLnYXWLWc4pSjA6JUs4FEVP2GqhGEyhCjSaGKNW6uSzTDtYVuSxbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kkVrjjXH2ZghdwpUUmB33oeESUM0H+goL5Ha+eMeUXU=;
 b=bMLsyRKbOhCGnig48Ztt9NHL1zNlo9nXyFpTGnjx/4902NC5PiZVVvu31JjHcmVJYjjfexEg/N3GRypUvSdfe44ckSKsFslT/nB4L/WZf4moRe8VH6TMQ4th6jjD3aHNKO0CZVm4e60OJsP4lQzZRbiq8U5HLM30IljSfkX2t8o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by DB9PR04MB9865.eurprd04.prod.outlook.com (2603:10a6:10:4f0::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Sun, 9 Feb
 2025 20:24:11 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529%6]) with mapi id 15.20.8422.015; Sun, 9 Feb 2025
 20:24:11 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Sun, 09 Feb 2025 21:23:54 +0100
Subject: [PATCH 3/3] board: solidrun: add cn9130 based boards
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250209-cn9130-board-v1-3-b94ab83e141b@solid-run.com>
References: <20250209-cn9130-board-v1-0-b94ab83e141b@solid-run.com>
In-Reply-To: <20250209-cn9130-board-v1-0-b94ab83e141b@solid-run.com>
To: Tom Rini <trini@konsulko.com>, Stefan Roese <sr@denx.de>
Cc: u-boot@lists.denx.de, Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: FRYP281CA0011.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::21)
 To AM9PR04MB7586.eurprd04.prod.outlook.com
 (2603:10a6:20b:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB7586:EE_|DB9PR04MB9865:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d4243cf-35ea-4029-d471-08dd4947b6b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NGk3SkhoaFBtbzdrRkRwcDFlTFJ2U3FpclQwa29JN0E0OXVmOFBtK2ZLblpO?=
 =?utf-8?B?eEJBa2tXWWNmWDdNYWRVMlV1S0U4UUpJY05QdlNHOFIyTXBmajhVbWdsS0Ey?=
 =?utf-8?B?aTRiM2wwY3pHOHNXUkUwNXhRV3E2V2dOUUZYMEdnNVdySEJzay83bXovOElw?=
 =?utf-8?B?dmN1YkZvQ3ZyV25ZeVNod04rc2lNbDIwQzJJOXNNRC9lMXZ5TGRvbnpnZzQx?=
 =?utf-8?B?RGc2QThtZHVqL0JncWo3TXJGNm94RWc2ajg2R2N1eUN2cmE4UGpLaEdIYlZL?=
 =?utf-8?B?QWllci9lKzQrNG10VENmTStObXczR1l3MXI5Vm9QeGYrS2UrU1pRaitXTGNz?=
 =?utf-8?B?Zk1xb2t2WFdMS3BIVEN4cTl3OUtMSi9Pa1h2c3FqeUV2YzZMRjhFKzJPMmh1?=
 =?utf-8?B?QlVSR003RmxBTTErb2FkMG5uVFJveFc5a1A0ZGxsY1ZyVTlMRFFPTkhIUyt1?=
 =?utf-8?B?YVpZNDZBZ3duQmZtTnc0TEZ6SE5rV3NCeldiVVlvbkhYTUZoamxNbEdmT3pE?=
 =?utf-8?B?V1lBeThtZjlDN2loSCttZkdCM1NxVUpsNHJ1cVU4eStwdWN2RmFxOHRRLzBn?=
 =?utf-8?B?YVhzQ0RadEx3SDh3V2hTNHEwOHExbGlLancvNENVQ3FhWVRJT1lxL1ZZelo2?=
 =?utf-8?B?UmRlRGRSaUlCVk1zV1d2U05qZ0Q0SEVtK3ppK0p0VE9rMjVHSElVL1lBYUp2?=
 =?utf-8?B?bCsyZ1ArNlRITGsvMzN5MndFZnN3bVNxSWtYdVo0Y3A3bnYwVVhwNC9EMHc1?=
 =?utf-8?B?Q0JiaXlRZndCUjh5SjhwN2dZT09aWndzQllzTHM3dE1WZVBBUHZJeVc2UzY5?=
 =?utf-8?B?N1lsMVdySHp6T1hhek16am4xOExVRkdsUytaNDJVQmhYTDZNdVlZdGVFNDln?=
 =?utf-8?B?MEpaUm90QVdia0kwcDRiU01HL1VSQUY5NExLWDZ2eWt5WGhjVG1lbWVHZW83?=
 =?utf-8?B?RzVkTS81cHA0V25qeExWYWI5aC9oOXRsdWRSMG1GaTdUL2VPak84dkZJbnlo?=
 =?utf-8?B?bnZsWTBkZXBLVG5xZkxnVUZLTEdIeFVtMjhkd3FtVjZlTVF5T3JxL25kbnB0?=
 =?utf-8?B?NnhSN0FyOFM5TEZobFNiZDBsNXpZQ1JnaEVZcm83L2ZsdjJxSllUQlVnaHJa?=
 =?utf-8?B?REZwZ1Q2RVRtbVQvSHZiR1pZSWJNb05meGFJUVVvMW4zd0xHdXlSM2hTbU45?=
 =?utf-8?B?dEJSdWNYOG1MWC9ZYzNXVDlBczR2MmpRMUJRb2ZoL29ESllLbHMyWTRITEZ4?=
 =?utf-8?B?NG1SZWFBOHZUQzNXMURlOUY4MXhaRE1LbElsZ2s3ak5SRHQ2dEVDdXVzcFc4?=
 =?utf-8?B?QWExVEtNeE5oaytLUkpFSjZBeG54aXdtQkJ2Q0U4VytsbWllNU9ya1N0NUNQ?=
 =?utf-8?B?WTJLQWErRTNBdmdkanlzajBIeEY0MnVxSUozZHpaemRseUgyYjM2UnFyWnR1?=
 =?utf-8?B?akprd2czVEpRbkFhUmdKdm4vdFdpaWtXS0ZZTlBqZm5qYm1zZHRsUHJQV2NV?=
 =?utf-8?B?ODEyb3BnRVZUVVFMRk1JRlJpeHJldVlyd1B6STRiZGdOUWtkc3ZDV2hZM1p1?=
 =?utf-8?B?MmRjOWFzWTRmT1YrcXVQRW11WkVnbXkxUzd5K093c0U0V1l3V2FzdUZBMzNY?=
 =?utf-8?B?czdaR0tzVFZCbXpjZDhzWndEclRkaUJVRndNL0M1WWZEbTRBcjJWdVlvYXBj?=
 =?utf-8?B?S09IVzdYZXF1aVZoRGp5OG5LcldrNzBQUXlqeFgyVlpGWE0wVmV4TGg4bncr?=
 =?utf-8?B?amg0YWRacXJsMGNtcE5ZUHY2SnpSUld2Q2o5b1FqK3hlMXd0RGR4K2xMczNv?=
 =?utf-8?B?MkUzQ3RPNW1uenRlN0N2YS93YS94R2V1ZjFXM2YwejFlOGVvbzM2VTlaSFVO?=
 =?utf-8?B?V3VPdDlkajZjTjhZaFFoZlZHc1lGL2U4TzYvck1sVWt5eXRvek96eEFnbVFi?=
 =?utf-8?Q?FrOFlKF/uY1oPpMu0KpoY5APFh/MnY3y?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB7586.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(52116014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NitkV0VVNFJ1MDdBK0FyVURNanlkUVh0TmdKdElIRGhENHlJdUhUaDdkODY2?=
 =?utf-8?B?bU1EWG1VMHdPTlU5b01KQlRLajJHcUlGU2tDaTR5eXYxSnVRVWZMcXFQZmNF?=
 =?utf-8?B?c1ZYcUNxL2pIVXdKcUdubVZ0K0tFU254SGVNbHlQdlZsQUI3V2FhVXhQVTJ6?=
 =?utf-8?B?VGxVanZSTjd3cWNLY2x0d2QyamVDK2tINVZyYkR2ZU1uaHNSUy9tZWxQR3Uy?=
 =?utf-8?B?aitMN2Z2TDZndnBsL3kxWnZUaC9Fc1F5clhnL0FvV3JiTUZQUnlDcUY5cStt?=
 =?utf-8?B?T2doaVdWUFhySktvTkFaSlo4UE5QSXJGekhoakVPbVd1NWNRak1DT2p3YlVX?=
 =?utf-8?B?T0tSWVNqMTJUTGJoUDBvYjlMVzhuT09wSGRZU3U0bll6NGVXZGJiKys1QkNY?=
 =?utf-8?B?RlBTQ0F5Sm8yQXp2S3k3TnVmaitUL2JNS0R6bVZVVzZkRzFFbkYrVFp6WDZw?=
 =?utf-8?B?bUduc2czRG95Y1hhdUZUS00rbDdkbTRUd0VESm05dHd3TGpnRGtYZVZCRExW?=
 =?utf-8?B?eDJVZUgyYVE3TXlBclRQUk5oVnVlQnhhRXRvaFdjMXVpRDhSeVVuNU0yTVR6?=
 =?utf-8?B?a2k1UUxnL09pbzRTMXpCTzJnb2pKYTgzNUJqTXJCYkJPcWdBTG9WTm1ZSWJu?=
 =?utf-8?B?NjlJOVE3UTQ5K0dVWllYb2pLSXVaRy9VZjlaNXFJNFJ5Y3d4L3FaME9yZ25S?=
 =?utf-8?B?aTFMeXhIVE5Vdk5TekdoMkpDRUJTU0o0ZEJrWjJTOGFpdEUxQlAvSzkyRi80?=
 =?utf-8?B?RHhaOTgwWlM2SHBhbU1LZ1UzdGlML3Z3WkNtMlRmalp0S0RLWmtVTy9iT0dT?=
 =?utf-8?B?aDI4UEhaRGVrTUEzcGFKOWQ3UWFxLy9YQnV0MVhpeDYxTlIwcXh3T21JREk3?=
 =?utf-8?B?YXdZZGNBRWsxaTdta0oxNXNEZm1WYlBSaUxDd3p2Y3ZySXpmRXRWS3hlcDEx?=
 =?utf-8?B?T2ZhNDhmanFqTzgvQUwyTWUrU3Z1OTdJMkpqTldqbU9YdWFObVBFalludFFp?=
 =?utf-8?B?ak5MN2c0WURuMWxISk85UXVLRi9OcWtlRi9ZangrZy9zRkkvM1k0T0VhUmVE?=
 =?utf-8?B?ZG1xV0VhbjZvR1d0eWpSZkpoUWoxQmQzeTcwSTRWM1ZKbEx2MGtGdE16SzBN?=
 =?utf-8?B?eTdhYXgwSnJZa3RUUXlHRzAwQ3lzdzFxZHhQNFNOYUw4eGZZeUtSU1h4eUJs?=
 =?utf-8?B?QStUQ2lCOWtFOTcxYmNWRG1NcFNzSUlMZFVCTkk4ZzBzSXZPbVZhTldna0hR?=
 =?utf-8?B?TyttTFdCejV5eHNBQUphcUwxYlZOZ2E1Mit5bFRaUjBKVEJnN2xEQXRwbG1J?=
 =?utf-8?B?MW5pWkJzMmVMcld6NFdnd2syVnEzUEQwRytnc0cyUUMwRVNBTmhNQjNMLzQy?=
 =?utf-8?B?bTB1aUlLczZGZVl4djdZWmQ5a1RTNElBWWZ6OWpwL2VBYXo3NS8vRHRDSXpK?=
 =?utf-8?B?a0N6cUhGVy93SWR0RmtGTkNNbzBpQlZ0WmtuVURnUmRBdHdJQ1B2TEk5eThC?=
 =?utf-8?B?VDBRY2p0ZS9lTzZObWlMOUhMZUhQOXZyMWtSU0pIdEZNVUcvSmwzVUVsc3NT?=
 =?utf-8?B?cllic2R3S3lKNC9kOWZ6YTJWZFF2cmFzQWUyR2U3c1ArRFZmWm9YdXoxV2U0?=
 =?utf-8?B?Tkk1STcycVlDU1FVM3JKSExVTWlhMk1WZmpRSXZjay9FdDFxZ1cvOE81SSsw?=
 =?utf-8?B?NGptRWVVU3NkSENSZTRZWEtVc1Y2MVJtaWR6eCs2cWJwMDdhZmI2Vm1oODMv?=
 =?utf-8?B?SGZBRWdrb3dIeDcrQzZxcWdDNlF3b21yTWVhcmZqbWVHejhBS3V1V2RHQWE1?=
 =?utf-8?B?N3YrUWdZd3FGUW5xQUdoT24zZlllOGRxREg5RzBORFA4c3IyUWwyRFhCbjFy?=
 =?utf-8?B?ZmxNTHYvOVNPTm5MbVVodzJZOEVKNmVZN0ZLQndQMGYvUXFJWGJ1THNvdVVZ?=
 =?utf-8?B?NmdsVWJ4NFVQYnV4bllCdDZOams2Tm9XNTNBbnBMdWY3RGJ4eFgrakZ6K0cx?=
 =?utf-8?B?TVRlNlIvVFozenc4Qzdyb3pSbWZRc01OMFlNeHU3N2tjK2lROU5seHNNcmRY?=
 =?utf-8?B?VFg0d3k5NFBEUG1mcWhBNUIxOXVZMndCbHRQMUJueHl5RTBpZUYyc1hWcWpX?=
 =?utf-8?Q?pkdV24g2eK8t1rCFAVipyxZ6G?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d4243cf-35ea-4029-d471-08dd4947b6b3
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2025 20:24:11.4473 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hs6UQALZ8iffrEPe6q4wo4w67ybaC92i+S0sgVTfuwnHPLqnvlZXX2YvWoYiTV+x8dyLk7zZ/gVOxMiNWWrVAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9865
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

Add a new solidrun board "octeontx2_cn913x" for all boards designed with
Marvell CN9130 SoC:

- CN9130 Clearfog Base
- CN9130 Clearfog Pro
- CN9131 SolidWAN
- CN9132 Clearfog

The boards can share a lot of common code differing only in
device-tree.

This initial support is limited to:
- GPIO
- RTC
- USB
- PCI
- microSD
- SerDes configuration
and can boot to Linux.

Notably not functional are:
- Ethernet
- SPI Flash
- eMMC

These boards are supported by upstream dts which requires a fair number
of quirks to work with existing u-boot drivers. These are described in
*-u-boot.dtsi files.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 arch/arm/dts/cn9130-cf-base-u-boot.dtsi     |  15 ++
 arch/arm/dts/cn9130-cf-pro-u-boot.dtsi      |  24 +++
 arch/arm/dts/cn9130-cf-u-boot.dtsi          |  52 ++++++
 arch/arm/dts/cn9130-sr-som-u-boot.dtsi      | 122 +++++++++++++
 arch/arm/dts/cn9131-cf-solidwan-u-boot.dtsi |  91 ++++++++++
 arch/arm/dts/cn9132-clearfog-u-boot.dtsi    |  79 +++++++++
 arch/arm/dts/cn9132-sr-cex7-u-boot.dtsi     | 265 ++++++++++++++++++++++++++++
 arch/arm/mach-mvebu/Kconfig                 |  11 ++
 board/solidrun/octeontx2_cn913x/Kconfig     |  33 ++++
 board/solidrun/octeontx2_cn913x/Makefile    |   8 +
 board/solidrun/octeontx2_cn913x/board.c     |  40 +++++
 configs/cn9130_clearfog_defconfig           |  77 ++++++++
 12 files changed, 817 insertions(+)

diff --git a/arch/arm/dts/cn9130-cf-base-u-boot.dtsi b/arch/arm/dts/cn9130-cf-base-u-boot.dtsi
new file mode 100644
index 0000000000000000000000000000000000000000..6e10fdb54fd0071efbfed48fca3ee42fafb9f804
--- /dev/null
+++ b/arch/arm/dts/cn9130-cf-base-u-boot.dtsi
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2025 Josua Mayer <josua@solid-run.com>
+ *
+ */
+
+#include "cn9130-cf-u-boot.dtsi"
+
+&cp0_comphy4 {
+	phy-type = <COMPHY_TYPE_USB3_HOST1>;
+};
+
+&cp0_utmi1 {
+	status = "okay";
+};
diff --git a/arch/arm/dts/cn9130-cf-pro-u-boot.dtsi b/arch/arm/dts/cn9130-cf-pro-u-boot.dtsi
new file mode 100644
index 0000000000000000000000000000000000000000..90a7f5f182673a0f9f2f34fd41f45c113073167d
--- /dev/null
+++ b/arch/arm/dts/cn9130-cf-pro-u-boot.dtsi
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2025 Josua Mayer <josua@solid-run.com>
+ *
+ */
+
+#include "cn9130-cf-u-boot.dtsi"
+
+&cp0_comphy4 {
+	phy-type = <COMPHY_TYPE_PEX1>;
+};
+
+&cp0_pcie1 {
+	/*
+	 * Unlike the Linux dw-pcie driver, u-boot pcie_dw_mvebu
+	 * uses non-standard "marvell,reset-gpio" property
+	 * and does not invert polarity internally.
+	 */
+	marvell,reset-gpio = <&expander0 2 GPIO_ACTIVE_LOW>;
+};
+
+&cp0_utmi1 {
+	status = "okay";
+};
diff --git a/arch/arm/dts/cn9130-cf-u-boot.dtsi b/arch/arm/dts/cn9130-cf-u-boot.dtsi
new file mode 100644
index 0000000000000000000000000000000000000000..ad728e58595d929182db57abb3d25e69ea3a94c0
--- /dev/null
+++ b/arch/arm/dts/cn9130-cf-u-boot.dtsi
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2025 Josua Mayer <josua@solid-run.com>
+ *
+ */
+
+#include <dt-bindings/comphy/comphy_data.h>
+
+#include "cn9130-sr-som-u-boot.dtsi"
+
+/* Changes for cn9130-cf.dtsi */
+
+&cp0_comphy0 {
+	phy-type = <COMPHY_TYPE_SATA1>;
+};
+
+&cp0_comphy1 {
+	phy-type = <COMPHY_TYPE_USB3_HOST0>;
+};
+
+&cp0_comphy2 {
+	phy-type = <COMPHY_TYPE_SFI0>;
+	phy-speed = <COMPHY_SPEED_10_3125G>;
+};
+
+&cp0_comphy3 {
+	phy-type = <COMPHY_TYPE_SGMII1>;
+	phy-speed = <COMPHY_SPEED_1_25G>;
+};
+
+&cp0_comphy5 {
+	phy-type = <COMPHY_TYPE_PEX2>;
+};
+
+&cp0_pcie2 {
+	/*
+	 * Unlike the Linux dw-pcie driver, u-boot pcie_dw_mvebu
+	 * uses non-standard "marvell,reset-gpio" property
+	 * and does not invert polarity internally.
+	 */
+	marvell,reset-gpio = <&expander0 1 GPIO_ACTIVE_LOW>;
+};
+
+&cp0_utmi0 {
+	status = "okay";
+};
+
+&reg_usb3_vbus0 {
+	/* upstream dts gpio polarity is wrong */
+	gpios = <&expander0 6 GPIO_ACTIVE_HIGH>;
+	enable-active-high;
+};
diff --git a/arch/arm/dts/cn9130-sr-som-u-boot.dtsi b/arch/arm/dts/cn9130-sr-som-u-boot.dtsi
new file mode 100644
index 0000000000000000000000000000000000000000..cdc01692c09e0e35bbd74ca69569161c8e6f52e2
--- /dev/null
+++ b/arch/arm/dts/cn9130-sr-som-u-boot.dtsi
@@ -0,0 +1,122 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2025 Josua Mayer <josua@solid-run.com>
+ *
+ */
+
+/* Changes for armada-ap807.dtsi and its parents */
+
+/ {
+	/*
+	 * U-Boot does not (yet) have a driver for compatible
+	 * "marvell,ap807-clock" used by upstream device-tree.
+	 * For now define required clocks using fixed-clock.
+	 */
+	ap_mss_clk: ap-mss-clock {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <200000000>;
+	};
+};
+
+&ap_sdhci0 {
+	/*
+	 * U-Boot does not (yet) support compatible string
+	 * "marvell,armada-ap806-sdhci" used by upstream device-tree.
+	 * Add fall-back matching existing u-boot driver.
+	 */
+	compatible = "marvell,armada-ap806-sdhci", "marvell,armada-8k-sdhci";
+};
+
+&uart0 {
+	/*
+	 * The ns16550_serial u-boot driver requires a valid clock
+	 * handle to enable the console uart.
+	 * Link the fixed clock defined above due to lack of dedicated
+	 * ap807-clock driver.
+	 */
+	clocks = <&ap_mss_clk>;
+};
+
+/* Changes for armada-cp115.dtsi and its parents */
+
+&cp0_comphy {
+	/*
+	 * Add compatible, register and additional properties
+	 * for U-Boot mvebu_comphy driver.
+	 */
+	compatible = "marvell,comphy-cp110", "marvell,mvebu-comphy";
+	reg = <0x441000 0x8>,
+	      <0x120000 0x8>;
+	mux-bitcount = <4>;
+	max-lanes = <6>;
+};
+
+&cp0_sdhci0 {
+	/*
+	 * U-Boot does not (yet) support compatible string
+	 * "marvell,armada-cp110-sdhci" used by upstream device-tree.
+	 * Add fall-back matching existing u-boot driver.
+	 */
+	compatible = "marvell,armada-cp110-sdhci", "marvell,armada-8k-sdhci";
+};
+
+&cp0_utmi {
+	/delete-property/ marvell,system-controller;
+	compatible = "marvell,mvebu-utmi";
+	reg = <0x580000 0xc>; /* utmi-common-pll */
+	#size-cells = <1>;
+};
+
+&cp0_utmi0 {
+	/*
+	 * U-Boot does not (yet) have a driver for compatible
+	 * "marvell,mvebu-utmi" used by upstream device-tree
+	 * on parent cp0_utmi node.
+	 * Add description for legacy driver.
+	 */
+	/delete-property/ #phy-cells;
+	compatible = "marvell,mvebu-utmi-2.6.0";
+	reg = <0x58000c 0x100>,/* utmi-unit */
+	      <0x440420 0x4>,	/* usb-cfg */
+	      <0x440440 0x4>;	/* utmi-cfg */
+	utmi-port = <UTMI_PHY_TO_USB3_HOST0>;
+	status = "disabled";
+};
+
+&cp0_utmi1 {
+	/*
+	 * U-Boot does not (yet) have a driver for compatible
+	 * "marvell,mvebu-utmi" used by upstream device-tree
+	 * on parent cp0_utmi node.
+	 * Add description for legacy driver.
+	 */
+	/delete-property/ #phy-cells;
+	compatible = "marvell,mvebu-utmi-2.6.0";
+	reg = <0x58100c 0x100>,/* utmi-unit */
+	      <0x440420 0x4>,	/* usb-cfg */
+	      <0x440440 0x4>;	/* utmi-cfg */
+	utmi-port = <UTMI_PHY_TO_USB3_HOST1>;
+	status = "disabled";
+};
+
+/* Changes for cn9130-sr-som.dtsi */
+
+&ap_sdhci0 {
+	/* avoid xenon_sdhci driver trying to configure fixed-regulator */
+	/delete-property/ vqmmc-supply;
+	/* ap mmc voltage domain is fixed 1.8V */
+	marvell,pad-type = "fixed-1-8v";
+};
+
+&cp0_pinctrl {
+	/*
+	 * U-Boot does not (yet) have a driver for compatible
+	 * "marvell,cp115-standalone-pinctrl" used by upstream device-tree.
+	 * Add legacy description for generic mvebu pinctrl driver.
+	 */
+	compatible = "marvell,mvebu-pinctrl";
+	reg = <0x440000 0x20>;
+	pin-count = <63>;
+	max-func = <0xf>;
+};
diff --git a/arch/arm/dts/cn9131-cf-solidwan-u-boot.dtsi b/arch/arm/dts/cn9131-cf-solidwan-u-boot.dtsi
new file mode 100644
index 0000000000000000000000000000000000000000..64074fec705762790dd0c9d5dab837b96d4569db
--- /dev/null
+++ b/arch/arm/dts/cn9131-cf-solidwan-u-boot.dtsi
@@ -0,0 +1,91 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2025 Josua Mayer <josua@solid-run.com>
+ *
+ */
+
+#include <dt-bindings/comphy/comphy_data.h>
+
+#include "cn9130-sr-som-u-boot.dtsi"
+
+/* Changes for armada-cp115.dtsi and its parents */
+
+&cp1_comphy {
+	compatible = "marvell,comphy-cp110", "marvell,mvebu-comphy";
+	reg = <0x441000 0x8>,
+	      <0x120000 0x8>;
+	mux-bitcount = <4>;
+	max-lanes = <6>;
+};
+
+&cp1_sdhci0 {
+	compatible = "marvell,armada-cp110-sdhci", "marvell,armada-8k-sdhci";
+};
+
+/* Changes for cn9131-cf-solidwan.dtsi */
+
+&cp0_comphy0 {
+	phy-type = <COMPHY_TYPE_PEX0>;
+};
+
+&cp0_comphy1 {
+	phy-type = <COMPHY_TYPE_SGMII2>;
+	phy-speed = <COMPHY_SPEED_1_25G>;
+};
+
+&cp0_comphy2 {
+	phy-type = <COMPHY_TYPE_SFI0>;
+	phy-speed = <COMPHY_SPEED_10_3125G>;
+};
+
+&cp0_comphy3 {
+	phy-type = <COMPHY_TYPE_SGMII1>;
+	phy-speed = <COMPHY_SPEED_1_25G>;
+};
+
+&cp0_comphy4 {
+	phy-type = <COMPHY_TYPE_USB3_HOST1>;
+};
+
+&cp0_comphy5 {
+	phy-type = <COMPHY_TYPE_PEX2>;
+};
+
+&cp0_utmi0 {
+	status = "okay";
+};
+
+&cp1_comphy0 {
+	phy-type = <COMPHY_TYPE_PEX0>;
+};
+
+&cp1_comphy1 {
+	phy-type = <COMPHY_TYPE_SATA1>;
+};
+
+&cp1_comphy2 {
+	phy-type = <COMPHY_TYPE_USB3_HOST0>;
+};
+
+&cp1_comphy3 {
+	phy-type = <COMPHY_TYPE_SGMII1>;
+	phy-speed = <COMPHY_SPEED_1_25G>;
+};
+
+&cp1_comphy4 {
+	phy-type = <COMPHY_TYPE_SFI0>;
+	phy-speed = <COMPHY_SPEED_10_3125G>;
+};
+
+&cp1_comphy5 {
+	phy-type = <COMPHY_TYPE_SGMII2>;
+	phy-speed = <COMPHY_SPEED_1_25G>;
+};
+
+&cp1_utmi0 {
+	status = "okay";
+};
+
+&cp1_utmi1 {
+	status = "okay";
+};
diff --git a/arch/arm/dts/cn9132-clearfog-u-boot.dtsi b/arch/arm/dts/cn9132-clearfog-u-boot.dtsi
new file mode 100644
index 0000000000000000000000000000000000000000..1bcec3aead7c3763842f5868c9303f0139c44ead
--- /dev/null
+++ b/arch/arm/dts/cn9132-clearfog-u-boot.dtsi
@@ -0,0 +1,79 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2025 Josua Mayer <josua@solid-run.com>
+ *
+ */
+
+#include "cn9132-sr-cex7-u-boot.dtsi"
+
+&cp0_comphy0 {
+	phy-type = <COMPHY_TYPE_PEX0>;
+};
+
+&cp0_comphy1 {
+	phy-type = <COMPHY_TYPE_PEX0>;
+};
+
+&cp0_comphy2 {
+	phy-type = <COMPHY_TYPE_PEX0>;
+};
+
+&cp0_comphy3 {
+	phy-type = <COMPHY_TYPE_PEX0>;
+};
+
+&cp0_comphy4 {
+	phy-type = <COMPHY_TYPE_SFI0>;
+	phy-speed = <COMPHY_SPEED_10_3125G>;
+};
+
+&cp0_comphy5 {
+	phy-type = <COMPHY_TYPE_SGMII2>;
+	phy-speed = <COMPHY_SPEED_1_25G>;
+};
+
+&cp1_comphy0 {
+	phy-type = <COMPHY_TYPE_PEX0>;
+};
+
+&cp1_comphy1 {
+	phy-type = <COMPHY_TYPE_PEX0>;
+};
+
+&cp1_comphy2 {
+	phy-type = <COMPHY_TYPE_SFI0>;
+	phy-speed = <COMPHY_SPEED_5_15625G>;
+};
+
+&cp1_comphy3 {
+	phy-type = <COMPHY_TYPE_SATA1>;
+};
+
+&cp1_comphy4 {
+	phy-type = <COMPHY_TYPE_PEX1>;
+};
+
+&cp1_comphy5 {
+	phy-type = <COMPHY_TYPE_PEX2>;
+};
+
+&cp2_comphy0 {
+	phy-type = <COMPHY_TYPE_PEX0>;
+};
+
+&cp2_comphy2 {
+	phy-type = <COMPHY_TYPE_SFI0>;
+	phy-speed = <COMPHY_SPEED_5_15625G>;
+};
+
+&cp2_comphy3 {
+	phy-type = <COMPHY_TYPE_SATA1>;
+};
+
+&cp2_comphy4 {
+	phy-type = <COMPHY_TYPE_PEX1>;
+};
+
+&cp2_comphy5 {
+	phy-type = <COMPHY_TYPE_PEX2>;
+};
diff --git a/arch/arm/dts/cn9132-sr-cex7-u-boot.dtsi b/arch/arm/dts/cn9132-sr-cex7-u-boot.dtsi
new file mode 100644
index 0000000000000000000000000000000000000000..398da325a61c9419c89369de24e58d6fe917d897
--- /dev/null
+++ b/arch/arm/dts/cn9132-sr-cex7-u-boot.dtsi
@@ -0,0 +1,265 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2025 Josua Mayer <josua@solid-run.com>
+ *
+ */
+
+#include <dt-bindings/comphy/comphy_data.h>
+
+/* Changes for armada-ap807.dtsi and its parents */
+
+/ {
+	/*
+	 * U-Boot does not (yet) have a driver for compatible
+	 * "marvell,ap807-clock" used by upstream device-tree.
+	 * For now define required clocks using fixed-clock.
+	 */
+	ap_mss_clk: ap-mss-clock {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <200000000>;
+	};
+};
+
+&ap_sdhci0 {
+	/*
+	 * U-Boot does not (yet) support compatible string
+	 * "marvell,armada-ap806-sdhci" used by upstream device-tree.
+	 * Add fall-back matching existing u-boot driver.
+	 */
+	compatible = "marvell,armada-ap806-sdhci", "marvell,armada-8k-sdhci";
+};
+
+&uart0 {
+	/*
+	 * The ns16550_serial u-boot driver requires a valid clock
+	 * handle to enable the console uart.
+	 * Link the fixed clock defined above due to lack of dedicated
+	 * ap807-clock driver.
+	 */
+	clocks = <&ap_mss_clk>;
+};
+
+/* Changes for armada-cp115.dtsi and its parents */
+
+&cp0_comphy {
+	/*
+	 * Add compatible, register and additional properties
+	 * for U-Boot mvebu_comphy driver.
+	 */
+	compatible = "marvell,comphy-cp110", "marvell,mvebu-comphy";
+	reg = <0x441000 0x8>,
+	      <0x120000 0x8>;
+	mux-bitcount = <4>;
+	max-lanes = <6>;
+};
+
+&cp0_sdhci0 {
+	/*
+	 * U-Boot does not (yet) support compatible string
+	 * "marvell,armada-cp110-sdhci" used by upstream device-tree.
+	 * Add fall-back matching existing u-boot driver.
+	 */
+	compatible = "marvell,armada-cp110-sdhci", "marvell,armada-8k-sdhci";
+};
+
+&cp0_utmi0 {
+	/*
+	 * U-Boot does not (yet) have a driver for compatible
+	 * "marvell,mvebu-utmi" used by upstream device-tree
+	 * on parent cp0_utmi node.
+	 * Add description for legacy driver.
+	 */
+	/delete-property/ #phy-cells;
+	compatible = "marvell,mvebu-utmi-2.6.0";
+	reg = <0x58000c 0x100>,/* utmi-unit */
+	      <0x440420 0x4>,	/* usb-cfg */
+	      <0x440440 0x4>;	/* utmi-cfg */
+	utmi-port = <UTMI_PHY_TO_USB3_HOST0>;
+	status = "disabled";
+};
+
+&cp0_utmi1 {
+	/*
+	 * U-Boot does not (yet) have a driver for compatible
+	 * "marvell,mvebu-utmi" used by upstream device-tree
+	 * on parent cp0_utmi node.
+	 * Add description for legacy driver.
+	 */
+	/delete-property/ #phy-cells;
+	compatible = "marvell,mvebu-utmi-2.6.0";
+	reg = <0x58100c 0x100>,/* utmi-unit */
+	      <0x440420 0x4>,	/* usb-cfg */
+	      <0x440440 0x4>;	/* utmi-cfg */
+	utmi-port = <UTMI_PHY_TO_USB3_HOST1>;
+	status = "disabled";
+};
+
+&cp1_comphy {
+	compatible = "marvell,comphy-cp110", "marvell,mvebu-comphy";
+	reg = <0x441000 0x8>,
+	      <0x120000 0x8>;
+	mux-bitcount = <4>;
+	max-lanes = <6>;
+};
+
+&cp1_sdhci0 {
+	compatible = "marvell,armada-cp110-sdhci", "marvell,armada-8k-sdhci";
+};
+
+&cp1_utmi0 {
+	/*
+	 * U-Boot does not (yet) have a driver for compatible
+	 * "marvell,mvebu-utmi" used by upstream device-tree
+	 * on parent cp0_utmi node.
+	 * Add description for legacy driver.
+	 */
+	/delete-property/ #phy-cells;
+	compatible = "marvell,mvebu-utmi-2.6.0";
+	reg = <0x58000c 0x100>,/* utmi-unit */
+	      <0x440420 0x4>,	/* usb-cfg */
+	      <0x440440 0x4>;	/* utmi-cfg */
+	utmi-port = <UTMI_PHY_TO_USB3_HOST0>;
+	status = "disabled";
+};
+
+&cp1_utmi1 {
+	/*
+	 * U-Boot does not (yet) have a driver for compatible
+	 * "marvell,mvebu-utmi" used by upstream device-tree
+	 * on parent cp0_utmi node.
+	 * Add description for legacy driver.
+	 */
+	/delete-property/ #phy-cells;
+	compatible = "marvell,mvebu-utmi-2.6.0";
+	reg = <0x58100c 0x100>,/* utmi-unit */
+	      <0x440420 0x4>,	/* usb-cfg */
+	      <0x440440 0x4>;	/* utmi-cfg */
+	utmi-port = <UTMI_PHY_TO_USB3_HOST1>;
+	status = "disabled";
+};
+
+&cp2_comphy {
+	compatible = "marvell,comphy-cp110", "marvell,mvebu-comphy";
+	reg = <0x441000 0x8>,
+	      <0x120000 0x8>;
+	mux-bitcount = <4>;
+	max-lanes = <6>;
+};
+
+&cp2_sdhci0 {
+	compatible = "marvell,armada-cp110-sdhci", "marvell,armada-8k-sdhci";
+};
+
+&cp2_utmi0 {
+	/*
+	 * U-Boot does not (yet) have a driver for compatible
+	 * "marvell,mvebu-utmi" used by upstream device-tree
+	 * on parent cp0_utmi node.
+	 * Add description for legacy driver.
+	 */
+	/delete-property/ #phy-cells;
+	compatible = "marvell,mvebu-utmi-2.6.0";
+	reg = <0x58000c 0x100>,/* utmi-unit */
+	      <0x440420 0x4>,	/* usb-cfg */
+	      <0x440440 0x4>;	/* utmi-cfg */
+	utmi-port = <UTMI_PHY_TO_USB3_HOST0>;
+	status = "disabled";
+};
+
+&cp2_utmi1 {
+	/*
+	 * U-Boot does not (yet) have a driver for compatible
+	 * "marvell,mvebu-utmi" used by upstream device-tree
+	 * on parent cp0_utmi node.
+	 * Add description for legacy driver.
+	 */
+	/delete-property/ #phy-cells;
+	compatible = "marvell,mvebu-utmi-2.6.0";
+	reg = <0x58100c 0x100>,/* utmi-unit */
+	      <0x440420 0x4>,	/* usb-cfg */
+	      <0x440440 0x4>;	/* utmi-cfg */
+	utmi-port = <UTMI_PHY_TO_USB3_HOST1>;
+	status = "disabled";
+};
+
+/* Changes for cn9132-sr-cex7.dtsi */
+
+&ap_sdhci0 {
+	/* avoid xenon_sdhci driver trying to configure fixed-regulator */
+	/delete-property/ vqmmc-supply;
+	/* ap mmc voltage domain is fixed 1.8V */
+	marvell,pad-type = "fixed-1-8v";
+};
+
+&cp0_gpio1 {
+	status = "okay";
+
+	/*
+	 * Tacho signal used as interrupt source by pwm-fan driver.
+	 * Hog IO as input to ensure mvebu-gpio irq driver`s
+	 * irq_set_type can succeed.
+	 */
+	pwm-tacho-irq-hog {
+		gpio-hog;
+		gpios = <26 (GPIO_ACTIVE_LOW | GPIO_OPEN_DRAIN)>;
+		input;
+		line-name = "fan-tacho";
+	};
+};
+
+&cp0_pinctrl {
+	/*
+	 * U-Boot does not (yet) have a driver for compatible
+	 * "marvell,cp115-standalone-pinctrl" used by upstream device-tree.
+	 * Add legacy description for generic mvebu pinctrl driver.
+	 */
+	compatible = "marvell,mvebu-pinctrl";
+	reg = <0x440000 0x20>;
+	pin-count = <63>;
+	max-func = <0xf>;
+};
+
+&cp0_utmi0 {
+	status = "okay";
+};
+
+&cp0_utmi1 {
+	status = "okay";
+};
+
+&cp1_pinctrl {
+	/*
+	 * U-Boot does not (yet) have a driver for compatible
+	 * "marvell,cp115-standalone-pinctrl" used by upstream device-tree.
+	 * Add legacy description for generic mvebu pinctrl driver.
+	 */
+	compatible = "marvell,mvebu-pinctrl";
+	reg = <0x440000 0x20>;
+	pin-count = <63>;
+	max-func = <0xf>;
+};
+
+&cp1_utmi0 {
+	status = "okay";
+};
+
+&cp2_comphy1 {
+	phy-type = <COMPHY_TYPE_USB3_HOST0>;
+};
+
+&cp2_pinctrl {
+	/*
+	 * U-Boot does not (yet) have a driver for compatible
+	 * "marvell,cp115-standalone-pinctrl" used by upstream device-tree.
+	 * Add legacy description for generic mvebu pinctrl driver.
+	 */
+	compatible = "marvell,mvebu-pinctrl";
+	reg = <0x440000 0x20>;
+	pin-count = <63>;
+	max-func = <0xf>;
+};
+
+&cp2_utmi0 {
+	status = "okay";
+};
diff --git a/arch/arm/mach-mvebu/Kconfig b/arch/arm/mach-mvebu/Kconfig
index adb816982f87c785f3b64e391f45b2c1cac23b92..2d30734933e68704e95216e2f9502f203b5f088f 100644
--- a/arch/arm/mach-mvebu/Kconfig
+++ b/arch/arm/mach-mvebu/Kconfig
@@ -234,6 +234,13 @@ config TARGET_CRS3XX_98DX3236
 	bool "Support CRS3XX-98DX3236"
 	select 98DX3236
 
+config TARGET_SOLIDRUN_CN913X
+	bool "Support SolidRun CN913x based platforms"
+	select ARMADA_8K
+	imply BOARD_EARLY_INIT_R
+	select BOARD_LATE_INIT
+	imply SCSI
+
 endchoice
 
 choice
@@ -300,6 +307,7 @@ config SYS_BOARD
 	default "turris_mox" if TARGET_TURRIS_MOX
 	default "mvebu_armada-8k" if TARGET_MVEBU_ARMADA_8K
 	default "octeontx2_cn913x" if TARGET_OCTEONTX2_CN913x
+	default "octeontx2_cn913x" if TARGET_SOLIDRUN_CN913X
 	default "db-mv784mp-gp" if TARGET_DB_MV784MP_GP
 	default "ds116" if TARGET_DS116
 	default "ds414" if TARGET_DS414
@@ -323,6 +331,7 @@ config SYS_CONFIG_NAME
 	default "db-88f6820-amc" if TARGET_DB_88F6820_AMC
 	default "mvebu_armada-8k" if TARGET_MVEBU_ARMADA_8K
 	default "mvebu_armada-8k" if TARGET_OCTEONTX2_CN913x
+	default "mvebu_armada-8k" if TARGET_SOLIDRUN_CN913X
 	default "db-mv784mp-gp" if TARGET_DB_MV784MP_GP
 	default "ds116" if TARGET_DS116
 	default "ds414" if TARGET_DS414
@@ -350,6 +359,7 @@ config SYS_VENDOR
 	default "Marvell" if TARGET_DB_XC3_24G4XG
 	default "Marvell" if TARGET_MVEBU_DB_88F7040
 	default "solidrun" if TARGET_CLEARFOG
+	default "solidrun" if TARGET_SOLIDRUN_CN913X
 	default "kobol" if TARGET_HELIOS4
 	default "Synology" if TARGET_DS116
 	default "Synology" if TARGET_DS414
@@ -508,6 +518,7 @@ config ARMADA_32BIT_SYSCON_SYSRESET
 	  Build support for Armada XP/375/38x/39x system reset via driver model.
 
 source "board/solidrun/clearfog/Kconfig"
+source "board/solidrun/octeontx2_cn913x/Kconfig"
 source "board/kobol/helios4/Kconfig"
 
 endif
diff --git a/board/solidrun/octeontx2_cn913x/Kconfig b/board/solidrun/octeontx2_cn913x/Kconfig
new file mode 100644
index 0000000000000000000000000000000000000000..425ceb4342a4be9e59fda3fd2c2914ee5ed37056
--- /dev/null
+++ b/board/solidrun/octeontx2_cn913x/Kconfig
@@ -0,0 +1,33 @@
+if TARGET_SOLIDRUN_CN913X
+choice
+	prompt "SolidRun CN913x board select"
+	default TARGET_SOLIDRUN_CN9130_CLEARFOG_PRO
+	help
+	  SolidRun has a range of boards based on CN9130 SoC
+	  supported by common code.
+
+config TARGET_SOLIDRUN_CN9130_CLEARFOG_BASE
+	bool "Support SolidRun CN9130 Clearfog Base"
+
+config TARGET_SOLIDRUN_CN9130_CLEARFOG_PRO
+	bool "Support SolidRun CN9130 Clearfog Base"
+
+config TARGET_SOLIDRUN_CN9131_SOLIDWAN
+	bool "Support SolidRun CN9131 SolidWan"
+
+config TARGET_SOLIDRUN_CN9132_CLEARFOG
+	bool "Support SolidRun CN9132 Clearfog Evaluation Board"
+endchoice
+
+config DEFAULT_DEVICE_TREE
+	default "marvell/cn9130-cf-base" if TARGET_SOLIDRUN_CN9130_CLEARFOG_BASE
+	default "marvell/cn9130-cf-pro" if TARGET_SOLIDRUN_CN9130_CLEARFOG_PRO
+	default "marvell/cn9131-cf-solidwan" if TARGET_SOLIDRUN_CN9131_SOLIDWAN
+	default "marvell/cn9132-clearfog" if TARGET_SOLIDRUN_CN9132_CLEARFOG
+
+config DEFAULT_FDT_FILE
+	default "marvell/cn9130-cf-base.dtb" if TARGET_SOLIDRUN_CN9130_CLEARFOG_BASE
+	default "marvell/cn9130-cf-pro.dtb" if TARGET_SOLIDRUN_CN9130_CLEARFOG_PRO
+	default "marvell/cn9131-cf-solidwan.dtb" if TARGET_SOLIDRUN_CN9131_SOLIDWAN
+	default "marvell/cn9132-clearfog.dtb" if TARGET_SOLIDRUN_CN9132_CLEARFOG
+endif
diff --git a/board/solidrun/octeontx2_cn913x/Makefile b/board/solidrun/octeontx2_cn913x/Makefile
new file mode 100644
index 0000000000000000000000000000000000000000..8c6ffb9328719dd7665dd5232e930618b6c572c9
--- /dev/null
+++ b/board/solidrun/octeontx2_cn913x/Makefile
@@ -0,0 +1,8 @@
+#
+# Copyright (C) 2016 Stefan Roese <sr@denx.de>
+# Copyright (C) 2019 Marvell International Ltd.
+#
+# SPDX-License-Identifier:	GPL-2.0+
+#
+
+obj-y	:= board.o
diff --git a/board/solidrun/octeontx2_cn913x/board.c b/board/solidrun/octeontx2_cn913x/board.c
new file mode 100644
index 0000000000000000000000000000000000000000..3ffe15d42b803f407c70608d86874be1dfb71abd
--- /dev/null
+++ b/board/solidrun/octeontx2_cn913x/board.c
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier:    GPL-2.0+
+/*
+ * Copyright (C) 2016 Stefan Roese <sr@denx.de>
+ * Copyright (C) 2020 Marvell International Ltd.
+ */
+
+#include <dm.h>
+#include <power/regulator.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+__weak int soc_early_init_f(void)
+{
+	return 0;
+}
+
+int board_early_init_f(void)
+{
+	soc_early_init_f();
+
+	return 0;
+}
+
+int board_early_init_r(void)
+{
+	return 0;
+}
+
+int board_init(void)
+{
+	/* address of boot parameters */
+	gd->bd->bi_boot_params = CFG_SYS_SDRAM_BASE + 0x100;
+
+	return 0;
+}
+
+int board_late_init(void)
+{
+	return 0;
+}
diff --git a/configs/cn9130_clearfog_defconfig b/configs/cn9130_clearfog_defconfig
new file mode 100644
index 0000000000000000000000000000000000000000..d32ccbd3d658ecb31c4ebe1a2930a9398def546f
--- /dev/null
+++ b/configs/cn9130_clearfog_defconfig
@@ -0,0 +1,77 @@
+CONFIG_ARM=y
+CONFIG_ARCH_CPU_INIT=y
+CONFIG_ARCH_MVEBU=y
+CONFIG_TEXT_BASE=0x00000000
+CONFIG_NR_DRAM_BANKS=2
+CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xff0000
+CONFIG_TARGET_SOLIDRUN_CN913X=y
+CONFIG_ENV_SIZE=0x10000
+CONFIG_ENV_OFFSET=0x3f0000
+CONFIG_DM_GPIO=y
+CONFIG_SYS_BOOTM_LEN=0x800000
+CONFIG_SYS_LOAD_ADDR=0x800000
+CONFIG_DEBUG_UART_BASE=0xf0512000
+CONFIG_DEBUG_UART_CLOCK=200000000
+CONFIG_PCI=y
+CONFIG_DEBUG_UART=y
+CONFIG_AHCI=y
+# CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
+CONFIG_DISTRO_DEFAULTS=y
+CONFIG_USE_PREBOOT=y
+CONFIG_SYS_PBSIZE=1051
+CONFIG_SYS_CONSOLE_INFO_QUIET=y
+# CONFIG_DISPLAY_CPUINFO is not set
+CONFIG_BOARD_EARLY_INIT_F=y
+CONFIG_ID_EEPROM=y
+CONFIG_SYS_MAXARGS=32
+CONFIG_CMD_TLV_EEPROM=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_I2C=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_PCI=y
+CONFIG_CMD_SPI=y
+CONFIG_CMD_USB=y
+CONFIG_CMD_SNTP=y
+CONFIG_OF_UPSTREAM=y
+CONFIG_ENV_OVERWRITE=y
+CONFIG_ENV_IS_IN_MMC=y
+CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_SYS_MMC_ENV_DEV=1
+CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_AHCI_GENERIC=y
+CONFIG_LBA48=y
+CONFIG_SYS_64BIT_LBA=y
+CONFIG_BUTTON=y
+CONFIG_BUTTON_GPIO=y
+CONFIG_CLK=y
+CONFIG_GPIO_HOG=y
+CONFIG_DM_PCA953X=y
+CONFIG_DM_I2C=y
+CONFIG_SYS_I2C_MVTWSI=y
+CONFIG_LED=y
+CONFIG_LED_GPIO=y
+CONFIG_MISC=y
+CONFIG_I2C_EEPROM=y
+CONFIG_SUPPORT_EMMC_BOOT=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_XENON=y
+CONFIG_SPI_FLASH_WINBOND=y
+CONFIG_PHY_MARVELL=y
+CONFIG_PHY_MARVELL_10G=y
+CONFIG_MVPP2=y
+CONFIG_NVME_PCI=y
+CONFIG_PCIE_DW_MVEBU=y
+CONFIG_PHY=y
+CONFIG_MVEBU_COMPHY_SUPPORT=y
+CONFIG_PINCTRL=y
+CONFIG_PINCTRL_ARMADA_8K=y
+CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_DM_RTC=y
+CONFIG_MARVELL_RTC=y
+CONFIG_DEBUG_UART_SHIFT=2
+CONFIG_SYS_NS16550=y
+CONFIG_KIRKWOOD_SPI=y
+CONFIG_USB=y
+CONFIG_USB_XHCI_HCD=y
+CONFIG_USB_EHCI_HCD=y

-- 
2.43.0

