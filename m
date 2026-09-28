Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5562CA5FA2
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 11:21:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0F68640604;
	Mon, 28 Sep 2026 11:21:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9BRWyjWgWHGt; Mon, 28 Sep 2026 11:20:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 2354A405F3
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790594459;
	b=d/EQY3CiWZEzcYPaNxOPXI/EQznYwML3TEB0WXo+gD0j5u6seoaBySkBtRWzR/amT3uN
	 RXUAP71O7lXZ1Lci8r3u6QbH/d8RLP4HKuLpug7iPMCrJu1i97R0n1zOZS5H4vRMT9hCN
	 LH2rpn5Qu1SuPGMcGwQ7YKwviEk1Ec6uNAvXigdDFtBpf6pLm7m1yoZVCOA6bhU0lYfm7
	 EgIKhwomsp3B5IbWMGwlTDuU09KQ5tkFu8krFi38a9Lxnd+bvJM0ud/OvRwJgodzFDSDj
	 9uyR4KdxilhQpvvqKUswGC3dlKa53l0Txw2yiF/H9ASbyb7iZBSFNaOkHIeLM8qH5Dg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790594459;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:CC:Subject:Thread-Topic:
	 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:msip_labels:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ld-processed:
	 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
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
	bh=Qm4Bk5tk6NWo0XfrKqZMxp4udHj3wrPVu+fOGiXKc/I=;
	b=iQcIDCZfZcVBIZEsQ+w/PbGkTVSRiwcj+e5zA5+2yIJBRjPYYwBLH5sIp5qYliU70kG+
	 5CcfEznHePdeaNZj04yzl6Smew0GROjDnqCoCr3y2E6rkb1se2db0NMFfdnNuCif85gGv
	 B2H2pofj5dCOwVTkHnmU+jM1Y1cjncuyId9i+E2oArpd7WDqPefN/NT5Zxu1vTTyMITPM
	 rPbwaAUGY38SnbeHdTJk6Z2pc9vG00ZES5hLW/rKqkzOxEh8o0c9h8gBkF4KhSRTvaeZH
	 ySt/zT3djGmJ5gmX9+//RjYSRRmluBb73y9N+UkIiLlSEpWtcB52X23gB2QTdA1CMFg==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790594459;
	bh=Qm4Bk5tk6NWo0XfrKqZMxp4udHj3wrPVu+fOGiXKc/I=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uwEKeJycGn8RjNVc+JMW9edolEufhc0gj36bgN1920V4rvg2EtKoMI34ULt1d2NqX
	 juy6Kch2Ari7Vd5JIR95C9bTezckgk6C9mfkLqFOfRdW3BiYn3N1Ya50Y0DdYWyn2F
	 sLERk0NTmtlBRfajHY1JTEtjzv6sqeUqKVDnHsJtoIlb9q+SO27+AuKcv2SHNvekEL
	 4zUrBVr7uSzS3tX/zUOAZn7L7UV3aXWRC1EAeYuNKbT8OvJAe26cveSYHyNwMUNJn1
	 1gHV+K6Vc5897Nc6i2Ku0FBZpxgDVdPzAVecpMqV+rl3qRYZxOOy7zHjw6CgdB9Fkh
	 fE8VKE6yrxjhQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2354A405F3;
	Mon, 28 Sep 2026 11:20:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 48DF672
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 11:20:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2E6A4400DB
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 11:20:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id S0KhsgnWDfAS for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 11:20:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org E77D540063
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c100::f"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790594457;
 b=e2+rePiuv32mxCWHFq1rd+Obd9f2Ur/4x5qbz4LB1VQoPjwWcT1CO1r815OokFD7TP2X
 xelZYsOUh3bOzCUYhrdvkQ2/5Dw4hkw/xqZf9vJwKBxbm7Sf3Ce92iUOtUKpP6hEOuVIp
 stsApN9uscG2RC1Lji9wuc8LRMzSV/NEMFeRlDpWol5UTpGNxmTeLVDmAM+uAPlkdvs8x
 9NoY7K2mcxIXWyoXItsgihcg9wODyOFkNu7I5A+pqDie3Qr91hjFVg5ymI59Ejz4HEB4/
 A9ThmVAaDLLWW+L0dn7nG4ARRQ4RyIMaq8bi41UL7a4dK2HkQnMooLzlDW/v06suYuw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790594457;
 h=Received-SPF:DKIM-Signature:Received:Received:From:To:CC:Subject:
 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
 msip_labels:x-ms-publictraffictype:x-ms-traffictypediagnostic:
 x-ms-office365-filtering-correlation-id:x-ld-processed:
 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
 x-microsoft-antispam:x-microsoft-antispam-message-info:
 x-forefront-antispam-report:
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
 bh=Qm4Bk5tk6NWo0XfrKqZMxp4udHj3wrPVu+fOGiXKc/I=;
 b=HjOqNlKD+nj9cxEpbBUlFappfy0YHYo8HPuMDkGQfbEdkcm0D97YV52pmx15esrd9Ycj
 JtzlzADcn/gfgqVhysZhTyyjFrUS7CIUhEc1WW4IC3cMnqDfMVyOFnDTCjT46SsLIhmzd
 6asc+zVwGg6WH0/seWXrQPHTqng+FDDTa+3+xUcmdB9WG9ST+jMZOcVU/v41Rjg6DZbXh
 gtEe9XIDnaaOt3bFUZ8kcXH/+mrhYduqLBcppN6d59RqUeKW5JyckrvpXqFsTosxtRhej
 rfIZzf+ZwQwUu4MF/pxG1vFQdry/YtNWcuAI1uobkf+Eob9JgAiMcAwuCrJKD4Oyb6g==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=amd.com; 
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=UGLp2exT; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c100::f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c100::f;
 helo=bl2pr02cu003.outbound.protection.outlook.com;
 envelope-from=prasad.kummari@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=UGLp2exT
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazlp17011000f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c100::f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E77D540063
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 11:20:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ieWQPgdRjc7b79DcyrKqC7a3fRDVIextX7tLmw1YPZv0+Cf8OpZoJR/tDQyI6vSgJ53CV5f1/69pbsce93MrYo+xi0ha2Ya8NGUaaxQDxZe+mE3w/1jNjWr4UbrtBAUz29BcINzIYxvlYShXktlV77ffNDygy7hyIB2qIYXti5YhNTAoUWmCEinQ8CGj9c/92kPpBju7022+2Hbc0r/rIwA8JrAkqvxLSDLgZiodWjM+MArLerfEszfMF3wzoDLopm8RkyzmDXhDxZrliiFPpyqh9xZmjEpH4pyv2Fwmgb1xzT3+bnaDOfW0tg0PoSh2Sp7eNRtzehFWHtVW2bzRHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qm4Bk5tk6NWo0XfrKqZMxp4udHj3wrPVu+fOGiXKc/I=;
 b=fdl5MRVNoQbmd8ICDTHYixyyctpdmeFxCfMlC5/kWTFBMWWWmH5hHcraDHOF6V0Mhfee4DONPHx45tSZdiQSEhcqIPiqWTTERBORF8B6BT/sDd0uwtgze3OIp1o4vYosp2SyophIK3bAg3fgG20qyDzLSwXIL5WtPK3AzSbidPUxdRKxkfl1p997dN0ByjtbZgHJoii9VmU5mjHYbR/70nSiHxaZt1xIgG3vvhKCYLtjSDQmzNw0YkJrL2bQEmRFX5yObTNs0QOXv91+2NoP5Ea2PB2OG3cbRwkKzurRTYZaOls6Ir7zHa+hzU0A0rg4MIVpqnVT5WffeKh8cDDExA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qm4Bk5tk6NWo0XfrKqZMxp4udHj3wrPVu+fOGiXKc/I=;
 b=UGLp2exTANXM50DArHSNY/u+CMjSiOV3AY+EWaR4/N+IZKgGpVXV1L5aDBNci1BHO35auhtj5k/SklsNxvSFgoM8rvqAES6Wu4uUs1cwoAXrkLtyH7yYzNZAR8+SyJgkFDT+q9+ZE/8GcAUK6miBbT/S+AZdSANMciecnl4UcoA=
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 DS0PR12MB6440.namprd12.prod.outlook.com (2603:10b6:8:c8::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.19; Mon, 28 Sep 2026 11:20:49 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::d4d7:bf8:c51f:6473]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::d4d7:bf8:c51f:6473%6]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 11:20:49 +0000
From: "Kummari, Prasad" <Prasad.Kummari@amd.com>
To: "Kummari, Prasad" <Prasad.Kummari@amd.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, "u-boot@lists.u-boot-project.org"
 <u-boot@lists.u-boot-project.org>, "git (AMD-Xilinx)" <git@amd.com>,
 "Dhanawade, Mohan" <mohan.dhanawade@amd.com>
CC: "Simek, Michal" <michal.simek@amd.com>, "Begari, Padmarao"
 <Padmarao.Begari@amd.com>, "Belsare, Akshay" <akshay.belsare@amd.com>
Subject: RE: [UBOOT PATCH] fpga: versalpl: fix OOB write in
 versal_align_dma_buffer()
Thread-Topic: [UBOOT PATCH] fpga: versalpl: fix OOB write in
 versal_align_dma_buffer()
Thread-Index: AQHdTzhkbHAjaBSC7kmJNIsdwGlaVLbj1CMQ
Date: Mon, 28 Sep 2026 11:20:48 +0000
Message-ID: <CO6PR12MB54448F5E387F57A271473C7C828D2@CO6PR12MB5444.namprd12.prod.outlook.com>
References: <20260928105742.86144-2-prasad.kummari@amd.com>
In-Reply-To: <20260928105742.86144-2-prasad.kummari@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-09-28T11:05:36.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR12MB5444:EE_|DS0PR12MB6440:EE_
x-ms-office365-filtering-correlation-id: f5a77def-24fe-4653-4b33-08df1d528c65
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|38070700021|10067099003|11063799006|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info: lsn57dgZ3MkM1e1E6DaWutZQV1bFRedVR3dC6hiu/o2Jyse3xN9Sfpz6wNLj9E7E+LfPhFB9K5Wnbkp/2PXzcj3hWgimt6GvrOiLMtWIeNHeoZdaJy6NCuGiEd/T5bfSYfr7kb8b3Wson2y7KW70dlgYipARC11RS1RBwTRjvvZTqnD/xK0LYZS3dHDWHRepFNuKAOnGTOlNMcePtPpjouNlOunYEYTuiEKmHdd07nup+Totls29qaYceQWRExKsDtUOD5kqbRe2WWpduTeCEnBT5m3PfIFAWbJVhNGBgTqXG6yn21cUl7uQWVFdY6Zwl/AV1L48e7e8hODYL52U+p8SyUgUh+4hFlo9NCDs9yZUR5g9I2VaI5PbEi/q2GUHAJjbvQt0tg0cAGf/ucMr0stuvpcdqQOKtu5BxwIj0sKbNL3yD8on9hr4QrL9U80S8m6fuIbaRnHNrXj2xnndXxkSZqNmWOcxYI4peu9F+mk4CJOmd729BL666Ify1lbGHgYwILjR+hR7KF40O8U2SqoIAqVLAP0Gtc36940YL3I6UvacD6TIewMKvxBH716rnjvYVkM8Vv0OwNICCkSJpOzv0u8a8IoccvfLT2hDAFC4zbMA5rrEUOf0TYjUjjzlQP89sLbphBMDskajHHVwuSgD9VS/pay+5J9Q54Ub7YLEh4D/wKFn0ggaxBkRAdTdI2orBjOemRYWMqR8vDO3Tw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5444.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(38070700021)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T1puNVBmbXhJUVlJQjJCbGUzM0UrWUxnaEh0U3QwWHlTWkNoUDBRMXhMODNU?=
 =?utf-8?B?UVR3cjh6eFU3cTJkekJDeGF5M3RBQUZOeEhtSmlSTXBNdXAzVFRBbnRTMDNR?=
 =?utf-8?B?akVSZGsxTkx4RDZiUy9sdTZCRUVlMDFqL0NzNE5RY2lncGdrU2ZuRkJqaWph?=
 =?utf-8?B?L0xHY00xSzJ0aU5GTEhNV0kyV3Bab1A5a3p5NmxpZmRlSlJiUUpYMG11djcz?=
 =?utf-8?B?akh4MzBRTjFQV09UTnZKWm5OQzNtcncrU2hOakc4blE5TllIQmNUNzg0S3pO?=
 =?utf-8?B?VzJ1ZEx3MUFDandBdk5MdzR6Z0Q0WjVtczJja3ltTWRUb1hnVUk1cXo3Qnh4?=
 =?utf-8?B?S3JxdWo5UHM1WnM3dXcwKy9McVdiOUl4eDV4ZHZVUUgzeVl0dkRsUjVSN2Ix?=
 =?utf-8?B?RFVVRXJqcUV6ZlVnK054bnhmdEx2QnYvaXVMaisvOENFQi9KTmJnaTJ5WGU1?=
 =?utf-8?B?V2FRaWVGeUVNUGRQbVJYd2RuMWd5Qnl4anMrR254V0dORGZUOHowcjBqbldx?=
 =?utf-8?B?dEx5L2xUK2Q0R3htR2pNMllxSFQwYThjZUgyVytyM1E5SzFDbVpRWWMrR0dG?=
 =?utf-8?B?eDVLT0NoZGtFdmVsWU54bEJXRW5IOU9TR010cFJTeUFYM1BlcXhVWThETTYw?=
 =?utf-8?B?bWxYNmJDcW8zVktlR1FOM1hDVy9kRVVqV3YveE1keDN4UGVkOVZnQVE3cnZQ?=
 =?utf-8?B?a0dkZ3lUYXNVektEMUdML0lCT0QvZ2RWUkFNSmVVcmtVTlNYamltakQ4eHdG?=
 =?utf-8?B?WmdPR0c4QjBONlY1RWNiSFdsN2JIZmdHSUEyTDlhNGxzcTNoWitjdUxXM0Zo?=
 =?utf-8?B?bGFUMmk2aUhqYXQwemVEbk9JenMvZ0V3S2I4bHlPWC9Yb3ArSzgxODJCaHEy?=
 =?utf-8?B?TXNPei9XblZKT1FzTm1tWU5HN0R2OHZJeXZnbXhWTEFXeG9sMXBRdEticUNZ?=
 =?utf-8?B?cGVZWis2bnZ2WGF3SkFqeVhhRG1LMDFVYy9rMnI3RllWSnpaM1YwcnZwWWRM?=
 =?utf-8?B?OU1vaEp6N29TUVM5Umo2ZG5mdUM1KzF5b3MvaS9LNlgrU3BicWtuREtWczIz?=
 =?utf-8?B?cWdtUngweDJ4Q1ljZDliUVVTSEpWN3lhNit1dTh2ZmRkaFdwTzJ0MVF5TzNW?=
 =?utf-8?B?RlVkc3hDYVF5eXZUYUhZaUJJL2RCaVNmUGhmSFVTVFBuZFM0cEpaVkFWUGZO?=
 =?utf-8?B?a2VjQjlUemhPcFIycXRpdXdRNVhmRXNETXdOcVpCelJKbGF1NTR4Vk9VT0RK?=
 =?utf-8?B?NmdWdFBDcWZvQ3FQd21iQndGN3FrTHpzSGJYZ2IzTG1tcGttWEovRThXNXdq?=
 =?utf-8?B?QldxMHk0SVhLZlRxazNvcGlzOXlRKy82d3UwMHZxZkI5SXZmRG9LYUZnblFt?=
 =?utf-8?B?eW8xMEJWWldVL0JqTkZaOU43UC9WcC9URjBPVSswbUJYOWlCUlZmOUNtcmRx?=
 =?utf-8?B?dGZIdEhCdHV2TlNnN094WVN6ZWlqWlZzRXBhbzk4OWYzbjFCcWd2MTFFalR5?=
 =?utf-8?B?UmVVeWhlVm1UTlB3QS9qd244TjVJM2ZkSWJqTURjaUpxSzYrdWtQcVlGS1h2?=
 =?utf-8?B?SU5YTGplMHk0N1NsSDZSMWtTdDNKN0lidWgzQmlyT05keHdnQlRRMmpnTjJa?=
 =?utf-8?B?K1FOK0tNMjB5dkZzUXgyMnhtWTJRQndkaXBJejY3QUlRY0RRSmtLNUpyYWhV?=
 =?utf-8?B?UEw5ZXUzRmVyYjRNU0JDWnVwMk1qcEJNenplYUc3UlFWTVBrNXZwYVFNUUU5?=
 =?utf-8?B?Mkc0ZUhVeHZLWjhxMDlJTmlhSVFNdDdyNlk3K2w5bDhWaW9mTU0xbmVtZFVx?=
 =?utf-8?B?bWxxUkFkanluazFHK29HWWxSb0tQNVRBaFpJRXViN3JuNXJvRDdlc09xekRV?=
 =?utf-8?B?cjROSmRHb2x3U04wRnhoUjJQTmdwclh0RVpmaTBseXcvZS9samc3VmJSdjBv?=
 =?utf-8?B?VTBNSWlQMWhwRmFCU01PS3BlVXBqaHF1cS92cGFrQ0pORStFa00rQ24xVzRT?=
 =?utf-8?B?dkdEU0xNbUF2Z2NyTGNHRkRPRGJQUTlIM0Y4aGxuYzc1WkV1WG9WQkJzOHI3?=
 =?utf-8?B?NWFoNkwvcDRIb2k5blJvSUczbHd5VlZyT1dnZ1hQMXhobTYvS0dtZGEvWmgz?=
 =?utf-8?B?bHF5dG9KaTFQUGdpUmt4Qkp2WEg4OE1qSG8ydFNHSmNTQnRKcGViOGZPU25s?=
 =?utf-8?B?SWNpdzRTUTZYbU1md0RObFBKaDdRNGNrUXd6UDR0S2lDd0RYNXR4N2JqMVhB?=
 =?utf-8?B?dVNMWDIzbk05L3hua2R6bHNmRGR4aU5MN3pqOFpCYWtPMHlVOEN6SDUzVCtG?=
 =?utf-8?Q?ljguZnglEWbYflKeGK?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5a77def-24fe-4653-4b33-08df1d528c65
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2026 11:20:48.9601 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g4sKScXv8kKjiqKDXaMRDgVKjVDoLg/abQdqkPPELXssXOhg2ocFMDlcoGd8wE6D
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6440
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

QU1EIEdlbmVyYWwNCg0KSGkgdGVhbSwNCg0KUGxlYXNlIGRpc3JlZ2FyZC93aXRoZHJhdyB0aGlz
IHBhdGNoLiBJdCB3YXMgc2VudCB0byB0aGUgbWFpbGluZyBsaXN0IGJ5IG1pc3Rha2UgYmVmb3Jl
IGludGVybmFsIHJldmlldy4NCg0KQXBvbG9naWVzIGZvciB0aGUgbm9pc2UuDQoNClJlZ2FyZHMs
DQpQcmFzYWQuDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUHJhc2Fk
IEt1bW1hcmkgPHByYXNhZC5rdW1tYXJpQGFtZC5jb20+DQo+IFNlbnQ6IE1vbmRheSwgU2VwdGVt
YmVyIDI4LCAyMDI2IDQ6MjggUE0NCj4gVG86IHUtYm9vdEBsaXN0cy5kZW54LmRlOyB1LWJvb3RA
bGlzdHMudS1ib290LXByb2plY3Qub3JnOyBnaXQgKEFNRC1YaWxpbngpDQo+IDxnaXRAYW1kLmNv
bT47IERoYW5hd2FkZSwgTW9oYW4gPG1vaGFuLmRoYW5hd2FkZUBhbWQuY29tPg0KPiBDYzogU2lt
ZWssIE1pY2hhbCA8bWljaGFsLnNpbWVrQGFtZC5jb20+OyBCZWdhcmksIFBhZG1hcmFvDQo+IDxQ
YWRtYXJhby5CZWdhcmlAYW1kLmNvbT47IEJlbHNhcmUsIEFrc2hheQ0KPiA8YWtzaGF5LmJlbHNh
cmVAYW1kLmNvbT47IEt1bW1hcmksIFByYXNhZA0KPiA8UHJhc2FkLkt1bW1hcmlAYW1kLmNvbT4N
Cj4gU3ViamVjdDogW1VCT09UIFBBVENIXSBmcGdhOiB2ZXJzYWxwbDogZml4IE9PQiB3cml0ZSBp
bg0KPiB2ZXJzYWxfYWxpZ25fZG1hX2J1ZmZlcigpDQo+DQo+IHZlcnNhbF9hbGlnbl9kbWFfYnVm
ZmVyKCkgcm91bmRzIGEgbWlzYWxpZ25lZCBwb2ludGVyIHVwIHdpdGgNCj4gQUxJR04oKSBhbmQg
bWVtbW92ZSgpcyB0aGUgZnVsbCBwYXlsb2FkIHRoZXJlLCB3cml0aW5nIHVwIHRvDQo+IEFSQ0hf
RE1BX01JTkFMSUdOLTEgYnl0ZXMgcGFzdCB0aGUgZW5kIG9mIHRoZSBjYWxsZXIncyBidWZmZXIu
DQo+DQo+IEFsbG9jYXRlIGEgc2VwYXJhdGUgY2FjaGUtYWxpZ25lZCBib3VuY2UgYnVmZmVyIHZp
YQ0KPiBtYWxsb2NfY2FjaGVfYWxpZ25lZCgpIGFuZCBtZW1jcHkoKSBpbnRvIGl0IGluc3RlYWQs
IHByb3BhZ2F0aW5nIC1FTk9NRU0NCj4gb24gYWxsb2NhdGlvbiBmYWlsdXJlIGFuZCBmcmVlaW5n
IGl0IGFmdGVyIHVzZS4NCj4NCj4gQSBtaXNhbGlnbmVkIGJ1ZmZlciBsYXJnZXIgdGhhbiB0aGUg
YXZhaWxhYmxlIG1hbGxvYyBwb29sIG5vdyBmYWlscyBjbGVhbmx5DQo+IHdpdGggLUVOT01FTSBp
bnN0ZWFkIG9mIHNpbGVudGx5IGNvcnJ1cHRpbmcgYWRqYWNlbnQgbWVtb3J5IGFzIGJlZm9yZSBh
bg0KPiBleHBsaWNpdCwgZGlhZ25vc2FibGUgZmFpbHVyZSBpcyBzdHJpY3RseSBwcmVmZXJhYmxl
IHRvIHVuZGVmaW5lZCBiZWhhdmlvciB0aGF0DQo+IHByZXZpb3VzbHkgd2VudCB1bm5vdGljZWQg
b25seSBiZWNhdXNlIHRoZSBjYWxsZXIncyBidWZmZXIgaGFwcGVuZWQgdG8gaGF2ZQ0KPiB0cmFp
bGluZyBzbGFjay4NCj4NCj4gRml4ZXM6IDI2ZTA1NGM5NDNhNyAoImFybTY0OiB2ZXJzYWw6IGZw
Z2E6IEFkZCBQTCBiaXQgc3RyZWFtIGxvYWQgc3VwcG9ydCIpDQo+IFNpZ25lZC1vZmYtYnk6IFBy
YXNhZCBLdW1tYXJpIDxwcmFzYWQua3VtbWFyaUBhbWQuY29tPg0KPiAtLS0NCj4gTm90ZToNCj4N
Cj4gSGFyZHdhcmUgdmFsaWRhdGlvbiB3YXMgY29tcGxldGVkIG9uIFZFSzM4NSBhbmQgVkNLMTkw
DQo+ICAtIEFsaWduZWQgYnVmZmVyLCBleGlzdGluZyBmYXN0IHBhdGggcmVtYWlucyB1bmNoYW5n
ZWQgbm8gYm91bmNlDQo+ICAgIGJ1ZmZlciBpcyBhbGxvY2F0ZWQuDQo+ICAtIE1pc2FsaWduZWQg
YnVmZmVyIHdpdGggYSBzbWFsbCBwYXlsb2EsIEEgY2FjaGUtbGluZS1hbGlnbmVkIGJvdW5jZSBi
dWZmZXINCj4gICAgaXMgYWxsb2NhdGVkLCB1c2VkLCBhbmQgZnJlZWQgY29ycmVjdGx5LCB3aXRo
IG5vIG1lbW9yeSBsZWFrcyBvYnNlcnZlZC4NCj4gIC0gTWlzYWxpZ25lZCBidWZmZXIgd2l0aCBh
IHBheWxvYWQgbGFyZ2VyIHRoYW4gQ09ORklHX1NZU19NQUxMT0NfTEVODQo+ICAgIChWQ0sxOTAs
ICs3Mi43IE1pQiByZXF1ZXN0IGFnYWluc3QgYSA2NCBNaUIgaGVhcCk6IFRoZSBvcGVyYXRpb24N
Cj4gICAgZmFpbHMgY2xlYW5seSB3aXRoIC1FTk9NRU0sIHdpdGhvdXQgY3Jhc2hlcyBvciBtZW1v
cnkgY29ycnVwdGlvbi4NCj4NCj4NCj4g4pSM4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSA4pSA4pSs4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSQDQo+IOKUgiAgUGxhdGZvcm0gIOKUgiBDT05GSUdfU1lT
X01BTExPQ19MRU4g4pSCDQo+IOKUnOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUvOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUpA0KPiDilIIgVmVyc2FsICAgICDilIIgNjQgTUIgICAgICAgICAg
ICAgICAgIOKUgg0KPiDilJzilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilLzi
lIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDi
lIDilIDilIDilIDilKQNCj4g4pSCIFZlcnNhbDIgICAg4pSCIDY0IE1CICAgICAgICAgICAgICAg
ICDilIINCj4g4pSc4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pS84pSA4pSA
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSA4pSA4pSkDQo+IOKUgiBWZXJzYWwgTmV0IOKUgiAzMiBNQiAgICAgICAgICAgICAgICAg4pSC
DQo+IOKUnOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUvOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUpA0KPg0KPiAgZHJpdmVycy9mcGdhL3ZlcnNhbHBsLmMgfCAxOSArKysrKysrKysrKysrKysr
Ky0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMTcgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkN
Cj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZnBnYS92ZXJzYWxwbC5jIGIvZHJpdmVycy9mcGdh
L3ZlcnNhbHBsLmMgaW5kZXgNCj4gMjlkMmEzODlmZDkuLjFjMTIxOTE5ZGI3IDEwMDY0NA0KPiAt
LS0gYS9kcml2ZXJzL2ZwZ2EvdmVyc2FscGwuYw0KPiArKysgYi9kcml2ZXJzL2ZwZ2EvdmVyc2Fs
cGwuYw0KPiBAQCAtMTcsOCArMTcsMTggQEAgc3RhdGljIHVsb25nIHZlcnNhbF9hbGlnbl9kbWFf
YnVmZmVyKHVsb25nICpidWYsIHUzMg0KPiBsZW4pDQo+ICAgICAgIHVsb25nICpuZXdfYnVmOw0K
Pg0KPiAgICAgICBpZiAoKHVsb25nKWJ1ZiAhPSBBTElHTigodWxvbmcpYnVmLCBBUkNIX0RNQV9N
SU5BTElHTikpIHsNCj4gLSAgICAgICAgICAgICBuZXdfYnVmID0gKHVsb25nICopQUxJR04oKHVs
b25nKWJ1ZiwNCj4gQVJDSF9ETUFfTUlOQUxJR04pOw0KPiAtICAgICAgICAgICAgIG1lbW1vdmUo
bmV3X2J1ZiwgYnVmLCBsZW4pOw0KPiArICAgICAgICAgICAgIC8qDQo+ICsgICAgICAgICAgICAg
ICogQUxJR04oKSByb3VuZHMgdXAsIHNvIGFuIGluLXBsYWNlIGZvcndhcmQgbWVtbW92ZSgpDQo+
IHdvdWxkDQo+ICsgICAgICAgICAgICAgICogd3JpdGUgcGFzdCB0aGUgZW5kIG9mIHRoZSBjYWxs
ZXIncyBidWZmZXIuIENvcHkgaW50byBhDQo+ICsgICAgICAgICAgICAgICogc2VwYXJhdGVseSBh
bGxvY2F0ZWQsIGNhY2hlLWFsaWduZWQgYm91bmNlIGJ1ZmZlciBpbnN0ZWFkLg0KPiArICAgICAg
ICAgICAgICAqLw0KPiArICAgICAgICAgICAgIG5ld19idWYgPSBtYWxsb2NfY2FjaGVfYWxpZ25l
ZChsZW4pOw0KPiArICAgICAgICAgICAgIGlmICghbmV3X2J1Zikgew0KPiArICAgICAgICAgICAg
ICAgICAgICAgcHJpbnRmKCIlczogRmFpbGVkIHRvIGFsbG9jYXRlIGFsaWduZWQgYnVmZmVyXG4i
LA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgIF9fZnVuY19fKTsNCj4gKyAgICAgICAg
ICAgICAgICAgICAgIHJldHVybiAwOw0KPiArICAgICAgICAgICAgIH0NCj4gKyAgICAgICAgICAg
ICBtZW1jcHkobmV3X2J1ZiwgYnVmLCBsZW4pOw0KPiAgICAgICAgICAgICAgIGJ1ZiA9IG5ld19i
dWY7DQo+ICAgICAgIH0NCj4NCj4gQEAgLTM3LDYgKzQ3LDggQEAgc3RhdGljIGludCB2ZXJzYWxf
bG9hZCh4aWxpbnhfZGVzYyAqZGVzYywgY29uc3Qgdm9pZCAqYnVmLA0KPiBzaXplX3QgYnNpemUs
DQo+ICAgICAgIGludCByZXQ7DQo+DQo+ICAgICAgIGJpbl9idWYgPSB2ZXJzYWxfYWxpZ25fZG1h
X2J1ZmZlcigodWxvbmcgKilidWYsIGJzaXplKTsNCj4gKyAgICAgaWYgKCFiaW5fYnVmKQ0KPiAr
ICAgICAgICAgICAgIHJldHVybiAtRU5PTUVNOw0KPg0KPiAgICAgICBkZWJ1ZygiJXMgY2FsbGVk
IVxuIiwgX19mdW5jX18pOw0KPiAgICAgICBmbHVzaF9kY2FjaGVfcmFuZ2UoYmluX2J1ZiwgYmlu
X2J1ZiArIGJzaXplKTsgQEAgLTQ1LDYgKzU3LDkgQEANCj4gc3RhdGljIGludCB2ZXJzYWxfbG9h
ZCh4aWxpbnhfZGVzYyAqZGVzYywgY29uc3Qgdm9pZCAqYnVmLCBzaXplX3QgYnNpemUsDQo+ICAg
ICAgIGlmIChyZXQpDQo+ICAgICAgICAgICAgICAgcHJpbnRmKCJQTCBGUEdBIExPQUQgZmFpbGVk
IHdpdGggZXJyOiAweCUwOHhcbiIsIHJldCk7DQo+DQo+ICsgICAgIGlmIChiaW5fYnVmICE9ICh1
bG9uZylidWYpDQo+ICsgICAgICAgICAgICAgZnJlZSgodm9pZCAqKWJpbl9idWYpOw0KPiArDQo+
ICAgICAgIHJldHVybiByZXQ7DQo+ICB9DQo+DQo+IC0tDQo+IDIuNDMuMA0KDQo=
