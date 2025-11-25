Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 026CFD0E6EC
	for <u-boot@archiver.kernel.org>; Tue, 25 Nov 2025 15:36:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89E1283F89;
	Tue, 25 Nov 2025 16:36:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Hbc73nuB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 218EF840CC; Tue, 25 Nov 2025 16:36:43 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E017483F75
 for <u-boot@lists.denx.de>; Tue, 25 Nov 2025 16:36:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4dG6HV712pz9vH0;
 Tue, 25 Nov 2025 16:36:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1764084999;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dwtz4h39aVhJrg4r1Pk+8miy7I1dvT60i/42k/rhYgw=;
 b=Hbc73nuBLb/4oLdZwXrR1sEMQD7kfuh9KqmsWX7jjiONoXQBiceYfVGqAFbpNSNzJL0Ln7
 hLKcZKXQKFY9HIjMOpCJ4H93yyzF/8Fc9t4KpwNn8TxmbVnLrTqcQE8AiGis0HPr7/eMFm
 fl8uaivMHq64iGexUTiha3MRa5x4GBT3UdOIRpYyn4ExriW/Si5U0Aex5mV/I4hJMVLb+D
 cwVtkiB/PnGWGeVzbERa4PJcSXN9THJjJEM62XTO+hr9teOi5sR/VLvxrlgtyGBRueq4dB
 7QNSLZlZGl1rzkXu7aqCC6XVE8Y0UMuW4PnoXtzUCjrDkpTS7d3rVkUv3RYWoQ==
Message-ID: <e5208fa1-2964-4253-b436-1e0b71f1efee@mailbox.org>
Date: Tue, 25 Nov 2025 16:36:35 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 1/4] ufs: cadence: Rename CONFIG_CADENCE_UFS to
 CONFIG_UFS_CADENCE
To: u-boot@lists.denx.de, Neil Armstrong <neil.armstrong@linaro.org>
Cc: Anshul Dalal <anshuld@ti.com>, Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Michal Simek <michal.simek@amd.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, u-boot-qcom@groups.io
References: <20251030223626.20005-1-marek.vasut+renesas@mailbox.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20251030223626.20005-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 49708c0cebe5fa80d00
X-MBO-RS-META: ornytrp9oin6nz8qa81mim91998uryxe
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

On 10/30/25 11:35 PM, Marek Vasut wrote:

Hello Neil,

> Align the Kconfig option with the rest of the subsystem, use
> CONFIG_UFS_<vendor> format for the Kconfig option.
Can this be picked up to next ?
