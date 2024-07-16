Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45C91C3DA49
	for <u-boot@archiver.kernel.org>; Tue, 16 Jul 2024 07:16:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E95948897B;
	Tue, 16 Jul 2024 09:16:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="UAbPTSan";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A93FF8897D; Tue, 16 Jul 2024 09:16:32 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 534268878A
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 09:16:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-59f7fb90a50so67642a12.1
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 00:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721114190; x=1721718990; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=un9F2pcmBqShnb4C4mS0OS6BlizSyRC+u/Qm23Sj2Vs=;
 b=UAbPTSanxTTka6w4oGhAvko5u/j5hQwfWuFVWhzi+dbuSDFAdXUqSqSUMZ9HEGbBqD
 obQkpJIxrAR7z33kkzfSBSStPE7dofJ85zcg/aEdwV90Y9WSbAICzSAw1cMC9FmqYNva
 8nXhIIPZ/EyDgyr6yF6mURtM0VAED+wiECsapEr4XPkyzKFOKtSNcYBMJbkdHKCb6uGV
 Oh1jlSfKTYiMoFQL/FWPzAuzawebGANSVqEDgBEesxv/9m77phZgXj+DC227u+FdYkug
 8Hf+YMqgldWyxuIngIfbFzifLVsob4fUiyQ+bWbxGX7UQrAMPKkyiiYdpTx51yC7kfTy
 vmjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721114190; x=1721718990;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=un9F2pcmBqShnb4C4mS0OS6BlizSyRC+u/Qm23Sj2Vs=;
 b=A076GwJkT7DLV10iXNTs/urW8GS2LUOniR1B/rrUyqiYBWlhVqBMHZ9cCvp2RAXtju
 fkjUz3mPoWFhGZ9J0GyVdsoATjsZg3/jZ1YI7IFXuG9QA99FH8JysjLw3bQiUzcQz2xM
 ZhRxSa3qDzFr8Cou//xaTpzX9oHU8Y5h2NLElxCS5FtA1wo2eDVD9aSqpV7GKQuTzKNz
 foR31Pqn3tnI2EYaR7swBpejX03O6AuPmr2gUnVEJnev650UdSrQlTVQMHS4NTqMUmIE
 bap9rkYcIRFdOEXdhTwKqs1n+/L8AtnVL+PxxT32b9JXdyejiY84eimN9JIkJFme9s27
 wHlg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVssoKW1gywGoEgJZmtJwpHPNRU2y6g6EdZrlBjuE6v71Gz+kO923M+CVX1HSZQzf6YvL42CpKbhFZDDCYnDgfA2ZZW4Q==
X-Gm-Message-State: AOJu0Yw+Gp3h3LG65KnEO4/PHEB0se09/AGp86EcSl8c/Y9uqyLFIbGC
 MU7COiYJ70dX7PNX3PrxKHgNufJgzWpITS5S92q2FaiAtO1NfKcFKPwoiC+vlRI=
X-Google-Smtp-Source: AGHT+IGf7haLDhe9Z4TezhnTADZUTbhO799kfWaIOSUqFke6oa07h5UQt+kzY9NDM8bq5h1uy5KSNQ==
X-Received: by 2002:a05:6402:3553:b0:57d:46f4:7df5 with SMTP id
 4fb4d7f45d1cf-59eef775ca8mr899364a12.23.1721114189697; 
 Tue, 16 Jul 2024 00:16:29 -0700 (PDT)
Received: from ?IPV6:2a02:8109:aa0d:be00::18f8? ([2a02:8109:aa0d:be00::18f8])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-59b26f61fbfsm4341960a12.81.2024.07.16.00.16.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jul 2024 00:16:29 -0700 (PDT)
Message-ID: <893fc8be-e4aa-46a1-9dd7-774a7f8faa69@linaro.org>
Date: Tue, 16 Jul 2024 09:16:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 06/24] soc: qcom: cmd-db: adjust probe for U-Boot
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io
References: <20240715-b4-qcom-rpmh-v6-0-0c948a25d018@linaro.org>
 <20240715-b4-qcom-rpmh-v6-6-0c948a25d018@linaro.org>
 <CAFLszTgz-SOFR+aV7f45+pfByLztAYU1kvFPZof665=QwjjoPQ@mail.gmail.com>
 <c1f036a4-a080-428f-84fd-c44f968d44bf@linaro.org>
 <CAFLszTj-1Pok7mJRGfR5fV20JMp5Hoe0r+4=p0S=NwtxQ0Gdgg@mail.gmail.com>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <CAFLszTj-1Pok7mJRGfR5fV20JMp5Hoe0r+4=p0S=NwtxQ0Gdgg@mail.gmail.com>
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



On 16/07/2024 09:04, Simon Glass wrote:
> Hi Caleb,
> 
> On Mon, 15 Jul 2024 at 22:42, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>>
>>
>>
>> On 15/07/2024 13:39, Simon Glass wrote:
>>> On Mon, 15 Jul 2024 at 11:08, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>>>>
>>>> Integrate cmd-db into the U-Boot driver model.
>>>>
>>>> This is just a wrapper around an in-memory database, so we just need to
>>>> get the address and validate that cmd-db is there.
>>>>
>>>> Since cmd_db_header will be stored in the .data section we can skip
>>>> bind if it's already set.
>>>>
>>>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
>>>> ---
>>>> To: Simon Glass <sjg@chromium.org>
>>>> ---
>>>>    drivers/soc/qcom/cmd-db.c | 72 +++++++++++++++--------------------------------
>>>>    include/soc/qcom/cmd-db.h |  3 --
>>>>    2 files changed, 23 insertions(+), 52 deletions(-)
>>>>
>>>
>>> Reviewed-by: Simon Glass <sjg@chromium.org>
>>
>> Thanks
>>>
>>> BTW, this is a MISC driver. Does it implement the read() operation?
>>
>> No, the API (as defined in the header file) takes a string and returns a
>> database entry. cmd-db users don't have an easily available handle to
>> the node / udevice regardless.
> 
> OK. The closest thing might be UCLASS_SYSINFO, but it is designed for
> inside U-Boot and uses an int instead of a string for lookup.

Right, I don't think we'll be able to find a more optimum solution here.
> 
> Could you use the devicetree for this information? What sort of info is it?

It maps resource names (e.g. "ldoa1" - the LDO1 regulator on PMIC A) to 
the address of the resource on the RPMh co-processor.

We need to support existing (upstream) devicetree, since this has 
already been around for many years.
> 
> Regards,
> Simon

-- 
// Caleb (they/them)
