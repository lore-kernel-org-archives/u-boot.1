Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45F95CA0FF9
	for <u-boot@archiver.kernel.org>; Fri, 29 Aug 2025 21:11:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9ED3183642;
	Fri, 29 Aug 2025 23:11:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="p7/Knzg8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8AD30836D3; Fri, 29 Aug 2025 23:11:26 +0200 (CEST)
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A669835FE
 for <u-boot@lists.denx.de>; Fri, 29 Aug 2025 23:11:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-61bf9ef4cc0so1551148eaf.0
 for <u-boot@lists.denx.de>; Fri, 29 Aug 2025 14:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1756501883; x=1757106683; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hw980OQIZqoloWrz3jphWaRX9ukRVnYZeeY8zZdUhCk=;
 b=p7/Knzg8nnWE5KCNww9ecKYfQNt2fn1bkg6E1Et9BgflE/6vaYpnCdlP+SXOfmyxHU
 cfGpomjDHMmdqWZSib/7YAHsTAPEkSZc9riXIktC1FuTBd2XYkKC3yXa5j144drRKsYn
 VCLhAHl+SeKSOU91ikBYF2QlTJ7GPNQv5J5jw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756501883; x=1757106683;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hw980OQIZqoloWrz3jphWaRX9ukRVnYZeeY8zZdUhCk=;
 b=YDfRv4vqy3UBgEi2n4TDE8tAOUpG7ByOUNf3XyVxqMo9UYH8LJnwZo9SsmxMsMzKDM
 ekl2A/hGiv7ZD6AH4djKgJmq2nYD35OtTYwAdzeSQm0QcxqkQZ4vAniRZZCHPUd5yHzF
 mA5YahWxTBhn5sGR6i76wulWOojZz59AhcoEas6Ycx3es2C6hBNKydmL+G4enH6Sj38t
 24RSXFQWwZXM6nNoqP9aNMk0FclHS3j+o5AxgdLNZ1NCUc2/YsyDxIEowdX3xnKoI20f
 atqkj2HbDHIL9PSzwnAFUcLSIJeC7zxOzUMUXTw9eTdjF5XpxxRmVVLzschaC/iaytYh
 qmPg==
X-Gm-Message-State: AOJu0Yxf0c/eVrrHRkDQ51YSY1YJH5OQbOBDAyMKI/FBa15q7ZEijpQr
 h4FzrUMWpxuhuQ/Ndn8/dFBdLB8tssEFZcqz3aAAbaNQpTvos7E0ggpBLgYbQjCKX+U57y8oVQ2
 iSu6hpK4=
X-Gm-Gg: ASbGncsvgmwEvq//gPw8xlRTY5JcpWfT6VMo7E8IKbhbJucApIuk5QAYJVMstZZEW7K
 rfxFhEDTMFYMx4vTCRhROAphuklxGVyGV4dZXsSdTfLKlVtTwIEzSbE7pStmhEPOTwY/Jbpq1Yk
 9yroVuEb7svWJABwwdmBdvzLAPAu7ShhBbQkdc1jrhK+ZVJj2/iQuQ7z0GdAoymrnhSLRvBnNKC
 JgGrTCC430sf4eGHWDy2FlFKKgInqQyxKVuuMB7R6pz7iZZX5VZExEsSnGP1AVPwYbq07gpjjWL
 hkBKnxGSFwbyCV/C41eN16Ztti7qnEi6dJ2YnGdoBLgB9gMJClZlm+XRHbtySnknyaHLjj7pcH0
 QWCsJNCmxMO1fLEpMdMPyRU7CK9+HC0ZQom9KMV83oR0gyaycVbLhkbA=
X-Google-Smtp-Source: AGHT+IHCS9Kere96OBdnzXU+YdLkhNAclXoTUJSgnkX1Z5+wkoRYjvJm0/i1Pjw3guXA40hWhog9Sw==
X-Received: by 2002:a05:6808:250f:b0:435:6f4c:8b1e with SMTP id
 5614622812f47-437f7cc00a9mr24004b6e.6.1756501882691; 
 Fri, 29 Aug 2025 14:11:22 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-315afc59e27sm1665401fac.12.2025.08.29.14.11.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 14:11:22 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <20250829205203.281150-1-marek.vasut+usb@mailbox.org>
References: <20250829205203.281150-1-marek.vasut+usb@mailbox.org>
Subject: Re: [PULL] u-boot-usb/master
Message-Id: <175650188177.2527057.1947762057749961491.b4-ty@konsulko.com>
Date: Fri, 29 Aug 2025 15:11:21 -0600
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

On Fri, 29 Aug 2025 22:51:46 +0200, Marek Vasut wrote:

> The following changes since commit 3dc5e9a0108bb114175b6362f9cb22367402f624:
> 
>   Merge tag 'u-boot-stm32-20250825' of https://source.denx.de/u-boot/custodians/u-boot-stm (2025-08-26 08:33:10 -0600)
> 
> are available in the Git repository at:
> 
>   git://source.denx.de/u-boot-usb.git master
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


