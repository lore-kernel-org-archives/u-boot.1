Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A3A0EDF17C
	for <u-boot@archiver.kernel.org>; Fri, 13 Feb 2026 16:31:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 721FE83015;
	Fri, 13 Feb 2026 17:31:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="WfVBmRN0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2C4583AA9; Fri, 13 Feb 2026 17:31:14 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B3BD82A9E
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 17:31:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gakG/aueKSSbTg3aB+Ieg2J+4+W69yn2blBws+TxRWayoOePQehpTO7if2poW5kjCk/nfP7NyQ1IiECJ5F4k7d5ytaUGn54PUjnG2zm4uBMl2tW+L26xhyMV0hNsb9NVnzNBT7NDxPy0/cSh4GXnR65NgPnTyMOQOp8wR9KG7SI9UaxYiVa89Vskx1thGRcTpP1vzq+8URLEzCO2EmV5M/W4bPtVaSa9o3AC1jZNwNLXENp0M/CAUpQU2t7pUc7v7WaLhg0ct9UJ33NY7/nLJBOdKanurnwEAKMGEoNt0MDH2pe2w3lhITpX/vtGQr9+dbd8C0W3fNAKxcAsQToH5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GTzQU01SHjQuT6VX/r/8Y4e2gvptDPqZSqhHf3QXrwY=;
 b=RcQ3yiacPdqjN8Cc3n2vt8sAjvvU6iq53Vr7AdVcXnV6XGVmDsJUZS1Ao/4sND+p0TONO5L2RW7ozevdPnMV9qbhtPYS43vEjyAOeUefIeWHX1svXraMM+30PKR8bEJ+Ui3jnUpnj4nG0qGSk7cVFfVkbMbCs6TXBR4IMQTBRiwlfoqBsU7ubzPYKGh+tey+GnlgqawK7KahZNZ8K++COV/myJQo2U49F3P7y/x9X8LtKqxOh5Ka3ek1klks9Jmf4IdZN2r4myIQJCod0dqPbWU/QlTu5nEJjV5Wz6scqkeT57y4kwSCVki1urrFQQyA5yEnv+M6DuaoGshU/6q5kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GTzQU01SHjQuT6VX/r/8Y4e2gvptDPqZSqhHf3QXrwY=;
 b=WfVBmRN02IMYa3z5kf4vHsRzxu5HRx12TTAsbp6bLlp0Vqpv4lUToP7knIbyT4DuZgDX7tHbjFIBNPgQO0WX4t7u4CONYStdYJklJpYSP9IfBajE0ughXLCbtE7BQRjVM3qdIkJDzpe9LVD1FhuXfCoJ+vP37U/nTlEVTbBNPyE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by DU4PR04MB12247.eurprd04.prod.outlook.com (2603:10a6:10:630::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Fri, 13 Feb
 2026 16:31:06 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9611.012; Fri, 13 Feb 2026
 16:31:05 +0000
Message-ID: <0712faba-5e56-4cd5-b0d8-c9603bd7eda9@cherry.de>
Date: Fri, 13 Feb 2026 17:30:54 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/12] rockchip: board: qnap-ts433: Support multiple
 models of the TSx33 family
To: Heiko Stuebner <heiko@sntech.de>, sjg@chromium.org,
 philipp.tomsich@vrull.eu, kever.yang@rock-chips.com
Cc: trini@konsulko.com, u-boot@lists.denx.de
References: <20260114082822.4007128-1-heiko@sntech.de>
 <20260114082822.4007128-7-heiko@sntech.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260114082822.4007128-7-heiko@sntech.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0185.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::10) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|DU4PR04MB12247:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d37be00-3c5b-40a9-b4d3-08de6b1d48ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|376014|1800799024|366016|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eHpibmRyTTFnS1NZL2ZaTlZJU2ZLL0lNaVdwZm8zaEZ3M3hXNC8vUy9KKy81?=
 =?utf-8?B?VlNvVGNxWEFBUmRHVWtpMWp2blBtWXV6aUhxTHExYXNHM1VjVU4rWW9Mc1Fn?=
 =?utf-8?B?YjRhcDdoWGk5cE9yZmNTSUFCczJxcnVTVDNVeVdxYkhrcUpPbkxSSmtDaWJK?=
 =?utf-8?B?YUs3SlJ4Yy9mMGJKWDBuYXZzWXVCRmR3V1N3cUlxeXhXQk13dWdaU1R4akdJ?=
 =?utf-8?B?OW95ZnozRW9RcFVtWEx3SnZCbjJmdmRpdVFEM3cwSWF5a0lZWDk1K05Oaytu?=
 =?utf-8?B?QnBzU0NOTVFGY1R4ekJFNTdJZWJXOHRvb0FYODd3Rnkxb29tZmgzRXpPMjhL?=
 =?utf-8?B?YlgzSXFpajlFVncyNjAxMFdHUWpRMUN2dEtrbHN0ZG9yb1hlVlJ5ZVhaQm5I?=
 =?utf-8?B?eUtKM1dHTW0vbUdFU3FUQ3dKRWhMOXd5T3FvMExRalN0MVlCamU2aUZPSXZh?=
 =?utf-8?B?ellueW44VnlIVkdGaU8xbkJGS1F2MytTQU45dmlESW43Q0sxQVVCK3ZZeDFq?=
 =?utf-8?B?SnZ3am93SWxxa1VBa2l0cjFRTmZMT0Y4OGcvS3VWOFVwKytzTnZEYlUzcFd1?=
 =?utf-8?B?eHJ5ZmxqREpqTEloMUJ1VWI5STRqZ3hqaVE1Qm1IaStpRERKNzU0K21UYUk3?=
 =?utf-8?B?cC9kUkEyRzU0REd6VlZZd0sxZk1FMGhtSmNZOUYzb252QVFSTENRZnBqbW0z?=
 =?utf-8?B?bDhjM0NybXV1YzEvb0ZmdUUzY0VKMTNPZkdES0FYVS9oeVFvVjltQi9oV2Vh?=
 =?utf-8?B?SDE2VDRVMFZsdlJ0TEtBbDRKcW1CWklzTlZHK29OeXJ1cUdnUjlLb3NsZWpi?=
 =?utf-8?B?NTk2WVRWT3c2UVJrN1BDQ1pLQkhvQlFxQ0xVWkhETmZXcHFsR09ubDdXcXA2?=
 =?utf-8?B?V2E5cVBnZkt5ZlQ1dUE0T3BGMXl6UDV4QWZmLzQwZURPNjdRVnUyZVdyTnVB?=
 =?utf-8?B?OUNTRXQySDBJTUJSbVUvMUloYnVYNnJDNWc3RzhNYk1JVElkeTdBZEVYYkZQ?=
 =?utf-8?B?UjhkY25hYW5qcUFjT2dDVHVsTWdCYmRnZ1ZLVmJYSTBkNE1tQnVBV0JTVkRK?=
 =?utf-8?B?aHNpYiswWlhEbmZkSFdtRk5WbjJBUnRiN0RCSmNrSENMRTlRV21neWVIZnVS?=
 =?utf-8?B?NS9razB6dFE5YjlRWENOaFB3cHdhVzI4R2ZVQXRSZXBUU25oR3lOaVo3MEF3?=
 =?utf-8?B?WHNSRVJkT3RzOFlCbCt3cm85N0pMRkF4emxhOERseDUyZ0htTCtqelBpejd6?=
 =?utf-8?B?bjN3VmlHeVc5OEN2bzdGbHFYQmRiUklIem93aFVTcXdQb2lHaTZnbTY4VW9V?=
 =?utf-8?B?aVFjcldWNFl2Skd1Ni9GdXIwT2lwT3hVcXIxRk1KbDZ4bnFXZ1JEdkQ0NnNW?=
 =?utf-8?B?b3lZd2NLUFhkTmd4c3pFRVlreFVHdmFHcmFpZElVRCt5WDBQTnZpV05yUFEz?=
 =?utf-8?B?dTIrMWpxZjd6OVZBRmh1MTVqSXNGQmphd1NZTlNwdFlzRU15bTFwTGF2KzFr?=
 =?utf-8?B?SFBCckdiR3N1RWkzNWs4UGcyd0VLYnk0MEt3cXVnNE96WlU0SWxNS3AzdHlV?=
 =?utf-8?B?TUtLdWJRR3lUdHRIU0ZhNUxJVkFmYjNZR21SNnRxK0piNzYyWENjMjlUODV2?=
 =?utf-8?B?Y1NpMU50Zm5laFI5ejR1b1VSN3N3ZkF4Z1lSU3FpTUd6S2ttYjcvbXB1NGxI?=
 =?utf-8?B?SVJRbXlTWk9lSG03bW9Gcks4MGlhRzNwT0svYzZjenVyQm1nZDVwdWF5VGlU?=
 =?utf-8?B?U2FiTXdyK2tmWUlQbFEwd1hPZURsVUhxVUdtd0JHdzFSdlE2ODJYK01aNm13?=
 =?utf-8?B?Q1hyc2twNXE3b2NYWCsxYThpNytIS0oxa1ZRaE5RVmQrQ3c3YzZDUDBTNzBP?=
 =?utf-8?B?RU81UW5wZmUvc3NoWlZFb3lMNDNoZ3k4MHU5TVkzNS9ROW1MMUlCN2ZDelcr?=
 =?utf-8?B?bVlLUXp2dFVscHcybCtmWEFGczZ2cTIvNXM3WHoyMEFFOFZFRjZwR2Z2SmFR?=
 =?utf-8?B?c2tkS1ZIWVVVQU4wdi8vLzBZQ1dldVRKK0RTS3NwR2JMNHB0aUh5c2Y1RlVQ?=
 =?utf-8?B?am10ekVwZ0p0cS82cHJPOHlpYVEwOER2S1V4dHhDL2FqUTdPNU5NZjMxYzV3?=
 =?utf-8?Q?eleo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(1800799024)(366016)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWJlMDZLOTdkSi85Sk1aV3VDWXpzTVpSeHlGR0Zic2VxZTRTRWJkQTVna1Q5?=
 =?utf-8?B?dnV6WG5kMG55Q3JBVUxtNUk3YlVyZVl1MFV5ZThWQUhMQ2dMZitZbkFIM2ls?=
 =?utf-8?B?dFpXK3FXUlZCV05TanFpT05JV1VXU0cycnRES2xGY3RqODZaQ3BJV2dFL0tY?=
 =?utf-8?B?QmdVc1A3bDdzQjJXRlc0NDBUbUYvZ0xEdC82YmZpYzdxVFVDVG9RNTRVMW05?=
 =?utf-8?B?dVRiUTYxMDh3cjEwbVIySzJaR3hmWFMzTTAwc1dJOW5lc2JWOGcvQ0U5bjNI?=
 =?utf-8?B?bXRwUENNNUtnSldTdkwrc3N3WW40ZjFlNVR4azZlNzlBckNBdlpBVHQwSXAz?=
 =?utf-8?B?R2pZUi9CN2E5cVdsRnBrTXJSMVcrVU41amt3dHoyY2owMEtWdVR0U200L3Bm?=
 =?utf-8?B?Q2hHc3d2TTdlbVEvWG5EaVFoaDB4R3QxbG9HOVpRdW5VcHJyOXJqNUdVQ3ln?=
 =?utf-8?B?RjRjUHlVQ003U0FBWXNQd2o4NDk5Tyt5Nk1oVm5ZTWowbEZXVm9LU005R1o2?=
 =?utf-8?B?L1RUZjlLazd6TkxZa1dGV0NTKyt5MGEvYzlUaWpoLzFMaWxLdlFzQUpNaGxx?=
 =?utf-8?B?SHlLemtreGZWcXJxdVNKZEYxUlhNUERjWEVPZ0JVbGhsVG5uNFJneFhhcE9o?=
 =?utf-8?B?ZWxTVld5QTZOVjdPdWp5YlFyV0wyR2xscEJQWnN0eWFZbklWOGlSc2Z3WExE?=
 =?utf-8?B?QzFsT1dRTE1ueWkvZGFVQmZqQXJRUUZlZytJek9aU3R3SWNtM0F4UDdnYjBm?=
 =?utf-8?B?a3VJaXVBclZiL0lKRGcrVnNjeTZJdlJxeHFSUHA2dEhFWU1lK3JKRC84Umox?=
 =?utf-8?B?T21lalpUcytDN0RUSHJkL01ZOFE3Q0F2ekU4RTlFLy9WNUJoMG10cDNMb016?=
 =?utf-8?B?aGJnYi9vdjNUVGd1RzlkdUl3enduSWthc2xSVmVjL1d3anVUOFV4RW5QU0pK?=
 =?utf-8?B?eE15aUJMUFpZcDZCU0lFTXpaYWFuYkxGeW51Z01vdk10R0NQNmc0TVZPQ3gy?=
 =?utf-8?B?d0JPdUdYNXhPSnhOR2k1cy8vTFlYM25ud210STRZcmVFeTg2Y1NIbms0dkhP?=
 =?utf-8?B?azk3TVZITkozM0Nkdnp0Y0tJNXFld3ZvUkUyTG1wTWk2bkFMbmprZWVrTFl2?=
 =?utf-8?B?c3YwNUdQSktaUFd1alZ6T1Y4T3NUZ1NGSUlxM2oyeTJ2ZnMwc3pVUGhYdisw?=
 =?utf-8?B?VCsyV0RjYnpqcURBYitnelpxS2dZdDhkM2tNNERpZGgvZGFKUlN5dy9SWS9F?=
 =?utf-8?B?dzlJQXZrSmhvcEplR2krZmR6TEkwcnl2OGFESXpXS1k5UDkxTTVwOXNkdElU?=
 =?utf-8?B?KzRNTHpHRzlxdjdJbmxZSlpFUkUrWmdiT1VHT0JJZUJHdnplOENhb1p6blAw?=
 =?utf-8?B?MzdzbUJ2cjd3VHdrUCsybjdlODBrTmdrVnRpbmdBdHA1cVFWdnlWSklqZHIr?=
 =?utf-8?B?ZDNuL0dWM1Jzd3FqVHNDVzdEK2tXZDkwWVBiTkhwdG1CUUwweE9RbjBaV1h0?=
 =?utf-8?B?RnNoKzdyMHNCdU1IRmgxbFZhWU1WMk1NUU95S0hldHREVURJd2FLd2hBMXFh?=
 =?utf-8?B?bGdaclp4NkdkTlgvcGJERHFEQVFGRGs5WXAxclUxT1k1cnI1SXZFeTlUNkpx?=
 =?utf-8?B?T3huSTRnTGtxRnJtVFJJUTNmV0JPUnY2N3hzWG9VZ0ErTjB0TWdNSERyWGdk?=
 =?utf-8?B?TTB5M0ZncXA4L3VNdzVBaTVQc1p0dVZHN2d2TXR6aVRWR2NvellsNEJiSFph?=
 =?utf-8?B?ZkpLd09TTG9kblkvOGhKMlVVekFsNFVkd09Ob0daRUJtbHl0U2pKMDRFM2ZT?=
 =?utf-8?B?UHNnQmpqamZwaDJUckJsVFAybWZoTWczMGpXVTN3N0pXUmN1cmlFZ3FOQ0Nz?=
 =?utf-8?B?SjVLeDJvMkRoaDZKdDkvQWtuUERISHZqK3VGTFk1ZkppRk1DVVVVTmtnY2Fa?=
 =?utf-8?B?Y3prMitqd2ZueHcxcjhvYUl2UTZmOXQ4YzUxOUxWZmNZSGxjVkpSTmtQcDJl?=
 =?utf-8?B?QnhRV1JiUmR2d1ArZGgyeDkvSk15aFVjY1ZXZUlkVWVUS2czVDZ6SDJNbWdH?=
 =?utf-8?B?SWVZMzArSG9LREZwQ2hHUE5OZkR2U2NQTXpKNkNSRVVQSTBaMHBPNUo0Znl5?=
 =?utf-8?B?QzdWN3Q0N1pYZHNlKzhtWkc4ODJTUTVPNEF6eWhCU0xZWFVOYTNBWXRvY2Ry?=
 =?utf-8?B?ZzdBMXFKbkFYZ0ZjczVySWxyQnJxM20wcm9Ia3hDS1BOZ2VZLy8xT3VVcFRq?=
 =?utf-8?B?UVR3U0dyRDdJcjdKSEhnZWtYMi9mVDQ0akRybTNRT1lxUjVtbXMxaDZTb2xW?=
 =?utf-8?B?YjUwa2lLWlJVcC9wa1pFTlZzTGY2R0YrbytYMnFrNFd4eWsvcUpWYWdwUlFX?=
 =?utf-8?Q?L2HpQN3ZhbU+v04Qu33n5SXvRGueo096z8PEt?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d37be00-3c5b-40a9-b4d3-08de6b1d48ca
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 16:31:05.3965 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FxAqsR/pU3QKMyIXSAhjVbPv80/urrSPmvS/WdAyzfDkkJcjNGyVmpkHvLZKDqfdNLylYbhvcY72VfdQFnYlIzs5kNrhnbOzyYhFpnud5pY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB12247
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

Hi Heiko,

On 1/14/26 9:28 AM, Heiko Stuebner wrote:
> The RK3568-based NAS systems share a common basic structure and mainly
> only differ in the number of available hard-drive slots.
> 
> They also contain EEPROMs on their mainboard and backplane, that contain
> identifying information and therefore make it possible to determine the
> model at runtime.
> 
> There are 3 different formats for identifiers found on TSx33 models in
> the wild, which can only be distinguised by the position of dashes ("-")

s/distinguised/distinguished/

> in them, so the code determines which format it is, and uses a dedicated
> decoder function to get the relevant information.
> 
> Add that EEPROM reading and model association, to set the correct
> devicetree filename for the OS that gets booted. This allows to just
> set fdtdir in extlinux and have u-boot then load the correct devicetree.
> 
> For u-boot itself, all models are similar enough up to the emmc that
> in theory we wouldn't necessarily need to diversify here, especially as
> reading the eeproms gets tricky at the stage where embedded_dtb_select
> would run. But especially the still to introduce TS133 does have a
> quite different USB setup, so definitly will need its own DTB.

s/definitly/definitely/

> 
> So for now, we'll still need separate configs per model, but can share
> the board-code. I do hope to consolidate this further in the future.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>   board/qnap/ts433_rk3568/Makefile    |   7 +
>   board/qnap/ts433_rk3568/board.c     | 386 ++++++++++++++++++++++++++++
>   configs/qnap-ts433-rk3568_defconfig |   2 +
>   3 files changed, 395 insertions(+)
>   create mode 100644 board/qnap/ts433_rk3568/Makefile
>   create mode 100644 board/qnap/ts433_rk3568/board.c
> 
> diff --git a/board/qnap/ts433_rk3568/Makefile b/board/qnap/ts433_rk3568/Makefile
> new file mode 100644
> index 00000000000..d87f916d00b
> --- /dev/null
> +++ b/board/qnap/ts433_rk3568/Makefile
> @@ -0,0 +1,7 @@
> +#
> +# (C) Copyright 2026 Heiko Stuebner <heiko@sntech.de>
> +#
> +# SPDX-License-Identifier:     GPL-2.0+
> +#
> +
> +obj-y	+= board.o

Only build for non-SPL...

"""
ifneq ($(CONFIG_XPL_BUILD),y)
obj-y	+= board.o
endif
"""

> diff --git a/board/qnap/ts433_rk3568/board.c b/board/qnap/ts433_rk3568/board.c
> new file mode 100644
> index 00000000000..006add6fb30
> --- /dev/null
> +++ b/board/qnap/ts433_rk3568/board.c
> @@ -0,0 +1,386 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * (C) Copyright 2026 Heiko Stuebner <heiko@sntech.de>
> + */
> +
> +#include <dm.h>
> +#include <env.h>
> +#include <i2c_eeprom.h>
> +#include <init.h>
> +#include <net.h>
> +#include <netdev.h>
> +#include <vsprintf.h>
> +
> +#ifndef CONFIG_XPL_BUILD
> +

... to avoid this big ifdef.

> +DECLARE_GLOBAL_DATA_PTR;
> +
> +#define DTB_DIR			"rockchip/"
> +
> +struct tsx33_model {

Please document members (bp meaning wasn't so obvious, had to read a bit 
more to get that this was meant as backplane).

> +	const char *mb;
> +	const u8 mb_pcb;
> +	const char *bp;
> +	const u8 bp_pcb;
> +	const char *name;
> +	const char *fdtfile;
> +};
> +
> +/*
> + * gd->board_type is unsigned long, so start at 1 for actual found types

Don't understand why that justifies starting at 1?

> + * The numeric PCB ids should be matched against the highest available
> + * one for best feature matching. For example Q0AI0_13 gained per-disk
> + * gpios for presence detection and power-control. Similar changes
> + * for the other boards.
> + * So the list should be sorted higest to lowest pcb-id.

s/higest/highest/

> + */
> +enum tsx33_device_id {
> +	UNKNOWN_TSX33 = 0,
> +	Q0AI0_13,
> +	Q0AI0_11,
> +	Q0AJ0_Q0AM0_12_11,
> +	Q0AJ0_Q0AM0_11_10,
> +	Q0B20_Q0AW0_12_10,
> +	Q0B20_Q0B30_12_10,
> +	Q0B20_Q0B30_10_10,
> +	QA0110_10,
> +	TSX33_MODELS,

Because you start at 1, this means this represents n+1 supported models.

> +};
> +
> +/*
> + * All TSx33 devices consist of a mainboard and possible backplane.
> + * Each board has a model identifier and a pcb code written to an eeprom
> + * on it. Later board revisions got per-harddrive presence detection
> + * and power-supply switches, so might need an overlay applied later on
> + * to support those.

Maybe make the last sentence a TODO: ?

> + */
> +static const struct tsx33_model tsx33_models[TSX33_MODELS] = {
> +	[UNKNOWN_TSX33] = {
> +		"UNKNOWN",
> +		0,
> +		NULL,
> +		0,
> +		"Unknown TSx33",
> +		NULL,
> +	},
> +	[Q0AI0_13] = {
> +		"Q0AI0",
> +		13,
> +		NULL,
> +		0,
> +		"TS133",
> +		NULL, /* not yet supported */
> +	},
> +	[Q0AI0_11] = {
> +		"Q0AI0",
> +		11,
> +		NULL,
> +		0,
> +		"TS133",
> +		NULL, /* not yet supported */
> +	},
> +	[Q0AJ0_Q0AM0_12_11] = {
> +		"Q0AJ0",
> +		12,
> +		"Q0AM0",
> +		11,
> +		"TS233",
> +		NULL, /* not yet supported */
> +	},
> +	[Q0AJ0_Q0AM0_11_10] = {
> +		"Q0AJ0",
> +		11,
> +		"Q0AM0",
> +		10,
> +		"TS233",
> +		NULL, /* not yet supported */
> +	},
> +	[Q0B20_Q0AW0_12_10] = {
> +		"Q0B20",
> +		12,
> +		"Q0AW0",
> +		10,
> +		"TS216G",
> +		NULL, /* not yet supported */
> +	},
> +	[Q0B20_Q0B30_12_10] = {
> +		"Q0B20",
> +		12,
> +		"Q0B30",
> +		10,
> +		"TS433",
> +		DTB_DIR "rk3568-qnap-ts433.dtb",
> +	},
> +	[Q0B20_Q0B30_10_10] = {
> +		"Q0B20",
> +		10,
> +		"Q0B30",
> +		10,
> +		"TS433",
> +		DTB_DIR "rk3568-qnap-ts433.dtb",
> +	},
> +	[QA0110_10] = {
> +		/*
> +		 * The board ident in the original firmware is longer here.
> +		 * Likely the field order is different in the ident string.
> +		 * So this needs an EEPROM dump to figure out.
> +		 */
> +		"QA0110",
> +		11,
> +		NULL,
> +		0,
> +		"TS433eU",
> +		NULL, /* not yet supported */
> +	},
> +};
> +
> +enum tsx33_product_id_format {
> +	LEN_22 = 0,
> +	LEN_21,
> +	LEN_12, /* has the least amound of dashes in the string, so last */

s/amound/amount/

> +	TSX33_PRODUCT_FORMATS,
> +};
> +
> +/*
> + * We (only) identify the serial format via the different position of dashes.
> + * Because we read the product string from an eeprom there is no

there is no?

> + */
> +struct tsx33_product_format {
> +	int *dashes;
> +	int num_dashes;
> +	int (*decoder)(char *product, char *board, int *pcb);
> +};
> +
> +/*
> + * The longest board-name length known.
> + * Buffers using this need to be MAX-LEN + 1 for the final 0-termination.

s/MAX-LEN/MAX_BOARD_LEN/

But also, why? It seems the other _LEN variables do take this into 
account and you have - 1 wherever applicable, some consistency would be 
nice?

> + */
> +#define PRODUCT_MAX_BOARD_LEN		6
> +
> +#define LEN22_PRODUCT_BOARD_OFF		6
> +#define LEN22_PRODUCT_BOARD_OFF2	12
> +#define LEN22_PRODUCT_BOARD_LEN		6
> +#define LEN22_PRODUCT_PCB_OFF		16
> +#define LEN22_PRODUCT_PCB_LEN		2
> +#define LEN22_PRODUCT_BOM_OFF		14
> +#define LEN22_PRODUCT_BOM_LEN		1
> +
> +static int tsx33_decode_len22(char *product, char *board, int *pcb)
> +{

Please document this.

"We get this as input, we return this as output" such that we know 
what's supposed to happen without deciphering the implementation?

Ditto for other decode functions.

> +	strncpy(board, product + LEN22_PRODUCT_BOARD_OFF,
> +		LEN22_PRODUCT_BOARD_LEN - 1);
> +	board[LEN22_PRODUCT_BOARD_LEN - 1] = product[LEN22_PRODUCT_BOARD_OFF2];
> +
> +	/* add an artificial end to the PCB part for strtol */
> +	product[LEN22_PRODUCT_PCB_OFF + LEN22_PRODUCT_PCB_LEN] = '\0';
> +	*pcb = (int)simple_strtol(product + LEN22_PRODUCT_PCB_OFF, NULL, 0);
> +

Are you sure you want to auto-detect the base? If the string starts with 
0 it'll be understood as octal. I think you want 10 as base?

> +	return 0;
> +}
> +
> +#define LEN21_PRODUCT_BOARD_OFF		6
> +#define LEN21_PRODUCT_BOARD_OFF2	11
> +#define LEN21_PRODUCT_BOARD_LEN		5
> +#define LEN21_PRODUCT_PCB_OFF		15
> +#define LEN21_PRODUCT_PCB_LEN		2
> +#define LEN21_PRODUCT_BOM_OFF		13
> +#define LEN21_PRODUCT_BOM_LEN		1
> +
> +static int tsx33_decode_len21(char *product, char *board, int *pcb)
> +{
> +	strncpy(board, product + LEN21_PRODUCT_BOARD_OFF,
> +		LEN21_PRODUCT_BOARD_LEN - 1);
> +	board[LEN21_PRODUCT_BOARD_LEN - 1] = product[LEN21_PRODUCT_BOARD_OFF2];
> +
> +	/* add an artificial end to the PCB part for strtol */
> +	product[LEN21_PRODUCT_PCB_OFF + LEN21_PRODUCT_PCB_LEN] = '\0';
> +	*pcb = (int)simple_strtol(product + LEN21_PRODUCT_PCB_OFF, NULL, 0);
> +
> +	return 0;
> +}
> +
> +#define LEN12_PRODUCT_BOARD_OFF	4
> +#define LEN12_PRODUCT_BOARD_LEN	5
> +#define LEN12_PRODUCT_PCB_OFF	9
> +#define LEN12_PRODUCT_PCB_LEN	2
> +#define LEN12_PRODUCT_BOM_OFF	11
> +#define LEN12_PRODUCT_BOM_LEN	1
> +
> +static int tsx33_decode_len12(char *product, char *board, int *pcb)
> +{
> +	strncpy(board, product + LEN12_PRODUCT_BOARD_OFF,
> +		LEN12_PRODUCT_BOARD_LEN);
> +
> +	/* add an artificial end to the PCB part for strtol */
> +	product[LEN12_PRODUCT_PCB_OFF + LEN12_PRODUCT_PCB_LEN] = '\0';
> +	*pcb = (int)simple_strtol(product + LEN12_PRODUCT_PCB_OFF, NULL, 0);
> +
> +	return 0;
> +}

The logic seem to be awfully similar, would it make sense to have a 
single function with offsets passed as parameters?

> +
> +const struct tsx33_product_format product_formats[TSX33_PRODUCT_FORMATS] = {

Can be static I assume?

> +	[LEN_22] = {
> +		(int[]){ 2, 11, 15 },
> +		3,

If you'd declared an array, you could simply use ARRAY_SIZE(array) and 
never have to worry about them being unsynced.

> +		tsx33_decode_len22,
> +	},
> +	[LEN_21] = {
> +		(int[]){ 2, 10, 14 },
> +		3,
> +		tsx33_decode_len21,
> +	},
> +	[LEN_12] = {
> +		(int[]){ 2 },
> +		1,
> +		tsx33_decode_len12,
> +	},
> +};
> +
> +static int tsx33_decode_product(char *product, char *board, int *pcb)
> +{
> +	const struct tsx33_product_format *format;
> +	int i, j;
> +
> +	/* Find the correct serial variant */
> +	for (i = 0; i < TSX33_PRODUCT_FORMATS; i++) {

ARRAY_SIZE(product_formats)?

> +		format = &product_formats[i];
> +
> +		for (j = 0; j < format->num_dashes; j++) {
> +			int dash_char = format->dashes[j];
> +
> +			if (product[dash_char] != '-')
> +				goto next_format;
> +		}

You can use strstr() instead of looping on all characters manually.

Cheers,
Quentin
