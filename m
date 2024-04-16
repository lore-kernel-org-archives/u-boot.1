Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18A04C4345F
	for <u-boot@archiver.kernel.org>; Tue, 16 Apr 2024 23:24:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 860F58836E;
	Wed, 17 Apr 2024 01:24:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="bdkfanmy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B28888390; Wed, 17 Apr 2024 01:24:07 +0200 (CEST)
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1531288369
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 01:23:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jh80.chung@samsung.com
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20240416232356epoutp0339c1cac32c4d5d2a91c2ae3bfa966a98~G5jgezx771119711197epoutp03T
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 23:23:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20240416232356epoutp0339c1cac32c4d5d2a91c2ae3bfa966a98~G5jgezx771119711197epoutp03T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1713309837;
 bh=NqlYvHzZ4L17WyE5CqKaU+HcUeuu+gHS0gtzCRIiP1g=;
 h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
 b=bdkfanmyMYjS8FsG1wloDl8E8T6sEV5NrkQqzB2lyL0KVZOgYJUF1wF7Oshn8mK11
 cFwzsM6ZaK0S5oxIClRq8wjkoEcr9caOF+4ozORThqb8j879Dj0c/HKs7Ff3mewpMw
 UpkB4dXLiES0/HJTMtni57SYlbjyQD02+z8KNVSQ=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
 epcas1p2.samsung.com (KnoxPortal) with ESMTP id
 20240416232356epcas1p2c5d82693f37e0afeba00e8acccfbdb2a~G5jgA-_Tm0630906309epcas1p2H;
 Tue, 16 Apr 2024 23:23:56 +0000 (GMT)
Received: from epsmgec1p1.samsung.com (unknown [182.195.38.237]) by
 epsnrtp3.localdomain (Postfix) with ESMTP id 4VK0V33c9gz4x9Pw; Tue, 16 Apr
 2024 23:23:55 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
 epsmgec1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
 87.16.09696.B880F166; Wed, 17 Apr 2024 08:23:55 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20240416232355epcas1p2dffde88099e00b7e9181a5ee2447c738~G5jexgjCb1329613296epcas1p2D;
 Tue, 16 Apr 2024 23:23:55 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20240416232355epsmtrp1585170f8ace7adb07537a2b752389ab6~G5jewvRnl1142511425epsmtrp1h;
 Tue, 16 Apr 2024 23:23:55 +0000 (GMT)
X-AuditID: b6c32a36-7a9f9700000025e0-7f-661f088b7b54
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
 81.0D.08390.A880F166; Wed, 17 Apr 2024 08:23:55 +0900 (KST)
Received: from jh80chung01 (unknown [10.113.111.84]) by epsmtip1.samsung.com
 (KnoxPortal) with ESMTPA id
 20240416232354epsmtip17d438c0f2ab1e8264908daba0147c44b~G5jejTbIE2632726327epsmtip1w;
 Tue, 16 Apr 2024 23:23:54 +0000 (GMT)
From: "Jaehoon Chung" <jh80.chung@samsung.com>
To: "'Quentin Schulz'" <quentin.schulz@theobroma-systems.com>, "'Jonas
 Karlman'" <jonas@kwiboo.se>, "'Peng Fan'" <peng.fan@nxp.com>, "'Tom Rini'"
 <trini@konsulko.com>
Cc: <u-boot@lists.denx.de>
In-Reply-To: <496013c1-7a57-4d12-bf31-c5257f35ee8c@theobroma-systems.com>
Subject: RE: [PATCH 1/2] mmc: Imply HS200 cap with mmc-hs400 prop to match
 linux
Date: Wed, 17 Apr 2024 08:23:54 +0900
Message-ID: <000801da9055$2641fe50$72c5faf0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQH4WoF6XMPcZuGkh8wOOqd8YokilwIb6NJ6AaZfHMuxEeKP8A==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIJsWRmVeSWpSXmKPExsWy7bCmgW43h3yawcvzEhYn31xlsfix6gur
 xeoH+1ktpk7azG7xdm8nuwOrx6sDq9g9Tky4xORx9s4ORo+N73Yweax9tIElgDUq2yYjNTEl
 tUghNS85PyUzL91WyTs43jne1MzAUNfQ0sJcSSEvMTfVVsnFJ0DXLTMHaLuSQlliTilQKCCx
 uFhJ386mKL+0JFUhI7+4xFYptSAlp8C0QK84Mbe4NC9dLy+1xMrQwMDIFKgwITtj9oc77AW9
 QhXLpxxlbmCcw9fFyMkhIWAise/va1YQW0hgB6PE96eaXYxcQPYnRonWlQuZIJxvjBLzr65n
 hOm48/U8M0RiL6PEj+fTWCGcl4wSd9a+AatiE9CT+L9oIViViMAqRon3C5vZQBLMAlISTSd3
 gRVxCnhK7Dl+hwXEFhYIkuiZfxjMZhFQlfjR8ZgJxOYVsJT4ff0yI4QtKHFy5hMWiDnyEtvf
 zmGGOElB4ufTZWBPiAg4SWxcOBdql4jE7M42sCMkBFo5JCav38wE0eAi8XfBf3YIW1ji1fEt
 ULaUxMv+NnaIhmZGiaVLDrJCOD2MEv8arrNBVBlL7F86GWgSB9AKTYn1u/QhtvFJvPvawwoS
 lhDglehoE4KoVpG49PolE8z8u0/+s0LYHhLnX3SyTGBUnIXkt1lIfpuF5IdZCMsWMLKsYhRL
 LSjOTU8tNiwwgsd3cn7uJkZw2tQy28E46e0HvUOMTByMhxglOJiVRHhbhGXThHhTEiurUovy
 44tKc1KLDzGaAkN7IrOUaHI+MHHnlcQbmlgamJgZGZtYGJoZKonznrlSliokkJ5YkpqdmlqQ
 WgTTx8TBKdXAlO0UwDbvyrGmyOjuq2qBIhonv+6ZfnlG0drG2f6nZmtu03qwNeRcyG/3yy0h
 98OM53W8UQ1bpSuuayaTMcHzV5+p+KnVwWkXLsxiW7VOa7XA8afKi+X0frxMLvl99YDEyYrA
 iZMOLFnJJK/4/kP5zvufXTLq/gU+OKk1L+Pokk9FEsefn/IMWu+idlX97RzGo6Yr9Jfs09oj
 ftlJWKRD4T6X7nUha4nXD9dp6shM/mDBsc5y0WyzuceNjjKV8Qtf+xxw4VNmaq3N5lO8q1Tq
 FnkpP2Y1kwjWKxDYUiYlztnUl5S6ZE9jHQefo/a90n/BK17vEuVVblFvEmmL71V5HCwgbclp
 dF49L9Gzt++TEktxRqKhFnNRcSIAo7hKiCQEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFLMWRmVeSWpSXmKPExsWy7bCSnG43h3yawf8ci5NvrrJY/Fj1hdVi
 9YP9rBZTJ21mt3i7t5PdgdXj1YFV7B4nJlxi8jh7Zwejx8Z3O5g81j7awBLAGsVlk5Kak1mW
 WqRvl8CVMfvDHfaCXqGK5VOOMjcwzuHrYuTkkBAwkbjz9TxzFyMXh5DAbkaJWSd3MUIkpCQ+
 P53K1sXIAWQLSxw+XAxR85xR4sHulWwgNWwCehL/Fy0EaxYRWMMosW7ZJbAEM1BzE9ggkI6j
 jBIzdv4Em8op4Cmx5/gdFhBbWCBAov3sCbAGFgFViR8dj5lAbF4BS4nf1y8zQtiCEidnPmGB
 GKot8fTmUyhbXmL72znMEJcqSPx8uowVxBYRcJLYuHAu1BEiErM725gnMArPQjJqFpJRs5CM
 moWkZQEjyypGydSC4tz03GLDAqO81HK94sTc4tK8dL3k/NxNjODo0dLawbhn1Qe9Q4xMHIyH
 GCU4mJVEeFuEZdOEeFMSK6tSi/Lji0pzUosPMUpzsCiJ83573ZsiJJCeWJKanZpakFoEk2Xi
 4JRqYJpzsf9PlsK24/URH2QtdH5US0zZ9PX179+X2ORjSnqftisxPc3J/fWh4KiSxlWR/WZe
 TVqmPlqhHQG3Nn3rnXlOYIXDM41bLw7G8xYczFSStFQ71NWoJ79r6cI+2dhlO/uKK712THt7
 lO/jlzvymVxXcrMqy3vNNq9aIBlflHwlW65s55XwLZJXPth43Tq17fqz+flzTkzPi7Y8+GZO
 T/iq/cu7vCPmHuLb+m1WfsuL/Jgf3ixfvuwTZ1e2Zt6i3CeZfdDrbbfRubYjaXclldyPGz/4
 dUeRKc3i+MwEdxufkI6vUl9PuHn8kE1fOr2rTvh+9IzbtRm1gj/DTd3quOu0DuaciWCecqLu
 4CGm/0osxRmJhlrMRcWJAIUyz5INAwAA
X-CMS-MailID: 20240416232355epcas1p2dffde88099e00b7e9181a5ee2447c738
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240409152724epcas1p4da03e6022a7b60731008924b514401c0
References: <20240408210619.3749231-1-jonas@kwiboo.se>
 <CGME20240409152724epcas1p4da03e6022a7b60731008924b514401c0@epcas1p4.samsung.com>
 <496013c1-7a57-4d12-bf31-c5257f35ee8c@theobroma-systems.com>
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

Hi,

> -----Original Message-----
> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> Sent: Wednesday, April 10, 2024 12:27 AM
> To: Jonas Karlman <jonas@kwiboo.se>; Peng Fan <peng.fan@nxp.com>; Jaehoon Chung
> <jh80.chung@samsung.com>; Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de
> Subject: Re: [PATCH 1/2] mmc: Imply HS200 cap with mmc-hs400 prop to match linux
> 
> Hi Jonas,
> 
> On 4/8/24 23:06, Jonas Karlman wrote:
> > eMMC nodes in linux device tree files typically only contain a mmc-hs400
> > prop to signal support for both HS400 and HS200. However, U-Boot require
> > an explicit mmc-hs200 prop to signal support for the HS200 mode.
> >  > Fix this by follow linux and imply HS200 cap when HS400 cap is signaled
> > using a mmc-hs400 prop.
> >
> 
> Technically speaking, the DT binding should be the one and only source
> of truth and should be implementation-agnostic.
> 
> There it says:
> """
>    mmc-hs400-1_2v:
>      $ref: /schemas/types.yaml#/definitions/flag
>      description:
>        eMMC HS400 mode (1.2V I/O) is supported.
> 
>    mmc-hs400-1_8v:
>      $ref: /schemas/types.yaml#/definitions/flag
>      description:
>        eMMC HS400 mode (1.8V I/O) is supported.
> """
> 
> So I'd say, the DTs should be fixed to add mmc-hs200 as well wherever it
> makes sense.
> 
> The point of the DT/DT binding is to be system-agnostic and
> representative of the **HW** implementation. At least that's what the DT
> people want it to be.
> 
> If the eMMC standard doesn't allow to have HS400 without HS200, then I
> think this change is acceptable as is, because it is the reality of the
> HW standard. Couldn't find this implied in the standard though (but I
> just skimmed through).
> 
> It's also quite surprising, as it's not because the eMMC works with
> HS400 that it necessarily does with HS200 or that it's desired (EMI,
> signal integrity/stability, etc...)?
> 
> Now, it wouldn't be the first time U-Boot follows whatever is done in
> Linux, so... up to you/the maintainers :)

I want to follow the linux kernel. 

> 
> Reviewed-by: Quentin Schulz <quentin.schulz@theobrma-systems.com>

Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>

Best Regards,
Jaehoon Chung

> 
> Cheers,
> Quentin

