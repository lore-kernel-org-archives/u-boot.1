Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 953E2D11193
	for <u-boot@archiver.kernel.org>; Wed, 26 Nov 2025 19:10:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 717B883AB7;
	Wed, 26 Nov 2025 20:10:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="EowjO1Nw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7CBB883A84; Wed, 26 Nov 2025 20:10:32 +0100 (CET)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B879839E4
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 20:10:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-450c9057988so32043b6e.1
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 11:10:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764184229; x=1764789029; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=c+CCF30rb9EzCvkTyeF3Xmjqt2hCD50FNAOjDzdAJ/o=;
 b=EowjO1Nwi1ewxW4ub8/BESvTtZiWH/YH+OxIgOrP7K++LLdvGD0oE/XY7C+If4SYut
 uiP4u0OaimD0ewp7fantcaWpH7bv/aQ9anXIviZ6pauht/BinbWnFfxU8XafUEHf8rxv
 Ur7UWOpLMTCAOyH3zMIllqH/42R4KZpcjbeuw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764184229; x=1764789029;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=c+CCF30rb9EzCvkTyeF3Xmjqt2hCD50FNAOjDzdAJ/o=;
 b=SbKGi/bAFvrQ3bmTFGyLGpeitfZoj7s7j5ViWzYFD9jMzROQ3sL2Ys8G6v1b2X083O
 WretAeXscjJVnTpo+Yh2Lzi0QoQHx1RVY2XHcjya9wZN2hmcQDVNR2jxMz36Wy3UasgZ
 rkbJ3LGqXSQ2B/7GGWurZIiJRwkuYM9/hNRUHjJ5pkamGoAyT1zZknOiVIdQ0Bku/0m0
 X3e663Ic/5cRs41kd8CmLBzpi+Ixv8uE+RFiQ57nz1aVQiILaGsW1PcTuN/ssYZByupL
 w+8FiMgiZRF6L1FEX36eiVrabOnnMpNZO3p+HokjhXbTcoVVIZRc/UVPLn5GIRg+P1SU
 4t9w==
X-Gm-Message-State: AOJu0YwLjToU5mn9oXpx/nfAIji2XR4iaDWNYIOBSEdeKHYQg383M0R7
 ywRjUZJAXf+RL52ulycQdFaWCK0nEqMusxr2Ww45PsdyHr4HFxVggVqFkSLalr/oQwQ=
X-Gm-Gg: ASbGncvgRE7p/Hduv4uJeoX+2R/ePvtY8rHyOLlsHkHtEDneRoxzfnyt2vH3bU4T78O
 0MPzwTDQtqah58UpBF/u5SrAtthUdk9+WeTmguQ/TkDJ+L7g0K0wHFG3414xnzLdClT56mHlpjM
 vTiKbSLRVw9sKYWBIM3/2x80RXmOpvKfc+PE0Ug4VcfsJ/cR+98eHFFJT1HN5iQ2Rx75uK1CyyG
 r8iVxFvIN2wsIF/6tWZZwzdkTgf2XTiRyWm8Zof7fhhpbxiCgHK0cEMc6kMlcXhngxQYil61tux
 mIVPIefu0NiZImGCK4oUMLDM2Uq0kUGkq4/Mu4eXGMwan3ZQb47QmFbyq4ZTqmCsUYLaUHZzSiL
 C0bj2FFc0Fj4LOFluwAA++LxJ3miFLMZw+MCkp6+ivSWZd/Fg0c3KBb9jbl0x/VJ79s37y2zSTB
 49jTWK8C1EaiUY4ZYgrww62YAZ/FcNgc9Z3fSQERlTpbVaq8HU
X-Google-Smtp-Source: AGHT+IE/x7TXd0NbiNIh9zMJP0cn0dHKzDPEyJFidVy5vgCeIxrVgrL3ke66oQx8J4L1647SvlFZ7Q==
X-Received: by 2002:a05:6808:8953:b0:450:d568:a50 with SMTP id
 5614622812f47-4514e834249mr3586780b6e.56.1764184229073; 
 Wed, 26 Nov 2025 11:10:29 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-65782bacf02sm5227803eaf.15.2025.11.26.11.10.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Nov 2025 11:10:28 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20251126190626.3799644-1-trini@konsulko.com>
References: <20251126190626.3799644-1-trini@konsulko.com>
Subject: Re: [PATCH] CI: Update to latest container
Message-Id: <176418422850.3800471.2070071962969738606.b4-ty@konsulko.com>
Date: Wed, 26 Nov 2025 13:10:28 -0600
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

On Wed, 26 Nov 2025 13:06:26 -0600, Tom Rini wrote:

> - Move to jammy-20251013 tag
> - Bring in tkinter so that FATtools should run and more tests should be
>   run.
> - Update to QEMU 10.0.6
> - Pick tags for (most of) trace-cmd
> 
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] CI: Update to latest container
      commit: 0ae3dc6809ffb6568b5e46d9022829e36d473d36
-- 
Tom


