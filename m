Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D148C28B30
	for <u-boot@archiver.kernel.org>; Thu, 20 Mar 2025 17:40:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E28C806FC;
	Thu, 20 Mar 2025 18:40:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VM7yxFP/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2152B8070C; Thu, 20 Mar 2025 18:40:18 +0100 (CET)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6092803CC
 for <u-boot@lists.denx.de>; Thu, 20 Mar 2025 18:40:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2235189adaeso22173755ad.0
 for <u-boot@lists.denx.de>; Thu, 20 Mar 2025 10:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1742492414; x=1743097214; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a1GaULRd4zTKjNs/8F/4dUgiUP9iApIoy/93nO8euq0=;
 b=VM7yxFP/A72tMO3wqlUyZ98+uCjDxvDkbvSEliunVjNHs4kOUbDiMsWik0yU4Wks/4
 7RoNgppEX9kDL5JvtFv+s1OVBthQ1bXmXcZVYOskDsFV944B2NULbRMnvvYxwDtBmObD
 O7CL7PVyQitntTCbhje5IiYSXf7zMfQlc8vLI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742492414; x=1743097214;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a1GaULRd4zTKjNs/8F/4dUgiUP9iApIoy/93nO8euq0=;
 b=R4h+xxwzMHSMufc8J4Hhi2ZqFXPxl3cdI//SJaFDe2M9Zsh2JpNdA6qOkf5ROOJnpB
 +Hd9eHMRCDw7mvbztucBUXhAUNTX6nJpFVpPiUJ2qAxMdTLgJMFWSI99vg1McNGMqWTT
 fBk/Rsg4U85Rls4VCQnbZOeXuqYBNtINkcdfCJ2mkTijfaHKdcKaO7WS7AvlkDUPrD7A
 abZaybfapwF3EKtBZxsqHowm90Jgko+aK8Wg8nSKaRjRtXDffS5mZTDuZFxrZNXSMB8F
 hDIsjlvq+WxE5LgjIk0NPI/GV7uQoPz5fW2EQJzJMsApvvvqekqghMRZeYw8VgFeEde3
 LJfg==
X-Gm-Message-State: AOJu0YxcZeCW8cQcoMdFjvxZC6A6rkzuO7umJ8jgi1l9w2sMMrQjDdlf
 7vDapvrVub2PnkGk614MqpEEJSEalxoGcO3ye+GgyX+I5/AymrI6ySxlzTsKRk8=
X-Gm-Gg: ASbGncs+IyaeXKk4IBR4wOxzZTEhfiCKuq6zuBEdn9E6wWiEwgniRWVlFRqzjaEZA0L
 9kSq6l8tEcH13NbX4BJizhZHEtTMI3sqUHM1PBFGaaRq7M1dwJTC+7kZZeVZxtiJGLsTGRY851e
 Uw3EzY0ydR40FEtph7/YdRO2IEX9w4n+udcPkrlR1oQOUTN5swc4evLcLBtzfK1w4CZXUJUCxsG
 N9M4O/ebn539/gbe/pyv3Jkut5NDhmKa93JKI8OtGtWAuWRPGycrODuoT1NFcdBqEf984l+meMS
 5a11swrA11NCKlb142LQ7SSZQpuD2hTgd7ddW2JYMfFt
X-Google-Smtp-Source: AGHT+IHwj8ws3kX3l33uhaDEfUR2U8fML/hMF76IYOhnYag+5GV1HNEwdovOsvdIhOoJDqSwAUlfCQ==
X-Received: by 2002:a17:902:ea0c:b0:215:742e:5cff with SMTP id
 d9443c01a7336-22780ad6afamr5397735ad.16.1742492413893; 
 Thu, 20 Mar 2025 10:40:13 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.138.125])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-227811da369sm538665ad.170.2025.03.20.10.40.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Mar 2025 10:40:13 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
In-Reply-To: <20250319234923.264256-1-marek.vasut+renesas@mailbox.org>
References: <20250319234923.264256-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PULL] u-boot-sh/next
Message-Id: <174249241277.2082349.11847966495795233355.b4-ty@konsulko.com>
Date: Thu, 20 Mar 2025 11:40:12 -0600
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

On Thu, 20 Mar 2025 00:48:00 +0100, Marek Vasut wrote:

> Renesas RZ/G2L USB support, remaining RAVB ethernet fix and
> KSZ9031 LED errata fix for next.
> 
> The following changes since commit 8bc3542384e3a1219e5ffb62b79d16dddc1b1fb9:
> 
>   Merge patch series "pxe: Precursor series for supporting read_all() in extlinux / PXE" (2025-03-18 13:12:51 -0600)
> 
> are available in the Git repository at:
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom


