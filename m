Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13429C5DF70
	for <u-boot@archiver.kernel.org>; Tue, 18 Aug 2026 06:16:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C3AFD40720;
	Tue, 18 Aug 2026 06:16:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rQwWo4BtLVqZ; Tue, 18 Aug 2026 06:16:36 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EDB9240840
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1787033796;
	bh=zv/Fmjc+sdvbH7qh9q5yGPJ4L3UvMrRPx0lE3ee6ngg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TTZNb8RTSWFjuM95cOnr/vkxCiVuAwwMQM57+cnKGP6j0DFVZUqOsxsJ/C+pV4N0E
	 8SqdTHYR5Ptr7V0TcXO+7BUqrJ9PnIReBUPBAEGhT3UFDn5/h1xLYcI6Sl9lxBgPt2
	 lXoAzaFpua100IXoJ2u4G+/1yfSjwiFEI31kRJ1hOjFqBgkzRed2LzHiJ9MzNekh8M
	 Au0APk3R+JoOOTEeOz9MTnb4Q0I5zP0qRYggcKkqXG6D3UOP4yYPhjB1poRvCnW5dP
	 r0TO0MrX+uYoDUA4Ug6T0CPGPMWW+B4T1TJWsczYSIVJ3DdO/jzqux8ZfFBT2TNvv/
	 XsDJXTQ1uH13w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id EDB9240840;
	Tue, 18 Aug 2026 06:16:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id BD77F322
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 06:16:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A37CD605DB
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 06:16:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id liYwWX59hrGp for <u-boot@lists.u-boot-project.org>;
 Tue, 18 Aug 2026 06:16:34 +0000 (UTC)
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::1;
 helo=db3pr0202cu003.outbound.protection.outlook.com;
 envelope-from=alice.guo@oss.nxp.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org D498C60763
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D498C60763
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=ATFOX8KH
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D498C60763
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 06:16:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BgJuNDns2E7vgr8deirgVvhPoXDRLvoNUKsw9B4acrjUUo8wMQJWHjX2ivFZkwA0dORFNLpZb0w4PrsTNLmjUMbFaBn35x76+Rf494iMZOMHx3Bs5lEKnS8VSwVlPiTPSrl5z71ncXsfYmZYlUZmC43UhkkmcQk35DwJpDdilwZlNoWtlIxm1+vASMoU7265aXpVKxbe5h4YMNSFFXeFXMJXwV1MTxYXpG7J9CTsDFpfCzD843HnmgX0ilUQT3n+fD8e99bc7RD8ehdtpZ/kaifNGHBe2CSNu137eZo6b8eiCJL5UWkqiMNEvHirtFZEyBxWW7ThwxIT92YojZGOsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zv/Fmjc+sdvbH7qh9q5yGPJ4L3UvMrRPx0lE3ee6ngg=;
 b=n0RnzW/ZHktYS7K5pyi6VkvQBfncIxsRQgjlMUKCXq69ZzN7OZ65IInodE/Y/wYZhNcK8IUJMWlyDa0YB56KAq0WHdKD7GtQ+xbaoXj1efNo0pPtEFYk27nUDs75im4mAaA19Vx9Id1RcbKay4y/RvukZ1XVto4yWldMpp8kl0zWTpwP3uNkJqnDfLcRmE7X5mTom7wTKxtUAIspHmiOzQaDoy5W9zbxatgEZtWbZ7gLsYxXjh/Nw3BKJU0BxUkmA3UQaaeA+KYRfKCh1ytlKuX+J+cd8JvOu2o6c4o0we2JfBv2irwZKKkIxZ0o8BzzoCcHGlp9wiYr9mlXXwRMZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zv/Fmjc+sdvbH7qh9q5yGPJ4L3UvMrRPx0lE3ee6ngg=;
 b=ATFOX8KHSW2G6lLD6VKByecIyOwyKivPiT/9Gn25RVCFcKq0MdIfxAu1bqIHmA07W0wRAA0k8IcUrbtbq/BAMCDmS6r5RefQaxwPK1PbdTUlZBRNT/YPdcPAgm2Pmt39X11vxSP3NhpRy5UwREtr20TXc+5Tasl3qs14bVMpd02looJ+G8MHj3km20axKqQkkxM+TgWC0oX6t3wD076QZWO91shfoQXAX/rfyGiK5hyqxRRKNCPZvF1F8I0O7/fNKBEcixU06k+qLjCMIvEKlYsl90DoeXDNxGe3kn2ZZRSFcCZNa/4nz8jn8918/eGorn2uuJvA+BctOrOPhFaj8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8114.eurprd04.prod.outlook.com (2603:10a6:20b:3b7::22)
 by VI1PR04MB7152.eurprd04.prod.outlook.com (2603:10a6:800:12b::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Tue, 18 Aug
 2026 06:16:28 +0000
Received: from AM9PR04MB8114.eurprd04.prod.outlook.com
 ([fe80::cab0:e4b0:6be:b1d1]) by AM9PR04MB8114.eurprd04.prod.outlook.com
 ([fe80::cab0:e4b0:6be:b1d1%4]) with mapi id 15.21.0339.007; Tue, 18 Aug 2026
 06:16:28 +0000
From: alice.guo@oss.nxp.com
Date: Tue, 18 Aug 2026 14:20:11 +0800
Subject: [PATCH v2 2/4] imx93: clock: add 450MHz DDR PLL rate
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260818-imx93w-v1-2-2b1784c35822@nxp.com>
References: <20260818-imx93w-v1-0-2b1784c35822@nxp.com>
In-Reply-To: <20260818-imx93w-v1-0-2b1784c35822@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Ye Li <ye.li@nxp.com>, Peng Fan <peng.fan@nxp.com>, 
 Johan Jonker <jbx6244@gmail.com>, Primoz Fiser <primoz.fiser@norik.com>, 
 Lei Xu <lei.xu@nxp.com>, Joseph Guo <qijian.guo@nxp.com>, 
 Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: SG2P153CA0007.APCP153.PROD.OUTLOOK.COM (2603:1096::17) To
 AM9PR04MB8114.eurprd04.prod.outlook.com (2603:10a6:20b:3b7::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8114:EE_|VI1PR04MB7152:EE_
X-MS-Office365-Filtering-Correlation-Id: 9aba1a3e-2b2c-417a-cc72-08defcf03d4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|1800799024|376014|366016|23010399003|22082099003|18002099003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: l86otouEnJo45IzkrWx25YtRmm8PjID20bFK4D4y9DGGk9/fJQQ0hl7F5ZBNtdEKMXW7NxXKzb6+5mmPzPFGC4O6xGvVGw1PgL0DBykM30zXJeR1uqja5luFJnBGAnoPsI+fIZqeorpjXdmS4W2noo83s2LDrcBA4uABnHmQ5vPYmZJTSyn+MAuaGkIhS+IhUxR3y1JwPN26UHbTTI+ZxODTINlqPUVuWq+A+oYVFihVylraFzZI/jeKWe2NVf7MluWvXURuVvfYhqW4NJRx9WUsr+zjFfivAZsuAWqxzkW8nL+mSWEalW4cMm8L+vTnkBTsJq6bma/ZEnzy77FYV82zGe98gHWXf+FQ0bvA/cv9jxSQq/Z2mG2UhNmYFOD4/GOUNaRnO+Q8orkpXXFZxY9zUCrU8pA9civobF3skkZDRjvdTv8UFPkJ72fyTidKvQoC3Smwf9qxHkic8KkhMdW3z52fQhGSfbwQzXVlr2iY62s7/lK3hch2Djmu7wK/PYEk0yKrPs2xisOKEhiOSb+bqQ7IIg0+ADLVGh7famrhKHpq46/Ozl3q3BCnHFC5tI27moP0Nm2tOPh9DT4EdQl4awk+qo6HsIFbzk5SxOKwLqKoxgOAEgG0f+sf8FMW8GrRgMCiXHoGW/YyABRXLhHZE3JEJqmTXjREJmXBS5E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8114.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(1800799024)(376014)(366016)(23010399003)(22082099003)(18002099003)(10067099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bkRxWTNvcDRjNXVTbzlHTlJkaXpDc0NmUjNrNWJ3aVZiQTBROVR2dThBOVFn?=
 =?utf-8?B?YUNxR2U3MEM1cCtEdkcyWUh0VmpTa3lPdnErV0ZheGxjYzcxYjIzR25MRzlZ?=
 =?utf-8?B?RGhRYUhmaHJ4dUNPQ0pITjdFWk5PMjhDalp6Q1FvMysxNFVWbVNjRDdmQ0Fy?=
 =?utf-8?B?cHp4WURvRUxUM3JlcnpSZHpwdmlTTnQ4WStoRVRvR3JmNTRNNTI5YURUK0FO?=
 =?utf-8?B?RFJRQzdYb0hPamNQckZHQTZWNTlhS2pBT1U2RUFtdlZjL0NDRVJNN0orZm9N?=
 =?utf-8?B?SVEwVC9tUE5NOEZ3K2NGUVhIM284ZVdCWFdWNlJLWFdYZXpXazZhZHRHWGw5?=
 =?utf-8?B?cFkwY0NhV3F3akpFSm5uSSsvbERKb3ZZVjNGdTJ6M1ZDRkh2T2p3VzZRdmF2?=
 =?utf-8?B?aWdHQ094aWlMRVNCK0FkSlZMMjhNZzMrS3UxMFVDWm1jNkJIL3ZoVXdVbkcx?=
 =?utf-8?B?NVFER0duMmQxLzJBRGpIZ1h6Vm9WQmp3UzRMOU1TOVFVS1BtZXZMc1FmQXZ0?=
 =?utf-8?B?UWE5NVU4MmkwUC9vLy8zKzBqdmEyemZ1enoxOFduTEVZNlpOUUxZMStDaHBX?=
 =?utf-8?B?SXgyYVIxa3d1c2RWd0YxMGJMeWpEbEx1UzNON3RWeHV2cHNDcjJuQlk5N25a?=
 =?utf-8?B?dThaK056NlF2bnJDWkdUSTN1WlY5cTBWSitGclNOdjlDK0ZiNVJMV1Bmd29U?=
 =?utf-8?B?RWdaVUgzdURHazZYYktjZSswcUw1ekI4ZG4yYTNmcEFoTDNhTVlhQy9qVUdU?=
 =?utf-8?B?OTd4OHFTUHlqeU5BaGtLbjFXMGtUTnQyN1JWZzU1TEJjTnlBbGYxU1BIc3E5?=
 =?utf-8?B?bWtUUjBaZFAvM1pxcGFqOXViNndkTWJlcDB1KzJDVkZSTlVUUjF0YjRyR1hB?=
 =?utf-8?B?RWxzN3BocFR0T2V3ZkdNNUxKTWhpYnpWK2kvVnJldzl1RzNidHVMNDFJQmhG?=
 =?utf-8?B?dEFTM3UvZGpKckZQK28rS1g0VGh3WWpjU00yS2ZtUmtHVEdHSG44NVhSWTAv?=
 =?utf-8?B?ZndnM0JzTzVUcmQwQnlZODZrZm1leGhSK2U0NTcwNWppem9iSU1ORzBFT0pB?=
 =?utf-8?B?ZHRNMGFhT2doTkI4NVBaTmVJUUhQV3ByZzdqdXN0TW44YUtSZnhla0krV2ZP?=
 =?utf-8?B?Z2pEek9ZQmozNnIwNnU5Uzk5SWZLeDB6MVk4MkQ3RDYzbEFTUkZBOXRDTFc3?=
 =?utf-8?B?eS96Zm5BaXo0dlZGVVpuamI1bEJMVm1LV25nUjBBdERVOHF3YU9iU0RHRmhW?=
 =?utf-8?B?eGp4MXJnbjRjd3pUZTEyS2hrWVNxRC8zYWxnRDlycTV4S0dxalRFQ0xxWDAv?=
 =?utf-8?B?TEcrWkxaLzNoUTZXTkNaUkhqWHZzdVZ6YjJpZkVTc0U2dUNjTFhPa1EwVkdX?=
 =?utf-8?B?UldBR1ZwTmtQQUxwU3h0OHV0NTE1S2ZjdCsyWS9JN3FZNTZuWm1SdVoxbXIx?=
 =?utf-8?B?VERqcTU2cnd0WE4vb1d2V1dJTDlrQlN6U3FZTHRUOEU0eFh3bGpWT1BmaG4y?=
 =?utf-8?B?cXREamZraitWVVBtTGdsbGVMNm9UTlpob1BBcDJDYVA0M1BHeUNGMUN4QVVa?=
 =?utf-8?B?Z0k2cHpNYjgxL0tqQW96VE11TUZUbkpVTkVyUFBzSHE2bFJqQ0hZQURsd2Vq?=
 =?utf-8?B?cFlDSzFlandHcjZtbGt2SDhiR1Q4eUl1Y1hUczZHaHN1dWZOa084ckFENXdM?=
 =?utf-8?B?em5xbDZoYThoUlVRTCtlN25FNlFrdGJuOXF1TUo0VnJHVFoxRUtDYjRFQWpR?=
 =?utf-8?B?bzNRQkhSZ0pCWXpMb1FaUjhJb1hxTWN1dC9UZmpMbW1wNDRzekszTmgwTjZN?=
 =?utf-8?B?UFd0YkRFSytHS29CNUhjaUIwM3poZDdjWnVKbU5RUC96UmxpK2k3eS9yMEhQ?=
 =?utf-8?B?S0RPZ0syL05Qc3hnSG1kL0tmMGI1c1htT1RPOVBLbmJoSHhFU3ZyNFBVWklv?=
 =?utf-8?B?SExNc25iVk9JZTZIYS9SMmdGNHlDZ0hoTG9mb2VvRVVkd3RlOGZtdTI5TGpt?=
 =?utf-8?B?Y1VGY1R2OVFDWGg1MzhnVk0rQ2FwZVpDaElkUEcwVUZYa0ZuYVFQVlFkdHdB?=
 =?utf-8?B?c2F0alA0eXQzeVM1SEx0d0xkdzJTMU9tMU9uTi91RVFYUmhBK0MyZkR1RHpm?=
 =?utf-8?B?NGhOYnRHcTZ4djFUb3hweUJIMUFRa09CR2NoODJpcENkenJRVnJDOHRRYTRK?=
 =?utf-8?B?L3Vpb0ZDT0h1U0NvL0JKc1VjdUJoVXlNZFFWdkNIalFUcUZFU0VtaWZ5V1Jj?=
 =?utf-8?B?YjdYSlhEemI2dmNYVnVuVnVSWnhmOEVHTWlXS2dXcDhjRm5FemkzNHY1L1Iz?=
 =?utf-8?B?T3UvMDFObFFvK05UcnhIR1RmL0lkbUdOeVpoZ05DMUVyckxOb2VINEZrR1Ny?=
 =?utf-8?Q?Ap08doWxByVfTXkbOtv78hM7Ed2C1glOcnGjj?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9aba1a3e-2b2c-417a-cc72-08defcf03d4d
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 06:16:28.7403 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8mVD1iTNGiZTDicvty3ginO1a/LQCYpoQ9UuZQO/aMx0iCcQ9MnhxcfVNeKWjlWYPnmAXANBhXSl59jPhUTumzjMs1Y2jDGxMcH4USY6Ap3viyWYro4Oq3azymqpiBgT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7152
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

From: Ye Li <ye.li@nxp.com>

During DDR PHY training, an intermediate 1800MTS data rate is also
exercised, which corresponds to a 450MHz DDR PLL frequency. Add this
rate to the DDR PLL table so the training sequence can program it.

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 arch/arm/mach-imx/imx9/clock.c     | 1 +
 drivers/ddr/imx/phy/ddrphy_utils.c | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/arch/arm/mach-imx/imx9/clock.c b/arch/arm/mach-imx/imx9/clock.c
index 4b89ee3b2b4..cc0a7729d94 100644
--- a/arch/arm/mach-imx/imx9/clock.c
+++ b/arch/arm/mach-imx/imx9/clock.c
@@ -40,6 +40,7 @@ static struct imx_fracpll_rate_table imx9_fracpll_tbl[] = {
 	FRAC_PLL_RATE(484000000U, 1, 121, 6, 0, 1),
 	FRAC_PLL_RATE(445333333U, 1, 167, 9, 0, 1),
 	FRAC_PLL_RATE(466000000U, 1, 155, 8, 1, 3), /* 466Mhz */
+	FRAC_PLL_RATE(450000000U, 1, 150, 8, 0, 1), /* 450Mhz */
 	FRAC_PLL_RATE(400000000U, 1, 200, 12, 0, 1), /* 400Mhz */
 	FRAC_PLL_RATE(300000000U, 1, 150, 12, 0, 1),
 	FRAC_PLL_RATE(233000000U, 1, 174, 18, 3, 4), /* 233Mhz */
diff --git a/drivers/ddr/imx/phy/ddrphy_utils.c b/drivers/ddr/imx/phy/ddrphy_utils.c
index 8e350de8315..665d32284ec 100644
--- a/drivers/ddr/imx/phy/ddrphy_utils.c
+++ b/drivers/ddr/imx/phy/ddrphy_utils.c
@@ -140,6 +140,10 @@ void ddrphy_init_set_dfi_clk(unsigned int drate)
 		dram_pll_init(MHZ(466));
 		dram_disable_bypass();
 		break;
+	case 1800:
+		dram_pll_init(MHZ(450));
+		dram_disable_bypass();
+		break;
 	case 1600:
 		dram_pll_init(MHZ(400));
 		dram_disable_bypass();

-- 
2.34.1

