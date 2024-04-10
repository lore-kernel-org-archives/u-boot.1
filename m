Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2DEFCD11C2
	for <u-boot@archiver.kernel.org>; Wed, 10 Apr 2024 17:43:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB1EF8819D;
	Wed, 10 Apr 2024 19:43:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fCAehNZm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8380288180; Wed, 10 Apr 2024 19:43:19 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69C71878A1
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 19:43:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-6ea4b4d1024so161296a34.2
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 10:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1712770996; x=1713375796; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jYDh89+DhnWyu/+jYBAtTJ2+6O2xxMBegutxChmdlWQ=;
 b=fCAehNZm140wvjew07o8a+Tz3EWEu0sFCx7LbqKdBxVgq1Qu2rFH8LvvsFLmXlRAf/
 izv34nbqwe+jNdhbWyg7ckpIpd87L+0kO/ivBq4UL7v2XgaM6TzWtRjoZsLFDG36D7KE
 heVVESetY9b2I6amEoratOQRja8LAr+PIg37k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712770996; x=1713375796;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jYDh89+DhnWyu/+jYBAtTJ2+6O2xxMBegutxChmdlWQ=;
 b=EQtk8k4atmOJJEnBskwdhayoz8Cme6mOjUQZbTGdrAjR/zPl4cBHNl7ZebGj2bqyzg
 0iMCQBVu+4Uvj1oVS/UZiiQ4dHYSPfwZIMlsXAD+bJQ8sBlIJqQOUCcK7fV5DnsjYWpJ
 8JU8KUoBFVijnn/4Pfe0iq35WiCaR0vqSeja3gWFpVwI6DQ15dOez2bUCChWIAZ8dRvK
 OQujQh4fupeT7BWz+xXRAUch5i/6JTssZvS3kNX3mBR8F1z4tVnmPIsWzcb6ZIpn132x
 NW2J8lx+2FFoOG0MQUTyoxSFDGqtF5tAi1/2oiPIu3ule/r7j4ku4lfCSsMpG9Rod+eW
 64CQ==
X-Gm-Message-State: AOJu0YxvHgsEPumu7g7jvD4rKE+7gxBiIDI54sFr36X8/Wfntx6fXs3A
 5ojxhB2DTmHiy2yQ/YfuSwnxR72nC50tuqYxuD3Med8sWmu7LXm7OZeRf1eyfI66PO9bKcNKz68
 wiEhUIA==
X-Google-Smtp-Source: AGHT+IGFpYS/fuN55XPCmpgZyMVZ+0EZOrAKz6DCc/Tb1I2UghZSLJFw2HnxUJ10pDY8xaaRFuDD1A==
X-Received: by 2002:a05:6830:6b91:b0:6ea:1365:9fda with SMTP id
 dd17-20020a0568306b9100b006ea13659fdamr3546489otb.30.1712770995952; 
 Wed, 10 Apr 2024 10:43:15 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.73.35]) by smtp.gmail.com with ESMTPSA id
 vq3-20020a05620a558300b0078d6b676b9csm2308177qkn.17.2024.04.10.10.43.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Apr 2024 10:43:15 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, 
 =?utf-8?q?Pierre-Cl=C3=A9ment_Tosi?= <ptosi@google.com>
Cc: Marc Zyngier <maz@kernel.org>, Fabio Estevam <festevam@gmail.com>
In-Reply-To: <43haokus4jdxguk4arig5tsqcgq2wbezwpbj7oti6pdkvrfual@wa7vz2iypcv5>
References: <43haokus4jdxguk4arig5tsqcgq2wbezwpbj7oti6pdkvrfual@wa7vz2iypcv5>
Subject: Re: [PATCH] arm64: Fix map_range() not splitting mapped blocks
Message-Id: <171277099498.98421.4154709400340682931.b4-ty@konsulko.com>
Date: Wed, 10 Apr 2024 11:43:14 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0
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

On Mon, 18 Mar 2024 19:35:49 +0000, Pierre-Clément Tosi wrote:

> The implementation of map_range() creates the requested mapping by
> walking the page tables, iterating over multiple PTEs and/or descending
> into existing table mappings as needed. When doing so, it assumes any
> pre-existing valid PTE to be a table mapping. This assumption is wrong
> if the platform code attempts to successively map two overlapping ranges
> where the latter intersects a block mapping created for the former.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


