Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8172CCA0EC0
	for <u-boot@archiver.kernel.org>; Mon, 11 Aug 2025 08:50:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF43483330;
	Mon, 11 Aug 2025 10:50:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1754902221;
	bh=TYUgq8aAzvKqvjK0tXRI2hWUsjN5xcV/xczxjHQt9R0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UW2PqN6W2aO8RqPYwZah4VF0589uB4qgRuWu76Y+bkI27yAsSgBzh8Bnu04dIgf7N
	 iysx5dqPlWKFYvImsYVNN7iv/KKvtHroG5Fv0VbsTng8V835+YU9i8AlcIJ3ErYOZ7
	 tlQ+PLTbQPLGpP0NI2R3JifcehCbw/t1QOw7PHpsCNzDDIXoKVZHH2B7gVi5uAUQy6
	 11ZD13VJD3dWx9VBgnsnHohRB3tUWR79mR+rRWM3F/KURicHvih7gCwZUF7mHQuSDd
	 qDPUAMUBpRXFsgaSsQDOx08Yqoso5yUiwkk3YLwL80SMwZLm0586RbvMImPENX1Sxd
	 wM+jDx+d2nXFQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C84E83335; Mon, 11 Aug 2025 10:50:20 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2CEE783323
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 10:50:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=pro@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="FLxjug8y"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id D4BCC1038C11C; 
 Mon, 11 Aug 2025 10:50:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1754902217; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 in-reply-to:references; bh=TYUgq8aAzvKqvjK0tXRI2hWUsjN5xcV/xczxjHQt9R0=;
 b=FLxjug8y6QNOQzVCrLo8GOLnADkFak9ZXL95/nrKCkhepdtxwFXRrtWocB5vdz47Q4fTKx
 kxUeIA+Ckzmdrpuwviq6YuRc77Go8ivlrwbSIWEwAFZGaGhZWI1WJ/NDrma6dxkZRrp8oW
 hAy3tElvdKt3SnMkY3t6VXzDtzIvnJpDVHwotJCJ05iXMtc+5nRJElZsG9HExbSOnx3ej4
 bKQ5E4VoErQAr+2r2tGz6SIPqJmNhqFLaW2bEdIYWbsHSXHVcasGbuea757i4W1TCwkyx3
 OX74BT8ec4QP6+qx5GRKzhaio+Ws1bxMAdeQuto/bfdqsnBgpCWdZhjrJp3UHg==
Date: Mon, 11 Aug 2025 10:50:14 +0200
From: Philip Oberfichtner <pro@denx.de>
To: Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut@mailbox.org>, u-boot@lists.denx.de,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michael Walle <michael@walle.cc>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH v2 1/3] Image size checks: Remove HAS_BOARD_SIZE_LIMIT
Message-ID: <aJmuxlTEFT4R7HR_@antares>
References: <20250807102436.452691-1-pro@denx.de>
 <20250807102436.452691-2-pro@denx.de>
 <eac8672f-e90b-42e9-9efd-d94fcc8c1f17@mailbox.org>
 <20250807162115.GZ124814@bill-the-cat>
 <06dd9037-af3d-48a3-974e-80db481c7121@mailbox.org>
 <20250807201142.GC124814@bill-the-cat>
 <4813ce12-ad82-4170-999c-e5f816a42708@mailbox.org>
 <20250807232421.GD124814@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250807232421.GD124814@bill-the-cat>
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

On Thu, Aug 07, 2025 at 05:24:21PM -0600, Tom Rini wrote:
> On Fri, Aug 08, 2025 at 01:15:45AM +0200, Marek Vasut wrote:
> > On 8/7/25 10:11 PM, Tom Rini wrote:
> > > On Thu, Aug 07, 2025 at 09:41:34PM +0200, Marek Vasut wrote:
> > > > On 8/7/25 6:21 PM, Tom Rini wrote:
> > > > > On Thu, Aug 07, 2025 at 03:41:38PM +0200, Marek Vasut wrote:
> > > > > > On 8/7/25 12:24 PM, Philip Oberfichtner wrote:
> > > > > > > CONFIG_HAS_BOARD_SIZE_LIMIT is obsolete, if we interpret the value
> > > > > > > "zero" as "unlimited".
> > > > > > 
> > > > > > This sentence makes no sense. Is the variable not obsolete if its value is
> > > > > > non-zero ?
> > > > > 
> > > > > This is phrased oddly, yes. How about:
> > > > > By making the code treat a size limit of 0 as unlimited we no longer
> > > > > need to guard asking about having a size limit on the platform.
> > > > 
> > > > 0 shouldn't mean unlimited, that is just fragile ...
> > > 
> > > That's a standard unix thing? ulimit -c 0 is unlimited.
> > 
> > This is a really bad argument, because then the counter-argument is, that
> > size = 0 is also a valid size and it shouldn't be conflated with SIZE_LIMIT
> > validity.
> > 
> > My take on this is, don't conflate size-limit "enabled/disabled" with
> > size-limit "value" , these are two separate config options. Mixing them is
> > not helping.
> 
> I still think it's fine, but it's not worth arguing further over, and we
> can just make sure to gate all of the symbols rather than 0-is-disabled.

The idea of treating a size limit of zero as unlimited has been common
practice in mainline U-Boot since 2019, where CONFIG_SPL_SIZE_LIMIT has
been introduced. The same logic has later been applied to TPL and VPL
size limits.

If we want to consistently stick to the HAS_*_SIZE_LIMIT approach, we'd
have to introduce four extra Kconfig options alongside
HAS_BOARD_SIZE_LIMIT:

	CONFIG_HAS_UBOOT_WITH_SPL_SIZE_LIMIT
	CONFIG_HAS_SPL_SIZE_LIMIT
	CONFIG_HAS_TPL_SIZE_LIMIT
	CONFIG_HAS_VPL_SIZE_LIMIT


Furthermore, the extra lines of code in the toplevel Makefile, which
could otherwise be removed:

	ifneq ($(CONFIG_BOARD_SIZE_LIMIT),)
	BOARD_SIZE_CHECK= @ $(call size_check,$@,$(CONFIG_BOARD_SIZE_LIMIT))
	else
	BOARD_SIZE_CHECK =
	endif

	ifneq ($(CONFIG_HAS_UBOOT_WITH_SPL_SIZE_LIMIT),0x0)
	UBOOT_WITH_SPL_SIZE_CHECK = @$(call size_check,$@,$(CONFIG_UBOOT_WITH_SPL_SIZE_LIMIT)
	else
	UBOOT_WITH_SPL_SIZE_CHECK =
	endif

	ifneq ($(CONFIG_SPL_SIZE_LIMIT),0x0)
	SPL_SIZE_CHECK = @$(call size_check,$@,$$(tools/spl_size_limit))
	else
	SPL_SIZE_CHECK =
	endif

	ifneq ($(CONFIG_TPL_SIZE_LIMIT),0x0)
	TPL_SIZE_CHECK = @$(call size_check,$@,$(CONFIG_TPL_SIZE_LIMIT))
	else
	TPL_SIZE_CHECK =
	endif

	ifneq ($(CONFIG_VPL_SIZE_LIMIT),0x0)
	VPL_SIZE_CHECK = @$(call size_check,$@,$(CONFIG_VPL_SIZE_LIMIT))
	else
	VPL_SIZE_CHECK =
	endif


Is it really worth adding this much of extra code?


Best regards,
Philip



> 
> -- 
> Tom



-- 
=====================================================================
DENX Software Engineering GmbH,
Managing Director: Johanna Denk, Tabea Lutz
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
=====================================================================
