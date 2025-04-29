Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B3CAC369DC
	for <u-boot@archiver.kernel.org>; Tue, 29 Apr 2025 14:04:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4DAB48272A;
	Tue, 29 Apr 2025 16:04:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="hKmp4/mw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B363B8293C; Tue, 29 Apr 2025 16:04:40 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::601])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8760B8215F
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 16:04:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e0LSRfpfqXaxdY3iC18MPn6CIaC3T7qPrJMkKV6WvieQsfU1jouuriJg57kg6Ht5u/Qs9ot1aix3iAmxSLd82POiwRnZpe1BdYDTs7Y59IwHEzldcOpWNAprpJMr1P/WRNHpe/D8CNI1g6qHPAJuhiyGEwuif6i9l54tslS1xDFhh00StXSjCHmDj/zHml/6IHPuptE1Kxitf/YLvW5V9oorYMEVABx6Waxa6JhR8xPq0lY8YGvCH9trorrDbn+lhPDyCy5Spohk/6PksWOest+3KzPMs/PM/tNnkHGImhaUA464ldsC1/KnyZMMd2GkFmECkc4tAsNPZ+Z3MfGJqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=phfL6OTo/NlrjGGxLtMQvyPWFIKvcu2sXMlHAgWcUJw=;
 b=xVUKzBDqt3hFQzDQqDez2RRNjuD7FdXPatJSA68lY57iDY9QDt1vV3oy7RAps7uktYC/09iEYtrdOiSy5yg9w2lbIk3f0LlKdb9RseeLrVk2z3uFHvxgdV5rzSOGRyWRcEF0KaVxgRJb3qc2KVqBlIsAQElSkLy58Pbidhp6ZOu3tjdqaEz/bVxZrLs6WV2I9NrkECjeLZV2t7Q9S05h6NL1Z8r6LePbp6+HbpExs0wdb6V0aua5DrHF77epE7jgB40P2cxniEJrmO3xh+zgwzN3eAnPEwUcIAxNOjVy6q8U/WB1OxA9nKQstYL1mowl3WVE7/UsM923A2S8nZ8FCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=phfL6OTo/NlrjGGxLtMQvyPWFIKvcu2sXMlHAgWcUJw=;
 b=hKmp4/mwRmL4T3GUIwg2RkMVR6s465VfFZ3NGM/mvKfzJpZyOm4qAqCiDj0GYzUGsQ/fhUb6Z+4rSR3fc46piFepA0qtb71K+QeOJe+qCmkGHut+nY7l3oG7DlqWfYMYaAYItc7Txl0VYB5jEpRiF8fWRpT9N3B2vJ3PI+61zTM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DU2PR04MB8840.eurprd04.prod.outlook.com (2603:10a6:10:2e3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Tue, 29 Apr
 2025 14:04:36 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%7]) with mapi id 15.20.8678.028; Tue, 29 Apr 2025
 14:04:36 +0000
Message-ID: <290f70ad-bc06-41cc-910f-cecb89bdd6ff@cherry.de>
Date: Tue, 29 Apr 2025 16:04:32 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] tools: Update the license specifiers
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List
 <u-boot@lists.denx.de>, Alper Nebi Yasak <alpernebiyasak@gmail.com>
References: <20250429131515.244061-1-sjg@chromium.org>
 <20250429131515.244061-2-sjg@chromium.org>
 <016f585f-fd30-4604-8676-c7cabd9e40a1@cherry.de>
 <20250429135241.GC1261075@bill-the-cat>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250429135241.GC1261075@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0046.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::15) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DU2PR04MB8840:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e69a074-c46b-453a-4f7d-08dd8726c500
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VmxmUm5PWXB2U0pqV002Zlcwc0xWQzZOQm9DUktGaVdId1dxVjJicVhISkJs?=
 =?utf-8?B?ajdTR01wNDBESjVzQjQwWmlUVG5KbUlURlZwaU9HWDhReWIxcE5JMDdWM3RN?=
 =?utf-8?B?eXZ6QzJvQkJVbDZKL3dhc0tpWmQ1bkRkdUtidlAxV3o2ZGFTaFpvckZvOWxY?=
 =?utf-8?B?dE9CcENDY2xQTVcvOXNkS3lzZ3Y1cEtRT3dKVitLeU1OeEc3c0l1VElMcjRK?=
 =?utf-8?B?bTcwK2xjU2VraGd1WnpsZFBrSGJzelNzNU9Jb0UrbVZKYVNSaFNmZHR5bjUw?=
 =?utf-8?B?ZnM5SHJlL0Q0aHNmQmNRbmEwdkdvZk5YVkQyUlp0U0JEei9VRk1MeHlwNDlU?=
 =?utf-8?B?cEkvRjhOR2drcWZFMzUvLzdoOU43Y1Zqald6b0JHdUZpQ2VIZ3U0ZzJDL05r?=
 =?utf-8?B?eTdpOTdKRDcybktVb3JBdzZGTWVEb1dHSy9pNmJWY1pXUWYrb1pyUUZwcTc1?=
 =?utf-8?B?U0tkazNmN1lMU0lJclc3ZDVsRDZ3OWVGRUx0TS9EaDRlSC9IcmlDaUNma2ls?=
 =?utf-8?B?OTBWY3NlNTFid1R1OWxCY1RpZjZkWGw1Zmc2MFlhQS9NY0FyWUJKN003VVJC?=
 =?utf-8?B?clEzcDFtemZ6RXdGR0lWUkhkWkY1bGpDRDlqelFIeHA2bkVUN1FwUmJTdTVy?=
 =?utf-8?B?YnFDM2xkTm51YzcrZWJ5NXJad0pvQmszZWI0WGE3RFBPTWRuOFdteEVROHQr?=
 =?utf-8?B?ZG0wWnZ5OXFEZlpjcHVPMkZlaDFTZWdoMDRkVG5id09zVytoeTZkRjVhWTFG?=
 =?utf-8?B?UEZBdDR3a1ZqQmd6dUxPdTlHM3FMaGlBRC83dktKb2FRRDJuQlNSc052Z1Zz?=
 =?utf-8?B?Qy9tMXBJYkt0QjBZcmtLeGt2YU13bGZGV3Bxd1RtbHdoSWhjb2hwNUtXUU4x?=
 =?utf-8?B?YUlsN3hiRStMOFFnOFZlQzl5SXU0RmRaNkxscE5pU0NuaUVTYUVFLzA2aWcx?=
 =?utf-8?B?TnowR2Z2dGRVaXlEb21MZUNpbVlNWnV3NllTckdwT2w4Yy9rV0FhSEd2Q1RE?=
 =?utf-8?B?RzRlczRjZE83RUJ0VytOdHZEOEZ6OUp6cU5hUHIreWY0N0RSaC9vdnAzOHVh?=
 =?utf-8?B?Z2s3MnhuV2ZJaVhpekEzbWd2THFaT3l0VFpXRGREaERpVndZQmtzbTlMNXhP?=
 =?utf-8?B?aUZLcU9BR0tiWFM4ejNOZVRqZkthSitQSTlXRFcvemxhSTdLdWhVTmw0N2lP?=
 =?utf-8?B?TG41QW5sNGZaU2tHREtBUWVwRWJJN21zNUhhekVQTmF1SVVvcEVVQTlKQ09w?=
 =?utf-8?B?a3dLcWxjb2orOXZLd1VtWmVVNWJUeFNFN3pVVjJ0NndrNGxEaGVUQi9MUmY2?=
 =?utf-8?B?bmJUN3Nkc25aUk1XS1UrcHlpUFNCSUxJWXhjOGpkMnRLd2JTcW9wN05nT1VP?=
 =?utf-8?B?RkY4SGZlSldDSFloU0U2Mi90d01lS3lqcTVtSGNhQ0ptR2dOTUJWeUk2eTRQ?=
 =?utf-8?B?MlliaDVDSUFOcWdXeHhpQ0swL1B6dWlnMklFNGg3aEdYUUdaMVMrSnVxQlNC?=
 =?utf-8?B?S2VoNXFXK1RETWNHc0NHZ3N3Y0dkV2luaVhIU0Z3a3dqSDBlWFQwNDBmZE1L?=
 =?utf-8?B?Sk12SmYvS25NYTlDTnN0S1RFWngzN0FKa3V4STNwME1QbFBUUkFtNHl5RFE3?=
 =?utf-8?B?bDhhWFBmc3Fuc0FZbU00L2JiYUVESWFpV3ZxbGp5L2xXWFFtdDVGbmVPQ2lz?=
 =?utf-8?B?bW1rZ0t0RS95ZUZ3QzJRU0p6MXovK01WZ3J4WmM2aEc3Ym14aC9rRnczNHdT?=
 =?utf-8?B?cUhQcVBsTE9JQ2w5UkVKRkJSMzVJRlNueW41VXdyVzBvWEUvVVBUamovQ0Ex?=
 =?utf-8?B?T2MvV0Nwa1VNcCthaExscVNTU21iZHZrS1loeE9JL0hGeVlhYllNbVR3Ly90?=
 =?utf-8?B?MnIwRWEwZysxRzlBa3ZBOVFKVExITTcwNWZHaWJSYTNhcE5xaVVDZ0VHZCtU?=
 =?utf-8?Q?/VSZ4oiijE4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZzhvMG1jQ0U4Q3NBdlhpSWtmalA3M1VsTTA1enlkL0UzazNmMU85Yi8xanhZ?=
 =?utf-8?B?Yzl2cDRGV0tUcUk2QUVuU1hZZTlvR3hJQlRSNHE2U3ovZE41dEYrdlZXNWFi?=
 =?utf-8?B?TWVOVkZnYWRLVGZCcXNzc3RkeWQ2Wnd5VmU2enNyLzNtZmRFampBMDJJNm1X?=
 =?utf-8?B?NVdSQnJmSE9GbndOQS9YbmVDdlNYWDJ1ZDFrMXBVTk00OEVqME9NWDI4bTBl?=
 =?utf-8?B?UWdmMmtIWUU0Q3llRysrMzFXWk1RVzdlTVZmL3VYVjkrU1pUenJQK1lWS1Zm?=
 =?utf-8?B?MmRwakg4S2prUnRNdDdKQUd0aVBja2Ftc3VhcldOaks1VnN3SXZKWFNNVEZr?=
 =?utf-8?B?eXB6UGl3SXg2QVdUdWxjUytiNjFhY0d3di8zZDA1TmNOR3lRQkFZTC80YmZS?=
 =?utf-8?B?MmtPcnpxSjFFLzVsYnFGQjRXZVV0ZzIwMXB1YmwvTTFIbFNRSTN6dkd0TEtG?=
 =?utf-8?B?SnRpVVhmSTFzTGFxVUhBY0hBNXhrMDVSVTBGMFlDQTU0eXdCYllJcFFoU0pV?=
 =?utf-8?B?ajd3VmU2SlVUcGtyKzBEQUdGODVnUWFGQnhobmZKeXRJSStJNnBpQ2hPdGZD?=
 =?utf-8?B?VFROaFFxaHVmQXJIT2FaTHFLL3NOd3FXNnhiYU9jMzV6RkF4NlhIR0M3a0N0?=
 =?utf-8?B?OGlydk9zT00ydVpoTENSVWl4OUV0eGM2MGQ3a21rYll0QTlwd0dRQkYvZ1lV?=
 =?utf-8?B?SlFOZjg2NlFHVmNBZEpEbEU0dmhWdzhHUXhjeHM2a0wyU1kxb09nc0ZVUzlt?=
 =?utf-8?B?TEs2SHVrR3UxTGFmbTJCdmhoM0Vqa0h0TUY1TTR3aUZKSFMyY0ZQQ3pKazha?=
 =?utf-8?B?TVBiMmlUTzJVempkOEk5L1czMWNlZ0dKVHB5UTBHOGV6bEVSKzMzSXcxd0sz?=
 =?utf-8?B?cldZNHJ6V1R5dnV4aWpLZHdQMFV3Z29YUGpHQ1pjcDBHSGxDazEyd1diU0Mr?=
 =?utf-8?B?SURXTjR3WEZ4T2FRMDZCeWRCNUJMdHA1bWVGT3lEUUthVkh5Wnl4V1lzdjNj?=
 =?utf-8?B?S1lWM2RPL29lZXowSXZDR3UxWk9wUFQ4bXRRZzdtSWFNZ2FHMmxJcS9QMFFj?=
 =?utf-8?B?UWptakpWemRYMFMycC9pS0lMQ1B1c1VnblRrcDlHT3MrZXEzQ25iVjVpcG5m?=
 =?utf-8?B?TVJKTStPcElCZitleDBoZDdQYmJBbTF1SlZienJHeUFZV0J3dlI3WDY0Szd4?=
 =?utf-8?B?b0QvdURsVVNoWTU1L3NXU1ZOTGovc0pjQ0o2Q3kzejhSUnoxcEhZaXBxVU5s?=
 =?utf-8?B?cHpESUYrVW4rWkx5R243S3pTWTd0Qm9DNlRNbktLK3lmbzNIWW9tbkUydU52?=
 =?utf-8?B?aWZVOFpKcXJ3aGxVM09BSjRqVzFIcFFxZlRxVlF5KzV4RXZ5ZE4vUFNKRE1v?=
 =?utf-8?B?N0ZxYmpXblJ1dTJQZGFlYXduVHAwdVRvV2wvQzM2aElZZE5YdXdMbkZzNjVI?=
 =?utf-8?B?enlKcUE2K2RQTjVyaldiTlZtdFU4aXpaaGduY2RiVnhtUGVrUHhaTzRIN3R4?=
 =?utf-8?B?aGRBaC9QUDk2ZUlkRGxxMWJGZkRCdExnVXpmSUpCYWVPcHJaMklrT3l2S0tu?=
 =?utf-8?B?VkxTODIvL2Y1dHFsTis3eXF2UllEM1Znb09JODFXVUR3cUQ3NGJYT0JNNUhk?=
 =?utf-8?B?V1lVOTdidW53TjJOLzVsVGdzVHh6T0hKYmdYQnZ2YVAvRVdkN0RPaGp6ck9P?=
 =?utf-8?B?VmRlWTBPbEJraTZCa09wSlpoWHFIWGhRbzR1eE5KOXVMLzlBYk4rb1h6ZWJa?=
 =?utf-8?B?d05VckJPNEd3M25XQ01UL2FWVjVzZHZqRStaVk9KSm1QUDY2UXJVV3gyRnBV?=
 =?utf-8?B?UXBvWFEwcDkxVjRLUkw3VVpRKzVHNzdGTnhGM2h0OHlGZlNOR3VXZHdmTkxE?=
 =?utf-8?B?T21tN0Y2UHZTRC9YN21kVDZXdmJwa3JackIyMVcyeTlWZWMzalBPcUIvdmpj?=
 =?utf-8?B?ZzhFaTBiSEYxQWQ0b1ZxQkNjVWVnUEhEVHNKdk9OWjYrK1gxMWxHTFVqRE5w?=
 =?utf-8?B?dFNPTC9IaVdaUXNCekJ4RUVOQ1dtRzNmNU45M2JlY0tkVnFDd3dFUmtJVVRw?=
 =?utf-8?B?RDRWaFNSSWw4NUlhak5MWUg4VzBSUlEwUnlNVU5GSjdES0N0My85ZXROeFVO?=
 =?utf-8?B?cjA4YjE2Ykh6TEFZeDh2eStsdkFqaDRFV29iVmNkSXU0MmU1RVhOTFRJTzVH?=
 =?utf-8?B?ZHc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e69a074-c46b-453a-4f7d-08dd8726c500
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2025 14:04:36.3494 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nsTHVHmTuRHO1n6J9w76tk0Pjm1+uUZPirhBvIa5HgWiHvnVDAOHW6qNkHJX3aSUEEv/BhD8TsOUNYMSDyujHuYzsCf3hKay1OJn9deCrYM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8840
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

Hi Tom,

On 4/29/25 3:52 PM, Tom Rini wrote:
> On Tue, Apr 29, 2025 at 03:28:35PM +0200, Quentin Schulz wrote:
>> Hi Simon,
>>
>> On 4/29/25 3:15 PM, Simon Glass wrote:
>>> Recent versions of Python complain about the license being in the
>>
>> I believe this isn't related to Python but rather setuptools.
>>
>> setuptools 77.0.3 and later support PEP-639 which recommends to ditch the
>> License :: classifier for a license property.
>>
>> The issue is that this license property also changed in PEP-639, with
>> something that isn't compatible with pre-PEP-639.
>>
>> Therefore we need to bump the minimum requirement for the setuptools
>> dependency in the various pyproject.toml to 77.0.3 or later.
>>
>> I'm also wondering if we don't need to add a license-files property (also
>> PEP-639) to comply with the GPL-2.0-or-later which requires to provide a
>> copy of the license.
> 
> Thanks for digging in to this more. Is there not some way to both meet
> the PEP and utilize SPDX?
> 

AFAICT, the license field is for the SPDX identifier.

Not all licenses require you to provide the license to comply with it I 
guess? But my reading of GPL-2.0-or-later makes me believe that we need 
to. You would then have the license file(s) included when license-files 
contains a file that is found at the root of the python project? I 
believe that the default value for license-files is ['LICEN[CS]E*', 
'COPYING*', 'NOTICE*', 'AUTHORS*'] so it could be automatically included 
(and thus the license-files not be explicit) if the license file(s) is 
named like that.

It isn't necessarily a big deal (IANAL) to not have the license shipped 
if we don't plan on pushing those to pypi or share sdist/wheels through 
another mean (e.g. GitLab/GitHub releases generated with `python3 -m 
build`)?

I am not sure exactly what you meant by "both meet the PEP and utilize 
SPDX" as I believe they aren't related here? I mean, license property is 
the way to define the SPDX identifier in PEP-639, but the missing 
license-files doesn't have anything to do with SPDX I believe? Just that 
it wouldn't be complying (I believe, still haven't become a lawyer in 
the last few paragraphs) with the license itself if the license file 
isn't shipped.

What I meant is that in order to use the license property, we need to 
bump the setuptools version dependency in pyproject.toml so we're sure 
we're building with a recent enough setuptools.

Let me know if something isn't clear, I just happened to have had a 
glance at the PEP this morning for another project, so I am as confident 
as someone who spent 5min reading a spec :)

Cheers,
Quentin
