Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC131C1B0FF
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 15:23:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C9DA810EB;
	Thu, 27 Feb 2025 16:23:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Z4kk5ZEj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89B73810F5; Thu, 27 Feb 2025 16:23:09 +0100 (CET)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC45180FF2
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 16:23:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-223594b3c6dso13599755ad.2
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 07:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1740669785; x=1741274585; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HNtFIC74i8hi8++L5iVJsZL+ajx+0BW1NFGMdVB0VD4=;
 b=Z4kk5ZEjas05JNpBUgGUuqFCMfX9im08bstJv1v7cDcfJHyhvjrxyO7DaFTJbYsFxr
 okk9Y1m22Ra8YthW6yTqPbbKBKqGz8RZ7bCr7Y2Te/BwQ94uVWB3pQ7cRV9zrdu4SaRi
 IJZDCiqBiobo6jJyRh7Gkkzh4MUsig9duVN8k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740669785; x=1741274585;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HNtFIC74i8hi8++L5iVJsZL+ajx+0BW1NFGMdVB0VD4=;
 b=gxY32rZ4YQjoG4eJyZywG9O6mn9ayhNiHqhA68u9MkB0RoB2rLa3z4wwOC5LWtPzSK
 gGLquOkbdjiqj3mOOTISFACHvLjZ2OmGZ0azdoUOpF2XT8WGe2VREhi52ILnQJgRquF5
 N65/Xb4wTIiid8mlDym2G2IW9zSLAsy/Z14AkgnbGlWB9VqMnqxbiL3VfThczrQseKqn
 ZJnf8/ienZi0lAv6HlUp0AsEdYTf910rM2boKgbbOjdH4/ozjchyhkBseKWKbtg0afTp
 k8IfrI4JP6Mqzm+13VuuWc37Ld/8kGlmrzFZgrwqD8cWk/5DZLxZ9PqB5m/ZZZvTcgwK
 kQVw==
X-Gm-Message-State: AOJu0YyAqcXAB4eveQO35CWZkFYPtVZ2IVzbeMgJKodB4QcBr9V9TUhs
 0ITfHAWF3SZW2QUcq0ggvvQlfteLjlmDfwTLitt47RgG5HqMt2nX/mZImQk91Rk=
X-Gm-Gg: ASbGnct+257635TEeZejmqXxBvMz6k36q6ksPPSQSG/DmCLWV2UF8ooNbkDoadqHkfo
 ju5qUmHtMEmCgyrV7VK5+DJ5kUGLwmqFEmMir+5Qh5FwTrcfBSRB3Coi6ExyNlbTFNq49Rwsnvg
 M10LHDYQJwpIIbWZG1n/t4/jMvtPrgElucWFjwh370Lf6sXaurk6z3d9QYHuaucW0Z4rskYrrza
 ml9K2g7CSCnsksNNIESlg+zOsSrty29gb7Ugur80Ke+Myt4AZVvPn21dgliRO/PUPfy+IzETJVT
 SCZYYXhvEI4uWmhqhIQIs+g=
X-Google-Smtp-Source: AGHT+IFhyLWlslpaVVmAqnG3/acUZmbMyYuLV7oeOmDkNVfVcVvZkiSTJbv14EkBs4uaNiD58g+rkQ==
X-Received: by 2002:a05:6a20:4310:b0:1ee:d92d:f6f3 with SMTP id
 adf61e73a8af0-1f0fc998e0fmr20452349637.37.1740669784655; 
 Thu, 27 Feb 2025 07:23:04 -0800 (PST)
Received: from [127.0.1.1] ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-aee7de3c4d4sm1383802a12.46.2025.02.27.07.23.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 07:23:04 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250227124816.187928-1-festevam@gmail.com>
References: <20250227124816.187928-1-festevam@gmail.com>
Subject: Re: [GIT PULL] Please pull u-boot-imx-master-20250227
Message-Id: <174066978383.3965812.1331149257145830012.b4-ty@konsulko.com>
Date: Thu, 27 Feb 2025 09:23:03 -0600
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

On Thu, 27 Feb 2025 09:48:16 -0300, Fabio Estevam wrote:

> Please pull from u-boot-imx/master, thanks.
> 
> The following changes since commit 57bbc4de75f6f6eb066462c777bf18cb8b8d4631:
> 
>   Merge tag 'qcom-fixes-2025.04-rc4' of https://source.denx.de/u-boot/custodians/u-boot-snapdragon (2025-02-26 08:55:32 -0600)
> 
> are available in the Git repository at:
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


