Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32A91C282D1
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 15:41:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4CFB381417;
	Thu,  6 Mar 2025 16:41:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="meErOY1g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B184981249; Thu,  6 Mar 2025 16:41:19 +0100 (CET)
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com
 [IPv6:2607:f8b0:4864:20::b29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8FC48122F
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 16:41:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb29.google.com with SMTP id
 3f1490d57ef6-e611ebd9a61so740070276.1
 for <u-boot@lists.denx.de>; Thu, 06 Mar 2025 07:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741275675; x=1741880475; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nPfXoogmJ69segkQ3cvdoTMw7vonHBDxxVCXM6nXMNo=;
 b=meErOY1gUCENOuA1BAfRT05B2VYhxSVr3v4VkBXomFnGz+0LMIp8xvMqVTjkNwRT7s
 gHTuVnKi1+H8tc5ih6tQDRzooMb9t8DIt7SN5XfAJcWCy7hF5+Flz8T9cXbUAp3izxYL
 E5oC8oJy8vYcjXeNLKQIWPd2zGSI5+Sjv670Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741275675; x=1741880475;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nPfXoogmJ69segkQ3cvdoTMw7vonHBDxxVCXM6nXMNo=;
 b=cpGtaPTxlDOFEs6L044dUI03TUFtPn7NfnBR7b5rUSdFX5e1qywg0YDXcR7Rw/PXYf
 Uh3v9qtUOAHnwlbaMQ4/ce9vQqHA2Yh8l2xsOAWFgG2aEQ4V1Wlmk2vDi64UWSU92adX
 hCWjLSRlQEmL5Vf0qn6GcVMjGH8xTheHx6ycz/o3J+yfEdu8zcNpdEJ5XU6Ji9pvFeRq
 WwbTB9HVf49MpI4LU5bjcvmYq/Khm87YjpCdQOYEbBiLDr5hHmIdGpitC/ZU+zyEaPOO
 jW+m7qAVGTPXVzbSkJfgRKCXMeTbEPLCmD0b3snUjiN4/ae3yNBNNMfs8SjcOZ8HBfU1
 leIA==
X-Gm-Message-State: AOJu0YyViNHk5L8CJC30vtR/m36K8r0yGMGaOshleLD6lPgLacLzpJhe
 xnUI2QwABSveeHUrG8b/Y2jkc9kk0ziJ1f8yQSr0vUe8icYGs5ZNm1+nvoFmS3cLYYHQTKSYR8k
 9
X-Gm-Gg: ASbGnctSycYQ6ZgQsRaTpXFSJbVTubRKTCOsg3YC2J+Tuk3OiUR5h0uVfRWXRBpG4jp
 DLhv3Sv5anAbvFGpi5ZlEA0negyAGD/0wvb/UtF969WV8n9U1o2qe2CeiRuM5h/c/5vrtmImN9/
 aBPxs+nzY1fpBa9f85vYPDFe3t+e7vH8k7AU7ppdgwrQ0kBbpSNnNOKCxwEFB9x4+EPjREaikjg
 0ZbJGVppSG5jiBe2uHqrD8w3rrnEDnUj4PxG1NjvA3v/miAPzD9aru0Hj6CKTEwM+DZfAZv28Oa
 l0XEE5dnRNql6099OYLbRP3Rhq/F62PtITu4IM98lCEB
X-Google-Smtp-Source: AGHT+IHWrVu47fFZWZgm5M+TvbiZlwk/t8J/Q33AviuBwqp+6HfoF2OGGGyO5bMMjGu6gtrjsL9NMA==
X-Received: by 2002:a05:6902:2101:b0:e60:e14a:df7b with SMTP id
 3f1490d57ef6-e634793fc80mr5136707276.12.1741275675605; 
 Thu, 06 Mar 2025 07:41:15 -0800 (PST)
Received: from [127.0.1.1] ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 3f1490d57ef6-e634b842f58sm348755276.22.2025.03.06.07.41.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Mar 2025 07:41:15 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Eugene Uriev <eugeneuriev@gmail.com>, 
 Diederik de Haas <didi.debian@cknow.org>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250301102202.289097-1-didi.debian@cknow.org>
References: <20250301102202.289097-1-didi.debian@cknow.org>
Subject: Re: [PATCH] mcheck: Fix SPDX License Identifier to LGPL-2.1-or-later
Message-Id: <174127567481.3636414.14090875112332934202.b4-ty@konsulko.com>
Date: Thu, 06 Mar 2025 09:41:14 -0600
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

On Sat, 01 Mar 2025 11:14:12 +0100, Diederik de Haas wrote:

> The GPL-2.1+ SPDX License Identifier doesn't exist, but luckily the full
> license text was available which shows that GPL-2.1+ was a typo and it
> should have been LGPL-2.1-or-later.
> As the '+' in LGPL-2.1+ is deprecated in SPDX 3.0, use the preferred
> identifier, which is '-or-later'.
> 
> Normally the full license header is removed when switching to SPDX
> License Identifiers, so do that now.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] mcheck: Fix SPDX License Identifier to LGPL-2.1-or-later
      commit: 31378bd6fc909afabee69f425bf663002277eecf
-- 
Tom


