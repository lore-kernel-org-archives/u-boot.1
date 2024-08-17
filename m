Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 819B8C52D7F
	for <u-boot@archiver.kernel.org>; Sat, 17 Aug 2024 18:29:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D844E887E4;
	Sat, 17 Aug 2024 20:29:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YwkPJCNn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 580A488860; Sat, 17 Aug 2024 20:29:57 +0200 (CEST)
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com
 [IPv6:2607:f8b0:4864:20::831])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 408C088533
 for <u-boot@lists.denx.de>; Sat, 17 Aug 2024 20:29:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-451b7e1d157so20370281cf.3
 for <u-boot@lists.denx.de>; Sat, 17 Aug 2024 11:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723919394; x=1724524194; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JhP/cF+sQRDHYM7Ue7LdWP7aIvOLETUk7OqQEa/IsJc=;
 b=YwkPJCNnMk4B/U2NA6wlN4MVom2h95h8b1yuXshsZrqJvis7KYwreVjugB1ydav9R4
 ll0/yzSsbEgAuwN+Sr57Her2cvzQf/11sTwEL67ZQWWYbnpGsuydgtpP7z7wMDNKj0I1
 QL+s161tUL1+JpozQT1Z7FAWW0Qz9sb9hIjBCcZcNaT0rH12/mE5BEuC9SGVuYdUUOqL
 im9gtwQEnkMrCukKsmXi9LO9G2gebHYYdKrkolJwnmB8MEljdfVywXh2bfVHKVGknBb+
 vRfUq64sL8lQ2+w1cryOnma07oAJlw9tClBswBE+BuhhgM0S3R7gQlkMQxEb/tFuujKz
 eRBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723919394; x=1724524194;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JhP/cF+sQRDHYM7Ue7LdWP7aIvOLETUk7OqQEa/IsJc=;
 b=BFgpW9VzOhGJyngLnPlbE9fl5SKW1h+KZts+D4meKHluQvsuubh/hK9pUQiSx0uMAB
 W2KdyrLLl2fuZKzs2EJA+jfvSE0+2YvmQ748a947N67VeSOSsSgT+uzHPjNYpoe7npR8
 P0/aeRknDyXszxe19a6DgQIRsJvtGBTdxVxJ2f99Y0tWdGq65WNIXPmX0pCrjg5RQg05
 s5ubCpnuQSwUiIdCpmwSBbm5egvNippf/c0qTvC/6xEKObWc0t/msbCXQAzH1dvLhg1x
 hGV+HKD0w1gcNTE3JkHZqkD+iCTHxKcDqz2pLFZINe6Z89CBTmNQnseo+1NzG86IN5Su
 134Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0bH3ZsiJ/wPfsTR6I0ozhr4pbM7e6m2Hhw/blu6AAgqgpuaCS0FpBawW2ECbyh9yavcRVd4jb8xrsBHwkaY2f8Ma5Ug==
X-Gm-Message-State: AOJu0YyBxeoUwkS8J9Ni72ZsRBFO+2pFyccKpDSJ+vPaOGbMeDjQr4F1
 C+YgYXYjlnj31zKfgEAhT6lzNFMwltmsK7xIB51vaTVAfEqYEOv1
X-Google-Smtp-Source: AGHT+IFUfxnoER4qWcY4XcAtDZ+Rcz1wqfxFJdFieUoyzycx93EKjbnHSX6VdUwStukkSr49GO3f5g==
X-Received: by 2002:a05:622a:1f91:b0:446:5568:a6de with SMTP id
 d75a77b69052e-4537436682bmr92581571cf.48.1723919394001; 
 Sat, 17 Aug 2024 11:29:54 -0700 (PDT)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45369fd8fcasm27328071cf.1.2024.08.17.11.29.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 17 Aug 2024 11:29:53 -0700 (PDT)
Message-ID: <cd021589-a6d7-fcaf-83d8-a4af50dd6285@gmail.com>
Date: Sat, 17 Aug 2024 14:29:52 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 09/21] test: Update NAND test to avoid extra macros
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>
References: <20240810205205.3403177-1-sjg@chromium.org>
 <20240810205205.3403177-10-sjg@chromium.org>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20240810205205.3403177-10-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 8/10/24 16:51, Simon Glass wrote:
> Use a single test function with a for() loop instead of using macros to
> create multiple test functions. Add a message so it is clear what piece
> the test is up to, if it fails.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>

Well, the whole reason I wrote it this was was to make sure both tests run
even if one fails. They flashes have different sizes/geometries/ecc and it's
definitely possible for some regression to happen for one but not the other.
Having two test cases makes it easy to see this.

--Sean
