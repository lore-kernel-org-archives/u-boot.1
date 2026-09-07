Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF904C79F9F
	for <u-boot@archiver.kernel.org>; Mon,  7 Sep 2026 18:06:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3FFDD60650;
	Mon,  7 Sep 2026 18:06:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TX1sNTtCULto; Mon,  7 Sep 2026 18:06:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 33DBE6068A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788804407;
	b=gb6n/UdVWKbXl7CJRbEbdPkDqPIgfTOEE+RjcUE9/xEqCFoAWgLVHoUZmtW1SDmT714f
	 cnuHDj/2ccH7Nf0Pao1RZsSPsZIlmWTBQmCp42j+5e+4p7ltrP1C9a7+eq8pAyMeeJA/k
	 6j2qjIQQGnWe/mQI4ksxMNFbsSqz6e04zxfb4KlUbOvG9xhK4ACQ8kADioBRfVVDnyl1s
	 1M181AdCTgZj4XRvAQ9B676mtvz53DAWZ/v5B18eksbb6Pxxy16pgzr+93/Lrz/5i7Lmd
	 cdbK/sUOQ5VSXbi/Am5oZ+FScwm/1CUsTIqatTG4f8IRtMYlnKt/QvSHIf0EMir7CFw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788804407;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=iOF46sScvgZBBVcms3H2X0g7vs5rAeQ14UTxztcCn1Q=;
	b=PcoxeZMPEOHDItfMdujC9o4CZTKE+D9xoZexDkr4efL40AtvL9YfZb/7Z9T/aZvnTVpy
	 gY+6FIJIKI81xKP0q8Fu9nEXYG+STcOxXyNSv+w5Y+MJxnnE8QpcCJwoX7bhGYlRlCJES
	 RKc1126xahhrxYpMd1KQHm4YZBH5uYMXRMlY6UKHFWb9kkyFyejSjtxqHUwvQKUpMeJvf
	 WYF2d8Q/W/awDqrJ3PKbLmTh3r0GhzInQL48IQZ9Fb03WQj13fJT1oZwVvdMG0Klwr98L
	 mtg9u6jkhaKpRaCzD9cGNNPAsfoSao4F33lHTnK6pjiGVwFiUMpIqqHQkISynX+P/MA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=J01esLZi;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788804407;
	bh=iOF46sScvgZBBVcms3H2X0g7vs5rAeQ14UTxztcCn1Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uvjt0KiSfb/JceGOTQvq97agktr7qEa5hTGwPvJclpEdK0LKkeyFcWC9BqEperu3G
	 uvDaQ9abYgSZgU0DyUe9PmBYg1BtMP9/30cdyTHD5RKLJEiCSE+EjOu4VVEnuYWbRb
	 iiDMCRpmoSWudQu1EpsjbYUIs7mhfEAGPjqikbZNNb8dgvDArVUfn7UJCPC4o3qsf8
	 OA/syk8D6+var66DotqLJdp74oFU0BX7KLqXUIQmVWwJAddco++L7RWjMAhrzEdA+Q
	 WhpyKbg3Z1HoNnGL9icNXWhrZ9MBEgnG9fd/o2mrEXXrHhf9yc73HU4z9UlO+lIxck
	 MNqyEK3QTzUpA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 33DBE6068A;
	Mon,  7 Sep 2026 18:06:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 670009CF
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 18:06:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 58CD46064F
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 18:06:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vWCL6zLTcJHd for <u-boot@lists.u-boot-project.org>;
 Mon,  7 Sep 2026 18:06:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 8DE05605D0
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::36"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788804404;
 b=BCS9thunkr12NK1GoSdQTp2E4eLYHGZ+kV+PwfKp197uRXvj/QFuKvbyOytT1optBUCP
 UdtXYX5PZ0dfg81xYRk64YKRSjuLCNayYK8UDQLhQeMMdKO6A7JjykyEpjH98c7Z+43/s
 lg6cxenwsOFyjV5DWMkc+shLjM1H5pE46HvCh/1JjyOj02V67OmKTm3/X403MNDCCwFtN
 GqMInIIzJ3i25KL+HYzRJs+6P5+iQIftU8JIjM6kp5MENpe+Q/gNUhrkDjtCTEil3Bb6s
 JZcY6IrCXrubfXNTZhim96WkpYKmCC05O2Ozl5Hx52tDvwqRfpDXtaoca0iI3dxz/Iw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788804404;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=iOF46sScvgZBBVcms3H2X0g7vs5rAeQ14UTxztcCn1Q=;
 b=gH6aax0P11dwdLjhYmVat54wfUW16Di027bV5IFst6yCzcB5+Hlxrc6T+ZCmjKVhGuNe
 PiswNcqqwpt+F2DEvv12TNeXOIHwSnlABS5inx4q6kpPlFG9y3EwD+bhE/8UumqBa8uQX
 7kVSVfgmJQitMPXXYV/SmahPcb9C+bem5NNwx8ArReyDztzvFVrE57+oTMyGvjNhCDfqW
 5g5wl7PaSZGnGBSN+N5k7F5YTFBinV33Pe9Fk4i76/DCpYGrz0UMPkOXvK/9MDZQi2BGy
 MnU1K9Sr2bwdrYZN++4exjPn5UUl7hrbEdBtEnLnGnj7mkVZy+FuL/Vx8D7yyjOB8Eg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=J01esLZi; 
 arc=none smtp.remote-ip="2001:4860:4864:20::36"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::36; helo=mail-oa1-x36.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=J01esLZi
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8DE05605D0
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 18:06:44 +0000 (UTC)
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-46a4870536fso2646971fac.3
 for <u-boot@lists.u-boot-project.org>; Mon, 07 Sep 2026 11:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1788804403; x=1789409203;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iOF46sScvgZBBVcms3H2X0g7vs5rAeQ14UTxztcCn1Q=;
 b=J01esLZizhMUqoki60d+weAhVzX6TTZ2opNiDFVC0c3td1Rk9e/P7rhpAaATjJgf67
 xYOu1ETXASDpNn5B6tiNk06biBuhwPt85WJaR488dkjO8bnXrCm2AHrLRMvz1zbOQ+bW
 TIeLl5uK6eU26n9Zlyzpm9r6DEtM8li/0/tug=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788804403; x=1789409203;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iOF46sScvgZBBVcms3H2X0g7vs5rAeQ14UTxztcCn1Q=;
 b=MxTN/0Op9oyg3A71NEJ6pyNrNKOkG9n4A3dRatA77Md6+WAiNASRkz2cK11E6BKtVf
 uCr9t03VEmqHDjeUa9aaAnFNtKmpRuvTiQj5dypwnVH08HBpSeDwcMPtfzlLFHBUw7PU
 /+IB1GsWZxGoVTqfUCzEQyrTzm3a+iaxEyQCLEcfnAVEPRpjgm4Y8pmdAyTZl1fS1wqd
 1HpXIDN1oVXQtt/Ecb6w443w3yhesNVsVzNRj3AB6+5JqZE2MUQUgmlq4mDLilFoXWy6
 h3lxOqcEnEZPLZER2jyW6EJC/CMdcDmJih/hEWnyRTWOVErKnj/vP3TWCcGGTM37zKL1
 VFXA==
X-Gm-Message-State: AFuF++lWrNWMagpKVx9EDGzMDWpuVTrTbFjxdfwFzqnI09T30eo7jqnZ
 1diQHDaTUIeZUfyCZymTJVQSan24uLjWlNSeu/O/jf5h1DsY1D/fd5jkfDMQ7fCLb50=
X-Gm-Gg: AYBFou2jkcRTD9lcgLgFf8yxEcpmLgU309sv9Fcu4JBmWIkPwOZbC401sGaZxw/5alr
 +aG5uMg9OjaiiQdQGhHwuoprY7mTKCyMo4KJ0tOV4xJPigjfikb2B0Tw99ca7knI4PxogufS2r6
 ShMOYnwpjvZenvSiKgKPT1/O4q9C/aVthsJi/damG1MXRwLxIernXSTPBOhS6O0NLw7DbOEUrIt
 WqlNbk1PiAtl2H8crxX/d6uC45fk+ITKrILiaYIFxJ/VH8Nn9NQ+G53DQ/yXtXvk7EVt4cFHTmg
 79e5YebYVpk/3si5cAMPjBCdeyQigQvZCnCLZZL2CIDcWq+8Dj3jhuFtqR6t/F5zHENouS0g6hJ
 1inGWZvx1KU/0mz7Y/6WpL/Y1ZAt+6QDJVG9idDYrSfT3k+VAGp0Hhm3xs2vTl9iA9dXZWiaHYi
 Ca2jIHZQvAVNTxyzTM2fxNHjh1X+338d7Ry0vnAl7Ry10WKsfJJW6TFimtpJKyCnpy4Z1nrcLz7
 W/JS7I7vUat5hGw+XG6JZe3sfFbo/6Nzhq2ApsasuACsIDjA2RcgjAfg0LT1MYuFFZdF25+Nc7z
 5ibzmXGj7Mx0BLyz+QE=
X-Received: by 2002:a05:6820:4df0:b0:6b9:937a:a096 with SMTP id
 006d021491bc7-6b9937aa45emr6485483eaf.64.1788804403014; 
 Mon, 07 Sep 2026 11:06:43 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6bab80ba74esm4282672eaf.10.2026.09.07.11.06.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 11:06:42 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, Bruno Banelli <bbanelli@gmail.com>
Cc: Stefan Roese <stefan.roese@mailbox.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Vincent Jardin <vjardin@free.fr>, Sughosh Ganu <sughosh.ganu@arm.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20260827193602.208352-2-bbanelli@gmail.com>
References: <20260827193602.208352-2-bbanelli@gmail.com>
Subject: Re: [PATCH] arm: mvebu: armada8k: do not offer the ATF/TEE region
 as free memory
Message-Id: <178880440200.3942941.6667082079782791789.b4-ty@konsulko.com>
Date: Mon, 07 Sep 2026 12:06:42 -0600
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

On Thu, 27 Aug 2026 21:36:03 +0200, Bruno Banelli wrote:

> mvebu_mem_map[] deliberately leaves the ATF and TEE region unmapped:
> 
> 	{
> 		/* RAM 0-64MB */
> 		.phys = 0x0UL,
> 		.size = ATF_REGION_START,
> 		...
> 	},
> 	/* ATF and TEE region 0x4000000-0x5400000 not mapped */
> 	{
> 		/* RAM 66MB-2GB */
> 		.phys = ATF_REGION_END,
> 		...
> 	},
> 
> [...]

Applied to u-boot/main, thanks!

[1/1] arm: mvebu: armada8k: do not offer the ATF/TEE region as free memory
      commit: 835ac41ca69a5aa9171b6c8dbbb54ddb5520c161
-- 
Tom


