Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE0A6FF8868
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 16:01:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D66F84178;
	Mon, 27 Apr 2026 18:01:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=hitachienergy.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hitachienergy.com header.i=@hitachienergy.com header.b="ncHuIFLV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BADE83BC4; Mon, 27 Apr 2026 17:00:34 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0550B83693
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 17:00:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=hitachienergy.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=tomas.alvarez-vanoli@hitachienergy.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j1URii7aLtgPJdNuPHx1QnGsVz8FxeZaMz3E0pgsvjGUIUALpdhspgY5RXN0FW2YY2JpMxqZDz4AXl388rKP+uT7sbFgMPLqA4SnPGYhqpjIlf0GC6YteXiCpG0+eMPvnUkLsaBdEBR/TGxf9Su5g8zwCntI4eZrhzg8SGz8uA4IZ6/GO+My+qgO2lmoIVcqmD6ip2My1DVYrK2EfDh5+8QovmumVtC7n5zXvBzw2MrLD1cN1ZfttlMv4WyitOnUU01i9W2AgBlbieepm5Ij3u53KqsaQ3KrT7VwnD6rdEo6x78vFQOZJhonDwXDzxcmdjl1cVBQ5iWsFbDjlJyxsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+EI9yYcnKYPH0p+dFEqZ8NB4AmHfZ0b9hvgDBOgSyVE=;
 b=ZFUMrF+K6xDPD583uY0zCpv1Ik7E6ikIKp2UCSuQkPWzLZvAOpEQxZBTShHAEjNyv0ZAX3VZMkYS+bHlv5mkTqIs1PQbRRAfwp240tePS4UjqxJ0BmMS8ghAOzu7jO/NIxl2z5SSP6y5LJG0Fa7HFYtv/cdVEl0NN0MGDqmmeawNAP0mYACqToXXl+CdKNpbcRidzGYtP8vYOXZ2vu2xfrtkZ5Bz0KC9dNjqaVGgOvpmtGDeFF25CYF3kYh2YznuAJRvLuGjdNrtilRh5Dn8NxBDqdXT4MCZS3H1NLFDA8z7TglDRNzzvaGu7O2xCu+a0uQ5U93bCYaw0rtvMd6nfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hitachienergy.com; dmarc=pass action=none
 header.from=hitachienergy.com; dkim=pass header.d=hitachienergy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hitachienergy.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+EI9yYcnKYPH0p+dFEqZ8NB4AmHfZ0b9hvgDBOgSyVE=;
 b=ncHuIFLVMgRkCTEB+RW3HAMS07+h5Cd9chd/KEzv1ApQY6V3+sjHPUXVaFUHREFTQd7Qp8Q3JtDhP2gie73vPN8gUMFWT+/KMEr1XyePqcpj8lK2oyqZvawSll9b3BmAO6eY/uVBGCW3cgsrXyLkCDv2wA8ENe13GI+jchCJMk6/ouJDNWmoqv3ZmjIgJRrUlfI983BTE0x3GC6zrg63D1JbM4wQ77ZLWtnhRaZcPlBgDyKDtnh5Op+G+75o3Iq7aMr9aNXsJxMTcQ+bh51POZStbZtUL2krhmlb6TvMdwSViSjbW6h7E6O09+Y1fOdBNcjJJ9vqq3Z4MSSqmHUCkw==
Received: from DB9PR06MB7849.eurprd06.prod.outlook.com (2603:10a6:10:291::22)
 by DB8PR06MB6442.eurprd06.prod.outlook.com (2603:10a6:10:126::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Mon, 27 Apr
 2026 15:00:30 +0000
Received: from DB9PR06MB7849.eurprd06.prod.outlook.com
 ([fe80::f0f5:da:c159:65ab]) by DB9PR06MB7849.eurprd06.prod.outlook.com
 ([fe80::f0f5:da:c159:65ab%7]) with mapi id 15.20.9846.025; Mon, 27 Apr 2026
 15:00:30 +0000
From: Tomas Alvarez Vanoli <tomas.alvarez-vanoli@hitachienergy.com>
To: Michael Walle <mwalle@kernel.org>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: "trini@konsulko.com" <trini@konsulko.com>, "chuanhua.han@nxp.com"
 <chuanhua.han@nxp.com>
Subject: Re: [PATCH 0/1] spi: fsl_espi: fix din offset
Thread-Topic: [PATCH 0/1] spi: fsl_espi: fix din offset
Thread-Index: AQHcu7ACMCR13v4txEGC5uikEn95zLXzDK8AgAAo/ss=
Date: Mon, 27 Apr 2026 15:00:29 +0000
Message-ID: <DB9PR06MB7849FF9D7AFDD1CD3C3304B7C2362@DB9PR06MB7849.eurprd06.prod.outlook.com>
References: <20260324170212.481394-1-tomas.alvarez-vanoli@hitachienergy.com>
 <DI3XUWVXNGP3.2TI0N0LDP7ZJ4@kernel.org>
In-Reply-To: <DI3XUWVXNGP3.2TI0N0LDP7ZJ4@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hitachienergy.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR06MB7849:EE_|DB8PR06MB6442:EE_
x-ms-office365-filtering-correlation-id: 5062e538-bf6a-4e53-33c2-08dea46db947
x-he-o365-outbound: HEO365Out
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|56012099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: s3NgHU8RGeY2yZ5MLfj5rsnvdmB8dzyHe6TM7nNX+m9NRTXByDae+WGWV0yq2xJH+cUFHsPnhuVJneCq1GuSCbfs/MhRvtOHe7NHBaP4JxJ6NvIUJIXklrMGcv1Cx6EeygRTSv1YIL+53/MkPNilHvLMOuFoV8W0QuAcuBaHMuX0y4jwBwRw7CGOWSweXc0Ut/GVrwu9+QYl6oZ2LtIp4HCZ+c1mimSkqmXRNzSEsKgX+TQYmZRJFYQL27tWNsRP0IU/03XpfgyXnwMAZI6mifYiGo11ajrWW9Yv8Nmvlqv2t8OkgROpMSEQbnDAyM3YMLz21s+NPzCZh2CG3Jt3CU6TzMhECBydpY80O+KCUEMrPXXwwaZtpQA67NvAYy2eOQ3zAwElY/oica2Tkf/amvB1UGNkUo6XqLFx6+DXCEAyk1IL9jcfo8G1u1K6ljOtxt/qvQF6MFQ6inKHi4vF/NF8hArSStyjIYQM6uP61qVSqqB3X3MpJ6+BUWJUa9P70OBzeOKSkosNqh3gBsmcKMW6V5RiS3Uq818ByZMBXnAVNIuBWvaldj4wOwRpEK5zFIklYr2tj4UTZiVgI+bhi+dbWU0fQawNRZPyAme1Acv0t0PJhB3IJLYuhTc2ZxNZBJjSkdJZ44wydGk+/Ayth66j1IAqNyNbbrY305MoatIvQ6VpR2GAbeN685QrM8RUYnJyJbVgyW0joyCeGg3WZXF4QN6kTyzabbQ2cZC5fk1uMZlL8zewHGUBdQoEntyDhBi8wL96Gsu+pXAUkuCsIKw5l8QlSYRuNZZaH645Fvw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR06MB7849.eurprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?4qyh7mweQH4wzI2p76z+bvPHr81DN2Dt/mxBk3dPw4aNiFISFbWssPNYcF?=
 =?iso-8859-1?Q?WnEE3FER2bFumJZaFKE5cTwRUrSMlWIVkJX3VIaFd7XOIHWjvcteuEvBwE?=
 =?iso-8859-1?Q?8kRgfI+HUxleiON4vJQT5mL+mJq+smLExspG1i2yeaA9k3uGova6UfXvwx?=
 =?iso-8859-1?Q?adNuX4qKZwRxzYqt0HZ4SNqPfpuZa9SbhgTzYYiOQA2mDao8HfHiXxy+Em?=
 =?iso-8859-1?Q?6Yto82vsausv9VJwbRQu9yIeoqiZkds1HGTLTIJUJAiAYO5Ma2HImpUABP?=
 =?iso-8859-1?Q?sMg9ghLWhgEw/NnbUwhEWCHvu909hIe7EBpL/jTOvIdBEqUSip4i7hy0pG?=
 =?iso-8859-1?Q?KWz0ydJbe/SDOunde5yg2UPI7P1zYRK4Uaw25HzUUiX+INMeE28ZxWDyDg?=
 =?iso-8859-1?Q?l9VPWZgFpM0d4buZvtAP+q728VI6b3oz00WMD9Yd/b0vhFIhIdBatfdygo?=
 =?iso-8859-1?Q?tMSxndmaxo27V5eAmNEpHuQevb3W1LapRXEV0EXycbZ5zWQDMFamaHZYRN?=
 =?iso-8859-1?Q?6NaCksgFpm5SphjYtiHSCQUCeLSpKCwj0kKuPW51NczL4tJm9QtMNZlyV9?=
 =?iso-8859-1?Q?S9ba37lD6QF2mQsNadNrJJq6Dr7kD39GYW5RrXp1A7aFUxGSRjF2d+P220?=
 =?iso-8859-1?Q?v+E58a5xHDGA6YHbH50gYVf/W4K4DV0M+w6FM/xQDTtI8Q4qpQVrkv56VW?=
 =?iso-8859-1?Q?JGiDMRrM9ClmmWmUoariD0bQHtNP0ZwcltXHgdJXo7ipicqZBACVJ9slod?=
 =?iso-8859-1?Q?ThjZyL+BTOAddTmFopLvcwgjcmVL+OUzmS7KPg+5aS9LAEiuj4SnWAeSQm?=
 =?iso-8859-1?Q?qT2kWF1iy2qCJWxdhDoVEDnnWnxXxG/L3g6xtIkDjMcZyhDX9V4TcwK+m5?=
 =?iso-8859-1?Q?jpDANiAVn+9CTjdEbn8cBf4ktmtmBPzb02h7j0f5wF6uM+GMERFRy4G4ma?=
 =?iso-8859-1?Q?EdfOTIZ63OGcuWv1t5MFB7LoXpKLkA5jNVKbQJ4dIDl91BICG3juyczvt/?=
 =?iso-8859-1?Q?F+tKaVN8IIrGQH1rqfQTg4IvPWK/ebPLZqR7dB4w8AsdsYxBlPETO1L18t?=
 =?iso-8859-1?Q?VooQBvk7X7PVm30EL6Imv5o+XagguHFhFL1AhGes/8NFWlEeuZZD/v9zUY?=
 =?iso-8859-1?Q?zLqVtQzCtoP1MH4nnJwgMFqzCJLcltZtPt/GW3s895PtR+hh/k6NDGZ08b?=
 =?iso-8859-1?Q?U7s435+ha1nZHP95u7fXRTMJGCKh7d6J1AI9jc5MQhpNO3NAFhwivzCn86?=
 =?iso-8859-1?Q?uI3DqGajHY73n/fVbusmN24r0ExdTKOm9jcZAk5Mwru3unHo5HiVoOPs+z?=
 =?iso-8859-1?Q?4k5gF6E2LDb6QC7uZGg4IOKC3wELmiWr2EcwsYDSl2/bDLuD0VuxQrBt5E?=
 =?iso-8859-1?Q?b8BBQElsSiYKRlHwn1lAyZ9uaw6QWGnRTMXpSR+EIGWXNX/2YwCIfPUgtg?=
 =?iso-8859-1?Q?nmOb0B2vIPt6lnrCBmWTe31m/jtHBn0j5xnKBim6G9BMlMjs1kjztw23tt?=
 =?iso-8859-1?Q?YcF5MRqYx/OxKHtyHunKFNNTa/8+d/ltC6EHwh90Vra54dXt6zw/UQJ+VK?=
 =?iso-8859-1?Q?Q6s+9HVBZPbiENc109N04tcbLe1leIXdbmTgsR4+c3y/n9Pum17Mv5Gauh?=
 =?iso-8859-1?Q?Y7Ig/8klyKVFq9kS6KDYeGgLq4+QNLFATPT9KDP/NbTUHyF/eWj1cRJ+u8?=
 =?iso-8859-1?Q?TljVv7A3w2y3+1yKdsWIJkr5uVVaF3c0I9wnL9Jw4DNpOrGelyU2DuLgTR?=
 =?iso-8859-1?Q?QhObXpwW0tJCzFDtMx5HmRj5lXvw1UOa3gVylzeO7zf2A+Oe0f6gV34oZi?=
 =?iso-8859-1?Q?K2hoz7VtX+0j+QJ+IM0YMSfr0AG7afqTaLt1r3qq/lyYr6QrNuQv?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: hitachienergy.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR06MB7849.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5062e538-bf6a-4e53-33c2-08dea46db947
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2026 15:00:29.9467 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7831e6d9-dc6c-4cd1-9ec6-1dc2b4133195
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZdZG6B2MPI/7vncUVSQck3KbtgBS7aV+2Bzn90kcTs9qVbCIuo+wcFH52JnVwFL4Nwf2YiOEQRMx1aiQqO/JJptZyiPcTMuGmbBkPgDKyT4qBR0JY5j9U3PfGyNl+XWH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR06MB6442
X-Mailman-Approved-At: Mon, 27 Apr 2026 18:01:11 +0200
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

Hi=0A=
=0A=
>What kind of issues do you see? And how does your patch resolves=0A=
>this? I guess we can assume the code was working correctly once.=0A=
=0A=
The problem was that when calling spi_xfer like so:=0A=
=0A=
`spi_xfer(spi_slv, bitlen, &dout, &din, SPI_XFER_ONCE);`=0A=
=0A=
To read a read only part of chip with known values, I was getting garbage.=
=0A=
=0A=
Digging deeper into the driver and adding print statements I was able to=0A=
determine that:=0A=
=0A=
- fsl_espi_rx was getting the expected data and putting it in the correct=
=0A=
address (local din)=0A=
=0A=
- The memcpy later in the code was taking data from a different address=0A=
(buffer + 2 * cmd_len) and putting it in the user pointer (the &din from my=
=0A=
call)=0A=
=0A=
>Honestly, I don't understand that code either. ...=0A=
=0A=
The switch at the start of the function determines the buffer and offset se=
tup.=0A=
To be fair I only focused on my issue, SPI_XFER_ONCE which is the same as=
=0A=
SPI_XFER_BEGIN | SPI_XFER_END, and in a small transaction.=0A=
=0A=
Inside the ONCE case, the driver allocates a buffer of double the transacti=
on,=0A=
because it puts the tx data in the first half, and then will write the rx d=
ata=0A=
in the second half.=0A=
=0A=
The case of only "SPI_XFER_END" is a bit more "cryptic" to put it nicely, a=
nd I=0A=
did not properly debug it if I am being honest.=0A=
=0A=
However, for my case of the ONCE transfer, if you look at the start of the =
while=0A=
loop:=0A=
=0A=
```=0A=
	while (num_chunks--) {=0A=
		if (data_in)=0A=
			din =3D buffer + rx_offset;=0A=
```=0A=
=0A=
This means that if the user passed a pointer to get the read data back, the=
n=0A=
we set a local "din" to the buffer we allocated at the start plus rx_offset=
.=0A=
In the "ONCE" case, this is the second half of the buffer. In the END case,=
 this=0A=
"cmd_len".=0A=
=0A=
This din pointer is what is passed to "fsl_espi_rx", where I had corroborat=
ed=0A=
that the chip data read was the expected.=0A=
=0A=
When we get to later in the while loop, there's this:=0A=
=0A=
```=0A=
		if (data_in) {=0A=
			memcpy(data_in, buffer + 2 * cmd_len, tran_len);=0A=
			if (*buffer =3D=3D 0x0b) {=0A=
				data_in +=3D tran_len;=0A=
				data_len -=3D tran_len;=0A=
				*(int *)buffer +=3D tran_len;=0A=
			}=0A=
		}=0A=
```=0A=
=0A=
where I made my change, in the memcpy source pointer. This is the code in c=
harge=0A=
of copying the data back to the caller/user.=0A=
=0A=
As you can see, for the ONCE case, cmd_len is 0, so it is taking the data a=
t the=0A=
start of buffer (my tx data, not the rx data). Hopefully the bug I was=0A=
experiencing is clearer with this explanation.=0A=
=0A=
As I mentally traced this code I realized of a better fix, hopefully you ca=
n=0A=
review this and/or test in on your board too.=0A=
=0A=
Given that for the ONCE transfer cmd_len is 0, what could be changed is als=
o:=0A=
=0A=
diff --git a/drivers/spi/fsl_espi.c b/drivers/spi/fsl_espi.c=0A=
index b1586d12912..ef2ebd5840b 100644=0A=
--- a/drivers/spi/fsl_espi.c=0A=
+++ b/drivers/spi/fsl_espi.c=0A=
@@ -287,13 +287,13 @@ int spi_xfer(struct spi_slave *slave, unsigned int bi=
tlen, const void *data_out,=0A=
                break;=0A=
        case SPI_XFER_BEGIN | SPI_XFER_END:=0A=
                len =3D data_len;=0A=
-               buffer =3D (unsigned char *)malloc(len * 2);=0A=
+               buffer =3D (unsigned char *)malloc(len);=0A=
                if (!buffer) {=0A=
                        debug("SF: Failed to malloc memory.\n");=0A=
                        return 1;=0A=
                }=0A=
                memcpy(buffer, data_out, len);=0A=
-               rx_offset =3D len;=0A=
+               rx_offset =3D 0;=0A=
                cmd_len =3D 0;=0A=
                break;=0A=
        }=0A=
=0A=
This theoretically should work and should also not affect the "END" case.=
=0A=
=0A=
The two things that support this are that:=0A=
=0A=
- The loop always writes out first, so the rx data can safely overwrite the=
 tx=0A=
- cmd_len is set to 0 for the ONCE case, so data_in memcpy would take the r=
x=0A=
data from the right rx_offset (0)=0A=
=0A=
Hopefully this explanation and my proposed alternative fix are helpful, I'm=
 glad=0A=
someone else was able to test this, I had cc'ed someone from nxp hoping the=
y=0A=
could shine some light on the code but their email does not exist anymore.=
=0A=
=0A=
It would be good to know what flags the flash probe is passing to the drive=
r,=0A=
to know if the problem actualyl arises from the switch statement at the sta=
rt=0A=
or handling multiple chunks/blks. I can say for certain that for a single=
=0A=
chunk and signle block, the ONCE transfer was not working correctly for me.=
=0A=
=0A=
Best Regards,=0A=
Tomas=
