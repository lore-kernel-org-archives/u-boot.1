Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C34DDCCF2E4
	for <u-boot@archiver.kernel.org>; Mon, 19 Jan 2026 10:43:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0769680B98;
	Mon, 19 Jan 2026 11:43:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="H32L1S33";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B61D83015; Mon, 19 Jan 2026 11:43:48 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E4E99800AE
 for <u-boot@lists.denx.de>; Mon, 19 Jan 2026 11:43:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gN0jCmk9EH+sE1Zjn5CIuW/Hrkdks4M2TVgX5RAhYCp2KE+cveTe/gqKlS2VQN/qReUJ8cPuNG07TPLi8mmy2MGTxGGJ+Q5hmtAeZZzi2aX2DjGdeHEhwSz5QyCTrKxB0RFpr5MFWXxTuscczlH9a7nzaJkACZ3GhLI5rAikGO37S2b9eejirQcjKcv3lhYw5dFZQBU970vq+8++QjfhP1nQD10vVQoxfmc0NBw0d1cvZ+fTBZk3p+Sl0j2pfoMMc6PFEzxqACvh5PorKUgAyx1KmnF63lta5ncFjOgZHtI8Z2SypEINM18SfHjEIoiobht7mJYJ/2tF7INhhVrPqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M/cX+R6UfW1jBIw+6tEMbYvLhaqtuVe1VHB4UOHzy5U=;
 b=nYgKzVxN4xXIJ3pSKUIB/1GMQZEq6r2OCNalaPMmsiui0qm1A2TZkY4VZY/vgNlhaznrCMOnlrBzFl8nnlBE7/RFlKB/Ahx7UbWrAVUC1pHkvKU3TgCRWG6V7nrB8Gqy24b5XMDuE3uoPwkXHGSCbZCcKdGHkwtH0FoSGX4N4UlJCnuPbgOLkWMD5Rd/OJwGpxZNsK2p7rGK1hc175q8ziWHA907AYRn4GmrH9r72s7eKo1JSCjrDuzqAZWWO/vKG9XKJVzjIpVwRdjdNuc2R1SqlSvhDClEIikdf4/khYNAofiVg//tTKYq7eVgv63k7e3yeGQfNZIugDgsNnnIuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M/cX+R6UfW1jBIw+6tEMbYvLhaqtuVe1VHB4UOHzy5U=;
 b=H32L1S334QT3c5B1kEN1KDouJ3/zWpvhkjGS9ZZeQCjBQVtWl49D89Bk9zY3U9STD3xiRN7Wvyk5UGeyXSXcnsKPJHoNAKvAl2aoz0hLxbklus3jZKQC6gzGsloENCteVfZs+9PCd03r6CILOHHJPvii/AE6FFGfoIj9zTXj0TI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by DU2PR04MB8648.eurprd04.prod.outlook.com (2603:10a6:10:2df::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 10:43:34 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9520.011; Mon, 19 Jan 2026
 10:43:34 +0000
Message-ID: <d6c9d982-5b05-40f1-a61e-373bef2dfae5@cherry.de>
Date: Mon, 19 Jan 2026 11:43:15 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] cmd: gpt: fix partition search boundaries
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Tom Rini <trini@konsulko.com>, Rasmus Villemoes <ravi@prevas.dk>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 Mike Looijmans <mike.looijmans@topic.nl>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Kever Yang <kever.yang@rock-chips.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Corneliu Doban <cdoban@broadcom.com>,
 Alexey Romanov <avromanov@salutedevices.com>, u-boot@lists.denx.de
References: <20260119003606.748561-1-mikhail.kshevetskiy@iopsys.eu>
 <20260119003606.748561-3-mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260119003606.748561-3-mikhail.kshevetskiy@iopsys.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0237.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b2::9) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|DU2PR04MB8648:EE_
X-MS-Office365-Filtering-Correlation-Id: d898a344-212b-42d5-851d-08de57479814
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|10070799003|1800799024|921020|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QlVYZlhQcEh4ZkZiRWdhUHp0WnlXRVRMU2lnSFZrSzR6NEN2VTZTYXB5aWYx?=
 =?utf-8?B?aXFEN2x2ZWJSZ0NLT0tlVCtDYU5PanNBTXAvSHRKQVFkcmMxM21SSjdKMTY4?=
 =?utf-8?B?QTZ6T3cvcHBJT1YzZmw1bzVEelhqZEhPL0tZZm9IZnYvNjFlOU8rSUpSMG1z?=
 =?utf-8?B?SXpFTi8vSXpYZmFKR3JuYmhqMkgxN3I4ckRGOENMNG5aRkF4UGFNbi9KSXpu?=
 =?utf-8?B?UUU4czZ5WWw0SFI3dmlTRU12TS94aVF1NHFiMmpkNDRDVlZ3SjJSa2NVMWpI?=
 =?utf-8?B?L1pEMFZrTHlCSGg4YmlDOVgwem1xQXp2VmhaaHUvQkg5dVJaK1MzU0J4ODRq?=
 =?utf-8?B?TnFaU1YzYkJ0Ri9tRDFITzVyNFh6WU4xVG1BbGRBbXRydTFFbTJEMGZJc29Q?=
 =?utf-8?B?Y1NtS1ljRmhwMlZ6SHVDUkVjdUIxcmtzTTNGUHhMQy82UCtnbERtcDRJSGxR?=
 =?utf-8?B?TER1cFN1ckhBOFVlUXVRUy9UbVhldTFTWHByaGZUelFRNVVRc0s2OWkyRHBt?=
 =?utf-8?B?SStQVEVOd1lVWEllYm1rMThLWkNwcWFJTzh5a051WjFJOXV0NTFvMWhCWE5p?=
 =?utf-8?B?ZFg5UE1OeWZRM1dVMGx6NGJCcW9Za3o0S0dmSG51WGlQNkl3c2F0MWd0YWdk?=
 =?utf-8?B?WDIwMHQyTnZrRVltdGRtaDQrT2doUHJiaHk2TVlERndHRi9aNmI2VThIejVh?=
 =?utf-8?B?UEg4Q0ZySm9RK2liVXZXSzVJZG9kVmtDcUc0VzFXU3NvdEFLWTJCTmRyTjJp?=
 =?utf-8?B?SUNCdU1IT2NwdG9MU0JuNER1Zlc2cEFNbndyQkQ2ZDVxa01yVHp5OW0vRkJX?=
 =?utf-8?B?WWwzUFAwaEVDazJrdVBYWHpDM1FBWkloOW8zWTE5UDZHb1IycnJTeTk2NlBp?=
 =?utf-8?B?NHd2cW85bnB6aFNSQ1NuZFBrbUx5UGx3TEZCVEk5K2F2RkJCKzI2cFZJNEZQ?=
 =?utf-8?B?a3N3a3BMd0hxak9janJ5Q1ptTHBIQktuNkNKQWpXekFSbXN3dmtZK1FuQnI2?=
 =?utf-8?B?cjhvYi96WnRpREpTdEcvQzBZdWJwSk9xcVBRWGM3ZFg4Slo5YU51ZEcybm5j?=
 =?utf-8?B?U3F5M0RQdUNJUjBWUGZ5bElHd0RpTHh0QURJUHlzVFh1dmluNGlRWGlzV1E3?=
 =?utf-8?B?UVZWbXBOK1NlcFZTdk92bml4N3dSMXFLaXhDdXluNkkrRXBRSTZJWjhEbWlt?=
 =?utf-8?B?OGh2eFZBbWZRV2RyRmtvYlRWWVVabXkzK2hLck52akszcW5LS0t6RVBlcStH?=
 =?utf-8?B?KzZBcWdEclZvY3dDSmZsVHVFQnBlUWFZQngyVVREejA0WGlNVXROZUU2cjVC?=
 =?utf-8?B?OG5nRklvQkZZQ3VWMDh1M1dQblRGM2gyR0hjSkJaTFVXNVk0ZmxSRWYySklx?=
 =?utf-8?B?b1REU09oR1orVzJTUHRIb2tVUjVNcW43ODEwdlJWUWd0TXRZMHFta0E3Z1RS?=
 =?utf-8?B?WHR5cnBQSXg4a2s3NXhDb0JFK081SnBDOS8rOXdGZUlhbElIeDZUclllSGtJ?=
 =?utf-8?B?c0NLeXBqMEVDaHlIKzVESzFhZ012b2xTNmNRWTNCOTYvblZEK1daL2xUT0JI?=
 =?utf-8?B?Tm9TQjVldWVncFNtOURkbW95aVNNcmdORVo5NVVGN0txSTdQamM3ajlwZHJI?=
 =?utf-8?B?K0g4dkNlUG44VEFWRmcrODFqNDRVWHFPVTV0UmhSdFlQWm9hLzEzV0paenQv?=
 =?utf-8?B?WkJWc1pBd3cwYmhzQWk0cmYxMWJnZWFhVkx5WXBSYUtySTBtOXdQdVRkdyt5?=
 =?utf-8?B?TkVYK3ZYYlluVGF3aDRDbDlHcFlIQVlGQWY1ang5Y0tiVjJMYzZwUEJMTjkw?=
 =?utf-8?B?RTE5VHJUZ0RadjNTK1FSczJ0V1VrUXk3QUhqYWVoRmxJbUFmK2ZUNTRsNkVo?=
 =?utf-8?B?cHF3aG9qRzcyalQ1eDhRVTgwTHFXa01DM1ZoOHU4MHBsTW5iRlpRVUhnMDhX?=
 =?utf-8?B?TGdBVUpWZ3RYVDJtMUt6Z3duRHNEVTFUUmNhT1I5cDJzYnY4M2gxUHgrajBV?=
 =?utf-8?B?UStBRHNESnB2eWJ5UC80UjkrSDdpWTFIMUthbjRVc1NLUHFNalF2OVMraldo?=
 =?utf-8?B?OFdjeGdzZDUxRnJJSDB4a00veUpmSGxHOFBQSlMybFJGeFVOampxMmpJNFMr?=
 =?utf-8?B?ZmR4aFRMUEk0V2NiMjRxZkdUaURtc2tXTEhSd0RzOG5ZSTJYT3Q0UHFzUHBn?=
 =?utf-8?B?N3c9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(10070799003)(1800799024)(921020)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aThGazJKUWZPSDllV2I1eWtLRC9QRW9BVEhCVktXVjJ0aGFFdmk0U2tGSUVq?=
 =?utf-8?B?UHNXeWcrajYweDlNak83OWttTWZOalV4NFJKbzBvR2ZOQUxwNXo4aDlKeVFN?=
 =?utf-8?B?c2xFWEFrMGZOL3BDZ2o3RmpjbEhQelNvL0o1TVhlcEsreWR4aTNGZlRDdGxV?=
 =?utf-8?B?eGZUcTVvcS9zQjlxRFZSd2NabWZoYnJhd2d1ZjlzUnBmbmNRK2p6dzRPcVV3?=
 =?utf-8?B?cm5RbEhVd1hPZUdkUEh6TDliZ2tkVFZBcmgyenFHSGl1RW5aa0poeHZTRWR3?=
 =?utf-8?B?RVBqRjkrcUxTYXZJZjdXODYwNmRMcVA5MktzZzdXRG9nNXNrekJhSmN4VHlR?=
 =?utf-8?B?bGdGU2JndVhkbFEwSUM2d3FCNVFIWmZGZTBLNGRQcjFIenQ4dnFCa3VtYXRm?=
 =?utf-8?B?MnV2SVR4NWRoN2V6cEx4cml0dkV0VWhJKzRWcXZGaWJoRlRWdXBRc3pIeDVQ?=
 =?utf-8?B?RWN4L29Sd3lKbEdISHh3ZWtUYU9KdGVVcFpyVXBDbFVWL1g3R2RuVkJjUVVy?=
 =?utf-8?B?bUc4R1lHdW82YitPTzJ3YzljMEo3V2FNSUF6VUxSeGVSS0xIcTRobXlhQ21l?=
 =?utf-8?B?QnJLclhpL0VBdllxenV0OStET2oySkdMaUVibzZ3NVJBK29YSVgxYlpTelNr?=
 =?utf-8?B?QVBkSWdWTWRaZlBVQjBMSnVRUExiMmtZdkxaM0puUGNtT3JIQTRpMUpyZGM3?=
 =?utf-8?B?K0cyZ0hpNWhTSnZpZlY2YXBNS1FVeTVEWDVZWm9yMGF2TGtPVUlkeWtmK1li?=
 =?utf-8?B?YlFIUTBOaGV0YzgwR0NvTGViQ2xMQWRkaEVhRTFCOTV5ZHlKYm5ML3FiWjRS?=
 =?utf-8?B?MXhQUjhINGI4Y0RSQnFWaCtiVmwvL20wNXluTWMya3EybW1VUnlUcWwycThx?=
 =?utf-8?B?RVMwVjVWd2RxM1dYaUdDeGl6V1J3WEdHaWNGOHhVaFA1Y01sZ0pFV3pVUnVY?=
 =?utf-8?B?VFcyNkQrWnMzMzQ3bFowN0xjQUYxNEZEQUNFMU9ya3FnZDlST0ZvbXN5aDNT?=
 =?utf-8?B?WU1DOWVPTEdUaWFCMlhKazNDdG00VEFkZHo2aWFjaGRFLzExcnVhMVVRL1c4?=
 =?utf-8?B?MzFyU04ya2g3VmpOVTRZQ1ppeGQxeTVmQm82Rk1PR2k4a3JScDVUeWpTK1g1?=
 =?utf-8?B?SmU4Q2Fmalg2T2twSzZOMHZnVURDWUlpQ3dKaytZdlYwdllBY2JLa0VIanpV?=
 =?utf-8?B?bnRsYzM1QlFkdEdCWG9vUWpHaGNraG5LdUFySXZJU0g0aW0xVkkwcGZrSUpL?=
 =?utf-8?B?UjJxTURrMmdwWVprNHozNVloVFpzMllVSWFBZHBnMjFwM292Z09JSmhmRXd1?=
 =?utf-8?B?M1kxUEt4MHJkUE9jSmxDeTdFWVhrZWxNYVRyTTR3VjVyamhVOElhK0R4Zm5z?=
 =?utf-8?B?ZVBnaEoxUG01Nlh4eUNhZjVCSU1jUHROVDBrRzZCVlFmS0RWWWlSM1VmS1oy?=
 =?utf-8?B?RzE3TWpTaDBtaTAvZGRzVUlMd2MxREZVbHlOS3JrakhWTFhpcFZocGZsczdW?=
 =?utf-8?B?TmlsWWU3elVTdDBSU0VyWmxTK0ZNd1lMbVpDMURRUlZ1bnZzclFSb3JYQ0V0?=
 =?utf-8?B?bHJjcTVJMUZHOGlkNWIrU0xpR0ZKNkhJS1JiSElFVlNtazRWNzdTSUw5MVV3?=
 =?utf-8?B?RHVxNHMxSTFCY1J3eGlRRy9aa29wOWRkbVN5SFU2b1NRNWdFZy9RbWQwNHNB?=
 =?utf-8?B?WklXVnRyTnVCSzE5Uys4Uld1clhua1FnajF0b05JOVhqK2RsOXZ5MWR3bXVj?=
 =?utf-8?B?K0ZrbDZwWUxKUnJuc3VRbkduaXFLeWdicGFHcHhXZ1phSVdlL2xEd2JjbGY5?=
 =?utf-8?B?N3grQVlKcy9zNTZqeDhoQ1dqM3FFR3MyR0RvcWFlY3BUclI0VEdNUVJ2MTdE?=
 =?utf-8?B?a2JpZGQ5ei8wRjJBM3ZGb1p0dFZheXNheE5lZmljOWZuRnEvNDRwYjJWR2kx?=
 =?utf-8?B?YnBGdlp4aGQ0QWdOUGsrQTc4a3N2UU9xRkMwSVNFbW9FMEFPZVlpZTdRUldl?=
 =?utf-8?B?Z0hmQTFzNVlKWkFUeG92TVVVeUpURjFZczh1VlpGbkhvc2xaSk82S3d3aWtD?=
 =?utf-8?B?QlpzUXlLQlptUXNGcGJ2WnZ4OHRvMlBkOWQ0clpidC9vdmc0b2k1Q0xmZzlF?=
 =?utf-8?B?TTZNMXRjRm42TTI2WWVFRUxFTkQvYmV5a1loLzNPOHlDYlozTVBpZXkxOVRz?=
 =?utf-8?B?cC9FTzQ1eVk4UldhdUpmQTFYQlEraU9yeU9BWVYrS3duYmtyTEczbEhoQncw?=
 =?utf-8?B?RkJuNUtNVVFRcFRkempwSnprM3hGRy9ZVWtnNkhCdFVzYnR4dUt5SENpd2FP?=
 =?utf-8?B?VDRReWtVQzczUGFVdG54bHV4QTdVRGFkNWJ6SFAwc1BGZVNvbEFPZUpsSjhI?=
 =?utf-8?Q?+HzmfhugQUXPGVSHqmQEl/x5EV5Ag4mXfFZAf?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: d898a344-212b-42d5-851d-08de57479814
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 10:43:33.9868 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uTMmJ5kSaOGy65SGMoCDkdywLLdFKtRn94uh75QQd9qms0erlCwg7oXCNCFW60+dyjFyQ+F5p+lR/RSWck9ZfOCmDvMZ7G/fjoiHTki46OY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8648
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

Hi Mikhail,

On 1/19/26 1:36 AM, Mikhail Kshevetskiy wrote:
> GPT disk partition with max available number (ex: /dev/mmcblk128) can't
> be used from U-Boot. Here is an example:
> 
>    => mmc part
> 
>    Partition Map for mmc device 0  --   Partition Type: EFI
> 
>    Part	Start LBA	End LBA		Name
> 	Attributes
> 	Type GUID
> 	Partition GUID
>    1	0x00001000	0x000013ff	"env1"
> 	attrs:	0x0000000000000000
> 	type:	0fc63daf-8483-4772-8e79-3d69d8477de4
> 	guid:	5452574f-2211-4433-5566-778899aabb02
>    2	0x00001400	0x000017ff	"env2"
> 	attrs:	0x0000000000000000
> 	type:	0fc63daf-8483-4772-8e79-3d69d8477de4
> 	guid:	5452574f-2211-4433-5566-778899aabb03
>    .................
>    8	0x00158000	0x0034bfff	"apps"
> 	attrs:	0x0000000000000000
> 	type:	0fc63daf-8483-4772-8e79-3d69d8477de4
> 	guid:	5452574f-2211-4433-5566-778899aabb09
>    128	0x00000420	0x00000fff	"fip"
> 	attrs:	0x0000000000000000
> 	type:	c12a7328-f81f-11d2-ba4b-00a0c93ec93b
> 	guid:	5452574f-2211-4433-5566-778899aabb01
> 
>    => gpt setenv mmc 0 fip
>    error!
>    => gpt setenv mmc 0 apps
>    success!
> 
> The error is caused by invalid boundary checks. This patch fixes an
> issue.
> 
> Fixes: 12fc1f3bb223 ("cmd: gpt: add eMMC and GPT support")
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>

Acked-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
