Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3A64CCFA03
	for <u-boot@archiver.kernel.org>; Thu,  6 Nov 2025 13:09:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA51883B87;
	Thu,  6 Nov 2025 14:09:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="iumRksfr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57F1D83B8A; Thu,  6 Nov 2025 14:09:13 +0100 (CET)
Received: from mail-yx1-xb130.google.com (mail-yx1-xb130.google.com
 [IPv6:2607:f8b0:4864:20::b130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1CBCF83B85
 for <u-boot@lists.denx.de>; Thu,  6 Nov 2025 14:09:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-63cf0df1abbso881461d50.2
 for <u-boot@lists.denx.de>; Thu, 06 Nov 2025 05:09:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762434549; x=1763039349; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sqAs5BScSPndH3II3LN8n2VbtQRbh6MVpjhSHp+Bxow=;
 b=iumRksfrO+676REraNs9zPkr1OdMucWFlzwOkKj8t/Cl6OaNU5Sj7Ki7W/plYUaSuC
 OOebF7aA8smCIAUQk5wSmsyNrZk3j8xPeGylyz9KFUv2T2gjdZiXDVaoX+ag8kJPJLy+
 JJxDOdjqpcw8Si/HHPBnPV6aaUfH3Etxd7K9S4wa6myQBiROb3fSnXXmDwNb6D/LBbnD
 P2L2tvnt0bhZgd1EcyaSuN9mNeJSmpVNhhLPVGQBWCqchENvVod103Avz1zmGL3qbmj6
 X1M2GlpykC4eqJgHScDFFWhqexa/c50F2jQG7qEoA3ACGEs6lchgnkaJn2yzVQHCcRBw
 Brlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762434549; x=1763039349;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sqAs5BScSPndH3II3LN8n2VbtQRbh6MVpjhSHp+Bxow=;
 b=g7R0xjlwV4QFUig0VtQ4OJZc2wZUiqgAkXbVmdLDQTl5Z0ICC8p5gxpM/8X6BTFotb
 rLATCPBQ/LhbRri7U1N7PF81P/lKvMB90m+gagEwvggUYWZWZlzr4nKxH/w/tkPGcX0Z
 +ePef7zguti6IAIQ4W06GkqgRCh4DjvPmGAE+EkQRi9mRWQcyr8TBz/zM/vRjEUjtd5z
 0gjpekNb2kFINZSisnY73N9freiptxRZIiZH65O8WHCodJn+cP17+eXzaQcVdVN/IjrY
 UDvjbArlJUTeXrkxY5C/m1O0fnTNawTbTKLa3EA+XI+5K2HgHPt7SOeS1+H2n2ukxPJN
 0eRg==
X-Gm-Message-State: AOJu0Yzelxzy8djCk18uHnvSX/mjN9frObB9si/G/+IRdvMb+1dHn46P
 eelkNb9rtQUNB4d/C9kqi1d+mJIe50EP4/8hbgLDYVKj50N6JvGp9YvoYd52fWYM440Mig8QDfL
 kQBeLp2kBtHrJV34tkFw5XTD/M+cSCveDAZGvH5MZGll0yLWA0w+uMPoabw==
X-Gm-Gg: ASbGnctRA/JVtvllGsClF+wB+sY24TfgBdENLn1uz5ZVqOuOmdQqh9ZBBFCm57h0zJ+
 I/KUPl9qEAZsOPywCuKtiVbwHagfMLWDFjJQaBCnWeTEh4+2g/oJmhNvk6yEjrr25B75EXqyYql
 FiTPc5pBIcdsKITpL57lmKa4ui9Ns65ydHZE03FI1pS3iUlPTGXPGhOuSzgKssqS+QldMQnr4kJ
 BM2yvPQfngIHWhDA1bLJkrJyuAy/JBDppLLFfR6WLvHQl7lbeDQShZPrllSTO1dv/GnuqwMqwXC
 0HTpO7+O6d2Q/8GbYsPNJlC8vziIIDH8+GW5pwekEA==
X-Google-Smtp-Source: AGHT+IFZRUgwAMJXvuk6bhH6uhsAKthZ9gqNfxGS12VNEzzkbak3MPZ81+aKC4h40bWG8HfKD8u8sNEcaye5N9rTG1E=
X-Received: by 2002:a05:690e:418d:b0:63f:abf6:1a7 with SMTP id
 956f58d0204a3-63fd34b45demr5092707d50.4.1762434548837; Thu, 06 Nov 2025
 05:09:08 -0800 (PST)
MIME-Version: 1.0
References: <20251104214804.18043-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20251104214804.18043-1-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 6 Nov 2025 15:08:32 +0200
X-Gm-Features: AWmQ_bkD1X-2CPwZoxiQWp3YCn5MIgjpFjbKyXtysBPt5Mr7M3dYTkXbVI4DN6c
Message-ID: <CAC_iWjJFs3xBn5CZx-9iRwQR2RgdG9=gz0fN5F0mOjg7=S7VNQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi_loader: typo 'mange' in efi_net.c
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: u-boot@lists.denx.de
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

On Tue, 4 Nov 2025 at 23:48, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> %s/mange/manage/
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  lib/efi_loader/efi_net.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/efi_loader/efi_net.c b/lib/efi_loader/efi_net.c
> index b8a6e08ba8e..0f8a851e3f2 100644
> --- a/lib/efi_loader/efi_net.c
> +++ b/lib/efi_loader/efi_net.c
> @@ -372,7 +372,7 @@ out:
>  }
>
>  /*
> - * efi_net_receive_filters() - mange multicast receive filters
> + * efi_net_receive_filters() - manage multicast receive filters
>   *
>   * This function implements the ReceiveFilters service of the
>   * EFI_SIMPLE_NETWORK_PROTOCOL. See the Unified Extensible Firmware Interface
> --
> 2.51.0
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
