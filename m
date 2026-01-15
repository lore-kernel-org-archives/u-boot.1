Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27206D4114C
	for <u-boot@archiver.kernel.org>; Thu, 15 Jan 2026 09:36:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 85A6780325;
	Thu, 15 Jan 2026 10:36:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="rFD/PaUi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8F6883015; Thu, 15 Jan 2026 10:36:39 +0100 (CET)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99BAF80077
 for <u-boot@lists.denx.de>; Thu, 15 Jan 2026 10:36:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=glaroque@baylibre.com
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-42fb4eeb482so380874f8f.0
 for <u-boot@lists.denx.de>; Thu, 15 Jan 2026 01:36:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1768469797; x=1769074597;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gnGuSvU7itIUkBEGSsB8ydHwMQNaWPQXlOwPXn4ciSQ=;
 b=rFD/PaUianyvEcxhtv9ZUyQajjn80AoA/EjjwhGKBxWNJ8AG3JpHY35mgFW1EUaP5W
 nveeCjdHamTzbtLtWwQoFw1hXWzmed2DSsaENuBrnH/+imb6g8SXyzuNr+Cu5IMz8Low
 UMMG8zRBHSJW0YOWCgmnDXWS9dyddC7zMrkeY4bZSHYJ+a/SwwTg4LgTvn79m+0BolVu
 fAsE42BuWu0/XpWUd/Fn589TzXDg+hiDHT7kdsmxL+hL1KFnKXt4da/MTcWNHEoclKp0
 H9vTUMtJjOH4foZa579Eh85+hiGORicdtJH8x+F2FIzRy3R+4J7zjchzoj5OBauMv+nr
 ocUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768469797; x=1769074597;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gnGuSvU7itIUkBEGSsB8ydHwMQNaWPQXlOwPXn4ciSQ=;
 b=LabI4GhF3CC52NvISDDTNI62eyTN43E20lb9M9K9EuP2VQCggWazQw4S8x2nduC7vD
 Aps37eOc3Cyx8HVYXvCutUKVTIHN8GnZ4fhA+Ix0c17kR/5/ytKAh2Ep34XzpJip5aa/
 nM7bF3/QRADuQNs+LckQfirAgwH8WY0cKeqfCkEMvprL8CaqIJPzanmgFv7qzEUGeT8B
 DBpo79cvKDCFUbFBZZkSdRjvAhqw3+i+hb+kNCAsAUDbCSEYX1oT8aGSkd7ryLkpGR5i
 jhY7rFbIf9lUF5f+24bIwzaWpWNIoP8lbidIpLIQpA82yayqZNhIsSJqJPvCIFJd7Kym
 EgxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjfWj34jqoUW1TcAWQhHBErjbp7HUIs7j0DloBfCd9Y9LgKu6YsH8cJ29qibk+hsoTsCdwLlg=@lists.denx.de
X-Gm-Message-State: AOJu0Ywt3zy1HmH9PfMYGEcdVYmmc32JWbKsNEY8ro9duiBrllXZyCMo
 iTWXeElWsFIEwIJf3LRjy9AN+/qgwJ/b4uZDm4rNuY7cwy2NkKKyejMcifWM8YJ9WSk=
X-Gm-Gg: AY/fxX5vPyIddISzBkOsgsoFSSNg6VS2u21reiaK5anmJ+FASeiBthzYyouXAIC0KOq
 XOOR/hwYcXK/c3zMVGq0856i/iqlrubqKeUqM0K+g5CZA7kC84hOasgYrWql5WNxVixt016zhiF
 Ek2xLg5nOyYHUursIVpujMTNhO2mPDLN2up6abOxF0Eg+Mpcq24URwPHBxB0J5QG/JL7wkirpIC
 sitz6DqcdvtubA+8ntQ1tQ4rI2V7Wf9YKKA0axpxGl1UBxNjAqvifV7q8BWgGSjqnfLNJYDGB4Z
 QqPaljtA/870X5Dwgyu5/RXAWDVcyf26Swv3M68RDeqPjwzHiWN0SuczG8gHWJ03fOpK9cxcvzb
 oARm1rf5zy1rxm4W3jzQiRU+osMI0FTs79biGPXyluJssVE9FVUmjj88M4grlM9AbUm1ZU8LoM7
 f672DLCmwZxk5SY79tYNWfe5LiguT1waByC7LDEy8oLVZVFEUoUgtFsOTj0Q==
X-Received: by 2002:a05:6000:2893:b0:42f:b65c:1e4f with SMTP id
 ffacd0b85a97d-4342c4ffd79mr6821670f8f.17.1768469797000; 
 Thu, 15 Jan 2026 01:36:37 -0800 (PST)
Received: from ?IPV6:2a01:e0a:e50:3860:abb8:cc0c:24e5:51ea?
 ([2a01:e0a:e50:3860:abb8:cc0c:24e5:51ea])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-434af653632sm4915030f8f.11.2026.01.15.01.36.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Jan 2026 01:36:36 -0800 (PST)
Message-ID: <bcbe318d-bcc9-4c3a-86a2-450da1b6d539@baylibre.com>
Date: Thu, 15 Jan 2026 10:36:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/5] test: abootimg: Add test for bootconfig handling
To: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Tom Rini <trini@konsulko.com>
Cc: Julien Masson <jmasson@baylibre.com>, u-boot@lists.denx.de,
 Simon Glass <sjg@chromium.org>, Nicolas Belin <nbelin@baylibre.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Aaron Kling <webgeek1234@gmail.com>, George Chan <gchan9527@gmail.com>,
 Sam Day <me@samcday.com>, Maxime Fournier <mfournier@baylibre.com>,
 Eddie Kovsky <ekovsky@redhat.com>, Casey Connolly
 <casey.connolly@linaro.org>, Guillaume Ranquet
 <ranquet.guillaume@gmail.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Jerome Forissier <jerome@forissier.org>
References: <20260112-bootconfig-v5-0-79b242159ac7@baylibre.com>
 <20260112-bootconfig-v5-5-79b242159ac7@baylibre.com>
 <878qdzfdja.fsf@kernel.org>
Content-Language: fr
From: Guillaume La Roque <glaroque@baylibre.com>
In-Reply-To: <878qdzfdja.fsf@kernel.org>
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

Hi,

thanks for review.

Le 15/01/2026 à 10:09, Mattijs Korpershoek a écrit :
> Hi Guillaume,
>
> Thank you for the patch.
>
> On Mon, Jan 12, 2026 at 11:55, "Guillaume La Roque (TI.com)" <glaroque@baylibre.com> wrote:
>
>> Add test to verify that androidboot.* parameters are correctly extracted
>> from bootargs and appended to the bootconfig section when using
>> 'abootimg get ramdisk' with boot image v4 and vendor_boot image.
>>
>> The test verifies:
>> - androidboot.* parameters are removed from bootargs
>> - They are appended to the bootconfig section in the ramdisk
>> - Non-androidboot parameters remain in bootargs
>> - The bootconfig trailer is properly updated
>>
>> Reviewed-by: Simon Glass <sjg@chromium.org>
>> Signed-off-by: Guillaume La Roque (TI.com) <glaroque@baylibre.com>
> nitpicks below.
>
> Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
>
>
>> ---
>>   test/py/tests/test_android/test_abootimg.py | 91 +++++++++++++++++++++++------
>>   1 file changed, 73 insertions(+), 18 deletions(-)
>>
>> diff --git a/test/py/tests/test_android/test_abootimg.py b/test/py/tests/test_android/test_abootimg.py
>> index daa87643e93..760f8e385ba 100644
>> --- a/test/py/tests/test_android/test_abootimg.py
>> +++ b/test/py/tests/test_android/test_abootimg.py
>> @@ -62,22 +62,24 @@ b7762ffff07d345446c1281805e8a0868d81e117a45e111c0d8dc101b253
>>   d4a9820881a70f3873f35352731892f3730b124b32937252a96bb9119ae5
>>   463a5546f82c1f05a360148c8251300a462e000085bf67f200200000"""
>>   
>> -# boot img v4 hex dump
>> -boot_img_hex = """1f8b080827b0cd630203626f6f742e696d6700edd8bd0d82601885d1d7c4
>> -58d8c808b88195bd098d8d246e40e42b083f1aa0717be99d003d277916b8
>> -e5bddc8a7b792d8e8788c896ce9b88d32ebe6c971e7ddd3543cae734cd01
>> -c0ffc84c0000b0766d1a87d4e5afeadd3dab7a6f10000000f84163d5d7cd
>> -d43a000000000000000060c53e7544995700400000"""
>> -
>> -# vendor boot image v4 hex dump
>> -vboot_img_hex = """1f8b0808baaecd63020376626f6f742e696d6700edd8310b824018c6f1b3
>> -222a08f41b3436b4280dcdd19c11d16ee9109d18d59042d047ec8b04cd0d
>> -d19d5a4345534bf6ffc173ef29272f38e93b1d0ec67dd79d548462aa1cd2
>> -d5d20b0000f8438678f90c18d584b8a4bbb3a557991ecb2a0000f80d6b2f
>> -f4179b656be5c532f2fc066f040000000080e23936af2755f62a3d918df1
>> -db2a7ab67f9ffdeb7df7cda3465ecb79c4ce7e5c577562bb9364b74449a5
>> -1e467e20c53c0a57de763193c1779b3b4fcd9d4ee27c6a0e00000000c0ff
>> -309ffea7010000000040f1dc004129855400400000"""
>> +# bootable boot image v4 hex dump (with DTBs)
>> +boot_img_hex = """1f8b0808e2dd60690203626f6f745f6e65772e696d6700edd8ab0d836018
>> +40d14f900a0c8c5036e80a24180c24dde04f4034d04740b13d02d90920e7
>> +8c70e5adbbe6d9b74d5544441987c72dfe64010000009cd5342e9f71beff
>> +d2367fd3900b0200000017b4a4f7f05a2703000000002e6c0765d9bd6000
>> +300000"""
>> +
>> +# bootable vendor boot image v4 hex dump (with DTBs + bootconfig)
>> +vboot_img_hex = """1f8b0808e2dd6069020376656e646f725f626f6f745f6e65772e696d6700
>> +eddb316bc24014c0f14b2dd20a425c3b393a48c1d0c1a54be9aca588fbc5
>> +0b3434e9c979d04628f811fd22426787d2bbc43a68e9d4a5f1ff83f7de25
>> +5c787053f220d3d1fde3dd783c39174ee86255e68e4f0000e00405e2e835
>> +e0e142886db9fae8f89c95dbaa7ac5890100f02f1899ab74f1dc9dcb22d3
>> +52b538110000000000ea67ddfedcb8f2ee6228aa317ecf859fed7fcffefd
>> +fae68747835d6dec42bc0df6d74d1fc5a0bfac6e89331797b9564926663a
>> +9f4b9bc659f2b7cda383e6517f19fdd61c0000000080d3111e7c4f030000
>> +000080fa912fcae854c55adbeb2769d4ab34c9ad4d16963f010000000000
>> +a88d2fb468951800500000"""
>>   
>>   # Expected response for "abootimg dtb_dump" command
>>   dtb_dump_resp="""## DTB area contents (concat format):
>> @@ -166,7 +168,6 @@ def abootimgv4_disk_image_vboot(ubman):
>>       This is function-scoped because it uses ubman, which is also
>>       function-scoped. However, we don't need to actually do any function-scope
>>       work, so this simply returns the same object over and over each time."""
>> -
> Unrelated diff, drop please.
>
>>       global gtdi2
>>       if not gtdi2:
>>           gtdi2 = AbootimgTestDiskImage(ubman, 'vendor_boot.img', vboot_img_hex)
>> @@ -179,7 +180,6 @@ def abootimgv4_disk_image_boot(ubman):
>>       This is function-scoped because it uses ubman, which is also
>>       function-scoped. However, we don't need to actually do any function-scope
>>       work, so this simply returns the same object over and over each time."""
>> -
> Unrelated diff, drop please.
>
> I can fix up when applying if you agree to that by replying to this email.

ok for me , thanks to do yourself this changes.

Guillaume

>
>>       global gtdi3
>>       if not gtdi3:
>>           gtdi3 = AbootimgTestDiskImage(ubman, 'bootv4.img', boot_img_hex)
>> @@ -282,3 +282,58 @@ def test_abootimgv4(abootimgv4_disk_image_vboot, abootimgv4_disk_image_boot, ubm
>>       ubman.run_command('fdt get value v / model')
>>       response = ubman.run_command('env print v')
>>       assert response == 'v=x2'
>> +
>> +@pytest.mark.boardspec('sandbox')
>> +@pytest.mark.buildconfigspec('android_boot_image')
>> +@pytest.mark.buildconfigspec('cmd_abootimg')
>> +@pytest.mark.requiredtool('xxd')
>> +@pytest.mark.requiredtool('gunzip')
>> +def test_abootimg_bootconfig(abootimgv4_disk_image_vboot,
>> +                              abootimgv4_disk_image_boot,


