Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0ED7C3DA64
	for <u-boot@archiver.kernel.org>; Fri,  2 Aug 2024 00:24:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35CFA88B79;
	Fri,  2 Aug 2024 02:24:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="eCMx370c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E90F688B74; Fri,  2 Aug 2024 02:24:15 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA78688B7A
 for <u-boot@lists.denx.de>; Fri,  2 Aug 2024 02:24:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-709485aca4bso3365883a34.1
 for <u-boot@lists.denx.de>; Thu, 01 Aug 2024 17:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1722558252; x=1723163052; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F2yFejHD/KcZGgU5w/kNziPeIIHat2AqoVytCsydDtA=;
 b=eCMx370ckwM1K/bZX5vVxPzVea9jBrb/iVDUz74R0Yk7v9WymW1SMHAH0sXRyCJVKP
 rU5f8LN2t6RhA94wYZM2usxY8MWh6JgIGByVp/BwcmVmp7XyxnlqoEgjJLxpLjN36wXu
 4hI+6WHZOEfXcJ0AjOrxiAhyNUbpFlnJXwahs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722558252; x=1723163052;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F2yFejHD/KcZGgU5w/kNziPeIIHat2AqoVytCsydDtA=;
 b=p6qbcRRA7Oy76ZvTALYCfMrkFgKRMaHOzgpocwje3zMNnSaufd6QJhHZ5PaH8Kc4St
 SX8ouAWevLEcGVgVu9LwcdNPa2GcT6sRnEICPhYt0jP38uuLAffph4UYOpNfCc2xUOQS
 jv6VV+pWNpAm6vxa4McNPpTtAWRpjB3yEw0rUhB4ercEu+wg+M3FTJkArruxKNxSsKWM
 wYRdEpGYM+M8vJ2gcsFasKpj8wLn94MIn/f5IY6Wui8k6KGeaIbb/33n1nZm22c7Pkoj
 FkarVZVmDaKVT46lXLXyQxJbT6DXier6ezDpudORVfxy1fIfKGNjY6nm5+S1LdhYpT+3
 o2aw==
X-Gm-Message-State: AOJu0YzX0p/qqDJcGmYza+f+eF7LsvKw8wcWXz2MgvK1POamgDYLL6IU
 UsBLGksUo4ML4NCXI3AiHQ3JbjgnxxwtgUEWBrPiuooi1cNv9lXEJHmD+CVrSIc=
X-Google-Smtp-Source: AGHT+IFEH/6lfhIZfdNVB0TfHIe4ad8GfjOEZz4fD3Rq+B7KFTyxHi+AvbcL086UZLRmlzJS9MnlxQ==
X-Received: by 2002:a05:6830:6e8b:b0:703:660f:f694 with SMTP id
 46e09a7af769-709b9980d75mr2616809a34.34.1722558252622; 
 Thu, 01 Aug 2024 17:24:12 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-103-190.totalplay.net.
 [189.203.103.190]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-70a31d9dcaesm232611a34.7.2024.08.01.17.24.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Aug 2024 17:24:12 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Alexander Dahl <ada@thorsis.com>
Cc: Sean Anderson <seanga2@gmail.com>, Lukasz Majewski <lukma@denx.de>, 
 Peng Fan <peng.fan@nxp.com>
In-Reply-To: <20240503072009.11602-1-ada@thorsis.com>
References: <20240503072009.11602-1-ada@thorsis.com>
Subject: Re: [PATCH v2] clk: Revise help text for clk_get_parent_rate()
Message-Id: <172255825085.13067.17016586916876798422.b4-ty@konsulko.com>
Date: Thu, 01 Aug 2024 18:24:10 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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

On Fri, 03 May 2024 09:20:09 +0200, Alexander Dahl wrote:

> The function returns the rate of the parent clock, the previous text
> made no sense at all.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


