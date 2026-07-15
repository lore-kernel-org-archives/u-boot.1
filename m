Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFCD7C44501
	for <u-boot@archiver.kernel.org>; Wed, 15 Jul 2026 16:22:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E92F84B6A;
	Wed, 15 Jul 2026 18:22:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="MziVBBZ5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F70C84B86; Wed, 15 Jul 2026 18:22:20 +0200 (CEST)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43AB284B49;
 Wed, 15 Jul 2026 18:22:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marex@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 216DF112A0E; Wed, 15 Jul 2026 18:22:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1784132537;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=CMMBfUnEthU0jotd50knMD2elDmmUprUFJHSf7ztX7U=;
 b=MziVBBZ5H/EezS8BO48sRSBAq/oAyV4HNfbO0a0r88K69QGz/UWV+7/HK8emuoo183d0ae
 JSeRjYreODB6y3InZm32MagyLslBNTObV0fcJ1TQyBXZfD9awqh4JF7nYQmzy7VRremlv1
 01AYr2+b5wB0dQ+6JtA4IXIzKKp7KlfyyCjy/prqczkkW7+frOcJmzsFuzHEmajowOVnuL
 yadk7b09kXxPT/l3xHsnPh62YJtnOjNlK6CPSHTPeKeXMweETTLVNqGUMAlzdqyjGNjXUG
 RV7X29WWxQ0qAB05ym+lcDfQjQA4nMk4eXsO78sVz/M/p/L0LLOd3qOfX3ja4g==
Message-ID: <a68ee92c-48b6-470a-be97-1110f3ea5abe@nabladev.com>
Date: Wed, 15 Jul 2026 18:22:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [ANN] Updating branching scheme to use "main"
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: u-boot-board-maintainers@lists.denx.de, u-boot-custodians@lists.denx.de
References: <20260708161945.GU749385@bill-the-cat>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <20260708161945.GU749385@bill-the-cat>
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

On 7/8/26 6:19 PM, Tom Rini wrote:

Hello Tom,

> As part of migrating from source.denx.de and over to
> git.u-boot-project.org, I think it's time to change the branching scheme
> from master or next to main or next. Since we'll be changing the URLs, I
> don't think we need to (and I'm not sure we can automatically) have a
> period where both exist. Thanks!
It would be helpful for legacy build system integrations to keep the 
'master' branch around and mark it as "protected" or some such, so it 
cannot be updated after certain cutoff point.

OE fetcher for example checks whether a specific commit SHA exists on a 
branch unless that is inhibited via 'nobranch=1'.

It was suggested that the 'master' branch can be pushed with commits up 
to v2026.07 release, and then stop being updated, while the 'main' 
branch will be updated going forward. I think this would cover all the 
old build system integrations without causing them too much breakage.

For example gstreamer kept the old 'master' branch around, stopped 
updating it, and then kept updating the 'main' branch going forward, 
which to me seems like the optimal compromise:

https://gitlab.freedesktop.org/gstreamer/gstreamer/-/tree/master?ref_type=heads
