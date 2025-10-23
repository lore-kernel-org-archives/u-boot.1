Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B67DCCCD1BC
	for <u-boot@archiver.kernel.org>; Thu, 23 Oct 2025 07:34:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27BCC8323A;
	Thu, 23 Oct 2025 09:34:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="kT8Cwj5F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 550F28323A; Thu, 23 Oct 2025 09:34:29 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0922F82E34
 for <u-boot@lists.denx.de>; Thu, 23 Oct 2025 09:34:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1761204857; x=1761809657; i=xypron.glpk@gmx.de;
 bh=7kOHD6LRLe/5xosg/yyDAWZbI54x3HdndgI3402s9M8=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=kT8Cwj5FP6Pa068oDBJu6lA/eQiwohpMPvXGaDZnd+ongKjYIhI+d2tscGU14Kw0
 zwGNTRRqcXGpBSymvASPLjx2Iol9E5ZdrQi6vm/8l1+wBB+TOducfSNWNv27UPthB
 wH/61/1phCozVk7JjaUIdosoH1tDj01Q9gRC98auHr9+fcjzmTOQTPEVPQ7MSB2cB
 leQS47QvycLMtz3zLVdglyddKr0utaKhrxk1+3W0UQDH/jRFDGjq7/Oq/CyaUrCCx
 vX8gKXyb0fzrH544a37TnuJzfhNQF0raGBV/Aez+Bt7MR8zZyHnBWq5Ca3XyKsduT
 vTBOg812/1hne41HXQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.104.3.212] ([109.144.144.191]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MzhnH-1uG8qG0DyL-00rPgv; Thu, 23
 Oct 2025 09:34:17 +0200
Message-ID: <f16df8c1-f58f-48f1-8e9a-8fe6e4fceb84@gmx.de>
Date: Thu, 23 Oct 2025 08:34:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc: pytest: Complete dependencies list with missing
 packages
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: u-boot@lists.denx.de, Bajjuri Praneeth <praneeth@ti.com>,
 thomas.petazzoni@bootlin.com, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Jerome Forissier <jerome.forissier@linaro.org>
References: <20251022132055.816662-1-kory.maincent@bootlin.com>
 <87bjlzarlt.fsf@kernel.org> <20251022180451.1e91cee4@kmaincent-XPS-13-7390>
 <875xc6axmw.fsf@kernel.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <875xc6axmw.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WIC15NhU09aXNWSGMijyyw99rqLokF6Fd2yx8POBoMMpZbW6ZRt
 PdNpaEhjauLVwYmTDLb7wKcn48kz9GtklWBt+Pf0KZKahf0IXAL+pU5tsxos0yTL6b9PKP0
 OLJLDgg9+jaWd62k6dkd+0Uxy1l8yQeREJ3QVMP1P2bdKfxEFwsd7fziQ1/1CLHb2870Qey
 pFqedimdRCWUPMIWswcPA==
UI-OutboundReport: notjunk:1;M01:P0:C/uFXyJ9LsI=;og2jYZuZK1rJ1lMuLfQgAX+Q0J7
 lXFkn2eKSvYW7VzJnH0RNK0ueYoGndySHOFsFL84kQrCB439ORZ8wL++nQOU85vcmlXYv3qBr
 R0XQ2Hb+zFyfnm4S3bqyp2pRwqMiblZZ7dRyTL2tIIcEbFL1FjPDyp66MiMXUxV+HgyE05l+T
 xHbybxPFkJkUW2tOCTvntBPTlaLxzYJk26rEgWlj1AqATtNVV0PZheRNIo4YCw+JBeqYdgdLN
 mdBZzI9wHXDE5QL3AbAJvi8KgVSZOmY406hC07h1aoNnpMTdA1Kf81oAlyTDMtvo0Tdwxzmra
 Sn88Ilonctf6gFSoKMmHsvfwVM5liq4Pi8/WxPAJVYYvb67pm9StpOhpm3icRYDvbPOQ5Wzv7
 mz+tyynnMgDs7FZSx3CmyJXQz4/ifMBClx+jJibdp3UesBZeN3jTO+74SyaRCHfgRV6jWeYqa
 MB5ZfdZfrhxLxs2glPQ8y+SFMTeAaw+R7TnaVWYyD43UqM2EY2BSzBbqz4OMzB/ocLZT8S0Ul
 ruJwP/l3DcwX2yqxtb3/z9/n8yBPTT35zmqA8uFmSQRyBLR91Xu+w7W9qZimRhyIsE2wDneh0
 30CI31XHBFQmWAI4uq1Jf4TDPDiK//PINUUWiLWXbVpfzfb1yloAmrEdZMOcUnIrfSYyKJ5tL
 PHmsi1sywXXU7xZHUHaTiW2sYpJ/kn4rf+Z2S35dU0kHQ6TRykJyT+z2K4f1cF4mIIrEPwxKY
 CgvPy2I93XrHkjR4p0m1CgyHqv4aBWOqK/5sIYOEmEpHU23Lfa5sOtX5wJo4wvQxQ1RvpHP+b
 Dm7396hK8qy4iTELK93s2ebjGzkT7+6DGYWk3f3mYdS5iVxcd9zkfn3kBqxKUen5kucHKu1tZ
 t04HLPF4JW/8kvmxMg0NBFqfzNqLigfoMf2EYr4tGKy3520h6fR0TS7klyuEojBY+G1q/Z3I9
 4VV0RqhwvEOkfkwsCSCqgWZEUfVAL2Jpp6tmx3v1WCEZjSwobwjmgMV3L8ixkcU7iCHJfvSr+
 EnBE5gMe4EGFWqBJnciFgJl5mh29siYnOb89wdllJXsKwLdjcAMU/zrk1P0KcNfxv0reOouQw
 wSv3rLESfSgVY8aIgfRuUxysaSyU7HjPLyrrS/HM8rXKyWtt4G9lp1eyKx8Io9cHWYv/c1+pC
 jGA99p+Fc5TEaxbJcTzr8HYFJrBSOkgrEL5a86isocQF2uvcfAAGeJdSkj6H0CKPKGhQohRm3
 Y8MZ22Ifa2z0tcJXriawf2jUq2ajDHi46lc9f84GUPf3yST1UOhYyxlvxSFCIOEt2DXmxnQX8
 uH6JSV1CiIcC2eGoVHGvCabwLBTdKie2M7yByYb7JpxvsxWHZKKlo1TW/6GcmQTQHBSOzEgA4
 fZI35nuZ7uBG2hf9o4v4u2JCmUHd2Vrh9sHeiTJLzMiktdDrBSGuhkkV+VGJmG8T9Pq7skIck
 gU8lz5h/MMKfForGlAnwLfi7pqQcPFxhqKUN1EDvTtmKXC2WtM3Y6XPPkA21QpKkUO98rhoi8
 mVZbwgcm7wkhb1WGT+1ODq9xexCiufLl4QtVO5HEZz3jtZmvIs0J2+d5+ctpVbKPa77kfkusC
 WAcr1IR8h32Q/Z/qv8HWR8aGu56MldFp4QEs5zO3ki3z5aHxqIeGgaDRrMG0MlE32MW14hWTK
 r3UZqNuf0Ym6kgM2XViA+WAPyPssqYEpXztZ3tmjVqxITlAl+cGBV7F54kyvI0qSOy6srEj3V
 2LUTE4w010PVtD7UC0r/NltP9AjkG7eWeUfjTn98kkbb/OB0JlMNDQFcGHOHJidEtALpZDGi+
 HyV0SB/5sUCqhsE72tY2FXP9f/0gq+6gmqnxSEhIQ7aPPS4+t6SZfyur2Vj05+DmXtHOeHNL6
 JZu2R9FHkjjqIqMVyjTlRIgxp7F8P5yz+ur877Yit3S+EWIBaoHCY8jfPivl7u5oBtZ+T32A/
 s/Bq35++79Sm3vHhRrPeeVeqJV822JVlmfIJyLYf69XCWrvflPy9Xdd9H3nLdAATd82quW4N2
 q5D1QDmTF8nZisZ2AKIfcWEw6NKEGwjqT2bdKE0Hp12ZLhoD95LGtKiax24xdL//eVffRVHns
 mfz8pMmKifzKXPl+eTVPNmui89SlKTntU3a0TIE8tggpAzQjCM0m1Q63LeTOIQcyTOAoKfdym
 9RwusmKPGAfQbjRwsVoo8M6Lcq/K8WuKFAP6zwaRNKHOFlmqoPKkaqK1Dj4KnlwB2z7KHMtUA
 87f3sjp2voto0vtsBpfkrEJZt8uPj+DY9Tx3YmHiJx7ent9FmwJ1nxXX8RNKI+RHF9o6EcA/6
 27eNNwjE0Kp1u4DEWFMe9U1O8DLcdYjUiNkj1xZNiQX6BIFhAt069xljj++HLeToWI3tl1NvL
 Xc6ZmmZaLFHSVWly3Y0vyKdySJCBk2/gR0ncgIOFQk6yAOhf1eIxs5O9gL+OsKP9PTaX/2q34
 MAGPJNK+qHMqzXyXOBA/wWO97M2nv1jaboGdQ+Ur/Hp9FOEA0DVxBv/P9+7E0joMVOZIUZrqi
 oYSvEL2yTkKamoAijZSmSP2Uk4uEmF95raISY1/znGNhyWrosubkwMoTW3uEXSoZ2pTjU3YaG
 m/77lr3njmrBrvgmamvfKOCy1xGQwOKbEMHz42PSzyM8ESJDiYz6oROSb5dM18Z1rRJa7QNnB
 04kHDUdsvg972FYOFOXOslJILARw4Vv5FZ37x62CJmG8loxeOuiD4GQz5t3gxY+DfZE7hdxTz
 jrfI3E4iUyehjkp6rTEA9NQ5piELAIkDvjxhGovuxEomo4n9UNdFtyqLHJTszwIti5k5Rj6i0
 QtepAtJkpA69hUZGKw4wj++Dk99OXQDBaFXpG1DzYQKolhGuQQiUrsXJaxhxGD2q9xkH3l8fE
 hhoa+G11zmRpJhe8uT2RoAXHyklSk2a8cbFaTHABTsF4INp6Qm6NpAjseJYRUvthhseACfOFS
 zMEfBfykgFt8Wf4gBYDjxqnRKUh7AdG9DnQ749IE+sjOuyquWlLh+pkEG79ikjbrwG5bQS0rE
 9nPwSE8qF/noRGyo80upvXipX+th4xzvAvG8G5XAciigAPTx8JTVkmj+69NUhCE3T2eK+cVtz
 QXzkyJ1scrD7xakndF7/fDXohW0CIM2N0dCzOxYKIMQ/umX7LKE9Dp3aZkQMb92ZABjj19xa0
 f9DZYuuu5n5ZWkVptmfrahay6Nm9wWH9useLJRj9tyC1rbnAHok4AO4TjI38Sx4P1G5K5u1uJ
 xWhVipT3LFRhyZqhT2RFwLvL31W4btW1XnJiAORec3+jdQ0BR4YBTMhasVMl+erVOml0x/81p
 kT2LNL5pfBvnYXhdlbKQv3HN+v6pBVi1jekANIXx2FPFJtPhjOZbnygwVVFREPNlsK+edrpPH
 SQZ3xF2Hbll/+Of+FADOYlHY7C2IVZC8vcvqa0nw5d+hKEYZ4vaT4nbGPkEkYqfOUbiZmiEEU
 ThuvIn+f2km+UMLpe1IJdLmgw5uqZ1GLLY0nG5gnHEeOEHU7bzNl/f6q/Zr6XeK8ZZB6d8k3n
 RxVf7cVMUPoOD0O3bqwlOTFTs78CcCQieLv15H7E2L6Ys8ihW+5hoyygFJ36aNKWNq+GhsUBJ
 p4tlpIpVf3J0VHnsUlw27MEtK80fCUBSboaerxO1bQ7ver0yBMVukvjUz81rhEBsOzFDrD+IF
 YY1UDJduYInU76THa+0ARhqU/FtRKjBtpbiXlw2vL9Vj3d1L6d65zwhSQpM8cdHF91GtsEM/G
 UrDQh1nM/WjDoUfRVoPtM7/onkw7Hx2bnCEu7ohJa80LSAIHZqPqf4RXQKubr6QUHgqVbQoKv
 bf1th78zCNu0cfWUJRi/bWWiy5mNaL2DsQa0IPUt0atjREeQ4HKPcYX+1clWP0xmeJWQvCpBK
 MMof71XhjVzWiIVIkbUfJXGTEluUrEctcm/eRnyWszNmMtgX/0oigxXMBsNnjKdtD4jrwJOEG
 XjLjwm4EdhhtGgTIX82kv9RJeullQ2AVqB0BAjzwNBz5BvV1ftq0/deRZWwbn0/mjzC/KGUuA
 FIAyxLlTvbG/zti4bmTMdVLeBfuqN6bBrCIqYj8Db/FIedeTgF5TXdhSjFLbIs8dgEjHGXFyU
 hW9fStRgNlT8afAg6/WD8uImW2AdFNPUmCEc/fW83PvxGnncG6tFkrZMHonhfv8oa975rWDMA
 i0Va/LFqgqlchwaJvuZmFPf0YsbbjIkR1qLKlzZUTCB334HeXeVNq1dO+ueLWo0+SFmGBXzM2
 ZcGUqzXRcIlU2GwQmII1iloQg7iSPIzvw1g/Ua0O+8Bv6iREbi10WYERTFllsgdkaHtuhlvqQ
 zrrOhTBwaS3z65vTUmtzhoFkSBQBGfMjjrEnH0PmcYfF8jlAivGMmxhOFm3+4XK1YRBBZzkHF
 Uj5QAPM3DSczRXv9suRFDcVCOLht3WcPxsN3TT4YliJMMXKd2F7lZDvgqzSgDJgmRbIX4sXqc
 oJw7r/CvaEX+SSvsK9c39E7VMaTWpVdRNJv1Yf9cC8UA970QSWdNK0O5GHkE1j9o7zBqtFLbd
 ove00KLTj6df45iMw1aYfFUgYH7EAmBfzsDSrqGVwJz0l+lxdBtHkmIltQMFLZ/Y4UWnxAMQE
 hdfSOaXThCNz2WRBMn3vXfBipz1R9mnvXS9K7Zah58UB7DlqeB/AI+yLI0Ptm49jLwWHUgb7C
 PUhlwwFUYw5jbkK/1qXWJ2/aVT3PzBx5KWDAVHX80mGlqhQJ3vHBQLrZXaPGVf6BLcs2+Kcx0
 NxOEnK9v8GRCskBbXfbp8h8scon0Aj8pAemM0/kDhlFHYtpEGblS1UsPXK+i/Lm93dND4gYlj
 op4qU4FW8uDNQJcNjVSNEowxqcrc0x8a+PXbzuIqfNwp3JNOPlIAX7pXbOJxYqkyzL8RtQzrk
 jLBJf0JtC75LJNeJ5PGaDe1HvsoogRB11XB9BAakQpAV2Kd4zBz+ZcJO0C1DPs/x3fKoXESA6
 pPEgZyNIqByZ/AyDxAqam3oXb6+HG7ewP2D4NIfHJG/ex3FNvUn1VyinqHrM8XxhZXE5BYvt0
 WAWhsPndBmo9R7pWMS3h7Zvqo7kLSABqT+xtwW0vu7uXh/z
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

On 10/23/25 08:24, Mattijs Korpershoek wrote:
> On Wed, Oct 22, 2025 at 18:04, Kory Maincent <kory.maincent@bootlin.com>=
 wrote:
>=20
>> On Wed, 22 Oct 2025 17:22:38 +0200
>> Mattijs Korpershoek <mkorpershoek@kernel.org> wrote:
>>
>>> Hi Kory,
>>>
>>> Thank you for the patch.
>>>
>>> On Wed, Oct 22, 2025 at 15:20, Kory Maincent <kory.maincent@bootlin.co=
m>
>>> wrote:
>>>
>>>> From: "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>
>>>>
>>>> Add missing dependencies to the pytest usage documentation and correc=
t
>>>> the device tree compiler package name from 'dtc' to 'device-tree-comp=
iler'.
>>>>
>>>> This ensures users have the complete list of dependencies needed to r=
un
>>>> the pytest test suite without errors.
>>>>
>>>> Signed-off-by: Kory Maincent (TI.com) <kory.maincent@bootlin.com>
>>>> ---
>>>>   doc/develop/pytest/usage.rst | 7 ++++++-
>>>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/doc/develop/pytest/usage.rst b/doc/develop/pytest/usage.=
rst
>>>> index 779b2dbe24b..454877837ca 100644
>>>> --- a/doc/develop/pytest/usage.rst
>>>> +++ b/doc/develop/pytest/usage.rst
>>>> @@ -39,7 +39,7 @@ will be required. The following is an incomplete li=
st:
>>>
>>> If the list is now complete (as per your commit message), should we
>>> update this sentence as well to remove "incomplete" ?
>>
>> Indeed I think we can. Do you want a v2 with this update?
>=20
> I think Heinrich will be the one picking this up so I'll let him chime
> in.
>=20
> If you do make a v2, please add:
>=20
> Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

Hello Kory,

Thank you for reworking this page. Yes, if the sentence is now=20
superfluous, please, send a v2 of the patch and CC me.

Best regards

Heinrich

>=20
>>
>> Regards,
>> --=20
>> K=C3=B6ry Maincent, Bootlin
>> Embedded Linux and kernel engineering
>> https://bootlin.com

