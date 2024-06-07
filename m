Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBB3FC27C53
	for <u-boot@archiver.kernel.org>; Fri,  7 Jun 2024 07:46:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13D6C8823D;
	Fri,  7 Jun 2024 09:46:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1PoXTSaQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B160B8824C; Fri,  7 Jun 2024 09:46:38 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A2008823D
 for <u-boot@lists.denx.de>; Fri,  7 Jun 2024 09:46:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CU5hwzbFKzsUNQ4LghFlEh3cAUn5Wa9QKp3N4UGxVK/6pOgAKzo3g+rbULvtsiYZO19+LITTvaYbcxAdhwXFGV31hcUARaoHEpwWB6V8TvXxAm0Bkm+l4/xnoxpirnW7R8qNtm3hJ3NMK5bA7MJtS/5iBL0PhfM7Fra5hK3bsLgeOJgpVAY8ni9torD4FrlybNSjQzsXfAQGF5y9yH0RbxutxeVdBJtH3doBZK4lR508e6BfRL7brqeOtAFvn9y1J7XhXQ7D+0HSK7h+oA+IMps6O9qVlAuukNUaJcgYKlmkR4x+tJEq24kKZDC3m+a8MSk7NhYGgFgKq2o18yJdGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k8BcpF2nXP87NLilrTAQ++mw4KQ47r04MoZTMxeWr7g=;
 b=F7KfGQGfjl5gqOcAARJKJGZknNjSwYqNpoHpuoQTdr/cask26rh2cdAvRAQ/gks3ADQL+1CbZKGMw/7RWWJucueHbfVbzcg8mKRomWuLwgGoaxKTxpVxSZNCZYL+DCbiY9QcOO+tgAEUsOY4qiSwkOcR2lgoebXrLuQ/+TQlsmts4IOd6lXCexO+dcllREOU9wH15KD9vXbd818CJOfULRojMmmE1TI6HTarxv8qh8d5lRTSPrDDyCE1OpnvADEAuRe/mcCjXcnYLF6gEG/BNrMqyzLzEQjy9vpnfyBj51/J6EBbwC6P/fUrsHRV2rfPKNi+htZziOiR+WP9+jgJWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k8BcpF2nXP87NLilrTAQ++mw4KQ47r04MoZTMxeWr7g=;
 b=1PoXTSaQAFsZWe10HQM0qVCmLy+O9MqH2JhG9lgeP7XYzphr154MbW8pTAbJE55S80ceRr+nDaOUtzSEO9FILXFVEv6xQ3BW0yMWvlx3KuSrXKpaFfDFCx4JyZ4bE8pyAcmvjhnnz5584JwdtOsAWWfz85F6SPIEW8MLv99W9Ck=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by CH2PR12MB4245.namprd12.prod.outlook.com (2603:10b6:610:af::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Fri, 7 Jun
 2024 07:46:33 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%7]) with mapi id 15.20.7611.016; Fri, 7 Jun 2024
 07:46:33 +0000
Message-ID: <0d0e1d72-2b64-4aa9-8670-7800072c5832@amd.com>
Date: Fri, 7 Jun 2024 09:46:19 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: zynqmp: Update rproc node
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Piyush Mehta <piyush.mehta@amd.com>,
 Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 Tanmay Shah <tanmay.shah@amd.com>, Tom Rini <trini@konsulko.com>
References: <d8247a46f486a612f85767de9b832ad33fa980fe.1717065556.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <d8247a46f486a612f85767de9b832ad33fa980fe.1717065556.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P194CA0046.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:803:3c::35) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|CH2PR12MB4245:EE_
X-MS-Office365-Filtering-Correlation-Id: d4435f1b-9430-4f8b-031c-08dc86c5f366
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RGZKVEJIbnhnVzUwK25wRjNCUlVjS0dSaDR5eG1LNXhkUkdHVDBWeGUrWGh6?=
 =?utf-8?B?emFKTk1tU3pEbWsxbmxYWTlZN3IwNHdlZTVOWHdTN2RPc1psWCtKUUFleWFP?=
 =?utf-8?B?bzNKMWlROTJKd0dLVEY2VlkzZUloVk5KWVZ3NmRmc3RoeHlZdjc0N1MzdDVY?=
 =?utf-8?B?MnBYWmZhT0U0aGNPVHNJMC9kbUZMUkFwWVhrbFp4UVVlQXoxZWhHaTNuTHM3?=
 =?utf-8?B?VGh6YmNBTjZQWVpqR1A0ek1hdkZIZkVPZ01NbmNVeUREcitrTUE3TjVwbUxZ?=
 =?utf-8?B?ejJSaVFSTVhnald0TytuZEVRb2tQOWxTYjhwZjRPZzBBM3hyWnZ6eExVclF0?=
 =?utf-8?B?aDljSDk5YXlSdlhSSzM3UlhWSVdrbDQ0Y3RUM01qM3RmYUpxU1dacmRNaDBK?=
 =?utf-8?B?TCtISmlwUCtJcyt6QWhuN2g1ajRYLzBTWUxOam9KWDB5TUpVT2ZCSFNwa2M1?=
 =?utf-8?B?em11YkhZZmY2c0FONFpUcmxNOFRVOW5BRWVpMnptcWhqcEhnbDJFMjhDYlJB?=
 =?utf-8?B?bEFNYjB5YVlUeERQcC9mcnczOXdrSWsxZUlJQkh4VE9UR1p4bGlscVRzNjhR?=
 =?utf-8?B?dXlPK3VsZFFaTTltOEtTVzgvckZkelU5QllnVUZ4VGlTQVpNRlpXdFNhL2pm?=
 =?utf-8?B?S1k3eW10RVVncFlDL2VrQkVHTFRTWUF3eE9CTTZHNXErWGdsYzZzNlc3YXoy?=
 =?utf-8?B?c0dCVWpVN0IxcjhJK0dxUVlPOWdsR1hnRjJIelFZeG1pV1ozZkMvK3djWUk0?=
 =?utf-8?B?TFF6OFcya0NFek5xODZSbncwM2x3U0E0NElRMWJ2eE94R3Z2QURrMCtuNlRC?=
 =?utf-8?B?dk04VVF1SndneVYzMFlvTzVPMXc0QkRTckh2ZnlQeVdzMmU1amJtSVo0cGl3?=
 =?utf-8?B?bEpZVTNydkJzcnZZREZ6ekFTNHBISzBlbXV2eC9saDNGaHpyOFgyeEdhS2gx?=
 =?utf-8?B?L2UzM0hLUEpHcFhCRmh4NmJVV2VqZ3JBWGpJOWpVWCtaTFBoVUdseHNPVmt5?=
 =?utf-8?B?RDJDZXlrZnJzK0paZ2tPbXBtdi9tSXRnWk5IUFJUek1QMHdJNzl2b3ZJRWkv?=
 =?utf-8?B?b1RTamxTYnFrYVEvWlVoN05oZklCOEZhQ216K1JsUmZOd3ZlbTBXL2ZqUzFM?=
 =?utf-8?B?U2FwcjFYQjF3d0NqNGYyV09nQmMwUkJtYXZEd2F2SDJCV0NoTThERUU4bDRT?=
 =?utf-8?B?NElqWU9IZ3FkbE5nQjlLTHlYK2dTdXBraEdSTE5MUE1SSFVtc2NiNVhTWmow?=
 =?utf-8?B?dDlDUFIraGFsUmlzb1dFVHc0anJibzdCSlNCTkl3SW9LV1ZaWURydExrRktY?=
 =?utf-8?B?aWMyR0RhK00veWNla0ZiZnBQZDUzc3BjUnVmTXlPaGViUy9NakV4TmRWMmdI?=
 =?utf-8?B?SHgyK0dENVo2eUhlMjBobjl1STQ3Y2hMdm9ydStYYmdHdHlZQVVWekZpelNl?=
 =?utf-8?B?L1h5ZzNvUll5Y2pPbkw2T0tzRHVCWXdiZEdjbkFwZkR2bFVjSTlaZHZPbXor?=
 =?utf-8?B?M2FXYS9KTWR2U3dWMFNscHgwM3Q2OS9LRXdrK09tdTFiSVZzSVp1Y2dXU3BF?=
 =?utf-8?B?TUpHRFFNcmc3SWwyblU2Nnd0RTd1c2NRNldRZlh5UUo0OW9jZ2xnc3FSK1Jz?=
 =?utf-8?B?bXlDWkNFcXFNc0NKSlFrZSs1QkxTQ0JVR3dwTmlFMm9ocUhhUmlKR0xnWjlv?=
 =?utf-8?B?cmE2NW1hanJCbWQ4R1JlZUlRSFUrU2pFbHJRbFRPSC9XQlBoTU1sb2VScy9X?=
 =?utf-8?Q?lUnwRoZXERZsCABE+4JuD9nocdtS7w7sySF3bAE?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cHlIWThUb0pMMEUyUUo1SEkwemtSSFFGcTcrZ3FzbnZ2clhQS3drMzErN015?=
 =?utf-8?B?R1hBMHZVblY3YmpOTG5XRmhQOWJJN3JsUkxqK0lEYkxJZlFZQU9nWStnQlFG?=
 =?utf-8?B?YmJ2VGFyV0M5ZXBFQ3c0dmwwMTg1c1Q1VDBSUmZaekxMVDNRUHpEMk02TGN1?=
 =?utf-8?B?RTQ4dXFJQkl4SVdET3R3aHR1LzdET1lBTGJaMy9aRzB1eEd1cmZUN2VwOCt1?=
 =?utf-8?B?c3dpOGVhcW9JUnM5Nk9tSXRad0pRYktuRWc1UmhTU3BXNE5WS2F3T3JsT0R1?=
 =?utf-8?B?dzk3STFUYXBENlZRcE9qS3RnSlBjN0FlazF4b01VeG40R3BjVzBwNUF5b1pn?=
 =?utf-8?B?OHpXckYrT29wd3hJeFkwQ3ZRRFZaaDFYbEJESW14SEVhaFhEaUorOGc0eWhO?=
 =?utf-8?B?RXViN09iSFJxT2Y0TTA4QkwyQytLTS9SK0JOcFIzUDIycmJYcHJ2cE9oMk0r?=
 =?utf-8?B?YnRrOUJNV3d5NVdMNVJMSm1idlZVNFVKeVRCekZRQXJESzVxeHhDUWM0NUM5?=
 =?utf-8?B?bDR2cm9YUElVSk9aTTlmcDAwVFA4ZEpNUTYwZ1B5Ymw4Z1dmQmp0QTY5dWxz?=
 =?utf-8?B?K2N6SVdWTWpUN1pDTDRHdk1SUDkyOXp0QzFwT0tZSHdSb1VVZTB5bFVHa0xw?=
 =?utf-8?B?UHQvTzlDUUVTQW9KSkJRM0RoaUhDU0laTTNYNStnSGd5YUR3WDR0YTA2L2ZG?=
 =?utf-8?B?RkNPQWkrSHB0RTQ1cTkxT2VXNzlzRytYN2hJYXBXOHc1ZU1HcXFkblBaWXQz?=
 =?utf-8?B?SC9rNmpWc0pkUC8vb256S2hXaXVhVkh2M2V3YWZOdm50TUs3OHIzOCt4bHV6?=
 =?utf-8?B?TTZSc0FYSkdBZW1sQ1VmNkZBQmxKT0k0cTlsOVEzWkRUREZYblRmcUhMQ0NV?=
 =?utf-8?B?N0VoaEsxT3JkNmZRZXVLcTJhd3R3WHc4eDRxeS8wK3Y5bzFQTFNYQzBiaVhE?=
 =?utf-8?B?UXlUWjlWNVQwNFhSUW9kQklnK0tHKzlQRTB6a1p6NXk4WWFrZmk5V1V6VEd2?=
 =?utf-8?B?UFEwUFRKMHMwZFY2ODEyTTFac3d0eU81azVSdEFLMzZmMUlKMnlzNmxiRU52?=
 =?utf-8?B?aUF5SGFpem9kWFB2Rk1paE1ZbFdNZFhtamZIbzRjYldUN0FiMGlyQThtZDZK?=
 =?utf-8?B?cHYwZkUxRlY1WmpBOTBUZDlEWU04alc2cVQ5TWJlQktHQ2ZWM09LRVpuSnJO?=
 =?utf-8?B?NzVrWEladk5PTFpYc0NEUllLQlJ2aHdONW5ZQ0FyeWhQTUVNS1lYUGg0SlRF?=
 =?utf-8?B?NENHUXNZdTFkRU1NaWpKTTZSYWthU1EzTGM2Z3p3ZmhobCtjQWxLajV0TGNZ?=
 =?utf-8?B?djZ5NExMdVpXNWFZRWdMa2xwd3BuNmtuSU1Va0JaZmNRQzg5M1JsRjRJWnkx?=
 =?utf-8?B?cFVNdnU5SCtyVlNEZnl4eDJRZ3N3U2pOaUh1WFRFcU50TU5jbDRmbWRhQ2xl?=
 =?utf-8?B?MlhOVGpYbEppUUNzaW5SMW1WNllXNEVKdWc4QWdWQUM1QjQyVEF6QzFEa3JW?=
 =?utf-8?B?ZFJJKzh3aWRJNlZheGZqekRXMlhNWnpIbG5kQURzb29USTFzbm45NmI3K1Rx?=
 =?utf-8?B?c1doOVJBR1d5elorT1g3aTNyM0J2STRIT0hoKzRKbWhENTdqYXl0Q3czTy93?=
 =?utf-8?B?Q0JDSHNucXZmRndoczRobmFjYjdUY0xPU2J0czJRQVpPejhRdHM4VEc5OUtq?=
 =?utf-8?B?M2pIOGpQRTVkaU9lTUtEUExyVFRXMktUOC9oUENuRnRpSS8rZmtQNUdWU1pO?=
 =?utf-8?B?cmVCakN3Unl3endNRFk3TGNDb0pQSy9XNlFzTk5oZUJadEx2b3N1M3JCTm5w?=
 =?utf-8?B?QWx0TWV6a2g5N0JiQ2RJQnJIalZOOTQ1RE8xVjM2NCsvRnhUZVBlOEh5SWN4?=
 =?utf-8?B?QUNMSjU5K2pKNThSdXloZ0syMVlESG1VdXV3YWJKRk5pZ0F2Z0gxSklVaXhO?=
 =?utf-8?B?QUEzWlJQelhCcjN5clJVOWlxVldjYk1SYWlCY3hvOGhNRkRrNXFGOEFxS0xw?=
 =?utf-8?B?cjlIem5QYTVHVTJ2OUdrQ2RkZzBuV3IyM1NlV3lTUTZWUzhTeDdhRWFPU2VB?=
 =?utf-8?B?ektlcmhIMVg2NGR0S2FnMTUrWmpHYW84NmxnNGNjdEYyZHBBTVZQWk1lb2lx?=
 =?utf-8?Q?sh6nz7Vn2K/dX1uI0allGYtQM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4435f1b-9430-4f8b-031c-08dc86c5f366
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 07:46:33.0719 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /pr2hWPotowAIxjTUzwS0/sqKaa0kDLmHKlgbttE76LStOIXYTtgxWCEbBIoU+Km
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4245
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



On 5/30/24 12:39, Michal Simek wrote:
> remoteproc node should be updated to be aligned with the latest dt-schema.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
> Once we push all dts to Linux we can change to OF_UPSTREAM but till that
> time we need to keep DTSes in sync.
> ---
>   arch/arm/dts/zynqmp.dtsi                      | 67 +++++++++++++++++--
>   include/dt-bindings/power/xlnx-zynqmp-power.h | 17 ++---
>   2 files changed, 68 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/arm/dts/zynqmp.dtsi b/arch/arm/dts/zynqmp.dtsi
> index 53a606c340a4..34f592c1a85f 100644
> --- a/arch/arm/dts/zynqmp.dtsi
> +++ b/arch/arm/dts/zynqmp.dtsi
> @@ -314,19 +314,76 @@
>   		ranges;
>   	};
>   
> -	remoteproc {
> +	rproc_lockstep: remoteproc@ffe00000 {
>   		compatible = "xlnx,zynqmp-r5fss";
>   		xlnx,cluster-mode = <1>;
> +		xlnx,tcm-mode = <1>;
>   
> -		r5f-0 {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +
> +		ranges = <0x0 0x0 0x0 0xffe00000 0x0 0x10000>,
> +			 <0x0 0x20000 0x0 0xffe20000 0x0 0x10000>,
> +			 <0x0 0x10000 0x0 0xffe10000 0x0 0x10000>,
> +			 <0x0 0x30000 0x0 0xffe30000 0x0 0x10000>;
> +
> +		r5f@0 {
> +			compatible = "xlnx,zynqmp-r5f";
> +			reg = <0x0 0x0 0x0 0x10000>,
> +			      <0x0 0x20000 0x0 0x10000>,
> +			      <0x0 0x10000 0x0 0x10000>,
> +			      <0x0 0x30000 0x0 0x10000>;
> +			reg-names = "atcm0", "btcm0", "atcm1", "btcm1";
> +			power-domains = <&zynqmp_firmware PD_RPU_0>,
> +					<&zynqmp_firmware PD_R5_0_ATCM>,
> +					<&zynqmp_firmware PD_R5_0_BTCM>,
> +					<&zynqmp_firmware PD_R5_1_ATCM>,
> +					<&zynqmp_firmware PD_R5_1_BTCM>;
> +			memory-region = <&rproc_0_fw_image>;
> +		};
> +
> +		r5f@1 {
> +			compatible = "xlnx,zynqmp-r5f";
> +			reg = <0x1 0x0 0x0 0x10000>, <0x1 0x20000 0x0 0x10000>;
> +			reg-names = "atcm0", "btcm0";
> +			power-domains = <&zynqmp_firmware PD_RPU_1>,
> +					<&zynqmp_firmware PD_R5_1_ATCM>,
> +					<&zynqmp_firmware PD_R5_1_BTCM>;
> +			memory-region = <&rproc_1_fw_image>;
> +		};
> +	};
> +
> +	rproc_split: remoteproc-split@ffe00000 {
> +		status = "disabled";
> +		compatible = "xlnx,zynqmp-r5fss";
> +		xlnx,cluster-mode = <0>;
> +		xlnx,tcm-mode = <0>;
> +
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +
> +		ranges = <0x0 0x0 0x0 0xffe00000 0x0 0x10000>,
> +			 <0x0 0x20000 0x0 0xffe20000 0x0 0x10000>,
> +			 <0x1 0x0 0x0 0xffe90000 0x0 0x10000>,
> +			 <0x1 0x20000 0x0 0xffeb0000 0x0 0x10000>;
> +
> +		r5f@0 {
>   			compatible = "xlnx,zynqmp-r5f";
> -			power-domains = <&zynqmp_firmware PD_RPU_0>;
> +			reg = <0x0 0x0 0x0 0x10000>, <0x0 0x20000 0x0 0x10000>;
> +			reg-names = "atcm0", "btcm0";
> +			power-domains = <&zynqmp_firmware PD_RPU_0>,
> +					<&zynqmp_firmware PD_R5_0_ATCM>,
> +					<&zynqmp_firmware PD_R5_0_BTCM>;
>   			memory-region = <&rproc_0_fw_image>;
>   		};
>   
> -		r5f-1 {
> +		r5f@1 {
>   			compatible = "xlnx,zynqmp-r5f";
> -			power-domains = <&zynqmp_firmware PD_RPU_1>;
> +			reg = <0x1 0x0 0x0 0x10000>, <0x1 0x20000 0x0 0x10000>;
> +			reg-names = "atcm0", "btcm0";
> +			power-domains = <&zynqmp_firmware PD_RPU_1>,
> +					<&zynqmp_firmware PD_R5_1_ATCM>,
> +					<&zynqmp_firmware PD_R5_1_BTCM>;
>   			memory-region = <&rproc_1_fw_image>;
>   		};
>   	};
> diff --git a/include/dt-bindings/power/xlnx-zynqmp-power.h b/include/dt-bindings/power/xlnx-zynqmp-power.h
> index e7eb0960480a..618024cbb20d 100644
> --- a/include/dt-bindings/power/xlnx-zynqmp-power.h
> +++ b/include/dt-bindings/power/xlnx-zynqmp-power.h
> @@ -6,16 +6,12 @@
>   #ifndef _DT_BINDINGS_ZYNQMP_POWER_H
>   #define _DT_BINDINGS_ZYNQMP_POWER_H
>   
> -#define		PD_RPU_0	6
> -#define		PD_RPU_1	7
> -#define		PD_OCM_BANK_0	11
> -#define		PD_OCM_BANK_1	12
> -#define		PD_OCM_BANK_2	13
> -#define		PD_OCM_BANK_3	14
> -#define		PD_TCM_BANK_0	15
> -#define		PD_TCM_BANK_1	16
> -#define		PD_TCM_BANK_2	17
> -#define		PD_TCM_BANK_3	18
> +#define		PD_RPU_0	7
> +#define		PD_RPU_1	8
> +#define		PD_R5_0_ATCM	15
> +#define		PD_R5_0_BTCM	16
> +#define		PD_R5_1_ATCM	17
> +#define		PD_R5_1_BTCM	18
>   #define		PD_USB_0	22
>   #define		PD_USB_1	23
>   #define		PD_TTC_0	24
> @@ -45,6 +41,5 @@
>   #define		PD_CAN_1	48
>   #define		PD_GPU		58
>   #define		PD_PCIE		59
> -#define		PD_PL		69
>   
>   #endif

Applied.
M
