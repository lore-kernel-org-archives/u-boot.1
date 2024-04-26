Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0930CC4345F
	for <u-boot@archiver.kernel.org>; Fri, 26 Apr 2024 05:18:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FF6388E78;
	Fri, 26 Apr 2024 07:18:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1714108722;
	bh=ihm1ZP2XNGZlC0t4lJ1C++GR75ObZjYgz/mXnyFLMEY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=yiRysmuC6sVi57tsq7kSXXc9WYvZW1jS4K2/TIYmzTYtVJ144GVqfCogGOUBIXWMV
	 rHqHmP/QdevFlgnVaCYvQslM3Ay/WcBc5fMKD5MN1/HmdIvKMdm4/noWvh5yt+GJmm
	 5o0XMtfqlUPSH754Pk+H9jJ1/fbsBrWgjt+7hQqpjmAAbD79cyNtJGkRfEatHb4dfF
	 kgoUN9MiQJ640qd0Oc/KDfwFCXcrVXG/4tP7IGk6580uZa9ZzLso621hXF0imuQdkR
	 se9lOLX6gfGk51wWTQVzk3SVHkKggir4xJu6ItXb98bKw9cSkQSJHI+Agf2zrDpaHE
	 LwritlJs5+uHA==
Received: from [192.168.1.107] (82-131-156-115.pool.digikabel.hu
 [82.131.156.115])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 3894D88F1C;
 Fri, 26 Apr 2024 07:18:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1714108720;
 bh=ihm1ZP2XNGZlC0t4lJ1C++GR75ObZjYgz/mXnyFLMEY=;
 h=Date:Subject:To:Cc:References:Reply-To:From:In-Reply-To:From;
 b=HuAmpEK++jtMgRN0fwJt5r5NE84WFFuUzr2ujscm8akbhZREyu1DEIEVWqHFfv86Z
 ky2KX8Ddla3aiYh243YYPo53GS86/uH/Knhsg/gZ1JWN9AsKgsZV9pYn6kQiFNzVIT
 61gVEqAgcS9MB6od8J1jb0XCofr6DoaBqsTzzv1n85fbni9S2Ha3u9MWnTDkgfXx8S
 wG9hGCiPxhtTTL2ylhxV0bDAQ56uwbyVVXSr9QSkA9sJ7Vf0gRFYo69C7XD8Y13ONu
 Ha+JqxO0+p0eFvaxnSW88bTJFmL2E7tPY+QiAlWW/p5qzcQNXKTtzZeIBKHAO5PAKP
 +FRpDNZd500cQ==
Message-ID: <74dc9d77-9316-4c14-5d52-9b496cad2a76@denx.de>
Date: Fri, 26 Apr 2024 07:18:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] ubi: Depend on MTD
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: Kyungmin Park <kmpark@infradead.org>, u-boot@lists.denx.de,
 John Watts <contact@jookia.org>,
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
References: <20240411-mtd-v1-1-fe300f6ab657@jookia.org>
 <CAOf5uwmcrh6M-GGYwZVk3D4LzZRnk8fE+88JJgtOAHJ_X2=P2Q@mail.gmail.com>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <CAOf5uwmcrh6M-GGYwZVk3D4LzZRnk8fE+88JJgtOAHJ_X2=P2Q@mail.gmail.com>
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

Hello Tom,

On 11.04.24 08:09, Michael Nazzareno Trimarchi wrote:
> Hi
> 
> On Thu, Apr 11, 2024 at 7:06 AM John Watts <contact@jookia.org> wrote:
>>
>> UBI required MTD to build correctly, add it as a Kconfig dependency.
>>
>> Signed-off-by: John Watts <contact@jookia.org>
>> ---
>> While working with UBI on my SPI NAND patch series I found it was
>> possible to enable it without enabling the MTD subsystem.
>> Add a Kconfig option to solve this.
>> ---
>>   drivers/mtd/ubi/Kconfig | 1 +
>>   1 file changed, 1 insertion(+)

Seems I am too dummy to find this patch in Patchwork, nor is it
applied in master ... can you pick it up, or should I do this and
send you a pull request?

Thanks!

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
