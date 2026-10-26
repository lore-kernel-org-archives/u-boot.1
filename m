Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA4B606A31A
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 17:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=DyIug8XO;
	dkim=pass (2048-bit key, unprotected) header.d=hitachienergy.com header.i=@hitachienergy.com header.a=rsa-sha256 header.s=selector1 header.b=cz5xLhPA
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0093A4084A;
	Mon, 26 Oct 2026 17:35:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VWGuNEsZpq16; Mon, 26 Oct 2026 17:35:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1FCE340800
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793036105;
	b=CRgEFZFEl95pIM1rHWNFnjBDlCuSxo3f89QPfj6k9AmZT2U9M0bzQJ7KyDQRdlja0ABi
	 QghPKQw6WbLQ0sFS8ZNVOjp3l04f6feBJi5dl0eNBl4j6oE2EbLpdMeeYsNg1NExxtCDc
	 oPKlwXfbFKq+wal4FLigKAU89auqPVR/wYvCxRmLcE6BwpWj8onW7bXTrpLsQ5CKKIabB
	 xH8Bp1LeeqQahnq/ZGoWX+9Ba7/xJNte2KBIDJIBSOp40pRfWqmmyLpn/JNx4A4wnennx
	 OxoI1wzgSYWtiqFrJS1SDfopotQlNn1PHV9kL1XmZcKVyx4hrC/XpYkvmfu99eFL4gQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793036105;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:CC:Subject:Thread-Topic:
	 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:msip_labels:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-he-o365-outbound:
	 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=kRs9FLkfxe5jXt99QeWbKvk+8nyTcfuKhpZEMr7E7iM=;
	b=S9SQfq0eDt5/DGPa2PUt70xQiieZtBHTPoYZu1wg0BKAo7jnk6fS1/JdflrfzAnUnBxJ
	 1pirqvd3iuc49ghgaVAjPnc17h4bpMyauIqeYCIT43oR+icSKBxtPkBqv/OrzZINS/xEl
	 Ow/i9N0oTa6DgSfMGh/qNLxPZROqsScgf/UnrddGz6z5n/n9ZrFpGq9vh8e/MbtnYhhlf
	 /q1h2lgyGBh+rWH68P99c8LF1rNZL8eD4W/h5xn4ozKSEBgsJvjSZjRHW1rfYqZmP6e/P
	 U4HmHfuIl7DA88xUNZm7TNOciKvCG1FCw6kwDiRaiPEcyg8Ja8RCYOF3fyu72ieR13g==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793036105;
	bh=kRs9FLkfxe5jXt99QeWbKvk+8nyTcfuKhpZEMr7E7iM=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DyIug8XOjxeQt0+bwNy+gAGJLqWcLBR3tKITDGgUolE0CQbv8X74NOB/8blO7GTpw
	 1XPChqlkHpTtIhPJJn2Gpe7o0UA3jahXfbJ5eKRl4EAdUisgKJHHev/+X3joWYCsQx
	 RcmY7YHFEgpEUVvbI5O8zbUfM3cGa6n2qhi2S6aFCjZnjN+pmmxg+WMVtDT4cuVqN7
	 RpSV6C8bKYOYVCJlvoj7Q0OxAurerv616rk6scrM0UclyGBFfvPtqfoScHlwTBCzBw
	 TuGMiov1HKTFnID/FkG6kO9XkHAg8ooQA5tgUKXHCrsAyH+H2j8i99JFxLopBIUfOs
	 L0DEFoGOwU/nw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1FCE340800;
	Mon, 26 Oct 2026 17:35:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 076D2380
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 16:39:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E19E040205
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 16:39:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uyaCGrzZXg1e for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 16:39:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 44FD4401AE
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::6"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793032773;
 b=MaancBhB+Ao9B1DKx39vx32bqZm01mq777xPsRW0MFxjQDQRrd05DkkU+IRPG0EycalR
 Qh/n7RvSHot1mlZTEL1JANq3BXJOpwovIGDuLt9Jb4MjI8emnnAV4UHnhMfNmebga/D/f
 8qdA4gH3zw8vA58nQWym4m17ZCWakJ4iO2t6bprGtzV+j/HLvXfuPk3bxpnuYhS+3s0R+
 E4TBqpRqUTSfRFw/DjqIXlUq3tSLylNJECu7y6kmhUdjGF1jVL/lQuHKnsVnf+Z5IUHR8
 dlyOmWH7b10lzg7rFEwyoA0fcYv4DnXgeVnVIAbdYHMsfT2fBkRN8i5+2ObVuPGO5Fg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793032773;
 h=Received-SPF:DKIM-Signature:Received:Received:From:To:CC:Subject:
 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
 msip_labels:x-ms-publictraffictype:x-ms-traffictypediagnostic:
 x-ms-office365-filtering-correlation-id:x-he-o365-outbound:
 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
 x-microsoft-antispam:x-microsoft-antispam-message-info:
 x-forefront-antispam-report:
 x-ms-exchange-antispam-messagedata-chunkcount:
 x-ms-exchange-antispam-messagedata-0:Content-Type:
 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-originalarrivaltime:
 X-MS-Exchange-CrossTenant-fromentityheader:
 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
 X-MS-Exchange-CrossTenant-userprincipalname:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=kRs9FLkfxe5jXt99QeWbKvk+8nyTcfuKhpZEMr7E7iM=;
 b=KIGjiQD/c263jK0lnHOXyX3YnoJYhglxqpWAWJ559k9DGK5Th6ASatJ6Vgd67Djjw8ae
 C2D16KhYfaEfSMBAhXBxdkH8pDDooTj2vpHi6kRQOMEI/tLI0fwKaJAaL/xllolnMnpKu
 8s2ILxI6WvIXYwSDRSQEowQiaTkyp2v1Mnvw0Y/9CdOuJrWp+AR/iKNHm0yrHmWVCkLAE
 NaORVjc6JFk5H00FUYP57W0IGLsWcOLgxq4tuzmuBSzbu/AeyOW5EIrtIcNaJME6B5zv0
 k2ENp+9Mf/vEVZl38DXx8mhkpFPrv/xFMi1yV1wMnt5Ugb0/l7HRLHpmrhwn43F/HWA==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=hitachienergy.com;
 dkim=pass header.d=hitachienergy.com header.i=@hitachienergy.com
 header.a=rsa-sha256 header.s=selector1 header.b=cz5xLhPA; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c201::6"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::6;
 helo=am0pr02cu008.outbound.protection.outlook.com;
 envelope-from=tomas.alvarez-vanoli@hitachienergy.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=hitachienergy.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=hitachienergy.com header.i=@hitachienergy.com
 header.a=rsa-sha256 header.s=selector1 header.b=cz5xLhPA
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 44FD4401AE
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 16:39:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vZyc7aVH8ontIZ85YYaERjcy/rJcFK94Kpa1fdOqW3cZWOk4pyhtJiUyIPta/TV6fDCN/7p2E/093QGnK4GanJfwb9NJSV+7ysOD8wjujoSL+UE8VRMMxbaCzjQpclHMQzY7cEpRSJuEGckzaB+NrfQ/8f8Uq1tm5CKaqSjC1RVD5Hlqj311vx7psvfD703fxhvT75yRv8rVGGO9H3kQr64DStFhsOrv0oaRNrYk3FeGdBpIBYWWo5s/weVSBOQ77aTwMUSrXheU1l1cZcfI+1VrnQrnYFY7u53tslvLTCCq0Dp7qN3H82TkJfHIHKDr6ZWhEzSqI983EdU0svsgfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kRs9FLkfxe5jXt99QeWbKvk+8nyTcfuKhpZEMr7E7iM=;
 b=aC1Y0PEo/zULjKEE/fXxhZ3+cHR4pmyCwgFqrfcZ7v+GLM/KtEhiebnD5iDhsyI6D1pXfik0ur0M/pq5VxUqeuKnqX5S+qvadv51GsBR+gs307l25WawVvB3kjprfqhA3fXt9aUkd7nWBEhjbxDLPaQ67CodLEfc6j5tZYTr92eXxndahnHxL3nP3DZsFPZST6ckSAgNbbwPJ9kMzfK+NlfXZtwkaN39Ee32zQQ9G2JXL4w1ZKQRSNAvLwDbCplpoRd9RT+8g+oNF6K4PKOmqkVlRm0TyEtg1tqnDn2YhlR8YCMCaDwg2Th2qughl+2eDDWD2pe/+bPdX5xnDvDP/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hitachienergy.com; dmarc=pass action=none
 header.from=hitachienergy.com; dkim=pass header.d=hitachienergy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hitachienergy.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kRs9FLkfxe5jXt99QeWbKvk+8nyTcfuKhpZEMr7E7iM=;
 b=cz5xLhPA4WIP2lL7HE2tA+h8jrazwBBs57kjLej6L6of/vVKBLKYi1iXYB1hyvJuadbpajL8LgEPMHrUXDHaOB5h2v7VNGQs3I0OW9zXzB6APCPYwsLDHAdz5w1zWD/klJR8TQywpiYu+vfFbdRWZ+F/P0Q+8FO6iTo//PFBtu/05TWFzWK1gXmIS5F4ID1DEv36vKATV6n4ctPdE5YNjOjlQwl4HlhnIrL2UHOLHodS9gobZeF35kHIgcDtVtFO01GIlLj8mivfvC0AxnNjepp0c41mOkL1ACw/4NNcvywtAk0afVNnrZm4h+4rhFk1cDnHGtFXT1hjRhbnx1949A==
Received: from DB9PR06MB7849.eurprd06.prod.outlook.com (2603:10a6:10:291::22)
 by GV1PR06MB9385.eurprd06.prod.outlook.com (2603:10a6:150:19f::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 16:39:21 +0000
Received: from DB9PR06MB7849.eurprd06.prod.outlook.com
 ([fe80::f0f5:da:c159:65ab]) by DB9PR06MB7849.eurprd06.prod.outlook.com
 ([fe80::f0f5:da:c159:65ab%7]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 16:39:21 +0000
From: Tomas Alvarez Vanoli <tomas.alvarez-vanoli@hitachienergy.com>
To: Bradley Morgan <brads@mainlining.org>, Vincent Jardin <vjardin@free.fr>
CC: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@oss.nxp.com>,
 "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>, Sinan
 Akman <sinan@writeme.com>, Bryan Brattlof <bb@ti.com>, Holger Brunck
 <holger.brunck@hitachienergy.com>
Subject: Re: [GIT PULL] Please pull fsl-qoriq-for-2027-01-rc1
Thread-Topic: [GIT PULL] Please pull fsl-qoriq-for-2027-01-rc1
Thread-Index: AQHdYfgxcd8Euf/YrEWQnfd/hXanv7cJoxWAgAXlIwCAAAu0gIAAUmqAgAAKiICAABa0AIAAAhgAgAAA4g4=
Date: Mon, 26 Oct 2026 16:39:21 +0000
Message-ID: <DB9PR06MB78490540DD8519B943F1B688C2612@DB9PR06MB7849.eurprd06.prod.outlook.com>
References: <atm8jabAOY-wLeaB@nxa18884-linux-1.ap.freescale.net>
 <C7012F65-D275-4D2D-AE1A-9340A5171FB9@mainlining.org>
 <at8StA3lzLMDbcrR@L30177.local>
 <6C364E68-4927-470F-BEEE-1F9AFF3FDCD0@mainlining.org>
 <20261026142023.GA624796@bill-the-cat>
 <50F741B3-1E13-4B3F-BF87-9DD7C45E1216@mainlining.org>
 <at99iCtY7_bTF85U@l3017728.home>
 <8961F479-747C-46A1-A6AD-DC55A25379B6@mainlining.org>
In-Reply-To: <8961F479-747C-46A1-A6AD-DC55A25379B6@mainlining.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hitachienergy.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR06MB7849:EE_|GV1PR06MB9385:EE_
x-ms-office365-filtering-correlation-id: d72d6be6-bafc-4363-6773-08df337faff5
x-he-o365-outbound: HEO365Out
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|18002099003|22082099003|261026140227099003|38070700021|56012099006|11063799006|5023799004|4143699003|261022105027099003|261021121427099003|10067099003|261022075727099003|261021135927099003|261026121527099003|41080700001|15866825006;
x-microsoft-antispam-message-info: sDOGVj/fdQVx3R5f3ovDAlUThleMXGF4JVYzAtRE3YClWvVcxUKwX9FaRhKoStkL3MzOZzhcp8CGoQsV6iRv9MhPglt4zgG9Df9oa52JW9H2Caxeb+WSXSIxITqHxF0g9q57tmrgOYILViPOyQzsLYLcudcrZ20yMo4ZjRj25H2wfqJAkLAwDjV/LqVHLf71nx+iZodN8ZT1o+DeX+SxZ3rcPiWIuBS0vLpdcjTNbEeQnteStlYFW6LRt6bkkCv9Oq4Hq0Dnb7h81OVWWwGpsQKTXG3idq5d8FBWCHG36yvZg2A98X7GChQzvHdkJLx6mQwdRf1mk2MP6JyNU0m2fpZ8ipNEpxWvo0sEuX1DekI2ELJxPo6qh+0bxSg3SA7wri0xg+sQRwJHatvx7zdlbr7ABzPFtFVmqSRKqqMk5a1UaJViHMYQxm1i/DJRxM0VfL8v/bXpiOTe86CNMFDxr2erAY25ptIIRqMAtdV8vL8WLqTAWPRCzBCwM+GP0jKBsZIK8ZC3KOO6rgTZJhi2DjV0/jJA6Amoq76CiUiDmxsKpi8S5Y20rHmwJEIGMbJ2FPnjLg5l55Mr2z/1ohXkP82i/386HoTlaIPOuAW9imcOlhHz4cLTRCFsFE25niWmURk7xTrmqUSQI+NlhDwTLCAc+os9kERSRn39a2UHzopfUXA03AnFJVlgwxVqYnbeRHDTxD8AwZAFSxPuNl55q3osjFfuOaynXYVo6z+76gql3c0TzfLQk6wUvT+mnwVo9l/eTzX9VEKIrR5OSv8MSBCZFDgh9tmrVCYbOqX7cLQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR06MB7849.eurprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(18002099003)(22082099003)(261026140227099003)(38070700021)(56012099006)(11063799006)(5023799004)(4143699003)(261022105027099003)(261021121427099003)(10067099003)(261022075727099003)(261021135927099003)(261026121527099003)(41080700001)(15866825006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?fvO9/fEO/RDdLRilgtiwxrpVwPJq5VRLS2K1KphC1vFMoNDaxTXQC8Jadn?=
 =?iso-8859-1?Q?kAqwvhi+LgEavls/C7eePKjUnh4xd3JkgDMLedwGCP3T0Htdn5SHqwskZE?=
 =?iso-8859-1?Q?DFnvUR9s7NNd48FFdQd0xB0zV17RpS6dum2Anyy3I1b2tO/uMnH8FpRmtD?=
 =?iso-8859-1?Q?BzRzu3pQ07JMpx/TTf+BXeQd7IwWLwWB8AA/9ihAnDzjnoCAdGbZF3sZno?=
 =?iso-8859-1?Q?tnLI7H/Q9uEDBYb8F0DjlqRWq7d+IzeAlZDHE5kIVVYf/kDlKn2Xpvudc9?=
 =?iso-8859-1?Q?Vevbl+SPQVPDn+HWDuAl0MtZwZc0G4Iq2oiMHbkuomsHw61d09PTHc9poz?=
 =?iso-8859-1?Q?8dHJQtCQAckq60RJmyhJpEqP3n+cfUKlLISEwUTzbejwFtfpuNNEwFQqDd?=
 =?iso-8859-1?Q?hSx3LuEDFyjstAkzRy+fc+nS5MW4m+l3zrVGXSufJABCA7LPBcf61s79vr?=
 =?iso-8859-1?Q?3kn0fTSmD8iT+C8p93krVYFe+nsJVy8EifXH51KG3NbAmh0Lq612jbWayG?=
 =?iso-8859-1?Q?6kr/tdWVJaBUpraCr06Ia2Q5fmRbZxvZWcrnbihl2b/knUXjqooh0byaN3?=
 =?iso-8859-1?Q?46UFSQBCl4m2BwNuqliHma/XcEmnicc+4W/RflBSxfZTxjgV0XzeOFSt1F?=
 =?iso-8859-1?Q?06DMwWFAj/S4SVreZz4hsf7nCdoKJH5Mil3ALoMby+eL6NO8ZsAYrGeOkr?=
 =?iso-8859-1?Q?HA9pFIGnXiUaxG2s90vTlzkd2Ek3V40iHLepmgjvYyIuD0TPW8Ch1XnpTg?=
 =?iso-8859-1?Q?sJLdVE3n6WCS6OseqllRwLdkUPO98ieqX42XX8uUR7TPUe4L3D7dqLvyvN?=
 =?iso-8859-1?Q?qdMrkOUeRmgQCOTr0aQFPSAB3K4fL3aAgf3Q5XJvVrlibLIlbPm+Wbklnm?=
 =?iso-8859-1?Q?qxgiUFicjaUBOx++AxyvxskRxDh3rN8qyYMXeDG2qyrzRlCkKph+z1Dy0A?=
 =?iso-8859-1?Q?Clhpnw3FWJcVkW4Ke/VvoiF8lI/7kNaV2IHVw3bP4gmraGKkHTzPd50Y2c?=
 =?iso-8859-1?Q?7iaORP6PTCdwUpYyeV0Wj4vZjO7LcjFNRMvy5zqNd2+7bWb8AA5k4G5q9n?=
 =?iso-8859-1?Q?H7TtCNqCo74LT5LbPUbhkpTwIjVcdKhpJ7L5iMaQKYUoBhFDSlSdfuWo9W?=
 =?iso-8859-1?Q?e7ahOTJ2+bqu3tbBhpv2DqB6XD5h4G24HNy7+DPGcV4QBM2pIGtTKELe2E?=
 =?iso-8859-1?Q?nIh69Xr1mRuN2sw7rT8uWd+vmyHuLLM4i+5paKOFXSc7tcDgZdw0KdGqQP?=
 =?iso-8859-1?Q?EDoyWZ175C4JJS/XSAosfUCcGzMQFMtZiivxb+WaT3ZoXWw/4Yw87sqol8?=
 =?iso-8859-1?Q?rIM5AfttgsSbSTXQKbp954mCm5g2V+UgzZMXcLYUZ/VL///UrIYhDPjiwy?=
 =?iso-8859-1?Q?le6uiIm7o13/jdlCJP/BN18qBD71cXsBDjVrnBOgA5GYTK2X5rYXqGmIj1?=
 =?iso-8859-1?Q?wZoVH5HeWaMu9is2Dp5l5Mk179NASeWZQZj2u2jz49tEq1KSDlvWADcN7T?=
 =?iso-8859-1?Q?g9+xZlTOIMmOF0pxJFlTYunhFnFS8e49Gkz3LS4SWket9UorJTtA+ettKB?=
 =?iso-8859-1?Q?4appvfyk4RtzJLIfBKm4EhEBC7qNskYcxd/BwaZaIlk//GdaA9xp7Y3PG6?=
 =?iso-8859-1?Q?mkHBFqYT1fB2cX0hSTEcs9R5D2P7eR+zQVq1tRlvt9KbIhAYgR5Tzv+RFE?=
 =?iso-8859-1?Q?OQugIaUOmLyN/geNV7dame5PAMHXeI890hfN9t5Ouqcm4LfARinYT7S2ES?=
 =?iso-8859-1?Q?f1hdf8pynVZYCjvueg5BK5gaFEq0MXng92Mk4ZeVvwbio4rfFCZpE71DZY?=
 =?iso-8859-1?Q?oski+Fnlfolvf5xLSTXwElWPYVmEk1bhtg1s5j55s7r86yE1PUVd?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: hitachienergy.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR06MB7849.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d72d6be6-bafc-4363-6773-08df337faff5
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2026 16:39:21.5584 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7831e6d9-dc6c-4cd1-9ec6-1dc2b4133195
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Odwaejv8hwtbn3QPapV4OWomvz3rwizORe3rFdir3Fihj/zYIGQrtVjY/uq/PLj+X1ZEFF1LpbznfGLVGxKEm8Db1kYpSmxYiu2BuND2n8TbTcxSwMVdI0WjGc/dPXBs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR06MB9385
X-Mailman-Approved-At: Mon, 26 Oct 2026 17:34:44 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

>On 26 October 2026 16:19:20 GMT, Vincent Jardin <vjardin@free.fr> wrote:=
=0A=
>>Hi,=0A=
>>=0A=
>>> Isn't that a double edged sword?=0A=
>>>=0A=
>>> I mean, since PowerPC is SO inactive that like nobody will respond, and=
=0A=
>>> it'll be limbo limbo limbo, just to merge say 24 removals and a=0A=
>>>=A0 maintainers patch, especially the maintainers patch, that has nothin=
g=0A=
>>to do with the removals and that'll get all stuck up with the removals I=
=0A=
>>think unless you have other plans, which is annoyance, because it is "oh=
=0A=
>>so inactive"=0A=
>>>=0A=
>>> And I also made a additional maintainers patch that IDK where it will=
=0A=
>>go!!=0A=
>>> Either to my custodian tree (p,s: maintainers patch isn't merged yet!!)=
=0A=
>>>=0A=
>>> Or to another tree, yeah, odd, hm?=0A=
>>>=0A=
>>> (Sorry, I had a small vent, :c)=0A=
>>=0A=
>>I would not drop PPCs so quickly ; there are still many systems running=
=0A=
>>PPCs=0A=
>>even if folks are more in "don't touch things that work", I feel it'll=0A=
>>change=0A=
>>withint the upcoming months because of the scale of CVEs of those old=0A=
>>systems=0A=
>>and some new regulations in EU. Let's wait/watch, maybe one more year,=0A=
>>before dropping.=0A=
>>=0A=
>>It seems long, but looking backward EU regulations will start to be=0A=
>>effective only=0A=
>>by end of 2027 and LLM -> explode of new CVEs are just starting...=0A=
>>so the mindset of "don't touch, it works", it'll have to change.=0A=
>=0A=
>Yeah, I removed so many systems because it was 1: EOL, 2: Old, unmaintaine=
d=0A=
>rubbish (well, some of them)=0A=
>=0A=
>But my concern is the one patch that has nothing to do with it.=0A=
>=0A=
>26/26, the maintainers patch, I already got a tree and stuff, but I=0A=
>wouldn't know if like it'll=0A=
>=0A=
>A: get merged when they merge your fixes=0A=
>=0A=
>Or=0A=
>=0A=
>B: Merge when the removals get merged :(=0A=
>=0A=
>I'd prefer A personally, because of the fact that the patch has nothing to=
=0A=
>do with it. If that makes sense.=0A=
>=0A=
>Id personally think a cleanup is more than due for this, I have millads=0A=
>more cleanups to do when my maintainers patch gets merged, PowerPC as I=0A=
>see it at the moment is in a slight disarray, well, it works, but it needs=
=0A=
>to be cleaned and organised a bit.=0A=
>=0A=
>Id say 19+ more patches would be required in order to make this actually=
=0A=
>clean ISH.=0A=
>=0A=
>Because for 1: power(8,9,10) isn't even implemented yet! What!?=0A=
>=0A=
>Well, I'm not sure about that being a priority because for 1: it can be=0A=
>booted thru LPAR. Which, is odd. (Thanks IBM! :c)=0A=
>=0A=
>Personally, PowerPC needs a nice dustpan and brush across before it could=
=0A=
>be classed as an actually clean architecture subsystem!=0A=
>=0A=
>And god forbid the bugs. Somebody with a AI will be having a field day=0A=
>covering their ears going "la la la la bugs", because I can see bugs all=
=0A=
>over the place!=0A=
>=0A=
>But thank god people still use ppc on u-boot, and for anybody reading this=
=0A=
>using u-boot on their PowerPC as we speak, thank you so much for using it,=
=0A=
>and me, as a maintainer(tm) and the whole community sends our unreserved=
=0A=
>thanks for your use of it.=0A=
>=0A=
>=0A=
>=0A=
>>=0A=
>>my 2 cents,=0A=
>>=A0 Vincent=0A=
>=0A=
>--- Thanks!=0A=
=0A=
=0A=
Hi all,=0A=
=0A=
Just a data point from a user: we are using U-Boot on a T1040 (QorIQ /=0A=
mpc85xx) in a product, and we intend to keep up with mainline as much as=0A=
we can. We'd appreciate PowerPC support staying in tree, and we're happy=0A=
to test patches on T1040 hardware and report back.=0A=
We run u-boot in 32-bit mode (not sure if it is possible to use 64-bit) and=
=0A=
linux in 64-bit.=0A=
I am in the process of bringing it up to our 2025.07 branch and potentially=
=0A=
mainlining as much as possible. We have some remnants of it under=0A=
`board/keymile/kmcent2`.=0A=
=0A=
If any of the planned removals or cleanups touch T104x/QorIQ code or=0A=
boards, please keep me and holger.brunck@hitachienergy.com on Cc.=0A=
=0A=
Thanks to everyone maintaining this.=0A=
=0A=
Best regards,=0A=
Tomas=0A=
