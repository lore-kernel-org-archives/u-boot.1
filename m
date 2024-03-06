Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84EA4C54E41
	for <u-boot@archiver.kernel.org>; Wed,  6 Mar 2024 18:21:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD6AF87CAC;
	Wed,  6 Mar 2024 19:20:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AqYy7zNB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C09FD87C92; Wed,  6 Mar 2024 17:48:44 +0100 (CET)
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com
 [IPv6:2607:f8b0:4864:20::834])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 756EB86F1E
 for <u-boot@lists.denx.de>; Wed,  6 Mar 2024 17:48:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chuckmeade@gmail.com
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-42eb3decd37so339141cf.0
 for <u-boot@lists.denx.de>; Wed, 06 Mar 2024 08:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709743720; x=1710348520; darn=lists.denx.de;
 h=subject:from:content-language:to:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=GeCmDl3wD/caUIipA2PfZHM26y5xdf29h1MTAErSnTg=;
 b=AqYy7zNB1WDljxEr53too1shPIpK9d8x5rTa+O2nQ3kRVqDkzq6lF43YaunJk38S2+
 5UPINhS0T0mVYfjq9qHwEbLAYlaySXoxwfQ9gJ7kGR6BgI/OyhTyQv/JSyrMfZPalA3P
 dPad2jBwjX20F9+dokjSlTX9JEXYmC2AJWBoLFtpl9HaAIhAeZMk/k95u9qvL+1aEB26
 M6vTn4x8pfxGVpfnaDeuYhGysfhA87RVYmYHmNLitKehFEn1fMxJGt/GIF+1oxlY0slH
 WduQEF6PDZhUjojtNNlIUM73dQCZE1SsNvIwwKRBoumTo7tQsLUX854DWXVuSGv5Dz7d
 yr9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709743720; x=1710348520;
 h=subject:from:content-language:to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GeCmDl3wD/caUIipA2PfZHM26y5xdf29h1MTAErSnTg=;
 b=BHL7ijuC1txJzevBPuhwvnZWa1eQUHC4i7mnGKe5UqDhll29nxOh1QfJb8cfaOu7gR
 YdD4gXID4ZiXw9PcA4y3hWBLSPqDTW0pLbeTFX7GTnPVs3Sqf02iMlNTjhu8TJZyBOMK
 wCNz2yp9oqvetEUY4ljQ6O6OACECCrRVjrYdSqufTw6qMIjgiiuvhIJHb7RPrbRkEBWp
 YSZRJZ6JhePezO0pD7Dg/Q5Z7/sg6NIT8XaanzANANN9vifhRp+PkFcXDFkpnn5Eaazx
 LtzXJ882EXRP8wx0HCjuaCXrnMH5Wpuy6cP8bzPm9PP1OPEYc0xW+LSxag+AWdAfrJxC
 mCuQ==
X-Gm-Message-State: AOJu0YyYX5Le0b6jCxwHaN2ivILP2TxyqOpZhfGUddP7dhKh5nC3Np7K
 YNvm0yoI2iXGaiVc1+6nVoMTYHDs0/1v+a4fFYHQpgb1laQ7qSMoLs5yl1SH
X-Google-Smtp-Source: AGHT+IEwOnWrM83yaenGOCbiWbfGuWJ/jeM74dd+fv/CJK7rjpVF4G7961C4HjMuyTixZuCrpXY/Kw==
X-Received: by 2002:ac8:5c0a:0:b0:42e:ec41:99e5 with SMTP id
 i10-20020ac85c0a000000b0042eec4199e5mr5847713qti.28.1709743720034; 
 Wed, 06 Mar 2024 08:48:40 -0800 (PST)
Received: from [192.168.1.14] (pool-173-66-156-160.washdc.fios.verizon.net.
 [173.66.156.160]) by smtp.gmail.com with ESMTPSA id
 m10-20020ac866ca000000b0042efa46a3edsm2404089qtp.42.2024.03.06.08.48.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Mar 2024 08:48:39 -0800 (PST)
Message-ID: <29244d1c-ec74-4d98-8137-aefabf4fe253@gmail.com>
Date: Wed, 6 Mar 2024 11:48:39 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: u-boot@lists.denx.de
Content-Language: en-US
From: Chuck Meade <chuckmeade@gmail.com>
Subject: Can U-Boot create mtdparts from device tree partition info?
X-Mailman-Approved-At: Wed, 06 Mar 2024 19:20:39 +0100
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hello,

In looking through the source, I'm not yet seeing logic that allows U-Boot to actually use MTD partition information found in the device tree.  Does this logic exist and I'm just missing it?  Or do I 
need to parse the device tree partitions manually and create the mtdparts env variable?

Sorry if this is obvious, I'm just not seeing it yet.  Also, if the answer is just to manually enter the mtdparts env variable, and keep it in line with the partition information in the device tree as 
a manual operation, please let me know that too.  I'm just hoping there is a way to have U-Boot get the info from the device tree automatically.

Thanks very much,
Chuck
