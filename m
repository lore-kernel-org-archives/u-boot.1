Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5542DC54ED1
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 20:20:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8381C833D3;
	Fri, 23 May 2025 22:20:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HcJa8stz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E86D833E8; Fri, 23 May 2025 22:20:41 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C8C9833CF
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 22:20:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-601a5747638so425526a12.3
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 13:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748031639; x=1748636439; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lPLBg9ProOwYEfqrqxruyuWmf7tPJXPdbz1zRAPdQ7o=;
 b=HcJa8stzCoOPjy+/CovCJ0xIEdmLG+KEyMvrWWKkuaFjjtopBSF0m3gtjxyrxk+PY4
 SSea+wP8z/dmWcfJfkKouNq+jE2l5mh/BeeX73dIPzFhUSAAOEl29DCbcU4V5GMYCcbf
 DGySM5DuBNJ5dpBDNpI7lsjknk9eqyC26PwOo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748031639; x=1748636439;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lPLBg9ProOwYEfqrqxruyuWmf7tPJXPdbz1zRAPdQ7o=;
 b=FKTP76Rr7XNKc1FtazhDzij+SiqA+v7LtVi20GsNXCdU0m7EFT5Hrw1UEdy4eJw3e7
 945P8FZV0nfu/uuvuI3zuJ8Z79w2+K5MAo+xDozbvQxVKW7d42W1GJEwH1alxApRtQa5
 F1Z6eaAutFy2e31s05xs+b4TSBJk6ZQz86I96YvuudZVQCLqvI94mU5e7eO/NrSyTN9H
 iF9Q+9GxknllbzKI+9znMe50SN8ZUS2E5juJi6m9EgAPKLERyy5ueBCxJpKh2SEKpdsB
 8cOad5bmE21vC26Jf1eC44pS8ixO2Mc4NJzcA58i1jXkRkzNN/cilauxM+QQ4SgzofTe
 ZpOw==
X-Gm-Message-State: AOJu0YxFnBASlMIr8BGLI6d4hYHgE3+AB+4RpwIXl8I/bW3CKGCG+SRQ
 SOZBFx7nkS91G9Tcckkm3XCf951+QD4HCrD21e4HwDudaJK/SvLV3MLQLpFhFhiqnoVz45Bj7dK
 farp1Lcau5q06DfkKYcv2DWhPw8QWCLm2rxId5hFM
X-Gm-Gg: ASbGncsPe5GaNdpS/Ms6qxZIln8bLYj6ZYhltnQdkR9MdN+4WdYMtGdg2R6vX9b2+EL
 SG/T3JP4ivtuWchAKNDAUoCLcYprimuTqxEMCX49BqcOE0Ard2cr58lCwhwAh7jnVsJODg0URKP
 cmwYNQQUz9KtmFQUu6O5talpLSV8XI0H0=
X-Google-Smtp-Source: AGHT+IHb9bkEU+w3HYUs1UEEWuYX7m7q+p5gPBk7iMAkKTLJLaA8881rNUkE6saC+0CGF7XgSGYJ/PAMsMlV4g6FF3Y=
X-Received: by 2002:a17:906:f58b:b0:ad5:557b:c369 with SMTP id
 a640c23a62f3a-ad85b1c2be8mr44133766b.33.1748031638925; Fri, 23 May 2025
 13:20:38 -0700 (PDT)
MIME-Version: 1.0
References: <20250428192427.3877612-1-swboyd@chromium.org>
 <20250428192427.3877612-2-swboyd@chromium.org>
In-Reply-To: <20250428192427.3877612-2-swboyd@chromium.org>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 23 May 2025 21:20:25 +0100
X-Gm-Features: AX0GCFuQgnWtiF0Fv2zIJJBDCzdM7CTZCGU1KSHytuomQddv3h8fShlukq4wcu8
Message-ID: <CAFLszTj_dbnxPF6YFRfQojFiK18NRLwH0cPHStXVgWXMU8pBgA@mail.gmail.com>
Subject: Re: [PATCH v3 01/17] bootstd: cros: Return negative error code
To: Stephen Boyd <swboyd@chromium.org>
Cc: u-boot@lists.denx.de, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Bin Meng <bmeng.cn@gmail.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Jagan Teki <jagan@amarulasolutions.com>, Anatolij Gustschin <agust@denx.de>,
 u-boot-qcom@groups.io
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

On Mon, 28 Apr 2025 at 20:24, Stephen Boyd <swboyd@chromium.org> wrote:
>
> This should be negative EFAULT to indicate an error code.
>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  boot/bootmeth_cros.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
