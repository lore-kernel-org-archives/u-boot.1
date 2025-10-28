Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A615DCCD1BF
	for <u-boot@archiver.kernel.org>; Tue, 28 Oct 2025 20:33:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0168F838CE;
	Tue, 28 Oct 2025 21:33:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gigadevice.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=gigadevice.com header.i=@gigadevice.com header.b="dS6msVyA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7345D838EE; Tue, 28 Oct 2025 21:33:19 +0100 (CET)
Received: from SEYPR02CU001.outbound.protection.outlook.com
 (mail-koreacentralazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c40f::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70AFD83826
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 21:33:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=gigadevice.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vlim@gigadevice.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k5g571mP5uE0FXrNaA6RZW1XUcKFIBWs0JHKNvHd3m+StWe+4LLNOZjDXGgU6wwAf6AhaeTRFs3GiCCWX1JY/y3LaZ+3sWM5Z4QiiFzqSauULxgua7TTcmNsvjZu4YITXz/jKUd9sFM/5MKYaJ72zNFjnqUgq7Zzun9GBWbEujGhFtvQCILAawiDGOnhWIF5P1KVw3M+jmqKDz4rCXe2VS8fASEltt+FhAKnpUtDsvOe1A8rJa+LLCntvTu4esfu1Xcjb70k6QlGXftpaKufdWV+aTRrC22+WZ7FkcimircukeBR/9e9JPIDb+VjR8OQhJ42+pQCc/nnVTLB8Aiq6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jFoHlaxKu/Ug/RQh+qh3LZyrv+k9wMaYyQYi93y3OGs=;
 b=Vp4ry/ZMOwC+sP5pAyMnoupce2Ll6R1rsa+4U926I4vyqppuyI1+1P/RQtXPs2UEzEw3jB80bAc4mg2JdIer3LVgIKELuMHl6mdAP6bWA8Se+7cOP2BTijxZGUus5ddEYWkTf2R8Yq7nQ6SUiLwYFV8rDEW/dX2nzChgUm16mWacvrPxgn2duoKmqCGYujqnRcGMe+lX72xi5Qzwj/3upOAKKHyNLWLxzuA1QzD8uOW8WGWalbniU/P6VOQ6r7MwTxIEmZ+GzyXTuPsDOodsiylIoTASLBXJhNs551TNxuhvPMP6QjJdfPks+gLuO5BiWnVeOCECIdDWwqpOEiWpRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigadevice.com; dmarc=pass action=none
 header.from=gigadevice.com; dkim=pass header.d=gigadevice.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigadevice.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jFoHlaxKu/Ug/RQh+qh3LZyrv+k9wMaYyQYi93y3OGs=;
 b=dS6msVyAaOw5eDuuIYItw3H5VN46h4+IVJItd9neSRgCI1BiRUHjXs1AByMEsoHUtMKS8Mr8d95u/fG9oYxexOCZXNMI1vAL105sW95BX+e4LD3U+bXsLZuyKPm/SDjbHQe0etwzfSx38dCjrWInlwGaLcHAszF/bXCY37OLLNU=
Received: from SI6PR06MB7813.apcprd06.prod.outlook.com (2603:1096:4:26f::11)
 by PUZPR06MB5827.apcprd06.prod.outlook.com (2603:1096:301:e9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Tue, 28 Oct
 2025 20:33:10 +0000
Received: from SI6PR06MB7813.apcprd06.prod.outlook.com
 ([fe80::554d:309a:787d:e16]) by SI6PR06MB7813.apcprd06.prod.outlook.com
 ([fe80::554d:309a:787d:e16%4]) with mapi id 15.20.9253.018; Tue, 28 Oct 2025
 20:33:10 +0000
From: Vlim <vlim@gigadevice.com>
To: Marek Vasut <marek.vasut@mailbox.org>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: Jagan Teki <jagan@amarulasolutions.com>, Takahiro Kuwano
 <Takahiro.Kuwano@infineon.com>, Tom Rini <trini@konsulko.com>, Tudor Ambarus
 <tudor.ambarus@linaro.org>, Venkatesh Yadav Abbarapu
 <venkatesh.abbarapu@amd.com>, Vignesh R <vigneshr@ti.com>, havish.mutya
 <havish.mutya@amd.com>
Subject: Re: [PATCH] mtd: spi-nor-ids: Reformat the table
Thread-Topic: [PATCH] mtd: spi-nor-ids: Reformat the table
Thread-Index: AQHcR6R84bCIRBwF0Uan6yynaKMByLTWzOjRgAAdAwCAARTGzQ==
Date: Tue, 28 Oct 2025 20:33:10 +0000
Message-ID: <SI6PR06MB7813BEE2045C178C32397BCABBFDA@SI6PR06MB7813.apcprd06.prod.outlook.com>
References: <20251028004729.119349-1-marek.vasut+renesas@mailbox.org>
 <SI6PR06MB7813347A75CE48B5924DF36EBBFDA@SI6PR06MB7813.apcprd06.prod.outlook.com>
 <20ee9a4e-9d66-4507-9c88-6efacef85297@mailbox.org>
In-Reply-To: <20ee9a4e-9d66-4507-9c88-6efacef85297@mailbox.org>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigadevice.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7813:EE_|PUZPR06MB5827:EE_
x-ms-office365-filtering-correlation-id: 42827eba-55ec-4d46-11f1-08de166135b9
x-ld-processed: f84ba339-959c-4ab1-9b67-1e43414f945e,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|10070799003|376014|7416014|1800799024|366016|38070700021|13003099007|8096899003|7053199007;
x-microsoft-antispam-message-info: =?utf-8?B?V2lCS01QTkVqRTE4cXVKVjdKUGk4Qi9HSWkxQUQ1dHNsYWxZTUYvbVhyWEd2?=
 =?utf-8?B?b0NrazVYaVc3UUhpL3pPTFN2VGRvcEJDQ0pYV3dzcWtPNnRCSlMyZDBidk1v?=
 =?utf-8?B?Rmt2ZjZpeXB6MFRWZ3RnaTBhU3BodzB5bHB4WHdMQUF0OXJZeFF6MHl4VDQv?=
 =?utf-8?B?U3poTXBNaUI5bW9mUHVrZy9rdTJFcTF1QTQvUkxoamsveFB1ZVZMcEdKdzRQ?=
 =?utf-8?B?Qk5jM1lnOWFJV2NQWFV6L2gwSHdWWDRUZzg1SEgyTWFnUHV0VVFKRTZkODYv?=
 =?utf-8?B?WmtjYWNaRGVuOWJWenFaeE5JVlYvSUhwZEljdmVoNU54MnU1TlgwZnBsRk9j?=
 =?utf-8?B?TktaOUl3QnBCNlVHYjFVMUZvalVDZXd2UXJKTy9XSmpINWxJbGY1bGpCZmxR?=
 =?utf-8?B?bDNzdEtXa1VlRkl3aHRmd0hSUkRNbTl3TE1zWHYza1R4aERBclU5V3lEeFo4?=
 =?utf-8?B?QlgzbS80MUdTZitiRjBxK3dOZmxqM3hhNGhpNXA4dVdLV24rNXFIMVVGcjV6?=
 =?utf-8?B?YUUrL1BxZmVMT2lZZ1JHdnA5eGJEVDFyNzlKK25PcjVTZDZpMVE1NEhVa3Fs?=
 =?utf-8?B?alkwdjAvUUtoWkVpMUg0ZEh2TkhWaEV3c2N1Z1dDQzNOSG4vUmhHcGprUHow?=
 =?utf-8?B?MmRabGtYRGc0WEwvcHAxRVBrRitSVUZIdGRTN1phRGJsZ0ZkWEJKVFp5d2Jv?=
 =?utf-8?B?alpSU0hYNWxBL0o1NWUzRGw4K054eE9qOEVyd1NabGVFeldpNmpFRnpwcUlF?=
 =?utf-8?B?aUJxY3RaYnRHcTVBT2RrN2lQdWxIenh1YnJ1UUdjUlRYMmtWRDhIK1FNWi9Y?=
 =?utf-8?B?blYwQ1pBTnpCTE5rSUYyUldNZW53U2dUN2hYQlVPczQzRzk3em5WK3NyRDZl?=
 =?utf-8?B?aVRlbFg1T3ZwS1RhT1FKQ2owTUJ2dXhUMEp2aGxmdkVUTnFwbzJUSk43ZmpW?=
 =?utf-8?B?QklEY0VvQUdLZk1Wc2RjWU1ibHF1dlRvMlV4MGV2QXBiTTlYSkZmcDJrK25z?=
 =?utf-8?B?MERpUC9ybDlMa2xvY3h6SGQxbWk4a1BoblMzMjBOZ3VneFBHNGZTWGptVGl6?=
 =?utf-8?B?MWRTbHl5UXNoVlF0NEZ6aHNPRk5kQ3F0SDN2c05CK0ZqaFRUWE0rWFlDSFdU?=
 =?utf-8?B?OUFqOWFyclVnbDJId25uQjZGQUFwZUgrcHplRFRBODhETjdvLzlhYnBCZmov?=
 =?utf-8?B?NHNBcTBGdnE1czhrNElMbTA4bHVvVDNpbUh2UmlDWDlwM1pZa2VuTzlvNHBZ?=
 =?utf-8?B?YkZKM2d2dy9zNFM4di9uTGZMc2w4dTlSUTMyWjZ2N255QXcvak9ZOFdadVhK?=
 =?utf-8?B?UWpzTTZVdUhIRGtHK1MwakZ3ZkJkR0wxWDlRUG5QSzhDYkZLazlqTjUyUHhr?=
 =?utf-8?B?VDFGUnEwQ0h0d3dxSmEyMWJoQzg0b2F1ZjFOeWREZ2ZraXZ2TUpuN091WXhU?=
 =?utf-8?B?WnZZZC92Lzl4YjcrWVZLMTBXNGxLQklMVEJHMjNMUS80MUUrUGxaR0R1VWE3?=
 =?utf-8?B?TlAwNmZJenBJK2hWQ2ZUc3RrS1o2S0lrbkhISVFUWGdBb0FQMWM0Q0hCSDA3?=
 =?utf-8?B?VGxCOWdTdDdYZllqOTdvZTNDSjd2dEFIMHR1em0yNDh2QjV2YjlMc2JEejlG?=
 =?utf-8?B?eGdTc2NTQjNVcGdTKzIyNHViOEV2NFZpNGtEUG5INmlhNm9SMmxCdmc0WGJo?=
 =?utf-8?B?Umx6YkpEVExOUHpidWdIWmV1ZU80ZjMxdU9sOHRoRWUxMlUrY2EvZEMveS9i?=
 =?utf-8?B?Q0Z1YlBDeFBBVytCckdsMnRmMXFSSnVRL21hQ0N3My9ZbXcycWI0WXZvU2h4?=
 =?utf-8?B?Q2p5QVBCWG5BSTVwZXR1MnJsMkNQUGgyd0JUclhiVTJhVXdsR3Z4b2toUmRL?=
 =?utf-8?B?aXZRVEdSRURrSUI0KzZpelViNHpoRlZnR2o3M3dmRWpqK0pqVGM3WjQzUXdV?=
 =?utf-8?B?T1k5YVZOQ3pjZ1YrWGw4dnMyM3cvZHVQd0NlbmRHQmhxZjNpSGRSS1RtQVlz?=
 =?utf-8?B?VlB4d2c5MXkwdVF3YVlqY1BWaHo3czFScXpidVNod2JNZ3ZHSERjb0YrVG5t?=
 =?utf-8?Q?2kk2Hq?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SI6PR06MB7813.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(7416014)(1800799024)(366016)(38070700021)(13003099007)(8096899003)(7053199007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aDJidW92cUQ2NERjbTErdnlSdDUyaHEzVjlvRHVDWUtxSHMwbE9BdXY3eEQw?=
 =?utf-8?B?a3J5TW9SR1FLa3IyNHcvS1BQbzlFWWZ4UDRoNzNQSXZ2bzZuMHVlMXdrUC90?=
 =?utf-8?B?VStVLzdpTFEyemRlbkdUNGNIaDNodjEwU0g3dFNUWjhZUitkRytkQk80OHFj?=
 =?utf-8?B?WkNwRi80ZGQ4RkZzWjBxdWFmSzBxVjlBQlRHUG5IS0N3RFcwdmJoVHM0UGpj?=
 =?utf-8?B?RUhBTUduZVg0Q3F6bzJyWUFmZnBjbURIa0pEOUxwT0E4L2JxRitqc2RFRk1t?=
 =?utf-8?B?aUNnZCtVZXJ2Rjl3OFVtQTErVjAreUp1RXRqQ2psNTlzdTd1dXd4N2d2VHNv?=
 =?utf-8?B?WWtZdERRNHF5ejlEcnI5Q05XSXpSUXlLdmZNbG9VdW4vbTFTdm1vdjl5NmtQ?=
 =?utf-8?B?QW5VZE9LNXhSOHZnbS9scUVpbks0K2Y2NGoyREs4dUo5YXpuVDBNOEM5U2VV?=
 =?utf-8?B?T2xHeFJqWTBLTXFGQ1lBVXZBUWhLc1UrK0w1UTRCaFJsYWR4OHBXSmt4RGkz?=
 =?utf-8?B?NzRjRUR2Ty8xQk1SZkRhOFZwc05ieUg4NFBRYUkyWUVpM3h5d25BdHpOcEE5?=
 =?utf-8?B?QUh6NWo1UTVGQk1aZFc1RUpUa0JYdGtsem5HalRZalk5cGNZUldSOXpIbmY0?=
 =?utf-8?B?WlZjY2hlQ1ZZWUczdFV3TXNtRVpveFJNdHlhSEtwZ3p2aWgxYWRZczlFSk1a?=
 =?utf-8?B?aDRoVmdLamVWZHVlOC9tMHJ1ZkxZWmxiUlNsTnQwVFVWQU1ZNElLczZXSURQ?=
 =?utf-8?B?ODJWdHVPTVVROUx5TmdOSkVyd0Z0L2pnNjVTTEh6WWQyTGNwdFlsUTZacnRR?=
 =?utf-8?B?dTBtcTEyOXRLUDBkcW1DemQ5bzdhODNUblMzUXlvaDFmT3ZrS1k5ZTQ2amZz?=
 =?utf-8?B?ZG8xL2p6REk1cUVwcjdWV2RLVnU0VGY5NElOb0FPLy8rTENiTG5GRnNyZnZI?=
 =?utf-8?B?Mm9MUVhPREVGNnREREpET1dxRkliaVUyNS8yRm5iQk96bldQdEJ4SWtSam1L?=
 =?utf-8?B?SUU5aHVVWWlWOUw4STIra0w3NlhmZlVOL1ZoMGtCVjVGQitvY3J2SDJlV1lI?=
 =?utf-8?B?V29WTm9HZmpya2RSTldYbWpoUmhmRGR0YWxhc0MwUlAybHpmeTJqUEJCUmpH?=
 =?utf-8?B?YjVscVJURVRvMHAzQjRPbkN2NUM2MnE1YTZoTUZWNHphY1FHMXNwUVYxR0Vw?=
 =?utf-8?B?RG9aOVpUZVNEdkc1dHB4d0x4aHh4UkRkcmdMV2JROXh3dWZnZTJidERSMDli?=
 =?utf-8?B?aW1EcXQ0UmZJV2ZMY1NBcjhGeVVTM2FDZHM3R1VUQkVrQUdvK2R4aEVMTVZG?=
 =?utf-8?B?dW1OQVZtR29VRWhjblFjOUZYb21vUW9UaHd2dktEbW5BUFJLUWNuenQ0NTFH?=
 =?utf-8?B?VUQvTWlUaFFWbUhyQXFOWjJadDFuUGVsVFFrYnVCQWFzcW12cVF4UDZ6MkF6?=
 =?utf-8?B?S0ZsTHVDbjEyNHppSWlYU0JacUs3VStIU3JTSHdxNXNRU0ZvdHNXY2xWQkxr?=
 =?utf-8?B?a2FscEVUdURVbGgybm00VGNISjNQb1dhd0JkYWtYWkVzL1pacTFieXRYeC9I?=
 =?utf-8?B?b2txTldwNTlFM09saTZPcGp2SmpXejh1cStEN1N5MWJEeTdSYkMrK21HYllH?=
 =?utf-8?B?dmRkYmJHdTZSMTJyWnJKaGUxMUR1eDJsWkxnTkxPdGNNcXVSS1dGWk9kYXRq?=
 =?utf-8?B?Ni9SaVBjajhRSEtjcnRsY2NZMG5TSnhSZzZtLytHdFBnZkkvdWNLc28xYURK?=
 =?utf-8?B?NTdpdmhOZXo3K2p3QlVIcnN0SWRhMGpMZG5tcGN0OHpabHJ0dlY4RWpKSHc5?=
 =?utf-8?B?RXlNa1d6Y3pvcTRSVTVtSmdFT1FTSFRuQVFoeERxUkV0L2xiK3BGcWNzTmZ0?=
 =?utf-8?B?Nmt3MzRacmFhVDlYQjEvSFhEcnkvNlUrQUcwNi92VGNXVjBtb0Y5TFh4Qjc5?=
 =?utf-8?B?U2xOTWljbXVQeHE0TlBCOVNwMlhxWjJuRXVER2F4anczNXRQbS9IbUp4c0Rh?=
 =?utf-8?B?QWI3dkhCL2FCTWlvY1ByZGQ3TjM2dGhTRzVRWUswYUJ2NzFZZDlDMXFwb1hq?=
 =?utf-8?B?QzZidmlwYU0zOWlKWXdXcHc2bEQyU1FiRmxNNlBCTFZEaGs3UG9ZVnpnUytG?=
 =?utf-8?B?NW40NjdnYURGMkdRUTl5SnRPT21GT3hmSjl0VGtpTGJZUFh4TjBXbGtYK29I?=
 =?utf-8?Q?NKa0smlYSwFiaSmof2idFFubvr1QTqVMJ7PDCWR+PiTx?=
MIME-Version: 1.0
X-OriginatorOrg: gigadevice.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7813.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42827eba-55ec-4d46-11f1-08de166135b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2025 20:33:10.1938 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f84ba339-959c-4ab1-9b67-1e43414f945e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d6Fzr3ek8qjiv0vAEfvE2JXJxjw51MxCk1qWjkBTjnKctvyQEj9t4Ynngoi/U41gsiY+mVx6IaaBI2YeRj/Xcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5827
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

SGksIE1hcmVrLA0KDQpUaGlzIGlzIHdoYXQgSSBwbGFuIHRvIGRvLCBwbGVhc2UgYWR2aXNlIGlm
IHlvdSBhcmUgb2sgd2l0aCBpdC4NCg0KDQogIDEuDQpyZWZvcm1hdCB0aGUgdGFibGUgdG8gZm9s
bG93IHRoaXMgZm9ybWF0Lg0KDQrigILigILigILigILigILigIJ7DQrigILigILigILigILigILi
gILigILigILigILigILigILigIJJTkZPKCJnZDI1cTMyIiwgMHhjODQwMTYsIDAsIDY0ICogMTAy
NCwgIDY0LA0K4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC
4oCC4oCCU0VDVF80SyB8IFNQSV9OT1JfRFVBTF9SRUFEIHwgU1BJX05PUl9RVUFEX1JFQUQgfA0K
4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCCU1BJ
X05PUl9IQVNfTE9DSyB8IFNQSV9OT1JfSEFTX1RCKQ0K4oCC4oCC4oCC4oCC4oCC4oCCfSwNCg0K
DQogIDEuDQpSZS1hcnJhbmdlIHRoZSBvcmRlciBvZiB0aGUgdGFibGUgYmFzZWQgb24gdGhlIElE
LCBzbyB0aGF0IEkgY2FuIGdyb3VwIHRoZSBwYXJ0ICNzIGJ5IHByb2R1Y3QgZmFtaWx5Lg0KICAy
Lg0KSSBoYXZlIGEgZmV3IG1vcmUgcGFydCBudW1iZXJzIHRvIGFkZCB0byB0aGUgdGFibGUsIGNh
biBJIGFkZCB0aGVtIHdpdGggdGhpcyB1cGRhdGU/DQogIDMuDQpEbyBJIHN1Ym1pdCBhcyBhIG5l
dyBwYXRjaD8NCg0KIFJlZ2FyZHMsDQoNClZpY3Rvcg0KDQoNCg0KX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18NCkZyb206IE1hcmVrIFZhc3V0IDxtYXJlay52YXN1dEBtYWlsYm94Lm9y
Zz4NClNlbnQ6IE1vbmRheSwgT2N0b2JlciAyNywgMjAyNSAyMDo0MA0KVG86IFZsaW0gPHZsaW1A
Z2lnYWRldmljZS5jb20+OyBNYXJlayBWYXN1dCA8bWFyZWsudmFzdXQrcmVuZXNhc0BtYWlsYm94
Lm9yZz47IHUtYm9vdEBsaXN0cy5kZW54LmRlIDx1LWJvb3RAbGlzdHMuZGVueC5kZT4NCkNjOiBK
YWdhbiBUZWtpIDxqYWdhbkBhbWFydWxhc29sdXRpb25zLmNvbT47IFRha2FoaXJvIEt1d2FubyA8
VGFrYWhpcm8uS3V3YW5vQGluZmluZW9uLmNvbT47IFRvbSBSaW5pIDx0cmluaUBrb25zdWxrby5j
b20+OyBUdWRvciBBbWJhcnVzIDx0dWRvci5hbWJhcnVzQGxpbmFyby5vcmc+OyBWZW5rYXRlc2gg
WWFkYXYgQWJiYXJhcHUgPHZlbmthdGVzaC5hYmJhcmFwdUBhbWQuY29tPjsgVmlnbmVzaCBSIDx2
aWduZXNockB0aS5jb20+DQpTdWJqZWN0OiBSZTogW1BBVENIXSBtdGQ6IHNwaS1ub3ItaWRzOiBS
ZWZvcm1hdCB0aGUgdGFibGUNCg0KW1lvdSBkb24ndCBvZnRlbiBnZXQgZW1haWwgZnJvbSBtYXJl
ay52YXN1dEBtYWlsYm94Lm9yZy4gTGVhcm4gd2h5IHRoaXMgaXMgaW1wb3J0YW50IGF0IGh0dHBz
Oi8vYWthLm1zL0xlYXJuQWJvdXRTZW5kZXJJZGVudGlmaWNhdGlvbiBdDQoNCuatpOS4uuWklumD
qOmCruS7tu+8jOiwqOmYsumSk+mxvOmCruS7tu+8jOivt+azqOaEj+mCruS7tuaYr+WQpua2ieWP
iuaVj+aEn+S/oeaBrw0KVGhpcyBpcyBhbiBleHRlcm5hbCBlbWFpbCwgYmV3YXJlIG9mIHBoaXNo
aW5nIGVtYWlscy4gUGxlYXNlIHBheSBjbG9zZSBhdHRlbnRpb24gdG8gd2hldGhlciB0aGUgZW1h
aWwgY29udGFpbnMgc2Vuc2l0aXZlIGluZm9ybWF0aW9uDQoNCk9uIDEwLzI4LzI1IDM6MDMgQU0s
IFZsaW0gd3JvdGU6DQo+IFRoYW5rcywgTWFyZWssDQoNCkhlbGxvIFZpY3RvciwNCg0KPiBDYW4g
SSBmb2xsb3cgdGhpcyBmb3JtYXQuDQo+IFNob3VsZCBJIGNoYW5nZSBhbGwgcGFydCBudW1iZXJz
IHNvIHRoYXQgdGhleSBhcmUgYWxsIHdpdGggdGhlIHNhbWUgZm9ybWF0Pw0KDQpXaGF0IGtpbmQg
b2YgY2hhbmdlIGRvIHlvdSBoYXZlIGluIG1pbmQgPw0KDQpJIHRoaW5rIHRoZSBnaWdhZGV2aWNl
IHBhcnQgbnVtYmVycyBsb29rIHZlcnkgbXVjaCByZWFzb25hYmxlIGFscmVhZHkuDQoNCj4gQWxz
bywgaXMgaXQgYSBnb29kIGlkZWEgaWYgSSBjaGFuZ2UgdGhlIG9yZGVyIG9mIHRoZSBwYXJ0IG51
bWJlciBzbyB0aGF0IEkgY2FuIGdyb3VwIHBhcnQgI3MgYnkgcHJvZHVjdCBmYW1pbHk/DQoNClN1
cmUsIHRoZSB0YWJsZSBpcyBub3Qgc29ydGVkIGV4YWN0bHkgYWxwaGFiZXRpY2FsbHkuIElmIHNv
cnRpbmcgYnkNCnByb2R1Y3QgZmFtaWx5IG1ha2VzIG1vcmUgc2Vuc2UgZm9yIEdELCBsZXQncyBk
byB0aGF0Lg0KDQpbLi4uXQ0K
