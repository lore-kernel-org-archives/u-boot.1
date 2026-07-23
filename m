Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F188C531CC
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 18:54:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4B90B60AD3;
	Thu, 23 Jul 2026 18:54:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OB0A89yGtnsY; Thu, 23 Jul 2026 18:54:08 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8285E608F0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784832848;
	bh=YRO4Xt0d36Ka/NjcdqcVu3Yfjcq6cv7KnoYG5d2ldK0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eKc0cc+YfIhaAoaL0UPysDgcIxoz9gRLN1o33oU4ljpFrgg+I3TI/bvIooA6Bq0SW
	 dPdlmGvOLkSsz38iFIAqQXLmmfiQ8NWkEvjhpLaC2BZRfHFZBFDFNJkD/1nRV3l6Mt
	 uIRwi0dIOLpDUkLH6c3GzCNy5QpACPvyfow3oxNMRlJ082E+NQpIvNduCaTQH196Nw
	 jN/1egPwEapCN4kkbm45Ao0SNZihSaYBsPfA0kq9roPdFegfS2uPxRve6p/KLnSUtg
	 +FqpWv+Ei9nIgCac1wOLLxKd0H9IAAkEJSVEcWShadTD9XuOj8mcZCzKAssg6TO4qx
	 BPf0uI2PlRF7w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8285E608F0;
	Thu, 23 Jul 2026 18:54:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 789DE1B8
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 18:54:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5E74C40472
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 18:54:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Na-Gck2e3kzl for <u-boot@lists.u-boot-project.org>;
 Thu, 23 Jul 2026 18:54:05 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::336; helo=mail-ot1-x336.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 9AE4E40162
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9AE4E40162
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9AE4E40162
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 18:54:05 +0000 (UTC)
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7eb42a2f5feso484453a34.1
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 11:54:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784832844; x=1785437644;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YRO4Xt0d36Ka/NjcdqcVu3Yfjcq6cv7KnoYG5d2ldK0=;
 b=klSfaTmCGQ+SRCZ/th1ZndMmJveF4mLw04MTHCeRV2JHtCyLnBdCJlLAwbKNGW+pih
 45M/kEQn6I93ggjh25sCdOrHyH0B8ho7BBI36ZphQ/zm+phxbaAop0FiQ7dutZQE/Vql
 3M6Lv8fXPliciA0z9JA1BHLe2JgcQZmSf/ge3JGgjDjpsh126QIZajGf3x3ub4Jb0F5A
 dJauFWd+4DavOCbaT3eQY5NRT/fhKm3Wy/k9VlwnTh9SFjh/ypW8Heed2//3kKbgEauD
 ogZRHikySnc5vk+VSqjnNg7PzUV1YSAwitFmBMkfBIUyE4vQ8587Q/BjrKQvheymyVi0
 AnlA==
X-Gm-Message-State: AOJu0YxxIQJgB1LaQzXIrrZU+1/OG/UBVvPBp4SjyH8ohHqhpa1OQBtm
 ZsZ8Cu0v3TVP6ruOK0xRx0dJbc4c66vvxF5VlwV3ikrAUP016/Y96KybI+fF2XLyQZs=
X-Gm-Gg: AR+sD13U3L5FVGWWZ742RAsBTGqfn7hGCsZtvwYtHe6jnNGOiTY8BX2XE9bymbDYbgO
 LfiulOjikE4XkRBWmLEmyZii3KllXhAgYM7So6N5cS3en0kn4RXOGPZnxxaM9XzwtUo1j/2wE+f
 Jc7kBdo3YEWJyKDYwx3JHpeg7az02yqZ0S2rKAX+Id9IGnKNpPcoqR0eIfUManZ3PyKEr4tN8dR
 qfHI8pVx3knZr3BV/XPaTemV1fQSIkrKl0hqSOc+rpRMgZR1U03omvp87XnRXqrWg1u8QxLy78n
 lpYulqou6dXzv/nGnJuau7pF/e9X3/e0fTSlWrReWjrQFRkdu0KLeKO/dShK8b9dMmgl4ndxHgw
 /KfcRe2VBhQKq0xJ2o3K3MwGFA/L0N3qA8lL4NtLjfxBQdHq+mvU9EXmBOpy0Q6u4D5p9zHvgsa
 GzgPYhgHBoPEhVJCHIHHJLssEGksThiHrRCfXoLUZMo4x11h6+LcqOJTGDcL/W32u9ZYwQA6ut7
 GYS0Noj37RKnSC8HYaZqNzMWg==
X-Received: by 2002:a05:6830:8289:b0:7e7:76f:3ec0 with SMTP id
 46e09a7af769-7ee43d0755dmr2643161a34.15.1784832844336; 
 Thu, 23 Jul 2026 11:54:04 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7ee2a108679sm4217667a34.27.2026.07.23.11.54.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 11:54:04 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: David Lechner <dlechner@baylibre.com>
Cc: u-boot@lists.u-boot-project.org, GSS_MTK_Uboot_upstream@mediatek.com, 
 Julien Stephan <jstephan@baylibre.com>, Carlo Caione <ccaione@baylibre.com>
In-Reply-To: <20260722201522.3930921-1-dlechner@baylibre.com>
References: <20260722201522.3930921-1-dlechner@baylibre.com>
Subject: Re: [GIT PULL] Please pull mediatek-for-main-2026-07-22 into main
Message-Id: <178483284358.3183172.15000440898796253779.b4-ty@konsulko.com>
Date: Thu, 23 Jul 2026 12:54:03 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1784832844; x=1785437644;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YRO4Xt0d36Ka/NjcdqcVu3Yfjcq6cv7KnoYG5d2ldK0=;
 b=uTVlXpeYyx1LYmCZBqQKFEiyuG8zp1XRKAYjGBXQg73l/tFpzzBFv5ZSY5khA83wCX
 ns/rVqvg02asiY+3+KL+qKKhbS7Wq77V96VR3igSyz7fbP/qCbj30YKR4by0KTiKeJ/+
 6XCQ4jhhdXxDQKf02drI5fZpZN72mgcGVdt/s=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=uTVlXpeY
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

On Wed, 22 Jul 2026 15:08:59 -0500, David Lechner wrote:

> The following changes since commit 1b8283bd3220e898d338fb98929f0b06ed63da84:
> 
>   cmd: read: fix unsigned overflow bypassing range check (2026-07-21 13:52:50 -0600)
> 
> are available in the Git repository at:
> 
>   https://git.u-boot-project.org/u-boot/custodians/u-boot-mediatek.git tags/mediatek-for-main-2026-07-22
> 
> [...]

Merged into u-boot/main, thanks!

-- 
Tom


