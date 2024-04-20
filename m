Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65CC0C04FFE
	for <u-boot@archiver.kernel.org>; Sat, 20 Apr 2024 23:02:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A98088210;
	Sun, 21 Apr 2024 01:02:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1713654154;
	bh=TR3KwQcDGTd0Q49khG1erjmAIEPnGJzuOj1g5x0nZxM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EE02BHSDVUzjyVdha0ENmET6+nf1Wx0zvCJGTW5oR5Zfwqn5ME10l78pmGzA+ipb2
	 cEMzoRE8zVzlRiHbnz9Xq1Tzxb0RL9Wpsf2jhSWBScvxW8jaWTEjvBVzX+qzA3WxFN
	 Ro7uKSIwrkb4oOyjjSaGBMd2nlnPXgP+EKimwYOcoRHQ9KWf3n58bNLXMLfMT/qHZf
	 s4pbUqcNT+4wyb1JhFMlV5PGXxQz+gmi8ceRXMG5t38Cqxl8wwpzPdHtv7X3y1ZAe0
	 wzDnvJjzwjaXb4zgJUvMnc9EU4mZ51EhCje2Bqc/i2k+igd4D+ZFuXvqKe45obFUY5
	 ddpTmy7n/QYyQ==
Received: from crub (p508b6ab0.dip0.t-ipconnect.de [80.139.106.176])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: agust@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 3FDF3881FB;
 Sun, 21 Apr 2024 01:02:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1713654153;
 bh=TR3KwQcDGTd0Q49khG1erjmAIEPnGJzuOj1g5x0nZxM=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=dkAjYgiwfQFquqJKdI11QiSF8H5X/AOAq1Pld8M8AepvviANSun7P6KHL/L5/mzAj
 aW7fMpwYMI3hBcfGm7P2m/ftKJ50ehQLqClraQFMTzN9xJQO34VjywU2Ao4hv6uhlE
 RER5EH0A9rqmMm+iW4//G6UivS27N7D2vN/F9247Nf/UFlY1FdWtnV+oBjBqYrYO/J
 hwXvb5yeZYdkcWlMXgr3Pte0YeP4lg7Tvo/HAPdBZJscqkmcFmps57yDoV7plPXIH6
 I0VV5gOFrXm16hg+d4S6OgSyr3yyt3IfNxTRxeFp92znxV7mFrISEGqi+fGQxgZ9+B
 pL+pnuBTh94Rg==
Date: Sun, 21 Apr 2024 01:02:12 +0200
From: Anatolij Gustschin <agust@denx.de>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Thierry Reding <treding@nvidia.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
Subject: Re: [PATCH v6 00/18] Add T114 video support
Message-ID: <20240421010212.1c68d9ea@crub>
In-Reply-To: <20240123171633.246057-1-clamor95@gmail.com>
References: <20240123171633.246057-1-clamor95@gmail.com>
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

On Tue, 23 Jan 2024 19:16:15 +0200
Svyatoslav Ryhel clamor95@gmail.com wrote:

> T114 is not that different from T30 and all T30 drivers will work
> on T114 as well with some adjustments.
> 
> Patches propose general improvements for existing Tegra DC and DSI
> drivers as well Tegra 114 video support (experimentl).
> 
> Commits pass buildman for tegra.

Series applied to u-boot-video, except patch 06/18.

--
Anatolij
