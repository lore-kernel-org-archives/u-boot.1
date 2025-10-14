Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BBEDCCD184
	for <u-boot@archiver.kernel.org>; Tue, 14 Oct 2025 16:06:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15D63835FE;
	Tue, 14 Oct 2025 18:06:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=avaya.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=avaya.com header.i=@avaya.com header.b="QhRdtNua";
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=Avaya365.onmicrosoft.com header.i=@Avaya365.onmicrosoft.com header.b="OrlVC2+M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B03280422; Tue, 14 Oct 2025 12:21:43 +0200 (CEST)
Received: from mx0b-00186901.pphosted.com (mx0b-00186901.pphosted.com
 [148.163.137.181])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D724E800D7
 for <u-boot@lists.denx.de>; Tue, 14 Oct 2025 12:21:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=avaya.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=amanea@avaya.com
Received: from pps.filterd (m0173338.ppops.net [127.0.0.1])
 by mx0b-00186901.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59E6LgZH014819
 for <u-boot@lists.denx.de>; Tue, 14 Oct 2025 10:21:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=avaya.com; h=
 content-type:date:from:message-id:mime-version:subject:to; s=
 dk201908; bh=h/difP0Q51b0x9ofgLvsHBas3ifALuaxSMqZVJSQFF8=; b=QhR
 dtNua1Sh3nq1H9Xnj1WEPIkrG2t6bFf3z7B+swIaHUUMevFan0qddiqYcvDLh0WW
 0oceQSX3zT8qRpeRfqWgXPVVP6YoB1G/0H2GGeeHGzaHwshp4JmnE/hRjDm71ETt
 CGgRw9aCnG6e1O3mUf736/S3LgPKQKvSZpEy2zu/4Qi+stwTykF6vZpIPr1jSxAe
 ucXrzwfhnZfS3X0JUzL5kMLjzbJgFkUMWISy8IjfK8q9xMvBVfh7hpzpv8G8pJZL
 KOLiHN/238mZUtxJCFWGdRbHDVMYrmv3oNKmcY9XUGUxv8HFhpL4BA09GyouvsmA
 DyWbfo3NEuPdQmJblYQ==
Received: from sa9pr02cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11013025.outbound.protection.outlook.com
 [40.93.196.25])
 by mx0b-00186901.pphosted.com (PPS) with ESMTPS id 49sh630cw4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 14 Oct 2025 10:21:39 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ehMOFeUcF8+xe1vs3yal6tKmjGfneMJAORTNvxnBelrUxq1cj7NiMS2w+ODeUsPsiHtR3rBlIXseXTvAd2i4IULyh+JBGDlisR8cOsiDnMWPTBgtpJ752ivRhB5kaH5VYob5QTAEgWazLl+FinUDm39Uhr12R6IVviVX7jTMtXex3R9rLUwAMyqL+vBMJ3yAgWTUT7fgA06kUnQiy6+IaPRVh17mYC43dVCcocXEoAOREy3tJ03LYfsd+joqDByja5R/zztn77USi6aZn7kZ0p/DJry3zBuAwmcBEeop64DkY2xiFHx7A+g8NNYeBU859FSudOnMN4huCPJzgqUecQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h/difP0Q51b0x9ofgLvsHBas3ifALuaxSMqZVJSQFF8=;
 b=MWF+P5I88u58zv2swkyLMilQoG0gbHaWyaXvbyY+89HlPyVz9oKRMAbd48c58CNAnFtSWfJBK2ZAMNC+J10ZRHbcDOjSf3rjkBDhT/fLvsrqGZ6elh1dXVZPzlJ4/AcGtb2APOQEzxGZXxpXB0SQbu54CM4lRnzphO1AL1tyNWbXIUuZ5Fq9jXXeWUl+/w0SzuSjr1AEygTriDyK6Ize0nbWZHF5qu1uThK2MTHK5VBA0hJ59DqQPcwZxPb74qHlH4vTtqJpQAkuRbNHaoelu007rghN5HgBNvLxsh5HITnb7xhiCP3BJlA4JO1W6RkEbj9a3sUpIACOKFgCqAVtJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=avaya.com; dmarc=pass action=none header.from=avaya.com;
 dkim=pass header.d=avaya.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Avaya365.onmicrosoft.com; s=selector2-Avaya365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h/difP0Q51b0x9ofgLvsHBas3ifALuaxSMqZVJSQFF8=;
 b=OrlVC2+MuhBDKq0wzdoEdsUhDkRsRMtnL2oqdaIX/8k6fhHhtJ8g1jIK2M/aux0EDGU1qG+0Il501ClQcch6bToXJxD9M5aMhsQ/O5Z//T+R3mS/H2nekeHb75trKBAD8CDwAiZ6k91QeY8WMAb6gW40TMPA4rtrxAIS/CiDSYQ=
Received: from SJ0PR15MB4758.namprd15.prod.outlook.com (2603:10b6:a03:37b::21)
 by PH0PR15MB5119.namprd15.prod.outlook.com (2603:10b6:510:c7::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Tue, 14 Oct
 2025 10:21:37 +0000
Received: from SJ0PR15MB4758.namprd15.prod.outlook.com
 ([fe80::6b53:e8f:2b48:7c23]) by SJ0PR15MB4758.namprd15.prod.outlook.com
 ([fe80::6b53:e8f:2b48:7c23%4]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 10:21:37 +0000
From: "Manea, Alexandru (Alexandru)" <amanea@avaya.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Uboot upgrade from 2016 to 2020
Thread-Topic: Uboot upgrade from 2016 to 2020
Thread-Index: Adw88+QOxL+rsyUwSIea/uTt5I12zg==
Date: Tue, 14 Oct 2025 10:21:37 +0000
Message-ID: <SJ0PR15MB475808D1A536E7E2993BDD1DDCEBA@SJ0PR15MB4758.namprd15.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR15MB4758:EE_|PH0PR15MB5119:EE_
x-ms-office365-filtering-correlation-id: ab7dc008-ff5c-4f78-f38b-08de0b0b752e
x-pp-secret: juy7654fvc87ki.jtred3xepo0.4g2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|8096899003; 
x-microsoft-antispam-message-info: =?us-ascii?Q?JZ+xCgM61eK9gTKk/vH+th/ClKCJsGJimnTrA/pn2z2Vck6UZNlHXWgIxnx8?=
 =?us-ascii?Q?6XCVIWuPhR+JpdVvhejGT/aOXbfgXKqqBiUEpP19wZe1aDfWr+ZX0GatjMLG?=
 =?us-ascii?Q?0lTaemSwXKXs8eQQjHfIaGPyeRw+YkYA5zjJLIdCpbSImSNOm1nMoUSLlME4?=
 =?us-ascii?Q?ovIAJoLndZKZbjfD+zG4bskWHTq7TBeCo+28yOpF7VYgI9vUCkfMIh11F+RX?=
 =?us-ascii?Q?n9eMc++dV8cgDAjxQEsA6imabj2R/IKB2m/d5p1DSLgp5c7gsuAvvmgXRAC6?=
 =?us-ascii?Q?e+itN1GYI2TSoZ8/tw3+j9o5E7Xdwqw5MCqcPZL50W/ShL+fKCREYXIIpFCh?=
 =?us-ascii?Q?yf4hXiCRIv0+iJEGaunTgqh/TITf/b9o54i3zihUHkhN3qLv1SWb1pWquymj?=
 =?us-ascii?Q?2g88MLFFwewcOJQvJqI5XGySOi+0ibymCzPRJsbAuTmyuBs7OzTc8DoLUEEv?=
 =?us-ascii?Q?9b1ZoE9fEw2zFQwaucgAcB7VaETybIq0kj/VOx0R0PnDvNau1q09dKi959xt?=
 =?us-ascii?Q?XtNme97Seh6al2C2Owli50P9qaiXFGJ5zkm9idfn4eB38+I2wqXpkpOBM/DV?=
 =?us-ascii?Q?GLvaJGUs2sc36YhV5xnuLNxdkQQaaJ3uHXOBvdSMW5hZRFBbBdoY4lqFzhAO?=
 =?us-ascii?Q?vqpQSoJVO6QfvqTnIhBt2qEkMBUynTtDPiVOLoqRDq0oLCgrPaXmirtqxFjG?=
 =?us-ascii?Q?HY2ep18EMNlyW+AsPfvlhDVFtzJgLGSK8jTRN4PGAMY5XrHrsOKiXdXLsjwe?=
 =?us-ascii?Q?Skh1mn/xbvNKzG6o4xP0T+7hG+Cqmj74CsYHE0pKNDtdI4kB2jVfQfOgFUzU?=
 =?us-ascii?Q?Ahhnaeyf3sAvFt8pBjx0di7dHMNMjD7qzmv0t2tgLH7aGi8ddrgfULqg05lh?=
 =?us-ascii?Q?mVCgRCxwC801JCq527sScQi6e/t4IDKC8S2bLwke1G74sk4q2bsIKz7v/638?=
 =?us-ascii?Q?ltZlSxoptcXkGrUvD80zGMLF7eNIFSQHfD3iIWBCbfabsGNgIlA3BjY5iYXj?=
 =?us-ascii?Q?zgoDSg/M3GTDixTvQcTSPjNlFoMtzc7B5jgYbejEDsRA/OYPZLJ8Bedr/N2p?=
 =?us-ascii?Q?NysLx4HCgx9ObE0e6uFTxF2j/egsgZ4L3hPsBrMBnEpdGQEhRzFiqIi5l/Ab?=
 =?us-ascii?Q?u0EQdXDcXJQuHe+eRskYvPaUbAX5czCmqmUTm+7Uh4UCesAR/c9eCL1utlMP?=
 =?us-ascii?Q?J+8/v1Whg1OlJlosfzUnlLvcrgPiz2Z4AYRHMmz0oWZfKUT53lvsPxLsZKLu?=
 =?us-ascii?Q?UCvoI5c7g/M9/UW/KPaj9HG3DWxBy0fWaP0kYL05j/Gtz76MLJ/UKj4h6X67?=
 =?us-ascii?Q?FmzJ22qztfmk7Sj3gajDVWKAR4Uxo1sZ2H4w4OipVTTBrXeXNRjSisr8B2Pi?=
 =?us-ascii?Q?fltoyeRsDKTn4Ha1wVq2RZeFaT0vjMNndsAUFoqJMFnWh/Y49OSbrfMgZerj?=
 =?us-ascii?Q?VgkHeupN8z0xY30PAfZx1yyGhhSMz8WvazHDTWIR9rn6CWXvXsDYEfFFYyBd?=
 =?us-ascii?Q?NBcDZvsVmqxvccrIosysjdYYRVHdfxHvfghN?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR15MB4758.namprd15.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(8096899003); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QrT6StSVGvQ0Pm1H0yJtMNzqSH4H3mhEKnbPIkWNjBuXr5XzTjSTBNV/VmMM?=
 =?us-ascii?Q?GkUqsbDln2VgAjWk64Xq+fWsyxn+V/CWUmj42G3Vqz2rJqThpv7GyAKQ9P/P?=
 =?us-ascii?Q?o+ezWTBIULtKrFQfwBXWwPlOdt7EyN5ABjanM9SS4fbfaE20lTQyGfuyeEgF?=
 =?us-ascii?Q?y53x1eFY7dqw35TrCb6o6BxcLO0SaT/gyt5kg6fLgNuEGyA8q6PcEmsolK/R?=
 =?us-ascii?Q?4Ud4m8gWIL93sj0tPwJ+foO5FW9ke+px/bBss7YlZPe087Zz8aJd7ua8kF8O?=
 =?us-ascii?Q?YDd+tVht3Zpj2pgo1R/y7kKLUtHITfn5qNMMyKBHd75jF+X1b9D4xR0AHYpa?=
 =?us-ascii?Q?sxMTeljgZ3WW8Dd1coCbIqNMsMF/InWRm0x1gnWyjwJqH9BHqiJGf6JFMHw4?=
 =?us-ascii?Q?2yopV56ejQD2CHJK7SIuKZ/yVsaqTWGwld8LXgDoruok5OaTYnKQBwXeM7Ot?=
 =?us-ascii?Q?/mqhYScVxkBFhp0s7tkvc9ndLdwXrYqPdm3qe367AOH3XeqQyUZ4bX7KMpwW?=
 =?us-ascii?Q?lDrBI9jgY/doCySu8ZVzgmNgQNvE0gyIi6JkpggnVanL3oxkEhmDxhY9hbtw?=
 =?us-ascii?Q?g4ghPMK/3tNAzj9erX//lVvqK4Z0qQkqBZZ4MB6EwDqUAz5RPffo+7aWeoCb?=
 =?us-ascii?Q?lbXCpRmeAn9d5EftIyi9tBxhPLd0lD8SK7pxN8cLhPsINJELAzXf6kkLbkLk?=
 =?us-ascii?Q?mTrpKQzpreBl99n721+hJYc5ES+6HARn6d/AFp0qK3um53CX9GhI5PYoG4QX?=
 =?us-ascii?Q?cFwTuxYOo8T/uWZVAC+epbdnPMny5CODXdjYTKStOJsKiZJcN50zM8ZknJdw?=
 =?us-ascii?Q?AFaDRkXrUTBt9LpdoXOD4ZEmmW5VaYV6JqJbw4FW14/+/0RyyCCuAyDhoTse?=
 =?us-ascii?Q?8NKKanrG1gc0y8+pv56n95OQH1preZH3auXvBOsL7LqZVT1ep/Vyq0ZUSyh3?=
 =?us-ascii?Q?ISlj4Bphd0c1j4w/rBw8u9hUJsWMOtWJxNkwaOD91qVCoE8AoDv3HpLm8UZb?=
 =?us-ascii?Q?IHKn6MnCgS2vz7yubCPE+De+Bv+hoT1EWKHv+qVWR0ikETHBrUPb9dwGyXnl?=
 =?us-ascii?Q?Yx9Z27iyuQ/9TnvyRRApAZ+XKy2gOHkSNiNFCoQapABYmSvxcL3w4zgt+Y01?=
 =?us-ascii?Q?QJZC8avTZu6dTK0PkSbZ6kVgqNcdrM3ijOxjzzcmfvk1rT8/pRGQvsHswZr1?=
 =?us-ascii?Q?dkIQoI9R7f/XTwy4j5oX36iRUeO9a1fcg45ojh33+QprJPWbECjAJrvg19jk?=
 =?us-ascii?Q?jW9QW/G7+poSPSlN920v9AEZi6KgUPB5qXrJKKti/WWkSOrYKo5JsAjKGF0W?=
 =?us-ascii?Q?nC4MMN5dh8WBDKE0ABIk6q46tqY6IUClvZoNw2Jtcka/HtEEBt3k22cPp/Br?=
 =?us-ascii?Q?lhJKeMtKwl8ouGlAWQIemXBCizY4zhfTPffn0Ukip8PDcgUBvZ14g8rjqNOk?=
 =?us-ascii?Q?GCJkd5qDeKttbKVg6MeTsxYwpjwvdeywjxR0NFuBUHMVsc5AYwh32LF1tc76?=
 =?us-ascii?Q?Zz7Ok/JlSyNqXuw6pPzH+j8Ac0rI0FBaUHUXLdjNaUG59B151HCZT6EOZ2nj?=
 =?us-ascii?Q?63YHSvwl85S3369F7SI=3D?=
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: TT0cMLywZObues7SStlNsYLMGTOtEDDXqFLPwJRbuFMaSkr9rY1hvLP3zB8ROYDDhNUdv85p0J0BsPZdZLbf3MgjdT7wTUx/5kgyhJLn+KLsVGytG/Zs6IrFAonVxG1XO01ev06wsPoXotjrnPlbUiTMrJQvikNBNOYdzYeofCOsTHl2B/j1zepm8zw3Gp/QZlUjAUn6PaNDwShUpIDV0k2oLaSmc/6mFCyfkPYqYSS0Xo5o7UYCTLu1AmT+r/JJECUt+l84hdxDksUzS4H+9lr0mEjDTvuHSaQgldXBeiPmMuRY6t3QkgVVbM6SH5SRr6ICEBkKcj5t2OKoRXpasoPGA6UwzJmfwjz2MC4selb/01oeu7QP+YuQCgr0ukjvT9AcqLj3o/rhv8zkGIwgt3kXGZF2CJEi7O+hdwIqQADVN463sQC9R2Bo5D7ZIRsrEw1D6s1/71iA7y+ApFwt/ybMmulIVyi+SulQ1eq4yfjFgdTicLJ1KDZh6RD8aevRnTlIcBDsEEeLbBkS8XcAqcdqGCKdyEouMe4QSaeu3Nvy4tRK4B0MxiV8BD0cOo65/Xi/OeYO9jKX4UhxS4C+adcHednlOCQHKgL8h2hmFArORIEWIObe92w3rRQtv1Agd8ojCByCgFpLa9taDfrQWQ==
X-OriginatorOrg: avaya.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB4758.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab7dc008-ff5c-4f78-f38b-08de0b0b752e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2025 10:21:37.1560 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04a2636c-326d-48ff-93f8-709875bd3aa9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C47hXlDlSa+A5QL1Vu3EHT9XINqVCwsg6pM5FvtYjo9YfOotVKf7bVKQDzYaH9fACqtwaIE/CVLdZ8Sx1KbaaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB5119
X-Authority-Analysis: v=2.4 cv=MIRtWcZl c=1 sm=1 tr=0 ts=68ee2433 cx=c_pps
 a=XslAgrSL5Auaid5C2fKBmA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10
 a=7_b1JmNPT6gA:10 a=VkNPw1HP01LnGYTKEx00:22 a=5Zta_8kPxfi7rtisWlQA:9
 a=CjuIK1q_8ugA:10 a=yMhMjlubAAAA:8 a=SSmOFEACAAAA:8 a=uiSL7vqUW4CU-GGXjccA:9
 a=hdJnwPdwejVVjuPf:21 a=gKO2Hq4RSVkA:10 a=UiCQ7L4-1S4A:10 a=hTZeC7Yk6K0A:10
 a=frz4AuCg-hUA:10 a=HhbK4dLum7pmb74im6QT:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE0MDA0OCBTYWx0ZWRfX58qk2AX+KE6J
 2QiTpQH8xGcXw42QpSliORZ2S3/8hp2jhReUaoVmMTYU2vQqAutHaXxzrRN0G83rjaLIpP+Knas
 18T0Uy6IBscJVdvdfBS3Ws4i1Q2BErcaz/5xUro2CdvWwBJYfP8YDlBbfjHdYfe14yoTG/DwVAM
 BPp/tfq3B8OI7dM/WyLUq7rmTOTNXGYUraMm6uIJxAThXqeISPvNAIuz6W9oaf48zYy0kY5N+N6
 9Io/RPlhROr/1Od6euVY8+b+Eo1bTTTN7JEIoLUY7KpP+F11CfI7A0PQUcwMl/LzSroCN6PxgDh
 P3CvCBimKV0Nru2Sx8SA9QidPbdaIhqnuuUBvDMTOdk4di1wgAokZYbEmxRChan7aKtNxYkuJPU
 /NgtpieBS4lilExa/Md5pnpw+mxDDg==
X-Proofpoint-ORIG-GUID: Fd2Crku5l6N9is96k6SAygofUGjFr6mS
X-Proofpoint-GUID: Fd2Crku5l6N9is96k6SAygofUGjFr6mS
X-Mailman-Approved-At: Tue, 14 Oct 2025 18:06:29 +0200
Content-Type: text/plain; charset="us-ascii"
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

Hi,

I have an issue with upgrading our sources to use the 2020.04 uboot rather =
than the one working now on our system which is 2016.
After adding all our board changes, I can see the SPL loading and setting D=
DR and TLB entries but once it tries to jump to uboot from mmc_boot() it ha=
ngs and I can't get to see anything...has anyone encountered this? Is there=
 something I can do to make sure uboot is actually being jumped to or why t=
he hang? I've set the offsets to go to the _start_e500: instructions like t=
he old uboot. I can share the traces I have if needed. Looking forward to a=
n answer.

Regards,
Alex
