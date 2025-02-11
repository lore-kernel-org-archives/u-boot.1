Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0968AC0219B
	for <u-boot@archiver.kernel.org>; Tue, 11 Feb 2025 14:18:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3381F80B9C;
	Tue, 11 Feb 2025 15:18:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="T9fXirpU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C89580AE5; Tue, 11 Feb 2025 15:18:03 +0100 (CET)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC6E880077
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 15:18:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-21f44e7eae4so93259725ad.2
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 06:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739283479; x=1739888279; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kSbrGbm7oQLWBRYIN1BkFYv/GqeFcx4isFSDqyUjZyA=;
 b=T9fXirpUJ99YFLFXb9lElGfKIQh7XLDTHxSkChORtzGox4JFxN9CPxnr3RXQcJNzNT
 xTPxYgCYwDzhviYb/9hWDqNZZuCKkCU0sXz0sSIiKvTnJ7XJGqp85VYDxs5BNJEHRbLl
 JVnzTDNtMyVNnQnhVbqcUubCkTKbB0+QsQLy0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739283479; x=1739888279;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kSbrGbm7oQLWBRYIN1BkFYv/GqeFcx4isFSDqyUjZyA=;
 b=lwzmClY8i5aSPHPytz9XEc+xe9PVRKG6KoEpPd7ZoSXkEPhPZZ+7j/C28kzZy9VpGr
 5gaONgFXtu79GvGex0Ow8LSvnOwTc+76Yf3SqL5ZEptLvQgjNKAVLW2QIAnxIPs/av29
 yWSWxsmYJfbwMsdMMOfwsxvIPOQE7eZ+C6/XOZ63FEoGwOPq6QnNM3nYgRMs4Vt8rXdA
 PBFWMnRWUsbPU4PBmtm01QETuMJzsChnQmb+zo1ZMKYe8tStPFfX8jNR1cLLBsYAVhC/
 LM6YZwU5tw0F/7gvv1xOoVS8CTkqF4s5t5HO9h2z4lZ1GwLtDKbyFchzdrLNkKD4P4Rb
 2/cQ==
X-Gm-Message-State: AOJu0Ywq3Ob1lByYkOaekfHmzhhsi8phdHZPd4JgFeDd50DFkF3q/lTK
 eB1SCUewvXdjO0+Kc5ywHuDlGhIkRL56UFOVGfjZJ3W/Lc56mrdlzHNYuJIil3c=
X-Gm-Gg: ASbGncu5DU97CuxzyWvG2rjco0C/3yDUBhj04BY1dedEZImYSwg6ijkHGw2K3UH3FB7
 Ge6/gvyuuPDxHiKm0B9n6rXhbkQTXHKYj8Glaz3rjtqrum8Noz8aOCM4ELWFalrEVI4XYy3J+nU
 arn3y2ZnN8/vYKKIjARVs3IKJbZhtcuZPdOK+QoDAeL3EazcmhqWvUOtIAjDal8iUAdChPLSfs9
 Us4Wx2iZ/eFzLZe2ojuRob/c10rKOaz5O/yJUI+Opm/y/x3F+mwLvD63CVBCDNHq3A91B51wMRk
 EFx96tQaNHDhlA==
X-Google-Smtp-Source: AGHT+IEYhbMld+aFUGbwgsHfkN0Kj1MVXPCqQeriVtcf1wN3r1BpKBCzjgHJiRYdbqW3dz8w3JR9lA==
X-Received: by 2002:a17:903:181:b0:216:3c2b:a5d0 with SMTP id
 d9443c01a7336-21f4e7b2053mr231823185ad.51.1739283479121; 
 Tue, 11 Feb 2025 06:17:59 -0800 (PST)
Received: from [127.0.1.1] ([189.177.145.20]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21f3653cac5sm96957545ad.76.2025.02.11.06.17.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 06:17:58 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, 1425075683@qq.com
Cc: Simon Glass <sjg@chromium.org>, 
 This contributor prefers not to receive mails <noreply@example.com>
In-Reply-To: <tencent_410F4F8FDC201D1B50F008D01066D0A4A006@qq.com>
References: <tencent_410F4F8FDC201D1B50F008D01066D0A4A006@qq.com>
Subject: Re: [PATCH v2] arm: Remove redundant loading of image copy start offse
Message-Id: <173928347812.3071479.11598508405228678365.b4-ty@konsulko.com>
Date: Tue, 11 Feb 2025 08:17:58 -0600
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

On Sun, 19 Jan 2025 09:04:58 +0800, 1425075683@qq.com wrote:

> Because the beginning is already computed
> 
> 

Applied to u-boot/next, thanks!

-- 
Tom


