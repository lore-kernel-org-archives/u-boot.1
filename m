Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95C19C35FF1
	for <u-boot@archiver.kernel.org>; Thu, 13 Mar 2025 22:44:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9AA84817D3;
	Thu, 13 Mar 2025 23:44:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="f9YOPwY5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 806828175D; Thu, 13 Mar 2025 23:44:19 +0100 (CET)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com
 [IPv6:2607:f8b0:4864:20::72f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B82478168B
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 23:44:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-7c3c4ff7d31so200294385a.1
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 15:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741905854; x=1742510654; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iYRzxx+MrSuC0NCVt7fJgB9WOriosaeqtWUzZSTCjpI=;
 b=f9YOPwY5omStzNRyBb7MBW4UxlwaDFgpTt7j541WaK5BfLwou76ZVoBffdsdYNLFQO
 wGmlj1VQDRaQ1/8Pv3S+BXQCNW0m92k9PnAGM/HUXVq3k2Vmzr5dqnZd/5/+3VS3fKQs
 7ugibH7F40KJH6uWra8E1IMEqshwYD3FwHSxc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741905854; x=1742510654;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iYRzxx+MrSuC0NCVt7fJgB9WOriosaeqtWUzZSTCjpI=;
 b=ZzR5/QnBdTPUcYRH/SBAw/5YEpF43d8VZdIBVU6QIg3EE2PLOp9Roh+WhKQ6BTDvET
 3zIp++uekFz5HhTSv/ngO+P5Ob/iBoTXbCmS6TfnVPz0guLUneamRV5P1rgivXSWbXb6
 Grnqh7muOztK0qNrgU9loXR0ADxv3clP5yiv1TucNwyU56F59W8e8YZ7+EQ1spIpFemj
 DoWn1Xgs13Vh6mYKGNvIoCuvZ257DjF2zwejscqH3sE8Kw0t6czwKXj4PsWzyVrcpt07
 xzKBmnCCN8r3zUkmAI+OWW1aj7p8ch1WbuSY0w85hX48qnJRZHmiCDcg/O02NqaftxDH
 MuhQ==
X-Gm-Message-State: AOJu0YzO6YsDNRWne4q2wUqJWhBxSdflZr/qjfo/v5O7+vyIc2OBpTuq
 gV3j45Yi5/nfrN49PhSqUSLqq+Fpco6Sm7O1TDcZi0ZBkscvJ/tAOQRC019qyRZzOt+nhNqNEu5
 i
X-Gm-Gg: ASbGncvEV3q8yJQh9H21s3sgoz57j8Ffjm5buTNLaS+UeSDvF/a7h7oyI5JJWcxYlu0
 RI+ZmYoEQDpe/U9UC+28nbQwHwYDbxEyIRcwTEjzxxh9e02bbEUQk2iIquHiZJwbQH5CHJmKiOY
 C/4dt7/tOSkwpI1PT/PODY7J0jjgLa25joBiK+zjjroRAUSsWBMpfDkzvNmp6dcFmRrYtbj00Rs
 lE86D3Rza1KyJTOYAthmrHH6jDfBCO/P5hN81nxVImhPuYb6L35sdIaWOdvm4SPlDOmuUyfyz44
 8mqGzYOT2nrHAndV0th5XLTwgE8A2kSvZj4F5kS27sxI
X-Google-Smtp-Source: AGHT+IFsjtQhqShMCAkTvPiLx2RPVNpvy9MO5+gGk6PWnt8zsMaBjaIuk0PZoc90TjCsnAEAWsYL9g==
X-Received: by 2002:a05:620a:4091:b0:7c5:53ab:a745 with SMTP id
 af79cd13be357-7c57c8fb0e7mr15200385a.36.1741905854665; 
 Thu, 13 Mar 2025 15:44:14 -0700 (PDT)
Received: from [127.0.1.1] ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c573c98225sm154508585a.49.2025.03.13.15.44.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Mar 2025 15:44:14 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Raymond Mao <raymond.mao@linaro.org>
Cc: Caleb Connolly <caleb.connolly@linaro.org>, 
 Paul HENRYS <paul.henrys_ext@softathome.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>
In-Reply-To: <20250226141952.1195955-1-raymond.mao@linaro.org>
References: <20250226141952.1195955-1-raymond.mao@linaro.org>
Subject: Re: [PATCH] tools: add HOSTCFLAGS from openssl pkg-config
Message-Id: <174190585290.2150240.11043902184438732422.b4-ty@konsulko.com>
Date: Thu, 13 Mar 2025 16:44:12 -0600
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

On Wed, 26 Feb 2025 06:19:51 -0800, Raymond Mao wrote:

> HOSTCFLAGS of some tools components (image-host, rsa-sign and
> ecdsa-libcrypto) depend on the directory where openssl is installed.
> Add them via pkg-config.
> This fixes a potential build failure in tools when openssl in installed
> in varied directories.
> 
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] tools: add HOSTCFLAGS from openssl pkg-config
      commit: 7a765a37b3d4dead659a061561489ccce1276923
-- 
Tom


