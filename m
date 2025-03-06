Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A226C282D1
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 11:52:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79FD580F9E;
	Thu,  6 Mar 2025 12:52:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=br-automation.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=br-automation.com header.i=@br-automation.com header.b="HJ+ejfor";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08897810DC; Thu,  6 Mar 2025 12:52:39 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D96A80756
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 12:52:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=br-automation.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=bernhard.messerklinger@br-automation.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=drmx1Htr29vowVEtznvD7ts/opeNWeVvF2t6GPxDbV2XaA5PItp3vdYaXgHxorfdgipcFB7lcAiq583WelhA4EdsGOBr8w8v6uWe7/cuLarMCLEANRBb1kJyOZE8jGRnvdoKZJxVF+nY3hRA992HPLG8c+XBvvL6U9oJuBtVg3CjyLXRFNcrebuT9dmFZCYcE5YPLJBbxE495oFqWWrn4PjwveyxE6NvDvYq2+ZUT1R/MqRWDCrJ8md2stznrWqQ82pvbQ752jPENKlMU4XA4/+2GHEiL+I8niQAshaWkGoQTXfEQLQkTLIuU3Y9qSs9O0B/WcGEAZ+UCsSfka5u/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ys+XeQ3Py3oEIAo4pDQbQgR1+Vqwc0WV9KCN3tz5eVU=;
 b=ikm4/374GuVdLDec8lH7jU0438Ug7L8yRSdVbGMGPCDiwhG3O/+bwkaUVVipgKDK8MILyv9i+SZ+u+9br06swCIVj6MDyfUyJteG2Hi4VBctWyKugnNH42lWIaWm1YH5PZqkjvUbGXXdxwXsM1XHH4CG5LBnXdjIeix7Wkqas92UczssaAf47ihpylWMGdGMdqWcRhIYayZo4apCvl4MqzvlhcGwGY6md+GbCorpHYCtHLttMnk+B3l8DqXXOhcnVbZcm5fdz7jUb4GBUh/AYaiM9DgbwQg4qFKH1m1X85zhBXFtWR3YIlyuNrrLnEj1q03wOlT+YC+EtTCVmPNzPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=br-automation.com; dmarc=pass action=none
 header.from=br-automation.com; dkim=pass header.d=br-automation.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=br-automation.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ys+XeQ3Py3oEIAo4pDQbQgR1+Vqwc0WV9KCN3tz5eVU=;
 b=HJ+ejforgD0fYiX+/1JEcrwTShcNFaS9e86WXJLIWmxSn0RYTlU/GuAUMw66WOMZ3m2TXlGLKqDKwRpAnX6PRpqksQaGpuL5ynm3Pd1RVf4YJKnXwb4GpYjyx5SizjIvLr77wAp/nfarUUGRg6IzTpNFCgjXKl8XBAt236bwEV8geN0zWPina3o4crkSbcPS18ATmPfOnz/j13jWldECUzrdBNx0Pfgg0Vt4ITOea8imCe3AcM1AC8crLuFM6Q66U5qJjgUiyVtNu8GFLp/ajAg+v2VFMubDpMxoTHY6Re7EX+cyCiMhnAaSXkiXrTtIyS5vaInbajsbzSEX/c0z7g==
Received: from DB9PR06MB8559.eurprd06.prod.outlook.com (2603:10a6:10:369::16)
 by AM7PR06MB6549.eurprd06.prod.outlook.com (2603:10a6:20b:121::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Thu, 6 Mar
 2025 11:52:32 +0000
Received: from DB9PR06MB8559.eurprd06.prod.outlook.com
 ([fe80::eaeb:257b:4131:652]) by DB9PR06MB8559.eurprd06.prod.outlook.com
 ([fe80::eaeb:257b:4131:652%5]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 11:52:32 +0000
From: Bernhard Messerklinger <bernhard.messerklinger@br-automation.com>
To: Michal Simek <michal.simek@amd.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: Adam Ford <aford173@gmail.com>, Andre Przywara <andre.przywara@arm.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, Fabio Estevam <festevam@denx.de>, 
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Neil Armstrong
 <neil.armstrong@linaro.org>, Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Prasad Kummari <prasad.kummari@amd.com>, Sumit Garg <sumit.garg@linaro.org>,
 Tom Rini <trini@konsulko.com>, Tony Dinh <mibodhi@gmail.com>, Wolfgang
 Wallner <wolfgang.wallner@br-automation.com>
Subject: Re: [PATCH v2 4/4] board/BuR/zynq: initial commit
Thread-Topic: [PATCH v2 4/4] board/BuR/zynq: initial commit
Thread-Index: AQHbfIOC0wep50vKUUy8BBnI1GNVibNZd9+AgAyRbcKAAASggIAAEQ3g
Date: Thu, 6 Mar 2025 11:52:32 +0000
Message-ID: <DB9PR06MB85594C77AE8EE6D9D5DD70D7D2CA2@DB9PR06MB8559.eurprd06.prod.outlook.com>
References: <20250211124957.104907-1-bernhard.messerklinger@br-automation.com>
 <20250211124957.104907-5-bernhard.messerklinger@br-automation.com>
 <de79214c-088e-4554-9e40-b8fce677bf3a@amd.com>
 <DB9PR06MB855954FEBC17BC680E24CAB2D2CA2@DB9PR06MB8559.eurprd06.prod.outlook.com>
 <7d3b9a41-59a2-48c9-a0bf-846890642709@amd.com>
In-Reply-To: <7d3b9a41-59a2-48c9-a0bf-846890642709@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d792d246-d363-40e2-82bc-6f0655128b68_Enabled=True;
 MSIP_Label_d792d246-d363-40e2-82bc-6f0655128b68_SiteId=372ee9e0-9ce0-4033-a64a-c07073a91ecd;
 MSIP_Label_d792d246-d363-40e2-82bc-6f0655128b68_SetDate=2025-03-06T11:52:32.084Z;
 MSIP_Label_d792d246-d363-40e2-82bc-6f0655128b68_Name=Internal;
 MSIP_Label_d792d246-d363-40e2-82bc-6f0655128b68_ContentBits=0;
 MSIP_Label_d792d246-d363-40e2-82bc-6f0655128b68_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=br-automation.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR06MB8559:EE_|AM7PR06MB6549:EE_
x-ms-office365-filtering-correlation-id: bad592be-9373-4811-48ce-08dd5ca56131
x-abb-o365-outbound: ABBOUTBOUND1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?GWVcA9KHgeNi5QC33tyhYFhS8BbvggadO4pRbbmtDxfAyf7ne0LMwhUh2v?=
 =?iso-8859-1?Q?7bygI9LUWVMI+Wo9kQVk+ZZrPy2Jsnyaquf9ZCB7gtzqCsh3O7yItTD1Et?=
 =?iso-8859-1?Q?i99j+RB44aC8WaQuIdozRaTBsay+Z+LOlWUm1nIfTWDcVOEUA3HE1KKRg+?=
 =?iso-8859-1?Q?O8ZEZSBChRPoeczdmYefgPgOTLxhwaP/1vBRcZodVhY+NB3gHeIwY1bqhF?=
 =?iso-8859-1?Q?qhAYz1kKe9WnriuF+uneUdfQDroKHbQ7eytQ2r8IYOnZJE0vE1O3d77kFj?=
 =?iso-8859-1?Q?WnB0SpAZmLCJmNzuhelcwRcLMM+xkeeG/46+k0/4TbgL1R/9+G8CjncScp?=
 =?iso-8859-1?Q?MLGTKD3yX27NCrNpz4dREIqjjxB8DggzJW2mXAIP4o/YuVc6DfYzj/JIU+?=
 =?iso-8859-1?Q?Rdxbm9D/FfnN+bq1XkxiKy0LxyJ7pFRKSQP2RFn+06PH8udOIJrvRqNmv2?=
 =?iso-8859-1?Q?MLxBTCJSycKy8UrrzdOnOICozepd3IYQquEKskitAsvFE3y0YZ0xMejtlY?=
 =?iso-8859-1?Q?EkAU7wtOqr5UZRmrYu1c98omU27wTRdtAkdHdcv6JQ7akTCifPx1k5dJY5?=
 =?iso-8859-1?Q?ysO92A9VseVWpdoRn+gE5HkTxg7izcdPITXysGlOFlRH31hKyveaKQmytL?=
 =?iso-8859-1?Q?ZMJm+8DOIgkSZSbOcS0fnJNwFlfSmp5/6rL6quvBEx4J6wHyLasB25w1JX?=
 =?iso-8859-1?Q?Ijor3AK0JwwYU0DzC0iLHK7LyqAwYrodiM7BwaYCEcllxrPluVuCAbT5R3?=
 =?iso-8859-1?Q?InzbNS0Bw10KWMLQQiwEWWkVNynn4gH003oEF3vPLTuaANv6+RXEmsdzwE?=
 =?iso-8859-1?Q?C3YgiGPeBDDCnN/W4mUhm38MWohqpRJbwuQkhETCYZ1WS4dKo7uHfBvAh+?=
 =?iso-8859-1?Q?qSfqHfwe/UznQH203fqdHb8T8zQuehUnfoqMRBJ0tKZqVnH7Rded62ckzD?=
 =?iso-8859-1?Q?WptNgkT9EXjGwjpeb7G9mfbLW8sAezajM1T2pjgizdYP8NKUiNXvu/GoZl?=
 =?iso-8859-1?Q?2whMQ6D8GXm+QzskevUAjZ4ptJM4+psRmJACGNQ9UQ1v7UwJ7a65wH6KrT?=
 =?iso-8859-1?Q?AGdeU/9k4WQk3ujwz7tKJD4gyXG0idq8vbXIFpR7U2ZRPFuG+xRqs7EIW6?=
 =?iso-8859-1?Q?9w3t2roSjWF/rD5XAITavGt3Dv4fFTaP/ZI/eHiA4kJKP7rVWlYTP7LN+w?=
 =?iso-8859-1?Q?qg1BiEU0hyFyECtPnUdXc5O8nDUVOt8kf4voVC/CTQJQmmVXbUCmFibe4f?=
 =?iso-8859-1?Q?WxC6rKZwe7hz2ZgmyLtCaNZPEtuwI1hAml5PzEJQFHYOze4IN34/WAQ9mP?=
 =?iso-8859-1?Q?kz9iRqky+YbIXRjT7Hcyh8YlRPmzbnD61xnz5UDTpoR0EEOa6kjzFgEkB0?=
 =?iso-8859-1?Q?Avu1p5dM8/Ce7zzCdBYmq5yg25EkyVLBhTTRHb8/5u09lwbwFEI6Ujr5OH?=
 =?iso-8859-1?Q?LuHMBgF7qVq3FM8MQK0pc6mGiNYZQjSkHWShGFntt0j60PmR9SFh1dsCr9?=
 =?iso-8859-1?Q?ELZGVk7kwIbXI3VTnknkNt?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR06MB8559.eurprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?90zAXdXKpBo5Od0mOSkH5lnBfsGcruCD2qB/Mq11g4bL+Mex0qgRxvuN5h?=
 =?iso-8859-1?Q?yJCC6YeHWq2WAg+qQ4189b2Tx5XC9gOhUstzykUkc7ZbvhdQvlfyRXKI4y?=
 =?iso-8859-1?Q?xEv7SNSmHe+pVgh7r+ztMGUiwdQjZRJ24vpN0/C5Mm6F9LQmLpxRYlXkB/?=
 =?iso-8859-1?Q?aNcxnTyLBXtdHtXbqtT34mfX8lOt8WkLDilaFHyMP3daSjgs80+00OVZV2?=
 =?iso-8859-1?Q?rOHbcTUJ9ZBYKP53ZL5s1p9kdn+wglGKxRpGywDeeBGgfYJbWodCA9aHKz?=
 =?iso-8859-1?Q?hz+HKkbCy6Je+3kPVdpENv1SSHygV2tKFZfVcGIR6R6zgNOty0qfWfvgy0?=
 =?iso-8859-1?Q?+ulNeEJC8pZMfURscY19ZD60ofEDqK0vc4SYvGVYpALl9akWtV5TB+9rUy?=
 =?iso-8859-1?Q?g+kGmWY8FRhpOKMJh0HZV67BxOpa/0ddfw47xgBjE0W3Dv/6icXlP9N6Je?=
 =?iso-8859-1?Q?VDfJ2Xc1B59kNo8hsYoBTyMW6EMn7LRy8wrcC95ZN+80NNwu3wbjhilMEC?=
 =?iso-8859-1?Q?nP081UhAagZq0npN2YODm4GDi8tnP3WnJhwa+Op90qOnXrcc5Q607ipKzg?=
 =?iso-8859-1?Q?y7woJYuTLKGxfhyg/7t8L6RiiL+xRs7Z4aQsrY0Y3B+ujvTQhnNHI41Efa?=
 =?iso-8859-1?Q?yjBr4R81LbStL8PQ3lbbxl6KF8U5rsjoNdVeRAp3oXvOTEtYK8sMQNmSkP?=
 =?iso-8859-1?Q?y0iIwGm2BKwrlQZ+yRXoBSPet80+gqL3fm1WbeuylelXiHR72nQGJNjXup?=
 =?iso-8859-1?Q?5GbHLwxAZYgDoXCpH1E1m8LqeqwnbroOdG5YhyiY0GDim5Q0kV7Lgzgf7N?=
 =?iso-8859-1?Q?NmDBc1xfvPnunoL/kVj6qjVFnAk62VDQxc0nSzr7xKNMy4s9tfYgplXGaL?=
 =?iso-8859-1?Q?Ptk9ePI4vPAJbIzrty+aCD1vZDgcya+uNJs7TF4QOXhjXjBcc/5uipcWpM?=
 =?iso-8859-1?Q?xHEVYK3GoGDabetJMP7uFHUXuyQny3gYFGWlSNvCHzwOLE70qVxk61LtJ6?=
 =?iso-8859-1?Q?er8P8v5qZg8PjdBtFm1brCDlmfXPZ5GoiitudWDVTDXx9r7zhiQsbbW0Cy?=
 =?iso-8859-1?Q?nqkpo1ZTVYU8kRnPq7+dZEgyV7XVA7QLWTOFThu48qs6EIsg/EiC4BmABS?=
 =?iso-8859-1?Q?nS1qLmQ1sc4pRXiKH5kIb9lhhogJT25SrCXdGJx6N76M3J85Ys9HgYRJMd?=
 =?iso-8859-1?Q?yneVCM4NPgVcLmJIUFzFtAyP0rp3jsg+ha2cNw37OLF7dfqASm2ngzuMec?=
 =?iso-8859-1?Q?N5MBIhi8G+51WLKt2/Ik0xq2hnhr/NF/LM9z7hb5m/ZkURsGP1NcOL1MTX?=
 =?iso-8859-1?Q?DvCqUp9ca+VR+/SxHmwLHadmhXchHCLIj6qgbqDyLEEbSlNe8e9QpfIo2K?=
 =?iso-8859-1?Q?5mr5qWfB6ME/96Rf5cXU2qHbs+wxjYr1yIANFPqWb5+k1Cmd5dv4OzHxGl?=
 =?iso-8859-1?Q?HxcAfw0t9V/QVQhz/D6b9+vTq76Cg8v07kCPCvEqVt2fIkGlmkQIKdxakr?=
 =?iso-8859-1?Q?ojVjrGpyW6dUt0VBTA3swyKJ94NQCvPkto4rVaOaSGbsp6hfV+33/RFfYl?=
 =?iso-8859-1?Q?kNyqIlOm+5mKNvIfST84yiU+8THpLu+8sxSTFhEtr/DYsG3Aw1Sil31vSk?=
 =?iso-8859-1?Q?KylMwmbb6Mol4ewZLKsgWAnEGo/MmW7il4cG/UmM8LfFWK9IB8ciT6dlJv?=
 =?iso-8859-1?Q?dp6LkBWQ/KsAGWCgN/I=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: br-automation.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR06MB8559.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bad592be-9373-4811-48ce-08dd5ca56131
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2025 11:52:32.5865 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 372ee9e0-9ce0-4033-a64a-c07073a91ecd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b3kyF2iOml4JNZEYQMAUdp5vMkmpfDHEbCoVFCbncK21NA105OnWGgLRhEkx2SV/UnHgFF8G1YInvNEC7s4tQB1CCNLX5ANoPb4KWS9XE2ti1UmOICX9IkmUuSOHb+56WzxBnWHTnjRHHc/02fzR0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR06MB6549
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

=0A=
From:=A0Michal Simek <michal.simek@amd.com>=0A=
Sent:=A0Thursday, March 6, 2025 11:35 AM=0A=
>On 3/6/25 11:20, Bernhard Messerklinger wrote:=0A=
>> From: Michal Simek <michal.simek@amd.com>=0A=
>> Sent: Wednesday, February 26, 2025 11:23 AM=0A=
>>> On 2/11/25 13:49, Bernhard Messerklinger wrote:=0A=
>>>> This commit adds support for the brcp1, brsmarc2, brcp150 and brcp170=
=0A=
>>>> boards. This boards are based on the Xilinx Zynq SoC.=0A=
>>>>=0A=
>>>> Signed-off-by: Bernhard Messerklinger <bernhard.messerklinger@br-autom=
ation.com>=0A=
>>>> ---=0A=
>>>>=0A=
>>>> Changes in v2:=0A=
>>>> - Remove all unnecessary device-tree entries=0A=
>>>> - Reviewed led names (no pattern restriction found)=0A=
>>>> - Fix maintainers file=0A=
>>>> - Cleanup of code=0A=
>>>> - Move preboot variable to env file=0A=
>>>>=0A=
>>>>=A0=A0=A0 arch/arm/dts/Makefile=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0 8 +-=0A=
>>>>=A0=A0=A0 arch/arm/dts/zynq-brcp1-u-boot.dtsi=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 | 110 +++++++=0A=
>>>>=A0=A0=A0 arch/arm/dts/zynq-brcp1.dtsi=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 | 133 +++++++++=0A=
>>>>=A0=A0=A0 arch/arm/dts/zynq-brcp150-u-boot.dtsi=A0=A0=A0=A0=A0=A0=A0=A0=
 | 129 ++++++++=0A=
>>>>=A0=A0=A0 arch/arm/dts/zynq-brcp150.dts=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 | 174 +++++++++++=0A=
>>>>=A0=A0=A0 arch/arm/dts/zynq-brcp170-u-boot.dtsi=A0=A0=A0=A0=A0=A0=A0=A0=
 | 113 +++++++=0A=
>>>>=A0=A0=A0 arch/arm/dts/zynq-brcp170.dts=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 | 140 +++++++++=0A=
>>>>=A0=A0=A0 arch/arm/dts/zynq-brcp1_1r.dts=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 |=A0 29 ++=0A=
>>>>=A0=A0=A0 arch/arm/dts/zynq-brcp1_1r_switch.dts=A0=A0=A0=A0=A0=A0=A0=A0=
 |=A0 30 ++=0A=
>>>>=A0=A0=A0 arch/arm/dts/zynq-brcp1_2r.dts=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 |=A0 22 ++=0A=
>>>>=A0=A0=A0 arch/arm/dts/zynq-brsmarc2-u-boot.dtsi=A0=A0=A0=A0=A0=A0=A0 |=
 110 +++++++=0A=
>>>>=A0=A0=A0 arch/arm/dts/zynq-brsmarc2.dts=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 | 158 ++++++++++=0A=
>>>>=A0=A0=A0 arch/arm/mach-zynq/Kconfig=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0 1 +=0A=
>>>>=A0=A0=A0 board/BuR/zynq/Kconfig=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0 14 +=0A=
>>>>=A0=A0=A0 board/BuR/zynq/MAINTAINERS=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 |=A0 11 +=0A=
>>>>=A0=A0=A0 board/BuR/zynq/Makefile=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0 15 +=0A=
>>>>=A0=A0=A0 board/BuR/zynq/brcp150/board.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 |=A0=A0 4 +=0A=
>>>>=A0=A0=A0 board/BuR/zynq/brcp150/ps7_init_gpl.c=A0=A0=A0=A0=A0=A0=A0=A0=
 | 278 ++++++++++++++++++=0A=
>>>>=A0=A0=A0 board/BuR/zynq/brcp170/board.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 |=A0=A0 4 +=0A=
>>>>=A0=A0=A0 board/BuR/zynq/brcp170/ps7_init_gpl.c=A0=A0=A0=A0=A0=A0=A0=A0=
 | 274 +++++++++++++++++=0A=
>>>>=A0=A0=A0 board/BuR/zynq/brcp1_1r/board.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 |=A0=A0 4 +=0A=
>>>>=A0=A0=A0 board/BuR/zynq/brcp1_1r/ps7_init_gpl.c=A0=A0=A0=A0=A0=A0=A0 |=
 274 +++++++++++++++++=0A=
>>>>=A0=A0=A0 board/BuR/zynq/brcp1_1r_switch/board.c=A0=A0=A0=A0=A0=A0=A0 |=
=A0=A0 4 +=0A=
>>>>=A0=A0=A0 board/BuR/zynq/brcp1_1r_switch/ps7_init_gpl.c | 270 +++++++++=
++++++++=0A=
>>>>=A0=A0=A0 board/BuR/zynq/brcp1_2r/board.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 |=A0=A0 4 +=0A=
>>>>=A0=A0=A0 board/BuR/zynq/brcp1_2r/ps7_init_gpl.c=A0=A0=A0=A0=A0=A0=A0 |=
 277 +++++++++++++++++=0A=
>>>>=A0=A0=A0 board/BuR/zynq/brsmarc2/board.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 |=A0 30 ++=0A=
>>>>=A0=A0=A0 board/BuR/zynq/brsmarc2/ps7_init_gpl.c=A0=A0=A0=A0=A0=A0=A0 |=
 276 +++++++++++++++++=0A=
>>>>=A0=A0=A0 board/BuR/zynq/common/board.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 | 231 +++++++++++++++=0A=
>>>>=A0=A0=A0 board/BuR/zynq/env/brcp1.env=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 | 109 +++++++=0A=
>>>>=A0=A0=A0 board/BuR/zynq/env/brcp150.env=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 | 119 ++++++++=0A=
>>>>=A0=A0=A0 configs/brcp150_defconfig=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 | 123 ++++++++=0A=
>>>>=A0=A0=A0 configs/brcp170_defconfig=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 | 122 ++++++++=0A=
>>>>=A0=A0=A0 configs/brcp1_1r_defconfig=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 | 122 ++++++++=0A=
>>>>=A0=A0=A0 configs/brcp1_1r_switch_defconfig=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 | 123 ++++++++=0A=
>>>>=A0=A0=A0 configs/brcp1_2r_defconfig=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 | 122 ++++++++=0A=
>>>>=A0=A0=A0 configs/brsmarc2_defconfig=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 | 122 ++++++++=0A=
>>>>=A0=A0=A0 include/configs/brzynq.h=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0 21 ++=0A=
>>>>=A0=A0=A0 38 files changed, 4109 insertions(+), 1 deletion(-)=0A=
>>>>=A0=A0=A0 create mode 100644 arch/arm/dts/zynq-brcp1-u-boot.dtsi=0A=
>>>>=A0=A0=A0 create mode 100644 arch/arm/dts/zynq-brcp1.dtsi=0A=
>>>>=A0=A0=A0 create mode 100644 arch/arm/dts/zynq-brcp150-u-boot.dtsi=0A=
>>>>=A0=A0=A0 create mode 100644 arch/arm/dts/zynq-brcp150.dts=0A=
>>>>=A0=A0=A0 create mode 100644 arch/arm/dts/zynq-brcp170-u-boot.dtsi=0A=
>>>>=A0=A0=A0 create mode 100644 arch/arm/dts/zynq-brcp170.dts=0A=
>>>>=A0=A0=A0 create mode 100644 arch/arm/dts/zynq-brcp1_1r.dts=0A=
>>>>=A0=A0=A0 create mode 100644 arch/arm/dts/zynq-brcp1_1r_switch.dts=0A=
>>>>=A0=A0=A0 create mode 100644 arch/arm/dts/zynq-brcp1_2r.dts=0A=
>>>>=A0=A0=A0 create mode 100644 arch/arm/dts/zynq-brsmarc2-u-boot.dtsi=0A=
>>>>=A0=A0=A0 create mode 100644 arch/arm/dts/zynq-brsmarc2.dts=0A=
>>>>=A0=A0=A0 create mode 100644 board/BuR/zynq/Kconfig=0A=
>>>>=A0=A0=A0 create mode 100644 board/BuR/zynq/MAINTAINERS=0A=
>>>>=A0=A0=A0 create mode 100644 board/BuR/zynq/Makefile=0A=
>>>>=A0=A0=A0 create mode 100644 board/BuR/zynq/brcp150/board.c=0A=
>>>>=A0=A0=A0 create mode 100644 board/BuR/zynq/brcp150/ps7_init_gpl.c=0A=
>>>>=A0=A0=A0 create mode 100644 board/BuR/zynq/brcp170/board.c=0A=
>>>>=A0=A0=A0 create mode 100644 board/BuR/zynq/brcp170/ps7_init_gpl.c=0A=
>>>>=A0=A0=A0 create mode 100644 board/BuR/zynq/brcp1_1r/board.c=0A=
>>>>=A0=A0=A0 create mode 100644 board/BuR/zynq/brcp1_1r/ps7_init_gpl.c=0A=
>>>>=A0=A0=A0 create mode 100644 board/BuR/zynq/brcp1_1r_switch/board.c=0A=
>>>>=A0=A0=A0 create mode 100644 board/BuR/zynq/brcp1_1r_switch/ps7_init_gp=
l.c=0A=
>>>>=A0=A0=A0 create mode 100644 board/BuR/zynq/brcp1_2r/board.c=0A=
>>>>=A0=A0=A0 create mode 100644 board/BuR/zynq/brcp1_2r/ps7_init_gpl.c=0A=
>>>>=A0=A0=A0 create mode 100644 board/BuR/zynq/brsmarc2/board.c=0A=
>>>>=A0=A0=A0 create mode 100644 board/BuR/zynq/brsmarc2/ps7_init_gpl.c=0A=
>>>>=A0=A0=A0 create mode 100644 board/BuR/zynq/common/board.c=0A=
>>>>=A0=A0=A0 create mode 100644 board/BuR/zynq/env/brcp1.env=0A=
>>>>=A0=A0=A0 create mode 100644 board/BuR/zynq/env/brcp150.env=0A=
>>>>=A0=A0=A0 create mode 100644 configs/brcp150_defconfig=0A=
>>>>=A0=A0=A0 create mode 100644 configs/brcp170_defconfig=0A=
>>>>=A0=A0=A0 create mode 100644 configs/brcp1_1r_defconfig=0A=
>>>>=A0=A0=A0 create mode 100644 configs/brcp1_1r_switch_defconfig=0A=
>>>>=A0=A0=A0 create mode 100644 configs/brcp1_2r_defconfig=0A=
>>>>=A0=A0=A0 create mode 100644 configs/brsmarc2_defconfig=0A=
>>>>=A0=A0=A0 create mode 100644 include/configs/brzynq.h=0A=
>>>>=0A=
>>>> diff --git a/arch/arm/dts/zynq-brcp1.dtsi b/arch/arm/dts/zynq-brcp1.dt=
si=0A=
>>>> new file mode 100644=0A=
>>>> index 00000000000..f1cf75f1277=0A=
>>>> --- /dev/null=0A=
>>>> +++ b/arch/arm/dts/zynq-brcp1.dtsi=0A=
>>>> @@ -0,0 +1,133 @@=0A=
>>>> +// SPDX-License-Identifier: GPL-2.0+=0A=
>>>> +/*=0A=
>>>> + * Copyright 2024 B&R Industrial Automation GmbH=0A=
>>>> + */=0A=
>>>> +=0A=
>>>> +/include/ "zynq-7000.dtsi"=0A=
>>>> +#include <dt-bindings/gpio/gpio.h>=0A=
>>>> +=0A=
>>>> +/ {=0A=
>>>> +=A0=A0=A0=A0 model =3D "BRCP1 CPU";=0A=
>>>> +=A0=A0=A0=A0 compatible =3D "br,cp1",=0A=
>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "xlnx,zynq-7000";=
=0A=
>>>> +=0A=
>>>> +=A0=A0=A0=A0 aliases {=0A=
>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 i2c0 =3D &i2c0;=0A=
>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 serial0 =3D &uart0;=0A=
>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 spi0 =3D &qspi;=0A=
>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 mmc0 =3D &sdhci0;=0A=
>>>> +=A0=A0=A0=A0 };=0A=
>>>> +=0A=
>>>> +=A0=A0=A0=A0 memory {=0A=
>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 device_type =3D "memory";=0A=
>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 reg =3D <0x0 0x40000000>;=0A=
>>>> +=A0=A0=A0=A0 };=0A=
>>>> +=0A=
>>>> +=A0=A0=A0=A0 chosen {=0A=
>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 stdout-path =3D "serial0:115200n=
8";=0A=
>>>> +=A0=A0=A0=A0 };=0A=
>>>> +=0A=
>>>> +=A0=A0=A0=A0 usb_phy0: phy0 {=0A=
>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 compatible =3D "usb-nop-xceiv";=
=0A=
>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 #phy-cells =3D <0>;=0A=
>>>> +=A0=A0=A0=A0 };=0A=
>>>> +=0A=
>>>> +=A0=A0=A0=A0 brd_rst: board_reset {=0A=
>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 compatible =3D "br,board-reset";=
=0A=
>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 pin =3D <&gpio0 9 GPIO_ACTIVE_HI=
GH>;=0A=
>>>> +=A0=A0=A0=A0 };=0A=
>>>> +=0A=
>>>> +=A0=A0=A0=A0 leds {=0A=
>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 compatible =3D "gpio-leds";=0A=
>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 se_green {=0A=
>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 label =
=3D "S_E_GREEN";=0A=
>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 gpios =
=3D <&ledgpio 0 GPIO_ACTIVE_LOW>;=0A=
>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 default-=
state =3D "off";=0A=
>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 };=0A=
>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 se_red {=0A=
>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 label =
=3D "S_E_RED";=0A=
>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 gpios =
=3D <&ledgpio 1 GPIO_ACTIVE_LOW>;=0A=
>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 default-=
state =3D "off";=0A=
>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 };=0A=
>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 rdy_f_yellow {=0A=
>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 label =
=3D "RDY_F_YELLOW";=0A=
>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 gpios =
=3D <&ledgpio 2 GPIO_ACTIVE_LOW>;=0A=
>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 default-=
state =3D "off";=0A=
>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 };=0A=
>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 re_green {=0A=
>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 label =
=3D "R_E_GREEN";=0A=
>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 gpios =
=3D <&ledgpio 3 GPIO_ACTIVE_LOW>;=0A=
>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 default-=
state =3D "off";=0A=
>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 };=0A=
>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 re_red {=0A=
>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 label =
=3D "R_E_RED";=0A=
>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 gpios =
=3D <&ledgpio 4 GPIO_ACTIVE_HIGH>;=0A=
>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 default-=
state =3D "off";=0A=
>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 };=0A=
>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 plk_se_green {=0A=
>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 label =
=3D "PLK_S_E_GREEN";=0A=
>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 gpios =
=3D <&ledgpio 5 GPIO_ACTIVE_LOW>;=0A=
>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 default-=
state =3D "off";=0A=
>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 };=0A=
>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 eth_se_green {=0A=
>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 label =
=3D "ETH_S_E_GREEN";=0A=
>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 gpios =
=3D <&ledgpio 6 GPIO_ACTIVE_LOW>;=0A=
>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 default-=
state =3D "off";=0A=
>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 };=0A=
>>>> +=A0=A0=A0=A0 };=0A=
>>>> +};=0A=
>>>> +=0A=
>>>> +#include "zynq-brcp1-u-boot.dtsi"=0A=
>>>=0A=
>>>=0A=
>>> Why? It should be added automatically when you run build.=0A=
>>=0A=
>> This is not case for me since I have 3 base device-trees:=0A=
>> zynq-brcp1_1r.dts=0A=
>> zynq-brcp1_1r_switch.dts=0A=
>> zynq-brcp1_2r.dts=0A=
>>=0A=
>> This device-trees include the same base file zynq-brcp1.dtsi.=0A=
>> The file zynq-brcp1-u-boot.dtsi is needed in all 3 of the above files.=
=0A=
>> But the zynq-brcp1.dtsi file naming doesn't trigger the automatic includ=
e of the=0A=
>> zynq-brcp1-u-boot.dtsi file.=0A=
>>=0A=
>> My approach is to include zynq-brcp1-u-boot.dtsi manually.=0A=
>>=0A=
>> Also I don't think it is a good idea to create 5 u-boot dtb files:=0A=
>> zynq-brcp1_1r-u-boot.dtsi=0A=
>> zynq-brcp1_1r_switch-u-boot.dtsi=0A=
>> zynq-brcp1_2r-u-boot.dtsi=0A=
>>=0A=
>> Perhaps you have a better suggestion for this problem?=0A=
>=0A=
>pretty much bootp-all can go to your standard files. It is the part of dt-=
schema=0A=
>for a while now that's why don't need to keep it in u-boot.dtsi only file.=
=0A=
>=0A=
>And then you have only binman part. You are not adding fdtmap to binman th=
at's=0A=
>why I think map is not added to binary itself and you have only descriptio=
n in=0A=
>DT. I am using CONFIG_BINMAN_DTB and if you don't need to have binman node=
 on=0A=
>your target you can use it too. Then you can simply share this across your=
=0A=
>boards and you will avoid sourcing these files.=0A=
>=0A=
>M=0A=
=0A=
I use the binman entries in the environment to get the spi-flash offsets.=
=0A=
=0A=
+/* SPI layout variables */=0A=
+cfg_addr=3D=0A=
+	fdt get value cfgaddr_spi /binman/blob-ext@0 offset &&=0A=
+	fdt get value cfgsize_spi /binman/blob-ext@0 size=0A=
+=0A=
+fpga_addr=3D=0A=
+	fdt get value fpgaaddr_spi /binman/blob-ext@1 offset &&=0A=
+	fdt get value fpgasize_spi /binman/blob-ext@1 size=0A=
+=0A=
+os_addr=3D=0A=
+	fdt get value osaddr_spi /binman/blob-ext@2 offset &&=0A=
+	fdt get value ossize_spi /binman/blob-ext@2 size=0A=
+=0A=
+dtb_addr=3D=0A=
+	fdt get value dtbaddr_spi /binman/blob-ext@3 offset &&=0A=
+	fdt get value dtbsize_spi /binman/blob-ext@3 size=0A=
=0A=
I also use the binman fdt in the SPL of one board to get the FPGA=0A=
SPI-FLASH offset.=0A=
=0A=
One way of fixing this is to move bootp-all to the standard files and also=
=0A=
add the binman entries with an extra file with the config option=0A=
CONFIG_DEVICE_TREE_INCLUDES=3Dzynq-binman-brcp.dtsi?=0A=
=0A=
Regards,=0A=
Bernhard=
