Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55CE6109024D
	for <u-boot@archiver.kernel.org>; Thu, 19 Mar 2026 16:11:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8EA8E83DC9;
	Thu, 19 Mar 2026 17:11:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="j2RezKd7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0158683EEF; Thu, 19 Mar 2026 17:11:23 +0100 (CET)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0B3683DA6
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 17:11:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=boon.khai.ng@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IclRTC6BzpndO0hIdG7qLnXOBLT1yfzBLEVRjyPN7YhTsEc2uAuzhqB7CrPPHumdaT046/MGfIHT9JZcIHh+PFqx10WaLg4k08Ng4u3A6QDRbMGk6ZJM8ALoJccm2cI68/AFk+/VElqAYDw/8T7doFr9rK08a/LW9/T7GfWcCVwsWyFn28xMAS7zlACukC7cAqyPu/Ai678OBjyQzIuOdahKUwn1GDmiU7kvjvGbUIerXDCDII0dogUaTwWXUHKtCXgStGq4U64aBxkPSmfr/YfMZZAx60qYwFP1WHbbyPTlySXcCHDqQ+onW8p7bwy0u2cXf33PvQzo9HyxThQ/9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yeIPIHDxpP/RxlTKkAb3RwD9wBejxGkeVb43YDSN7h4=;
 b=wIPi+kmpLLZKzl6U/KMzbsxbkENf/arDcqyEoQLqS9HMYOLojBIu/MS7LuhHi5J8RWn9oP4/1eDUt/HBWC3/O9EiUqaCsNRhN0/ele6p63e0Ih02jMFTRCVJzq5VDcQiZIbpwupLs/Mmaht2Swm58rQi/u/quTDhEjsQVqwNf2cv3RzVLZr9/Qm0/Pfs/ZO/WlKUMTgijiwZ1Nv/qnT/QGZbVYiV13IGJ2zrYXfj48uEGr5Rh4ynJXrwAVGgiCq7UpLx3PJRqGT8Bs0MKHThQ5jXdRwkeNXx+sUnMCD9baUpsNCfLqaDdExIeaRQkC5ufDmSs0u9fkkCmxb5J9R0CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yeIPIHDxpP/RxlTKkAb3RwD9wBejxGkeVb43YDSN7h4=;
 b=j2RezKd7jL6a8eN+7td44J+JgK6rm7mfNaPiDk9ZmG79PjbvaLMd+TdTEZxdvL+Whkj7lLjA6F+dCc1M4QqBy20xUK+zYJggIKDegPjtNxTGkCaT9DnJY3pCBf04mQDNOZc3aAFnSGsIT6l2MLLi+5pMfBGZOJV9X8qbdPq3LJlus+ffXse7zJrn8dDWCdEjoXYRNDGfbebdIIuQ4Q6uS/eeS8Vs1dxy+yxXwyDIwsfOUIQXZwfmbeCaa+OxqaSrrQpWUGku+/NTaLafYBLaTvq5G8IJgUfDMXnqmpM1ZbvCz5PbSvJVFfkqLWIA5up5c69yr7IJ7lmVT+bU+Rp/YQ==
Received: from SA3PR03MB7187.namprd03.prod.outlook.com (2603:10b6:806:2f6::11)
 by DSSPR03MB989214.namprd03.prod.outlook.com (2603:10b6:8:374::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.20; Thu, 19 Mar
 2026 16:11:17 +0000
Received: from SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::7000:d55:b39c:2e53]) by SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::7000:d55:b39c:2e53%7]) with mapi id 15.20.9723.018; Thu, 19 Mar 2026
 16:11:10 +0000
From: "NG, BOON KHAI" <boon.khai.ng@altera.com>
To: Tom Rini <trini@konsulko.com>
CC: U-boot Openlist <u-boot@lists.denx.de>, Chin-Liang See
 <chin.liang.see@intel.com>, Dinh Nguyen <dinh.nguyen@intel.com>, Marek Vasut
 <marex@denx.de>, Naresh Kumar Ravulapalli
 <nareshkumar.ravulapalli@altera.com>, Simon Goldschmidt
 <simon.k.r.goldschmidt@gmail.com>, "Chee, Tien Fong"
 <tien.fong.chee@altera.com>, "MANIYAM, DINESH" <dinesh.maniyam@altera.com>,
 "YUSLAIMI, ALIF ZAKUAN" <alif.zakuan.yuslaimi@altera.com>, "LOK, CHEN HUEI"
 <chen.huei.lok@altera.com>, "Hea, Kok Kiang" <kok.kiang.hea@altera.com>
Subject: Re: [PATCH v1] configs: socfpga: stratix10: Disable mkeficapsule tool
 build
Thread-Topic: [PATCH v1] configs: socfpga: stratix10: Disable mkeficapsule
 tool build
Thread-Index: AQHct5NhYEcwx8aNDU+9MkP3aZIY5LW13uOAgAAmm8o=
Date: Thu, 19 Mar 2026 16:11:09 +0000
Message-ID: <SA3PR03MB7187764E2EBF3FACEF2619DDB44FA@SA3PR03MB7187.namprd03.prod.outlook.com>
References: <20260319112717.7805-1-boon.khai.ng@altera.com>
 <20260319134809.GR502704@bill-the-cat>
In-Reply-To: <20260319134809.GR502704@bill-the-cat>
Accept-Language: en-MY, en-US
Content-Language: en-MY
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR03MB7187:EE_|DSSPR03MB989214:EE_
x-ms-office365-filtering-correlation-id: 4bc45e1a-214c-4ab8-0b3a-08de85d22274
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|10070799003|366016|376014|1800799024|38070700021|18002099003|22082099003|56012099003|55112099003;
x-microsoft-antispam-message-info: 6XpZ9TwbU1rWdQRCxysOJvFM1XFhBshepn2ld+F342afiJUhR/yQ7X60k3XCxt7daxtom1zBeCmkkDVx356PYkg8zsc6SrpPf84JRMLJ+KK43FwILGDIqJy3iQj22q3SEhbjMSddz7Ehx7sT75OKRjagNbRg+lK/xchIzVB7if7yRwzA8RQMw3zZNHUouzS5L0gHxhGxCP5viaFM0QDx2zcffxjMgwGKK/hgwfasAkMypn5GlitGXDSCLmemebRGbcTb50saBAeSr54s5HWh8JncHRrlLGSpxqlZuvnbLxwXBea1P6wLbb2ejne0S6abp6du2crfs4tsm9OxRUOtaWwHTaq/3FXqXKe9qH4g8rNyeSvYjLXjRg+6jv8zacl0IIQ2h8YuW/VeL3F0o9TuIG6zFtB2fHtRBwr82TppaAGmU0eKsl7C3RO+5xKVmi2Wr7P2YkfoHUA081qqOHo5vHQk7nDOY1kwlCoo81ezWPrkCjJEP/+Q4toiel9ZpICSq8qXlmYEbRMPS937h4Wb0MAjJsYgTvBx3P6dAdjT5bDw9BpNy9t9gOnLo/T9KaHjBjg2/ldAgx1ZmYO1HnvagNRVVcXaoGJKNhdhazBjhpWnlciKsojK/c3jkhyws9Lum8qb4k+EwxMdcrV6n3odXibcM+Lk2Dd/oQ3GqSzlKx3BUB3TBsa8goauQmWt4Fbwc0D3Ror0TW5OSly8djobVi9umq18ubuiOFqBD4U2hcApv5NedO2Cg+qsYLxNifCmogTuAOhkggw5Ga3gX4GX0kXANFmvYlV9dVYGV7P+BfM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR03MB7187.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(376014)(1800799024)(38070700021)(18002099003)(22082099003)(56012099003)(55112099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Umlsb0G6OpWENiZgiQptk5tv94chieTDZ3MuTMqBjrVF5i+IsqmAJcl7IC?=
 =?iso-8859-1?Q?+Fi1DLcM9Mol0roK1p9AaYmQ2bHmUDQiq/6FU7zvPBjr8wlah/p/6jPvB4?=
 =?iso-8859-1?Q?RyeiPxHgUNaNm+SCGbD98hThy06uh/iE9yCRlMkH6UX6NsFUfZ+NSZHz7z?=
 =?iso-8859-1?Q?Rh84EdcBk3VfXyd/c8wJzNKgY5q1yIAYYyX/FhxzAEsFYkLs2j81pTJcbp?=
 =?iso-8859-1?Q?A5L5OKVXycUv/87i8XdvLUkeatYlvIlwtaxU5ANv1hWvNqOJiXSDkOaNo9?=
 =?iso-8859-1?Q?0LhrnxCJUzU36mJ/2zwet45bFriiPIZpeYtLe5kz3shH8vlZi31+yacs1f?=
 =?iso-8859-1?Q?eHz5PIQ5oxjarLD4Sh9Jf1o3RiKlUTFsYQfJUf7YkzuBHcIpc4a7e38c7y?=
 =?iso-8859-1?Q?TqRdGUPUP5oSRQqkHeU80uCyCh2j4jFAoYB99R6YC8M/QuzNrFWXjM9VDY?=
 =?iso-8859-1?Q?BP6OVTIcck7ZAyfMygh7M9pOfW/OIHlcU7I8ozcMzTtHEU3dCfAoCsOTNr?=
 =?iso-8859-1?Q?sthT7nx7IaivnXVnRQ5HPY/gqgLsEl3drn/CWsK5/I15pKDu5E4nvwwIlT?=
 =?iso-8859-1?Q?WmnwVt3YTvfAtB2AlnxQrfo9v+l3T02BEz/MPqFLhcEhgNEyJuVV3ScHMM?=
 =?iso-8859-1?Q?+I3Q11oxMTcLz1cpMW/XzeO+JVhE3fTDOA+z3Yqy89e3TbIJ2KeCvn9KsT?=
 =?iso-8859-1?Q?wlEdj6/bI8d+gtZ6qsyVKEc9foUXRgEQO/5MArCjXAiodlPQiEsBF1UuKa?=
 =?iso-8859-1?Q?/y4Two8ElQxjabD6CD99CMMq1XywQQOm0QOP7/XrWIrHdZ8iU+KKcctxwi?=
 =?iso-8859-1?Q?gFDe7DVr14KAcVcTBcKO1e7TMZH8GMFCB2i1UXSSzSTXsCQNlZMNgb0bKM?=
 =?iso-8859-1?Q?yCSeF00t6MfbbL2PlYDMTIZLQnGUJNXP9xgSidquq//CyKCqJgAI4kdQSQ?=
 =?iso-8859-1?Q?wcrhMhhf2HmjYQ8UReZnG9RzD3SWYUuNn4OjCLZOcpaimt3y1TJEB8LZjR?=
 =?iso-8859-1?Q?kOZ/OS38nuYdj4XJ0H+2GINabn2biSuL5uJbLRikfUJAX1tkLukjVCp0vb?=
 =?iso-8859-1?Q?/a3CsPQri7rCYKJCoBfw/6dMDQCQWuQAWvSf/nwNE2JLsywBT82kMFFJto?=
 =?iso-8859-1?Q?bqJn5eIA6cs0B23zYdPGbRyZJY8HcugXVleO3uT6AAXl+1PZ6TPboMN2GG?=
 =?iso-8859-1?Q?JjHnBMi8bu6FO+kJ1JwWlHN9pdPAv3EqYa1dPH2tCjbX3rmiOb2QeG8hfM?=
 =?iso-8859-1?Q?J6BJQI4g0nZvSextnTwM5p6+JcYZXwTiucHEmkVQupgl25jqwv96qRLdjP?=
 =?iso-8859-1?Q?mwaR29Ac56a9Z5wMANLUmtLuGqk+RarJ6zCc7UXNAcfCeLiviCy+e0OG/R?=
 =?iso-8859-1?Q?uvmuPXuaNB1RFLQQ7+ld/97oPjqJx7jNbal0XftK0NYTQhyapm8WyeH1yh?=
 =?iso-8859-1?Q?/sNetOm6mIICc5aBAHxEC2Ys1JrgeWHmoIF4dojKvHVdt/nOfGswcTvJfj?=
 =?iso-8859-1?Q?2Lsw+6xr/iGNf4qu+tqNkA55rpLNZIOj/TdwP8gbC5qpVglARIb/pv/uRX?=
 =?iso-8859-1?Q?0vPKqJpJ2QztHG5XhwrbKpsP3r9S5qCx3XGBOiEwqeTPkntVbZNCtJhbRA?=
 =?iso-8859-1?Q?/hmZoGsMFwJfhehX6+Pa624itklbTa8dFNP67Q1MwwMVt0PBbS5GD+RJYZ?=
 =?iso-8859-1?Q?NFYyY6CIqvOZswasqZitQ/OZPMRJFUJWZdgnRRm2zEuEwqNw8pMkPnQzyg?=
 =?iso-8859-1?Q?jueUIv0++LuA1Tg8LPA70cknmQoPz0DDJOy0nuBeCCbxs61rFLJsBUqvau?=
 =?iso-8859-1?Q?94uw5wJafvkMCJAXLmD6XuXze381Vahf6SrzPZNgGLF8Px7eNTwpp86IsP?=
 =?iso-8859-1?Q?Uk?=
x-ms-exchange-antispam-messagedata-1: qKUAuFDangkZfw==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA3PR03MB7187.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bc45e1a-214c-4ab8-0b3a-08de85d22274
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2026 16:11:09.9852 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jMNB/tasEGT9Rd8q9wLRAV3/EAsdeFaHmfe0mXtU7ITvZJMz6wVVkK3LFkdLtxBReUglmXEgd49OtzYp7BXl2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSSPR03MB989214
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

Hi Tom,=0A=
=0A=
> Why / how is this failing to compile?=0A=
=0A=
When compile without disabling the mkeficapsule tool=0A=
will hit into this error:=0A=
=0A=
tools/mkeficapsule.c:20:10: fatal error: gnutls/gnutls.h: No such file or d=
irectory=0A=
 #include <gnutls/gnutls.h>=0A=
          ^~~~~~~~~~~~~~~~~=0A=
compilation terminated.=0A=
make[1]: *** [scripts/Makefile.host:113: tools/mkeficapsule.o] Error 1=0A=
make[1]: *** Waiting for unfinished jobs....=0A=
make: *** [Makefile:2201: tools] Error 2=0A=
=0A=
We are not using that tools, I think we should just disable it.=0A=
=0A=
Regards,=0A=
Boon Khai.=
