Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27540C5DF94
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 06:06:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D51564059E;
	Tue, 25 Aug 2026 06:06:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dQhdSc9A0t2I; Tue, 25 Aug 2026 06:06:23 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787637983;
	bh=MCu09zz3loXW3Y6fntxJCDZMltRk9+jQ3x7bIzgRckw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WIONU71LJQyBAz5KvrH4rqjQqyz2D1HtWr4mxznFUGoo0w0IeF8B479/NUtzeXFcy
	 2QnNr3hjoKutsYKV9ESMzvnGoBIyfRIRtBQde5BRwR9tKW32efhvKHi8WD7DoJtZvJ
	 yLTV8ZjFktj49ReA5430695KfJwH6gf80bYymY+xDANAJcGKrPg1G91mYbz908hRHP
	 Tp24GW2hMksHoxvmhbUbaQVRsBmiIvyCQhMl8gtYiINCleAz2bGSvRqHs6cUEgdm5k
	 CTXZFrBz/9FUJiepdBmdIWQLbB5uwi5cJD3Q4TQOR8Tn2yLdztu71FhZ1Ten80rZy6
	 4qfR1i6NrR1wQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D7E83405DD;
	Tue, 25 Aug 2026 06:06:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id E82CB279
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 06:06:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CDAC380C80
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 06:06:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TZo_v6Dx_dol for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 06:06:20 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::5;
 helo=duzpr83cu001.outbound.protection.outlook.com;
 envelope-from=frieder.schrempf@kontron.de; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kontron.de header.i=@kontron.de header.a=rsa-sha256
 header.s=selector1 header.b=SVDQ0h1A
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 38C7A80BA2
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 06:06:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gEsE5XoQoehjeoR9Tp2gd28/dSqHQsvqH3ETTwvrSidwCX1Mu63MM8Kbrurd7FsM4/vNCK0xpW0mKFgCKyKVEUw3yM3QZVU1xMAeuchIyWHjNurWSCPrgLMdxDjIlaDfeLLMN1dPaDR+9mBjQ8IgCoCnCFJNdDdAuPCaCZM5SJ9qgaxqq3NHoZJ4WUu7NHM0JGcPgHAnbLpkaxjfGDlM2Ks+sdMoF+viv0Ab05vAd1vtoIEjFJFtl0WPPlY0tVin+a+JDMgfFBmRRdKZDQvFqrWGhYgI7e+QM6Zv90HEeqtf29ZkRSOfC1zMz/owrSk/JNB2BpnSHCJvW5BQ2+3Q8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MCu09zz3loXW3Y6fntxJCDZMltRk9+jQ3x7bIzgRckw=;
 b=ofQKhtk0ROonVZY/glOUW0hB6oC7HxGOTgp3chwffH0KS9JrrN0G3LAUHDIaB+MPlBlJ0jLH3zhnj1B6uTSdZCSyeEsEUTPs+ijeHv1eS5c2gROTsj0Ya9QS2Youi3QXuaEtrvrbHg8gkWEVtcZgO69zm9xmyzaxnHrPQ/HwsMI54ktP0rmzJBqAzvPOYByDE0Kle0vK9QDGLc9/8rvTKyiHaOaQbb8pYuFxEZfBwNEZgYIiSjWwMAg3PuniJbGg2gZ1dN6yUJBxfEiJgj09TjuOR7CLVzBuYNbDE2UkHWioE8wAErIegBGDHB2aaoc6eMDfayukqqyreXtLuqCI4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kontron.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MCu09zz3loXW3Y6fntxJCDZMltRk9+jQ3x7bIzgRckw=;
 b=SVDQ0h1ALn19FGM8dqKkt4G75y6J7I23nYhxK02Crx+q/o6Cn3eT54mBnc3IeAgGeuxvtXDeV01Znm/c9B/qk+qijLx9B3pvF4lkbseGgQkmGjZKzilt5ClSgaEHlhaSDdNJyWeo8iVdAbSRuW1YOaonFf4G0izjScSGShHy/TltIsPz8Nt07doYoPEZohRT5eWh8aFV8NchNjwvLcwKM4bvLpWQqfjVGnH9xhmYGULXYSSrrri9b4r4LIhiMUlIA8/WhqcDVvrSCy6WwSo6jl8xSa9oLtnoSCSjXDhYC0OsgIUaOSik0B0cnCMSivGUv2pWnOUm3ySBuJcJaQZ1jw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1fb::23)
 by DU0PR10MB6132.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3e7::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 06:06:13 +0000
Received: from AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a276:4ad7:962:da22]) by AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a276:4ad7:962:da22%6]) with mapi id 15.21.0339.012; Tue, 25 Aug 2026
 06:06:12 +0000
Message-ID: <3c3d772a-364d-4346-9503-d2e77d8305a4@kontron.de>
Date: Tue, 25 Aug 2026 08:06:11 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] ddr: imx: Allow to call ddr init without logging
 failure
To: Fabio Estevam <festevam@gmail.com>, Marek Vasut <marex@nabladev.com>
Cc: Frieder Schrempf <frieder@fris.de>, Stefano Babic <sbabic@nabladev.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini
 <trini@konsulko.com>, u-boot@lists.u-boot-project.org, uboot-imx@nxp.com,
 Simona Toaca <simona.toaca@nxp.com>, Viorel Suman <viorel.suman@nxp.com>
References: <20260819070758.51350-1-frieder@fris.de>
 <20260819070758.51350-3-frieder@fris.de>
 <b8c844ab-7ea8-4044-95e5-edac173b3c9f@nabladev.com>
 <a8be2bf7-aafa-4e8e-9685-5fa100941805@kontron.de>
 <cfe8d0e1-c652-408c-bc47-0ae96dd0a65d@nabladev.com>
 <c81db5f1-600c-41a1-91d3-7638fc4d3d58@kontron.de>
 <b528b642-5010-4843-bfe1-d24e8b709876@nabladev.com>
 <fa652a2f-addc-47a4-b89e-755aba42509d@kontron.de>
 <83ee9efb-e09f-45d8-ac0a-cd9b2797c513@nabladev.com>
 <CAOMZO5CbpA0cmFVsSXuGQcYQ7azRXK6XKNYgM4s5b4shGoD7sA@mail.gmail.com>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <CAOMZO5CbpA0cmFVsSXuGQcYQ7azRXK6XKNYgM4s5b4shGoD7sA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0370.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::16) To AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1fb::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4277:EE_|DU0PR10MB6132:EE_
X-MS-Office365-Filtering-Correlation-Id: 82717739-297a-4434-881c-08df026ef720
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|23010399003|366016|1800799024|10067099003|4143699003|56012099006|11063799006|10063799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: wagnwJytE/3gczHvnXShrjH6YR0ooQg0pGKr+O4Tu6AZ6T69NVdUHSTsjNZGE4A4zJxm/oU4Qb6fpzOZUkzE1r9uo5q5bjTZhFHYyzDTvKfHN3LnUl3cOcYh1T9gfnmmnmHTxkOU1mLEj5NYUbQQFTaZcxc8/DQt0ur65eJsIrB/kHRmLnkKPi1rPGlxqItQgW6O6XWLjkTHZ2Ay9EFTTKE/22vYyrgvyw2zZGv3mef5tUFST52gSgjXZ6NGp7dmbX009xHfHqlnyPr7pXd2/PZuxfG96efBqxq//Zaoc0tpMc+CMrqre7/vsgrnexr8Xf50pWGA+zgNRiw9x/ThG6kJNvg2yH0S793nRGOZJ71qIFSNXh72nxEtyGQs1fPizMbTZjGd248tZmPStrfVUwdG3lTwJGONnzc08WEDCnG6YLfJm5s1kSyFdJdlTdeLH4djoyrCbKtG8eyDfnaN3DNO17XSzMclcM4GVB6Hii6o5KPb5cEMRBkv89KNcT2LNS60eWT2p77N/a0Z4VSWH+1sDnxOEOOj18rbHV4ua2wvmS8VERTV8md51wQzr1NmOgTXgRqGfzYFnsvgJNq8wgOvA2UhLbvAaT+GnQlWOAz9ZGaF/d5J5B6pzhUsenOr
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(10067099003)(4143699003)(56012099006)(11063799006)(10063799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QjRVcnZHSDNwZXNMTzNaNmVMMXFsWkFaMU04cWFsb2Q1N2poM29rdlhmbkFO?=
 =?utf-8?B?K1ZMNS92akV4VnpFTWhBajdpYkxKSFNIeXJnc09JYVhxMmJVU3hEK1R3dFNK?=
 =?utf-8?B?TDVFZFo0aVoyV3pCZkxLZnRlNTUvODhrclV3NDM1WisvZmFTYlNNdUNYYlpu?=
 =?utf-8?B?dnE2dnNIaTRsNFVkSmhuM0ZpL1U3b1pmSlJDZjdmNXlnenZjVnhGZDhTK3FC?=
 =?utf-8?B?YytDbFJRa3ZxVjRjbElXaUtCWWFuckZUQ2U2UzdiWFJHVkZiZ0dGZjhsVXEr?=
 =?utf-8?B?SFVrYmlmSUtJYjVzcTRMRC9udXpleWNjUyt5aXJOY2tHSjdoM0RhRVJzWmpj?=
 =?utf-8?B?Z2xuSUNINHhsRy8xWGx5MmVJZDRDbFFDK1VBelkrVmMyMCsreGlZQ1dpNFhP?=
 =?utf-8?B?Qit1S1liU1RVN09aaVd6czU1TWYrRXYvNm1tdStBOHQra1FnRkJXYWo2aUtT?=
 =?utf-8?B?ZTRZTk52RWxHaUNyN2NlbjM5NEJYRWc3Y0RtUW1CVVQ2K1plN0dnS1lieWNi?=
 =?utf-8?B?QktEWnl1QmUxSkVieFY2UmppaHo2QWhSY09HK2Rnd25RY1ZXYVVxdlN6cGFx?=
 =?utf-8?B?Z2NPYTJsWnp1SEROVXJIN2dqVlpRYVE5MUlHZ3RCZVJqdHdaTVZaTmtJWFVY?=
 =?utf-8?B?djZEL08wclNDeWJJMmd1V2I0U1VNcEp6d3N0UHJqTnVSMDRCNVdhWktOWUdu?=
 =?utf-8?B?MXlFamxZRG8rQWxmcWgwcDdIdzF1VDF4OWhCWHVpdm55OXZSeGZsRDAzWVg3?=
 =?utf-8?B?amNiZ1k5YTNOYXdBOEc5RElPcjgzQmwwNnhraW9pajYyQTg0aEtiTU1PQ0or?=
 =?utf-8?B?WTFwVERHMUludDhMM0EvR1MwMEZLV05SVHpiSHBWTVVNS3BTMkg2Y2hlTDhI?=
 =?utf-8?B?c3lybUU0Vk15VStvcEtUd2ZjRER6OWJScVhFcVBFaDVaMGV0cTc0QVpyOHh2?=
 =?utf-8?B?ZEpHYnRDR05tdlRIQ0xURjVOaFhmVE4ybFk1cE9OVit5b1ZMOUpjYTV6WlRH?=
 =?utf-8?B?VGpjK1lETktVWG1DbFVwR1NZcStmazRzVFdHT3lxU0FaQmhib2JRZ2V6MG45?=
 =?utf-8?B?c244NXYycDhTb3dVcFdrYmU0d0JJRWt0SlZIUU5EcllMQXNHVXlEckV2NXVS?=
 =?utf-8?B?N0dCTmFVcXA0enZlbVl3RjNuc2c0MkVTRkZqYkhMaitPR1lOY21DeHVZbi8z?=
 =?utf-8?B?UUVaay9rd2hFMEQ2SUprNGlMNE9nTTh5L2V1aDExeERKeVgxbDdMUlh0Y1Y1?=
 =?utf-8?B?OXZvdnhJcTZjbnpDN3NZSno1SGJlS1VYNTJiK2RDV2FJOW1JS0JyNTdLMURM?=
 =?utf-8?B?UnFLQk0ya2YrTjM4cFVlYk5kOElISmN4ei9NSFpSY3NmQ3k0QnI3SDBqWmZD?=
 =?utf-8?B?TTJkd2pKY0RSL0tCckpIa3FaMDhrdDBBU0FLb1JXOWJuU2pqam1selFEK3Y4?=
 =?utf-8?B?M1pzZXo2U3lQQWRsTGl5VS94MjZaRVhtS2RCOHR2am1iUTdjeVUzRHhpSEht?=
 =?utf-8?B?SWhTT01SVGtBeHFwZ1ROTkhxKzBhRHRrbE5DbEp2Z09kcXRHYnZqQmliRzV3?=
 =?utf-8?B?ZDB4WGZLR2E3MU9lUW0zZ2VqQUs5alZEYnB1SVFYYVBMQTRGWThMUm5OV0Vr?=
 =?utf-8?B?dnlOMDdIVnJtc1BaUHBROE1RckxpUE5EVXlqL3J1NlM4OUk0RExLdXdpTjNH?=
 =?utf-8?B?Q1ZFaTAxM0swc2wrYXY3SUptTkhuaHFWSUV2ZWR6b3Z4c2pNQWd5S2U5aE9I?=
 =?utf-8?B?VGRJdnYrdEs4eUhkMC9DSHZ4bTFHR21qcWxKcGExWE1tWnZDVUpaNDFpREVM?=
 =?utf-8?B?Qm93K1dBTHJxNVlObGpad3MzMXd6VjhURXcyT1NCaTVuRTQxcExsRXcrTHlZ?=
 =?utf-8?B?Rmh0TkFNWkIvVGcrcVorRUJuTVRuMVpTa2syUU1wdXo5SitVcnROaHNTVjJl?=
 =?utf-8?B?TFdTVHZSMDJrcWExT2dxcDlwOEU0RkxMN3ZPa3JMS2oyMmI4OC9UUThRbDRi?=
 =?utf-8?B?ZG9CR2dCNHl0czF3NTFRdVh3MWNiTXM3U0NkazNzeWV2YWh3R1JtM0wvZnhk?=
 =?utf-8?B?N2t3cmwxL2RNSEdrQ3Mrd0FWT0w2aHFOMFNPT2V6TytFTys2YWt5SHdJWjk1?=
 =?utf-8?B?dXJvOExQcjRXRHZ0bzI5VVpNZkxTSDdOek5qV09JR0toK2RRSzRmeUUzMlFP?=
 =?utf-8?B?TWRVdWJPNFY5eFdCanMwRkVuaXAxNnJ0dFR6NGNBNXkwVjhGeUNyU3o5Lytu?=
 =?utf-8?B?UkZIMFF0MU1yQ3BtR2hmbDJsL1gwaE5rcHY0UGZwS3dJK1E0QndGNDdLNHJa?=
 =?utf-8?B?VzI3T29GMGRtVW43allwdkRZVTlxQmlycEhwOUVlUmpxSS9wN202d2hjengr?=
 =?utf-8?Q?W51BXU2BygAAEkzU=3D?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 82717739-297a-4434-881c-08df026ef720
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 06:06:12.7410 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P0AH+V9sBV434M6NX3PanIAB+6sDMcRzlg9QIzms4kNnv2ZGo9+BGLwzAT9n7XvVSApi1Bt2CN4HBhRP+X3kkgQWHtpManR8qy/yebLrvzc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6132
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



On 25.08.26 01:28, Fabio Estevam wrote:
> On Thu, Aug 20, 2026 at 11:25 PM Marek Vasut <marex@nabladev.com> wrote:
> 
>> Why ? Init the bus in slowest mode with widest bus settings, then try
>> MRRD on all available DRAM chips, then figure out which ones report
>> valid IDs and which ones fail the MRd .
>>
>>> , so I'm not sure if there is
>>> any benefit.
>>
>> Generic solution that surely works and does not guess the DRAM size.
>>
>>> Also I'm not seeing anyone doing this kind of thing. It
>>> might be worth looking at, but my primary goal now is to land patch 1 of
>>> this series in order to fix the regression.
>>
>> What regression ? (I was not CCed on that)
> 
> I think Frieder refers to the regression below (patch 1/4 of the series):
> 
> https://patchwork.ozlabs.org/project/uboot/patch/20260819070758.51350-1-frieder@fris.de/
> 
>> You can (=should) send bugfixes separately.
> 
> I agree.
> 
> Frieder, please submit bug fixes targeted at the 'main' branch and
> cleanup/improvements targeted at the 'next 'branch.

Sure, I sent the fix only as v3 and dropped the other changes for now.
