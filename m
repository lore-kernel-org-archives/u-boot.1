Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28871C5DF7D
	for <u-boot@archiver.kernel.org>; Fri, 21 Aug 2026 16:06:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DDAE9409BA;
	Fri, 21 Aug 2026 16:06:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mpVgIzXcqG76; Fri, 21 Aug 2026 16:06:28 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787328388;
	bh=7+uS4q4dcrL0rXSBXdy6qLMFw5C70poNOwyY2FK1krg=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tSscNMGz4XRxrazVNnrJurRjJvzmUcMC4a86q5SNYd6f6cInJbn4JOBBGeTWqVoKy
	 xpRbY11U8D1mcxbWdyMVJhBW22gcYpm9gP3D/CWsf+GmOeUvqSKq0W3gvfmqznz92F
	 cDMHsVejJXyY6bWF6j2vfcTxqQEsP/9GoVwbo7ss+ipJwcfR+6i6ywaySjyLXq6Dmj
	 1pks3kBlYJl8f9ynZHY2zlHFHjcxuSGiQ3Z0K3Wx9jD2fQCUlrawYRHkHEc1+YTrGo
	 oKzqutN1QgYF18f34ydoGn5RXUdJwpUC+UlQcUEq6RNXgRgnlezZBcuz/eKYg1AMUj
	 F3wo5D/EZeMUg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id F3414408E4;
	Fri, 21 Aug 2026 16:06:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id D45B9336
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 15:24:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B966D40A15
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 15:24:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mJmtRi5KJy4W for <u-boot@lists.u-boot-project.org>;
 Fri, 21 Aug 2026 15:24:20 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c005::5;
 helo=co1pr03cu002.outbound.protection.outlook.com;
 envelope-from=jamie.gibbons@microchip.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=microchip.com header.i=@microchip.com
 header.a=rsa-sha256 header.s=selector1 header.b=YE4trekc
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c005::5])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 51D1F40A04
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 15:24:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RCsf6GPUvwtOj1FgDFuMiAbpfShF/uZcKsbPkjXUT7yRjAQNrntwH1GJ0451uIMHYKdt0Gai+k2RFNPj4OWkwyCpU6iV8LRD0oakpOEO2VeJrRU0409JAk+VRt6Gz2Dzxn/j2+3JZG9rsLo770up18xS8MxNcYwB7BDbLr7mlh8vDIcTK2ONaYyf/6q6/7LPkKS0lwVUqSzhOmlkZwIi8QFDJfN0z0OJFLC6tp9+lLA9PiRpfkjAnwiNQl0v9xOb1mpz/JqfJOUSHC5c8oKGpc6jIq9Y3AeYEOekH0fsj8b1TuU8qNVNiNjHOWMngsS+RGjygbCqKOi4mqpQ6axWhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7+uS4q4dcrL0rXSBXdy6qLMFw5C70poNOwyY2FK1krg=;
 b=bWuIBr1wqBcIjo/ab7sVLmRmfN4DfNFHOBOCkpmTba/H+v/0k+S7eRi1K5thhz6PxsQtn/wglhDUkQ5ROwDQwTl7oPgq+CzILSMUIiowrwCMiQUGUuGPxaBSutXhF5zk43y9vBuGyNH2SLjB5r5r6daf88mUixn7Aarbucg+usDOhseQVh6eGKvzW7h0WiDh66ji5hThvdIQCHh26jaGGcFiMYYIMQXKPe4IPMEFSNF8Fn6tZ7wz2NaCte+FTsdriRAjEbykdwrnvZZbGIwyFUaPWrl/rnMrnbykY0jYtAiuMljgQYfbfdvt3iGX7wy3zrRWGphXXJeOK7SkZOKonA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7+uS4q4dcrL0rXSBXdy6qLMFw5C70poNOwyY2FK1krg=;
 b=YE4trekc6cA9U8B+O3m2ML3ObUmV4/PTKWOfk88NOpcdOmpSOd01Og6YaWLsA8fkJY1FTNNxEcN0o5k5U1A9l5fBgFlsZEkUiu+0YJYCIGxCbJHWDM2mTaQRwuFQUalEakj91v8ZHbt1Y4gVCp0X5avDWfhl0JW2ItG7qeXFP+IianJrywgBirY5qb7yNeUG68kyZsnjbMixbz5LiQQMBn491tRZuHXaIEHs9gzFJdw92Urnz+RxJX7OSJo9YGuuutX+QDeDR5iuqqND5mMlvRit0pbvMQfCJicWeRodRAuOIV6Y+ExtG5JtOTMZj2pVfPdl7emILhotASds7X5YoA==
Received: from DM4PR11MB6335.namprd11.prod.outlook.com (2603:10b6:8:b7::10) by
 SA2PR11MB5036.namprd11.prod.outlook.com (2603:10b6:806:114::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 15:24:14 +0000
Received: from DM4PR11MB6335.namprd11.prod.outlook.com
 ([fe80::b76:913:9a3c:a4d1]) by DM4PR11MB6335.namprd11.prod.outlook.com
 ([fe80::b76:913:9a3c:a4d1%5]) with mapi id 15.21.0339.010; Fri, 21 Aug 2026
 15:24:12 +0000
From: <Jamie.Gibbons@microchip.com>
To: <nwhitehorn@pa.msu.edu>, <u-boot@lists.u-boot-project.org>
CC: <tim609@andestech.com>, <Conor.Dooley@microchip.com>
Subject: Re: [PATCH v2] riscv: mpfs: Read and store FPGA design information on
 MPFS hardware.
Thread-Topic: [PATCH v2] riscv: mpfs: Read and store FPGA design information
 on MPFS hardware.
Thread-Index: AQHdLw/oj/Q783UvF065Q9Gk+Eu8WLaopROA
Date: Fri, 21 Aug 2026 15:24:12 +0000
Message-ID: <600f5bbc320e19f9d82ef01dac5077e35a51d471.camel@microchip.com>
References: <20260818124815.24470-1-nwhitehorn@pa.msu.edu>
In-Reply-To: <20260818124815.24470-1-nwhitehorn@pa.msu.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6335:EE_|SA2PR11MB5036:EE_
x-ms-office365-filtering-correlation-id: aff556d4-907c-4d6e-97bc-08deff98410a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|10067099003|56012099006|11063799006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: TndYpNYid9CUKSkdvSDD+fzRWCWnyB/2nVbap1K1DYID3mKHKFkKO2ZU5Re7MsrRNuwcwzdVAUNP0SLSfko7sRHT1hgdgKND35Su5K9Z2i0qAHG9Yo5WVbOoS/UIOcbGGvMIsjF1bCr2s7MzvMzxGN6f4hLKq4hauXO790E2j2GyDbiNADGV4wM5KjJecKCUGruobQQkbuBVeqEVi/nAi/i07YYtZAjra1l4Vc4mNC1Sb5e+KouYJYU3XIAL8Pt2ORJfkbAe8lThdtxpzkhx8TctO0w+hvjPQRI9xUuxWqIcJ49eENP8PzI2xbJjr0+aGqw7CQ5EIsG5KGLysdyAV7tgI0JPxdM7CUKOWb2w16lElgh9e/JITmmnF9fjhNw8bozequgr+V9QoGHtLFoP60jKYuUNpsoYP+t5n+ypsITuVKUU/R1KDBwNqF7+orAhJChdV7NATyBwDoZ54+AWFXiOjnH7MZsB8EjS2FpZ4pxQVuEdTxbtM3RevKxgJm0JRJM+Ap/wfZ+HolHRGVceF9uLFiK6O+zGT6wyTTqmc7h3J4s4cJ/PnXtqWK34rfO4QEpuSJQBaIiHvcp6HVuPMKCdN/tuMjAmwMUaiP4xjopXGAwY3d5XG0bHJ1998guzO9eJ6HN14O02Zbeo/dAsMvUFDKPw8cIeM5Va587pW48F84Lu9tqBsJ2SbcqrGOMPy9iNJiMOR9J8LHB3+b0PLFUeCR+KFzgRYsAMHIu/xmA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6335.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T25HeEZjTWE1TjhrQ1U3Mm5hNm80QUdnMGdtMzZFcndSd3NURk82cmRIcWRs?=
 =?utf-8?B?L3BPK3dOK0xjSDBBUEdhWEdndVlaRkoyUXdqaURkU1FqVXQwbVU2YnNFWXJm?=
 =?utf-8?B?ckpNeldKWW1COGZjb0VKLzhUUzR4Z1hIMlB3N0NWeXpLUFN5SnJnbEhtclIw?=
 =?utf-8?B?QmJSMjhLVmZzREJTcUl1QmRLYW9yb0d2RldvbkVPNWRaQUtxTCtML3dDWVZ6?=
 =?utf-8?B?TFJEOXNDTEgvdTRSVTkxWXhJbkhNYks2aHQwOExkY0Qvb2I1T0pkUkhQS2JL?=
 =?utf-8?B?R056OW1sYnU3dmZPZFN2VDhVamdGNS96eEkxSzYrNDZOdVdaMk1uaTVBMVpm?=
 =?utf-8?B?MVJzZW1rOVkrTUpZdi8vODVoMHdqYkZNOXBXTmEzZWs0aHNXOGFYbEt2eHQ3?=
 =?utf-8?B?NmVlY3JaUHVRekErWG1EbGNONjBmd0hleTRmd1lZWWcrYWxzMVdkcHIyQmYx?=
 =?utf-8?B?R08rNFpSWEF6ZHVHQ2lCd2cyTExjV1o2SlA1Qk9zRUg3SXpPM3I4NWYwb3ow?=
 =?utf-8?B?ODZScDQxclJNUDUvT3JHL1pPYjdFdXdGSElqdXRXd1pmd2NYSXR0eGhkenhD?=
 =?utf-8?B?enhaRW9qQ3V0Zk1jMVR4b2ZWay95MGtDZVV2UE1TR2VKdlY2SDZSZ3hMbERT?=
 =?utf-8?B?cGhCZ3hhNzZYUitxMVBoaHNTcTBDeWJKWGdxeHdCTUhselVZVGZ6N04waTJU?=
 =?utf-8?B?QWlXdGgxWEFxamFHL0JNVCsybEZqQ0VZZHZBeklQd29ra2RKVE5yS3NFKzBn?=
 =?utf-8?B?MjE2Y1krcmRuMTh6dmhUd0pCb3ZNVytjd096UUVlMUtFbmFWcG4wLzlvcWZv?=
 =?utf-8?B?aWNNWVArM1VzbWhvb1ZwaU82YStkRGxydU9qZGJhMlFrMENCY1pZbDZQLzUy?=
 =?utf-8?B?SkYxdW1qRjIya1ZpcVlOWDJEWXhiamc2MmdvOGlvbmZMT3Z6VWtaSzhkMmhx?=
 =?utf-8?B?aXlYRDMrU1VENG11Vnp6OUpMM0dMSDhhOW8xUUxBNHJHbko2dXJocjdLMVFN?=
 =?utf-8?B?MCtBTTgwemszT0FmczBZOVg5V21neE1ld0VMTGpkeDZwZlRmaGpmaUF5T2dv?=
 =?utf-8?B?SVhTdXdvYVU4SVpaVS8ybmkyL1lITlRKWjRZbmxIZ2ZnTlRsa044TGNBM3hC?=
 =?utf-8?B?UUtvaWE0dm1GN2JrclhtYmJCL21jL2NhOVRlelVsTEgxMG1iMTVYYldHSXR6?=
 =?utf-8?B?RVFCdmpZMER4ZHk0NUpxUjZnZXpHamQ0R0ZKUks1YWs5aGt6c2l3K0V6M0tP?=
 =?utf-8?B?RWV2Y3Q1TmM2RG9ML1A0cmFsTFZhUXdYajJFZkk3bUdNaHk3UXBQemRMbFZL?=
 =?utf-8?B?VWlhSllXS3BvekRzOEZMTXBvWitQK2VUVEN4OUpJQ1IxN096WWh3V3RZa3hj?=
 =?utf-8?B?ci91TkY2ZVRhUkFrS214bWFiMzZKUUJtOXBIOSsyemFMNGRoeEV1dUxCejNw?=
 =?utf-8?B?UUJuS2xIYm5XRFhYV0pzeU1raHdTc1kzUG4rc2ZqTEMwU2pMUWJPa1Z0eVpv?=
 =?utf-8?B?KzJCLytCQytXWTRtSlhIMkJCZUxNT0s0ODBrNHhoVkRDVjlNWXEyeVFJcWp6?=
 =?utf-8?B?RXF5YnJpclE3WHBSTElqVElIOWFGU0NjQitRTDBremdlMy9ZamFBaEthUG4z?=
 =?utf-8?B?Qzc2dTJUTDExaFRMZ0kyUU4yaVJQc2hPRmlKbmhKMHdBM3RPbTVRcGhxbUpz?=
 =?utf-8?B?OGdVUGJqOWFWWVZZbEp1T0hrK1VjQkpteFZHeW82Zk1yK3pmbDVCajkxVVBN?=
 =?utf-8?B?RXdKUHZ0QVlKbm5UWWtCQi95cnpVVW1QdHBRZU93dVFIT2VsMjVPK0F0NzI0?=
 =?utf-8?B?UUQ4MHRsMjdwQlhyNW5ZWXBvM3pwdWU5UEdSUEd6dDdYSzZBeTFGbnphbmZq?=
 =?utf-8?B?Yit3amZ6N0VTQWx5OFdJbm9KQlAvQiszV3I5djhrNVUrcHlndWdieURXRVc3?=
 =?utf-8?B?WTlnTFE3NEVRdzg0cU5UcVJ4VGVNYndIc0pXS3RKdCtrdGlsWTlXd2RJM3Vm?=
 =?utf-8?B?cGhyeHBUbFRsckdURnJrTnAvYmczbXp1K0VnU0Z6Qzg4TUZqUXpubk83aWd4?=
 =?utf-8?B?L0x6VzI5OEpYYk9qV0VsRzhkRHpxdFJTZzRYR2FmUEV5MkN1TXlGbDNFZ2lK?=
 =?utf-8?B?TVEzbzlHdHRMZ2U3bGx5aFFEWnVNZ00zMCtQeTdsYUpuSXBQd1h3YmFVTGtK?=
 =?utf-8?B?aE50OHVXZk40OGtNMUpIMXBNNm1IYVFFNVJGZENGbDZkUjk3YVdoSlpiRk0y?=
 =?utf-8?B?c21YRkc2RW1na2pHRS9HSkRSeUJDSkFoU1Zlb1RqUnlrV3QwN2NLRUJBcEFS?=
 =?utf-8?B?U3p2ZkxIRktYak1LMHd1WnplcGpkaTlVRDJKNFBUZmwwQklZY0t2R3ptcENv?=
 =?utf-8?Q?zjhHyr0d4WKni0A4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A2E347FEC488C343A696DEAFEB580E76@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6335.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aff556d4-907c-4d6e-97bc-08deff98410a
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2026 15:24:12.4258 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hDlr0eqZx2x0d6o2tvh5Gl98y51QpKwPwUJs8eCcFE0fOvnmUBnsD7PVFRsUrN3fgOQHWeFX+g1kySgCsZ7F00pDBlqA+pCUnPrqjw9vb7A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5036
X-Mailman-Approved-At: Fri, 21 Aug 2026 16:06:26 +0000
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

T24gVHVlLCAyMDI2LTA4LTE4IGF0IDA4OjQ4IC0wNDAwLCBOYXRoYW4gV2hpdGVob3JuIHdyb3Rl
Ogo+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50
cyB1bmxlc3MgeW91Cj4ga25vdyB0aGUgY29udGVudCBpcyBzYWZlCj4gCj4gV2hlbiB3b3JraW5n
IHdpdGggc3lzdGVtcyB3aXRoIG11bHRpcGxlIEZQR0EgZmlybXdhcmVzLCBpdCBpcwo+IHNvbWV0
aW1lcwo+IHVzZWZ1bCB0byBiZSBhYmxlIHRvIHVzZSB0aGUgc2FtZSBVLUJvb3QgYW5kIHNjcmlw
dCBjb25kaXRpb25hbAo+IGJlaGF2aW9yCj4gYmFzZWQgb24gdGhlIEZQR0EgZmlybXdhcmUgSUQg
YW5kIHZlcnNpb24gbnVtYmVyLiBUaGlzLCBhbGxvd3MsIGZvcgo+IGV4YW1wbGUsIGZsYXNoaW5n
IG5ldyBGUEdBIGltYWdlcyB3aXRob3V0IGZsYXNoaW5nIHRoZSBib290bG9hZGVyIGFuZAo+IGxl
dHRpbmcgVS1Cb290IGFuZCB0aGUgTGludXgga2VybmVsIGFkYXB0IGFwcHJvcHJpYXRlbHkuCj4g
Cj4gVGhpcyBkb2VzIHR3byB0aGluZ3Mgd2l0aCB0aGUgaW5mb3JtYXRpb246Cj4gMS4gUHJpbnRz
IHRoZSBGUEdBIGRlc2lnbiBJRCBhbmQgdmVyc2lvbiB0byB0aGUgY29uc29sZSBhcyBwYXJ0IG9m
IFUtCj4gQm9vdAo+IMKgwqAgc3RhcnR1cCwgd2hpY2ggaXMgaGVscGZ1bCB0byBhIGh1bWFuIHdv
cmtpbmcgd2l0aCB0aGUgYm9hcmQuCj4gMi4gU3RvcmVzIHRoZSBzYW1lIGluZm9ybWF0aW9uLCBw
bHVzIHRoZSBhbHJlYWR5LWFjcXVpcmVkIEZQR0Egc2VyaWFsCj4gwqDCoCBudW1iZXIsIGluIGEg
bmV3IHNldCBvZiBlbnZpcm9ubWVudCB2YXJpYWJsZXMgKHNlcmlhbF9udW1iZXIsCj4gwqDCoCBk
ZXNpZ25faWQsIGRlc2lnbl92ZXIgW3RoZSB2ZXJzaW9uXSwgYW5kIGRlc2lnbl9iYWNrbGV2ZWwK
PiDCoMKgIFttaW5pbXVtLXZlcnNpb24gYmFja2xldmVsXSkuIFRoZXNlIGNhbiBiZSB1c2VkIGlu
IGEgVS1Cb290IHNjcmlwdAo+IHRvCj4gwqDCoCBsb2FkIGRpZmZlcmVudCBrZXJuZWxzLCBkZXZp
Y2UgdHJlZXMsIGV0Yy4gZGVwZW5kaW5nIG9uIHRoZQo+IGN1cnJlbnRseQo+IMKgwqAgaW5zdGFs
bGVkIGZpcm13YXJlLCB3aGljaCBhbGxvd3MgVS1Cb290IGFuZCB0aGUga2VybmVsIHRvIGFkYXB0
Cj4gwqDCoCBjbGVhbmx5IHRvIEZQR0EgZmlybXdhcmUgdXBkYXRlcyB0aGF0IGNoYW5nZSBhY2Nl
c3NpYmxlCj4gcGVyaXBoZXJhbHMKPiDCoMKgIGV0Yy4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBOYXRo
YW4gV2hpdGVob3JuIDxud2hpdGVob3JuQHBhLm1zdS5lZHU+Cj4gLS0tCj4gQ2hhbmdlcyBmb3Ig
djI6Cj4gLSBSZW5hbWUgZW52aXJvbm1lbnQgdmFyaWFibGVzIHRvIHJlbW92ZSB0aGUgcGZfIHBy
ZWZpeAo+IC0gUmVtb3ZlIHBvcnRpb25zIG9mIHRoZSBwYXRjaCB0aGF0IGFkZGVkIHByb3BlcnRp
ZXMgdG8gdGhlIGRldmljZQo+IHRyZWUKPiAtIFN0eWxlIGNoYW5nZXMKPiAtIFJlYmFzZSBhZnRl
ciBhNWY5MzAzN2YyODYyNGM2MTIyODhlMmQ5NzYwNGQ3M2UwM2FmNWEzCj4gCj4gVGhhbmtzIHRv
IENvbm9yIERvb2xleSBhbmQgVGltIE91eWFuZyBmb3IgaGVscGZ1bCBzdWdnZXN0aW9ucy4KPiAK
PiDCoGJvYXJkL21pY3JvY2hpcC9tcGZzX2dlbmVyaWMvbXBmc19nZW5lcmljLmMgfCAyNiArKysr
KysrKysrCj4gwqBkcml2ZXJzL21pc2MvbXBmc19zeXNjb250cm9sbGVyLmPCoMKgwqDCoMKgwqDC
oMKgwqDCoCB8IDU0Cj4gKysrKysrKysrKysrKysrKysrKysrCj4gwqBpbmNsdWRlL21wZnMtbWFp
bGJveC5owqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAyICsK
PiDCoDMgZmlsZXMgY2hhbmdlZCwgODIgaW5zZXJ0aW9ucygrKQo+IApIaSBOYXRoYW4sCgpIYXBw
eSB3aXRoIHRoZSBwYXRjaCBvdGhlciB0aGFuIENvbm9yJ3Mgc3R5bGluZyBzdWdnZXN0aW9ucyBh
bmQgb25lIE5JSwpvZiBteSBvd24gc2VlbiBiZWxvdy4uCgpPdGhlciB0aGFuIHRob3NlOgpBY2tl
ZC1ieTogSmFtaWUgR2liYm9ucyA8amFtaWUuZ2liYm9uc0BtaWNyb2NoaXAuY29tPgoKVGhhbmtz
IGZvciB0aGUgcGF0Y2guCj4gZGlmZiAtLWdpdCBhL2JvYXJkL21pY3JvY2hpcC9tcGZzX2dlbmVy
aWMvbXBmc19nZW5lcmljLmMKPiBiL2JvYXJkL21pY3JvY2hpcC9tcGZzX2dlbmVyaWMvbXBmc19n
ZW5lcmljLmMKPiBpbmRleCBmNTdmNWY0MDQ2Yi4uNDQyM2RkMWUzOGMgMTAwNjQ0Cj4gLS0tIGEv
Ym9hcmQvbWljcm9jaGlwL21wZnNfZ2VuZXJpYy9tcGZzX2dlbmVyaWMuYwo+ICsrKyBiL2JvYXJk
L21pY3JvY2hpcC9tcGZzX2dlbmVyaWMvbXBmc19nZW5lcmljLmMKPiBAQCAtMTE0LDcgKzExNCwx
MCBAQCBpbnQgYm9hcmRfbGF0ZV9pbml0KHZvaWQpCj4gwqB7Cj4gwqDCoMKgwqDCoMKgwqAgdTMy
IHJldDsKPiDCoMKgwqDCoMKgwqDCoCBpbnQgbm9kZTsKPiArwqDCoMKgwqDCoMKgIGludCBpZHg7
Cj4gwqDCoMKgwqDCoMKgwqAgdTggZGV2aWNlX3NlcmlhbF9udW1iZXJbMTZdID0gezB9Owo+ICvC
oMKgwqDCoMKgwqAgY2hhciBzZXJpYWxzdHJpbmdbMzNdLCBkZXNpZ25pZFszM107Cj4gK8KgwqDC
oMKgwqDCoCB1MTYgZGVzaWdudmVyLCBkZXNpZ25iYWNrbGV2ZWw7Cj4gwqDCoMKgwqDCoMKgwqAg
dm9pZCAqYmxvYiA9ICh2b2lkICopZ2QtPmZkdF9ibG9iOwo+IMKgwqDCoMKgwqDCoMKgIHN0cnVj
dCB1ZGV2aWNlICpkZXY7Cj4gwqDCoMKgwqDCoMKgwqAgc3RydWN0IG1wZnNfc3lzX3NlcnYgKnN5
c19zZXJ2X3ByaXY7Cj4gQEAgLTE0NCw2ICsxNDcsMjkgQEAgaW50IGJvYXJkX2xhdGVfaW5pdCh2
b2lkKQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gLUVJTlZBTDsKPiDC
oMKgwqDCoMKgwqDCoCB9Cj4gCj4gK8KgwqDCoMKgwqDCoCAvKiBTdG9yZSBkZXNpZ24gaW5mbyBh
bmQgc2VyaWFsIG51bWJlciBpbiBlbnZpcm9ubWVudCAqLwo+ICvCoMKgwqDCoMKgwqAgbWVtc2V0
KGRlc2lnbmlkLCAwLCBzaXplb2YoZGVzaWduaWQpKTsKPiArwqDCoMKgwqDCoMKgIG1lbXNldChz
ZXJpYWxzdHJpbmcsIDAsIHNpemVvZihzZXJpYWxzdHJpbmcpKTsKPiArCj4gK8KgwqDCoMKgwqDC
oCByZXQgPSBtcGZzX3N5c2NvbnRyb2xsZXJfcmVhZF9kZXNpZ25faW5mbyhzeXNfc2Vydl9wcml2
LAo+IGRlc2lnbmlkLAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCAmZGVzaWdudmVyLCAmZGVzaWduYmFja2xldmVsKTsKPiArwqDCoMKgwqDCoMKgIGlmIChy
ZXQpIHsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBwcmludGYoIkNhbm5vdCByZWFk
IGRldmljZSBkZXNpZ24gaW5mb3JtYXRpb25cbiIpOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHJldHVybiAtRUlOVkFMOwo+ICvCoMKgwqDCoMKgwqAgfQo+ICvCoMKgwqDCoMKgwqAg
Zm9yIChpZHggPSAwOyBpZHggPCAxNjsgaWR4KyspCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgc3ByaW50Zigmc2VyaWFsc3RyaW5nWzIqaWR4XSwgIiUwMngiLAo+IGRldmljZV9zZXJp
YWxfbnVtYmVyW2lkeF0pOwo+ICsKPiArwqDCoMKgwqDCoMKgIGVudl9zZXQoInNlcmlhbF9udW1i
ZXIiLCBzZXJpYWxzdHJpbmcpOwo+ICvCoMKgwqDCoMKgwqAgZW52X3NldCgiZGVzaWduX2lkIiwg
ZGVzaWduaWQpOwo+ICvCoMKgwqDCoMKgwqAgZW52X3NldF91bG9uZygiZGVzaWduX3ZlciIsIGRl
c2lnbnZlcik7Cj4gK8KgwqDCoMKgwqDCoCBlbnZfc2V0X3Vsb25nKCJkZXNpZ25fYmFja2xldmVs
IiwgZGVzaWduYmFja2xldmVsKTsKPiArCj4gK8KgwqDCoMKgwqDCoCBwcmludGYoIkZQR0EgRGVz
aWduIG5hbWU6ICVzXG4iLCBkZXNpZ25pZCk7Cj4gK8KgwqDCoMKgwqDCoCBwcmludGYoIkZQR0Eg
U2VyaWFsOiAlc1xuIiwgc2VyaWFsc3RyaW5nKTsKPiArwqDCoMKgwqDCoMKgIHByaW50ZigiRGVz
aWduIHZlcnNpb24gbnVtYmVyICVkIChiYWNrbGV2ZWwgJWQpXG4iLAo+IGRlc2lnbnZlciwKPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZGVzaWduYmFja2xl
dmVsKTsKPiArCj4gwqDCoMKgwqDCoMKgwqAgLyogVXBkYXRlIE1BQyBhZGRyZXNzIHdpdGggZGV2
aWNlIHNlcmlhbCBudW1iZXIgKi8KPiDCoMKgwqDCoMKgwqDCoCBtYWNfYWRkclswXSA9IDB4MDA7
Cj4gwqDCoMKgwqDCoMKgwqAgbWFjX2FkZHJbMV0gPSAweDA0Owo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL21pc2MvbXBmc19zeXNjb250cm9sbGVyLmMKPiBiL2RyaXZlcnMvbWlzYy9tcGZzX3N5c2Nv
bnRyb2xsZXIuYwo+IGluZGV4IGI5YWVhN2UxMTgxLi4wN2E3ODhkYjc2ZSAxMDA2NDQKPiAtLS0g
YS9kcml2ZXJzL21pc2MvbXBmc19zeXNjb250cm9sbGVyLmMKPiArKysgYi9kcml2ZXJzL21pc2Mv
bXBmc19zeXNjb250cm9sbGVyLmMKPiBAQCAtMTUyLDYgKzE1Miw2MCBAQCBpbnQgbXBmc19zeXNj
b250cm9sbGVyX3JlYWRfc2VybnVtKHN0cnVjdAo+IG1wZnNfc3lzX3NlcnYgKnN5c19zZXJ2X3By
aXYsIHU4ICpkZXZpCj4gwqB9Cj4gwqBFWFBPUlRfU1lNQk9MKG1wZnNfc3lzY29udHJvbGxlcl9y
ZWFkX3Nlcm51bSk7Cj4gCj4gKy8qKgo+ICsgKiBtcGZzX3N5c2NvbnRyb2xsZXJfcmVhZF9kZXNp
Z25faW5mbygpIC0gVXNlIHN5c3RlbSBzZXJ2aWNlIHRvCj4gcmVhZCBGUEdBIGRlc2lnbiBpbmZv
Cj4gKyAqIEBzeXNfc2Vydl9wcml2OsKgwqDCoMKgIHN5c3RlbSBzZXJ2aWNlIHByaXZhdGUgZGF0
YQo+ICsgKiBAZGVzaWduaWQ6wqDCoMKgwqDCoMKgwqDCoMKgIDMwLWJ5dGUgc3RyaW5nIG5hbWUg
b2YgdG9wIG1vZHVsZSBpbiBGUEdBCj4gbG9naWMgZGVzaWduCj4gKyAqwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBOQjogbnVsbCB0ZXJtaW5hdGlvbiBpcyBub3QgZ3Vh
cmFudGVlZAo+ICsgKiBAZGVzaWdudmVyOsKgwqDCoMKgwqDCoMKgwqAgdmVyc2lvbiBudW1iZXIg
b2YgdGhlIEZQR0EgZGVzaWduCj4gKyAqIEBiYWNrbGV2ZWw6wqDCoMKgwqDCoMKgwqDCoCBwcm9n
cmFtbWVkIG1pbmltdW0gYWxsb3dlZCBGUEdBIGRlc2lnbgo+IHZlcnNpb24KPiArICoKPiArICog
UmV0dXJuOiAwIGlmIGFsbCB3ZW50IG9rLCBlbHNlIHJldHVybiBhcHByb3ByaWF0ZSBlcnJvcgo+
ICsgKi8KPiAraW50IG1wZnNfc3lzY29udHJvbGxlcl9yZWFkX2Rlc2lnbl9pbmZvKHN0cnVjdCBt
cGZzX3N5c19zZXJ2Cj4gKnN5c19zZXJ2X3ByaXYsCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgdTggKmRlc2lnbmlkLCB1MTYgKmRlc2lnbnZlciwgdTE2ICpiYWNrbGV2ZWwpCj4gK3sK
PiArwqDCoMKgwqDCoMKgIHVuc2lnbmVkIGxvbmcgdGltZW91dHNlY3MgPSAzMDA7Cj4gK8KgwqDC
oMKgwqDCoCB1OCBkYXRhWzM2XTsKPiArwqDCoMKgwqDCoMKgIGludCByZXQ7Cj4gKwo+ICvCoMKg
wqDCoMKgwqAgc3RydWN0IG1wZnNfbXNzX3Jlc3BvbnNlIHJlc3BvbnNlID0gewo+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIC5yZXNwX3N0YXR1cyA9IDBVLAo+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIC5yZXNwX21zZyA9ICh1MzIgKilkYXRhLAo+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIC5yZXNwX3NpemUgPSBzaXplb2YoZGF0YSl9Owo+ICvCoMKgwqDCoMKg
wqAgc3RydWN0IG1wZnNfbXNzX21zZyBtc2cgPSB7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgLmNtZF9vcGNvZGUgPSAyLApDb3VsZCB5b3UgcHV0IHRoaXMgYXMgYSBkZWZpbmUgYXQg
dGhlIHRvcCBvZiB0aGUgZmlsZSB3aXRoIHRoZSBvdGhlcnMKaW5zdGVhZCBvZiBoYXZpbmcgaXQg
aGFyZGNvZGVkIGhlcmUgcGxlYXNlLgoKVGhhbmtzLApKYW1pZS4KPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCAuY21kX2RhdGFfc2l6ZSA9IENNRF9EQVRBX1NJWkUsCj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgLnJlc3BvbnNlID0gJnJlc3BvbnNlLAo+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIC5jbWRfZGF0YSA9IENNRF9EQVRBLAo+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIC5tYm94X29mZnNldCA9IE1CT1hfT0ZGU0VULAo+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIC5yZXNwX29mZnNldCA9IFJFU1BfT0ZGU0VUfTsKPiArCj4gK8Kg
wqDCoMKgwqDCoCByZXQgPSBtcGZzX3N5c2NvbnRyb2xsZXJfcnVuX3NlcnZpY2Uoc3lzX3NlcnZf
cHJpdi0KPiA+c3lzX2NvbnRyb2xsZXIsICZtc2cpOwo+ICvCoMKgwqDCoMKgwqAgaWYgKHJldCkg
ewo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRldl9lcnIoc3lzX3NlcnZfcHJpdi0+
c3lzX2NvbnRyb2xsZXItPmNoYW4uZGV2LAo+ICJTZXJ2aWNlIGZhaWxlZDogJWQsIGFib3J0XG4i
LCByZXQpOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiByZXQ7Cj4gK8Kg
wqDCoMKgwqDCoCB9Cj4gKwo+ICvCoMKgwqDCoMKgwqAgLyogUmVjZWl2ZSB0aGUgcmVzcG9uc2Ug
Ki8KPiArwqDCoMKgwqDCoMKgIHJldCA9IG1wZnNfc3lzY29udHJvbGxlcl9yZWN2X3Jlc3BvbnNl
KHN5c19zZXJ2X3ByaXYtCj4gPnN5c19jb250cm9sbGVyLCAmbXNnLCB0aW1lb3V0c2Vjcyk7Cj4g
K8KgwqDCoMKgwqDCoCBpZiAocmV0KQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJl
dHVybiByZXQ7Cj4gKwo+ICvCoMKgwqDCoMKgwqAgZGVidWcoIiVzOiBSZWFkIHN1Y2Nlc3NmdWwg
JXNcbiIsCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBfX2Z1bmNfXywgc3lzX3NlcnZfcHJp
di0+c3lzX2NvbnRyb2xsZXItPmNoYW4uZGV2LQo+ID5uYW1lKTsKPiArCj4gK8KgwqDCoMKgwqDC
oCBpZiAoZGVzaWduaWQgIT0gTlVMTCkKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBt
ZW1jcHkoZGVzaWduaWQsICZkYXRhWzJdLCAzMCk7Cj4gK8KgwqDCoMKgwqDCoCBpZiAoZGVzaWdu
dmVyICE9IE5VTEwpCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbWVtY3B5KGRlc2ln
bnZlciwgJmRhdGFbMzJdLCAyKTsKPiArwqDCoMKgwqDCoMKgIGlmIChiYWNrbGV2ZWwgIT0gTlVM
TCkKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBtZW1jcHkoYmFja2xldmVsLCAmZGF0
YVszNF0sIDIpOwo+ICsKPiArwqDCoMKgwqDCoMKgIHJldHVybiAwOwo+ICt9Cj4gK0VYUE9SVF9T
WU1CT0wobXBmc19zeXNjb250cm9sbGVyX3JlYWRfZGVzaWduX2luZm8pOwo+ICsKPiDCoHN0YXRp
YyB1MTYgbXBmc19zeXNjb250cm9sbGVyX3NlcnZpY2Vfc3BpX2NvcHkoc3RydWN0IG1wZnNfc3lz
X3NlcnYKPiAqc3lzX3NlcnZfcHJpdiwgdTY0IGRzdF9hZGRyLCB1MzIgc3JjX2FkZHIsIHUzMiBs
ZW5ndGgpCj4gwqB7Cj4gwqDCoMKgwqDCoMKgwqAgaW50IHJldDsKPiAKCg==
