Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4836C531DC
	for <u-boot@archiver.kernel.org>; Tue, 20 Aug 2024 13:28:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E54388840;
	Tue, 20 Aug 2024 15:28:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sony.com header.i=@sony.com header.b="jHZr8sZB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2CF5883D4; Tue, 20 Aug 2024 04:45:31 +0200 (CEST)
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com
 [185.183.30.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 024B387FBC
 for <u-boot@lists.denx.de>; Tue, 20 Aug 2024 04:45:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=JianfengA.Zhu@sony.com
Received: from pps.filterd (m0209321.ppops.net [127.0.0.1])
 by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47K2VMpB008466;
 Tue, 20 Aug 2024 02:45:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=S1; bh=o7mENyP
 5uSo/3JpM2GVwPvDT//NV1iFYljVg8ShAlP0=; b=jHZr8sZBLeXjo4Y0WU9+CZO
 i+DVZmzt32fVKUFlXqgavBj132qp9dDNBLq3+ZArQC5Sv9WqDSHxkuCyXGpecG2F
 FQKJaqlbUgDAzal4VFXjhKXu/UEDMmnWVQ6h9rlqm0q7gvZLNKkDV/hnODa6Ih1w
 MXL24Dk1vpQ6PCgMg90UXnoaSUOV/tE7lE5OfJo5/ckLVwmyEGVA4a2nEiXw7mPU
 Qw6nAG/1mR6TuWi3ziTXlcPdfkRr8lPsHp7s84Pldwj8DpOBdJs5jRpaXAlfBR+j
 2hFnWifQdqXF6Ql1Png+sJstqu92Ut/DwnGw9UhALIpaeZA9DCZ70vPEwp29P8w=
 =
Received: from apc01-psa-obe.outbound.protection.outlook.com
 (mail-psaapc01lp2040.outbound.protection.outlook.com [104.47.26.40])
 by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 412mncj0pd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 20 Aug 2024 02:45:22 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DCfz8Sd0i8ngAFzR3KhuWk26iGj9LVG94ukn/B5pUWF1ICeUW0CHNqloo1s3nen8QC4ShR15ib4Ibg96r/AwfVRulVShc5wEc8UIkfeUD4okrdvWPAwdRiOLeesnsi7EAc4K7A/ZWDDmHZH1M3vufv3GNynyLGQpDVQ0BywoTGg+nZ8pJsBOVAwuygFrFu9tk3gWbGYFCE5zMoXHJMcPpuZ9rewNQNITBzSnuFFVNg7V0ToIZ2Bi3qsZbq2DkCJ2JYZgK67I+Vr1cI+iK9ZIWihEozrmEkHd0IdrVH0foY++a9J6Cn7btmMTugaY0LS74BNS0DyvPReljsGht1zH1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o7mENyP5uSo/3JpM2GVwPvDT//NV1iFYljVg8ShAlP0=;
 b=TRdrO0ySXszTfzFjtj0s3srEsWt7XxcVF8hn8X2zVBfT6/uhKRvX/PMQA29Qp9smHVAwlKayuwJTomRScpFgtKh6i+rq1z0Q7/tNXMa2kLdyDqwE3p1MdrohJ/wSCT7uFV1Hoc2PWJ6Wx48q/CvDjNek/lJXkGSEIlsBDbV/zAE/2ft1Oc8TBpxe91MkPi/q252yToWTeZrm1tB2fz91AS0hpjJdqoXjkQHBTfMjtpl1se2ztJ+VsB2oOElDfOGyTvpFBdhn9uWcCQPWv/id1snCSCqFmWSeo2gzWSnjvcq4wja3UXGNnaQqLrguokvS6hmB/1bN6dxUJy6K5pH8iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from OSQPR04MB7740.apcprd04.prod.outlook.com (2603:1096:604:283::6)
 by TY0PR04MB6253.apcprd04.prod.outlook.com (2603:1096:400:32a::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Tue, 20 Aug
 2024 02:45:12 +0000
Received: from OSQPR04MB7740.apcprd04.prod.outlook.com
 ([fe80::7c06:41d9:f38c:e1bd]) by OSQPR04MB7740.apcprd04.prod.outlook.com
 ([fe80::7c06:41d9:f38c:e1bd%6]) with mapi id 15.20.7875.018; Tue, 20 Aug 2024
 02:45:12 +0000
From: "JianfengA.Zhu@sony.com" <JianfengA.Zhu@sony.com>
To: Caleb Connolly <caleb.connolly@linaro.org>, Marek Vasut <marex@denx.de>,
 "neil.armstrong@linaro.org" <neil.armstrong@linaro.org>,
 "trini@konsulko.com" <trini@konsulko.com>
CC: "Jacky.Cao@sony.com" <Jacky.Cao@sony.com>, "u-boot-qcom@groups.io"
 <u-boot-qcom@groups.io>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: =?utf-8?B?5Zue5aSNOiB1c2I6IGVoY2k6IEZpeCBkYjQxMGMgdXNiIHJlc2V0IG5vdCB3?=
 =?utf-8?Q?orking?=
Thread-Topic: usb: ehci: Fix db410c usb reset not working
Thread-Index: AQHa8doyfZyzV2yuBUCqkBKJjB90ZLIucCIAgAACHICAAP4l2Q==
Date: Tue, 20 Aug 2024 02:45:12 +0000
Message-ID: <OSQPR04MB7740CBE65155F2A6C0D7D6C0908D2@OSQPR04MB7740.apcprd04.prod.outlook.com>
References: <OSQPR04MB77401D18913B397B768EC042908C2@OSQPR04MB7740.apcprd04.prod.outlook.com>
 <6d338e52-2817-4612-8592-f67cbf942b48@denx.de>
 <4ca6cb11-f616-4842-b253-21a7ba8253d7@linaro.org>
In-Reply-To: <4ca6cb11-f616-4842-b253-21a7ba8253d7@linaro.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSQPR04MB7740:EE_|TY0PR04MB6253:EE_
x-ms-office365-filtering-correlation-id: 966c50f7-e767-46df-eac3-08dcc0c21d1f
x-proofpoint-id: d8690225-876f-412f-87c6-a7cb45557a4c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?TzBMTjNoNmNCb3l5eUN3SmVmb2VZdkNkZmJ5Zk5jbEEzTEVCcU56Y2ZWd0xo?=
 =?utf-8?B?eEZxeDJmbDJyRmEwU3pRWW00TlU5RU5DZHFrdjV6aStPWUdzeXhoVERLMC84?=
 =?utf-8?B?Yis2ZWVTYmhlOWZTcHNnd2JkTjkwSVlBUWg0djQzeDJaVXNranVZZFJWZlpx?=
 =?utf-8?B?bStiVEVlekU2UUd2ODhLRldPdGhLNnliVmNCZlhiK1pPTVZ4RVFJbGRzQkZ6?=
 =?utf-8?B?ZXJwSldqaWtlWElNZVFZNDVNMkk0L0pnU3BmTkZtdXZhaUR3dk0rcDYyRit2?=
 =?utf-8?B?b1EzakQ0MmR1bldwVnV1ZnFtZ1did2g1eHZ4aUZubmRSOTF2MXFEMEo1T2o4?=
 =?utf-8?B?VUVNUDVaV3FYU3E2YmdBWDdWQ2NPNnRobTRRSW9mU0tjTDhIQnlRVFY3QjV0?=
 =?utf-8?B?Rkd4RVdSaGp3eTdia1VLVXpobjBqalYwWER2MkVkd3FhYWdrVkkxRnRzUmNr?=
 =?utf-8?B?Q2pxTlpCSTJqQjA3STJPTjFQN0NWQkN5bmZBd3F5RjUzSkJxaHVZY0NyNXNE?=
 =?utf-8?B?U1JsbE1ZSFBGNmFzbEc1MGFRTHlyUm1SOHlLNmdKbzJ4clp0UEFJTGJVUVFy?=
 =?utf-8?B?OVRrZlRVOUFOLzJwQVNXYlVtVnhtUUVhbTdCNVhWQm9hRWI0eDFvSUZJNzh4?=
 =?utf-8?B?V2lENWQ5MStOT3l4R3ZVVW5xb2ZsMUxwQ0VTYll5WEt6TVZ4a2FuYUpyamJt?=
 =?utf-8?B?VXhkemJMVFFmQnNIWC9QOEJVaHZyaVk1R2ZwVEtGeHdtWmE1RVlVN0JyeVA2?=
 =?utf-8?B?T3FZVGEwcnptYUhBQldDU3prdUQ1Z05EOHhHVVVaaDBTSkZvbTBGRDU1OWJS?=
 =?utf-8?B?Y1k5L1pFWEZsVGZReVRncXYxcURBS1pYNzFHaXUwUkpBd0p0clNqZXpCRS8z?=
 =?utf-8?B?Y1F3dDdJUi8rNEx2SHgvenB6YnNicEZKbzZsMWxPcmVBUUlmN2ZkbTlBbVEz?=
 =?utf-8?B?TDB0VjNRRnpuWS9RNlBMYkVzQ3JvVUFvWkMxT3ZaR2k5bUQwVGdUNmhiTllC?=
 =?utf-8?B?M1dUNWZPcHN1OHJKRi94NmdaK1RoRkgvU1F1TzM0TE1rY0pBRER4NWh2ak0r?=
 =?utf-8?B?d1Rhc2ovb2NwTlBMK0RzaytXYlMzb3pLQXIrVXorSlp3UHJodW5KNHpDVVRn?=
 =?utf-8?B?WTk0OHJacGtZRnc1Tk44dldoUFB4TEVXaHNEUjgrazFqak1XaUlGaFpsRXdJ?=
 =?utf-8?B?c0M4TDNqbG5BbmhuZ0tJQXdXNHNZcWtITlk4Q3BRNDNjd2dsSjJqL3dsa0xJ?=
 =?utf-8?B?UkRjUDUwUXVVTXorcGY3OUprUlduQy9UUTRtNHNkRkJVOXdCTTZtUWswS09K?=
 =?utf-8?B?dDJZZWxxeHZqUi9SSWdKaG4za253eUUwL20xNUZnRGNGMVJWQmtQbktnY0Ja?=
 =?utf-8?B?aWZrRmpVVElBSklXT3BON2RKcjdocTQ0OGZrUVNraGMwREZyVmphK0dQZ0NN?=
 =?utf-8?B?U0cvbjRxd2RwYXA3OG9YcVRQMFdjcHM1dCtQb3FIYWMrRFpVWFlEMjI0SGJX?=
 =?utf-8?B?TTV3d1JGOVZOMFFPZUhpaktOc2x5MDFJME56RWZyYzAzUGp6RGV4K2w3Z01t?=
 =?utf-8?B?aHFOUjNiOGpsYmdDakwwNU8vaE5CTHBxYWgrbWh1Mm1VU3NlUXZwTXdjWHdZ?=
 =?utf-8?B?U2FSeWZRY1k3alB0dktua091VHpacHliODVjZlh3Ylk0OWl2QzRzOStvUWUv?=
 =?utf-8?B?bUo5QnBtaXdObFFXOGlTbjFGL01rdGlxVnY0dzlobTl3MVJsRU5NRFNkOERP?=
 =?utf-8?B?a0J5dzdpeElpU21WTStjaHp1cjk2U3dyYjN1RWdBcURwMjZoR051NTJlRHho?=
 =?utf-8?B?QVgrZVh3UHVOR05FVHM0Rzh2c05XKzk4M2UzSjNocFhZUWJlWDVPUS8vbTJn?=
 =?utf-8?B?QjFxQ1h4di9LcHlzNEF3L1VYbm9RajI1OURCdTluN1Eranc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:OSQPR04MB7740.apcprd04.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TEVQemh3REY1SUE1NHRBUzJUaXVlOTBSNWhjT1d3MUliSDhYa1FsR3prdmN0?=
 =?utf-8?B?b1NGMWlHazUzTkxWMWVuYmlsSzRQV0kxd2lnclJTVmF6MExCODJ2WVMyTlFm?=
 =?utf-8?B?eHVsL3h2eUNZc0ZxdmNaU01tYjdMVS9Gd3c2VW5ZMkFaU3B0T096bmJVRG40?=
 =?utf-8?B?em9HcUsrZklZM3RNZ1ZwL0dCSFJiWXFpWDNSbGprM0VGNnhlbFZMcWpVZlJL?=
 =?utf-8?B?cU5nRSt5S0dXSXlBTHF4NHhpcXNIQkFzTDJnWDFTVU8vdUJzTk9ReEluT1I4?=
 =?utf-8?B?UzdkT1U1THdORXVjUHFyam1HMmhhTFdOd1VVMVdnVzFuS21TdU5UK2JuYUNr?=
 =?utf-8?B?NkprTTBPNC9mQlFsTVNwbkxSUTR0aG5sM0JPbUdPNms0ZzEzbExENnNBRUZ3?=
 =?utf-8?B?U0tvYkE0SFlaYmI1V2FhbnV0T3ZHSnJyU3kxOGFVb0pUT3dzK1l1dGo2ODZi?=
 =?utf-8?B?ZFBjcitScG5KMnQwMXBWdHlSLzZOL0NlWWhtQjRGamxXRE4wQnBrUklOc2FF?=
 =?utf-8?B?aGZ4dkxzMk90T292M1N1enpFRVZVVSt5bmdjZ2IvMjhLU1NQZFdSYi9IK3ZY?=
 =?utf-8?B?NXYxL1RzRFBHYk9mRjRUY3d0NytCdEFzYXBSS3NzWWlDdHorNDlRd1lmOUxx?=
 =?utf-8?B?dFM3TmVLUXpqWnRaVWVmREJsT1pLK29DN1FJT0IrSXVnTTgvNVVmT014clNn?=
 =?utf-8?B?c0VSc1JmelFKUWJxTkFibm1pTmd0NmNXVzdrRFJZT3E0Zmxnb1g4SWRsdnBS?=
 =?utf-8?B?T2Fya3p4Y2VCYUJHNW5pNE9pMkQ1YjRzdFE0MlEwbWhWSnJoVkt6R2hUeXZZ?=
 =?utf-8?B?TUduZmlLdnBrWTRRQXBiTkc3Y1Z6QStHSWpLTWNLbkdQN0FROWlQaGxxQ0JP?=
 =?utf-8?B?aWVPcnBYdVlhcEVVc1d0N1MySkhHY2h3elJCK0RBalR6YUFKUlRILzl1SnpF?=
 =?utf-8?B?V2piWERrM0ZiQXlGNDJIM0pPK1NuYjg0SFR1WUlGNWM1VUdnRlRKb1FWTG15?=
 =?utf-8?B?NFdCdTdvSFQxOURDamhJZTJqUlNNY0NhOHl1VjRPOVlNYkgvRTNCNGY0Q0lR?=
 =?utf-8?B?MmhUWG13WTRVOENSS0ljN0dwRVoycnBrazNFWXVSRlFqZUJLcWpEcElFR1Jl?=
 =?utf-8?B?N3pnYlBMRFBGbGcwZE5FcWVGYjU3YWp2MkNyeUZpV1VqaXVFd1pqdENhR0FL?=
 =?utf-8?B?Nm1MS3NmL3BDQ3VGUmRIMHF1c0F6WmorTDMwTTB6ZThKVTR2ZDFWTVcwR3E4?=
 =?utf-8?B?TU1qVVZPbk1YNVRzeHNNajVQblc5SUM3RDcxRy95UUJ5SnQ1RzVtSVUxd3pD?=
 =?utf-8?B?Qmk4dk5Nai9rdkM4MWN5SXRRV3ZySHJybVI5cEsxb3Bmd3BySWtMand0V0ox?=
 =?utf-8?B?NVBSSTBRS2ZjeDhEa0pzcTBidGJ6OTFIemFIbDlVVUlXQjExeGtiZU40VnEv?=
 =?utf-8?B?Rmw5ZE9KWDZnWlBVb2Jhb0pPVnZJN0JFWWNNY3BtbkNKMWdzSGJLa0E3Zmdz?=
 =?utf-8?B?NTczcEZ2RUljblROTUlyVWIrZmdITVZyQTd1bWJUWVFjVDU5bW8xMkFhaVZv?=
 =?utf-8?B?aWsrVmtYYUIwWEx6MEtTRDUrOEtqNjFuenVHc3EvV3ZTdkpqVnJUaVFldmZp?=
 =?utf-8?B?V0lmTW91ckx1Q2hEWkx2dThuZ2Z5NTJQRWVsUWdEV1ZXbUQyYTZ6RHlaclQx?=
 =?utf-8?B?SWdsK3lRWStDODJEOGpmVUk4STFIbWlqN25CTk1wK05tbDY1SG8weXdOWVN0?=
 =?utf-8?B?TFBsQXJxSklqZENwR2hQNWVuN3lYUXlYQUJwRTZOVEFDN2FJRHpDVmR1UlZq?=
 =?utf-8?B?RGZBZzBuKzZyekllYnBwcTYrRGkxbU9za2wyY2lBZHV0RjNsNkYwZmQwc2JB?=
 =?utf-8?B?YU9qUk1adGtpbmp0eUo2SDVHdmRyRXlSSnlGME5iWGRUN2ZTTysvZjV1MTNJ?=
 =?utf-8?B?K0psTTFxYzlKNXhMZFlvVWgzakhua2dmbXBTOWpWZ2R1L3E5dXIrZjVpVktI?=
 =?utf-8?B?anhRY1lwRVY3aTVycnVFQVhyZ3ZsMDlnY1RTRDR3Z2d5cERiS3JwWjU2V1Fr?=
 =?utf-8?B?NUJ0Z0F6bithUCtVQ3N6ZXUyZ2hNYlJMVHJOcmtmMWRCYTJJV0FCMnN2NWd6?=
 =?utf-8?B?d3loYUg2Y2R5U3NpVi8yazRvcVQ5a3dxWmk1OXhNMlZVR3J4R0p5c3NzWWVu?=
 =?utf-8?Q?JBcXt1yV8nnfKB6QU5GqeZE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: bknkEut3r6+fbbHFVVfvWOIP+oeH0SRuyCzt7/s2YpF+woM1c++dcxCUQe82TUdtU8ORF4Dr862rP6JDOV0k+lotjTLhjJmgPrFGeL/CVu1xIKafnvcNYirIlhK38rQxKe4I8yhpCdx/i2LbsoER9/rn4+P1qwnBMEoj1PyRMDBiBFMHt45wCLpkYZE5qBVgp26b2hDP4AmaSofMgCMKoI6uKXlQt7FYKxkOi2dQdD+d6nBxpQPMq2Fuombi6rMfpdIJTteIOyTkdN7P8Hbr5AS5t1nSEU8poew9oUNiISX2lIWbC/LzsxBEgGm+ykD68fcWclxQlawz4hzWFmyD91j9S6pvp37BKrPpXbEfOXvSjweguoYSyA7CLhCfMqroBILs7/WTZiodTuKq9Ys3h+0YjyKiGZctsbvMmFyDvlo2cWMwrb0VpbaNd6XQv64/xlScruLGalW7tkUlDyonKQAhYMZ77k+cexBYvEwY0UBVyomIGbB6N0kS46tTxOxO2RT0nh5gvIUpx7TG+U29BcbShxWsyPB02ssesl9UoWcx6cNBzg9P+mfkql24omMvHGNiipYHuyqeNqSThhY++pqUeU77LgvALkrgkVJG6aOkR2OQqDwW8CvKtgVWOVHr
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSQPR04MB7740.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 966c50f7-e767-46df-eac3-08dcc0c21d1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2024 02:45:12.4152 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dfy6U3qcHBQQy56cPDs998IDwNhZ/JGtuWEta/8Rg8Yacl2wAqgdA7Ie+PrKl44xmBzemljjD6E5ZpBZvC3Qxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR04MB6253
X-Proofpoint-ORIG-GUID: vpnkkdfi46ctgKauXQNx6XNrN-tohtjE
X-Proofpoint-GUID: vpnkkdfi46ctgKauXQNx6XNrN-tohtjE
X-Sony-Outbound-GUID: vpnkkdfi46ctgKauXQNx6XNrN-tohtjE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-19_16,2024-08-19_03,2024-05-17_01
X-Mailman-Approved-At: Tue, 20 Aug 2024 15:28:03 +0200
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

PiBKaWFuZmVuZzogY291bGQgeW91IHJ1biB0aGUgdXNiIHJlc2V0IGNvbW1hbmQgd2l0aCBsb2cg
bGV2ZWwgOCBhbmQgcGFzdGUgCj4gYSBsb2c/IFRoYXQgbWlnaHQgcmV2ZWFsIHdoZXJlIHRoZSBG
RFQgbG9va3VwIGdvZXMgd3JvbmcuCgpQbGVhc2UgY29uZmlybSBiZWxvdyBsb2cgd2l0aCBsZXZl
bCA4IAoKZHJhZ29uYm9hcmQ0MTBjID0+IHVzYiByZXNldApyZXNldHRpbmcgVVNCLi4uClNlbmRp
bmcgZXZlbnQgNS8odW5rbm93bikgdG8gc3B5ICdlZmlfZGlzayBhZGQnCkJ1cyB1c2JANzhkOTAw
MDogb2Zub2RlX3JlYWRfcHJvcDogYXNzaWduZWQtY2xvY2stcmF0ZXM6IDxub3QgZm91bmQ+ClNl
bmRpbmcgZXZlbnQgNS8odW5rbm93bikgdG8gc3B5ICdlZmlfZGlzayBhZGQnCm9mbm9kZV9yZWFk
X3Byb3A6IGFzc2lnbmVkLWNsb2NrLXJhdGVzOiA8bm90IGZvdW5kPgpTZW5kaW5nIGV2ZW50IDUv
KHVua25vd24pIHRvIHNweSAnZWZpX2Rpc2sgYWRkJwpvZm5vZGVfcmVhZF9wcm9wOiBhc3NpZ25l
ZC1jbG9jay1yYXRlczogb2Zub2RlX3JlYWRfdTMyX2FycmF5OiBhc3NpZ25lZC1jbG9jay1yYXRl
czogTG9va2luZyBmb3IgY2xvY2stY29udHJvbGxlckAxODAwMDAwCkxvb2tpbmcgZm9yIGNsb2Nr
LWNvbnRyb2xsZXJAMTgwMDAwMAogICAgICAtIGNoZWNraW5nIHFjb21fY2xrCiAgIC0gcmVzdWx0
IGZvciBjbG9jay1jb250cm9sbGVyQDE4MDAwMDA6IHFjb21fY2xrIChyZXQ9MCkKICAgLSByZXN1
bHQgZm9yIGNsb2NrLWNvbnRyb2xsZXJAMTgwMDAwMDogcWNvbV9jbGsgKHJldD0wKQpMb29raW5n
IGZvciBjbG9jay1jb250cm9sbGVyQDE4MDAwMDAKTG9va2luZyBmb3IgY2xvY2stY29udHJvbGxl
ckAxODAwMDAwCiAgICAgIC0gY2hlY2tpbmcgcWNvbV9jbGsKICAgLSByZXN1bHQgZm9yIGNsb2Nr
LWNvbnRyb2xsZXJAMTgwMDAwMDogcWNvbV9jbGsgKHJldD0wKQogICAtIHJlc3VsdCBmb3IgY2xv
Y2stY29udHJvbGxlckAxODAwMDAwOiBxY29tX2NsayAocmV0PTApCkxvb2tpbmcgZm9yIGNsb2Nr
LWNvbnRyb2xsZXJAMTgwMDAwMApMb29raW5nIGZvciBjbG9jay1jb250cm9sbGVyQDE4MDAwMDAK
ICAgICAgLSBjaGVja2luZyBxY29tX2NsawogICAtIHJlc3VsdCBmb3IgY2xvY2stY29udHJvbGxl
ckAxODAwMDAwOiBxY29tX2NsayAocmV0PTApCiAgIC0gcmVzdWx0IGZvciBjbG9jay1jb250cm9s
bGVyQDE4MDAwMDA6IHFjb21fY2xrIChyZXQ9MCkKTG9va2luZyBmb3IgcGh5Ckxvb2tpbmcgZm9y
IHBoeQogICAtIHJlc3VsdCBmb3IgcGh5OiAobm9uZSkgKHJldD0tMTkpCiAgIC0gcmVzdWx0IGZv
ciBwaHk6IChub25lKSAocmV0PS0xOSkKTG9va2luZyBmb3IgdWxwaQpMb29raW5nIGZvciB1bHBp
CiAgIC0gcmVzdWx0IGZvciB1bHBpOiAobm9uZSkgKHJldD0tMTkpCiAgIC0gcmVzdWx0IGZvciB1
bHBpOiAobm9uZSkgKHJldD0tMTkpClBvcnQgbm90IGF2YWlsYWJsZS4KZHJhZ29uYm9hcmQ0MTBj
ID0+IAoKQmVzdCBSZWdhcmRzCmppYW5mZW5nIHpodQoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwrlj5Hku7bkuro6wqBDYWxlYiBDb25ub2xseSA8Y2FsZWIuY29ubm9s
bHlAbGluYXJvLm9yZz4K5Y+R6YCB5pe26Ze0OsKgMjAyNOW5tDjmnIgxOeaXpSAxOToyOArmlLbk
u7bkuro6wqBNYXJlayBWYXN1dCA8bWFyZXhAZGVueC5kZT47IFpodSwgSmlhbmZlbmcgPEppYW5m
ZW5nQS5aaHVAc29ueS5jb20+OyBuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnIDxuZWlsLmFybXN0
cm9uZ0BsaW5hcm8ub3JnPjsgdHJpbmlAa29uc3Vsa28uY29tIDx0cmluaUBrb25zdWxrby5jb20+
CuaKhOmAgTrCoENhbywgSmFja3kgPEphY2t5LkNhb0Bzb255LmNvbT47IHUtYm9vdC1xY29tQGdy
b3Vwcy5pbyA8dS1ib290LXFjb21AZ3JvdXBzLmlvPjsgdS1ib290QGxpc3RzLmRlbnguZGUgPHUt
Ym9vdEBsaXN0cy5kZW54LmRlPgrkuLvpopg6wqBSZTogdXNiOiBlaGNpOiBGaXggZGI0MTBjIHVz
YiByZXNldCBub3Qgd29ya2luZwrCoApPbiAxOS8wOC8yMDI0IDEzOjIxLCBNYXJlayBWYXN1dCB3
cm90ZToKPiBPbiA4LzE5LzI0IDQ6MDUgQU0sIEppYW5mZW5nQS5aaHVAc29ueS5jb20gd3JvdGU6
Cj4+IHVzYiByZXNldCBub3Qgd29ya2luZyBlcnJvciBsb2cKPj4gPT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KPj4gZHJh
Z29uYm9hcmQ0MTBjID0+IHVzYiByZXNldAo+PiByZXNldHRpbmcgVVNCLi4uCj4+IEJ1cyB1c2JA
NzhkOTAwMDogUG9ydCBub3QgYXZhaWxhYmxlLgo+PiBkcmFnb25ib2FyZDQxMGMgPT4KPj4gPT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT0KPj4KPj4gQWZ0ZXIgY29tbWl0IGVkOGZiZDI4ODlmYyAoImR0czogbXNtODkxNjog
cmVwbGFjZSB3aXRoIHVwc3RyZWFtIERUUyIpCj4+IG1zbTg5MTZfdXNicGh5IHdpbGwgYmUgZGVm
aW5lZCBhcyBhIGNoaWxkIGRldmljZSBvZiB1c2JANzhkOTAwMC4gdXNiIAo+PiByZXNldAo+PiB3
aWxsIGZpcnN0IGNhbGwgdXNiX3N0b3AsIGFuZCBtc204OTE2X3VzYnBoeSBhcyBjaGlsZCBkZXYg
d2lsbCBiZSB1bmJpbmQKPj4gaW4gdXNiX3N0b3AsIGFuZCB0aGVyZSBpcyBubyBiaW5kIG9wZXJh
dGlvbiBpbiBkb191c2Jfc3RhcnQgCj4+IGFmdGVyd2FyZHMsIHNvCj4+IHRoZSBtc204OTE2X3Vz
YnBoeSB1Y2xhc3MgY2Fubm90IGJlIGZvdW5kLiBUaGlzIGNhdXNlcyBlaGNpX21zbSBwcm9iZSB0
bwo+PiBmYWlsLgo+Pgo+PiBEZXRhaWxlZCBjYWxsaW5nIHByb2Nlc3MKPj4gPT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0K
Pj4gdXNiIHJlc2V0Ogo+PiB8LT4gdXNiX3N0b3AgKGRyaXZlcnMvdXNiL2hvc3QvdXNiLXVjbGFz
cy5jKQo+PiAufC0+IGRldmljZV9maW5kX2ZpcnN0X2NoaWxkCj4+IC4gfC0+IGRldmljZV91bmJp
bmQocmgpOyA8PT0gKHVuYmluZCBtc204OTE2X3VzYnBoeSkKPj4gfC0+IGRvX3VzYl9zdGFydAo+
PiDCoCB8LT4gdXNiX2luaXQgKGRyaXZlcnMvdXNiL2hvc3QvdXNiLXVjbGFzcy5jKQo+PiDCoMKg
IHwtPiBkZXZpY2VfcHJvYmUoYnVzKTsKPj4gwqDCoMKgIHwtPiBlaGNpX3VzYl9wcm9iZQo+PiDC
oMKgwqDCoCB8LT4gZ2VuZXJpY19zZXR1cF9waHkgPD09IGVyciBjb3VsZG4ndCBmaW5kIG1zbTg5
MTZfdXNicGh5Cj4+ID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09Cj4+Cj4+IEZpeDogcmViaW5kIHRoZSBtc204OTE2X3Vz
YnBoeSBkcml2ZXIgZHVyaW5nIGVoY2lfdXNiX3Byb2JlIGlmIHRoZQo+PiBtc204OTE2X3VzYnBo
eSB1Y2xhc3MgaGFzIGJlZW4gcmVtb3ZlZC4KPj4KPj4gU2lnbmVkLW9mZi1ieTogSmlhbmZlbmcg
Wmh1IDxKaWFuZmVuZ0EuWmh1QHNvbnkuY29tPgo+PiBSZXZpZXdlZC1ieTogSmFja3kgQ2FvIDxK
YWNreS5DYW9Ac29ueS5jb20+Cj4+IFJldmlld2VkLWJ5OiBUb3lhbWEsIFlvc2hpaGlybyA8WW9z
aGloaXJvLlRveWFtYUBzb255LmNvbT4KPj4gLS0tCj4+IMKgIGRyaXZlcnMvdXNiL2hvc3QvZWhj
aS1tc20uYyB8IDcgKysrKysrKwo+PiDCoCAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCsp
Cj4+Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9ob3N0L2VoY2ktbXNtLmMgYi9kcml2ZXJz
L3VzYi9ob3N0L2VoY2ktbXNtLmMKPj4gaW5kZXggZmYzMzYwODJlMy4uN2NiM2FlMDg0OSAxMDA2
NDQKPj4gLS0tIGEvZHJpdmVycy91c2IvaG9zdC9laGNpLW1zbS5jCj4+ICsrKyBiL2RyaXZlcnMv
dXNiL2hvc3QvZWhjaS1tc20uYwo+PiBAQCAtNDcsNiArNDcsOCBAQCBzdGF0aWMgY29uc3Qgc3Ry
dWN0IGVoY2lfb3BzIG1zbV9laGNpX29wcyA9IHsKPj4gwqDCoMKgwqDCoCAuaW5pdF9hZnRlcl9y
ZXNldCA9IG1zbV9pbml0X2FmdGVyX3Jlc2V0Cj4+IMKgIH07Cj4+ICtzdGF0aWMgaW50IGVoY2lf
dXNiX29mX2JpbmQoc3RydWN0IHVkZXZpY2UgKmRldik7Cj4+ICsKPj4gwqAgc3RhdGljIGludCBl
aGNpX3VzYl9wcm9iZShzdHJ1Y3QgdWRldmljZSAqZGV2KQo+PiDCoCB7Cj4+IMKgwqDCoMKgwqAg
c3RydWN0IG1zbV9laGNpX3ByaXYgKnAgPSBkZXZfZ2V0X3ByaXYoZGV2KTsKPj4gQEAgLTU0LDYg
KzU2LDcgQEAgc3RhdGljIGludCBlaGNpX3VzYl9wcm9iZShzdHJ1Y3QgdWRldmljZSAqZGV2KQo+
PiDCoMKgwqDCoMKgIHN0cnVjdCB1c2JfcGxhdCAqcGxhdCA9IGRldl9nZXRfcGxhdChkZXYpOwo+
PiDCoMKgwqDCoMKgIHN0cnVjdCBlaGNpX2hjY3IgKmhjY3I7Cj4+IMKgwqDCoMKgwqAgc3RydWN0
IGVoY2lfaGNvciAqaGNvcjsKPj4gK8KgwqDCoCBzdHJ1Y3QgdWRldmljZSAqcGh5ZGV2Owo+PiDC
oMKgwqDCoMKgIGludCByZXQ7Cj4+IMKgwqDCoMKgwqAgcmV0ID0gY2xrX2dldF9ieV9uYW1lKGRl
diwgImNvcmUiLCAmcC0+Y29yZV9jbGspOwo+PiBAQCAtODAsNiArODMsMTAgQEAgc3RhdGljIGlu
dCBlaGNpX3VzYl9wcm9iZShzdHJ1Y3QgdWRldmljZSAqZGV2KQo+PiDCoMKgwqDCoMKgIGhjb3Ig
PSAoc3RydWN0IGVoY2lfaGNvciAqKSgocGh5c19hZGRyX3QpaGNjciArCj4+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIEhDX0xFTkdUSChlaGNpX3JlYWRsKCYoaGNjciktPmNyX2NhcGJhc2Up
KSk7Cj4+ICvCoMKgwqAgcmV0ID0gdWNsYXNzX2dldF9kZXZpY2VfYnlfbmFtZShVQ0xBU1NfUEhZ
LCAibXNtODkxNl91c2JwaHkiLCAKPj4gJnBoeWRldik7Cj4gCj4gVGhhbmtzIGZvciBsb29raW5n
IGludG8gdGhpcy4KPiAKPiBDYWxlYiwgZG8geW91IGtub3cgd2h5IGdlbmVyaWNfc2V0dXBfcGh5
KCkgc3RhcnRlZCBmYWlsaW5nIG5vdyA/IENhbiBpdCAKPiBiZSBmaXhlZCB0byBoYW5kbGUgdGhp
cyBwbGF0Zm9ybSBpbnN0ZWFkID8KCkknbSBub3Qgc3VyZSwgYnV0IEkgZG8gYWdyZWUgdGhhdCBp
dCBkb2Vzbid0IHNlZW0gbGlrZSB0aGlzIHBhdGNoIAphZGRyZXNzZXMgdGhlIHJvb3QgY2F1c2Uu
CgpKaWFuZmVuZzogY291bGQgeW91IHJ1biB0aGUgdXNiIHJlc2V0IGNvbW1hbmQgd2l0aCBsb2cg
bGV2ZWwgOCBhbmQgcGFzdGUgCmEgbG9nPyBUaGF0IG1pZ2h0IHJldmVhbCB3aGVyZSB0aGUgRkRU
IGxvb2t1cCBnb2VzIHdyb25nLgoKS2luZCByZWdhcmRzLAoKCi0tIAovLyBDYWxlYiAodGhleS90
aGVtKQo=
