Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2C43CD98F0
	for <u-boot@archiver.kernel.org>; Sun, 21 Jun 2026 08:39:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 625A4849BA;
	Sun, 21 Jun 2026 10:39:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="q8SzNxSC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58520849BB; Sun, 21 Jun 2026 10:39:54 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 105938499C
 for <u-boot@lists.denx.de>; Sun, 21 Jun 2026 10:39:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1782031189; x=1782635989; i=xypron.glpk@gmx.de;
 bh=m5z432yl+SQCzB7Pwy+dpG+18zYiRTQfk5k3k5pKOYo=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=q8SzNxSCV//v4R+sY1Kqu6QGP6j/EI4++PpX/cLB8GJSkWZhrUUNfSNlimVXAX9t
 JAJK+G0qyfeX/7H2ojn1dXCQqzJXiAhj2jzUMQbwy2lFzSn669dJlWT61iXU4LcTQ
 6ZF1ib3jWuVX5ow0wwAJXw5eACYNjwoycwEG0Wk1GA+Ekxp8uHoRNFXzz2LS53ory
 zPpBGOa6pGtE+SPUcIDywl1Y/PF2fdGmcv8o5pba7GLfqITTtvmyBVJXaNGkB170G
 mInq+39yOPnS1vuIwNtORum11JOcgMqZD7TLbdUtI1xCiMqCo0b/gNbMNQjnbAUzn
 yyvZpGFKkV5gMh+lQQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MBm1U-1wTV1d0OJo-001rOa; Sun, 21
 Jun 2026 10:39:49 +0200
Message-ID: <39fc6fd8-cd7e-4cbd-8957-67b3215e5129@gmx.de>
Date: Sun, 21 Jun 2026 10:39:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] lib/efi_loader: fix block io revision
To: =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20260609-rev-v1-0-0ccae5bf0fc5@arm.com>
 <20260609-rev-v1-1-0ccae5bf0fc5@arm.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20260609-rev-v1-1-0ccae5bf0fc5@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:x3RircYZSCeo8KL/VgRi87OFFaa52Nq4YOUvfO2dhH6NK0pXWrg
 jOPdrE8/VEQG/wZQROueEW0IJGPzDYXZxTZgNGOpTK7147mA4LCpXdLAoDnImUJIw/CdOCq
 8h8NyO1nRZG1bV2pHwZ3lQnAIz2/RbPSIYQQjz1OEtqVHUFf9gIci8RkOA6cmsKpfRCyQyG
 sPHBAiyPNiRzwSXCPtXwA==
UI-OutboundReport: notjunk:1;M01:P0:TV3LdG8xHLY=;oxVzC6HNMGv0OYopjOYJePIZBRX
 jJN22G9N+vxDnHTzqPF1LexmYeKRH7X+uSUiDtGwMvAaSuoJudJZsoGUChCuNwfbooi/2CqpH
 rnPLuNz5nxuhTz+BwLRzFrpbHT+SI38XY9kvEN07PPhkRtBlgvRw0ufH85v2UBxfiqRn5FNLY
 WRxh/FDAou8YGGmfCrdgkrjUFIq+Fn5IyjpW/zwoDrLJMkNIL3dMeJEuvOW+htdBnJ1F7j+ja
 ipUZvZK7eOnO4jjuPM7Eb0VNjmA8HFTPIhucIlWIJ3pq1LG1jPMJJF4rtXsQjiAFyu0W0KrOR
 s+lnQ9kWwoEmdASRz0rHHXYWB2s1am8LblDm1ztAjPzyI1iNaIPER14HIMqwAbjn/wLAzrBSo
 dO0eDuVdOKZ6wO4E490+Y8CA/Uhpcg8Qt+gFvIbyt+/Ls0jOdxqNoR4TZtrc1K6oXnTtw5vEu
 FkMD0L7zcYIK/0Z8nNbtGi1rhdmoD7zXYAKkkBxWL51Nwtz2WdFpV3yl17kWjCVEruWJrCNuS
 EusTzfPnu/27aL5Y9QvpWXpP/7yxl/61x565khvYqfmidw9tkFnEqe1cqEbRdCVTJdHFMDugF
 G8hBh0AsUq6TqT+44fUXtvhx+B0v1tUnIbOs2lzHEmqymXgZjoQ/SEjuQLn/II7KpE/Xn8LwT
 ojd5FwRla8FeZKumCtp/1dQGCbuoqsEsyd5q/Jyo71Z3bkqmFzUaqB5qvuIAM/H0zZuRpAb5V
 gxP2Fj2KavdwIRkFkuvSltCclHnXvxPy1qSRvLHdH2RJn9chBWDrvLgAQDAj3H3h+2pXJIPR5
 /8gsImsTWQP1+jfGKfgyHDBiVdzIPthQqfUWl1dcd3AzE2V3NqqXWxc7pDvysMZgFpEpMrSIJ
 tFbCA8muAT42z1I3TZ6MJ4M8GUUfTElu1xfFBaotJDl3UBtuEjosAfiQaQKQlKFQD0BZMjkkS
 Kwbn4UQyOItvC5mA26XH/Dg0b5bC0qFlWDe//5fH98NCnElNsGAMPEPirOJG7Pt8IRaXtY2le
 dzK80sqMfGCiyIY27y0tF8+E/djuojiHe/ReeSb4LC88n8A/txj0Wv/fCHLIMqw4ChimJxpcu
 mzggJJx+8qNS2e4rBvNHw9IfbH2AAOAntHBsJKAwyH+Fgmpp3sTm2LQsRO0fLTTNtkVEy4Vip
 Qn5oSqfZQH6RgU7VD3R10UhQcjwK3DG4fA1h7dXYvUgFslZwAt14ZsBxVWcF5QUSA6IlpUSeR
 YcrzdtaEyNnb1I90gTL64d285GEssP2oRnw3jvxDDfVasdqlU2LmvOtEXaV9PYCqbTQgfzBJt
 4fBpk/MBMNBEyh7BhSIxqJIq/us/rTEIH5Ru+AhvidF5e9Et7jsSElNaJZsH+jsPvDHZO9DvQ
 j9nnTgYdwOhLPI2SUkG18lZEENhx/NiTZxW8ghz23+/DIl8tzeazI6w4+t7dFP4WP5VH6B2sv
 yOJr2rkopRCjowhWmlJMhey3fW9mYXDtuF49d0woQxUQc3PS3A0veAQeulEwoBmrhVLy+W9UE
 Pabr0ErbP6GROxUXlfvnJmIjhR1Ur4ePIbMHW8w+nscezHvNNVmkrZZ4A8WVBTO572CSpb3vv
 vRaLApU/2ueKScA+MJNusVg3+1ZRMQj4NaLRb//IpoujFQ+f0GE7p4EHh+/OZVldIZ3PtnI7J
 +FBSkTdhkxGeIYXZEDN8twPLQbLz9wmf9opTc+HamE23nl4PAcac4xHdW6d1O0klS5M29Ccfd
 sX+bGQz8hbHzl7mhlEGcDUdlEQTg5HiNESmzmsVb6zGSFOG4V16U7SvGdbx5B3IXp2YSuXpD4
 nPXrmVyVA77lOPG5kHDhjueYuFsQPzJKH7M13iFYOaRzD29q0DC1ue50OchLXTXsDSMT+qHr7
 9EqDT36aoPu60lOtA9rqLui5U04yHbf97aBlyOiZO9mfj/U+EtyX9t2clPpJUT6kOYCdbxMxJ
 pq+fn0+OXed5SrlKiGEKUGcEwJA3TAFAtY4od429DjfKFAfIU1VSDVuakE0XkSMABzdJtp3Gu
 EQGTr4s8aAd7m4+kYUX0Ytmo2Jsd7kG8wp3IOVdKJO6SehDErsHzezX5z1ngLcdZJ8mf9tOCj
 9B2A45K3drgPz7GHzwN78DJVPg42HyZqwfFMB9D1E/EeHtm41/jPd//Zb2TMok6tRcxglmRjV
 CD2TWkOefPSr+v6WUz4xHnFvZmSrGmcyv/QpWrA1ZGYBDm+U8jwOvYKiCYmVM3GEMHzxr/H36
 FaBC4Rlme2PqWD4aD/m6X/NrUkbklRFYN4Sj9zi0WqgI/MBfquVF3Uegt3zO4IhwlP4vdgBG6
 ApQXZ162ah7IvLCaJhdOvHqL6KVdiivh4+qOY7aXdPAsiS/EIdhMBDD2p1G+Q/Evlq+AaYnb+
 NPvJOwY3AAfL7Gk4npJbkdeC7yek4NqXmUXDu/odlgUegpV+tYyWcVT5cEHdrYb3QM6xT1gN1
 GxXQPb+9DRcoL4h+gaTJX9JtnDgrrwXlPEllUd7Zu1XHlrjGbn/2EFeWQ0/ebBcwAbtW2SFPt
 7Cm8zjSIRV2WIhjUfR3LP1VxCUbHKzPZMX+4ehzAOqapQ4deXiiQpOBW8I8oyd0AtMkbMYPHR
 jVQCgGi5RpWO9X2BeMMUEo6zDpgInEDAqCStb6YJgNB7KFzOjz8iLN5EM4g++4AtZjp/5slcj
 bui9JPFdG64erLij4Zs5uHqxK8CQccBJMnd3ayPNnMFK4TygES2/UtXNphkXTRl3h1Cs9WteL
 CtSi4oXC0EZDJ2Df0KUI+XifNudS9ZT67avnElm5y2Nl4nkmhyrdLrgbptkPNGDz/1bwASbBE
 iVfMoDJlqaUg5yP0ZVLb2PH4noJFewBpk621F++USh9VusrOtd2IVxpkd1bwDZHRxm0ufuEYF
 mXZZZ5CNgsHCMpPD1XLIwU3xfINJLjdHbhZatX7zMxLxkb7boviwWRghnLfpuVeZYzJrLyTCi
 tKsAedjQtW+4lHvoX8Twnz9BQumKtbHhKnanR6saUyCJ716qogmLCFbAkkKWkTH6zk2zqFl5H
 1IJKrIMc0EqT3ENBRH1uA+WAAnRWSdmp712dQm9we0ZiNhNbUhix50Wual1ZraWACthx9VUPH
 lJICriYQTzDLYpbFBBs8CPPE2lXBPURjU3lMyQM3muGGYLVLyPLTSdFYwbTZXG/lMMc2/yddi
 VXtuvLCTcoPdoc183jOkmTQpBSIY3vBc8+ZJdTkcSLzECuCQmJu9ybK+Cn26YqvJ/7Jeaj8L1
 iLYmvLc1B6fpVq8tOkF2WwKjs96vcdXUKU6pbM+AvM+ovfsuB0dOXFDd+MXHNs6f5BngL7Hvt
 /sRueg8nx60Ds2QkBNe0Xm+G+Gpiq2SXzcQoe8Jd3utKOfj22rHm137trvIQdz7Af2Ds1NiwZ
 Rwb4hdO5XmamMKsdFkPRuOTWFvScF9BruQLosee2l4Q5VXkk+EUxN8rB1Giw+KhmF9GzBUitb
 2Gzi04vj5eAo6qd1KKzmM0Sn5Mkegic1IN8dsNBZ22jM8s4kk0dyeJtJwTmv8kjBZVPr42jdR
 Mrzwnj1HV5GjgKZyH79E5w+3E6acOPDou0rf4uXgu9MhzRVuPne6eErBCI9kmxtpf4CbfclWW
 pg3GlJ8jTNlKEF60fBuJlZwe/1/rbYq3DaNscpkJXDYAQrfh1a9WJtb+mswCEBXuB9WQGi+uL
 DyNsNJBgcxroukzyHM8ksF37480l3wMGTpJoFHcb9En8SofRTbWVbJSsVlj/eTCjsiI4a7Wxp
 AkGwE4PmO+i9wqPeP74AEHaay03AgPenFAyE7NQKT6r041FarwYNa4hzeoC0NcAnhftqaRd3N
 rs946OpR5SD6caQ/yALvdt8NNpi50U0NivimaLCSZgzDwczmCi9P39MXcUyQxTMWx6aNxmEP8
 BUn5/grZFSXmhDBdqny5EGiPjeB00VjJBTVly3ItK0PSQ2skb2trsPgmK7E1VD5uHMRxLusF8
 KGTAPD11FHkHwZX5Hv+nlbWLYmnxd6MQhI47AnWmYSd6iz3MquOKDXgozWkpoHMRLU7Ic7Fsf
 5HcpqJRLqRulEqvuO0DdaXImgO3tT0XLHqqaT1Hf4DCApg34YF+/qpV0KKLRV9MQGAmlQCQFV
 aikobNPsBiifwr2+aIgQCZXdmFVfeb5NdhuuNm2IpZ74iPzMx5hFSNzsihCBVKfhiupYrmn/K
 k8hm41rpXKOkwWC5mbb5mmrmSflC5EewxKATxHFnDHa58ef4L9ebJSP5MFi+6bpPC6e2YPhiD
 60DSmaz/UHkfdKiOa31t0jqspx6IsfQyl5AI1jUEBGs+Gps75mcpoWDJEQqnpgPpTNIiLiEkO
 wwQBiq80CnBWglkz9/YckAciA3cTr4VVgEWnSr5VdLmMIjZg/zJQox24aQwLE1w7uY5ST3yWm
 Enp857HF8nmNRMtp8cXOFXqBenlKog7hxHzLR0c3K6AsXhPBHurLpmQ4+xg6YCIlxr46aOnx7
 xQeFFqzq6Bz6mE2FcZ7/mS7hS/6krAgWe5ok2lcXYjbtJPnpjlDSaYwhxKVAGw5h/x1CzgZ5v
 Uf3x4atjrdoyRM3rq6CxDjqvYRjFsTb6DAYggORX2NZaK9353gsccGkP2zIhKfxgwNw9ZCy//
 DbenZixzUt7W0DpOSu16yyq4QV/cxwBNzlj1H7MLtd9tZ60zVDwVUQBabtY/YbDivIqXZt+fW
 T5AdYMj9wbmaQnPkyfO1tbp6QY452pqfylk4R5iKuls0ZwNQXEsE1062YHrlOekdQMSPI9Pe8
 AaCAiXeZJgSsxQV9I8UgOlSTos09SklfAhtjanp1VqjmEOb/miuhJn9vNvFxIONYG21d072bw
 43PX8wHy+G0TvXdXzowzpl3lJ0HL06VxUlW000SJdZQjXBFdbLx09ELITWQsur8xTDe7qeO12
 zWU52ok4K/z75HQUYczUZ+/+HzgyCrJYyDSP13KurYunKAk8GBxu9uXuS0mlgPZHZ9zQxyybD
 2qfFLrvH17m85Mv9/qVQlpoaqWzIIdhyI/w0CrvMosuVrFL5DIzxMZ1UQS6G7FXP/j1Nhhtf3
 vdZnbV5eOskKiNuOY9pxTkrOt29DFF3pQva2A+k4KP9ciNbgpi/dCIfdMe1RF60rSXoJOtXeM
 peHy7oMm3KBNIAK5+KFRm0FsujVqWdTbLn/qrflPdSGw3w6pt0/f8S/GQPj/9tljNmf9gPzbY
 5fGqZpXmeYeb+XYrfYjkr59R9ymRr+um9v/k2gM+JlZZYg7d5e0CmEQMwc1gpK+VHVDy9ud8Y
 JH3MfADni7DdT4bEfWsDn8Q1trdruUV/+xGhmCbSRpmtavp1YjQwgwaGd+KUoFhrl8Xs6pB3+
 F7IqVeDVgitm646kp1RGS/DMGcjryKk3r+wcZopfIOMstDD9qIZ6ZwhogXpTFXMTTje7n+oWL
 K0iNCVoKZq2V0AiFvYE4+jh7Nnk4n6dCJvycZokRGtv/1ffpTGXfYL/iaurNBz2h0/feiaC18
 LCAnrSoNHXAItengK/HyNXuEzf5lsDxTLlgGnYczMjyhx7n/aqWuEBGkgmgiG1mn5ULmZkHw6
 L7INbzQBDT0u9DMf23MJnsxGAe+YszYGDyM9otmBBUE/bdZRoGDzdVvDwKWEz1VhWOLmghQP2
 ikRZ6wjq7inCU7YNts=
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

On 6/9/26 10:07, Vincent Stehl=C3=A9 wrote:
> The Revision field of the EFI_BLOCK_IO_PROTOCOL structure must be set to
> one of the two valid values [1], but this is not initialized in the
> efi_loader; fix it.
>=20
> Link: https://uefi.org/specs/UEFI/2.11/13_Protocols_Media_Access.html#ef=
i-block-io-protocol [1]
> Signed-off-by: Vincent Stehl=C3=A9 <vincent.stehle@arm.com>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Tom Rini <trini@konsulko.com>

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> ---
>   lib/efi_loader/efi_disk.c | 1 +
>   1 file changed, 1 insertion(+)
>=20
> diff --git a/lib/efi_loader/efi_disk.c b/lib/efi_loader/efi_disk.c
> index f8a57539ec6..4a3ace3a304 100644
> --- a/lib/efi_loader/efi_disk.c
> +++ b/lib/efi_loader/efi_disk.c
> @@ -305,6 +305,7 @@ static efi_status_t EFIAPI efi_disk_flush_blocks(str=
uct efi_block_io *this)
>   }
>  =20
>   static const struct efi_block_io block_io_disk_template =3D {
> +	.revision =3D EFI_BLOCK_IO_PROTOCOL_REVISION3,
>   	.reset =3D &efi_disk_reset,
>   	.read_blocks =3D &efi_disk_read_blocks,
>   	.write_blocks =3D &efi_disk_write_blocks,
>=20

