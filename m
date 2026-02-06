Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9813CECD9BF
	for <u-boot@archiver.kernel.org>; Fri,  6 Feb 2026 03:11:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1E648341A;
	Fri,  6 Feb 2026 04:11:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="N+iTCbj6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2DCC83AA7; Fri,  6 Feb 2026 04:11:10 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C947F83015
 for <u-boot@lists.denx.de>; Fri,  6 Feb 2026 04:11:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kOuIDLh2eKV5Q9Pu78211oGO7Hm6F8jbG/SPcBX2Jky7XVonRp/dlDyEJ+YmWY2/sHrgCop/pSDoso3lJMF543dzgflzWxNn8p+Tnzf0vkxNi25ClcxIfbyonwIq4QfwaVspkBtyIBtHI3wGO6RU4pWgrlyKsm1pFeNVoP7bk5h+JMJqmZEP2cihVH4Wxd+SK+Riso5DkwORZWFoIMaa0ZD80RLCoRTDqAFj3PSczYAeC02CUqV4+0qpHWnvUCrpxSEUh/T08U3wmZUTwl8Y8IoTcLNZxXe6SkGQuuZOyW/oz8wVi27sfdircFrN0EZfmVYhYYihlGeDdOkWkv04tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aU1SSIi2nseN7XFzHo27AnIiPQXDVQWjQEL5AKmzvu8=;
 b=dlbKCNjMJgH8TfvT7ElAnWGj48/GRfdlGJeAi3r9zimyJU2lmuB4aldGd0kzmbj/MGk+wWoz30IjNv8IpJqLCbn71PmGWxOBIYFdz5ZE6o1oXfFyfXnmd1+mU0DY4iN8HsFVpA+BocNR0aZQWp3Y/Sm4SVtQoWiSW8CkFvJd5at35tCY2Te3UwDiE+//UHRjidcyZPkPNP4k5dD93pbxjAq37/tTFwA0T8IE43S6W1Aq5ypst/aMOHVGVJVhLv7rv9YnTLKPkNDhJmMzo54GEvFY2bMgdSUOXkpgJhkJ/urPO+ws00kEh03tC/D6lshAPEwhaxWron66U9DhmREFCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aU1SSIi2nseN7XFzHo27AnIiPQXDVQWjQEL5AKmzvu8=;
 b=N+iTCbj6h6i0+mWUxv+XekBXvz06JOf6J+heQq2ApBE2YNLFfVImheZNbTkCwHO4rSRs4QeLimVyVQ+VRm8xfiwcWLPC7Z7+m5T+TwNcq0ITZnZQVZl4/lyv2QokyA/ocvjFIcpk1UzEoFGu6rbUcacfqTY8S8LDc29ojX6NKzCzDdvSKcWPNtQy+a2gjEpwQLlaKVZYNTI/gZKRw3NDOKzVYOCVye0iZFfVqGRbHdRJ4xTtRX46NJGd1FFAxRbWUyyT11X785OeAMNm0tCmneLroWZuBPgSiPBRK4zQ93M1ioSScTsIbPdKG/ryB+3coGUFE2gvVm2tsu8gkZca7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS5PR04MB11419.eurprd04.prod.outlook.com (2603:10a6:20b:6c4::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Fri, 6 Feb
 2026 03:11:05 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%7]) with mapi id 15.20.9587.013; Fri, 6 Feb 2026
 03:11:05 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 06 Feb 2026 12:25:42 +0800
Subject: [PATCH 1/2] nxp: imx95_evk: Drop init_uart_clk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260206-imx9-board-clean-uart-v1-1-3965b4e7f79d@nxp.com>
References: <20260206-imx9-board-clean-uart-v1-0-3965b4e7f79d@nxp.com>
In-Reply-To: <20260206-imx9-board-clean-uart-v1-0-3965b4e7f79d@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Alice Guo <alice.guo@nxp.com>, Tom Rini <trini@konsulko.com>, 
 Ye Li <ye.li@nxp.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: SI1PR02CA0047.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::15) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS5PR04MB11419:EE_
X-MS-Office365-Filtering-Correlation-Id: 353dbb99-2711-493b-17e9-08de652d5dd1
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|19092799006|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TXlIRVpWNVpEbHlXbXBOeHI2SjNST1N6YVFWUGxFbE9nNnJaRVdqRTR3YjE0?=
 =?utf-8?B?dkRIYk51cnd6V1BTenc4WDc4K0RlZUY3WGVmUHFXaUhyNC9kTXdBQ1RDeng0?=
 =?utf-8?B?d1BDeFpVM0ppQ3YzM1d4QUU2bmVKZXZDblFmcTBYUnF1OFpJMWxoSjRDZEh0?=
 =?utf-8?B?czhCZnNpb3pyUUk2dDBGS2hGdExOUUlKSnZLd1VDRzJmZ1dveXlkZ2YySU5E?=
 =?utf-8?B?Ym0xTVFLQTB3OXQ1UlFXbUtyQ1VzbmNrbTNxbkZRWkpYV2NiU2xmaEFWTlh2?=
 =?utf-8?B?VHdzRnRseW1PSmFsVUw3eko2MkJoV041NEQ1VXhXOUlZOUtDWTlxRktlS3NN?=
 =?utf-8?B?TkNLbVFpVDF2R2s3TE4xb29MOEFQYzU3YUxXV2VEdXNxQ2NyazFNTXFqWmN6?=
 =?utf-8?B?Tm1Ha1pZS0J1QlppQXhTS3NhK0RmVHBuKzFyUW03WnpHUTFwVjZNVDN5L0xa?=
 =?utf-8?B?YUxkcEZKNGNvQXZjQ21uSjgxc1JKa2dobkl0RXNiZFZsSjl2cDJsb2gvYjdI?=
 =?utf-8?B?ZGZtOTBVRXk5S3FmZGwzQk8wZ0Z6MnZyYVFrNWxMeEJMSGlLN3V1UFJycnRE?=
 =?utf-8?B?RU56RnBYeVROdytadFA5aFo5bzBQekg3Zit3OHltaFQrS2k3U1BUSjNxbEtH?=
 =?utf-8?B?NFYxNE5HYU9XTkt5RDVYcGI0elZONDc3SDY5d0U2MmxEeG1YdTFkZ0p4NXNo?=
 =?utf-8?B?WTN1ZGlBU3hhT3AxL2EwQmozQ0dzMCs3M3Z3M0JEeFNPNUF6K2UxTU1sejhv?=
 =?utf-8?B?emduaU1Sd0lLaC93d1BiemduMDhLMGlTMHFFaHU3QXlZMmduQ0I0WDk2dVBO?=
 =?utf-8?B?T0hsQ2laMThDblFoM1hBWEpQU3UvSXFMdlQydXlhdkZVak5malMwRmFPdFVj?=
 =?utf-8?B?dE15S3pwZitkVVV0L2dLQmh2Njhwc092RHQ3U2YrUUE3enNXV0h0VUNiRTlm?=
 =?utf-8?B?cVFwa1B3Z2k5emkrY24yc1JSM09iZk1QRUw5Zm5ZK2ozN010WlBvNno2MEFn?=
 =?utf-8?B?c3ZCTVVmV2t5YmcrYXE1eWFQdEJVc0hpL1RuWVZWaFJRMEdjS0JrbndLbVl4?=
 =?utf-8?B?TWtoaFcyd0dtVThTNDZ0OFNoa251Zk5RamtDNC90WVlLQnROeXFpV0JJOXZC?=
 =?utf-8?B?bm53MVpWY0xkZXpKa04rTFVJL2U3SGpwSjdlaGRNSU9RcFkrSnowc2VjMlRi?=
 =?utf-8?B?dHM5ejMxY1c2UkxTYVhCdkkvb2ZnSVFqbG1LbEdMRXBUT0RVMzlsdVdDSkZE?=
 =?utf-8?B?Y1hDL1ZkbS8zeTYvUncwVVh1d3h3L1RFai83djBnN0xYV3ZvTm1qNXBFMklm?=
 =?utf-8?B?ajRZR0F2MzlYTlMzOEhJUXMyajgvK1RqVDZXdWxhL213SmlMWjdWbVJNMTBU?=
 =?utf-8?B?OStlZGNBU09vaVhyTGtXSmdMaVRQZVRjMGxJU1F5Rnh3UjBXcHM0akVRTzBL?=
 =?utf-8?B?bGhlZEtnTmI4dTRVMlhmeUx3dUVKRVFUaG05alQ5b1FTYlpOT3dVMmZWNVRy?=
 =?utf-8?B?d3I4VWFXckY5emRrTXBtODBjRURVaC83QVh0TVcxRWRONE5TZnpuRFFpRHpn?=
 =?utf-8?B?ekM3RjRyZ0JlOVlMWGRRbzVpU0ZIaXV1L0UrR0FQcjhwRHNZYzRzemdsanZw?=
 =?utf-8?B?MkpyVXgvYUVCN2tFdHQ0SGErVjRmSU1XL3JkR1lRVWdaL2pkaE9RTkVhTXFw?=
 =?utf-8?B?dnRKb1NEN3I1ZWs0dzZaME55bUpBQk5SV2x6Mm54eE9OeUFuNkJ3bFM4NWNh?=
 =?utf-8?B?Y1hpNzlvdDFiQWh1a252Mm02NStZeStJZjBsV1FTS2RKK0RzM0ZqMVBJZ21C?=
 =?utf-8?B?Q0pQUEVVc2VqS21DbnRWOUhkMmUvM1ZRZFJLT253dWYwNzNTYWc0aHZ2Sm40?=
 =?utf-8?B?b3I0Rk5BT3J6OUpFc3p4bmRVNDZlRkRkTkE1Yy9vT1ZTUUNqZnE5aXJ2d0Vi?=
 =?utf-8?B?ZkQrRG5UN253MGg3bmM1b29BZnJ6bkgrcFNTcEs3UEs1WTdkTXJtUHV3U1NR?=
 =?utf-8?B?N1BvL29BK3VSNWxVb1BPQ2lmV3o2RDhhS3dSSXVqWkhDS0dxOExud2hmM0FM?=
 =?utf-8?B?enVyOVdRUzJtOGtRQUlTMmtsd0J2MG1uMkYxbG9QakQrWURqbnRiR2pxb3Nt?=
 =?utf-8?B?dExIZytLOVJWMHFMZ0RGVklNUUFscXNEa0ZTOHBhVjZybldrVUttSk5KT3Nv?=
 =?utf-8?Q?Ob3PV+Fbr8+w//1xXWnDAZA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(19092799006)(366016)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWRDWkJicWFiZzUvdHRiaUlaZ3owN3l0ZVlHWlNZQXlhNXVJSWxOb005VXZ2?=
 =?utf-8?B?Mm9uVWJSMlVrcGZqR1luMkh0dGxrY1ZzNWhhOHFub2xRQS8rNnRTUjlqOS83?=
 =?utf-8?B?WlVtUkRNbjFLcW04L3RTdjRkWlhJaS80NVAvNEk5RmhJVFpnb29GT3hMVHFT?=
 =?utf-8?B?S2NZdVhxVlJOM3VsS0JLamUxS3l0OFRRV2tEdmFXWTBXUkpRTVdjYXFTT0Y5?=
 =?utf-8?B?QnVwdkpVaXRPc3NISWZMNHFDMklXNGQrL216ZWh5ZXU2YnpuSkdXaTdnQXQ1?=
 =?utf-8?B?NitXNWRBLzdYc3JKeldzYTdYUUhvVUJsSytPRUtlbGpwUVdudFhheml2VFFJ?=
 =?utf-8?B?bXdnUFlYdWFjNHdzcHIxZG1rRmFESHhxejFKTEp1UmRJZWhVN1RCaFdESTA4?=
 =?utf-8?B?Ym1FQXFKaGYxOWlRZTNURmdzbXp5c2Y4QURZQzVxWktrVURRZzV0czdHa1ZK?=
 =?utf-8?B?NmMrR2NWN2RaV1UraHl1ZksrQmlsZ3dGbWM4TE9UNlB6d3FWV3R0cHNTci9M?=
 =?utf-8?B?NHo4ZXhCUGZyd3VuMGJJYTNhR1JIakd2RXU2L1pQZ1dJcU8zWVpmZ0JiWUM5?=
 =?utf-8?B?dVZxTys0VWVjcEdaY3VsNFFqMzRrcDI2MW9PNUpObDYvV3A1c0s2ak5zWEda?=
 =?utf-8?B?QVFkOFNVVlRoc04veWdnb0I5Q0xYQ0JJL0FPSHlXRUhNeE5NZEx2eXYyeVRG?=
 =?utf-8?B?UFQzNitBc3RCaGdVazA0S01WWHhZN2ozWTVURVVXdldGQ2dsVlR4dFUybkJC?=
 =?utf-8?B?Q3VaQzkxS2ZIaUl1aldOTkVWOVRrWmhCZFVxQUd5Z0NrODlqR1UyOGdoOUU3?=
 =?utf-8?B?Vm85eEtUSGU1dGlmNFZCdjhVU3I5VGNhYS90d1lOVTIyR0VBOG1aNmtJTzk3?=
 =?utf-8?B?WnhXL2UzUnc5S2dNRnFkSGd2bDJPNjc0d0pNc1ExYnF1L0xQeUtNRUtrUFZB?=
 =?utf-8?B?dHRYTE01UTM3UWkrUm90bm9GdDRoYk1CcTcwUFE0YnhER09BSXQzcTRrdm5w?=
 =?utf-8?B?Z2o5WUxBTXZKcEJ4eDBualdxQmJKYXhONnQ0UUtzSjFzY0cvZUxoM2FabWVQ?=
 =?utf-8?B?LzFrQlJhbGpGWit1RHp4Z0o0Mzg0ZEJIYjhwT3Boem5SVEZJV2d4ZUVrZ0l1?=
 =?utf-8?B?WkNaNHVyN1puSDl0NWU2OHFZYW1hNHp2T1dZSDRxdERVKzBWVUh0Rjc0QURC?=
 =?utf-8?B?MG9KSmZLL2psNERhQVErbUtYWXhQQS95d29McTFQSk5GK1hnL3F6blZvaHo5?=
 =?utf-8?B?MUJHRy9HZCtZcURRZVRVeVVTOFpDaTRVbzNFdncyOFlvT0V5YVlXSWw1KzF0?=
 =?utf-8?B?V2VPNDY0dHNFVldIVG1DTlRCdzZkdWoyRHVRUXQ4dVVmWHRmcVBHU1dtWlF6?=
 =?utf-8?B?QzJnd3pIUmpSZmJqaGFxMHRiL2hmaWR3OENIM2N5ZzNVcHM0cEYyOHpMaXRP?=
 =?utf-8?B?dWJjZVAyT1E5cHJBd0pNT0JtUVltelIyM2JjK1BXWXhsSlg1amlNWktOd1NF?=
 =?utf-8?B?SThycGVkS0VuVlVBQjl3OTRYbWhNNzhBM0xWT1pqbzRta3p6L1hTVThxdUdC?=
 =?utf-8?B?ZisySFd1dDlEMnV5TGVIOVYvayt6WHc4RExmL2NEdURRMHdlTXg3ZlZVU01T?=
 =?utf-8?B?bXJtV3hGOHhZQWpVdVVKeFRJeWVmWUlMRkNmQ2plL08rc0dFaTRnQ21ESHY4?=
 =?utf-8?B?L25yejNwUVRxME9oY2p3L1lYNWk0NzJna200S1ZERGJqU3AxU2ZMOEVtZHVl?=
 =?utf-8?B?OGN0NHZGMjh5SEoyTTB5VHhYQVRnRFVsVUZKeVAwUUNrQ0NiWC9VZGdqa2Vy?=
 =?utf-8?B?aUNtMkd3WlQ2dDMyRHhMY0xXK2tTODNOVC9rSnpFd1pGUkpwdHo1UG1IanlN?=
 =?utf-8?B?TERYU1VCOHJLVWYzZmljbUNkeHg4WDBubVZPaEJCaDZ6N1Z1SUlOSDFQMlVW?=
 =?utf-8?B?Tm45ZU1zZXk4N2dqandjTjFzWjVJWEJiVGRuWE03d016R0dacENkd285aW1O?=
 =?utf-8?B?a2p4eXJyaGRwcTFKN3NabU9Idy8rN2NmdDdtK0FuMk5xV1ArcDlxQyszR0xE?=
 =?utf-8?B?NDJocHFoS0V3cC9XRkVKdmlJd3kwZEtwN3dTcXJjZ3RqRmNXQVZxNmppK0dL?=
 =?utf-8?B?bW55cm4xOHEwQ0crRUVyWkNrMW5BQnBqdTFtL3p6T2hBaEdraEc5VHZEVnRZ?=
 =?utf-8?B?RklvYzBqYUVUa3hkWkd1dmk2b2NoOXlER0w2UjRYMXpoUGJEbWJ2UEV2U295?=
 =?utf-8?B?OWIzaXV0RFpJWm50M2hKbkwvdUpjQTNILzlQSGE4Q0tyU0MvRi9PNEtLVGQz?=
 =?utf-8?B?eDJreDN2UExiYUtQSFBIZGtzcXhyTXVLRE5YOFZzS0tiaFJNeG8vZz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 353dbb99-2711-493b-17e9-08de652d5dd1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 03:11:05.6527 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b8YkIzVA1hlPvE3lkP9qUNnZO7WFdSKLc4GRxMDvJHGpaubEMYxFHT4JVENXKBkHaLgJj7oqkpnEZu5hEFQpXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB11419
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

From: Peng Fan <peng.fan@nxp.com>

Rely on serial driver calling clk_enable to enable the lpuart clk, no
need to do init_uart_clk in board_early_init_f().

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 board/nxp/imx95_evk/imx95_evk.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/board/nxp/imx95_evk/imx95_evk.c b/board/nxp/imx95_evk/imx95_evk.c
index ca1d916deab..9cb69543f0f 100644
--- a/board/nxp/imx95_evk/imx95_evk.c
+++ b/board/nxp/imx95_evk/imx95_evk.c
@@ -9,9 +9,6 @@
 
 int board_early_init_f(void)
 {
-	/* UART1: A55, UART2: M33, UART3: M7 */
-	init_uart_clk(0);
-
 	return 0;
 }
 

-- 
2.51.0

