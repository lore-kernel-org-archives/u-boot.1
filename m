Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B848C41535
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 18:16:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4701787053;
	Tue, 19 Dec 2023 19:16:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Q9iX5uWQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89C2286F42; Tue, 19 Dec 2023 19:16:41 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B520487600
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 19:16:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=zajec5@gmail.com
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a2371eae8f1so149823066b.1
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 10:16:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703009799; x=1703614599; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CPjNNGRVl834dbVMwON3kgyUWofS8voa+GRP3e8W41E=;
 b=Q9iX5uWQnWZawPCEhTBALhb6zwpXXEKkCvGPJ9hn9TAl8WfCCZHM65RPDfF9kO6Eqd
 CVvULeirTJDyjgl3njF8H/6kn3td/aY3lJ7N5WC8IUGG4I3nYsVSCmnv4c8p/PaTI6KE
 sF1QhHLwF111KyuBlY65kebq78SJrp1Z1VSEuayjKqOcO4LFM+gbsUcQ3+kpBuyC21io
 av0CgEW+ePqWH2EAoIG1sJoOxDSsKQgmSXTMurOcqW2soq3uJhfUf+c/sclpC91cy2z1
 65XiNhMka6HAAj+ikiKRWETNGWObrmxmTDbDaMVRs9Xz4vtKtZx/K1uPUYlbLzwzOq9v
 +CNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703009799; x=1703614599;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CPjNNGRVl834dbVMwON3kgyUWofS8voa+GRP3e8W41E=;
 b=v3oH0QBi4C6YLsZ8G7VEOV/V+z6I4GwlnjozPN85HNpH+OgY/HMCwMy6l+FQXRADTn
 Td6KOfkP8zzVG3gBGDIt4ciWVqIseqLeIMkPka9nL/kCNhTSxmfAIWoFpMhpzupwAYwL
 1n5DPDTA5c7xl8z+LwtBLrjeffPmTEf1ydLuglD+TNugwc7k0MiTo3gUPZ062dMQKI5S
 mIJ5UzVdzDlPXZxL+XwGgMiXESl/7z23u01SkiIiYs/xtVssnpJe2eC058o7Y4mjmmCO
 U9/aHrRPE3QskJpeMvLC3Jh33ZQmXqqgK2pGkItQ4psBBO5oF2xUAcdV70d0dqOZxrPu
 YB1A==
X-Gm-Message-State: AOJu0Yw5Mr6lkNFI/1PKBXM2i6etDrpv6cujRSF/4msvGKNYkF4LkBKu
 32L6Ms/t9BRf6tN/WwMEz+A=
X-Google-Smtp-Source: AGHT+IEV+DYh2x5q129WtIIGrMyHM5JcnCzXLNDYXZfxxn9D5eLuxUTi3tapArS0fRpHMnXkfNXkDA==
X-Received: by 2002:a17:906:7481:b0:a23:1c51:40a6 with SMTP id
 e1-20020a170906748100b00a231c5140a6mr3630903ejl.104.1703009799151; 
 Tue, 19 Dec 2023 10:16:39 -0800 (PST)
Received: from [192.168.26.149] (031011218106.poznan.vectranet.pl.
 [31.11.218.106]) by smtp.googlemail.com with ESMTPSA id
 vv8-20020a170907a68800b00a1d2b0d4500sm15648822ejc.168.2023.12.19.10.16.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Dec 2023 10:16:38 -0800 (PST)
Message-ID: <1b5d4c36-9963-476c-8edf-e807beceda80@gmail.com>
Date: Tue, 19 Dec 2023 19:16:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 3/5] nvmem: u-boot-env: use more nvmem subsystem helpers
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Michael Walle <michael@walle.cc>,
 Miquel Raynal <miquel.raynal@bootlin.com>, linux-mtd@lists.infradead.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, u-boot@lists.denx.de,
 =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20231219174025.15228-1-zajec5@gmail.com>
 <20231219174025.15228-3-zajec5@gmail.com>
 <2023121929-salami-pessimist-c943@gregkh>
Content-Language: en-US
From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
In-Reply-To: <2023121929-salami-pessimist-c943@gregkh>
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

On 19.12.2023 19:13, Greg Kroah-Hartman wrote:
> On Tue, Dec 19, 2023 at 06:40:23PM +0100, Rafał Miłecki wrote:
>> From: Rafał Miłecki <rafal@milecki.pl>
>>
>> 1. Use nvmem_dev_size() and nvmem_device_read() to make this driver less
>>     mtd dependent
>> 2. Use nvmem_add_one_cell() to simplify adding NVMEM cells
> 
> Shouldn't this be 2 different patches?

I used to maintainers complaining my patches are too small and not the
other way ;) I think it happened two or three times with mtd subsys.

Sure, I can split it.
