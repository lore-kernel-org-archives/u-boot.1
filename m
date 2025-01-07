Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2E72E77198
	for <u-boot@archiver.kernel.org>; Tue,  7 Jan 2025 10:04:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 49B968036B;
	Tue,  7 Jan 2025 11:04:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ri6hBAjM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E0728036D; Tue,  7 Jan 2025 11:04:17 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170130004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05D31801E8
 for <u-boot@lists.denx.de>; Tue,  7 Jan 2025 11:04:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VT0v63ep2MJb8hIdiHEHT8e1RKXGOtEyp/GWcp9LRZs10Zh9MCav4A7Ug/ss+UiA9cpqiozfKKQULaAg1hW8lxo3R28R0HRMkt55vWkx0TaWiWJTpwgoXl/BXKIOYMztKnbawRdf+gYt1xpFADPSUVFuxUw90rgsG0Kr1eSeuTkph/HHuct6teQP6w7f8nBl0raoudcvuLcBDPPLEkN6FL+p7EGhzPkYHqKIuifigqV2jocxzLqq5nnT9PhBLGcvMDyzG98IaDYIETYYUzvv9/mSfQ+OTQA3bQ5YuO61D/dgHiWk8+Pb5m9DdR8er0LxsOMFq3H06QerCGGSUVed6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N9BBSsbvkM7I2s1Tk7QxF8oTMVR41OH29xC9emi/WNI=;
 b=cBFwsJL8O7UWeLQcJG6yl3KrtbQhzEjwflDReva6CrgsBqBZBr9F8CgibroUD+xWqc+Sv3tFf+Dl/J7rmLjgYi1Od+N89Rl/CaTB4I96irk5+4ejUScis2O1wmLPDDzrdjygTXP3P8YEgFqOLIAATVbEPRXxN3QL1HJ7XQNWyZxULUKaWBJNWY/tGa0WWnLMA6T9fIw0uyC9hex7piG/1W3y28F30NWotH6NYHQ1x+4Ztchtz3DIpAD4bzcB0c3k0k43jMxKFhWeLvCykFeF6XgfVyBpQIeCOAAxGKOMUqN7YUp4PwS4KJHyuNc3RRGYqZsEBpqThuUsar0hupGXlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N9BBSsbvkM7I2s1Tk7QxF8oTMVR41OH29xC9emi/WNI=;
 b=ri6hBAjMsu0ZOLpAsC3wO7i0Y8TUvQNGg1B75RswlPTZ4rHDKarD4iBz+4XRZBST41wLHOybtwxBsF0sttjUj6613ZsFq5haq1C+MZtTuvMp+5H2/bXEvVDArDicDai6DyJHFjAYZm9a/vi/oJK4AYQw9ZT9QzAr8MTyFWpgRKEcbnsBKiPl50VGi0g9X/ote6dY8j9JT+X6488AoNSroUnmT2fkPdLZeYnwbXS+BEXx+IEcV+zlJZ8FEbEfSy1D1VOp4ZgpZYK2MdNTLNxKJo86fVJt2K9ajnSmz+wf1oIw/MOlDXNfSSBIFiwNx9w4K1dig63aR1yWuFMgr+BYkw==
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DB9PR04MB8480.eurprd04.prod.outlook.com (2603:10a6:10:2c6::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.18; Tue, 7 Jan
 2025 10:04:09 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%5]) with mapi id 15.20.8314.015; Tue, 7 Jan 2025
 10:04:09 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: Marek Vasut <marex@denx.de>, "Alice Guo (OSS)" <alice.guo@oss.nxp.com>,
 Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>, Fabio Estevam
 <festevam@gmail.com>, dl-uboot-imx <uboot-imx@nxp.com>, Lukasz Majewski
 <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Simon Glass
 <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo
 <alice.guo@nxp.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "tharvey@gateworks.com"
 <tharvey@gateworks.com>, Ye Li <ye.li@nxp.com>, Peng Fan <peng.fan@nxp.com>
Subject: =?utf-8?B?5Zue5aSNOiBbRVhUXSBSZTogW1BBVENIIHYzIDExLzE3XSBpbXg5OiBzY21p?=
 =?utf-8?B?OiBzb2M6IE92ZXJyaWRlIGhfc3BsX2xvYWRfcmVhZCB3aXRoIHRyYW1wb2xp?=
 =?utf-8?Q?ne_buffer?=
Thread-Topic: [EXT] Re: [PATCH v3 11/17] imx9: scmi: soc: Override
 h_spl_load_read with trampoline buffer
Thread-Index: AQHbXas6ijbhp3QsIkqT4MzB2NzLI7MIunGAgAJTYzA=
Date: Tue, 7 Jan 2025 10:04:09 +0000
Message-ID: <PAXPR04MB9644460F64C5A3F04D4EFD92E2112@PAXPR04MB9644.eurprd04.prod.outlook.com>
References: <20250103-imx95-v1-0-6744df5dc020@oss.nxp.com>
 <20250103-imx95-v1-11-6744df5dc020@oss.nxp.com>
 <529cf75f-5e89-451d-acd4-942cfc91799b@denx.de>
In-Reply-To: <529cf75f-5e89-451d-acd4-942cfc91799b@denx.de>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9644:EE_|DB9PR04MB8480:EE_
x-ms-office365-filtering-correlation-id: e07a1bdb-ebf1-443f-6032-08dd2f02a12c
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|7416014|366016|921020|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?TGh0U1R6Yzg2V01qS3lQZGNaLzg5d0ZQbTYvbDgwOWVpYmY1bjVqY1JISkls?=
 =?utf-8?B?R1pGbC9ORjFhQTBaZnRjVFNaNmdtSzZQeEdFTVFiczVXNkFtQUhPSlNMOC92?=
 =?utf-8?B?bkVnbXNUNnNzWklzaUJrcU9SUHpvRU8vV2R0a0tlcmZDTlFLVGpTVi9VdWJZ?=
 =?utf-8?B?aVFLSEV2cUd0TVJCcXRRbE1KZSs0WTF6UHVYZGZiTmwzWmtiaVNzYUgzUHls?=
 =?utf-8?B?S09seEhqT290cXN1RUlOdS81dDV5UmlONHNpbEZhYzViQ0QxUm51NWtVRWRR?=
 =?utf-8?B?bUowZE5TeDcyUUNmMTU4TDVwblp6NzJtbXJYeVU3WkVYTDFRN2hZRVhJbXFk?=
 =?utf-8?B?REl3Zk90aDZ0VjRaNDBIMFlVOFhyRjcwT1JqWGVWWlprNlVUYUlZbWF0Z0J2?=
 =?utf-8?B?TkJwZmF5MU9VY0JHSWk5ZTB0NWlWVHVOQnJzM09DbzQ3VXRCWVZ0ejNWWldL?=
 =?utf-8?B?N1d2YnkxMVRXZWliU3VNNkRBSjRXajJiNkVQMWFNeXdYcG9LSXVSeWdTUnNF?=
 =?utf-8?B?dkxQb0phWlNzYU9oYVNGdjJTNUVVeUNhZ1o2NnVGeXJwOFFpbm1UZzMxQndZ?=
 =?utf-8?B?U0srV1FLSHA0bm82R1R4Nk1paC9uK2JqcG5WQmZ6ZmNYQ0ZMT3FiaTRuRSt1?=
 =?utf-8?B?Wi9ZZElCcGx1VWFqVXVMV0lsdTV6NmZwVVFCUWhoQlIyUUZoWUtwZnR1UEZK?=
 =?utf-8?B?MWFSTVF2Y29icHFqMVRlUUpMcllaSmtRZnd0dkxXUkFZcWVPNkNXSHVzUFk0?=
 =?utf-8?B?VFBRNVBMRTFLVGhNalFWNXpDWUJIL1pUTzNTWE9IcE1qZFRoRFRMNHIwUlFM?=
 =?utf-8?B?SGFidUQzUnBpN2QxbFEwc2pFa0cyeGM4OFByeTI3WnRtbzd1Q3RyVHp0cW1r?=
 =?utf-8?B?WUxqMkFyUnlzZ1BQdTEyeXRoVGJ0WTJwT00vYWRuL1gzMkdxaW1WWVhhb25p?=
 =?utf-8?B?aVBHc09FTnl6aTRPOVpjWCtWciswZnZpZ0NRZUYram1vcXQyNmlDd1MyZE5U?=
 =?utf-8?B?eXBGZUdWcGZJMXk0Rjg3MlVlUWZScXZHT01JV3FsWHZsN3ZzYzJXakFSQlkv?=
 =?utf-8?B?a3JZQjRTOTFQcURqUExTNUM4OThJdXBITTBFbmttQWpjZnZDTmZ4bGRqZzFW?=
 =?utf-8?B?TGphc0lyakdOSlRWMHJHMWVDYU02L2h1b1FRME5taGZuWVY4ZVdSc0ZqdTNU?=
 =?utf-8?B?anJLRkk5UzdoRE0zb3Z3WHNZc29yN05ITDd3V0xXR3NTOCtZWmNYTjY1QWZs?=
 =?utf-8?B?azArNHFlcFdlRFJGazk5RXN2TXhNNDZLZkpWYjdUeXlYSEQyeVNQaDZCRjI1?=
 =?utf-8?B?bFF0NE5FM0tqUHpBd1FjM1lPZTAySnhEc0hmaWcwTEkxR1p4L0J1dk9vNEdk?=
 =?utf-8?B?S2tucVhjYmI0NjdTRUpDcTZXejZ6azhubW9Ec0ZYSVRvaHhvWnBva0NmTllN?=
 =?utf-8?B?Wk9TbXFZQWg1d29La0RtaWFzZW9kL0Z2aDBRNyswTnpMZTVpS1JnOU9Pamtu?=
 =?utf-8?B?SjQ5UU5CQjRPU3RMUmJsblVscXUvV0pGbnV5cmo3Yjh1ZXBmamRSK2QvaHBN?=
 =?utf-8?B?ODFRTndPNGZPYTVmdWpjclNxL0VOcVIrOEdyNDUyaElpVHd3clZ5YjFCMDJ0?=
 =?utf-8?B?R01VYlBQRDZIZDRMWTRTd1NkQVY3NitQa1dUcjVtaDRqbndXaFQyZ0xUTU1D?=
 =?utf-8?B?NkNoMmF6SEQveVo5a1V3VXN3OTVaUmxodkw0SlVQcW9mT0p5bWFHMXJ5cTBC?=
 =?utf-8?B?SitseXNTdzUvMHMrZ0F0MFZCY1M2Ryt0YjdEYTRNZ05zYkxoSytTY2Z4NEJt?=
 =?utf-8?B?WmdDR0tIbmM5OGFlOUJKQko5d3pwLzAxWXl4ZDIyNWtHQldtaHRCOGttM0lj?=
 =?utf-8?B?dnF0VTFBckp5Ykh1TlFNK21BSzlZN1RPZjZiU2I1ME41R1Jsa3BuVHorR1p1?=
 =?utf-8?B?REVLbklGS1huVGRzd1FadC9QdSswWkVqQXlYV3BPSU1LZFFSbVozUXgvbXhS?=
 =?utf-8?B?RmtISUJLdnZRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(7416014)(366016)(921020)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q3NnZXI0SUs5V2g2clpoaWh3eDJzT3hlb3N6aEFQakcrZCtUblc4bFJWcEU0?=
 =?utf-8?B?ZitoRGhHNFF0N3M3SUx4eWpzZUVSNjNBNWJLckdYWjdKczVvajZoeG9HYzAv?=
 =?utf-8?B?MW9ENlRCbVR0cFNaM1BXQzlwR1JFaUtOVHNYM3lPaWtsUWMzUFNGYlh5UEtv?=
 =?utf-8?B?RStuMlQ2Y1IrbjRZdlRJMzRYTm5vMmxmVmFVczBqcGlrV3FKbFExeFBqYlF4?=
 =?utf-8?B?eU52cnhaV2dWZFo5cTJwTE81ZFJ5OE5jQXZYUzlzZENrK3MrUEkvejRaY0NO?=
 =?utf-8?B?Ri9oVVZ6YzdraUFqWTlUV0ZqM1YxTkVlU2g4THlHSEdSTTNEd25pcTVkR1g2?=
 =?utf-8?B?REVZTEJ3dDIrTkNJakdtQlFhUVU0aFB2L0xWWjVoSDJGUkc0b25wcDdiRmxU?=
 =?utf-8?B?a0szaisyc3hVejlaQXFYVWVETjdSdEt5N2lrOWI1Y1h5dk04VEE4SU1aUDFz?=
 =?utf-8?B?YzNlV0JvOEpVaFBYQUxxVnlFbEk0allRcFNWRTlFMS9HYjR5azlpblVDRFVs?=
 =?utf-8?B?bHcrQmhWY3Q0NTZmZEc0Wnlialk0dWZCUjFZajVzOUFYMmN4R3NNK0kyL3NL?=
 =?utf-8?B?V2lzZ0E2eFU5M29mNEFMYk1ZWWVhY2JQYzc2M1B1SXI0Q0kyRmtxeUU3YXhQ?=
 =?utf-8?B?Y0pYQnJlWVdsYnI4dnFhQ2J3VGZJQVhhdk1EeHhvU0l5VUFueGlMMTQwcUFQ?=
 =?utf-8?B?TytvSEN1SWtLL0dpMTlLbVVyWDUrdzNZM3dHWmFFa0tDT05wMHA3cHVMM3Fq?=
 =?utf-8?B?RmswdHBzNDZhWjd0WHBXd3k2TzZST0dkL3dIWUExNUFrVGhEUW1GQW5DK0FX?=
 =?utf-8?B?R2pvQnpCTXBkUXZBOGF3dVlQQ1pRTUxJclRQSVpWY2x5Tkl4TzAyZ25hd2tI?=
 =?utf-8?B?SWh6YXBQYlcrZUZwY2k4ejNFZXBBclJQOXp5Q3U0NGd3TklEYjZhMWlySFRa?=
 =?utf-8?B?VGZlSnJCQW5vSmR1Zno1R0tGUkRMZCtkNDRoeTVwZHdXTDlOODJmb0JvcVow?=
 =?utf-8?B?RjNObE44Z1dCMTVrVXVmT2ExSU1ualdnanpZdSt4S0dFMXFlZC9yc0lveGQv?=
 =?utf-8?B?MFBEK3VvVUFkNysvRVpFb3dlYzJDY0UyKzlmQVFOYmVTT2NXMS9NV1pCbTJt?=
 =?utf-8?B?YlljL05haGN2MkgzVXQ3bGRNT2huY3haVTJ6VUdZdTNmS0ZKWjR6OVgvSGRp?=
 =?utf-8?B?RDFRdTF2YlF2OWh4YXZIS2JzTkZYbk9odHR1YWNZN0VaV1NNb3RjSDJvOEVU?=
 =?utf-8?B?S2VVdnd3RkllOVl6VkQrMzRJYk9XVWExbUJ4eW5EZjRlaTQ4UlNWTkNZazc2?=
 =?utf-8?B?TlNiQVNqWkthQksrV1A5WHA5UFl2bDluTDA4ZDMrYndlV0J4eVdrK1dzVmR1?=
 =?utf-8?B?MlpVNjVRc1FjNzJyZDRxbHJzR1pKS0Y1TDhwUjk1RUZRNU5RZ20xYkFYajh3?=
 =?utf-8?B?Wm9DRHNRSFBUbWEzR1kwcmtTd0VtdXVhT3g0RCtMV2hyUWQvenE2TVRTWFZm?=
 =?utf-8?B?ZjdUY2IxSHZGS3oyZjNML1VET3lDc0NyTElZWHNNU0dGTUl0cHhENndvZXRC?=
 =?utf-8?B?K1BsQ2ZGTGlJZWlOd0F1QTg5Mk9LQnVORG02cmV4M2RyNStKMVJXbXNnemx2?=
 =?utf-8?B?OElKUkh1N0FIY00zUG5QYTJzakMvdWhaSjVMcWZjR3BqeFdhQ0lUQVdlK0Mx?=
 =?utf-8?B?SnB5SkplakdWOUtYUXN0V2krRkNkVlg1elEzdjAyKy9WNEN0OGs3ZnhUT1Za?=
 =?utf-8?B?eXQzaGRSUjZHUExaV1N6dk9oeGp4ZUVUaHBRYkdTazJ0Um1DZlFLeDNKWmVZ?=
 =?utf-8?B?anllUE5WQnFBOW9qdlIzK2ZaSFlvendUQ1czQnpxNmdoQ2lrdTR4OWRFTVRG?=
 =?utf-8?B?RzlxV2svUUI3NksvNEtXZ3N5MGt1V3RkU05pYzVqbm1wNTFVVVQ2dkczZkVh?=
 =?utf-8?B?OVpZT21BSTdWUkVHV1lsNWJyS1hLZnQwY1BhbWxGdFFCaWxaRDdMZjRUUVJX?=
 =?utf-8?B?Yy9MQjNzVDViOE45Um9rUUh4VE1Rd3luelFuWGxScTE5WHpyM0lTY3Q5eEU3?=
 =?utf-8?B?N2g2dGduZkNqQXdNR3BIVnBmTnRWSXJQK29makt6cGhIemRuNEl3VFBiWFFu?=
 =?utf-8?Q?lMMg5mZH8quiURrscC63GiagS?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e07a1bdb-ebf1-443f-6032-08dd2f02a12c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2025 10:04:09.6632 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xjzhdZ3NkfVzOw019yHzoSGyvXTfnbUn2AE26R8ZGMW4p9y5c4rfCTPuMKTN3gobYYROn6f4jt9PcrkZhEryLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8480
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

PiAtLS0tLemCruS7tuWOn+S7ti0tLS0tDQo+IOWPkeS7tuS6ujogTWFyZWsgVmFzdXQgPG1hcmV4
QGRlbnguZGU+DQo+IOWPkemAgeaXtumXtDogMjAyNeW5tDHmnIg25pelIDU6NDQNCj4g5pS25Lu2
5Lq6OiBBbGljZSBHdW8gKE9TUykgPGFsaWNlLmd1b0Bvc3MubnhwLmNvbT47IFRvbSBSaW5pDQo+
IDx0cmluaUBrb25zdWxrby5jb20+OyBTdGVmYW5vIEJhYmljIDxzYmFiaWNAZGVueC5kZT47IEZh
YmlvIEVzdGV2YW0NCj4gPGZlc3RldmFtQGdtYWlsLmNvbT47IGRsLXVib290LWlteCA8dWJvb3Qt
aW14QG54cC5jb20+OyBMdWthc3oNCj4gTWFqZXdza2kgPGx1a21hQGRlbnguZGU+OyBTZWFuIEFu
ZGVyc29uIDxzZWFuZ2EyQGdtYWlsLmNvbT47IFNpbW9uDQo+IEdsYXNzIDxzamdAY2hyb21pdW0u
b3JnPjsgQWxwZXIgTmViaSBZYXNhayA8YWxwZXJuZWJpeWFzYWtAZ21haWwuY29tPjsNCj4gQWxp
Y2UgR3VvIDxhbGljZS5ndW9AbnhwLmNvbT4NCj4g5oqE6YCBOiB1LWJvb3RAbGlzdHMuZGVueC5k
ZTsgdGhhcnZleUBnYXRld29ya3MuY29tOyBZZSBMaSA8eWUubGlAbnhwLmNvbT47DQo+IFBlbmcg
RmFuIDxwZW5nLmZhbkBueHAuY29tPg0KPiDkuLvpopg6IFtFWFRdIFJlOiBbUEFUQ0ggdjMgMTEv
MTddIGlteDk6IHNjbWk6IHNvYzogT3ZlcnJpZGUgaF9zcGxfbG9hZF9yZWFkDQo+IHdpdGggdHJh
bXBvbGluZSBidWZmZXINCj4gDQo+IENhdXRpb246IFRoaXMgaXMgYW4gZXh0ZXJuYWwgZW1haWwu
IFBsZWFzZSB0YWtlIGNhcmUgd2hlbiBjbGlja2luZyBsaW5rcyBvcg0KPiBvcGVuaW5nIGF0dGFj
aG1lbnRzLiBXaGVuIGluIGRvdWJ0LCByZXBvcnQgdGhlIG1lc3NhZ2UgdXNpbmcgdGhlICdSZXBv
cnQgdGhpcw0KPiBlbWFpbCcgYnV0dG9uDQo+IA0KPiANCj4gT24gMS8zLzI1IDc6NDUgQU0sIEFs
aWNlIEd1byB3cm90ZToNCj4gPiBGcm9tOiBZZSBMaSA8eWUubGlAbnhwLmNvbT4NCj4gPg0KPiA+
IFdoZW4gU1BMIGxvYWRpbmcgaW1hZ2UgdG8gc2VjdXJlIHJlZ2lvbiwgZm9yIGV4YW1wbGUsIEFU
RiBhbmQgdGVlIHRvDQo+ID4gRERSIHNlY3VyZSByZWdpb24uIEJlY2F1c2UgdGhlIFVTREhDIGNv
bnRyb2xsZXIgaXMgbm9uLXNlY3VyZSBtYXN0ZXIsDQo+ID4gaXQgY2FuJ3QgYWNjZXNzIHRoaXMg
cmVnaW9uIGFuZCB3aWxsIGNhdXNlIGxvYWRpbmcgaXNzdWUuDQo+ID4NCj4gPiBTbyBvdmVycmlk
ZSBoX3NwbF9sb2FkX3JlYWQgdG8gdXNlIGEgdHJhbXBvbGluZSBidWZmZXIgaW4gbm9uc2VjdXJl
DQo+ID4gcmVnaW9uLCB0aGVuIHVzZSBDUFUgdG8gY29weSB0aGUgaW1hZ2UgZnJvbSB0cmFtcG9s
aW5lIGJ1ZmZlciB0bw0KPiA+IGRlc3RpbmF0aW9uIHNlY3VyZSByZWdpb24uDQo+IENhbiB0aGUg
YXR0YWNrZXIgaW50ZXJjZXB0IHRoaXMgYW5kIHJld3JpdGUgdGhlIHNvb24tdG8tYmUtc2VjdXJl
LW9ubHkgc29mdHdhcmUNCj4gd2l0aCBzb21ldGhpbmcgdGhhdCB3b3VsZCBsYXRlciBhbGxvdyB0
aGVtIHRvIHRha2Ugb3ZlciB0aGUgc3lzdGVtID8gRm9yDQo+IGV4YW1wbGUsIGNvdWxkIHRoZSBh
dHRhY2tlciBmbGlwIHNvbWUgc2VjdXJlLXRlc3QgYml0IGluIHRoZSBURUUgd2hpbGUgaXQgaXMg
aW4NCj4gbm9uLXNlY3VyZSBEUkFNIGFuZCBiZWZvcmUgaXQgaXMgY29waWVkIGluIHRoZSBzZWN1
cmUgbG9jYXRpb24sIGFuZCBtYWtlIFRFRQ0KPiBhY2NlcHQgcHJpdmlsZWdlZCBTTUMgb3BlcmF0
aW9ucyBmcm9tIGFueSB1bnByaXZpbGVnZWQgc29mdHdhcmUgPw0KDQpVc2VyIGNhbiBhdXRoZW50
aWNhdGUgT1AtVEVFLiBXaGVuIGF1dGhlbnRpY2F0aW9uIHN1Y2NlZWRzLCBPUC1URUUgaGFzIG5v
dCBiZWVuIG1vZGlmaWVkLg0KDQpCZXN0IFJlZ2FyZHMsDQpBbGljZSBHdW8NCg0K
