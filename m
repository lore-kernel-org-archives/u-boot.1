Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A05CCCF9EA
	for <u-boot@archiver.kernel.org>; Tue, 28 Oct 2025 23:58:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D02E0838D7;
	Wed, 29 Oct 2025 00:57:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Fzpz+MLw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1C05838C7; Wed, 29 Oct 2025 00:57:41 +0100 (CET)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69F3383826
 for <u-boot@lists.denx.de>; Wed, 29 Oct 2025 00:57:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7c52ce8cbe7so3564700a34.0
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 16:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1761695857; x=1762300657; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Z7rBDispZpCqsO4ql/kY9mvklmtWbom8Fr5++Kr90CI=;
 b=Fzpz+MLwymcIPpjvuNUDx4Zf2WbketbtU9VWC5Eleifvw/RteO32fRaM9I8GVUncVU
 kKxwyIzTwYJUl6LYiftUXe2hbPGBMe8pjDKLW3EWeglK11kGoZ9SCRvkUesyMNW1WHt+
 HQNd7epmXnF7rnAeN9Fs6WMACjy4rkQtllV5w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761695857; x=1762300657;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z7rBDispZpCqsO4ql/kY9mvklmtWbom8Fr5++Kr90CI=;
 b=UEFyUgjcWsx+nwgS9+I0NoVpSjx8iNqAK1M+PpBYazbBMMUYCA3iIThVsPxuubMWg1
 sTz/2zgzRc61MoG9+gMDDpceVrQ6aecFPY1XpF+40tRErkqDY50yoVnB/Qr27nrSdptE
 kBMo94kzHhk9gTfV4XU5bQBZq2t0ZY0oZ21O8D/vX+KV9MVUPHM2YvecEu0LDreAjAGl
 4utHpNX0FTvV4fs6npGDeKEg4+uct1RfrHSLsb0MlBNsAiJCPwhwgD8pylgSB6Ca7MkY
 O2x9bSNqOzrdUndFcjiImwhHBbEoabWISpyz4L6m97s15LmeSHekOaBGF7XMgctSCv13
 9oxg==
X-Gm-Message-State: AOJu0YynhEorHbchLsEWg15UGGjfJ5RLu9lcTeGSeDKN/Ysbh8hfhZan
 Y3k2XXAOQRA1u3A7Y18OEJDsiaQrQCIb1ZLM4nNhzU6yN+LpQseyGiFw+bPmNXvbOPs=
X-Gm-Gg: ASbGnctSMxVZpjJj6RMnTwDtr9MKKlFdWmah1VpeGKUo8Qwt+FOzrcAE8GUcuBMsXkY
 fJWvQ7BWngHf9zHdd5srKmWnQPbPF9sN5jRjZIO/Pb5RvSX02qIvFwfy5+wSPXG5+6+JvDPVmPC
 zs2TD1kZ7zqFe92VGMgiTnVOBfeVLS97fwAYN4wg6GctXB0nMdTw6HT1OKydqrjOr6dQ6zt7JCi
 puz7ZZZJWD2BzBlSRCJ9O4niENkc8E4izRDn8ugwCDaVu0Zd1Nq2QXpMsTJsQujIpVh4D5h8rqz
 t40ZzRY5+AuzC6Bitak8YtPXy1ATsdG+liXhJOKfQIQgw/b0cg7QpVVQwY9Da6zLdMqzOtx6Rdp
 pOGfT/YfxFAvLJnjTiQMMPGsOt+Q2KLtUE8g4KA4ZjteEGKS5xmrHcKjqyREh377gwppAwm+vYu
 GtLaf0DnrtxunMWu9IupTAW5cZqaHtP6ZezJKatwbpawKitMw8
X-Google-Smtp-Source: AGHT+IHgFjDg10EwSCqRuw8BuJ6+BNQV9KozROLY7Rp9uPnmIGNovhOAi8CoIQdMKOS8mGusJfyXZA==
X-Received: by 2002:a05:6830:6739:b0:788:d698:a0ad with SMTP id
 46e09a7af769-7c6830ee6ebmr781859a34.24.1761695857113; 
 Tue, 28 Oct 2025 16:57:37 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c5302068a6sm3646234a34.25.2025.10.28.16.57.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Oct 2025 16:57:36 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20250711152019.2225509-1-trini@konsulko.com>
References: <20250711152019.2225509-1-trini@konsulko.com>
Subject: Re: [PATCH] x86: Rename arch/x86/include/asm/pnp_def.h to
 include/pnp_def.h
Message-Id: <176169585606.2287207.1337547373383116457.b4-ty@konsulko.com>
Date: Tue, 28 Oct 2025 17:57:36 -0600
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

On Fri, 11 Jul 2025 09:20:19 -0600, Tom Rini wrote:

> There is nothing x86-centric in this include file, and moving it will
> allow for some drivers to be compile-tested on sandbox.
> 
> 

Applied to u-boot/master, thanks!

[1/1] x86: Rename arch/x86/include/asm/pnp_def.h to include/pnp_def.h
      commit: b901d8f15c3b623e6eb01c397cc3140d31388016
-- 
Tom


