Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99BB4CD4F4A
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 14:53:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 687FE846CC;
	Mon, 18 May 2026 16:52:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=outlook.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=OUTLOOK.FR header.i=@OUTLOOK.FR header.b="vKNQrRn2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 748B08469D; Mon, 18 May 2026 16:39:37 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazolkn190100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d200::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 477BE83EF9
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 16:39:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.fr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fberder@outlook.fr
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RJ+Lhal8PElEuxhPFe4Qw5fr/x4zwtaS/z1SgxCXDFrgw2Z6URDZxDw9U8t/lcIwPbVxIIsPHK7SR8Xtojru62YnNs+vb5UNFw74tTCigksgo15L87dvIGHIeDGAwanPfVH8A7pre8E+V0XhX+Y1GGeaVJmRBlgH+9PeKa783WmVimg3HXnDcR1Rcldj2EhUBfY+dxS7i/AekJK3sU6R6Lc3TQgB564vaD31ageXUBvEuyww5thAthNbVD3upFLIaqVMste9VizpkMqMubjKkg6LhE2myxhIVX8iysTu4pq/x98hWAuAi4dXE8ZrQFM3XJm4T+UapxeqHu9rFajlsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NX3YLw9pqNo0m8dw4IShV2jmFBUJ0lhpyqWExIh13FE=;
 b=sa1nE997CDIi85/S3lW1xYNMHxGdD55WlbMM3ziog7taNU0XRMjL882vNEZqjk0sZNZO7d3xsf+Rzuiu+VNfMa8pgjrGetqz2KxZnPIxB9MgbFRde98HXQkNXpLQwV03cLj7MTi0IxRT8I/orNauzCoVYvwUcMrmIKwr12AO+rOTUk4A+XuqwcTKeFC1Sud0g0qEj9XcoqCmIzbe7usG7zvxCDsmbvnnU0l0JxR3eO1Xg8I/Xu7/BvXmaEqYJSO2FMiN16XFxHfJ4ZTM8MRIsheXPZBMgEp1SAfVR+m+oIxaunAzg7xNVXlTIsPzDDnGJfwE/V8ZHFlmUqft4HOycg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.FR;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NX3YLw9pqNo0m8dw4IShV2jmFBUJ0lhpyqWExIh13FE=;
 b=vKNQrRn2/QY7YLQ8ug9BY9m048dE0V23+v9q9/apn7xEi7p4+hgA4fHfBPfWdJ1lw7WI8PBwjpfb1zYFDiDHIEIXCQYT6sf5m56HWeeHiKNVMDImEoWIJZtXRh2bD7pjao1IDFjQdun1Hy4yiEvuRqNXA+VJmEv81h25AcvfMSUKcACwYVuqoAgaqim6lfrM9qQtPM9ZAfD2Ujq5xMa/ne3y1dEOnqYnXOOiLNClqvp2pDfx24akR77FlqBboke2X8XfkFoKg+LamJcOIdU2+skLvKiU10DdThJQwNVgqMDCNCaHqXK03XSJsDXiFaXYlUoM4XK/aaXXokV5An3EZA==
Received: from BESP194MB2805.EURP194.PROD.OUTLOOK.COM (2603:10a6:b10:e8::5) by
 PA3P194MB2857.EURP194.PROD.OUTLOOK.COM (2603:10a6:102:4b7::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.23; Mon, 18 May 2026 14:39:29 +0000
Received: from BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 ([fe80::5ae3:1158:9ce8:90]) by BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 ([fe80::5ae3:1158:9ce8:90%3]) with mapi id 15.21.0025.022; Mon, 18 May 2026
 14:39:29 +0000
Message-ID: <BESP194MB28056BB07D2C25BD5409444DDA032@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
Date: Mon, 18 May 2026 16:39:27 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
From: Francois Berder <fberder@outlook.fr>
Subject: [PATCH v2] boot: cedit: Check ofnode_read_prop return value
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR1P264CA0180.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:344::9) To BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:b10:e8::5)
X-Microsoft-Original-Message-ID: <497b5851-2426-4c66-8885-5529dadda2f0@outlook.fr>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BESP194MB2805:EE_|PA3P194MB2857:EE_
X-MS-Office365-Filtering-Correlation-Id: 629e202c-1dc5-44eb-7130-08deb4eb448b
X-MS-Exchange-SLBlob-MailProps: 5fu/r660v9MuQ6DTCgtH6GhpDR/2/wDC6zpCiOwmSHgXXDPNEm8M0bOaTilQjbOW0TMmlNr1Tvjkh3PUK1T6GlQkhbhU7WHdsdkjpW/p9QoM35sEfJn7QNX07r+SqIyDvbJ+jZSHKhuRwC0Ajf6vBBXaGNWavqwlW1zxoB6ytaX/uneuHYFt84KX2hMOGjTas0P5WeUGQfFGmnOGttI5jRAHSTmXQCvL4DReKsdPEMfd584vtpNoNlCbWhSdYmYyJlYaKitvq6T3nl3UvH9/587TcekHOdEkYdnklsPB6yQA8M4ecvKOdMJhWcdgK2JMRTzflK7uBlr4DJxouvwQC7x0zmYtaEAmLVMxRvRE2LS+DDpChs8iYJMhIU3ftakMGxJNzSyi+1UL14PxM7q0GYcDyZeaBBvIuuFMm8XqG6lHkW9DPE6mx+pfHKPz8vgRnYnRg+DRAesorcDNF4mMo+LXZEQBLHvY+u/kY7e7F55iv+CPRZyNzZHTyuj7qJc/bLmfBPC2wJndYATzwm47L6N7DZq8BlaM/rDr0JsnrrbPs2vYKHJGrJgjlVjrGhJHL61upaRh31jR7MwtAbi+Ce3OWGj8qGBBptYwpr5K164cDgK+dIm27rgN3Sle8ATCalE1jnBmh/B3791zyD2X+81Fh8epbVQNFhKNOSpUkkaecqN+Qrr3nza+8lTMOEtRMTYYYW+oKKYbBLcIReMjGRkUp43Q/MdMPvT3W1Z1avg=
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|12121999013|23021999003|8060799015|19110799012|15080799012|51005399006|55001999006|24021099003|6090799003|37011999003|5062599005|41001999006|5072599009|440099028|3412199025|40105399003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q3N2WHNXR2hNRE1TQTNILzMxT2xGKzJTY2c2enA5aE5ILzZxZXNoWWdpR0J5?=
 =?utf-8?B?R2w1Q3MrcGdEV3lSUjFCekFQYmNmelY1QXh5d1BwZUc2dVUvV0dNaEJkQUYz?=
 =?utf-8?B?MkNPRldXaDlsT1RHS1dqWGh6NTYwTEE3TUNzK0FVT2NHamZBZHpxUXFwdFQw?=
 =?utf-8?B?NGtLUG9CRFJJV3RtVm5RNnZjbHhpaWEwZVd0ZzBZMCtJWHVrdDU5VWcyTUF3?=
 =?utf-8?B?ZUxyOXFQY0FZdUkvdktEOE1QR1R1aDlMQzBqUk8vYVZsOW9RYzJQL0pmRVJ6?=
 =?utf-8?B?bW1WR0JraWk3eHhRRGFyYUY0b014dVQySXYzbzNSZGh4Y3NCUjJ4L2pNQXRj?=
 =?utf-8?B?OHU3djNoT2t5dURKa1U0YUZ3NXM5T1Bsald1MU5rellGVkFiZS9JMEJSU253?=
 =?utf-8?B?WWpSZ2hIcE1XbnczbmlBL1NJRldQdnZEVzdvVWNEUStvWlVCOFVtcnJyMkpQ?=
 =?utf-8?B?dGJ1LzhSQ242YkMvVEdSMi9DcDBSSDUzZE84ZERHaE1KK1VlQy9hQ3pTWmVi?=
 =?utf-8?B?MFdPajNFVDZoTVFtdStUeFFrYXRYdmxsL2piN1BmWU91d1UraGRZOGlvbTh2?=
 =?utf-8?B?STQ1RFpMOXdSZnZDUTV0ZlJaT3RERUJXb1hQWmdMV3FwajhvK3BmR2VDZTI4?=
 =?utf-8?B?Qm9wN3RzY1NTdWtyUGZzSXBMTlFSSzk0T3cwL3pTS2ZnWXdQbWN5RjZUcEN4?=
 =?utf-8?B?TW1Jd0svWEFxamFOQnN3bmpGQTZYLzVvU3FINUhRT05iL0JlYnZDT3FjM2F6?=
 =?utf-8?B?UEZ4dXYvbE9VTnE0NGFLRVVLVmdvM0lWMHU4WFJWT1FvTkF3LzR4bnAybmQr?=
 =?utf-8?B?NHJXdlpPUEZwK2hqNGs1OGVJMnVaTDQvNzBKUUdXY05IR3h4NFhCY0czY0Ji?=
 =?utf-8?B?TzMyOWt6U29wQlVTVVR6L3pWaThVOG9HVVNDb0ZJMys4WCs4Qmgrc1crRXBz?=
 =?utf-8?B?Ri8veEFRaWNkNWVqWGxLNTYwMnNkbTdkVTdMV2V3cG5VWEJSVUdZN1JrdzY0?=
 =?utf-8?B?QjUydWMrMU1rTlpValN4SytPb3FUdURKL09qN0JWYXhnWHBpcisrOWVmcjhi?=
 =?utf-8?B?WUZLZ0dPeWYyZmJYbEUvMEtIWEF4U3FFeVNoNWlEVmFKdjRqSGpuQnRRMzYz?=
 =?utf-8?B?NFljUVUyTFpnWEVjMjQvNUp0SjJ2NmtUSWdIYkdHaVJOK0M2UmZ4ZERXZGJ4?=
 =?utf-8?B?TlJSMUEwWVI0YkZYVVl6dE5iMVJIRnZGaHJlVEVBN1l1Y1BYbGRnUkhGRUc2?=
 =?utf-8?B?UEdJUktSZTloejh5eXNPZzBDRXRKNEtmS05jcy9yTmlDSkxUVTBlcnJDRTdY?=
 =?utf-8?B?WGpIUmszd21wdnNBSGtIQXQxOVhVREd3M3NYK3lRaU40ZGVpSW1jb2hDTnlC?=
 =?utf-8?B?UTdMdTBFQitRMldXemRYeVRyR21vR1BUWFQrcnNtVE1vc2tzSHBVYzJFQW1k?=
 =?utf-8?B?dmFHaENqejdxNG1ZaElUVG8yZ1lzZ1VVaVkyV2htVFNkUE9qUXdWV2VUdHBt?=
 =?utf-8?Q?rHYX56Jej9ms7y3BOsEvB/+fygP?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?REdEMDVZaGZnb1Fkd0hqOXQzSU5hWHdFL2F1VXNDUmQyOWJtWlQ4SnNnckI1?=
 =?utf-8?B?WGJuM3Fld21EZ252bnRZekwvWVhJckRnakFtbE5iemt3M2gvNTFuT3pERlF5?=
 =?utf-8?B?WXVWMGpnOURtVnFqNXFzdVJSU2M1ajRMU1pwQ3FHYU9KbVVpTWIzUUdxWXVT?=
 =?utf-8?B?dm5TTk9LNXpHemF4TXFYTWpZRmhLTmZHcC9EWmZhVjJHeTJybzRQY1ZSV0cv?=
 =?utf-8?B?TGlIdnRmaUpsNUNHVHBjbzZORlF4ejdmODA5TUg1QXh2ZmZQK2NMK3FLT1Fz?=
 =?utf-8?B?RkYrNTQxYVhCYytZVDdiVUxVb1BmQnhVV3pDT0dVcWsySWdEUGxMRWl2azRx?=
 =?utf-8?B?TEpmVy8wQkpSTVNadSsxZ1pZL01Wd3FLdjhSeTZKYk8zQ05SWW5iWGtHV2Fz?=
 =?utf-8?B?K0FITTBrNTIzZFI2U3QxZnhFOXgyOVk1QllsMmxwenhlWnhjKzcvQ1A2TFMy?=
 =?utf-8?B?MUI5eEZ0b21IUTk4YVRDbFBRRVZSTjRvOWtKT2FTOU9yQVF3TkQ4aW1Ydng0?=
 =?utf-8?B?MUR5K1JSRWx3NlVtOCtKU2lZWVEvaFdWQzRRUE1jb3dOS2dLUW56MDQ5bnBS?=
 =?utf-8?B?YTRkZ3JqTnBzS1k5UGxEUDJXMDllUlJwUTAyQVltUTVJTEZLanZLQVBiSGYy?=
 =?utf-8?B?UjlwOGREdFBTR1FuMFd6STFQdHA1VVZJM2x1UEJTcUpwT2VubG9vRmtTTTE0?=
 =?utf-8?B?cDlmWU9WOFBBV2I4VlpMY0FrdGNPWkhid2ZoZ3MxbnBDQVhTeFN4VnNsVFpi?=
 =?utf-8?B?VVkzL1h1dm53bWRLaVhiVUxLWjZjNTl0akkxVlNlZ2NtMXpoYnEvTkllazFs?=
 =?utf-8?B?UFZIK3ZuOHJPcmx6L0p3M1MraDZTamJNenhtUVlWTDRVakVYMU80NS85RENl?=
 =?utf-8?B?M1lvb2s4NFVaOCtoN2VLcWY3N0NaV0kxWVY3NXhhV1FoTDQ1UTV6ZDZuZ2pz?=
 =?utf-8?B?VzVSMkNBaDNnSmJLd3YwRDRZVkxCcVEyZWJuWExjbkhUbVh3L3NvZWNPZmVa?=
 =?utf-8?B?Uzd1aDVtK1E1cHpBSnJSMHdGREUzQXpwQWZqcGRJR2tWNEFKcWNBRnZ0ZVRq?=
 =?utf-8?B?TVJyZk5ra3NwMTBRdDI5Tm9hb005cCsveklTTDNtVHhvOGR0MGJHMVRiYUo4?=
 =?utf-8?B?Q2VFRFNVTWJuSGUxS3hxbEpJK2wxZzlONnlvQ21URkRVbHo3V2xQQXJDc1c2?=
 =?utf-8?B?TlJQQ0hrV3o5ckZpK04raUNZOVNrVk5pdHlMQ1pxdUVOVDYzN1k0dEx4eUd5?=
 =?utf-8?B?bVdHbTdtVHF1T3pHbzFNemVVZ2lNNWNPVENnRGZCN2RTWXYydlVLbnNzQzBF?=
 =?utf-8?B?bW1Ydm81NmJFdldEa1ZrR20vYWw3MW5MZDFCYmxDUjRzV3JHeVFCR2VXeTVj?=
 =?utf-8?B?cjY4VnRaeUNaTlBuODhQQlJ3dEJyZGhxY245aXpHdS9tOEExRjN3cjJoVUw3?=
 =?utf-8?B?TmxFR2V3TlFqYWY2MHlnOEhWcE1yTXN6ODdwcEJrWlVIRkFpb3FIYjhoT21t?=
 =?utf-8?B?ck1Nclh6WWkzRnVJaldCL1ZPR2E5eTJOeHhUYWU2UEc2QUpRK0hXdUk2UWFT?=
 =?utf-8?B?VG9CMDVVM21MVEhyNkVkMlpRYUJCNGZDZy9FSm1TNG9xdVZPdzRxaUZXaGw4?=
 =?utf-8?B?MmM1cU5QaUdOYUR0TnF4WFNBYTFTRTR1UlNUaWZmTUpScTdOTGw5ZHhqcmFk?=
 =?utf-8?B?ZEtGbnFpbjRVS0JBUGlUdXFjcC9nUlFlVVc2cGRLLzRWVEQ0QVZxOWVHV0hM?=
 =?utf-8?B?UllZeFV1YTlhMVRRRXhsQ3daeWFPUm1xM2licm1VYlJ0dEVUZFV6S2hTakk3?=
 =?utf-8?B?NW1IREdRZDJnVzBYVG5WdWk3QVFpbEJkMkZ5eWQvYkl0TWNLRTZzcDEvQ1N4?=
 =?utf-8?Q?sQUzyNlWE7mnP?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-3927c.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 629e202c-1dc5-44eb-7130-08deb4eb448b
X-MS-Exchange-CrossTenant-AuthSource: BESP194MB2805.EURP194.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 14:39:29.5602 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3P194MB2857
X-Mailman-Approved-At: Mon, 18 May 2026 16:52:44 +0200
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

In h_read_settings, val variable could be NULL due to
ofnode_read_prop returning an error. This variable
would then be used as the src in strcpy.

Add a NULL check after calling ofnode_read_prop.

Signed-off-by: Francois Berder <fberder@outlook.fr>
---
 boot/cedit.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/boot/cedit.c b/boot/cedit.c
index 56dc7c6af15..b1b79d1752a 100644
--- a/boot/cedit.c
+++ b/boot/cedit.c
@@ -500,6 +500,8 @@ static int h_read_settings(struct scene_obj *obj, void *vpriv)
 		tline = (struct scene_obj_textline *)obj;
 
 		val = ofnode_read_prop(node, obj->name, &len);
+		if (!val)
+			return log_msg_ret("tline", -ENOENT);
 		if (len >= tline->max_chars)
 			return log_msg_ret("str", -ENOSPC);
 		strcpy(abuf_data(&tline->buf), val);
-- 
2.43.0
