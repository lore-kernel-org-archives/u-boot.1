Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95380CA0EE4
	for <u-boot@archiver.kernel.org>; Thu, 14 Aug 2025 18:49:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 589F283A47;
	Thu, 14 Aug 2025 20:48:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="aFyzQl0b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E62B83A45; Thu, 14 Aug 2025 20:48:39 +0200 (CEST)
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com
 [IPv6:2607:f8b0:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3BBAF83A31
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 20:48:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-3e57002bc23so5819925ab.3
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 11:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1755197316; x=1755802116; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jwtLT5qbFFjwLrneCkThYwTGx5AaS9oMO0vwACsn7iM=;
 b=aFyzQl0b8KNWwAGxB7l38Pc5/0FuVc1mkniQ8Utrc2zVdcHURHN0BMGfPIA2eztL/j
 cOcHHHxB4PTYCD9WmgmBJiqdlBlc4RiiTmfcXnEPr0wluQo5XLXbqCfiM1m16X0wYn6l
 4qLGZf9xHA+ml1vBSvJy6jbuDVg1h4yZkZ060=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755197316; x=1755802116;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jwtLT5qbFFjwLrneCkThYwTGx5AaS9oMO0vwACsn7iM=;
 b=gDATL3i+G1UvheW4AaNQlLQTKpjobm8Go2SK20/Qx1qf88zMacXdPclsfUV0/XOqF8
 R9ecVvP5qIkS3cN8oZojsui6FVYx4bm7+0g+++b2fWUrThG2SDJhY+6lj1U/js85/m6+
 BlTdwKd1Lgctl38K4SACd8pbZ8mybxCBweqUH79/C66jFTEewbaAEwz9jgI50Xri5Yun
 uaCd8MxT1INHmEl0hmv/PUUP+9cZ4kJHD3QjNtKX+FursrBEzJNNg1rt+izZEOaM1YL9
 b7HIixrBLEwl8I+LTnUJxzDLhQIeVXuSmaabfhb+KBULFlQ3YSTcI4iIuKCl6T6qOOP+
 cM7g==
X-Gm-Message-State: AOJu0YyY0pk1j+zNbJgJ8asSym8HendN38PmU2uzHyTxEEmHAegOWfrK
 jbfNj4rsHL9OoHk+X/r910Kv31V7zn/RZ4Xn3v6JeJadybgMuh6VVRlOY+TsRoKZ6hI=
X-Gm-Gg: ASbGnctOliRZPXQ9fvJrlDr7OeTuX1wUA9Eu+3gYWLUNDw4DrIGi4NbbVS1ieyVzW6g
 kk4te37zPxAbyUy7iZ8vwJKmQJB7H7cD7bU+8Bg9fn02PrYtBi/FgE/eF2eLNr8pSzBheIUkR1B
 p5jMUxVZu/3nw+gBaiYup9JSxpYFOf4yI6uqYa0DgzpiyFuXlQ4e+vfEOmcu3DuCruPLHis4Esk
 Qg9qEavccpl5c99DpEzu1p+gMcvZaXyc0njTBuUn+HPSKi0IIV8y+c70zo08Kn5O3TDMU8oUgGx
 gmUcZm4YnNIntMpB5pt6tmBym9aXHxEC9D9OBYCDjPPBmFSRp21wXacXxWLMUcwHWX0pnbcCLo6
 WXIfUB9MVlg4gVqXZoDZUoGdAo9Nz2TGc5jYgyz835rL9yPsGVbHQYNQ=
X-Google-Smtp-Source: AGHT+IF7a5Rxt2KXH8pQvZ+I/Y2/Tt+vhme4ulROuFRW2ME4n+fK8ZeuxrIIeCX7o+8ACO+0FM396Q==
X-Received: by 2002:a05:6e02:b27:b0:3e5:469e:b105 with SMTP id
 e9e14a558f8ab-3e57089fad1mr79492095ab.18.1755197315902; 
 Thu, 14 Aug 2025 11:48:35 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-50b3d6ff137sm1219762173.41.2025.08.14.11.48.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 11:48:35 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20250804215425.1412704-2-trini@konsulko.com>
References: <20250804215425.1412704-1-trini@konsulko.com>
 <20250804215425.1412704-2-trini@konsulko.com>
Subject: Re: [PATCH] remoteproc: Tighten some remoteproc driver
 dependencies
Message-Id: <175519731527.3600102.9081155967714772649.b4-ty@konsulko.com>
Date: Thu, 14 Aug 2025 12:48:35 -0600
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

On Mon, 04 Aug 2025 15:54:24 -0600, Tom Rini wrote:

> The TI IPU remoteproc driver cannot build without access to some
> platform specific header files. Express that requirements in Kconfig as
> well.
> 
> 

Applied to u-boot/next, thanks!

[1/1] remoteproc: Tighten some remoteproc driver dependencies
      commit: 548ae9d1a537464254afac63f802179a24c645d6
-- 
Tom


