Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D28FC54E65
	for <u-boot@archiver.kernel.org>; Wed, 21 May 2025 00:40:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76C1582CD2;
	Wed, 21 May 2025 02:40:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="UbL9V1C7";
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="PsxI6oTm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48BA782D2E; Wed, 21 May 2025 02:40:01 +0200 (CEST)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4011682C2F
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 02:39:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: 1a8255d235dc11f082f7f7ac98dee637-20250521
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:Content-Transfer-Encoding:Content-ID:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=NfV/Dsz8psUBMJi/UtA5bx8wl9MwDhKzps2Ob1a1fLw=; 
 b=UbL9V1C786WI0YAJ2ODlwtDku+rFKVjj7Boz2q7iX6S75D0a3PQGrj9YKN8SHrXm7AT0mDJXyiUtozdztDxM1taAHhtCJ9DXy8E5hMRCzuPIF+7N2crLoAy/xcObOm6z1zP0AOwuUl01WeaATZJguMapSRfUCOvEU9AiPWArDdM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1, REQID:6a69b2fb-d51c-483c-b7b4-b83c7bcf5bb1, IP:0,
 UR
 L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
 elease,TS:0
X-CID-META: VersionHash:0ef645f, CLOUDID:a666f517-88c3-4984-800b-8677a7c73bc4,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111,TC:nil,Conte
 nt:0|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,
 OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 1a8255d235dc11f082f7f7ac98dee637-20250521
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by
 mailgw02.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 749298662; Wed, 21 May 2025 08:39:50 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Wed, 21 May 2025 08:39:42 +0800
Received: from TYPPR03CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Wed, 21 May 2025 08:39:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gTKCVmc1NtbnA2uLgtVXONmJsZhwTKvqs0BHpIy4K1BSsOqdszMD+hq8///kfS23plxGZwGQmSbC3mfwETYLHSe0U+9vHxVkWZk6VwnnAJ4s9FynLp4uIVN1L7+YYDWpvS7ax1jUEXobLj9LE0GKGURQ/438CMvO5WWhzQXOS3wZyuqW7Lf0lxiDOBXO+MQ1kmkXSs0kcUTHgA3JIJRErTRtjjJVx7PTVwf7vIYuRu7OgDCMftM8zLxb3xGWIsBGvT51GZiOpJ3+qBo037kIjB6gDiHAGoLnwbV0eF09kZYNE94geDM+9LkgAkPQa97T65jhbnhHFPQVRdiLjVzfBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=syQjWzrGtpFjIfLRZFJmY6KvR0TmnqWNXCfk11Ve+m4=;
 b=do20hSV5d+SqHXOQDcCjTCo86leiMERo/lpLq72bSYi0V66Bye98ld68h5vV7ySCmiSjimcq75C7hcRhwTRDdJZVVRhcgW36Oev/qXnXmCN4xIhVQoTL8xqFOWWd8q+PLrv0AXTsBc2Fdxm4cAu0NNUemfQuOtp1fqmRUygJyIzBX+z3p7gVUL05ofrhoYW/VlqJHnw4VXL0HOWhfJuAMcHhOQ6bvv9YKFDSQ/YVQpF+/vByqPoPVOEgqYgd2BpTH5+eEDVw8zwZnzBrgJSTIpHZsoXkp+Xna6J1LoiGKPUehXeEmtaC5/QjiBI4zw6DgXrqtvUG7jBvZd0e6eZG3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=syQjWzrGtpFjIfLRZFJmY6KvR0TmnqWNXCfk11Ve+m4=;
 b=PsxI6oTmOswfn7qx8QeH8kPCe/i+EsfRdIcyVEKLy23JBC7x22WcDFmlcQ3VSVDc5V5/shVbQIaJZLhZBb1t919Prg+5QnC7tskDdYX8UQ8gX/qrhpU5kYE9lFt7ytcJb834a0i7WGNMy5TQx+EG9uQJ0aK4QfpgX8u05g5PmqA=
Received: from SI6PR03MB9045.apcprd03.prod.outlook.com (2603:1096:4:23d::10)
 by TYSPR03MB8836.apcprd03.prod.outlook.com (2603:1096:405:95::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Wed, 21 May
 2025 00:39:46 +0000
Received: from SI6PR03MB9045.apcprd03.prod.outlook.com
 ([fe80::53c9:58ef:a15f:6183]) by SI6PR03MB9045.apcprd03.prod.outlook.com
 ([fe80::53c9:58ef:a15f:6183%7]) with mapi id 15.20.8746.030; Wed, 21 May 2025
 00:39:45 +0000
From: =?utf-8?B?V2VpamllIEdhbyAo6auY5oOf5p2wKQ==?= <Weijie.Gao@mediatek.com>
To: "trini@konsulko.com" <trini@konsulko.com>, "ghidoliemanuele@gmail.com"
 <ghidoliemanuele@gmail.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "emanuele.ghidoli@toradex.com" <emanuele.ghidoli@toradex.com>, Ryder Lee
 <Ryder.Lee@mediatek.com>, =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?=
 <Chunfeng.Yun@mediatek.com>
Subject: Re: [PATCH v1] linux/sizes.h: sync from kernel
Thread-Topic: [PATCH v1] linux/sizes.h: sync from kernel
Thread-Index: AQHbyWcE05jzDk4GmU6qY/Ki903OWrPcPuMA
Date: Wed, 21 May 2025 00:39:45 +0000
Message-ID: <07c599d1774a350209022e528e0b37220f6edb22.camel@mediatek.com>
References: <20250520090924.2638187-1-ghidoliemanuele@gmail.com>
In-Reply-To: <20250520090924.2638187-1-ghidoliemanuele@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR03MB9045:EE_|TYSPR03MB8836:EE_
x-ms-office365-filtering-correlation-id: 8a34f7db-181e-448f-b4b0-08dd97fffc18
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?V0pZS2xLNVg3SlNZVGt6cTdkU0xSMElRdUlnWkh3L05KR3c5aHdISkp2SEQr?=
 =?utf-8?B?SGFHWUk5T1gzZE9ySjNaNzE5RExCZXljMUUrL3h3VzJ2VDdsSVJnZ1JQSVJr?=
 =?utf-8?B?Qlp1ME53cSt1QTlwZzREc0E4dk5URGtQeDV5OHRsSFFjUEdoR3RxZmtUSE8w?=
 =?utf-8?B?VVVwdFVTTmRPN3FBNFBlZW9yVzltSG1qNm5LZHJNR0tCUkNSbWcrREJSQ2Zv?=
 =?utf-8?B?WXZnMVBIRWdhcmNCTExwVjNPcEt5djI1UStuN3hrU3JGL0lTRzhXWWVuUDUz?=
 =?utf-8?B?eU1rbDUvS1IxS0gwYWJjSDBKTHlWYkFTQlFacld5UE5haGxnNXlsUVRlY2ZB?=
 =?utf-8?B?QURBYnRMK2ZSWEZzUldLMkovTHBHU1BUUFIvbXZyclA2V1diTmNQdzNGMWhE?=
 =?utf-8?B?QWF4RFh4ZGZWa0RHOEpZZmhsRWRVZytWaW5zQXZ2czZTQ1ZQTFVZSXl6S1JU?=
 =?utf-8?B?cGN1ZU9VYWRPN0xCYVZVNFJTY3crTWJBUVE5bkRsK0VhdVdDbmovM2xrVjJT?=
 =?utf-8?B?Y2Q5cElDNG5NYXp0QjBtU3JvVlc5ZGd4MFVQanB0bjZpSklRRW9yeFVSaXR6?=
 =?utf-8?B?Y1FFQnk0VWpGS0dFQi9Oa0tmS0NiNHBkU0lYOEJoaFl4MlRGTmpHY1dEVHI1?=
 =?utf-8?B?UzZXYjAwRzVHbjZXZmtnZjFKbGJqd0dNTGF5dmVTN1NuTlErVmJJb1ljZ3p3?=
 =?utf-8?B?TjJOZUhob2ZOcWJtWkRVb0EyYzl6WjBHcUZKWjFBWFM4TDd2QnlISDI1ZEcw?=
 =?utf-8?B?R1YvaW90WXVFSGlXaGhKbkVsUmJWYmVRS1kvRFRhMm1KZkhjU21ZL01CbXk3?=
 =?utf-8?B?UTY2ZU5VUEdReGY1Zng3bmRIbWthYWswcnJHNklKTTk2YjcwQzltc0tPSkV1?=
 =?utf-8?B?TnpySnNQT3JkdDNBS1hoUS9BS2N2by9jM05WYW9qbzdwOUNZRUlJWERIMDVR?=
 =?utf-8?B?VUprUjBKR2RGaDlXckpOaXdXR1ZDZGJ1aE5TSHp6K0c4L3RPTUZXNFhPOGFF?=
 =?utf-8?B?VDczSk8yR0hzaHZ6TkVQdDdadG1GVGsvSnpleDNDK2NQY3I0blBNaGhHYXR3?=
 =?utf-8?B?ZDByWlViR01ZUHBwQ1dIKzdjazgvT3kyNHJ5bnpHYXJTTjE1VWtNYUd3cEhq?=
 =?utf-8?B?ZC9tMjN6NExpbGFlcVdNSklaU0VIZEpIRlR2emZ2NE5Xdk80cjUzMEFhUlM3?=
 =?utf-8?B?TmFDOFhzTTh6QU5ZZjRmMTZKVkRPMzBKbjRicHVQRkRZendpOUM3Q1hQVkV0?=
 =?utf-8?B?TGZzZEkrK1MrZnY0ci9JWVhxNk0yMWdnTFlGcjB6Uk9rNUJ5b0ZUS2EvMEVy?=
 =?utf-8?B?SFFkZXdWbGw1TzByR1hYUWZ2MWlSNnR5SFh4UCtadXJodThHNEg4dHd0UE9n?=
 =?utf-8?B?Y25pT3RNNStuSVc3dFBsZnYwYlF6MTRCcW0yazN6akVJaTkyT2JLcjNPcjVk?=
 =?utf-8?B?TFJmWmpLa0dLWXZ4c3pYaEtnK1U4SnJZdjU4R0ljZnZaWWwzbGx2SGludElo?=
 =?utf-8?B?UGIwM0JaNnh3Z0dRQnpYeHJITmd6YjhNUGErMTNINklvSG5Ja25jcTNCa3Uz?=
 =?utf-8?B?VnFjVFFtdDV6RC9yV05ldTVIMjZaZUduU1ZRUTVPajV6UDhPS2JJeUE2UjVQ?=
 =?utf-8?B?dG1lS1EvdGhkQW9pQmg0dXJSS1N5OWJsaUxrbFBpV0EwOXdYbXhjZVpwcExh?=
 =?utf-8?B?WEpjSDNIdmtubWVRY1dRTEJDVEMzdnFuSzloWlZoUG5XeG5oZ1pVdURteitW?=
 =?utf-8?B?anhGbmF6d29xckJNbDJYeGk3WUo3c2h4bEJBWmp1SUJ3bDNjSGd0YjVVallY?=
 =?utf-8?B?aHVyVjFFdTBvVEpXK0dRNUxJbDNZTWNjcy9aQ3RuTzBQY1Z3cE5qM0xkY2Zr?=
 =?utf-8?B?amE0N2czby9BV1h1M25nTkxFbEN2T3BqR1RKVld1ZG41YW9ZRjZuS2UzYmdy?=
 =?utf-8?B?V05yTVZvU1d6YTJsSHNqT0dDUUMwdSs0dG5pZ1haKzNWK3NUQ1FDWDJCWExi?=
 =?utf-8?B?NG13Q1Yzc1lnPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SI6PR03MB9045.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Yi9zL25RamxDSWRBMURnYUdSKy93Tk1US0I0NGRFSG5DdlJzYUJSWldwb1R4?=
 =?utf-8?B?QktnNmg3UkJJd0tFT0UvN013bE41cEQwRFNkZ29qUGliNVlibXN3QzZxMCt5?=
 =?utf-8?B?cTRFQmt3cmo1OFV5eHh4b1phOXZhUFFWQlFxUGpEbm9ZZXJ3c0x6WXEwRGRD?=
 =?utf-8?B?VzFzaDNKSFRNMFhrL2hPTnVvaWhQSUxSUllwYTVhaVRIdmltblJlRnJHVjZ0?=
 =?utf-8?B?TUNyN1VZbUF0WEhJd0JTQVc5d0d5RUd3aEVjTDQzNzl2YjNRNW81and5OWwy?=
 =?utf-8?B?RTNTaEk3aEJNTnB5MzJkek9aOE9vMmI4RklTRDVlVUNvaGg4UnVjV2NQWmdG?=
 =?utf-8?B?enhYQ2ZTTE5la2lLVFdiaUZVNjg5WGF0S21lenhpOUxvdFpMcmtjUE9WQWla?=
 =?utf-8?B?TEhyM1JBUk91N0NLb2RYUXUwT2tHWW82U3lZTGVBUGhWTm9PODlJQzJKMGlF?=
 =?utf-8?B?WnNSQVg0N2xacXlxSko2N1ArdlJ1WmdNTFhYejlwbGh4UERaVi9sOVBBLzZW?=
 =?utf-8?B?Qm9tWVFRblV6OEVOcUlqdnNON1NUYnF3b0ZjeU90U0VqS2RCL0V6djBaTTRU?=
 =?utf-8?B?NzlEZmREeEg1UmdXWWhqYnlzemZuZ3RWVmRxNWZuOFhsczh3dWlBdVJ4OXcw?=
 =?utf-8?B?blVQNno1S3pwemFNOUNQMU1DOHFyOW5zbUZhamNHdk9KSnUrc0p4SG1OQk1l?=
 =?utf-8?B?aVZlekxQelQyUFJqa08wSTNsb0FpK1JvQ1o3amlSZXltSGdTZklsZ0hmRzBk?=
 =?utf-8?B?aXkydnE5M2pqdnlUY3A3bXpJUGZWY1VZUUd6eGM2YXJkdkMvNmpIMCtiNERt?=
 =?utf-8?B?WnQ0TkRFdUo4STFocS9ENGkraFlRaUJPQ0w3UU4rc0ZRMUdPWDRhUTVkMzEw?=
 =?utf-8?B?N3dmQ3pyUGIzMlNyRHlvOTNaVnVzWmEyMk1qSHhQaVcwU3dNSlIydDBZNkF5?=
 =?utf-8?B?eGNvZUk4Yy83YzkrZzdRTm5GK3h6YXZIRjcybVJadWJ0Y2ZzVmdhQW9SSWdk?=
 =?utf-8?B?VTJTWjNRWG1EdSs3a3hTWGFteituL1lCYUxRejNrRWhXNm5NcDBTenhLMjhF?=
 =?utf-8?B?YnVldVdBWnE0N1YzaW4rNWcxenc3QXZPSUN3ZjZicWYrdytsMXpQS1NvN3dx?=
 =?utf-8?B?cVBhUlNnakRWM0c3REx4V2NiRHNKL1BVT1pEdFhYVVNsMnN1ZzFkZlR0QTlW?=
 =?utf-8?B?ME9DaldqOTZOYS8wUFZVdlhJaTNGZ1NIU3NIVmkyTVRpb21pZkwxczJ2dm1M?=
 =?utf-8?B?NzZoU0ZEUk9idTAwUHJrQ1lyK2NvaXJRMktIQ09vSkdwajIyd2lKWjFnZWJw?=
 =?utf-8?B?UFlhU0xBUW9MemhSSVlzU1RYcHdnVVhBMk5XTmZUZkx1dFliSXBabTRuam53?=
 =?utf-8?B?ZmlTcGtNamxocEFmdkd4N3UreXBlSWtPVUVPRG5rRFhOb0wrMUZlRGFySjZI?=
 =?utf-8?B?WGhvdENjbklpRGdKaHFlQlROdUU5QjJIckV3cWpsZGN4Z2FaaTNLZFdzdU05?=
 =?utf-8?B?d09aZGRDVUVPTDVab1ZvZUJxSHl4b2h2VEg3bEJocmorSXVsRmRUalloWm1k?=
 =?utf-8?B?cDNyNC9vT0h2TWRYZFA2UnV3UTM0VHV0QkFSeW01bTBUaUtqRVQyZTIwTHUx?=
 =?utf-8?B?ZjI5UmM4Yk9QMGFQdkVLekN2Q3NHUDgxQjg5REFpMW5VZU5vSTN4T2FnTjlK?=
 =?utf-8?B?TDc1OUhLQWEvc0lUQnprcElNVXhZZjMzV3NkTnVBN2VSa011ZVJndlM0UzRq?=
 =?utf-8?B?K3FCa09BSDBJTC9CTmkvekVjb1JJSlZYejlVZVU2V1hkK2xZNGc5QWlvQ2lj?=
 =?utf-8?B?RkNSenA2NjJ5QW01WFVJbG01RHY0RjFLVmpjUnFvcG9BMHI5QVJzeFpOZUQv?=
 =?utf-8?B?YTVjK1hJUnUyVVd6U3AwcVVVTDVsNldLOWZLNlJHLzdlNFJ4UElZQmhlUEIv?=
 =?utf-8?B?Mmx6YmdFcWQ0YjJaVGNXWXVLbWYwZ3lINDVKby9ZalNVUTRtN2N0Zm5rS3pV?=
 =?utf-8?B?RUdob1dSbS9lWVY4QTQxVzlHRG8rdHJPV3FhczFPQjREa0pYTW1zZnZmd1hF?=
 =?utf-8?B?OHhRRlYyYnJFYUJ3YWIzNjFla00vR0ExU0VTdUpuRHlWQTg0UWIxOGU2L2hn?=
 =?utf-8?B?TElueWtVcVp2b0FKYXl2ZlJZcDFPS05SVmZNMmEzUXdLd1ZnZjZkMUVqdkM5?=
 =?utf-8?B?d2c9PQ==?=
Content-ID: <5046DCCB42BAD646B34B96129289057F@apcprd03.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR03MB9045.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a34f7db-181e-448f-b4b0-08dd97fffc18
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2025 00:39:45.8298 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 837L3T8g3lAZ5P7ZvKkmQiPyDve2Fi+PJ7i/Ps33xrdMt8p62FnAbKnRwO2gChqIASXX9CBiABBwT6wNI58k6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB8836
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
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

T24gVHVlLCAyMDI1LTA1LTIwIGF0IDExOjA5ICswMjAwLCBFbWFudWVsZSBHaGlkb2xpIHdyb3Rl
Og0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBh
dHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBj
b250ZW50Lg0KPiANCj4gDQo+IEZyb206IEVtYW51ZWxlIEdoaWRvbGkgPGVtYW51ZWxlLmdoaWRv
bGlAdG9yYWRleC5jb20+DQo+IA0KPiBUaGUga2VybmVsIGFkZGVkIG5ldyBzaXplIGRlZmluaXRp
b25zIGFuZCBzdWJzdGl0dXRlZCB0aGUNCj4gYm9pbGVycGxhdGUvcmVmZXJlbmNlIHRvIHRoZSBs
aWNlbnNlIHdpdGggYSBTUERYIGlkZW50aWZpZXIuDQo+IA0KPiBEcm9wIGEgbG9jYWwgU1pfOEcg
ZGVmaW5pdGlvbiBpbiBNZWRpYVRlayBNVDc5ODggU29DIGJvYXJkIGZpbGUuDQo+IA0KPiBTaWdu
ZWQtb2ZmLWJ5OiBFbWFudWVsZSBHaGlkb2xpIDxlbWFudWVsZS5naGlkb2xpQHRvcmFkZXguY29t
Pg0KPiAtLS0NCj4gIGFyY2gvYXJtL21hY2gtbWVkaWF0ZWsvbXQ3OTg4L2luaXQuYyB8ICAzICst
LQ0KPiAgaW5jbHVkZS9saW51eC9zaXplcy5oICAgICAgICAgICAgICAgIHwgMjggKysrKysrKysr
KysrKysrKysrKysrKysrDQo+IC0tLS0NCj4gIDIgZmlsZXMgY2hhbmdlZCwgMjUgaW5zZXJ0aW9u
cygrKSwgNiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9tYWNoLW1l
ZGlhdGVrL210Nzk4OC9pbml0LmMgYi9hcmNoL2FybS9tYWNoLQ0KPiBtZWRpYXRlay9tdDc5ODgv
aW5pdC5jDQo+IGluZGV4IDJlZmM4YzZhODhmZS4uOGJkZDM4NDhkMjYxIDEwMDY0NA0KPiAtLS0g
YS9hcmNoL2FybS9tYWNoLW1lZGlhdGVrL210Nzk4OC9pbml0LmMNCj4gKysrIGIvYXJjaC9hcm0v
bWFjaC1tZWRpYXRlay9tdDc5ODgvaW5pdC5jDQo+IEBAIC02LDE0ICs2LDEzIEBADQo+IA0KPiAg
I2luY2x1ZGUgPGZkdGRlYy5oPg0KPiAgI2luY2x1ZGUgPGluaXQuaD4NCj4gKyNpbmNsdWRlIDxs
aW51eC9zaXplcy5oPg0KPiAgI2luY2x1ZGUgPGFzbS9hcm12OC9tbXUuaD4NCj4gICNpbmNsdWRl
IDxhc20vZ2xvYmFsX2RhdGEuaD4NCj4gICNpbmNsdWRlIDxhc20vc3lzdGVtLmg+DQo+IA0KPiAg
REVDTEFSRV9HTE9CQUxfREFUQV9QVFI7DQo+IA0KPiAtI2RlZmluZSBTWl84RyAgICAgICAgICAg
ICAgICAgICAgICAgICAgX0FDKDB4MjAwMDAwMDAwLCBVTEwpDQo+IC0NCj4gIGludCBkcmFtX2lu
aXQodm9pZCkNCj4gIHsNCj4gICAgICAgICBpbnQgcmV0Ow0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVk
ZS9saW51eC9zaXplcy5oIGIvaW5jbHVkZS9saW51eC9zaXplcy5oDQo+IGluZGV4IGZiZGUwYmM3
ZTg4Mi4uNDkwMzk0OTQwNzZmIDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRlL2xpbnV4L3NpemVzLmgN
Cj4gKysrIGIvaW5jbHVkZS9saW51eC9zaXplcy5oDQo+IEBAIC0xLDkgKzEsNiBAQA0KPiArLyog
U1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb25seSAqLw0KPiAgLyoNCj4gICAqIGlu
Y2x1ZGUvbGludXgvc2l6ZXMuaA0KPiAtICoNCj4gLSAqIFRoaXMgcHJvZ3JhbSBpcyBmcmVlIHNv
ZnR3YXJlOyB5b3UgY2FuIHJlZGlzdHJpYnV0ZSBpdCBhbmQvb3INCj4gbW9kaWZ5DQo+IC0gKiBp
dCB1bmRlciB0aGUgdGVybXMgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIHZlcnNp
b24gMiBhcw0KPiAtICogcHVibGlzaGVkIGJ5IHRoZSBGcmVlIFNvZnR3YXJlIEZvdW5kYXRpb24u
DQo+ICAgKi8NCj4gICNpZm5kZWYgX19MSU5VWF9TSVpFU19IX18NCj4gICNkZWZpbmUgX19MSU5V
WF9TSVpFU19IX18NCj4gQEAgLTI2LDE3ICsyMywyNSBAQA0KPiAgI2RlZmluZSBTWl80SyAgICAg
ICAgICAgICAgICAgICAgICAgICAgMHgwMDAwMTAwMA0KPiAgI2RlZmluZSBTWl84SyAgICAgICAg
ICAgICAgICAgICAgICAgICAgMHgwMDAwMjAwMA0KPiAgI2RlZmluZSBTWl8xNksgICAgICAgICAg
ICAgICAgICAgICAgICAgMHgwMDAwNDAwMA0KPiArI2RlZmluZSBTWl8yNEsgICAgICAgICAgICAg
ICAgICAgICAgICAgMHgwMDAwNjAwMA0KPiAgI2RlZmluZSBTWl8zMksgICAgICAgICAgICAgICAg
ICAgICAgICAgMHgwMDAwODAwMA0KPiAgI2RlZmluZSBTWl82NEsgICAgICAgICAgICAgICAgICAg
ICAgICAgMHgwMDAxMDAwMA0KPiAgI2RlZmluZSBTWl8xMjhLICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAweDAwMDIwMDAwDQo+ICsjZGVmaW5lIFNaXzE5MksgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIDB4MDAwMzAwMDANCj4gICNkZWZpbmUgU1pfMjU2SyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgMHgwMDA0MDAwMA0KPiArI2RlZmluZSBTWl8zODRLICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAweDAwMDYwMDAwDQo+ICAjZGVmaW5lIFNaXzUxMksg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDB4MDAwODAwMDANCj4gDQo+ICAjZGVmaW5l
IFNaXzFNICAgICAgICAgICAgICAgICAgICAgICAgICAweDAwMTAwMDAwDQo+ICAjZGVmaW5lIFNa
XzJNICAgICAgICAgICAgICAgICAgICAgICAgICAweDAwMjAwMDAwDQo+ICsjZGVmaW5lIFNaXzNN
ICAgICAgICAgICAgICAgICAgICAgICAgICAweDAwMzAwMDAwDQo+ICAjZGVmaW5lIFNaXzRNICAg
ICAgICAgICAgICAgICAgICAgICAgICAweDAwNDAwMDAwDQo+ICsjZGVmaW5lIFNaXzZNICAgICAg
ICAgICAgICAgICAgICAgICAgICAweDAwNjAwMDAwDQo+ICAjZGVmaW5lIFNaXzhNICAgICAgICAg
ICAgICAgICAgICAgICAgICAweDAwODAwMDAwDQo+ICsjZGVmaW5lIFNaXzEyTSAgICAgICAgICAg
ICAgICAgICAgICAgICAweDAwYzAwMDAwDQo+ICAjZGVmaW5lIFNaXzE2TSAgICAgICAgICAgICAg
ICAgICAgICAgICAweDAxMDAwMDAwDQo+ICsjZGVmaW5lIFNaXzE4TSAgICAgICAgICAgICAgICAg
ICAgICAgICAweDAxMjAwMDAwDQo+ICsjZGVmaW5lIFNaXzI0TSAgICAgICAgICAgICAgICAgICAg
ICAgICAweDAxODAwMDAwDQo+ICAjZGVmaW5lIFNaXzMyTSAgICAgICAgICAgICAgICAgICAgICAg
ICAweDAyMDAwMDAwDQo+ICAjZGVmaW5lIFNaXzY0TSAgICAgICAgICAgICAgICAgICAgICAgICAw
eDA0MDAwMDAwDQo+ICAjZGVmaW5lIFNaXzEyOE0gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIDB4MDgwMDAwMDANCj4gQEAgLTQ3LDUgKzUyLDIwIEBADQo+ICAjZGVmaW5lIFNaXzJHICAg
ICAgICAgICAgICAgICAgICAgICAgICAweDgwMDAwMDAwDQo+IA0KPiAgI2RlZmluZSBTWl80RyAg
ICAgICAgICAgICAgICAgICAgICAgICAgX0FDKDB4MTAwMDAwMDAwLCBVTEwpDQo+ICsjZGVmaW5l
IFNaXzhHICAgICAgICAgICAgICAgICAgICAgICAgICBfQUMoMHgyMDAwMDAwMDAsIFVMTCkNCj4g
KyNkZWZpbmUgU1pfMTZHICAgICAgICAgICAgICAgICAgICAgICAgIF9BQygweDQwMDAwMDAwMCwg
VUxMKQ0KPiArI2RlZmluZSBTWl8zMkcgICAgICAgICAgICAgICAgICAgICAgICAgX0FDKDB4ODAw
MDAwMDAwLCBVTEwpDQo+ICsjZGVmaW5lIFNaXzY0RyAgICAgICAgICAgICAgICAgICAgICAgICBf
QUMoMHgxMDAwMDAwMDAwLCBVTEwpDQo+ICsjZGVmaW5lIFNaXzEyOEcgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIF9BQygweDIwMDAwMDAwMDAsDQo+IFVMTCkNCj4gKyNkZWZpbmUgU1pf
MjU2RyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgX0FDKDB4NDAwMDAwMDAwMCwNCj4g
VUxMKQ0KPiArI2RlZmluZSBTWl81MTJHICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBf
QUMoMHg4MDAwMDAwMDAwLA0KPiBVTEwpDQo+ICsNCj4gKyNkZWZpbmUgU1pfMVQgICAgICAgICAg
ICAgICAgICAgICAgICAgIF9BQygweDEwMDAwMDAwMDAwLCBVTEwpDQo+ICsjZGVmaW5lIFNaXzJU
ICAgICAgICAgICAgICAgICAgICAgICAgICBfQUMoMHgyMDAwMDAwMDAwMCwgVUxMKQ0KPiArI2Rl
ZmluZSBTWl80VCAgICAgICAgICAgICAgICAgICAgICAgICAgX0FDKDB4NDAwMDAwMDAwMDAsIFVM
TCkNCj4gKyNkZWZpbmUgU1pfOFQgICAgICAgICAgICAgICAgICAgICAgICAgIF9BQygweDgwMDAw
MDAwMDAwLCBVTEwpDQo+ICsjZGVmaW5lIFNaXzE2VCAgICAgICAgICAgICAgICAgICAgICAgICBf
QUMoMHgxMDAwMDAwMDAwMDAsIFVMTCkNCj4gKyNkZWZpbmUgU1pfMzJUICAgICAgICAgICAgICAg
ICAgICAgICAgIF9BQygweDIwMDAwMDAwMDAwMCwgVUxMKQ0KPiArI2RlZmluZSBTWl82NFQgICAg
ICAgICAgICAgICAgICAgICAgICAgX0FDKDB4NDAwMDAwMDAwMDAwLCBVTEwpDQo+IA0KPiAgI2Vu
ZGlmIC8qIF9fTElOVVhfU0laRVNfSF9fICovDQo+IC0tDQo+IDIuNDMuMA0KPiANCg0KUmV2aWV3
ZWQtYnk6IFdlaWppZSBHYW8gPHdlaWppZS5nYW9AbWVkaWF0ZWsuY29tPg0KDQpUaGFua3MNCg==
