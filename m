Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AAB0C55171
	for <u-boot@archiver.kernel.org>; Sun,  2 Aug 2026 07:55:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 88E7280D15;
	Sun,  2 Aug 2026 07:55:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8S6V7dmYS5Xm; Sun,  2 Aug 2026 07:55:25 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4E20E80D02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785657325;
	bh=yXvq43MZnGR/ilcXas46BdH+j6znfT5aZNVonIdtwu8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oeyhEpTrJnvuxvqXpWWdEjWkePORqiKAsMEB6JhjjgLl294DyBVEFGegyOAkt1l1S
	 P79fzwzA6uEz+1Df2oVkNOF/8ad6ObnKzP+oOp57GXh2OZ2XV0b5H779mdsdbZxseD
	 o05IFmRQZmSIzzGK4zaPIISTgieCbs/r1bpl57YuMak01KGjbklfKX3AYAWCEYJ5cR
	 R+dD6hKbs1DJ7M1EmBhtSA6r47TkBKhmCG8KBUlaCOgCkOPcR2cKwmL11ox+66qzDL
	 21LzSYbOD1AFCxwgZ9e2dbBKbU2ziQmKGNm6jVUapm9dpWXD7zi/IijBkrALRmInPh
	 vSXtJE0FqRz+A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4E20E80D02;
	Sun,  2 Aug 2026 07:55:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7B4ED36E
 for <u-boot@lists.u-boot-project.org>; Sun,  2 Aug 2026 07:55:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6232C60672
 for <u-boot@lists.u-boot-project.org>; Sun,  2 Aug 2026 07:55:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0D-hl0Q5Mo-G for <u-boot@lists.u-boot-project.org>;
 Sun,  2 Aug 2026 07:55:22 +0000 (UTC)
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=quwenruo.btrfs@gmx.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 0E7B160659
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0E7B160659
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0E7B160659
 for <u-boot@lists.u-boot-project.org>; Sun,  2 Aug 2026 07:55:20 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB44A844F6; Sun,  2 Aug 2026 09:55:15 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C02D580117
 for <u-boot@lists.denx.de>; Sun,  2 Aug 2026 09:55:11 +0200 (CEST)
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MfYPY-1xRgag3JpA-00eJxx; Sun, 02
 Aug 2026 09:55:07 +0200
Message-ID: <d95529ec-3da5-443b-8c05-776309f06ada@gmx.com>
Date: Sun, 2 Aug 2026 17:25:01 +0930
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs: btrfs: report file sizes from readdir
To: Cole Munz <Munzzyy1@proton.me>, Alexey Charkov <alchark@flipper.net>
Cc: u-boot@lists.denx.de, Marek Behun <kabel@kernel.org>,
 Tom Rini <trini@konsulko.com>
References: <c8e57b678bee2394655ea5e7b0678fb300705e2f.1785649258.git.Munzzyy1@proton.me>
 <CAKTNdwGCYjr+2vaBc6kArQokqTF=Gc23mF17B_22Fdcg1O=7hQ@mail.gmail.com>
 <7bcd492f-7e1e-4fd9-970d-857ca5460ddd@gmx.com>
 <hTFbDtB7gXE4tGU0EwriHsWY9lutwDK1ehYABepLafBuF5IDEY1rjTUVvCFq0HOsdgpfpFHvayOonotnzsuHWxs-FnRFFsnKUKmvGSkQAHI=@proton.me>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1YAUJEP5a
 sQAKCRDCPZHzoSX+qF+mB/9gXu9C3BV0omDZBDWevJHxpWpOwQ8DxZEbk9b9LcrQlWdhFhyn
 xi+l5lRziV9ZGyYXp7N35a9t7GQJndMCFUWYoEa+1NCuxDs6bslfrCaGEGG/+wd6oIPb85xo
 naxnQ+SQtYLUFbU77WkUPaaIU8hH2BAfn9ZSDX9lIxheQE8ZYGGmo4wYpnN7/hSXALD7+oun
 tZljjGNT1o+/B8WVZtw/YZuCuHgZeaFdhcV2jsz7+iGb+LsqzHuznrXqbyUQgQT9kn8ZYFNW
 7tf+LNxXuwedzRag4fxtR+5GVvJ41Oh/eygp8VqiMAtnFYaSlb9sjia1Mh+m+OBFeuXjgGlG
 VvQFzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1gQUJEP5a0gAK
 CRDCPZHzoSX+qHGpB/kB8A7M7KGL5qzat+jBRoLwB0Y3Zax0QWuANVdZM3eJDlKJKJ4HKzjo
 B2Pcn4JXL2apSan2uJftaMbNQbwotvabLXkE7cPpnppnBq7iovmBw++/d8zQjLQLWInQ5kNq
 Vmi36kmq8o5c0f97QVjMryHlmSlEZ2Wwc1kURAe4lsRG2dNeAd4CAqmTw0cMIrR6R/Dpt3ma
 +8oGXJOmwWuDFKNV4G2XLKcghqrtcRf2zAGNogg3KulCykHHripG3kPKsb7fYVcSQtlt5R6v
 HZStaZBzw4PcDiaAF3pPDBd+0fIKS6BlpeNRSFG94RYrt84Qw77JWDOAZsyNfEIEE0J6LSR/
In-Reply-To: <hTFbDtB7gXE4tGU0EwriHsWY9lutwDK1ehYABepLafBuF5IDEY1rjTUVvCFq0HOsdgpfpFHvayOonotnzsuHWxs-FnRFFsnKUKmvGSkQAHI=@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bM2onRFRVJijbtHKFsW9AAJnUhvvJTleQzr972//UFoH/Nq9gaz
 zLYrj/Futt98zPcSWXUI1wLds+CdYezRSEatK6K6A4kYt+WIprcd+MsT0sWVweg45b/dfIh
 Jkhb9yohWWmXrZl4AR/ggUkjKkBuN0uvKrBBhAppmmwL+k38N3zOM2mbi+8kNmsKpNr2SbS
 L//9HDli7nTcORqWMZgxA==
UI-OutboundReport: notjunk:1;M01:P0:s2Msa3MvV58=;mpBMQdX2073keXyhIeOfLcPa5J+
 HaVannpFQ7RjenYQTPpsCiKKoUfe8c0obqUIGwNcQ2LIwk0H+OPEkT04YitYK+syFpiH07wpJ
 uaz8vi+Pgm6PppGp5UHLKKENpSQT/xKvAon+hFF7GMCcfiUsjCxzxwaMg9K2I4pxNOffm+cyi
 zSICUL4mGSBQn/WFAS5+huUBwgIcQrolv1/6K7IAFRhtiLjVUTfEpKKojhrzjuqvGeXp1WUbk
 byeJWupbIC7BgjVPk6c+gBNkch2KJBhK9mhsDIoVZmfAbGk5VW3HcK63IgR1q0eRuOpKUgCLO
 LPP6w8MnycX/fc9N+LlwVpkIHxyXk2StB3skzvonuN2TC7z4INImZMdRV03cqaqeKA4iEaGo4
 Yv00LSHnhJ5+ezs9plyzFUM0iSAUZc09CWF622oYfKS4Q1yEl0sylmHjTIYl77GdtwAikJIES
 WygC0sPfMwYiEXEdkVm8Wq3vvaGLu29HVPusEkN/Ub+NBmvNfjVl/yMGIZumidYIiBjj7agOv
 FlnW2UEDLfd3LF/1IGFCSO1fLFBr+yIKcxKb04uEmPx37S8w97bwFB7JlyP13H2qmq8IKrMR4
 JFTPOP0bOwPGHCXRXxBgllwieFBv61s5Q5Gj+XkYP8gthDm0XbqcEi3VPN1AVuzz9FCY/KQXk
 CuPgBbRY/K/SkXAiKFoWlejJSjJl5uKuvHoK/nexHdZYwQRG0G8A//Q6GfaX4QNIP6qKlvvS7
 YjtZFSNGsqpcKxm3RzI+RRLuTYlJo8Pi+MlYLmFfGd6mXCyAudMLQ+CLfpbP51LFKRctoBLnm
 7W76VbXJvbVnDF0BBuv5UhUDLei9uKoAVEZVJSJpkjMHJQVTRPctiRD1YCVYLY57vUsYixn/I
 gVuipqw8XnY4OZzueNw0VXOqiMYqCxkebWs5dOi8p3YlmAyYSDwPrmZ4+wkgKcCWvRNR8Apwp
 iTjAtkIUsDicYTpT8NRppSGK/oNRtPSy1iPFacfcVJEiPcK35RfXJ5A96eDe7YWFKi+ycvw/M
 OzR+wedtXv7sr+jK2rbsRXGu6ZWcYzAeudq82P7wViN4w1zgWmPEx6hOp64Fz9x+AKYFm0Zya
 RoIUQgX4pFZ5FqY/QD5DlnJ3lv12DAAuY/Q5e1oVrK6HBCXvtF4kugMlX7V+iAZ3iPVS650sK
 gOMB3pnMKmmHHJ4zkoObCo1JjphKhyei30sXHA1u7hmcwZONBATiZKTU0TWwxPLB62gZi3i7a
 RIFkUT8eH32QXVIgP68EnwynqZ3zKmkpm7Q0Y+gppZerYYYSw1GTH5ttLbDLzBrZCcSf5Khty
 /mXFgnipRi8UzykMxQUulGRNVYxFmJYvX/R4pwMgd1CUh8d5l+YIOy+HlWCmeul5hYJoCjrcM
 is/bUYDyG+2D97+ns1FoPhvhPeh+0Btcm1fv10SCkDgAR5NuJmB/yFK7XYLRwq9IEWofXWo3D
 XY8ewCvHlpwQtvzN+MXi1sjkPXB7Qnjl2ODAodIs6Y6zP7PNYfU/qzoC2lgJYhq/0XNTzVIBc
 96RFahOj7BDHlkyMcI3vvAu7z/zXopD6pwSCUz3xI2hB37LaoxQEeHwp04/ho5RgynQl1AH/2
 XRHJLm+6bYiy76Zj46VijNG7HH/99M8rvQMMJBsZCYp/+P1U36BTYsLqtEUf/H3EpV63lsrN9
 50dGoVk6G1Kfuzta+OgI8A/JE8oOjaXokcXgobr4awPRnifTXn8eYoLFR0B5suwVsw6Li76mW
 R1iiIZM5xs1hjNI9sAeTOtdqCTRMq0OeoQ8gH4+xef/DjrRsXVrCjlOinh0j/Xc0tHL0/sVY5
 m6q3ToRUg3b/z4UPO3V1wB6HcFdLLOdTU9NGK3uOecj5KgyoYVhhxt/hH4ToRe6+BULcLJJ1m
 82jX2ZurDRIvbxPhrEmwas6dtjO1EFHuR9S62H+ivDQx5Rk3l3mEhKlXp/lP1RtCREeamWbsK
 wp1+9/qubECjkebHasOILsf0h0tVTD3JhmVvlu4VOINJLMws/jHcZLCP4U2vZvKKRp1AbCZ5M
 CoN5lhcYXCPaTPo+DZneTsZyeM370IEYEtx2vyXBKX/y2vwGh3CNn6BRbfPIbSSqsKWzoolIy
 xugglRLlWE1SgWbezukiCaLVBo6uFSlCXc7VxiJoI1f+k7+HtA9zULZhxkjao39S2tnXx3nVw
 QD5ZajIR+jYEgn32FVihs/7QAB37PsF5vHLmKwEUAohFJc43uEt4XruQ6V3MTktP3/7PsjMs6
 OMrAAhLYAiAtd8IsDFeANYyZxnd+9srcw7iRT8I67ikj7n1a0hDnBslP7LRo+PndnC+2dBdT+
 Zn2JYffp7oOYh7H4+/EeCXSohyMyZqMDckL4hFLQmdLV+kK54oOTgGUNvOpjbXA7xlNKCXUBz
 YLvPzL4VQvxXsfpq/4MxzAO2A9q6YwhtZg+g2hSFEfU/adJeTumzfITUmOSAYQV636JIWx7Fp
 9d1MUAfScN/Oio8p0ufYkknRhNcbZ04h/8v2wsSEjqvZl7tghU+MmKm1VoP4RWWM+aYbnkmEe
 +alvT+WnqnuBgjXJlWz6lQ4wor7OKgpHuIdVZuShT2Qv0qpUXId+JHM3HPzy+2dhBrl8IcMLC
 Pz+Ik01zsALSGFDuk/x/y9aiwCdc17iMMpLDRQfvA6UjYB4kboz7kMbNvfXo3NrY7a0K6NVyL
 aUQA0U/++nFjcHQ2/Y0Cx2UfoLjfP24Z8WMcharJYQWWFl3UNswFiGK0KLioGyQBnqFqy1N+v
 3gKZid33ktO22HzoblcM34PRqhJL23sPRqF1A77HnDL8H5jDzS0iR6X2/Hc+e5elE65Balpzb
 FNh3SQRXbXUKEJaC6+WLCciDtYboXAJnvUffmpizbjm9IXy/59wAUdZ8zHb7ndlPagNRegqeg
 PbvBQK9n1yQ1HvJ7vv/GepGQ0t6vdDnZZ+CD1D+mK9U0EfjImFJbg1TYSWBGdOjBAJZQFpaKQ
 svfYCpys0jywM0rVPDHmxS6hE6fU73O89wfse5q0Kn4kf6GP89HtJeM+Z6XLM9chw+KVCA50H
 TGOM+NZsC6tFLDiLMnOdvNc8/w5RP4zSU8WowQLYXinkKXy5iD6LvWPGBCtTjT7/O4AGEH4Tr
 351hMaCNHJU8JgM31B+YuxgKO7e/e/Rx7c+v476Iu3tU1PCUK1UnVCPxj0HaCQ748RoDAdFOE
 Cn2Z85alzCvGCupELOaf+OhglDBfwna/t7ZniHcRp6D59epfBZrqUn1Om7w9o42/SvjrhBCXV
 /ktpzk4Wm9xxerEO7R8AiVGR8ESGZloiALz0OUtBwU3QwqB+PBUIlnFeawg+e2Rfi9tMPTBmd
 vZL4AM+xXJDXfAlkg1QH9j3BMOIgwav8NUijOillBOFK7iRGfQFF44KZJHPDZaMKIuNC0jkBr
 vHBnb04vx8FS4A3m49bl9cs8t9mJUq4BhoHVsLmjlQqAkgl4up4GPvT35vb7kNvxwtHO0h4OU
 H+dU0FLWXXMknYHXfddSuPKSwBy58vvjcokHmm10FnHJVgB2VjQmf59FMLPfQ6qOmdm68zwjC
 BLEyZeTRFdPz5NQU2nW3uwpFKA2uf5/viM6eVvcq2WXwEGlZYWzgBQIgBTn5TCnPZtMtXoyhD
 OgvdgUBDTv7PRiWSRjs1RN/pajx5g8s5Ny23rUQCkz2gvKEGI60VFVQYasy7CEBkbmwZ6NiDA
 ywIoQrTY87U8DlzOqnZMdfqnW1OfEDwp6/sDhyOabCJ789+yKbxpWx6bJs3R4cvPLWzwyZrjL
 HVQLsEf3Cw7rAFUnHJxAIiZfkpinf2m292kYfE762tFWxKlXGgw2Dv5qPw6lbgqzfg3/fGqvo
 G7bIIce9vj+jLkHXNx/6T19cYksjjnvqy3hEpmhMtM+XXT6sG4/YGl9w4lejSDp01yDwEI4a0
 mkqV+Q5RWFUjcaxk/17NPlt7ABPX+cARyjfCfUvTehTh2hA4KNdrLNwRc+C1GfPok+mF9hSo3
 Tv+EtkGc3MyR4q6ocKqVFBP6apx8XKG4cmMmu/4Gj9IkMJ/SqHWAdy/IfPHXRnjDd1I13nAp9
 D4XGel+5vvBt7UE3a8crEwBnvm1s6ots8nx3mKhORenjei70J0o2oS4Qnnpp+cUsX1zcxc0js
 QZW4dDdUUytcRroBvbT3WjM/4WQqk3Z7/urLcLYz6qtdgi7JSW7wRRQuvO6+KgDJz7wem9IZB
 bxR/cVypG0OfP3RCcEmcWw5+6/f07MjC1P9wWm6jlu9trKBC33t8Omm9R4L03xUpV0EgyhYiy
 SYcZ7gn6XMyB5Hv4kQpNZrjQxon0gu3TiVyY/OZ4jswdoaM1wU9w7cThI/jglY90WOLIy6cYE
 z2o0mJesblkya/S7wOB4njdyCrIggCcw7FwrkCPPaAPBGNWt+So7Mzw/WEGUaRsRjo6nSaJhP
 2upX/Pl90PzsK7ZNCbf3YVWQOUzPtEVe45pv+kJHWtZh3olLzRpk0QZGa/ypBq96Mc9br8JBX
 Lv5A1jz3zTCUoE0ykyNwmncaw3eOCpgojhKhHdObaBorgFn/q97k53xtNIaoas1vUbU1Wkupc
 c9QG2B2bMZKlbw/LKAKq0umttnFSQoOowVaMP9PV0UmtEgmScfMVx4/es4N2/znJLneC0V1k0
 VedRxZkLzFTFVh0qeMi1Ask8nyk40e1/CdkbktTthS5ds0uh1HGmMeXb/SqBedDNfqGPt0I9S
 FGSOhfH3d2Ml54jMssq7rbuIE4c25p0uoy8jXiyGeBr1Dcr0xR5/8XJ5g/CZVt3vL53Z24vkM
 O/4yxvaxCmpUVf5h89/NvUhbyRx9dswApb0EKVqSpNMgrnYDCHtrcuOKbzX5x20hCnevhSY36
 7lBwiynRiZtGA45CBJDDwgzdxuK1bwPVYL+BEUpIpCvgw2klH75In159cZhtneTzraXd7+kFb
 j/falhXp0OEavOpr0tZNDqmnaEsCROZ2IeJI9JP8CvcVWP3ALcilGq0N3XrbY+3b9cnTAg9Gw
 9c5m4oDTk9+bCVHXYhqD4Wwp7H8UYT75ooq6yQLyeyUblGU1mLboFkLiXgsa/8/DfmUEIuMe7
 NBjbOyf3iU9SliO4GrQGac6A2dQC9LvES80PpzeSuwgqGY7vVZ6xXnt74F3p8M+d7NaLzQ5Xa
 UzkmjYOjjKudGTUAGvp5yb+L/VsSQvhTFxLefpkK/Rh9CIHMWnt7tu7IrCxic1XngcgmdSwoB
 UDbqEOGsFNA5Y1uzngqQ7Fa0JJpS5pFvEQMUoO4Je3+khngJPwVXpiR/zCDviXxEeB1nbYXyb
 bj7XLHkTpiMtu8U7VE2PeP87PGiJAkCzE0ohzE9zgXLFsgI1mV698Q9tH2ZOfHselydFjpwez
 37o1a2uB5RjzTxVlfC0TqWFAIhfpqVuuI3AX/qsH01UwkKetCIYxmHoiiwm2svKNcWAEwFgc7
 EmmjjMQG7nGSmdaxY4+w8O4BmKvrDIp+eff9R7turS+23MKviqO409DKAX4k7BVi2XFJVpmQI
 LnJi+aF8jko76iloGmc8xPySbOAPdhDDEPx0d67Da7SfUisA2CHJjVXae3tfBa4S7Nsn63Slf
 oDZ5b9/uRdmLY4hWalCfyCH8mJTnhBDM67O+7prb5rWfqTgRHeNUMWgl5zVuN2ZatkEu4LZV7
 g7G2gt+aTDsPNVjc2YiV2e0A4f76U/qK5hrqk3tMhJj83MrNTw9PC3A/jmzAUEWTaT6JAN8Fr
 Du+qK5omfqD/h1jnl0wwlXCjOOqbzFDsvXNQfZxKf6FinO6WnOBirvSoLsaRJRbE5CREQLBTs
 uwLqMYc4tkNJFpYxnq/iRjEB0Cq2z6lOkB7lnV/HZ4Q==
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmx.com; 
 s=s31663417; t=1785657307; x=1786262107; i=quwenruo.btrfs@gmx.com;
 bh=yXvq43MZnGR/ilcXas46BdH+j6znfT5aZNVonIdtwu8=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=ZqcqMKHnSTc5JmFoMb8zKAkpaqi7sIu2AvOPbuw8cMUy/+6uSjkPvBBV1DIzef6y
 oZUAhUMQwVONxGuPrLmg0EWA51vG9QoCCQeNC4GiPWoV91Kx1pYml7kDGl/vPdDZ7
 85SEgzTFpGKzn8ZAHBmYSxJYxagZD0al67uw97yS3+Z+fSMh2oRy97QSOWewiRvdM
 hYb4vm2risCzjALtSjCN1WJx5JUX77A7NttRClux6qkWu/gcf8PdeKr8ADhUy+yLg
 mgHGnvxcelnMlxzkUFwMx7z72uW9xM6IW+8ZVm0Mkz86jl1D1yld7Fo1YGhbx5yfR
 AeedeapSD2GgMCIP8Q==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=gmx.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 spf=fail smtp.mailfrom=gmx.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com
 header.a=rsa-sha256 header.s=s31663417 header.b=ZqcqMKHn
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=gmx.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quwenruo.btrfs@gmx.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 secure) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="ZqcqMKHn"; 
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
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>



=E5=9C=A8 2026/8/2 17:07, Cole Munz =E5=86=99=E9=81=93:
> On 2026/8/2 16:17, Qu Wenruo wrote:
>> The function btrfs_read_next_dirty_entry() is search the key inside the
>> parent directory.
>>
>> Meanwhile this one is search for the inode item of the child entry.
>>
>> They are completely different and I didn't see why "refactor" can impro=
ve.
>=20
> Right, the two searches are for different keys and cannot be merged.
> The repetition v2 removes is elsewhere. btrfs_size() open codes the
> same inode item search, and its error path never releases the path.

OK, the u-boot's btrfs_search_slot() is different from kernel and progs,=
=20
that on error it doesn't release the path.
So indeed we need to properly clean it up.

Although I'd prefer to change btrfs_search_slot() in u-boot to follow=20
the same kernel/progs behavior.


For the new helper, btrfs_get_inode_size(), is indeed called in both=20
btrfs_size() and btrfs_readdir(), so there is indeed some duplication.

> That leaks the extent buffers btrfs_search_slot() attached before
> failing. So v2 mixed a cleanup into a fix, which was the real
> mistake here.
>=20
> How about a v3 with the fix back in the v1 shape, plus a second patch
> for the btrfs_size() helper and the missing release?
>=20

That sounds very reasonable to me.

Thanks,
Qu
