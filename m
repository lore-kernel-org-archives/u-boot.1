Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A364C606A323
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 14:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=qFFeEVwl
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 413EF40800;
	Tue, 17 Nov 2026 14:01:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WH2mf45YYXMb; Tue, 17 Nov 2026 14:01:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8D8CB4053E
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794924073;
	b=TP/dC9DRJen6pH7F0dcghk1NwjpuEbmSvX/hYD1gdgPcpo/KkdA/HmfKPzUOZBgPQeED
	 AnRV2aOvR78p/lNjzLu0XurVhWl6wG595HKjRmHduxR0ASwdsXR0osF9Tg2eEeEfaEpHC
	 uskLoctXtSEACrcVnMBeTCC3hFo/sV/+LqIxHQa8PRSvzCBlNkHCtqwy5vd8OgassSP2x
	 WsEcKdra2bTcp2GW+EeV72ifmnSjLk0+rGwKzpz2FGcGJ2acxUcbf8yq8J+oc5ce2ui2W
	 DZD/SC1+GUdmdxt2v8d1dE8pvQ9tg/68Ry/L1lI6OI/E7kV3GkniD+qppUzckAN1F8g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794924073;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:Received:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
	 Message-ID:References:In-Reply-To:Accept-Language:Content-Language:
	 X-MS-Has-Attach:X-MS-TNEF-Correlator:x-ms-publictraffictype:
	 x-ms-traffictypediagnostic:x-ms-office365-filtering-correlation-id:
	 x-ms-exchange-senderadcheck:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=wT5NolQvWnwJ9rnPpRGrXfmAWsHfFKhyDkeorimotHM=;
	b=p2z7db124v9Wa85WBguDAOxDc0V557MENlfrVcHTJNx78ZFxbMEnEuLR/vYp0jfK0jX0
	 V7sOyVCsSwVRkN7dpjvKg9hF9K0qSV7SM8HbPtsEF9RIUXIhRPFqhDoer2btrrMO3EFIY
	 UUsatWKlmyvYjLYKSi0ctGejDVE/z81tSQ943Y3gK7XvbRqz7G+Tfn/X0dqSMpTw8kyCR
	 DQGAXpBwwbAa2zYAnuviwiQxpKO5pkR9uXyoQXfsg7LYIfa92/o4rhROP8Hcq/poNr6dN
	 nb8e+s7MCiqHmdA2NlrnIULceVgpIlEcRG1htApzc91Hzuf69/kivU55nnYILZWdfhw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794924073;
	bh=wT5NolQvWnwJ9rnPpRGrXfmAWsHfFKhyDkeorimotHM=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qFFeEVwlUtN9njR2nJqHaTRbZ1g80IT2B+TvSiV8RwPAWzaE5WnBU4LCFVe64j0D+
	 F7odMaUc7In2+E/3OeBQBQ3+L4O8Ok778tM/Lj/Q4Btg8joFKIiIomZJH6KexTmazS
	 mq8s+G6UvPwXKqnx7xA8CxjrB3nT6Ws+pD5P4Nndvv50Li4TpiIIBypahWaNnqB8KI
	 cDLb2E0c4jVhxdpyOWjDLt4VB4hwzLqzJLeMkhF3vlPHtYECDuJKaJ9Q3U483u/vyu
	 EzLNunkfWsJHm9hZra73dsdgy5j3e7jir54QVe2xg0Xtowc0BZFhIsP/vccBGHSpq7
	 TEYui/viBRXEA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8D8CB4053E;
	Tue, 17 Nov 2026 14:01:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8EF402FB
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 14:01:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 74BFB80BCF
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 14:01:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Bnx0yfwmrJFQ for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 14:01:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3FD7681137
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2406:e500:4440:2::72c"
X-Greylist: delayed 883 seconds by postgrey-1.37 at util1.osuosl.org;
 Tue, 17 Nov 2026 14:01:05 UTC
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=starfivetech.com
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2406:e500:4440:2::72c;
 helo=chn02-bjs-obe.outbound.protection.partner.outlook.cn;
 envelope-from=hal.feng@starfivetech.com; receiver=<UNKNOWN> 
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on2072c.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::72c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3FD7681137
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 14:01:05 +0000 (UTC)
Received: from NT0PR01MB1102.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:7::10) by NT0PR01MB1151.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:11::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Tue, 17 Nov
 2026 13:46:14 +0000
Received: from NT0PR01MB1102.CHNPR01.prod.partner.outlook.cn
 ([fe80::be4a:d29e:5188:b37e]) by
 NT0PR01MB1102.CHNPR01.prod.partner.outlook.cn ([fe80::be4a:d29e:5188:b37e%3])
 with mapi id 15.21.0615.009; Tue, 17 Nov 2026 13:46:14 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>
CC: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Aspeed BMC SW team
 <BMC-SW@aspeedtech.com>, Bin Liu <b-liu@ti.com>, Bradley Morgan
 <bradley.morgan@linux.dev>, Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>, David Lechner
 <dlechner@baylibre.com>, Fabio Estevam <festevam@gmail.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Igor Belwon
 <igor.belwon@mentallysanemainliners.org>, Joel Stanley <joel@jms.id.au>,
 Julien Stephan <jstephan@baylibre.com>, Mario Six <mario.six@gdsys.cc>, Neha
 Malcom Francis <n-francis@ti.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Peng Fan <peng.fan@nxp.com>, Ryan Chen
 <ryan_chen@aspeedtech.com>, Ryder Lee <ryder.lee@mediatek.com>, Stefano Babic
 <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>, Weijie Gao
 <weijie.gao@mediatek.com>, "uboot-stm32@st-md-mailman.stormreply.com"
 <uboot-stm32@st-md-mailman.stormreply.com>
Subject: RE: [PATCH] ram: Constify driver ops
Thread-Topic: [PATCH] ram: Constify driver ops
Thread-Index: AQHddfHgcBUz9kqaCUCckUYjsnFCa7cyRu/g
Date: Tue, 17 Nov 2026 13:46:14 +0000
Message-ID: <NT0PR01MB1102C3EE636A16B05F2F6EFDE67B2@NT0PR01MB1102.CHNPR01.prod.partner.outlook.cn>
References: <20261116174226.3488225-1-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20261116174226.3488225-1-marek.vasut+renesas@mailbox.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: NT0PR01MB1102:EE_|NT0PR01MB1151:EE_
x-ms-office365-filtering-correlation-id: 455093f5-0d44-427c-5c26-08df44b125b6
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|7416014|366016|22082099003|261009223027099003|18002099003|56012099006|10067099003|261102123227099003|38070700021|261022105027099003|261021123027099003|261026140227099003|261021121427099003|261028144727099003;
x-microsoft-antispam-message-info: Yd/w1ZXu3OPAlrXQTO/nnJboVs+ZjrboWomsFSf37sQ+Hg1U0XDMeg7waeQwJLh4b+g8jR2fhkF7rUS3WcuJblAcxSUtKlLRHuAo864mWa362VJzQQ5a2o5oQZ9NIq72mq7xldN5DNHMaXO8wN5+GiEr2UywFuaug97J5mVrrwSF8rMViaGnSOIGvR0B1O+2yfwH9MtYU29YNaEFHPAW6KQB5lzvivGXz3fbOvXnRjABkKyUxK0Yc6aTfOlAdaVaM7sAAG7ts5idAhdr9mmT5coyjjR61yfvVBtosBnd5n/Nh3OjujYe9KfRPkbCo8l37oSPMhsKY56+ZnPnSgkFHkv5ACSbKUtK3ZVXqG3WvWtS3lpqgQTFtJK5wl+/N2xWX2vc59fTbtaGJiOQpgWUx9sasNrpkClrgXUUoM2ivtdbUQlZ20vwAxfk4MjlW9vxF0lX8or3VJiWKiWuoEOwrfdcaBOEZFLh9rpiaEdXm1bmhWSdaEIExo+8yyjU4acK8SCepNBwIvomPlkSthOZAgbE+N4eqWI3jOnQWYRm5+C0GOlFZtlBs58Yd+FsG9QT
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:NT0PR01MB1102.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(366016)(22082099003)(261009223027099003)(18002099003)(56012099006)(10067099003)(261102123227099003)(38070700021)(261022105027099003)(261021123027099003)(261026140227099003)(261021121427099003)(261028144727099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ANEZn+St0wqN8nBPhHL/GgZghPMeKvPNg/QhPHsBGqTxyId5RjnExKMC1wwL?=
 =?us-ascii?Q?tj7ixrM6QeVZlUa0iJpRUIEbDRdcnEYNIjBTjzcBaqH45BJoXAafbDr50vXk?=
 =?us-ascii?Q?jACtKylDuP/VlzCFGL+GJeDWB9Mu5HpUFTKoGRnVurMyeWuQ49cmdKq+iwRf?=
 =?us-ascii?Q?/B7SWRFNS9Gr7oVYZi1MqaOxEeG9SutNstN7BRN7858xIiJwwkSS7cjWapWi?=
 =?us-ascii?Q?eowdVCMHW1N0zHRTzz4EnMM6zUOFQUyvsKcrBKAZHa9F3j8dFgVsLu5LOPyZ?=
 =?us-ascii?Q?G2Ap6Q9GdtFDe24kN3AlA8sS0aqJsbXzzvMZOa0jLd7dUDAEEZXYpDHsXq6p?=
 =?us-ascii?Q?J5EGsro5ufUq3jTtCqzVex9F25CMfsMgbQKprKulkLDKpYU/RAPx46wcdsfK?=
 =?us-ascii?Q?xKQfJRkzCAh/1GvPJuU3ng5NNyEWHMoAwVn3M+zRY1HzL9B5Zf/qf6qJNh9A?=
 =?us-ascii?Q?vhNUt7yo7zkRTMmxsIGGtK3TbN8reYF8Uq5uhHE3qny6cGgy9QPLbAXgEf8e?=
 =?us-ascii?Q?BiGS+G2/+8waosoCex/MCs4NBHd41o5gywhjXxJ7uIXpqWrwUhKE9fmJ7Wiu?=
 =?us-ascii?Q?oAGQAJWrpQYiDTqMbIYVrTuZpTzfgXHv+YIPisXomP4WnN9tG57XtIsiAU0K?=
 =?us-ascii?Q?UYOtpEp3WWt513pYpERIqGn7L7M0f900Xhbn5MSmdMJtqV6L0njG0SN3aOY9?=
 =?us-ascii?Q?yoHPxQFnZLzbLNr2SxqchLtH1a7X0aY7t31dBz3/swv6+DcqhqMXK/jCUSsf?=
 =?us-ascii?Q?pLMqEhT6hpX97yx/Agwxxaj1xyfKQGyuFj3EsoW0IcgfXem91OJh1vPakpF/?=
 =?us-ascii?Q?W14ZEs7t+FIgo6aTQNrOQZXFfFct0NlIxe439m/byaA6VY7poJfYE3wMb6WX?=
 =?us-ascii?Q?VoPLu462orkxik37gfF6xpnm1GXxRqOcXfxBt8FlaU6Vy0D0hB0HFDPhdiC6?=
 =?us-ascii?Q?ckhIZhzYiCEwdtSnAs3eqlHC2DFyiycaHaZOaBmM2DUTL7OU3wr5v8YZH4Wd?=
 =?us-ascii?Q?BRGm34W1byO9QbHfnPLK2mUWxvg+g5kuf9HjCjJn2DlT9TS0J3DjhCqDxNHa?=
 =?us-ascii?Q?BExJaDxyor5KRXg+4ktiW/sAX1uLShr/eOvc4b7mp/rz+wol9WChPimyLtkK?=
 =?us-ascii?Q?k5w21tTozR3Nxw4CgWHYnM6zDrO+hpxo3/EfPfT5RciXNdSJlPWJ3pqTQGA6?=
 =?us-ascii?Q?21qWexzXO61bmYEvct0XbPUPQgtB/b95bJOyueAHfXFxcvHKky0xI0svPpUW?=
 =?us-ascii?Q?wLYz9b9lWKn92+XA4/N0gOWGyX1Hyjy5Gk3qDVqhkqGcWYSVj3dIVNQQS/7P?=
 =?us-ascii?Q?tV05LLWNzkq7XexjkYn5agmOOjbWNDPEqaaOMWCMwatFTmOmuH48BoKWk6cw?=
 =?us-ascii?Q?QG36qhFo/ue0eai+SxzeIz8ncms6bnPWBgUtKBJhKcmYN3oFceCUacHifdh1?=
 =?us-ascii?Q?5OSi63+MqJrARbOKMH8tjWucNyPQM9iBPkGjEANa5hOswJnmcIelVUWn3HTE?=
 =?us-ascii?Q?en5NT9K4fUwpOQxSNgUUCvJbVFoGA1950te3dmJExtnNl1ClXgAVPQONhT0r?=
 =?us-ascii?Q?ck4E5rRTuF9mIO6KHAMO/N9nID8fi9ikJhuAhkBEK29RC0PqS6eE2yFuAxt9?=
 =?us-ascii?Q?rh8EK0DyPH6uMOTlIG5xUQZQUX2HylCLLiL20Y+szviuMWmCaPkm9l3KR2tC?=
 =?us-ascii?Q?y/Wu5TVYfkbhJ+q1rpTB0eZfGglCB5+WcdfM1UmeZGae1UojUAlJdb56546Y?=
 =?us-ascii?Q?JkvVxPaBDA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: NT0PR01MB1102.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 455093f5-0d44-427c-5c26-08df44b125b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2026 13:46:14.1634 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Otyr+mSl84fKvnfiPE8+2kjtlibgGFWqe61nojb4QSBxd0KRFOBgCE6C0wF7mTjMew9c8gE15uIgZSb9P/4EdVYKhAKnlVo7IxaOGqRktYg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NT0PR01MB1151
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> On 26.10.15 18:27, Marek Vasut wrote:
> Set the ops structure as static const. The structure is not accessible fr=
om
> outside of this driver and is not going to be modified at runtime.
>=20
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
> Cc: Aspeed BMC SW team <BMC-SW@aspeedtech.com>
> Cc: Bin Liu <b-liu@ti.com>
> Cc: Bradley Morgan <bradley.morgan@linux.dev>
> Cc: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
> Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>
> Cc: David Lechner <dlechner@baylibre.com>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: GSS_MTK_Uboot_upstream
> <GSS_MTK_Uboot_upstream@mediatek.com>
> Cc: Hal Feng <hal.feng@starfivetech.com>
> Cc: Igor Belwon <igor.belwon@mentallysanemainliners.org>
> Cc: Joel Stanley <joel@jms.id.au>
> Cc: Julien Stephan <jstephan@baylibre.com>
> Cc: Mario Six <mario.six@gdsys.cc>
> Cc: Minda Chen <minda.chen@starfivetech.com>
> Cc: Neha Malcom Francis <n-francis@ti.com>
> Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Cc: Peng Fan <peng.fan@nxp.com>
> Cc: Ryan Chen <ryan_chen@aspeedtech.com>
> Cc: Ryder Lee <ryder.lee@mediatek.com>
> Cc: Stefano Babic <sbabic@nabladev.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Weijie Gao <weijie.gao@mediatek.com>
> Cc: u-boot@lists.u-boot-project.org
> Cc: uboot-stm32@st-md-mailman.stormreply.com
> ---
>  drivers/ram/aspeed/sdram_ast2500.c   | 2 +-
>  drivers/ram/aspeed/sdram_ast2600.c   | 2 +-
>  drivers/ram/aspeed/sdram_ast2700.c   | 2 +-
>  drivers/ram/imxrt_sdram.c            | 2 +-
>  drivers/ram/k3-am654-ddrss.c         | 2 +-
>  drivers/ram/k3-ddrss/k3-ddrss.c      | 2 +-
>  drivers/ram/mediatek/ddr3-mt7629.c   | 2 +-
>  drivers/ram/mpc83xx_sdram.c          | 2 +-
>  drivers/ram/octeon/octeon_ddr.c      | 2 +-
>  drivers/ram/renesas/rzn1/ddr_async.c | 2 +-
>  drivers/ram/sifive/sifive_ddr.c      | 2 +-
>  drivers/ram/starfive/starfive_ddr.c  | 2 +-
>  drivers/ram/stm32_sdram.c            | 2 +-
>  drivers/ram/stm32mp1/stm32mp1_ram.c  | 2 +-
>  drivers/ram/sunxi/dram_sun20i_d1.c   | 2 +-
>  15 files changed, 15 insertions(+), 15 deletions(-)
>=20
...
> diff --git a/drivers/ram/starfive/starfive_ddr.c
> b/drivers/ram/starfive/starfive_ddr.c
> index e151179398f..9083f421b41 100644
> --- a/drivers/ram/starfive/starfive_ddr.c
> +++ b/drivers/ram/starfive/starfive_ddr.c
> @@ -138,7 +138,7 @@ static int starfive_ddr_get_info(struct udevice *dev,
> struct ram_info *info)
>  	return 0;
>  }
>=20
> -static struct ram_ops starfive_ddr_ops =3D {
> +static const struct ram_ops starfive_ddr_ops =3D {
>  	.get_info =3D starfive_ddr_get_info,
>  };
>=20

Reviewed-by: Hal Feng <hal.feng@starfivetech.com>

Best regards,
Hal

...
