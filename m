Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD7CDC36000
	for <u-boot@archiver.kernel.org>; Fri, 21 Mar 2025 19:42:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19AFA8082A;
	Fri, 21 Mar 2025 20:42:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="oe/TXTEm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B301808A2; Fri, 21 Mar 2025 20:42:48 +0100 (CET)
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com
 [IPv6:2607:f8b0:4864:20::b35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2DB06806D8
 for <u-boot@lists.denx.de>; Fri, 21 Mar 2025 20:42:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-e5ad75ca787so2203366276.0
 for <u-boot@lists.denx.de>; Fri, 21 Mar 2025 12:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742586164; x=1743190964; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=99EzEL4PhimenXr/Ee/uRd/EKlIIQ5AwmGUN87eHLuI=;
 b=oe/TXTEmc2JAZpxLV0ep1oZmhrjMChFkXz47CBQSjBhYQnoXu/c1mn3ugvSbBanxa9
 7AAJ6GXeKt7TQX6fF6rmkBXLm4auKbjyksl21M6lKItOdKFStvzSw/oooco8TAxfIvSX
 znPgt6c4iZ5Ub3lRWbsdpjN9bAaJO+208JSSBEmVX0GhI3PN5yDrbmIL4SOBsqROicfY
 qWn38IUSCNAc/r1mnq1Gp2uY4frT2zqiJyiqDDFc46JlFavY2tcHCVQd81atRtWZIZKw
 xHuwEwh5eTHjJtUXEdn8FPxegy4/I1eT/G8dEVBLem/eUmiSoxlvchGZZQripv19Nn3c
 XBXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742586164; x=1743190964;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=99EzEL4PhimenXr/Ee/uRd/EKlIIQ5AwmGUN87eHLuI=;
 b=SVqZkkTP6wSBNftv7uNToGNIKsf/ZcyLEzPZuIh0UC6wBXaW/ObOcY03jsG1EEaJTj
 jf75CwACtDPvdL+BO3KYT8V0Sbe8YIFRqeaAIHwhTBv4iQWve8yXMU7/MIyVjyDt4FWG
 QS9/fR24bd7X+2QgvPRtCOk9VkzkvQfwt8OkNn3RIfKMx5aMkv8072Q9QLGFsBvu9GVL
 gen9TNOvaYgTRnj0kr8kdqUZ+JAPyqznJv1OA/Vc/tcMIIPJ/UhePRLvTctbuw8QlIL8
 VmUf3c9iB5eC4EuCy117fbZ7dxjTUMU60IasFT2NtM2viuLSSsHPYrtCU7bjEGMd7yKA
 VLcw==
X-Gm-Message-State: AOJu0YwulPWy/CaX9FiNJsrHRp1lKjuIiI9Jkro2vbl/75Kozzi7xHuu
 KvkWtldWSAlZyiLBDWIWZuFH3iSpB9/atrGdOrBhJ2jaQINcvUs6QSUev7yTq3a+eXOU7MyZqBx
 KmOrL9bULeBRUcMUHqRZZ8XOO0ci22O/iYEIIIg==
X-Gm-Gg: ASbGncv9u1zYG9m0f8ulv/UZnsZIQMjDTgjBGwiNYiOpKdqezsgZ0YYnNr4HUVNF+h5
 NT2s/DSPveyUSNk9FWsgTHcZZcPC3s94yiA0sZz9m5SXZFkq6ErOW4UtmV2vLsJUmhjCoLftXBm
 QvUYLugTSNdEXuehu/ExEJBig=
X-Google-Smtp-Source: AGHT+IFwepuXw/Pem64SFiQmUZqM1Zxrcs5t/gT0Qv9OdqBcTvOJw1pYYeMtVjXOQskPPylbSfXst8OyTBDJ5UfDUSk=
X-Received: by 2002:a05:6902:1b06:b0:e49:5f2d:e722 with SMTP id
 3f1490d57ef6-e66a321e489mr6807090276.14.1742586164489; Fri, 21 Mar 2025
 12:42:44 -0700 (PDT)
MIME-Version: 1.0
References: <20250321124216.1268147-1-jerome.forissier@linaro.org>
In-Reply-To: <20250321124216.1268147-1-jerome.forissier@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 21 Mar 2025 21:42:08 +0200
X-Gm-Features: AQ5f1JptuyXVaCC2nT2WhcYdtSm2gZ3LawAQ9A9IXG9tNtlLL-kJIJn6puy8j08
Message-ID: <CAC_iWjJbSP=+aDcHP59mf425spGy8wB+7sQ6qCrYnCJbJ1Ax-A@mail.gmail.com>
Subject: Re: [PATCH] net: remove commented out line
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Adriano Cordova <adrianox@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Simon Glass <sjg@chromium.org>
Content-Type: text/plain; charset="UTF-8"
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

On Fri, 21 Mar 2025 at 14:42, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> Commit 1d5d292b7941 ("net: split net into net{,-common,-legacy,-lwip}")
> inadvertendly left a commented out declaration for do_wget() in
> net-common.h. Remove it.
>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
>  include/net-common.h | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/include/net-common.h b/include/net-common.h
> index 29d31f37263..89679e20860 100644
> --- a/include/net-common.h
> +++ b/include/net-common.h
> @@ -518,7 +518,6 @@ int wget_do_request(ulong dst_addr, char *uri);
>   * Return:     true if uri is valid, false if uri is invalid
>   */
>  bool wget_validate_uri(char *uri);
> -//int do_wget(struct cmd_tbl *cmdtp, int flag, int argc, char * const argv[]);
>
>  /**
>   * enum wget_http_method - http method
> --
> 2.43.0
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
