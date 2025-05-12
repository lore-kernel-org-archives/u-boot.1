Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D8FCC3ABCB
	for <u-boot@archiver.kernel.org>; Mon, 12 May 2025 01:27:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A05A68091A;
	Mon, 12 May 2025 03:27:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="A/ZJqfHi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE0B580F03; Mon, 12 May 2025 03:27:13 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E328A800C1
 for <u-boot@lists.denx.de>; Mon, 12 May 2025 03:27:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tOQQ8apQAJ90Rcgz0zxwlanNxK9+Kl9+m3eDRU4/TCxuHShxXUdHUFlRjGG7zSs/TuvKRmW/EJfEVBTQcNbmSh0GqjWJ5rtbhx8UvWcR0F0Iw66VQWx3qQgTL4OHCKfeD1lnku/HceYNQSFExUrlubMfZ6OZOej5Mr1hwnlIN3qJam9tmXr9OIdS5q0Aq1YNVPBlP6OetXixMpnLoTXJ5xru57NYR5P+FrqsiTE20FBQEmTDJpnAg5u+uKR201NVPy5AVGw2TyF9E1vwoQvoYkN2iXz8qarYCIOj+Xf4d1vdvWEmZ8MjO7IcYpaUn7l3uxuzC9e579cvYJvuCnB/Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n+xWWL6ComwBOE52SNrtn/mYXRW3j2Ny+FnCiyV105Q=;
 b=toeFBPHibm9WfT50zLK3QM/KfjfJnd618OTnsX3A8sLs6VAdTCRZINu1V1Ya1w0UGV6cPIgFbyROhMV37Om7WadC/IqDR5ukvBvYcTWELqhYmm+VobSYpNK1JDemVhOiAm1xHWXUaaFINtKZlEjyvLJ+ArYQZCZXVT9aWWMq/+L+lADritvPw7ka5ipJymCXxjY+KYhPRl+lMRUIgmgjF/G8jLIcZcP1pMc10BGPrEFTWsNMneb33HI8gmRWuUJARqbM1krvMlqstN3s18Fb9ly2ZMhyaFD2UXrHKaah0yatE8w4RQ/bBOwK5uji9olTAQDX5fAi/yTa0DkX73wCIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n+xWWL6ComwBOE52SNrtn/mYXRW3j2Ny+FnCiyV105Q=;
 b=A/ZJqfHim3whVcrxO5q7GEErxRemo7JrnJHRkJol0y0sjHnYRUBBmbWhbiY5bdj0re6YUjQfETFfFf/2bZUKFeHJJSIINKZeQ77/iUuAQX+qw/MR+0UPvtsJeS3ZYmIphbhx6OaEHE3ihXJ6fFJQMVFMYZw+/3myIK+qmZIdYfqITJuKTWFuUJcgE8uK4kieAiHHvqpXSMA8L2ObqGl069EIbLJgeOJ6DM0Kn3ZOqPkzpK80L7Wf4rPf7+3GNHYRby5T7Q27W57+zK0SINMFzIKvWZZjCgUpPvfq965RK7G6NFwIxdAROpFep+FT6GkPcTg9RHnWteZOEEMSOQJYuw==
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AM8PR04MB7812.eurprd04.prod.outlook.com (2603:10a6:20b:245::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.28; Mon, 12 May
 2025 01:27:10 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.8722.024; Mon, 12 May 2025
 01:27:10 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: Heiko Thiery <heiko.thiery@gmail.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>, Marek Vasut
 <marex@denx.de>, Alice Guo <alice.guo@nxp.com>, Ye Li <ye.li@nxp.com>,
 "tharvey@gateworks.com" <tharvey@gateworks.com>, Michael Walle
 <mwalle@kernel.org>, =?utf-8?B?VGhvbWFzIFNjaMOkZmVy?=
 <thomas.schaefer@kontron.com>
Subject: =?utf-8?B?5Zue5aSNOiBbUEFUQ0hdIG5ldDogZnNsX2VuZXRjOiBmaXggaW1kaW8gcmVn?=
 =?utf-8?Q?ister_calculation?=
Thread-Topic: [PATCH] net: fsl_enetc: fix imdio register calculation
Thread-Index: AQHbuCRXmigJBC4eS06Y1rLCGKTYJbPOSViA
Date: Mon, 12 May 2025 01:27:10 +0000
Message-ID: <PAXPR04MB964469FCD160C5C736CC5DF9E297A@PAXPR04MB9644.eurprd04.prod.outlook.com>
References: <20250428095945.1432389-1-heiko.thiery@gmail.com>
In-Reply-To: <20250428095945.1432389-1-heiko.thiery@gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9644:EE_|AM8PR04MB7812:EE_
x-ms-office365-filtering-correlation-id: 3f5500e7-cc9b-49d3-3385-08dd90f41dbb
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?b1Fjak42b00vWU9rZVJVb1hFVjc2SDFzUy9yWHlMR2djQU0wejNLVENYTXhR?=
 =?utf-8?B?VTFkTXB6UmgxYWdJU3pZOUNOUnZDZGFnd2h4Y3J5V2xjV1pud09pRzdCMXQv?=
 =?utf-8?B?WlE2NFVTMStlVzVDTkY2N0ZRcTNHMlJGSjl1d29mK1hQRmtoUHFtaWFwa1Rw?=
 =?utf-8?B?dkx2NjJDNUxqSlFLbVpZTS9vRXlRRy9ua1BOcGV1NTFmQUprWG02cjZkeTFu?=
 =?utf-8?B?QnpNMTI4YkxtS0lncytmcGUrZ1UrMWorUlRXMXFCSlFqZXV4TCtSWWY3NkFt?=
 =?utf-8?B?THdScE02Zjl4RXZxWkpNcldTcVJQWWhxWGN5aUlXZ2hqTWdBWTBUOE5oNDhn?=
 =?utf-8?B?Wk03UnE0WXNjaXc4SDZmeExsZ3BKa04vcnA0d0t5OEo0aDJLN3Yvb24vZ0lV?=
 =?utf-8?B?Sjg0WTJhaFBGZEZsTE5kb2FYYnAzaWwrdGNvOHdRQnJCQ0c4eFFRTlJOcURV?=
 =?utf-8?B?dldaQko1anNBOEc4akRYOGJTeU5GNm83ZzUzR3BXbVN0VmxLRmZkL1llODI1?=
 =?utf-8?B?SmpDU3JBbnlZeGM2SkZuY2N5d1BobHdTaVRWVTFOOGJZbnJVV0J6d0RheGQr?=
 =?utf-8?B?MElPZlBIK1g3NkFYQTUyTlZ3UEpOVWRPZFlZNG53cEh6aWRpTHQxWEF2T0g4?=
 =?utf-8?B?clRNWVRSeWQ4SXFrYTBYSHdPUnhJQWhqcyt3ZnRIZVZ5MWVXWDJLU3dPd0g4?=
 =?utf-8?B?QWswOHlTWEZackFCUjAvc1pxQnp3RU44c2dmZzhiZ0FWV0kwdis3dW56enZs?=
 =?utf-8?B?c1A4ZW9TeHJVazArZGtwWlA2cXBFQWVxbDN6aHBlc01XTy9HbE9acmh0OENH?=
 =?utf-8?B?VHBHdjM2OTYvdk9XZC9ydm1VSnRRbzQ5aFV6Zk9JUEhTa1pvSUFzWEhYaEVO?=
 =?utf-8?B?QkZYRFJQaU1DU1Urc2I3dHpoRVdTWWFoMlkycjhIL0k4UlJWQUtpNlo3bzda?=
 =?utf-8?B?cjVEQ1hDNzROeG53ZW91eFp4TC9qc2RqVm5tK0psR3NiSUpuRXM1RmdBekFt?=
 =?utf-8?B?bG1hZmhvS1U5SFN5Q3QvVzdUamhHUEVDejhoVXA4Z0hWUVF0ekxERkZWT2pk?=
 =?utf-8?B?OFFFd0dNdmE3dWRQdWcrSlVyc1JIU3pTRWlYR2NWMjJ6ZExyYkJ1dCt0a2hD?=
 =?utf-8?B?MUN1dXlTK3dqUzloRlNpd2htY2ZtR3d0c2pxZVFGOTJYQ2hhUkFhVTlYYit6?=
 =?utf-8?B?TGZhWE9BN2ZLV2tXUHZJMDdyMlZLTGdBd0FIQkorQmZGZmFlVjFyYStQSWhG?=
 =?utf-8?B?QWhqK2ZjRVZ5TXVQVTh3YmF3Q2wwbXdqcmVZTXpKNFFMNjlQOXhMc1dDN1Bh?=
 =?utf-8?B?czlxSFN4Z3Q1UUhtd0xDYWZjQTRoMVYwR1VnRjZlcUh4ZDM5NFdEaVYrL2hR?=
 =?utf-8?B?Nkg0cTFnQUV6aTMzenFHSW1SNlY2MUZIRXI2cnAwcytFazg0MXZEZkJzWEMz?=
 =?utf-8?B?OWZNVXJYVHVZSzg4cTBhNysrSzNXc2VPTGY0OG5oZjJ6U1k2WlVyeHNJSE00?=
 =?utf-8?B?ZDRyc1FpWnAyNGZoQjV4UmlsSEdSM1dOUGgrTThFZktVVWJ5cjU4Vk5BWlha?=
 =?utf-8?B?cHdoVGMwc3FtRVEzZ2NTOTIzcXZwL1NQbEdZOEtKbFlOQWphWkUrNWR4YjlD?=
 =?utf-8?B?amNPcDUra3FjWVkvZ3lUOWtTaEd3MGNlRlIwQjh4UGRSa0ErRXFwV1RqUy9q?=
 =?utf-8?B?OWtRdk9BeExJaFprWlhNOURobWM4ZzBCaXg2RFZMMzAwU3JKYUdYa2YxK2du?=
 =?utf-8?B?SC9Ma1l0bDNTUVpXVUJYNkIrUzFqS3Vkc3hEaFcxTHBwamFNZ01KUDREWTJp?=
 =?utf-8?B?MHRPR1gwYVVBL3lGdUpZODg3dmtnTnlHdHpDZHY3eURKalR2T3RlTDZKYURr?=
 =?utf-8?B?SHc1bDR6NVRVS29ZYzVDeG1yQktVWnRNcXJFTmxoUkVYNmxQK0JEUWZRVnAx?=
 =?utf-8?B?eWxTR1B4T2tuQjJ4TVRyeHRZN2NsRW1zRkdYa2t4M2ZVbUlRR2JxVUEybmxU?=
 =?utf-8?Q?djBUhRKxgsJi6xE6TgxUly4u4p4u1I=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bG5RSko3OHA5RjMwZXgwUjB6RkZYdTg0S3lPYXNRUDhPM0R2YkRDa0VId2NN?=
 =?utf-8?B?MDJabENiRnpHbVdSQ3dFWW45anlXVkt3b1F1dEpES2pISGtFRGdnekRwL0Rk?=
 =?utf-8?B?djQzMEwxeTVnZGdhTUhlcVc2NmFCcEI5MkRsVU1pQWQzSGh3K1JuWXZaNWtq?=
 =?utf-8?B?S2dubnQvNmVYK1pnZk1kOHVIRkpSbVFrSWRNc0JLb0lNSW5FQzNXSVBLVEtK?=
 =?utf-8?B?MkV1eVhmL1hiRzNJUG95aHNxZk5pa0ZvOXV3ckI0Q2RtelZmTDBJbnE2RFY3?=
 =?utf-8?B?WkNUbkQ3c3p2Wm5wVTY1ZXE5MXVjNDZ0dVB3anRYQXpVYXJ3RDNUaUJYTEV3?=
 =?utf-8?B?cjBXVk5wVVZsbTVDMHVzSEdXcFBnTGI5cEpwaGdVaUtadDlEblZxTTVjbFpD?=
 =?utf-8?B?aFdZSlVkamFHQzg1SVhSaXhjWVNrd1FDeHlDUkdSbFNNRlA0TzR3MzZaZFFX?=
 =?utf-8?B?NXhxci9QV0R4cGFkVnduRUVYWHcxUE5ZNWJaRHlJRFhmQzNzdUMwQmgyZFBL?=
 =?utf-8?B?dmhOR3daVG5mejkvZGhubmhzY0Y1M2hoemhicStrRklqTjFuTWF1RG5YckE3?=
 =?utf-8?B?MHVic3R3ZmRIQlo4VlVLTktpMjhRc095WFpGN0h5cUJUWmhYYzlabHJmempL?=
 =?utf-8?B?cXpIdmh4N0ZPRGEwcUVKUXcrQm9OOHFTTDYwWExManJpMWMxdU1HQ0tkREJy?=
 =?utf-8?B?N09KQzE1Y0JaNGNWUXQrZGd4cFl2R2t4dDMwM3ZRZEppNUd2dzRva25VZHFM?=
 =?utf-8?B?UDZ0L0VldllnYW5SSXZIeElXbWJ1ODZpdlFxd29QWVVoRy8wekhwMXJ2cjdO?=
 =?utf-8?B?YThFQWFFV29OU2w5c1ZQb1VIeGlMdTRSeTZzU29JZFJaMWlHYWxheDFkQ3Jj?=
 =?utf-8?B?dDhtb1NleExwSFNsMEJJb3FLeXNUM3hYdnF3NmlVK25VdG1iUHAvQ2ZaUTFG?=
 =?utf-8?B?WWZYSlJFLzlabzJMS05rcnZZRW9OeVNlQ3JML1Z4MXZWSUM5cG9RUjRPT1Yz?=
 =?utf-8?B?QUwwRjhNbXllQVV1WTFPT2kwNGJDOVM0RGVDSWYzU1R5d0JucDdsdXpBV29L?=
 =?utf-8?B?djNwWVhoZnBnVTFpcmFjUFRzV2N5YkxEZmlLamtYbHlEWWsvbDlmVVdYdWpJ?=
 =?utf-8?B?VTVibUNqOWRqdHgrTDBhWHpidmhINmdYaUNyRjdHS0RxdmU1Z3docWJXeXJX?=
 =?utf-8?B?Rm5xcmZlM0NQUmpkZUFlTFZGYWRHSFVRTXpJK2dHVHBSWmI2SDBVK3ZJYXpr?=
 =?utf-8?B?WVJLcW5SMDY1c1VYY1ZzV2tPb3BTQzlTNFpRNnZKTVI2cE50c3VJSWFJWUZU?=
 =?utf-8?B?SlIxYTVWZHdOMUhNQ2czbGhXMXJJV0VObVk5YWpYWVpTMDBJWkdiU0ZCZzg4?=
 =?utf-8?B?YzNQN24xRjZZY2ZVVnlpQktKVWdjdjRtKzdLOThaSlB0ajJsR1JxTDVjMEoz?=
 =?utf-8?B?M2ZaZFZBakQ0MUwxeHZLblkrcDNQZnJJZ2NOa2FXOTZXakp6bzgzL3JobmpG?=
 =?utf-8?B?TGZXL1dLTGxnRHdGdFBGS3FFZGRXbWlUUmp2NHJ6bHhCVGluL0J0ZFRDNERI?=
 =?utf-8?B?SG52VU9kU3R5SXV3QjlVVGlycUtqckU4ckplQmt4ZDEzeVVSSDhSQ0dINGZP?=
 =?utf-8?B?YmVXZ3N2dG1wL01GR2NJQ1FiWWJqTnFjU3ZjSHdDbURGemZTZExrb1FWbnV2?=
 =?utf-8?B?K2NFUGRZYXJ5dURLSWp4ZXZWRFpycTFISkUzVnkrTm5RRTFYaTZsT2xwWjlN?=
 =?utf-8?B?RFNzTERSWWVnNzE2TGhOQWxXQWdEUHRMM1o1ZnBxeERNUjRMQ2JITjdvaGdj?=
 =?utf-8?B?TERadGdsalRwRTBUTzdndGg4NTArVTRqUWZXWnl5ZEtaRTJ1U2I2amQ4ekNs?=
 =?utf-8?B?VVNIaHB0aEgrc2V5ZW1uYzM5dXY2aTJleFdCUEVpTXdWWi9ENjM1MnNldHJG?=
 =?utf-8?B?dkZWbE1VeHltQkduK3VEZVl1cFFjQldzVDgzMkIvMFZVL09WSzlGcjRSeUdy?=
 =?utf-8?B?NlEvNXZkaXNEUUtiMFIxa1NUSjFpZXVQaEpkZ1NaQ1o3QlJtRzc0RTdnMHdm?=
 =?utf-8?B?aWlZTy9yaEZHVlhMVldxbjE4YXUvbDNkUmU3SE9UdDI3Q3ZaaEYxMWcwT0lv?=
 =?utf-8?Q?j7pRKVK5/hdVbQNxapq12/kXT?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f5500e7-cc9b-49d3-3385-08dd90f41dbb
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2025 01:27:10.1213 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7114c4klFhg49SLXUhshwTtGaI4zJBcpXGaWz4eiAhRWOn5ptn9YWYBK/zflRwzV/Kw1EWVSyBZ46m0DNLI7CA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7812
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

UmV2aWV3ZWQtYnk6IEFsaWNlIEd1byA8YWxpY2UuZ3VvQG54cC5jb20+DQoNCkJlc3QgUmVnYXJk
cywNCkFsaWNlIEd1bw0KDQo+IC0tLS0t6YKu5Lu25Y6f5Lu2LS0tLS0NCj4g5Y+R5Lu25Lq6OiBV
LUJvb3QgPHUtYm9vdC1ib3VuY2VzQGxpc3RzLmRlbnguZGU+IOS7o+ihqCBIZWlrbyBUaGllcnkN
Cj4g5Y+R6YCB5pe26Ze0OiAyMDI15bm0NOaciDI45pelIDE4OjAwDQo+IOaUtuS7tuS6ujogdS1i
b290QGxpc3RzLmRlbnguZGUNCj4g5oqE6YCBOiBKb2UgSGVyc2hiZXJnZXIgPGpvZS5oZXJzaGJl
cmdlckBuaS5jb20+OyBSYW1vbiBGcmllZA0KPiA8cmZyaWVkLmRldkBnbWFpbC5jb20+OyBUb20g
UmluaSA8dHJpbmlAa29uc3Vsa28uY29tPjsgTWFyZWsgVmFzdXQNCj4gPG1hcmV4QGRlbnguZGU+
OyBBbGljZSBHdW8gPGFsaWNlLmd1b0BueHAuY29tPjsgWWUgTGkgPHllLmxpQG54cC5jb20+Ow0K
PiB0aGFydmV5QGdhdGV3b3Jrcy5jb207IE1pY2hhZWwgV2FsbGUgPG13YWxsZUBrZXJuZWwub3Jn
PjsgVGhvbWFzDQo+IFNjaMOkZmVyIDx0aG9tYXMuc2NoYWVmZXJAa29udHJvbi5jb20+OyBIZWlr
byBUaGllcnkNCj4gPGhlaWtvLnRoaWVyeUBnbWFpbC5jb20+DQo+IOS4u+mimDogW1BBVENIXSBu
ZXQ6IGZzbF9lbmV0YzogZml4IGltZGlvIHJlZ2lzdGVyIGNhbGN1bGF0aW9uDQo+IA0KPiBGcm9t
OiBUaG9tYXMgU2NoYWVmZXIgPHRob21hcy5zY2hhZWZlckBrb250cm9uLmNvbT4NCj4gDQo+IFdp
dGggY29tbWl0IGNjNGU4YWYyYzU1MiwgZnNsX2VuZXRjIHJlZ2lzdGVyIGFjY2Vzc29ycyBoYXZl
IGJlZW4gc3BsaXQgdG8NCj4gaGFuZGxlIGRpZmZlcmVudCByZWdpc3RlciBvZmZzZXRzIG9uIGRp
ZmZlcmVudCBTb0NzLiBIb3dldmVyLCBmb3IgaW50ZXJuYWwgTURJTw0KPiByZWdpc3RlciBjYWxj
dWxhdGlvbiwgb25seSBFTkVUQ19QTV9JTURJT19CQVNFIHdhcyBmaXhlZCB3aXRob3V0IGFkZGlu
ZyB0aGUNCj4gU29DIHNwZWNpZmljIE1BQyByZWdpc3RlciBvZmZzZXQuDQo+IA0KPiBBcyBhIHJl
c3VsdCwgdGhlIG5ldHdvcmsgc3VwcG9ydCBmb3IgdGhlIEtvbnRyb24gU01BUkMtc0FMMjggYW5k
IHByb2JhYmx5DQo+IG90aGVyIGJvYXJkcyBiYXNlZCBvbiB0aGUgTFMxMDI4QSBDUFUgaXMgYnJv
a2VuLg0KPiANCj4gQWRkIHRoZSBTb0Mgc3BlY2lmaWMgTUFDIHJlZ2lzdGVyIG9mZnNldCB0byBj
YWxjdWxhdGlvbiBvZiBpbWRpby5wcml2IHRvIGZpeCB0aGlzLg0KPiANCj4gRml4ZXM6IGNjNGU4
YWYyYzU1MiAoIm5ldDogZnNsX2VuZXRjOiBTcGxpdCByZWdpc3RlciBhY2Nlc3NvcnMiKQ0KPiBT
aWduZWQtb2ZmLWJ5OiBUaG9tYXMgU2NoYWVmZXIgPHRob21hcy5zY2hhZWZlckBrb250cm9uLmNv
bT4NCj4gU2lnbmVkLW9mZi1ieTogSGVpa28gVGhpZXJ5IDxoZWlrby50aGllcnlAZ21haWwuY29t
Pg0KPiANCj4gLS0tDQo+IA0KPiBCdXQgdGhlIHF1ZXN0aW9uIHRoYXQgbm93IGFyaXNlcyBpcywg
ZG9lcyB0aGlzIGNvZGUgcGF0aCB3b3JrIG9uIHRoZSBpbXggU29DcyBhcw0KPiB3ZWxsLiBOb3cg
dGhlIGlteCBzcGVjaWZpYyBvZmZzZXQgMHg1MDAwIGlzIGFkZGVkIGhlcmUgYW5kIHdhcyBub3Qg
dXNlZCBiZWZvcmUuDQo+IA0KPiBDYW4gc29tZW9uZSBwbGVhc2UgdGVzdCB0aGlzIG9uIGFuIGlt
eDkgYW5kIGNvbmZpcm0/DQo+IA0KPiAgZHJpdmVycy9uZXQvZnNsX2VuZXRjLmMgfCA0ICsrKy0N
Cj4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9mc2xfZW5ldGMuYyBiL2RyaXZlcnMvbmV0L2ZzbF9l
bmV0Yy5jIGluZGV4DQo+IDUyZmE4MjBmNTEuLjk3Y2NjZGE0NTEgMTAwNjQ0DQo+IC0tLSBhL2Ry
aXZlcnMvbmV0L2ZzbF9lbmV0Yy5jDQo+ICsrKyBiL2RyaXZlcnMvbmV0L2ZzbF9lbmV0Yy5jDQo+
IEBAIC00NzMsMTMgKzQ3MywxNSBAQCBzdGF0aWMgaW50IGVuZXRjX2luaXRfc3hnbWlpKHN0cnVj
dCB1ZGV2aWNlICpkZXYpDQo+ICAvKiBBcHBseSBwcm90b2NvbCBzcGVjaWZpYyBjb25maWd1cmF0
aW9uIHRvIE1BQywgc2VyZGVzIGFzIG5lZWRlZCAqLyAgc3RhdGljDQo+IHZvaWQgZW5ldGNfc3Rh
cnRfcGNzKHN0cnVjdCB1ZGV2aWNlICpkZXYpICB7DQo+ICsJc3RydWN0IGVuZXRjX2RhdGEgKmRh
dGEgPSAoc3RydWN0IGVuZXRjX2RhdGENCj4gKyopZGV2X2dldF9kcml2ZXJfZGF0YShkZXYpOw0K
PiAgCXN0cnVjdCBlbmV0Y19wcml2ICpwcml2ID0gZGV2X2dldF9wcml2KGRldik7DQo+IA0KPiAg
CS8qIHJlZ2lzdGVyIGludGVybmFsIE1ESU8gZm9yIGRlYnVnIHB1cnBvc2VzICovDQo+ICAJaWYg
KGVuZXRjX3JlYWRfcGNhcHJfbWRpbyhkZXYpKSB7DQo+ICAJCXByaXYtPmltZGlvLnJlYWQgPSBl
bmV0Y19tZGlvX3JlYWQ7DQo+ICAJCXByaXYtPmltZGlvLndyaXRlID0gZW5ldGNfbWRpb193cml0
ZTsNCj4gLQkJcHJpdi0+aW1kaW8ucHJpdiA9IHByaXYtPnBvcnRfcmVncyArIEVORVRDX1BNX0lN
RElPX0JBU0U7DQo+ICsJCXByaXYtPmltZGlvLnByaXYgPSBwcml2LT5wb3J0X3JlZ3MgKyBkYXRh
LT5yZWdfb2Zmc2V0X21hYyArDQo+ICsJCSAgICAgICAgICAgICAgICAgICBFTkVUQ19QTV9JTURJ
T19CQVNFOw0KPiAgCQlzdHJsY3B5KHByaXYtPmltZGlvLm5hbWUsIGRldi0+bmFtZSwgTURJT19O
QU1FX0xFTik7DQo+ICAJCWlmICghbWlpcGh5X2dldF9kZXZfYnlfbmFtZShwcml2LT5pbWRpby5u
YW1lKSkNCj4gIAkJCW1kaW9fcmVnaXN0ZXIoJnByaXYtPmltZGlvKTsNCj4gLS0NCj4gMi4yMC4x
DQoNCg==
