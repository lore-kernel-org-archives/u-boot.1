Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0DE9E77197
	for <u-boot@archiver.kernel.org>; Tue,  7 Jan 2025 15:31:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 09C4080613;
	Tue,  7 Jan 2025 16:31:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IfIoKvCE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 357A7801E8; Tue,  7 Jan 2025 16:31:20 +0100 (CET)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 716BB80613
 for <u-boot@lists.denx.de>; Tue,  7 Jan 2025 16:31:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2ef8c012913so17653854a91.3
 for <u-boot@lists.denx.de>; Tue, 07 Jan 2025 07:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736263872; x=1736868672; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=iDUADFY81dQrA8oAnnRY0pdASJOUsNgF4+66CkWPkvI=;
 b=IfIoKvCEb3HKpvBzWRyn05rjyMhjGqpjb6eWgRSkbhkasAvy+2kQH9dqW/gwAw0Q/g
 1k9AQoe9ikQ/yZrGeeiBav9E60wvgBi2kEvp39rMSrOkPv7Qf+G3QjRiWhMajfFA0hof
 p+COeUQQt4A3lzs+43W63UaqoWy+Joyq4joRE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736263872; x=1736868672;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iDUADFY81dQrA8oAnnRY0pdASJOUsNgF4+66CkWPkvI=;
 b=pJWb0+u+vb+4wyKG7ZoMmeJKEbPBIRcgFIvsFbkncxkWtO0mDetq0LZV4/434+bXrZ
 lM7pNaqxky5srZAftIYGT3Q/Wn8EYxys5oZWR7BY/Fj5t+IRb7JXnGU9MzoW8q1vHeT0
 shv6Pjzg1O0wejiAWgXUxpQ4lzFQg4fNcgUqsodXFSFoLclTpDNyr4mN6VvnQ2floBfY
 OfXWmQUX5jC9PxQXuxndx5lI0dOiPMkwim3BgqDbsPPE6wnjjyt4j8cLl3U/IgwKDrIl
 kRZLKvwHvkAyxTitELZEhPGcOly53X6sJB6LgIvn2Huv1zX07ZF5eLWv5Ntf4l6Tv4NP
 ytwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqdD41BCCQtcAleLguGj7aOxG/of4w6W3lMYTT0a6PZKPKDFYm5GH4aw1/5s8M5cRLH7/ipno=@lists.denx.de
X-Gm-Message-State: AOJu0Yx99aJJY70XeY67IwgSsLMoy0QKvoUmwbbw8tharv2dDs8u5p7D
 Pz0i+A9ye51+zmub2n+ZHoBRf4xta/W48Llnz+9UKnmCo7M2+HoQ2OmYk8R8UstkCp8UHsEV3qq
 NFKScS+EYEL117jLuAXHfGCxOxip5o/5/oBXq
X-Gm-Gg: ASbGnctO1ej67bjmMxa0dJH3dCGA5rl1Xa9xMizs0XbPxb0scj0SJAAcSRo1KcSVLIH
 kM2UYcaqn6SRULMkimpv2Jv4RD7i4E5wKt81fzq0=
X-Google-Smtp-Source: AGHT+IGHhXlVgTjOHDeOlrj3Zs9kk5nMI1U7lVoen3LtHVuYg0vqjW5+IRoSNBdSnsGQgghHwkIASiV/vAyvO+dJ2xM=
X-Received: by 2002:a17:90a:c884:b0:2ee:7698:e565 with SMTP id
 98e67ed59e1d1-2f452dea33emr100586741a91.8.1736263872008; Tue, 07 Jan 2025
 07:31:12 -0800 (PST)
MIME-Version: 1.0
References: <20241124-b4-modernise-smem-v1-0-b7852c11b67c@linaro.org>
 <20241124-b4-modernise-smem-v1-6-b7852c11b67c@linaro.org>
In-Reply-To: <20241124-b4-modernise-smem-v1-6-b7852c11b67c@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 7 Jan 2025 08:30:31 -0700
X-Gm-Features: AbW1kva4ZYUy_1kQsnRYdKVbrivI4YhtGoIM5s74ygdyetZQeCFUiY_xqh8zAdk
Message-ID: <CAFLszTgvWh3654RptgOwVCnzyPCTk-2aV=V7ePX8rcfuR3nucA@mail.gmail.com>
Subject: Re: [PATCH 06/15] soc: qcom: smem: adjust headers for U-Boot
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
 Mario Six <mario.six@gdsys.cc>, u-boot@lists.denx.de, u-boot-qcom@groups.io
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

On Sun, 24 Nov 2024 at 12:17, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> Drop Linux headers for the U-Boot ones.
>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  drivers/soc/qcom/smem.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
