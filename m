Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6619CCF9F8
	for <u-boot@archiver.kernel.org>; Thu, 30 Oct 2025 07:56:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F7A78391C;
	Thu, 30 Oct 2025 08:56:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="dRCmzIBy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 941D88392C; Thu, 30 Oct 2025 08:56:03 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D4C8838D7
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 08:56:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1761810961; x=1762415761; i=xypron.glpk@gmx.de;
 bh=+52cvid2YSk5jiiH/mbW+76TrAH3jQDBeUVY8+pqal8=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=dRCmzIByK7dRTibwdnSvT102IbmFBVoRqiEikmUQTEfSGuYbKW1ghcD6tXiiumU2
 6JsRJueHr6GLQkg8Dz60EII7UY8Hx7axe/bDJlElRQgUTIh6bYP1HUWnbTc9LmLgj
 i+uK7vDjCKesGLihCr0CBZqPV3FzLcMgThcSPGZnsMVtprrkeE+berZc2y2mbkXz1
 I9289LcvJzy9v+ptqFRPUxnTC4ly8S/zxTvlCZUe3fNEfwAtNPSJi3FY8skLqyvLf
 B6G7iJ2n8Vpr5D18L1oierA/goIP/GocGAZ//viEbJjlOSGCGkU6icAfnpf7SbaO+
 I1TdKS5RV0OIAcpvMQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.25.161.182] ([93.94.208.154]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MgNct-1vuZ9b3V9D-00gZ2Z; Thu, 30
 Oct 2025 08:56:00 +0100
Message-ID: <c15d7ead-883d-4c34-93b9-d70310d85bb1@gmx.de>
Date: Thu, 30 Oct 2025 08:55:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/3] ram: starfive: fix typo for unsupported DDR size
To: E Shattow <e@freeshell.de>
Cc: u-boot@lists.denx.de, Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, Leo Liang <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>
References: <20251030062354.35413-1-e@freeshell.de>
 <20251030062354.35413-4-e@freeshell.de>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20251030062354.35413-4-e@freeshell.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dm/O/R9GKjnJWMaqWj0K0xDWMpzfT5YKUX+QRf0B6B+Yv6lKkFv
 xjh7dCth4ADUUiSlP+m56GNqeoPDgyRhoC8xWnjfwXTIOxAYfzbonFFAMS4Kdq0pUAjLh5z
 0cTuFoIw/ehQ+0R4tedeqHqseKX6uZGDGLSDtPNUu5ybn2LjYW6oWmlZkMXyY6+8Cqr1aHo
 LM5JcmJ/7MwmV5/PVeKow==
UI-OutboundReport: notjunk:1;M01:P0:35rH56PUERY=;u6cOlN5PNGGyvzAc2zUnmvSFC4H
 7ZSas9CN/7U6ZIL69kL3Y6VF7xWCDY0UCzQREbvMKuHOslw9D9dyvF/C9Xv6DZGnoDOUYJ6TB
 Kq4zJqsH0KV1benPsYVxzyrniTBGM5l8sSdMOuPwGJjXzZrmdyZAfpveauxE7gGYXZ+9w9v+J
 upSNPAd1m9bKqrg0LUHqr9kPyKuUm/vVAiXDvTsI9bv9Cbmvy+vFRVny9QIQBwbbzr37/XukB
 faC89RdzA+vk/n91A7BTMnGdxJZK2tW4Xqtu/jaGPVEHrxKGEMmBuO2qBWaywj+SH/cLP1m79
 wmMOlxBi6QmvJAf9BYe2eQDg/RplfE1lFlTGFdGkuBq7Kt7AiXhziMxzR5KOLOV0WO5LA0wYt
 cGLDEd4cuWauv+3PauuwYWEUX+Xp3jeS3jVdMkE9HXq4a8Y3DXDYyfFKWkwykSQFySRsBEWz6
 HLDXBr3MLsqHaBjuoIm/+g/7FtK9ZODtz9d8E/6sH7w6Bium/5U9/zVPTycYZ2W7xQYuCiQVa
 LXNF5vMYHXwVhRFZ7xVvge01oyI3TSH9O7XsSJcPM5vpu2U/PhN0yr6oigjckMGLS3zChU5r5
 qQGY8NvNuFdyXw/lLZhsigV4txIo9LjMV7tPoAVQnX+JHIU4Jg39b0IuOOb2+4REs8HXW2/iu
 M8OSkrNbF8xKSaIyLUGZgDuR1sSmCQunVTcCxpNbzIxfZaCRn9dQY4sDVFUkgNKhkKex1nnh6
 GPu/DSOSCtpk2wPj0uJJ036MegXWPwpH/QnxJvzxpiF+58wFwITS2XhhQrRBu/PeI84ajkHpW
 gF7Qp8A49C8H/JWFhMawINzDTiZgUBjWFmPVJgemGg27CsTL7jFKycVAm3KtT6Z2yhUcMgBtk
 p5Xr8aHI0aoaOvIVhU7lyXSAQzQw/QcEMH608I0MUW7uSY7sNJMfVgdkgZqBcJuHutKX5+Fi0
 A6Cguu0Gg8jFElynvIA5X0YBvRmfR7Z9AHhNy8yDQBMxJB4Ej6Jx1d0rojLwh/3ZIUwhpFRQI
 M17ndoL88QEGRnwVWBw88wIIZeSD0Io8C2/JztSdyxNxWzZzIFLxLAm/Qq7ZM9BoWeNUTNzMY
 4XCccbzBeJvnzfyPrnAh7ZXcZYY+2NZSoXK/PARNAzaenzk2ZHOukEfBVu2V2a7Xm3sGwV+jT
 BphTR7xb+VKx6JBb1PYfQi9svtcQi7raDYceaVDe0BW5UiuNh3m6dJwTdMMUB5+IgQbQb55Yq
 N5jNp0GOWyKLu7JPFHmyTcWrruhLlKFqghmx2S4FQ+0FXCrmVFobKI8etqUkOyX/l6SciLW1J
 mBQNAHCuSbh7j50X8cjSRFFwxpCPGc75EFGJeIsIR92illr9tiiXKILxHcpk8QE8iTwW1HHwV
 x0WWWMMNZoIUrR6L3TpaAVJIi3WNEOrdiuRJutER/QeR5wceIIuRISsVwUT4iOerg6xaLdraL
 le2CsfTag27RmwWvaBFDXHRhmYJxVfQu19aykU7vJKl9XcVofTi5/LUY4/AANwtyzXRH5WMJy
 V1v+qQdahT9Dt/qre2OZbeUXD0m+oJjmKnA4hmJLkMEq+KGN2/Q61zkKp4yuyjnEREcCuU/Eu
 kyki1t55AxzI6OyzQF0xA6jK1+qFMtnrFE+eWzeKxVvdxKlj+q27NVCorWm9huFi4WR+84ROk
 UKjTIGgDf30rgpKhjP/O+33UBSXJqGfRM6F0ZYwlADprj3Inmu7p+pCnIO306aQXVZPjBFb0q
 +bfwaWUSrtlU7tOwfGE70eMkYg28LfBmi+lXmc844/emO+JDFJVpYLY74YKdUywIGXm6+0QoE
 jPJ1r/dDrbilTK3ydTLW3IKFRJBCvqbCW5B94jlTxgSDehyIeIm8E9PfcCdKFPbcevbroYYrL
 +BwCO4XDBnwGv019kEyKfwN5wxCd3WQv1hyNVhtBbRWKc7JYEfLRluvhIfMA7DbSHJnm/7NsI
 3Ra3eI3XDhvtpbDtu6YN8h7hmZyq8GWxn40yQtEZfhqHvvzxgFVrC79CEGXmzqKyPSiG5OdtW
 Y3njvELLjN4NaapC3f+mUAehrPLE9+/xCPsa4jzp0mzB79OzoYTrRGeuF65KOKmoHNTHjqjuE
 FpdtBOJDKY8Fi4mgjJp7xZsu/0WFNnBHvS1CGbeBu9ZKqP3n3zxz9gin4aFdXe+cj5EyUjMyi
 0+p1Yu+u55Gw5bIPlTj3vrg+3cU+Ivquiu09L55Y/oEV+K/i/vooyc/HdQ3o9Ri0LwWnk0bdu
 4NpI/9BdMt0wOpSVnyq5ivZB32pEDhobp1Alart0/f3M907cIXGnay+MTN56qaLfzAt+76l8Y
 hctZQnSfXoM2oByEZY6WK6VZiry8e1P2AXckL7qziTvcnUKlwj/6ruThaO2YmWOZZ/8Tp/O2m
 GU+pXA55N8s0fivQTrhQelMOKZlv7kzC20xWgUHmj4s0/sRjqkmQgd6NmI2mvziglxL4Nmld4
 /T9rF9skDoOz3ufWr2hkh6cQo9dkzRr1erfq33LlkLRl7GIZEK+bnpHJFpwQZsZnTYE2kNYZ1
 QYkwILfRma8tOIwLC4BxdCyUxKF4EOIWXh2MZuzX4G1FgqnYouhmuWOBfmON/fYxwy3HGWSF0
 c3pYcJVVwIy1Da84psn3uiE4SirtPqBXmWsg2rz7vTCiq9K+Kkk+gshwMF2+dWP2KXcDiUYiB
 6nyvlP95wRHQOBnM2CTZLgqyT8XLjdoLgR2BPuEXIcmYUHvLQDQVtu3qJDucDSXOVslS0zS7c
 CWc7p1XlqqMeBh67+FtQ3tkeTvd44+tinfrilWkeyMIPK/FOnfaUK9CyYg7b//sMB3sj4RRJe
 Ikv8Ii/vflfDk1sUHeJdFYGRUAooWWYHoMuOa/uenuyJ12K1soFT45WxycQbQCf+y6TjI5DDz
 aAPeg+l1WVEFrOtB320kjbfkaO171zrpM+AM/FfGO4r7xYpWwmbFObCHWXe5kHTMXbAVOKgbH
 9MkiqNdkN6+aToGTTnWwAjf+5G+kc71gYamiH4OTJ8TWG4cklfl+MPwce9OoPqF7fx81H9MzZ
 jwbpt5q/lrFo4ZE9OY+X8V7Y4BHLId5AINNswa3WIMpy58nFDWP6O6SRzqsjDnfsiYUubqKqW
 C2DWB3exxnsW0LXh+Gb8PZIfsM/Hi27u2KzSsx+BNLzSpwEcEZO9yeba3Xn+/J39DYhdk6tPo
 tVY9JuHTf4ky5IbH5odfEXi1p2Vpip7yd7aPnLO9xfTYEk2qOX+X9Nv9UftgkVTcySQoPJu+8
 PdqVdUvRMCqQc/VTOlOv/u5HCrW5qMY7dJJH9PlCaTNcoYCdB6hzeFjfo+QTNYxGEZYs+8rx+
 nGUk4fhZz00xfCxT+BzizkNRE2rUx+beP3SKE7jCVl38M2omZ5/Vy7lmtEaNFj/vUN/Qe6El/
 r3x0mzLjc5ZjEm1USJzMO4i9+kG//NdnD9rgOP9ds2TyKI73s9dgF/fq6nxAc6dKJhSRC5VwU
 4IUrbVl/DacqrGZGXMVbWt+l0D+PntMAri0Hoy4cKrJszZ3S7GJkBqKBZwaIjsAXMRoc25wN9
 fOtZXvYtbgmTD/GCIZgkj6HdV17VwNhCAy6DFrGroun0rGl0opDUd7onn2qzH4Bwbudd7RGD9
 m0f9LqZdoIznJ4m6u8ITDtmeg1Wm/+SoxcvIMMU3dM6McoVo+le4eBc7/Yeney+tP7U5dqDfM
 czaS+Mg/PRnM0tr4FX9d3EgH8pfH0JvUQciAx5c6aTcAMcyqPwlyea9ZCb/SoFYxcu5EwKv1G
 akXPHaBbB/DcJ8KmmlXsZaNHs5zR+Prg0C/U1sti83q1+MkK2o7aBcsUut+WG2AWyBH16vh4Q
 MpER7WnWVYhjB4p6BwUuJCUF1iKOeLJcFh5kRNTWSyorIZrWnFRf4cFk3C+FAJx1BhVh0qEzS
 mr/CpICd0U0vqbmqI/Ams2HVC/e/iPGcO+EJCB9zC0VOqxF6/YIfMX5YSwTLIvLITmnnjkQfy
 Iwuq4/cghRIxcTeC0LnAJlolsQXSdS9Bl8mv7WHQjhJywg9gTeJxy0NbWCb6CdJByO6X9my9E
 Bk2S6EpeOSHtUhVEpYojS3LSpMtRnbXxqba69wGrCMSIBMM9UWiWVYyd0cbZ4T1aAzNOjJImL
 NwE3hkg/YnC30LtLCBVKhrL54Kk538C35RcofkovcLmatowuqFn4OjOPA7LUj2KNMdHndxqBQ
 0dxMBEdporKebgVxW5hv1oaXbvouwlmTOAsa00s7lSotsK/8d7PUf0TiPyt5ztjTiJQgHdSR9
 m7+8a1CbNdjAwukp5Ldw1XFTHanzxH8UM6TpQBAgNMboOL+BzpRsrVrYrOYtuMOlmKD4AXD4c
 riIA1QR8YrbJWA6gy67b/CjGlylM1dSWOSOm3nrIllmXtmqERhZ++/BCoIxv90F4Hmp3fEpSS
 AVzdQNLVJu1wshYn1PO6ZKpeCg/ImBhAVWj1vdXBdvhzmMBzx5GJLQkjDxkcavQ4y+OST0ltI
 CIkTq2q2OyuJRf8iOSy6j7BXBjIVcpnTN+j3FTgs0pTMKb9a0afU4DGMKc6gXBaxngHpAFRF2
 OheuKG+1lkkQlkCrH7ucrLfOWtIZAcZec8rRzcasdBTE7xr1XRnPCg9r+mMtqEvJxMIiqqsx6
 GJM+9P/wU5g7zpDE1VKYtBpgfn4HbFfEuskPKoPOGEaDgWc9u0nqf+fpWJkcAXUzWX+SDKoQn
 ZbUs/k6lhtiVqmVUfW5U762AC/alJReLSc3oq6ukGoQAdxa/VvY4R0vfdKuwUKd5AWcDXx5mO
 0/6F3+PApheYYbEsieobngKNuCRPhDIhDnsreOIZtrWYc8Pdu1AmSdzu9jO3NQ5Y3Bbs5vLau
 49Me0bV+y/T/2075LsVqaGpqqCcm9bNvRBbs9spNTu6y/hClnaG2zJcbUsKr8KLrPnA/SduVJ
 3EOaZedntCLQSjGlHd/RJOL/2z2tL48VVeAkW4YpUttmUBkOpMNAsi7P5S/TjKwNSFXzM6NAY
 DcM31+KmH8g7cEq7fx/pKKp2ugRvzuxKWzJNy9uu/NGfRfK63fOPUrt77SolWOcuFECTlfn47
 p5g+glDncuwR1fucF/RiHy+aWBfa+A/p2KA9TVL9vFRARgNA3yUMA2A6srRlZOiC5ZFZTFdQM
 ajBW6pa5swN4CYo3Q=
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

On 10/30/25 07:23, E Shattow wrote:
> Fix typo for "unsupport" size and improve description to Unknown DDR siz=
e.
>=20
> Signed-off-by: E Shattow <e@freeshell.de>

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> ---
>   drivers/ram/starfive/starfive_ddr.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/ram/starfive/starfive_ddr.c b/drivers/ram/starfive/=
starfive_ddr.c
> index f030192f6f4..e151179398f 100644
> --- a/drivers/ram/starfive/starfive_ddr.c
> +++ b/drivers/ram/starfive/starfive_ddr.c
> @@ -48,7 +48,7 @@ static int starfive_ddr_setup(struct udevice *dev, str=
uct starfive_ddr_priv *pri
>   		break;
>  =20
>   	default:
> -		pr_err("unsupport size %lx\n", priv->info.size);
> +		pr_err("Unknown DDR size %lx\n", priv->info.size);
>   		return -EINVAL;
>   	}
>  =20

