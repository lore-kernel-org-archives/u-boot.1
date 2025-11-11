Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 598E1CCFA1A
	for <u-boot@archiver.kernel.org>; Tue, 11 Nov 2025 17:09:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2EBD83BD2;
	Tue, 11 Nov 2025 18:09:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lAD1gK0B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B32483F8E; Tue, 11 Nov 2025 18:09:56 +0100 (CET)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7ED7F83BB5
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 18:09:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-3e80c483a13so1190877fac.2
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 09:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762880994; x=1763485794; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=KGQYQVQmFq41OfXmSyrJx6g/Dy7q+WE1MahII8ch6o0=;
 b=lAD1gK0BZ832aKnInCoYfktEecZYntyZ2R1HUlXSKKLACjPDhpYTrMqYFuvspnBExm
 jq44JBpW2uHjbF/BIKHOkHroC2grRfBl94KdXKVAK07LmiPkb4bhbN7I3zuDiSOG0wkj
 4lTBHN9cqkQ2g4I7JlxK8bb7RmEK8oS0H8pXQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762880994; x=1763485794;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=KGQYQVQmFq41OfXmSyrJx6g/Dy7q+WE1MahII8ch6o0=;
 b=YqDX/fWx+9SLyOUIeOwUphb3x/+h9u5lEpGTmY4nBODvBH9yghaonF/orWiKZK53Pa
 jcwHXM58Gp9tm+2Awg0113vuLkAnUb4Hajyj2rXGxvxbcvuyrZVH5Gk7t5YpLtFidOS7
 00dFHBXdWWaC5Z3J9/f04xLVw0rmNkMLhkvM/yI0j9hxo1WZWUKoWwoSSwj3VSF92WWh
 kP5OMyofm25M22O9GZYY6UC8bS9ntUmMDzvS0IEi/Yzpv8sG8WXgDErFC4jhppxi3FL7
 zB5OsjQBvUTfS42blS1rtgP+PvIhxeuPScAv6kLapEPKKsZkTjy/70rQnaBW7+1YUYOJ
 or2A==
X-Gm-Message-State: AOJu0YwFaT8SCHDiWbmbSKD2UHu2YW4YjcCQYFs+JZoilCm3pIjI7X8r
 DTEAVbqb1Iklx3lH9BDeIW7lBe8DuY60OCrrFybGRSCleY99lJkAqI54bl0eL0UWx6U=
X-Gm-Gg: ASbGncuDRoklskOZC2gEYLcQETGJ/RZNw9O+2BA78cvEnaKEG6Cz1vutAnZUzqVDAdB
 BZcnqAAzrlgFXOESpXe8Zr2701PGVzC1jlWepjZKuAZRZmUltRq1nRup+kisUvQR7VuIVEXOnv3
 4Z0oF/pgOCD8AwExk5LcYkaPhWDd/bBZb6P3kBovNdZJ5Sw0XjSgi1PcNhe4YJt22ZIUIors9JV
 3c5OO5YMZ3of8XKHte03eBOy1dEzIPMbdwxZ8/EeW3CnkPhxfOK/vi4Qsh6I0/ebCL1eg0s2qEL
 JAB+kUtqrTWYcJA+/IDaCAIqH8F9NHkizQbGIPLP2bjbodU/QBZJCujtUEku+vO6AEcqs6TC0JF
 ShY9J5mzHFV4Ij2IBFeundlqM6i+T2mtyI22FhchrM8L0nW7Z56gF2a7TL6gyOi8IHExNL8mIUG
 koOBxNTWdCOQ0WKf3wZEBEuFAxB2l3UKShBQlnNowbj2txJRJD
X-Google-Smtp-Source: AGHT+IGmVk9tXIAowWX1CKrOdBvFmlFituz8kO78v1VpRmon7KXv2qu1/hU5DmIewKO6dpUaao+gYA==
X-Received: by 2002:a05:6870:f689:b0:3c9:89b6:c64f with SMTP id
 586e51a60fabf-3e7c1f2b021mr7479254fac.0.1762880994161; 
 Tue, 11 Nov 2025 09:09:54 -0800 (PST)
Received: from [127.0.1.1] (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3e41ed1838esm8164296fac.7.2025.11.11.09.09.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Nov 2025 09:09:53 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20251102151130.1429360-1-trini@konsulko.com>
References: <20251102151130.1429360-1-trini@konsulko.com>
Subject: Re: [PATCH] CI: Update to LLVM 20 release
Message-Id: <176288099348.692546.12558004643894751681.b4-ty@konsulko.com>
Date: Tue, 11 Nov 2025 11:09:53 -0600
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

On Sun, 02 Nov 2025 09:11:30 -0600, Tom Rini wrote:

> The current stable release for LLVM is 20, so update to that from 18. No
> issues seen in CI.
> 
> 

Applied to u-boot/next, thanks!

[1/1] CI: Update to LLVM 20 release
      commit: d5e2db3a4ab82e360f20669d19eaf246f01f32f6
-- 
Tom


