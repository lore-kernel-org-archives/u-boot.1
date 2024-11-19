Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAA17D4415E
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 13:53:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6BCF0895B9;
	Tue, 19 Nov 2024 14:53:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="o+WJ4W3M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21A92895B7; Tue, 19 Nov 2024 14:53:04 +0100 (CET)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7E498959E
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 14:53:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3e604425aa0so531585b6e.0
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 05:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1732024380; x=1732629180; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hjFCcWghCF4h9JIa5KHUu+WcaB5PNJKu+mtugfF0dlE=;
 b=o+WJ4W3MEHrmxsn7Tvk59WMUC4X8cf0rtl/5C1GTp30JefEGGu3Jo4tFTDEq9TFqCY
 bLnzeo564v5NOjnVlPw58VaHZpk1p1R0d3NSd5suXU9s2nh36qO0TnuVqVaBSDguJP9M
 XNTNb2zmPCNUpWAy5KMio58PB5rtOnlyxFqZ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732024380; x=1732629180;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hjFCcWghCF4h9JIa5KHUu+WcaB5PNJKu+mtugfF0dlE=;
 b=jmUzuf9o/odWtyWpBEaYbER0ocmDC5pmKIiGlVG58yTHfTj6/cQ9+med8bdGW3qQOb
 cAtxyLbJc0sY53oiJwtIBiVmp7egyTSF7UVu4yWWqrTvyzrb0eZXHykYPdb4tDoQYYeY
 em+1gtO5Hmd8KViNfqvUk2WOA8uBmncBGUdXtUGXpjGn17ZrO2sXxMmAMTDzO1UNv7Vd
 OAi6g0N22ySV+APH1eUb4o2UgHtlibpRP3wndSXJpnaOiydXb+PRRMfEsyHofcE+EqDD
 uwKzhRuwqkrbdhfhlTEuWPWvVB3bJTk9l4sigL9+yk2hoxkitEkuwi+6M4CgOomt+gPs
 zsbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwuAc+YWiX3LaTLYil/rXXbODwIMnRFmy/FMiuiI7cSl0kfu4iBW6L8mmFidnzwzVuQFEpqt8=@lists.denx.de
X-Gm-Message-State: AOJu0Yx8UAnD0BSfKIQsTciqyBqQ+5dXjIW0sVOL2D/xOAeu4RK7wwNK
 lvuTwpwddRuwEVjX7ku1I8NLhFQcSrcsfP4qRyfdPpNFnspV/mJFHsxn7fSN9S4=
X-Google-Smtp-Source: AGHT+IF1JLYEYN7nyf6j59BjqUxjCj3KXaFZ2T2lApBrhtk4yKvR5pAm3r2QQYB7xcLhIuCEnIcW7g==
X-Received: by 2002:a05:6808:bd2:b0:3e2:92ca:92d3 with SMTP id
 5614622812f47-3e7bc85dcdfmr15809180b6e.34.1732024380444; 
 Tue, 19 Nov 2024 05:53:00 -0800 (PST)
Received: from [127.0.1.1] ([187.144.30.219]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d40dd23291sm48507786d6.81.2024.11.19.05.52.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 05:52:59 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Adriano Cordova <adrianox@gmail.com>, u-boot@lists.denx.de
In-Reply-To: <20241108174526.16390-1-heinrich.schuchardt@canonical.com>
References: <20241108174526.16390-1-heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH 1/1] net: lwip/wget: correct SERVER_NAME_SIZE
Message-Id: <173202437908.3483935.6756474809298488240.b4-ty@konsulko.com>
Date: Tue, 19 Nov 2024 07:52:59 -0600
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

On Fri, 08 Nov 2024 18:45:26 +0100, Heinrich Schuchardt wrote:

> The maximum length of a domain name is 253 as defined in RFC 1035.
> So SERVER_NAME_SIZE should be 254 including NUL.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


