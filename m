Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A92BDE6FE24
	for <u-boot@archiver.kernel.org>; Tue, 23 Dec 2025 18:55:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2FA6784179;
	Tue, 23 Dec 2025 19:55:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="OmsJrEgI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E29184180; Tue, 23 Dec 2025 19:55:51 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 616FD84167
 for <u-boot@lists.denx.de>; Tue, 23 Dec 2025 19:55:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4dbPNM21Qmz9tGQ;
 Tue, 23 Dec 2025 19:55:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1766516147;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vKm86w/L3El0iZmsEX64Y/gq7/GxXYvaFnGaQmgUR9s=;
 b=OmsJrEgIT2Dwf9gRQXi1m3nMZ5zi7mlEted6gQXX6GzM4u4w1UFhgV44A0SnW1Eg3dNodD
 kGDc7hfyZDYaoVFJi8dNd5tDQMzN24VI6JcAygTZiAi59VIB7k6cErjiHQRoQtnt2yLwx3
 FCyIHmuAhh58jqiJusQluVhU/d9UlvXv2fBIdP8gU2YU+vcXHAzJSDdtNLFlc2ZaRrf2L9
 sns7HqWqGo3YZOf2B+xysMHN/sOvYfGDXF6MODqwxZh5KJ67OYN6rJkgN/zFyI9mEgopXU
 KKb9iSnWt1Nh+bvao5GwxlMmh4190ujdAiB3IH9Chh4aNCzSi0QaSZkBFY+OWA==
Message-ID: <bb3d1ff2-4cc1-48da-a47f-3aef44277791@mailbox.org>
Date: Tue, 23 Dec 2025 19:55:45 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/3] test: env: Add test for environment storage in SPI
 NOR
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20251223143130.16266-1-marek.vasut+renesas@mailbox.org>
 <c31bd8b3-2604-4193-abba-6815845e8967@gmx.de>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <c31bd8b3-2604-4193-abba-6815845e8967@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 6d0124f2d28c5e12f2c
X-MBO-RS-META: nci48we7r9s5qe6nda5g8kuh7dfacr55
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

On 12/23/25 6:32 PM, Heinrich Schuchardt wrote:
> On 12/23/25 15:31, Marek Vasut wrote:
>> Add test for environment stored in SPI NOR. The test works in a very
>> similar way to the current test for environment stored in ext4 FS,
>> except it generates spi.bin file backing the SPI NOR.
>>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>> ---
>> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
>> Cc: Jerome Forissier <jerome.forissier@linaro.org>
>> Cc: Simon Glass <sjg@chromium.org>
>> Cc: Tom Rini <trini@konsulko.com>
>> Cc: u-boot@lists.denx.de
>> ---
>> V2: No change
>> ---
>>   test/py/tests/test_env.py | 99 +++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 99 insertions(+)
>>
>> diff --git a/test/py/tests/test_env.py b/test/py/tests/test_env.py
>> index 383e26c03b0..48e31f19b3c 100644
>> --- a/test/py/tests/test_env.py
>> +++ b/test/py/tests/test_env.py
>> @@ -457,6 +457,26 @@ def mk_env_ext4(state_test_env):
>>       utils.run_and_log(c, ['cp',  '-f', persistent, fs_img])
>>       return fs_img
>> +def mk_env_spi_flash(state_test_env):
> 
> Thank you for adding the test.
> 
> Unfortunately pylint doesn't like your code. Please have a look.

Is this something we run in CI ? If so, CI builds did pass.

If not, how do I trigger this ?
