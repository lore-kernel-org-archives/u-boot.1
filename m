Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 372E5C27C4F
	for <u-boot@archiver.kernel.org>; Fri, 21 Jun 2024 08:44:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 828AE87FF0;
	Fri, 21 Jun 2024 10:44:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="FeVCnkQf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C69387FBC; Fri, 21 Jun 2024 10:44:40 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 17F6387FBC
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 10:44:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HmJ1XzDqvjXfezZzEuipVUznOPboOP6Zu6vL5ixzpNXZ6FNen3C8hsYg6lvw7DR3gk9MS6E1ffA7w4kHPxlNKZjqjv+1B8zIQhsdFa6Giaoi3+8AXT7XQy5H3wUUuS74qP3WjiKE5Xi+bjQOnx8KHrBVhKZ36pLxEGPbiDvoGmL+rSwEhavyvYdlLH7clhUKIdqB4ngCnozHba3BuYJ5MX5N2HXD82lH2owSd+JNvsNMM0oVEjGGyFaLbh0R7hiuwbPH/WlamYdtvgsolEouz2k2CEqGkWJ6HZHx1OBtNl9ZSWhSCddGU74Rid1GOgEzXeZnE6d1nF+3nKpHfyfHcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kkT0gqxVGfysrRO7FovY7WaNkJGKPVDUsRNRGWnjoKk=;
 b=hD9gaCNRQNqBiT/mDK7crHTNUMfnZRtyzHuKSFLF9GkhS8d3zlPgBgXuKLiXija2wUtVO8tHDbL2OdnQ5P/2Diu65hBQ8g3YGIXG1Y68qnMm8PHUEeqYZDT6OmSmYEi0PQxtj0m3hNPO576hzEGByCaZxHSBgqRSrqRcdZkeozI8evZMvlx7KnHg3q0j+U7fEEWrVkOfKrbnpEdxf4aH2AMejcg0JG6HCDpN7i285fccLbje9cWMNVL7HOsGCIE77Y6sDQ71qNf2rbB8yEMzdy9ch+5Bz007my0RBwU85pmvazzDNu7RjIisE/9BFZqIlGpZHrLJniuOWPqZviaL0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kkT0gqxVGfysrRO7FovY7WaNkJGKPVDUsRNRGWnjoKk=;
 b=FeVCnkQfyjKolJBtVQ+jSR+aC0chxL6Pwz9M7sWvZZobt+1bVdCS0l6xGoLclgpJ06DxvjLul5GjXQ+jtl1zZz8Uw5Nis/uUhHVDUXYqbl6Mvt3cTvYcN0jbRpnpRtSgH6BJM6l65TBobOoXeb8iddCtZk4EazYaFWocSKPTSfE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com (2603:10a6:102:c4::9)
 by AS4PR04MB9433.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Fri, 21 Jun
 2024 08:44:35 +0000
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af]) by PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af%4]) with mapi id 15.20.7698.020; Fri, 21 Jun 2024
 08:44:35 +0000
Message-ID: <6d80a505-3374-406e-ab1f-959a1794cae1@cherry.de>
Date: Fri, 21 Jun 2024 10:44:32 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Request for hosting a boot-firmware repository in u-boot git
 (denx and GitHub)
To: Peter Robinson <pbrobinson@gmail.com>
Cc: Nishanth Menon <nm@ti.com>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Enric Balletbo i Serra <eballetb@redhat.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Josh Boyer <jwboyer@redhat.com>,
 Kever Yang <kever.yang@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>
References: <20240620213539.ftmjhphypssxp5n4@desolate>
 <a7cca1a2-5ba8-487b-9fce-1553da93c56e@cherry.de>
 <CALeDE9Ojza7T3gMxBJP5L0s0CA6CfxeO_6AAvnoUKDevG+_eBw@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CALeDE9Ojza7T3gMxBJP5L0s0CA6CfxeO_6AAvnoUKDevG+_eBw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: WA2P291CA0036.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::9) To PA4PR04MB7982.eurprd04.prod.outlook.com
 (2603:10a6:102:c4::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7982:EE_|AS4PR04MB9433:EE_
X-MS-Office365-Filtering-Correlation-Id: a459ac2b-cbe5-4b51-fb90-08dc91ce609b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|366013|7416011|376011;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U2JvYUJMTjRPQzdPQ3kzN1hQcW9CcXdELzhmaHBNMmdob1FXUStTM0llUXgw?=
 =?utf-8?B?L3RtT3RRQnpqdXpjeDNYcmpnZE1kQWk4aU5wNTlrVVZWdGhZSjM2VUt2YXJN?=
 =?utf-8?B?bHpOKzhVQzFrVGMxMDc5aUw2dG5xd1B1b0JHbzcvR205cjU1OUVwU0ZFelJz?=
 =?utf-8?B?YlkyUDFRdXltYnh1UkJGTEw4VitBU0JGV2JxTVkxbkJZN0Y5R2NaQ0FkRkQy?=
 =?utf-8?B?Y1hTY2NhNnBXbitQZlp6b2dxbFRvVERJL2xMYXgvbVNneU1acFVuRVU0cHBk?=
 =?utf-8?B?ZWEybkkrMDU0bnVwaGM0aXZIalZJUDJsRkZXbHYvajJkSE1TTWx2b2hXUlBK?=
 =?utf-8?B?NnhjWjY0QU15Szk0MldLcGZENVg0Um85YlYrYVRMSTR0YnNxVzg0S1lvU3Q2?=
 =?utf-8?B?MkRXamFVbEhVNTkxZDc0Rk9VVkZyZ29XNDY0VWJxbUhXd1NhcGwxT3EzMzBq?=
 =?utf-8?B?K1pVTGR4ZFNWcVg2NHlvWCtGZlVVcWZZc1JFeDQzRlcxTWZOZzdpd25OWWVr?=
 =?utf-8?B?K0pvMnI0WG9hZWU1VS9VMmhsVmN0TU85bEZHcFZSaERkK0x5Y2VmblpBaDdW?=
 =?utf-8?B?QnprYnI5ektQRSt2dXliWEhaODEwUUx6YlVSRVd5Uk50N3BDTEY2QkVIcWtP?=
 =?utf-8?B?eGxHSXNsYkg4bzgrdTNKdURpdlU1MjdLMjVzb1JHeW9jQWpHRy9sSEtVQ2Na?=
 =?utf-8?B?dmdkUFAzWExycGN5Z0Z4L3RJb2xPSjcrSlp0bGUyMVpsUk1oVXZCRHova0ZR?=
 =?utf-8?B?YmZYNC9oZEZKTTlsYm14K3FLWDVqNHE4NFBWNkRxSHl6YWRZbnNHbVh2RmlQ?=
 =?utf-8?B?OGFQZ1ZKdy9pTFR5ZGhQdmxhL0NYZzdiYmpiZS9uTDUzUVVTT292TkRlek5Q?=
 =?utf-8?B?R0VRd3BQSWVlaTJWOHUvVW5CZlh5NUpCQVNOZ3ZmM3p3TWRoeDJSMlVLVzRI?=
 =?utf-8?B?dVFvcDE1M253NEdNQnFpaDlZUkJOZTNvS0pUOVFzVWVtcE94blFGekxVSC9X?=
 =?utf-8?B?MFYrOVlvNUVRQ29mY0hyV01NUW05VTlWdDkwVjErdm5vUGtnYXZoaExXampQ?=
 =?utf-8?B?aVZiQ0JFMkZNUEU1amxwcmVNbVY3dXJEWERJc3ltYVh0TVRaY3dnU3B1YkFn?=
 =?utf-8?B?dWt0WnFDTGpPK0s1WjRpdjVTMjJZUyt5SWFGa0JZWmZwWVJScTFyb2RLa0xw?=
 =?utf-8?B?dWZxZjdvTFlHKzNkbjArMStVc2NramFSd1MvTjZ6WEFXTGZQaVI3cTBlcGtJ?=
 =?utf-8?B?YXV6UnhsVjZYSHBwNU51RDNoOHJPNUI0NFMxTHNLbWFPVER3Wi9maVpuaW1q?=
 =?utf-8?B?MkVTYTB1czltb1R5MGpMRDZDZ2FjVDdTcS9sNjVvcTM4ZktweVdEQXdUZExs?=
 =?utf-8?B?aUR1ZTRzOUFDVy9tZEk5aHk3cW12dHJEZmFzcnk2OElkSnBrUllQeE5XUkZS?=
 =?utf-8?B?UkxvS29udmo5ejFWbk8vMGUxUEN2dUlBejE0RWt1NWUrUCtuMlE5b1l5K2hM?=
 =?utf-8?B?ZmhsUUNvSVpNTmtyZC9jdWVuT3hsR3ZwcDc2M1hGZUpacW9xemVGL2ZDMm1C?=
 =?utf-8?B?L0YvMGxNU0FZRzBzOFNTWXRjQ3lkQjkvQVVSQnhxWTZsZzNydmhaRHFtSGVX?=
 =?utf-8?B?Z2w4U1psdkRJR3I1R3FPVU9kUXF1MjhwMTRnMDl1M1c2U1dBZXNmeXJRZDFK?=
 =?utf-8?Q?QDkFwesSOA5hiP+FQ4T0?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB7982.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(1800799021)(366013)(7416011)(376011); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eFJObFNJUjArblpwRG5QT2U2NkpXazNYNDMzRitEdjVIeHhJRG81NHptNWgx?=
 =?utf-8?B?VzdqWTJyTnYwNFI3U0ZheXFHanFtS2tlVGUybHY4bEtpMzRJR3NXa0lCQ3lm?=
 =?utf-8?B?TWVlWVFMdnBJRUdoNURqaVBjSmhsQjNNVm8xekdFbm9Fd3JpalZ6TndDWStt?=
 =?utf-8?B?dENjVkpFMUVqMC9GU0dlRTNXeFNYQ3dUNnJuS0taa3VGdjdYK0I5ZkVmdGFl?=
 =?utf-8?B?dnk3clpWSGM3SHZmQ2hyWjdSdENOZmUvbVg4YUtDSmgwdHIrRGY0LzhTRTVu?=
 =?utf-8?B?WWxCMkEwSnFNTmQ0VDlxZ2xXWlFNcG1sWllIOStJbkloRUdwNHFGazFoOGxN?=
 =?utf-8?B?MnB4N1J1d1M0RjZvNVhxR1VISUdka2phMUVGS09tWmtDTUpXd04zR2ZSeXlN?=
 =?utf-8?B?UHhYWlNiNWFPL1p2Rm9xUHAwQU11ZERYU05SdW01Z2VyWjdRMUVUMXlhRUFw?=
 =?utf-8?B?WVRhRXdMSG1UZnFYOU8rd1FjamRqZEgxOUMzek9Bd2YzeE5oblR6alpXTlV5?=
 =?utf-8?B?ZGFwSXlsWG9yYUs2cE5oKzRXUXdrcWwzSVRCRTFuSlRkaXRPWU5vZHpZYWwz?=
 =?utf-8?B?dXp5anE1ZllTVXg3Y29uOTdnZjZWL0VKZnFzSDN0OHhDVHpxWmcrZzFGN2V4?=
 =?utf-8?B?c2NtRHVuVUk3eXpjNnpJdEV2RWFzcmYrVWs3VVNpdGFiQ1FpdzliaEg5N3U3?=
 =?utf-8?B?VjhmR0kyWFZHMElwcFFXSzRRWFJtOHdSVTcwVTdlUnRIbEx6WlVUYnpiUFpv?=
 =?utf-8?B?OEN4NDRtSWZTb1BHU0ova0hyK1FFZjA2cEdFRzBLT3N4czZyQ2grVDlLS3Jm?=
 =?utf-8?B?SGlGekdIR2JRZ3ZQKzJtTDY3QlhPcWszK0pCWWFQTURVVytVYVBXYVVjTFNp?=
 =?utf-8?B?T2d6bmppYXRyd3p6bjVmWVF0VTFjMkh5ZU55QStQMHRteUV1QWFEMkpZR1Na?=
 =?utf-8?B?SkdHb2ZLOWVLay90SlJlSGt6cHNDTnh1TzhEM3BxSjdHYXVla0lpazV4U0ha?=
 =?utf-8?B?bVovNnlQOHRLaFRSdVFqLzdXa3dpenJYek5KTERwNzc0SEd4R25EcTFMU1J5?=
 =?utf-8?B?OVhnWWZ5d05rak1Ba1lVd1ZDZnUzbWpCME1EMkJiM3BUdkZobnJYK1N4OUR4?=
 =?utf-8?B?NmJkRzVZdFlBSGVCMTN4MVZIbzlHUEg3d0M3dG5WLzZZK3Rwd1hzQTRNS1Nu?=
 =?utf-8?B?M05CYmxmOHc0UGJtcE00ZllKM2xJYjY0TTRxUjZDUjkyai9LZ09rQmQ1aUtw?=
 =?utf-8?B?SksyNG5NU2NGdUlWUkpySjdSWlBwTGQxR3lWYUhaeWRrUjM1Q1M0TDIxaHBy?=
 =?utf-8?B?N3E2QjdGb0M3U2ZwM0Zyc3ArWVdCN0lhTmxDcGZ3MWlIUE5QUy96SGpkcjJy?=
 =?utf-8?B?dCtwQzFOZ2Jpak94MFEyNDBBOGd4QzZTN0taS0J6TjJIOStsU2ZBUTc0aUpy?=
 =?utf-8?B?SjhZRjUyTmhuVi9Ec3psUFYrVjIrWVJoWTBkMFI3VWkva0ZUeko0NE5oT1Rk?=
 =?utf-8?B?dHVHb05QZnVzVG8wbTZoVWFnU3N3aERuQTBlS1lrbkplUUJpRjlEMVJReHpk?=
 =?utf-8?B?bm9nL1c3dUlFQ1pkZ1dnaGxlaWllSlVZWnAycHZxMXpVZThqUUFaZFROMUFB?=
 =?utf-8?B?SXVnbU5pNHh6MFFYU210Tm9RWDl6RDVnQVJGUk1EQitnZjFTRG13VStRcURK?=
 =?utf-8?B?MG55UWVzM0tZdVpTSEY3K1I5UjZRVmZ4cTJjU0VkR3NxaUVERmFKaHZ4VVJp?=
 =?utf-8?B?WG1NZkozSFFmdnpzNHV1VUZZa0wxWW9KeXpSUGhyd3pIaGIyaHFCc3JBZi9h?=
 =?utf-8?B?NGFueUNqTnlqbEpVbTFDNFRScDRTZGdJZlFzVEtITXkxUHRVL21HWktodyto?=
 =?utf-8?B?M0ZzREQvR3JWeE5SaFBFYUV5SzlaL1U0QzFZR2RRbXpmbDhlcm43clVRcnV1?=
 =?utf-8?B?YlpkeTkwa3ora2ViSjNJbDJrYkV5eVVqZ1ptSmYwRmJCZXN6cFNTOEM3a3lN?=
 =?utf-8?B?dWR3Z2FtV0EzSEJ2T1FFUVVpN0hRZEM5ZGh0UVdFbXNrbnRLWWtpQ2pSNi9z?=
 =?utf-8?B?MmtwTTBOUUdsNTdkRDQ2eEJXQUtvdnU2cFVCT3Bpbi9yTkRRZi82T3M2dDdZ?=
 =?utf-8?B?MmNpU0VnN3ZacHQ0SkZJaFR5NDFZWG5ucURyS3R0cXVubEtkRFhGZmtqcXJO?=
 =?utf-8?B?WVE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: a459ac2b-cbe5-4b51-fb90-08dc91ce609b
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7982.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 08:44:35.1426 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LOizlO/QsgWem56xT5FjdrxN428Q5S6Lh55B1laf+qlb4wfTbPOKPzA62IDV+bTP391CibN2n+CBUjPLXbhidQWyke8VyV6lk5s537Uf4hw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9433
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

Hi Peter,

On 6/21/24 12:29 AM, Peter Robinson wrote:
> On Thu, 20 Jun 2024 at 23:22, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>>
>> Hi Nishanth Menon,
>>
>> +Cc Kever from Rockchip as maintainer of the arch in U-Boot
>> +Cc Heiko as maintainer of many things Rockchip in many projects
>>
>> On 6/20/24 11:35 PM, Nishanth Menon wrote:
>>> Hi Team,
>>>
>>> We have briefly discussed this topic on IRC[1]. I would like to
>>> propose a new boot-firmware repository similar to the Linux-firmware
>>> repository under the aegis of u-boot hosting.
>>>
>>> In addition to TI, it looks like some NXP[2] and Rockchip[3]
>>> platforms seem to require additional closed-source/open-source
>>> binaries to have a complete bootable image. Distribution rights and
>>> locations of these binaries are challenging, and there needs to be a
>>> standard for how and where they are hosted for end users.
>>>
>>> Further, looking ahead to future architectures:
>>> * IP firmware: More and more IP vendors are embedding their own
>>>     "specialized controllers" and require firmware for the operation
>>>     (similar to Rockchip's DDR controller, I guess),
>>> * boot stage firmware: Additional stages of the boot process involve
>>>     vendor intermediate firmware, such as power configuration.
>>> * Security enclave binaries: While I see a few folks trying to have an
>>>     open-source s/w architecture, many PKA and PQC systems still require
>>>     prop binaries for IP reasons.
>>>
>>> NOTE: I am not judging any company(including TI) for reasons why some
>>> firmware is proprietary, but I hate to have the end users and other
>>> system (distro) maintainers have to deal with hell trying to make the
>>> life of end users easy to live with.
>>>
>>> In the case of TI's K3 architecture devices, we have two binary blobs
>>> that are critical for the boot process.
>>>
>>> 1. TIFS Firmware / DMSC firmware[4]—This is the security enclave
>>>     firmware. It is often encrypted, and sources are not public (due to
>>>     various business/regulatory reasons).
>>> 2. DM Firmware[5] - There is a source in public in some cases and
>>>     binary only in others - essentially limited function binary to be
>>>     put up in the device management uC. In cases where the source is
>>>     available, the build procedure is, in my personal opinion, pretty
>>>     arcane, and even though in theory it is practical, in practice, not
>>>     friendly - efforts are going to simplify it, even probably integrate
>>>     it with a more opensource ecosystem, but that is talking "look at the
>>>     tea leaves" stuff.
>>> 3. Low Power Management (LPM) binaries: tifs stub: another encrypted
>>>     binary that gives the tifs system context restore logic before
>>>     retrieving tifs firmware and a corresponding DM restoration binary.
>>>
>>> All told, this is not unlike the situation that necessitated the
>>> creation of a Linux firmware repository.
>>>
>>> Options that I see:
>>>
>>> 1. Let the status quo be - SoC vendors maintain random locations and
>>>     random rules to maintain boot firmware.
>>> 2. Ask Linux-firmware to host the binaries in a single canonical
>>>     location
>>> 3. Host a boot-firmware repository - u-boot repo may be the more
>>>     logical location.
>>>
>>> * (1) isn't the correct answer.
>>>
>>> * (2) Though I haven't seen any policy from the Linux-firmware
>>>     community mandating anything of the form, the binaries we are talking
>>>     of may not belong to Linux-firmware as they aren't strictly speaking
>>>     something Linux kernel will load (since the bootloader has that
>>>     responsibility), and in some cases may not even directly talk to
>>>     (security enclave or DDR firmware stuff). I am adding Josh to this
>>>     mail to see if he has any opinions on the topic (but keeping
>>>     from cross posting on linux-firmware list, unless folks feel it is
>>>     OK).
>>>
>>> On (3):
>>> Proposal:
>>>
>>> * Create a boot firmware repository in Denx and/or GitHub (if
>>>     financials are a hurdle, I hope we can solve it as a community).
>>> * Limit binaries only to those consumed part of the u-boot scope.
>>>
>>> * Limit binaries only to those that do not have an opensource project
>>>     (Trusted Firmware-A/M, OP-TEE, etc..) or depend entirely on vendor
>>>     source or are binary only in nature (subject to licensing terms below)
>>
>> FYI, on Rockchip, there are currently three blobs **we** use on Aarch64
>> (i have only worked with RK3399, PX30 and RK3588, so they may be more :) ):
>>    - DDR bin/TPL no clue what this actually is under the hood. I think
>> most SoCs do not get an open-source DDR init in U-Boot sadly, therefore
>> mandatory until it isn't,
>>    - BL31, mandatory on Aarch64, a blob that is an old TF-A (v2.2/2.3 I
>> don't remember anymore). I don't know the state for all SoCs, but I can
>> say the RK3399, PX30 and RK3568 have an open one, RK3588 is one the way
>> (but considering the RK3568 and RK3588 were released years ago, BL31
>> blob is mandatory for a while),
> 
> rk3568 is now upstream, there was a PR upstream for this for some
> time, similar to rk3588, albeit not as long as rk56x. In some cases
> the issue here is the speed of review of upstream ATF. I don't think
> that means it should go into something like this.
> 

If the BL31 blob doesn't go into boot-firmware, I don't see the benefit 
of boot-firmware for Rockchip platforms to be honest. Instead of telling 
people to get their firmware from github.com/rockchip-linux/rkbin we'll 
tell them to get one from rkbin and the other from boot-firmware. And I 
have a feeling that if that's how it'll go that the vendor will just not 
care about boot-firmware as they would anyway need to keep updating 
rkbin as well.

It doesn't matter whose fault it is for not being upstreamed earlier, 
the fact is, we still don't have a **merged** open-source BL31 for 
RK3588 2 and half years after the Rock5B from Radxa was announced. So in 
that whole timeframe, we have to work with blobs (or maintain your own 
forked TF-A whenever patches are posted and hope it works well enough).

[...]

>> FYI, the DDR bin is printing stuff on the console, so we had to modify
>> it (with a tool from Rockchip) to remove the gibberish breaking the
>> terminal by setting the appropriate controller, mux and baudrate (for
>> our products, there's no one size fits all :) ). The question is how to
>> handle this since we cannot realistically store every possible
>> permutation of that binary for each UART controller, mux of UART
>> controller and baudrate (the only parameters **we** modify, but there
>> are tons of others).
> 
> I think those sort of things should be mostly quiet TBH.

Mostly != fully. The console doesn't break consistently so I assume that 
if it even prints a tiny bit of info it would still be able to break 
stuff. I assume we could have binman run some logic to replace the uart 
controller, mux and baudrate. Not sure we want that but we could.

Also, the DDR bin is passing the console info to the BL31 binary through 
ATAGS, so if you don't fix the DDR bin baudrate, controller and mux, the 
BL31 will also not be fixed.

Cheers,
Quentin
