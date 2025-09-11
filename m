Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B6EACA1016
	for <u-boot@archiver.kernel.org>; Thu, 11 Sep 2025 12:34:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7DA28334F;
	Thu, 11 Sep 2025 14:34:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="gwRAKT4k";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="rkV4egEl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B36E483390; Thu, 11 Sep 2025 14:34:12 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D27D683327
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 14:34:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4cMxnY44Rgz9tTX;
 Thu, 11 Sep 2025 14:34:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1757594049;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3t6D+KEAzaq3QoZ8HX/w1MSBpwKv+353edf3dD1ok68=;
 b=gwRAKT4kAEQ6a6DrgqtR01MlH62nkf+rTcfLvLXnI1ROMK1gnPkvEgf7MCVXi1kbg0b1LF
 CLkiwUpZ6Ap4oOBh5dQcN9/O8C3ZvPRDwzY2swtJZhfbnJf4sZUrfN0En3ciixVF4c0Dao
 l8HV+hbZQkaCEDnJ6enhyPmt8ZIKzkpbszj1KE9pdviDqSpCfe+ZSjeXBsXdPrcvLAjZxY
 xoEpD7Uj6wEtQ5eRZXgcHu1lIwaEpa2cW4wRexmg/s+MY4j3bP5k6maA6yHe5g1CoPcF8U
 3WtYGDiCkdHfKbHOWJCREE52ydRX7noqkNye1M+SqYjbTDxLl1BTtYC6BUnHHg==
Message-ID: <99873b46-8a48-47da-9337-d5ceb2816331@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1757594047;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3t6D+KEAzaq3QoZ8HX/w1MSBpwKv+353edf3dD1ok68=;
 b=rkV4egElONs3YE+dI5W8ezhZEdJDaYrmAWF/+G7sSGOIFbAoV7LfMjphgKqYX1Cj/eSrqM
 EwX7xkC2naAF+dCp5mgkZc/tuFLT1qfyBtqDttUfpJcNNYT0sQSzUDn6hUvTShaXBA7zWu
 vo/KXbMrCVOBvWgzXGunYeMfb5H7uak25rEuxqGeFazvl6C4lnfdTWeT0FMjdu8jH96n90
 v87wHDfM3CyncPzQAjNRkiwjAu3vPnlN/8L+XJYxt1ooUUNw1wHGEYFrD0FYryzraSSuqu
 8CqSG1T+zf5cfJ69ht/GdMfejhBgiWONkp5Gfx+748mSHYQbynjq9wIz+Gxf+g==
Date: Thu, 11 Sep 2025 14:34:03 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] env: fix config dependency for
 ENV_OFFSET_REDUND_RELATIVE_END
To: Heiko Thiery <heiko.thiery@gmail.com>, u-boot@lists.denx.de
Cc: Joe Hershberger <joe.hershberger@ni.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Christian Marangi <ansuelsmth@gmail.com>, Michal Simek
 <michal.simek@amd.com>, Michael Walle <mwalle@kernel.org>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>
References: <20250911093223.65323-1-heiko.thiery@gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20250911093223.65323-1-heiko.thiery@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: f9186af7ccbe9393040
X-MBO-RS-META: hzkrwzzphs5zuinwka8aro4x7n6n14ag
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

On 9/11/25 11:32 AM, Heiko Thiery wrote:
> Since commit 5fb88fa725 "env: Rename SYS_REDUNDAND_ENVIRONMENT to ENV_REDUNDANT"
> the option SYS_REDUNDAND_ENVIRONMENT is no longer available and should be
> renamed to ENV_REDUNDANT.
> 
> Cc: Marek Vasut <marek.vasut@mailbox.org>
> Signed-off-by: Heiko Thiery <heiko.thiery@gmail.com>
Thanks for spotting this.

Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
