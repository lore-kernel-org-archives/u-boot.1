Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 941FDD6E2CA
	for <u-boot@archiver.kernel.org>; Thu, 21 Nov 2024 10:17:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D1D64896D4;
	Thu, 21 Nov 2024 11:17:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="DPIOaIRK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8FEB78971D; Thu, 21 Nov 2024 11:17:40 +0100 (CET)
Received: from PR0P264CU014.outbound.protection.outlook.com
 (mail-francecentralazlp170120004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A4D989689
 for <u-boot@lists.denx.de>; Thu, 21 Nov 2024 11:17:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.henrys_ext@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zSGMNvNeZbGJE6v10ngTLez1tSZgzTkfom1TpaPe45BF28RNtDBnMoDyLV+OurtlC5REUJhsnrPFWY80zuYvwJJ7IBXn6Fsu33K2H3s629oFTaPRLy2cxQfY3scztTn1gG6bteffkns0WIVUQSxl792bV2uATdsVYP/CHvaa0dNSky+DMrhkH/kLZEK/41Nqak397vBFGHxtKpGcyWCKyQESacc205OBwaUX4xOaXUdfUU6RbuoW9lRbK+fTmHaJOd6BPAPMDKLDJtNjlE5zoLlm2Ot9TFV4eWJkxf1IVVhpVmXyX17Koe9kqkAUXDY7RXMtH69Pm/QtXOn3z+l1jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=glHY0MRzdRK2N4GwBZbzJeLb1zjjmp/MdQIgCYgau78=;
 b=qavNgkMzNudripnV2CPZDLc3AojMgr9XajwBMzi58hCYxgdDCBXwU9azqrrkjwbzRDTpwbO1kXDU4+bLIU7BDkHZGR9nm4OOBArnLC0E8KMSmHVqQmjt5oqo6KpD0CZLoPg53wVsoKvynL795DfGD81cHDwTuIRed2PBadanbUorxSk1p8q4cZDZfWPjxX6f9hq7B1TSA8Y6DAWe7TaW2nijbzhoSoTAtOfL/MSmT4s6qXcvixvrIEa69xuuZoef1CbdagzsA4DiekW9rXazoEB2IXJNoTKpD8pykODDweH4S+wcLeJ5knBY1uxxPVaQ5xSZnB0GCOsUs64Zd2GsXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=softathome.com; dmarc=pass action=none
 header.from=softathome.com; dkim=pass header.d=softathome.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=glHY0MRzdRK2N4GwBZbzJeLb1zjjmp/MdQIgCYgau78=;
 b=DPIOaIRKlAVeNCvqQkPY/l+gvgu9SD4vh+FsvM1fKhG1kSXju1R2JH4RpfJ0pFcPXPhIprYyGx+3MRf90VeboqBN/6DlCuf66q88oc64L7ibyARorJ0AOPf3TdFp/dyvW2NO4qrQ0d5gMRPP5onf/bCeDcikazSSq/A2C6sw1e/s+5wqwxNI/1jVjK1Bkvz/qgij/DZpJGFrBwEO/j7uCZCXN9dXfc1uvjEyN8ql5QdRPHv6ETZqrsNCG6IP+9zXW94mq9y0+w2XUww5aTd+H5cqy27wOWuQhYenznkv5gGnwkOLVU+Wz3yjgOtE0ZFPddppH9gxrBwxJUYw+9qD8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=softathome.com;
Received: from MR1P264MB3107.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:3c::21)
 by PR0P264MB2328.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1e3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.15; Thu, 21 Nov
 2024 10:17:35 +0000
Received: from MR1P264MB3107.FRAP264.PROD.OUTLOOK.COM
 ([fe80::b707:71fe:8517:aa42]) by MR1P264MB3107.FRAP264.PROD.OUTLOOK.COM
 ([fe80::b707:71fe:8517:aa42%5]) with mapi id 15.20.8182.014; Thu, 21 Nov 2024
 10:17:35 +0000
Message-ID: <d067cee3-88af-4a6d-bef3-726540cb4afa@softathome.com>
Date: Thu, 21 Nov 2024 11:17:34 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] tools: binman: Replace 'fit,sign' by
 'fit,keys-directory'
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, al.kochet@gmail.com,
 paul.henrysd+nodisclaimer@gmail.com
References: <20241120100911.885418-1-paul.henrys_ext@softathome.com>
 <20241120100911.885418-2-paul.henrys_ext@softathome.com>
 <CAFLszThV+sQ6Hj5TW=8JyLz-Ta_GTJhkXxfNHY-caeN0dpaZtg@mail.gmail.com>
Content-Language: en-US
From: Paul HENRYS <paul.henrys_ext@softathome.com>
Autocrypt: addr=paul.henrys_ext@softathome.com; keydata=
 xsFNBGQYeUEBEACp9Mxa0R+O3VXwft27iMo1uMfatjkGSMebTe/NXYDeXAc3ZhaktWik/kN0
 dksMdNHuDjQshXFjf16QCp93REtLE1m+h3d1k2KH7VU0Is/wtrAlz3zxyxWwod3H8MF3cBes
 SvFgEsb/qFQ+Re8rKG3+ab0dEqTPTsHJWkciZOxO7+J5hEcS9FKpGk5OxCWRgDHzdDnXi5p4
 VLgvXtoKujLpPlBqpGSNziJzSYtBgt979tzLkt6TNw6kL1/uNCYcmKkutAL/deVdThdMhF8p
 pWz8cSLFyB07/+oCxVVQLdsgNfpoTcv9PFuOH9Fl01F0fezcgwGwk5vr5mrNqqMeG9byrGdd
 Fos6Xf6xACZ7tUXifeFs1jr8GuB5ErGgrSIPTXJBgHHgWr8WUVcTTPjBoPWHR5hMQ4oh7+6Z
 fCdlrQSyjUHz8DWG79mRZ0dQiiPlXBxOZ5dO47Z2NVhKo8GLyHklrhaO1mgqKfHIDGF/IX/a
 TTXyiGHU/anYmzcSKLFkn5C+TMNXx4jBOT2yp51wMX2zh9odDzq/EPbN+A2kweQrfLBgLwcs
 JzsskWpji7Lb7dS8YS3yleEDhL1o26if+fE5YqlDW2A2OGjEBd2HRDyrLAcPll+mhnflgFqK
 IpHRPNsdjUqwMvWknzXMDi/u1FlOCgzFQpqRwZ4k1zyhC4O/UwARAQABzSxQYXVsIEhFTlJZ
 UyA8cGF1bC5oZW5yeXNfZXh0QHNvZnRhdGhvbWUuY29tPsLBjgQTAQoAOBYhBC/0TbUGNniU
 1s2pmlybfngNcCltBQJkGHlBAhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEFybfngN
 cCltEz0P/A5X/r/RlxwW7S0WBp7MK52hGtT+CApyKqEWRyJbovN6Gjor0uu+VLPqmk8y8ufi
 R2zAvO+cB3hziL7+qY/uxzXIp7j2eziBhhiM4GGzv2BqR7fGXZC9Zy7edAoDVa9QXm8MsCq9
 Ai+87bapfXek/92cnGK8Q40mRSxlgmk1ZyI1mY579k9K4el5ja48aWcvOmTsIeleGBn2BoFv
 dp7/la++0Sfs2HGtxrWeZ+eCUEGFJweU8bb+1nTmK0ksA04qFjlnS3QNPvHteeDd+eyJyq0a
 6QGrYw7czPJsmjGa6KkSdqarG1zh79GMiCvpA/kjp2V03+iRPe/OZDzEwZ3abESWxDx6z8Py
 xhsreNZG2VoNrc9QUK9hT5vYpQHvD+n2cd6V/zOBxIhH1/9I4gf4lGMYDR1ucZYJnlQarjMf
 Ty/eiur55M045vySk/ql8Jlfh7gFCBgmGd8A5LMhYc8UAA/RO9BAL7mUQh195uLmi3ARMAVQ
 TP2c9KDKV4t/Txu32oGis21Bxe8J5p8SNsMUkWV/zShLkGYiPFP3USBO9nht0TQ6+SyFXqH1
 FrmD8Iwpu7ykdAaaXVZ+8LKCR8n/je2GQ0JHcer2XoRvegwfLJFHG7CqtZZVZRxT9iYhWQAA
 xij5PpQVgHqzzHeJ0xs28n9GhFyOgU88HNruzzyzaC2QzsFNBGQYeUEBEACmlubHldszJX1R
 Gpx1T6ILdVe7rPY6SsV92JybiDghSoGzm2G76lN4BywF27xMjK4A1j1I0hdIKFmp7lUB1S/8
 NDpsiWF3YfMEhpdbEQqFvF6S+AkC0GUj1c4PNOThslFFRVSD3Zs/Oot+EJSQFA82Ws7RBBvk
 azfqlyhoLaO7A9tLQIT6E/PYVLj+YzSRWtG7LwIooYgHTmhrue6MXEk1ksQgbLJlAyhOTpoQ
 80QRrck5Qcv7j12WtpZTNWiztjG4ZywlopZfpwtn48genI0PuZB++sRfaJvcrABY2eNHD9iR
 GxmnzDldt6r091fCC9fcY/A6Licbw/I/p42f2tzwmm7Ni8SXTMqkalhGmXyMqlgHBan/AOrM
 im11508QkY1Ls7FxuMq81QP/vppxt6B7DXmI587t/PU6GP9FSQ5uWoKbL3Ny3otRgo9IG7Kl
 gX8NqGtdSGqnUcbTsafXCnQmO/18MbdFTRbaXyeGCrndUMWBJlb9tvg0Mbd/WZUTnqNvyV8f
 JaY20NsGI07haZeuW3/Wey89EiqFQtHw+V69wQCTI6VPeByfcohe4CeFAuIGyx4LGYlP+Z78
 uj5PcL2xSmruqG70HaIyhr+Iom3F9QUXqR8kitUe6Bz4MjAvGN4jzblI6h+Q4UKHB5HY5Fjj
 Y0YqGFnS75Uos16VAKJUHQARAQABwsF2BBgBCgAgFiEEL/RNtQY2eJTWzamaXJt+eA1wKW0F
 AmQYeUECGwwACgkQXJt+eA1wKW2l3g/8CLQkwqgT5Pt4Nsup0/WugJWKaKeqREeUQFZCjIlQ
 oLGenrdeE3FevRyj1qGIHRIDg7zxO7bIcePIKMhzntXYByas+dsWI/u49WIjkn+agjdvnsfm
 6iBNN2uHa27bcEGhOfvskcJVs6qPivUfcXGbl4ovF6DOHPTWsLpLkEANKK0tyZpQD2FKMHSu
 ST9edYn8gdVyCmxeSJ6uyJOBdJ62RZMgg1qYJt1TCF9SBpUYaD6boXZQLgJBIUyo5ah1OM41
 ZG4LtXnmbGoCjlfXADn1GKs6Q1tPeu7Az2HB9NmnUFYAaAk0U2TFE4c13hqBqbf28NE1i54V
 a1i4usgGeOyRYobNsB7wH1znbpuPqcFGRAln4lZt3KAIVmBtLQLUUsfeSLxNQW7mbMxJJaYG
 2pUFD1r55Ye3ODy1qz7edVVsTWjUvZaaZ2d2kQGMe5k8hbZWMefaXTx5Gt2TOULgagRhkPM/
 MVtSwPLGzbgcPyGaMgwbNFg0Lgk+Z0eFfSGO0ROuKZZmyL34FZ3CHFDVZEFQGEFn488SYBeQ
 PVFZ6XtspuBK9LSNi9Y4g4MS5NhWywy7555Q1t/NTiftzPQz3sfmr5iDzVqyxIXFZMKwOxl7
 zE8PsOtQMDauBN1eFehaPb1mlyBio5ispwRCJCm006jBSHvE4i9W+/Lu7DSE2v/LI0U=
In-Reply-To: <CAFLszThV+sQ6Hj5TW=8JyLz-Ta_GTJhkXxfNHY-caeN0dpaZtg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA2P292CA0001.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:1::17) To MR1P264MB3107.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:3c::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MR1P264MB3107:EE_|PR0P264MB2328:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ae2a5d9-fe1f-42a5-d30c-08dd0a15b7d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SFVjZ2ttV0gwOWZUNVVuVmFCV1h4SVRQNXY2d2IzTDFNdmJzNDBPNmU2dUJq?=
 =?utf-8?B?TnhQZWdlZmZrOTlSOUhLTnRnMnpiYm1oUmhqYWtQcko0YVdKbzNuYldDVTFW?=
 =?utf-8?B?b1R1ajBpK3JRNVpmOFVOUFk0akZGRjUxL2tlbnM4bUhMYzhOc1Zkc25rM0Vq?=
 =?utf-8?B?V1BlTkx0eXVCaVd6Z1JZZ2pBUFBXVGhRUCtSRkU1dVdMUTExMkdHREgraTZQ?=
 =?utf-8?B?b0NzK05ZblB3dVpKUlJaYStoM1MzamFiSVRGZEtxWGk0SWJGMmhPa2s4RC9C?=
 =?utf-8?B?UHFsV2lsQWpSaTVuUTFFVTdoUmZQeFQ2alJLamZTTHg3VisvTEdKT3ZoSFg2?=
 =?utf-8?B?UUJzOXliSGhhL2hBc0twZ2JtTVpvUm9NNXJCTGhtRDc5cHk0TU4xNTFSdVJN?=
 =?utf-8?B?d0pIeitQbFlkREdycU9iaTFPQW9PRGVuU2NpeEdHdzhxblNhM3prQXVvT3RU?=
 =?utf-8?B?SzNoK1UvNGdRRnhuSURITE16eFRHNDN1U01DYlZHak5WV2pFY2tORnhCUC91?=
 =?utf-8?B?NTlsVnhiak9kdWNCQXE3V25KUVdJVG14ZmNkWkxGLyt4U2lnRk1WNXhPSTBr?=
 =?utf-8?B?ZmJ6QXpMVFBxRk4zSmZNa1dZQTRMNmo3aXF0UHQxOUFlVkptT0wrZDljWHlR?=
 =?utf-8?B?YkhZVS96eUhmVis4eEQ3MEE3NVdiNVZKTU1EU2pGTHV5STJPZE55SDZiM20x?=
 =?utf-8?B?SDl4R0U4OWx3N1BaeVRtVHpqNVg1NFBFVFE3UUhTQVdzdjhBQTlkWDQxMWtB?=
 =?utf-8?B?ZGd2ZGJyQ3YzZ3RDczdFcFl2UVpPdzlpemliOHBxbGh2eUxxcXdBR3ZZQklH?=
 =?utf-8?B?SmUzL0s1ZDU5TzJlZ3VJSmtsTUFPems3Tk8zMEtmcURlRzk3VWNIeHBWbDNR?=
 =?utf-8?B?Z2dnNUlLL0dzZElYWjlIb0ViL2hXekp2T2ZadWdOTXk2em5sSVNHRzJsNmtP?=
 =?utf-8?B?ZzFjSkVhU0lWNXVDSW5ET3NyYzA4aE45VkVQdjJqMnE4Tmo1aWw3N2V6R2lM?=
 =?utf-8?B?c0Q2VlB5cUQyc3ZZR3dsR0dIa2hVdVRFQXhkRm5WWVNLZi9UTUFxNHp6TmNm?=
 =?utf-8?B?eTVteXc0dlQxSkdwemJDamhTUldvM0hqak1iY25YSHJucXMraFFqcmJRcVFH?=
 =?utf-8?B?K0w2Nmd1cFBYd0l2NDFINitTc2dsWFZDWEFJamhKZ3VCbk1aRlBmcWJmYnlu?=
 =?utf-8?B?WFlhbVVVYThTNGc1NUxsd203YVVXc1c4SlU1Z3IxRTNSTTVTSXVFQlpoWnVi?=
 =?utf-8?B?M2lSUy9DMU4xQVZtckVoOXduQVNhb1Fma0Y5Q3RtbFA2YmhmUUFiZG1LcVVr?=
 =?utf-8?B?Tit0VnppaUoyQTRUYUZ3MnRUY2ZJOGlzMDkrVEc1VGxZNkZMY3gvYXJvOHh6?=
 =?utf-8?B?NDhyY29wQ2dhdlM2R0QzdklLZ2Q3SFRPRXFXTDJmd2NlQ2x1dldtSm5lelg0?=
 =?utf-8?B?UVd1TmYvL1pqU1JtUzAxVE1VSWdhTE4yaFEwell6US8rVHV5S0xYYlhteURT?=
 =?utf-8?B?TkxYZlVRMHRDbEVKL0dLeW9jVXlBQTUrSHVzYUdUUURIa0VrQUxZZFJkWG8x?=
 =?utf-8?B?cHJYaFNzb0lwbTNQa2laSnYxUWlaT3ZhQXdrUnREZGtaM3hIT084REZBUTJq?=
 =?utf-8?B?WkhTc09WZEpzR2tHTnlIMWRVQlFxODlXSXhMSkNDUEo5aU8wTHNoSVlFOXQ0?=
 =?utf-8?B?NjI3L3Z6c2RteGVzNWRpTUxPRnFwN1ZSZVVCVzcvTHhNeVowTzRmUkVTUDg0?=
 =?utf-8?Q?+jbHg8HiYdegywB9vh6QE2HD6XPGmz3bwECZvhx?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MR1P264MB3107.FRAP264.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a1Nqd3hTYkMrNXAyMTFrODZQVGQ1NHp4cDJZSVpGdEFualMraWNlS0xySnRm?=
 =?utf-8?B?NlpuWEVsSnFRQmx6eVZhWWxaL29sd2pxSTFzZGc1WWlPUGZyMlIzY09JWXNU?=
 =?utf-8?B?cGwrNkhVd2sxOFJ1NzJHVk5zL05rTUFoc3NZaEFQejdzWmlTeDJZaDRPRjh6?=
 =?utf-8?B?aEpNUGdEMVNjVjZreFdLS096YlVheFNlREppeEV0ek96dko4amFjWlJiYmJj?=
 =?utf-8?B?b0oycndYUEpteGVRSU9qL01LdGV2VlNGWk5SMjRndEJzTDNDMGNDUHU2K1A1?=
 =?utf-8?B?OXJySFdFZ1ZrMUhLR2N4N295Tm93c2pmUkRCSTY1NXdDQnhIMjc5V0o5QmhU?=
 =?utf-8?B?eExTeWV2L2hCczQyUjdMdzViYlBWeTN4RGNFajB1amd6UHFZMFRyencyY1Vo?=
 =?utf-8?B?Y2dHUVRoYUFKdlVxOGQ2dzFEYW9HSmlmcGw0Z21wYTI1VEJsVlRETTR4UHZt?=
 =?utf-8?B?MUtzbGs5UDFlZzNCd1ErOHkvbGZtYkdPR2RUWlJoeENwOFlJa3d0YUJZRGc5?=
 =?utf-8?B?TnQxSnpEaFIyTW1EUkdsMUFBNXVYUmZBSkFTQkZqMUFQQlpOUWJDREhhYmFv?=
 =?utf-8?B?SDB2a29DVkRaWUx2NUdPY2RyMWJVQTltN0lwczZzYnF6cWlkZWc5YXBiRlg3?=
 =?utf-8?B?SHR6b0FnY0VTR3NxWTkrSUV2OFN5TXBFV3BXN0svR0xzZlVrc3lMRUZFclkv?=
 =?utf-8?B?QzcxQi9PbzVsdkE2RFZRYzlWYkY2Wm40TmtTQm45ZEM0c25MWlNQSURsbVpk?=
 =?utf-8?B?dWZIVXJMbE1MLzMzME9BTGlCYlNKcFoxRll1NjFseDZFV3YyOHJTMWExNFZt?=
 =?utf-8?B?TW12K24vbWhDV1pTeGRIUmtkMWxTbTFsb0lsbmNoaFRHSnN3V3o4OEE1elBS?=
 =?utf-8?B?RExnU0JZL3pJNFJpeU9hdDFyV3FmeWNReDZDRWV6aUM0czFYYWs3cW9iSWxq?=
 =?utf-8?B?OURCVXJlbG1UdjBPSUt5dEYrTVdpYVRxNjQzR0JNZ0pBeEYrTTVKZEs4cEJD?=
 =?utf-8?B?dWZzM1ZINWNmbzNsWEVaaVFTWXB1TDBlQkZVVFZla1oxUjZYQ0xkM1dWbC9a?=
 =?utf-8?B?V3ZIbnRhSWg2Uk1MMS9DRkxLNjlhNE1MQTBLVGx3Q0V5bDB4REJPaE9FeUxa?=
 =?utf-8?B?V2tlZWdIODNuR2dreVc4YkJhdlA3YjYwNTEwbjlObzRYdm41SllFOThuMXBl?=
 =?utf-8?B?RThyOVhEYU9yK1BCSklmY1JaSWpFdlBYbG5MTEpNMDdMa29peDJSb292aWt2?=
 =?utf-8?B?USs2WWg0S00vTkFLczYzUDNETnZFelNFS0RzZHRVUjB5ZFRGb0lTVjU5T2ZH?=
 =?utf-8?B?YmxLV1Y4SmhPR0xZcFo3dStYSWtMeHRmcHBYZDdOd2V4TDhEWnRYR0dBUm1h?=
 =?utf-8?B?U0MzNHcya0dTdHBqa0pqWVBQSFo5SVcvWVpGcnZEbk41ZHNHelM2ZkNDZm95?=
 =?utf-8?B?TC80aWFITkU5aUJORlZtRmlZSU0wNHhBTXhhSmxoWi9ST2xIWlAxMVBSQlVN?=
 =?utf-8?B?QWN6emFhTHg2Ty9McUttZFF1djZzcy9BRGRnWSt5a2RQd09yb2VpcmdDNEox?=
 =?utf-8?B?YW9uOVRyYzJCNWpWS05YQ0hiTnNzanZrZFAzZHh4cnBxR0lUdWlyZGc4bi8x?=
 =?utf-8?B?TVJta2w4UnZsUkgyUGxxNjZCNExRMFNUMElaMjNJQUVSTmlPRFZNRUlFSmgr?=
 =?utf-8?B?WjNsRHc2MjdMd0NQbjBnbGZYUUVBYVVsZFp5WXhXUUJUTk9pWnF1TFpaS2Na?=
 =?utf-8?B?ZkUwZU43eDFmYklTNVNYakdmTlFHZmhoNXpuWjAraUFGcUEwZXlCYjdBSWZF?=
 =?utf-8?B?NmF2NGdNclZ1MGtjVTNONWRnK0pwRldlYUxuVkt3dlMxb2FpNXRpSWJ4OUhG?=
 =?utf-8?B?N3RKUXYwNkNpWTdsTG03dFpSTmNLOE9rRXowaUR3MVBoL2VON3d1eXpTK1Bs?=
 =?utf-8?B?MTRqVTl4NlpEY1psNm5xUmNZdVpPYXFGTnk1dENuUjdYbkJvZDdRc0d5SkUz?=
 =?utf-8?B?TXlyeS9rMmpVRDg3eW5TMXRFMXUrRUYrN2JtS0N0R2JjeXdWME9nZ2M2S3FH?=
 =?utf-8?B?WjIvVXBjV0NxQWlVSElCYlJydkRMK3FIZDVGbnduWkdZdTVXd0tubW0xK1dS?=
 =?utf-8?B?VGFkNXIrbDR3MEF5bkhFUXJLc0g5RFl4eTVsNXpLMzZ5NEdldkFIOXRIMXd0?=
 =?utf-8?B?SVE9PQ==?=
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ae2a5d9-fe1f-42a5-d30c-08dd0a15b7d8
X-MS-Exchange-CrossTenant-AuthSource: MR1P264MB3107.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2024 10:17:35.6570 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sCcZIbqJg57lcYsTpa/522E370qPUT2agTPJS+LrljFz3Xsb/2435bR07qcF1k1yST482ZYnsn5DZuGfOtjF5lfTa5YMHc8ZbWYQrxpzaeM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB2328
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

Hi Simon,

On 20/11/2024 14:35, Simon Glass wrote:
> This Mail comes from Outside of SoftAtHome: Do not answer, click links or open attachments unless you recognize the sender and know the content is safe.
>
> Hi Paul,
>
> On Wed, 20 Nov 2024 at 03:09, Paul HENRYS
> <paul.henrys_ext@softathome.com> wrote:
>> mkimage can be used for both signing the FIT or encrypt its content and the
>> option '-k' can be used to pass a directory where both signing and encryption
>> keys can be retrieved.
>> _get_priv_keys_dir() is also renamed as _get_keys_dir() and adapted to support
>> both signing and encryption nodes in the FIT.
>>
>> Signed-off-by: Paul HENRYS <paul.henrys_ext@softathome.com>
>> ---
>> Changes for v3:
>>   - Adapt the code after changes made in commit 133c000ca334
>>   - Rename property 'fit,sign' as 'fit,keys-directory' since this is not only
>>     about signing but passing a key directory to mkimage for both signing and
>>     encrypting
>>   - Update the tests and documentation accordingly
>>
>> My initial changes proposed in v1 and v2 has been outdated by the changes
>> proposed in commit 133c000ca334.
>>
>>   tools/binman/btool/mkimage.py           |  8 +++----
>>   tools/binman/entries.rst                | 13 ++++++-----
>>   tools/binman/etype/fit.py               | 31 ++++++++++++++-----------
>>   tools/binman/ftest.py                   |  2 +-
>>   tools/binman/test/340_fit_signature.dts |  2 +-
>>   tools/binman/test/341_fit_signature.dts |  2 +-
>>   tools/binman/test/342_fit_signature.dts |  2 +-
>>   7 files changed, 32 insertions(+), 28 deletions(-)
> I think it is good to be able to specify the keys directory and not
> just rely on Binman's input path. But do we need to remove the
> fit,sign property? It is the signal that signing should be done.,
> although I understand that there is a key directory too.
>
> If we need to remove it, please do that in a separate patch.
>
> Perhaps we also need a signal that encryption should be done?
Based on my understanding, we don't enable the signing by adding 
'fit,sign' property but by having a signature node in the DTS passed to 
binman and thus also in the ITS passed to mkimage by binman (at least 
with the current implementation). In the current implementation, adding 
'fit,sign property' in the DTS passed to binman only leads to add the 
argument '-k' with a directory where the private keys are stored and 
nothing more. The '-k' argument of mkimage is used to specify the keys 
directory for both signing and ciphering FIT data. That is why I thought 
the property could be shared for providing the keys directory for both 
signing and ciphering when generating the FIT.
Then maybe your idea would be to use such a property, i.e. 'fit,sign' 
property, to be able to add more options related to the signature 
(key-name-hint, algo...) instead of having those information in the ITS 
in a signature node. In this case, I guess it would indeed make sense to 
have separate properties that could both set the '-k' argument passed to 
mkimage.
The current signal for the encryption is to have a 'cipher' node in the 
ITS provided to mkimage.
>
>> diff --git a/tools/binman/btool/mkimage.py b/tools/binman/btool/mkimage.py
>> index 78d3301bc1..3f84220fb1 100644
>> --- a/tools/binman/btool/mkimage.py
>> +++ b/tools/binman/btool/mkimage.py
>> @@ -22,7 +22,7 @@ class Bintoolmkimage(bintool.Bintool):
>>
>>       # pylint: disable=R0913
>>       def run(self, reset_timestamp=False, output_fname=None, external=False,
>> -            pad=None, align=None, priv_keys_dir=None):
>> +            pad=None, align=None, keys_dir=None):
>>           """Run mkimage
>>
>>           Args:
>> @@ -34,7 +34,7 @@ class Bintoolmkimage(bintool.Bintool):
>>                   other things to be easily added later, if required, such as
>>                   signatures
>>               align: Bytes to use for alignment of the FIT and its external data
>> -            priv_keys_dir: Path to directory containing private keys
>> +            keys_dir: Path to directory containing private and encryption keys
>>               version: True to get the mkimage version
>>           """
>>           args = []
>> @@ -46,8 +46,8 @@ class Bintoolmkimage(bintool.Bintool):
>>               args += ['-B', f'{align:x}']
>>           if reset_timestamp:
>>               args.append('-t')
>> -        if priv_keys_dir:
>> -            args += ['-k', f'{priv_keys_dir}']
>> +        if keys_dir:
>> +            args += ['-k', f'{keys_dir}']
>>           if output_fname:
>>               args += ['-F', output_fname]
>>           return self.run_cmd(*args)
>> diff --git a/tools/binman/entries.rst b/tools/binman/entries.rst
>> index e918162fb4..1b1d73ef17 100644
>> --- a/tools/binman/entries.rst
>> +++ b/tools/binman/entries.rst
>> @@ -864,12 +864,13 @@ The top-level 'fit' node supports the following special properties:
>>
>>               fit,fdt-list-dir = "arch/arm/dts
>>
>> -    fit,sign
>> -        Enable signing FIT images via mkimage as described in
>> -        verified-boot.rst. If the property is found, the private keys path is
>> -        detected among binman include directories and passed to mkimage via
>> -        -k flag. All the keys required for signing FIT must be available at
>> -        time of signing and must be located in single include directory.
>> +    fit,keys-directory
>> +        Look for a directory where signing and encryption keys are stored.
>> +        If the property is found, the keys path is detected among binman
>> +        include directories and passed to mkimage via  -k flag. All the keys
>> +        required for signing and encrypting the FIT must be available at the
>> +        time of signing and encrypting and must be located in a single
>> +        include directory.
>>
>>   Substitutions
>>   ~~~~~~~~~~~~~
>> diff --git a/tools/binman/etype/fit.py b/tools/binman/etype/fit.py
>> index b5afbda41b..e0c1ac08d8 100644
>> --- a/tools/binman/etype/fit.py
>> +++ b/tools/binman/etype/fit.py
>> @@ -102,13 +102,13 @@ class Entry_fit(Entry_section):
>>               In this case the input directories are ignored and all devicetree
>>               files must be in that directory.
>>
>> -        fit,sign
>> -            Enable signing FIT images via mkimage as described in
>> -            verified-boot.rst. If the property is found, the private keys path
>> -            is detected among binman include directories and passed to mkimage
>> -            via  -k flag. All the keys required for signing FIT must be
>> -            available at time of signing and must be located in single include
>> -            directory.
>> +        fit,keys-directory
>> +            Look for a directory where signing and encryption keys are stored.
>> +            If the property is found, the keys path is detected among binman
>> +            include directories and passed to mkimage via  -k flag. All the keys
>> +            required for signing and encrypting the FIT must be available at the
>> +            time of signing and encrypting and must be located in a single
>> +            include directory.
>>
>>       Substitutions
>>       ~~~~~~~~~~~~~
>> @@ -518,14 +518,14 @@ class Entry_fit(Entry_section):
>>           # are removed from self._entries later.
>>           self._priv_entries = dict(self._entries)
>>
>> -    def _get_priv_keys_dir(self, data):
>> -        """Detect private keys path among binman include directories
>> +    def _get_keys_dir(self, data):
>> +        """Detect private and encryption keys path among binman include directories
>>
>>           Args:
>>               data: FIT image in binary format
>>
>>           Returns:
>> -            str: Single path containing all private keys found or None
>> +            str: Single path containing all keys found or None
>>
>>           Raises:
>>               ValueError: Filename 'rsa2048.key' not found in input path
>> @@ -533,11 +533,14 @@ class Entry_fit(Entry_section):
>>           """
>>           def _find_keys_dir(node):
>>               for subnode in node.subnodes:
>> -                if subnode.name.startswith('signature'):
>> +                if (subnode.name.startswith('signature') or
>> +                    subnode.name.startswith('cipher')):
>>                       if subnode.props.get('key-name-hint') is None:
>>                           continue
>>                       hint = subnode.props['key-name-hint'].value
>> -                    name = tools.get_input_filename(f"{hint}.key")
>> +                    name = tools.get_input_filename(
>> +                        f"{hint}.key" if subnode.name.startswith('signature')
>> +                        else f"{hint}.bin")
>>                       path = os.path.dirname(name)
>>                       if path not in paths:
>>                           paths.append(path)
>> @@ -587,8 +590,8 @@ class Entry_fit(Entry_section):
>>           align = self._fit_props.get('fit,align')
>>           if align is not None:
>>               args.update({'align': fdt_util.fdt32_to_cpu(align.value)})
>> -        if self._fit_props.get('fit,sign') is not None:
>> -            args.update({'priv_keys_dir': self._get_priv_keys_dir(data)})
>> +        if self._fit_props.get('fit,keys-directory') is not None:
>> +            args.update({'keys_dir': self._get_keys_dir(data)})
>>           if self.mkimage.run(reset_timestamp=True, output_fname=output_fname,
>>                               **args) is None:
>>               if not self.GetAllowMissing():
>> diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
>> index 156567ace7..adab65e579 100644
>> --- a/tools/binman/ftest.py
>> +++ b/tools/binman/ftest.py
>> @@ -7885,7 +7885,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
>>               str(e.exception))
>>
>>       def testFitSignNoSingatureNodes(self):
>> -        """Test that fit,sign doens't raise error if no signature nodes found"""
>> +        """Test that fit,keys-directory doesn't raise error if no signature nodes found"""
>>           if not elf.ELF_TOOLS:
>>               self.skipTest('Python elftools not available')
>>           entry_args = {
>> diff --git a/tools/binman/test/340_fit_signature.dts b/tools/binman/test/340_fit_signature.dts
>> index 9dce62e52d..97c0cbd05e 100644
>> --- a/tools/binman/test/340_fit_signature.dts
>> +++ b/tools/binman/test/340_fit_signature.dts
>> @@ -11,7 +11,7 @@
>>                          description = "test desc";
>>                          #address-cells = <1>;
>>                          fit,fdt-list = "of-list";
>> -                       fit,sign;
>> +                       fit,keys-directory;
>>
>>                          images {
>>                                  u-boot {
>> diff --git a/tools/binman/test/341_fit_signature.dts b/tools/binman/test/341_fit_signature.dts
>> index 77bec8df1e..4a4da7e589 100644
>> --- a/tools/binman/test/341_fit_signature.dts
>> +++ b/tools/binman/test/341_fit_signature.dts
>> @@ -11,7 +11,7 @@
>>                          description = "test desc";
>>                          #address-cells = <1>;
>>                          fit,fdt-list = "of-list";
>> -                       fit,sign;
>> +                       fit,keys-directory;
>>
>>                          images {
>>                                  u-boot {
>> diff --git a/tools/binman/test/342_fit_signature.dts b/tools/binman/test/342_fit_signature.dts
>> index 267105d0f6..9c61aea044 100644
>> --- a/tools/binman/test/342_fit_signature.dts
>> +++ b/tools/binman/test/342_fit_signature.dts
>> @@ -11,7 +11,7 @@
>>                          description = "test desc";
>>                          #address-cells = <1>;
>>                          fit,fdt-list = "of-list";
>> -                       fit,sign;
>> +                       fit,keys-directory;
>>
>>                          images {
>>                                  u-boot {
>> --
>> 2.43.0
> [..]
>
> Regards,
> Simon
