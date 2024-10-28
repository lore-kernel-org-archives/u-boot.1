Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1DF3D13590
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 02:53:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4946D88C53;
	Mon, 28 Oct 2024 03:53:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="o4iAZIlE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 823E588C53; Mon, 28 Oct 2024 03:53:17 +0100 (CET)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 665F588FA8
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 03:53:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-6d18dff41cdso5824076d6.0
 for <u-boot@lists.denx.de>; Sun, 27 Oct 2024 19:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730083988; x=1730688788; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rbfukb55NuNz9OHdpW+IKsUazcGuhU68kqOQDnXCF/g=;
 b=o4iAZIlErNtWs3mmf9KbadmNe/U6ttbhKunkFiy2m43KKqonhIhK3PeRCP76fw6XKl
 4edJ+G/5zlPUrX20w3wOxeliaeCu8a2letYmNhdCHOy6Ff89I7JJD9fj2KEtoA2U2FAG
 3Dmiml6xDgZ8fFfD/NnsYTCFepx8QX6dLuZaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730083988; x=1730688788;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rbfukb55NuNz9OHdpW+IKsUazcGuhU68kqOQDnXCF/g=;
 b=fMFtLc1YdaiMlyJstR9GkVCn5ceoUGwNH+KSBvpCt6SxrIZf0asfPMPqPhXPbES4Ix
 hJoOQtbsdsxmZ00DGXcDfCbjQruDTFQEJTpAIPAaUv5mNshBSHcXo4pRwkU7Zr4KOXX0
 J7aMDBcPoA9QJQKQ0PzGgTtyqyphc4r42agwZ2+T8+SKxwYaDCk9rHjtaFJzmPmU1xBX
 XUvR9lF4cJJzBavtKzAatAXfI8hGQeInx+1gWj+/Kh2UmBOLcjwhDqppta8KVkAeoBNc
 B/CTosHCGZMnJg2PBIe/3Zno3S4FRYD0BhJeawaAKikZkWAykP9FUdQauW9sHByUMb4J
 gbDQ==
X-Gm-Message-State: AOJu0YwAGSsVCyLYDoRKyTXAj7CTFh+ihSSbGez1C7f8Bz8aNMeo0LKY
 YRBXhG5mgJ0rfDWQ0ap9xaQr+ZW0CyEOuLqaGMLtWWjDYjbxuiAaqZItWsxkgqfN5rQRbshJTNv
 tTao=
X-Google-Smtp-Source: AGHT+IFdrJAiLx8wYm9sbJt8LYyyN5auEUYCinfyn0ttA1FxpTlUr0UngRNQBWAJxYM+0zKdt/07yw==
X-Received: by 2002:a05:6214:3d8d:b0:6cb:c9d0:df32 with SMTP id
 6a1803df08f44-6d1856743demr109749466d6.11.1730083988382; 
 Sun, 27 Oct 2024 19:53:08 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.104.2]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d1799fd4fcsm28497146d6.92.2024.10.27.19.53.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Oct 2024 19:53:07 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Peter Robinson <pbrobinson@gmail.com>, Simon Glass <sjg@chromium.org>
In-Reply-To: <20241025164732.73121-1-andrew.goodbody@linaro.org>
References: <20241025164732.73121-1-andrew.goodbody@linaro.org>
Subject: Re: [PATCH] test: efi_loader: Fix dependency for http test
Message-Id: <173008398630.2202883.15049834400370528726.b4-ty@konsulko.com>
Date: Sun, 27 Oct 2024 20:53:06 -0600
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

On Fri, 25 Oct 2024 17:47:32 +0100, Andrew Goodbody wrote:

> The config setting CMD_BOOTEFI_HELLO_COMPILE was removed in favour
> of BOOTEFI_HELLO_COMPILE but the dependency for
> test_efi_helloworld_net_http was not updated and so is now incorrect
> preventing the test from ever running. Fix it.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


