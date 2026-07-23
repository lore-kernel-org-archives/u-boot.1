Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0172DC531CC
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 21:04:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AAFAC60AF2;
	Thu, 23 Jul 2026 21:04:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8WuMh6e5Uaox; Thu, 23 Jul 2026 21:04:58 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AE8E960AA6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784840698;
	bh=L+0G90YQl3pHdzrqLeBsFk6fG7lIqgURqtwYn6XRnj4=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lrFS8kfcUYxisji5MSEk7EVXpeAQxQlNn+br2UPzEfNFfu6DcTgSpdFTO7VguDRYi
	 MnnYQQ/hsfrHZdO5Xqd0GV1J6WAE9IkiJLVGKIZSwTHLi+yBQGZx7zc2n2Mp1QlRcD
	 Oswm18EatQUaaObd1+eB4Yutwbi4LOUTDZVtjLHQ78yGAHrpsfo/QkO4MYsCB4svhz
	 48eeI/qtmqtyCY8+2Ub+cQodlb7lXS30/hSi/Phftl94RJP6i54Ru/jkr3R262GFCz
	 thxAkmF9but/xxOkzaH+qSfddJiIPVv8A9YPImOZLnkhRXUNnVV8baF3Y6xObU80S5
	 HnyCJufV57/dw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id AE8E960AA6;
	Thu, 23 Jul 2026 21:04:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id BF0D2788
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 20:43:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B0309403F3
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 20:43:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 59Hml6WmTR8p for <u-boot@lists.u-boot-project.org>;
 Thu, 23 Jul 2026 20:43:38 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=thinh.nguyen@synopsys.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 948C840057
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 948C840057
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 948C840057
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 20:43:36 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id C791980287; Thu, 23 Jul 2026 22:43:34 +0200 (CEST)
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com
 [148.163.158.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9B24800AE
 for <u-boot@lists.denx.de>; Thu, 23 Jul 2026 22:43:31 +0200 (CEST)
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
 by mx0a-00230701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66NIoOG7892129; Thu, 23 Jul 2026 13:43:24 -0700
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com
 [149.117.73.133])
 by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 4fkdt0xdng-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 23 Jul 2026 13:43:23 -0700 (PDT)
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com
 [10.192.0.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits)
 client-signature RSA-PSS (2048 bits))
 (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
 by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id DFB6140134;
 Thu, 23 Jul 2026 20:43:22 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com
 [10.4.161.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits)
 client-signature RSA-PSS (2048 bits))
 (Client CN "o365relay-in.synopsys.com",
 Issuer "Sectigo Public Server Authentication CA OV R36" (not verified))
 by mailhost.synopsys.com (Postfix) with ESMTPS id 6A14CA00D2;
 Thu, 23 Jul 2026 20:43:22 +0000 (UTC)
Received: from BN1PR07CU003.outbound.protection.outlook.com
 (mail-bn1pr07cu00300.outbound.protection.outlook.com [40.93.12.0])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest
 SHA256 client-signature RSA-PSS (2048 bits) client-digest SHA256)
 (Client CN "mail.protection.outlook.com",
 Issuer "DigiCert SHA2 Secure Server CA" (verified OK))
 by o365relay-in.synopsys.com (Postfix) with ESMTPS id 8D9D7401A7;
 Thu, 23 Jul 2026 20:43:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i8Fn3bFhmV3rdiKXm0D5swl+zeZuKkFe3SqqLpeDLje54IuLvW//2tBiBPd+eb4HTBK3VwoArz4M2NppgHaqHYRUuRCPSGAt2tW9wXSw6JMlfg3qKeP8J4pnwxv4DaPSBBjgB5M2Nmv3FOlTx8/5U4OesbQSf6JTpOhjIJgBArQKzNP9RDMt2S/16noIh/wiRcasYTDyEsuVSh/efXZ7M2rJhZTe5yhErbmPf/qle0KHzyHoyJ9kAoEBMUhkFMTQEg4bfR0IeSaSVldAhaQcgaNho8yFfXPNW3zSi1HneisM89pdlM5aMXavi4fvFNAOtVJ+5l81Bx//1u8HpDYr7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L+0G90YQl3pHdzrqLeBsFk6fG7lIqgURqtwYn6XRnj4=;
 b=S5vFq7vhDP1+KAlsiOmcpfdFOnSvvNreM4U8jGlyi6xTtiLA5MSNhqHqSX8ujH0/d+OX8d8woQK7xO/+EdYIpkXR36pTAUiSnJcJABHMF/NmL22xWCcpvd58eqPRX0chhW9tQzTNTZNnaCFLjvhzytfT4wiwhewr59t1bLvj8EIJJwBkfaNT2ti4gSZpedLZ7HeQqqeTWXh+uJop1JllyJULZt6uR2yFVyVbJ/eH0f+hZHbfeB86iyi1p/RxfzpmrgSB/BA/DJGYwpAAu3UCyA6bJuMAhk7M8VwKHCrDRt63sk3P8IYogGROJ3Y1QRNzxlGJrERpxx2OfD67wLgfGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
Received: from SJ0PR12MB7473.namprd12.prod.outlook.com (2603:10b6:a03:48d::8)
 by CH8PR12MB999205.namprd12.prod.outlook.com (2603:10b6:610:35a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Thu, 23 Jul
 2026 20:43:15 +0000
Received: from SJ0PR12MB7473.namprd12.prod.outlook.com
 ([fe80::fd38:a665:ba4:95d7]) by SJ0PR12MB7473.namprd12.prod.outlook.com
 ([fe80::fd38:a665:ba4:95d7%4]) with mapi id 15.21.0245.010; Thu, 23 Jul 2026
 20:43:15 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Mattijs Korpershoek <mkorpershoek@kernel.org>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
 Dan Tran <Dan.Tran1@synopsys.com>, Marek Vasut <marex@denx.de>,
 Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>,
 Tejas Narendra Joglekar <Tejas.Joglekar@synopsys.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH v2 2/2] usb: gadget: dfu: add SuperSpeed descriptor support
Thread-Topic: [PATCH v2 2/2] usb: gadget: dfu: add SuperSpeed descriptor
 support
Thread-Index: AQHdD89/nAOpDtv5TESo302SnCVSt7Z7ICQAgACH/4A=
Date: Thu, 23 Jul 2026 20:43:15 +0000
Message-ID: <amJ8tfCL1mPkDrH5@vbox>
References: <cover.1783620779.git.Thinh.Nguyen@synopsys.com>
 <a6c2533e5d59c5bcb1199fc0b939e6a7a5ee2382.1783620779.git.Thinh.Nguyen@synopsys.com>
 <87ecgt992r.fsf@kernel.org>
In-Reply-To: <87ecgt992r.fsf@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB7473:EE_|CH8PR12MB999205:EE_
x-ms-office365-filtering-correlation-id: 8d97e56b-b7ec-4579-18ee-08dee8fb0542
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|56012099006|11063799006|4143699003|6133799003|18002099003|22082099003|10067099003|38070700021;
x-microsoft-antispam-message-info: NcpQwPitLR1iBz/3YGnV3YVsxkheYc7cm2RlFxnvKknjKaZrQQ18bySu1xWklNRybSYY2HAv88i3ifEFwOPQBRhN73EQCzVaWQM/9GA56YOmYj2xl/OXn+0ovlARvs1JSnJ44KePytRmnj+EQ8KDlf7IQM9VKXOL9DKG7fHD5V0h1XuSgIw2nffENLLavJmKl0ezhk8+pKYjaJZvrCDZ5YFH7b8ETtChn4Q+4pdATwSiwY48ZtLo0CPU2/xgZkHKeFoWOldyF35eT9/7xQtKcH1cpeSkbtTSjgY7IuurTvKRab3couoNJbJeAU255c0HJjpWXAkoZWkc7u3rVOL37f3me9hXoAq+H6jaljFTN+0I4vsgGXIJdIg5ANeInOfQDatMO9UeeRDRNw6sv0DuWKxbXm7ic7uQHDh7oKV1cWICgfpFaC1Wtf5cV9shPBMDleACdok6oF/OLv6Kqe/UWG01z+r3/iAPpvNoMRSd5kQlzj63ldjHowVE4TVQx9WbCyGM1/pkuX1WS0N0q8DpWuYsMx3OckLeCYwBdGCSuX24rvjkUe/cJy+QSyGmCb0djXurE3+3RuH0KRbohmw2S5ccULGIp++ak24Rm/SaqlxYsQJANy5NM+wod1iarrYwkewFOlxCUqH7LgFNgRAgJaqDmy9WFUNUa0lC1joD5t2otUD4ogYHPYFy7K3+wiadL/a0YschpHI+7G8OTjkFDE+uIdFeo4HkNvSK2Q2vN4U=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB7473.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(56012099006)(11063799006)(4143699003)(6133799003)(18002099003)(22082099003)(10067099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZThBQnllL0xqek0vdlJIUmVtVVBSUXdWeUdZR05OWkJBcFRRSk1LMTBidGFv?=
 =?utf-8?B?Zk1ORHV6ODk3TURKNy8rT2FsK1liRVYzc3pZWFZreFYxUjNZeExtUXR5aUps?=
 =?utf-8?B?cnZralpOZnJ6VGk2a3RtalhEZG8yTFlwY3ZJSENDQjYyY3hUVWNURWRIcG5J?=
 =?utf-8?B?VW83emRnekFtVzlqVG0yb0hzdUIvcUkrODJJQlUzZEk1WkZ4OXdZcC9Uc21T?=
 =?utf-8?B?Z1gveXJ3NVo2UFJzWjhoV2VXdmFDK2V0UUpmb2NEQTNFcmFlZzJPaUgrNHJy?=
 =?utf-8?B?OGZJMGRXcjF1RmpTMmlxK2RNdmVMdHhSeFVFd3pSc3ZBU3BZcXJHdjhKVlhz?=
 =?utf-8?B?b1c0QnRibW84eUVGVkwyNkJGVnVCWEk3Ump2Z1I3b1JGdkZ4TWFUajZtcGpy?=
 =?utf-8?B?U0RUYnV1bjIwZmtBeHJVcFN2dnlNMjdDejBRK0p6ZXhGWkhjTk1TcmpYVHp4?=
 =?utf-8?B?YmlDNmtxV3NKdi83TUFnaC9hTTQ4QjlhVkExbUpJd1JFUG54dHJKMHBqalg3?=
 =?utf-8?B?ZTFQUEdoampxem1uTGIxZldzMTRGSWEwb0tVYTZzeFdvYVo3U3UrWU1LTXlm?=
 =?utf-8?B?UDNpWU5XdWluc1p3OTM3b3YwN2txYTlHTlhST284VWVZQ2JTemxvbkYvTjBH?=
 =?utf-8?B?dXdXNkRLZFZNS2NMa3Yrc2ZQR3Y0azMrS2dTNE1EL1BVUDZZMlEyNkJkVE1r?=
 =?utf-8?B?K01Ja0RLb2R6bDlNaXZvaXd2WWNKenFJdkhGanQ4cDllVE9TYytxS1d2UEo3?=
 =?utf-8?B?SGdlOThTNzM2ODMydUhYR0lBQm1RMnpLS0xCQkdXbTVJUG9pMC92U0FMR2R3?=
 =?utf-8?B?N1RLNVU2cWcxSEVZb3J3ZmdsY0NwdlpXMDFOb1dEbHlhVkhZWlJNRVZweGdt?=
 =?utf-8?B?VFRSNFVHeTBQc2NtZWo2NUxQVXRnYnBDUVlMalFGcjg4UE9EelRNL1NiSkl6?=
 =?utf-8?B?K3h5UTN0Z2RBcVRIQlRyc0k2emtaUjFUN243dlhUYWVFbGhGY3hSN0tMOFBF?=
 =?utf-8?B?NHlXNWxZVCt0TEI5REJVLzB5d1hlOG9UNC9iRmIzdzNvRWZKa2hERFlodHV6?=
 =?utf-8?B?SWdjSWJKN2RHSWhOU1NUUTVobHBSNmpYWTZkTTlpTU9uZlJFNVo5UXBaT3U2?=
 =?utf-8?B?ejF0bithVGsxSExwYnJWNXdZa2MzOFdhSmthT3R0Mjc2YkVCOVhrYmhURkM3?=
 =?utf-8?B?NWxGNGw1UnRGZUJpaXNaQytSL2RvOUViR0s3OEpNNndDRXVOUW45a0JqS2JB?=
 =?utf-8?B?NkllalZycUs3MzNJcHBjVHo3RzFaNURhVlRVYzZPbjgyc1BTUFg2MitkYys4?=
 =?utf-8?B?WFE3S3NvZVhSc05GZjdiaVIzVEI5MklHREVVQjl4dzF5M1dIS3J3NXJGMFRo?=
 =?utf-8?B?aU85OWZyVzczcFZ4bitJZTlPVGxhbXVhL2hQNmZIVmpYMHlCUXJXRTJ1UFNQ?=
 =?utf-8?B?MnN6THo4bDdLWlVSR25TUEErMG5KSUxEUnNjU243b0pVTnNWdng0amtNaGgr?=
 =?utf-8?B?ajJFQkQ3NzFSVVFpMzBpODFpLzN2eDdZeUlyaDBkZ2o4aDQ2eCtuSWwvSHZC?=
 =?utf-8?B?K1ZrV1dlZUl2U2tMeFhKcDJwaXdaVHY5RlY2b1hxbWpaZ2lhbDNUNU5PZHdU?=
 =?utf-8?B?VXFMQVhldDB3aG14bGN2NnYzSjZlandKL0xvcmhiVlhSTWFyQzlZUk1KaHdi?=
 =?utf-8?B?ZThndktadFdMcGtEM0RRdGlscGRRQ3p5S3FSV1lXRGlrajdKZ1dWNDNwb001?=
 =?utf-8?B?SklVSm4wQUM5cWcwWlJqRFRoUnExMVlCV3Q3U01ickdhNEkxdjI4R0FESUdv?=
 =?utf-8?B?bkFOeXRJSVM1RkJNbVV5OXlhY1R6eXNFelVyUHhvZXkrdkJqaFJUZWFta29x?=
 =?utf-8?B?UGJ2b3BFRFk2YWNZM0V3Uld1ZVJ3YnBReDdPT0lMU0NWOWVMVWVTNktzQmFz?=
 =?utf-8?B?MFF6NVVkbnBzbEZ5cDNOdmxUQ3BGVnVsZzl4aUJOck43VTZuQ3ZBMVJZU2Fq?=
 =?utf-8?B?UHBMM1JUd3hxc1RKbzZ1NDdWVXJxajNFelRtelUxZlYyU2NZTUJBU29ybnFJ?=
 =?utf-8?B?dnlVMGtHWm5mRmpxMm1rQkt5VmF3TXE0dDh5aGNPSWxleVEwRmowaUpRenhI?=
 =?utf-8?B?c3VkV0d2RHNuMHh4YjRWbEVRaWs3b1lLY1I2aG0xK0hSNlRjZU4wMDkwMUhy?=
 =?utf-8?B?enZ3Sy9OQ0JGQkRTaGpNMkZpTjlySXpsd1VSL0VGdyszVk1DT3l2aW4zZ1BL?=
 =?utf-8?B?Wk9EbjV3TmdaemhBMDJpVUVUN3o5TjVWZS9ia0ZWQU44aytuUUdQN2pXZHJU?=
 =?utf-8?B?M01WQlprdVR3UURLWjFOcmZreDBJNDJCVWhORGtYWWg1QzVWVmdzZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D7CDFCB90272CA48A1480315D7E7421C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: JG1DKQCyAcFwDdS0XRprCfn+n3DZdih3o0XOgLOC8IaFfsJP1CDMOyq+7lRgm8xcino4XlZVp44BmPUzsxvt5C82BlzDJATzulL9hXzG3iXvV8ygDdBjKF2ovOj05mftL+GIOU9m/ZBd67hS+qfiMiUAmTzzFeH2AC8L2foirg67yPO9Zf2mcd/3zkyBy46XKAa4zcerhYQmSVSGtguVaxHVXFaKUMiHBZcdZzpTFXPH709MMtprNbpQSN+VR5bzDRfUjH3rbvPjYogHKnnyiX4lNF4A6bl4ecuR8TZkDpFbbM1HxNFWHMUGhIu539S/JXGQE+S6dm5X/ghhHMnVTg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 10nfHb9t9LpEd+/6agPTpkMUSbbFu7onKqruIpbtqIgpqMniDb8qPiBBwC0pCxEHWaJYMi+77ohVPAI9/uTpr15GMmMic0mw4kix613eXYa24kBYJdnd3MHaop4B8gRzIeQ80WsPBvYuY/3+urw0/+/+bcUUUUp2DfVxW0Gjjcs1esOs5pnclJAH36tkuo3JTWI3I00ojXIdCetlcUk5d0BxM6/jyD90HR7M+vYje+OtJwtvuTVmWw9y4TveOmO8QwXqknBGVDgRReVAmZGItPvqBMGhh5tbw6pqkcv/orHr4a0NxBgEc2UaGAu0OvZzsVxBVlN0NTT8rL3mf5TbXlSoFWxMZQAyOSom7EgwjUWwZYbLS/65FKgodP3ouNE1iXSCJPM6PmUwcqmh4Tj+LRjOzYdRvBZ1Qid7VTTq6+gorD0cfWHRQR1ItLSzPhEJXzrrkj41E80AlJqSBmL4TkPkH/TY/SCG4d+UA1yyUlbiLSGcQbMT9QlwGjzhaZRxbJOnGnWtjwMU1Rfe49vTqJP9xsMwO7bFC2eNcWe6hh2TMuROk5tbBSHqeiYd2sOoJUNKtU3FQvdRr9ogYyfPgeBcjPb8oeAL23dbqbqz2k+hENNuHUImM9f0da3jVPXRzkmhZ1ihGvW+pngfM6ab0A==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB7473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d97e56b-b7ec-4579-18ee-08dee8fb0542
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2026 20:43:15.5731 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WVLqwlDaeev0Rn8e9qsBt8y2MM1tyodvWEFfSWtKMJi1Cz25ACxqvTkLtcAI8quGu/YOCN+/B6U830mdogf3Ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB999205
X-Proofpoint-ORIG-GUID: 8NCkWJ9VGsOksF0YiRV16vuejjQTgQXL
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDIwMSBTYWx0ZWRfX1ASTDJ6XrT3t
 OWVhwZS5SMlf3gI6VajiFSfLPE0gKavx+DE+v25L4Pbucr+JVTTx3kM6vaYDlNH9AjzbQg18siG
 UyWr8LEIrBdPkMQieMHKmdZulF4FZSc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDIwMSBTYWx0ZWRfX6Qh+FpH83KpX
 ME+MBM2EkI6mpRIv6yIQ8NT3Txjg+HMLDTL5tRj7zRPS/bXK5Cd5SxukIsEL+2i8/MWWQQebTeX
 Gl4psoLw0Rg5ClFowF6FmaGWymtw0+H8RoVnepyvHJDT7e5kVM9SkF+sh8M6rutmUnOB1ZH7+1A
 rxWWYXXvmRj8Hx/ZqZ5yoiGrKkecqBXjUeB1MWNK5IHq+fYEurcbKEkTObnnwH7A/KiDHR3ss2E
 YEVEazEoJ4PdA7clwe+PHk2aciHTfVnRuR/L/J9TeC+fZktpcCNqjg9BaFUPN5yMvGSrxdENpU5
 5+TX7TdodDY1i/js3gSkc+OKZqOsgYtkH1g1VcjD+cVOGQ/Xzun9nBb+5MAOwzWfKMxSl15j2P2
 JBZQNjBGxEg9IEG3Bpt7nG/O3UI+GTVGXdNT8aDaTjHs9bra7sqGUjRXGRUUflOOm/ajl3fpPU4
 NF+akKADuzr0nVSwfIQ==
X-Authority-Analysis: v=2.4 cv=Q8DiJY2a c=1 sm=1 tr=0 ts=6a627ceb cx=c_pps
 a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=qPHU084jO2kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=tU_645BZ7FZt8VqRJtHG:22 a=-4-sGo8i1FcW4KD7_GeR:22
 a=jIQo8A4GAAAA:8 a=u0EYavrxwc53m77yp10A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 8NCkWJ9VGsOksF0YiRV16vuejjQTgQXL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_06,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 clxscore=1015 spamscore=0 adultscore=0
 suspectscore=0 impostorscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 phishscore=0 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2606150000 definitions=main-2607230201
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Thu, 23 Jul 2026 21:04:56 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.com; h=
 cc:content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 pfptdkimsnps; bh=L+0G90YQl3pHdzrqLeBsFk6fG7lIqgURqtwYn6XRnj4=; b=
 hymoVEGEB1s9cUqxCsTjX0xaWQLy+/fVHGPOhxPpZk6+IAHvF/c2UjFWU5V8u548
 x71utyi9QTTRmsOOpDTI6Bh0M52THrZGPN03QUQpjORnpp6yFZSRLxRPxKtJnC1D
 Itl4i7JUXjyQjywc9NTv919JaPfCe/KXXoNELBmss74vV7gULeKMOGqkeul0FsZu
 ukxfwrcudOAFSmR7VLYH6ctsYtO0cRHyUlPfVvW20BDu+e45mCKIztPt6e/jBHCp
 Op21o6nnSsmXVE8FvSRlEt/oFZurU010FOj/ZYoNgSdVzfoI0iAv7zTLASqgMepH
 MW1ZBfTColt2cJJxG85i4A==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=synopsys.com; s=mail; 
 t=1784839403; bh=L+0G90YQl3pHdzrqLeBsFk6fG7lIqgURqtwYn6XRnj4=;
 h=From:To:CC:Subject:Date:References:In-Reply-To:From;
 b=U1dWCA7mzbqusV/+90BkkG5S2Ujl00kfaMy9l+WyBVONhemuS6M5gr1pDJMOMZJki
 LdGORUtg+WRoR9SKk8Lx+ODztFO7mMKIjuYq9LpDu31uFhtmb7gx4LbP4VLSoNcTZC
 AuFozDk6tDiDTlOn5hE0oBPnQMPMmFpO8hq5JjzKAG4l2oBMRZSXNsT9lSsNgYm23p
 6rMVozveB/C6Kqu3FDfjpSETyx3D32FWNy06baJjLI5QP98KxqdpSUqpy9dk5H6LSg
 6WsvDFFqJS19unTwc9TMlggDDxeoSaoThlKsvRjDBB5gJDgDhOFWPRM6sYU+Rhuw6V
 2wd+6grE++9wg==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L+0G90YQl3pHdzrqLeBsFk6fG7lIqgURqtwYn6XRnj4=;
 b=ZU4mRZVXgr2xm4dBa/zmoGT4oO1SaK4Wf5QgP6oL6wFdUxWPkDnpSqMcGY/aVIAEn25YZfU9sNJedWpLQq0NSv6nYfl2OOdecgQRPiZvNJ1+j7qiDI6Nm32M5NyqxOeUiApvsrbBoKZEzO6brV8H/U3fyVYIMg1BTeSVylF/R7Q=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=synopsys.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=synopsys.com
 header.i=@synopsys.com header.a=rsa-sha256 header.s=pfptdkimsnps
 header.b=hymoVEGE; 
 dkim=pass (2048-bit key, unprotected) header.d=synopsys.com
 header.i=@synopsys.com header.a=rsa-sha256 header.s=mail header.b=U1dWCA7m; 
 dkim=fail reason="signature verification failed" (1024-bit key,
 unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256
 header.s=selector1 header.b=ZU4mRZVX
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=synopsys.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=Thinh.Nguyen@synopsys.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="hymoVEGE";
 dkim=pass (2048-bit key;
 unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="U1dWCA7m";
 dkim=fail reason="signature verification failed" (1024-bit key;
 unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="ZU4mRZVX";
 dkim-atps=neutral
X-Mailman-Original-Authentication-Results: o365relay-in.synopsys.com;
 dmarc=pass (p=reject dis=none)
 header.from=synopsys.com
X-Mailman-Original-Authentication-Results: o365relay-in.synopsys.com;
 spf=pass smtp.mailfrom=synopsys.com
X-Mailman-Original-Authentication-Results: o365relay-in.synopsys.com;
 dkim=pass (1024-bit key;
 unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256
 header.s=selector1 header.b=ZU4mRZVX; 
 dkim-atps=neutral
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

T24gVGh1LCBKdWwgMjMsIDIwMjYsIE1hdHRpanMgS29ycGVyc2hvZWsgd3JvdGU6DQo+IEhpIFRo
aW5oLA0KPiANCj4gVGhhbmsgeW91IGZvciB0aGUgcGF0Y2guDQo+IA0KPiBPbiBUaHUsIEp1bCAw
OSwgMjAyNiBhdCAxODoxOSwgVGhpbmggTmd1eWVuIDxUaGluaC5OZ3V5ZW5Ac3lub3BzeXMuY29t
PiB3cm90ZToNCj4gDQo+ID4gRnJvbTogRGFuIFRyYW4gPHRyYW5kYW5Ac3lub3BzeXMuY29tPg0K
PiA+DQo+ID4gUG9wdWxhdGUgc3NfZGVzY3JpcHRvcnMgdG8gc3VwcG9ydCBTdXBlclNwZWVkIGNv
bm5lY3Rpb25zLiBERlUgaXMNCj4gPiBjb250cm9sLW9ubHkgc28gbm8gc2VwYXJhdGUgU1MgZGVz
Y3JpcHRvciBzZXQgaXMgbmVlZGVkOyByZXVzZSB0aGUNCj4gPiBzYW1lIGRlc2NyaXB0b3JzIGFj
cm9zcyBhbGwgc3BlZWRzLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogRGFuIFRyYW4gPHRyYW5k
YW5Ac3lub3BzeXMuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFRoaW5oIE5ndXllbiA8VGhpbmgu
Tmd1eWVuQHN5bm9wc3lzLmNvbT4NCj4gPiAtLS0NCj4gPiAgQ2hhbmdlcyBpbiB2MjoNCj4gPiAg
LSBSZW1vdmVkIGludGVybmFsIFJldmlld2VkLWJ5IHRhZ3MNCj4gPg0KPiA+ICBkcml2ZXJzL3Vz
Yi9nYWRnZXQvZl9kZnUuYyB8IDYgKysrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2Vy
dGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9nYWRnZXQvZl9kZnUu
YyBiL2RyaXZlcnMvdXNiL2dhZGdldC9mX2RmdS5jDQo+ID4gaW5kZXggY2E4YjM2ZTA3N2JjLi42
OGQyZWM3ZWJiZTggMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy91c2IvZ2FkZ2V0L2ZfZGZ1LmMN
Cj4gPiArKysgYi9kcml2ZXJzL3VzYi9nYWRnZXQvZl9kZnUuYw0KPiA+IEBAIC0yMjcsNiArMjI3
LDcgQEAgc3RhdGljIGlubGluZSB2b2lkIHRvX2RmdV9tb2RlKHN0cnVjdCBmX2RmdSAqZl9kZnUp
DQo+ID4gIAlmX2RmdS0+dXNiX2Z1bmN0aW9uLnN0cmluZ3MgPSBkZnVfc3RyaW5nczsNCj4gPiAg
CWZfZGZ1LT51c2JfZnVuY3Rpb24uaHNfZGVzY3JpcHRvcnMgPSBmX2RmdS0+ZnVuY3Rpb247DQo+
ID4gIAlmX2RmdS0+dXNiX2Z1bmN0aW9uLmRlc2NyaXB0b3JzID0gZl9kZnUtPmZ1bmN0aW9uOw0K
PiA+ICsJZl9kZnUtPnVzYl9mdW5jdGlvbi5zc19kZXNjcmlwdG9ycyA9IGZfZGZ1LT5mdW5jdGlv
bjsNCj4gPiAgCWZfZGZ1LT5kZnVfc3RhdGUgPSBERlVfU1RBVEVfZGZ1SURMRTsNCj4gPiAgfQ0K
PiA+ICANCj4gPiBAQCAtMjM1LDYgKzIzNiw3IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCB0b19ydW50
aW1lX21vZGUoc3RydWN0IGZfZGZ1ICpmX2RmdSkNCj4gPiAgCWZfZGZ1LT51c2JfZnVuY3Rpb24u
c3RyaW5ncyA9IE5VTEw7DQo+ID4gIAlmX2RmdS0+dXNiX2Z1bmN0aW9uLmhzX2Rlc2NyaXB0b3Jz
ID0gZGZ1X3J1bnRpbWVfZGVzY3M7DQo+ID4gIAlmX2RmdS0+dXNiX2Z1bmN0aW9uLmRlc2NyaXB0
b3JzID0gZGZ1X3J1bnRpbWVfZGVzY3M7DQo+ID4gKwlmX2RmdS0+dXNiX2Z1bmN0aW9uLnNzX2Rl
c2NyaXB0b3JzID0gZGZ1X3J1bnRpbWVfZGVzY3M7DQo+ID4gIH0NCj4gPiAgDQo+ID4gIHN0YXRp
YyBpbnQgaGFuZGxlX3VwbG9hZChzdHJ1Y3QgdXNiX3JlcXVlc3QgKnJlcSwgdTE2IGxlbikNCj4g
PiBAQCAtNzUyLDYgKzc1NCw5IEBAIHN0YXRpYyBpbnQgZGZ1X2JpbmQoc3RydWN0IHVzYl9jb25m
aWd1cmF0aW9uICpjLCBzdHJ1Y3QgdXNiX2Z1bmN0aW9uICpmKQ0KPiA+ICAJaWYgKHMpDQo+ID4g
IAkJZ19kbmxfc2V0X3NlcmlhbG51bWJlcigoY2hhciAqKXMpOw0KPiA+ICANCj4gPiArCWlmIChn
YWRnZXRfaXNfc3VwZXJzcGVlZChjZGV2LT5nYWRnZXQpKQ0KPiA+ICsJCWZfZGZ1LT51c2JfZnVu
Y3Rpb24uc3NfZGVzY3JpcHRvcnMgPSBmX2RmdS0+ZnVuY3Rpb247DQo+ID4gKw0KPiANCj4gQ2Fu
IHlvdSBleHBsYWluIHdoeSB0aGlzIGNvbmRpdGlvbmFsIGlzIG5lZWRlZD8gSSBkb24ndCBzZWUg
c29tZXRoaW5nDQo+IHNpbWlsYXIgZm9yIGhpZ2ggc3BlZWQgc28gdGhpcyBpcyBjb25mdXNpbmcg
bWUuDQoNCllvdSdyZSByaWdodC4gSXQncyBub3QgbmVlZGVkLiBXZSBjYW4gcmVtb3ZlIGl0Lg0K
DQpUaGFua3MsDQpUaGluaA==
