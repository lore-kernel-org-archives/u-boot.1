Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79A73CAC592
	for <u-boot@archiver.kernel.org>; Mon, 15 Sep 2025 23:09:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA81B81E13;
	Tue, 16 Sep 2025 01:09:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="r51yfGzl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7749182C84; Tue, 16 Sep 2025 01:09:06 +0200 (CEST)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E81EA80B9B
 for <u-boot@lists.denx.de>; Tue, 16 Sep 2025 01:09:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-8935b53bb14so42097439f.0
 for <u-boot@lists.denx.de>; Mon, 15 Sep 2025 16:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1757977741; x=1758582541; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5Sgh5DB5aYJmC1avUTWSQJtbfaTSuF0tCpP+LLokeEI=;
 b=r51yfGzldVf6FKZ3Fwpy7FdtJvMWewHSC3e7a+yN56RbqN1qHMZDIwOpNA5bcHAKZh
 /v1Q8Q32wDwt875pdpWOLQdsagdPPER+q4WqM+UD8MdtbO8pHwoGJ551aoninT8PNAk6
 sifo9TdQvGrA3ou87eq4t9KZCW1xWf1fpuhUQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757977741; x=1758582541;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5Sgh5DB5aYJmC1avUTWSQJtbfaTSuF0tCpP+LLokeEI=;
 b=NE3AYNfKsgvXYUqSh5L5povKzatWzDzR1bHiQMkMrxRYqzQwhPrfKQOOfq8L/TFVnU
 aN4osfgQAdvUmkbpKXesz2wZ2iD47cQY+gqj54m1xtA/6xC7zBGkGye1c4tJiRBr/0kj
 DIHVFWLtk1mPkjSntBgL6n2JPCi8Zjggu4yIDlNUo3KlmcFffB0vevcg3YBiZ7cEC+o0
 k0ob4zD4v7El9xtXAmkeHN+tmm9qA3UO5GKNNy9gvLlD5eeGHED/Sdv4VQrzsRdDmXMN
 jonBIfBhQmypXNKufuAk+glTjwX9H0IOCmSBVXVIUvyqLhsLrdn08AYhvURjthAOZcbn
 HEig==
X-Gm-Message-State: AOJu0Yz+LuyXKkA27buprQuVKAR8ApfNdPojWB9mYW9H70PqgpoAtL+x
 ycZcfxntyRlFZQU35kQ4EY9NQxYGVYG16fTUAZ0dmRUkHrnNY+k8tWzqpCWcZBgD2rs=
X-Gm-Gg: ASbGncu97CoEEwY7OLHP/nwVAt0saom/wr9v0IbKgjYlMo8+hM53jyNquvPCWjj3EJ3
 PVZu/pESMGCwC9sUJpc2bLFelAbWsAi/aRY/+n2nN7DXMpiJ1on70Zjs2HnCqvT4dZfOs8moSW2
 lWvzpgFG6FoLScaF9QRohi++0i5wXb0WW1j+M/1vGnnJZCZeaRGyvxYzIjlrOIUcvtDkVoVD6n1
 kh3euLwnepCEQY+z45FSrlgENBpZcflpWNY3zWbZF85nW8NNT2Rea2PYphvVViHKu8Hiy8F/exE
 3kXukwS+GdCjJi75A6WvsCd4HVb+hk0jVvzhcruOGoMw61N7y5T6N/apsJowiu1IsHY9q77RyJX
 oeGDJBpmB6f1pD8VK5o648L7VVhbtUD2u9A7oILXHXxhYTMrVeFdFkmw=
X-Google-Smtp-Source: AGHT+IEnAomsXqLvKHcM6xoj3PcWkjzCFs3OW/TZnzIfetYBtn21r37OT5M4at/4JsN7Js4p0ZcWbw==
X-Received: by 2002:a05:6602:3fc5:b0:887:628c:7ff4 with SMTP id
 ca18e2360f4ac-8903213cf42mr1524574639f.1.1757977741087; 
 Mon, 15 Sep 2025 16:09:01 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-511f30ccc33sm5144259173.77.2025.09.15.16.08.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Sep 2025 16:09:00 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Ye Li <ye.li@nxp.com>
Cc: peng.fan@nxp.com, festevam@gmail.com, uboot-imx@nxp.com, 
 alice.guo@nxp.com, ye.li@oss.nxp.com, tien.fong.chee@altera.com, 
 alif.zakuan.yuslaimi@altera.com
In-Reply-To: <20250912094111.319680-1-ye.li@nxp.com>
References: <20250912094111.319680-1-ye.li@nxp.com>
Subject: Re: [PATCH] arm: armv8: Fix spl recover data section broken
Message-Id: <175797773953.472537.3482532758923188299.b4-ty@konsulko.com>
Date: Mon, 15 Sep 2025 17:08:59 -0600
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

On Fri, 12 Sep 2025 17:41:11 +0800, Ye Li wrote:

> SPL recover data section is broken which causes reboot failure on
> some i.MX platforms (iMX8QM/iMX95).
> The global variable cold_reboot_flag is assigned to weak reset_flag
> function which always return 1, so restore never been executed in
> warm reboot.
> 
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] arm: armv8: Fix spl recover data section broken
      commit: 2dbde3f9b08771b8182fcbf0bb0309acaff6c2e1
-- 
Tom


