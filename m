Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB03AC3DA6F
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 19:40:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C8B486926;
	Thu, 24 Aug 2023 21:40:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uma6fhBe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6FC6C86944; Thu, 24 Aug 2023 21:40:53 +0200 (CEST)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BCB4C86923
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 21:40:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-58df8cab1f2so2911437b3.3
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 12:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692906049; x=1693510849;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B2RIK8CyvDmx4W+cHTII1YlNUui0h13SRo8mbRR1dlo=;
 b=uma6fhBebSq9IsPt6dLkbbLCezZt835JVQLcL7lFf2g6awImAk7zMP6cB4WTe2D6l8
 6fbaVgy55iEZoZfWqqMQVmUak4UbGBDAqqTV3MXJ6IVp9owJQPlvDIbBbY/QZcFQ4xY/
 oANRYvzFAmMfclc5lp+sQ02JdaMmhh9Y4CnLs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692906049; x=1693510849;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B2RIK8CyvDmx4W+cHTII1YlNUui0h13SRo8mbRR1dlo=;
 b=kluf1zaoLO6oB+PUb7kWgCKG22C4Jld8X8TzE1BDe8U1pyPVbck2K5qHrDIfy3VLzN
 wAfKIqrWTa7nP4UI4//4uqKdVSGSy/Bmg4cX+7uo2/Ye2MuOlwzBFszQ/dWwyn5y2g0b
 X+cfpdxSyca3X7ttMnl1iEqZBFoSKblqxoTKlMyNIfknUE3gVfbyV9I8Q3ZkLgQpA/EE
 2eK/G9bZwK2vjw9/0GKbk9jXNaVyzT04S9lXTm/jnNR04MVzeRu5/IrIwpGx0Lq6CoYU
 4VE8V7Z2OIfBL9e6VMPp+Ztxhql3sOi8eQHnRePUFhBQMksXEbWqM4OiT4vTmVMzruvj
 r47A==
X-Gm-Message-State: AOJu0Ywso2OAf2w5ZL6dkfAo8eEp42Z5QEtdKR13zWm0z7KhTPAI6Yng
 OHOaY9h9yKRAlw7muKgohSXi1f21jztKs/4peF3C1w==
X-Google-Smtp-Source: AGHT+IFYpNRzdlKy9J/ad3pSf73P99XHkzihg4h1B1yw1mMeM5FyzbjdAlHi0oiXzS93yyZSCtZFzA==
X-Received: by 2002:a0d:d644:0:b0:577:bc0:2d55 with SMTP id
 y65-20020a0dd644000000b005770bc02d55mr17984060ywd.33.1692906049331; 
 Thu, 24 Aug 2023 12:40:49 -0700 (PDT)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-37ed-1199-bcc5-406f.res6.spectrum.com.
 [2603:6081:7b00:6400:37ed:1199:bcc5:406f])
 by smtp.gmail.com with ESMTPSA id
 j125-20020a0dc783000000b005463e45458bsm65620ywd.123.2023.08.24.12.40.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 12:40:48 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de,
	Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Bhupesh Sharma <bhupesh.sharma@linaro.org>, Faiz Abbas <faiz_abbas@ti.com>
Subject: Re: [PATCH v2 1/7] ufs: Convert quirks to BIT() macro
Date: Thu, 24 Aug 2023 15:40:47 -0400
Message-Id: <169290602339.2656175.16008219378050933565.b4-ty@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230816150555.245028-1-marek.vasut+renesas@mailbox.org>
References: <20230816150555.245028-1-marek.vasut+renesas@mailbox.org>
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

On Wed, 16 Aug 2023 17:05:49 +0200, Marek Vasut wrote:

> Use BIT() macro for quirks, no functional change.
> 
> 

Applied to u-boot/next, thanks!

-- 
Tom

