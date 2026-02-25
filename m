Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EB8AF5543B
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 02:25:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D39CE83E36;
	Wed, 25 Feb 2026 03:24:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Zcsgg30l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5613D83E61; Wed, 25 Feb 2026 03:24:59 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43A0083C39
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 03:24:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FYZJ1sto4W9azrAgDwfzjlYyVQeRSf9XzeYZP36u4ZY9UAijF3XllhX/4I9lY65jsysl8c/e76lU02IPWqE6Ffs4uq80PgBuQpYJMp5DhTsB1UUb3MiKpg3x+WwOLImySh0porldNP8LNg3fuL1ZpmRzQLWaiTFk8NVCiKArdqNtjb0HxTRNpUMWuAu+AM81r9lbmZnNnDb3ZE2UjjwVBOKIM8KTLS+BEQhsjIX3FntiY8o2pidfw+6D8bRD57KKOHzoPtaKhaDUTbFDl4M0t2ZNO+JcAzEleUFbxK9GLjTBSq47yd6NkzW+A9Ga77xpIwGIs/WWnVBGO2w9KDoUMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=13jWpYO09AZCOHO4WGvf0HOPjE1b6naglPbElGQT758=;
 b=qSdXIa6IPOeMwM8hIOzu5riANrPts3Uxg/3zWcdqeY1f8unr6fl7GSWe/ZKWEx3ji7NnVdKZPW9uWjA295drBvbK+GXMolHjFettup8VyMRF/YtoXG/yE+eQF5mRsNJOSrE8uLQkcDJlBO67GMx/1/Ph1ZoFFIw/IgsC8OXQNbtbEmZGVyebD3ED9NpZvPYOY1XtqQU2SI0VrRbOzn1x483lBFW9wjb8vaWFc9KrTgFXTM6iAsjlZNkS6mze4SBTBxrJ2xGmaE9Z1lQDt0spHKhj71eKtFT2km7lyEvUNmw9z741NDjoWnvDo3JovE1ffIAFZRUNm41oJ6P43yMUQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=13jWpYO09AZCOHO4WGvf0HOPjE1b6naglPbElGQT758=;
 b=Zcsgg30lSYf2Va/Fa8G66/oahu6CwKh2gNVJNrMIntdDNy7BYbg5Pwiks/TbzhHumw3ypuwUwzQt/8RQgGq+2WoEN/TGTZBmqxTSzQ99EcCfQkkitEhyuIuuX6RbJIu4QW9xXKrogcVBzAY/wRHH5+gsJTpKi/YGkExWdB7A7qxdoYst8kQFtO6b+yNfOyQrk7Im6Tflra9kqkF4Rlk9KAs4KPz+Xg0iznbYbcPHJrHInHM5Oms9DTZvGKGelb5Ol2YjGm/7dghSpPOv9erz/aTY+Fwd351f890CXGAa5CZ1OKSxExCA6QMZCci0efhk+XvDf1qFc62f701H+reacQ==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB8945.eurprd04.prod.outlook.com (2603:10a6:20b:42c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23; Wed, 25 Feb
 2026 02:24:55 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%7]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 02:24:55 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: =?utf-8?B?U8OpYmFzdGllbiBTenltYW5za2k=?=
 <sebastien.szymanski@armadeus.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Andrew Goodbody
 <andrew.goodbody@linaro.org>, Kory Maincent <kory.maincent@bootlin.com>,
 Julien Boibessot <julien.boibessot@armadeus.com>
Subject: RE: [PATCH 1/2] serial: lpuart: fix RXFE filed offset for i.MX9
Thread-Topic: [PATCH 1/2] serial: lpuart: fix RXFE filed offset for i.MX9
Thread-Index: AQHcoOc0QooAHRhO0UCVkmLF5YnUhLWSufyQ
Date: Wed, 25 Feb 2026 02:24:55 +0000
Message-ID: <PAXPR04MB845947B2E1AD75FDFB21BC168875A@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20260218-lpuart-fix-rxfe-offset-v1-0-86a78b224f13@armadeus.com>
 <20260218-lpuart-fix-rxfe-offset-v1-1-86a78b224f13@armadeus.com>
In-Reply-To: <20260218-lpuart-fix-rxfe-offset-v1-1-86a78b224f13@armadeus.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|AS8PR04MB8945:EE_
x-ms-office365-filtering-correlation-id: 8dc9c52a-816e-4fcf-6c07-08de741510a7
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|19092799006|1800799024|376014|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?UnNSbHo3TU8xNGV6VitFQklTK2pBRlVJNVJsNmpqWHp3ejBscmtWUXVSZm9m?=
 =?utf-8?B?NWI4Wmh1S0Q2bktUZGV5Yy9TZ0RjN2ZYSjMrSHR6ZWFQQm5iN0pteGxSTHJ0?=
 =?utf-8?B?WHBRVmtsU0c0YzVDYjFXOUxYTHhPc2hOUWRQVWpuOWNyM3lxSTBTejRmRkYz?=
 =?utf-8?B?Ukx2MkxNOURlYlRPNWJFSU4ySnRBQTBQOStZVTloYjhQb2pmTnQyNVN0YmxL?=
 =?utf-8?B?TVZObjNrb3huTDBEY2I1WURxbEhSNGcwQ1h4K3A3aVFldnlzRWU5M0xMVWpk?=
 =?utf-8?B?ODJwOVFjS0s2K2pFU0xNblFmUDdWcUFQSkdrcmdiRWZvVWc5Y3pkZm9aMXpL?=
 =?utf-8?B?ampMdHZQaDV4ZjZvYzZpaWI5RWRXNFZjY3ZGaUtpVmp5dU95ZW9ldHV3aFJG?=
 =?utf-8?B?K3VZVGpBQmU3MUFRQ1hJVmJYc2VYQWl4N3JEd0xJaHNpZHQ1UVFCMCs1Z2VL?=
 =?utf-8?B?NGxiV3JPaGs4dUp4NExRU3hlNzcveDhYelJMNDlRNFlweE83Ylh4bDBpQmtW?=
 =?utf-8?B?Mk1YdUh6MlBDbmtRN3JRWE1vVGlzOVEwanlKbm94T015YlpjSjNQVTVNRCtk?=
 =?utf-8?B?SnM2WnRjYTd4WlFLd2E5U3JLdVZRQXJKUFQ5MU5lb0ZjblBRb0NjbDU2LzBa?=
 =?utf-8?B?UmtlZjNKbXVNK21VbVN5bU5xdDNKQnJYMnlPVUI1UTRZUVZ0NTM0QTliMnBB?=
 =?utf-8?B?R3A5Wkg5M0ZDaWFEcDUrdWZKemRqR1Q1Ym9EOE9TbmdDUHBwS0tVYnkwRm44?=
 =?utf-8?B?ZHlrZmZVa3hnQW1EQ0Ywak90dFd1QjNCWmlGdy9jQXVDSWtjelBQMVZjMVhB?=
 =?utf-8?B?KzF3NUtlYzZheDA3L2IydER4cUFrajBqQ3B3alh1cjlobGxLc3JYTlhDc0R0?=
 =?utf-8?B?cjZxckhCMHVmaEpTb20yMHB1NlFkZzJhb1J3cWlmK3h4RnRGMGZ3KzI1clor?=
 =?utf-8?B?ZmdPWmhFdGExVVlmcnR3SjcxYmZ3MUFOcmFOWEFsQkZZVDBxWW5IaDkrckZo?=
 =?utf-8?B?OFNDbzhhRWo0RlBBWm1ySGpvb2N0RW9XOXl3aWkrVkttaE85RlBOempISlVz?=
 =?utf-8?B?TVFaMjkzbUJIZksrU25YcmEvZ1VsQjdraTg5cmhmc3lsTlcwbEh1czlwR01O?=
 =?utf-8?B?UGN5Q3poeTBXazhFakxWNSs2VEJGR3JlZk9paWJwWGlpT3cvcGtGZnFJYk1F?=
 =?utf-8?B?elVnRTlSbDFZMXlYaUdFQ1plVVJHUjduN0hRUG5GejRNNlM3MHRTRkx1Nllp?=
 =?utf-8?B?dzhCb2RHWlp2UGtwdTBrZFByRlhXbFQxQ3FQUkNiYjBIWlpsSTNMVVU4d2R5?=
 =?utf-8?B?aTZVZ0cwaWFUbmVGSTJBcEhCSVZrS3k5ZHFPQ1RvWG0vVnhQcEFBRHRBTHBU?=
 =?utf-8?B?SlpXWEFaa0tMVnFBa0p6cys0T1BYT1E2NG02eTBoUjc0bUF1b2ltRnpUeGZx?=
 =?utf-8?B?Ym5RbnJDQkFzOTQ3Yy9GcUkvMVZRajl1cFp1aEhhTWtSc0RDWTdWYlFaV05p?=
 =?utf-8?B?b3NMK0xaRmQvTkVTM3FFU1lHTnBGRGpEV2hGOVpRNVM0YXZsZStRa0J2NzVm?=
 =?utf-8?B?MndBcW9sU0did2VzU1lyU1hZWGhIN3JkZEovRWJEVTl6aHNNanNFUzlyNk1o?=
 =?utf-8?B?Z0NMVnppWFNycm5XVThhNStxVjluOHRjblhUTHN6d2x3dy96U1lWNW9UQldp?=
 =?utf-8?B?RHBqTXBXMENTeDZrdDE2cUFwb3MyRkNBY2MwNFNzY0lpNDl4SnlqVmdVQVg1?=
 =?utf-8?B?YUhKQmtzNXFicWNWS2JhNHdCUDRuVzVGTUFzdkExb3FGTE8yQ3MrSER0dXkv?=
 =?utf-8?B?MEZPZ0xoUHA0TU5rSTg5WW5CeUc5NVQwSUh3TEh5U0VSVzBsZnEweS9YU2w5?=
 =?utf-8?B?TnZjMkxMbzEweWJQaEY5LzQ4OVdFSG1uWjVGaUo1bHB4U05mdTE2WjBOZDNp?=
 =?utf-8?B?N0xyVCs0enpoYnlBcm8vWXRKSTFZdHBrQysxaXc4Z1Bhb1UrZVkzY3dINldH?=
 =?utf-8?B?VUtFenFpTjV5dElwbjltajZTRk5pSnI3ZjRURjFtbFZsODk0cFFmUUdBejhp?=
 =?utf-8?B?dUh5bEFKSjcvNUZUQUh1OXJDVC9Nb0FRdUVOY2FPRTRlaWU4NVVRVFJUQWQ4?=
 =?utf-8?B?UVZGVzF4N1dISmFZVlo2dm5QK01hQjc5cUdQMkJNdFNpVG42Zm8zU1NTY3lZ?=
 =?utf-8?Q?nuPDJ5OV2TIwkbkDYkpf6WU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(1800799024)(376014)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cWp5aGlwOFBqd0ZuVTNpckN5eEl6VDRJZ25WRjM1ZGxHWkV4cWxqd0VBUWZC?=
 =?utf-8?B?akt3aTF4WDFYN0N3ZEhCRDMyLytZdFdIY3NBeXFWUHZuczdQb0FEaCt6ME1K?=
 =?utf-8?B?bzZRMEpVRFFVWm8ySDBwZXN2aXdJQndZeG5mYUducnd5SXhxaW9yQnE1UjUw?=
 =?utf-8?B?Rm5QVzM5ZjBhcDhlbDkramZYMForbnlTYlZOcHl2dUFucGVXLzYrSXBYWkc3?=
 =?utf-8?B?ZWlGNHJFSFhWWURrbFYxazdTamVTN0x3dWZPL1FYdnFlalRVQ2FQNUdUZXhv?=
 =?utf-8?B?VDBXWnpUNk8rbnJqUFBhcTVLM01Oc3ltYmFpN2xWeUgyNHkyMTM3Z3drS0ps?=
 =?utf-8?B?TmZnQmplVUVZSVRjdVovQ2hCQVVmWkFyd3UrT2dPUzNCZ1IxbGZPRzQwUVp4?=
 =?utf-8?B?ZW1Yc0RnbE1QeGY4NXNZQk1HeUJreEhsdndnMVdhTlprcGQvQjdyK2FnMkpl?=
 =?utf-8?B?UWRyZkQ4cnFDak5qei82akg1aU4zWGZFSEIyREtRcFB0c3daRG1RY1lWUklU?=
 =?utf-8?B?eVU5VG1YZFhPTy9UMUpQTVh1aTd6aHBtVnovRkpVWGVjdE04eW1lTFlVNXdF?=
 =?utf-8?B?WklMUGhVMFZmMXlVYTg1U2VEV203Vnc5bSs3NFl5MDludVY5R2Q0TCtGeW16?=
 =?utf-8?B?UFlJdHhjK0FOSEgyc1l3UFRsQnU2ZndNWjN4c1dRajFQM1ZvcHhlYWk4Q0Yv?=
 =?utf-8?B?UDRXcnhraTVtRyttUEtOVk1DYWpOakU5MnU0emc1bEFPT1RKUUdrdUFlSGgw?=
 =?utf-8?B?a1psNXZjYzd5VTdKZldQWmliY3BOVU8xZVdGcnViV3VOVHJPdDJrdVBNcG93?=
 =?utf-8?B?RnNBZ1gyRFgxa3YzUVNtTjJJVFZjbitHRS9SVzZINE1pTVJ0dkhOc2p4a2dP?=
 =?utf-8?B?c2w1U1JDdkg0eHRNWmgrU29pRFlWaytWR29HL242SlRZdURYQ3grcTFxMURR?=
 =?utf-8?B?d29sUE1sMURGTHZpbnl2bWZ0NzhaRkl3MU8wV1Q0eTZjM0xES0VxMlAzWFlq?=
 =?utf-8?B?amRIdk9KdWxRN3Zmd0VVSnlHeWZQM1hZcW9qNmx6ZU0vallCSEduVEZXbjhw?=
 =?utf-8?B?Z08yN0JyOGVuK3ZkY2NjY2FrMFU3eG9IWEEraW9aNVlNNzhJRkpwWW4xMjdN?=
 =?utf-8?B?ZW9uQm5XbkphV2tQOVN2dTZkc1hnam14QlVLN0thZjhHVHRyRnZHeW1LeExS?=
 =?utf-8?B?R3VJTUpRclVZMis5S1E4UFhFaFhLM0hQcWllWVhJbVFEeDNUTmEzV3NGOEhV?=
 =?utf-8?B?eUxyL3NaT1ZPSGliR0xWMGFHRVBFMElTS2VPcWxvTThrZGk3c3N2Ui9peXVq?=
 =?utf-8?B?cnBoKzg0UStSNU5QMFppamFFcU9OK0UxcWJRMUg0RUN2MURzWUJJUFJ4OGo1?=
 =?utf-8?B?SGNsMjB3b2xCSUhNREJYM1dQWVpJcTZ4SiswMm9WaVF4QVFjWjY1bklrNnhx?=
 =?utf-8?B?WDNHYVdZelNEQlpXNUJYRVUxMnN4cWNFOS8yc2RBNlMzMGsrbDVaRWFNYTRw?=
 =?utf-8?B?TitzUi91U01zVUoyWWZqaGZlS2toSE1mU2pOZEVUQms1a1ZMOVpYdVltczJi?=
 =?utf-8?B?WjErSkZUTDUxZUowU2tPT3owbUFkeG50WXFETHVMSjM5ZERrbko3YzlqakZm?=
 =?utf-8?B?Rk1CNHI2b1RiRmlaYSt3Tnh4dzlWTzFKKy9zOXJWbHYvejlTYnNUTDk4R2o2?=
 =?utf-8?B?bVhMd1FiaktobU8rV0ZlVCtUVWQ5aXNCSm1ucEpWbThXeWxtdXdxM0tzeGJp?=
 =?utf-8?B?VkNMMVZwYm0vVWtPZm9KblQrcmozTmZPdVJMKzEra1RUaUY5S1VRQkh0Y0E3?=
 =?utf-8?B?d2hweUlEeTlramYxY1hzSXNjYXFvc2hrWDJ2U0p3RFZlbGtTdG93bDR2b3hD?=
 =?utf-8?B?aWNNV2hLT3VWbjZEdWc0anVrTy9TclVOTDZSczUwK29iYWlDTlNYUzRmTXpL?=
 =?utf-8?B?RWxIQTFuS1RoK3B6bHNERVQ1RVhXcWdMbm5OdjJtK3JLK0pRa1J4NzZsMkxV?=
 =?utf-8?B?RVhEb0o2NWo4bHVDSjFYUFM5UStmcG05T1Fvb3pmY0x3TmNhaHMxTmtyb3hh?=
 =?utf-8?B?SndTZUF1Um1QazNJVDUyc2ZiRFp4aDFtMXpNdjJrdVk5Y0lHaU1PQlRHVUM1?=
 =?utf-8?B?Kzk0VkVnOWlzbGlWQ0pTQ1hwZldJWEU0dmVNMXp0aldvYlBxY0xGWWIrOU9M?=
 =?utf-8?B?MEJ4OFZYMDJlS2VOYVkxOXI2Uy9jc0FPSUJxN001dGRZWTZlUm1KYUJ0d0Zv?=
 =?utf-8?B?NTZjMnlFQ292ZlpFL1BjbVRpL3duZmNQd3AwUkNIY3BTeE1ndU1PRk14bUJB?=
 =?utf-8?Q?sh6ZQdg/szatAm95ya?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dc9c52a-816e-4fcf-6c07-08de741510a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2026 02:24:55.5219 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /yBbGrfklf8woFX4tVCrTedTVCfytxiUDBlNKh22O42Aa5fiyU/dEMEYmk3HIZIHMreWbzvqYlyCZxK/sy0z7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8945
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

PiBTdWJqZWN0OiBbUEFUQ0ggMS8yXSBzZXJpYWw6IGxwdWFydDogZml4IFJYRkUgZmlsZWQgb2Zm
c2V0IGZvciBpLk1YOQ0KPiANCj4gTGlrZSBpLk1YOCBhbmQgaS5NWFJULCBvbiBpLk1YOSwgdGhl
IFJlY2VpdmUgUlggRklGTyBFbmFibGUgKFJYRkUpDQo+IGZpZWxkIGluIExQVUFSVCBGSUZPIHJl
Z2lzdGVyIGlzIGJpdCAzLCBzbyBzZXQgRklGT19SWEZFIHRvIDB4MDggb24NCj4gaS5NWDkgdG9v
Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogU8OpYmFzdGllbiBTenltYW5za2kNCj4gPHNlYmFzdGll
bi5zenltYW5za2lAYXJtYWRldXMuY29tPg0KDQpMR1RNOiBSZXZpZXdlZC1ieTogUGVuZyBGYW4g
PHBlbmcuZmFuQG54cC5jb20+DQo=
