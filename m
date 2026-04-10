Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36049F36B97
	for <u-boot@archiver.kernel.org>; Fri, 10 Apr 2026 01:22:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 973CA83DC9;
	Fri, 10 Apr 2026 03:22:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="oMnPyXd6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3541484099; Fri, 10 Apr 2026 03:22:05 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A206B83CF5
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 03:22:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4fsJtb5r2qz9twJ;
 Fri, 10 Apr 2026 03:21:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1775784119;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=giqWb/Mtz6INGN14A1FDkznyyfKmS5u5jX+1iT2Cn7Q=;
 b=oMnPyXd6G92v939076GRrj/kyb4CQwdeqPGjsBIuzWEBVZYWXZZxQsbP3IZJ0SU2IccujI
 zgGqRDO+z/HPUE5dtyT/XvLPYpd5S9zROLEXqIRXwgnaPFQnO1GcKSlijyT5IVb7LnAbib
 XGZH1ou28dgsvjqA+4xvAVFuicKXHw+hdPiluvZWOyLjQsFVypf3GdvH6ZVLJxDlyN8RG0
 9eXWfhdau2EbBqVsO/D30ZKVn9+xzxxlnejZIPB5phJ2wqt9dXSdCn1LTz5yPNIaHK0p+G
 X9gsFeiDGeprd0xq6UzqZZkYKyXzs9guW7K2P5wVqFQVbkR0s4WlcliadapMRg==
Message-ID: <8b382ec3-7c57-4f67-b46f-daa4fe6fba0a@mailbox.org>
Date: Fri, 10 Apr 2026 03:21:57 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] ufs: core: Fix heap corruption due to out of bounds write
To: u-boot@lists.denx.de
Cc: Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Julien Stephan <jstephan@baylibre.com>, Michal Simek <michal.simek@amd.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Padmarao Begari <padmarao.begari@amd.com>, Tom Rini <trini@konsulko.com>
References: <20260329231151.332108-1-marek.vasut+renesas@mailbox.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260329231151.332108-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 525600ce783f034a6e9
X-MBO-RS-META: tqqknmy4hhemk8dwyi1dnund1tcch943
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

On 3/30/26 1:11 AM, Marek Vasut wrote:
> The ufshcd_read_string_desc() can perform out of bounds write and
> corrupt heap in case the input utf-16 string contains code points
> which convert to anything more than plain 7-bit ASCII string.
> 
> This occurs because utf16_to_utf8(dst, src, size) in U-Boot behaves
> differently than Linux utf16s_to_utf8s(..., maxlen), but the porting
> process did not take that into consideration. The U-Boot variant of
> the function converts up to $size utf-16 fixed-length 16-bit input
> characters into as many 1..4 Byte long variable-length utf-8 output
> characters. That means for 16 Byte input, the output can be up to 64
> Bytes long. The Linux variant converts up utf-16 input into up to
> $maxlen Bytes worth of utf-8 output, but stops at the $maxlen limit.
> That means for 16 Byte input with maxlen=32, the processing will stop
> after writing 32 output Bytes.
> 
> In case of U-Boot, use of utf16_to_utf8() leads to potential corruption
> of data past the $size Bytes and therefore corruption of surrounding
> content on the heap.
> 
> The fix is as simple, allocate buffer that is sufficient to fit the
> utf-8 string. The rest of the code in ufshcd_read_string_desc() does
> correctly limit the buffer to fit into the DMA descriptor afterward.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> NOTE: This is for 2026.04, but please do test it on your hardware too.

It seems this memory corruption bugfix missed 2026.04 ?
