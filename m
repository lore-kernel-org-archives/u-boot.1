Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1833DEB26E0
	for <u-boot@archiver.kernel.org>; Tue, 10 Feb 2026 16:45:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5CBA383D7D;
	Tue, 10 Feb 2026 17:45:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="e0qsv0ll";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4BD6483CE3; Tue, 10 Feb 2026 16:36:00 +0100 (CET)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com
 [IPv6:2607:f8b0:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C399883CB5
 for <u-boot@lists.denx.de>; Tue, 10 Feb 2026 16:35:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=nathbappai@gmail.com
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-824484dba4dso872953b3a.0
 for <u-boot@lists.denx.de>; Tue, 10 Feb 2026 07:35:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770737756; x=1771342556; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wv/TxLBerZOCFMMZYbw1OQ/ikNSoZoHK5iO+aN3FX3g=;
 b=e0qsv0llQRjB2KQZcYgiQLtg1p9CGlLH8Q8blv7O4izK+xnZrLFyWjbigRW0oYJjki
 6t8LShup5Htx8ww02meo09a+A079F/DIybQH9i1ueD/R/unLTA9XzN0OcIhRphILzhwi
 7hQvoAXZxsKCPsn8K/Q31rm8s/EiddhaGRFGCeruThy2wQFZYrriwZwwkrJ7uwv5Ydg8
 oMgdds6tNngxbCQttokAiLGbTLjPNP34Nu104qvU9qLGLrzvxvEHu+902Hyv6du3lEHO
 JlthCLalWH9QUHkJcolP92rUPnz1RhYWado2ORZhUFTtJROy7FFewSu5kDBbaJKa8OMG
 YUPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770737756; x=1771342556;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Wv/TxLBerZOCFMMZYbw1OQ/ikNSoZoHK5iO+aN3FX3g=;
 b=EBZCDWLujNHVmOztyMMnWyYDZwMvQZS1bk49XGjIc2zhuPULXbJGylb/9yt+SFxg+p
 IQMUpUbxRfRnIneLePk2pkndGBOdGY2IocHwikJg5E4A72ytDBjxtqNZkVm7ru5w2Hab
 FKT8jxio3vfWPURwYluGA/Fo2GFJuqzlOGMEx4C47+YHBJGRnRAJTR5t+vEKRKhymfRo
 pGr1xzRbUhDzjg/nPxkRJp2GcDDbzG1wbZIpgSxcwM9HGBaoC28vzXG3WjTjAE8zD410
 bmB0J5b322rQAeqhQ0Z1W6FOoOURbkXWCOaXYWqFePFWXIsN4H5qI/GztoUiqLvvoylw
 Is0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSYcHxSb1tXvGc2SjbNpZbNAZcvam6pYIKWHDWRseqoLcIGYlCPwSxrRmcXYgAyfC5gODMJhI=@lists.denx.de
X-Gm-Message-State: AOJu0YxWY8GyVP+iXpxkT0q20Ul6a1ZzWxLWBaXu5+CZDH1xByGIJSK9
 CyiKOhWBpxKBRzx/gKBOHNL38+Arn5k9XCs1ZpwwOFiLx4FWiQgUdQY7
X-Gm-Gg: AZuq6aJiuIYngcmdKpuic/Lg/cQ7gIHrgTyeSuMozCd4ei8xhxUNwAafnL7Yvtd4p5W
 x251DeR6/WkmTeqMynXdcIykNg5l8ldw+MWj/D3pyUHhgn2AYZMWurkr/PLfGFhU2IDerSelXN2
 3uGp14Xou0qyTNWjzREumGtcwOWWdD3vyJS2M2xblhUT0dLLmzfeaxl8zsrmRC7acKFZh1ELOiL
 JuO3LWfO74y1mKbHh53FFGE+J3ZH5DU5fU56U4cbINZGKxZOU4pvM+WZk51e6GPuYdFsbqFFB3P
 +MAPNYu2z+QOxHfItN/h5MqhRuKR0b4dG3RhIxlcOShh/13Wa1ogm8kvz7KdOuT6rSJxsgtdAjp
 LRKu7yOoKVSGBl8GrdaA6EQiVJn//xqOSPeNns0sw85uhUxsHdWTXnfyQ3SufD7wMA32khJKgGa
 CuVU/SFjX9IALPHNRf9VM=
X-Received: by 2002:a05:6a00:450a:b0:81f:9c50:3564 with SMTP id
 d2e1a72fcca58-82441753c79mr12990545b3a.52.1770737756128; 
 Tue, 10 Feb 2026 07:35:56 -0800 (PST)
Received: from ArchLinux ([43.251.91.63])
 by smtp.googlemail.com with ESMTPSA id
 d2e1a72fcca58-824418b60easm14104736b3a.55.2026.02.10.07.35.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Feb 2026 07:35:55 -0800 (PST)
From: Biswapriyo Nath <nathbappai@gmail.com>
To: Sumit Garg <sumit.garg@kernel.org>
Cc: Biswapriyo Nath <nathbappai@gmail.com>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Bryan Brattlof <bb@ti.com>,
 Peng Fan <peng.fan@nxp.com>, Leo Yu-Chi Liang <ycliang@andestech.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH RFC 0/3] Add clk and pinctrl drivers for SM6125 SoC
Date: Tue, 10 Feb 2026 15:34:55 +0000
Message-ID: <20260210153458.36231-1-nathbappai@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <aYrBejVVr7Ud9xkv@sumit-xelite>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 10 Feb 2026 17:45:26 +0100
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

On Tue, 10 Feb 2026 10:56:18 +0530 Sumit Garg <sumit.garg@kernel.org> wrote:

> 
> Can you check if recent SD/eMMC fixes merged [1] are included in your tree?
> 
> [1] https://lore.kernel.org/all/20251210155454.1561611-1-loic.poulain@oss.qualcomm.com/
> 
> -Sumit
> 

I am using this[1] repository with latest commit as of Feb 03, 2026
and have verified that that fixes are present in this C files.
Similar to that change, I have tried to add the sdcc1 clocks but
the sd card is still not detected.

[1]: https://gitlab.postmarketos.org/tauchgang/u-boot

Thanks.
