Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7433FA374B
	for <u-boot@archiver.kernel.org>; Fri,  2 Jan 2026 15:19:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 732D984295;
	Fri,  2 Jan 2026 16:19:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=forissier.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=forissier.org header.i=@forissier.org header.b="mnA3tEWZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24CFC842A4; Fri,  2 Jan 2026 16:19:08 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39CB384295
 for <u-boot@lists.denx.de>; Fri,  2 Jan 2026 16:19:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=forissier.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome@forissier.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4775ae77516so125301905e9.1
 for <u-boot@lists.denx.de>; Fri, 02 Jan 2026 07:19:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=forissier.org; s=google; t=1767367146; x=1767971946; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5yE1j7/O7U6NJVns3yNy3pYR6uc0vdplyM4C/7QHXFY=;
 b=mnA3tEWZU2zVY5Ws/WSRjDVilsw2CO6C0eHeOAADW17xUYHckJJLktN06xYRxkn4uv
 dKRrRKsVlxfRlNNYhy1XWFbpt/P6O5suHB/CIp2qa7lXaa8n1TWlPKZ+m4eaWkiCxGaz
 CxkQi2e5/LlZ4EUsr48RdWCnHSwUW/zgBvsXhxgueOgjY1eMomm14t9UcS3usjRnhiCV
 AVT40vwPo/M4JZPYarhAPrIg33UO0OMc0K6WSL/a48RkIXDo0O34bjkv0BR22cfOugkv
 kwnfKOGQMnS2yNuxqidrB0dd9wduBJ6OhFDfYYkKvLC5ZWILrN6gC/Pmi53aaUbgREpx
 Ls1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767367146; x=1767971946;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5yE1j7/O7U6NJVns3yNy3pYR6uc0vdplyM4C/7QHXFY=;
 b=kSyZ7Jz5MTa/acgvDENwdgm7AqvV3Dw1GlAuY0OZYMkmUUn/SrMVzD4kd2NwMtcD8e
 nbDNfIHllN1qahyBfQL3/cFQ0ktSs84X9/osAgdgdC5FgtoUdQITAwsVTeiKs/dhRxLQ
 QxbtD10ZrUu3AApMhDBvA9Iv0Rijys8yI4kxq6kVIlu8iEm8/w2i2IOVPj8EN/90/Ws8
 JhlsxkL6m+rXnBNWkRma/WrGhkfGr6GIsFnReWO5XDwPKiW1MmMnzrSrzLDJd/yhXVbc
 rMC6BY6cXCv2PaSEtD+9Jv3ca5K4wapNH3KdU0bjqz9P12TZYagu/l4hE/KjKsaV2+B3
 b5Ng==
X-Forwarded-Encrypted: i=1;
 AJvYcCUI4vMMd7gfMsT6SkjI0WZ8v8ENcYxHfMb/kDbVEl+vcLtjumONKw5X1CFLwY+Vo85mJCYaitc=@lists.denx.de
X-Gm-Message-State: AOJu0Yyr1JL74NCWF1EaGR3yB5i3G5ecbPFUQitM+ClXGYaEZCHXVyTI
 hjE9VfWXbeKJrU/PDGgt+IWSGTNUbEHHtM7hIDKUots7ECrw6E2AV/aIdrAwwOlC+D4kivBZfJG
 PvzqH170=
X-Gm-Gg: AY/fxX6jHhOn8GO3+jqRQnELuzWQYFxv6540lrB2eIpnZ8q8hglfSehaHKQIwOc4VF7
 RwcaCKuUlc/zcPiCqeh9Lli1CUYLxiIleerlQRZ5HQmttfJYt7gbTUVxvl5WDflhED7fRA8N1Q8
 l86Kn3rQCvGKL3o+tbr8P1SQ1YKrDYig2zNcersqat5Ha/YN8iDD4tYkWt8VOFBh7UQJNFk/hD+
 jiL4Z37G6B6vWkWNYQwXTbXsPn7u8qDEKgsP4/1Xf5dEuUZIgDfVri1Bmnr0AG/TtCEM3brsPTk
 8aD89B7ECgsbZYarcgn09EL+qfMYQSoIpZIQIp484oHoIAHn4tpBKNGI3Tf/92Msy0lkUUeWvs2
 qjVscGOs7FencaYfcw5IsRrvJKlKcT6/x/bVdQ0/caXEVYz9b7hTTsP/DvnM3bHORLHPxclCL/Y
 0lRe5lbN3ijZ4+GbWFdAwG+kdWlSxLEZhalOh4ciFIyxE4uqf6WOD2qUCa
X-Google-Smtp-Source: AGHT+IEAvjgWvejpT1/fHcDDyAWOfbu31sm8QDBK5hr6PBJfpRgpUnraXvoLVDR71CEdtdgdK90SUQ==
X-Received: by 2002:a05:600c:19c6:b0:471:14f5:126f with SMTP id
 5b1f17b1804b1-47d195c201bmr550125485e9.33.1767367144784; 
 Fri, 02 Jan 2026 07:19:04 -0800 (PST)
Received: from ?IPV6:2a01:e0a:98d:5340:ea5e:8e1b:d9b6:2093?
 ([2a01:e0a:98d:5340:ea5e:8e1b:d9b6:2093])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d6ba3b196sm773225e9.6.2026.01.02.07.19.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Jan 2026 07:19:04 -0800 (PST)
Message-ID: <e2529768-467d-4bf5-a27f-9e50b8defdb1@forissier.org>
Date: Fri, 2 Jan 2026 16:19:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?B?UmU6IFtQQVRDSF0gQWRkIG1pc3Npbmcg4oCcbmV04oCdIHByZWZpeCBp?=
 =?UTF-8?Q?n_help_net?=
To: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>, u-boot@lists.denx.de
References: <20251227181852.4404-1-linkmauve@linkmauve.fr>
Content-Language: en-US
Cc: Tom Rini <trini@konsulko.com>
From: Jerome Forissier <jerome@forissier.org>
In-Reply-To: <20251227181852.4404-1-linkmauve@linkmauve.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

On 12/27/25 19:18, Emmanuel Gil Peyrot wrote:
> From: Link Mauve <linkmauve@linkmauve.fr>
> 
> The usage of the net sub-system was missing the complete command for “net
> stats”.
> 
> Signed-off-by: Link Mauve <linkmauve@linkmauve.fr>

Not sure this is a valid S-o-b as per the U-Boot guidelines (real name
required?). Tom?

> ---
>  cmd/net-common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/cmd/net-common.c b/cmd/net-common.c
> index 1c6f11cd435..6f33d15d695 100644
> --- a/cmd/net-common.c
> +++ b/cmd/net-common.c
> @@ -103,4 +103,4 @@ static int do_net(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>  
>  U_BOOT_CMD(net, 3, 1, do_net, "NET sub-system",
>  	   "list - list available devices\n"
> -	   "stats <device> - dump statistics for specified device\n");
> +	   "net stats <device> - dump statistics for specified device\n");

Apart from the S-o-b, the rest is:

Reviewed-by: Jerome Forissier <jerome@forissier.org>

Thanks,
-- 
Jerome
