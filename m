Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A2F7C282EC
	for <u-boot@archiver.kernel.org>; Tue, 18 Mar 2025 17:02:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D4C881B42;
	Tue, 18 Mar 2025 18:02:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Su+YNJ9z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A2F681951; Tue, 18 Mar 2025 18:02:47 +0100 (CET)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8086F81D0B
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 18:02:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-22403cbb47fso111712115ad.0
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 10:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1742317362; x=1742922162; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uUGd5kQAhaxr8Xro96shzjxgOeDT55ug8SP9UYjvxV4=;
 b=Su+YNJ9z47G5nfZJSxe49MSz5FR1pAd2ZhiSUVUatupfRO4XayWb1kCJg9zK/4Wa45
 tO4O+QkTyAfw8HPGDN83t7Q068ffQab7BlSWmU4zG/Kb8oqBFiSzvVf5plAnJ7mujIil
 eKgxRqLaBhdyNWgHMSwx+WyZG2oBse74F62gM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742317362; x=1742922162;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uUGd5kQAhaxr8Xro96shzjxgOeDT55ug8SP9UYjvxV4=;
 b=PLcMvAL1vzJnBX8bywIc7iWkD1yBeC9l8dHHRth4+zgDjgUnCpcIa9uJPV3JCxqbB0
 PrAubQ60onsRNumuMaDwLTTiWmouvIVw/RJ4sJwWrqCD7gFBWV8laTcXsGhgfyYEVQYh
 fmUaxkaPKfczuT7bhXQewshFSlThyTrtrkfGLqEvxbYdXYSfIGiCRgmWj4RoJAeZBIP8
 xa+O7kjpZW/rpGCRAhLMkL8qMgXDolve6tij0EJ0VEAiq/ovoUEevl1EpSep0TXCZ3+r
 FtSlynNPCy01bEBtaZR/UkNZDJug6qpIaXHJEG8tR/3FzmiVKT3BySDFI7alWD/p79Yz
 XlFw==
X-Gm-Message-State: AOJu0Yz2JMfCP7UnQSGeaT6N0PdMOHGEliiIAEnRMKSgBLB72ygJjP54
 nHt/hrQ4BQdT1ss679PFCvJifkpHyPrBDC6C6jtYxZcRSIJs0S4qylYQOShA1G4=
X-Gm-Gg: ASbGncseJQ0EG4tkEtS1zMNnp/LNPUYDwO2d2vMZM+bfceNRELh2lZq4yvbyU72Wg7e
 2mkwn9SroNSYP+9xk8i1JyQwF/4rmq1BOyFzRWA1xBoqkjk8q2qwySrXkxjeTXFFY5NsiufbsWS
 +ju2Xtn8wTbJ7aAAaXZqqsPSMre+ZYzIS4kKkvtTluOnQ38HSPr2oBSL1NNkQezVgsjbZZGlIRW
 BWykq1n/MPfGkR0OzgnW7do2QRNwQBvcHrJ50mpMsHdPMbecUPej6Cy4Fuo2HiFIb1nDdlASlIW
 NfbpH1NMb+3+KY9m2StUtQecPiWg6mOtHpRxrkZhuPSd
X-Google-Smtp-Source: AGHT+IGs+quiTiodq1GSEp5iVkMhbEUscXADvlRqvX2vkIZtJm0dL0R6/SLy5s4zFKwBbD8OBoKKYg==
X-Received: by 2002:a17:902:f684:b0:224:10a2:cae1 with SMTP id
 d9443c01a7336-225e0af5092mr214453235ad.37.1742317361673; 
 Tue, 18 Mar 2025 10:02:41 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.138.125])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-225c6bd4e0dsm97501595ad.221.2025.03.18.10.02.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Mar 2025 10:02:41 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250220100013.43496-1-heinrich.schuchardt@canonical.com>
References: <20250220100013.43496-1-heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH 1/1] scripts: typos in event_dump.py
Message-Id: <174231736056.1761706.17999258265036198935.b4-ty@konsulko.com>
Date: Tue, 18 Mar 2025 11:02:40 -0600
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

On Thu, 20 Feb 2025 11:00:13 +0100, Heinrich Schuchardt wrote:

> %s/even spies/event spies/
> %s/EFL/ELF/
> 
> 

Applied to u-boot/master, thanks!

[1/1] scripts: typos in event_dump.py
      commit: 2ac91756ad9124a607af81fda1eafc436934ad4a
-- 
Tom


