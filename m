Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D7B6D1625B
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 13:03:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32C2488F64;
	Mon, 14 Oct 2024 15:03:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sony.com header.i=@sony.com header.b="msdrxh7Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3046988F1E; Mon, 14 Oct 2024 08:24:00 +0200 (CEST)
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com
 [185.132.183.11])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B6EA888B2
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 08:23:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=JianfengA.Zhu@sony.com
Received: from pps.filterd (m0209327.ppops.net [127.0.0.1])
 by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49E5j5Q1019932;
 Mon, 14 Oct 2024 06:23:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=S1; bh=2DViHFH
 BSQdR9Kp7QlFMebZ1q3uudqyAufDBu1NsDvA=; b=msdrxh7ZdZe0sxNRaujwuEe
 9wYBpr07l72I2rlvn2fs5bnxepQ/Hix+LQ3tpsvNO96FnXGtVWnsExIo9CXaCM1e
 ehcuAojXF6bMgXfXdPuvE6dFHggPfuFLBCsfLQQpfQNPJh1OSP3zdfUCcVOSdgvW
 pEcQyBnoJmYEA3Ax4DLcdcMRae0p2ZjdCijEZhpHmuXSKj0I2i/MmTb0JwdpHdui
 FKPXOwIVy+oynqLjOYiqlHhCDe3xpQenzVYWlr2Dx3t+ZXEeA4KEpE9rR6imC//n
 rOkjQrJ2cbi/x3Ynq1G05M61EzJOl1ji84N3HbI7QlZ8MQRfYGIhg7rbvxi1VnA=
 =
Received: from apc01-sg2-obe.outbound.protection.outlook.com
 (mail-sgaapc01lp2111.outbound.protection.outlook.com [104.47.26.111])
 by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 427fyxscxa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Oct 2024 06:23:36 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jHh3MSaU3Lzd1Om1Dkn7GqRo9xI5x0hXBw7OnRa4pg3o7GoEOzQ4RBFmTKviwgmCoSGfVFV8hy89cQlk7IEVOfHLFqBHiP/UnGe/lXUunDmrIWKjqhqPqOWUmM0AG+9anm5rW1aWS7h/7F0IoVUnLVUNzO+qegA7uqoBT0AWOx9Qs+wu/BlB6kn3gxSDCQyVZE3un4Invre6GxZJ7CCCfnIB4dbubTNb8dp4eZuB2eBiRn5hj0dQ+RUv1UPszcbRjJM+h4SXvs5dgVeFf/UKdsEbjyQ0hsIyxhrCf/hQIx5nw/V83wGDnk3nhQzn2FOZXmRvTsHDQVVw+UcX2lI8XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2DViHFHBSQdR9Kp7QlFMebZ1q3uudqyAufDBu1NsDvA=;
 b=AA47UnzF8XgGo9BuvQo+yGSfLkWIqCz8BW8ho7xT8W07bdkCFyM8DUtzzxQ1ba6ewbEg+VYDRvnvh4ie++A2akYOaoS+9YeUvmgkr2Iun8ZiHCRARy0xXR2hLpbdxG0ZrEMlYaDScJOLBXyIXwi6ekjIHVnw8VdCxN/CBfQ1gJ7M4HKfCz62sym9EHmOvYGzC9rCOhTFER7D1ZOj8OwJ/JN3GP9ZqdLte9vv9gJo0MxY4cdloF+i5pr8+u3ktxtSAvmFDyWtu0g5DDAKYaZQRz8FCTO0sFdm7zTo9/wBaf8igphlpgmJJaRLa+41KwUi5oUWm3PeYnNLk5UBL0Xt5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from OSQPR04MB7740.apcprd04.prod.outlook.com (2603:1096:604:283::6)
 by SI6PR04MB8284.apcprd04.prod.outlook.com (2603:1096:4:231::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.25; Mon, 14 Oct
 2024 06:23:30 +0000
Received: from OSQPR04MB7740.apcprd04.prod.outlook.com
 ([fe80::7c06:41d9:f38c:e1bd]) by OSQPR04MB7740.apcprd04.prod.outlook.com
 ([fe80::7c06:41d9:f38c:e1bd%5]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 06:23:29 +0000
From: "JianfengA.Zhu@sony.com" <JianfengA.Zhu@sony.com>
To: Caleb Connolly <caleb.connolly@linaro.org>, Marek Vasut <marex@denx.de>,
 "neil.armstrong@linaro.org" <neil.armstrong@linaro.org>,
 "trini@konsulko.com" <trini@konsulko.com>
CC: "Jacky.Cao@sony.com" <Jacky.Cao@sony.com>, "u-boot-qcom@groups.io"
 <u-boot-qcom@groups.io>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: RE: usb: ehci: Fix db410c usb reset not working
Thread-Topic: usb: ehci: Fix db410c usb reset not working
Thread-Index: AQHa8doyfZyzV2yuBUCqkBKJjB90ZLIucCIAgAACHICAAP4l2YBWrD0g
Date: Mon, 14 Oct 2024 06:23:29 +0000
Message-ID: <OSQPR04MB7740E6E4AA1998EADB872E2890442@OSQPR04MB7740.apcprd04.prod.outlook.com>
References: <OSQPR04MB77401D18913B397B768EC042908C2@OSQPR04MB7740.apcprd04.prod.outlook.com>
 <6d338e52-2817-4612-8592-f67cbf942b48@denx.de>
 <4ca6cb11-f616-4842-b253-21a7ba8253d7@linaro.org>
 <OSQPR04MB7740CBE65155F2A6C0D7D6C0908D2@OSQPR04MB7740.apcprd04.prod.outlook.com>
In-Reply-To: <OSQPR04MB7740CBE65155F2A6C0D7D6C0908D2@OSQPR04MB7740.apcprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSQPR04MB7740:EE_|SI6PR04MB8284:EE_
x-ms-office365-filtering-correlation-id: 7bb43e20-074f-4c31-af8e-08dcec18b86b
x-proofpoint-id: d8690225-876f-412f-87c6-a7cb45557a4c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?eVNOUmJXOWRBRVRwOFVKT1lCTnUrb3JTQjFEaGlxSkRwQjVhN0hUSENWYUpV?=
 =?utf-8?B?TE8rZ2tpUmJ0U1FydmRtbkhreU0wVFlTKytMdDJPOXFnOEo2ekNFaFZiZjZU?=
 =?utf-8?B?V0hudzRVcHZlbjF6R3ZqeWg0UUhHeGpQRmtROXlHMG5NR1RyTjBrbzZGa2dU?=
 =?utf-8?B?cUJaaXdjQXgxdDM0KzV1eVZ4WHAzOUZ4S1dOM3hCUkNSSndmNVd0UmthOFdr?=
 =?utf-8?B?RnREZnBPNWdUVDJzQkVjT3grZVovVEhUZFVyZkl6TTg0RFRLbGFNY0JYL0Js?=
 =?utf-8?B?UnROSy9EMFpQdklzOHZLaXQyYko0emJmaW1EWHB6Yk8wUzlOeWpkUFdEOUVU?=
 =?utf-8?B?WmVXK2ZNL0VObm5zWVFpaVlhZmpEQTVmQ0JEdGpUTG4zMWhuNURteXpQT0VT?=
 =?utf-8?B?V0NOZTRNR2VITDAwdzVOL1JVb044bnd0VmRrOE9JNFpFWDhQVklNYjBNaTZX?=
 =?utf-8?B?Tm5VQndMd3I1U0JuNEFQUm8rMlF2RGNsQzh3c0ZCbzIrQTNIYkFra0VUejdU?=
 =?utf-8?B?QkprOGs3YWx1OWVKZ2tRQ3hEcjdXS2lBUXIxTXdsTElYM2dCZmRzZnI2eWdG?=
 =?utf-8?B?Sms3a2plM0Y5a3ZtcUJrUmtQY3VlT01kV0RhWmZiRFNqOHl6K3FmdVczeGl1?=
 =?utf-8?B?eC9hMzhpd3ZNUkdmbjNUcWJFOFZFTUNCTTBjSU10RXZzVHFzakIrNG94OHFM?=
 =?utf-8?B?ZERHOTF6bzUxQUlYVTdaZVJMSjExMkJWckdZRDI1NmQ4SVNBb0NreC9OMEpv?=
 =?utf-8?B?MUdERkZYZ2srVzVybUt1TFpzK0x1VmowTjloaWxLMTk0OUVXYkE1TXp3MjQy?=
 =?utf-8?B?R1ZGbE5XYzVkekJxTXdjSW1UcVZTV2d4TTdVQ21YUGtsMjdlWlpqR2IzZUJo?=
 =?utf-8?B?eTZOVjBIUWs5dE9PTlpuQzVzQldpU0pxSEZ1L0o1alpXczNZM3Q3cUZienRX?=
 =?utf-8?B?ZVVGL2FaWkZDZC9xdmRwcHBIQUpwRUIxSExnS0l2aXdtNVRDSFpyaE9mcDda?=
 =?utf-8?B?K0U5ZmpYTUJrZDZxUENHOXl6V2VGMjhTSW9peUxpK01Ic1BSTnlXQ2hKR1NO?=
 =?utf-8?B?K2liaHVLZkwzWWpKSVc4c085WVVWVTdIWTFVTWQ1QVY3d2d0cENmb09BRVhl?=
 =?utf-8?B?a1FscmtoZk9UOU93NktISnpWQWw5QnlYZ0pZYlF0eEFUc3lySWg3S0t3amQz?=
 =?utf-8?B?Zzg3MHBpcWhTS2hkVTQ1NERMeG9hU0IydEVrK2hwYTErTy9yckZXWG1lTlNU?=
 =?utf-8?B?WTF0M1lQd1lmdkNtVTNQWDNmL3E4WnpieE9WeW9MMlJzdGJHK3FmaEN0TU9w?=
 =?utf-8?B?d2ZsY3JNWlhMczQvMFozdHhhUUdlUG55QUVjSzR0Z2JGUGhvcXBJc21sK2pW?=
 =?utf-8?B?TjIzWnNLcUdteW9wWFBYN214QlBtMWFZdWVCby8vSU9GU25QL1huUzVHM3Mw?=
 =?utf-8?B?N09HLzdzTWF4N2VaYkpCc1VVdDgzanZRMFBTUlpIWUFsdmpkdytBWFBkSTNL?=
 =?utf-8?B?bXhYM0lEQnU0SmNEYk43Nzd4ODczSHNWM051UnFkc0JsVGl6dkFHOFB6cEkw?=
 =?utf-8?B?LzV3TmpZUkVDYm5ON1hBUFg3Z05MS21rV25SSENhcE4rV0hoaTB3OWpkZkVP?=
 =?utf-8?B?YlNKRlB6MWdubjBYL0N5TDBMV3hydExKU2JwMitGTFBZUll3Sm5rdVIxMDVT?=
 =?utf-8?B?bncwNk1FRVpyYm43cUZqcEpNYVVXdGlLUGNuc1E0QjNzQ0xBQWZHKzFORmwx?=
 =?utf-8?B?Tk5VRUtSZ2szZ3NkNkJGM2dyMUhvVXJNdVRzVDdqeG8vTk9EZjc0RnlwT1Fa?=
 =?utf-8?B?SXp6TzJkL1krbi9sb2wyUT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:OSQPR04MB7740.apcprd04.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L3Q2Sk51SFNmSG04Y3g4clBWYjNPS21XMFhPQkl6NHdJbnhlRmVKQjB5U3Jm?=
 =?utf-8?B?R2pYaCtDZG1QR2w1WFk4QXl3MkxpaVJkTWYwRWVYMFV2bDhiWmFlUXlhQlVk?=
 =?utf-8?B?cEd5UUZ4cE1JT1YwRG1KVnlPbk9DRllmQ05kWVAwR29NWjU1dlllSDE5NDZj?=
 =?utf-8?B?ekFsSS96dkFWdEdoVFlmZElRU0tzTWRQNUw1OGd1YnNNQkUvMlp5eG5IeXhR?=
 =?utf-8?B?QXZvOExmRG1pRzltelVWcklzU2ZRRVd3R25EdVdTNmkvQTJPTDRrak5YcEtK?=
 =?utf-8?B?bVZtdnBmMkZBUHdqWllBU2F5MC9GR3RZeHVjTUp4U3JKRGRmOXE2WkcvMWw0?=
 =?utf-8?B?VVFkSUp5QU5aNDRDUmtJeWFhZkJUZk5TSWQ0dVA3RzhuRlQxdkRHVHNoTnpN?=
 =?utf-8?B?U3FRbERVK2wyblZrTFY1TmhSVVkzS2ZETDdwcDV6U0tZa1BYTGdRTTNtV2pW?=
 =?utf-8?B?TW1pUlZpUVJIdGRTSmd3cGJoRmxYQVVRUXNrTFYvUmNhcTFXSUFEVGlEazBG?=
 =?utf-8?B?VDJIdnV4OXFYeWQ4Yyt2YVYvbHRvZGRGNkdFS25EWjhCTTJzUHJ0Q3B3Tita?=
 =?utf-8?B?ckEwWURiVHZKOHVIMmpEQmFPOEdyci9tTHVRc0JzMXRGOFBkQ2YzZkxlc2J0?=
 =?utf-8?B?ZE4zckM4dmltaU0zSnF1QzZ4WEVXUzdrcENHMFBMYXAyeGJ1bHNpd0Q5cXM5?=
 =?utf-8?B?TzFwK215dDBrVTVGSGJaNnhROFVwbFRMVlJiM2lNVENiaWJUaFR4L0ZmamRa?=
 =?utf-8?B?ekNWM2ZnQk5wZkhmVUZQMy9SMnM3ZVZycGtHSWhNUS9oUHJIYWhSaHNvM2NL?=
 =?utf-8?B?ZVJGK3R2UExhelpoYXp2QXR2dHhUQUNEYkcxcFZKcTNmWVB1T1VFdjJzNGV4?=
 =?utf-8?B?bnZ6a3o0U0FzUmxnRWQ0OHMvWjhGdjVRZWNLVDBQQnM3ZUM5NDFkV2VrWGR5?=
 =?utf-8?B?RVpBRFZGbWFrNC9BN2dmVE9Zem95MEN2dlJjbUl0UVgzSHltYWdxMDdEeUcy?=
 =?utf-8?B?K25FRkc4NU9DdmtiaWprd0ZkWGhyemc3aWxRS3NpdmZ0NE5VNTVzVWcva1hG?=
 =?utf-8?B?eFlEWTdPMmNrUEZXM2xaUTROdG1LQklrY0NaUjI3TDIxL2VVdXBFc0l5NmtR?=
 =?utf-8?B?WnRuTElWK1pSNW5tTlFyM0h4VW11eGFzMG50U3dRRkVXZlBxMUg4akFxRy9I?=
 =?utf-8?B?czh1NjIwckdlbVBaa21YdFFTaTJyNGcyaUcvMVJCZW93N3J6Nk5pWDE4NkRG?=
 =?utf-8?B?WmJDMVRXTE1JUGF3OHlSeFU1Sm8zcHRXYjVKTUJOSWhqK2lVQkNQUmNNRnpZ?=
 =?utf-8?B?dk1kcU1kUGZ5TmVncCtVSGREVUx0WVZqQkxwMEUvV0d0OWxVQjhIVkNWeHJ0?=
 =?utf-8?B?SVFIdGlmbEdqUE1UN1V4TjI3OTNTRWNQeldsYmR6UmgrZTl5QjdIRFAvSXdu?=
 =?utf-8?B?VTlpcmxhL1pBc0ZvY1FNME9ZNHJwWXQ5bUtENXFiUk1GcG90RmdCT1Jnd09G?=
 =?utf-8?B?K2ZKTkt5ZXlLS2FvRFBVRCs4Z2MzUG5hRjg0SDd2Q1E0L1RNb2I3OUJkcHcv?=
 =?utf-8?B?dHRZTzBJckNSNGVYZWorVGlwSDJpTHVKdGRSYlc5di8wcmkrZlJ2enBMcDMw?=
 =?utf-8?B?aDlQZVptUWd2SEVBM2t0K2lVY29oUEhSYzhJT09GWGIyMHRFNkFhNzB0R2ZL?=
 =?utf-8?B?YXkrTWYzT25Mak55Ti80NXZUdGowT0tWUExVRG9rQzc4cldyV01yZm8rY1pZ?=
 =?utf-8?B?YjlSTndzVTF5NDRzLzFpSXoyd1hLVjlYWkxEZ1NJdFhPTVFyQTZxN01TOVBv?=
 =?utf-8?B?RGdUMzFIelQrS1VTVnVxbXNyWU9DNHZ1cG0vQ3JINXdlVWNEQWxkMTZPaHZz?=
 =?utf-8?B?eCtUSE56RUhQWHZFeHpGbWdiQkpwcjA0YlRqS2JqYkVPak9ETmhhV292Ukhi?=
 =?utf-8?B?MjBIdnFFbVZJRHY2MFJMMHZnL1B3bmZjNVFhbnN5VWNqNHhKTVZSTnRmd0Jq?=
 =?utf-8?B?WW96VkNyazFTM08wTUNXVW9NL3hqUFI5V0J4UnB1SXk4MDU0V25DR0dGRUpW?=
 =?utf-8?B?L29QTVNSSVpFVmRxMTYrUVkyVEV2ZHZVcnFDVi9HTDhMUFFBaUJRbGlJVnA4?=
 =?utf-8?Q?FDyGM59Xt1O1uvp/2N84f9OFc?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: GmwDC5RQDeZVvUl5jNYoqlXAO8p3x3c8DMZCTpH98e+VPPoWxRSbXUApTYcvnb2oTL8xeqHzoOwE9hySrfKkbIwDQZ9cigckQKCdsAShQ4v3S9T5ylfKRqerIqrXByfp2MkbiygAZD3zTipIGY0YeKDkQgKOf4/P/lw/2YI0DuyCxdLBLFK5aq4tl4zNWAa43+DLsGm0OiLtNSCPejGVnSuPYuBexgMU7+VP9pGE7LxPwn6HgRN3hK0DzwiXrfM3hCNDfcZe84mWFIAnfkXx2kFf9qyHunO6CQerb3+kOY5/rbHGTZjl0QQ51hT4LA90bXK9utFMZQkXTtj7vMaIt/j+lS3SHcvuAD2n2FXuh9lZiWcRrHSYqBtSDtZ7ZmgmW6urIpcOZicD1AmoajIlRS6AE+/+QkGE+7f8OIh98Kh9E/BN1Hnnyws8XLRzCd4X5exqUING0kj89aljx2FprNlGler4TNaleat79CkiyBdgzrwoWqtiW4tvP0q+D1IF7ldjkuuZhNEaYeqckUuHhQqavamzId2frMFqUIncp2WI4CyxbuyHa5OZCYUgcJ3Zc8p3L/1Hnk3eEP9CVJua8jQqvLLwJqyAkpYo25cP5RfVVFL5KvhsZq9it1CxWdi1
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSQPR04MB7740.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bb43e20-074f-4c31-af8e-08dcec18b86b
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2024 06:23:29.7128 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UehW0w3xJFDenMZpD5B4ISKGmS7LMsl0stZv8wzyrvMYdWMTVsBsZpQr9i4ayKLjQwGkSMw/Ii2g4pFCGEfpCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI6PR04MB8284
X-Proofpoint-ORIG-GUID: 5mng09rEQ2k-y9HA-GJKKUZRzRGQ1BS6
X-Proofpoint-GUID: 5mng09rEQ2k-y9HA-GJKKUZRzRGQ1BS6
X-Sony-Outbound-GUID: 5mng09rEQ2k-y9HA-GJKKUZRzRGQ1BS6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-14_05,2024-10-11_01,2024-09-30_01
X-Mailman-Approved-At: Mon, 14 Oct 2024 15:03:22 +0200
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

SXMgdGhlcmUgYW55IHVwZGF0ZSBvbiB0aGlzIGlzc3VlPw0KSSBmb3VuZCB0aGF0IHRoaXMgaXNz
dWUgc3RpbGwgZXhpc3RzIG9uIHRoZSBsYXRlc3QgdjIwMjQuMTAgdS1ib290Lg0KDQotLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogWmh1LCBKaWFuZmVuZyA8SmlhbmZlbmdBLlpodUBz
b255LmNvbT4gDQpTZW50OiBUdWVzZGF5LCBBdWd1c3QgMjAsIDIwMjQgMTA6NDUgQU0NClRvOiBD
YWxlYiBDb25ub2xseSA8Y2FsZWIuY29ubm9sbHlAbGluYXJvLm9yZz47IE1hcmVrIFZhc3V0IDxt
YXJleEBkZW54LmRlPjsgbmVpbC5hcm1zdHJvbmdAbGluYXJvLm9yZzsgdHJpbmlAa29uc3Vsa28u
Y29tDQpDYzogQ2FvLCBKYWNreSA8SmFja3kuQ2FvQHNvbnkuY29tPjsgdS1ib290LXFjb21AZ3Jv
dXBzLmlvOyB1LWJvb3RAbGlzdHMuZGVueC5kZQ0KU3ViamVjdDog5Zue5aSNOiB1c2I6IGVoY2k6
IEZpeCBkYjQxMGMgdXNiIHJlc2V0IG5vdCB3b3JraW5nDQoNCj4gSmlhbmZlbmc6IGNvdWxkIHlv
dSBydW4gdGhlIHVzYiByZXNldCBjb21tYW5kIHdpdGggbG9nIGxldmVsIDggYW5kIA0KPiBwYXN0
ZSBhIGxvZz8gVGhhdCBtaWdodCByZXZlYWwgd2hlcmUgdGhlIEZEVCBsb29rdXAgZ29lcyB3cm9u
Zy4NCg0KUGxlYXNlIGNvbmZpcm0gYmVsb3cgbG9nIHdpdGggbGV2ZWwgOCANCg0KZHJhZ29uYm9h
cmQ0MTBjID0+IHVzYiByZXNldA0KcmVzZXR0aW5nIFVTQi4uLg0KU2VuZGluZyBldmVudCA1Lyh1
bmtub3duKSB0byBzcHkgJ2VmaV9kaXNrIGFkZCcNCkJ1cyB1c2JANzhkOTAwMDogb2Zub2RlX3Jl
YWRfcHJvcDogYXNzaWduZWQtY2xvY2stcmF0ZXM6IDxub3QgZm91bmQ+IFNlbmRpbmcgZXZlbnQg
NS8odW5rbm93bikgdG8gc3B5ICdlZmlfZGlzayBhZGQnDQpvZm5vZGVfcmVhZF9wcm9wOiBhc3Np
Z25lZC1jbG9jay1yYXRlczogPG5vdCBmb3VuZD4gU2VuZGluZyBldmVudCA1Lyh1bmtub3duKSB0
byBzcHkgJ2VmaV9kaXNrIGFkZCcNCm9mbm9kZV9yZWFkX3Byb3A6IGFzc2lnbmVkLWNsb2NrLXJh
dGVzOiBvZm5vZGVfcmVhZF91MzJfYXJyYXk6IGFzc2lnbmVkLWNsb2NrLXJhdGVzOiBMb29raW5n
IGZvciBjbG9jay1jb250cm9sbGVyQDE4MDAwMDAgTG9va2luZyBmb3IgY2xvY2stY29udHJvbGxl
ckAxODAwMDAwDQogICAgICAtIGNoZWNraW5nIHFjb21fY2xrDQogICAtIHJlc3VsdCBmb3IgY2xv
Y2stY29udHJvbGxlckAxODAwMDAwOiBxY29tX2NsayAocmV0PTApDQogICAtIHJlc3VsdCBmb3Ig
Y2xvY2stY29udHJvbGxlckAxODAwMDAwOiBxY29tX2NsayAocmV0PTApIExvb2tpbmcgZm9yIGNs
b2NrLWNvbnRyb2xsZXJAMTgwMDAwMCBMb29raW5nIGZvciBjbG9jay1jb250cm9sbGVyQDE4MDAw
MDANCiAgICAgIC0gY2hlY2tpbmcgcWNvbV9jbGsNCiAgIC0gcmVzdWx0IGZvciBjbG9jay1jb250
cm9sbGVyQDE4MDAwMDA6IHFjb21fY2xrIChyZXQ9MCkNCiAgIC0gcmVzdWx0IGZvciBjbG9jay1j
b250cm9sbGVyQDE4MDAwMDA6IHFjb21fY2xrIChyZXQ9MCkgTG9va2luZyBmb3IgY2xvY2stY29u
dHJvbGxlckAxODAwMDAwIExvb2tpbmcgZm9yIGNsb2NrLWNvbnRyb2xsZXJAMTgwMDAwMA0KICAg
ICAgLSBjaGVja2luZyBxY29tX2Nsaw0KICAgLSByZXN1bHQgZm9yIGNsb2NrLWNvbnRyb2xsZXJA
MTgwMDAwMDogcWNvbV9jbGsgKHJldD0wKQ0KICAgLSByZXN1bHQgZm9yIGNsb2NrLWNvbnRyb2xs
ZXJAMTgwMDAwMDogcWNvbV9jbGsgKHJldD0wKSBMb29raW5nIGZvciBwaHkgTG9va2luZyBmb3Ig
cGh5DQogICAtIHJlc3VsdCBmb3IgcGh5OiAobm9uZSkgKHJldD0tMTkpDQogICAtIHJlc3VsdCBm
b3IgcGh5OiAobm9uZSkgKHJldD0tMTkpDQpMb29raW5nIGZvciB1bHBpDQpMb29raW5nIGZvciB1
bHBpDQogICAtIHJlc3VsdCBmb3IgdWxwaTogKG5vbmUpIChyZXQ9LTE5KQ0KICAgLSByZXN1bHQg
Zm9yIHVscGk6IChub25lKSAocmV0PS0xOSkNClBvcnQgbm90IGF2YWlsYWJsZS4NCmRyYWdvbmJv
YXJkNDEwYyA9PiANCg0KQmVzdCBSZWdhcmRzDQpqaWFuZmVuZyB6aHUNCg0KX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXw0K5Y+R5Lu25Lq6OsKgQ2FsZWIgQ29ubm9sbHkg
PGNhbGViLmNvbm5vbGx5QGxpbmFyby5vcmc+DQrlj5HpgIHml7bpl7Q6wqAyMDI05bm0OOaciDE5
5pelIDE5OjI4DQrmlLbku7bkuro6wqBNYXJlayBWYXN1dCA8bWFyZXhAZGVueC5kZT47IFpodSwg
SmlhbmZlbmcgPEppYW5mZW5nQS5aaHVAc29ueS5jb20+OyBuZWlsLmFybXN0cm9uZ0BsaW5hcm8u
b3JnIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPjsgdHJpbmlAa29uc3Vsa28uY29tIDx0cmlu
aUBrb25zdWxrby5jb20+DQrmioTpgIE6wqBDYW8sIEphY2t5IDxKYWNreS5DYW9Ac29ueS5jb20+
OyB1LWJvb3QtcWNvbUBncm91cHMuaW8gPHUtYm9vdC1xY29tQGdyb3Vwcy5pbz47IHUtYm9vdEBs
aXN0cy5kZW54LmRlIDx1LWJvb3RAbGlzdHMuZGVueC5kZT4NCuS4u+mimDrCoFJlOiB1c2I6IGVo
Y2k6IEZpeCBkYjQxMGMgdXNiIHJlc2V0IG5vdCB3b3JraW5nDQrCoA0KT24gMTkvMDgvMjAyNCAx
MzoyMSwgTWFyZWsgVmFzdXQgd3JvdGU6DQo+IE9uIDgvMTkvMjQgNDowNSBBTSwgSmlhbmZlbmdB
LlpodUBzb255LmNvbSB3cm90ZToNCj4+IHVzYiByZXNldCBub3Qgd29ya2luZyBlcnJvciBsb2cN
Cj4+ID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09DQo+PiBkcmFnb25ib2FyZDQxMGMgPT4gdXNiIHJlc2V0DQo+PiByZXNl
dHRpbmcgVVNCLi4uDQo+PiBCdXMgdXNiQDc4ZDkwMDA6IFBvcnQgbm90IGF2YWlsYWJsZS4NCj4+
IGRyYWdvbmJvYXJkNDEwYyA9Pg0KPj4gPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NCj4+DQo+PiBBZnRlciBjb21taXQg
ZWQ4ZmJkMjg4OWZjICgiZHRzOiBtc204OTE2OiByZXBsYWNlIHdpdGggdXBzdHJlYW0gRFRTIikg
DQo+PiBtc204OTE2X3VzYnBoeSB3aWxsIGJlIGRlZmluZWQgYXMgYSBjaGlsZCBkZXZpY2Ugb2Yg
dXNiQDc4ZDkwMDAuIHVzYiANCj4+IHJlc2V0IHdpbGwgZmlyc3QgY2FsbCB1c2Jfc3RvcCwgYW5k
IG1zbTg5MTZfdXNicGh5IGFzIGNoaWxkIGRldiB3aWxsIA0KPj4gYmUgdW5iaW5kIGluIHVzYl9z
dG9wLCBhbmQgdGhlcmUgaXMgbm8gYmluZCBvcGVyYXRpb24gaW4gZG9fdXNiX3N0YXJ0IA0KPj4g
YWZ0ZXJ3YXJkcywgc28gdGhlIG1zbTg5MTZfdXNicGh5IHVjbGFzcyBjYW5ub3QgYmUgZm91bmQu
IFRoaXMgY2F1c2VzIA0KPj4gZWhjaV9tc20gcHJvYmUgdG8gZmFpbC4NCj4+DQo+PiBEZXRhaWxl
ZCBjYWxsaW5nIHByb2Nlc3MNCj4+ID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQo+PiB1c2IgcmVzZXQ6DQo+PiB8LT4g
dXNiX3N0b3AgKGRyaXZlcnMvdXNiL2hvc3QvdXNiLXVjbGFzcy5jKQ0KPj4gLnwtPiBkZXZpY2Vf
ZmluZF9maXJzdF9jaGlsZA0KPj4gLiB8LT4gZGV2aWNlX3VuYmluZChyaCk7IDw9PSAodW5iaW5k
IG1zbTg5MTZfdXNicGh5KQ0KPj4gfC0+IGRvX3VzYl9zdGFydA0KPj4gwqAgfC0+IHVzYl9pbml0
IChkcml2ZXJzL3VzYi9ob3N0L3VzYi11Y2xhc3MuYykNCj4+IMKgwqAgfC0+IGRldmljZV9wcm9i
ZShidXMpOw0KPj4gwqDCoMKgIHwtPiBlaGNpX3VzYl9wcm9iZQ0KPj4gwqDCoMKgwqAgfC0+IGdl
bmVyaWNfc2V0dXBfcGh5IDw9PSBlcnIgY291bGRuJ3QgZmluZCBtc204OTE2X3VzYnBoeSANCj4+
ID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09DQo+Pg0KPj4gRml4OiByZWJpbmQgdGhlIG1zbTg5MTZfdXNicGh5IGRyaXZl
ciBkdXJpbmcgZWhjaV91c2JfcHJvYmUgaWYgdGhlIA0KPj4gbXNtODkxNl91c2JwaHkgdWNsYXNz
IGhhcyBiZWVuIHJlbW92ZWQuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogSmlhbmZlbmcgWmh1IDxK
aWFuZmVuZ0EuWmh1QHNvbnkuY29tPg0KPj4gUmV2aWV3ZWQtYnk6IEphY2t5IENhbyA8SmFja3ku
Q2FvQHNvbnkuY29tPg0KPj4gUmV2aWV3ZWQtYnk6IFRveWFtYSwgWW9zaGloaXJvIDxZb3NoaWhp
cm8uVG95YW1hQHNvbnkuY29tPg0KPj4gLS0tDQo+PiDCoCBkcml2ZXJzL3VzYi9ob3N0L2VoY2kt
bXNtLmMgfCA3ICsrKysrKysNCj4+IMKgIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKykN
Cj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvaG9zdC9laGNpLW1zbS5jIA0KPj4gYi9k
cml2ZXJzL3VzYi9ob3N0L2VoY2ktbXNtLmMgaW5kZXggZmYzMzYwODJlMy4uN2NiM2FlMDg0OSAx
MDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvdXNiL2hvc3QvZWhjaS1tc20uYw0KPj4gKysrIGIvZHJp
dmVycy91c2IvaG9zdC9laGNpLW1zbS5jDQo+PiBAQCAtNDcsNiArNDcsOCBAQCBzdGF0aWMgY29u
c3Qgc3RydWN0IGVoY2lfb3BzIG1zbV9laGNpX29wcyA9IHsNCj4+IMKgwqDCoMKgwqAgLmluaXRf
YWZ0ZXJfcmVzZXQgPSBtc21faW5pdF9hZnRlcl9yZXNldA0KPj4gwqAgfTsNCj4+ICtzdGF0aWMg
aW50IGVoY2lfdXNiX29mX2JpbmQoc3RydWN0IHVkZXZpY2UgKmRldik7DQo+PiArDQo+PiDCoCBz
dGF0aWMgaW50IGVoY2lfdXNiX3Byb2JlKHN0cnVjdCB1ZGV2aWNlICpkZXYpDQo+PiDCoCB7DQo+
PiDCoMKgwqDCoMKgIHN0cnVjdCBtc21fZWhjaV9wcml2ICpwID0gZGV2X2dldF9wcml2KGRldik7
IEBAIC01NCw2ICs1Niw3IEBAIA0KPj4gc3RhdGljIGludCBlaGNpX3VzYl9wcm9iZShzdHJ1Y3Qg
dWRldmljZSAqZGV2KQ0KPj4gwqDCoMKgwqDCoCBzdHJ1Y3QgdXNiX3BsYXQgKnBsYXQgPSBkZXZf
Z2V0X3BsYXQoZGV2KTsNCj4+IMKgwqDCoMKgwqAgc3RydWN0IGVoY2lfaGNjciAqaGNjcjsNCj4+
IMKgwqDCoMKgwqAgc3RydWN0IGVoY2lfaGNvciAqaGNvcjsNCj4+ICvCoMKgwqAgc3RydWN0IHVk
ZXZpY2UgKnBoeWRldjsNCj4+IMKgwqDCoMKgwqAgaW50IHJldDsNCj4+IMKgwqDCoMKgwqAgcmV0
ID0gY2xrX2dldF9ieV9uYW1lKGRldiwgImNvcmUiLCAmcC0+Y29yZV9jbGspOyBAQCAtODAsNiAN
Cj4+ICs4MywxMCBAQCBzdGF0aWMgaW50IGVoY2lfdXNiX3Byb2JlKHN0cnVjdCB1ZGV2aWNlICpk
ZXYpDQo+PiDCoMKgwqDCoMKgIGhjb3IgPSAoc3RydWN0IGVoY2lfaGNvciAqKSgocGh5c19hZGRy
X3QpaGNjciArDQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBIQ19MRU5HVEgoZWhjaV9y
ZWFkbCgmKGhjY3IpLT5jcl9jYXBiYXNlKSkpOw0KPj4gK8KgwqDCoCByZXQgPSB1Y2xhc3NfZ2V0
X2RldmljZV9ieV9uYW1lKFVDTEFTU19QSFksICJtc204OTE2X3VzYnBoeSIsDQo+PiAmcGh5ZGV2
KTsNCj4gDQo+IFRoYW5rcyBmb3IgbG9va2luZyBpbnRvIHRoaXMuDQo+IA0KPiBDYWxlYiwgZG8g
eW91IGtub3cgd2h5IGdlbmVyaWNfc2V0dXBfcGh5KCkgc3RhcnRlZCBmYWlsaW5nIG5vdyA/IENh
biANCj4gaXQgYmUgZml4ZWQgdG8gaGFuZGxlIHRoaXMgcGxhdGZvcm0gaW5zdGVhZCA/DQoNCkkn
bSBub3Qgc3VyZSwgYnV0IEkgZG8gYWdyZWUgdGhhdCBpdCBkb2Vzbid0IHNlZW0gbGlrZSB0aGlz
IHBhdGNoIGFkZHJlc3NlcyB0aGUgcm9vdCBjYXVzZS4NCg0KSmlhbmZlbmc6IGNvdWxkIHlvdSBy
dW4gdGhlIHVzYiByZXNldCBjb21tYW5kIHdpdGggbG9nIGxldmVsIDggYW5kIHBhc3RlIGEgbG9n
PyBUaGF0IG1pZ2h0IHJldmVhbCB3aGVyZSB0aGUgRkRUIGxvb2t1cCBnb2VzIHdyb25nLg0KDQpL
aW5kIHJlZ2FyZHMsDQoNCg0KLS0NCi8vIENhbGViICh0aGV5L3RoZW0pDQo=
