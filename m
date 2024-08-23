Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83C7BC52D7C
	for <u-boot@archiver.kernel.org>; Fri, 23 Aug 2024 13:36:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA99B87E15;
	Fri, 23 Aug 2024 15:36:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sony.com header.i=@sony.com header.b="Gc/rU4g3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7463F88718; Fri, 23 Aug 2024 07:00:22 +0200 (CEST)
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com
 [185.132.183.11])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B2A288216
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 07:00:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=JianfengA.Zhu@sony.com
Received: from pps.filterd (m0209328.ppops.net [127.0.0.1])
 by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47N3tCe0032060;
 Fri, 23 Aug 2024 05:00:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=S1; bh=H+UZr0F+yPqZwKimJtj6dMM0mrL1j
 QRuywJy+XAssR8=; b=Gc/rU4g3y3a40oegXkZUY0hBbC77Vohl43r35FyGPfZd3
 dVjuCQYfqZeWu+PEdmhco37Ev/iyjyoAPFnjUtCU28Cv95xla3CNO6sCT//vUiyW
 vu4lmw8OBDTVkRvyaQFaNnl1fuFRQ0nL3aW4hnaiw0KbX8aAyvVDSohm7S+TBft9
 UiSdiF0o67+F5R6M9Xxfr+JiMJFCVF3Rsi3OxOzXCRBLhP/tnWbVvOD0EA+0kegX
 lYEst++0e5JpPGbaRyDOM70atCrajrMetb6f0eFaS8tZltTH5WDhrhVavSCzv6O6
 i5xtQDKnViNKg3Z8AaGfQME2wKV9ObnEbsHMiGSCQ==
Received: from apc01-psa-obe.outbound.protection.outlook.com
 (mail-psaapc01lp2040.outbound.protection.outlook.com [104.47.26.40])
 by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 412n1h5e3k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 23 Aug 2024 05:00:12 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DvVnpUkcPM2K2ioGsaKla6hn+E55yfQvvzdTQCPJigp0FaKQlswFsboeNxjX6AIGz6UUJswWphOxxUNx2MHT3L2yRaG6pP4bbBwPWPuHmBjzNiDDo1HdidxWPygO7UDJA3Apl27n4oogEBlqjTe7iBgzAAlz3uyvg/sgKoLDVUoHj0WhNEYHjG1K0x7TmIcQ99EZ1RUuMKXRCk2MHLe2IpZU0Pa5HlxuR6EsDqzyV4y/ZwAjmikWlkovMsHx310eSju0rA4WFmrrmLEmykLJvlZK8cJodl37tgSMYgcRf41WtLtCcP59WF73CXymc1bc/QF8B2eNHZzGcl9cAGT0gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H+UZr0F+yPqZwKimJtj6dMM0mrL1jQRuywJy+XAssR8=;
 b=V07GM++DYJXtKdi5TbykzRhZMjETtw5bOB73V74iu/gJhOPpvX5KX4BkoAqTEhNqxlaNu92t3ajNvpRqYu64OzrwR9NEFNvTKH1SeBFw/S6C5ye/6CQHSz6HPyH0za/WRAFaIOKtVBgLgvvLVTxl43drWeRuEdzjf5esDi0L4MeERwMUMPi/I5jr45sj+zRyhLiG0FNH8WW4FgZ0pDvI85xiYYV10MjC+aEWnGY7JR6S6626dTwECAQ7gRAvQcA5eU2h/HDjuYyRABh8/2dJACBfexK62ehQXErfVRWBO6bBOqWoXYV8jAm8atvoZMEjj0MxpYBdRN7Thadb5zcrVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from OSQPR04MB7740.apcprd04.prod.outlook.com (2603:1096:604:283::6)
 by TYSPR04MB8318.apcprd04.prod.outlook.com (2603:1096:405:be::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Fri, 23 Aug
 2024 04:59:52 +0000
Received: from OSQPR04MB7740.apcprd04.prod.outlook.com
 ([fe80::7c06:41d9:f38c:e1bd]) by OSQPR04MB7740.apcprd04.prod.outlook.com
 ([fe80::7c06:41d9:f38c:e1bd%6]) with mapi id 15.20.7875.018; Fri, 23 Aug 2024
 04:59:52 +0000
From: "JianfengA.Zhu@sony.com" <JianfengA.Zhu@sony.com>
To: "caleb.connolly@linaro.org" <caleb.connolly@linaro.org>,
 "neil.armstrong@linaro.org" <neil.armstrong@linaro.org>, "marex@denx.de"
 <marex@denx.de>, "trini@konsulko.com" <trini@konsulko.com>
CC: "u-boot-qcom@groups.io" <u-boot-qcom@groups.io>, "Jacky.Cao@sony.com"
 <Jacky.Cao@sony.com>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: phy: Fix db410c crash issue during usb_stop
Thread-Topic: phy: Fix db410c crash issue during usb_stop
Thread-Index: AQHa9RistJEm/ZGpwkW7YAl9XzKglg==
Date: Fri, 23 Aug 2024 04:59:52 +0000
Message-ID: <OSQPR04MB774067EBEEADD714EFE18C2A90882@OSQPR04MB7740.apcprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSQPR04MB7740:EE_|TYSPR04MB8318:EE_
x-ms-office365-filtering-correlation-id: e3143474-bf75-4034-2892-08dcc3306c33
x-proofpoint-id: d8690225-876f-412f-87c6-a7cb45557a4c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?gb2312?B?QlR2TjQxR013Qnpnb1BJZDN6bTRuQXk3Tzk4V0l4MmRiVFMzem1odXQwN0dp?=
 =?gb2312?B?SmpZV2pseFR6L2VzVnFHcTNhTWI0dktlRFNwcVhQdkpudjZqSXQzdTNYeXRm?=
 =?gb2312?B?dnZrSjIva0puYmYzNjlUZ1dhRU1nSjcyckhXamlVUVcvYUhmMFRzYitZS2Z0?=
 =?gb2312?B?YkVJdm5lSmdIM25vTnA5dk5hRVN0TU1Fa21DZGg2RkZadEs2UXR0cGxnbGNE?=
 =?gb2312?B?SERPVUhuZkFhemxWQ25pNjZJdjUweEp1SW1zcUxnR21hbzVZdTdnS2pCVWR1?=
 =?gb2312?B?d0NscW5jSmZtRUU0UkdkcEF4UEREeEdCWmc1YS9qb2xKWDduMlJCRzBVTUNC?=
 =?gb2312?B?c3NySFdzQzE3b0l2Skd6dVNGL3ljQVZDdkY0WThRdGJBWWJTL1VvZVdrd0Rm?=
 =?gb2312?B?bWFPSjgxendNb0RxVTk4a3h5NTEzOENnbXJxZ2pyaFdScDRqUTd0aTFoWnhl?=
 =?gb2312?B?a25LeE0yZUpneWxkS01UR3FqNG1Id0pnMGl4VUdBK25JdVBXc1ZweURLNlV4?=
 =?gb2312?B?RDV0R0tQSFlzTVpXK0JZQ2Z2TS9CT3ZVMldnd3FzbHZMODJCWWZ6Q3FNWFhC?=
 =?gb2312?B?ZGF3MmV3YkRCUTJxa3dEMGk2V1ZZemMrWUtsTys4VFZkc2pDYWtFbkNpQ3Zs?=
 =?gb2312?B?VjFxZ3lhNGR5SUw1aVhCQUZiWEFVQ0JCYVI5MmhwdFYrK1FWbi8wd1lGMGUw?=
 =?gb2312?B?bHBTODhvajE4Z2laNjdCUVJJQlVkT1hZWlJrZmdTRjNYaXpSUUVpRXNVdTYr?=
 =?gb2312?B?K2gxcTdCK0NsSUxvaDVndjBuUlRYUzM2aUNSNUVseUJ1MlFWbXByYkdnS1Zt?=
 =?gb2312?B?a1NWSVJodnZKcEpHL28xeUxZQk5XY2MzNzdremUvSU55ZjgxZisvTXZQRGl3?=
 =?gb2312?B?cjdmZVphL2EwQTlvd0xCcGh6enlaWmI4MzRNQitydlB1L3hIUWprSlBFUHoy?=
 =?gb2312?B?dGpPSVhhTTZLd2padkdsWFJBK2l4QU92d0Q5WVJEWEF0VS8rUnV5NmlPVVov?=
 =?gb2312?B?VkJFSWd2dzM3M21nTWFSYmxaVjdBRGc2a2J6VzZZRkRwUFNVWGM1RmdWZXk0?=
 =?gb2312?B?RHFmRk5wUXdBdHJIYzNUNFY0VG9IQ25PVTE5QnhhUGl3NHJUbVU2K3k0dlZa?=
 =?gb2312?B?RzcwK2dWVC9CRjh6SnlJR2J4MWIvOVhoMHMxUFNjWVB6UnJiZ044ZTBBVXlw?=
 =?gb2312?B?azE0em1XaFA2ZWN6K2xTNkxBc3VDM0RrNWQxRWJkdDFGNDczN3JJSU0yaUtt?=
 =?gb2312?B?b1UvQzdyMHBLWk96eWdxNHp0VUpab21IblhPQlo4R1h1VHNtYWkzZDZmRWtu?=
 =?gb2312?B?UTl2Mm83SmYydjEwVVVGMnFwZkJVY0xuN1B4RDlDNmtJQTZkdDBGNkJyM0hi?=
 =?gb2312?B?WXpudGVOVUpUVklUWng4amxyZFFVQkhvbEU4TkZKeEhCek1kZ0Vsdmh6NUND?=
 =?gb2312?B?eWlhb1BUUGtWYlY3UXFjQTI2ZWhrNldrOW5WMlNoWkxmNG1MUTNzNktXcGNt?=
 =?gb2312?B?Y2xtUXVtcHBReFdaeTBQL1BCUUt5UXEzR2wyNTNQdzZ5cUlGZXlMc0hMNlJs?=
 =?gb2312?B?bXFiS01FRXFZUmpaU2o1TnlKZWgrZ243b2QyYmovcjNPcWZYczVHRy9nRWVm?=
 =?gb2312?B?cjZMR2pJMkxzQml5QmNOaE9aT3VWNHh4aXlhQUlLN3NXMkNpVVNmRGlabHky?=
 =?gb2312?B?RUdySjZwUDVLUFZhSWw5dWJ3dURiYWV0RDhnT0psakpqQWhkSk5WYUhITFZU?=
 =?gb2312?B?YTI2YXNldHNhb3RvT2VtRUo5Tko4M2xEVEt0MmFpNWV6ZkNjR1o5K1hScUsv?=
 =?gb2312?B?RzBkL3lrUHJoZXkyeEZ0NWpOVjZXK3UwcW5IMVR5bFF3RlBvdWM5ZEZCdi8r?=
 =?gb2312?B?cy9reHRIdkI3N3dYUnBybldocnJSOU5JQlphb3U0UG5VeUE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:OSQPR04MB7740.apcprd04.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?UWJzOWxuZmwwUmEvNUNIMjMzWWtoZGt5dHJNM0I5dG8vS0h2alE0Nm1HK0ZB?=
 =?gb2312?B?a1JOL2orNkxoRHZaZzJpcHFFbnRSTUhxUzAyd0JhVFRPaE9SMHphbUR0R0Iv?=
 =?gb2312?B?Nlcrd0g0aElmeHZDUjMvdTl4UWxURkd2aTEzYzBpVnF0UjhuUzNhVzhOTXNp?=
 =?gb2312?B?NHc3RWxaelFxcXpqMnlUYUdVdnZ2SzAwUnkvOXNxekJwUXNvb1BtSjk4N2ox?=
 =?gb2312?B?cGoxcG1yUHpEc0NnRjBKN2hTTWhBSTQ5dDNQc0R2UGdOSm5QaEx1VEZaOVJt?=
 =?gb2312?B?Q3Fpbyt0ZW5qekVLQ0tURWJpc3JIUVU5Yy9BZndDNHBpeFZUOWEzNElKaVhi?=
 =?gb2312?B?Z2tOODNrUit1cU9XN3Fybzl4TSt0TFRuN3VHVEtadytteVl6RHlOcXA5QUZW?=
 =?gb2312?B?OGlGdU0yVWRiVUpXK0lVUHp1UE1UTlBTaDYrMlpwUFVxdk9tY0RoWEM3RFZl?=
 =?gb2312?B?ZXJJbmhlL0NCekE5a3pxSG5TMlVVLys4bW1US1Flbnk2RDNYS0xTTjh5L05w?=
 =?gb2312?B?eWl2Z0RjS0N4Y2lnYlZzUFlRdEZhVXZwYTd5ZHRkeHNDMVBzWmZmU3QxZ1Fh?=
 =?gb2312?B?Y1hGY29NcDhrNHBDNmNWaDhYOUQ1NDF6dVpia1loYjFqWi9zMDc0Q055Wlph?=
 =?gb2312?B?SWYzdFkrM0t3R3kyNlRUOUR3RmhPZVE5YmYrd0FIQ0lpZG1ZRE94YlpJNkU1?=
 =?gb2312?B?TjBhdlNKZDdDZGVXTFYxb2ZHc2E0MlFxV1g1OU8rMXRpcVlRaE9XdDYzN0Yz?=
 =?gb2312?B?K0QvZ1pXOHdhS2NmUjNZWk8xS3NUUU9HdUM0UEwxc2JyL2c4ZkFlc1dXdnVI?=
 =?gb2312?B?MmxtVDJWMFVBd1BOQkVMZVBzR0hnOWF5d0xlN2hZQUVnK1kwRGtZNmhXaG1J?=
 =?gb2312?B?RHVxWmZKM1JFRDBISmhqd2J2Z3g4VzJ0aFV2b2M1QWhaNHQxWW1nTm5lbHh0?=
 =?gb2312?B?QzJEemRMZGwvTkJZeHJISkg2Zk14bEE0eTQvekJhRk5sb2JYNloxN2NuV1Iz?=
 =?gb2312?B?bzMzRHBXWlVUQXRRY2t5UWx4VU1GemJtdVJYSDY3bEdUMi80ejFMTi96UUlz?=
 =?gb2312?B?a2VzZXZYQ2VBWWdvNHpqV1NXWkhkWTVZaHgwUDVJNmhJaEI0UXdsRzNNb0FI?=
 =?gb2312?B?ZFcwSmVBR09kSHF4VUxROXlZQjZrSCt6bWhCbUk3N2h2enMxSS9aY3o0MU82?=
 =?gb2312?B?TitBNDFLN3VwdlpJeDF1dUNRODZJcjJiUVRBZGFZVTE2L01IU3JZKzl6ME02?=
 =?gb2312?B?UmhkMG1SV1hKbk8zTHkwR0RMdXNlRnVHclZtMGd1QkEzbHhIMjEvUzJLOEtH?=
 =?gb2312?B?Yk1ObTJzUENOTWNMS3ZSdmVDbW1hdUhURllDT09QL1lNT3QzV2VVYURyZkY3?=
 =?gb2312?B?UGlJZzJIbHdObWxoLzg0VVB6NWRoaXU5YU12RnRyQlNvaUJKQ1F5bEFQYlBN?=
 =?gb2312?B?MGl0cHpvVGh5aC83b0FsTnNQL2lOSWNIeFRZeDNWenF6a3FCZlgrem9XcktK?=
 =?gb2312?B?TUtVTWlFKythNDhEa2tmOU8yK041cGJhcGFPYklIMllRa3ZtM2ZUR3hDWWgv?=
 =?gb2312?B?eGFCVWk0L3JNMTMrY1dqdWxxWHliZ3lyN1F5bDRLWjZEem41TWJhNmIraXhK?=
 =?gb2312?B?eHlVU0JzN0I1TDVCQ2ZyK1psRGNmbGFFT1dUNklUR2QrVVpNY0xKVWJUbDNP?=
 =?gb2312?B?UW5PS0RBRHRReGE3eFhvQkdGb3JaOTc1UE42Znh6Vm5jVVFqZjBJR3M3TjM2?=
 =?gb2312?B?a3FWcEo4NFVNNzQvQkRpWUJ4aytlVnZjVFlscXpVSEc0RGpNQUVjQnd0NC82?=
 =?gb2312?B?ckhxcjRMYWtFa1p3OEgzRCsrOFpDNXhNb3hzc2s3aVc1azVIUTJOaGRRUlRu?=
 =?gb2312?B?QnpNY1Z0S0NsanFLRVBoTWM0MVFldlBQcDhRYjZna2paNUMvc3dTMVYwZXM3?=
 =?gb2312?B?VHlrYi9yaHJMOEpmb2J6Y0c5NEk4NUNadlZGUkZpWFJKSTNJY283SFV4SlpR?=
 =?gb2312?B?SXZIY0dCb1g5ZlVVRTJJNDBOTHF4ZG9meEhrbkxvdkVQWWFuMktKZkdBS3pp?=
 =?gb2312?B?VWNrdmVXbllxRENvZkkyc3IzaEhJS3kwTHkxRlUzSk1TbE9uaTNsTUJqUzVv?=
 =?gb2312?B?VGZ4UnV0WWNMQTBNUmw1MC9JMXpoSDhueGxseld3UVFCZU9ub1dETHV1YUZJ?=
 =?gb2312?Q?VGPjGh8trqy6rqS4eF+IAow=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: R0l17IYXUN6DECnMB1NPJskc0nTs8Ped4xnFgy/rYHh00WVEma9pTiZissKf/F0JzgPye/08wKlrkakTKkPhTed2KwH899bhOpWBKBN1AeiPZ3YkbKdEspfJ81pG5Vh5BDHftV/Wjk6Qid17g4hJbgx0nyCQOjjte+aqAOsvRuUZarmtCzG9XywfjND34+2IAf/WVFGKqV09kl2T32Zla21UbC0mhPi5k8LI5pUh69VFwmy8kKZx4AeEfjPrR/AerRqAgUyJb5C/Ww2SDW76PJSu8qsLTcl04Y1SXyrr6KdNQSXPBCCIQC/Y3SpqyP4IqzYeNlWFpMv3sMSXKhxamPul87MUehdCP9NHZDRt/H2kLkIChWelxszIDdNIt5HQ3d6WgCC5q6xDQ6sS6hvohgBKiHNA+SrxEQ/QgAykRRmcYCxYDOeCfxkc/kksA8+7N2NZHf/id/C5KVJxn+suT8a1JtCxMNbuD84FrrtuNwt8IxjMREBujIs8DiHwkyM/t9xq3ZhgRiqJ4EqUDJuI3h4rH+QBQYrGUc1JhYjghVuyYyK5/BcL8PkcUU2811/YWBnLiOKm1qYQkvEuCwshW8fnx07PZBe+yX5aBVg7DUZjh7l8uPbUHdfkN3gcNoXm
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSQPR04MB7740.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3143474-bf75-4034-2892-08dcc3306c33
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2024 04:59:52.0654 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AE3zWstiur3rfztjb5aMutBF+kce5lAaiA6DvkTmbvkZ4pr8Z28l3wbXgAboWHzkzG97X2lKQTpKiWe07hMCTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR04MB8318
X-Proofpoint-ORIG-GUID: CrkdDYkYJbAMfci7N3enj4bdzWEsMHei
X-Proofpoint-GUID: CrkdDYkYJbAMfci7N3enj4bdzWEsMHei
X-Sony-Outbound-GUID: CrkdDYkYJbAMfci7N3enj4bdzWEsMHei
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-23_02,2024-08-22_01,2024-05-17_01
X-Mailman-Approved-At: Fri, 23 Aug 2024 15:36:19 +0200
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
PT09PT09PT09PT09PT09PT09PT09PQoKRml4OiBtb3ZlIHVzYiBwaHkgcG93ZXIgb2ZmIGludG8g
bXNtODkxNl91c2JwaHkgcmVtb3ZlLgoKU2lnbmVkLW9mZi1ieTogSmlhbmZlbmcgWmh1IDxKaWFu
ZmVuZ0EuWmh1QHNvbnkuY29tPgpSZXZpZXdlZC1ieTogSmFja3kgQ2FvIDxKYWNreS5DYW9Ac29u
eS5jb20+ClJldmlld2VkLWJ5OiBUb3lhbWEsIFlvc2hpaGlybyA8WW9zaGloaXJvLlRveWFtYUBz
b255LmNvbT4KLS0tCiBkcml2ZXJzL3BoeS9xY29tL21zbTg5MTYtdXNiaC1waHkuYyB8IDIwICsr
KysrKysrKysrKysrKysrKysrCiBkcml2ZXJzL3VzYi9ob3N0L2VoY2ktbXNtLmMgICAgICAgICB8
ICA0IC0tLS0KIDIgZmlsZXMgY2hhbmdlZCwgMjAgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMo
LSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL3BoeS9xY29tL21zbTg5MTYtdXNiaC1waHkuYyBiL2Ry
aXZlcnMvcGh5L3Fjb20vbXNtODkxNi11c2JoLXBoeS5jCmluZGV4IDRiNDM1YWEyYTYuLjBiYTUy
MGM5M2QgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvcGh5L3Fjb20vbXNtODkxNi11c2JoLXBoeS5jCisr
KyBiL2RyaXZlcnMvcGh5L3Fjb20vbXNtODkxNi11c2JoLXBoeS5jCkBAIC00Niw2ICs0NiwyNSBA
QCBzdGF0aWMgaW50IG1zbV9waHlfcG93ZXJfb2ZmKHN0cnVjdCBwaHkgKnBoeSkKIAlyZXR1cm4g
MDsKIH0KIAorc3RhdGljIGludCBtc21fcGh5X3JlbW92ZShzdHJ1Y3QgdWRldmljZSAqZGV2KQor
eworCXN0cnVjdCBwaHkgcGh5OworCWludCByZXQ7CisKKwlyZXQgPSBnZW5lcmljX3BoeV9nZXRf
YnlfaW5kZXgoZGV2LT5wYXJlbnQsIDAsICZwaHkpOworCWlmIChyZXQpCisJCXJldHVybiByZXQ7
CisKKwkvKiBUbyBhdm9pZCBOVUxMIHBvaW50ZXIgYWNjZXNzIGV4Y2VwdGlvbiBpc3N1ZSwgbW92
ZQorCSAqIGdlbmVyaWNfc2h1dGRvd25fcGh5IGZyb20gZWhjaV91c2JfcmVtb3ZlIHRvIGhlcmUK
KwkgKi8KKwlyZXQgPSBnZW5lcmljX3NodXRkb3duX3BoeSgmcGh5KTsKKwlpZiAocmV0KQorCQly
ZXR1cm4gcmV0OworCisJcmV0dXJuIDA7Cit9CisKIHN0YXRpYyBpbnQgbXNtX3BoeV9yZXNldChz
dHJ1Y3QgcGh5ICpwaHkpCiB7CiAJc3RydWN0IG1zbV9waHlfcHJpdiAqcCA9IGRldl9nZXRfcHJp
dihwaHktPmRldik7CkBAIC0xMDUsNSArMTI0LDYgQEAgVV9CT09UX0RSSVZFUihtc204OTE2X3Vz
YnBoeSkgPSB7CiAJLm9mX21hdGNoCT0gbXNtX3BoeV9pZHMsCiAJLm9wcwkJPSAmbXNtX3BoeV9v
cHMsCiAJLnByb2JlCQk9IG1zbV9waHlfcHJvYmUsCisJLnJlbW92ZQkJPSBtc21fcGh5X3JlbW92
ZSwKIAkucHJpdl9hdXRvCT0gc2l6ZW9mKHN0cnVjdCBtc21fcGh5X3ByaXYpLAogfTsKZGlmZiAt
LWdpdCBhL2RyaXZlcnMvdXNiL2hvc3QvZWhjaS1tc20uYyBiL2RyaXZlcnMvdXNiL2hvc3QvZWhj
aS1tc20uYwppbmRleCBmZjMzNjA4MmUzLi41NjU4NTllODA2IDEwMDY0NAotLS0gYS9kcml2ZXJz
L3VzYi9ob3N0L2VoY2ktbXNtLmMKKysrIGIvZHJpdmVycy91c2IvaG9zdC9laGNpLW1zbS5jCkBA
IC0xMTQsMTAgKzExNCw2IEBAIHN0YXRpYyBpbnQgZWhjaV91c2JfcmVtb3ZlKHN0cnVjdCB1ZGV2
aWNlICpkZXYpCiAJY2xrX2Rpc2FibGVfdW5wcmVwYXJlKCZwLT5pZmFjZV9jbGspOwogCWNsa19k
aXNhYmxlX3VucHJlcGFyZSgmcC0+Y29yZV9jbGspOwogCi0JcmV0ID0gZ2VuZXJpY19zaHV0ZG93
bl9waHkoJnAtPnBoeSk7Ci0JaWYgKHJldCkKLQkJcmV0dXJuIHJldDsKLQogCXJldCA9IGJvYXJk
X3VzYl9pbml0KDAsIFVTQl9JTklUX0RFVklDRSk7IC8qIEJvYXJkIHNwZWNpZmljIGhvb2sgKi8K
IAlpZiAocmV0IDwgMCkKIAkJcmV0dXJuIHJldDsKLS0gCjIuMjUuMQo=
