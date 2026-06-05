Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FF59CD6E79
	for <u-boot@archiver.kernel.org>; Fri,  5 Jun 2026 12:28:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A82584931;
	Fri,  5 Jun 2026 14:27:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="lxNf+3fV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22447848D8; Fri,  5 Jun 2026 10:57:43 +0200 (CEST)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED0C38486D
 for <u-boot@lists.denx.de>; Fri,  5 Jun 2026 10:57:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chen.huei.lok@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TkX487otFAGG62D4prxcHUTQPAv7iR6sxNNRYc/Rzm9hK51PU/o9V1xuzOnIFvFzTsFyM2msMZvlxZ/GEOCQTnScXYXp8gsDQNm5riqX7TqE0AvQ812tsig7TujLNO50AYtQ+xNwxhKjuUYG0/HjenE1RioYdyZslSgJHxdyBP5VzzWZECTQ6tb1aEDzT7y4uujsY3Nx8B9Cw4Wrv8fgHqGcmsTEtzUz3lJ7fqJDHuoItpgRzCgW0etEUjGlwu7gW5lCHRJ14OHhedIKie+tsdIAaV7V8DeY9fVRFLcE9DiPIRCbvKmLKD32CGJYqOQC6ixlrIH1c9+q+X+RxHDnYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wO7U+VsWXcaQ76k5OGVOlyimy1M0JSkXA+ruAgS8fMw=;
 b=npFX7sOqbzwRMJNolEN+4bbFf/JtmSbEwh1j/bLQq9TbBIDbvdWk6gORJt+zk0Skl/+latFTTt3uFJgDT5vaJaQLb3/lpcGfvtpzB03wqXpOSZws3erMV9vtz/zIRoaf031DLCzF86deXAKwSIpmyekjZbuDKsHtv4OpzqsYZvrShCF1hpfTQBSlmzKdCbLSCRYlXfsegi4yCJwL38XR/91DylXDsGF4h83qjYVw+VUDxMh5uWbHf+d3rH5mXXtEiwxeS2LZ4w7Xn936+RJNN3t8t25DNSZG2qdSawtVNIu94HmuYWqP1tfVmHyvkBKqqZQgsRhrBVtHDsdej/9u7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wO7U+VsWXcaQ76k5OGVOlyimy1M0JSkXA+ruAgS8fMw=;
 b=lxNf+3fVyLoM8f4wWgTbWlK5+mc4nmAjppuTzg5xZXPmLYyox75hlXBfFseNuxU2qCUaUtseOUyLC5g8X/KxrArhjAsda2CvuzOYO9CW7LllJRmBsFRtvt/7T/tYqx+4WwlQ9DZk+BG0Q7aUrr2ZI259Mw1lf2KlSvT/mvCJLgUYJ7XolWYbErVLOQ4kpZIN4+mthE2+sH/3tg5YpZRQRjuk3UlqKPQJo9K7d4cUJWS1Q5FCLg0ddJ1NNO4UrD9UcQGGLTCIg7/vGowEqu7Z7nfYGrF4WoT3mUeLW4EnTpnOeW46/GNbltXESadmLA73YOYGOlQ17AAUtiWJzTgsBg==
Received: from CH4PR03MB8019.namprd03.prod.outlook.com (2603:10b6:610:242::16)
 by LV3PR03MB7755.namprd03.prod.outlook.com (2603:10b6:408:288::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.9; Fri, 5 Jun 2026
 08:57:38 +0000
Received: from CH4PR03MB8019.namprd03.prod.outlook.com
 ([fe80::adac:cf9b:26f0:6585]) by CH4PR03MB8019.namprd03.prod.outlook.com
 ([fe80::adac:cf9b:26f0:6585%3]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 08:57:38 +0000
From: "LOK, CHEN HUEI" <chen.huei.lok@altera.com>
To: "Chee, Tien Fong" <tien.fong.chee@altera.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>, Simon
 Goldschmidt <simon.k.r.goldschmidt@gmail.com>, "YUSLAIMI, ALIF ZAKUAN"
 <alif.zakuan.yuslaimi@altera.com>, "MANIYAM, DINESH"
 <dinesh.maniyam@altera.com>, "NG, BOON KHAI" <boon.khai.ng@altera.com>, "Hea, 
 Kok Kiang" <kok.kiang.hea@altera.com>
Subject: Re: [PATCH v2 6/8] arm: socfpga: n5x: switch firewall setup to driver
 model
Thread-Topic: [PATCH v2 6/8] arm: socfpga: n5x: switch firewall setup to
 driver model
Thread-Index: AQHc1tzB2HurqD1VLUCvFqG4xQ8HLbYM9+AAgCLrGlU=
Date: Fri, 5 Jun 2026 08:57:38 +0000
Message-ID: <CH4PR03MB8019AF92CAB38104E14F61D0C3112@CH4PR03MB8019.namprd03.prod.outlook.com>
References: <20260428070017.16807-1-chen.huei.lok@altera.com>
 <20260428070017.16807-7-chen.huei.lok@altera.com>
 <c328b9bf-0c49-47d4-b058-147aa6f15357@altera.com>
In-Reply-To: <c328b9bf-0c49-47d4-b058-147aa6f15357@altera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH4PR03MB8019:EE_|LV3PR03MB7755:EE_
x-ms-office365-filtering-correlation-id: 82e706ff-a6ea-43bf-0be4-08dec2e07e72
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|31052699007|39142699007|4143699003|56012099006|11063799006|18002099003|22082099003|8096899003|55112099003|38070700021;
x-microsoft-antispam-message-info: 4ZKf9K9yMAyFHYUO1J7LoF8uXC03ilesVmQ1F2xlpJ04x7nzOHQx8Pzpr2qvKRk3KL4p1PdI8n0PWvY36/3u4JI7vTMQm3yjUSiIhsTbjuojItuYM2Shxs/6FPNAx949bKVZuJ292SX+dSKZPMx57u30j2CBjVXNIFKlG44RJH/cwgz48+k+VOS6efI1+I+yqqpvDbW4lZj5Eom3kxLr3dKklMkygUM3dIxH2Rzlho2vvBYNrrRDBqkxVs89Qdu2dwJ3gtgQlJtfsaD4SKCU65l+6Y6awC7dVWZA8+RvORGSvJmLrEifsgCcD5LXChZfzJi08Hp7KfbCyA+ZZzYBqdm0WcLZJECiTeVN3sVA+YpuUtEFEn/KL1FcePAZ8U3ZJyJOqzwGkBjFFAxsaUSzSMeRMiUcDW9cPP8IXZVuH7BIijG3UdUbaTMuyg2nKjzVtLjAO4C+XQIiQM72LOXNgVQkszGVDMPTxuLQDSwdmfOJxKvPap31Mjg07i146ePsXOsuayHVlARXp2Rb7gSnvLKGTlEJvQXQP1cpjbTL2E/MzCMYMXebBbInGoXOTf+vdApRl9l0812YeVl6d3d3WWYK/tiE5a5LwPRwPQCzv4iPK3xzQ/ynulfuvDZf7PcQ9fkBXhRF2SkaWfZ96dPAFMoQstpZmhfVJxPA58QfQ50y31+tRThnJkgmXxBYCeYJtS/U3wJtatRWhyr2minOuTy7lURMj03qXlwnrPsQ0OIDbt3QLxwht1+WCIeKIAz3
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH4PR03MB8019.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(31052699007)(39142699007)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003)(8096899003)(55112099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?xHBoov/SEI1qMUKPM7CZNSFK+PfeRDUXdaCe4f2smYRANV9wY0IkW9+K?=
 =?Windows-1252?Q?IQgzh7NQGYjbNBZiD6HqQKeQLoN8ruZAMVWStgTxxJZq8NJ0c/ZBd00G?=
 =?Windows-1252?Q?wb1uEKOcZ4kvWdz9iXu0aahuA7NJ9QPW4m4+Hmq8OP1nsIz1ZdUM5YJE?=
 =?Windows-1252?Q?/Gu/1VvRF+SZX5KBdmmt8M0TLbSSV85kN0Va76zvSefXvNI3PMobZxyd?=
 =?Windows-1252?Q?dm/6j0c7Ph1YCuhjjndchNwmdKtewo+M6a/SlhWCu0vlg1TJ+Uf9wqeL?=
 =?Windows-1252?Q?lhJ+TR7qohGeRCMysUpYCQ3d0yR2Top2mUtqhVSnxztS8nj8JsHyjRgO?=
 =?Windows-1252?Q?+PvDSSN1zg5mQEBNTAVc9sgeuj8bMsnH6osiF/AOIH5xzTab6dnzpiWF?=
 =?Windows-1252?Q?EiA0ZFwAvxGWMi04feWKtRNfl8VsUztl8aukrTyP4bSqupIKcydAvJjc?=
 =?Windows-1252?Q?EIBus10w5GJVo7AUUx5jbUvw4XEWkGDqiLGb0pph0vh+1kgGwr1zwAIS?=
 =?Windows-1252?Q?62E/WriNH87yEFYkB16Hq7Udr/08eMHWCigLHtHgDqKcOJiIOv4ZNICL?=
 =?Windows-1252?Q?b6XnEWO4mPsayLBASsdFaJJTMXDaEGrzLSZhbBt1NIqdXdWAZ2bWVIVs?=
 =?Windows-1252?Q?3YX3iDYTXsjaOUcdWflNTClo8ShdWXvZMAB7ZdbVtc7ShPuH+sXk/P5v?=
 =?Windows-1252?Q?Don5hFX93ZBs1JuAy807lcKhOavz/cC4TULEbVbnankKxAx9Br/NJz8p?=
 =?Windows-1252?Q?FVE5xpsehvUXbJ1cEc8U5h2pSW9wKZ4kvN6DoW6zquqnXQZ7qdDhLayY?=
 =?Windows-1252?Q?5/Zqkc0qASoa234aRlHHBr5v+IV9j1sjsxNh2/xuyFYfTSNRgNxz0Wwm?=
 =?Windows-1252?Q?uZq7fqMpmK1G2T4w7CGCd4ZvJV6hzjgaPjoQlZfx+u503tzR1o8ZD0t7?=
 =?Windows-1252?Q?3JjrCAR+9i6kdBS9TVT0GjSkL1ViYb4iXibHGvwtRsw9OBUALMF8FyEr?=
 =?Windows-1252?Q?r+JeLRWXbkML3aTbup9Ij2ZTMWY53cjlUmrYOBruNRaZKIz/8PmaW0lR?=
 =?Windows-1252?Q?oSch+lnqEQ4OsBtMUX7B8e9QEXUKaCulJYayembid+gEBrkiuntzEBha?=
 =?Windows-1252?Q?5ixEZyyfW0js+vD3d4Sjlg0t+QnYGlJ3yNq3bzlZ4vIWEn3khLhqK8fT?=
 =?Windows-1252?Q?2uuLE/MH0wul0VLhSzBQNb8/Pk7cRynlzwAOVHeHZ7UjSBH5UTfeuZiz?=
 =?Windows-1252?Q?uXHarWXACxumW3LCtholcTVylmcQgAQdzShobZejOhDEd71daBqdywFh?=
 =?Windows-1252?Q?4V6rrhZ+5ePPj2U8rPjWXZmhdQBYtEnrfbs9R34LUVmdr0KJ/QdtNWWo?=
 =?Windows-1252?Q?Kq/gyszhxB/hkDAdqz8JwG0obPNCc8INNrHlZxg/6vwFqNBumj5P1eKO?=
 =?Windows-1252?Q?4uo+ibeBs6m8raD4Uj/J7RlOiT3JUnAXdi/UxezkP4x9T3mjo0Og6T0f?=
 =?Windows-1252?Q?/N7ZAnDQp9jh5Odykc5ntz4xu9L6RMIw4WSHVJUHGbhZF8/CcTBqsdNO?=
 =?Windows-1252?Q?fXCHmRuQLuSVcMTHWCbYmIX6mkbxeoByugGO4pXCxnEqZ8/ocKf5smWH?=
 =?Windows-1252?Q?rEC1EFV42iKzksXO2Fe/hNADjCbfVCbYUaMSLPwiGoAb017vSYsOfuZV?=
 =?Windows-1252?Q?jjlngGnh5+QZXGcOsTi666lMXwGiE9E4sixlX5zmFDtu0SY7AKqzqaiB?=
 =?Windows-1252?Q?RVQ0V+yNcjzbWI1SY8FWDCUyfB/wHtWnZLuhUqh+r5u2OqTp5bmRlBBd?=
 =?Windows-1252?Q?X7J/rv9EfbKAGwcuMMGRv3ZySn4RWUoLAtEgTy7PAOyxv3koPMF/GGuy?=
 =?Windows-1252?Q?PS1Z/5lHX8IwHg=3D=3D?=
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH4PR03MB8019.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82e706ff-a6ea-43bf-0be4-08dec2e07e72
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2026 08:57:38.2825 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MO0kNxwEeGaHKozIAl/11n1FKS/VIongwJSxFaOaul1lOFwKThwS0aIe8L+XsyAVRVGg2puyqnrh55L/CtfU1foh6tVUqyyBdnLaFbUadI8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR03MB7755
X-Mailman-Approved-At: Fri, 05 Jun 2026 14:27:55 +0200
Content-Type: text/plain; charset="Windows-1252"
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

Hi Tien Fong,

On 28/4/2026 3:00 pm, Tien Fong Chee wrote:
> If firewall_setup() is defined in a separate source file (which is
> implied by the function call existing before this patch),
> removing its only call site should prompt deletion of the function
> definition too.
>
> Without that, the linker may still include the dead code.
>
> The diff should include the removal of the firewall_setup() implementatio=
n.

Addressed in v3 =97 extended this patch to fully remove the
dead code: deleted firewall.c, removed firewall.o from the Makefile,
removed the declaration and unused struct/macro definitions from
firewall.h, and dropped the stale include from spl_n5x.c.

This series depends on Alif's series which removes the last
firewall_setup() call in spl_s10.c =97 will document this dependency
in the v3 cover letter.

Best regards,
Lok
