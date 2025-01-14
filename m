Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFA7BC02183
	for <u-boot@archiver.kernel.org>; Tue, 14 Jan 2025 21:29:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD91B80713;
	Tue, 14 Jan 2025 22:29:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Lkva2OvC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46CC7806FE; Tue, 14 Jan 2025 22:29:15 +0100 (CET)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 259F780657
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 22:29:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-7b6ed9ed5b9so880280985a.2
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 13:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1736890152; x=1737494952; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wZW5bx9wIOY9OyidNFCMHulpsqikqaMfh9llvx1bXI8=;
 b=Lkva2OvC6AJHOStYVh1KtM2nQ3W713RbXQxknPyIcWjgk7iw9gzXRSAQfrrTqZEOeo
 SWN94Bni2tJ6QdAydngBUK4xyF4Dc0zeIi9wwiLAceMTpaZm2/2VZSIelJyDOcWMDMuS
 +ZpEfYYbwkuN2mVfv3vzqN0a2e1tDTKe+8VJA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736890152; x=1737494952;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wZW5bx9wIOY9OyidNFCMHulpsqikqaMfh9llvx1bXI8=;
 b=LhO3SvFN1REYubGYVbnwe8QC/h32NhopkPYSiRizuADQix9FEXHwK7rFd0dYbv7dex
 sNE4d46C5BuaU9GQatyUJLo0cqEcP58+miC3duvIcyP1MLwfJpmLE0ZMqnbzIu6Iymj4
 HvD/9L3NrX4gaV3Mnx6FzZEYbGMivCyojDKjX0fFQCGeDq8DEr4cm4pPYi3CFdt8WwqW
 UNKxMsRaSwbUTc0uGZySWJhy4b9aBQTCfE2Zj2YVN9ADcFwcNg1jUnNVp3RkACx9R7EG
 ACbPKbXnhD13fvIkVrfkEA1tCyL8skQYix+JvMRcblfbgeku63WOv2XaKYlkBOeJU1Y9
 icyg==
X-Gm-Message-State: AOJu0Yw3i5hWm583mqL/AVfUn6onwNv+QsS+7ufs3zw4QVGvLw8Mx7P8
 Lncv25fxZfhyNZAx9eqOekwyRRIjUk9od3+zFAg3NF+/rd14Dg0byuyjTh/IFRvN1XJnIAXaj9a
 B
X-Gm-Gg: ASbGncsElppA5JFB+AwixOpdUZ/RocCUdDqTlJM7XRKXRPn6t2KdzecXgRGSYxXU2um
 4nqLRLncEq0pfQUvQI+H3LiVnZ6LHplGadIJkELBO8GBlUjNakQa1XeDqDJP+/BGukK8tmM+WnL
 f2WtsbmIn1nZK4Y/vVwWTyPxL5/ro8jFQE5RwakPs7Z1ylluLVotspND+34Q7heDx+GrybPrMcv
 hEuxbUOX4uOAoi9C7pIuU25AiQ//qoFI4pktOoBwLa0I21FRCJb
X-Google-Smtp-Source: AGHT+IGIfe9HLmAROJVrvzIfdxcTh6U/31QrjEsSlBxZyHyqK+5JxrmUaJ8R7pvI0gL/HsHg43QkUA==
X-Received: by 2002:a05:620a:46a0:b0:7b6:d079:748f with SMTP id
 af79cd13be357-7bcd97d2752mr4890817485a.54.1736890152092; 
 Tue, 14 Jan 2025 13:29:12 -0800 (PST)
Received: from [127.0.1.1] ([187.144.16.9]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7bce324826esm642891285a.41.2025.01.14.13.29.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2025 13:29:11 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>
In-Reply-To: <20241217162215.3210121-1-trini@konsulko.com>
References: <20241217162215.3210121-1-trini@konsulko.com>
Subject: Re: [PATCH] chromebook_coral: Move CONFIG_BLOBLIST_ADDR to CAR
Message-Id: <173689015065.93138.1723255461542184548.b4-ty@konsulko.com>
Date: Tue, 14 Jan 2025 15:29:10 -0600
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

On Tue, 17 Dec 2024 10:22:15 -0600, Tom Rini wrote:

> Reading doc/board/google/chromebook_coral.rst we can see that at some
> point it was intended to put the bloblist in CAR, rather than DRAM, at
> some point during development. This is fine for TPL/SPL stages where we
> have very minimal information stored in the bloblist and so we can set
> the limit there to 4KiB and then expand it to 196KiB in U-Boot proper so
> there's room for ACPI tables and so forth. We also update the
> documentation to use the same location for CONFIG_BLOBLIST_ADDR in both
> references.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


