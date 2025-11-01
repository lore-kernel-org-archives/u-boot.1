Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E82F6CCFA00
	for <u-boot@archiver.kernel.org>; Sat,  1 Nov 2025 15:15:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7CEB5838CC;
	Sat,  1 Nov 2025 16:15:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=21sw.us
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=21sw.us header.i=@21sw.us header.b="knW8Ut9W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 192D3836D1; Sat,  1 Nov 2025 15:46:53 +0100 (CET)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c000::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D82E283677
 for <u-boot@lists.denx.de>; Sat,  1 Nov 2025 15:46:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=21sw.us
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=mchaffin@21sw.us
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yb8xnaJQ7rOUCbPw2SFXl5y3OZnZDOQBeO0PIyzuEkApZT1lA/q5cBTwOquk0/j/n70oTb7MAxJ7K5sHi9m5YnvDT/ZhCaByJBCvwpaQCNCrDPP42fyzFuDpqJ9oZ41M5gczuD1nCkkxYtDlDSI5cKnto1GIIq+KKaQr5tAUMoyag7bbWzsrhKds243I1yNqG2yk2Cmqlq4jRWW6vzD31rSgB+iCv7k3g8sEX2SnObtVKPrjpT5V385Uqn/lzKRx2eRHUtZscpbRd4xUufwWV/0R9hQHXZ9ShDNR1el3ZIL8U/6HoFkMzLFgyoF5Fom8xH9klrfDOX0mR3w9c5VA8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hh+WJ7FSNx/YSLRThGST7fAiB7cLQt0AEhc5thmPN8I=;
 b=Rke22uNkKtnW4Cyp6Y3BkMYv2tgr0pojQDgXq2Pvgf9u7jsh3TF8JjiS8IUul0FrQxmPiFN4BJCTmc9/VrPQWYLaN+/BcdBr+AUSWk4buqLm9kqLYD0Xnr7Qz7NbJ7qqMJF751eI4ogNuNdEfP+oSAcCrwFQ0fgf8Q7SHjV4zAjPtH1yfSu2VvD9hRdRhu9A8QlyPrxxBySAcUQKqkSviDuyNAgnoHdaTjT5tDA8t8vS/gNYy1zGbFpg7mcEmtv+00S+WRx7+//3hW+uBnJk8zAUIv83obYGUJEvoaCFdGviceG2F2Cwt/PUKlBKE/QC4sD2RCkDfsF/SR2fTcMnbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=21sw.us; dmarc=pass action=none header.from=21sw.us; dkim=pass
 header.d=21sw.us; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=21sw.us; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hh+WJ7FSNx/YSLRThGST7fAiB7cLQt0AEhc5thmPN8I=;
 b=knW8Ut9W5BiRfMZDeUSeWn48KKt/ClLOX1CbJu4nznDXsqtjka0jsEdXBLqN9aDVPRqp7m+V979U0BxpExl3TQ5AH9I5uZK8R/fXwYoSXBr2W5q2mgRTYchiE+mjrRpWpX/ytM/MNTT3LFIGE1FiEujvK+reZUZvH0mvFhXW8rkmM0NbIhkGdwOk260R3MVN59lC37nWYxStDLmArZHBwgGWDzXnSkFvoVe+TNUFYJmkNdyaJc6sGQhlr9d0xCtsKXDujOKFz8N/pss/4e2RuaqSdx1lhF9SwVKf7myxwdMTck0/QTnXrkjivrrQu9LSJ1ykquF+vxmJ5ImuaR97aA==
Received: from SA1PR22MB3002.namprd22.prod.outlook.com (2603:10b6:806:235::13)
 by CH4PR22MB5702.namprd22.prod.outlook.com (2603:10b6:610:230::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Sat, 1 Nov
 2025 14:46:46 +0000
Received: from SA1PR22MB3002.namprd22.prod.outlook.com
 ([fe80::8450:a08a:6d99:a9d3]) by SA1PR22MB3002.namprd22.prod.outlook.com
 ([fe80::8450:a08a:6d99:a9d3%5]) with mapi id 15.20.9275.013; Sat, 1 Nov 2025
 14:46:45 +0000
From: Michael Chaffin <mchaffin@21sw.us>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: How do I set cpp_flags for environment text files ? 
Thread-Topic: How do I set cpp_flags for environment text files ? 
Thread-Index: AQHcSzwJcAFZCJHEak+W/7Ergkeeow==
Date: Sat, 1 Nov 2025 14:46:45 +0000
Message-ID: <SA1PR22MB300291D180E67E6D7E209E4ED5F9A@SA1PR22MB3002.namprd22.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=21sw.us;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR22MB3002:EE_|CH4PR22MB5702:EE_
x-ms-office365-filtering-correlation-id: db125d91-84c0-48c5-a2e5-08de19557a94
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|19092799006|38070700021|80162021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?D/GOSDdeRWuh6pCm/Q59Kd4nNia5uAJteifffkrjtzIFqj+ych6OL7Ob16?=
 =?iso-8859-1?Q?KD9hdtsJfH40l/9XGjttUOTOpTUmiBaKoHaQWvzCiH9iQ9ZVji+LZMy2LC?=
 =?iso-8859-1?Q?X8E5nIwSNMzZR0uQgvmjcmltZWxnOVGG9vjppJ+hME+acA27DN5FZdBmgf?=
 =?iso-8859-1?Q?ar8rIYis4yX4PYFYPfWWHr8Ya2r/xgdNeV+/Eus9sgv+HwEvokoe7vxZPO?=
 =?iso-8859-1?Q?HPVqwAtEIs3U+icwZhGFgbFRDpsArdjMkrEp7rsOrVxxdNzFKdxYTs0FNt?=
 =?iso-8859-1?Q?gr12Hqgmz5u116+jECcWSENVs9PFbViFCZ2bHrzHnGa9UbSc3sJYjDl5Fe?=
 =?iso-8859-1?Q?9d3RLpJruXQyy64m7PWZAyPxEEpNsCi+nDIwIQQBcLHWGlMdUTPPPxLA4m?=
 =?iso-8859-1?Q?ZxjoCoz/iC4Yv6lSEeUKVQO+g4qD1rGLvfQ326KicV6M9CnSKRDNELRvp4?=
 =?iso-8859-1?Q?tFQIGslXpvZBjdl2HUJ/9GVSqqN/1H9XvsIiCRIqJDHKytDKckyTBKMn5F?=
 =?iso-8859-1?Q?MNkZ82/wHEyHGkZSWAvnNNOgFqOGPYVWOj4CI/641mF9ZNxOywObAUN8as?=
 =?iso-8859-1?Q?z+xIcwYFrgOsyD3oFfsX9/t/ej2TF3ze3VIPmWC1G1vK5xJd4Uo0bDe6/m?=
 =?iso-8859-1?Q?fQtP5JBzSE2Uld5rs9JIwEIgPPPOLnGeFABK+dcsNB0FsVRA02MnjXLN63?=
 =?iso-8859-1?Q?vszGqqP8s7afJkIbhspaTcbjbKUfjufeX0CSEwoqlFWrQ0mcB7Vx69sVMw?=
 =?iso-8859-1?Q?PTuDteryd13FrxRvNuofg01i956wkEJ19mPP6Hl9XJlJbwIgxit4s5Rg0H?=
 =?iso-8859-1?Q?U4bExNKHa3+eCL3GjDxqz07RH8hPX6lylIIKkVLHJCybUn8J9WAgSqO+R/?=
 =?iso-8859-1?Q?73+n0R94zn3qDrrE6ONAsm8v9Rj2xO+BGOdkFCSJLv570mrsJ/tbj1T17t?=
 =?iso-8859-1?Q?ZsxsFbtdjBDdzs0FKlTfSAXSz7aO3VNT7oqaTjtAVbou/QMIMwr1z+81UT?=
 =?iso-8859-1?Q?v0kL+D00mBiEasuUPtwO9TvBfnYW6Vlwg21k8maIqszFfGU0EfeZdfklDD?=
 =?iso-8859-1?Q?C2TAAMOh7WLb/42BPo8GugsSkRDWk5nPET4iQ5MAT6MQ7etXGi33ij8UMf?=
 =?iso-8859-1?Q?hMLvz062m4K3awOXY6ER2LOtKeyZy1rLGAOLs/JutkgPnQI9YGZ+Xc5LIq?=
 =?iso-8859-1?Q?Noyfi3HNPFP9lTXi/VBKOC4hzlBKcArhZkgCeJ6zrCB+xmAqfAx4zkdj+O?=
 =?iso-8859-1?Q?CZ6J6UffaVq6W2I+C0ttlVS0DSNNK8OvZCNWcrkGM2eF+vqM0J4tjdFXms?=
 =?iso-8859-1?Q?GkEUFUU0aWI0vXsCJvw/bp3R3ewpqzcRJ4tWyC0FthCVBCMNHm4KXQWt5k?=
 =?iso-8859-1?Q?9/IF6yQ8H9JyBGe0XFVbFx/RnIMaa0dYbz6QzSt4VCQ/gm6XscCYCICSnk?=
 =?iso-8859-1?Q?BrTofW5KhhtOkzvMErAbok0FJ+Es1cpKQYiNYJsdLg33dqaX3giMHcTYTj?=
 =?iso-8859-1?Q?rn6nSeeH+u/J+HBqpkTezEmWiarae2oMK4W4PIvAcrdz0JwGPuPMO9hTPz?=
 =?iso-8859-1?Q?5j9+VougtkhSi6vvWcTWR4Eei63O0/uxXxzWbdtvjirEcXlPpw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR22MB3002.namprd22.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(19092799006)(38070700021)(80162021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?DgIHQOzIpkbZecj1mtGd/I6V73u48XyC/Gwi4HZ1/2/pjfbgnVVZ77qZiS?=
 =?iso-8859-1?Q?8xph5g32igOSuIkSMsJi1II8Yqbormi+wBQhn+wwJuX5x2A79tmirlOFJt?=
 =?iso-8859-1?Q?k3Ns8w0mdsZIMLOo+X3H5Kp4mBDmBJJHYT+D1EHE4sjDrOdSSDgdjeDE5H?=
 =?iso-8859-1?Q?pX0xcW2xH7vHkq4MENSBK6E0jUei8y1fYsW7v8u7N7YrhVMx/vljNiQsG+?=
 =?iso-8859-1?Q?lLzVYAwSER2jtUpiawxbFYoFxnQS8yK2LnzzfP07b8Xy+m+5XubHStPKSP?=
 =?iso-8859-1?Q?9+9quSScmam7c5KIvaneQQCn4KHY1D3KR8qmtoRBhptl7oLJiTRM9e+KhJ?=
 =?iso-8859-1?Q?tiketfWOqiZzOC+HyR8m6mvvEHRqZES4WyOa0rYsDcF/QOouzLCZAysRTV?=
 =?iso-8859-1?Q?m2JJ/0oA1JIH+Wf+fAi1lTyB7z4DcpRgbGpn5ConuuaKCoT1L0aweo8pM0?=
 =?iso-8859-1?Q?IRKA2hZle9HU28GBd5GGiczG2S5/d+YDajDeTLbzSu4P7H0RbNoE4bloVH?=
 =?iso-8859-1?Q?oKL9r5zZCvkpmBLxo4ZNglHoD0F924m1BZNbVBAdJ1S+FjtX8MgEqooJ1o?=
 =?iso-8859-1?Q?Rffd1hCKFm96Zc8ZadYpJPm50IKkV26KOWZcB0II5H91xUsF/x4zuq4PgT?=
 =?iso-8859-1?Q?afHTgqKZ2vFdWZvNiBUrw3cU5hzJiizQePIq4rCRwquiQguobdsh2DXV2d?=
 =?iso-8859-1?Q?GLSLsZwATnw/Gf/dYmeRRJ0adUBtntuqycwTNG3NJUbvFOBig5mGroUaRF?=
 =?iso-8859-1?Q?NkL5pTfaFCC6Ep3Yg4zVgSGG8703WjMEzeiIWLEMx8HeaZPaRs5K1xj2cf?=
 =?iso-8859-1?Q?i2ZKIeWkK9QeTu6EYaJOrbLGhSmFXJwoLhXBJAaaqKA2hnt4DaAGlWUJJl?=
 =?iso-8859-1?Q?lSg9y7MsXeEvDyp5usjJaWbIcuqe1JqMkDw4ntyJBH40YDE3E2RRcwwbFV?=
 =?iso-8859-1?Q?N8TKbUmjbwjxdHMTkv00h8VtuNNJDEB/k1iWkwiJuqGXjUiYBp9KuIES27?=
 =?iso-8859-1?Q?JZoLnoMCFMn1sZRWrApH4Kzf2sE5I4OnH3tKw3wYhVpV1gbHpMpcufPhtY?=
 =?iso-8859-1?Q?z0ArvAG+wu9EKMAxD4goDJjdvEnGXjzgOkkyawbe4GJ7dUxlH83kA6WRd1?=
 =?iso-8859-1?Q?BB3t8QnxLKVG9NRh0G2G5crQgVlDUGhNLTRCUolEXXwVzZ0Ds/Pjytr7CF?=
 =?iso-8859-1?Q?Q82TeS9FM/VS5RSIGNgnj8jmsbpPze5l6fpVAJ/yTjK+ZzOGEHoLAdKXVx?=
 =?iso-8859-1?Q?YQLS2BZXJ4ia24fUF/RwmndPzwP0fj6uPRcyxH/mMWWteIuIdQn6IbqZEG?=
 =?iso-8859-1?Q?IlkDraauRqy4bxTxbbVT/TyRSBAKsULaDm5B2VgPT/HEFDQrhOv3hn1KfT?=
 =?iso-8859-1?Q?8YPG+d+dwoLx9nFJgOdzunlrYMb7BaY0U1UiEChEhqDcLGwX0tsvy0BKgK?=
 =?iso-8859-1?Q?4wDAx6P5NjJ2wLW3XP+Jmi0BkcGBvlHmZqUvIN9vNAOKG368JoIX8LuYiK?=
 =?iso-8859-1?Q?TUuAmQIzC18XfdnvcSb+LZ2uIBY8Oxww2zKcb39DsZE9twssn7iHyjI/t3?=
 =?iso-8859-1?Q?eVnzSu1s61kFkXHt/uNHQpB74/19yCnIeJwOo37TJwOkfQuT595yoPEiyG?=
 =?iso-8859-1?Q?xM26HOYj6H20s=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: 21sw.us
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR22MB3002.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db125d91-84c0-48c5-a2e5-08de19557a94
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2025 14:46:45.2238 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5f4ac144-0fc5-4d2d-b796-d7cf051f555a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0/ebpafZLp30pe9HaTC3v9bEVKS6nZODnNFZiZ+v0GlfB5Y++MrDb12JyKOH4K0b6vEntdFHzGwKH6wUgnz85w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR22MB5702
X-Mailman-Approved-At: Sat, 01 Nov 2025 16:15:06 +0100
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

I am trying to understand a change to the u-boot, Makefile from last year, =
10 Aug 2024 as commit 0x2956a84 ; The change commit messages says don't use=
 CFLAGS for environment text files. I am unsure of how to properly set the =
Makefile variable 'cpp_flags' when compiling u-boot for the RaspberryPi5 ? =
Now when compiling for Pi5 I get the following error,=A0=0A=
=0A=
 =A0 ENVP =A0 =A0include/generated/env.in=0A=
| cc1: warning: unknown register name: x18=0A=
| cc1: error: bad value ('armv8-a+crc') for '-march=3D' switch=0A=
| cc1: note: valid arguments to '-march=3D' switch are: nocona core2 nehale=
m corei7 westmere sandybridge corei7-avx ivybridge core-avx-i haswell core-=
avx2 broadwell skylake skylake-avx512 cannonlake icelake-client rocketlake =
icelake-server cascadelake tigerlake cooperlake sapphirerapids alderlake bo=
nnell at=0A=
| make: *** [Makefile:1877: include/generated/env.in] Error 1=0A=
| WARNING: exit code 2 from a shell command.=0A=
=0A=
Micheal S. Chaffin=A0=0A=
Principal Software Engineer=0A=
21 Software=
