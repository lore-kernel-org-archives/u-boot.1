Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25C96C48260
	for <u-boot@archiver.kernel.org>; Thu, 25 Jan 2024 14:07:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 88925875FC;
	Thu, 25 Jan 2024 15:07:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JHbgADyU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 59D8E87866; Thu, 25 Jan 2024 15:07:27 +0100 (CET)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77F2787559
 for <u-boot@lists.denx.de>; Thu, 25 Jan 2024 15:07:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=malu.bertsch@gmail.com
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-55a8fd60af0so6302052a12.1
 for <u-boot@lists.denx.de>; Thu, 25 Jan 2024 06:07:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706191645; x=1706796445; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MfL9iV7HORAJ3cSGjooCve57K/z2peoN1aPOKL5EWos=;
 b=JHbgADyUb0KsfMMnfg53Evm8VtbJznH/kFEkeGyj101cDQCf6tvJmHr/+++wtf/aHv
 8mwkvaZm8uW5eY3LKs+fhBtR3xZHsau5spRRofSoF51LANYehYxmiEKo16YPfH5EF5xw
 81bO6BxFgTWZLAxkrEQ9RGjuqEt/NKUcbErCHU8rvNtBoFN9OSrsj78iH2e0gsrwJiBW
 LrRfFtj4pYImGe/9asdOPXsUA45AOLEdm17fXeuxUvddeL1OqIa6a8YiePyc1Y2umVPK
 iKzrqrJP4iwVKMOuP7ElHC+JDAfNdqk6v3oPhjdjFMKFvs022izKtx9B2+aEyA3DWXPE
 WCfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706191645; x=1706796445;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MfL9iV7HORAJ3cSGjooCve57K/z2peoN1aPOKL5EWos=;
 b=ZljnnixWZf5KEb1iWVgAC4HnIqkA4uJrfhXQzAQC4F4vPeP+ywMZab7P1wVKNEmXMa
 qi04RWGvG6YhStchNDpof9FT9Xv+kXte9spvTE+T2HgZPqF++O/GsyhXeFv6+pWyOlrq
 I+6cS16BELX1eiLZNWzGPN4to8I8PvxpgXQMRZsXSKuw0+jM/uzGQUFvcjBXtPhFX3PK
 TSWYyjRVCxS71gLmu5tJaBF9vzgofwe1MQANMQwVSF52hRFn/ZLDeeHmRbRV/ZFGD8xv
 9YsVOjMHGjWJFmMQQKvZ2pd2w0+x/VbzBTfwapWNgBHo4QRLgt1spoEagixFrH5k8gVE
 YfTg==
X-Gm-Message-State: AOJu0YxK+AZRUZdEUqMh+GiiRWOd10zCQntJMgHxx8CP/9jOXToB0psJ
 CFXB1sgy0/tqgCdWDfXZrwQC5rDONz4o9C10E1nBemWxegMFPt1/vC91FPNMSeo=
X-Google-Smtp-Source: AGHT+IE6CQEEKhpUarsaLd4NB+hp+x+jZUOVyk17ddZuYu3r5Cv6c4Ojd1YhoNTjV1MijWFe59G8XQ==
X-Received: by 2002:a05:6402:105a:b0:55a:6dc3:59e3 with SMTP id
 e26-20020a056402105a00b0055a6dc359e3mr333659edu.139.1706191644311; 
 Thu, 25 Jan 2024 06:07:24 -0800 (PST)
Received: from localhost.localdomain (pd9fafaa6.dip0.t-ipconnect.de.
 [217.250.250.166]) by smtp.gmail.com with ESMTPSA id
 ee15-20020a056402290f00b0055d18d6a586sm83136edb.13.2024.01.25.06.07.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jan 2024 06:07:23 -0800 (PST)
From: "=?UTF-8?q?kleines=20Filmr=C3=B6llchen?=" <malu.bertsch@gmail.com>
X-Google-Original-From: =?UTF-8?q?kleines=20Filmr=C3=B6llchen?=
 <filmroellchen@serenityos.org>
To: u-boot@lists.denx.de
Cc: =?UTF-8?q?kleines=20Filmr=C3=B6llchen?= <filmroellchen@serenityos.org>,
 Bin Meng <bmeng@tinylab.org>, Leo <ycliang@andestech.com>,
 Rick Chen <rick@andestech.com>, Samuel Holland <samuel@sholland.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 0/1] riscv: Support building with Clang
Date: Thu, 25 Jan 2024 15:06:58 +0100
Message-Id: <20240125140659.28229-1-filmroellchen@serenityos.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240120002049.GO12635@bill-the-cat>
References: <20240120002049.GO12635@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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


Hello everyone!

This is a minimal patchset for making U-Boot build with Clang on RISC-V,
something I stumbled upon while writing U-Boot build scripts for
SerenityOS's RISC-V port. The only change is a (for unclear reasons...)
differently-named flag for fixing the global pointer.

Notably, this patch does not make U-Boot actually functional under
Clang. Booting this on QEMU (`-M virt -kernel path/to/u-boot -serial
stdio`) hangs after the image is loaded. I do not have the motivation to
debug this, but it may be helpful for further work on getting a working
build out of Clang on this architecture.

Greetings,
kleines Filmröllchen

Changes in v2:
- Removed copyright attribution
- Use -ffixed-x3 unconditionally as it is also supported by GCC

kleines Filmröllchen (1):
  riscv: Support building with Clang

 arch/riscv/config.mk | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.39.2

