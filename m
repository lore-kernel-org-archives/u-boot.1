Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52885F531F8
	for <u-boot@archiver.kernel.org>; Tue, 14 Apr 2026 07:15:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C25483EC6;
	Tue, 14 Apr 2026 09:15:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="Efv6DbZB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F9B084119; Tue, 14 Apr 2026 09:15:23 +0200 (CEST)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1554838BB
 for <u-boot@lists.denx.de>; Tue, 14 Apr 2026 09:15:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AVZluALk2TPrAN0L3BMhq83gvFVcg0fQ030uWEac+JE1/uPgw5fjEwV8ucQT+1ZHDBWgDrPr9HWbZ4sSfwe3MFL4JN7JqMCveoeyyasqZjBapT9rUt2McRc2c4RwvKimx2wy6J5ZyqZYVltU6klIZCvJ8ZsXpCFSppnYPYX1884EuvDs0H7xa1NSMFfBB4rZDXPRYUsM+qhBx8loGZ6IzFmkgmE1e/vs5BNL96aW5Av6ndZCg1PkoCOkRiHg/BJre8u5tzpPuGDPiPSt/Odd90MwqVPKZ0bIfMXZCEg4UjFWaf0hjgHYahqI3ZQ3cSaYTnIDWL64xpxqlcot7WN+Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=79Eqm58GzXEU29irO64H4bO6mahHkG6Uk8hw+6Ksxmc=;
 b=uf+vS9xvkfho0bnHNYTbf5FOT9uDFxp+6r4Czff6TQ/WS4kwTwTgOhSuFbayuxOjBWfx0a/Y1JqDGbci1leyWR11UuiwXuIW5gXWHmKpbpudykVr6QfwKUnViqZnYOdMBtrK+M6gMylZ0Xbxk16WnznzRrlqRq/ykYsvo8tLyN6bD8rHoa6JHf2iCQVQwlUtkXS4fjRUcwpXgmCCtLX37jScXv/1m2fsNwPr72lPqEfo7ZEYeq7vjxVYVw6B8+uGv6O5i/VHI8iy4xYZaM6UcQP+mVhywrRTewEvu0LBJZuuvOwN15k1X1NsC1dLrnioVVs8lU9mpMuQe16XzinvMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=79Eqm58GzXEU29irO64H4bO6mahHkG6Uk8hw+6Ksxmc=;
 b=Efv6DbZBH9702wftZWTYP729ZSnEDqTSnENOw9lmTznXQ5ALp8rCqNWhRsDyz2+TmQEvKE6YpZGFn+zitn3jf7KENOz/uqHHb3xzAZXXKlme6xyZ5UOGotNsDoqUDfifOOiGRUb3uTmvEUkpFcZnalGKWlVu+YjWQiDnfZOWWvxd3vd+vDevRUgKkXoJsI5QolrwzSIhisiUTnRAZ7qAeio/VdBaMPXUBQidmKKqacJmGKj1e+Bm9aQlkiU394Gb3GkQM8nDLH6jIauKF4CuQL158U/xj1TEaG2Ml6ZCzakqXiWnh6ED5CclG0ItvvUg9MZ303pngDF4rKJ4qExn3A==
Received: from CY1PR03MB8121.namprd03.prod.outlook.com (2603:10b6:930:106::16)
 by SJ0PR03MB6676.namprd03.prod.outlook.com (2603:10b6:a03:389::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Tue, 14 Apr
 2026 07:15:17 +0000
Received: from CY1PR03MB8121.namprd03.prod.outlook.com
 ([fe80::fe3c:a06b:8724:fab0]) by CY1PR03MB8121.namprd03.prod.outlook.com
 ([fe80::fe3c:a06b:8724:fab0%6]) with mapi id 15.20.9769.046; Tue, 14 Apr 2026
 07:15:16 +0000
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
To: "NG, BOON KHAI" <boon.khai.ng@altera.com>, U-boot Openlist
 <u-boot@lists.denx.de>
CC: "YUSLAIMI, ALIF ZAKUAN" <alif.zakuan.yuslaimi@altera.com>, Marek Vasut
 <marex@denx.de>, Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tingting Meng <tingting.meng@altera.com>, Tom Rini <trini@konsulko.com>,
 "MANIYAM, DINESH" <dinesh.maniyam@altera.com>, "LOK, CHEN HUEI"
 <chen.huei.lok@altera.com>, "Hea, Kok Kiang" <kok.kiang.hea@altera.com>
Subject: Re: [PATCH v1] ddr: altera: Add delay before writing to MBRDADDR
 register
Thread-Topic: [PATCH v1] ddr: altera: Add delay before writing to MBRDADDR
 register
Thread-Index: AQHcpjKxEjS68PlcIEKWEvIwPbRkabXeblLs
Date: Tue, 14 Apr 2026 07:15:16 +0000
Message-ID: <CY1PR03MB81215FBC33A052AAE3846734A7252@CY1PR03MB8121.namprd03.prod.outlook.com>
References: <20260225084223.19498-1-boon.khai.ng@altera.com>
In-Reply-To: <20260225084223.19498-1-boon.khai.ng@altera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY1PR03MB8121:EE_|SJ0PR03MB6676:EE_
x-ms-office365-filtering-correlation-id: 94ce45f7-4cc8-47e1-bb7c-08de99f59463
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|56012099003|22082099003|18002099003|55112099003|38070700021;
x-microsoft-antispam-message-info: IaylbeCiHYxGCiFjrKGAgNXzMwMAIUBwfplPR928FPFWhAQdKB6qlSEQBOBd6dR8p1y02wwK57xeDGAUuelTQZU+AgLyP5taiDyiTGKHJwfQlXLF68UJ2xyeCIbp4y760XR6hE4qDva82NqDqiCCtYwu9ny+7o51eEStA0je01t+dPBbZBsGWWabnHbepVi5W9SsqcHQxOWzGGfAa2CMmAz6brQIR8yhJP7x1JqAVBsOVqdJvg/q5LPUbZhsPzehOEiWkwE15H6bugKUKLSt9KH7n132bvnkQiHGkV2YFcQ/Zrdg6RFT+W0pWCCcyUaIiXYvZCzuFN2OjWViAoC0KMlngnIVXoChuZUngPHtDZSfvnmGzld/GEf/xbArXdt3SyzDkbl9Gl4fRpvwyOj5DYxfLtgWrUyMfK56Mwwfcw51AORnGxxqUsiKwnG/XVMaPM9pFL4FvLJ1ejjyO9NTgSC6qkGvffH9T4sTJgrUyVR7zOMH1FV6CnP/Ufe9mAKWRyrzaXZRh3Bv0TMZm0BoFYpIbcpcz4fmRFIaLUREE6J39ktHfM6Kzn4mWdQF0I4hYP0dfHFoEdLVY3WAWjs2yqmO8uQX4asQp3g1UQu3wwpn/1qYrTp4osHHg2HwyzHOiZIfuSVVgREDDyVhM70DAj7Co0ItHK8rRm9sY+sdeLpjRzYVVi2lexf5TChwl1K/FBgNEOVe6W9FnMuYzEKlh+TM4QoX/keljeKjdCOdS3EkpZez+OWxeIIUmSTG0b+7xNgw5C6Hnl7upktQKwgV1DhBhtxGVQZZ9+fYmrW5f6s=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY1PR03MB8121.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(22082099003)(18002099003)(55112099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?fV9mJwF4T+F2fjEwTt9Ad2GoHCru11U+LfDbNlQr1y9fgzLgoVUgXEDsHL?=
 =?iso-8859-1?Q?tKMjEM3XYn6cQjCqD8rr9i6/VP4mkVe9UP38kdWfbJv+EzNCjyG+6uazP+?=
 =?iso-8859-1?Q?2gfdWRmn8u7dw8erAH7qr0XbTZ7z/nfxxCZg9olTQ61IjsEHhjJ7tA2/vz?=
 =?iso-8859-1?Q?iM0KacLqFy0Yxa22Bn5/gDLEWef5aHCazcDpYcq/88Kq5Hn30cksDuEFNF?=
 =?iso-8859-1?Q?ABlLzhQqaYaVa54BHAOOSz0sBFBJkdYtIL1zI7kp4J2QEy5mkFviXSbpWk?=
 =?iso-8859-1?Q?mQ6c+o1GmFE6INfdeTxm8oMZbk8eNvRne6kpHMdWiG0ax+S/JKGk+U1qcF?=
 =?iso-8859-1?Q?Q8xxuQgYKc0V+BMMtqvy9xdlU89JA+PQwWeiAV96KjMqaynooZgdzlp6n/?=
 =?iso-8859-1?Q?l+6c8YkarmE5a9GoFnMSI5obqpdTKxiBhcMq1sQiOMtEvggSrtxX6AmXJ2?=
 =?iso-8859-1?Q?mbuLsYd29WyxkZWI4AiIgd0bNY5bifF+BfXmjJq+Ntrdlab3j+AT40BeLd?=
 =?iso-8859-1?Q?MoXyi5g82iO+hyrkjhEAq7K8PGHip+SAkfSTlKyhBjn4/SYmj075y+DgHM?=
 =?iso-8859-1?Q?XEcNWik2kldubN1aGKOeqMgPtnW2qFG8H/QHHn8HizlYrWgje17kOSJZTk?=
 =?iso-8859-1?Q?sxye5BWmO6x4Jsha7VeboXrR1a19L/qe769XaAl5nWAS1XS01rwEL4Y/vw?=
 =?iso-8859-1?Q?jA5XyLc8H80xSdX1euIHDhxnnVkV2WvVigSyyuEP4E+6j7bOxL6SmoshgD?=
 =?iso-8859-1?Q?UJNIQhDDZEU0IsYJE3uKpuuaql/8tk2EGfGNyDldk9bmApPfWFWI3f2jc0?=
 =?iso-8859-1?Q?LsfEgDzBmlc1fsMLSBkOTR7NE7Tpebowa0O4hDBBiSvSV9WLmt6eC/iS8Z?=
 =?iso-8859-1?Q?IN0O7tegq7PMLvox8M1JMrDNLkD0ky/WXMyAgl5WNX769c45HGBmK1/yWd?=
 =?iso-8859-1?Q?W5XbZHErJ2yAlMXlo/BcjVZ2bDoRqeRlEcN3W3LAzDWvFX+GDZLJbMrzbY?=
 =?iso-8859-1?Q?j0wBWjW7hvzg1vWgxd7VR6WZ5LVaTNSHp1WNlFNdD23YsTOL1w8tztU4wc?=
 =?iso-8859-1?Q?b9JT/Y8WIzU0AtjIkGxjpDh+7pX75wkiE9poXdXzCaoMcc7e+2lApJMseB?=
 =?iso-8859-1?Q?F9/UdAfQoVpfUP1gpofh11Res+gUjhQQHE2/KdqR7VwSCIqhUrhSSOCOzj?=
 =?iso-8859-1?Q?X8Xgff+klwoto1eHlEtIiLGtmL4jU+48/ba6sNY0kzdSi0wcqvvjO6rVb5?=
 =?iso-8859-1?Q?9x1NwLsyr39Yg6bSD6sFh6cfnOD2QqDxldGHcFNfwMZdpdV85fEUyaCXM/?=
 =?iso-8859-1?Q?37IkYn4hr8JMqO8t1E8zgL5iLnZvMmjttfF8aVRKA7ux06WP7I/eaVdStY?=
 =?iso-8859-1?Q?dk8p86bjL+PnsgZqpWuas1wpqKTcPhuhjVNkHJ3CKzn6GDruHs+uP3QUV4?=
 =?iso-8859-1?Q?hZ9k4Om1TKVOfTIyvarx2kOW5pkDoV5LKZglN+Li8yTi8re71MtV8axl5D?=
 =?iso-8859-1?Q?uiLsiXljKd/Ga8+i0NrA/oPIf0Zv66Gg0LiX33rxHn0yd6TbJXp5PIsgQC?=
 =?iso-8859-1?Q?iWLNRBb5QYJOq9iVlZQr5Paf3xi7k49IBADBMYVf7GBQ/Dx1WBE5Cjky9b?=
 =?iso-8859-1?Q?0W1QxXYwNi864n2ROZc5g0oRybDPy7athErm5y2jX7VJUPZ1km36I8SKYE?=
 =?iso-8859-1?Q?UCTjZ3jskskpOFZ1wCvdK2M8hdCDWnOaghKc6sWi9bF6+W5pAQEcGw/6Te?=
 =?iso-8859-1?Q?WEe4EGEa1AQ4sMIF6y5OPz6Mgk02Y/65Hs5nVki6m6/iVfQS2UvTnZL7SO?=
 =?iso-8859-1?Q?cEjymykvOw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY1PR03MB8121.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94ce45f7-4cc8-47e1-bb7c-08de99f59463
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2026 07:15:16.8675 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7L5PMt4FsbCUpVpOe3qmrWsbQxADwXSASss8ZYu86C36Ue5UtdEwozgZMX9GX21yayb6SJPn2vTLujZo88+HkKbo90Mppg8fCmmuV/FJym8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB6676
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

> From:=A0Ng, Boon Khai <boon.khai.ng@altera.com>=0A=
> Sent:=A0Wednesday, February 25, 2026 4:42 PM=0A=
> To:=A0U-boot Openlist <u-boot@lists.denx.de>=0A=
> Cc:=A0Yuslaimi, Alif Zakuan <alif.zakuan.yuslaimi@altera.com>; Ng, Boon K=
hai=0A=
> <boon.khai.ng@altera.com>; Marek Vasut <marex@denx.de>; Simon Goldschmidt=
=0A=
> <simon.k.r.goldschmidt@gmail.com>; Chee, Tien Fong=0A=
> <tien.fong.chee@altera.com>; Tingting Meng <tingting.meng@altera.com>; To=
m=0A=
> Rini <trini@konsulko.com>; Maniyam, Dinesh <dinesh.maniyam@altera.com>; L=
ok,=0A=
> Chen Huei <chen.huei.lok@altera.com>; Hea, Kok Kiang=0A=
> <kok.kiang.hea@altera.com>=0A=
> Subject:=A0[PATCH v1] ddr: altera: Add delay before writing to MBRDADDR r=
egister=0A=
> From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>=0A=
> Add a delay of 1ms before writing the address of the data for HIP=0A=
> interface into the Responder Mailbox Read Address Register.=0A=
> The UIBSSM mailbox require some time to settle down while waiting=0A=
> for the MBRDADATA_VALID bit to become 1 without this delay,=0A=
> specifically the board will timeout while waiting for=0A=
> MBRDDATA_VALID bit to 1 after setting to 1.=0A=
> This 1ms delay has been tested thoroughly and no intermittent issues=0A=
> with UIBSSM mailbox communication is observed.=0A=
> Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>=0A=
> Signed-off-by: Boon Khai Ng <boon.khai.ng@altera.com>=0A=
> ---=0A=
> =A0drivers/ddr/altera/uibssm_mailbox.c | 2 ++=0A=
> =A01 file changed, 2 insertions(+)=0A=
> diff --git a/drivers/ddr/altera/uibssm_mailbox.c=0A=
> b/drivers/ddr/altera/uibssm_mailbox.c=0A=
> index deef61f1178..2316e602d3a 100644=0A=
> --- a/drivers/ddr/altera/uibssm_mailbox.c=0A=
> +++ b/drivers/ddr/altera/uibssm_mailbox.c=0A=
> @@ -243,6 +243,8 @@ static u32 uib_mailbox_read_request(u32 target_read_a=
ddr,=0A=
> phys_addr_t csr_addr)=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 hang();=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 }=0A=
> +=A0=A0=A0=A0=A0=A0 mdelay(1);=0A=
> +=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 /* Write <target read address> to chms0034 MBRDA=
DDR */=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 debug("%s: #2 Write 0x%x to UIB_R_MBRDADDR\n", _=
_func__,=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 target_read_addr);=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 writel(target_read_addr, csr_addr + UIB_R_MBRDAD=
DR);=0A=
> --=0A=
> 2.43.7=0A=
=0A=
Acked-by: Tien Fong Chee <tien.fong.chee@altera.com>=0A=
=0A=
Best regards,=0A=
Tien Fong=
