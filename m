Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 593E3CD4F5B
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 13:35:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FA2E84843;
	Tue, 19 May 2026 15:35:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="W6IkPW/f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22E79846EB; Tue, 19 May 2026 15:35:15 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E518846F2
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 15:35:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7dbcb467f2bso3498414a34.3
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 06:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1779197712; x=1779802512; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3HxM+75cDIV2PljVW8CXqzafawJa/nWdToCi4Wdz21k=;
 b=W6IkPW/fzhulLonbVUOQ3C/QisnyGdr+T2eoviYWBoLsnvCz7YV8PvLlLH8x8xTUw8
 VSGB7fHYPe11oVkNjPeV7AoAscgNDzwFfkMBjq6if7UfG6d0vT0acO9SSIa5gfZZIpAK
 6EHrIhUOrfS7c08B6oI60NDexO9Q31b2r4VcU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779197712; x=1779802512;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=3HxM+75cDIV2PljVW8CXqzafawJa/nWdToCi4Wdz21k=;
 b=TFAiNsOSr4QtDlPo/WWKXHNIkYcgAdvA7itpyx7dijy5u4vqU7Z1oUQIjOw9utxeIf
 Q9L/PTt87ryRIyOv+RBf/gXsB8sdEPKDhSNcIAOeH4LfjTNLbe5kqplBzcAUinG4d69n
 M0bf0kzDND1nS8Qx/275sSYr8BjCDkwhOSccBgTJ/dIll9WFQrXndoQpsy2y+qypNBmA
 IHrLYQKtK32SdZkTAxxqtSdaGeuEF/PJaV9FhLunswUCB8h7/Ymu49eAGLv5WVhnYhcH
 EpIE+JZ9nFuzNRijqVp2fVSw18+fgo127yi1dSI1n7lcIX9D4qfniyXriOTsDQOMl9Kx
 ck8A==
X-Gm-Message-State: AOJu0Yz5Qn4yQfSo/yHCrbxP6a11OOHfKaqTfYqj13JcBrDyY+Ak2gpM
 SpAcJH7uyJXwYu3TgtAFoP9yFVIdkQ4lYzHUNC42GSk3nIlKoxjeMlok9WcbyD5HqJd0l0ML/9/
 oAcbTDtcvULAE
X-Gm-Gg: Acq92OEMKm4QHwS8to25IzWCUufjia6IlKb73k0oEQmB4z6rqnB/v8xf8OfBmEB5L5K
 2UDO6vEjxbnhz3FQuDxMj/qy8DO0IbNTmPm065+bOJeXR9jJPCg3NFCkvove7mlh1T3B/WpMMD2
 Jk4XHX4B1XQSK8D7vu5dFMSrOXU6PbPZ0cVGqO1jP4jsns2M0jOGF6SnxOTgnP5fAK1ASz3/FFP
 q8o4z2dPy0CW5yc6p0Wcfzll/IyDtcBlYrhkxywyE2S86jHJaec8du4xQUfjRTOvlyfpQ/C4XKo
 ZaoqsrZ9UqM9KUBpAh5UMHuu4VZNHY76YHAVRKUHXiL4uU/Oc8I65a2ym6FUoeUD0bL9EZAewCm
 oBp2P5lFwzdKvh2NyyGKaLufEFvtB4gLP2gWU8ll8VRID/dEW9HuvZKoIcgutpPyFzdSeFCylMu
 EpLoJDvBrwzMYh8q65XkyEerCmYX1GzotocKyaN5JgxkSyGXUWvBP/hJsIoixFM1b3Z4M/RgcRg
 Mf49zwfV/UpT32LWFPutdLyebFDLMkchNLErSmCz53mgpojcg==
X-Received: by 2002:a05:6830:d11:b0:7d7:4002:1f21 with SMTP id
 46e09a7af769-7e4f2b6c3a7mr12957014a34.20.1779197711857; 
 Tue, 19 May 2026 06:35:11 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55b7cd6c0sm10826569a34.4.2026.05.19.06.35.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 06:35:11 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260509151339.23116-1-marek.vasut+renesas@mailbox.org>
References: <20260509151339.23116-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH] rtc: emul: Staticize and constify driver ops
Message-Id: <177919771126.672258.17119822282756633779.b4-ty@konsulko.com>
Date: Tue, 19 May 2026 07:35:11 -0600
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

On Sat, 09 May 2026 17:13:32 +0200, Marek Vasut wrote:

> Set the ops structure as static const. The structure is not accessible
> from outside of this driver and is not going to be modified at runtime.
> 
> 

Applied to u-boot/next, thanks!

[1/1] rtc: emul: Staticize and constify driver ops
      commit: a504ad9e685a5711d894b8759dcfb1b6e3127d82
-- 
Tom


