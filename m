Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADDC4C83F01
	for <u-boot@archiver.kernel.org>; Wed, 30 Aug 2023 05:10:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A14186514;
	Wed, 30 Aug 2023 07:10:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="sj6ciBIM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C301386520; Wed, 30 Aug 2023 07:10:24 +0200 (CEST)
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4473C864D8
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 07:10:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chanho61.park@samsung.com
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20230830051014epoutp0442857b233f793a0ec47a06ec8241bde5~AEQ6avfkm0558505585epoutp04K
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 05:10:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20230830051014epoutp0442857b233f793a0ec47a06ec8241bde5~AEQ6avfkm0558505585epoutp04K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1693372214;
 bh=Ih1kl3MCjWbbUOtvFA+0r3u7VDSlJ4az7ndQP8DzRls=;
 h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
 b=sj6ciBIMHSzbTezlg994Qx6/YUG0t+rq02DKSRVUcfBJCJIdtdOMQ36tJDs+MfwHp
 TiqG8Y06TFY6QouDP+KspbUfSFGtFL014YsgKA/46gEse3+08qEiJCmk8PIP3vdfbV
 ufP5truZCYAZ1bZabIKRPeGNE8KIhgaGEUqIcGp4=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
 epcas2p1.samsung.com (KnoxPortal) with ESMTP id
 20230830051014epcas2p129ed526453ae92e29cb74805dd9d2ea4~AEQ6LOAId2442524425epcas2p1i;
 Wed, 30 Aug 2023 05:10:14 +0000 (GMT)
Received: from epsmgec2p1-new.samsung.com (unknown [182.195.36.88]) by
 epsnrtp3.localdomain (Postfix) with ESMTP id 4RbC6F2Jp3z4x9QG; Wed, 30 Aug
 2023 05:10:13 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
 epsmgec2p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
 ED.E7.19471.53FCEE46; Wed, 30 Aug 2023 14:10:13 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
 20230830051012epcas2p156d74c394920c2069e106d9761d4e9dc~AEQ5Co0762914029140epcas2p1n;
 Wed, 30 Aug 2023 05:10:12 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20230830051012epsmtrp29799ce99dadf99c7b4eee4a60af3977b~AEQ5CGo3U2959229592epsmtrp2j;
 Wed, 30 Aug 2023 05:10:12 +0000 (GMT)
X-AuditID: b6c32a4d-b07ff70000004c0f-26-64eecf350095
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 7F.72.08742.43FCEE46; Wed, 30 Aug 2023 14:10:12 +0900 (KST)
Received: from KORCO082417 (unknown [75.12.40.192]) by epsmtip1.samsung.com
 (KnoxPortal) with ESMTPA id
 20230830051012epsmtip1b180e904114ddd0c2fce1250d22526e4~AEQ454DRa1129111291epsmtip1S;
 Wed, 30 Aug 2023 05:10:12 +0000 (GMT)
From: "Chanho Park" <chanho61.park@samsung.com>
To: "'Simon Glass'" <sjg@chromium.org>
Cc: "'Nikhil M Jain'" <n-jain1@ti.com>, "'Marek Vasut'" <marex@denx.de>,
 <u-boot@lists.denx.de>
In-Reply-To: <CAPnjgZ0XSpoCRp20aOUQ7mwaCnkQGS3ois7kfkkMV064=QWtOA@mail.gmail.com>
Subject: RE: [PATCH v2] spl: bootstage: move bootstage_stash before jumping
 to image
Date: Wed, 30 Aug 2023 14:10:12 +0900
Message-ID: <000001d9db00$416373e0$c42a5ba0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIfhblCRPPtyAFT/Lcd3zaiCuujOwKFp7+vAfIfaMevUzJScA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplk+LIzCtJLcpLzFFi42LZdljTQtf0/LsUg62/OSzetDUyWvT/f85k
 8W3LNkaLt3s72R1YPGY3XGTxmDfrBIvH2Ts7GD2O39jOFMASlW2TkZqYklqkkJqXnJ+SmZdu
 q+QdHO8cb2pmYKhraGlhrqSQl5ibaqvk4hOg65aZA7RTSaEsMacUKBSQWFyspG9nU5RfWpKq
 kJFfXGKrlFqQklNgXqBXnJhbXJqXrpeXWmJlaGBgZApUmJCdsbUtvOCRYMWh4/NZGhhX8XUx
 cnJICJhIbPxwhxHEFhLYwyhx414qhP2JUWLe9souRi4g+xujxJ3De5lhGtq2TGWDSOxllFjx
 +TMThPOCUeLMhI1gVWwC+hIvO7axgtgiAmoSbxecYAexmQUSJU73zgSzOQUCJb42zGUBsYUF
 wiRm/bgPZrMIqEp8a58PdhKvgKXE+8lLoGxBiZMzn7BAzNGWWLbwNdRFChI/ny6D2uUkMWHW
 SiaIGhGJ2Z1tzCDHSQg0ckgcmfGcFaLBRaJh6xmoZmGJV8e3sEPYUhKf3+0Feo0DyC6X2LEs
 CaK3hVGiuW0PVL29xI+bU1hBapgFNCXW79KHKFeWOHIL6jQ+iY7Df9khwrwSHW1CEI3qEge2
 T2eBsGUluud8Zp3AqDQLyWOzkDw2C8kDsxB2LWBkWcUolVpQnJuemmxUYKibl1oOj+3k/NxN
 jOD0qOW7g/H1+r96hxiZOBgPMUpwMCuJ8MaavUsR4k1JrKxKLcqPLyrNSS0+xGgKDO6JzFKi
 yfnABJ1XEm9oYmlgYmZmaG5kamCuJM57r3VuipBAemJJanZqakFqEUwfEwenVAOTJvf0X0/K
 g87nphtzrc9prxPwi9txccOFlR5VH0761u3rEDR2b4uXk1y+91PhZrO0lZpeh+q+Fpl90FjH
 IfI7s+i5a/36kJBfxt2116xKJq43mX5jWfWsHJ6ZllrHP4aJsRgw2+uYBSumOgkUFGXGPPyy
 qrSdW2rWuU/XJOP9T9RX5E02Xy37XFVh/t7Y0Hr3Mxb6jtLTDjmIxkiJ1hdPVrwkfr0yYMq5
 d+fuGvSX3zDqMAhSnFr5ZVLc/afCvEus+I+0X3QwC5O59Pxrm+pk3ZsG5SektTZn8a0OWKKm
 oG60f4uTcmb6Gru9p1R0HQ9ejrt852L9waprq6dW+HmJFbOYXt2rzMJvcuTwTiWW4oxEQy3m
 ouJEAArzBcQYBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgkeLIzCtJLcpLzFFi42LZdlhJTtfk/LsUg1c9BhZv2hoZLfr/P2ey
 +LZlG6PF272d7A4sHrMbLrJ4zJt1gsXj7J0djB7Hb2xnCmCJ4rJJSc3JLEst0rdL4Mo403uJ
 ueCeYMX2h7MZGxhn8XUxcnJICJhItG2ZygZiCwnsZpQ4+8sTIi4r8ezdDnYIW1jifssR1i5G
 LqCaZ4wSMx8cZQRJsAnoS7zs2MYKYosIqEm8XXACrIFZIFniy8PzUA3XGSX2LOwAS3AKBEp8
 bZjLAmILC4RIzPgyC8xmEVCV+NY+H2wor4ClxPvJS6BsQYmTM5+wQAzVlnh68ymcvWzha2aI
 6xQkfj5dxgpz9Z+jc9kgDnKSmDBrJRNEvYjE7M42Zphv7j54yT6BUXQWkhWzkKyYhWTFLCTt
 CxhZVjFKphYU56bnFhsWGOallusVJ+YWl+al6yXn525iBEeWluYOxu2rPugdYmTiYDzEKMHB
 rCTCG2v2LkWINyWxsiq1KD++qDQntfgQozQHi5I4r/iL3hQhgfTEktTs1NSC1CKYLBMHp1QD
 E6dxx0/fetcT5RP9nEvWnX3VxLxd8DrLcmN1l5w18r9yj6dVbtGU6UjNeTDN5ZuXjcWhacpF
 t67HbhMxbve97KX4TbXUN5P/7LwtWy6zRxY6G82xi93AKtfHcShBWe/KnkMbT16ttX2lluy9
 9Pibm5Nz8+SSZzlw3fL/ZPHVssB5ihrr7ZQFvuwhfLUvqh5elVi64snOM803Hq/Ii82J+tat
 YPCTM0N0z/8uwcVP1hoc0HJWuXhr2eykTz6/7kk9ynQJO/ssofFsz9WH7Sx6Js4cfUyzPILL
 1i1tqp/opa1/is01e0Hz3vqoULFD98vWr+Y//Wp7WdjBhYdbtSNdU0rPzjdcHLhRqTRdeudR
 JZbijERDLeai4kQAx8zJMBsDAAA=
X-CMS-MailID: 20230830051012epcas2p156d74c394920c2069e106d9761d4e9dc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230829042831epcas2p4a8a4cd85cdfe73e8dac914b274d5c351
References: <CGME20230829042831epcas2p4a8a4cd85cdfe73e8dac914b274d5c351@epcas2p4.samsung.com>
 <20230829042803.2606011-1-chanho61.park@samsung.com>
 <CAPnjgZ0XSpoCRp20aOUQ7mwaCnkQGS3ois7kfkkMV064=QWtOA@mail.gmail.com>
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

Hi Simon,

> -----Original Message-----
> From: Simon Glass <sjg=40chromium.org>
> Sent: Wednesday, August 30, 2023 1:38 AM
> To: Chanho Park <chanho61.park=40samsung.com>
> Cc: Nikhil M Jain <n-jain1=40ti.com>; Marek Vasut <marex=40denx.de>; u-
> boot=40lists.denx.de
> Subject: Re: =5BPATCH v2=5D spl: bootstage: move bootstage_stash before
> jumping to image
>=20
> Hi Chanho,
>=20
> On Mon, 28 Aug 2023 at 22:28, Chanho Park <chanho61.park=40samsung.com>
> wrote:
> >
> > Regarding IH_OS_OPENSBI, IH_OS_LINUX and IH_OS_TEE, there is no chance
> > to stash bootstage record because they do not return to SPL after
> > jumping to the image.
> > Hence, this patch separates the final stage bootstage code into
> > spl_bootstage_finish and call the function before jumping to the image.
> >
> > Signed-off-by: Chanho Park <chanho61.park=40samsung.com>
> > ---
> > Changes from v1
> > - Separate the final stage bootstage code into spl_bootstage_finish.
> > - As Simon suggests, call the function before jumping to the image.
>=20
> I think you misunderstood me here. I mean, you cannot jump off somewhere
> in your board code. You must change it so it returns correctly, and the
> jump happens from spl.c's board_init_r() function.
> The way it works is you set up the spl_image structure, then it SPL jumps
> to it at the end of the functions.

I feel like I'm still not clear on what you mean. Sorry.

switch (spl_image.os) =7B
	case IH_OS_U_BOOT:
	case IH_OS_ARM_TRUSTED_FIRMWARE:
	case IH_OS_TEE:
	case IH_OS_OPENSBI:
	case IH_OS_LINUX:
=7D

Regarding ATF/TEE/OPENSBI and Linux, they need different number of argument=
s and formats to jump to the image, respectively.
I think that's why they can't go to the final stage and can't use jump_to_i=
mage_no_args.

Do you want to move jump codes at the end of the board_init_r function?
The easiest way is that we just move the whole switch statements to the fin=
al stage of the function.
Otherwise, the arguments can be prepared from switch statement and make jum=
p_to_image function to support variable length of arguments.
(Or we can put switch statement there to support various jump of the image)

Can you elaborate a bit more?

Best Regards,
Chanho Park

