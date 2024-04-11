Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F1BACD128A
	for <u-boot@archiver.kernel.org>; Thu, 11 Apr 2024 12:44:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D602F882F6;
	Thu, 11 Apr 2024 14:43:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="r25hRqH1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18F5B882A3; Thu, 11 Apr 2024 14:43:18 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 230FF88244
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 14:43:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a46a7208eedso1112488266b.0
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 05:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712839394; x=1713444194; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nNQVEnGCaMOzbjq/F3aiu8UEOCqOLxB1anBPCdNiiW8=;
 b=r25hRqH1mDWynClas2DbdSHB+n9pcIXbBrlFByw8ss2NY9mcGkbo5sQ3aD6a1QTwAG
 k5xP1ZkOp57rkQNuocGLVhf1tfykRIbiEiN7k31ETPri/fEyyPFUqnTeiBLCCu4NQNB8
 2zIFwxKO4fjQ+elk0QIixdDQ7ZQeuPNcGZgLHyqZ1Nftc1Amfuz5OBlc4CyAI0rJRYMX
 tlvQN6LhIeA4HaP8qtCRHnHjqrVfV99K+Z8nb3lar3OyvnREHa+fzgofcAKP0h3ClK8X
 WzZtZr8HP0HN+TL1ZdxDRPAv4pES9lAgpFSnDWhAXXKrxsOA8HCPfM5Wz2o6BZR7JKDd
 g8VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712839394; x=1713444194;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nNQVEnGCaMOzbjq/F3aiu8UEOCqOLxB1anBPCdNiiW8=;
 b=Q/ko21lFBgiEw6DwRvNH2dy8oYMBV0/joUMceUKNkYBgZNhzfdeuf65xz0KSuHQMW+
 vrg2vNZVZX0dbfBSVOLBCDtXLERZSgSWNKq45JDSk/104Hx6mnnifNNEZ3PAf5FdFNvM
 2BGkIgNoK8wKKZ6/zkJmL2CWQQm5EJvX+UOgBMzqgt5441FCxZuwyLeVkM05jxJkG+y3
 yZ8UxG7RGfytCiKH7g9TwdFY8fesNF39xgYRT/xZi0hQg2rFkVi7LgLbIEryXCNuFPho
 q59+hwmjaNIGsidtFrykHH0pBoBxe2kwn+1asT6wv3t7Xm4cazRN4yiuDmyI7RMxJVx3
 cx6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXI9VylxLHU2+XrAkvHM5X5Mxz4dap8YXiREI4OvnnOC+Fj8vfaFwzstQ8b9bNNjsF8/Xzyjb3bP8OLfNtklm4Ulp5iRQ==
X-Gm-Message-State: AOJu0YxH6W+MgE2LeFRcYcTwAr3Pp82bTEh6eVgmTdhdnVauKL/nckjj
 bR83eecdBtafkznvaQNsf600BiSIFtSZiqiUg+2Udv7owvCB05HDvupPceykc9SS3I6jwJ2hPZ7
 7
X-Google-Smtp-Source: AGHT+IEDfhTth2gtLDTk+JnAVmTj4zYOLeEXBQUZAlrHDxj50M3QKER3d/XBVy+MV93wFSx0+L3sog==
X-Received: by 2002:a17:906:b2d8:b0:a4e:a7a:84e0 with SMTP id
 cf24-20020a170906b2d800b00a4e0a7a84e0mr3267026ejb.34.1712839394780; 
 Thu, 11 Apr 2024 05:43:14 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::570d])
 by smtp.gmail.com with ESMTPSA id
 e1-20020a170906844100b00a4e8a47107asm710491ejy.200.2024.04.11.05.43.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Apr 2024 05:43:14 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, u-boot@lists.denx.de
In-Reply-To: <20240409150252.561029-1-caleb.connolly@linaro.org>
References: <20240409150252.561029-1-caleb.connolly@linaro.org>
Subject: Re: [PATCH] MAINTAINERS: add Qualcomm mailing list
Message-Id: <171283939376.622116.1340488880042920142.b4-ty@linaro.org>
Date: Thu, 11 Apr 2024 14:43:13 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev
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


On Tue, 09 Apr 2024 17:02:51 +0200, Caleb Connolly wrote:
> Add the newly created u-boot-qcom mailing list to keep track of Qualcomm
> patches.
> 
> Additionally, link to the U-Boot Snapdragon custodian tree.
> 
> 

Applied, thanks!

[1/1] MAINTAINERS: add Qualcomm mailing list
      commit: b46a2aec4cd5937ef6cd77601ac02ac0fcfdb4c4

Best regards,
-- 
Caleb Connolly <caleb.connolly@linaro.org>

