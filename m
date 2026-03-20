Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BE511098784
	for <u-boot@archiver.kernel.org>; Fri, 20 Mar 2026 13:41:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 883D383F00;
	Fri, 20 Mar 2026 14:41:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="swVNAByI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4069883CF5; Fri, 20 Mar 2026 14:41:43 +0100 (CET)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 177A883CF5
 for <u-boot@lists.denx.de>; Fri, 20 Mar 2026 14:41:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a0ZbTL9kGMvUG3uQMEq0A0VPyindO5cU3/4P2IvOXzAkNKPzFwwj76uT3Xao9rKnuIlZnMWWnOWpQfE7blR/MSdKiWm+nNyXo+axqZTmrtgQg4EdojNyC0/8AAlTGcsrqzx1Qr79xGDboTIMZ3NtVTHlpEKi3k9Wwqx5z86Ikfb4+IAbHAfFv6fWR9c+8mcP72zO/87GOZQag0oHMCmibZNgl5LsmATjE/djLrEppYe+W1ZWUTDPxDF70geE+L5lUP/E1ZjUwk0ARRiX+tU8bjwSFAdvnpfBW5A9gFdxgOvNoLO/bgO9tB+SZh6V54FjhBPzrHOvqAWixjXyEh6unw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xF8H9VXbo/udC/GpzdNd2GowtIrWltl7l1YVQPep8PU=;
 b=JntI81K6SiwbJjccHjYrdSvQMBzY+H9nERd/IkkTlhcXg2uRGIhhORDzT1emQoKt3KzNVJg6E1EvIaGcUVhR09kHTnRSJtt0I0BALpcsDO9ckzjl0bDzLWYLmdwis7X9khzv0E5e8jv+NUmC0/Pvc2UjwTPkDyLfV8Q6UBlRsY2tYffuaMEVgxFoIOm5ra5wuRUTTOVbLXYUnlLoRWx/+0XbnZ6dzdwSHmx2oGaL12XxdZKOx37zieogp9G78ZaBi2w3Wq/so3jSTe7Kly4EKfqD5gHb6wAdSiD89uL5otP7JxJr2cBrTfPBIRbTul8P9ugF/8lXEZI2bv+SlyDpJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xF8H9VXbo/udC/GpzdNd2GowtIrWltl7l1YVQPep8PU=;
 b=swVNAByIVq9eIsXUVj87xfobSx9JP/1VWFy8UUWln/2Ebe+E4SJ/tM0ubCdG76skkXIAY+kbdhR3cT9hUo0xP9xefxIxirN0DP/OWKUh2fYm8cVutNeVm2Gh4hDyfPirW2VdLP6jsIeTWpdLE5kgB07HknGTRfjxj52ZW/SDA49OB4N+85ZX15zERjhD6FMp/a1+oK95p6wmYZQRqWF0WKd+coMoUHG9UbEDuxqWmiH4YnJwlxNgJPKfbheEdB3Vqo9yhDujeDWXOZzExDdOKIYYs5y9/tuzGojiu4EpPhM9Uo5jyjjd4EDdi+PafMjaPGeGj2qMui+DjvHxcZtIVw==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA2PR04MB10188.eurprd04.prod.outlook.com (2603:10a6:102:406::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.23; Fri, 20 Mar
 2026 13:41:34 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%3]) with mapi id 15.20.9723.018; Fri, 20 Mar 2026
 13:41:34 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Marek Vasut <marex@nabladev.com>, Patrice Chotard
 <patrice.chotard@foss.st.com>, Sam Protsenko <semen.protsenko@linaro.org>,
 Tom Rini <trini@konsulko.com>, "u-boot@dh-electronics.com"
 <u-boot@dh-electronics.com>
Subject: RE: [PATCH] board: dhelectronics: imx: Use second Ethernet MAC also
 from fuse
Thread-Topic: [PATCH] board: dhelectronics: imx: Use second Ethernet MAC also
 from fuse
Thread-Index: AQHcuFTL3zELcCJKDE60GTSXntN1pLW3bZSw
Date: Fri, 20 Mar 2026 13:41:34 +0000
Message-ID: <PAXPR04MB84598FAEE27CECAF44791AAC884CA@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20260320102918.4011-1-cniedermaier@dh-electronics.com>
In-Reply-To: <20260320102918.4011-1-cniedermaier@dh-electronics.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|PA2PR04MB10188:EE_
x-ms-office365-filtering-correlation-id: e874c6d9-9680-4d90-1cab-08de8686671b
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|19092799006|366016|376014|1800799024|56012099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: 9FUiQN+3Jh+4qJPJTsRcuWrYsJ7H3bCKFheCAsIAs7hrYmwY/fqXAVyDmvy3Wp2Na+ykaKdCVF25Gw/angf+kpzeUt09zdzAs87TpdmOFoZP3PKlnNx5jE01hJXfHHdCb1yFASmiACzBRmC6h4kyYS0H0EsYfoigFs3R+c8Wp12wOGbCo2o1HFTcsi/kKIoN4szNtAdy5AdHT3OQkkCwnVaf+MSOAxUrSjCTD0eD/BlsQj3ze20Ah0I/6V01mmcAqq4Sv9UxWuylK0yAEtnag2WdPktoxaJggWYG0+WMnt/F3ba+PR0mOa8fBqBbFdPkzRQEpIJBIa6u8hzESDBhsZcYoNIFIbq5DGTC3KwZmq37VYp1u++oIpBiKA0DU//LAAstNr97ZvflBQWDZWh7jVfmpZ2wB9Y86YXwZn1BYF6oSSNWrWTMykp0qqCisadtTtqvzqr1eSe6Xy7Lz+Y47KiJTStNp4Ho2cXjkNvgCc6IqVfC/+vtCsm7FWRMGIW7SX9q8XNQNaBREwsqAQBe6DF6u/TUk6jIJO5XKmNTvvSHszo5r7vFw1MQc7bCHp2vjBnJoCJsJCNwO4UrAT2p0qwnBISB1VD3BsgkLbbYIJRNRdohZdGVGnbAaK01T2ekNVS8zMNmQBzGEgJyrNbaKJrrzjggofbbpSN1mNcJC872RUFmAlXlTlTCIzxEOpz+TGCXuY127mAakU9Lla197g81EhJlpKlK1OorbXzG56KmWtcz+k3U9efI7OCSQPPz9ac8GUEQfYwKYzT5vIe+I8Ts9NfOR0kBzjCNl7QezWg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(376014)(1800799024)(56012099003)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/1EPEivIEOowfA2PJCcAJwCMcGJdrCMiyie/Pwql3Rqm16ilCziBOwdBBwZQ?=
 =?us-ascii?Q?A5e4r1/j6NMuU4E/VI4czB1Djua1uZZjVfsqTUKGR2dmKBIU49CGeeHR8e/g?=
 =?us-ascii?Q?kG9mhUtFiUoDJs1coWHHuc1+2RFFSDMpps/dDcB+NRVGhsXWoRKphwASOMUI?=
 =?us-ascii?Q?AmdDqzeDqqqKHh6/ot1P08564zdu45g85x/DF5VVs/g+knRZgJvd5XBzWK+9?=
 =?us-ascii?Q?o+d7Emy3PhmTcdzgPt7WZMasxzncY0v+wIsJXOCBtToICcBomVlcdD3Lw96T?=
 =?us-ascii?Q?llmxftBkmR3byOkQU5O4KyqHsx/ytnoNUYtkrGlzJyoQj6xC76V9PMwt91dJ?=
 =?us-ascii?Q?h1AKC7o4dPg73Nug16ijErK1Vg0nt5n1h/hzjTu9pQAdrU/5eZSeBLvWnNGm?=
 =?us-ascii?Q?Rj60+zBueYQ6N96psPdiq3vGgQF/HtYiTUJYH1RMkgI/+G01JWQDBxw4kton?=
 =?us-ascii?Q?iPIOXce8qFHQzhBQ0tB2HEUDCGb9MscMbAoE6p+a+WHzNM9XIz2MpRSYlgwr?=
 =?us-ascii?Q?RNM8Z1HVKdZMx+3FT28dNEfMLBcGGMqTknPu+7Vs/2+hTFnfOZnkt9bJsTOe?=
 =?us-ascii?Q?i4yopMqR1yfH5ufsSOdFL19N0YoVwd11mZJjcMQJacUa2n9QRrjxfDwDMKD9?=
 =?us-ascii?Q?KZ9JAIZnakL/EwdDdSWzVR+DGviByxJwMGvJjNk6PNtdSQwje/ExjQ+Aw2Wv?=
 =?us-ascii?Q?t4MlOnfFgPqIEiD0Pg9/pGR78CX+cDs7vbVf217U4cChsLbe2rDj3GiLgmtH?=
 =?us-ascii?Q?4P5ZQ8/fEP3ej+2+8fvIvWcxsP2WBWj0a2L4VJ3F145Ep8pby/W0CIreZABt?=
 =?us-ascii?Q?K+mhKRZ7a6E29gUj8Bxs5qnhh9c8NdqMjhRB3RmcUZPea40ZOM6Z3juw5uw0?=
 =?us-ascii?Q?vMkpOF0Jb6fnjHQTFHp55YrBEN991oHk2TBjQS6OJd6xNv2SaoqwwV/JZlWC?=
 =?us-ascii?Q?jKsnpG4uYE5/9VV7OGoAjXMhpAInj7syNHQhNTSInhgIVekYaYMF1KBtANHz?=
 =?us-ascii?Q?f3imlyiujdKI+23MMoMfqm6rCZL/JRJzR6RTL8LSRqUs0w9A8VXaKuSPO9Iu?=
 =?us-ascii?Q?jJ4E2dodU0314B5uNKDw97j5k07xddjU1dPwu+uer3Q2r7LOIqi4FYDlh+6O?=
 =?us-ascii?Q?Era/1LA5dBBdmJ6M4a38VM/xIL2iNJJ3J8GNCk2G2GxXWlKyo2KiGUI08YPH?=
 =?us-ascii?Q?1vPcrAKqLM9jhZssBG8X/qr8peQp0J8nnR7sp57JwncjC7HVx8rTvqILvIxT?=
 =?us-ascii?Q?6TpKHlyOu/rtNRIjDWnpZ06yuVmgIcGraEfkmDB8mp4tpzPwtzCFiwRuj17/?=
 =?us-ascii?Q?/o51YOuYkXMVQK2Y2HwxW/9ptM/uFm7wQCGYo10ChaqZpYbwexkpGWUu9TRz?=
 =?us-ascii?Q?L4w0c2sTT2k3VHV97MGO40+rVitGckFcwAsQNY2eyQhrbhCaR7H+5iq7Sg/S?=
 =?us-ascii?Q?MLt2U/6XCXoJQ0836I7fQ3cQbTlBHab8YDGefHTKkrTi6rHUjpOlwndX8OMS?=
 =?us-ascii?Q?h6Mi/Op9ps8nhHaRsI/g871p6WjqUf/GCbqkt32QCFfTixoSxOSjkmr2TPbw?=
 =?us-ascii?Q?eDgffhELU7F9jnaSQi39hO3i5tmklLZM6imAXPujF6NBZtCyHEUI3TNk7FqN?=
 =?us-ascii?Q?ucJlaIWpPEuNgOuGdIaGmBq9cLDVpQFx6YIE4dTMPAF879mB/dkNYYlB7V79?=
 =?us-ascii?Q?0BLzt2bOf0AXdw4DWJFRvKfdNGJcAShPvpzc7MKIuAJqlHmT?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e874c6d9-9680-4d90-1cab-08de8686671b
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2026 13:41:34.6412 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XhRUVbccow0rsBjRmKEUWYxh6tuNii9fKY+3MOu4h52ti0vlOX6w0aV0x7IwvLNq6/xMcxEABInwb0F76YIJXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10188
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

Hi Christoph,

> Subject: [PATCH] board: dhelectronics: imx: Use second Ethernet MAC
> also from fuse
>=20
> When two Ethernet MAC addresses are fused, the first MAC address is
> incremented by one and used for the second MAC address. This causes
> the second fused MAC address to be ignored. Change this so that the
> second fused MAC address will be used.

I may miss something, would you please help explain a bit on why
the second fused mac address is ignored?

Thanks,
Peng.
> Keep the old behavior if there isn't any second Ethernet MAC defined
> and only the first MAC address is fused but not the second. In this case
> use the fused MAC address incremented by one, for the second MAC
> address.
>=20
> Signed-off-by: Christoph Niedermaier <cniedermaier@dh-
> electronics.com>
> ---
> Cc: Marek Vasut <marex@nabladev.com>
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Peng Fan <peng.fan@nxp.com>
> Cc: Sam Protsenko <semen.protsenko@linaro.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@dh-electronics.com
> ---
>  board/dhelectronics/common/dh_imx.c               |  4 ++--
>  board/dhelectronics/common/dh_imx.h               |  3 ++-
>  board/dhelectronics/dh_imx6/dh_imx6.c             |  2 +-
>  board/dhelectronics/dh_imx8mp/imx8mp_dhcom_pdk2.c | 13
> ++++++++++---
>  4 files changed, 15 insertions(+), 7 deletions(-)
>=20
> diff --git a/board/dhelectronics/common/dh_imx.c
> b/board/dhelectronics/common/dh_imx.c
> index 3d6487dd0d8..308cdb5b002 100644
> --- a/board/dhelectronics/common/dh_imx.c
> +++ b/board/dhelectronics/common/dh_imx.c
> @@ -10,13 +10,13 @@
>  #include <net.h>
>  #include "dh_imx.h"
>=20
> -int dh_imx_get_mac_from_fuse(unsigned char *enetaddr)
> +int dh_imx_get_mac_from_fuse(int dev_id, unsigned char *enetaddr)
>  {
>  	/*
>  	 * If IIM fuses contain valid MAC address, use it.
>  	 * The IIM MAC address fuses are NOT programmed by default.
>  	 */
> -	imx_get_mac_from_fuse(0, enetaddr);
> +	imx_get_mac_from_fuse(dev_id, enetaddr);
>  	if (!is_valid_ethaddr(enetaddr))
>  		return -EINVAL;
>=20
> diff --git a/board/dhelectronics/common/dh_imx.h
> b/board/dhelectronics/common/dh_imx.h
> index 284f8637fb8..cb51a2f6eb2 100644
> --- a/board/dhelectronics/common/dh_imx.h
> +++ b/board/dhelectronics/common/dh_imx.h
> @@ -6,7 +6,8 @@
>  /*
>   * dh_imx_get_mac_from_fuse - Get MAC address from fuse and write
> it to env
>   *
> + * @dev_id: index of MAC address in fuse (starts with 0)
>   * @enetaddr: buffer where address is to be stored
>   * Return: 0 if OK, other value on error
>   */
> -int dh_imx_get_mac_from_fuse(unsigned char *enetaddr);
> +int dh_imx_get_mac_from_fuse(int dev_id, unsigned char *enetaddr);
> diff --git a/board/dhelectronics/dh_imx6/dh_imx6.c
> b/board/dhelectronics/dh_imx6/dh_imx6.c
> index 234824b38c2..5806a03ed17 100644
> --- a/board/dhelectronics/dh_imx6/dh_imx6.c
> +++ b/board/dhelectronics/dh_imx6/dh_imx6.c
> @@ -94,7 +94,7 @@ int dh_setup_mac_address(struct
> eeprom_id_page *eip)
>  	if (dh_get_mac_is_enabled("ethernet0"))
>  		return 0;
>=20
> -	if (!dh_imx_get_mac_from_fuse(enetaddr))
> +	if (!dh_imx_get_mac_from_fuse(0, enetaddr))
>  		goto out;
>=20
>  	if (!dh_get_mac_from_eeprom(enetaddr, "eeprom0")) diff --git
> a/board/dhelectronics/dh_imx8mp/imx8mp_dhcom_pdk2.c
> b/board/dhelectronics/dh_imx8mp/imx8mp_dhcom_pdk2.c
> index 5c35a5bf447..60d1e05b77f 100644
> --- a/board/dhelectronics/dh_imx8mp/imx8mp_dhcom_pdk2.c
> +++ b/board/dhelectronics/dh_imx8mp/imx8mp_dhcom_pdk2.c
> @@ -50,7 +50,7 @@ static int dh_imx8_setup_ethaddr(struct
> eeprom_id_page *eip)
>  	if (dh_get_mac_is_enabled("ethernet0"))
>  		return 0;
>=20
> -	if (!dh_imx_get_mac_from_fuse(enetaddr))
> +	if (!dh_imx_get_mac_from_fuse(0, enetaddr))
>  		goto out;
>=20
>  	if (!dh_get_value_from_eeprom_buffer(DH_MAC0, enetaddr,
> sizeof(enetaddr), eip)) @@ -75,8 +75,8 @@ static int
> dh_imx8_setup_eth1addr(struct eeprom_id_page *eip)
>  	if (dh_get_mac_is_enabled("ethernet1"))
>  		return 0;
>=20
> -	if (!dh_imx_get_mac_from_fuse(enetaddr))
> -		goto increment_out;
> +	if (!dh_imx_get_mac_from_fuse(1, enetaddr))
> +		goto out;
>=20
>  	if (!dh_get_value_from_eeprom_buffer(DH_MAC1, enetaddr,
> sizeof(enetaddr), eip))
>  		goto out;
> @@ -92,6 +92,13 @@ static int dh_imx8_setup_eth1addr(struct
> eeprom_id_page *eip)
>  	if (!dh_get_mac_from_eeprom(enetaddr, "eeprom0"))
>  		goto increment_out;
>=20
> +	/*
> +	 * If only the first MAC address is fused but not the second, use
> the
> +	 * fused MAC address incremented by one, for the second MAC
> address.
> +	 */
> +	if (!dh_imx_get_mac_from_fuse(0, enetaddr))
> +		goto increment_out;
> +
>  	return -ENXIO;
>=20
>  increment_out:
> --
> 2.30.2

