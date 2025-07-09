Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E3CBC83F09
	for <u-boot@archiver.kernel.org>; Wed,  9 Jul 2025 14:22:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB04A83526;
	Wed,  9 Jul 2025 16:22:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="eacWocPB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F236383510; Wed,  9 Jul 2025 16:22:03 +0200 (CEST)
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D35B583496
 for <u-boot@lists.denx.de>; Wed,  9 Jul 2025 16:22:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-60efc773b5fso3731091eaf.3
 for <u-boot@lists.denx.de>; Wed, 09 Jul 2025 07:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752070919; x=1752675719; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9iXBX8RlkBEbxllIka1mqxliY/Ghrxdz2VEwpIv1z2Y=;
 b=eacWocPBmYfksNAzNHR5NwHcnxD1HW4BIPfn2DFrmZA4Byi2hzZYUXWadMw9vrcFMv
 b31LmoTdZ+SpWM1njCFe7EjM3acOslwGvHmkaqBuJyqqzjlMnrnQ1VdKks6GZjNIWdfB
 25+xktEc787CbJX6r6Borq7KbJTYit61vOXE4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752070919; x=1752675719;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9iXBX8RlkBEbxllIka1mqxliY/Ghrxdz2VEwpIv1z2Y=;
 b=PGI6gMba26TFWiodbAQwWaM9iHT6seKFKRj5SdKzUOFw+Z65KwuUTchdf6Eu+mb94y
 eVhUZVIQ+2cOPtbI5umFSlUqrntPzpy0iC3Om5282p7PdlcHTP4jiQ0vdoNzvOosm4Wy
 qnFjPRLqpDA0IMIk382paCxlOiW0xiPAMFnCzM1Kk+di4Z4Gzq7ApHwAzS4CrFs3dYzT
 m4q5//Px/tIaIB9wdRDDEtEE/jA1h0l8xFUaJhSUjnAIUdu/VfBd/arinCg+6VT0oH+w
 emH3HEwoMaFRxnOKTwx2q3qzvg18Pb+1SrxJfSdrU5n7xutTUqU4fNPY2wYGFBf2SpHD
 9P3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUr5MMIDbOtH/QR4oTyySe7gJil/ZSYhkJEG6rAmd0nnuYjTShmxtlLtpxBNzBQ6H31+4nau2Y=@lists.denx.de
X-Gm-Message-State: AOJu0YziWyFVQKSygphsvd2ZWoMugD1IrEGQKlIMofJAVP7N++XaNgI+
 6Gtv2Gebj89kL+2VnjBTTwpVOBFKZn2Q3HfxAj4LWLiDMzo7UbQyjfDe720xGeal0uA=
X-Gm-Gg: ASbGncvk2ZMV7JyFYokUTe15Xncz+ioMHFW5aZyw4lkUAXpcSz8tOMhrwINz7xaVzGD
 kS+81fMt2mEr+GZSJ+wbwhiZdL+7Ul8yzRiuE5o2jKfiGnU8qPHEhQmWSFKj6H19wXgoKgBGjfz
 /bNfT5eLdcgVFDJWrqB3HKpu0BATyfPD1YYwqx0CWLv0c4DE3ldq4sxKTYUpx2e07qiRUxt5aGj
 ptoLxaPNXaoyhMp+nglfdYmyfULho8b0EjfObRSnPl69hqMcS+FL7r7qnCdO+MUB7Qd5vPu9cMi
 q5T6gCUf7quGe/KEMX0CKb44bapo0kR3J8aBSClZeRppl6CY1RTWHAb9mWOMxHTRxhlCwkx0OK5
 +yriZ5qiqyln3c1LA9XM=
X-Google-Smtp-Source: AGHT+IGOi0j3IgyNghmdJrwEN2lFXctwJmAfisfKavltgBWtV7+S8ZTwK3oGPneUY7qnmkJVcA1E2w==
X-Received: by 2002:a05:6820:4c85:b0:613:84b1:c4c1 with SMTP id
 006d021491bc7-613cce2fc08mr1555509eaf.5.1752070919509; 
 Wed, 09 Jul 2025 07:21:59 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6138e5ac83esm1919975eaf.27.2025.07.09.07.21.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Jul 2025 07:21:59 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Manorit Chawdhry <m-chawdhry@ti.com>
Cc: Udit Kumar <u-kumar1@ti.com>, Andrew Davis <afd@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Kamlesh Gurudasani <kamlesh@ti.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Aniket Limaye <a-limaye@ti.com>, 
 Bryan Brattlof <bb@ti.com>, u-boot@lists.denx.de
In-Reply-To: <20250626-b4-upstream-fix-icssg-fit-v1-1-95eff1c853a4@ti.com>
References: <20250626-b4-upstream-fix-icssg-fit-v1-1-95eff1c853a4@ti.com>
Subject: Re: [PATCH] Makefile: Fix of_list_dirs with EXT_DTB
Message-Id: <175207091860.1813324.4675148806522212325.b4-ty@konsulko.com>
Date: Wed, 09 Jul 2025 08:21:58 -0600
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

On Thu, 26 Jun 2025 16:13:32 +0530, Manorit Chawdhry wrote:

> EXT_DTB overrides the of_list_dirs that is passed to binman during
> builds. This causes binman to not find the normal DTB paths and instead
> it just is able to use the path for EXT_DTB only.
> 
> Add the default of_list_dirs that is used for normal binman builds to
> EXT_DTB usecase as well.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] Makefile: Fix of_list_dirs with EXT_DTB
      commit: 29be3d7d055e7db475d0bbea27b4b3bbfa9e0aa5
-- 
Tom


