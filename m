Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CC21CA0EE4
	for <u-boot@archiver.kernel.org>; Thu, 14 Aug 2025 18:48:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11C3483A3A;
	Thu, 14 Aug 2025 20:48:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Ym/PKjMg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3247B839C7; Thu, 14 Aug 2025 20:48:35 +0200 (CEST)
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com
 [IPv6:2607:f8b0:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1DC90839CC
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 20:48:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-3e56fe95d83so7282555ab.0
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 11:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1755197312; x=1755802112; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=70qIzARJA1ohjTYuqc2zE3p4ZDYN5nJSjVfVP0X463g=;
 b=Ym/PKjMgLhMCG8sxqdna04cYtMUqjO+RKNzrh0bDicGoo3TTsu9ICgyvAylu3zAVjH
 ztwbMBEKhWLQnfWZU4rSvpDu7OzRvDKiKgG4tm/9b9IzKbszxBnq4K6thGRw6RHKQBEY
 NM1fdlFtkCosuBydFZBiGvMFvkVSzI5tautKs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755197312; x=1755802112;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=70qIzARJA1ohjTYuqc2zE3p4ZDYN5nJSjVfVP0X463g=;
 b=mIc/3knHsJu0jBdCf3T2F+zFHRYDAw4fc323lAJxTH0mR76wz0QCUcBTHJocVLI0U/
 LSN1YDWCf3LLL2UVSK99YW0RRcJgFkJDnMoR0TzgWLiWQcN0Yh/rtwtGVIMzp5HLVozQ
 CGxOMdizJKf3ufR+6S40MtFqWE4b4wuqCQKSc09QpsQ17J3LsMAckefUl21qHqnIdiXy
 S7+K/AUBImDF/3mTHND+VvqcR8fbbwBYS8KlNkeX/9SvkULbPCyUAY3daeQZjqIXY0Up
 WmT0W4rcBzqkHnZvqRyk1MaKjMaaNicM61icizUUhcobUnqNvAKAzd38jbOkEAZr6DaK
 2vrg==
X-Gm-Message-State: AOJu0Yzhb5Xf+RfcV0cG9DdjOegd8csQhI3l7pzkxwktdnMYh8VPgCiN
 xOjEG8wn8RAkWm1L9CZnrAQvWmcx64LGGt6faT87rMDokzEyg6BxHBZ72nBkuWPGMcff7zVOaAP
 JHilIBLY=
X-Gm-Gg: ASbGncsTEUbjj9CgqsLN94bY1a25jSFAbZT4EkUgMQlhlulguNwau7ypNcLALCxcrTt
 /uHu9OvSmdAL739wiKPdPTIh89HFbSU5zJMTerMcHD9OwbMnQ8L0ZiYXIhKQrHgi723iB2ogTM6
 JQoPan32sbSxeCAvcARbyStwm/xfBF83z0qVAJXq9iSZOQMPhsu/4aMzxAeocP37wRzQlRvmppi
 H5f1VbKu4o4kat3WFy2wky5JGRMio9fYdpMdLXruzD1f2PYSX04kYiYNMi2fxpCjAZHaaSq/3ZZ
 beIjYcEkW3gVD4Pa9fm5A3YkrpwrDkeJfoBq4jOeKntpJviHGRVqUuvqfAvMWD/qP/OR4xSwgux
 og8DV4Q+scx3buEAbNE1/hrMd0WcXAuPJ4za3cBN5FI+xM7YuPbTvjx3DOjQNtWri1g==
X-Google-Smtp-Source: AGHT+IHdIHgTs2vYNdOCk59NJkC2Zhs3Tc5NSvi8dC7uxa0kj+Unq3zGZnS+h5KRU4hS6dZYkBAZPA==
X-Received: by 2002:a05:6e02:1561:b0:3e3:cc1b:2b5e with SMTP id
 e9e14a558f8ab-3e570866948mr75460215ab.15.1755197311774; 
 Thu, 14 Aug 2025 11:48:31 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-50b3d6ff137sm1219762173.41.2025.08.14.11.48.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 11:48:31 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20250804215008.1411974-1-trini@konsulko.com>
References: <20250804215008.1411974-1-trini@konsulko.com>
Subject: Re: [PATCH] sandbox: Add an additional dummy sync macro
Message-Id: <175519731101.3600102.13860013650786989006.b4-ty@konsulko.com>
Date: Thu, 14 Aug 2025 12:48:31 -0600
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

On Mon, 04 Aug 2025 15:50:08 -0600, Tom Rini wrote:

> There are some drivers which call a "dmb" for a type of sync. Add that
> as well to sandbox.
> 
> 

Applied to u-boot/next, thanks!

[1/1] sandbox: Add an additional dummy sync macro
      commit: d68db76b95b106227a40fcf41ebf4dccb2225a0e
-- 
Tom


