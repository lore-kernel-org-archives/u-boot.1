Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36961C4452B
	for <u-boot@archiver.kernel.org>; Tue, 21 Jul 2026 07:24:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BCA7540801;
	Tue, 21 Jul 2026 07:24:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Qb4uR2jx7leY; Tue, 21 Jul 2026 07:24:00 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 023764080E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784618640;
	bh=LmaCRp6myjAU4Ol/LhAFQEIkKjDibGs/7i/AW8sZL9M=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=KZX1ERaFkaYgtq4lH09LYDIM++dWPUPY+OCtSiYCaE8bjjNki699qqz1hvlHlJZcm
	 aMpc10LI9eIxPd2B0dR/2gNUYN62R1V7jNdocp3QxpWivtIE8o4JypwQ3pe/ESjDm+
	 DS6+skfd6c3BF8mMfXLXmQjdOYRFp4vQskvk1LKqA6yuWvGSzaeS78qjAb9dXUyuCS
	 W9/qHMYtUsuUEIn0zcR+cZfoAghPFqBTkQyExsB6Ya5vAZoAFE2T3PIgZ8aWq0CIQG
	 mPSPmqgJp9uGewrkd6S2FstskDFCBOgOiy41jUg9brxu9hQVOC6dTgffJfwWXCo7vl
	 /YB7AxuGGwajA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 023764080E;
	Tue, 21 Jul 2026 07:24:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5F234109B
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 07:23:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4475E80E07
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 07:23:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LoyPq3P-QYyv for <u-boot@lists.u-boot-project.org>;
 Tue, 21 Jul 2026 07:23:56 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=xypron.glpk@gmx.de; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 5439980E35
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5439980E35
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5439980E35
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 07:23:54 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2CD384659; Tue, 21 Jul 2026 09:23:52 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10D7C803F6
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 09:23:48 +0200 (CEST)
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MacOQ-1xIeQS40F8-00b222; Tue, 21
 Jul 2026 09:23:47 +0200
Message-ID: <49d8b67e-c31c-483d-abde-462d9cd27a73@gmx.de>
Date: Tue, 21 Jul 2026 09:23:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] global: Switch from source.denx.de to
 git.u-boot-project.org
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20260715172146.80974-1-trini@konsulko.com>
Content-Language: en-US
In-Reply-To: <20260715172146.80974-1-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YWb3do9a49UQNBptDmbCOyqjfz9mTseG8lBfQBd1bCFTUzNtI/T
 snMu04BHgWxyZ+urAO3HJBojEV1OhUFbGZckBc/cKGbcVFrYMFdHLtfLI/Tev2SLmzNP3/C
 wEg2C/8GuNPO3SwsaAV+mGNwnlmfwsN9jFgTIjJH8odk5gXj44RHi1fscj2iaX6L6J1SBrT
 6rWp4nFEzzX39Q+rZMNFA==
UI-OutboundReport: notjunk:1;M01:P0:aiQbaofwHfE=;cXdLCqOQ121OBpayZWIFuc4hkL9
 O1QC5Sd0240FV4EFdM8g3sPBDNevdajjdtleKfKk/lxYRauBSKQr427xn3LSMx5tW0R+LBjMM
 baDcnbbnTizuy8eT5K8ha4HbUqvDttvSbp98/zw+eIDfHByrKU8PsJg+Yxp9/Iqs2micRJapg
 TzAYst2ng9R8sBeXZp0miH4cJ3hGeoTxXj5MUNr+u/i8b1GfHQrJuNjFSmNvxFHwaZhtL4otE
 NY1nOkEpz92s7CqT9/kiF5++kzCoe78Ft8josA73xIAYoDbuh/7c3GLz+5EKqUGg2WAAV41n3
 j+mGPt2UcmV3rWXfc55s0neRMMgD9toVZ9ds2twoi2t9yygIkatOSaR+Ln9Pv4N48mmUojlcH
 uiVGr6zaY3ucgCWRF0gvSJ5oVF1ftMLRbr4FOaNZMkiPsN/1JoMN/oOdbzcFqSytWmAt3vQOR
 v4Sn3xmLiZrW1Fq7Zs/bS2pojtpqCCkHTk8H2ZEANMoo56M4JAcZzx2VLV2AXnzz2SXss8EDc
 T07PO7rK6cJm0xB8HvMvMkCDJwhFmlppuHEox7VQOAWEm+x9LKPjdjlFjZ5mXc34xi0Sr0gqT
 dkVB7zUi2c9tAjlN6WZ3Iv1oLuw9LAOO8dWoHxtyrpXUbGAJdkr8W0imPQR5CE99hD3M0tGAw
 fgEIYhk6NWg7P0oUGDPlwZYRGJjCUP5Ba55xAzYcFcFYfgVJWDWV51ai5O4FNJy8v0qqbI4GB
 zz5FTyPRpXf1JMnm9niwbopBtcphD7hY/C3yOFopNGBBOZ+Z1qKVsUqu3Pc9gmlml4EEa4CkW
 sY6asGMVUToY5b/pgSH1yFKztECkTsyl/XWugLfYd+fJ7jlzlqFE9znVI4b5ToRqAFAxCam1f
 fears1iORp2B2mjbfYrvFNwP8jNoveaqvZb8GMlqFVoRSYCjkQZrIg+9a82ZunAKs0xa9SsXv
 5aSVYluqh8FW8YgZ4ocCn2dP8E45/jmkDenkI2lwOY17zbzndO3e+md6Ix1p3xE0vA43OtbJR
 B7NmFkQK6ryDXDctmCTBPqjSmIZ/KfO1RPtoA3QdrZcm+/+A6PFOV3O1IcjrstydFIE1R3I2I
 BU7fdvSFalUZY2+f/K5oxl+vJZsuwmHILPz7i2+ZgapYRdpXe71sBZE9qKuNF0MxLIxRy3nFB
 CUNWDcQAqvCEltWj7xzmfWrO9ClshY12+3E8YIYnegXzuWFMCinSrCIS5k2rK/9G3mnRihcm5
 c25/wk8utT4ZskdbAfXWJkDv0sRDCFefZ02urVFQxwTYAn5w6f4/+/ZJftAhB+lMijfEZtHvm
 jI6nFd4gV8b/njr6bgElO2rTZPA6wSYdDDapjvY5KGnpsmkLmLwRPD4MquaUfD+G9UGlPuR6d
 1c1Oipb7oJc7W5nGPbByEKPYYN7U2Ca4yCHatu9tDH0fSXOPyzzgX9Ge6zeJsvbvuNwPtdLwm
 X3lWKTLlHbWj4uuyMV0d8VWhWPSLTC2bfkFt4ML++VCwZf3Disx9MYMtlaClUai7dRwdtEHtu
 B+NO1gWTaUVojE4TF91t6aqvPC5hf2OOVXHyzZDM7xIatdf2OWCdL9cRrms+6KVeC2uL9q5mw
 aRBCVPORrqoGWgT6l+3TKZL+4qtW9LIwqsfXecEMzdH1F1dY+GHhw+wjFFel5XRcZtKxMl3QB
 XIn49kkznFVwhLONUzkYJvrQSVUqxeF8/IvGWDnbAO+2HMWpYhFkHJ7P7DoT07dLN+tBdgH/h
 4QGVvhy+iSGCOcjACemJzYkJ360TSUOuVquOz2fap0yyrTZLVXNNMle9N7pVnVTkZ891Cfapx
 F8hpFyK4lZILVQV5zUM6d1WQOdVb2++uEIRIIZ6XP7Lq7Tc62iMTvwhicxXX8P0Al90Ksu09o
 EVqNOeAoWzwiqV2Phz2lCqH4IpHfqsf6Wp1FeG2bGc3urf1CiimN4iNcqxAAsW1nj1BnvT4fG
 PqnNJaGfUZZlBllxKjgCySSWTfCSf8HGt7I5yf7jqSAPUXZvt2Y0Ht+1Uy+YuIZTaR0Yw0o65
 fvbN/ezcYJEHLqza/y2h76E9v/nz+GFbVwpJoWJk9QAjawjzG2cXUqN6+66ZVDCJnitNuSS8W
 MBuRa452NovNR8cvueQOURHRjQ9kHj1n9p1HfBxToZ+0nL+0oKITpSozVtp6BZf3hPZ9jJFmC
 OeBjz+qnc11Ap9/g6J+dyj/gcw/e06ib9t13pJbUDAgc7yxI8zVxLhyzSqm3VG1eovSPMuneG
 2ew6VL4+vCwmlsrqBvq3opmjghViY+6npP8AiHdGO0P3S3pZM2zce1NXptqcDPEscP/G/+UpF
 N8+Qn6740jAKThPnFVhzgW8GXaCY4lACP0XtbW0x0TWwavjsLDEglSdIHV1Z5SWo+8LqdHTTD
 XRG+bYQ216USjGaHWvqjCW14NFmOkU34U0TxkDyYhI704+51z7JnsXHK3fh3Fi3KWPu++Y1Xc
 gQWkpHrP6gyfLuupT594QAAGN0GafwErgqvRSli6qKLpp95+C5S9Iocntljk3tlstXLdKh0BR
 SMjNxI/GzZhqW3HNqeeYU/aOYjXXGHh27BdNiRIxrGzmFh/FUusma5JFdnI60H62P6m/jtWir
 y7Alz5N5T7tZtlSxO9s9j+Iqvv9Zn+JYKrMS6kRDIqm5fWhIp2SztwKD6N3feRnUNKDBgRntU
 a1epulOO6IoBaIdmsx73NiPrR/zgQpNwrcl5M8PQ5rKzJOkiamE5FVKp5DN+t6L824PFQDqXi
 ucmYehRtwQbQBakFrwvmRFHs4Fj8ZpWgR+jllY3ZamAfO0TroEVyKcDa1SxaCZeoBVHMZNVM9
 DQIBBXMRAOsikQAi34jmRT4vGBz/M89/2XomqHJP6l778q80QVzGhTLe0PSR2c4+9Guk77LrL
 P40IEfjLd5xK9rknC9Up2QC8o69mFm3behg30uUa3Btl24hJU5cw5koFeoLrYXa//OHMOYpIL
 ApleMDR2SIjD5ZplwcfOA4FTdcNPez3KBZLxcIoC0y7bD7DWc0cRGMbCWaGvhnkHHUokKmenn
 zfw1z5RxBeEOXt3ZK3gYgeCoSi1rZhq5axMRvWH88ONlTCEVM/1dl7jTpnZZtNOAlPm4dTPUd
 kskWh7hDLYsZdYt/v9w/5Mdi9FP02hEzHK1vFL372bTj1DiT5e5hGjZm1U47qPvDkr3/UPVEG
 L7FA1hNhbbs2a6A9wIzQUTjPmoMaEZcfDcAYatiBBr4+d6GaoBOj5lBUsAEBm5Rx2t7kWRaYu
 qBojjJkC6UxvQdAUaigv0Ns9OCN1CjBpVDyujmcC0Orxufsiy3/O1MxL2Bguz8KCNAhvq1GCO
 sUYmxHbTIBQ9Pc5Df/hoWQdro59Sv7Z6lnjckUapbEa4v5v8/iEEnqTEml1s6CCDziWSvxXlE
 CsEcuiwMeVuBFkuKwEWKSNacqGLUF2/ugS9XK2JckEj6fHwJ+YYkYKAZ/ekfWJJSBnSW6akJE
 m6pnmOIUQLerW6r+HqYUDkzWv5RRklHnpyNrPlTHYPt3IBcyktOunZrxrYeHPoGXs5JETvZmf
 FMafg8KyhlsP/OMmSsh+5QCl8LtM56DaQMwTyOGfzyhvz2/v89gYJh9UFqaOZtR62zCnnNydV
 /hGzm8PtvHE3gSAiYfkYdRhpO68WfUCI/HDpOP7btYKtiPAN/u6ipdBkyKDkMm24C/VWisb1y
 rbH7Uba0vIRHLaHrM/sUhe0lMlIKokpiJsc3CQ8m3YCZpa3L/Zm12e4ELzK2TOEz28YvrnzS6
 MLc9eoatsr6RjxQANY+AGD/fppx9tcGYQ25b+E0k0G8awfoyixKuGXow3vQ6TuZXwlJvTUDlc
 NIUrNpRf0BQ7XGHka6lO/4b+RTG8MoBTaFUGGP3ADm/Euq0RuBBrlSe5s/SzLxvn1lg+l0p1X
 jPOiKNH5t8mM/1yZqV8nLpCEOJFcsOCLEqJTFguse/FqvFzE+VbKTlEzh2HJYAxG8v09yFRAL
 K6WoTOxXdwXfQBYwIOENo9KcW0Yfuo8cjqsq2C3fp/UtvskwWCtfCkejcTIJhbfAmU9s9oiAa
 8Kks4Zx09beXPAwS89bPKkDuH923tIJa05eTxrjMYQqT1pe8A+eTp8h4ZBQuxqU4Wg3tnt2R3
 vNuzFlV8ZuapymzH8cAl2Db9vOmoPDFN7AJbf837bz7vMr1FPyQEBp8uyAtiThxKM+0B6eH1g
 xWaywk1ekOKCmZKL1wj5QhAgbvcM4KRrdUCJ0c2+UpPKIkSRV7BXcTx74k5OXgGvKmZHYoEeQ
 OL1+3qP0k5KwoAfhSoiIb96NmVE59YzYOZT71hwYbP6Rwzq/tcNyoZ+j8yov5r8if8cbdjxkE
 TdKGocb1FoC6oG1plYTZsxa31+a39f5EYVxxuoH6VoWUVTXx23yxxO0GoDZrJWqIl+brVD5Ej
 MwAnpFA6qRr48Mkl2r4t+72oanOB1lqsJ046yr4BTbNOA9XX65F8KczX7MYiGw+xkDqr/bI0P
 BzFRmVryNE7QiOQ5hZxAc5c8AfHp2muQzGuXkU7xrW8IKJ595DoULay2OoCRMBSuSAtuZlHjc
 hoArN66WTng1l1PT5bSpfpkJiTx2t6rlW2Q4YMgPpR3ITY8dcEIDad4hr9IWfYE5Q8XTR63qc
 X2QFD3wRLzLSdO9e+5M5sG2HDQ9FNPCCd35tDf/NVE2fN4tSlMJfnbjA9aFj7UUKqgdoauDBO
 5Zajurz4jc0EAv78mmqybp8S0DWg94cjyavZcRq2ty6F3nt0kLC2S9CN4t3TOstAgb42uhKuD
 OIHnWWV95NMlvdxadqpBPbWwkHCPhPDGrH4USf2ms8b7X2BKJyd3Fozu7+MVMzVQbiYP1xa4a
 1YKErrm1+0/vLviI1NfkjYbwfZyJ++YMmG/RAxT2YDQGNFVTZoGY2XrcMO+NI6YTVny4P2u8q
 riBO0M2W+Qhj6Awim8crB0mRtFJ6yIpc2Jv0OcBZovo7QgHvTkj5JYdyATWgyuTQUJhTLQTwn
 X3kl0V2Yjdee2L1sIhlHKwXc/Y5nhMyoWwTFVZANRmjw+qe//8UanJUWnaFu6EfHH2wW5hltU
 PDYEMWzx+cgr89NzL66QrU11RyYm1pV2kSYG1Lxyb1KfiG3aZA5+TxYIQTC4TTzHnMOl0g0xX
 yfJufdFp/ObI7JAovMFGgAdIMuPkI1EXNW+GAhRR6ZS+bQ7oAhekwfCq/Bzmp7OAWYg3UPKBo
 fsc5WgH3LhcCLLsCSp2+9qNhxZ6ruuVRzqT2GfErwXQo8bifneDQDsb5mczzNJqj0ATQH9zyI
 pdvQPC2vqQfQcirF2STImfosY18Twh7PviZfex2VNLglmni4L5120Cgc+hCryv/8Feth/ijJ6
 DWGv7GBNGHY8qkEWuwC1G3LE52C5akHGvvwINtCFX2Mts326dBtYNOEkcZL3k7MXVjZFIK8/4
 3UX6mO+6HhaaoNSyQHuyerjxvQGcEmMoQI8CEAFFwEUP5cUyb40BzyjgfEljPXKrFVolXkkgd
 DFSAh4bIl1ERsG1xitaeVl53Uzihgf2k3fnZoqhqMHMqty2rZPdw/t7lRTSSpFOeAxHpyQ9Kf
 XlNoXqbIzXE1o5JIOSH3RxVcp0x6ifuBZWzjIo3vCJ0G9e6DkYOpafWy0UkVwy2KLzd5CYGSP
 zL6r2lQeV7NUHTTSqohbgkMQ8KoZWVQS9UGsjnFEHCqhAFqoemgkj0fokDco28OupgpyCus6T
 90hpaL5WnQWRfySyayTuS3VeBZhP2Uva1/2BNIt0118C1bwfDjFa3+rXysGUoth6C1wKs0Qhh
 yZSi7Wlf6YxPQQFCvXR9JuGrRfv6VSmzzJSI8atD9C89kXs5tZmg+FcA5oHFAgLHxPPIm1WYT
 frP9O5nyqRdFZ8k60IuHEa+QQwWIVnbYAWg4aBJLEP/+ibd0QWlMvmxer9g3ggVGcqTDVu6Qs
 qRWX3IDH0yYGsF6Np+so9y6x0s8wFq7J2Ulcs3I/RXw5FY=
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmx.de; 
 s=s31663417; t=1784618627; x=1785223427; i=xypron.glpk@gmx.de;
 bh=LmaCRp6myjAU4Ol/LhAFQEIkKjDibGs/7i/AW8sZL9M=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=saunMXGmMAnDMzuGc9W5uVkJbMH8yox1UKYpkVw5/A9mDqeJrQVkEsJc7aYVEpMz
 Syozndwmk8pfxW0cXQZvGskVgkIjhzvlo2KKNdVL3EbXehyCr3DjIiw6+jnxoFGWS
 LSCOonQt71rucdCi410zGfYB3n0iQC1fXvIpSVINtIHruLiV1TRf6QDtULuXCAik3
 +4FNstL1e6PQpY1n9Kp/AD8dVgbYkzv2VKL0VGbhQ/s4Uui/FWPyZ5hwWQaRnSA3A
 tUsjIWeS6g34BncKRxSIfl40lg6jRc+ukikVPWIfLe11sl9NaCK9i0Gf05Tsb+Hnc
 dYTNzbnOotg9PxaxnA==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=gmx.de
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmx.de header.i=xypron.glpk@gmx.de
 header.a=rsa-sha256 header.s=s31663417 header.b=saunMXGm
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=gmx.de
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=xypron.glpk@gmx.de
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="saunMXGm"; 
 dkim-atps=neutral
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
From: Heinrich Schuchardt via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 7/15/26 19:21, Tom Rini wrote:
> As part of moving our git forge to a new location, update all references
> in tree to point to git.u-boot-project.org now.
>=20
> Signed-off-by: Tom Rini <trini@konsulko.com>

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> ---
>   MAINTAINERS                                 | 144 ++++++++++----------
>   README                                      |   4 +-
>   arch/arm/dts/armada-3720-turris-mox.dts     |   8 +-
>   board/st/common/MAINTAINERS                 |   2 +-
>   board/st/stm32mp1/MAINTAINERS               |   2 +-
>   board/xilinx/microblaze-generic/MAINTAINERS |   2 +-
>   board/xilinx/versal/MAINTAINERS             |   2 +-
>   board/xilinx/zynq/MAINTAINERS               |   2 +-
>   board/xilinx/zynqmp/MAINTAINERS             |   2 +-
>   doc/CONTRIBUTE.rst                          |   2 +-
>   doc/board/intel/slimbootloader.rst          |   2 +-
>   doc/board/renesas/rzn1.rst                  |   2 +-
>   doc/board/rockchip/rockchip.rst             |   2 +-
>   doc/board/starfive/jh7110_common.rst        |   2 +-
>   doc/board/ti/k3.rst                         |   2 +-
>   doc/build/source.rst                        |   2 +-
>   doc/develop/pytest/usage.rst                |   2 +-
>   doc/develop/release_cycle.rst               |   2 +-
>   doc/develop/sending_patches.rst             |   2 +-
>   tools/binman/btool/mkeficapsule.py          |   2 +-
>   tools/binman/pyproject.toml                 |   2 +-
>   tools/buildman/pyproject.toml               |   2 +-
>   tools/docker/Dockerfile                     |  10 +-
>   tools/dtoc/pyproject.toml                   |   2 +-
>   tools/u_boot_pylib/pyproject.toml           |   2 +-
>   25 files changed, 104 insertions(+), 104 deletions(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e5b2a2e373cf..8a7a6fdf32cb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -81,7 +81,7 @@ M:	Mattijs Korpershoek <mkorpershoek@kernel.org>
>   R:	Igor Opaniuk <igor.opaniuk@gmail.com>
>   R:	Sam Protsenko <semen.protsenko@linaro.org>
>   S:	Maintained
> -T:	git https://source.denx.de/u-boot/custodians/u-boot-dfu.git
> +T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu.git
>   F:	boot/android_ab.c
>   F:	doc/android/ab.rst
>   F:	include/android_ab.h
> @@ -91,7 +91,7 @@ ANDROID AVB
>   M:	Mattijs Korpershoek <mkorpershoek@kernel.org>
>   R:	Igor Opaniuk <igor.opaniuk@gmail.com>
>   S:	Maintained
> -T:	git https://source.denx.de/u-boot/custodians/u-boot-dfu.git
> +T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu.git
>   F:	cmd/avb.c
>   F:	common/avb_verify.c
>   F:	doc/android/avb2.rst
> @@ -104,7 +104,7 @@ M:	Alexey Brodkin <alexey.brodkin@synopsys.com>
>   M:	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
>   S:	Maintained
>   L:	uboot-snps-arc@synopsys.com
> -T:	git https://source.denx.de/u-boot/custodians/u-boot-arc.git
> +T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-arc.git
>   F:	arch/arc/
>   F:	board/synopsys/
>  =20
> @@ -162,7 +162,7 @@ ARM
>   M:	Tom Rini <trini@konsulko.com>
>   M:	Ilias Apalodimas <ilias.apalodimas@linaro.org>
>   S:	Maintained
> -T:	git https://source.denx.de/u-boot/custodians/u-boot-arm.git
> +T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-arm.git
>   F:	arch/arm/
>   F:	arch/arm/dts/Makefile
>   F:	cmd/arm/
> @@ -172,7 +172,7 @@ M:	Marek Vasut <marex@denx.de>
>   M:	Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
>   M:	Tien Fong Chee <tien.fong.chee@altera.com>
>   S:	Maintained
> -T:	git https://source.denx.de/u-boot/custodians/u-boot-socfpga.git
> +T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-socfpga.=
git
>   F:	arch/arm/dts/socfpga_*
>   F:	arch/arm/mach-socfpga/
>   F:	board/intel/agilex-socdk/
> @@ -185,7 +185,7 @@ ARM AMLOGIC SOC SUPPORT
>   M:	Neil Armstrong <neil.armstrong@linaro.org>
>   S:	Maintained
>   L:	u-boot-amlogic@groups.io
> -T:	git https://source.denx.de/u-boot/custodians/u-boot-amlogic.git
> +T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-amlogic.=
git
>   F:	arch/arm/mach-meson/
>   F:	arch/arm/include/asm/arch-meson/
>   F:	cmd/meson/
> @@ -251,7 +251,7 @@ F:	include/dm/platform_data/serial_bcm283x_mu.h
>   F:	include/dt-bindings/pinctrl/bcm2835.h
>   F:	drivers/pinctrl/broadcom/
>   F:	configs/rpi_*
> -T:	git https://source.denx.de/u-boot/custodians/u-boot-arm.git
> +T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-arm.git
>  =20
>   ARM BROADCOM BCMBCA
>   M:	Anand Gore <anand.gore@broadcom.com>
> @@ -314,7 +314,7 @@ M:	Stefano Babic <sbabic@nabladev.com>
>   M:	Fabio Estevam <festevam@gmail.com>
>   R:	NXP i.MX U-Boot Team <uboot-imx@nxp.com>
>   S:	Maintained
> -T:	git https://source.denx.de/u-boot/custodians/u-boot-imx.git
> +T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-imx.git
>   N:	imx
>   N:	mxc
>   N:	nxp
> @@ -365,7 +365,7 @@ F:	drivers/misc/ls2_sfp.c
>   ARM MARVELL KIRKWOOD ARMADA-XP ARMADA-38X ARMADA-37XX ARMADA-7K/8K
>   M:	Stefan Roese <stefan.roese@mailbox.org>
>   S:	Maintained
> -T:	git https://source.denx.de/u-boot/custodians/u-boot-marvell.git
> +T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-marvell.=
git
>   F:	arch/arm/mach-kirkwood/
>   F:	arch/arm/mach-mvebu/
>   F:	drivers/ata/ahci_generic.c
> @@ -388,7 +388,7 @@ F:	include/configs/mv-common.h
>   ARM MARVELL PCIE CONTROLLER DRIVERS
>   M:	Stefan Roese <stefan.roese@mailbox.org>
>   S:	Maintained
> -T:	git https://source.denx.de/u-boot/custodians/u-boot-marvell.git
> +T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-marvell.=
git
>   F:	drivers/pci/pci-aardvark.c
>   F:	drivers/pci/pci_mvebu.c
>  =20
> @@ -404,7 +404,7 @@ ARM MARVELL SERIAL DRIVERS
>   M:	Pali Roh=C3=A1r <pali@kernel.org>
>   M:	Stefan Roese <stefan.roese@mailbox.org>
>   S:	Maintained
> -T:	git https://source.denx.de/u-boot/custodians/u-boot-marvell.git
> +T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-marvell.=
git
>   F:	drivers/serial/serial_mvebu_a3700.c
>  =20
>   ARM MEDIATEK
> @@ -415,7 +415,7 @@ M:	Igor Belwon <igor.belwon@mentallysanemainliners.o=
rg>
>   M:	David Lechner <dlechner@baylibre.com>
>   M:	Julien Stephan <jstephan@baylibre.com>
>   R:	GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
> -T:	git https://source.denx.de/u-boot/custodians/u-boot-mediatek.git
> +T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-mediatek=
.git
>   S:	Maintained
>   F:	arch/arm/dts/mt*
>   F:	arch/arm/mach-mediatek/
> @@ -470,7 +470,7 @@ F:	configs/uDPU_defconfig
>   ARM MICROCHIP/ATMEL AT91
>   M:	Eugen Hristev <ehristev@kernel.org>
>   S:	Maintained
> -T:	git https://source.denx.de/u-boot/custodians/u-boot-at91.git
> +T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-at91.git
>   F:	arch/arm/dts/at91*
>   F:	arch/arm/dts/sam*
>   F:	arch/arm/mach-at91/
> @@ -530,7 +530,7 @@ ARM RENESAS RMOBILE/R-CAR
>   M:	Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
>   M:	Marek Vasut <marek.vasut+renesas@mailbox.org>
>   S:	Maintained
> -T:	git https://source.denx.de/u-boot/custodians/u-boot-sh.git
> +T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-sh.git
>   F:	arch/arm/mach-renesas/
>   F:	drivers/clk/renesas/
>   F:	drivers/gpio/gpio-rcar.c
> @@ -558,7 +558,7 @@ M:	Simon Glass <sjg@chromium.org>
>   M:	Quentin Schulz <u-boot@0leil.net>
>   M:	Kever Yang <kever.yang@rock-chips.com>
>   S:	Maintained
> -T:	git https://source.denx.de/u-boot/custodians/u-boot-rockchip.git
> +T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip=
.git
>   # Exclude from N: px5 matches
>   X:	configs/kmsupx5_defconfig
>   N:	px30
> @@ -588,7 +588,7 @@ F:	tools/rkspi.c
>   ARM SAMSUNG
>   M:	Minkyu Kang <mk7.kang@samsung.com>
>   S:	Maintained
> -T:	git https://source.denx.de/u-boot/custodians/u-boot-samsung.git
> +T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-samsung.=
git
>   F:	arch/arm/mach-exynos/
>   F:	arch/arm/mach-s5pc1xx/
>   F:	arch/arm/cpu/armv7/s5p-common/
> @@ -661,7 +661,7 @@ M:	Neil Armstrong <neil.armstrong@linaro.org>
>   R:	Sumit Garg <sumit.garg@kernel.org>
>   L:	u-boot-qcom@groups.io
>   S:	Maintained
> -T:	git https://source.denx.de/u-boot/custodians/u-boot-snapdragon.git
> +T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-snapdrag=
on.git
>   F:	configs/qcm6490_defconfig
>   F:	configs/qcs9100_defconfig
>   F:	drivers/*/*/pm8???-*
> @@ -681,7 +681,7 @@ N:	qualcomm
>   ARM STI
>   M:	Patrice Chotard <patrice.chotard@foss.st.com>
>   S:	Maintained
> -T:	git https://source.denx.de/u-boot/custodians/u-boot-stm.git
> +T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-stm.git
>   F:	arch/arm/mach-sti/
>   F:	arch/arm/include/asm/arch-sti*/
>   F:	drivers/phy/sti_usb_phy.c
> @@ -700,7 +700,7 @@ ARM STM STM32MP
>   M:	Patrick Delaunay <patrick.delaunay@foss.st.com>
>   M:	Patrice Chotard <patrice.chotard@foss.st.com>
>   L:	uboot-stm32@st-md-mailman.stormreply.com (moderated for non-subscri=
bers)
> -T:	git https://source.denx.de/u-boot/custodians/u-boot-stm.git
> +T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-stm.git
>   S:	Maintained
>   F:	arch/arm/mach-stm32mp/
>   F:	doc/board/st/
> @@ -746,7 +746,7 @@ N:	stm32
>   ARM SUNXI
>   M:	Andre Przywara <andre.przywara@arm.com>
>   S:	Maintained
> -T:	git https://source.denx.de/u-boot/custodians/u-boot-sunxi.git
> +T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-sunxi.gi=
t
>   F:	arch/arm/cpu/armv7/sunxi/
>   F:	arch/arm/include/asm/arch-sunxi/
>   F:	arch/arm/mach-sunxi/
> @@ -761,7 +761,7 @@ ARM TEGRA
>   M:	Thierry Reding <treding@nvidia.com>
>   M:	Svyatoslav Ryhel <clamor95@gmail.com>
>   S:	Maintained
> -T:	git https://source.denx.de/u-boot/custodians/u-boot-tegra.git
> +T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-tegra.gi=
t
>   F:	arch/arm/dts/tegra*
>   F:	arch/arm/include/asm/arch-tegra*/
>   F:	arch/arm/mach-tegra/
> @@ -771,7 +771,7 @@ F:	drivers/*/tegra*/
>   ARM TI
>   M:	Tom Rini <trini@konsulko.com>
>   S:	Maintained
> -T:	git https://source.denx.de/u-boot/custodians/u-boot-ti.git
> +T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-ti.git
>   F:	arch/arm/dts/am57xx*
>   F:	arch/arm/dts/dra7*
>   F:	arch/arm/mach-davinci/
> @@ -848,7 +848,7 @@ N:	uniphier
>   ARM VERSAL NET
>   M:	Michal Simek <michal.simek@amd.com>
>   S:	Maintained
> -T:	git https://source.denx.de/u-boot/custodians/u-boot-microblaze.git
> +T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-microbla=
ze.git
>   F:	arch/arm/mach-versal-net/
>   F:	drivers/soc/soc_xilinx_versal_net.c
>   N:	(?<!uni)versal-net
> @@ -856,7 +856,7 @@ N:	(?<!uni)versal-net
>   ARM VERSAL
>   M:	Michal Simek <michal.simek@amd.com>
>   S:	Maintained
> -T:	git https://source.denx.de/u-boot/custodians/u-boot-microblaze.git
> +T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-microbla=
ze.git
>   F:	arch/arm/mach-versal/
>   F:	drivers/net/xilinx_axi_mrmac.*
>   F:	drivers/soc/soc_xilinx_versal.c
> @@ -875,7 +875,7 @@ ARM ZYNQ and ZYNQMP
>   M:	Michal Simek <monstr@monstr.eu>
>   M:	Michal Simek <michal.simek@amd.com>
>   S:	Maintained
> -T:	git https://source.denx.de/u-boot/custodians/u-boot-microblaze.git
> +T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-microbla=
ze.git
>   F:	doc/board/xilinx/
>   F:	doc/device-tree-bindings/video/syncoam,seps525.txt
>   F:	drivers/gpio/gpio_slg7xl45106.c
> @@ -893,7 +893,7 @@ N:	zynq
>   ARM ZYNQMP R5
>   M:	Michal Simek <michal.simek@amd.com>
>   S:	Maintained
> -T:	git https://source.denx.de/u-boot/custodians/u-boot-microblaze.git
> +T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-microbla=
ze.git
>   F:	arch/arm/mach-zynqmp-r5/
>  =20
>   ARM PHYTIUM
> @@ -956,7 +956,7 @@ F:	test/boot/
>   BOOTMETH_ANDROID
>   M:	Mattijs Korpershoek <mkorpershoek@kernel.org>
>   S:	Maintained
> -T:	git https://source.denx.de/u-boot/custodians/u-boot-dfu.git
> +T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu.git
>   F:	boot/bootmeth_android.c
>   F:	boot/bootmeth_android.h
>   F:	doc/develop/bootstd/android.rst
> @@ -990,14 +990,14 @@ F:	cmd/cat.c
>   CFI FLASH
>   M:	Stefan Roese <stefan.roese@mailbox.org>
>   S:	Maintained
> -T:	git https://source.denx.de/u-boot/custodians/u-boot-cfi-flash.git
> +T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-cfi-flas=
h.git
>   F:	drivers/mtd/cfi_flash.c
>   F:	drivers/mtd/jedec_flash.c
>  =20
>   CLOCK
>   M:	Lukasz Majewski <lukma@denx.de>
>   S:	Maintained
> -T:	git https://source.denx.de/u-boot/custodians/u-boot-clk.git
> +T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-clk.git
>   F:	drivers/clk/
>   F:	drivers/clk/imx/
>  =20
> @@ -1025,7 +1025,7 @@ DFU
>   M:	Lukasz Majewski <lukma@denx.de>
>   M:	Mattijs Korpershoek <mkorpershoek@kernel.org>
>   S:	Maintained
> -T:	git https://source.denx.de/u-boot/custodians/u-boot-dfu.git
> +T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu.git
>   F:	cmd/dfu.c
>   F:	cmd/usb_*.c
>   F:	common/dfu.c
> @@ -1043,7 +1043,7 @@ F:	include/linux/usb/gadget.h
>   DRIVER MODEL
>   M:	Simon Glass <sjg@chromium.org>
>   S:	Maintained
> -T:	git https://source.denx.de/u-boot/custodians/u-boot-dm.git
> +T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-dm.git
>   F:	doc/driver-model/
>   F:	drivers/core/
>   F:	include/dm/
> @@ -1067,7 +1067,7 @@ EFI LOADER
>   M:	Heinrich Schuchardt <xypron.glpk@gmx.de>
>   M:	Ilias Apalodimas <ilias.apalodimas@linaro.org>
>   S:	Maintained
> -T:	git https://source.denx.de/u-boot/custodians/u-boot-efi.git
> +T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-efi.git
>   F:	arch/arm/lib/*_efi.*
>   F:	cmd/bootefi.c
>   F:	cmd/eficonfig.c
> @@ -1146,7 +1146,7 @@ F:	include/extension_board.h
>   FASTBOOT
>   M:	Mattijs Korpershoek <mkorpershoek@kernel.org>
>   S:	Maintained
> -T:	git https://source.denx.de/u-boot/custodians/u-boot-dfu.git
> +T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu.git
>   F:	cmd/fastboot.c
>   F:	doc/android/fastboot*.rst
>   F:	include/fastboot.h
> @@ -1162,7 +1162,7 @@ F:	test/dm/fastboot.c
>   FPGA
>   M:	Michal Simek <michal.simek@amd.com>
>   S:	Maintained
> -T:	git https://source.denx.de/u-boot/custodians/u-boot-microblaze.git
> +T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-microbla=
ze.git
>   F:	drivers/fpga/
>   F:	cmd/fpga.c
>   F:	include/fpga.h
> @@ -1171,7 +1171,7 @@ F:	test/dm/fpga.c
>   FLATTENED DEVICE TREE
>   M:	Simon Glass <sjg@chromium.org>
>   S:	Maintained
> -T:	git https://source.denx.de/u-boot/custodians/u-boot-fdt.git
> +T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-fdt.git
>   F:	lib/fdtdec*
>   F:	lib/libfdt/
>   F:	include/fdt*
> @@ -1183,12 +1183,12 @@ F:	scripts/dtc-version.sh
>   FREEBSD
>   M:	Rafal Jaworowski <raj@semihalf.com>
>   S:	Maintained
> -T:	git https://source.denx.de/u-boot/custodians/u-boot-freebsd.git
> +T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-freebsd.=
git
>  =20
>   FREESCALE QORIQ
>   M:	Peng Fan <peng.fan@nxp.com>
>   S:	Maintained
> -T:	git https://source.denx.de/u-boot/custodians/u-boot-fsl-qoriq.git
> +T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-fsl-qori=
q.git
>   F:	drivers/watchdog/sp805_wdt.c
>   F:	drivers/watchdog/sbsa_gwdt.c
>  =20
> @@ -1196,7 +1196,7 @@ FWU Multi Bank Update
>   M:	Sughosh Ganu <sughosh.ganu@arm.com>
>   M:	Kory Maincent <kory.maincent@bootlin.com>
>   S:	Maintained
> -T:	git https://source.denx.de/u-boot/custodians/u-boot-efi.git
> +T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-efi.git
>   F:	doc/fwumdata.1
>   F:	doc/mkfwumdata.1
>   F:	lib/fwu_updates/*
> @@ -1226,7 +1226,7 @@ F:	include/goldfish_timer.h
>   INTERCONNECT
>   M:	Neil Armstrong <neil.armstrong@linaro.org>
>   S:	Maintained
> -T:	git https://source.denx.de/u-boot/u-boot.git
> +T:	git https://git.u-boot-project.org/u-boot/u-boot.git
>   F:	arch/sandbox/include/asm/interconnect.h
>   F:	doc/api/interconnect.rst
>   F:	drivers/interconnect/
> @@ -1237,13 +1237,13 @@ F:	test/dm/interconnect.c
>   I2C
>   M:	Heiko Schocher <hs@nabladev.com>
>   S:	Maintained
> -T:	git https://source.denx.de/u-boot/custodians/u-boot-i2c.git
> +T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-i2c.git
>   F:	drivers/i2c/
>  =20
>   I3C
>   M:	Dinesh <dinesh.maniyam@altera.com>
>   S:	Maintained
> -T:	git https://source.denx.de/u-boot/u-boot.git
> +T:	git https://git.u-boot-project.org/u-boot/u-boot.git
>   F:	cmd/i3c.c
>   F:	drivers/i3c/
>  =20
> @@ -1257,7 +1257,7 @@ M:	Pali Roh=C3=A1r <pali@kernel.org>
>   M:	Marek Beh=C3=BAn <kabel@kernel.org>
>   M:	Stefan Roese <stefan.roese@mailbox.org>
>   S:	Maintained
> -T:	git https://source.denx.de/u-boot/custodians/u-boot-marvell.git
> +T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-marvell.=
git
>   F:	doc/README.kwbimage
>   F:	doc/kwboot.1
>   F:	tools/kwb*
> @@ -1265,7 +1265,7 @@ F:	tools/kwb*
>   LOGGING
>   M:	Simon Glass <sjg@chromium.org>
>   S:	Maintained
> -T:	git https://source.denx.de/u-boot/u-boot.git
> +T:	git https://git.u-boot-project.org/u-boot/u-boot.git
>   F:	common/log*
>   F:	cmd/log.c
>   F:	doc/develop/logging.rst
> @@ -1284,7 +1284,7 @@ M68K
>   M:	Angelo Dureghello <angelo@kernel-space.org>
>   M:	Kuan-Wei Chiu <visitorckw@gmail.com>
>   S:	Maintained
> -T:	git https://source.denx.de/u-boot/custodians/u-boot-coldfire.git
> +T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-coldfire=
.git
>   F:	arch/m68k/
>   F:	doc/arch/m68k.rst
>   F:	drivers/watchdog/mcf_wdt.c
> @@ -1304,14 +1304,14 @@ F:	lib/mbedtls/
>   MEMBUF
>   M:	Simon Glass <sjg@chromium.org>
>   S:	Maintained
> -T:	git https://source.denx.de/u-boot/u-boot.git
> +T:	git https://git.u-boot-project.org/u-boot/u-boot.git
>   F:	include/membuf.h
>   F:	lib/membuf.c
>  =20
>   MICROBLAZE
>   M:	Michal Simek <monstr@monstr.eu>
>   S:	Maintained
> -T:	git https://source.denx.de/u-boot/custodians/u-boot-microblaze.git
> +T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-microbla=
ze.git
>   F:	arch/microblaze/
>   F:	cmd/mfsl.c
>   F:	drivers/gpio/xilinx_gpio.c
> @@ -1327,7 +1327,7 @@ N:	xilinx
>   MIPS
>   M:	Daniel Schwierzeck <daniel.schwierzeck@gmail.com>
>   S:	Maintained
> -T:	git https://source.denx.de/u-boot/custodians/u-boot-mips.git
> +T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-mips.git
>   F:	arch/mips/
>  =20
>   MIPS CORTINA ACCESS CAxxxx
> @@ -1351,7 +1351,7 @@ M:	Weijie Gao <weijie.gao@mediatek.com>
>   M:	David Lechner <dlechner@baylibre.com>
>   M:	Julien Stephan <jstephan@baylibre.com>
>   R:	GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
> -T:	git https://source.denx.de/u-boot/custodians/u-boot-mediatek.git
> +T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-mediatek=
.git
>   S:	Maintained
>   F:	arch/mips/mach-mtmips/
>   F:	arch/mips/dts/mt7620.dtsi
> @@ -1416,14 +1416,14 @@ MMC
>   M:	Peng Fan <peng.fan@nxp.com>
>   M:	Jaehoon Chung <jh80.chung@samsung.com>
>   S:	Maintained
> -T:	git https://source.denx.de/u-boot/custodians/u-boot-mmc.git
> +T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-mmc.git
>   F:	drivers/mmc/
>   N:	mmc
>  =20
>   NETWORK
>   M:	Jerome Forissier <jerome.forissier@arm.com>
>   S:	Maintained
> -T:	git https://source.denx.de/u-boot/custodians/u-boot-net.git
> +T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-net.git
>   F:	drivers/net/
>   F:	include/net.h
>   F:	net/
> @@ -1431,7 +1431,7 @@ F:	net/
>   NETWORK (LWIP)
>   M:	Jerome Forissier <jerome.forissier@arm.com>
>   S:	Maintained
> -T:	git https://source.denx.de/u-boot/custodians/u-boot-net.git
> +T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-net.git
>   F:	cmd/lwip/
>   F:	cmd/net-lwip.c
>   F:	configs/qemu_arm64_lwip_defconfig
> @@ -1444,7 +1444,7 @@ F:	net/lwip/
>   NIOS
>   M:	Thomas Chou <thomas@wytron.com.tw>
>   S:	Maintained
> -T:	git https://source.denx.de/u-boot/custodians/u-boot-nios.git
> +T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-nios.git
>   F:	arch/nios2/
>  =20
>   NVMe
> @@ -1480,7 +1480,7 @@ F:	drivers/net/phy/nxp-c45-tja11xx.c
>   ONENAND
>   #M:	Lukasz Majewski <l.majewski@majess.pl>
>   S:	Orphaned (Since 2017-01)
> -T:	git https://source.denx.de/u-boot/custodians/u-boot-onenand.git
> +T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-onenand.=
git
>   F:	drivers/mtd/onenand/
>  =20
>   OUT4-IMX6ULL-NANO BOARD
> @@ -1551,7 +1551,7 @@ POWER
>   M:	Jaehoon Chung <jh80.chung@samsung.com>
>   M:	Peng Fan <peng.fan@nxp.com>
>   S:	Maintained
> -T:	git https://source.denx.de/u-boot/custodians/u-boot-pmic.git
> +T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-pmic.git
>   F:	drivers/power/
>   F:	include/power/
>  =20
> @@ -1562,13 +1562,13 @@ F:	arch/powerpc/
>   POWERPC MPC8XX
>   M:	Christophe Leroy <christophe.leroy@csgroup.eu>
>   S:	Maintained
> -T:	git https://source.denx.de/u-boot/custodians/u-boot-mpc8xx.git
> +T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-mpc8xx.g=
it
>   F:	arch/powerpc/cpu/mpc8xx/
>  =20
>   POWERPC MPC83XX
>   M:	Mario Six <mario.six@gdsys.cc>
>   S:	Maintained
> -T:	git https://source.denx.de/u-boot/custodians/u-boot-mpc83xx.git
> +T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-mpc83xx.=
git
>   F:	drivers/ram/mpc83xx_sdram.c
>   F:	include/dt-bindings/memory/mpc83xx-sdram.h
>   F:	drivers/sysreset/sysreset_mpc83xx.c
> @@ -1586,7 +1586,7 @@ F:	arch/powerpc/include/asm/arch-mpc83xx/
>   POWERPC MPC85XX
>   M:	Marek Beh=C3=BAn <kabel@kernel.org>
>   S:	Maintained
> -T:	git https://source.denx.de/u-boot/custodians/u-boot-mpc85xx.git
> +T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-mpc85xx.=
git
>   F:	arch/powerpc/cpu/mpc85xx/
>  =20
>   PWM LED
> @@ -1604,14 +1604,14 @@ RAW NAND
>   M:	Dario Binacchi <dario.binacchi@amarulasolutions.com>
>   M:	Michael Trimarchi <michael@amarulasolutions.com>
>   S:	Maintained
> -T:	git https://source.denx.de/u-boot/custodians/u-boot-nand-flash.git
> +T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-nand-fla=
sh.git
>   F:	drivers/mtd/nand/raw/
>  =20
>   RISC-V
>   M:	Rick Chen <rick@andestech.com>
>   M:	Leo <ycliang@andestech.com>
>   S:	Maintained
> -T:	git https://source.denx.de/u-boot/custodians/u-boot-riscv.git
> +T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-riscv.gi=
t
>   F:	arch/riscv/
>   F:	cmd/riscv/
>   F:	doc/arch/riscv.rst
> @@ -1700,7 +1700,7 @@ SH
>   M:	Marek Vasut <marek.vasut+renesas@gmail.com>
>   M:	Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
>   S:	Maintained
> -T:	git https://source.denx.de/u-boot/custodians/u-boot-sh.git
> +T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-sh.git
>   F:	arch/sh/
>  =20
>   SL28CLPD
> @@ -1740,7 +1740,7 @@ F:	drivers/rng/smccc_trng.c
>  =20
>   SPI
>   S:	Orphaned
> -T:	git https://source.denx.de/u-boot/custodians/u-boot-spi.git
> +T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-spi.git
>   F:	drivers/spi/
>   F:	include/spi*
>  =20
> @@ -1749,7 +1749,7 @@ M:	Dario Binacchi <dario.binacchi@amarulasolutions=
.com>
>   M:	Michael Trimarchi <michael@amarulasolutions.com>
>   R:	Frieder Schrempf <frieder.schrempf@kontron.de>
>   S:	Maintained
> -T:	git https://source.denx.de/u-boot/custodians/u-boot-nand-flash.git
> +T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-nand-fla=
sh.git
>   F:	drivers/mtd/nand/spi/
>  =20
>   SPI-NOR
> @@ -1838,7 +1838,7 @@ F:	configs/k2l_hs_evm_defconfig
>   TPM DRIVERS
>   M:	Ilias Apalodimas <ilias.apalodimas@linaro.org>
>   S:	Maintained
> -T:	git https://source.denx.de/u-boot/custodians/u-boot-tpm.git
> +T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-tpm.git
>   F:	cmd/tpm*
>   F:	drivers/tpm/
>   F:	include/tpm*
> @@ -1857,7 +1857,7 @@ F:	include/env/tq/*
>   TEE
>   M:	Jens Wiklander <jens.wiklander@linaro.org>
>   M:	Ilias Apalodimas <ilias.apalodimas@linaro.org>
> -T:	git https://source.denx.de/u-boot/custodians/u-boot-tpm.git
> +T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-tpm.git
>   S:	Maintained
>   F:	cmd/optee*
>   F:	doc/README.tee
> @@ -1881,7 +1881,7 @@ UBI
>   M:	Kyungmin Park <kmpark@infradead.org>
>   M:	Heiko Schocher <hs@nabladev.com>
>   S:	Maintained
> -T:	git https://source.denx.de/u-boot/custodians/u-boot-ubi.git
> +T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-ubi.git
>   F:	drivers/mtd/ubi/
>  =20
>   UFETCH
> @@ -1900,7 +1900,7 @@ F:	drivers/ufs/
>   UPL
>   M:	Simon Glass <sjg@chromium.org>
>   S:	Maintained
> -T:	git https://source.denx.de/u-boot/custodians/u-boot-dm.git
> +T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-dm.git
>   F:	boot/upl*
>   F:	cmd/upl.c
>   F:	common/spl/spl_upl.c
> @@ -1913,7 +1913,7 @@ F:	test/py/tests/test_upl.py
>   USB
>   M:	Marek Vasut <marex@denx.de>
>   S:	Maintained
> -T:	git https://source.denx.de/u-boot/custodians/u-boot-usb.git
> +T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-usb.git
>   F:	drivers/usb/
>   F:	common/usb.c
>   F:	common/usb_kbd.c
> @@ -1932,7 +1932,7 @@ F:	include/usb/tcpm.h
>   USB xHCI
>   M:	Bin Meng <bmeng.cn@gmail.com>
>   S:	Maintained
> -T:	git https://source.denx.de/u-boot/custodians/u-boot-usb.git topic-xh=
ci
> +T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-usb.git =
topic-xhci
>   F:	drivers/usb/host/xhci*
>   F:	include/usb/xhci.h
>  =20
> @@ -1960,7 +1960,7 @@ F:	include/vbe.h
>   VIDEO
>   M:	Anatolij Gustschin <ag.dev.uboot@gmail.com>
>   S:	Maintained
> -T:	git https://source.denx.de/u-boot/custodians/u-boot-video.git
> +T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-video.gi=
t
>   F:	drivers/video/
>   F:	include/video*.h
>  =20
> @@ -1979,7 +1979,7 @@ F:	doc/develop/driver-model/virtio.rst
>   WATCHDOG
>   M:	Stefan Roese <stefan.roese@mailbox.org>
>   S:	Maintained
> -T:	git https://source.denx.de/u-boot/custodians/u-boot-watchdog.git
> +T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-watchdog=
.git
>   F:	cmd/wdt.c
>   F:	drivers/watchdog/
>   F:	include/watchdog*.h
> @@ -1988,7 +1988,7 @@ X86
>   M:	Simon Glass <sjg@chromium.org>
>   M:	Bin Meng <bmeng.cn@gmail.com>
>   S:	Maintained
> -T:	git https://source.denx.de/u-boot/custodians/u-boot-x86.git
> +T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-x86.git
>   F:	arch/x86/
>   F:	cmd/x86/
>  =20
> @@ -2025,7 +2025,7 @@ M:	Tom Rini <trini@konsulko.com>
>   L:	u-boot@lists.denx.de
>   Q:	http://patchwork.ozlabs.org/project/uboot/list/
>   S:	Maintained
> -T:	git https://source.denx.de/u-boot/u-boot.git
> +T:	git https://git.u-boot-project.org/u-boot/u-boot.git
>   F:	configs/tools-only_defconfig
>   F:	*
>   F:	*/
> diff --git a/README b/README
> index 472cf37d9cc9..adc96c3e1fa8 100644
> --- a/README
> +++ b/README
> @@ -54,8 +54,8 @@ Where to get source code:
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
>  =20
>   The U-Boot source code is maintained in the Git repository at
> -https://source.denx.de/u-boot/u-boot.git ; you can browse it online at
> -https://source.denx.de/u-boot/u-boot
> +https://git.u-boot-project.org/u-boot/u-boot.git ; you can browse it on=
line at
> +https://git.u-boot-project.org/u-boot/u-boot
>  =20
>   The "Tags" links on this page allow you to download tarballs of
>   any version you might be interested in. Official releases are also
> diff --git a/arch/arm/dts/armada-3720-turris-mox.dts b/arch/arm/dts/arma=
da-3720-turris-mox.dts
> index 595b4b5abba0..1123a81a1a44 100644
> --- a/arch/arm/dts/armada-3720-turris-mox.dts
> +++ b/arch/arm/dts/armada-3720-turris-mox.dts
> @@ -147,12 +147,12 @@
>   	 * for IO and the rest 112 MB (64+32+16) for MEM. Controller supports=
 32-bit IO mapping.
>   	 * This bug is not present in U-Boot ports for other Armada 3700 devi=
ces and is fixed in
>   	 * U-Boot version 2021.07. See relevant U-Boot commits (the last one =
contains fix):
> -	 * https://source.denx.de/u-boot/u-boot/-/commit/cb2ddb291ee6fcbddd6d8=
f4ff49089dfe580f5d7
> -	 * https://source.denx.de/u-boot/u-boot/-/commit/c64ac3b3185aeb3846297=
ad7391fc6df8ecd73bf
> -	 * https://source.denx.de/u-boot/u-boot/-/commit/4a82fca8e330157081fc1=
32a591ebd99ba02ee33
> +	 * https://git.u-boot-project.org/u-boot/u-boot/-/commit/cb2ddb291ee6f=
cbddd6d8f4ff49089dfe580f5d7
> +	 * https://git.u-boot-project.org/u-boot/u-boot/-/commit/c64ac3b3185ae=
b3846297ad7391fc6df8ecd73bf
> +	 * https://git.u-boot-project.org/u-boot/u-boot/-/commit/4a82fca8e3301=
57081fc132a591ebd99ba02ee33
>   	 * Bug related to requirement of same child and parent addresses for =
first range is fixed
>   	 * in U-Boot version 2022.04 by following commit:
> -	 * https://source.denx.de/u-boot/u-boot/-/commit/1fd54253bca7d43d046bb=
a4853fe5fafd034bc17
> +	 * https://git.u-boot-project.org/u-boot/u-boot/-/commit/1fd54253bca7d=
43d046bba4853fe5fafd034bc17
>   	 */
>   	#address-cells =3D <3>;
>   	#size-cells =3D <2>;
> diff --git a/board/st/common/MAINTAINERS b/board/st/common/MAINTAINERS
> index 0c6db5477252..e87284c6a8b0 100644
> --- a/board/st/common/MAINTAINERS
> +++ b/board/st/common/MAINTAINERS
> @@ -1,6 +1,6 @@
>   ST BOARDS
>   M:	Patrick Delaunay <patrick.delaunay@foss.st.com>
>   L:	uboot-stm32@st-md-mailman.stormreply.com (moderated for non-subscri=
bers)
> -T:	git https://source.denx.de/u-boot/custodians/u-boot-stm.git
> +T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-stm.git
>   S:	Maintained
>   F:	board/st/common/
> diff --git a/board/st/stm32mp1/MAINTAINERS b/board/st/stm32mp1/MAINTAINE=
RS
> index f924e61b3c03..f488361ab472 100644
> --- a/board/st/stm32mp1/MAINTAINERS
> +++ b/board/st/stm32mp1/MAINTAINERS
> @@ -2,7 +2,7 @@ STM32MP1 BOARD
>   M:	Patrick Delaunay <patrick.delaunay@foss.st.com>
>   M:	Patrice Chotard <patrice.chotard@foss.st.com>
>   L:	uboot-stm32@st-md-mailman.stormreply.com (moderated for non-subscri=
bers)
> -T:	git https://source.denx.de/u-boot/custodians/u-boot-stm.git
> +T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-stm.git
>   S:	Maintained
>   F:	arch/arm/dts/stm32mp13*
>   F:	arch/arm/dts/stm32mp15*
> diff --git a/board/xilinx/microblaze-generic/MAINTAINERS b/board/xilinx/=
microblaze-generic/MAINTAINERS
> index 29ed32f78f91..5220a51a5ea2 100644
> --- a/board/xilinx/microblaze-generic/MAINTAINERS
> +++ b/board/xilinx/microblaze-generic/MAINTAINERS
> @@ -1,7 +1,7 @@
>   MICROBLAZE-GENERIC BOARD
>   M:	Michal Simek <monstr@monstr.eu>
>   S:	Maintained
> -T:	git https://source.denx.de/u-boot/custodians/u-boot-microblaze.git
> +T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-microbla=
ze.git
>   F:	board/xilinx/microblaze-generic/
>   F:	include/configs/microblaze-generic.h
>   F:	configs/microblaze-generic_defconfig
> diff --git a/board/xilinx/versal/MAINTAINERS b/board/xilinx/versal/MAINT=
AINERS
> index a13b65661646..07173ee916fd 100644
> --- a/board/xilinx/versal/MAINTAINERS
> +++ b/board/xilinx/versal/MAINTAINERS
> @@ -1,7 +1,7 @@
>   XILINX_VERSAL BOARDS
>   M:	Michal Simek <michal.simek@amd.com>
>   S:	Maintained
> -T:	git https://source.denx.de/u-boot/custodians/u-boot-microblaze.git
> +T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-microbla=
ze.git
>   F:	arch/arm/dts/versal*
>   F:	board/xilinx/versal/
>   F:	include/configs/xilinx_versal*
> diff --git a/board/xilinx/zynq/MAINTAINERS b/board/xilinx/zynq/MAINTAINE=
RS
> index b5b9e2fe40a5..3eb1a451b580 100644
> --- a/board/xilinx/zynq/MAINTAINERS
> +++ b/board/xilinx/zynq/MAINTAINERS
> @@ -1,7 +1,7 @@
>   ZYNQ BOARD
>   M:	Michal Simek <monstr@monstr.eu>
>   S:	Maintained
> -T:	git https://source.denx.de/u-boot/custodians/u-boot-microblaze.git
> +T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-microbla=
ze.git
>   F:	arch/arm/dts/zynq-*
>   F:	board/xilinx/zynq/
>   F:	include/configs/zynq*.h
> diff --git a/board/xilinx/zynqmp/MAINTAINERS b/board/xilinx/zynqmp/MAINT=
AINERS
> index a4527f8959ab..3db240782f4d 100644
> --- a/board/xilinx/zynqmp/MAINTAINERS
> +++ b/board/xilinx/zynqmp/MAINTAINERS
> @@ -1,7 +1,7 @@
>   XILINX_ZYNQMP BOARDS
>   M:	Michal Simek <michal.simek@amd.com>
>   S:	Maintained
> -T:	git https://source.denx.de/u-boot/custodians/u-boot-microblaze.git
> +T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-microbla=
ze.git
>   F:	arch/arm/dts/zynqmp-*
>   F:	arch/arm/dts/avnet-ultra96*
>   F:	board/xilinx/common/
> diff --git a/doc/CONTRIBUTE.rst b/doc/CONTRIBUTE.rst
> index a6e1cd1fb68a..40a409d101e2 100644
> --- a/doc/CONTRIBUTE.rst
> +++ b/doc/CONTRIBUTE.rst
> @@ -19,7 +19,7 @@ projects available to review if you are unsure of expe=
ctations.
>   Repository
>   ----------
>  =20
> -The official U-Boot repository is located at https://source.denx.de/u-b=
oot/u-boot
> +The official U-Boot repository is located at https://git.u-boot-project=
.org/u-boot/u-boot
>  =20
>   Further more detailed documentation can be found at the following link=
:
>   https://docs.u-boot-project.org/en/latest/index.html
> diff --git a/doc/board/intel/slimbootloader.rst b/doc/board/intel/slimbo=
otloader.rst
> index 87d71a55bdc8..a1d9102859b7 100644
> --- a/doc/board/intel/slimbootloader.rst
> +++ b/doc/board/intel/slimbootloader.rst
> @@ -170,7 +170,7 @@ Build Instruction to use ELF U-Boot
>  =20
>      $ python BuildLoader.py build <qemu or apl> -p "OsLoader.efi:LLDR:L=
z4;u-boot:U-BT:Lzma"
>  =20
> -.. _U-Boot: https://source.denx.de/
> +.. _U-Boot: https://git.u-boot-project.org/
>   .. _`Slim Bootloader`: https://github.com/slimbootloader/
>   .. _`Intel FSP`: https://github.com/IntelFsp/
>   .. _`Getting Started`: https://slimbootloader.github.io/getting-starte=
d/
> diff --git a/doc/board/renesas/rzn1.rst b/doc/board/renesas/rzn1.rst
> index e6d636b89e8e..c34c722e3cb2 100644
> --- a/doc/board/renesas/rzn1.rst
> +++ b/doc/board/renesas/rzn1.rst
> @@ -15,7 +15,7 @@ Clone the U-Boot repository and build it as follows:
>  =20
>   .. code-block:: bash
>  =20
> -        git clone --depth 1 https://source.denx.de/u-boot/u-boot.git
> +        git clone --depth 1 https://git.u-boot-project.org/u-boot/u-boo=
t.git
>           cd u-boot
>           make rzn1_snarc_defconfig
>           make CROSS_COMPILE=3Darm-linux-gnu-
> diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockch=
ip.rst
> index f77f1e78f38a..9351a5b8eae7 100644
> --- a/doc/board/rockchip/rockchip.rst
> +++ b/doc/board/rockchip/rockchip.rst
> @@ -228,7 +228,7 @@ U-Boot
>  =20
>   .. code-block:: bash
>  =20
> -        git clone --depth 1 https://source.denx.de/u-boot/u-boot.git
> +        git clone --depth 1 https://git.u-boot-project.org/u-boot/u-boo=
t.git
>           cd u-boot
>  =20
>   To build px30 boards:
> diff --git a/doc/board/starfive/jh7110_common.rst b/doc/board/starfive/j=
h7110_common.rst
> index e9c0ed5b0224..013bab50045b 100644
> --- a/doc/board/starfive/jh7110_common.rst
> +++ b/doc/board/starfive/jh7110_common.rst
> @@ -170,7 +170,7 @@ Build U-Boot
>  =20
>       .. code-block:: console
>  =20
> -       git clone https://source.denx.de/u-boot/u-boot.git u-boot.git
> +       git clone https://git.u-boot-project.org/u-boot/u-boot.git u-boo=
t.git
>          make -C u-boot.git O=3Du-boot starfive_visionfive2_defconfig
>          make -C u-boot.git O=3Du-boot OPENSBI=3Dopensbi/platform/generi=
c/firmware/fw_dynamic.bin
>  =20
> diff --git a/doc/board/ti/k3.rst b/doc/board/ti/k3.rst
> index 21973d53b15f..d3ecaf599094 100644
> --- a/doc/board/ti/k3.rst
> +++ b/doc/board/ti/k3.rst
> @@ -170,7 +170,7 @@ online
>  =20
>   * **Das U-Boot**
>  =20
> -  | **source:** https://source.denx.de/u-boot/u-boot.git
> +  | **source:** https://git.u-boot-project.org/u-boot/u-boot.git
>     | **branch:** master
>  =20
>   * **Trusted Firmware-A (TF-A)**
> diff --git a/doc/build/source.rst b/doc/build/source.rst
> index d21ee055f33c..8407945a13fc 100644
> --- a/doc/build/source.rst
> +++ b/doc/build/source.rst
> @@ -7,7 +7,7 @@ You can download the source via
>  =20
>   .. code-block:: bash
>  =20
> -    git clone https://source.denx.de/u-boot/u-boot.git
> +    git clone https://git.u-boot-project.org/u-boot/u-boot.git
>  =20
>   A mirror of the source is maintained on Github
>  =20
> diff --git a/doc/develop/pytest/usage.rst b/doc/develop/pytest/usage.rst
> index 6002244d6085..a9b8b8bd6101 100644
> --- a/doc/develop/pytest/usage.rst
> +++ b/doc/develop/pytest/usage.rst
> @@ -411,7 +411,7 @@ The board can be switched off now.
>   Examples
>   ''''''''
>  =20
> -https://source.denx.de/u-boot/u-boot-test-hooks contains some working e=
xample hook
> +https://git.u-boot-project.org/u-boot/u-boot-test-hooks contains some w=
orking example hook
>   scripts, and may be useful as a reference when implementing hook scrip=
ts for
>   your platform. These scripts are not considered part of U-Boot itself.
>  =20
> diff --git a/doc/develop/release_cycle.rst b/doc/develop/release_cycle.r=
st
> index a454d3436767..ee77e8827df6 100644
> --- a/doc/develop/release_cycle.rst
> +++ b/doc/develop/release_cycle.rst
> @@ -96,7 +96,7 @@ Previous Releases
>   -----------------
>  =20
>   Note: these statistics are generated by our fork of `gitdm
> -<https://source.denx.de/u-boot/gitdm>`_, which was originally created b=
y
> +<https://git.u-boot-project.org/u-boot/gitdm>`_, which was originally c=
reated by
>   Jonathan Corbet.
>  =20
>   * :doc:`statistics/u-boot-stats-v2026.07` which was released on 06 Jul=
y 2026.
> diff --git a/doc/develop/sending_patches.rst b/doc/develop/sending_patch=
es.rst
> index c3e0ef27824c..0258b1cebe65 100644
> --- a/doc/develop/sending_patches.rst
> +++ b/doc/develop/sending_patches.rst
> @@ -134,7 +134,7 @@ General Patch Submission Rules
>     patches is by using the ``git format-patch`` command. For a patch th=
at is
>     fixing a bug or regression of some sort, please use the ``master`` b=
ranch of
>     the mainline U-Boot git repository located at
> -  https://source.denx.de/u-boot/u-boot.git as reference. For new featur=
es, if
> +  https://git.u-boot-project.org/u-boot/u-boot.git as reference. For ne=
w features, if
>     the ``next`` branch has been opened (which happens with the release =
of
>     ``-rc2``) that branch should be used, otherwise ``master`` is accept=
able.
>  =20
> diff --git a/tools/binman/btool/mkeficapsule.py b/tools/binman/btool/mke=
ficapsule.py
> index 7638c941a8ee..3d3ceb009c15 100644
> --- a/tools/binman/btool/mkeficapsule.py
> +++ b/tools/binman/btool/mkeficapsule.py
> @@ -126,7 +126,7 @@ class Bintoolmkeficapsule(bintool.Bintool):
>  =20
>           cmd =3D ['tools-only_defconfig', 'tools']
>           result =3D self.build_from_git(
> -            'https://source.denx.de/u-boot/u-boot.git',
> +            'https://git.u-boot-project.org/u-boot/u-boot.git',
>               cmd,
>               'tools/mkeficapsule')
>           return result
> diff --git a/tools/binman/pyproject.toml b/tools/binman/pyproject.toml
> index fd43a71b02b5..46204f477ca3 100644
> --- a/tools/binman/pyproject.toml
> +++ b/tools/binman/pyproject.toml
> @@ -20,7 +20,7 @@ classifiers =3D [
>  =20
>   [project.urls]
>   "Homepage" =3D "https://docs.u-boot-project.org/en/latest/develop/pack=
age/index.html"
> -"Bug Tracker" =3D "https://source.denx.de/groups/u-boot/-/issues"
> +"Bug Tracker" =3D "https://git.u-boot-project.org/groups/u-boot/-/issue=
s"
>  =20
>   [project.scripts]
>   binman =3D "binman.main:start_binman"
> diff --git a/tools/buildman/pyproject.toml b/tools/buildman/pyproject.to=
ml
> index 5f5c405afbf0..8a27bbaf1672 100644
> --- a/tools/buildman/pyproject.toml
> +++ b/tools/buildman/pyproject.toml
> @@ -24,7 +24,7 @@ classifiers =3D [
>  =20
>   [project.urls]
>   "Homepage" =3D "https://docs.u-boot-project.org/en/latest/build/buildm=
an.html"
> -"Bug Tracker" =3D "https://source.denx.de/groups/u-boot/-/issues"
> +"Bug Tracker" =3D "https://git.u-boot-project.org/groups/u-boot/-/issue=
s"
>  =20
>   [project.scripts]
>   buildman =3D "buildman.main:run_buildman"
> diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
> index a91a1060cc4f..ebb679a5f466 100644
> --- a/tools/docker/Dockerfile
> +++ b/tools/docker/Dockerfile
> @@ -358,11 +358,11 @@ USER uboot:uboot
>  =20
>   # Populate the cache for pip to use. Get these via wget as the
>   # COPY / ADD directives don't work as we need them to.
> -RUN wget -O /tmp/pytest-requirements.txt https://source.denx.de/u-boot/=
u-boot/-/raw/master/test/py/requirements.txt
> -RUN wget -O /tmp/sphinx-requirements.txt https://source.denx.de/u-boot/=
u-boot/-/raw/master/doc/sphinx/requirements.txt
> -RUN wget -O /tmp/binman-requirements.txt https://source.denx.de/u-boot/=
u-boot/-/raw/master/tools/binman/requirements.txt
> -RUN wget -O /tmp/buildman-requirements.txt https://source.denx.de/u-boo=
t/u-boot/-/raw/master/tools/buildman/requirements.txt
> -RUN wget -O /tmp/u_boot_pylib-requirements.txt https://source.denx.de/u=
-boot/u-boot/-/raw/master/tools/u_boot_pylib/requirements.txt
> +RUN wget -O /tmp/pytest-requirements.txt https://git.u-boot-project.org=
/u-boot/u-boot/-/raw/master/test/py/requirements.txt
> +RUN wget -O /tmp/sphinx-requirements.txt https://git.u-boot-project.org=
/u-boot/u-boot/-/raw/master/doc/sphinx/requirements.txt
> +RUN wget -O /tmp/binman-requirements.txt https://git.u-boot-project.org=
/u-boot/u-boot/-/raw/master/tools/binman/requirements.txt
> +RUN wget -O /tmp/buildman-requirements.txt https://git.u-boot-project.o=
rg/u-boot/u-boot/-/raw/master/tools/buildman/requirements.txt
> +RUN wget -O /tmp/u_boot_pylib-requirements.txt https://git.u-boot-proje=
ct.org/u-boot/u-boot/-/raw/master/tools/u_boot_pylib/requirements.txt
>   RUN python3 -m venv /tmp/venv && \
>   	. /tmp/venv/bin/activate && \
>   	pip install -r /tmp/pytest-requirements.txt \
> diff --git a/tools/dtoc/pyproject.toml b/tools/dtoc/pyproject.toml
> index 53b09dba8859..895bdc9b763b 100644
> --- a/tools/dtoc/pyproject.toml
> +++ b/tools/dtoc/pyproject.toml
> @@ -20,7 +20,7 @@ classifiers =3D [
>  =20
>   [project.urls]
>   "Homepage" =3D "https://docs.u-boot-project.org/en/latest/develop/driv=
er-model/of-plat.html"
> -"Bug Tracker" =3D "https://source.denx.de/groups/u-boot/-/issues"
> +"Bug Tracker" =3D "https://git.u-boot-project.org/groups/u-boot/-/issue=
s"
>  =20
>   [project.scripts]
>   dtoc =3D "dtoc.main:run_dtoc"
> diff --git a/tools/u_boot_pylib/pyproject.toml b/tools/u_boot_pylib/pypr=
oject.toml
> index 1c6a023ee4b3..300d14441c8b 100644
> --- a/tools/u_boot_pylib/pyproject.toml
> +++ b/tools/u_boot_pylib/pyproject.toml
> @@ -19,7 +19,7 @@ classifiers =3D [
>  =20
>   [project.urls]
>   "Homepage" =3D "https://docs.u-boot-project.org"
> -"Bug Tracker" =3D "https://source.denx.de/groups/u-boot/-/issues"
> +"Bug Tracker" =3D "https://git.u-boot-project.org/groups/u-boot/-/issue=
s"
>  =20
>   [tool.setuptools]
>   packages =3D ["u_boot_pylib"]

