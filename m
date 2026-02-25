Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03C9AFD3760
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 15:05:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A74B384090;
	Wed, 25 Feb 2026 16:04:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="VfLA9E7B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C59B84062; Wed, 25 Feb 2026 16:02:44 +0100 (CET)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59E9C84067
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 16:01:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=tempfail smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LRCuVVQXQ2E16vwSfpAMVz6OVIkOFhwT+IKcoNMivHtP4DZEAb6ZRMc5q1n6R13clZug7i+XHBbMdjoFb9REnYp4byGXg8SdY6vQOu/Zla3Mygzb0+OJis/wWWGGscd2Fu3eyFnr9lwfSpMymXsnGiyHwrO5JEbbz57ywY4UMhub8Rut9QJ2TGxECGxAz6tjdp2QFNkBKFSdcmXWNgMO/AZi9wtcxjElt1FQFidRoI4DUhpN+EioU/g0ZcgultWlKWOi5KMa6KsR9vExbkvuGnIuyIM91wED6my4+cc9rg2Ty3E4j2i4MP/FKeTE5TA1j+hn26S+omCIsnv4zFQsbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h4K/Q9oAGsrtrjhYTAynpGJPsuIV61Fcn06YRzHXRg4=;
 b=EWDX6f3Uw+xWEXqWNv659Xaeida9fSV3H46pYg97+tEHjEUXIuPL2dIUM4XpXn9zYfyz0d9geKFJs2mP3stTJXC2AkQQ+jrjPH7yBiAOtpmghV6i8OfoeaahDQmP+Dn4OJlNztpCKMjLzEuLzrBcjwpluM3Qo4Vh5LyaY5O5twV2j7b7xS+0ip3YXi5tT4g6d7q84OROpJxkc9fcqnaC9SWAdlJohlKmItPamzjaZ6OuX8yeG3rzk+0gslbzgwDGk9sQKez/bvK7oDUilP7UMn/qpul06mP2n2cgHhA6nDFfK4To/l3wsnz8E6V5aEoxb8hNubiXK1DYSBg+4igu7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h4K/Q9oAGsrtrjhYTAynpGJPsuIV61Fcn06YRzHXRg4=;
 b=VfLA9E7B7wz1GIltDnFZ+uIxOd6ErYP6WpzdDNShGDanvK42WrmsX4RqyCa04Qq3tdCefPDRiH5cIi5diNE3FJcwXJbYPaEpdQRStOaGPNBoNyDkng9T3GFli6meoKXARr7nkZEMWstlSaEtOQPXli2qb9pI9yY7kX0oiGZFxhQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by PAXPR04MB9446.eurprd04.prod.outlook.com (2603:10a6:102:2b3::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23; Wed, 25 Feb
 2026 15:01:06 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 15:01:06 +0000
Message-ID: <aa85a6a7-de55-4340-bc35-bd440f612752@cherry.de>
Date: Wed, 25 Feb 2026 16:00:56 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drivers: cpu: fix syntax error in Kconfig documentation
To: Hugo Villeneuve <hugo@hugovil.com>, Tom Rini <trini@konsulko.com>
Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>, u-boot@lists.denx.de
References: <20260216172843.1102036-1-hugo@hugovil.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260216172843.1102036-1-hugo@hugovil.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0134.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::18) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|PAXPR04MB9446:EE_
X-MS-Office365-Filtering-Correlation-Id: e6e5d092-ad3b-4f9b-8b93-08de747eb3af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: eQXEMJ7mfq09S4TDNP/gGjIXN3dEqAj1JK33h5L3mck1V/ZCmIPWbK83AUAwi5puaJtqaECdA4RMPmQV5sXr/2I0lo8T189WbbjKbpcawbBnpNep1dP2TrboSi+k+gKw/qQmrMjzdxtMJbsThmuWJhJ6/y0TkFKtEZu9nXAMJDNNOKKejh7R3FYHas+8zEwFbSH7pYts88VGeRDwGzZC3rp+CBVW1th1l/Iiyc2490hb9LZ+OCUmOsEAVC5lXhZaxpuQ3ONpzdJktgGIvRPaUW41JWIJEpAuxML2goyRrNEHW9BXM4SHHA74EMZWliLZb69StkWU8wjiBvV8yPFr8sCZcy7SQgCNb+w5GPocr6F4yYuubt0GpTfrjk0Xw+srnYjdJjpv+pVA1YcWlLVivE0N4Yfw9i2ML9KGF6JLoF4XauRuF6yTXepQglCYhfHl/ev9esvutemLgHQMy06VGN5b+FJwlwQmD8+bScTyw8mcg+hlECEpx7ThG7saH+UhWOi3WU4vbefuv4NuKIGTJZUAELviuXf67PEfTdcr3SlmfYKs5VaLpI5PKyI+TR0BvYLdbMZkEwzPXWzjoZmezUuc0DEqgIJBPsYlaSgSC8aU8D7+rn1SExFPgDi3i2wkOnJITU+ICub9HhmofgwH36I21qpgtZNyJZuXJZ7rsagf9jx5/3Q8JapjgaHN0FSOZZZThhdZV4Wa23qYAOMCzzaM4UxixOpd9ELyXU8I64U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0tEU2tVQ3ZHbVhLQzlxcUpuWXIrY280QlBGT052Mzd4d3AxS0NBUHc0T3dx?=
 =?utf-8?B?cmpZQnIwc0plamVWOUw3Y2lmYVBDMndjdlp0N1FFd3YyaUMvTXlMSm1VcElx?=
 =?utf-8?B?aFhId29wd1pSZVRUcy8rRXJSYXVhTG9WQkpZTER3TlAyOGxJS2dTTldzT1lI?=
 =?utf-8?B?eUpPU3R4Z3l0SUlTa1VKNmJhdGw0SFdUb3VodFhZU1pWOWV1ZWtkRzNkeitV?=
 =?utf-8?B?TzlkMFZzM3Z3akRzNm5Pb3lhamFtdy80aVJicktrd2MwQ2c3d0c3VHFSY3pn?=
 =?utf-8?B?cTJ1LzA0bTdSV1RWZ3VBVEFMZ2NseWlXQkIvU05uRDYyVVJjTElDemtmL2Jm?=
 =?utf-8?B?MDNsS1NIVDQxbU9kN3hmNEFTcFhmNkc4L2xzYnJmaWI0M01YOTdjemdkN3pH?=
 =?utf-8?B?eEdYMmprNnN1QisyOWhaZ0dvY0U5a3VsWkVRR2FtTVpZQWkzbDNkY3F6dU8w?=
 =?utf-8?B?cGN0RkRGaGUvcUhqKzVYQXZsZCt2aGllTEZQY0FGbzZ3SjQ4WHpGMTAzM1NC?=
 =?utf-8?B?NFlCVVZ2QVNHLzlGT2lJK0hOcXludHlwbWdVVDlwbEtLNjlOSm80K3JWMTJo?=
 =?utf-8?B?V08xMHdjVXRWb1krSlk4NWVuZUc2KzBmTVFwU1lyVEFlenpuRy9vWVRHM0lW?=
 =?utf-8?B?ak54K2crRHRzVVBjMVB5Zm9sZmREaEcvYjhkV1R1Nk5FUGVQdUNUOWc1Vktw?=
 =?utf-8?B?N0VNRkFGZkhVUWppTG12Wjdsd3VBOTRieUtpM3I1ZkpVSktnc3ZWS1puTHB5?=
 =?utf-8?B?NlpCclBvWWlQUVl5Vis4RTdpd0ZOUVg1OGkzbVRhSVpZRDlNd2wyZGJ6SmQr?=
 =?utf-8?B?cytSV0h0TXh5SlVwWXZ5RFdocWJyNzZodGxVMC93Q0QzQXY2ajRZSmcvQzZG?=
 =?utf-8?B?Z2lTZ1VUUWF2Z3RKQ0dLQUNpUXRuN05aMTRHUC93WHE0MWNvSGI2NDR1RTZa?=
 =?utf-8?B?bVNSVHo0bjhGVW44NVlST2VsRUQyclBmS2RKM2htLzN2dmNBclQ0QVoyK1k0?=
 =?utf-8?B?dnlaZnE0QzkvYm00Tzg2ZDVFZnh0UFpLbi96MW80eEE2ejhtMythMjEvR3BD?=
 =?utf-8?B?N0F6d3FFQkxObml5M3JWajAvY21JRTRPaTJBWk8veVpGQk1MYXNKZ1E5T3dz?=
 =?utf-8?B?WjRjVXZZcU9vSUhRV213a2RqdlExclkrdjlrZ3Azc2pER05vMCt1TVhETkxq?=
 =?utf-8?B?bWlOSHBKNUtKTHR1UU5BYjVqZlE2Z1BTVGd3MjNNcFN1UDRSWkxFdVdkVkRU?=
 =?utf-8?B?Rlp4SFpBQmVXNGliNEVwaGNKUjFORzRRb0NrT2U4OGVhQk1yZTVZdEJaU0hS?=
 =?utf-8?B?NjBkT1dYbmR1R0ZYUUNIRHNZcDUzdWtYdjdnYmJBTkp3VE92Mkc4ZGQwbzZG?=
 =?utf-8?B?YUdTMFN3K1lrTFhtc1lUKzl4Tk9SVS9maVU4MEQ0VXNFcXdiOUxWbXM5S1h5?=
 =?utf-8?B?K1FkWVVqUGk3WDN6ZXh6dEpRM3RRMFp0dytvNmw0aW5CRjJQQlU5UDVwR1Ir?=
 =?utf-8?B?Rks5ZjdjNDBDL29zZFJaTXl5SlhZNWNSUG55TSsvbmJ6QWRXY05aeXVkTytP?=
 =?utf-8?B?eWlESm1vSVAwMTdUN0dzL2dud1YyQWhSZnhxMzlCSTdwdUhDYlE4RndyVGx2?=
 =?utf-8?B?Rmt2MyttcVpXLzBnakUyWkR1YVZralVEZld4WmQrKzJvenZIUnkvRDM0cVJa?=
 =?utf-8?B?T0dEQnp3anozYlIvUEw0QlZtM3I5SE1mTlhsWHBHK1dtR2I3RDIvRVkrOXdB?=
 =?utf-8?B?cTBDYkxGcmx0MzBNMGlBS3Npa2VXd0QvUUVIckt3ZjdSejJWd281cG5JM0tZ?=
 =?utf-8?B?MFo0ek1lMklKREVlckRnNStkZnBOeEhuUEI1UGtualBwN1BRcnp5Znk1ODlF?=
 =?utf-8?B?U2QvTmR2TXBjMnYwNzJaZHIrMWE0eGlqNDMzSUxpbTlWRTdDeXE1eXNrdU4x?=
 =?utf-8?B?UVRkUUlCOGd4WmdtajBMNjlwTlpRTG13alI4WE1FcGFOQ0VEN05IdG85Qkhr?=
 =?utf-8?B?YVIwOUlLNDFhMXVxc1hWaVJsN3RrNXozalJWU0xON0VRTG4wUDRqTkxyWmkx?=
 =?utf-8?B?QWtnVWtaRHhUUDlOWFZydWpuNHlDUWI0WXB6ckFFeW9YK1JQN2NONnNXYzNm?=
 =?utf-8?B?Qis4MFo1WXBVd2M5NUdmb3dsREZxYm5RbXJLa0VnSC84TlFEZ3QxSTFmMksw?=
 =?utf-8?B?ZlFVNEZodHdXSnIrcWozNytWeW1PaEd3bldMZVhBQUZsdVdKZTl0OXhpWjNQ?=
 =?utf-8?B?WUhBRHhQS09VN28rMlc4VE1KZkM0WURlQWFUUm0wcHdwQVlvWnNieFJObHRU?=
 =?utf-8?B?em5tNUVmSmNOMC9tbjZjVit5dEhSNnErZEtwT1FQcmdScG5EaFlsaGlmN09j?=
 =?utf-8?Q?OzsfCWw41TDHhh30=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: e6e5d092-ad3b-4f9b-8b93-08de747eb3af
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 15:01:06.4000 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O1nDpASloqI6yRlhlrm5ji6MsL6YcBnsdCDg0iYBO3PFDqPm6i6jejpTVFrlgv0Jwm7V7BzJJiVWith82KvXv78/WsKl0FI0E9zArhp5jes=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9446
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

Hi Hugo,

Quite misleading subject, it's simply a typo.

On 2/16/26 6:28 PM, Hugo Villeneuve wrote:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> Replace then -> they so that the sentence makes sense.
> 

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
