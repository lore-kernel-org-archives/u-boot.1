Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3ECDC25B48
	for <u-boot@archiver.kernel.org>; Thu, 26 Oct 2023 08:42:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3466886E1C;
	Thu, 26 Oct 2023 10:42:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=renesas.com header.i=@renesas.com header.b="abX8YsdK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D01A687B4F; Thu, 26 Oct 2023 10:42:29 +0200 (CEST)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com
 (mail-tycjpn01on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2019::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05A6E86DFF
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 10:42:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=yoshihiro.shimoda.uh@renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eYdFWkPaMoMwY5fUSdHdQLrVYD6UURxjZdXKugRWf/4wzIuB2Xk5K+TxQ7MNNV+wCeGfsmue5+yPAUNZdwW+6Scf01cYXDZLw1nP1sGi+VOmFzqtm5w09kVR68uU4DWUDr0236D8YZm5n8lJrN5WUG7ze1nOdw0HWWB1s2Mt6Y3dOlTBu0dGEUIJqBBOOrSIYeA7ArrOVQpiQ8E9Y5thbJHpKOJm+bMfpiT2c3Zftz+6H46E+epjgGXqwGoEuPrfQCKyEjtkDLy1HSV5gfLxUZ9hjCBEbSOuH7UWZzBW1VPSwoAaBw13N4VeNno83BkYfOTOsjKuaMxD3f/szvjb7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2G7GjC0GWKW2L3YBuBLfhBMuYWEsgcCO5KFo4YtDkLY=;
 b=G6tDViBW30uW5KIwpFDGQEQE/2v26xhfIk3dtZT7zJHRDYF17LzcJN65D4vlKe1vEThhHLvJap5TZXIluNivIQoEq0pxIVdGV16bwRdf088XoI5abqkV18L78HC+W393b6zNNUlef7n1bjAr1VdyBFNptQYPr4HIsk6DQ0X43EDRGpG5Mkv4mGtZixvVaK7l2jHpiBeWFjRqYFtT4T11aGUDQxSVX0Pl6Moc8+1AG8jxgX3YnbgD76odYCiLkt1Ih+jSkIDFfWqG0SahEMMhvXyCXZYN4gRUf28X/k0VNUq7Bbk8egAd5z1FTMC4NBOfdY7vf4onNhLT3KvdGyK3TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2G7GjC0GWKW2L3YBuBLfhBMuYWEsgcCO5KFo4YtDkLY=;
 b=abX8YsdKBQpU9cqfSz4v5tIyucg9FpyxRDt95jTd90nCny87163/L593+j1aSCI+sdllNX7pld+0nzQDddPEMUT7rdja5C4PPYQXUxvyoXz4m1FxxXtlDy1J5a3n6fZfRySAhmXqCLtuhOFH0RpUxXPxk/2uZvrEi0eaWLMRf7I=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by TYVPR01MB11131.jpnprd01.prod.outlook.com
 (2603:1096:400:367::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Thu, 26 Oct
 2023 08:42:20 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::206a:4c02:8a6e:160]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::206a:4c02:8a6e:160%4]) with mapi id 15.20.6933.019; Thu, 26 Oct 2023
 08:42:20 +0000
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: Jaehoon Chung <jh80.chung@samsung.com>, Nobuhiro Iwamatsu
 <iwamatsu@nigauri.org>, Peng Fan <peng.fan@nxp.com>, Nguyen Hong Thuan
 <thuan.nguyen-hong@banvien.com.vn>
Subject: RE: [PATCH] mmc: tmio: Always check for errors after receiving an IRQ
Thread-Topic: [PATCH] mmc: tmio: Always check for errors after receiving an IRQ
Thread-Index: AQHZ/zLXkQVJXD0CAkSaluCXROZVwrBbzv7Q
Date: Thu, 26 Oct 2023 08:42:20 +0000
Message-ID: <TYBPR01MB5341DB7CB5F478AA3BF8697CD8DDA@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20231014215606.130343-1-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20231014215606.130343-1-marek.vasut+renesas@mailbox.org>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|TYVPR01MB11131:EE_
x-ms-office365-filtering-correlation-id: 814b31ad-ae1c-415e-aacb-08dbd5ff77bf
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: h2+vr4rypVFPHgy9toSJFCjVdCs/e5G2LP3GEyjnM6z/+ELKKHktRC+m3jK7uZM3VE2PwnVxyR5L8T+GdfO9eJGwe394YukO50Qm7YGN1zl48npz1AEXhBG6olktbCsYpZiRE9jNSRbgwHDBc042h8VF4Vb7kIBzTCB7sGUDN0r+cNaSC5R7EW5BB4xZiq7nFiXCZABG7lvz0b7dq0nlnTJyckcehTg7H7JJbOyvBKvRMOovhLYddICDOYXzSA+wk6AtdILCP0NTGeiNYkJniBw4LkEGsw8Xm/jsBN+aOhFlBtN4SW8HmtbvZ3ADg7Gcur60W/HvrBERqzXpS29GNELWKtnHwqtQHf7Gr0oFvKZsGPvOObRHX4kbll6gBZ2hmC0KmSzNN+76cIr512hSOx9G0PxPwVMvfEPqmmG2f3KgzkUArzlUetb64H799a6WfnLrZbL9KjCVWIX9Uvy62lXDfjVETrFQCqdJrVpQSqow7+vIXB08LOuVWcfFmDNpvbInxCxE5E9Nc4BwzEd80Fb9I4JR4UNe3376+DJ81Sqlug35rw7rczD+f81oIv5XcjmqbfEeuQyJvw4Ack8p3irgPpK4vpE1TEQEL51v9xnj/hKoYLl9Gd8COeOImtyQ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYBPR01MB5341.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(39860400002)(396003)(366004)(346002)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(38070700009)(38100700002)(41300700001)(2906002)(110136005)(55016003)(86362001)(52536014)(4326008)(8936002)(8676002)(33656002)(478600001)(64756008)(66446008)(7696005)(6506007)(71200400001)(76116006)(66946007)(316002)(54906003)(66556008)(122000001)(66476007)(83380400001)(9686003)(5660300002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8uNOlCqe/9xEd8z8bF7X/uou1awZ0GIKGP7BdDjyMqWhhEzM6C/bRCb5Yk0k?=
 =?us-ascii?Q?c971KKtimkeGm/VOZapTxgTpzEhXzvS5BgFyQ6iYRA4SkOzNbcvVD4FkbDXt?=
 =?us-ascii?Q?OVAimE4ZY0XqnwHq2SaVw3IoUqQTmQoTcwhofOPnWZhf9gJtujP8iiJGObrh?=
 =?us-ascii?Q?YbJLlaoiAMUCkbyr9Fl2btgG3gIEV2skAPu/UN1K2QZXioR6YIO9n0uR+aiv?=
 =?us-ascii?Q?6ANyYtD11LyS3sUv1UIyRXpehnll2ycsuk/lwYdLfIbV1GnKnE9G81Nvi+P8?=
 =?us-ascii?Q?HSegklolKywRrp/UcACHiAWn4sWEBL2vjJeRqrAmooSulz2yPER7o8uO6+hW?=
 =?us-ascii?Q?m6JYVWhc+ACP2SPqC7XX087qKGRDnyVPAxosn4xmPeO6RUVHM3phySVUuwWg?=
 =?us-ascii?Q?0rp0+YWqnTO3yCvdga33To6IMSWBYQ8fuVfLvvwWSDPIdoDf2oFOj7K/aZIr?=
 =?us-ascii?Q?YjhlmhKyU5gCHts6wExeOAt3vGUgY/TluebVMujG7ye29S+DeyKkBxkN5Fv6?=
 =?us-ascii?Q?jjvB7r8EQa0AYZDvNVgcD6s5Xa07m34fN0HlQaMGvDvsN6/ISLlZCUzEJhKn?=
 =?us-ascii?Q?vVQd2kA9grMbcsUb/UeSSgTBFu+Gx3CsVDNuGWAlblIqhYuxlcT0n6Yc91UK?=
 =?us-ascii?Q?EwMha/xUFFN7HK9bpoEgH4Rmk2hcbrfS5xxecjllo257BMNcHZyzVI0HrUm6?=
 =?us-ascii?Q?lpeJuVMCXZORA9DLJkVI57RMKjFywZgIVK/42ejLU0msSJljSVnRH1iTYbrl?=
 =?us-ascii?Q?tqBQi5nKItfLxVe/4NFSqN0uB3AHRLeAiUfICZDoydHe5YIy6Du41bkdLa+b?=
 =?us-ascii?Q?vIjaknOav5BJVo0qJZtr0zH/krpzV6DFwr8V9IRn73CgPEL4H1UPaLjl23Nl?=
 =?us-ascii?Q?aiFJFh5S4rji+1j+X7SthnVaamdIdOr9+2sO9bPNG1BlqXbxoOPd26KrPfFu?=
 =?us-ascii?Q?cPxoPsQjGxaNNsLyEirjvDa0RUfWafBy7xtaF4h4ytAAIYZC3iWkLicRgdLC?=
 =?us-ascii?Q?5xAPo+gkq+1X1KuAmH9OzhLTNUCe+NPIe00dLV2X/fArDq+rE4FMwRLMJBtF?=
 =?us-ascii?Q?tWgT3BfxmqJq8yoip0T2Bx7Zbt4aAX54LnnrDiOZ8NfedHLBwoQcBKnt5gqq?=
 =?us-ascii?Q?IR2EWL8adNQfkuzR6hM4rIiyIiMOfAH81PUcbEH3/A3/X2eLn21nlatONpVq?=
 =?us-ascii?Q?vCFhGMfYvuADLSqh0ed9BhTJuugds6QXXD42sWl0YVsHQYkDcI4RBOGQ5AA2?=
 =?us-ascii?Q?8/i8elLQbI04Ye2UPLzQy67c90PTrlXm6aozEGOIRdn1mKsFpSZTJG4HvlzR?=
 =?us-ascii?Q?qJhm79IQSaPbt75XDLXLxIi1ntZTTooEwAUQT3/CJEl62X35y00fsdeFl9U3?=
 =?us-ascii?Q?O9eam3ktcT+rcgWRA5/wbwXlMvKHLHx7+98YXv05TiFbMv7yfKYwxL5VwFHZ?=
 =?us-ascii?Q?dHRXQt7PSIRsY9px0Xj8kOk4pvIlsP3KYlgfIcXYIjVLSy0dRgEm63OkWGNH?=
 =?us-ascii?Q?3b/4BIUaYL0gsdhID7vpn26xLDsT1rRMAxCy0th7QB/bJ6SfFJ2MLIfQDYD0?=
 =?us-ascii?Q?7G23fAMYKAIeblgFv9tq9w+WrysKDwcGIMIyKXfEyjpGWXVP6DOO9fFfQbax?=
 =?us-ascii?Q?tC5YRy6jxz9eqtT8zrBiOudTdzE0VmwAtN8P5VadCeRKEX4B7d6l6wQa2t8I?=
 =?us-ascii?Q?LXn4pw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 814b31ad-ae1c-415e-aacb-08dbd5ff77bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2023 08:42:20.5379 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 04Rn4Mu1QcB3MfUmOTxyD/jrXuHvcf03MO77td7+m5A/wBvOh2gXrCpcA/a9Qs0DZvWc1vBAo0ZpQ/VjfzP8E9Tpq+Jab3psNWdFNRPjOcjGAOBMcayRiJQ+Yf5LvwA6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYVPR01MB11131
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

Hello Marek-san,

> From: U-Boot  On Behalf Of Marek Vasut, Sent: Sunday, October 15, 2023 6:=
56 AM
>=20
> Unconditionally check for errors even after successful reception
> of IRQ flag, since the hardware may set both an IRQ completion
> flag and an error flag at the same time.
>=20
> This mode of failure happens in case of an error during transfer,
> in which case the hardware may set the expected IRQ completion
> flag as well as error flags. The later is currently not checked
> by the driver and such an error is not detected. Improve the
> error detection.
>=20
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Jaehoon Chung <jh80.chung@samsung.com>
> Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> Cc: Peng Fan <peng.fan@nxp.com>
> ---

Thank you for the patch. It looks good to me. So,

Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Also, our outsourcing member tested it on R-Car H3 Salvator-XS and
it works without any regression. So,

Tested-by: Thuan Nguyen Hong <thuan.nguyen-hong@banvien.com.vn>

Best regards,
Yoshihiro Shimoda

>  drivers/mmc/tmio-common.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/mmc/tmio-common.c b/drivers/mmc/tmio-common.c
> index d1e26815996..83eaf361f0c 100644
> --- a/drivers/mmc/tmio-common.c
> +++ b/drivers/mmc/tmio-common.c
> @@ -122,7 +122,10 @@ static int tmio_sd_wait_for_irq(struct udevice *dev,=
 struct mmc_cmd *cmd,
>  	long wait =3D 1000000;
>  	int ret;
>=20
> -	while (!(tmio_sd_readl(priv, reg) & flag)) {
> +	while (true) {
> +		if (tmio_sd_readl(priv, reg) & flag)
> +			return tmio_sd_check_error(dev, cmd);
> +
>  		if (wait-- < 0) {
>  			dev_err(dev, "timeout\n");
>  			return -ETIMEDOUT;
> --
> 2.42.0

