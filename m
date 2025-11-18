Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0613CF2560
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 23:33:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3523083A57;
	Wed, 19 Nov 2025 00:33:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kHFfACwW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6120183CB1; Wed, 19 Nov 2025 00:33:17 +0100 (CET)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4499383A57
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 00:33:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-3ebd1b07919so798917fac.0
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 15:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763508794; x=1764113594; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ajBYwxhtPWtOZmfGnaAhD4izc9VQSOlf8CfmBQU74+Y=;
 b=kHFfACwW4ELVhRwFjuNYgYzI+OF4rjOCCc5KQMe5b+idd7mNn4JVw2jpD/yizv4J7x
 2CKSo2Xy4S4zdiekkf+tSynx77XUJUvjyCspiY0DXAguoj2xFQ/Lv1M297G+5kiKqpH9
 lrYz13w/JfsRGSEGGbgTPnxDFpt+q1k0OSuBQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763508794; x=1764113594;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ajBYwxhtPWtOZmfGnaAhD4izc9VQSOlf8CfmBQU74+Y=;
 b=G3sH1bgO/hGVIMUV1rMquOTuOkJSqN7WLlO6O8+BVQNFdrFSpD0HhnttTBc8vG/ERZ
 1ry9DJIS/9N4SqPybKoho3pn/EhrAL1/Bqi5mBWZVD1k9LXvwrraT+pyCQd7JSp8qoLt
 a+o+5kVSAD5Qc27Ah9bdm7TdeBvkvejK8VR8vjLKx7++0XYzr2G9NIJHZdK+G0NO+TWI
 Oiu0K/JjlSbu9KWBF8KzZEN1P8Ohro1PDwEeZbDbHBOpv2DRDIePz590np9fTbtn/K2n
 B8tu7Aavr5H1i4ixavz4ClzGkJ9u0m9n/nH6WDXQOwrS+M/fHrClr3I0WE25xOQu27EH
 eqsw==
X-Gm-Message-State: AOJu0Yyu4hI+0O9YpsaLrvfExg0ECGHJeVrlj7tdiYwbXTZBtSt6XlHY
 Zy24DW6m78SjZkHAquWwrtp2AKbR9bGp1A/b15ghnC1ypbCdUbe+Cr6u+/kZCkq5kho=
X-Gm-Gg: ASbGncvNPA8wtQylJlcVqXHWu/NZaAeAU0eTFZ3mgVJMuf4LFe4NTYXfptPz/V3tBF4
 s8bi9ev1FWpTDY01MTMttdi+KL+D2ewyuxwRHzfB6qXFZphDmpKqHRtGDEBwVA1NVPbZQrPLqa0
 GJIKSsv1F2MLibNNQcHONDXB6J6MafyMa4LlJKJ22VOSk+wSlFxsKDlNU6Q1oGvpljJhwNd0J5j
 46PfRtrXqjvjK2yvldOgngURI7NkIozem9xKT1biZGFfCQqSCYUYp8EzdnY2grRHZr/EVf+KApa
 xsYVwVJs4HxwGy1QIl1vZywcrUaYEY+Uhq1k6r2AiIkELyEa6u3VWl1JdCXulZXp7JzvKL2LkOh
 iUhngJOUtbkeJFYys/t5b3gCVONItPukXF+4s8+JsVtW9DlnK2zP7ncq89Qdb+O1WtjU1WeubZp
 GUY9Ybc0zXS48qwnh+7R8Ei3J55CM200CIvH7TuzhQ4H6M/Y3j5BB7yjXn2KI=
X-Google-Smtp-Source: AGHT+IEPOCUnVZx3NM4Do/PN2rH/Y6xmbCJxC1Q6hR5zd8qoq4ROeoCEYy9WIWhRKuJ/kux8dY/MEw==
X-Received: by 2002:a05:6871:bd0e:b0:3e8:9e62:4888 with SMTP id
 586e51a60fabf-3e89e6252b3mr4908730fac.47.1763508794014; 
 Tue, 18 Nov 2025 15:33:14 -0800 (PST)
Received: from [127.0.1.1] (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3e89697fedcsm4075794fac.1.2025.11.18.15.33.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Nov 2025 15:33:13 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Raymond Mao <raymondmaoca@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20251106232838.3243607-1-trini@konsulko.com>
References: <20251106232838.3243607-1-trini@konsulko.com>
Subject: Re: [PATCH] smbios: Fix warning when building with clang
Message-Id: <176350879301.654721.8462487276121261537.b4-ty@konsulko.com>
Date: Tue, 18 Nov 2025 17:33:13 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Thu, 06 Nov 2025 17:28:38 -0600, Tom Rini wrote:

> When building with clang, we see warnings such as:
> error: field max_size within 'struct smbios_type7' is less aligned than
> 'union cache_size_word' and is usually due to 'struct smbios_type7'
> being packed, which can lead to unaligned accesses
> [-Werror,-Wunaligned-access]
> when building drivers/sysinfo/smbios.c. Resolve this error by packing
> the unions as well after verifying they are complete (16 or 32 bits).
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] smbios: Fix warning when building with clang
      commit: 2d226a735e0e9df2c017259c72cfd569986db480
-- 
Tom


