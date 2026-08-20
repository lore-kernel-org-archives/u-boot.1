Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5887EC5DF8C
	for <u-boot@archiver.kernel.org>; Thu, 20 Aug 2026 18:55:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 18C13405F6;
	Thu, 20 Aug 2026 18:55:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Kpm9h2PHtmQL; Thu, 20 Aug 2026 18:55:56 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787252156;
	bh=iqBSkEFTtSD/bfCaP8MIoJYm4aFKS0kUhp7tniAuOoI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jo85Pbh6ZwR3gpcb39X6bi4USKlMBaa40UBplSvS31uDtBNWFOJtjXyDWm/9F/BHw
	 Ig3lMRe+zasYTYJKJCFhrBw638dKOMgzTOQgD4+aF5+7WwWR4t8YImV6vXKqrTyDXP
	 9PL8f3cXIPD3D3QtUdipM6pXOeiF/jrwjjnh9vzcUDWX0E8woYcXqNjBz+SvpVCtMW
	 MKsX6Qujo/Zgr2/7NrS1ecXapUtIE7cHfojCuUspnKsuVSAIRw0iUbH/wXWj5kItJO
	 h7p6PD52tVglnTj8D0mXgIJz8TQqzwjwh9gwgVxfcKBrVMElLW/NfScwVXza4+VxLV
	 6PtkXMXpjdUtA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8576A405B9;
	Thu, 20 Aug 2026 18:55:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 505492B2
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 18:55:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 31B444083D
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 18:55:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id x5Hv9KVK0gNr for <u-boot@lists.u-boot-project.org>;
 Thu, 20 Aug 2026 18:55:48 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c30; helo=mail-oo1-xc30.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=S2u/VPJa
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7318540685
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 18:55:48 +0000 (UTC)
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-6b13fcf22a2so131292eaf.2
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 11:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1787252147; x=1787856947;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iqBSkEFTtSD/bfCaP8MIoJYm4aFKS0kUhp7tniAuOoI=;
 b=S2u/VPJa2Mbt+qX82PEHfabdJA7DmFMrhb2uHXi0bcZND1qsJjPcnOGC35kx46UMAC
 UW1AZct4f/+rqQsynGwk8B9Nkv3iNMw3nLSdWU/WP4RmzduBMbfmVQHhZ/mvpUR6ktzU
 Qb5MYf1BCgNXTF36j6AS53uJC6RyV11MHNuGg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787252147; x=1787856947;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iqBSkEFTtSD/bfCaP8MIoJYm4aFKS0kUhp7tniAuOoI=;
 b=LpxrijJrkCS/po98p/DtrKGAkXpidXe0haObj46FAcpEb9H3hXLjS9Nnnel825aW5u
 35mRV7TR/dNyWuMP4qdy4vWkjRcEVe3doPFPf9VTgZVVv/Y60i0DHbsCaQDvVifT4x/7
 GiMq8JoMzfH2zIp0J9RedKdHiJeKSMy0OA6sfDP7tjLh0iRXmNZOBvSGyc83rDpfOWvg
 a8C85fJHkgO/o1SwesRA91WUIzw7XbrvOPEO16jLeof+eEvw89EOnE7IEAeiILSEUcHI
 OCMjGd/tfc+f/aA5IhGvKFGflnLd2DjEPTvqNCtbiPY1e8BFa5k2jy5JpXA8OI/gq4Vb
 b7GA==
X-Gm-Message-State: AOJu0YyDpVyFOxXJQLI99FZbNflhdZkopOrtTH8Wfd98Ui5pIVNpJx/Z
 5oUbiMLIB81lN9wckk8gpnhNhVWoJ+e3/rqtUBhnRufDYOyZK0xzebMK1+pVZTlGBzvXsHJigBA
 iuSjy4tyGWLBw
X-Gm-Gg: AR+sD12Y0JtSjGxK9gxiB8TlqXSzgsC/a7reCxvoKRigMT1AmpOsZ//1GlUki9HMaO8
 O1gvtLMo5vlWsUQUn7aTpO3/d4T3vD3+toSLJiy4NiGRqFl6XhUCvjJ5+7t+BOx0YeLNY00HG8G
 no+SE7Y6FQLq4rEbY2ThUSr9SIs3nPQPZXaoOuN0pPE0I5+ghiJGvaKbzeD8wJmXcBVNJ4koyEg
 Ru7ukcFkhC3fKe30PZ8H/i2eZnZl18vJPHYjXLv/kk3qxyeAPV/ZL5+5ImFC3Ej5ZWjnu1dqVWw
 zpJXIl/zZYeJ0inkol1+AkyfFARNtgT7tubgcLCZ6ClE/jl+rztreICQyMoD+JfWyxntzIXf0UQ
 tpeDfLSnSDSzmHpXwZxQb0jrMCNsWoecCBqFmV3VaAxMudRQOLj5WV/UPiMpvB+rcZigjYLJpWy
 +Gqjlhc6kXlCwVdNAtC8D9I0KmO5O3coYYT898fzOkDimBgpYqgfz6B35BHjP54UtLbPeB6LgX/
 7ohG827YLx9vTk7g4Ryt+/3sZtt3VutpDecoedVrCCkaWP14/08m5lTFZlUaV9I+LSqhRX0KEin
 rzdGzE5W
X-Received: by 2002:a05:6820:83cc:10b0:6b1:36ec:6a99 with SMTP id
 006d021491bc7-6b1593bba9amr691243eaf.22.1787252146870; 
 Thu, 20 Aug 2026 11:55:46 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6b13cb55782sm5729175eaf.1.2026.08.20.11.55.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 11:55:46 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, 
 James Hilliard <james.hilliard1@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
In-Reply-To: <20260811051750.164470-1-james.hilliard1@gmail.com>
References: <20260811051750.164470-1-james.hilliard1@gmail.com>
Subject: Re: [PATCH] test: dm: hash: check digest size before memset
Message-Id: <178725214624.2214048.17845011401660022626.b4-ty@konsulko.com>
Date: Thu, 20 Aug 2026 12:55:46 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Mon, 10 Aug 2026 23:17:41 -0600, James Hilliard wrote:

> hash_algo_digest_size() returns -EINVAL for an invalid algorithm. The
> test success provider passes that result directly to memset(), where it
> is converted to a large size_t.
> 
> Return the error before touching the output buffer, and exercise the
> invalid-algorithm path in the provider-selection test. This addresses
> Coverity CIDs 652907 and 652908.
> 
> [...]

Applied to u-boot/main, thanks!

[1/1] test: dm: hash: check digest size before memset
      commit: 6073c36b2c8d39afe3ecc789b281667a3ddebc70
-- 
Tom


