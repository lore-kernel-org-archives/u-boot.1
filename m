Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A424CC25B76
	for <u-boot@archiver.kernel.org>; Wed,  5 Jun 2024 15:19:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB24786DBD;
	Wed,  5 Jun 2024 17:19:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=collins.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collins.com header.i=@collins.com header.b="J9JfFgc8";
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=rtxusers.onmicrosoft.us header.i=@rtxusers.onmicrosoft.us header.b="hqTTktSZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54ADD86F6E; Wed,  5 Jun 2024 17:19:20 +0200 (CEST)
Received: from mx0a-00105401.pphosted.com (mx0a-00105401.pphosted.com
 [67.231.144.184])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45AFD866F6
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 17:19:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=collins.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Brandon.Maier@collins.com
Received: from pps.filterd (m0346908.ppops.net [127.0.0.1])
 by mx0a-00105401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 455ECQAx010192; Wed, 5 Jun 2024 15:19:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=collins.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=POD051818;
 bh=fMVhNKfOlgJpAVIVWjyxXva7gZdLhXyvX20gx1eHwBo=;
 b=J9JfFgc88XY+ETCOVRnLgmI5cYdKt6p3nyFHgaEqT8btsrxrGeJzjkYyw/HxEXeEiydZ
 EU3XiMSQwUeHMVH4X2/AGtuIv96SKyNAp3v3uEDzPZdXSa/Mq5nwj87DzaAfo0cKusTv
 5NxlkuzU/cgFEYcPvxmXYM2r2IIE0RPAPPzrVU5EO5cbSJjREQdbjHaUFREBXXaHU5l5
 2dWlgmeh7AFvzJZovx2bW6JG7BTINlwxjDn+OzdxjgcgMB/XtNFycdiJsS0WHzm61drF
 MeS9jgA7OtPwtA7f4roU5ZfcNFXIkj3LvEWudHRmiseuDVCdUrA4GHx34GwhBqPo1vgR kQ== 
Received: from xusxph009rp040.rtx.com (xusxph009rp040.rtx.com [128.13.125.146])
 by mx0a-00105401.pphosted.com (PPS) with ESMTPS id 3yjsk1gvjm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 05 Jun 2024 15:19:14 +0000
Received: from xusxph009rp010.corp.ray.com ([128.13.125.224])
 by xusxph009rp040.rtx.com (8.17.1.19/8.17.1.19) with ESMTPS id 455FJCH2003074
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 5 Jun 2024 15:19:12 GMT
Received: from UUSALE2E.utcmail.com (uusale2e.utcmail.com [10.220.63.40])
 by xusxph009rp010.corp.ray.com (8.17.1.19/8.17.1.19) with ESMTPS id
 455FInh7029588
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 5 Jun 2024 15:19:12 GMT
Received: from UUSALE29.utcmail.com (10.220.63.19) by UUSALE2E.utcmail.com
 (10.220.63.40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 5 Jun 2024
 11:19:01 -0400
Received: from UUSALE28.utcmail.com (10.220.63.22) by UUSALE29.utcmail.com
 (10.220.63.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 5 Jun 2024
 11:19:01 -0400
Received: from USG02-BN3-obe.outbound.protection.office365.us (23.103.199.146)
 by UUSALE28.utcmail.com (10.220.63.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4
 via Frontend Transport; Wed, 5 Jun 2024 11:19:00 -0400
Received: from BN0P110MB1673.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:184::20)
 by BN0P110MB1545.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:184::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31; Wed, 5 Jun
 2024 15:18:59 +0000
Received: from BN0P110MB1673.NAMP110.PROD.OUTLOOK.COM
 ([fe80::c67e:811a:963d:4a42]) by BN0P110MB1673.NAMP110.PROD.OUTLOOK.COM
 ([fe80::c67e:811a:963d:4a42%7]) with mapi id 15.20.7633.021; Wed, 5 Jun 2024
 15:18:59 +0000
From: "Maier, Brandon L                            Collins"
 <Brandon.Maier@collins.com>
To: Simon Glass <sjg@chromium.org>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: RE: [External] Re: [PATCH 2/3] tools: binman: fix deprecated Python
 ConfigParser methods
Thread-Topic: [External] Re: [PATCH 2/3] tools: binman: fix deprecated Python
 ConfigParser methods
Thread-Index: AQHatpqKmxe8gSZe2UeuB/mt+C3rWLG4bsEAgADaTuA=
Date: Wed, 5 Jun 2024 15:18:59 +0000
Message-ID: <BN0P110MB167322053D93D4F977CF9061EBF9A@BN0P110MB1673.NAMP110.PROD.OUTLOOK.COM>
References: <20240604161607.1133032-1-brandon.maier@collins.com>
 <20240604161607.1133032-2-brandon.maier@collins.com>
 <CAFLszTi1G44DPY8rMH_+sPkmSOfotxGSEJM=ec64VQzCr2==Bg@mail.gmail.com>
In-Reply-To: <CAFLszTi1G44DPY8rMH_+sPkmSOfotxGSEJM=ec64VQzCr2==Bg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0P110MB1673:EE_|BN0P110MB1545:EE_
x-ms-office365-filtering-correlation-id: 786c432e-f53e-4ebf-5296-08dc8572d357
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?dmZPcXo5WEhBRW13UUdIeUJ6dGNsNTFwVmVnd2pVUDZrN2huaHQ0VVV5NmtX?=
 =?utf-8?B?ODFqalJ3dGJiQ0RLR3k3L2FQMWFjVlV4bUs1Um45OXhrZXJETnhySk1IcWFj?=
 =?utf-8?B?Q3F5SjJDaGVuaDlGQ3QxUjhtQ0FtU2JSV3l2OHFPbUxKRERwcmhhVjlLL21J?=
 =?utf-8?B?K2QwUlhHZXAvbXhNN1ZVZy9Cak44MHNXQ3I2VVR4MXVQSlhHdm9YVFhsZ1lo?=
 =?utf-8?B?c1V4bWZZNVJFTTNJWVNuaUxqRlRaVkVZTCtxa0h5OS9UYkdFK3Y4anAraUxq?=
 =?utf-8?B?QXg4czBhVnJLcWtrY2FiV29zN3VPZno5YlVrY3JWMWUxRml3ZDg3K2pES1Bi?=
 =?utf-8?B?RjRnM3ZadVFkYWo0NVlTSVFpUTVld0M4L0VKQ0JmZ09mNFNndlhEaVRjY0J1?=
 =?utf-8?B?T013clJlcXY5TFlCczF6S2RXRTR0NjlvWDF3a0RXS2Yrc3hiMjJuS0lrcm4r?=
 =?utf-8?B?ckhBRkh6ZElRQUt6NWxpcngvaS8yNG4zckd5bzEwWldBU3QwK1NJaFNIWXBn?=
 =?utf-8?B?MGlpUjhib1dFVVdFZm5obzNIblYwcFVSQTN3d05tb3EvMWdYWHY3UTl6K2dt?=
 =?utf-8?B?Q0pqcUNJdTVOOXJ4cjF6S3EvUmdkNFYxR1BENGVmcGYzaUtUSm9iUkgxRVZQ?=
 =?utf-8?B?dzhHWTRPSUcyS1Fhcm82UnIvemZDdFJ2K2ROZkFLT2Y5aExFeW12a3o2NlJi?=
 =?utf-8?B?UWYxZXNZOTRuQnZwc0lGNkxNcGh0TEc1NncvcEVCeGszQjMxMTdTZHZ4Lzg2?=
 =?utf-8?B?OTF1WVR0S3BWVGFmSnl3LzUvMkdKSzJ4SzFYRjRBUmZSS0V6OXpzbHhkZ1Nx?=
 =?utf-8?B?VHFGRTdFWFh1L3dXeDRqdkUxamhqUEdxQkQxZkl2MzZSM0hlaHYrUXFaQUNX?=
 =?utf-8?B?ZjFQd0JnMWhzc00zcDZEVFl0a09TaWl1b0F1YlF6S3JqMkhOeE10MEc2RW5a?=
 =?utf-8?B?UFFJQ094VHhwQzVZUXB5TVMwS2xDYnNOeG9XQVhWSk0vUGprUm44ZDVlemYr?=
 =?utf-8?B?YmZza2xTek1yc2RuRHUrdGxvUkRNMjJJbHJwYlBnK0dPZXU2VzZoeUszYnhY?=
 =?utf-8?B?ZGFvY1I2L2RVaWtuREVIOUdSVytHSHpQTGRkSTI1NU1RbWE2THJtUjE4MTJS?=
 =?utf-8?B?RndyTWJMb0JxaE9KaGRkeW9zejR2ZDlyUlJ5WkFqWXNhOVI3RlRmOElMd0Nh?=
 =?utf-8?B?anBiZ05DSy9iZjF6WHNmMnhpSTJjekIyMUxnc082R2c2MlR6OW1NUllQMm1l?=
 =?utf-8?B?YlRHR3M5N09ldVFTMllySE1wUDhQSEpmS2YrTlNJR2h2U0QrVkp2S29sOFBv?=
 =?utf-8?B?SnU4bG52dXJlK2grbTh0ZDBYN3NuUmZtV0NiMzdtdE8vMjBqbXJIMS9NQmtM?=
 =?utf-8?B?MFJIZFdVNm5IVFNnUlZDcW8vMFRrdlNaaGUyM2U5U3NEbVdwMmZ1S3QzdkR3?=
 =?utf-8?B?UFl5VndLT0kya01tWTFqcXBZMUgxV0NwMHM2ZUdkWmtvaHNTWUZkOHV1RStD?=
 =?utf-8?B?R2crQjUzZXU2Vk51SjlPQ25qcGxIT0V6SzNjQ3hBYjlWNS9Bb0Vzb0xsdlRk?=
 =?utf-8?B?TTJZTy9DRXNNU25CVk1GQ3dYZkR5bDNOUS9NQ2tWOEhHSkVIZjVqZThjb0hk?=
 =?utf-8?B?Q2hGQnNHRWdUKzdmc3N6dXoxSXAyUHZRVURVc1poVGkwWHRZMzh1MWFLZlc4?=
 =?utf-8?B?eE9yRzUxUGxTQ2hlNXp0T3Z6R0YvZ3IxZUU2MjBnUkI4bjdhU1FudnlERHpl?=
 =?utf-8?Q?CRX3NFV8FwadY/M6zTYNn0s3nJhXsIJjWTFgDuv?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN0P110MB1673.NAMP110.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YmVyMDRXLzUrb3UvcVBHR0MxMEx2WXdId2cvdDhYaTRnT3pUVXRKTDBqRUEw?=
 =?utf-8?B?MEhOSUIyYXBnR1owOERXeHZTRkFFVVhtTmJJdXF0bW5COVRENktiQmtvWjJB?=
 =?utf-8?B?SzVja0dLeitEUTQ2SEZ2aGwxZEhYZHo1Ukk1UlR6Z0MrZC9OZXgwWjNQcWVX?=
 =?utf-8?B?UEllaVJNRTZvOUJsTm56VGx4RUZzZUdFM0NGZmFTQnpZTm5RYytYN0pYNXRk?=
 =?utf-8?B?RURlRStRY3JQS1VXbVBFVU9aM2J2NWlyWERxWnhHbDdIaTlmNHNBTmpSOUVP?=
 =?utf-8?B?S25iRG0xSzllcWtWRnVoN0p4cXVzR0tYSExhZ2FFRlBWSExaUSs0NFpiT010?=
 =?utf-8?B?eTd1THIwdDNpOTZtdWx5a0JLTVNtaFVTU0F6b2dCSUo2SUdTWURjVThyZXQ2?=
 =?utf-8?B?NUZTS05HY0trTXgzWEtUNE81MCt6VnNWKzRUUWtyRFpNbGhycmZDdTVPbGVQ?=
 =?utf-8?B?MnppdzdVTVNHVXNOUmh2VVY5a3pDU1NXdTh0ZlVkTWJwRWVlTnRMd3Rydmxh?=
 =?utf-8?B?STBBV2FwNjluL2g1L3JMcDAvR0d0Z1QwWFNPcUxpbjlCd3pGeUNJbmRxbm1U?=
 =?utf-8?B?M2dTcURBcVFCTlZYcU9aV2M5RStZYTZCRG8wVmZBU2U2YU9tM0VLdHUvQm9v?=
 =?utf-8?B?UW5zT2Z5ZFQ5bk5ySUlPZUJBdndlNXdERExicDVBS21DbU90dlhMY3IrUEdS?=
 =?utf-8?B?Vmw4OVR0eEoxVStqSzE1SHFSRmoxdkl6anpWaE5SQ0NrZFNrL2hCVEVQWkFI?=
 =?utf-8?B?Tldwdi8rbGUrR2Z1UWErY2lxL3Z6elY2WE9JMzNsU3d6dkNIQy9GWWc4N3hY?=
 =?utf-8?B?akN3WW4zUGszcFFJWEVPS3pBSUV3MldvMzRsbEYxZHllSkFVTTB0cTh2M3ZX?=
 =?utf-8?B?QWFYc0ZFWUNiQktLcmcyYXJXZmNONElhL0N2ZGQycXNZV2pHUW9TN0dmSE0v?=
 =?utf-8?B?ZHJLWUhWUktmT1J1K2VLcnJZRFFvMkVDZ0x0ZDJScjZGa2hkT0JxQStZdGxn?=
 =?utf-8?B?N2RYelVDVmdpd2ViVU1VbGZsWXV5em9NSzdSYlFoV2VmQTVDc3MzRTlWZlA3?=
 =?utf-8?B?UWJuaExTSG9DcnFOamViaHA5MmMrL2QxMnhNUEZkQVJIZDkrT2p1Y050SGFz?=
 =?utf-8?B?RjBJdmdTVEZRQ3QyUTlmcVIwT1J6N1RwS0dpbE9vN0dwcXcxdC9tQUoxZU9l?=
 =?utf-8?B?L1FxNHFOTXluZDUwMmVxbGtubDg5a25QcWpEVGVlMFhUMS9ITDU1dlVwZWJw?=
 =?utf-8?B?Qlo5eXVsUEhzVjRQYUZuM00zVXRvT0hrZFQ2SlEyRVczRFRCMXZ6Y2IxcFQx?=
 =?utf-8?B?VksyK1AydDQvclcxc3o2RDFGd216K0s1R0d2M3pqNkRiaDdqcGJJS3hNbTZw?=
 =?utf-8?B?RXRxTmt2QUZ6eHpTN0htUWdYUEtjZnFhbXhiQkFZaDB0RURoWllVOXNkZEFM?=
 =?utf-8?B?ZENoKzc0TVJRekxWZVZlOEpiTW1EZW1lcUlSZHVnVUIydXh0N2JrVzIxYUhN?=
 =?utf-8?B?KzUweUpxZzNuYStTeS9IYTQ1NmltTW5TWHh6ZDFaUGhuMVR3YzJiNnZkd0l2?=
 =?utf-8?B?QnNKVTdCYmNUQndudm9xdk5QZGYwNUtvaWU3ZGlsaGI2VndoYnF5K05kcnJV?=
 =?utf-8?B?MkpOODVrakdlUkg0NExBeFlRNzlneGVPQ1BWeHBJNFEySzZlVXU2dzNpeTR6?=
 =?utf-8?B?ZUNYaWh6TlBPMjFEODlFZmlqNTEzUllwdTE4eHZHNytrMTNYaHprcUc1eHRJ?=
 =?utf-8?B?cGhRSEFDdld2QWNEejR0OUh4dkIrZGZTcDhkSjJkZUJGQVZ2R3JBNzNJd29N?=
 =?utf-8?B?WlhhUUxXR29IOFdWai9RYjA0dGJNdy9zclFzTG91VDc5S3BYcnp3SzEydGNN?=
 =?utf-8?B?UEZTQjlyNEZpVW9jR25uNVU1N3I3VnhoOHF3ejFUZDI2Qkx6TVBneWFlcmc4?=
 =?utf-8?B?a1BpVVRSMnYvNCtkOG82M0pYai9qQjVhZ0c0a05ibURLVERDR3pBeGVHTTRa?=
 =?utf-8?Q?TJNjJSTom3FRH/69nKgY0x5y8vYGao=3D?=
arc-seal: i=1; a=rsa-sha256; s=arcselector5401; d=microsoft.com; cv=none;
 b=Z1uYEpwTFZjWCCpn9NrpjTSEjAKb9XIPLyEeuCNbv2AZ7HQTreYgM5Nj9gA7xeAPqscukv5j39+SOwWgm3Mr3OZFp3i3Z2/yt8rkDWEGBf+DfnSmlkedcsBYd0vElKn11x5aMF9ybuKN0c7AbBTklPQOxcz9hVN8IEPmRjZwo4k3tmmmKSzhcjC3e6YEB4N4RVJJP6trXme9LzyLQTb96A/Nl7gMSbJo+q6pMLYZXPVCtaUrO4DKFGmx/VEJ1wd4U9WoVW7tlny5W0OSLf09bxQHzo7CtDaZt/PNZk5fQkg1a0w2a/9raGP73zZyam+WmMH6SH5+1gGVXs6p+UnBxQ==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector5401;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DBWVqMLz5oUt5x7SsPBGBfyVqSBUPqFwev+E6wDizLI=;
 b=J3MOVxhPSJSEIfvySTLJaxC3p9OV+Hi+Hc7jA4yjnrn4Zw0bjR/1Y2L33imB1HO4jvNJkFIjTBBIrG5PgEfchrDjJTo485fX2geIakyw4AVk8hdXaUFRRsTtEEWP7FuzJ50FKcBEOdExf/Z1Vitl4p4d/lRV6ALAQ2uizmSLCRrWoRoKT5SqCAOuihT/O8uTOGYGPFwis04udxPi2ylng5hXtw0HzRQzsAmrYsmqSn62do+kPv1lwP0binWWdRH07ub9W0KtJS2eYKeVSJU1CivkZGPnUe7494L2bKhoj+XwmP6gznYun0ZK9YZ90xsCrawT+sLin2XZtjb0VwqdCA==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=collins.com; dmarc=pass action=none header.from=collins.com;
 dkim=pass header.d=collins.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rtxusers.onmicrosoft.us; s=selector1-rtxusers-onmicrosoft-us;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DBWVqMLz5oUt5x7SsPBGBfyVqSBUPqFwev+E6wDizLI=;
 b=hqTTktSZ6WLiDYudxt0yyQpFWNIfPmNMVR12YBwwG5stOjfn7Q6Nhf4QnhYcXhWkyptcD2UnwjFnNULW6Bw3bD77eewTNDIQtWn6OnaqGiPWq36IexR2XvPAON5Oh0jaqgh/X9Ihfm1TMDd7hI/leCapG/X+jS+aItbOzY1wCKM=
x-ms-exchange-antispam-externalhop-messagedata-chunkcount: 1
x-ms-exchange-antispam-externalhop-messagedata-0: 3t1IcTC6VHiudw1AAaxnZQYXkebIe4rV1eUM/lrdWL/P31b6o2cFXUf5SAQUoAwK7yEasZtv0G/brF6zimx8i9DlOPQEinFxs6AoQLY1liVF3XuipAfAOr+Z3pXtNDxzyGJ8OznSDe9VH3eVPgYcKtkBYqlqedNTthwrN9kOe/bXXXQWz4KZmboirCAp4djSkNmo5O0rveYsHPp5BMj7t7kqzvEGxiivHv00lejRYj0ohCIyQh/Isnaj6xkzIUk5etRX6LbJiTIgHG3N+nZUE5N5DBaUfyEugzeaZzi7o0pH4J9DS+HUbDTZ1StvXGsl3+NzVgvScKQHpJmd520TKW8t3vA73SQsmXfHYXWzNVHQLPaDoUDutut8Q/+4geq4W5COikrYDCow9fUBKKN+ONyatSrznpTUxquVE1HFHUIKFpfki9LrvgedYIHoeZaCH0UySJsDYUanXEpydlbfNkNA2fhma08Vv9pZjYqDHsrnHxAx6LlWOqc8rFjiKMLV3dn40NJVRoxG9PRa6MsdpC9yTU3lr+sggePDmsGG+FjYTTbWtnUr4wHEJLHR/yWVeBjzAeWFmM9yzAKJ4Y/V7EJ3NCtR5a2F+KeLqBKPU4M=
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: BN0P110MB1673.NAMP110.PROD.OUTLOOK.COM
x-ms-exchange-crosstenant-network-message-id: 786c432e-f53e-4ebf-5296-08dc8572d357
x-ms-exchange-crosstenant-originalarrivaltime: 05 Jun 2024 15:18:59.7687 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 7a18110d-ef9b-4274-acef-e62ab0fe28ed
x-ms-exchange-transport-crosstenantheadersstamped: BN0P110MB1545
x-passedthroughonpremises: Yes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Collins.com
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-05_02,2024-06-05_02,2024-05-17_01
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-05_02,2024-06-05_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 spamscore=0 mlxscore=0
 malwarescore=0 bulkscore=0 suspectscore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406050116
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 malwarescore=0 phishscore=0
 spamscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406050116
X-Proofpoint-GUID: pTjsO3AzZYIiU66oaPrqqwUwXrngU1v8
X-Proofpoint-ORIG-GUID: pTjsO3AzZYIiU66oaPrqqwUwXrngU1v8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-05_02,2024-06-05_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_default_notspam
 policy=outbound_default score=0
 malwarescore=0 mlxscore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 clxscore=1015 lowpriorityscore=0 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406050116
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

SGkgU2ltb24sDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU2ltb24g
R2xhc3MgPHNqZ0BjaHJvbWl1bS5vcmc+DQo+IFNlbnQ6IFR1ZXNkYXksIEp1bmUgNCwgMjAyNCA5
OjE0IFBNDQo+IFRvOiBNYWllciwgQnJhbmRvbiBMIENvbGxpbnMgPEJyYW5kb24uTWFpZXJAY29s
bGlucy5jb20+DQo+IENjOiB1LWJvb3RAbGlzdHMuZGVueC5kZQ0KPiBTdWJqZWN0OiBbRXh0ZXJu
YWxdIFJlOiBbUEFUQ0ggMi8zXSB0b29sczogYmlubWFuOiBmaXggZGVwcmVjYXRlZCBQeXRob24N
Cj4gQ29uZmlnUGFyc2VyIG1ldGhvZHMNCj4NCj4gSGkgQnJhbmRvbiwNCj4NCj4gT24gVHVlLCA0
IEp1biAyMDI0IGF0IDEwOjE2LCBCcmFuZG9uIE1haWVyIDxicmFuZG9uLm1haWVyQGNvbGxpbnMu
Y29tPg0KPiB3cm90ZToNCj4gPg0KPiA+IFRoZSBtZXRob2QgYENvbmZpZ1BhcnNlci5yZWFkZnAo
KWAgaXMgbWFya2VkIGRlcHJlY2F0ZWRbMV0uDQo+ID4NCj4gPiBJbiBQeXRob24gMy4xMiB0aGlz
IG1ldGhvZCBoYXZlIGJlZW4gcmVtb3ZlZCwgc28gcmVwbGFjZSBpdCB3aXRoDQo+ID4gYENvbmZp
Z1BhcnNlci5yZWFkX2ZpbGUoKWAuDQo+ID4NCj4gPiBbMV0NCj4gaHR0cHM6Ly9kb2NzLnB5dGhv
bi5vcmcvMy4xMS9saWJyYXJ5L2NvbmZpZ3BhcnNlci5odG1sI2NvbmZpZ3BhcnNlci5Db25maWdQ
YXJzZXIucmVhZF9maWxlDQo+ID4gU2lnbmVkLW9mZi1ieTogQnJhbmRvbiBNYWllciA8YnJhbmRv
bi5tYWllckBjb2xsaW5zLmNvbT4NCj4gPiBDQzogU2ltb24gR2xhc3MgPHNqZ0BjaHJvbWl1bS5v
cmc+DQo+ID4gLS0tDQo+ID4gIHRvb2xzL2J1aWxkbWFuL2JzZXR0aW5ncy5weSB8IDIgKy0NCj4g
PiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+DQo+IFJl
dmlld2VkLWJ5OiBTaW1vbiBHbGFzcyA8c2pnQGNocm9taXVtLm9yZz4NCj4NCj4gRG9lcyB0aGlz
IHN0aWxsIHdvcmsgaW4gZWFybGllciBQeXRob25zPw0KDQpUaGUgUHl0aG9uIGRvY3Mgc2F5IENv
bmZpZ1BhcnNlci5yZWFkX2ZpbGUoKSB3YXMgYWRkZWQgaW4gUHl0aG9uIDMuMi4NClRoZSB0b29s
cy9idWlsZG1hbi9weXByb2plY3QudG9tbCBzYXlzIGByZXF1aXJlcy1weXRob24gPSAiPj0zLjci
YCBzbyBJIGFzc3VtZSB0aGlzIGlzIGZpbmUuDQoNCj4NCj4gUmVnYXJkcywNCj4gU2ltb24NCg==
