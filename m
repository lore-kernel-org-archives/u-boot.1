Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42C36D65C5A
	for <u-boot@archiver.kernel.org>; Wed, 17 Dec 2025 14:51:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ACD6F83B49;
	Wed, 17 Dec 2025 15:51:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="Z+bGxb+2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 905D783B7F; Wed, 17 Dec 2025 15:51:10 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60A4D83B32
 for <u-boot@lists.denx.de>; Wed, 17 Dec 2025 15:51:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pi9C0FQMXG6xko/AKMvYaG4UBMWk5IboUiqRnCAVp0bqf/zfDhdA/mHdlyVjJCCegeuS0S7tgOSyD1CmnpzC17SCFvU3DcbPF01NyHts5HLl960pjrxM8Qbt0AMQJsBZGE3zqpeufDL9rEK+b1t5rQPm40xkbBVo22IbcXGw5Ruc0fcQkqSqHKuDgOBDdJv0ssG094KDcFnrMxoFLmPujTOKhmfDT1GqOD7O08mZfroM1lR8rfdC2Nhz/dj06ZE3UdqNus44XMWar6fGM73TpXQiFzAgWg4c4WgqpV8fI5ReHoDLQPHR/qyK4qoEQCfGMF+HIrY6Dz8AgRVQrOoRPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B4KQNw2A+tn1bp3ZjOj98ScouoBlbF5W7xJjaqfaDtA=;
 b=hdWSznlK89gYbEAQPz4OG8B3IbC/nMtWOU2n8KgR2B0GJmagpDTveEAiwk/Xw3vtQBjX/+o9L0zt8XVejGb0LQ1wtWMNTe9fPI69T/Mp8UCaem8QA5RQQ4EuITERoJG8YqnhVTc3KJIF8VPt6njs4JxqwoszX3/YHUh9gZs97xaZlDSoLcdn8QyDkCa920yVtmzWvKygBd+8VNeeD1eGNtTHPB25z39OFwnrFrHGLzOaCUHqOEB35K2WoxSVvwvG9m62BjKNvp9X4FRlKiqboqkZO8YYQzjkEa/wJh10bEAD/DFZJVWOd4oiPP+Sd2eZZqBZG6gHNVnHn+fqz9yuCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B4KQNw2A+tn1bp3ZjOj98ScouoBlbF5W7xJjaqfaDtA=;
 b=Z+bGxb+25rKNLru6pACNOrj214jmsBfkm/1YcxidUjibeb+PZlu+iALIGY56RUdk78pq6RUwJEiQaDM3RdJckwjUNH4rwHdaMg8NZlpHVBuVZQzWohR51ZmYDqkq4vouA0KpMWnVj4KO8neiJQpxiHDP4k9WfH/jCYEcTULHebU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by PAWPR04MB10031.eurprd04.prod.outlook.com (2603:10a6:102:38b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 14:51:04 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad%4]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 14:51:04 +0000
Message-ID: <11ade490-ba73-4553-812b-27e85b4d29d9@cherry.de>
Date: Wed, 17 Dec 2025 15:51:03 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cmd: bdinfo: fix incorrect Kconfig options check for
 print_eth()
To: Tom Rini <trini@konsulko.com>, Quentin Schulz <foss+uboot@0leil.net>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de,
 Michal Simek <michal.simek@amd.com>
References: <20251217-bdinfo-lwip-v1-1-849cf060bf12@cherry.de>
 <20251217141727.GB303283@bill-the-cat>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20251217141727.GB303283@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0033.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::12) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|PAWPR04MB10031:EE_
X-MS-Office365-Filtering-Correlation-Id: d9140b9c-f786-4aa3-49b2-08de3d7bb419
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ekg4SEphMkp5c0R1TndRNk82QUZGZVFDbU53K2VLeWxSUjloZU9obS8vbENL?=
 =?utf-8?B?RXM0U0ttdjdRa2psSEYybUR4THBVdjc2YWxLbloxNTdrK0NkSmhDczU0N0FD?=
 =?utf-8?B?U2hPVGd1b3ppYnZCdFdYRVpyd3JBU21PUmtzcFpYWnBSRGVLc1BTVnE2N0p0?=
 =?utf-8?B?bThLTGJEUkFCc0RXUVJRb1gxY0l5UUh4RVROcDQ4WjNnWm9lNlJmSjFnenBp?=
 =?utf-8?B?MXFFTVZCSVFoUko2Y0NwOHJIRXh3NXAvSnIyemRSTXAvbmh4Zmg1ajk5Smd0?=
 =?utf-8?B?ZjhyeTdwQ3UzY2FuOGhxQUhiZkVYUld0bUdSd01aVWlVa3A4UHg3dThkYVJT?=
 =?utf-8?B?bzNDUERkUHVReGVjN2FOb0ZnemQrRHFiakNRUzQrVGs5ZFBMWEJxY1lsdXlz?=
 =?utf-8?B?VEpweFk1Vm1aVXp5VlB1TnJ1cVp4SVhTemVGZ0FRN3NXS3lLanl0TzA4Q3Nj?=
 =?utf-8?B?QUs3WjVEanRPZUNHT3pPZUVySWxlR2xLeE9IZ2pDTmpJM0FkcGFZZGExMXRF?=
 =?utf-8?B?NzNLM3ZxZXhvUVFOUm1qNTBSWVZQUTVzbDhtckJoUjRCSU9TYTdMcng0M0Nr?=
 =?utf-8?B?dXJvNldoTEFwMEgzVkFqcHQ3WnJKTUQ1T1RYOHRvS0ppL1dOc3B0MUdVdENi?=
 =?utf-8?B?dG5qZEtwTytqRFVSaGhQM2xlQ3h0bTlBeEpGUkVQTk5XdGxOLzdYeTlVSVhT?=
 =?utf-8?B?aUxtbmRYT2N4WWE2UjAxQ2hOZXRFam1Gd0d5SmhFV1Z3Ymx4SitjRXFZeW1m?=
 =?utf-8?B?NlRXbTlHZnhDR3BKZzB6c3pZckRPVG5tMng5R2VaWE9UWGZrbFRnMGlZU0Fl?=
 =?utf-8?B?dmp1ekhMUFpaWENTU1lIaTZvdnpCWEFIWE5qNjRsbG1rdkFYU3RpcTlSQk1a?=
 =?utf-8?B?dHBmTmR3UEw2TGdQbm9HSFBSbFNKWVZEYVNBbHhrVkxkaUxOUmc1Q1ZNa09s?=
 =?utf-8?B?UndQQWxyaHlOSW5Yc2FaYjRRUnl3UktlczNBSjcwNExWY09CNmg0UGViYjFw?=
 =?utf-8?B?eU01Zm1Yc2tmWmo0cmRzMlZ0Um0vd05FZDVqdVd5T0ZxV2x0czhmYWV6ay8z?=
 =?utf-8?B?SkRDOXYrQ1JLdnNJZ1FsQ2M1eGZkQklKOGZUa2tHa284MXBsekxpalkwUVd2?=
 =?utf-8?B?RytQeVNPRm03YzUvMTFURWJCVXE0dEY5cHZYN0tQN3JxdE4zYmJhSStYY2o2?=
 =?utf-8?B?eFNxbGVKTnd5a0hLK3NneWx0eXEzYkFxUzczTHRCcC81SFc1U1hram5MZW9t?=
 =?utf-8?B?VkFKN0kwcVl3bmRlbzFUZHpReWlmUnhkNkR3aW9TaFRDTmZ6Tmc3cllENFQ3?=
 =?utf-8?B?cG0ydXkyR3NwR3lkZ29aZUorNWdzbkE5QnRJYVNhbWI4a0VwMFFRU2h2NGJq?=
 =?utf-8?B?MGN1N2NvMWNvYkVMbEtZOFRFN0NUemJySnV1RUJoMFZleW9DaXFMNjVmNzVX?=
 =?utf-8?B?MWUzUG5BQ2NNaVdtQ0llTzJMZlI0Zzh6NFFtRnhoVC9XemlkaFphSUl6NTdY?=
 =?utf-8?B?Mzd0SHFtNmhWMXpiMnUxUHdwZTdPOHZRWisxUG05aWZ3akwrOTFkMEFuTmNG?=
 =?utf-8?B?bjNlaEJCWGppR0dPZzNzR2NmR0ZZY2gwZ1RpWmhHcllQTWl3djN5UWcwek9E?=
 =?utf-8?B?VVFqWS9BcWJWeHV1amxnZTNRR2oxR25iZHpEa1pma3VvYXZvcmNuR2t4Vmlv?=
 =?utf-8?B?MzVOL2lBYnBqanV4dWtTM3FXTTIxSnZHbG9EU0R5MjlETUl4VnJIREMrdTJk?=
 =?utf-8?B?c3ZXZVRETEhmM1BoZE5rdTBDbnlkNGNNMy8yMng4NXV0VHFuMVhURjNaWm4w?=
 =?utf-8?B?WmtONmdNUSsyZnNtbTg3V1FacXlVOTJZUkZ2NVorZXZlMU4vMEJzNFVvUWZk?=
 =?utf-8?B?aW5QYTZxSU80K1NTUzFZV01xTFByNTRaNUdnMUx2L1VSZ2g4bXhuWjVUZGc4?=
 =?utf-8?Q?3MRbcKeqcvdTTKPQ+6I3J1ps50qhQKDR?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VEdvRkxqYnhxOUJyU3lQcDROSkdjcHVSMFIrTUV6YWY0QWhFZ2c4d3RiWkZv?=
 =?utf-8?B?bCtuZnY0WWFZS050dnF1andrMHVFSk03UU0xVURXVEE3UnRvcjR3MHByME5R?=
 =?utf-8?B?bEpZcnc2bFNYVnkvSGthTHE1Q0NZZWkrK0pOOW85WXhpeW9idVpsSmRscUxj?=
 =?utf-8?B?NCtEUktTQjlJS3ZGRjRiVVRtUkF4ZDYxQTREWGUza256MERXdmtOT3lRU203?=
 =?utf-8?B?Z2lENGd1aTJKZGdaUmwzdmkrTFdTeXo1d01FTHpmWVo3Nlc0dHFFb2RwcjJw?=
 =?utf-8?B?QnEyMkxlYnN0QnJMNDNBREhDaEhpQ2NGclNrZ1JJYUEwd09ZRGliQThhclZv?=
 =?utf-8?B?S1A0WnQ5Qmd4cy9UTGtqRjN4ZDl6V2c4djNEUFNrSVdod1RpNkNock01SzN1?=
 =?utf-8?B?bmwzR1VNdnpoU0NHTWNLWDdtdk82NXFTc211cWFqSmNTZ0xzZ3doaC9uYitM?=
 =?utf-8?B?d1NmV2tQOFhmcTVMRWEzbEtZWE9PVEU5WnRkVWhLNGNua3Bqdk93NjJ5YkdY?=
 =?utf-8?B?UEVVeFEvWldoQ3UycCtOZUxRV2NTWlkxOTlIdGROZmNtcVJjTWR5MHFqN0xE?=
 =?utf-8?B?T1VzcTdoM21GSXhYaDVsZWZFSWZOKzAvaHJjZzVibDBzb29MUnI2YTNSWUM4?=
 =?utf-8?B?R0krQTVmQ0owWXNSeGZjZlZJNzVwRUpndFQ5bXdXdDRUSHBGallCZHUwakZ1?=
 =?utf-8?B?ZjI5VllXcVh3OEU3TjR1S0xTL3E3ZDNITVlwRmlianBBL2pPQzhHUFpBeS91?=
 =?utf-8?B?Q3pCNWxyWmR2YVNucm9qTEtpNjlZbHRyRzV2SkIvOTNEUjQ0UlU4RWhzWXlZ?=
 =?utf-8?B?WVgrR1JsZnpsK2RmYWhqUG4yV1JNZklaQUNvcUFodTF4T3JZcW9ZL2hNWVda?=
 =?utf-8?B?M2ZCdlFrK1YraWVuNmRFenZKZlMwU1ZFN0hFZm9yK0RzZDhpNEF4VGlHR1pB?=
 =?utf-8?B?ZHBrOVlSV1gwcHltVWUwMFdaUHNZdUpOWnYyMTlqMVVLMHRJSWRtT0NNNy84?=
 =?utf-8?B?a1NtVmZkYzN4Y09pR0xRZzVycUdCMW4zSFlqM1Q0bVdManVUajlvVUpXN3gx?=
 =?utf-8?B?bmhCQ0VtN3doeVNGNzlSbmUvWGh0RkYwdFIycCt5VVh1cW9hQTdGYk9yRTBY?=
 =?utf-8?B?S0NSbW5sM3VLL3hrR0Q0TFkyYVJsaFE1MC9SR0FkREo3ZWRaNGhSTnBmZlRE?=
 =?utf-8?B?MjgrSVBLaFJnMWdJQmVNcG9OZjcyTTEvVlFnUDFuT1hrM1Z6YVpGRVVUUTM2?=
 =?utf-8?B?ME00emkyeThha2M5UzdSbEFrSG5vdzRZZTc2UlZPZ1BtV3pJcTl5bTBnQ2xh?=
 =?utf-8?B?Mkk1aWZ2eGhZdTR6Rk8xQkx1VW9YZWpWbHZQbVFML1lYNVFncDRsTUNhTnpZ?=
 =?utf-8?B?azFNaTI5ZzBSL1dMRDlIaTZENUtCOG44R3d0aXZqdFd1TkhOQnhpaGRWY2w0?=
 =?utf-8?B?b0dDNmNXQ2RxTkt6NWpxd0JmQ0RWdlI3ZmkvTGRQQm9QYWtOVDhZV0kxT1gy?=
 =?utf-8?B?S3MrSXhTVkRWRzVOUDRrRXhSRzVsRFhLTkV2eEZ4ZzZQbWJDQUxjLzRaK0Mr?=
 =?utf-8?B?akdKT1gyOVl3MGk5NzlXSlNzV0ZBVGc2S2FjcUJ6dml5RnIyNEhPaGdMRmYw?=
 =?utf-8?B?MHNNYWJVNkcya1VtZ2h6dnA2bVY2c1I0dHhUeXNXNSt0dmtLQmRnbmVFeTZq?=
 =?utf-8?B?M2JYSVpuY1Y0dHprM1cydnkvUzJxU1dBbmVacnVzTVFGVERFSDFxUEloZGpR?=
 =?utf-8?B?NGlobVNVQU1vZVRkN0FNWDJ4aDR6NnRvS1dJaVoxa3p4V2JvUEplNDg3Unpr?=
 =?utf-8?B?Ti9mWGpFQks1dWFRb0lQQnBHWTArOHNVa1dwRHdkTFJBMlFHMjFqcXRIOVdH?=
 =?utf-8?B?elVQSmVjcmN3bzlyck1uVmtkY0lpT2gwM0xoYWNtN1FwYmZXeGlmeUluZ1Rj?=
 =?utf-8?B?MndmUUc5L1ZaTWdVbXJ2MFdFQmlacWY5ZTc1Z0dkMHp3Wmk0aUVqb2RMaGZK?=
 =?utf-8?B?TVhXNzhsOXNLWVhuREt1OU03TVpWZk5wcUhveE9ZdFBObFM1SXRqa2pzb1lX?=
 =?utf-8?B?UTFGakdueVFubU0vQngyaEFKRzdmTU9qVzUxY1NVRXYyVGVPNDY4azhFZ2JL?=
 =?utf-8?B?TUl0MlEyY0lSK2JIR1YzM0Q0aFdRYmxwOC92RGJ1U2Y0Z2t1T0lIbmN6RTFi?=
 =?utf-8?B?RHc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: d9140b9c-f786-4aa3-49b2-08de3d7bb419
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 14:51:04.6094 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mqgj7WdiGkBbIFI4h/yf350KeopWL4qpeTCfCOWkUsnqnaynFjWdfn1KOLSkxJDJcpPePedTqgWp5hmkXK/vx8/FxCQdsat42FkEKV1eegw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB10031
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

On 12/17/25 3:17 PM, Tom Rini wrote:
> On Wed, Dec 17, 2025 at 03:01:10PM +0100, Quentin Schulz wrote:
> 
>> From: Quentin Schulz <quentin.schulz@cherry.de>
>>
>> CMD_NET_LWIP has never existed so it cannot be right. I'm guessing the
>> intent was to allow print_eth() to be called when NET_LWIP is defined
>> (NET means "legacy networking stack" as opposed to NET_LWIP which is the
>>   newest (and incompatible) stack). There probably was some mix-up
>> between CMD_NET and NET options.
>>
>> The dependency on CMD_NET seems unnecessary as it seems perfectly fine
>> to run bdinfo without CMD_NET (build and run tested). So let's instead
>> make the dependency on NET || NET_LWIP.
>>
>> Fixes: 95744d2527cb ("cmd: bdinfo: enable -e when CONFIG_CMD_NET_LWIP=y")
>> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
>> ---
>>   cmd/bdinfo.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/cmd/bdinfo.c b/cmd/bdinfo.c
>> index 20c8c97f0cd..09fe8067642 100644
>> --- a/cmd/bdinfo.c
>> +++ b/cmd/bdinfo.c
>> @@ -152,7 +152,7 @@ static int bdinfo_print_all(struct bd_info *bd)
>>   	bdinfo_print_num_l("relocaddr", gd->relocaddr);
>>   	bdinfo_print_num_l("reloc off", gd->reloc_off);
>>   	printf("%-12s= %u-bit\n", "Build", (uint)sizeof(void *) * 8);
>> -	if (IS_ENABLED(CONFIG_CMD_NET) || IS_ENABLED(CONFIG_CMD_NET_LWIP))
>> +	if (IS_ENABLED(CONFIG_NET) || IS_ENABLED(CONFIG_NET_LWIP))
>>   		print_eth();
>>   	bdinfo_print_num_l("fdt_blob", (ulong)map_to_sysmem(gd->fdt_blob));
>>   	if (IS_ENABLED(CONFIG_VIDEO))
>> @@ -193,8 +193,8 @@ int do_bdinfo(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>>   		case 'a':
>>   			return bdinfo_print_all(bd);
>>   		case 'e':
>> -			if (!IS_ENABLED(CONFIG_CMD_NET) &&
>> -			    !IS_ENABLED(CONFIG_CMD_NET_LWIP))
>> +			if (!IS_ENABLED(CONFIG_NET) &&
>> +			    !IS_ENABLED(CONFIG_NET_LWIP))
>>   				return CMD_RET_USAGE;
>>   			print_eth();
>>   			return CMD_RET_SUCCESS;
> 
> It must also be the case that we never both build cmd/bdinfo.c and also
> have no network stack, otherwise we'd get a warning around print_eth
> being defined but unused. Can you guard that function too? It needs

This doesn't happen though for some reason.

make ringneck-px30_defconfig
make menuconfig # CMD_NET=n, NO_NET=y
make

No warning or error (CMD_BDI=y and I've checked by adding #error 
whatever in the file). eth-uclass.c which defines eth_get_dev_index() is 
not compiled in (no eth-uclass.o in build/drivers/).

> eth_get_dev_index to exist which does require a network stack. Also,
> maybe we should be checking on the "no networking enabled" symbol? Or

Yes we probably should but we do NET || NET_LWIP everywhere, so I 
believe it's better to stay consistent for now.

> no, because that would then conflict with the other series you're
> working on that you mentioned?
> 

In the upcoming series, I plan on having NET mean "there's a networking 
stack available" and I'll replace all current NET || NET_LWIP with 
simply NET (the "new" meaning for NET; the current NET will be renamed 
to NET_LEGACY). It'll be based on this series, and I don't want to be 
making this patch dependent on the huge changes in the upcoming series. 
I'm not confident that upcoming series is necessarily worth merging or 
that it'll go through and be merged. I'm at 198 files changed and the 
list of people get_maintainer returns is 160 people... I still have my 
doubt on the NET->NET_LEGACY rename and reusing NET for NET_LEGACY || 
NET_LWIP.

I'm on PTO in ~24h for ~3 weeks and I'm torn on whether to send the 
series (if it's ready) by then, feels a bit weird to drop a big 
changeset like that and disappear for a while :)

Cheers,
Quentin
