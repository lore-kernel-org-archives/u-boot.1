Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15D3DC4332F
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 05:04:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20EFD87ACB;
	Tue, 31 Oct 2023 06:04:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="cn6PM8iQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B328A87ACB; Tue, 31 Oct 2023 06:04:15 +0100 (CET)
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C34387AC7
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 06:04:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jh80.chung@samsung.com
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20231031050409epoutp04897feb7a532e4021ec51208d4f973e9e~TGLTlhMEQ1304413044epoutp04y
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 05:04:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20231031050409epoutp04897feb7a532e4021ec51208d4f973e9e~TGLTlhMEQ1304413044epoutp04y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1698728649;
 bh=Wm8OUFeYQmpaUHWn7R82vI9P+m2HZD+pOcKlI/TKdwM=;
 h=Date:Subject:To:From:In-Reply-To:References:From;
 b=cn6PM8iQ38N9UimlBwqUlBO1n1pSowuvGuDT+jMugpSeeJqpAhaU+D0+Vvaq+Cu2X
 IxlkaX3e8wa5w+vrzi6G/nALSc3ftP6UBgU2YXFeemh8UvEeuBect1IBTBDfR+dkmm
 8xNv0KDolSou0BZ5pbdHC6SoiAZyeMYG7qrwRRo4=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
 epcas1p1.samsung.com (KnoxPortal) with ESMTP id
 20231031050409epcas1p12c96d8e9995f2aed77c5bd75d833c537~TGLTSh1ya2367623676epcas1p1O;
 Tue, 31 Oct 2023 05:04:09 +0000 (GMT)
Received: from epsmgec1p1.samsung.com (unknown [182.195.38.232]) by
 epsnrtp1.localdomain (Postfix) with ESMTP id 4SKJ2b73sZz4x9Pr; Tue, 31 Oct
 2023 05:04:07 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
 epsmgec1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
 AE.8F.09731.7CA80456; Tue, 31 Oct 2023 14:04:07 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20231031050407epcas1p250bf5bb525b416e61ca4b9a2425a30b8~TGLRwejN52477724777epcas1p2F;
 Tue, 31 Oct 2023 05:04:07 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20231031050407epsmtrp25973a18f30fa2772cb9eb4d9b13e7c52~TGLRv516C1485014850epsmtrp2m;
 Tue, 31 Oct 2023 05:04:07 +0000 (GMT)
X-AuditID: b6c32a36-2ef8ea8000002603-b5-65408ac7726c
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 C8.3A.07368.7CA80456; Tue, 31 Oct 2023 14:04:07 +0900 (KST)
Received: from [10.113.113.235] (unknown [10.113.113.235]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20231031050407epsmtip1e8931a007f5a5caa863fa189e983fe73~TGLRlGNNJ1482814828epsmtip1g;
 Tue, 31 Oct 2023 05:04:07 +0000 (GMT)
Message-ID: <539140a0-3f14-4247-a802-be488b28ade5@samsung.com>
Date: Tue, 31 Oct 2023 14:04:07 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] power: mp5416: Fix LDO SVAL for MP5416 PMIC
Content-Language: en-US
To: Sidharth Prabukumar <sidharth.prabukumar@gmail.com>, u-boot@lists.denx.de
From: Jaehoon Chung <jh80.chung@samsung.com>
In-Reply-To: <20230924223022.313107-1-sidharth.prabukumar@gmail.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIKsWRmVeSWpSXmKPExsWy7bCmvu7xLodUg4vXLCyevV7FZvF2bye7
 A5PHzll32T3O3tnBGMAUlW2TkZqYklqkkJqXnJ+SmZduq+QdHO8cb2pmYKhraGlhrqSQl5ib
 aqvk4hOg65aZAzRfSaEsMacUKBSQWFyspG9nU5RfWpKqkJFfXGKrlFqQklNgWqBXnJhbXJqX
 rpeXWmJlaGBgZApUmJCd8W79KZaCuZwVb2beYWpgvM7excjJISFgIvHz4UbGLkYuDiGBHYwS
 D/49BksICXxilHhzIwki8Y1RYtXSH3AdO7YvYIIo2sso0XtaH6LoPaPE0Z2HmUESvAJ2Ei2T
 voI1sAioStyav4kdIi4ocXLmExYQW1RAXuL+rRlgcWEBB4kbW2eAxZkFxCVuPZkPtICDQ0TA
 X+LfRzeQMJuAjsT2b8fB9nIKuEgs7TjLDFEuL7H97RxmkBskBI6xSzy4c4oZ4lAXiW3fLkPZ
 whKvjm+BekBK4vO7vWwQDc2MEkuXHGSFcHoYJf41XGeDqDKW2L90MtgVzAKaEut36UOEFSV2
 /p7LCLGZT+Ld1x5WkBIJAV6JjjYhiBIViUuvXzLB7Lr75D8rhO0hcWR3JxsksKYzSmzcdp5p
 AqPCLKRwmYXk/1lInpuFcMUCRpZVjGKpBcW56anFhgVG8NhOzs/dxAhOe1pmOxgnvf2gd4iR
 iYPxEKMEB7OSCO9hU4dUId6UxMqq1KL8+KLSnNTiQ4ymwNiZyCwlmpwPTLx5JfGGJpYGJmZG
 xiYWhmaGSuK8cx73pggJpCeWpGanphakFsH0MXFwSjUwTcjgaU/9FFNnf2uGu/ir22yHj7Yz
 szS86WG6vN+z5MgMzoQunc+JT82eGU+Py7N6/NFt+e4nH8y+rjaY28SYMmNX1L/Hjs0/3Wr1
 zyz8cVFQbsMNzwVbRTezps92n5ouezRrp4mW04v3ojqyp7h7ezuKH2Q6FlRvNpx3zStb+v+c
 3hyGfK8C92sSGcv8jj2puryiXytzk6p2oFaTpxqfa0Tg2gU3ItT/F+4sfBS+fIrzZEH95Z+c
 y6PfKXitdGSSXS6e6Rn3yL5xptLW2YJ929JlIxSnqhRk+eWJbc1syt4gbbbFuORA5Kf7QTz/
 5r9x3b7y5osFGyRyt6za2FqRO3O6RVqlS/WdbqapTVlKLMUZiYZazEXFiQBbOvbNBAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrALMWRmVeSWpSXmKPExsWy7bCSnO7xLodUg5vrVS2evV7FZvF2bye7
 A5PHzll32T3O3tnBGMAUxWWTkpqTWZZapG+XwJXxbv0ploK5nBVvZt5hamC8zt7FyMkhIWAi
 sWP7AiYQW0hgN6PEtKvVEHEpic9Pp7J1MXIA2cIShw8XdzFyAZW8ZZQ40PGfGaSGV8BOomXS
 V7A5LAKqErfmb2KHiAtKnJz5hAXEFhWQl7h/awZYXFjAQeLG1hlgcWYBcYlbT+aD7RUR8JU4
 1nifBeIGZ4nvHXsZQWw2AR2J7d+Og9VwCrhILO04ywxyD7OAusT6eUIQY+Qltr+dwzyBUXAW
 ks2zkGyYhdAxC0nHAkaWVYySqQXFuem5yYYFhnmp5XrFibnFpXnpesn5uZsYwYGspbGD8d78
 f3qHGJk4GA8xSnAwK4nwHjZ1SBXiTUmsrEotyo8vKs1JLT7EKM3BoiTOazhjdoqQQHpiSWp2
 ampBahFMlomDU6qBaa3Zx+WCJ9hqmp+6FZ5/IN83Ub1PKLGpYpaG2B+dE7YS5ufLysyLXryo
 PzZdaMk986i/Guc8fl9sNvUu2/XMXCPywN/DPzZMt9Q9LtDJUbqlaZVk5JGG2BsBDRmNfgdU
 dV1EXUv1z0axX3j9a/253EfnJh83Dbomb28opLB74e8iuQ/XAjcHrZSy2rzmWgFHsnfvFL3X
 xWU84S+O9xopHfabzZDodlKzSnn9VusZDzfeeHh+EsuG+3uU9jzSPnvuVaWAl/fqQNtd3MeV
 Ppans8jurbwn1Hbc6dG2LF79Dd583n6TJ/1Qar5uxrHUY2Lbmfw6NZPTN8q2HXDoOP7crCOx
 tmgZ8+5T+taFRpt+KrEUZyQaajEXFScCAK3/TgHTAgAA
X-CMS-MailID: 20231031050407epcas1p250bf5bb525b416e61ca4b9a2425a30b8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231031050407epcas1p250bf5bb525b416e61ca4b9a2425a30b8
References: <20230924223022.313107-1-sidharth.prabukumar@gmail.com>
 <CGME20231031050407epcas1p250bf5bb525b416e61ca4b9a2425a30b8@epcas1p2.samsung.com>
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

On 9/25/23 07:30, Sidharth Prabukumar wrote:
> The MP5416 PMIC's LDO set-value formula is incorrect. This patch fixes
> it by using the correct formula.
> 
> Signed-off-by: Sidharth Prabukumar <sidharth.prabukumar@gmail.com>
> Cc: Jaehoon Chung <jh80.chung@samsung.com>

Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>

Best Regards,
Jaehoon Chung

> ---
>  include/power/mp5416.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/power/mp5416.h b/include/power/mp5416.h
> index dc096fed3f..4326baaa42 100644
> --- a/include/power/mp5416.h
> +++ b/include/power/mp5416.h
> @@ -32,7 +32,7 @@ enum {
>  #define MP5416_VSET_SW3_GVAL(x) ((((x) & 0x7f) * 12500) + 600000)
>  #define MP5416_VSET_SW4_GVAL(x) ((((x) & 0x7f) * 25000) + 800000)
>  #define MP5416_VSET_LDO_GVAL(x) ((((x) & 0x7f) * 25000) + 800000)
> -#define MP5416_VSET_LDO_SVAL(x) ((((x) & 0x7f) * 25000) + 800000)
> +#define MP5416_VSET_LDO_SVAL(x) (((x) - 800000) / 25000)
>  #define MP5416_VSET_SW1_SVAL(x) (((x) - 600000) / 12500)
>  #define MP5416_VSET_SW2_SVAL(x) (((x) - 800000) / 25000)
>  #define MP5416_VSET_SW3_SVAL(x) (((x) - 600000) / 12500)

