Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECE41CAC5AE
	for <u-boot@archiver.kernel.org>; Wed, 24 Sep 2025 18:17:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6853683631;
	Wed, 24 Sep 2025 20:16:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Frf9+KCQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5A40835CD; Wed, 24 Sep 2025 20:16:40 +0200 (CEST)
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com
 [IPv6:2607:f8b0:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B75C383071
 for <u-boot@lists.denx.de>; Wed, 24 Sep 2025 20:16:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-42593858280so482245ab.1
 for <u-boot@lists.denx.de>; Wed, 24 Sep 2025 11:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758737797; x=1759342597; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aPmNEe++WMEMQYclRse9SnlrA8aoRplxZLAd6jIE8as=;
 b=Frf9+KCQm6jL3gAgUtZwzjledf5cgo2ShW6D3iHbsRmCQi2xe21LXoMALIXdSdhWcY
 MlaX5xEcC6dusbFBYH8IKmUajLTj91QRmYCc6qNC3e2r4FTjNFxY/OuXv9yJaS2KwR82
 rkug5mhuQzrfn23PQM50sC6T20JQ/wDevzwUY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758737797; x=1759342597;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aPmNEe++WMEMQYclRse9SnlrA8aoRplxZLAd6jIE8as=;
 b=sHfeN3KDctyFbGryUifubPB9T3BzDYw7AoW9usDs6sZIN3ZJ03aYpdFgMWiOpvC140
 eeilOHRvq0hFfVtNsnbgZ7uW/DR9tQQBFgSNdUz+586KAg2UuZRbb41k3qOuTavrPO8f
 je3GFH5UiXzlpLr9ew+M06pSVEJNBh7shyrdbWRnWprRTHtBgpOxjMz5wDcpmqFC6Gtn
 7p+EUFCJErRkEv/46CqevqsUBXghcAh+ySf6H2cDRr2wAAXetfRap4zKTJtmIJcBsex7
 eUct1IuSEpLl+WGunZl7bm60NzdMC3FmGgwG+Ndb2gEBKXxuXdAkRvI2JrPw5Gn4O7Zi
 PLzA==
X-Gm-Message-State: AOJu0YyvGuFItJqrKRUBA5egexdO3IbfNc+WR/mXfIsk5HVveQUGwd7v
 /sc2LOxhHbrqGDzf/W8pbq0rgZbSoy8iZ+MyKRnHIGnfXekwz+ZBUzMyszAL9KFPAKNGeWH2yXB
 JU+/xMyo=
X-Gm-Gg: ASbGncvvCZLVx1KlwK23aIhkJT/UI6l0uvURcEowr3KDdRfXqaclNeFdcL7peeCzOvM
 fIC3R520Q55vGq3woR4XT9tKBu/3/y0l6WNwACcqmIXnfaIbVQC3D86yOibgF7paVx8v3k7wqys
 HJHbUGUUQw8cY3g6EjBP29EwVutyWWl97N0Y21j1od0IT5ZSmlkvFV3x29yCr14DlxJEL6sLLw+
 WNH/6CthFiR7jptxaLlzfDGNiSsiI0ui84IW8R9Z1erLgkofarwzY1dUDe5Aux2Le46hrP0j38d
 ErN6b9GRZ63sYuQpVkDTyxLuBai8fFOvvgDhk/6+P3Irp3sda5jFOwbOBLDBgSU38wfPlBDAd8M
 haDxDSwoSKkNssiXqS8he3k8UdCjnTBM5zl3Y+PzLd0UBdv8rsriEF0I=
X-Google-Smtp-Source: AGHT+IGJ2RVJdzEdz8xZBWlWluGKi/7N0gDLPm34mbeFAqjKRvrJQ6mfxDtUqLHqkHhqhEm7UOu+Qw==
X-Received: by 2002:a05:6e02:2193:b0:425:85b0:49f4 with SMTP id
 e9e14a558f8ab-42595623754mr8476525ab.17.1758737797397; 
 Wed, 24 Sep 2025 11:16:37 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-4244a493b40sm84122645ab.12.2025.09.24.11.16.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Sep 2025 11:16:36 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Jan Kiszka <jan.kiszka@siemens.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
In-Reply-To: <13ba48f3-155c-4329-8bd9-fc548c6ea53c@siemens.com>
References: <13ba48f3-155c-4329-8bd9-fc548c6ea53c@siemens.com>
Subject: Re: [PATCH] lib: optee: Add line ending to debug() outputs
Message-Id: <175873779654.361751.17260542925422656365.b4-ty@konsulko.com>
Date: Wed, 24 Sep 2025 12:16:36 -0600
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

On Mon, 15 Sep 2025 15:41:46 +0200, Jan Kiszka wrote:

> 


Applied to u-boot/next, thanks!

[1/1] lib: optee: Add line ending to debug() outputs
      commit: 7cae89bac47cd8e79c91034865e5a671334f73fd
-- 
Tom


