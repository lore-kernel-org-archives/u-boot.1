Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE704C4345F
	for <u-boot@archiver.kernel.org>; Thu, 18 Apr 2024 00:11:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0EB8D884D0;
	Thu, 18 Apr 2024 02:11:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="oq2eg9DD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2D87884E3; Thu, 18 Apr 2024 02:11:48 +0200 (CEST)
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D939E882C4
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 02:11:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jh80.chung@samsung.com
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
 by mailout1.samsung.com (KnoxPortal) with ESMTP id
 20240418001142epoutp01d65ed0a0166d97e82518df5b17b64066~HN2fDKduG0618206182epoutp01J
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 00:11:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com
 20240418001142epoutp01d65ed0a0166d97e82518df5b17b64066~HN2fDKduG0618206182epoutp01J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1713399102;
 bh=ET31e1M2dfvnHb6Rnjd7AhsuZHn7qF72Ag6gmtSXQLc=;
 h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
 b=oq2eg9DDDvT8IHiN7iDgMvwDp3ocxskzzXOlO4I/sPOsvDUj8+LVI733mLDmu3JnN
 FactiUFPS74ZxCZjCJvvhTkEt5EnY+fbK4rgEGNiRTJljVB649cD3ePhwbrrYri9oI
 j4CAAMdHiY5NdA1ZVt+9SnZYz8evHX8wTONrRx0A=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
 epcas1p2.samsung.com (KnoxPortal) with ESMTP id
 20240418001141epcas1p2b644eee34d9617408a27d840e05de3c9~HN2euuz4G2651826518epcas1p2S;
 Thu, 18 Apr 2024 00:11:41 +0000 (GMT)
Received: from epsmgec1p1-new.samsung.com (unknown [182.195.38.237]) by
 epsnrtp4.localdomain (Postfix) with ESMTP id 4VKdVh2qJKz4x9Q7; Thu, 18 Apr
 2024 00:11:40 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
 epsmgec1p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
 6B.66.19431.C3560266; Thu, 18 Apr 2024 09:11:40 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20240418001140epcas1p2aedbb7d9b37df117ac295d9bb707c73d~HN2dKXkGp2648426484epcas1p2W;
 Thu, 18 Apr 2024 00:11:40 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20240418001139epsmtrp2bd652ba14c49dcff1004bbc7d413983e~HN2dIfA4E0582405824epsmtrp2q;
 Thu, 18 Apr 2024 00:11:39 +0000 (GMT)
X-AuditID: b6c32a4c-1d1ff70000004be7-4a-6620653c7234
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 9F.C3.08924.B3560266; Thu, 18 Apr 2024 09:11:39 +0900 (KST)
Received: from [10.113.113.235] (unknown [10.113.113.235]) by
 epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20240418001139epsmtip2dd9d28266776f5c8a1a9a59306d3b76e~HN2c1Qv1G2497224972epsmtip2G;
 Thu, 18 Apr 2024 00:11:39 +0000 (GMT)
Message-ID: <dfa3c331-58a8-4120-b762-81df8908572c@samsung.com>
Date: Thu, 18 Apr 2024 09:11:39 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v3 1/5] power: tps65941: Add macros of TPS65224 PMIC
To: Bhargav Raviprakash <bhargav.r@ltts.com>, u-boot@lists.denx.de
Cc: d-gole@ti.com, dan.carpenter@linaro.org, m.nirmaladevi@ltts.com,
 sjg@chromium.org, trini@konsulko.com
Content-Language: en-US
From: Jaehoon Chung <jh80.chung@samsung.com>
In-Reply-To: <20240318094925.374959-2-bhargav.r@ltts.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEJsWRmVeSWpSXmKPExsWy7bCmrq5NqkKaQc8MEYvN8w8yW7Ss9bD4
 MK+V3eLj9vfsFt+2bGO0mDppM7vF272d7A7sHrMbLrJ4vDqwit3jzrU9bB5n7+xg9Pi6aROr
 x/Eb25kC2KKybTJSE1NSixRS85LzUzLz0m2VvIPjneNNzQwMdQ0tLcyVFPISc1NtlVx8AnTd
 MnOAblFSKEvMKQUKBSQWFyvp29kU5ZeWpCpk5BeX2CqlFqTkFJgW6BUn5haX5qXr5aWWWBka
 GBiZAhUmZGdsXPWJuWCZYEXPrqssDYz3eLsYOTkkBEwk/rxYxdrFyMUhJLCHUeLIhn9MEM4n
 RonZb0+wg1QJCXxjlOi8nAPT8fDVNDaIor2MEjs6+tghnPeMEvvmrWAGqeIVsJNYMv8oK4jN
 IqAqsf/5bzaIuKDEyZlPWEBsUQF5ifu3ZoBtEBYIlPg5ZR9Yr4iAk8TXk61gcWaBbImJ828z
 QdjiEreezAez2QR0JLZ/Ow5mcwpYSiycfx6qRl5i+9s5zCAHSQhM5JCY1HCTHeJsF4k102dC
 2cISr45vgbKlJD6/28sG0dDMKLF0yUFWCKeHUeJfw3U2iCpjif1LJwOt4ABaoSmxfpc+xDY+
 iXdfe1hBwhICvBIdbUIQ1SoSl16/ZIKZf/fJf6gSD4lDWwIhgbWbUWLC3vvMExgVZiGFyywk
 f85C8s8shMULGFlWMUqlFhTnpqcmGxYY6uallsOjPDk/dxMjOLFq+exg/L7+r94hRiYOxkOM
 EhzMSiK8LcKyaUK8KYmVValF+fFFpTmpxYcYTYExNJFZSjQ5H5ja80riDU0sDUzMjIxNLAzN
 DJXEec9cKUsVEkhPLEnNTk0tSC2C6WPi4JRqYGKtcOyX/9bRyW8iHlNo7Kh/dY+59BHnutJ5
 4hfC/tefOea8dcKXRW8M1eLcl5lG+N2oPnAqSnBm1JT3/Fz3Lqv/TZ6nPidoGkf2b9aW9I5C
 9t82a9f+khJ7yOByVb1UXi2i0vDLwR0GcY8yQ3lZVqxLvq+yxowlLPbenZu54mYh3O6G0auv
 cZQ0/RV7uPrqOgk/eeYclonfKlTVGCrXu8b4qt2L+ruDy8C28NZjb5Zs2aMn/7rmb0/nmNPd
 PPniuSqt24oNygEVAsezfyr9ONNxqiRkwZ5oSV22Gc+PTmibHWPluowxPfncpgKbOXUar3um
 bd3H1WVw8qh4duplc9Hbrh3T9iQoLCqJEd2rxFKckWioxVxUnAgADZYpnTUEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBLMWRmVeSWpSXmKPExsWy7bCSvK51qkKawazNxhab5x9ktmhZ62Hx
 YV4ru8XH7e/ZLb5t2cZoMXXSZnaLt3s72R3YPWY3XGTxeHVgFbvHnWt72DzO3tnB6PF10yZW
 j+M3tjMFsEVx2aSk5mSWpRbp2yVwZWxc9Ym5YJlgRc+uqywNjPd4uxg5OSQETCQevprG1sXI
 xSEksJtR4t/PTnaIhJTE56dTgRIcQLawxOHDxRA1bxklzt3oA6vhFbCTWDL/KCuIzSKgKrH/
 +W82iLigxMmZT1hAbFEBeYn7t2aA1QsLBEr8nLKPGcQWEXCS+HqylR1kPrNAtsSl5kSQsJBA
 usTus1fBRjILiEvcejKfCcRmE9CR2P7tOJjNKWApsXD+eSaIVnWJ9fOEIMrlJba/ncM8gVFo
 FpIjZiGZNAuhYxaSjgWMLKsYJVMLinPTc4sNCwzzUsv1ihNzi0vz0vWS83M3MYIjR0tzB+P2
 VR/0DjEycTAeYpTgYFYS4W0Rlk0T4k1JrKxKLcqPLyrNSS0+xCjNwaIkziv+ojcF6J3EktTs
 1NSC1CKYLBMHp1QDk2y48zQuyb1r7Ou2ukyLSuo5f/GxR6Pn+okbOC/ckbp93qLi5AO2BdN3
 vb2jW+t2+KHiEc6JB9JWG9W4sMguflF5vi6gg//e05hNl7I21S8VlCj8XNAuo2OcP0WZd0XE
 2fzcx4ejEi69NnwQtlerPv16Y6fJw8t5EncCA//5z3nL06xX5MVUc7vzqnKlOts67kfr5Mu+
 az32r6ky/LjH48qGT+mLWhsXMZ2b2TupQVTF/0XrMfa8swvufew0O3l34tHtPPrJDIeZF6+7
 FhhT9WyllZK+1fqzHnFhK7adjT+Qwrc9Mrcl0Wnfri0TOo8W7D0veWyrz1fu7uxzN9aor5x3
 68XtB55F6jXiGZ3ne5VYijMSDbWYi4oTAQDCoWwLAwAA
X-CMS-MailID: 20240418001140epcas1p2aedbb7d9b37df117ac295d9bb707c73d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240418001140epcas1p2aedbb7d9b37df117ac295d9bb707c73d
References: <20240318094925.374959-1-bhargav.r@ltts.com>
 <20240318094925.374959-2-bhargav.r@ltts.com>
 <CGME20240418001140epcas1p2aedbb7d9b37df117ac295d9bb707c73d@epcas1p2.samsung.com>
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

On 3/18/24 18:49, Bhargav Raviprakash wrote:
> Re-use the TPS65941 PMIC driver for TPS65224 PMIC.
> Add additional macros of TPS65224 to aid in the driver
> re-use.
> 
> Signed-off-by: Bhargav Raviprakash <bhargav.r@ltts.com>
> Reviewed-by: Dhruva Gole <d-gole@ti.com>

Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>

Best Regards,
Jaehoon Chung

> ---
>  include/power/tps65941.h | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/include/power/tps65941.h b/include/power/tps65941.h
> index a2bc6814ba..cec85333f0 100644
> --- a/include/power/tps65941.h
> +++ b/include/power/tps65941.h
> @@ -3,11 +3,14 @@
>  #define TPS659413		0x2
>  #define TPS659414		0x3
>  #define  LP876441		0x4
> +#define  TPS65224		0x5
>  
>  /* I2C device address for pmic tps65941 */
>  #define TPS65941_I2C_ADDR	(0x12 >> 1)
>  #define TPS65941_LDO_NUM		4
>  #define TPS65941_BUCK_NUM		5
> +#define TPS65224_LDO_NUM		3
> +#define TPS65224_BUCK_NUM		4
>  
>  /* Drivers name */
>  #define TPS65941_LDO_DRIVER		"tps65941_ldo"
> @@ -25,3 +28,30 @@
>  #define TPS65941_LDO_MODE_MASK		0x1
>  #define TPS65941_LDO_BYPASS_EN		0x80
>  #define TP65941_BUCK_CONF_SLEW_MASK	0x7
> +
> +#define TPS65224_BUCK_VOLT_MAX		3300000
> +#define TPS65224_BUCK1_VOLT_MAX_HEX      0xFD
> +#define TPS65224_BUCK234_VOLT_MAX_HEX    0x45
> +
> +#define TPS65224_BUCK_CONF_SLEW_MASK     0x3
> +#define TPS65224_LDO_VOLT_MASK    (0x3F << 1)
> +
> +#define TPS65224_LDO1_VOLT_MIN_HEX       0x0C
> +#define TPS65224_LDO23_VOLT_MIN_HEX      0x00
> +#define TPS65224_LDO1_VOLT_MAX_HEX       0x36
> +#define TPS65224_LDO23_VOLT_MAX_HEX      0x38
> +
> +#define TPS65224_LDO1_VOLT_MAX        3300000
> +#define TPS65224_LDO23_VOLT_MAX       3400000
> +#define TPS65224_LDO1_VOLT_MIN        1200000
> +#define TPS65224_LDO23_VOLT_MIN        600000
> +
> +#define TPS65224_LDO_STEP               50000
> +
> +#define TPS65224_LDO_BYP_CONFIG             7
> +
> +#define TPS65224_LDO1_VOLT_BYP_MIN    2200000
> +#define TPS65224_LDO1_VOLT_BYP_MAX    3600000
> +
> +#define TPS65224_LDO23_VOLT_BYP_MIN   1500000
> +#define TPS65224_LDO23_VOLT_BYP_MAX   5500000

