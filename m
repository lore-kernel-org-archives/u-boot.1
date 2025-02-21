Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE775C021B3
	for <u-boot@archiver.kernel.org>; Fri, 21 Feb 2025 17:38:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D8A580FD4;
	Fri, 21 Feb 2025 18:38:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QxZqLZt5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6BFD880FBC; Fri, 21 Feb 2025 18:38:18 +0100 (CET)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3869580F88
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 18:38:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-220ecbdb4c2so66231385ad.3
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 09:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1740159495; x=1740764295; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BzL7eVHkreKjYq+yldgkvW43JJuzVGTna37ap3buADY=;
 b=QxZqLZt5go9JaooOVYP09NwrUQ0p8qteKJox5149JY/qBuzTiQzycU6PkZ5S7Q+Ljr
 9CdVguZ4xj3TpD/YRrRmNh/E9/eppVIJZbPQK1vT6x/Znm8Qf9CjAzzaIrv0/4xPH955
 ydeIKvS72x3pPLpNbXhQrne24twlwnrwqd21E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740159495; x=1740764295;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BzL7eVHkreKjYq+yldgkvW43JJuzVGTna37ap3buADY=;
 b=c+C0oEv1KoNv6ddSzcsWZdKIjanPaw91/klfYvZlmV6QtSHWpPNjwRRIjFiM0evd1K
 0TNxXnc4AdHKineA3VYmPACeLU+KMCKGcWsmLKKjwB/dlSnwBZcXHJOM1y/o3S/Lx9Es
 gRH+NIP3luYaFQ2ehTRaTzy81Fgj93QxF1F3fp/83a6KU4BUXRBF9JFfRmZ3i9kqx8sO
 8L9beOL+9m15QdM6WliTwPLrAvM1sDiABI9EyIl9FdqS87Fdj7qNimc8G0z0JRQr0Qhp
 MW9MSHFJRkco0cKFKNaznD2H/0UXBijMjIq/M9caG4+a54tlqQZIgO+82xyTBYQzZE9b
 ZSgQ==
X-Gm-Message-State: AOJu0YwKUDluhgUdNh7tPXifPjKup9ljxitQI4rteWPoLJEKM9AiGAit
 VpttlzQyqIf+mtCuloJTqo9D+rhSlPJIl1XVmnPrBZWt8dkQYUJVznC2HxEaph4Fa2hC+V6TijA
 S4OM=
X-Gm-Gg: ASbGncuPKY49uDzpDwrFJBf8459YsEt5KMSnoRDBVqqyBw0bHhK4cocP7K4LQ/zYaw+
 L7kERAfG/z2ECPuIt2XkljJ5NL49cHEJtr6aTlyvh6WDZBapjBY2SD6giV4+UIOY9byto3GjcB6
 mZIFlkmdfLBuQuOIb29ISfezP3+2lwv1HjXIn3BXcCtapXZm8XWUUjacvtg5HoOyl6b2C8clNjW
 P7Wf1X6v5uMFGVdx5XroSRE7hBJT0E2ApUmGFMcRaEHtcn0Q/kYDCxi0OoMBX6nLi/fRa3Cu99a
 AVsVAVcVloVsCRMAOdCvFdQ=
X-Google-Smtp-Source: AGHT+IH4+GE/krs3xYkS3F9jvQWrgl5V9X2Ebr7J68zJ1owLgh5CyJc0rGiU4cpDy4QADAnkhbIMlg==
X-Received: by 2002:a05:6a00:1a86:b0:730:74f8:25b9 with SMTP id
 d2e1a72fcca58-73426d81592mr5896166b3a.17.1740159493267; 
 Fri, 21 Feb 2025 09:38:13 -0800 (PST)
Received: from [127.0.1.1] ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-adec4756d0csm8792554a12.55.2025.02.21.09.38.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2025 09:38:12 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>
In-Reply-To: <20250212222339.684459-1-trini@konsulko.com>
References: <20250212222339.684459-1-trini@konsulko.com>
Subject: Re: [PATCH] binman: Switch to setuptools
Message-Id: <174015949242.3526942.7241118160059406187.b4-ty@konsulko.com>
Date: Fri, 21 Feb 2025 11:38:12 -0600
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

On Wed, 12 Feb 2025 16:23:39 -0600, Tom Rini wrote:

> With the distutils module having been removed with Python 3.12, switch
> to using setuptools instead.
> 
> 

Applied to u-boot/next, thanks!

-- 
Tom


