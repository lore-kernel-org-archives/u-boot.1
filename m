Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1571C5AD49
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 11:11:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6B8683A71;
	Wed, 28 May 2025 13:11:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="tMWog3VX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B4A983A79; Wed, 28 May 2025 13:11:29 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2062c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2413::62c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8125E839A7
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 13:11:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=naresh.kumar.ravulapalli@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ShRf5HyrjshdyiwJ6vcyCsxyvRw7oSBXtwjur7xx+fgI7KVh/36ilvllvLqG5mBKt82gs+KlDP43ZFyd5LNzq/3OXi7IlT/OQIc1AnWaeb89A7eRCEQLX/eIpCPS2QfZHE0lrC1v7cuIT0JQ31IiAZ7qvow4sOdMUxAsP77WoWigh61GlVxEBH1+rEQLfiIHMG3jf8sYiLZuY4egenPA9GD2b7GaDaqhdkx6YAGHZxbZrdKQdGbCSOx0chOFDWmAFwEf3vqlnidbqkxY8QfDOzHrb5Ax4jOjUVBzt3faVaoC2lS3GXBGGft1PS/r0QcJ5QBxH10Xlbue+oC4ookwjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vDd1GMe1Znl+FEnOBFEt8GNUJuKvsvbxmHSKupJFWAU=;
 b=ha+uUIX6uJm0TnNhKPGQ8YyEfTWSjsq7iY1Le5triq827XfjsaG07oe+qugUJ8mcfBQcyXyIBqRgH8mOhOIw/DrtNuj6BlQjOUEs/Yhw1XCvNAGsO+MakKbOLnsI3Wg7qsXHmKtAYtjL8ziw+u1rCYXcELFFNtkHzraCFG34jB3c/YWu9G63yCD5xFu3yd7BmizpuKDg/lBqJbKMH10xqiDJEo1IsfJMXLSuYRvAZbGJ5/5TAY5vaIrJOMsN/BTRIb+I32yx60e2yd3qU1oIhjAhyRVIXwLS1JCa2ZwdsAYGrwNfZWomGYcn6RTgizmTAuglu2RrQNz9MMlfFhS9QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vDd1GMe1Znl+FEnOBFEt8GNUJuKvsvbxmHSKupJFWAU=;
 b=tMWog3VXqRC9f3F+54UUV5m614FWj7Xs5+VPjDVYS8L/2MegB1CVMefQYrhLWvAERgUfKYFcuLEwaUhffvA2GV+Pt+TUSoGGBk6u0fE2LK3wh5tIQ4fCU2dsHs4JP9MY3NEynscXHfckuGEdW/GQc+BI2Z4SWyi0nEMFq7507kbefoJeXHtsb/vN23LGQbIPcpMR2NfmlZU6fcdJMiMROUVvy1rJQFbS5SjE2b71wC3woBktyuBXNoxfglMw9/r9RHEE004DKadtpHV4isuNx2CMuQlThm6Ds8GOrSYIoGFkus343yXlldy3vEExIdUOLDHnj0PfMmSey15EL/Pshg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BYAPR03MB4646.namprd03.prod.outlook.com (2603:10b6:a03:133::26)
 by DM6PR03MB5211.namprd03.prod.outlook.com (2603:10b6:5:24a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.27; Wed, 28 May
 2025 11:11:23 +0000
Received: from BYAPR03MB4646.namprd03.prod.outlook.com
 ([fe80::8919:e2df:10df:51ce]) by BYAPR03MB4646.namprd03.prod.outlook.com
 ([fe80::8919:e2df:10df:51ce%4]) with mapi id 15.20.8769.022; Wed, 28 May 2025
 11:11:23 +0000
Message-ID: <459a6e3d-040e-4130-b643-c822f4008daf@altera.com>
Date: Wed, 28 May 2025 16:41:15 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] Create FPGA Partial Reconfiguration (fpga pr)
 command
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Michal Simek <michal.simek@amd.com>, Tom Rini <trini@konsulko.com>
References: <20250524203737.20541-1-nareshkumar.ravulapalli@altera.com>
 <CAFLszTjiRpYaG=Hx2fo5gGowpfkww1t4=W7iaEpgbU3OgWKbuQ@mail.gmail.com>
Content-Language: en-US
From: "Ravulapalli, Naresh Kumar" <nareshkumar.ravulapalli@altera.com>
In-Reply-To: <CAFLszTjiRpYaG=Hx2fo5gGowpfkww1t4=W7iaEpgbU3OgWKbuQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0105.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:276::8) To BYAPR03MB4646.namprd03.prod.outlook.com
 (2603:10b6:a03:133::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB4646:EE_|DM6PR03MB5211:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b6592f8-a24f-41e3-2b82-08dd9dd86159
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NlpvbjFZREtMTGtUbnkvS0E2ZHo0WGxMTWdlalZtU2cxR2NsTWpQWEo3UnMw?=
 =?utf-8?B?d0ZKWUFWZzVnTHRtOEl5Q09GOUhLcW1Jc2pYbURQTXo0QmNRUHEzSVd2SVZN?=
 =?utf-8?B?U1JNZEhwTnlEcUZvWXMyNUhsRXJPSTd1Q2l6OVVLKzBSaGM2R0hkeHFGd0R3?=
 =?utf-8?B?Y2FtU2lCYVp1Nk9vWWd4cFphUFRtb3Blb1dHanRaelpGTjNKcUtTYVlIUFRk?=
 =?utf-8?B?UjMyVUdSM241cDJZWktXUDFQb0g2K1YzemI3ZExGSmFKU0FJS2VGUGRQTjNr?=
 =?utf-8?B?N0RLSFkwaGxxdW5aMy9FS09YUWRFczV6MjhIMEZWSzNpWm03Mk1GOFI0V1BX?=
 =?utf-8?B?V25JQURaN3cvKzJDZ05lYXBLVXNRaGVwK09GQlhLTjh6OXpKY2cwczF1ME1i?=
 =?utf-8?B?THJTWUp0akhpTHRUa0JMbnZzQTFUeDl1S2tjWTFUaVBQbTVVNnpwcGpqTnVo?=
 =?utf-8?B?ZFZGQkMrbXZaNWdYZ09wN2FIYzhoUlNFVjdLdjNuaDVUYlNjUHF2LzBNTkJK?=
 =?utf-8?B?TFQ1Z3F1VTJwMkY3SXQxQTRUSVZ4RUNBOWtPT1Z6K3JBS0Z4Y3RwaWhMQ3FH?=
 =?utf-8?B?QnVjTHNQc2h6NDVpWWE1VnZnNWFCMmRFemVYSS9wNnVlVjROTUFaenpXRWRq?=
 =?utf-8?B?VktlVTFMWDVra3RKTXAzTzgwQ3FjMHo5cUJtdndPbTZWVzlXQVpwb1MyamdZ?=
 =?utf-8?B?dkFDK082dGpnS2o4d3QzMHZ4YUdUZlEzQ1czZVl0Ni9lZ2dpTGRWdndxNDZT?=
 =?utf-8?B?U0xMZklGOENjQWRYZHRaMEpBa3pMSW9lcGlZQ3AwYmV6MUcrZWYzRHYwUERx?=
 =?utf-8?B?eUozellQV3d1WEk0dVp3SzRnVXJxblRZaXdSMnluamh5R0dCYXQyYXNqN3BC?=
 =?utf-8?B?eWxQbXJBVFVreFhhZXJwWWRNNlBoNVhuR3FPMjdEaE40NU5EYlppTW8wNzQx?=
 =?utf-8?B?Rk9hZjFPTlIydUlMUjN2WkRURWs5MFhKSEFBUFB1c3NYNnRFUnZySE9lT0hH?=
 =?utf-8?B?dHBCTG5ZZ0pyeWJYNTQyQzUyTEx0WjZIeDU3V0JRMCtzbjd4ajVUWHhjYS9H?=
 =?utf-8?B?Z1lSZWY4VVloRTRsRXVRZmNDVHVBclVrcnp2RllsRnBNc3dwTmJGYXpBb2x2?=
 =?utf-8?B?RXFSUTJUNGd5V2J5RWRiN2hhMHQwSXZhRHZqcUNpVUg3Sm1yZ29HVURGUDV1?=
 =?utf-8?B?cEh2Umo5R25zMzhwSWVKS0NDNGx1c0laS2RDbW42OXZscnBIbE1DU21qa0lq?=
 =?utf-8?B?cWY1RVBqdERydTNMOTlXbEk2S2dIblhWVkMxVVNhZ2VyOTlWMWlSM095WlVk?=
 =?utf-8?B?OE9zcDhaN3BYRUkzZG53VnN6VkttZXVOKzhpWnByRVRZSmk2YTVXMStiVkE4?=
 =?utf-8?B?MW8xV3c4TjZzYzJiVERGVUZ1b0JWOTh3dnlMRWkzTzYxOU1LNlRHYWJEc1Zz?=
 =?utf-8?B?WUxHWlplZFMxTXNxdUk3MzBMZHNoSlNGTTRMdVJBUGpYb0JFclp1TWErYnBK?=
 =?utf-8?B?TnM1RUxWd1EyMWFGS05mRVRBUlJvdFpEM2YvVEp4WHNvNlJPNWhiSy9UdFNo?=
 =?utf-8?B?amZQam9WL3J1bGVLd0dPMzlvL0ZMakFvZkhWQ1RJY1AvTmYxWkl1NzNQdWJi?=
 =?utf-8?B?SEVKQVRoRGZJSklhOWVxVENQeHVCUnMrVzN2UUp3clRVRm5yd1NsQVpMRjBz?=
 =?utf-8?B?clJ3Sm5UbTJlalNBdTVCbFRPQUpyMHlETnlXbVp2MFQzSTM1RVJmVzJQeEph?=
 =?utf-8?B?REFteUhLcmIwQStjZlhyeFFEajFQV0xpenlCUWhlUDRva3lZZ3poeVRnazFw?=
 =?utf-8?B?UUtVamVBTk03QVY3TktpS0g4dndJQWJZOFI5MXBDbnZVRmoyMjBrOG0xbWVV?=
 =?utf-8?B?QjNqeXJ6dTE2a1lIQVIwZWRFRTUvZVIrd3BpcCtTbmtoVDMyb0lsNXB3OFpJ?=
 =?utf-8?Q?oQRES3TB69Y=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR03MB4646.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NTkydXI4VHUyd29UYmtMRHorRDBXSFhDWDk1RlhYWW90NWlKbXBRcHBucEhV?=
 =?utf-8?B?Z0hyRDNjMlcvdm5oNTlYRmhTVUEyZjJyc3hKRTQvSlR4b0FMNy8zL0JvMjli?=
 =?utf-8?B?RVI0cXZUMTF5OHhHcU82SmsrM2k4UUtMeThIV0ZNNkhlMG9aOFFXZkhmSW04?=
 =?utf-8?B?RGtnVWI3YklaRm9MQ0ZYd1ZuN2ZEV2dydCs0TDRMaG9EQ052UDhsU2FRSzNN?=
 =?utf-8?B?TkNsUGhaN1gvdzNnbW1XNC9Ca1c4TFBHUWNQNml1aHVPdDhNOGVZVWNxbHBt?=
 =?utf-8?B?cEc4Z1lwRlIzS2daZ1p4SzFibHFBWnVoYmVZZkxvcEFoQ0ZZZFhsZ0pXVGVi?=
 =?utf-8?B?VDdidER5emhwTU5acFQ0Q2x5TXBmZXEvdFZkNjgxWGU2NjBKMXk5WS9nZ2VT?=
 =?utf-8?B?U3pXbVRkQUNPWnFwR0poaVdiK2VQOG1wbmwzU2hHTE1IWWZ5RlJxYnFENVQ5?=
 =?utf-8?B?c25pbkEyQkNlbVR1eDFFTVF4RHlCS01OMndrT2Q0bnFYc1ZBdDNHN0hHcWtP?=
 =?utf-8?B?b1VoQjVOa0VLQnplUFZVbEJUOTVkM3pwR3VBL3BiMU5KUXpJQjdFNnJpM3Rp?=
 =?utf-8?B?Q0ZWait1V2Q2U0JZU05TT2o4blR6NEplTXBBemZjRWt0aGNEVTJBazI3TWdE?=
 =?utf-8?B?eklhTTJOK3RQL1EyMlFFSDMyMnVsWFFTR2VMdFNySmpMeDQ1NkJvdCtxVXNT?=
 =?utf-8?B?YU51Mi85Zm9LVzBFVkVFOUVVdXh5d3NtakUwRzI3L1duWXZuODl3UVFmejNK?=
 =?utf-8?B?Uk9MVlZ6Zjh1YlpvMUVyRVRvOFVROU5qUkN6dlB6eGZZTlN1MEJzTGJvME5q?=
 =?utf-8?B?bFFVSFdaMzB2MEppeTVhYlQycmVpSXVtWkE5OEhTQm5UQTBTK25oNkxxelN2?=
 =?utf-8?B?Q0tXZzMreGN1bzBiNE1BWlFlSjZDM1dQS2FSbks1Vkp5elc0QXl2K1p0T3Ry?=
 =?utf-8?B?MGkrNU8vRFMyd3U5VnVkZFBWUXY3cDlzZjBHa1JHWjB2c2JDckd6VVJzaDJh?=
 =?utf-8?B?UWx1ZU9VTnFkcEd5dEZzY3UvREYwZ0NIbVlIMmkxYU5LQ2I5aEJrWVRya0J5?=
 =?utf-8?B?Z0hsWE5SQ2V3NlhuQ082VmNvREJubGJJekxYbHU5Z3llcTVhemQ2YjEyTjM1?=
 =?utf-8?B?T2tjS1J5d3lnNEZBYmtUNzRTejRZaDNQSS9qVEF0dTU1MFQ1aHZXQWxXbU9u?=
 =?utf-8?B?NVlYb0NPUkN0c3JPQUsyR2lSdGw5TWlKTFJmNTQ5eXJaOEVPb1ZJYlNvNXhy?=
 =?utf-8?B?bjhTdnplcFlqZDRsdko5ZEdGUnN5WTIyMVg2dEsycngwejdSRkUrZUVjTE9a?=
 =?utf-8?B?bkE4bFQwNGd5bG5vVCtlYzd0NkR1QlpVZFdHMFROa3dSSzZ4M3JHOWF6N3Zz?=
 =?utf-8?B?ZUJNZzNXaUJUa24xTUx6R2s1VHNhaS9vMjFoa1c5TmE5K0tNN2ZBaHFwRHpU?=
 =?utf-8?B?ZFo4VnYwZ3BpemFBYWEyR1plZzRGYTI0dFNNVy9KN1RFdU02SHRGTHlBZXJo?=
 =?utf-8?B?QnAvTkJyWHRkN1dGb3BvbmpKQzVBKy85cGQvTXlCRmtiZlE3Z2RMV0grSWdN?=
 =?utf-8?B?cU9NbEhYdVA4WW1IQXc5NnJDYXp6U3hNQ2I4cDRRaENqZ0E4MjQrMDRXcnMy?=
 =?utf-8?B?QUszODI4NU5weGxzbzB4N216TzdqK3JYWGM0RHFadzhRRUd3QVRHNnNaSERx?=
 =?utf-8?B?ZktHNndMcHJELytRUVdMbUVidGpYaGdtbzBTQjNWMEpFNi9DUmRBM3h5Zi9L?=
 =?utf-8?B?SmFsbTRsVTNtQ2ZqVjBHL2doUlRrZWV1WFViNzE1a2ttRUJjSHdVb1ZMdFA4?=
 =?utf-8?B?NjJQSEtKU2RjVVJUMCsxL3R0aWZhSlRaci9JZGFSVFVzbHpIU3ZqNmxrUFl4?=
 =?utf-8?B?WTluSHYvNTF5d0pGdjd4RUdQVUNGK2ZFZWpuMmhwOFNBTEdTM1ZzcHM3WWNZ?=
 =?utf-8?B?elBnQ2pGRmZyZUl4OWlsVWtrckpRZDNabHNlNFNxcUhjeHF4T0tVYVd5ZkpX?=
 =?utf-8?B?MVR4b3UrMlpkTkp4emRvTy8vYVFTN1FtSTJRYWE3VVVQUEN0MXo5ZHJIdHFz?=
 =?utf-8?B?SGpsYmJhSHBrbE1LeWR5aUF6Z1JxWVdubHJKVTd2c25sWWdCSzVJZmtMMWVu?=
 =?utf-8?B?Wk0wUWQzUEVvSU9Ld25VWmE0NWtvLzNhWXg2blF1dktFZXU2TXozVEwyUFUx?=
 =?utf-8?Q?CWF8LvFT18I8yW2U89O3t4g=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b6592f8-a24f-41e3-2b82-08dd9dd86159
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB4646.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 11:11:23.2357 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CGREi4ERPRmCUQLS/DbEjzLPMa8hnrujFEdMSONiQpUxdOnrGV2eWQz3QBzdDk5gdIH+0Y8N1oasnUDEE13GnEOALF1X+ZzAyl6xvnnlNl8E/BcPuBSShHTahmUyIFxu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5211
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

Hi Simon

On 25-May-25 11:35 PM, Simon Glass wrote:

> Hi Naresh,
> 
> On Sat, 24 May 2025 at 21:37, Naresh Kumar Ravulapalli
> <nareshkumar.ravulapalli@altera.com> wrote:
>>
>> Partial Reconfiguration (pr) FPGA command is added to U-Boot console.
>> The "fpga pr" command supports multiple regions for partial
>> reconfiguration by specifying the region number. The implementation
>> of the command is specific to the underlying FPGA device.
>>
>> In case of Altera, it is used to freeze the specified partial
>> reconfiguration region, then user loading the reconfiguration image
>> followed by unfreezing of the region.
>>
>> Test set currently can't be added as the command is implementation
>> specific. It involves opening of FPGA bridges and loading of external
>> images during run time. Currently, existing FPGA commands don't
>> have any tests/sandbox environment. The design is being worked on,
>> but would take some more time to share and get the community
>> feedback.
>>
>> Changes in v2:
>> - Change the command implementation to generic FPGA command
>> - Add usage documentation for the command
>> - Correct "_" with "-" in alias name in Altera dts files
>> - Add FPGA partial reconfiguration support for Altera devices
>> - Address minor comments in v1
>>
>> Naresh Kumar Ravulapalli (5):
>>    drivers: fpga: Add generic partial reconfiguration support
>>    cmd: Add partial reconfiguration command
>>    doc: usage: cmd: Add documentation for fpga pr command
>>    arch: arm: dts: Correct alias name for Altera SoCs
>>    drivers: fpga: Add partial reconfig support for Altera SoCs
>>
>>   .../arm/dts/socfpga_agilex5_socdk-u-boot.dtsi |   2 +-
>>   arch/arm/dts/socfpga_agilex_socdk-u-boot.dtsi |   3 +-
>>   .../dts/socfpga_stratix10_socdk-u-boot.dtsi   |   3 +-
>>   cmd/Kconfig                                   |   8 +
>>   cmd/fpga.c                                    |  38 ++++
>>   doc/usage/cmd/fpga.rst                        |  65 +++++++
>>   drivers/fpga/Kconfig                          |   7 +
>>   drivers/fpga/altera.c                         | 163 ++++++++++++++++++
>>   drivers/fpga/fpga.c                           |  37 ++++
>>   include/altera.h                              |   7 +
>>   include/fpga.h                                |   3 +
>>   11 files changed, 333 insertions(+), 3 deletions(-)
>>   create mode 100644 doc/usage/cmd/fpga.rst
>>
>> --
>> 2.35.3
>>
> 
> How about creating a uclass for FPGA, with an API? I think it would
> help to make things more uniform.

Yes, I agree. While going through the existing FPGA commands, I also
feel we need to refactor them for uniformity. But this patch series is 
about adding a command with existing framework, I would like to keep 
both tasks isolated.

I will push the refactoring work as a separate patch series.

Kind Regards
Naresh

