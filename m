Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1DAFCFB440
	for <u-boot@archiver.kernel.org>; Mon,  7 Oct 2024 12:15:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44BB988D38;
	Mon,  7 Oct 2024 14:15:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1728303350;
	bh=Pqmmzo3XJWaxJFnf1lUV2KQ52BbOUgWxoPGwRvqmfyU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pHWIKn0W7JQBBfihVMqmzeJEMeSYeTMzNI398sG7tmom7ujSY7f3lT+96ClHOyuQq
	 f4FT5myN+RSqSqNd2MNB9pCf+IUm0JhhpmIjkN7xsDURL0y5wTdqBphCQRdI68kj2g
	 YzXWKg8dQf/NDvKjUyJ8JoPgW1FnszOn44QvxVX5s/ASs5W7RGrYWRu2lB0bHodM8w
	 TkMA9PoWsg0ksFc64h6IiJr/l+hYq2tlWKTcfG/JmEOb0lbdHDIaomaBFKB6qSQ8AQ
	 zZV32kVAph2Y0xfvA5EiVjSB1WhEBVPrn3ofXsmO2VaEYM8wrbltMJaHOd1EkvDWAk
	 9mDy6Un5lfK7A==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 8E68B88AB9;
 Mon,  7 Oct 2024 14:15:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1728303348;
 bh=Pqmmzo3XJWaxJFnf1lUV2KQ52BbOUgWxoPGwRvqmfyU=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=XW6ODbO8G4QoVqZk5cUUC7VPEsfe0c1t5cYGXxmJymxkFXxbBIJ2qQvUGHs+092Xp
 tkcH9CiHykxFTsLesY9ef48/evTjYOWbIdUwJGRhO75YUTA4mqXhHhyVZLidh67Ybv
 wiyIp2TjRxqP4XBmGmAT+ubmLrHRzG0HE9LQCw9xELa1CPNbFC9zlmXWUrk+66YM3O
 k6Il5XjrQ430Pb8ZqE4vELtRunTbwlbedUtQasYlGQtSeEy2fVQRhVlc4s1jS76c1F
 w/+bVx+OyHM3UgaaSWjbvCZl48Kcl74rBVU2Aqri4abgA2ra1Im91TJtXROqvn3b1d
 K2LGHNscVXQTg==
Message-ID: <67e75db9-f158-407d-acbe-3ac62c528bb4@denx.de>
Date: Mon, 7 Oct 2024 14:09:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/7] usb: onboard-hub: Fix the return values of
 regulator APIs
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: michal.simek@amd.com, fabrice.gasnier@foss.st.com, git@amd.com
References: <20241007044547.23896-1-venkatesh.abbarapu@amd.com>
 <20241007044547.23896-3-venkatesh.abbarapu@amd.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20241007044547.23896-3-venkatesh.abbarapu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 10/7/24 6:45 AM, Venkatesh Yadav Abbarapu wrote:
> Don't error out if there is no vdd regulator supply, as these are
> optional properties.
> 
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Reviewed-by: Marek Vasut <marex@denx.de>
