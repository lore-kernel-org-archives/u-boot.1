Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFC7BD1356D
	for <u-boot@archiver.kernel.org>; Sun, 27 Oct 2024 16:32:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7684988C10;
	Sun, 27 Oct 2024 17:32:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="moHjizkN";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="XfiOAuPI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5DB3189083; Sun, 27 Oct 2024 17:32:10 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3676188F31
 for <u-boot@lists.denx.de>; Sun, 27 Oct 2024 17:31:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4Xc2996kdyz9sWY;
 Sun, 27 Oct 2024 17:31:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1730046718;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZWxlTt1+Lx9wKZFESC1eVJAgLEU5jQoFe+Q0Dvbft08=;
 b=moHjizkNIfZIdXlMTnlJag2Qwl8OrIJSdaEpBnuNkYacYQeqATt64JK8l30yQGAVYRpIXr
 P7pWs8PBFPKfxJS5Hfh74jvsYbath8Gkwtj6BBPDHRpFptRqXCND+SUV2DvRrOkMWHr2g2
 /cv7RILiH9aT5ej170i8M9XA0OI5rY5qOnEfVTbi2eaR1PNnHrI05VvX4z9OjMfp1WREgT
 iXIqR/dj8S/erk2OT5dfJR80fw0YY9xFOTgZt6/wehVZ2EAKmqGtu5nraemtXCcz4TX0gg
 KqCi+iqJt/IDIt/JXi2MELUvFP65m/IpAoeb3WhG68vU1IkxOqkq5wlDYIT/Fg==
Message-ID: <30ec85e5-6de8-4305-971d-893ea8e1151b@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1730046716;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZWxlTt1+Lx9wKZFESC1eVJAgLEU5jQoFe+Q0Dvbft08=;
 b=XfiOAuPIB5z5lhzU4mrWlUuJ/OR4XjiQImKfVecLouaXET3TU6h/uoo1sbNj3ja5F4h0zz
 h9krOjFRL36FkG7t+wonDT7KQ1qTpxxoDLXdTk+xTmI3mdW9bYHI6vYCarcgkGEMg9vjja
 ALaxNFoyhNHRf0M8X69jh65ciq2g5+QOxUwChrfjYHEcOk3EW36fBgE4UvbCvVMZWIpXyG
 LFS5JJfV6iXdC6G2qHDd9H7M80BlYIm/kwvXf/vpQy03f+J/PPv0bGORXR4xXVckY2MP4B
 +gWbZu1KlBZ2u9sw1jj7/5pddfBgyZadWxTdRL642MpTb/teWtD9WsoAoXXLRQ==
Date: Sun, 27 Oct 2024 17:14:33 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 02/14] pinctrl: rzg2l: Support 2.5V PVDD for Ethernet
 interfaces
To: Paul Barker <paul.barker.ct@bp.renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de
References: <20241024152448.102-1-paul.barker.ct@bp.renesas.com>
 <20241024152448.102-3-paul.barker.ct@bp.renesas.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20241024152448.102-3-paul.barker.ct@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: pcuw6krumjequr9cbg7bctie9dn6o1xq
X-MBO-RS-ID: 12a5968d739bb4b4da6
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

On 10/24/24 5:24 PM, Paul Barker wrote:
> The Ethenet interfaces on the Renesas RZ/G2L SoC family can operate at
> multiple power supply voltages: 3.3V (default value), 2.5V and 1.8V.
> 
> rzg2l_pinconf_set() is extended to support the 2.5V setting, with a
> check to ensure this is only used on Ethernet interfaces as it is not
> supported on the SD & QSPI interfaces.
> 
> While we're modifying rzg2l_pinconf_set(), drop the unnecessary default
> value for pwr_reg as it is set in every branch of the following if
> condition.
> 
> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
Is this ported from Linux ? If so, please include the Linux kernel 
commit in the commit message, else ignore this comment.
