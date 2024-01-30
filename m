Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B47E1C46CD2
	for <u-boot@archiver.kernel.org>; Tue, 30 Jan 2024 14:29:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2211087DE2;
	Tue, 30 Jan 2024 15:29:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Xp5HsmFL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A02187E1B; Tue, 30 Jan 2024 15:29:51 +0100 (CET)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC1DD87DE2
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 15:29:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dan.carpenter@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-40fafced243so2546005e9.0
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 06:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706624989; x=1707229789; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=myEWYBfNV/sNULqn+cuaYH5eI+NFy74uVrn+dJAmmZ4=;
 b=Xp5HsmFL5h2xe59v6aBpW3nc3Fbn4rRpPkYczve+BNOe4EpJDM4iEjEyCDgEvBRr5U
 JGtIJ31PbiEe5MQWT7c5JIooZ5LNMp6K4NcXff4o/gWt3NVctRc561t63DkOWmddj7ex
 Suifg0xFJyZ1gm5EGw5f+jXSpbHmV6OWTdgYV5DYlBgujoKHRcdyd2IR/u3SRy2soB9T
 ygfyaFXqJfmfly1Oar7dqponyGbI6tPtOac/FxHIDpT5zJztfrW9yUA3OWfCSB+Zc2aW
 Xnpo/YQFmdHSMRvJMy0i9sx9TqV+jnPs+w/hzHXH2lprU9lM2vo8ZSIVkajFv0Uocm5f
 2jug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706624989; x=1707229789;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=myEWYBfNV/sNULqn+cuaYH5eI+NFy74uVrn+dJAmmZ4=;
 b=KV90mYdE4Zqt/68639xAxjpKtaDMvm1spPp7vdrCAbdyQhcYJwttnyYM6bdU7wlrUg
 pI+UV7rr2tepAc6QvIarNQuorG3n4AunoHs02eQUhZllECxzA1dcEwIy9ND5C0JpGKXZ
 TQFRFsUd6FGQAJA+by2GOtLQgXJ17/b25NNXTyc3ubTjy4VIcQBT4ec/ZYmhDlFzZGaS
 /n/NPG8+JnhBtrizQecoUA/X1UEwx5JDeja7iFZ7VuvL6d9NhBq90zgJzwPUGSbsAFh6
 tF/Iuj+FY3mR64enCIlCcR/lz1XsuKKV4+9d63dec0LTfaLt6fVUbDDe1GnxYQe6TS5X
 c03w==
X-Gm-Message-State: AOJu0Yx1NJn3+VRecYojR2mymiaEbo7+n+eSjDxlPhMBfRFdHBGGEww1
 HRkoe+7Kh3mGPAqEXIe5qZPBBLDrWNEy2kdgbw28qNv5Fadby7EOg5q5fMVGltI=
X-Google-Smtp-Source: AGHT+IF1FbyNu1H9WCb7bE9lzvtlzjUilcOXvVqOouCP9e3qx8Gipyl4e2ATakXvkdBnECGcMg8n/Q==
X-Received: by 2002:a05:600c:1f93:b0:40e:8f44:68fd with SMTP id
 je19-20020a05600c1f9300b0040e8f4468fdmr7826166wmb.3.1706624989157; 
 Tue, 30 Jan 2024 06:29:49 -0800 (PST)
Received: from localhost ([102.140.209.237]) by smtp.gmail.com with ESMTPSA id
 g9-20020a05600c310900b0040ef2e7041esm7993474wmo.6.2024.01.30.06.29.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jan 2024 06:29:48 -0800 (PST)
Date: Tue, 30 Jan 2024 17:29:45 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Ramon Fried <rfried.dev@gmail.com>,
 Dzmitry Sankouski <dsankouski@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>,
 Stephan Gerhold <stephan@gerhold.net>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de
Subject: Re: [PATCH v3 03/36] mmc: msm_sdhci: use modern clock handling
Message-ID: <a427675c-e289-45f6-8848-833bf706e61f@moroto.mountain>
References: <20240130-b4-qcom-common-target-v3-0-e523cbf9e556@linaro.org>
 <20240130-b4-qcom-common-target-v3-3-e523cbf9e556@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130-b4-qcom-common-target-v3-3-e523cbf9e556@linaro.org>
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

On Tue, Jan 30, 2024 at 02:04:51PM +0000, Caleb Connolly wrote:
> +
> +	/* The clock is already enabled by the clk_bulk above */
> +	ret = clk_set_rate(&prv->clks.clks[i], clk_rate);
> +	if (!ret) {
> +		printf("Couldn't set core clock rate: %d\n", ret);
> +		return -EINVAL;

The if statement looks reversed.  Or if we want clk_set_rate() to fail
then there isn't a reason to print "ret" in the error message because
we know that's zero.

> +	}
>  
>  	return 0;
>  }

regards,
dan carpenter

