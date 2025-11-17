Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D93CACE8D6B
	for <u-boot@archiver.kernel.org>; Mon, 17 Nov 2025 10:49:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12D1E83B2C;
	Mon, 17 Nov 2025 11:49:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="l029meqj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5FEF983B8C; Mon, 17 Nov 2025 11:49:48 +0100 (CET)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44B9E83A8F
 for <u-boot@lists.denx.de>; Mon, 17 Nov 2025 11:49:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-42b39d51dcfso2234467f8f.2
 for <u-boot@lists.denx.de>; Mon, 17 Nov 2025 02:49:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763376585; x=1763981385; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M/e99HPS1vJtSl/6kE8dVRXJFKHvJt3L9OFtu8w8Hu8=;
 b=l029meqj205XMIE7wNGFHY2umcJsHrTLEUOCO8UXiF0UsMfKgksmCM5WvzEqC1HfvF
 8LH3wgpb6/7pM1EOMZTsj2ABRU+TfPF4F057uvgXnZaQscgHBr/QBLHU/9BZhhPV74Ev
 0mpG1b1e8lCsKmfhsZo2rvTJWsxHKYLcbsmLJtbPxwthX4R+p+65K0jSiPABDfvUBZjL
 APPmJohj6Snea17IUOOcF8+9AN0Q7Wu6gxJDGFopBjvtiO+F8W+N4LP0/+DEyennYJiD
 4t23NzmaiLXfWN3UeFqth7soKmmWR2hIbszxUuTLSGqf+3ZTnS5TUifKVVMH3Eri3/Li
 W+LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763376585; x=1763981385;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=M/e99HPS1vJtSl/6kE8dVRXJFKHvJt3L9OFtu8w8Hu8=;
 b=KYWpupYlPZrgmRkyVJ66obiHKFK69Viy46WvB6zd95Jvnhpwlkyuw9wBScVwj5KNBd
 03X2JLK9awSyCJOrCnb45xciBMPGTHsw2x/jEAfc0edgBcEHxqZuLmcVwH5W7U7953jY
 d2hUHqdrR0U3zVFcjrWHAdqs92gJpKAK85fINwsBCC5fqaYtE8Lf4EblpfAqqCWtoHSc
 cYtkFfHTwsnf1+2Bjt40/gYyRg8hE+m4Sh+uJkjj1sOOkPevxdIfsG4ci5UGbT9WJE+b
 tEki+9nmgSi4fsRigXZZ/2TXWTw5WtM+U4sOr10kNWLAxZhe2ObZp+qc4KK56U7lxklb
 K3TA==
X-Gm-Message-State: AOJu0Yx1tMXlyAwpq+vE9SDrUfRDMWpS5eb06FUgrA++0uK4IU3R3zSU
 p6nreLRC+DUZCXknKq1u32ZJhAKSaMie43R2Vxqf5lG1B+kd0XDDecoJL/IjdPYTYsVQi4aeNiP
 d0nMr
X-Gm-Gg: ASbGncsRcpAKrWMatsuUsGw8hAGqmv25XZsHi5UPnQgmw3IOHIrFJdOL8sTcqxwJVfC
 sSPruSrfwaVI5AG5+anJ1/27qmEphKr1C5NrJjsCtIfQjYntWJ5FoCsYRqTlVm69WVbG/b2d2Fi
 kNB7IctTE0u44fSbtDFFKbqxJtBBEx7gtk3HVW/d3YcjEreciVMQW9/LhB6LT8yy2a67WxdnJTE
 QGSmFlOP12qPP5cJchNhcz13x3JJkMnVPsqE8GtJerJuZoTRTnyxjZjpQwJUNhzIBOHm2UV5R2Q
 +//9gEMfjwesyiHCXHjW38f3uKRWZSyHlSP/R9a3ahqJ/EYXOWZ2uN5Aa6zcF1JDZ7vkKEI5q5P
 yBdRhK+4sksMA75GnbOHCFvSeTPpcSgrN+NbHSf9hJ3cSnVv1MKFLTNt7UPyUxi2BS8MZ7MX0au
 Qjx+8ReHk5DMCjQ/JkBnSDMYdbQvd9G5B0v/EuYNa2jQ==
X-Google-Smtp-Source: AGHT+IGCUM2BSn432Sww4Na2tP3esgQL1AsvVb+GmD5G1Wd2Yf13b0ISNBSom8VNkSFERVKLBGU8wQ==
X-Received: by 2002:a05:6000:310b:b0:42b:41d3:dafa with SMTP id
 ffacd0b85a97d-42b59389c39mr10623417f8f.46.1763376584500; 
 Mon, 17 Nov 2025 02:49:44 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42c97745f79sm11422514f8f.23.2025.11.17.02.49.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Nov 2025 02:49:43 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Tuyen Dang <tuyen.dang.xa@renesas.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
In-Reply-To: <20251112211841.1428696-1-trini@konsulko.com>
References: <20251112211841.1428696-1-trini@konsulko.com>
Subject: Re: [PATCH] ufs: rcar-gen5: Use a unique U_BOOT_DRIVER name
Message-Id: <176337658354.3830363.10042938881205083768.b4-ty@linaro.org>
Date: Mon, 17 Nov 2025 11:49:43 +0100
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

Hi,

On Wed, 12 Nov 2025 15:18:41 -0600, Tom Rini wrote:
> All instances of U_BOOT_DRIVER must be unique or we will have link time
> failures. It is possible to enable both ufs-renesas-rcar.c and
> ufs-renesas-rcar-gen5.c at the same time, so give
> ufs-renesas-rcar-gen5.c a new unique U_BOOT_DRIVER name.
> 
> 

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-ufs (master)

[1/1] ufs: rcar-gen5: Use a unique U_BOOT_DRIVER name
      https://source.denx.de/u-boot/custodians/u-boot-ufs/-/commit/d4f80bddc58115744d681a332144e9a9371d1f59

-- 
Neil

