Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D06A6C3DA49
	for <u-boot@archiver.kernel.org>; Fri, 26 Jul 2024 08:51:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27370884C5;
	Fri, 26 Jul 2024 10:51:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="coidwJfB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5081D884A9; Fri, 26 Jul 2024 10:51:33 +0200 (CEST)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45542884C5
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 10:51:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-52f04c1e58eso1448511e87.3
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 01:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721983890; x=1722588690; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tdiS/6XJ+IqeJCwTRjyMNnR8xB+UUQValsO5OlMLTm4=;
 b=coidwJfBtzHyznHJ57DMzb4OZEC7+E4cs/Rr3PMDmdCvFvjXXkEd2/hpkB9JGpoaO/
 EKcTaXeWZ9Ybk0vL4uHkErIKttNsLNmzTU0kuKk8NZCQqU3UJGBEK4KAh84b2P4Ukw45
 vg1dqzcn6ARXtQHvgIKsserIZKiubaqGKKAXxid18o2d1y0rBTbWA3UaUGcs8W9B5Vk8
 MLwCS/sP77UgFbRXzUrABFJ19G7VxDODFqnEDqWjSD7zc8fhsFbQmPo8K1IaCx5a72Qx
 xyZd9bpDBFONYBXwSHGE6xkfGylyqrlZuvGzk7K9V4/5GnF6KkRmHPzzCT4KrvlxCIyL
 qcVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721983890; x=1722588690;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tdiS/6XJ+IqeJCwTRjyMNnR8xB+UUQValsO5OlMLTm4=;
 b=dzw4jV2P6SVvkE1lNn4JeShZ+KNO59NAu8IxohdJqEBEBh4zLUTOAMVF6ixFyWwlDg
 U8c3r78l4x5Zoz2X7CMrm3gL5z3Acm+Tx6tq/ihF8RkIYg5L9Cd09/dIhDXymz+e/s7W
 Y8ozqVPNyy2tke/lOpXK0379ZEphPQ91SZk9x5qaKeQSMD6VLqbHBIovlXGDjkRPEp/+
 aM5hpAf0KVCVUKqYoCilULJAGjG04wQ/s9K85LuMv9GPAS2w5B4ncYUSlOyJRrlBtVPg
 GHTrLGQwNiokAMOeR64kMywipGgv6RL3qiLdLLqEtLJYSGHV55CLoVPChwQTlhFNMeRJ
 lmvg==
X-Gm-Message-State: AOJu0Yyghz8Kx3Bv7PAbXsjCk+04oPi6kQA6s/VWsOcpckSKoXoCtr7W
 Yg6k14azwbJEOwmJWlfq6sEnPKlYok8Bn2W/itLkKzVKYJKoJnn3yPXejwc+Wbk=
X-Google-Smtp-Source: AGHT+IFeTFBi3NUliFY63jC3B/fYMglDJdZrdgGJzh3sOnrQlFWgrMXGoRmd9Ow/FeQ8vQ+FiWGy+g==
X-Received: by 2002:a05:6512:2c95:b0:52d:b226:942a with SMTP id
 2adb3069b0e04-52fd5fb3533mr3971921e87.0.1721983890468; 
 Fri, 26 Jul 2024 01:51:30 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:ef99:2dfc:dad:83fa?
 ([2a01:e0a:3cb:7bb0:ef99:2dfc:dad:83fa])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7acadb9a12sm149147466b.213.2024.07.26.01.51.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Jul 2024 01:51:30 -0700 (PDT)
Message-ID: <174a7369-865c-4121-b45c-2f05eb02a2da@linaro.org>
Date: Fri, 26 Jul 2024 10:51:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 01/20] flash: prefix error codes with FL_
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Angelo Dureghello
 <angelo@kernel-space.org>, TsiChung Liew <Tsi-Chung.Liew@nxp.com>,
 Stefan Roese <sr@denx.de>, Peng Fan <peng.fan@nxp.com>,
 Jason Liu <jason.hui.liu@nxp.com>, William Zhang <william.zhang@broadcom.com>
References: <cover.1721910373.git.jerome.forissier@linaro.org>
 <1b22bbc08cb0841256283114db7ae117d97c0155.1721910373.git.jerome.forissier@linaro.org>
 <20240725181803.GB989285@bill-the-cat>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20240725181803.GB989285@bill-the-cat>
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



On 7/25/24 20:18, Tom Rini wrote:
> On Thu, Jul 25, 2024 at 02:57:22PM +0200, Jerome Forissier wrote:
> 
>> Prefix the flash status codes (ERR_*) with FL_ in order to avoid clashes
>> with third-party libraries. Case in point: including the lwIP library
>> header file <lwip/err.h> which defines err_enum_t as an enum with values
>> being ERR_*.
>>
>> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
>> Reviewed-by: Tom Rini <trini@konsulko.com>
>> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> 
> This is incomplete as for example 10m50 fails to build due to
> drivers/mtd/altera_qspi.c. It might be worth doing a world build with
> just this commit applied to check for other problems as well, in v6.
Fixed in v6. I have now grepped -w all the ERR_ codes and it was the only
one I missed.

Thanks,
-- 
Jerome
