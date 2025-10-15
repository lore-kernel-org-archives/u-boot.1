Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF519CCD185
	for <u-boot@archiver.kernel.org>; Wed, 15 Oct 2025 22:57:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 026D0829E7;
	Thu, 16 Oct 2025 00:57:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KTztUDsU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 353D683655; Thu, 16 Oct 2025 00:57:33 +0200 (CEST)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E38DC829E7
 for <u-boot@lists.denx.de>; Thu, 16 Oct 2025 00:57:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7827025e548so45502a34.2
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 15:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760569049; x=1761173849; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mDNExjvjk+xrlJUR7eS7UHRMGNbsJegiKsoADOf2cLs=;
 b=KTztUDsUj8z0M2F/T0V9of0ERSCnfSxRglbzwgq3+OZ+5Udoex0Et/0gEAMdtZYQ7t
 46ufNmHwGJi++xu+oyj0SCw+syhJKGZRAqX5e4x1pNVb1JsTnGJfpJiWS90eRLU05mhq
 6ojaGWXovFgo5G5QS8idm6MdWX1tswXkVtx5Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760569049; x=1761173849;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mDNExjvjk+xrlJUR7eS7UHRMGNbsJegiKsoADOf2cLs=;
 b=sPtZtnxRMnn5zIBbjKhKLyMEg4GSq2Q1zpHMS/FbNN0A0uZQhawY/yZF5Cl+5pwpHw
 GUZnj0XDhZ6J39l0xZQEBclAMnZPd71YMlUD5WlII2htycg5STfm0jP3FmkTATeCqR4G
 Dx26ZqjnuyzcXn0mJ6IRToJgm2MObpsE2OcBys8Zvn0J9GIt5SRNzlR94TCUh7Rp6d2t
 vZMyH9WkGWXYofd+oPAT+9RD/1eJrYkivUBHGqMT1jgX2cTKVs+c5ygW7L8X4Bh+f3Vj
 DLiRYxU7HLl6F3O/w89pYdcSAe6mhNYCbwdBnx6d7/q9/nfVwDTSyhkSE9mIc+YDfPFS
 ff2A==
X-Gm-Message-State: AOJu0Yx0OM7YGPBD9DCxPbMw54JSkXhbHnBlnRXsNoevDxRgheZZkYM6
 wUQ0l+g+QvSr4LgJd4oWvTgTA18gFaNZib7vdiA+KZqTH5i74Mv9A7b7kxj1ObrkxGTfIMhBPVl
 GxjtwymM=
X-Gm-Gg: ASbGnct53ZDyEvS9+kC9v3uK7FoVHUKgpO4aHN0nwfcmPrjYBH6CSnTIYbe0vOMSZSS
 Zq7d2jKkH6M9KmuF5u8lqWuy+Mf3xXcqaEtRzeCVMQwST+IDDatrvfYJ9ABDg3gWEs3BLEVQjSH
 Dsf8rDknr16EKztFuQP/ZaYj5v8wnMgecgun+85rEyDzjKs9d9Z4N6q4jha2Xk5DPkTRbj2x4TY
 4CQtqLAxpHBakXrI/qoTq2srKMfJCxe/Ew/ivDblyc6s8PD67bj3ExB5yeyQV10TkwnjwZ37N+a
 gbjsg8bxSd/Db6mbfnNM0kfaBDz5LjGJ5CwpL9sDo3540KnabymEs106Mu2WBEoKYcMBAHZ3yKm
 1I8L/rw7r2JwDquFoAHKiQ5BNko9ZkMpQ+xLVy8VO++jXII7IHZGoCNQbpXrIX/4mIzmOX2rW4+
 0I+S1CVS75h1JTFaoiFXiJ8I5xTOcF8xRRI8M6VshWeBoFvt5p
X-Google-Smtp-Source: AGHT+IEEOXLYXNkswqP1L18gS0Z56QX6+tvAACyI/p7WcvpqXNLvSXL5h3lb9WbF1F8wKlHcVLv6DQ==
X-Received: by 2002:a05:6830:3901:b0:744:f08d:15fd with SMTP id
 46e09a7af769-7c0df829a2dmr15333838a34.35.1760569049568; 
 Wed, 15 Oct 2025 15:57:29 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c0f911af78sm5774854a34.29.2025.10.15.15.57.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Oct 2025 15:57:29 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Kory Maincent <kory.maincent@bootlin.com>
Cc: thomas.petazzoni@bootlin.com, Simon Glass <sjg@chromium.org>
In-Reply-To: <20251006164506.380308-1-kory.maincent@bootlin.com>
References: <20251006164506.380308-1-kory.maincent@bootlin.com>
Subject: Re: [PATCH] test: Do not build expo and cedit test if no SDL
Message-Id: <176056904870.760819.4660726599367703993.b4-ty@konsulko.com>
Date: Wed, 15 Oct 2025 16:57:28 -0600
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

On Mon, 06 Oct 2025 18:45:04 +0200, Kory Maincent wrote:

> expo and cedit tests depend on the host having the SDL library.
> Build these tests only if VIDEO_SANDBOX_SDL config is enabled.
> 
> 

Applied to u-boot/master, thanks!

[1/1] test: Do not build expo and cedit test if no SDL
      commit: 00ed9753c803402935c6d67e839637c5c144e70b
-- 
Tom


