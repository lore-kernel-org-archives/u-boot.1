Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB485D74960
	for <u-boot@archiver.kernel.org>; Thu, 31 Oct 2024 13:41:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 36707892CD;
	Thu, 31 Oct 2024 14:41:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1730382088;
	bh=171MFjmK2mH5TUopBfV7J4IfsvleUDfXtvSJps87nqA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZouSafXA+/WyqeYZfhD1kK4CVPGO4k4KPBTKQ/6XTdkXwFRj7ayJTGtxT/3C4BSfS
	 j2+oOyWxVdQKiEyl8EqC0VRPLmDwZlh863udhrrts0JgSDfP5VcQyeBGpZjlu1ADaH
	 GTQEcDdPlZ1kR+J7NgAvn1WBjaXm43Fg4rtaogHeXFTFyO7P68QVAnt01Q/nB2RE15
	 FhpFANYehSacQFb8gfSsk5pXxyFilJHj0dsYKVIT1ymEvq9Gvbri78ik1OZalchzzy
	 mVPJoe+kgLVBphP5CJSVGZalgL34vLEAbkxV0BxoAYLJ9j4A6imSzSQPnpbhl7I28G
	 5fsxPFfLOPk0A==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id F417D88E43;
 Thu, 31 Oct 2024 14:41:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1730382087;
 bh=171MFjmK2mH5TUopBfV7J4IfsvleUDfXtvSJps87nqA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=hyrefOtXUUP4tlcCufw/TI8oEVF4/Vl4fi7yQ42Ota9NXhbBLkUjKnFQq6eJmvU8M
 /8GM+vTjZRVqPxjmNy914zmzSSQhaYjwu4DV4rHi71IJ+cmh+qwwPX0iCi1VOU9Vij
 4N/eBTh7cmbu27XYz5EHYZgVRFegg6ODCvQbZ3wcBzasUz5F53MIWudsUIXZ5/J0gA
 9EmPMV2FjnuGjgiiBVhP6tIY98lDgIa+yzCfDcoQkXU0d6CdiYyeDwaqgrCkEjV3ej
 TIodMiq42s/zRn/UUTUr/Td9p6FZeNlBX2OFQSqU246qjGk0kMtXlXQ3pSxu0A7MEy
 xVpDHNpBGCdyw==
Message-ID: <3d885d5c-97ba-4403-84c1-376fec651b88@denx.de>
Date: Thu, 31 Oct 2024 14:26:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: Fix test dependency on ext4write command
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "Kumar, Love" <love.kumar@amd.com>
References: <20241015141737.1170669-1-andrew.goodbody@linaro.org>
 <f2859286-0e58-4373-b5ff-7121da452ddb@denx.de>
 <PH7PR12MB65388EF5AFC0FC77B30DDCDE83462@PH7PR12MB6538.namprd12.prod.outlook.com>
 <895194e8-ca21-44d8-a1b4-e31fb1d8b132@linaro.org>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <895194e8-ca21-44d8-a1b4-e31fb1d8b132@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 10/31/24 12:20 PM, Andrew Goodbody wrote:
> On 16/10/2024 07:33, Kumar, Love wrote:
>> Reviewed-by: Love Kumar <love.kumar@amd.com>
>>
>> On 15/10/24, 10:25 PM, Marek Vasut <marex@denx.de> wrote:
>>
>> On 10/15/24 4:17 PM, Andrew Goodbody wrote:
>>> The tests test_usb_ext4load_ext4write, test_usb_ext2load and
>>> test_usb_load depend on the command ext4write being present not just
>>> the feature of being able to write to an ext4 file system. So update
>>> their dependencies to include the ext4write command itself. This will
>>> prevent spurious test failures when running the USB tests against USB
>>> storage with an ext2/ext4 partition but no ext4write command available.
>>>
>>> Fixes: 1c5b6edad381 ("test/py: usb: Add tests for USB device")
>>> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
>>> ---
>>>
>>>    test/py/tests/test_usb.py | 5 +++--
>>>    1 file changed, 3 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/test/py/tests/test_usb.py b/test/py/tests/test_usb.py
>>> index fb3d20f082..b86fc290c7 100644
>>> --- a/test/py/tests/test_usb.py
>>> +++ b/test/py/tests/test_usb.py
>>> @@ -382,7 +382,7 @@ def test_usb_ext4ls(u_boot_console):
>>>    @pytest.mark.buildconfigspec('cmd_usb')
>>>    @pytest.mark.buildconfigspec('cmd_ext4')
>>> -@pytest.mark.buildconfigspec('ext4_write')
>>> +@pytest.mark.buildconfigspec('cmd_ext4_write')
>>>    @pytest.mark.buildconfigspec('cmd_memory')
>>>    def test_usb_ext4load_ext4write(u_boot_console):
>>>        devices, controllers, storage_device = 
>>> test_usb_part(u_boot_console)
>>> @@ -469,7 +469,7 @@ def test_usb_ext2ls(u_boot_console):
>>>    @pytest.mark.buildconfigspec('cmd_usb')
>>>    @pytest.mark.buildconfigspec('cmd_ext2')
>>>    @pytest.mark.buildconfigspec('cmd_ext4')
>>> -@pytest.mark.buildconfigspec('ext4_write')
>>> +@pytest.mark.buildconfigspec('cmd_ext4_write')
>>>    @pytest.mark.buildconfigspec('cmd_memory')
>>>    def test_usb_ext2load(u_boot_console):
>>>        devices, controllers, storage_device = 
>>> test_usb_part(u_boot_console)
>>> @@ -543,6 +543,7 @@ def test_usb_ls(u_boot_console):
>>>            pytest.skip('No partition detected')
>>>    @pytest.mark.buildconfigspec('cmd_usb')
>>> +@pytest.mark.buildconfigspec('cmd_ext4_write')
>>>    @pytest.mark.buildconfigspec('cmd_fs_generic')
>>>    def test_usb_load(u_boot_console):
>>>        devices, controllers, storage_device = 
>>> test_usb_part(u_boot_console)
>>
>> +CC test expert Simon
>>
> 
> Ping

Simon ?
