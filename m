Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9547BC4450F
	for <u-boot@archiver.kernel.org>; Fri, 17 Jul 2026 04:27:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52E3D84D9A;
	Fri, 17 Jul 2026 06:27:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="ClJ2Q11k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3ECE84D9C; Fri, 17 Jul 2026 06:27:42 +0200 (CEST)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF53484D85
 for <u-boot@lists.denx.de>; Fri, 17 Jul 2026 06:27:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marex@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 2D28111A1C9; Fri, 17 Jul 2026 06:27:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1784262460;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=aLCOkVIJgyJIToSS6q4Oar8GrbKjdLUJUBgBlzkSxBc=;
 b=ClJ2Q11komGhHt4jKYveMjh5cdiC+rfMEXFNEeRhK/ytbbi385vwdseluZc/V6ioB89dAb
 wN1xUPNWRDKo10ECD7SQDvStWsOgyGaoRNLmQOKjVlEoZk5eVr5u1Jj00G634MAjmXY5RR
 se9K+8hK+khdrlWsKXBfR4vox6PtWQDNPQOObzuCNhqeUGYN3zRdx/xzwgrGDTZdDzCdWr
 AxsHpFbWv+qhboYCuggvJxI5iBeCwPvjEFPSOGs5G8+CxQtWl8WWz67mQ6KZeXSUnBcojO
 Bl8oejlpNcuRijudk+BurWFGQdYsPqkiTJbrARhrO4DgyJqxOAo030tDN5j6Tg==
Message-ID: <5e143c8a-36db-4e44-b50b-eef29dd85182@nabladev.com>
Date: Thu, 16 Jul 2026 21:22:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Marek Vasut <marex@nabladev.com>
Subject: Re: [PATCH v5 00/75] usb: dwc3: sync code with Linux v6.16
To: Anders Roxell <anders.roxell@linaro.org>, u-boot@lists.denx.de,
 marex@denx.de
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org, trini@konsulko.com, 
 michal.simek@amd.com, alchark@flipper.net, jerome.forissier@arm.com
References: <20260716134305.614278-1-anders.roxell@linaro.org>
Content-Language: en-US
In-Reply-To: <20260716134305.614278-1-anders.roxell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 7/16/26 3:41 PM, Anders Roxell wrote:
> Hi,
> 
> This series syncs the DWC3 USB driver with Linux v6.16.
> 
> The driver was forked from the kernel v3.19-rc1 eleven years ago, in
> commit 85d5e7075f33 ("usb: dwc3: add dwc3 folder from linux kernel to
> u-boot"). After that almost no kernel changes came back to U-Boot.
> 
> I split the work in three steps, so it is easy to follow:
> 
> 1. Restore drivers/usb/dwc3 to a clean v3.19-rc1 state.
> 
> 2. Import the dwc3 directory once per major kernel version, from v3.19
>     up to v6.16. Each commit is a raw snapshot from that kernel.
> 
> 3. Add back the U-Boot glue, the XHCI/UDC updates and the build fixes.
>     This part builds on Jerome's work.
> 
> The import commits are raw kernel snapshots. They do not build on their
> own, only the full series builds. This is on purpose. It makes it easy
> to see what comes from which kernel version, and to compare each import
> with the matching kernel release. The commit messages say this too.
> 
> This is compile-tested only.
> 
> The series needs the dwc2 endpoint fixes from Mattijs [3]. They are
> already on the list and should go in first.
> 
> The branch is also available at [4].
> 
> [1] v4: https://lore.kernel.org/u-boot/20260629084507.3254232-1-jens.wiklander@linaro.org/
> [2] Jerome's adaptation work: https://lore.kernel.org/all/20251121153812.2076440-1-jerome.forissier@linaro.org/
> [3] dwc2 prep: https://lore.kernel.org/all/20260703-usb-prep-dwc3-sync-v1-0-1352bc238c9b@kernel.org/
> [4] https://github.com/roxell/u-boot/tree/usb_dwc3_sync_v5
> 
> v4 -> v5:
> - Split the big "fix build after resync" patch into smaller patches, one
>    per area, so it is easier to review. Marek and Mattijs asked for this.
> - Dropped the Tested-by tags from the import patches. They were only
>    tested as a full series, not one by one.
> - Removed the merge commits from the "import from kernel vN" changelogs.
> - Some small cleanups in the new helpers: dropped a dead function, added
>    a missing NULL check and changed spaces to tabs.
> - Rebased on latest master.

Has all the other feedback provided on the 64 patches in v4 been 
addressed ? I recall the v4 series added various glue code drivers which 
were never even compiled or used ?
