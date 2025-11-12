Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC448CCFA1A
	for <u-boot@archiver.kernel.org>; Wed, 12 Nov 2025 14:12:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 41ACD83C62;
	Wed, 12 Nov 2025 15:12:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="fpoXGARX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 246F383C94; Wed, 12 Nov 2025 15:12:41 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3EC183C54
 for <u-boot@lists.denx.de>; Wed, 12 Nov 2025 15:12:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w6jCCAbjbol6elynjAinxqrKZ31+TUkVYR7VUGCA/f3SuIuzUbQZe1w3cIZeFyS609YXtBrCpEH1NABpktTPxomCGdMeZ4FQD1fAd8CFe5wMbEYdKgMq7h9izKUVgIZBvdTZ1KF68JNyONpw8EBp3GGru23AGSdhEbUYVVcTXLW7/YIjvjUVzKYdRixYBcdPETRLy9Du7HTDfk4Nx7I82iTTnpfbWODFKxqWNra/evZDu/ryiyZy8bhv06E5A5nQ5v5iobOUI96gbuBWIEQL0c9f72YDslRR9sOkJmLjGbN8gAkcR9KeFht7/T8HmLSptG25CTio97iDxt5G2tY7KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UMvvZHGQB3enxulc3IleF6W3yBD7hxyCv9AM7VGOv0A=;
 b=fE7h1Qrfcv0EE1mJGiPehkY7V0N4e6uHcIIUqd0ugTpLndaPQuSrFh2md30uB7XNFGs68LQELPeEqh5jHlh6Dj23gTy4Mwkboz019dlqoz2pUxx1Q0zEm7AfRsfHJzT32YRHqN1f4aBhxkJ9qz6NpRUfy17t51Fd/RC4DieMaKlFCBW/LTEWeZM/6tdZiXonHw/GRURHsNyHnbqoyO7EDZMQDmxNmDwikRuo5PTAgx2wJYcCAihVYHOZvpjuYJNathopCTETCYiFunRQFuRbcxMMpvT/D1m93MeYiomEAlRvUwW6H8LSSY5UaddX+va/3NbHjyH+H7WKZZyIotR1uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UMvvZHGQB3enxulc3IleF6W3yBD7hxyCv9AM7VGOv0A=;
 b=fpoXGARXe2sLncUIooc/BdkQQaY9OttB7b0YL5AJYV4Zd3znkaYQsl9v/HKGTRGnSo4o8iImh+AblubX/TUInLCtNCXYHR9pn/0p/sJvFqn0CWmM5Za1aO0V90hgekqAXTCs3FjQWLSkmcnofNeoEnEMa/o3XM0+eYwvr/x0yYE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AS8PR04MB9045.eurprd04.prod.outlook.com (2603:10a6:20b:440::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 14:12:36 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%6]) with mapi id 15.20.9298.012; Wed, 12 Nov 2025
 14:12:36 +0000
Message-ID: <896ae93d-0b37-4a6e-b244-fcee50b496f7@cherry.de>
Date: Wed, 12 Nov 2025 15:12:34 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cmd: extension: Fix possible null pointer dereference
To: Kory Maincent <kory.maincent@bootlin.com>, u-boot@lists.denx.de
Cc: Bajjuri Praneeth <praneeth@ti.com>, thomas.petazzoni@bootlin.com,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Jerome Forissier <jerome.forissier@linaro.org>
References: <20251112130742.97473-1-kory.maincent@bootlin.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20251112130742.97473-1-kory.maincent@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: WA2P291CA0033.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::13) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AS8PR04MB9045:EE_
X-MS-Office365-Filtering-Correlation-Id: 149a778e-a617-48aa-f4ca-08de21f587aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ekk2aGhGTmdaWVV1TU5nbkZQZlVyOERqOWJTR1BPUmxLcGgxN1V6UDMrbndY?=
 =?utf-8?B?RlUrZjZaS3F6OTlqRFRHV2Y0SzdmTW9oMzh4Z1JnRUloTGd1THhqQzFSVXg3?=
 =?utf-8?B?ZHJsdkxXRk5xYWVsZ3BxYUpqTHRKUitvQ1QvNGlZMW9DUm5wMC90Qk1WWERF?=
 =?utf-8?B?eGwzaGlCUGdUaFVxdTJCN1B4azlVNmYxL0xvLzhXcHVvS3FhZjcwRjZkeDVv?=
 =?utf-8?B?TWZRSk5FWGp3NWV0UVV0MjhIOWJpUXBFdWpkK2diRVd5N1BWRnRiMDg4UnBn?=
 =?utf-8?B?cnB3eWsydUNiL1VmL3loS2M0eFpTWXkyVHdyV1VWazFYMFJveTd5QjdtZGxY?=
 =?utf-8?B?OEQyU2JOaE9Gdkt2M0dpT0NwaUtsQ0VpZUxjbnBLTVJkRUZjUEZoV3hGZDFi?=
 =?utf-8?B?eEhoZWhxdGV2enFpOWpYS1l5bFMrN1JTTkwrL3RVS3JTbzJSNlhMQU1DWlRn?=
 =?utf-8?B?Z0w2bTBZZHU0ZzlkTTBRNTdHZUE5VDByOTFOVjk4SzNLd21EZHhqMnNVSGx5?=
 =?utf-8?B?L2JydHJ4Qk9qUU8xaW5VQ0V6ZTdiNGVTd2NXaVZjK3dqbDF2dDkvTDFsUENU?=
 =?utf-8?B?UTZxSHdXdVZ4eTJOUW5ydGZ1Q216SklyMW1DZU5zQWVDTXJrenVZZjY4MVU5?=
 =?utf-8?B?aXkvRGNhTXE0M1htK3U2ck0zeE8wOVJGNDhHOE9xNnVjb3pwT0NwcmV1NS90?=
 =?utf-8?B?Q1F5SEhuN2xwbWhUWHkwd20vR2EwV2dzczBjSnNhQWNsUXdSQ29mWVRic3dh?=
 =?utf-8?B?K09UbHNsR0xnVjRsR0NBZCtCWDdmWUlTc1I0MzRTSGcxYlFQNys2ZTZ5eVJw?=
 =?utf-8?B?dVZiTTRmL3ppdkgybjViN2ZPMm5MNnk2REJtOHlDRFVHN2xCcW1BaUdUUTFs?=
 =?utf-8?B?RERhQkVuNmdhNldNajR5WVBxNnNYbDdZQTV6cmxYVG8vV0lRbkpXa0M3OERM?=
 =?utf-8?B?Mll0cVBETWJ4azZ6TjM2ZjcvUEpGZFRjTVRxeFVRVDl3SFpSelhacVFGZlph?=
 =?utf-8?B?TTZNWE9DelBsOUxwam5yRGI1bGRiQklaeEx6QjdId2QxRnJUeUorZXVVR2xF?=
 =?utf-8?B?OGc0ajNzaVBqMVlBZ3dLeExzdmRNK3dlM2JvbWNXVkRPbDFaMndLR1RBRUwz?=
 =?utf-8?B?ODdRWjNVN0pjUkFGaWxaaURZZXBTQVV3bTF1MnJEdHc2TkJkdTNMQ3RRWXFN?=
 =?utf-8?B?Qmorb0ZURy9zR2t6RzNTRDF3cXZod3VVR3RvMi9PRGFlTWxka2wzQlU4aTZx?=
 =?utf-8?B?dXZrVUFmT3hPNXpzbld4ZHRyd25oZGlzc1J2U3JkdTF5Zk42ZVh1a2IvTjEx?=
 =?utf-8?B?VXJFTGJ3OXlvVWsrcjFqS2FiVWFQUFF5bUtIejMwZThpaUJPYWhMa3BLdHVy?=
 =?utf-8?B?TjBmNEFzVFYxb1FoOEZQSjJram9tdGdoY3BQdnJOTFNwUll5VmNmczArNHp4?=
 =?utf-8?B?MFNaWE1vUklxUmwwT0xOUlhFSGtGR0VCZVVYZS9ML3FpMnhjVlpSM1pZWmph?=
 =?utf-8?B?VVlFdi8yMC9jQlg0RElGMGJlaVdlWGV0Rys1cWNWQ3ZxdjBOS3lQZVVWUzBS?=
 =?utf-8?B?UXJRSC9ESVZGamNFV2JpT3BhbnIxUC9XOXNHSEphais2dnNrUDZveVFFaFIx?=
 =?utf-8?B?TVNmTkQwZUtjWGh3T2J4SldWZjhqdU0raWRrWXFlcXZ2dzJwcDlXWUhCZHZy?=
 =?utf-8?B?b1BQcXdROTVhckgxQkw3WXFFcmZzUVVIbXFUNE15U3p3NnlwNmc4TmtkQXp5?=
 =?utf-8?B?Tzc4TjFmV3UwbmluTHJCc2NXY0RjUmEyOUlqeGp0Wk9CSHBTcGpvSXNLTndk?=
 =?utf-8?B?VWZuWDFPU3R6Z3EvaHNUSVVtWUp4eDlvcmZVVUJ2MjlSNjEzMExwVmtJYkNC?=
 =?utf-8?B?Nk1zbGp5YVBxcFZxVDZ5RUFuaGxkdWFDbkhnZnhSTEhnYWc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VER5UElaRDVmY0NIQVNDQklmN2ZPYnByNXVGWlZXbzJBb05uOTZMcUNXaEFu?=
 =?utf-8?B?MEJZTG1RVHF2d3VaaWV6eEduNjBwNUk2eThWVVhGMHpJT2tBNmVNZTN3WDEv?=
 =?utf-8?B?a3hQR29QdUJmSVlBWFE1aDVHS0Nia2pCKzN6K0ZNR3R3QmZKR1N3SHJseGRi?=
 =?utf-8?B?R092MFpKdHRwVGIvRGdGS0EyMHBhOGhxNGo1WjF6QS9YZXd3U3ZEQ09TQ0lt?=
 =?utf-8?B?blc1S2UrSkFSOXFDemh5V1d5WUdsUDlxdkpRNklHWjIydEFVaVBub2czZjU3?=
 =?utf-8?B?eVdkVk9oV3QyWEluY21UTmlNSVBlaXhSOEF3YUNDSjdKK1MyQlZHVndBdTNq?=
 =?utf-8?B?TTNyWFEva1llbjE5cVZhVHBRVUkxQkVaTXM3RTJwNm5oR1MzejBBUkNTMzdq?=
 =?utf-8?B?c1hYM1ErQXRVcG05aVBCbG9XU0VKKzdweTZuM29zMmJ0cStOdGdRN21MVENo?=
 =?utf-8?B?TEFXVUFrTTNIb0daOVRmYW9RRUlMY0FjcGxRMDdrSFdnRHJOMmR0MzhHeXJw?=
 =?utf-8?B?dVE1MGJnT21iVktNL1RHTHpwLzgydnk5ckxaS0todWdJemE3L0N0UmFhMVdi?=
 =?utf-8?B?S0RUQ2lkMHFicnNTQXpsNy9CUVhsL2FhTmNtaVlHblZRZ1FtZjF3NU1FSURh?=
 =?utf-8?B?ZHNFeHlFOTZtWUFkdy9NTnNod0dXaTRVaWtUVU9Mdm8vdXpPK2kvS3pkcUdC?=
 =?utf-8?B?R0FKTmVNa3N1cnphdXFMQ3JhU1lGOVAycm92d2hneUJwZmpQRDd5RzhSVnMx?=
 =?utf-8?B?UDZXL0w1WDc4SHRYK0tTOUZqZFlVNnNvWE14STB0TThPOUh2VUJjQVpVRVJ2?=
 =?utf-8?B?cVhPOVEyc2lRVmlWMmxmd1k0TUYrMTJoSHI5d29hTHhPSlMyb1p4Tk1TRjVV?=
 =?utf-8?B?NGQrNjAyUDM2bkRJSDJLb2duU1M5R28xaHMvV1doYU5LR200aU5HbHJoR0hB?=
 =?utf-8?B?SDBoVnZob09xeUxsM0xCdTJVcWp1dVM5N0hxZ2cxaVowSkJmMWlESi9tUDVn?=
 =?utf-8?B?VDF2dC9Gc1J6UnJlT3BEaDBxenE5MkVQQXFWbW1zZHZ6a2NFSENHSHJHUmVq?=
 =?utf-8?B?em8wUHJucXowdmdCNU10NnBabHFSYkFYUUtJQXNxc2FZZnVhcXcrUGw1aURP?=
 =?utf-8?B?STBtUDJoY3l6VjNMYkE4VWVqVDExRStsMGdXc0tscVhvazN6YmhtZHY0R0RJ?=
 =?utf-8?B?M1RycTV1aU0vanFyb3k3SVI0OHJGd0R5VE5NcWxWWXk1b01NRjJCOWZ6d0Zr?=
 =?utf-8?B?OXZzT2wxbU9Vc09ZcHYxUEx2YStSZ0J3T2FJZzhUZzNyWEtPbjNTbXBMWmdz?=
 =?utf-8?B?YkluVFF1bmVxTEdkVmQ0YjdIT0swazI5aTl1REZnTHhzRGo4TStxd25hTjJI?=
 =?utf-8?B?NkJKWndJcGJwamsycGplSlJFTVlGZjY1QmpTTnlHQ05JSkhaaGQxWUdlOXlz?=
 =?utf-8?B?WFN1bXBISGtWeUxpTUdCdEE3ZUtCRTJnT2ViNklJMVYyQWNNa3RPb0RNTlps?=
 =?utf-8?B?T1RVajByLy9DRVRzS0VBZ2lZTkptc1lneER4QkEzYjBiNkp1UmFYSkMyWlFR?=
 =?utf-8?B?cWNwY2VWNFZxUUwvQ0hkeXRMMXh0WDdDMmtWVGN2VWpSYU42eDdNNHhVdytF?=
 =?utf-8?B?NEhpT0pPSytZMDVmZ0hhSDRuall6Z3hOYzBmUE4zcUU1WE9MK0k4bDMzVVla?=
 =?utf-8?B?aFVxSFhRUnQ4c2ZDZFVPRk02MllBVG85N1BjaysxYVZ0a0VFeXh4cThYTUoy?=
 =?utf-8?B?V0Z0eDZ4TWdDRGUzRWhBcURVWnFGWFV0NHlkRCs3Ty9nRk5ONjF4N2lYTmZt?=
 =?utf-8?B?NXU3YmFVdStNcEhDdE5ZOXpkRTYwb3U4MU9TY1Bndklxc1lRUTFhMmNMQS9Y?=
 =?utf-8?B?ZktpTS85MVNZYXorSTZXNzFtaVg5a1dZN0p4VDIrQTV4V0tUNTRocisvLzlp?=
 =?utf-8?B?WHdyeXRVbE8weGJHTlVUYXhpQm1QM2pyU1hMV1R6TE9UcTM5by9nSWJ5RkRa?=
 =?utf-8?B?KzBYQXVpa29GOFZBd3YwYksyWTBtSjI5eXZ0bndLeWNQcWhhUUIrR1hocXlL?=
 =?utf-8?B?bmswZU1IczlXQWFQNE1NYmR1SmlBRUxZazFpUmNBdHFJSDhycXpId3dROElo?=
 =?utf-8?B?VkRoSVhxNGpTZk41ZkVpQThkTmhhazRpa0dteWZiTGJoZ2NnZE10WGlBdWNI?=
 =?utf-8?B?dUE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 149a778e-a617-48aa-f4ca-08de21f587aa
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 14:12:36.1448 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sfKvxZZO5kqfdjTllS+FijtViQWF9FvakgV0O7dEVidN5HnAg1lg28YTY0fxva6YRNWM2NtXUijeUQfgw5l8hDO7NUzFOB0QzGEfIYYCIFE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9045
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

Hi Köry,

On 11/12/25 2:07 PM, Kory Maincent wrote:
> From: "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>
> 
> Add a null check for extension_list before calling alist_get_ptr() to
> prevent a potential null pointer dereference. If extension_get_list()
> returns NULL, alist_get_ptr() would attempt to dereference it, leading
> to undefined behavior.
> 
> The fix ensures both extension_list and its first element are checked
> before proceeding with the list operation.
> 
> Closes: https://lists.denx.de/pipermail/u-boot/2025-November/602892.html
> Fixes: 2d12958ee71b ("boot: Remove legacy extension board support")
> Signed-off-by: Kory Maincent (TI.com) <kory.maincent@bootlin.com>
> ---
>   cmd/extension_board.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/cmd/extension_board.c b/cmd/extension_board.c
> index 86e4795ba8a..1b92be82611 100644
> --- a/cmd/extension_board.c
> +++ b/cmd/extension_board.c
> @@ -99,7 +99,7 @@ static int do_extension_list(struct cmd_tbl *cmdtp, int flag,
>   	int i = 0;
>   
>   	extension_list = extension_get_list();
> -	if (!alist_get_ptr(extension_list, 0)) {
> +	if (!extension_list || !alist_get_ptr(extension_list, 0)) {

Is it possible that one runs extension scan which returns no supported 
extension (alist_empty(), the default state before calling the scan() 
ops for the extension uclass driver)?

In which case, we should only check whether extension_list is NULL and 
not whether there's at least one extension?

Or at least have a different error code between "scan wasn't run" and 
"scan returned no extension", if that is a distinction we can make?

Cheers,
Quentin
