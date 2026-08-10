Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2928FC5B570
	for <u-boot@archiver.kernel.org>; Mon, 10 Aug 2026 20:53:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A981180F4C;
	Mon, 10 Aug 2026 20:53:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dd2NIY3QcURv; Mon, 10 Aug 2026 20:53:34 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EE0EA80F27
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786395214;
	bh=1dPxwRuv2V6zwU84CVPZv+Y0ZkCEVMJRipVw4wcHiKg=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mS/RuAO1fhNPqs6+6TEsEHIDO3KIsABtaAzkOiwsCJAxHbqFHJrKE8I/tMQGnMwIW
	 7zaLoKTMbqhTkOYI9BeMgMjmYl/hX4ZS9Bvq9ltcPaYKV6RLLWEgnZ7xlY/ZGZ2sPZ
	 lwxlB8bmzzs8GsdAfdRKtRpvjOiWLLjD2oMjRgg8bIgqZ8n7VjfajfvcyAZW9DNuag
	 IEKmUvFgemSeFOIvamfVy2kzYXrHlmjK5yxZ2WR0gwOd1Bwo5nAgNWdORVDpPJplf9
	 C6EsCvk7fkQwMKXykH9YuB92hmuNuFpzWaA1Mz4q3cNmchkU3y3TG8+Fpl9WyuKMLe
	 V2+G/2Y8DxuXQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EE0EA80F27;
	Mon, 10 Aug 2026 20:53:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 753B910E
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 20:53:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 72B8580F0F
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 20:53:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id G-gS9oo0eynw for <u-boot@lists.u-boot-project.org>;
 Mon, 10 Aug 2026 20:53:28 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::35; helo=mail-oa1-x35.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org ADD5180F09
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org ADD5180F09
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 by smtp1.osuosl.org (Postfix) with ESMTPS id ADD5180F09
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 20:53:28 +0000 (UTC)
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-4560d6f82edso1438615fac.3
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 13:53:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786395207; x=1787000007;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=1dPxwRuv2V6zwU84CVPZv+Y0ZkCEVMJRipVw4wcHiKg=;
 b=sIb+ogKYDv+FScEl9LM1zCnQTbRV7EoWpsnd5cclIDw8jcLZacAXHL0VzTZM/APd5n
 PrP1iUZ2UvQt0seKu4ktBSfSy12DbzXdMTerHciBsclqCYb9l/Rwql5Kp85lvkvK/vkx
 RIC6KjfqZwZOaylpswboK6ZrfRSc9INicS7FsAREZwfb0i67sOBhYFUhRDz+iUhbuH56
 K4MrN9gcotWb4tOUJNsmicuS/0e+bU4BXnVRBwj0eMwgFBhdtirt3Zjj9m4qYk7HF3EI
 zJLvzdJTW1XWvSOlfecN7ytiDKhJiqcMMCm4nj/Ukc7fLPjA2n14zdAp6NjXGP7oEhnN
 Zemw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr4V2CNZL/t4XU4KKwqgfmELHzi2Jx2zcJdt+lO5+J39zoNIyDQ4FmnGmA1Vzj3k11TZV34tY0=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yxpzo5i16jY87ulnOIdW84/dHWlb1MAA42A7TbV3caPU0Iog0ZX
 hZcKA4leOgRouYeVULxu8mg0BOwSoFl0MP3m5ov0pNAAoKLS6UgHxiK+86n2RgX/zTx1N7iDy9Z
 IACxCPek=
X-Gm-Gg: AR+sD12B1HwNx9ANCfiSje1iQx7Nepw4qQH+4h1xZHWKH60nN2Ht4SKQTh1DFcXvnwo
 ostElNRO2ftYYNy9a07OlbRyUW8S3xiY/UxadHKckhwvble80o7PlAZr4zMYByxwnx5Mx1Z0YiA
 wChJODuVC5Dn80W7ZuM0QMr6TMKY4VgatJ68UeAWslGaO/OVnD4ZyK0KV8NV2yswAxJuJYh1XT9
 F/JUZvqNv46yF7YO2D81djv8TlEu79bjewv55D/ScHqXdXrbSNx2bezGUEKDCWOCV2CPaliyiYC
 2ruBRZmVl+z4poQlMTlCSPnL+rPA7uRXqk4co9v9zyhizY2qp5Ut1BjSKBkbRLi+m/zItp6ZB67
 wHE26FFk75Zq5wQfi7Ee/jOZh55t4lHuw5DLrzqujkaZYuyBY8CYFlIZmsN2tGZG6m8sHcHMdIx
 a05G4UFwaAaPcTiQ6XecJCb55/redPVCo81vzN9D61QD6opX5CpM00m55Jz7JNQOiFcGJ+331MU
 J1u5NLtSBlKrRk87PxDK8k0BdLo827PnEzWP+GkxJ3r4HHtaXwcGZoRhej13Oa6ytncvl9tda8l
 DzjM16rltRdKMIULwjE=
X-Received: by 2002:a05:6870:818a:b0:452:213:bd4d with SMTP id
 586e51a60fabf-45e0599365fmr2290359fac.17.1786395207590; 
 Mon, 10 Aug 2026 13:53:27 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-459f1a76701sm9061652fac.5.2026.08.10.13.53.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 13:53:27 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-kumar1@ti.com, n-francis@ti.com, u-boot@lists.u-boot-project.org, 
 Gokul Praveen <g-praveen@ti.com>
In-Reply-To: <20260727103122.95270-1-g-praveen@ti.com>
References: <20260727103122.95270-1-g-praveen@ti.com>
Subject: Re: [PATCH] arm: mach-k3: j784s4: Add clk and power support for
 main_uart2 and main_uart3
Message-Id: <178639520681.1450255.5151417878960540977.b4-ty@konsulko.com>
Date: Mon, 10 Aug 2026 14:53:26 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1786395207; x=1787000007;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1dPxwRuv2V6zwU84CVPZv+Y0ZkCEVMJRipVw4wcHiKg=;
 b=rVSqkts68KqsJ6Cdhag31xcMES/QNUpLtNM/a7aTjnYrkvIXReZoy3YLP5J53n/JLn
 7yNcapW82yMUsr79C/H1O95RITIHNR6c3VBIARBwAHSYhv39K71gKftFTxw1EvSwm5mi
 BR8ckOrzeJyvqP5VVtIyKbJu7y9H3AOCx4VQc=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=rVSqkts6
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
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Mon, 27 Jul 2026 16:01:22 +0530, Gokul Praveen wrote:

> Enable main_uart2 and main_uart3 for console log functionality.
> 
> Add clk and device data for main_uart2 and main_uart3
> which can be used by main_uart driver to configure clocks and PSC.
> 
> 

Applied to u-boot/main, thanks!

[1/1] arm: mach-k3: j784s4: Add clk and power support for main_uart2 and main_uart3
      commit: 0ed1a87ad81f706c341f41af918219cf8619b6e0
-- 
Tom


