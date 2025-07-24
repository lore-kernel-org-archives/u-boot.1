Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DDF3C87FC5
	for <u-boot@archiver.kernel.org>; Thu, 24 Jul 2025 16:33:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0587838D4;
	Thu, 24 Jul 2025 18:33:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ICutDb8/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44B29838DF; Thu, 24 Jul 2025 18:33:45 +0200 (CEST)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69BEE838C7
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 18:33:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-41bc2668f75so654664b6e.0
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 09:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1753374821; x=1753979621; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ml4mWOFCdKzEjfiNvs1HFlw5RfWc5A1JJGxyH6EKOPk=;
 b=ICutDb8/dtq96KAFgXqpRwryxax3+9hzwv53tfHSJI2SknI0D30Vd9msu6k2vUxqaz
 crFobyHufzTMT6rjX57o0E4GKEyO8jz8d5ytScmAv0u72+uY6mOPy37oYcF6+fY4+gAH
 2i2zpwNgzUKuPfopY+s6qDl67mu0jV7mgJftA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753374821; x=1753979621;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ml4mWOFCdKzEjfiNvs1HFlw5RfWc5A1JJGxyH6EKOPk=;
 b=Ktifuv8j2MOvpH3t4B6Pv8vESDwZ1iKApCBwOlwCrb3Q4GsP6WKcvBGatTF2ESRFZR
 j+QxBrS3zwgxSONWMFIqhMUjIfK4U41O+LhNdDm2+EsebqkLTUxTO6Brc9eGkSAo2+E9
 yyxJVXbCpE6ENX/MLE2CBGkN3Gr/ainfP9eumG/M8sDgtxFIMUFJBLpcTb5i/iGDNlLh
 yjZicREdDQEud4zG1NrdGicE9GPP03pqt1AYwQGQngdul44RamjYwob+nB32/5IUgO9d
 Q0SNSRrWx9gyhWEjjHs60+2YOj5bVL7gcUs2TwQWqwztmlFRnweoZwBtJYME+76CXMG+
 Frag==
X-Gm-Message-State: AOJu0YwxhOKE3nvVih6KgwyYh0FEhacF3FXgV/y3Wiet5ct2TtTvKjfa
 jO+amdFYZg4gaDzWpqMOwbp4EoEeNZ6GLl8wPnF1DwFL0QDfYI6jvUh6YizaMVRzk6nUKX9uuVj
 JvxwGOuc=
X-Gm-Gg: ASbGnct2mXVSMJWDGV9DTIdK4lDA31nI5BcibEQgM1AJVPv/BaGNKhKy0Lq083l2gvk
 in8m4Q622976kb+PPmffhXvWaaWkOeegWTz1yC+NGNcXkePg/SYrP9JwTl6CVinqVCDZ72XyHuW
 P5lUudegIywqQQetlMcKOorR8dR4/jNfATr5AAteNxfkAWfvuXbFqNUVZ5+fzL2vxIzpfX+QWWE
 dUaC9uqJM8qtlqIhi8aId4WxH1i4GWx6rEOBg6rebLuOkJ1/io/th/vyVbpVI2bHW+fio6ttMJe
 eLMkimzDoSJbdFRx7PjsnIf7l3m1yDbH5CNYZhwg+zCiXZ5qEZCFLfsTM+9vqwIYgh1KdstHnMq
 OO4+W4UpKCd49gsVrhBtqXBaTnKdVI0aoDYIuJFFPyBsm7eg66/9C4Uo=
X-Google-Smtp-Source: AGHT+IGTHt3pRvbeQKUsERE3USOl0f21KZ9P1KEfsvo4qcJ4KEF8a4JmDvqZM3/4Pegqabtjy9trLw==
X-Received: by 2002:a05:6808:2f08:b0:41f:79f9:1b4d with SMTP id
 5614622812f47-426cddb5ac0mr5097432b6e.28.1753374821054; 
 Thu, 24 Jul 2025 09:33:41 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-42a33092eb8sm294351b6e.33.2025.07.24.09.33.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Jul 2025 09:33:40 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250724084733.GA30707@nxa18884-linux.ap.freescale.net>
References: <20250724084733.GA30707@nxa18884-linux.ap.freescale.net>
Subject: Re: [GIT PULL] please pull mmc-master-2025-07-24
Message-Id: <175337481985.467777.5510846098360192237.b4-ty@konsulko.com>
Date: Thu, 24 Jul 2025 10:33:39 -0600
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

On Thu, 24 Jul 2025 16:47:33 +0800, Peng Fan wrote:

> Please pull mmc-master-2025-07-24
> 
> -----------------------------------------------------
> Fix emmc error state after mmc write timeout
> Minor cleanup s5p_sdhci
> Support DT upstream for exynos5420 and exynos4210 mmc
> -----------------------------------------------------
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


