Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FFCCC43458
	for <u-boot@archiver.kernel.org>; Mon, 13 Jul 2026 12:56:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F00D84B18;
	Mon, 13 Jul 2026 14:56:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fvxo2qx7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1EBB284B1A; Mon, 13 Jul 2026 14:56:36 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A24884AE7
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 14:56:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-69a50b818c8so5118826a12.2
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 05:56:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783947394; cv=none;
 d=google.com; s=arc-20260327;
 b=QFtoWNqll9V5+7RUUk3G6ff6tvP+Z1gMcQw4qjs7CnFNEv9ZPj/LIrcy3peUhZDiOK
 3chNtMPz6gIU+719iFg4JDnluo6XEFIxjlb0XWbFn+RhsKKOG7iUGQ8xQRf266HE55SH
 fiGb6Lcpgf9oLHFZ4BgAClolFDxH3CuDY0WoCPUXR/YUAYx6VBcxKeziSgGVnzINxlvB
 D+IPqmCQ1NEZ4VWKnuaQVuixYsAnsp6RBfrCWSm52EuxlyHfvXRqIgNK7UluTYwK1hrz
 hIzZBlJ1t2GCSnoVtpqlRnl3zQQSnBrkJ40KvFJSsFxTHhJJtvQFJEpYJDsrUfZaYh+Y
 kEAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=5Qa0ODIC/uOXSPAB78PsBxP/RbZ/Sz6BmJ98hWWb/Z0=;
 fh=is6TKv49MgERBAcyxHwJilOvaFSawPXqsCYNk2VrlTs=;
 b=ZjxoX5LqepH9+XvLv0eI1edSnVHUkiIN4O4MdDXd0/vcNIxDRQKlBBH939+npjPZB4
 fcXPaJgRZqFFG2SAQKbkk0/oS4edWjHJCbUVZLOtXNaojO1h9jAf76pjxRMoHkAF87Y4
 HwQHGPu3PMxRQde+HH9TxwQGgDuGe05jwZeov57ry3Ks78wpNflvHYfRsE8YFx0Cmed0
 fv5Ac/DSp/OX016xrmAE81zVkBl/2ENZ6o25yOa3CwQBaC84lhcoUsMAl6O9QN6rNy6m
 5wOka57b7yodRS/C+uDwDj/gRoIBvUg58oQrwOUXs7iyNrX4NVlc8lGH82rUBhZmqA7d
 Fm2Q==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783947394; x=1784552194; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=5Qa0ODIC/uOXSPAB78PsBxP/RbZ/Sz6BmJ98hWWb/Z0=;
 b=fvxo2qx76aO49l2vavEXBxY4yj2/Ra0PPT8oxlUFx4hcN38rbNbxir8Zs2kKhla1UZ
 PEz+Qnb6PRGetiKUQ795F2/BSWvfcDWAk50aCFYXZoYU0n/AK/yyH8XY6LrBu5z0Qg21
 DJl9U7DQe5cyRZ/gzh1mcQrHEkz39qgo8v71g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783947394; x=1784552194;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=5Qa0ODIC/uOXSPAB78PsBxP/RbZ/Sz6BmJ98hWWb/Z0=;
 b=eZdiKg+wWejTe5Dz21mTLv2wYJjW82Z9QO44SMr6IPr2WmqUzExoyzABZP8cPUBwr9
 Vb4VBgrusHECeabmmDu3eNwjBJvhnP8nk/dLL5zEQ/QQgv5UHjLQK5aiq6BH1bbcbB3R
 tglq0AGHdPz8owttkloHhivuOe+c42P8KTkIPZrEkyf+jauaYSP3k/Ay8XtvV+6+brr+
 mfIykF6aYswKe1RJ7UomMGOtCJEAbc5vkCpViC5PBgv53/5IUGi9fUUOJc6n2iN94HHT
 TW8/GqOm0oqQsGIvdr3KFwevY9Hk9EJ06AWDzU+xXNnCSAWiyTuswi7WByHzsIG2LRIp
 PvPw==
X-Gm-Message-State: AOJu0YxgT3ITcI7q6YrX1i2TOPJuUyXX3S2Cl0Cqf626K9F8FxsKWK4D
 wwmJqW7RShQ9YeyycdwRakEdXSGeSOMiD5yLd917vIL5rNnMn4ysQtRawxx8/jou37R2mJJZQ4a
 fM3CEJf9ThH8zF1oOwtT5OpS/S60v1/eDqg7GNgv9
X-Gm-Gg: AfdE7cmyJ7IoCXj5DVG69n7FbnLck28Q75jBWAZVYHMCLT+AyHQ5MnEMMdTYmkt059I
 8YQ8vF9nTEAXKg2YXpllPaEFaj4G/PZvIHLVM6Zs8ZtRB91aYW1AisybwvcfCB+RF+YafG5gr19
 vJp1e5jYMTu2UsYViGZ+8NylHuIDDuYCgDdBY/7DfACxgUT5BKLJ6jWz1IxxEPR4PUZSsmxKlM1
 wFUigKiHfS2QHcyetIdJH1ozvfKKNslFecstQaS5a2CDON1sZE9/Dt/+XT+ZLl9qiDGvf1k5WNk
 RVnRCA==
X-Received: by 2002:a05:6402:4498:b0:698:8f3c:bfb7 with SMTP id
 4fb4d7f45d1cf-69c5f103969mr3699969a12.31.1783947393710; Mon, 13 Jul 2026
 05:56:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260710123618.2036728-1-ravi@prevas.dk>
In-Reply-To: <20260710123618.2036728-1-ravi@prevas.dk>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 13 Jul 2026 06:56:21 -0600
X-Gm-Features: AUfX_mxal28iOVRWYTT0ObJWumHQw7SQtl2o6lbme4QfyWW7Bf57Ss7ihKwyna4
Message-ID: <CAFLszTi2f20JN=LUAjhW=pQP=ytBcATk+hA8-i5HzD-q59cCeQ@mail.gmail.com>
Subject: Re: [0/6] k3-binman ergonomics
To: ravi@prevas.dk
Cc: u-boot@lists.denx.de
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

Hi Rasmus,

On 2026-07-10T12:36:12, Rasmus Villemoes <ravi@prevas.dk> wrote:

> Use the template mechanism that binman already has to allow one to
> only set the keyfile= in a single place.

Thanks for sorting this out - having to override the keyfile in every
node is definitely error-prone. I think this is a nice use of
templates. Do we need to explicitly document how to specify the key,
etc.? I don't see doc/ changes in this series.

Regards,
Simon
