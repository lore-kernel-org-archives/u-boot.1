Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 667BCCD8C92
	for <u-boot@archiver.kernel.org>; Mon,  8 Jun 2026 07:45:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B142C846D3;
	Mon,  8 Jun 2026 09:45:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="ZWcqFiJ1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1160683EEF; Mon,  8 Jun 2026 03:19:23 +0200 (CEST)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazlp17011000f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c100::f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF9B383314
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 03:19:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chen.huei.lok@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sBlR5A0qcPJK0gpeiACQ6LdM+TkboMO5BqyEybApeYjOxit0JksRW8VBicqgQGisi3Pt92vN+sWyBhztiHBOuKbfJYIDz1vMsTgulPwrqCkURVWGBgsgsWTK1VWpOvZEeF8bbYoQvmcRV0KV59WJvSQ44xu/GJUj7TkhTdZKWdo8K+Qn6yxvSE6dIB30joQZkpDgASnQPUvbgZHeW6did7y5mN9yolIU0OEWiAGqvJhv3IPyHWiVgqCKMpX37JxAtLHU4MAAHCQ3F8fzPT1qxI/0bSnV2cdoboxYzxB2GAKOSje+L5MkDzepGYmYRLhaZ2ZPiSCPV/CJa0/zaGeEBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BCJCHiaWr82SmMTx5rcicSJZndY2rqWtzqhX3/MiNj4=;
 b=HstevYiyiAXYvKgGeUDrjU2VvOQhZv0WyFbiYjr23XC17eol2bSQDxjhoqHcqPVP7HDR5J+/KUNavXQ026VsziO8pn3ioydOBOorg06qJBHR2sVN2jtoGPossBwd3UNLKt9e6tCbHSDLW2dheyfNwfzBRGCmfV8uYd/oMwzFeO9TJBLUZJRyVf8G9mLWFSe+uX15t5pUYctDHt4Kg2JZJzCAfPJ0sEK3JiQqaSGiJLBJyd4m/JNxG8Ep/jeGQSP41DXAWhn5rcWEHFzoAQDp012nWzfXOOZtDjwNyFVnPWW5Si6nenYkWjvh7IGMyqEr6bopxf4uNZX6p3H4uMFWKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BCJCHiaWr82SmMTx5rcicSJZndY2rqWtzqhX3/MiNj4=;
 b=ZWcqFiJ1BJttcQaWtS4JDfXNRFUSoIwn6Yabeojc/tCDABvef/C9jVQsMY3Xc+ZYTOiu8D3LZETcYooNHfdg6J20ZIBbny6XewqSRY4nL92RNqNV8smx1509WpHouiYfCxff7Llq5OAK9YB0HC6BPsYiTUHcSWlt9+yzjM8MlYA3Krd0j76XzevOy25YJ2uTQUy8OpSsjex/vNePuUE04n0TSi+4p0EXmSNYyJDwXbZf4ggr5EqDPT1YU2u3XC0xyrJ3pXvy92+4AiaPYXZJxO2kixKy4WiU+beljAyIQnIfcVUJxQFjm0rpWeVHypJYBBe031K7zItlDRYREjH+uw==
Received: from IA3PR03MB8021.namprd03.prod.outlook.com (2603:10b6:208:502::17)
 by CH5PR03MB7813.namprd03.prod.outlook.com (2603:10b6:610:211::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Mon, 8 Jun 2026
 01:19:17 +0000
Received: from IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad]) by IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad%6]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 01:19:16 +0000
From: "LOK, CHEN HUEI" <chen.huei.lok@altera.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Michal Simek <michal.simek@amd.com>, Alexander Dahl <ada@thorsis.com>, Tom
 Rini <trini@konsulko.com>, "Chee, Tien Fong" <tien.fong.chee@altera.com>, 
 "YUSLAIMI, ALIF ZAKUAN" <alif.zakuan.yuslaimi@altera.com>, "MANIYAM,
 DINESH"
 <dinesh.maniyam@altera.com>, "NG, BOON KHAI" <boon.khai.ng@altera.com>, "Hea, 
 Kok Kiang" <kok.kiang.hea@altera.com>, "Rosdi, Danish Ahmad"
 <danish.ahmad.rosdi@altera.com>, "LOK, CHEN HUEI" <chen.huei.lok@altera.com>
Subject: Re: [PATCH v4] drivers: fpga: Use FPGA_INTEL_SDM_MAILBOX conditional
 instead of Agilex/Stratix10
Thread-Topic: [PATCH v4] drivers: fpga: Use FPGA_INTEL_SDM_MAILBOX conditional
 instead of Agilex/Stratix10
Thread-Index: AQHc1tApwUFoyAnwhkGP057WCjDO9bY0GU87
Date: Mon, 8 Jun 2026 01:19:16 +0000
Message-ID: <IA3PR03MB80212DA982EA73C977D48CFBC31C2@IA3PR03MB8021.namprd03.prod.outlook.com>
References: <20260428053030.19532-1-chen.huei.lok@altera.com>
In-Reply-To: <20260428053030.19532-1-chen.huei.lok@altera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR03MB8021:EE_|CH5PR03MB7813:EE_
x-ms-office365-filtering-correlation-id: f983f465-06f2-43cb-dd64-08dec4fbf58b
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|55112099003|38070700021|56012099006|11063799006|18002099003|22082099003;
x-microsoft-antispam-message-info: UlUBBxrnsIsVO4U1Xd+Z3gptdMg8Xy4QaS2m5Xucc93p5FGHSjllG4La0pkYu/oKlXg2/k8cKpq9XcmMYBi2ebf6nslxlishcFLOywWYOrJIQJ91C40CKTWGJ6/MRfwBdo8wPk+RFmQBvrVCwUUXPHliOUAl9PEw6nw8UNLAdl8t0FFM5SThCYJBmVlh5nIUtTByzsY0onR5kigMg5qzVIclnc2/sq5ncUcFGHArATSVFEeq+Ma3mpX362vLgiuiBGxGGQnpPwy4cFdKeRtyHuddoTk0YL1R1zeGOLkrfJ1ScAmCmLRXp2+gBeSD2gZTg9d+oUvyCK6YUzhDemy3Hoi02MhaQLi0ZJYcNwbSl9veSMT/gauH2D6XNcjiIQn03WI8/hEwQMGNU1etsedJh7I2WBUiml6yCrLIL1go9dQSh625RtFRsX0Pbixva7UottYY7iYb119VgR/JyWNScr3yH/BAxcz2PWmWbuqruH2j3aR0niyNMMu5ZLlDI6R95EhFI5EG1q8wRhpWROIiABwcQ8Soq5Up/3VkttczsfjeTlkNuY5oR7ANWTdQr+IGgi1xkLGgqfQv1VSoX2IJr/ZrSti3W0v9eg94pj5D7lCk3Flb08Kg3A9oedKLun6UX1qTPQ2sYgOhgsnzWuIrVpo31f9P6pradidBXhLmAu2ozFlUSf5FkYPL7akEmV+1Cq9TZPdKQVrapppdKtoAXT9v7+nXpxUvwS3cUEcpXP5cVd+a1I37oP3s+6LQckqZ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR03MB8021.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(55112099003)(38070700021)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?RVMROpyUa+7jSmjGdSIuCvgxdiw9Nk6crlVtkMSkV4odfI9MsPellyulsl?=
 =?iso-8859-1?Q?RqnhFyL1yWYLTbQ6YKQxhHaIn/alGD++lfIYj3dr2kB58VcbRnbYSmrQch?=
 =?iso-8859-1?Q?i5e7nQBDNOFvErRS09uz2Ye3jyt2pRhjqwJRNPC8Gvi8CEUd72Hjca9C9t?=
 =?iso-8859-1?Q?Yn2sK6C2BEuOKugNFhsqCZiGVA1VbUwjr9gUFC2tNn75raDg+80vOwGsaj?=
 =?iso-8859-1?Q?Cu+dDte4U3crw76lpzhrp1ZwxS82sqvMWIp8VQ0PcWes6yp6v41T9haiTy?=
 =?iso-8859-1?Q?R6YgYuLy+crvzUsvOCyrqg5+9LbZbMoyMNN01yYEirnnNd+JNJOpvyFSfr?=
 =?iso-8859-1?Q?d1tghyuMRyEwgSDL893TOBMWpxmax/PN3zq+zDiO6SDbac23ss1QJincNg?=
 =?iso-8859-1?Q?9VOYsmyM8QEcDQaoWg/CA524zdWsnmKAZ1qF6Enwa1M6O3xbizpG8MWgTW?=
 =?iso-8859-1?Q?Do+LThYk9lQsFxKM4rUmZ3LBInYM+/NQiIBBI+FvPzh9FiSqtcgy8jlM/F?=
 =?iso-8859-1?Q?e65oQuRxIFrIrzFloDD83Isil+/qm58XiE09DXANr7PcGxDCeYgWTf2eh/?=
 =?iso-8859-1?Q?CxM/fnSIyIiEmMwER6DKXB6XwgcgrUKSpo7rqbrB2lOSo47nI3hDJcw9nv?=
 =?iso-8859-1?Q?JoAJMlBl/xsPVwql3PBwM0iGtgncprt/5MLDuZLGXwMjiANNYRGseFm6N3?=
 =?iso-8859-1?Q?kaRUAp1VYkBY6yr0d7NgD/q5k4Q4+VclRoJVULjOBUxCGr27y+1837Xv9I?=
 =?iso-8859-1?Q?sRzNQvCk7NTTZtsH2WYyUgvuYdS+yKZF4hY//+NaKTwrCsh9EP3yfAVkwH?=
 =?iso-8859-1?Q?dvrF3BA3rVnb15GMs9QEnP3Fnxf6aVL0LzilF5ZgbkFSGB6h07eq+32O3T?=
 =?iso-8859-1?Q?JzQz71rNDVZVil1mcXPp7Oo6mvxPzRWgV06dyzfjb94mrdMru9yoTk6W41?=
 =?iso-8859-1?Q?VxYACJWWw29zEFmwpwM2HipgsgTFRlKcuX9fR77JOMmkaqExoVfHH94Z/K?=
 =?iso-8859-1?Q?9RL9WNoPlysxbLbi1Kl9oDhoTKQVG+33V3E88fuVl7Ha7V+QNjyGknggVF?=
 =?iso-8859-1?Q?22tlhYQ8T5ahcdWl14cvis41oHT0kZdrqNwsk0+aWn/2rlZmwKTxu9pv+q?=
 =?iso-8859-1?Q?qGOXH1xyEAEwYlc/4kej//HuWN/Xnn2QpfC4kTktnvGqHo3wdl9upNScXR?=
 =?iso-8859-1?Q?VCdz+6guevczahDWehIhpVcIwcOge04igAIIr1L4nIZ8wOmrsDfFqdxnYO?=
 =?iso-8859-1?Q?pbIUCevkbfNv9AHI047cEkDsIrZCCfeopEQIdGqu1xF/JKzYl/8xwc+csF?=
 =?iso-8859-1?Q?gMGTNxwjGre6uoQmvQabRu+Rs7AwJwPN+HUcihc8NA/lOGaNlvuiUrkL+i?=
 =?iso-8859-1?Q?0r/yoZV9bm7t90MWMl17rVXZiR6tn+hxSGRAWV2t7RRihs14G3mntj/RLA?=
 =?iso-8859-1?Q?+N63YtN3I+PSuXWTWEBCwdeut74DHdJQGW5VQmR5G1KOwCw+h8r/WB5o05?=
 =?iso-8859-1?Q?yyxZtmOvWhSEWZduqpiO5/Pf2wcVNt4uVdZMS9V3bH/ARI5jrEOen8PdS1?=
 =?iso-8859-1?Q?bo2BBie0MXJk2BDfVaKUaUBm0lQub/ImOR43vnPWPcW+6NjmpFf0rk/gpY?=
 =?iso-8859-1?Q?/OXIlVk+cVECzUufA2NylSOp9LnGbdTmwgbBVSLVrz8VO5GXdLPyW/jXez?=
 =?iso-8859-1?Q?2bQsRo5rQaSkwSbykZuv0wqx1SLWQZ2T86+EwgJA+PsdH/fy2hoVBJutNI?=
 =?iso-8859-1?Q?kGIJICobZbTcl9u0DZf/mu1EG3r2vx84RXhiH31Pg+lpKtXYLSjiYjBsxl?=
 =?iso-8859-1?Q?zNXrLq5QXw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR03MB8021.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f983f465-06f2-43cb-dd64-08dec4fbf58b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2026 01:19:16.8253 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 02LmxJf4pf+VmbfJ5fP5FyuK7u1JvZZs6yHywfbR/rTgr39XC3wqp+bULUaU23OyHvjBKmSqZ58oTD0f1O8P710Mw8et1tMg8MWmqj6y6dw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH5PR03MB7813
X-Mailman-Approved-At: Mon, 08 Jun 2026 09:45:15 +0200
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

Hi Michal,=0A=
=0A=
Following up on this v4 -- this addresses Tien Fong's review from v3=0A=
by switching to CONFIG_FPGA_INTEL_SDM_MAILBOX as the conditional=0A=
instead of the per-SoC arch checks.=0A=
=0A=
> Replace the conditional compilation checks for=0A=
> CONFIG_ARCH_SOCFPGA_AGILEX and CONFIG_ARCH_SOCFPGA_STRATIX10 with=0A=
> CONFIG_FPGA_INTEL_SDM_MAILBOX.=0A=
>=0A=
> Signed-off-by: drosdi <danish.ahmad.rosdi@altera.com>=0A=
> Signed-off-by: Chen Huei Lok <chen.huei.lok@altera.com>=0A=
> ---=0A=
> v3->v4:=0A=
> --------=0A=
> Replace conditional check with CONFIG_FPGA_INTEL_SDM_MAILBOX.=0A=
=0A=
Tien Fong, could you provide your Reviewed-by if this looks correct=0A=
to you?=0A=
=0A=
Thanks,=0A=
Lok=
