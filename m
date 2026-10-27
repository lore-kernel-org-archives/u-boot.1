Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B184A606A31A
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 14:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=AzvxbQz/;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=4YORh0KB
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9281C809F6;
	Tue, 27 Oct 2026 14:43:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FQd4chMLbsFj; Tue, 27 Oct 2026 14:43:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 33C3E80E10
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793112195;
	b=G8Copk90pyp/zP0UxQYnf6LJ6yAE2Eoqu4FuAGSunp9eZygxr8Fz0hCebjAzctj3Z4wJ
	 IRFfceCFCitkIiuqL83p7Uaa5XlmX1wvgd8OuKCfKbTNO/5rlyQYJNcgS1Pw6wTSh8sRe
	 vpqXJp2kCbCtMQsFh3TJ6YGkuT+aCSGWaETeXxabDWAhnS61N/p6P6EwncW26H4GzjAH9
	 k5baRoOSGRAdEIKLllWRtlO1DW8JlKVBm5TPTjc580G+pJDdhAp6q9vpQVlWBv+iDK71L
	 nV0tODUxsgGeyuvJxrTDm/S3c0te3SS2hAHXtjjsoqaK8/i3w16zgNaIraUtf/din4A==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793112195;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:CC:Subject:Thread-Topic:
	 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:msip_labels:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=dNDAsO54m/tIllmt5xilGVQbZkCo9N4+v4wQY7Skvrg=;
	b=GfqyXHnl1Ft7UD38z5oRkW8FbJZnj0nFNe7zM0V8yqb4RXLM9jEsL2KK7T/VsIVbMqOk
	 F/EH2gH98y1aMySWNSdiYiWVJfB8t+zPIRK/UBp+Gj66srz7MNag1dktsDyHRmF5JMpUE
	 OxVSN7XdMnwkXrd79lCh83TS5kez30/H88PkOHvEDrd7alfO8VFLa+J5NTkWVw8UhUFWg
	 FtF6+WJJVTWTAhjC3MuddTtXDr34/8aPMNr2SGPkEBQiXReUnzVia9GSrgT3FZhVg+/Ps
	 3LlazTTqsJ+wKe/VIJhekS/fe4nhm5heJo0DfdihqAHv+iIjaVznBapmDmhvLh8J5vQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	dmarc=pass header.from=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=4YORh0KB;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793112195;
	bh=dNDAsO54m/tIllmt5xilGVQbZkCo9N4+v4wQY7Skvrg=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AzvxbQz/8HH3RVfPqquSMhZE8XRZcDuvd9ZzJP6Yv4fL0pjvXJBkW9CDGPk5lAtqP
	 LLCA2RTfaeo5HhbcZMKbHlA0nrdK90yFxKU149kBQVshrkpUUmaxAcYBqaItwmej+N
	 2OWZVMnJ0fj5u+gwDiGFNT9VlpGLxoitDpiV4m0GwVzGA8ol/OREIeR/6HSkG8Z045
	 BKTKLnk6j5YkNGDJzzexQ5XD8HTmFVGiHnD5JTjKjzxlYzZHSHgA2SLfI/+0Gr8gG3
	 pFw8GsqufytLKd0SKCxMv5CXcG+hOQo6KyNglW9Mp7dpRAhFf7o3EB/dMqI/lWkbrg
	 Bq+b8dZKcbXwA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 33C3E80E10;
	Tue, 27 Oct 2026 14:43:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7E096279
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 14:43:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 64E2880DE9
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 14:43:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VIwNY-Hyh0uv for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 14:43:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 68B2180DF5
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c10d::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793112190;
 b=WZwHWOss7bo8bOU7QMwwHFqaEdD1qTita+O8plONhw+8O8mjuwLRM5I3D/6tW18hz1n6
 eTYFkNhtrxEmtZiee1YtFZPBdjGWo4ga+hrOuqMoOSB1cymi1xkGdhvK1DIxc5qQuafMg
 50fNffL3QlTMsPa2jurYFM9Yj95bZkfKyxISeQ/S3iVgqcu+MfQwJEMqV33iLJ8XEkbzh
 Fa9gObAais6XWp0lzhUPtHwuXrAtwyi6NaP0cLwg2imCRo9NFbq43HvPl9JTzcfM2Py+6
 eAZC/If+qkApJg+xrMhbyZT7jDk2jO6A0+roo4nREWD7pko+tCOP5kb1JlpPEmVQEow==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793112190;
 h=Received-SPF:DKIM-Signature:Received:Received:From:To:CC:Subject:
 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
 msip_labels:x-ms-publictraffictype:x-ms-traffictypediagnostic:
 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
 x-ms-exchange-antispam-relay:x-microsoft-antispam:
 x-microsoft-antispam-message-info:x-forefront-antispam-report:
 x-ms-exchange-antispam-messagedata-chunkcount:
 x-ms-exchange-antispam-messagedata-0:Content-Type:
 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-originalarrivaltime:
 X-MS-Exchange-CrossTenant-fromentityheader:
 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
 X-MS-Exchange-CrossTenant-userprincipalname:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=dNDAsO54m/tIllmt5xilGVQbZkCo9N4+v4wQY7Skvrg=;
 b=XI47MFC8FwehaF+on0AxOb3Ok/4ZdfeP25zjLXPfaSkxEuR2HGJiuO/6Hwd60r8mjId4
 QB1+YJmwJnqZAut1Zorprn2YmE5+Kh8EaP/O5TsA3zeGbofhrLNeo+Ipkx++58BCLVitE
 wltOLC/61/bIdPg9jK5E6eW9PiRpRUMVhOBOvApswq64r4UNCSZ9mOzRS5n6aH1y82dGM
 vW8rwlp8KMmmaRhYK//5AsASm0IbBtaUHV5fLMnOKfhi0AevPPZbHfNVD4KqHlcx0/sfL
 E2p5SLVPMCZWkKkjR8Z82U7nB0gedgIYEEfGIXiZCroNiVnuqoekbKtsARIBa4thNaw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=amd.com;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=4YORh0KB; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c10d::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c10d::3;
 helo=sn4pr0501cu005.outbound.protection.outlook.com;
 envelope-from=padmarao.begari@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=4YORh0KB
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 68B2180DF5
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 14:43:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tpp3kDhYiAwZyWSNCwFnMGmfDt6CBguSrre2IhcSPdISx5hU+qg9ykRgJL7NGA2jgqeKPwTQvFxAxQP3jcgOQg9TWCLEULldzk0PrnNfAMlKDtqW4mBs2mTy3rRnwY1CYPFzX4ArgwT2SVvuJ5X6BPrTWp2aSfQDd+UhTbo1lDPHhlzK+/PUoGBMVb4URi9htYZ18LI8Q5c+3WAEAf2OuAXmr80ynBs81RGQJ0o97wObf5A6gglmAXMGTptVrtqXUv5uB2PsEI7LwxjHQDt9luvI1vmxlhsOcG+zvfR2kgXUB6AKWuMXkWoT8iU1ZAV4L71z+bKqdqRDRPfRj4Rupg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dNDAsO54m/tIllmt5xilGVQbZkCo9N4+v4wQY7Skvrg=;
 b=AExxgdHfHitqMecDfH4x3tirV70u3SDjJZThL7rkwqrJMNj0i5WssrDjVbse1LYwr+nbd6yfAf2oyWyT8iaTBIR0F1Snx0AmOQlHOHKTYbeYVXUCpU5HDPrqz2b6WdFgcFX59un0EthALz+vyIDb3RFsJ6jgxGFS2WLOaz+EGNRPCzai9uk8iRPObxSzeQ2fGVui8vhcVKkc/DZ6kA5qCIYuo+V8UPrzrEnfi+w3n17CN8AHrrQct4PBscRXHlskYuIeUYklV05XvcEvrC8RpUKFtyZNP4ow2iyYbQP12/5VZAHyDawE8TjN3wTbECZHZWbDLDMVnBuPPh79OB1UHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dNDAsO54m/tIllmt5xilGVQbZkCo9N4+v4wQY7Skvrg=;
 b=4YORh0KB3YqvilIJ9a50Go63NH/CciOQe9t2HXmjMorGi0Q9k6O6Yfz3oqsFggP7ehFbuDxiOoj0FqsIFBdFXZ+WRqzT1iKSNW75IBPtT5Ym5tXU378ZOnYkoEFmZW18q5PtUumTGCSKqTHXI2Mgxf+B6Ol0cMJSiHa5cNkWkD8=
Received: from PH0PR12MB7470.namprd12.prod.outlook.com (2603:10b6:510:1e9::20)
 by DS7PR12MB9503.namprd12.prod.outlook.com (2603:10b6:8:251::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 14:43:02 +0000
Received: from PH0PR12MB7470.namprd12.prod.outlook.com
 ([fe80::c3e8:ee3e:aae:e211]) by PH0PR12MB7470.namprd12.prod.outlook.com
 ([fe80::c3e8:ee3e:aae:e211%4]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 14:43:02 +0000
From: "Begari, Padmarao" <Padmarao.Begari@amd.com>
To: Simon Glass <sjg@chromium.org>
CC: "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>,
 "Simek, Michal" <michal.simek@amd.com>
Subject: RE: [PATCH 3/4] spi: zynqmp_gqspi: fix chip select for part-concat
 flash configs
Thread-Topic: [PATCH 3/4] spi: zynqmp_gqspi: fix chip select for part-concat
 flash configs
Thread-Index: AQHdYi15OGPOdE1rH0S9bb93toQ9ObcMQRoAgAU00AA=
Date: Tue, 27 Oct 2026 14:43:02 +0000
Message-ID: <PH0PR12MB7470F88A6367AE304150E95AEC602@PH0PR12MB7470.namprd12.prod.outlook.com>
References: <20261022135740.3869144-1-padmarao.begari@amd.com>
 <20261022135740.3869144-4-padmarao.begari@amd.com>
 <CAFLszTiq+CVjUKaoH-86f_MCgtspYK-34t_ssSJy3pLpZrCDQw@mail.gmail.com>
In-Reply-To: <CAFLszTiq+CVjUKaoH-86f_MCgtspYK-34t_ssSJy3pLpZrCDQw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-10-27T14:12:01.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB7470:EE_|DS7PR12MB9503:EE_
x-ms-office365-filtering-correlation-id: 9372182f-cee7-49a8-5743-08df34389a61
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|38070700021|4143699003|56012099006|5023799004|11063799006|261009221227099003|261009220027099003|261009223327099003|261021121427099003|261022075727099003|261021123027099003|261009221727099003|261009223027099003|10067099003|22082099003|18002099003|261026121527099003|6133799003;
x-microsoft-antispam-message-info: RKeoW/sFsiJF4GG5mubyd9dba3bPeS/Hmv6vMLPYAR09jcNzkMBvOdP2AmW2W1IGL12jvP3Sca3BHAWMzRbQ78PhY1CdFl+I55m6A8+PcErocdZlsDl5kVaSyRgCMpKyHi5G8s7zdF2a0GF7oUGJbUYN/O8sgReCEsP2TBEsH0xZU0LEhNePNEGBUmWNvNpVoDYSWpsXvKbW0jLsHghO7cwWdZ0spEQNBlwLdzPyqMdNk3d1LjLdYb1ilFsuWC+4HHOJspMojFyrwwk1fn6nRLhDVgfZ/NUL50mwJQcrXL10jhQd36qFgTl/SWXaK/OvI26so1m+rL4J3uKd9taHsEeGFz87lwQp2ySXf5uik3eNpUTdBuIql6D686Q9T0vGksVx6oMJ/tDAlHle/WCj+1zzR5ZEqM0antQlz6tap9ilPBD/ockmFQAemjfw4gA3xqHDow/65Gwg9UTsw3nbQkaFoXw8pAr0bOe8Cfc2So1eC1u8WyEf8jStEOiQK19xkOLSgoLPmSnexp2nmZSNRpxHYKJLeV2JW7SzkD4S+LjdmdVz3g1jgirvXgPXYmegBfMGzKhaS2sT5AKcfUXB1a5DN9MWpg8xodeGh18An3WPNzoYrp4FHUZ73ZbJZo3BFfbgWGImrgiIv7ifRkpunKXFhB0z2B6nv52ZtHBHJLfYD0iv5FM4AIJMXkCKaOpDMUYBZeup/NPSIE0oMkU/6Y3m1+cVqY6UlXIU2dTDcAI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB7470.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(38070700021)(4143699003)(56012099006)(5023799004)(11063799006)(261009221227099003)(261009220027099003)(261009223327099003)(261021121427099003)(261022075727099003)(261021123027099003)(261009221727099003)(261009223027099003)(10067099003)(22082099003)(18002099003)(261026121527099003)(6133799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EzhxxaQRrJNqTk1yx2ZWz38ufjPyEuDNfS9YbqgxobnbvXvizVtr3aqHW4cj?=
 =?us-ascii?Q?Dhctx+f+7VuxECrERdN7LQ0NMB7O/HMbG4kCvOdg4h2sR9XH71DJOR/JbbKJ?=
 =?us-ascii?Q?i7mhtp0SgugDPXF0bHUVHZWCfIsWvWjYgK/2lahgf1XTRDk8Zke+O+5UM07H?=
 =?us-ascii?Q?D+IQX2XOMtvrAvDhWlySW/BOiJi7O3gCQP2atWdQhoRDEeA23gUUGoYqPF7a?=
 =?us-ascii?Q?m67OB+kSwmUvx3upAgeqNwscv3Hi7oEznDEOj/kP6rkiRKvRyrMuiR58xeCi?=
 =?us-ascii?Q?wuhjx3E9Wsww8gNY8T+Wn3HPpRcD0TU4Y+/YAOK3oZ+7nMhW4XhWdOzSiLtn?=
 =?us-ascii?Q?/48M/8cKcXvxu2bRSOSUkK39ww3Z2UqrNHkQxF5Bs+MJyjANAW2V8VADFM10?=
 =?us-ascii?Q?25svb6hT/8TkID2dUWATcYRKb87WliTtlMI/pIe3yye/Ue9fc88XhHV9NZN1?=
 =?us-ascii?Q?fJ6aPcvS6cdaNA4iCft2AS1EcqYb/nSTOTv3zAr7DgR/vAwNreostZMJ8Twu?=
 =?us-ascii?Q?9+559HHvL4f1LsnZ100LpTE/edPGgRPFFePkdpN9tak7Zpd0GRSRyI7Ym4fg?=
 =?us-ascii?Q?gTOlVziURQ+7xWAWQEtHIYgfa2CSbTKwzDlnE4+5znRy8J7Rxe2XHSFiQ7tE?=
 =?us-ascii?Q?rp6UYOf6pPvaYrommXEgfBoQexWJ2XD+rD1kGepKY2UwTfepVdSVeSgJDvUe?=
 =?us-ascii?Q?wpBF4+FMSXj/xP4csv6+PIW/pr2fmGee2LPf7IT28+kZtbL/CANJsqDRlClD?=
 =?us-ascii?Q?tc0Xr0//WoSYm+C9d/bYmfIecJ1nkjHHwXxWRxKoWEx4qpT/GqQfvR90ajwH?=
 =?us-ascii?Q?rG/VIsNBxD9OpqxMaaxRlO4D7hpoDbdYkKGKe8i06DT0DHyp0tfHksfx9kMP?=
 =?us-ascii?Q?AETMgzOzYijZdIby+26LZJnd06d6r3s2D1vBsUNokvF/j+BvrZSqFI0m82gz?=
 =?us-ascii?Q?A10AFhEQSK/CalidKIpaXxMbAs3INxs/MF0Je8QN5xP0xKO7gSUBG9PTxzgQ?=
 =?us-ascii?Q?5DvEHaSEzhm78gbQUbmltYCWHbp2Qq2xa+zqqUtiI0mjwAU/2DBoMuraxtTl?=
 =?us-ascii?Q?xVTYzSI8VwAUfNVxh3uRQ7o5JuRFt1tCvbowLV2/Q7xVSNMo7OVPbeLA7oNS?=
 =?us-ascii?Q?6NVSdH/uJafOuupzRT/Fxph16wGEUaCmqX5x3Smo/emAAWrIFyRnLlAhH5mZ?=
 =?us-ascii?Q?veOZIFcea2u9PIXEK+qfw2KBIYoT+a9YP+wMQOh+OrIchRBOsWhP44OZi/yC?=
 =?us-ascii?Q?JqkTnd7wc3/Vgxh5YqS4zP4x4o+NSbdIdEhhiFsm8OvOc0jcE5QkDDl0Olut?=
 =?us-ascii?Q?opjadTvizwpPP2hEBs7cQYJmhtDKTLP/JO6MX+4akM4+bz2fIsBOSx7JFmUq?=
 =?us-ascii?Q?JSoFsohIbSFPLDPZ7d5zzjCoaCSxt+AOazarRhi++HznA9asfqFE7/elnLyk?=
 =?us-ascii?Q?8sZkgcaZr6oS4IuOV/xMuU1aBNebFbXQMcxMxpTj3snrmxzEsQK9+o6qVObz?=
 =?us-ascii?Q?Q1IWDCXjFlrusqmEdLF4DpFbn/3iF4pJYGm15KPF96rIa+gUFebsrImQUXB4?=
 =?us-ascii?Q?0yqWSKHhYeuhzOyhTOi0wRdyyGm9LoHHpgA0IrW0+hDB75WU04b827tCCENW?=
 =?us-ascii?Q?WSvSPuUxdq3o0WiY57d4XE0MPUhD+wQxdkK1o1Gz1cLK1CIP6/0sjUQGRXjV?=
 =?us-ascii?Q?Vmn5G2RntvM6vn49FlJewZkqqMSssvKHp5+T5Z/Nyr0X4I61?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7470.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9372182f-cee7-49a8-5743-08df34389a61
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2026 14:43:02.2450 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RXGzkzf/t9gT6rRZKDIMFrmkhj3JolDJe3BNtwlLn8jmKK2fY7ZF1LU+FulcLYc5Xmg1nebnCa7P9cKmdqGihw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9503
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

AMD General

Hi Simon,

Thanks for the review.

> From: Simon Glass <sjg@chromium.org>
> Sent: Saturday, October 24, 2026 12:12 PM
> To: Begari, Padmarao <Padmarao.Begari@amd.com>
> Cc: u-boot@lists.u-boot-project.org; Simek, Michal <michal.simek@amd.com>
> Subject: Re: [PATCH 3/4] spi: zynqmp_gqspi: fix chip select for part-conc=
at flash
> configs
>
> Hi Padmarao,
>
> On 2026-10-22T13:57:03, Padmarao Begari <padmarao.begari@amd.com> wrote:
> > spi: zynqmp_gqspi: fix chip select for part-concat flash configs
> >
> > The ZynqMP GQSPI driver hardcodes CS0 as the default chip select when
> > SPI_XFER_U_PAGE is not set. This works for stacked-memories
> > configurations where spi-nor-core.c toggles the SPI_XFER_U_PAGE flag
> > based on address offset, but breaks part-concat configurations where
> > two independent flash nodes (flash@0 on CS0, flash@1 on CS1) are
> > concatenated at the MTD layer.
> >
> > With part-concat, SPI_XFER_U_PAGE is never set because
> > SNOR_F_HAS_STACKED is not active (no stacked-memories DT property).
> > As a result, the second flash on CS1 is always accessed on CS0,
> > causing incorrect reads and potential data corruption.
>
> My understanding of this is that the problem has nothing to do with
> concat: any flash node with reg =3D <1> on this controller is accessed on=
 CS0, e.g. a
> board with two independent flashes doing 'sf probe 0:1'
> or 'mtd read nor1 ...'. Please can you describe it that way in the subjec=
t and commit
> message, e.g. 'spi: zynqmp_gqspi: Use the device's chip select when not s=
tacked',
> with concat only as an example? This patch doesn't depend on the earlier =
ones, so
> it could go first in the series, or be sent on its own so it can be appli=
ed as a fix
> through the SPI tree.
>

Yes, that is right. I will update the subject and commit message as you sug=
gest and send it on its own as a fix.

> > Fixes: 217b0a28b6db ("spi: zynqmp_gqspi: Add parallel memories support
> > in GQSPI driver")
>
> Just to check: before that commit the driver always used
> GQSPI_GFIFO_CS_LOWER, so a flash on CS1 never worked. The tag is fine
> since that commit added the 'u_page =3D 0' default, but it would be worth=
 saying in the
> commit message that CS1 has never worked for a non-stacked device.
>
Correct, I will mention that in the commit message.

> >
> > Fix the driver to use spi_chip_select() from the DM SPI framework as
> > the fallback when SPI_XFER_U_PAGE is not set. spi_chip_select()
> > returns plat->cs[0], which is populated from the DT "reg" property:
> >   - flash@0 (reg=3D<0>) -> cs=3D0  -> CS0
> >   - flash@1 (reg=3D<1>) -> cs=3D1  -> CS1
> >
> > [...]
> >
> >  drivers/spi/zynqmp_gqspi.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> > diff --git a/drivers/spi/zynqmp_gqspi.c b/drivers/spi/zynqmp_gqspi.c
> > @@ -881,7 +881,7 @@ static int zynqmp_qspi_exec_op(struct spi_slave *sl=
ave,
> >     if (slave->flags & SPI_XFER_U_PAGE)
> >             priv->u_page =3D 1;
> >     else
> > -           priv->u_page =3D 0;
> > +           priv->u_page =3D spi_chip_select(slave->dev);
>
> Elsewhere in the driver 'u_page' is a flag (upper vs lower CS), but here =
it gets a
> chip-select number. spi_chip_select() can also return -ENOENT, which beco=
mes a
> large unsigned value in 'u_page' and silently selects the upper CS. Pleas=
e can you
> make the intent explicit, e.g.
> 'priv->u_page =3D spi_chip_select(slave->dev) =3D=3D 1;', perhaps with a =
short comment
> saying the controller only has lower/upper chip selects?

Good point, will change it to that and add a short comment.

Regards
Padmarao
>
> Regards,
> Simon
