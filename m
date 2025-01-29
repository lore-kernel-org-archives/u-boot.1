Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39F6EC0218D
	for <u-boot@archiver.kernel.org>; Wed, 29 Jan 2025 17:34:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E7D58083C;
	Wed, 29 Jan 2025 18:34:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="VhA44QaB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE03C80BA9; Wed, 29 Jan 2025 18:34:30 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC97D80646
 for <u-boot@lists.denx.de>; Wed, 29 Jan 2025 18:34:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nx7SsNRP0h997ihpWLcHJ4TPvCXGsVcpSQ88O1l4+SM/TDam4bArl4572dy3KefcEvOzlAvsV9JvVE2h9S1pnO3/2ENkYnB1mbvIB+3j2JP9W7tm3oJzKgR65TKMJtJeEhL4jC4buVSWEbYufJ3bLSzGQeTDSxslMwQc+uC3Ft679NtxeKmLcrsbpnBXlcNMXQPhT05hcpjRrki8igSupDyUWM4dqN/b5p7dgdnZxSM5ZhGJzEe2rGa4fhejmX+LReuFyxWkEHqIUJC2ZGPS+TxX6QOKx3QCX4pHCLJA3dSpbXMIWHoKeA7ZvAeCiJEnKBDD3j9F52higmoeZmlGzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q/4NfyCx+0IH9RV4K0oiwIhE0t/tBvqQNIl/wDIG/xo=;
 b=oTQY6qAnZl0Zr81tVZ843B/h0JxImOBi+8z4HMT4Oa/2FryRMoAP2366JXMmm/d5FAdjTW83otDtdJfzZDn6wbK/fqoUWlSVYS3U3ze6U0BTg/lSDJXMSKlTi/HDkZT2GQp0n3Pf29Q/SvtvqRXivOQP1K2Nqez0u8xWh1NP46y+LmDJ/enjb7dFXkxsbmyfwVBay2g28jb8/pD14BwtWnBwEbwDu0m/jBewKDzfDy8cKsAFh0ED1xuFCRmzypp2sfIe5OgXqbNFVN2E5vREbgejSQbyBFHMdKId7BymCMlfK0h9q1t6VWnTGTC56uJ5uQn4auaxzSkKx2TqOlU6mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q/4NfyCx+0IH9RV4K0oiwIhE0t/tBvqQNIl/wDIG/xo=;
 b=VhA44QaBEezbyAkce1s6SUaScrjAXNxFaCmxfRhdag/F+PltTW5KHyPAWKguCGXw0gDOyN8sqT3Ob5O16ruvOvjdSVqV0+JA6vz3LqpwQVtidNrqMapRxkfus1jL4G5tQmCVjsX0krkDWXsbC3raHmDksrY+cQiHRDatqnoY4DU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AM0PR04MB6963.eurprd04.prod.outlook.com (2603:10a6:208:18b::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.18; Wed, 29 Jan
 2025 17:34:28 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%3]) with mapi id 15.20.8377.021; Wed, 29 Jan 2025
 17:34:28 +0000
Message-ID: <9ed503e7-9e97-4df5-9573-e3b20cfa414f@cherry.de>
Date: Wed, 29 Jan 2025 18:34:26 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/9] ARM: renesas: Drop R8A779A0 V3U Falcon SPL
 Makefile entry
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Adam Ford <aford173@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
References: <20250129170514.82118-1-marek.vasut+renesas@mailbox.org>
 <20250129170514.82118-2-marek.vasut+renesas@mailbox.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250129170514.82118-2-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR10CA0114.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::43) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AM0PR04MB6963:EE_
X-MS-Office365-Filtering-Correlation-Id: beb2f486-0c86-41a0-df32-08dd408b2e4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|376014|366016|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?REJ2MUFSOUhraSswaHdCY09zb0F2SDI0UWRmUmw5UnhqNDFZVUNib0hpK1c5?=
 =?utf-8?B?RHRaU3NzMFBRZDNaVllEVjYzZGdFZXNsZTRldUc0VFBSUkJhOVhQTVhGc2J3?=
 =?utf-8?B?MlZJWDVjMnZIRktqK01JRVdObW9lcHdKSTNpNzVMN1hXUjVSejZNTXJtcENJ?=
 =?utf-8?B?NzBoMXNtWWUrOGk5OWQ0YzZscFovQm1YL0xQRmo0U09oaUFDM0RkaHdZQXJC?=
 =?utf-8?B?ZFhFdURtWUxRaXdqdllLQzhsRlA5OXMvaWtCSWx0UUZsU2VLUTE0Yk9DWGJP?=
 =?utf-8?B?dnluU08wWHE4bDI3S1MyOWtGYzBUNWRPbG96NDFOOEF2aTJzQjEwcllZNVZl?=
 =?utf-8?B?WXluQk0wYmhjNEN1TTVxckhqSGg5Yk1nUmtCaVA3NXBYMmtnZWJhblJCZGZs?=
 =?utf-8?B?T1NFWUFZb3BYSkIrd0FMUE1ZdDlJd1EyeXFhZ0h4c2dIKzZLcUx0dDZ5WFZz?=
 =?utf-8?B?TGxSWXk0UHR1VUhKa1FxTFdSUlBrWkxKZVMrZ2MxNUJDRnJmUU42SXNTOUcy?=
 =?utf-8?B?ZFFzT1BmYzRlZndnaTdrWnYyQXpuNDE5Ym8vd3BKYjVZSlFhMTRMYStFOXo5?=
 =?utf-8?B?djlCN0pNOWRCeFE3dDZnd1lrK2Qvd1pEVjRiQm1wWEFDRzMvQ1dKdHZYckEy?=
 =?utf-8?B?WkdJQ0JOU0Z2YXhtUTc4bG40Zm13TFZ2QzVlSEtRcFhWUjdHdVlkaVhSdUd3?=
 =?utf-8?B?ZktTd3dqbkxWeGYwcFRxYXowZFlmcDlWU2JXSTRQN3lqbXhlSi9NYW1sdFdl?=
 =?utf-8?B?ekpsRzM5VnJqOVpQSEZoMEZFY2V1dXBaamxTK01yYUQxZ1hyd3ZieDlvQ21M?=
 =?utf-8?B?bGR1MTcxK28wSW1BWDVZK3l1ZTRMak12ZldRREVEOS9tRDlsVnVrRVQxbTZ6?=
 =?utf-8?B?TDdxRlo5ZkVleEVFdHEvZWFSdDh3QlhDejFzcW9ESVZ1R2FqQ0gzdzVhdWVr?=
 =?utf-8?B?M2toaGQwY2VxZjBMRDdCM1Z0T3VxSDFqdy9ybWlXWXR0cHJrdldzYllnVXk2?=
 =?utf-8?B?YUxCamNBcEZSYkFDbUk4TER0dElNdjBGakUySnFldkttYkNVTWs3bzEwb3F4?=
 =?utf-8?B?eENBNWtOOG1zWmFJN2pZZ3ZTcHBhRjNnQTRFRWt3OGVqV0ZZSjErVTRZcHVN?=
 =?utf-8?B?bTkrUFRTUEFqZTZST1lzTXlGdVpnRWZUOVBuLzJOSER6OUpabTRLVDNtVFIw?=
 =?utf-8?B?TkhOdzhlbTBnSDAwQUpxK05Pc1hzdHRPQ2Ywd0UxbW4vc1p1S1Y2QUNmR3F6?=
 =?utf-8?B?NVBuRUdySnRzYmJBYTNiRmJsa044M2ZNWXhHL0JYMk5sNTJPQUZNck91Q0pv?=
 =?utf-8?B?YkdzR3hRZHpTWCtBMXBxV2FXQVNmdmp2ekNTT3VaODAwelFScFQ5YkZkaE1Q?=
 =?utf-8?B?ZFhWRXQ5Sit3aTg5elVBcHhMcDFJZTM2UVI1bFhFTVhuV1N5WTR0QWJJSjVp?=
 =?utf-8?B?cUR0eS9SeWdjcjVTU29kN1cwUHdVNEtJTWRsWGN2NVFDK2RvYlNFQzYrSHpS?=
 =?utf-8?B?NUNEbTlScCt5NGMrSTVVWkRCVzBWYXRGejFiWElxbG9uN0syczRRalhLd1dJ?=
 =?utf-8?B?cWFNYjZTV2FlNFpET1RoWFFNV3NGcDRyTlpwUHViUHYzbFErbnB2TDg0U2dI?=
 =?utf-8?B?Zk1GUTh4N1FCMGljQzRSQmRQek1JbkxHZ2JXUGhBdThoUTVEUzNnclpTYUNq?=
 =?utf-8?B?S0lab0dzSy9EazM1eFVtd1dIdHVQdzhMYlh0MHZKYjBvd3YyY24yeHJmQkZj?=
 =?utf-8?B?R0I3VGRaWEVQN0o1VWxxK2lKdEluSzVqTXdiZUhXbFZTOHE5TGlUVGJORWtI?=
 =?utf-8?B?TlNaK0txVVBqSzJiZmNmMmpVc1N0K1J5ZFhGbDF2aC95dGI4NkE1cTJYRzhz?=
 =?utf-8?Q?XEe+nubMpo4cD?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(376014)(366016)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aVFCM2pYdWpaR1h2bXBvNVBaSFFIQ0tUWGNndHQ1b0U1VVkzbWJNNE1TR2xn?=
 =?utf-8?B?cDJXc2UyWVljRGNndlYxbDFaZHJrNXQ1cG5UMTRVei9SQ2VOZmYzaEFQZVg1?=
 =?utf-8?B?Ni9IL3Y4NVdsR1hqMTB2RVVYc291RXJwSnVZalhsRDlsQWh4b3dDMWR3MXU4?=
 =?utf-8?B?VXNvc2s5S2pueWdkRGhieDg0eFBIOWdWTExWWC9rdS96ZzU1OUNpZy9RY1JB?=
 =?utf-8?B?V3htalpZUHAySVEwdGgvUHVpd3k0M0NaNmxNZnNGeE5NSHpXKzd2azNPQmVR?=
 =?utf-8?B?UVFaSVgzbmcwQWsvOXFUMTBNMUgrSWt2TVFNQkI1YWZxbmhrUDZCTnlVM1Jk?=
 =?utf-8?B?YTltY3l2WmRiRjE4S0Qzbnd1NTFCckFnMjhhb2ZmN09kTUJlV2NRZXkrRk1l?=
 =?utf-8?B?K096OExVMEJ3bjQrM3V5TEtmOUFPdmVDOTlOdlp2Z2QrL0hrVmFaRFlPRnp0?=
 =?utf-8?B?dlVSTXRRZWkzMlZHdkJmQTlsQ2pRRVVDTFFSR3NidW5lVkp2S29MQkt4QVpY?=
 =?utf-8?B?SGFwOHhpcldDZmQrUUNKb2ZtSTYzTjlYMDlHNGQxQmFMc09WVS8zenB5QlJF?=
 =?utf-8?B?bGxoZ3p3TnZ2OFQrU09zYTh2V3I3NUV0cGpVTlI1VExhK0FGNkRSMFpRTU9u?=
 =?utf-8?B?a0NlRUh1SFNhZXFydWdmUGhZVkNQenBRdW5Ga2hiT2pqZjRTeVNQWVk4TlVE?=
 =?utf-8?B?MFBqVE5TTmJlUWQyU1UrSVU4VExXRENjdXdGZWhTbUtQQlV1ZWFXU3VOSGtJ?=
 =?utf-8?B?N0xoMDRWZmhWeXF1Q1MrZXNjK3NES3dqWkVZRjFTVDl5azdORC9qQ083TmFK?=
 =?utf-8?B?dG13aGxVZktMVTRlQUIvMHFyNWk4bXN6a3Vlc0hwdFNRdzN3OURlQWlLNE5h?=
 =?utf-8?B?S0tnU2dDTEExMzRDeDFISGN3YkFJQjNSTWs4WW5RZGRNV1ZpNzhLYTVsZDZJ?=
 =?utf-8?B?VHhKZ0hBdGFrNmUzOUVOOFFxMVdvMzI1MENWUnlaRlRnYkNZRGo3RFBkMTBL?=
 =?utf-8?B?SHB1YjhNb05SQUdMZVRoRlI5U09TYUFVdjVJVzEyM3p2Z3QyaVUyRklMUEl3?=
 =?utf-8?B?WTFkamkxNmRDdGhMeXlTakIvdUVXRGx2OS9Za0M5NGQ0Mm9VM2cxb0tWRHdS?=
 =?utf-8?B?VWtVS1ZVS1BlRk9jS1pOVEV4a21jUGJ4UUxkdm9qaTRuamhuYTlzdzE0cjY3?=
 =?utf-8?B?UngrUGZaWGttTVY4dENlSUtYRWdQSVIydkIxK2pJSjBUM1FCOTh0TXJhWTRL?=
 =?utf-8?B?c3plRVd6b2MxdVc3YnZ1cldobDBIVWFaZ2lOTVBlckZPd2ZscmN3RUk5Vmp0?=
 =?utf-8?B?NzJiRmp3YWxSRUFvcnRNK1BRVVNTaXdzcmxyUUpkZEFZcmZ3UlRYMFJnVUZT?=
 =?utf-8?B?Uzlqd21nVnRiMHhEWUpYaUFSMnRPc0dzMnB5MTMrVU9keXdZbkVlWGpxZXQ3?=
 =?utf-8?B?cVoycGxLMTQ0L0hQVWFwUzhtSHQrc3hYU01sZElURjVISWNyTW5ucG5zUFpy?=
 =?utf-8?B?UkFWc2FnMnlHMUwrRlc0aC95K0RPTDlaaTQzY1N0VnNKY3l5RjUrRlNVODIw?=
 =?utf-8?B?TnF5cGlRSStQeWVQR0x3RHFBcjV3T3c5QWdmTEZJVSs5OVliWTg1M2JtTjVy?=
 =?utf-8?B?T0JLcVJFZ2d6NHFjblc3dWJLQ3U5cEJpbEcyc1JXazVIYjg3QklwM1JnaUtW?=
 =?utf-8?B?NDhkbnFoWWVEVnAyMlFQTlRTTmRWRXd0R3l3c2FIS0x6TEp1cDFDZVRtZnkx?=
 =?utf-8?B?ZTJycTdRVGM2aU5NZlYrQ3puRDdsV21OVWZEUmt6SVVLUzlOQ0VONmpSVVVS?=
 =?utf-8?B?SW9Vb2lzeURhQ2RMRFRkbU4wVmVxOTNVOEE0MlBYVlIvckhGUXRHL1pEejk1?=
 =?utf-8?B?eGRhNzl6Q0ZSZE1laXhFc1E4SFJ6VTM5SFpkR21HdHQvQ0ZjbE5Ec2w5Wi9L?=
 =?utf-8?B?VURTeERBdWpkd2JLMEk4cGZxa3lKTWhUZ2xocCtjRGxNVnV5cDRBNzk3QlJZ?=
 =?utf-8?B?VFFhbzJGRHdodXJ4OS82MjhldlhMTklSNjFXbGFGZnkrVkNHTWM0KzFBTkpL?=
 =?utf-8?B?SzcrME12UTVvK0I5L0ZYN2Z1RnptVERaVC9JRjBua0pTd3JkbGFNc3VzMlJo?=
 =?utf-8?B?cFRxMGRFRmR4UVJMREllWU5WTnk3dTlkcDEzTTV6aUVPY09rbWdCbHp5Z3Fs?=
 =?utf-8?Q?IcnDe60tG5parNIYzv4+8/g=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: beb2f486-0c86-41a0-df32-08dd408b2e4b
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 17:34:27.9342 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GsxXKgYlbcCNtVocTPgD8KIduQGi6F1R7rhBDO9L9UMNf/euKAatNkSyHqh9FZttLzObrQpXZ9izAQeEDiHZDORhMHgzTUQmP2WmYAV13Ig=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6963
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

Hi Marek,

On 1/29/25 6:04 PM, Marek Vasut wrote:
> The SPL on R-Car V3U Falcon is never built, remove the Makefile entry.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
