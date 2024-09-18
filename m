Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50CEFCAC5AF
	for <u-boot@archiver.kernel.org>; Wed, 18 Sep 2024 00:21:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C9EC88E08;
	Wed, 18 Sep 2024 02:21:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="RZZQX6nC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D73E88E44; Wed, 18 Sep 2024 02:21:22 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7809988E08
 for <u-boot@lists.denx.de>; Wed, 18 Sep 2024 02:21:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TpbW1uzYdE79TO2xcWHZF4mVphstEsI8RTZx5VqOsclUGsT/bMhIDXeiVbaXtvc6Io92SNynIJBNp1++HCA4fbp/I5FDzmU5Jj9lFxzEQhmyapO9SlUryBZNNNYVLQ1QyCoIvBT0rsb3Q6clRR4AzxsEw+qxe3FPz4J9XYxMZ3cz4UXVqiduIsVcsSGvz5vHMNxuTAry57dYHYv9uG9PhjNKCGrZbWeShzi8nvTIG7o7rs2mQebADtJFVbwypzS0g2lrgY2aRFPPS/JLqGkxOsk7C9ElvPjTe89+wK8ll5wymJeQTrTH2cuNHncZ9w2vGaUHr4Ys280YOCHwOMf9MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b6n8UWKaeaX/zWovycQwRy7SYmvNe9PswgjI8KvE7zw=;
 b=Ar0gyisllhyN7zPpXdCkV/2wPs+zOs0l36a0Se6/uRLhUDw+lLWj11YhL9RvGKqWzRH/mb7O63JMI4Z4EhQfYnN4/h25GY4PtJqEe/yebgcDzTIK8mpyC2OF3qLN7twT5XvnwYPfy6FTLEjFMVi7vBMth2KZnDHuBZHRtTtFwQQQnEjvg9OwOMKdTMNk6yC8I5jNyySXuwNnaLlHa72OsKgnwKlgZlozKwxeeO3Urf5MgKb8C9GQkBR+lFSLP4Z/OY6DLoIyjPvhAKiOAM/Fg7TbOgHUup2eMwQ38TxP6lC8z+nKma/OUVokkPFUgiFoPioC1usLUv5RXKQ7scpOwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b6n8UWKaeaX/zWovycQwRy7SYmvNe9PswgjI8KvE7zw=;
 b=RZZQX6nCm4S92Et1vmiBESHkW8vlGG4hvdPAaSwSizhKEQKR3idNF0nQcOZuGV8A4hMjLb1lXNIdoz12G7FFZYxnjvfOgULmmDeKmLVQ3cUWpu5UpA+t3LTn8OaEGpX7gCd7wjhedA/reawU33JzpAowCcsoiHZho2GghgKV4ZcA/oVNdqjo7N4iQ0R/x4YfIS7a9HWxIu8yH5ZKUZTEfRD6WoIf+lkcd+33XUSb3CdOEQphcSeoiz42Wdn2PyoD2R1ujpO7jBVtMyWvNVtEB58MwQfVEWjnGIt2Ss23yMiwIuk5FF5PEkUp4F/yMVfxAiszUm0IX0DJ1/j3Es3O8Q==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DU4PR04MB10364.eurprd04.prod.outlook.com (2603:10a6:10:560::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16; Wed, 18 Sep
 2024 00:21:18 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7962.022; Wed, 18 Sep 2024
 00:21:18 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Fabio Estevam <festevam@gmail.com>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC: Stefano Babic <sbabic@denx.de>, dl-uboot-imx <uboot-imx@nxp.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Ye Li <ye.li@nxp.com>
Subject: RE: [PATCH 21/21] imx93_evk: Enable M.2 VPCIe_3V3 and deassert
 SD3_nRST
Thread-Topic: [PATCH 21/21] imx93_evk: Enable M.2 VPCIe_3V3 and deassert
 SD3_nRST
Thread-Index: AQHbCKmwtXn5HoU12EiUCrPjGGILZbJcrb2AgAABQBA=
Date: Wed, 18 Sep 2024 00:21:18 +0000
Message-ID: <PAXPR04MB845979D1A524FC309F7A84CF88622@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20240917-imx9-update-v1-0-4fe8effc937e@nxp.com>
 <20240917-imx9-update-v1-21-4fe8effc937e@nxp.com>
 <CAOMZO5BzLSCTOpOz7vvp-uGfPQAjViuoCP-fyV3BZ3KnxeZm9Q@mail.gmail.com>
In-Reply-To: <CAOMZO5BzLSCTOpOz7vvp-uGfPQAjViuoCP-fyV3BZ3KnxeZm9Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|DU4PR04MB10364:EE_
x-ms-office365-filtering-correlation-id: c426e0c1-7652-4122-7b42-08dcd777d0bd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?L3hDeGpSZlRNQlFYdW5SY1poMzJlSUhleWMyWTR6RjV5eFhDVTBFb0pwc01w?=
 =?utf-8?B?a1dscE5NYTNTRlhxVmgzQ3hXYTdwS2FYZ3ltYmxhdzIyeEVMYUN2eWZ6aUZy?=
 =?utf-8?B?WnRvOUJCZnFOV1B2eHFRbWlUWjZIcVdLODU2RFJwUStNMGY5UXRXWEYxc3Rh?=
 =?utf-8?B?RVFEOG1rUXhXMGQ0emhYalZZRHhVUklPUDFmSGI5ZUo5bTRFcWlKMnF3dmdV?=
 =?utf-8?B?YVFaaktWeUVWN3RZcytqMmNUNDFMYklZODVqeXpDajBMR21IdkxrRUxYZE1j?=
 =?utf-8?B?NDAxTDhyYkxGZHhYZ1IyWTA3UGkyMEx2bU9FK1FKVW84VzRHSEdlY1pIVy9N?=
 =?utf-8?B?VXBtZ2JETkZxZFo0WGhXZUNWdjh3L1BSaHZkU0pWeUVUTnpUcTZhN01YaDZp?=
 =?utf-8?B?eVhWM28rQ2ExSDRqcTM0U280NFdGVzl5MmczWUlUdVljc3NQU3U1MzlQalg2?=
 =?utf-8?B?dnVaS21MUnFLR0orUEFJbWR5ZnFQT2NaRnJTNEdOa3B0THFEWUhpWUloUHdT?=
 =?utf-8?B?MnNndVlGaWlCYmVJVGttTHZaZTBDekttemU1NE9CbS9pTzhhMEZJbFpBd090?=
 =?utf-8?B?QmtYcWlQNmhaNTBGcEFKSnYxdXdWdktkTmV1bnJNVzM4T3B4UlJRa1Qrak84?=
 =?utf-8?B?eXF4UmpmU0s5cDQ2NFdnK1RGenJ2Z2NOUVZTNmJodWk3NHFHUFJnM3B2c2lL?=
 =?utf-8?B?am95SEsxSWtFa04xS3h0VkxULyt3bm5ZTDV4TTN4WGpwRkhxdlU5UGN0WStJ?=
 =?utf-8?B?SStwVmNSTHU5S3pvMjFQcTJRQkhCbjUvSjRQSXpKQXNxbnd4bWM2ZU01d0JG?=
 =?utf-8?B?S0J1d3B2UncrWnMySk5KM3RvRVNjRGFIcGVBY2oyV05lWWJ0YkNmR1l4dmY2?=
 =?utf-8?B?OGFISVMwdTFiOFUxWVk1dFpzWGFFOEptZTY1S0syYVdrMTcvdTBtczVidmZs?=
 =?utf-8?B?UVNVWlNKaklwVDg2bHRDZC9SWHhBVXhZaldSL3BkWSsvcFl3RTIxRmtETDVV?=
 =?utf-8?B?T0poM0xLR2F0a0Z0UWkzeUxaMW5HbVlDei9FS3BGOFJITVFKVVN6Q0FrZm9s?=
 =?utf-8?B?TTZqcVZsUms2bnRHcURMSDB4aENvdGFibThVSUR2czlVQzcySVNxVWlNUEJB?=
 =?utf-8?B?WmtzbE03R3R3a1ZKeHlseGswSXFmYUt2OVZoWlRYWC9UbmErU1pkT3ZCcjh5?=
 =?utf-8?B?c1kxWWZwUGE0OUkrQW9hdWJjRUJERDdraUlFUXBNNFNELzM1QmdZWllKaitE?=
 =?utf-8?B?a3E0U0k2VFQ0QmdQektMYTNuR3RMTHM3dEk5RFV1WEdqMTR4NkpYclowdllC?=
 =?utf-8?B?NHNXOWhnbDl1THhKWGJJOW5mMzhmTEQzek9oU0I3VUtwRWZmbWhXWDJUNW5Y?=
 =?utf-8?B?ck5ndDJibnU0TjZ1R1kzaElyQVIrWmpPdlMrMGYwdWZKTUx1WEtKZTF5N3RU?=
 =?utf-8?B?MGNIR0d1ZFRDK005WVBmOGkrbStBNHdKMXVaUWg3RDFUQm1KZWpzUndyTWI2?=
 =?utf-8?B?YlhRcnpVQXB0VXBvZ2lrK0orajNPd096YkU4QndKdDV1N3NndW4vbGluVllH?=
 =?utf-8?B?OTBIZXAxYVZWc0lQcHZWaGRSSGROaG5aVUlOaXVDaWNVK1RLM1AyUnM5M01G?=
 =?utf-8?B?K3dxQlhXZ0sxSTJxMHdnakNrQnNmYi9RMVdlVUJIdi9TOERTeUdmb0hhWVpp?=
 =?utf-8?B?UUpZRFBoM21VV1pMTWd4b1VDckhzdUxYTk9pUTJQU0p2MU8xTmEzbDVmT1Fj?=
 =?utf-8?B?TElKbmY3dVRZT0NTQU8vYjkxREVMckFxbDRNeE13Q2V4OStJdVdFMy9LUmVi?=
 =?utf-8?B?aDRMbGEwRisvNTdyTFFjRUUySmthZ2RqaVBaemgyS3pqdWYwSnhrV0RqTzMy?=
 =?utf-8?B?TmZZalllTkpHblkvNEwyeXVsMjdsM2pzUng4RHBMcGhOWUE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aW1SWmtvbktHMk5ZUEVON0dpbGkrWDY3c0ZVcVlBWW9yb1NXeTNxTXFUbnYy?=
 =?utf-8?B?N2JzR096bk9wUmZuelZteFN0N2sySEtuNHhiK29ISnhxK2ZNL3Z4Vkg4MGMz?=
 =?utf-8?B?QlFnZW13WHVPUmdEQVh4aEVFdThKMDdZV004Q3FNRW5QbFZnbXlta1gvMGxn?=
 =?utf-8?B?WXh3YWFIQm14WTVHYUQrckFnalVjdWdIc1p0SDhZZDBJYXRSZVZYYzdRWFpS?=
 =?utf-8?B?SnpiN1o5SFdpMWNXZVF1bmNjT1A1a1dzaGgzMVZ4UVE0N0hOQktPMGxkK1Nm?=
 =?utf-8?B?ekVGa05ObEh2UEcvNkthTVMwZ3VxUjNwV3lzSTFsek90K1ludG9jQXkwbktC?=
 =?utf-8?B?eGxJSWhkZW1YZ3hWRUZkVXhnSmNqVDd4Zk5ZVjBhZ05iWGpmYjd6YkVoWTRS?=
 =?utf-8?B?dnFENnZBKzI4VHovR2kyNUVyZE56WENjK1NhbFgyd1Y4SXV3b0sxalV2TmFy?=
 =?utf-8?B?ZWpQbHdBVHI3UzZpbTZrTFFVSGhEZXJhSkdJME1Vb1lBTDFHQkRCSkFlU3hM?=
 =?utf-8?B?Y3c4d2dWWk0rVi9PbWVkdDZNeUVSLzNEeXlSZGtlOXZvYkFWLzNOcm1DZ0RN?=
 =?utf-8?B?Z1NOc2F5S3lidnFqT2doS1llWUoxS2xqY3lHL0xkRjVlMWtNUnBNZFNBSi8y?=
 =?utf-8?B?WUNMYUJDN245cE5RbzhTTVhkVFNFdDJMa0grWHhVTTAydUZJSkJYTy95NGNG?=
 =?utf-8?B?bEZhYXZ1ZmhBbW9GeXNUaTZhbk1nUUVFVTYrTVJiS01UdlU2YmhZN3c2VDdu?=
 =?utf-8?B?MG5veFVjSi9MWnVIcjZoRldtVkJSdlVlM2VxMGtJWmxiRGIwcGswR1dDaDBt?=
 =?utf-8?B?b1U4bUlyNnVSakNSc1RlOU9adlF5K2pEUFF2UlpJVk1TMGpmLzBsNmNDWGo5?=
 =?utf-8?B?cElGaE9ta0Y1dzc5VU5uMTl3K1ZpQTB5Y1owRzVrTlg2L2RUc3FyVmpRSlFv?=
 =?utf-8?B?dExQQW9uaXpXWTl3RUlUdEJiVWt3NEp2YWJDbjdpY3R5VU15Q3V1cytoTTVs?=
 =?utf-8?B?SHI0Zll0UWlheHcyZ29XUndacEtZZjliUlZoeG1TcHVPYzl4SlJGQ2k4UGgr?=
 =?utf-8?B?aEl6TzVFTHVkSUhIbDJCOUxjRXZObUFMUTdYRFhYRC92VkJTSy92UnFRVkwr?=
 =?utf-8?B?NWQ2SHN5cExVYjk5RHYrYW9RSzlxcWtIQTNPNTU4bVM1Q292d3ltL0xjTTlz?=
 =?utf-8?B?MVhSVHlFWi9xYUVUN3RDMzIzM3k1aGQ2bGNMVk13dG5TZ3NHZWtUK0kwdEYr?=
 =?utf-8?B?WUNxUmo5TTd5L2ZiT0tCcXdqbjEzNmpjbDQzcXBxVjY5NTV3Vmc5amhoNWZ0?=
 =?utf-8?B?aDE1RVE0WExkR3p6R3I1SlN0UTZ2ckxIbENhU3YwSmNubmNPS0tHOFZLeFdK?=
 =?utf-8?B?WlVCdU5MaGxiVnZacHAvUlZIVXo3T3BPOVBlMnVwQ0NJMnhBVDJEMjRvK3FB?=
 =?utf-8?B?Q25HMFc0Rlg3aVFDcDRGMWlqOTVNdHppMWdtWXQ3UWR4VENHY2tvUmUxdEFU?=
 =?utf-8?B?RW1nV0kraTE1ak5NeTJMUDR2NG1qMG9ncWk2a1hnaGVsMHRyTW5EeGtmdDkv?=
 =?utf-8?B?TFBPMFhkNjFEUlg4cFBGTzNWbjA3b0RhZnVLQ2E1RDVXcjVBWS84S3c5SHJw?=
 =?utf-8?B?WExrVmdDMFU2QktPRkhqVmh3R1g2NTVWZTFEQU16dmNCeTFRVDlBRk5SN05I?=
 =?utf-8?B?dVNHVWxScEVKTWc2WFhXOVZvUE9YUlB5enNqcUxvTmtDRUFWTmhJd1Q0QXA1?=
 =?utf-8?B?RmFhbkxFcWtpZDFRejRVenduaEt6dlFHcWR5ZFdTQjBYN2NjTHpRamRrWEpV?=
 =?utf-8?B?WDN3NjdHUU1rVnYxemRCS09RYU5mL1E4bm5uaG0xaHdKRGNJVDZHR3JwUnBI?=
 =?utf-8?B?ZzJSNTBOK253eFVib0dNekFoWHNGUGx2QTBIeDlzRkUyWER2a2J0OXM2bVdm?=
 =?utf-8?B?bU5lREtpRFltTk90OVdKd2JnZzRwOHZNR3c2TmZTUFRvckwvVytCdjZkS3NI?=
 =?utf-8?B?Y2R4cWhiZXA1UmNiMkQ3T28vVXV1bDBtMzFsNk9GVXE5enVPSElmYTJ6M0xG?=
 =?utf-8?B?dFRxbElnNVUySDYyT2VyRHh2dmprMWQvbTI1N2huc2NocDQvZXFQbFpKbHgy?=
 =?utf-8?Q?zpOY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c426e0c1-7652-4122-7b42-08dcd777d0bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2024 00:21:18.2582 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 32lLDspFnSU7EfEH6lWJ06s4solmYMwjZ8Uxyahr2WmgNawGj9Vo617EQuYF2J6578uESIpnUR0OTc02VUJo1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10364
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

SGkgRmFiaW8sDQoNCj4gU3ViamVjdDogUmU6IFtQQVRDSCAyMS8yMV0gaW14OTNfZXZrOiBFbmFi
bGUgTS4yIFZQQ0llXzNWMyBhbmQNCj4gZGVhc3NlcnQgU0QzX25SU1QNCj4gDQo+IEhpIFBlbmcs
DQo+IA0KPiBPbiBNb24sIFNlcCAxNiwgMjAyNCBhdCAxMTozMeKAr1BNIFBlbmcgRmFuIChPU1Mp
DQo+IDxwZW5nLmZhbkBvc3MubnhwLmNvbT4gd3JvdGU6DQo+IA0KPiA+ICsgICAgICAgLyogRW5h
YmxlIEVYVDFfUFdSRU4gZm9yIFBDSUVfMy4zViAqLw0KPiA+ICsgICAgICAgcmV0ID0gZG1fZ3Bp
b19sb29rdXBfbmFtZSgiZ3Bpb0AyMl8xMyIsICZkZXNjKTsNCj4gPiArICAgICAgIGlmIChyZXQp
DQo+ID4gKyAgICAgICAgICAgICAgIHJldHVybjsNCj4gPiArDQo+ID4gKyAgICAgICByZXQgPSBk
bV9ncGlvX3JlcXVlc3QoJmRlc2MsICJFWFQxX1BXUkVOIik7DQo+ID4gKyAgICAgICBpZiAocmV0
KQ0KPiA+ICsgICAgICAgICAgICAgICByZXR1cm47DQo+ID4gKw0KPiA+ICsgICAgICAgZG1fZ3Bp
b19zZXRfZGlyX2ZsYWdzKCZkZXNjLCBHUElPRF9JU19PVVQpOw0KPiA+ICsgICAgICAgZG1fZ3Bp
b19zZXRfdmFsdWUoJmRlc2MsIDEpOw0KPiA+ICsNCj4gPiArICAgICAgIC8qIERlYXNzZXJ0IFNE
M19uUlNUICovDQo+ID4gKyAgICAgICByZXQgPSBkbV9ncGlvX2xvb2t1cF9uYW1lKCJncGlvQDIy
XzEyIiwgJmRlc2MpOw0KPiA+ICsgICAgICAgaWYgKHJldCkNCj4gPiArICAgICAgICAgICAgICAg
cmV0dXJuOw0KPiA+ICsNCj4gPiArICAgICAgIHJldCA9IGRtX2dwaW9fcmVxdWVzdCgmZGVzYywg
IlNEM19uUlNUIik7DQo+ID4gKyAgICAgICBpZiAocmV0KQ0KPiA+ICsgICAgICAgICAgICAgICBy
ZXR1cm47DQo+ID4gKw0KPiA+ICsgICAgICAgZG1fZ3Bpb19zZXRfZGlyX2ZsYWdzKCZkZXNjLCBH
UElPRF9JU19PVVQpOw0KPiA+ICsgICAgICAgZG1fZ3Bpb19zZXRfdmFsdWUoJmRlc2MsIDEpOw0K
PiANCj4gV2h5IGRvIHdlIG5lZWQgYWxsIHRoaXMgYm9hcmQgY29kZT8gVGhpcyBzaG91bGQgYmUg
cHJvcGVybHkgZGVzY3JpYmVkDQo+IGluIHRoZSBkZXZpY2V0cmVlLg0KDQpJIGp1c3QgY2hlcnJ5
LXBpY2tlZCB0aGUgcGF0Y2hlcyBmcm9tIGlteCB2MjAyNC4wNCwNCkkgYWdyZWUgeW91ciBwb2lu
dCB0aGF0IHRoZSBib2FyZCBjb2RlIHNob3VsZCBiZSBkcm9wcGVkLg0KDQo+IA0KPiBIb3cgZG9l
cyBMaW51eCBkZWFsIHdpdGggaXQ/DQoNClRoZSBsaW51eCBjaGFuZ2VzIHN0aWxsIGluIGRvd25z
dHJlYW0gYXMgYmVsb3c6DQogICAgICAgIC8qICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgDQogICAgICAgICAqIEZvciB0aGlzIHNwaS1ub3Igb24gTS4yIGNhcmQsIG5lZWQgZmlyc3Qg
ZW5hYmxlIHRoZSBWUENJZV8zLjN2LiAgICAgICAgICAgICAgICAgICAgICAgICAgDQogICAgICAg
ICAqIE5vdGUsIFZQQ0llXzMuM3YgbmVlZCBhYm91dCAxLjc0bXMgdG8gY2hhbmdlIGZyb20gMHYg
dG8gMy4zdi4gICAgICAgICAgICAgICAgICAgICAgICAgICAgDQogICAgICAgICAqIFUtYm9vdCBh
bHJlYWR5IGVuYWJsZSBWUENJZV8zLjN2LCBzbyBpbiBsaW51eCwgY2FuIGlnbm9yZSB0aGlzICAg
ICAgICAgICAgICAgICAgICAgICAgICAgDQogICAgICAgICAqIDEuN21zLCBpZiB1LWJvb3QgZG8g
bm90IGVhbmJsZSBWUENJZV8zLjN2IGZpcnN0LCB0aGVuIG5lZWQgdG8gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgDQogICAgICAgICAqIHRha2UgY2FyZSBvZiB0aGUgMS43NG1zIGRlbGF5LCBi
ZXR0ZXIgdG8gYnVpbGQgdGhlIGZsZXhzcGkgZHJpdmVyICAgICAgICAgICAgICAgICAgICAgICAg
DQogICAgICAgICAqIGFzIG1vZHVsZSBpbiBkcml2ZXIgdG8gYXZvaWQgc3BpLW5vciBwcm9iZSBm
YWlsLiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgDQogICAgICAgICAq
LyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgDQogICAgICAgIHBpbmN0cmwtYXNzZXJ0
LWdwaW9zID0gPCZwY2FsNjUyNCAxMyBHUElPX0FDVElWRV9ISUdIPiwgIC8qIGVuYWJsZSBWUENJ
ZV8zdjMgKi8gICAgICAgICAgICAgDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPCZw
Y2FsNjUyNCAyMCBHUElPX0FDVElWRV9ISUdIPiwgIC8qIGVuYWJsZSBTUEktTk9SIFZDQyAxLjh2
ICovICAgICAgDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPCZwY2FsNjUyNCAxMiBH
UElPX0FDVElWRV9ISUdIPjsgIC8qIHB1dCBTUEktTk9SIFJTVCBwaW4gdG8gMS44diAqLw0KDQpU
byB1c2UgZGV2aWNlIHRyZWUsIG5lZWQgdXNlIHJlc2V0LWdwaW9zIHByb3BlcnR5IEkgdGhpbmsu
DQoNClJlZ2FyZHMsDQpQZW5nLg0K
