Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 896DBCCF9E3
	for <u-boot@archiver.kernel.org>; Fri,  7 Nov 2025 21:36:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E72A83E40;
	Fri,  7 Nov 2025 22:35:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uwpBIyhq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D52783E81; Fri,  7 Nov 2025 22:35:06 +0100 (CET)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1758383E23
 for <u-boot@lists.denx.de>; Fri,  7 Nov 2025 22:35:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-3e41b6469f5so607713fac.2
 for <u-boot@lists.denx.de>; Fri, 07 Nov 2025 13:35:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762551303; x=1763156103; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lMb7Uxr30alT/rSM2K3q1k7KFRYDnPsACSW7IAs+jDA=;
 b=uwpBIyhqYYjBurag3aPzMyA63W60g9k2tswovoJIi8qbyOFPh7KrgYcBrGnsEIikvu
 7i0SWz8jbjuPKnn2XeGlUUgIt4KqTIeMGsXxaVIEUFb/480JmGtwJk+fT99zGdwDbS7A
 T/4J4+qffPrup4hEkeK+DW4ttgO/j5Lfq9hFI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762551303; x=1763156103;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lMb7Uxr30alT/rSM2K3q1k7KFRYDnPsACSW7IAs+jDA=;
 b=Yg+RvP34MEGS9BXHYNHuORDL52jcsJ+o+zdEWwWaAwsJuXO7Pf0tSmJMhhkmxAwKMb
 IcP0bNTd/sRSyRk1KsIwPEM/VevNiP2tVFgaHlVNyeh9xwXONq2EPXB1eM9HhvRP1YmD
 wveoy4ClN0kbeCQuscXX2AQtbT2/fak2gGvnOw0g4Y5jldvZlfvu3ACmUH3Yn6PDRe3a
 Ut0KN+7y8aWXtPvUIoun/BhRc9sPYbEkopUE3uDqYCsiVKPBfJ94/8qE4wKnVJ5mvERB
 QniCANZTBetC8RQxIQGd6qjUP+Wu83qtHHpJ5L5bzPRtInsjy3y9HzMiHDBli8cnYJpm
 1m2A==
X-Gm-Message-State: AOJu0Yx5GHbJ4lXoAL7jatw3+AuW4KoEIivGiMNfTBfVuiyyPHnDTgir
 LM/o9Mm7riPI1kLly1lA5XBA6VzfM7I4I9DibwfwbSAVNknz11o6H7yjBTMDJFtWzhF73k3fLLy
 QCDnzY8KpLQ==
X-Gm-Gg: ASbGnctxBPV4w9seT9RXs7g+AN13hGTKaamnNBCkMyc8HeYO/N/OjZSA1SXiKSEK7dU
 YLfJTAtONzg7pbXqEdrqD7XvY0V5qjh6mfz6k2wi6WZ0P2qiYvm6/D9Et5qUTAVLcKdfq3U1g0U
 clOWiSVbQobUCX6+ATZoKgbn0PZRMBzwXfUuV3ldlSQacSBFXf19dJ0op9ImaHJOmls3BUsAWEe
 hHUVI0OSBNKgZ8m788EfOCTLy1f4Izn44LXhMEjLSCeKmuOfvJAE1VGQjs9l/WZ8lXg2ifNtWXC
 txdbT0sIxBPnQWlsmqL85hTCExz8aJvALt1DHvUPXYVSXCXNynxIKGgh/rw/tTk1rl+zJnl1TiY
 +atRc5CNgjS9G1Y9Kk9HDt6ITSPhh4ArE9E3y25vHlcSV/YTycxgJMFZBOj73ODv/oOMl+IlLpu
 7cRYh0hIcSDG3puG3NyRFOfuXj3ONTrCt8rNM/NsnHbpjMRNq2
X-Google-Smtp-Source: AGHT+IHt1fIBh0SHT5oLrSpdzt6OpiUC2iBpRqaAw1K2P+iwgTrl5f1IYYK9Xyzfer0RZYeAPFVDoQ==
X-Received: by 2002:a05:6870:169e:b0:3af:2418:d6d5 with SMTP id
 586e51a60fabf-3e7c252fc4dmr604800fac.19.1762551302732; 
 Fri, 07 Nov 2025 13:35:02 -0800 (PST)
Received: from [127.0.1.1] (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3e41ebb0fc6sm2507000fac.2.2025.11.07.13.35.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Nov 2025 13:35:02 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de, Bin Meng <bmeng.cn@gmail.com>
In-Reply-To: <20251105012649.11067-1-heinrich.schuchardt@canonical.com>
References: <20251105012649.11067-1-heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH v2] block: typo 'to be write'
Message-Id: <176255130209.3424353.885161744666592162.b4-ty@konsulko.com>
Date: Fri, 07 Nov 2025 15:35:02 -0600
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

On Wed, 05 Nov 2025 02:26:49 +0100, Heinrich Schuchardt wrote:

> %s/to be write/to write/
> 
> 

Applied to u-boot/master, thanks!

[1/1] block: typo 'to be write'
      commit: 928af44314a1a086e946ef3c0901d40bdb3e19a9
-- 
Tom


