Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0EABCA0EFA
	for <u-boot@archiver.kernel.org>; Mon, 25 Aug 2025 08:59:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4254B81E13;
	Mon, 25 Aug 2025 10:59:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1756112360;
	bh=1J6ZwnUI3UT8Y5pvNJHgIXFnlvRe71EpUpV+psUGiAw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=C+xdnCYTX64BXMGsPXOuQWFTtuQrFf9d3H5fc8BwvQKCJCWl7FvhyRCrdswidVun/
	 drJlmB5JjSuBiVpfACHuScJYGf6swDFHj5Af6tkuCsDNuDFAJk4m5bgL3xw1Ac56jN
	 88N3qhs0JgsYKgPKuE7W+omGhhW4vOEmz2jjXymQvjjvzzvJjnq7zpE4BjiF9rNMzB
	 BOrA2ZBnQ2CmtJ5y/DgbRO8q/pcpm68nGEIwxT9UDc9g3Q+ZdoDTLbQB6Uq9tg84zQ
	 Ssrq7MvQ9bmlax2SPKLvuFKuFFAwkNaQYKOgVCyMQrzBxWf0DUFshQBcbhB4ey0sbf
	 ZrV3Y9ON3/5Lw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF1D5828A2; Mon, 25 Aug 2025 10:59:18 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78C71808AF
 for <u-boot@lists.denx.de>; Mon, 25 Aug 2025 10:59:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=pro@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="hYVYg37Y"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id ED98C1038C102; 
 Mon, 25 Aug 2025 10:59:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1756112354; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 in-reply-to:references; bh=1J6ZwnUI3UT8Y5pvNJHgIXFnlvRe71EpUpV+psUGiAw=;
 b=hYVYg37Yr6sgN/mkb6XRvZrAdcX5y4MhzVspAmCd1BWy3bjw7LPyQ2otA4bQw1CyQ38+sy
 pR3/5o94uC46t8U/kp65nLbmh+I3dK0VrLCTlfTolQHP5C0O9DUnOxi2yKFKtBk+/sMM2Y
 D9gOiEVErecVCTRdkR0JAYlBM/4RgA7Cx7LQrZ/44HUpKtbEwpuASB7Oa+g+bRidRPbCVZ
 /vl+YtZKul7ZpI+eJ8S37/nsNwvaLNy3Au9zY6Fb2QQQWR56SVYAyLIy8Hm7doIVykxuuj
 9BTyhbtAnNTbPM5kHS2Hzvi3/znSjR88e24QzweUc2z9Egqz7HRtvuCOU2JaOg==
Date: Mon, 25 Aug 2025 10:59:09 +0200
From: Philip Oberfichtner <pro@denx.de>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michael Walle <michael@walle.cc>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH v2 1/3] Image size checks: Remove HAS_BOARD_SIZE_LIMIT
Message-ID: <aKwl3eTg44aL7uy0@antares>
References: <20250807102436.452691-1-pro@denx.de>
 <20250807102436.452691-2-pro@denx.de>
 <eac8672f-e90b-42e9-9efd-d94fcc8c1f17@mailbox.org>
 <20250807162115.GZ124814@bill-the-cat>
 <06dd9037-af3d-48a3-974e-80db481c7121@mailbox.org>
 <20250807201142.GC124814@bill-the-cat>
 <4813ce12-ad82-4170-999c-e5f816a42708@mailbox.org>
 <20250807232421.GD124814@bill-the-cat> <aJmuxlTEFT4R7HR_@antares>
 <aKLylfvzdfebJRWe@antares>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKLylfvzdfebJRWe@antares>
X-Last-TLS-Session-Version: TLSv1.3
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

On Mon, Aug 18, 2025 at 11:30:02AM +0200, Philip Oberfichtner wrote:
> On Mon, Aug 11, 2025 at 10:50:17AM +0200, Philip Oberfichtner wrote:
<...>
> > 
> > Is it really worth adding this much of extra code?
> 
> Ping @Marek: So are you in favor of this surplus of code?


Hi Marek,

You criticised the patch in its current form. Nevertheless, I'm left in
the dark which outcome you would approve of.

If I'm not missing out on something, we have three options:

(a) Use the value zero to disable size limits, as this series proposes
(b) Use XXX_HAS_SIZE_LIMIT consistently, implying a lot of extra code
(c) Maintain the status quo, which is 80% of (a) and 20% of (b)


I'd like to bring this thing to an end, finally. So could you please
position yourself?

Best regards,
Philip
