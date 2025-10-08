Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5880CCA470
	for <u-boot@archiver.kernel.org>; Wed,  8 Oct 2025 20:59:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9CA7583ACA;
	Wed,  8 Oct 2025 22:59:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="EdPrmx7/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BEB083930; Wed,  8 Oct 2025 22:59:45 +0200 (CEST)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 092AD839B1
 for <u-boot@lists.denx.de>; Wed,  8 Oct 2025 22:59:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-43f8116a163so190326b6e.1
 for <u-boot@lists.denx.de>; Wed, 08 Oct 2025 13:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759957182; x=1760561982; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Oq5nLmky+gMQ1XFfBKTKbRBmxlB432GLBx4XLLdHAz8=;
 b=EdPrmx7/UGZZQkmVBJYszI97geRHkk862gRnasHZHmc9JhiU9sE5gLGQ5ZPvcSJkbe
 Qib8MxyJCNplSqIRBQUkHnZA7JsSKjeMIXJH1R6GCJa9eg6vEfV0mIzhAR3AhtWgk/1S
 rfz1Ovs2N+d3aQg/4qYmj6P2ODectJjX3fHxw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759957182; x=1760561982;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Oq5nLmky+gMQ1XFfBKTKbRBmxlB432GLBx4XLLdHAz8=;
 b=lDt8/VNScsG9nWYwNf24CQg+FXxyYUK50d2OvQs6aYcY2zQE6UEZlap6xkkVPB0Vga
 gjD5A2eLeZRJEpSaNBLaP8ZyxApAirhQRZTV8oB/qN/QjY0h0hHPu5QQij+xZ7kIv0dN
 jkqZ+pU3BUcBihsfJjHME4YC1R94va/b30gv0Wa1RUQwMBLcsDhX1oBUYW1i8oyi06YI
 chIGfOccHdqUgl9lyjaSZ8ezyqiHDW3sH0zZzkFWbeeO4hoA6MLF7kJP+OZTJ81hLaDM
 ZGLX1rod9z6DOv5HGukeyEhLxensBR33YEH+XIHkupFvE3GHU8wa7d+A87RN1k91vmYq
 5LVg==
X-Gm-Message-State: AOJu0YzDJ3x3zNpEID4vtOCcBar7zynGX6LMwBt+8S2Sqp8GLqoV1QoR
 p/dcGX+nbK1zAKqAVdLXc2/GDFlYy68mCy2xxjeqsXdEPDgry/2oqSmdhFsGQjCcl4FO6olfHjn
 qG7yc72w=
X-Gm-Gg: ASbGncs0sWDnSfxde+ezJyWwDrlv4226beBdbYbRSrWWQEmhYj3V7Ahsn+gEDNOKzEG
 PhRcAuSIxtubggSrl9tMHT/BeATly1VP5kja9EA9r1PtHBZl9ayDWnTZu/srCF+N9S9fHVB8NM/
 V37G7hN/D+5xdb5u+sff90BXoWq6N6mHypTXa01hHVQDqjRabiVuLSNucPWid8F1Kt1L3fU5tyh
 nu+4Lf9/Aad7wOGSA6cNqrCbUqIPQr7+XmZL40X1hnAyXsyIec7rEefMaCMS+91gC8iZA3K637h
 8NTFOUH4xGqHz1waF3vJ+Jdclgkt1ll0wPnEbocSVU6sL0nJOG3zb8pJUbS7Ax6CA31e3LRJeCo
 kkbf0eWUhAhUCdfqaSa6kwDPLxnFdJsTH6a/nPUFpbvn0cyR6bGAUO6QEd8EyVb6i8JzcmV5rWe
 ky8vP5KcC6
X-Google-Smtp-Source: AGHT+IH1XeMSzxuhpRsXHQ+vFEV4K6YcWawRmYNXDFMjbveTeUlMrjrq2qVW53chuwLz3iC8bbl1ZQ==
X-Received: by 2002:a05:6808:518e:b0:43f:6e52:1433 with SMTP id
 5614622812f47-4417b3b1328mr2840445b6e.28.1759957181699; 
 Wed, 08 Oct 2025 13:59:41 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-44189a67d27sm226052b6e.23.2025.10.08.13.59.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Oct 2025 13:59:41 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Tien Fong Chee <tien.fong.chee@altera.com>
In-Reply-To: <20250925204314.3560861-1-trini@konsulko.com>
References: <20250925204314.3560861-1-trini@konsulko.com>
Subject: Re: [PATCH] pci: Remove pcie_intel_fpga driver
Message-Id: <175995718084.3059512.13389623292118441587.b4-ty@konsulko.com>
Date: Wed, 08 Oct 2025 14:59:40 -0600
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

On Thu, 25 Sep 2025 14:43:14 -0600, Tom Rini wrote:

> This driver has never been enabled by a platform since introduction and
> does not currently compile. Remove it.
> 
> 

Applied to u-boot/master, thanks!

[1/1] pci: Remove pcie_intel_fpga driver
      commit: d40eae0e270f50e6e9b99d7bca334bb87bc28f70
-- 
Tom


