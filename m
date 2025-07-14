Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DF1BC83F17
	for <u-boot@archiver.kernel.org>; Mon, 14 Jul 2025 23:13:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 541FF8318E;
	Tue, 15 Jul 2025 01:12:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nQ3g2hK3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 952FE83145; Tue, 15 Jul 2025 01:12:14 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8713682B07
 for <u-boot@lists.denx.de>; Tue, 15 Jul 2025 01:12:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-73afbe1497bso1898491a34.1
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 16:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752534731; x=1753139531; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fG3OiWUhyriKyqIGu17m6cP/rD/b+D0fKR8TR7jShNY=;
 b=nQ3g2hK3gGDflpkr0w6cji6l8VpXdjYQBZrXPmio79wsdnplqRTcteSZhPDP7rFhcL
 2kVJoMNaf1KBAFKxPfh280I9UFACj+UowZdVemKk9K8nf478GWj50B0521CHQdoV51WC
 Qql9Ve5pA4Cu3rNEMsDVHOCxui6519fAl7+7I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752534731; x=1753139531;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fG3OiWUhyriKyqIGu17m6cP/rD/b+D0fKR8TR7jShNY=;
 b=uT++0gfbmfi9Cuwbw2kjfh4Nc82zc77efFLccSwbmDCWNIMkeJbrKq7k1Svmy2eCtS
 mfoud4e2KRG7RLw2fpWkvGgz2LLsc6VU9ZyRhIMdor82nsbW/yWePU/GZv0POrSLt62E
 GwJ4H4xfvgZwm1PjhjLTAVdMvtEoDsaEO9glrWe1Sk2fffMwWagJqujo0+ZlFy2BXHMa
 F2qE0CkWCDLSnghp9xgRmEwStDwkUOo0kqDFD1F0vYRWICzCDMIKBzJK9J+uWdKHF3AW
 knxDFA6LzT+k8DaG2px2DqIx9CH/xVDEw59JHOXU5xTnY9G8iSsHEpUnbnWOGhS4ZlCq
 nbdw==
X-Gm-Message-State: AOJu0YzYwl8Jx0p0BZYVkf1q92+ON954MjczG/zHUjDr81r4fYYrmBdx
 WpPxKutjV0NZfhxwvnHBe0BV3yl2+3ilFEOB5R8HQUlKN2EArIoSPObuV+CfgTzTqWk=
X-Gm-Gg: ASbGnculjuF1mnKo/lV4zsL1tEAejwLfzA3tVjPLlQpWkLrkXN/TkxO+lRxLNDtkr5F
 DSEgGUtDcIciX5inqczpM0TsmA4O0WWGBgS0rLRd/ohL1bC7BuUU9bapvyDdsL0OQTWKhoatPpi
 AvSDx53o1KFyas3U9aB8kSHMsJAMc2ZQWsNF+wbGnJJfVRcCGRy3TcQveUUrFjuj4j591HFAxYj
 WV3wpltUUCHfQxKSzFF+839N33Hp3dp8gufca/q932O2kO61M/8CzHvHik01TnvQOHBGiHTT/Qp
 RzFFpeiOwRJ4yhpVVmAecNpmgG5RAkKOTRcgYjKeENFYlvGbA+6kJUdqSWZm1C1kZlARzHcBUSc
 o2YER5QD/YOEjHs7IuEuKFUZ8LFsLiDl8pTQxBRzvFSG/hqZ42oz4UWs=
X-Google-Smtp-Source: AGHT+IEAqkYpv90Hwtsdfd4UN2UAeOYdCcLdYesWGm5I5iK2eu9kH/dh9KoibnPEGKYcbx3h8vozuw==
X-Received: by 2002:a05:6830:3c83:b0:72b:872f:efca with SMTP id
 46e09a7af769-73cf9f5003bmr11604494a34.27.1752534731345; 
 Mon, 14 Jul 2025 16:12:11 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73cf108af60sm1729410a34.21.2025.07.14.16.12.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 16:12:10 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250703-ofnode_fix-v2-1-2e529f21ba7a@linaro.org>
References: <20250703-ofnode_fix-v2-1-2e529f21ba7a@linaro.org>
Subject: Re: [PATCH v2] ofnode: NULL check bootscr_flash_size before
 dereference
Message-Id: <175253473060.280771.9931931485909750085.b4-ty@konsulko.com>
Date: Mon, 14 Jul 2025 17:12:10 -0600
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

On Mon, 07 Jul 2025 11:04:29 +0100, Andrew Goodbody wrote:

> Move the NULL check of bootscr_flash_size to before the first time it is
> dereferenced to avoid any possible segment violations.
> 
> This issue found by Smatch.
> 
> 

Applied to u-boot/master, thanks!

[1/1] ofnode: NULL check bootscr_flash_size before dereference
      commit: cd79a2839b01571b6f2915c219f71c05e3c97482
-- 
Tom


