Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1DBBC369D7
	for <u-boot@archiver.kernel.org>; Fri, 25 Apr 2025 16:30:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7ADE382918;
	Fri, 25 Apr 2025 18:30:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lMH7SLNO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D61F4828C2; Fri, 25 Apr 2025 18:21:37 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F3FC82115
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 18:21:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=b.t.freeman16@gmail.com
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3a064a3e143so1220385f8f.3
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 09:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745598095; x=1746202895; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=miui51m4WZP2t7QWrX7M4YCc9vTAHLpEYIHfWvaPVJc=;
 b=lMH7SLNOysqHvYQYMbWwQ/yUT7makGKbZjZWIbblb+5eL+e4rqIlakP7YtHaZpUU9D
 MRH83o5Q9kCAPlPMjbeCxIIsLzhZQ9+Ap9tKfhLMi8lpB/nzIMY1qk8XpFpwOtU/lD/F
 UysqLmj7Xn2gghfdyE6Z8dUVWIxdudBUiX5uwCLB97E4XGlkYNlgy2MmbmCML3VHGv92
 apPrqJnOhalQ+YPPOF1rEDHBNbgk11+APu2tl4RYusZ1LfAC1mQpS/sBX39o5ETai5Fa
 ba4K2aEeyQ//juwjQtVZYgQIX2GfGHjY1KJ0/bYpJPrqExVxnc+huBxzsYLLYiaKwELJ
 gVWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745598095; x=1746202895;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=miui51m4WZP2t7QWrX7M4YCc9vTAHLpEYIHfWvaPVJc=;
 b=AYUT3WuRQ/jMxLw8KMtjrXUGHV4PR9VIyy99IfzCpq6JMoEVZjeu5L59fYIGkVgZfA
 EaJD8PPxDc6i63lj/ab+0N0LNibFYzooC66OHhLjMmgny7Wly4Iq9qs7VK0wL94UMydo
 jgjjlefOuSTtpQyMnfU6Yc+bgpfncPO3vELcIPJ2FSHt77NCP6dcf54IP9z2fKZjNuU8
 N4U+299vTF/4irA4KnjEmMIww4wwIh+kn4C15I9ISM/EAODTe7cXTnAwGGVBaeCxer6g
 VcvBaKDqj2tJdI9cIu6wrFIPqq8k7hrziYc25qXFGfwzNYD/rZOniW9GyJ6U219tuWUn
 fHow==
X-Gm-Message-State: AOJu0YzO6ArJevESpwohuLL53CLGAdWCLhXrcPj1hIzd3kUvp+NNdsXu
 NyUOIund4aLTdjgJ2cHei80BN4c1IcyHdI6kdQB3MGAyYNGH+I6U
X-Gm-Gg: ASbGnct45p0Eh9CRaC6DmKXyL40+ZLtzI+8XgEJyvhJiQ9kW4tLiLqyJazrsEZTPygo
 G5fG34+EMwY1k1G3cgZkZQhkVT5i/GmGxz89Ghi1I6O6mkjeez2vq6Epgm8lYZxr3E4/m0FLZnw
 dklElOLdzlrmQp7YziTPA/2rnMe3ER31AU5UXxOXmOhQziR6uqqeDWUKl4XKOEaaKy+QFgYlXC0
 zO/1T72R/9S3wn8yGaAYjmYp20mnv/Hzy97mEgBsSfqUzRobI7XCTNk4xjifXi7uJn3EkeYQaDs
 xroU6OW5KoA5lqjOX81dPb2KAoBrsp6Q1xSRzJSTjt3D673FtRXwCwruC+BJWOddrFdjeOhEtiq
 T5j2XKZv81AR6CYTMeg==
X-Google-Smtp-Source: AGHT+IH4r15Zg8te9VtVocCQ4X6VdzY/wiENsNfTtAry7CM91xfNgXbF2A8UYmfmOkkXVkMQrg5Gnw==
X-Received: by 2002:a05:6000:144b:b0:39c:c64e:cf58 with SMTP id
 ffacd0b85a97d-3a074f8fb0amr2706392f8f.55.1745598094771; 
 Fri, 25 Apr 2025 09:21:34 -0700 (PDT)
Received: from ?IPV6:2001:861:8c82:cad0:dd04:2330:98c4:e69e?
 ([2001:861:8c82:cad0:dd04:2330:98c4:e69e])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-440a53044besm29844955e9.14.2025.04.25.09.21.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Apr 2025 09:21:34 -0700 (PDT)
Message-ID: <2ad7780a-c006-4ca1-b4ec-637ebc13bdf2@gmail.com>
Date: Fri, 25 Apr 2025 18:21:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Flashing U-boot on a Google Nexus 7 2012 (grouper)
To: Nathaniel Hourt <i@nathaniel.land>
Cc: u-boot@lists.denx.de
References: <6f4dda08-7944-45f5-b454-3880f8af4d29@gmail.com>
 <61c0d2f160b74eaace0637d20f754821@nathaniel.land>
From: Benjamin Freeman <b.t.freeman16@gmail.com>
Content-Language: en-US
In-Reply-To: <61c0d2f160b74eaace0637d20f754821@nathaniel.land>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 25 Apr 2025 18:30:36 +0200
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

Hi Nathaniel,

That was it! I used the bootloader-grouper-4.23.img file and it worked. 
Thanks!

Have a good weekend,

Benjamin

On 4/25/25 17:40, Nathaniel Hourt wrote:
> Hi, Benjamin
>
> On 2025-04-25 02:38, Benjamin Freeman wrote:
>> Hi,
>>
>> I'm trying to flash U-boot on a Nexus 7. I've followed the 
>> instruction from this page of the Read the Docs 
>> <https://docs.u-boot.org/en/v2025.04/board/asus/grouper.html#u-boot-for-the-asus-google-nexus-7-2012> 
>> but I'm stuck at the "Flashing with the NV3P protocol" part. I can't 
>> figure out where should I get the android_bootloader.bin file 
>> mentioned in the command: $ 
>> ./run_bootloader.sh-sT30-t./bct/grouper.bct-bandroid_bootloader.bin
>>
>> Does anyone have an idea?
>>
>> Thank you in advance,
>>
>> Benjamin Freeman
>
> I haven't had a N7 in a long time, so I'm just guessing based on the 
> docs here. It seems to me like you're just looking for a stock 
> bootloader image to use there. If you have a copy handy, great, it'll 
> probably work. Alternatively, I found some likely candidates here:
> https://github.com/tofurky/tegra30_debrick/?tab=readme-ov-file#files
>
> But again, I'm just guessing from afar. Good luck! =)
>
> —
> Nathaniel
