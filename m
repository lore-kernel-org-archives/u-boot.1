Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AFA2C282EC
	for <u-boot@archiver.kernel.org>; Mon, 17 Mar 2025 09:49:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A624B80107;
	Mon, 17 Mar 2025 10:49:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="b2WP+W91";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F1EF18058A; Mon, 17 Mar 2025 10:49:09 +0100 (CET)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on20604.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2406::604])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 68A91800C2
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 10:49:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mn3F/Gi+v1449wEjaadvibQfpkDzz7kYNIyKgXXL+qGm/5kWm6VQXsMF61CyVvqseuO2yggCrqT0nUg/slWO5ZwapfwGxyPKbEQpbWRV0tETInht7rCI/Yj6NOr9Si3gyFn5zuvL5Ycs4spI8bIJRJcCpjM3gPMLwdCGws0jdqEVkzDFZn2j9s/HUIBOUoE4CE7CzkJNgS/4ob2gH/FT5aexIJjk4FlY3GdL6s8ENY+tVf2eE/oyoonmfuYmWZS7hFuZk8PH7jKGSNYfa7JhGASSb1Ax18KM8u12avg0Ap6Z6dSSYmw0GWg8oI+b9nqeuOYkcpbABXjW58K8586LDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rzGk/dRt+fQexnlLo5vdVgaIG+e2UqW5/xJSog/iSkc=;
 b=GCSrLxdxo+MH1iksuA+iWSfaTkQ7tBifOoRHh5QnzsmhD52cHP34MBAbF6c8uPbNT7pz0BLt9w3U8QE/qS9d1ccZtAZzb3eoeIVQ6rKrC10jFeZKP87NYNUt5++MRQASd71HzXiHR5WUno4t+8xGBAlhVIu137dOtMdb2+KggcXPZ3q+dPOwdckUIM4UkPPqH7U/yykO5kMLpIXEtEEvVId/2zoFQRP+dVv8FmH9qEjCPu/tmaaMgTwcX35K3wYfRYy/jEKwnYCP5M/i411lCBsaPmG3u1W4hA1TugQazNOS2+LQiI9zE32GHhyfevDKDTOG4fW2mDDuSd0/LxoTDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rzGk/dRt+fQexnlLo5vdVgaIG+e2UqW5/xJSog/iSkc=;
 b=b2WP+W91GEOwvnGVGc8Hr9mPhYOU4iud1qYRA+WxkjdmwV9nyT46bp6C2Oi9J56Z9MYvjjzAPCNLmU9W0fpOyHxVQ0CCC1ii22xwx/qvSzP2yS8CZOCd0JCAaefiiouQhlDsjtcG8K0eylF8hlOvIkFSuxfmPtJ5mDh8VHNcsbg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB8101.namprd12.prod.outlook.com (2603:10b6:806:321::7)
 by DM4PR12MB6088.namprd12.prod.outlook.com (2603:10b6:8:af::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 09:49:04 +0000
Received: from SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899]) by SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899%4]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 09:49:04 +0000
Message-ID: <1704f391-e76c-49b9-83d9-e1a738da971c@amd.com>
Date: Mon, 17 Mar 2025 10:48:57 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cmd: version: Get information about GCC and LD back
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, git@xilinx.com
References: <59827eccb8a90957e3d4f09059e43cc7fe6c92dc.1741255948.git.michal.simek@amd.com>
 <20250306140250.GX2640854@bill-the-cat>
 <41f1ec1b-2c36-4ab1-9e99-77459deff366@amd.com>
 <fb24a61e-0fb5-4430-b5e1-1c2b25ca8159@amd.com>
 <20250310135605.GX2640854@bill-the-cat>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20250310135605.GX2640854@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0109.eurprd09.prod.outlook.com
 (2603:10a6:803:78::32) To SN7PR12MB8101.namprd12.prod.outlook.com
 (2603:10b6:806:321::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8101:EE_|DM4PR12MB6088:EE_
X-MS-Office365-Filtering-Correlation-Id: 81da353c-1601-44d0-7311-08dd6538f420
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eFpEK1llUFNVKzU2L0VaN3cxc0RuMTg5enZwdUEzb2ZIejVoSW5UZTBPK2xq?=
 =?utf-8?B?bVV3aDE0NU9jU0J3UjlHSkVxZWRmUSs4Wkp2bklNcWpEaWdDbnExeEdkdnda?=
 =?utf-8?B?QUhOUVl2TTV3QXJaR2swa3RBM09NbWxyN0RWZlI5NUd2c3lva3cwWFZpVUpM?=
 =?utf-8?B?M1A4OW84dVRERnhSSFk1Tlg5RFlQOWJFeGtzUHQ3VkV1ZndYSDVkdXl4QTk4?=
 =?utf-8?B?Ni9sd3c2Z2pUZEpKYUMzK0JXa2RFRzU2ODBLSnY4eVlRNWZFODczRHR6SXd6?=
 =?utf-8?B?VGc3Njh6R01SeXZGNGZtaWpGaFB5anY5Wmx0UGFpMDIraFRTcG1pNHh2ZU9s?=
 =?utf-8?B?Skl2eUtiSS9FMEVwQWhLSU04ZGJaYzVOdzl6ZmZXR0dxVzN4bGZoZ2d2aXcy?=
 =?utf-8?B?L002TndVcGh6cnJrY1Bqc1RNZDRsWjlJQld3QkdmT1RHV29kV2NLekhKRGNh?=
 =?utf-8?B?emh1akNPMDR2QXFNbUxwV1liZEhNSmhzN3lIc21HWW92TlVJQUdiMGZZVGhu?=
 =?utf-8?B?Z1VFRnNlRk95U21sOVVtVU13OTY3RDQvV2lNeis4UVZKOGRjQnZXaHhIanJu?=
 =?utf-8?B?L2V2WDg0b0NtdXMwVCsvM1FrVk9YWTBDWnQwZTErVExHRlNSTFNHbW95b3Fn?=
 =?utf-8?B?NlhvNzBFWENKU2hkTnRhVDVkSFJFRHh2dERaSkhjTXNzMkg0WGRteWhKMjBi?=
 =?utf-8?B?cjZ6VW5QeWcrRnYybDh2NkZid2dhb3N6Zld4eWdBdXdCY285Y3NSVU1sdXhz?=
 =?utf-8?B?eTd3Qzk1QlEwUjZ3L2w0N1pIZlBBKzJ2aFQvNGpuSDh0NEgwaStKYThncS8z?=
 =?utf-8?B?aVVJVllZS2NuOE5UaHVkK3pwMkxmeW94Q2FqL2xIQWE2SUtPckRYUFVrZ21z?=
 =?utf-8?B?TUJVMW1uQXBDQ1Izd0RwRy9sVWFDUGs4WjJtSFdPcmN2dk5lRWVQamVvOFRr?=
 =?utf-8?B?KzB0N1J1ZG5QUDNqUittcjQ5ZjBVMmplRWNYd01Gbk05VGtXdm94MUdwYUJq?=
 =?utf-8?B?a2lKV2ZtMFM1NkdqRGlnMm5vUDhNYXJ2a1IxY3NBa1VXQnRWeHRqaXd1ZndE?=
 =?utf-8?B?ek1LaUpiTlRtVDI3MytWS1Q1djc0RmpTdGRSa3lCMUFTRnYxRUd3UmlxRFVD?=
 =?utf-8?B?dnNPUFhjYWlUQlI4UmQ0MTZBVjlNUGVidCszWjFocnZaTTlzSHQzeUhYb1ps?=
 =?utf-8?B?VUxteW9DZGZ1bitpeUlPMlZBUUdvUlIxemd1bmw2VVljTVRjTHpOOWpNeTdW?=
 =?utf-8?B?N3dDbXNuYm5XaHpNREM0VTlSOXJ2MWZOelJOZWJxbjczU2JrdzdPVy9Ub1dM?=
 =?utf-8?B?d0NXdXdseUJDUjlaTGdudTZsV2tFMFZRRXNIU3BCblVidmhOcndYSG5wRkxr?=
 =?utf-8?B?djhTVXRHRmlWUVdOU29xU1J3ZGhhc2diYy9FdXFCZldGR1FwU0poSHU2cUpi?=
 =?utf-8?B?MWJUamc5MGY3NVQrdWVydklBV2NrNlpZSStuR0FqcVdsWEZkWnd3WU9zQStv?=
 =?utf-8?B?R3pUaVVGOXlYSkt5MzVXajJpblU5VGszR2cyaW83NHlMMTR6UVFrcXdrbzVs?=
 =?utf-8?B?QWdVTW4vc2lHOEhKZHZVOW5oMDh2YmVNUStXUlhxSnRlSzAya2lGaHJ4c1hP?=
 =?utf-8?B?NWRETFBsRzFaRDc4M1dPYWtTZGVtMGxuM2xVczdOb2dhN25tOUh4bjRvcDRv?=
 =?utf-8?B?NWlLdGQrcE8vYm5zWUFPM1ZWcDBqTjNjU2ZQcmpDMEQ4WjFPRXdlb2pmcUN4?=
 =?utf-8?Q?F5LuYmiPA3h70LaNbRplJTex6RxS7MByyf/iHQy?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB8101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Nk56QW54ZHhITEZ6KzZaWVRKRXQyTlZDdWZhQUdrK3M3eVI0bnhyelR5TVZN?=
 =?utf-8?B?QllzQ2Zja2dERGpDRFozUHB0TEYvdHJQYzhUazJwYmZxa08rbHFMRHFPTnlP?=
 =?utf-8?B?bjRRSWFsaE5OR0x3SmhjTFdEbHpuL2VsV3VjY2hKMTduY1BxTEN2MHZDOTcx?=
 =?utf-8?B?TlEraG1XQzBMdkRlWUFpTkk4WmNxTDhMTFVEVEh5U0t3OGYvZi82OVhESnpF?=
 =?utf-8?B?VjFXMlR4aDFVMi9rVFg2bWpQdVorUmd3aW54YWdBYmlpMEI0R0E2SmlQbDRr?=
 =?utf-8?B?ZElzaUJuN0ViaUN2RXZIRnQ1a2RIOHNmcXRBOFFPbUJhVDd0OFIvN05wczZi?=
 =?utf-8?B?aTN0dVFvcm1tejB6NHF0RUg3S1lzZ2J4TTM4Y2RhVEVacU9WNmxFQTZveDV5?=
 =?utf-8?B?S2lUL2JpeUhWWmF2bnZ2QUpGTUcwREZtZmFJQjVwemJQaDdPdytOSndiSjFP?=
 =?utf-8?B?d3BTV1BVKzZMU2pFVkJyVzh0Y1cvTUxGRzkvcnAxNndsR1RZTDhodWxNalE3?=
 =?utf-8?B?S01jRERJUkE4RlU4cGh1WFdESGIrTUpmMlR0alhGUGMrV1VUTDRqYUNmUjBq?=
 =?utf-8?B?UlJ1aExWWWRFckNHM3VXbDB3Q05QYUFDNEgyUnpNYUthcWFzd2hBNWM3ZHVq?=
 =?utf-8?B?RUJXSk00dk5DV3ozS0RmcVI1T0lReEJOckZxeVFpemF5SmJranBzZEF1YlFJ?=
 =?utf-8?B?eDVmRStCbVJnM1ovZDhUb2J6T0Z6OWFLOW8zd1U0ZjdpUEZvR3BaMmlyRXlD?=
 =?utf-8?B?a0Zia0x5WmxXR2FFeTBTVTREek1ZWC95T0lWcTVqcjNwemVhRHJJRHBVVDAv?=
 =?utf-8?B?M2ZWOFcxRGlXaG5WNVE4SURtdFlhaEZqamZEdE95SWQxcTBrcG9maVpXVE0w?=
 =?utf-8?B?cy9vMWd0L2JIeFFTdDczbzdncUlLWEN2Qm1YV1pubFBMMXBvd1pJMGNpYmlm?=
 =?utf-8?B?K1pUc0JWa090OW5icXhOVnpjdTY0ZHphZ2lqbnJRVkRzM3B5MjJyc1dyUHNQ?=
 =?utf-8?B?S29qeURRaDBaL0RwZ0tyb0hKREVHSC9YY2ZGV1pWQkdxNjY0dHAxRWJLN1JY?=
 =?utf-8?B?NWxRaU9kM0lSN1pMNG1QcWxZODJrTzJSQ3N0NTZHSEJkYW5NSFQwYVJHM3Y1?=
 =?utf-8?B?TjdHWjVtNFRLWWVGQkdmUmdrZDB6OEdpVDFDeVVZY0NmNWdMMlZuR3BaOWdU?=
 =?utf-8?B?eEVNbm1CQ3hhV2hjNXJlSnJhdXE5K2Erc0N4NTZDWmdPVjRVU1NlNjkwRm5u?=
 =?utf-8?B?M1NKenRlSHdXQ2UrV3lOR3NRaUNSdzRLMStza3EyY2QzdkJnM1pnMFFsYzNW?=
 =?utf-8?B?alRNcExtc0hsSHUxK0RraUwwMC85SDJLbnF2cmRvNjVybHk0eVZCcVBWWTlO?=
 =?utf-8?B?WC9CMUZKSlhqeFNCQVFlMzZBMVFFQmd1bm1ma0RzOFk1ZXlER2VRVkJHN3RW?=
 =?utf-8?B?cE5BUHBnbE9XcWIxVGZreE5Rb2cvQkVuZGVtM1BYamVMdE14MU9pZkxHTXMv?=
 =?utf-8?B?eW83OTV4WkJ5OENlVlN4dXp2RDBuSWwwNkFPR0tKTGp0dGRCQlpDU3dHN2I2?=
 =?utf-8?B?d0lvRnZXZEo2S2tZaWpEZ3BmY1N1QWpram9kUmVqOWhGbE1MRGQrUVYxYXpM?=
 =?utf-8?B?OGZBdEw2S2xkOHAvUWgzWEVHZThjdHNuL0lhY3MzcTFtclpqNzNMbnBwNnp5?=
 =?utf-8?B?S2JFSStzdjRrb3ArZ2NLeENhLzJ1eGZudUJoSE1RdVlZV3JxN3kyNG9vaHcw?=
 =?utf-8?B?cEdiR0ExcGhUdlMzeE1TT2g5dHVMSVVmMkZ2dUZGSEgzald6SEVOUUZZeENB?=
 =?utf-8?B?d2JVNm1RYXRFWlJKS1ZuSUxvZDYyTEZyTFpKbWtlU2FENkdLQ2RaT3crTGZt?=
 =?utf-8?B?T1pXMTRDNUNpVlQxZkxjNkp1VjZkamVxVDdJZkdwUFdocXpVeTZDdmNwL2FW?=
 =?utf-8?B?ZlU0WVBwT29JbXZOOXZFNEk4NEpXcnBBR0pwVDFyMUdsUVpqT1JvRlNpUUwz?=
 =?utf-8?B?dENtblZtZkdiMnJxS215emE0dFlYS0JqQWFJZElrb1hJVitjSm9NYzZubEVU?=
 =?utf-8?B?bzFwMkFwdTFOZ1R4WXVCWHlJYVBhb0MyUnpNYzkweU1PdXNMcWoyeU12aVF4?=
 =?utf-8?Q?6kIZTPs0tm4FN7CoCaWFlWSHf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81da353c-1601-44d0-7311-08dd6538f420
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 09:49:04.6866 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /aaPPs2wa77JdesaKtap3S807w6vFMY3XHjhGg0R1UTiazSqKWOp6scx85vbNU0r
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6088
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

On 3/10/25 14:56, Tom Rini wrote:
> On Mon, Mar 10, 2025 at 08:49:32AM +0100, Michal Simek wrote:
>>
>>
>> On 3/6/25 15:12, Michal Simek wrote:
>>>
>>>
>>> On 3/6/25 15:02, Tom Rini wrote:
>>>> On Thu, Mar 06, 2025 at 11:12:30AM +0100, Michal Simek wrote:
>>>>> U-Boot version command is no longer showing information about GCC and LD.
>>>>> The reason is that version.h has been removed that's why CC_VERSION_STRING
>>>>> and LD_VERSION_STRING are not pass.
>>>>> Values are generated to generated/version_autogenerated.h which is sourced
>>>>> in version.h.
>>>>>
>>>>> Fixes: 54ecce2cbf90 ("version: Separate our version string from
>>>>> the version command")
>>>>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>>>>> ---
>>>>>
>>>>> Tom: Not sure if this has been done on purpose or not but this issue has
>>>>> been reported by our regression team.
>>>>
>>>> It wasn't on purpose, no. Did you put this through CI / confirm
>>>> sandbox_nocmdline still builds?
>>>
>>> Nope I did not.
>>
>> CI is not reporting any issue.
>>
>> https://source.denx.de/u-boot/custodians/u-boot-microblaze/-/pipelines/25029

Are you going to take this to 2025.04?
Or to next?

I don't mind. I can also take it via my tree just let me know.

Thanks,
Michal

