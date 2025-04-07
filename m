Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFA34C36010
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 13:55:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 572B082D0C;
	Mon,  7 Apr 2025 15:55:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="e4824lwY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B04D82EA5; Mon,  7 Apr 2025 15:55:21 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B393F82CFD
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 15:55:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43cfebc343dso28672775e9.2
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 06:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744034118; x=1744638918; darn=lists.denx.de;
 h=content-transfer-encoding:subject:to:from:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5D5fvk+F8WuGiT6AqKqh3yh7dDGXDgJt4eyJiFymGj8=;
 b=e4824lwYIcoopqCn00zxK8cgIg0+rIRrAROv4x9KR4Z3Az+S4HPpA9hmJxNypWcjrd
 k8DTTSGqnl6oALP1BbFjTibHwgeFgYzUPstXkNRJgu3KKfCqZOhnGxi8G53Kj3Ib/RhK
 sySVApUuH3nSTK8KX/ZdDxEz0nUFrznKOo9u6VjybwfMmAOqhNxtcgrXNTF5Olc8KgD3
 AR15NszQGxMu5yZ3LO1+tCQfUoF6COfojSrjCK4u56raECZihzz8wZV3rqM+sHRPwBmP
 wrW5aSylJ8QmyYcdLGYTTa8GhEWWSIV1UhAfsKus9adGBD09Zlht6YzpA0CCQxswD0c2
 m3Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744034118; x=1744638918;
 h=content-transfer-encoding:subject:to:from:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=5D5fvk+F8WuGiT6AqKqh3yh7dDGXDgJt4eyJiFymGj8=;
 b=IpLQfDIZ0XoBvbHVD+6SVb36z9I0NIshAom9F9mRCRsbauxdLMNRF2RdaQ1oXL6g1E
 4167Mwr1i2lSBk1VEfBwYYJ27LOisSNf5sAWfGVKXKhytbQLW7ojsyMcnooLfohEAPxB
 6m8zcS9UMJ5srJUCyU1+T4gbi2kmbJHrMzX7c2qZEmKHfrFVL05ACg6smgYujR8FDE/a
 cf/dHBLSJXjqh1Bjxyaa0utpZPMVxykNhP0iHDMjj8vzIEG7xvPjS+M5Uy+cnyKdQ4Qv
 FX0lQJLtx4UwY6GVeog0W6S+5Qk8NnnkBJxpNRBiZXOVZkvXnA5dGcSgcAws48qrLBR8
 NNNA==
X-Gm-Message-State: AOJu0Yz5trbW9Hj4CYhcCtssa9BeNLVDtmIrnFXN2tNWtOIabhuAERxg
 ZROioTVINaPqQxS4z2hnhTJDdEjAypg0KDpC7dPAfr5Bl9oJDEzOoLwC46l/P8xR/EAGJSeWdv9
 f
X-Gm-Gg: ASbGncuCmqMOUn76zRfVHoPyN+gamucfjIUQ+F8/OwkbHN4NPJCczx3NufrlraF1oQ4
 UKq4/oYFFIqV2DMipRUppml8CAcYKUE9gE/ODTi5aq7sBnwcPZPrHFjQlH9inv53inyjKZ4MmRr
 W8IGnTazIixqtTZ4bb0532hmiKhReGQb7Aqf70Juwq7kUevDboD7UXJtedxduiZeOoCHIABA7Cl
 MGpJfEKHs0GYP+ekyOuHoQzp9M9DQbju/ahvLz4gcph4rwDQ1DDKVO0ROOKsGNgHqmIRJxejG8v
 Uxdb4Dzl0bIXmKgNyUqzeEXtYcA6tf3p1aponLLZv2HFn5NdBsVI
X-Google-Smtp-Source: AGHT+IFF3aSKuTLbcqMO2nN8mzTXn1HYuMoxJLNqmjnh0mMbMjGmjvvlzMV026Jq4rXl3Ww0q2Uw/A==
X-Received: by 2002:a05:600c:4ca7:b0:43c:e8ba:e166 with SMTP id
 5b1f17b1804b1-43edd3bd698mr52263365e9.22.1744034118184; 
 Mon, 07 Apr 2025 06:55:18 -0700 (PDT)
Received: from [192.168.0.24] ([82.76.24.202])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec1795db7sm137383405e9.25.2025.04.07.06.55.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Apr 2025 06:55:17 -0700 (PDT)
Message-ID: <7a737a5e-c804-4d46-be33-28aed9c4a113@linaro.org>
Date: Mon, 7 Apr 2025 16:55:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Eugen Hristev <eugen.hristev@linaro.org>
To: open list <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, joel@jms.id.au
Subject: Gitlab runner timeout on evb-ast2600 ?
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

Hi everyone,

I keep getting an error on running the CI loop on -next on my tree :

https://source.denx.de/u-boot/custodians/u-boot-at91/-/jobs/1090517

! _pytest.outcomes.Exit: Lab timeout: Marking connection bad - no other
tests will run !

Any clue ? It's been like this for few days. It doesn't look like a
faulty patch.

Thanks,
Eugen
