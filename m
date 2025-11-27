Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C586DCFD2F6
	for <u-boot@archiver.kernel.org>; Thu, 27 Nov 2025 08:22:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0865983AED;
	Thu, 27 Nov 2025 09:22:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="D+N29eXX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 04FEB84327; Thu, 27 Nov 2025 09:22:46 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95A5F83A5A
 for <u-boot@lists.denx.de>; Thu, 27 Nov 2025 09:22:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E0gG7zMPT6Ui/c5y9QYWDDQpSubLSsYPtsXBysfKKBtbVZ6DwNeYXkpkKeAlv8mu57A9jf4g2jjbwsxrfJIDxIZcHWT2p/ZcmLUcm+BiFL3ZecHH3IIHDFa1xuog5U6+oSESF8IRVVXhvgM9xsF/vUylc/i2JIviXGfTWiIoj7kRXB9iZpGXb+/oTeQCJIOu79KU1imf6Ub3IAT9UhntaAKT9hwkOJSJpsT5OycTNKfzey9GTO9pu0KhXDe/nUOv4t05Fr7HHHsbx3lvWHxBUnXorgKd4a8A4RgLbFF0HsWmBZFRv/uTpZIBb9sYPrlI2i1ivkuJeqlJqQjFTVECEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Om2uErmU+nhOaIki23yva/xfc97suzneIERGrkI79hk=;
 b=V56q6wjhzeRiPoSFceHKdBfgJApRs1bj2n1QKExrXoHMs2HzIgVU2Cg31AYWaNDe3lXBTbA3gMiw7Y15CREBZLWbnJfByMtCYIyAzcmVxCRPc03UTUj03WnOP8TJ6cc/Y4P9szYfsI04MjrsnfAATbHiyZfrnVQczCWjCkm7CL/wQLpLEP7W7GVpw+yHv7UWqLv5XnKVcMV4iGqCoSQoUkcMfveL86Q1MpXqfFnuf2JpJklpBXnVSMSsPsNaKMj3vCC8pJop/2VdyKXtOjKiLrQ4kEBdwMe5ydWPk2vxNRbEIB5ojPclYhcVrS44Cv4m7SV50m58kgvwUIkwbh3slQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Om2uErmU+nhOaIki23yva/xfc97suzneIERGrkI79hk=;
 b=D+N29eXXt1BXQXYDGHpW483d1BgjnIt77+0uUozNwa3lRdvAve3aNr+5qzfzboep655LQtFeg9UJHgfFs1yqt5/HfeWl+5+7M52IW9M9ur63WyPPGMD+5y/Hgdxva0ozUg1HCO2Q8riIwR8QMywbTKLUYPjvSB9Rxf094KgKlT6bnMEAo646VfSZCLvLSBKqYSbdu+HQRzJen0/y8BnbyOuUiyHM4zp2u36Gq3VS+CFNEw1LpCpbzhVTU1SwOcpko0oL7GU1lsbao750Qiv35uHHK+X4AuzOHaLPpLwHzrAwMS6bGVRnvGjorJG1veNOWiQHbfXq2TXUp+/P1CXnvg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB5593.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:30c::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Thu, 27 Nov
 2025 08:22:41 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9366.012; Thu, 27 Nov 2025
 08:22:41 +0000
Message-ID: <d4b1acef-fd8e-44d2-b583-450d4c61190f@siemens.com>
Date: Thu, 27 Nov 2025 09:22:40 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 6/8] configs: cyclone5: Enable SPL FAT support
To: Sune Brian <briansune@gmail.com>
Cc: "Chee, Tien Fong" <tienfong.chee@altera.com>,
 alif.zakuan.yuslaimi@altera.com, u-boot@lists.denx.de,
 Marek Vasut <marex@nabladev.com>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
References: <20251125081316.17329-1-alif.zakuan.yuslaimi@altera.com>
 <20251125081316.17329-7-alif.zakuan.yuslaimi@altera.com>
 <896ecbf4-d85b-4c09-b8d0-9730be370673@siemens.com>
 <e2f1c154-573e-4326-ae8c-ee9ded46c71d@altera.com>
 <dbe16e20-ae32-441e-b987-6cb5feaeeb93@siemens.com>
 <CAN7C2SCmt1z_rtQBpoBwpDJBCcXWAX7eZTz=mxQ1SqPR=rqWfw@mail.gmail.com>
 <75a890fd-48c0-439e-962d-6fa85fe67953@siemens.com>
 <CAN7C2SCSr3h6dJLEXrUEdvAHQYyEfo3jWtkUkNccSWYTv9M7fg@mail.gmail.com>
 <0c42e18e-60d7-417d-9b83-dea8ffd4a362@siemens.com>
 <CAN7C2SDH6g0PgDUsu8hEnEA4yr6z+YA5afWhK9-D7-7wBbe33A@mail.gmail.com>
 <b977adfc-f16e-4436-91eb-8824932379af@siemens.com>
 <CAN7C2SCiTqJDK2ZVjJ_859NEDg6tD3KWQqzVHqqmbyM8+aBvLQ@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 xsFNBGZY+hkBEACkdtFD81AUVtTVX+UEiUFs7ZQPQsdFpzVmr6R3D059f+lzr4Mlg6KKAcNZ
 uNUqthIkgLGWzKugodvkcCK8Wbyw+1vxcl4Lw56WezLsOTfu7oi7Z0vp1XkrLcM0tofTbClW
 xMA964mgUlBT2m/J/ybZd945D0wU57k/smGzDAxkpJgHBrYE/iJWcu46jkGZaLjK4xcMoBWB
 I6hW9Njxx3Ek0fpLO3876bszc8KjcHOulKreK+ezyJ01Hvbx85s68XWN6N2ulLGtk7E/sXlb
 79hylHy5QuU9mZdsRjjRGJb0H9Buzfuz0XrcwOTMJq7e7fbN0QakjivAXsmXim+s5dlKlZjr
 L3ILWte4ah7cGgqc06nFb5jOhnGnZwnKJlpuod3pc/BFaFGtVHvyoRgxJ9tmDZnjzMfu8YrA
 +MVv6muwbHnEAeh/f8e9O+oeouqTBzgcaWTq81IyS56/UD6U5GHet9Pz1MB15nnzVcyZXIoC
 roIhgCUkcl+5m2Z9G56bkiUcFq0IcACzjcRPWvwA09ZbRHXAK/ao/+vPAIMnU6OTx3ejsbHn
 oh6VpHD3tucIt+xA4/l3LlkZMt5FZjFdkZUuAVU6kBAwElNBCYcrrLYZBRkSGPGDGYZmXAW/
 VkNUVTJkRg6MGIeqZmpeoaV2xaIGHBSTDX8+b0c0hT/Bgzjv8QARAQABzSNKYW4gS2lzemth
 IDxqYW4ua2lzemthQHNpZW1lbnMuY29tPsLBlAQTAQoAPhYhBABMZH11cs99cr20+2mdhQqf
 QXvYBQJmWPvXAhsDBQkFo5qABQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEGmdhQqfQXvY
 zPAP/jGiVJ2VgPcRWt2P8FbByfrJJAPCsos+SZpncRi7tl9yTEpS+t57h7myEKPdB3L+kxzg
 K3dt1UhYp4FeIHA3jpJYaFvD7kNZJZ1cU55QXrJI3xu/xfB6VhCs+VAUlt7XhOsOmTQqCpH7
 pRcZ5juxZCOxXG2fTQTQo0gfF5+PQwQYUp0NdTbVox5PTx5RK3KfPqmAJsBKdwEaIkuY9FbM
 9lGg8XBNzD2R/13cCd4hRrZDtyegrtocpBAruVqOZhsMb/h7Wd0TGoJ/zJr3w3WnDM08c+RA
 5LHMbiA29MXq1KxlnsYDfWB8ts3HIJ3ROBvagA20mbOm26ddeFjLdGcBTrzbHbzCReEtN++s
 gZneKsYiueFDTxXjUOJgp8JDdVPM+++axSMo2js8TwVefTfCYt0oWMEqlQqSqgQwIuzpRO6I
 ik7HAFq8fssy2cY8Imofbj77uKz0BNZC/1nGG1OI9cU2jHrqsn1i95KaS6fPu4EN6XP/Gi/O
 0DxND+HEyzVqhUJkvXUhTsOzgzWAvW9BlkKRiVizKM6PLsVm/XmeapGs4ir/U8OzKI+SM3R8
 VMW8eovWgXNUQ9F2vS1dHO8eRn2UqDKBZSo+qCRWLRtsqNzmU4N0zuGqZSaDCvkMwF6kIRkD
 ZkDjjYQtoftPGchLBTUzeUa2gfOr1T4xSQUHhPL8zsFNBGZY+hkBEADb5quW4M0eaWPIjqY6
 aC/vHCmpELmS/HMa5zlA0dWlxCPEjkchN8W4PB+NMOXFEJuKLLFs6+s5/KlNok/kGKg4fITf
 Vcd+BQd/YRks3qFifckU+kxoXpTc2bksTtLuiPkcyFmjBph/BGms35mvOA0OaEO6fQbauiHa
 QnYrgUQM+YD4uFoQOLnWTPmBjccoPuiJDafzLxwj4r+JH4fA/4zzDa5OFbfVq3ieYGqiBrtj
 tBFv5epVvGK1zoQ+Rc+h5+dCWPwC2i3cXTUVf0woepF8mUXFcNhY+Eh8vvh1lxfD35z2CJeY
 txMcA44Lp06kArpWDjGJddd+OTmUkFWeYtAdaCpj/GItuJcQZkaaTeiHqPPrbvXM361rtvaw
 XFUzUlvoW1Sb7/SeE/BtWoxkeZOgsqouXPTjlFLapvLu5g9MPNimjkYqukASq/+e8MMKP+EE
 v3BAFVFGvNE3UlNRh+ppBqBUZiqkzg4q2hfeTjnivgChzXlvfTx9M6BJmuDnYAho4BA6vRh4
 Dr7LYTLIwGjguIuuQcP2ENN+l32nidy154zCEp5/Rv4K8SYdVegrQ7rWiULgDz9VQWo2zAjo
 TgFKg3AE3ujDy4V2VndtkMRYpwwuilCDQ+Bpb5ixfbFyZ4oVGs6F3jhtWN5Uu43FhHSCqUv8
 FCzl44AyGulVYU7hTQARAQABwsF8BBgBCgAmFiEEAExkfXVyz31yvbT7aZ2FCp9Be9gFAmZY
 +hkCGwwFCQWjmoAACgkQaZ2FCp9Be9hN3g/8CdNqlOfBZGCFNZ8Kf4tpRpeN3TGmekGRpohU
 bBMvHYiWW8SvmCgEuBokS+Lx3pyPJQCYZDXLCq47gsLdnhVcQ2ZKNCrr9yhrj6kHxe1Sqv1S
 MhxD8dBqW6CFe/mbiK9wEMDIqys7L0Xy/lgCFxZswlBW3eU2Zacdo0fDzLiJm9I0C9iPZzkJ
 gITjoqsiIi/5c3eCY2s2OENL9VPXiH1GPQfHZ23ouiMf+ojVZ7kycLjz+nFr5A14w/B7uHjz
 uL6tnA+AtGCredDne66LSK3HD0vC7569sZ/j8kGKjlUtC+zm0j03iPI6gi8YeCn9b4F8sLpB
 lBdlqo9BB+uqoM6F8zMfIfDsqjB0r/q7WeJaI8NKfFwNOGPuo93N+WUyBi2yYCXMOgBUifm0
 T6Hbf3SHQpbA56wcKPWJqAC2iFaxNDowcJij9LtEqOlToCMtDBekDwchRvqrWN1mDXLg+av8
 qH4kDzsqKX8zzTzfAWFxrkXA/kFpR3JsMzNmvextkN2kOLCCHkym0zz5Y3vxaYtbXG2wTrqJ
 8WpkWIE8STUhQa9AkezgucXN7r6uSrzW8IQXxBInZwFIyBgM0f/fzyNqzThFT15QMrYUqhhW
 ZffO4PeNJOUYfXdH13A6rbU0y6xE7Okuoa01EqNi9yqyLA8gPgg/DhOpGtK8KokCsdYsTbk=
In-Reply-To: <CAN7C2SCiTqJDK2ZVjJ_859NEDg6tD3KWQqzVHqqmbyM8+aBvLQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P192CA0003.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5da::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB5593:EE_
X-MS-Office365-Filtering-Correlation-Id: bb9f1445-d972-4d18-6ce9-08de2d8e2242
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b1ZGZElBV1dGTTRCQy9LMUUxZTZaNUxLQkdCSnFJOXBYVHVqUytmdzg0bk9N?=
 =?utf-8?B?cHFNUUZySVpMQVRKUU9LQWRYYUEyRzZJN3F6Wmg5c29IK29YbUpXSjFqTVd6?=
 =?utf-8?B?WXNQUTFnM2lmVElyWHJpSHpqOEVyWHVEanlnT3dqb0dSK3dON1B3NXluekVx?=
 =?utf-8?B?TW1LeEpFU2dPNW1yMWxKT2JVQTZ3aEtKYXNKYVNkUDhBYXZKQS9wOUErZm9y?=
 =?utf-8?B?T2FGN2NyRXVxQkJNZzA0ZEx4djY5SkE0RnY0em5nRkRTZ2VYZGw3cDl0Nk1V?=
 =?utf-8?B?cms3SmtTTGlJam03L01IRkx0NFZ3R2Nob0Rvc3M2OUtxRCtyaDFSTEkwVzZB?=
 =?utf-8?B?OC9CUC9lTnppWEFDUlpSRjBHanBrMTJUQUQ1dDR6SzMwekwxaENHVEtva0w3?=
 =?utf-8?B?NFVzczVQYlBTb2luRVU5SGtUamxDYnRsalJVWGtTTlMyQ1IvdEU4N1MzZDBm?=
 =?utf-8?B?dmIwZmhjSm9oK1g2dUJsYmJ3T2dMY1MyR1huamJIN20veGdKbmtUb2FnVFJZ?=
 =?utf-8?B?OW5Ga0trN3k4RE0wUXdPWnZDY0krQ0V0M1dxMzU3VXEva1c4cVZEWjJ4K2Vr?=
 =?utf-8?B?d0h6UzdEMG13elVRaGpmUWF6b1dCV1FKWk9vNjk0azlEWmlFOTlsMk5BQkEv?=
 =?utf-8?B?K3ZWVUZKNFhlMytucno3bSt6NzUzZmRQcUpoTHd1ZWlTMisrZlJtM3dFYnNj?=
 =?utf-8?B?SFpocWFiZkZCS2dHcW0vV1N1SjR2N3dRYUFqQVVzTjVpbXV1UVJjN2FlT24w?=
 =?utf-8?B?eEMxZE5LL0I2V2F6eDFvdzJyYU1KSjN0S0JLR1Jaa1NqOWVXRkxkMWFnWUFO?=
 =?utf-8?B?UDBoNHR2MVFQSGc5QURhVDR1U0FXTVYvUHlMVkpKVTRXWDdEemlvRGtLRjBp?=
 =?utf-8?B?OXR4RHlMSkZFK2psOW1panRBamg0UExzNGZNUjZpVWV0cVhrSjV3WXZKclVi?=
 =?utf-8?B?WmQ1c0xDa2Y1TWdvWFNnUFBKeC9CRVZZcFVsZGNlV0xrWWhIZUdlSzY3MWtN?=
 =?utf-8?B?dDg4MWtmQ0Ezd2J3V1VXbHB4Z0s0N3B0Q3EwVFZMcGJJdGE0UFRYZWpxRm4y?=
 =?utf-8?B?UlBZYTAvUkRUVmNUdEZnRkxST2NvaXY0cW1RVWxNZ3dBL1ZsaUZPWmFrVmgr?=
 =?utf-8?B?UEZuaC9iVEJVVW9XMFdaMHh2VXZLaXdNeXMvemx6S2d5bHo3Y2VFQUx3LzBt?=
 =?utf-8?B?ZkNjQnpGeno0MHFkVzQzaGVJLzZjYVlWUlMwZWZYekthQzZpTDErenlXSHRk?=
 =?utf-8?B?R2xuMkt1WXdTSVJhcUVNRzNJaHcycGpjOFhtZnE3c1N2bFhhTzBDOGhlZWQy?=
 =?utf-8?B?aGQ0Z0lVNFpha2ZhWGFXcnJVY3RpZklVME1kbFhVbmJKMGhHWExDb3M5bEcr?=
 =?utf-8?B?UXhMdEpYSnFkN0l0QmJ0SDVnbHkwdXB3MC8xVDJkMmgxQXMrdzFyaFR5SEhy?=
 =?utf-8?B?M2dZWnhpMGhTTWFMTWRxTzNwTDNmcnpQbmttYVRjVjViZXhNdjdDRzRBalFM?=
 =?utf-8?B?ZGtLcCtsQ1FtelB5UlRlVmdqM0VBdEtvNmxZMW82VXVlV28rcDdHcS91cjJP?=
 =?utf-8?B?aDBIL1Y2TUh4QXl0QkVvWWF4TDdncVBrc1pFbnhDUzZzSU9nMEx0VkF0Z1d5?=
 =?utf-8?B?dG5PM0xob1E3TlNOYTlUWWNHZU9pVFRUV2lWWTlCS3hReFhaNmNMV2hqcjda?=
 =?utf-8?B?c1JVaFM0WCtpbmx1ZUtvNWtVZkZEZlg3WUJYdWxObXVDMWZEaWdjcWZNV3BS?=
 =?utf-8?B?Mi9IQnZzS1Jmb04yZkgzV0pwQld6RElmQXBmbGFkOXhDcWpXaFZqdXdCREM1?=
 =?utf-8?B?UWlRNG85cXo3YzdOeGJhSjhBak5DTktaTjV0cytYWGgza3oyMkF4MnlhY3B2?=
 =?utf-8?B?cVZEdVhpdzJOaFNkc3grdWU3djJFT3dURU5nVS9ob1pwOTlnaDZ4Y0t0L0V4?=
 =?utf-8?B?MEVKTlZPKzB2UUJDVUhja2hLSzY4YnZuL0VHSjdLVzhuVS9WeTRWQ1hHNnR2?=
 =?utf-8?B?SXNWQkt6amF3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cUFPZDRsSUlEbXdFcVFYREJtdXhraVJaK0VoNFdUODVtTGhBQVVSaTV5Z1Uw?=
 =?utf-8?B?TjNwd2J2b09NZzVVdjV4SWp6NzZTaEdsVWhHK3NjRU13aDVOcGVrU2JpK2dm?=
 =?utf-8?B?eHNBMlZxaGJiektOcVhMYmZaajJRN3ZpTXJnWDVyR3dTSmF6ZWM2SDJlbUdF?=
 =?utf-8?B?dTk5bUw2YWNrTU5OdWhQNXR1cjI5WFhzLzI3bmJLTnZEM2RpUVhyZDdsNGI4?=
 =?utf-8?B?OG1KeDNDK2xZcjhnMGYvVnFkYVhPUU5lNDlLYXRvSjhraUE3WU1EYWt5S2Nu?=
 =?utf-8?B?VEliblJrWEhVTkFUeGVIbGxWS09xR1J6Z0F6THpIYW1hUWRKMUJzQUV3bXJr?=
 =?utf-8?B?NXcxcFVxQWJ1ZXY0Wm1WSHJraVJmRGU4anMrWGVLcjNWY0d6Q2FxMDJYdTVS?=
 =?utf-8?B?eHpGTVJoUXlrRGloeWJBbmlaTDZ0L3ZTUzBFTVkwMXhMV2V3ZEFZVkMzZ083?=
 =?utf-8?B?R1VnT3BOR1FSOHhtaGJvY2ExS2dXSDZiRXhIK1krUHdUMFdxTHd1T0pkRGpH?=
 =?utf-8?B?V2V6RGx2VmI5NEkvanl5ak0ra2QxZGtmUzZZY2lVRXY3TXd0SE9yYzJhb3FK?=
 =?utf-8?B?d01pdVcxTzl6QU9oZjg0Q0NnRFBmWUJxTEdrcUFTdkY4Um80cDUyd1BWc1Z0?=
 =?utf-8?B?dWFWU1RhN0Y0T1hGa1dkK0FVTlQ4ekF3MkZYOTNzY2U4TUU5a3VYdm9nczcv?=
 =?utf-8?B?a3QrNHYrTGlnYjNhUCt1UysxR1lvVW9VazhnS2tUWmhsWXNoK1NTZHFvM1BI?=
 =?utf-8?B?QlJHc1hLb2lSNDU0YlNYc2hpclVJeVpMeWF2Tkw3MmpGcUY4ZnYxMEt4cVd4?=
 =?utf-8?B?eU5MM3NJdjBOWmhRSGhhOFRoU3UwdXpPM0ZIMTJxY2w5Zi82UVFZSlF3Qjhv?=
 =?utf-8?B?TmhEQjZ0bkV5T3FyVjdxc1RzSmZhU0ZPRGU0dGJId0o4TDJLVEozTW95T0Zo?=
 =?utf-8?B?aDBMeTdxVUh1OTZGRDN4d0VvbmVCNHpzamFFMitqclRsRC9Ec08wcUxOMHJY?=
 =?utf-8?B?N0loUm5nOWc5QUVDdGhOckY4UmwrYkVyQzR4ZnV0Q01tWlVGMFlHSXczcCtG?=
 =?utf-8?B?U2RzQVNXT0lWM2RXUDExYU1oZXdBUWlMTnhRa2EyczNMSXNUNXh0a0M0NGJn?=
 =?utf-8?B?bkNYZEk1bFgvUnp0OGxuTjlJQ1U0QnZrYkw0c29BYnFWUHphWDhWejY1c0w0?=
 =?utf-8?B?STU2K1BSMjBLWFRxeUJXSlIwa3RORWd4eEo0NjlwVVhsTFVabEg5aGVMSm4v?=
 =?utf-8?B?WjExSzczTDQ5emVjcU1Objh6c05pdW1QN3NCVGFYenlWeWRpcUVhaTlveHgv?=
 =?utf-8?B?ZnozMFYvbG5LM3puQkEzaDI2MWZaa3lFdlVjNmhjWldSdytwbTJud2pPSSsx?=
 =?utf-8?B?d2EzOEcrMUhEUWhaNmZ4V3NZVXcxVnBmSmhtWVlBbzcwMVlxQmROQUsrSElY?=
 =?utf-8?B?RDh2MkFlMCtON1BFeE4zRXlOSm9DS2VacyttRzRnNUV5ajE3U1Nqb0ZtTlZP?=
 =?utf-8?B?bUNTMGpHa09tQU9LNHNsenJEdDRYTzNZY29mNVRVMWZjbXJMSlRnZ1hTSnNj?=
 =?utf-8?B?SHBleGZySEJxbHZhRUFGdExVVHpadUNDVUNXWklDYXYyaHJvMUtyYWw4bXhn?=
 =?utf-8?B?Z0V0N3NEdmxjREtxZTd5WmQ1YVBBWEJtOFVZc3UreTlxQXJrQ1ZzZVZ0elZR?=
 =?utf-8?B?dnRONnQ3SkY2REV5TGhFdHFrVnljOUFPSC9qRnFJQzFlQjAvNENJN2xPdzVS?=
 =?utf-8?B?LzBjRUMxSkhMQ2ZFejIzY1I1QThZc0kyNlpKaEFQVlVrMFlYT25hckdMdG5y?=
 =?utf-8?B?Zmx0OVo2UjkzMTBGZVVHVmhhNmxlMTFiYmRlL3NoTllSNWV6aHhPTnJaaXNW?=
 =?utf-8?B?cENNelVSd2VJSzVCcHlwaVpOSU91K1dGVEhTR1gxYXF6blZyemp5VTd5c1gx?=
 =?utf-8?B?eGtSaWtUOFJqTFlYZHRKRkRRc3ozQk1kZXlvVlI0Rmh4Z1VyS2RXbkVMSGZG?=
 =?utf-8?B?UHlaY0htTW41VmQ0NjhWSTdMdnhBNEYzNkc3aWR6cnFyRE9KNkJtRUJyVlhB?=
 =?utf-8?B?WGhkUThPZDdVL2gyTlhLY2tZK2EySm95OTI3NnZOZnV0Z0I1UFdBMkZjbitp?=
 =?utf-8?B?dzFTSHpYRXloWmc1RGViZkFoK0I2azBEVWgrU3ZJRkp0MXVVL0t4RnFQTG1u?=
 =?utf-8?B?aUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb9f1445-d972-4d18-6ce9-08de2d8e2242
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2025 08:22:41.7468 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xbfcJgDspgY2E405ckIwsJ68p1gFaL9v7pkXOxtSWxMcqh7zV2kCw4nDjBrcW4ezys/EQoIVtESgYRfDKw2PzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5593
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

On 27.11.25 08:56, Sune Brian wrote:
>> I would recommend studying my raw-mode loading patches without looking
>> too closely at your own setup again. You should be able to spot the bugs
>> I try to fix there.
>>
>> Jan
> 
> Open minded, point out which one please?
> But since 2025 07 I did not encounter any major issue.
> On mainstream. Maybe your patch dates before that?
> 

My patches address master (of two weeks ago at least). Please have a
look at
https://lore.kernel.org/u-boot/cover.1763140421.git.jan.kiszka@siemens.com/
(or https://patchwork.ozlabs.org/project/uboot/list/?series=482132), and
if you find something that is changing in the wrong direction, please
comment on it. There is at least one known build issue when you disable
CONFIG_SYS_MMCSD_RAW_MODE.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
