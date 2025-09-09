Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75795CA0FED
	for <u-boot@archiver.kernel.org>; Tue,  9 Sep 2025 13:20:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D82083106;
	Tue,  9 Sep 2025 15:20:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=munisense.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=munisense.com header.i=@munisense.com header.b="Wefcg/vS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 316CF8312A; Tue,  9 Sep 2025 15:20:10 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29619830B4
 for <u-boot@lists.denx.de>; Tue,  9 Sep 2025 15:20:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=munisense.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=gijs.peskens@munisense.com
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-b046f6fb230so176893766b.1
 for <u-boot@lists.denx.de>; Tue, 09 Sep 2025 06:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=munisense.com; s=c12e0d22-ac12-44f1-aa93-b49ab5265a0e; t=1757424005;
 x=1758028805; darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5+oQLsEhFRvHTkKH6zMT2EQaRJC6n+el7Z94lWPnyoo=;
 b=Wefcg/vSt4jaGBM8LwXSw+B20PSQnq6HemBRRHhARskyy9cOZJAOh6RrIUS2OOWV8U
 VnI0ORrZZgVzYNJ5xBE+V6zI9rjcXC//7aZ2gMhwfUDCwQLiFEOcXU52q4R+vXanm6ep
 J7ELAK6tyd4DnLecc7oLDynbTfc0zY0n+bQLkEV/6DdzVQzXCJvW5+Ju1bzqMSH2Q1SD
 8fBAxOMd0XcJjbPeaAS1gux+R5kHqg0gIx2VIGvWAf2DwjqQV+dugLpTIwuvRQ/FvWG4
 V0r+3/IABxds+riLWlETwPZTsOsc6zVl+UqQjnyoatBZ89fePGGKJskN16dtKojldFnr
 gEzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757424005; x=1758028805;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5+oQLsEhFRvHTkKH6zMT2EQaRJC6n+el7Z94lWPnyoo=;
 b=Tq+TRWC569N+JLY3VJKuOtTL7xjEyqNLL/ZuCvdd2dENmVK4DGh+4jKPKo2BKj+2Qu
 OIECDF7+nvSs3vTfhc0Tm7naGY8+q2hb8WeqLbLTP4NXh8hoIEa2BXAvNgQSPq4pdujb
 Qs1nDBnQIPtHvEq5epP1Q8WBCZ0kQdPkhy/dreQVsBHoDK3oWY/Uxnb/fGiZu4QAPFVo
 xtmkEsC9AtjutOl9ByFxcb0MH9Ckjq6NdOMTTqKZQ6/ntK9c2uCacEE0LwgLUtHI+cBI
 Sf7eLRyzvdbCIH+NjukS7NNaxpCZdKHYuNDLKYpt8yn7dtX7DZqjnIb210kEVi9bPZxq
 oIfg==
X-Gm-Message-State: AOJu0Yyt0XFt/V8NSrStAWV+PdacUhC5KnSkuahBml3iuUbVQ0PPCXb5
 W+Nyl7Lhi/4b04kuUnXg4wYZAnDnmVaAEgLJX694RXcq8679SND5M2doStmIlF6sBE64z/ssUds
 aImFM
X-Gm-Gg: ASbGncvp72mgHAAH53AhnTQZGfRXlQfz9AtNC2ZPZPnQtXZXpKb+SKa4mznHnr1G0Ei
 +/ugILUzkm5URYNQpBSQ6atcmEh2vKiDidPL1UCheOsOYGW8V2n9WR2ic4uezf2qx0/4+2QizZc
 qQn8tvTPPnoYw+MH9aNMgkwzaiA6YjPDcz9TNZIk8IBTI3kMEx6GT0SZH+JH2aM5glrblPv/AoM
 9F5LiHu5cuBTEkg5zru/k82xbwUKmuS1Aw0C3jSUsV/mWEvuTY0KRbMdVck8Cxn1BOM5ZHtHM/I
 7QiirXULOerysX2iF0z6E7Ihl8+oaeB7XHtAGgjUPofhn8/EaD5VMAVXgI+/7Z2wDEsHiSqKmdv
 +AYezFOZJH7L4MH60HD32diTGduVs7t/695zmF0gR1cCFCBQ8rqUwfsKh/FMSPM60CsZr7SCJz5
 h3Mh7JuSo0M+APSg==
X-Google-Smtp-Source: AGHT+IECB7aiN0plszdSZnuh0w+LWDzrONmPTaE0rvY35t8LK8aLekNwPJuPPjtDSY1XpJ30JccYGQ==
X-Received: by 2002:a17:907:724a:b0:b04:1957:8e71 with SMTP id
 a640c23a62f3a-b0493245e11mr1610789866b.25.1757424005264; 
 Tue, 09 Sep 2025 06:20:05 -0700 (PDT)
Received: from ?IPV6:2a00:1708:3ba6:500:9fed:9c57:d5ba:9f44?
 ([2a00:1708:3ba6:500:9fed:9c57:d5ba:9f44])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b04279a59ffsm2131199366b.60.2025.09.09.06.20.04
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Sep 2025 06:20:04 -0700 (PDT)
Message-ID: <8c41c1dd-6d96-4bc6-aab4-38a8e3ccc078@munisense.com>
Date: Tue, 9 Sep 2025 15:20:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: No console output on Raspberry Pi Compute Module 5
To: u-boot@lists.denx.de
References: <a09a51134c3d66a9644d2aadb15c99558ce5e7e7.camel@opensuse.org>
 <CALeDE9NwpDJ4_to1Z6L+N1WqL4L_UgegyHqShDvTYTc7Cc8tnw@mail.gmail.com>
 <c0daca70b93929d62a90b2e51a935d4b3e91456b.camel@opensuse.org>
Content-Language: en-US
From: Gijs Peskens <gijs.peskens@munisense.com>
In-Reply-To: <c0daca70b93929d62a90b2e51a935d4b3e91456b.camel@opensuse.org>
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

On 06-09-2025 01:20, Jonas Kvinge wrote:
> On Thu, 2025-08-28 at 12:05 +0100, Peter Robinson wrote:
>> Hi,
>>
>>> I'm using a Raspberry Pi 5 Compute Module with a sourcekit.io
>>> board.
>>> I'm not getting any output from u-boot to the console, I get this
>>> with
>>> CM4 with the same setup.
>>> Do I need to change anything to get console output on RPI5?
>> Well at least on the RPi5 the console has moved to ttyAMA10 from
>> ttyS0
>> so you'll likely have to update something, it will depend on how that
>> carrier board pins out the UART, but it works fine for me on the RPi5
>> so I suspect it's something config based.
>>
>>> I've added the following patch for RPI5 which I found on the list:
>>> https://github.com/jonaski/u-boot/commit/2f60b5d80b3a08d480074e8230ada543bfa42401
>> The rpi5 is supported with the rpi_arm64_defconfig so that's not
>> needed.
>>
>> You also don't report what version of U-Boot you're using. There was
>> an issue with the serial console on rpi5 producing gunk on the output
>> but that was fixed with 2025.07 release.
>>
>>> My config is here:
>>> https://raw.githubusercontent.com/jonaski/u-boot/refs/heads/rpi5/.config
>>>
>>> Jonas
> The series of patches for Raspberry Pi 5 support
> from https://lists.denx.de/pipermail/u-boot/2025-February/579540.html
> aren't in the master branch, are you saying RPI5 is supported without
> them? Does the GPIO and console work for you without any patches?
UART console (on the debug UART, not the GPIO works), at least on my 
CM5. Anything living on the RP1 chip (USB3, GPIO, Ethernet) doesn't 
inside of U-Boot.
I believe PCI-E also doesn't work (i.e. NVME), but I'm not sure on that.

For my own testing I've rebased the patches to v2025.01, which enabled 
GPIO en Ethernet for me (haven't tested beyond that), you shouldn't need 
it though if you want to just boot from the sdcard.
> I used the latest version of u-boot from git master at the time of
> testing.
>
> Jonas
