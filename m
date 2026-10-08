Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5C03CA6007
	for <u-boot@archiver.kernel.org>; Thu,  8 Oct 2026 12:46:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 59AF681283;
	Thu,  8 Oct 2026 12:46:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Bin8zptzrUwU; Thu,  8 Oct 2026 12:46:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 037148128F
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791463583;
	b=OPqiiSZ9pjRR1tEw2Pmd0CzZZzy0Y+6/CiXc9D7mqUR+F5/CiUKVYBGBkSi6rHMMzVs6
	 IRQKZNaMyUjl7EE78RqUgDVt3nNy3TjouG/X8aL+xt5B2ttD2MPOb2UpeMC228HqrQxKI
	 ZxHfhB/K1JOU9MHscKBpoeLM+iYGyIIHJ0WMPgUhQWH/T7qJOFZKZaqw3jhMYIGTXHoQL
	 0qnmFHm5gCHphN2G4imLPFwMI9fv3hkUkWyrG0X76SSgzF4zyWCrj9Na3LBOf4cCumR7J
	 M039zZcuKo6lNTUi+6onmI06Pm4xk1RZEr3qWlLgIWc5dugDW4bnRRkE3j7ZD54oohg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791463583;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=5YyAq6JNMEYlXagC7fj1/EDTqcL+idGHbWila2hYbBQ=;
	b=CoH9fqEoqIWQL6pM72APC52vyPgIxjoikkywH3TXIq68Uo9QPrAV6TiOtnJvTdoq1xTt
	 JotbppVCfyIJ4yq187i7ylE/lYAMiKEfz8Mp92G/9uP3xmcj5E3dah1XX9fAhQGHm3Hm+
	 DDAt6G0pv8y8TtXYbIH9bHuLH//NYchfose0GXrLu0AuJeaIN6xpUR0O++PpDonxVPCQU
	 1Odg9rTSIyY4vWysDrb5Ko2hC+dY3fK5hxGUDJ+FGQYuyTLiOnxgCxhZQ1yEdY9nodnMM
	 csXQlNLsKYlCBYtvWHj6cMzpwpgZ6zf1zUcKy53xs1MmVu4oblM8vMMDXAVqdZtwSvQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791463583;
	bh=5YyAq6JNMEYlXagC7fj1/EDTqcL+idGHbWila2hYbBQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eHuR14bcNoVrcV/t7mZcNy/RIvkQzsDRnpolvuY70Xg6UiRt0MNapdrS9UDVfvZey
	 fQEwfxG1yBUjSpONnhw3u1M9BAW0H87DW8MFawDrIWbG6z70enYkj1AQn6rJLUyC3P
	 UX3MZvP1FI5vcJmXGaKwmjNZkpJGdbP5WrIugzAAfTrlVlJGb21FZzSFrTWtS3Zqc2
	 czK88GgDiVDI5vrgcoULQOnslkHbpOAScfDHxqJjV1dPEkDtpo13igfw1QBT2pJwAj
	 ghj+GLIMuJ0Dn6+vVoerkCM5heSw9AY8zPbH3am4IuMiTQQXnu9EGH3t5siZI9E5qX
	 BSgCpf6e8vg0g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 037148128F;
	Thu,  8 Oct 2026 12:46:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1F0151A6
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 12:46:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 03A2760B6E
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 12:46:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LFv5ryBOjhwN for <u-boot@lists.u-boot-project.org>;
 Thu,  8 Oct 2026 12:46:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 85CA660B39
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791463580;
 b=sVQjjemXBsWTifhHoXw7EeOVZ/TypcKf3nqvta3MSo/ClPifpW+7EuA6c7uTvtsv5x0P
 oqVmkj7hYKy8DlC09zImNMNjR07lx7By2zrFPVcFja0/z274MQ6IvXEWl+7cIhwSlCl2Z
 /SdZHjpKB1qBSjXz+F1Q0n0B3UzxuuF/MsnlUhD3/g8aj1YuvBoJttm9isiRNLAqqfR4C
 F1E7hEylP47E/wRLApTIoEnh4eQKvLC/8ESfa+FCFpW3w0O2g+Hz4UoOZ9vmXZjeh3+qJ
 e5k582dFOxWmQYlDT/0ytbu0X7c+z7SJjurvu91CWvSMZtmtIRHLBN7jdipLdoQsGSQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791463580;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=5YyAq6JNMEYlXagC7fj1/EDTqcL+idGHbWila2hYbBQ=;
 b=FORshIoJByf1xMSqa0qe+R/JzYXfhuQ2oQVcAuTuYp/kSS69OCPsF9s4x5SV/AsGj6/w
 HtI0igFxWyMrRYB29LnehVyT7km3n4H1FRgN4K9+17RIt9UCZknhHLzcScC0kg3Fga6Nv
 lmO8wXyOmRoCOwvX/rGvlnLOQiLbSyhCG0hqeY3XY5XM4z4a9kj68ZmVg1YJC0Ozp6MtH
 Jx2DXqnZCLTFtREsfHeXYdLd9k3WTwKvKzJeuFKUPSUAqfV9zuetoIQ7kCETK4zFDpBc8
 rom+FHekvmzzt2kMn5NprEzXUSGt49x/onOpOTsQwKOtwj322Xu5SdQOoPZV49ROioA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=IUV6u8WF; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::42e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42e; helo=mail-wr1-x42e.google.com;
 envelope-from=neil.armstrong@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=IUV6u8WF
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 85CA660B39
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 12:46:19 +0000 (UTC)
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-48b0ef9c76eso4089545f8f.0
 for <u-boot@lists.u-boot-project.org>; Thu, 08 Oct 2026 05:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791463577; x=1792068377;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5YyAq6JNMEYlXagC7fj1/EDTqcL+idGHbWila2hYbBQ=;
 b=IUV6u8WFduTu2NQm++zirhCibJ8Prwx/w3Pp7K5GPqFUAsrICbjn0fQGkbkyw6GcNf
 Z9EWYLK9bmF42kQIUoON6FENBk2HiT3geUYqkNioH+13vFafeUiBB6hmzZNMb9ywg61X
 e3JflYO/9R8dYtcHGJjyUPLPVtut3+/+IXTFTmtU6ufAdpmlrYL2y/f15BpMvc3pSTRI
 Zst3NlETvVwgtL/jtf02/A2OXQrLoFDZFrkQZIYE8EO+D6agu7IsLMKCsrEpcqe9Gbm7
 71SrVGQQX9Hx8DRhPZLDWmAuKoe2WhNGYh9EZ2y785A6IfsEiD1xNuTqNTKty5ZXdIQr
 vzlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791463577; x=1792068377;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5YyAq6JNMEYlXagC7fj1/EDTqcL+idGHbWila2hYbBQ=;
 b=dKd2A+lSvmHl6YmKIiM0v/nCQZVyuHgHAolmmWb1fgIKUayK9wObn73F8Qqiac7pCD
 g4yeDyVInGuWVLWMxN6ukclbPQ75He2/u1aTc0Ngb5N4i0C+qjwdeLxRFjRfQ0v1l+It
 +I6C1zhtY6hPmwPY7IkQH0Zk8nh5x2TMqxfHZ2Q5IQkm2pNpcfiVNs+8kGLNPTTGNqsv
 KkAJTURE0EjS77r7Me69Eluw1PheHfWY2IhkhOEfwhdsiLti0ndVS4ubhCY/RWZD1MxC
 OUBtbPaMirGYldYS09Z7IxaIjepeICpud8ilK+UG4semp2533DZr6LM55LcURo4YEQqF
 djDQ==
X-Gm-Message-State: AFq9FYIp99aNfcRyf8sZbRD5Wg3/GxEKwVKTJ2KZGnQHDV7wuCj3Osth
 Jv83q5PeveSG0mrucmjXv73IScpGWRWc7qrLoXE6yojLFqriqjliqNUsDApQrhlY268=
X-Gm-Gg: AYBFou1b79GGAZIQpImtbqCNVywAhyoyOpwQl/teIILuMzhficQozbFJamJCSD71+bM
 SOkwRW5dvL8wH3b3vRs/rGE6SkKC3EDMWE9YVItRyv76UNQTSJWCodDM1opXy0KQNP4qqyJpzgZ
 Qpx2g5CxhkTzmcEMfCivxXrk09cZdmnchjxmd7Eaa2zSkisKEggwai2j43ydzrliUf5u9j+wEzq
 5VU+TrDNwjUsXx9/h1zlxVHAXT0hLLhlWCwBTMSejlLIdOMO0DC9vDFzeWRDShPFbWkes5SQjvI
 FtRi8kiXQdCMRtk1WQ1oyNQXZ6JCFUq//An7sPZdatkbxAjJ6pk5Sn7IFV3G9eob0F6Lz/MB9X+
 Sz7iIyGw7l7ZCqBS7uL4WV/6i3aQiZj1cwwLeV+nw7UxYv7pnmOHI/W6gSucJKGMtwmCXSaH5SL
 SynBZ/ZW2jSa2MTKXEGPIQTaJ0GRo7tfCjJW0bse/friOZZKHWg7Ug4gb0pdndnFdtKv69xnsQC
 XfpoDSqrdpSfPAvsYls
X-Received: by 2002:a5d:5f90:0:b0:488:75e4:f5b6 with SMTP id
 ffacd0b85a97d-48c728ab043mr9472730f8f.54.1791463576829; 
 Thu, 08 Oct 2026 05:46:16 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c71d04c0fsm11015183f8f.10.2026.10.08.05.46.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 05:46:16 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: u-boot@lists.u-boot-project.org, Sean Anderson <sanderson@brivo.com>
Cc: u-boot-amlogic@groups.io, Tom Rini <trini@konsulko.com>, 
 Christian Hewitt <christianshewitt@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Lukasz Majewski <lukma@nabladev.com>
In-Reply-To: <20260817171623.1943847-1-sanderson@brivo.com>
References: <20260817171623.1943847-1-sanderson@brivo.com>
Subject: Re: [PATCH 0/9] arm64: meson: Add s4 support
Message-Id: <179146357578.183177.12895968507698976143.b4-ty@b4>
Date: Thu, 08 Oct 2026 14:46:15 +0200
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

On Mon, 17 Aug 2026 13:15:11 -0400, Sean Anderson wrote:
> This series (along with several patches submitted separately) adds basic
> support for the amlogic s4 SoCs (S805X2/S905W2/S905Y4). My tree with all
> patches on it is at [1].
> 
> I developed this for a custom board, but I believe a better candidate
> for a defconfig would be the publicly-available Khadas VIM1S [2].
> Unfortunately, I don't own any VIM1S boards, but I have included a
> sample defconfig in the last patch. If anyone has a VIM1S, please test
> that patch. You will need to use AMLogic's FIP [3], as I have not yet
> gotten around to submitting a PR to LibreELEC's FIP.
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic-next)

[1/9] arm64: meson: Add s4 SoC support
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/a0f6e4a9f1b3ba2314c58bcd66a61a8941508b58
[2/9] clk: meson: a1: Eliminate separate id parameter
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/81b3945a2096fba2ba8421641dbdabb5ad73740b
[3/9] clk: meson: a1: Use clk_set_rate from meson_mux_set_rate
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/99bd1d3f515842e8801d6c8cfd556077b9ba219b
[4/9] clk: meson: Use soc-specific naming for common functions
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/1f615257213246dc741416b3e92a4e9e76d76d5f
[5/9] clk: meson: Export a1 functions to common file
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/5dadc8a09b07f2bfa9bbf0d151b660c0beb92a90
[6/9] clk: meson: Support fractional fixed-factor clocks
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/538d95ef9ed6413dbd735ca799dfad2fe8c6e001
[7/9] clk: meson: Support power-of-two dividers
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/10176b815d013d8825fd243ae20892cae35c249f
[8/9] clk: meson: Add s4 clock driver
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/5363c69e08d0f96834f4d80dcf23e11d64cfd80a
[9/9] meson: Add Khadas VIM1S support
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/9c048da44bed99311355450d70840bb0795e21f8

-- 
Neil

