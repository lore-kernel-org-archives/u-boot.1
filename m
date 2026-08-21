Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADE42C5DF8C
	for <u-boot@archiver.kernel.org>; Fri, 21 Aug 2026 18:49:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7487540A17;
	Fri, 21 Aug 2026 18:49:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CMQ9rJ052iFS; Fri, 21 Aug 2026 18:49:46 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787338186;
	bh=AIPZrD2r4F5r0DScOItjEJHH89P8sTcGVW8MU0VxYaE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=1CaYkvQ+Qc1s5ad79RI7kIN52y9eMq9650hh0XgO4Y3LhkRMyilWkVmbD9uOcfKSo
	 L9QIk4oQLw7ao4D3KRW1xi43oDr7hIlvRwPD0ypzwT9VnW4nEuuBsM7U+OoqXG4DCe
	 iBtLlBJfjb9cCvVaHG2J307RoasmmPt4KXFs1AyV1GSdnI/QmKyGZRj61ylu2nmXUR
	 KaCms/unMIUihCFiClhvLiWoi7LCNW7463bVagvuGm+l+uAtRw++WBqtihT7y/zoBg
	 UvqV/N+18UFTf1nDzZXmShgLknv2IlEsJuQbrQ7MHDHxjh8RK/AItrV8k9kqXnxFEJ
	 67/WNNWahvNXQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9F7114097C;
	Fri, 21 Aug 2026 18:49:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id BB0F9336
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 18:49:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A96ED60AB9
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 18:49:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qhrMckRiZP-k for <u-boot@lists.u-boot-project.org>;
 Fri, 21 Aug 2026 18:49:43 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::5;
 helo=duzpr83cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=YIpCSet7
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 77B09606BD
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 18:49:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ql0BUcFfUZ24C45VhLIb9PVtOMMbAg8uwTrAmMLv5Tnk/uKPP4zituQ1/woz7ib/GanErTOcfa38K3d25433wG626NaIK1ceN7kjqkFbrSh7IpcU6XIIgE2oX8Xjr6NgqoaV73WPDpMrZHaJY9wS03fGPrVzUua4ka3YWFA95wwnuSLx3gEh8aCSlgMyel7aNUR+0OH1THnu3j+zbR43a5YyH8x/5lwoLVDwOgPAm9duQPq3bU8bus/+5S9h5h20a3DfIKupUK6pdocps/XIBVcNXb4VlR23X5CrMbS0jnu2dEeiqXZwGFdKOBG0xoIdTe9l4pz6wvm8SJHi0AYc9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AIPZrD2r4F5r0DScOItjEJHH89P8sTcGVW8MU0VxYaE=;
 b=szlrq574bkpn70b/eND8ygk95rm2yVikcgPjfEFh64zJuItIQ7aFLsRpcBONYMcwF1UgBcpzR027k5uEBPUb9cyiwLwHUHNVEP15CbMU9dFvbehheqjuxkIuW+S6iiqG36zUIfsz/Zp/ijBok2Kla61BLEu2LIpOKEkGAZW1nzeC/kXOmdn7SEVzbk0EZNBi36LWmGj93KosXcVtS+26BdqCsXKJ3NLWuiEtba1oduOveTsHiuzbrr+wBpsi2XpCtmwjW8ZB57bg8/zUST5bTVNuGadx0ZhD3sVBP1zLpzPbydqSob7fxc89OpKSdTQTmnk/z0cje3SJCjO+q249uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AIPZrD2r4F5r0DScOItjEJHH89P8sTcGVW8MU0VxYaE=;
 b=YIpCSet7723XQTZmfMTpZPijNxgOKMYRFOEDqEIh75l3tZDqJSVL92NuSEZUftMmIU32B2NeRTHVOfCk94ICiQnu5EK18/ii7JwuWimKpWA/67ljQZz0+ae7D94kofmZgzhT3nT4lFaSqpYZ0U7UCLTs36rMdSiWRbBvEP7qLgk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from VI2PR04MB11147.eurprd04.prod.outlook.com
 (2603:10a6:800:293::14) by PA4PR04MB8062.eurprd04.prod.outlook.com
 (2603:10a6:102:b8::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 18:49:39 +0000
Received: from VI2PR04MB11147.eurprd04.prod.outlook.com
 ([fe80::c859:7e6d:9345:afe1]) by VI2PR04MB11147.eurprd04.prod.outlook.com
 ([fe80::c859:7e6d:9345:afe1%6]) with mapi id 15.21.0339.008; Fri, 21 Aug 2026
 18:49:39 +0000
Message-ID: <246f8c07-d77e-41a5-bc67-5f77c1c522b0@cherry.de>
Date: Fri, 21 Aug 2026 19:18:46 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/6] watchdog: report effective timeout
To: Juuso Rinta <juuso.rinta@nokia.com>, u-boot@lists.denx.de,
 u-boot@lists.u-boot-project.org
Cc: Stefan Roese <stefan.roese@mailbox.org>, Tom Rini <trini@konsulko.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Yao Zi <me@ziyao.cc>,
 Antonio Borneo <antonio.borneo@foss.st.com>, Peng Fan <peng.fan@nxp.com>,
 Simon Glass <sjg@chromium.org>, Aaro Koskinen <aaro.koskinen@nokia.com>
References: <20260818-rinta-watchdog-gettime-v3-0-423f5caf526d@nokia.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260818-rinta-watchdog-gettime-v3-0-423f5caf526d@nokia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0058.eurprd01.prod.exchangelabs.com
 (2603:10a6:803::35) To VI2PR04MB11147.eurprd04.prod.outlook.com
 (2603:10a6:800:293::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI2PR04MB11147:EE_|PA4PR04MB8062:EE_
X-MS-Office365-Filtering-Correlation-Id: a5d4e0ef-f597-4d99-28ef-08deffb4f449
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|366016|7416014|376014|23010399003|22082099003|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: 5oSKCv+7cISkqtwXn23xI3rbfgB5ugpRuxpLH7OGny9suN5EQO0ksYBmGOCQcRTCdpbLA3FRgUAcVZiKx8Tza43uOLwENR1KHfirKgqbBn4wNDNELRHPSupLb866wvagyKViSO0uTBzuhVNc1AMGU2QdC7m4uLYmALxh+ikiLbN1pNWCBaJZWr3vcn2MbwDk66F/rPBz9JMQax+j0W1MhAM9ooezTC2dlAtpntHzR3Wm+PyG3OdMroRKCQkkQ9qRC8Z3cYipMwz1X7q1oX5tjrQyFp+yy3o3Qlc1rFCuAmiHE3jZ04iWlLutGQeUuO6MlOAY6u6sUqt0PzDcMxAuLqP9hT9gaMmjKXHupajHXfSqdo8wwT4gLVklzGqruekbf5+s+a+fZHnHmZxDJI/CTpkitp+8NlfvYXG0r+NQq7gpP8oyEZymfG0vYMQszSc5WPS1qo9tShxbgYjlPRrEp9l2vHH+lmUyLzS0viKcPHWpMhJtSPy8HLHDf3lgn0pb27YSvpkRFUtKPXFKhKYgKvnN92Qk91XoNtvwYWagIjaDsujkbzemGIacI0bOIlHzcVL4aWQMK48Gn7Di0JhwIf3Q48dyIWb3g5GjsakoULNj32MKhHGSyEJ8Miv58fwZeQZufBzxSypgy6I8YaoRO1LE2A7W7Tm0DaMfEfsC9DQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI2PR04MB11147.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(366016)(7416014)(376014)(23010399003)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YnBoZ01XTGszZVdlb3Q3UkxiOS90ZXJEbHQwN3VzbTBiUUxlTmVKMHlodDBE?=
 =?utf-8?B?Wm1wU3ZFaFU5UXJhZElLaUoxb1R5SVpNZlZJb29oU0tBQkFEMSs3akR4VjRl?=
 =?utf-8?B?S0tkaUY2SjJmN1hOUjJKek15bWJTZDFnVzlWT2RiRnpnSnJxZ1h0MGFvalFh?=
 =?utf-8?B?QzFIVUdnSFM4Qk14Qnh0M29RSUFHa0NZS1lNdXkxV1c2ZjlSek9OY2o2bkRp?=
 =?utf-8?B?Y2x0Z0VNMkFMQkpyQUljWmxUaUVUYjRnUnVyVklyYWRQdERBVEZpc0k3cXN0?=
 =?utf-8?B?RTZwb09lN2svckdXdUxXdFZDeHZDNDE4eGczT1dVRmZ5TjVOWUZMWExxSGNq?=
 =?utf-8?B?SVhtUDRvY0FIMGRTanM0cjlkWTFkdEdIazFLQmsrdjFqRnF2VTJha1NmcVJF?=
 =?utf-8?B?Y3hEcFJpZ01oL29MeENiOHpoeEQ5RTM1MkhZTVpVcEg4TGl5QnVkZEV1L0xO?=
 =?utf-8?B?cENubW1nOEQwWXVLODRJUmVKaHo5U3F5bWFWYlUzUGhQS045YWxBbGlaUzl6?=
 =?utf-8?B?L1lFYlFsak1wTmRRbmdnNFc3RnNFdDF3Q3prU0R2R2lSMlVrbm1zOFJGY3dn?=
 =?utf-8?B?QmxhQjRaUWMvUXhjTW5XVWIvYXh6RTVqdVZCd2pIdWl6aC95K2lPZnFwOEhh?=
 =?utf-8?B?KzVtdDFESnhEZnFNeXk2bkNwZldjWGthbGlkSnVoS09jeGNqZk5FajBBV0Rl?=
 =?utf-8?B?WDZVRXNiTEtBOWQ1YU9SZkVKQTNLanFWRUdmT2hpTHhWQUxyZ3FJL0tBbW1E?=
 =?utf-8?B?MnIzMTVjRDlKdGQvWDNYazRHOFZEWDRwM2pzT1N6ZkxxUWU3VkZvZ2w5S2ox?=
 =?utf-8?B?MVhTeHZPVHR5RWJ3dExJdmYxMWcxTExuQWo4N1ZWQXRVSnRrMm5manJrZ0w5?=
 =?utf-8?B?Nm5wZEs2dW56RDRVd1dGdGQ2VGREVVZFZ2ppZVljbUVVbVNrVUtqOHBTRVA3?=
 =?utf-8?B?M3VEZWlUb0tjSWZheURKZVI1akVJOUFjbjZhQlVoK1daYUEvK0JLakR5N0RR?=
 =?utf-8?B?TGFHTlZ0U0NpMTBRZlgrY0pFaTI2UnpUWUxPWlVEVExhU0xuSWRIaTRTU3lN?=
 =?utf-8?B?SUFlM1U5ajFNaCtVYmxSbFk3ZkRRVm1DZGd4T3BQOXFSNTRoZGNIamZWUmwy?=
 =?utf-8?B?S1h2VGhvN1VwL3dReDNtZnVwbFJ5WnVGM3lZdHB6VHkwdktVWllIcTRJQTEr?=
 =?utf-8?B?UFRtWjd2bnplb1FsV0RJQ2RJQWlVVVJNL0c3K2tsWDFsOTJsc3dMVzZVS2x1?=
 =?utf-8?B?dmRTcTZQcWlrcmRuZWtEVWpxTjhUa1NETC9oSTQ2QmJmM2hxd2VkdmRtakhQ?=
 =?utf-8?B?SlBYQWJwdlBHSjVkeW8rSXJtd0VPbWVtNTBVUitNeUR2YWljVGU0UUlZUmpv?=
 =?utf-8?B?WjRORnJsYmpyZzFmaElLYlc0UkdjUldnYXFmeWU3QVVkbU9nTEg3YW5JbGMz?=
 =?utf-8?B?S1BYMzNzcHBLQWJ1elZhVUZQSlFKaUZ3VjYzdmQzSWlkVE81L2FQcEtXbTk1?=
 =?utf-8?B?d0w2eGN0d1dHSzJjZVYxcWFQbE14STFlYVJoOXFSeXpXdWF3RHp0WW1HczMy?=
 =?utf-8?B?WnZsa3NCNUs4U2kyeHl4S2xaOTBWazRoNDU3M083dXlNeU1ZUFdkbjBCQ1pZ?=
 =?utf-8?B?RlFMODU2cmxZdUtmS1RrekF6eStqV1VkVnF4UElpZ3FvOXhFM2gxNEdVdjlx?=
 =?utf-8?B?N2FQNjMxOUVWS1dGdDgrWnhlbDk3NkRLTTBKM2FldEJGaWdkTHhtZ05MUFJ5?=
 =?utf-8?B?dHMvdnpWQU9QTmhhSThjN0o0SXIxUzdVeGZ5djk4T3pkYVpGWWQ3YXU5ZlNP?=
 =?utf-8?B?MzZVSWRMc2NqQnphV295RGxvQUo2aUJORjltcUxVbE1Rd3VjTmZxVzJtNXBU?=
 =?utf-8?B?ZU1TK0xLTEFqTklxVTZEVEJwWStWa0EwV3EwNk1YWkZSWTlrYnJrL041eWxv?=
 =?utf-8?B?NUZEQklQS2IrWEQyT0U2MkdPTU5rdXBxeWNPY0FENnFlN2ZtT0h1MUlteWFR?=
 =?utf-8?B?NWVCRFVocmVicDY1VlIrRHRkM3llcWh4WmhpbStqMEFGRndTK3VwVW5LRTcy?=
 =?utf-8?B?ZjJsRlBvRGI3YU4zOFVrZ1lITWNGRmYwRTRnRDl4REM0NTVTUWt1disyRUVO?=
 =?utf-8?B?SFN0UnI3Nm9FbCtoNEJ4eVk3aUppYng0ak5nRnpRVlpxQlZJL2ZHa3hDSFVI?=
 =?utf-8?B?VDVaaWJPSVFKY0lOZnFSK21hKzdHZk41eFJ1SnpLc1VnaURkdDJzY1hoR1hh?=
 =?utf-8?B?bmIyMGZkbENZbk9WQXJPQTEvSFQrS2tZRXRBNi9BZHZuWThmeUFybnRFUkY5?=
 =?utf-8?B?YlBJUkcwK0dEdjZHUysxaitHSlE5WjRJM29sY0pvRGJkQ0kxVUhBYmRsbDNW?=
 =?utf-8?Q?+/lLIHV+x0llz8BFyUhwC8N2+Pe5d4V7B4Jck9i1zlhGt?=
X-MS-Exchange-AntiSpam-MessageData-1: EQEew/bCuwQaaTp2eYCbDORmkvth66HTU5g=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: a5d4e0ef-f597-4d99-28ef-08deffb4f449
X-MS-Exchange-CrossTenant-AuthSource: VI2PR04MB11147.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 18:49:39.2663 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0yvheR4qD/7xs4bXbbH4EwGabJ+PRqD9N7serB24Do5UHT0jJrL2xpPUuozP5UdmFUuhClK3mNrKI7k6qMfYplODuesJ3KiqHgGtIADvw04=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB8062
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

Hi Juuso,

On 8/18/26 9:43 AM, Juuso Rinta wrote:
> This series provides a fix for the wdt_start() function, which can
> print incorrect timeout values in cases where the function is
> called with a timeout value greater than the hardware-supported
> maximum. The current implementation prints the requested value, so,
> for example, the console may show that the watchdog timeout is set to
> 60 seconds when it is in practice clamped to 10 seconds by the device.
> 
> The series introduces the max_timeout_ms value into the per-device
> uclass-plat data. By default, this value is initialized to 0, and
> drivers should write the hardware-limited max_timeout_ms value into
> the plat-data typically during probing.
> 
> If the driver has reported a max_timeout_ms value, wdt_start() clamps
> the requested timeout_ms value before calling ops->start(). The default
> value 0 is considered "limitless", i.e. on drivers that do not set the
> value, the prints and the functionality are unaffected by this series.
> 

I have two remarks.

1. Is it really appropriate to have a timeout smaller than requested? 
Maybe the answer is that we should fail if the user requests an 
unsupported timeout?

2. I'm not sure it is enough to clamp the max. The Rockchip RK806 PMIC 
has a watchdog with only a few possible values as timeout: 50ms, 100ms, 
500ms, 2s, 10s, 1min and 10min. Experimentally, they are not even that 
(though I don't remember exactly the actual values I found, and I don't 
have access to my notes as I'm currently traveling). So, I'm wondering 
if we shouldn't update the API such that the driver reports what the 
actual timeout is, as it may differ from the requested timeout (if we do 
clamping or rounding, even with non-max values). wdt_ops->start() 
returns 0 on success, but it could return the actual timeout for 
example. I would wait on Stefan to chime in though, that is a much more 
involved rework and if Stefan doesn't like it, wasted time and effort ;)

Cheers,
Quentin
