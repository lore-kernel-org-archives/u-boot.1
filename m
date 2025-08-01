Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AABCBC87FCA
	for <u-boot@archiver.kernel.org>; Fri,  1 Aug 2025 14:39:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6CBD83A92;
	Fri,  1 Aug 2025 16:39:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.b="RtW8SFz2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4L22L3zd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 04B4983A94; Fri,  1 Aug 2025 16:39:54 +0200 (CEST)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2FC5C83A8E
 for <u-boot@lists.denx.de>; Fri,  1 Aug 2025 16:39:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=b.spranger@linutronix.de
Date: Fri, 1 Aug 2025 16:43:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1754059190;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=flgkNfZxTjP9WFA3c9MCmQLZ1pZ7CGzGrOn4i1mx0WM=;
 b=RtW8SFz2ShxZyAxKml57CdrTfU/r6f+RuqlVepdkOmszetfdTGzs3oYdz3xsO+EsDbRUmQ
 XPB9J8nuFUVXE9pgyTqDd4ibe7YVZ50jXPXqV0e6OUAI/b4xaRwELQfxNx/y6y+jdUVelN
 oeO0Kee0ZEqkbDQOEbEoVFfOXEpygUpnJSq6zelJaa9gPTx0et1ssRmM+XnV/eV6T5Me91
 juOQPMpAAt/1zDrZ8wT5MpLO9lMyzO/ib3kI94MdaR6gs3OhW1K95KAKZdTcdOOutcBk7G
 2U6zDxwKrV/hzTXxOc1GKRLnvNeczsmPyaecOpaQvbhWrURwTg7VtZSet7WJUA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1754059190;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=flgkNfZxTjP9WFA3c9MCmQLZ1pZ7CGzGrOn4i1mx0WM=;
 b=4L22L3zd3xkcCKq5HTJ8ihX0xVlgSw63Dd9ThFjO+tQ5VG//tbkJ1Ci/0tGcn2om6YhKPh
 03oyQrcGl53m7TCg==
From: Benedikt Spranger <b.spranger@linutronix.de>
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, John Ogness <john.ogness@linutronix.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: Smatch report for ubispl
Message-ID: <20250801164333.1221fa13@mitra>
In-Reply-To: <d34b63c9-4fd1-46fd-a984-a22cc0dd3e0c@linaro.org>
References: <d34b63c9-4fd1-46fd-a984-a22cc0dd3e0c@linaro.org>
Organization: Linutronix GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Fri, 1 Aug 2025 12:42:06 +0100
Andrew Goodbody <andrew.goodbody@linaro.org> wrote:

> Smatch reports the following error.
Fine.

> drivers/mtd/ubispl/ubispl.c:782 ubi_scan_fastmap() error: memcpy()
> 'vh' too small (64 vs 268)
OK. And how does it come to that conclusion?
What config - what extra shebang was used to get here?

> I do not know the code well enough to attempt a fix in this case.
And I have no glasball to get sufficient information...

So please provide more information, what you are doing, what
configuration you use, what is going on behind the scenes.

We are talking mainly about SPL code here. How are you shure that the
suggestion of your tool is correct? Can your tool handle code which
interacts with flat mamory without any memory management?

And last but not least how is UBI_FM_MAX_BLOCKS configured?

Regards
    Benedikt Spranger
