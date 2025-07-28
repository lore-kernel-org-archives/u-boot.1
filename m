Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76BD9C87FCF
	for <u-boot@archiver.kernel.org>; Mon, 28 Jul 2025 08:25:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3CA382F14;
	Mon, 28 Jul 2025 10:25:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="bXzOQP+Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9BC882F8E; Mon, 28 Jul 2025 10:25:24 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28ED782EB8
 for <u-boot@lists.denx.de>; Mon, 28 Jul 2025 10:25:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 25A363F078
 for <u-boot@lists.denx.de>; Mon, 28 Jul 2025 08:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1753691121;
 bh=0Lc6k35uHvxFhUSBNW/OEvxhLW7YJjJdNt751586sOg=;
 h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type;
 b=bXzOQP+QmdVaBXQqX16QRM64/aRm3Oftox7Gl8a1RZ+qDAIka9dGIgYOPYMLZoTNu
 I5BSy2O8xEX80d5ILJUVoSmhVETWa1/o6Xmbmt2gnrVedXcjKKi6ayv+aI3uZXfGle
 q2Qxzw9Syq6bwhlgZjC7FN82L78FXCXUpqGURVEnVASc/o8fmtTIXiAy+Q+Uy7DGpv
 ouX2Pgk+5KrOkogEaous5KCAHr87g5Tsr534cfjuE/md0qOXF8lfY7ZVWbsIElPWId
 vAB37fFu3ymi/sOwxiYPOUh1Tqj+WulTq1L/q84xqBxdVrLuRwlWVzS7S4Eo7XwhDd
 KsqmeUMjoji+A==
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-af374d9611eso381002366b.1
 for <u-boot@lists.denx.de>; Mon, 28 Jul 2025 01:25:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753691120; x=1754295920;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=0Lc6k35uHvxFhUSBNW/OEvxhLW7YJjJdNt751586sOg=;
 b=iE4Exr9Ia9cLlHlPeFESE4zZeOVDBDLgU//N8hP6JrYkWzq3q67on31Jvrypgmjx7E
 efo4A81hhzd77EMeniFCRPRHowQm+/w2F3yRQqx35IBW1ow2IxkD5tlsboES3aQcvbuJ
 /IXL57Sk+3gtaR9FQ6i9ZaE6yT3iSOLoB2It9+3LfmfdqthcvozniLRkECDQM5ES08Uq
 FMKesUVxcA26VkE1qmHAswQVoW8j4eDPkn4lQnhfoPFuBY8Evy7D6w4v39+ycsagXP65
 9lxyMewaPCkVM2nCnWB+fk7OKbXOJ3Afm/spDvOLmn2m1QyulzK+KRiIOAw9OnSBgM8q
 XyyQ==
X-Gm-Message-State: AOJu0YxSEAQU5/XXn2BcoR6pjHI0Q540ImZ3yIvxp63fLDkL0IS+FG5p
 3HRcV9xSrUwUBrlgvJN5jcqTyTKG1gMOIaNehPylRAUB6/to4/wfiqln8FLSlsBqGXxd6CHwLwp
 mLXT/piXhck+o3hPaab9OLpPr0ILT8A6vquwU48FNqphkzFwkQ6xAXg3mmXlTvNDDCZRxAVQbRJ
 ZXRXJTTA==
X-Gm-Gg: ASbGncsbBhJQb3vCvlgdePWan6aaHvgqL7O8Qs6Xbvyue0jzU+HTb4kl5sbkrYVv5Xg
 siADEf8If2thGFCj7Hgpw4u2hhFgP1vJwUz0m3lEnW3iSbcr0b9EbI+Et8NWiKHHBhyW09o6iOU
 3K5zJJFnkkwtjGRiYgKZv2n/Zpa+gqJkYETuqe98BmtNSLeR1sE14021HFxQz+aBtkLDkFNSXWD
 oET3U6mQRg6osl1wkxe6RRkcczhRHskGKFeSBZ6MZkng/JkPGJcxXU9JY/ACiq1OXsv1DsgbN/U
 MB0FzJudpH+7E0GYuaXC23jkthvpdg7q503vyYWPHGWuzuk4VyD561DdqYAIyGDIzTRivcpsb/3
 qlrD5zvF15PlkQ3iUQSLToFZqW22Ukr3J+2U9
X-Received: by 2002:a17:907:6d27:b0:af2:4535:7334 with SMTP id
 a640c23a62f3a-af6192f6106mr1123987066b.50.1753691120683; 
 Mon, 28 Jul 2025 01:25:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHDMGlJWoBGU528SCD3GbILIzDoYaXQg5O+evQVIwx86+vMd+UrR1Dol5Hxv8ulMaNb7iEJjw==
X-Received: by 2002:a17:907:6d27:b0:af2:4535:7334 with SMTP id
 a640c23a62f3a-af6192f6106mr1123984666b.50.1753691120231; 
 Mon, 28 Jul 2025 01:25:20 -0700 (PDT)
Received: from [192.168.103.102]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-af635a62af3sm392169266b.84.2025.07.28.01.25.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Jul 2025 01:25:19 -0700 (PDT)
Message-ID: <cf0fb712-40fd-4ea5-b0d1-1f923bc088c6@canonical.com>
Date: Mon, 28 Jul 2025 10:25:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass
 <sjg@chromium.org>, Jonathan Humphreys <j-humphreys@ti.com>
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [BUG] test_efi_capsule/conftest.py fails
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

Hello Ilias,

Simon pointed me to this problem:

https://source.denx.de/u-boot/u-boot/-/jobs/1208907 has this line:

SKIPPED [9] test/py/tests/test_efi_capsule/conftest.py:103: Setup 
failed: cp /builds/u-boot/u-boot/board/sandbox/capsule_pub_esl_good.esl 
/tmp/sandbox_flattree/persistent-data/scratch/EFI/CapsuleTestData/SIGNER.esl

The file in question was removed by
659f97eb1fc3 ("scripts/Makefile.lib: EFI: Use capsule CRT instead of ESL 
file")

Best regards

Heinrich

