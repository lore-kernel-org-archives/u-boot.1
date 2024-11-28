Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB0A7D69114
	for <u-boot@archiver.kernel.org>; Thu, 28 Nov 2024 15:21:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5BF48894FC;
	Thu, 28 Nov 2024 16:21:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ukRYZHJM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9598389500; Thu, 28 Nov 2024 16:21:31 +0100 (CET)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C96689384
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 16:21:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-aa535eed875so131612066b.3
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 07:21:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732807289; x=1733412089; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Kzj5wLz+6xLHHvIIbmJC4PeUQV80CuW8IEGwPqiLnLM=;
 b=ukRYZHJMYNDduGRyk0eVb2aP8PvfYrt8+4bOtFnUgj/7TE6nVon5EHhUvNM0NqKk1c
 xOdyi5qG8OQOADK3aMbskH7PKk/4SktICpsI6LDrr4cUg0TpPL1eky7jhin8HkJwco6Q
 +R+toii3qsJ4wwWhjoCkGk1A9QYUa/zwtgX/IlHqB+blxoElUn6vxWDzhsWa6BayiQ46
 2fwrD659e9nAzVeZmr5QeJt0ftb4fIJlaDOoKErybTQpwb75eiqrGHta9I1yh3bBTi/y
 iUX1PSUb6EEkM6lxvcgWbcJ1ZgIkOgwqofJgUgTuXF+8SKAWPL4gKCPBgqiCaHfFF6wT
 uBpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732807289; x=1733412089;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Kzj5wLz+6xLHHvIIbmJC4PeUQV80CuW8IEGwPqiLnLM=;
 b=CxvPw/PCCk2/xMi5DgfyShjaXJQa7ECgMD3xCgcqT1Tr0VsuduZkpOZqKW8A+C4PQ0
 e5X/Kt6nzqByR38lqK8mtHWjOLdbj9kt0HxaRz6vL6rcob0hVrUuHJOZfHTlyGpbiLH3
 jZWfGW4zHuLTi+/yaKgUqDR5vdPQAEnDkI6eG2r6oJFJKCuivv5p7p++yznDhpsJB8Oz
 F3s1vcd+ftDATRhvzfiba+pivd2XoGjbumWREwT7O0cXMfs1x6qQlUK0rW1lAqJZ4HEa
 NaQr29BNsManje8aJH7aGriQqGUBK483X4Dj/H1qM1RR3ogcZhHcdD0fdPhI2E9gHN5o
 cogA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXivObicSKbbvypcixpeJwsqaUvtH8geck7SnEIu3Ffphn4uIJMV1jMceT786YjvWW/KViYwvQ=@lists.denx.de
X-Gm-Message-State: AOJu0YyYRFRKShzz9q6sFCWKdrwqhzsAAHYC3J9C1VYDRr6TguVuF9LA
 PeKWeeqygj2IwZ0kwI6SExy6+4L/vwGXfceWNh4ctuqBRjKtL/Q8T2k+HF+3VIQ=
X-Gm-Gg: ASbGncvJnZcltDAmRIdEgEFlBnAikgVJfUe30Kjndg01PrFzj8eejAKj3X0xBpLBcvG
 mlhr57c0svBWjdg4Ub/SKRbSvzOoOQ/AHWCmo4GcM2hV0vDZPln8mq8nw5BWWHDpBMLs6ipWNls
 hasUKASKSR4FbBI5AmxaDewkqia8R9vaM4ofLfk2q3jiMJcEW1GY+tjPd2dpb/qe+kxo1Oj8gTT
 kuFNMSVLR4ImfbDCYxqWI8uT5GY83J3LZPOppTTava/N7uIEK8tj1WN2cCFVnyYx0vvlaoJhz9p
 tsPDw2fwtiXWFsy4HWwNSXQpIYqtDg==
X-Google-Smtp-Source: AGHT+IGnyzymBrvgpcB1qnspl+NUjv2omQ0nAKoA0vyUQQ/tHfptfB96dqzXr/Voc1KU9rnVpEx0oQ==
X-Received: by 2002:a17:906:328f:b0:aa5:4b7f:e705 with SMTP id
 a640c23a62f3a-aa580eee492mr586819566b.1.1732807289027; 
 Thu, 28 Nov 2024 07:21:29 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:869b:f8c3:dc94:123a?
 ([2a01:e0a:3cb:7bb0:869b:f8c3:dc94:123a])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa5998e64a8sm75913966b.130.2024.11.28.07.21.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Nov 2024 07:21:28 -0800 (PST)
Message-ID: <13227e59-010c-412d-8209-b6e39683038e@linaro.org>
Date: Thu, 28 Nov 2024 16:21:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] lwip: wget: pass port and server_name via wget_ctx
To: Adriano Cordova <adrianox@gmail.com>, u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, xypron.glpk@gmx.de,
 ilias.apalodimas@linaro.org, trini@konsulko.com
References: <20241128151919.605791-1-adrianox@gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20241128151919.605791-1-adrianox@gmail.com>
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



On 11/28/24 16:19, Adriano Cordova wrote:
>   Commit 5907c81 ("net: lwip: Enable https:// support for wget") was not
>   correctly rebased on top of the changes introduced by Commit 6cc4d04
>   ("net/lwip: wget: put server_name and port into wget_ctx") in next.
>   This commit re-applies a  couple of lines from 6cc4d04.
> 
> Fixes: Commit 5907c81 ("net: lwip: Enable https:// support for wget")
> Signed-off-by: Adriano Cordova <adrianox@gmail.com>
> Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
> Changes in v2: changed commit name
>  net/lwip/wget.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Reviewed-by: Jerome Forissier <jerome.forissier@linaro.org>

Thanks,
-- 
Jerome
