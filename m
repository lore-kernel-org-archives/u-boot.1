Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9568ACD1296
	for <u-boot@archiver.kernel.org>; Tue,  9 Apr 2024 15:27:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D01FD87947;
	Tue,  9 Apr 2024 17:27:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="D8bPfp/H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 419DB879E2; Tue,  9 Apr 2024 17:27:22 +0200 (CEST)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B5E787861
 for <u-boot@lists.denx.de>; Tue,  9 Apr 2024 17:27:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JjdvlLmYu1PAfkaEVjEqyYZ2X3sHO+EKIk0SqBMe41TI2H/oZZ211/S7WPUcsvPJqmQTONrhIIv7DkQTQEsVtYmERtXsfi6dmE6p6CoqwZUHSTV1K9dac+R5n7WiDVNcES95RU5UU/1mXCwBnazqVfYQlrqDL7eDz4lmShOx5pFKiygxih40+/HnMdwRNk6pEwJFZ3uGYkQqpMdkdKLnPww/08qx8VA3nFiWI2NIYBCiMUWvVsCDq4nqUxSlNsJtI9mC4tKz5c/MfGEznTUA6zjq4G+St1NDNkoaiCeH9Zzsmir5AgbvUvICQSPq17o/4R/Kfc+swxpZxx0GJt2wZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FWmpMOk6BKJTcXvRkfxeelL2tWbmD4TAZUEQxcVxi6o=;
 b=GhHh3o7IGR9R1RGx+V7R8ot9KeeoSBwij8RYY52Iul/ahQ5i74LDp82yl0b5t3pizT5ezeTSZ4KK/mPBgP5v/0OXJHI7HF83xev62nsIzIs7WDQDR9wCrDZoRHZ7llu0Go6tTpyi1vprsln1O55VvmN08H6Ye4e5Oan5GX6rR8AU6+MMqeus82SUuIrcnoWgij4HwTunAktUH1i7pMXNSHo9g1Hol+1zCU1oUtl60JEMjSR/PkOlLzjIFk0HS0K16K+JQwR3mJlSVER8DnqJJ9MlEmLIlCAGSZT58hLjPd5kUl9pYIAF0+bEtDFNnYTm/UzWAF9pJZcpu9brwgB4Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com; 
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FWmpMOk6BKJTcXvRkfxeelL2tWbmD4TAZUEQxcVxi6o=;
 b=D8bPfp/HeZvIK2GUapSzA03KkLEH+pSD0ac7l3xMkQoVLqfLhrVyDP0kWf13rdgWsaUhDXbGog8uZKOOU7H/Nq3J3wVe+RRodjsVJNIK5IWaFrdlnd+H9dkqGsvvBNpK2WgXm+Vmr0IHxp6PsVwMeKkg6OHeFMVAin3Fp8qtllWlMRxh8x3tk3rtZP0kOpw96rkvFqyj/ryykW5esLT2mZcTw99+pIMnRlh86s09YhYAiFWtvj/xrSFstyO0MJ6Lc7I6tYOo3TH3O2iKVkN2IRtHveMWdcIz5RFbfTS/eITvTlyEDgrnmU9qGiTBX6etdArEdeP/XzkDsifl7tvAHQ==
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by DB9PR04MB8313.eurprd04.prod.outlook.com (2603:10a6:10:241::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.54; Tue, 9 Apr
 2024 15:27:18 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::3e70:7029:faf2:7779]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::3e70:7029:faf2:7779%3]) with mapi id 15.20.7409.042; Tue, 9 Apr 2024
 15:27:18 +0000
Message-ID: <496013c1-7a57-4d12-bf31-c5257f35ee8c@theobroma-systems.com>
Date: Tue, 9 Apr 2024 17:27:16 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mmc: Imply HS200 cap with mmc-hs400 prop to match
 linux
To: Jonas Karlman <jonas@kwiboo.se>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20240408210619.3749231-1-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <20240408210619.3749231-1-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0025.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::6) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|DB9PR04MB8313:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VDkHblG7cOQ/fjiq89f+H4pQvPPLxUiuHNyaFq2MUa2KtvIG+fNwURHDfK6ycSffg7/OfphP2WrzjE3NUP8741RToh353pSZnbZKCzhk2EIcA3XLLtlAWU8ZuKKsCym4uOTF4bSDAKbCP7Rt6/ww2/GUH1izKXIVOZSxqh0V2XnemOR2jWCsCp+wHKuVybqDt7J2ftDtJ2NMoxbbQIsZkFFnBcfbL4fGZHKpC5ZOEV/wSVba5pI5EixBj6KiYR7DQdKUPU5pNGHgoL5s1yNmMHn6auXC+aqlTv9ImmGfzgJuhrwcDSfItE9fsK88qtiQoihOR6jHWolgfsvaKExpWkgSJp4cRVIR4cfU5y5Y1AzzsTlAE7mnxe4c4Iqv9UYuwwEkCrCpCs6iZTA+au3bHzj9G1ZxroD9a2IvqjboX1WAXXK7DSN/Tfdc8DAYD0jStlMfDoKTxeSJ0FdOhMzn0Mi//MnFWI4NPzu/OlPEWeXnZUs5mtBjmRE8FKJ+1tRz6PbG5ey9sPaN0j75DBWZfpX3UgplJ8ZhgTO6Kz4z9aXA/LNO4o5Q2eYHVgHTt3RXewodfy0EUQZq4IAYamuANc1hkMXsLvEIWe/PelhQUVPwwcXyzjKOHaFt5JQSXicDb/yfXs67snasGTaX4oq+l1WFcVvQgmphCB53fyBOWeY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR04MB8536.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZFA1QmV6WXRYUFh0aDZDVjgzZ3V4S3d6dVdIN0Fia2RnSENQcTRKZVMvbTRQ?=
 =?utf-8?B?VHNjaGk2bW1ZaVBpRFVnWVh1WXQxSHBua0pUaFc3R0ZlSE5ZMzhYVVk4cEM2?=
 =?utf-8?B?RXFyZmwwNHJhd3dlVFJoc1NOZjhOY0Q4T0xuV1pqNFM4VEdPblEwL1RZbGU2?=
 =?utf-8?B?aThMQ3pHYy92U0FNSDJvRGM0c1FaaVZnQmI4SXJFOCtwRVdSWFBXWnBFMEVq?=
 =?utf-8?B?OTY5S09MZmlXNXlYN3FCOXo2ai8vZ2ZtaEd5eVY5a0RnN2RtYWV1VjhRNGJ3?=
 =?utf-8?B?SnR5Smw4M0lIcnN4M1Eyek9hdjdqT3BtaEVNejlSZTloKzFGcjBubXRXWHl6?=
 =?utf-8?B?SzFuWnhudnpLQ3hDZVAzRzZhdnJIQ1lTcDB1UWtNeUpFU09WZHRib1ZPMDJD?=
 =?utf-8?B?WlVObXhRbEs2b3FJTWluWTQvR1lCTE8zYldSZCs5MzJLVUh4bVhqTjlORlFo?=
 =?utf-8?B?bTZvRlRlc0VhU0J2QnBlVE1sTkJMSk94SkpqSTZZeTdscytnaXd3QU45RW12?=
 =?utf-8?B?ZkwrajNtTHRNUnBIQ3NCU3dwQTdaeS9WYzFFRDJhdjlacENpZDZKNmNSUUQx?=
 =?utf-8?B?Vlo2MzR1MDhIMC9PWjFDNWljdHd4c3o1ZmdvdFdkeXViNUhrRHg2YjI5OXcr?=
 =?utf-8?B?VEFVR1luaVphelhBUG1FakdYU0s4TzhocVFwUWdvdUdTakp1NHh1MTlSTlBU?=
 =?utf-8?B?ME5FVk8rZ3NGUzk3MEk2QlpCZ2FLUFdYRjZORTh3QUF1WUdrQWQ2S3VNUk1R?=
 =?utf-8?B?eUV0ZFhGVUMyYnI1LzJOTDdmMG1LS3ZhUGczSnRGQWtQbGRldGRUdEpaSWJx?=
 =?utf-8?B?aG5GZFd6Q1gwNFFWTDhNaDZIcC9RMWo1MC9LU2pweUdaZDI0NUFrSHBrY2ZI?=
 =?utf-8?B?VXhIS1ZsSno4SU9CS21hN0tZcHVFUlN6Y3pwMmpXbXQyclRiS21rV3ZaZ3o1?=
 =?utf-8?B?cWp6VzNqNmNiNkRnZHNia1E5TmtaWVlBNVNsWllGSjNTeGpRc2dGaUJ5b0Jk?=
 =?utf-8?B?bUg3UGFFY1d0aE5GWlcweHpqSmpkV1hGTVhwK3MvdlhkRHRhTFRBandzWjRR?=
 =?utf-8?B?WHBwV0ZWeVBWa2JGNVhpS3Z6VG1CZEZxbHo0SGNmYnlVOGV2VFA4bmVaRTRZ?=
 =?utf-8?B?ek1DYmpUdDloTWFUVHBPUzJoS04ybVdDd2NOVTdXdFFOeWZTWkR3MGpsQkFM?=
 =?utf-8?B?R1RBN0EzMWZLd2N6bmlRNWpRVTVRTE5oY01USTBpN3BON01aa3R0dCsweTlD?=
 =?utf-8?B?M3FKd09ZZDJzUE1HK0tZcGNrWWh4eXFsVEFxbGNmc0dTcGplUVJBeXZ4cXJq?=
 =?utf-8?B?bU1sL0lEWVpzdkdwRzgzS0w0U1NhSm53cGpScWwwMGZRYXpVOG9HOWw4QXVP?=
 =?utf-8?B?QkRCTTFOTFBqUjR0RFo1YzZ0UUtUc3A1VE96RUhuSGRzWWZ0RTc2U0g4UUtm?=
 =?utf-8?B?RHRkZVptbGs5VXAvM1UrM0pIUUdlbkVrNzFqNlBJbk5RbUxsVnBBSE1RaEdI?=
 =?utf-8?B?WTdpZEJNTzBpb0R6Y2U5MHJvNjlzS216elpkeEZOUzVWdHM4TzN1SmJpL0Nt?=
 =?utf-8?B?VVJQT0twQm52OUFwWjNheUszdnVSSHRYRnVIWGhMaE1qYzRrQVc1enZrOXh2?=
 =?utf-8?B?UmoyWW5wZE10T21KS2hMVFlXbGlpZmlRWkVGTEc3MUt3QVdDN3MyWE1MMjVm?=
 =?utf-8?B?Mit1RE16Qm13K2tRZUN0NXNmUkR5dElBNytwSExyK3lYbDF6c2Fycm1oMjRo?=
 =?utf-8?B?MVJDazNGNmkyRWpleWJldEtva21MSE96SWZETGhEVVVVcWdpeVA2QU1FdWda?=
 =?utf-8?B?eTBValZLaWNsNk5oT3l2S0Rpd1ZMcTJPZ0Q1bGw3ZFlJMElqbXRYV0NzR2g0?=
 =?utf-8?B?dHhLRXBPRVJwVXVQNmo4dlJVTG9VRzhaRHJLeGtGUE5HWHVBSTNOZnVLVXFR?=
 =?utf-8?B?TEI2eS9vZk85elZtS3RsY1Bsa1hEa0JHMUJtK2poN0d5Y1h0QlVKdFFvNitt?=
 =?utf-8?B?K0pKQlJiU2NMRjFPRHFJUlIzdFUyQUhBcDBkandNd09mVHpjU051Zlp4M2Fz?=
 =?utf-8?B?RzhDRENFUmhLNWE3UW5jdFNlS29ZUFd3c0VEUnhnOWFtS0NqNHZKMVE4OGZ0?=
 =?utf-8?B?VVhNMnBNUVdhWmx6aHpobWRsOUFKNVpycFpiZkZHV3pScnQrOUMrNGlIYzQx?=
 =?utf-8?Q?hN+iMyV9lCcWqZ1SdN6ykRs=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84b68a43-55ae-4ee0-9f68-08dc58a98ab4
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 15:27:18.1015 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uowT6iZYXATSDYeZymq643nADH7AN0X/0MLmxT/bQQYiXw3WXHCRUP3IXRqPwxUjHJh9x6OYzQgUuYQHTHXwANCf9OfIerlBekMf4XQBovInPwDtDLdE0h7XQnI/IU4R
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8313
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

Hi Jonas,

On 4/8/24 23:06, Jonas Karlman wrote:
> eMMC nodes in linux device tree files typically only contain a mmc-hs400
> prop to signal support for both HS400 and HS200. However, U-Boot require
> an explicit mmc-hs200 prop to signal support for the HS200 mode.
>  > Fix this by follow linux and imply HS200 cap when HS400 cap is signaled
> using a mmc-hs400 prop.
> 

Technically speaking, the DT binding should be the one and only source 
of truth and should be implementation-agnostic.

There it says:
"""
   mmc-hs400-1_2v:
     $ref: /schemas/types.yaml#/definitions/flag
     description:
       eMMC HS400 mode (1.2V I/O) is supported.

   mmc-hs400-1_8v:
     $ref: /schemas/types.yaml#/definitions/flag
     description:
       eMMC HS400 mode (1.8V I/O) is supported.
"""

So I'd say, the DTs should be fixed to add mmc-hs200 as well wherever it 
makes sense.

The point of the DT/DT binding is to be system-agnostic and 
representative of the **HW** implementation. At least that's what the DT 
people want it to be.

If the eMMC standard doesn't allow to have HS400 without HS200, then I 
think this change is acceptable as is, because it is the reality of the 
HW standard. Couldn't find this implied in the standard though (but I 
just skimmed through).

It's also quite surprising, as it's not because the eMMC works with 
HS400 that it necessarily does with HS200 or that it's desired (EMI, 
signal integrity/stability, etc...)?

Now, it wouldn't be the first time U-Boot follows whatever is done in 
Linux, so... up to you/the maintainers :)

Reviewed-by: Quentin Schulz <quentin.schulz@theobrma-systems.com>

Cheers,
Quentin
