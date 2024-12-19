Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB401E7718A
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 17:51:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A26418033E;
	Thu, 19 Dec 2024 18:51:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rJYDpSYD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D6458021A; Thu, 19 Dec 2024 18:51:12 +0100 (CET)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B7FE8021D
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 18:51:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-7b6e24aa0dbso79893885a.1
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 09:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734630669; x=1735235469; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hyOTSvNr1mdE90q0bvjhJMffiT3nYZxMGy4jqZGuNVk=;
 b=rJYDpSYDVKb2GKGxnlDNXYFPnuX9bhN3gAoWZ5WmOXb4CZpOKQJ55zKs0WbV3M5Hd3
 lPvBKoL26qzxRL0l8UX9LUBq/wqBra0iAubxAy06+BmOWf0c7Sxyt1fXOcD8PPXGD0hQ
 zfQCh+V/AU1vs6178KhqU+5wJx75Xw96q8hzk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734630669; x=1735235469;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hyOTSvNr1mdE90q0bvjhJMffiT3nYZxMGy4jqZGuNVk=;
 b=ahALG/cAXHGGW7p6NZgG61pg5QCWuG6tNyFQj2wd+8nxwjHCMJAIw2P3HcHsmXl3Os
 rwM8jKPBNdmLXqtCW9vylR3dRxz1nlTFNXfxZYU9dsdIneStxXMye58lOmHHpVDBXFJy
 iSpWNCJEdQSgOtX/gcBraQ2WLmheGA9BsAxK7S1gL0fhZ8izCKcIc0zfyrEGisFYBL41
 M9ozYGM7tHPfy5k9vvfRQYw6PNQcauqtRo+xEROwvuVP7zm4MCUtXtGbu39hG8AoDiSX
 kdDJYeCq3zgm4opVneYQLerdRfj59+mJmWHTUwQo+7gg0UjQ/k3fNZpV6GK9lTCY13Kz
 cEVg==
X-Gm-Message-State: AOJu0YwxLqfbm3WhIA6VAyWaKK4XpDtsWDGhjsjMemmSoOFVeRHFYOGL
 TN7MOncQHr27goczN1dy+RkY0LsNy3y+AyYFAZAzwcxO9mMghzi7ztOq0G2Wn47awGk52Hz+XsY
 Z
X-Gm-Gg: ASbGncsfKE2W/JCpe2jATS4ivtKDFdrUaknfvH8OnHy93ejyALIJAXgnqzNqqjEzqHS
 eE/N2xy6/x5Ggt5wvPp6KBl7o2iBlEJJIL/PQo0J+MdUM3JE6eItUa9Q0uRGBfPdx53+yaetW8u
 YWO8fHsblUHnEb1menmH9oa/58Ug4gkTs7TuLJuxSLhaSMHbWJYov4pbcaoGTzV+GI2oUkUKYo+
 w0Bg/yf0cRK5NnFWlI0lHm84Y0sFVAXbF/VhlDgCzePeemUbf/C068=
X-Google-Smtp-Source: AGHT+IG4bHpB6/F+KOe18dipak7jhrdAmNegbYyXHMXyNUjr4qEE88Ging/i1IWs2ZXWizHiGODo3Q==
X-Received: by 2002:a05:620a:40c8:b0:7b6:6b07:e80d with SMTP id
 af79cd13be357-7b8638b80c2mr1162523285a.57.1734630667594; 
 Thu, 19 Dec 2024 09:51:07 -0800 (PST)
Received: from [127.0.1.1] ([187.144.29.192]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b9ac478e33sm67004685a.76.2024.12.19.09.51.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 09:51:06 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Paul HENRYS <paul.henrys_ext@softathome.com>
Cc: paul.henrysd+nodisclaimer@gmail.com, sjg@chromium.org, al.kochet@gmail.com
In-Reply-To: <20241125174717.1181452-1-paul.henrys_ext@softathome.com>
References: <20241125174717.1181452-1-paul.henrys_ext@softathome.com>
Subject: Re: [PATCH v4 1/3] aes: Allow to store randomly generated IV in
 the FIT
Message-Id: <173463066589.3644953.11764091478598865796.b4-ty@konsulko.com>
Date: Thu, 19 Dec 2024 11:51:05 -0600
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

On Mon, 25 Nov 2024 18:47:15 +0100, Paul HENRYS wrote:

> When the initialisation vector is randomly generated, its value shall be
> stored in the FIT together with the encrypted data. The changes allow to
> store the IV in the FIT also in the case where the key is not stored in
> the DTB but retrieved somewhere else at runtime.
> 
> 

Applied to u-boot/next, thanks!

-- 
Tom


