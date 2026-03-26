Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 025BC10A62C6
	for <u-boot@archiver.kernel.org>; Thu, 26 Mar 2026 13:17:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D921883EAC;
	Thu, 26 Mar 2026 14:17:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nD5uU6tP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FD188405B; Thu, 26 Mar 2026 10:35:46 +0100 (CET)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com
 [IPv6:2607:f8b0:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C1438407B
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 10:35:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=blfizzyy@gmail.com
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-82a7539851fso370734b3a.1
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 02:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774517742; x=1775122542; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=aayZrFkxYTmxCNDfPVhBhRlyDTH92QcxxWVY3bBCC5k=;
 b=nD5uU6tPT43x7mnw4Dfh+tKi7f3oWiRHp5i4RVchFNAQZ2cIoFfU+5HdJybbW8Lcji
 DCaunp9D48rMCcKOp3EF2vZZ82bGvkYac2QhapCB5fxlf8qIqchVN5ahx+fBOlaHt55/
 nRPp5QDQ7d3GpitEaQ8rvFTX5XR3bcd84x2A8yX4VIAJZVAOrcAlsgWvqnCuE6zLPUnQ
 Wf4ze/7z4ZgldVP4FxQI+pILhylGfr5zudjj5iDc16E0eltZ7TvJdTTJzLagvuqyqGwS
 eSt7b11tEQip4myOrVfiH2UGLxDq6jOVupnXKUPvjpFjxjpdUy4ARuyOj9bFZVijXlHV
 jMbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774517742; x=1775122542;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aayZrFkxYTmxCNDfPVhBhRlyDTH92QcxxWVY3bBCC5k=;
 b=S5X4SfzBMl/5IR67L3Js0WHoaAq34c7Vr5vytBXvcxmu5t/B7ta8i4Ty6iruCuu9Ne
 NIKvZxUR2bniTNaxqugOHCjcZeijUZRnMSDUfgrQCiF+t/+Ng/OMkxa0Vw3l1AwdcONF
 IfqSHDkliXdYJJBwsrWvWgxGblYen/e9dFSLP088SuUhsXIG/PCtP8RuhJV6Hqe9JYmS
 3u2/f9TwHLRvMjJ1OvvcFGV+SEZezO/yLSx04Y9vwzi5kvzEaB9ovXFB7NxBFjhfn847
 8hsl0/6XVf5mZfDRdRYkWNqxFUbZHuqCLi06j8IyD4KjBBurt7/QhaW1dmMhfcPgfc+z
 QR/A==
X-Gm-Message-State: AOJu0YyWTz8qqoBI2Dx0vml3xcEZVWrCqiJvhJCdigdnr1U6RiPIOaio
 8KFMPWCUkaCvcJMz1N04LzRPlaY/dj/0zgUMJ0L3Q2HYntqKzcOIKCwK
X-Gm-Gg: ATEYQzyFw8MqPdU6TQ/qev08nh4OA/QJ0Lqv88F+7ARN9AofTmbRRxVneaxAZyEag94
 TiKJGOzI6NU5d+Zi89ZsFq7y+vvWKKwzG9FTmU13kCQuTyh40Mc73WxJcpYgwh6fX3DZb+x+KpR
 kCvl9x6RWxBq0IFxBipNdL6vGDkKrarok60ML1ihwolGxC0tbfKs2SWbC0NHKHycsXUULEB6a4P
 7tYdte/GXKTjAa+ckyNvFPwhfXFp9UgetyiFfmlaK8D2WmdEypwzwDMULh1AWDCstxK0Jx16OXl
 AJ/ljyqHuZvf7qDegj3a/s6deUoacnzsxB2y8ad7BS7iymZEsKDTz8rrG4rxpTwzlBO4ROBdWEy
 XeHWRY+X4Ve2AzefN64t2En1DjN9wZZy1ywtxDJKy6TM3jr4EOs9D+HJorhHZtuGMLwAIx7SPHU
 3ZIdw+A9url+4388Z7ev+BBV7iiGipfbSkOhDfbYiBMHo=
X-Received: by 2002:a05:6a00:4ac6:b0:827:3f79:2349 with SMTP id
 d2e1a72fcca58-82c6e1207cdmr6872930b3a.61.1774517741833; 
 Thu, 26 Mar 2026 02:35:41 -0700 (PDT)
Received: from siya.local ([2402:a00:163:2ce9:a0f4:f5f3:238d:9056])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82c7d1e637asm2129399b3a.6.2026.03.26.02.35.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 02:35:41 -0700 (PDT)
Date: Thu, 26 Mar 2026 15:05:35 +0530
From: Ajit Singh <blfizzyy@gmail.com>
To: Casey Connolly <casey.connolly@linaro.org>, u-boot@lists.denx.de, 
 u-boot-qcom@groups.io
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Lukasz Majewski <lukma@denx.de>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>, 
 Luca Weiss <luca.weiss@fairphone.com>
Subject: Re: [PATCH] clk: qcom: sc7280: add missing SDCC1 clocks
Message-ID: <72n75hetw5x5xadyso3woboelcbqiuiwiahe4y3s3vsa233gpt@ptcjznfihp3r>
References: <20260226193217.82657-1-blfizzyy@gmail.com>
 <89ee5c39-0a2b-4418-bd00-6e85345079d3@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <89ee5c39-0a2b-4418-bd00-6e85345079d3@linaro.org>
X-Mailman-Approved-At: Thu, 26 Mar 2026 14:17:19 +0100
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

Hi, Gentle ping on this patch.
It already has a Reviewed-by from Casey, so I wanted to check whether it can be picked up.

Thanks,
Ajit

> On Fri, Feb 27, 2026 at 05:13:26PM +0530, Casey Connolly wrote:
> Reviewed-by: Casey Connolly <casey.connolly@linaro.org>
