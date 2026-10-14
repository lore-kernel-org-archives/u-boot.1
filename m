Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A473ACC6B1D
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 12:23:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 62D0380DC2;
	Wed, 14 Oct 2026 12:23:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XPzsFojnr1ht; Wed, 14 Oct 2026 12:23:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9EBE380DB5
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791980584;
	b=GRrHbXv5TAiFPoRRs0iYwBistIlL0o3RjY0r9rXauCkn/hu2XKbV6x1wanPMSsCdO7fg
	 BEFG93XjrahS6e08z/ZHP7MFWIU5PbEsD/hurc3A3pqBH7CE8IULqOcLJumKabdVSXdKw
	 xBMaQg2RTcWUyVzQMakfMhqCc0s2yL6L2GVOq4HxCYnDypVYADu3ZSQCkhn7d/xvoYmpO
	 gsSNEovLAT1hdTNNMKWSCTuIUi0BFNfJ1mItv06sNrR5lv39cKteSUiHK5HpY39U1/L9X
	 gbn6zFMStH+UznPCajdEb5PdBo9wg3qEO6hZ9YQN+WBJWNw1ZFTRPV/x1xcay8BO61A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791980584;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:From:Subject:To:Cc:References:
	 Content-Language:Autocrypt:Organization:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Reply-To:Errors-To;
	bh=iwaPxAJjh8W4IHMCsOF5IbSgfdShjVUK5LHn4jS4v64=;
	b=Dx6pFCMtM5JSmKx31nWk+klK+dxqcKwfaSIsAoLGfOKpxd+CTrWRfL33P03b5XxnEOgu
	 F6EUBwGlgeafT4xrCpFVYQU6GnC51boNv9rSC9LscpEqEdgt0WeWc/JsDD2bA+81jkAsL
	 zVvlOhlFRoYPOi4CzN6mHWF0IUybGloX95XoawuMvY14/H3GtWbiSEaeNOmP2igIaOvLP
	 XU/w9Qkcl2vkXq341uvZJrGrQJ23lCwslja+kXRG/hNncnAwfq1Xde5zxYmKhTzN9cSrc
	 hK1Wdr+XW+LqdM9IB/4l8DCnfUc2TOY9YGbLPEr9FvPPNcA9g9Mw60wmrzbUJkcU9sg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791980584;
	bh=iwaPxAJjh8W4IHMCsOF5IbSgfdShjVUK5LHn4jS4v64=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=mPywmmIXZ60w/hNYk9WfF5fqhmPbsOxOdP1iRRJPvHJdX543SMizpFh4HcbPKfYOO
	 2DXQ09ezxZyVqTLwPmT7rJSfTPQuR5CceRcftsXdEYVmg2QSQFDAH52Lh2D8pupgrz
	 hu2j6F9vM1tLoQEiDqaI7fCSElz56agrfkkzsBwHTKyx6wFP4ZatzciNnU6FjPBscu
	 63qHNUXHOfIMMIK7gnSbtVURJ3cCCEgfPedcpzCvj9Yt7AjMNAwWwgMYiUDJHYnkDh
	 I9R7PCtf1JTTp9LoEqLsWNxv1E/zrEJYrBvyUKX4f1XWx97lJQTsxEIXYq3vjgfOAo
	 LhKQEmV4vprpA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9EBE380DB5;
	Wed, 14 Oct 2026 12:23:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 63D002A8
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 12:23:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 558494014E
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 12:23:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9G-T9EBkvcp0 for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 12:23:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 47598400D2
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791980582;
 b=rmiOJmWcA5OXsJf9j+9AcbbyWVNmfr4BH5+e57c08Mgn+TrqHdego51cdgAqO1fux+ex
 Yi/06DJkzfD4C22z7cKu29/t0mO2sm9xFLuZRDpsmIxsO8Pjd8HYuZvErUlUo91PrYvAc
 t1zwsb1SKXmoY2SXJckSskf6OB1aIzyiJhCxSSuGYmG25z9XptXyU10ZxiAulS8kwULZe
 0KIzTVpiQUVCDTM//Zs2aYxOTwPtyGx37VZ4rxitxCj+4HfO1VDQy7WE3IrU90/Vlq7W5
 J2gIK5vi0+KeC+Hq+l9mfmdQr6b6Wkf6nK+4XZHpX/0RjeLEIFWgieFsZ5ZzRSF3CbA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791980582;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:From:Reply-To:Subject:To:Cc:
 References:Content-Language:Autocrypt:Organization:In-Reply-To:
 Content-Type:Content-Transfer-Encoding;
 bh=iwaPxAJjh8W4IHMCsOF5IbSgfdShjVUK5LHn4jS4v64=;
 b=HqEa5c7tmLbHmf/Sqd6ogQ+A3+McD1CL5wDJx7wLYFJh9cADzdEmX0G909cU8HabFVH8
 wiJJtpHA4EKG4AWGL8WN05ZLmLVZ8zcZi1MwWrOBCRhvDLPpP35yymHEEwN4tFKP8XE3u
 rYsyqBphm7svsJ83YCDzNO9QK+n1jtdgt59DrZytprwkxfYO8HxZqOFm6DZ15UQBHhUvv
 LYDNMgiiJGFNaH6qAhIbZTT9tWye4zsPbmdC8VUSwgX47gnG3zl0zHniRdFmcfX6WUO9Y
 e0yUpkBeZrPEzDSSZ6lnNZioAeV/JdQQbtyOJvNPBxxLKDP4qyTuIMp12pVIxThkh+g==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=b4xg02kx; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32a; helo=mail-wm1-x32a.google.com;
 envelope-from=neil.armstrong@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=b4xg02kx
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 47598400D2
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 12:23:01 +0000 (UTC)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4a17baef589so8179345e9.0
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 05:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791980580; x=1792585380;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iwaPxAJjh8W4IHMCsOF5IbSgfdShjVUK5LHn4jS4v64=;
 b=b4xg02kx4Z9DzpI3gqzjGZJGlPLEvgbOZ02kUpfwyuezOjUfvf3X21PRliQXTsmrZB
 ffc4dqh1c7pw5f3hRFJRJlEvCFOkAGnVij8b45KM7CvdKjXOWk3yLyam6ruam3MPKYmR
 7VEfvkM1/ZFWPyXTC4nr0oEY1CTwk5TnWJ3kl66HTnE3E3AGmRBXf7mLjergO3XiYHbL
 ZZSHLkUPryg+UsNyAuYqOSTzFzGM93Q7d6OtDY+ztyS9iqnOFynV/4g6ZwxciC62PzXF
 ca+Jj4jxJ73n3xDoqMK9E9oAtf0cgrI7650P0Z2cCtkmRIBxTx6YATRucOSbD9V1Txie
 X8WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791980580; x=1792585380;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=iwaPxAJjh8W4IHMCsOF5IbSgfdShjVUK5LHn4jS4v64=;
 b=FwtLXmqnpmpmFweo1VfqZIoU/yPU7oIqpiuywIuug28aJdEbzDvwTjGdgZHKYMNKcl
 QDzW2KTnM2wEc5c63M7s31LvaOqcGzKrUNJFf9uY6gGnWiEI1CCOOstJLOeAo9AFaZda
 b6QvrFlekked5vtQolaxBC5N6iZnFnGayZU7+wnAneGVKC7bcQS44IHKtCkGvFf0idMx
 e8RZiNnxZf5OfJdRry55fjeLn0BkLBW2hkhbG8Yh2A4a4SyQyeiYMeHQeAeWCCesvyeA
 EbLSW3IRoawNCMm2HgTy6iCc7XN3gvgVAP78BhoDwbbu1iIR4HzG9LK2ID0lqNSTqJWE
 N/Qw==
X-Forwarded-Encrypted: i=1;
 AKwUvBz9l+0OsOojY/B4xd0R5y1ohU67s9xSR6yBcoBK1RwkUWfKaPEQQKYivD1BEkYNohsTZB13N9c=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIo7IsGjeqnekNK2vNRzsLIjAzDjLQXWbPrDvrCbn8HCL+JYZFK
 KWA5u9yPHEpHrJy6hZwdF4Yw1xvTDY5nP2EXQPPeclTh86C36vkt6/YZb2eGV9U/yHo=
X-Gm-Gg: AYBFou1lJye714YJVF0sOQCOsj2rA0FxHhoXud4iETL8svVf5ELrP5VJGwEYZ3vKMF4
 gnPQRJPO/wMB0je/95Ny75kCcaoqD2uzjd1YAeCm7gU3PS14szxcG49E1AM9279oW3/SPLOsva/
 fpGKOf5XvEQbpYyzW1BLS51/eNn2NnNt0G4kePGpuThcquummOKzKAj3fO8eGfT6lliWrzZaQSQ
 rO5VBS4FKxsqUzbLKgwgtnMfisk5rbRgkox41EUrf32G1KAUTL32TGx3KWE+O9WngTExGB7jsyB
 vRJRmLJwIjjiym73OzocPmPcLh0yZWCQI5oi4G3gT3gKDJMEtfooJixMfv83rWW96PC6jINKvCO
 lwqPgeUjkDjJorAsohBzUQHwgl3eri1PMyBYG+4QzBDzwIoUEwye+YbQgZ9xV7MBKEg5zzN6urf
 /XdkzaWDl7hWnbBRXxWU1n+9xkU3xPNIU1TcsNxBrN1GsG8QqkKuXHg1wsI9UOnH9Gfgwvz2sst
 dYz0ZI65lmR0s9sAris4sQh822JU+utGWMYjcCayEriYhdbO4hEiBA/MU2Ua+va9g==
X-Received: by 2002:a05:600c:6215:b0:49f:ff32:8044 with SMTP id
 5b1f17b1804b1-4a18e47a88fmr286744425e9.7.1791980579675; 
 Wed, 14 Oct 2026 05:22:59 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:fdbf:f373:6d5b:93e4?
 ([2a01:e0a:106d:1080:fdbf:f373:6d5b:93e4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1b2fc4724sm50258505e9.2.2026.10.14.05.22.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Oct 2026 05:22:59 -0700 (PDT)
Message-ID: <fb54d6d0-abe4-4fba-a66d-fac75d1a6895@linaro.org>
Date: Wed, 14 Oct 2026 14:22:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH v5 3/6] ufs: add RPMB transport over SCSI SECURITY PROTOCOL
To: Stanley Jhu <stanleyjhu@google.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
Cc: dlechner@baylibre.com, trini@konsulko.com, jens.wiklander@linaro.org,
 ilias.apalodimas@linaro.org, peng.fan@nxp.com, jh80.chung@samsung.com,
 tanmay.kathpalia@altera.com, bhupesh.linux@gmail.com, n-francis@ti.com,
 xypron.glpk@gmx.de, s-vadapalli@ti.com, michal.simek@amd.com,
 jbx6244@gmail.com, marek.vasut+renesas@mailbox.org,
 sumit.garg@oss.qualcomm.com, jens.wiklander@oss.qualcomm.com,
 u-boot@lists.u-boot-project.org
References: <20260918200641.2286077-1-jorge.ramirez@oss.qualcomm.com>
 <20260918200641.2286077-4-jorge.ramirez@oss.qualcomm.com>
 <20260929032920.1391393-1-stanleyjhu@google.com>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <20260929032920.1391393-1-stanleyjhu@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On 9/29/26 05:29, Stanley Jhu wrote:
> On Fri, Sep 18, 2026 at 10:06:35PM +0200, Jorge Ramirez-Ortiz wrote:
>> +		/*
>> +		 * A power-on or reset UNIT ATTENTION is a transient
>> +		 * condition the device clears once it has been reported,
>> +		 * so retry it. Any other failure is final: stop and
>> +		 * report it.
>> +		 */
>> +		if (ufs_rpmb_sense_key(&pccb) != SENSE_UNIT_ATTENTION)
>> +			break;
> 
> This retries on any UNIT ATTENTION, e.g. 2Ah/01h (MODE PARAMETERS
> CHANGED), not only the power-on/reset one the comment describes.
> Would it be cleaner to also check for ASC 29h, as the Linux driver
> does? Commit a8a34238e5e6 ("scsi: ufs: rpmb: Retry power-on UNIT
> ATTENTION on the RPMB WLUN") in the SCSI tree retries on ASC 29h with
> any ASCQ.

Probably, Jorge can you look at this and check that we only retry with ASC 29h ?

Neil
