Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBE1ACAC599
	for <u-boot@archiver.kernel.org>; Tue, 16 Sep 2025 11:49:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3B9F80325;
	Tue, 16 Sep 2025 13:49:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=br-automation.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=br-automation.com header.i=@br-automation.com header.b="hOIUSOMX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5DD5683071; Tue, 16 Sep 2025 13:49:10 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F0DF8004F
 for <u-boot@lists.denx.de>; Tue, 16 Sep 2025 13:49:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=br-automation.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=wolfgang.wallner@br-automation.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=is50qFY8iAfxMWVRDnJ+bXdbOos0ASpC4I+A0B+IRwQpezMnqDMQB7pvnSEOxd81t+PdyLvOfjjVSsCWQoDPetKNAlUSbzzz/nlzvnKksO3DFDDrb/Py75Q8oYLD+yJ+L9ihmEz8lT+DH9KwXkw/l+4Zden/dNtRAaPtvd4lBUpItCSL4ZIyYyZxJ8E4megmLsoTFEw1QTKMyg8HhDQYicSNXj1kh2WpBDJLp2iaUyfQ0PCjM84Ch6ykKpaE2kj1fh3fjecdnn9khQcVUoGb77UISAmJa8qJtSOIx10pDYQkGauPBNkVoPDr0cDC4/CUvHtluzCNFbYwt7I+vA5RKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dHkHAe5N95VSMwEwx5tjy/lrwAnhvd0X4p4hY3e5rSc=;
 b=EalwfYStpiGtmfBCUNTxN9Y8DYOpU7XLJh5e5r1KurjomvdX4tgRor2tVRrbHl0ech/olnucm7R+y3CJQMlhlPZZEjl0uBL7BsNtP3WsZLKgc2RjakGV8YcWTGbMisQF9CID5JYZ1+yy/x0vRaRmMh5iB0DPaWUHhJjKwPHzZZLj3m/NddrK9kPBzIhhlfL9AWO5jP21pfy6MOBJGP+Vm7Gphf4oLoy+8IUq6HKGzu1DD1vj+4LZxUS9aRCe8WCdCCvQl4w1Lqt3ZQ88ro48lfssGYAalN7p95jgThRnbnEK7/cmF4TTb+RBJtEgkvY44z1K2vANwvngKr+ChYhAJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=br-automation.com; dmarc=pass action=none
 header.from=br-automation.com; dkim=pass header.d=br-automation.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=br-automation.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dHkHAe5N95VSMwEwx5tjy/lrwAnhvd0X4p4hY3e5rSc=;
 b=hOIUSOMXTzVvn3k792eVVxc8P2/eXh7h0AjkXlSDEtZ+YczfkzlvSC1tevWcSlNP1ktpFNIaHu8a/myU6iZeFDjN2GaUBPYw/Lw1VRpO6A8x7o/kyWDuIxv3jfrhBiaZ9qr69qKjRGbL1s0svBuLd0Lo8FjBBGQWol/mGPcD4jY6/sLhBvwUktotgzO+SIBjqoEH6Am82N9b6uSjKTwvymgR8pQFUFZain0f24dt+pofYp93Cei7oyo/AU5JE7PKbrm38c/uHvMwNJ0y/SVcU6GuudXHTfbpIeWJm2KkcnyatgaEUdrPHdemsXN7rWbIxOS9ynmzE8woH/oW8m6VNQ==
Received: from DB9PR06MB8512.eurprd06.prod.outlook.com (2603:10a6:10:36c::17)
 by AS5PR06MB8920.eurprd06.prod.outlook.com (2603:10a6:20b:653::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Tue, 16 Sep
 2025 11:49:06 +0000
Received: from DB9PR06MB8512.eurprd06.prod.outlook.com
 ([fe80::5f8:554f:fee1:6cd5]) by DB9PR06MB8512.eurprd06.prod.outlook.com
 ([fe80::5f8:554f:fee1:6cd5%6]) with mapi id 15.20.9115.020; Tue, 16 Sep 2025
 11:49:06 +0000
From: Wolfgang Wallner <wolfgang.wallner@br-automation.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Dave Purdy
 <david.c.purdy@gmail.com>, Ion Agorria <ion@agorria.com>, Jason Cooper
 <u-boot@lakedaemon.net>, =?utf-8?B?Sm9uYXMgU2Nod8O2YmVs?=
 <jonasschwoebel@yahoo.de>, Luka Perkov <luka@openwrt.org>, Luka Perkov
 <luka.perkov@sartura.hr>, Michael Walle <michael@walle.cc>, Peter Geis
 <pgwipeout@gmail.com>, Phil Sutter <phil@nwl.cc>, Stefan Roese <sr@denx.de>,
 Stephan Gerhold <stephan@gerhold.net>, Tony Dinh <mibodhi@gmail.com>, Walter
 Schweizer <swwa@users.sourceforge.net>
Subject: RE: Continued need for ATAGS-based booting?
Thread-Topic: Continued need for ATAGS-based booting?
Thread-Index: AQHcJoC35RgHhCjTPEyn5bG6YZwCDrSVhTkAgAAs6mA=
Date: Tue, 16 Sep 2025 11:49:06 +0000
Message-ID: <DB9PR06MB85127E0FB3A0BF108EEAF0D4CB14A@DB9PR06MB8512.eurprd06.prod.outlook.com>
References: <20250915203827.GN124814@bill-the-cat>
 <CAPVz0n2tpEVrZ=1k9BPyg8h3Fa_P_J8VKoQFn0MZU0rOwVbstg@mail.gmail.com>
In-Reply-To: <CAPVz0n2tpEVrZ=1k9BPyg8h3Fa_P_J8VKoQFn0MZU0rOwVbstg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d792d246-d363-40e2-82bc-6f0655128b68_ActionId=97eac744-67ff-4969-adf5-5240940c2cb4;
 MSIP_Label_d792d246-d363-40e2-82bc-6f0655128b68_ContentBits=0;
 MSIP_Label_d792d246-d363-40e2-82bc-6f0655128b68_Enabled=true;
 MSIP_Label_d792d246-d363-40e2-82bc-6f0655128b68_Method=Standard;
 MSIP_Label_d792d246-d363-40e2-82bc-6f0655128b68_Name=d792d246-d363-40e2-82bc-6f0655128b68;
 MSIP_Label_d792d246-d363-40e2-82bc-6f0655128b68_SetDate=2025-09-16T11:46:43Z;
 MSIP_Label_d792d246-d363-40e2-82bc-6f0655128b68_SiteId=372ee9e0-9ce0-4033-a64a-c07073a91ecd;
 MSIP_Label_d792d246-d363-40e2-82bc-6f0655128b68_Tag=10, 3, 0, 1;
x-processedbytemplafy: true
x-templafyemailsigvstoversion: 9.22.0.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=br-automation.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR06MB8512:EE_|AS5PR06MB8920:EE_
x-ms-office365-filtering-correlation-id: 99ed73d3-4baf-4b01-8ee5-08ddf5170a58
x-abb-o365-outbound: ABBOUTBOUND1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?a3FDMG4rcVdYTFROWWNkK3hPazVIY2ptc1J4dmdOQ0ZoMng5NDIyVlpnQW9t?=
 =?utf-8?B?SW45U3FKQTFvclE4N2lWWmV1NUxhbjd4ZTI0MGRrdUdJUFdHV3U5RHpRUnps?=
 =?utf-8?B?RWhJV0Y5Yk1jb3hjQmtVbWQrdVVqcTJwRDNTUm9IakFYK2I0N0FkcUVXZEo2?=
 =?utf-8?B?bW1WSmcvNndGRTVXdk1lUzc1R2ZNNGxMYnY2MVdwNDRGWi9PQ2hNL0JkYXl5?=
 =?utf-8?B?a3BXQkZLNU1CRk9RaVFhQWFwdzI4bE5HWE84OEcybVVnVy81djQ3ODdOaThK?=
 =?utf-8?B?TndBNEhwR2VRRDAxUlgrdnFrTWZ2ME1STzJnV0pBNXVhd1hwaFBjNnB0RlA1?=
 =?utf-8?B?TGdJNFp0eTZZY2U1K3NsVXhzT093RTc4SG9MZ3EyOXpRNVRUYUFSdUpGNTBu?=
 =?utf-8?B?Q1BvUURMVDRmQW4ybEJEQVhrS1RvQjJHOG93WXk2T1gwMUVlcTRabUMwMUta?=
 =?utf-8?B?T3RVMzJkUVdmT2ZmQksxQ1VzR1VLWHErY1JSL09UQk9teVZEc3dFN29HVWRP?=
 =?utf-8?B?djlZZnJYbUFyZFhEVkN5azh1TjY4c0N2RUF4T0VQdHNGS2Y2YmIvNUJ5SXl3?=
 =?utf-8?B?UHpuT3gwZUtlK1hhZm1sTkoraStncmo1UWkzL2FYRUp1NVlPeVk4Rk1vUnZJ?=
 =?utf-8?B?L24zM2xnZUZESVdZazdnZUU0dmxMM0FRbXBkdk81UWVXK3B3Zko2bzVUQlcr?=
 =?utf-8?B?MTdYY1IzcjlzWnJibmJyUytGcDBEZlU4bjNhS25EVE1xQVlFUlpUbmFvMzFC?=
 =?utf-8?B?OGxJYnBsVktVMkFTRWFtQjhkSjdIbzFuTkdNM1Q3ZlRSeTU5NGUya1ROTEMy?=
 =?utf-8?B?SmJUN0VacVVYeUpONUdxY1V6aUVvYkFRY3hEWVNoMXFNc2ZOZ2RRQzduS3E0?=
 =?utf-8?B?K0htYU5ieDYxL01MYTBwTmhvUytTMzE4aVE1V3pwZWpVN09PaUlLSWZHMW9T?=
 =?utf-8?B?Q2JpdEFKR3lFQkI3U1psZmJZejFCdWN3WHJ6Y0tZMlppL0wyZGNVcG9OenFL?=
 =?utf-8?B?R3paTklCemVGQ0xwcUZLanhiSGhrdXJtWG1oeGNzaDExeFpTdk1Nb3UxTzN0?=
 =?utf-8?B?SmR2cnpnNHNGY1ViemMrYUVZUTd3dE4rZE1td1RUdkV0U0ZJSklNVzBSMGFU?=
 =?utf-8?B?bjE1SEdJdmEzRjFOK3BWdlRIWHpLREM1K1pSQ2U5Smhvd05uelRIZE9TUXFF?=
 =?utf-8?B?SjJEa2VQZ201VjBoNGc0MkZTUVducEozeGtFbzk2NmpFZ090QWk4a2IrTkdW?=
 =?utf-8?B?aTZGR0d1Y1dPQWVsREFEVDVXK1krNFFvd0piNWVNV1A2TFN6SzhPZ3JQeFk4?=
 =?utf-8?B?TVFlanZwODZZbWdaVzMyanBpejIwNDdwUTU5TDJzR0pwcDFLNjc3UGhad3hh?=
 =?utf-8?B?Rk1XYkg5MXcySEJPeC9DeEd2S1orVHZWVDhFK1hsNHNtQ1hIeXYybk5maUpF?=
 =?utf-8?B?S2ZSbm9IakVPOExqajlCdHRPM2FNZDlQSDF5VGVjQVNxV25hY2RzRWFkRDhG?=
 =?utf-8?B?YVZtckFZVGdtaU02VFZjd1JmL1JXd1RJSFVvcWg3a1lyenp0cGhpQ1JNRTA4?=
 =?utf-8?B?QWFoRW9wNnFNRjNFa0wzQ0JGMTZCd0xUUExScW9lUXlUWURMbStTVEw4dyt1?=
 =?utf-8?B?eGpOMW5tdnBnU3RscHZzTU5sd2ZsSHRlenluY0JodUk0eDZWd0VpNnE3ei9F?=
 =?utf-8?B?ckp1eWJidHpVbDgzb0RxTG5UeUFwUmlHcDA1UlA3ZWRobWhkQ05sSnpnUFMv?=
 =?utf-8?B?L0tQcldFSEFZaUdFZU03bFZEYjg3RnpVMDBwU3dkajdiU2hYbGd6Y2RzT0tP?=
 =?utf-8?B?cDNBU1dWQ2dqcmErenY0dmNUMHh0UmhGL0xoKzU5WjhVSmlwd2cwQVZ3bzg4?=
 =?utf-8?B?NWRKcFU0WUpXNkJiZ3RhdzY5cGNyMjU2ejc2U3kzaUpSTGoycWI5KytQWUFO?=
 =?utf-8?B?SkdESC9ZTlk5RG93REQ4S2taN2dMMkFVUjFKb21STTA2Mk5QOHAzdjB4WXZP?=
 =?utf-8?B?aXNDVjRZa25RPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR06MB8512.eurprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aTdzbEZMQWxjK2tRakRsZ3paNWpWanp1MURhRFM1S25raWFVT2RubUdaV0o3?=
 =?utf-8?B?cVNoNnl6d3Z0dTB6NTlKSVhtdDdnZGx3T2w1cXhwUnpmSnVidmRXaHJHS1Qy?=
 =?utf-8?B?clRmTi9SYlBkaEtDVGhNQlJkV0lRbENNSFZzYXdZeDhxQ0Z2dXhGcmR1RHJL?=
 =?utf-8?B?Qld3OVNXWUZxbFdUMmxkYW5ubFdVNkg3ZVRpWXFhY1pJMlYyUE9oQW5nbEpp?=
 =?utf-8?B?bi9DallHNEhTb0pWeVlRcGFCenF1ZG1CUGxnc1hqV1YzdlJUR3BTQTNoQSsz?=
 =?utf-8?B?YW5yQk5LTWFnSGw5MTlyWWVJaHV1V3pXbEdYMlZKUW5kcG9RTWdPdjVBYkFp?=
 =?utf-8?B?WGNjaW5JZTU4MVIvR21OU2hTazdGcTRhK2V3L0ZwcmpGdFlJNTBWamhMVEJE?=
 =?utf-8?B?UmxSTjB1c3VrTjdVTzNtNXYweDhOaTR5N0VocHc4a1lYajdMQzlScmdsUm5S?=
 =?utf-8?B?RVNiUzN0c3hBUnFBWlg2bit3Rk01K1Nyc09UckJkaHNqdU9NdnhDM0JkSHd0?=
 =?utf-8?B?L2M4T2Ivd3F5YUJFNGRnblpYM1BMWnVpNnMydEhxZjVDVEQ1cmlUbG1KU0JI?=
 =?utf-8?B?Q0x4dUplcjcrVjFsZVRuQlNpRHNlZGdvK1VPMHB2L0swUlFQTDhDbWJJdVhu?=
 =?utf-8?B?MHgzakRaYVBIUnl1SmpPWHpNNTh6ZXc0dEx5eHByMUlETlpCSWxabEtKTjVh?=
 =?utf-8?B?QkxLYThudjA5V2UramY4aEcxczg0QTVNbWJMMzN3Wk1CMmJmNGkvd2pzb1Bl?=
 =?utf-8?B?TlYvNDNxRVA0MWtoeE1oZUR5a2Y0SHRnRXlNRHdKZkJJaEF5cDJYZWNWTVhU?=
 =?utf-8?B?dlNESUt5bCsvMzIvODhpa1Q0TGtpNm9VYWFRRFl1WS83TzQ5MHBHSkIvL2Zx?=
 =?utf-8?B?TElMZEtuUVlXdEtZYnRVUjF1dVRxaXNROVg1TjNrM2poSFR6YThENmJkY1FV?=
 =?utf-8?B?K242eEVQcmhadW1FdGY0QStjem82NEs1Z2M5UFBaQ3dJeU9nNVZMMzZ4KzVo?=
 =?utf-8?B?ZkZ0MHpSc2hrdEVmYmpENkdCZFA1Qk04RTVWdnJkUkcyNzlTMWZnd015TlRV?=
 =?utf-8?B?NlE2S2JSbE41OEk1TG1YWGhoVFZSemYrS3UzMWIwNWNJbWoyeTJmUnhsREF3?=
 =?utf-8?B?Uy9EM21FN0FOUmk3UnJoR1RScXFDVHR2QzhEQXE4UE1aZTJxMDI0ZG5uUzVZ?=
 =?utf-8?B?TDdvWUlCS0Y5TDRNQTRVYmZrREJjMXFlRGpvcnJOYnlzajNWY0lRQmFTN0ZP?=
 =?utf-8?B?bDRPVExwMDFlQmNYbUJvcTJ6c2xhN0o5K2dmcFByTmRmdm95bFErZm1maVQ0?=
 =?utf-8?B?bGc2eEhtdk9zRENTVTNRZTBFSGlJaExoSGx0YmlVZ09KUmEvbmxpQy9yVk5L?=
 =?utf-8?B?VVh0RWd1VjUrdVdHYi9pOCtNTU5aTDVmYzVab0VZekQxOHhGMVNTSEhBNXBD?=
 =?utf-8?B?K1hQdDBEWlZRVXBLbzRTSThiMzB3ZlZsOTcvY1ZtZlRhOTVlME01TzA0YXcw?=
 =?utf-8?B?OS94Yk1oWFJ1RGpOZmplUkdaM0ZkWk0wM2ZaaUc4L3J6ZE1WSXc1TXFxQXFW?=
 =?utf-8?B?UytkUFZkUHdDTmMzTklBeThDS2RldjF5VmltQU9qNmJ0MDBjeVdrRHgrS2ZS?=
 =?utf-8?B?T3BxcjQ0RllIZndZUjhCWkY4RldsQ25RamdOREhNbFRtN00zLzRQTExkdHp4?=
 =?utf-8?B?MWtHTkZOZEtUejZzN0o4cnNtZUVxK0ZBcDdrWS9KU3dpZ2ludERUM1FGOXlv?=
 =?utf-8?B?SVBTdW9uaXlqdVFTTDAzdkM1UlJOSWl1NlR6N1hFQ2RWSkxjamJ6WjNOaEo3?=
 =?utf-8?B?bUVSOXY1ekFGR21OU2FwUFZISC8zUnFEWkE4dU04YU9XYXlUbHZzT1laR0VW?=
 =?utf-8?B?bHZYVzlZSElCT0VmdndmbXVPcGdTSDNheDl0cmpBUHBGRXJyNWZxVjRPeTRR?=
 =?utf-8?B?VUhOQWlJclk2Sk0xRzJsUHh3Q2pUNldmdHUzNzFCQUFIYmhIMlVwY1orOFlv?=
 =?utf-8?B?dE5SaDdacEJvQ0FjWEh6MGpHSE1EcUZYNk5SdVhXajlTZ1Bua1RuVnVBOC85?=
 =?utf-8?B?dWlwcFJLVERVVmdhcEcwcUR3bDR4WWRRazZ1YnJpeEVWOWQ2aHpUVWVkenNC?=
 =?utf-8?B?RCtZVHhPckY1U1JaNktQQnlraEVnamV2cTVTakJ3WnovelFFcS9vUzFreXhB?=
 =?utf-8?B?eEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: br-automation.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR06MB8512.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99ed73d3-4baf-4b01-8ee5-08ddf5170a58
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2025 11:49:06.2897 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 372ee9e0-9ce0-4033-a64a-c07073a91ecd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CX/+1WhA/b92mgGGw5UQKjLhU2RySGSnc61THx683dw2I4mqbQI6mMzGbGgPaL+CNJbWzMpwbxnLo0O874UM5ilb55ZklWWioWM8e781LY4xQqFWOEwxPcVQheLXrIfU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR06MB8920
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

DQoNCj4g0L/QvSwgMTUg0LLQtdGALiAyMDI14oCv0YAuINC+IDIzOjM4IFRvbSBSaW5pIDx0cmlu
aUBrb25zdWxrby5jb20+INC/0LjRiNC1Og0KPiA+DQo+ID4gQXMgcGFydCBvZiB3b3JraW5nIG9u
IGNsZWFuaW5nIHVwIGRvY3VtZW50YXRpb24sIEkgZW5kZWQgdXAgc2VlaW5nIA0KPiA+IGp1c3Qg
aG93IGZldyBib2FyZHMgc3RpbGwgZW5hYmxlIHN1cHBvcnQgZm9yIEFUQUdTLWJhc2VkIE9TIGJv
b3RpbmcuIA0KPiA+IEluIGZhY3QsIHRoZSBsaXN0IGlzOg0KPiA+IGJyY3AxNTAgYnJjcDE3MCBi
cmNwMV8xciBicmNwMV8xcl9zd2l0Y2ggYnJjcDFfMnIgYnJzbWFyYzIgY2hhZ2FsbCANCj4gPiBk
b2Nrc3RhciBkcmVhbXBsdWcgZHMxMDkgZHMxMTYgZHM0MTQgZW5kZWF2b3J1IGdvZmxleGhvbWUg
Z3JvdXBlciANCj4gPiBpY25vdmEtYTIwLXN3YWMgaWNvbm5lY3QgaWRlYXBhZC15b2dhLTExIGxz
Y2hsdjIgbHN4aGwgbW9jaGEgbW90IG4xDQo+ID4gbjIzNTAgbnNhMzEwcyBuc2EzMjUgb3BlbnJk
X2Jhc2Ugb3BlbnJkX2NsaWVudCBvcGVucmRfdWx0aW1hdGUgb3V5YSANCj4gPiBwaWNhc3NvIHBv
Z29fZTAyIHBvZ29fdjQgcWM3NTAgc2hlZXZhcGx1ZyBzdGFyIHN0ZW1teSBzdXJmYWNlLTIgDQo+
ID4gc3VyZmFjZS1ydCB0ZWdyYXRhYiB0ZjcwMXQgdHJhbnNmb3JtZXJfdDIwIHRyYW5zZm9ybWVy
X3QzMCB4M190MzANCj4gPg0KPiA+IEFuZCBteSBxdWVzdGlvbiBpcywgZm9yIHlvdSBib2FyZCBt
YWludGFpbmVycywgZG8geW91IHN0aWxsIG5lZWQgdG8gDQo+ID4gYWN0aXZlbHkgc3VwcG9ydCBi
b290aW5nIHN1Y2ggb2xkIExpbnV4IGtlcm5lbHM/IE9yIGNhbiB3ZSBkaXNhYmxlIA0KPiA+IHRo
aXMgc3VwcG9ydCBhbmQgdGhlbiBwb3NzaWJseSBiZSBhYmxlIHRvIHJlbW92ZSB0aGUgdW5kZXJs
eWluZyBjb2RlIGFzIHdlbGwuDQo+ID4gVGhhbmtzIQ0KPiA+DQo+ID4gLS0NCj4gPiBUb20NCj4N
Cj4gSGVsbG8gVG9tIQ0KPg0KPiBNYWludGFpbmVycyBvZiBzb21lIGJvYXJkcyBpbiBpbnRlcmVz
dCBoYXZlIGFncmVlZCB0aGF0IHN1cHBvcnQgZm9yIEFUQUdTLWJhc2VkIE9TIGJvb3RpbmcgY2Fu
L3Nob3VsZCBiZSByZW1vdmVkIGZyb20gdGhlIGJvYXJkcyBpbiB0aGUgZm9sbG93aW5nIGxpc3Q6
DQo+IGNoYWdhbGwgZW5kZWF2b3J1IGdyb3VwZXIgaWRlYXBhZC15b2dhLTExIG1vY2hhIG1vdCBu
MSBvdXlhIHBpY2Fzc28NCj4gcWM3NTAgc3RhciBzdXJmYWNlLTIgc3VyZmFjZS1ydCB0ZWdyYXRh
YiB0ZjcwMXQgdHJhbnNmb3JtZXJfdDIwDQo+IHRyYW5zZm9ybWVyX3QzMCB4M190MzANCg0KDQpX
ZSBjYW4gYWxzbyByZW1vdmUgaXQgZm9yOg0KYnJjcDE1MA0KYnJjcDE3MA0KYnJjcDFfMXINCmJy
Y3AxXzFyX3N3aXRjaA0KYnJjcDFfMnIgYnJzbWFyYzINCg0KSSBjYW4gZm9sbG93IHVwIHdpdGgg
YSBwYXRjaCBzZXJpZXMuDQoNClJlZ2FyZHMsIFdvbGZnYW5nDQo=
