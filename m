Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFDECC5475B
	for <u-boot@archiver.kernel.org>; Thu, 29 Feb 2024 03:05:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D872787C5B;
	Thu, 29 Feb 2024 04:05:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="s9eBFvib";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82AF18806E; Thu, 29 Feb 2024 04:05:10 +0100 (CET)
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com
 [IPv6:2607:f8b0:4864:20::b2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6FEE187B41
 for <u-boot@lists.denx.de>; Thu, 29 Feb 2024 04:05:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-dc6dcd9124bso492061276.1
 for <u-boot@lists.denx.de>; Wed, 28 Feb 2024 19:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1709175907; x=1709780707; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ws+xEYa73DURK+0vKM7AmsaTKtUgBntMLTNiMlx3rI0=;
 b=s9eBFvibsmCxnN/Ew2tT44gra7C5xKQlxWFlLyHoPWkOyQafiDRMECVVDNUjOIVOs4
 H6hpQ/EQ+Xc2wc7WBgLE5iGmFjf9jDK1ih5s+rNFS6nBq6z6N7CRjjBOwK0Fl1AOkLb4
 /Kp9s1BykPjXpMO8JnoPkW1dIb0bmLrqZ4Wbk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709175907; x=1709780707;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ws+xEYa73DURK+0vKM7AmsaTKtUgBntMLTNiMlx3rI0=;
 b=qFwEt1XGj2QA/FpG9CwkC7YJPPQ+n39yvAfKVAddY8wS8H9TlEe+67CMQ5aVROVQYW
 TUd3lv78ueDd89S2PCIZ28lFxxUCt4do89cOuirFfhkIYRa/ZaHdPIi5JuHNe2fQl4Wk
 C1h8/WDzEjf7fy1gHs/b7TLWdHH3XLvOi48LMVfcULoUk4b03aqpTEz18n/GWKkz1cj6
 QQHou6mPU0lUyrlLDKUftpuf/TFabVHmCdcVwlefUB1J/IHzmRg8zqQWOWn8aOdWnmQK
 xsanmlHhtxwOhbOV/q4RZfQ5PwVMooaCQzv3cBi7gLnoCTa+syw0gi4571C9NRXepXCG
 CTcw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNysj/rZJNyzJceECH1oCyvOZUhPBK7qkyT+9eZhsG6BC/QKMKnjxnn6Rds5u/0y/BncJWYep/UZSsmsrmH3/dyHGSNQ==
X-Gm-Message-State: AOJu0YwDN/bbeAIa57Txeog3UOG+8Ca3jd12+LRyMcMmuuF62OFwNMNR
 juDAGlNy/IYQboc4ppzrGpSvechaqlRVioJmUlxY1f9LYbKOOpilKlaJpAV/jWU=
X-Google-Smtp-Source: AGHT+IHze3UPINBwq21Kn3hgeLyHqo+uzIn3FJdDcqJNJ8+8O9uYM0yURmltB2tZN7erIMSipZUHaQ==
X-Received: by 2002:a25:c5c7:0:b0:dcf:477e:c82e with SMTP id
 v190-20020a25c5c7000000b00dcf477ec82emr1068740ybe.50.1709175907142; 
 Wed, 28 Feb 2024 19:05:07 -0800 (PST)
Received: from [127.0.1.1] (065-184-194-195.res.spectrum.com. [65.184.194.195])
 by smtp.gmail.com with ESMTPSA id
 a9-20020a5b0909000000b00dc22f4bf808sm99664ybq.32.2024.02.28.19.05.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Feb 2024 19:05:06 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: nm@ti.com, Roger Quadros <rogerq@kernel.org>
Cc: vigneshr@ti.com, s-vadapalli@ti.com, srk@ti.com, r-gunasekaran@ti.com, 
 u-boot@lists.denx.de
In-Reply-To: <20240131133348.182987-1-rogerq@kernel.org>
References: <20240131133348.182987-1-rogerq@kernel.org>
Subject: Re: [PATCH 0/3] mux: Drop usage of "u-boot,mux-autoprobe"
Message-Id: <170917590614.3675981.13765235171591951762.b4-ty@konsulko.com>
Date: Wed, 28 Feb 2024 22:05:06 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4
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

On Wed, 31 Jan 2024 15:33:45 +0200, Roger Quadros wrote:

> MUX driver should autoprobe if the device tree has "idle-states"
> property. Drop using the custom "u-boot,mux-autoprobe" property
> in TI device trees.
> 
> cheers,
> -roger
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


