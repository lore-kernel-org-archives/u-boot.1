Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AD61CA6007
	for <u-boot@archiver.kernel.org>; Thu,  8 Oct 2026 12:44:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D0F9B40A2A;
	Thu,  8 Oct 2026 12:44:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aLBsTP9uQS8T; Thu,  8 Oct 2026 12:44:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 0F31940AAB
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791463490;
	b=LwvR9Q2cI9+RNM8HfiOgemiYCCBYOJosJUwpaE9IHkUhUPOxrxfbxkk4EhSM65tHk4Oz
	 IKBi4bXWMhaYOVmXF9vgjAxIVZHOpP+8MVpIQJ9e/P6p0I31q3pJz7XmTeA9gGfM8ZQRK
	 FrIRe9/i1bQRa5pHtUETcm/y7U1SF3hLAnjIvFFwN9Rnp1lMQ2X6aFK16yA1IO6YqEA4m
	 XKi/ppY2l0MXqQMr1u9okMHuKb1wtyemsxRfVufdqtDlzr4o+A7WrHsIO7uVlvomJBG+Y
	 4oTjEmpHPcqCyn5TzPn0Bi4OGVoBDy/vmLjj378d1h/nESleN74S8tC4QzS8YlJnzJA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791463490;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
	 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=uOzKv2GWnyENiyS4zQiWp9WHMpU5NE0XIj6Ah3CZjHw=;
	b=cm2jrAGCkj70dv8g45JwVlHp03zvxofgv3lvssZMkohOAQ7QfhSwMp7FR8D2N5Y4DWYg
	 yoSZqEVyzN2bIUBndEXJZABqi7GSvdTE+OVj3E6UpoY1zj2+5sm05GYnV1uCMa7HQxf1j
	 V+xWqSvRZea6srLipQov7zb0Gn3Pzzmcvs+d9GX0asNmOYBtsw7z6QiefrcfBIrYdaIX+
	 XRCPSXFmPMqajzlg4f2BeHB2pN5ivpd+79RIRXNwESUZ+klpSJF75fya7v8Z7EGZd7Lue
	 JcoopDOQvAfoLvjVaLMgHXF13IbAwQZ0+fSVp7vyIHsIbr01vBfBo3u5aMnoqNh76cg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b="sC/zo42O";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791463490;
	bh=uOzKv2GWnyENiyS4zQiWp9WHMpU5NE0XIj6Ah3CZjHw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pkYM/m4HWNA7QAHbVxO9gomonhMuJ4B8zKEoR2LSbaGBrPAzbMT2UBaK0QNnAn4TV
	 iixYv1CJEtp+BrB7kGmaTHpw+t3CBlPQVeRDOTEV5EfcOqbvnvNuHWNV5cYeMYXtxe
	 yF/LGqD5YDtBkBHO4fBHcHic93vP88hjhHqA3Vo0C0iftdwQpOVv6lJw+PUJy8mirS
	 zhgPjCa2yT8+wTHOxmHyVosxD+9DGcon+1wacvkK6i+drM8Nqmp80Raf4aFI5vvkYY
	 iamrhGfI7schJ3cDBs2hdMyh2gWHrAeiSNDbLfe89x9BujsG8Oo6p6IxrCVxJ63SM0
	 buradh7gJ4K0Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0F31940AAB;
	Thu,  8 Oct 2026 12:44:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 42D2D2E0
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 12:44:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 285E140AAB
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 12:44:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id scdk7TpHsx0i for <u-boot@lists.u-boot-project.org>;
 Thu,  8 Oct 2026 12:44:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org C16B740A2A
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791463488;
 b=F62t4mAn+SnCSfXLFIqf9iMlrcn1XC0OjaI3AgInQI7NaS7fEk0MW/B4F2ICdPu5Lubk
 gpHfiDLXpWCEqPMpgGmS0VWU7qQHtimpUwNtmmtB78qhCUGDvJXxXRJPdV/5dOALIGSri
 xFQymCAEHMionAcEZeGGMhE4dPo3KbCjq2fqn/eWvtkW+UCdZ+qBa8qLRCY3wbiy8W8Pg
 gUAziYRz/yqmY6ewXOHcXC36WHMX3Qw3wWsxpcBZeMvPPkfIvf/EWdM9P2YB23+Uk9ZzL
 Z3KzGgxcpOInA92LigWiGlcxMdgevaDB1tziXVzYxpGvN8RgkeBb4DexGnNfhAt06Ng==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791463488;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer;
 bh=uOzKv2GWnyENiyS4zQiWp9WHMpU5NE0XIj6Ah3CZjHw=;
 b=SGSjquW9cH77imiqLhH26cUxaiuxKY2Dp1K4rZ7GnaL1uVdn4Mp+o7L3fcq0OQkG3oOG
 pIe9Xa9Aqs7eBMI2wV403Imeql1R8ivwm04uznKO6B4aqUar0iVa0tahS7TUHg+WgPVxy
 kzwr/xcUdL+LW4zSY+XVF96dXjGfCEvlu/+4a6JH+pvPdr7l/Qoxkicyd9VWSY2Cs6mkH
 ZdxcD2VFyeZDcFodkIoCjO8bRn8CVT4ciqJxIoFUQAYpb2nDV2y7HIyaLHpzAL5M+8Ign
 RbtznHY27Ec0jAhRVSKCaWXpTnY4zxnPg5RDccrKW6eFqQdD7RFIRvjvB1RXaF3cbLw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b="sC/zo42O"; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::42c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42c; helo=mail-wr1-x42c.google.com;
 envelope-from=neil.armstrong@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=sC/zo42O
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C16B740A2A
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 12:44:46 +0000 (UTC)
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-48441a2ba1bso3075695f8f.1
 for <u-boot@lists.u-boot-project.org>; Thu, 08 Oct 2026 05:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791463485; x=1792068285;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uOzKv2GWnyENiyS4zQiWp9WHMpU5NE0XIj6Ah3CZjHw=;
 b=sC/zo42OcJKgfy44BBHWjN5I7fYfYeiRrBk0N3IHHyxa5TaM981htWMh0V48Eex3HT
 GcwtbnTyCtwmwfEJeOBkOX8ejDwxc9vU7SAIH1eUktt3lHgWBjeDXuW28mHFpBxvBQeY
 QSamE0MA+UnDR+vAi6oYfl7aOcRaGjxt3T/NjGEAF/IGKupNYRme2TNm5kDLv6WH42Kg
 j0lezZP9ACDHlmIldF+GYCSrJp24xukUwn7HG21d4FtsvHJRaen2wcsOu35U2G8//cKa
 /VQSY9b5dazVjIGmTgdG3UJk9606p4qYp0rBkiKF/F8vZ+JJGZhREgbT9HeX4V6sdhdv
 jemQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791463485; x=1792068285;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uOzKv2GWnyENiyS4zQiWp9WHMpU5NE0XIj6Ah3CZjHw=;
 b=Oyjv0DHwptX01KapBsC8N5oAnf79UQOPbq5hNAaHcF+34/oFF0oXbt9IhJZLRrqIbt
 z0SvErx3BiqvKzZ3oiveEq1qJUqtufkTzpbejqOsBw+K+AiS0mP2AHMjGgJZwqHZfyaR
 Yw2oy2koaYpHPCO66caUGplWA4QSlMmjoylkqN4MURmIIpIsQjRqkJavS/tzIXAj5dvR
 Qb9ybKereuHxhwQGvlxDN4qGPk9eki+64ST2ABi54HDLKvw+bmCIwVgQBtYnejKSdZ6/
 cJHijW9qL/hgybCAQ+E6RvkQijgcz0PvRkYu40yVuoPLBGnwUs4dnFnM7vFtrE0iyYzx
 p6qw==
X-Forwarded-Encrypted: i=1;
 AKwUvByR762DbbhkZT3YmGqupM75G3TpDH5Z+uKdWvib2doFwo0hOukE9VS7ksJyz7X3yQjmCyssoU0=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLz0pyrukmc1hVkDzThS3NIpV7znyEBN5OdcCbYNVzWQ1q8Z+GF
 7Z984t4xsHR3+i6KU/VwvZkB6nWGmN3y5T8HaNsBd4Cb1F/4PWyWfeeqGUeFVdzwWbQxzGz/huv
 L5q9AMkx9sw==
X-Gm-Gg: AYBFou0ttPMmUxAz5p3KF2lVMHrFhewZ403eHqN50j18uQM/phmqwY8O4zjGORBShIt
 sBtHUCJ1n28ifyw51IOFJRvmkLmCWYuMUocufpcnuDH+51QNT/Nau4cg/YSssvQJ+vC7ntQvuw3
 Mkfb1gM3NTqjmlxyk32bHDNUpJAupSloyttfnfX/43hO20uXFr3XfIO25JxlYMuPWF3HIPHY+85
 w7R+OHd9qCAYFxauUbCP052XZl3wVtAYv5sYN6qI1BJC0YG8fEq7NPq8/sCmQ1nFHNb2Z57Aclt
 0fZMzP0dRfN25OxYbXm/mDk4RtucOWN3e/LcirQRadn3l4RlgMtFJzmAZmLcuwKd+yvlF8cyY6u
 hGw43jCTI8le2jAoCPgWJKnWXQHpGG7Y7iaF3HLg12x0VU7JH4yOBFCgSsAnruw50CX6niigkFi
 ZsR7AtkU/3hj9kHxnTdIZGTugoBrEaeNOlkskLOlgmI+tH9F5SDvotyoOKLBzrIAvdAiS+RdkxP
 JQQhy3xFQ5A+qEp6gI/ZnAlcq8zvA==
X-Received: by 2002:a05:6000:4a04:b0:488:7bdc:f7f8 with SMTP id
 ffacd0b85a97d-48c7288c338mr10569252f8f.29.1791463484931; 
 Thu, 08 Oct 2026 05:44:44 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c71d2eeb6sm11418650f8f.43.2026.10.08.05.44.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 05:44:44 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io, 
 u-boot@lists.u-boot-project.org, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: Casey Connolly <casey.connolly@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Biswapriyo Nath <nathbappai@gmail.com>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260820-interconnect-qcom-sc7280-v1-1-5997fa475e99@oss.qualcomm.com>
References: <20260820-interconnect-qcom-sc7280-v1-1-5997fa475e99@oss.qualcomm.com>
Subject: Re: [PATCH] interconnect: qcom: add SC7280 interconnect driver
Message-Id: <179146348384.181743.4880343052779797243.b4-ty@b4>
Date: Thu, 08 Oct 2026 14:44:43 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2
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

Hi,

On Thu, 20 Aug 2026 15:18:27 +0530, Balaji Selvanathan wrote:
> Port the SC7280 NoC provider from the Linux kernel. It describes NoC
> instances and their BCMs, and reuses the existing
> qcom icc-rpmh helpers for probe, bind and voting.
> 
> Taken from Linux commit 46bdcac533cc ("interconnect: qcom: Add SC7280
> interconnect provider driver").
> 
> [...]

Thanks, Applied to https://git.u-boot-project.org/u-boot/custodians/neil.armstrong/u-boot-ufs (main)

[1/1] interconnect: qcom: add SC7280 interconnect driver
      https://git.u-boot-project.org/u-boot/custodians/neil.armstrong/u-boot-ufs/-/commit/31daa2e65bd85d4546fb69026e61dc8f3492615e

-- 
Neil

