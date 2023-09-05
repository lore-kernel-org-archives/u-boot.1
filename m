Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F208C83F33
	for <u-boot@archiver.kernel.org>; Tue,  5 Sep 2023 01:12:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 248E7864DD;
	Tue,  5 Sep 2023 03:12:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ANZtibYt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 884028071F; Tue,  5 Sep 2023 03:12:45 +0200 (CEST)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB280864DD
 for <u-boot@lists.denx.de>; Tue,  5 Sep 2023 03:12:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-58fa51a0d97so18482937b3.3
 for <u-boot@lists.denx.de>; Mon, 04 Sep 2023 18:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1693876361; x=1694481161; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=IXbJ8rfolU0Xf1pnK8h1boIe3ibamSaOqLHq/jhgMtA=;
 b=ANZtibYtd56fQLTw2o7w0sdLrDyP6hH3KFBdB0NQArlgInGCQ4iSTpwyn2bbgHDNQe
 I01AnaF8nKUCkhI+lbUf1v3OM5V2RmjCv2FJae9V7+965tCcTHTRnmX9JAxL4QbSCyNc
 MZB3Jxvmz/ndULrRxmxcEYrbClsmRXHa/Kohk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693876361; x=1694481161;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IXbJ8rfolU0Xf1pnK8h1boIe3ibamSaOqLHq/jhgMtA=;
 b=kduZ34hppgZKEDK5uP76xfw+ejn0ceoBk0cJJ6VEVzfGG0KfVE7b2RwovE8eBPs8Rk
 gOqcNXrh1Ko4Wl7GEpkc9iIZB5CX7tn8P/VPmeRoffr7Qyfn0a2QiApOFlkZGct59szE
 JsOrDxs3WweIU7QObgp0YZ++sAEAmUv/1l7t8ghoPZx5hXyyuuKOE1Qyp2sXFXr2g7zh
 DcOcV2TKa+Y2UNGkpjT9yCY1FoI7kimBKpFl+IUQJ1CcJR4f3CpbTL2rdNYqzm9tC87W
 aA17rnFtDcNTQGs6+AM73bLfEvDa6mOHOnkmjDSplCr4P31b+aNYIN25U+jjioBbwmsO
 LAyg==
X-Gm-Message-State: AOJu0YxJZaMhtB0HGovKeV9LrWQj5ghPq3u5RlFu2vSSz2fUzP3nWQxB
 sOsOALLgyD/9pFD2q1Po0cXOuUj04tGk3Z3CqbH1ag==
X-Google-Smtp-Source: AGHT+IGSKxZeZ8RO3Fh97m/+ImAEQOGIhdrGoE2DNN7QTOj+J0PKtMRYZfYuRk1c4PfnmI62CONbGQ==
X-Received: by 2002:a0d:d597:0:b0:576:93f1:d110 with SMTP id
 x145-20020a0dd597000000b0057693f1d110mr11423962ywd.14.1693876361264; 
 Mon, 04 Sep 2023 18:12:41 -0700 (PDT)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-51ef-a95e-1d1c-c7f8.res6.spectrum.com.
 [2603:6081:7b00:6400:51ef:a95e:1d1c:c7f8])
 by smtp.gmail.com with ESMTPSA id
 a1-20020a0df101000000b0057a67df3308sm2868829ywf.101.2023.09.04.18.12.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Sep 2023 18:12:40 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
Subject: =?UTF-8?q?=5BPATCH=200/2=5D=20Remove=20Pali=20Roh=C3=A1r=20from=20MAINTAINERS?=
Date: Mon,  4 Sep 2023 21:12:26 -0400
Message-Id: <20230905011228.4006020-1-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
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

Pali,

Your actions on the mailing list the past several months speak for
themselves. I do not feel the need to summarize them again at this
point. You are a persona non grata to this community at this point and I
am now removing you from the MAINTAINERS files because of this. The rx51
platform is being removed and if you know someone else who wishes to
bring it up to modern standards they can submit a patch to bring the
platform back.

I do wish to thank you for the time you have spent over the years, but I
do not know what changed more recently to bring us to this state. I
believe this is best long term for both you and this project.

-- 
Tom


