Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F5D606A689
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 14:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ngbkXXEt;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=oCwetmZX
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E1F34810F3;
	Thu, 26 Nov 2026 14:21:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qItNM0tkWz_J; Thu, 26 Nov 2026 14:21:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org EA41080F8B
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795702919;
	b=p8HhsaRU7WJWvLde8U2FoOUtN5XGH7n25GYGjWJHuLJXK0x//gSLd9s5Lek0mqQaR8cQ
	 yowkHl1vozZEMZFR5lE+54/+nN98vWrTBMicBnUFVMceNiDHhRzoXKCPjFTDb7n6QIFJD
	 QSTvvNu2tFf4jRXZ+us0fB35xxNgum+nd5r0W6g9B2cgcRflHdpFKwtautUJrogCOsyD2
	 WaYUmgToekMOR/gld8TtbbXJi74fa4oArZs6V1eE3RtiPiLTi6RdQaDpqCB1WiqHiB3e0
	 YCe6lLSFWg+TOeki05WsRTQRhTwt4G0sBEPeo/EhoLvQ9FLMceuUbA6EUpfO1FQn6FA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795702919;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=0n9zKssz5DUjfHisarPohYKXf1pSK4syaakRSTAGVR8=;
	b=INp0HXPAFLFysJTyOa/OmKvh9/IsSW7xZxe6EFq8SF13FcD6aJTkG6T7YUr+1vWdGmIi
	 Z2XHIlZWaBCEZqt/Ue95fCppqO1fKGI8QU5WKG5cOrpXJ6HXXxwQ0nLX5ZGtp0ax8eqwA
	 HqVimXK/edLsxgK8/VilzE/hwO/1NiybuHnTEy+0SbpvRAYPnJlB/qW+SyQMtYma9J8wZ
	 kGBya2w9uO0aC2j+JKLr6HqKNGagq9pZ/2puGmKj2Sywz/gq7x3t7Dylm2p5QQlMad+rU
	 LqZgMOiQ0QFCNuL2Y+5p2+qLUfFZMglNbOWVg+mDuz4x8MZ5/G0IXcAYsmWgUvBAgnA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=oCwetmZX;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795702919;
	bh=0n9zKssz5DUjfHisarPohYKXf1pSK4syaakRSTAGVR8=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ngbkXXEtdxktQxECTYBFLrFnmIkYB3/91oALFIMOpup8lkDcEmYHg0kZY5NluOUJx
	 SKTIntlipeR9dYa/dPwNBdJ2YZENzGkI+2FXQcwMaSpkunDPuWZNoBnCpg6H1OJcxs
	 zQBC4WNVSLdwOA3jrMzy2lsAf7Nhvv8gQcnwAKqz0CRXwPAWQVgrwOGuUECS8xV7Fs
	 bJ/9zzqT6FuSJXOZshbmhNKbptuKgFU74xog8GWFWtkAKlO7bqFoFJzo9OU+8u/ItB
	 z+M5kVx9daeNJUsb8ZD1z9bHubWi9fJgMlURwB/KnNVob6R8ql1BH20/ZBMe7pGsoV
	 G3WhQ7Z78RuEQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EA41080F8B;
	Thu, 26 Nov 2026 14:21:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id BBECA1AB
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 14:21:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AD9AA80F8B
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 14:21:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BQdCRat7Z-wG for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 14:21:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9771C80F76
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32e; helo=mail-wm1-x32e.google.com;
 envelope-from=glaroque@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=oCwetmZX
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9771C80F76
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 14:21:55 +0000 (UTC)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4a2153c8525so57258735e9.3
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 06:21:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795702914; x=1796307714;
 darn=lists.u-boot-project.org; 
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=0n9zKssz5DUjfHisarPohYKXf1pSK4syaakRSTAGVR8=;
 b=oCwetmZX848jrJcD1rC2rXa0Uwo9lLbvQNX8fvmTmDaTJLZRAvTG5TkqoB9lHHP7ta
 SxOrxkNOC3eqmFw5vH+rQt1o4MT2V8jhw72iF6TUIPQ1Z6JsFX2yDzRiAg28BaMQPPm+
 pxKsVHYu5ZSlOSs2LXsdKbTbwjr4nCiTJGMcXSpcikrYO+uPETiXkfqR6bRzuEq7zoW9
 wRMQ8oiEtsiIWSo5z0txZfTZSiop0slF31EDyLo3H1lyFXSlxAKMiDs86wCYQbHaW0t6
 dwj47HsNP+RVZEI5wDRvftPXsRxhlU9DDRsi+oQaUXSSQ1gHQGymBYkZW58ci5hdJCjc
 0rRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795702914; x=1796307714;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0n9zKssz5DUjfHisarPohYKXf1pSK4syaakRSTAGVR8=;
 b=fLE4RPW6jbpUjyxkwQP+gvWuKCXNZkQnQ6boCBuFRhez2Jt1z1o16tLECj5kMusUCk
 klejTzvHdCzy3jNOXmjL4m7OUL+hNwnPZgnlw7VVs36m7oTsQCZWPUIbn7WvZht9DzfO
 8aNlAlyhikJkF4wNB0wdINBZJ24xJSWE6VeTnKHDu68oQl35K7htMz4NUlPyzutWh0Tm
 WmiNB/pxCTWEn1HbfWihSr37nOvFN0HTWsyVQEIxnuy1rm1ddNf/09VT16+Bag7Y+/NQ
 a3wmuYxMa5j0FwjDFqRcxYsKRx2fZuC1Cziw6ZPsJlZ3eKY9aeXB5vwSS5th+DwIpEIA
 ItEQ==
X-Gm-Message-State: APuU4Z9NIQ4BteV4lI3IVZHN6+HnYr9RIi86DLSFTQ4SswfVN+IoODtA
 68vhXGzgaRBMWJXJc4zHTCyBgMUT8MNK23LGSteN2VQgp+pcDTzB+WaIMeiwYX94EfF4aHqfLt5
 wa/m6Lx0=
X-Gm-Gg: AZFdTZd6Z0xmEhVgymgPHk+20V4l5PPytF27CbE3hBbIuoi8t7W4un2F8RkjFEED/1V
 EbbZ6qNx9YmiiE7WX5jFhd/JR3rifhLEarwsqrVjdgJ8qy8JQTvaN2wZCECYaGdvv1xEGr5vNGv
 6GlIztcs7mJ30sUJCR03GEmcRl8Ga+/87bQ7j3odrAtNLYoIrKDNlYriM2GclIlgwBTqtBF6vzz
 IljNzbavAym4q+dl0/GLdhp5/KCOuX7HTMR5pZ4MpEB0X8HOpJOTM6di26W5mVKs4mVM+JnLVCp
 N38TYfEfYchcwEUwfxEQNZc+VRawBMux6Eh2cQn6705NyVM26S/coTDoT90/YpSehMCG1BOzL9J
 B0yuIaT1gTG4Np6BAfSEoHjXCGHk66eQM6W21xIZv3y0uqy+J2HCYT/EGP+GNA9O4T8ohydtGEd
 pW/LYww5V5o+Sj6umFJDhH5rSyBiuBguoqGeyf6wA2QgRnfgb6luNwqyAQ4QMx/2x+A4c/o89uW
 YfrMGGAMsGsmF89ACObT8QX4PIQUa48J2zZjdb2hurL/Oxe2vQYkdi+x//JRyKNEUcSpf8Pm4d4
 Q7OHj9t/4MgSYs797jUn2Ajnf7KS/Ve6qvfGpy/r07CYKPTt0xY=
X-Received: by 2002:a05:600c:483:b0:4bb:a9f7:681 with SMTP id
 5b1f17b1804b1-4bba9f70685mr47483795e9.3.1795702913991; 
 Thu, 26 Nov 2026 06:21:53 -0800 (PST)
Received: from [127.0.1.1] ([2a01:e0a:e50:3860::e1d1:d182])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb90655f5asm387647325e9.1.2026.11.26.06.21.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 06:21:53 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 0/5] riscv: spacemit: k3: Enable boot with SPI NOR
 flash
From: Guillaume La Roque <glaroque@baylibre.com>
To: Yixun Lan <dlan@kernel.org>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Yao Zi <me@ziyao.cc>, Junhui Liu <junhui.liu@pigmoral.tech>, 
 Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>, 
 E Shattow <e@freeshell.de>, Guillaume La Roque <glaroque@baylibre.com>
In-Reply-To: <20261122-06-spacemit-k3-spl-nor-v1-0-33beb921011d@kernel.org>
References: <20261122-06-spacemit-k3-spl-nor-v1-0-33beb921011d@kernel.org>
Date: Thu, 26 Nov 2026 15:21:50 +0100
Message-Id: <179570291085.2502540.12731523896156873061.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795702912; l=1468;
 i=glaroque@baylibre.com; s=20261019; h=from:subject:message-id;
 bh=TkDYZlYbf6IqyjgGnmMUN2lZatxuw6Jbctpf+QDWKUw=;
 b=yZHMO5ppm/uE6qCFthWJdAN845w4+yNGNBtGloBUzG2qWmFOVvYfmkrGzaYS+ccplwjnxPPra
 qJ1GW/Q9R63A7vLC25+qLI+xmOaBTB+VD3xRSfy92PSYEdjaHrzhuZG
X-Developer-Key: i=glaroque@baylibre.com; a=ed25519;
 pk=nMpSg4NT6M6q143E089emouMc+MXpHO9CWmnEUfjhjI=
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, 22 Nov 2026 02:34:08 +0000, Yixun Lan <dlan@kernel.org> wrote:

Hi Yixun,

> Goal of this series is to make K3 boot from SPI NOR flash out of
> reset without relying on any vendor code. Add necessary bootph-pre-ram
> marker for device which will be used before DDR initialization, also
> adjust defconfig options accordingly.
> 
> Only two prerequiste patch series are mandatorily needed.
> 
> pinctrl: spacemit: Add SPL support for K1 pinctrl driver:
>  https://patch.msgid.link/20261029134705.3767-6-linux.amoon@gmail.com
> 
> riscv: spacemit: k3: Add SPL LPDDR5 initialization
>  https://patch.msgid.link/20261106-k3-ddr-v1-0-1e60e1d78020@pigmoral.tech
> 
> Patches can be applied and tested on top of upstream 'main' branch,

On current main, both this 5/5 and the LPDDR5 4/5 conflict on the
CONFIG_HUSH_PARSER line dropped by commit 6a8ea4096ab5
("configs: spacemit: k3: enable CONFIG_BOOTSTD_FULL"). Trivial to
resolve, but a rebase would help testers.

Tested on a K3 Pico-ITX (16 GiB) on top of main 9d67454e920b, with
Anand's v2 and Junhui's LPDDR5 v1: the vendor bootinfo is kept, SPL
replaces the FSBL in the fsbl slot and u-boot.itb is written at
0x210000. SPL brings up LPDDR5, loads the FIT from SPI NOR and U-Boot
proper reaches the prompt, with no vendor code besides lpddr5_imem.bin.

Thanks,
Guillaume

Tested-by: Guillaume La Roque <glaroque@baylibre.com>

-- 
Guillaume La Roque <glaroque@baylibre.com>
