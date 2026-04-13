Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF247EBFD2C
	for <u-boot@archiver.kernel.org>; Mon, 13 Apr 2026 09:53:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4105D841C2;
	Mon, 13 Apr 2026 11:53:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="oMaHi3mJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 022B484206; Mon, 13 Apr 2026 11:53:23 +0200 (CEST)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD3AB83F75
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 11:53:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=boon.khai.ng@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OByeMkVxXVpiN5qv0M92iz/3ZwqOZFTPOPHUY7r8/SqU9EHf7b7U8WUvvfDempVqsc5HIEsEhm5fOLb0N5+IprNh/CqnkNPrcAjqtKi/NGVdSfC8icdROOPJaAibU7sFz6hEQdbSHWQKj+9uH5abGcgDhvt9QOrj79lodQS15fkfQazzBgzccJzbSXNJsbhvigkuWv9PXbQ+LAvy7dZBiXPCAnESqd3q2G4MCEhqmAz72GQRUG2yEFXXypKSgW7uOasNe2L7vfh9mysaThevKR8dfFtOJ9Y/S45tLzEwYLwLqy+fHTPF34mcm+aAwQ5l1qI//4zQdXjaRjkE9dgsXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DEB1SCJiLXaG0OdsulY6vLR1IO9g2YLyGS1QUIWuOzw=;
 b=Mb7vmIDIMhEPwAafGYzVfn8Fmc4ESBE8W7nPHH4wOqEWr/7DSKkJPq57Fz4b2fcK0AaS5xN0hT2dXex8prigqUm0f+hklpsW5UHrlu3+qPkut68XVjG3JCGmkqo1nRZ2mip7fSW+qNV9E8mA15RWKlsAN07t57njZu5jYgK1KqJm3LltGBRrsFz5XRJlmQOcuKE//7wOPONgGpu0ZKmQdTBGnY9/6VDOHylRZUk9lyPh2cf5BlQpFA2eMkdVOAwKxJ7UbGQcP4FjMGOLNeRnwC8tJ4aLY48gEusI0JtlFhwKRN8dfwnme5FEYaRLAm2zBHtNXAcpvU10+60ynKqY8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DEB1SCJiLXaG0OdsulY6vLR1IO9g2YLyGS1QUIWuOzw=;
 b=oMaHi3mJnwmBTDPVC6Hrrt2QWpaGF7cnhObWLL38ORqZNFRZh1q61QQteFQxjMMjJM2IM6OEQ/XZ8CoGzVd1nLNBH14b1Q73KbRYkL1v7oZ/C+XP2OYyAv/7uqDNyiL+e1mo24ZB/8r62kUpfBc5Pb8NO51BektVnlfLUhPYeYJ2abz820OWFD7Rracjy712B9xHeScaSlW6W8sk6dfxJIFbwcrVCm2k8Lesy7oPEkVKEh0sA0mYA23wgR+n7PFR8sLTaM+YNbnw+GFxl2sjQTfHbZMXscNoDcjkQtv5x9YI2MirLLbWLuHVsLt9Gw6inXtPl5Hwfzgr+/nVrIiLyw==
Received: from SA3PR03MB7187.namprd03.prod.outlook.com (2603:10b6:806:2f6::11)
 by SA2PR03MB5820.namprd03.prod.outlook.com (2603:10b6:806:114::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Mon, 13 Apr
 2026 09:53:17 +0000
Received: from SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::7000:d55:b39c:2e53]) by SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::7000:d55:b39c:2e53%7]) with mapi id 15.20.9769.046; Mon, 13 Apr 2026
 09:53:16 +0000
From: "NG, BOON KHAI" <boon.khai.ng@altera.com>
To: U-boot Openlist <u-boot@lists.denx.de>
CC: Alice Guo <alice.guo@nxp.com>, "YUSLAIMI, ALIF ZAKUAN"
 <alif.zakuan.yuslaimi@altera.com>, Anshul Dalal <anshuld@ti.com>, Casey
 Connolly <casey.connolly@linaro.org>, Christian Marangi
 <ansuelsmth@gmail.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Neil
 Armstrong <neil.armstrong@linaro.org>, Quentin Schulz
 <quentin.schulz@cherry.de>, Rayagonda Kokatanur
 <rayagonda.kokatanur@broadcom.com>, Tien Fong Chee
 <tien.fong.chee@intel.com>, Tingting Meng <tingting.meng@altera.com>, Tom
 Rini <trini@konsulko.com>, "Chee, Tien Fong" <tien.fong.chee@altera.com>
Subject: Re: [PATCH v1] drivers: clk: agilex5: Setting correct counter
 frequency in boot mode
Thread-Topic: [PATCH v1] drivers: clk: agilex5: Setting correct counter
 frequency in boot mode
Thread-Index: AQHcpW2LtDCy5TjkN0WZCDXEq0KpRLXdC41E
Date: Mon, 13 Apr 2026 09:53:16 +0000
Message-ID: <SA3PR03MB7187BF99049BC78C3CAF13F6B4242@SA3PR03MB7187.namprd03.prod.outlook.com>
References: <20260224091109.8181-1-boon.khai.ng@altera.com>
In-Reply-To: <20260224091109.8181-1-boon.khai.ng@altera.com>
Accept-Language: en-MY, en-US
Content-Language: en-MY
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR03MB7187:EE_|SA2PR03MB5820:EE_
x-ms-office365-filtering-correlation-id: 46dc44a8-5f0d-4b79-e332-08de99427c75
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|38070700021|55112099003|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: EkZLQeprARMBRcxBWnJ/CCQnbmGV1WKy/4q4jAwP5N559i9338BSIJMmheDSIUtsb1Fc7Y4IVS79N1SZMK8QZWC1g/dnUZFSur8AYn8T3RClEMn4SNsOyre8fH54lbg+nraGXb/hn0upZPdRJ0hGL8T/cmJJXKMPlCsUzuBpPRJa2hvcqoagTia9fioT7qY7g0Za+Z6xokKJKjCh5eIVM4EywKjvuMXfZ7nGnuH7SL7dG8H8UA4Uqo0NDzvO7jauRCgKGl0ezOnwnEtP41h6/8P3pR0FV7Z8mi3JEenTlDt+FJFvZXqhdRXUjw4jlY3/1iOPnoXjZz2BHc/2R8F77EHgD7DvU3AtkNR86/rgrX7qADkuKqIturT5aswx9U/Rox/PPQljREZY2wtBiXSR/7kkAQsXp1ukIgeEyBw16ynY6/5jbdUFMa8t9GLrtEx8ffnZoBYSXLI+WTOQz1jCwphMD5fFWzAjj1nK0NTpQ8yRmlIrAzwGn61SZbAOmCjd70AsPBAIMJEwvJ5Q254Fsi0/YReFY1Us25VMiUmA2CMlCPx1fH3Ad53CaBwOcWRQN76eS1/CL9daFhXf5S4bcGsEgSNXvSi0/f/fNje+DVkEkQRpaRegrpPIJ0WVXdelSaKPxwwl0sN/aRU5dhfafxfqubCCG0T5M2HeViEPpK7n6AwP8euXFf6y40Y+nu2WiIsC5pu7SWo/OhEUK0WTY3z0Kgmjviw1YPjyhYaUDGzk/UODfFPuOLHClkQ8zOFezwSnfUJpqZcgmWlu2TVebWGJtsdEEqqjxIr0kSXghQU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR03MB7187.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021)(55112099003)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?TvTcr2BvFiYG5XA6PGQGcDys9dUP3uVya+MkwtXG3tIgPkqXBgLieE1q9a?=
 =?iso-8859-1?Q?I6fYEgQf8Jhqwb8yMNUhyFP0ONr9FfRzS4vLPVeizM3SEneWGM/V3xrWOM?=
 =?iso-8859-1?Q?pVMZx1PoozJwFeW89+/tEhaXi4Qhu9g8llFPOt5ks+0EIz56UiA5h66Ux9?=
 =?iso-8859-1?Q?WtKL0cE1fy7V7kzKKAwxbXzHtlWZNyjHJ9iB22VhuXd3zlhNajBrZxInDn?=
 =?iso-8859-1?Q?yKQhpmHMRJTd3p4I6Mn/eagdeGwgmrPN/qbq/cu6RGP2WfpPp9U9yXFx+b?=
 =?iso-8859-1?Q?EN+KhIT4xjIi05ZwkLJ0vig4Z4QAaKrA6O6KfMyfi3jNS27NAsZGc0vVy1?=
 =?iso-8859-1?Q?FHeYC9GRTQdlGSQVFSjnEBHWQW54pb+SO1GoduXckyueadcy67lDtl0NmN?=
 =?iso-8859-1?Q?qBU+fqH06RkXnA1Oa/jbKvJiSKG+sINN39j588sqYnrqQUWa3Y+1f6kX0Z?=
 =?iso-8859-1?Q?xvIpJHok9TjE7Vsu3SZBuMNBuqGQXbZbWBZIJUh9vHLVENeoM23Fngttcp?=
 =?iso-8859-1?Q?wdJqmXBgve2oonV9IBNzw2d49EpYbj6Ltsk4/Bzb5s0J03uu1SeVkWPDPK?=
 =?iso-8859-1?Q?O8LVKMzIz7LPs/TkRMlj6UciVFA6ZnNF3+3nGAlJmskXe76D9pQF1BN91w?=
 =?iso-8859-1?Q?YJrg8/9ji26XBZa7yAuc+f58PfkdBlxhp4kSyoCLcQaUrLgxutIU/TMTMG?=
 =?iso-8859-1?Q?vifhc8vMMFZ44Hd2RoG8aA7lvDNP5SmYS/lAas6l1axRBnRtOZlSQ97Tvo?=
 =?iso-8859-1?Q?xVL4qmtUkhRuOL8SfaiIUmBL4jMeFtb+kzDE9ONn7cbhpB3DGeN2gPfQ90?=
 =?iso-8859-1?Q?KMTWOGS0kXQaey2eijzt28iiQaNRuuJQgsGpH0JI/r8zOLQ/LLtCQeip3W?=
 =?iso-8859-1?Q?rU13s2TpxVYPnmlJvnLbsLwQEagFSsDXOl6acCHqo1nTnmQzJwgh6rChM8?=
 =?iso-8859-1?Q?tZThcylfjOnVjp2m+NOcrR97BnUR0gapUJNUVXyP9aRTWedAoIBTS4CJp9?=
 =?iso-8859-1?Q?zGHDpR4x8cTyj023wn9BdOuNn/4oHtl/G/KyyN/gUVWNrzj2FF7UBgnb9e?=
 =?iso-8859-1?Q?puNRLrO7N/nLdYmt0z9AxuY6R6YWYAU1Z0mPn9/NJTCjVe6ztGxYREexd7?=
 =?iso-8859-1?Q?QCSRMa97QMYsDf79hezIEwIvw7LIAhzUkrNth/uBxBOq9WsMu15u8LqG9P?=
 =?iso-8859-1?Q?/Db5sF8vGS1zJclc7auKE0FSlWq62/1Xq9Cxuw4ATyTyEldUQzkUn4mxdO?=
 =?iso-8859-1?Q?lF/0bKPT+l2/YVLCukwKdauR9vEHuiZusr3aSHDzgxflAsa1ukiQWBhk/F?=
 =?iso-8859-1?Q?U63IsDAZCISqCy0A4DKQrtHccldzb0a78C/ymyWG9l7J0DUvvswgPGSlOk?=
 =?iso-8859-1?Q?9JWYBAYOwl438t+0Pnh1OYKC4JqaMhInbNvLFnHfK9QvDp1a6xSJ87qXED?=
 =?iso-8859-1?Q?FBQfc2sPyE8Q9PLixnwP1H/IgogyYR6o9LpOUlwEDIAGJVPAJJHcD3yOwe?=
 =?iso-8859-1?Q?uttjaPCG1LHFTIavk0WCkXdW0pq6KxtPm7Z0DGpeViXto0tXVC5FEibETR?=
 =?iso-8859-1?Q?6MGd9JYlWV8ZTjpBelalB9uXXVHccDGiBMXaTnXD5hWVsGqbc/kKiDlrJD?=
 =?iso-8859-1?Q?eeENQrVDPhdNg5HEjqYybKfmruf6JkXq0B/Zr1sFbGWG/iBjEY8qSn0xAj?=
 =?iso-8859-1?Q?OiWNtyfo4cPN/thUGvDBQTQh2z1UaTiz9BvDN/7qil+aIe9AAAH8CfOgCj?=
 =?iso-8859-1?Q?HJQAU6s9EqhlPc09jWDVC9BELH63vTQuH5ySrn15jDe3+XLiXGXh6ZB2Mu?=
 =?iso-8859-1?Q?oG2wIv/jOw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA3PR03MB7187.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46dc44a8-5f0d-4b79-e332-08de99427c75
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2026 09:53:16.8010 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6/UFUWHv9MLlkXSh6FUVUcFu5x7DDYKHsFutG7KpqdYob1vy9S+AETbKs9+Rnf1mTWwr/YmcjWmBOPW1il1AkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR03MB5820
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

Adding Tien Fong's altera email.=0A=
