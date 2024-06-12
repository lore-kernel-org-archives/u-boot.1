Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A9E8C27C53
	for <u-boot@archiver.kernel.org>; Wed, 12 Jun 2024 10:21:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9712488229;
	Wed, 12 Jun 2024 12:21:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1718187685;
	bh=ia4S1IUz/ggdjYLJG7aKKPytwdgSqs0hYLhGBsqHYw0=;
	h=Date:To:Cc:From:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=DOBkCHFfbUTwC/yQWyde/E2ozV2j/+5yo1mGtc3FvUnkixhz50+ntZS2ikWCD2WoS
	 wfXAzGUrwJmCJsfF2DdS0J504LT+NA46Xa2iWvDL9aNgAXUgaqJNfj+YO9EZLYyEAK
	 pH4GaBkLJbEPDHfBQbScvPTdDRIRsDF6irKqRX/XuNdtJrn5eiS1hw8dyXBucictMc
	 ACZaUROTVljmy5PgvCIBQZcL6JspFRSHFSUA8tySjJGLIK0lZQSXwFxFE2uiIja21f
	 E0s47ls64EhElZcDB1RAmdrDjbwsX+jCH+zNDF+lkpm9lZ4FxOtEB2JZ749sHpHrz+
	 OCKZHeTUIERJQ==
Received: from [10.88.0.65] (dslb-002-207-026-217.002.207.pools.vodafone-ip.de
 [2.207.26.217])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: ch@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 024DA88229;
 Wed, 12 Jun 2024 12:20:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1718187615;
 bh=ia4S1IUz/ggdjYLJG7aKKPytwdgSqs0hYLhGBsqHYw0=;
 h=Date:To:Cc:From:Subject:From;
 b=fNrlP0lQbP3GRW8WHhI//L54LBtE2devTYDwr8kNsvym4cszTpWhWW5ZhGalsdnQz
 66Jm/boUwQS1aQvucdqpSlOELwwbGi1Sc5+wbY6jZ8Hj4DAWgmspU8LDoi+6FK+M1l
 0+igtnofvoz9/cab3CXM6FSx5vqw1gtemv9HrQMMyKXJpKFgZ7YLleptONFht87pxY
 /D3nrkdpXBMhgnXIPaxaHgZIuJVrgMKY6p3s2fokga9IUhCMbOEePipSwb0+NBCmKs
 sbPc7Nm+jm51zI4w8xa6ziudFbgYuJ69VuIZ0peJCTuXg2gOQOB3xSV202acYBOSz/
 UOXwmyS+lDdvA==
Message-ID: <323dbb9c-42bd-4664-b660-0ba24c819bec@denx.de>
Date: Wed, 12 Jun 2024 12:20:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marex@denx.de>, Stefano Babic <sbabic@denx.de>
From: Claudius Heine <ch@denx.de>
Subject: Shutting down of the git-daemon (git protocol, https and ssh still
 remain)
Organization: Denx Software Engineering
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Wed, 12 Jun 2024 12:21:24 +0200
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

Hi everyone,

in the past we used cgit, which provided cloning the u-boot repo via 
http, https, ssh and the git protocol.

When we migrated to gitlab, which doesn't support the git protocol, we 
implemented some additional service files to continue to support it for 
some of our git repositories.

We just noticed that cloning via the git protocol is currently broken, 
likely some changes in gitlab happened and we would need to recreate the 
symlinks on the server to point to the right repositories again.

Since that is another thing to maintain and keep up, we would like to 
just shut the git protocol down. AFAIK most projects moved to use https 
for cloning anyway, since there were not many reports of broken cloning.

What are your thoughts? Is it worth the effort to keep the git protocol up?

regards,
Claudius


-- 
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-54 Fax: (+49)-8142-66989-80 Email: ch@denx.de
