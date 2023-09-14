Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26100EEAA74
	for <u-boot@archiver.kernel.org>; Thu, 14 Sep 2023 20:25:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F3FA864B3;
	Thu, 14 Sep 2023 22:25:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GvH4TSF/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92ABA864C3; Thu, 14 Sep 2023 22:25:34 +0200 (CEST)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89B0A863ED
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 22:25:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-58fae4a5285so15667137b3.0
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 13:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1694723131; x=1695327931; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gWYmT945piXEFAxb8+1ep4yq7hNqVnUDSEAQwdo6BtE=;
 b=GvH4TSF/WNLCpEX8DmJ12xkidecwu8FW2hA+RsTg+rhdG/i9DHuE8nK9aKjx8ZVMvV
 aJJJnyMZ5ZVmMwsMFmR0oyrmFkhxhzcuN+g4ZJgDk5bFQ62psjc/DQpA6JlOAbOqIlUg
 IrteBHYWkAVpmWalC7220Y8dU308bnjHV7imw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694723131; x=1695327931;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gWYmT945piXEFAxb8+1ep4yq7hNqVnUDSEAQwdo6BtE=;
 b=b/HrE2VZkvBfvV6AmNy7mu5wms+433IpKpmRjmPDiksPeNVqZe9YfLgPI6ZKvN1Xjs
 gEIzq5wNonfDNTSz961dGk65ZXzxQCiNLJjyrafYyEt6YFYikKz03lP5m/Z5WCZ1CapN
 1VRr9OxAIYJmfU4JmoNZlum2x1Q05mVhbXleJuOSY4oeU+4u+tvB2XN3MChlhE+tsv4A
 9imLd2ggORxq8GR+pdIpPDT1MjwTBjxMeXiFEdU6+sT0v6h38DzyCa7gF7T/vd5FZb5+
 sN3DZVUZMfMIidqtb8eZ11+PrHm2tWHFaoWKMCi1+NxL05z92CptDX4Nd4TTkgliKC7D
 /5HA==
X-Gm-Message-State: AOJu0Yyp0nARYNHj8/J3D41XzuUxBhsXaDIen/rTr+UyTszpRg3aGBqJ
 uIjVGm0Vs8CSPUIBPDLYxHgyHoEYvMd+ozNNGCroUQ==
X-Google-Smtp-Source: AGHT+IHlGujTTnGOxWJS4XlKHEeqEScDFy7OdtYxRuu1sxNIlw0wO8D1XPu6xcO7AC8fYYE5IUscAA==
X-Received: by 2002:a0d:d247:0:b0:59b:2be2:3560 with SMTP id
 u68-20020a0dd247000000b0059b2be23560mr6292569ywd.48.1694723131140; 
 Thu, 14 Sep 2023 13:25:31 -0700 (PDT)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-d1a3-6cda-a8be-914f.res6.spectrum.com.
 [2603:6081:7b00:6400:d1a3:6cda:a8be:914f])
 by smtp.gmail.com with ESMTPSA id
 c127-20020a0df385000000b005463e45458bsm501929ywf.123.2023.09.14.13.25.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 13:25:29 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de,
	Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: sjg@chromium.org
Subject: Re: [PATCH 00/35] treewide: Remove unused NEEDS_MANUAL_RELOC code bits
Date: Thu, 14 Sep 2023 16:25:28 -0400
Message-Id: <169472311537.1507631.3823107473012828432.b4-ty@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230906213015.203437-1-marek.vasut+renesas@mailbox.org>
References: <20230906213015.203437-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

On Wed, 06 Sep 2023 23:29:40 +0200, Marek Vasut wrote:

> The last user of the NEEDS_MANUAL_RELOC has been removed in commit
> 26af162ac8f8 ("arch: m68k: Implement relocation")
> Remove now unused NEEDS_MANUAL_RELOC code.
> 
> This is a follow up on way over decade old commit
> 2e5167ccad93 ("Replace CONFIG_RELOC_FIXUP_WORKS by CONFIG_NEEDS_MANUAL_RELOC")
> "
> By now, the majority of architectures have working relocation
> support, so the few remaining architectures have become exceptions.
> To make this more obvious, we make working relocation now the default
> case, and flag the remaining cases with CONFIG_NEEDS_MANUAL_RELOC.
> "
> It took a bit longer than expected, but now we can really sunset
> CONFIG_NEEDS_MANUAL_RELOC.
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom

