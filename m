Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BAB606A326
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 15:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=MItFSIbO;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=suug569E
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F0C7380DD7;
	Wed,  4 Nov 2026 15:01:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JSuGYWRtWUI3; Wed,  4 Nov 2026 15:01:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2EA3580DC2
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793804504;
	b=Zuz+kDreKKhFNqle1wh4/ruCFmPukmE0Sk4SLufneNJ90c5U2Hnx6IwDROE97IS+DCxC
	 UZcOfOMRy8jF5WuBjCxZcItFvMkyGWRLvQBovBUofV0SHSlIT6OLbnApU2wDlb6Fg5nPF
	 DYyntR11gVd5QUp4In3KJ7B0G/DwWjpHvVezv+Y3jDvj5vQnijV0GNacU9mYwxZf5I1dJ
	 PSsGAV7PGogyp+hNs4HZ4aG2jbCnBwVMQHz5uuUrvxGr+iKmMq+NobexplqS4nTEVMzXr
	 1EGAL7XNMUyMi9AANGyV1a25Er/y0wPS6GANiqlpltgzt/E1Wzfp62Wk+g2zhSacx9g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793804504;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:In-Reply-To:References:Subject:Message-Id:
	 Date:MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=BlVaWzpeXYBku0PUcEUHjE4kXDDu2MIvAG1BNBqtwjo=;
	b=Fb+hTheol1x9CbjhXTfDvJnxVUC8TOgpy1DIq11eA3+zlY8N4Gdxy8erBxON93sUm0kl
	 sylWA6XJe0MZPU7aQEW55Md6OBXri/hvDKYK1oz8RY2UiC+8ZNNFoh3c/LWp9FvNX6ouN
	 t6DolwpY67Gni6TRKBFIseaCbqsft28HrTUjHPXnw9Zeoyid6uw+XNZpty8h5bETxsHvQ
	 z7P51eZ4j4ikciK0Hh7aPtIMCSR8/sCUueLeEScZyxS/3GEo8TmiKk1Wi1BtxBTLRdx6f
	 B22mUEWmbF6+FRj3+cO652jUJtwyka73Wd4w3+D4y8of+aU4MCc+FfhKCg9ZPXaK5Eg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793804504;
	bh=BlVaWzpeXYBku0PUcEUHjE4kXDDu2MIvAG1BNBqtwjo=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MItFSIbO+9sB/a/9Bml6jAE2JwMQeoEUZcTxqRRx1/2w+2K8O2Z3KY/I+PxMLZ19j
	 EydHQwD1evWnCgarU8gujhpT1+857Hz1ZO/5oo9lrJWubKmsaK0TPVFn+yy1gVHLnc
	 E4YX3psOCewdOhicUWvHBIef+2EPgodHe4reSrLfnL8tn8sb9kbGEVEJTdp0LteDFc
	 h7m6kuyKHuhKmkfYjBLev3Yz6L1mYZAMyB0zha+OxRMgdShrafE7gbns3f3lve+k4i
	 BwLm1tQvJMIFLzuS0ox305yHYDCLoEPF5yJuXJpIdjQOXRBagOBdZYBwJEzQIKp7/d
	 5wH517OTb9nGw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2EA3580DC2;
	Wed,  4 Nov 2026 15:01:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 64610362
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 15:01:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4A536605DB
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 15:01:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TE_slgevqe1Y for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 15:01:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 89EB0605ED
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c33"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793804501;
 b=MSqWl/aZQYlbRgqwcLwtHhs1PlcWdfCKEISA5Pc5WxH/5FygYFkzPCouNocMsszduBmK
 AK06OOhWo8oGbLssxQazUeqhcu83/lFr4hFEUYFhDVFjdMHXBB3dWVlrYmCix5DxY1l5f
 vXvt6zSMm/mlc5w2i5rhAvmZmzKFEFApn3CSwcoBQCFF2b6nZHJ5JGZqy0sQp34oVcc7s
 2HZ017RlEE/WwLoAACNQLRHxXa1TbWgLFpKnnrSsunKlsIlELgtNr6oJj3hDFxWX0Wbhu
 SdO9mwGETbz8QKj3HSy1B6FEDU5qh67+L6z2f5pW+u9H3FWQe9jOFVZ6VcYjtq+4V7A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793804501;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=BlVaWzpeXYBku0PUcEUHjE4kXDDu2MIvAG1BNBqtwjo=;
 b=Pg4yDXKOW0t06rt4wW6croVhAo4x5CiFJtH0KaBRS8SM56vWUmtYxi52EwBD2Nq4Kp2H
 I2BpTCo7o13Q9G2XazbmDsq7m7KXXprggwSL8XKaVNf97yXaz6eMqLQWKPslCrKmHv9Gv
 iZj6W+JUlIp0m7gvvV4fh813mvpwaLs2Y3eOhPKOoWUP+U6w4bPOj/wq/pmiESLRmXLTR
 AcOtUrTYH104gh65tAzi/xhWvPg1SrP0pPcC2h3iq4icmSNF+7wzuFW3srGuqrU242R1S
 RiSWAWJQbCHAU43sM7eY7uJXRfwhH+K7cHnAPlc+ErfFyXGzlWc7isCKKxIMufEtgLQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=suug569E; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c33"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c33; helo=mail-oo1-xc33.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=suug569E
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 89EB0605ED
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 15:01:40 +0000 (UTC)
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-6f5a0893610so536357eaf.1
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 07:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793804500; x=1794409300;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BlVaWzpeXYBku0PUcEUHjE4kXDDu2MIvAG1BNBqtwjo=;
 b=suug569EibYQAw49q0pCmtg/lt0Ok2mPlyUij21ZgZe7o3YhkpOdIr10j9mQBSbZsE
 mAhaRWJtr1wajRoiacu2xq1FF+bcIrjCuGcAn5Ljv1Ww70gp4dHHD+5IoLO1BXffIGLv
 vBLmwVHEvx9CmLE3h2rQPzEbRw3gSSfHJWHzI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793804500; x=1794409300;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=BlVaWzpeXYBku0PUcEUHjE4kXDDu2MIvAG1BNBqtwjo=;
 b=qXU/tDbNE9gfagY+MSuUCqgHVDFJJbF7TXL4u6D01JNMA+yacGnZ/E4EhdjRBC8/6J
 SaO7GnTFWf5g/7WAy0N/MG/oIiaXTLiw10QhnEppL6b692qmvlmPEj6P7SkcjZD8mxex
 raLjnXxX3fxKHge1DyCHBmKB3y652DJDg7sF6w0Q/vy1j512PzFkQ8gPpsSNnUtMdn2V
 WyfN9N/Wb2YXFY3DxaTdyqkhyaGZnxyXV83zedo3EKt2/uhiu7FObKz4ZeqaahNv8K8c
 pj6JLGgmP7GdDBGiehD/YcsEWWYcoCLfqnovI/x/VSkU2BFYQyrRe9Apfufr5YFcJbpa
 tE+g==
X-Gm-Message-State: APuU4Z+z6/6mAJea3fP/TKs0k5CRHv/+F9dtlEtFBHIQ+moLNLZCj9ev
 MIjl8S7o++mY6VKsLQSKuJT7xuAqC/w9TKf2n/k1iCEjrmvWrQvqZAmtkk0NsmMWM91gCvzDPAg
 wwZPPFQv3ep4z
X-Gm-Gg: AYBFou3DJYBLYbH2ku36WQFjmir8ZWj005wqZ1S6yI02qWgJpsq4eooTCAe3/y9nH2L
 XhL+gCpWgy90f4U6PD+5D/IA9Rs2AsZrOepBe9b4tqmO5SrJLB/dA8bfdMxpgywwKze1vdinRSx
 mrGHwGRISN5RTeIQoGi00jB48kgz4VMCx9UQXx2YPUibTe6eXFCRkWoH2/DD2qgPxI8TdMDjBnx
 +2YViJe8G71xZHZD7pqwnDDtHffki63TX0Y4JMXCFrjzSoa6zb9lW2H9cjyvNz36uP6CDcPhcEX
 xD0EVcxOCGUcKi8k8zW4AVnbTJayeKOwW0MnjwvhbZfGeu9gYA6k51qQ8YsgCHLTSJ99pqCUSzJ
 F7kVEdEREqlVUxigM5U+4w2fGROvmAQ3nHPOJi5tGe+MqMb45dbyNoDW8zHrbqXjkenEyDtDM++
 UI7YRAaI2yiLZBDFO5PwNUqJAxVxho2EPaBsasVCvTLJZH2JCfZ9QgtA48AMzW9EZBi/XFc9HfO
 mXrnO8rkZ+5IPsVe+h5/VXj0D9pKjs20RVXZYuEaAFsroCTrNviybmtXJNaSRyFpXoUgo4d5LoJ
 P1MVHyVC0rBJmaB+L5CwgEPaNA0uAgpTXdgTuCbv+1T0OC8qqljxVvWMqbGRsU+K5A5+G/vzRNq
 nKfJEPoXp936UjfvptumRpwbXsnKdQDxVhVSinw1DzZ+wcy1zeNxG4drK+WTdDaR8ovtLtm1ZOT
 1s3/S7Mo+faW+CrpbqvCMp1ZlwVvNLmw==
X-Received: by 2002:a05:6820:c0cb:20b0:712:d5a5:fb0b with SMTP id
 006d021491bc7-714f2ae35c7mr6150837eaf.84.1793804499857; 
 Wed, 04 Nov 2026 07:01:39 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-716c0cdb22dsm1873859eaf.0.2026.11.04.07.01.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 07:01:37 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, 
 Stefan Hansson <newbyte@postmarketos.org>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Linus Walleij <linusw@kernel.org>
In-Reply-To: <20261024-ux500-external-sdcard-v8-0-badcdf6db2ea@kernel.org>
References: <20261024-ux500-external-sdcard-v8-0-badcdf6db2ea@kernel.org>
Subject: Re: [PATCH v8 0/8] arm: u8500: Enable upstream DT based SD card boot
Message-Id: <179380449733.1119852.5555913213470624998.b4-ty@konsulko.com>
Date: Wed, 04 Nov 2026 09:01:37 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, 24 Oct 2026 00:18:27 +0200, Linus Walleij wrote:

> Switch the U8500 Stemmy configuration to the upstream Samsung Janice
> device tree and enable booting an EFI system from the external SD card.
> 
> Add compact DB8500 pinctrl support for applying the default states from
> the upstream device trees.
> 
> The upstream device trees describe the SD card supplies through the
> AB8500 or AB8505 PMIC. Add support for the AUX3 regulator used as
> vmmc-supply, using the existing AB8500 PMIC driver for register access.
> Enable fixed regulators for the vqmmc level shifters used on the other
> supported Samsung boards.
> 
> [...]

Applied to u-boot/main, thanks!

[1/8] pinctrl: Add compact Nomadik pin controller
      commit: 5ddbcf8c440e2f104f194fa9a2664b683eff314a
[2/8] power: regulator: Add AB8500 AUX3 support
      commit: d02cccb7684b9d655b8bee82b8dd2cacd8d668ea
[3/8] arm: u8500: Enable SD card regulators
      commit: 93292513d17c9757c1b0494f467b7cbb905887c2
[4/8] configs: stemmy: Boot EFI from external SD card
      commit: 52f68243c96d5615e5654661ed872cabc658920f
[5/8] arm: u8500: Switch Stemmy to upstream Janice device tree
      commit: d970ac095f150588404fd2ef08fa0db4503dfed0
[6/8] ARM: dts: ux500: Make panel regulators have unique names
      commit: c698441e1c8a5f74f0444681df3c67af5e173850
[7/8] ARM: dts: ux500: Harmonize GPIO key names
      commit: 9e14d1457065b34ee6110bfaa59357650d23bd12
[8/8] arm: u8500: Package Stemmy device trees in FIT
      commit: 5d50adae908d8b02497055dce16f3095a0289e0c
-- 
Tom


