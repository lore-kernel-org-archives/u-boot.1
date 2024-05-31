Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44BF8C25B75
	for <u-boot@archiver.kernel.org>; Fri, 31 May 2024 12:46:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47C4C885F1;
	Fri, 31 May 2024 14:46:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=thp.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=thp4.onmicrosoft.com header.i=@thp4.onmicrosoft.com header.b="Tb6oJjGY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0148088783; Fri, 31 May 2024 08:48:41 +0200 (CEST)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04on20724.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260f::724])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7FE93874D4
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 08:48:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=thp.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=m@thp.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YTvljv8OzpsGzvf9ZRomxcOw8g29kLVqYL/bwnlJal4M57Gw4PT1vcKPMyxcMyN4BBmWTXfH/V1ns4kGgmUt073TD1lQlxztKoagtYYha+wvfZPUuSI4uPXLdFBW/EmPKJSVadQmxHqvodyZBBlJXg3LTR3bR9et+SAYnRH1efcBbi8LSNsp+m169hhs4UMqFIXUUx52wrGyiq2zwyK99nqQv8iH5iHMhxyv3/OFi4J7ZOP8e/YCHVTRmU1i7HgfeTgPMPpFgu0/FAhbFoxq3W/fRRpwqYx8BWVLMo+yy7Rlgh7DBZhWEzkVN9X77E7iaY21Wx44CLxdKIIBm04gnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c8vOufTxHy6Sk1l51dKcexJDaa7bNV/lw5HgZCAd4YA=;
 b=UuxGAKSkegY0PkwadJnNP03qA0bbhdhu9EteKKDHq5J1zKnhkpYDkvLzWTDlV6dGKeMmGS1ee7nSVnW2u4JoJYcm6F0l7jBI9AVVvAkMrohpmhneC01ghnpL54bwyxnpl7RPN9abD73Wmrz9Tp8okJig6iBoITAu8u64ItnWYrz3sBrZ+CPTXmokK+idvloxvh0zxZNlK2K4d43R8L5Pq71OVWfoJ8CZyoyZTsI0Ud05vi7uyckC7xX4h3iLyOwvgireE66jETU83C8j7f6EvEG78mBSyDeMSYvRMvnVvoTvc9Bws2rzU5L3lgZfTbI+998o6EXGPCb1BbG8lHpvSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=thp.io; dmarc=pass action=none header.from=thp.io; dkim=pass
 header.d=thp.io; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thp4.onmicrosoft.com; 
 s=selector2-thp4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c8vOufTxHy6Sk1l51dKcexJDaa7bNV/lw5HgZCAd4YA=;
 b=Tb6oJjGY0KXR4Rt+JejYMWGDRwHaKbIpxZBaaDkzZ8yUHdKncQXvoQt/K/oNvFBunmFBUE2Q74pxIHZiRtZdoMPb4IMcowCxKzG0pS9RvXMeqWCGTXIiTpo3ClTOjpjeoMgBd+TwiYb38KEexRlaBY0e1kmfn9Ug8EZCJmln3TM=
Received: from VE1P194MB0781.EURP194.PROD.OUTLOOK.COM (2603:10a6:800:162::9)
 by VE1P194MB0941.EURP194.PROD.OUTLOOK.COM (2603:10a6:800:166::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.25; Fri, 31 May
 2024 06:48:35 +0000
Received: from VE1P194MB0781.EURP194.PROD.OUTLOOK.COM
 ([fe80::4d4b:101b:9e87:e5f1]) by VE1P194MB0781.EURP194.PROD.OUTLOOK.COM
 ([fe80::4d4b:101b:9e87:e5f1%6]) with mapi id 15.20.7633.018; Fri, 31 May 2024
 06:48:34 +0000
From: Thomas Perl <m@thp.io>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: [PATCH] Fix typo in NVME show command
Thread-Topic: [PATCH] Fix typo in NVME show command
Thread-Index: AQHasyaOcXAKs/bH+UiZ89E+1FY52w==
Date: Fri, 31 May 2024 06:48:34 +0000
Message-ID: <4899A066-269D-4316-89AC-5B3C28394CD6@thp.io>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=thp.io;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VE1P194MB0781:EE_|VE1P194MB0941:EE_
x-ms-office365-filtering-correlation-id: e2b72a83-4aae-48f1-6c92-08dc813db151
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?Z9iC5VFVJtlqvb+fk5tTaq0cO1T7t12VoT369FzExyl2vLzAGcx8r33djTmv?=
 =?us-ascii?Q?oItmJ3QgRzZLpo9KCAH6zdMcIatzRpOaYySUZh4M/9DcTVKGpWJZPDi/swYZ?=
 =?us-ascii?Q?pliWrCp9JCkHYJRRC+irh8umqh7mlrOOfoXMZqLWFpAIumgFNp30JxRIHd/Q?=
 =?us-ascii?Q?z191Ighij/7GY9/STQMZFUNxZFGQjvkERgSaA58u/vYy+nJAI+31K/ZKuAkG?=
 =?us-ascii?Q?ipiKAPG41JtJ2wgxS9G9B9t+kFjiR/omZmS8vBHVHBs37T2EepnIqh1RH/Yl?=
 =?us-ascii?Q?QBxjRVUPT06BLC2QZd2JK7twKEuyc+/jZ099oV8wMCiMUOKyaeWI3P7/y4T5?=
 =?us-ascii?Q?7jaIcGOsM9PJTW+UAQetXKVyUAEd3d5rTNxWQJx6Dqi5Ly01dgnKw6wlVFVv?=
 =?us-ascii?Q?so0kW2rKIsgY2w4QxtUn4s5FXpej46XvzdvaX+yvtJhHNlaMHvlLpf1GWD6P?=
 =?us-ascii?Q?p065TmNtXJfBYewq3Z0L6aF/BgkmADDADkxh9yIYCd8NtgunuaZq4W4GepOx?=
 =?us-ascii?Q?Ez4KX6eJWOtr/tEc/V5YIdQ1nybOM7Y2gPFeBP/13rLcP0FW6lG3QVDljB7Q?=
 =?us-ascii?Q?zoww5aecIgi5xmtJAzc7wwAcal36Z1F23gWRIhPvJ188SdpjXGEn31jnSRh5?=
 =?us-ascii?Q?r0XZKFi3+J2cUnUBGDghyEMd0VudSaoICICbK3UU0gqEpw/MedYBp31qKppn?=
 =?us-ascii?Q?azr/4vH12eU3vNJq+O0Tqnh8tasK6ISDqAr7jVAxeL/aWjpn06r7Gj8uNNm2?=
 =?us-ascii?Q?DvyBnWN5j35mAL600zjiuYo4QO+mjSabC9DhzMvL+w0PG6+vMh/NqOJ8e1BN?=
 =?us-ascii?Q?c59DO4ZAjw5w7o5MaPAbtn+rxr/8eVtO+wsfJEkP25P+v4vaiISIy7LTYbP/?=
 =?us-ascii?Q?zkglf+1IvPBh8Y/SYv5STtmiQUTku+8QZ/aSEwoJMBh/aGA+aRiehzUn2Uv2?=
 =?us-ascii?Q?2IHXrCRwNx8ldw3Lppxu6N479FwRCylug1bGOQQSRfYkyPaKw4+Co+NUnJmI?=
 =?us-ascii?Q?GiNeL26cCcSW0VAp02rBBC5mTNVSNhvPumW+CtLjQIp6tNZJAXDbsGQrJiFH?=
 =?us-ascii?Q?L5pC9vP7OahXg9m0ZKAmvDYnT0oU7AyZ9iT4Jk5vlRHo6IgQGSKTsD9QbXJ7?=
 =?us-ascii?Q?4MY2Bv1x2ZCRuDVZGCtq6IOWPcCvfMUPBX4n2Csq6tGVcj5+v7/abQQIp+Nn?=
 =?us-ascii?Q?k8B6XSnRv0/jo9t+Zl3PQn5euiKplX3qNG/SE541jSxA4D0MFrOtk54m3puP?=
 =?us-ascii?Q?ocV+Q7oQAcQGOuj/nzYbD9M6e/aHN4KX5QfXRXvBrG/S8gaGjxBqWJx+Ywos?=
 =?us-ascii?Q?LVvSoGpY39nPe3Mf8hVHdRqrTywQ/EeYrEi/Iu9CrD0eJw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VE1P194MB0781.EURP194.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005)(38070700009); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5sg4lLLw/VsBQ+Nt8tO40Vvf2juWNl0o7505bR6U+A5hEwDU9bQzsBrBIXAl?=
 =?us-ascii?Q?oo71913A/vi/+tI/emsGUgXCzihDQrjyG0evNwgNNsotGMj0yqzDFSB0h2ss?=
 =?us-ascii?Q?40kAKz3utWjIQDr83HuKyBVgLQfzKdG8Gp9uB31dtYhvt9vK4mp1fIh23Run?=
 =?us-ascii?Q?CqXgcg1hktdbeUkiTRx+JHkB11mWqX2Yx8m+HTJoWwSj3ebmJaFHhDwKFNKJ?=
 =?us-ascii?Q?4kR3s6CmHoSBWBY1u5tg1k9QI6LepM/UdUaquUZAiys5cdgqyKAOtFG2IpoV?=
 =?us-ascii?Q?rhc8FMUUCD+wRo8PfveQdLOVayNjSTzr61WrZ+8xqmxscDC20eUYl/hYAqUW?=
 =?us-ascii?Q?BoxabfmrR2eNB7omIehORZZUKuzYjBrATek/rWAhMhS0ZcWhZDZZIlOFzV2b?=
 =?us-ascii?Q?w6rlzGW4yG1s5s/gB3Fdb7KmZbAsFeqpfMcBrsM0p4+Oo51wQvR71jkPenhA?=
 =?us-ascii?Q?+9c9eU7PnhZc7j+wKCeBAFLiQ76CLT+2UBr5sbvXWXBF9X6Inf9VkAsU0+l/?=
 =?us-ascii?Q?osSkvBP3TmDGbfzhm9HLg7b5dhzqyPjP/fcwvt2s9H4vP60TQ6ssJVV9+HVE?=
 =?us-ascii?Q?2NtwET+RWUyLYNc85QPdn3E6VyY2bp63W7CldjtPLx6d0XEw1AWgU8TY0T2c?=
 =?us-ascii?Q?OmOSmFhjc06hBk4RAYjqrLqirsFUpKxqQtOINcpymQUlgzDjFQ+Q/2wrFd51?=
 =?us-ascii?Q?ibUd0Z/5zH7QgLL8kbxr3nrhiwtW1oM5ginwnMNQvjTKxreXw0Qcy+j+k8Vg?=
 =?us-ascii?Q?W2k/+hjQzZFXEaHKkdetQFSK1TipWZH/LlKE8Fb5hUTclWoYU424QAhXABPM?=
 =?us-ascii?Q?mOPcFE6Me1IsNlkbNm6atptp7Iczc8xpOyP6MnM7Luo+3AZMQwrNxy0vtC93?=
 =?us-ascii?Q?iLKfTlpYQw5p926QdjcGSNXCimtq1t8xT5owFfm3lKueMOlzMugPu7BTE49C?=
 =?us-ascii?Q?wEg/B73xY7k/21hv84YTsewE+IPKnk+HMnrjzrHOJhy19TeLaCekjIxzMKRW?=
 =?us-ascii?Q?mEr/d/bNxqpKP1juMnTJ+/tR28+qmrdYQ9K5OeB20n2MggLXXl3uyC75mK3w?=
 =?us-ascii?Q?ru987hN0m0M2dBdzK4w5LpunTcjBiASulUwFEdt+0138NbYJrfGnGyIe3Oig?=
 =?us-ascii?Q?nSyyugO3HJxft+P/emaYciOXOLNvWUtDCx6RMg7fKnM1giFkhix2QKOWfCCy?=
 =?us-ascii?Q?u0hEDCi85Xdr2hwN5HZGP7c25WZsKzueNLjee+Hgv+djet13b8Aqsm1dNfqw?=
 =?us-ascii?Q?QxPedgt29stEeV428F1fmgGkatCz8NCnt8QsLL0cfNAKnXacHXlibPeYRRXr?=
 =?us-ascii?Q?HFmU66qKRn1BL/d72QjxYns38+hgOx8oqlWz6SQHft0oMBBd5OhfFGzuc5u7?=
 =?us-ascii?Q?de5bBTP6LH4s7MCpnJoSK6Jvoang2Ae8IoEPq37RJtZ2nz2pP+sn56yNZb+r?=
 =?us-ascii?Q?fCPkaaArXUGTyenxuTZ77eAPQMP5kHTx4P3Rt6wNiuYIij45FioUSi+P6WHV?=
 =?us-ascii?Q?YoRTZN3B+3IWbLguLZP1mP6DJWdKtUTd1TJD6yy1YXlZfi8+nHo2jwJZgbxY?=
 =?us-ascii?Q?tKDSWi+UlVUxgONJNUcchbMy3XYH6GcXxH7sEZxmbJcl+S8XTPznnejQ6cn/?=
 =?us-ascii?Q?NHvGjQxvOOtFJ+5GB1hAKe/3AtN+8w5/3SvEZ5vv4IKTi+pPDQZ+j/mimx/M?=
 =?us-ascii?Q?aJFgWA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <75EAC1F7EDCF4740A25B7D8E7268D516@EURP194.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: thp.io
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VE1P194MB0781.EURP194.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e2b72a83-4aae-48f1-6c92-08dc813db151
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2024 06:48:34.7622 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9b407b73-c466-49a2-b0d8-a8ff83188813
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mRYHqoebe4hRMgN+GVmKu8RJlJQzNNXUcecZlCISsy6FOBN4xldJrTlF7ORNvdgbdut4LGlBadILhXyJzZmJ/q9sgbrSdCr1Xnme0/ni77Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1P194MB0941
X-Mailman-Approved-At: Fri, 31 May 2024 14:46:11 +0200
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

Foramt -> Format

Signed-off-by: Thomas Perl <m@thp.io>
---
drivers/nvme/nvme_show.c | 2 +-
1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/nvme_show.c b/drivers/nvme/nvme_show.c
index 72cbac82bc..8dc03fe5bb 100644
--- a/drivers/nvme/nvme_show.c
+++ b/drivers/nvme/nvme_show.c
@@ -68,7 +68,7 @@ static void print_formats(struct nvme_id_ns *id, struct n=
vme_ns *ns)
	printf("Blk device %d: LBA Format Support:\n", ns->devnum);

	for (i =3D 0; i < id->nlbaf; i++) {
-		printf("\tLBA Foramt %d Support: ", i);
+		printf("\tLBA Format %d Support: ", i);
		if (i =3D=3D ns->flbas)
			printf("(current)\n");
		else
--=20
2.45.0

