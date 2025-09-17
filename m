Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B422CAC59A
	for <u-boot@archiver.kernel.org>; Wed, 17 Sep 2025 15:08:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B2E08362A;
	Wed, 17 Sep 2025 17:08:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GfoOYZmN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19DA4835B3; Wed, 17 Sep 2025 17:08:17 +0200 (CEST)
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D1A3835B3
 for <u-boot@lists.denx.de>; Wed, 17 Sep 2025 17:08:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-621b4d2b2f3so488810eaf.0
 for <u-boot@lists.denx.de>; Wed, 17 Sep 2025 08:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758121693; x=1758726493; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KQ/0Tco8qMmxoMKl6Jf7r8S/pEM++xrIrq/qFrMwGuI=;
 b=GfoOYZmNlUTRxGvMSV8yuiideydPYUlSAK46TESu3YTWJwZpuJyX59kQpHDGa2sV5v
 t4VzdyZOLuiOW8o42XjQO0dBtG0PjHST68K8KfUKin94YspjNbwDtkutccGS5m+zpYyA
 4yXGB23Zx3v4u3sEyAN/De2AOivCn4kKMkFI4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758121693; x=1758726493;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KQ/0Tco8qMmxoMKl6Jf7r8S/pEM++xrIrq/qFrMwGuI=;
 b=o70kd9j4+oAY3jYaKVB95/+zVH1zzpMfx5uMYFCHs9qejIs7p+m8wORL2OG213J0pP
 vbEa2DXz/zmJpsBUP6bnG+Au+grkUJqHYv+E5pOWiByiZvuQWlB2ytFQraQwRR2Qoz1Q
 R8XoPmGc2qN6PVHhkiD7F4MKL9njaiviEhzOT2kZcofB3NjAWlPdP5u0mX5ozKRHSqvm
 3cSPqB1pQ5LSpXDnXItAPu9mxlUpLbgrcqSfEOSgQKC94UIQmVIPXl8EZfR2rdbwtvrj
 zUkHEdiNnH1wOX9liNp1xiqlAtF7o615jM5EI1cPpKea6snLRgEvIEgxI36ZHY0hfs2p
 53Qg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXkTnG+OyEFAv/pfvkbmtvEwCbc7cEdDWsRDDi2SYXLk21vGWFaqgLJOmCvtK1n1l2i4MK7f4w=@lists.denx.de
X-Gm-Message-State: AOJu0YzSV/VVxvMtqHXRZaiNhj0k/J5SX5BizAFgyt97SQmjLBO1CCbk
 Vis4EO8b+wXoKX96vf5WVBKQ/WAZ/RdJP4lgsm8vCJ/lZ2b1FXlkXoEm8JD7p/JB/EY=
X-Gm-Gg: ASbGncvs0VFEnQDxOpQZGi2+x6UjLeTNj+BScoLCQojyZYso0IKMqjgrYIPr1OQB3ds
 ZeswYOwzBuMTAYLH+vlmn7a376AEhb5eGazW/EE97nwvFS6snidmG3+cAW0wygr04faap87STDg
 jFNZpHqjLk3zdTDQ2+83NNS8tSncDfTytcFyvlCpf6yvy2hqENU5zc8jHVvtQHTSNPsOZyx8xCd
 owq0b1aDgwXLyt3xGMspZ4eb67rk/CxB2T9YTi514MSdXHyuLVC9JRTxviP4iIsT9/yk+lAiFvK
 EkMqrhgVDApQXBs+84gCaTgCoeN9voeZUpwhAQkDLRUxZfHUg06WUCCUH9vzTjvcoUT7DjaBpLR
 1960kfWLigwCMjFwZjwFRtZWuiX8HE1TNdEB6XlW/aO6hvcCDbev0u8U=
X-Google-Smtp-Source: AGHT+IGFdAyO/HAgP4scAsjWgVUd7PeQxEA0jzWHhFVexMLzeH17VW2fAjnqQxvWmVhs6GHQcPoCtw==
X-Received: by 2002:a05:6870:e090:b0:31d:6445:d6b4 with SMTP id
 586e51a60fabf-33452170a38mr3284092fac.9.1758121692964; 
 Wed, 17 Sep 2025 08:08:12 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-758b2883055sm2981354a34.45.2025.09.17.08.08.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Sep 2025 08:08:12 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Anurag Dutta <a-dutta@ti.com>
Cc: n-francis@ti.com, u-kumar1@ti.com, u-boot@lists.denx.de
In-Reply-To: <20250917041729.3460570-1-a-dutta@ti.com>
References: <20250917041729.3460570-1-a-dutta@ti.com>
Subject: Re: [PATCH v2] board: ti: am57xx: Remove "ti/omap/" from
 name_fit_config
Message-Id: <175812169202.761188.13173206159809748698.b4-ty@konsulko.com>
Date: Wed, 17 Sep 2025 09:08:12 -0600
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

On Wed, 17 Sep 2025 09:47:29 +0530, Anurag Dutta wrote:

> Commit 649f4a7d3ca7 ("board: ti: am57xx: Set fdtfile from C code
> instead of findfdt script") prepends "ti/omap/" to the actual name
> of the fdtfile whereas fit image boot needs exact dtb name. So, remove
> "ti/omap" from name_fit_config by substituting it with an empty string.
> 
> 

Applied to u-boot/master, thanks!

[1/1] board: ti: am57xx: Remove "ti/omap/" from name_fit_config
      commit: f6d5bda0e32c3d645b9926f6965af8196843c62c
-- 
Tom


