Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0F0DC25B48
	for <u-boot@archiver.kernel.org>; Thu, 26 Oct 2023 11:57:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 057F887608;
	Thu, 26 Oct 2023 13:57:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=wiedemann-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=stwmm.onmicrosoft.com header.i=@stwmm.onmicrosoft.com header.b="TvJhMuWE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 915B787B0D; Thu, 26 Oct 2023 07:47:47 +0200 (CEST)
Received: from mail.sensor-technik.de (mail.sensor-technik.de [80.150.181.156])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4349E87AEB
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 07:47:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=wiedemann-group.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alex.michel@wiedemann-group.com
Received: from stwz1.stww2k.local (HELO stwz1.wiedemann-group.com)
 ([172.25.209.3])
 by mail.sensor-technik.de with ESMTP; 26 Oct 2023 07:47:44 +0200
Received: from stwz1.stww2k.local (localhost [127.0.0.1])
 by stwz1.wiedemann-group.com (Postfix) with ESMTP id F3B8EB5ABC;
 Thu, 26 Oct 2023 07:47:43 +0200 (CEST)
Received: from mail.wiedemann-group.com (stwexm.stww2k.local [172.25.2.110])
 by stwz1.wiedemann-group.com (Postfix) with ESMTP id 972F4B5AAC;
 Thu, 26 Oct 2023 07:47:43 +0200 (CEST)
Received: from stwexm.stww2k.local (172.25.2.111) by stwexm.stww2k.local
 (172.25.2.111) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.32; Thu, 26 Oct
 2023 07:47:43 +0200
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (104.47.13.51) by
 stwexm.stww2k.local (172.25.2.110) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32 via Frontend Transport; Thu, 26 Oct 2023 07:47:43 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BDfx3eKkSg7+/glw6zuvHqkgCXyvjJzCkvoNI9ONUSibqAlkeunQKEBv7JSBdKYwzH5FrqV3IKtJ1GREfiG6NHjBJQcj3+lpvpSJoNxIJOdOib+9g2EIFkH3J7As5Rl8BLAW8Alvl63YlhSOhQMj8ZcT4EJTthXditd7UJEJ/YbQVoyww4I4fclTRpJP19x5kZzbJIhSAfpbaX0CQHhFcJhWaFB5SFV1v26DEvnk0jE89a0FEt0+jeA1Zc/X1T29zJb92oLOFasNBSxC6lJJGJeIOC4aAQjO9dMGkq9OCPfMh2SApzFgTsfBl3sRqa/hMZnRDZz1LVMyWNYFZ07F6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+t/AVUTQmbTl+ICr5khvXM4O8Yw4dy1bGHxCPWR/ZcE=;
 b=TGdx93keZ7Dq3ZIpX7qfoW2VVRkMX+XOna958iK4TC68vx3xl90XCTHXDsiHqD/lD8TVLKTJUOjIq03Mt/NYHiFCER7QEHJajjI4zy85GasV8nke6SNyj6iJceGUjtrcwE92n/MTlqorwyCa/6wL1JySRJ59j1BF70JZ2eTqTggkj4fqk0c49jLC0TBS/pxkVL20fb5mqZrNxQKOa0q7mTKHKUeZkvgkIHI/Pi5gaqbWmHqaPqmweinMWvJOO3wldohhoRGaeKshFXxc45PzImnN73sAwy7xluv5rIk7gVE3RPtVRdTiMPm5s+3BqLKyF0y+wFzTKZ1IclzijQCrqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wiedemann-group.com; dmarc=pass action=none
 header.from=wiedemann-group.com; dkim=pass header.d=wiedemann-group.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stwmm.onmicrosoft.com; 
 s=selector1-stwmm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+t/AVUTQmbTl+ICr5khvXM4O8Yw4dy1bGHxCPWR/ZcE=;
 b=TvJhMuWEyOdOn34HqZ08QaFTReNxTO6j67zkiL6Kg4Qb8hTWs3khI2LNsZfUkE4mfwv+/HsWn+kj4HAgJej3207PauxVVCdB5bk1Hu7CQ2+vyts5+nLKi2Cd0DJ5+9U5WjYz0Oj9orr0pTT64hRuc7UcFkJrcoZ7pqAUgc/3dxk=
Received: from AS1P250MB0608.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:48d::22)
 by DU2P250MB0240.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:279::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.22; Thu, 26 Oct
 2023 05:47:41 +0000
Received: from AS1P250MB0608.EURP250.PROD.OUTLOOK.COM
 ([fe80::3848:f440:3c65:5e82]) by AS1P250MB0608.EURP250.PROD.OUTLOOK.COM
 ([fe80::3848:f440:3c65:5e82%7]) with mapi id 15.20.6933.022; Thu, 26 Oct 2023
 05:47:41 +0000
From: Michel Alex <Alex.Michel@wiedemann-group.com>
To: Tom Rini <trini@konsulko.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: [PATCH v4] misc: i2c_eeprom: consider pagesize when writing to eeprom
Thread-Topic: [PATCH v4] misc: i2c_eeprom: consider pagesize when writing to
 eeprom
Thread-Index: AQHaB8/vNDD7waW7yEKTwi1VYl2Xvg==
Date: Thu, 26 Oct 2023 05:47:41 +0000
Message-ID: <AS1P250MB06084AA86F3BB452127D951FA9DDA@AS1P250MB0608.EURP250.PROD.OUTLOOK.COM>
References: <AS1P250MB0608EFCD6443148D5D9837C6A9F8A@AS1P250MB0608.EURP250.PROD.OUTLOOK.COM>
 <20231024231543.GN496310@bill-the-cat>
 <AS1P250MB06088A3DFC19C7673DB0F551A9DEA@AS1P250MB0608.EURP250.PROD.OUTLOOK.COM>
 <20231025135544.GN496310@bill-the-cat>
In-Reply-To: <20231025135544.GN496310@bill-the-cat>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wiedemann-group.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS1P250MB0608:EE_|DU2P250MB0240:EE_
x-ms-office365-filtering-correlation-id: 8346a22c-6ee9-4331-6fae-08dbd5e711b5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OtrWVDgwxgd+zIW/Vn02cRBEIFdxtoI3IpUVTxRFZ3cpZNISIHSlCQlHZ7vanF1leEqvvG+18B/m7auZFC8qsoQ9jfaseEvrF9ZQYFY3b+yDNV03UlHyFvSh71AayBlb5TIem3IZJxTesoXpcT4myN6eLIx/fellJji4SWLjiCuC7eHh/F3uV3bv5UV+pA2E8dlBeE5fFkT8ttugl8zcVMx13FlAFAqVxV3ZW+9k992FxTxcvacdgHZfD5slvD7fnJtEtBW8iXL+F0is3V8u5pOgMuKIgvouR4NHpx+m9ZjJOviSdwoQ0N5NENh6SH5su7mCv/UB2znGY5xEyA9celgyM2NwDONtawB671DizXyu0m6ncUYuodzXpIh2eQkyPnJHPuk4tx9nNdegaIXubAbtA7Ue92I3eNbQQUyNmKVJttTIQPQ+osxrFBnEV8mHQ6BnF38J7y3xjtP906nPKNwYk2dpXSAHIpu/1VbCVMYHe8VC5Bpsl9UKcusvce+5TQSmoKQSfRIrtJ40faan/+tzwklrd9BmJBZ7dXOhjDxSkw0jYd7xVTHqPVKooOIN7P+Y0DCs0XI817bK++6JGLMZRY53ZRYtxFI2kmNG8mPgcbRnCQw7S7cYRz/TkYfU
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS1P250MB0608.EURP250.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(346002)(366004)(39840400004)(136003)(396003)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(33656002)(41300700001)(55016003)(4326008)(8676002)(8936002)(5660300002)(52536014)(86362001)(2906002)(83380400001)(38100700002)(9686003)(71200400001)(6506007)(7696005)(122000001)(478600001)(26005)(38070700009)(6916009)(66556008)(66476007)(66446008)(64756008)(316002)(66946007)(76116006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Xwv9RyAkUGiH8hf45/ymdH5By98MJA7HNM/Fb20G68H1iXaLI6tMWNPj5scE?=
 =?us-ascii?Q?gYp5dYRWiTP+smiwSPZmdZm6S+BuHh6c6OwjC0MdIEGundAL/GTllG7GMawZ?=
 =?us-ascii?Q?cw1BS+1QHKJiLi/yiXbQVrq0dAZwNq+HWnJyC1OrkqT/C+iwDwmN559QKj5D?=
 =?us-ascii?Q?9qXlEKjiRJbzuscpsUSQXGmWdPMHZ3n7M5li3tJ2VvpetnNfuPENNok6+2jc?=
 =?us-ascii?Q?+wPxqEiMQ6NE2Xh+izFCUrM4MYM6gHgqEATKyXfZBENE4fCB1V52miKUirq9?=
 =?us-ascii?Q?RGUrAT1E6Zy59SH+ZNK2ZYJmJdYpTmOBpq0ic0vUzUKBvoDR+DedLQk2uE5E?=
 =?us-ascii?Q?VelP8fsT1d0WUBg/9dsFv63nWEAtcvX5yE41O35o6OlOYhbdlB7xv5hZ8hAw?=
 =?us-ascii?Q?v9rbL/oQjlskcZ8IfWRAF/w94c7cZPhLpZvwtscqhYca5k15Q99v4gNRtefh?=
 =?us-ascii?Q?8iaDmfwLWLt+WUaQf12M7KXqbn2/PjrypmcTQXfVDN/5ZIDjv4/qnwSZ0yfK?=
 =?us-ascii?Q?JycK+PQPa1hdLuvblpva7A6Fntv9WyA/+1NlA6kD+ehrziVpSOQlGmTgwIKK?=
 =?us-ascii?Q?++SSbTpUQu1z9So+QEANO67wTVw5ia1MrdXxhmM5xVErIbGx4z3PwRAK+ylb?=
 =?us-ascii?Q?yqH7NhuPL/NKJvXyALOsMQse6Y2t4U6j7v25inmwTQKffi+pmn8kesOBRWra?=
 =?us-ascii?Q?CQ9iWhaR9vAewg/DH+IACqIWqeJszTJUaE5Pp/YXtv0b+4up2l6wmK+k/Flw?=
 =?us-ascii?Q?kaAuhaPLkr40rkKxiW2myNa3ZtDFQi14IRX51MBUUvDrC0uYfL417iYzl8LL?=
 =?us-ascii?Q?UgqCeoyUmt5lzlDdF9IsJT95C1yctD4Lu0eNhmiHmLMAzL/TmULyAU2Dvm1E?=
 =?us-ascii?Q?Lmv7vLSvpoSnl+HwLnnM9H1OhscIxrDw/AvwSvKX1ruJr2ENw+B5g5FBba7b?=
 =?us-ascii?Q?A6fLV3eiDfdjsAZEV8tBvHJGYhCz45kP1kkh+mvARswZ+fyPAxFR+c2KQ0Py?=
 =?us-ascii?Q?hMOl0HE6VK6LpwuFt2H86D8wx50pXj99/TH6UctdnBg/rxKyJmZrs4RkHN3g?=
 =?us-ascii?Q?gUoK9VJswO9BIgNqFod/haxjbjqdWtESkK6FZ7JjeXN5k9IX2Ajnz0GvOcLY?=
 =?us-ascii?Q?qoauqH1PFfscvy/M6HzW6BBJuHk6iVlZvaaEavnr8oO1JWqwSU5f3C6PcS7q?=
 =?us-ascii?Q?dat22WK5QMAhWHcxn79AQcXDuL9/cuYROfioEbidDCNsaoS0d+O5zUgqmflm?=
 =?us-ascii?Q?tMyB2t9G3ME4sghPzN0SfZEWrwQzVtfYdmdFkdLBuITWWTPlSALoZIqpgwr0?=
 =?us-ascii?Q?US68vgf9SRd+AZv4uslt4dkDcZwJaqpnE1kGkZ/CtVvT4oggYDKpYEvymGwC?=
 =?us-ascii?Q?7Vv0vs7E74rh8pLjWT7hlyuLgyd59J209OojCtQ+3laqN0skTIhZrUfNge2k?=
 =?us-ascii?Q?OP62luE8ruWbcb20qRuMzTDk5forgfrn4DNqjcQNFIxLV2Klybhym0H4SrN3?=
 =?us-ascii?Q?ebGQxK9duOdXfLfQxpkfs8twSkKPeU1/KePxh1mREUiCWA23X6BQdav50YoL?=
 =?us-ascii?Q?vBlLOYD2sYlwxZSO7bqj5a1LJJn5OpmKDFSiFJ+8gqftMqVrM2L3UWgW+4dm?=
 =?us-ascii?Q?QA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 9tJDMmRgo1q/GNhpnp53LJH0/YfqJkRAKoQIU+vdcAnY7fDrqm+UnfN+gIaltE7BEFfNX5U7TYAdh8IPVSIstElJXPs7EIW70CyfWuRwELD8xnq//+7q3JlyEU31W7xAR2w10WqwHkrTMmnpzwwKcl0Z0DMNdNmiPnkbP7CTrqImi9PEg1vQGfT55qG4shibIlsTiEwamsOF++EYgpwm6Pu0uY186wKVi+VOXq1V0d797lUYItAQLI4tv+w/Yea0N75tHa4oNBgPgxT7PxR/ZEZIxtzTBkb9FsMemxZBlCv+Xv4nRJ+oaeUdyeU6XPuto8M1OgemS6ySFdI9spm68ClzPQX/K0Shjd609sr62kObCYdOafhs+QFuOaDPEuOm/ZdUZFZyqAarLnpZJFOwDiTWQcFNtJ1xad70W3sby8m1hdvowY4HaSmgKOa/zLhiM4YUWUF+5UOEwhA6gHwo/TCTl2RMlJes7YQkq7DuWwbC3RAE7mI6xQzMAvRay/hFLKdlR4nvrRWcN9/HRDMuu2D8kibx9lhDK+OYzLZMkVNTq3AX+QL6WMmlHtRz30elWT1aYCerTx62VxLWNL16BxCjmFOmhgNQIl0RjCg17R8Hr4ss5AXvsfuZk4icBPiBtQa+gX60aifRT3SYuVkAKMneKIiMvaWYOb30WUUCTiC33oK+YG1cPp6jRmJtV0yz+6O9U2yjyJbH48lyiowE2JcnRdZkUJ/gMiEYWJO64KPNYPe28DH5KqXmgBIL84jt/mqLElS34LZDO3TdInbQ6g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS1P250MB0608.EURP250.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 8346a22c-6ee9-4331-6fae-08dbd5e711b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2023 05:47:41.4032 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f92d38a3-9c84-427f-afc3-aef091509c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vSodDij/nx9wKNCwQu3/X2xGiMfaRFgtKwqPRxIYl0O0NPeC+fMG3Z5wKrzKATiNpSShx6wE69h52qZxxwxL2caaclPKKQfg25lcMMa5IcE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2P250MB0240
X-C2ProcessedOrg: 71f8fb5e-29e9-40bb-a2d4-613e155b19df
X-TBoneOriginalFrom: Michel Alex <Alex.Michel@wiedemann-group.com>
X-TBoneOriginalTo: Tom Rini <trini@konsulko.com>
X-TBoneOriginalCC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
X-TBoneDomainSigned: false
X-Mailman-Approved-At: Thu, 26 Oct 2023 13:57:35 +0200
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

Calculate the maximum length of the buffer when writing
across the page boundary. If the buffer length (len)
exceeds the page boundary (pagesize), split it. Use this
length instead of comparing the length with the pagesize,
because if the write start address (offset) is not at the
beginning of a page and the page_offset + len is greater
than the page boundary (pagesize), the write operation
would overflow the current page and the behaviour can be
undefined (e.g. at24).

Signed-off-by: Alex Michel <alex.michel@wiedemann-group.com>
---
Changes for v2:
- fixed deviations from checkpatch.pl
- improved commit message
Changes for v3:
- cleaned up brackets
Changes for v4:
 - use "int" instead of "unsigned int"
---
 drivers/misc/i2c_eeprom.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/i2c_eeprom.c b/drivers/misc/i2c_eeprom.c
index bdd7e018cc..0d35efb7f7 100644
--- a/drivers/misc/i2c_eeprom.c
+++ b/drivers/misc/i2c_eeprom.c
@@ -60,6 +60,17 @@ static int i2c_eeprom_std_read(struct udevice *dev, int =
offset, uint8_t *buf,
 	return dm_i2c_read(dev, offset, buf, size);
 }
=20
+static int i2c_eeprom_len(int offset, int len, int pagesize)
+{
+	int page_offset =3D offset & (pagesize - 1);
+	int maxlen =3D pagesize - page_offset;
+
+	if (len > maxlen)
+		len =3D maxlen;
+
+	return len;
+}
+
 static int i2c_eeprom_std_write(struct udevice *dev, int offset,
 				const uint8_t *buf, int size)
 {
@@ -67,7 +78,7 @@ static int i2c_eeprom_std_write(struct udevice *dev, int =
offset,
 	int ret;
=20
 	while (size > 0) {
-		int write_size =3D min_t(int, size, priv->pagesize);
+		int write_size =3D i2c_eeprom_len(offset, size, priv->pagesize);
=20
 		ret =3D dm_i2c_write(dev, offset, buf, write_size);
 		if (ret)
--=20
2.34.1

