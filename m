Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 340ECCD6E55
	for <u-boot@archiver.kernel.org>; Wed,  3 Jun 2026 18:21:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBB988486B;
	Wed,  3 Jun 2026 20:21:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="I69ZQMwq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A88884879; Wed,  3 Jun 2026 20:21:10 +0200 (CEST)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB10F84868
 for <u-boot@lists.denx.de>; Wed,  3 Jun 2026 20:21:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-43d3a0dabb0so1720173fac.1
 for <u-boot@lists.denx.de>; Wed, 03 Jun 2026 11:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1780510866; x=1781115666; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YgkVNrZeLtUiFyjGq7x/knT7Z1RN2EnG64zuYTPcDGA=;
 b=I69ZQMwqIViWPy+BufHmXe8Rrx5moCqzqTSpUuW6iQ/oRIeASAaTvKEtowuBAW49jv
 xGWbznSa44LLDldNbeJ7P9RR0Jl0lGgPvxv7+PFG/gdjL+YnKrsFQtfPkn+HHnfi784Z
 RpG8EEQm+ufVGbYoR3Cwz4lWjYJb9Sv3hAuSs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780510866; x=1781115666;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YgkVNrZeLtUiFyjGq7x/knT7Z1RN2EnG64zuYTPcDGA=;
 b=pWLxvvGqy4RxCJp+uLgIu8KIf9pkNRCWAuRVanaV+gk1Z+7rXbkTuKMWQYMcxjTMxt
 fAPU87A8+OPKG3rKosAPCwGcC9fK7/MIHXrPX5s5v84/6bTAmazZvdwi2cDnb4cf/+8b
 sxilGo+telKvj4UCBkYk7sMVdiEijNo+as3HUqAEt+G2DensEA8irkOuvLg4esEPknja
 a16L3MVpbsBANN1QrZaZfcXlyRVU4gNRyBD7sCF1HRM8b2zVSImXgJdAH68oORPL+jol
 5RlMYRgxYPB3LncmqDqSj1LoTjs71ntkon/baZQRJ2iSroUjN+YYhRXyDe2YGdLRi/P2
 2oOg==
X-Gm-Message-State: AOJu0Yxkc9/wTW5dC0DmChHI1N04Bzf/j0juj13Lm7dNCCQEbE9S+6wf
 1dP/D4XvPVyQzPB760BJW7nibnfeIP3gZQ4LRH8O3SJlfXVEXQHzEWdJWXo6wbKnOOo=
X-Gm-Gg: Acq92OGitZ6lYrhi7XYBEHrlCF3d56BE+xdYhExO04nDJ+b+bshMYo4XUiOwsrlFx8Z
 zN5BxxMS6/cdStfVPlUkdfV+d9akj2qDv1Dbl+ACQt7uikylc5M0lXhPp++oBcKjfhRAr4VhLg6
 InBWbDcXNQaGdOlgv4Jwr8/4ea89L8fIGGZ2PdX2CsKVr/kAauSM8YfcNNEpqbkYWhu4LMBpf3o
 ULTZDL85TYDxgRttsYm/+zpZ1UcbtsSdTMopTgPSny7X6IkyDqBhrzW3OAL3s/Z9RhbSKMsSge5
 jnxG1DdogDY6OQytDCt6huSFtmnMl0P9qa7BEVBaPSg6hilz+anifzF0afrHYTr3pDm9y2aQoHN
 rzLoRcwbR4i8v6jjFKdd9kYNHU6PtNmQB2PJLtW9ElDXJc+ZWeO0ANihP4yFQ/iHPzRIH5zULcG
 0zy83Lj7j90HcyKTCJlHXd1BOtnLXnqWCcbZRCaBqSarI7lCOfT3O48zJd66pGl45+vbg600Z/F
 8M11DVeKYopigtIa4ckrCcxlAGXH2aVGfescLBtO1IU7Bfydlpj6ogKgLk0
X-Received: by 2002:a05:6871:5826:b0:43b:912e:48f7 with SMTP id
 586e51a60fabf-440db9eb3ecmr2915416fac.28.1780510866315; 
 Wed, 03 Jun 2026 11:21:06 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-440d7d3c2casm2820886fac.7.2026.06.03.11.21.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 11:21:06 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@arm.com>
Cc: u-boot@lists.denx.de, nd@arm.com
In-Reply-To: <7fbf606a-1c83-48e1-8402-04568b1761ed@arm.com>
References: <7fbf606a-1c83-48e1-8402-04568b1761ed@arm.com>
Subject: Re: Please pull net-next-20260603
Message-Id: <178051086566.2223942.9339239038601114815.b4-ty@konsulko.com>
Date: Wed, 03 Jun 2026 12:21:05 -0600
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

On Wed, 3 Jun 2026 18:15:15 +0200, Jerome Forissier wrote:

> The following changes since commit 4674475760d293d6cca07c2f85ef48029e08078b:
> 
>   Merge patch series "Enable splashscreen functionality on AM62X" (2026-06-02 13:49:16 -0600)
> 
> are available in the Git repository at:
> 
>   https://source.denx.de/u-boot/custodians/u-boot-net.git/ tags/net-next-20260603
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom


