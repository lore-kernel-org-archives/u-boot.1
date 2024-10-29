Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAFD1D74948
	for <u-boot@archiver.kernel.org>; Tue, 29 Oct 2024 22:29:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 592DE891E2;
	Tue, 29 Oct 2024 23:28:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TktFwN6F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5503891A8; Tue, 29 Oct 2024 23:28:30 +0100 (CET)
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com
 [IPv6:2607:f8b0:4864:20::e34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B12D8891C5
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 23:28:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-vs1-xe34.google.com with SMTP id
 ada2fe7eead31-4a4789662c1so1681514137.3
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 15:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730240907; x=1730845707; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n+5aJpDfZ3syQHnGEjmGpUbUmELO0kKtMRJ3KkRou30=;
 b=TktFwN6Furinc2shsc+baBJAPAmnypKq1zP23oVcSa9+mmb7sZex69iNO9pKM40bMF
 2AEhu8Cb2AtCv3uGsBl6i4ZJt62UUi5trme9q3meKvYbeWD/J+5FggeXjcK0d66VIzYb
 d395o0Mxhlpym9Gw4oQWbSnFrp0itifkhN3VY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730240907; x=1730845707;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n+5aJpDfZ3syQHnGEjmGpUbUmELO0kKtMRJ3KkRou30=;
 b=O4H0wK5wlHErEuRLNEv+o5fmbiLVmlLK/w/CIY57uGoYhUi62SuJAmRXeIis0dQsPv
 sIB43sLwQgSijxR7K/QL95kl3d35p00KLYH9Som4ntyHpxjJ77i7gU0WDol36K8nCsFy
 qrYssX+hUSJwwZEI+fI1c4BEEqQKHU2twpX/w48RyGQ5e3mmVBgQYLwC0c2WRga4HUas
 0GH7za6wI4T1A0yeABVMJHvPluERkI8S/jXY6bW+YR1Gbcmb2bdoF6JRE84unjEwquUc
 oiJEBABEBrX2m7AAj0/alr7GLYpKLH2dU2M6aU6/hk1hxT2FyK0PDKVoJFDKVLsRPb0g
 g75A==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2VFLHZLucCYzD/yONs8wyUkhMNK1CngqAXOFnHlryZGcIuMEX/MmKFy/gB/67WqWjqoqI/10=@lists.denx.de
X-Gm-Message-State: AOJu0YzTRHeO9ZpdbjOgiwAEICrzw+gpSb/deso/ecElaV3VBdhKNij8
 coIilZMPsBo7J7tOt+hxAX24fncXCTmDYpbT7/2lZwVefrPYJg/dvsfx/CDpfyw=
X-Google-Smtp-Source: AGHT+IHJtWKk3bG0fAmaSZ2Dhbn/SAPK+U9rfhn7n57mqVAQKfVWYkrIMWQSkfdbd+1KywfXFL42RA==
X-Received: by 2002:a05:6102:945:b0:4a3:d46a:3590 with SMTP id
 ada2fe7eead31-4a8cfb38e82mr13729590137.1.1730240907532; 
 Tue, 29 Oct 2024 15:28:27 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.104.2]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b18d3480d7sm459351285a.123.2024.10.29.15.28.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2024 15:28:26 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: sughosh.ganu@linaro.org, Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Simon Glass <sjg@chromium.org>, Prasad Kummari <prasad.kummari@amd.com>, 
 u-boot@lists.denx.de
In-Reply-To: <20241023152637.1222691-1-ilias.apalodimas@linaro.org>
References: <20241023152637.1222691-1-ilias.apalodimas@linaro.org>
Subject: Re: [PATCH v2] lmb: Remove lmb_alloc_flags()
Message-Id: <173024090607.2563570.18084294906758414198.b4-ty@konsulko.com>
Date: Tue, 29 Oct 2024 16:28:26 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Wed, 23 Oct 2024 18:26:36 +0300, Ilias Apalodimas wrote:

> lmb_alloc_flags() & lmb_alloc_base_flags() are just a wrappers for
> _lmb_alloc_base(). Since the only difference is the max address of the
> allowed allocation which _lmb_alloc_base() already supports with the
> LMB_ALLOC_ANYWHERE flag, remove one of them.
> 
> Keep the lmb_alloc_base_flags() which also prints an error on failures
> and adjust efi_allocate_pages() to only use one of them.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


