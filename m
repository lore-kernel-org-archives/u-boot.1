Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD4B606A32C
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 14:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=x0kT7XAK;
	dkim=pass (2048-bit key, unprotected) header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=qrP1mldH
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8B34C810C3;
	Fri,  6 Nov 2026 14:59:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 36UV8AlZt8cG; Fri,  6 Nov 2026 14:59:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 28975811DF
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793977146;
	b=kLfoYHkYCZuuuc0b1tkEomsjjZFM8/fJ8I0UMVyHRaX72czHio9F0GD67YeerckcJy2R
	 F1qGJn9M6uNW0rZNKuNwhefIyod3PwrlBYQFRvqyZpScyn5JSuonh+DTK7u2WBPay+reh
	 xDn8k4ydba8TV6xPSCMrvqSdeaX+Uv+cRGz7oV3To4oTBQec5Ijdn5BSHYCOfkydzG4yd
	 FwC8phcE+75LxrghoL6orXFG9+8oM/1CIuVqLFLjHs2DaDj2+22h1IfmKz6VeymdmnKjv
	 cGHlUfrk7jtfxKqBFAWda0Q2GAjMf1sS7cya6Wip0s21gRDqZ531ba/lWY1otv3cbFw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793977146;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Comment:Received:Received:
	 Received:DKIM-Signature:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-ClientProxiedBy:
	 X-Microsoft-Original-Message-ID:MIME-Version:
	 X-MS-Exchange-MessageSentRepresentingType:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Virus-Scanned:
	 X-Virus-Status:X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=S/ERHCx2i0OeLGQr7Qo54HxEsMrYL6I+7zW4peP2/pc=;
	b=UIOEJG+ril4TkmryZqnk6WM6M+e/wv4he+K0HJ5btmeVwdwtPOXEFriodBH5EbjtMEsx
	 Bw/4l5ymvGFa6AM4a1yD4FhUwObAxRSszYLAYbHSeBxZ0jzzKZKs1pnzvkbxsJ1XUL1es
	 phFsQrKlSYG55GwX83irlxuruPSP4FXj+D+xTFgnXnDCKsliMlOTRHcw91PThd012DhIT
	 sO4bUpLQsAExMIUHWIfGERYmdIug6YIKpfXI9flQZzeOu22TpaPvtRYlUEjy34MTv4/m8
	 LILmYVwpkD7RyquJrDHhVVuqGE71xrXVKVKhnlXqt92KxSKo1SKItrh7aTmHdSyDZPg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=hotmail.com;
	spf=fail smtp.mailfrom=hotmail.com;
	dkim=pass header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=qrP1mldH;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793977146;
	bh=S/ERHCx2i0OeLGQr7Qo54HxEsMrYL6I+7zW4peP2/pc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=x0kT7XAKjCEbQ5d4PDrt3oI/q7Su05n2K83yzmMV3uOyiywfNO7qpIfTjDatmykqu
	 3FuyGLDRM8cNRAs0kFDe/IIp3zJfGLCJ8eT4CO6pwtSQ8VDhhH+GopwfA+x5yK6/G1
	 AP1qbLXGNfsNgPeTO3eMRtnT11s2P5GApHRHafE78y4HKVnZNIOa0e37ecbldAAbpf
	 YUfOzBplqQPfbOR0RRYQ9N8ye6EjdcS26y0pcD0PPIUVsxOW38ptFIYEsmpbUDaXnA
	 0SleLbg5m3ZoL77QA1b7MThyeYirSx6D9PeuvSxdjv1/bHuch8vHGoyL7V9vxgpD9Y
	 QglXtQtFzo/dA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 28975811DF;
	Fri,  6 Nov 2026 14:59:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4482731F
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 14:24:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 29F4681246
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 14:24:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id o3jCNHgN6cFe for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 14:24:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1FBCD81244
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=85.214.62.61
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=macromorgan@hotmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp1.osuosl.org; spf=fail smtp.mailfrom=hotmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256
 header.s=selector1 header.b=qrP1mldH
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1FBCD81244
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 14:24:33 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35AB08482A; Fri,  6 Nov 2026 15:24:31 +0100 (CET)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazolkn190100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d000::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85A1884820
 for <u-boot@lists.denx.de>; Fri,  6 Nov 2026 15:24:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=hotmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macromorgan@hotmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S/ERHCx2i0OeLGQr7Qo54HxEsMrYL6I+7zW4peP2/pc=;
 b=qrP1mldHaxXrrFcI5skos5B7pH7+ZtlRoUqM4FHvJ1EsRLElwkco9t8WMZB+LKW1rph7EL8DiRcLA+7iPigkNUsao7u4vL6fbscfVQR3pwU01cJFjqb/XrEpf9Zem1n3Gid/lzpcExOkW5cRNoCFbg7xk0+FRxmkspDqtpGojHddltY/ispoDjg+tdivQHp0v7qPd377J6m4U1kOAuUW7kt86y8o1joCh5bemEYtn2BNqCFiIjrFrkR+nQBdgSI+w4HkFl5d5bk/mvtyr2ZB+mFr7fhEFeEfo+RBdPKMh7LpiDLTcf8DYfo3m3FHHncOREAxxtmSg7R97KMIi3ZBxw==
Received: from PH0PR19MB997338.namprd19.prod.outlook.com
 (2603:10b6:510:3b1::18) by MN0PR19MB6405.namprd19.prod.outlook.com
 (2603:10b6:208:3c2::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Fri, 6 Nov
 2026 14:24:19 +0000
Received: from PH0PR19MB997338.namprd19.prod.outlook.com
 ([fe80::fd22:ee23:3e25:3172]) by PH0PR19MB997338.namprd19.prod.outlook.com
 ([fe80::fd22:ee23:3e25:3172%4]) with mapi id 15.21.0592.010; Fri, 6 Nov 2026
 14:24:18 +0000
Date: Fri, 6 Nov 2026 08:24:15 -0600
From: Chris Morgan <macromorgan@hotmail.com>
To: Joseph Chen <chenjh@rock-chips.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>,
 Chris Morgan <macroalpha82@gmail.com>, u-boot@lists.denx.de,
 clamor95@gmail.com, trini@konsulko.com, peng.fan@nxp.com,
 jh80.chung@samsung.com, zhangqing@rock-chips.com, kever.yang@rock-chips.com
Subject: Re: [PATCH] power: pmic: rk8xx: Don't set RK817_POWER_EN_SAVE bits
Message-ID: <PH0PR19MB997338A34AEEDDAF76FF8D1B95A5762@PH0PR19MB997338.namprd19.prod.outlook.com>
References: <20261105151057.477529-1-macroalpha82@gmail.com>
 <cb2be9fa-19b9-4d02-9696-bb89c1e713fe@cherry.de>
 <PH0PR19MB99733827DB66CA431B1BD7DA94A5772@PH0PR19MB997338.namprd19.prod.outlook.com>
 <1748270f-1eb2-4741-b75e-cf1e4d36dcd2@rock-chips.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1748270f-1eb2-4741-b75e-cf1e4d36dcd2@rock-chips.com>
X-ClientProxiedBy: SN7PR04CA0074.namprd04.prod.outlook.com
 (2603:10b6:806:121::19) To PH0PR19MB997338.namprd19.prod.outlook.com
 (2603:10b6:510:3b1::18)
X-Microsoft-Original-Message-ID: <au3jDyAFaeweI1pk@wintermute.localhost.fail>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR19MB997338:EE_|MN0PR19MB6405:EE_
X-MS-Office365-Filtering-Correlation-Id: 4416d83f-c503-4a6f-7ccf-08df3c11a4bb
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|6090799003|23021999003|19110799012|37011999003|5072599009|51005399006|15080799012|24021099003|8060799015|25031999004|4140399003|55001999006|12121999013|25010399006|56899033|3412199025|440099028|12091999003|11031999003|10035399007|40105399003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NEVuTUFyaEFFeWZ4VnFtaEo3bjdPcldjMDZtOU5OR3pUVUZVNnAzTzd3QkFr?=
 =?utf-8?B?RHd4elVySlhTSDhlaWowNjk0ZTdTZ2p6RHVTNEJRZFVKSnRLMG45aFZpZ0Ju?=
 =?utf-8?B?VUt1Y1FDYUZGalFIVFBKUnJObGxETDdsSS8zWWJKSVhLNTlFb2VhMG04cThr?=
 =?utf-8?B?RjQ0a09sT21sSS9MVkh4Sis3L01CdDhxY3dHLytvblFYQWlWb3NaQWZKMURN?=
 =?utf-8?B?VE5LaWdzUUpDT2d2eW5ac3hSUUNMTklFbVVDWFRPMFhmZkRNWTdGZmJTcUxn?=
 =?utf-8?B?MkhaaVBSN29YaXo1OWVpSWRIenRUU3pQRjMybVhQcGRjUzhSMC9GckVCMFRM?=
 =?utf-8?B?MDAzaXVkOGlxbzBORTIyOG94TG1JRjVzUXNUWThrTEg0SWRqSHRzUnF3SlV3?=
 =?utf-8?B?U1R1TVZkMlFFOVExVTBOY0Eva0lMdyt5U2JqRGZtemJRSkE1NFpEekZScTRh?=
 =?utf-8?B?blVNU084cERqMWNtSXM2RUhRcktvOGxMbUFHWEFISnRPZVJxNk45OHdrZGJ5?=
 =?utf-8?B?Q01DNUJlbEwxVklZb0xPVWpUdi96Ymh0aXRLRUgwelRPZm5VYWJrTTdiMnNT?=
 =?utf-8?B?K3MrUGVrR1JKVzVSdzhxenBRNjdzbVl2YVJKMVJsUEFRbys3b25JNlplLzFO?=
 =?utf-8?B?V0VvSzRmc1hmczVacTJxRGtJaVg1WlAzMlIwcER1ZjdZaG9OcjBvc0JDWjBh?=
 =?utf-8?B?bGt4dGg0NFBzdlVacWtNV0VNNW5xU2hnSldzTStLdVN2M3U1TW00RXlSUzIr?=
 =?utf-8?B?VjNqdHVQVkVuSjY3K1YwRHFqSE1zTktUM0NpenZPeG5jZ3J5Z1dWYndvREJZ?=
 =?utf-8?B?ZnVBbHRxWVRaL0ptUXFyYjBDVzNKdmdrVTM0a1pGL0VTOFFwUkZ3bmJpb0FK?=
 =?utf-8?B?QjIwbTJWQy9xWE51a0NGOFI0b3FxYWFMM2JxWHUvUS8zYS9HckIvUHZjTHZL?=
 =?utf-8?B?aUtmVVlCTGhUMUlSWGVXY25HSE51bjdaazROS0Y4NDBZNjUzWi9QZEJ2OGVm?=
 =?utf-8?B?WTVESWI1K1p6UVIvamVzU0VSNXlNVjY4WlZONnpRY1Q5bmhwaFd0M3g4RGdJ?=
 =?utf-8?B?Y0hjODVNMG9kbXphWm9wN3huSlZJRFNQQ1NoODZmOUJTL1I2K3lrTnhTb1lG?=
 =?utf-8?B?cDBnZFRpS3JtbEdlN3c2cnpDNHg0a1FMK0c3RlllM2dra3NiWVYzbFBtZ0RB?=
 =?utf-8?B?VkJHaHFPd0xiSzFnMDRUc1hmWnVYUDNuNVc4T1VHSXJKdE05RCtZOWFPWmQ4?=
 =?utf-8?B?U2pUcjRBa2thMUhvWmU5REtoS0Uycml4bEJWMmREblp1eWdqWGNNYVdsWm55?=
 =?utf-8?B?WnRjNHQ2UWlMKzdzQUZZVm1rdjA5elk4MnNQaVJwSDhiRFY1WFlpZlRESU9v?=
 =?utf-8?B?eVF0dSs3SU44TnBZUnRTSE05RjVxZmVsRC9TYkxVWUViTWVuVi93ZXRmRUt6?=
 =?utf-8?B?MVdtdnBlUkEyei93WFBubThwM1VZVzhhSEhwV2FlQXdsWGpIenRJTVYrQldl?=
 =?utf-8?B?WmtjOHg0Vi93anVvV1dXRzF0aFRleWo4bGsvY0cxZGNLcUtiQVlFY3QyTk50?=
 =?utf-8?B?VngzQT09?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aU9LWVlycGIrU0l4MDBwYk1wRmdnQlVoMWlEdXhIcVhWWmcrRmpQV2hWWnU2?=
 =?utf-8?B?dUFtSzhVT2ZRK0I1dVpGSkRtdHZwcTk2SnF5Rlk1RWxtZW5hSjdyb2hSdWht?=
 =?utf-8?B?dmlFNXBLSGtGM1NHMmtuNTVxWENrdk1pYmRXWlBpYTVXNU96c3o2TlFMbXRD?=
 =?utf-8?B?TGNzeWxzMSs3NCtULytLbUpNU25Ja0Y0cTJ2UnZ4ekNTVjBNMGovOVozRFda?=
 =?utf-8?B?WFRqam9SbUFuSGs0MHFYQXNjTjR2ZklOYVltZ0pJc24zYkU3cFpId3JkWm1z?=
 =?utf-8?B?MnFRMlByT3JtQ1RYYnUyWjhoa3N2bVI0bVUwTFMyN0FLSXRrMmtmbnBsL01V?=
 =?utf-8?B?bGZPVmV4SCtCckpTZjY5a1ZUZ2RIdWptT2RVWFR6akgxQkN3M0ZpSVo5eDc0?=
 =?utf-8?B?NHhOMVdvRjkwcFNLN0UvbDhmSXk3ZnpRS3lRakZNNHlBNkhrd2xHZ3NsU3VS?=
 =?utf-8?B?Q0ZnSktyUG5tbUJPcTZaTDhRcHFRWFBSVjRPSk45RmpzUGdkNE9iQ0hwbHhO?=
 =?utf-8?B?YUd1ejNOZGNUcjdlQ2VDYVNLT21pT0p4VHhsU3U1eURodFhRc1dtVktpbXp4?=
 =?utf-8?B?ZElseEEwUnUzRW0zRk9CcWlVV2hpbUl6WEVMVkcxcFcrYXpmL0hXVUdwM044?=
 =?utf-8?B?UzFRZ3V5VlY1QTcrU005SUhGaU1rSkJtbENxK2t0WDFoMElmU3UyMktoNGRD?=
 =?utf-8?B?VUFuQjcxbFpJdU42bFFWNHM4L0QxUjZYMzZCanF6YThTTEFTay84aEJFeWxN?=
 =?utf-8?B?SHVoSDBnZGthQWJXZUhnSi9wUTJaWmc1UXY5Vk9OdjFvMHJDZGEwdVNOR2FB?=
 =?utf-8?B?MFczcWNFK1VXUDBNcUZVMlZ0SjBKVU5UdzdiY3RXQkNNWXkwS21RdmdzUUpZ?=
 =?utf-8?B?eDZUZWZpa1BuY3lNcDFsOWovMC9WMHdjUXRxTCt2UmNLbDVSTnNDWEthNGRV?=
 =?utf-8?B?RklVYjlDR0I0dDFvdkJTYXhTRTlNWVJ5YjlxSHNoVzk0QUU0QnV3NDFuaEhu?=
 =?utf-8?B?dVB4Z0hUN3hVQzR5VFUreURwTHVCMVZ5b2ZFRkdLNGZKWktQVmhycXRXVEt2?=
 =?utf-8?B?ZjhlSk50TWFRS04wMjRVUWNnNlpmbmEyK2NqMkgyaXNqei9QekhuWHFDRk1M?=
 =?utf-8?B?NXBPemsvdEgzTlVXeVJxVG1PYnVPcWZ6OVQ2bHh4NXQ5bUgvN0Y2OTlRM2oy?=
 =?utf-8?B?eGYxZjhic3ZVdDdLbTRxR3FQNlV2MUltOXIyRzVOOTg5QW9sQlZVYVlhbDVH?=
 =?utf-8?B?REpaNXdYUit4OE8wdDVVZVZLUlpSM0hqTm43QlREcEpkU0FuRlhIOWlqNWdG?=
 =?utf-8?B?MmxObzJVVFpQQllqc1RLUG15V3R4MWl0NmQ2Rk5say85Z1RFR2ZZcWdETC9P?=
 =?utf-8?B?QkU3eXpmWGE5QUs1dnZRWUoxcXJEWnZua0tBVnBpSk9EWmVZWVN3cnp4OHEz?=
 =?utf-8?B?QW5NMStPZllJZFRocDhlU2NndG1xelJxMUtLOFVpUkhxSWlPWUk1Z3FVL2Vi?=
 =?utf-8?B?aXA0UWRhejNmZTZhajJOMHV3OTFQM0hXeEMvRklubnFONW5UR0pFK2drR1Ri?=
 =?utf-8?B?STNrY1lkbGtIeHZnZlFwSnZZZjgyNGhlNzF5WXYzcWhEeVJLSXBvMWsxeWRr?=
 =?utf-8?B?T1FIcXpYNVdHbk1udUl2RTlKNVl2N2Z2UnpuVXRCU1dTeCs0eE9GZHErYVBo?=
 =?utf-8?B?ZS9WckI2RGJNSVV0dko0cUp1TWdwdHIyQ1E1ZDRJcVVLTmFEYXZEbDBzQWdY?=
 =?utf-8?B?ZEVvaVlPUDcrSUhOY08xUmVpb0VLOXBqUGVDMUMxaTJpOWJlZmJqUFMxODBJ?=
 =?utf-8?B?VXNUa09NVHQ2THFGMEgwYkJaZkMwY1JOWTExWnJyd2Jlc0Fuc1p3NWhwUWNW?=
 =?utf-8?Q?SZywe3Dj1kvdF?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-990eb.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 4416d83f-c503-4a6f-7ccf-08df3c11a4bb
X-MS-Exchange-CrossTenant-AuthSource: PH0PR19MB997338.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 14:24:18.8234 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR19MB6405
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Fri, 06 Nov 2026 14:59:05 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_FAIL,
	SPF_HELO_NONE autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 06, 2026 at 04:57:55PM +0800, Joseph Chen wrote:
> Hi Quentin, Chris:
> 
> 在 2026/11/6 1:32, Chris Morgan 写道:
> > On Thu, Nov 05, 2026 at 05:13:48PM +0100, Quentin Schulz wrote:
> > > Hi Chris,
> > > 
> > > On 11/5/26 4:10 PM, Chris Morgan wrote:
> > > > From: Chris Morgan<macromorgan@hotmail.com>
> > > > 
> > > > Don't set the RK817_POWER_EN_SAVE0 or RK817_POWER_EN_SAVE1 bits. These
> > > > bits are not used by mainline Linux and actively setting them in U-boot
> > > > interferes with their function for BSP kernels, causing systems to
> > > > hang when regulators are enabled or disabled incorrectly. [1]
> > > > 
> > > More information in the commit log would be welcome, in the event the gist
> > > ever disappears.
> > > 
> > > In essence, those two registers are used to store the current state of the
> > > regulators (why? don't know and not explained in the gist, do you have some
> > > info maybe Chris? Anbernic seems to be ignoring it anyway but we don't know
> > > if there are actual users of it). They aren't meant for that at all, but
> > > that's what they are used for. Downstream kernels then read those registers
> > > and configure the regulators at boot based on the saved values. In upstream
> > > U-Boot, these registers are set at PMIC driver probe time, which doesn't
> > > make a lot of sense since no regulators would have been configured by then
> > > (although, they may have if the PMIC driver was probed and used in xPL and
> > > U-Boot proper then save the state as configured by xPL).
> > > 
> > > I'm a bit worried other downstream kernels may actually be expecting these
> > > registers to be set. But considering we probably are misconfiguring the save
> > > registers anyway (by saving too early), I guess that's fine?
> > > 
> > > Please expand the commit log to contain summarized information from the
> > > gist, and that would be an:
> > > 
> > > Acked-by: Quentin Schulz<quentin.schulz@cherry.de>
> > > 
> > > Considering this has been the case forever, I'm tempted to get this into
> > > 2027.04 rather than 2027.01 as it's not a new regression. That would leave
> > > enough time for people to complain about it (though I'm not sure may people
> > > are actually testing upstream -rc on Rockchip?). At the same time, we're
> > > still relatively early in the 2027.01 rcs so maybe that's acceptable too.
> > > 
> > > Thanks!
> > > Quentin
> > > 
> > I'll resubmit tomorrow with more information in the commit message, as
> > requested. I'll save the ack so you can confirm if you think it's
> > good.
> > 
> > I don't know that we have a good answer as to why those regulators are
> > stored. The BSP U-Boot driver (assuming it wasn't modified by Anbernic)
> > would check the device-tree for a "not-save-power-en" parameter and if
> > it was not set at 1 it would save the contents of registers
> > RK817_POWER_EN0 through RK817_POWER_EN3 and then save the contents to
> > RK817_POWER_EN_SAVE0 (0x99) and RK817_POWER_EN_SAVE1 (0xa4). These
> > values would be saved at probe time which would be very early in the
> > boot process. The BSP kernel driver would then read the
> > RK817_POWER_EN_SAVE0 register and if it was not 0 it would then read
> > RK817_POWER_EN_SAVE1 and write all of those saved values back to the
> > PMIC as part of the reboot-notifier.
> > 
> > So basically it looks like as part of the reboot/shutdown process for
> > BSP kernel and bootloader, the initial values for what is on/off is
> > getting written back to the regulators unless not-save-power-en is
> > set in U-Boot. This process breaks down for boards where the BSP
> > bootloader sets not-save-power-en.
> > 
> > Since mainline Linux doesn't use these registers at all and there is
> > no parameter to control their use in mainline U-Boot like there is in
> > BSP U-Boot, we should just drop them so they don't interfere with the
> > BSP kernel.
> > 
> > Thank you,
> > Chris
> 
> The purpose for POWER_EN_SAVE0/1 is that:
> 
> During a PMIC reset, voltage settings are restored before enable (EN)
> settings. For example:
> a regulator that is disabled by the PMIC hardware at power-on, with a
> default voltage of 1.8V,
> may be enabled by the user and configured to output 1.0V during operation.
> When a reboot triggers a PMIC reset, the regulator may briefly output 1.8V
> before being disabled,
> posing an overvoltage risk.
> 
> To prevent this, U-Boot saves the initial power-on enable states in
> POWER_EN_SAVE0/1.
> The kernel restores these states in the reboot callback, disabling such
> regulators
> before the PMIC reset to avoid unintended voltage output.
> 

This behavior is not reflected in mainline Linux, should it be?
If it should, it seems to me the proper fix would be:

1) Add the functionality to set the regulators in Linux, like it is
done in the BSP, as part of the reset handler.

2) Gate both the Linux functionality and U-Boot functionality behind
a device-tree option. Unlike BSP, make it opt-in rather than opt-out
(to preserve backwards compatibility with the existing mainline
kernel).

Let me know what you think and I can start this process.

Thank you,
Chris

> 
> > > > [1]https://gist.github.com/fr0z3n-cs/047b24a6fd430e816fe02a877ad7ab8c
> > > > 
> > > > Signed-off-by: Chris Morgan<macromorgan@hotmail.com>
> > > > ---
> > > >    drivers/power/pmic/rk8xx.c | 11 -----------
> > > >    1 file changed, 11 deletions(-)
> > > > 
> > > > diff --git a/drivers/power/pmic/rk8xx.c b/drivers/power/pmic/rk8xx.c
> > > > index 95b71d2fe49..16b3dc7cb1c 100644
> > > > --- a/drivers/power/pmic/rk8xx.c
> > > > +++ b/drivers/power/pmic/rk8xx.c
> > > > @@ -251,8 +251,6 @@ static int rk8xx_probe(struct udevice *dev)
> > > >    	int ret = 0, i, show_variant;
> > > >    	u8 msb, lsb, id_msb, id_lsb;
> > > >    	u8 on_source = 0, off_source = 0;
> > > > -	u8 power_en0, power_en1, power_en2, power_en3;
> > > > -	u8 value;
> > > >    	/* read Chip variant */
> > > >    	if (device_is_compatible(dev, "rockchip,rk817") ||
> > > > @@ -293,15 +291,6 @@ static int rk8xx_probe(struct udevice *dev)
> > > >    		off_source = RK817_OFF_SOURCE;
> > > >    		init_data = rk817_init_reg;
> > > >    		init_data_num = ARRAY_SIZE(rk817_init_reg);
> > > > -		power_en0 = pmic_reg_read(dev, RK817_POWER_EN0);
> > > > -		power_en1 = pmic_reg_read(dev, RK817_POWER_EN1);
> > > > -		power_en2 = pmic_reg_read(dev, RK817_POWER_EN2);
> > > > -		power_en3 = pmic_reg_read(dev, RK817_POWER_EN3);
> > > > -
> > > > -		value = (power_en0 & 0x0f) | ((power_en1 & 0x0f) << 4);
> > > > -		pmic_reg_write(dev, RK817_POWER_EN_SAVE0, value);
> > > > -		value = (power_en2 & 0x0f) | ((power_en3 & 0x0f) << 4);
> > > > -		pmic_reg_write(dev, RK817_POWER_EN_SAVE1, value);
> > > >    		break;
> > > >    	case RK806_ID: {
> > > >    		u32 rst_fun = 2;
> 
> -- 
> Best regards,
> 
> 陈健洪 (Joseph Chen)
> chenjh@rock-chips.com
> 福州瑞芯微电子股份有限公司
> Fuzhou Rockchip Electronics Co.Ltd
> 福建省福州市铜盘路软件大道89号软件园A区21号楼 (350003)
> No. 21 Building, A District, No.89,software Boulevard Fuzhou,Fujian,PRC
> TEL：0591-83991906/07-8573
> 
