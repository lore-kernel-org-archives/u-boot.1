Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E507DC61DC4
	for <u-boot@archiver.kernel.org>; Thu, 27 Aug 2026 13:40:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9B569607A0;
	Thu, 27 Aug 2026 13:40:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RhEO9NxBF3E7; Thu, 27 Aug 2026 13:40:29 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787838028;
	bh=gB1Vo7EU4zvPI1giK0oqFzCWeHfZwu+6HDMstd3igYQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yhlmij0gz75NEAxm46FYST769zvbzoyXVVNMyGQI3+aXeBia4BwwgBEMecSfSTyfA
	 OH3QN1EFLYDxMBq8foWx+KreQFFpQPHeNUz7KvOsbt6jadkYomkfVKYN1zQzGHE4or
	 9HjXWUzxfCFqXbb1higVa5i9xOFkZN2rgmKbJ1EFK+xS8VCOZKEo5u0GMZCJSYa/s2
	 /1jaomECQBPImzwLPKd4L8Kg1/HpWbxC1nlh9AiMoiiH86dWRwL4fFxqnwUrUfG9v/
	 Kzkqieq8WcdK+Fs4/x0F8ExfMmszK8mMh8erOv+T0YRFOe2YJHSlp8jJ7p3mjfnHiN
	 eUy5xKZ26COtA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C9DD36078A;
	Thu, 27 Aug 2026 13:40:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 7542D3A4
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 13:40:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 66FFB4072E
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 13:40:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JlGVZcFnav4l for <u-boot@lists.u-boot-project.org>;
 Thu, 27 Aug 2026 13:40:26 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::1;
 helo=am0pr83cu005.outbound.protection.outlook.com;
 envelope-from=ludwig.nussel@siemens.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256
 header.s=selector2 header.b=AnQA3a1e
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 76A6640726
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 13:40:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UtrXJUnv5JFoIqBawkHE/GCeuGgrc9x23Y+zukf7orQ6+Nfff+GGsSRnN7PvQKR6q1v6Z6aNm3+usB0feqjCUcKba9q+6bVQ5OV/FRE9Nw2WMc2j27He3C/yTls2gqr+eY/3fBTULgHyjnVHU6Ca9raIvwOOMLXNfJSp+y9p26t531IB89LjcaabB5X0OXOf5wUR2lhtruo1kqLL+zyJBdNMb98CLgQfVxElOfHcMhX/xiy8TTSOIHYMRNGcdKZj8D8swjG23HauxfR+De3+FRF7RfXrOOM1/cobeuBqPxfdWcoezSy/0brAuuLALd6YPceBgJ+8CXKRHIDDkRXNuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gB1Vo7EU4zvPI1giK0oqFzCWeHfZwu+6HDMstd3igYQ=;
 b=Ff7WRLfmBk+WL+qWKte7suVfvoAJ15o9iKGqWzfKDOgvWbcKcAj4pYi18cSDVIoVssQ+gRp8iTFGyI7nVx/9u35vZLL+vVnOqzlHxEFVW2938C610P44sQaefK55O+B7rpkDpzkyrDnK2itK6ErqTc0+MHQwXEIpkFyYOSMiZ802CpAQDrRz0NPwhFZBOM2QbGJ5GP3MgH7KZL20v9vRFy8N5JHWTCH/5J43STsFhw/VjkKMEO6mHoUNp0XSdNxsTajPW8B463Bp6jjZsLvWGXuXflfh35Ij3F9OEy+duADtIUagjNhEWW+rUB5JmUWqNnIj6qcFauPHmmHg8RUa0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gB1Vo7EU4zvPI1giK0oqFzCWeHfZwu+6HDMstd3igYQ=;
 b=AnQA3a1ePbsUFo1gZs2X7sZtW9qPlpLz15JT5hJF1aplmukWxx2DPUXSukQD5Gm/MgOuDpGkqVOAJko2ioxI3Xp0Pwn4Awe4P5nWgjAUk1AipxIT9AnoSEtr7KyZrLbIVsWtrSP3zb2lWBF5tjzZeVSCNoa3r5fr//YJDUChZJ/1tvGj4yKhyU2mt3z9jiAhb/DTSfYAJPn78gafO4ZjVJzgscvHWlv9OwPhZvUAGogt7mfC6C5+zZmQu1kyQPcjMSGTCCRKNMh/6yQ8OUuvBQYUMMCdTXmID1GGbIZjGH0vMg1rmo2PW96Bbv+2CznAt8jGCpkn+XjGz2N5L1l6+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:2cc::12)
 by DU2PR10MB7696.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:49a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Thu, 27 Aug
 2026 13:40:19 +0000
Received: from DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::97ce:ff62:c0b8:4ed1]) by DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::97ce:ff62:c0b8:4ed1%6]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 13:40:19 +0000
Message-ID: <2e48dc18-6887-4b3b-a3aa-7373169c3130@siemens.com>
Date: Thu, 27 Aug 2026 15:40:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 4/8] image-fit-sig: Optionally require signatures
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Simon Glass <sjg@chromium.org>, Anshul Dalal <anshuld@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org
References: <20260813061009.26344-1-ludwig.nussel@siemens.com>
 <20260813080943.v8.4.6d1d5d14140677a76a7cd7bb99a9088d8c8f480c@changeid>
 <66a3267d-1980-4b86-be3a-791707373554@kwiboo.se>
 <0ddc21e0-7511-4f54-b32a-8a0163ccff79@siemens.com>
 <44dbc75b-13e6-4242-a1a9-43264f379391@kwiboo.se>
Content-Language: en-US
From: Ludwig Nussel <ludwig.nussel@siemens.com>
In-Reply-To: <44dbc75b-13e6-4242-a1a9-43264f379391@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0360.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f4::13) To DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:2cc::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB5019:EE_|DU2PR10MB7696:EE_
X-MS-Office365-Filtering-Correlation-Id: fb250836-d959-423b-6985-08df0440bc67
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|7416014|366016|6133799003|10067099003|4143699003|56012099006|11063799006|18002099003|55112099003|22082099003;
X-Microsoft-Antispam-Message-Info: dLGmGTJUDhZyi1zAHCJDS69nWpqyFXa/gDYZ3b20oZKujvqYTC+lqzThLwBtP8Zg84npCSy3skonKFErrfXtZ9e4W5tK6NCD0n1ZhxMZFHtI57RHb05cnC2ve5X8GvM0E/3NBBCrjCTOs8XO9pdBHgXOLYqukIsqy9A2QGuLN3OEc/CLULCsCIOW19N72Z+uj713sOHjwtilRXZ1soxtD9OjedrIkTIOq1ImuTSV8yFeCeNdoBbDgWkpBPeQ0xZnzarqWb9nxz7PT+Eh8N7oIPFjLc68pJhnSUvTkJzYOHrbP30iPRY3IIgWQf1TB44WQemT8Mpr/mkTmaQ+8+p02hbKXfJ3dP0d3yBqc4z582fabQis9lSzQNvTtMS92VkTJYrftoOIeeL++41t7B24iBWBwWQlAvneWttlqmKZu12IWdiqPMf6zW7mIbySGVHYaY1vDm8ozqxh+NiBIT555sTAdnERwY9LWjmBE0ocQnY15Zkb8FE4F4ii3BEICoJ5vLu+OX5hatY/V4o6557HLVUzOqYRAQSM/an9torjdekIbDEEEDOVS8ONJRXV/EIgXXl9z+sL7TXu0cF6HLYWs+uUeR0aJxsaZ/Is91CQ8t4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(7416014)(366016)(6133799003)(10067099003)(4143699003)(56012099006)(11063799006)(18002099003)(55112099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2hrWjlXOFpBb3FwUXY0K1BDU1pGRzBZd2pZMkFFSFFwciszVXJFT2NBTlBO?=
 =?utf-8?B?dmJ6d0hQR0FCVjBsQmpmQmwwd1RQUkRibVJ0TG51dFBTR1dpRzllRU1rOVlv?=
 =?utf-8?B?RG1idkZoV2lMaklzUDdsQkEvdXZvbzlLZ21iMlUzckxMK2pZUXQ5TytnaFlE?=
 =?utf-8?B?UTFUYUxYekF3T0FrTHpJd0xiSkRLajl4cmpjWThCZHEramtFNnlHQjEwTU5a?=
 =?utf-8?B?UXpZQnZ2cEpkLzVabWpSaVhhNjBZeUlnMTJEYTNiVnhROXZadU4rTm5RL2ZG?=
 =?utf-8?B?NVBuaDhBMFZDcjE5MVJ1Sm5WVnEvQUNJakZHZDJBZ0Zoc2ZTVE1LeW9GZE9G?=
 =?utf-8?B?RnpaK1NkMTVTMGkvOThQTzhkSHh5bHRqM2kyM2JVZmNNMk00SDZIb0oyNzJ5?=
 =?utf-8?B?UWxibk9nRThud1lWRzhheWd6dm9nNVE2d09JWFVDK050SERwb214SnlsVkxC?=
 =?utf-8?B?RmcrWVZFbForODZ1M292SnV0b1FzbGxrd0EzeE5hd2ZESzdIUXB0RzVHVHdn?=
 =?utf-8?B?d2ExQ1hEK2FXVDJoZldjT0wvd3ZDdk5rZmt6ZGE4SjQxQWZqUmxncnBCSXlz?=
 =?utf-8?B?TDZXWGMrZnF5NlRrTzBwRWhYbWVpdThnc0VacXRlaE5YckRodlQ5NHlkTmxK?=
 =?utf-8?B?WHA2dEhKL2pPbElOdndQT2s5RSs0SlUwR2F5bWhvK29aemRGL1AyNkoybWhY?=
 =?utf-8?B?YysrZ0FGYkluQTNnUFNVdTlPSWF4T0tVR1VBRXl2cG9xK3FyQzFYVWx2RWk2?=
 =?utf-8?B?SHBFcnd3WHJseFpibnJMMi9YOHpJR1RaaHAzT3BGRXJNVFJUazJVKytNTGFu?=
 =?utf-8?B?bmtLWCtObWt2cFdYekNOL0l6TEF5Wi9RMXRFenVzdjNKWWh3aEN3bW5Va21B?=
 =?utf-8?B?RjRacUtYZVovVXVxd2pTVFZvVTRkbnVBRDhDRnQvby9LcmVDYjdZZFU5Y0d1?=
 =?utf-8?B?MjBxN1l5Vk5VVyt4NXBGNnlIUk9ySE9EVTN1OXU5UUtDbGk2QjhleE54am5R?=
 =?utf-8?B?clRyMldXWldrSGw1OGtOY0JRVks5VGRZS09LNUhuNkpBRmRmenhqRmlpMk8z?=
 =?utf-8?B?bWlRdUNYY3BSbytjNTZpL3QwdEJCUVV3cDJvNzk3d29SbmZjblpwUDR3SUlP?=
 =?utf-8?B?dDU0SnRRakRlcHduNGpaaWI1VCtDZEloeXRhaFpvR05FODN2bzdVZnYrU255?=
 =?utf-8?B?Z3ovT3JLaXJsZnRCeWVpWU0yY0g2cG8zV3Q5MW5OTzkwOXVCRjlJTXlLZXli?=
 =?utf-8?B?VS9nK3Z3NWVJNzlnVkdGbHI3cXlQODJ1S1k4eEtwRjZPVlgrUXFnV1R3NzZ1?=
 =?utf-8?B?dVJGVzBNM3ByRTNVRlpLU0hUNE02dGRyZkQyQWR5RjFjTjg5dHlTUlhDalFI?=
 =?utf-8?B?anl3Q0NSNzJUb0Vldk9jTExiUDhYWk9FT0I4Und1UEh5NlF3SGVrQzExd1Qy?=
 =?utf-8?B?eHRZQ3FwUzRXQWpTRXVoeFk0dzdWUmk2MkRSa0ZGTHZxejVhaDJ6aE9XK3Fp?=
 =?utf-8?B?MFIrS3lETEtOYVJoQ3hQdkM4ZXMxZGZMeFJ3RStXSVlVNVRSSWE4VTQrSGQr?=
 =?utf-8?B?TjdxSjFKSUJUajAwd0cxNmJVYXpvbGhFaWFjbjVHUmxzSzRianBQZEpNQ2k5?=
 =?utf-8?B?aFRrM2huVVoyM3NmSEZJN0dLQ0UyTE9OOTI0Slplc0tTc2F6d3MzWUVWSjE5?=
 =?utf-8?B?TkNHTCtDLzNKTVdwbGVFNExlVFpMemRQT2pWMHc0MlRLOXlYM3h1RUtacWpQ?=
 =?utf-8?B?akRZbE91bkdVUmhHYWtkNFZ0dWhyenBxS05aWjNRT0tERldZUjZjemx6TElK?=
 =?utf-8?B?T0xBUHJsWDFtOFlnc2VKOHF3R1lueFYycGsrSytUYkpSNWhvbUN4cGRLWFRQ?=
 =?utf-8?B?YldyaDJRdWptWlNmMXZ4UHBWNjJYaUpBQkxwRDNRL0l1UFlHMS9vRk1nYm1J?=
 =?utf-8?B?WmZHVXlTcFp4KzkyWkdKWFgwUit4bmxwblNWQk1EZUk4aFVpajdtU2dkVStR?=
 =?utf-8?B?Q055Z0xQUjJXc0J3Y3NRa1c2TGVrLzRxTmEwTW8rSTAxdTJ3M2V5RHNBNU5m?=
 =?utf-8?B?M01zTGdGLzNudS9ZV2RaWEJESVdQWVhwaENXN3RyK1BZei9ObGRSSFkrTmxu?=
 =?utf-8?B?Q2hHbHZrUkw1NENpbXVVbFR2V05QelZLQU0rbFNTRGNRSDY0WHRWQzhsM3pr?=
 =?utf-8?B?cmxiQTBMalE0bUdhcVh1Yk5OWHd1TEZIV1duMWd6N3h3U0lFekxxVnpnY0xu?=
 =?utf-8?B?Um1RMnVBZXlLbTdHRFRPUklwamRleDBzVFl1Q2hHczJyZVVOclJUREN0dGFa?=
 =?utf-8?B?b1UxT3NjUDZ2R3RSUGV2Nytxb0ZraE52cGNZelNNZHhGdmRYZGpwdTVEZGhB?=
 =?utf-8?Q?OFk5DILdbP8x+NxI=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb250836-d959-423b-6985-08df0440bc67
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 13:40:19.6602 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zmsmwQttS5dFJWJN4rUxbtJA5+HiNWu2aMYJe3aEdKwf8FlSUoY4NiJgfm5Hlt6RquxH90g3CEmHCs0m7MvJh5ts5PwJZj/igl2BQzo1x/U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR10MB7696
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On 8/26/26 18:13, Jonas Karlman wrote:
> Hi Ludwig,
> 
> On 8/26/2026 3:52 PM, Ludwig Nussel wrote:
>> On 8/22/26 00:48, Jonas Karlman wrote:
>>> Hi Ludwig,
>>>
>>> On 8/13/2026 8:09 AM, Ludwig Nussel via U-Boot wrote:
>>>> If U-Boot is built with signature verification but no keys are
>>>> included in the device tree, the boot would still continue.
>>>> Introduce FIT_SIGNATURE_REQUIRED to avoid a fail-open setup.
>>>> Defaults to off so existing setups are not affected; boards wanting
>>>> fail-closed behaviour must enable it explicitly.
>>>>
>>>> Consistently use log_err for errors in fit_config_verify_required_keys()
>>>> while at it
>> [...]
>>>>
>>>>    	/* Work out what we need to verify */
>>>>    	key_node = fdt_subnode_offset(key_blob, 0, FIT_SIG_NODENAME);
>>>>    	if (key_node < 0) {
>>>> -		debug("%s: No signature node found: %s\n", __func__,
>>>> -		      fdt_strerror(key_node));
>>>> +		log_err("No signature node found: %s\n", fdt_strerror(key_node));
>>>
>>> This change is causing a verbose error messages on Rockchip where the
>>> FIT_SIGNATURE feature it used to check image integrity during boot. The
>>> config nodes is not expected to contain any signature, only hash(es) of
>>> images.
>>
>> Is the message a problem? The intention was to at least leave some clue
>> about the potential fail-open behavior.
> 
> Yes, printing a verbose error message for something that should not
> always be treated as an error is an issue.
> 
>> Looks like you are also not using signed configurations with is even
>> more suspicious:
>> [...]
> 
> It is not, as mentioned, Rockchip platform only use FIT_SIGNATURE for
> image integrity checks, and not for signed configuration validation.
> 
> This series seem to make an assumption that signed configurations always
> is desired, and for the Rockchip platform that is not the case.
> 
> On Rockchip we enable the FIT_SIGNATURE feature and only ensures image
> hash nodes are populated. At runtime SPL checksum validates the images

Interesting. The documentation of FIT_SIGNATURE clearly says it's about 
signature verification. Nevertheless you are right, common/spl/spl_fit.c 
has this:

        if (CONFIG_IS_ENABLED(FIT_SIGNATURE)) {
                 printf("## Checking hash(es) for Image %s ... ",
                        fit_get_name(fit, node, NULL));
                 if (!fit_image_verify_with_data(...


That looks unnecessary to me as fit_image_verify_with_data() itself 
guards the actual signature processing with if(FIT_IMAGE_ENABLE_VERIFY 
..) which is turned on by CONFIG_IS_ENABLED(FIT_SIGNATURE).

Looks like common/spl/spl_fit.c should not have the FIT_SIGNATURE check, 
right?

Also, fit_image_verify_with_data() looks like another case of fail open. 
If bit rot coincidentally flips a bit in the "hash" node name string and 
therefore no node is found, no check is performed at all and the 
function returns success.

cu
Ludwig

-- 
Ludwig Nussel
Siemens AG
www.siemens.com
