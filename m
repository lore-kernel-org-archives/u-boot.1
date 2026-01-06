Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1127CEFD0C
	for <u-boot@archiver.kernel.org>; Tue,  6 Jan 2026 23:17:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E21C583FFF;
	Wed,  7 Jan 2026 00:17:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="I8UuTKY9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E93368400F; Wed,  7 Jan 2026 00:17:25 +0100 (CET)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4DF883FF9
 for <u-boot@lists.denx.de>; Wed,  7 Jan 2026 00:17:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-3f9e592af58so876324fac.2
 for <u-boot@lists.denx.de>; Tue, 06 Jan 2026 15:17:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1767741442; x=1768346242; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1pEAoneFDEtOr6S6WdOPbPj9ug7R2P/c+TD2hmIkEQ4=;
 b=I8UuTKY9Ztr8xrW8ZK5rHFRXi9321v3nrP+5n6rkDpFSoHpkB91vNasHgzX02uraE8
 Z7yXEHpw/CnCif6qciuCY0xqgUEHg81ZvIyFoNeqgX04YxD7BL4RG1aj8NN7n1W9N4je
 QDwb1tUJY+mFwSnjrtSzwhuA5lzvib5Mq/Vv0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767741442; x=1768346242;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1pEAoneFDEtOr6S6WdOPbPj9ug7R2P/c+TD2hmIkEQ4=;
 b=dYXdMWhE0VOUGmJVi/3hEvHTWcWrE/MbshRwluKNt0799cNwvGHY/nTEp1VminQ1Dq
 398uMiTSB/8CPHmms7aDQDGzZ+WCyZ70rG+E38RmZmpksh+2Cf05k3gRaiWQRrniJNDR
 DVGxee0L2o9Wtj7zbJ8Mk0Ftg0vAP8UbNgFUnzG4rNCPOCczbjvlOnltQNYyE8zNRU5P
 ZYSIbbYZ9ESNnCR+oQpqEvZdaBuv4Db++5Jv9Yyj9bHaCXwcwHYBUKgAz8d3A0fQRhf5
 4aCqzs4aAvACkWhyYt7ZKjN16sPKFhcDeIEZ4y0/6hqgtuRSBMTa8/cVEaxXXmtK529a
 d4yA==
X-Gm-Message-State: AOJu0YzqP7RkdnpPFz37Yy0lja+c3J73pBIoa0yWaMgLViOR++c0h0rc
 Dey3DT3+U9OkNLdhjNv0P95E7cfi7IVW2/AFIPWk58mi3raQ/ylLdOD+uXXzOIhjpOY=
X-Gm-Gg: AY/fxX6ajsx69djnZZzS85GI2Ka3/K80oNLJcsQrGM+GstdZRVn72hiqxn3GCGpCBaH
 8eVGOheg9Qurn5f4VX8wyoyQAlWz+yxkyYJVq+MXVJ1wyZnz1ATrWqOJ4IYSgBdLtIw5i4hmbM2
 XlMzCrwlJOjjR78H/48JHvljFAZYDABS9wNJTF3Nq0Xd1wqTYhkgu6j/zL1XuIiphUP+GDiVNc/
 S1QAk/qyqXQaKOflMzVxCZkMyK6EzTiBQZdAkfufIqUedM4aeBDvsADZwMP9SvfZh7iXG8Qh/8a
 WCXMMQ5oiFGx9vu+DB/SH/sMS0a+oXSiKisV7NciY8y+1BBHxLUnOO99Z0HskAAmxGOQwN4TDsL
 RjcPlLbvQHjXIFuokRPv9tJFwH0aiN2ae03IDUMNy//3/L5AcDsD6JApjFEP1lPVi6rW7M90axN
 ocrjMjyg7tk3Uv9B8AlVUGKPGPzUYz1CLGvQSdlP1ChwWnqec06dZuxxsqMeZ8URqYG8DZzy/XQ
 Hr3mJZKks3CwZYNBvFUSxl48qMgHbxLfrT3RA==
X-Google-Smtp-Source: AGHT+IEMyu28ClzYpkGf7EgFIHb8SXzJt/cvPYVvyX1MB0RlYcqBxuHjIFsdbTBXkP0UII1N93VASQ==
X-Received: by 2002:a05:6870:6b97:b0:3e7:f174:ae1d with SMTP id
 586e51a60fabf-3ffc091879cmr294767fac.5.1767741442448; 
 Tue, 06 Jan 2026 15:17:22 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3ffa4de40bfsm2059380fac.5.2026.01.06.15.17.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jan 2026 15:17:21 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Darek <x64x6a@gmail.com>, Stefan Roese <stefan.roese@mailbox.org>
In-Reply-To: <20251218233654.3938385-2-trini@konsulko.com>
References: <20251218232255.3934258-1-trini@konsulko.com>
 <20251218233654.3938385-1-trini@konsulko.com>
 <20251218233654.3938385-2-trini@konsulko.com>
Subject: Re: [PATCHv1 1/3] lzma: Add Kconfig options to optimize for size
Message-Id: <176774144160.3783364.9518655819393448998.b4-ty@konsulko.com>
Date: Tue, 06 Jan 2026 17:17:21 -0600
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

On Thu, 18 Dec 2025 17:30:56 -0600, Tom Rini wrote:

> Currently, our LZMA library has an option for optimizing for size,
> rather than speed. It is a minimal savings today, and has not been worth
> enabling. As this will change in the near future, add options now to
> allow disabling it in full U-Boot or in SPL, and enable these on
> gardena-smart-gateway-mt7688 which is very close to the size limit
> today.
> 
> [...]

Applied to u-boot/master, thanks!

[1/3] lzma: Add Kconfig options to optimize for size
      commit: e7797f450ad26bca32c12ae55e3d43438b74f910
[2/3] lzma: Update LZMA SDK code from 9.20 to 25.01
      commit: 33c9db62d49306805bf7ccfb7e6c6e53238ad0c0
[3/3] lzma: Add SPDX-License-Identifier lines
      commit: 45c5bc2ca515684dedce4cea3d66a109fba5144d
-- 
Tom


