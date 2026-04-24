Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAE8CFF885C
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 19:05:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0954584255;
	Sat, 25 Apr 2026 21:05:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XwoSfZ5d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7EEE284258; Sat, 25 Apr 2026 21:05:11 +0200 (CEST)
Received: from mail-dl1-x1236.google.com (mail-dl1-x1236.google.com
 [IPv6:2607:f8b0:4864:20::1236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5471C84150
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 21:05:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-dl1-x1236.google.com with SMTP id
 a92af1059eb24-12dbd0f7ecaso1810524c88.0
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 12:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1777143908; x=1777748708; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JDNEcQ2CsunxQkiRVCPSv8/sRE1j3qi898LU5RnVZyo=;
 b=XwoSfZ5dQIv2Gue0+UAhAREkNBTkw3vs+cWi+R3oDbZ3AgEOLWaCgemGJto8H+CQxn
 1vCASPBSATZmjrKOJ+ACLGBNbzojI+4rYxjZoHVlPr1Vy3sxmB4PuAOKHcA/5o5gQNzF
 WTQQmk4tQswQkzRudX1t1GeyJ4YGF07PByhK0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777143908; x=1777748708;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JDNEcQ2CsunxQkiRVCPSv8/sRE1j3qi898LU5RnVZyo=;
 b=fA9iGcuMbnOzKfn15pt4eDAFRZbg2s3x6ghsmdvP9/WlsYk/0vuTqMCHITe23Ctj2o
 JMNMYTZVLT3+thc0KO6qXlt/awkyyPJQvouneZmVwnycpYkYOGg+SzWf4+Ac0NdVJVfP
 rxVkenSqy+CWQ2aXy/N27EXq5rFtAHIDEeNXQwKGl8p7/CVCdN512ox0wu/72v/M27MD
 qnDr/niZu4s6QDCbuuQikvACT+nW3ocZeR2ui4EPexy3832wCgHCXSQolKHlJ8VMXgcG
 uj8B7WPaXnMSp5t4rtPXraiJ2qeF0NWLH9PW+dQDDpcYj2kvs9RreKknNV9Pig7vw/9N
 4unw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8QdHj8bnlcbE7oxTDBnwJ+2U/KhnNDi4nLc0ZFlQEmCOpVsX2hy9XnhStm0Vk6MqSazD0ykK0=@lists.denx.de
X-Gm-Message-State: AOJu0YzXsclOQyPK22MTCzmt9T+ayz4GM32t7lrrb5RyZFR5dYsu9LXK
 R3Oq/v+JOfcmgnByCnyyWfUbEGEvNiUVmpFOxrKdwSwsSqLV2zfaCGJ06pF3uRtYZ7+lPLv0Mhd
 xw8qyrUPw1A==
X-Gm-Gg: AeBDies4kFB4Hlr5SBJw6MFPCpknElyQIGPMvi+0I8bPJ9rpmZAW4XdxTPw5KTuhshE
 Z5NNnqb48tgICCm5JL0qihIr0g9jRqWc8YlL7aQfURRK/luZmMqG/urDkBzvUqRJ88AVFF7N84E
 oXm0J/0J92oyMRQaGvxFSFoATR6QY+otAFtCwVuDM+kPd0igAVLMHrA2ooJ7cTgkoRNXQMD6vBg
 H4UBxp+0o3OToPikHexzqtlNyCdXuFWUCRWw383kvVvaFw5DS2jKbE8lY3f/MCLWg8ejV0ufQqA
 MjQl6gT/v4IZ2xDW/niWXeDlqnig/rGYNC6aYITS/gwzWyro/f1VJg3FZvKOvdFCtiVIl1o81Iy
 pN5/xNnXoaucH1OwWAmKtnJDwDNG/qcKxU1ZLt76L1HwJxinQ69zOdLALmqYZ6NnJ033H8uwq0O
 /Ip5aQQY6XDlp4Lys+rA+mxZ7r4jTsor2sHMJEUmPQLGMS6KXBvpgVJhQcTa/g6HuRGYYUWNB5t
 O0gCWB4x8jtvx3kbQtiCcLpy4iMOOnouzbaVztJVpLCC2QEQBk5/2oaEM2H
X-Received: by 2002:a05:6830:43ac:b0:7dc:cd0b:58ba with SMTP id
 46e09a7af769-7dccd0b6c6dmr15210277a34.4.1777056651092; 
 Fri, 24 Apr 2026 11:50:51 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7dc975034e7sm19832464a34.6.2026.04.24.11.50.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2026 11:50:50 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Javier Tia <floss@jetm.me>, u-boot@lists.denx.de, 
 Javier Tia <floss@jetm.me>
In-Reply-To: <20260417173345.6559-1-heinrich.schuchardt@canonical.com>
References: <20260417173345.6559-1-heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH 1/1] Mailmap entry for Javier Tia
Message-Id: <177705665038.2527258.855539774076095779.b4-ty@konsulko.com>
Date: Fri, 24 Apr 2026 12:50:50 -0600
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

On Fri, 17 Apr 2026 19:33:45 +0200, Heinrich Schuchardt wrote:

> Javier has left Linaro. Forward to his new email address.
> 
> 

Applied to u-boot/master, thanks!

[1/1] Mailmap entry for Javier Tia
      commit: 0d2e561ce40b58ea3cb19044375a8043b5330f6f
-- 
Tom


