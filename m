Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 277B2CA100A
	for <u-boot@archiver.kernel.org>; Fri, 30 Aug 2024 23:30:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6126188D04;
	Sat, 31 Aug 2024 01:30:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sAE8vR2/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B2AA88D27; Sat, 31 Aug 2024 01:30:20 +0200 (CEST)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 546F288CC9
 for <u-boot@lists.denx.de>; Sat, 31 Aug 2024 01:30:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-7a802deeb9aso144146085a.0
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 16:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1725060617; x=1725665417; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QhNKzMg15cYsY32xiOxULIefnMdBvDnzH6vcSU34pMM=;
 b=sAE8vR2/pB1sxBfDpqGvK5fyBlWJpS1qgMdYtBj87l4UTFe5I8eAmhE2x0t6EtB8Ra
 3qAcS8X0nid6EbX/xJ9+8Q+mKs1THXF+VPg4UEwhM/HgDeXIZ24YJV9JDbl3OyCZOy8n
 a6Dik4JqxQP0+mFDD3EXnduTFBx1VX9UyTVng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725060617; x=1725665417;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QhNKzMg15cYsY32xiOxULIefnMdBvDnzH6vcSU34pMM=;
 b=cOLQfQolCwDLUIlxAVta3kPd9pTSsrFig8y4kVyEFR/vRuzb3HDrg9EkZ/x+lJTr0D
 lYyA8J/o0BuFWuO5h6/+Uhh6tWDKaPPzk4lJn4LVXtHeQdMB7pnAIHtMUiokArm0mdNC
 OvzgJzGqcG5T53/izxplPQ3XIiebeCeKFj0Ms8tUjBz2LGxUsTBNSoGAmU9mRIweZdL4
 td3spW1Bp/ajc/YKYb36XMU6PnmCDBnnJTD6hKWDB6/9NToC/0lkPS6yS4ytFhQC1LmR
 vsK272pVmq+t6U8+HCVkQ0O2wOz04+XGxZg+++0jbug77c8p/2dyxEVPlzaoKpzoBHyE
 X7sA==
X-Gm-Message-State: AOJu0YzPltEvNa8I1xaTT/jtLUzex1vkp1YEsBE6zkYur8wBva8kRMdB
 +1ARgngOYPtchg4FIBsyx0hurCuONcquhGbdMCEUjWxDEbpMldvjdHcWpa7XPPv9YRx432DqoOM
 Q0es=
X-Google-Smtp-Source: AGHT+IHJaujlWFlIQ2g2Yl1bJwM9qtSDgNsXfcDB3qNlUqAU+GMszCYE39s0+V/ZBG6NwF80KfALVA==
X-Received: by 2002:a05:620a:4402:b0:79f:7b8:4950 with SMTP id
 af79cd13be357-7a89aca7855mr163475085a.51.1725060616994; 
 Fri, 30 Aug 2024 16:30:16 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.65.244]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a806c1f974sm193224085a.37.2024.08.30.16.30.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Aug 2024 16:30:16 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240828165422.3553394-1-sughosh.ganu@linaro.org>
References: <20240828165422.3553394-1-sughosh.ganu@linaro.org>
Subject: Re: [PATCH v2] list: use list_count_nodes() to count list entries
Message-Id: <172506061515.3280213.13483732347066743078.b4-ty@konsulko.com>
Date: Fri, 30 Aug 2024 17:30:15 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Wed, 28 Aug 2024 22:24:22 +0530, Sughosh Ganu wrote:

> Use the API function list_count_nodes() to count the number of list
> entries.
> 
> 

Applied to u-boot/next, thanks!

-- 
Tom


