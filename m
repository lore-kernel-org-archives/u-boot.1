Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 963B2C4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 08:15:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C61D86EF2;
	Mon,  6 Nov 2023 09:15:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="Ha9JAXH7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4604886EBA; Mon,  6 Nov 2023 09:15:43 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2070c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7d00::70c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E60386E05
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 09:15:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JCJx/ti61Ad8lW98bD0FwEMz41hHPwDucj3uytuORQ7Oj3OaKjdCMih9RQs3kS3q8VgA/rvvKx5DKtjiCInO4q51WIFBe8cxT9FB303rHgs2nkzy7g/LXV+1abGSZMLzmPAnMuRutk5y2BOU4bntz5GVEg7PkxBIrZkZU52nfyN7izvKK5cfrZDyqz1KCffH3THfSGePtyrFMmme1jR3SlhXfZwu43bSvadpGMIlQw5Raq5W68wnBjR4gds5X729woMuWqKaN6be2ZAy1Rev6ywNUzKtnxoNNAwZm04EaU8oZ0XBrRTFi8ZI8cP1l9pkKOOmQ8hFn1faUrM73I8Xog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vH+b+f/3ssmnRs22+XEDIWmQ1zXFiHZvfsYazIrVP80=;
 b=ekMs76dYqSXJL3h5iiSqwvUe0qveok/2tDCxpjF0zsaLeOPp1QU6o47K7qAJu4xCy12DvadN3OnJXGLq1hSMk3E8JSM0zEA0kW5pylluVRbmadBA0m/Zmk/Kpv9kAarG1VzMZVgDzgKFcdaj9gfnsj1K/qGAj27wGCGTSJVtVDTFmN1lri6Wlkbj8bmbaGudQ3Y0Axpr9KwBQf2q2WpD/hsHRGI5qRtGHFR8RiilLhkWo0WkaTomOv80AD3wWtaxxHbz1bWj4kILnNOz/DAbJMNx+9fLTcxO0d6hjuNQb8M7Vp6JgP8SaXWWTeAEMasFvQIYZdoaDEoueqSjk5pa6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vH+b+f/3ssmnRs22+XEDIWmQ1zXFiHZvfsYazIrVP80=;
 b=Ha9JAXH7T93gTWlj40juJX1zUe3g+YGwYLUI+c4awvrO9vWylfoS57OQwPIRJT8xewH9IA6uzxhxYoVx4W0zzpynVSy2e3hi4LNtHzdTmJN27S0AHhnbb3kBF3q/7Wi3c27rk1Mkw1nDwu2GYPllIoh+x1oSdrcNV/7p4Dr2H1Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by GV1PR10MB6683.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:85::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Mon, 6 Nov
 2023 08:15:37 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3d76:c11a:5c3f:3245]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3d76:c11a:5c3f:3245%5]) with mapi id 15.20.6954.027; Mon, 6 Nov 2023
 08:15:36 +0000
Message-ID: <a5dee47d-409b-49ad-b0f2-f8d49669958d@prevas.dk>
Date: Mon, 6 Nov 2023 09:15:34 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] mkimage: also honour -B even without external data
Content-Language: en-US, da
To: Simon Glass <sjg@chromium.org>, Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>
References: <20230919113705.109639-1-rasmus.villemoes@prevas.dk>
 <20230919113705.109639-2-rasmus.villemoes@prevas.dk>
 <6ac71b7e-d84e-10d5-e500-0d54e5d6c191@gmail.com>
 <3fd4d611-891a-fc3d-7385-c2d621cf2eac@prevas.dk>
 <8d3ef056-1d72-727f-f158-f034c34d5786@gmail.com>
 <CAPnjgZ1kFjsZ96fkOu9KgOMiSG8W_YcO7ERJcRtdD1OOkPYY5A@mail.gmail.com>
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
In-Reply-To: <CAPnjgZ1kFjsZ96fkOu9KgOMiSG8W_YcO7ERJcRtdD1OOkPYY5A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR02CA0134.eurprd02.prod.outlook.com
 (2603:10a6:20b:28c::31) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|GV1PR10MB6683:EE_
X-MS-Office365-Filtering-Correlation-Id: abf4a731-fe08-4351-ed67-08dbdea08e47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aQkKEzTFkNNDf2RaoiA/sXC5e9o2YFuCcZdUwSkj3oDlDwFuxYWnxeV8OdXUfkVInlG7LD26siKAeqMs85EbJbW71G9vDifuXirsunpYmoqdtM9zkUgQBDZhXS+BK7xkwY5excFBRrYfI3jVw/sFa+psucQxy+ZnkZW/nO5KfPmgqWXjBxoPcwv6gIjZm8xX6E7DcUwOzn9L2fE8BO6V+1pei+ebnIviFQEvqEZ39r81RNhbRmnzmyto0lmb3btgf+SKb553d6ukUSz9NQaIp9g0iy9odfm+owKUQvYgBWaIVunZH6mpvXulE9Wrq/e2ZOgqy+FKzps42qyN6laTRYKiaztAV3ICdjiRt+/slFwHdJtedM5Vbokv59JuhMACNUTRqDsbGxt2HT5hc2z9+p4W/Jk41q6+9stN0l01qFlUHhjujKMkpUHCLvfE1HkA1PucG0jMaw3Pe8/Fmnza6mpDKn44HaJZV3w/s7jvONu6EklZ/nO8n0+Ea3dltmNe8fSc3w26HXo62GOAW07bskHT4Kuap9KKpUWjWwuzVEKct/xerrlNT3w05hUY309jY6cPmR1+hNwyDji3ue6nCcdenw3X+8qtEzwEPQjSNNfnK1flFMqZG62kcwGQKjVXgwLnW3fRWu3Dj3ev2COXXQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(396003)(366004)(136003)(39850400004)(346002)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(31686004)(2616005)(6512007)(6486002)(6506007)(478600001)(2906002)(38100700002)(36756003)(86362001)(558084003)(31696002)(5660300002)(41300700001)(66476007)(54906003)(66556008)(66946007)(26005)(44832011)(110136005)(316002)(8936002)(4326008)(8976002)(8676002)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YTgwaWxqcm1CTmlQcHY4NEY1cm1kbDdnTFdkdkRWM2doMjBxUHFWRy9nRXZX?=
 =?utf-8?B?Z1NSRko3YlRsVnBZdW45czc2NUNWZ2FFbDNvUWJGUGo0SWtnbGtRSlRPWHVK?=
 =?utf-8?B?UFRsY1dEcUlhTG13OUJLSFMwOFhad0YxMHplakdYejJiemU5TFk1UWIvdEQz?=
 =?utf-8?B?djMrb3RQY1FsR1FmdW8zOGtiem9rYjRLSWp6aFV3Q2MwMGVTSzkrMFdOVm56?=
 =?utf-8?B?QUJ0SUVPWkNlVXp6bDJ4WU9YUURKSlUvbGFhTXlCKy9PQ00vOVNHaDFmUzFI?=
 =?utf-8?B?bE42MXdkam1lVklReHcyNHZwTnhzOHJPNVdDQUlCOWg2bGRaQUIwRFhmQTVL?=
 =?utf-8?B?VmtxNjFVL1lEdXNIaGRmMEQ2OVdHZlpuT2xudGV5YVpzSnQ4YjdOUWlsT3Zz?=
 =?utf-8?B?UU5ITGl5T0t2ejZIU2k0N2xGbHhKNFhrejlxRXA4ZlZUL0xhcW1OTWFDV2Zq?=
 =?utf-8?B?WlgwbjVpemFwa2Y3OFpHZ2MzazVtWFgvWDBlK2kxSTFPdXRlbWdDKzh5Z1ZZ?=
 =?utf-8?B?YXNYVVowMStkTElGVmFjZzFGNUdCVHRNK2JlbWd1alFYZEVibmk1UTBlU0dG?=
 =?utf-8?B?WXVZV3ZsYTNuV0hUTUtTQ254RWNRM01VUWNDWlRhaEQySS9lZHZjc0dLN0FJ?=
 =?utf-8?B?SFlLTzVlUHptZGdhUE9KWmQ0QkJIdVlNOVJYMGJodG5Jb09UeG9WTEJ6TGdw?=
 =?utf-8?B?azY3QUI3QzE3SCs3bng5QmlRQW5DRjNvM2FrRU9IQ2Y5S2VIL3lkaUxkMHlU?=
 =?utf-8?B?QXBDa2JkcnNzRDg2Z3piUm1LbFFBT1lxMUdDRjQzR3FxblgzeGNwdDhBUlYr?=
 =?utf-8?B?SmxHVmN3Q25FNmFzOTJwSldxVzYwMW9sOVd1QTBzWmVWS0NVSzVQUi8rN1Bo?=
 =?utf-8?B?TjdmbjBSZHFEOHMwQ1RsZlJSWWt1VE4zZkNWK1d1eU5HVHhRUlM0SHp5bkNx?=
 =?utf-8?B?WXVST0Rza3ArZzI4eVdZOE1JSkNZU2RwRFdxSVBNcTExa2cwaEkvOGZ2MzU2?=
 =?utf-8?B?TUV3VUN2aFpxMG1SVklGZXVMdXB5SWpwWmNYbEY1dVVvWUpDK0ZoQTB4QjZv?=
 =?utf-8?B?NmZpdURVWjVobUxQTXRTQm50M2kyT3dDNkp1bDQrd0FSb1JBc3M0VENxR29W?=
 =?utf-8?B?aXNDSWVLRjEvTjBkazc2WUtxeVlGQUdDOEZGQU5TRTQ0eDY2cG5HR1I4YjN3?=
 =?utf-8?B?RW9tSlltWjRxc1lNaFFHYVlWWjZLMjZXcDhVSGswNkpXL2R3WWRZa1ZzaVlU?=
 =?utf-8?B?ckZSb3lEME5IcmRsVWUvM0lLYVp1dHJvSEJMdDVlckg1TUZsSjB3akRnUFlR?=
 =?utf-8?B?WkJCdDZxa0NqZVlMWk9MeXV5MElkRGU3YmpxenVSM2VOTlBReVZDc2xOZFVP?=
 =?utf-8?B?dUt2RmFQY3B6WExFNWZTZ2FkMVJSUXFtakVpZmJpOHF2b2YwQmpuWG9DYnMx?=
 =?utf-8?B?aTIrb3RrYXJ6YUNYc0t1R2FKK21OQzJQSnN3aEYwYldBNEo3dWo1eUJyV1lz?=
 =?utf-8?B?RzNsWW91cFNrSUF3VkZPZzhuY3VVcXZJRWdJbERZNTUrMVBXcXp4Vi95a2pm?=
 =?utf-8?B?VnlRTDNleUIycEM4NUlnL3oxcUtYVC9ZOWRINWdrSlpibmRraFNhRHBqRjl0?=
 =?utf-8?B?MlhTbmMyV0l3TFh4MUV3M1VBMW5UcklSRXFKakppT0p6REdQdG1kZ1pENHNL?=
 =?utf-8?B?dGpSNU5zZVowaGRzcGhISHQ2VXNURHhrRXZoTnN0K1dYbnFFdjJTZVZrQzlG?=
 =?utf-8?B?blNteUVPSk5GMTlFOFBGaklWVWdIaGI0cnQrUWN5SWdMOWRMeTl5aS93YVEy?=
 =?utf-8?B?ODRXclRZSHJsZ29ZYzBTZlFqb2dJcGt3SFZUL29mNE4wK2k1cVk3Z1ljSUNy?=
 =?utf-8?B?ekFGa0Q2SkNVdVplWXBEYXU1ZDk4WmFsV0FKWlA5SFJsRGYwVVNpVVVkVnQv?=
 =?utf-8?B?akFqbWxjdXl5eGxCQlJkRkJnRlQ0aDlQb1FoT1dzdEtISnNEUjZPWDRVSFFk?=
 =?utf-8?B?VWxXMVVQTTlSbDRXYlJKNFhrVDE5cU1kNnlwRFBJajJFYkxRTVQ5YkphWTBV?=
 =?utf-8?B?V0U5c1BFdS9YeFA4YmhKZlJRL2ZMZUJoRlZVUm1LeUlYNjFDYzNRUStzV3dk?=
 =?utf-8?B?SUR0WGo4Z1FNWTBRQ1duRU1vNzZreWFUc3h4MkQ3YW9xMktsTWVVMXh6MXAy?=
 =?utf-8?B?YkE9PQ==?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: abf4a731-fe08-4351-ed67-08dbdea08e47
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2023 08:15:36.8209 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b79WMKQk6UBmoz0IpmSu4LuJMR8OKbFj3i6FXg4pvTAVXafcfl3WnG5DllfHLbawjwjU2unTxeGsxX8M451FpdQF7VJ1T9QryPWkClkaJw4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6683
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

On 04/11/2023 20.43, Simon Glass wrote:
> Hi Rasmus,

> Are you planning a new version of this series?

No. AFAICT there's nothing to be done on my end.

Rasmus

