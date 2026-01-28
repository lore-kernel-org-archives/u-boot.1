Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31C2FD35690
	for <u-boot@archiver.kernel.org>; Wed, 28 Jan 2026 09:01:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6970583BC7;
	Wed, 28 Jan 2026 10:01:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="OKyHByQO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EABA583C72; Wed, 28 Jan 2026 10:01:44 +0100 (CET)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c007::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83D8683B30
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 10:01:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tanmay.kathpalia@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FExHzi59rhwnecCI6kNh1hFkXyJr3jCHdm58LOqDO43cR1hgWPPahb6687cPK8zH8DE0t0mzPTkiboK1xfp91FmgtIozKs03smluvyL8xaVeCCQWKMql88IgqyMTdmVO87pU4f/7qbbE84c0Qnxz4jrsphRglI60XfOeZJDJ3cXksHoLldwP3IMkMPU9gfuyq6uGrE9knfvYkOUS5myj/cCGvDIA5qOSaRjsUm3dE+HMxKG2XMpajLoYo3nSTthnTe0jbRml9eDx4jbqIQCzEwazFiaXWrBY+63ywsHBYlVTEBQ87eJLn8sQvIMvwH5GVfPqIUuh5x3xr1Z2p7cqqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oEbSN//aEf54lRLp2MNo7QITiRAYUIymNJ0TLlEX4oI=;
 b=bYofJMwiYTChKxOuRzD6o/hRk/AaULnPvOKTAMgziBztgG5mSOKAgs5kb0VWqfakVxVHguWtiHT6ZkxODbz/gYCqDJc/sKZ4i05NTuuNXEnSfiblzYM/82oMiS6UujkaAA6hiAczM/9NXeGizcSSE7yN/XNZKXA7UR1xjOVK8iryT4jtrUqstA7XHGj5ewkYbQBi9eITmOaJsNERKDgMzT9ZyIPHe0oDWGwOlZCyPbhaKvNawd97kP3GGXdgiJL7kCcQjQWxpEtzQm8ZS2aVie+InZjMSz+L4i6edNcvw7XcgDOiLrIz0DyLx1SH57qa1/6Opa2nCX+SHfJ1Od+Vug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oEbSN//aEf54lRLp2MNo7QITiRAYUIymNJ0TLlEX4oI=;
 b=OKyHByQODmp9o4eAp3jrob3ktfsE+JU793JwYuawQy4YnyJ9zBBZ2GeLyWqTpaqkQWcIp6a7arBthYgsoNXB8NKTI23VuOdLj2P16wy1l+qDw/1r0U5LxER+hcgbr1HoxJT1EeSM+LBHebsXMh7vuqjBoyh9l1p9o+/pVtffNltcZPxUNuSR+Wbe8b0q8C7DOXFaPlrRv04ugKiBEwl8a5mSiUQu0MiM5vHw6+ak5XkqP2u1DMTvncX+ZKnGd9AFnbqlNKbCNdTzx23FfXPZInXCfwOQPDWbYsJV9KcUxKnW61nlhHCwb7CnrHi93F0Z0z1s4YM2eI/fxh5zwG5zQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by MW5PR03MB6984.namprd03.prod.outlook.com (2603:10b6:303:1cb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.8; Wed, 28 Jan
 2026 09:01:38 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::6735:e440:e9a1:e844]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::6735:e440:e9a1:e844%5]) with mapi id 15.20.9564.006; Wed, 28 Jan 2026
 09:01:38 +0000
Message-ID: <4f8fe7fb-8dd5-4f84-a25f-15b8aa70a9cb@altera.com>
Date: Wed, 28 Jan 2026 14:31:27 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] arm: dts: agilex5: Fix DT property naming
 convention
To: "Chee, Tien Fong" <tienfong.chee@altera.com>, u-boot@lists.denx.de
Cc: peng.fan@nxp.com, jh80.chung@samsung.com, trini@konsulko.com,
 marex@denx.de, tien.fong.chee@altera.com
References: <20260125202329.12738-1-tanmay.kathpalia@altera.com>
 <20260125202329.12738-2-tanmay.kathpalia@altera.com>
 <4777ebdf-ebca-425d-ba09-e058871ab01d@altera.com>
Content-Language: en-US
From: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
In-Reply-To: <4777ebdf-ebca-425d-ba09-e058871ab01d@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0212.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b0::11) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|MW5PR03MB6984:EE_
X-MS-Office365-Filtering-Correlation-Id: f0e726b3-d8bb-46ba-c946-08de5e4bd889
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|376014|366016|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R0JJSTJpV3ArRUl1V3NEWG45QmErdUtZa0xYek11WVhvU1BVUUdRZ1FKMUt0?=
 =?utf-8?B?OFk3b2VFTnJZem9IQ1JITXQvWnFxdFFjbmN1REptKzV4WVB4ODBmV3ExNklG?=
 =?utf-8?B?ajNmMzBVVGs3a0sxQW5jRUw1NWlST0ZIMi9IQkNSRDZpWGw1U0ZnTXpUSy95?=
 =?utf-8?B?YVhYR1Z3dm5yUnRNY2Y0eHp4WWdjdVc5a2ltQlA3OTZKeE5RbzBkRlhzbzFU?=
 =?utf-8?B?TDVyZ1NnRURscG44aVljRnF2YzV5UGhVQmV6K2RYZG9mN0luWC8zSTJLWVFW?=
 =?utf-8?B?djBTVEljSWM2SnplVTd2VmZkc01yejhtZGJxY2lGS21uVUUvYkZSMDhDWTBx?=
 =?utf-8?B?aEczajVKVEJVM2VKcGJaYU41bEs4a0tJTXpuUGJzeHRsamc4dnBsemJ6MVR4?=
 =?utf-8?B?c0dVN05wWnRsdFZGZ1M2UTF2emVSVGhUeXRBUUNkbGRkS01DVXVwN1FLVmw0?=
 =?utf-8?B?Z3Q3NGRYWDRBNkNMak9sKzBNbmsxSi9UZkZIVmllaU5NcU1wQThSWW5BQ2xV?=
 =?utf-8?B?cVlLeExBU04zRkF6dDR5T1FGTzRSV2xRazB3QjNSdEpCVDYxcFlvVGFQTWlE?=
 =?utf-8?B?ZFVocUZNNzhYYTgxUHQ1eEdoTEJQZmtrR0JFWEtQTUZWZExJSkxhTDE3RG1E?=
 =?utf-8?B?OXJ3WEdtMFpSMHpDTmNZZytSUXl5R05iTkVsR2dLb3oxYWRwaDFZc0VoVnRZ?=
 =?utf-8?B?VktKdEYrOEhrMVJzbWxKUGJmMnZQbzczT3R1MUVCUHQ4TE9UdEdhekgrUFQ2?=
 =?utf-8?B?RTJuRStydGJRN1lWbGwxL2JlTDFkTHpEbHlZV1BoQkViTHlDUzRReE1VZFVF?=
 =?utf-8?B?Wk0yMEtaRWRRNFFndEw3ZlJsNWIzTkx5c0tpNlpwQk55dFpoSmhpSnJKZEp5?=
 =?utf-8?B?a1ViMkp1VHdTL1lLTjBYOUR5WjNkMGNYdFBVUWEzelEwYVpJcDFRTjRHZFZv?=
 =?utf-8?B?TXRzVi9zVWh3cnNWaEFETWZNVC9xa0dqUVBzS3Jra2tZc2VaSHd4NnFVcEFD?=
 =?utf-8?B?d29ueEgvVUVHYjJtMDJrczhxcEtLb2tnL2ZBbnArWVNKSWFMeWVDdnlUTVdS?=
 =?utf-8?B?QjdPN3RXYnJ5dW9saHpCT2t2RlhsZG5hNnZDTWQ0SkFZS25IcFVKZmg5QmU1?=
 =?utf-8?B?SUYwaW1ZQ0Joamc5dHpvVUdlODl6ejdic2VmUWVwdmZuSnFIZmR1aEV3RXd3?=
 =?utf-8?B?N0wzbDNaUGdpSEVCOW9iMzRLQ25EaFJlQVRLYzJ4ZGNDQmREdG9la2s4SzhS?=
 =?utf-8?B?M1FZL3VMaGp4OXMxWGVLVWNDMmw2TU0wTzFzTDNKOU5hN2JIczMrRHRnSjVR?=
 =?utf-8?B?cDFpdnY2aXNXemkwUjZKNzd0djRIb2xCQnFvQW5KZG9MQTBmVWp5aW5kV1JO?=
 =?utf-8?B?dXAzNGQ3SmRZRmpaZ1JpZmd6eU50SmxBV2pJMVQvZCtDTDYwNmxBditlVDdQ?=
 =?utf-8?B?c3JadXY3cGJ6ZmVqUGFqdzcwWkNlT2IwY2VnSmZKOVdabkxiNkcyN0QvUEN0?=
 =?utf-8?B?KzRtRFNWUUw5dFc0Vk9pSXFIN3ZmMytQZnBKTlZKcGJnaGppY2VtNUt0ejU2?=
 =?utf-8?B?M2Z6VlpuKzZOQTBRMXl6bTZvcGs3c1RlSUpYemdvWHZqN3VqOFdja3pGTThL?=
 =?utf-8?B?RGV0TVJRa0JrNHRJNTJsa05ZN0VRd1ZBL0hlMFBiSXhnTkhUU0ZPZnRZOTR3?=
 =?utf-8?B?UnZPNmJSUUZMY2hYYi8zYkJPaFc1WWNnVjk1c3V4WDhPRU9SZGtONklGZXlB?=
 =?utf-8?B?R001d3lKMFpFd3BmWndHQS9jYThtNmZjd1VtTkRPL1hrNk9nV2tyVnp4Sk5S?=
 =?utf-8?B?Uzk0YlJoc0lWQkx4R1hURDFsMmJkcEdudFdISHpMUUpWUTRjUlp3eDYyWEhH?=
 =?utf-8?B?ajhweDdQTlhTWU13SktKeml3dUJiOGVkSGJWamRaQTdpZ01OKzNUNzI4YlVv?=
 =?utf-8?B?TitWNWpYOHJ5d1hCR2NBT1g2elVCYzFCOWVkOWhSdVZaZXYwaGdhTlBDQUhU?=
 =?utf-8?B?MUo1STc3RTFZWVNtRnllTzVNKzRsUG9ZMlB6NVlqQkxaUDhKZUFyWVlrRFd6?=
 =?utf-8?Q?sUli7w?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR03MB6208.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(13003099007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MkM5UDRyaDVMbC8rSEZybEQ4c2cxVS9iNjFYb3JBSzBMNlRVRm1UeithTVVV?=
 =?utf-8?B?bXFBSnpCang5SWF1MnJ1bC9kMW9NOVJjcHlBL2crclc3bXp2ajRpLzlBbWM3?=
 =?utf-8?B?MmJEWnRvQ01leDdld0NzTnZjU2k0VFdCMTRmRkpjRm5mbmxIWmJRMkRzQWVq?=
 =?utf-8?B?UU1DeVBzMitNMzYvaWpUSkVuMjdYTy9waEFmRmRPTHhWTGJRcUJobDJaMUox?=
 =?utf-8?B?NmhONXptQXBxUy8zVFhHdjJNM1NTOU1pejBGdWNiMEo5c1E1a2ZSU0s1Q2V4?=
 =?utf-8?B?NDBBRzUxT2ZEOU01M0cyZm1FcGtwT0NGaGVmanZUSHBKRXUvcVc3MSsxd0ZL?=
 =?utf-8?B?RDEvWFdabWtwWHJLSlhhM2o3eFpUL1l6c1E1NTQ0SWw1S2F3NFNlZVdRRHVj?=
 =?utf-8?B?RldjOE9DQ0pRRWNwK2NxODZ0cUxaZDFQVWFaTE9PNEluYmZyMkpvb0JRUTFr?=
 =?utf-8?B?NVpWUXE0QWNxcUdkYXllVnNMSG92Y1JxQmhQaHpOWFkyZjUrMktoOTRaOFA2?=
 =?utf-8?B?TTZ5N2x1cC9vN2N6bFJOMTRObFZuekxmem43Tlo5VDFWSVE4d3JGZ1FQdEVE?=
 =?utf-8?B?cklYY1hUdkU1T0V0cnFNMkdNMUxTNS8vYkxrSllHQmttWTVrVVRoaGVGWWNI?=
 =?utf-8?B?T0E5UWJWeHpyb0xzSWpBVmw2NVR0clMzVzJ4b0VEdTU5WXpOZ2lsN2ZDclNV?=
 =?utf-8?B?N212MWtSUlE0Z09scThBcGxoR0k4MTVrR3BjRnpQTWlra0tLTUUxQmRaejB4?=
 =?utf-8?B?cFhSWmxmbk5KK3RBMENKbEx1NlpMVmhYZmNkMHdBN2JMcFhlMlpuTlZRbUFC?=
 =?utf-8?B?b2dBUWdGekpqYzNDZEU4dnZmRUpuYW0yVWt6azE0TGZob2NqTFNzc3A1QjFZ?=
 =?utf-8?B?NXdjS1pVaFNqMkZkbi9Dc09WMElqejRsbHJSQXREdEg5bjFQaWkzemp5UXR5?=
 =?utf-8?B?K3o2UGV6NHl2THFQMVRhdUJRUlM4WEVaeCtwUm14UjdEWDBLR3ZXOWlzRUNk?=
 =?utf-8?B?bVBjZVR3a0lhNktodTBmSkVuNkNiT0EyYllWSzRNS0dna2QrYmR6Y1NDQkVN?=
 =?utf-8?B?RGRmQk85clVpQjlrSVlXbExGZDdMaEE3MWs4TzhTRHlzUmJ4ZlBXZCtqSE92?=
 =?utf-8?B?aUFhTjdZUjFrY0ZUUmlMS0FuWlpSU3grUkxPaHJDaW5aU1VURy82bWxsS29T?=
 =?utf-8?B?NVpsK0JZV28xSDlvUkRsNlkyM0IrMXhtMWRUcG5kMFEvMnFFdm9SZUZEVGwz?=
 =?utf-8?B?d2lzQWg4ajZiRk9mMlF6SXhGVnR1NlZSaFFsNVQrN0JJMUZ0ZkN4R1ZCVmhq?=
 =?utf-8?B?VUFwMHk5M2FNNk9GZUdWVXV5bk1ocXB0SXJqYys4RXJlOG1BQ1JMRDNHMzgy?=
 =?utf-8?B?aWtwUGhqdVVlWlBrNEFhOW9EU04yYW5BaHJKOEFEYnZTSlJ2LzRMQVFLSlRw?=
 =?utf-8?B?K0tsMG52cUVxWjkrZ3JlZnpBMTVncDhRdnVmWDErd21DczZFbUQrSE40ZlJU?=
 =?utf-8?B?SFdMMkVaUGpuZFhvM2piMlpsR0FSMzg4eUNvbDk0TmJCWHRHRGZrdDgzRmFX?=
 =?utf-8?B?VmI0bjBaK29sdFJnenIxbFhhNUpVTzRGM1V4VFQ4Vkt6QlNtaU1QdEJmSXVV?=
 =?utf-8?B?SVBVbnUrZ1lzQm5Id2N2bk5EclV6Wit2RUZFWWZLZGhMZE11SmZOQWpsbDNk?=
 =?utf-8?B?N3V0Y0dTd1VVanc3eGRsaWk4WU5lYzZNSnVOMHl2RXZGSUh4eVlTenhhUFJQ?=
 =?utf-8?B?SndCeXlIaVdBR2RnTVZIRTFuak96M01GcStFeVlUckxRZXV5UnBnZW82ODg3?=
 =?utf-8?B?QnpMTUUwZG5zaUlVcUFXTVBCL0dtY29TT29NcktDaGorMC9vWjR1a1lMN2R3?=
 =?utf-8?B?ek9JaFZ2ME5oNDJFaEJJZHJOWWI0RmlnQnZaMHdkU1dQS0l1anJJcjcybUl4?=
 =?utf-8?B?blVBQ05FZGlLYng5MVdrR2g2NFhpVnowdldkeUNnTmVDTkpjMGxuWkYxSkNT?=
 =?utf-8?B?aTNvQ0szSGsyc3M2Z2JidEpYL1RvbUplWTUxdUloTVVPRU80NktOZUp5WWhZ?=
 =?utf-8?B?WG9BZEpEaDFWcThMMUh2aWxNZ1RwR3hLaVJzU1pEWE5VNEswOTdMeXBCN1Ny?=
 =?utf-8?B?MzBIZXVIWUxSS3ZvaTNjTTA3NGFDeUxmdmsyKzY1S2JOenZiLzRUdllLbkd5?=
 =?utf-8?B?NFVOK3d5bVFZc2NwRWlRSzJGZnVlV3JBRi9YdndkWjFOM1lZQjM3VjlVWitW?=
 =?utf-8?B?bXRNcldMY3hrYWJFMU5NeUpWMkp4cE5RSzNqLzJyMFR3bGpqNnpMNXZ3R3c0?=
 =?utf-8?B?LzU0SmFad0dWZEhlaWMyZ05sZ3pFS0JNTXdnbnh4V3hEZmhidkJiVzBNSHBp?=
 =?utf-8?Q?drzaEa8P4Bnh/5QE=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0e726b3-d8bb-46ba-c946-08de5e4bd889
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 09:01:38.6443 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xs1kiixQ7KpLgr8C6yA1PcSZIFkzowEFIHIH/NiQYFFL1IpFRWwCrUohdAIyhD1jFq7TCdp73m92I4FJyCqmkEQZ3IxJe3Tx0726MqB3svg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR03MB6984
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

Hi Tien Fong,

On 1/28/2026 2:01 PM, Chee, Tien Fong wrote:
> Hi Tanmay,
> 
> On 26/1/2026 4:23 am, Tanmay Kathpalia wrote:
>> Replace underscores with hyphens in the PHY timing configuration
>> property names to follow standard devicetree naming conventions:
>> - phy-gate-lpbk_ctrl-delay-sd-ds -> phy-gate-lpbk-ctrl-delay-sd-ds
>> - phy-gate-lpbk_ctrl-delay-sd-hs -> phy-gate-lpbk-ctrl-delay-sd-hs
>>
>> Signed-off-by: Tanmay Kathpalia<tanmay.kathpalia@altera.com>
>> ---
>>   arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi b/arch/ 
>> arm/dts/socfpga_agilex5_socdk-u-boot.dtsi
>> index 5a7aa5841e3..417575fa0f0 100644
>> --- a/arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi
>> +++ b/arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi
>> @@ -3,7 +3,7 @@
>>    * U-Boot additions
>>    *
>>    * Copyright (C) 2024 Intel Corporation <www.intel.com>
>> - * Copyright (C) 2025 Altera Corporation <www.altera.com>
>> + * Copyright (C) 2025-2026 Altera Corporation <www.altera.com>
> 
> 
> Please don’t change copyright notices when making minor code changes.
> 
> Copyright statements reflect authorship and do not need to be updated 
> year-to-year or for small modifications.
> 
> Even if the file still reads “Copyright (c) 2025 …”, it remains valid 
> and does not require adjustment for this patch.
> 

Thank you for your feedback, I will incorporate them and share the V2.

Regards,
Tanmay
