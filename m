Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C3F1CF8555
	for <u-boot@archiver.kernel.org>; Thu,  3 Oct 2024 02:53:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C3A12890BB;
	Thu,  3 Oct 2024 04:52:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="q+Qml8zo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 957188912B; Thu,  3 Oct 2024 04:52:42 +0200 (CEST)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 27728890AD
 for <u-boot@lists.denx.de>; Thu,  3 Oct 2024 04:52:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-6cb2ad51162so4219636d6.3
 for <u-boot@lists.denx.de>; Wed, 02 Oct 2024 19:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1727923959; x=1728528759; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=EPy87y54G95W8xHR891OEMztFrHa3Bx7E6QiGfNLqFI=;
 b=q+Qml8zoE0n9CXqXg4I61YmIKa1SW2oC6jjhhUYN8VBDE3ZRNOPGXSh5H5uci4YBY7
 BhWajne1+ntA7nZAbTK11Pazr4How86wvfICSpteKFr55uERRLMjwV6bMH4aW8SioiP1
 tJjQFJd6NWQM862qvc8jfUu8NBV7+vHcLdcS0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727923959; x=1728528759;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EPy87y54G95W8xHR891OEMztFrHa3Bx7E6QiGfNLqFI=;
 b=oF+DlVStrVnWZvHTAH9FdKHb2BO9F/REHGulWFZL5kN7CCJJ7r9JyVvdhT4qebORk+
 kJkG9iwLvOPgqK1cMBk03J+aQ+PlLxb+NqEpX/g40++X4Mxxhrd0xXv9YVa6uta/gtWD
 Z6vnJWQDrvboDdJSx+cL9ApzlOzZ5yls6X4kjdc2gdPFx7OP3QCLCO4ilj+pYDMEKEGT
 ivSkhsfE8TLRCGmLOjTC5l0C8HIlS+kP45stt6AeogGVNQ8+jxY+drD3pwv1SIM+It2M
 plQGtFiBsTdV9weL2hcsuyA8VAk7Zf/aWOsmpR4bV/3g6VRIV5KGxvJG3dc7Lm2mukKm
 MWjQ==
X-Gm-Message-State: AOJu0Yw6vX03SM9FS+pgY5CpwfEM/4NoxnzA0EF3I25U9rRTDl6DbLhF
 e3iRjfbJ34OPOVx0IccG7el20mH/hkkytfaud+R9R9Fmn8t9oBSpaTov7SyvC6rAVqu44veDjca
 AxYE=
X-Google-Smtp-Source: AGHT+IGom6nU1omNZKtlFbZWuvszh2MmzWzZoxJUYF3NhGzHlezNnJ9DDxWbauCVsn8LVykhxd50Ww==
X-Received: by 2002:a05:6214:428f:b0:6cb:22ea:5e00 with SMTP id
 6a1803df08f44-6cb81a3ab01mr86790016d6.30.1727923959009; 
 Wed, 02 Oct 2024 19:52:39 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.65.244]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cb938211f0sm1606826d6.142.2024.10.02.19.52.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Oct 2024 19:52:38 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>, 
 Joakim Tjernlund <joakim.tjernlund@infinera.com>
In-Reply-To: <20240920161521.917955-1-joakim.tjernlund@infinera.com>
References: <CAFLszTj0HNbEy7VSaDA=Vd05+EWT1rxcDOBxu6e=BY1aQ54ZPg@mail.gmail.com>
 <20240920161521.917955-1-joakim.tjernlund@infinera.com>
Subject: Re: [PATCH] Add mkimage secp521r1 ECDSA curve support
Message-Id: <172792395764.1516896.6388761340807753857.b4-ty@konsulko.com>
Date: Wed, 02 Oct 2024 20:52:37 -0600
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

On Fri, 20 Sep 2024 18:14:35 +0200, Joakim Tjernlund wrote:

> Adds support for secp521r1 ECDSA in mkimage
> 
> 

Applied to u-boot/next, thanks!

-- 
Tom


