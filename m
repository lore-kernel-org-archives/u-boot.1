Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16851C28B2F
	for <u-boot@archiver.kernel.org>; Wed, 12 Mar 2025 16:23:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7EF18141D;
	Wed, 12 Mar 2025 17:23:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fE4OfS17";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B75C1800B6; Wed, 12 Mar 2025 17:23:45 +0100 (CET)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 469878056A
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 17:23:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-6e8f4c50a8fso678866d6.1
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 09:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741796622; x=1742401422; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=joRvQ/CA8YetZgA7jS57FqGkj4vQBZpAZpX5nQgWF3E=;
 b=fE4OfS17wh5Hx6js7TUl8pUg9R64K5SFYKAJ6dsYJwjuEMUNXjtCx7xEQUBzdzhGsx
 dKViY7LwNonq51YSJdnRQrWHdGIXfhbYjOnRzvNwr8H/thlXafEvJimSkdwRvFkKa/ZO
 NFTxJMs9nsBUMogoPJQL5a7PACjvOco/E/9n4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741796622; x=1742401422;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=joRvQ/CA8YetZgA7jS57FqGkj4vQBZpAZpX5nQgWF3E=;
 b=Ap8Fuggv6oMlMAo0mdxl8PkPZLK0ak1dudntuc9A6p2xc5TLGidB56rd20S9E3JWnj
 TsZQLiUNWR0FqAcJWP9CZC0nitNpVlcUUe92RI/xm/eRZUOdKS25rI5VeXJ37amGVgbi
 97p1nyqA75Lji42qi2nbkgz7sjAe8q4PXECyW1OoXeTobk/ONCpWHMGP/yN2W/jTvfUq
 dM7Gzn+cuh6eKLZqg9nCF42D06zflv8bFdhPY8zRVhtQxAAVqC/+3+gu3+UXD7teTtpV
 8tFRNl+MfNdW6LZtbWUfbKuM5ICOp8R9PvCYS5OCIIU3b1emFz+kkuiu6thUT5Iih+Yb
 NlKA==
X-Gm-Message-State: AOJu0Yz+8gGUQV5jjhKAdpYJBEXDT09JdEZWUoTevAaIskN5BSacgLVF
 Ts6QAgk7P5LqMKna8HqLzNvdDAASmI68+OjsDot3NZrVxbpW7+H8zPi43hh12Sw=
X-Gm-Gg: ASbGncugs8yEFmMv9kNUtOpTzWfGXHTVCxlblUnjZVN7v7zIuE8dUZ6xwg2+ntzyKqt
 YX8k9+C/pCEbc9+NceWXXyUByH1qJeF9RiIMT+NfR9gT2F6p3UM+KG+omU3NObzmh9MFNCfOgfM
 eBV2j+f7vvMnjnvO90sqh3yexQ5Ms38baKEDRmV2oDx84G7OG/F3sagZZ2mEoJCv7urpsThLD4Y
 8UYEh7DwS1sY50R9i69rvs+SxmtLNju95hj5S0yAIIuJYtvKkKFDnVBfs60kOBXtK1OAh5WRj4O
 Ciiymeg+7LutrFn6YhB/tB+rBCCQDiJHcOzrGuCXOFCV
X-Google-Smtp-Source: AGHT+IH5lLAHVbgPloLOlXDAKP3RerhqbXHogpjT0bxX/jJJSR+dj0W5WS4LUVFteA2K2JApVdqLtQ==
X-Received: by 2002:a05:6214:500f:b0:6e8:f4d3:e8a5 with SMTP id
 6a1803df08f44-6e9005ebd75mr337303066d6.15.1741796622193; 
 Wed, 12 Mar 2025 09:23:42 -0700 (PDT)
Received: from [127.0.1.1] ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e8f715b6ebsm86448076d6.87.2025.03.12.09.23.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 09:23:41 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250312125452.53671-1-clamor95@gmail.com>
References: <20250312125452.53671-1-clamor95@gmail.com>
Subject: Re: Please pull u-boot-tegra staging
Message-Id: <174179662124.1743005.9043974564399737865.b4-ty@konsulko.com>
Date: Wed, 12 Mar 2025 10:23:41 -0600
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

On Wed, 12 Mar 2025 14:54:50 +0200, Svyatoslav Ryhel wrote:

> The following changes since commit dc0ee458f1afae4cb5c8a7b2c875bb24ffdf71ca:
> 
>   Prepare v2025.04-rc3 (2025-02-24 16:53:59 -0600)
> 
> are available in the Git repository at:
> 
>   https://source.denx.de/u-boot/custodians/u-boot-tegra.git staging
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom


