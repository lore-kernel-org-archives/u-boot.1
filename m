Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33587C531FC
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 04:46:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B49BB80A86;
	Mon, 27 Jul 2026 04:46:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id n0aEkG2PvDus; Mon, 27 Jul 2026 04:46:06 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C31EE80C23
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785127566;
	bh=b3dSJjSg2L0uADLAl6/XyQpmZ9d48GRUIQ9tx02c5Z8=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=VxM8kgXZ5b+e8a9b28QRrZBzU/ecxFaIo46/m2/XEPh5ayU60hGIB4hQSi8fS5sbM
	 QSDY+MJOktJWkji7zoZ/D9MrYvfY9rpcOyh/7T3tBTrbw1GSDjbdg13cn+NIGvOZcb
	 hiwrLIMTQTGmPGfnlTVXg3lNcsgVt3CdhkXqkKbJGCeoperruM2eebu0sEUbqzju+r
	 //EoLd9zOhtKZ1RiGZEfeBUOyKOxH/V2lapDcAHqrd6TXrUNBJMp/5EuTTzjADYx5P
	 GX0f+VoX0QHdnUQ3kLd0cCwC27fRNgQ5dhU1P8kiWAajfQ2sWnu1HXONxZfF3uiY2r
	 DoWyAyE2IWYEg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C31EE80C23;
	Mon, 27 Jul 2026 04:46:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id E3FA82E5
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 04:46:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D551D405F3
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 04:46:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1KVXHxIVHFhA for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 04:46:05 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=alif.zakuan.yuslaimi@altera.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 82402405B3
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 82402405B3
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 82402405B3
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 04:46:03 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5EF684671; Mon, 27 Jul 2026 06:46:00 +0200 (CEST)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 54B8D82991
 for <u-boot@lists.denx.de>; Mon, 27 Jul 2026 06:45:58 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ln8Q6vgIpBlN4PiqTQLR6t0vQujcp5kBqgCqpEqq2Qmt3/IwojUIV9eKrud6k70aL7ptJJ+oj7X6Qu+47DQmzkn7xs6AS/5+os/BPNsnutW0omocYWayO3s4VSzp1q8LhVr3/UgNQ1I/qKtn2Mv7ORJjQWItk4SLciYXbsVPc0EOuF6vR2et92ragsQJo1DvjPBf6EeIt9DqMywDikxnYwD3vYwZwWr0dCi8RZVPrwW7MwAkApu4B74ME5oWkIQzCs1PgvhbOyVapEbiSaQG9oh/wf5dvEAHp/D5vqaA5KviYkr+aQEJoQMxVksbg50/vh9C18xOBYMijuf1obWsXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b3dSJjSg2L0uADLAl6/XyQpmZ9d48GRUIQ9tx02c5Z8=;
 b=sv7txEuBOsjMVha8mkPHLiUEGxaRezAd9yoHTZWMVaivaOm01QWMtMAxWK1HiXRAhNs/JHPz0rX34cPVZcBJWwA+To/Ndo4uhg87uYP9Px1U3nHfqFKtKeATeLYg3RnhmE8YcOJuwIEDpBvZw8hjBBftCNkW8dy4QBOLFWznn/8CHZAFA+ymcjav6arMn2ZX7/MfsXy/9FWIH+9O+fxGcqB729unzGhxdNxeixPWqBv865HWa72PrdKs4IhWa4zm/DiK2UKlw6nZj5dcc85jT22OtXtNhsqynwfmTdE0DGRqInQVvMiO6v//zPuhIbbqdid10iVenzWbBgvRUhmmgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by SJ0PR03MB5613.namprd03.prod.outlook.com (2603:10b6:a03:28b::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 04:45:53 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21%4]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 04:45:52 +0000
Message-ID: <0c27630b-7b1b-4f4f-a04c-5ad24b367e6d@altera.com>
Date: Mon, 27 Jul 2026 12:45:18 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: socfpga: Rename TARGET to ARCH for SoCFPGA
To: Sune Brian <briansune@gmail.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Marek Vasut
 <marex@denx.de>, Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 "Chee, Tien Fong" <tien.fong.chee@altera.com>, Tom Rini
 <trini@konsulko.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Anshul Dalal <anshuld@ti.com>, Simon Glass <sjg@chromium.org>,
 Johan Jonker <jbx6244@gmail.com>
References: <20260723024306.9888-1-alif.zakuan.yuslaimi@altera.com>
 <CAN7C2SDhSzVabXx+EswLksHbQSEyK4GxgkgUVG7Z3Kx7RdS6JA@mail.gmail.com>
 <a4a2481c-fa1f-411c-ac21-380b3a35a4c2@altera.com>
 <CAN7C2SCatXrdU-ObZWW=-sRAO2oa4chFu7pRsTVjcAaqs=w8VQ@mail.gmail.com>
 <0200e37a-7790-4a48-b43c-abbfbb1603f9@altera.com>
 <CAN7C2SC-9+NxKsMs_kMu-rUV8E4uicty+v+_HLvdtmud2LYaLQ@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAN7C2SC-9+NxKsMs_kMu-rUV8E4uicty+v+_HLvdtmud2LYaLQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI3PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:4:295::18) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|SJ0PR03MB5613:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a328fb6-f57c-4b27-18d9-08deeb99efa5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|18002099003|22082099003|55112099003|3023799007|56012099006|4143699003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: X8unntmjtzu8YEUnY545mlibFgMh08Qee3onxXZC6l27aJx7ZtiVmsnn6pvlbtwYokQHSomLjsKEGorgLO1K/eSpde8KQVFzAMsf+s2/fS7mrVkve8yIZiaNM+utaA8mjNwWOOtXyIgn8h8cttVECsQG/3xO3mDp0NDDKK+VUcBJEBUcUXO2/pGglt18KMDDTBQ1JjMNlSrINWMAzMTpDyDcR3yALbJw9qsusaU3S687KfJpPNFs2bS7HT5QqwpCZKI4x2H1FanElHe9qVnLJQBT/AySvQLsp+spB3GOfPCrVDnX78GdTSSrvj1tv63/224hz7otx+qcLQLABxPXGT48pW606TURzaN2u0vpb8s2PugonVvqr6zVFidoaWGFge0zh2+CGfISg/zs89m+iYyqC6gBF11vqtqQVfn0OvSpoRLhzmkmaRkPUJJSqz/QACBCE7eOjZzN/4ZCGbzOJP52Qj9dAk7m8bdL/f5fnDbNKiQe+8dyGm6ctjh2iMbu10KogyJL2h43zs3lCRN/F/+9tk7A6yzzK2fHNTvUAklPn37GabOk4dRjiByWeIYx8jJw+rwvqv+4Itww1zTnPT6Hv9COnE2dmvgi70sWVjqYoDxTLbyNXAyjBzDjlCEgxhLlz2Cl1p9s4qaqOa9ydPzaMdo1ruxK7N7M4BmK/2I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(18002099003)(22082099003)(55112099003)(3023799007)(56012099006)(4143699003)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NHdFMnhGUGIzSWRXSHArQmt4ME1lYTFoY0pNUjBDdGNQWFhXajE1Z0l0Y00v?=
 =?utf-8?B?NnUyd0N6ODlQZ3QrMGRkUDBXTVlaTWNIelVSWWpic2grMmw1dFBxRzlJejRl?=
 =?utf-8?B?WkNFc3ovUlduMHNCeFRSelpSZzNGNmRKSWQrUWEwbVlNc3hMMXYrTFYrZVVJ?=
 =?utf-8?B?N2JVMlJMZUNER3V5RmkyZ0pUTVM1VGFlSUE0RXMycTdOM3BvamswMzA4dkxs?=
 =?utf-8?B?dGhZTkZwYlN2Kys0MHV2OHpRaXFZVzVKOVBpS2FkTnhkVDVFRkFuTGRLK1Yw?=
 =?utf-8?B?N09hRGlSNEJ4ci9ENVlUZGNVbWtzWUdNU2tza1JWbW1mUnUrWFlBS3JDYTEy?=
 =?utf-8?B?SEdydTZYNStsMEwrMmFhd0JoS0tqcTJhQ0JEbjB0OGhBOFBKK2duL0h3a1hY?=
 =?utf-8?B?Y1F1ay9yemNsMzBVK3NZbmhXZ2tkSHVJTEdLK2hmZDBZd3preS9ub2NCZjk1?=
 =?utf-8?B?Z1hTNDdBQk9ubTdKWkVIeVV1SGUvK0w0ZTdLQVV6VE11SXhiQ29aTU5MaVlo?=
 =?utf-8?B?ZVZEWlA3Z1JqVTRQVW5KOWpRR3kydHpqdTU2cGRZbUo0Q1ZLVkNkZG1rWmI5?=
 =?utf-8?B?NmlPSmZnajJRQ2RBT3dqemExRTZjSEpOQnowd3E4VkdiekU2d1dKQUNVUXRa?=
 =?utf-8?B?bFgweWpuZ2pNY0NibmMzWHpRK2hvRVNMSGFwWVdrV2ZDaGxLNnZpMkNDQkxa?=
 =?utf-8?B?RjRPY0s5Vmxwcm02WmxEV2xaK2Erb3NLTVRNZjZNbm0yeU1DcUdJQWlPMm9o?=
 =?utf-8?B?R255KzFiekQ0eWErNmp5TmNjak5QVC9ZTngwNS9nNEowQXI2dkVTZG1Hd01r?=
 =?utf-8?B?TnNPbUxYRnlMWWpCQitBZDVuenJMbEtwdDR5VUtOUkN5VlJSYk5pOUNqdW13?=
 =?utf-8?B?cGtGZ0RuNElHL201WVYwSGkxbTF1K1lERTVnN1MzMkt5MklnWjdaRU02ZC9Y?=
 =?utf-8?B?MU01VFZ2NllGa0svbTRBNE9CZnE0MUo5ODNUQnNDN3MzQ1AyRVFZaEx1SHVl?=
 =?utf-8?B?dElOeXlsUDRoY0RrYzNXYStLbDU4MEc2VTJxM2VjdmkzSkZWNU1US01xdE9y?=
 =?utf-8?B?TStrek1teE5jQXBPdXA5aE5XWXJwNDhsYkpRbzF5ZzRzMU9qQ2hvdllvdDNL?=
 =?utf-8?B?a1Fja2s1amdaMjZZUnpwTzhjZHBGbmFoZktRSW5YSmE3Q1gxRFBTSGIyVllY?=
 =?utf-8?B?cGNheDU5RncvQ3JLQ2ovTXhCMXVoNllrUTV1MlNLeWQ1c1lOYlJQM2x6bFNp?=
 =?utf-8?B?SFB5RXhaK3QxdmVCSkZhT2E0TEVFLy9KNmlHaHYzRTB3Uk9ZSUJEWnBNZFdh?=
 =?utf-8?B?RDcwdEJJdWVlbHAxNlQ3QjJBVGRWZTd0L2NCVElRNGt6ZnExalVlQkJhU1FI?=
 =?utf-8?B?QldUeXhiYW04aFhvVUVtUUpKWWthL01WV2FTcWxFUnMyTUhpY0xkbXFBNk51?=
 =?utf-8?B?bEV6WHJlRTkwWDNFNmpsY1YzSnFoR0ZBcHNSYUg1bDJrZ3dlZEc0ZGRoQWZ3?=
 =?utf-8?B?OVpxZWNTUmEvR3hiU2Zub3FUWlprOHpybHZXTDFpRDJUQW9yK2hHNkNORS9J?=
 =?utf-8?B?UXd2ZGQ0eDd2VlR1MjJleTRoMmlJMGpYc3ZvdnRHSG1qS256bnhaZXN4bCtF?=
 =?utf-8?B?WXNSUXp4MktQaGhkaE9NMDZpanRpT0pNQVdaVFdzeFUyNEJveFNoRmRUK2w3?=
 =?utf-8?B?MmFSUklMdkNURFNIbHlScU1KdVYxdUJSNjNGWlU5SkcxZ1VGMms4VW1YNjds?=
 =?utf-8?B?dE1nVjZGalBaV2I2OEpEUHhBWGZpd3lNTURUU0VBekVPSE9CNzYxSTczRE9L?=
 =?utf-8?B?RjlWWG1udDI1cVFiL2dxMnh2Tk5IZm8wVmdNS05sNXVmLzN0aGIyUmVKeXdt?=
 =?utf-8?B?dTU0MWIyZ3k2YkxkZWlXRTBmN3FBRlpxemxNMXIrOWlyQzBBZ24vdE9ZaUN5?=
 =?utf-8?B?LzRGdTFMVmZLNE5TaE1DZkZsdkMvR0hZdFlodzlXMW9qUCtrNlJmSS9zQUJK?=
 =?utf-8?B?Z1hsaFNTK1d3VTZTTE04dGh6a0tyZkVTK3JsYUQ5ekVTb094WUVGOG5BdFlC?=
 =?utf-8?B?MlpnZlptN1c5RzVPcXFCREtMWEtkNlZvZHV1ZEo1cXZBTTV4dWRCUUVucVJL?=
 =?utf-8?B?UlhZQmQxSitQSkF4MU5OZGNYRjhPaFpEVlpHSUV5amh2MHZjMXFtbS81M2N1?=
 =?utf-8?B?ZWZIbnFjamh1dXV1VVNwTXFQRWVhcjhjSHpqWmFsOU5DT1VhcTEyZEFkMHpt?=
 =?utf-8?B?NUY0SmlKb1ZJUWRWVlJnNEl2aE8xL2lIRGRmL2NIVVQ2ZUlxOW02djdTdXNT?=
 =?utf-8?B?NDhlYUczQ2EyN1lPT2FEYS8rODdlbDY2U3lnK3BwdjZqaGtmY1c0ejRXT1cy?=
 =?utf-8?Q?A/8dBmNdInGz0DqiJxrH8+cuPoiE2e+LWtHZG?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a328fb6-f57c-4b27-18d9-08deeb99efa5
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 04:45:52.4111 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cKRCCw7AjqOd50x0xWDJvA0gevKotpLd+zda5JmitgGCU5pPD4dJXM9X5AcV7l2A4AIx2yOgDj6cxowgTZZ7XU6qs/TjlJQUUmTc0aFJMPY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5613
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=altera.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b3dSJjSg2L0uADLAl6/XyQpmZ9d48GRUIQ9tx02c5Z8=;
 b=jNuny49wGfgzpMH2i+5exIT5aEdOtMh3mE+25ncspP7r7/Hh7Uq3lOw+kOvMKlHczt5ZfCJV5QvIVK+y/1mDnNiyWEH9pXetdhUKFhNmJZ1E9IkbtvisB+YuMXpXv0f8cQTUWT/Af71MQArNxCRYB2cR10Zd7a+0Croz0VHg32eW1ETg6alGVVNDV80C2fC8Fe7y9mA8Euzl/n3ahC3mEf4yt2/75BFe+bzAiqr58CtQ+51xUWhpktKZFcLt/3BsEg8P8ErL+cFQpOMrZYzobU/YAVvtvOwAsyNJohzXpfCrdudha6JQ8hPWQEbL4kpxsL8TlSxTk3Hk+eRvbJYO5w==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=altera.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=jNuny49w
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none)
 header.from=altera.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=altera.com header.i=@altera.com header.b="jNuny49w"; 
 dkim-atps=neutral
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
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
From: "Yuslaimi, Alif Zakuan via U-Boot" <u-boot@lists.u-boot-project.org>
Reply-To: "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Brian,

On 25/7/2026 7:57 pm, Sune Brian wrote:
> [CAUTION: This email is from outside your organization. Unless you trust the sender, do not click on links or open attachments as it may be a fraudulent email attempting to steal your information and/or compromise your computer.]
> 
> Hi Alif,
> 
> I am not too good at checking the history of these patches.
> I think the board.c is missing naming sync.
> As for PL330 the original CMD is done by me so history-wise
> I can trace more easily.
> 
> Is it possible to update this patch with the remaining board.c
> and message the patch with the PL330 the current reviewing one?
> 
> Not sure how to due with the missing board.c
> 
> Thanks,
> Brian
> 
Sure, I will submit v2 with the changes only for board.c

Best regards,
Alif

> On Sat, Jul 25, 2026 at 5:49 PM Yuslaimi, Alif Zakuan
> <alif.zakuan.yuslaimi@altera.com> wrote:
>>
>> Hi Brian,
>>
>> On 24/7/2026 6:25 pm, Sune Brian wrote:
>>> [CAUTION: This email is from outside your organization. Unless you trust the sender, do not click on links or open attachments as it may be a fraudulent email attempting to steal your information and/or compromise your computer.]
>>>
>>> On Fri, Jul 24, 2026 at 12:09 PM Yuslaimi, Alif Zakuan
>>> <alif.zakuan.yuslaimi@altera.com> wrote:
>>>>
>>>> Hello Brian,
>>>>
>>>> On 23/7/2026 4:59 pm, Sune Brian wrote:
>>>>> [CAUTION: This email is from outside your organization. Unless you trust the sender, do not click on links or open attachments as it may be a fraudulent email attempting to steal your information and/or compromise your computer.]
>>>>>
>>>>> HI Alif,
>>>>>
>>>>> Just reminding, duplicated patch:
>>>>>
>>>>> https://patchwork.ozlabs.org/project/uboot/patch/20260407153650.26404-1-briansune@gmail.com/.
>>>>>
>>>>> Which is under reviewed.
>>>>>
>>>>> Thanks,
>>>>> Brian
>>>>>
>>>
>>> Hi Alif,
>>>
>>> My original patch does grep the entire u-boot repository and update it.
>>> However how T.F. redo that patch or any missing I did not double check
>>> again.
>>> Tom also noticed the new board's naming update is missing and updated
>>> the naming as well.
>>> After the patch applied, the board.c did not notice the missing renaming
>>> but only the PL330.
>>>
>>> I am okay with the old patch removal due to the title not properly formed.
>>> I also suggest doing a full grep again to verify any missing.
>>>
>>> Thanks,
>>> Brian
>>>
>> After grepping the whole repository I found that only these two files
>> needed fixing.
>>
>> Since this is already under Tom's radar, and your patch has already been
>> submitted and reviewed earlier, I think we can reject my patch here.
>>
>> Thanks,
>> Alif
>>
>>>> Thanks for the heads up. How about the fix for
>>>> arch/arm/mach-socfpga/board.c?
>>>>
>>>> Best regards,
>>>> Alif
>>>>
>>>>> On Thu, Jul 23, 2026 at 10:43 AM <alif.zakuan.yuslaimi@altera.com> wrote:
>>>>>>
>>>>>> From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>>>>>>
>>>>>> Commit 62f7a9460209 ("Replace TARGET namespace and cleanup properly")
>>>>>> replaces the TARGET namespace to ARCH for all SoCFPGA devices.
>>>>>>
>>>>>> Some of the TARGET namespaces are still left out, update leftover TARGET
>>>>>> to ARCH following current SoCFPGA naming.
>>>>>>
>>>>>> Fixes: 62f7a9460209 ("Replace TARGET namespace and cleanup properly")
>>>>>>
>>>>>> Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>>>>>> ---
>>>>>>     arch/arm/mach-socfpga/board.c | 4 ++--
>>>>>>     cmd/Kconfig                   | 2 +-
>>>>>>     2 files changed, 3 insertions(+), 3 deletions(-)
>>>>>>
>>>>>> diff --git a/arch/arm/mach-socfpga/board.c b/arch/arm/mach-socfpga/board.c
>>>>>> index b202ca258bc..b662afc1ad7 100644
>>>>>> --- a/arch/arm/mach-socfpga/board.c
>>>>>> +++ b/arch/arm/mach-socfpga/board.c
>>>>>> @@ -210,8 +210,8 @@ void lmb_arch_add_memory(void)
>>>>>>     }
>>>>>>     #endif
>>>>>>
>>>>>> -#if (defined(CONFIG_TARGET_SOCFPGA_ARRIA10) || \
>>>>>> -     defined(CONFIG_TARGET_SOCFPGA_GEN5)) && defined(CONFIG_XPL_BUILD)
>>>>>> +#if (defined(CONFIG_ARCH_SOCFPGA_ARRIA10) || \
>>>>>> +     defined(CONFIG_ARCH_SOCFPGA_GEN5)) && defined(CONFIG_XPL_BUILD)
>>>>>>     unsigned long board_spl_mmc_get_uboot_raw_sector(struct mmc *mmc,
>>>>>>                                                     unsigned long raw_sect)
>>>>>>     {
>>>>>> diff --git a/cmd/Kconfig b/cmd/Kconfig
>>>>>> index 35ce42f8397..b724f4f8d49 100644
>>>>>> --- a/cmd/Kconfig
>>>>>> +++ b/cmd/Kconfig
>>>>>> @@ -1911,7 +1911,7 @@ menu "Shell scripting commands"
>>>>>>
>>>>>>     config CMD_C5_PL330_DMA
>>>>>>            bool "Release Reset DMA Channels for PL330 Handshake"
>>>>>> -       depends on TARGET_SOCFPGA_CYCLONE5
>>>>>> +       depends on ARCH_SOCFPGA_CYCLONE5
>>>>>>            help
>>>>>>              Provides access to Reset Manager Per2ModRst. Enables DMA
>>>>>>              channels for ARM PrimeCell PL330 via reset release.
>>>>>> --
>>>>>> 2.43.7
>>>>>>
>>>>
>>

