Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EFF4F4613C
	for <u-boot@archiver.kernel.org>; Mon, 23 Mar 2026 15:14:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C08D84144;
	Mon, 23 Mar 2026 16:14:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mSUFPyws";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA72584144; Mon, 23 Mar 2026 16:14:41 +0100 (CET)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ACDA0841E6
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 16:14:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-404254ffe8aso2761700fac.0
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 08:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774278878; x=1774883678; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hx3h8o7/jwlr08muI/qgBc+Bi249GhgmvG7CHptIiEU=;
 b=mSUFPywsnBj4qNSh6cj9NptBn52nCnjM9Fy8nebqF9VkTmuluGNZwqY0PCiktMcFKO
 jSNVOxmremcoH8OQZxZdD+OSlVWXU4kU+tDHrPNQOX6VGoCUi1awjiuczRExcwd7Iv9Q
 GeCtS7D42+VhIjvpYiZpkK6VmCs6Z1N7nvteE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774278878; x=1774883678;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Hx3h8o7/jwlr08muI/qgBc+Bi249GhgmvG7CHptIiEU=;
 b=P8NdkO/cvgvQvOqhQnmIXj7kp+prd7xSNFbIdSv0J2XFYGGzJIlq/56S3VfKarGIkP
 ekeL0oXdwk/ymeOV8ozDUqoeYSI44knFsJGWX5L4DO3PI3VJVB4uVfUmyu46Qe6DJvrl
 4mUiiIkqUhd7cWk9qzM5Adj47368z5ZASrFg8Lpkeb3amUx0snaR5mkqWe3mW0C49j1N
 v7+eAw23jt8lUoI1yEdWWWPdpX6CQmq7VLh4JcHm92UBCn6r8zRDljqLsKlNx3Rv2dyL
 xaBF0UAtldH4SBtsuAP1nhmFTir91f+FxCYMQgZW1fPDH4v+TC+rMkcScYOs+52ZH+rk
 Qv4Q==
X-Gm-Message-State: AOJu0YzNTTcH4J5r2zkRWESuJOvV0pU45j2oBgnChyILDWE9OtYd1XN5
 2uLg4ELGbxELuDHR1uJ+Nh0yfaAewo1Z6h1jiOe7bGjSEX43VOe4eOF2c/2atljWfasFYrnY0iC
 1MtdYmDw=
X-Gm-Gg: ATEYQzyeGbYpQtHfQOQ2l6xQ/aoqLRpkVlGu5KSG3yIBklwu9EkyPT/sWUm00qjINnt
 LjohoobUFdnEEQfU8vIZa98nVQaYEXZUIXNT23/S2NFjXAdgFunNwWitd7DscTyJj9yNnBc8D+R
 y3Nwmv/uTvPhyq1EI7lVs/fEUIPTfTn3X3ycV0YGFaSV4XA5K5IFRMjDZFs5HyU2s4NlSARraX8
 HO63CDyC7gwwRNrypo+5/jIJVfslis4+h3G5S0qoUrAwMJTqIHfkt76RCtEdfu9+5LNjR6A0tNA
 tnrdGsk8qoyncB787MsbgOoKzvUVri4ZNrqybgjG8i7ilJK9Pw0vdERrewG8BoCBUfcpf0tZ3Su
 qE6oZY+POzWVEzXzBxtvek1zL+5OZUnzpRHm98iucITtUz9rGanJoV4+iWgt3v2C1fLa5FzWTfk
 fMJqDll7Jro0U2I/yKQuJWoTe1btMqM+Nrqli37QejUryvtYYjZ1Cd6nu5Z+TR33vrEFhMD89RB
 8AiqbO4XPzPSYF9oqsSgFKQDXxlJaNVuUwwGnBQUx4xKY8=
X-Received: by 2002:a05:6871:69b1:b0:409:628c:ca6e with SMTP id
 586e51a60fabf-41c1038e43bmr7995900fac.2.1774278878304; 
 Mon, 23 Mar 2026 08:14:38 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41c14dd0a6bsm10057366fac.13.2026.03.23.08.14.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 08:14:37 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Michael Walle <mwalle@kernel.org>, Vladimir Oltean <olteanv@gmail.com>, 
 Ashish Kumar <Ashish.kumar@nxp.com>, Kuldeep Singh <kuldeep.singh@nxp.com>
In-Reply-To: <20260319163343.1679919-1-trini@konsulko.com>
References: <20260319163343.1679919-1-trini@konsulko.com>
Subject: Re: [PATCH] serial: Enable SYS_NS16550 on incorrectly migrated
 platforms
Message-Id: <177427887742.2283014.8941990225595983435.b4-ty@konsulko.com>
Date: Mon, 23 Mar 2026 09:14:37 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Thu, 19 Mar 2026 10:33:43 -0600, Tom Rini wrote:

> With the migration to DM_SERIAL in commit 191b10ac70d7 ("PowerPC /
> Layerscape: Finish migration to DM_SERIAL") a number of platforms were
> incorrectly migrated and did not enable SYS_NS16550 despite previously
> having enabled the non-DM NS16650 serial driver. Enable these now.
> 
> 

Applied to u-boot/master, thanks!

[1/1] serial: Enable SYS_NS16550 on incorrectly migrated platforms
      commit: f09e500f6d242d35fc477dcc2dbcfd469188b5a5
-- 
Tom


