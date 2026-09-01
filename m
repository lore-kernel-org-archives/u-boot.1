Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EFDAC624CF
	for <u-boot@archiver.kernel.org>; Tue,  1 Sep 2026 10:37:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E1FF680B19;
	Tue,  1 Sep 2026 10:37:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id t7Lsjua7FBrd; Tue,  1 Sep 2026 10:37:50 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788259070;
	bh=pY0RiqAwDcYARFjGtCQww6vmRXMBNLqB8plLRXOCWaU=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qiQovK6GrIPol7pP0IoeUd1uGyfeevZGQfZgiAptFPjkMr5S5fU/+I52JgW6I01vg
	 SC1PNaFrzeUswJbTANWi8p1r2qZmzQ1UfJO7IX63M+elkqznGHkKM/CM/BMYghcqWM
	 ZsN54yHFJO3Pkh5XT3jVeO3/vAtEIkOr6TZasofRzIpQHueUdUgGyqvywb6UZj4kjI
	 +h/3JKF91fD6+SaIqSdmVg1cZMO5a52PDuo/4mx0rdzTOQm3no/nwRAMV5Eoj6Wq1w
	 umR0MCZKkFty6y2CvEoVF59CDSi/rAF4LQxwFxd2gLm0DghPrsJhkxdoH+roI/+z3s
	 jJaGhfTBAtY/w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B801280989;
	Tue,  1 Sep 2026 10:37:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2B6FA1DE
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 10:37:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 091A54008E
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 10:37:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id j27fE2KLJeTC for <u-boot@lists.u-boot-project.org>;
 Tue,  1 Sep 2026 10:37:48 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c110::3;
 helo=bn8pr05cu002.outbound.protection.outlook.com;
 envelope-from=jayaramudu.desapogu@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=TzFqbViE
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::3])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A6B014000B
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 10:37:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tzwI1Hw9dLf6hG7F0+G1DD8NUpu19k8bnHr4CZw7NYO8aVFpXXPSHjSOhM5QDWJ/hVWnYitfIicFXSFfFmNVed2w7IrSx1HvY7s5kOOUm/BE3SLO0e0ACPvYO7JDJZiCNKK4j9tTp9NiF/y2j9yWnGVWz9r45eIP136Gjt61dEs06+SVRz1AzzoWUnztlHEsFp8G3dAVQbRHlxK8suFau8oUEAGqi2LTVR5X5b3hKJtZxo7Tpd7xQmjTklCqMLFfurOwu8lxu9os5aFK2PAAnt/GQ0G0pnagyZsEtURPKWVKvi2Q7HH0sVEXOmc0bUAOgIRbAR8FNMxTTAV6FyDv3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pY0RiqAwDcYARFjGtCQww6vmRXMBNLqB8plLRXOCWaU=;
 b=W5ly7WByg3uhT+1HajLAWYiW9aUzAOJDF3oZVZDJX3K31U0+Wc/WGlkW+tG3ky6D/jy7gBd0ZAHT4O4kKpmZfiqk9Pk29l8gCyvYWHQ7KQYVxX7bEXmYx9jxCNUemJiKFoHW46x5vDdDxYKMNLpm3K8o+ET5fukbrNx1aKY3PZh5sVdHAJ+ieMnYQe/9A5mHXoH2b9hZKn9twl6FgyHYQ6phj6J6nXNg+26OVwC4VSpeEYqgFNxTevlPys/NO4gQ5IQSKf6u8RyQvgitfEmWFcSEvF5aALiQAmgKuYxV+x/WpCQURh9hDNkC3496y/ZOh6i7srsPHPrNSD0Cuq5ebQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pY0RiqAwDcYARFjGtCQww6vmRXMBNLqB8plLRXOCWaU=;
 b=TzFqbViEzOzgpWEhq151Zn6kp9eu9jEmJa75e2BY2BZdYZpSa7hTG/ri5R4v/mXaiTQ6MLRBtMG/1mjjMsTzTuHw6RILkJgHUp1kewg36vMdVqsNw0HcGDgEJmZYnGzk5vLaDAA9VU38zAvNrAYDaXVtV9S1B0IYPAD4gc6O+rE=
Received: from LV8PR12MB9360.namprd12.prod.outlook.com (2603:10b6:408:205::16)
 by SN7PR12MB8058.namprd12.prod.outlook.com (2603:10b6:806:348::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 10:37:31 +0000
Received: from LV8PR12MB9360.namprd12.prod.outlook.com
 ([fe80::75a4:7817:3fe:f0b1]) by LV8PR12MB9360.namprd12.prod.outlook.com
 ([fe80::75a4:7817:3fe:f0b1%6]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 10:37:31 +0000
From: "Desapogu, Jayaramudu" <Jayaramudu.Desapogu@amd.com>
To: Simon Glass <sjg@chromium.org>
CC: "trini@konsulko.com" <trini@konsulko.com>,
 "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>
Subject: RE: [PATCH v3] x86: cpu: x86_64: Detect CPU vendor and device ID
 using cpuid
Thread-Topic: [PATCH v3] x86: cpu: x86_64: Detect CPU vendor and device ID
 using cpuid
Thread-Index: AQHdNKBLu8S01c0jVE2qz+/GWYXHRLavEv8AgAp+SWA=
Date: Tue, 1 Sep 2026 10:37:31 +0000
Message-ID: <LV8PR12MB93604B707C8C414FBF350A96E4A82@LV8PR12MB9360.namprd12.prod.outlook.com>
References: <20260814171829.384826-1-jayaramudu.desapogu@amd.com>
 <20260825144421.184361-1-jayaramudu.desapogu@amd.com>
 <CAFLszTj5gWZbd71x38JLcxLjB50+j9dbe1CP5nDHvr=TjtJ1LQ@mail.gmail.com>
In-Reply-To: <CAFLszTj5gWZbd71x38JLcxLjB50+j9dbe1CP5nDHvr=TjtJ1LQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-09-01T10:33:02.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR12MB9360:EE_|SN7PR12MB8058:EE_
x-ms-office365-filtering-correlation-id: 8d834ab5-b12e-4c4d-9129-08df081506d2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|3023799007|38070700021|10067099003|4143699003|11063799006|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info: gOQdDUvDYxybVq7M2XP6w51pm97dJeJKUbV3IAV0US3JTQIKctZT551Dc8P9fyn8j/BDpvI878sey0N7WtMBn+wZOT06C9AvP6w8P9d8z4l0J4EcE3jkLQ1GVdBBvV4f80v1o6FohN/kbcefpPWXQmti3oEEctDv7lvHvw5Wgoo0cjAFZh/vK5uvCTzZSDTPg2mWSHi814oZSZyIL0ReYMhFbOwpJZCuiB1wCDkfLbN+mw2ekPR16L8PcqItKxIC5trTlKw1t2xWOkah9uvG8F8me1wUPWEiDzQ5kAuqi/DhSXYqpDIYN4ulrVwQeG8BESU94IdGGm1qZS2ZrPuCPY9Cz5YoioDht3ApRtFS1PoWCYW0IqmDRQNgUxddUUeOV8kPKd8MYGM+K4qUsPQKKO3+jP5GBXsT8/5mmg9lypk3Pz4C7RBROM0H9Y1+IDGbbPox6VyDUL2Mqx8Jv62MLeQCSAu/bGWoXsQ+zV1R/QaLlACExc/zlCzEiJJ7MXk9FrFSanUQFbOfjdFZDzbyEr3Y3R51btFiNLEcC+O1FGcFoQxd+TvYrd5WGa13mPfrl7UIJSykLgWQbZ266hePGT+qQK2/Df5XNdxaQJiHsh2HY5Mqh58c9fSdkMCPqutw4GWGpnMm9+mhyFRHWnV0LFdJOpb2Yq6NclMF0gOqvjk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR12MB9360.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(3023799007)(38070700021)(10067099003)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ak5oVStRRlhjTG1hN21uQWUzdEhxNHcrTGcwQjFpb2p5OWFaREZvN0grYnl3?=
 =?utf-8?B?cENZLzV1NXJwV20xVTh0ZnErNGJQWGtLcXJ1NEtWb3Z1c2RJZ09tZjJEWU9u?=
 =?utf-8?B?bGMwbGF2TVF6NXFmQWJoaURwR3JhTHlUZElDNE51NWcxY1hZSGh0VlI2NERh?=
 =?utf-8?B?Y1FvOFZweGN5QVZYbDZqQ1EzRVdQSmJ4MFJaRnNtbnI3cUkzQzM0WVhsaG5i?=
 =?utf-8?B?OVZsUnh6TTRkUXVsdHorVlpPOGNVQkczdzNmeldic1JlMFlkS011Ri9SUTJl?=
 =?utf-8?B?emRLT3NEc2pFQWRvLytiNC9kN01iYjE5OHAzQW5NeVhYcjFjQjNmSGMwSnpj?=
 =?utf-8?B?U2VXeVR1QUF6UWdSb01VQ09lK0NYWC9zR1hCOWlna0lQZGZ4eXE2dExEdGJ1?=
 =?utf-8?B?WTliNU9DZm1QdDR0Y0xmZlIyUUd3UzJHTVZoZWNZa2luTWVZMGxIa3JBcXYr?=
 =?utf-8?B?RDd6ZEk1ckRoamoxU0NBNUNGNjlvM0U1SEY4QWRrLytWVVlFdGZVeDRBcjNy?=
 =?utf-8?B?ZmwxSEZ2amlzcHdXUGpTTHZFR1UzUEhzbFNKYnBRcmpGT1FwSDJYNGhyTmdm?=
 =?utf-8?B?SmY2OGhYWklLSEtuRWVJNTdwZ2RDeXI3UUNUR2pYRWNCcXFjcytqM0crYVY1?=
 =?utf-8?B?d2FqaVJvSEJza0k0aFZXcUhGRGZla0hBbjIwa01pSklwMnJKWk1OV1d2Mmhu?=
 =?utf-8?B?U0lOR0FDdis0R2tyeVB1K3FTTzU0RlRhcGdxakpOVHRjL0FRdFFURVRSeU5L?=
 =?utf-8?B?WlArMHViWmZTaUxqNkhSNzY4VGpQS0ZMR3FkSnpDWE1iNHZHQTRKNW9RMVI3?=
 =?utf-8?B?c3JYUzA1L3FNSG5oaFRiT2pjYmk0bERzVTNHZzEzK0U1TE9NWFQ0aW0wdTlV?=
 =?utf-8?B?UVp1ZGhhazRnUCtuTGkzUm1sK3kvZGNHRHBmZ1JWc0xxNVExWCtZc21SZVhP?=
 =?utf-8?B?MUM2STA3YzBCOHVOTkl0UXZaLzBXei9yYWc0c3N1cTZOMkNiODNOdGRZdnE3?=
 =?utf-8?B?dzBqbVB2WXc3MnFsTjJDRWtuSXBwRmNhdGVTbWk0MXR4dFg5cU5FSnJ6ZDNs?=
 =?utf-8?B?MkJYbzVCLzVMWmI5RUx2dTNGemgxNlFLb3gyWVB3bWdKV0dTMGE0VWxTazY4?=
 =?utf-8?B?a2VKOFFkelZMVXA1ZVhhWmJYS0V6WUNwdlV2MjdpcFdvZ09iVm9oa1k1WU1F?=
 =?utf-8?B?aFAxVVlDQWtQdTZsdjVqa2pTaDhoMnFsMmdTNjZqcGF1RXQwKzgvK1psSmVj?=
 =?utf-8?B?OHdPUVhMZ3N4ZHgzWHluVnJYbG9YR1BXMitsOWllOWdPRk05RGNwV1VNTlFN?=
 =?utf-8?B?YUtLY2xsSFM4N2JpK3A2a01OYlNYUlZXYlo5V2tiUVFzbkdjanF3bEZvQkk1?=
 =?utf-8?B?RERyTnpCendoWG9yUFh4RFY3Nk01c2ZEalNQb1BKblA1M3U1bTNYNGtkQTNp?=
 =?utf-8?B?NlE0M1B6NExMVUt4L2ZhNkl1UkoxU0tjdThnbmNVdmMzek9iZHpEOTlvQjk4?=
 =?utf-8?B?M2NURW9HRDdkYmFCTzBRbnNCRUZBcXlIR2EzSU1xeGRuK1p3YUczNHc2bGY3?=
 =?utf-8?B?bWxqUnExRGtFQlRtRzlHRjNHK2VIYXg4MFNkNHlOS0tsV1c5R295Z2x0eVFP?=
 =?utf-8?B?clJQcmNFZUhPZFpURSswTFdHWDdxYzNhRFRIS05QcUJxUHVxdlhJVHZYN09a?=
 =?utf-8?B?SjZSS283bjcwVktiSGxXSTZ0TE9IZzMrK2xYNjR0NE56eGxoUUNweUZwUzJk?=
 =?utf-8?B?czNCaG1vWVk4RklaR1NvZGZ2bzhXOCs1Y0trZEJzZ2ZmSFFsSGNTc3VtTkVr?=
 =?utf-8?B?QjlJUS8rUnA2ZSsyNTJZTGpzenJYNXNvOVAxdmU3d0xKb3FvVnViMS9LQnFj?=
 =?utf-8?B?NnZwREtSUGRxRnl2S1JGYTlGNG1TakNmTC9DWkYzTjBCZUsyWjJmcXE5aHdh?=
 =?utf-8?B?UVpYV3NFeHQ5NGZQcldZU2hXTkR6dDNvZmVQTzZ3bVNaWUFtY0ZmMmNEbGZJ?=
 =?utf-8?B?UEFCemJVeWlUU2NodjVuRHBkeWFlcmgyRmc0aVg0SjVrVTlUTXdLd25KSTFj?=
 =?utf-8?B?a2pzcGtCbkl2bHc4NkE1UnV1WmRzQ0JncW1WekhROEtpUGUvNC9OYUNhNG1F?=
 =?utf-8?B?MzJmQmxHOXhYblVQWjJtMTF4Z1VpVTJXclNwREZuTTNkSnNJcFUwU2g3RjhR?=
 =?utf-8?B?dy9aNHBwUHpOZFF0MHd1VDc3RDZHR3JTTlNGa3Mrc0NBSmNEMDVHWlArWGRx?=
 =?utf-8?B?dUJoUnFEcHlkNGZSTzRkVzNJV1ZzcitWN2JjWUUzeGpicGxpRi92T2ZVTXd0?=
 =?utf-8?Q?6TboF3PPXm8olHyzlu?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9360.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d834ab5-b12e-4c4d-9129-08df081506d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2026 10:37:31.1656 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8jBqtGp/2B7UHFnY1iQc8BqaVei+J0MdDLGN3gIamJcdm621pUBbLDzOlaSU368moKw56yHA415ghc9INf5/IA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8058
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

QU1EIEdlbmVyYWwNCg0KSGkgU2ltb24sDQoNCk9uIDIwMjYtMDgtMjVUMTQ6NDQ6MjEsIERlc2Fw
b2d1IEpheWFyYW11ZHUgPGpheWFyYW11ZHUuZGVzYXBvZ3VAYW1kLmNvbT4gd3JvdGU6DQo+IHg4
NjogY3B1OiB4ODZfNjQ6IERldGVjdCBDUFUgdmVuZG9yIGFuZCBkZXZpY2UgSUQgdXNpbmcgY3B1
aWQNCj4NCj4gV2hlbiBVLUJvb3QgaXMgY29uZmlndXJlZCBhcyBhIGNvcmVib290IHBheWxvYWQg
b24geDg2XzY0LCB0aGUgY3VycmVudA0KPiBjb2RlIGxlYXZlcyB0aGUgQ1BVIGlkZW50aXR5IGF0
IHRoZSBkZWZhdWx0IEludGVsIHZlbmRvciBhbmQgZGV2aWNlIElEDQo+IDB4MCwgZXZlbiBvbiBu
b24tSW50ZWwgcGxhdGZvcm1zLg0KPg0KPiBSZWFkIENQVUlEIGxlYWYgMCBhbmQgYnVpbGQgdGhl
IDEyLWJ5dGUgdmVuZG9yIHN0cmluZyBmcm9tIEVCWDpFRFg6RUNYDQo+IHRvIGlkZW50aWZ5IHRo
ZSBDUFUgdmVuZG9yIGF0IHJ1bnRpbWUuIFNldCBnZC0+YXJjaC54ODZfdmVuZG9yIHRvDQo+IElu
dGVsL0FNRCB3aGVuIG1hdGNoZWQsIHdpdGggZmFsbGJhY2sgdG8gWDg2X1ZFTkRPUl9BTlkgZm9y
IHVua25vd24NCj4gdmVuZG9ycy4gQWxzbyBzdG9yZSBjcHVpZF9lYXgoMSkgaW4gZ2QtPmFyY2gu
eDg2X2RldmljZSBzbyBsYXRlciB4ODYNCj4gY29kZSBjYW4gdXNlIHRoZSBkZXRlY3RlZCBDUFUg
aWRlbnRpdHkuDQo+DQo+IFRoaXMgYXZvaWRzIHJlbHlpbmcgb24gYSBmaXhlZCB2ZW5kb3IgdmFs
dWUgYW5kIGtlZXBzIHZlbmRvci1zZW5zaXRpdmUNCj4gcGF0aHMgKGUuZy4gVFNDIGNhbGlicmF0
aW9uKSBhbGlnbmVkIHdpdGggdGhlIGFjdHVhbCBDUFUuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IERl
c2Fwb2d1IEpheWFyYW11ZHUgPGpheWFyYW11ZHUuZGVzYXBvZ3VAYW1kLmNvbT4NCj4NCj4gYXJj
aC94ODYvY3B1L01ha2VmaWxlICAgICAgICAgICAgIHwgIDEgKw0KPiAgYXJjaC94ODYvY3B1L2kz
ODYvY3B1LmMgICAgICAgICAgIHwgNTEgKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0NCj4gIGFyY2gveDg2L2NwdS92ZW5kb3IuYyAgICAgICAgICAgICB8IDUyICsrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiAgYXJjaC94ODYvY3B1L3g4Nl82NC9j
cHUuYyAgICAgICAgIHwgMjAgKysrKysrKysrKysrLS0tDQo+ICBhcmNoL3g4Ni9pbmNsdWRlL2Fz
bS91LWJvb3QteDg2LmggfCAxNiArKysrKysrKysrKysNCj4gIDUgZmlsZXMgY2hhbmdlZCwgODgg
aW5zZXJ0aW9ucygrKSwgNTIgZGVsZXRpb25zKC0pDQoNCj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2
L2NwdS92ZW5kb3IuYyBiL2FyY2gveDg2L2NwdS92ZW5kb3IuYyBAQCAtMCwwDQo+ICsxLDUyIEBA
DQo+ICtpbnQgeDg2X3ZlbmRvcl9uYW1lX3RvX2lkKGNvbnN0IGNoYXIgKm5hbWUpIHsNCj4gKyAg
ICAgaW50IGk7DQo+ICsNCj4gKyAgICAgZm9yIChpID0gMDsgaSA8IEFSUkFZX1NJWkUoeDg2X3Zl
bmRvcnMpIC8gc2l6ZW9mKHg4Nl92ZW5kb3JzWzBdKTsgaSsrKSB7DQo+ICsgICAgICAgICAgICAg
aWYgKCFtZW1jbXAobmFtZSwgeDg2X3ZlbmRvcnNbaV0ubmFtZSwgMTIpKQ0KPiArICAgICAgICAg
ICAgICAgICAgICAgcmV0dXJuIHg4Nl92ZW5kb3JzW2ldLnZlbmRvcjsNCj4gKyAgICAgfQ0KPiAr
DQo+ICsgICAgIHJldHVybiBYODZfVkVORE9SX0FOWTsNCj4gK30NCg0KIEFSUkFZX1NJWkUoKSBh
bHJlYWR5IGV4cGFuZHMgdG8gc2l6ZW9mKGFycikgLyBzaXplb2YoYXJyWzBdKSwgc28gZGl2aWRp
bmcgYWdhaW4gZ2l2ZXMgMTEgLyAxNiA9PSAwIGFuZCB0aGUgbG9vcCBuZXZlciBydW5zIC0gZXZl
cnkgY2FsbGVyIGdldHMgWDg2X1ZFTkRPUl9BTlkgYmFjaywgaW5jbHVkaW5nIEdlbnVpbmVJbnRl
bCBhbmQgQXV0aGVudGljQU1ELiBQbGVhc2UgZHJvcCB0aGUgZXh0cmEgZGl2aXNpb24uDQoNCj4g
ZGlmZiAtLWdpdCBhL2FyY2gveDg2L2NwdS92ZW5kb3IuYyBiL2FyY2gveDg2L2NwdS92ZW5kb3Iu
YyBAQCAtMCwwDQo+ICsxLDUyIEBADQo+ICsgICAgIHJldHVybiBYODZfVkVORE9SX0FOWTsNCj4g
K30NCg0KaWRlbnRpZnlfY3B1KCkgaW4gaTM4Ni9jcHUuYyB1c2VzIFg4Nl9WRU5ET1JfVU5LTk9X
TiBhcyBpdHMgZmFsbGJhY2ssIGFuZCBmb2xkaW5nIHRoYXQgY2FsbCBzaXRlIGludG8gdGhpcyBo
ZWxwZXIgc2lsZW50bHkgY2hhbmdlcyBpdCB0byBYODZfVkVORE9SX0FOWS4gUGxlYXNlIGhhdmUg
dGhlIGhlbHBlciByZXR1cm4gWDg2X1ZFTkRPUl9VTktOT1dOIGFuZCBsZXQgdGhlIHg4Nl82NCBj
YWxsZXIgc3Vic3RpdHV0ZSBYODZfVkVORE9SX0FOWSBpdHNlbGYgaWYgaXQgd2FudHMgdGhhdC4N
Cg0KPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYvY3B1L3g4Nl82NC9jcHUuYyBiL2FyY2gveDg2L2Nw
dS94ODZfNjQvY3B1LmMgQEANCj4gLTQ4LDExICs0OSwyMyBAQCBzdGF0aWMgdm9pZCBzZXR1cF9z
c2VfZmVhdHVyZXModm9pZCkNCj4gKyAgICAgaWYgKGNwdWlkX2xldmVsID49IDB4MDAwMDAwMDEp
DQo+ICsgICAgICAgICAgICAgZ2QtPmFyY2gueDg2X2RldmljZSA9IGNwdWlkX2VheCgweDAwMDAw
MDAxKTsNCj4gKyAgICAgZWxzZQ0KPiArICAgICAgICAgICAgIGdkLT5hcmNoLng4Nl9kZXZpY2Ug
PSAweDAwMDAwNDAwMDsNCg0KV2hlcmUgZG9lcyAweDAwMDAwNDAwMCBjb21lIGZyb20/IEl0IG5v
dCBsb29rIGxpa2UgYW55IGVuY29kZWQgZmFtaWx5L21vZGVsIHZhbHVlIEkgcmVjb2duaXNlIC0g
aWRlbnRpZnlfY3B1KCkgaW4gaTM4Ni9jcHUuYyBqdXN0IHNldHMgYy0+eDg2ID0gNCBpbiB0aGUg
ZXF1aXZhbGVudCBwYXRoLiBQbGVhc2UgZWl0aGVyIHVzZSBhIG5hbWVkIGNvbnN0YW50IHdpdGgg
YSBjb21tZW50IGV4cGxhaW5pbmcgdGhlIGVuY29kaW5nLCBvciBkcm9wIHRoZSBlbHNlIGJyYW5j
aCAobGVhdmluZyB4ODZfZGV2aWNlIGF0IDAgaXMgbm8gd29yc2UgdGhhbiBhIGJvZ3VzIHZhbHVl
KS4NCg0KSSBoYXZlIGFkZHJlc3NlZCBhbGwgeW91ciBjb21tZW50cyBpbiB2NCBwYXRjaCAoaHR0
cHM6Ly9wYXRjaHdvcmsub3psYWJzLm9yZy9wcm9qZWN0L3Vib290L3BhdGNoLzIwMjYwODI2MTEz
NTE1LjEzNzI5OS0xLWpheWFyYW11ZHUuZGVzYXBvZ3VAYW1kLmNvbS8pLiBUaGFua3MgZm9yIHRo
ZSByZXZpZXcuDQoNClJlZ2FyZHMsDQpKYXlhcmFtDQo=
