Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A437CC6B2F
	for <u-boot@archiver.kernel.org>; Thu, 15 Oct 2026 04:25:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3882E608DA;
	Thu, 15 Oct 2026 04:25:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id skjuSdBs4VHH; Thu, 15 Oct 2026 04:25:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E539D608BA
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792038304;
	b=p97T4uIPjLqh+AqllhxCyVkfeBmR9yxK7SdHFagUHGBJdDCkgUvs/nEbL240tV8kv7Nz
	 dTE8WjcmvwNROYJsVvwAnfYc81YnRA3yMDEkef6JdkcJ2WaK6UHkMy+iBOPWam6yWfO72
	 UZlg7DTeeKQwLzcGH3ylNZnpAJyhbIHYnleFIcOsCEtrYqVdME0hU6FUJSaNx6eDD4nFD
	 JgEn16B00kLdmiqhKCX8dqi/lACuPBy0a/VZsNUCxlQ/jzCClehs1AOEhcZ2WrAQOVnDr
	 95BpREp0Ozzp6lsQf9+gmh1h9/O+aLlNqyAZaXaQecGImfLlJN1qP+GoNRVlp09nsdA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792038304;
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
	bh=mJGbQKMlG1+VbLjPXLjrqHOPfpWwYsTzihr4O2Bxq+Y=;
	b=KSofmKUKHkCTJwfKV6DeJMveQs+/fOiIez3ZKwc8x8boeiUE1N2w+GNsiVFOH6nYIhXU
	 mIeRLriqPNtNdJrm7t5W1E55HQWHPj3Qgiky/VXs3Opq0Eiysr1SS8LwvWormouBJLKbZ
	 a3YoBAy5n9g6DXdN1UC3F6eDJ4h9Ojm0Zsyyjy7/AD0HjcEoXywEQ+E/4RNe9a7tFDesy
	 jLkvKrRWEU+mDgg0BpEzolLdpzbXQR2+cw+4eQ9F+kkyrEaBNju9+HP+x/ngLGpizeW2l
	 lc5EV+lD1qnfysb7WUScN1Xe5XqXdwyfZQ+okJnjm4/m22UB83V35PVTxub19zM3q8A==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792038304;
	bh=mJGbQKMlG1+VbLjPXLjrqHOPfpWwYsTzihr4O2Bxq+Y=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0fKa9jonCEpik7FI2YZLunSuZ8Xarq9kejxi2/w41fJoeS/S5ZZrxFwoUMWuDd1ai
	 8xAwa52JDSp1V55Bh/rhjoPmTwdWUJu/BQ58cjlyEdDJ4v5Gqbh9L8W3w0mW2zmvDc
	 XuE5Y+IzaurhiME+yTztpHaDzCI6x44a5wHoOaDLRo3NX9Z7vPqGjDaecss6lEH8sF
	 9SdWuCzsxCmI2tKFsFAJQ64LY4HZqLFkO6Ps4jshyDDRkX0h5Yi5tkDQlC47MVzxgA
	 OaTVsfhaQ8mJeDzhff43Va/5tscKt9XG9cdTfQ0dI1z/rxDxCtw2zxKqBOnIdNPe0C
	 1e+tA25lLPHIg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E539D608BA;
	Thu, 15 Oct 2026 04:25:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 9BBE0255
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 04:25:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 81EA440807
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 04:25:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XQV417eW6Oxs for <u-boot@lists.u-boot-project.org>;
 Thu, 15 Oct 2026 04:25:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A48384080F
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c10d::1"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792038301;
 b=o8Ze0k1fgv+fLW1QKkUtiBlX3Xkc5HIrBs39Tdzza8OH/q857pahlIg1tUZIR5p3FDkK
 tzWWvuEN4MinZZ0UMTc90+hcIYArOTnBsiNMyfCadjccV0w0u2IB5qwjGWxkI9GoX6O9H
 vVJkLiJsmms023x4s01cAQ8E8FPJ9d1IXyK23cMLV7PM6EOEWdiub31w7EOO0dRoeIY2X
 F7e+QWlo5qm0pzeU8EjRJKpHW3834ZT4AwJsIWSMSWvLzL/ZIUkrqfolT4Z/FLpiZ4W9i
 39EnorEWevLQXd8QHXkIfdfRxM5cqVOePD0iA43RYlq6X4cES0xvie4FrGQvFkHZ4Xw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792038301;
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
 bh=mJGbQKMlG1+VbLjPXLjrqHOPfpWwYsTzihr4O2Bxq+Y=;
 b=OGMXFlGnQwPQGlQPQ86xsmHo6JXDQX98Gl3PHPtUYNrviDQbQF233Fsyu/jq9DNH6yEA
 pkLi5CfxNWfb0lM/hJyJUtv4nOTSVkXIeP0+d6LWYR4LFgE+v9dTrCqnccZHAg0YHOIl/
 pS6BTzLgTqPPlwNZZC2SHQ/RRk5SeMYrvd9nc4Pet7rM0ohaMsZPVg3QyYEPIeTIqeK+Y
 0WNWqUbsLKCtNsjUuQRkbHtfctYMbj6dg0GHCpA5UTZB4wKX0fX3jjR0XC/ZuOpOzsKQY
 gJkN5KgDbuczQuITNgxcIxZ7NORFBffG9ou8+8+Gr6+9yvAbuIiWbPFBGuPLUkvFDTQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=amd.com;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=clw3ngBd; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c10d::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c10d::1;
 helo=sn4pr2101cu001.outbound.protection.outlook.com;
 envelope-from=suraj.hanumantkakade@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=clw3ngBd
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A48384080F
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 04:24:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Znu94kC+bUbvLKen6QCmz998vh8/Wo4NwXTkIV2y56Yjrjq88xsy/o43vdJ3aE6ptiVzbSOD3yzs3r6/8GpPLMN6JMlCl0N3bzgkrQFf4rpAmTxeQjFsBFE1Tlne64hd74EFL/qCr4FvkXVRWOwppm7253zxoD655RuXzdsbxjRwuyx+m5rToAam1KOhKzouMLDZZV2X1g4+u1QYul4GF1Y9psPrDNtp2n8y8HnZdux5f+eVs6Ux++H035rhrI/xSRVORLehWMhyYIUhrlRTqT+8JKYml2J5g6pQEbznKMtZJ8AJ5W1Cr85Brp/fxy/YAa9Sa+z8Kwd5VZGlctKItA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mJGbQKMlG1+VbLjPXLjrqHOPfpWwYsTzihr4O2Bxq+Y=;
 b=QQSs18qd15iNR+tGdWtAiCfoJUpHcCUsZILpGsdNfTrliFxe9WG0ZR6XfMMXrcNytmrJiLy5vdQnwM7kKJnAVgD8qoyKttLwpRFvVNMyIuFIFpAztBxcrrWX9ZtLywOl1BrAyQUg3fDT3+6Fuyg75hgDfkmz48qDe5UoMg0E7JxubA8qm9IL6zWBgXF4GKcBFwOZLSzsdldNZtFYXvBALvjMQOkj4T+Q07jfUUSM6LN18JtF8tgKK2QwwqZfUzkFXoKRnEUQkgbqUhVIDFgXQNERkxNcUtlybkGjKM3DUAI0NfSO5/RzkNMvYJFr7ceLtb6bgO7SMObKm1yG7L3Tjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mJGbQKMlG1+VbLjPXLjrqHOPfpWwYsTzihr4O2Bxq+Y=;
 b=clw3ngBdL+IqDurmZc5+SKSvJZbxUWAo+qVR9zJuJCgCVUWzLj/+6rdsm/J/F6THK3tBXY9R0h7EHxnY4t3WxFS0cQDO7ZH1zaQBsH8g+IKVCHKW32iOrTjQes+40+FPLk3wPbcoYATwQ/mpcPnRpFrpZ53grI4Mo0r7LH4Zux8=
Received: from IA1PR12MB9529.namprd12.prod.outlook.com (2603:10b6:208:592::17)
 by SAAPR12MB676730.namprd12.prod.outlook.com (2603:10b6:802:301::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 04:24:54 +0000
Received: from IA1PR12MB9529.namprd12.prod.outlook.com
 ([fe80::40f6:c7e:1854:4e03]) by IA1PR12MB9529.namprd12.prod.outlook.com
 ([fe80::40f6:c7e:1854:4e03%6]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 04:24:54 +0000
From: "Hanumant Kakade, Suraj" <Suraj.HanumantKakade@amd.com>
To: Simon Glass <sjg@chromium.org>
CC: "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>,
 "Simek, Michal" <michal.simek@amd.com>
Subject: RE: [PATCH v2 1/2] scripts: pass dtc cpp flags via a GCC response file
Thread-Topic: [PATCH v2 1/2] scripts: pass dtc cpp flags via a GCC response
 file
Thread-Index: AQHdUAJDGtZMLZm0AEmfMw3D040J/bbn5kgAgBYuFiA=
Date: Thu, 15 Oct 2026 04:24:54 +0000
Message-ID: <IA1PR12MB95294A372717ED544C48D7C0899C2@IA1PR12MB9529.namprd12.prod.outlook.com>
References: <20260929110315.2879640-1-suraj.hanumantkakade@amd.com>
 <20260929110315.2879640-2-suraj.hanumantkakade@amd.com>
 <CAFLszTgVsth9dWeB8qGY-NivzfvnmDjqpEnC67dwQAhyBc+btw@mail.gmail.com>
In-Reply-To: <CAFLszTgVsth9dWeB8qGY-NivzfvnmDjqpEnC67dwQAhyBc+btw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-10-15T04:03:53.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB9529:EE_|SAAPR12MB676730:EE_
x-ms-office365-filtering-correlation-id: bb83d21a-3e0a-49b5-becb-08df2a74437e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|10067099003|11063799006|56012099006|3023799007|5023799004|18002099003|22082099003|4143699003|38070700021;
x-microsoft-antispam-message-info: jX2sVVlWBQ8t2CsOKI+6rb2MP1SfCd5Ej09tE1zGd3dFjAzo0/orO83nAQL9yQJnUeQm+8zlfxo00WgzbUvRqB9pV1tRUurgNwHqgteTT9AwLynCAzmNd6bQuheCakcJnXZg4MZcTB4UH+riu+X9JkbbfYaiF7nw/q9Wa02KLqprcx2eJg3UXfa10IFV5o4B/j/1pIozPrRXUkqzi2NVukNI9oMrgcozTyrwW4/hLkZegP4AOUFR9tI5I8nN0meRnEQlBizYjoIMlgj3BKLhTrOx2V0+oERsbpR1yXPTnQ4/vFpHVIa6vLNRkREL2DaYxbfESa9zh7rmjYE+TSj+v5yLy0YVlMxiTgof8lxSaoLGkTiwlImveb8FsO1q3XoQ0ulhol33Vka2dtGECB/9WkEFFyl+36tWysrj+Bg2FnJaQm8XQqACW1TRMd/K1MTTXBgTb62yfp4GajR2dUQNdjQkG4PSfGTe3cYI2GIghp2/Uys2MiNiMm4Nc2Ji6CRpqfsqm1JC9DYuqN2YT0iBowMxR3+dLbhbVEhb3iHQO7lL3LyxvX68/DvTzE+YH0jdE8meoZowHWNL5xEPsxDtAaDoya1bwV7UkNFKTdq9SJUkkd7m5TCQuE2XQP9Mjn2mvhDz7buoQiWHRIusRBysuPlKuj4Em7GDlPCTelBUqxrzxmrwDkZ9zeFeo+W/AacZ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB9529.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(10067099003)(11063799006)(56012099006)(3023799007)(5023799004)(18002099003)(22082099003)(4143699003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WTlYbUNURk1FdHIyMmFveUt2MHJjcDJjUjlBaTk5QVg5ZDhDWlgvdGovSmo5?=
 =?utf-8?B?a2orOXhaaVBUVkZoaDM5V1dzS1ZIUXVOK1hxUWplQnRIcnZ5ZGNvemFSZUpv?=
 =?utf-8?B?SnFjV2VsUWpGL0NTK29MWHM3dm1YZFQ1R0d3aVlTTFVJd25IMlc5cTVnQnR6?=
 =?utf-8?B?cmc5OFVtMTFobm51a1ovL0t4Z1JQU3I5a1UvWVBPQWtxRjZPcUdCQ1cxenpV?=
 =?utf-8?B?WE1sM2p5aEkweThXbEhHZ2tFNExCazBvemVDTHVWL0dsRFh6b3poWHVrZHBh?=
 =?utf-8?B?eGdjN21JRDc0NlBtOUJSWEIyUDFtSU9CaWlOWlhwOUN6ekFmS1E4SHBmbnRV?=
 =?utf-8?B?TkRFalh6akFKU0VEeHF3cDNIUWF0U0ZkWkRCQVZvei9TR2Rzam52bTV1T1Nt?=
 =?utf-8?B?V3hvRUFOTEkvMWtsSysyZnVWVGd2eHBXbVVMMVo2LzRVL016RXZBYWhHNXNo?=
 =?utf-8?B?a3NGbFJFT3FGN010dnpMVFJ5dGJzeFZIRzBxSldndmcvZGY5Wk9TeVJDc3NL?=
 =?utf-8?B?enY1UUZRdTJlcFp1OFpnUm42dGJMbDNwcVE3a2RuMU9VbVl1K25wTW5rMER4?=
 =?utf-8?B?cU1xZWkrL2trL2dscGRNbUI4Uzl6Q05sb3lVdkVhbmFvM0dyb3ZkM25nNjRa?=
 =?utf-8?B?clM1MjhZeklvTXdQWTR4UGZuZmNCRVB0NFVWZ3IzN0VwLzNseUluSlF2Y24v?=
 =?utf-8?B?enFJYkF5Z3lzR2xjRzd4Q3FPdjVLZzEwdkJEQTNEZ2twRHlQTTcwNXJETXZT?=
 =?utf-8?B?RHQwNzUvdU5kaG1XSmt0OU45clVtZWdmU0NxUWc1THFlTFhlcS8rRUM2ZmFY?=
 =?utf-8?B?V0Rub2FObkU2WUNEbHpWTU83MDdEbUtYMG9hTDBZWnhuZ2NsNzJrb2c2VVg1?=
 =?utf-8?B?eDZHUXpXcWltVFJsYUlXbGJMZExJUHpzRmRLUEJQeXJqdHpHdHFyZlZCUDNq?=
 =?utf-8?B?R2Z3QXk3dTdMWDRUTFBRVXMyRDJudzV4N3pMUGVOWVRRYlhuRU5kRWhWanhW?=
 =?utf-8?B?eWg2cDNIVkFrRng4bGZzV2VVQ1ZLWkVEZUZ1MGZKbWNXMExiQmd2TnVKN3Jv?=
 =?utf-8?B?ZGRCTDh3RWJvQzNSMTNYb2IvOUh0NmJkQUxNOVlSL0dHRTUxQ2VtUmRhSlhQ?=
 =?utf-8?B?N3RoZHREQ0FHKzZRNlkrWDBXNzhTWUVydXQvNkdNNlV4NFkyRWVrTEEwd2Vm?=
 =?utf-8?B?RXBoK0htWExDQzBQT0hFRWQxOUdPdXlPUjlsdU4wcUtHc2QwWEpzeHFpV1pO?=
 =?utf-8?B?NG1XRnNWenBXYUx0SGMvWmdvZEVnUUhER2dFZXJYMzgwVEtYY01EeHBVRkYx?=
 =?utf-8?B?Z1QvdEI0b0ZFb05RcXREOWdHRnV4ZFZ2a3pTMFRicXVBR1BtdExvSVFvZHBX?=
 =?utf-8?B?UTVIQVI5bFlzUHhMcGluWTdhNUZMVkhSWTQ0Wm5qNmtndng1L0hyRnFSWHNz?=
 =?utf-8?B?RzZJLzVxaU5NSVhLM3BiM3d0QkJoZkxvN0NPOHJWbWtENDQ1Yzkvc05DQWFB?=
 =?utf-8?B?QXpkc1FmMUErTWZXTnU5T0JDcnp2cWdoUks3cE1FSzZRcVVXYTk1bzZUMlBM?=
 =?utf-8?B?cldZbWRQczEyVko1eCtVcnZoWjBHMFg5cEVTSWUyWVQrdzZmWlRzbjZRZHRp?=
 =?utf-8?B?M2REb3dpTmdvVU8vVHlwbjBXQ254dUl2UzJXNFQvcWNWQWtJcDhzTG8rSkNT?=
 =?utf-8?B?NU9xcnc5SW9LcU1YMEhKb1MxNXJHd1dFdGhrRVYxeVpCN25jc1VxclpQQmJG?=
 =?utf-8?B?aVhZdFptb0VzTHlRUGRmY0NsREJ2Y3ZnbDkxUHNMT0VVTkVrRFI3QUdJSnVv?=
 =?utf-8?B?dUtvMFpIenJHUG1KeUFTQW1yNHcvMHZReDlGRTl3NkxXV3FKc25hWndaZldF?=
 =?utf-8?B?WldkT29Fb1ptZ1lQb1N0Tm51N2dycStIdTBQNXVxVXRVZHh2cVk1ZWwzbVFw?=
 =?utf-8?B?SUtyL0VCYjdiY25rWCtoQWtTTS9wVDFFYldXbEl2NDFLeUpDRTZ2cmx4blN2?=
 =?utf-8?B?TmQzK3A2Wkttd1U0UUw1MVgzbHZ3ZUFqZ2E2Sk1OS2lHRVBXK0gyL25vdHpZ?=
 =?utf-8?B?UDJwdlNmMklLS3dYMGxXMFhxRDlHOWZaa1N3ZXU3Uk5SOXgwaElycXl4TWlV?=
 =?utf-8?B?a3Fxc1l6VnFsUU03MlZLTUhheFhyclBQSnlERmZvR09KY2NxZUtYYU8zeHFn?=
 =?utf-8?B?MStpazdueDdHUDB4bjc2T3FZaSs2ZjhwRzQ1L1k2YWFmRVJjS0NlSW5tSGVy?=
 =?utf-8?B?ckQ2dTEydlVYU2dRc0dhYmxleHIvZ0JySFJ6a01zaDFRL0R2dGR1WGRFNWNH?=
 =?utf-8?Q?8aE7g/3biUxQgdeLcO?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9529.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb83d21a-3e0a-49b5-becb-08df2a74437e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2026 04:24:54.6682 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K8Tue0iFj6a8ACMfYiQzH8HNt4hXAOhj1yD45iztNlsYdKq8iP0y4zRJwLTgNvYqAlUGEzgx5bm7UEDvioSR+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAAPR12MB676730
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
Errors-To: u-boot-bounces@lists.u-boot-project.org

QU1EIEdlbmVyYWwNCg0KSGkgU2ltb24sDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0N
Cj4gRnJvbTogU2ltb24gR2xhc3MgPHNqZ0BjaHJvbWl1bS5vcmc+DQo+IFNlbnQ6IFRodXJzZGF5
LCBPY3RvYmVyIDEsIDIwMjYgNjo1MSBBTQ0KPiBUbzogSGFudW1hbnQgS2FrYWRlLCBTdXJhaiA8
U3VyYWouSGFudW1hbnRLYWthZGVAYW1kLmNvbT4NCj4gQ2M6IHUtYm9vdEBsaXN0cy51LWJvb3Qt
cHJvamVjdC5vcmc7IFNpbWVrLCBNaWNoYWwNCj4gPG1pY2hhbC5zaW1la0BhbWQuY29tPg0KPiBT
dWJqZWN0OiBSZTogW1BBVENIIHYyIDEvMl0gc2NyaXB0czogcGFzcyBkdGMgY3BwIGZsYWdzIHZp
YSBhIEdDQyByZXNwb25zZSBmaWxlDQo+DQo+IEhpIFN1cmFqLA0KPg0KPiBPbiAyMDI2LTA5LTI5
VDExOjAyOjUyLCBTdXJhaiBLYWthZGUgPHN1cmFqLmhhbnVtYW50a2FrYWRlQGFtZC5jb20+DQo+
IHdyb3RlOg0KPiA+IHNjcmlwdHM6IHBhc3MgZHRjIGNwcCBmbGFncyB2aWEgYSBHQ0MgcmVzcG9u
c2UgZmlsZQ0KPiA+DQo+ID4gY21kX2R0YyBpbmxpbmVzIGR0Y19jcHBfZmxhZ3MgKGluY2x1ZGlu
ZyBldmVyeSB1cHN0cmVhbSBkdHNpIC1JDQo+ID4gcGF0aCkgaW4gdGhlIEhPU1RDQyBjb21tYW5k
LiBXaXRoIGEgbG9uZyAkKHNyY3RyZWUpIHRoYXQgY29tbWFuZCBpcw0KPiA+IHRvbyBsYXJnZSBm
b3IgL2Jpbi9zaCAtYyBhbmQgTWFrZSBmYWlscyB3aXRoICJBcmd1bWVudCBsaXN0IHRvbyBsb25n
Ig0KPiA+IHdoaWxlIGJ1aWxkaW5nIGEgLmR0Yi4NCj4gPg0KPiA+IFdyaXRlIHRoZSBmbGFncyB0
byBhIHBlci10YXJnZXQgLmR0Yy5mbGFncy50bXAgZmlsZSBhbmQgcGFzcyBAZmlsZSB0bw0KPiA+
IEhPU1RDQy9DUFAgc28gdGhlIHNoZWxsIGNvbW1hbmQgc3RheXMgc2hvcnQuDQo+ID4NCj4gPiBU
aGlzIGNoYW5nZSByZXF1aXJlcyBHTlUgTWFrZSA+PSA0LjAsIHNpbmNlICQoZmlsZSAuLi4pIGlz
IG5vdA0KPiA+IHN1cHBvcnRlZCBieSBNYWtlIDMueC4NCj4gPg0KPiA+IEZpeGVzOiBkMzFmZjIx
OWE4MzMgKCJNYWtlZmlsZS5saWI6IGZpbmQgY2Fwc3VsZSBFU0wgZHRzaSBmaWxlIHdpdGgNCj4g
PiBDT05GSUdfT0ZfVVBTVFJFQU0iKQ0KPiA+IEZpeGVzOiAxZTc4ODNmNjMyNWEgKCJkdGJvOiBG
aXggZHRibyBnZW5lcmF0aW9uIHJ1bGVzIikNCj4NCj4gVGhlc2UgdHdvIGNvbW1pdHMgb25seSB0
b3VjaGVkIHRoZSBsaW5lcyBiZWluZyBjaGFuZ2VkIChvbmUgYWRkZWQgLQ0KPiBJJChvYmopLCB0
aGUgb3RoZXIgcmVwbGFjZWQgJy0nIHdpdGggJDwpLCBhbmQgbmVpdGhlciBtYWRlIHRoZSBjb21t
YW5kIGxpbmUNCj4gbG9uZy4gVGhlIGxlbmd0aCBjb21lcyBmcm9tIHVwc3RyZWFtX2R0c2lfaW5j
bHVkZSwgYWRkZWQgYnkgM2E0ZTU5NDRjOTYNCj4gKCJNYWtlZmlsZTogQWxsb3cgdXBzdHJlYW0g
RFQgc3VidHJlZSB0byBwcm92aWRlIERUIGluY2x1ZGVzIiksIGNvbWJpbmVkDQo+IHdpdGggYSBs
b25nICQoc3JjdHJlZSkuIFBsZWFzZSBjYW4geW91IGVpdGhlciBwb2ludCB0aGUgRml4ZXMgdGFn
IGF0IHRoYXQgY29tbWl0DQo+IG9yIGRyb3AgdGhlc2UgdHdvIHRhZ3M/DQoNClN1cmUuIEkgd2ls
bCBwb2ludCB0aGUgRml4ZXMgdGFnIGF0IDNhNGU1OTQ0Yzk2Yw0KKCJNYWtlZmlsZTogQWxsb3cg
dXBzdHJlYW0gRFQgc3VidHJlZSB0byBwcm92aWRlIERUIGluY2x1ZGVzIikgaW4gdjMuDQoNCj4N
Cj4gPiBTaWduZWQtb2ZmLWJ5OiBTdXJhaiBLYWthZGUgPHN1cmFqLmhhbnVtYW50a2FrYWRlQGFt
ZC5jb20+DQo+ID4gUmV2aWV3ZWQtYnk6IFRvbSBSaW5pIDx0cmluaUBrb25zdWxrby5jb20+DQo+
ID4NCj4gPiBzY3JpcHRzL01ha2VmaWxlLmxpYiB8IDcgKysrKystLQ0KPiA+ICAxIGZpbGUgY2hh
bmdlZCwgNSBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPg0KPiA+IGRpZmYgLS1naXQg
YS9zY3JpcHRzL01ha2VmaWxlLmxpYiBiL3NjcmlwdHMvTWFrZWZpbGUubGliIEBAIC00NDgsNw0K
PiA+ICs0NDgsOCBAQCBjbWRfZHRjID0gbWtkaXIgLXAgJChkaXIgJHtkdGMtdG1wfSkgOyBcDQo+
ID4gLSAgICAgJChIT1NUQ0MpIC1FICQoZHRjX2NwcF9mbGFncykgLUkkKG9iaikgLXggYXNzZW1i
bGVyLXdpdGgtY3BwIC1vICQoZHRjLQ0KPiB0bXApICQocHJlLXRtcCkgOyBcDQo+ID4gKyAgICAg
JChmaWxlID4kKGR0Yy1mbGFncy10bXApLCQoZHRjX2NwcF9mbGFncykgLUkkKG9iaikpIFwNCj4g
PiArICAgICAkKEhPU1RDQykgLUUgQCQoZHRjLWZsYWdzLXRtcCkgLXggYXNzZW1ibGVyLXdpdGgt
Y3BwIC1vDQo+ID4gKyAkKGR0Yy10bXApICQocHJlLXRtcCkgOyBcDQo+DQo+IFRoaXMgYnJlYWtz
IHRoZSBjb21tYW5kLWxpbmUgY2hlY2sgaW4gaWZfY2hhbmdlZF9kZXAuIEJvdGggY21kLWNoZWNr
IGFuZA0KPiBtYWtlLWNtZCB3b3JrIG9uIHRoZSBleHBhbmRlZCBjbWRfZHRiLCBhbmQgJChmaWxl
IC4uLikgZXhwYW5kcyB0byBhbg0KPiBlbXB0eSBzdHJpbmcuIFRoZSBjbWRfIGxpbmUgc2F2ZWQg
aW4gdGhlIC5jbWQgZmlsZSB0aGVyZWZvcmUgaG9sZHMgb25seQ0KPiAnQC4uLi8uZm9vLmR0Yi5k
dGMuZmxhZ3MudG1wJyBhbmQgbm9uZSBvZiB0aGUgZmxhZ3MuIElmIGR0Y19jcHBfZmxhZ3MgY2hh
bmdlcyAoYQ0KPiBuZXcgLUkgcGF0aCBhZnRlciBhIGR0cy91cHN0cmVhbSBzeW5jLCBhIGNoYW5n
ZSB0byBVQk9PVElOQ0xVREUsIG9yIGEgbmV3IC0NCj4gRCksIHRoZSBjb21wYXJlZCBzdHJpbmcg
c3RheXMgdGhlIHNhbWUuIFRoZSAuZHRiIGlzIHRoZW4gbm90IHJlYnVpbHQgYW5kIHN0YWxlDQo+
IG91dHB1dCBpcyBsZWZ0IGJlaGluZC4NCj4gVGhlIHNhbWUgYXBwbGllcyB0byBjbWRfZHRjby4N
Cj4NCj4gQWxzbywgY21kLWNoZWNrIGV4cGFuZHMgY21kX2R0YiBvbiBldmVyeSBtYWtlIHJ1biwg
c28gdGhlIGZsYWdzIGZpbGUgaXMNCj4gcmV3cml0dGVuIGZvciBldmVyeSBkdGIgZXZlbiBvbiBh
IG5vLW9wIGJ1aWxkLg0KPg0KPiBBbHNvLCAkKGZpbGUgPi4uLikgcnVucyB3aGVuIG1ha2UgZXhw
YW5kcyB0aGUgcmVjaXBlLiBUaGF0IGlzIGJlZm9yZSB0aGUgc2hlbGwNCj4gcnVucyB0aGUgJ21r
ZGlyIC1wICQoZGlyICR7ZHRjLXRtcH0pJyBhdCB0aGUgc3RhcnQgb2YgdGhlIHNhbWUgY29tbWFu
ZCwgc28gaWYNCj4gdGhlIGRpcmVjdG9yeSBkb2VzIG5vdCBleGlzdCB5ZXQsIG1ha2Ugc3RvcHMg
d2l0aA0KPiAnb3BlbjogTm8gc3VjaCBmaWxlIG9yIGRpcmVjdG9yeScuIE1ha2VmaWxlLmJ1aWxk
IG5vcm1hbGx5IGNyZWF0ZXMgb2JqLWRpcnMgZm9yDQo+ICQodGFyZ2V0cyksIHNvIHRoaXMgbWF5
IG5vdCBoYXBwZW4gaW4gcHJhY3RpY2UuIEJ1dCB0aGUgbWtkaXIgaXMgdGhlcmUgZm9yIGENCj4g
cmVhc29uLCBhbmQgSSBhbSBub3Qgc3VyZSBldmVyeSBkdGIvZHRibyBydWxlIGdvZXMgdGhyb3Vn
aCB0aGF0IHBhdGguIFBsZWFzZQ0KPiBjYW4geW91IGNoZWNrIHdpdGggYSBjbGVhbiBPPSBidWls
ZCwgaW5jbHVkaW5nIHRoZSBkdGJvIGNhc2U/DQoNCkkgY2hlY2tlZCB3aXRoIGNsZWFuIE89IGJ1
aWxkcywgaW5jbHVkaW5nIGJvYXJkcyB0aGF0IGJ1aWxkIGR0Ym8gZmlsZXMsIGFuZCB0aGV5DQph
bGwgYnVpbGQgd2l0aG91dCBlcnJvcnMuIEFzIHlvdSBzYWlkLCB0aGlzIHdvcmtzIGJlY2F1c2Ug
TWFrZWZpbGUuYnVpbGQgY3JlYXRlcw0KdGhlIG9iamVjdCBkaXJlY3RvcmllcyBmaXJzdC4NCg0K
Pg0KPiBUbyBrZWVwIHRoZSByZWJ1aWxkIGNoZWNrLCBvbmUgb3B0aW9uIGlzIHRvIGxlYXZlICQo
ZHRjX2NwcF9mbGFncykgaW4gdGhlDQo+IGNvbXBhcmVkIHN0cmluZyB3aXRob3V0IHBhc3Npbmcg
aXQgdG8gdGhlIHNoZWxsLCBlLmcuIGJ5IG92ZXJyaWRpbmcgY21kLWNoZWNrDQo+IGZvciB0aGVz
ZSB0YXJnZXRzIG9yIHVzaW5nIGEgZmlsZWNoay1zdHlsZSBydWxlIGZvciB0aGUgZmxhZ3MgZmls
ZS4gQW5vdGhlciBvcHRpb24NCj4gaXMgdG8gc2hvcnRlbiB0aGUgY29tbWFuZCBsaW5lIGl0c2Vs
Zi4gWW91IGNvdWxkIHVzZSByZWxhdGl2ZSBwYXRocyBmb3IgdGhlDQo+IHVwc3RyZWFtIGluY2x1
ZGUgZGlyZWN0b3JpZXMsIG9yIGZpeCB1cHN0cmVhbV9kdHNpX2luY2x1ZGU6IGl0cyAkKGlmDQo+
IChDT05GSUdfQVJNNjQpLA0KPiAuLi4pIGlzIG1pc3NpbmcgYSAnJCcsIHNvIHRoZSBjb25kaXRp
b24gaXMgYWx3YXlzIHRydWUgYW5kIHRoZSBhcm02NCBpbmNsdWRlDQo+IGRpcmVjdG9yaWVzIGFy
ZSBhZGRlZCBmb3IgZXZlcnkgYXJjaC4gV2hhdCBkbyB5b3UgdGhpbms/DQoNCkkgYWxyZWFkeSB0
cmllZCBmaXhpbmcgdGhlIG1pc3NpbmcgJyQnIGluIGEgc2VwYXJhdGUgcGF0Y2gNCihodHRwczov
L2xvcmUua2VybmVsLm9yZy9hbGwvMjAyNjA4MjgxODA3MDQuR0EyMzk0MjhAYmlsbC10aGUtY2F0
LyksIGJ1dA0KaXQgYnJva2UgdGhlIGJ1aWxkIGZvciBzb21lIGJvYXJkcy4NCg0KSW5zdGVhZCwg
djMgd2lsbCBrZWVwIHRoZSBmbGFncyBvdXQgb2YgdGhlIHNoZWxsIGNvbW1hbmQgbGluZSB3aXRo
IGEgcmVzcG9uc2UgZmlsZQ0KYW5kIGtlZXAgdGhlbSBpbiB0aGUgY29tcGFyZWQgc3RyaW5nIHdp
dGggdGhlIGNtZC1jaGVjayBvdmVycmlkZS4gVGhpcyBhbHNvDQpmaXhlcyB0aGUgc3RhbGUtb3V0
cHV0IGFuZCBuby1vcCByZXdyaXRlIHByb2JsZW1zIHlvdSBwb2ludGVkIG91dCwgYW5kIHdvcmtz
DQpmb3IgYW55ICAkKHNyY3RyZWUpIGxlbmd0aCB3aXRob3V0IGNoYW5naW5nIHdoaWNoIGluY2x1
ZGUgcGF0aHMgYXJlIHVzZWQuDQoNCj4NCj4gPiBkaWZmIC0tZ2l0IGEvc2NyaXB0cy9NYWtlZmls
ZS5saWIgYi9zY3JpcHRzL01ha2VmaWxlLmxpYg0KPiA+IEBAIC00ODYsNyArNDg4LDggQEAgcXVp
ZXRfY21kX2R0Y28gPSBEVENPICAgICRADQo+ID4gLSAgICAgJChDUFApICQoZHRjX2NwcF9mbGFn
cykgLXggYXNzZW1ibGVyLXdpdGgtY3BwIC1vICQoZHRjLXRtcCkgJDwgOyBcDQo+ID4gKyAgICAg
JChmaWxlID4kKGR0Yy1mbGFncy10bXApLCQoZHRjX2NwcF9mbGFncykpIFwNCj4gPiArICAgICAk
KENQUCkgQCQoZHRjLWZsYWdzLXRtcCkgLXggYXNzZW1ibGVyLXdpdGgtY3BwIC1vICQoZHRjLXRt
cCkgJDwNCj4gPiArIDsgXA0KPg0KPiBUd28gb3RoZXIgcGxhY2VzIHN0aWxsIHBhc3MgJChkdGNf
Y3BwX2ZsYWdzKSBpbmxpbmU6IGNtZF9kdGNfZGlmZiAodXNlZCB3aXRoDQo+IERFVklDRV9UUkVF
X0RFQlVHKSBhbmQgZHRzL3Vwc3RyZWFtL01ha2VmaWxlLiBjbWRfZHRjX2RpZmYgaXMgYXBwZW5k
ZWQNCj4gdG8gY21kX2R0Yywgc28gd2l0aCBERVZJQ0VfVFJFRV9ERUJVRyBzZXQgdGhlIGNvbW1h
bmQgaXMgc3RpbGwgdG9vIGxvbmcuDQo+IFBsZWFzZSBjYW4geW91IGhhbmRsZSB0aG9zZSB0b28s
IG9yIHNheSBpbiB0aGUgY29tbWl0IG1lc3NhZ2Ugd2h5IHRoZXkgYXJlDQo+IGxlZnQgYWxvbmU/
DQoNClN1cmUsIGluIHYzIGNtZF9kdGNfZGlmZiB3aWxsIHVzZSB0aGUgcmVzcG9uc2UgZmlsZSB0
b28uDQpkdHMvdXBzdHJlYW0vTWFrZWZpbGUgd2lsbCBiZSBsZWZ0IGFsb25lLCBzaW5jZSBpdCB1
c2VzIHNob3J0IHJlbGF0aXZlIGluY2x1ZGUNCnBhdGhzIGFuZCBJIHdpbGwgYWRkIHRoYXQgdG8g
dGhlIGNvbW1pdCBtZXNzYWdlLg0KDQpUaGFua3MsDQpTdXJhag0K
