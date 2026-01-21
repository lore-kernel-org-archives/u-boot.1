Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 777C9C44506
	for <u-boot@archiver.kernel.org>; Wed, 21 Jan 2026 19:19:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A006483A6A;
	Wed, 21 Jan 2026 20:19:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="eddNn1ZE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE12A80077; Wed, 21 Jan 2026 20:19:04 +0100 (CET)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF13783946
 for <u-boot@lists.denx.de>; Wed, 21 Jan 2026 20:19:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-45c87d82bd2so164741b6e.1
 for <u-boot@lists.denx.de>; Wed, 21 Jan 2026 11:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1769023141; x=1769627941; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nkEchSoSexaHVgJKs+4gtOwQ9G2OJGG51bljPkUYXu8=;
 b=eddNn1ZEnUA2Nax8gl/miax/uFtE4PYKNsj2ehAfG/LLwogP0GJOYRROl4ZhFfGY0q
 6IhN4UHaGdiVMKNyfHsZXn0SLXidzMLt2966agIHKjI6pcahyv8L+F0acXzV/FMntFUt
 gJJvenadWg8q36/UhIy6UqV7+BlbiGzptvfBQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769023141; x=1769627941;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nkEchSoSexaHVgJKs+4gtOwQ9G2OJGG51bljPkUYXu8=;
 b=JBbEUXpEhWNPL/vsnHP2EVbf/fjWl3w3RWldWScgdZIJ+9T7PSMnnhRWmlu58gmmpS
 CVTfbT2SxuS3rTUHduac7A8zKiQ5cQXo05C5+ZIDn1WIgZx38459cXMN9seWvrcQ9RFv
 BHIqfF/9QcidpJuR834PpfwUgcFAdaYAVIAXOosV4XHdRS7WHoEgnMzTadI2PWKtpST+
 mJUlHcNAOY/Gm3b54ToKgCFn6q3xkXgqt/1JZp/HusqZp0w58pa5ziY/Ff5T0wU/cIB/
 AtseH6RR2ketwKCPYZdfHY6Hh9+hodEl2o2MJt2BQs61svJaRecdbnrikHX6VkjLU/kt
 DeqA==
X-Gm-Message-State: AOJu0YzUb46Us5cCaMVYjImZJytmwTsd8dSGhl/FqW66IG3INIQ2v9UR
 t83AUpe7CJIZu1Kns9IkMMas/FxePJIce5LJDMr8cdh1PjIJ5kOAqW1yjb61HQ1InnXerRLahmx
 BvBPrNpk=
X-Gm-Gg: AZuq6aJQAYqidNe9xYn/acawmHGqhDLsCNkYmKJ0m9qj+pXjC7gDyTSO77GU11Xri47
 QSGYjIo/tf5KB3izxqfFCW2eyzMygquqU3b0QVZdhg0eNnctGaMADYWjUDwhTNVfXwlxGuKj0pj
 fqFTKjaj0eLovVqUVSQAIF8H4zcOrKc5t0W/GOMcC6CkCVVd9gcqbBFt5MDsK2Ph7GVAjLuGwnw
 ZVtMvH2Vyza2uAz8BYfTiThq6F4NPU3BSzPdGNcfd2Y/FMGKfo+DLUttXevdaQg9JMdix4ukY7I
 eHGeP9W/w7SHSn9UOp6My87laTlp6OV0fFLI8QR4fTm57cr06NuHNav7jGajG7OJmVbjeUWwkDl
 pK1np3g1h7XoCgw7qbdndue+WuWOlwsKA33NdUqSVvDW2tNu0KuYPxbjz43iB5s3LEv5a0p2VLl
 7bRt4KI7QXZLnp3u3ptmruRLSgEABEvdS8RzjFFHw4/CnxwqsMAQG8DNlCeVB0RlitSlqPmFxmM
 9qTndIbk4GvBimoMhVSex4B/xeqJJvotfwp8w==
X-Received: by 2002:a05:6808:1d2b:b0:45c:a3ed:8fce with SMTP id
 5614622812f47-45ca3ed9338mr6143216b6e.19.1769023141506; 
 Wed, 21 Jan 2026 11:19:01 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-45c9defa8a8sm9181560b6e.6.2026.01.21.11.19.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jan 2026 11:19:01 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: t.remmet@phytec.de, ggiordano@phytec.com, 
 Wadim Egorov <w.egorov@phytec.de>
Cc: u-boot@lists.denx.de, upstream@lists.phytec.de
In-Reply-To: <20260114090351.3419641-1-w.egorov@phytec.de>
References: <20260114090351.3419641-1-w.egorov@phytec.de>
Subject: Re: [PATCH] board: phytec: Add PHYTEC mailing list to MAINTAINERS
 entries
Message-Id: <176902314082.643148.3356920032970139381.b4-ty@konsulko.com>
Date: Wed, 21 Jan 2026 13:19:00 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Wed, 14 Jan 2026 10:03:51 +0100, Wadim Egorov wrote:

> PHYTEC maintains an actively monitored mailing list for upstream
> activities: upstream@lists.phytec.de. Add it to the MAINTAINERS
> entries for PHYTEC boards we actively develop and contribute to.
> 
> 

Applied to u-boot/master, thanks!

[1/1] board: phytec: Add PHYTEC mailing list to MAINTAINERS entries
      commit: e1561ac2de16525a5952f8239c6477cda2cd9212
-- 
Tom


