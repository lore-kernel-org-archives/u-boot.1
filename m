Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB03BD46623
	for <u-boot@archiver.kernel.org>; Thu, 15 Jan 2026 20:59:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22FC882BF2;
	Thu, 15 Jan 2026 21:59:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cIKsjnFj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3717E83015; Thu, 15 Jan 2026 21:59:25 +0100 (CET)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA9F780325
 for <u-boot@lists.denx.de>; Thu, 15 Jan 2026 21:59:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-45c715116dbso902677b6e.3
 for <u-boot@lists.denx.de>; Thu, 15 Jan 2026 12:59:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1768510761; x=1769115561; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=IYljNYLrkU0jcytuSHO80Wimuwmz27kTiaOYCFinpY8=;
 b=cIKsjnFjTCSD9FiKz0RO2oupVCxmurfkQputY33GFcB1+XeO3Cn/YinPEdIUUiPrXl
 9FfcErPCgv+LlZboCSFilpKPq6y/fINNfXo4oQj/EMJa+nXd6+uZlBmRgQV5yKa90ifo
 AzsckO1lradKPGcp0qywFzeM00palr3BAf5L8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768510761; x=1769115561;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=IYljNYLrkU0jcytuSHO80Wimuwmz27kTiaOYCFinpY8=;
 b=DCZIY3nHkBw9b7n0LnF/YhvcE3B22EaRNucjDNOf116UH9xB+PVAl7/cdJeWCsY7DL
 R/9Eo3f7cgeXmcsCAtXtWDjm6+LnjJycNELROrnG+Ci3DkuUyyekv4iCSxR/CS3SsJG1
 SIY1gvWOywH39/3Huvc+a7o5WohD3cB45aMW/cu2wYP+9ZD03B/I+0SFbJSy1yhlIfWu
 4Ry6YehQt9BQnMSiAHuMmfY+/dWC8iMY5f5ypb9bAf/LdHsrIf5thKsZUKPWq5Tf5fmm
 1CJsdkKlRXF+Qr6f9J9jxaLSVR7NW6zk6aa9VmZL56Mb0YKNNp5+5dxuGlG33udOPIyw
 OQLg==
X-Gm-Message-State: AOJu0YzCaYiXHWwOm28aiwM92nkztn1vx2yI+hh5RrjVPwS07SQHs4ps
 bvsqS7o34lYzD1b1fzGSZ4tHxH7+hXsopLm+J5eO7V3BYtCQSfTM+t30e17VV1dSVgMaq/iChep
 g+QDO4pk=
X-Gm-Gg: AY/fxX4BYXhwtpR99HMA8znGXYymRJ0jOn1Uc/JGGHJlyOOHVqM84YfpvsLRpEJ/uS8
 OddihcTws/yMnOXFbcv3w64nJh4f8JCmc4pUinWZ6ZqiE195xWYA+89vU5ycjeEVcm5bF8urqfE
 AeqB3UNExPFtUulJDtNSRGQ8j3CXUH8vAKzYtn7vK3/VQctvw7pUraoJW6ABrC40hOLms3yLmnl
 Qj95pK+Z7yL/zQg3IyWBFVapAsoqy1imXO7eGEibHkNJGeuXDhfeHTaQMkyvEum5p9m1fAM/lKj
 iYsVjk/Ddn2SIJrLuKIQOS1tfKzExy5pG+Y44+P7b6PA4Yqelsvavt0LU4/ZjmZEtnarVp0mwv6
 2LGsr9I7QRhLm5jvnNy3NFfP3/ysEJhDajRvBv3SNugHSjxcguVUYXfdxxLUb+BOIy4PzxzqxwV
 zTD/w8v8CTCrhuPdpTx1V+g4dYLEzVqPSVLt/lnRmmV0i/hY/Ay6UboWsG9LxG0oVuAvrr+A2Ru
 qYTNrbdyur4utcbsJtygNoy/sOmvK9x+k/YKQ==
X-Received: by 2002:a05:6808:2443:b0:45a:6ccd:761f with SMTP id
 5614622812f47-45c9bf53f82mr450754b6e.20.1768510761112; 
 Thu, 15 Jan 2026 12:59:21 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-45c9dff95a2sm228012b6e.11.2026.01.15.12.59.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 12:59:20 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <3e16301b-e9b8-4e61-85d6-8acbe7753226@arm.com>
References: <3e16301b-e9b8-4e61-85d6-8acbe7753226@arm.com>
Subject: Re: Please pull net-20260115
Message-Id: <176851076041.3921521.4589627621907349019.b4-ty@konsulko.com>
Date: Thu, 15 Jan 2026 14:59:20 -0600
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

On Thu, 15 Jan 2026 13:07:08 +0100, Jerome Forissier wrote:

> The following changes since commit d503633a36767d756c7de28305cf0de79440cbc0:
> 
>   Revert "doc: board: starfive: update jh7110 common description" (2026-01-13 14:18:05 -0600)
> 
> are available in the Git repository at:
> 
>   https://source.denx.de/u-boot/custodians/u-boot-net.git/ net-20260115
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


