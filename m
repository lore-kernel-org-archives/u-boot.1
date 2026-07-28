Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 943BEC54F4C
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 12:07:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 54F35407A8;
	Tue, 28 Jul 2026 12:07:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xGZHx5F4DIFW; Tue, 28 Jul 2026 12:07:32 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8969C4099F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785240452;
	bh=EzYEBsDyC1/tN6JbRmcpFzrV752M7sBAMJmEPCZdIJc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UFZMjo66jL0HR9Uii+XCsJnHj2pZJjQbYctZ1C2JrpZ5ZCI6Tz5FwIHyCRS0wZ4JI
	 dSnfSCMctQ0HTXkJjsFRiH4dpXD4so24PVHyLvEEKIEcSGb7V/b2/PBUyB67lVPHLZ
	 jo5R+Sz4eZ9VBlCFuJMzXJ0pTsHpaO5aPMVO/kw+qEahmBzn3yjUCRP4I16oepryaf
	 yj/bj7dgxYXxMNNUtO+bwztlh6kE/ncwxGlZHoUmHQV2Pv8QcaQxcyM5tR6nI7ZUKV
	 pjTZXE1+TNp4ssxZyoNFjk3uovGXuxa1Zhxn1ojCVMOEdATcSDBPSd7LUpD2tORNsY
	 +DkZDAoDg/qGQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8969C4099F;
	Tue, 28 Jul 2026 12:07:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id A0CFF350
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 12:07:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8214A407A8
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 12:07:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LO2Z2UYeY1n7 for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 12:07:29 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::534; helo=mail-ed1-x534.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org BDE7140990
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BDE7140990
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BDE7140990
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 12:07:28 +0000 (UTC)
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-69f7af97316so6032719a12.0
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 05:07:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785240446; cv=none;
 d=google.com; s=arc-20260327;
 b=X2zIGiOPNcEQGmJrAdOUDpBZZLaEWmN8n2+xhwY0nFZEB5ab39V2mC+9YRVgqt6K//
 XR0Av567Fzoa9dLtcApkec9lz3D8Osw4ZhDSAdbBBktMlrX721LulL7JGGKH7xKTFZYo
 YluIsfA51j+zUQGLXrWaZIGFrF3YdOL7/sVmOXB6Nu5mnb0jtuklKRrl9rqrJklbsbnd
 4O/h46LS1Qu+lF39Dcq4SPeJ557zQlNrkB413XjG8/CUqTlp4IqV38na+li7UT/x+NZH
 vZ5hop+7Aagi2jzpBw/yVsmtHSPIvo0hljsZ+12jLhri65IkxR4h3LtmqV2RBaANLLxY
 9RVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=EzYEBsDyC1/tN6JbRmcpFzrV752M7sBAMJmEPCZdIJc=;
 fh=qpl1R5oyLDHrYwZo56n7zf1ddBj2+zYDxUllAj6kB/g=;
 b=Z1P84g6dFwldqyh7mjuI/HUR1VW0wNvOQemI7guhS3G1tQ04ijbztMp5AhXMP9HXzt
 IcZeSOnpQWd0YzF5qR5gWCEiOMtnRWeZFaz2BPELcEuiobHVWuMGCqnOtxBBK9Gb9Rtc
 tSlCp0YgrLHhxBdfjpN51W9F7g9GoORcHWlxTuMM0MdEK4QLaQza7F8o+j1eg52U0XZb
 uMK7KBAyiWCTvSZ6fAgIUMN+3d0LJWK/BqnIeWkvWYSCkp9zcabYZfI/1HU2o726BROK
 J7rtVE5/gidPg+Wg7bmdE3LVVg3DVsGVpx+JzTBIiK3SJp9n0YUUsNIg+lFt3QO4QZhH
 sR+A==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785240446; x=1785845246;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=EzYEBsDyC1/tN6JbRmcpFzrV752M7sBAMJmEPCZdIJc=;
 b=oNnY2/tvujZiBnj6Ut+8LMWq+17ldOJQ0YUXw5QqHM8+4E06riUXCQkW6RDWCtm9uv
 +K5pg6xMy9hUTG4cRSR8VeiTG6A+p9jYR82ztbJ93ZkNvj9LFzLty5lGh6K3XF8/1neg
 bh4B73vKEO3ylPs6k1yfgvPhGkBUYO52axnetk3jeACdT28L4TNYuqx8wWAS4eelTlzA
 0TSfsHUk3pjnM0MGh5da2DqkO4NkxGdE8mls3oAgZw4sI3crVqUFq76cLygdjFwIWQX6
 vTApTGla5g1HAeDoztCtJv6Eqdto/ZPImdpiYbsyNnfxdVlUU/ur0qVih5rlmAB0vWbP
 oXzg==
X-Gm-Message-State: AOJu0Yz264ELKXSAYFCsJNR8eB2ZyY5ihzj8ORqrZnZyPwoXzJlVqZzV
 A2ljO7Eyz9vuFrRyjj9rXI59ExingTv4FTxhGxwxlat6wMYFV50QP3hqvHGjxgtpKm5+NC88lcy
 Idm7NobFM2IxCXE0KKDKWzS4QzEXUrVpNwMkFEnAq
X-Gm-Gg: AR+sD13P9Yl7txv8dRnRO8QJ6eHYyt3q4M+1S+igjn7FTD5Hhgh7+pT2wC1VyOcP0ED
 XTFKfytSs2MCGTl59qxlT8z7QYfuDUud9ksodmSxKi2FsD24njw1tWeS/XAzQJwL/4OJHFdEw01
 BWEMT1SX2JjGu+qZqbGLHfwYZw/wtNhEJ7JhA3YwqWzk8rWb8Q1Kxl9Ty4mzeK3DuT8VEAxzRzU
 TOaUw83dz3+2uBPL651hNy/49obsH3WR47at43gBniFY9FVRT34YSwaKphf
X-Received: by 2002:a05:6402:5205:b0:69c:7406:9492 with SMTP id
 4fb4d7f45d1cf-6a034a8b3camr1098530a12.39.1785240446420; Tue, 28 Jul 2026
 05:07:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260723005203.36715-1-dmukhin@ford.com>
In-Reply-To: <20260723005203.36715-1-dmukhin@ford.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 28 Jul 2026 06:07:13 -0600
X-Gm-Features: AUfX_mz4sCMyCop4t76qwz-WNOf9Iwcut_xPfQPcsCrGNaxwHm7jsevbSoGxCdk
Message-ID: <CAFLszTiJY52v3rnEQG=mLSgKEK4N7emCV5v_g4WS4ifJji6Cnw@mail.gmail.com>
Subject: Re: [PATCH v2] x86: add support for CONFIG_REMAKE_ELF
To: dmukhin@ford.com
Cc: u-boot@lists.u-boot-project.org, sjg@chromium.org, trini@konsulko.com
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785240446; x=1785845246;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EzYEBsDyC1/tN6JbRmcpFzrV752M7sBAMJmEPCZdIJc=;
 b=YGxyDUM1/tkqwOmlRES87I0RfTA4pdxXJDOpWhf6CSGOgmeOmCyROJjpQNwa1RSHE2
 JoOYX8gUcaLYiiR7UiiRNpPCIzuSYF1wwj7SCE02spQbb4tJkWyv3deTsyljW2PKLMH8
 53bNhiQZ2599ybPLYc8QR+fWklzB2kHSnzgN4=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=YGxyDUM1
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 2026-07-23T00:52:03, Jamie.Gibbons--- via U-Boot
<u-boot@lists.u-boot-project.org> wrote:
> x86: add support for CONFIG_REMAKE_ELF
>
> x86 builds with CONFIG_REMAKE_ELF fail as the following:
> ...
> u-boot-elf.o: file not recognized: file format not recognized
> ...
>
> Fix objcopy/ld parameters for x86 to enable CONFIG_REMAKE_ELF
> configurations in both SPL and U-Boot proper builds.
>
> Add a new 'PLATFORM_ELFLDFLAGS' make variable for injecting
> proper linker arguments when u-boot.elf is requested.
>
> Signed-off-by: Denis Mukhin <dmukhin@ford.com>
>
> Makefile           | 2 ++
>  arch/x86/config.mk | 3 +++
>  2 files changed, 5 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
