Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D721B1061B22
	for <u-boot@archiver.kernel.org>; Mon, 30 Mar 2026 23:01:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7AC3A84010;
	Tue, 31 Mar 2026 01:00:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Edf9+Jaq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AEEB28352B; Tue, 31 Mar 2026 01:00:23 +0200 (CEST)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D8C984068
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 01:00:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-46701f2077cso4617769b6e.0
 for <u-boot@lists.denx.de>; Mon, 30 Mar 2026 16:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774911615; x=1775516415; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LXD5s5fuDHU4gShi6fqiJ1/edsgmbwcn645xEUryBWs=;
 b=Edf9+Jaqna9hoy1KLJHwmH2EnFtjYD6q84mJ56Wszm3MhvieASO/x/sn20rAtFrpyK
 fOZQoQXGbk6TMK97YynQD9mUizqoFioQ0ZzZvBfepM6jI+0y4GJ8LhfOjA3mGJ7fhqJI
 zMsu3E5Al6BN4ZZRY83mHto5x7eaF/3OZGuoU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774911615; x=1775516415;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LXD5s5fuDHU4gShi6fqiJ1/edsgmbwcn645xEUryBWs=;
 b=q/J3DBrkkZtxrS1YKbBodNmgGjj8hy0BJ/5aRjfSf0wuO2ebU94vU1yJu5vwC186ht
 1DyN9d/rdM/WK6VbqxCxcdrMUQpM5xEqjUxptLW+aVao8I2zAnioLiHmT/B73Bysu0jE
 V6oTJpW+vncjakD8kZFh6MFJyiVqs3zgTYHV7E7DEF+HxT1qOwq4CoqFy/+Jwpz41Iu6
 lUj8HclStTNL3RxOlKiUkOthypQAWLw3Cfc+KPFJRTvv/WDQq6mNnQ+3f1kBGTf7geWR
 8kv/yuZSaFd2lbhSJaVj1eGPmNnQLv///XCxO+jtz4gz10G+881uJZYKyhkG3K4s4+KR
 ixLQ==
X-Gm-Message-State: AOJu0YyjtARVhuEXZwb1fz4DdsSqkaW9+uEE1yZEs+NRAASxtf50bKnA
 ujR9yt9bVQX7PKIzXymqbQATjY2N1n73A3F9v+ueG7ZxyrG6QUk5NF1nrllY0uITWZT6slQ/U6P
 5ESmReRM=
X-Gm-Gg: ATEYQzxb6DXg7a2ZETrortpd7w0cicg5Fnq2tLTl0fZPdgVGRjxQ27cfc28bjuHH11G
 wp51TfO/EV0sH9bR4pqNjlTqAOsMx5LtJTa5PFai3PWy6H4K33UWt/x3m5A12GL01VFLERJD8sz
 zw3ClYrsE/SF3MjDTqKMuoo1JMDc5Ff7r8dA34Y4zKtiJ2A78PNL3NMM1RYz87IQEkwPyjjg50P
 zxR6lHeYY2Af4TNbUDr3AfIVZzjkOJRObGHTo7q9Mczv/ImMb2Sn/Gx7+wFskhpgy/NaVHCyyf/
 Hcz19HH572EH6hobyshR8a1Ruo5Gt4zs4cJ6nFd8EFp94Gi/D79TzhIiG/PNo9v6o5DVUnh5DWy
 U1Sh38DLer8lHvFIX+7Anf9KFdJ1dDhjnxAKWTmcd5Ob+DZRQPXemqlXhCy2BCUu6Ebdn9mGNy5
 mOo+B3F2PuyYlZwFwB7K5P0WVzvV1j1UiwoqyZ0/WQRbxB/7+dQ7O1LtEtgjFp0qTmkQ+0SEn/Q
 j6FhdG3Vie7DcOxnZLVAjpKebpZLo7qLTVsjg+0Gy5uWTM=
X-Received: by 2002:a05:6808:2f0c:b0:467:2f58:dff3 with SMTP id
 5614622812f47-46acdc1b762mr785095b6e.18.1774911614710; 
 Mon, 30 Mar 2026 16:00:14 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-46aa03b1e64sm5644737b6e.15.2026.03.30.16.00.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 16:00:14 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260317012439.4162568-1-trini@konsulko.com>
References: <20260317012439.4162568-1-trini@konsulko.com>
Subject: Re: [PATCH] misc: Correct dependencies on QCOM_GENI
Message-Id: <177491161403.1028292.11622842018430672095.b4-ty@konsulko.com>
Date: Mon, 30 Mar 2026 17:00:14 -0600
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

On Mon, 16 Mar 2026 19:24:39 -0600, Tom Rini wrote:

> As exposed by "make randconfig", we have an issue with the dependencies
> for QCOM_GENI. The symbol PARTITION_TYPE_GUID depends on EFI_PARTITION
> and this driver cannot function without both being set, so select that
> as well.
> 
> 

Applied to u-boot/next, thanks!

[1/1] misc: Correct dependencies on QCOM_GENI
      commit: 81fff1704fc38171bf6fc34c7fc0f25e93d2e2b0
-- 
Tom


