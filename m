Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9142AF8A154
	for <u-boot@archiver.kernel.org>; Thu, 16 Apr 2026 09:55:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C03BD840AB;
	Thu, 16 Apr 2026 11:55:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="KOwHLmiH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F96084105; Thu, 16 Apr 2026 11:55:28 +0200 (CEST)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F1DE83FC0
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 11:55:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xccnXye9UGwc0B+qdqDON/5sq0xGVfJWBbkOKOu+sfophhA4EtryD0zryygh8e0yUTjhj7VsDyUc6Q28QOrya51JhIL/y4wO/TnyS02ZnfXy76Wpqr4JeRY1yMqd7Z2jUUsm3g282ZfOxTrw56CO6a43Ck+ISqjqsiNNouKU+o+/jZO7QJor/Y6xCLWcatwo0eIH8MvBqoWq1kyPp7m5KrekDDjK5FFHOMJSxC57kxd3DkIj7Ly6l0YhKirQoKb6d8nVXH9iWQYo6sTRMaVUHc8WPgN+8vxxcM5UVPCf1oI91ogIRMFml96uDHuy66GS0j2rQkgn4soD7TKelvDArA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KXdVoCE/Q0i8RHISDhiSd6EVb42/1o8jpwpVN/IRX9w=;
 b=Kyz8yyw93nvLXuKFPFI/fnGtidSQN3CgGYBI9gF0BJaQ+mCEgcIfbjRLlCiuE3hllVVdYJ/ZwBNMOGVI7DdF9l21XL33XPDj6gWxB/RPUEa6qzudxKjZSRqFbtIU4gDSBiPoxSpFN2/cAYARyrU65nCqbPKQm7mUy5x5wlmcImV1IVusjCkGvBFiJ80sJzr32MvM6Pxp5r7xaQEc4RsMsLMNVbQ6NTRW+E7zu4aDk5pLHdCk2TV9GprD5+iHuk33rixChyB3Z078OoZhE1pgvagENjdRlUtUBMcRobZL5dfikZK5Kit9CwPJYVYHGDTjrsAWQ3ZWLOAkHnzpaC+C8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KXdVoCE/Q0i8RHISDhiSd6EVb42/1o8jpwpVN/IRX9w=;
 b=KOwHLmiH5Es7JAx0eKwxmELYlw/tE5uFYGWqGtrL+OXE+vWouhpfhxrSAuWl9q9pws0Nwko2QJsukeQz0uA005OTxlaWXs3kR6bHDWkXlbTLNgH5wVRqswPom83ETJKKtn9PwYB+Htls3GGXGU15PkS4/TKfFEn51JXCK+kXF7OUZmGiEwdHZ9CHYKxAUZHuy9wciezaP2QAxaMToDLF0oCHFDtIYAHofnT+M0/zTUAiN5J1oi42JoZCLsD9YM2mBzh1XG2a3nOtbh6lZYn6SpaVUwENvKKchqntsF2EaJeK1VF78J+RPw6Kb6/a0QA/5UStdHwD51R5mPMmIJ4hzA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by DM4PR03MB6207.namprd03.prod.outlook.com (2603:10b6:5:39b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Thu, 16 Apr
 2026 09:55:22 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235%6]) with mapi id 15.20.9818.017; Thu, 16 Apr 2026
 09:55:21 +0000
Message-ID: <a3245d64-3e7f-4179-aebc-439eb400b11a@altera.com>
Date: Thu, 16 Apr 2026 17:55:12 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: dts: socfpga: n5x: Drop kernel node from binman
To: dinesh.maniyam@altera.com, u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Boon Khai <boon.khai.ng@altera.com>,
 Alif <alif.zakuan.yuslaimi@altera.com>
References: <20260311050224.23983-1-dinesh.maniyam@altera.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
In-Reply-To: <20260311050224.23983-1-dinesh.maniyam@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0038.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::15) To LV8PR03MB8137.namprd03.prod.outlook.com
 (2603:10b6:408:295::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR03MB8137:EE_|DM4PR03MB6207:EE_
X-MS-Office365-Filtering-Correlation-Id: b1748db4-6da8-4135-f0b2-08de9b9e45f3
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|55112099003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: VzYQqjr/zPPHNhng9LfypkBHKRLQk9/wtQvdkINGYpvgkZHRPAQyroXcxtnsN6ibHHXBuzZXaOlwV2Pk5Ufd/HmL+ItTR/+hb2sp18lxV4m6v+7mEBxGR2mfKBFrFSWLI2NxXtM+nlIRxStJT7/fzjNviYxGDX43u7K0Z8ubC7kKk4S50jhThQeRpG6Qvw9Xx4ZH1GDfaH6IxSh/ak75qNP2+1AlhKc/c1xIz9+YjGSCMtauLpMVXWxtiEiqbaKOtKJJXd7bTqHtVe/cOgJte7IU7vSsme/VGexlleI0RJk/Gh8oyuwYptwQC2ELY8x3CFq+D+EyhbXjXn6kzlVks2Gxvn296MKppkRbkpJH4vZ3EPw8KRz2Z544iuDZlcu4XesDG7MIApgt+qBWOhmB6amBskSoeAih7WZ1blmMcCTPOF2HuaEEWSN85ezMiznyI3JAzMNpQEUQJy4V/j/UO1Tb7nk+mOaEeuX5sx5LIkAuLPQ/hhm90gXzCBQjh1bek0/j/m//+byE0fBMhZV0lsLmdxTXNDgkex0jAg28qZeIiz5drTvXpjcWil781KrZkPLSaEYaGmhiF3UpEJDE15v9vOrfBq67npBwYnOZbVh5pjOaEhAGicL0kUoR1/W7kKv7Jc2EHFum7niv9aP31/y178285wpPgTVAhwaROjUeWn/DhueoKQqvxHdmKo0BD8kDSNbchRU34MyvhjDs08B5bncpvvAmQYQhUGwkAqM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(55112099003)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VTZCcHBnblRwRDExaUkyVHc3aWxHQVlyT0hZWktmb2hObEJZeU1wbzlSbjlH?=
 =?utf-8?B?akhHZnE1ZmFyTC9BTHBGd1NmNG5zc2ZPcnRrWm1PdFdiaFpRd0VzS2JmMElm?=
 =?utf-8?B?c3E5QUVXQkJpRTZIMzNPWUVrQXBGUzkwS2VBZzI3aUQxeG9abStabnBTNGMz?=
 =?utf-8?B?QXZXRmozZUNGdEd5eFdxUSsxYmgrR1cvcjlJOFN6aGdXcXZ5ZWJ5ZVdlUmRn?=
 =?utf-8?B?N1BSWFhzNVk3RG85RUNsbk84REt4eVRrQTVpdDlNMUNVT1B0UGVCVGVkQnZu?=
 =?utf-8?B?aHVmTlZYVXAxVVdWVjBuMjd5aHV5c3p6OUEwVnZ1U3czUFZ5WWdrcS9SWDNJ?=
 =?utf-8?B?V0RsQURFc1FrUUtmRmxPek9raGFjdEJkVzNBVDk1ZmdwVkdIWWtvV0V5TmNW?=
 =?utf-8?B?T2tqVjNBbVZKcCtVTDlRMysyOVFsUFNuRWxVQ1NOU2dEYTF4eW1NVFV2aVhQ?=
 =?utf-8?B?QWVUcmM4azc4M3JFcFUyYVFQSHFrQXFqOVprSGNXRzh1ZHM2bThwTXpjSk5y?=
 =?utf-8?B?bkN4NUJxdmxyRnl4SGY2WVdUYjRPRnc4WFJteFA1RVpaUzFtMjNkZXB4ZEZs?=
 =?utf-8?B?L2RHVWFXT09VMGd0T2pJeCt2bTllUFF1Ukp3ak51ZE1MSzlEc2xxM1RYdFF6?=
 =?utf-8?B?c2UzQXNGRDhybjJMdnYzNXNRVE9XaFZuR0w0RHV2Y3pIQ2c2N1hVY0dEaE0y?=
 =?utf-8?B?bkQzOTZSK05JUHFNZkRtNW0rdHZudkdTOVV4RnFsTGZyNkdMTGtzRVNzUnFB?=
 =?utf-8?B?ZTh4eDdwWmlVYktnb2dPYTMzTGtJTjlaQlhJRzhoNENhUmpjZDREVXJ1MTZz?=
 =?utf-8?B?aVMwZXV6dVN5TGFSRU9LSlVYdlpDNFZlSC9hOUxsWi92K3JERWtKeFE5ZHow?=
 =?utf-8?B?TmsyVENobjR6VVJSa0YvMzRpUGl2ZngvUm9sSkttalFMSDJkWU1paG05R2JD?=
 =?utf-8?B?UzdCdlRZN1RLRS9wWEg4V21Oc0hMVVdNS1g3Q2NBODFSN2hoYk5oYm5XZE5a?=
 =?utf-8?B?eEVibXdhamtoNEt4bXA3b1cyc2hzTW9Hc3hFWXVCa2lldkpkVnB3N2pwMDhp?=
 =?utf-8?B?VWhHajFoc2xIMzR5czZMQTk3SzlNOG81NlNDTWJxS2xoTDI1WHU4aStqNnpK?=
 =?utf-8?B?OTBOMFJwaVpxcFZCS1Uwb25zdm1wZm42aThKMXhRS0cvLzVQbmduTE1DZDB3?=
 =?utf-8?B?UE1QSGxrYkR5L280Yk9pbmVYQXBTOGhTVWFFMVBKME5jU2piaGxkOFYrc2dX?=
 =?utf-8?B?RDhqaWhTTTZVcmI3bVR5b1Z0K1RiTTZQeWRka2JKajVBZFRBUkJ5TXNJbnRG?=
 =?utf-8?B?VC9PMGZQd1IvYnVBcFErb3JTVFdnOHJNQm5aRG9CNzVKOTJzTG1aNWk2K2RK?=
 =?utf-8?B?aDVlaE1scVlDblROOWhENTBDcUdaWHZ2OElkWUNSMmp6TGtNdXRJZDNzVDZy?=
 =?utf-8?B?NDd5QlZZSzNzUm1iMk1WUnpGbWtjem1xdG1ZT2c2cm9RTFZ0QTJtdUVudlQr?=
 =?utf-8?B?TUtYVHZmVVQwZ2NjZWhKWmpucHNWTWQ1REZkNVF6aEhQUk1QV0NybStVVGNV?=
 =?utf-8?B?YncwM0VVdkVrQlpxOFVuYTlEK3A4b2diZDk0QktzRklxdWpCZ2NBdjlrMEJP?=
 =?utf-8?B?YlBJUzF1SG1hZ3Eza2VqczRiNG01Ly9lZC9BU3NGNVRUbmM4U2hINTNBZDhZ?=
 =?utf-8?B?UmVvSlBFYjRIUVVSSGJxaEV6Rkcvdk42MXpWU1poZUxrRVFQcGxHdFpTU1Nx?=
 =?utf-8?B?endacWJZL2g5d1l6eXlyZlVpQW0rQVpURVVqeUZiWW02SVViVS95aU81NVZQ?=
 =?utf-8?B?c2VMTnVCK1YrK2ZLaTFzZTFEUjdabUVjRDV0TFZybTFjaWhTVXJDa0RFUGJi?=
 =?utf-8?B?QjB1STlvMEU1Y3hKY1doWk0vUDJ6MU14UUtmVzhWU3lRWFE5K0pObjlqa2pv?=
 =?utf-8?B?NVVadTFoTU1ZdUJ2b0ttWWRJL1cyenE2dFFOcEd5bmtjNFZBYTFwQys0bUpY?=
 =?utf-8?B?SVEvUStROWw5MWNZSFA1eWpNazIrNWpSWll0TGtIMzhoYytpdk5KRk41eDdr?=
 =?utf-8?B?b3E3aWVLOEc4N2pnOTBLWUwvcmRqVHJpOWJwV3ROd2hSVzVOKzdwZmZreGNU?=
 =?utf-8?B?TUNvL1NxN3NDQjduZkJTUFlFdGxLL010dWtXTmxzMlpyb0sxa0xBU2IxVHZx?=
 =?utf-8?B?b3NKNnhwSzluOG5iSWFCQlBhMzI0SnNNd0JKZm1ESUJuZTNjQmlMT3VMZjUx?=
 =?utf-8?B?OVVSVElNaXdQNzJiUm9pOXh6VUFzZEJJck40bXFGKzRsajJ2NEVSYmFRQWda?=
 =?utf-8?B?UkhIUUd5d1BhWWJtWnp3VGplK3RrKzRWL3FUVlJ5NDFta3p4bGlXb1JzSmVL?=
 =?utf-8?Q?hu6FvzqKfrEdaC1w=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1748db4-6da8-4135-f0b2-08de9b9e45f3
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 09:55:21.8302 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GfSK/J9jjtbGnx+JUfnXWmxXhpfhopwLquaorPVORNfedzKDwNzmpuHaxWyqD3yBOtXVClKWVARn+PJZPeXhmo6ffQk77EWDebmO1spZ39c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR03MB6207
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

On 11/3/2026 1:02 pm, dinesh.maniyam@altera.com wrote:
> From: Dinesh Maniyam <dinesh.maniyam@altera.com>
>
> Recent binman changes expect a kernel image to be present when
> processing the binman description. N5X builds U-Boot without a
> kernel image, so drop the kernel node from n5x.dtsi to avoid the
> build dependency.
>
> Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
> ---
>   arch/arm/dts/socfpga_n5x_socdk-u-boot.dtsi | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/arch/arm/dts/socfpga_n5x_socdk-u-boot.dtsi b/arch/arm/dts/socfpga_n5x_socdk-u-boot.dtsi
> index 840537c9d0b..236975692f1 100644
> --- a/arch/arm/dts/socfpga_n5x_socdk-u-boot.dtsi
> +++ b/arch/arm/dts/socfpga_n5x_socdk-u-boot.dtsi
> @@ -61,3 +61,7 @@
>   &watchdog0 {
>   	bootph-all;
>   };
> +
> +&binman {
> +	/delete-node/ kernel;
> +};


Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong

