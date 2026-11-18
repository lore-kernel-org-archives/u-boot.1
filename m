Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483A4606A32C
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 19:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=wTGEBn2E;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=p1/ftrHm
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 20FF040822;
	Wed, 18 Nov 2026 19:08:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lnaC_pRmCs52; Wed, 18 Nov 2026 19:08:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6958840844
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795028930;
	b=M3LTUp+EXQLW4LpF50YGVFIY+tDsiLWLF2cNdvdeqwXq4p8TTmw4oU4XzKCniViKWV9G
	 LuDRcSFvRv9vmIjqcqJ5EQNfQfmaE7g9qQulkzo1qGPGX5JCLV+9x7jhh4e9axuVDOJsx
	 mA3TS2uySmjm5Hu/z3E1BrtPjHqBjTHp5f+y/AOw9GMSVKbi9kc8K/yn1S8u0KRr7ntsV
	 5qochqrUNcdfcJ9QeOQhkwaQVqTJu/L1WhhI7fcy/XSRNbj/4XRkMIqdEycC1QgBOgqM4
	 uy+xQW9+KofgAlWKJgd9lmD1tTNxVCURox57m72UTD57ZiT04stb9lcr+2OCYJE7N5Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795028930;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=utBwonalHJC+QqZmap5Ur8iBilS/ySOf6miGlzJodhs=;
	b=O4czJsJ0hnrxDAFL1lM/yT+T1t+8WMCq/RlkFit5LchAXWRCBHhNPeHsWzMUT3XDoC2Q
	 Nx2CLkH0/w4JkXOMFMU3B9OptZ93UEVoWpuErDnoGGsj7zWDGkJKb40HA4BSCmnUnVLI7
	 2bijiNweeHxG7Qaa04WO6rtxGT5p9+rs7NEGccKcVtgXHn6uS0X/gtIIVle1vZBgIDtye
	 kN9JMUqWOLJhazXP47LlRVd5nvzOC4tDu3Vq0UYtwCy5Ae/ZdOMs+2RMaXwqSgUyX03u8
	 +sWK7Bg+HrLvuwKGNNqhqVZ7DenUU8v8cxZwDVIVz39zJodVHZUxq5bHTiYZwN6FyYw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795028930;
	bh=utBwonalHJC+QqZmap5Ur8iBilS/ySOf6miGlzJodhs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wTGEBn2EPs8DqG8x6B6ogHpTH7eZIA+UBIV2EEcKD4OAyMO+lIPFaZLVZvjY+YuYD
	 lc8XfEklXgXZH7yUL5NPkrEzRGHBZ0NNkepjpT/TJ2KfVQctfk0mbg+sWsg6mRc/oV
	 Bgg0A+vZbHqeqXQYnxZBrdRzmhebfZDA2h3LUIphWNZ4VIycsWwQgfvHVjWKP5WTkd
	 GkHJwPAJFsrEEkT5bHGG9ndoNhxiwtJkSV3r9Une3ZNLWOYyvc8yVyw/9v+aomtjnb
	 JIQKCfqxkEHPO4FZ49sFnLL93KkZ2UUWICUljYttz4flDQRN9ZHXCGGwCx6ABzJwwm
	 3r4N2agWBaryw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6958840844;
	Wed, 18 Nov 2026 19:08:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id CC47113C
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 19:08:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B154B400A8
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 19:08:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yGRUoW_mc-EB for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 19:08:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 13DB240095
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::229"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::229; helo=mail-oi1-x229.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=p1/ftrHm
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 13DB240095
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 19:08:42 +0000 (UTC)
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-4d7034a99a9so683245b6e.3
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 11:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1795028922; x=1795633722;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=utBwonalHJC+QqZmap5Ur8iBilS/ySOf6miGlzJodhs=;
 b=p1/ftrHmpJO78WkaZ/CQFBc0db1dpNb4yKgIKtUD+/+yBspjiCdCIgwlpD4G8Csi6N
 27HZ57D977VrpD9+ZTIGkMcbKNsE90hVAeS4n5JqskmzAPZnefqc6vsg5a2z9hfsrvNt
 gwtChqP8rwgFqXBs/dK/ynRSo0+i2ZVhTiZL4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795028922; x=1795633722;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=utBwonalHJC+QqZmap5Ur8iBilS/ySOf6miGlzJodhs=;
 b=CWcwIr7gTN0VUx7t+Fh8Ou/MAEgT9iwKIE6t1UimToT0jbXf7q2+vRM3uGlvrafzYx
 u/fH8YXW0gpSMQpDB9TlWeEiZjeBgkKQ1KXILqlaeWk99wPjXBWq2OaK8pGRDkC86NeC
 fGbyhZ9Qs7uGUmvGXyMl3b7mwDWe6hJYX4P1CQXHOhcDo9YVhT0/qh7qA5RqEuANoZjt
 r32+RNMxqY/N+U6Rpf6N9Jb6ur85ZK6+nKom19YZ1tx8FC35k/L6mFBxlEMr+mNv3ELN
 FUcEPFYwm3+WTTuwk10/ijt7eZw/fCQMOAvOEBDMwj1aJYw1EEDt8bPyBWNBHbk64VFS
 U/8g==
X-Gm-Message-State: APuU4Z8awpR5QWYuwLFvaFWi7herKcggaAS7wVx3nDJ0K7Opbcv6xHxR
 3LQM8/eH6TtIwenYF+A2y2BAjlML2LS6RC+tH4LZzO4z7iiZeecTJIgCCmA9mbR33N0=
X-Gm-Gg: AYBFou0ko1lEP1Ub3UQWIOJomnbPNPMNf08qqbh5h6+qSolAtfDT1CnKFHy7Q60kBJ8
 MLWq/ZGMlkq9lHE0pNspm5/59TzpvBqnUQARQ+NL3ksp9sjD3y5mfYSzYg/xL1OcKYiQR468Vrs
 laStN7n77FtudQ8CJL2o8VZEM3CBpwmTSlRB5driH1dhmmy9Hc94PD2HIlnzdG4XKR1IMjHYP5g
 ANCUcf6R/846pjC0m+3X62XHVm2hvQXoxxxHt2OXO1TlbTwVUV8vo7E1hj24pM9f0yyTYwEYK0f
 d7H5Tg+mYGcrMRth/UExUVPVhCOtOytxDuTYNsmkVNQU6DTtLgV5VE4qeSgaJIShq66JR3Ak7eG
 5IcfPXx9+ALCU0TTRCP6aE3/pG4y/dg1hzBAexKxyZOc1FkDqO6ScwJjfJU6uE6IMPbDA3O7Xpz
 8GefYfqsswcdhH8kp00PS6k2eqAfzLLXCR61bZ774VIEe0S1eGm+in8HxIwKqeXR1SWPoFiEDXZ
 osbFKki8cvz5Ih+SV/kv2Qv6CQZe1zLDyJ2z55506VmDlKwO57Cqs8679Pr+QpYKwTKl9DNSZxL
 DJS0MdZtGoYmJUHjYTCU6Givkah43DbNv0E6LJnscAoMHkaac4ae54NKasigzKATu7n0XGg8jbo
 sRwLrhms5SmluD7LL2F/5SfDice2ffEtuwliAuA2MAIIv5VSreSZzzNTCJJfC0Wi40F0q1klrSk
 Amorwe7CiVVHxIvIcGShDK1pt6kjOskQ==
X-Received: by 2002:a05:6808:f08:b0:4d6:90d3:e185 with SMTP id
 5614622812f47-5773e752f8cmr3953221b6e.46.1795028921722; 
 Wed, 18 Nov 2026 11:08:41 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-5777b39306asm2052999b6e.15.2026.11.18.11.08.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 11:08:41 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Kenichi Nagai <kenichi.nagai.ry@renesas.com>, 
 Takahiro Kuwano <takahiro.kuwano@infineon.com>, Vignesh R <vigneshr@ti.com>, 
 Vincent Jardin <vjardin@free.fr>, 
 Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>
In-Reply-To: <20261105140915.10682-1-marek.vasut+renesas@mailbox.org>
References: <20261105140915.10682-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH v2] mtd: spi-nor-ids: Add support for Winbond W77T51NW
Message-Id: <179502892056.3148473.14106657827588496212.b4-ty@b4>
Date: Wed, 18 Nov 2026 13:08:40 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0
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

On Thu, 05 Nov 2026 15:08:57 +0100, Marek Vasut wrote:

> Add IDs for Winbond W77T51NW, 512M-bit Secure Serial Flash Memory
> with Post-Quantum Cryptography, SPI, Quad, Octal and DTR .

Applied to u-boot/main, thanks!

[1/1] mtd: spi-nor-ids: Add support for Winbond W77T51NW
      commit: 90e85ea8516eececf9ea06e5ed161b0f1bc9a8e1
-- 
Tom


