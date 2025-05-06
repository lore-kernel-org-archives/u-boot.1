Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CA63C3ABBE
	for <u-boot@archiver.kernel.org>; Tue,  6 May 2025 19:07:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72AA08007D;
	Tue,  6 May 2025 21:07:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="dvXtCk5S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C09E8056A; Tue,  6 May 2025 21:07:15 +0200 (CEST)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on20623.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::623])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 800B480050
 for <u-boot@lists.denx.de>; Tue,  6 May 2025 21:07:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fVmUHtFi2TaXNZLcwDfta9X6+NZodpHn6lZd7FzLEg8G8NzjlUQo0gxxt9fI2VqR30mXZDRPzsR+XmOrO/xwEFXZ6FowcQHkjbt9QR1BSnKRq+6T8fTj8Bi4yr7GFNVjKjEciZdT1VzEX22OgBFUfDc5DK7duixV0lXzCaxdjRrXWcw73N5kYPQWfoWe5hsXzu6ZhXGHCAZWZFNdk4pSDcS8Qzj0bDY8LBx/mUD+xyxyXvdO1eJSi1Cwo0e6L67sRxI/gWqImZmSFe5JvrzVp1gP1BVPWh7K7PEontar531MNVmzl7BRWf5bb4BlexbDtY6AOOWfrtokV45PJbUF6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9oRziqTo3j4UsN3fksyrnzU1yWNc+xeColumBwGLnFc=;
 b=rcOW35iLA1yh84h3dLw4+okORpmUTNKe9wIfJpZgpbQ+JuGGyx1Hq7kcSzXotd+LSOx4zAD1Vhgvp0tPqCG6zvFNkawnlhhOM9lhfomCg4HPFs7UwCBBuixtY13uiWnxBRw3zqK/Eh36cULSwJhpfBVCvOnU2Xo5x5Hqabty7C9VLMX+6fl2QkwVSzws2QiEh3lUUiITuheERyp3uls3lEXmSYDbFtfAnVsK/IiWVJ/y0i2xvoQwvCmF8G3edEf4JjrOveWx9o5QdUMwZ+18i+gorKTH43Xchm6+W9bUs+fMgTlkw7D6VTo5YEf9DWO+knxxhzP3M9T6tl7uY5n2hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9oRziqTo3j4UsN3fksyrnzU1yWNc+xeColumBwGLnFc=;
 b=dvXtCk5Shxk4WTulJePp71dmXfSXQFEDb6/t0Ym3Z8v+1X5tphVaMeHM47oa0kWfgFRhXi6d6s8jtD2ZxUsZC2tkytTG2GCQQkDjt42R862VJlrfFUWYeqzTgQztVnur0LxCXfW3WCPOxI5ebja5i1hsvU9MLUpydQJDEvsgqTg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by GVXPR10MB9062.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1de::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Tue, 6 May
 2025 19:07:08 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5%5]) with mapi id 15.20.8699.026; Tue, 6 May 2025
 19:07:07 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 01/11] cmd: test: add support for =~ operator
In-Reply-To: <20250506165221.GB5430@bill-the-cat> (Tom Rini's message of "Tue, 
 6 May 2025 10:52:21 -0600")
References: <20250506141035.385756-1-ravi@prevas.dk>
 <20250506141035.385756-2-ravi@prevas.dk>
 <20250506164931.GA5430@bill-the-cat>
 <20250506165221.GB5430@bill-the-cat>
Date: Tue, 06 May 2025 21:07:05 +0200
Message-ID: <874ixx5zja.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0118.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:9::8)
 To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|GVXPR10MB9062:EE_
X-MS-Office365-Filtering-Correlation-Id: bf4beed2-a29f-4233-b784-08dd8cd13240
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|1800799024|366016|376014|7053199007|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AaT7nDeTCzi3q69IGc3CrFf18jRKA59ojX2ynWvs5V1/77AD+nDosPVCAPMu?=
 =?us-ascii?Q?6ITY4atgSbQfoAZMbzN7NxLaTaKV7LjnlUfc+660rflX3c/uqFPjjz+WW+aC?=
 =?us-ascii?Q?MdJqr/fki/d3LN7AGz7Y3llv67WQ6c2M8posrvOtRcoLlqT69/F+Lgjp5RXp?=
 =?us-ascii?Q?tN1f8dqFA4pM3VdhmCYck90c3eNOFCUZmfYZoGOJiY9PQG5Bk5PcVmbx+klQ?=
 =?us-ascii?Q?2O4TvKLtBDLI5iKLmALpiZrWttEOiJuLWdFRLOAX8AJ6llytDfHqykWGFEmZ?=
 =?us-ascii?Q?IXSro10bqHbpATgm5PI65qRgMf0MKfXcqWIHNC7My81kaJ6kIwyV8fG4dRdL?=
 =?us-ascii?Q?KtqdQ4VD/pOT5KDOAKzvpogXBGyrTNJSpJBmpItFGjarG+tAQgoddYj1HB5C?=
 =?us-ascii?Q?kukuJemNKdSimFHhXOOkEXWa2V7Fl7sguiVdjIQaWt2cjtmtaKeVhYoWr9sQ?=
 =?us-ascii?Q?xrYoxr0p6JxLt4k5Dpp9SJ11H4AN95jIhMVAM6VxQj8yWBHYdL07gF5QjvX+?=
 =?us-ascii?Q?NnI2TGRdqRNkIDSsKZGkc0M0/L9632FlTS/ChALF9n/AqnUfnAUTnT6Z0kQU?=
 =?us-ascii?Q?0BneLyIta2GXZE8ZBS5FL5sv6svupPaPYattVi01br+klzUlW+DyMnwYkmn5?=
 =?us-ascii?Q?IUFtOrf3LG6FDj1fD1sdSBzS5o3tu2vxCL8d3bw2KMn5et1+ignZuUYXXNcz?=
 =?us-ascii?Q?JDv7iBBCyfYR80J1XhkxHS0aXXL8eVSqt7uXrM9tuY6T0P//FvLfTIrjDsFV?=
 =?us-ascii?Q?K8oskVT6cjEsW6oOpxOf/Xh4oB+PupDlMgDrr6R0T7blY1vA6Ju/5YdOHrGS?=
 =?us-ascii?Q?vIJVa+a2G8Dr0AzGqR9uCY8tB35GZpb/33xc2APtinOanRZ15yDYbu3va2cF?=
 =?us-ascii?Q?iVJ9KJV5JcElB8+8N0wXFkPNpwmWi654c9wdutEf0e+n6ILCYPzi3DHKC+ZR?=
 =?us-ascii?Q?ckgRuEhZfI/FlobOq78NTqhbV6y/xta6YbnQOKtIS4R18YDKyL31DIoqyPW2?=
 =?us-ascii?Q?jNpO+2+0yxzXkCsNFKThwkLJNpO2tZ7DRwhFyBqDRx45tqS8ETHDcKc7oI5M?=
 =?us-ascii?Q?7uOx1wUzNs6p5r+M+/KdMvfZ+oGS+p3a5fljxi7V+sVXKxMHl24sx+epPx+T?=
 =?us-ascii?Q?o6vUnQvBzn3Uh0CmooEbkxFIsreIkg9VoqPE/qMQfXP7Ce7ZgHSwnuFQVI2O?=
 =?us-ascii?Q?WJkWr3Kw0YyxBFduRP6J+qDiSSxXh+N9KT0xIjkTv+B4wWVR2O/t6heQNO6e?=
 =?us-ascii?Q?LwaS56P1MKSccPvEHSvWNH9MWncdiZkVYVIDD+PbQWfAPFKUG2fl541oBZZ4?=
 =?us-ascii?Q?8cmc+20fRkZZ1wdeQndA7Io347pdLGzonp6kDpzE1tDNSe9jmTPBu8cSHJi7?=
 =?us-ascii?Q?ZS2JbrdqN8sS4rt2Z3NUWjJeARPNBdFgvw5OuLTp8gMKrTw9XBxHEB9LCK9T?=
 =?us-ascii?Q?h0QWx+KwIjpdIiWp2hk8ZGivGGQ5coVNc0CgM28QU+UqmEmHzb4Adg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(1800799024)(366016)(376014)(7053199007)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?A5+RyVl0ANa/uJTU5xi44rThNBo7uE5ixX3WkaJobCltlsa0v02AnuMXVKy6?=
 =?us-ascii?Q?1mZpbRHMrfDt1xYN2BPbfEQrA4taKHBpK434LcYc1rvyvAmC6D5c5HsuHk9/?=
 =?us-ascii?Q?3wGCDI6kB77VrTLfANmH+19mZ4PtyR4+GMyafsjvfhiO2fma+gxHSZcyZeLp?=
 =?us-ascii?Q?6dlL2s9EO6P17T6vD19q2j0IMq9h3I9iZrWTIOnpUQ+RS1UKUWUWxMH3Ro3y?=
 =?us-ascii?Q?h78aiJ0ZIRB3D7JXUz5P0W4rm1VFN40bEgc7dFgWpcJ8M5tr4fdJ5UKzp+qv?=
 =?us-ascii?Q?9odFEfamCtF3Z2OQniievFNyP6tkUxjiY69s7k6sHuGf62jrKQkFQ9Ur7vGs?=
 =?us-ascii?Q?khixBA/wkTZNJTH1ERJcq4jCvsSXF2rkJf2HPLjyfSEHrS9w5oDtXJRnc4fA?=
 =?us-ascii?Q?3TnUbqgnhRDu5StgICj9xxHCUKVd3tMsG5NqNrUIm2zrgxMyZhpEI47R48vf?=
 =?us-ascii?Q?nEGNJZi7ZZcCfizrth7RO+W/LbKhZzzVAJ1uBtgIcP6pLkmUtQwX5kZlBLqe?=
 =?us-ascii?Q?K3i214JJsJ+SCyJIU9HO1mR7ElgZ7hfTy8QsrSB1Mz+tqOKbAynjncTGesI5?=
 =?us-ascii?Q?A4h/auQq4AzoyWFEm0rbDkq9tt/k9YIdgFtEDoHqefBWaXjcfQ4kOIISXbrq?=
 =?us-ascii?Q?Z3wUwN6KKAA1zJTJzo+EEyfkFe5YJMUXuOhM4+0f8A+Yi1mwA5LEcLX+x2if?=
 =?us-ascii?Q?fEOXaAOC8U6X15yrCi6Jve7+FtbUz65LTUFEvCJnih0fMt3jr0iairI5d0oa?=
 =?us-ascii?Q?gdcwkIja0SuKPfCZnsQ1XgmgDnfDJcbJ407hYIm+yhwxqgbU79Q2owawo28U?=
 =?us-ascii?Q?Z/jdkU9saw+NQ0IA7xBskc1yqCPBXA8CcWQvLZP77HOR8lavqGfirkGtZawz?=
 =?us-ascii?Q?OzvVf5JYBvcyLrOzGDc73bCyOCiUdNyxv257Q3bVqf94DXfB+hOhzTEkSjbj?=
 =?us-ascii?Q?EaZ6pCKUu5E7skTHljxMqDtoFOtzqjFdyaREYBN42SSleMA0WUg67dKte7Df?=
 =?us-ascii?Q?iKN2cGnO0obKtkFCVenaCvHgixmn3l4ttjFG08whkF8M4BdZUATbIYSJxnxw?=
 =?us-ascii?Q?GKk9K80a4dIAquixKu+4zecyFrTW8dBhlYqdzx2VzyvnazB5GNu0Q7Fotp/0?=
 =?us-ascii?Q?R45i/GvBTc4xeVqEH8K71zjmj1qs3N2frouk25VbZL/4DWkQmpBPEUHy6h6/?=
 =?us-ascii?Q?G7Ih331hP6UASZUuFMHpOCd5UAj+CIoHAdeN8kGwNlMTh5qanPYJ1mSEZGA5?=
 =?us-ascii?Q?ISfIpBJZ8GMcWWDaFpieA0UbxUWM3xhicUWoGNXSJpZAwl7f+3n7EJteAPmP?=
 =?us-ascii?Q?kCcFs0aXwkL96J7nKarqe7L2n1rR5bNqxYnowAOcZOZZp5SSeAxKAwcJVBX2?=
 =?us-ascii?Q?oJyIWM5YNYn5dPiW21CKqFOK/6tmowugEXGByN/LYyImAHTuf4M7w7+dUFcr?=
 =?us-ascii?Q?6IBx1lmCTJb49KxzvNxdD8Q7707Ul1qMQKmXrEez1KJzWjvxyimTH6k8CPF9?=
 =?us-ascii?Q?g3fL7qRWSWB+9oWP2EGuXDpKqjyRmAwCcKJyrRnMAb4/S3xP71GXjRRnHUEj?=
 =?us-ascii?Q?ovMTerc5UioTkL12xuzvhZVC1pczWsVWxewevvYkphexDQbYRGHZU+1bGv1F?=
 =?us-ascii?Q?Qg=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: bf4beed2-a29f-4233-b784-08dd8cd13240
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 19:07:07.8482 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FcX9V41kJ36u7pswsw5EvShSHBileCRlYVaO6YDeQFpG3dQCSZsPoi6UOq+k0gEEFidXQUBFAcV0Ax2K95xUpgw6CE8QleDt0UkDstFzPDc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB9062
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

On Tue, May 06 2025, Tom Rini <trini@konsulko.com> wrote:

> On Tue, May 06, 2025 at 10:49:31AM -0600, Tom Rini wrote:
>> On Tue, May 06, 2025 at 04:10:25PM +0200, Rasmus Villemoes wrote:
>> 
>> > Currently, the only way to make use of regex matching in the shell is
>> > by using "setexpr [g]sub" command. That's rather awkward for asking
>> > whether a string matches a regex. At the very least, it requires
>> > providing setexpr with a dummy target variable, but also, the return
>> > value of setexpr doesn't say whether any substitutions were done, so
>> > one would have to do some roundabout thing like
>> > 
>> >   env set dummy "${string_to_test}"
>> >   setexpr sub dummy '<some regex>' ''
>> >   if test "${dummy}" != "${string_to_test}" ; then ...
>> > 
>> > When CONFIG_REGEX is set, teach the test command a new operator, =~,
>> > which will allow one to more naturally write
>> > 
>> >   if test "${string_to_test}" =~ '<some regex>' ; then ...
>> > 
>> > Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
>> 
>> We should also mention here (and then in docs) that this the same as the
>> =~ operator in bash, which I only learned about now as part of answering
>> my own question of "Are people going to expect =~ to do something
>> else?".
>> 
>> With that,
>> 
>> Reviewed-by: Tom Rini <trini@konsulko.com>
>
> Oh, and we should update doc/usage/cmd/setexpr.rst at least and we
> should have one for test as well, but don't, yet.

Yes, if test.rst had already existed I would have updated it, but I
didn't feel like writing the whole thing from scratch until I had a
sense of whether these were going anywhere. I'll take a stab at it,
including the bash ref, but I'm not sure what you want to put in
setexpr.rst? Perhaps a reference to test.rst for an overview of what
regex features are available so they don't need to be repeated?

Another thing I considered was to have the 'test foo =~ ...' thing
populate shell variables $1, $2, ... with the capture groups, if any;
and possibly even $0 with "what matched the whole thing", as U-Boot
doesn't really have anything sensible for that.

Rasmus
