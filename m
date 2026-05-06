Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF295CD3439
	for <u-boot@archiver.kernel.org>; Wed,  6 May 2026 17:17:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E5B0849DF;
	Wed,  6 May 2026 19:17:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SX2200fW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0558849E0; Wed,  6 May 2026 19:17:32 +0200 (CEST)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3864849C9
 for <u-boot@lists.denx.de>; Wed,  6 May 2026 19:17:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-47c918c62b4so2458869b6e.0
 for <u-boot@lists.denx.de>; Wed, 06 May 2026 10:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1778087847; x=1778692647; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ie2eox9bN/5yaQ55qMPyVoAfHaNWYitCKlWCk39/9Es=;
 b=SX2200fWe4wJaaeD8djIPulBoDqTKA2bvsTZHnWHDZAhhvCZZnTAgtw23o6CQP2IVR
 kviBEKqJ6+eakEEM48k1cjRey8lAkJBB7oH+ZEArMT2oLGOSfBeBF7OoYqCoL/SX0Rxu
 q5yxIof/q7rgZKJpnnG7I7Hjo3y+JiUEqx62I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778087847; x=1778692647;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ie2eox9bN/5yaQ55qMPyVoAfHaNWYitCKlWCk39/9Es=;
 b=sFis+l0FYeijrDvC/fPAgKLmOhV9Nwl3HoZ36HwHHYAInqJwoas0VL+vSHAtz6zwjI
 YbCVdyPTTLAiN+EQr5aUTzvypWPH0zGqVHG6r1Wq7XGul0kVHB07ENljUoCvBbyblQXu
 TPnzpqXAw9zf8IN7AN65sEIpusdmwgi2srRdVRwcT0ZKY+e4Mu/6joIKr4MGaPx7oGdi
 XlA0059yiJ1Myq/InHVdg+Hp3zuKQ/PWlvM9lwTqhurbf1x2crgqkCxFDQibAA1ICLvq
 xzJBCtjSPr19DR0vK6vDBUR/3DuyXHHqdMIHSmenpolO+KpDwMcCpVGfzDfXbcZX2fRc
 bZUw==
X-Gm-Message-State: AOJu0YxAQ6609htFhgPKebEWsjXpikorasJIA7C+suXWj2r1MWpEOAb6
 1MWcmFBg4MXjqdNgVb0fEb+kMspom5ZFgDHhHqHwf69j7jMLuuWxELhunQJRLOkiiR0=
X-Gm-Gg: AeBDiesJSBfbNj2geJE3FJDDxvAiVjB58O/Hp1C5UsmAVyV/dv823A/ZbBTTEFwjQjK
 swg2czlhwMphjD95qwlGKWmpF1cx1j9WtzALOBLwz0RejS08PNfL+R2KOgLIshIcWM93T4+ZO04
 L/2UssJq2UQCTk8IBZhp/60WUgO/r1ARUrLRTSMiOz6GmIAsnXHi4uwOF/a/lix8flhJn97P/Mj
 Yv/bgQf8+eH90wQNqvuw/TTQossz8LE+G8SNlo1TTqb5aFeC0e7sHMbDTMpScxhfHgjGWBKeZ8a
 hvOxUmFknhee2ER07Mzwma//Tz3tdsfgi6i+teYuB8oM9E9wiELp6KTFjovSBGYPwhIGrjA9oQV
 xfwL0wCV13aFSC5iKvoKNxtQfdtC9+ZV9L7frDp7XimK4qkh9Lm0LkmkKnayrCX2/T5JYIBaAT8
 MV3bjMyAQeCHfbC1EysRA9+TGd0VbshRraHUsCy2fa4hvYgtb1mHBtZ/QDat1kMvopnABKj7qI2
 myniubssJgys+oh4CROCLF4TWVP9lwN0i5A/JPk8ZPA+h8fWdro2zUwEnq+
X-Received: by 2002:a05:6808:f05:b0:46a:c98c:bfe9 with SMTP id
 5614622812f47-480424a4a44mr2474086b6e.40.1778087847538; 
 Wed, 06 May 2026 10:17:27 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7deca80d5b7sm12380327a34.9.2026.05.06.10.17.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 10:17:27 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: u-boot@lists.denx.de, Mathew McBride <matt@traverse.com.au>, 
 Ye Li <ye.li@nxp.com>, Julian Braha <julianbraha@gmail.com>
In-Reply-To: <afsF9Ih4RPQ1L5d4@nxa18884-linux.ap.freescale.net>
References: <afsF9Ih4RPQ1L5d4@nxa18884-linux.ap.freescale.net>
Subject: Re: [GIT PULL] please pull fsl-qoriq-for-2026.07-rc2 for master
Message-Id: <177808784654.2488.14949888607298544927.b4-ty@konsulko.com>
Date: Wed, 06 May 2026 11:17:26 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Wed, 6 May 2026 17:12:20 +0800, Peng Fan wrote:

> Please pull fsl-qoriq-for-2026.07-rc2 for master
> 
> ---------------------------------------------------
> Add USB Hub (USB5744) management support for ten64
> Various DT fixes for ls1088a
> Fix dead default for SYS_L3_SIZE for powerpc
> ---------------------------------------------------
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


