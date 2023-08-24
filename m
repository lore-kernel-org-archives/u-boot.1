Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A30A2C3DA6F
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 03:14:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2AC6C86585;
	Thu, 24 Aug 2023 05:12:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1692846768;
	bh=VV+6KJbcIiX5gz6L7600Pb6EIWyKeAwnsdC6otRTAS8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=b5dIv9XV86EgV5ryVHm8GaI73o9gW94T5fCvj7WIV6L+/Dequ2grz4E0CyQar1LdX
	 Iv8SmsyyKu1eSm5wkNmvhdbpJWdI1wDwCoB2v605FxnmRNTbwMiFMWuE2yTJecVZfL
	 c0l7E9EwoYnng8fx3Q+AOOAkaTdJ+95HGm1hrotIDkzi9UnloCekdw6cdRWBa0AB/q
	 CMy6QnzUlIU3mocx/4p2euUogL5hFAUTcT5p/axXWh/wAzhmRvSWZqYgwc0dezBWUm
	 /D+SnplUHwRV77sQeGEDcq/2l3T4ruu5IlczKw/hVDFHOvTI61iFKr0AvST3VwnKN5
	 zCplIcpO9mmwQ==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 6633D86547;
 Thu, 24 Aug 2023 05:12:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1692846767;
 bh=VV+6KJbcIiX5gz6L7600Pb6EIWyKeAwnsdC6otRTAS8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=mUG3Kr3t8BM4k4m0Tc3th6w7u602t5+yItp/bSix/3b7MQkvJ5eh4rtAcpDPltVDE
 Bha7CstJh5sqiHY7R8jSjMxXIHCft1gRlFekeawYCofIQb4TaIWLUjJGHXg3cvSiyg
 7+51EEaSAh4YFwqzM8qvqyQ7aSG9D19FRItMcUwGGIrSd7bTTy5FdGA9VwsNnFgYdY
 M4CV1i9/Fk3QwME0yfRpI/SDIZp6L5zw6HCYf0Bm/Dk8piDZdcf1/waXQVyxXgtXJZ
 /L0IrHZ9vgxYWziVzAdyd6NEIKr7/dR3oW1qFXC8Jvcqk1SriPiNRjBBhfCg9dxOoK
 kOGrMmzJ+lGNg==
Message-ID: <3ab486b0-be22-48b9-7417-742ed8360f0f@denx.de>
Date: Thu, 24 Aug 2023 05:12:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 6/6] stm32mp15: Use u-boot-spl-stm32.bin instead of
 u-boot-spl.stm32
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Dillon Min <dillon.minfei@gmail.com>,
 Kamil Lulko <kamil.lulko@gmail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Vikas Manocha <vikas.manocha@st.com>, u-boot@dh-electronics.com,
 uboot-stm32@st-md-mailman.stormreply.com
References: <20230824030304.1555547-1-sjg@chromium.org>
 <20230824030304.1555547-7-sjg@chromium.org>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20230824030304.1555547-7-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 8/24/23 05:02, Simon Glass wrote:
> A '.stm32' extension is not allowed anymore, so change it.

Why?

This will likely break a huge amount of scripts, I'm tempted to NAK it 
unless there is a very good reason.
