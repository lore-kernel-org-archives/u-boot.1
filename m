Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2201C4345F
	for <u-boot@archiver.kernel.org>; Wed, 17 Apr 2024 14:00:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4BCB288442;
	Wed, 17 Apr 2024 16:00:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="hZtuHnSj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 158C788447; Wed, 17 Apr 2024 16:00:08 +0200 (CEST)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260f::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A5AD8832B
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 16:00:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SVVPDy74yBf23kZdNwddNiqDbvylGw6w1dCuZ88f8W9aHefEtejdVCIlbVT5UKZgiOKvdg1E63ij4Odlss+pYaKaSIbXHISdNTcBqRpni0kRCH1kU0oXP5sfWJTgFl/etEsCfdejP2pc5PC/XJuouJfHa7lCSKyIkppcAsMiRk47aLaSQjORvs+OBphunSamhvtAUtVNjaDEg1Zg7fMXrsRvAXhwZPey4the7pvIu0HeUlGnJDqRp7SEojci2oZl5cDNfQeMnYsHOY0VD9OcKCsiKHTiQvpEZmM/7+zWPL1halEv6PYuSL2ELZs/9Q3Aju320FJ9x83aMMGjF2UGKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mhQeI6PlYfMp99dfAM/yKyHjtCzlSkU4sEW4lX6IyuA=;
 b=knH8K0Fh49NLvkjlHZ67xVRZaupGMUQ2wRbDlQIQOj3mYSQcHeEiL/5J8+HLaCa01mdjBYk2pAMXj01muKqNKXemUow567sS9wgZWgfnnhsHz/J6lWAJp84I5Lx8Q0+FXyXewrhsiSX7SqekhN/epVMGYO/LrWG+5pRnclD7IWO2v01VQsHD6lg4NxY3BDfFjg0tc5u3VbpS7JJgngkR3Ss2Imf5c2bxLsEMpEGoWA1R+hNbXS21lo7esE6TqlViG/CTVrD/AEMqcmO2YaVGkrWt5mJnlx4Tew/B7rXdxrdO1hJFsRAdLu4KvlgcQ4vCc8QoeK+Xby2qosI0+H0hwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com; 
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mhQeI6PlYfMp99dfAM/yKyHjtCzlSkU4sEW4lX6IyuA=;
 b=hZtuHnSjjra8IAlaYDcN3ptKVGvrswidPeIUr6MEUd/s23J+2eezmR89Qqf+T2XAxlwEiWN5bNMsxYP3ScQHz0XFLmYTMrYig3VaW71kmlxjEBzkS/ArUQs0lTzZxBL2D9igAwLVNkPyHBTJHLOlY1mD743iMXXgb25vgyKysaK4WcMFnKYosg0tFUn/VWiWMk2k4oJX/fV9zl7r7OkBCMnG+QWPUTflpTAQ47UUbWSYWdFD7kTMQNR7bQZbJ+ay3aYysPkSmzMJq0g9iQJ6JHeDdtUCXh/0WEJrLXZ3CDUEnBHMPsdYmDNVEl3BC6fsCU5cgTeLYJxKLuWre2jlNQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DB7PR04MB4842.eurprd04.prod.outlook.com (2603:10a6:10:1b::13)
 by PAXPR04MB9351.eurprd04.prod.outlook.com (2603:10a6:102:2b6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Wed, 17 Apr
 2024 14:00:04 +0000
Received: from DB7PR04MB4842.eurprd04.prod.outlook.com
 ([fe80::bdc7:4b2c:e74e:1504]) by DB7PR04MB4842.eurprd04.prod.outlook.com
 ([fe80::bdc7:4b2c:e74e:1504%7]) with mapi id 15.20.7452.049; Wed, 17 Apr 2024
 14:00:04 +0000
Message-ID: <af05b1a6-41fd-47ba-be2e-a33a053efa27@theobroma-systems.com>
Date: Wed, 17 Apr 2024 16:00:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ram: rockchip: px30: Replace misleading log message
To: lukasz.czechowski@thaumatec.com, u-boot@lists.denx.de
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, kever.yang@rock-chips.com,
 trini@konsulko.com, Lukasz Czechowski <lukas.czechowski@thaumatec.com>
References: <20240417111625.288202-1-lukasz.czechowski@thaumatec.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <20240417111625.288202-1-lukasz.czechowski@thaumatec.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0005.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::11) To DB7PR04MB4842.eurprd04.prod.outlook.com
 (2603:10a6:10:1b::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB4842:EE_|PAXPR04MB9351:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fac6415-3c30-4f5f-5730-08dc5ee6ae97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4KL0WUhKBOwEfFOil/qailkETVXVUjQSP3vUYAtGy2u+eHJ+vGDGtrYs3Ph1ZtA2sM3O0ZkTIdGDGRTKj1EZ2I/ILNNd3XcsNLwos9W7lTveBDIayk2mjm6XpZHcBrnMF8rwe9H2BtO3QaAwgMDXEyw6Ibjhi0j7ZQpWNwBk7IeJkTuYC5Tb+5knpG7hd1pC5Pc8G4M5bPn0nayFglVUmMq1UgVc0jZVKqfj4dshEV3T4W5YRTAYsEGnf/1G93NHmIzhzuM/mgTwzfoVgDMyBDx5jZ2zqbL1iOqayKAtIjBpt68vuVSD5GbdHoC7xbHIdTmMZkNKDsMFOaJnwa10/p5yGtvQcGnB195Yl5YmfXXjbCYKkfjydiHn7N585eUUppDV+Gg1qjRr9UopfQf38dOKszgCz0nDXAIsogkWdjDfC3etunon2G/nGUxVqtJunoAVX0iioaejBVXZb9qvYzbAKknl8eW5H6V+STVH2fUHozmat6sEBWRrGQhEBgHUjoYqYdNsxlbUXxR1DjTKy0NDzQE0aT/+Uubz0l67oKp+pOuQuqAwOBNlhzOtxU4nKu/iYnFmj4YZXWd+6Is/xQFyMrF46pl+ast+bQSBP3GzYVQauarcNLmUZUIZMbPPsIy95Cz1D4iIWNSaxTvCgCrju9YvjE848Vt9oGsPbaI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB7PR04MB4842.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aFNZOTRHZ3gxVjc2TGVRUlFkWlVZSVE5TUo0RHRvcWFmRnlVQmsrVzB2M1pp?=
 =?utf-8?B?MVhsRGthOUlRMitQcFNyTGt0TkpDOEtJL0lYSG16NVplUDc0QStzWUVNY25E?=
 =?utf-8?B?a2tSN3dUQ3d2dHl2SEhvOTlGTWJ2UiswdW5YcExJS3RaRERZNzBvNlBVRWJB?=
 =?utf-8?B?MHpPbU5aL0xwR2FBdUFPNjBZcHc3bXBzWm8xM3J4dmxtbjhLWnlzU3JqOWhz?=
 =?utf-8?B?cENIV3EvQzNnUVQ4djRvb2hybGZOeUx4c0lCZkxKM2VyQlZhUmxyRytPZGlB?=
 =?utf-8?B?R3ZOQnlweEplQW9CMW42TVh4czVDWnlGQXo4L0k5em90dmRWa2pBc2ZOQ015?=
 =?utf-8?B?TlJKdU9LNWFWMUdXa0dmVnZRK3ltbndjL2ZvT3RVN0prOVk0ZnhYR0ZzVzdX?=
 =?utf-8?B?WGdoUHJjZlJlZDBraEIyYU9MczRoQ29jRzQ5OTdNSkdKNlFMdnM2b21VaFlG?=
 =?utf-8?B?RDNCWEM3NjNEVzhDYUVQdFlUYm8xQVcvK0ZpOXduamEyRUZqY1RvZ0tyakpk?=
 =?utf-8?B?cis2RzdCdmVXR2k0czFHSzVvQWF2UVV4VFFNQ0xyaVhjeWZ2MXZrZmxVNmsy?=
 =?utf-8?B?S2t4dFZwbzVwVFZlQS8wTzZNVXBESHk0bW9kNm93ak9uQXFHbHY1SDhxMmlV?=
 =?utf-8?B?WTFNMDQyRk1RbHZoS2h5NXJhS2QvWHkxQXJsUFRrcEJ6OHNWSXF1RWtEU1I3?=
 =?utf-8?B?ZkJkSkJ5QWU0QUZoZnJidkVXOXV3Vlp2L2Rka0dYczJQaXZnUGR2RE1NbzFw?=
 =?utf-8?B?bFB4NCsvZGNyeFljNVF3azEwTkhRalREaDBIRFZUTkJaT1N0NWRramxIenFL?=
 =?utf-8?B?eTVMN0EyWitVdmZIc1NMRlU2VTJxak4xMUQ4aUVrUCtnRWt6NjBUZkFRbjJB?=
 =?utf-8?B?NDdrTGxiRGYvRFBucW15aGdpL051dnZ5Zzlqb2ZRVHE0Y1ZoYXY2Y01uQURT?=
 =?utf-8?B?MnpLbFBHcmpRa2VxY0ZMVTRWbVFJUlRNQnRyMmxka1JoODZGU3Q3RWVXUmRE?=
 =?utf-8?B?ZDZzV1lOb1hhSS9tR3BGVlZkVnlCaUdWUzZaMi9pZlV4SE9qaFZVSnpMNDlQ?=
 =?utf-8?B?cUNCZk9zREVndEEwTzgvMTdpYXJZZlVaYzF0dkJ5Y2dWRlhPV2EramRvQW4y?=
 =?utf-8?B?cU93RHp5M1kxS00xYWZONGR0R3p0a2VWenMvRUN5RlRkRFFtb1lhSCtINFJt?=
 =?utf-8?B?d29oOGpJM1dwK0NoZTVMZnVmczNNWGQzcmh2VHcra3JnMVhaT0hnMy9JMllk?=
 =?utf-8?B?dEo5a1NJRS9pUitQV2paVi9KMU9jTm12NGJJWHNYSVBRT24zMWpXK08vRllS?=
 =?utf-8?B?WkZFNGkrb05PMll0dzdDUUZLS29HMnhlMTNVeWVkaUtVK3d5N2hkWnZPb1Ez?=
 =?utf-8?B?dFhZU0g3OE5rUHk2Y1FYM2NMR0dSWk5qM3RNRysxaTNSN0YrT3NHSEFidTZr?=
 =?utf-8?B?ZU9ZbUcyWUZwcG81bi9GMkhXS1RNNjF6eStVOEYzQ091VW5oYmxvRm11VnBP?=
 =?utf-8?B?eTEyclphYzA1enhpNVA0K3BBc2JzR2R2eEtwRis5aVZJbWxqY2Rac3M1YlRp?=
 =?utf-8?B?ZjFHR2V2RGFlM28xakFzZGI1cXNMZlJXc2NJcGF3Snk3bXQ5U0lJZEdXNy8v?=
 =?utf-8?B?a2pUaTdkcXk5T3gvZEFaeTYxNVVrSUwzUm04aEQwbDlpb3I4eTBRdTJrcFVE?=
 =?utf-8?B?VDZsdndYemxWOTRGenJ2TStpV2tsSERPMzZTZVFHaGloc0FudTlYNmtqNHlo?=
 =?utf-8?B?bTN0Q2h1cFJzSTdjZVNjL21Sb1QxcE9GVjVUK2lLZEtuRmdQMWlrOCs2Rk1h?=
 =?utf-8?B?TzgxcElEQTRYMEVCY2ZiTDdWZGJsUkdDWkZiQW5GTms0Q1pzb3dmUWx2bkpw?=
 =?utf-8?B?aE5wNWRzclQ5VFhOUEZTUitnYjdTa2RSQUM2MklTU0ZXczU5WnN0REpYT0FZ?=
 =?utf-8?B?MjloQ0Jzakx4S1R5RGc1SDNwMXJuaDUxM0ZYaFNZVHNRUWo4d3JpS1U4cG5R?=
 =?utf-8?B?MW9rWVV4TUJPRHhlWGpZSmFkUWlWWHFVMUVVeDJnditxM2Y0WHV0Y0RNdCtH?=
 =?utf-8?B?STZWVTJCbi8rOEJsZnQ2L2VnZ2c2Y1JxYUhjSEZNM3hPQmdRbEdoOXZlS1Ix?=
 =?utf-8?B?aUxFTlRYS3c3emtWSDJiY2JkUjNEaStSNHRJT3VhbC9HcWdyNUlRWG1CN01u?=
 =?utf-8?B?TjRuSXBPVExGQnFEdHFhK3hDNHRyaUxXTmRiV29PdXdDYkNabHF4bzZiVjEw?=
 =?utf-8?B?b0JLYjhHLzZzSmkwbks3dU1FSjZRPT0=?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fac6415-3c30-4f5f-5730-08dc5ee6ae97
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4842.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 14:00:04.6297 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O22VD74BnTvtbUfTUst7AimzVV/ZKFTRLjDwBSHEhQFbLHkbci1jLA+V8lIlTujrLyzfySv1DoSNaWcAMFRQI54iZa7YayGa5ywGEPb1MnH9M8GTJILiVHw4jt43gX0s
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9351
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

BTW,

On 4/17/24 13:16, lukasz.czechowski@thaumatec.com wrote:
> From: Lukasz Czechowski <lukas.czechowski@thaumatec.com>
> 

There is a typo in your mail address. I assume your git config 
user.email may be wrong, because your signed-off-by is correct.

Cheers,
Quentin
