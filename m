Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B0D4C7115B
	for <u-boot@archiver.kernel.org>; Mon, 23 Jun 2025 23:49:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BED3082D83;
	Tue, 24 Jun 2025 01:49:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="W7IPeQ3F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7AC3F82DBC; Tue, 24 Jun 2025 01:49:24 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 017A18210D
 for <u-boot@lists.denx.de>; Tue, 24 Jun 2025 01:49:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3a4ef2c2ef3so3672765f8f.2
 for <u-boot@lists.denx.de>; Mon, 23 Jun 2025 16:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750722561; x=1751327361; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0v29Ltp/jkk63yRWfJ7f9ccF3yDwx29tE+/naQrmZ9w=;
 b=W7IPeQ3FCoL4wQI6FWe3rv9BPt+8ZDT27hh0NI5H4G1/DQ2zfbf/X/Hk3Gweeje0ho
 eY3O3OS9rI4HZ5B2Lo8Vnvqyi9tpJGr7Kv8TlV7nCQzncF0y/xQraNMlgdZWlY0Vy6Uj
 5/t5X51ISQ3F+z8oboa1XKrvjaCoU2mbLIJ07mFXatZ0wQLi3bkF6w2HgzKhqathsxWq
 ne0CVfAMzf83Pp7OCTygKGl3aVDUh2ucBrBlDEECqenTuwLgPnyyGUg4jCc1DA4847lf
 7F/UyoW1tJOOYtmcv6WemWUasnl7G1WSyvwcrrvsPn4jET5+iad/0RGOLVtnWd+nforO
 Ik3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750722561; x=1751327361;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0v29Ltp/jkk63yRWfJ7f9ccF3yDwx29tE+/naQrmZ9w=;
 b=RZVY6rVIKDXlZC+h1dBAY4NxuMhl/NjjW0s3MSeUCan6+c6GmcmGxjEZq0jkAp4L9S
 TzTg/AdZZXGEOhiqgxKy4OeE6ad6qsdtCon/v8LXPJHCyE9dgb/jqSfTEGRM4DOQvDBP
 QF/YdLyNaL5ZHPkkFLynMP5W6b4o/Q67GGNUT+bgZbb2gok3xG5L9LtzTapJu+pXZXZ/
 zVVNFs7yhjyeFUdb6toNKI9E0Yw0qmCPX3zNWOWhmPbg9WlhkkjRmh92BmjowNWe63nv
 OnGUHvZOkT8b/RYht5SMNGbFFkE6BzElNKaGJmvGGm91riYFOt/zDLC75dP/fF92BC9l
 rnnw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsPb5adH6EpTFajeHzksDwbEv1dehq3QawwIyFQJzh+5BY5PBsUa8mfkvDBY8K05dIEaAdB94=@lists.denx.de
X-Gm-Message-State: AOJu0Yx6XTjvGeMj9uHYZNwfM4a6UUkrhHW1vheF9JHdQkVwGJn47aAl
 BIH1HzQ55mAYNTsYEHoP8uszv6Jz/JgEH0QRy07cApmD5a0eO9fJofKyjIAZAwVM+Lo=
X-Gm-Gg: ASbGnct01YlDPELMNYvCXhEvRIfMhZ5qOBGLpyOLDUQAST/XhtwqM/ol6LAzjjcof6+
 05RCNpUx5GDJbbiZCPb9DsXr37zKCBtj7FXZqqVcjj1noXyMLkRaF6E4DqxdVby99AC/1YGZ/cI
 FZQjtL1VFugJ0zDMAqnnfaEDmWvU4jvo0XDXwmdqWaCQiM+RP3uDcUMvYO/Rt8fzzeoQp6iN8eF
 FAv9dUncwHwqusP8/1dt11Qj2EUUDcylC6zCk85GTMtM41/vtZUw6x4H+uzKdXf4RqKVXmjgXzT
 rkpaSyp2TZA0miVtSN8eooJtjfgObCNRiQTDNwUBZhTyjraJYDizE73iFHNSDPPkXz3yk0JPEIB
 Fos9z40RwJG8=
X-Google-Smtp-Source: AGHT+IHSUcQr1zDnqHz+sZiyX1w+yNRnSBiYrvGQChQhrQGh3yunUoEZFIwo3XC7yVuRiFkeJv+QkQ==
X-Received: by 2002:a05:6000:4818:b0:3a4:d5e8:e352 with SMTP id
 ffacd0b85a97d-3a6d128a386mr9305549f8f.7.1750722561418; 
 Mon, 23 Jun 2025 16:49:21 -0700 (PDT)
Received: from toyger.tail248178.ts.net ([213.240.182.16])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6e7fb5716sm432284f8f.0.2025.06.23.16.49.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Jun 2025 16:49:19 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
To: trini@konsulko.com, neil.armstrong@linaro.org, lukma@denx.de, 
 seanga2@gmail.com, Volodymyr_Babchuk@epam.com, lehmanju@devpi.de, 
 sjg@chromium.org, robert.marko@sartura.hr, dmitry.baryshkov@linaro.org, 
 andersson@kernel.org, u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>
In-Reply-To: <20250304110105.2762124-4-quic_varada@quicinc.com>
References: <20250304110105.2762124-1-quic_varada@quicinc.com>
 <20250304110105.2762124-4-quic_varada@quicinc.com>
Subject: Re: [PATCH v1 3/6] doc: board/qualcomm: Update RDP signing
 instructions
Message-Id: <175072255791.128390.5790418641917474579.b4-ty@linaro.org>
Date: Tue, 24 Jun 2025 01:49:17 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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


On Tue, 04 Mar 2025 16:31:02 +0530, Varadarajan Narayanan wrote:
> IPQ5424 expects U-Boot to have MBN version 7 header. The qtestsign tool
> presently documented doesn't support v7. Hence update the instructions
> to use a different tool that can support both v6 and v7.
> 
> 

Applied, thanks!

[3/6] doc: board/qualcomm: Update RDP signing instructions
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/c1363633c6e0

Best regards,
-- 
Casey Connolly <casey.connolly@linaro.org>

