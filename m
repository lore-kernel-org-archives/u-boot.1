Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE882C282EC
	for <u-boot@archiver.kernel.org>; Tue, 18 Mar 2025 20:37:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E94B810F4;
	Tue, 18 Mar 2025 21:37:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="t0vKroZP";
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="W3siN/oX";
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="WWfBR4Hl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C93CD8129F; Tue, 18 Mar 2025 21:37:03 +0100 (CET)
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com
 [148.163.156.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E47981026
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 21:37:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=synopsys.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Alexey.Brodkin@synopsys.com
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
 by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52IJwHla005071;
 Tue, 18 Mar 2025 13:36:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pfptdkimsnps; bh=Fd6gsawyirmqs+hrlVlOG
 AlAyy8Md2/0GHG1m/hQ7fk=; b=t0vKroZPTiNhlVDUcZSiHRvt8A3l5Z0tQNxc3
 bcBpxMH3fl7L4A6AEvAxMG99tBfsw6tabR0N1cwlw5lFn4GahtYg4s00f6Tr9xgH
 a5i+8HWsiDJFr+rQ0V7rrw3VPtOTP8Tjojj2b/fqXcF1/ePQOaXvz4bazau/VsdI
 5gG0EXGF+th4y9ipXHDBsXB5aKEK5UF6lSFoh2ZdWZ889TxBbnW1b/qiNyU9Rg00
 5JrhpxCYqRNq/wOQMCBAwJlZJ5gsZdhzNtiACqzQ1y4RpIwMseuXOnxeK8hgqn0R
 AW8CWFvQETowLLzF+k4MBmYlNIneL3oLL2eARlITVqHtGbAiQ==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com
 [149.117.87.133])
 by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 45d8t704s5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Mar 2025 13:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
 t=1742330217; bh=Fd6gsawyirmqs+hrlVlOGAlAyy8Md2/0GHG1m/hQ7fk=;
 h=From:To:CC:Subject:Date:References:In-Reply-To:From;
 b=W3siN/oXWhTlgrXa+NDSxyOoqou0HbNpw6X3yv8NeIIU2WGHGWnR/NluAFm1Z+FZJ
 u8iEy9qq3ILn6u1KBLeLwWHuJU/eA+mCVD1yBq66lNTrQxq//+ilh4J0P46CEtlt7b
 1Wju61bsKYECKi5jnvuQWlDOIlRvMy1D8FMGdGXfSXscaXQlj/5CW7LwQa1kvmMhj5
 Hg5t6TdWAUJoswYf0auJx5wW1Ud01gVFwIKtDq1kA2ChsnfNgp5fM5qo2WevmiIfnV
 XubCuk+mTc0LciZWBdWpLRg+EKuOzAriR160byT4PeUAQ7LGiwdAg7bBi9HudE21SF
 BrFHiGn6KWFTw==
Received: from mailhost.synopsys.com (badc-mailhost4.synopsys.com
 [10.192.0.82])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits)
 client-signature RSA-PSS (2048 bits))
 (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
 by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 926F4401B7;
 Tue, 18 Mar 2025 20:36:57 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com
 [10.4.161.137])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (Client CN "o365relay-in.synopsys.com",
 Issuer "Entrust Certification Authority - L1K" (not verified))
 by mailhost.synopsys.com (Postfix) with ESMTPS id 0F31CA0077;
 Tue, 18 Mar 2025 20:36:57 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com;
 dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
 spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; dkim=pass (1024-bit key;
 unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256
 header.s=selector1 header.b=WWfBR4Hl; 
 dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest
 SHA256 client-signature RSA-PSS (2048 bits) client-digest SHA256)
 (Client CN "mail.protection.outlook.com",
 Issuer "DigiCert Cloud Services CA-1" (verified OK))
 by o365relay-in.synopsys.com (Postfix) with ESMTPS id 4774F40120;
 Tue, 18 Mar 2025 20:36:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SdsHF6VGNrXL2qn93JkWe2xL81SSdV7Neabe98+fvJ6Dgu7qCTj+hjVtLBTDE7/0fmHCgAgq2oPmmCAn+ctMjTxbZSFaeP7Ob5Khacd1+g2euIQX5Kz+7Ffjc4jhSHNGNQcw6zuXANpQyACDvRXeR8nyKmmxDuD9eJsiTM6wUw1Bom9MQzaHFoTWvrJ3PezqVA0nTcyM+xdTxHX52D0ivazSpwb8EBmY5sST3oDtGOgM8/ub9nJ65/xI9nDsW2do7mGqUgDg7HR9n//nw4dRR9kyoKEsXufobj8j5thADRLa8I1nr1pzm4hjRg8Fy5HSJJ3VLXr6Z0C4rDNDfymDzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fd6gsawyirmqs+hrlVlOGAlAyy8Md2/0GHG1m/hQ7fk=;
 b=PhfpdHUicpcom+YixmcUkrmb51ako0RiAabTJdGwIyTsYDU2Rbs6dZIcTttOVstcNDIYw3mp+xNnADuOa4e8DZdxk9k2kmIYBBF9KE02VAZDGa6lJMeRfcBDMnzG1SWOVnPduOVwe751nk9oQTne4AZl+2lDZieVA/uVCT8myPNiS1WcovCYFFhe/tkwqtYGqajSklhGS0ZAvAT60Ksq63ky7DbyuB65SCxE+ejxYcNuuq9rJ4IIiDxAujXf3btxaA4W7/3m49I5K/B0a7XhksnDCtwKODg0/ArO+S1cTw2+eMS9o1wsb5rBr2QQQHVFcGQkAnOpBabXbXxivP6P9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fd6gsawyirmqs+hrlVlOGAlAyy8Md2/0GHG1m/hQ7fk=;
 b=WWfBR4Hl3gbiiWhu+0uuuXRUTUjI0HTZptPgU37Fh+O1ucsl3/2dsnWcLc1dNOYXgLPG8DPhA7j9gab8JteaeNWsP9hXuk90MeHzfmNYXbi4jHV1TGegEmPGm2H+zjYw/fpFSMyc7tYGKoWxZ/tf3iKSGJv6lDgEqZN2aVbgjPo=
Received: from IA1PR12MB6113.namprd12.prod.outlook.com (2603:10b6:208:3eb::8)
 by MN2PR12MB4406.namprd12.prod.outlook.com (2603:10b6:208:268::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Tue, 18 Mar
 2025 20:36:53 +0000
Received: from IA1PR12MB6113.namprd12.prod.outlook.com
 ([fe80::65cb:f536:1808:2faf]) by IA1PR12MB6113.namprd12.prod.outlook.com
 ([fe80::65cb:f536:1808:2faf%7]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 20:36:53 +0000
X-SNPS-Relay: synopsys.com
From: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
To: Tom Rini <trini@konsulko.com>
CC: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 "uboot-snps-arc@synopsys.com" <uboot-snps-arc@synopsys.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH 2/2] arc: Migrate to SYS_{BIG,LITTLE}_ENDIAN fully
Thread-Topic: [PATCH 2/2] arc: Migrate to SYS_{BIG,LITTLE}_ENDIAN fully
Thread-Index: AQHblUm1g6B3nFpoVkyTrIf7QcufYbN5Xyaq
Date: Tue, 18 Mar 2025 20:36:53 +0000
Message-ID: <IA1PR12MB6113FA032A4687CD64BAEDC3A1DE2@IA1PR12MB6113.namprd12.prod.outlook.com>
References: <20250315012923.399465-1-trini@konsulko.com>
 <20250315012923.399465-2-trini@konsulko.com>
In-Reply-To: <20250315012923.399465-2-trini@konsulko.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB6113:EE_|MN2PR12MB4406:EE_
x-ms-office365-filtering-correlation-id: 2c37d77b-4c69-4258-dee8-08dd665c9e1a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|8096899003|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?d0SLHgXzb1jjBzhAUGn+1z/fX8KGSGyTyDpF99Dmj+kbfWBKOWerBgbKqX?=
 =?iso-8859-1?Q?J+Z7zdjSq5ts/Izgv+P/zILq8EsGNP+3QyX7fSUBhHhY3GBjz4k8M92TCO?=
 =?iso-8859-1?Q?uM0iDHYvwiIU6ODDy1sUt0nRNjvzRceTgcj8qo9sVzxs8uK0vuW2jEMFAV?=
 =?iso-8859-1?Q?aWQfe6xPhMnDgrC5m0JRtVAIr2Svtp1MkdFoPe8EluSD6lciSC8dmlYRQ9?=
 =?iso-8859-1?Q?IiOaoShfQ5HYACGUB+2yoKqhcCY5DhX5jVxrf1yHHPMO5lIt9RY5VlM3/Y?=
 =?iso-8859-1?Q?vMzkCcQLQh2LBpbgTL81iuOTy67Vk/lk7OJ+C3lv/5BIo3rj7VR6MX7Aua?=
 =?iso-8859-1?Q?a8U2DZi0ZbhF0WuReL1MvHqndwiHafIUxHHEuXZMJPcKRmSbS3yX2Cqi2L?=
 =?iso-8859-1?Q?sZne+PEMEngVZYGrE+R447VAtx+6Jd0NK8PQ9JMz4yXFgA30Bb5fVgvCow?=
 =?iso-8859-1?Q?arePqezzreEgwkyaXSlufS9l/B58CKKPNTnrBN9jhYtIraJvpb7bVKclu6?=
 =?iso-8859-1?Q?eWzL0OPTqil3boVrGNXoEXIl4yAOOLcokmcjf3sBWne9v7NX0eXDOaBmT2?=
 =?iso-8859-1?Q?4jjzunP+OKMx13Nr9OOezfxJRPMDhdbl4W8tm1PXYbT1yrUD5z9+YXP0ii?=
 =?iso-8859-1?Q?Ko//3KTJDnjgEaiN8ng7R5HVOpP6tkSGOsf11of9GrEiOJqYVI4N+dbB48?=
 =?iso-8859-1?Q?YcPcy4GjpGn6lUO/ItGAHUkeJencxDcXpjtDPsE2RrYSuyyYKB6+nbBhBs?=
 =?iso-8859-1?Q?3/xYgguIdFGn0j/9FwkjfAPlWiE92lm6w84/Fxu1+k7RFw54Xxnwcl/uJX?=
 =?iso-8859-1?Q?Udw8valH9H5f2d8+zfe5hTieX2XfQ9Z5M8nJvw1r50OypYGJoBa2mpY8B7?=
 =?iso-8859-1?Q?erUAK7TGo4AgYoTzhBAbh+O3MkT6WEQhwe1m3KarWGQklxFwCaNaAmgS+1?=
 =?iso-8859-1?Q?kNYWH+gLut4NS2vKUlQ0ZhVn70YCqknoZCgqN+40lJ30PXEruTZFI2Oz9v?=
 =?iso-8859-1?Q?hPQaeA0ioLtlYiQ1TjV18pxJ6SLo3ppxZ+eUBVseMVek9K91jdCWXy1ghq?=
 =?iso-8859-1?Q?evTwA5kh3zHgY/pPH0U1/3p/rjUulo/sKzofXBEtV1/XqTocTXluaXFt1G?=
 =?iso-8859-1?Q?EU8AIp/l0/txcNzC+nY9HVb2E/TM0zM0cgMRY2DnweVVna7A/fz2CZD/r7?=
 =?iso-8859-1?Q?ezykdo8MUN5uUvqh0mb9E7K+IgHiL3ERFh72lw+QqkQj52CgV60p/cQg9y?=
 =?iso-8859-1?Q?r6Tpsu+xUOGyzmXPjyAsq5/IXcgI+vuVU3WHSbXpmoE0WS4CchwwN1C3dC?=
 =?iso-8859-1?Q?ly3MnqqOeRLgOcTwIGL4UYq0wnNCE5iAMBQ+a3kBzSuVTmkAaMOaERQzzk?=
 =?iso-8859-1?Q?Tkf40h82H13DSNK/pgxoMurkEjhsHqcLCdopPnAvZ0dCAXM0cmT0WHK+bj?=
 =?iso-8859-1?Q?kN6A/Q6itDN0vvAGW7KgFU3LjN04QLGJLajoP6AJsGbNpt1Y+YeS//tDKB?=
 =?iso-8859-1?Q?X/Z4f5JY05sL1opX5xiAp9?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB6113.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(8096899003)(7053199007)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?VkDxXbZNhyOHGPx2/6aWZ/KkY4TAjuHAYsboIflsHndbGynux5HdBnpI1/?=
 =?iso-8859-1?Q?jxFCgGBlXaAtK3Z3HhQxhSUY2v50YT40JNh+FgRayWQ8b6jSOqds4IuQ72?=
 =?iso-8859-1?Q?2xo85iQgh3Awa2yhcAEsQ2JMkFuDjcen1wT8uVOZHzs19qTENSll3rTVSm?=
 =?iso-8859-1?Q?6y3ynZHW8aeFD7LbrCxt8xIwrwgSy5rqTNhA6xz7o8WjIGd0iJMGUgDqBT?=
 =?iso-8859-1?Q?trcN195cfmKJa1kCgMW2BUCjEh3o0Dn45ZqepQiRnRDjbbpRbw0+OZlZvh?=
 =?iso-8859-1?Q?osexwX8OR2Ra/u6K/1V1dmDyYk3xCf4davdUIPdPc5kv3539Babvlr5WZn?=
 =?iso-8859-1?Q?B2rp0SsDygYLaR7STAHO0L/S+qygviRor0yFPhuRqp5qMY200NbJ2YmZQ0?=
 =?iso-8859-1?Q?BNONN82B8B+ga6idi1pZVxnUsy8fAxKaMfXJfHImWcZr7c9lVB2xWKGryp?=
 =?iso-8859-1?Q?8ttG49qH4C9QQkyBQWB+L+8ucHKH6001pX85N0jDSxSgYcNoGBM4Ip4lSe?=
 =?iso-8859-1?Q?Iyr3P/SZFEpXx+gSljFeYMhygP9mUKd41+6wBXhg85yeQPkT2kred/Yy+7?=
 =?iso-8859-1?Q?GNG7iFAaLTNYkE2al+qqdcZ3K6cwfeZ+6bnrzUCQpAVHOEx9XC/DLfNVDC?=
 =?iso-8859-1?Q?1Tl1bteOEB2amvAX8Q0w5K6UvCIgJ8el8L1hjwLhRsJRyL/JUn66Sww8zE?=
 =?iso-8859-1?Q?KCplvr0a01nkwQRcU6N1IqRAr+uTzKKBoAEd5ZHFF748EKCDJOVqjZQl5B?=
 =?iso-8859-1?Q?ISGMi+IAVlnXbkzZsyOhB1LDkpGfK7AIoZ6vXU93iGYVB1G/xw2iVNKkku?=
 =?iso-8859-1?Q?/cOPuhOAQQOXhJxxo77ACzlGVSeKZh39TJUZo1488rewlratoGUZASpnqG?=
 =?iso-8859-1?Q?+DAa9yPtDOxQ2b+WTcYlZ4EkT+mmuPHC1jtnhN7iXO5oPs60ZwHwGEQAHo?=
 =?iso-8859-1?Q?GtCV5dvgOGF6Q0mKLymW+9gasqFTdNop7ickQecVjnEgCok72tNrC4QTcb?=
 =?iso-8859-1?Q?f2FTmksGe2WaqMnqxB3i4rK9pPTTJAmHeGXdroa5ftUgtPmsAhnBgxz3Gu?=
 =?iso-8859-1?Q?dQkKdlUjfPnIuvpcXOuwwXn1gbdI/qhn3MBW/Uqzn1G3qeweJCh8P2ll1V?=
 =?iso-8859-1?Q?+i+ekD8KiOnXsny1c7abaA6K6ZOpexLomGw+vWVek2yPLjy5yBRIa/5Ewk?=
 =?iso-8859-1?Q?ldn/sTLWJgccoV/CHu+F0pAmgjzi3dzx0GVti81tYGsBOsSMQxnoxhBXNz?=
 =?iso-8859-1?Q?aZ1xWMqYDkgdoTXgwo7LA7XUigvh4xGS59vGG56uQXR4C+FEHhBJjOiYy5?=
 =?iso-8859-1?Q?b76kTCHyz3Mws1yiBRXR409fdlsfGFzSCYfd382YUwMPkWm8C+eurQ/D/Q?=
 =?iso-8859-1?Q?V91jNKSy5c6N7am/SIpsL0COz/+hZBRUg5UM3ZiEpvhOAJVUAOHFMI5zuI?=
 =?iso-8859-1?Q?e9GB2gen57LcRzmZppzRrK+yvjm+WpDhAzSVBLMB0ndjaztha/b+pbV4VS?=
 =?iso-8859-1?Q?UcE5jSL2vt7mviZS96X+9KumT8XPUYDhLNTLlTO8wzbCPWmWCC45PaHnml?=
 =?iso-8859-1?Q?CSo4NVa+gZR2uI88kJlWGUMQUevEnVKQ6m69PBWIQclpoG5m1ZXf04U97u?=
 =?iso-8859-1?Q?8/FzEjoqgYmb2Y0eRs5jw0gcjieMp+TWQG?=
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: DrYpebtKKehEDnQRjbEJoXUyd7EX1bFq6gZsyfqOgNrV8Tgq7A5Os8d2xjHKfc48rM7LRHnOephtuKyQG8kUlJAO2gdrvJmYoGnhNSfKYV0nfT9s1yHlZwKhdKgHN07t9sa1roESOoJFKddqShM+OpFE8TlQIOv6eyXZSzZN7xXEqQraO8HFwzdU0Cp63tZqrsgcG658G5QqqbkMro4f42Is1JbOODsPoVdCbt+tNMmTtPQ9/BAB5YLuYFN9ca8f+xLkjJVFcOrUrLee6tlh3dRrvSZ/s71VrS/ariPoBNus3f9xZhSRIQ5JckKSijo/0UlPL0moI3ismM4TbAmOYOIM++askjuLeS6rtDbBwyk4C5kL1/6NKr54pA83QtbmGlgoAAesgiagxMLQAaaW7nydQHIgmc6WSvDI2w918JKV8Ozl7ckuNQxK2vKpC5eUXaKYFx6Rtd1MYrlCacttvGHXn/6TJLfxWnqW+z252PU+0UGeliKXWTEntLamZvOqgyHze7pYbxaLyXg2BGqseNUqctZ7k9p2Qww8HYHOGQv5CwOHtEQTDebun7ohik/VjjtwRCUnXBKhRuYQuqxP+QfwmrZ32zlQag+ejZxiiOOdAB9XZSzWv4eGncFNngjfOxxfaZBGomRweHja1qm3Ug==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6113.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c37d77b-4c69-4258-dee8-08dd665c9e1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2025 20:36:53.1641 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DZsdwMdkiZ82L2HZFkl9iwOjDbLZPwplKCO0Tv7tYL9cB/rzIHzQbrdRh7bioVnwxO2ck7QFzyx+Yb5hEcQtXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4406
X-Proofpoint-ORIG-GUID: CgN-KkXTtBtpQN6TImSN56nQa6hgQ3SN
X-Authority-Analysis: v=2.4 cv=IJYCChvG c=1 sm=1 tr=0 ts=67d9d96a cx=c_pps
 a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=Vs1iUdzkB0EA:10 a=H5OGdu5hBBwA:10 a=qPHU084jO2kA:10 a=k-42gJp3AAAA:8
 a=jIQo8A4GAAAA:8 a=QnR9dJsvxPuuIEaFdW8A:9 a=wPNLvfGTeEIA:10
 a=EyfJrAPGyNLe2X-QvRUA:9 a=q75MKx3O9FRDiVHF:21 a=frz4AuCg-hUA:10
 a=_W_S_7VecoQA:10 a=uCSXFHLys93vLW5PjgO_:22
X-Proofpoint-GUID: CgN-KkXTtBtpQN6TImSN56nQa6hgQ3SN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-18_09,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0
 suspectscore=0 malwarescore=0 bulkscore=0 phishscore=0 mlxlogscore=923
 impostorscore=0 adultscore=0 mlxscore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503180149
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Tom,

> With the way we now prompt for big or little endian support, the "select
> ... if ..." portion of the ARC symbol doesn't work as intended. But now
> that we do have a globally visible prompt for big or little, switch to
> using that fully instead of a custom symbol.
>
> Fixes: cbef295441b4 ("Kconfig: Unify endian support option")
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Alexey Brodkin <alexey.brodkin@synopsys.com>
> Cc: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
> Cc: uboot-snps-arc@synopsys.com

Thanks a lot for that wery much needed fix for ARC!

Acked-by: Alexey Brodkin <abrodkin@synopsys.com>
