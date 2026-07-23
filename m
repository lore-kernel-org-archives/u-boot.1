Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 186A0C531D1
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 15:26:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AF3DF81086;
	Thu, 23 Jul 2026 15:26:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id doCUVwqzi7cN; Thu, 23 Jul 2026 15:26:09 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DCCF380EAF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784820369;
	bh=OWK+MtR0OgYCipoS+72/iJ4STA7y8cvfUhjCTozN3EE=;
	h=To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=bjhFyZ0azkt/iCg+LpOZOsalao7Iy9LrvN6C4zo2kws36Eqvnt1dZjXcDT5Mxc+nt
	 qqXThm7ibbm3iNSLPfG3zAR6PINgCcXt502PU+1r2OTvu/DsE7kHf0vLytXJoft73j
	 nUAl99+cLfMkSqVYTvlF1KWQFXDQUfwIBKTiYy/dBsR3CxUN7RQdHpy3wdhI+aUAS5
	 gVg7Iw594pRTb2nkPXZL2zC03OYYdXKtb2D94eLHyvjBvsYxmXGuRk8RCDkw5VUSDq
	 xMDse4T2OU29t91kmGcmnpjgWciAHBbwRDPGcwNfQ37UBqM/Jkq0eO895ROgRp+Ygh
	 zNFn7p3rMrilA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id DCCF380EAF;
	Thu, 23 Jul 2026 15:26:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 854F34BF
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 15:26:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6ADA38104F
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 15:26:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xN7gl-qpygjn for <u-boot@lists.u-boot-project.org>;
 Thu, 23 Jul 2026 15:25:57 +0000 (UTC)
Received-SPF: Permerror (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=nick.hawkins@hpe.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 46AEB80E0D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 46AEB80E0D
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 46AEB80E0D
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 15:25:51 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5EB6F803F6; Thu, 23 Jul 2026 17:25:50 +0200 (CEST)
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com
 [148.163.147.86])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8E3A800AE
 for <u-boot@lists.denx.de>; Thu, 23 Jul 2026 17:25:41 +0200 (CEST)
Received: from pps.filterd (m0150242.ppops.net [127.0.0.1])
 by mx0a-002e3701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66NFKD1K3324395; Thu, 23 Jul 2026 15:25:37 GMT
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
 by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 4fkkvuj693-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 23 Jul 2026 15:25:37 +0000 (GMT)
Received: from p1wg14926.americas.hpqcorp.net (unknown [10.119.18.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 55348805679;
 Thu, 23 Jul 2026 15:25:36 +0000 (UTC)
Received: from p1wg14926.americas.hpqcorp.net (10.119.18.115) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 23 Jul 2026 03:25:27 -1200
Received: from p1wg14920.americas.hpqcorp.net (16.230.19.123) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 23 Jul 2026 03:25:27 -1200
Received: from BYAPR08CU003.outbound.protection.outlook.com (192.58.206.38) by
 edge.it.hpe.com (16.230.19.123) with Microsoft SMTP Server
 (version=TLS1_2, 
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Thu, 23 Jul
 2026 03:25:26 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bIQJ/ctxVflC6tQKrR3jWth0fvB3ZVDqI03qH/cu4TBiqZn3Jzl9OzBUs0DVl2C5qLUdD+/X4cM/8iwXAImVcLfmkjgW5jAcXpI3NmSQS3F53NLYEw9sHR2++g5gfQwTRb1AoJbopzTCzK35Fsy7aSy805fb2DG3ZVj7mpNVvXJN6v214pogjWNV22Ag478GNzTodP0WQRQ7xI0Q0y7Eo5/Q6u7FvsqgUFvn3zubzgzUfQ1IIY2/GmcHXTIese598xNEf+XOlcspCuYLNzMveHsHd5v9WVJijiY9oxMX1FlV4Ctvo4X4mzouJn2xVcUIb74leGB86HTYtRCYWHoDxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OWK+MtR0OgYCipoS+72/iJ4STA7y8cvfUhjCTozN3EE=;
 b=vr1poegdWZuA+d+fq6LE5avAiieyMb7f53pV6+ZoDkPLW6/nvulB4VhQrdBdzkOjJmR5SIR/XccKKX2f35j25XtFsY30hXeguQa6/68amIA4TWad6kfQx9gwNjcGN/up7FL6aZuYuJirhLe/bGZSZmjRTkUgplOR8cEGxy0ZPKptDDfpjhXf/kHO6jdjZ2CVFerNriIcnu7WGqWSjbiuYI1SXn3VZf3208Lk1wG45VQnzzylkz3Gk9pVHn0Y4GL0dxCv4WeLopekDEqeX+uA/kCMLRcUiu9LLRtFBz4h6BpOFXJHk05Ll+lvugzKhm0DY5KGwegjucsCDcrHDt9r2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:4e::10) by
 DM4PR84MB3970.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:225::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.11; Thu, 23 Jul 2026 15:25:25 +0000
Received: from DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::a85b:624:a74f:e211]) by DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::a85b:624:a74f:e211%4]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 15:25:25 +0000
To: Tan Siewert <tan.siewert@9elements.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, "Verdun, Jean-Marie" <verdun@hpe.com>,
 "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>
CC: Tom Rini <trini@konsulko.com>, Marcello Sylvester Bauer
 <marcello.bauer@9elements.com>
Subject: RE: [PATCH 1/8] MAINTAINERS: GXP: Add Marcello and Tan
Thread-Topic: [PATCH 1/8] MAINTAINERS: GXP: Add Marcello and Tan
Thread-Index: AQHdGqeGeiNyMCxyYkm4PajN3w0v3bZ7OR1w
Date: Thu, 23 Jul 2026 15:25:25 +0000
Message-ID: <DM4PR84MB19279FB7245BCE52FADBB62588C02@DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM>
References: <20260723-9e-gxp-v1-0-f86e5cea239f@9elements.com>
 <20260723-9e-gxp-v1-1-f86e5cea239f@9elements.com>
In-Reply-To: <20260723-9e-gxp-v1-1-f86e5cea239f@9elements.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR84MB1927:EE_|DM4PR84MB3970:EE_
x-ms-office365-filtering-correlation-id: 9f59cecf-4300-46e2-13dc-08dee8ce9eb2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|38070700021|10067099003|56012099006|4143699003|18002099003|22082099003;
x-microsoft-antispam-message-info: V5zv1aDD3gFeUNRH3AHnDFZc892z8JmBJhhPItnty68e/jH2gSguobfnvYKn3AO9oSY/NQOEHfjo0j+ZoT8BbLANl4kZxhJgS0OP53/0iDK9MmHX+R0WL3G4a6kM148jVoU0q82p0z0U3rdUHhsOOP3qkk61f2Ys8hdSd+pArZ3+BU9cfp2AYDrOmhWD3Gak7JFM8YnObpati97NQMJuwPz6MM9C4qppa0cjCa7LzQxraerGsFbcuG+I41Rkc3d+SN1LtRg71cvywjTqtevySQgx3E5RTDGK6qKjbxA1d+TSbeFwnID0d5buFsO8KNcUusPSCBkADJfhl+cJgZVoueZy1T+X+E1csNWmnKOQfS8PQfh962rFaKZjSflRJq5sL7J688hYxnEp4kVN4uAmNULMzjimBnShnt+hISjWbIGk/c6Fsx62Vf9iN3h/bzPpjSMt1FhqVpmsTkPRkrABL7u2qvqWBqBpT9+Ga9Sn8WhnbxKBLMd/23w8UeJ2fFlYDGofiCyeLgEzaVT59wSdye1T/dMvNeOv6CGTPWliE6VQyXrpPFwxu0AdMZYdMXoF2LlyFWCup5tf8J5oatNryWThx3x2gQpF+VWuVqit2NwHah1QMgTZF07LxsbBETHW8z/l2fa5k41J9sNuWNtGOOEVxo3Aenf8ydVT6V1hdQiAc+FxxJJiLkt2f/b7oAHZYE0lDSI5A/qd5E+duxlZB2P+bzE5EIAbdcZOEKvmV1s=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(38070700021)(10067099003)(56012099006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?emtLVUxGalVWMzZZaVBVV1dkSUdabU5oaC8vSHVLK0pCQ1lWVmtUcW5rbHFR?=
 =?utf-8?B?U0NmOXk5Z0xSWHVPREpWekZMYlZBYzAwVE5Wd3hPZlM2cGdFSDV6QXJwc3hM?=
 =?utf-8?B?dEptaGpzcEZwYWhHOFBJenlvZGU1UmZSUjFKbm9GeDRMS1praXhyKzRRaHNS?=
 =?utf-8?B?RnJNanZmQktjN1FCbzlUN3MrMUlNeHNVbkw2VTkzQXFwMDgvRlI2bnpLbDhn?=
 =?utf-8?B?RWs3NGZmQjQ1eHJ0UEhnbzQxa3lMWUdJY2xvckVuTG4wL004Rnp0czdJMmU1?=
 =?utf-8?B?OW1Zd3NKQmNLNXo4UzBNUnlDalI3TCtKRFBUWlduSlRBZXVPeUo0T2t2RjNu?=
 =?utf-8?B?dDJmSEpkUkNhcm02VHMybE50VExOb2RpQzRmbzJrbW0xNVVjT2grcFJBTFhF?=
 =?utf-8?B?WVVTK1FUMXVEZmpEcnlabXU3WjdmMHg0NVhKQmJUdC9MTVBUZnJhN2owV1kx?=
 =?utf-8?B?MmN3VEk0Yi9iN1ZtbEdlWWl6YUg3QitjS0oyRGhZSDFZRk9VdlJQYkpsbnAw?=
 =?utf-8?B?YnlRcHZReERsQStmUzFQYWc1NE83SXJCelY3VmdqNXBKVmd1S0NNbmVENFpO?=
 =?utf-8?B?SllZSVNiN284TE5DdkQwZFFTVG03bUM5Z1NSTjVXbkpPZFFCZS94cXRhYU1j?=
 =?utf-8?B?RHVYd3BrcnZqMnJHMi9VS2IvTXEwWEMvTXVXMHB6MWZUTDQrUlVXSzYvbWdV?=
 =?utf-8?B?MTRzMEo5NmwrZ1pMdzVMYXJMWGpyQnVhdWk1dlZqZ1NHLzdrVkdlVzFjaWQ1?=
 =?utf-8?B?cGRsTnJxNVVWRUdVcVJzSXIyTHlrMndTM3AydEUra0FSaGVUd2EvYiszNDha?=
 =?utf-8?B?OXdLUjNrMmdFbHAxeTFCZVlvTzRvZU9xaGkvWUVuWmZUZ2xzVGd3RGpqNnJl?=
 =?utf-8?B?WklhTWZZdllHcU4zZE1YbXRjSkt6U2NxK1hxWTVmQ29NSkVlM2Y2N1hKY3Fm?=
 =?utf-8?B?Q2p3OWV1NFhvTFNQM2plWE1laGNqeTR0SWhMN1NqYnJVN2hjOFlKNXJYUWkx?=
 =?utf-8?B?Mjc2YlRrdVZtRmdnd1pRVndlWSsxL2xKL3U1b3RCdytwc3QvbjlZK1BjcjF5?=
 =?utf-8?B?QnZpNndsNWIrU010UU5QVm5wTTdaRktxUDc2eER3M1NJQUJqR1dseXU0Um9X?=
 =?utf-8?B?ZUpHa2ZRNkZZUzJQc1NoMmx3Nm8zYUxaOFNLaFg4UWszYk5aOStpdXRKenFs?=
 =?utf-8?B?ek1mczBIUG5yNWJnV0ZnV2pockU5dnM5QStrUUgwQ1U1d2FoRmJnMWZ1cE84?=
 =?utf-8?B?V2Q5R1JPZHhkNXYyNklXNmpmQ0pVOGlvY0VNVXkxSTczM1VELzBJclRucXlZ?=
 =?utf-8?B?T1RHd1grd1FxRmtoYWRTbzR0SVF0aWNHc0drRzFCcytBTzU5M3dmczVJQnpk?=
 =?utf-8?B?V0VjalQ2RUE1a2ZiSkk2M2twOTJPamVwelJtMDAyV2gxd3JKbTJQVnhuMGgr?=
 =?utf-8?B?TU95YVNDTENTb1gzOVE1Sjkrb2tuMnZIcUJSaXpVc3dzOUVYMzJrTG5aK0xh?=
 =?utf-8?B?eGVzWFZRTkp4enhGNGV1RGI1WkRtY2U5K0ZKL0JJK2RDbFRMRHJwYVJYc0Ir?=
 =?utf-8?B?eXlTY2RRWnI2a3YwbEdmSEx0SWRITy9OT2N3VmNsTWgzWFErY2RNbG9oS1VV?=
 =?utf-8?B?ZWRJb0dxRXA2dVJrWDZTbzdZREl3R2wwbGErd0syOXJudDBmYzRGbWlKQjdi?=
 =?utf-8?B?Q1VlS3BhRHZjOGc4ZU1lblN0MnkweEZmeTdjM2dWdjZIMVJrOUQySFB2ZWZt?=
 =?utf-8?B?bmxvMTRjdEJyc2VkR3Z2NTJxazlmNVpEaCt2c1hFSHQ5L1pyS3BSWFdaUkh5?=
 =?utf-8?B?U2EzUmxLNEFwYXZTZS9qUnU5RFFWSE1rRjlRNkFndHdlcUcvMFBDYlNYNDFY?=
 =?utf-8?B?b3Q0MVpCS2V1OS9nT0VPY2FLNm9vUzl4V3R1UUtYbUtHSkF5Q01jZUp0dGZJ?=
 =?utf-8?B?Q21ZNW56TlN0bWtCOU95TjlLYU1MQUF5TTA0MkFkUDdadExnTE1SVmt3NHlW?=
 =?utf-8?B?M1BFdUJ3WWsvemlLQmcvZ25DODdoa0hHbDRka2Z3VkFjRU5xVWVxRXlPZWVu?=
 =?utf-8?B?RjNGTTBTTXhtSE93RSs0ZlFFMGlCQkhNSW8wbnA1YjMwTlVZcHJUUzhxeVVH?=
 =?utf-8?B?ZFYvampKRkJKaFBYVlRMWW4zVk1kVzREbUdUS1FKYzJqcE03ODlOMG9ta2tP?=
 =?utf-8?B?OGY2cEJpM3JLSUYxaU0ycW82YmtsQitWdTBrbGh6cVJGMDlqa1JmNXNieDJx?=
 =?utf-8?B?b241akxXY0RRV1g1YVpwYW95bzBuVEF4Njk5Smc5dDYxRUhETG84K0hyQy9N?=
 =?utf-8?Q?jrygjHCwTAxe4vFPa/?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: jvWq32fdifT5XgHAPuj3MkKvvTElbo2XYl0WbdiwwnNrmOtEQp51464g1r6iEQafkDPla1K42L0DrjPaa5hnmybQuE834SCr0xE3FxdYBhfyq3pVhd5A0/JMhidsNtxYz7HNQf2yZe5Mw/HCwIG+tz78soBLAiJTSSw4Wc8J8+8Dz/4roQQ2QUEeuHE+Lt4aLv2Dkz2c159Iyu2OCzt3CPQ0N488gu1v4tlKl35MtVmqFIFuz1rYI3I10iF9Jnd6tVYT+cNRgjP/lzrR6tviHSwJw/CAiIRfC/PZIQDh6Siy6f8cdmuwvKr9MqPg4h0wtp9p7X0swe2Xnf++f/Vd7Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f59cecf-4300-46e2-13dc-08dee8ce9eb2
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2026 15:25:25.6305 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SR3RAPF9y9WILWSH9WbcRRaeYJed6zKuDwJ07baGQdEXv43XkHt/qAE7kAT8KRsIsAVasjOdw5ktg9orXVEu1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR84MB3970
X-OriginatorOrg: hpe.com
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDE1MiBTYWx0ZWRfX7Z6yglgF5L4f
 OiY1CmJA8B89RHcfFmlO0mFvD36ZXSJkhp/OdKB5YoDqCla68UM2UYLtEqPPYC59fI1cOBE43gL
 wdYcXagJBUyRZrtVcbf/yPpqeWSYyL8=
X-Authority-Analysis: v=2.4 cv=AZ2B2XXG c=1 sm=1 tr=0 ts=6a623271 cx=c_pps
 a=FAnPgvRYq/vnBSvlTDCQOQ==:117 a=FAnPgvRYq/vnBSvlTDCQOQ==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gQcMVamqm3wCPoSYhaRC:22 a=J0OTuHAx6l5K1fCpvPfz:22
 a=MvuuwTCpAAAA:8 a=PzGKxP3WAAAA:8 a=1VxDqnHFAAAA:8 a=k-42gJp3AAAA:8
 a=VK0keEH2y-Gv6agWPMwA:9 a=QEXdDO2ut3YA:10 a=zCCnohV0i-_k6euCn0hJ:22
 a=aZ5uHUMKh6B-zo3GvD48:22 a=uCSXFHLys93vLW5PjgO_:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDE1MiBTYWx0ZWRfX43RKfbD6WcOZ
 Qr1O61IiWczS6FBtFJY2d9hP2wojlM4DhWjCPPegs6ToP2IlZyfJGRBLrxabcmZCYA35Ua/hd47
 tdVFH7f9I0xQmBdJnmdbgubWZ+7d4qTeA3YOxSOAl00qo622xQCPHWY3ImC6fgHGaXIkXBUFGbt
 yh8kj4sfaV0zPtnyt7uF2B5JmWDGBkvPveKmA3YnogQ3DtRyD9E7Pzb8oIg3Z4vXwYAANJK7YSW
 GFZ+7QDBF/nV60WNflrOS678tVzaF7iKoDuwBWB8wG2cToLUO2TfIjsybVIJDkDUUa++JTizItt
 RJbSeolglN+rgnGqdl4U0yDC+YOG5Tux3wDFL1ZwGIwNgsIF5HlE59Mjy8DcTz60KCkpOcXTb1S
 9BNq8nj1WtlOrFOiwa22yOb2kXhJeEnNv/MwXDnAkXmxGE8dh+4qChMxeRziJEbnRPITQbVdg+8
 krybfzSJAd8W4dgBIeg==
X-Proofpoint-GUID: KjPcJD6AYRFhf5XPo9D-vGwPSt-G5-u5
X-Proofpoint-ORIG-GUID: KjPcJD6AYRFhf5XPo9D-vGwPSt-G5-u5
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_04,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 clxscore=1011 malwarescore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230152
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hpe.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pps0720; bh=OW
 K+MtR0OgYCipoS+72/iJ4STA7y8cvfUhjCTozN3EE=; b=aNA76WMnx6NVtozYNX
 zeuJPhZ9raD55mQ6lkvNw1uf505bkpc+AIUA3mAdD8CiH7VKzFpnY1S3lmuCfPUN
 Xqz/mN9vMXjxkZxEgv7ZF5p4pAkawI5omW8XaYVr1AecpbpGSlyIL5aKCbjv1X16
 xLvzCAGPB8i2P1ExR9kAxYlzHiHI47N1XLGPtyFPXBzJxGT75q9sHN1pnhVjjbKp
 1bKCSo1E4sHPYPKesVT+SKJT/FCYqC2br0lJyn+8aKjxiJNSYxGAAETLNOtU3rv2
 4Eqhm2Ls8jdK57iUBXLNwkUdv2ktpuLE/OhN7DUXn/4yi5V9hmlXSgaGf+lvl4Jr
 /LIA==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=hpe.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=hpe.com header.i=@hpe.com header.a=rsa-sha256
 header.s=pps0720 header.b=aNA76WMn
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none)
 header.from=hpe.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=nick.hawkins@hpe.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=hpe.com header.i=@hpe.com header.b="aNA76WMn"; 
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
From: "Hawkins, Nick via U-Boot" <u-boot@lists.u-boot-project.org>
Reply-To: "Hawkins, Nick" <nick.hawkins@hpe.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

QWNrZWQtYnk6IE5pY2sgSGF3a2lucyA8bmljay5oYXdraW5zQGhwZS5jb20+DQoNCi0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBUYW4gU2lld2VydCA8dGFuLnNpZXdlcnRAOWVsZW1l
bnRzLmNvbT4gDQpTZW50OiBUaHVyc2RheSwgSnVseSAyMywgMjAyNiA4OjMwIEFNDQpUbzogdS1i
b290QGxpc3RzLmRlbnguZGU7IFZlcmR1biwgSmVhbi1NYXJpZSA8dmVyZHVuQGhwZS5jb20+OyBI
YXdraW5zLCBOaWNrIDxuaWNrLmhhd2tpbnNAaHBlLmNvbT47IHUtYm9vdEBsaXN0cy51LWJvb3Qt
cHJvamVjdC5vcmcNCkNjOiBUb20gUmluaSA8dHJpbmlAa29uc3Vsa28uY29tPjsgTWFyY2VsbG8g
U3lsdmVzdGVyIEJhdWVyIDxtYXJjZWxsby5iYXVlckA5ZWxlbWVudHMuY29tPjsgVGFuIFNpZXdl
cnQgPHRhbi5zaWV3ZXJ0QDllbGVtZW50cy5jb20+DQpTdWJqZWN0OiBbUEFUQ0ggMS84XSBNQUlO
VEFJTkVSUzogR1hQOiBBZGQgTWFyY2VsbG8gYW5kIFRhbg0KDQpBZGQgTWFyY2VsbG8gYW5kIG15
c2VsZiBhcyBtYWludGFpbmVycyBmb3IgdGhlIEhQRSBHWFAgYXJjaGl0ZWN0dXJlLA0KYWxvbmdz
aWRlIHRvIEplYW4tTWFyaWUgYW5kIE5pY2suIEJvdGggb2YgdXMgd29yayBvbiB0aGlzIFNvQyBp
bg0KY29vcGVyYXRpb24gd2l0aCBIUEUgYW5kIHdpbGwgaGVscCBtYWludGFpbiBpdCBnb2luZyBm
b3J3YXJkLiBUaGUNCm1haW50YWluZXJzaGlwIHdhcyBhY2tlZCBieSBKZWFuLU1hcmllIGluIGEg
cHJpdmF0ZSBjb252ZXJzYXRpb24uDQoNClNpZ25lZC1vZmYtYnk6IFRhbiBTaWV3ZXJ0IDx0YW4u
c2lld2VydEA5ZWxlbWVudHMuY29tPg0KLS0tDQogTUFJTlRBSU5FUlMgfCAyICsrDQogMSBmaWxl
IGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvTUFJTlRBSU5FUlMgYi9N
QUlOVEFJTkVSUw0KaW5kZXggMzIzYjFiMTcyYjEuLjNlY2JiNTBlMDNhIDEwMDY0NA0KLS0tIGEv
TUFJTlRBSU5FUlMNCisrKyBiL01BSU5UQUlORVJTDQpAQCAtMzM1LDYgKzMzNSw4IEBAIEY6CWFy
Y2gvYXJtL21hY2gtaGlzdGINCiBBUk0gSFBFIEdYUCBBUkNISVRFQ1RVUkUNCiBNOglKZWFuLU1h
cmllIFZlcmR1biA8dmVyZHVuQGhwZS5jb20+DQogTToJTmljayBIYXdraW5zIDxuaWNrLmhhd2tp
bnNAaHBlLmNvbT4NCitNOglNYXJjZWxsbyBTeWx2ZXN0ZXIgQmF1ZXIgPG1hcmNlbGxvLmJhdWVy
QDllbGVtZW50cy5jb20+DQorTToJVGFuIFNpZXdlcnQgPHRhbi5zaWV3ZXJ0QDllbGVtZW50cy5j
b20+DQogUzoJTWFpbnRhaW5lZA0KIEY6CWFyY2gvYXJtL2R0cy9ocGUtYm1jKg0KIEY6CWFyY2gv
YXJtL2R0cy9ocGUtZ3hwKg0KDQotLSANCjIuNTMuMA0KDQo=
