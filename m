Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DBD606A31A
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 05:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=YBTPTvOX;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=u2FDDmD/
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 70CEA80BEC;
	Tue, 27 Oct 2026 05:36:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PvTVyH9cTAy0; Tue, 27 Oct 2026 05:36:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org EE4C880BD6
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793079411;
	b=noS8yVXv8FEIp1YB2Znoww+ImqCQApCO4vg1mEeHfax5TQQ51djEZV5WcsyYWcR5O9gj
	 RcUuhYUmRLQ+gxf6mKRm5v8CGL2lifh3+74UXzQ0Pj3tjTJShFbQAdbjIrT95jPXnrDuo
	 s3de5XTcvXZF964Y2fjqjQYs8D+ZfcDgWe3xrqyNNOhfTIdmfNB0roUt9NuDB4cyhI2mM
	 e31nzfxWwlHFskzVqjV+Up6SrJRnt9qiRyo8pk+dVPeiz8N8pIxY9BSmKNUubOLDHvmP4
	 8u1cbT92sGou5pK157Nc+lxesPrXiU3SsOoyyDQC+It3WWOPvBEmPgzs1kv1OizHIbg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793079411;
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
	bh=bcXyImw3EnjiEMEGSOP06VfzG23yG7YS3pxOcdddAlc=;
	b=qgNSjavYfgnoolmD4BVkjeQjMm9NiyshmvgIcYaZ0Nsr4IulKgtbfZMzvkooU3axA6oX
	 cV88tU9/pXR48UOTxNWXiKKmHDjAl3z7Z+HdVNY5OyN+9Kh2n2CTCEzLzu0ka7JwRGMfX
	 plUtlmoAIA1lqTLnyz0atIHeWR877pVGucM/0tH9v7kA4CyNOV48W8B0bN5moWb8LwC+h
	 zTK5pU2kxx9n76Sj8a8oM65WPD9VfYi8LELqvNJDwbXMC5R8fuid3FPiUAhi473tTlrGc
	 k0rhhUz0Pg25nTFtwDoPF1+sgTc/8D7gMMuY/D/VAeazp3C4iPC69PL1+TA7REUE8ZQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793079411;
	bh=bcXyImw3EnjiEMEGSOP06VfzG23yG7YS3pxOcdddAlc=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YBTPTvOXaxya5Nk5pGP+Dn2EHW88YOu6YsWaDvaR0TGSVkrgV0vuFWoAFlyaxukFT
	 p1nG+YQzMl7YNusXd16O05qhGbi27YazJN59N5rGL5RT+/hh3D0poAHSLQvIRSG7hY
	 bxjvgsIypb82KuFFoCZaG/NkCU1GPjUivaZ3PoDZKgbvXSSeeCHv3ZPdIHVOFsruak
	 WcyobpNIfH+WQm+V8frf3Tt2sSeWq/FJz0FOlYmlbx0ggzBoPgLHzVRznRxAtruaac
	 ZnUFaK/Aywokjj0KVlyVRcT/7TistOio2fwg8hb8zLrSe7dosUQTEtS/ND9N9DIF6B
	 oaGD2RIs1kbDQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EE4C880BD6;
	Tue, 27 Oct 2026 05:36:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 367DE356
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 05:36:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 33D4E400C8
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 05:36:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8uj0Ht70Tm10 for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 05:36:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org B390640062
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c107::9"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793079408;
 b=RME4GNok9npCDGWIJPafSFb1kbsQNz4zcRna7HlxKLRUmmSMZn1eafv9g9ZYoy91Di+8
 umpT5zopYch+AvH4s92RBH4oU0AgqjK3SFE5WrYz9YKqICOgzBg6uc6P9AVBw6z69HgfD
 3u0O6MZVTwrYyAR0sRt0Zw8VpaH6cl+skIU+ia9iL+kbRpnmKWd2kPsDaN1uzeVBdWdyA
 7cZwqFy6F1q8nsFCmx9DP7Njc4UOec+7/+BQCWcmBQo75KS/PiPtSavGB9NRmpwVcA7ki
 nqrwo+KaHalDopt4D79PgDZuE0av1otmHr5x66UxOeoER+ehHEyOtyzcZcTrqxqLhbQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793079408;
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
 bh=bcXyImw3EnjiEMEGSOP06VfzG23yG7YS3pxOcdddAlc=;
 b=Z1jZ0qFLtWPRcXPBoC8FKJEgGg0Gi3SejrpH/Y2DmfOXT9G0B4iIF0OoFJ7qddZ2akUO
 Eg5bpr+h+frY83EFTMD6I/heOe2HQqX/A2qmgsSN+qSGYZN/NZ00yV9DoXmHrEowCw7yP
 mA03vFsqDPF2qIXak/3fOYdJIhpajK9VXpXof0zgr2uTXl89KYQTjl8AyWpYjaujgz0fZ
 fSmDy4nNJAcv81DU/C3k2mDA98Hc3yL7udAgThMjhFRtwhQOTAvKQMEFW2ETEsR/pis3N
 JdsVIFOOVZmffjWlAYHc5ppAF/dmil1mEh7H24ndKc2djVILzttKnSBt4MrmTI6Nnhg==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=amd.com;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b="u2FDDmD/"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c107::9"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c107::9;
 helo=ph7pr06cu001.outbound.protection.outlook.com;
 envelope-from=suraj.hanumantkakade@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=u2FDDmD/
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B390640062
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 05:36:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T2LmIo0FwGpF49fPw46I9VQjSpOImkj1UZlpz009r5KEeDyLqeOFYmXnT+QlujGuRHRZ7HqktBIMNJ+t/iOitUHAPT4p5fcQNiM3EJ9X0tl3HVCNPh5bAFZgdd9gILxdLXTlFwKmXgkIxIBnXaCB0em5IjOGgT7VMJ7Wpt63Bx6OCKGJseJtqiXZ+fYi7xqHMO5ZnccA3/YxxsgS4oES5pH7etEb3X+ZOECYyfuahdpdjEPDjsstNpP6fAmkVSzcqmxyD3oIg5dn4jaJwIaNhgLdnonpvKkKoRgQTnyPB7S2IibZplveWKDXPO6dkpoOmAaU1lJdDeVo/aR2Pg2wvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bcXyImw3EnjiEMEGSOP06VfzG23yG7YS3pxOcdddAlc=;
 b=Kktqe64a7gvh1eLomaJCJ4KV+Csl50OAy3VNXYXCjw9pEQsQOO08qTDdwuDB8TMTjw0DNZr8SqNwwdxzNM+5FIkFFI+NawKimtzWI5fV4rJFmN5tLG0BUzkb3cou3yqNkF8QhKNsOUcxa9sNLRMEXqyGgTwJnvOXCU39hqJkDqdaI6q7GEojE/YUldjwr6abBnMMNGF/RsFY//Mgo+sTOErFiA0G/xRnfcq3kD011lZskGQjjkuaoGU0KEpM8iUnIxfc52U+9qKsl2qUZi+6trH1849gKNJp58qSf3cHyh0STT4lwkQQyCPFFAbaJbPAi+iIzwMfJppPZJyrvem07A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bcXyImw3EnjiEMEGSOP06VfzG23yG7YS3pxOcdddAlc=;
 b=u2FDDmD/VlUBW7ZEEbw8p9VRtIZKOXEnhx38KFZ0MB3BG/EuhP3w0E145upgB0DMKTXar6B7vEvu1S35tok3GaReqTcvMJYM8XIG8wSDbxPCbqryyyXqIS4R1JOz6ibqRKxmNe02ojaequRpu9TL/r0sZsYFlaWWDoUmnEEJjiQ=
Received: from IA1PR12MB9529.namprd12.prod.outlook.com (2603:10b6:208:592::17)
 by SN7PR12MB6912.namprd12.prod.outlook.com (2603:10b6:806:26d::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 05:36:42 +0000
Received: from IA1PR12MB9529.namprd12.prod.outlook.com
 ([fe80::40f6:c7e:1854:4e03]) by IA1PR12MB9529.namprd12.prod.outlook.com
 ([fe80::40f6:c7e:1854:4e03%6]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 05:36:41 +0000
From: "Hanumant Kakade, Suraj" <Suraj.HanumantKakade@amd.com>
To: Simon Glass <sjg@chromium.org>
CC: "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>,
 "Simek, Michal" <michal.simek@amd.com>
Subject: RE: [PATCH RFC] scripts: pass dtc cpp flags via a GCC response file
Thread-Topic: [PATCH RFC] scripts: pass dtc cpp flags via a GCC response file
Thread-Index: AQHdM4PL/ydZYN0GLUi5QzBz3EqsC7cITHQAgAjz6DA=
Date: Tue, 27 Oct 2026 05:36:41 +0000
Message-ID: <IA1PR12MB952911BB398C79508458C86489602@IA1PR12MB9529.namprd12.prod.outlook.com>
References: <20260824044729.708287-1-suraj.hanumantkakade@amd.com>
 <CAFLszTiJnwq2M+LxQ-Mp3-2hwQQ1xegni7fydb2rdVHVxas11g@mail.gmail.com>
In-Reply-To: <CAFLszTiJnwq2M+LxQ-Mp3-2hwQQ1xegni7fydb2rdVHVxas11g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-10-27T05:26:19.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB9529:EE_|SN7PR12MB6912:EE_
x-ms-office365-filtering-correlation-id: 01b33108-fbd8-42e0-da68-08df33ec476f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|261026121527099003|11063799006|38070700021|4143699003|5023799004|56012099006|261021121427099003|261021123027099003|261022105027099003|10067099003|18002099003|22082099003|261026140227099003;
x-microsoft-antispam-message-info: zCLC/7Uxi4h4KyWCRtCuU5z9og9UVPAQ/wt5homieJRp5Ytzq5v1WsYukNsMqdmuk7OTAj12KRt3C7wbr/rIOt5O3h/uvNxRulNSzbEoatI/2q4nd9bdFk6vBf7z45kDi1P6c/b5n8LIsw1+nEPVSxzdA97B9CZ4eyLpQNiinDj68Fnw8OQ3iICsAYWUX5irEikcgEYonU9eXwnUziAEBDrhEcAo7mP5kZoOe6hD+4SWubspBCn+Wg6EErCm0y037CiVfZ2YMA0lSXS3FMNMh/IZoZVvQWwsoRMvEdm1uok3MOS8i9XkeOUMGShM2eO3wWg0Fv29fz+VcKHfVVUV5seS7FweybIIud1hSzXujPVHcPg8lG/uAWbkCkYtJDNBPjRQcB7QE+oModBPJi8CwrgoL9WSvcnpSZwPqA3orR1+NMisUFHF2PAgHCUNV1OjI4j35c1JGZZmDiB1bGK3M7uFjkPVeIzrb3aDzm6sJ4H97uFErLfDtNA/9yix5AXTS9lrskupZnlavJp8dQOYnAzNJjafjOtlem7e7CsyilRMTMAy36efeUtNOrErU3uCAMn4x8l9wAxxuHWZipSA7HJ+zyPU8efeetH8XYac2s2K/f13ewcPrq2AKukzddGwLcxXuu6aiKXVAUfnvD7FfLm3rXVqUl5plk0YqMBNzUw4Dg5ZCZNwqDaEpZT5DbzI
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB9529.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(261026121527099003)(11063799006)(38070700021)(4143699003)(5023799004)(56012099006)(261021121427099003)(261021123027099003)(261022105027099003)(10067099003)(18002099003)(22082099003)(261026140227099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U0QwVmorVjZiUVFuVWxZMnNoakFYS3hUVmhSekg5TGJ6VDJoZnEvN0FPMFZj?=
 =?utf-8?B?Y3huMExyeHhhYkwyZXlVQTRkQktoR0MxakwzYjZZcEJPYWJ2MVdmQW90NHFL?=
 =?utf-8?B?NnhLajIwR0JLYTBQNHRGL1JRdEJLakdwRjd2elcrcnpYQmJFWHBtaU9zUHNM?=
 =?utf-8?B?blRkd0t6ekM0RlFVbUtyTkxCcHkvVDJPRFhEd3plSGc1cTg2QVNsdFJwSWlL?=
 =?utf-8?B?MnVsbUlyYWw0SDZYUVlUa2pLemFzVEhPWUhrYnI1TEpaUmFGK2E0clROT0FO?=
 =?utf-8?B?RHhOUjlKZ0RLMnp4MDI1K2RFT2d3Q3F2N1AwTWYrMmtXbUZnaUE3WVZNZENw?=
 =?utf-8?B?UmxWbzRBQUxrNTVyNnhqTlFNZThsNFlsVk4rbHVrTlNIQTlLUTRyUUVWVTRj?=
 =?utf-8?B?SjZGcUZ5aFZsV2tMZWphV1E3UFROWm9JNklCVkkwbEE2aVNrV2FGOTRCaDVv?=
 =?utf-8?B?SmJLWWdmL2ZqK3ZEUGtsUVlhY1pGWmMzTEtPbCtPU0xINnlyN1pKbDlhZTJr?=
 =?utf-8?B?WStrNy9HWHAwVjRHeEI0aUJmREZDUjliTWpwVWR4VlB3N2MwQWdsT2xwR0FB?=
 =?utf-8?B?amRhY3N4OGhsWTVVZCtHYU9VaDlWL3lnamk3U2NBdmxtZm1GVXVWRCtkek84?=
 =?utf-8?B?c3piZjQ4VjVVMEhOSTVXQ2YrSE1mZXNJaGdTSXZqUjh3OUFmVmxRT3FVR21k?=
 =?utf-8?B?OW1LbE81cW1UeVdQSmkyR0hHOVRXcGxvdnBxdWZPUklSYmM0MlB0ZnhSMk5S?=
 =?utf-8?B?Sk1XZzV1dzRMN295MmJnMkRFZlpHeEtOUFRrcGdZbG5XQUhZRFBFSWRZK3Za?=
 =?utf-8?B?eEVWcktqOWRaQis1SktBN0tFaDEvb0NycDN6c3NCRGR1V2YwOFE4cGdCbGcw?=
 =?utf-8?B?aWlCS29ZbHR2TnJhMG1STHdNa285Q0FVcjFZMkdLMFFDSDdqdnQvT0pUSTBo?=
 =?utf-8?B?L3RGVzZUcllsQVd3TUtCZXZkeUxkWVh6VVIxU0QxN3VJTFBiQWQzSEtXQmlC?=
 =?utf-8?B?MmRSWG9OaFRzZ2FndzNzVGxJczMxUi9vV2FCUkUwbDlrVmhic0lTbDZ2aE1C?=
 =?utf-8?B?Vncza3k0dCtXQkxhNVpDdGdka0pQMzNCNjlMNWY5R1g3V3BOVUhIZEpEUzNG?=
 =?utf-8?B?ZzR0SEZoOGlMTzkvbnFWc2tNWTd1ZktPcnp0Y3V1eGZDRFltYnc5aTl0cU1j?=
 =?utf-8?B?ejFDVG9ucFRrTm5zRG1RMHlVTkNLS2FLVHRhVitUbUl1YkJwMXRLVWNhZ09C?=
 =?utf-8?B?REV2NmhKQkJmWGlqc0d4ZllqdEY2b2RjTVZiOGVVeS9yVFE1c2dnNnRpYzlX?=
 =?utf-8?B?RTFRYlNhTG5rd1pEYk93aHdEUG05Vk5wRm5FSWtIM1pFZ245YlRjRXR1aS9Y?=
 =?utf-8?B?M3JlQ3huVUNkTm9VbnFKUmVJMUtJUnlpc0NWWTAzNEJVcklreEZOYzI0RUQv?=
 =?utf-8?B?SERFTHJFYU54UytQY1RkOWJYU1p1eFRhMzJUSzFMTGY2cnBQUkwzQzZVZWZP?=
 =?utf-8?B?Rm1IZG95Szl4UFl0RGJJRG5idnVubWRlaHJzUW9pMG41YTZFdE1GRXVhS29r?=
 =?utf-8?B?eHhlSjhZd0J2b2tVd2xyMUhJOTNDbGpJUzA5REFLZVdhMkp2VHlpaCsxT2JG?=
 =?utf-8?B?WVpJM25PV1F5VUFESXJZVVVSWGd4TTc3bVFFYTFNOTVrOUJNK25BeXY2ck1x?=
 =?utf-8?B?anN5T1R4V0ttek9FY2tpY09HT3JFMDZlOExJY0xveU9BMlBZTWY4aVFnMDMy?=
 =?utf-8?B?bGMzTGhWdHRDcU10d2U5dXdYVjNJNFhSMFQ3bldTRzNEL1R1SVQ1L0lRRTdB?=
 =?utf-8?B?WnRkWFdIalZndXlxZklMV3NpcnpCcUdtQVZUa3JCNWU4ZHFHTmQwTG5SMitt?=
 =?utf-8?B?QW85T0FZT3RPQUQ4aHQwWXpSdElpbmFrR1l0aUIxeEp1bFMyTkdUNFVoR0w4?=
 =?utf-8?B?Q3lVREEySXBSSE1KeUI3K3NLblZCZGlybk9scnZCa2Z0NnFTc2U1SXJ3L09S?=
 =?utf-8?B?bW9EODJiNU1TaGZlMGxOcnB1ei8yajVBY2VHVTBLbGNvUDhGWWVoaFBJa1hs?=
 =?utf-8?B?N1FMdXZnaDhEaUUwQXE4ckFyNHF6WVY1UGlYb2lpZ3M0TVhmU0J2c1c2cEpZ?=
 =?utf-8?B?U29JTGxxaTJWSk1xOEcvMytybWpua1ZUWlI1YWVWbXhvRkREcm1PVFlWOEdM?=
 =?utf-8?B?RkcxdEd4bnNJZjgwckd4TkdualJEUVdXdzRleDEydmxXd1BPem5RdW1DZU5M?=
 =?utf-8?B?ZjNPVEd2SDB3emFvbjNBeGtoODEwQlRRa1NjYmFaMGNXazVFTFA1aFhYTnhV?=
 =?utf-8?Q?B/NxFQaZ0X6ibJerKa?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9529.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01b33108-fbd8-42e0-da68-08df33ec476f
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2026 05:36:41.3147 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q/BbgpZfgsq5U7qZUQLUuu8usZRTYHSi9TvLv7L9AXm8oqSVT4OH/X6K0pbzwGGhdlt8RWXbLVl3Wg7xfOkbRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6912
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

QU1EIEdlbmVyYWwNCg0KSGkgU2ltb24sDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0N
Cj4gRnJvbTogU2ltb24gR2xhc3MgPHNqZ0BjaHJvbWl1bS5vcmc+DQo+IFNlbnQ6IFdlZG5lc2Rh
eSwgT2N0b2JlciAyMSwgMjAyNiA2OjEzIFBNDQo+IFRvOiBIYW51bWFudCBLYWthZGUsIFN1cmFq
IDxTdXJhai5IYW51bWFudEtha2FkZUBhbWQuY29tPg0KPiBDYzogdS1ib290QGxpc3RzLnUtYm9v
dC1wcm9qZWN0Lm9yZzsgU2ltZWssIE1pY2hhbA0KPiA8bWljaGFsLnNpbWVrQGFtZC5jb20+DQo+
IFN1YmplY3Q6IFJlOiBbUEFUQ0ggUkZDXSBzY3JpcHRzOiBwYXNzIGR0YyBjcHAgZmxhZ3Mgdmlh
IGEgR0NDIHJlc3BvbnNlIGZpbGUNCj4NCj4gSGkgU3VyYWosDQo+DQo+IE9uIDIwMjYtMDgtMjRU
MDQ6NDc6MTgsIFN1cmFqIEtha2FkZSA8c3VyYWouaGFudW1hbnRrYWthZGVAYW1kLmNvbT4NCj4g
d3JvdGU6DQo+ID4gc2NyaXB0czogcGFzcyBkdGMgY3BwIGZsYWdzIHZpYSBhIEdDQyByZXNwb25z
ZSBmaWxlDQo+ID4NCj4gPiBjbWRfZHRjIGlubGluZXMgZHRjX2NwcF9mbGFncyAoaW5jbHVkaW5n
IGV2ZXJ5IHVwc3RyZWFtIGR0c2kgLUkNCj4gPiBwYXRoKSBpbiB0aGUgSE9TVENDIGNvbW1hbmQu
IFdpdGggYSBsb25nICQoc3JjdHJlZSkgdGhhdCBjb21tYW5kIGlzDQo+ID4gdG9vIGxhcmdlIGZv
ciAvYmluL3NoIC1jIGFuZCBNYWtlIGZhaWxzIHdpdGggIkFyZ3VtZW50IGxpc3QgdG9vIGxvbmci
DQo+ID4gd2hpbGUgYnVpbGRpbmcgYSAuZHRiLg0KPiA+DQo+ID4gV3JpdGUgdGhlIGZsYWdzIHRv
IGEgcGVyLXRhcmdldCAuZHRjLmZsYWdzLnRtcCBmaWxlIGFuZCBwYXNzIEBmaWxlIHRvDQo+ID4g
SE9TVENDL0NQUCBzbyB0aGUgc2hlbGwgY29tbWFuZCBzdGF5cyBzaG9ydC4NCj4gPg0KPiA+IFRo
aXMgY2hhbmdlIHJlcXVpcmVzIEdOVSBNYWtlID49IDQuMCwgc2luY2UgJChmaWxlIC4uLikgaXMg
bm90DQo+ID4gc3VwcG9ydGVkIGJ5IE1ha2UgMy54Lg0KPiA+DQo+ID4gRml4ZXM6IGQzMWZmMjE5
YTgzMyAoIk1ha2VmaWxlLmxpYjogZmluZCBjYXBzdWxlIEVTTCBkdHNpIGZpbGUgd2l0aA0KPiA+
IENPTkZJR19PRl9VUFNUUkVBTSIpDQo+ID4gRml4ZXM6IDFlNzg4M2Y2MzI1YSAoImR0Ym86IEZp
eCBkdGJvIGdlbmVyYXRpb24gcnVsZXMiKQ0KPiA+IFNpZ25lZC1vZmYtYnk6IFN1cmFqIEtha2Fk
ZSA8c3VyYWouaGFudW1hbnRrYWthZGVAYW1kLmNvbT4NCj4gPiBSZXZpZXdlZC1ieTogVG9tIFJp
bmkgPHRyaW5pQGtvbnN1bGtvLmNvbT4NCj4gPg0KPiA+ICBzY3JpcHRzL01ha2VmaWxlLmxpYiB8
IDcgKysrKystLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAyIGRlbGV0
aW9ucygtKQ0KPg0KPiA+IGRpZmYgLS1naXQgYS9zY3JpcHRzL01ha2VmaWxlLmxpYiBiL3Njcmlw
dHMvTWFrZWZpbGUubGliIEBAIC00NDgsNw0KPiA+ICs0NDgsOCBAQCBjbWRfZHRjID0gbWtkaXIg
LXAgJChkaXIgJHtkdGMtdG1wfSkgOyBcDQo+ID4gLSAgICQoSE9TVENDKSAtRSAkKGR0Y19jcHBf
ZmxhZ3MpIC1JJChvYmopIC14IGFzc2VtYmxlci13aXRoLWNwcCAtbw0KPiAkKGR0Yy10bXApICQo
cHJlLXRtcCkgOyBcDQo+ID4gKyAgICQoZmlsZSA+JChkdGMtZmxhZ3MtdG1wKSwkKGR0Y19jcHBf
ZmxhZ3MpIC1JJChvYmopKSBcDQo+ID4gKyAgICQoSE9TVENDKSAtRSBAJChkdGMtZmxhZ3MtdG1w
KSAteCBhc3NlbWJsZXItd2l0aC1jcHAgLW8gJChkdGMtdG1wKQ0KPiA+ICskKHByZS10bXApIDsg
XA0KPg0KPiBPbmUgdGhpbmcgSSdkIGxpa2UgdG8gY2hlY2s6IHRoZSAuZHRiIGFuZCAuZHRibyBy
dWxlcyB1c2UgaWZfY2hhbmdlZF9kZXAsDQo+IHdoaWNoIGNvbXBhcmVzIHRoZSBleHBhbmRlZCBj
bWRfZHRiIC8gY21kX2R0Y28gd2l0aCB0aGUgY29tbWFuZA0KPiBzYXZlZCBpbiB0aGUgLmNtZCBm
aWxlLiBTaW5jZSAkKGZpbGUgLi4uKSBleHBhbmRzIHRvIG5vdGhpbmcsIHRoZSBzYXZlZA0KPiBj
b21tYW5kIG5vdyBoYXMgb25seSAnQC4uLi8uZm9vLmR0Yi5kdGMuZmxhZ3MudG1wJw0KPiBhbmQg
bm9uZSBvZiB0aGUgZmxhZ3MuIFNvIGlmIGR0Y19jcHBfZmxhZ3MgY2hhbmdlcyAoYSBuZXcgLUkg
cGF0aCwgYSAtRCBkZWZpbmUsDQo+IGEgZGlmZmVyZW50IERUU19DUFBGTEFHUyksIHRoZSAuZHRi
IGlzIG5vdCByZWJ1aWx0IGFuZCB5b3UgZ2V0IGEgc3RhbGUNCj4gZGV2aWNldHJlZS4gUGxlYXNl
IGNhbiB5b3UgbWFrZSBzdXJlIHRoZSBmbGFncyBzdGlsbCBjb3VudCB0b3dhcmRzIHRoZQ0KPiBj
b21tYW5kIGNoZWNrLCBlLmcuIGJ5IHdyaXRpbmcgdGhlIHJlc3BvbnNlIGZpbGUgb25seSB3aGVu
IGl0cyBjb250ZW50cw0KPiBjaGFuZ2UgYW5kIG1ha2luZyBpdCBhIHByZXJlcXVpc2l0ZSwgb3Ig
YnkgYWRkaW5nIHRoZSBmbGFncyB0byB0aGUgc2F2ZWQNCj4gY29tbWFuZCBzb21lIG90aGVyIHdh
eT8NCj4NCj4gQWxzbywgY21kLWNoZWNrIGV4cGFuZHMgY21kXyQxIGV2ZXJ5IHRpbWUgbWFrZSBs
b29rcyBhdCB0aGUgdGFyZ2V0LCBzbyB0aGUNCj4gZmxhZ3MgZmlsZSBpcyByZXdyaXR0ZW4gb24g
ZXZlcnkgYnVpbGQsIGV2ZW4gd2hlbiB0aGVyZSBpcyBub3RoaW5nIHRvIGRvLg0KPg0KPiA+IGRp
ZmYgLS1naXQgYS9zY3JpcHRzL01ha2VmaWxlLmxpYiBiL3NjcmlwdHMvTWFrZWZpbGUubGliIEBA
IC00NDgsNw0KPiA+ICs0NDgsOCBAQCBjbWRfZHRjID0gbWtkaXIgLXAgJChkaXIgJHtkdGMtdG1w
fSkgOyBcDQo+ID4gKyAgICQoZmlsZSA+JChkdGMtZmxhZ3MtdG1wKSwkKGR0Y19jcHBfZmxhZ3Mp
IC1JJChvYmopKSBcDQo+DQo+IGNtZF9kdGNfZGlmZiAodXNlZCB3aXRoIERFVklDRV9UUkVFX0RF
QlVHKSBzdGlsbCBwdXRzICQoZHRjX2NwcF9mbGFncykNCj4gLUkkKG9iaikgZGlyZWN0bHkgb24g
dGhlIEhPU1RDQyBjb21tYW5kIGxpbmUsIGFuZCBpdCBpcyBwYXJ0IG9mIGNtZF9kdGMsIHNvDQo+
IHRoZSAnQXJndW1lbnQgbGlzdCB0b28gbG9uZycgZmFpbHVyZSBzdGlsbCBoYXBwZW5zIHRoZXJl
Lg0KPiBQbGVhc2UgY2FuIHlvdSBjb252ZXJ0IGl0IHRvbz8gSXQgY2FuIHJldXNlIHRoZSBzYW1l
IHJlc3BvbnNlIGZpbGUuDQo+DQo+IEknZCBhbHNvIGJlIGludGVyZXN0ZWQgdG8ga25vdyB3aGF0
IHNvcnQgb2Ygc3JjdHJlZSB5b3UgYXJlIHVzaW5nIHdoaWNoDQo+IG92ZXJmbG93cyB0aGUgbGlt
aXQuIFdoYXQgaXMgdGhlIGxpbWl0Pw0KDQpUaGUgZmFpbGluZyBidWlsZCBoYWQgYSAkKHNyY3Ry
ZWUpIG9mIDMxMiBjaGFyYWN0ZXJzLg0KVGhlIGxpbWl0IGlzIE1BWF9BUkdfU1RSTEVOLCAxMjgg
S2lCICgxMzEwNzIgYnl0ZXMpIGZvciBhIHNpbmdsZSBhcmd1bWVudCwgd2hpY2ggaXMgd2hhdCBt
YWtlIHBhc3NlcyB0byAvYmluL3NoIC1jIGFzIHRoZSB3aG9sZSByZWNpcGUuIFRoZSBkdGMgY29t
bWFuZCBhcHBlYXJzIG1vcmUgdGhhbiBvbmNlIGluIHRoYXQgc3RyaW5nICh0aGUgY29tbWFuZCBp
dHNlbGYgYW5kIHRoZSBjb3B5IHBhc3NlZCB0byBmaXhkZXApLiBPdmVyIGEgaHVuZHJlZCAtSSBl
bnRyaWVzLCBlYWNoIHN0YXJ0aW5nIHdpdGggJChzcmN0cmVlKSwgYXJlIHBhcnQgb2YgaXQsIHNv
IHRvZ2V0aGVyIHdpdGggdGhlIG90aGVyIGZsYWdzIHRoZSBjb21tYW5kIGdyb3dzIHdpdGggdGhl
IGxlbmd0aCBvZiAkKHNyY3RyZWUpIGFuZCBleGNlZWRzIHRoZSBsaW1pdCBmb3IgYSBsb25nIGVu
b3VnaCBwYXRoLg0KDQpUaGUgb3RoZXIgcG9pbnRzIGFyZSBhZGRyZXNzZWQgaW4gdjM6IGh0dHBz
Oi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDI2MTAxNTA0NDkyMy4yMDYyMTctMS1zdXJhai5oYW51
bWFudGtha2FkZUBhbWQuY29tLw0KDQpUaGFua3MsDQpTdXJhag0K
