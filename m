Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67987D0E6C9
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 08:22:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0557892D4;
	Mon, 21 Oct 2024 10:22:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1729498969;
	bh=zW6L1ltp0TDM629jKJMI34m5u8DjhX6+JkuVYxwWkkg=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=wOkmFf2zsUQ11DUsoYDaNtKYsjkMeFETt9uc230P64+unpPVoBj3WpARm8y+7ORr6
	 +U7iotd6nq+imJjXRmSxPelhl9iRziWc3tgdM3qRunaBrPlcYy3rLUH0biSUuiqig1
	 ZEsCsZryGUjXJiev70UU16sQ/eBnLu6IKR7kzVCgQOqvbdsIE2Mn37wXaN8G8DsqNO
	 GsiaCBTAn3sN1DzvsimJhzsuJfBXVlg/NDZFyaqPeB2yw9/Ck/WpviGmGvacxRedTu
	 KCdRrZGUwt5rXakUlb0Xy4l6cXzvaShsWhoGJwtU7ckZ9iy7zlNGzpxjuwcm1R+l8z
	 D/GOL6UbDP1DQ==
Received: from [192.168.1.107] (82-131-200-27.pool.digikabel.hu
 [82.131.200.27])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id E5A4389313;
 Mon, 21 Oct 2024 10:22:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1729498968;
 bh=zW6L1ltp0TDM629jKJMI34m5u8DjhX6+JkuVYxwWkkg=;
 h=Date:Subject:From:To:Cc:Reply-To:References:In-Reply-To:From;
 b=NozLP4b08DnaG8Lh5Q3gRI4EGm70Rwm8MnDXWZR3LcNc15TQ2AF//uQqeYKa6iTQ/
 6ACXCWz0uZPe/Hr47kgWojxFzoO9o8EbZTd1zK0OIGmO/8qj/qvyo0SI4DgmsiMg90
 pQEtiZE0ruH9rTMAHll3fy/JrCZ5xuXHwC01z1lVoSUPLluKPWxga3N+ykp8b/mDo8
 mbdoOVAs5nVOmbMvdseRWn6MSk9omiAfVTrVvPY6q3uv+hFqTfvUTx9ShuVz6e03So
 nVnoRuzyPzyL2u2KW5yQEMHOuRtIpMav+c6Nk3zBxu0W5Hn7YG3NRix8CdBXm22DMq
 K3kPT04gP39yg==
Message-ID: <dea0b782-1268-32e3-c777-337e2826ec9c@denx.de>
Date: Mon, 21 Oct 2024 10:20:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] i2c: i2c-gpio: add support for i2c-gpio,sda-output-only
Content-Language: en-US
From: Heiko Schocher <hs@denx.de>
To: Alex Shumsky <alexthreed@gmail.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>
References: <20241015202931.15270-1-alexthreed@gmail.com>
 <476dd140-d157-5e22-3a70-d06c079e32c7@denx.de>
In-Reply-To: <476dd140-d157-5e22-3a70-d06c079e32c7@denx.de>
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
Reply-To: hs@denx.de
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello Alex,

On 21.10.24 06:13, Heiko Schocher wrote:
> Hello Alex,
> 
> On 15.10.24 22:29, Alex Shumsky wrote:
>> Some I2C slave devices are read-only and don't even answer with NACK.
>> For example FD65x segment LED controllers.
>> Make them usable with i2c-gpio,sda-output-only that are already supported
>> by Linux 6.3+.
>>
>> Signed-off-by: Alex Shumsky <alexthreed@gmail.com>
>> ---
>>
>>   doc/device-tree-bindings/i2c/i2c-gpio.txt |  2 ++
>>   drivers/i2c/i2c-gpio.c                    | 10 ++++++++--
>>   2 files changed, 10 insertions(+), 2 deletions(-)
> 
> Thanks!
> 
> Reviewed-by: Heiko Schocher <hs@denx.de>

Applied to u-boot-i2c, thanks!

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
