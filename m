Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50AFDCA5FC7
	for <u-boot@archiver.kernel.org>; Wed, 30 Sep 2026 17:17:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0FA6860B73;
	Wed, 30 Sep 2026 17:17:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CFn-uhPPtvqC; Wed, 30 Sep 2026 17:17:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 5E06160B75
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790788675;
	b=Ith0Odef8Swufie7xZ5RGCt2XAKDA4iVKQcxA0GEDsJdwW3WuK565iq/Ot5gMZOfUZx1
	 N6dHXyG3PHE2u/OAY4R3vJe2AHw5vMZIgOiabV/0kiumgqyXIAd+gIcHLb6ky76zQ7DSR
	 8ak94Q4OfhVsrCtDr+KsQpJPeTr+INLKpXxj/kQydKSyN9iO4vrIN97noyNBTz5WKTeDi
	 TtTDcqNQebXxYdFLMEPelyq8m/MRrOoQUKw3Frh8HDMV+A/EpMnCY1g/rmSclOEvDpej4
	 PLGzDl8GRRLCVutI0wEoJTR4al3dpUQ5OoTfKKC9w7u0fbBT2z9EJXgQdeG/RaFzU3Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790788675;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=42UhM/qSg/JTt+9C0QyfNoSsnnxEPI6kbS9r3ltMK4M=;
	b=c7qJUyoqeLwGPDPVxWAt9VpPQQn+EN0+pfhh8w4rlvL2uEdAs2v9mRzqFeoj0Kzc5+RB
	 aGc36MtYCak6rxMqBuKMTi0GrSDlXpST8zUiLb6K5U2ljDIukSTWluD+7N5wNhLvUYR8d
	 7mtjZiieTg504DSfky6EoEwqseFwAouyz35AxPXOeuEIXkLHkbznRgdcloJub3ULY4XkU
	 pfOv/T+uy8i+gmoudG+7bo4I63cAbYF1B0bY4ahh9KQngJKcdrbu6MmcpxKWX60kfBBUg
	 XVhwVGC/UQFRjsfBPYZ+JTGpsqcPc+He9TzTChnP46P8LPJOjYTq5NnjURSSTQX32dw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790788675;
	bh=42UhM/qSg/JTt+9C0QyfNoSsnnxEPI6kbS9r3ltMK4M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YzfxEf0RPYd59kWtvmFPUEzyW+cHbjtH16Kf9XJr+r8fN55WCVGiEpzQ2DE+y7CKi
	 Ml5ObRZkiB1h2hVvCkABgO5jaQitqTID0iiifUicAc6bJ2PlXxBtr2C8UBykpaTQ5M
	 d3avNBkVSe6ze25PN+5U60+NjWyK6itec++nO5acli1GrLLmQfQotiZJ9WXdb2+ETz
	 JNyjgLdNPUGqA+e/oSnxpde7uxzmmqfr+ksRM5B3f2OmGNyemqzYWCpbMm0uLKA9Xa
	 7jg39FED9H22eGR8D3so22Y0dXX9dGwy6ePdOat4VIzw7mCu3TyYiLtIRJPJ6cawbv
	 kuoe4E/8a0Bxw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5E06160B75;
	Wed, 30 Sep 2026 17:17:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8864232A
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 17:17:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 52A0080EB0
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 17:17:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XIsPPWNNEW0k for <u-boot@lists.u-boot-project.org>;
 Wed, 30 Sep 2026 17:17:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 9A9B380D45
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::28"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790788657;
 b=jeIbprvmjfg798YNQdJq8Q23sKqFGcsHLA+IY7ruo30cq8aTQwYNkQFwgJij3JvRqB0O
 rkMOhSeemCC3a2aGGyh21MANhzxKRo+tUAIiFFV55VvSVIFykP6o8OcCRf+hDzUo/Z3t2
 k+b0GZRkyyWmeTfk13+WRqhUP0Th8R4SlkM6UE9mt92mNbP5RUkJTr7GK19Kzni52Fo6K
 62H0M4DQ3GvEfwVmtTSeoSMgzOdb69xMXN12RLkkdZuUCD5cSL/jDJQ+aEhdRb6YKqSEK
 ycqYD74F36hdVUNU3rPHoRAnZXNZMQpn9w36NFduJIoKqN+xDAUEEeugu14D59vy6SQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790788657;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=42UhM/qSg/JTt+9C0QyfNoSsnnxEPI6kbS9r3ltMK4M=;
 b=TmQ5HhoKR5TXtMH+hKtcC+jFtRLw5bhONdRq+gJBJoBdn+H4bYS+hRiLxffMmdoVeg+l
 CrqiVcgC2T314lf41WU6NfVdZUy6UbA/CJn2RbF+0fj/BzqfCAVSMvqebn59LIP9fpOdg
 kSm0Us/LZjoLUbfZDOwuZAjFqVosNrUtwI8q7y2uqITt7HKA8J1dhFL2VG9udtXVh9kqO
 2/xFOjyUqqawHpk7hwrn72NKhxQHuEvLVfTPFKpEnj3LW0oeltJ/x5rAN+nQFqGhEdif5
 W9zlJtvuLXSqrYUqzEM4ui+gxv3tH3guRZA0hD1gRZ2ZRDpZdhQkFwK9AXVtxxYvUQg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=Zaa6ZsNe; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::28"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:31::28; helo=mail-oo2-x28.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=Zaa6ZsNe
Received: from mail-oo2-x28.google.com (mail-oo2-x28.google.com
 [IPv6:2607:f8b0:4864:31::28])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9A9B380D45
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 17:17:37 +0000 (UTC)
Received: by mail-oo2-x28.google.com with SMTP id
 006d021491bc7-6d769a6fbe4so407823eaf.3
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 10:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1790788656; x=1791393456;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=42UhM/qSg/JTt+9C0QyfNoSsnnxEPI6kbS9r3ltMK4M=;
 b=Zaa6ZsNere3YkqpxP3zN/XpE1qTAHp4F5hqz7j37RNeaGjC+2zneBoi1qyE/V4EPXM
 FdHfkTwPX8sv7QClqXqUTadNjbYCzTKJECKPBRhG7oGxu/qSrO/81BWWQpjCPaCpl82N
 +3uqH1pOqycCbpVM08KUQkl1rAj73DTy/Iang=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790788656; x=1791393456;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=42UhM/qSg/JTt+9C0QyfNoSsnnxEPI6kbS9r3ltMK4M=;
 b=wZYcHSrCXghoAK5U3BwZMW0m3RewrBaQOyqR2eLugKVvgytW9g14CiomvdQyEVdOWt
 7mHCYf1QrbK7T36slOtUbxekeixHEcLRk5gDWVFmBp9+6ZkTNzm8Tt1RidWgI2kSW6Qk
 O9smPgN6IRyReok8QmfODrcfRhN2jwHSy1ILpquUXBvKv5Fc3xJ70RNkvbXuZygaaNYH
 pPZEW4I6k9auLPFDwWwzrM5OQ1CHY2oBMcXC9uV3e/x8aL49SWaceQSjkQDnRgMNMesc
 1nAgXp/mjOb2p8oAz/4N1S/4wx+G+iEKadSRC1H5sSTWTbLbpD5sVouiEUXKKkbAhJT2
 3rnQ==
X-Gm-Message-State: AFuF++maUlnCGd6FOtzuKL8x/GTAd+7N7/1zUAaC95QDMzip5wHMHodA
 rEPR4Lwl18uEPZhj8bjkylzuyKmdEIPC0nfyrXnObXkZ+Tqrasb6NyEmOBSTBJaXWQ0=
X-Gm-Gg: AYBFou0v3Yfn7ny7+6PMwWLZRYyH0xUdQPAQCAOvRNynkh0WEGYBQ/RXdqKY4fjdraa
 jBqeKl8KoIDray6GCBPIIDMf5KRbJ56tLCMAy1ia3qSGO5B3QUNbKcUj2qIvoURTxRPSCEVuHLG
 xaY5nOFAEIzK2vXXgXV5h6a656jZPbfoe8tujV52L6CMiWnHr5ePEwIO1Y3RVhbiwifBg2mj25H
 3QgzAW6KDQ00jXNqEiFjn+EhnOToHCDACc+LoWwtL39s44lN56iDnoVe6a9jSPrT5XDvxCP8pq+
 pTGy3veqe02Y5v6M1SWFyCWeMPm46XEhI4XIOmQNHbgLDHcCa2Ncl4+577UjFs3kusYt5dmEFdq
 uLKZ66Zt3oSImpbg/Q9pmbmLnWAzMAwQd/4/Xk4x0pqLsQjf5cjNAPiU7zLg6u+QoWegPhZIz2L
 L2koAGUsFH+M9Z8oNGLXgltlm95xQdVfI7NwlYYcNYhCIueGCcj892SpFYPNJ0JGu9Dw8IYmMy7
 9k4l+w8xv/2jgBO0t9irmoCp6NnV6U5xYAuWVEimnksHNU9AQCn7g+QN6y4SMifieiDgE+FPpzl
 JcgPWMgh9D5CUU8VDA==
X-Received: by 2002:a05:6820:825:b0:6cd:3fdc:a92d with SMTP id
 006d021491bc7-6dcf632a575mr2331387eaf.74.1790788656328; 
 Wed, 30 Sep 2026 10:17:36 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6dd985dfee1sm591516eaf.12.2026.09.30.10.17.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 10:17:35 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, Adam Ford <aford173@gmail.com>
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Peng Fan <peng.fan@nxp.com>, "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
In-Reply-To: <20260913155303.84201-1-aford173@gmail.com>
References: <20260913155303.84201-1-aford173@gmail.com>
Subject: Re: [PATCH 0/3] board: beacon: Remove i.MX8M Beacon EmbeddedWorks
 boards
Message-Id: <179078865507.467656.9629940053674203425.b4-ty@konsulko.com>
Date: Wed, 30 Sep 2026 11:17:35 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Sun, 13 Sep 2026 10:53:00 -0500, Adam Ford wrote:

> Remove board support for the Beacon EmbeddedWorks i.MX8MM, i.MX8MN and
> i.MX8MP development kits. Each patch removes one board along with its
> defconfigs, config header, U-Boot device tree overlay, documentation and
> Kconfig target. The final patch also drops the Beacon documentation
> index since no Beacon boards remain.
> 
> Adam Ford (3):
>   board: beacon: Remove i.MX8MM Beacon EmbeddedWorks Devkit support
>   board: beacon: Remove i.MX8MN Beacon EmbeddedWorks Devkit support
>   board: beacon: Remove i.MX8MP Beacon EmbeddedWorks Devkit support
> 
> [...]

Applied to u-boot/main, thanks!

[1/3] board: beacon: Remove i.MX8MM Beacon EmbeddedWorks Devkit support
      commit: 2255792e61e5804821408fabaf9a00fcd2099b5e
[2/3] board: beacon: Remove i.MX8MN Beacon EmbeddedWorks Devkit support
      commit: 0627c1f743309adc856767946aa2d5e8ed376b85
[3/3] board: beacon: Remove i.MX8MP Beacon EmbeddedWorks Devkit support
      commit: c92d8c3c431e37a17c3b37918037dbd7ade32d1e
-- 
Tom


