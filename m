Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7EFAD1356F
	for <u-boot@archiver.kernel.org>; Sun, 27 Oct 2024 16:32:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E086889072;
	Sun, 27 Oct 2024 17:32:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Na4448V7";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="N4EvWLRK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 564CF88F70; Sun, 27 Oct 2024 17:32:12 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6726988F75
 for <u-boot@lists.denx.de>; Sun, 27 Oct 2024 17:32:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4Xc29H1GrVz9stG;
 Sun, 27 Oct 2024 17:32:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1730046723;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DznLahB5tJyZ3PXt9cYMAdw3Kfxw5U25vIM84wr+rhs=;
 b=Na4448V7qgX2geFz3TFLrhGIehfBA58fgvNQhqaN4h4AFG85TZ8tsYqNgKDDzRXXLjsdwt
 YrZGq0Z8sWzYqY8C/DuFvP+vgHZH/kPoRMCGjwwqN630POLejtQjlTUZNc3Kk1ezWySs3L
 /JRvOGvQ3wfL6LMPJ730l/hqwEwtbb6egg0qavgXqGoEmToTjaGQ0FCdpXcKLCtROv6J4o
 rLne1zGckyQ4Gh8UFUI+11Yx5ApdPYGfXsffqWyNzWEiNzpI4B2jO1nPTy+9CBWvHwX11t
 QPOYUnmXuks2g4lYpkHouXzrvlnPm94w53dL/1ho80vtumAJMnaoXs42vaPgOw==
Message-ID: <03c1c8e0-c382-4d0e-b422-94432918e0c3@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1730046721;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DznLahB5tJyZ3PXt9cYMAdw3Kfxw5U25vIM84wr+rhs=;
 b=N4EvWLRKxDGR/GRLvItvlKI7qGrGRlAXGWZ3dP37T9BGK2vTxsvp4C95IM3lKMlL3aESGd
 VzuZ9qZSbx7hREIsdG97CD6o1QnL5Pg/2FgESRdvgMNbMK+3W7IFuTW95kPiN8mCIx6Agr
 nrDupgCufsY0drj0D1ztmzaUgxqZan5OBTYCXrk4ZGCrsFU90Qwob0wonxR3YaD+MSvd+s
 SfMfHExyvIB4Pfq6xOU7DsSWhBd20CWkdTpd7LBPZozoXFPY0Dm48oJsfuHyCq0WhWmhxi
 vL6jOvhBsHdDhbvqm0T2ztIIwH+jX/qHMxMukPlcEJKdyPz3bkkOYMYy+V9DHg==
Date: Sun, 27 Oct 2024 17:17:12 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 05/14] net: phy: Port set/clear bits from Linux
To: Paul Barker <paul.barker.ct@bp.renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de
References: <20241024152448.102-1-paul.barker.ct@bp.renesas.com>
 <20241024152448.102-6-paul.barker.ct@bp.renesas.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20241024152448.102-6-paul.barker.ct@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: fz44kw1cenugkzzeghb4ihbaxjxigygx
X-MBO-RS-ID: 9a8df24120d89c57914
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
> To simply porting phy drivers from Linux to U-Boot, define
> phy_set_bits() and phy_clear_bits() functions with a similar API to
> those used in Linux.
> 
> The U-Boot versions of these functions include the `devad` argument
> which is not present in the Linux versions, to keep them aligned with
> the other phy functions in U-Boot.
> 
> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
