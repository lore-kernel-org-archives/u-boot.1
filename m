Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97A08C25B74
	for <u-boot@archiver.kernel.org>; Mon, 27 May 2024 17:16:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B20F87EAC;
	Mon, 27 May 2024 19:16:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="BMMpyJQ4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 736AC87DAB; Mon, 27 May 2024 19:16:16 +0200 (CEST)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260f::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BBDF687F6F
 for <u-boot@lists.denx.de>; Mon, 27 May 2024 19:16:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=elena.popa@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZK2HgTp3fMb7iI5VQIoPwdb3ROskhKCXaaOzIL7+8qAMyJU/x6BruiAfIoNPEbhbvzd/jTHXVYN3bJ6B0/gsF5U2xzGM7EyTRTrozFo9IN8dpRu7+u5GO2VJhcYRMkdim1nIxA1smD2odwp2ngU7/jAdkFCv2JLtp/CvBuRHzzHEVpEnRycQipBuC1fjJEV2D3bEkUTqp4hfdtwn2pWhsV1X72d6BCeFoRQ/uQkAJyLaeGbGJjuGmYkKuT8mCRzN0fPtFomF/uhnyOB+GCLXUO1G085L0tEpJ12fGm6c2Ei+lAIFxP1n4VuYDEJWC+FTEsSTzJVlJruyrychxkcmlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZDzPJ3VKYrSPGQy/NPhSe4cVIzK+zkhZiocWHgNIJTo=;
 b=Rnkim/9C6+Q9HMHrwJ8tf19y3Hbj8JYf7KgyqKPjRqyS1tzPWCyesufbF/fCoZ/VY1oMuTiZfo0Kk1ceoODXaAvAYAvBk8+V6EuyLHF61dhPGzmGHzxAdyqxh8wGv2WmMRzcXgOhUyGZJHj3udnwPKsFXpIycQVjbTAFrYj7gtpLiB3a8abPTn/6hnSl6nUAK50JSktHStycqdEUDf0gHGEG3O68V6plIIqwu2S9vBLjEcsugdp3TEZanv0Boq/f7hzN7W4nExPaotoajZY0R2lCQ/Z9tZAPHGnKWYhv0q4K8MMfbE99WVRVUjO4trL6i/KLrekxKakeKBcFOd2uAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZDzPJ3VKYrSPGQy/NPhSe4cVIzK+zkhZiocWHgNIJTo=;
 b=BMMpyJQ4Xq84I0nMXByAJlf7RLnF4Ge4aTOwUEx9tJWV6L2IZTxDr7WaGBfMK18BhnRrZaZ6wz/JjA92nk6kbiDZI/Xu3s1kBBwk/dBNHJLyKy65F6XpVp5Fs3xi+df2a3jQ8KE0bzpTwTlWDyrbYxQVQsulsLtUgBoAZD5WpkY=
Received: from AM7PR04MB6968.eurprd04.prod.outlook.com (2603:10a6:20b:dc::13)
 by DU2PR04MB8630.eurprd04.prod.outlook.com (2603:10a6:10:2dd::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Mon, 27 May
 2024 17:16:11 +0000
Received: from AM7PR04MB6968.eurprd04.prod.outlook.com
 ([fe80::31a7:17e5:a4e8:ef5f]) by AM7PR04MB6968.eurprd04.prod.outlook.com
 ([fe80::31a7:17e5:a4e8:ef5f%4]) with mapi id 15.20.7611.025; Mon, 27 May 2024
 17:16:11 +0000
From: Elena Popa <elena.popa@nxp.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Simon Glass <sjg@chromium.org>, "gautam.vivek@samsung.com"
 <gautam.vivek@samsung.com>, "vikas.sajjan@samsung.com"
 <vikas.sajjan@samsung.com>, Marek Vasut <marex@denx.de>
Subject: [RFC] usb: xhci: Some USB devices fail to initialize
Thread-Topic: [RFC] usb: xhci: Some USB devices fail to initialize
Thread-Index: AdqwWVW3P9w5ugCBRoKUpk8i6qFE+A==
Date: Mon, 27 May 2024 17:16:11 +0000
Message-ID: <AM7PR04MB69685A41537BA13AB3D32C7590F02@AM7PR04MB6968.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7PR04MB6968:EE_|DU2PR04MB8630:EE_
x-ms-office365-filtering-correlation-id: 0b6c69d1-2a55-4f4d-17b1-08dc7e70b4da
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?/TiKxl10naUZzEVS8064VEW9EpSZ8zGc/H6RRdwtanT/N8trrG52H5Db4uHO?=
 =?us-ascii?Q?ziPi3TUN40ecuoVT+m+g/lCt7PgzIwuEzgnHgFyPI1ym4eFXw+1tKI/wxEKa?=
 =?us-ascii?Q?yiigJmBH7AVEntbWu9y8ivtaS8UdlNibAWPUDQqyjZpL5jKQNStdVHxV+2S8?=
 =?us-ascii?Q?6Y1r7v2x91i8WpaAKlfZTNw1Li7q/0wynp/FgiSn/IBVULfoT39z6U5mbkju?=
 =?us-ascii?Q?cqOL7hWSrwU+7LfaxoVslbsoUEdUy/5FkZFJ6tlNEaF/CtwtXeSWfw7LySzZ?=
 =?us-ascii?Q?ICTfzv7QCc2Fghq/P76vutBP2qdPYxsCMnpePl24do+1Q2kLT39dbwQL6Dtw?=
 =?us-ascii?Q?jeJLNcZfVIC0pvjWGlDn9POKAHYUnV/vqUm6eIH5MmoNRMzipe4KYSic+z4K?=
 =?us-ascii?Q?+vk6C7KPwVUyi6Ye6hzkXIe1QTt0nD06EhA9MzxhnxzbC+JrCYOXTxdB5ubh?=
 =?us-ascii?Q?2LZVsd+enWIc3TyEMrhkRzJGhCXaM6/C3JkCw30UAW602UwkNDH8gMHJV8xD?=
 =?us-ascii?Q?Hy+SmasMgACFBtfKLCKO9c0zW0PV/aVVmAkXGXfqdWkZ4faz3H66CngwaZYF?=
 =?us-ascii?Q?LffSi8LqgWrBi7TGy5hDrl4Eup1vUkc6QnevU2mVaVeDo2Q/IsN+u5O/IrKb?=
 =?us-ascii?Q?ETzUDs4NsWHDrpV2IM8c2IURzs6YfDqtzsu58yA9rcpkjqbxbXsfk5XQsQDa?=
 =?us-ascii?Q?ThkNPgjHidlAlMTtX7aZeIc1ku6S1BiQ1Sk6KlVQ19SViAjaeinKRvMKsJhV?=
 =?us-ascii?Q?k4obVHkNWswhw1BqL98rD2uFibXt1sUNzwDuyJD4yxk9dBqD2rvJw+AndOGF?=
 =?us-ascii?Q?npe/5T41XkOGkaSKc2fzxTZj+GYcKj/i1OjIT4Y4+af5X3Zz/eWVmqmqHb3P?=
 =?us-ascii?Q?/ES1+ma63uTdgN+9YGdzF+uawLuIymaUPGFqDt4EbtavGMesIlN6SVYBv7OE?=
 =?us-ascii?Q?c2w5UuKezrZkIWJBfJomkHHkCW7SLE83B5qVhuo9LIlQhei7wgzlhY+1nqFw?=
 =?us-ascii?Q?ndA4sJl7mdq9rbxmrQwal9fSVJ5MXvPFENdHx/t2EB+Og8nRfLJyJC4NtQUp?=
 =?us-ascii?Q?V736Q8LwekpoQi+J8Q98sACNRLMuDBPvU4R0GT1tBHu+/zpTWGGrsxapBbaz?=
 =?us-ascii?Q?5AfmszqoYVDBpp6rdOoNx05Rv5TKq9lh4L1BvjBhpt8lFSce6SKpcXJpDxMt?=
 =?us-ascii?Q?kDirj+h2vMwpdR4XVet7/yFjrff8lBZX7LOk27xUCkV8qXCR+GRBNv1U8NFA?=
 =?us-ascii?Q?j/ekKnLjCCOh/f7SmdWiqvipNNaG+4gk/PsctTJ4+6jcb7TuFpLNhyTJByea?=
 =?us-ascii?Q?jQLnDWQvkQsvjf64AJZNuQnP11m/OYmr7AhwVKi6wPo36g=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR04MB6968.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LIpb/+yF6WbjXHy0w327b1m5Vh6srVrEiIwWuHkdNRekEqbOBoLKUrcjc5+g?=
 =?us-ascii?Q?qPGe4Ce92Jrda4JxwhhjoOft+j5s9H3i75a4QIUUA9kFLyh9mcC890cV8wzq?=
 =?us-ascii?Q?UV4FL0EV42qEgdwz05/fY4nt5EYzBbQML57k7K1OjNu8W486CcHiEJdl6gZv?=
 =?us-ascii?Q?naqDiwEtBk+MdrgjLOwAs9eKeuhr9v4Lcjp9ZeTrQKRHjsSoMS2CylmdAaPu?=
 =?us-ascii?Q?tZDv8oVwnz0Hje5FSV4hTic+LhCeeTd3PiSLVlAjxyrivPUkOYSdWeeBlJQL?=
 =?us-ascii?Q?hPX9anSVoC9X1Nqsa7Rtq5QsA989cROSI7xTzOHfibnleaLbOPiABC1vg7Kj?=
 =?us-ascii?Q?41OnlWat4Ar5pEQrKjRLyCG7ZyKOP9kxHfOlgNsknhvH93rZGb7Rvsb/3GP3?=
 =?us-ascii?Q?2+L3FwGcGYZ/0wz+vrKbUlNpJo65KwN562MGga8r7EpqQWgL1IGI4raXk5AX?=
 =?us-ascii?Q?2xgKnz2qxdYagwYwT0bg2pidI1wanA+JeZc/s6HneuSb+kVTouM68cCO3bzj?=
 =?us-ascii?Q?FrK2VunZtotVdS/3ih++mNMEcdddHZ2PPCR+lTdbY+EAHbM9kCA10TRGApHb?=
 =?us-ascii?Q?UxjZ5NzAgl3e0bYpqgBPQPV/Ar5cRfbNkgMuvR5u6GRfYfx89XWt0vLbevnu?=
 =?us-ascii?Q?Ot8+FhQxBcn9jSgVosGnIyWRQQku6uTsfz2FokUUWKoZqrldKP9YiGBSB0mt?=
 =?us-ascii?Q?Hw8es1la7/hFXcfLIeHkRpK1HEe3jBsTTXWsDvxz9w9q4nhCXaQeTRqI90kK?=
 =?us-ascii?Q?nBvf1BWP7w0Zy7BaB4qC79HCfs4WwLug8hi/Xq3EKaptZm5avJM8V2KZEgbE?=
 =?us-ascii?Q?9BfF0EQ2OmGsZrQJyDRfs4YDWdpm1uakYYJHZdJ4hh+lAHCjvIBvMB2UNn/A?=
 =?us-ascii?Q?cQWDGkvV/aAfa96SsXH8dRCzfs36peyL4SUNgSvcFG7uh/qwWYHiZYQD/kQU?=
 =?us-ascii?Q?GxD6gjaCeLmNrjQrpapR7ex2/XIXxTbKcVklUuIZgIzDycXyPciGA4U5TzWn?=
 =?us-ascii?Q?NstGAau30j0GW00Gkc6wMfK8phihSUzI2B2MVKmxFIV+7AcM57tyonpvXkEE?=
 =?us-ascii?Q?mUAXuHZpZcyj61L6/gUj1lYMUWGP/iTKsHMGsxzG+JJv/jXOk126O7gyb0mJ?=
 =?us-ascii?Q?oYbkefffLcyqhvx1rShEDWh5YBHmNMk/dcovdAEN+7qePZ5YQYkyoCEK3E2T?=
 =?us-ascii?Q?TGvpjahLcJmfq5bSd370fYPVG39rnJF/zGbbkKmtmuvoVaGInsZz6HG0mASl?=
 =?us-ascii?Q?FO74Lz2fMx62TJKy5t0S+SeXy2eqoz661pC9LW6+UQXMnKzwV/2IZkhROu6K?=
 =?us-ascii?Q?VoaxcFg+eVNOKXkZfYF5iS5y12C3g726oaHsgbP5mSDGM1dYUJIRxP83oJRS?=
 =?us-ascii?Q?QabeY6WHUfPEkIq7bj7bZmcK3++TpmD8Cf8fjl/k59m16IO8JMQOi5RRsqO0?=
 =?us-ascii?Q?E2U3LkVqmANwBKWeVQWBa5rXF3XwKxV9KwopALcPfIgSc9c52cr0EOB9Rfx/?=
 =?us-ascii?Q?ExsClJhXwV9yYvpLxt050FABF9NRl3hATah5AdhHQGE128NEqHfuYrzWlSIJ?=
 =?us-ascii?Q?e7Z0gcyG5OxjdKAXzLajkq/KcivJ1dfhRtbG94aJ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6968.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b6c69d1-2a55-4f4d-17b1-08dc7e70b4da
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2024 17:16:11.5132 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bKFwJyUAY7/mYZvvxs1PaV5O35atIAUAgPvWcsWvNbV2kknrFcPgWuZX0PnMsr7qOJ/y0LdPYlqpugQyR2C8UA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8630
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

Hello,

We've noticed that, at least, on the i.MX8M* platforms, some USB devices (e=
specially USB2.0 sticks) fail to initialize with one of the following error=
s:
	- scanning bus usb@38200000 for devices... Device not responding to set ad=
dress.
      	USB device not accepting new address (error=3D80000000)

	- scanning bus usb@38200000 for devices... WARN halted endpoint, queueing =
URB anyway.
	Unexpected XHCI event TRB, skipping... (fcf1a5f0 00000000 13000000 0100840=
1)
	BUG at drivers/usb/host/xhci-ring.c:530/abort_td()!
	BUG!
	resetting ...

It seems to be a timing problem, since if we enable the debug messages, the=
 USB device initializes correctly.

We found out that if we add a small delay of 5 milliseconds at the beginnin=
g of the _xhci_submit_control_msg() function from the drivers/usb/host/xhci=
.c file, all devices initialize properly. Essentially, each control message=
 is delayed by 5ms. We tried a smaller delay (1ms), but it is not enough.=20

static int _xhci_submit_control_msg(struct usb_device *udev, unsigned long =
pipe,
				    void *buffer, int length,
				    struct devrequest *setup, int root_portnr)
{
+	mdelay(5);

	struct xhci_ctrl *ctrl =3D xhci_get_ctrl(udev);
	int ret =3D 0;
...
}

We went a little further, and this delay seems to only be necessary for the=
 requests of type:
- USB_REQ_GET_STATUS (for the communication with the root)=20
- USB_REQ_GET_DESCRIPTOR ( for the communication with the device)

I don't have too much know-how about the USB, so I would appreciate your op=
inion related to this issue, and how can we find the root cause. I found se=
veral reports on the internet with the same problem on other boards. Maybe =
some of the USB timing specs are not implemented correctly? U-Boot is maybe=
 sending control messages too aggressively?=20

If you give me some suggestions of where to look, I could do some debugging=
 myself. Of course, since printing debug messages makes the initialization =
work, complicates the debugging.

Thank you,
Elena
