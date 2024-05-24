Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A580C25B74
	for <u-boot@archiver.kernel.org>; Fri, 24 May 2024 09:51:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C9428822F;
	Fri, 24 May 2024 11:51:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YAdf3oOk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 40EEE8823C; Fri, 24 May 2024 11:51:22 +0200 (CEST)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2407::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A09A788228
 for <u-boot@lists.denx.de>; Fri, 24 May 2024 11:51:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bmh7fAk8D4asN/ak+UxA2Q9XjIEdgEOQcwptzInaQ5A5uML71MpD689k1++jNzFSih2CeCwAVV8+52/C8IY2JzfUH5PJyLZz0Aq9NlTsgxu4suvS/tf7DKon46QCSG3pkfFonR06Y0FrEB1CIcovvLfJZTNikkrE0U2mb3S40ebff5ARFBT9P57fN9TWt4GBebT46qpdGqiWa/DQmwsi9JFW5BmwEMRzEzH3mXPoQ0Ir3uKf4b8TfG98wxNtXWiEFJq+BUtf/NbdS43KW3f8sEnXkMYElHwGGaujcnFmlFID+BWn0r89EAFf+Hr5krCTAAo9iASzH9CyQNufJ2jkAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T+r8kQQi7akiicWK1JkrqHSFSEs21T7zk4GF9F966Z0=;
 b=TvRHw6Fx6/TmKlLVZv+nvEJ2uDhFZ8Yv0sms1ty+tEHx/nqk13RoMMjVnSjCFVtUaEgiVpuNDM3T/KiE38Bs2ak4Wbm9/aBniL7NJ0Ayoj2TNq4P4r5k0xVvfROigvin/tiUGMjh3rnSCUsxVatVTGQ9six46IF/nQz4hV00TsJAqCJCJg+rv4Y19iRldSpPQspBs2OFsJpY7BavWU5akz2zPQTiiz6MqVgujOnPMwbex8hS+UgpZpbvPU+IQPzeRt47fHyvY6iLj3/ywiylQQ/UC0wX7moqT3W0kFP4PQnb2gbfzoH7Lm7bC1CQHfUFg/BlvK1ViqFoUP/Ae1IPKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T+r8kQQi7akiicWK1JkrqHSFSEs21T7zk4GF9F966Z0=;
 b=YAdf3oOkp/gfutJjKvMemtHyie3vW6FN3xRFi97Tj6aoJTgKUwOI3Y/HVNaqJlS+JRrTIzZoqIEkBrIR3okTMYXF8sEeM/uZE4Wj6BvxL2xZ5evcT20O0HCOUmRdUzg4BRTxFHjiwwtHsXCI71jZ/hQ4sWDwwfqdIzuHKwn6XOQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by CH3PR12MB8547.namprd12.prod.outlook.com (2603:10b6:610:164::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Fri, 24 May
 2024 09:51:16 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%6]) with mapi id 15.20.7611.016; Fri, 24 May 2024
 09:51:16 +0000
Message-ID: <15a65f0a-1ec6-44e6-97ec-61c026a4c774@amd.com>
Date: Fri, 24 May 2024 11:50:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/20] FWU: Add support for FWU metadata version 2
To: Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Yann GAUTIER <yann.gautier@st.com>,
 Etienne Carriere <etienne.carriere@foss.st.com>,
 Patrick DELAUNAY - foss <patrick.delaunay@foss.st.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Michal Simek <monstr@monstr.eu>
References: <20240322105733.203888-1-sughosh.ganu@linaro.org>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240322105733.203888-1-sughosh.ganu@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0058.eurprd04.prod.outlook.com
 (2603:10a6:802:2::29) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|CH3PR12MB8547:EE_
X-MS-Office365-Filtering-Correlation-Id: 25d0ab35-f168-473a-3f0c-08dc7bd70db7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UTJvTXVZRkZZUVB3YjM3WkkrOXFFT1Evc1ppL1JVVFhNMFFleVNMTXhOclpm?=
 =?utf-8?B?cVdkSDFmOEkydVFpVTdQaXdaV0xCNFB4NVQ0b0NLR2VVSTBoTjV6cS8wUHpi?=
 =?utf-8?B?bnBmc05mUHg4VVdXanhXVnd1S1kwb3pmSytUZHJWTURYTUw3SnNJaEw1QkFR?=
 =?utf-8?B?NitBeS8vT0lOWlBLVG9oNFpGZTdMdVM0WnBJTFZrYzB2OStDOG1vQmNTeHUz?=
 =?utf-8?B?QnBrdjkyMzBwdGF0NWhYT3dmb3NCUkxDekJvZksvOC8wZ2JicHZxWGNMOHRv?=
 =?utf-8?B?WVhMSHAxWXFQTEh2NHR4SkZzT2tuam05dCtEYzdYTkZCaC80b2x2eVZ2Nmgv?=
 =?utf-8?B?U2NISS83OUZDQmZkUVAzL0VIQTdrYmFteXpwYzVQeWxLUUxRczlvVlpYcFpN?=
 =?utf-8?B?eUpPT2lkemZqVFBmREtOemFlUWhxZ2h1dzNGeWplZk1NYkIrbXF1a2Z3WGlJ?=
 =?utf-8?B?dThQR2JES1BGL1MyOWN1Z3pDYStIVDNhTGV1akdYSEZMNEYrUjljM0dXTWQ4?=
 =?utf-8?B?ZEpDN0t0RTZFVStXWWU4N3VibXk2WEh1dGhQWTRGejZyTk95dUpYVWJ3K1hv?=
 =?utf-8?B?em5xa201Nm9CckpSMjZVRE9TUzFRN0dRVEJ4RXZ5L3E3a0V1SlAxRWRsT1pZ?=
 =?utf-8?B?ZzNwTnpXeVBrbGZpWERyTlozakFSbmVHRnRCKy9PdXVYVHdUZHdWbUxzS2dk?=
 =?utf-8?B?Z2tlYnJON0N0TmlFY3N3V0R5Q0t0KzFHMUk4OG05SHRKL2F2aXo2cWlLaUx3?=
 =?utf-8?B?d0MvN3BWRUZkb2dVMXR4dGcrQXlTZk9NUHgwcTZyZWZKUzZxUXF1elpFVnRy?=
 =?utf-8?B?ay9IbXU2YlM1dml3SE41ZzNVVDlWbGtHakMvcHpuSTZqNGZkMFNCMFlWWEJm?=
 =?utf-8?B?ZDRnRkNhZDRJM3hsMUFVZjhWdlBqNlVGZzM1bzhTcWlucytHMmFCYmFNNi85?=
 =?utf-8?B?RVJxZ05TWVZuRTY5R3RSWlN4WjliYS9DanlLZHR0SDhCaVh0cGFGNTkvRVE2?=
 =?utf-8?B?eDRpekE4TG5Cb3FLNEhEM0ZNaEVpV2g2NzNJNHk1SmlBT2w2amRrT1BiYXQ2?=
 =?utf-8?B?UHA4NFZaeGw1cUl1NGVrT3BzdHo3QWFObm9OT3BQN211VHkzVEt4OHJrd0RW?=
 =?utf-8?B?VVY1dWM2c1p0WWM2K1VJSUVJRzlDREVLWEpEZlpEa0lUU0tTL1ZOdkt2Tm1G?=
 =?utf-8?B?L0psL1hheEdMenpZbmJ4VVV0L3h5bmJjTjZ4UGdnNVhtS25Na1JTbzR6TWdJ?=
 =?utf-8?B?cW9LNnluSXp2OHJjOWpWRTZYeEwvcmI5TDdQYUdib0lYRmh2S0sxYVNiSk9z?=
 =?utf-8?B?SGMrU01ZNEVkeUtoVHBhMkhwaFJEeGJXM2M5S3VHVXZqRFJFUnhhV05BbjF6?=
 =?utf-8?B?QU90NWxzMWdZNzN0bTAvQjRtaWQxdStvcFg2dVFJWm9ZZVMwZVp1WUQ5STQ3?=
 =?utf-8?B?U0NzaVk4ZHFMSzVFcHhQQXFNUHNDdzZ5VTlBa1FiYnMwQWR0Y3lMVFVtVW1J?=
 =?utf-8?B?Y1dOQktzMVFkNW54M2tMa3RUdHRiTUJEem0xZG4wWksyOWFYVjNjNDJ2ZWxE?=
 =?utf-8?B?NzRZZVVqODhLaWpreDM5ZGRnUVF6TENDNDBFVEdCSTlEcnI3WkhiY3Q4dFdO?=
 =?utf-8?Q?QXGwfZYIhwIqSemdiv1GKsebO74c/zBCqcJvmp75825w=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bVNGMFd1anJIVXI2OHF3T0QxaDVZc0ZuNlMweTdHeWNBNVo2OUpXdzdiUVNN?=
 =?utf-8?B?T3kvSjRmNUttakYvMTRCeGpCSFUyVkxPYzFTYU02enlkZW01aXhsU3preFY3?=
 =?utf-8?B?TStsRHNpQUlCUElCYVorOTRZS3hmL0NqRHM3VjNZTEZwUmF1TWtVM1V3clZR?=
 =?utf-8?B?akVoVmVGeWlkTmw2a3I4VW1zMC9ydlppdlA4RERXRjA3amFneUJ3TUltRitQ?=
 =?utf-8?B?VFV6YnR6Y09XbWwvV0NhdExGM2tMSXZZbE1jSCt0MXZ4aXZ6MloxR1o5Q3Ix?=
 =?utf-8?B?Vk9sTlVXcUNhY2VxbHhOZW1RNUlONVEvcStZUm9FcE01cGtpTzFJbFJYZHJ6?=
 =?utf-8?B?YXRQRHZyZ3hNUmZYcFl3bG9tQTRLWGxFMTU5OHBtWU9RU3RhWUpUajBvK3J2?=
 =?utf-8?B?Wm15dHdIUEJTeXhPQnVSNjhtVloxaEZWaUNCNTlTZGkrSk9HM2NUd1JSN1hj?=
 =?utf-8?B?WEE3Zm1xOGx4VGNWcHExY0dQNXZXSDRZc2gweEd6S3l5QTY5Ny9MVWRGWVVJ?=
 =?utf-8?B?dDY3VUM2MUtmMDEzVjJTcFJoV3BTNUxvZXpIZzEvN01ocnRPS3ZTcU5MQzlQ?=
 =?utf-8?B?SUNDbTgrbTVqWEFHWmdiY0t0ODhpZDRPWjhucWM5aDd1UDBaVk4yblBLbWhT?=
 =?utf-8?B?TExFU0RSOEE3dHEyOGV5YXBpZ2xUV1ZzSUR4ejQzMURlTThHaGM3SVlWd25q?=
 =?utf-8?B?amJZUWdwS2JDS056dDhGN3lZMDRNTzJ6ZUFoSjFZQ3NLajFDTnBOd1U5Q1ox?=
 =?utf-8?B?NGJsTzB0MXdjZWc1WWRkTElLN05xSWhQY1V2VmNaOUFNdDVnZE1oUWkrU0VE?=
 =?utf-8?B?VDZWRS9ZYm1FNUxNUlN0Z1RZTmhFMHdETUx5VGNla2RmWlpuNTdHMEVMeEFZ?=
 =?utf-8?B?blNMZ1FvR1hZRFJGS3NQTTdKRzdCb2NJT1ZCeVR1Sk4wY3dGNmNKeTNjV3FQ?=
 =?utf-8?B?KzltUGFpa0tRL1UvRjZtQWVIdmExbnFYdnBCcksySVZ4NUhuZTV3RmZ2eE4v?=
 =?utf-8?B?MzV5Z3k4MjVDWEJFai9wamUwQVQ0YmMrWWNiUHRRWGd4RlErUXIxeXNkQ2xW?=
 =?utf-8?B?cmMvOVBiOVE4dHlDcHpUajJTa0hkSzhuWURYYWJXZ3dWeDEvZ0RmUVBWQUds?=
 =?utf-8?B?OFBWWmdMbThwVzNKWmg3eDNDMHlndmV2eVd4amxWb0FNcWZERThGNWI0cG9J?=
 =?utf-8?B?WGpzcjQ3Y1ZoOEtneWxwYWJob0Faa1NzQWpDTUc4RVh1Y09PTDV1eTBJWGYz?=
 =?utf-8?B?aTNYd1g3RWFpT3BFMzZlL3BXQnRFQkNucnFlUlFaK0FCTVNWMjBWQnF5Smxr?=
 =?utf-8?B?TzFJenNIOE9nYWxLRGIxYkhWU0NUbVoza21ZcVYxMHNueXExWDlGQnlFTXU2?=
 =?utf-8?B?QWdnalFlUFpSTC9hSUNrOG1yMkNNQnVHeWRTVWVwVWdGbGx6SGNkVGlDTWg1?=
 =?utf-8?B?em9JcHdpYVFqdkVVSklkT0RJV1lXYTc4YlZxVmJQanhDOXhhZEFzcloxNkVl?=
 =?utf-8?B?YXk4Q3ZMbTJ2ZzhONmU5dXNFckxnaVFTNXpOdUF3SzV5OTJlZVJGbVpFcVFn?=
 =?utf-8?B?NFpLVTdZYVdBYVY2UXQyZHpMNXU1ZG9lSjJhblRNbytCTVRMYU5oUlNtTzJw?=
 =?utf-8?B?U09BWVQvMzlrZUVSWlZDOEFOTlRQZnZsc1h4L1dGK0J2aU9Nb2g3ZDV1VE40?=
 =?utf-8?B?aXgzT0VvU1ZQN3cyOGQ5ci9VR1RKZ2grODBQTHBSRlJvVk04R2FNUUpQZ3ph?=
 =?utf-8?B?MnpzZzdJS1FYc1pxRXI0eFhDVGF4V3pSbzRQUWZ0VW9BdXhhQWxZR2NRbXRE?=
 =?utf-8?B?Ly9VY0dDWVQ2TGd1QzlXcU5aL2pEajlTQm1UaXJpZWVIVDdhcDR4T3JiTlhW?=
 =?utf-8?B?UHNsSVJJWXRubkZkaEZ5UmQyaEJtRkk3NEMwai9BcjQxcURWenBJcmEwekNF?=
 =?utf-8?B?ZDluQm9PK1JLMkE1L0FNbnZyTUtLazFJSmJUdGlmZDN3MVZLMlVrS3RrUDhZ?=
 =?utf-8?B?SlpHTWFYOTUwZ1prbGEwQlltd0pnRWJoVnpaRHY3d0NuR2lGWi85ZU14MlJy?=
 =?utf-8?B?VDB4emJ1R1pBdnY5SDVjT2VkS1B2amVkbVc4a0JOY0pxNWxsMDNmUURpNlZx?=
 =?utf-8?Q?L98Stz4c40sJfntolyMdAssPt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25d0ab35-f168-473a-3f0c-08dc7bd70db7
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2024 09:51:16.0276 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ctDytTQHlyVyOGNwGTpLPz3rB0921p/6ipwOpStqzf/bSvxMEWJEKcoio+Vbqqva
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8547
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

Hi Sughosh,

On 3/22/24 11:57, Sughosh Ganu wrote:
> 
> 
> The following patch series adds support for version 2 of the FWU
> metadata. The version 2 metadata structure is defined in the latest
> revision of the FWU specification [1].
> 
> The earlier versions of these patches were migrating to a version 2
> only support in U-Boot, similar to TF-A. However, based on feedback
> from ST [2], this series has been updated to support both versions. A
> platform would still be needed to enable one of the two versions of
> metadata through a config symbol.
> 
> TF-A has code which reads the FWU metadata and boots the platform from
> the active partition. TF-A has decided to migrate the FWU code to a
> version 2 only support. These changes have been merged in upstream
> TF-A.
> 
> These changes have been tested on the ST DK2 board, which uses the GPT
> based partitioning scheme. Both V1 and V2 metadata versions have been
> tested on the DK2 board.
> 
> These changes need to be tested on platforms with MTD partitioned
> storage devices.
> 
> @Michal and @Kojima-san, please help in this testing.
> 
> Note: The CI is breaking on some sandbox py tests, but the errors look
> unrelated. I will look into those issues, but the code review can
> proceed.
> 
> [1] - https://developer.arm.com/documentation/den0118/latest/
> [2] - https://lists.denx.de/pipermail/u-boot/2024-February/546277.html
> 
> Changes since V2:
> * New patch which retains support for V1 of metadata
> * Earlier patch was catering to v2 only support. These changes support
>    both versions of metadata.
> * Earlier patch was migrating to v2 only support. These changes
>    support both versions.
> * Support both metadata versions instead of only v2.
> * Added documentation changes.
> * Make changes to have the test work with v1 metadata.
> * Make changes to have the test work with updated logic in fwu code.
> * Changes to indicate support for both v1 and v2 instead of only v2.
> * Add config symbol for selecting either of the two metadata versions.
> 
> 
> Sughosh Ganu (20):
>    configs: fwu: remove FWU configs for metadata V2 support
>    tools: mkfwumdata: fix the size parameter to the fwrite call
>    drivers: fwu: add the size parameter to the metadata access API's
>    drivers: fwu: mtd: allocate buffer for image info dynamically
>    fwu: metadata: add support for version 2 of the structure
>    fwu: metadata: add a version agnostic structure
>    fwu: metadata: add functions for handling version specific metadata
>      fields
>    fwu: make changes to access version agnostic structure fields
>    capsule: fwu: transition the platform state on a successful update
>    fwu: add config symbols for enabling FWU metadata versions
>    fwu: mtd: remove unused argument from function call
>    fwu: mtd: get MTD partition specific info from driver
>    fwu: mtd: obtain image information from version agnostic structure
>    cmd: fwu: make changes for supporting FWU metadata version 2
>    tools: mkfwumdata: add support for metadata version 2
>    tools: mkfwumdata: add logic to append vendor data to the FWU metadata
>    test: fwu: make changes to the FWU metadata access test
>    doc: fwu: make changes to reflect support for FWU metadata v2
>    MAINTAINERS: add entry for FWU multi bank update feature
>    configs: fwu: re-enable FWU configs
> 
>   MAINTAINERS                              |   8 +
>   cmd/fwu_mdata.c                          |  39 ++--
>   configs/corstone1000_defconfig           |   1 +
>   configs/sandbox64_defconfig              |   1 +
>   configs/synquacer_developerbox_defconfig |   2 +-
>   doc/board/socionext/developerbox.rst     |   7 +-
>   doc/develop/uefi/fwu_updates.rst         |  20 +-
>   doc/mkfwumdata.1                         |  16 +-
>   drivers/fwu-mdata/fwu-mdata-uclass.c     |  10 +-
>   drivers/fwu-mdata/gpt_blk.c              |  23 +-
>   drivers/fwu-mdata/raw_mtd.c              |  78 ++++---
>   include/fwu.h                            | 147 ++++++++++++-
>   include/fwu_mdata.h                      |  71 ++++++-
>   lib/efi_loader/efi_capsule.c             |  14 +-
>   lib/fwu_updates/Kconfig                  |  14 ++
>   lib/fwu_updates/Makefile                 |   2 +
>   lib/fwu_updates/fwu.c                    | 204 ++++++++++++------
>   lib/fwu_updates/fwu_mtd.c                |  34 +--
>   lib/fwu_updates/fwu_v1.c                 | 167 +++++++++++++++
>   lib/fwu_updates/fwu_v2.c                 | 260 +++++++++++++++++++++++
>   test/dm/fwu_mdata.c                      |  16 +-
>   tools/mkfwumdata.c                       | 235 ++++++++++++++++----
>   22 files changed, 1153 insertions(+), 216 deletions(-)
>   create mode 100644 lib/fwu_updates/fwu_v1.c
>   create mode 100644 lib/fwu_updates/fwu_v2.c
> 

I tested it on Kria and I can't see any issue that's why

Tested-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal
