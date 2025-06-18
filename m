Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24E2FC71157
	for <u-boot@archiver.kernel.org>; Wed, 18 Jun 2025 09:49:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 684F082C55;
	Wed, 18 Jun 2025 11:49:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="oJ9QXS0a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E47682CC9; Wed, 18 Jun 2025 11:49:57 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C205082C2F
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 11:49:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ssdcp351IDqDB+9psCYf2qAVG9g0RsA4woaE0kfJ5ig5WtDIWSFi6ba4Foo08oVrIwcGZi2EuIp2X8+APusTpNX1eQdol16C21MQckMcNvQylpt4VmH+XvjUMluVYvZ/EdO2YmIl0aIY7YFaYngimdF/UTXAgyR2I/67nZ0GrZmMoqIMGCMnodMXbr/bzhUnz2ZzpvmUsWw8H31ymObJeY0wHeqVAFCUQHsaBDCwKiImgns7pbYziSZ77zvMC5hUKxnnJpTxLtDAt49sL1RMN9r2S8owlSNAm+qsjnx6Ugw+z80bxahKQIIPDJby1t9ZKsam5iuhXGTBjyviB7gYcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=skbqjiSkmNZNznNv1yisHamXxzd/bnU5qENfXJmZ5WU=;
 b=Fd/SJ8/5hMe1ncleIT25ySOlWC+D7D1cvxPKeAbBHXf1bIVh91Yj0fwvQXdbqh3FeGifmsp2EV8QcEnSRVzrN1WDWOoj1lHliSVL1A9crduewrYbJVp8CXAgZ6NcQqbR5wxvNTe7lA5ZEw2jQM9NWiOLjmjtvss+BLsoa/6DbG6cgQZ/EYG/5+iLD8ntsbeU+B8L0UIdPAgnry63OWPTK7l17ex1ERnKToWVBgtLXLCmituStajinRiPmlzxt1fKotcIFmqww+irdZQIjiUTX2JZLFJSqvbhZFqkY9rGg3ISVP4Yxq/C5k3cv5t0tU0i9ytZXgT/sxmc8iqgM7n10g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=skbqjiSkmNZNznNv1yisHamXxzd/bnU5qENfXJmZ5WU=;
 b=oJ9QXS0azaBMfnNHZSB+uoy3Hi7UUl9JMW+l4D0Nu+juX1KoITjz8d10CEF1ya0IzmT3t74yKq0++3kNokCEZ4NnRoTUXOj4i6sVy2KT8SxDpiInmdmG2n+gV39Mm4ftkA7sN5ddV5Rnbtgb33gSUXA5YlNF9xc8KUnxUhhrIRU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PR3PR04MB7307.eurprd04.prod.outlook.com (2603:10a6:102:84::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.30; Wed, 18 Jun
 2025 09:49:51 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%6]) with mapi id 15.20.8857.019; Wed, 18 Jun 2025
 09:49:50 +0000
Message-ID: <0c822158-11d7-4a1f-93f8-22043c807bd9@cherry.de>
Date: Wed, 18 Jun 2025 11:49:50 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: board: assign up to 3 static Ethernet MAC
 addresses
To: MichaIng <micha@dietpi.com>
References: <e76dbe98-2fa3-4d1b-a452-aa88a142c5cc@dietpi.com>
 <2beda42f-68c4-4fc3-8b84-ede6e452c4c7@cherry.de>
 <5aeeab0f-cbaa-4b25-9baf-37e2b0e5e9d1@dietpi.com>
 <7ab1deb6-5ab7-4544-805f-f2e1e139d045@cherry.de>
 <647c2f92-344f-4feb-8979-93b1d6574193@dietpi.com>
Content-Language: en-US
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <647c2f92-344f-4feb-8979-93b1d6574193@dietpi.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0265.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::14) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PR3PR04MB7307:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f2c41c1-da27-409a-c31f-08ddae4d7825
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|1800799024|366016|376014|13003099007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OENOaWdNMXc0UXdjMGFzb3VNeEV0MHgwVFNCQlhIamxSV1BGZVNIU2RPT3ZN?=
 =?utf-8?B?cTJZOWVtSzNvWnFGYUpqb3NsQlhzSlJNSDREYUhKRFJUOXpYWVd1eFA0bnRL?=
 =?utf-8?B?NnJKN3pIM1NqZHpkTTRTSnVBaUJhNVhnUjg5SXVMZittdXNkVnFzVzVTc0dk?=
 =?utf-8?B?TXRpdGJpS2x0ZG9SbWIxVy9KWjJuc0xtWnJ2RGRRbFRrM1k2MnRQdEtTdk52?=
 =?utf-8?B?RkpMSzFMYTlDN2lBSVlFSDVCNWJyUXV3UkRFemNCbUpIVUs1MFBjcjBId2JN?=
 =?utf-8?B?enVrRW9zNXdBMjNXdHJRU1p5R0dFOHFHTytObURBb0t0aWo0TEpIN1hXcFBB?=
 =?utf-8?B?ZkY3dkp0SDBnN0RpQVBXWXY4dWJ6WmZFbTlmUlBlcnVJdHZlUjJUcEU2WWxw?=
 =?utf-8?B?TVlKYmxYR0RUQ1RFL0UxRTB4TEFjRDAwZ0FVWC8vVVhURUF1SmFwRnZtUGF4?=
 =?utf-8?B?ZHo5MFFZQzl1ZnNZWkJUMmMzUXJnY09mM1VvREtYQlZuSG40MWNFRzFoc2RY?=
 =?utf-8?B?dmNzY2pnV2d0ZUsxWXdmcC9HTG5DZDU4N3N1K05ySHVPa01wSnM0d1BCSUlw?=
 =?utf-8?B?bHF4Y3NCNVU4NTRzWFl4eTVCK0JObENqa2paUGxmb3RiQnY3akcxNENkSFBv?=
 =?utf-8?B?TVlwZ3JUMnBoQ2JPdUd2Z1kzR1dNYmlUNXlTOHpGYXdDMGNQSU5iRmxjS3ow?=
 =?utf-8?B?V0s1bTA3cWJsaHNtckxNdEFFQ2luRHdPVitkdTFjR2dPRGp4aDF4b0dLaW1N?=
 =?utf-8?B?alhxb0taQ2w3N2pLck9MSGU1Y2lSeVFOd3RYdERUazJ5MkhSMS9TRGxBN0FI?=
 =?utf-8?B?SU5hdDltU1J1RGF4azdBV2o2Sy9sQnNCN3V1bE41VENtU0xvMHh2OS9rV1VX?=
 =?utf-8?B?eDdKbzBBeDBUUGhtREQ5WW5IckhvUlNiMk1VbjV5SG8zTmpMZUhDUWtYa0VR?=
 =?utf-8?B?d1J4M1YvdEV5aDMvd2daRGRzWTBaTm9GOXQ1OWY0SnAxUW9HUzZuRnRyQ1or?=
 =?utf-8?B?WndNcWxYc25xNTcvMTVkNjgvbzJYL1dJaGM4UXVtcHMyb1BmNEhQeGNQLzVZ?=
 =?utf-8?B?a3BOM2xzNTZyZzdXM0dPU0p1YmxPR1BxQWlTejdyRGM3Yyt3L0pnZ0dIYnBl?=
 =?utf-8?B?SVI4WWk2Vk05aU45L21ra2ZKK0VmK3ptWHpvd0pzY1J1M25wMWdpQ214YzFU?=
 =?utf-8?B?dmE0dTgrWXdmUGN5bDRxWTR0cmEvZFZoSUduUWR5dysvRVVsbXVVUGFQdlZq?=
 =?utf-8?B?b2MvMFBGb3FlVVpNTXhwWE9hWGVTTXArRmV1TUlsQS9JZDlwREVqZmc5dXFS?=
 =?utf-8?B?KzFQT3JrS0dqUy9yL2hhUUtqNmZzMml2MnhXZnA5MjY1Z2VLZkZta0V6cEdG?=
 =?utf-8?B?cDNmRllrQm5rZXhZZ0syb1Ixcm9aT3RoMDRoYm5GWXNZYzZRdFI0WTk4S0Y0?=
 =?utf-8?B?dEFxUmQybzVJNG5OSExQWlUwc0Foa0s0NnBXam9XWjd2dDlSUWNOUlQyTVBK?=
 =?utf-8?B?aFdiZUhVUFNFdnZHSm9DT0FYY28wS25jV0JtMnlONGZ1RXVEaUpQa2s0VGtq?=
 =?utf-8?B?cGhJRU9LZ1NuZHdveVowMm9pWEhNdWdWdHJPeTNZaXRRdDM2andIbUtFMWJ0?=
 =?utf-8?B?bEVpYTJwMENsNXNOdUh6T000aVNmekxsdzd0ZnVaWFNOQ2d5QmYyaEhjQzBW?=
 =?utf-8?B?cnQ1Y0d3SFcwaDNEMnpLQml4ZFRTaXIraFEybmx6Mzh0cmt3cnBIc3orTGFj?=
 =?utf-8?B?cE5kV2pabkNqYmZwRDIwNXRBbk5pYzNWSVQrK2lSbnB1M2s4LzRrbFdIUDdM?=
 =?utf-8?Q?6CKJfYXBK9mgwHnXLHpnuUd7hW98KP0LrQ1TY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(13003099007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eXhoLzhBZklZYTJ1djIrcVRUbXloYmRpMitaOVlQbDVSQTYyOWJ1VXNucmtF?=
 =?utf-8?B?KzdVeG5zNERMa3ppU2czQStDMDZHbjRRMmpXOCtuNTVGT2VwMDNTVnNiUXJk?=
 =?utf-8?B?b0RYNTJ3REpaTmdEYVBqUDhhU3dpdVd2cnJta1NPSDZuQTllZGR6dkJpQU5J?=
 =?utf-8?B?WVFReFdHdDR2Zm9GUlpVaDJtUG5ZS1ViWnB5N2JiMmUxbFV2bjRCUG5qNSsx?=
 =?utf-8?B?Yy9vMlg1QkV2NmxhYS8xd3Y1ckJSVGVxbGpqTFI3RmZQVnJMS2ZlWW84TWJZ?=
 =?utf-8?B?cXZEWHdpQ3lXVTVKa0ViajdUdlNVSHpNNzF2OEdQUDVJY0lCV2NjbEtNZWxh?=
 =?utf-8?B?R1JsQkZFNGp3TUQ4R09FNjdxWHY5S0lGUEVBQkhGK0lHMmpzemZqaFJLYUYv?=
 =?utf-8?B?N0xCTzQwR1UrTHFmZHRsZWw4YlBnZm1BMVIvY0EwK2lyV1ZodmtEZUllc3Jp?=
 =?utf-8?B?akRPMHhXQmx2cnFMYXl4V0k3SVlheEhhUFRvcytRTk8zSlRaYWphZ0luRTdn?=
 =?utf-8?B?cCtCYk9YRGFLSHAyU0V5L3JJSndXUTBmVmpTMWR0UFIwSVg3dFduNmtldmdU?=
 =?utf-8?B?a2lrL2pWWFEvN0hkeS9tYzBsSldPS1FnWk56VnloM0FGQ1VVd0pFOXNtM3d4?=
 =?utf-8?B?QnRNTzZaazd3OVUxanA4eTQ0M1N4WXp2YlRtZisrUmlZKzAwNWFNY3hHemtR?=
 =?utf-8?B?YVFYMW9GY2ZFNE0wR3VTTnNqQTBMdlJCa0h1d1VwaTJXaUJaUnFYa2FLU0lp?=
 =?utf-8?B?WlJNYVV6eW9ZeFFjN2I4MnZLNUJ6WnhIbExGdDd4YlFBRlB4OGxNTW5uZU5X?=
 =?utf-8?B?ZU5vc3lpMk53TGQ0WmtwOVU2OGsyR3VEcVJpK3JyaEtLODlVaHlQYngvbk0x?=
 =?utf-8?B?STl2TVpLZUZ6anV3NDZVNmVoaW9GTnpGbEUrRit0MW5VNlRkc2hJV0tGM0Y2?=
 =?utf-8?B?bmVKSVZqSEFrNmQ2QUQ4VHNIQkhKK3NlVDUwM1pqQlRWb1RWcTUxdFV0RjdX?=
 =?utf-8?B?M1JrbUdvbHBZSmYycDBTZXFXa2dWZWcydmQ1MnBQWVJzMVRFd1puTVdTd3NZ?=
 =?utf-8?B?QWc2ZzV1aGw2QTBFSTdBZDFmQlhCbUw0NUhnQkxHcmpPRnBLeExjQW9Xdm95?=
 =?utf-8?B?MjVYQUZxUXhWK2VjOHIzRXEySW02elU5ZWxNRjkwS2lGemMyQnpOdlc1QnZM?=
 =?utf-8?B?ZGNqYklVYjNIek96UDV2K3E1T2RMNTBKK2gyTmIzUThSejFoV25HOS9Jd3A1?=
 =?utf-8?B?M21hZ2hkZnlxYWV1bFB2Q1l4RTVtWlJwVm1sa0VNTWx6azRlaVlqaGx5ekI2?=
 =?utf-8?B?YllIQmkwWHRBQ3d5K3NWTXNPUG5JNlN4enhOTXRyYVB5UWQ5cXdjMENxL2pD?=
 =?utf-8?B?MlpNNkVhbWxHWXpCUUgvZG52UFB6M2w0cFlFNzNVTFN5ZVpnN01qMC9EaFNN?=
 =?utf-8?B?WHFwTHcyUEh5RTAvazBIa1hZbGw1UFdnSit6U21QakRiZFhCTGdzekRTdDUw?=
 =?utf-8?B?ZEM1ay9SYmF6YjNzbXNRZGYyRVhnRGxUS2p5K2dRZHI2bzNZUmxLT2xBMlFS?=
 =?utf-8?B?V0NGUHcwOGoxNHVZYUZLUis2VDZMZXFBampZdEltdTUvYU0yY0ZGRWFKbCtP?=
 =?utf-8?B?RTNvQ242SFU0clYrUEpyMUp3aXJUdndFU3BqSkhVYm5TNzdPSW1CcmNGNWUx?=
 =?utf-8?B?czFycVYzbkgzbExrR2NYajJnazhaZG1DaDJiRWJubWFuSHZ5R3dlc2U5ZlB2?=
 =?utf-8?B?S0lRTUFnZVB0ODV3bDlJYzJIT3YzR3FYN2dIckxHcHlSaGwvM3p0SW1tT0Rj?=
 =?utf-8?B?M3NEMHZOcEY5ckhsQWR5dXVwWWFNdEZQOW1mQmFUNWdHSkJoaXFwek10aUh4?=
 =?utf-8?B?eWYxYUtYWm1DZUpIZXpwVlFOVGxmRkYyVFNNQ3Y1aXVnTm9FV2NQdFBseWF0?=
 =?utf-8?B?bDg3S1E0d1ZyOHd6c2RXaGVZTU5GdXdCbFE1MGhvZFNtWEhUdUpiN1IvK0E0?=
 =?utf-8?B?bXNaQTJVcmZQeUdUdnJkd3dhNHhMdUpVRDYwWTdhWVl6NXRldHJ2OVdITnA0?=
 =?utf-8?B?ak5PZkNBM3F6NU9Ia0lGUmRhbnhwTnlkNTc4Y2pNQy9JZzZkalllMzFhU1k5?=
 =?utf-8?B?VkZkZmpTaEl2YU9KU2tQaXl3NFcvQm4zNVBrL1NxakNtWnZjYndUTDNObW1w?=
 =?utf-8?B?Z0E9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f2c41c1-da27-409a-c31f-08ddae4d7825
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 09:49:50.9059 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w09nZvk/7yC1mfZkcoevuSmKuO05ch+p7dyptArsaDvsMGTONL2L1d1fyPfz35t6LXuR/h0YSKDuVBAmBeVs98jmP73Wx9snQbV2y9hziSk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7307
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

Hi Micha,

Please keep the ML in Cc.

On 6/18/25 3:05 AM, MichaIng wrote:
> Hi Quentin,
> 
>  > I didn't mean to suggest to have this as part of the boot script. Board
>  > file (for me) is any file in the board/ directory which applies to a
>  > board. See board/theobroma-systems/ringneck_px30 for example.
>  >
>  > There you could replace misc_init_r entirely, or define your own
>  > rockchip_early_misc_init_r (like I do in board/theobroma-systems/
>  > ringneck_px30/ringneck-px30.c for example) or add a
>  > rockchip_late_misc_init_r callback after the ethernet addresses if you
>  > want?
>  >
>  > That's what I was suggesting essentially.
> 
> Ah I see. Since it affects 3 different Rockchip boards relevant for me/ 
> us, potentially more, doing it for all Rockchip boards seems reasonable, 

We currently have 137 defconfigs for Rockchip boards (git grep -l 
ARCH_ROCKCHIP configs/ | wc -l), so not sure 3 is a reasonable threshold :)

> at least less code in one place. I will probably start to work on the 
> Orange Pi R2S soon, a RISC-V board with 4 Ethernet adapters, which will 
> most likely have random MAC addresses as well. So actually I would vote 
> for a more generic solution which works the same way on all hardware. I 

I am not too fond of how we handle the random MAC addresses in Rockchip 
either, we should be able to make this more generic indeed.

Now I see a possible issue in that. I believe the random MAC addresses 
are constant across reboots for a given board since it's based on the 
CPU ID. I am assuming we should be keeping this stable if we make the 
thing more generic. Sunxi seems to be setting the first byte of the MAC 
address depending on the ethernet controller index. Rockchip seems to be 
XOR'ing the last bit of the last byte (and you were looking into 
extending this to the 2LSB of the last byte for up to 4 addresses). So 
we already have different expectations of how the random MAC addresses 
need to be computed.

We could have a generic implementation that is overridable for 
boards/vendors or architectures (e.g. via weak symbols for example).

> see the argument to not bloat the environment with often unused 
> variables, so makes sense to generate those MAC addresses on demand only.
> 
> As you mention misc_init_r, I see sunxi boards override/use it to do it 
> more that way: check for aliases ethernet0-4 in a loop, and generate an 
> eth*addr variable only if the alias exist, and the variable does not: 
> https://eur02.safelinks.protection.outlook.com/? 
> url=https%3A%2F%2Fgithub.com%2Fu-boot%2Fu- 
> boot%2Fblob%2Fmaster%2Fboard%2Fsunxi%2Fboard.c%23L776- 
> L795&data=05%7C02%7Cquentin.schulz%40cherry.de%7C464204d1dfa844099a4208ddae0443dc%7C5e0e1b5221b54e7b83bb514ec460677e%7C0%7C0%7C638858055555459309%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=%2FD%2Fr88eFxZY%2Bf%2FMafL6AftJVswiA4uVClC1Hqn3xM1M%3D&reserved=0
> But since it generates variables, I assume it is called before boot 
> scripts and hence is based on the ethernet* aliases defined in U-Boot's 
> device tree, rather than the kernel device tree, right? I mean I aim to 

Yes. Remember that some boards do use U-Boot DTB as kernel DTB as well, 
so it's not that easy of a shortcut for everything supported by U-Boot.

> send Linux patches to add those to respective device trees as well, if/ 
> once this U-Boot patch gets merged, and those might be synced back into 
> U-Boot device trees. But since this is all done on/for the kernel device 
> tree, I would prefer it to depend on kernel dtb aliases only.
> 

Not sure to understand what you want to do here or what's the issue sorry.

You need also eth*addr for use in U-Boot (if you do PXE, TFTP, ping, 
whatever involving networking) so it makes sense to have them in U-Boot 
DT as well.

You can anticipate ethernet aliases being in DT of future Linux kernel 
releases by adding a temporary -u-boot.dtsi with a few properties in 
/chosen/aliases matching the ones in the Linux kernel. Once synced you 
can remove them. Note that obviously unless your system uses the exact 
same binary for U-Boot DTB and kernel DTB, you cannot guarantee that the 
aliases will point to the same controllers for example, so ethernet2 in 
U-Boot may point to ethernet1 in kernel for example, in which case MAC 
addresses may all get swapped between U-Boot and kernel. This is 
theoretically possible, not sure how likely it is to happen though.

> Wouldn't it be possible to generate and generate and apply the MAC 
> addresses [here](https://eur02.safelinks.protection.outlook.com/? 
> url=https%3A%2F%2Fgithub.com%2Fu-boot%2Fu- 
> boot%2Fblob%2Fmaster%2Fboot%2Ffdt_support.c%23L645- 
> L664&data=05%7C02%7Cquentin.schulz%40cherry.de%7C464204d1dfa844099a4208ddae0443dc%7C5e0e1b5221b54e7b83bb514ec460677e%7C0%7C0%7C638858055555480725%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=zes5ZQmR4du9dygIIf6HLT2cVO5yWR2b5dwbaLzpWDA%3D&reserved=0), hence for all actually existing aliases, and only as fallback if the respective eth*addr variable is not set?
> If the method for obtaining the first ethaddr differs between boards, it 
> could still rely on an existing ethaddr variable, to derive different 
> MAC addresses for each ethernet* alias index in a consistent way.
> 

I guess. I would rather have a fallback whenever env_get(mac) doesn't 
return successfully, in which case you can attempt to generate one 
randomly based on some callback. This would cover the case when you have 
a kernel DT with etherent aliases not present in U-Boot DT, this is 
reasonable for boards with adapters covered by Device Tree Overlays for 
example, which don't need to necessarily be applied on U-Boot DTB.

Cheers,
Quentin
