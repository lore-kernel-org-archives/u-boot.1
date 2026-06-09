Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD0FCCD8CA8
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 12:50:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B358884942;
	Tue,  9 Jun 2026 14:49:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="nPST3yQ/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27A3784928; Tue,  9 Jun 2026 14:49:30 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F41CB848B0
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 14:49:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-6919f40a0c8so5044014a12.0
 for <u-boot@lists.denx.de>; Tue, 09 Jun 2026 05:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781009367; x=1781614167; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Hm/q/z2SY5FgkVOHhtu8WSJydZaLreTTm6zhAtvHJNk=;
 b=nPST3yQ/byv0U6AAy/JcNs9cul6Fe+fz02vtEWFMfy0VFdcEILvD42k25RiZ6YSyfz
 Mv9MxN3qEugOjKVl9ChLNrdXktp/6J12Yj+hl7lHoj4cT1Vmq7/ZieEmVl7fccdxCJom
 B3UYNlnI+SdWMjzkKC4gSClZtKFjTsLrrLbKj6JI1AmyLvLOBM4CGRwsDbn+hwefCY7O
 zGnCBykWbbvedabqjJ4gQ5AKGvLeRHpjdjj8h1X74jMU+IVb5q9JhC6Xt7uKmKqr05hR
 oz+COAmnW6cMz0lF01uZQ/PH9bO6DNbU+oi9/k8BK9G0LiaWqJlTje5O6pMb/YMCu2wN
 7XEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781009367; x=1781614167;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Hm/q/z2SY5FgkVOHhtu8WSJydZaLreTTm6zhAtvHJNk=;
 b=Dy6gQ1xnaqFNpHXANCWwqV3yuSwS8Nw35IwJEoAbHEo6DkIfZOjzBqmCGhgSgXUe/u
 A7hvjOFSzPFkgC6qQvJNgo8ug5h8ITMOduxdod1P292f4n8xkdKE6hnz5jrSmrsmTXTo
 cipUDqZ3rMwOAccK7vxcMJ2VFSvKL5zOrxZh7xQOA4UiphzZzUoMTlYENm/TzuU65iA6
 66TZ/ux2FKU5y3MaQpNWix2+xOSu3WnZGBCO6UW4JqA4tYGp4Vc6f407axMrc1fpyN0h
 zMuhXDvcDiqcdmX6juBEKr6Qwy33ktIHY9KEdZM+LNj8MEfVZW0Q/cl/Dfbh7Ox0xUJf
 jU2Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ+eu4EO/J+8CbUgM8/N+5NTaPE9NZy9Frio/pL8l3mHJzBxGrXBFTBiMBM6qWSLu0TQDqEex0o=@lists.denx.de
X-Gm-Message-State: AOJu0YxdsHLPH9PvhtHDpMBkYPgX4gmnBkrHfcSIbMt60RDuLDkDeMeZ
 +zgTG7PIXURA06LHYOHYiPxs3parfPZqlJAZCa5/qfpiqp7AOuv0gY9qMEyBD46QM1M=
X-Gm-Gg: Acq92OHeKAqAJ04KT1VFPjFcTcQec2Xv3wC7TTabOe05izEANz+Mlj4wkY6HSik+yjt
 538iNoszlak1h5UaPSoKaTsUgIJOrahI23SA+05ImVO4e2HlPV7mK14Hvc/c7TSYEEzX/t25BAC
 jiMgzJ4aXw+EKdrT7u1i7vXpz0Wgag/CyoNe3jXfGEDf5h5JXA5uoqFFEok9Gv46iRCFaZuTkLM
 CUaSk6pjEXPWgDR5qyLk4jjfPL0X0aqNo+xmFap8oN/3I/2ThlM0u0xe1xABgrVRRcb/qWppnDf
 9useYDxf65nb5j25u6PQ9egG3sy2+BFhmORL9aKcGj92rbNFUxkKZyj0zdMoRQzctFLw4K4x3tB
 1zY39B9t1aP0PW/TbWQUNLx5zX9rL63lkr73hmy74D1CG8nrJgftT3rcYbpElAI9LM0NDyXA/rl
 0lvbys7gNklp2QuU94coetTb/LvJUOSrtGKl/w7hEI+xnTPO1VUUOcen0swcRDtEzll2V8aefeb
 GBG
X-Received: by 2002:a17:906:f5a5:b0:bd8:bb13:2227 with SMTP id
 a640c23a62f3a-bf36fba2445mr961850666b.6.1781009367410; 
 Tue, 09 Jun 2026 05:49:27 -0700 (PDT)
Received: from lion.localdomain (p5b29e032.dip0.t-ipconnect.de. [91.41.224.50])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-68e65b55d81sm8689526a12.27.2026.06.09.05.49.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 05:49:26 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
To: trini@konsulko.com, quic_varada@quicinc.com, u-boot@lists.denx.de, 
 Gurumoorthy Santhakumar <gurumoorthy.santhakumar@oss.qualcomm.com>
In-Reply-To: <20260603113853.3396271-1-gurumoorthy.santhakumar@oss.qualcomm.com>
References: <20260603113853.3396271-1-gurumoorthy.santhakumar@oss.qualcomm.com>
Subject: Re: [PATCH v2] arm: dts: ipq5424-rdp466: add chosen node for
 serial console
Message-Id: <178100936644.3342853.986863720340950272.b4-ty@b4>
Date: Tue, 09 Jun 2026 14:49:26 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
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


On Wed, 03 Jun 2026 17:08:53 +0530, Gurumoorthy Santhakumar wrote:
> Add a /chosen node with stdout-path pointing to serial0 (uart1) to
> enable the DT-driven console discovery path in
> serial_find_console_or_panic().
> 
> Without this node, the live DT path in serial_find_console_or_panic()
> is skipped and the fallback path is used. Adding the /chosen node makes
> the console selection explicit and deterministic, ensuring the correct
> serial device is always selected as the console.
> 
> [...]

Applied, thanks!

[1/1] arm: dts: ipq5424-rdp466: add chosen node for serial console
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/d234ba9f4204

Best regards,
-- 
// Casey (she/they)


