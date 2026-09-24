Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8552C98314
	for <u-boot@archiver.kernel.org>; Thu, 24 Sep 2026 13:22:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5F32A40BC2;
	Thu, 24 Sep 2026 13:22:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kfAzc8s2BBgv; Thu, 24 Sep 2026 13:22:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 4B08240B9D
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790256152;
	b=Ak7bTVA9U3izyuj17mznhrACmyrCrPvl8a4L8AKdh1fXs5e7a281c5tMjOQVnS7vUisW
	 A6nFHOA9MA9nUW3kDAsMm7qGLCqJQ3mGMxuI7nWdSsXz3Zct23r2H+NgBv9TWvro1U6by
	 0aimB7IcIKxh3Avq7BgdP4ii8Aqq1PjORg7ZwUYV0sOplh58aDJjOo2M2+9qDv2NlR1JS
	 XKsaJ3RJ8X5r8oXqtJHaM/aFwvtlx5Kg90QzFVOPlhNlrry3GdC39KyY4woXNZOQG61Xj
	 8oFqJNf9bhJhnrzuArHD0VYvGnJEIQF4bUerHqYaOtmWLe4a+E1jvXRVklln646bILQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790256152;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=dCGbB+PUc5PTQ8TCaAXS9LbfQdXNuBfmF7nVRxx1NBE=;
	b=FZV5veCHa/sw6NXA/SN44JUE2z127hxoifD1u0GmOBDcRYOFsTp1ClZKyzMVqmU7vZgt
	 9JR+nuxy0VYAwvsoYOkupRMeg+jU1z1EczauBjwXVtHHjXSUb3+o++HkRSl/ONCgTLtVh
	 6oT/dvckeciI8n12WUGUrHvNGb4t0WBSCKYbSuvEnrgdMj5PVKSMuvF0anw2cD8ZAtUXl
	 HdoNzwN76N09dhhIzAfymeuqU9tlN5RWNZOjC4POKm4BqaYI6KW1ffG8T0y8pAOZ9/+M/
	 GCG5qbHEj0iNO6sVaCAoBWdeLASjJnHCwXgQCLuE5hHBRvFteGk2/7UWNmYnmPpqAKw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=Ab+R0GGY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790256152;
	bh=dCGbB+PUc5PTQ8TCaAXS9LbfQdXNuBfmF7nVRxx1NBE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tyD3SuX/e6N+kyvilm6OLVbQ2kAaVeZPwZN9ezXK1f4ewfMB6Y1Gn9FnXISFPXiVI
	 4NyjMQ67DsqlhkcXlrYrelI7MZO4ejyxeU9TpGvxtVgd7GeFze+VoK4TGNuYyeJN5Z
	 m3+Ax/cvN6anGjcT3HCDiJZGq1lzWo+MkBGwkkoQjGNf+NN9vKXFGFB6cK1SY/9R73
	 IzK2or0fPyzX6ZqqMjpO/GDgFD6myH7a9nTU1urOhZwz/5IcgmdFSNVxtbQQo+e0eX
	 juTygXNnDcJjVA+ziHJBw17lFbJw/+ui84SFJ60o5vA41MGjsk1gOjS85GiodtyDpH
	 UwCDB80HH422A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4B08240B9D;
	Thu, 24 Sep 2026 13:22:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 04C13194
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 13:22:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DF2FE40B85
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 13:22:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id X-iodXHbUfBo for <u-boot@lists.u-boot-project.org>;
 Thu, 24 Sep 2026 13:22:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 9001A40B68
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:30::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790256150;
 b=F012Hks4yTyZOrQ/uBDx5aG5XindGU8SFPJ+USTPEocmlja1GhZhPH6973TzIFw/xzIK
 gaBA8RZSYuwuTOhDkbCAlEnE4CEYpHyoxhSWp2SWfFHCY8yd16LDad8bwITQrBIvkJWsJ
 b4B6xd6rLLTONqCvSSeMsVHVaihj8ELh9Fk85BfZNI0K1YxkXVLUyopN4uqk2glrmcv17
 PREyRPAkxiis9LuTA95MLnuhKfY9c64Dfpu8nCNRbVXZa6HY87ZyTMTlxQ3vqTpqYlqRZ
 FsqQ6d3kKyabP3clzA2Jy7uI97FRI5GJ+9Cxrw21jZmT7A7BMjGOjnwyA1//0bp9+Cw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790256150;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
 bh=dCGbB+PUc5PTQ8TCaAXS9LbfQdXNuBfmF7nVRxx1NBE=;
 b=WycoHowBy7puX5djY+lKR9L8CUa6Jw0gEoJDiGDfyXnlG9S6SCTOCAN/dLUetdhLOj+3
 E1jP516r2hLvtwhnYOhIZcPh+Tj9g6KOejPUuKupXUN/CPtGPPaDpCJFr5dqAzWCwm/AC
 VH7V1Xr3YcryIbxolGvhS+Vu7q42oBzUmuNVFyk1AppUui/8uL3n3UxxitSqj8fd+S4mY
 esHYrreD6BXMjqOp4PyxdiIKk5sfgdrulysyN0Q9xL87cRYLvB3iJ/pk/2riVMQCqrijF
 nW5KHCUave7D/eB8X7zCzu697DBNnqv5dijeMObxwqWE6ZGdye1v5X6R4hTcNc4xtyQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=Ab+R0GGY; 
 arc=none smtp.remote-ip="2607:f8b0:4864:30::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:30::10; helo=mail-oa2-x10.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=Ab+R0GGY
Received: from mail-oa2-x10.google.com (mail-oa2-x10.google.com
 [IPv6:2607:f8b0:4864:30::10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9001A40B68
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 13:22:27 +0000 (UTC)
Received: by mail-oa2-x10.google.com with SMTP id
 586e51a60fabf-46accbdfc20so1388463fac.0
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 06:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790256146; x=1790860946;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=dCGbB+PUc5PTQ8TCaAXS9LbfQdXNuBfmF7nVRxx1NBE=;
 b=Ab+R0GGYu2Ik1oO3Q85o08aAorz+F9T/RVTmuk2TFMZhXUxjsW7y+XAbKZS1JeUGxs
 02jyJ9HMwnDBchni8WEWoboXntmBnCXLLclvVWYdtrJ5fKFdwv3l1M5cXqIN9V+fyNOZ
 jfL5odD7nTz7xdOUp9GkBwZObAJV8cKuWknP8Xu5jvwZ2N9VnB/+N8oHp9VmyiaMoVET
 wiOUJNdXc+DO7LWoptWBI3fmdQqak7g4pGPXgnn2Nh9At79FVV9EE5QfP8aUzter7/WU
 iMlpKxPjyq/Jq86p2DPdJhj1pIsrmLgNNR2qwnHIaPZwtlBtKmCTYfQYCbQ5Q/AeL01p
 iQeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790256146; x=1790860946;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dCGbB+PUc5PTQ8TCaAXS9LbfQdXNuBfmF7nVRxx1NBE=;
 b=KHLN11jQpuqkCW0uryOTplvgrbwRLyG6vF91NUP6abi5OZGt7EYPOhu7xKHvEtv6nl
 3cMbMjJGEp8eHhUJg5UDgl3Hr+LTnrN84NYzeur7CtUQy+YhIs3ddzLzj2r4fSOwQ46W
 4eUDY3/mCX+CmPVE0zVt3c0l+nNc67n2fAX8RmeweVLfL9s1Wn8y3FG6Spv5G+s/qgB6
 4Hnb/PK4SI3faXYI33/rPWlm5yGUcH1bNhdkW3lrhZ6oSa4OjJp4zd1zPWVjM/zD58mL
 Iz2EEc9Ztg5pDz/nIa5UKXvXVl7CUATakENbSO93dS0N9aVd9LAxxxeZd9NMhTEI8yXv
 EyDQ==
X-Gm-Message-State: AFuF++ktvSFWSNejCp4cQVD7FmfMOknyLp7m5fO1M/U/QpVaDbp1KmyF
 ZyYKsZB7WHNUejmSoApmrb4+k4d8h+oumP+WV7SS6/tSWgO0XmOUntDvhlIwHhaVPL0=
X-Gm-Gg: AYBFou1t8YCgui6qOKbWJP9e8XV6B7d7hc8Ul78O29bqqS7W8Wl30k/5KhM7cmnFgaO
 atX52JPClJsKLtrAoXIqNcOxH05pBDSAScBc1bmpR8exMR1ebirbGvQYsLBW0Hysj/XDDmIdJER
 g6ewPAnPpJh9ye1jjbuaaB1aKxPgZx0+wtH6fEiFn8yabKJHGJBAY+n11AN9QKRscaQL4Kfyo/V
 o3/jFNhQ4P8ohgxGTR6XRnOOIeMPJwfRQSJtVJDCb9tcmD97t0AXRQD5WDwP7UfO0b1Pp+C2nAL
 VpbuwK62pwh4ImHC23e2z9k+f8l1x5cq3+ysEHLls/kmO5BLQ37hO4hb6LvXI0okA3gyVmqRz91
 w+NufWJMSan7tddDgSwZ8uxBxqsuxvxp7Cg7GCApYnexvUIPyAlbz1RMEK4FBwV2QHo0TwTOYPf
 2/119sDTGFxEyKpk1eN2Yj9nzjud5EyIxrV7VsVW1CNDML+D5135rj4K3c5sTtU5UlsPcCbr12G
 QMSOc+XNfhiJc5QPhAe12hAI4iojH4IBC3hBobzELgf3m5JfvLgxY0uxpQ=
X-Received: by 2002:a05:6871:c8dd:b0:48f:e25e:e203 with SMTP id
 586e51a60fabf-491e6df1dc6mr2603761fac.52.1790256146049; 
 Thu, 24 Sep 2026 06:22:26 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:7ded:edd5:63dd:4102?
 ([2600:8803:e7e4:500:7ded:edd5:63dd:4102])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4929ce6352asm488889fac.14.2026.09.24.06.22.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Sep 2026 06:22:24 -0700 (PDT)
Message-ID: <022fb3ac-a086-4837-a0d1-f4033fa53d15@baylibre.com>
Date: Thu, 24 Sep 2026 08:22:23 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm: mediatek: allow a board to carry the arm64 kernel
 image header
To: Aleksei Sviridkin <f@lex.la>, Weijie Gao <weijie.gao@mediatek.com>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ryder Lee <ryder.lee@mediatek.com>, Chunfeng Yun
 <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Julien Stephan <jstephan@baylibre.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Macpaul Lin <macpaul.lin@mediatek.com>
References: <20260922193031.785941-1-f@lex.la>
 <8edbca32-851f-4694-965b-677af74e59e6@baylibre.com>
 <20260923072204.1248855-1-f@lex.la>
 <ee2dbb58-bad7-4bbc-a86f-5a93193df3f5@baylibre.com>
 <20260923225350.1645617-1-f@lex.la>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260923225350.1645617-1-f@lex.la>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On 9/23/26 5:53 PM, Aleksei Sviridkin wrote:
> On 9/23/26 9:50 AM, David Lechner wrote:
>> It would help to know more what your overall plan/goal is. What do you hope
>> to accomplish by using U-Boot rather than the stock bootloader?
>>
>> If this board simply isn't going to work without a NMBM layer, then we
>> should probably wait and see what kind of response we get to a patch series
>> that proposes adding it. I found something similar [1] where it was
>> suggested that such things should be linux-first.
>>
>> [1]: https://lore.kernel.org/u-boot/0db3e5e9-d54f-4571-99a1-9e5f34bde685@kontron.de/
> 
> The goal is the shared port on the Keenetic KN-1012 (MT7981B). Port 5
> of its MT7531 switch has one SerDes, and a mux on GPIO 27 routes it
> either to an SFP cage or to an Airoha EN8811H copper PHY. Which one to
> use is only known at boot, from the SFP presence pin on GPIO 23. Linux
> cannot switch this port's media at runtime today, and the stock loader
> always boots the default configuration of the FIT image. My U-Boot reads
> GPIO 23 on each boot, sets the mux, picks the copper or the SFP device
> tree, and falls back to TFTP if booting from flash fails.
> 
> NMBM comes with the stock loader, and I keep that loader on purpose. Its
> TFTP recovery works whatever happens to the rest of the flash. Most
> OpenWrt users could not unbrick the router if a replaced loader went
> wrong, since that takes a serial console and the BootROM. The stock
> loader writes the firmware through NMBM, so anything reading it back has
> to use NMBM too.
> 
> So I am dropping v2, and the board stays in OpenWrt for now. I will not
> propose NMBM myself: a layer that remaps bad blocks behind MTD's back is
> what the thread you linked turns away, and it is not my code to push.
> 
> Weijie, the NMBM patches OpenWrt carries are yours. Is taking NMBM
> upstream something MediaTek plans? If it lands, I will come back with
> the board.

On the Linux side, rather than trying to get this in the kernel (I would
expect push-back on a vendor-specific thing like this since there is already
UBI) if we could implement NMBM using ublk (user-space block device). We
would need an initrd to load the rootfs using this. And U-Boot would still
need at least a read-only NMBM implementation. Just some ideas if you want
to keep pushing this forward.
