Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3BCECA5FD4
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 14:39:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DF23640DAF;
	Fri,  2 Oct 2026 14:39:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id S8n5am2pQSmE; Fri,  2 Oct 2026 14:39:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org A4EA740D97
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790951966;
	b=eIGNT/4MzXukbM2tsKjMf9Wi5Zuq1wlrkPqdZhBophKHAv4iLLm6iEFXWvPFrSMCveI2
	 WQXQ64JhYUkUbFKSvT03zZWqTCjsngHMKLnqSMVRexPCEzRJ/6k9MkLbegaidtQ9qTsr4
	 jDbO7er+zO+35EPaxWbViBplG0Yp3EBDiFu+MV0P8YxG+XSy8XghKfZ9HxR5qka5b/dAM
	 nMVVY8/+9j6oHwnJruyvp0bigvyxxSKGi644CA1/OFvasHwMZPkXz4YvTjdmnzzhR8hki
	 oyGsv1z72tnl8AE351cGnrTEyEyFu8d6UiRwSPiKicIEJgVzI17a/h/Rndl+O2plH4A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790951966;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-UI-Sender-Class:Received:Date:From:To:CC:Subject:
	 User-Agent:In-Reply-To:References:Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Provags-ID:UI-OutboundReport:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=VM1kxAmKEgOBQFnRPVihtvkItdOHfvvM1cD0pFQe6i4=;
	b=F9u7blpc+STiHn2K8vq2OQhD/LVgZs4VMqPwUmZ6TWgOjdKtUVTdCwxgG2IaT76SK1Xj
	 RTxxYta2E+pyBs2JCIgnzYKDpcxgG4caIk/DnfTLoIdPOXXBBZWx/Y20jjH479r8Mg5Gf
	 OFzfPxHAYqaKWbEdEZMdMn45YCy5Qam6taIvFwralfEqqWL9zLtgBO/Q6QsD1OIOK9792
	 b0R3mb0fM8F7B9lObHqQIRCEzb/kV08pKBHKTcw8l7Os4vZCbvgXGCed+HDdASiYegdJT
	 XOMpEDpWwUIuWut/xs0h+JbGzXR2NEd/YLXBvDLcTmOoMvbC5WuVE2Kf7ud4MaPpRxg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790951966;
	bh=VM1kxAmKEgOBQFnRPVihtvkItdOHfvvM1cD0pFQe6i4=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bO+r25pumdbOUhAB3dZQHPiizLarL+mHp/PiT28+lIbksBnAogszTwDVccOrfLXgm
	 8aK0tUoVRdBHlinmMXRp/xmajkAkagO88Ys00ZPBSHSQml5oSl/WPmU2NCy1IWH4/M
	 /ep75BlAR+DmKmBSlUZ8CGi1bHEl1+vGjF5VZ3UtTIunjswFuROw+cYxiMctm3l3RT
	 fQMqy5wUxO6wysIY8TIXjCOzlCZQn1SSDBA8E2+TsOX10i+m68F5Los4KvmoCxxR2d
	 Cm9qc8vNiWmJS/1LHyQOYEneyRIErAsWlwQ7sxfCsD9gHm4XTVHczS0NNbjDdwrRoG
	 7ryXEmnl8wDkw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A4EA740D97;
	Fri,  2 Oct 2026 14:39:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 08D38435
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 14:39:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 060F2811BC
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 14:39:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FX0ykxtmv9Sr for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 14:39:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 4C17981183
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=212.227.15.19
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790951964;
 b=Ir9jqBOzGkfIiYe07Cl1lsRzAUXmYppuL/BAWlviBDwEOV1EhXQvXpGJCEqtoPHRqVT2
 kBqEU0BUOLxpSnIy6luNbuB2dtGnqK8GgEwJ7WrObOXvjym80a7eS/TP7c6t4SG8Oeu5g
 fGfTGCKkX/l/gs7OJaSMd56LQ2f+H+TnD4O6Av+F/iGtJKIhzEVrDgzUCx99CWdrYnc5v
 iCLQJMJxdZ99uGPRIf9vDVc1m6JDnzNbT7+bijCLpGRzP3Sz+vHYp2VJ2qfFPEQfWhLcV
 12P2D5OJ0LliEPVDCt9jIIWr0XZHRNcb1oiFg0xU9kLGNaCpQ36NG4W1HG6trTgjiwQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790951964;
 h=Received-SPF:DKIM-Signature:X-UI-Sender-Class:Received:Date:From:To:
 CC:Subject:User-Agent:In-Reply-To:References:Message-ID:MIME-Version:
 Content-Type:Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:
 UI-OutboundReport;
 bh=VM1kxAmKEgOBQFnRPVihtvkItdOHfvvM1cD0pFQe6i4=;
 b=nwddt1cNz7EbiaQsBmgelWAiDVKLjxNfzHwpTgODvsZzW6YZsSZGBfaL/2dtrJTS7Jir
 L11cCNxMBGEZXdZXE03vj1Rel56tu1gMC04upSvwKZPlLDGa9kjll4wrPBg5V6izGmbDX
 1Fgeqi1AUN7H+IavaZwzNHwaXrrLvDauOW5rY6QSknd377xkNlweLL5R/gf9u0uNkeNqD
 z35KbG5Gkdfq3WszzKMxUFv6nAC5o22luu0XFcpycX4z5a/I0II5RW568ID2377CW7f+f
 a1XSgEy5iIoj8wuTEYZjfgeV4FWYrBJ7ErxQwB6fofP8Kxa1Mlc9odICLYW3fOD43Jw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=gmx.de; 
 dkim=pass header.d=gmx.de header.i=xypron.glpk@gmx.de header.a=rsa-sha256
 header.s=s31663417 header.b=oBLkXmRS; 
 arc=none smtp.remote-ip=212.227.15.19
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.227.15.19;
 helo=mout.gmx.net; envelope-from=xypron.glpk@gmx.de; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmx.de header.i=xypron.glpk@gmx.de header.a=rsa-sha256
 header.s=s31663417 header.b=oBLkXmRS
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4C17981183
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 14:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1790951957; x=1791556757; i=xypron.glpk@gmx.de;
 bh=VM1kxAmKEgOBQFnRPVihtvkItdOHfvvM1cD0pFQe6i4=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=oBLkXmRSeZBmGC8Nz95lU+k/+P9YvUkMtFo63mBnXAt8VBHZu4B96hVwj41YQNBY
 dmw6QnPUSBJKRKHEfuuh6t17o0zytKqDGIxkw6S2HJ8kIbZ5bUOfFIJ/6e5J2N4pq
 zm2CumYzNeZxYHzZSUKqU7QmDW08gepok9C5z6EWmdweKcb2tBdNHwvdFHtz1lArn
 8p18Y2U+rCXJqUviiMupW+KjECCKlFxad7dvSjAvwjd2Axo20hBnWJ1CrPiBPBakh
 DJfmao5oXEldWAwT9AtVvKtyT2y6SFB4nNq24YQtexZpjCh2NgfAcoolFxLKBNL7x
 V1qhnVHtnErb5gbavQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MgvvT-1wVNAu1vqf-00fwx5; Fri, 02
 Oct 2026 16:39:17 +0200
Date: Fri, 02 Oct 2026 16:39:14 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: =?ISO-8859-1?Q?Vincent_Stehl=E9?= <vincent.stehle@arm.com>
CC: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, 
 Sughosh Ganu <sughosh.ganu@arm.com>, Udit Kumar <u-kumar1@ti.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH 2/2] efi_selftest: add minimal fmp test
User-Agent: Thunderbird for Android
In-Reply-To: <ar94zly0zywmoZn2@debian>
References: <20260922-authi-v1-0-e943530349bb@arm.com>
 <20260922-authi-v1-2-e943530349bb@arm.com>
 <79ac74ea-390e-409e-bfcf-033357832d71@gmx.de> <ar94zly0zywmoZn2@debian>
Message-ID: <CF811B8E-B192-499E-AEE2-3AFEB7243895@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Bl9UjgDiVq2xpaf/yCzKOuyyRVJmPclB884SpTZgmw6k2pm9X/L
 Jo5DewssrZgi99UB2R0V8E420Q9pFLq9c6vj6K2ISJCmGUmyCFX/QObaBT+LCxtnG0ZHYOS
 2sLdaK8TtKjiz7XkvgY2m8fhiKBOLwBZg9Wmw58z/AmbT7IX/izhv/9S0atA26XAY1Ixmhf
 un1pUoxw7v5IPk9gOhHDw==
UI-OutboundReport: notjunk:1;M01:P0:mY/bhsFY9nk=;4m+DH1KlNRjgBQx1H4Jh6W9JnrU
 CmIbzPDwF8lGttjW76mzmO1iYDjJ7iDU3YCx8lXrRICwNlzA2qxNnNzYBhf6/nhYcGt8VjBkK
 OPcYGlyoj3tJbygfFwiYX0JsA63+UHKws40e6O3ho7JwE1px9p2pN3c+/zHEQit0pD6/ZArJ0
 3BmWCDvmTfpSaJSn12YYxINlUMIQsacejHNE5uS0LnIm7vnhFyTawJrHdkSEMSN3sMXYiKIaa
 Ib0Bs1sFMb1fELmviNAirCQE5PMXuYPtmFj4iZCX6gvX5vVA3XrZZwh4K4xBAYLWx9pnszF5l
 vgjUaHyeHogvUuqNX1aVUwFvY0v7VlDz6pSFepfgo0SgLFT4Oe9wiTJVUvB5aOy73sbkbv1hj
 EzTjHEFLwcQURKv+BhAN1MV2pZoBJ61G2ncx6WMxXmNCKfNrxMmLfi3C9oa8t2iJh8cxFbYEU
 Nu5KAewq/JOj8p0hUji36/iH1UX7HVCnARp0ejOAv/Ex8wQzqY4p/fOwk/zTOIa2JBCVjjRlA
 /O4wzb9Ru45VZfn5zIkrDm+bXjRbQCsMmBpXnR7a+plLyYqU6l6qy4rUz3J4yxdAkME/x90qr
 JkNec5otvmw4I2J62e1NeZgYLxAyAbSkVLv90OsGweKwLXnaygWlA3r7X0R9gGo5b8clrXTB4
 /trsqi6XwUhSfTAN3pmRtYYfPoonWnGSZBS6dtpG6RwX0G9K2qeH0Y6559A+ndQzLfBQEHW/0
 6G/PISSkqKBPCPgukO36K2D4Q9PvWILK/ihzmCmhkdYshBMEGT98XUCQClSBm9Fa5JJKmpbrB
 YdTCt6zpPdmmdlFGkk6IsNVeIYLM5LCchu1w2QViHSRT8OWoKMAR9Xglp/eav8flQ0vY4taHI
 XgRXxTNbPFaiYigiaZBQhUxat5EOmXzwLx2oY3olLSSF7JIWIbRPX8lzY7lPC1DUdMElQz2Uj
 um0b2NwxpRpYSQKfPghGhMGkenrA1jJRuzxGKIr8e93M6HGyVPaVAlBLui+5ZYzwueYb52ROz
 MhJAmuhsBpRSU9RFo+otLdzoKkm8+oWxCmbPwte2GofF6Vx/xVW00jp7eYqpO6FaC8kyT8lo9
 9ejKt0/YlTOR1QJtSSC5LtYJHR0vA1Z0KBh0Hkd51FZSY1paAjKi5DVWtfwB9NeLNsonywyxz
 z6WQgTOz3FuSrccKxeXcZVcaQxmCOr//BdjFO4oHOs9gsOcnibYqBFUiMEpWQw5CujZEUiq/2
 HftL7sBTfE4zOGuwRtCAU6bPePMLxTVrtWV9ZS4kcsqxRXMn54s/KTw1HTgcyw2iYTQFjly5F
 zcCKF9CkZxMinwXXQO3OUusdIQR8QTSR4V+z0RU3BkVXVQTKH0uKqVFzfdtZs93XsZVgE00tS
 cR/MwnpoxegXzLaoPEmFsTueJi/L9VdHoq4pvNHWwDrMdppo+c5MXM7dimOWH0MI0GCufOaEY
 3etMT5CFgPSWHmxj2/EJSvYHAS3xRUuYZ51k8xaNEOmYvYdsC8CVdU0FdZtyLyxog+dgrp6pv
 6vMz5FL9AWRSx8eDspvpqJhZflJDLCPgSQq62BNv52nzao5tdiJh0ecmiBRbjcBCRTOBqbcLW
 eF+Z+BCMY1NOZOj5Z02YFJipS/CW+DIHniS0x4bv5uLRh9v88wmSYo0wSMmDEwQNXPYb13qfZ
 VWQ7opUfGOH6z8/pR9MOfG/DQ2m9irf1gmkjaONCSgodrIwUiGFECM30u3cfTaF+zVo2f+KHg
 sm293oyLgt2Ry6J7Mtem/687G9SVWrFPlSQwQyBC7JRjjR1Dhp8Rb051FjMSBC9UtK8n2QVnx
 TGnbT62rboglxORg8HGs3MOzpnn+A30xzkRtwBD/pLRoLACwWsxbOk0NT4R4VF1+UpWGiajF3
 SVK7fkLbnRmXJS5bPaGLz89541leAljnCG13mO/be44+NWX7mlEIPXHg0z28lrsjekU3lDLUR
 rn2SfEjo6IDoybN08qYO1nnt5eouSyyhefW/RR3WN8oT6k/oPzx2gsRBztBWfF8XPnA6y/jsE
 X/zDDnRvdvy2vmtm337hJ3BIPubsyD5C+luies/AMIwF3KUeXe2nR9mSMW9ICi2pfZP432XCY
 2QHSiOo9p0Jk6kJD6T74PAfTe4JdmlsgI2JH56qfCtVK9VW+Lmnqq/HsncYCTX6WOS2R6kxeL
 E6kwkukS4nyLxxCy1P3GSYHSn1KyW9fjgcGzpNPv8WEdZZ5jytvxNIOt8KFyqQBba9jOuErD3
 n/YyEuwjz8MKWSFek6VV56FaglsBqS386RUlWEBHmfyV3rmvxMWGcefMEu/YQmVaKxuTEhVUp
 4hcZXwyE7N3YaQMSV7K4s3Boko1Nx4EkTf4arwXBgRjXYeLxWLRc3e/NG/AfJK1x6AwM3Xz/o
 dvvMU4lgZrodcuiqy+wDeEDvPSVgyuqUOPTvVj9266boeiAffhUJOWv2NdvxevgVENj6bXw1g
 hT4XjnKROkyEaMXeJs+7ooZ6KgrCp9+OU+51NgZuc3zS0Md+NZP00l1fqmcAFPNy2OX/BWAY8
 d7l2XGkmSBo0Ib+uN0zNx0O+EN30vz1ctPsLrWoRJU1lDeZb5XsBshZ8WygDeu/4ryP/jH77H
 0nV40btoNBo2/6Dx2tuyO7RY4dPO+CbRD52e5+PR/MKv0p28MosC/qJ2jA2/7W6QPdcxKPEYe
 Mo7Itd12ZeJSrmHqte7zA6lJyCcvMpvDuS8djUUoVQfVv+uibu5aagFdhP7vwC23SwMD6iNKL
 QXLZH8ggYpWVdSCS0hada3cUJDB7qmIFQlMXoVn3huPsQRg5Tc0JcQbF+TXKTRrPdOgrVkd2D
 bAHtiZYmv2fItnDFInAB/fILLCrrsNP/kuq6TZHn9fj8riKHsk4u3cP0NcvOSVCJ1EmFV60oH
 jf2bLMQOryupNplUy9rGmmFRGvFnuGSK37Q6eYuAixjgOm5Gq/fT1athZFzKrNaogQqcil1IN
 WPP57ibZW3SeZ2p3brsONjHIrYoMx6pStoRL0+s2pIP1KBL8DdIyh4b/o/QattnMwwbm5toVH
 smeQxLGOoYZmvs0Ynsuk9NUYCAWAX94SvMaJNhewoJXQ+8cUlRbOj+YZbatQ6roO6/jui558C
 vK8aGkH6bB2EHQ5fXDKoy+YSYPSmVW0eYT50Fj8Rx3H/OEX0EZFwyopUCM/0fQy0GzZEG4Mxr
 qmJuqJjajCE0oUq+dyhJRQCTuN5utBOIRmza9p19fnFz1R7Gc5OA2XoDagE8MdbXE4OidMyuw
 TaVDZzGNoDy7SaPRBHI5+LQ0xEVvAJuDc0bGGA45kcAkiDVj6Rq8D9kFqmFLlTkZxeHtL0Du6
 fxxkccZPyHYniM0gvs6yMzPgs+Cf05eSeKzMvFxLYCkPXidnCnAdZRkZRNDK9Lj4cA2unnlmq
 Hu1pdJGqOkV7UVgCzSfOMfg4BswgMNyNSfrfROHaYxN4fShLCUtFfcVkprGCZyZeBMiXT3Co8
 QTR9NFekT5s2SVBcYsDbFe2DYTGlQT7siDV5bHhkWaf0pGIob/vDQHREzH1X3u7cs1Huy1taC
 +ZDdFPY/pCHSFMsgmaFQz1pquf0h4E98n/pFStkikmiKELWE9E155OdLDkS/ajx29af2ij+GA
 GNVFkBaNF6+7XZGasZyisE2qhOZWbS03rmEWhE/NxanO5XCeC6GnyRiJ7eGSYGaNbteVsh4pS
 L+Fo60xHGIHHGmmIiFYVT0tatpkdk94OSku9hdZO0nN/Fnw7ryfJaJCp7IKTSb0TaC9cb3q+W
 JyIVz1if42KiuNe2d1YsvcPLf+Y1si4AWfPbuP5tyl73NHyrilx/QR1D6wGGhHcrCHvyUsDLi
 JKum+rM+MvjiqiteOXS6QZHcVyj5hDYvkE6nk6L4u4oXXoXQLLCKF/N/igNnXa7rStvsBYJlp
 uPOHmqN3hSdm5RwhDHSB3Tx4PaxD8PW9/bWDq448ns6OIP9yESsreooNZ/5c0E4HtikxO4QzF
 X4MxURjRQRJ2w+Yfail3c569I6zGnyfnGRXNXgdzocfC8DZrq8zYrCUUImgU+ix2gbah+NEj0
 EuSdg7L7Gc6RWZUiqeef5Ayo34jI3YWekpznLc8oeLE5QDtnd7OUB7JwOi265au1FvyqynEmE
 czufoLmHtTlH9o51QyjLiosSgcBIuYbxmPhzWLtcgXzRK7VkWg/BdEREAR6uPCOfI2TvadGmd
 wvz6HON/lp2fJdjdabdYcL0PK9NIjuojlE0WDjUQCW2Yt+vbCiMDHYjtjU2FViXBl1dgCvmD4
 Cam+XpTpA6M5/JIkCWDQiR0TSd3JwIoCyL7zYFCMWZBMp86NA5oAui//kXjqXMCAZw3oJd/t4
 l5okgtK1d7xT6uG+Hn5eFimazqhazRVoJLUcL3VhR09+YUR/KqBF0VhKY+qYtl/+24Ne7FYAZ
 P4W9T8AQxWaLxYMDTpfrzcq7lrLws9SgBBkhH1nA6QsJcbCpHwnkmRMmlQDqMVawA5iA2Kf2I
 tbyVPvfROROxBk4yMdkgn2Jw/jVAgOE1RUcbuK6TE38tEtJji4DlZWZOjwoaXSmrWBHOcXvfA
 y+SJYmEifmgBlGvaPO1HIgDTrEThz1IcmIsKRLkXf/zywykKchtn5Ju/R6zvF+zwEm6hA+3rD
 dq7vuZDwXR9/oCltSgor22YQYbOAQOLZ+OHUolN/cGyCY+VmoBotKJBhEOWiR3MjgS/l+dO22
 dx98SGBU85FHawCpdAv+UxevTqLFsaW9bVJtFFEyzpOP3WHSSgcaLT4og5QE+A/9ANI6xXOrD
 SQ28HGp2xtkxCqZw6Ff6DEpVO41QIaL+IcUaNmtLLVJHoV6DsaFhmfFNdH7XK74o6W9m6/Y/Y
 VQag/1mKqM23sur+NtJhEwrKDx1H7MgqYD4suKKajiuExHTqawPBjZDrjXGER8BsXgR7Ncgqg
 3p+/jt/RwhkLrMem5pneO2A9Qc5/nRPRD5qtvN5cuzXhBCnR9TMoOvnleS5mqC5/XSqT+ndyA
 ww31qnSaCwmNG2TN3LaoKZmPRGqe573EqiWqcOAuDoy/Y4BFgzBuDQxky+M/3xmpTM9Abxfp+
 F4v1J5K7iJH0tbE3j2FKCL9nQFubq2+hi6dcn9DLfKqsmPu8teKQ40Ro1lpyPDv7n3lQaMUQ6
 iLodg4sUosUoa9ir+1xSKj5yx67ltXZUPuYc0elcocq4Q4R9Ttqq9AzhqjkNOrxnKbF0kbWsc
 FvHLuUJCF5WGTwZqDMRt0PZK1BEyE6qVxLcAkD30U24+ei49b/QjHBLSfcjZr82ioe18X3r3V
 2ndZP9KgVpL0gjARE+GHihODCmUBcHFfvOfgGCqfAkOA+v1OdzL6VNY3tGd4E1OKhT03AkE9e
 0VDXqbG5ypwHASgyAzE3DsKXbR2clTv1sa7G7vcslqmfP64SOAHeL2lN8Xro5KEs9jonZy/ZD
 3TPttutoHFsxuNK+Ylf6aShntVJWhtgi3cVXuV8cCmtldXaEqkhc27DN3hds+UpupKUz4pmtU
 RR3UcXs/Y9pk1s3gBu9qQCOEPaGL/tazoL/YSYCi/j8v/2yW9XOj9Nr8aQfXm/PYLxmT9XJIQ
 aVl/I6C2PR5P7w4Ql3NDpowHg4WYCtJY1lkQTOAY6stGpocGj66jhFzgElgc64b6sd3chQt6A
 E1iaffoBc5LtkrRzVhEGnWDRDMGmc0AgQVsEnKzRbJv4jQR6rD3edC4bgWXKrpk+aBIUAvBpD
 2KzD0uEijbK4b4JHFXu33rfrKbkb0u6AvH4AmmudZJHwW8/RCSMYvJXIQbBYL56S6ikfFmvd5
 XlSDveb/toGC/KrQEGLuHrQ6SMjLGXuXgSt2/FVGauDOVE6V+8+7wpDLhZe7djPF2i2XtwFOh
 h0+kYeY8pGpr9S9NtX2fdbVvse4/nrYHwfGjkJyrAE754//YF4PMWc12XUUxSJUHLtSVD7Meb
 RZmYuoXHQypYujodOUcSOEoBD8RRwJRDT/HruD1UBvJziWm+VTvNa+oSQ9f58Zc70I8RhCwza
 gvzQkP8/WKsr+7zqv2awENlH4391yjVqeNqszWYK5IUlYacR78VpDkT+piL1L1FhZr5EPeLYP
 3dohaH5O0y/4tT5epgv/nD6oVcX4RDmS7MSxCE0hOGIUo/j9QOqDdbq4f8o8ACqzHfiQuOmEf
 FCWONSVjGK16cfSLRJZG/+Ehk16y809CMhbFcdvcfG/LC/BIozd8D+K61vR9BwHc61A8AjQN/
 6yZkQ4jzURQG+OH/bFhY8L8smJFcDatwSzNQGGLmUZGPRujPAemuA+GKz7+El8m5IWWm5D2Qd
 wcmytuwtQocw0C1JJmma+lisTtosTFfQ5oXCIGR6NNBk/cOkXnHewgnPrTJ7Hk/gwrEIBoJgc
 oNz56h2+nZMod
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Am 2=2E Oktober 2026 11:26:38 MESZ schrieb "Vincent Stehl=C3=A9" <vincent=
=2Estehle@arm=2Ecom>:
>On Thu, Oct 01, 2026 at 03:55:10PM +0200, Heinrich Schuchardt wrote:
>> On 9/22/26 16:58, Vincent Stehl=C3=A9 wrote:
>> > Add a minimal test for the UEFI Firmware Management Protocol=2E
>(=2E=2E)
>> > +	/* Determine buffer size */
>> > +	img_info_size =3D 0;
>> > +	ret =3D fmp->get_image_info(fmp, &img_info_size, NULL, NULL, NULL, =
NULL,
>> > +				  NULL, NULL);
>> > +	if (ret !=3D EFI_BUFFER_TOO_SMALL) {
>> > +		efi_st_error("GetImageInfo returned %u\n", (unsigned int)ret);
>> > +		goto out;
>> > +	}
>>=20
>> This fails if the number of images is 0=2E
>>=20
>> ERROR: GetImageInfo returned 2 (EFI_INVALID_PARAMETER)
>>=20
>> +struct efi_fw_image fw_images[] =3D {
>> +};
>> +
>> +struct efi_capsule_update_info update_info =3D {
>> +       =2Edfu_string =3D NULL,
>> +       =2Enum_images =3D ARRAY_SIZE(fw_images),
>> +       =2Eimages =3D fw_images,
>> +};
>>=20
>> This looks like a bug in efi_fill_image_desc_array(()=2E Why does it re=
turn
>> EFI_INVALID_PARAMETER if the number of images is 0?
>>=20
>> We should just return *img_info_size =3D 0 and EFI_SUCCESS instead=2E
>>=20
>> The test should return EFI_ST_SUCCESS in this case=2E
>
>Hi Heinrich,
>
>Thank you very much for reviewing=2E
>
>I confirm that I could reproduce this corner case with your changes=2E
>
>In the end I think the test (v2) itself is fine, as it does pass when I
>replace the calls to get_image_info() by the following code:
>
>+       img_info =3D NULL;
>+       desc_ver =3D EFI_FIRMWARE_IMAGE_DESCRIPTOR_VERSION;
>+       desc_cnt =3D 0;
>+       desc_size =3D sizeof(struct efi_firmware_image_descriptor);
>+       pkg_ver =3D 0;
>+       pkg_ver_name =3D NULL;
>
>I will try to send a fix for efi_fill_image_desc_array() as you
>mentioned, but if you agree that will be separated from this series=2E

The UEFI specification does not define if AllocatePool(size =3D 0) may ret=
urn NULL which would lead to a failure of the subsequent Free()=2E

I think we should return if size =3D 0 before trying to allocate memory=2E

Best regards

Heinrich



>
>Best regards,
>Vincent=2E
>
>>=20
>> Best regards
>>=20
>> Heinrich

