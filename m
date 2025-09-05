Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46505CA1013
	for <u-boot@archiver.kernel.org>; Fri,  5 Sep 2025 12:44:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 530A68380F;
	Fri,  5 Sep 2025 14:44:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=sttls.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sttls.nl header.i=@sttls.nl header.b="T9yv5ZEP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42E398390D; Fri,  5 Sep 2025 12:06:20 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71C75838D2
 for <u-boot@lists.denx.de>; Fri,  5 Sep 2025 12:06:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sttls.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Maarten.Brock@sttls.nl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hJzf7GLRLIbaf2vB3JGbwpuLLf9D8VOiszjxK5tHC0zRTxQlVyTX2+aEWozHbHtDrjRSkWQr3GbV+Ac8tgpEov54uIRMMPh+XQA4bwS7+3ZPCrVTH5XAuwoYjUnU1BrvtXyr8oVlF3YmhPYYYn4w999sZZvl0Cs+rb60mdfQmk8f1W/ObUQKktOAM/iKBRjKaopwPQwWQNw/SHB7mhK5v4yQAutqWEldgKtgMEuI34pBi8P3A5BhoyP8rSAjnhabW2f1Py2QTn0j7kH41qQrSfUmccmp00qHMEbMj2NGxvwwwiMhSZR1fUNqZfRFxlBZUFxEA/q6UcYx3pcQI8n3lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C6GGjSkUj6gjd8Psz+euQtSZijX+x+lM2XejEQqgYEU=;
 b=HjJwnO7APPr5h3Ikm6K7bWlBHPA6bQJlpvOLwKqvD8Mh0cXhQm1brZDY6Zoieu0oMNkPONKHlBI11Ydie8yzPU2yPaDo0NH1+TW8qvbQ3r//RfgYT5NlEo+GI4O/AL2zo529NKoBEH+9rLn2omllygeqMue5s2WNnQY/qDih85hpTzCZz/QKnjKqmyArWsKOPSSYkF4ICT6GZC/AIwMPJHdmCRtnVjQK++wmICAF7ZjAvqhLl/k/n232fyheneGpnhswBV8ckIaeUK0lhmuCPZ5E1hjnLJga2/Apoy5v5kAcSOMTEEryC0jZtwk19DBb9FDkfylyiqFpj836XZzC0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 20.93.157.195) smtp.rcpttodomain=konsulko.com smtp.mailfrom=sttls.nl;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=sttls.nl;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sttls.nl; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C6GGjSkUj6gjd8Psz+euQtSZijX+x+lM2XejEQqgYEU=;
 b=T9yv5ZEPqCtRzjFdE/OPJkeK0dY6+RjL/EK6wDLymzT288sRdGPsmwKpV5rr4yDzc6rpTzaNBMSpdUbiGWIZTMh1GSa4wyA0Aa9T23Gm2OXRkbILcZd4oDQNeg7Fq07sGbXyhfWnU/KjJhA3bKX6G8bfaUXm569SPqR31WswiptqTLkeAvlJHRP4+4d5dLnnYJKFP3RYFzuqhqo3pYSsoe8G7abAGeoOcDFGeS7pZq6ScJDC/aJr1o0xyJfJb7PaRLLIKuLWFr8hyA2LLUyTmlqzMcHHDKkOWeCKhH+d59GJCGXIE3lGzXhpR7n3IYYhWbkhN7mDQTwWoNoOWeSszQ==
Received: from DB3PR08CA0017.eurprd08.prod.outlook.com (2603:10a6:8::30) by
 AS4PR05MB8967.eurprd05.prod.outlook.com (2603:10a6:20b:4e6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Fri, 5 Sep
 2025 10:06:14 +0000
Received: from DB3PEPF0000885A.eurprd02.prod.outlook.com
 (2603:10a6:8:0:cafe::a4) by DB3PR08CA0017.outlook.office365.com
 (2603:10a6:8::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.19 via Frontend Transport; Fri,
 5 Sep 2025 10:06:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.93.157.195)
 smtp.mailfrom=sttls.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=sttls.nl;
Received-SPF: Pass (protection.outlook.com: domain of sttls.nl designates
 20.93.157.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.93.157.195; helo=westeu11-emailsignatures-cloud.codetwo.com;
 pr=C
Received: from westeu11-emailsignatures-cloud.codetwo.com (20.93.157.195) by
 DB3PEPF0000885A.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.14 via Frontend Transport; Fri, 5 Sep 2025 10:06:13 +0000
Received: from PA4PR04CU001.outbound.protection.outlook.com (40.93.76.78) by
 westeu11-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12)
 via SMTP; Fri, 05 Sep 2025 10:06:12 +0000
Received: from DB6PR05MB4551.eurprd05.prod.outlook.com (2603:10a6:6:4a::24) by
 PAXPR05MB8064.eurprd05.prod.outlook.com (2603:10a6:102:159::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.17; Fri, 5 Sep 2025 10:06:10 +0000
Received: from DB6PR05MB4551.eurprd05.prod.outlook.com
 ([fe80::f854:dcd:a8dc:bc53]) by DB6PR05MB4551.eurprd05.prod.outlook.com
 ([fe80::f854:dcd:a8dc:bc53%4]) with mapi id 15.20.9052.019; Fri, 5 Sep 2025
 10:06:10 +0000
From: Maarten Brock <Maarten.Brock@sttls.nl>
To: Tom Rini <trini@konsulko.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Jerome Forissier
 <jerome.forissier@linaro.org>, Kory Maincent <kory.maincent@bootlin.com>,
 Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH 2/2] ti: Do not remove ft_board_setup for CONFIG_NO_NET
Thread-Topic: [PATCH 2/2] ti: Do not remove ft_board_setup for CONFIG_NO_NET
Thread-Index: AQHcG1oeOvD//iZHQk+XfdKWv0RcKLR+pPqAgARcaXKAANHrAIAAi09a
Date: Fri, 5 Sep 2025 10:06:10 +0000
Message-ID: <DB6PR05MB4551C55FB367824AB9AF8FFB8303A@DB6PR05MB4551.eurprd05.prod.outlook.com>
References: <DB6PR05MB45517FBC403C54F9589F03878307A@DB6PR05MB4551.eurprd05.prod.outlook.com>
 <20250901182549.GD124814@bill-the-cat>
 <DB6PR05MB4551C8F51246AD5EEA64F4498300A@DB6PR05MB4551.eurprd05.prod.outlook.com>
 <20250905013256.GI124814@bill-the-cat>
In-Reply-To: <20250905013256.GI124814@bill-the-cat>
Accept-Language: en-US, nl-NL
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sttls.nl;
x-ms-traffictypediagnostic: DB6PR05MB4551:EE_|PAXPR05MB8064:EE_|DB3PEPF0000885A:EE_|AS4PR05MB8967:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bed9c96-2716-4d8c-1b45-08ddec63d8ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700018; 
X-Microsoft-Antispam-Message-Info-Original: =?iso-8859-1?Q?MEOcPeFUJCvi7id7SDBu141X3vrhdlxEAcbC1cFUQ7Mxe7qVDKXZxPEWAa?=
 =?iso-8859-1?Q?b3IqhK7eNZg97ZJYinaKm0wGPimeIxlcsFwjsX2q4H22M5oCcMCvow15C3?=
 =?iso-8859-1?Q?GXgMCoO+tpm53OcLrrdrZI+K5UMcu+PJV5SBzvN2vXnZUmpEFOUSDGD1CL?=
 =?iso-8859-1?Q?cfMPURVkMtdtRpKBrl+8CD42v4Rk9OLz1s7SwnJRRto2ZMw5IE5f48pxH1?=
 =?iso-8859-1?Q?8EkByaYtt3/M+AR6tinCIhPT+Vx+wkLW+K5BIFDcmo9AjvueQEN9rVhfGp?=
 =?iso-8859-1?Q?vvEPOMHY/drTKkcnLNAmXt6eOujAEn+0Z1EY47JBRi2BljNaD6rGDQyVCP?=
 =?iso-8859-1?Q?w/HS/Csk90fUD5XDAgcVfOO/izpGsWuTSPhuF8RXu0D/ya0LQjcW73QD+C?=
 =?iso-8859-1?Q?QaCMEvpSMJDeNxgaIShiQCabQWRwsKNZA0NrxYX+H+HtEr96t4fTxag/16?=
 =?iso-8859-1?Q?WJeKQ6v2COEvj2nwSkFojHM4WhZRjn+/obKP2vb+DESpAEfH1UheE9j1k9?=
 =?iso-8859-1?Q?gKOSexqA2V2BMSOo6U5zCPIC0HS+3UsfS7QMZ2QM7d4kZqrhb4vAdpdG/j?=
 =?iso-8859-1?Q?qOb2p7bV4ulE2OtRY0+DAkVnVlwFYVaOcCjapRoc0ch6zAIbW8TcwG+nIb?=
 =?iso-8859-1?Q?kY3M+aEf+7JMKFO3K7RFSeAnTDQFOMA7G37kVbUhnM2hxiaUNVoTaGJ02x?=
 =?iso-8859-1?Q?YbCdFTIEEUbnDoKMrFLU+79lU6dINYobt7geMmfJWo7SZTY097aUg8s7rb?=
 =?iso-8859-1?Q?TC1fkCm7j3YeiOPdIKFhhiHZ1DgCqMKeik64+yCVAqv7ce8UJTj49J50G3?=
 =?iso-8859-1?Q?6zg5lBCaIUKxd0cvzELSn9z07Yjs7QFhnbZ96PwmP/vfymDi0OGNkCux24?=
 =?iso-8859-1?Q?4ohySFdrs2JUvyzmjiZepFGmcoUmVJkLhGbO/p7KTNW9Tim2Uc/lHFjlH/?=
 =?iso-8859-1?Q?BVJtSvfKFSXB/sDwIL0Oxs3AMlBw6DNpQotgORejoWyeg/wJGACW+kMgdN?=
 =?iso-8859-1?Q?B8e7v2dyGy90yIcQNlbimjM/RnJR0G9trNaGHHARyH7k2tSqsKrmb+B+Dt?=
 =?iso-8859-1?Q?s4yYWpNceZTxDoPQt9vwbwhf3IZEy8/cGFqbgSzAr9uJ8aHqrYwUhwImhv?=
 =?iso-8859-1?Q?TLC06CoM7hFYyJtnJIcqmFdTBaBZlp686TCXF8byJiS7AQBJFkFkvP4xSZ?=
 =?iso-8859-1?Q?UaqqSdexe9V47UKeeOMWDorv0Hxflf31+OCuoqtQQVphGcsWPc6SYsFSdo?=
 =?iso-8859-1?Q?bmVlba+NqJA9x8ra5cVNBMrhcxATzqiHEeWI12T2h29UbJmCdRtdf+nN1I?=
 =?iso-8859-1?Q?MnDve05vYNXiNJFYeZpfba9HhauMPp8YDQelMIohm2Q3yTe6nf2sH9gK01?=
 =?iso-8859-1?Q?jVuXrUrwHmY010/yHdKvzQzzFyCMAyVPxFnND9jc/5BpbRHm5ps8HZ6DAw?=
 =?iso-8859-1?Q?BWsle/ysG1vY7OH82TpTq2r549blNSZaDQ3l+/WWF4fA+ZE+M25xau/ydr?=
 =?iso-8859-1?Q?oUemutQMSr6EucfTAkSToluWTQIoXsOqou63LmIBazXA=3D=3D?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:DB6PR05MB4551.eurprd05.prod.outlook.com;
 PTR:; CAT:NONE; SFS:(13230040)(376014)(1800799024)(366016)(38070700018);
 DIR:OUT; SFP:1102; 
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR05MB8064
X-CodeTwo-MessageID: acb49f54-5eb1-4e32-9465-527fadcfff0b.20250905100612@westeu11-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB3PEPF0000885A.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 0ae11504-a53f-4824-a0b3-08ddec63d6c5
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|35042699022|82310400026|1800799024|376014|36860700013|14060799003;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?iPMVrLCjE6oWpErWqBSR9GTjFkU85+X+VfUJvWdYqEJeNCfJAefFw9y3SA?=
 =?iso-8859-1?Q?ZexDkybAXxzgqoioWEelmdDrVRvlhxAiyKdqWw4o1IhK0y2mDuX0Yk3/mK?=
 =?iso-8859-1?Q?fLxgZNwEu7sxTIwuTOQcvWIIvCZwzUs0fEadQgFMxGei0v3e/fk4h5B+2/?=
 =?iso-8859-1?Q?ac1AUnj0ju/eUTjjw1wprmml18CNNs6C/ajbEElm8R0kkt3zqO2YNU+H83?=
 =?iso-8859-1?Q?GLmjnxnLC+MClyg0Y4lX1J+8Ta6mPPD9RZOp9PrlCkJnyrtfMHC+odAMIN?=
 =?iso-8859-1?Q?cuwn6uB3Mbgn6cAujIgynjSWw9l3RuEYrw7Yd0WBr8Yn+mBCSQWxK9nEgy?=
 =?iso-8859-1?Q?2ryNwXUWdxy3mURaOEPuMRqpBTzFXDyI2iqZ3sWl4dzV34z2ubDZoWg7/S?=
 =?iso-8859-1?Q?LajBlRH1ZrdYP4ZwqWiQgFwOyGyN4w96y5js1mG2dR6QWwJnSdE6dRpmD9?=
 =?iso-8859-1?Q?GxsWweT3EHaRR94bXDo+SRtSYm+vK3b6F4BA8LZUxzmrquGBgfzDkiQCNT?=
 =?iso-8859-1?Q?6WgE05j5b4LecRVSUgJRYUpsGHJTENp7vB7b/c6Sf/8Y3tv+dqJKXPl8Ir?=
 =?iso-8859-1?Q?54rmpDkPRCazR3wg4VDPCLjxIqUj//cjZjwvgq1IrnRmM18Ii0HjfiXhjb?=
 =?iso-8859-1?Q?BxfaiqBrIgJo+bfcAmLOEW4zjZOI2ZgDp5ItBG5IDD94VfvLVCgels9+7P?=
 =?iso-8859-1?Q?0iLEMlGVznm4gl6L9PcpOZNKZBkBKMpmys8ifqiGb9GqV1oleSkrzGWNCS?=
 =?iso-8859-1?Q?NEqrRjqlCBy3nAZC+b9/1ZEIQ7oXwUwsdKFF9iLDcUnKfJ8r4QJJf65r5y?=
 =?iso-8859-1?Q?/YWBBs3Oe9MQM9G2jVUMgRRwOKs9Bf/uY7v7pAcgpqjRj72gJqaFAaiQOH?=
 =?iso-8859-1?Q?L27D9kU3ssOaNkjSyZBA8rB+YacukZKYgetzNEU9f9UP81Rq/Q6dwUSwF5?=
 =?iso-8859-1?Q?boO2Tz7guvyOw8jYCUNjT7naKSf/oOnzYQkTs9PiX9vdfyKD+0NyaRraWL?=
 =?iso-8859-1?Q?MzMej8u0dCYg0Z7sGqD2EJwtFOhlJGV5dbTqRM4Xc1MizsIS338x2QduxH?=
 =?iso-8859-1?Q?h8qST7PddiCe2WOoiRtB4+x07dXD4sda/E5r6t70QEhg455SvA5S1nKFQc?=
 =?iso-8859-1?Q?GaKs+GPs00i5MYrWpblG5ZrgJyA9SFw54eejwEc9AykSJjPr7Fhsc51AzQ?=
 =?iso-8859-1?Q?/16/oBtZutL6xi91BS6rKkWvX9QYoZaZCh8uyXijA7VRRpovsvcS2uCSWZ?=
 =?iso-8859-1?Q?NuhKm8RovWIzDurETs0Yt6S7+r4J3fn9VcSZLdBqimWwM0Dw1xiVDTRJK/?=
 =?iso-8859-1?Q?21LbDa3OU/nS63QZDe3kCLJIrATGOpkvmMgwpurhilkooo3zY39VZcJddd?=
 =?iso-8859-1?Q?gf0NqcKRIJPd9cp+h0GeY3oA9DkUOpl4sxOEG3kWH5MDrMFNhx8l9WzK1U?=
 =?iso-8859-1?Q?VshOczM4VoeBcvHLPtxa4XKCk2cjntXYBHT6QUctz4W3nwqGhVpX4FLd1y?=
 =?iso-8859-1?Q?AYOAYQdlFOC1RhiBH0a/WFjUbFuuFeEhlZDLm0eb+6MQQId1Sd5hjeJdx6?=
 =?iso-8859-1?Q?xy/SD8IcCGHi86d+t5fBBK3Q45aN?=
X-Forefront-Antispam-Report: CIP:20.93.157.195; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:westeu11-emailsignatures-cloud.codetwo.com;
 PTR:westeu11-emailsignatures-cloud.codetwo.com; CAT:NONE;
 SFS:(13230040)(35042699022)(82310400026)(1800799024)(376014)(36860700013)(14060799003);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: sttls.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 10:06:13.6423 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bed9c96-2716-4d8c-1b45-08ddec63d8ad
X-MS-Exchange-CrossTenant-Id: 86583a9a-af49-4f90-b51f-a573c9641d6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=86583a9a-af49-4f90-b51f-a573c9641d6a; Ip=[20.93.157.195];
 Helo=[westeu11-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: DB3PEPF0000885A.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR05MB8967
X-Mailman-Approved-At: Fri, 05 Sep 2025 14:44:10 +0200
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

From: Tom Rini=0A=
> On Thu, Sep 04, 2025 at 01:19:26PM +0000, Maarten Brock wrote:=0A=
> > From: Tom Rini=0A=
> >=0A=
> > > On Mon, Sep 01, 2025 at 04:06:10PM +0000, Maarten Brock wrote:=0A=
> > >=0A=
> > > > Even when CONFIG_NO_NET is selected there is still need for a=0A=
> > > > definition of ft_board_setup(). Thus move the checks for=0A=
> > > > CONFIG_DM_ETH and CONFIG_DRIVER_TI_CPSW inside the function.=0A=
> > > >=0A=
> > > > Signed-off-by: Maarten Brock <maarten.brock@sttls.nl>=0A=
> > >=0A=
> > > Shouldn't OF_BOARD_SETUP be disabled in that case?=0A=
> > >=0A=
> > > --=0A=
> > > Tom=0A=
> >=0A=
> > Had there also been non-NET-related fixups in this ft_board_setup(),=0A=
> > would that also have been your answer?=0A=
> > I don't see why disabling NET drivers would have to impact anything els=
e.=0A=
> =0A=
> Yes it would have been my answer. And because not all dependencies are=0A=
> easily expressible in Kconfig.=0A=
=0A=
If this is your opinion then I propose to remove the checks for DM_ETH and=
=0A=
DRIVER_TI_CPSW alltogether. They obviously serve no purpose as one is=0A=
required to deselect OF_BOARD_SETUP when NO_NET is selected.=0A=
=0A=
-#if defined(CONFIG_OF_BOARD_SETUP) && defined(CONFIG_OF_CONTROL) && \=0A=
-	defined(CONFIG_DM_ETH) && defined(CONFIG_DRIVER_TI_CPSW)=0A=
+#if defined(CONFIG_OF_BOARD_SETUP) && defined(CONFIG_OF_CONTROL)=0A=
=0A=
I must hope that there will never be the need for other fixups for e.g.=0A=
the RTC or the user is left with either choosing both RTC and NET or neithe=
r.=0A=
=0A=
Kind regards,=0A=
Maarten=
