Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70CA8C07CB1
	for <u-boot@archiver.kernel.org>; Wed, 29 Nov 2023 03:25:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 635868747E;
	Wed, 29 Nov 2023 04:25:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bqcAkaJy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DAA528749C; Wed, 29 Nov 2023 04:25:56 +0100 (CET)
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com
 [IPv6:2607:f8b0:4864:20::b2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C81A4870D2
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 04:25:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2f.google.com with SMTP id
 3f1490d57ef6-db4422fff15so5276413276.1
 for <u-boot@lists.denx.de>; Tue, 28 Nov 2023 19:25:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1701228353; x=1701833153; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GIxVJV0smC9PfnFplzTJyagp6p6qJsTFri8Fp6AULls=;
 b=bqcAkaJy/C2CeGX2ADT+mGmR69nFzrYTUHYvCNB3bE9dtgaSx0yTNdoBvxTwyDU5an
 ZjP1UvjEVE0GAGeLgnM8ABJKLjDbufXS+gZUrZKjDLZ+GHCwsR752wOA3X/dcMR6OR+E
 Dp7YTtA8BVzQ6pSe5AaJ2I1+PQUfMIRVp3lZ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701228353; x=1701833153;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GIxVJV0smC9PfnFplzTJyagp6p6qJsTFri8Fp6AULls=;
 b=iOfXNCsMY2LKI4lhrLEphLS8TY3gwKlP8bkiSPfURARxqr+HpqKg02tfK8F5U2M9Td
 ZrLwDOfEK9zsLSClJmySH0TKjA7CsLEuiB8qjSpeGQRsxfgEiRIIy3IyD6ffvtdOKKCr
 JZbIkmSKyROypXCM3ctQnSJEjugDZEwtCGCbflr+pkHe1kjN7xyLw0P/aGMFujn05VOD
 KZK4jjD/D3gAawMKJRI2/6nqiFzgvN32JmGv3d83juYO2ilP6ICGJb9J0hSdlW4ep53x
 UBLFHecd95hMM5imcEj7Lb86VyEiHXxI/tD+QHs6r3Sc7otyWLQFWzAKRmN73EanV2H9
 6DKw==
X-Gm-Message-State: AOJu0YyNBQwiM5TuvXeqYP0Hf4iGmrxRlk54lYvwg5jeP+nxUoLGic7y
 dKvqjn/kYOAwxtFDB1JK/y/eqw==
X-Google-Smtp-Source: AGHT+IFph1yZXZ8WySLNYNxNDr+xF/A4ivPQ76ksLN/aSNNkXvjPV1Bjms5rQUTH+FZNaY+BKIDnxw==
X-Received: by 2002:a25:8407:0:b0:d84:e7a6:fc09 with SMTP id
 u7-20020a258407000000b00d84e7a6fc09mr17554170ybk.17.1701228353481; 
 Tue, 28 Nov 2023 19:25:53 -0800 (PST)
Received: from [127.0.1.1]
 (2603-6081-7b00-6400-9fa4-b7c8-6a9a-173e.res6.spectrum.com.
 [2603:6081:7b00:6400:9fa4:b7c8:6a9a:173e])
 by smtp.gmail.com with ESMTPSA id
 79-20020a250d52000000b00d7ba4c5e31fsm4000128ybn.39.2023.11.28.19.25.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Nov 2023 19:25:51 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, christian.taedcke-oss@weidmueller.com
Cc: Christian Taedcke <christian.taedcke@weidmueller.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Michal Simek <michal.simek@amd.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Qu Wenruo <wqu@suse.com>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Stefan Roese <sr@denx.de>
In-Reply-To: <20231115124424.125823-1-christian.taedcke-oss@weidmueller.com>
References: <20231115124424.125823-1-christian.taedcke-oss@weidmueller.com>
Subject: Re: [PATCH v3 0/9] fs: fat: calculate FAT type based on cluster count
Message-Id: <170122835109.772379.10049440097124366790.b4-ty@konsulko.com>
Date: Tue, 28 Nov 2023 22:25:51 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4
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

On Wed, 15 Nov 2023 13:44:15 +0100, christian.taedcke-oss@weidmueller.com wrote:

> From: Christian Taedcke <christian.taedcke@weidmueller.com>
> 
> 
> This series fixes an issue where the FAT type (FAT12, FAT16) is not
> correctly detected, e.g. when the BPB field BS_FilSysType contains the
> valid value "FAT     ".
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


