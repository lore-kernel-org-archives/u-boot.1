Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47537D6ED2A
	for <u-boot@archiver.kernel.org>; Thu, 21 Nov 2024 13:21:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C8D189769;
	Thu, 21 Nov 2024 14:20:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sony.com header.i=@sony.com header.b="lx6x4d/f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D6FB895FA; Thu, 21 Nov 2024 06:52:34 +0100 (CET)
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com
 [185.132.183.11])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 618AC89304
 for <u-boot@lists.denx.de>; Thu, 21 Nov 2024 06:52:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=JianfengA.Zhu@sony.com
Received: from pps.filterd (m0209329.ppops.net [127.0.0.1])
 by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AL4kgqZ017075;
 Thu, 21 Nov 2024 05:52:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=S1; bh=/QBZpO5fn8N7kRZuk8SdN5kuTjLDn
 CAQajcZqmWs4KA=; b=lx6x4d/fxqZ8E9Fx1+DDh5z999PW09ijopCAVjqKLItw8
 Qf1Auk3VBJZI3OCLz6hqCUDH5uzBYuiBLhZsAcwOdxIJGz45A5yTwFomY6gkj4IT
 N4TnXTBcpx82EkNwC4a4u7W3Vr8b0h18U4Wns2JXWGf8iOsOXXCeIjNCqZXmrXCQ
 G5Rszjx1pna8nCoYizDcno54zN/8YtdU96TGROAbBJzTXwSbymdSYrJrp8GjcTTL
 BoyWXqthX7yv1FwH+0AKteo+yZhR76tT7RhyD7wflqmTAQ3z66M56MDfbWH0h4A7
 LmJbA+NuZJ7iJ92teIlhjank6e4Y60zYnJrj/Y5PQ==
Received: from apc01-tyz-obe.outbound.protection.outlook.com
 (mail-tyzapc01lp2046.outbound.protection.outlook.com [104.47.110.46])
 by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 42xm964gv3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 21 Nov 2024 05:52:26 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ff6YKeWkLrMAEZR4kUQLozwFcdEeHh6Bu/5LTR0EFebprHgt3mgAbxjr6j9KUj4WY201nCSNYDzy+JLpe1coqCvBzgNQ1bGJRenOkOJVBP+oIBYMRBCbckDDJDLY61q6t1nDhL4wO+PTSYwnfFeFD/oKEpqV4dpiDeQ/0KRWLXQZmR4CPdeMa/gs899y8t4yoF6T2uKrmkzsUmDENV34EsLIUUoi3XQWpFypCD5C+MnwBWyqzBN99xhRuIz+SmwDuG573puqsuxR4XJjwTDLImcYiJjjOq96DVZ1bkKMkgDxlovdsyWfAWU/t48QODjhdOgKmcDO7x7d56AI+3iyGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/QBZpO5fn8N7kRZuk8SdN5kuTjLDnCAQajcZqmWs4KA=;
 b=GZMcxsR4l++5buDvks4tZW+tVCVaN7dxrSXbt2CgUBUeE03zMkhtEUsdESAzMhhUCRtSBtOeBZ5Jd1UMzjnSwuiOjTBCOV4cWsKi1yGM4k22CecUp8L6Qgui0IUOCYNCeAy4xjE1MSAKu+FADjOV7ronqNP0Fu9Tkjz+e/PAm9xdCSLAS3Y+wsJNFIZcA8kQN5A+2Mxm2/iBCw8IkQc3m8sy10Ree0IQuA80seoViIY1Xpyt8B89zZxWRnxD6YbatGr30GaBQDfR4DQcVQz+B2Jn8el6899yPPMIDDr+zVNG/Ise853tJPHW+60J5SUnnbny4+Yi6pHLECRl+mstPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from OSQPR04MB7740.apcprd04.prod.outlook.com (2603:1096:604:283::6)
 by SI2PR04MB6114.apcprd04.prod.outlook.com (2603:1096:4:1fa::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.15; Thu, 21 Nov
 2024 05:52:15 +0000
Received: from OSQPR04MB7740.apcprd04.prod.outlook.com
 ([fe80::7c06:41d9:f38c:e1bd]) by OSQPR04MB7740.apcprd04.prod.outlook.com
 ([fe80::7c06:41d9:f38c:e1bd%6]) with mapi id 15.20.8158.021; Thu, 21 Nov 2024
 05:52:15 +0000
From: "JianfengA.Zhu@sony.com" <JianfengA.Zhu@sony.com>
To: "caleb.connolly@linaro.org" <caleb.connolly@linaro.org>,
 "neil.armstrong@linaro.org" <neil.armstrong@linaro.org>, "marex@denx.de"
 <marex@denx.de>, "trini@konsulko.com" <trini@konsulko.com>
CC: "u-boot-qcom@groups.io" <u-boot-qcom@groups.io>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, "Jacky.Cao@sony.com" <Jacky.Cao@sony.com>
Subject: [v2] phy: Fix db410c crash issue during usb_stop
Thread-Topic: [v2] phy: Fix db410c crash issue during usb_stop
Thread-Index: AQHbO9kMShKMO2r48kuyD0WReFo7sw==
Date: Thu, 21 Nov 2024 05:52:15 +0000
Message-ID: <OSQPR04MB77408FFDE05FE0FD91E6D24D90222@OSQPR04MB7740.apcprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSQPR04MB7740:EE_|SI2PR04MB6114:EE_
x-ms-office365-filtering-correlation-id: 9acadbb3-9b9a-48a5-28f4-08dd09f0a6e7
x-proofpoint-id: d8690225-876f-412f-87c6-a7cb45557a4c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|10070799003|1800799024|366016|376014|38070700018; 
x-microsoft-antispam-message-info: =?gb2312?B?K01wcGFUc0IvWVVmMUNLUjFKdUlFSjhYU3VkZzVtN1EveEl4MVZjdkRyQlE2?=
 =?gb2312?B?SVRHK0hxWThhYUx6MS9UekFuWE5qTWhzUkdaLzkzdlVXZEsvbFBhUXRRSHJK?=
 =?gb2312?B?OXMvUE9hN2pCeVZNa0hIeFZraTV0c2J1Tm80b0FJb1V5bGwrdlU1Q2J0amFP?=
 =?gb2312?B?SjJRL3kvZ2l3NUhmanRUWWU2ZHFnZVk4amNYQisyMjNQazNyL25GRHl6ZGEz?=
 =?gb2312?B?ZGZFNUpRQlpuT0x3WmVXcGpIYkQ0Q0JuZTAxQ21MMnJzRGplREJ3Y0dYSVps?=
 =?gb2312?B?K2R0ZXNtVlBydHRra2VZTnE3OTVSalZzY1hTOWJZOWh4Y0J4RHU2Mkx6TUtM?=
 =?gb2312?B?bXlPYU42YVRYU3VGdklHcHM4TFk3cXNCSkNLbmVuTXJEUWpqcS80MUtrOFhz?=
 =?gb2312?B?aWVEVE4xeU5FSWNRVm5WbFNFVnRLa1k5ay9PenFtbVRZSnRaa0FlZVNOLzdZ?=
 =?gb2312?B?TGFGNHorZkxVRWttV25uQS9nMFUvdXlyN2RNODVBSEs0VzlielhIZ0NSaEZL?=
 =?gb2312?B?dElEbTJpV0R1ZnMybzQyK01zdnhPbGJPWDBDbGgxbkFkWEIwYlhEOVZnMmVw?=
 =?gb2312?B?SXBHWWF1QlIyNHJRdEF2bGRtYnk2M2xuNllaajJYQXlTdmlJWWs4ZHc2SFUy?=
 =?gb2312?B?RFBPVFQ4SGFrT3N0b3Y1MHZWMVJORW01M2ZuejV0RUh4UzV0YVUvaTFTN3Er?=
 =?gb2312?B?RVJYOVJremVqc2Q2Q0J2cnpkVmRWUkJMVVIxUjM2cEZ5OCtteW1HOS9sSU84?=
 =?gb2312?B?Y2E1RnhDaDd4eFk4dE92di9HeXQ0ODYycUFzcFJLOUhmZ1czUUNScDI2Yld3?=
 =?gb2312?B?ZEVidE9PTzdVZ1U4QXRmdkQxZUhzYk1ZUktqTTVDaTkrQ3grUlNnTkJDUERB?=
 =?gb2312?B?K1cwYlpjbWJQa3JHOUR6bkVCMXNtZWphQmJsalFORkVUeW5qZkxzcUpLcmdP?=
 =?gb2312?B?TFN0aGNXNk9PZVl1NHVQUkNsQ0FWUGh3SzNtZUh0OVVwWDdmK3A2aUVnSUNj?=
 =?gb2312?B?ZGVuTWtKQ0g0SGRaL0Z6L0N3Y1M1aWllRHpkd0hvNmh5SS9MYXlsY2tGa2Q3?=
 =?gb2312?B?bC93dCtwdGQ5NDgzaGJzTEhGelZnQVZvd3JYQ2duSjBHNStlQVA2azFHbFBG?=
 =?gb2312?B?OFJwd0V4VWlib1k1VXVEb3NvdTh0UWdCZHJ4a3ZRS0o1STBmeHFRUjJlOGdF?=
 =?gb2312?B?a0NSWGVFeEJKS3ZpdGVCRnlwM1V0VmQ4RnJiVVp1SCsrRXRQMmI0K1d6UnFZ?=
 =?gb2312?B?eTBtVmsyQU1nTDVPNkt4c0tqZVd3RE9NelBBTWpHUFBQK0ZwdVRZVXlHUmhT?=
 =?gb2312?B?MnpxbllLSFI3L2p4VDVvRGRTYU5sbGpwaFVCQ0kyQzZXb2VubHRzZllrRmpo?=
 =?gb2312?B?eWZGL3pUUzJEeXFPd1EwNWFVeU9wQVdIOEc1R2dJL1IzajNmaTByYmkvakRa?=
 =?gb2312?B?d2wyMS8zTVVuZnVvRlI4UVlRNUVwblNiV2RYUUp5UWFQQ0dkdml6UHN4N0lm?=
 =?gb2312?B?TjAzN0JUcjFOMzlQTENVek11OFVtUFFWRy9weHppbUF0Rnh3eWpTdXo2MitR?=
 =?gb2312?B?ZzViL2tOTFZ3Z0g4UWlFOEkzN3V4K1RRTnVEWmpldnl3UmhVUkt6SUF3Nlh0?=
 =?gb2312?B?K0txemdzTSsxZkdlVGRXcTV0RzFBRG5zakFFOUp6ZWUwMTdwNjZXTVNsR0p2?=
 =?gb2312?B?dko5MHpwNlBSaDZrbnVvL24wVUJaaVd0SytXV0ROeGN1MkVFaU4zNElGSkZT?=
 =?gb2312?B?ZVhrMFVob3liMWlwbXhMbVRTNVpoalFVdkZOOVBiZDhPV1ZqaTFyNVBwbzhB?=
 =?gb2312?Q?CMtqiHe8/NoMs+C8MiGRcOhqsl4lrpoShkGNg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:OSQPR04MB7740.apcprd04.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?OUl5YnRsYkRFWEhPSFhJeEVteTFoR2tiaHJOOFJ3OGpvWTZkeUI3WURjWnVt?=
 =?gb2312?B?VXR2dmtTZEZxcWRYMjI1M1AzOXpYY3hEZWZ3a290ejVzVlNFa0dETUprYm90?=
 =?gb2312?B?ZGxMVkFrNGk5RlJ2Nzk4OEdBUlJjSVNUK204c041TndPNVV2T3FDbGFnenpE?=
 =?gb2312?B?MXNKNjhsNmh0MHl5RmpkZ1RWT3BmY0tGSUFnSXl2SkN0d1dBUjhQYlNJNnZ4?=
 =?gb2312?B?V05JRkoydSs3TnBKTDk0dmhFN1JwbUtvZHlETzVpUTdFSXNvQ0R4M2pKS3JV?=
 =?gb2312?B?aDhxcS92K3NXa3ZnN0dPYk8vZHlGR0ZUNnF6YzFqMlhzTFlkTnhVVGpPcDlk?=
 =?gb2312?B?WFZ3eXFhL0J3ODVwNHVyc2lweXYvVzRFNFhGQVMwUmpMbTZVL1ZnSUNlRDBj?=
 =?gb2312?B?OUZ2NVczcWZpUVEyaEppRlB2QXZxb3pobWU1U3F6c0N4M041M0FIUk16REFh?=
 =?gb2312?B?dzFiY1BsUFU2a0x5QStvbm5jYndpU1AzZHpKOXRWb0pSU0NJSVUxWDFibVhO?=
 =?gb2312?B?NGxTUzVDU3k3ZkdTY0g4Z3NKQnJDTmZ5QnQ5WHlxc1N0YTJTZkRSeUJmUjZt?=
 =?gb2312?B?V2VtZ1hRUVZGRDZ2T0ZQUkVTOFJRdUJ6Ykd2ZjMybEdabkxQMHpZVW51S3ZE?=
 =?gb2312?B?b3F6SDM4RU1FODhQR1BYazU5R3FBZUhqV2hCWGFZelZQMFN2V0wwNHNMVXFU?=
 =?gb2312?B?dExyZkdjak9aa1dyODJkdHJXVEkza1lTanVaZmJzbE1kdG95aWpGTTBqL2xj?=
 =?gb2312?B?MzBPY2taekhpSUU1NHc4ek02TVVlVC9NUlhmTW5ETzk2cXhjbWFuNDF1S2h4?=
 =?gb2312?B?L0dZcEhFVVRwY2ZHb1BsL0NMQTJrMXFqWDJtaEdNd0xaTWl1Vzd0cFEvK3dr?=
 =?gb2312?B?TW5XYU1DdXlJK2VOVTFwNXhaekVBWEsxRktaVmpZeG1vM2ZMakZKV21VQlQ2?=
 =?gb2312?B?OFlRTlhNTmJyREFwd2crSnV3NURMYkExbGQ2MUVmdHhCNnZ3ak5MY25KTXlO?=
 =?gb2312?B?clgrUm1zNWpXaWRPZXJ2d2c5eGc0OXpTSk1VTjlwRlNmNitEYWNCUzBYcURs?=
 =?gb2312?B?RXJyZW13YVRBTEtjVWhPbGJQMUhxT2FMTE5XZVcrZC9vQ1grZTJ3cUphbXJ5?=
 =?gb2312?B?bnluaGNXNkh6L0d5YWp3UnVUSTJTSXIrUmwrZHJqTklTaUVDL2owRFVSSG1Z?=
 =?gb2312?B?TldlcGs3amNtN1RTMGJ4emlFdWZBT2cwRFp5RnBoa2gwdTJ2eldPNWxUVDcy?=
 =?gb2312?B?MTZ2MWwzcmRCLzkzWUQxa04reVZWUjZXMWlqbUErK1FXWDJtN2ZPMllIUGxF?=
 =?gb2312?B?THNmNWVpTlRETWFnMEt3eEo1ckhWbnFBYWpBREE3ZzQvRnRjV2pPNnplR0Q0?=
 =?gb2312?B?Y2RHa05SUU0zd05iUmNvUnF4VHpwazBqelpPaWRHRTlrQ0NmRU5GTUthSGQ1?=
 =?gb2312?B?bEdoNFhQK1RUd2tRMFptYnFWUzM1ejFjNkd1UjVUWG4xek5ONThhaXZpTEJO?=
 =?gb2312?B?R2hIWi9wMm0xbzNVNTg3ajg2b0hGQzdjTDZkdXlOQllSOEJJN0lXKzZmckhP?=
 =?gb2312?B?KzEyaGNtdzlQVmM0d0NhVzZiSEE3RFVKYmlpQlZMREhDY1VUNlBEVmZEaVJL?=
 =?gb2312?B?ODRjdzFOa3pPVGpIdzQrd2RFeVMxQ29yNFZMSHR6RWozbExsRDMxR0dqeTRH?=
 =?gb2312?B?NUY2NG1DanFtTmtmaXk4UmlxM3pQdkVXaks1bXI0Vm1oZWlZa2lwTitzWWNP?=
 =?gb2312?B?Y2lEUjlwRWttWldaMStRUzdxWncrQ09iV3FZRlpzUW1lVnFObFFITkxyU2Ez?=
 =?gb2312?B?Z1hwMWc4ek5wYlpRTjNMZE40UWF0SjBCVWw5SVdXZzlIVTliWDkxRXZRaHJE?=
 =?gb2312?B?a1huOGZ6ekI5Qk9LblBnMUoxU2tQc2hJR1ZNNGtFS0J2eGh5TVRtQnpwMGtt?=
 =?gb2312?B?TlRsaUJndG8xb1BmY2t2UjkrbWkyOG14VEh3eDhsZ05lUGsxU0lQRjhSU0c3?=
 =?gb2312?B?c0Vwbk9iTWZobFNGQWZWQldXL0JyWGtBbHJjRnV4S3RMRkdVUk4wOERaZVNi?=
 =?gb2312?B?ZnZhdm5KeGgrR3g4YzRFZHBXQUNjc0RIQjl6VERiS01VdCtUanpOMlBZUmlU?=
 =?gb2312?B?d0Q0WFlyWHhlUXZVd1NZQ2hPQUtiRlk0RmNYczhUSEIrTGxYRGlSc2JaL1VE?=
 =?gb2312?Q?WVov48Nz2FqCH/6/Qo0eYq8=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 2hjBNFXGdnOigoA9VSPNVYreKoDGAEcRweG5OvFbQvNOM2d9kPrmz0QzJsevP6sL2DSqvW+rwB6i/vOl3lwkwOh6QymrCVW+IF/Anap8DOEs4RHTls/zURXO167UUdzkFvEV3cRDQtVWApNCB/CvS51/G1CemqogjS+p/Z3aUsMly6EszyaDTT8T+n4OQz2RBeR2cGIifcWjhzhvmWbjZlwOdctr9C19P6/6xHnFiOwUTW3EVIscFk+HjtSPtiwnj93IFIJyJAXNCT0ALGVRvx8kFT6m/mrfnHpC70J91d6sP3IJqeeN1GcO6ouwZ9PmEdloKQTuQb66DbdN62icnU4cCwGP0eZRTCTpMRkdr4l6HH8WddR52hY6D7HQoCT1f0r7env8bZV+fGzcHO0zMkkonBsczBJC1ixvHQrEO1cGbUxrQ01OQq12sf2mrZGFIj1SkiuwuZJAO3hnP05RD+GL+HgKlEI2nlKSzE9jhtYQyIIKnFMI3x2CyE7jy880TPDL4gCiYbEDJsRDAKRFSxa12lZKZv1omyk7DboIGWuWDUpZFAdCnuSxXS48aqwy8iS1ClfmUX47aSTAlBCBWEP4kMoRNIzQ8CW+c2+aMjBx+K+N37BiJZhstXij3dQZ
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSQPR04MB7740.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9acadbb3-9b9a-48a5-28f4-08dd09f0a6e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2024 05:52:15.3184 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bhbikl9EGZEE4XGG0JcyreNv2gMzF6APB7RZrAksPSYXgHJMPc/auap9IVtOamOEEXKTYFVSeVSfN8Iyyjt3Jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR04MB6114
X-Proofpoint-ORIG-GUID: EJutNuk9LCo8_It5WScBA1cmIH8a0jIR
X-Proofpoint-GUID: EJutNuk9LCo8_It5WScBA1cmIH8a0jIR
X-Sony-Outbound-GUID: EJutNuk9LCo8_It5WScBA1cmIH8a0jIR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-21_03,2024-11-20_01,2024-09-30_01
X-Mailman-Approved-At: Thu, 21 Nov 2024 14:20:56 +0100
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

dXNiIHN0b3AgY3Jhc2ggbG9nCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09CmRyYWdvbmJvYXJkNDEwYyA9PiB1c2Igc3Rh
cnQKc3RhcnRpbmcgVVNCLi4uCkJ1cyB1c2JANzhkOTAwMDogVVNCIEVIQ0kgMS4wMApzY2Fubmlu
ZyBidXMgdXNiQDc4ZDkwMDAgZm9yIGRldmljZXMuLi4gNCBVU0IgRGV2aWNlKHMpIGZvdW5kCiAg
ICAgICBzY2FubmluZyB1c2IgZm9yIHN0b3JhZ2UgZGV2aWNlcy4uLiAwIFN0b3JhZ2UgRGV2aWNl
KHMpIGZvdW5kCmRyYWdvbmJvYXJkNDEwYyA9PiB1c2Igc3RvcApzdG9wcGluZyBVU0IuLgoiU3lu
Y2hyb25vdXMgQWJvcnQiIGhhbmRsZXIsIGVzciAweDk2MDAwMDA3LCBmYXIgMHgwCmVscjogMDAw
MDAwMDA4ZjYzNmEyOCBsciA6IDAwMDAwMDAwOGY2MzZhMjQgKHJlbG9jKQplbHI6IDAwMDAwMDAw
YmQ5N2VhMjggbHIgOiAwMDAwMDAwMGJkOTdlYTI0CngwIDogMDAwMDAwMDAwMDAwMDAwMCB4MSA6
IDAwMDAwMDAwYmQxNDk0ZDAKeDIgOiAwMDAwMDAwMDAwMDAwMDAwIHgzIDogMDAwMDAwMDAwMDAw
MWY0MAp4NCA6IDAwMDAwMDAwYmQxMzE5OTAgeDUgOiAwMDAwMDAwMGJkMTU3YjcwCng2IDogMDAw
MDAwMDAwMDAwMDA0MSB4NyA6IDAwMDAwMDAwYmQxNjNiODAKeDggOiAwMDAwMDAwMGJkMTMxZGIw
IHg5IDogMDAwMDAwMDAwMDAwYjY1Ywp4MTA6IDAwMDAwMDAwYmQxMzE4M2MgeDExOiAwMDAwMDAw
MDAwMDAwMDA2CngxMjogMDAwMDAwMDAwMDAxODY5ZiB4MTM6IDAwMDAwMDAwMDAwMDAwNjEKeDE0
OiAwMDAwMDAwMGZmZmZmZmZmIHgxNTogMDAwMDAwMDBiZDEzMTdiOAp4MTY6IDAwMDAwMDAwYmQ5
Yjc4YWMgeDE3OiAwMDAwMDAwMDAwMDAwMDAwCngxODogMDAwMDAwMDBiZDE0M2Q5MCB4MTk6IDAw
MDAwMDAwYmQxNTc1ZDgKeDIwOiAwMDAwMDAwMGJkMTU3NWQ4IHgyMTogMDAwMDAwMDBiZDE1NzQ0
MAp4MjI6IDAwMDAwMDAwYmQxNDkzYjAgeDIzOiAwMDAwMDAwMDAwMDAwMDAyCngyNDogMDAwMDAw
MDBiZDllYjkxMCB4MjU6IDAwMDAwMDAwMDAwMDAwMDAKeDI2OiAwMDAwMDAwMDAwMDAwMDAwIHgy
NzogMDAwMDAwMDAwMDAwMDAwMAp4Mjg6IDAwMDAwMDAwYmQxNTg1NDAgeDI5OiAwMDAwMDAwMGJk
MTMxOTgwCgpDb2RlOiBmOTQwMDAwMCBiNDAwMDEyMCA5N2ZmZGQxZSBhYTAwMDNlMiAoZjk0MDAw
MDEpClJlc2V0dGluZyBDUFUgLi4uCgpyZXNldHRpbmcgLi4uCj09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09CgpBZnRlciBj
b21taXQgZWQ4ZmJkMjg4OWZjICgiZHRzOiBtc204OTE2OiByZXBsYWNlIHdpdGggdXBzdHJlYW0g
RFRTIikKbXNtODkxNl91c2JwaHkgd2lsbCBiZSBkZWZpbmVkIGFzIGEgY2hpbGQgZGV2aWNlIG9m
IHVzYkA3OGQ5MDAwLiBXaGVuCmNhbGxpbmcgdXNiIHN0b3AsIHVzYkA3OGQ5MDAwIHdpbGwgYmUg
cmVtb3ZlZC4gRHVyaW5nIHRoZSByZW1vdmFsIHByb2Nlc3MsCnRoZSBzdWItZGV2aWNlIG1zbTg5
MTZfdXNicGh5IHdpbGwgYmUgcmVtb3ZlZCBmaXJzdC4gSW4gdGhlIHN1YnNlcXVlbnQKcmVtb3Zl
IHByb2Nlc3MsIHRoZSB1Y2xhc3NfcHJpdl8gb2YgbXNtODkxNl91c2JwaHkgd2lsbCBiZSBhY2Nl
c3NlZCBhZ2Fpbi4KQmVjYXVzZSB1Y2xhc3NfcHJpdl8gaXMgTlVMTCBhdCB0aGlzIHRpbWUsIGl0
IHdpbGwgY2F1c2UgYSBjcmFzaC4KCkRldGFpbGVkIGNhbGxpbmcgcHJvY2Vzcwo9PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PQp1c2Jfc3RvcCAoZHJpdmVycy91c2IvaG9zdC91c2ItdWNsYXNzLmMpCnwtPiBkZXZpY2VfcmVt
b3ZlKGJ1cywgRE1fUkVNT1ZFX05PUk1BTCk7IDw9PSByZW1vdmUgZWhjaV9tc20KLnwtPiBkZXZp
Y2VfY2hsZF9yZW1vdmUgPD09IHJlbW92ZSBtc204OTE2X3VzYnBoeQouIHwtPiBkZXZpY2VfcmVt
b3ZlCi4gIHwtPiBkZXZpY2VfZnJlZShkZXYpOwouICAgfC0+IGRldl9zZXRfdWNsYXNzX3ByaXYo
ZGV2LCBOVUxMKTsKLiAgICB8LT4gZGV2LT51Y2xhc3NfcHJpdl8gPSB1Y2xhc3NfcHJpdjsgPD09
IHVjbGFzc19wcml2IGlzIE5VTEwKfC0+IGRydi0+cmVtb3ZlKGRldik7CiB8LT4gZWhjaV91c2Jf
cmVtb3ZlCiAgfC0+IGdlbmVyaWNfc2h1dGRvd25fcGh5CiAgIHwtPiBnZW5lcmljX3NodXRkb3du
X3BoeQogICAgfC0+IHBoeV9nZXRfY291bnRzCiAgICAgfC0+IGRldl9nZXRfdWNsYXNzX3ByaXYK
ICAgICAgfC0+IGRtX3ByaXZfdG9fcncoZGV2LT51Y2xhc3NfcHJpdl8pOyA8PT0gTlVMTCBwb2lu
dGVyIGFjY2Vzcwo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PQoKRml4OiBNb3ZlIHRoZSB1c2IgcGh5IG5vZGUgb3V0IG9m
IHRoZSB1c2IgY29udHJvbC4KClNpZ25lZC1vZmYtYnk6IEppYW5mZW5nIFpodSA8SmlhbmZlbmdB
LlpodUBzb255LmNvbT4KUmV2aWV3ZWQtYnk6IEphY2t5IENhbyA8SmFja3kuQ2FvQHNvbnkuY29t
PgpSZXZpZXdlZC1ieTogVG95YW1hLCBZb3NoaWhpcm8gPFlvc2hpaGlyby5Ub3lhbWFAc29ueS5j
b20+Ci0tLQogZHJpdmVycy9waHkvcWNvbS9tc204OTE2LXVzYmgtcGh5LmMgICAgICB8ICAyICst
CiBkdHMvdXBzdHJlYW0vc3JjL2FybTY0L3Fjb20vbXNtODkxNi5kdHNpIHwgMzAgKysrKysrKysr
KystLS0tLS0tLS0tLS0tCiAyIGZpbGVzIGNoYW5nZWQsIDE1IGluc2VydGlvbnMoKyksIDE3IGRl
bGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGh5L3Fjb20vbXNtODkxNi11c2JoLXBo
eS5jIGIvZHJpdmVycy9waHkvcWNvbS9tc204OTE2LXVzYmgtcGh5LmMKaW5kZXggNGI0MzVhYTJh
NmUuLjQyZWQ3YTZiZWU0IDEwMDY0NAotLS0gYS9kcml2ZXJzL3BoeS9xY29tL21zbTg5MTYtdXNi
aC1waHkuYworKysgYi9kcml2ZXJzL3BoeS9xY29tL21zbTg5MTYtdXNiaC1waHkuYwpAQCAtNzMs
NyArNzMsNyBAQCBzdGF0aWMgaW50IG1zbV9waHlfcHJvYmUoc3RydWN0IHVkZXZpY2UgKmRldikK
IHsKIAlzdHJ1Y3QgbXNtX3BoeV9wcml2ICpwcml2ID0gZGV2X2dldF9wcml2KGRldik7CiAKLQlw
cml2LT5yZWdzID0gZGV2X3JlbWFwX2FkZHIoZGV2X2dldF9wYXJlbnQoZGV2KSk7CisJcHJpdi0+
cmVncyA9IGRldl9yZW1hcF9hZGRyKGRldik7CiAJaWYgKCFwcml2LT5yZWdzKQogCQlyZXR1cm4g
LUVJTlZBTDsKIApkaWZmIC0tZ2l0IGEvZHRzL3Vwc3RyZWFtL3NyYy9hcm02NC9xY29tL21zbTg5
MTYuZHRzaSBiL2R0cy91cHN0cmVhbS9zcmMvYXJtNjQvcWNvbS9tc204OTE2LmR0c2kKaW5kZXgg
NzM4M2JjYzYwM2EuLjZmNjE1MmQ2MDM5IDEwMDY0NAotLS0gYS9kdHMvdXBzdHJlYW0vc3JjL2Fy
bTY0L3Fjb20vbXNtODkxNi5kdHNpCisrKyBiL2R0cy91cHN0cmVhbS9zcmMvYXJtNjQvcWNvbS9t
c204OTE2LmR0c2kKQEAgLTIzOTUsNyArMjM5NSw2IEBACiAJCQlhc3NpZ25lZC1jbG9jay1yYXRl
cyA9IDw4MDAwMDAwMD47CiAJCQlyZXNldHMgPSA8JmdjYyBHQ0NfVVNCX0hTX0JDUj47CiAJCQly
ZXNldC1uYW1lcyA9ICJjb3JlIjsKLQkJCXBoeV90eXBlID0gInVscGkiOwogCQkJZHJfbW9kZSA9
ICJvdGciOwogCQkJaG5wLWRpc2FibGU7CiAJCQlzcnAtZGlzYWJsZTsKQEAgLTI0MDUsMjIgKzI0
MDQsMjEgQEAKIAkJCXBoeXMgPSA8JnVzYl9oc19waHk+OwogCQkJc3RhdHVzID0gImRpc2FibGVk
IjsKIAkJCSNyZXNldC1jZWxscyA9IDwxPjsKKwkJfTsKIAotCQkJdWxwaSB7Ci0JCQkJdXNiX2hz
X3BoeTogcGh5IHsKLQkJCQkJY29tcGF0aWJsZSA9ICJxY29tLHVzYi1ocy1waHktbXNtODkxNiIs
Ci0JCQkJCQkgICAgICJxY29tLHVzYi1ocy1waHkiOwotCQkJCQkjcGh5LWNlbGxzID0gPDA+Owot
CQkJCQljbG9ja3MgPSA8JnhvX2JvYXJkPiwgPCZnY2MgR0NDX1VTQjJBX1BIWV9TTEVFUF9DTEs+
OwotCQkJCQljbG9jay1uYW1lcyA9ICJyZWYiLCAic2xlZXAiOwotCQkJCQlyZXNldHMgPSA8Jmdj
YyBHQ0NfVVNCMkFfUEhZX0JDUj4sIDwmdXNiIDA+OwotCQkJCQlyZXNldC1uYW1lcyA9ICJwaHki
LCAicG9yIjsKLQkJCQkJcWNvbSxpbml0LXNlcSA9IC9iaXRzLyA4IDwweDAgMHg0ND4sCi0JCQkJ
CQkJCSA8MHgxIDB4NmI+LAotCQkJCQkJCQkgPDB4MiAweDI0PiwKLQkJCQkJCQkJIDwweDMgMHgx
Mz47Ci0JCQkJfTsKLQkJCX07CisJCXVzYl9oc19waHk6IHVzYl9oc19waHlANzhkOTAwMCB7CisJ
CQljb21wYXRpYmxlID0gInFjb20sdXNiLWhzLXBoeS1tc204OTE2IiwKKwkJCQkgICAgICJxY29t
LHVzYi1ocy1waHkiOworCQkJcmVnID0gPDB4NzhkOTAwMCAweDQwMD47CisJCQkjcGh5LWNlbGxz
ID0gPDA+OworCQkJY2xvY2tzID0gPCZ4b19ib2FyZD4sIDwmZ2NjIEdDQ19VU0IyQV9QSFlfU0xF
RVBfQ0xLPjsKKwkJCWNsb2NrLW5hbWVzID0gInJlZiIsICJzbGVlcCI7CisJCQlyZXNldHMgPSA8
JmdjYyBHQ0NfVVNCMkFfUEhZX0JDUj4sIDwmdXNiIDA+OworCQkJcmVzZXQtbmFtZXMgPSAicGh5
IiwgInBvciI7CisJCQlxY29tLGluaXQtc2VxID0gL2JpdHMvIDggPDB4MCAweDQ0PiwKKwkJCQkJ
CSA8MHgxIDB4NmI+LAorCQkJCQkJIDwweDIgMHgyND4sCisJCQkJCQkgPDB4MyAweDEzPjsKIAkJ
fTsKIAogCQl3Y25zczogcmVtb3RlcHJvY0BhMjA0MDAwIHsKLS0gCjIuMjUuMQ==
