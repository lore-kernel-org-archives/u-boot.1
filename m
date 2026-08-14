Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C39DC5B572
	for <u-boot@archiver.kernel.org>; Fri, 14 Aug 2026 22:53:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4857F8130B;
	Fri, 14 Aug 2026 22:53:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wbQjvFS0uVSP; Fri, 14 Aug 2026 22:53:32 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9E90681307
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786748012;
	bh=8y3MhtxOq6JyUN+JbSSCPPlS6k8lCVS+gjUmAKpjPYc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OFWGgXODrSex1yf9N4PZR4mA3QLG4h4k0iwU6v7VVE6u9LXhGd/izePFJQxUKi+EF
	 hjOzkRQlZe8TfxGcaOOmMzRPloq4FjXxOg4UVEtjLmuKEyguNgXknvFHaMmkT2GObd
	 3/uJ7DUzs2mn3Bc3HiD0NEUFihCdTCutgjY99b40ZkPBMw54hxTG9d65UtDBSnzOAy
	 I1WDWTn3dtL3vVGA2msTtci+xrywtxKPFQOpj5m+l+FWiT1CcAsnkgewtw1VrqqQjl
	 GLTSXW3hsOAXbxGE9f6mu/lzxitOT7v9ppZNMN98eWlrfrgNepUZkw3AnnN/Yw0N56
	 aMWI+G4e+0XPw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9E90681307;
	Fri, 14 Aug 2026 22:53:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 620B52B2
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 22:53:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 60025608FE
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 22:53:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IydVeE64vO7A for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 22:53:30 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::530; helo=mail-ed1-x530.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 74C0260A50
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 74C0260A50
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=m9lzbHXR
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 74C0260A50
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 22:53:30 +0000 (UTC)
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-6a18e24ad25so1964209a12.1
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 15:53:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786748008; cv=none;
 d=google.com; s=arc-20260327;
 b=sVebzQcgobYAhXerWAjcs8ATpwVkS+Hy2iv1JdBBcRaseaIAeKDN/TJXz0lmC1kVVX
 cNSvZqsnILxskWPRNxFwgqpyF3AB/06cF+N2KPK1J++YFYLpomDnfMEsvsLE+7jtVVXf
 l//UodN7Sqx1oH7jUhGxHUi5A8jpx84Jlj+RqjrfRJchUAfB+0XvVRYsnvpmc+PRqgj/
 X75U3GYx81fSlMpZJBTjV8NJvlpIPDXhRhBp+fMFsAC3nx0ds9nu1miEt5mXwXfUzTGI
 x53urAhltu24xkSh5cxTd3Q2eSML51ydxU+UQKz1xnL43F87yXuis52rZgWhgvWJu3ht
 FCEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=8y3MhtxOq6JyUN+JbSSCPPlS6k8lCVS+gjUmAKpjPYc=;
 fh=5QzZRLif8rwx4v11s7VQ14M8IjxxDNo7nclv5CEIr3s=;
 b=FqENlQvBMbYo7/TthbYLh868JHO14QiMNvxcRnHgFQwTPSE3jsVurGPOmUoo97I8ac
 +6bvpzvJAjKfb8UYhfHrPkRT1HK/hnqp8BFF7Pd4LXufo2V54SQ8oRJ7Wsph1I6e7K1Y
 oquUj5HevEltS01//EeycGMxQg6InT1kWU8Y7eGr5uAIXMVJTU0A46g2slAdvJ4y0627
 YbM7SdXpqY3qqtShEqQcxP/5EAwY0+6ikwTxcPmMEoHWHPNA0CX2Izup9YIe2XLHtvTI
 ruRIBP3R04DjWMmYXZF1c2xt/9JuMv3SUNbSP4uFkbIgdG4FpA2G4oNrQtgpnuX2Ab+8
 XZZQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1786748008; x=1787352808;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=8y3MhtxOq6JyUN+JbSSCPPlS6k8lCVS+gjUmAKpjPYc=;
 b=m9lzbHXR0GK4+jm8t/9Rh4/xcwZvr6LjUyCP4Y+x+cOWupPDKw7SpyW+LHj2jER9sv
 ENkqqUl6H3R2hJwSckCtQj7PIjGmcsDvWFjvsOTmgvpnltSb3Apa9gk/wxF/D9PPXW/a
 5v9VmEvieDNb14CZsZ47kxWZhEpn7oGG8WxeI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786748008; x=1787352808;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=8y3MhtxOq6JyUN+JbSSCPPlS6k8lCVS+gjUmAKpjPYc=;
 b=ScrKsxUC1kTdq4T123AbybLB/wkDlitcWcogAJTlub6vAcsH90FOrsuBOgw3yaLp49
 R4+sG/cKPwRj0yDlaN8yffjnPFGl4cicDdUayaobMW5UkCqdQ8ZIlK7DcFy/8zGlAID4
 BDsUWsGcolZhvBm/eQKALQT2k4ygYCOrn4YAeaXnB2eCxnPjjIoxyTbjqPMgvHSGxOQi
 Ih9Z7xkZ4XBXWaA/vatBhuQoSNHkpMGoolwd4teID0tUnAF74ADVnKMu7F+5DwmrKbXG
 Hbtv62mAwYhK1A3UPD8KPWj+yzBFehTy3Yt24EAO0xRyexgGU+RUvzJyjctw1df6k+dv
 ZnOQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp60SzfYyclK5KXJ9rxxHuuLwvQ0dIqa3uB3C3WSXsrR8qUey222xxCaPC3QMqCIKlUkJiSSF0=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YzOb4XMdPVn2qRiVLWrjEL3wAEwaYQnfIyFMi02rDu9GYgJOpss
 mzBPvImYaWTUaUAer7QzfrHGbCv/N5V8IrWsJddLZ19HLuXOlm5OcLzd3zVXGTsiS6+BvaH96mX
 amm71rczAELh+PyEq7nPZyxyd7LfeXaSxWslG8C9C
X-Gm-Gg: AR+sD10mNGrY2rkeSYI4SpE8DpStzgWXQE6Bz7MTuVwuZzDXSOnVHUf5egJWWKeitL1
 prjcbgqq2IKIzK5a42l5bfKZ0adBGZ0gbqgTVDZOMzl00rH6d2L0hTH8Cwrc8Dbq5Li+U8k15aE
 3gLeilLtYkJTnsBxYFpP2OorVE8cwnBYa6JBO0s43IqRC8qvbVsq0bv66izVl44Pno6AcOywCin
 3IIqA8mb7oZry5g7ajCRfZe3dXjFrldm15hIhzVgx8CDQvceW96Ewf2aiYreqdr6giosCDDbXgp
 DMnBk17jM0E7Bjm9HVK9OA6d4EJSqWb4tH4qTNGqt9bHk6qxAFiDEQ==
X-Received: by 2002:a05:6402:a0ca:b0:69e:8ad:515f with SMTP id
 4fb4d7f45d1cf-6a38a8f51d9mr4236604a12.6.1786748008290; Fri, 14 Aug 2026
 15:53:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260812-rinta-watchdog-gettime-v2-0-d8a5a7aa0df7@nokia.com>
 <20260812-rinta-watchdog-gettime-v2-3-d8a5a7aa0df7@nokia.com>
In-Reply-To: <20260812-rinta-watchdog-gettime-v2-3-d8a5a7aa0df7@nokia.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 14 Aug 2026 16:53:14 -0600
X-Gm-Features: AUfX_mx7gRy--Um9y3DzuNM5tefRo4d5S3-4s4gxR1aSqs6eBDtCl74GValeN3A
Message-ID: <CAFLszThfRkVC7i962Tn3VweE4Qxqarp4aBVyTbF78Q+59JJmdw@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 3/5] watchdog: octeontx_wdt: set max_timeout_ms
 in probe
To: Juuso Rinta <juuso.rinta@nokia.com>
Cc: u-boot@lists.denx.de, Stefan Roese <stefan.roese@mailbox.org>, 
 Tom Rini <trini@konsulko.com>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Yao Zi <me@ziyao.cc>, 
 Antonio Borneo <antonio.borneo@foss.st.com>, Peng Fan <peng.fan@nxp.com>, 
 Simon Glass <sjg@chromium.org>, Aaro Koskinen <aaro.koskinen@nokia.com>, 
 u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 2026-08-12T09:48:39, Juuso Rinta <juuso.rinta@nokia.com> wrote:
> watchdog: octeontx_wdt: set max_timeout_ms in probe
>
> Report the hardware-limited maximum timeout value to the wdt
> uclass by setting max_timeout_ms in the per-device uclass-plat
> data during octeontx_wdt_probe().
>
> The timeout is programmed via the 16-bit WDOG_LEN field in
> configured steps, so the largest representable timeout is
> (0xffff << 8) steps. This is then converted to milliseconds
> via the timershift and clock rate, and set only when the rate
> is valid and non-zero.
>
> Signed-off-by: Juuso Rinta <juuso.rinta@nokia.com>
>
> drivers/watchdog/octeontx_wdt.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
