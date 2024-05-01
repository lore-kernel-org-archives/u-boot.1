Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36311C4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 09:38:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1D0988AB8;
	Wed,  1 May 2024 11:38:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="cbrm25Vz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86E3488AFD; Wed,  1 May 2024 11:38:42 +0200 (CEST)
Received: from APC01-PSA-obe.outbound.protection.outlook.com
 (mail-psaapc01on2071a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:feae::71a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7FF288AB6
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 11:38:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=aspeedtech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chiawei_wang@aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SySXqqlTfiXgDt+ia285otRleOt7ccShWL3cCgQAoWenwzd5ddczRh+AGFC4SoE1bgkT2mKJyG8fHJRIONhgXAVC/KyB7kSQ734OKBzIHoB3PoBTTbPBgVozOeNamdfPUEp235HLtHm4+tDyVsGpsbzmB0frZP5Kzn/n0uvgSP9VUXr15gcuavrnvHJ4SLAIo1acBfpw+Bt1uBG0p6zT8D8DAkm9QD1r5RZo8EgfzKE3N5RH+AGh+BxbaeyDTeTl7w1CTOAKmw/WggN1qHRJPKw+67gQdIJgMCWnMr8xAe60j/4yeadkhxhW7Co+tTGSWVJYPqMQV8sAue9OTICAPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6fNSnLpwvsUABdPj9SR4NlezEJvAFqj2ar31re4Uo+s=;
 b=YDgN2gUVjSQiX5VJ/3tm6H88lWuBIYouiPpHA5zTL8O3vVjmbOH2u7GcBemE+4OdGZ/4Dt0SfMC5HmCeTHmqyVHFEYk4AyUf4FOBo1IyoRfZP9BAcm/VThvHIPi0uaQMj8USnDXOEgleN0rBRPgEgOOa74zLixLWpQFe/Sp/piA8ayR1QK4Fd0vS08C3r3cdLtBI2AIX5NrwFoFIvLfgoy/UAxgKnHir3OTB97TXf8CAHRIBNbs50mYNWEmtWahuk2lBsYpHt6AmOngG/eqHUw27SsDYSUsLXurxaW1SWmeovSazjRUU9Ze6BVer14vZhmx81J0lWu9TZfEql5p1Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6fNSnLpwvsUABdPj9SR4NlezEJvAFqj2ar31re4Uo+s=;
 b=cbrm25VzD6EKfsTgOyzPxxdihvkgxEfqrA3AqM1RsUW3IX3y9jbMjyLhA8cBu8NTe9oJ7aq15CCeXBqitkhpPKMea9oUn1BZU9iH2eZZus2PUEMuCvSye5C3NpxYARq2elxi4Z2RQugg5UwlSk7SPOADbblHEIeqUMpZ6kdZMPHlCbH6LkY3nvw4rQVVVhCCig0H57ocaL/8dtRnIY0bv03RoU7W7s0gqX7UOKXwWh9VCPuhpgoI/h1y6AMyok1lNhFHIn0YsBiPD76BKUD5sAe6aBDSgRHQ8Nsq+GlBimK4wZJCLlZ2m7hccYF7DOx9jbABCZO9rp4Hv4aDFFGLHQ==
Received: from KL1PR06MB6652.apcprd06.prod.outlook.com (2603:1096:820:f9::5)
 by JH0PR06MB7233.apcprd06.prod.outlook.com (2603:1096:990:94::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36; Wed, 1 May
 2024 09:38:32 +0000
Received: from KL1PR06MB6652.apcprd06.prod.outlook.com
 ([fe80::3c13:dd16:cffe:9b68]) by KL1PR06MB6652.apcprd06.prod.outlook.com
 ([fe80::3c13:dd16:cffe:9b68%4]) with mapi id 15.20.7519.035; Wed, 1 May 2024
 09:38:31 +0000
From: ChiaWei Wang <chiawei_wang@aspeedtech.com>
To: Tom Rini <trini@konsulko.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: Ryan Chen <ryan_chen@aspeedtech.com>, BMC-SW <BMC-SW@aspeedtech.com>, Joel
 Stanley <joel@jms.id.au>
Subject: RE: [PATCH 30/33] arm: aspeed: Remove <common.h> and add needed
 includes
Thread-Topic: [PATCH 30/33] arm: aspeed: Remove <common.h> and add needed
 includes
Thread-Index: AQHamwNuOYG9E7jHeUC5jBqhdFK4KLGCIFlA
Date: Wed, 1 May 2024 09:38:31 +0000
Message-ID: <KL1PR06MB6652175E97D7676D334E616891192@KL1PR06MB6652.apcprd06.prod.outlook.com>
References: <20240430133559.1836389-1-trini@konsulko.com>
 <20240430133559.1836389-30-trini@konsulko.com>
In-Reply-To: <20240430133559.1836389-30-trini@konsulko.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR06MB6652:EE_|JH0PR06MB7233:EE_
x-ms-office365-filtering-correlation-id: e1152129-194b-4147-6184-08dc69c276e1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?WGMySFRWcURGbEhkWjdyWkJ2L0lJSkNlcXhVc0swdGNxSm1CRjVOVHdFZEZL?=
 =?utf-8?B?ZFQ2ckFsOWErclRRT3IzY0JLMUx4ajFpSHJpVDJUZWxUNm1BZ1pNRUhLWUJz?=
 =?utf-8?B?c2x0U05SVW0reGF1TkxoT05sTTdiVm1nS2ZuRUw5YzhJemdoUUdmVTA1ZEtP?=
 =?utf-8?B?Qnk3cHFIMHl0MnFweVhvbmFSbmlaMjcyNjdPQS9oQnQ5cG4ySGNzOXl6U1Zs?=
 =?utf-8?B?YllhVzd2YmtLckdyeW5jUzJKVHFPQWMxeTFUckNrLy9uZTZuWngyT3RLYU9R?=
 =?utf-8?B?d0F4cFNlMUhJL21mNnR0bDl3NVFWZTh6T2RrR3hrRThpVHg0bkVYYTVhSHpV?=
 =?utf-8?B?bXBITGE1ank1emdBM2lxNjA4b21jRG1jRnVaQ1JTcVdBcElOV2lJcjc4OVB6?=
 =?utf-8?B?dzNQZHNaYkl3S3ZzekZqdEdyT3lJOVVnVkN0L0wva0pkcHpseEdOYmFJbjFP?=
 =?utf-8?B?SHdVbkRNeTgrN1ZxUjdNMGhZUWpScmloQjZ4Y3QxNDdEeFVYTi9NNjVKMEZF?=
 =?utf-8?B?c2ZBdEI1WHYvMm1GUythM2JETEt3cDl0RHFYTTc2VmNRYVNxWlc4VnB6SG84?=
 =?utf-8?B?bUdVTHhLQzk2VGNwV0lkRldRTGRSUWw2aFlCZDB4VXZGTEYxSU5NSmdnUk13?=
 =?utf-8?B?WkhSUDhtaWNvejNHS3YwSzNXbUI3MEQ0eE5JKzJYaElFNWRTMFpma01Ucmpu?=
 =?utf-8?B?MTZSdUZmbUdPYWxWdUdvZUR5MlVBS2ljL0hIOVNCYUtkcnRUc3FSVFBCUm1L?=
 =?utf-8?B?VTdhSXllWnZOenpJRlJ2cndMOEdFK1dyU0RYLzRMcUhiQUNwZDBiQUZMcHZM?=
 =?utf-8?B?RGlMOTMzZHVqbnUyRFhBRFFLQnB4YzliWGtBSTB5R0FKQnRQOEpKVVpiYWk1?=
 =?utf-8?B?eXBaMHpOS3BuaFpxV2xDdDFDNjV1NHR5cjIwMzlremN3ZHRYbmRQcFpYcVhX?=
 =?utf-8?B?RjFzK2FCQVJvRnpJek1scDAzTjNCM080d09JYnZoREVRdVlvRFNjbi8rS2ND?=
 =?utf-8?B?R2xGcDlDOUM1QWJoY3dsK3I1elM4aUtNUXdLdmZ5RlJpbWhZVEN2YlZjcURR?=
 =?utf-8?B?Q1BQOGc5aHAvRVdHZGdVRVYyWllzMERVRlhKTmxNRHRoUmJJb1lTSzc5bkV1?=
 =?utf-8?B?L3UzTXpQRy9GWFVLZEEvVEZPK1BSY0tQNmZVSXNrSVFSZC8vR0doVFZsNndM?=
 =?utf-8?B?b0dlMVg5c045MWNpdXBWbWFIbmhkRldFZHpZeDNlVmFqdzFtSjhoY3R1Zy92?=
 =?utf-8?B?NjZqQ29IL0R3MHBob1Z6Wk1oQUdXMzVrQks3N1R1Z1NWYXBpZFlVclBmcE9K?=
 =?utf-8?B?RVpDdlRONHExN2xvRHU5bERsRmtvQnNoeCtlUmRGcWZnOVJURmVyQnNQRllq?=
 =?utf-8?B?OFU1TVBTeUx1UFp5d1hBRXdBSGt3UWRkYkFTczh5ay9DK0Zmb2V4UGRzRzk2?=
 =?utf-8?B?MG80czJVSzQ1NmdoU09XZEY1MmFmT3JRdGh5ajBIdTB3S0lhYlVneC9JUWhM?=
 =?utf-8?B?bXY5N25MZHppdTBzZnFWUmZzSXFUNGw5M2NhY0ovOHBnTXdoWXhEN1FIVzBq?=
 =?utf-8?B?c1J5SDd5MXREM2EyRFNqZkRxNmY2T2dvbUdod3BXeDBYYi8wcjhFbk5sNTVS?=
 =?utf-8?B?UGxtVXhzS2wyRlg2QnBtMHR3Ykg0ODJLdmYrd2hHK0U5M1RNcWdDRTVPanIx?=
 =?utf-8?B?Nm1NdVRjVENXWHJ2YlNEeXE2aFd4OWV2a2FyZ2Yyak9UK2o3ODNySldUUHBN?=
 =?utf-8?B?Uld3cm93UG4zUmxUQ3RxNmhkeVhNVnUwbXBLQmY3VWI2Yi9RSVI5YU5sOUZX?=
 =?utf-8?B?aHorSUZpL1pvWXpLSlk4QT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:KL1PR06MB6652.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230031)(1800799015)(376005)(366007)(38070700009); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WWxyOXVlMHhrZW5XOWJGNkJrQUV2aUQvQTlUNERLcFV1MVFrSGNnamZlOXRw?=
 =?utf-8?B?eDg3V1RSQmd5R0pFZVl2NFV4QnBnSEN0aFR0c1duY2EvTkNQQXpCQ3RTZXpv?=
 =?utf-8?B?MHN6b0toNVdaWGo2UFJOSGY1ZlUza3hsMWtmZ2dyWlJsdFRBU2dNMHFLMXdm?=
 =?utf-8?B?ejhHbkdjdlY1U0IrK25xb1ZYMDZMVnZrUEZVcHpYSTRpTHA2bzFEQW11OEVq?=
 =?utf-8?B?a1gyYjJndlBwVmtuZEk4Qi8ra1NreHVTaTZyM1R6VlZySGVrekpvbW1uOHpx?=
 =?utf-8?B?ck9lRWtQUjU4ejl5NXBPZ0UyTmI2ejBqRGdQM21weUs1Rk9LdDIzTWJDTkl6?=
 =?utf-8?B?S3lJdURXZ25RcTJiVmZSdTAwcXJJcTdqNjJSSi81MHlDNEx1T0J3SFZ3SHA1?=
 =?utf-8?B?ZmRrODc5Q3Q4MStwNjJPLzBJS1hjSjAvc1JuOHZpcXhsTFlYSCtEakdUOXQ3?=
 =?utf-8?B?dlAxcVZrbWUwaHlCY0w0VkwxYWExcWNJQkt5MkhubE5wQ1MzWDdpRVlFRytP?=
 =?utf-8?B?NmZaOE50aHhQeWFBNkcvT1U4UkFiMUo0R2FJbzEzUjh0Z05oSTd4YWJycFdT?=
 =?utf-8?B?aTZBbm5Eb1lzbG9PVk5DcnV0WVlnL3podjY2L3hqeTR4MHZHZkRhMFVGcnRa?=
 =?utf-8?B?d2ZTVUQ4a1dPY09kaFBuRjRlS2RBMldkdmlvQThJelJxYURtYlBUaC9WVzg4?=
 =?utf-8?B?MVpaVWZhcUFiQldZWUhRWENPbmhINXh0Z0dVMFFUQWh1dk9lNXk2NGthSnhj?=
 =?utf-8?B?SlEyOFU5UW1oRk5BMkZQdzlsSGtQdFR2VkZySVNtbWFMM3Away8vTXd5UlVv?=
 =?utf-8?B?Tnh2THhKMDlvcTBHd2pWYWdkYlNmVnFxS1kyQktLeE51N3IrcnFMNzY2VUd2?=
 =?utf-8?B?NHFHMTBVNXRyWU5WNk1kV3MrT1NBS01kNUFvZEtjeFY4TmEvaXRQTzdzRjhD?=
 =?utf-8?B?Z2duRTEwNE5LZGdOZ0VXaHJaSTk5NU5VdnoxYkE1T3JWQVNnNHV4YWJsWEU5?=
 =?utf-8?B?d2FXMGJWSjk2REZHMWRYT2c2RTJQRHMyMzdEVFUrSlZsbEdtTTFBMFJ1Wldq?=
 =?utf-8?B?ZlU3MnZYK1hVa0NPTWlBM2tZNWVyZkNxWnY2WUxxMEMrZVZlZFBlM2dqbHJl?=
 =?utf-8?B?VWlCQjFwck5YWUQ5akhNYTl3L0c0OWF0RjFpQURQTUVkN1laOHRZSUh0MXU3?=
 =?utf-8?B?VVdnaTVxVWp0MUlVUFRJUFJFN05lMUc2SEJRUnNlSlMrWXFRSlhqd1ZqcjlU?=
 =?utf-8?B?blRuZytYTUovUWxvbWtSYi9Hb3d6RzFNOUhPTzR5WlNJV1IwVHYwUk9sWFpG?=
 =?utf-8?B?WlU3UmNVdWhsWTlvYmUrQ0RHenBuYkFsbmNwZ0piLzJ4RTk1cUNkZXp4UzJJ?=
 =?utf-8?B?RzVBTFNFZ2tCK1ZFWlZMVlBsTlBhU2dCTkduRW1TQVN5Sm1tTTRQTTRzcU1Z?=
 =?utf-8?B?VTl6MlIwekhsYk1aTkE5a3JNQkoxdEJEeXNRNGp2WGcybXNUVEVNUnE5a0lm?=
 =?utf-8?B?dDhSMGJkbThIcFZvUW03aytmemlkVEZjcTlvNjRIRkhBL3JKZ2orZGJ0a3J0?=
 =?utf-8?B?N3BySmxPVSsrTGloZ3NmR3d5aW1wVEVzT0NHbllQUEQwVG1QeXZmWXJRUEhp?=
 =?utf-8?B?Zko1SllMTDRjOU9RNEtDTUIySXBSOVQ0UEpuMkFLOXVYazMxUnp0TGFsdWFU?=
 =?utf-8?B?RDR1eC92NGx1d2g5QTdDeTVIMVJRMThCcFdBQjlUa2pTUVI4TXFDaEJCdVpL?=
 =?utf-8?B?T3Y3MDkvSUxSYzZvRnFhS2NFMmpuQWQrL1d0Z0JiTmF5aDJsdFBjSUwvMCt6?=
 =?utf-8?B?K2FmcXFqNERPcVdJV1F2VzJ6VllOWEdzUmo1bXI4NWpjY09HUjlySmtyMnZo?=
 =?utf-8?B?OWhRL01iTDdqb21YUkROTnFuL253Z3czY2dseEVFTjNmaS9RRTl3K0kwUTNP?=
 =?utf-8?B?L3BoZmNtL3VQeDNpZ0Vtcm94VmJMM2VISDYxUWtXYW5Ld014SlUzMHdQblpz?=
 =?utf-8?B?VDhKNHYzY2VJeGl5ZEtOYzRsNDUrS3hwcDBCblZBRzhlNmN2R2VORm9MbytH?=
 =?utf-8?B?SS9qOGtrYStUMU1ZbjBzYVhnVFdPNmZ2clBxYWZsNWFwaVhreTB4eVp3WW1v?=
 =?utf-8?B?dkdzWk5XVTRuMHg3YlZ4SHlGV2FiZEszRUl4ZGtYdW16ZFVmbFNUMnY3anpw?=
 =?utf-8?B?dUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB6652.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1152129-194b-4147-6184-08dc69c276e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2024 09:38:31.8436 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y/ib2IBdZ8EsBS6U1TXYLEyrzm81AugIvkU08jo65sxhY7xBdTMIMbycZhiZgQ1eKPFe8OWbIK9xgpXTp8z9AJ+WikrpnBpB/cTn2gcZzKQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB7233
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

PiBGcm9tOiBUb20gUmluaSA8dHJpbmlAa29uc3Vsa28uY29tPg0KPiBTZW50OiBUdWVzZGF5LCBB
cHJpbCAzMCwgMjAyNCA5OjM2IFBNDQo+IA0KPiBSZW1vdmUgPGNvbW1vbi5oPiBmcm9tIGFsbCBt
YWNoLWFzcGVlZCBmaWxlcyBhbmQgd2hlbiBuZWVkZWQgYWRkDQo+IG1pc3NpbmcgaW5jbHVkZSBm
aWxlcyBkaXJlY3RseS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFRvbSBSaW5pIDx0cmluaUBrb25z
dWxrby5jb20+DQoNClJldmlld2VkLWJ5OiBDaGlhLVdlaSBXYW5nIDxjaGlhd2VpX3dhbmdAYXNw
ZWVkdGVjaC5jb20+DQoNClRoYW5rcywNCkNoaWF3ZWkNCg==
