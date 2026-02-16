Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DA1BE63F2A
	for <u-boot@archiver.kernel.org>; Mon, 16 Feb 2026 07:11:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5695D80B98;
	Mon, 16 Feb 2026 08:11:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FKpH2Lme";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5154C8063E; Mon, 16 Feb 2026 08:11:10 +0100 (CET)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA34780B98
 for <u-boot@lists.denx.de>; Mon, 16 Feb 2026 08:11:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-4358fb60802so1986280f8f.1
 for <u-boot@lists.denx.de>; Sun, 15 Feb 2026 23:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771225866; x=1771830666; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1Fk7iz4KtqGQrep73tdDPgkNTFE1s8nqRW66t2trTxs=;
 b=FKpH2Lmetx1VaaBmaGlhi3Wn4AC+yJHI6vX3+CWhHd0NnlLYxAVWynWeYmTuo/D0uF
 bHagWqkvRc4tX64o4Y83PTqzIdZ6zkfVG2mxJlEtZqOKkKCwAjeC7Drw4VLtF15XxIXi
 D3WBZb+Ey6Okk8Pc0cHJ29Iv+Pn/8cv49cW2UEU8utPb4vuRl42H54ZKPmMSZoJ8Mpb9
 0jzomlDuzuSNiT519iZg3IgAyODDeDU95OXQsZgUfKJZQAjBQ7MAtpUD0flDjBkk+zwb
 fSKNZtHGBcLfaPQ/jAyLcYWKGxkIa684LldQ47RcwSmRxXV/75kTVYtAIgLdp2rya+PG
 iU+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771225866; x=1771830666;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1Fk7iz4KtqGQrep73tdDPgkNTFE1s8nqRW66t2trTxs=;
 b=I2O7aicvCWweperERspJ22NcTuURzt+NEYRavTaFTSH4AAn6nL9b6WhQa0ur33X449
 pAE/yRuhixUc9gOgOw9YWyJ/aTbgioiM5oWi8ug02o/kjCLPwrDibV3vkRHu1vcojJ9e
 C6y9rVGIZU+0UUXzwybdkgsk84FV0EcKDiaB9dmT5l1Pe1m9w/RdOTbpl/SvDnSW+tbT
 eqT3K14yvPz7hSLbtWM+zIFSETyhhx2e8obh3sbyFRyFHMbeUB/4o3HEULXB0L7okEHF
 6nMJK+X+GFe5exqT92BUdzVKPp5YNrkpaIuBoKNwvqzYTPMQlm7M2ObbUSyUTqEeBZL4
 HR5w==
X-Gm-Message-State: AOJu0YyV/SJahwcJh8xAMqJ/5ae7by1IXaQoCe0D87EY2Gc81ESfJe4g
 q/ox3wN36MlnlqZeVDZbV1bhCLf3+sNy9wB4Mc2L9JziV0aG0w9VYqEjtxvQbzdGjp74v17H6v3
 mb1sT/ec=
X-Gm-Gg: AZuq6aL0QLUy1Q8BpzDvS8quTRa1m+kQSeHrHy5oiluhMQoIbiKbQYkrwMJ4st2kSo5
 sYnTNDhQNYTY2brC/cmgjB9kzqwUOY/H86vRmG/+RRAJ3S61gUg24vBTL8zGXfh0R2mCFGkDrIX
 ea0KgG9ME+deI1fV5KhbrQ8ocPUAlDKbvOll4aFSeF6G5txBz9iGz5gECy9epbUiVT1EHkcGsb3
 QmWFlxIUHAlKksupXvZHB8rByFvLSeS7XYzzqg5Lt1SBlSnwYHAkPgFVOAZZdwaYHwj4wf45/46
 +l7iRtnntNVn9oMXfLcySOVjxI4yF1vL+fSYAzMvW4H8PlvAWwhbetUEYdGgS4SNrh1IEDqqAUZ
 oN+nwedlOFVe1wJj3XgcI9tymNYtNRUnRtzV/q3ANfS9ih8Re2rNXlWgrxZvSLxxsJK1pbOf7Gg
 jovuVkgES9Yjg/BRqK/gCgFg7TGcx0ZHkZU+Az/s7KIGeYPgwRM+QszfcrUd+PJsTjaLYcJVlXf
 7kXQulXO0mTjJHf5Uk51Yys/qq+79RBspHDHGK2z6AuU1B44YUdjH2f2vYp8PiQoF+xmF0FLIiz
 /2jEOFE56b1edKfqH70wA6UGhxB57dD8eDa/1r9PPREZUwakySEndoc9ZhYLteheJoTNw5HL9Md
 j7Z/nZcFogLPtlyvlUuD8ACnzahva0q2nrm+UlOEgdETkPP6Ehr+/y25acnlnl/ejP0rtNCedPS
 aotV4OU7Mx+sMZIcYFBkouCR++8T/7kPeAjmO4pK8D46/sbnakDtL13rRm+rnw
X-Received: by 2002:a05:6000:430a:b0:437:6963:a104 with SMTP id
 ffacd0b85a97d-4379d6151e5mr12861155f8f.20.1771225865927; 
 Sun, 15 Feb 2026 23:11:05 -0800 (PST)
Received: from hera ([94.131.143.12]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796acffcesm22509244f8f.37.2026.02.15.23.11.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Feb 2026 23:11:05 -0800 (PST)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: u-boot@lists.denx.de,
	trini@konsulko.com
Cc: ilias.apalodimas@linaro.org,
	kory.maincent@bootlin.com
Subject: Pull request for ab-next-13022026
Date: Mon, 16 Feb 2026 09:10:56 +0200
Message-ID: <20260216071056.3108298-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hi Tom,

The following changes since commit 9e6b66409a3235ae73f1937929fe025911165bbb:

  Merge tag 'ab-next-11022026' of https://source.denx.de/u-boot/custodians/u-boot-tpm into next (2026-02-11 10:42:18 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-tpm/ tags/ab-next-13022026

for you to fetch changes up to 7080475bb7c2e9ed272cb88be83a42e73edfe0f7:

  fwu-mdata: Allow multiple metadata storage drivers to be enabled (2026-02-13 16:04:40 +0200)

The CI seems ok
https://source.denx.de/u-boot/custodians/u-boot-tpm/-/pipelines/29283

----------------------------------------------------------------
An update on AB subsystem allowing multiple FWU metadata
storage drivers to be selected simultaneously instead of
being mutually exclusive. The board can then select the
appropriate driver at runtime based on the devicetree
description.

----------------------------------------------------------------
Kory Maincent (1):
      fwu-mdata: Allow multiple metadata storage drivers to be enabled

 drivers/fwu-mdata/Kconfig | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)
