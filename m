Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D407CFA46E
	for <u-boot@archiver.kernel.org>; Fri, 21 Nov 2025 04:08:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 480D283693;
	Fri, 21 Nov 2025 05:08:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=unsw.edu.au
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=unsw.edu.au header.i=@unsw.edu.au header.b="QVjzEkDY";
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=unsw.edu.au header.i=@unsw.edu.au header.b="dYxzUs2P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0A0F807B1; Fri, 21 Nov 2025 03:35:51 +0100 (CET)
Received: from mx0a-004a3801.pphosted.com (mx0a-004a3801.pphosted.com
 [205.220.161.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6F89802C1
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 03:35:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=unsw.edu.au
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=i.velickovic@unsw.edu.au
Received: from pps.filterd (m0437972.ppops.net [127.0.0.1])
 by mx0a-004a3801.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5AL0k3eW791242
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 13:35:44 +1100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unsw.edu.au; h=
 content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pps1; bh=P+31eGVIoqonGSG2Cqi1arMC99GsA
 kQPVl/gLersd+I=; b=QVjzEkDYAAabxniaSB5PI9z8j0N680fUwqErtp8LsU2PI
 mCBlVs/oLMyxxzpmZqtFrlHuQwusZLqkVuyJqrSQPBeifjbJspxQdMENt5xXG2Cu
 ln7pzqsHoFD6tDzE+ufUsUaiUfabeqChzvd5HmlYMhH3GOFDB+5qbiKxVvJF+cvO
 XfN/P8iieA2uC966MkWM+o47iDopmA2VC54Rpgv7JOMb3+dsqFflBHDlbLvOpZVe
 D35mfKZe2pkO0Lq7nuXsTdQQB3Mn+LSdLDyQJyuHXXbKFXLlmy6mYtgspVURLd6X
 Q/EeqKFuChEPlBsNA756nIaLikXgL8AKsJU2VkQkw==
Received: from sy8pr01cu002.outbound.protection.outlook.com
 (mail-australiaeastazon11010048.outbound.protection.outlook.com
 [52.101.150.48])
 by mx0a-004a3801.pphosted.com (PPS) with ESMTPS id 4aj598anc4-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 13:35:44 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=njZmQqNKKrgrAvMVAGBE7nJcqpB+yzhsSdOTqotI9Dyvh6Yg9Qi5H/AOXYCutP5cbLwYcPt7u2tYjlW9nnJqkXaVqW2qQxoiLw6VYyCVy4+ezr7bOXMF5vgoBdA9pgFeR7yIQXZ53xYHmNusbl9TTRcB7Za/7Xp8aJcU03stlravg/MAVbLQ3SU1J1QhaUbWZ7BH5VIzrF/g031gvVKLjGnq5t4z/kB0WOqgZROrp/fOzlmiCDBoXsy7Cp4Yg6A0Ljr/nWPS1nyPMAkhvBWfSmFDVB7xyShRLMoGclDBCvsXyAQT3jDpCCxkGo9LSWARIollg4JfeWo5sF2VsmvkEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P+31eGVIoqonGSG2Cqi1arMC99GsAkQPVl/gLersd+I=;
 b=bX7714gyL9zhcKzyCuhabt9TpLWSO0UBJTznxGgnBtzmxw23ebDpi3iE4C1/52qAzajiT9X7qQVwyA/IsraMiwWctuBMDpEpRPoLj9RfUkEou1qoYmQgGsk3Q/94MMxK1j2rQjS+vYlBQeLwAP+f6CsZCt8q4jRle1miPNAyghAZ0HSsk0bBvyO9PwLKSYxjJnSTnO+sDts1+PMT47+vV0wT+fu2X2unNcaLN1gP/CIamRA6f0dzBlWeDHI1sZ04WJ5Ok7QNKd1IloInZP7ZzfLbMQXJ+4UoNTEVGGfT+22lJhx68Hf+HFdZclZ/Goc+5hRDVm+nJlRJVP4YfIeeLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=unsw.edu.au; dmarc=pass action=none header.from=unsw.edu.au;
 dkim=pass header.d=unsw.edu.au; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unsw.edu.au;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P+31eGVIoqonGSG2Cqi1arMC99GsAkQPVl/gLersd+I=;
 b=dYxzUs2P0wYi2Svd9Q4RinhL+0+7dmGCEaWPR87e/DJbLTHjJFddG9GozoZvEYQ0aW1IzzNC+txvrR7T60x24Us0VziBpzt9uMbZN3kE9fdLL7P+w5tTCVxqXeaMesH4duVqFSwCfUiOwv6RLqVc9YiiN0nNn/d8UkCFRx0i4DY=
Received: from SYCPR01MB4015.ausprd01.prod.outlook.com (2603:10c6:10:3e::16)
 by SYBPR01MB5903.ausprd01.prod.outlook.com (2603:10c6:10:9c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Fri, 21 Nov
 2025 02:35:40 +0000
Received: from SYCPR01MB4015.ausprd01.prod.outlook.com
 ([fe80::1706:211f:3cf6:db9a]) by SYCPR01MB4015.ausprd01.prod.outlook.com
 ([fe80::1706:211f:3cf6:db9a%4]) with mapi id 15.20.9343.011; Fri, 21 Nov 2025
 02:35:40 +0000
From: Ivan Velickovic <i.velickovic@unsw.edu.au>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: Query on RISC-V booting ABI
Thread-Topic: Query on RISC-V booting ABI
Thread-Index: AQHcWoqnagDnTl/4MEm8HJdn6H4Yx7T8aewA
Date: Fri, 21 Nov 2025 02:35:40 +0000
Message-ID: <F6239687-D1DB-4A34-8928-E6FD4FA7D274@ad.unsw.edu.au>
References: <000D2537-636F-493E-8E6E-2BC18916A6BD@ad.unsw.edu.au>
In-Reply-To: <000D2537-636F-493E-8E6E-2BC18916A6BD@ad.unsw.edu.au>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SYCPR01MB4015:EE_|SYBPR01MB5903:EE_
x-ms-office365-filtering-correlation-id: 65332a30-7b45-4382-61bc-08de28a6a940
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700021|13003099007|8096899003; 
x-microsoft-antispam-message-info: =?utf-8?B?SnhUUXhTdVhwOU9TYWNDTUZXajNka2R0Y0E1cEhoSmduYld4Nk5HckZxRDZo?=
 =?utf-8?B?c2kxUWV1TDlmQ2tuSW5EYmp1S0pyNDVEbDl3b2N6OVNiSVhycXlnbUlab1lH?=
 =?utf-8?B?UkNyQVNlNzlSTW95YnAwakYrWmt3dkpnTmJYeVZRenNlM29VVytlZk9iT0lu?=
 =?utf-8?B?L0JIaVkycWlqTldqMjg2M2ZVWVZRVEdWS0lHNFpyNnp2ejJvR0FyenNXQ1JQ?=
 =?utf-8?B?VVA5bEJNdjRNVUx6S0F6Yml1WlpoOHdWNXlFd3p6Z05USjQ4Qm8rL3NESXl3?=
 =?utf-8?B?a3YwUXNtYzdaQzhtaEZneE1IekVMNHNhenNBV3RONEpyU1FvM3pOU1hRTjJn?=
 =?utf-8?B?eCswTVZSV0IwM2NZaXEzR0RqeW9mVVQ3UFJrL2N6aEQvMHBjQWpMSHlRUXZt?=
 =?utf-8?B?UXZ5YksyNTc1cCtPYlRkNWFVNFJFcG9zN25DOHJaaUFERi9naEFjdmxLVDBt?=
 =?utf-8?B?MldjQ25FK3pIOEpEVDN3MFRHUDh1VnNOdXRZRHp4TkdYaWdMbGlMYTVBWjFJ?=
 =?utf-8?B?czIzOUg4alVpTFU5UGI3YytDYzZUWWQ1dzY1MzJ0S0liaHFRbXNsa3ZDQVRx?=
 =?utf-8?B?UnQyOW5DaTZHRUUrZERUQjBQOG9FeHBCWitPNnNpalN2bWt6WmM1Y2hwV0d4?=
 =?utf-8?B?L0E3Lzg4bDc4R04zRjZzNTl3azZPWU1MMm9HZkR5QjJpSWVWd053b3NsQll2?=
 =?utf-8?B?THo0OGhaL25mbGZXbEt1UTJDcTFFTTVuQlViSmsrR0tPcEorR2FTQ0g4Rmhy?=
 =?utf-8?B?SmJjbVFkT2VUWExLUGt0ZmNEeHVaaU8ydGJKRm1HWlVpaVc1OWtMcmY0U1dv?=
 =?utf-8?B?c0ZWVWhrK0hBaGlQMWdZU2s1Vk9zRlVQZ08xZW9HelNPUDdRazVwTXRKQW1K?=
 =?utf-8?B?Rm16M2thZ1g3SUtOUzRSS3NBL0gyY2phbjZSVGh6L2RMd2liWnArZ1UxZk5U?=
 =?utf-8?B?NkNpbkRCRDgrbUxiZ3lyd1d3cmk2S05NMWdCdkFsRCsrQlV6OFZsWWV1dDFD?=
 =?utf-8?B?b3FUdHFmWUh4Ukc0K29kUDR4UTFydGV5VDJJazh5TEJyUkZWQW5PaVptV1hP?=
 =?utf-8?B?V0lTNGtnYnk5NXU1TDQ4TkFpcDFnaDBIdXFnSnRKVy9JVThWcUtIU3FDSTBz?=
 =?utf-8?B?VHVlTjRueXNGdlJTRlpPWCtKa3g4R0piVXFvdThoVmFqVkJMSy9mUlNPbWJx?=
 =?utf-8?B?V1FkSXMrQnJJY3UySHhGNk9FWXo3WXk3NkxvYmNuOVY0L3BTMHNaZnVYaC9q?=
 =?utf-8?B?YTZsckM1T2N3MWFPZm9CWTMzZ052aUg4cTl3OEtBbjdTWEtLT3VRdW1PcFBN?=
 =?utf-8?B?TmFMV3l6ak9mWDMxbGkxQVF3TU5pd20rVC9nV0lPTEk2U3dRanRFWUNDSXUx?=
 =?utf-8?B?TWZSMlFNU2RvMHdoM3F5NnBpdGduMlFhUDNUNlpSdkJNMEhhUlJLTDB5NS9r?=
 =?utf-8?B?WFpvelZDYStJQjZnWFZmWGE1YnNRbVJ6dVZtN2RIYnJjM2ZnU3VHWnZDL1dw?=
 =?utf-8?B?RkZSNDJtcUcydDBaTEFCMHZ5RDA4VTFQY0wwTnlTRnZjaVc0RVJhbXBwSUxS?=
 =?utf-8?B?a2VnRFpLMHNWem9QQjdKdEU0SkFadDVWVWlDSXdNTklvUFF5RWhUWW53M2Fo?=
 =?utf-8?B?RWF3MTJmbER2V0luMitUc1pWdXFWaWhUZ0g1NTdWMnFyTXJqaW02N1hoenpl?=
 =?utf-8?B?Z1huc2pqZ1BkYUQySjR0ZlpGTG1JR2NmK0JjWVprWWRJVHJWWlFwUi8zaENu?=
 =?utf-8?B?TWZYUDdxcnNDeEkrSjFDdjhVbXNCT3M2UEFJWXNhLytFc1ZaRzltdXJBQzU5?=
 =?utf-8?B?R0ttYjBTNEVuSFBzenFhZTZ4TDlTS2k5WG1UR3lpdjJDZkl3ZEw5RWVTamhC?=
 =?utf-8?B?WnQvZ2k0cFhGditKeHNrZlVPbXZtK3hSUXJpNUNLVHd1dmlYQ1dHK0IySVVT?=
 =?utf-8?B?eTZWN3RFSFJ0NFpzK0FVY0Z5ZEdhNThOZTNXc0tOeHdXMEFNYlhDdzZ5MkhC?=
 =?utf-8?B?ZER0djM1NUhDbVJCcFV5WUtKcXpzVUZXSVpCdFpPQjhxVFlPby9SQ0ZRMkN4?=
 =?utf-8?Q?CDIVUg?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SYCPR01MB4015.ausprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(13003099007)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?STFrZTl1cTRjNXEyTEdPdlliT3hOQnpsYU1EZWdmTHV6ZVpMSDFVRThVcHo3?=
 =?utf-8?B?S3BrNTZjS3FlN0Z6Q1NFUFhsVzk0WDA2TUdON0x5Q3BKTFpPUTZHRjQrOGRs?=
 =?utf-8?B?LzRDMGlmeGdLWG44ZXM4ZVV5NmdET0t5VWdpYkl5eHc4MnBjQzZsK3N2dFJl?=
 =?utf-8?B?K0x0dDVjaVQ5TUJrQzB1bWlXZkVRZWRFTm9XUFIzVXdGL1B0Q0RXSDhxSGNY?=
 =?utf-8?B?WjVNcFFmcHNSL0MvSTNWcEUvN09IdkVsSmtuaU9WaUp6SjcxVW5PVWlhLzFw?=
 =?utf-8?B?QUh5V3dJSmI4bE1xSkI3eTQvWFN6STVMYjAwbXZ3aGNzQkhoMjE5Q0FQVG9s?=
 =?utf-8?B?cmFSQWtGZXVlaUlyWmJGYkNTYkM1MFEzcnhUd29LVVJGNWpWM0tHMVhlc0Uy?=
 =?utf-8?B?RmM4TEh1VW0xR2RLS2d5WWNrZmF0UEhTQmJMUmNUWXQrYmFYZ1pMMERSMXlE?=
 =?utf-8?B?NlhBclA2Q2Zxb2w1VjBaaWRtdmJOakFEcEpOWW9OR05hb2wxdW9UQldsdVN2?=
 =?utf-8?B?Y0pqVVA1d1pqdGNXZjM0VmRDbXBwVDhxWXk1WHhvYWJHdEE3azdaRmRET2ZQ?=
 =?utf-8?B?aXVjcitqTUJjSjNFKzB6WEFhRDhZVDRKR2R6Z1BFM2lyYzE4UXp1a0hBT2hC?=
 =?utf-8?B?Y0lLY0daUVkxNzhhVDdzMWhzYTB6RjNETGJoUldwdXNjYVJHZmZ2UmZ0Tm9h?=
 =?utf-8?B?Y0Q2NGdHSE5OdnJldGo5Y0IrbjdtUjdiNjFiRGwxL05DcVlDSzdESlFWd3NE?=
 =?utf-8?B?R1hXUDJ1Z0RrOGZCdWM1RWJCYXRBYlpreFdqWkIzTmNoVTFHYlZ0MUVuRVU5?=
 =?utf-8?B?bVphT1U4akVGbUJ6VElUN3Z5eTYxdHgrRkk5N3pJSEJQS2IwL0xiakYwenB6?=
 =?utf-8?B?S01wdkNTUWNybWdUZ2pmVEd6blVkRzVhZ2hTeldqTFpaZWJVbnVldzB4dkFS?=
 =?utf-8?B?aWZ1YVh3aE52U3JQRFJ3Nm55QWpjSUhLd1c1UWpHaFl6TGZaWnFJWHczYTUy?=
 =?utf-8?B?NFRIRVdaendCaXZXL0h5ZEwvMENXOUx4SkJ6VmM3bG9acmRUTDd4WEhZMXBa?=
 =?utf-8?B?YjRkQWdzYUZPSjFBQ2tFL0huNklIcGVoWGk4dVlMbGs5ZmV6YmJFeHBnQW5O?=
 =?utf-8?B?NlZ5ZEVsSElJOEhlTSs5NzhoQ1VQSmIvTEh0eXc1eEFlN1BjdEx6ZjI1Uy9v?=
 =?utf-8?B?eWROWnd5VXFyUFRzNXM5VW5iQzdacFpSaXVwV1ExTnhmWHl5STM2dEduNmgy?=
 =?utf-8?B?dkNIakZ2a0haVElESFVrQ2VkK0JTdmFGcTIvQmo4aFoyTlU1VkRaeEtrMXVT?=
 =?utf-8?B?RjM2QyszUUdwVE1pWkZUNGJ3bUxqK2ZNS05oYjhiMHNJVUR3SnB1SXhhY21X?=
 =?utf-8?B?cFE1c09tQ3NIR2xhV3FkUkZVeUYxQmJYMDBiYnNjeFk1cExzRmVwR25WRVNL?=
 =?utf-8?B?a2lEaFFMSkZpei9IWEhEWFJkWlVFd2lYT3lORE10MFZGbzVTc3lCSTBoK0Yy?=
 =?utf-8?B?UTJVbGg3M0FObWcrTVNyc3M4cUJEWmNBRjV2bVN3bTZObjhEbGs0aDZ4cmNN?=
 =?utf-8?B?VWk2a0VUaVVaK2VwdkI5amtGWXhxMlJDNlNPeU4xLzJDQ2N3Tk1VQ1RLSHV2?=
 =?utf-8?B?QzEvK05vV1dlU3NzZzMrMXgxcmp5ajJLVEZETk1Wd3YvQU1TR1hoMXJGSU5z?=
 =?utf-8?B?eXc5aE9GRFdvV2xMeWZRSTc4SENhT2FrRk9laFB4NEdjYXM1ckJkblpFOXpy?=
 =?utf-8?B?WWw0dmdycDM2bzRHbFlJTE00TW8veVFaaXN1RklJdzZNamUxQ2szVWdCTWhS?=
 =?utf-8?B?ME9Xc09DSVp2UjRkVTZqcldaZ25BTm5taTUzc1BqY09FSmNsaTFrSVA4NjJl?=
 =?utf-8?B?QkJJeDJmWTFWa0poTWJWcUlwTUh3MWNpTm5QbUhiLzFwN04xYXN3dys1QzN3?=
 =?utf-8?B?M1JMNXVKc2lkTnFKSDRTekJ2M21LN1plT2dHa0wvanJ0L1VIdUJEMDlVaHhL?=
 =?utf-8?B?R0sxQkpJcTk0S0RtZzBPQWlnUDdFNG02VVZmcE0wR3o0ZmRieFRzcmV6SVJm?=
 =?utf-8?B?dEhMVHRya1RhMlhYcy8xcVVFUXA0R3JiZ2l3clNieXUxYTZ4NjhOZmE5eXk3?=
 =?utf-8?B?UHpJeXJPVE1TeFp3bnZFVmJjclFZNzQ1dlZTZ09xR0xpcTlXT2lBMk5LOEFE?=
 =?utf-8?B?Vnc9PQ==?=
MIME-Version: 1.0
X-OriginatorOrg: unsw.edu.au
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SYCPR01MB4015.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65332a30-7b45-4382-61bc-08de28a6a940
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2025 02:35:40.2309 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3ff6cfa4-e715-48db-b8e1-0867b9f9fba3
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wlGtCShjgWuFXrZ4qzl2YHpcfvdXwHc6xca/Qsmy7MATME84JC7wZBcXZSsStlNMzlmX1MuUFEDa/sSCkKoWwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SYBPR01MB5903
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIxMDAxOSBTYWx0ZWRfXy4sKgiU1YFfY
 7I/OuZ2+4kWM02KSFQUdPiVbVOrk10uhzvCmGJo0E/YKW0/FYgEhupx4zLmkwhAuHAnvU5QeiMa
 Z0PzAPs6gv+wTUNkSoUXjl3kYos8D6Sl57C/CdxSS6c9mmobf/q1oUAIb63ZJ/ovPu4gOYjMdCh
 msR/NiFYgkjMyk7HIxoloxAold3GpesOndAjdWH+fTS/eIPrM2eLbpRPvbF7WXr3eHCp22isgFu
 WwomwpkaboGQIttEOI9nKyNh0vOS7nyUVXN85fu7M/lc8+FVlXnkBJ9euCm0HOa7QSH+/rpiJ1O
 vGdpxta1acQcvO9HoEUM/rWQuihU39RtQ32bmfjUQV66Go58atW1carJ51WT224FczIq6tBA7wK
 OSY/RuB/Pr5HkYI7HpI+L+wAb9pb4Q==
X-Proofpoint-GUID: 2cJr-PIF4nvW4ONqYScybg6C-ArIDvLw
X-Authority-Analysis: v=2.4 cv=M7NA6iws c=1 sm=1 tr=0 ts=691fd000 cx=c_pps
 a=5E1qJjPwt/y+NqK4kpF6KA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10
 a=x7bEGLp0ZPQA:10 a=Nz8yn8fW8ScA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=XpE1AkgCAAAA:8 a=apn0q0EWAAAA:20 a=gpADgeIW2VticpwZSKUA:9 a=QEXdDO2ut3YA:10
 a=f7nS49b7AjcA:10 a=nH9O1qUWU4RO4MrvwREA:9 a=UK7VuYDodfHu97mF:21
 a=_W_S_7VecoQA:10 a=dpZMgbseYPk84XhQl7oQ:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-ORIG-GUID: 2cJr-PIF4nvW4ONqYScybg6C-ArIDvLw
X-Mailman-Approved-At: Fri, 21 Nov 2025 05:08:05 +0100
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

SSBzaG91bGQgbm90ZSB0aGF0IChmcm9tIHdoYXQgSSBjYW4gc2VlKSB0aGlzIEFCSSB0aGF0IEni
gJltIHJlZmVycmluZyB0byBpcyBqdXN0IGEgY29udmVudGlvbiBieSBPcGVuU0JJIGFuZCBvdGhl
cnMNCmFuZCBpcyBub3Qgc3BlY2lmaWVkIGJ5IFJJU0MtViBpdHNlbGYgc28gVS1Cb290IGlzbuKA
mXQgb2JsaWdhdGVkIHRvIGZvbGxvdyBpdCBvciBhbnl0aGluZywgSSB3YXMgbW9yZS1zbyBqdXN0
IHdvbmRlcmluZw0KaWYgVS1Cb290IG1haW50YWluZXJzIHdlcmUgaW50ZXJlc3RlZCBpbiBoYXZp
bmcgdGhpcyBiZWhhdmlvdXIgYmUgY29uc2lzdGVudCBhY3Jvc3MgdGhlIGRpZmZlcmVudCBib290
IG1ldGhvZHMuDQoNCkZvciBjb250ZXh0LCBteSBtb3RpdmF0aW9uIGZvciB0aGlzIGtpbmQgb2Yg
YmVoYXZpb3VyIGlzIHRoYXQgZm9yIG15IE9TIEkgbmVlZCB0byBrbm93IHRoZSBoYXJ0IElELiBU
aGUgaGFyZHdhcmUNCnJlZ2lzdGVyIGZvciB0aGUgaGFydCBJRCBpcyBtaGFydGlkIHdoaWNoIGlz
IE0tbW9kZSBvbmx5LiBPcGVuU0JJIGRvZXMgbm90IGVtdWxhdGUgdGhpcyBDU1IgYW5kIHRoZXJl
IGlzIG5vDQpTQkkgY2FsbCB0byBnZXQgdGhlIHZhbHVlIG9mIG1oYXJ0aWQuDQoNCkl0IGlzIHBv
c3NpYmxlIGZvciBtZSB0byBmb3JtYXQgbXkgaW1hZ2Ugc28gdGhhdCBib290bSB3b3JrcyBpbnN0
ZWFkIGJ1dCBJIHdvdWxkIHByZWZlciB0byBzdGljayB3aXRoIGJpbmFyeS9FTEYuDQoNClRoYW5r
cywNCkl2YW4NCg0KT24gMjEgTm92IDIwMjUsIGF0IDEzOjAwLCBJdmFuIFZlbGlja292aWMgPGku
dmVsaWNrb3ZpY0B1bnN3LmVkdS5hdT4gd3JvdGU6DQoNCkhlbGxvIGV2ZXJ5b25lLA0KDQpNeSB1
bmRlcnN0YW5kaW5nIG9mIHRoZSBnZW5lcmFsIFJJU0MtViBib290ZmxvdyBBQkkgaXMgdGhhdCBl
YWNoIGJvb3Qgc3RhZ2UgcHJvdmlkZXMgdGhlIGhhcnQgSUQgYW5kIERUQg0KaW4gYTAgYW5kIGEx
IHJlc3BlY3RpdmVseS4gRnJvbSBbMV0gSSBjYW4gc2VlIHRoYXQgVS1Cb290IGFsc28gYWRoZXJl
cyB0byB0aGF0Lg0KDQpGb3IgbXkgdXNlLWNhc2UsIEkgYW0gdHlwaWNhbGx5IGJvb3RpbmcgbXkg
T1MvYXBwbGljYXRpb24gd2l0aCBVLUJvb3QgdmlhIHRoZSBgZ29gIG9yIGBib290ZWxmYCBjb21t
YW5kcy4NCkkgYmVsaWV2ZSB0aGF0IGN1cnJlbnRseSB0aGVzZSBtZXRob2RzIGRvIG5vdCBhZGhl
cmUgdG8gdGhpcyBBQkksIGFuZCBJ4oCZbSB3b25kZXJpbmcgaWYgc29tZW9uZSBjb3VsZCBjbGFy
aWZ5DQp3aGV0aGVyIHRoYXQgaXMgYSBtaXN0YWtlIG9yIGludGVudGlvbmFsPw0KDQpJIGNhbiBz
ZWUgdGhhdCBmb3IgYGJvb3RtYCBmb3IgTGludXggaW1hZ2VzIGZvciBleGFtcGxlLCB0aGUgQUJJ
IGlzIHByZXNlcnZlZCBbMl0uDQoNClRoYW5rIHlvdSwNCkl2YW4NCg0KWzFdOiBodHRwczovL2Rv
Y3MudS1ib290Lm9yZy9lbi9sYXRlc3QvYXJjaC9yaXNjdi5odG1sDQpbMl06IGh0dHBzOi8vZ2l0
aHViLmNvbS91LWJvb3QvdS1ib290L2Jsb2IvMmJjMDcxNWI1NThmYTFhYzVjODhiMTFlMjUwNzQw
YjE2YTkwNTgzNy9hcmNoL3Jpc2N2L2xpYi9ib290bS5jI0wxMDAuDQoNCg0KDQoNClRoaXMgZW1h
aWwgYW5kIGFueSBmaWxlcyB0cmFuc21pdHRlZCB3aXRoIGl0IG1heSBjb250YWluIGNvbmZpZGVu
dGlhbCBpbmZvcm1hdGlvbi4gSWYgeW91IGJlbGlldmUgeW91IGhhdmUgcmVjZWl2ZWQgdGhpcyBl
bWFpbCBvciBhbnkgb2YgaXRzIGNvbnRlbnRzIGluIGVycm9yLCBwbGVhc2Ugbm90aWZ5IG1lIGlt
bWVkaWF0ZWx5IGJ5IHJldHVybiBlbWFpbCBhbmQgZGVzdHJveSB0aGlzIGVtYWlsLiBEbyBub3Qg
dXNlLCBkaXNzZW1pbmF0ZSwgZm9yd2FyZCwgcHJpbnQgb3IgY29weSBhbnkgY29udGVudHMgb2Yg
YW4gZW1haWwgcmVjZWl2ZWQgaW4gZXJyb3IuDQoNCg==
