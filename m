Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9516C3DA49
	for <u-boot@archiver.kernel.org>; Tue, 23 Jul 2024 07:17:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 53FF488354;
	Tue, 23 Jul 2024 09:17:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="XSr66LIk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25AB0883A9; Tue, 23 Jul 2024 09:17:06 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazon11021112.outbound.protection.outlook.com
 [52.101.65.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C67F841BC
 for <u-boot@lists.denx.de>; Tue, 23 Jul 2024 09:16:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uUqBJqUS2vXs/YFs42N2Pdb2LhYf9Hwq8Tgjx04QNQj//hVEBBG4FXIgxs4zwHuCcCPxoKGBrSjSmCTz4qwcQKQLR4Nq8pgpfUbKPHIDozWhIDb1GsTdumqg5zqIS076ONvJurJjH8IIXY7q5j77JLMjCHZy0OCsw9HDlevI4JONtJkVRnRYivo+eWiJMkUt1Xp94/HK4IZw2pLvF9dZr9Ahd46IsZ6sLI++uOyrrL07FMwBHJTu4Axf27TERUNoNv1g3xuMW0zYXTbO9cwUxlfmry4a0ESnEISGbIYqOjsi7x0UvYiSsU5hVsDlG511GUVREKlv1D7wohOkC4Ii7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qPPJrSaoB0OdjC93uZaOlSomO7r0mk8iUqjl5t73A+0=;
 b=CFIE5lkjkR0kZAq70xUc+Rtq33IQjf18QvDgQ0izoSKAzktkRWY7nwOdNx5HP5TVicCrNQk4Nrpapu0899tuZU2iGsN6OsG5QGzj0GCJmXUmJvLqB6FRVOKXNIcyIdJl3ggkxuz7QQgUYOanE5lA1BfG8DEtHq1zlk3S2V1+PEou4WBwV2TF5J4eFmSN2GNI7Hg9Nvlae0R6f4EJZqca9Au246OvjATVp2wPxDKUHuIafa9jm6B8lL1AeOzVxBZvhCuQy0Qrv+YRhLMoWZBcS1VgBAbyLZT7Tsdhq2waUffzRzW95GkpkBM7RScDs13dsNlhBWLmqBgza11i0D7Baw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qPPJrSaoB0OdjC93uZaOlSomO7r0mk8iUqjl5t73A+0=;
 b=XSr66LIktjmGwhQIH77L5ffSRkx4JBzxOKMjtvkftj2Jy92XpLvRwftq20vhOPD1ab3IRksGZltotKMreOANhNZMnOXwbhrmxUFcC1/DaFJB/xX78qHlGTU75EVXzEL540/Xxgc9BrJgZ3icWKNlH/D91wRwUZB1vg+4nDLkDOw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com (2603:10a6:20b:409::9)
 by GV1PR04MB10305.eurprd04.prod.outlook.com (2603:10a6:150:1d2::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Tue, 23 Jul
 2024 07:16:34 +0000
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea]) by AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea%3]) with mapi id 15.20.7784.016; Tue, 23 Jul 2024
 07:16:34 +0000
Message-ID: <c68ab077-063c-49f0-b345-dffe4db28bb2@cherry.de>
Date: Tue, 23 Jul 2024 09:16:32 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tools: Add script to update git subtree projects
To: Raymond Mao <raymond.mao@linaro.org>, u-boot@lists.denx.de
Cc: sumit.garg@linaro.org, jerome.forissier@linaro.org,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20240722193052.57592-1-raymond.mao@linaro.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240722193052.57592-1-raymond.mao@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0303.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:85::17) To AM9PR04MB8906.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8906:EE_|GV1PR04MB10305:EE_
X-MS-Office365-Filtering-Correlation-Id: a0f1b4ab-b5c2-4beb-ac16-08dcaae76204
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U0I4NEdUWk5mam5ITmYzVmhYSmNiWkM1Wk5nMUV3djQwbnVFRkF5SzFmT0tU?=
 =?utf-8?B?Nldna3MxNmlDbEp0dFZMZW1YN1VkOWVOSlc0S1NNazFZbDR5ZDFlaVhZSlJr?=
 =?utf-8?B?U0g5T0JkYU55Tjd2QXZDNkY3WGlsdHNtN3NqTFZOeDZGU0k1YUI5dldaRFpW?=
 =?utf-8?B?UTgyRWlHVG91MjZmdDQ3MVlRRnJXZ2hPNEJ3aDdYRnNsWUtSMHluaThqQzgr?=
 =?utf-8?B?TmVUUE9yVjMyeU5FekZ0dGRqU1psbTFmeldqUldkZk1LTEFjeGdwWjRKNENv?=
 =?utf-8?B?aWZmc3hBRDhPRXJHcnR1blVlUWdYMkxWbDRnZUNHRVRQMlFob3ZwQXIwU3p2?=
 =?utf-8?B?b3Y2RlQzckdLRzhFcFBtb0I5ckxyLzBKNjRjbEVlT1dOSFdNSEZWNS96UW5E?=
 =?utf-8?B?OFRocTNKVENwbERCSnc2YzVSemhzUjN6dk1TODZ3eWZzU2VoaUVqdVJmZE9Q?=
 =?utf-8?B?VUhHZmZsenk5aWRzeURnNUpibGswSERKek9JUFVSU1Y5WDQ5Smo4SFF2ayts?=
 =?utf-8?B?MVZpQ3NDaDJOTXZ5NWxUNXJOeG5PVlNrbWdLVXN5RU5wWTREMnQwMDJmeXpI?=
 =?utf-8?B?aHJobXA5bFlUSkhaakV5RjZmZnpidGRtK2VzR1gzak5hODY4SXZUblNnZm5s?=
 =?utf-8?B?eWpybkFwSlRhK0toSEpzVFVXNHFLZDFqU0RyWm1XaWQvNDBaQlBzVksrd0xY?=
 =?utf-8?B?Tk9tY010Z3pCanhCZm1ZbUFkTzNsL3lWWXdvRzN2RTFhZ3plOU1SQVRSdk5X?=
 =?utf-8?B?WHNHcWNBekRaOUhYaTUyd2NXcjcvWmllNFVFd1lSM1RyUGhKNS94NWRFZHNE?=
 =?utf-8?B?K3YvWWNWTDU0SWE1YnVuTEZEOU5ZOEJQcm16L1d5YWlWMUoyYWhsT25IVjdD?=
 =?utf-8?B?bzNVOCtqV1NZN01ZTXZtRGh0VW9ESWtIZVpaaWIzV2JQNnZaN1YydU5qaDJV?=
 =?utf-8?B?WUUybGl4NzhidnlmQkZNWjF3RHZoWDFZcXRPMVUrMWhJTnZnSjBFQS9wQVlX?=
 =?utf-8?B?YWpjVkNDc2JkYTBhbnUzVzVqZUNCNUM3RFR2clZXZUtVdjdhZFBUUUZKb2x0?=
 =?utf-8?B?Z042V1l3ZnFlZVZKZHc3YzhuNW8wWkFzTzBKVFVjemtTTjVLSkgyeGRPUFp0?=
 =?utf-8?B?aTBnTS9RV2RRWVQxSVI3N0dsd24rdElPYnNDRnpvUUNJL2xrRzFKMmsraVJh?=
 =?utf-8?B?OEl4bnNzdm1tbmNJNEw1MDdNQkMyOFRXUDlubFFGN09KR3Z3ZkEvaExxb0lE?=
 =?utf-8?B?bjBkUWJaNVVOejFwcnY3L1BMc2J5RDA5bkxQUnYxZEk4UVpMRmVyQkhOaEFq?=
 =?utf-8?B?ZHlCaG56Z20rNmN5NFBBUm9aUVljcWRVcXdBTU54aG00MlNKZEJHdXhrRUhF?=
 =?utf-8?B?eEVJTGJ3L1pzM1NuMDd4V0pJYitxR015cE83NzZyTGEydlB0bUpQVlBNbnFJ?=
 =?utf-8?B?QTlKbnhqY1dhV2ZmdXlOVUloeTVwOTFCUytjWCtaeENNTnlvMEJRWXZBSzBu?=
 =?utf-8?B?RGZ6YVFmcThkMUszSzFKNUgySkpGTEdXRXJ0UUNabG9ZOGhvVTllRlNndWc3?=
 =?utf-8?B?alRXb1RmTmNoN2t0NVBiY1BPVEJBS1M3VzF4RUZyRXl2N0gwT3RDbDBwc1N3?=
 =?utf-8?B?a0tYWjl0aUh2ajNCMTd1aG1aREFKYmRRUmZZMERrNURQOTdZdjZqLzBwQmpn?=
 =?utf-8?B?a0tpZXpSWkI1N2hYcjR3RXJYU0NEUEFEZGg3ajZVRHI0MmFjd2FrQUlidXB6?=
 =?utf-8?Q?nZd879G6Dy8muq0h3M=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8906.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UU4zaExjbjRnWFpMSlhhUDUvU2JNQ25ZeHlLVzU4N25lcVB2MFdmZWExY3ly?=
 =?utf-8?B?eVhORjVvR3BURmdLYWlGZkNJUldnZzhmeWlOaFh0TUN2K2NPajRtQURKeU42?=
 =?utf-8?B?NVphOUxsSkRUN3dNR1ZrRmhnd0VUcldpcURNZjZtK0pQb0VPenpvTE5xaVBt?=
 =?utf-8?B?OWh3ZW1KWHdPaURpMzN4d3JLTjl6KzNIeitGUTNrTGEyVG5YamIyZXJ3Q2tv?=
 =?utf-8?B?Y2JPQkxvS2NMT0F5T1VtV0pVOW1QMy8rSzlXaEdtZTF1UzZnNVhBUEFsKzla?=
 =?utf-8?B?Ui9MalBnRi9ScHJPOERpMTBiaW93MjVWMTBwQlA1SUhTbmpMMHM0dEd2NFRI?=
 =?utf-8?B?VUMySDFTMDdydnhHSURwaTYyZERjZnlTMnN6ZnI0TlhMUjVkOTg3R0tSZFF6?=
 =?utf-8?B?dEdPbjhrUzBVR2RZKzhDdGt5bzA2c3puQ2JWQkJsQU1aL2t1bjZsZ3dwWFBM?=
 =?utf-8?B?SmxKTTNHS0ViblVIWTdnNkprRTZQZjRqeVFldjNQRStxbU9WSytCNHhOemxU?=
 =?utf-8?B?WVp2ZzN4NEVIOUZMcllsYkJodFE5ZE16OE9SdktWaHVYZzNzSGw1eFdzeHVj?=
 =?utf-8?B?NlAyQ0Z1KzIrSnZFdUVCRXVDK3lxbjBhblhkSSswOFR1dVppekdqKzV1VnJw?=
 =?utf-8?B?TVoybnFTTlh3akhaa08ydWtIdXRBbWg1L1REVHpoY2g2WFNrdkFOZDBpbzBG?=
 =?utf-8?B?M3VGSlBPNEwweHM2Rzg4emxHTlp6OG1seGxZUmc1eXN3clNxUVY5NWNnT2JI?=
 =?utf-8?B?Wi8xZVlVWUpNbWx1Vmh1cXZuVWxldWR0T2w2cVRxODcrVzRTUU9SYnJoY2xm?=
 =?utf-8?B?S05YaDBCZWFNL2hGS3N1OGZsZnpaRTdJdXNISmY2WTB0V0NjZkM3bTdsUFFS?=
 =?utf-8?B?U3VvRmJHcjZvSVVJNlBBMThBQWpCSFNoVG1PVHE5WmZNS0pQeFpnYS9qS1k5?=
 =?utf-8?B?VnBmaDBoYTYxWXd0R0oxNFBWcEg3VjRmTVUrYXMzTXlHYnNlZXFTNStJMllh?=
 =?utf-8?B?TjZFTzRRYXFiZlk1YSt1bEdTZTk2ZktlZ0xWNEI0VTZwYmVHTkRwb1RHTmJC?=
 =?utf-8?B?aEtRcTN0N3NwSzNXR05IU1ZXZDVtZ3B4Z0ZCaVZxcStxQ044M2o5a2ppYytB?=
 =?utf-8?B?STd4VEVjMzhsa1FGVGhicjNQZnc4SjhPOVl4UVlTOWlEMERKa0RHUGhzRUZC?=
 =?utf-8?B?QkxnbzlyYnphdHdpRkxMQTFWRjc0SGJzakVpelR1djNMbXNnZ1IzTGpSREhp?=
 =?utf-8?B?cVJlYlZpTDMwbEZEcDhaWjRtRWZ0RVYva0VvS3NuZTZ2SnBTSGhTSVpnaWFo?=
 =?utf-8?B?MWVCRjlDQlo5Ynp4MVBBcmpiQnU5T3VFV3RuV0NBRXZjb0FWMGNEbmk5Vk9U?=
 =?utf-8?B?dDJkM0VVSlJrRHR4M3BvdjQ4bnpuU09uSHdNcnN1eWNKaFZmRDd3cVhsWFVv?=
 =?utf-8?B?Q2VFOEt3Tnl0NnVPMlhmRGZubkxOMDh2bEE2UWI0NG9TeUdzbWhUelljWFM1?=
 =?utf-8?B?MWw3eGxxTk5XMW9rZmYwVnZja0NDNHRkSzRqdk42b3A4cVZRY3hTbTFRUndo?=
 =?utf-8?B?MFc0alV2WGFCWWpDbVZldmlVNXNNTjZ1NjNkSkZsZDBaemlTZldWU1BqdjB6?=
 =?utf-8?B?eDUzazZXNnRSY1FRTlVnd2ZqS1EvN3hmSFJLaGhYa0p6SzVqSHRMdGxTVGNn?=
 =?utf-8?B?QkpZQWxSM2pCRndMRUx1Y2xFcWpmdFJ1ZGJabVpIUkRRTGJQU1RuNm9KeDh3?=
 =?utf-8?B?L3VReU9CUVFhV2ZFb21HcXZIdUtXMG9OTWM5NTJzNzJmMnBadUFwc2hDR2lB?=
 =?utf-8?B?QkhoNllqTjIzTHd1dWk5U2xIeE1kTEw1VWRrM0s3aVVhTVJPWmRUU2ttV1VB?=
 =?utf-8?B?Yk9jOFhwNGVXMkNYalNYM3UyU1VqZ0lFQ1Zab3hNWVlBU3o1YXlpNnk1V094?=
 =?utf-8?B?Z3FzdjV0SSs3cTkwaEFZN3ZWVGNHNVkybkFRL05nTWNyVDFtYnIvUmNZYWFP?=
 =?utf-8?B?eXkySUJtMnJDU0xBU3l2djdDZVBob0Rpb1FRMmlmYzBhRHp5NDFmeEJzT2Z1?=
 =?utf-8?B?M3RHZnJxajJwOHpZZ0dsckZUN0wwOVNyckNTUkZQd0cxbngxVXQrdmVoYkV5?=
 =?utf-8?B?czFLTFF6WGM2eW1rZ0pEN3hmY0dHT0tUVE54bEFLdmFYaVJMbTVaUnlUQ08w?=
 =?utf-8?B?UHc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: a0f1b4ab-b5c2-4beb-ac16-08dcaae76204
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8906.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2024 07:16:34.0155 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SIL4MIvyHP6kmJgfpRK5mMQGyxqU474P62v39hUXYttts1qy3aCsZ1jzIZLnG8yJRyJxEPDagDK6uX7cu5VXI5bOus7w9xJIfktnTYHsaNM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10305
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

Hi Raymond,

On 7/22/24 9:30 PM, Raymond Mao wrote:
> Recently we are introducing multiple git subtree projects and
> it is the right time to have a universal script to update
> various subtrees and replace the dts/update-dts-subtree.sh.
> 
> update-subtree.sh is a wrapper of git subtree commands.
> 
> Usage: From U-Boot top directory,
> run
> $ ./tools/update-subtree.sh pull <subtree-name> <release-tag>
> for pulling a tag from the upstream.
> Or run
> $ ./tools/update-subtree.sh pick <subtree-name> <commit-id>
> for cherry-pick a commit from the upstream.
> 
> Currently <subtree-name> supports dts, mbedtls and lwip.
> 
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
> Changes in v2
> - Refactored the script.
> - Update the control doc.
> 
>   doc/develop/devicetree/control.rst |  8 +--
>   dts/update-dts-subtree.sh          | 48 -----------------
>   tools/update-subtree.sh            | 86 ++++++++++++++++++++++++++++++
>   3 files changed, 90 insertions(+), 52 deletions(-)
>   delete mode 100755 dts/update-dts-subtree.sh
>   create mode 100755 tools/update-subtree.sh
> 
> diff --git a/doc/develop/devicetree/control.rst b/doc/develop/devicetree/control.rst
> index ca4fb0b5b10..211f7e4909c 100644
> --- a/doc/develop/devicetree/control.rst
> +++ b/doc/develop/devicetree/control.rst
> @@ -96,12 +96,12 @@ sync the `dts/upstream/` subtree from the devicetree-rebasing repo whenever
>   the next branch opens (refer: :doc:`../release_cycle`) with the latest mainline
>   Linux kernel release. To sync the `dts/upstream/` subtree, run::
>   
> -    ./dts/update-dts-subtree.sh pull <devicetree-rebasing-release-tag>
> +    ./tools/update-subtree.sh pull dts <devicetree-rebasing-release-tag>
>   
>   If required it is also possible to cherry-pick fixes from the
>   devicetree-rebasing repository prior to next sync, usage::
>   
> -    ./dts/update-dts-subtree.sh pick <devicetree-rebasing-commit-id>
> +    ./tools/update-subtree.sh pick dts <devicetree-rebasing-commit-id>
>   
>   
>   Configuration
> @@ -116,8 +116,8 @@ However, if `dts/upstream/` hasn't yet received devicetree source file for your
>   newly added board support then one option is that you can add the corresponding
>   devicetree source file as `arch/<arch>/dts/<name>.dts`. To select that add `#
>   CONFIG_OF_UPSTREAM is not set` and set `DEFAULT_DEVICE_TREE=<name>` when
> -prompted by Kconfig. Another option is that you can use use the "pick" option of
> -`dts/update-dts-subtree.sh` mentioned above to bring in the commits that you
> +prompted by Kconfig. Another option is that you can use the "pick" option of
> +`tools/update-subtree.sh` mentioned above to bring in the commits that you
>   need.
>   
>   This should include your CPU or SoC's devicetree file. On top of that any U-Boot
> diff --git a/dts/update-dts-subtree.sh b/dts/update-dts-subtree.sh
> deleted file mode 100755
> index a57b78a41d3..00000000000
> --- a/dts/update-dts-subtree.sh
> +++ /dev/null
> @@ -1,48 +0,0 @@
> -#!/bin/sh
> -# SPDX-License-Identifier: GPL-2.0+
> -#
> -# Copyright 2024 Linaro Ltd.
> -#
> -# Usage: from the top level U-Boot source tree, run:
> -# $ ./dts/update-dts-subtree.sh pull <release-tag>
> -# $ ./dts/update-dts-subtree.sh pick <commit-id>
> -#
> -# The script will pull changes from devicetree-rebasing repo into U-Boot
> -# as a subtree located as <U-Boot>/dts/upstream sub-directory. It will
> -# automatically create a squash/merge commit listing the commits imported.
> -
> -set -e
> -
> -merge_commit_msg=$(cat << EOF
> -Subtree merge tag '$2' of devicetree-rebasing repo [1] into dts/upstream
> -
> -[1] https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git/
> -EOF
> -)
> -
> -remote_add_and_fetch() {
> -    if ! git remote get-url devicetree-rebasing 2>/dev/null
> -    then
> -        echo "Warning: Script automatically adds new git remote via:"
> -        echo "    git remote add devicetree-rebasing \\"
> -        echo "        https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git"
> -        git remote add devicetree-rebasing \
> -            https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git
> -    fi
> -    git fetch devicetree-rebasing master
> -}
> -
> -if [ "$1" = "pull" ]
> -then
> -    remote_add_and_fetch
> -    git subtree pull --prefix dts/upstream devicetree-rebasing \
> -        "$2" --squash -m "${merge_commit_msg}"
> -elif [ "$1" = "pick" ]
> -then
> -    remote_add_and_fetch
> -    git cherry-pick -x --strategy=subtree -Xsubtree=dts/upstream/ "$2"
> -else
> -    echo "usage: $0 <op> <ref>"
> -    echo "  <op>     pull or pick"
> -    echo "  <ref>    release tag [pull] or commit id [pick]"
> -fi
> diff --git a/tools/update-subtree.sh b/tools/update-subtree.sh
> new file mode 100755
> index 00000000000..5946aa1a9e2
> --- /dev/null
> +++ b/tools/update-subtree.sh

We have scripts/ and tools/ directories, this being a shell script I 
would have intuitively added it to scripts/. So my question is, what's 
the difference between those two directories :) ?

> @@ -0,0 +1,86 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0+
> +#
> +# Copyright (c) 2024 Linaro Limited
> +# Author: Raymond Mao <raymond.mao@linaro.org>
> +#
> +# Usage: from the top level U-Boot source tree, run:
> +# $ ./tools/update-subtree.sh pull <subtree-name> <release-tag>
> +# Or:
> +# $ ./tools/update-subtree.sh pick <subtree-name> <commit-id>
> +#
> +# The script will pull changes from subtree repo into U-Boot.
> +# It will automatically create a squash/merge commit listing the commits
> +# imported.
> +
> +set -e
> +
> +print_usage() {
> +    echo "usage: $0 <op> <subtree-name> <ref>"
> +    echo "  <op>           pull or pick"

I think pulls are supposed to be done and sent to the ML by maintainers 
only? At least that's what we're supposed to do for the dts/upstream/ 
directory AFAIR. Is it the same for mbedtls and lwip? If so, maybe 
explicit this in the usage that only maintainers are supposed to run 
this script with that option? And if you need to do it, ask the 
maintainers to do it for you? Does this make sense?

> +    echo "  <subtree-name> mbedtls or dts or lwip"
> +    echo "  <ref>          release tag [pull] or commit id [pick]"
> +}
> +
> +if [ $# -ne 3 ]; then
> +    print_usage
> +    exit 1
> +fi
> +
> +op=$1
> +subtree_name=$2
> +ref=$3
> +
> +set_params() {
> +    case "$subtree_name" in
> +        mbedtls)
> +            path=lib/mbedtls/external/mbedtls
> +            repo_url=https://github.com/Mbed-TLS/mbedtls.git
> +            remote_name="mbedtls_upstream"
> +            ;;
> +        dts)
> +            path=dts/upstream
> +            repo_url=https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git
> +            remote_name="devicetree-rebasing"
> +            ;;
> +        lwip)
> +            path=lib/lwip/lwip
> +            repo_url=https://git.savannah.gnu.org/git/lwip.git
> +            remote_name="lwip_upstream"
> +            ;;
> +        *)
> +            echo "Invalid subtree name: $subtree_name"
> +            print_usage
> +            exit 1
> +    esac
> +}
> +
> +set_params
> +
> +merge_commit_msg=$(cat << EOF
> +Subtree merge tag '$ref' of $subtree_name repo [1] into $path
> +

I would recommend adding at the very least the path of the tools used to 
generate this merge commit (so ./tools/update-subtree.sh or maybe just 
$0?) or maybe even the full command line that was used to do this merge?

> +[1] $repo_url
> +EOF
> +)
> +
> +remote_add_and_fetch() {
> +    if [ -z "$(git remote get-url $remote_name 2>/dev/null)" ]; then
> +        echo "Warning: Script automatically adds new git remote via:"
> +        echo "    git remote add $remote_name \\"
> +        echo "        $repo_url"
> +        git remote add $remote_name $repo_url
> +    fi
> +    git fetch $remote_name master
> +}
> +
> +if [ "$op" = "pull" ]; then
> +    remote_add_and_fetch
> +    git subtree pull --prefix $path $remote_name "$ref" --squash -m "$merge_commit_msg"
> +elif [ "$op" = "pick" ]; then
> +    remote_add_and_fetch
> +    git cherry-pick -x --strategy=subtree -Xsubtree=$path/ "$ref"

Should we add -s there too? (or --signoff)

Those are just questions, no blocker for me.

Cheers,
Quentin
