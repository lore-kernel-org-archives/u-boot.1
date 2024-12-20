Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2E4BE7718A
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 06:49:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31F6D8007D;
	Fri, 20 Dec 2024 07:49:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="sRzydg53";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC1EC8021D; Fri, 20 Dec 2024 07:49:06 +0100 (CET)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on20725.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::725])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF4868006D
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 07:49:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xsETqOlh7xUxQIk97zu6pLE3tRUpIpD0sgtYO6CuT0K7NH8GaZH7larGBRxwnxzdikz8VgyLTaK9Y2d9MVoRCrW/oyxP+hvpNR182vOyhnokb9GVUFzK33X6nTcsPlezyEtTxoKuW/sFR8mX1AbabQbZXxmOJ+UF1GwKIClXEBSxRjjNDoOYenWtutQQAJfE6aivvgNAXqBD6NPVvNMLbEO6mld6vvrD9bNO+9bU4tBcf7SyJwOCOJeB6u+01Gf4TYGHI6qN+oBgmNNa3ZItRDUN0A50va6aTQPnRs30k1UKwHYO+boyI54C/Mm/Ce1MHNa3+PAFSGgciZqRg2rRmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pl2IGO0jkxZ9dTQ60GmClc8dgC86v9eZNIi8fxg8ktE=;
 b=rRluf+kvjaEHmnRDQghu2q0yJ7NpmlNCaDYtSdgwY85aD8p0HJaMFgBbhkZRXUVxYN/6OOdjqwZam8kbufNOzIxeknc9ukUtgjI4e42XEQzUWtjQVH3xO6gfrTxuGk3R2CNm8zdPOKEcoeFVdfc8aiZ2LHQwj0Vd7+z6//27DZhM72wqOP2/vGKx6y4qDy4yoYJXFWpju2JUZTnb3taxVVnMZ+wkDY++eO6hd8OZOLLIZ+7d1ppOInO04UiYH7PNn4c111qUaPwENH0KS+1ujS8N0dn01zy1Wk8BsujNChy7SWuQzP6a4GOnoNmCWtl6yj56Ap1uNmxeZGK9RYRqyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pl2IGO0jkxZ9dTQ60GmClc8dgC86v9eZNIi8fxg8ktE=;
 b=sRzydg53a2fBAcfhc+I/E0LOxgvYkFKO45X8G+f1SIyv9Xhf5Ie93vr3UcSQImjCS9zAH42AcqGeVA+dfsZ5bqfhMnLZnN42zLDq5AiIhmol0GtLDrfo8wg3yWVkNGIRndsOWLOK2l5IMDpf6k0d39BITj4Re4twvvN151A4zrDtdaDlFWaq7iBlmLb45WP58idi1sJkrUdTeXGvj35uCVBLcf7YtDzxUpCisEcAkROxuz/O5rxZFKVuOIhlKpDgTtY1Bg7WIms3E2wujbwF1e24nvJRpDQFmzEVS6EoTqpQNHeHhqRVse5c2ua0Dz+wZNZrTUBXUcIuUo3uHv6znw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:4b3::21)
 by GV1P195MB1926.EURP195.PROD.OUTLOOK.COM (2603:10a6:150:9d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.14; Fri, 20 Dec
 2024 06:48:59 +0000
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::369c:a760:5bf9:8d4a]) by AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::369c:a760:5bf9:8d4a%6]) with mapi id 15.20.8272.005; Fri, 20 Dec 2024
 06:48:59 +0000
Message-ID: <4d059cda-778d-44af-9fb3-a539a2ec06ca@phytec.de>
Date: Fri, 20 Dec 2024 13:48:52 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 9/9] board: ti: Pull redundant DDR functions to a
 common location and Fixup DDR size when ECC is enabled
To: Santhosh Kumar K <s-k6@ti.com>, trini@konsulko.com, nm@ti.com,
 vigneshr@ti.com, u-kumar1@ti.com, bb@ti.com, m-chawdhry@ti.com,
 vaishnav.a@ti.com, j-choudhary@ti.com
Cc: u-boot@lists.denx.de, n-francis@ti.com
References: <20241213103129.332246-1-s-k6@ti.com>
 <20241213103129.332246-10-s-k6@ti.com>
Content-Language: en-US
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <20241213103129.332246-10-s-k6@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KL1PR01CA0128.apcprd01.prod.exchangelabs.com
 (2603:1096:820:4::20) To AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:4b3::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4P195MB1456:EE_|GV1P195MB1926:EE_
X-MS-Office365-Filtering-Correlation-Id: 28828d50-db7b-4a0e-5c1b-08dd20c261de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c1o0YWhQNTM2cERuRkVScnZ3QW1jb1pWQlRjWXBPTEFRM2huN01YRzdzRDBj?=
 =?utf-8?B?aXNwSy8wRFp0QVl0U1hPN0NnRmgzbmo1WnBhdndkc0RXRVNLTTlEN244NUNl?=
 =?utf-8?B?Z1h4OStCTXhoSHVzWklvczRSR0c0RzJLWU1SdkZpTllIa0dXaFk3RkpmUGx4?=
 =?utf-8?B?K3FUNlo5VHRoTHRjekpTMXp3elk2aldLNDFMSTN5ZjZlVzFSMm4vSWpaSXVn?=
 =?utf-8?B?M1NHMHc4OVpORm9adVpvZlFFcnBKcjF1VHdac2dPZXdkSWQ3WWJzMW9lT3lD?=
 =?utf-8?B?YWVTbUlKMlVCVEtnTzM0ckpzUGFqZEY1NTNCcU1TYzhzcE8vREk2cU1BUFo2?=
 =?utf-8?B?VXBVNnNtSDl4dGJTTkY0REh6STIxWFVHSXBNdTRRMjBiNStENHBMN3pzUFBP?=
 =?utf-8?B?cUJaUlg1MUxPTDVpN1hjZmJ5d3VOczkvWlNRZktwdnNOWmZqNDROeUFOeE5M?=
 =?utf-8?B?UEJoWjU4QW1oZXVscXc4RzQ3Z1BEVndmekxueFoxS0I2bmt5TEJ2VzJjZUZV?=
 =?utf-8?B?VitYcmF4UzNqUEp3d0lzZkg3UEs3aHNYU29IbTVFY0ZoVjhzZTFOQklRdnR5?=
 =?utf-8?B?WitLR3RhenNUcGRyOU12M29VTEZLVnczR096WVREcEtua29WRFhnNWJ5NHFS?=
 =?utf-8?B?ZUJrenVqT0RENDB4WjNQcWJ6dmJ5dVVvdTlFOVBMU2poTFZsTzJyQ1JMWUhX?=
 =?utf-8?B?NUhUWmFVK29ZTE1DVTlFc1RDT25Da0hQcUZVVk05S2ZiUlJzeUU0QW56YzJG?=
 =?utf-8?B?YXFaWlZpZFFLYURjMmdCb0ZyejdweGpSQ3NBZk8wSVluL1RtQ2d3V0ZPRzI2?=
 =?utf-8?B?K0J0Y0o4N1o3c3Nka0ptaUJBOU5jUFpkYkdpQlpqVWJiQnJxSkpBalVoY0dw?=
 =?utf-8?B?Skp0djJhZjhNTi9ydVJqMXBtRTRVcFZkSUlKOG5pK25TWjk5NVVkSjZ1V0hN?=
 =?utf-8?B?TWdTKy8xOFh4R1NROXl4ZEI3TzE4cFppREk4MEZEWjVYcFladGx6aVZVODRT?=
 =?utf-8?B?bWlEU1hQb2lCblpmWUhuaS96Z2wwVGljQmxqTDd6WEljVDQzS3FQODBkWGhL?=
 =?utf-8?B?NVFCNWJvQzk0VFNSbThjcDNReHlTUVF5OWwwQzVERG5mckt3SENuWks0YXZ6?=
 =?utf-8?B?NVlSMFY4ZWl5ckZXeUt6Q0dVL2dGdjVvOFZKeWdvUndydGVZM3RsenVnZkV4?=
 =?utf-8?B?aVFvNXFPaTN0WTJaWFRzQ0d0UE5INEN1OU54OERTb3FjanluY1ZNbGhodzFw?=
 =?utf-8?B?czlZajhDdSt2VFNTTEF2NnZDcXhSRFNaWmp4Nld6Zmsyb1VMdjltYjFaTmk2?=
 =?utf-8?B?Ym9jaUZhMi9yMWkrdzB4Y05wMlgySXB6b1ZIV0I5Z3RRMnhnUnZWeWYrMmlO?=
 =?utf-8?B?TkNWeUZRc1lyck1pMmpxelVkMkN5TzZ3bEN4YlgrYzdUSDJTZE8wcllTKzdh?=
 =?utf-8?B?L21hQW41WldRbHJqUEEwbFlKVFNRbHB5TjV2UUQ1Ulk5U3dYbzVqUjJlWEEv?=
 =?utf-8?B?MTV3ck8vT3pLbGFtMTU4aW04cmxTOWZEeVJVczJnRUZJOUdBb3BPaWZDcVBa?=
 =?utf-8?B?TUhHSnRCWnlkL25jUUNEK3poS3lQd0tNSWluM3Q0dG9CTGpZejhuVHh2ck54?=
 =?utf-8?B?VE00QmM4NDdBdlY1K1N4SEVuNzMxb091UzFnS3l4Um02TDMyVXhBNUdCWFAx?=
 =?utf-8?B?WEJHUldpYmRSVG5YcENXYnZuZ3dKaGZwMXU5SFVSa0c5R0hqQjZxaDFoNDls?=
 =?utf-8?B?VEtuY0FFQzlPSlRUclV2b05mVTgxb3RxR1JxWlQvUS9QN1FlQmw2czdibHYx?=
 =?utf-8?B?MHg0U1hxT0xnNHI5Y1F5Zz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4P195MB1456.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bXBvdWJqckE0V0R4ejk0Q2hyU2d6RXB1Zk1qMXhyZEJkZXpLKzhIVTE2aCtr?=
 =?utf-8?B?UURxOVBOa2pVZjlSVzU5WWpSaWxmQkk5V1oyYTg4YzNqMmJvZW9NRmV0cVRO?=
 =?utf-8?B?MmZ1RUNnTjFxQjlhTnNtcjVqdVc4RDVmakxYejVlbTFHZlExeVNOb3l0SWZG?=
 =?utf-8?B?Y1E2ci84ZGNIWjhSQmV1QmE5QjA2Tk5OWGtQVlBDdmxIalVwK2MrMWVXTS95?=
 =?utf-8?B?MHg4SU4yV0h3U1luUmpLOFc4WnpjSW11WWNSOWZyR0Rja2RRZ1k0N2JjTGg4?=
 =?utf-8?B?akZ5dmMxTlJNVXMvQlZIU1dVQWdZeDBlOXpVRDVERTBZbFIrR2N5MWJXTDRF?=
 =?utf-8?B?UmtZVnFxS05vQ3NpRnY2ZktTL2hVL0NPN0xOSWk5MU9LUHY2TjNXL0lPMFZ4?=
 =?utf-8?B?NlNUckZ6UDN3dXJWNnpHNU4zc1BhSmxvRnBxcWJ6MkVqRk5sWXJuMm1iZjQv?=
 =?utf-8?B?RTdFcEdSNERIK1ZvejRraVoybU85c2grU0NBNkZWRmZsZG55cVE2TTlZMmh3?=
 =?utf-8?B?VENQaUVNN3A5cEhWZFA3WnRNSUdPYnljODJyVHkycGZtRjNLZW44WUR0Smwr?=
 =?utf-8?B?UWx4RjVoNWZUeXhCQkVJNWE3YzVDdGo5Z3ZDeTAwdUZTY241SUNPMm5DSWdu?=
 =?utf-8?B?bXZEVFFINms3SXhickM1TUkxOHJCRkR6VnpLaDhzMVczaG1VNDUvc0dQT3Nk?=
 =?utf-8?B?UzdNUFA0WVJPcTBhQkw4dU9xUFJTUzg5N2V4MDhpU29jZkxvSHVKS2RKOVY3?=
 =?utf-8?B?eFl6Nkoydi95LzVObFB5TDBnL2E0NWZLQXBTWXBDdThoOStxNFM1QnVoV0tQ?=
 =?utf-8?B?UnJ2bko1dXRWbXI0SWtHaDQ3REtTMWFFeU5BWTBJSDlnUmxwZXlhZHB2N3dB?=
 =?utf-8?B?QzNMQmhsTkk2QVBmYVVFTkh0dXd1V1NIdUlUQmVJWDZISkFnVlZyRFlHVGRw?=
 =?utf-8?B?cVRQK0FLTjk1YUxYdTRobWZ2c3IrMkhGSXNUQjdYNERrTXpld3dtYVVOV0dQ?=
 =?utf-8?B?NWVUYkZIdTFGYXB2Z0JkcUx3Zzd3dDBmR1ZJWmEzRjZSanhQYUVFNmRneGdT?=
 =?utf-8?B?ZGlweko0c2dEaGhZNVlWcDBqNkw1NjhUbFQvVlBGTXoraEFLeUZ0Z0R4WEt3?=
 =?utf-8?B?dUQrdERqY0xrbStRNmtPWU9uS28vZ3Q1c2FKMUwzSmZJeEp3bFBGc1AzTnN5?=
 =?utf-8?B?dkgyeDcydmhqVWgzTUhsbkdLblFKeHgyOVJsWjhKclNWbWxidEg0ZDZOQ3ds?=
 =?utf-8?B?d3JzditFOVQvbEs0azBrSWZzNUVNT2FQT0p4ZkFDUXA1S0hLWVJlakphZ1ky?=
 =?utf-8?B?ZXVLUDJiTnNIbmEzcXdad0Z2YzcvRThMTFQ5aDBudmhIU0tMcEorU1kvMlY1?=
 =?utf-8?B?S0sxYTJkRjd3ZlNIU255QWxHSTFMOEhwVit0Tko1dGg3UTdxTzFLNjhlV2Va?=
 =?utf-8?B?VXRhYW8rci9Kc05UbTVhYnZpbjFmVndWMEh4WlpuWVFZQUcvOURaUFp5YVBF?=
 =?utf-8?B?VXhhcVk3YzFrZUJOQVVnSjNmRzlhcHB4bHhFeGNnQm5UUlR2aENwT2tKZ0R0?=
 =?utf-8?B?bHgrdU5MR3BtVnFPNjVVY0lETENKSGNMWTducTRsVVhBZ1E4TE1WMkNOck8z?=
 =?utf-8?B?ZTNaall5VGFPbDlZM2txTDAzNHJRM0FwSUZnaEF3UUNGeStCRzlyN2tIRk1J?=
 =?utf-8?B?dU1YeE9UMzU0Vjc2VE9zSnQwNzJkL1NmTXBhTy9UNkthd0MrVGhwdUdNc05F?=
 =?utf-8?B?NEYrWFBKT3BiYTBTU3BQbjJyd2I0WWYzMXM5NG5iSy93cGFWM0pHdEdtcXdN?=
 =?utf-8?B?WEtvZVZxZUF4U0N4c2VqQmVadVBCRmJuSmtIR0p5QTFCY05ZNmxSUkc1dkhz?=
 =?utf-8?B?enBQTVFJQXJocVVRcUVDVHRtYjZMbk1US2Fxank4TWtFdlIyWm9iY2FxRWd2?=
 =?utf-8?B?aHZQQytkdmROeTJmWXp6ZnliRTd0eTNaWnU0bEp4dWJVUGpOMy9nYUJacml5?=
 =?utf-8?B?L0F4WFBaODBoT0ZXWS9zbFpGeDM1R1Jxb0FzUDlzSURZTDA1aDhWMFJ0bFA1?=
 =?utf-8?B?K0gxZ1BwN2k1TDYvS0VrQ2FxS21YUmp1Smk3dEFPejdmbEFQT09MMWpCQi9n?=
 =?utf-8?Q?IHXg6aC4fm7e27YimC3x2Q43o?=
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 28828d50-db7b-4a0e-5c1b-08dd20c261de
X-MS-Exchange-CrossTenant-AuthSource: AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 06:48:59.5361 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b0eVoYXed1mDekqHAteJkuboW+KLGokoQE2UdnzknVJ0xDns8HdujhLLryLk34QNHKCd2Dfpeoyu9wY7lYhFJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P195MB1926
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

Am 13.12.24 um 17:31 schrieb Santhosh Kumar K:
> As there are few redundant functions in board/ti/*/evm.c files, pull
> them to a common location of access to reuse and include the common file
> to access the functions.
> 
> Call k3-ddrss driver through fixup_ddr_driver_for_ecc() to fixup the
> device tree and resize the available amount of DDR, if ECC is enabled.
> Otherwise, fixup the device tree using the regular
> fdt_fixup_memory_banks().
> 
> Also call dram_init_banksize() after every call to
> fixup_ddr_driver_for_ecc() is made so that gd->bd is populated
> correctly.
> 
> Ensure that fixup_ddr_driver_for_ecc() is agnostic to the number of DDR
> controllers present.
> 
> Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>

Reviewed-by: Wadim Egorov <w.egorov@phytec.de>

> ---
>   arch/arm/mach-k3/Makefile              |  2 +-
>   arch/arm/mach-k3/include/mach/k3-ddr.h | 15 ++++++
>   arch/arm/mach-k3/k3-ddr.c              | 72 +++++++++++++++++++++++++
>   board/ti/am62ax/evm.c                  | 17 +++---
>   board/ti/am62px/evm.c                  | 17 +++---
>   board/ti/am62x/evm.c                   | 63 +++-------------------
>   board/ti/am64x/evm.c                   | 73 +++-----------------------
>   board/ti/am65x/evm.c                   | 29 +---------
>   board/ti/common/Makefile               |  1 +
>   board/ti/common/k3-ddr.c               | 33 ++++++++++++
>   board/ti/common/k3-ddr.h               | 12 +++++
>   board/ti/j721e/evm.c                   | 29 +---------
>   board/ti/j721s2/evm.c                  | 35 ++++--------
>   board/ti/j784s4/evm.c                  | 17 +++---
>   14 files changed, 190 insertions(+), 225 deletions(-)
>   create mode 100644 arch/arm/mach-k3/include/mach/k3-ddr.h
>   create mode 100644 arch/arm/mach-k3/k3-ddr.c
>   create mode 100644 board/ti/common/k3-ddr.c
>   create mode 100644 board/ti/common/k3-ddr.h
> 
> diff --git a/arch/arm/mach-k3/Makefile b/arch/arm/mach-k3/Makefile
> index 8c4f6786a5b5..5ce7fc62d80c 100644
> --- a/arch/arm/mach-k3/Makefile
> +++ b/arch/arm/mach-k3/Makefile
> @@ -6,7 +6,7 @@
>   obj-$(CONFIG_ARM64) += arm64/
>   obj-$(CONFIG_CPU_V7R) += r5/
>   obj-$(CONFIG_OF_LIBFDT) += common_fdt.o
> -obj-y += common.o security.o
> +obj-y += common.o security.o k3-ddr.o
>   obj-$(CONFIG_SOC_K3_AM62A7) += am62ax/
>   obj-$(CONFIG_SOC_K3_AM62P5) += am62px/
>   obj-$(CONFIG_SOC_K3_AM625) += am62x/
> diff --git a/arch/arm/mach-k3/include/mach/k3-ddr.h b/arch/arm/mach-k3/include/mach/k3-ddr.h
> new file mode 100644
> index 000000000000..95496e1c59dc
> --- /dev/null
> +++ b/arch/arm/mach-k3/include/mach/k3-ddr.h
> @@ -0,0 +1,15 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright (C) 2024, Texas Instruments Incorporated - https://www.ti.com/
> + */
> +
> +#ifndef _K3_DDR_H_
> +#define _K3_DDR_H_
> +
> +int dram_init(void);
> +int dram_init_banksize(void);
> +
> +void fixup_ddr_driver_for_ecc(struct spl_image_info *spl_image);
> +void fixup_memory_node(struct spl_image_info *spl_image);
> +
> +#endif /* _K3_DDR_H_ */
> diff --git a/arch/arm/mach-k3/k3-ddr.c b/arch/arm/mach-k3/k3-ddr.c
> new file mode 100644
> index 000000000000..6e3e60cdc865
> --- /dev/null
> +++ b/arch/arm/mach-k3/k3-ddr.c
> @@ -0,0 +1,72 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2024, Texas Instruments Incorporated - https://www.ti.com/
> + */
> +
> +#include <fdt_support.h>
> +#include <dm/uclass.h>
> +#include <k3-ddrss.h>
> +#include <spl.h>
> +
> +#include <asm/arch/k3-ddr.h>
> +
> +__weak int dram_init(void)
> +{
> +	return 0;
> +}
> +
> +__weak int dram_init_banksize(void)
> +{
> +	return 0;
> +}
> +
> +#if defined(CONFIG_SPL_BUILD)
> +void fixup_ddr_driver_for_ecc(struct spl_image_info *spl_image)
> +{
> +	struct udevice *dev;
> +	int ret, ctr = 1;
> +
> +	dram_init_banksize();
> +
> +	ret = uclass_get_device(UCLASS_RAM, 0, &dev);
> +	if (ret)
> +		panic("Cannnot get RAM device for ddr size fixup: %d\n", ret);
> +
> +	ret = k3_ddrss_ddr_fdt_fixup(dev, spl_image->fdt_addr, gd->bd);
> +	if (ret)
> +		printf("Error fixing up ddr node for ECC use! %d\n", ret);
> +
> +	ret = uclass_next_device_err(&dev);
> +
> +	while (ret && ret != -ENODEV) {
> +		ret = k3_ddrss_ddr_fdt_fixup(dev, spl_image->fdt_addr, gd->bd);
> +		if (ret)
> +			printf("Error fixing up ddr node %d for ECC use! %d\n", ctr, ret);
> +
> +		ret = uclass_next_device_err(&dev);
> +		ctr++;
> +	}
> +}
> +
> +void fixup_memory_node(struct spl_image_info *spl_image)
> +{
> +	u64 start[CONFIG_NR_DRAM_BANKS];
> +	u64 size[CONFIG_NR_DRAM_BANKS];
> +	int bank;
> +	int ret;
> +
> +	dram_init();
> +	dram_init_banksize();
> +
> +	for (bank = 0; bank < CONFIG_NR_DRAM_BANKS; bank++) {
> +		start[bank] = gd->bd->bi_dram[bank].start;
> +		size[bank] = gd->bd->bi_dram[bank].size;
> +	}
> +
> +	ret = fdt_fixup_memory_banks(spl_image->fdt_addr, start, size,
> +				     CONFIG_NR_DRAM_BANKS);
> +
> +	if (ret)
> +		printf("Error fixing up memory node! %d\n", ret);
> +}
> +#endif
> diff --git a/board/ti/am62ax/evm.c b/board/ti/am62ax/evm.c
> index 62d3664936e7..3351544c5b37 100644
> --- a/board/ti/am62ax/evm.c
> +++ b/board/ti/am62ax/evm.c
> @@ -12,6 +12,7 @@
>   #include <env.h>
>   #include <fdt_support.h>
>   #include <spl.h>
> +#include <asm/arch/k3-ddr.h>
>   
>   #include "../common/fdt_ops.h"
>   
> @@ -20,15 +21,17 @@ int board_init(void)
>   	return 0;
>   }
>   
> -int dram_init(void)
> +#if defined(CONFIG_XPL_BUILD)
> +void spl_perform_fixups(struct spl_image_info *spl_image)
>   {
> -	return fdtdec_setup_mem_size_base();
> -}
> -
> -int dram_init_banksize(void)
> -{
> -	return fdtdec_setup_memory_banksize();
> +	if (IS_ENABLED(CONFIG_K3_DDRSS)) {
> +		if (IS_ENABLED(CONFIG_K3_INLINE_ECC))
> +			fixup_ddr_driver_for_ecc(spl_image);
> +	} else {
> +		fixup_memory_node(spl_image);
> +	}
>   }
> +#endif
>   
>   #ifdef CONFIG_BOARD_LATE_INIT
>   int board_late_init(void)
> diff --git a/board/ti/am62px/evm.c b/board/ti/am62px/evm.c
> index 7362fa4520a3..75359fa1614c 100644
> --- a/board/ti/am62px/evm.c
> +++ b/board/ti/am62px/evm.c
> @@ -13,6 +13,7 @@
>   #include <env.h>
>   #include <fdt_support.h>
>   #include <spl.h>
> +#include <asm/arch/k3-ddr.h>
>   #include "../common/fdt_ops.h"
>   
>   struct efi_fw_image fw_images[] = {
> @@ -53,15 +54,17 @@ int board_init(void)
>   	return 0;
>   }
>   
> -int dram_init(void)
> +#if defined(CONFIG_XPL_BUILD)
> +void spl_perform_fixups(struct spl_image_info *spl_image)
>   {
> -	return fdtdec_setup_mem_size_base();
> -}
> -
> -int dram_init_banksize(void)
> -{
> -	return fdtdec_setup_memory_banksize();
> +	if (IS_ENABLED(CONFIG_K3_DDRSS)) {
> +		if (IS_ENABLED(CONFIG_K3_INLINE_ECC))
> +			fixup_ddr_driver_for_ecc(spl_image);
> +	} else {
> +		fixup_memory_node(spl_image);
> +	}
>   }
> +#endif
>   
>   #if IS_ENABLED(CONFIG_BOARD_LATE_INIT)
>   int board_late_init(void)
> diff --git a/board/ti/am62x/evm.c b/board/ti/am62x/evm.c
> index 9075df01cac6..279ceba95547 100644
> --- a/board/ti/am62x/evm.c
> +++ b/board/ti/am62x/evm.c
> @@ -20,6 +20,7 @@
>   #include <asm/io.h>
>   #include <asm/arch/hardware.h>
>   #include <dm/uclass.h>
> +#include <asm/arch/k3-ddr.h>
>   
>   #include "../common/fdt_ops.h"
>   
> @@ -86,11 +87,6 @@ int board_init(void)
>   	return 0;
>   }
>   
> -int dram_init(void)
> -{
> -	return fdtdec_setup_mem_size_base();
> -}
> -
>   #ifdef CONFIG_BOARD_LATE_INIT
>   int board_late_init(void)
>   {
> @@ -99,13 +95,7 @@ int board_late_init(void)
>   }
>   #endif
>   
> -int dram_init_banksize(void)
> -{
> -	return fdtdec_setup_memory_banksize();
> -}
> -
>   #if defined(CONFIG_XPL_BUILD)
> -
>   void spl_board_init(void)
>   {
>   	enable_caches();
> @@ -114,53 +104,14 @@ void spl_board_init(void)
>   
>   }
>   
> -#if defined(CONFIG_K3_AM64_DDRSS)
> -static void fixup_ddr_driver_for_ecc(struct spl_image_info *spl_image)
> -{
> -	struct udevice *dev;
> -	int ret;
> -
> -	dram_init_banksize();
> -
> -	ret = uclass_get_device(UCLASS_RAM, 0, &dev);
> -	if (ret)
> -		panic("Cannot get RAM device for ddr size fixup: %d\n", ret);
> -
> -	ret = k3_ddrss_ddr_fdt_fixup(dev, spl_image->fdt_addr, gd->bd);
> -	if (ret)
> -		printf("Error fixing up ddr node for ECC use! %d\n", ret);
> -}
> -#else
> -static void fixup_memory_node(struct spl_image_info *spl_image)
> -{
> -	u64 start[CONFIG_NR_DRAM_BANKS];
> -	u64 size[CONFIG_NR_DRAM_BANKS];
> -	int bank;
> -	int ret;
> -
> -	dram_init();
> -	dram_init_banksize();
> -
> -	for (bank = 0; bank < CONFIG_NR_DRAM_BANKS; bank++) {
> -		start[bank] =  gd->bd->bi_dram[bank].start;
> -		size[bank] = gd->bd->bi_dram[bank].size;
> -	}
> -
> -	/* dram_init functions use SPL fdt, and we must fixup u-boot fdt */
> -	ret = fdt_fixup_memory_banks(spl_image->fdt_addr, start, size,
> -				     CONFIG_NR_DRAM_BANKS);
> -	if (ret)
> -		printf("Error fixing up memory node! %d\n", ret);
> -}
> -#endif
> -
>   void spl_perform_fixups(struct spl_image_info *spl_image)
>   {
> -#if defined(CONFIG_K3_AM64_DDRSS)
> -	fixup_ddr_driver_for_ecc(spl_image);
> -#else
> -	fixup_memory_node(spl_image);
> -#endif
> +	if (IS_ENABLED(CONFIG_K3_DDRSS)) {
> +		if (IS_ENABLED(CONFIG_K3_INLINE_ECC))
> +			fixup_ddr_driver_for_ecc(spl_image);
> +	} else {
> +		fixup_memory_node(spl_image);
> +	}
>   }
>   #endif
>   
> diff --git a/board/ti/am64x/evm.c b/board/ti/am64x/evm.c
> index 00b8317d6bf9..6f7e1f828668 100644
> --- a/board/ti/am64x/evm.c
> +++ b/board/ti/am64x/evm.c
> @@ -15,6 +15,7 @@
>   #include <fdt_support.h>
>   #include <asm/arch/hardware.h>
>   #include <env.h>
> +#include <asm/arch/k3-ddr.h>
>   
>   #include "../common/board_detect.h"
>   #include "../common/fdt_ops.h"
> @@ -66,28 +67,6 @@ int board_init(void)
>   	return 0;
>   }
>   
> -int dram_init(void)
> -{
> -	s32 ret;
> -
> -	ret = fdtdec_setup_mem_size_base();
> -	if (ret)
> -		printf("Error setting up mem size and base. %d\n", ret);
> -
> -	return ret;
> -}
> -
> -int dram_init_banksize(void)
> -{
> -	s32 ret;
> -
> -	ret = fdtdec_setup_memory_banksize();
> -	if (ret)
> -		printf("Error setting up memory banksize. %d\n", ret);
> -
> -	return ret;
> -}
> -
>   #if defined(CONFIG_SPL_LOAD_FIT)
>   int board_fit_config_name_match(const char *name)
>   {
> @@ -132,52 +111,14 @@ static int fixup_usb_boot(const void *fdt_blob)
>   }
>   #endif
>   
> -#if defined(CONFIG_K3_AM64_DDRSS)
> -static void fixup_ddr_driver_for_ecc(struct spl_image_info *spl_image)
> -{
> -	struct udevice *dev;
> -	int ret;
> -
> -	dram_init_banksize();
> -
> -	ret = uclass_get_device(UCLASS_RAM, 0, &dev);
> -	if (ret)
> -		panic("Cannot get RAM device for ddr size fixup: %d\n", ret);
> -
> -	ret = k3_ddrss_ddr_fdt_fixup(dev, spl_image->fdt_addr, gd->bd);
> -	if (ret)
> -		printf("Error fixing up ddr node for ECC use! %d\n", ret);
> -}
> -#else
> -static void fixup_memory_node(struct spl_image_info *spl_image)
> -{
> -	u64 start[CONFIG_NR_DRAM_BANKS];
> -	u64 size[CONFIG_NR_DRAM_BANKS];
> -	int bank;
> -	int ret;
> -
> -	dram_init();
> -	dram_init_banksize();
> -
> -	for (bank = 0; bank < CONFIG_NR_DRAM_BANKS; bank++) {
> -		start[bank] =  gd->bd->bi_dram[bank].start;
> -		size[bank] = gd->bd->bi_dram[bank].size;
> -	}
> -
> -	/* dram_init functions use SPL fdt, and we must fixup u-boot fdt */
> -	ret = fdt_fixup_memory_banks(spl_image->fdt_addr, start, size, CONFIG_NR_DRAM_BANKS);
> -	if (ret)
> -		printf("Error fixing up memory node! %d\n", ret);
> -}
> -#endif
> -
>   void spl_perform_fixups(struct spl_image_info *spl_image)
>   {
> -#if defined(CONFIG_K3_AM64_DDRSS)
> -	fixup_ddr_driver_for_ecc(spl_image);
> -#else
> -	fixup_memory_node(spl_image);
> -#endif
> +	if (IS_ENABLED(CONFIG_K3_DDRSS)) {
> +		if (IS_ENABLED(CONFIG_K3_INLINE_ECC))
> +			fixup_ddr_driver_for_ecc(spl_image);
> +	} else {
> +		fixup_memory_node(spl_image);
> +	}
>   
>   #if CONFIG_IS_ENABLED(USB_STORAGE)
>   	fixup_usb_boot(spl_image->fdt_addr);
> diff --git a/board/ti/am65x/evm.c b/board/ti/am65x/evm.c
> index 07073a5940b1..6658794a1375 100644
> --- a/board/ti/am65x/evm.c
> +++ b/board/ti/am65x/evm.c
> @@ -20,6 +20,7 @@
>   #include <env.h>
>   #include <spl.h>
>   #include <linux/printk.h>
> +#include <asm/arch/k3-ddr.h>
>   
>   #include "../common/board_detect.h"
>   #include "../common/fdt_ops.h"
> @@ -49,17 +50,6 @@ int board_init(void)
>   	return 0;
>   }
>   
> -int dram_init(void)
> -{
> -#ifdef CONFIG_PHYS_64BIT
> -	gd->ram_size = 0x100000000;
> -#else
> -	gd->ram_size = 0x80000000;
> -#endif
> -
> -	return 0;
> -}
> -
>   phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
>   {
>   #ifdef CONFIG_PHYS_64BIT
> @@ -71,23 +61,6 @@ phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
>   	return gd->ram_top;
>   }
>   
> -int dram_init_banksize(void)
> -{
> -	/* Bank 0 declares the memory available in the DDR low region */
> -	gd->bd->bi_dram[0].start = 0x80000000;
> -	gd->bd->bi_dram[0].size = 0x80000000;
> -	gd->ram_size = 0x80000000;
> -
> -#ifdef CONFIG_PHYS_64BIT
> -	/* Bank 1 declares the memory available in the DDR high region */
> -	gd->bd->bi_dram[1].start = 0x880000000;
> -	gd->bd->bi_dram[1].size = 0x80000000;
> -	gd->ram_size = 0x100000000;
> -#endif
> -
> -	return 0;
> -}
> -
>   #ifdef CONFIG_SPL_LOAD_FIT
>   int board_fit_config_name_match(const char *name)
>   {
> diff --git a/board/ti/common/Makefile b/board/ti/common/Makefile
> index 5ac361ba7fcf..caf6b9fa8c14 100644
> --- a/board/ti/common/Makefile
> +++ b/board/ti/common/Makefile
> @@ -4,3 +4,4 @@
>   obj-${CONFIG_TI_I2C_BOARD_DETECT} += board_detect.o
>   obj-${CONFIG_CMD_EXTENSION} += cape_detect.o
>   obj-${CONFIG_OF_LIBFDT} += fdt_ops.o
> +obj-${CONFIG_ARCH_K3} += k3-ddr.o
> diff --git a/board/ti/common/k3-ddr.c b/board/ti/common/k3-ddr.c
> new file mode 100644
> index 000000000000..a8425da8de5c
> --- /dev/null
> +++ b/board/ti/common/k3-ddr.c
> @@ -0,0 +1,33 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2024, Texas Instruments Incorporated - https://www.ti.com/
> + */
> +
> +#include <fdt_support.h>
> +#include <dm/uclass.h>
> +#include <k3-ddrss.h>
> +#include <spl.h>
> +
> +#include "k3-ddr.h"
> +
> +int dram_init(void)
> +{
> +	s32 ret;
> +
> +	ret = fdtdec_setup_mem_size_base_lowest();
> +	if (ret)
> +		printf("Error setting up mem size and base. %d\n", ret);
> +
> +	return ret;
> +}
> +
> +int dram_init_banksize(void)
> +{
> +	s32 ret;
> +
> +	ret = fdtdec_setup_memory_banksize();
> +	if (ret)
> +		printf("Error setting up memory banksize. %d\n", ret);
> +
> +	return ret;
> +}
> diff --git a/board/ti/common/k3-ddr.h b/board/ti/common/k3-ddr.h
> new file mode 100644
> index 000000000000..737d45e2e509
> --- /dev/null
> +++ b/board/ti/common/k3-ddr.h
> @@ -0,0 +1,12 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright (C) 2024, Texas Instruments Incorporated - https://www.ti.com/
> + */
> +
> +#ifndef __K3_DDR_INIT_H
> +#define __K3_DDR_INIT_H
> +
> +int dram_init(void);
> +int dram_init_banksize(void);
> +
> +#endif /* __K3_DDR_INIT_H */
> diff --git a/board/ti/j721e/evm.c b/board/ti/j721e/evm.c
> index 6221be9dcff8..4b5b9dded7b0 100644
> --- a/board/ti/j721e/evm.c
> +++ b/board/ti/j721e/evm.c
> @@ -15,6 +15,7 @@
>   #include <asm/gpio.h>
>   #include <spl.h>
>   #include <dm.h>
> +#include <asm/arch/k3-ddr.h>
>   
>   #include "../common/board_detect.h"
>   #include "../common/fdt_ops.h"
> @@ -77,17 +78,6 @@ int board_init(void)
>   	return 0;
>   }
>   
> -int dram_init(void)
> -{
> -#ifdef CONFIG_PHYS_64BIT
> -	gd->ram_size = 0x100000000;
> -#else
> -	gd->ram_size = 0x80000000;
> -#endif
> -
> -	return 0;
> -}
> -
>   phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
>   {
>   #ifdef CONFIG_PHYS_64BIT
> @@ -99,23 +89,6 @@ phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
>   	return gd->ram_top;
>   }
>   
> -int dram_init_banksize(void)
> -{
> -	/* Bank 0 declares the memory available in the DDR low region */
> -	gd->bd->bi_dram[0].start = 0x80000000;
> -	gd->bd->bi_dram[0].size = 0x80000000;
> -	gd->ram_size = 0x80000000;
> -
> -#ifdef CONFIG_PHYS_64BIT
> -	/* Bank 1 declares the memory available in the DDR high region */
> -	gd->bd->bi_dram[1].start = 0x880000000;
> -	gd->bd->bi_dram[1].size = 0x80000000;
> -	gd->ram_size = 0x100000000;
> -#endif
> -
> -	return 0;
> -}
> -
>   #ifdef CONFIG_SPL_LOAD_FIT
>   int board_fit_config_name_match(const char *name)
>   {
> diff --git a/board/ti/j721s2/evm.c b/board/ti/j721s2/evm.c
> index 2cfeb3bec6c2..1b5ad19df7f4 100644
> --- a/board/ti/j721s2/evm.c
> +++ b/board/ti/j721s2/evm.c
> @@ -21,6 +21,7 @@
>   #include <dm.h>
>   #include <dm/uclass-internal.h>
>   #include <dm/root.h>
> +#include <asm/arch/k3-ddr.h>
>   
>   #include "../common/board_detect.h"
>   #include "../common/fdt_ops.h"
> @@ -32,17 +33,6 @@ int board_init(void)
>   	return 0;
>   }
>   
> -int dram_init(void)
> -{
> -#ifdef CONFIG_PHYS_64BIT
> -	gd->ram_size = 0x100000000;
> -#else
> -	gd->ram_size = 0x80000000;
> -#endif
> -
> -	return 0;
> -}
> -
>   phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
>   {
>   #ifdef CONFIG_PHYS_64BIT
> @@ -54,22 +44,17 @@ phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
>   	return gd->ram_top;
>   }
>   
> -int dram_init_banksize(void)
> +#if defined(CONFIG_XPL_BUILD)
> +void spl_perform_fixups(struct spl_image_info *spl_image)
>   {
> -	/* Bank 0 declares the memory available in the DDR low region */
> -	gd->bd->bi_dram[0].start = 0x80000000;
> -	gd->bd->bi_dram[0].size = 0x7fffffff;
> -	gd->ram_size = 0x80000000;
> -
> -#ifdef CONFIG_PHYS_64BIT
> -	/* Bank 1 declares the memory available in the DDR high region */
> -	gd->bd->bi_dram[1].start = 0x880000000;
> -	gd->bd->bi_dram[1].size = 0x37fffffff;
> -	gd->ram_size = 0x400000000;
> -#endif
> -
> -	return 0;
> +	if (IS_ENABLED(CONFIG_K3_DDRSS)) {
> +		if (IS_ENABLED(CONFIG_K3_INLINE_ECC))
> +			fixup_ddr_driver_for_ecc(spl_image);
> +	} else {
> +		fixup_memory_node(spl_image);
> +	}
>   }
> +#endif
>   
>   #ifdef CONFIG_TI_I2C_BOARD_DETECT
>   /*
> diff --git a/board/ti/j784s4/evm.c b/board/ti/j784s4/evm.c
> index 548dbd5925df..d317f3eccbba 100644
> --- a/board/ti/j784s4/evm.c
> +++ b/board/ti/j784s4/evm.c
> @@ -10,6 +10,7 @@
>   #include <efi_loader.h>
>   #include <init.h>
>   #include <spl.h>
> +#include <asm/arch/k3-ddr.h>
>   #include "../common/fdt_ops.h"
>   
>   DECLARE_GLOBAL_DATA_PTR;
> @@ -52,15 +53,17 @@ int board_init(void)
>   	return 0;
>   }
>   
> -int dram_init(void)
> +#if defined(CONFIG_XPL_BUILD)
> +void spl_perform_fixups(struct spl_image_info *spl_image)
>   {
> -	return fdtdec_setup_mem_size_base();
> -}
> -
> -int dram_init_banksize(void)
> -{
> -	return fdtdec_setup_memory_banksize();
> +	if (IS_ENABLED(CONFIG_K3_DDRSS)) {
> +		if (IS_ENABLED(CONFIG_K3_INLINE_ECC))
> +			fixup_ddr_driver_for_ecc(spl_image);
> +	} else {
> +		fixup_memory_node(spl_image);
> +	}
>   }
> +#endif
>   
>   #ifdef CONFIG_BOARD_LATE_INIT
>   int board_late_init(void)

