Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5EDDCFC294
	for <u-boot@archiver.kernel.org>; Fri, 21 Nov 2025 16:59:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35FAE83A3A;
	Fri, 21 Nov 2025 17:59:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="YS08NigX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD92683984; Fri, 21 Nov 2025 16:57:04 +0100 (CET)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B107836F0
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 16:57:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-3d56d0cb3dbso1317171fac.3
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 07:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1763740621; x=1764345421;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=z37/zJ+zzRIapSqF0JRVavOy4F+MqwfU8IYBvdMo+ZU=;
 b=YS08NigXh59o3goSbWcAYKBSm9tnCkgnHRvUxMdHwVcsP8Ee4XdJDzh7uz5CxT3oe4
 AEi++OFHbYGcM0ZG2PrbH30asitoAt56gStBxanIlDzP0v1kw/+eCIeKXgckdgokVOlA
 xhFFHp/xR+UYugxjIqDaypNcVEdTgz9nkEsuCRGhFbyaNWAThZx1pWuSTe1U51csgvI0
 Da3HZpb1wXCzhPkKkTEzEme4TjKXE8NQ1WzwdT1SADduSqRnQaKznrzxPt//Mehwjg9F
 QtdVaCZHaRIyzdcD3sdxKiQmKvG1QeZgt/dlJPyXdMXo1XPXu1aOT3z7CXeiMjiVXK1e
 uRKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763740621; x=1764345421;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=z37/zJ+zzRIapSqF0JRVavOy4F+MqwfU8IYBvdMo+ZU=;
 b=RhyhA2kRtpZZxytQyn4fwiMxCp63YmMpk8pLKwIeUDO6/ayGnRXhQs2QVEy67Wkqcu
 wCt4+x43wli0ETUu4pCpWNn9l5/PUWZPm+K/BGAZHA+bgFAnHzyjNtqBwsu6UXsj6swP
 CUZ5js12vIISzbYdeLazKo8UBfp37Bcj5pVEDgi/zqSkq34K5nVyztGAB8HgfYBVs4y9
 ShUy8zrNBr5mF1LsDOWRpnJtMUL/snE8U7k05wPMQ/3nBgB6mgtDRTEG7qZRe4NN7g8d
 S6oHqaAtIZwT/zueb9EKNjDHOeUYxevZAVcCh/HYRp8xOQ2O1GUzxHYn7VsJB+6zPi9y
 ztcA==
X-Gm-Message-State: AOJu0YzKV7x1xE2gpWFAxzmaCaqoKVLfsyl3jqGHvb4/60eYbaqBPlWC
 A0FdzH7kIHDzPiGXgn9OoeY+5VP3vM8KehvK086YQlkHet5vm3X3FO/8VQumgCoq8Hs=
X-Gm-Gg: ASbGncub7DglfGMyNRhJTzcXNtSYegA84tyHHNeJbAMvR0jYClUl/rU1mxPFeoCsQgn
 YZ8G0IAVH8TQT0sEFHleoTjTz2/0nSfecyMsPILsIWEHihj/44+7enuSGOUIVkzcyjSXRuS0HoF
 JKaRb7SwObQ/VMJS3k3FDIipqwVqrF4hqCyTDZqhe1AHSUkN0U7yV6qFWo4wyYpFzivKQpvfvgg
 x6QfPmdmrDWUjNbkNhBeGcXigJKGol8RE4gUL9ygTsENgYbtYi44XGwoyr+bZfBuEVguJopSB7v
 GHNk/Pynnj3UiTDMeBi6uIizGfFm5W30g5oo5SW5FCDURsRjy0/zUPx+ETlnbzmzZCv9EwFNKDi
 4sArbAwAle7miKyzCHcWYjvjjT3iNw+w/bR8cVRnOt+EFw+pla/z0SkdItb+O45MlqA+A9XcnlF
 64JVSEc6SgDlkf+MeiJasE31Xxej3JLUpC4MaJFcRf8mYaWC0SGz6R01g++g==
X-Google-Smtp-Source: AGHT+IEt23q7gCSJg98GEzHOVrkyUsLriGGkV3fQ3aWfTBHoDY2BtQP12qbi2B/aaQtXLTjTM7DxLQ==
X-Received: by 2002:a05:6808:f90:b0:450:b361:f48b with SMTP id
 5614622812f47-45112d2cc09mr1197901b6e.56.1763740621074; 
 Fri, 21 Nov 2025 07:57:01 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:d761:af7:26f5:f16e?
 ([2600:8803:e7e4:500:d761:af7:26f5:f16e])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c78d428f28sm2387692a34.30.2025.11.21.07.57.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Nov 2025 07:57:00 -0800 (PST)
Message-ID: <d78a79c3-cd28-4270-941c-a500bdff5432@baylibre.com>
Date: Fri, 21 Nov 2025 09:56:59 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] test/py/requirements.txt: add setuptools
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Jerome Forissier <jerome.forissier@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
References: <20251121-a-few-test-py-improvements-v1-0-bacb4148fb0d@baylibre.com>
 <20251121-a-few-test-py-improvements-v1-1-bacb4148fb0d@baylibre.com>
 <20251121143903.GY2125796@bill-the-cat>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20251121143903.GY2125796@bill-the-cat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Fri, 21 Nov 2025 17:59:15 +0100
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

On 11/21/25 8:39 AM, Tom Rini wrote:
> On Fri, Nov 21, 2025 at 08:36:14AM -0600, David Lechner wrote:
>> Add setuptools to test/py/requirements.txt. Otherwise, attempting to run
>> tests can fail as follows:
>>
>>     $ ./test/py/test.py --bd sandbox --build
>>     +make O=u-boot/build-sandbox -s sandbox_defconfig
>>     +make O=u-boot/build-sandbox -s -j32
>>     Traceback (most recent call last):
>>       File "u-boot/build-sandbox/../scripts/dtc/pylibfdt/setup.py", line 23, in <module>
>>         from setuptools import setup, Extension
>>     ModuleNotFoundError: No module named 'setuptools'
>>
>> Signed-off-by: David Lechner <dlechner@baylibre.com>
>> ---
>>  test/py/requirements.txt | 1 +
>>  1 file changed, 1 insertion(+)
> 
> NAK. It's the build of U-Boot that requires setuptools (specifically
> scripts/dtc/pylibfdt), not pytest. It was dropped as part of cleaning up
> the test/py/requirements.txt file before. A top-level project
> requirements.txt file would help avoid these problems, but we don't yet
> have agreement on that.
> 

OK, I think I see how it works now. It looks like most tools have
a requirements.txt already, but dtc is missing it. Would it make
sense to add a scripts/dtc/pylibfdt/requirements.txt containing
setuptools?

Then `find . -name *requirements*.txt` would make it easy to find
everything that might need to be installed for a given target.
