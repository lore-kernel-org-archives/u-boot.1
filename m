Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85CD3CCF9E5
	for <u-boot@archiver.kernel.org>; Thu, 30 Oct 2025 03:58:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AAD0783623;
	Thu, 30 Oct 2025 04:58:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="UqM4A26J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7404E83655; Thu, 30 Oct 2025 04:58:50 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D340800B6
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 04:58:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QLwP9tOKsIxj7Tx58+BFVKm6vIeD8xMuvNznJpXskqnVdFkwj3qR6Opu3BFMc9e5tbTzqTwAyXWixU2jG31/GQPYEHUW0G5fRHpSX8Oe0+Nz0YlPGdytUN9K8+DbMOFWsF7in0eszIx1du1fmofsTs+TO16nu2v1tZUCkW4wOd9hWX0gRUZiZNj9RXCT8JONBnjABuVoRnzfGobvwGCNVxAYVuFzitaFPWq0E/kDSbYs+3YsrDlBWE8jDSDh/5hpRKz+mTuaniJEYxpmDs3DslS5izEXxpiHi1WDnWQtVw3z7eJGta0DnyfcCh4ZUWj2MJDjfXq9PKtdjVibMSJ42A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=plRq9bHoXBUwv97Gd7uz1clOPj7ZTrpixgyNHfzhYsM=;
 b=sacnKaRLPlz+cVZmsRKXyuVT9jkbjQPzEK1V9NlGhOYJZxmrrGqaTsPGyTukIDtbL+sViAG6TcrXsRgkZqJ/Ntm3IBZ4NHOQS4sTpuCy3cLqdpxwPEGDflYEhGnb83IKX3yoPBYNBQB23meN+Qc9ZjB6UY9iG+eFazF46SfipSOUVQ5XwL8r/20Z4HUGpjZz8qYXlpWbeGPcgGCfzzQ6Bni0Tgp/1EyaBLj/3jTdA5yMwoyySDvc/TxKIv1Zhaowksr25fWAOET06nXD4ele9RWWCylI74M+DozzMlAk2Qm86aV4QyrEpFI2Lq6GkGyrNBxUFs0eQX+EbhDcNuw4hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=plRq9bHoXBUwv97Gd7uz1clOPj7ZTrpixgyNHfzhYsM=;
 b=UqM4A26JsM3ztPCLekXxoTgcmX5e0Ky/EJxKGM1dYnkfpPCjCXwWhlNpSj6DnYnf9d/x8LJRJ2ja3HnXDtY/UuvRc3G172+Gmr74vJoa0rRoBhfA2Fc5Jq8O62dYMCMpPUoLc90k3zHXJBZrCjnrZ1pWBNTS++1gwLr+PRol2rSnUEWVlriCvNv1LgbjIPSrUun2xDrl+MhasmrtcNnIS+EXuLho9de74nDfVk5Z5DjL0mFjNzshXgyNM9l44WtafViokGHmvx2zs65ayWtzP5cMECTSoO+ngarD11pxCSFiUr+dKoBEEEVqrjdEtUt3rmGiCmTdTUIciEoEmJW01A==
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by PA1PR04MB11059.eurprd04.prod.outlook.com (2603:10a6:102:485::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Thu, 30 Oct
 2025 03:58:44 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9275.013; Thu, 30 Oct 2025
 03:58:43 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: Marek Vasut <marek.vasut@mailbox.org>, "Alice Guo (OSS)"
 <alice.guo@oss.nxp.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Alice Guo <alice.guo@nxp.com>, Etienne Carriere
 <etienne.carriere@linaro.org>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Peng Fan <peng.fan@nxp.com>, Tom Rini
 <trini@konsulko.com>, Vinh Nguyen <vinh.nguyen.xz@renesas.com>, Viorel Suman
 <viorel.suman@nxp.com>, Ye Li <ye.li@nxp.com>
Subject: =?gb2312?B?u9i4tDogu9i4tDogW1BBVENIXSBmaXJtd2FyZTogc2NtaTogRHJvcCBtbXVf?=
 =?gb2312?B?c2V0X3JlZ2lvbl9kY2FjaGVfYmVoYXZpb3VyKCkgbWlzdXNl?=
Thread-Topic: =?gb2312?B?u9i4tDogW1BBVENIXSBmaXJtd2FyZTogc2NtaTogRHJvcCBtbXVfc2V0X3Jl?=
 =?gb2312?B?Z2lvbl9kY2FjaGVfYmVoYXZpb3VyKCkgbWlzdXNl?=
Thread-Index: AQHcSVF8VH31uGvtp0uM85TXtY6P3A==
Date: Thu, 30 Oct 2025 03:58:43 +0000
Message-ID: <PAXPR04MB964488C508F283B14E8B9B11E2FBA@PAXPR04MB9644.eurprd04.prod.outlook.com>
References: <20251025213537.238103-1-marek.vasut+renesas@mailbox.org>
 <PAXPR04MB9644A04B5499EA2BDC3130A7E2FDA@PAXPR04MB9644.eurprd04.prod.outlook.com>
 <e7063153-036d-4079-b9c0-252a5d1eb364@mailbox.org>
In-Reply-To: <e7063153-036d-4079-b9c0-252a5d1eb364@mailbox.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9644:EE_|PA1PR04MB11059:EE_
x-ms-office365-filtering-correlation-id: 05ad4ba3-e98c-4500-f89a-08de17689e9a
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|19092799006|38070700021; 
x-microsoft-antispam-message-info: =?gb2312?B?dnlPS0I4cWVTM2k3eGlYSjhsL3ZQQTFrOVFwMENlWkltazhjS3BDNHNWQ3Ri?=
 =?gb2312?B?ZjdDUlgwZmlDRXJ4bG9mQVgxMlA4TzhpYktNSEhxanVyV0xpbW9ad2QyM1h6?=
 =?gb2312?B?bnMxRWNKMzgwakFOcW1HRElpZzhFb2hwcXFFQWNsbkIwcEZpcjVKQWJjekJx?=
 =?gb2312?B?M2ZvUEtnMlhzdEFaTDFqWjhjYUU1dXUySTV6Q3JnSDZoWVpqcTRFWmNibnkx?=
 =?gb2312?B?cFVQRTB0OTFFK2lERTlGeU1hc1ZwR01iYy93elZ0TjI3L3lId3hIdzR5Q1ov?=
 =?gb2312?B?L3Q0VVRCNEt3d1JLclNRNXV3ajcxcHdNK3Y0Vk9va0FvbjlpQW5DZXZwRVMw?=
 =?gb2312?B?djhPZG4yeVhJUmdOMTZSWTh0alJtMmpEWlQvK2xMS3BPdDl5UkZPejJoaXlx?=
 =?gb2312?B?TVJrbDVwc1gxUU1QcHNwazB1WDFMZHlCbmV0QU8yOUVBMm5HT1Q0WUZYVnpY?=
 =?gb2312?B?RmFTTWVDcm85QVNEZ1lyb204cGlpMnpaS3hzSzhIUTN2MXhyUnl4SFZMRnNY?=
 =?gb2312?B?eHVHRWRmZStMaWR3aGNpd0lzbndqM0ljaU5ZN2ljbjVkUURHbUFjVVg4bzBp?=
 =?gb2312?B?OU9Ed2ZkWHdUSGdtMmxMZk9hWFNWWDZleUx3cWwzOWMwa2tLUVJ4NlJrT2w0?=
 =?gb2312?B?ZkJDYkdnb0UvOHlHN0RsYlNpZXYxMkhJb2xSRFlFQU9HZTM0VmltbkhqQ3F3?=
 =?gb2312?B?c0hJZFgwZmZQSXAwMk1JMlliYlBCbHJsNjNVNE0vZmdLd1pwa0dxcW80QXRt?=
 =?gb2312?B?aEVYZXBRT2NqemF4WmVnMVBaWHUvdUtjc3F6VUZSazVwRUMwNWFNSVJBbC9s?=
 =?gb2312?B?NXlBTFpZMkU1eWNFL3MxNzNlTUkxZS9sQ1hLSTltLzVkMG8vbVFVOThvSEdj?=
 =?gb2312?B?SzMzdmcxRnRHRW5RRHZQRC9qc2N6dVFpckxkZWZXRkdET3ZqY0M1V3FEbXN4?=
 =?gb2312?B?T2lSMW0vZ3ZjM0VBQUhzeVZPU3ZROUd6T3JKZDdqeU45ZkR4QWJxSytUbU9p?=
 =?gb2312?B?dFB4Y3ZkQ3JydEEzMEQ5aWd2QitFNnFQbG83LzZaZ05HOXM1Nmp5MHZRa2JW?=
 =?gb2312?B?eGUrelNDbmwrS1NqQ1doajVSZ1hzL0IzKzErN0JHV0VIYnA3M3ltM0xhMkFs?=
 =?gb2312?B?dW0zRmFIN3ltZWkvSXdVc2s3clJ2NTF3ZGU3OWRPODJSUGJJaGZBeitFRVE4?=
 =?gb2312?B?TVJGNHY1Zm50ekxBcmxBZ2NOVEVhVnVKNytvRVlLSXcrc3RyU0pCdmp3RGQy?=
 =?gb2312?B?d3RYOS9yYmRXejlOSi9KQ0xxUUhOeGw2TlBZZDBSMHlSNjFPSmdINnQyYjdS?=
 =?gb2312?B?UTlUNXhua3dtU1NoYk1MU0pGNVVVZVVNZngwYi9TWThSNU45TUdTUXl6aEJD?=
 =?gb2312?B?N2pBdWRFYXMwVFBlMkZjbDJZbVJ1LzVaMWM5Vnl3MldNQUxoUGZndkE2cTkw?=
 =?gb2312?B?Rjc2Vlllb2lteGw3YURvT1Vkakd4VW9sZjZ4d2xzVEs1T1FLdmt1dE81VkVv?=
 =?gb2312?B?VjN4SUlGdGFJamx4aVE2cEQ0MHQwVVVOY2VlZ1Zyb3FNZUg1NHowRm9DVDRt?=
 =?gb2312?B?NmpVTVlsWllZNDl4YnhHTG5icmlQekhIZ0t1dm1vN3lMRFI5U1krZEZsYmNt?=
 =?gb2312?B?UC9lU09VbWVQT2NvR0xXUm9rQmtJYTlNcTFQUjZXLzhSMVNraVM5YlpWSVJE?=
 =?gb2312?B?WFh2VnR2dVhXejQ2T1crQ1o4OHlwT2JrblZuZnlGYnh0TkZBSkgvMHdpMnFa?=
 =?gb2312?B?RG1NbUUvdklteDRVSGRhcGlqWnN6ZTRBYWVqZXZoYXJoQW44bzZ6bGRUT3Zh?=
 =?gb2312?B?Vmh3OHpLT2NMME1kYS9CMHFDQTlLY2l1T0NxV0hvTDVVNHNXTnhQZkNWSWRN?=
 =?gb2312?B?RWpncWZESEFvcTEwODFOMnRNY0JzMUcvUkp0ODZQYlJCT0tXd3NRaFpHSkta?=
 =?gb2312?B?L3U4Wno2UkJYQkJvVjA3ZmxhNzJwazMxYm92T0Z3MURpL3N2RGRwa2JtZlEz?=
 =?gb2312?B?SkNvdHpwblJZYU9iVnVobEtPL29EQ0REeTY1aExDTDRiTi9iV1dMWEZBQVc0?=
 =?gb2312?Q?iYHSDY?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(376014)(366016)(19092799006)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?ck8rZ2ZBdG9hVU1rOC9ZWndqVHp0UUZGK2tFQk1halMvSGNKWjR0cldoSzl3?=
 =?gb2312?B?bWZOdUMvcUc1Q3FleFBiblRWWFlBMDBsZUl3eXVvNk03bGdBWldDQjllVXd5?=
 =?gb2312?B?bmUreTUvajdsMS9wbnlWN0J3bC9DeVQ5VTJNSnhXWW1iNzRQOHAwcVRmeisv?=
 =?gb2312?B?VERzaVJJZGRtMzhGTEpnS3hPSDZoZjY4WjJpM3dLc1ZtWGpxNm9IMnc0cUlJ?=
 =?gb2312?B?ZStZa2F6Z21hMFQ4REgyZXRXcGVGYW1Gb0UxYnJ0ZnJMcFQrWXlpUGNNamti?=
 =?gb2312?B?ZDVIaTQ2Y2F2K1RWM1ErRG9ONk54dWxMa0JwblhHN1lwU0JmdFhpNVViUnhE?=
 =?gb2312?B?cWpQRFE3WnB1QzhKY3FDeFNDSk9CeVlicU1kTVhybXIwZVZuRFFXMk9HK1lO?=
 =?gb2312?B?OFA4Ky9NeWNmZ0Z2MkliUkNqVUNMVGJrajMwZDhFSitKOVZNNit6WnBxVW9O?=
 =?gb2312?B?aUEzUTQ1R1phaEZ0bmhjSnpRVE8vU0J1RDltNS9aaURuVVNzOXQ3MXR0ZU5E?=
 =?gb2312?B?ZUpCM3U4elk5MW85c1Q4M3l4dGUzb0llMDJPVGo1eG15UkdZSFdvZVR0d3BY?=
 =?gb2312?B?MFl4YzUzZmhhUWQ0ZjdId28wbGVtdm01bUw0NFAyVm1FRWxEb2FHaHZncDlJ?=
 =?gb2312?B?Tm1FOUN3WVRueUNRY01FV091NW5tc21vTkRNNnhrdGJBUnZJdFg1RDltWnVt?=
 =?gb2312?B?azVMaC9pTmpweTF1aW1HNFFyOHE2eUZaL0FpVmdDZGlFRkVQdDBmNlpPWitn?=
 =?gb2312?B?YnpkTjBLOEJZdG9nV21QTHV4Yi9wb2lxSzZCMk1PSnVxTFVNR2JDMjF6VTBq?=
 =?gb2312?B?V2FZMGxjZ3hxYko4TzRPVWRpTlFic0VKeTl5dmNTQU15VEtmVjI0NTJnZU8r?=
 =?gb2312?B?Z2w0VjRLMXpVSUphQ2VYTWlxdSs0UDgxMHpzM3UyK2JNajh6ZEw0SjNTdUlo?=
 =?gb2312?B?Z1RQNDNXcXl4eHJ2dUoyT25sL3d0OENFaW5PeDl0L2J1a1JYUXZYbU96azFI?=
 =?gb2312?B?R1l4eWhsV3NQOEE4Yk1IVzVSWFFKMVZwL2x2Uk9VdjlzbGhtc3RueXlwd0Jl?=
 =?gb2312?B?YTdhRHZNbVhYWWdNcm5WNmJGdTdoVWtKL2ZuOVVMYzhTN3U5ZmU1Z3hkdFl0?=
 =?gb2312?B?cE1zUTdiWmlOV3J2RXI4ZjN2RkRJZnVrWC9JTkFlSUwzZlMvWi9OL3RBVFZH?=
 =?gb2312?B?Um5CaDJnbDNYUFhsUWswK2RqMTdiWTdib2hnVllNbDAyc3RuSmp3Ynd5Q1ND?=
 =?gb2312?B?dTBxUTZSMjl6NW5aMkVkZjBieUNlOStLOFl3dlhWWklIbVJoNU1rUml3eXow?=
 =?gb2312?B?Vjh0ejJES1Y2c3RwakRpUUdSeTdJYVJiVmRLbDBidURwd0tkZzF0ak1JU2t2?=
 =?gb2312?B?UGYwQzZZOFRVZ2NlQ2N0NU5OdmJLeW9zN0ZKY2FRUTBSRk9xMjVsclNhSzk0?=
 =?gb2312?B?MzNmY1UwbWkrd2s5WGJJTkh5alNuRkZvTEI4azVpL1NlQ09Jb0h0Y3FTN2dz?=
 =?gb2312?B?dzg4WE9kOUhTbUZwZWZaTEVidUd6dFBiL3k0L2tqcERIV2RTOXJnYVFPTzNt?=
 =?gb2312?B?SU5zejlrUkJDNzJxdTF4eFJ0cTdydGpaRGg0TU1YQTJIREZOMnh0YVlieWxK?=
 =?gb2312?B?cVp1eW5taWFTOFVSc3JTa2R3a3dXaDJwZUQ4cWhDWjBGOGtaOS9nNWl2V3or?=
 =?gb2312?B?MUk2bnByYzRRM2ZReVBPK1JQOVFjbGNpWE5vTG9RUEhIazZrNWZ6SU8reitr?=
 =?gb2312?B?MGVsM09oVE42dlp3NW1admhoVzV2ZG9oTlE2Q2JNQVp3SHVwajBBQ2piNStP?=
 =?gb2312?B?MGk5RGFTaXRuWm10T3FRVGVpZi9EdzU5ekZ6d0tiWWoyY0VzckV3L0tVSWYz?=
 =?gb2312?B?a3BZUktFSVBJcVNGN1RNbkZjZVF5WnFlb3krY0NCZWNYYUdtaURJMEgzRFB0?=
 =?gb2312?B?OFQ3N0sraG1jUFRZcmVlYVNsZThZbnZIZXVYcmZpTkQwamNOcUowZVliOGZR?=
 =?gb2312?B?TTN4blo0cjZNRk1BNHJiU3d2eFo3UGlMbWtIZGVsTE5uOW1IYU11NmhYMWJt?=
 =?gb2312?B?OHRsdTBwbGErRDgxaFdLalpqTGNranpFOHpwWjR2YjVLaGVYdzNHZEtYK21p?=
 =?gb2312?Q?KXfM=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05ad4ba3-e98c-4500-f89a-08de17689e9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2025 03:58:43.7933 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XmupI+K75z9YaWyk7gUgH1+Q/yiJ2AO3ijXYCBOw3fNujg4bpMn2u6aJzyx4I8NipheGH5bylA6e2bAYcasNUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11059
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

PiAtLS0tLdPKvP7Urbz+LS0tLS0NCj4gt6K8/sjLOiBNYXJlayBWYXN1dCA8bWFyZWsudmFzdXRA
bWFpbGJveC5vcmc+DQo+ILeiy83KsbzkOiAyMDI1xOoxMNTCMjjI1SAyMjozOQ0KPiDK1bz+yMs6
IEFsaWNlIEd1byAoT1NTKSA8YWxpY2UuZ3VvQG9zcy5ueHAuY29tPjsgTWFyZWsgVmFzdXQNCj4g
PG1hcmVrLnZhc3V0K3JlbmVzYXNAbWFpbGJveC5vcmc+OyB1LWJvb3RAbGlzdHMuZGVueC5kZQ0K
PiCzrcvNOiBBbGljZSBHdW8gPGFsaWNlLmd1b0BueHAuY29tPjsgRXRpZW5uZSBDYXJyaWVyZQ0K
PiA8ZXRpZW5uZS5jYXJyaWVyZUBsaW5hcm8ub3JnPjsgUGF0cmljayBEZWxhdW5heQ0KPiA8cGF0
cmljay5kZWxhdW5heUBmb3NzLnN0LmNvbT47IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPjsg
VG9tIFJpbmkNCj4gPHRyaW5pQGtvbnN1bGtvLmNvbT47IFZpbmggTmd1eWVuIDx2aW5oLm5ndXll
bi54ekByZW5lc2FzLmNvbT47IFZpb3JlbA0KPiBTdW1hbiA8dmlvcmVsLnN1bWFuQG54cC5jb20+
OyBZZSBMaSA8eWUubGlAbnhwLmNvbT4NCj4g1vfM4jogUmU6ILvYuLQ6IFtQQVRDSF0gZmlybXdh
cmU6IHNjbWk6IERyb3ANCj4gbW11X3NldF9yZWdpb25fZGNhY2hlX2JlaGF2aW91cigpIG1pc3Vz
ZQ0KPiANCj4gT24gMTAvMjgvMjUgOTowMCBBTSwgQWxpY2UgR3VvIChPU1MpIHdyb3RlOg0KPiA+
PiAtLS0tLdPKvP7Urbz+LS0tLS0NCj4gPj4gt6K8/sjLOiBVLUJvb3QgPHUtYm9vdC1ib3VuY2Vz
QGxpc3RzLmRlbnguZGU+ILT6se0gTWFyZWsgVmFzdXQNCj4gPj4gt6LLzcqxvOQ6IDIwMjXE6jEw
1MIyNsjVIDU6MzUNCj4gPj4gytW8/sjLOiB1LWJvb3RAbGlzdHMuZGVueC5kZQ0KPiA+PiCzrcvN
OiBNYXJlayBWYXN1dCA8bWFyZWsudmFzdXQrcmVuZXNhc0BtYWlsYm94Lm9yZz47IEFsaWNlIEd1
bw0KPiA+PiA8YWxpY2UuZ3VvQG54cC5jb20+OyBFdGllbm5lIENhcnJpZXJlIDxldGllbm5lLmNh
cnJpZXJlQGxpbmFyby5vcmc+Ow0KPiA+PiBQYXRyaWNrIERlbGF1bmF5IDxwYXRyaWNrLmRlbGF1
bmF5QGZvc3Muc3QuY29tPjsgUGVuZyBGYW4NCj4gPj4gPHBlbmcuZmFuQG54cC5jb20+OyBUb20g
UmluaSA8dHJpbmlAa29uc3Vsa28uY29tPjsgVmluaCBOZ3V5ZW4NCj4gPj4gPHZpbmgubmd1eWVu
Lnh6QHJlbmVzYXMuY29tPjsgVmlvcmVsIFN1bWFuIDx2aW9yZWwuc3VtYW5AbnhwLmNvbT47DQo+
IFllDQo+ID4+IExpIDx5ZS5saUBueHAuY29tPg0KPiA+PiDW98ziOiBbUEFUQ0hdIGZpcm13YXJl
OiBzY21pOiBEcm9wIG1tdV9zZXRfcmVnaW9uX2RjYWNoZV9iZWhhdmlvdXIoKQ0KPiA+PiBtaXN1
c2UNCj4gPj4NCj4gPj4gTU1VIHJlZ2lvbiBjYWNoZSBiZWhhdmlvciBjb25maWd1cmF0aW9uIGZv
ciBTQ01JL1NNVCBtYWlsYm94ZXMgaXMNCj4gPj4gcGxhdGZvcm0gc3BlY2lmaWMuIEV2ZW4gb24g
QVJNIHN5c3RlbXMsIHRoZSBtYWlsYm94IG1lbW9yeSBtYXkgbm90DQo+ID4+IGV2ZW4gYmUgbG9j
YXRlZCBpbiBhbnkgY2FjaGVhYmxlIE1NVSByZWdpb24gYW5kIG1heSBpbnN0ZWFkIHJlc2lkZSBp
bg0KPiA+PiBzb21lIFNSQU0uIFJlbW92ZSB0aGlzIG5vbi1nZW5lcmljIGNhY2hlIGJlaGF2aW9y
IGNvbmZpZ3VyYXRpb24gY29kZQ0KPiBmcm9tIGdlbmVyaWMgY29kZSBwYXRoLg0KPiA+Pg0KPiA+
PiBJdCBpcyB1bmxpa2VseSB0aGF0IGFueSBwbGF0Zm9ybSBpcyBhZmZlY3RlZCBieSB0aGlzIGNo
YW5nZSBpZiBpdCBkaWQNCj4gPj4gY29uZmlndXJlIGl0cyBNTVUgcmVnaW9ucyBjb3JyZWN0bHkg
b24gc3RhcnQgdXAuIFBsYXRmb3JtcyB3aGljaA0KPiA+PiBtaWdodCBiZSBhZmZlY3RlZCBhcmUN
Cj4gPj4gaS5NWDk0Lzk1IGFuZCBTVE0zMk1QLg0KPiA+Pg0KPiA+PiBGaXhlczogMjQwNzIwZTkw
NTJmICgiZmlybXdhcmU6IHNjbWk6IG1haWxib3gvc210IGFnZW50IGRldmljZSIpDQo+ID4+IEZp
eGVzOiAyYTNmMTYxYzhiMTYgKCJzY21pOiBjb3JyZWN0bHkgY29uZmlndXJlIE1NVSBmb3IgU0NN
SSBidWZmZXIiKQ0KPiA+PiBGaXhlczogYjJhZTEwOTcwZDQwICgiZmlybXdhcmU6IHNjbWk6IHVz
ZSBQQUdFX1NJWkUgYWxpZ25tZW50IGZvcg0KPiA+PiBBUk02NCIpDQo+ID4+IFNpZ25lZC1vZmYt
Ynk6IE1hcmVrIFZhc3V0IDxtYXJlay52YXN1dCtyZW5lc2FzQG1haWxib3gub3JnPg0KPiA+PiAt
LS0NCj4gPj4gQ2M6IEFsaWNlIEd1byA8YWxpY2UuZ3VvQG54cC5jb20+DQo+ID4+IENjOiBFdGll
bm5lIENhcnJpZXJlIDxldGllbm5lLmNhcnJpZXJlQGxpbmFyby5vcmc+DQo+ID4+IENjOiBQYXRy
aWNrIERlbGF1bmF5IDxwYXRyaWNrLmRlbGF1bmF5QGZvc3Muc3QuY29tPg0KPiA+PiBDYzogUGVu
ZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+DQo+ID4+IENjOiBUb20gUmluaSA8dHJpbmlAa29uc3Vs
a28uY29tPg0KPiA+PiBDYzogVmluaCBOZ3V5ZW4gPHZpbmgubmd1eWVuLnh6QHJlbmVzYXMuY29t
Pg0KPiA+PiBDYzogVmlvcmVsIFN1bWFuIDx2aW9yZWwuc3VtYW5AbnhwLmNvbT4NCj4gPj4gQ2M6
IFllIExpIDx5ZS5saUBueHAuY29tPg0KPiA+PiBDYzogdS1ib290QGxpc3RzLmRlbnguZGUNCj4g
Pj4gLS0tDQo+ID4+ICAgZHJpdmVycy9maXJtd2FyZS9zY21pL3NtdC5jIHwgMTQgLS0tLS0tLS0t
LS0tLS0NCj4gPj4gICAxIGZpbGUgY2hhbmdlZCwgMTQgZGVsZXRpb25zKC0pDQo+ID4+DQo+ID4+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Zpcm13YXJlL3NjbWkvc210LmMNCj4gPj4gYi9kcml2ZXJz
L2Zpcm13YXJlL3NjbWkvc210LmMgaW5kZXgNCj4gPj4gMjM3ODcxNTU5ZjAuLmNkMWMwODAxZjcy
IDEwMDY0NA0KPiA+PiAtLS0gYS9kcml2ZXJzL2Zpcm13YXJlL3NjbWkvc210LmMNCj4gPj4gKysr
IGIvZHJpdmVycy9maXJtd2FyZS9zY21pL3NtdC5jDQo+ID4+IEBAIC02MSwyMCArNjEsNiBAQCBp
bnQgc2NtaV9kdF9nZXRfc210X2J1ZmZlcihzdHJ1Y3QgdWRldmljZSAqZGV2LA0KPiA+PiBzdHJ1
Y3Qgc2NtaV9zbXQgKnNtdCkNCj4gPj4gICAJaWYgKGRldmljZV9pc19jb21wYXRpYmxlKGRldiwg
ImFybSxzY21pIikgJiYNCj4gPj4gb2Zub2RlX2hhc19wcm9wZXJ0eShkZXZfb2Zub2RlKGRldiks
ICJtYm94ZXMiKSkNCj4gPj4gICAJCXNjbWlfc210X2VuYWJsZV9pbnRyKHNtdCwgdHJ1ZSk7DQo+
ID4+DQo+ID4+IC0jaWZkZWYgQ09ORklHX0FSTQ0KPiA+PiAtCWlmIChkY2FjaGVfc3RhdHVzKCkp
IHsNCj4gPj4gLQkJdTMyIGFsaWduX3NpemU7DQo+ID4+IC0NCj4gPj4gLQkJaWYgKElTX0VOQUJM
RUQoQ09ORklHX0FSTTY0KSkNCj4gPj4gLQkJCWFsaWduX3NpemUgPSBQQUdFX1NJWkU7DQo+ID4+
IC0JCWVsc2UNCj4gPj4gLQkJCWFsaWduX3NpemUgPSBNTVVfU0VDVElPTl9TSVpFOw0KPiA+PiAt
DQo+ID4+IC0NCj4gPj4gCW1tdV9zZXRfcmVnaW9uX2RjYWNoZV9iZWhhdmlvdXIoQUxJR05fRE9X
TigodWludHB0cl90KXNtdC0+YnVmLA0KPiA+PiBhbGlnbl9zaXplKSwNCj4gPj4gLQkJCQkJCUFM
SUdOKHNtdC0+c2l6ZSwgYWxpZ25fc2l6ZSksIERDQUNIRV9PRkYpOw0KPiA+PiAtCX0NCj4gPj4g
LSNlbmRpZg0KPiA+PiAtDQo+ID4+ICAgCXJldHVybiAwOw0KPiA+PiAgIH0NCj4gPj4NCj4gPj4g
LS0NCj4gPj4gMi41MS4wDQo+ID4NCj4gPiBUZXN0ZWQtYnk6IEFsaWNlIEd1byA8YWxpY2UuZ3Vv
QG54cC5jb20+DQo+ID4NCj4gPiBUZXN0ZWQgb24gdHdvIGJvYXJkczogSU1YOTQgYW5kIElNWDk1
LiBObyByZWdyZXNzaW9ucyB3ZXJlIG9ic2VydmVkDQo+IGR1cmluZyBib290LiBMb29rcyBnb29k
IHRvIG1lLg0KPiBUaGFuayB5b3UgIQ0KDQpIaSBNYXJlaywNCg0KQXBwbGllZCB0aGlzIHBhdGNo
IG9uIHRoZSBVLUJvb3QgTlhQIHRyZWUgYW5kIGZvdW5kIHRoYXQgaXQgYWZmZWN0cyB0aGUgaS5N
WDhVTFAuIE9uIGkuTVg4VUxQLCB0aGUgU0NNSSBidWZmZXIgaXMgaW4gU1JBTSBhbmQgbWFwcGVk
IGFzIG5vcm1hbCBtZW1vcnkuDQoNClUtQm9vdCAyMDI1LjA0LWcyNmEyNGYxYTJmZTYtZGlydHkg
KE9jdCAyOSAyMDI1IC0gMTg6MDc6MTMgKzA4MDApDQoNCk0zMyBTeW5jOiBPSw0KQ1BVOiAgIGku
TVg4VUxQKER1YWwgNykgcmV2MS4xIGF0IDgwME1Ieg0KQ1BVIGN1cnJlbnQgdGVtcGVyYXR1cmU6
IDI4DQpSZXNldCBjYXVzZTogUE9SDQpCb290IG1vZGU6IFNpbmdsZSBib290DQpNb2RlbDogTlhQ
IGkuTVg4VUxQIEVWSw0KRFJBTTogIDIgR2lCDQpzY21pLW92ZXItc21jY2Mgc2NtaTogQ2hhbm5l
bCB1bmV4cGVjdGVkbHkgYnVzeSBzY21pX2Jhc2VfZHJ2IHNjbWktYmFzZS4wOiBnZXR0aW5nIHBy
b3RvY29sIHZlcnNpb24gZmFpbGVkIHNjbWktb3Zlci1zbWNjYyBzY21pOiBmYWlsZWQgdG8gcHJv
YmUgYmFzZSBwcm90b2NvbCBpbml0Y2FsbCBmYWlsZWQgYXQgY2FsbCAwMDAwMDAwMDgwMjJhODkw
IChlcnI9LTE2KSAjIyMgRVJST1IgIyMjIFBsZWFzZSBSRVNFVCB0aGUgYm9hcmQgIyMjDQoNCkJl
c3QgcmVnYXJkcywNCkFsaWNlIEd1bw0K
