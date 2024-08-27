Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A6CEC5472F
	for <u-boot@archiver.kernel.org>; Tue, 27 Aug 2024 14:42:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0C4F8895E;
	Tue, 27 Aug 2024 16:42:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LCiFG4WE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08F5B8897C; Tue, 27 Aug 2024 16:42:20 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9D8E8895E
 for <u-boot@lists.denx.de>; Tue, 27 Aug 2024 16:42:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-429da8b5feaso62135445e9.2
 for <u-boot@lists.denx.de>; Tue, 27 Aug 2024 07:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724769737; x=1725374537; darn=lists.denx.de;
 h=content-transfer-encoding:subject:from:to:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nSdCvvMuFlgAvIvWdxLczc5K5mJ0/JLgXX8qiU4N7Q0=;
 b=LCiFG4WEIT0SRTU/Vl85CpCstEWNWbk1KOYxSQOuNAYL9EkB2mM/abKhXLHJNpONhQ
 lspr43U1WqFTrSPNydtimNO9zwjjFJ/ekT74nTh7nh4/b4kpigYn00/8RpNdjDsWgpS5
 a8v4aqew/RJr1mIlUx3WWsDxDrx3LRpzcIjyfcf+UrDRz7Vk5sU4tF97ZUJVzuGjvQ5N
 /gauMgYZ4HOfUWiRFnuG8e3PkOlqCvHoT7ZmDeUZz1VStEcRgSR44wa9WiEJkpv4VRwW
 KBsxV6DCp8wyo91XbBSG7TDmkion5NGJf0q4knj75e3kuSpCLnbl/1+MgNVzbPPs9SyB
 2nAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724769737; x=1725374537;
 h=content-transfer-encoding:subject:from:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=nSdCvvMuFlgAvIvWdxLczc5K5mJ0/JLgXX8qiU4N7Q0=;
 b=RCgeGh9he2axQKW8lKNlmKTcgKVLr9epX+yfzQcHgFi9MD1Y2zfgq0DgEOiZRdEuyN
 Q6X6h72r/NGJhMnuWyJpxVkcZqVdSBGFwOJQQ6ZnSSLKayw+i3I3qV6eYN+1Jw2K9+dL
 1QM2Ww+A4SKdKc5Sm75s9jmYYRnW8KXzqVN7vFHrjc0H9vLvB48scEVJ1GQYGiimBrTr
 2P1u5iexDH4oB/srPC6LFvmlfdp2BSKPRxcOq9qsYm3Nox9apg7cfdBN3m6chMTDcXQa
 901jSq3mOD7a1z8OzjaUen7+pMEgyqhrCW9DkYeoaRtLdnsiTPI2fAhm+hGL59LIsrAh
 lccw==
X-Gm-Message-State: AOJu0Yym3BQekmhc473xDPtGpqfvnE0L0eEUC8dtL0kiJuXNY7kbyFOi
 bBNI4qI3nnUU4wAvbNfTTU0HFAaWYhjZacePh4GCo7ymtsIdzGqGBnh2vJgyuh/oN2H6H/wg9ma
 6HKI=
X-Google-Smtp-Source: AGHT+IEg2XrjewR5Wh9Alu8uy0ux40hdZfVGEjrND/47K9DCNvpI/EHuSjsHZx/x80meDwNl2Jc7Iw==
X-Received: by 2002:a05:6000:18a1:b0:371:8c0b:4818 with SMTP id
 ffacd0b85a97d-373118ecc0amr14072071f8f.63.1724769736573; 
 Tue, 27 Aug 2024 07:42:16 -0700 (PDT)
Received: from [192.168.7.95] (679773502.box.freepro.com. [212.114.21.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3730815b633sm13232246f8f.52.2024.08.27.07.42.16
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Aug 2024 07:42:16 -0700 (PDT)
Message-ID: <980adca3-27ac-440b-93b4-80146d050584@linaro.org>
Date: Tue, 27 Aug 2024 16:42:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: U-Boot Mailing List <u-boot@lists.denx.de>
From: Jerome Forissier <jerome.forissier@linaro.org>
Subject: imx8ulp_evk build with buildman fails every other time
Content-Type: text/plain; charset=UTF-8
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

Hi,

Can someone explain what's happening with the imx8ulp_evk buildman build
below? It either fails with a mkimage error, or succeeds with a binman
warning, every other time. 100% reproducible. /me confused :o

====8<============8<==============
$ docker run -it --rm trini/u-boot-gitlab-ci-runner:jammy-20240808-21Aug2024
uboot@42aa85c2d6b7:/$ cd
uboot@42aa85c2d6b7:~$ git clone https://github.com/u-boot/u-boot.git
uboot@42aa85c2d6b7:~/u-boot$ git log --oneline -n 1
ee2af844ba (HEAD -> master, origin/master, origin/HEAD) Merge tag 'efi-2024-10-rc4' of https://source.denx.de/u-boot/custodians/u-boot-efi
uboot@42aa85c2d6b7:~$ cd u-boot
uboot@42aa85c2d6b7:~/u-boot$ tools/buildman/buildman imx8ulp_evk
Building current source for 1 boards (1 thread, 24 jobs per thread)
   aarch64:  w+   imx8ulp_evk
+WARNING 'mx8ulpa2-ahab-container.img' not found, resulting binary may be not-functional
+WARNING 'bl31.bin' not found, resulting binary may be not-functional
+WARNING 'upower.bin' not found, resulting binary may be not-functional
+WARNING 'm33_image.bin' not found, resulting binary may be not-functional
    0    1    0 /1              imx8ulp_evk
Completed: 1 total built, 1 newly), duration 0:00:09, rate 0.11
uboot@42aa85c2d6b7:~/u-boot$ tools/buildman/buildman imx8ulp_evk
Building current source for 1 boards (1 thread, 24 jobs per thread)
   aarch64:  +   imx8ulp_evk
+WARNING 'bl31.bin' not found, resulting binary may be not-functional
+binman: Error 1 running 'mkimage -d ./mkimage.spl.mkimage -n spl/u-boot-spl.cfgout -T imx8image -e 0x22020000 ./mkimage-out.spl.mkimage': Fail open first container file mx8ulpa2-ahab-container.img
+
+make[1]: *** [Makefile:1126: .binman_stamp] Error 1
+make: *** [Makefile:177: sub-make] Error 2
    0    0    1 /1              imx8ulp_evk
Completed: 1 total built, 1 newly), duration 0:00:04, rate 0.25
uboot@42aa85c2d6b7:~/u-boot$ tools/buildman/buildman imx8ulp_evk
Building current source for 1 boards (1 thread, 24 jobs per thread)
   aarch64:  w+   imx8ulp_evk
+WARNING 'mx8ulpa2-ahab-container.img' not found, resulting binary may be not-functional
+WARNING 'upower.bin' not found, resulting binary may be not-functional
+WARNING 'm33_image.bin' not found, resulting binary may be not-functional
+WARNING 'bl31.bin' not found, resulting binary may be not-functional
    0    1    0 /1              imx8ulp_evk
Completed: 1 total built, 1 newly), duration 0:00:04, rate 0.25
uboot@42aa85c2d6b7:~/u-boot$ tools/buildman/buildman imx8ulp_evk
Building current source for 1 boards (1 thread, 24 jobs per thread)
   aarch64:  +   imx8ulp_evk
+WARNING 'bl31.bin' not found, resulting binary may be not-functional
+binman: Error 1 running 'mkimage -d ./mkimage.spl.mkimage -n spl/u-boot-spl.cfgout -T imx8image -e 0x22020000 ./mkimage-out.spl.mkimage': Fail open first container file mx8ulpa2-ahab-container.img
+
+make[1]: *** [Makefile:1126: .binman_stamp] Error 1
+make: *** [Makefile:177: sub-make] Error 2
    0    0    1 /1              imx8ulp_evk
Completed: 1 total built, 1 newly), duration 0:00:04, rate 0.25
====8<============8<==============

Thanks,
-- 
Jerome
