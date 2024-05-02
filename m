Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80178C4345F
	for <u-boot@archiver.kernel.org>; Thu,  2 May 2024 11:49:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC94F88C35;
	Thu,  2 May 2024 13:49:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="a8NmSyIe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6581A88C4E; Thu,  2 May 2024 13:49:11 +0200 (CEST)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04on072b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0c::72b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E7A688C35
 for <u-boot@lists.denx.de>; Thu,  2 May 2024 13:49:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HVqLBmSgtHSywQxF9ew9AJn1mh1AoiAUf27tiRg5yM5q5tI9mica7CRvqWHQShgcsRSnbHHyp+bp1nHZLeqJbf6nXeehjLVHBUxrLD7pErAG9WEmvrzONl5mi36a4SdULxDHEtPDGOWEvtzfO5hVDZDtKfeh4s6m4ifQpP1fIS9siXLLSjv7k93w+qsV8HppVYIMz8oQfagV+enPHL1Zln4qdl4rXt2T1jrY4PzOuy/stnJepuM7FqKFxVAYQ25tyRYs/3a6CTa/8QxQHQ1WPoh2UEsAFJVAuq1y0Yr9yNggIlWRjkP5JAybdqnV5643cpNVnM3ay/8MZ4K3mbNjNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zdhEF4x5nHIayH8E+LC1Pd+X0XgF9dr8AzmCKuNsLJY=;
 b=arMN5H6XA0gBdgtIuXoQTZAuu9bXhOOv4Le4x0wl7mrF4Z8+fjm1NVgaIy4mGMewTvQXZPelE6+gJ3L0wex1j9nKiomGV7z9AYb3gbnsSbdeBbGN33ThPPXUGw46zujeqe4iGsSkNUIwHIVrod7lKoOkNrZv//xrqhICcyX1qSLpkQPlUSngbD/O9cUKSDO7iHJPtw1VXkAw2zg8EYcGhEaQM1pV5do1JuelV93H38dHkkKOMEiXjg91OZdLxw0UknQvMq00l1rpMxdyKneJ+uy71nTouSHdUHbdlXTsK8YiPTiHGBJUzdwbeRjHJxrqEyzuQEZUsiuDUNMcwfvH8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com; 
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zdhEF4x5nHIayH8E+LC1Pd+X0XgF9dr8AzmCKuNsLJY=;
 b=a8NmSyIedDj7tZoI/4Er9HBh54O/4zmS5v2PLzF5KyyRDXUOVkKhD0x112Zs8Mq+Isaq/F6YLWedFgzainPhLDBgfreuegXxyhbBOV+Jy9QWZ9dKKrtdZZ5HrE47gxwhn6UsnBRs+GyYhNj2kpe4dNctVyOLzFEsoKhoq2y0VmVMHGO80imBmcPkQnK8TEnc1URQr4+yKv7UwJE+85q8mQtBhlVp/dKKQj+8ClrVGMlZPwS8KOY/wgIgDi/YFcq3WgmwlV3PnIZNiDqXJ03nxRTFCyA3biju6BuR+EkE8X1sNiq+6RQVuvA0/0dtMSIMazp6PxprQvGdezG7OomZTQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DB7PR04MB4842.eurprd04.prod.outlook.com (2603:10a6:10:1b::13)
 by AS1PR04MB9237.eurprd04.prod.outlook.com (2603:10a6:20b:4d1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.32; Thu, 2 May
 2024 11:49:05 +0000
Received: from DB7PR04MB4842.eurprd04.prod.outlook.com
 ([fe80::ac08:df46:97bd:4ae6]) by DB7PR04MB4842.eurprd04.prod.outlook.com
 ([fe80::ac08:df46:97bd:4ae6%6]) with mapi id 15.20.7544.029; Thu, 2 May 2024
 11:49:04 +0000
Message-ID: <99f36af9-5d1d-4df2-8e99-ec83c33b851a@theobroma-systems.com>
Date: Thu, 2 May 2024 13:48:56 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] binman: Fix typo in mkimage etype description
To: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
References: <20240425225452.496150-1-marex@denx.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <20240425225452.496150-1-marex@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1P291CA0011.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::8) To DB7PR04MB4842.eurprd04.prod.outlook.com
 (2603:10a6:10:1b::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB4842:EE_|AS1PR04MB9237:EE_
X-MS-Office365-Filtering-Correlation-Id: a968219e-2a58-427e-d07c-08dc6a9dda21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aHdQWlhEeXpCNmUwU3I3UEF4eE9zdGhTaTl4cFVaTFJXVWdLdUh3bytUZWsy?=
 =?utf-8?B?ZzRBVDdyTm0zdzY5K2VMdEhKUHlWdDd6N3BlbDRCM3VsUC9Jc0dwbzlqVFRk?=
 =?utf-8?B?MTRFK21BcFRNUUdLeTNFR3Y1L1A5ZnhQYUJZZDcxTkRPWU5YZ1AxODMzeHMz?=
 =?utf-8?B?TTF4aHAyWkV4Vjd3U3YyeDBMNUMxMUZ3QUx2eU5pVnlxMjYweWRaZU15RC9W?=
 =?utf-8?B?MFZPb0plSnhGQ3ZtRE9VYmYzVE4yTDA5ZUMyTXZNa2VudDM2OVZkbm5rKzlW?=
 =?utf-8?B?NThvdVNqTllVQ1REQkxURVh1MXNtNmlxQ2VtWTNtL1VVclFiejlaYWIveVB3?=
 =?utf-8?B?eDRTSktBakthaWp0QVBMOXpVTXN0ajI3YzJpMFZjWGQvNmFXdFRHUTVseEU4?=
 =?utf-8?B?UDFBeENNZ1lhUTBMV2lyRmx5Z0o5cll3WERjRlVrT214aFdwdFJQb3E2Nng2?=
 =?utf-8?B?c3dWR1AvcTRvdE1lUWFML2h0Y3Rvd21ZdnQwVjl6TGFOM3p5QVIxZ0NoWXFU?=
 =?utf-8?B?R2hKM1ZiRjVaVnFORVVLa2Q3OGdMS0ZkdHpVcm5JOVY4dGo2SFoyOGhEN2FZ?=
 =?utf-8?B?aHFobWJOT0FrWmV2dEloNGZCcklQK3J3cWlDUXpzVXZaWXdHOENIbDJ0ZlBM?=
 =?utf-8?B?MnRjR01mUVNDYnR0T2psWmtHYXh2QVl2aTRGSEc0bDJLdmZyYjhtMmVCVTlh?=
 =?utf-8?B?ei9lUjd3bEFRRW54VnVseFZMKzV6aitLRmxMbUZnd05XdWY1QmJYNXpuQjdr?=
 =?utf-8?B?dnl2NHBvS2JsMm1lODYrT3JmbnBGYXZLU0lrK1MxQURKRStBSmNGUndFckhX?=
 =?utf-8?B?ZWVpUjZLejY3aFFyRzBFci9PWWxpMXR2RUw2UktyVXZaNmt0SDFRcUNVdnBG?=
 =?utf-8?B?Y1JjOWNKUitPRXBSV0RJV3dKcDl6Q1BRRGpVV1JDZDEvemFvRHNIZEZVZVBq?=
 =?utf-8?B?VFo1eE9hTzA1UllOYldJYlVFK1A4V0hZU001OVMrbGcvVVNHd2c1WkU4bU9Z?=
 =?utf-8?B?N1JaYVgyam5Qb2ZicG1wcVMrcUJXb1FaUmpJZlNIQU1sOFdSR1VHa004VUx3?=
 =?utf-8?B?WUhjZEl3R2l2dy8yN1RSVkw3RHM0d2tzNC91ZmIwTWtxd3B0TFhBd3VrTFFw?=
 =?utf-8?B?RFZ1K045eFNCcXFiMHhiM0N3dTFXUEVtREZFZ3B6QlNLbWZKTVdQQ0FTRm5h?=
 =?utf-8?B?K2xSditvdDR3aDBoL2VEV1dUWmpOTlhGbFF6MWQ4Y1FxRHZFWW56SmlFbnc5?=
 =?utf-8?B?V056dE9lQmx3UGtPSVRHNWhOS3U3VjBZNXpaaXVwRW1TOXB4MzQrMFhWZk4w?=
 =?utf-8?B?SE5RQ2ZmWWtodm9waUJSaGNRQ1U4TmJPNjMzYXBHSVRVbkNQNVpVdmxKcFQ1?=
 =?utf-8?B?dXp3UFZnNGdFMnlWclpJTjhkYk1qN0RNbDNxNGliNVQ1dVYySUhMR1krTzdX?=
 =?utf-8?B?UHpteVBEWWo0YXpQRjlqVi9BdklCZ1QzWmZLLys5ckFQall2OGJ5OEE1cU9k?=
 =?utf-8?B?dXovQ2hnWFVlNHgrK2ZwYU45OVFOV2NDUmRVdkZPNUhkeFh5N2V2SWcwdis0?=
 =?utf-8?B?ZDBQQXMwdkRoTTdLMTE3cENOYXRhYWI3OVoyck42dFVEYTIzWXdmM2QrSmdn?=
 =?utf-8?B?cTZZKzZqVGlTWS9SVHlMZkd3U1NUK2d6Q0l5ZlNZL004d1B0bnZNa29aeGp6?=
 =?utf-8?B?YytuR0k1WmNicDdjVEJDNkxoNUFYK1pHR2h1T2hlY2tOTEQ5ZG10OUpRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB7PR04MB4842.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UGl3c1ZmYVRaNi9GSVpoRUVRcU9jaFJlOVg0b0VjdnlJcFg1N3p6aWNYNG5U?=
 =?utf-8?B?OWhidVFEK25iNDlIdDZlaUNwYmFaK2ZqTjFKQXI0K3YzeHB4QmR0NHJUVkJy?=
 =?utf-8?B?RTNhQWRhQ0VsMzJMczhGWnZOUXV1U3dMY3gzdmVMbnFZclBWdXkrUHo3TkZw?=
 =?utf-8?B?M0lWY3FZYjZPeE1QVFRBaE9VREFMb1A5bTZmdVM2YVhwWlBwVC8yRnBvaXI4?=
 =?utf-8?B?elJEbjZWTG1EdzFNOGJkMFZPVEovaGJnOHhUQUc4MWttejVFUGowTWxTNUpa?=
 =?utf-8?B?S1BHbFlRTjhSZ2RTK0tMc201anhTay9HRlVaNk9qalJQTnZoRmd0dFNMVnVz?=
 =?utf-8?B?ZlZXZVdhWm1ZNHUwNnljdWlLZ1Y3YVBjb1FvZDlsUVF3U3Y5M082bC9Sckdr?=
 =?utf-8?B?eklSZytnQWowdlFPL2p1Nmo0Q2VzZDFMUitrTHZNZUVkQ2pKdmwxeThYL1gx?=
 =?utf-8?B?aDZVclBmcDhLREdpZGU2ZmlSUVNEL1I0c0JodGpQaU96NnpudHlsTHNHQUw4?=
 =?utf-8?B?MWpGem1MQ0FWbmFuY1oxQ2k1c2w1NkthYzl0eWlqeE82NnhsZzdLa09SSTFp?=
 =?utf-8?B?ODhGYkZIN3NqMnduaG5Vc0lrY2N4Sm5UKzJFVWVNR0syUmtJZmJhUytmUEU0?=
 =?utf-8?B?UHp4ZldWczY3ejZKOEcrTWdXQlNSaXNnOGs1RnJzRndFSUt6RXdqd0F5R3l0?=
 =?utf-8?B?S1oxTFo1eXB6a09aZmVtRDI5WmFYYVE0d1Y4YkZuSkZtd3ZXVlh4emY0cGRD?=
 =?utf-8?B?M2NYMXJqbHV2bjkybXFjYmMvSllRaE9QUWxDZ1BKTDlyS1Z6V1p4NFBhSkRD?=
 =?utf-8?B?eE5yWjhiSE13UVFkZklyVE1mY05zNEVFamhwQTVBTTEzQzh3UC9IclA2eFc0?=
 =?utf-8?B?MWVVUUdQU0JKNHJWMzlsWVpmcEwxOXJpSVNLbGhBYmQ0QVkrRllmb3EwblRK?=
 =?utf-8?B?ZU5QQU1EUVlFQm9aQ1RMbEhSYWZOUHhVcEE5TE9tRUJxVWRza2V0aktGQThi?=
 =?utf-8?B?aktiYWZ5bFhzSy96TlFKUDlQZjRTV2UxeHZrQ2VxUTRoL0JVbklJdGdoTVIz?=
 =?utf-8?B?aWE2UVJPbmZyZ1RpcmlwZEYveWVoNE50RU5vY0RKYWZ1ZEh3dVBmaG1aMjh2?=
 =?utf-8?B?OXlSM0tra01JNjN6Z1YyUDJzNHV3b3Jka3h3M3pkM3NiVFpRRVErclJ4RXpD?=
 =?utf-8?B?TWN6blF0MzhqTDNGTi96SkQ2bUZLNFg0U3FWZkhwd29rN2dvVk9mOWJwcllT?=
 =?utf-8?B?ajRUK2luUmtYUzBIei9GNGR5MHppVnMxNElvSkpzemdVYngwZmFQVCtoMWxR?=
 =?utf-8?B?emVibTBUWTMxRHZkOGlHc2c4RzdsUmhWbXdIeTkzVnQyd3ZzT1RjMU15ZEtM?=
 =?utf-8?B?OVV1RmhHQTJjaUZHM3JnOW5mOGZQOVpTaDRYaTcrUEdubzJNcUFPTCs0bEVu?=
 =?utf-8?B?SmZjL05SMzlmZVczaTFHVEV6RkgzYUxNYitnMHdSdUxmb3ZVMUxybTl0cnQ1?=
 =?utf-8?B?ZWpOZktMQTFFTlRmbTl6a1A4N21QUTZTMXNNa0V3cTBxaGhqcWJtVk9NYW9h?=
 =?utf-8?B?Snk4UFFOeFJiaXRQMnF5UXhOOWZESEJpR0lnL2cvUDZzbysycVdRTllxK2ZH?=
 =?utf-8?B?bVlzWEJhN1JXYWRYcGxHVmdOTks0MHRKY2VESWN0bUtsaDRYOGlUSlNyT1Vl?=
 =?utf-8?B?U3Y2V29IdlNMQ0prb3psVWFHYlV4TVk2d1lOUWwyVTJaTE5VTjVFMHorbmFR?=
 =?utf-8?B?eURyVXBKMlJhOHJFUE4rTE5wcEhaajcyVWFscGVnWng3aFRMWTB1ZklvejQz?=
 =?utf-8?B?Q3ZiS3VKaHlER20wSTFzY3VtaWt4VCs3UVlsKzdmcmFEWDVLbmxRWVJsRTQ2?=
 =?utf-8?B?eWorZGROTHFkNXg1cW1lM05lWmZ3d2xoS2VaUEh5Umt3MFd3UExhejZFY3Iy?=
 =?utf-8?B?WkpFSk92YURWY2xuN2pteWpqR0lLbW4wQmJPQjFWUDBTTDB3UzVud3JrbDlt?=
 =?utf-8?B?N3c3K3U0ZUJHT1ExeXNIaWlYNmlxR2JmdnlJUzN1eG5qcjFWY2E0eURVZEd2?=
 =?utf-8?B?WTEzdWV4SGlxZCszcHExNm9tZlpOSU14bFRBc29tcndOR1p5R1lIdzZjQTg0?=
 =?utf-8?B?L1RqL3pyZFRicHJsSkJCd2g5THZTS2x6Q3VJcUNWQTVpbXFISHZUdldDNnV5?=
 =?utf-8?B?bWc9PQ==?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a968219e-2a58-427e-d07c-08dc6a9dda21
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4842.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 11:49:04.9190 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nl+Rt5yYhoEbVriNoAhFnK+yNQLnMRMeDpelJkWKYi0Kf8Zw/GZ2JsFz5q1zkFmpl8P1LdY6DoS3CzuTpa6j7FvZ+N1ia5mHu5ap6qz7GRo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9237
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

Hi Marek,

On 4/26/24 12:54 AM, Marek Vasut wrote:
> Fix a typo, no functional change.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>

Reviewed-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>

Thanks,
Quentin
