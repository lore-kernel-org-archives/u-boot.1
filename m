Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF007C531D0
	for <u-boot@archiver.kernel.org>; Fri, 24 Jul 2026 01:02:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 315AD60B01;
	Fri, 24 Jul 2026 01:02:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Y2f6vz-7G_Tp; Fri, 24 Jul 2026 01:02:10 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 35B0C60B09
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784854929;
	bh=S9bm0eiVPYGEdsNUZ8oFM+tKkcoWvx0NpzEkzGXVzTQ=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VfLqYvmHIMcurM6zcXMRtsICmT0kN6Od4gZ2sa9VunPF5p6kOZVTEyVw+cpjMpldc
	 wle4oLHOtcBWAItjP+L9m+fRT64szktmBBRAXxEmPt0vLv5wOnw79YHdtZT2xpfpoG
	 SW5TfyilQDyeTc5fqZyjHqF9vlhKmsokOq7OUazql+GmAsJO0ZemE2F+1t0gHrkl8B
	 heHnq6IqhHh3PyVQZsMgxxiv3LKv3hdqyI55YEUm0mU7w0QGLDBtmjNSdsZG+P9FAM
	 ZEMvrAw6F87OfhybJQTYdecb4qo/NsrjfkxoDMreVi+0SIadgS+D+RrGiOyrqBAS6m
	 lpK5pxLhGO1LQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 35B0C60B09;
	Fri, 24 Jul 2026 01:02:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1A0822E5
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 01:02:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0BCA680F89
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 01:02:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DJd3EOqw_dW9 for <u-boot@lists.u-boot-project.org>;
 Fri, 24 Jul 2026 01:02:06 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 206B180FBC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 206B180FBC
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 206B180FBC
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 01:02:06 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D07F83E76; Fri, 24 Jul 2026 03:02:01 +0200 (CEST)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6382C800AE
 for <u-boot@lists.denx.de>; Fri, 24 Jul 2026 03:01:59 +0200 (CEST)
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-4a2fdbb7be0so571306b6e.3
 for <u-boot@lists.denx.de>; Thu, 23 Jul 2026 18:01:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784854918; x=1785459718;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=S9bm0eiVPYGEdsNUZ8oFM+tKkcoWvx0NpzEkzGXVzTQ=;
 b=DnbrXEUxUe0Kx3YxqSBFh+Ps5ryE7/wsGEQ8mwDsvqamipW0yxSTJtJrKxMxhyFaje
 7oIq6fpLsa80i1iHuvPSfXeVFrp5sRoULS8rcqGNrUNybpvnonmhtVQYH7EgWodQk5fX
 KrKx7mU55XZ+BYnNIAeW/xcKTtnOvIlkmFDqlJzRkOXOPcwcAmMftgSTs9BMgGh/DXSq
 r9OrUEHeW5XIP78X9CKyGLlhcTYqVRGdP9MTcHWS7pzbPRhrh5KWKx1kOtIVFeWaL0ee
 wQaevsvv35pvHYm2T4yUoe/9BSM8XZSAhCd3sDBFyu1C8Jb7xXfG7pWX7wCV/X/s9XIZ
 A0Vg==
X-Gm-Message-State: AOJu0Yxbgkley8pElNCNVgoU8pWACYsZ3Ufsxw33N6aP4hezuZVB25zP
 ieFciLHhDumpX0rTUfk7EskqJlifPye1y99lJsKRXWGO9SDl9d10e/0UezYAE6PdVkQSlVvriwk
 QKN54OT0=
X-Gm-Gg: AR+sD12mIQJKOZ9RZp0y8xinI2TMnLuTXD2ZBKzPecFJq8gPFGkE5bSEbJZE25MZnAu
 8LOlvKfh7G3pf1s/9xfTDuGf46ARwUnLw1nAyx3YmVGPZd7FWAlLbyA2ptV1ThGb15hVBVeo7aw
 +ngs2nh+hJQI+t8axsDQmiKycl89YnugfwUs6UzI7bHaQOKwv3GqkTcwMtUxDXC7ofrgp1mY1Nu
 KsdH0Zehuh3NOu9x27KnX/V/UQXVFU8sfRIWtahHFYJjsomdaVn3Lg6Ih1CAUr9e6x88d6wE8fS
 oyKvDN/zH5LIt1DACas8+Ac5OaveItJBemW+hO29bxhi0zHUSdgcZ1BA736XQIxVYzvy5vq/RJ4
 vwtd8baX2Nf0+zbL6wIryQsmxuAUumhv7eKf3dFEh0YHhnZU5GkZvZpyKtk6XnpsF1jFipA4i2P
 ebnzA88MzmKpM4MRUCRplOdCYiogRnIoIqmot54d1SX7lpPYXbcSjlzWy6ypsOMNawnQP8mXNfr
 T0T9K1J9E+yRZwYt4kh8bDfpg==
X-Received: by 2002:a05:6808:3028:b0:494:984b:39d8 with SMTP id
 5614622812f47-4ab3585b483mr2591776b6e.41.1784854917972; 
 Thu, 23 Jul 2026 18:01:57 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4ab0c7a01bbsm4196177b6e.1.2026.07.23.18.01.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 18:01:57 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Aristo Chen <aristo.chen@canonical.com>
In-Reply-To: <20260710153343.1839357-1-aristo.chen@canonical.com>
References: <20260710153343.1839357-1-aristo.chen@canonical.com>
Subject: Re: [PATCH v1 0/2] tools: mkimage: fix stale data pointer in
 fit_import_data()
Message-Id: <178485491644.3246206.10776156729275290038.b4-ty@konsulko.com>
Date: Thu, 23 Jul 2026 19:01:56 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1784854918; x=1785459718; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=S9bm0eiVPYGEdsNUZ8oFM+tKkcoWvx0NpzEkzGXVzTQ=;
 b=tjzJBqbfULwBfDZWYWIDFyZUJ5cldEJWn/n9DrH6S41iFmrP9+p3Tug6OW9MAvuY+3
 hAoQ+/3tat2mfhMGZkx+/SfcWz05rPYpuIKUWOyP0HDjDZSg+cfgxkSe/nRDaIFv47et
 G1FiPvZuBZYCqZi8Kus4rxRoXvNLWQF3rhzx4=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=tjzJBqbf
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=trini@konsulko.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tjzJBqbf";
 dkim-atps=neutral
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

On Fri, 10 Jul 2026 15:33:38 +0000, Aristo Chen wrote:

> fit_import_data() in tools/fit_image.c declares the data pointer and
> the name of the external data property outside its loop over the
> /images subnodes, so both values leak from one image into the next. An
> image node that carries data-size but neither data-offset nor
> data-position then reuses the pointer left behind by the previously
> imported image: the previous image's data is written into the node,
> after which the import aborts trying to delete an external data
> property the node never had. Since that abort path only prints a
> debug() message, a regular mkimage build fails with nothing but the
> generic usage text. The failure mode also depends on the order of the
> image nodes: when no externally stored image precedes the malformed
> node, the pointer is still NULL, the node is skipped, and the hashing
> stage reports a proper error instead.
> 
> [...]

Applied to u-boot/main, thanks!

[1/2] tools: mkimage: fix stale data pointer in fit_import_data()
      commit: eecc4148fe61a53fa1f4d16ffb453c3901fc704f
[2/2] test: py: add regression test for fit_import_data() stale state
      commit: 7551ce097779014405bd4976e0f9f1246dbb80d7
-- 
Tom


