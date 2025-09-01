Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CF27CA0FF0
	for <u-boot@archiver.kernel.org>; Mon,  1 Sep 2025 16:32:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A658583A2B;
	Mon,  1 Sep 2025 18:31:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=sttls.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sttls.nl header.i=@sttls.nl header.b="OvBPMdh6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49AC283A1B; Mon,  1 Sep 2025 18:06:16 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1407C8313B
 for <u-boot@lists.denx.de>; Mon,  1 Sep 2025 18:06:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sttls.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Maarten.Brock@sttls.nl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nboN3YB32Wr+AmzIUqb86trtG1L7WRPWR3iTb7fJ4gesk5Apjfz5sNYIQjobUV93s6iWR3WX2Ea5fQrA9btRFG2TvkfHZ61jI+5h+hO4XTaTvednCCxNql91YuM3BlXI3kdX0CrGtu8Scipp1/yYTHTdjL3hN+Pc4kXZ3zGfngxcnOAd+FU+4b+7p4JDmj3rPkPRpFFryXPkgAjODM7E3C8Qqh1E1GPn1q/m/EOFRyJPt5VJrYkHId/iUbGylaJvejVEBkj1AnTZUgFOq1QH+iazAj9wPNHm1gUf29nuanHKGGNcXz9Sb/N/QYmojUPPzfGrScTx/trSsD4k/ZsyAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X8wrOv4J1gUeGCH5B+e59wK0cWcOJZOTiskFzYZFFhY=;
 b=SBkD3j5D2l52Mut3Ft2yIZlIyEPtPrnydECnaGmtCy8oFX4cz6vSe5mn5rEZenIgMAWxOXk8VcL9HitApgrfOm9mvYLLwItCLqeKPxhF+RnE72YRER8lntkYDcPlVfG4pPKraxhkWmiF1npDgHpAZuXNuQ40Ka1/VBXLvztd/nMefqFIls0nysxgBzuOhi0BfrHcve2duv6TrkUYz2egnNnbyrvdTrZwiAKwQk03lyCF9I4it5FtU29Wgd8UalXOXsY4+6aIPsuVstz1G5sSnTt2/2Y2koHKOU8AUhJORDyYNl2A7fhyvJLH/Uz+nH+1+Egi2CiK8l6F8/YBv1rFUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 20.93.157.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=sttls.nl;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=sttls.nl;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sttls.nl; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X8wrOv4J1gUeGCH5B+e59wK0cWcOJZOTiskFzYZFFhY=;
 b=OvBPMdh6wSqeH2vmjppNRXdy7ah0uIGUOcChxPh+qxOfuqjQcj2x+tl8Y8LjbfaSEJ1tDOnfp9wU8TKYIou4vt2lIppnL9GzOhz1lPek2KFZzdJ/SNELLuLxAfyx+Lnk2ON3Ne0gdWNunDp835pZ3z83HvzFF2rJNdst9vOaCbOmTgROYjPTh8qzttf22YFUA5bnr4iFgnZU4e0th5TcIC2aWS3Q/Kg5iIaOdWh3zXPI+P+wD6QQwpWlodJeryUZwH5PiqBnXBfqOqB3qYt15S6tpMUIpMNkJyd36wktpddJUrSFGMVKKg+4S9AZ5KZhlnwNZA9rsZRiQRFS3wxgBA==
Received: from CWLP123CA0026.GBRP123.PROD.OUTLOOK.COM (2603:10a6:401:58::14)
 by DU0PR05MB10571.eurprd05.prod.outlook.com (2603:10a6:10:426::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Mon, 1 Sep
 2025 16:06:12 +0000
Received: from AM2PEPF0001C717.eurprd05.prod.outlook.com
 (2603:10a6:401:58:cafe::2c) by CWLP123CA0026.outlook.office365.com
 (2603:10a6:401:58::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.27 via Frontend Transport; Mon,
 1 Sep 2025 16:06:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.93.157.195)
 smtp.mailfrom=sttls.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=sttls.nl;
Received-SPF: Pass (protection.outlook.com: domain of sttls.nl designates
 20.93.157.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.93.157.195; helo=westeu11-emailsignatures-cloud.codetwo.com;
 pr=C
Received: from westeu11-emailsignatures-cloud.codetwo.com (20.93.157.195) by
 AM2PEPF0001C717.mail.protection.outlook.com (10.167.16.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.14 via Frontend Transport; Mon, 1 Sep 2025 16:06:11 +0000
Received: from PA4PR04CU001.outbound.protection.outlook.com (40.93.76.76) by
 westeu11-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12)
 via SMTP; Mon, 01 Sep 2025 16:06:11 +0000
Received: from DB6PR05MB4551.eurprd05.prod.outlook.com (2603:10a6:6:4a::24) by
 AM0PR05MB6739.eurprd05.prod.outlook.com (2603:10a6:20b:145::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Mon, 1 Sep
 2025 16:06:10 +0000
Received: from DB6PR05MB4551.eurprd05.prod.outlook.com
 ([fe80::f854:dcd:a8dc:bc53]) by DB6PR05MB4551.eurprd05.prod.outlook.com
 ([fe80::f854:dcd:a8dc:bc53%4]) with mapi id 15.20.9052.019; Mon, 1 Sep 2025
 16:06:10 +0000
From: Maarten Brock <Maarten.Brock@sttls.nl>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Ilias Apalodimas <ilias.apalodimas@linaro.org>, Jerome Forissier
 <jerome.forissier@linaro.org>, Kory Maincent <kory.maincent@bootlin.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, Maarten Brock
 <Maarten.Brock@sttls.nl>
Subject: [PATCH 2/2] ti: Do not remove ft_board_setup for CONFIG_NO_NET
Thread-Topic: [PATCH 2/2] ti: Do not remove ft_board_setup for CONFIG_NO_NET
Thread-Index: AQHcG1oeOvD//iZHQk+XfdKWv0RcKA==
Date: Mon, 1 Sep 2025 16:06:10 +0000
Message-ID: <DB6PR05MB45517FBC403C54F9589F03878307A@DB6PR05MB4551.eurprd05.prod.outlook.com>
Accept-Language: en-US, nl-NL
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sttls.nl;
x-ms-traffictypediagnostic: DB6PR05MB4551:EE_|AM0PR05MB6739:EE_|AM2PEPF0001C717:EE_|DU0PR05MB10571:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d8072c6-5d80-4c99-6f8b-08dde9717856
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700018; 
X-Microsoft-Antispam-Message-Info-Original: =?iso-8859-1?Q?MA+wC50YZAX1v7fICPmgIVt6+yJU5GVYXg4MHQYIt7hAFX45AIZ0iMjA3n?=
 =?iso-8859-1?Q?2Tog2jxySfnTFojQIUSBDRIVHYMblHqDFcZ79NDipIJVI5gt45nzOdkTtD?=
 =?iso-8859-1?Q?h6/kcxRcK/yJsjINx3NWTenW6814LRSC2REfZMKVdrPKX7lumSaQbwt2rg?=
 =?iso-8859-1?Q?WXjkg4O5p6/3VW/i/qzdGiBwb2jOBts/6mk3LvtFiXrZt7LKi5eZZpTfDo?=
 =?iso-8859-1?Q?UOXCVrbNhEyONPOcvI2V8IDZLXhyyuwhoHdmKNNigpolah6Tq8PdG4/S3H?=
 =?iso-8859-1?Q?Y+YST+JP1+3N1Q5fwPWxROODDZGe7uxhxgecBU40YlNwEVQZH3DuEu+xdR?=
 =?iso-8859-1?Q?anO1jDKbpdVsjWg48bXU7AyLaWdiyq4tZuFkh8gxz7BRjWzucB8VJKX6Ua?=
 =?iso-8859-1?Q?qeuFEthJTYQsAF/OqgJ6E80D43CLNGGVpbuhGaay1WTY3X4EZOi9awZCE4?=
 =?iso-8859-1?Q?yv6r035jwUtsxWdofihDg6HHXJQzfvWI5i69o14BxhbcyeCe887EiDvb1w?=
 =?iso-8859-1?Q?iJotj/x4PTFTf1UA2kiz8rkXJHgGpQzKPMuzw0p3z4vh8KGsug3+ucfj2C?=
 =?iso-8859-1?Q?3V5GLcjofoj/qbccjkSRLd5N3WIL0Yge77rH3E97NOs8MjI8zIsB493lk7?=
 =?iso-8859-1?Q?DD2qkDGoJPp1DmylpWlbQcaqgv4jHfPSL+m9fL853FiddMtXnjN5qHEakZ?=
 =?iso-8859-1?Q?UIcrE1rnMtAQQx1n6Xs8WJkc1jLrN2flvy1ORb8hVENlwLcjX+H3GXRIoD?=
 =?iso-8859-1?Q?Aqh3vcPLV3YWu/AVsmvWNSbmrE27WeIB+wWgIeEIZa8eUDPSJ41djuR8Sg?=
 =?iso-8859-1?Q?5dUTnS7f16U60ndJJkcznel9xcJ25i/qzkucug8m/sURzHNFF+/G+t10QJ?=
 =?iso-8859-1?Q?gaPjyQuLSdUpANChQxzW8E7I2Nd84a0S7UCiQPTYB42MK2lALUAILFad2k?=
 =?iso-8859-1?Q?g+BDFEt//Q6D0K2ShK4ESqFcsYYVDemdYjV4pVa1Ut6E8wiQPG9C+cZ+Io?=
 =?iso-8859-1?Q?fbpxSCe+o8xeuiXENgAPjounvR0vNbEzofnDAqJYplr8/A8iQEoYxiKRbJ?=
 =?iso-8859-1?Q?GWSPOLhJ0ME91hv+788aQ5/j3NS/I6wKkvianniPb7kmRUIzGRDaAYzBD0?=
 =?iso-8859-1?Q?SUajoclKd7cz14qVGCKYnadFuetX75bNkUOJy8Aiqe+RT+ZFTftfyQ0z0d?=
 =?iso-8859-1?Q?+2fgMilD+oEdkNMSmglA/b6/IatdRVS1o8efIrrKYkVzlRL8d1kM2iZeVU?=
 =?iso-8859-1?Q?mkCX0wyP/e1z1T4PFr9IeE4sK3r0Ofrl+YjaVS/rV3xfbzjLaKCmQgEbdH?=
 =?iso-8859-1?Q?9R4ltRRMMirrRanl/vK9u/Yyy1uCn7KUU3o4WlgqG0Y1xTwscLaInmvsro?=
 =?iso-8859-1?Q?KjcgAJGeVFSCJOztWTAd0zAL0ihL5EmLPWbAqqCuhRkowzFP7XyOPxwwtd?=
 =?iso-8859-1?Q?2zxIYddd96z+3govl4AB6x1HfjQJC/JGV9QzD59GKhfTWTSDfzK2lrjc/y?=
 =?iso-8859-1?Q?3cfjZKJTXlzQEpunw/L4u0r1Lj/rzmoIqywGcp+pzgcw=3D=3D?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:DB6PR05MB4551.eurprd05.prod.outlook.com;
 PTR:; CAT:NONE; SFS:(13230040)(1800799024)(376014)(366016)(38070700018);
 DIR:OUT; SFP:1102; 
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB6739
X-CodeTwo-MessageID: f08477f1-80c9-4a5f-8898-ab0914776634.20250901160611@westeu11-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM2PEPF0001C717.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 4f022be0-a7d6-4943-d507-08dde971776c
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|35042699022|1800799024|82310400026|14060799003|376014|36860700013;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?fEpSs/VwUlg5YQGKjx2UGxSfJT79w0+ad5ipuYPk22voHvCYnRS6rdCrFQ?=
 =?iso-8859-1?Q?3D8kpoHim4tW2PN8EhtgVhaKSNzcblNE9CU68jU5hvfPsGgoxpJVA43u4U?=
 =?iso-8859-1?Q?AYSoSsKq3LCl2pY64tzWCF50yYaPkNwAp072eA5QphcNsPwB+KEV5FS2qX?=
 =?iso-8859-1?Q?P4J89Jro9B8K0DagQbmhT09Z++ekKpflt89g/8F1mZDNNIjtlivNMt09Ne?=
 =?iso-8859-1?Q?6hlKJ7iXXSMzhHf55Zk2wgrYLBEX2kl90oWbx0YfCWQodKwjhnBGiaNpPa?=
 =?iso-8859-1?Q?/7fs9kpP15fduVyQW9cc22S0A0rV4LJtlDpGD0r4/barhytd65IyaXsXRS?=
 =?iso-8859-1?Q?NFu7S1/6J8tPUViKj8QMMZS8DF1er1hJ8GQqp/Utb+o8RpixBgQ57lzC+2?=
 =?iso-8859-1?Q?VQiVySEgFUtfDkyILN8JskllwpIFkFo109wPjQX3eJl1NJZr6hzKvLCr8B?=
 =?iso-8859-1?Q?0RfpMuNrTWfeZIr7ngqjXpbbP0JnOyt3yYKJJxu77KfZy3l8xwp+Mf7ZrL?=
 =?iso-8859-1?Q?uXUoE+xShUT0zwqEu9Md9o0u2eGpLdSAfmYBxS5O4q9Zk6B+K8UeVR8UjH?=
 =?iso-8859-1?Q?1PJIsgpAYu+Hw1H+bkActiHVPo8MX3+UbFONlW84FSXk19AOXOCdXSX34I?=
 =?iso-8859-1?Q?qxegjt6bOSO+67tHodeUqQ3HeZzddlNkHbXQSFkIf2MN33Av/ZERiOYGHv?=
 =?iso-8859-1?Q?1lBQrL3XPEkSMyKE5RdoSl4IHJxn70oNOmDX+/BTkrfC2VlrzEaFHeBBLA?=
 =?iso-8859-1?Q?j41RP1Q4Bkxh4f59sFACIVA1neg1CRuuGmk1iuoPuzhKnlSyxQDpEUGKin?=
 =?iso-8859-1?Q?9g2hF+nzKK3S5/0V6otN6GJcp7ZOar6wvDwoBySP6ppusZprZofjYOoSIi?=
 =?iso-8859-1?Q?V9MJucgZiC0aU8ML2WzwRbtT5qiOtEKxt7+uzmZaj0jMHaQYk09EYgB3zp?=
 =?iso-8859-1?Q?ZlogOTK6I0+6oag9MmzQ6Sm2crreADCgOlO4VSjL/9dolkbjNdbSBjFvwp?=
 =?iso-8859-1?Q?5Y4jwsFcr3FsmL5kaX7h0miUrQgeGpqpSZqcGdSTjdAB1ZdzkNWVIE3U83?=
 =?iso-8859-1?Q?OvVu0H8L5wkbUeTJ/Dqn+a0XEPrmb0mfHx3/DgRacL2q+WZZFwoDZckja7?=
 =?iso-8859-1?Q?lAfZFvjxtyIjA3CvK97bRPyCatfexrZqCYXAteFVasVkeuvNqBPUlL/Lwf?=
 =?iso-8859-1?Q?A9HpHt0v5glREIvNNcbQuFZDKW2RrfWccsO3X/iuoXJ9/CQFf70gqh9K0Y?=
 =?iso-8859-1?Q?zKcXRAetJAFk77erOkWhhUR+j+gaR+AsN/7mcQkQOgQLhe2yH3UQNT64pE?=
 =?iso-8859-1?Q?03y2H7PEr3Opjv7L40yOUbyukK+afgp2L6hE1kQ5jSn8zIfbEq8/HraPKg?=
 =?iso-8859-1?Q?Hxatl/3wJV+p5f3rH7eAEYXJk/GP+ZPiKX3WDGtx79uhKfkbOqp13MZMjM?=
 =?iso-8859-1?Q?t8FrkNm5QvKpo1R3mwqW+9CmyxSHYFWo8BPnQk38dNcyYm/AsDxVu3Y0LO?=
 =?iso-8859-1?Q?ET5/BnSv1W6W6GbfIBZzVl/UYe8U6+s30a5q6ZMrd6sgPylodmzKFOqv/c?=
 =?iso-8859-1?Q?sN5/0UE7gd8mVsUQq9HO2LhQT2eV?=
X-Forefront-Antispam-Report: CIP:20.93.157.195; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:westeu11-emailsignatures-cloud.codetwo.com;
 PTR:westeu11-emailsignatures-cloud.codetwo.com; CAT:NONE;
 SFS:(13230040)(35042699022)(1800799024)(82310400026)(14060799003)(376014)(36860700013);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: sttls.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 16:06:11.5716 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d8072c6-5d80-4c99-6f8b-08dde9717856
X-MS-Exchange-CrossTenant-Id: 86583a9a-af49-4f90-b51f-a573c9641d6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=86583a9a-af49-4f90-b51f-a573c9641d6a; Ip=[20.93.157.195];
 Helo=[westeu11-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: AM2PEPF0001C717.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR05MB10571
X-Mailman-Approved-At: Mon, 01 Sep 2025 18:31:50 +0200
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

Even when CONFIG_NO_NET is selected there is still need for a=0A=
definition of ft_board_setup(). Thus move the checks for=0A=
CONFIG_DM_ETH and CONFIG_DRIVER_TI_CPSW inside the function.=0A=
=0A=
Signed-off-by: Maarten Brock <maarten.brock@sttls.nl>=0A=
---=0A=
=0A=
 board/ti/am335x/board.c | 6 ++++--=0A=
 1 file changed, 4 insertions(+), 2 deletions(-)=0A=
=0A=
diff --git a/board/ti/am335x/board.c b/board/ti/am335x/board.c=0A=
index 739b23b8554..2b7ab68e83c 100644=0A=
--- a/board/ti/am335x/board.c=0A=
+++ b/board/ti/am335x/board.c=0A=
@@ -616,8 +616,7 @@ static struct clk_synth cdce913_data =3D {=0A=
 };=0A=
 #endif=0A=
 =0A=
-#if defined(CONFIG_OF_BOARD_SETUP) && defined(CONFIG_OF_CONTROL) && \=0A=
-	defined(CONFIG_DM_ETH) && defined(CONFIG_DRIVER_TI_CPSW)=0A=
+#if defined(CONFIG_OF_BOARD_SETUP) && defined(CONFIG_OF_CONTROL)=0A=
 =0A=
 #define MAX_CPSW_SLAVES	2=0A=
 =0A=
@@ -632,6 +631,9 @@ int ft_board_setup(void *fdt, struct bd_info *bd)=0A=
 	int phy_addr;=0A=
 	int i, ret;=0A=
 =0A=
+	if (!IS_ENABLED(CONFIG_DM_ETH) || !IS_ENABLED(CONFIG_DRIVER_TI_CPSW))=0A=
+		goto done;=0A=
+=0A=
 	/* phy address fixup needed only on beagle bone family */=0A=
 	if (!board_is_beaglebonex())=0A=
 		goto done;=0A=
-- =0A=
2.34.1=0A=
=0A=
base-commit: e4c8b32d03d7ecffd586b7d33336603ad639d7c0=0A=
branch: am335x-no-net=0A=
