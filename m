Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63D72FF8860
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 18:25:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF6AC8448C;
	Sat, 25 Apr 2026 20:25:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=ezurio.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ezurio.com header.i=@ezurio.com header.b="KDacxh7V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 054B484440; Sat, 25 Apr 2026 20:11:05 +0200 (CEST)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ECBDF84324
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 20:11:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=ezurio.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Simon.Gaynor@ezurio.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QIbR0uUIT1/OgmKJ29T0JkO9BskQA5UKd3D3htwneymXz7V0WbJ8kGkcne8ZfEOTW00+flgiyB0QbPVCww/1U9AzpOnFR0OG9QIKJToJmgAHTSkE0OeilrWRWouLKKPzBGfvhChRBKznt4Lcw9Acmsro5sEhgI6siryCOLs4/f/gaFVf0krf3NyqCFeq/4aNHaPd9kmI9pGDNkQ1jYcOFaF56rAWxdUktxFFe0Nd97sklzcKlgwg4+NPurJF5xgFoIOOgtRyd2cmMeXmjE68y97z/SAgFEIlfk8LItvjQHTgP9UpXkvkVqGdZAiDmAThRax6Lp13gwztAx6KIeFfYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OkYwG7eMb55q17eoBPrBKUQUQrqGYv0o5AtN7biouXY=;
 b=YGAWMEd12YU+mRKppJJjH3HHKSJzrvV/VRfUbU2qtWJdf4t4Zvy/S1m8j3xSOvvhPJvPATMJiXewYg6pgAAmNw8/yKIfgsoFqevSgDwD4BBMdZkPPBxl1UE/3KMW+RlTNaI9kbNw7zqIbXi/+ENdrXxDVN36JzvM1/CPfRL7rwegmFkn7zdTJA6yEWg0TWKX7e2JDZ5zMyvmiL/Pn86PCTm3E2dd4RaECwd4H7wMgacJoYzLdJagsGlO8Ybe2RCcpIntXYss5f6fVpCoxPInKEPZSKafpIu4SROYsaBlPa33M9kr3XHNTsVX+mFY+UiS/UZpuWrfFVmjO439qM2FqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ezurio.com; dmarc=pass action=none header.from=ezurio.com;
 dkim=pass header.d=ezurio.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ezurio.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OkYwG7eMb55q17eoBPrBKUQUQrqGYv0o5AtN7biouXY=;
 b=KDacxh7V6b+l8m+2cZGOIZoH6eWP4iykEreKqTHHdq8WNNU2+L3wBcg5LpqKR6B2c/+SDIKxWr/NQw3Wd3D8nLaASFcI2srRVuucZHdvWhfmBSyuwR1EmyLMB665QfxYlKl0qxBkV3eb+nDRmrP4s+BQxLWQrHW7JyUYp8hlKTkUu1bAU7n00yHiDaZhgYTBu1p4ADA6YYjMjHs9VrKvg251G7tbr0CTQAri2Ztn7mGAMQryFrw4p3nUcGUGA/rxUPsqzh34C6900QyBpNZ/2+Kko9MswCaKsGcjUQG9iOTUH++6euIhn8vnCh2uU2Ud96j9v/NabEzqKcOTD59DCQ==
Received: from MW5PR14MB5289.namprd14.prod.outlook.com (2603:10b6:303:197::20)
 by MN2PR14MB3968.namprd14.prod.outlook.com (2603:10b6:208:198::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.24; Sat, 25 Apr
 2026 18:10:57 +0000
Received: from MW5PR14MB5289.namprd14.prod.outlook.com
 ([fe80::ea30:e255:4a84:c05a]) by MW5PR14MB5289.namprd14.prod.outlook.com
 ([fe80::ea30:e255:4a84:c05a%5]) with mapi id 15.20.9846.022; Sat, 25 Apr 2026
 18:10:56 +0000
From: Simon Gaynor <Simon.Gaynor@ezurio.com>
To: Jacky Cao <Jacky.Cao@sony.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: "trini@konsulko.com" <trini@konsulko.com>
Subject: Re: [PATCH v1] nitrogen6x: Fix compile error if VIDEO_IPUV3 is
 disabled
Thread-Topic: [PATCH v1] nitrogen6x: Fix compile error if VIDEO_IPUV3 is
 disabled
Thread-Index: AQHc0uNQR5fiCRUdf0670q1qNheU4bXwF7Pu
Date: Sat, 25 Apr 2026 18:10:55 +0000
Message-ID: <MW5PR14MB528997D8AE5040E0AF4C501BFF282@MW5PR14MB5289.namprd14.prod.outlook.com>
References: <20260423053725.103866-1-Jacky.Cao@sony.com>
In-Reply-To: <20260423053725.103866-1-Jacky.Cao@sony.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ezurio.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR14MB5289:EE_|MN2PR14MB3968:EE_
x-ms-office365-filtering-correlation-id: 4a0f788d-90a7-427c-317b-08dea2f5fecc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|10070799003|376014|366016|1800799024|8096899003|18002099003|22082099003|13003099007|38070700021|56012099003;
x-microsoft-antispam-message-info: brb7MKz+1+yQYdFpdkzH2017WHNcXeh4U8NAXTkIt4tF8zORYfDgLFfSMPu0maPqi6jd1GMDGvTLd9IINhpv9pQvEvjswDZ+jjWzzDES1H9f8Xar7/drnXf8+FgAh2kFTmT0j6fHXPql7DLW46E1nirgTIYQtuRPGTKiminA91wk4ELRZelae8ZNxgV5Xmbqf5R5ud54fW3S+H7rN+iefKsQzxq/t3GD7VBDRIud/WU1c2Cqjl+gRjHGjzUKt+uvVmkD2Df2RM2fP2CcUKrjlkLV1mZvLvBADmV1AAiG/hFRzJ8rODWzFSskXZ2KgsW/mnAQIk4ELY4/IJK0x95E1oZYhmuaq7EVUd49q2d0VCQwvnCEl+h6hpEKMl1tmGsKRzyKits1kati7Pbrl/IPDRRipQvMCLsQiHgQKCXh94oydWDjzu8q9mrZHtAIg8k73KIKsRR5W29ZS3oacSZ4gxje7yUGCqYnzUxTAnwur3Ger/C7qFoIrAvh2QJXFIediMZapKS4zGx48Kte8oVDvJLJxojyRnNv0I7O8SVoMjxiz8wrZga08QcPKixY9MdznZniwVYOGhEa6Q4S3A8H8oMaOX+YsiCt7LuiRBwYNaqAs2OVrHdZye0CIR9nVS4cgvxovC8oG1v5wlmiEI+M4yw0DYTm+5VgkyGYG9/Pv2J+krmtOyNbJopRXp5EsmzabmEed5asWBPbCsU/64OkoRKTvzGFr712o6rEoh3kuW0CD6aDDyYXDX3Ma8fYSFwUGQN52w21JbnnxIg1U02Yna0igHN9o2CAH7hNQsVxq4E=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW5PR14MB5289.namprd14.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(366016)(1800799024)(8096899003)(18002099003)(22082099003)(13003099007)(38070700021)(56012099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?L8dvVauRVCYrGmXnmkw2znS36ltC+IOrSlD80a+xUhfbgWdeUEj5mPkD9Huy?=
 =?us-ascii?Q?uyqCy7RrFn4ycI9EYl4tacDVZJX3HphKJEJF/O6WUr17sK1f/m7C7sZI1o4/?=
 =?us-ascii?Q?wG8baWqrKvD/x7UYhTZ+Qc7xr7ViRYar4ILPh4My2Ml8qMgMUr3r+f2MgDDv?=
 =?us-ascii?Q?gto9NVH2lp3id9lOJo7TGw6X6dk+jNGV/LVTOwCtZGh8GMW2x7+1q3YiQFlM?=
 =?us-ascii?Q?9nVaz3Fa3fU4k4plPM/C7NXJInxZN6n64NoSsoJNaciPu3rIFhYjswsIHmO5?=
 =?us-ascii?Q?bJuNYbnM2OvgY3EHlGrl9uWiiGnYJN93KAjX0kOvQxAzTyRLCYWtrPRmkq45?=
 =?us-ascii?Q?0yr79NLiZPEyIi5d/iEMbauYonWkjbzjZEjlst5AjM3a0AzGQbBlU9lfZFwq?=
 =?us-ascii?Q?D/GWGiiwqhHI4RJAxYSQ0WxmAftkDcGMIGq/nH8uJTN2QSGlNfKOlHgSusGi?=
 =?us-ascii?Q?wsWTYsdSvP4poQ9WQnKoeDq+ZDk/iu22ZLnNLscf9ZZEqzydJEAffG9YwRAR?=
 =?us-ascii?Q?ALgsodsIOvM0mSbcgnnbLXWeEZWs46h0toEKjIlA5nCugUv4NpcK++L6tvaV?=
 =?us-ascii?Q?G4iS40yjsQB9OM2LRiDJ4wDN6tsMF7+VBHZ1c4CNVwZGwePWe8i4Ae5HtFDi?=
 =?us-ascii?Q?aax4x/W5fUsfo6LEu/YqBVc/7HDX0aQV86su7oajrW1uXJumnkfPK6R2qB4+?=
 =?us-ascii?Q?gMkCF0JMC8a/9oLgJ4eGAGrdz9P9pg93NSzTHi1PMFkTx2t0ZztLwKtIe49Q?=
 =?us-ascii?Q?cy9YVNoGJyZlHTwinM8HlMXskToqOGv6X0jZ3eXj4Lmz1lDs/AQnxfqPyLYz?=
 =?us-ascii?Q?kH+84ZGChqArmGzs2B+U+rvTuhp0U0RzX1Y+Sn/vds4EnYaN72vKvVpMpNv3?=
 =?us-ascii?Q?bIf+xjVwWxF5mduJfjy3x8HdZgQKIFUHpcIbcjKAEpr51SWdK1DDzusT2Zg3?=
 =?us-ascii?Q?xFyJavkDhHp6QSPC6n+2s5CZHxJ/3oL4R+3a9uURPQrJzH1dQvs6Pckf7jqC?=
 =?us-ascii?Q?jcI9Z48OKFoqpHn7oRVtPmfJjNQJsh97YRksSX3zbqvDj+wvPvpRZqqm/3wx?=
 =?us-ascii?Q?8OhTfnpxCeU4QvOFERRlkcu6HuX4ShUqf804OujiBpe9K2v8dXdy9w8qGmU+?=
 =?us-ascii?Q?GTjGFj3PVkXyNBwnBX+ZKi5kseOKg4l4mK1ualIdQUwWAV+g2GtdMR+Ic5uq?=
 =?us-ascii?Q?xeIRKjh40aJrmoMFmhwWJfdAof5XHZIi700GJKczbgf/4YtM48WMOOixi0Ro?=
 =?us-ascii?Q?HJHs8eNOEuYY09HQPzO/FJFTiS7VXL9k5i/iT4HhiP/9DKHSdOyQmORG+DQS?=
 =?us-ascii?Q?cMaKZ6ezElL08IXaColdDyp0UvvfXT3LqdubA/mTXc0mtPaROPqqmLADeEWa?=
 =?us-ascii?Q?e9jOvdFyoqCRN2afbs2Bifh6LUv4TFWZ24qA21P8KgJ/ys5E95NnXubeIfzC?=
 =?us-ascii?Q?hSwq6/5+e0fK5blQGgPltcQpgDnWOBty8jttinzuzfO9x3teZBr6wzfZ1Cdq?=
 =?us-ascii?Q?h8hdXlzzyGCIchEMLB3bRbseJHUvCovl+I91LvniHogRTdIA2Sm9iemspbF2?=
 =?us-ascii?Q?3tNEY7rmn5vMjDGsTFZ7/T+oXMiv2Oe7WMMY9s25VQGx31RSPCZccJYMe1s5?=
 =?us-ascii?Q?6efr/Cb0Z9GbveDRIRu+N25LfkTwLCID4tltGh6/qZegF7y/EKblqmvy0KnH?=
 =?us-ascii?Q?ZUVeY9HQ3p5GMJ1ia7hsrFlQJH50GazAnHsVPleJGg90td72VLKzT8M/OkoL?=
 =?us-ascii?Q?04qQAZrHoQ=3D=3D?=
MIME-Version: 1.0
X-OriginatorOrg: ezurio.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR14MB5289.namprd14.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a0f788d-90a7-427c-317b-08dea2f5fecc
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2026 18:10:55.8482 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a67ad7fe-2b14-4d12-b58f-bb509b58f338
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EZ0S+oWs/7Y/kSXxUjCpBxEDpfthpsvpo06gRHX+uVJlhYrY8++PT2xoHYxQyTTK9UYgIqDGZx6GOWETE/qvTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR14MB3968
X-Mailman-Approved-At: Sat, 25 Apr 2026 20:25:41 +0200
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
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

Reviewed-by:  Simon Gaynor <simon.gaynor@ezurio.com>

Thanks,
Simon.

________________________________
From: Jacky Cao <Jacky.Cao@sony.com>
Sent: Thursday, April 23, 2026 7:37 AM
To: u-boot@lists.denx.de <u-boot@lists.denx.de>
Cc: Simon Gaynor <simon.gaynor@ezurio.com>; trini@konsulko.com <trini@konsu=
lko.com>; troy.kisky@boundarydevices.com <troy.kisky@boundarydevices.com>; =
Jacky Cao <Jacky.Cao@sony.com>
Subject: [PATCH v1] nitrogen6x: Fix compile error if VIDEO_IPUV3 is disable=
d

[You don't often get email from jacky.cao@sony.com. Learn why this is impor=
tant at https://aka.ms/LearnAboutSenderIdentification ]

EXTERNAL EMAIL: Be careful with attachments and links.

Following compile error happens for mx6qsabrelite when disable
CONFIG_VIDEO_IPUV3.

board/boundary/nitrogen6x/nitrogen6x.c: In function 'misc_init_r':
board/boundary/nitrogen6x/nitrogen6x.c:912:22: error: 'RGB_BACKLIGHT_GP' un=
declared (first use in this function)
  912 |         gpio_request(RGB_BACKLIGHT_GP, "lvds backlight");
      |                      ^~~~~~~~~~~~~~~~
board/boundary/nitrogen6x/nitrogen6x.c:912:22: note: each undeclared identi=
fier is reported only once for each function it appears in
  CC      cmd/bind.o
  CC      drivers/gpio/gpio-uclass.o
  CC      boot/bootmeth_extlinux.o
board/boundary/nitrogen6x/nitrogen6x.c:913:22: error: 'LVDS_BACKLIGHT_GP' u=
ndeclared (first use in this function)
  913 |         gpio_request(LVDS_BACKLIGHT_GP, "lvds backlight");
      |                      ^~~~~~~~~~~~~~~~~
  AR      arch/arm/lib/lib.a
make[1]: *** [scripts/Makefile.build:271: board/boundary/nitrogen6x/nitroge=
n6x.o] Error 1
  CC      boot/bootmeth_pxe.o
make: *** [Makefile:2205: board/boundary/nitrogen6x] Error 2
make: *** Waiting for unfinished jobs....

To fix this, use reported macros included in CONFIG_VIDEO_IPUV3.

Fixes: 1b51e5f4cd2a ("nitrogen6x: reserve used gpios")

Signed-off-by: Jacky Cao <Jacky.Cao@sony.com>
---
 board/boundary/nitrogen6x/nitrogen6x.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/board/boundary/nitrogen6x/nitrogen6x.c b/board/boundary/nitrog=
en6x/nitrogen6x.c
index 1adee9a461f..e45db109f4f 100644
--- a/board/boundary/nitrogen6x/nitrogen6x.c
+++ b/board/boundary/nitrogen6x/nitrogen6x.c
@@ -909,8 +909,10 @@ static const struct boot_mode board_boot_modes[] =3D {

 int misc_init_r(void)
 {
+#if defined(CONFIG_VIDEO_IPUV3)
        gpio_request(RGB_BACKLIGHT_GP, "lvds backlight");
        gpio_request(LVDS_BACKLIGHT_GP, "lvds backlight");
+#endif
        gpio_request(GP_USB_OTG_PWR, "usbotg power");
        gpio_request(IMX_GPIO_NR(7, 12), "usbh1 hub reset");
        gpio_request(IMX_GPIO_NR(2, 2), "back");
--
2.34.1


THE INFORMATION CONTAINED IN THIS DOCUMENT IS OF A PROPRIETARY NATURE AND I=
S INTENDED TO BE KEPT CONFIDENTIAL BETWEEN THE SENDER AND THE INTENDED RECI=
PIENT. IT MAY NOT BE REPRODUCED OR USED WITHOUT EXPRESS WRITTEN PERMISSION =
OF EZURIO
