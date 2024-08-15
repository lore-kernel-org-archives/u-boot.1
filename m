Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80C88C52D7F
	for <u-boot@archiver.kernel.org>; Thu, 15 Aug 2024 20:32:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42E8B88BBC;
	Thu, 15 Aug 2024 22:32:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BcxpJwXT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E52B88B99; Thu, 15 Aug 2024 22:32:19 +0200 (CEST)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7BCDB88B9B
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 22:32:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-7a1d6f47112so91975985a.0
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 13:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723753923; x=1724358723; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=36vMcjn1yfsHB8ivh6RRvtcVkc/Pgs2w9bQ+B9C6kLM=;
 b=BcxpJwXTQCT4Ou1SE91Jxhe8RveJQWyH9BZAnL2PHuPP5dtF8vVklVVfYNNRh4CXbj
 syGMgMXBWcarfUSGgaMb0dR1CRkSF/AWzztr1diuHg0Xntikfb47Q1wGpCU2z6T6KtCj
 sAXuiIJzRP9lXHBqAwX5whDlIMt+0DuVxP6XI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723753923; x=1724358723;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=36vMcjn1yfsHB8ivh6RRvtcVkc/Pgs2w9bQ+B9C6kLM=;
 b=qDIpSmfpH8AGUb7ZTidQxr9SJMexSY9V2k07k+NeEH0MjaFSKbI8itlKKIa8a/XUMw
 rk0BK61RwhMUNvOS0aTbK+WtYgw3xbMpyHPqwlEXPJySKKdUpT36SuWDZElGJYZEda1+
 EbBfSpWzrEjAZ6d9NXmUTTi43EqkTi18h2eHEf8CkArNIqh5xp8n6KSHW37wmrCcDmrn
 mLF4YtgTLxGuy/MdxsqQo3GwAVJNtTGlHnmMwiPf3D8KOtXI2uO4q577g5nIEXeiFapM
 m/cWjbP4YTlrmVV2v6XJjP3jwVtdIZOTBp6Qs9rphzJmyzwHztVaYXEmb16OlcXiTr/b
 fdKw==
X-Gm-Message-State: AOJu0Yz8QanRLPw+oQiPEL6kAZS63vVe96V0zJnpwlF+2IJnHqkKuSep
 mCvRxJHdjeIcuPWBFvCX9X/zd+Cnt7JfKPq1sfsmEmsR1yS6YUfkE8mIpYKM4XNwZWX+QJ2D/Ip
 woxhL1WZOrzU+LMpKmY3y3HbxGofjMPJB4v5235GgxhoyPU7cZg==
X-Google-Smtp-Source: AGHT+IGMdQXDkiOGF28Ng/CCnRm2Rnjva/wg9qgCd+mjgSrmPXteDOrXpJUJjDi+289ouQKO3KMu6v8cbogTo4Jf5aA=
X-Received: by 2002:a05:6214:5c04:b0:6bf:6d7a:11c1 with SMTP id
 6a1803df08f44-6bf7cd85a93mr8425116d6.7.1723753923471; Thu, 15 Aug 2024
 13:32:03 -0700 (PDT)
MIME-Version: 1.0
References: <20240814110009.45310-1-sughosh.ganu@linaro.org>
 <20240814110009.45310-6-sughosh.ganu@linaro.org>
In-Reply-To: <20240814110009.45310-6-sughosh.ganu@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 15 Aug 2024 21:31:53 +0100
Message-ID: <CAFLszTh_6rdbYRvD+tv1cXKuRuTYxDUTT199cUcS2Xm11bJBHA@mail.gmail.com>
Subject: Re: [PATCH v2 05/32] lmb: use the BIT macro for lmb flags
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>,
 Tom Rini <trini@konsulko.com>, 
 Mark Kettenis <mark.kettenis@xs4all.nl>, Michal Simek <michal.simek@amd.com>, 
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>, 
 Patrice CHOTARD <patrice.chotard@foss.st.com>, Huan Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>, 
 Max Filippov <jcmvbkbc@gmail.com>
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

On Wed, 14 Aug 2024 at 05:00, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> Use the BIT macro for assigning values to the LMB flags instead of
> assigning random values to them.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
> Changes since V1: None
>
>  include/lmb.h | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
