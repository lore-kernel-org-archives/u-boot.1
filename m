Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C250C02188
	for <u-boot@archiver.kernel.org>; Mon, 27 Jan 2025 22:39:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D77D812BB;
	Mon, 27 Jan 2025 23:39:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HTOzm8+/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72C74812C8; Mon, 27 Jan 2025 23:39:42 +0100 (CET)
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com
 [IPv6:2607:f8b0:4864:20::835])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5074181265
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 23:39:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-4679d366adeso50710611cf.1
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 14:39:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738017579; x=1738622379; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=57dGAO52DOXo/PswlecUT572bL22qy9TgJmQCEy7Ivc=;
 b=HTOzm8+/PBM4hVGS8st+jSVYTOqFc81CbXoD1b3JrWpJENHJWK7xQZt+yB7ttw6z1D
 fT3lbLAgQleQS1g3zIdRW5eGmdUMUkogK1rQl5hQnA5zCSCif8OJ8vJyyokQ91azYh1P
 YosKE4XhGa7yVgnZokY8nmQLz1kIHjeAAG95Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738017579; x=1738622379;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=57dGAO52DOXo/PswlecUT572bL22qy9TgJmQCEy7Ivc=;
 b=N0O4olsGCbyFJEdvFW/V1LqQnboNfm1+gI7T1DWTZx6u9ZYYIyXRiMVcb/TE4QVFFS
 FhM1SQNjjbS0+znW+3gfOCByW1OYhfq+8xL5KDXXQgVdZAxLJUI6SUiULXyJ7OCtL/UH
 cSr/9ZpVwq8FKugZmP/StmKiA8gp0GAse3oOi21rjygszUS9L614g5jK8JMDKgYWqtFE
 iIpX8Ao7CQOr3cIY8H7Am+nrVolCS+6tp7rvDwrOtiyr2iMGE74RdlEtmiKUi81mXb2A
 tDR2Fd4Xx1ggDefbZvLhRlRaXka8Ssi3ZFz4R5P3cQDA5fKfzNhKZXYjr/vBwfMarQ4g
 Ta2Q==
X-Gm-Message-State: AOJu0YybVpB+AzjA30HVZTWPZzmafn/ncJV72Gi8kQ6re0n5ZEWTrccQ
 ZlGhLTy9loLzjvqx5EciFa5UOkThwALJmtCEtTeVmBUBUiI1lBekbo168j/KHkfGZ9QlqyGsYyn
 k
X-Gm-Gg: ASbGncu1AQlJ35DrMbBrCUEO3eLphisyPgRiatzyczro2II1ZNI+BwFpkhQTbHuD0Do
 6wWKVARal4oeSD3Jee3kV32KQn+XEqN6fo2E5BJ12e6IqoqoDrWe2U14mlSJLXJoOiVnqVCZG2I
 7b7CsaUFYoOaafY2OjSsXV3rbpbKVELQeQd9qcPhk+lv6sRaCidG6NqwoWtmmEbYwr+xPut2lw9
 HjxgiZttRZtNGoNgjOlvGLQ0gaPAp3qe9VopKfhd90fKChaxUg76LhCM9OoZX0gNXjG81vgC5D3
 Xq8=
X-Google-Smtp-Source: AGHT+IHWQet3wefgYuJ0mPzplL/hWkZsvWF/TKdW2eeT2eZ+ZjHDyYLgc4X+EqEO4I3mTOK8FhEULQ==
X-Received: by 2002:ac8:7fd6:0:b0:46e:22f7:7a3d with SMTP id
 d75a77b69052e-46fc497a332mr16244721cf.8.1738017579189; 
 Mon, 27 Jan 2025 14:39:39 -0800 (PST)
Received: from [127.0.1.1] ([189.177.145.20]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46e6689d3eesm43582751cf.36.2025.01.27.14.39.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jan 2025 14:39:38 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: vigneshr@ti.com, u-kumar1@ti.com, bb@ti.com, 
 Santhosh Kumar K <s-k6@ti.com>
Cc: u-boot@lists.denx.de, n-francis@ti.com
In-Reply-To: <20250123083626.1035262-1-s-k6@ti.com>
References: <20250123083626.1035262-1-s-k6@ti.com>
Subject: Re: [PATCH] ram: k3-ddrss: Set SDRAM_IDX using device private
 data, ddr_ram_size
Message-Id: <173801757726.1156504.6289835628753872428.b4-ty@konsulko.com>
Date: Mon, 27 Jan 2025 16:39:37 -0600
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

On Thu, 23 Jan 2025 14:06:26 +0530, Santhosh Kumar K wrote:

> The SDRAM_IDX in DDRSS_V2A_CTL_REG describes the number of address bits
> minus 16 that are used to determine the mask used to detect memory
> rollover and prevent aliasing and false coherency issues.
> 
> Set SDRAM_IDX using the device private data, ddr_ram_size for K3 family
> of SoCs.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


