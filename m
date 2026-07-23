Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73962C531F8
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 16:47:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2ECD140AAC;
	Thu, 23 Jul 2026 16:47:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7Z4UiYLHqseb; Thu, 23 Jul 2026 16:47:17 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 18AB440A94
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784825237;
	bh=Igu1ZqAn3hY53c8ge+sKD0spcXqK8vOaT8D3gXGTJ9E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gldUESkifzGXglPFghWcNk9Qis0zTteMe8GJCYuZwEd1RXvMZ8Z1WMYe095Xea+uv
	 RNARa3OwbXrpOvmmDgvRRgNJV+eqzveyvaYwNpuMiOXDOCZu8SuE1UEACN/iEKJVvY
	 Ez5sepFtGYi3O7i/v9CmzwW41HsgthVhEH8sH0vo2wZ/VE90O/INeEQZj5crrvkQ4x
	 CdB/H7xWHY5+io9iqwcQ8wp59E0T6CKsZhfNaNtsln2GbYqM9MNBHCVlEplQagm0EQ
	 bE+BBqTtgcyrcF5UyVywOnh/38k3xZNlefFWHL/UBdcdMwRLBpsJpktj8Gtfuhzyfp
	 25GEG4zvM65wA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 18AB440A94;
	Thu, 23 Jul 2026 16:47:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id A9219390
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 15:24:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A6D43403F4
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 15:24:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id x8GMzTikxKlI for <u-boot@lists.u-boot-project.org>;
 Thu, 23 Jul 2026 15:24:40 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=william.bright@imd-tec.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org A1C53403E9
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A1C53403E9
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A1C53403E9
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 15:24:39 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20CFA803F6; Thu, 23 Jul 2026 17:24:38 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 407D3800AE
 for <u-boot@lists.denx.de>; Thu, 23 Jul 2026 17:24:36 +0200 (CEST)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4955aa106b1so7391705e9.0
 for <u-boot@lists.denx.de>; Thu, 23 Jul 2026 08:24:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784820276; x=1785425076;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Igu1ZqAn3hY53c8ge+sKD0spcXqK8vOaT8D3gXGTJ9E=;
 b=Y+qvrA4jzR9DEJPikst5pCFZY8ePobBuw/yJQ1cfeUEyLY3YmNOfxBn8QZaGIsfnVM
 TpfMBGw+LrQsD6VDqaF5jIX+/0UMST4USRffqp8lDFaVIkr7p0EHE9CWKJqIuxVem0OY
 sYaNprn+CS8Awt6KY2RUhVfLPOXcnRX6lTsP9O3yDUgLy4ABFOK2RSBO/xnLH2EnKrUI
 SrEo1badDyoKYWXeM5uDw5E7UDAxXcQzIwqHYrPZzDOzaOEQUrwa4kGcSF2fh2VpD6EG
 NMGIL+Yid4kB8WUQ5xCx8XbmKdXotG0xRCfLUfu3CciccaKnxQu60DrJldc23zLtYEIX
 g4eg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrFgttqsdMc1Kt5Te4u5waAl3YcvEdP3RH8NygH31bjnX59Xos1LLiAhAELYPngdIfqoUxm9Bc=@lists.denx.de
X-Gm-Message-State: AOJu0YwOLJJenJ3igBmgEWwCOWqSdk/PT1By3wAjNdHUXgpAPrWA9cBM
 O+/77tZAqxXAqNHyWYsD/QsZXFCeRCPc1CGKoWQmEvbmaWC5WOTJsnrV7f3/31znLK0=
X-Gm-Gg: AR+sD10dm6a1r3X1Dvs7GYvGb41vv6AxBrwEcydEPqa0BEtWguK6nC/CUvN0cj9246F
 oPcXJqRVzkAkZWqv3nTRQrPM3dFCzCgSIaIluGEe7bujsQ34yqIgfPHJQJTJtyjLTSKZB679Gie
 Vc+PP2ZFA+zg/fCOo8dHOJpNcrk5ciG78kWf19SctRColHRjRBtOrY4Zeg367U6bxzfRQo1l+v6
 9Hmj4guenw0T33w8irbfVK0CA42XVC7FKpba14duKtL/wtab4Qy6W9Ei1178eEipFARWFsWz6mV
 SAzy8SBiet3/l0K/vzzDa/yID2TyW2yE32tCBaOFrLreASU4bbgCuzxkbNePlAHUgcuyiv+uY9Q
 YJBJr4XRlqyg00VlmN6imQbU7Pz7xBZdsII8cIj/x8UO9x5mzgyXCtRDfesYiunlRmRTfGAD828
 e/AdRbaD+QYeMi2RwlMA5xH/wQCyKe2xBFufhVeqG8eDXAbsMNDREURbNG4H5mfVEJjZQnc49mj
 EB7PwdG2s3UhP/iOdOVqZPoAObh9hD43A7YHoNBL+JwHEv+B+UYmt9cxMfYweCUL/zl18GD
X-Received: by 2002:a05:600c:4708:b0:495:4c74:6a14 with SMTP id
 5b1f17b1804b1-49573cc6d64mr38988275e9.14.1784820275508; 
 Thu, 23 Jul 2026 08:24:35 -0700 (PDT)
Received: from will-Legion-Slim-5-16APH8
 (host86-157-235-39.range86-157.btcentralplus.com. [86.157.235.39])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4957af6a15bsm1590445e9.4.2026.07.23.08.24.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 08:24:35 -0700 (PDT)
Date: Thu, 23 Jul 2026 16:24:33 +0100
From: William Bright <william.bright@imd-tec.com>
To: Casey Connolly <casey.connolly@linaro.org>
Cc: Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io, Tom Rini <trini@konsulko.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH v2 2/2] configs: add sm8550_defconfig
Message-ID: <amIyMfQch2NDAQpZ@will-Legion-Slim-5-16APH8>
References: <20260723-sm8550-hdk-v2-0-78f0ce2adb3c@imd-tec.com>
 <20260723-sm8550-hdk-v2-2-78f0ce2adb3c@imd-tec.com>
 <0fe5f1c6-d15e-4f7c-9a95-8b87aa7a644c@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0fe5f1c6-d15e-4f7c-9a95-8b87aa7a644c@linaro.org>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Thu, 23 Jul 2026 16:47:15 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=imd-tec.com; s=google; t=1784820276; x=1785425076; darn=lists.denx.de;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Igu1ZqAn3hY53c8ge+sKD0spcXqK8vOaT8D3gXGTJ9E=;
 b=VbP0fudBn1L/kxBQ7cS9vcE00ZMw19szpQ2mM6sZMem8TzrIkhLGjQMLi3bu+uSG7k
 wxTPu6QE1Wa44ZcJnPr71X5tZI9aeDqCPAAJr8h2FlSsXrvIzHW6XExfX8BkHfkH1vLS
 0yL06KvWGYog30o4a97sUNIxljO8u2fMH0ulpGX838K4zcQj62xI+b91/RmqeNwGOe2j
 Jkn2AzpMwpktRSh+z3Hw1Cye80DxbQVvUhkZ2CoG2nt9tB92K8D2iPK3oYhM45RCgf60
 FCirawHsUG7rGsyh6gVLjBWEJHGjal1ZgNy5BMdPJ3dVBdKUa8rDOBJIuttpCRFqvmT+
 X+vg==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=imd-tec.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=imd-tec.com header.i=@imd-tec.com header.a=rsa-sha256
 header.s=google header.b=VbP0fudB
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=imd-tec.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=william.bright@imd-tec.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=imd-tec.com header.i=@imd-tec.com header.b="VbP0fudB"; 
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

On Thu, Jul 23, 2026 at 01:24:54PM +0200, Casey Connolly wrote:
> Do we need OF_EMBED here? By default the .mbn is built from
> u-boot-dtb.bin so the DTB is appended is already.
> 
> Assuming things work ok with that dropped
> 
I dropped OF_EMBED and tested, it works fine without it.
I am happy for you to drop it or I can resubmit if you like as there
was also a small nit issue with the commit message in patch 2. 

Thanks,
Will
