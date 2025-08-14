Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07837CA0EDC
	for <u-boot@archiver.kernel.org>; Thu, 14 Aug 2025 10:39:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA23483865;
	Thu, 14 Aug 2025 12:39:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="l7k1MHYV";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="VjgPQbqv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D53E8386D; Thu, 14 Aug 2025 12:39:03 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8265783855
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 12:39:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4c2hYc1wsPz9sqf;
 Thu, 14 Aug 2025 12:39:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1755167940;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nsNlsHpVNvmEmj4c7d4O3ZQez3/FMCjGBXsM2bTIvTg=;
 b=l7k1MHYV2mYx5h/E4gOxl/bVQ+NsaHjryqlC0xQuaR/jIMmP61HQHXtikzfocZF36jieBR
 WyW1r2WX2vmv+jSxq/0EG4/0hZ2BzD/OZEsVNfyq+XGRfUiMWGH8MZKGb1eoWIcvidpw7m
 /nJESC+KwB+VcjeMYS3xHnq3NhRKKvFzQCrE7/eKIKiI1qQUFMf6PFlcXOrZPJ4mFhcX1B
 o9Zy17dY5PEllv+01oIQdolvpqPEJb28pzTWgokk4MExzfb0yiKbTLLkLJ12+RcaXDbwu/
 4JXZ/EkE8Fe6V7CdlJmk/A0onuXAKR7IspzcUMZc+Ca2gawWvfhOEKgaCOiW8Q==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=VjgPQbqv;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <c2816793-b8dd-497e-b967-3c5f70d87323@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1755167938;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nsNlsHpVNvmEmj4c7d4O3ZQez3/FMCjGBXsM2bTIvTg=;
 b=VjgPQbqvhhAvjPVQrBOCn6+oilMe1tX4gFpb1To+q5yrlJjUeHbppuFJX2qoAQIZ+YC82F
 Wu0TvOJzcqZ5ujzE4fYSn/oM1t3QK/9PTmVJI4fpMrn50jpwblNid5ofZwpYU3YiED9flX
 +00MvIQwvTRZ0ATobt2pGlGXCAgs5wzk8R1p4BcaRZl45vBuFSND1BCyR/L8BghZMSOTV8
 SEnm/wfC46UiWbhFaNAK0kzW0k9J8X7UvBNPEMB8vXrZEa0Ei28gfeytqOv6jGVKkk9mNG
 1ENK4gwsM0BLp8rswrdmKDdrNFmvCj6anOZYLzjnSVIO8ww6azJ9kVBY4TFG6Q==
Date: Thu, 14 Aug 2025 12:38:55 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] configs: stm32mp25: Enable OF_UPSTREAM_BUILD_VENDOR
To: Patrice Chotard <patrice.chotard@foss.st.com>, u-boot@lists.denx.de
Cc: Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>,
 Cheick Traore <cheick.traore@foss.st.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
References: <20250814094116.1351454-1-patrice.chotard@foss.st.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20250814094116.1351454-1-patrice.chotard@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: bwfedyk8s5rzyc58znr5148ofmoam953
X-MBO-RS-ID: 8cae7696c1f5d341a05
X-Rspamd-Queue-Id: 4c2hYc1wsPz9sqf
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

On 8/14/25 11:41 AM, Patrice Chotard wrote:
> Enable OF_UPSTREAM_BUILD_VENDOR and set OF_UPSTREAM_VENDOR.
Because ... why ?

What kind of sloppy commit message is this, you surely do know how to 
write a better one .
