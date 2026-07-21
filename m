Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9555DC44529
	for <u-boot@archiver.kernel.org>; Tue, 21 Jul 2026 15:08:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4D9BA80EA6;
	Tue, 21 Jul 2026 15:08:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Bf_Cn_VuS0zG; Tue, 21 Jul 2026 15:08:56 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 57FAE80EA8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784646536;
	bh=7JRMYpXpC7G88eVAkUNKmEAU62Xb9YzAiWafSq01DQI=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=caccpbJWjwg3NVPDjm6+Se6+FrCtKL4ycScF7C3Dr6NEyjdzuBgR0NhYcxOi0AGN4
	 Ke5me21emaB5j36wdflL8gQWRqjyu3Gu10sKiAQVHFdbtSEW5Pk8QBqdCuvt5THEqD
	 e7UGczEaS5xSi9l/1Jdobr3nAiAo9dd13J1EX5NoTpZVfP9WB6qw+807WlY7+upiBW
	 xKH4/UDQ5dtUDPbXSnY8mrr7zWTmPFp7ZwOxkZ+qMfrdfu2RJwqx7Des15AnuSyoWf
	 XeuuYH2o6qf7gbY6ERtZq38sb/X0ykMOGix9oKhabLr9HIa9IP6Q9/T0SZ9AMPeit8
	 47HrJLUvk2HFQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 57FAE80EA8;
	Tue, 21 Jul 2026 15:08:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 017AC9E5
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 15:08:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F343E40164
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 15:08:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7jerLWlYqkIv for <u-boot@lists.u-boot-project.org>;
 Tue, 21 Jul 2026 15:08:54 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20f::7;
 helo=osppr02cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 0643240055
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0643240055
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0643240055
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 15:08:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h4kh9Whi0GksMUuoxPJ6MFx0WJLfm0/JU7pnBUoqIh2b1HaA6+YLZFP5AyphiKjYqhzDcHE7vqG4HnjqzhJ2reeWdTa8WO0mEm++Q13y8PvgUZkYGfSFA+qcjT5VtT8cMCULZGOdomvI6CmS6WJj317jpdo3b31Yr1z1ot83CN2wn2ANm9XWJjctpEOKqxnvj4sFk2b/7bqY0E4p6I/MW1sIi7lYcuWFPf7IlVF0V90ANo/9qpqEHTVM9+hTQhLN/2to8fSr11pGLdJmTZExg8KsTqPE83UBXG/28xYxecQYp3pd+SHTH0khyl8gG2lCfnK0WzHan8PXQ+hvZTaj3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7JRMYpXpC7G88eVAkUNKmEAU62Xb9YzAiWafSq01DQI=;
 b=a4Mj2Mz8AOcbkibBhkhfw+zehZW0DaYbeURw9WL/Dg9QR3HdkIeobOvS8PXYnwGbtC/9FLk+1PJRz29ZvhCvlgJX7JuHFXPHgK6K/mm3yWF/rZgG6V3G9P93aPIQLM0JFzRSrjkVEYFBhhYu4KZRlMN1Q6oE8/HOVcn0LE4HKABb1sPdnm6b9NEFzIoU0h40fgLK8CjqFFIclxgQuRfhiCW75MRm4fENz8QGZcBMPqiJa9EhY3GU63X+yMDKThihHbUdVyUv153mkzzRJRsWsMdhX7elbkCG8fWiO3axH/B1SYEMlxXEjeyL8GuB74C7q7S+XqLIQge0dbIHLIo3sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by VI0PR04MB12135.eurprd04.prod.outlook.com (2603:10a6:800:324::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 15:08:47 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%5]) with mapi id 15.21.0223.012; Tue, 21 Jul 2026
 15:08:47 +0000
Message-ID: <4a01706f-e233-4fb2-a502-bbbae569eaa1@cherry.de>
Date: Tue, 21 Jul 2026 17:08:46 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [ANN] Mailing list migration to lists.u-boot-project.org
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, u-boot-board-maintainers@lists.denx.de,
 u-boot-custodians@lists.denx.de, u-boot@lists.u-boot-project.org
References: <20260715173119.GL749385@bill-the-cat>
 <868f95a2-269b-4879-ad65-b7dbaf2b1b14@cherry.de>
 <20260721150528.GV749385@bill-the-cat>
Content-Language: en-US
In-Reply-To: <20260721150528.GV749385@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIVP296CA0032.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:356::9) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|VI0PR04MB12135:EE_
X-MS-Office365-Filtering-Correlation-Id: f1c74939-e0db-4bb5-c129-08dee739f6df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|56012099006|5023799004|11063799006|10067099003|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 0Tqs2wkLQw9tC7p4t+mvoMQcgL/epOzm4SaELv9HEa5Gc8VLss2dzA/yhRaMCN6h30nhXAskH+2g/cAZ0QH1IE8JbkVIp1Vecg64XhA+fREfg72kE+NrhI3GsGfy5KE6mxkHxaZpkTbzRuARXVqKD+qwMKBJ+yWmTh2jpzhwhxQ/+Mws3xpohYdSxnUF7x30+BhpOIkfGDq/McmqnHrlQhPLg/palNio6+lRBtlvi0H+mfRGPDaCWyf0ifflTvSXDkFee46R5DHfdQ+acbDdR1YtJDkprIBC9fwqDviNkT+mfQWYOhkWj6+oPeSStXU3wg8mp7dvwLYfofQkuSwTSWsBKa/TZc0jq0E8jUdEMDc/r1sl1hoPhnl2zxLsgB4vQLoKuGE8MQCrsrja7xK49QdaPQ4OqIyGmhNgDYTOEXORWY/p+VxTvYWHAeWSRSsLVvVgS0hGpx76FpXgDCIXFNZaYkfNohXS8lKmlYxHu58fEeqGfwqFv/7fJZuOhnc3SefqnK4ITpVPiIpYYHJJcvdKsl2HJzWOBgpwXummLJcBreTHP6QAGUzfHgKlj+3W6FXHxqLjMBh3V8gKHx5K2/a/Q9vb7POpLFbLROHDBZE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(56012099006)(5023799004)(11063799006)(10067099003)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eWErUUhLaTdHRmJBSmJ0cGtnaWVpOGpNMnN6VVVOK2ZVeExQdDczRW1nZGdw?=
 =?utf-8?B?YlQrUEZlaVF2cDFzMStYOUpzWXowR1pjSFFHdDhyclVJdENDTDFueDJNZlk3?=
 =?utf-8?B?N0tYSkE3NHYyT01SVWUydDM4bWprc3lQVU4rYU85MjlKa21YdzJZMUlkNCth?=
 =?utf-8?B?Z01GRkUrSEpTQUUvNjRDblRlaUI3V3dsU3BGK0hPbVRvam9wK1hENVdjckEw?=
 =?utf-8?B?V3N1dGQ2eFplSFlTMHdQMkV1aHR4SDgyWVBWbm9zU3VrdUhnRU01UTlEYll0?=
 =?utf-8?B?eUZxTGVKUmxKemhGNElUS2JHN1lvQ0hoMGsrNHR5RU84Zll2N2NKbGk0aldF?=
 =?utf-8?B?ZSsveTFOYWVSNlROcjlvd2JEcUhudXc5S1VJcjRtYWlhbUdHdW84QTlsNDRQ?=
 =?utf-8?B?VzFBMGhsSUVVNkNqbkdkSm5JblRGeVM4dldZYUhuM3VXWmRxVHFmYURDR3NQ?=
 =?utf-8?B?SldOdDBJSS96S1NrYk1GSFpIR0VlbWlTMStDRitCMzNrM0U1QjRhbTJuR0Zi?=
 =?utf-8?B?R1VCOVhhQSs3SFBXWGNjK2hEWHNvRThQQXJhaExRSnZOUlhnaTQ0bER2RjVh?=
 =?utf-8?B?MlovSVBJeFpDQXN5UkZMU0lEd0pIY1ZqTzZHNTZHOVRwY2VzRnpKeGtsVkl5?=
 =?utf-8?B?UWtEMlhjMzNsb2MxWDlXNTkwOU5YS0NaUU9Na3JuZmJHMjQyN2V3amdDSElz?=
 =?utf-8?B?NndqN09pVG91bkY2SHE2OG9UMGZrbmtKWDI2UGtMaXZ2cndXV3pqT3RacGc5?=
 =?utf-8?B?STcweTVvMWMrNTFRRGJ6UXBMamlwWWlGb2Y3Q01PTFMzbnZkbkwrRkJhOXRy?=
 =?utf-8?B?NXFRZm5CemFLZ0M5SG9JQjI4dmZhTHUxc1owQTVENi80c0VwUmVkQ3dQSncx?=
 =?utf-8?B?NExlU2dUV0phUTdDbFVFS2Y5VmJuSWpxUjZYMk1aTkpjWWg2eDBLWUFXcGJy?=
 =?utf-8?B?R3FrbktQdU9FZGdqVTJvTzVyQ1MxdHNaZSt3Y1lENVIzdm0vQjh1Sk9LWEwy?=
 =?utf-8?B?dGhyV3hsb3UxQ3JBdHJMK3BtQ3pVOVNSVGljZ2t4UzNhbTJuUzQySmxxS0VV?=
 =?utf-8?B?Z2FXTFpGUXJGSGFLVGwxNlEwcVBjZXdJVE5XbVRLR2JwYk9KdGNJNEVVeUVP?=
 =?utf-8?B?YitpVlBCOFZEMndoaVk3azZ6T2FuTkpGNThiaThpazRHcHNkamE0S3MwVXZj?=
 =?utf-8?B?c1JUK2Rkb3Q4ZVlWd0tiYSsxYzR5QlNIMDh1bFpjUlcxYjFhZVFIMGZhQzcr?=
 =?utf-8?B?ditQUjkrKzV6Y3NFNjJvRkhkbkxLZmNjRTNkVUVXWFdLNHR4MzJKU00rWmU0?=
 =?utf-8?B?VjZ4YzJHeEZWaUppNDBTUmF6Z0gzWUNzRmFVUnlDc1FjWkpNNTBSeFlOSGQx?=
 =?utf-8?B?blB5aTJveVVoWml6UEhtMklDd0kzQnFvTzZQeUw4ZXh1em40VzBlK2dXdDhL?=
 =?utf-8?B?VUdqSTl1R1l5T2FpMGJ3MXEyM3ZFU2pETkdQNE9YcElpaktDOGcyVkF6KzFi?=
 =?utf-8?B?SHN0WlVDMVlDSlBqWDAzM0tZOXFXdU1yNU1uaU9rejNyU08wcHBtNWFudy82?=
 =?utf-8?B?SEdJTit2SkJMdUxJdU9PS2hKTStIZzhZdzJUVXFmckNqalhzanl1ajU4djdD?=
 =?utf-8?B?OEdLa3RhVXJTZDNCRHRUVk9jVUVCYjhrNVhLem9hcUdLL0dsVmlFQTY3enlt?=
 =?utf-8?B?aDh6TDJUbkFBTVJPd0pBbkwwd2xFeWMvQlFDYzZ5SFhFZzRNblB6WENyS2xL?=
 =?utf-8?B?bWhjUExYOGVsLzhIalRlTzd0VTdDaW1QSlUyVHdrbmwvYjdPQ2xJQVc0SnJG?=
 =?utf-8?B?cTk2SFBnVnVhUTNDWCtBZ2xQVHpzTmYzUjRqOXppUXFEN1dFMHNNQVBleHow?=
 =?utf-8?B?MFZjUjE2bnQ0NXVMV2wrMUxLZTd1QXF2MDZoSG1SMGVCc3Ztc0tNK0d5MktG?=
 =?utf-8?B?SHRuVUg3S1NVZUkyYVNlOHppaWZMb1lPUTdNU3JNTGVqaFg1SUtJVmJwUW04?=
 =?utf-8?B?WS9ySjJKRURTWllHS0lCeUpJcjd5b2VyVFR0M0xHTm5aTmJwaGlFK3JKaUhY?=
 =?utf-8?B?NlhuV2hIQ0I5NXovWGovREJLaFhMcFRGVGJaSm9tVmNWR0JBdS9ady9iYkpr?=
 =?utf-8?B?OXo3bFYxUmJjSHpMOTFZN0pjaSt0YVoydVQ1b0NsM2N3NTFDRWhxMWtkR1Zw?=
 =?utf-8?B?OVhwUVFscVBESDJKa1RuR0FuTTJ1cHNncmU2UnFodUpRcVJZWkNFTXI5U2s3?=
 =?utf-8?B?N3BENTVRNmxyN3ZiVW1TYkZjVjNidUxwaW1LUkExQmxjSUk5UkQ4VWdpL09q?=
 =?utf-8?B?TmxxamZKV2trTm42a0NpekgyU0oxZWNUUndML0I3N3FsblQ2RDRmQT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: f1c74939-e0db-4bb5-c129-08dee739f6df
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 15:08:47.7731 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bTty7fO5M5oS0Vx/w+BoDXMDj5mtNjRNUi0KriZQTW+LQyF6pT/L8XHrDMPMan5uxq4Azxo0nDCfp0NscHY6qbZaFqakpe9k+aCelCDxK9k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB12135
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7JRMYpXpC7G88eVAkUNKmEAU62Xb9YzAiWafSq01DQI=;
 b=Ca/J+w3HOxGiIjGJbShuk9tt75xYTfWbLJ+SVvwlzB63vN+LHWlFLzLYoxThJpMCvdq9P6NtIo9MPodQwMmRHX3P08rIhHzrE48ldnnn07fGnOIrvJkhetzBbwMrLXFqi0PFhztDL3PuknkDAdqfL4R1vR6gZY+bfnQL7waOO10=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=Ca/J+w3H
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Quentin Schulz via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Quentin Schulz <quentin.schulz@cherry.de>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 7/21/26 5:05 PM, Tom Rini wrote:
> On Tue, Jul 21, 2026 at 04:52:17PM +0200, Quentin Schulz wrote:
>> Hi Tom,
>>
>> On 7/15/26 7:31 PM, Tom Rini wrote:
>>> Hey all,
>>>
>>> As I've mentioned in previous release emails, we'll be migrating our
>>> lists over to lists.u-boot-project.org. The news now is that we have a
>>> date. This coming Monday the 20th of July, we'll be turning off the
>>> receiving side of lists.denx.de and then importing everything over to
>>> lists.u-boot-project.org.
>>>
>>> What do you need to do? Nothing much. All active subscribers and their
>>> preferences will be moved. This includes how lore and patchwork are
>>> linked, so all of that will work. We are going to try and ensure no new
>>> emails get lost in the migration.
>>>
>>
>> OK but does that mean that whatever mail sent to the old mailing list won't
>> make it to the new one once that cut off date is met (that is, yesterday...
>> yes I'm really asking at the perfect time :) ). Essentially my question is:
>> will we lose mails if they are *now* sent to the old mailing list. I'm
>> assuming at some point in the future they will be? Is there a cut-off date
>> for that?
> 
> The good news is that we were able to setup forwarding correctly, so
> there's nothing being lost at the moment. A final date is something we
> need to talk about off-list with the people that have access to denx.de
> infrastructure still.
> 

Understood.

> Nothing is being missed in *our* archives.
> 

OK, that is good news :)

>>> Based on feedback from the test migration, we believe we know what was
>>> missing to ensure that the archive links are stable, and so that should
>>> be the case when we go live again.
>>>
>>
>> I think we're missing an update to lore.kernel.org to monitor the new
>> mailing list now? b4 shazam doesn't pick the trailers reviewers provide on
>> the mailing list since that date unfortunately (due to the mails not
>> appearing on lore.kernel.org I'm assuming).
> 
> Yes. I've been trying to reach out to helpdesk@kernel.org for a while
> and not had luck, unfortunately.
> 

Konstantin was on holidays until yesterday, maybe we need to poke again 
now that he's back (he's generally active on Mastodon too but I'm not 
sure that's good etiquette to ping him there :) ).

>> I **think** there may be an issue with patchwork as well since I don't see
>> my answers in there either, see https://patchwork.ozlabs.org/project/uboot/patch/af0ac32e2bf603c39f490f15fe62319fd73c5282.1784423864.git.daniel@makrotopia.org/, https://lore.kernel.org/u-boot/af0ac32e2bf603c39f490f15fe62319fd73c5282.1784423864.git.daniel@makrotopia.org/T/#u
>> and https://lists.u-boot-project.org/pipermail/u-boot/2026-July/625465.html
>> for an example.
> 
> We also had a small window where patchwork wasn't updated (and I'm
> talking with Jeremy to backfill that).
> 

Thanks!

Cheers,
Quentin
