Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9301BC0218B
	for <u-boot@archiver.kernel.org>; Tue, 21 Jan 2025 13:52:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27EAB801F5;
	Tue, 21 Jan 2025 14:52:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bn3XwDXV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8E7F80326; Tue, 21 Jan 2025 14:52:45 +0100 (CET)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on20614.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:240a::614])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B77F801CF
 for <u-boot@lists.denx.de>; Tue, 21 Jan 2025 14:52:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Veqz08OnhLSFEOQRxf0YzaUUY4xAQgrU69MT3wC/jvwztGmIyA0+3Lcu3muDUEBALszE/OeDlNPko6lKb6JD/9wpDkhoOe8voYpjk8ueCFLOso3s3BCVUTwyRj8cXxWfUuCuh7PSc9+PCDeKJJyMZItR+8RD77Opa9MZ0jkmFsNTzs0cbkCJSrBquH1Ve66r0p89ko8KHfbWfNq7aeoerT+W2Tl3zQBYps+hKWZYU9G0FknPu0oS9JqQZLN4exGMeYq0C3v+ZKBGRtoo24OXhXx9yFl34ObmvMjEhpKQS7eU5ot8pHq7l5GAk4/sAjysJk6IkRxA7L1491aAA2/R9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zKAWhbKnBBbMujTNoeikptUXNBza0QpRQNvW2JnFVm0=;
 b=vlPx1jibLJMmVvoZZPKWad4ayWmVbnEomxpW/+8paXfV9+4O3GDZhXZh/RzaFEXVsBQQMk09bXhlZWdl6ej5ge/C4ZhzjEOv6vldHXYPlLvtcl6VUzGX+XbX69wJwhwhbcPxE9OyVQe1QMp1+K7NAWFq/wUUtE0K/s8+ZgqPDnmq1KL1IKocz71H+fNzDc8/TE3Ul6+SLeHNwMOVXAO8zP2oRgtkUIeIeBaoTNYVv1kQjpN+vkAdWwSmEXwub+PNERmPEVt66NRKnjrxnN2Rj2JTC+NDjyaOEKPDki68w1seWozHC5TrMWdL8i0eAE8NoFlgu9hVjyB9Y/XPThN5Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zKAWhbKnBBbMujTNoeikptUXNBza0QpRQNvW2JnFVm0=;
 b=bn3XwDXV7D5Q6Ze6EldwqeAC/sk+7Ce6t4+9W6vkl6rXvbngJV41KBJVn6RnBfX5NHx3csEBcG+q4rj/iHX1eHm/rl0ITnqA2foljjB4tjCEHs3Oby90xOiip8v8j8xReQDreBUong70ptw9egF+8BVuYBgUjy+j4rrW/cbbu5g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by MW4PR12MB6756.namprd12.prod.outlook.com (2603:10b6:303:1e9::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.22; Tue, 21 Jan
 2025 13:52:40 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%6]) with mapi id 15.20.8356.020; Tue, 21 Jan 2025
 13:52:40 +0000
Message-ID: <aa20a149-fb5d-4d52-8cd3-6dec485b79ab@amd.com>
Date: Tue, 21 Jan 2025 14:52:28 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] Introduce coroutines framework
To: Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Raymond Mao <raymond.mao@linaro.org>
References: <cover.1737380886.git.jerome.forissier@linaro.org>
 <e17799b6938d4afe08b80fc20b70f4d3a81db848.1737380886.git.jerome.forissier@linaro.org>
 <24dc7f4c-62bb-46e4-b7d7-6c3aa472c36f@amd.com>
 <13765dd9-c958-47f6-8076-f10b93561cca@linaro.org>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <13765dd9-c958-47f6-8076-f10b93561cca@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR06CA0198.eurprd06.prod.outlook.com
 (2603:10a6:802:2c::19) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|MW4PR12MB6756:EE_
X-MS-Office365-Filtering-Correlation-Id: efbfcb2b-87a9-433c-879e-08dd3a22deca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UUN0dzNzbWFvb3pYYVh6SUY4NkZOZTlZY3M1emRYRUJnZHI4aEtEYVJqU245?=
 =?utf-8?B?Y1FjS2RxcjFOL0FRREZqNndVckJaZFpqYmcvSUNGUTlaV1oxRWNjeTZsYjFR?=
 =?utf-8?B?R2pyVGRVTHhHbnAvbWJFeXlTMDhtQnlmbXZDR3R4WGhmUlIyU1dPS3BkZ3Ex?=
 =?utf-8?B?Y3h6d3NjSDFJNTlLRFM3dnhXRHFyRUpLQ2ZVcEI1ZmdTVVcxdU5rK21Hei9C?=
 =?utf-8?B?TDFTRDhFSHpicTJ5OCtoMHZaVjBYUUZGa3YzOTVTQmlCQTZNazI0eHVzYUdB?=
 =?utf-8?B?K1NCM2dNalM3VnZoY2RmZnE1K2ozZkJnVmxTclpETDB0TElPQ1lHeHBPd3E0?=
 =?utf-8?B?aGIyQ09CaFZtZS9JOXBHelFzc2xCQXhZblErSkVtRE01ZHlEZmxxQjVrTGQy?=
 =?utf-8?B?NU5oL09KYXVaaEwrNExBUjliTEJwM3dmelZQeXREZ2R4ZXVCRk1OTFdXZFVC?=
 =?utf-8?B?cVAzUXZWcmRkMWZ5a0F6K1JRd1ZPOXZGdzFac3N0c1J5U05raGp3aGR0NUJo?=
 =?utf-8?B?YXR5RkQ5aWFYUlU2ZHpyczdJU0Q2NjV0SkhSOGZ2TFVlK2owRWJOeG1MOUVX?=
 =?utf-8?B?eVBFM2JCeFAzZHJLc0pHWkVuYXpmcVFCTGp3ZG4yaHo1cU9HSnVDakJqT2Q2?=
 =?utf-8?B?aEVYbm96MWVqQVhvMTFPZVJFTlc2NVF0aXlIYzUyZnJkTUMyUnBidWdWQWFN?=
 =?utf-8?B?VWpmdW5iMnZteWRkZlhmV05nc21DOFJPQmUvcXI1TXhkbGVpUnhxaGZSekNM?=
 =?utf-8?B?eEpkZ3VZMlZNckJtSkIrbHl5cmN0NjZ6MnNMZVY2eXMzaHZFOXI4ZlN1YWlW?=
 =?utf-8?B?MHFib2xyU0h5WkE2cVBQNmc4UEU5VWlIcW5sdEVoZlFmVkwrMHQyZmlRNmt2?=
 =?utf-8?B?eEJhSlJCSGw5SWxYTzh3RUVhSzVxKytsZVlsL0ZocFI5TTVaN1JKcmV2Qk1w?=
 =?utf-8?B?M2oweXBFeEZKcXNBZStIM2dhYzRGeWlGMzNrSTFTZUdQbC9NNmdpOXJCc2dQ?=
 =?utf-8?B?Zkw4MjdKN1YvdkpPLzIrUnRHUnh0ei9HV3RmSFEza2ZMSmdzOEo1VHFzVHVO?=
 =?utf-8?B?ZTIwc3REOWEzV0xOZHJiR0hJd2plWkptOS9oUFVENm9JZjFzYnBEeHU4OERP?=
 =?utf-8?B?eWVJUUJzaEdIZDZWb2dOVEFCU2I4ZlExdjRjc0R1eVlEZTlkdEsxMVdZQ0ly?=
 =?utf-8?B?NER2b0VvN0JUandtYXJkalFqWnpDdzBRZ2ZtbEZCTWxpUk5UTzB6bm4rQUxv?=
 =?utf-8?B?N3AyOGg1RVJETUQvb1MreG1wRWVLVTR4SFowc1J1MG9BUEdXV1hCQ3FPcXN2?=
 =?utf-8?B?MVZMSHdhWFdYWlZRZU50bndNSXo1U1ZYMFVUVnpXS3R2QVlHTDAwcHhFdkhK?=
 =?utf-8?B?WVhnRkI2REEzcDcwSTZVWTFTY2ZxNTdjZ2d3dVY1RHlGYTFpMVA0T1dPVmF1?=
 =?utf-8?B?UDU0Y1laVVA1N1NXWWVyYkRCemFtTTRZQkp1QmFWSGx2SHdCS1M2TGgxTk5W?=
 =?utf-8?B?RGJnY0g0aXFweFFKb2lRUGx3R3F3N0FhR3hlT1ZqVkEvZnM1RncyUENxN3lC?=
 =?utf-8?B?SEdrdk5zd3U0eFkrUXJ1Y2VxemcwbWM0Q0E1RGtoT09BVW42YlR6MlNtNTVw?=
 =?utf-8?B?OXFTcitnTG1Vdkl1dWUva0szQmt4N0JsYXRRdGJMODFYSk1XM0crN3dJalBC?=
 =?utf-8?B?Q0lQNTZ2V1Ywa0hVNWVUYi9xK0FGU3lpTTV0VDROUTZLdW00UERhNFQvQllo?=
 =?utf-8?B?MWxocU9SWEhZSnBjaFlhZVVlSW90WkZRRUVwYkdRTzVwOFh1RmdpM290ZzVh?=
 =?utf-8?B?b0VSSExHa0hLMGM1aEkxNFFLYWkrb1lMMDZNRGQzTHIxUGxsQW5NZmJtWGZV?=
 =?utf-8?Q?PTFHmKC11PyCc?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c3pndzRTSkhyQWhJU253bThVL21NQWJNYWNMMGFNOEx5RGJpR2M2WFRqNjdC?=
 =?utf-8?B?V1lJQ1BkQ2FhampId0RLN1U2d1ZVbGRqTHU1NlB1Vkx1ckxjd1VwSDZPWmE1?=
 =?utf-8?B?cXhqazZ1L09IdTFQY0o5aDhvd0doeVpCMmNHQ21Za085WUpTaDVnMStYK3Bj?=
 =?utf-8?B?eE4zRFhwMEt1TWthWXJiUGZKWS96TGVnb0g2U1VXZUJUSThBSTJVSTlsS0NG?=
 =?utf-8?B?am9uZ0ZIK0tBUjFoVG8zd1hoS1pjOGhkTHFrREN3YzdhbisrR3RIWVZkY0tH?=
 =?utf-8?B?UUhubm14SU1KTThzaGUvRW1KKzRqQ2dwbjVUSWlGUzZqL0N5MzNxekYrWENZ?=
 =?utf-8?B?cjdLWUhiRUl2bjNaOXZUK0tWWlVBUC84SEFrNC8rRStVaW92SU8wa0VIRXRm?=
 =?utf-8?B?V2tsRFNhNGlPZDErTmZCaGlENnBNMkFsV3BsQ3Ruc29ZQTh3UlVqSkpDdEJi?=
 =?utf-8?B?RDNZeUpNbUEwWnNjeDR1YTZOSENlT00wOXJ4c1FSTDVYYkkwNjJjQUhYR0RS?=
 =?utf-8?B?cDQveG8wNFZBSi94ZlJTNnQ5dC9QYWlwMGNhN1FJWm1iRjhrYVFHL0VyZXl1?=
 =?utf-8?B?TTdrOWZCT0t1NlMzN3dUd0lGbjViNUxLUUk3N21Bd0tNSC83NnR4MW1uaFMv?=
 =?utf-8?B?WTR2Qmc0Wk5rdmRrSUtjY0lwQU5uSWxLZWtDQUYyY1JxYjEyMkFJdVVjb0Vw?=
 =?utf-8?B?TlQxVHBmQ2JWMVBvL3FlWUxXaGVQQko0WGJxdDlDQitVK2ZwSUVqTncyaVFO?=
 =?utf-8?B?ZDZCSTM0UXVYaVc1TnNIbUl3bURaeUZEa240ak1adDNOeUlQWHFKWkhyN1Z6?=
 =?utf-8?B?bmNud3lZZkoxWktxVG52bjltbkYyb3hKVWlpY01PTXYzT0QxODlPQ3FNUnZj?=
 =?utf-8?B?cC80RnRoT0RPMUI0QzFXZnN3V3VnUHR2RGljYkg4Qnk0a1YyRSs0dUE0ZzB0?=
 =?utf-8?B?NGJneTVYNk9FV3J2V1JqcUZpNThacEozQ2diSi9xNEpBYklWbnJDRUN0aXVx?=
 =?utf-8?B?QkkrUlovR3V1a1ErTHRhbUVtNjhXT0QvWDVjakR1WWtJeE5WSU9MZEhXK255?=
 =?utf-8?B?dDVMMkJpYW4zQ0tTYjRnYXdnUkJLTDBpK0pVNGtaTXI5Y0hqRWovUzdVZXJG?=
 =?utf-8?B?YlU0Q1pzTHBxOEdJS1puTW5pcmVyaDN1MlVqNzZ6K1RiUGk2ekNickI1RG1G?=
 =?utf-8?B?NFJnaE51NmpMcm1ZdTFqODVBaWo3Uldnd2k3WWE3R2hWWnJtM1dmNTJxYSsr?=
 =?utf-8?B?bDgzdS9FRHlhOUs2UTR1T2VKNGFJWkRUUWw3WEREQzVxWFYyWVdHNUFudFpF?=
 =?utf-8?B?ZEE4SVk4ZHNEeWNaMkcvbzFWYUVYYUFRK2hPK29UOWxqbGZqQStmcWxFVGJ1?=
 =?utf-8?B?YVJQckV1SFhCWEJTOVpsOHdpZ3hlVTR4MmhEWGRHT2hGclZxQ3o3eHZBTmZ2?=
 =?utf-8?B?S2RsaW04bng5TzMrcHpOMlJZUVlPbks4VXFPTWc1WHF2NG5PTjJmeGhDY25E?=
 =?utf-8?B?TkVSUVUxVWs3TmJSaGhZMFJJUk0rRm5ldzJ3Q1llZXNNaEpvWVZhc1pETWtx?=
 =?utf-8?B?Q0U3MHQ2K3o2WGNuaExndmxhbEdSM1N0UTFrKzBWM1c4SEZhZ09sWWMxRmV4?=
 =?utf-8?B?NEoxcTVIdlRXbVA1azZhSXV5MzlkOUZlR0pKSlUzVHFyandGb1pWWmtqdTZJ?=
 =?utf-8?B?emhFK01uYVpkLy9PYllzK3pJa1B6ZFZGNVF5NDdyKzUxVzIrZE4vQ08vdnNj?=
 =?utf-8?B?Z1VERVExcUh5YU45MzNuWHlra2puSXc0U3ZCcjQzdGpONWpnb2tLMUZPQi9v?=
 =?utf-8?B?dEpnUkxoK29VMnpBMUVvT1h5cFNESjdzQjUxWWV2bk8yR0U1dDhRVTMrV2Ra?=
 =?utf-8?B?TWUvaXBvb241dmRGTlBlWGh6R1FGNGJJTkJiRmx6T0hFU1ZOcjB1UmgvNm9u?=
 =?utf-8?B?YkcwMld0Yjh2NUpmc0xKMFVoVmNrZVRhb3JHeU5NMG96dysvZXRENmkyWXdX?=
 =?utf-8?B?Z1JHWnovczBOMzhSMnZZdWNBTStPZmFUcmxUN2lMTHNKWllYN21aUjMzam1E?=
 =?utf-8?B?UUJSQWg1NEk2VEZFUDNnblB6Qk5VcWtWNEFpU1RCUUpTQmRWaGtXT0VNY3Fv?=
 =?utf-8?Q?DPuT2CbBZafsyC2OjWzu3uNl2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efbfcb2b-87a9-433c-879e-08dd3a22deca
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2025 13:52:40.0002 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y1Dwm3ri7RqNVQ4kDF1sziJGMuaDtD+CmP2lqU5IDxT8uiloP6kvymjzOATUZwXX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6756
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



On 1/21/25 14:15, Jerome Forissier wrote:
> Hi Michal,
> 
> On 1/21/25 12:44, Michal Simek wrote:
>>
>>
>> On 1/20/25 14:50, Jerome Forissier wrote:
>>> Adds the COROUTINES Kconfig symbol which introduces a new internal API
>>> for coroutines support. As explained in the Kconfig file, this is meant
>>> to provide some kind of cooperative multi-tasking with the goal to
>>> improve performance by overlapping lengthy operations.
>>>
>>> The API as well as the implementation is very much inspired from libaco
>>> [1]. The reference implementation is simplified to remove all things
>>> not needed in U-Boot, the coding style is updated, and the aco_ prefix
>>> is replaced by co_.
>>>
>>> I believe the stack handling could be simplified: the stack of the main
>>> coroutine could probably probably be used by the secondary coroutines
>>> instead of allocating a new stack dynamically.
>>>
>>> Only i386, x86_64 and aarch64 are supported at the moment. Other
>>> architectures need to provide a _co_switch() function in assembly.
>>>
>>> Only aarch64 has been tested.
>>
>> I can't see the reason why to keep x86 around if it is not tested.
> 
> OK, I'll drop x86 in v2.
>   
>> Licenses should be cleared for all files.
> 
> I will add "SPDX-License-Identifier: Apache-2.0 OR GPL-2.0-or-later"
> to the coroutines C implementation (include/coroutines.h and
> lib/coroutines.c) since it originates from libaco which is Apache-2.0
> then was modified by me for U-Boot. I will add GPL-2.0-or-later to
> arch/arm/cpu/armv8/co_switch.S since it is a new file written by me.
> 
> 
>> Also I think this mostly should target full u-boot and not really TPL/SPL as of today.
> 
> I agree, but why do you think it targets xPL? efi_init_obj_list() is
> called as a result of "printenv -e" in the main U-Boot for example.
> I mentioned in the cover letter that I think coroutines could be
> beneficial in other places too.

It is build for SPL too if you look at files which are touched.
I think you should define separate symbols for SPL/TPL.


> 
>>
>> I have applied this patch to measure time difference on kv260 and kd240 and pretty much the time is the same.
>>
>> diff --git a/lib/efi_loader/efi_setup.c b/lib/efi_loader/efi_setup.c
>> index 94160f4bd86c..18d2260b8c11 100644
>> --- a/lib/efi_loader/efi_setup.c
>> +++ b/lib/efi_loader/efi_setup.c
>> @@ -258,6 +258,7 @@ extern int udelay_yield;
>>   efi_status_t efi_init_obj_list(void)
>>   {
>>          efi_status_t ret = EFI_SUCCESS;
>> +       ulong t0, t1;
>>   #if CONFIG_IS_ENABLED(COROUTINES)
>>          struct co_stack *stk = NULL;
>>          struct co *main_co = NULL;
>> @@ -272,6 +273,7 @@ efi_status_t efi_init_obj_list(void)
>>          /* Set up console modes */
>>          efi_setup_console_size();
>>
>> +       t0 = timer_get_us();
>>   #if CONFIG_IS_ENABLED(COROUTINES)
>>          main_co = co_create(NULL, NULL, 0, NULL, NULL);
>>          if (!main_co) {
>> @@ -333,6 +335,9 @@ efi_status_t efi_init_obj_list(void)
>>                          efi_obj_list_initialized = ret;
>>          }
>>   #endif
>> +       t1 = timer_get_us();
>> +
>> +       printf("time counted %ld\n", t1 - t0);
>>
>>          /* Initialize variable services */
>>          ret = efi_init_variables();
>>
>> Please correct me if you have measured it differently.
> 
> That's fine. Do you have a SD card inserted in your board?

yes I have. I do use xilinx_zynqmp_kria_defconfig only.

> If not, the efi_disks_register() call is very quick and
> therefore it makes little difference if it's run
> sequentially or in parallel with efi_tcg2_register().

I think in my case where distro boot runs things are initialized already that's 
why diff is not there.

Thanks,
Michal

