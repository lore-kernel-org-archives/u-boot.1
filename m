Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AB44C982E6
	for <u-boot@archiver.kernel.org>; Mon, 21 Sep 2026 15:27:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 32EAC80CFE;
	Mon, 21 Sep 2026 15:27:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Yv-i8EN4K1TB; Mon, 21 Sep 2026 15:27:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 3E19980D18
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790004442;
	b=mB61xdNqrmbSo4Loj6v+xvbsoysu5Z/QQS/OnyLPQLyFOYKvtgROfqUx1B73S4f/Up0H
	 qqVF738n9JVSSI+/z2znSZ6G0SacgNtVqcXn/wqWMH1GYuFBrw1U7DC/Hoy4zs07XLfjL
	 BubjqCff643E2tArCVgsekf82Q8hXEoloU5zu06B0t/2Yb4J5heQDxVdvBk2zVRVHWuEM
	 UsvEvCMmOufohRWfbgDB0u+AK9W0IzEfE28BE3D4kby3TIHGM9ulMYDGDZ74jehU6b1vM
	 e0wooDboBYO5p20GpBdkSzdTo+XZc2KuBaZEnEQ/aTZLY1i+mG7Tfq0fYrdOtECR9nw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790004442;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=qZygWANt2C1OSlHJR+BSMYqt828xQbzjfOnqy9uGDok=;
	b=qWZZYXOWYg24XkDkyFyodAdq8SBz3mPpwzD58+x90cwlt3z1c+dAa/0n79H0K/8kbOxr
	 g0duRI22MQc+cs3E+gEUbdetP6GJhQ8U7ZbQtQsoBrYSjJ89Ak4K4Bw1eQs8zYr8ICnNk
	 Jn6KThlgJSSkS9d/vuQ5K+soXZPaiCf6lrq/D8H97LFxYhcQKZhTVYCfk0HvsgTAdkYAG
	 Xblxx3bGcyOphlGXEv6CfpbAYJe6FohR/8IFFeuvFvbVv7asm/5n0IlaA7jXvKv9pkkmp
	 CLGseO8rzD6hRKlkrohgCIQ9i0dEVxQjILEskCMM0XjMS+uZadNn/I0ar4OmBSyu8Dw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790004442;
	bh=qZygWANt2C1OSlHJR+BSMYqt828xQbzjfOnqy9uGDok=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MgJe6oT5ctz4ji8pZ9a7FCp8EUn15IwV8WFLQya2f4S4F4JckMZYDSI7k0iESBTso
	 9F05qt9QzvySGloqwUuvgYmUI95e/5OGh+6dGmmwzKHEYdUC28M/ieP5HT28FQGyGV
	 00bSxfdri121lV2KqienKzMSTSNdGPu3dPCAoU89BeiZCJr9jMFtkSQfIviVGDI5uG
	 fPDiyFlU2Xl7D2ktezg8v2WGAUFd/13DhomEZkGGAFehQfOnImrKQtmldSO4ql6lho
	 /dr47b7il7rVVpdotxSkUC+BArmp/nCUX/5f3q/QV/EG5N5bN/j9O96bqZRlWKlUu3
	 raXtakgrRClRQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3E19980D18;
	Mon, 21 Sep 2026 15:27:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 705563A5
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 15:27:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6DC3C60710
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 15:27:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Hh28x40Sa_NX for <u-boot@lists.u-boot-project.org>;
 Mon, 21 Sep 2026 15:27:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 3DD3F6066C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c207::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790004440;
 b=a9QpQwcywA4QlP9KQ7wtliuEfYCE57y5LTgDEh+DEvb3jgUbJOMRBUr/8TdoQQpWSKaU
 4HpTQQMe9/nxy5JJQG1yfgDFEeA6kW/xTqc/0FP2e7p/Sk1nUSXAuuaSOjJFGRdsAuaxD
 XaozCpQulr9D9LY8X6u4P3hk5khEFHh5NX0PEZGxn8qn7/tzGdD7kJ8DH70B4GNEl51we
 yMONgWThJHUuOZ/CueFHiYA/lhxtMhvFmBaskl+AZQ+GriWHhfdgvzw3mt1LJv81XvQ1E
 L+cUX0E6azU+w2oERUvG8wjWuXGHZgx5hcFYYneKj7FTuMW5fCKC2ph4dLQ/A1O4Ujw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790004440;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Date:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
 X-MS-Exchange-CrossTenant-UserPrincipalName:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=qZygWANt2C1OSlHJR+BSMYqt828xQbzjfOnqy9uGDok=;
 b=X/HTvYKb3Rb1h16tpNQYTz032oSd45c7Upz14TSCD3k5K+qw/vkyXCmq1iUfCIFSf/0v
 HGSoqV/iyldvRG4ozy0aHSS21RSeE7C43ZfoVamwWX0RBTk7uJjR5G1dRmruBbP4ZK+ui
 zi1TpO/kKXt3rBBV7bpgov5EPovgpT7EEztt5seo3W5FKo+5B+4bbwaUD6cjLHJa/GWXt
 RDN7ZQ9Bnal2yCRCXgirQSQ44mQ0ELOnDvmWiek4M1kMqOd4Bz3/7/el3HaVOVB71lzr4
 jc5Q/TPLJiGW3iSQqO8Hd3CO95A+yEWRnV5cVz6Mk8EE9ziQycrnhcjyzo3j9AWYV3Q==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=cherry.de; 
 dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=Ty9iQRUG; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c207::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c207::3;
 helo=mrwpr03cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=Ty9iQRUG
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3DD3F6066C
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 15:27:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j6hePH7P7DeGVXeHioaVJtrcIQwBtkMCxocXfu7sqTksFcwZsqzpxtG4jcml1LV2+cmKcOgqpy13HflOv9XizqzmJXpEZvfox2i+KjK0r+s8iGd2pjRKZXuCezNtYaDjDKdOlsiqGg1JMoM9kFLfi6BzOWUEo3NYPOoWhW7KOUU2LuQiy3RwfPOLlskRba1nb1q+UjqXtjwiH+LqsOXtCoOIxbphPGnyy9LAJN2oZIWATQrp5dIcRDjhRgJwrkt8Ej1tDw3hiNIYlC88IOziIg/PE0U5z4JtZY588muG66nTGHopqKNvz6Aa354Vvb9R6yz0b3ufS84YOOHstFS1lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qZygWANt2C1OSlHJR+BSMYqt828xQbzjfOnqy9uGDok=;
 b=jceFfmTRXf+R3eHRchi1+MU/sXvkUM1He2PeIqzILt7EkVoxXUeyQ4cdvLJ7dq3D966d+3UbGf4MqFAP9chcmA+IQ1YgYaA1hnQHCZwr+/CODZS8n8Fhw3k/O/plSb9hmsTIRoc+buejd0GosWvQtNI3bGTO2uYxIkY8FVHWvRVLeemsLb1xd38kKITCbKRZRi3f29uU+9akxI/kMmlqVPVqj7FftXo0DIchWY4O93YZ9+aN70QrtlJL15zeahDuBaSrRRmdOcsh+YpeSEi24lYDPeBC/DwE3Vm0u4DztVKi3sDyf+2MftCMMM++pKGgO8ths8rnZ9uuDzfFqvq2tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qZygWANt2C1OSlHJR+BSMYqt828xQbzjfOnqy9uGDok=;
 b=Ty9iQRUGVv4Zducn2pALEGONCmWIr01QOrE+DaTAo4NLOuhk2jL+0u5Qu9Hq66xUSTi1x2KU7ttsg/i70/JouiyrdvColtog4zqPvJ/yokZxxDkQABxLfaXZA9FqPSgPHSh6zLG9u4xBoRvTkBXYLXEMX5/ZJnaRRSFRCOsmQ6Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by AS1PR04MB9357.eurprd04.prod.outlook.com (2603:10a6:20b:4dd::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Mon, 21 Sep
 2026 15:27:12 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 15:27:12 +0000
Message-ID: <33e01488-7295-49d2-b9b8-c194e064f5e3@cherry.de>
Date: Mon, 21 Sep 2026 17:27:10 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/11] boot: image: Keep the image-type table out of xPL
To: Alexey Charkov <alchark@flipper.net>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Vincent Jardin <vjardin@free.fr>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Michael Srba <Michael.Srba@seznam.cz>, Cole Munz <Munzzyy1@proton.me>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Daniel Golle <daniel@makrotopia.org>, Simon Glass <sjg@chromium.org>,
 Francesco Valla <francesco@valla.it>, Anton Ivanov <anton@binarly.io>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 James Hilliard <james.hilliard1@gmail.com>, Quentin Schulz
 <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Johan Jonker <jbx6244@gmail.com>, Aristo Chen <aristo.chen@canonical.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 =?UTF-8?Q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>
References: <20260918-spl-fit-compression-v2-0-28e946f57357@flipper.net>
 <20260918-spl-fit-compression-v2-1-28e946f57357@flipper.net>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260918-spl-fit-compression-v2-1-28e946f57357@flipper.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P189CA0017.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::30) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|AS1PR04MB9357:EE_
X-MS-Office365-Filtering-Correlation-Id: 15f4b141-c91a-4763-ef39-08df17f4cee3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|7416014|4143699003|56012099006|11063799006|10067099003|22082099003|18002099003|3023799007|41080700001;
X-Microsoft-Antispam-Message-Info: 44XKi2mFbmS1HyvWgIKETkbbKmbCTfA6Ah0/qxq93AlUni31NVJj3pFU/RSbxscrxV9fhul4r9sY9FXTdnpBqC3NbFWbAs2caNDXNq+sNKw1jKcC9oeESspza1HSkrhmWF5A+07AvFkcglox8ALsmnLqpse0A/O99wZDvHzS8WC6uTM46eB88iBPGAVP4MiKyUiy2CEVZF94zN9g0Gz0tOpXYYv/jWqH7JjkeWNom4vD4CxRk3wN8PMmDyRLZML2Gj08osm2bQAixkDPNeUUDxljUficULlYfkl0FRPKOCg+gve198qb0My/oyKmKUoKQJzD9QqoxOTysWaFlScqfpRsejqafQ7VuJfdfzNSxIsYj8X4/KSlSCzjyBNzBPFusNL16QumVrkxalW03vLnWGDZM+JH96veXdqDyvveynwPWVEGU1VFugkV6O5lcc7sSa4R8PMIC0lksrHH5NanmSPJINisByUPxKYfND4+QTCgGU7yn0po5tvXIhF4IOuTuikY5OcbzPZZ2rwTtVAmJ9MIuBsjq4LyYXQlEcYEPdRbbQ2vV6rRw1S8a/8nXWzsaDwNpYYFLC3Y2HBF5ShpcziFvJDj9Q3IAjhTds533r5bMl7u95HED/uBh+JWU8vVp+Cv6qNE9kqGG/GOML9w4qy7L0NnGkjAuInHVQxKOMMukqcf66GjweSn5qjIggFlLjv2i3l0kDvsPHkDFVrcPw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(7416014)(4143699003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003)(3023799007)(41080700001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eG5NUm5IaVlwaHN2U2ZOajBUQjY2QWxvRTIzYzZMUEpqUHBIWGtGdHA2MEVO?=
 =?utf-8?B?bk4xS0VrMXZJN1h1d3R1ZHRhcGIvWUcyQmw2c0FwRXBZOXh3OEpsNWFyQ2NJ?=
 =?utf-8?B?ZHVBeVhCVlNETkpVcXh5Y3liSGZaNzFuL0hyelRYNDZVeWVuVk9ENlBPMmtQ?=
 =?utf-8?B?Vk4zMk81TEpsRUxvLzI3K3lxdGhGUElXTUpXcE1vZkpua29JMVNZTTV4N2lR?=
 =?utf-8?B?enNhc2R2UXlqNzV1aFQwR1dwdGdmMThmQjlranRZZE15YVZoNm5zd3M4bVAz?=
 =?utf-8?B?c3Zpc3pFWUNOTlBBaThpTjUrSHUxSXdjRTVlS1VYWXUybkxZNkpHTDkvMWFt?=
 =?utf-8?B?YWtzQm4rdm9veERKNWNjVDJWdnA5cHBHV2RQTW9ZSEpXYzFyRWNWSC80cjM1?=
 =?utf-8?B?RFJFdkY1ZUk1amp6d1FhSVBDNVlWejBlMmkxVzFZVllRSmlXQm5ZTG9EK0Ra?=
 =?utf-8?B?dUxYY1YxME9uMjlmczVNekMwa2duMVJtTGoxZlBKU2U4blBlMHo5Z0F4ZVVE?=
 =?utf-8?B?NW0yZEZtZSt1WTZqT3pNMlAzV0Q3RCtBUXdmdzQvQkd0aVNkT3o0MXlrUlhs?=
 =?utf-8?B?R0wyNjFiV3BDQzMrMUdoY2VQcWgrUUtxREh0eWFsVXV0MUtHZEJrT1F1VG9V?=
 =?utf-8?B?QWluRjQrcWNod0ZYMkJXb2FRcmVkOFBpbHNpWmFNUi85Z3B0SjNsTERCTzMr?=
 =?utf-8?B?TDBycDhCcXZxR2R0WjkxT3kzOVdaUGsvd21Bd2cwL2g0dGNzWXMyS2ZRUklX?=
 =?utf-8?B?ZDIrb083ZFpMY29QMG1YZ3RuOUNOSkpoWnBEUHNPOUJPUEhJbjJWVGhsK3JO?=
 =?utf-8?B?WmNyOVM3SHVPSVBNeFZyOENGM2VKcTg5RGZHUnFibDNncUw0cFpDSDgvWVZE?=
 =?utf-8?B?R1d2eTJPT0ljazhqQWNiZkFtMlJsY2tUV1JqRGdHUEhBald4eDQ0SjVnUUpo?=
 =?utf-8?B?bzdFTU9vc1hOVUJldk9tQWpXbnhlZFMrRTBiWjFKOHZ5Q3BEVEJWWFRSZ0pt?=
 =?utf-8?B?dEJ6eldna3U3bFpLcEtVOThtaGJMQ082NUZYaFRYSW42aGFVWDMyd256SzNs?=
 =?utf-8?B?K0sxRGZHUEtrMmVOVE5qSTdjeUU1R1ZwZnRsQ0U3OGg0YXhJRk5ITGVHSXRm?=
 =?utf-8?B?OTVxVXNGbXR0dXRjSDZLVDFlYTRQUnpBY3RaNGFyeVNXWXN6KzFmRVo0YmE4?=
 =?utf-8?B?Vy9odEwxYm5xdmtiTHdJWXgwTkR4MkM1dVNsL1lWby9yTVNIVGptMnJweStZ?=
 =?utf-8?B?TFlJdTJoZ0RDK1R5QWxCWmNUajRKNytmdk9jRzJiMXkyaUc1cXJVN1dsa2FY?=
 =?utf-8?B?ZWJaNmp5N2ppc3cxeXl4ZTJHQ2ZXWEo3U1p3Qk5BbFlzc05hcjIyNU5LWVdk?=
 =?utf-8?B?cnNmWk95MXBOaEttSmZmai9ueGUwdzNWMG1WVnFoM1d2ZDhwSFFHNG0zQXB0?=
 =?utf-8?B?WTdLdVE2S05Tc24vbkkyUWdkOEI5NXExOCtNaU9JSnp4V3V4SGVWaS85M0F1?=
 =?utf-8?B?Mlp2Z0xHbk10aVpscDBkOXRJWUZYbXJNYWFPUnd0OWtIeGNZQ1I4VHRLbGx1?=
 =?utf-8?B?UWUySFh1UFRkWU04Vk91Mlc5U2x0TTVUVkFGY0s1RFhzd3ZLOFJrLzNVbFVW?=
 =?utf-8?B?TjNNVVFueEkyVnMyeG5yTkM4cjZ5ZTNEVlRpRWpCQWdheXFxNzFseEFCUnpY?=
 =?utf-8?B?enMrWTQxM01lbUltMngwY2htRzNqTEFLbUI1UWNqeUo0Z3V4S0thTGZYUXVO?=
 =?utf-8?B?WGNrd3NlZnREZjZGeldHOUIvZlY5c2ZZTkdmcnBndFJXc1cvWisvWWtHeEVL?=
 =?utf-8?B?eENpYzl3NXh1b2V4NHJhRkE0L1ZzN1BHQUF4MFhnWDdlMStJbUVvMytDMGNW?=
 =?utf-8?B?ZE5Wd0YyL0IvWmFjVHBJamFoUjY1dFhQTUIxcVBRdUN4eTg2Y1lQVVZEdGJC?=
 =?utf-8?B?aGcvdi8xNlhNaTdzTEEyRVVNbHBwd1JLS2dYQUZROGg4aG1VTFNWVkJjVDdi?=
 =?utf-8?B?UkRHRHNaVlhsL2RRaVpCY2xCS2pFaW1nbHlsU1VuT01FeURicDAyL1BLTm1p?=
 =?utf-8?B?YlBvTDJaR0dBYUNvV3puUlFQK2M3cUVuenNqNk5kd283ZmlNNGlhOEZvRlZU?=
 =?utf-8?B?TE1yaXpjdDNEQ3hSSWY1RGNQYnErNzFVRFlnTDczR3ozbEZPdFo5Mk1VMEVa?=
 =?utf-8?B?KzlndHIvcjZTSWYwSHkvTXNwMnVCMlR1cXhlcFVPanRQZTlvVklwL0RkTWs4?=
 =?utf-8?B?Y05wb1hLYlBkMVFYWDdMSk5Fbmo1dnBoWFk2U00xQTRKZVBpdEZjVUM1QmxY?=
 =?utf-8?B?RVpKWmVGak51ZVV3RkdQbDVXWlhEYUVVWVVkS1E0VzU4YnJtT2lxdz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 15f4b141-c91a-4763-ef39-08df17f4cee3
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 15:27:12.1967 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YWlcE7kXkLtA0uhdzV2gOkBo39OaEW1+/+1uGGcNcxdZToaHTgxKN7h8Oukmibp+LQ10/zDQIHnbPndjmVKzLf1FN+3W5hcq6HK1MT2AYCA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9357
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

Hi Alexey,

On 9/18/26 12:52 PM, Alexey Charkov wrote:
> print_decomp_msg() names the image it is about to unpack, which drags
> uimage_type[] and its strings into any phase that links image_decomp().
> That is about 2.5KB, measured on a Rockchip RK3576 SPL, spent on one line
> of progress output in a phase built for size.
> 
> Name it "image" there instead. U-Boot proper is unchanged.
> 

Would it make sense to also print the hex/dec value image type stored in 
the type parameter? Considering we have:
## Checking hash(es) for Image u-boot ... sha256+ OK
    Uncompressing image to 800000
we know which image we're trying to uncompress so maybe this isn't so 
important (provided you have access to the original u-boot.itb and know 
you can run mkimage -l on it).

I tried reverting only this patch in the series and I get
    Uncompressing Invalid Image to 800000
which is a bit odd since we actually should have a known type instead of 
invalid image (standalone program is what we have for U-Boot proper). So 
it wouldn't actually help to print the hex/dec value and would even be 
more confusing to the user (well, except if we fix this type being of 
unexpected value).

Cheers,
Quentin

> Reviewed-by: Tom Rini <trini@konsulko.com>
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
> ---
>   boot/image.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/boot/image.c b/boot/image.c
> index 185d52ba492f..a7dc69e858ad 100644
> --- a/boot/image.c
> +++ b/boot/image.c
> @@ -416,7 +416,12 @@ void image_print_contents(const void *ptr)
>   static void print_decomp_msg(int comp_type, int type, bool is_xip,
>   			     ulong load)
>   {
> -	const char *name = genimg_get_type_name(type);
> +	/*
> +	 * The image-type table and its strings cost about 2.5KB, which is a
> +	 * lot to spend on a progress message in a phase built for size.
> +	 */
> +	const char *name = IS_ENABLED(CONFIG_XPL_BUILD) ? "image" :
> +			   genimg_get_type_name(type);
>   
>   	/* Shows "Loading Kernel Image" for example */
>   	if (comp_type == IH_COMP_NONE)
> 

