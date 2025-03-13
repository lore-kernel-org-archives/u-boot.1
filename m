Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A515C282DE
	for <u-boot@archiver.kernel.org>; Thu, 13 Mar 2025 22:44:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DFE328192A;
	Thu, 13 Mar 2025 23:44:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="U78PnhMB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E71C81870; Thu, 13 Mar 2025 23:44:20 +0100 (CET)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA8E0817D3
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 23:44:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-7be8f28172dso97122085a.3
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 15:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741905857; x=1742510657; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=214RIJEL4WtSY14xdIjvCnJMbIHYhMiWaSxb/3KjW6E=;
 b=U78PnhMBlWxLqKuct1foa4haJdQGThsZRU4umk+7RetHsuZZNJwWbFcDMFubqrlxi7
 qviKWJIrjGqjgW+l8pwHU6hPCBAjSJn+SqBmPm66V3cxFbJNQ7sx/hIr+rqzFh49pAf2
 LbyXsjYoD1GYywCXHRSkTkW954BJvdoq9ATRM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741905857; x=1742510657;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=214RIJEL4WtSY14xdIjvCnJMbIHYhMiWaSxb/3KjW6E=;
 b=r1Pjc7LZPMMHWauz6+hcIRnhBHWC+ncHWf3ampcb+M6g4OCsJ/qhs/yC0UE/SWcJtF
 K8DrufRQJ/hznc+cHasCKQ2tyW4cOh4KF/qxM1yjCxXbDRBpBLg4aBguP7M0UZghLbTw
 FQChuTLC9noBcmD4f+gGQ6yL3Gw6ig3VJRVjhW1t3inEBqZcNK4pqGyOzX+h4yxfAGa9
 qOpSZJ7DaPYnSbMxeLpZpCvveqqvIuGLkFclrml0v+obU8qnyoVYQOkt4zc/bARqvmWD
 xc0HTPnRaxyOSAz630pe+vXw32WLdO052ptd+W9+G7pjuyrUcZzc0sTfy2/GenyR810q
 oY+Q==
X-Gm-Message-State: AOJu0YxAbvveDAhhPg+jmKFAZk0eF/AgVje8BiQLsv8UhR6I5mXSvrSL
 82ix3+NeMOia1Ax6FNWh/LLJB/ZWPt1oH7O7gpRVzE3OILwvH4HmehJnURHw/4ChLNKlIB1RJua
 w
X-Gm-Gg: ASbGnctZtHDNFup0a7kOzrN1Cw0LLuYwfodPRUuxWtGmo95XRmzcAljZOeByj5aI5TQ
 hy61q9yDcBPRH6UrfIsrNuK+wwjadMpaA4yr0dUJanx16mnCrzz28ffEaPr9AHwD32Wpxk9nGmB
 5wSpCHiXs/O3RfWxr+sFVhPu57jESuGJ1JI/2tAtYTYiQOVxLlvfrzeFZlApoiYfSbeJ93cGyF3
 /BdmxIv4uzty2Ka0DRazzrJfBE6IKvqJCxAWlG1rknthmcCy3ihrnerCr6ugT1IPNGn3tpXzjJV
 kXHh/JDyvYumQYjbs8fj1fc8AHqSBY3k2scJYjhfrefk
X-Google-Smtp-Source: AGHT+IEuQ2VJZd7HiZNqpumhN/02kgAfNRVSplZFoSubVbxG93CUBY0O4J/XEmzfmfNEbE3ctfijOA==
X-Received: by 2002:a05:620a:601b:b0:7c5:60c7:346 with SMTP id
 af79cd13be357-7c57c73cfffmr19324285a.10.1741905856861; 
 Thu, 13 Mar 2025 15:44:16 -0700 (PDT)
Received: from [127.0.1.1] ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c573c98225sm154508585a.49.2025.03.13.15.44.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Mar 2025 15:44:15 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20250226203109.3831895-1-trini@konsulko.com>
References: <20250226203109.3831895-1-trini@konsulko.com>
Subject: Re: [PATCH] test: event: Correct usage of IS_ENABLED() macro in
 test/common/event.c
Message-Id: <174190585480.2150240.1931622262561279882.b4-ty@konsulko.com>
Date: Thu, 13 Mar 2025 16:44:14 -0600
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

On Wed, 26 Feb 2025 14:31:09 -0600, Tom Rini wrote:

> This file was using IS_ENABLED() to test for CONFIG flags but omitted
> the CONFIG_ prefix and so did not work as expected.
> 
> 

Applied to u-boot/next, thanks!

[1/1] test: event: Correct usage of IS_ENABLED() macro in test/common/event.c
      commit: 5c2ad0799715e7c02aa98d946a04e526fc5802b0
-- 
Tom


