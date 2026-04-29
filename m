Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FEE0FF8867
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 08:50:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A4FD847C6;
	Wed, 29 Apr 2026 10:50:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YzUoaUnX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF44D847C6; Wed, 29 Apr 2026 10:50:49 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C250A84841
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 10:50:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-43eb012ac4fso7388660f8f.0
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 01:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777452645; x=1778057445; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N6JNIHwrwD0P63zOkLmqyx4y3sQktFuua0kuqrCGcnE=;
 b=YzUoaUnXZNuzbWfspU72AfMbqfeX84jrCgaGydJ6aDLL4Mqdd+D2SIQcq/vmIaypzv
 9jg1zCg/N5zNC1393vSLWcuPaf4yNniN1KvCSpP08HM3cnmDb3ZEhUUcUU/w0cgGiGGB
 QR1y+LIr5w44bs30FrNLota/ycxtHNVeUq6vNjYJRHmUe9eV503IgFNjclVT3YpYhbnU
 iqt94/AZBlN/QI6jLVzNEEl1bX3yvw9C5FYgfhHEClVogb9SR/41U/GdgiTt9OpZ/2dw
 GiZdeOM7M07mZ7BDRomS9i8ypWOwdZqQKM5/BfRsUR7rZd2W4PNx28Tfkcj9jzRgeM7f
 Mwbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777452645; x=1778057445;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=N6JNIHwrwD0P63zOkLmqyx4y3sQktFuua0kuqrCGcnE=;
 b=lgdYmTrc9vxESw+WyFtzh5rWQ2nuL6dPjiPN6W5PeABDpY9s+6QaU7C9I9gJSqMZVZ
 CNFIFh95lcDn8HOn9oVrkPLsbiHQc5FRxL8VeySWfZXoQ0CqkY42AxEyQYzt1sQSVqcS
 gsekbHdS3lc41Lb31lK8XdSeO/tu1Kbt/X+P8EawVkajvnnmN3XMxDCW0XFV5znTvIAa
 G8OzT/pi9Ecjl7oYniTeq+Q7HgFefKPo7FzaTn54lW9BAInyyxgZNdG9SyqJ8P+i+U79
 UM+2woHrZRswdEmxc+7Vstk/sGXC5jQsv6KYCGEXY1MlmbUBo63TWybGQ6b7lR4cJzDh
 fJhg==
X-Gm-Message-State: AOJu0YxRSS0u6vewskazWCGBEum4lNXfYSCKNNCzJMTEvf42LDdXIZ9K
 J8rhg28cUASUcMAe8exsx67aPHqyfas3JMum6lCj8l0OyULrfhsuvwF36Bs1Uas8XTiCQMqVnsh
 oXqAi
X-Gm-Gg: AeBDieucxsig13UFQ7zrTg2lvcacjveE/MNNfSCwnDfl0kbzoo12RPzI28snwQFrlll
 puBVb8NQMDZCzmVtEqGI4Vvfh//qZJ/RNG7gZv3BqGuRh1RPg7uweknHK3uGmgp+gREWwQKK12G
 Z8tYcHA/tpJcka6J8ObbGWWUs3rgJNn9EwEYRnzX5KhIyFjH+uq5gTmRGFOoQjUz7ClkqkzsGLY
 OS5svjWUwkzPdEOj4uB/I2qdiSZ8Ug1vNqyTzWZdqRFEZ1sEIs+Ojx4at3Ok+Sq1QJ5GSWWK9iT
 /DQkT9RdY1iu2/xt9uGmY7hqHQaS6WUd8JZ67AUuCsJVZ+WS1EzQdqxTDco4/Em7uELxHWjRO0Y
 +U/xAi57KDcqn//zY+AIhXAKb4HmXqoqGQ117RCrWwddh5gnuhriB/rYw26GSW3PYgPCZxawvNb
 K6ve1yki0oywZk3dQKjHAQiFo853k8AxrWN/BOdsqlYP0blqxFcLDTrP6P8o1sqRp3y0G9mk0Fn
 g9tjOA=
X-Received: by 2002:a5d:64e9:0:b0:43d:7275:c1ec with SMTP id
 ffacd0b85a97d-44790c1d8c7mr4816857f8f.40.1777452644997; 
 Wed, 29 Apr 2026 01:50:44 -0700 (PDT)
Received: from lion.localdomain (p4fc3dd86.dip0.t-ipconnect.de.
 [79.195.221.134]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-447b120bdefsm4422865f8f.0.2026.04.29.01.50.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 01:50:44 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
To: u-boot@lists.denx.de, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: Tom Rini <trini@konsulko.com>
In-Reply-To: <20260324-kodiak_dts-v2-1-243c28a3ffb9@oss.qualcomm.com>
References: <20260324-kodiak_dts-v2-1-243c28a3ffb9@oss.qualcomm.com>
Subject: Re: [PATCH v2] dts: qcs6490-rb3gen2: Remove USB controller dr_mode
 override
Message-Id: <177745263561.126665.15881105139514651155.b4-ty@b4>
Date: Wed, 29 Apr 2026 10:50:35 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=571;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=jv+39DTZfjaw1B6/T7KFtDpgjZHrogc92O3j/khORUQ=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhsyPx1LOfQu0bmhWZDi352SjRueK4w9vN3pvMdz593Dqr
 sPHxF6f6ChlYRDkYJAVU2QRP7HMsmntZXuN7QsuwMxhZQIZwsDFKQATuWrP8FfcYqN39RSeJfc9
 Hfktfklc2PqhqC1PZdH+OQtefTq5a100wx+uleuKHr91+MXd8PZa5KrGxCO/vth9zmTYo6J5/IC
 BicxXAA==
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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


On Tue, 24 Mar 2026 21:16:55 +0530, Balaji Selvanathan wrote:
> dts: qcs6490-rb3gen2: Remove USB controller dr_mode override

Applied, thanks!

First and last time I use b4 review, the commit shas are wrong but you can find the patches in https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commits/casey/qcom-main-13Apr2026?ref_type=heads

Apologies


[1/1] dts: qcs6490-rb3gen2: Remove USB controller dr_mode override
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/61412ab180c1

Best regards,
-- 
// Casey (she/they)


