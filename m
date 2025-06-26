Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C935C7EE31
	for <u-boot@archiver.kernel.org>; Thu, 26 Jun 2025 15:43:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D1F6182E35;
	Thu, 26 Jun 2025 17:43:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QRkW6obS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BABF982DA1; Thu, 26 Jun 2025 17:43:18 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47DCD82C4C
 for <u-boot@lists.denx.de>; Thu, 26 Jun 2025 17:43:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-73a44512c8aso275735a34.0
 for <u-boot@lists.denx.de>; Thu, 26 Jun 2025 08:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1750952592; x=1751557392; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iCL/gvsoav1UN8ErC7bRHBPyqIsOhLLEDPNrjtTfsF0=;
 b=QRkW6obSS9Gr+B+CnQ6UvAROqo7NyOj5MsrIEv5gErN+GWNRpjB/2JFWE3iv/upHVw
 RNZ081M90g3mezy09QHLBWmpPOE4efqMy3Sv3lW5vZYbIF3n0O4J0MK/rTwJWILVLIzg
 BNKef8VQwslZGWdCUjDScn8/NirFcViWxIMJ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750952592; x=1751557392;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iCL/gvsoav1UN8ErC7bRHBPyqIsOhLLEDPNrjtTfsF0=;
 b=l8pPJjZ+cksTITzAME+an1N7mcwcO1qZ4opC82lifBuN8Cl9y9TWTqXNK/I1pSE3Wb
 BZjfg+wgYNbNf9EG76r9GGBOE7sJ77Ni1kmGwcFFZH3KfVNTmdKVbGAh6s9aEL3JOrKD
 zZ1I2+FMGetu60K01SeUlhP54DFxf1yFfJzPo/QTb8235vlsHSproknflV7LM612jIWU
 AgVGtmV5ymU4HpbzjqNLGri3ryE4nSsN/WfC3PtsWCMRSFQJHEmQbsAzvJPgQ8PTefWF
 bBGfQ1VMP4rJVR7p8+CBeRU7oZK1OsqTo7xeC1PMbpYp/msr1tPjOuitsgPC7Lk2+Lhm
 D7zA==
X-Gm-Message-State: AOJu0Yx8pITvV+IVVN8Vpc+dJGl3T2I8FjAl/DpN7GzKOKDruP4g1z3I
 E0ZioenXFFpy0SmZRJFMWCMouB9zZ7Z2q7Mf2tioHLT/cYY6QkX8Xm/9h9DFE44d8UM=
X-Gm-Gg: ASbGncvmzIMfVWko0A4ZF/qOSPvDBcyQ7mGIWXIUpdcir4/GzAFkqBPY+7gGuSfNUq8
 Qdp64Z51lWiXTut+VBFix/5eJjMSWllPI39EqwPM0Jey/HK44xj75TZy1vl8wcOoXy+RfysE1cp
 4gCFIa8mut87htT3hklFW2AVKKq9UDUS3lbqKQEwtFIg2n+xqqhvwP9pLB3RBi2pMZCojZMQc36
 3K6S6Ll3///+iCH1NtwVvBCfxisDMjAmPYy+gddj4oXTNlYgPTZetvgl5NP9FkWDpXey3za/EFv
 5cJfambKRKRP+FVoKG8g4yCIYtuc7Id3NvG2/uIVt9HXlO3o89CpuJdd7fkatDOF1ia6s4MrxxT
 RhtZO7r2VaUP248VvS5m5lg==
X-Google-Smtp-Source: AGHT+IHu4LKLZgm1ULCnYEO6pH9t+DZe/+o7nlOxGHLPC4wsVYDych1pmZbpVkFRIVy+lUfmOxAIWg==
X-Received: by 2002:a05:6830:370f:b0:72b:8c5a:7294 with SMTP id
 46e09a7af769-73afabd0ab4mr336559a34.9.1750952591975; 
 Thu, 26 Jun 2025 08:43:11 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73afaff2429sm20316a34.7.2025.06.26.08.43.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Jun 2025 08:43:11 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Bryan Brattlof <bb@ti.com>
Cc: u-boot@lists.denx.de, Anshul Dalal <anshuld@ti.com>
In-Reply-To: <20250612-missing-blob-help-entries-v2-0-36f1c8078155@ti.com>
References: <20250612-missing-blob-help-entries-v2-0-36f1c8078155@ti.com>
Subject: Re: [PATCH -next v2 0/5] add a few entries into missing-blob-help
Message-Id: <175095259105.1712035.2504750483442874023.b4-ty@konsulko.com>
Date: Thu, 26 Jun 2025 09:43:11 -0600
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

On Thu, 12 Jun 2025 06:38:49 -0500, Bryan Brattlof wrote:

> Now that TIFS and DM firmwares are marked as mandatory items for a
> successful build[0] we should provide some more descriptive help text on
> where to get the firmware in the event they are not found and add links
> to more information about them.
> 
> We do need to expand the regex to allow the '.' dot in 'ti-fs-enc.bin'
> so we can add it to the list which was the lesser number of lines
> changed than renaming all these entries to 'tifs' or 'ti-fs' which the
> current regex will match.
> 
> [...]

Applied to u-boot/next, thanks!

[1/5] binman: alphabetize missing-blob entries
      commit: 562dcc6240fdb9b21e0e3b8da0a8452906e31aad
[2/5] binman: add ti-dm entry to missing-blob-help
      commit: f16f17fb050e44d9381c8742fa7ec1e37618302a
[3/5] binman: add sysfw-inner-cert to missing-blob-help
      commit: cf744bda69772cae34a48ee2d19eefd68231f09d
[4/5] binman: allow '.' to be included in the missing blob tags
      commit: 85c4c34dc92a8b545d376d00ec66990457556e9b
[5/5] binmain: include ti-fs-enc.bin into missing-blob-help
      commit: c1c8d2db436c9d9e8303b9e9cc108e719c6690c4
-- 
Tom


