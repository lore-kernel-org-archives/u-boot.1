Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6D3BC19F32
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 18:10:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67C5681420;
	Thu, 27 Feb 2025 19:10:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="q2J2vkxy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C08A8141E; Thu, 27 Feb 2025 19:10:36 +0100 (CET)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53451812BC
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 19:10:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2211cd4463cso25720035ad.2
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 10:10:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1740679833; x=1741284633; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C76wWnehvoXcTAZqfeZdmtp6qtrVRfF6+MsuA4iTSl0=;
 b=q2J2vkxyjxxSveTm/60CDvx1YrK/4SSJ2BLuP6Xsf1xQe5SLK/WNU/EdREYAoGFk88
 5n43cgPLAwstoOMV69+Ijr5hERuv+fvcieoDxxINf6SkK3Mr7fpcQhOF+VqCdRuSUYeY
 FMc38Ex/rnCBnVTBj0JhmVzXjXeXLFwUlRyGU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740679833; x=1741284633;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C76wWnehvoXcTAZqfeZdmtp6qtrVRfF6+MsuA4iTSl0=;
 b=wCchBjgCxbBtg5HIqQf2u/exSniiPKLX+hvNKgLDfHbzZsNDerSAEdnA8gMy3Mesek
 xwze1rigzFWUpAdj9u7gdrFcXzoqF/xRF0DbJJ/5m2jcqSS1ZBS9H5qSz3esZ3dpsjaL
 9xfsU5Q11Vm5Mo2wY6//BMZyCHeP/SWZ9/jv1nZU0q4elnTo18Yg7z5U5bWNAvgTbiJ5
 9WnYZqk1E/seTCmOUClAC4wiIcWN2Iq/0L4Y1GV3GHV7z16giIcIJs5hrii7BvJY5zS1
 IfUiTYOR4ZJRt5iFVk0WTiBs/zI4VzXNBxDo4X9f0+gxyoMtrfoqv7HzZb6oQK/7Z7p3
 Ic8g==
X-Gm-Message-State: AOJu0YxaFQckaAROr626MFs4rW864pN/DGYknVmnQ0MF9lgWWYYUptYR
 8cb3+P4k9J1zK25+sh41gElinFtulPVlnw1ox1Y4y+YEh7hS+YrdjxgMG1v0pqw=
X-Gm-Gg: ASbGncuLmaeP7vg6lOkx8zUpp83q6Kd+U4sSV4bhYi7Vom8tfGxooxehiMnPzw65r1X
 MMfzkLhL8Xps+1KcZJZBYErFkgsIeFJ0fxA06vjH+a6aKY4t5/XU6TZjMqMxa2kLmZVil9VV0IG
 3n+X9Rjm1mg75tFp8/2X7scy+msAivFB/dCEzMXb4ytKHnQdauHSTPFU9Zz3nfp8kuiIcbTP19X
 iHjptGg3QEIUoAV+t0NzQm+3mENQf9f6l7qDBPkQAo87QTp5iEdMg6aOWVWp31YFZek1+73jR4h
 KUI/a6+KZjeydz4w3SgFGxU=
X-Google-Smtp-Source: AGHT+IF4+shin4K3qxBclJkdgYiO0UuZyfeXUemQxuPgErZemPeoMp7dLsOp1HoTeWtRlWBqLFq1KA==
X-Received: by 2002:a05:6a20:d487:b0:1ee:e0ad:e6e9 with SMTP id
 adf61e73a8af0-1f2f4cbc8b8mr131789637.14.1740679832887; 
 Thu, 27 Feb 2025 10:10:32 -0800 (PST)
Received: from [127.0.1.1] ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-aee7dee0ba3sm1791256a12.68.2025.02.27.10.10.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 10:10:32 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250227141536.204947-1-festevam@gmail.com>
References: <20250227141536.204947-1-festevam@gmail.com>
Subject: Re: [GIT PULL] Please pull u-boot-imx-next-20250127
Message-Id: <174067983174.4113440.11437571911231495752.b4-ty@konsulko.com>
Date: Thu, 27 Feb 2025 12:10:31 -0600
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

On Thu, 27 Feb 2025 11:15:36 -0300, Fabio Estevam wrote:

> Please pull from u-boot-imx/next, thanks.
> 
> The following changes since commit 8dd7186ca7821446c6f46b6cccefab502912f2e0:
> 
>   Merge patch series "Remove "saveenv" functionality from am57xx evms" (2025-02-25 11:11:32 -0600)
> 
> are available in the Git repository at:
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom


