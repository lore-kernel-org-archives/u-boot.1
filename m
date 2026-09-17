Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BADAC88E72
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 10:24:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A82C160842;
	Thu, 17 Sep 2026 10:24:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4qVdtR3kw4tT; Thu, 17 Sep 2026 10:24:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org DDB056083A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789640697;
	b=hA8NrKfT6UiSV2gHU/0HcSibG8oh/F3WF4kWjcANJ6rWqn6XT7t2P9v3JfOBItbLrbGZ
	 4+b8mwxCwl/KIGoPeuQNFrYw7Fg2//DjH2LLUJHVUpD2oBoxOoGb+OlVv6s1GFKzCS+O9
	 RvukwkGIKwhKy/PbitXDFrwi5B7cvoAobKoXE/XBP2Y5kw245T58nhRp/rcm6qbEH+pMi
	 AmlM0r3EVobTEaZ2tBebhHWR70/EqNfsUJ9AA9/JFqRdSgabaXdNQDhiI74OQkpq9XHdI
	 JSxKJjAjCT2k/t3U/6UdJQ2M7Bd6Vgfx+2baeh4y8sXT26rwN6r96zgScFE1c8l6DCg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789640697;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=HzuPp0oHLjbS60JlZNy0kKxgHs8UZbYLN1rDYNK7Jiw=;
	b=gdSX1+tk61yVOB1bXNbO0E8xwrifp1i+q6q0NvzunF57JbHtmQsqhglU43Ycug8WKv5p
	 QzzFVreobpwQ84hiSJZJb0omZofGTpLwMYME+UCZXAXD7P+uDlnSuvqc2WNY+7TwOKbfB
	 FKgvGV5/KPusJU3eRr9MjgQalMkIu1rMFnAVlpgJnZt3OT4aAnkjndJPH/pIz51JQ1X4H
	 iiBWMcIpqNFzYzYuWyKIrX5Oz7pRHvXDZWsw1r9Rn2/dhGiAhFmvwgxFscng1GyU15QvP
	 PtdTPSKti8AArDVJ9AIMDqph8/lF/dIIlFxjfXxodMASa0TDnalZxLA/dIbVRBRaCSw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=hQNIF7Z3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789640697;
	bh=HzuPp0oHLjbS60JlZNy0kKxgHs8UZbYLN1rDYNK7Jiw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=euthTOJjGzQ+/RNHTjwPlREUrdHwfbFGSCg7IZ/yXBe2dG7L3UGvwZxTxSTR169F/
	 55DPexuFCvpSSwsSaNvZ8NOq6kCGHZQOR3I8+I0xNWff8izuFnh7Lc4eNugDPow6w4
	 yu3n1ACutSxhlDX/HmInvikgIq1FtK1RF51w2CzYx7XQAcHYD6mg7pwa540flCDQ5g
	 +Aqq8ZdYYLZPGu5jQ0IoVw/3DJnMxlyv+tncEt7BshNGJLkyqiL3+7BOprfxFDabz9
	 OZ4ZQOzUdFeXS/vgspHqLKbKoN/ONcygGT2aYKY86lkoeztlbuwtKqu80rHXkLMmLm
	 TSFrxl94THY3w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DDB056083A;
	Thu, 17 Sep 2026 10:24:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id D2E4F42D
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 10:24:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C41BC6083A
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 10:24:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZwHv5lS9ixC2 for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 10:24:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 8169C607CE
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:41::2b"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789640693;
 b=OhnZYc0KA1HzA73jw5zN0NUWe17ibWUjVW/4PVCXy/F7D2+aNjB5cCh3q3awDD6KPGX6
 /juBpoEnjKe3X+BpAzaYht41b4NN4CMju/qn+n2Qb86fYu3WPiDSkNI8whMFF63gjC+VL
 t7iEwMdRx5hPuTW2lGQrdfQ0/pZCMg1EgIT6m8++3TLnNQxeF+TH6oHJK9DCPXjcGuU4g
 /SvWBjmG/u4b5FxDkNx/9vPTPoBWVatMoD1sQ4nFV9DffEPnxySxponcXW/RfbCZshiqp
 p+/DmbkFWq2juakTxHDfeNB/LGvSNfUFgn/7LGKag53f4VWHbJzbp0UEayVZwUtF5WA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789640693;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=HzuPp0oHLjbS60JlZNy0kKxgHs8UZbYLN1rDYNK7Jiw=;
 b=W+656vZPz+qJrAv8G/yn7YOC6Us+9ZLP0fNe5XQiCBwHHp2ZBtYwK3mqBIjXbjZBacZc
 bWv8c2NA1MUnuZ9DVBwUnKrcieTy39+j7XftAiF9eEZVetpr4f5x02KMk8Xb0Y5D7rqXW
 RxjKLUT1RYB1FygaK5qAC9m0HocfnkWim24ONv1xeIwWGinOt3vZEeM8TyAXcQ3+eViw8
 wPhDSTAD61cPW3X474OCoN2jS8Z6yes7OCQSyEzWtNdHTCBgwiViSY6HIFZBujIaJFQ9c
 S8Ve2msrPvOIuEoUXCewl5y9dp44yg+Dk962pAoLixv89vCEdsOURMBa3sKbVvdFXfA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=hQNIF7Z3; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:41::2b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:41::2b; helo=mail-yx2-x2b.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=hQNIF7Z3
Received: from mail-yx2-x2b.google.com (mail-yx2-x2b.google.com
 [IPv6:2607:f8b0:4864:41::2b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8169C607CE
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 10:24:51 +0000 (UTC)
Received: by mail-yx2-x2b.google.com with SMTP id
 956f58d0204a3-66f7a9afe43so569822d50.1
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 03:24:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789640691; cv=none;
 d=google.com; s=arc-20260327;
 b=a4jSQlyby8FZfM7OhyqAyLFjXFmc9lg46vrxmn89uvdjdsq+Lb1ldeQrcjfvfvGmOA
 kUwrdtHXzz5LibXUANmEAmGPBEIoi2ATElQ8U1geQZ7Puqgkicjqd4Xu6Ct4G7CMzkHm
 YdFaCE7zBB9DX9HLagiKaG6seaI5FFL7b/XVQAJyoDuFplAYzRwbkKR8RWH5v7gsX+WE
 HkWA/oXwz6Vygp17W6MnJYe8l/WPEVoldNdXohYj6/0CUtTbZmo553JSxuwt8oIKEKA2
 ITDLBJAbquUJi31JKWflOMqj8xmpQnem4/qTqrP0Ro5yIrE34PjBtBAnzk9sPAsV1Dgd
 dC0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=HzuPp0oHLjbS60JlZNy0kKxgHs8UZbYLN1rDYNK7Jiw=;
 fh=SgX3lzKXsL5uOHPUteg8m8HKJkb5mKF9KCqOub2vpgM=;
 b=n0VXywQ0EwIPqyINz4Re2z0ye/A/Ug7DEdb1/wpKQXtZfIjmctWroU732JQIXpVSOL
 mfXgeg9R0jYXSjLkIB8fwmju5ILWdfSAGP1j3JiSIsetbdylT+sAvh0on3qGVBEHl+Gy
 RuaBJWUK4pMg7TrIHTO/OL5EiTyM20FlHLuiXdp0wwQ6Csxuv3fojKifs3Mbq2Wdmru1
 oL1gaQawd3f1Xy7TF+1gkK7dXi/G41S3fpwHnGjkYGA/wEzZjw3+Po5N8F9xo+Ck0wWA
 jYxtFXuW9k05XhIB3hPmdAGbtm6/+a7vLrp6ZdiWNW3UecgE9lKGgnDb0kGvhIT7bsUx
 iYaw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789640691; x=1790245491;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=HzuPp0oHLjbS60JlZNy0kKxgHs8UZbYLN1rDYNK7Jiw=;
 b=hQNIF7Z3buBsWchJAMhK9dbZD13wXRwFhoPxjGAds/relx9ZTL7nklXV+FWMXISsco
 1+MF7yEvhYPsWSuVSvMyFzk0XYpF9/yw3XMRUA6vJgqDpCMXkoLoDdLBlFsvzNcBQeGv
 QlftojA4s+mou6LUnsc1hvqo3sQYyd+tOXN5jHczs3nwNMIwa2jaBcM6JtNOBe1Q/g6g
 hfH+B0iPpU6Kd7dqPyf3kXXtRo0cOG2WkpGzxDUDN6APCK6x5qsguLZsEuourJIoG/OF
 NLS5u2Qm+5ENDZ6ACRmBLlMp+7k5PTjEBAu3XqryAz+3e08OwwItls/w/XmRO5gGDfOg
 9m+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789640691; x=1790245491;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=HzuPp0oHLjbS60JlZNy0kKxgHs8UZbYLN1rDYNK7Jiw=;
 b=ME4zIYKnnGGb564bgpNoKSebqlmcJTb9BLv2jtHFqUVaA7vTfD6N1QmUBNQOegQG9l
 OZq2eFx9WKahwWVTwUCygZ8a/i41ff4S1Aj2kBmwy3v4dTnydyiwtiR7yUdOXGIuia6d
 CCrfL3xZ0ac3fxFRvKh9nuhNk171B1bDcvE0MyNC6QJhnyKWEkRPfpoMptLQUATC+R/+
 rqWFbe2TWXWrJ/p9bXmGxeUQm8r/yf8wbAqfVom2dZoyMXHhExnj+FODM+cFFnKad4pl
 AuUPHuoZsFL3HrtBSao1GKe6sl5HIbQ7bxxMYQa4evHzBoN5azibpR2R2YVTHHzQ02md
 xb0g==
X-Gm-Message-State: AFuF++nVui6jqOGSK2m9S9b4JgSLD79iGIsSPgvq4fgsrINcPUNq7I3R
 4217JD0c+gXmXkeMStLO0w0BNJeZeJzdFuxaRLZIvek6yEyRRcNzuZRG/0yQ/bVjjiRvZ7/PiUy
 YxVYBLF4Lu9MxEt/dWtduzhmC3bHoCpI8AoMvyvdFeg==
X-Gm-Gg: AYBFou3CSbRx/tEKx8iVzXvrV2nHbCzpTTA1ogL9Z2SfWrO+zv+cRNStZo7bKCo4xEs
 Y77iLZAZ8w9WahhdOEcMNqFqayMYaXb41HB2X4M/bxzxnU1JdzP6el/xUdUWZ7hQNxr7eKnVikG
 0yqV0mbGEkSqPcfjGdNCZ7GhjRRV9U5Kr98rRJ+KH2C5TC26HhradhXc7UmOtZK4yw198rBDLIa
 nP6RpYG5Tzb2VKnFUv8o7/YQ8sOlBj+DZbBbzqPekkmIzBTzSCVe2eEa+hiRxZ4XSarPgVbW1+5
 pBt6C1fACd7IJfYMpGdF9cCRs5tQhdxlLTvidqB5/1H4YdqRzjtELTxb6UIsv6XTUFtIQ0C+aQC
 mCLCK0uMmNOUUV2shEJPayJWGLqr05ond0sdX/1iB9ifE29Q0/mCo42OzmiMXOaLO3sj/Ramq91
 gVLZpEDP8yZsaZ2UnsQhsDXhXltWoSoZuOSp0sYz8JQYm2KfQLDqcgP2JR51m32bPT6rhAsYG+J
 3G+oWPhGdJScfJ8SEpW+GAfBX6Z1sn4SeBDLu1jvTHFryYXRip3KufPC1izooQZiynrp4oRdVVf
 ZjI3C5vncGN/exRNKt5VeUz6s8VavKmCPXNueo4eRzB43NBFoXWFEL9EnrQED6F8mncj5UFD6ml
 vileRgCk6q4DERyQo9lgXTBta2iC04YDB7Ot2wmOEHpfz6zztpnFS
X-Received: by 2002:a05:690e:118e:b0:671:4763:cb5c with SMTP id
 956f58d0204a3-671631a92e7mr2023557d50.20.1789640690784; Thu, 17 Sep 2026
 03:24:50 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1789023381.git.jan.kiszka@siemens.com>
 <05f13f7b9b886c7ea0b826fae352a59cf07b63eb.1789023381.git.jan.kiszka@siemens.com>
In-Reply-To: <05f13f7b9b886c7ea0b826fae352a59cf07b63eb.1789023381.git.jan.kiszka@siemens.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 17 Sep 2026 12:24:14 +0200
X-Gm-Features: AcwNN1XLPBwhvV7XFUguwGNSSDYQNYkcKZGpRlPqF17TwOi9leOH-BHLldwXi78
Message-ID: <CAC_iWjJEy9mp5OutQdN=A+_ewnLXWzPAYwxN+ipoHPAK_eG8gw@mail.gmail.com>
Subject: Re: [PATCH v4 5/6] mmc: Call back to optee after a successful mmc_init
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: U-Boot Mailing List <u-boot@lists.u-boot-project.org>, 
 Jens Wiklander <jens.wiklander@oss.qualcomm.com>,
 Sai Sree Kartheek Adivi <s-adivi@ti.com>, 
 Alexander Heinisch <alexander.heinisch@siemens.com>, 
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>
Content-Type: text/plain; charset="UTF-8"
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

On Thu, 10 Sept 2026 at 08:56, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>
> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> This is needed to that OP-TEE can re-enumerate services which need RPMB
> access that may have become available now.
>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> Reviewed-by: Peng Fan <peng.fan@nxp.com>
> Reviewed-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
> ---
> CC: Peng Fan <peng.fan@nxp.com>
> CC: Jaehoon Chung <jh80.chung@samsung.com>
> ---
>  drivers/mmc/mmc.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
> index 670e92ee12b..2463e50cd3c 100644
> --- a/drivers/mmc/mmc.c
> +++ b/drivers/mmc/mmc.c
> @@ -27,6 +27,7 @@
>  #include <linux/list.h>
>  #include <linux/printk.h>
>  #include <div64.h>
> +#include <tee/optee.h>
>  #include "mmc_private.h"
>
>  #define DEFAULT_CMD6_TIMEOUT_MS  500
> @@ -3168,6 +3169,9 @@ int mmc_init(struct mmc *mmc)
>                                 mmc->cfg->name);
>         }
>
> +       if (CONFIG_IS_ENABLED(OPTEE) && mmc->capacity_rpmb > 0)

This is only used in used in U-Boot proper right? We don't have
SPL/TPL symbols for RPMB support, so IS_ENABLED() is better

Cheers
/Ilias
> +               optee_rpmb_available();
> +
>         return err;
>  }
>
> --
> 2.47.3
>
