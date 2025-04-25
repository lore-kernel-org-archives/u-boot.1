Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5385C369D5
	for <u-boot@archiver.kernel.org>; Fri, 25 Apr 2025 12:00:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C73081E14;
	Fri, 25 Apr 2025 14:00:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1745582404;
	bh=gZc9VNjs3l6OsaXOAcgC+KLx8LzMu0XUpVOfa5XijiE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=RnvwbmFHFIuKmOBsYbZnpWscCM/L3kPdHaB12igUKZglYunxP6+KdHwLYHpEpKl2T
	 g6QMXJOmKMM4+P3F3QdyTlgXH9lhHUw/abeKrpwA1VO/d9hvdh6E2Npbnvs8IxuZ4P
	 GIwRKZNHuLOdhhj+HDPgW+Ujy+HOGU0Lz2fduYuASwl1XahW7B6dahdXCbdQMUXSse
	 82cpPXcULxe4qjSBAFb2egAQP2S3oeRgluvgigCvg2RyZ4fEEKbSYqMokndoC4Dj/m
	 XS943NlaqYOXI4gJVrgE8e5On6u31Xgz3yHpqTnlVOje0m26U/ZFAfSHN6Syh1ygDs
	 yIHa5UPO+7VDQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54A1C82076; Fri, 25 Apr 2025 14:00:03 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5678B81E0F
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 14:00:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="AJW2oh9e"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 48EA810273DAC; 
 Fri, 25 Apr 2025 13:59:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1745582400;
 h=from:reply-to:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=gZc9VNjs3l6OsaXOAcgC+KLx8LzMu0XUpVOfa5XijiE=;
 b=AJW2oh9eH/nHR0feCGXii7ncwnp3EA9yztJtL4NbU4051CI0Yii8DSJnjeMOopkswRFszA
 T6GjuCF+xwji+i7ceixpZ3CyJ/HK5baoezYqsCIse88b1fOzCqj81UtWwlD9ERfq7W5LiU
 CIvuKgXfgoTYV/piHdvPxOjzbe1OV+OgobmKp4DfxCBHnWT5ZZimCpRjg3zct02+bsesEy
 8I5rue6ogHZ/HzC0QUPbGr6nFVZKCWQJZ/30XqXLHa2nDM6UgJ+7p4x7axTg/Tctw+1CmA
 xl76Vn8toZ0yr4Haxiaa+q0Bn9YHd+smgg+0XNHkXGBbtLM3VxBiVybA/hVUfQ==
Message-ID: <998d6b2a-cbb9-7134-7265-b22ff93b1a3b@denx.de>
Date: Fri, 25 Apr 2025 14:00:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v1 2/3] siemens: capricorn: enable text based default
 environment
Content-Language: en-US
To: Fabio Estevam <festevam@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Walter Schweizer <walter.schweizer@siemens.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Anatolij Gustschin <agust@denx.de>, Enrico Leto <enrico.leto@siemens.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
References: <20250416090419.54781-1-hs@denx.de>
 <20250416090419.54781-3-hs@denx.de>
 <CAOMZO5CPNY2tTF-dE9HMYBswLKX=idqkhw04M5YZ6sfPnHfcCA@mail.gmail.com>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <CAOMZO5CPNY2tTF-dE9HMYBswLKX=idqkhw04M5YZ6sfPnHfcCA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Hello Fabio,

On 25.04.25 13:43, Fabio Estevam wrote:
> Hi Heiko,
> 
> On Wed, Apr 16, 2025 at 6:04 AM Heiko Schocher <hs@denx.de> wrote:
> 
>> +initrd_addr=0x83100000
>> +initrd_high=0xffffffffffffffff
>> +ipaddr=192.168.251.1
> 
> Please don't hardcode the IP address.
> 

yep, of course, will remove it.

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
