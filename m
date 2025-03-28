Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37D07C28B20
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 15:19:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97A1781273;
	Fri, 28 Mar 2025 16:19:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HnO0epLS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69EC08129B; Fri, 28 Mar 2025 16:19:43 +0100 (CET)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20603.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::603])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7477C810EA
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 16:19:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xRTDJA+7nEW9S1qEe6PgvXNgxz0iKieQB0cIu0wocecndMbdqHHfOmMwvwcT0O83zX3PBaasqISqG9n+jDwr+3HIcgy43rVEtTfvmBsMMYXbqKsByM6aXh9nfX0AF8OdQAmZKlz0cPfJ+KokUkZ9/CV6FwfeynO4wPSu2WaNrfLiiaBqO9KwJCEzIO8CJWMCLgv2VqMbceD6o7yR6cOlNGS8aU57Jwo9oiNG80L5p2bOIfHl1V8FnueLOj1ahBx98k4n7XOIiB0DFHlv6/ypZtMc4TjzqzafMnhL7atXCgeEAxskatHIrbs1qD2B7XTbOvyNR/ORHZA5sghEMOqvzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7uFgGzl5+IQzPcjTjSif68AmMfpRbcTPyb9g/Q4uSlE=;
 b=Nm2t+/Wo62T8b0ElT/HsuF6t+8SqxfQ4VAkkS6XEexofG5+HGp6HCSyQx+1Iw4Km6JtKkp/3Ef0P46FLhlbD5vm5txf7BR054+YH/3CoD+ljT6zBmmbiifTMrlF+WkvIh5vSoPqo6KB1NCFzj/ZeCfzTS0/jfy9bptDvytLh4dy0MELH4/VY94m6Kbw3xWrMRH68/xGKYXLlpqZ7jdQm8JKAgbywy6bvs6xA5FbryIShFr+5K5+Gng+QO93BldJ4siF3Pm+XdXiJjGhyOZjIRThMXd1zBttxipRwQ+tn9XLeMtQCrv7ToRfmDZSk9VhFZDCdyMyJBCPejI6tF3Cidw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7uFgGzl5+IQzPcjTjSif68AmMfpRbcTPyb9g/Q4uSlE=;
 b=HnO0epLS1/oyLe0sWvdejiQQhTnIFcTnnUeu1a4oLz0RDLG8k5OYSp8/xrhYG1Tac0Ya4Uq+tTyeu5lUBUGlhCbyAiIlD4aK+AaX/hnFRepBGhlcg8MbymzoXg4qjSZGZTnkWlI/+QZyUpGlzVUYq8aHDWFjDPjkddTP1ZKUcE0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by BL3PR12MB6593.namprd12.prod.outlook.com (2603:10b6:208:38c::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Fri, 28 Mar
 2025 15:19:34 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%5]) with mapi id 15.20.8534.043; Fri, 28 Mar 2025
 15:19:34 +0000
Message-ID: <b33cbfe5-3755-486c-baab-d3195211f4c4@amd.com>
Date: Fri, 28 Mar 2025 16:19:24 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: zynqmp: Use CONFIG_SPL_FS_LOAD_PAYLOAD_NAME in
 binman
To: Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de,
 git@xilinx.com
Cc: Prasad Kummari <prasad.kummari@amd.com>, Tom Rini <trini@konsulko.com>
References: <022449eaa99ce8b96bd1c0af9bece2241180be6d.1742389724.git.michal.simek@amd.com>
 <421afd11-7a50-415d-b43b-9db62e416dd9@cherry.de>
 <7359fd8c-8235-4530-abae-b97c80cb3c79@amd.com>
 <3b4a6c39-3d26-40cc-aaa5-009ead2684b9@cherry.de>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <3b4a6c39-3d26-40cc-aaa5-009ead2684b9@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR0102CA0070.eurprd01.prod.exchangelabs.com
 (2603:10a6:803::47) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|BL3PR12MB6593:EE_
X-MS-Office365-Filtering-Correlation-Id: a8fec6cc-2afe-415d-c966-08dd6e0bf21b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TEpiRGpFOTFFbm9nTnZYQ0VXS2ZSN0NzMzI4dElHNXRLck5VT3RueEt4dnJG?=
 =?utf-8?B?M2RKZjVuak4wZ3dJK0JMTjRCaG1nY0U0VmxWY01WZG9ueWNUQ2ZCdHE0MnZw?=
 =?utf-8?B?WFpyM1JaL0xRTlJSNWt2cGJtOXVGYlpSWTRhN05YT3hFMTRjYy93VXI5RS9Y?=
 =?utf-8?B?SFlrYmpOUklPYUVXbS9uWGozbWJiZ0Y4Y2pBd2ZhTFJRK25IK1FqRFhhcGRZ?=
 =?utf-8?B?VHhZbWN0eVppcXB2QnBKcWRDQXpVQmRBaGJ0a2RyK01BNm9VTEpLL0JoOElK?=
 =?utf-8?B?ajdoaWJlOE1RZWpNLzd4ckphZzA3MUdyeWpFRzk3VmZNMDNtM3NZeUFjZm9u?=
 =?utf-8?B?RjV0QURINEpvRGRKeDZoaWlzcHo4UEgxNmJDUkZuKy85ZVB3MEptMkxvWVJE?=
 =?utf-8?B?VG1qNnpiTUtyU2JNd2hHQmdiK1ltU3VTVlFRaVorM044N2Z0aWdrM3NDam5V?=
 =?utf-8?B?VUtkNmcraW9oczFZREo1OW9XaXFhcEdKTFg5eVp4RW8wb0krb3BMQWJKSVh2?=
 =?utf-8?B?QjFjS3gyUDhOVzVBU1o5SU0wSGlRRldCdlk3MVFTL1RIN3ArMmZIMkU0eUV4?=
 =?utf-8?B?NlpyTzYvMW9QWWFMbmplb0ZNYURZSjZUbW5ocnFkNXRGKyt2blo5QXlYUnE3?=
 =?utf-8?B?UjM3YlV0YWc4aG05dGltUEJrNmd3KzdXY3gvZVBOUy9wK1NoZ0g2UjFtOEdU?=
 =?utf-8?B?SVR0YmJsNEFvcHJJZDlGNEY3OHFVUEVJdm94dTJNa0p0dzdwTUVFZExjc25N?=
 =?utf-8?B?eFR1UFYyWGFPQ0JSK3dWVzhqOG4rREVEQ0tiV1NHdEZ1dE0xT0xMNVYxZGU3?=
 =?utf-8?B?MUNlYytZWlNhM3VqOHErVGFhZjBRaVNjWVE4QVpqTEFKWWxIZUgrMGVFVC9F?=
 =?utf-8?B?ZE1xZW9VYk92aGtOd2dreDZKN2szWVNhTEpiTkl4bmRaV2dZSEhtbWNpeDZX?=
 =?utf-8?B?cm1TbWRyc0kzNUlVbVpWNTBNWWd3R1NxcFhZazRmVG1QNTVoelRBQ0ZyT0xY?=
 =?utf-8?B?SzlHWmdKSzA2UW9nT3FQQXpGcUR3ZXBrOUlmTkNJR2xSQk92bFpTSEs1WFpN?=
 =?utf-8?B?VUI3TVpNRWR4QTJiKzFVcnk0b2JGcVVPVCtZbm5wRTVqRHVFY2RVQ3pTMElC?=
 =?utf-8?B?UFBwZUY0dzRKWEYwbnorWU9JSFhEVlVWekZOelpzdytyd3M4ZXhoc0RuWGx0?=
 =?utf-8?B?WjlCT2JQWEpXQXRObXd2MGRZbVVVUVloZFJsa2FVUjREMlVoZmp4N01rYzl1?=
 =?utf-8?B?eWtxMUlYWXhRUC85UHMwaWNEZE5sSXRweU5LQ0V4ZnNhU1g4dDgyWER1YjZ6?=
 =?utf-8?B?RER6bUFIRjh6TUtIaDRXc2xPM1NDemwweFBnODh5ZGpzOWdETTNqTEx1YXo4?=
 =?utf-8?B?WC9Ia1oyWFN3cElMYVlkNDVHekMvMWZFS3doMDErK3k4QVROTDZKc2xTQUFQ?=
 =?utf-8?B?b0FITVVRRmdwU1hwTTZHV1orOEpLV1hoYnE1a1BWeFRBSWw0ZFRtOVFoNmdo?=
 =?utf-8?B?c3d1emtObnhEQXdVTzdsSVIyb1BKRHYzOWdLaVlwL0txdG1qRFJCU1NtMkJF?=
 =?utf-8?B?dEFXTVlHRTlTS0ljRmpGc04yM0VjK1lHZHcray80WThMZUF2WU8zN2JLUnBl?=
 =?utf-8?B?YlorWEMxWnQ0SkxBeFZXNngzTTg3WTVGZlE0WWlYbVk1ZEJNSTIyeE9qSmdQ?=
 =?utf-8?B?QVMxUnMvb2hvZy9NaG9OY3FOeThUWDJXSlIrWWg3WGJzQ2JrMmhSQmJQTXBz?=
 =?utf-8?B?VnJnT1NQcUlmTDVNTE5VQzllYnRrVVUrSUYraEdQZzlBZ0VnbkkvclFSbkNV?=
 =?utf-8?B?QWV2QzIzd1NTVDhNVXRpVFV1UnFVb0tkY0lSd0VXVWxkTmJVNlJGL3NxcUFm?=
 =?utf-8?Q?queQCoFqflQAl?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MEw1VjVKYTFITk52a2c3dmdQbnozdEZGOVpKL0Nrd0cvS3g1bGkvV053dE9y?=
 =?utf-8?B?KzhVVjhCQ29JU1hodkVQZkNDd3pEY3QwZ3B3UEZVTllCMmRTb1hKdURqeWJo?=
 =?utf-8?B?UjE2dm9JdnBCRGVZdVJZK0xnVUdWRVVqZDNETUpTSlkxU2F6bjNoekh1dzU5?=
 =?utf-8?B?UzBqdWk5TTd6WUNIRHRFT3haWThPMTF1bFJXa0crK3cxb21wZ0RpZHNJSHZE?=
 =?utf-8?B?dXVOZ09RSjBSK2VvemxIell4RGxSYjhJMkVaMVJRM3puUjgvQkF0MWxDMzNU?=
 =?utf-8?B?eXdXaHdZVjQwYlRiUXlzQytBUEZYbC9CVURRR1BaMGZzYTRUUlJZSW5TNHBo?=
 =?utf-8?B?WnpyaTJmTi95VVc3NkI2dFRjckVrQmJyZko4Nm9hcjdsYWVNY25IMGhiM1R3?=
 =?utf-8?B?cWVhNjhIT2tRdjQrYi9iK1JUREdrNEhEMEY0WWtweWlVbWhXN0FvSkVTbFda?=
 =?utf-8?B?cmFpRVQwbStNUVNLdmQxeXlTUkFya0Z2VnVxc2hJTGtWUE1WaXhGZU1yMmtU?=
 =?utf-8?B?OHBCMHZnTU8wMnBIYStsc0ZBN011T3F3YS9aRUlxbks5TnZVRHVTaHpFc2Fw?=
 =?utf-8?B?eG50bGRMM0NrN1dOMEJUaTV6ZEc0d1JHbENySkdWWWplSlc5eDZDK3ozOHJy?=
 =?utf-8?B?eEYzdCtrcmpNY0UrL0owc0hxUytNblNxeXRralhOc3ZHMkFVOGpZRnFUTVhn?=
 =?utf-8?B?Zm1sRkFYU2c5NjIzRTQrZDdmZldZQ0hxOTdyakwvUXBMNkhubU1SbnBlZDg1?=
 =?utf-8?B?TUV1OHJqb0R3b2hxVUY5VWFkVS9pYWRQRjNCRUdoTHBqRWFnYm5LcUk5Tk9F?=
 =?utf-8?B?WmJDdkRGbWFyeTh1TlA2Nmt2dmhXZXZjY3pmeDVVZFFMRnVybnFMcFg3Q0RV?=
 =?utf-8?B?RHdkV3RiY1Zwa2pZR0FOUmROWUFIY05oTTJnbVJkSUVscFpkeXd1UHVVbVMw?=
 =?utf-8?B?YVBPL1hTb0VxSXN0eFV6N2d4YnVkVm8xTzlRaXYrbTVsU25ZRHgzaWVxOWNp?=
 =?utf-8?B?R2VNSEZ2QWJVTTNjMFhyUDZ6b3oyQ05PcHM4UjVPbEh5VExQemZpU2s1L3N0?=
 =?utf-8?B?UE1YNzhmVDBLU3FucW1XUjZibDBJZTdObGViNDVGQ2ZpT25TOXppV2RsVXBj?=
 =?utf-8?B?T282TDhTcytXSkpBVHY5cXA5Zk1xakprQlFGUHkxSS8xdlZDZ1dKK1FpM2dn?=
 =?utf-8?B?YXdqQ2Y4cXhsQVZxcm1zTC82WmJSWE1MbjNxOHdMWlV6OHJQOThJeU9ISk5R?=
 =?utf-8?B?aHczZS9wSksrU2xpUUlkMVdQK2pPWVB6Q2YrdkhuNDZRcVloN2IxRXhVTGdX?=
 =?utf-8?B?TUJIUlNGd0ptSCtzb3IvMmtQS0VwYjIyRENLL1Y2aTNuYkFwUllMMUxKaThq?=
 =?utf-8?B?S3NiZTg0d0NmeE01TEI4VjVTSlNxdy9sSnQ5ZnlJbHlMTENJYVBnYzVMQk5U?=
 =?utf-8?B?ODJiNU9hQmlGOEE2L21kWGNvSzYrS0VlYXFmUHo0Rm1WY2VWT20wRzBkRkpN?=
 =?utf-8?B?MlZSeGtJaVVXcXd3ZnhscGtGNjdYeWFNMWpJMm5GeXhnSlpnZFNRRzgzcWY2?=
 =?utf-8?B?aEVHUktWbmNIWVVjWG5xNStRRjVEMDB5cEg5bzNUVDhteHlVRG9LcDZ1TmFj?=
 =?utf-8?B?VWxLSzV6K0hHNnFEeERTaEdYNnVBYzlNYXhqUlNoOGcxYjVKN2FEWGkwWmRD?=
 =?utf-8?B?Z0JBTDVVSklqdlZwQVpnNDRrcHZncHgybjRPclVBQnBwSEI0SVY0bXJkU0lM?=
 =?utf-8?B?emdtamdkQnRSTW5HOVdPbHlOem5LeDNKRzhSR1VaM3pqN1pjLzhBUVl1UzAw?=
 =?utf-8?B?c3NGckxFaFBFS2g0V1I3dWs3aU5zRE5jV1EvUFR6Zm8vNmlYNEN6MVNuWlNC?=
 =?utf-8?B?bUNjaDNmRDR4US9zSUtoR0toVExDajU2Yml4UWlyS2lmWWxWczUxL05MSSs3?=
 =?utf-8?B?dzZYZjJxa3lCNkprVWtRUVN3YUZMMEx3a2trZjhwS2cwUVZCd3BLb1h4Mm9Y?=
 =?utf-8?B?M0hzUVg5YkI2RnhNUUZxejVOaU83ZTl4bDgyMFlLMGhFaW1HK0xsWFJqNVVu?=
 =?utf-8?B?TUVQMWlTQi9rNVRVWVM3Z3BvaVdiR3JpcWNjZjVGYlNLYWlFSUVhODZYdHF3?=
 =?utf-8?Q?rml6I37ZxK6xTjuLU0F/muh6H?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8fec6cc-2afe-415d-c966-08dd6e0bf21b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2025 15:19:34.4735 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TcABs+DQq+Cx0gWqcjJoKMTE9FswvWE4QD8b4Y/VeB9JTK/y/JenkTGhiG1qSewM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6593
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



On 3/28/25 16:08, Quentin Schulz wrote:
> Hi Michal,
> 
> On 3/27/25 10:11 AM, Michal Simek wrote:
>> Hi,
>>
>> On 3/25/25 10:48, Quentin Schulz wrote:
>>> Hi Michal,
>>>
>>> On 3/19/25 2:08 PM, Michal Simek wrote:
>>>> u-boot.itb name is coming via CONFIG_SPL_FS_LOAD_PAYLOAD_NAME and it's
>>>
>>> They are unrelated as far as I can tell?
>>>
>>> Isn't CONFIG_SPL_FS_LOAD_PAYLOAD_NAME the name of the U-Boot FIT that the SPL 
>>> is going to load from some filesystem?
>>
>> yes.
>>
>>>
>>> u-boot.itb in the binman nodes below is the name of the generated U- Boot FIT 
>>> on your disk.
>>>
>>> Your disk FS != SPL FS, no?
>>>
>>> I can get behind wanting the same name for the file on both FS, but the issue 
>>> I have is the additional CONFIG_SPL_FS_LOAD_PAYLOAD_NAME #ifdef will prevent 
>>> the generation of this U-Boot FIT image if the symbol isn't defined anymore 
>>> (which is possible if SPL has no support for FS (ext4, fat, squashfs, 
>>> semihosting)). U- Boot likely work just fine by trying to load u-boot.itb 
>>> from another source no? (No experience with AMD, typically only Aarch64 for 
>>> me, where u-boot.itb is usually loaded from a specific offset in the storage 
>>> medium, outside of any FS).
>>>
>>> Basically, do we really need to NOT build U-Boot FIT if 
>>> SPL_FS_LOAD_PAYLOAD_NAME is not defined?
>>
>> There are couple of things here. AMD/Xilinx evaluation boards are capable to 
>> boot from multiple devices.
>>
>> On ZynqMP we have one official supported flow which is FSBL or alternative SPL.
>>
>> In FSBL boot mode FIT image is not handled and boot image contains just u- 
>> boot.elf and that's it and no matter which boot mode you use.
>>
>> In SPL boot mode boot image (boot.bin) has only SPL and that's it. Then FIT 
>> image should be created to be able to start TF-A, U-Boot, etc.
>>
>> Then based on boot device there are in general two options which are raw mode 
>> (for example SPI) and then filesystem one (SD or EMMC).
>>
> 
> So no raw mode for anything that is not SPI? E.g. no raw mode on SD or eMMC?

There is also NAND raw but it never gets popular.

SD/EMMC no raw boot mode on ZynqMP. (Versal and never has it).

> 
>> In RAW mode qspi image is created (maybe we can rename it because it can be 
>> also used for NAND for example) and image is expected at certain offset and 
>> name obviously doesn't matter.
>>
> 
> But you still need a u-boot.itb to be available during build (c.f. /binman/ 
> image/blob-ext@2 which points at u-boot.itb). Isn't this u-boot.itb generated by 
> the /binman/itb image node?

it is and the patch is addressing it.

> 
>> But in filesystem mode names matter and image should match 
>> CONFIG_SPL_FS_LOAD_PAYLOAD_NAME because that's the filename which SPL is 
>> looking for that's why these has to match.
>>
> 
> That's fine. I'm arguing about the fact that you are not only renaming the u- 
> boot.itb to the expected filename on the filesystem but also entirely skipping 
> building it if the filename is not provided, which is not what's done today.
> 
> Essentially, I'm wondering if you don't want:
> 
> """
> diff --git a/arch/arm/dts/zynqmp-binman-som.dts b/arch/arm/dts/zynqmp-binman- 
> som.dts
> index d5b63ef604b..e73f196611f 100644
> --- a/arch/arm/dts/zynqmp-binman-som.dts
> +++ b/arch/arm/dts/zynqmp-binman-som.dts
> @@ -9,6 +9,12 @@
> 
>   #include <config.h>
> 
> +#if defined(CONFIG_SPL_FS_LOAD_PAYLOAD_NAME)
> +#define U_BOOT_ITB_FILENAME CONFIG_SPL_FS_LOAD_PAYLOAD_NAME
> +#else
> +#define U_BOOT_ITB_FILENAME "u-boot.itb"
> +#endif
> +
>   /dts-v1/;
>   / {
>       binman: binman {
> @@ -105,7 +111,7 @@
> 
>           /* u-boot.itb generation in a static way */
>           itb {
> -            filename = "u-boot.itb";
> +            filename = U_BOOT_ITB_FILENAME;
>               pad-byte = <0>;
> 
>               fit {
> @@ -227,7 +233,7 @@
>               };
>               blob-ext@2 {
>                   offset = <CONFIG_SYS_SPI_U_BOOT_OFFS>;
> -                filename = "u-boot.itb";
> +                filename = U_BOOT_ITB_FILENAME;
>               };
>               fdtmap {
>               };
> diff --git a/arch/arm/dts/zynqmp-binman.dts b/arch/arm/dts/zynqmp-binman.dts
> index 252c2ad552b..89dfbf4e936 100644
> --- a/arch/arm/dts/zynqmp-binman.dts
> +++ b/arch/arm/dts/zynqmp-binman.dts
> @@ -9,6 +9,12 @@
> 
>   #include <config.h>
> 
> +#if defined(CONFIG_SPL_FS_LOAD_PAYLOAD_NAME)
> +#define U_BOOT_ITB_FILENAME CONFIG_SPL_FS_LOAD_PAYLOAD_NAME
> +#else
> +#define U_BOOT_ITB_FILENAME "u-boot.itb"
> +#endif
> +
>   /dts-v1/;
>   / {
>       binman: binman {
> @@ -17,7 +23,7 @@
>   #ifdef CONFIG_SPL
>           /* u-boot.itb generation in a static way */
>           itb {
> -            filename = "u-boot.itb";
> +            filename = CONFIG_SPL_FS_LOAD_PAYLOAD_NAME;
>               pad-byte = <0>;
> 
>               fit {
> @@ -196,7 +202,7 @@
>               };
>               blob-ext@2 {
>                   offset = <CONFIG_SYS_SPI_U_BOOT_OFFS>;
> -                filename = "u-boot.itb";
> +                filename = U_BOOT_ITB_FILENAME;
>               };
>               fdtmap {
>               };
> """

You are right that when FS functionality is disabled there is no reason not to 
build images for qspi which are not affected. I will send v2 to address it.

Thanks for review,
Michal

