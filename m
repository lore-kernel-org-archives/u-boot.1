Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA19AC2A072
	for <u-boot@archiver.kernel.org>; Mon,  5 Jan 2026 05:34:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F064083A9F;
	Mon,  5 Jan 2026 06:34:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="Qiazohl5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D471383C67; Mon,  5 Jan 2026 06:34:15 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 278FA83A3B
 for <u-boot@lists.denx.de>; Mon,  5 Jan 2026 06:34:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wi0YEo0caWZUatiDsDVZtR9nkk0rhVc4/xfsIn+j6Eiou5K/KfNHiMtUo6NgsIQ9kkjRKnO19c2noEpS3hnRFpq/HqqiKt7+zkw7Pzm6bb92iLA80IzonUGfQMbwEfyNe/fAHmlmxJIqjQiySrpK8C26Y2mBOXcZiZqIYdtxuIlpbkFfJreAgNVPV6cINCHF9baOiT3vu/5dCPIs61LnsLVt6Ywq0qUsk2nzP69Vv/zBPl4CXwxmAQicl/KdTzamqn3ClJsL9XgnxwiSm4UNvD1ooNAeZlGwpSybM4qBVHNhlrEeMf4tr5lnMu973RxYbpPGqUE7dOuMh38TNFCGXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ON28oJS6c52EuGseNL+vlQcJIYx4dQd7Wsd4DCMt2u0=;
 b=AfYC6VIVkNMlZOAaHLzZcjZQNwr5+iHV2q122rkCYPwg5i/2h7hwN/1Ex7AyWeOg9vV0YHNUA+CKTNiR/Dv6dABVUiKXbXC3+Me/9ccQlyHXdnzCpYBLPuImcGKro3nSQXrNInDeoyOSClZZGY29Cy0kYaC1D5P/lRpDatPdz7EaBZEYwpLyvar3Jog55mZd5mI+vWTmB1Lm6SPhufMzmU+sBxsbBJl8vLpbZHV1BmtLkigUlsriZrxWTpEzWbxyrsF1kjeYAaFKo0mvIN5Y3rKD92Xr4eGJgDJ6ik7V1BGlWqszI9+5YLnTljwZx+CfSk6dPt/3TQ6UZmfJnJMVTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ON28oJS6c52EuGseNL+vlQcJIYx4dQd7Wsd4DCMt2u0=;
 b=Qiazohl5hmyjGpA7eav4p4AWfT77PnUsIsG3MzjcUzBqyV6uSWrGX4JkW7gHYebdqte7dlq2lMQifDE1ShY/TB11Npa6vIbOtbkDDLkQZdqwFAvTQvoeAur3yDLNZdylwK+dh9d8zSjqssc5CYUDvyPmdvYYW8BCaEH9PXPVJUD5vcppMw2qlhyt8rwWliBUhb3n49yAJODV3CBpccKDTgxhVLZHThNumS3tZ+lCphgYLK2Tkgxyz6TpCC636HTFl1Obxx3Io0zFBdUYySgr3RqIP8AP3rwr9h7cY5jlntVuaVDWBc8MYr3v8f6XoV5D8WPt/5NyHV5HzL5QRN5Eyw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:4b3::21)
 by DU7PPF94CC0A1A7.EURP195.PROD.OUTLOOK.COM (2603:10a6:18:3::bdb)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Mon, 5 Jan
 2026 05:34:11 +0000
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::369c:a760:5bf9:8d4a]) by AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::369c:a760:5bf9:8d4a%2]) with mapi id 15.20.9478.004; Mon, 5 Jan 2026
 05:34:11 +0000
Message-ID: <48ecfbe5-7e16-494f-9e5b-49039a88a06a@phytec.de>
Date: Mon, 5 Jan 2026 12:33:57 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [Upstream] [PATCH 3/3] doc: board: phytec: Add phyCORE-AM68x/TDA4x
To: Dominik Haller <d.haller@phytec.de>, Tom Rini <trini@konsulko.com>,
 Teresa Remmet <t.remmet@phytec.de>
Cc: upstream@lists.phytec.de, u-boot@lists.denx.de
References: <20251231014255.87648-1-d.haller@phytec.de>
 <20251231014255.87648-3-d.haller@phytec.de>
Content-Language: en-US
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <20251231014255.87648-3-d.haller@phytec.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KU2P306CA0039.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:3c::7) To AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:4b3::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4P195MB1456:EE_|DU7PPF94CC0A1A7:EE_
X-MS-Office365-Filtering-Correlation-Id: 08227975-c734-431f-5783-08de4c1c0dda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L0RFZzVmM0xDWFdUVkpHQzdIaS9mbDdEOE5pU2JJcm41Z2N4cEoxRVc1L0RR?=
 =?utf-8?B?cmlFYWRzQW1FbTZaQUVzRURKQ2JqaWkvU05oV1E2SC9YZVR2anQ5dGdFUXQw?=
 =?utf-8?B?L2NRQ0xZSVBkVUJTUndWVWZacThwQ1FVZEo3YWpKTUxHN1JPYkszRC92bzVD?=
 =?utf-8?B?REZsb3VqUDNmdUNtVDJIQWZmSEhkV1kxMW5FVHR3bkFZV0s2dlUrcWYzTlFt?=
 =?utf-8?B?RWVsWXVrOUtWWC9qRGpXaTlKdXEvWFUxSUd5R2poVnMyNWlxUFh5RDU5MjJ1?=
 =?utf-8?B?QjFEMkhGSG1xbGlsRjhGS3VQUXVKYjh2RG5rbC96ckZYZDU0U0N5RjcrbTJy?=
 =?utf-8?B?S0k4WXpuYWVZZExLUGYxK2t6QWZ0dzgzdkd5VzlWOVNNK0dSYXhJdXNxRStr?=
 =?utf-8?B?eCtpcGZXUzYwQXlraGhtRHR1VytCVm5MbGtLcUVuUTEyYTRUR2VTNG9pSUV6?=
 =?utf-8?B?UmRPU0FaRnl6MjR4U3FxNzFOOVRxQkprL3VQeGw5TStkbTZTQWRVS05TMk5P?=
 =?utf-8?B?VE9YaVZ3cm9FYTREZVZTYlY5ZXhIYVNVMnkzSkdMc2tISVRjdmZSYU0vVW9O?=
 =?utf-8?B?Qks5N0l3dElEdy9lRnVOc29oaUZ4Wnhyd1hjYmRKV2hvdGExWm9EUXZrcE5k?=
 =?utf-8?B?RGJzMU13OE9PQjVzU2hmcHk0VVBzcU1GNDVXdVlnU2J2cWZUdmJEQWpyUDBD?=
 =?utf-8?B?VVJicTZ2RkpmUEg4bXBSeHBVRzROc2ZyWG9FZWpUM09zMGpiLzVDa0dMOTF5?=
 =?utf-8?B?Uy8xZVZkVWxuL1VJemF6eGVNL245alg5YlFEenpzUHdic2I2SjJOR1ByT1hz?=
 =?utf-8?B?UW1MY2VJaTZXcEVkZ3JHZGE4U1JsNkNwY3lLQy9QeUEvWUNWRzdERmpFdmtB?=
 =?utf-8?B?eEFxMnd0QmhOcDlZbDN3SHBUd29oajNDWlFvdUJnaEtDeG5Na1BaRkhyVTBa?=
 =?utf-8?B?T0E3V0l0MUFtbk1Ccml1REdWanN0NXRueFhNaW9kSjlvWk1WNVpzWC92VllP?=
 =?utf-8?B?bDk5d0ZGaVRIdExVU1JRTnJ4NnI4UlN5TFR1QjlpR2pONFJ1OGJTcVJRTXlR?=
 =?utf-8?B?M1FvdmdmV0dWZVNuODdmcGQwQUFZNWRvYytHVy9tc1JTb1pOMnRQS1JkQndy?=
 =?utf-8?B?UFpkejUxWFpyajdSSVYrcVJjMk0ybmt0UXBjWkpmelRSbG5YK3RSSGNCdm5v?=
 =?utf-8?B?TlE5UEZZZkdKcE9pL2lxMkpxc3NkdTM3OHUwTVNsYzYzRUFFRFU1aEpaWUNJ?=
 =?utf-8?B?UlJFcU1lRkFZeldNUmFOSzA2dzJiM1RiQnltcy9KdmJVcFRZRkJZTGk5RUpm?=
 =?utf-8?B?bzZDNnZpdjFoSHlQMjR5akM3c0pySXVKS2F4SWJtbVZick1TbEFXU1ZETFVQ?=
 =?utf-8?B?Uy9ORk94Z0JzRmxiaGF5TkJTaXJwWGdvM1ZQUzIzdEZTeEo3MHVnZEIrVmxL?=
 =?utf-8?B?RjJGWWVxVGtFZWg4R2RFOWdXOFF5Sk9POHJuUGZiMWtRdjd4ZUFYQTZLZE1N?=
 =?utf-8?B?a3dha1BQaUNtRFlJYWJ3QVFEdkdqN0d5Vnd6WFpIdmQ0QUhCYkVPVEdZTmF5?=
 =?utf-8?B?TENNL0JoTWp6aFhkcWNPWWNucVMrZU90WTJrWXUza25rRUFjTnVxQk1PRlMx?=
 =?utf-8?B?eHp3dldKWkIwZjAyMEc4aCtFWE1Pa3BVZXRIdExGZ2cxdEFVVjYwVW5KRUZC?=
 =?utf-8?B?UkZ0cVJSRHRkR0JlZGM5b3lVNEZiMVBZTE1tM0t1ZkxNMFJ6Z1JkS3lkb0h0?=
 =?utf-8?B?ODc3SStzR29kR1BVamRvNFJwVUFlZ2pLT0NqODlZbkM2VzcvOEphTlZzUzU1?=
 =?utf-8?B?cXVySnQvNmRqZkY2eGRqWmhJQXFvbG9GNnRYbHUxSTFPajVSRlI3b244SUdt?=
 =?utf-8?B?Z0pUSExUSWZEaTNFNUpwdVB3QUZaY1RSNTYvM0RQTXdDQ3dxZFI1ajNsNTE3?=
 =?utf-8?B?VVUrbVVlOVVEMDhjdXBrZHVsR0poVlc0VmFpbFM0MDkzYnY3VURBalRCNUJP?=
 =?utf-8?B?SjltT2hwdDhRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4P195MB1456.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHcvNHU5U0NPL1FFR3JXWHF5OTNVZkEvQWdQeUVsS3ZkaXhEdnJoR0p5bEhr?=
 =?utf-8?B?M0hldTRDRkFwNlQwZCs4SjNRK3JrTXM2bUF4Z3RFdDJTTURvUkdMejBWeHNL?=
 =?utf-8?B?QUVFMDZiVE9zQU92NERkR1VBSjByazZhK3o5NWlpWkhvc3ErYnpNc0t5ZW1E?=
 =?utf-8?B?R2F5ZmVIcFIxK1RkUktuTTNzS3dKQk0vOXk3bEp1Mzk5MVFDQkhvNmFydW1j?=
 =?utf-8?B?T0k3bzV3SDhQWEFJQm43VjRIbHM4YU5lWTBXZS93NkdIQ2lXdW1ScHpmNTBx?=
 =?utf-8?B?VnRGbUFrQ1h5VGRrR2paOWxSc2kzUXNBeTNHUjJkZ1loanpRY09IUkNRZTli?=
 =?utf-8?B?OFVVUytoYndOSWtLMWZVdlhBTmhoTEtHWGJUdSs0VVBBcUpQcUlzK0tTZTc2?=
 =?utf-8?B?MGVQOEc4aE43SFJ0eFVCbTY2ajAvODgyN1Nad2NScHJlM2ovT3h6dFA1MFpY?=
 =?utf-8?B?cGhQZnJGTWI1Z24xWUkwMHdHTHoyUkFLMER1TCtQTFlpcjZXWkdlUmtFenRq?=
 =?utf-8?B?SmpvVkdVRi83UHlXVzRPZkVSaFRjS1NZQUt1cUJzQkZCY3E3N3FJalZaRzI1?=
 =?utf-8?B?V051NWJZU3J0eW5NcmhDaHVydkM4YmFidFBFVTVlWk83cE9JY2lyWU9TSERn?=
 =?utf-8?B?a0xsa2M3ekxKSFZCMTFXWUQvVWxyN1RWQXFqZWNNbDJ2YnRaNVBkbFBndEMy?=
 =?utf-8?B?QTRGZUs2YjZkL0ZENVloMDU0eS80RzY5cG5sSG5qdWt2T1RVNlpKeWp2YVdM?=
 =?utf-8?B?cHdHQ1YvY2lmZW9LRllhZnBhM3dKTVBZUUtsVlQwMHhCaE42WEZrUnhiTWlK?=
 =?utf-8?B?RWZjZW9BYXJNdGlJbVlhc0hDSTkyOTNjT2p3SkRyZEZDNTF1NjNTeVlCZFZl?=
 =?utf-8?B?d01JeTZIQkNmdTFuQ3hGekVySks0RFdTSkUrbmpGMmV2ZDNRZGUxTkIzMnZw?=
 =?utf-8?B?MUpMODFLVitPQzRoeWVUczR5bjBpSHJjSW1KTUxUdnViTVBXdE9oQ25RUFhn?=
 =?utf-8?B?K2ptT0c2MFltRmhaZXkvMXU5b3hIdnlXSGE0SUJ0QlhPR0swSHdqV00wazQ3?=
 =?utf-8?B?S3FLOStrM3ZnanFneW5IQVFnTHRDSUQ3Mk1vR0tSKzZCVWYrOTZROXdVTi9Y?=
 =?utf-8?B?MkkvN3JUcXg0SXlsV1QxbkNESzk0K3ZtWDN6cW1mRk5PYVhZdVNJamZrWnJ6?=
 =?utf-8?B?Q0pCR3UxZ1ZLOWhBYTdSamVGbnI2STVwWE1abnpLVjQyRUpvM2VoQ2pTMHVl?=
 =?utf-8?B?WkZUZkkyRzJLWU90YVBONENLa1dRWkJ3c0lhYy9vbjF1cUdsUzMxM2E2QW8z?=
 =?utf-8?B?NG5mUjJvR0pCT3ZQNUE5akI4QjJ2V0htNklnTmRIV1JGWTlvczEvS2lNYlVv?=
 =?utf-8?B?WUs1cXJZc1pjcFZibjJFdGh0RGNKK1RNR1QzdmFoTjMvYjdBSEVNNEFyNStq?=
 =?utf-8?B?aVVneXNtQ2wvc0pOR3RsZWdQb0QyTVZYendpVDVDd1pEekhqMktCMzNwQkRZ?=
 =?utf-8?B?TUpSdmVNR3Y3a3dxUHJsejFuYkx3MFlTUUpETnRDa1NKMExPeEJvUHdRTEZD?=
 =?utf-8?B?WkxCUnJFbnFuYmZlOHBaL0Mrd0VPdzFvUllTN0oydTN5eTQ5SlRla3FlY0hm?=
 =?utf-8?B?TXd6Z3EySFVEZVJxNkFqRTNsNXRFckVvY2hDa3dKSGcvV2xqTmZ2bEhYUlZO?=
 =?utf-8?B?RHpiSGhsQkdRSHVoUTBNMjYrcmorbEpDRjIzdzhQOTVzU3dFN21PNG1NQ0Vk?=
 =?utf-8?B?TDBZRWdWR21TbC9NOWRXSC91UkNqaThwNmZuTytTcWdzOU5lQW5qbGJsK0RF?=
 =?utf-8?B?SVhnaVQwQmxYMVRSNHA2cDBLNVVzUldDaW45S2wxQjJYRCtlWktad2JlTlBk?=
 =?utf-8?B?OWkwVm52RHB4MndoU0l1emtYQ1pPeWM4Y0tXYlNsOTIxY2hlZ1FMaDBvZXVz?=
 =?utf-8?B?dzEvT3V4TXhtTXRxcjRMdk9xSXNRUnJmY251VmU1M3pqWmZuYzViL2tkaTJt?=
 =?utf-8?B?LzZGNHg5S1ZlRTI3K25yblkvcVVsLzZjeVYvWjk3R2k3aklkeU5BMmx3Zm12?=
 =?utf-8?B?WnBJeGlpWlBHNzhZL0NtdEsyL1BPQ1hoK1NJSzl2Nk1tSkFoMWhPUUpCMThs?=
 =?utf-8?B?anJrOGZBY3VYTXhnb1lLVnIyNjdNSlA0bjFlUEVqTDFwVmQ4MEZ0WS9ndG0y?=
 =?utf-8?B?MTNZMzhQZHYxSnRhRzM1TWpMYzhYNXhpejYyaytoSkxXclV4azkzVUI2OEhj?=
 =?utf-8?B?OEVEd0kzc2VXMDZRM3JXVGZsd2dLZlNQb1hnQjRpa1VMbWhTOVhZd0JTWG1P?=
 =?utf-8?B?VStPb1E3ZVBPa3RCOUFlbE9TTXlmdmlnUFloQTB3MExSQjJybHY5Zz09?=
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 08227975-c734-431f-5783-08de4c1c0dda
X-MS-Exchange-CrossTenant-AuthSource: AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2026 05:34:10.9466 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6OjOLtjML8BZ6CyTGwdlyOjFsavpzdGk/df3STspD0vjeCgbwVR5uyUZhKye3etvQdkQuLJEXDlSZeduwtUQrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU7PPF94CC0A1A7
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



On 12/31/25 8:42 AM, Dominik Haller wrote:
> Add documentation for the PHYTEC phyCORE-AM68x/TDA4x (J721S2 family) SoM.
> 
> Signed-off-by: Dominik Haller <d.haller@phytec.de>
> ---
>   doc/board/phytec/index.rst         |   1 +
>   doc/board/phytec/phycore-am68x.rst | 166 +++++++++++++++++++++++++++++
>   2 files changed, 167 insertions(+)
>   create mode 100644 doc/board/phytec/phycore-am68x.rst
> 
> diff --git a/doc/board/phytec/index.rst b/doc/board/phytec/index.rst
> index e24040a496e9..dd9edd792f40 100644
> --- a/doc/board/phytec/index.rst
> +++ b/doc/board/phytec/index.rst
> @@ -12,5 +12,6 @@ PHYTEC
>      phycore-am62x
>      phycore-am62ax
>      phycore-am64x
> +   phycore-am68x
>      phycore-imx8mm
>      phycore-imx8mp
> diff --git a/doc/board/phytec/phycore-am68x.rst b/doc/board/phytec/phycore-am68x.rst
> new file mode 100644
> index 000000000000..974dc53a30a8
> --- /dev/null
> +++ b/doc/board/phytec/phycore-am68x.rst

Don't forget to update the board/MAINTAINERS file.

With that changed,

Reviewed-by: Wadim Egorov <w.egorov@phytec.de>

> @@ -0,0 +1,166 @@
> +.. SPDX-License-Identifier: GPL-2.0+
> +.. sectionauthor:: Dominik Haller <d.haller@phytec.de>
> +
> +phyCORE-AM68x/TDA4x
> +===================
> +
> +The `phyCORE-AM68x/TDA4x <https://www.phytec.eu/en/produkte/system-on-modules/phycore-am68x-tda4x/>`_
> +is a SoM (System on Module) populated with AM68x or TDA4x SoCs from TI's J721S2
> +family. It can be used in combination with different carrier boards. This module
> +can come with different sizes and models for DDR, eMMC, ETH-PHY, SPI NOR Flash
> +and an optional SN65DSI83 DSI->LVDS transceiver using DSI0.
> +
> +A development Kit, called `phyBOARD-Izar <https://www.phytec.eu/en/produkte/development-kits/phyboard-izar/>`_
> +is used as a carrier board reference design around the AM68x/TDA4x SoM.
> +
> +Quickstart
> +----------
> +
> +* Download sources and TI firmware blobs
> +* Build Trusted Firmware-A
> +* Build OP-TEE
> +* Build U-Boot for the R5
> +* Build U-Boot for the A72
> +* Create bootable uSD Card
> +* Boot
> +
> +Sources
> +-------
> +
> +.. include::  ../ti/k3.rst
> +    :start-after: .. k3_rst_include_start_boot_sources
> +    :end-before: .. k3_rst_include_end_boot_sources
> +
> +.. include::  ../ti/k3.rst
> +    :start-after: .. k3_rst_include_start_boot_firmwares
> +    :end-before: .. k3_rst_include_end_tifsstub
> +
> +Build procedure
> +---------------
> +
> +Setup the environment variables:
> +
> +.. include::  ../ti/k3.rst
> +    :start-after: .. k3_rst_include_start_common_env_vars_desc
> +    :end-before: .. k3_rst_include_end_common_env_vars_desc
> +
> +.. include::  ../ti/k3.rst
> +    :start-after: .. k3_rst_include_start_board_env_vars_desc
> +    :end-before: .. k3_rst_include_end_board_env_vars_desc
> +
> +Set the variables corresponding to this platform:
> +
> +.. include::  ../ti/k3.rst
> +    :start-after: .. k3_rst_include_start_common_env_vars_defn
> +    :end-before: .. k3_rst_include_end_common_env_vars_defn
> +.. code-block:: bash
> +
> + $ export UBOOT_CFG_CORTEXR=phycore_am68x_r5_defconfig
> + $ export UBOOT_CFG_CORTEXA=phycore_am68x_a72_defconfig
> + $ export TFA_BOARD=generic
> + $ export TFA_EXTRA_ARGS="K3_USART=0x8"
> + $ export OPTEE_PLATFORM=k3-j784s4
> + $ export OPTEE_EXTRA_ARGS="CFG_CONSOLE_UART=0x8"
> +
> +1. Trusted Firmware-A:
> +
> +.. include::  ../ti/k3.rst
> +    :start-after: .. k3_rst_include_start_build_steps_tfa
> +    :end-before: .. k3_rst_include_end_build_steps_tfa
> +
> +2. OP-TEE:
> +
> +.. include::  ../ti/k3.rst
> +    :start-after: .. k3_rst_include_start_build_steps_optee
> +    :end-before: .. k3_rst_include_end_build_steps_optee
> +
> +3. U-Boot:
> +
> +* 3.1 R5:
> +
> +.. include::  ../ti/k3.rst
> +    :start-after: .. k3_rst_include_start_build_steps_spl_r5
> +    :end-before: .. k3_rst_include_end_build_steps_spl_r5
> +
> +* 3.2 A72:
> +
> +.. include::  ../ti/k3.rst
> +    :start-after: .. k3_rst_include_start_build_steps_uboot
> +    :end-before: .. k3_rst_include_end_build_steps_uboot
> +
> +uSD Card creation
> +-----------------
> +
> +Use fdisk to partition the uSD card. The layout should look similar to:
> +
> +.. code-block:: bash
> +
> + $ sudo fdisk -l /dev/mmcblk0
> + Disk /dev/mmcblk0: 15 GB, 15913189376 bytes, 31080448 sectors
> + 242816 cylinders, 4 heads, 32 sectors/track
> + Units: sectors of 1 * 512 = 512 bytes
> +
> + Device       Boot StartCHS    EndCHS        StartLBA     EndLBA    Sectors  Size Id Type
> + /dev/mmcblk0p1 *  128,0,1     1023,3,32        16384     278527     262144  128M  c Win95 FAT32 (LBA)
> + /dev/mmcblk0p2    1023,3,32   1023,3,32       278528    1693883    1415356  691M 83 Linux
> +
> +
> +Once partitioned, the boot partition has to be formatted with a FAT filesystem.
> +Assuming the uSD card is `/dev/mmcblk0`:
> +
> +.. code-block:: bash
> +
> + $ mkfs.vfat /dev/mmcblk0p1
> +
> +To boot from a micro SD card on a HSFS device simply copy the following
> +artifacts to the FAT partition:
> +
> +* tiboot3.bin from R5 build
> +* tispl.bin from Cortex-A build
> +* u-boot.img from Cortex-A build
> +
> +Boot
> +----
> +
> +Put the uSD card in the slot on the board and apply power. Check the serial
> +console for output.
> +
> +Boot Modes
> +----------
> +
> +The phyBOARD-Izar development kit supports booting from many different
> +interfaces. By default, the development kit is set to boot from the micro-SD
> +card. To change the boot device, DIP switches S8 and S7 can be used.
> +Boot switches should be changed with power off.
> +
> +.. list-table:: Boot Modes
> +   :widths: 16 16 16
> +   :header-rows: 1
> +
> +   * - Switch Label
> +     - SW8: 12345678
> +     - SW7: 12345678
> +
> +   * - uSD
> +     - 00000000
> +     - 01000001
> +
> +   * - eMMC (FS/UDA)
> +     - 00000000
> +     - 10001011
> +
> +   * - eMMC (HW partitions)
> +     - 00000010
> +     - 10001011
> +
> +   * - OSPI0
> +     - 00000010
> +     - 00001100
> +
> +.. include:: k3-common.rst
> +
> +Further Information
> +-------------------
> +
> +Please see :doc:`../ti/j721s2_evm` chapter for further J721S2 SoC family
> +related documentation.

