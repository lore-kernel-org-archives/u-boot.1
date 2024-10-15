Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63C37D1D88D
	for <u-boot@archiver.kernel.org>; Tue, 15 Oct 2024 16:55:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A53988966;
	Tue, 15 Oct 2024 18:55:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1729011338;
	bh=MJO1Y7Nlep2bW5A+LnUqZL3bSMOubmP+t72w9ITlkHQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LGjLS8iupdVsvDKf22/48zVBrEzrPjZD+ef83pxciLRx+gpSmws0FR2PsWKurFXp9
	 /GGTO38otjLGC9+V1owlKpQkyzM46EXz3IxBx7zyOL5tUUOMI69EPxhzMtbzlc1/vN
	 UZ9D+oS/IahebPwF3gbf1qVCNP3LiNol9LpvgVsH9x478kMrHlW1hK2ge7gkZHVslE
	 CxsiXJEQWgO9czMaIhoKzGzLlvzYrFiFqoJMUvxq2jNOZmL0we3SuUj+6N3mrP1dPR
	 0f0rVrtgszfN2seiAHjmIqW2TWz+Ow6e+hjoIF3prC3SxWWMuZFX+8AN+WhtX6REGE
	 Gg1XN6TggoRhQ==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id D0BAD88703;
 Tue, 15 Oct 2024 18:55:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1729011337;
 bh=MJO1Y7Nlep2bW5A+LnUqZL3bSMOubmP+t72w9ITlkHQ=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=lKWxmggaxOd2dEfZWcverb1OjoTmyuYpj+dB0c1Fat/cj461q6kFByX2FPJ5jqY0s
 9tf1XbJkws+lQeGnrzgCm3kCfXNAhYChLF9J4lnd0bSka87YpyE0h3ytgBi7GviyoQ
 dlS5/R8Dlk6+feRBKfjkBXNKw1vb7jpQPA9qwkEzAORPC6R4EmgTGpjkd76IfjKWA6
 Zrt/dV9A/rXEdx6mq4ioUZa/g1+DWNUw7MTeqZqijWRrxKRNuIP5CNyY+bF1fdiZor
 n8KkIs5HgNVQOapyOA6/AhX6lCJuNOKucvLSpkXX5WCiqJhin3QIsyTf5Z644fM3fr
 jDbw+EKCt/1mg==
Message-ID: <f2859286-0e58-4373-b5ff-7121da452ddb@denx.de>
Date: Tue, 15 Oct 2024 17:41:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: Fix test dependency on ext4write command
To: Andrew Goodbody <andrew.goodbody@linaro.org>, u-boot@lists.denx.de,
 Simon Glass <sjg@chromium.org>
Cc: Love Kumar <love.kumar@amd.com>, Tom Rini <trini@konsulko.com>
References: <20241015141737.1170669-1-andrew.goodbody@linaro.org>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20241015141737.1170669-1-andrew.goodbody@linaro.org>
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

On 10/15/24 4:17 PM, Andrew Goodbody wrote:
> The tests test_usb_ext4load_ext4write, test_usb_ext2load and
> test_usb_load depend on the command ext4write being present not just
> the feature of being able to write to an ext4 file system. So update
> their dependencies to include the ext4write command itself. This will
> prevent spurious test failures when running the USB tests against USB
> storage with an ext2/ext4 partition but no ext4write command available.
> 
> Fixes: 1c5b6edad381 ("test/py: usb: Add tests for USB device")
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
> 
>   test/py/tests/test_usb.py | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/test/py/tests/test_usb.py b/test/py/tests/test_usb.py
> index fb3d20f082..b86fc290c7 100644
> --- a/test/py/tests/test_usb.py
> +++ b/test/py/tests/test_usb.py
> @@ -382,7 +382,7 @@ def test_usb_ext4ls(u_boot_console):
>   
>   @pytest.mark.buildconfigspec('cmd_usb')
>   @pytest.mark.buildconfigspec('cmd_ext4')
> -@pytest.mark.buildconfigspec('ext4_write')
> +@pytest.mark.buildconfigspec('cmd_ext4_write')
>   @pytest.mark.buildconfigspec('cmd_memory')
>   def test_usb_ext4load_ext4write(u_boot_console):
>       devices, controllers, storage_device = test_usb_part(u_boot_console)
> @@ -469,7 +469,7 @@ def test_usb_ext2ls(u_boot_console):
>   @pytest.mark.buildconfigspec('cmd_usb')
>   @pytest.mark.buildconfigspec('cmd_ext2')
>   @pytest.mark.buildconfigspec('cmd_ext4')
> -@pytest.mark.buildconfigspec('ext4_write')
> +@pytest.mark.buildconfigspec('cmd_ext4_write')
>   @pytest.mark.buildconfigspec('cmd_memory')
>   def test_usb_ext2load(u_boot_console):
>       devices, controllers, storage_device = test_usb_part(u_boot_console)
> @@ -543,6 +543,7 @@ def test_usb_ls(u_boot_console):
>           pytest.skip('No partition detected')
>   
>   @pytest.mark.buildconfigspec('cmd_usb')
> +@pytest.mark.buildconfigspec('cmd_ext4_write')
>   @pytest.mark.buildconfigspec('cmd_fs_generic')
>   def test_usb_load(u_boot_console):
>       devices, controllers, storage_device = test_usb_part(u_boot_console)

+CC test expert Simon
