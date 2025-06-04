Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 347ADC5B543
	for <u-boot@archiver.kernel.org>; Wed,  4 Jun 2025 11:18:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B5D8681FEE;
	Wed,  4 Jun 2025 13:18:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fqZfVBQy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F025982B07; Wed,  4 Jun 2025 13:18:52 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF9E480F9C
 for <u-boot@lists.denx.de>; Wed,  4 Jun 2025 13:18:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-442e9c00bf4so45222595e9.3
 for <u-boot@lists.denx.de>; Wed, 04 Jun 2025 04:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749035930; x=1749640730; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GbKM5NcqtbfCv8JKB3zd2KHDgWw4xszoTLK1BsuktI8=;
 b=fqZfVBQy8slCzni4MvUREUdehKaJSakdLnlj68lxXxiUw+W+ieXFrx+a2MulbeD2To
 X9VWLZcn8su04jhhuveiadbdsGB+gMuKbijH2npbKsYKvoOPwTqQ3LEb3Ufzz3vnsGYo
 HIUoGie53EX3uxoQs1Y4Hj72/W9CF6vXjK0L04IBDEIdVmsm6ztY432H7V5ZL4LTSXmY
 1yzeADdIkbmHmxJM69m5xITMgdLo09q9XQmd4VCmAntI4CLo5MT8eKu9eaAxPrD/7RMf
 fk6/HeTT5Grmzz+ti40s8fZXC99nQmmLOk1UQQeuTvyC62ec/0NI5c7Kd2MYpCFcghHE
 fuyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749035930; x=1749640730;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GbKM5NcqtbfCv8JKB3zd2KHDgWw4xszoTLK1BsuktI8=;
 b=lJkkxlhnuyTIF3GpTDVoX/ccnJxRFq2zra52ppfXUhWQszauQsH9QVvi6g4dGeSpgU
 mON44soxsFD5mdrM3yUnycdpk4ypHXyI/vTqcssZ8lTa8Er5X65B48wRx9rck57d/Cah
 t4Ykxk6eSisp6yh95PIfidMizCnrT3qQAIQ/WW8VTPu0J/NFw0lzlUqTH5WsaKTDL+3D
 mNduAxpwKTN7ev/PSGHVutiVPMJ4Cg2Ad1zh+9f47BZRpAHPZalYNAL6c28GHCDQyh5B
 G8Yt7+CYZNAyduOXibMN112L9FeBl/ezNimfONHAeZ5FY0DdM5IxMp+EbdzZzq6QIMZU
 TZEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVg08Nfjjyp3cTsnzZHye99ck78Ip/a3DLVl7FX6MiEumL1kJW6AJp9XKe+xRG9rnVo93bzn3Y=@lists.denx.de
X-Gm-Message-State: AOJu0YzX1pmXPc1hiHZLYOajVAn33TCqu6hdyq8A5CEVGm2p90bm4iUJ
 bicFUzgR2yxgQlcr1MMePHfHjzZuLc5Ro6VyEdO0iprhs9qnHkn9EpGnWEOytEbb8ac=
X-Gm-Gg: ASbGncssIsgDuCx7Baeo3EkxVa04nWkjAeL4Oi2urapemVOjr9HSqeI20Zi/E0q/geG
 WZ5R94dDRUSvScGTiSDrwark3aVQegv2GjiQIe5vu+ustKUE2xwFlBtEwkZ1XhhShUXIG32qMIW
 X3mEGQZSkWeB/ZDtasWi5z1MhZYc4uSEAMFtRh8FnsWYsL4HIi19k/SRWkh0+V+CS5S19i1s1fs
 Uuer+uCF8gxRheIjoph2vMV87taJlj/PuQHTEjSMYfI7BZSy1XypNoTIONS+6fcisrZZ/0ep176
 efefZf/1IkKBIC9A2sFvyw4D1V86nN5+83MYkDlQzfaJuRUarDh+SxafJR5Gcnpmj0AkNUQ4hXS
 3ks7SdEqRRHA/EWFGLD7QGNvN5Q==
X-Google-Smtp-Source: AGHT+IEYtu6QwEbicYYqub4fPT/tWtp9zQUS8iUUNm4C7Yw32R03oA3b3o/80WckZUQ74cuH2hA4WA==
X-Received: by 2002:a05:600c:6086:b0:43c:f513:958a with SMTP id
 5b1f17b1804b1-451f0a7728fmr22361955e9.13.1749035930121; 
 Wed, 04 Jun 2025 04:18:50 -0700 (PDT)
Received: from ?IPV6:2a01:170:117e:fc:968c:2df3:c75e:5a31?
 ([2a01:170:117e:fc:968c:2df3:c75e:5a31])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4efe6cd15sm21759146f8f.39.2025.06.04.04.18.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Jun 2025 04:18:49 -0700 (PDT)
Message-ID: <e7accc33-4607-48f3-9402-4e44575ac427@linaro.org>
Date: Wed, 4 Jun 2025 13:18:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] Qualcomm: teach the build system to emit signed
 ELF images
To: Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@kernel.org>,
 u-boot@lists.denx.de, u-boot-qcom@groups.io,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>
References: <20250602-b4-qcom-tooling-improvements-v2-0-c7d19c0d4a8b@linaro.org>
 <aEAM7dMRe82n5Enj@linaro.org>
Content-Language: en-US
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <aEAM7dMRe82n5Enj@linaro.org>
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



On 6/4/25 11:07, Stephan Gerhold wrote:
> On Mon, Jun 02, 2025 at 06:10:51PM +0200, Casey Connolly wrote:
>> With several new Qualcomm platforms appearing on the mailing list, all
>> of which build U-Boot as an ELF, sign it, and then flash it to some
>> partition on the board, we're getting a lot of defconfigs which just
>> contain a debug UART and a TEXT_BASE address. This leads to needless
>> rebuilds in CI of effectively the same image, and needless duplication
>> of build instructions.
>>
>> To address this, let's introduce a new tool "mkmbn.py", this is based
>> on the existing qtestsign[1] tool but is (currently) hardcoded to
>> only handle the Dragonwing and IPQ boards which use MBN header v6.
> 
> It doesn't feel right to limit the use of this tool to v6 boards, given
> that qtestsign supports v3 boards such as the DragonBoard 410c as well,
> which is also using the CONFIG_REMAKE_ELF functionality right now.
> 
> Which changes are needed to make this work for DB410c as well? Looking
> more at the diff in v2, I think the hardcoding of v6 is actually already
> gone(?), since there are entries for qcom,apq8016/qcom,msm8916 now. What
> else is needed to use this for DB410c?

Ah, another place I forgot to fix the wording... This should already 
work on db410c it just needs testing :)>
> I'm happy to test on DB410c if needed, just ping me in the chat.
> 
> Thanks,
> Stephan
-- 
Casey (she/they)

