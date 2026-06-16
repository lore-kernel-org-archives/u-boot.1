Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22C03CD98E3
	for <u-boot@archiver.kernel.org>; Tue, 16 Jun 2026 15:39:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9427B848A6;
	Tue, 16 Jun 2026 17:39:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="G+PU770A";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="G+PU770A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5AB83848BA; Tue, 16 Jun 2026 17:39:27 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D210848A2
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 17:39:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Jerome.Forissier@arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=dYUFuvfSHrG0hTStDII6YEIyOa86TFIIBngJ+6KXVZTggbqbi1IBvwcLc5hGTT6l5kdlmaSeq02sdeNO81X7NkqpYHm9pHRIPuJm4ti79Y1gupn+oJySpU5bOVQi3YxoO1wrE2SZPXsHw091665eMPgjN2Be1GB2MR7D8ZXlQJB//C5fIr5Ry1wbP3cqfSDw9tIDEgBxevxyrZs8ITHa6emFuktgkogHryhxK7tOp3disGbkCXrdih68xCyFgRe+lCZZBdwOUrmkhcGpGj5bo36Kac267akSW6aC2UkF2f2zFmfJAYACCCqWsb7RGKkYAOaXezLVyM+qP5bnGHExiA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4PU0MI0Lbxcll1kebVhUrs6UBXkg7un+dYFut+6zn0k=;
 b=A7Ls0a6ZYzMlyCga2Mxr+CdtuBPXvyV+BiEt4kTuNjjbRtcjK16aOs1sEP2+H8sU5mrX1NQYLfHEjeyZSdwHQLcHiSQKmVkSLQmyM7f+1TtGqvaOV//64C61PkKP5TjjoYQTq/QYldRyTi227npqhvpd+PN0+aNntAfhpKHU9UXHPosqnvcHt3gN8/wXnxZ1cteOLUVbqq/+1dr5KMC+6JyNG/a4Wkl9EYTZbK4IjUzz8mGlf8agu3JNt0cwLDMBNqrWs41svMveM3tMRkBZm1/RXr7OQJHJ2sMGzLGcht56yn8Vd9ACv/OWC/fxHKNYblu9NiIyu9OHKfjRvmuqpg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=baylibre.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4PU0MI0Lbxcll1kebVhUrs6UBXkg7un+dYFut+6zn0k=;
 b=G+PU770ASxhSGz7NmowVbQTS1VyFwaRoK3fam6jcQBSOAaVipRUh4CjRXd16ZAPcxk2/XHb6CIlcAIXZhw12412jz1tH/4+PKQlQ6jPqDHWiIxgpLEUnGC/72bPhFwwIyT/RoRa3CYU7J3qeVxPHax35N1k52/9qXz9KH5UJLSM=
Received: from CWLP123CA0215.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:19d::15)
 by DB9PR08MB6652.eurprd08.prod.outlook.com (2603:10a6:10:2ab::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 15:39:21 +0000
Received: from AMS1EPF00000046.eurprd04.prod.outlook.com
 (2603:10a6:400:19d:cafe::17) by CWLP123CA0215.outlook.office365.com
 (2603:10a6:400:19d::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.18 via Frontend Transport; Tue,
 16 Jun 2026 15:39:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS1EPF00000046.mail.protection.outlook.com (10.167.16.43) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.8
 via Frontend Transport; Tue, 16 Jun 2026 15:39:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vnrxfD98IvR7zCz+qLmFbfP44Mogg9xMEGBY/p1OycHFBXQkJGtO/2YgRUMY+6L7Bzk4dl6pLae8p3OOENRMQB2QzI31dBmU2xaZszwp4/GMU+agyQzIj9ooeTYYxsOaHf+dkqFzMcjmJ3d2BElOddy2JkEG0N/T8CLjTiANFkUHBRepgQj3IBtQf0eh7fw1YX6e7EgwWHYgMtGkuUdOeQML0YDWuIJ8RcjkNZrYJMkHDNBuaOR4xlAioywh39EunigeHv8kcraCfcZLaMlt0UM2OP3Bz2DYquQWk1wwfqKEcM53/Aqyj5B9QS/lo/j8jRCLZ5YHJkWYIrC35M1/Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4PU0MI0Lbxcll1kebVhUrs6UBXkg7un+dYFut+6zn0k=;
 b=HjD99AV/7ZX2U2TQXrxg0swhRkrFYXEWi+odesj6jLrvD2jasbpAAQpFZwC0izIkD39RrbdrBJBVPl/dzk0hQp2w13Kqh7Kn95zAuaOt4A+d/pFw+uOEoKnmMKd67wMixcSOIr5jPTxwinEieJwGqnJBYaYnlTtWdqqkosjQK27N5yYiBf2oLzG87blg7kAjTQ5VU5RQ/gIpHlKfThRS6v0Z7QVvT/heDqU3R//74VWxPtAvcFB8hPf10WkHrVUszLaBb6ubZwnFu8GPzilaVesM7Q75KZRLEocdeGLWyZWB+S5C+n+jP1VkEe2ZTVUnZ9keufCOAbEfX3oCPeNo5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4PU0MI0Lbxcll1kebVhUrs6UBXkg7un+dYFut+6zn0k=;
 b=G+PU770ASxhSGz7NmowVbQTS1VyFwaRoK3fam6jcQBSOAaVipRUh4CjRXd16ZAPcxk2/XHb6CIlcAIXZhw12412jz1tH/4+PKQlQ6jPqDHWiIxgpLEUnGC/72bPhFwwIyT/RoRa3CYU7J3qeVxPHax35N1k52/9qXz9KH5UJLSM=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by DU0PR08MB7882.eurprd08.prod.outlook.com
 (2603:10a6:10:3b2::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 15:38:17 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%3]) with mapi id 15.21.0113.015; Tue, 16 Jun 2026
 15:38:17 +0000
Message-ID: <2c05892b-dda3-4b51-8ccf-e96a617346da@arm.com>
Date: Tue, 16 Jun 2026 17:38:16 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] net: lwip: introduce net_lwip_eth_stop() function
To: David Lechner <dlechner@baylibre.com>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Julien Stephan <jstephan@baylibre.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, nd@arm.com
References: <20260611-net-lwip-add-stop-function-v3-0-8849948fd9c3@baylibre.com>
 <20260611-net-lwip-add-stop-function-v3-3-8849948fd9c3@baylibre.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <20260611-net-lwip-add-stop-function-v3-3-8849948fd9c3@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0630.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:294::13) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|DU0PR08MB7882:EE_|AMS1EPF00000046:EE_|DB9PR08MB6652:EE_
X-MS-Office365-Filtering-Correlation-Id: 462bc535-b9b1-4abf-6ffe-08decbbd6f52
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|22082099003|18002099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info-Original: 8A83dnuh1IcRqJJbKg9CMrWezLgJ4syofvZERuWmz8uQ0p9vxdZ5aPcvGdFWyYVJho/aTDm6pUEh0BFxxwliP353oyPmIZpVQ8ev8NybqZdC3iVEpfAR3CIGuHmQKf8YrtFN5BmNRsLIK+Se5ODP0grureh6TPY2R4pSePSu2PgWTt18s6aob0OW4Z/BqpOnDEczevbq8h0YANQsUhVRlIT5rsfTaOEU6T5evr0uA/rgFclywHbaHpwE5fyoWpl6UAIFIO3PJHhQaU4j1WPGo6sQjnUzuVp9F5E6tjxQfGZjHE47W86dQnmgcy3RE05jQuXp6e/nkCSOoTppHStTm7U4aCDPDUHUm3L47EUQDvo2Unnso49iEaNQixAUKnMM9G4A6FNozrIGnsiW9iOMzF19yjYWia4F2AYar/g4Z8Mpg1/t/lXbRACc64ELGQn1s1V3aSd+75b5lKMoJm0Zj6W0sd0oNW38gub130qix69qZ4XdFFqI64ENj0PXArspnOEHIdPgmmTBqhVsOPMHJXJNKzxiGud+5JLDkfE1swf0AJBpUOjijy7zbmI1oKGqgKNlG1oeThRx5bdV2xnMVF1NJdyMSS4ZGzZ+ohIH0wqUQQGjO2JRKg7VPzRLTgJdOuf45Vp0KXlbBj/+hRjx8D6j+V6HSvXXlJEtT8BfZAN6zSw4ZbiUyqzpeIERqTXM
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(22082099003)(18002099003)(11063799006)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: SZezvjTvTBbGuKBNjsuJ6+gqsX1DH1vbSk0k3F1qugJizEYrPsOlmEqwah716UD46pBaeT52PpuzCOnjhm3Mg1V/cLGZxGyC8hrngrO2aoLyjoXz8b4Qs3yjtLo3yu/tjOeo3t5eleZFidF4MVoCPfVl5Wx6S+tO/xeaWj+FVmkIvw2C76PZiFKUEN4TqJ5DyWZs7mPjNuyGrtqUyf94gxmjd8M0cnKNFFqyqcYjZyEQ/7a5e6yEAAQCV6s46WDFzDQi7a/tppHe4REcdKQ/bzUw/yPZgWie3GtFDZVcqKvNGlHzz4adsPwSpDnfXJD+XTKyR5Bz8tyNMO3QQz4JSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB7882
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AMS1EPF00000046.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: d4ec9145-a451-4cd9-db7c-08decbbd4967
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|14060799003|23010399003|376014|35042699022|18002099003|22082099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: A1qkt1mEcg5hFfxMPoC1H+B14G1mkvzj5MnfSng3/9j60M2F0DY7gvStO2KHpzzNJI0KpcltCYBbLE8IVvsYiDFD+sn3pcsKlQwR95tCVEReoe2sC623XJtoktoW1y/7RY/a9Thoz5CGrlSrOlTRqCP7oSipCRy2RQ0nBOqc1Lg7/9LoguBjJzygzkTVotcWG6h/+1h9zN0OoP725hY2XVqYn5xDHiPYthphTmGJBm4QJYhRP66VeZ86ZisH4MLtDC0PvWi/rqwb8Jbl1V6EYGyVKdB6d+jgdmWD5QRKsfWaf+C8bbyrL54/yDfw2cfaFYKrW1tB9F3/5YBQkvOkh5TMpNjMP0LAynJh+j/chNS/sZ+k9MpwwoCbKBcL62F0VmDLWQhEJje09QbWo8eODK0WP/p/pU63MgFXG9tvwolUWPtGehx43Mtvg9QnGJMvb7tvHioT3WdiHGUYr4MbUAirOcHf6w8yUCPRtR4AV6ISFmUnO2nzZ8DWNdICjwBM5i1m2maWQGCMyltsUSZPv6Cur1AAD1z6KEspt3L6bGptMqE9nrQcGsPdgEEoNgdQg0C0H1JRV/2zVJFyPDE/0NgjHD7+bmRPk1+7KawqH537MDOgidIfCWOXaoT1NrXUVKeHkChRBUIq+eqrMrSV6vN1eRuSbGT28b5BcndxkKkQlFAFyhvJ/HdYBDiRzVDnDD7p91HVSCZLxB/ChlFiJ9Gzt6c5HpUlZUXzaQIJ16U=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(14060799003)(23010399003)(376014)(35042699022)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: kLkS0KC3r/i1umAPdyToUSuTlSbUIqXa/9AxMh2tLI3JnH0ATw3TQxj14d0UwK7uIPwzNVr14yFHAV0cysFxAf9pzSNQuJ1SdqvyT8+PC7fTVn+VMX2j4nZovp1sm15KoT0MfTgHK7GMehZnz8+80uBGYa4YnYD3gNQKRPHm0qGqRzN/hOXFk9s0fdtXvNpc++OSDpKdNKOnwPtcQh5l4KtIuebiwIL4pSXZBtgjSneCyYgCGo8HlOKvn+7MkrNlMI7Myu1VZTz3UCIlbHHLnwzT/HChZknBOvz706hM5hpZ2g9BnKvSitrbtGHuL+N/Foxcl79zFhbRPHLi2StwYP3DjH2bKlTdGv2n391CEeLhW52yrk7ovoDsjUB0/Nzc5BaamqujWnHdJbGEiZ81oUpU4NkJTED55Xso7K2WOfw6zWHTrfrdigj8pjxsOlFZ
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 15:39:20.9139 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 462bc535-b9b1-4abf-6ffe-08decbbd6f52
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS1EPF00000046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6652
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

On 12/06/2026 01:36, David Lechner wrote:
> Add a introduce net_lwip_eth_stop() function and use that to stop the
> network interface after each command that uses the network.
> 
> This makes the behavior the same as the legacy net code and avoids
> potential issues with the network interface being left in an active
> state after a command finishes.
> 
> The start/stop is reference-counted since there is at least one command
> (dhcp) that calls another command (tftp) to avoid starting and stopping
> the network interface multiple times in a single command.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>  cmd/lwip/ping.c     | 19 +++++++++++--------
>  cmd/lwip/sntp.c     | 10 ++++++++--
>  include/net-lwip.h  |  1 +
>  net/lwip/dhcp.c     | 15 +++++++++++----
>  net/lwip/dns.c      |  7 ++++++-
>  net/lwip/net-lwip.c | 16 ++++++++++++++++
>  net/lwip/nfs.c      |  4 ++++
>  net/lwip/tftp.c     |  4 ++++
>  net/lwip/wget.c     |  5 ++++-
>  9 files changed, 65 insertions(+), 16 deletions(-)
Reviewed-by: Jerome Forissier <jerome.forissier@arm.com>

Thanks,
-- 
Jerome
