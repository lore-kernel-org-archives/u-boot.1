Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07A8EC021B8
	for <u-boot@archiver.kernel.org>; Tue,  4 Mar 2025 04:41:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71DB481280;
	Tue,  4 Mar 2025 05:41:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="J7PruV45";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA9E781273; Tue,  4 Mar 2025 05:41:52 +0100 (CET)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B71F81249
 for <u-boot@lists.denx.de>; Tue,  4 Mar 2025 05:41:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-6f4434b5305so45501117b3.3
 for <u-boot@lists.denx.de>; Mon, 03 Mar 2025 20:41:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741063309; x=1741668109; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j00fSaShIW4AGfihSrk+k2hnUgEcQhxxObCZMkPWvkU=;
 b=J7PruV45pTrDEps/Byib/hR2tTwYuUV8A54eSn/YjfdbKe/mSnMCIuISY+5xZVrQxV
 /RQQKFfDpkggAz1DRjihXlyPOyY3UY79iLlWSFcuIawfVEmvuxsKvkq6bPDo+sj4qyR1
 EYb3IPqSDu1Q1CZX4B1B1kNew1bNMZM43DUdI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741063309; x=1741668109;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j00fSaShIW4AGfihSrk+k2hnUgEcQhxxObCZMkPWvkU=;
 b=vmyST8gik2PujfT2lqHMVgSP+E/yCM/klGTaw2WzmImjWDVvbHE4mryB5UELvjj+RH
 Z9Q+gsyDSsQSTJiw+tamyhJUX7ndYrlqN5MXJRT5m8NWWceNCOnT2t6IFJ3gY8TLAYvj
 z9OOQaF2oojg7/BpDrrz92n4ynrjdxoENT3SvXAL7jjeIp/pOcl8AlB3AIEjIa4R4Dgf
 ivVg9O3ktHEkoStEhR65ga8CFcieqN8zt7PLSIVGw6+kunXvtKQd66gFHbFMbBZsu6tP
 ii9b29QWVYV1jfyZ4W1YOSB5e3pQv6XjxLAI+gqD1gmKHDRUcjsBg6eZNsykpuAIUfCO
 iN3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwUbTf0lGrlihq/kq5Uxxnu0iu7cBFtizeDpjwOdWm5DhgoLFYTr9vZFQJNzOmWkeKnFgCCdE=@lists.denx.de
X-Gm-Message-State: AOJu0Yx64A/U3V7YEroufCzegh+GRrK6k6PDyNOJHbsdU2xTLR63VW8N
 FmPWNJnolE/tXkGAAfLpa4CpA8GeEOnXSTCn0l9kNBM1/RhtIiInNU+Fn03H+y8=
X-Gm-Gg: ASbGncvn8SXE7Oi4OkT/yWSM50snaRrUY3C6AeTcmfHMYgWniUSPd/rlr/e7pHfl1hE
 YtzCfjMfLQkXJrkQ7yBBnNKjkPaGJvBLaDmRsuv8+I4DksNGW5HWfq4cjnWWREzdSi3PaiEghwX
 v/3kDzDALTB5b5JubSCGhHME94G3jeteGOBfqFbD6b9//WleZuYyzVLqMcOCTWghF46KhaOC8q9
 JxyzHpJtb+QWJ09s1H5prsHzVZ5VqozGyEnSMEBSplz3EduAK21QiBeGjYKn9FcPimkdwPi+1Vg
 4KOyCDA3lenbrrX6S46XgzPQeqfwn1ZFajOIf8DKNw==
X-Google-Smtp-Source: AGHT+IFGXjz1g4fSiBLa2bG/0/qJtMsG1TH+lyjDs55oTz27N2ORjY0xEPx9SpyIt4KSPmgNMfGTrg==
X-Received: by 2002:a05:690c:6303:b0:6fd:3727:6471 with SMTP id
 00721157ae682-6fd49f9f81amr245362417b3.6.1741063309341; 
 Mon, 03 Mar 2025 20:41:49 -0800 (PST)
Received: from [127.0.1.1] ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-6fd3ca60d57sm23182697b3.51.2025.03.03.20.41.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Mar 2025 20:41:48 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>, Stefan Roese <sr@denx.de>, 
 u-boot@lists.denx.de, "A. Sverdlin" <alexander.sverdlin@siemens.com>
Cc: Chintan Vankar <c-vankar@ti.com>
In-Reply-To: <20250220124908.3396843-1-alexander.sverdlin@siemens.com>
References: <20250220124908.3396843-1-alexander.sverdlin@siemens.com>
Subject: Re: [PATCH] tiny-printf: emit \0 as %c
Message-Id: <174106330722.1753567.18050515077534713181.b4-ty@konsulko.com>
Date: Mon, 03 Mar 2025 22:41:47 -0600
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

On Thu, 20 Feb 2025 13:49:07 +0100, A. Sverdlin wrote:

> The current code has a problematic corner case with formar "%c" and
> 0 as parameter. The proper zero byte is being emitted into digit buffer
> but the final copy into outstr expects null-terminated string and doesn't
> copy the required \0 byte. This has lead to malformed TFTP packets, refer
> to tftp_send() which relies on %c to generate multiple zero-terminated
> strings in one buffer.
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


