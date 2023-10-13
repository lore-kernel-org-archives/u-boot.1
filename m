Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1883FCDB482
	for <u-boot@archiver.kernel.org>; Fri, 13 Oct 2023 11:47:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6878086DEE;
	Fri, 13 Oct 2023 13:47:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697197648;
	bh=3ktTsim6nBXwMq3oFqQHJZQx18BCaA/zCDpy2vetC8I=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zmub7Jx3pSjtJxfRwNmxQBdoD6xc8fsOZg5aw2vMYbd+PN5BnZtSsQbqXTTg7Bn/P
	 jMleLMQU88dyr18IJqVS+Th0SbmZx7UIKRVKXxU3ze1PWikQqICaAYZsAHFUT/HSNJ
	 qBG2/dzak8Nh3zXPrRuwC7hwe7BT6d/zun0DELPZjR9Rimy5MAtZRa7XfrlB0/s1He
	 LZmLtyl5iI4tSsT+cz0s21F5q7EjcOl0Wl/Iy2tu3vQ6dl+Ia1/wBgQ74538Z6E3hE
	 z4GTEt3o+Q2sdZd5a/SotJWzmTXclwWGtp4g8OpsGf8SOeFM3W7xHGiWFtqatQWP0V
	 tooacn3RusTzQ==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id B0F8986D6E;
 Fri, 13 Oct 2023 13:47:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1697197646;
 bh=3ktTsim6nBXwMq3oFqQHJZQx18BCaA/zCDpy2vetC8I=;
 h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
 b=x1x/+aRFXitexv0JxFS+UZqE4p/eanpHsNxa32YZxo77ok2NRBki58oGE0FvOVor8
 o57XuWe7saH8wiqOlPSFQFrAo24KcQawFcwXUJaSxtpLXeZzq1FNEVw9HbJsI83D8h
 OVZxAOpZYXCnU+4PicxcrsXvWCa3+eSnrUaOW3qlEUH0/HxEKPMhA+rk770wCoAMs1
 Zg2cmKLtdJIiYrZWs+zKA5XaF03Cjj52Dsv+TztcemdrVc8guNbmx7rJ/9ND7iyA5Z
 fdirSsvNlkUuo8hkEkS7D1DrRjFpW9j3PpCqV21qVmnE7Qc6LOPRhPYAZhvcWdU3qe
 utn1XDdGLJg3Q==
Message-ID: <2016c1bc-dfe0-416e-a910-75e6cf25036c@denx.de>
Date: Fri, 13 Oct 2023 13:47:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH v2] usb: xhci: Workaround to fix the USB halted endpoint
 issues
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: michal.simek@amd.com, git@xilinx.com, Tom Rini <trini@konsulko.com>
References: <20231013045356.25789-1-venkatesh.abbarapu@amd.com>
Content-Language: en-US
In-Reply-To: <20231013045356.25789-1-venkatesh.abbarapu@amd.com>
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

On 10/13/23 06:53, Venkatesh Yadav Abbarapu wrote:
> The xhci host controller driver trying to queue the URB's and it is
> getting halted at the endpoint, thereby hitting the BUG_ON's.
> Mostly these kind of random issues are seen on faulty boards.
> Removing these BUG_ON's from the U-Boot xhci code, as in Linux kernel
> xhci code BUG_ON/BUG's are removed entirely.
> Please also note, that BUG_ON() is not recommended any more in the Linux
> kernel.
> Similar issue has been observed on TI AM437x board and they created a patch
> in Linux kernel as below
> https://patches.linaro.org/project/linux-usb/patch/1390250711-25840-1-git-send-email-balbi@ti.com/
> 
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>

I already explained to Xilinx how to sync the driver with Linux and why 
this is needed to move forward, multiple times, and even provided a 
script which does most of the work automatically, since it is basically 
automated process. Xilinx did not even bother to test the script and 
provide any feedback.

Until that happens, this patch is rejected.
