Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D186D1625B
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 13:03:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D74C89026;
	Mon, 14 Oct 2024 15:03:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sony.com header.i=@sony.com header.b="F1unFu77";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1CD18888B2; Mon, 14 Oct 2024 08:25:16 +0200 (CEST)
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com
 [185.183.30.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D3EE88F20
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 08:25:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=JianfengA.Zhu@sony.com
Received: from pps.filterd (m0209318.ppops.net [127.0.0.1])
 by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49E4a2SI020985;
 Mon, 14 Oct 2024 06:24:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=S1; bh=SXqnZbe
 NLF2ZdlD4KBCHsqydF9ej2WwGp4YdTsCVEQc=; b=F1unFu77XWgbibfSwojl1Fv
 BJ8nbq4QuRe7AY///JMm//LMpdBUbNSvBtCSYZJeLN26E/vFzwv9kqYQwdO74lXR
 GuBf50KZFjzgfTGdw/c+okHr8UUnAWgRZIhx9amI2fX8rcSdJzfBfizx3p77W/Y1
 7k74p8m5EhE/meSiGekBPekEYkHr5mrRNkK+BFpY/w5K2Vh48hdEIBMCuslm2DiC
 gkjHkr8lEzGsHiy23V151HD+XauO+DtOF4F9VJMiVQU8veQNHlW1G5FOoIss2qYb
 0nXik2RDQv1y6TcYcf9eh/tanaPwj8A0xEcfuyKE1rZWHClAoJVcac/fkviw6zQ=
 =
Received: from apc01-tyz-obe.outbound.protection.outlook.com
 (mail-tyzapc01lp2045.outbound.protection.outlook.com [104.47.110.45])
 by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 427fp497c4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Oct 2024 06:24:48 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MrnAzk9sT+9ps1kiXVd4OEj+gtRDzUhFvqIF2laBHy2kWRryem2717yoT+qHTx9tYI43p3JnFkYADsomNFQZBVIkOJI2sW3+SLFLcGXPP2E211Rf05t0smsIXC5tf60yUoJWeYpXLzsvi2I3zrGGiZk1DL9BXR2mDLCweO/NanPKrEp2vpAogXQMzMpeRSbbsIY+nXcoDZ+4HvwVdgwLN8Rbe7JKqurMq2qxnCmpUoVwjjHyJhv3iss/s+qqmQRt89KxS/xtvWf79NMC80Fno8yKbmkHdhMiWIehXlt6BGPyPUkZs1of6fiEVd9Ny+/1LRAHXoR4e16J2Qfz/oT9AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SXqnZbeNLF2ZdlD4KBCHsqydF9ej2WwGp4YdTsCVEQc=;
 b=NvwQ3V2wiDwdAQeHX0SZi46KULT4tTWvgUQ73HtoCHnGBIJyyd3o7eby+zaZ91FfgR2uv1iACkBYmKedowdh54iH+M5He6Utr/2Y8buHI4HEB43qEgmtpsSpuME6WBCZFfOw2/DPapBCr2+tcv4gVlCfLxY0bMyH0gbGjOJpB3UHK3Fo0BrhLJoNggcFGpONjjzWGgPh/5wfsYiyoLBZv06r80Ji5vk3JfTMrpvyYa//Lw46mIbUEo8oGWeuXO8CJrI16Gjvc1q4LAiBkrcabIuBy4Kj6o0fLZvlBjSlPcGa8gomGpxnlRSZhxQJ9nuCqWtha048IPhRjuS4NR1Szw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from OSQPR04MB7740.apcprd04.prod.outlook.com (2603:1096:604:283::6)
 by SI6PR04MB8284.apcprd04.prod.outlook.com (2603:1096:4:231::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.25; Mon, 14 Oct
 2024 06:24:42 +0000
Received: from OSQPR04MB7740.apcprd04.prod.outlook.com
 ([fe80::7c06:41d9:f38c:e1bd]) by OSQPR04MB7740.apcprd04.prod.outlook.com
 ([fe80::7c06:41d9:f38c:e1bd%5]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 06:24:42 +0000
From: "JianfengA.Zhu@sony.com" <JianfengA.Zhu@sony.com>
To: "caleb.connolly@linaro.org" <caleb.connolly@linaro.org>,
 "neil.armstrong@linaro.org" <neil.armstrong@linaro.org>, "marex@denx.de"
 <marex@denx.de>, "trini@konsulko.com" <trini@konsulko.com>
CC: "u-boot-qcom@groups.io" <u-boot-qcom@groups.io>, "Jacky.Cao@sony.com"
 <Jacky.Cao@sony.com>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: RE: phy: Fix db410c crash issue during usb_stop
Thread-Topic: phy: Fix db410c crash issue during usb_stop
Thread-Index: AQHa9RistJEm/ZGpwkW7YAl9XzKglrKGGQyw
Date: Mon, 14 Oct 2024 06:24:41 +0000
Message-ID: <OSQPR04MB77404CDD74F2854369E1EEA990442@OSQPR04MB7740.apcprd04.prod.outlook.com>
References: <OSQPR04MB774067EBEEADD714EFE18C2A90882@OSQPR04MB7740.apcprd04.prod.outlook.com>
In-Reply-To: <OSQPR04MB774067EBEEADD714EFE18C2A90882@OSQPR04MB7740.apcprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSQPR04MB7740:EE_|SI6PR04MB8284:EE_
x-ms-office365-filtering-correlation-id: f494686f-957a-4b62-e7db-08dcec18e383
x-proofpoint-id: d8690225-876f-412f-87c6-a7cb45557a4c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?JqPZ7qpHDiMSKjP/2F+eOIkEhj31SvOELHh9PvDDA4ox5ZlTI0LTuwYSY05M?=
 =?us-ascii?Q?rYy9535Jcc+YuQf3HfsvC0rthO9hnZOgqQJcCt4fExjiYZu8zBObJcbB5BWh?=
 =?us-ascii?Q?apv0JjIpmRbd9Zl6eYmN1F8gRl6aJ8p8hYiSL3R+xcOTNtLOANbNZ9uLqFz1?=
 =?us-ascii?Q?RaGZHTfDXGOJudATr5dv5VQHjVmos40DSg8zIaBxFqh6sL5QNYcu6W1/Q4fI?=
 =?us-ascii?Q?oXU7hH60ZOoejUanJbUTKITCqsIYMDjuyZs8fyId6E8+DsRkUhnaMOxjX2ll?=
 =?us-ascii?Q?/J8xM/OSOqvcpAMge1sbRyk/0gG4a5EITks4b8xzPrnXARRI+BgyTI0V57ez?=
 =?us-ascii?Q?bHmmZuXB1jQE8E5udEj4OFEXhDbFzN7mE0xwrfhSA9h/t5Ay17IkGqVhKDOq?=
 =?us-ascii?Q?rAfxH8n1YZr/tcLttAubqyKmw51UNSoHjzBDgXZRuxdv6AAp81zJmeFzL0Ho?=
 =?us-ascii?Q?PrJ4II3DyJwOvTog0CsN4Z69pFQedsWOmb6SUpOGS2axwtU9x0ounValEj42?=
 =?us-ascii?Q?bE7B6ng+AFJiW1OHM0W/iXuU2xSTnuhl2P1Fy2UmA4WOVWo23BKsr5JxLK9R?=
 =?us-ascii?Q?1i7gcxK2IjcBqxrZtYpa591E24r7ZP1onHECMAFZSFIFt5btBZvjuzIpybWy?=
 =?us-ascii?Q?djPSNarQlj0ySdr41S7CHhN1HZDCnfimujrcPi8A/ojLjp98D0AbH79KXFbq?=
 =?us-ascii?Q?MiWo8Zk3lulLiqVl1xS4Ht05iRBVM5q81qImIVIVCr9O6sARmxYXfvhv4P6P?=
 =?us-ascii?Q?Qoa1E34clJrHUgUSZhzgYYD95jzu3bl+l0v9REK4iMF2lh/7UiooD1GlK2F2?=
 =?us-ascii?Q?zTYt8Dr78EtIRW0IjNjjzMUirjIlf0CEooMpkFp7Khci/CU2V7nu57na70Yu?=
 =?us-ascii?Q?MgQKCt7+fp2Q+2m31T2O4HMoHAN+593/JCDWYrErO3P2npNJvmFrr8hJn+Nl?=
 =?us-ascii?Q?XEJ/jgjFRXFp9L7bCo1V3n0S+1S0hjbnr2Dh+p1ENnscKafAD0Ucnt4kiZBM?=
 =?us-ascii?Q?uZkUG024o2b6J2Cj9p1v927daKafRnhVto/4t9v+4v3rvzM0xJU6PjTG//1W?=
 =?us-ascii?Q?2X/yNfb1KFqq7q5X7xPhgfHCswbJOZ20L+wTkqKdX8CRbiy4UoGPukmPFNrs?=
 =?us-ascii?Q?ZTFuumqCVrUexHMBz+d6ez52e6Bj6Cn1z8kxvCFhaQV0zddLpT7PZCRoSn+B?=
 =?us-ascii?Q?214qcDid/iroxIso/9uvYjth67EzutECRz/xmNtyTwD5zubur01NVMTyP/JT?=
 =?us-ascii?Q?Nb3EutlxdUjcQCLkKNz2iR+cd8MsIx+EmGVKXJAoxBmm74oaZM8Lv4rkcFrF?=
 =?us-ascii?Q?couz6ofcrR8aqkK3JCpptYebW9cYGmFixI2L9CxUvSqZWQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OSQPR04MB7740.apcprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zkT1TpiTtoDbp9iccnLzdvcgHjgXLugDUlza07H13lE9PefrhFD/leSveWao?=
 =?us-ascii?Q?AH43l0og2DBqXon2FLX3Ycombo7oZ084Ic/F22r8MzXS2ti5A4r2wd8G9UXL?=
 =?us-ascii?Q?pe5R68LXQu+GHqtZZJtUzFNfJZDWa/5Q+2xzOP8BeST1mK6eCqYlzlPODs3Z?=
 =?us-ascii?Q?fyzd9QGghhRvw991gMqXH9jxutSF9DHTKtr0a6JmOdWK2C7vEL/DZepV1qKI?=
 =?us-ascii?Q?yJHvf/mco3aWgysdXfYYxJ3Flfo9/3Ukw2A7MSf0sVCpt5RmTnTdsqBH7zeN?=
 =?us-ascii?Q?2WE1WISLQXA8JW1g1twXKYhhj5Ki4AReNh2czEH4EjU5YWllSKZnvZnNCX3p?=
 =?us-ascii?Q?xlRvIF3YngGSz/1mZC9w1Q5NHeJbtE1VoiTgAy1TDqXuouTH2SFFe0MpsAPF?=
 =?us-ascii?Q?hh3ttrbuUcPZ6wubaDRkgYVYBfMRNFhJHwf3YxNIecav9uMfZYWOCKsyQ9V5?=
 =?us-ascii?Q?Tdml+dTOfBG7wp/x3kL21agA/8Ka7uk98q+vrfNJOIw7tFUnm/PdoxWjPmCb?=
 =?us-ascii?Q?QyzH5RLavdF7XalYadq62yMv7SxA3+tUWTD5XZaq0CvcMm6aI1yMd46bO8SB?=
 =?us-ascii?Q?E0vJAiYD3I+4XA9bZJyrHlE0IqPfP0Nytq+1TOKkkmmUb9m4TP310OgmyqPr?=
 =?us-ascii?Q?Y6UW4LM2FSJYe3dvioQl4KRLjt0/BHnIjMShINGA3Da3oiunjy0hmrsP+4DT?=
 =?us-ascii?Q?I+B3gV/PYV8AX8Nv3dGFO4066c/AJGlQmmlmqUQCxa8TH/8yot+f3DVTAwvX?=
 =?us-ascii?Q?wnFHj4c2l5HSKJIhhYxqvruouRIxpsL6vpW8joTY9A0z5+lxUvkNCzfmNnEv?=
 =?us-ascii?Q?miW55iXDQ2s/xGf9FVxwYf5XwZzotpmUU4GaZecwU4dMjeiqllzAslgyCYbO?=
 =?us-ascii?Q?bj9vbaZ8EIwJ99uEZFlbyK9H5KCIMDllg8nX1pBsNW7qIDAZRzMAjfPxdTjW?=
 =?us-ascii?Q?wOdT42knGOFm/Z5mDkhQ938k8ivPCcE0e3Xj+0Ma0JQCVjQIz7KuDXHoAS8c?=
 =?us-ascii?Q?tKoRA2WAU42D0DYsJNWcupdVKCdyMkoJbkDOhV01g4j+3hoKOJpDokm51AiB?=
 =?us-ascii?Q?ih1G/NQTtryiIDSgBy4ttwwUC3ZDFoPQobrOJT3wI2SGCpU6apMtPj/lE+fY?=
 =?us-ascii?Q?1CjXKloIFe1ZjXDjOWK2dRO8PHfbIJwVkq0QSFOuyq8DR0uOXdkLiYAmapzH?=
 =?us-ascii?Q?9vNjDJhQVbtQcxFpoi7XwymoJuxjwoqGFDpYfAqnt2oHPhYJj1KArPFfFK1C?=
 =?us-ascii?Q?daAirnG5NzFe4k4M7jB3vbL8Uu5d2EdbUlI0GlmrxLQt9xbHFch1eTnxdWta?=
 =?us-ascii?Q?ysuhPXydP/9YR9np79U/7EvWa46QE4d3Hhmzasy5jBARBE8PPOf+BXyFRodj?=
 =?us-ascii?Q?ykqj7er18qFB2IZcBywhsLYziOf/nkoQbUidLvrnyTLORtz/R9qcel3lJFtt?=
 =?us-ascii?Q?lWGOKPDxsHY42pCl52ENJYu1fm+WaYI59Ixy8lMjF4ECBp5yDIDgJm666o+A?=
 =?us-ascii?Q?8hPdAcCvTfrslISnZyVUBm+4jdHrQAe2AzxdxmiGE0wU06Jl4F0hGtoEQ4AF?=
 =?us-ascii?Q?27bG0Eu/38b6+c41tVQsgaipofGxwUQW/cFf8aun?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: kZJ+rBK1lBb/yNYKdGkbz3OtYbcxmwLdotN7Z36tYLWXSviSuXzBvSoIfv+/lrI5hQNNKEXaMdUoGiOHE84qsYpruATY83uHRfn978Bzw8s8zaJWpa5euULNQxjYu325j1Qj18ZwWy5EaLLtHnmN/d+xqI55JKZaZYXujHXSXSa3XRCZ9sBqta0yppGMd7z4zdOrnTr7hFQzzedgCrEUYrSDk4Z9NJiBjyhZuqonD32z5ZqbuCT8WQ5o3eS6HNLSOcz40DbTWfum6EOeshYPRSfXIVdQy6bG9EgI/G3PDtJhJ3kw28ZUPp/pcqV1dlRo+RQBWjmEp2iKSRFiWGdrpId9unNTffEXGGrZ9yb8ffMDUJEGAYVOE63Awe3tStnek6PySd52ioeD98qJ19uTQWBBeJ0lOSsX1r+uW1dz/SFQYQOnZ+bObI042AwXVjXNe1Bwv80vb08BukqTwbw75Bz2jkpwvpFb/+QpPCcgiWDgYCzHS+/Kl4nfG4mCiXT7LiylyZEjcJ3Olz9SwguGnwwCbPut1ocgezAzeEjvuk8MQ9CaP88kDblsCOxc5cHpcd/ZDNPiLjJqwl+cInfVrj6WAee4fyaUSJtko8ZDdMRiyKuI9M9ALGNMiFGj0Sx+
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSQPR04MB7740.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f494686f-957a-4b62-e7db-08dcec18e383
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2024 06:24:42.0055 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fIhHoVcfzKp07mciVmBnmHe6vCbepOk1VaSwguSps0v+0v3wJJOUKm3Wil+Cpaijrc/94kAfmrnnX1Dlq9hvKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI6PR04MB8284
X-Proofpoint-GUID: lTI1LzUVmL7yLd3quvNm_czMjVb9yqSq
X-Proofpoint-ORIG-GUID: lTI1LzUVmL7yLd3quvNm_czMjVb9yqSq
X-Sony-Outbound-GUID: lTI1LzUVmL7yLd3quvNm_czMjVb9yqSq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-14_05,2024-10-11_01,2024-09-30_01
X-Mailman-Approved-At: Mon, 14 Oct 2024 15:03:22 +0200
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

Is there any update on this issue?
I found that this issue still exists on the latest v2024.10 u-boot.

-----Original Message-----
From: Zhu, Jianfeng=20
Sent: Friday, August 23, 2024 1:00 PM
To: caleb.connolly@linaro.org; neil.armstrong@linaro.org; marex@denx.de; tr=
ini@konsulko.com
Cc: u-boot-qcom@groups.io; Cao, Jacky <Jacky.Cao@sony.com>; u-boot@lists.de=
nx.de
Subject: phy: Fix db410c crash issue during usb_stop

usb stop crash log
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
dragonboard410c =3D> usb start
starting USB...
Bus usb@78d9000: USB EHCI 1.00
scanning bus usb@78d9000 for devices... 4 USB Device(s) found
       scanning usb for storage devices... 0 Storage Device(s) found dragon=
board410c =3D> usb stop stopping USB..
"Synchronous Abort" handler, esr 0x96000007, far 0x0
elr: 000000008f636a28 lr : 000000008f636a24 (reloc)
elr: 00000000bd97ea28 lr : 00000000bd97ea24
x0 : 0000000000000000 x1 : 00000000bd1494d0
x2 : 0000000000000000 x3 : 0000000000001f40
x4 : 00000000bd131990 x5 : 00000000bd157b70
x6 : 0000000000000041 x7 : 00000000bd163b80
x8 : 00000000bd131db0 x9 : 000000000000b65c
x10: 00000000bd13183c x11: 0000000000000006
x12: 000000000001869f x13: 0000000000000061
x14: 00000000ffffffff x15: 00000000bd1317b8
x16: 00000000bd9b78ac x17: 0000000000000000
x18: 00000000bd143d90 x19: 00000000bd1575d8
x20: 00000000bd1575d8 x21: 00000000bd157440
x22: 00000000bd1493b0 x23: 0000000000000002
x24: 00000000bd9eb910 x25: 0000000000000000
x26: 0000000000000000 x27: 0000000000000000
x28: 00000000bd158540 x29: 00000000bd131980

Code: f9400000 b4000120 97ffdd1e aa0003e2 (f9400001) Resetting CPU ...

resetting ...
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

After commit ed8fbd2889fc ("dts: msm8916: replace with upstream DTS") msm89=
16_usbphy will be defined as a child device of usb@78d9000. When calling us=
b stop, usb@78d9000 will be removed. During the removal process, the sub-de=
vice msm8916_usbphy will be removed first. In the subsequent remove process=
, the uclass_priv_ of msm8916_usbphy will be accessed again.
Because uclass_priv_ is NULL at this time, it will cause a crash.

Detailed calling process
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
usb_stop (drivers/usb/host/usb-uclass.c)
|-> device_remove(bus, DM_REMOVE_NORMAL); <=3D=3D remove ehci_msm
.|-> device_chld_remove <=3D=3D remove msm8916_usbphy . |-> device_remove .=
  |-> device_free(dev);
.   |-> dev_set_uclass_priv(dev, NULL);
.    |-> dev->uclass_priv_ =3D uclass_priv; <=3D=3D uclass_priv is NULL
|-> drv->remove(dev);
 |-> ehci_usb_remove
  |-> generic_shutdown_phy
   |-> generic_shutdown_phy
    |-> phy_get_counts
     |-> dev_get_uclass_priv
      |-> dm_priv_to_rw(dev->uclass_priv_); <=3D=3D NULL pointer access =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Fix: move usb phy power off into msm8916_usbphy remove.

Signed-off-by: Jianfeng Zhu <JianfengA.Zhu@sony.com>
Reviewed-by: Jacky Cao <Jacky.Cao@sony.com>
Reviewed-by: Toyama, Yoshihiro <Yoshihiro.Toyama@sony.com>
---
 drivers/phy/qcom/msm8916-usbh-phy.c | 20 ++++++++++++++++++++
 drivers/usb/host/ehci-msm.c         |  4 ----
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/phy/qcom/msm8916-usbh-phy.c b/drivers/phy/qcom/msm8916=
-usbh-phy.c
index 4b435aa2a6..0ba520c93d 100644
--- a/drivers/phy/qcom/msm8916-usbh-phy.c
+++ b/drivers/phy/qcom/msm8916-usbh-phy.c
@@ -46,6 +46,25 @@ static int msm_phy_power_off(struct phy *phy)
 	return 0;
 }
=20
+static int msm_phy_remove(struct udevice *dev) {
+	struct phy phy;
+	int ret;
+
+	ret =3D generic_phy_get_by_index(dev->parent, 0, &phy);
+	if (ret)
+		return ret;
+
+	/* To avoid NULL pointer access exception issue, move
+	 * generic_shutdown_phy from ehci_usb_remove to here
+	 */
+	ret =3D generic_shutdown_phy(&phy);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
 static int msm_phy_reset(struct phy *phy)  {
 	struct msm_phy_priv *p =3D dev_get_priv(phy->dev); @@ -105,5 +124,6 @@ U_=
BOOT_DRIVER(msm8916_usbphy) =3D {
 	.of_match	=3D msm_phy_ids,
 	.ops		=3D &msm_phy_ops,
 	.probe		=3D msm_phy_probe,
+	.remove		=3D msm_phy_remove,
 	.priv_auto	=3D sizeof(struct msm_phy_priv),
 };
diff --git a/drivers/usb/host/ehci-msm.c b/drivers/usb/host/ehci-msm.c inde=
x ff336082e3..565859e806 100644
--- a/drivers/usb/host/ehci-msm.c
+++ b/drivers/usb/host/ehci-msm.c
@@ -114,10 +114,6 @@ static int ehci_usb_remove(struct udevice *dev)
 	clk_disable_unprepare(&p->iface_clk);
 	clk_disable_unprepare(&p->core_clk);
=20
-	ret =3D generic_shutdown_phy(&p->phy);
-	if (ret)
-		return ret;
-
 	ret =3D board_usb_init(0, USB_INIT_DEVICE); /* Board specific hook */
 	if (ret < 0)
 		return ret;
--
2.25.1
