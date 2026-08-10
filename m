Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0736C5AD4E
	for <u-boot@archiver.kernel.org>; Mon, 10 Aug 2026 06:27:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2CA636063A;
	Mon, 10 Aug 2026 06:27:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Feg3-NxAXrNb; Mon, 10 Aug 2026 06:27:39 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6A7516060E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786343259;
	bh=cGWqoNIFd3orx6ZmdHFh7zWSBj9/vFfz5poMdGrrYK8=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XhIo2dsaBvIwEK5qHyBNDx6hXFePaucCt5OGC/z6rl008Gwf3HVJ+6iHQOTaWsQNb
	 rnwqbbVZT2iAUBsZdqE8dRKpOK52hDEvR7aIIEML8sXiTwYmeH+n2KsOm3Fj6b2IrQ
	 Gw97x59+IGMxkmNtHAqAzPhWafRENEjklSOgUJeAA3LO+kLbh7YmuxrlTfNRKo5jfR
	 9r3U5F2CxXq0qbMIduQgPuaPY25W901h2xWovdnSSgATIKxX7qC/6mw0H9dQNQnu40
	 1xD+RFfHZNWIt3RcArdbh+Co4eEVcQE9O7YFEy7JyrmSllulNgA3UdGxnG2jndlCiA
	 uBOoyYX4jE+fg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6A7516060E;
	Mon, 10 Aug 2026 06:27:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2887523F
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 06:27:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0E64840097
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 06:27:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Fbl5WJzQzA_i for <u-boot@lists.u-boot-project.org>;
 Mon, 10 Aug 2026 06:27:37 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c107::3;
 helo=ph0pr06cu001.outbound.protection.outlook.com;
 envelope-from=padmarao.begari@amd.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 369EA40071
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 369EA40071
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::3])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 369EA40071
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 06:27:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mauGCYFpTmvfe+nzgryRudHB0S7HDytZ9YzLDqxtFSHH+c4vdujzktHHFhX83r1V8BQIR/S+ENE2a7dfmqTvaLvTOIQHULvxRifzRF0BW+j/ZDMZy4ZB11stuiJZiIDVj2BY7oYiQjjYV93yrY0FABizFanoylmZl0NPWwTWxINJmSxQHLlJE5lAdbjzycETLIMYZ9sRU5FDaWdLW7LD9um9n+PvWNcjjbUpFfrDbS/RRoR/of0FLvTF1My3NRC2f5BCSS50N59PKEkHJ8zexlt2xlxlftDq1QGG7Weu2geUUnFS54jfp9dLM08ytUf5ejAywY7Ncg4Jg7o4m1HqnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cGWqoNIFd3orx6ZmdHFh7zWSBj9/vFfz5poMdGrrYK8=;
 b=tzlQjG4k2cDfkpKfE4PbZ6iQKLRWuTzBOdV4aT7SKoXSAUMI0XaeoMsGVSi8M15kFuqZB08hYz3Dw3ouUXnZneFpjEukJZAYz3XdiLpSNKHOScQKC+zweNsay36R35o18V/Ma+oAXytsIA4kjB3Uc7lZT+yjZs5v60MxwwAy1ZssZZtnXACTTYwu+NMdNmnKeaXVAZ1v2oAMReGPwvZIYf7c/dW+/U0d0WC53FM7DL1H/O5tffcwGRnHgdj6K6Lu4qdPpvSeOdGPnXBzI6vYbAPxSgIVRHFhhGXni9SUsIicb6LwucReCNM/4Uz4cIuQgX4HXOJ27Uav65LWXhi/8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from PH0PR12MB7470.namprd12.prod.outlook.com (2603:10b6:510:1e9::20)
 by MW4PR12MB7240.namprd12.prod.outlook.com (2603:10b6:303:226::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 06:27:31 +0000
Received: from PH0PR12MB7470.namprd12.prod.outlook.com
 ([fe80::c3e8:ee3e:aae:e211]) by PH0PR12MB7470.namprd12.prod.outlook.com
 ([fe80::c3e8:ee3e:aae:e211%6]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 06:27:30 +0000
From: "Begari, Padmarao" <Padmarao.Begari@amd.com>
To: Jerome Forissier <jerome.forissier@arm.com>,
 "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>, "Simek,
 Michal" <michal.simek@amd.com>
CC: "git (AMD-Xilinx)" <git@amd.com>, Tom Rini <trini@konsulko.com>, "Vinay
 Tilak, Pranav" <Pranav.VinayTilak@amd.com>, nd <nd@arm.com>
Subject: RE: [PATCH] net: lwip: fix TFTP blocksize threshold check
Thread-Topic: [PATCH] net: lwip: fix TFTP blocksize threshold check
Thread-Index: AQHdJMYh6+kDVSfW502B45xtIIqyrraPVh8AgAdxfmA=
Date: Mon, 10 Aug 2026 06:27:30 +0000
Message-ID: <PH0PR12MB747075E6ED36B7A39537AB7AECDE2@PH0PR12MB7470.namprd12.prod.outlook.com>
References: <20260805103429.3142222-1-padmarao.begari@amd.com>
 <7a620ca6-d2f6-46d6-86f8-990eb8cf3d57@arm.com>
In-Reply-To: <7a620ca6-d2f6-46d6-86f8-990eb8cf3d57@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-08-10T05:24:57.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB7470:EE_|MW4PR12MB7240:EE_
x-ms-office365-filtering-correlation-id: 20ffe4b0-5eac-4067-16c7-08def6a874d1
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|10067099003|4143699003|11063799006|56012099006|6133799003|38070700021|22082099003|18002099003;
x-microsoft-antispam-message-info: MXs4i8pxnbLggcqUiNoxso5zvN4DsFKXq6NexJL7kJ3Ud0NQWTL4M2ZZgbJE85T0xPoQJChiX8QU0wtJC0LHp/rsu55pz/9tD39AVYKcnIOLWjkC68LmZ+xLySCP4oj27KP8WHiTWqwaIWfiyLJcHkuKE3PTlsRHtMCoC3UhhOE2vFS6VZIEirdYFnVWY50W9SKNkm4Di96Pd7XN/wsk0fTa22I3APBL4qFX8ZyTBEHXn9zQlBQ6lLaHJHjPEn88AiBdcezs8dNZI6Sh6LrkLARPvvG3gvZMIQ4+cboMuIkheRbBznkFhWKd2GPVqLG8QLO+syDIi+qn/UY8UwAk1DOXIFzdhPfRb6vAluAqQhmZHFnrkOkmRl0Qr/kEjLYjEUZM6M8Y6Iz8uOuu7HEdgLBpWIsrxMsHcPOGj7kzOPzkmbhapGk5qpV4OwoLmqSH0ct8V+n5IrcXSnOxXK5Z7OCyYhVC7YFwFGTuL5Y8OLhvOIT8FjZtXB8lr0VmEvFdNDlD1AgZ+GMqEUJDKyF4WycUidh8/BJf6E8QkqSvvhj9H9dYL8BoiO9UBwQXwbOVSm8ktWpTkBxyFumfu1EObk4rRlTpY4uQEVEcu/sgCR6Kv8Vv72qs0SQ1xKzhqGdyMTCy2WDcW5qDCsGOaP2+6thdILCrHWIHqObpngfl1T4p/k3v8aJ8VDPiEob7rXtYLmxYnU3sCp7r+Lr/DTSNm1hJU0PGjFBHbgwUNLlfzb4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB7470.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(10067099003)(4143699003)(11063799006)(56012099006)(6133799003)(38070700021)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ejlBWnhNOW90M2hxZzdkRDM1SElMdmNmOWFzNWpCUFhOTlZieFh1Y3YyL0Zn?=
 =?utf-8?B?VWdFRmE0THhhZGlNYW1uOHNYT29qdjByQkwrc3RLWGwxZ3g5WG81RXRUeXh1?=
 =?utf-8?B?V2owV05FQVhGMjhwN1dFOFhYZ3FjTWFWNmMyU0RlRVFVUHpXelVpaW1zY0tr?=
 =?utf-8?B?NEF0WFcrMDN2amtnalZnSEd1Tm9FR3hGUWdiMlhwalpCRUlITU5iT1RtbFNB?=
 =?utf-8?B?aTI3OFdId1dZZFBMVkFIVG4xNEMxRllWZGJBS0c2bVVHWjhRQWx6cklqQ1kz?=
 =?utf-8?B?dzBsclVLNmgwbG9SSFVZSnFwUHlUQm1YZTdWd0pvbjMraDB0dW9jUTRhL0o2?=
 =?utf-8?B?QThKNmdVQmI1d3QxZGkvWThpTXQzeDZodGZUVGlRSGxYUHFnVGNBRjBEVUls?=
 =?utf-8?B?TjhrbzkxQW5ReGk4YmFNNERrbGY3Tm1BT2pCTWNpZXNURUpEcGZjSk8vK2VX?=
 =?utf-8?B?SFBBT3FkeFpwbkttSlZiWUg3MEN0Yk5jaG9wMG94aDg1MlFYS010ZFZCR0Qr?=
 =?utf-8?B?NEJ6V3hQNHRIemhRaTlIOXFRT2kxU3IvRzM5YjlKNmF6WjFzamhlS0FqZXdY?=
 =?utf-8?B?eTR6Z01UMTkvbHAzWjZUb3VwV2VpQklpK3hjbUM5bDNaMnAxTHpDUHh1TFNS?=
 =?utf-8?B?QklkYjBZa1F1NDFnR0IraE0rRDE1ZXRrZDI5bTVXc2dGRUNqcUUyTXg0RHMw?=
 =?utf-8?B?M2h1bzgxaS9NNkVwTGZSMjF0bHJRYU9wYVNDZjJSZzYwNHdxRFJYZ2xXZjhq?=
 =?utf-8?B?aUR6V0VscVVhbkg0RjFUUE8zNUx6RnFEc29ESzUxTlZDLzF0QXZzZGU2NHNq?=
 =?utf-8?B?SENQWEx6RC9BOHR3U1g0cHAyUUh6Rm81eFREbDdqeGw1QjlneUJqd3FSS0Uw?=
 =?utf-8?B?UGh0alJGTXFhOFN4a3U0YnpIV053VCs4OXk4VFRDN3hjaWRrWXBRa2lHb0FF?=
 =?utf-8?B?UkVBM3VLUGRJQnRQaEhhT2pQejNTK052SU9iMy8yWjBlN21adHFQSE1zQzNi?=
 =?utf-8?B?VkYrcnpTdk54Z2FSU3ZLTXF2QVU5K0s1Z2lwWjJpTXVwTUplMXFFeEt1YmlN?=
 =?utf-8?B?SURDdXRUTkVLckF4WUdtUFlpWGhKeno5K0JjeUVXQ21Kb2RaNlpXazQwWjB1?=
 =?utf-8?B?Ri9YYjJqM1BSUEpST0JWL0M1MUtIQWt3SFp0WERKd3ZzY3lDdU9xVUpUZVRT?=
 =?utf-8?B?cjJKaFcrT3hjQkdKTGZKMTZSZWlPeHRWVXBHRnJaSk9EbEdyYnhucGtEVzVK?=
 =?utf-8?B?MlVzTVo0VG5Pc01xWml3STkwYzdPeVBKaGJwMDBjV0I0bXI5SnBRcEFxbCtt?=
 =?utf-8?B?eG1YRHhtZ2d4bklRNmllMElWUXM0YkpadE9qNFUzRURXbG9nQ3dIMGNsdjFS?=
 =?utf-8?B?VjNkYU55d21OSXFiS2x2bGhLTjVhRnFXdERrTW9wVENqRHVSdDR6bW9XNFk3?=
 =?utf-8?B?RktPTGVuaThveGdLaFowMWs1MXYxSFFNdjBkbWUrZEFzMGRrTGZJaXJvTEJL?=
 =?utf-8?B?VlJTdmgyejNMMWN2MlQ4ZGx5T1RMTEtqK0xiRGg0VVR1TytUZHM5STFwam5D?=
 =?utf-8?B?UmVHbWkvMEo0WHR0cytmUnJpWW5FQkk5alQrcnJhZU9PL1p1YUF5dTQ0K3NO?=
 =?utf-8?B?TjU0dlVKSHhqdjRXWTlyaTRHUkRJU2ZuQUtWbERDckpWbEpSNU5iWW13VDdK?=
 =?utf-8?B?amVUNEdoekM4N09aM21Hd1VWY3Vlc0hWdzVMWFFSR3hoWTJKQzR2YitKa1ht?=
 =?utf-8?B?NGt3YUZibXUwb25GNlQxcXdCZGVuUmQvV0F4QkNPTFdBaGtnVnpaQnBHVmtB?=
 =?utf-8?B?bEZUb3BXbm90d0VhTXA1WFptc0N2STB0b3JhT3RRMFJueTdDeUkwdTZvNjla?=
 =?utf-8?B?TzVWd1BmVFE0cUJpTTJrUnhyeVZObXE0L0FBOGlXMmZ6d3FkYzNKWGRzTFlp?=
 =?utf-8?B?bW5MZlhxSnNmeHVFWnhjNkVvNjgxVjdvZ0RUZkZoRGNmZ3E2anNKMkxETDly?=
 =?utf-8?B?SW5GN1k0c1d6N25Ha0ZvUHhWR3hNb0RiS2RJZkRqMTU2L0puR2tOR2NkYlV5?=
 =?utf-8?B?ZHg3RmFKZDhBZm9TWE5seTJjZCttSUpHcU00dU9pUk1Oa0ttZXhrTU1KemZp?=
 =?utf-8?B?a1U2eFZFejZDMDBiNFo4bXhrOGNTZnBRaE1LV2N4N2RLNTJ0Wnl2RmY4aVYv?=
 =?utf-8?B?ckUrNkhJT2VrVHhQajVKWm5Ma2NFV21DeGpNOFNsaFl2RlY2U2ZJUmFJTGFk?=
 =?utf-8?B?MFpLMWlZa3U0MEJyMDYwQnorU240MkZITUJQdHdlWlMyZXFLYm5odm9FUU5V?=
 =?utf-8?Q?3XTxORRxuHms9j7oFU?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7470.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20ffe4b0-5eac-4067-16c7-08def6a874d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2026 06:27:30.7929 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0uaVyO2sT2wTzsItcAh0dGQS4o2qwN9VCldH04P80JOZlESDVtEKKWtvBMRyaknoc3UVSfUFS89KtDH72xgWGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7240
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cGWqoNIFd3orx6ZmdHFh7zWSBj9/vFfz5poMdGrrYK8=;
 b=AXIhb0wuOj1tzlZLuLGEJoTqLPrzc5B/6RRgFyxTcVYtn2GbQLr35VyqttByUAFRn1bvyQt5Byy5GkZlGbdVbxbv/3o2GroGrLIW0nJeQ1H0cX+uHLC41DH412hIYbcIzSYU2JbsrnO//CcNGkJ7gb6l6wTTUAHc+S680UMe6+E=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=amd.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=AXIhb0wu
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

QU1EIEdlbmVyYWwNCg0KSGkgSmVyb21lLA0KDQo+IEZyb206IEplcm9tZSBGb3Jpc3NpZXIgPGpl
cm9tZS5mb3Jpc3NpZXJAYXJtLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBBdWd1c3QgNSwgMjAy
NiA1OjE1IFBNDQo+IFRvOiBCZWdhcmksIFBhZG1hcmFvIDxQYWRtYXJhby5CZWdhcmlAYW1kLmNv
bT47IHUtYm9vdEBsaXN0cy51LWJvb3QtDQo+IHByb2plY3Qub3JnOyBTaW1laywgTWljaGFsIDxt
aWNoYWwuc2ltZWtAYW1kLmNvbT4NCj4gQ2M6IGdpdCAoQU1ELVhpbGlueCkgPGdpdEBhbWQuY29t
PjsgVG9tIFJpbmkgPHRyaW5pQGtvbnN1bGtvLmNvbT47IFZpbmF5IFRpbGFrLA0KPiBQcmFuYXYg
PFByYW5hdi5WaW5heVRpbGFrQGFtZC5jb20+OyBuZCA8bmRAYXJtLmNvbT4NCj4gU3ViamVjdDog
UmU6IFtQQVRDSF0gbmV0OiBsd2lwOiBmaXggVEZUUCBibG9ja3NpemUgdGhyZXNob2xkIGNoZWNr
DQo+DQo+IEhpIFBhZG1hcmFvLA0KPg0KPiBPbiAwNS8wOC8yMDI2IDEyOjMzLCBQYWRtYXJhbyBC
ZWdhcmkgd3JvdGU6DQo+ID4gUEJVRl9QT09MX1NJWkUvSVBfUkVBU1NfTUFYX1BCVUZTIGFyZSBv
bmx5IHNjYWxlZCB1cCBmb3IgbGFyZ2UgVEZUUA0KPiA+IGJsb2NrIHNpemVzIHdoZW4gQ09ORklH
X1RGVFBfQkxPQ0tTSVpFIGlzIHN0cmljdGx5IGdyZWF0ZXIgdGhhbg0KPiA+IFRGVFBfQkxPQ0tT
SVpFX1RIUkVTSE9MRCAoNDA5NikuIFNpbmNlIHRoZSB0aHJlc2hvbGQgaXRzZWxmIGlzIDQwOTYs
DQo+ID4gc2V0dGluZyBDT05GSUdfVEZUUF9CTE9DS1NJWkU9NDA5NiBleGFjdGx5IGZhbGxzIHRo
cm91Z2ggdG8gdGhlIHNtYWxsDQo+ID4gZml4ZWQgcG9vbCAoUEJVRl9QT09MX1NJWkU9OCwgSVBf
UkVBU1NfTUFYX1BCVUZTPTQpIGluc3RlYWQgb2YgdGhlDQo+ID4gc2NhbGVkIG9uZS4NCj4NCj4g
V2hhdCBwcmFjdGljYWwgYmVuZWZpdCBkbyB3ZSBnZXQgYnkgdXNpbmcgdGhlIHNjYWxlZCB2ZWx1
ZXMgKGZvciA0MDk2IHRoYXQncw0KPiBQQlVGX1BPT0xfU0laRT05LCBJUF9SRUFTU19NQVhfUEJV
RlM9NSBpZiBJJ20gbm90IG1pc3Rha2VuKT8NCj4gPg0KPiA+IEF0IGJsb2Nrc2l6ZSA0MDk2LCB0
aGUgZnVsbCBVRFAgZGF0YWdyYW0gKDQwOTYgZGF0YSArIDQtYnl0ZSBURlRQDQo+ID4gaGVhZGVy
ICsgOC1ieXRlIFVEUCBoZWFkZXIgPSA0MTA4IGJ5dGVzKSBleGNlZWRzIHRoZSB1c2FibGUgSVAN
Cj4gPiBmcmFnbWVudCBzaXplICgxNDgwIGJ5dGVzKSBhbmQgaXMgc3BsaXQgaW50byAzIElQIGZy
YWdtZW50cyB0aGF0IGx3SVANCj4gPiBtdXN0IHJlYXNzZW1ibGUgb24gcmVjZWl2ZS4gVGhlIHNj
YWxlZCBzaXppbmcgYWNjb3VudHMgZm9yIHRoaXMNCj4gPiBleHBsaWNpdGx5IChnaXZpbmcgUEJV
Rl9QT09MX1NJWkU9OSwgSVBfUkVBU1NfTUFYX1BCVUZTPTUpLCBzbyB0aGUNCj4gPiB0aHJlc2hv
bGQgc2hvdWxkIGluY2x1ZGUgdGhlIGJvdW5kYXJ5IHZhbHVlIHJhdGhlciB0aGFuIGV4Y2x1ZGUg
aXQuDQo+ID4NCj4gPiBDaGFuZ2UgdGhlIGNvbXBhcmlzb24gdG8gJz49JyBzbyB0aGF0IENPTkZJ
R19URlRQX0JMT0NLU0laRT00MDk2IGFsc28NCj4gPiBnZXRzIHRoZSBzY2FsZWQgcG9vbCBzaXpp
bmcuDQo+ID4NCj4gPiBGaXhlczogNjc1ODYwMTI0OTBhICgibmV0OiBsd2lwOiBzY2FsZSBidWZm
ZXIgcG9vbCBzaXplIHdpdGggVEZUUA0KPiA+IGJsb2NrIHNpemUiKQ0KPiA+IFNpZ25lZC1vZmYt
Ynk6IFBhZG1hcmFvIEJlZ2FyaSA8cGFkbWFyYW8uYmVnYXJpQGFtZC5jb20+DQo+ID4gLS0tDQo+
ID4gIGxpYi9sd2lwL3UtYm9vdC9sd2lwb3B0cy5oIHwgMiArLQ0KPiA+ICAxIGZpbGUgY2hhbmdl
ZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9s
aWIvbHdpcC91LWJvb3QvbHdpcG9wdHMuaCBiL2xpYi9sd2lwL3UtYm9vdC9sd2lwb3B0cy5oDQo+
ID4gaW5kZXggOGRhZTAwNGYxYTIuLjczMzQ3OGEwY2RhIDEwMDY0NA0KPiA+IC0tLSBhL2xpYi9s
d2lwL3UtYm9vdC9sd2lwb3B0cy5oDQo+ID4gKysrIGIvbGliL2x3aXAvdS1ib290L2x3aXBvcHRz
LmgNCj4gPiBAQCAtNzIsNyArNzIsNyBAQA0KPiA+ICAjZGVmaW5lIFBCVUZfUE9PTF9SRVNFUlZF
ICAgICAgICAgICAgICAgNA0KPiA+ICAjZGVmaW5lIFRGVFBfQkxPQ0tTSVpFX1RIUkVTSE9MRCAg
ICAgICAgNDA5Ng0KPiA+DQo+ID4gLSNpZiBkZWZpbmVkKENPTkZJR19URlRQX0JMT0NLU0laRSkg
JiYgKENPTkZJR19URlRQX0JMT0NLU0laRSA+DQo+ID4gVEZUUF9CTE9DS1NJWkVfVEhSRVNIT0xE
KQ0KPiA+ICsjaWYgZGVmaW5lZChDT05GSUdfVEZUUF9CTE9DS1NJWkUpICYmIChDT05GSUdfVEZU
UF9CTE9DS1NJWkUgPj0NCj4gPiArVEZUUF9CTE9DS1NJWkVfVEhSRVNIT0xEKQ0KPiA+ICAjZGVm
aW5lIFBCVUZfUE9PTF9TSVpFICAgICAgICAgICAgICAgICAgICAgKCgoQ09ORklHX1RGVFBfQkxP
Q0tTSVpFDQo+ICsgKElQX0ZSQUdfTVRVX1VTQUJMRSAtIDEpKSAvIFwNCj4gPiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIElQX0ZSQUdfTVRVX1VTQUJMRSkgKw0KPiBQQlVG
X1BPT0xfSEVBRFJPT00pDQo+DQo+IEkgcmVhbGl6ZSB0aGF0IHRoaXMgY29tcHV0YXRpb24gb2Yg
UEJVRl9QT09MX1NJWkUgZG9lcyBub3QgdGFrZSBpbnRvIGFjY291bnQgdGhlDQo+IFRGVFAgb3Zl
cmhlYWQuIFNob3VsZG4ndCB0aGlzIGJlOg0KPg0KPiAjZGVmaW5lIFRGVFBfUEFDS0VUX09WRVJI
RUFEICAgICAgICAgICg0ICsgOCkNCj4NCj4gI2RlZmluZSBQQlVGX1BPT0xfU0laRSAgICAgICAg
ICAgICAgICAgICAgICAgIFwNCj4gICAgICAgKCgoQ09ORklHX1RGVFBfQkxPQ0tTSVpFICsgVEZU
UF9QQUNLRVRfT1ZFUkhFQUQgKyBcDQo+ICAgICAgICAgIElQX0ZSQUdfTVRVX1VTQUJMRSAtIDEp
IC8gSVBfRlJBR19NVFVfVVNBQkxFKSArIFwNCj4gICAgICAgIFBCVUZfUE9PTF9IRUFEUk9PTSkN
Cj4NCg0KSSBlbmNvdW50ZXJlZCBhbiBpc3N1ZSB3aXRoIHRmdHBib290KGx3aXApIHdoZW4gdGZ0
cGJsb2Nrc2l6ZSB3YXMgc2V0IHRvIDQwOTYgdXNpbmcgdGhlIGV4aXN0aW5nIFhpbGlueC9BTUQg
TVJNQUMgZHJpdmVyLCB3aGljaCBpcyBjb25maWd1cmVkIHdpdGggb25seSB0d28gUngvVHggYnVm
ZmVyIGRlc2NyaXB0b3JzIChCRHMpLiBSZWR1Y2luZyB0aGUgdGZ0cGJsb2Nrc2l6ZSB0byAxNDY4
IGJ5dGVzIGFsbG93ZWQgdGZ0cGJvb3QgdG8gd29yayBjb3JyZWN0bHksIGJ1dCB0aGUgaXNzdWUg
cGVyc2lzdGVkIHdpdGggYSBibG9jayBzaXplIG9mIDQwOTYgYnl0ZXMuDQoNCkkgdGhlbiBjaGFu
Z2VkIHRoZSB0aHJlc2hvbGQgY29tcGFyaXNvbiB0byB1c2UgPj0gaW5zdGVhZCBvZiA+LCBhbmQg
dGZ0cGJvb3Qgc3RhcnRlZCB3b3JraW5nIHdpdGggYSBibG9jayBzaXplIG9mIDQwOTYuDQoNCkFk
ZGl0aW9uYWxseSwgSSB1cGRhdGVkIHRoZSBNUk1BQyBkcml2ZXIgdG8gaW5jcmVhc2UgdGhlIG51
bWJlciBvZiBSeCBCRHMgdG8gMzIgYW5kIHRlc3RlZCBhZ2FpbiB3aXRoIHRmdHBibG9ja3NpemU9
NDA5Niwgd2l0aG91dCBhcHBseWluZyB0aGUgdGhyZXNob2xkIGNvbXBhcmlzb24gY2hhbmdlLiBX
aXRoIHRoaXMgdXBkYXRlLCB0ZnRwYm9vdCBhbHNvIHdvcmtlZCBjb3JyZWN0bHkuIEkgd2lsbCBj
b250aW51ZSBkZWJ1Z2dpbmcgdG8gaWRlbnRpZnkgdGhlIHJvb3QgY2F1c2UsIGJ1dCB0aGUgY2hh
bmdlIHlvdSBzdWdnZXN0ZWQgaXMgd29ya2luZyBhcyB3ZWxsLg0KDQpSZWdhcmRzDQpQYWRtYXJh
bw0KDQo+ID8NCj4gVGhhbmtzLA0KPiAtLQ0KPiBKZXJvbWUNCg0K
