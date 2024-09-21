Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 937A2CF9C69
	for <u-boot@archiver.kernel.org>; Sat, 21 Sep 2024 02:39:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C5DEF886E7;
	Sat, 21 Sep 2024 04:37:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="VtSPCaXc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88F6A88356; Sat, 21 Sep 2024 04:28:55 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20603.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::603])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E26A28785E
 for <u-boot@lists.denx.de>; Sat, 21 Sep 2024 04:28:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=carlos.mora@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mPDaAkwrJZSyxqXERR1qrBNxhnMVaMoEBCPPf7I4JjZvH4fwjuSNKYltcHXwEusDOSLfFJGWm85svXLpC6vlLdxnG54MPxsEhpNNCrhdBg62mAeeHI0jdJRidjW45Rqgx4X7Xss+hwobAWG5EKxpqUvtbf7Qidmg+1fmM2p+v7tqiZvEj9wN3LvxlDUohC44Zd4AjMI02fkEsnbgb1B93TmBiE73GlfJ9z1MdiDb5TSxJLfIS3HeRDjdB+i8Zq5QPUKI7eHhBbvAxgK+cBGr14K1Bz+TJjTvITrcLKGLaz4dHsFwBcpml50ZXq4C8ItEM1Rb1yNL24JYh7IiCXcMjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dF0c0/jH9hU6MYjZARPqdyYnkS1rhVEKmUJlsaFsZgs=;
 b=e2xOIAmVEjFQGSCHVnfcipce2Hn4+0bGNwwgFxqartAzpcYT/oYaX2YwyMIH/LbyeqqNcix5t9Ft+q91uMBWd5UifLeempSQ2odjMMgquooMzNIQErm3O/XiieHDV+OA66RPNz5I5L4dXao9zrIjprQtoHMMNd4dZTVnrsn8aWPvDYgG6NyMT5c7jE+Dmhu2uMul1XbDoipggaZ2l+EeU9v0JLcb1gbyhqqQSG4RENIi+wBc7ag5sVzdKGuxbFis0e9uUUg+yKI/zwKCdsDcZFO8ExIiNcu9Xw7+eZm4CgYpnOID6BSehulQ6HFzv38CB5Eu/IhV9o7f1ksi17SHXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dF0c0/jH9hU6MYjZARPqdyYnkS1rhVEKmUJlsaFsZgs=;
 b=VtSPCaXcdMpeqamVAfZQhnJ7xKrudbTZ2RHF49qfeT+JGeQd1pwq9OiM3NeuzFFaPm+x+EcmnAQM0kpq9egspI4wTCAQyI8xFuPP3BwJmtf64n+arlYjLwO/3HVgUhuhfjU5/ywRnAtAa5exrtNZHfCvpgfMGD3LZRPT0/Y82gyYaP9U0VOThX/laAElvnm4kW82PX/Bk14usS0ofGeZpCCTNZCiuDYu9sEmsfJfU/80RHsVjl/LFYd9XdrquEZvpHHn8xAftrYVsKiIZzwPvF5dhG93KRuuTQJtEhP50V1OqbBCUx1Zr2RXvuYh+DUcPt+h9sYpo/NBfExMqSs7mA==
Received: from AM0PR0402MB3764.eurprd04.prod.outlook.com (2603:10a6:208:9::30)
 by AM8PR04MB7764.eurprd04.prod.outlook.com (2603:10a6:20b:244::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.22; Sat, 21 Sep
 2024 02:28:51 +0000
Received: from AM0PR0402MB3764.eurprd04.prod.outlook.com
 ([fe80::94f5:bec:6340:5d99]) by AM0PR0402MB3764.eurprd04.prod.outlook.com
 ([fe80::94f5:bec:6340:5d99%6]) with mapi id 15.20.7982.022; Sat, 21 Sep 2024
 02:28:46 +0000
From: Chema Casillas Mora <carlos.mora@nxp.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Luis Valdez <luis.valdez@nxp.com>
Subject: Serial console via USB on U-boot error
Thread-Topic: Serial console via USB on U-boot error
Thread-Index: AdsLy9X6xKJtn1MiS/m6buSspmPCMw==
Date: Sat, 21 Sep 2024 02:28:46 +0000
Message-ID: <AM0PR0402MB3764F30FA2A2A99A9E44D6DFEC6D2@AM0PR0402MB3764.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR0402MB3764:EE_|AM8PR04MB7764:EE_
x-ms-office365-filtering-correlation-id: 7d05d771-e984-4cbf-3fa3-08dcd9e51edc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?Y5CcHtXobpWcgBXaNBQZEhfYNph21yT2RsoPYW7pNfFyMc77U1gZPw/fT3jh?=
 =?us-ascii?Q?6dOVFs1Xe6JLIL9/abLwy/8TxZXFoyqreTLF9Pxfv5Soq1++llwPMj8Qjmyz?=
 =?us-ascii?Q?wjiAL9zZZj0CczTUh5T+iKLgThKkdquFgxNoQKdzQ1ezkSGnZF05utKI8Obs?=
 =?us-ascii?Q?kBDljzOrIsE+mpdRc299cMZGP4L6JB0IHEOeeP4GuGL7UMAModKtSSuuIBY9?=
 =?us-ascii?Q?6owUtZsdsB+w3NI6xfwFgkVU7PddAxfcG5ULvw9Y3R4R4+fklKrn3EfODQeH?=
 =?us-ascii?Q?D/iu+9YbyJ5/6oC/bs8q+nA4RY0Z4OGDEojUioGhrVyipvCP70+1U+oDnXgk?=
 =?us-ascii?Q?75lKMjcuEQngAaAwAyC+3eI4GvpG+bDnU+UAJWwkCGWcmwkH03YNzgYxjcl4?=
 =?us-ascii?Q?gKH1B7p8w2B9yjFuflUo4IDQGm9Xtyo62OaYiDYPkiI5FAUkqZ//ALQpnX9D?=
 =?us-ascii?Q?e8tx7ETEMnig+aDma1jYIQ+nd4V8sUVg97L7Lonu+nbOm/LHhdFTCMOpxEWi?=
 =?us-ascii?Q?XvG1yXuuPKHVimdfexXFHvplF3UwUTkLRU2tZrdsEwEw1Dx8ZI5ov+m9wVjr?=
 =?us-ascii?Q?EBRiPEpfkLLDYpUuSrZtqFgPyqRSOIoy9xiHfQoQM4FqhatuyWpSca9JnkJK?=
 =?us-ascii?Q?jnGPhRdso+oF/Er6RMbLR3MNh6CNs+lpd0xpo6rsFBrN7zzU6ipcE08aGjrt?=
 =?us-ascii?Q?DzWoHR91rgDMsYXdWXrwUyloHsvJDL0espARp+DqpDMDnKHPSSIjvyOT1vja?=
 =?us-ascii?Q?wyc7Qn1H+uhIKbvOJQ5Npykn88hw28uL6bwG1vs9/x7qYscrOtiwKQPwBYGv?=
 =?us-ascii?Q?6bgvgAgsZzirDxCn9+afll9pzVR/l8TAVNpehVTCqE3S5pF7mWJWSOgt4RGH?=
 =?us-ascii?Q?WEQMX/vjZcwakBjguBPAafYrGIos5VH38TEyDTUmVg4gaQxcd8yWbV/MQaiy?=
 =?us-ascii?Q?BCGx76eSFLf4qyl9sI73E41SgcI5OiNAdA6Kph/Uw4eVYMIGCaeYN1uK3U0p?=
 =?us-ascii?Q?smWpoWj87ftRd3e41ikoOSdokY63o4eR/0v83lELcGFvnrAq1fDAvQaV1Din?=
 =?us-ascii?Q?ReAm1sMoqyF01PnfbWgoi5YctWkxSuIpL+ZcWDdmc2fw+UqEAgQO+QL2R4Gm?=
 =?us-ascii?Q?a+Z1V7sMFLsusSTy7yvjvh/sLk62nNg6EHkXz33efEfJa7v8IzOGzftMka2g?=
 =?us-ascii?Q?w0SHZ4SGj7VpgdkReOTgFDbv6BbBYUQzYV6b0KEw3ns5xdDeCdjMri+HqE5W?=
 =?us-ascii?Q?IdShSKyQd51uS66YWjy3VwNFCU06SnbvR9aA0RNlf17sGNzK7S1DNFOzctzD?=
 =?us-ascii?Q?SI7/VQQgP+g9tUKqzlnfbl5Vv4rMRlHKlSOqBnTPC1yCuqTKoCLyRn39rR4u?=
 =?us-ascii?Q?GTne3IOI63u17MzbImyzsJkICKhT3+aBj3zNBQuwwa0d6ZlByQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR0402MB3764.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?soywfHvZyNU5AZFYLQua4FJ7RaGku7e9X6s68ElT+BQlmgolFNvNH9Dh7xsm?=
 =?us-ascii?Q?+WKxmirM+R4H3vG/+b6xdQUN38gVQw8iiPlsMnWVBVDJZvfAVDO2b/DJZhRt?=
 =?us-ascii?Q?14N6ICFq+TLl693wEdbXNvG+98MoC+cOUUXPeBZZSljU2bFjEgBCNNdifs5Y?=
 =?us-ascii?Q?xNE56vaOIm7ZWhdxKsDcADG+ldAIzRHqgJU72YOkRZ1oZi+K9KVVKe7gvhjB?=
 =?us-ascii?Q?tXORBLWbgCISFoW42ACK2ms6aoV5shlmf6zE7bN6ROuI4w1vIItcOzWSLHnq?=
 =?us-ascii?Q?WBPd7YzsNNqT+K+MRkFgJ1aRYyeJiiLxKkZ5lNf+CN4wAU1XCYVcnuRsuC+7?=
 =?us-ascii?Q?31aXOPY1k1jB0OJZgFQR6mtXTUxHToJqMC8/z9c86Y9gg74akQIecxd/ofNy?=
 =?us-ascii?Q?/o9KSPZoVgermt+8De6HRnN2YwHuCkZaOSOuL5qB6bjLn0S8+3O4vpNHPpzF?=
 =?us-ascii?Q?qdMNXgyn0S5BHyGAZ+AIeOGR3Fn5ZvnNEplSa875G+B0cgEppS1raxtkH3JZ?=
 =?us-ascii?Q?sAy1M8KgM7SGhVAAA0FSIv4Inr09ssNGQQ1oPw5OHyzE6wXpJIMYKcZrfrYr?=
 =?us-ascii?Q?vKJID76zH/LDLWz32jBRv0UimT4OqyMKGhbku2sI5qSjVX1uackqk/yZ94Fc?=
 =?us-ascii?Q?pY84PXjSTzfY78P1P8L0EQmux7YJAZeDNcZ0y9vfNkG70m/BhHp+54+tNayW?=
 =?us-ascii?Q?+THImZ62aaFmTKRVMWsZ7VdeO5a9dLLqs0AytLysLIPdQ6ILeMiMMj1El4d5?=
 =?us-ascii?Q?Nl0yPtM4fqhZsU7JaO0alz4exJI2bgq5LULB95MMj/Z/r1nN+W1k3y97mydM?=
 =?us-ascii?Q?5+SzkulbCFoU7pLboZNAnafcZtj746MxxcZb1u2ZwPRLazlColnZpeFpf300?=
 =?us-ascii?Q?A5eDACXRXATt2TZPwKXQGPPfmVRiTxPhlA8A1yoKznAY/us3tEbnRSyZrY8h?=
 =?us-ascii?Q?0oQw6j8f3orSSZZpA5jDpESdSb8kCE4hSYe5GXOv+6ms5Z2RZ/R6fm3lGE/s?=
 =?us-ascii?Q?lkMAfWzvBJgCAADI4Kpw8DR6EZOgbDtpgGkjKAGdH4YS92aTfVWpKBLLVkiO?=
 =?us-ascii?Q?QpLj5S4G22Qe5N4GDVAbZ7ug0o3Q6gH6IiEZWyDAoaF6+5WQYKNn58hlrLbP?=
 =?us-ascii?Q?Z16LqmsmMB/a1GZQE7zqvUWvw2f3PK9uTG9DABF/ErjgIQf0K7rEqNs6hQFB?=
 =?us-ascii?Q?F2Mos3Z3Lg/Vd5vziXItJ3SZNHT9806abBqDztx+qPtLc79tkYqwmGEDnzmx?=
 =?us-ascii?Q?mXrU5y/7YectJpb98UfUZq5zTI2OtWU1qBJRqoluKODwj2W01JOfHGnAZSLo?=
 =?us-ascii?Q?leK2HCAlRWLAWpYrh7L++Q5DEKn1E1Oeoeb3FDdIc2lM9hzrTzFVRxjXEt8D?=
 =?us-ascii?Q?tqOOmlRbAdkJzd/i2ATLCZKt0ZpYEH7ajRxUMHCa4ZdXtr/C4jM7oUAhwbS4?=
 =?us-ascii?Q?WgEpVk/1Br5d23fTptIUjf8lwXYliXFIEaDDmjnWsWiJZ8iAs0ucAF8593Qw?=
 =?us-ascii?Q?8gdT+LTZeLMAzq0x87kb32csYTV0AaJUznG0mq+eFm4nbByYlvZkAFv8fHgu?=
 =?us-ascii?Q?jSc2uvySqch+JyRMgk+RI/D/39w8Z7/DtyhthySC?=
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature";
 micalg=SHA1; boundary="----=_NextPart_000_005C_01DB0B9B.AFB20EC0"
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR0402MB3764.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d05d771-e984-4cbf-3fa3-08dcd9e51edc
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2024 02:28:46.7893 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q8Qu7/Z9o/Eqg8PJK6DAuJGB9eiUJq2HUMFB7Nh7wWEXhxWtHyjTLY0vToTYCtu8XgaujzSEef9UNEF0R9gVaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7764
X-Mailman-Approved-At: Sat, 21 Sep 2024 04:37:23 +0200
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

------=_NextPart_000_005C_01DB0B9B.AFB20EC0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_001_005D_01DB0B9B.AFB20EC0"


------=_NextPart_001_005D_01DB0B9B.AFB20EC0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_002_005E_01DB0B9B.AFB20EC0"


------=_NextPart_002_005E_01DB0B9B.AFB20EC0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi U-boot team,

We have realized that, on NXP i.MX93-EVK, when switching the console to usb:

u-boot=> setenv stdin usbacm; setenv stdout usbacm; setenv stderr usbacm

On a Linux host the gadget is detected-

Bus 003 Device 101: ID 1fc9:0134 NXP Semiconductors USB download gadget

However, Linux dmesg host shows an error.

[1138006.159559] usb 3-1: new high-speed USB device number 101 using
xhci_hcd
[1138006.309162] usb 3-1: config 1 interface 1 altsetting 0 has a duplicate
endpoint with address 0x81, skipping
[1138006.310989] usb 3-1: New USB device found, idVendor=1fc9,
idProduct=0134, bcdDevice= 2.21
[1138006.311004] usb 3-1: New USB device strings: Mfr=1, Product=2,
SerialNumber=3
[1138006.311011] usb 3-1: Product: USB download gadget
[1138006.311029] usb 3-1: Manufacturer: FSL
[1138006.311033] usb 3-1: SerialNumber: e6a3c0352fb31ff6
[1138006.314521] cdc_acm: probe of 3-1:1.0 failed with error -22

I checked that endpoints are misconfigured. For a CDC device, configuration
1 has one IN interrupt endpoint, and configuraton 2 has two bulk endpoints
(IN/OUT). Although they are set on that way, for U-boot implementation was
using EP1_IN for both configurations. This issue is also present on
iMX8MM-EVK as well since it uses the Chipidea (CI) USB IP (same as iMX93).

Attached is a patch containing the fix for this issue which adds a specific
case for CI USB in the usb_ep_autoconfig function so that the endpoint's
name of the USB IP matches with the corresponding USB endpoint descriptor. 

CONFIG_CI_UDC needs to be set to 'y' for this fix to work, as it makes use
of the gadget_is_ci  macro to identify the USB IP.

 We are sending this email since the epautoconf.c file is part of the uboot
code.

Is there are additional specific requirements to request integrating this
patch into U-Boot code?

Thanks in advance and best regards!

/Carlos

 

 


------=_NextPart_002_005E_01DB0B9B.AFB20EC0--

------=_NextPart_001_005D_01DB0B9B.AFB20EC0
Content-Type: application/octet-stream;
	name="mypatch1.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="mypatch1.diff"

diff --git a/drivers/usb/gadget/epautoconf.c =
b/drivers/usb/gadget/epautoconf.c=0A=
index 1b435c4653c..a703be1a686 100644=0A=
--- a/drivers/usb/gadget/epautoconf.c=0A=
+++ b/drivers/usb/gadget/epautoconf.c=0A=
@@ -281,6 +281,30 @@ struct usb_ep *usb_ep_autoconfig(=0A=
 		if (ep && ep_matches(gadget, ep, desc))=0A=
 			return ep;=0A=
 #endif=0A=
+=0A=
+	} else if (gadget_is_ci(gadget)) {=0A=
+		const char *epname =3D NULL;=0A=
+=0A=
+		if (type =3D=3D USB_ENDPOINT_XFER_BULK) {=0A=
+			if (desc->bEndpointAddress =3D=3D USB_DIR_IN)=0A=
+				epname =3D "ep1in-bulk";=0A=
+=0A=
+			else if (desc->bEndpointAddress =3D=3D USB_DIR_OUT)=0A=
+				epname =3D "ep2out-bulk";=0A=
+=0A=
+		} else if ((type =3D=3D USB_ENDPOINT_XFER_INT) &&=0A=
+			      (desc->bEndpointAddress =3D=3D  (3 | USB_DIR_IN)))=0A=
+			epname =3D "ep3in-int";=0A=
+		  else if ((type =3D=3D USB_ENDPOINT_XFER_INT) &&=0A=
+		          (desc->bEndpointAddress =3D=3D  (1 | USB_DIR_IN)))=0A=
+		    epname =3D "ep1in-bulk";=0A=
+=0A=
+		if (epname)=0A=
+		ep =3D find_ep(gadget, epname);=0A=
+		if (ep && ep_matches(gadget, ep, desc))=0A=
+		{=0A=
+			return ep;=0A=
+		}=0A=
 	}=0A=
 =0A=
 	if (gadget->ops->match_ep)=0A=

------=_NextPart_001_005D_01DB0B9B.AFB20EC0--

------=_NextPart_000_005C_01DB0B9B.AFB20EC0
Content-Type: application/pkcs7-signature;
	name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="smime.p7s"

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIhXTCCBaIw
ggOKoAMCAQICCE4Rpu+H69FRMA0GCSqGSIb3DQEBCwUAMGUxIjAgBgNVBAMMGU5YUCBJbnRlcm5h
bCBQb2xpY3kgQ0EgRzIxCzAJBgNVBAsMAklUMREwDwYDVQQKDAhOWFAgQi5WLjESMBAGA1UEBwwJ
RWluZGhvdmVuMQswCQYDVQQGEwJOTDAeFw0yMzA0MjEwNjQzNDVaFw0yODA0MTkwNjQzNDVaMIG2
MRwwGgYDVQQDDBNOWFAgRW50ZXJwcmlzZSBDQSA1MQswCQYDVQQLDAJJVDERMA8GA1UECgwITlhQ
IEIuVi4xEjAQBgNVBAcMCUVpbmRob3ZlbjEWMBQGA1UECAwNTm9vcmQtQnJhYmFudDETMBEGCgmS
JomT8ixkARkWA3diaTETMBEGCgmSJomT8ixkARkWA254cDETMBEGCgmSJomT8ixkARkWA2NvbTEL
MAkGA1UEBhMCTkwwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDAWrnSkYP60A8wj4AO
kATDjnbdgLv6waFfyXE/hvatdWz2YYtb1YSRi5/wXW+Pz8rsTmSj7iusI+FcLP8WEaMVLn4sEIQY
NI8KJUCz21tsIArYs0hMKEUFeCq3mxTJfPqzdj9CExJBlZ5vWS4er8eJI8U8kZrt4CoY7De0FdJh
35Pi5QGzUFmFuaLgXfV1N5yukTzEhqz36kODoSRw+eDHH9YqbzefzEHK9d93TNiLaVlln42O0qaI
MmxK1aNcZx+nQkFsF/VrV9M9iLGA+Qb/MFmR20MJAU5kRGkJ2/QzgVQM3Nlmp/bF/3HWOJ2j2mpg
axvzxHNN+5rSNvkG2vSpAgMBAAGjggECMIH/MFIGCCsGAQUFBwEBBEYwRDBCBggrBgEFBQcwAoY2
aHR0cDovL253dy5wa2kubnhwLmNvbS9jZXJ0cy9OWFBJbnRlcm5hbFBvbGljeUNBRzIuY2VyMB0G
A1UdDgQWBBRYlWDuTnTvZSKqve0ZqSt6jhedBzASBgNVHRMBAf8ECDAGAQH/AgEAMEUGA1UdHwQ+
MDwwOqA4oDaGNGh0dHA6Ly9ud3cucGtpLm54cC5jb20vY3JsL05YUEludGVybmFsUG9saWN5Q0FH
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
TiWKaSrsUjAfBgNVHSMEGDAWgBRYlWDuTnTvZSKqve0ZqSt6jhedBzCCAUYGA1UdHwSCAT0wggE5
MIIBNaCCATGgggEthoHIbGRhcDovLy9DTj1OWFAlMjBFbnRlcnByaXNlJTIwQ0ElMjA1LENOPW5s
YW1zcGtpMDAwNSxDTj1DRFAsQ049UHVibGljJTIwS2V5JTIwU2VydmljZXMsQ049U2VydmljZXMs
Q049Q29uZmlndXJhdGlvbixEQz13YmksREM9bnhwLERDPWNvbT9jZXJ0aWZpY2F0ZVJldm9jYXRp
b25MaXN0P2Jhc2U/b2JqZWN0Q2xhc3M9Y1JMRGlzdHJpYnV0aW9uUG9pbnSGL2h0dHA6Ly9ud3cu
cGtpLm54cC5jb20vY3JsL05YUEVudGVycHJpc2VDQTUuY3Jshi9odHRwOi8vd3d3LnBraS5ueHAu
Y29tL2NybC9OWFBFbnRlcnByaXNlQ0E1LmNybDCCARAGCCsGAQUFBwEBBIIBAjCB/zCBuwYIKwYB
BQUHMAKGga5sZGFwOi8vL0NOPU5YUCUyMEVudGVycHJpc2UlMjBDQSUyMDUsQ049QUlBLENOPVB1
YmxpYyUyMEtleSUyMFNlcnZpY2VzLENOPVNlcnZpY2VzLENOPUNvbmZpZ3VyYXRpb24sREM9d2Jp
LERDPW54cCxEQz1jb20/Y0FDZXJ0aWZpY2F0ZT9iYXNlP29iamVjdENsYXNzPWNlcnRpZmljYXRp
b25BdXRob3JpdHkwPwYIKwYBBQUHMAKGM2h0dHA6Ly9ud3cucGtpLm54cC5jb20vY2VydHMvTlhQ
LUVudGVycHJpc2UtQ0E1LmNlcjBRBgkrBgEEAYI3GQIERDBCoEAGCisGAQQBgjcZAgGgMgQwUy0x
LTUtMjEtMTkxNTIwNzAxMy0yNjE1MDQwMzY4LTMwNzY5Mjk0NTgtNjMyODY3MA0GCSqGSIb3DQEB
CwUAA4IBAQBc863MdAiYWP+BOkLXaAiDKtFzEMLHr9R+puCgGPWl2XeeaQsnek96TtrBsQpKkVEN
RuTYHbioqGXsiooyQRTl6U0nubJlHnlQqCMn5vt52S4ZHlG3jBbDv+SmZowSoAOvaKXuEL8vCqIl
jNsk0qg/Dc4oNPjFxYYn0cma+hFxPvpS3BOweDK1FiSyWeQgm4HVlu1jz+3NuzQInwMcgx56gYx9
h3LPb6hin++GWDDk4oFU8/JTX8WP6LtjnrP3W3o1dYQOFWWnS7wdYEFxSzLJNxy0g9JJxm7s4oPg
EUwRWK910pL4D0/RdR9M9o3cqwwMOzLEIHOGcKlJ30PCmmeHMIIIQDCCByigAwIBAgITLQAKThlP
Ss50kijTQAABAApOGTANBgkqhkiG9w0BAQsFADCBtjEcMBoGA1UEAwwTTlhQIEVudGVycHJpc2Ug
Q0EgNTELMAkGA1UECwwCSVQxETAPBgNVBAoMCE5YUCBCLlYuMRIwEAYDVQQHDAlFaW5kaG92ZW4x
FjAUBgNVBAgMDU5vb3JkLUJyYWJhbnQxEzARBgoJkiaJk/IsZAEZFgN3YmkxEzARBgoJkiaJk/Is
ZAEZFgNueHAxEzARBgoJkiaJk/IsZAEZFgNjb20xCzAJBgNVBAYTAk5MMB4XDTIzMDgxMDIzNDEz
MFoXDTI1MDgwOTIzNDEzMFowgZoxEzARBgoJkiaJk/IsZAEZFgNjb20xEzARBgoJkiaJk/IsZAEZ
FgNueHAxEzARBgoJkiaJk/IsZAEZFgN3YmkxDDAKBgNVBAsTA05YUDELMAkGA1UECxMCTVgxFjAU
BgNVBAsTDU1hbmFnZWQgVXNlcnMxEzARBgNVBAsTCkRldmVsb3BlcnMxETAPBgNVBAMTCG54YTEz
MzM4MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAvLeDSrwVm5BO84pk3X9nUn2P73Zz
5nvpodHMxhAKK50pg5RQqpIw4Z61ysfWwYnJd64deUVWIGQDMjlhWhruVqluYzPxrL2C1+oUsJCZ
UUSX94/qhv/mAvVdiC8aX7N5VK5EkWsa8801Ud/ufXcinjTA25vJFYHYZqGFzBz9Xlqq54iVWg2s
PKda05ncf3BSzOxQlVmK86qgeqeoF4IoQ9I6BYxOEUG9aFTCyPi8Fn+48BseChtEqbEnhonFsBjZ
0X9hFbuxETkBFWOIrHQ2aYczUaRGQTejlJrmU8t7l9WwwioZr0PDR3xabUZVa0gQo3RhK7AzkmAm
eqCHDnCPDQIDAQABo4IEXzCCBFswPAYJKwYBBAGCNxUHBC8wLQYlKwYBBAGCNxUIhYLAfoGO9FWG
7YU4guuZS5qSVj+F5opuhLXhfgIBZAIBOzATBgNVHSUEDDAKBggrBgEFBQcDBDAOBgNVHQ8BAf8E
BAMCBSAwDAYDVR0TAQH/BAIwADAbBgkrBgEEAYI3FQoEDjAMMAoGCCsGAQUFBwMEMIGUBgkqhkiG
9w0BCQ8EgYYwgYMwCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBLTALBglghkgBZQMEARYwCwYJYIZI
AWUDBAEZMAsGCWCGSAFlAwQBAjALBglghkgBZQMEAQUwCgYIKoZIhvcNAwcwBwYFKw4DAgcwDgYI
KoZIhvcNAwICAgCAMA4GCCqGSIb3DQMEAgICADAdBgNVHQ4EFgQUZTqgrLDWcW6Dh5pzQX9Q+zIi
jqgwHwYDVR0jBBgwFoAUWJVg7k5072Uiqr3tGakreo4XnQcwggFGBgNVHR8EggE9MIIBOTCCATWg
ggExoIIBLYaByGxkYXA6Ly8vQ049TlhQJTIwRW50ZXJwcmlzZSUyMENBJTIwNSxDTj1OTEFNU1BL
STAwMDUsQ049Q0RQLENOPVB1YmxpYyUyMEtleSUyMFNlcnZpY2VzLENOPVNlcnZpY2VzLENOPUNv
bmZpZ3VyYXRpb24sREM9d2JpLERDPW54cCxEQz1jb20/Y2VydGlmaWNhdGVSZXZvY2F0aW9uTGlz
dD9iYXNlP29iamVjdENsYXNzPWNSTERpc3RyaWJ1dGlvblBvaW50hi9odHRwOi8vbnd3LnBraS5u
eHAuY29tL2NybC9OWFBFbnRlcnByaXNlQ0E1LmNybIYvaHR0cDovL3d3dy5wa2kubnhwLmNvbS9j
cmwvTlhQRW50ZXJwcmlzZUNBNS5jcmwwggEQBggrBgEFBQcBAQSCAQIwgf8wgbsGCCsGAQUFBzAC
hoGubGRhcDovLy9DTj1OWFAlMjBFbnRlcnByaXNlJTIwQ0ElMjA1LENOPUFJQSxDTj1QdWJsaWMl
MjBLZXklMjBTZXJ2aWNlcyxDTj1TZXJ2aWNlcyxDTj1Db25maWd1cmF0aW9uLERDPXdiaSxEQz1u
eHAsREM9Y29tP2NBQ2VydGlmaWNhdGU/YmFzZT9vYmplY3RDbGFzcz1jZXJ0aWZpY2F0aW9uQXV0
aG9yaXR5MD8GCCsGAQUFBzAChjNodHRwOi8vbnd3LnBraS5ueHAuY29tL2NlcnRzL05YUC1FbnRl
cnByaXNlLUNBNS5jZXIwQwYDVR0RBDwwOqAjBgorBgEEAYI3FAIDoBUME2Nhcmxvcy5tb3JhQG54
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
AAA=

------=_NextPart_000_005C_01DB0B9B.AFB20EC0--
