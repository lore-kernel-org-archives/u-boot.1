Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45B00C531FA
	for <u-boot@archiver.kernel.org>; Fri, 24 Jul 2026 09:49:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E68B160B50;
	Fri, 24 Jul 2026 09:49:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FxPigUPBh9v1; Fri, 24 Jul 2026 09:49:50 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 18CC160873
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784886590;
	bh=GX4w224PjC9hU8T5b2HibzBMjdEhInmhQKzae7/DW5o=;
	h=Date:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=E95mwdBC2lbr077LlkNbWiheQBqPgWqnzLxO/A/NI1J06Gc2/5gIvOYIQ2mPz7Kz6
	 PKZ5jNCyEUKfFD01PuZNbjCeOS0V6tdlsXvjU/PRVYCclc9nmytm5uTpLJBbrWiqK6
	 8dfB4iZsFBWWNnYa2WCfVKWyZfAM/+AjzAZLTTPhOk7ZkrQDy6+ZG0f+MJZe1f0E3E
	 E2tuKDce2ubce37gF0eNtJt28Id8hjaRfbSwAin8vb7Rv9SWSxsbdrKz/72P9YPubH
	 xex1ynftufls0AIjDvpTIIaZJSLdorjP6vOHPe3twvOrYJhDh1YYrIPKHucZQ3yTMR
	 ygUJVqaBBaA4Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 18CC160873;
	Fri, 24 Jul 2026 09:49:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id B4E57A47
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 09:49:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A673360B17
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 09:49:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gqQjlbTlBD4H for <u-boot@lists.u-boot-project.org>;
 Fri, 24 Jul 2026 09:49:48 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::434; helo=mail-pf1-x434.google.com;
 envelope-from=leo.liang@sifive.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org E7781606A8
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E7781606A8
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com
 [IPv6:2607:f8b0:4864:20::434])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E7781606A8
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 09:49:47 +0000 (UTC)
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-84a2dcede83so302069b3a.3
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 02:49:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784886587; x=1785491387;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GX4w224PjC9hU8T5b2HibzBMjdEhInmhQKzae7/DW5o=;
 b=rvvbTr/SO0SKfI1sbsGQ/gosEbiWPbMqNCU8dG4vKG9d3+KMY2Kd6X91gDGjfsBnst
 C1I130/JN4L06Vfa4+YOX6Jo1tY82+uBPO1Vs56hzpuHChHLoL5oyx11IKIeEYrtHZAG
 bAx1DKQWIU4PGdqegr1c7qytdx+tzaD9rV32u2amHs1pFzFpYwJF5/7fN92cWqzzsiYI
 5gsYPbkIPjD45nt1xPAyzhy8IIPMtS4ifF9rTKSoL7dl9+exEzNhgp3mHf8TDovYvQZ3
 FNN1aOJLfFQ2HO+/7ImBm1V4tOGCDLoSMzf4bVu8dbwso0QcB2DupnsRpsc/kwXBT6dj
 zwxQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqrMNSozk7U4RT0ioF0PjTMdkJufyzvV9IxQoXk26vnhUBf8mHJhaJVmX/7W9Vf487Jj6f8PUw=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YyQkFVsVi01+DyW+sfrohYlIAcs9FJGeaE1WI0lmICfxcnNL0sM
 5YFDukmuQXgNPwosHz7M19hoJdgMTEs0Lt8u96Y9BOPliA7Br+Omxge7BAeXhRFfgGw=
X-Gm-Gg: AR+sD11i2zqdG3PZV5eHKqK0DyVKUILmO43OwpWB3+5F0ZfaD9Lpl8ANhw5Ec+GxFBk
 DAtFj3bGM7a1c77SNWbarkdgpqPuiLR51pSVyS2n1e6bW9VeFniW9Vhgyy8HFknWhkQ0Y0k8kTK
 Je7/+IZnJxd7vw5O39tkQy6QBo8Zixsy02eA/uD0Fq2qhUSXRrJCeoE1KcSLOUu/oBMQVA0ayGy
 VNZO3+PCsuMIY3oN5GlbLDYUYkIKEpF37jqocxfd1FYfzZJONmT00eW0fwJYWlhtpuOYg0Tt9Zl
 TnbhmLCqISxspfUf5sJ6a5ADdhiSQnxj2JtlypvTpjkUagXInm0RXTDYyEEAjj22eoRvPpCJIdO
 LW63xwka+ywBHhiPg+bj7b7o7uZ0k4WlvB2QwHHrJRJ1OTZr+pTMYRbgCDVNpZL/nlChMOyal4H
 dBPex8GFh814t0Ub9s1VQ=
X-Received: by 2002:a05:6a00:2386:b0:848:5c00:fa91 with SMTP id
 d2e1a72fcca58-84e2c17b3ccmr7646760b3a.38.1784886587313; 
 Fri, 24 Jul 2026 02:49:47 -0700 (PDT)
Received: from lliang-1876.localdomain ([136.226.240.179])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84e17266107sm4474045b3a.17.2026.07.24.02.49.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 02:49:46 -0700 (PDT)
Date: Fri, 24 Jul 2026 17:49:40 +0800
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@amd.com,
 Conor Dooley <conor.dooley@microchip.com>,
 Jamie Gibbons <jamie.gibbons@microchip.com>, Leo <ycliang@andestech.com>,
 Randolph Sheng-Kai Lin <randolph@andestech.com>,
 Rick Chen <rick@andestech.com>, Tom Rini <trini@konsulko.com>,
 Yao Zi <me@ziyao.cc>, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v3 1/2] riscv: Make RISCV_ACLINT visible
Message-ID: <amM1NB6WKp9bGt0D@lliang-1876.localdomain>
References: <f5c30c9faeba9e0f519fdf89c10e04c768c5f92b.1778849270.git.michal.simek@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5c30c9faeba9e0f519fdf89c10e04c768c5f92b.1778849270.git.michal.simek@amd.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1784886587; x=1785491387;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=GX4w224PjC9hU8T5b2HibzBMjdEhInmhQKzae7/DW5o=;
 b=cnbAj2c/bGCQanycaWsvs+CHuB3nIX+cXvGNT6IFN+BD/aK3e4Feky2ZbCB4c98moM
 Omh9ZSCG6FasNJybNotqqL7ZJ0GUearq9kGlPiMwe2hSBMrxbiwfhorRMA7qsBV9XT0l
 Q4AfyvTA0udgz02Oq9W8iGfJ56PWAaWAw5UsHcRxsKOp0iRPivK+s+OxUt4QRUs6bpQU
 Plq+t1SJ4VHGYHyrBqkxa4luudFv2z4lJ933IvZGl18baTK6ImIxv337PYz6nu1+cRkJ
 kBbCajpl5tqj4lOCokmusOIo/ahj6UEzX34SoLCOUmdQnueK/eUM4Lgq6b5QtwVTpGaN
 H69w==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=sifive.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256
 header.s=google header.b=cnbAj2c/
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Leo Liang via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Leo Liang <leo.liang@sifive.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Fri, May 15, 2026 at 02:47:52PM +0200, Michal Simek wrote:
> A platform (like Xilinx Microblaze V) does not have an ACLINT (Advanced
> Core Local Interruptor) hardware block.
> 
> Make RISCV_ACLINT and SPL_RISCV_ACLINT Kconfig symbols visible with
> prompts.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> Reviewed-by: Yao Zi <me@ziyao.cc>

Applied to u-boot-riscv/main, thanks.

Best regards,
Leo
