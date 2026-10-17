Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F769CCF2C1
	for <u-boot@archiver.kernel.org>; Sat, 17 Oct 2026 11:55:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0E96881400;
	Sat, 17 Oct 2026 11:55:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xnzWTwzgu588; Sat, 17 Oct 2026 11:55:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3EF1F813F9
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792238121;
	b=BzKCnF2uux3N6k6JNWprpxdf5e0E21ZRy/IYl2HElHqmIOfH8rWFFF5F15pKAzw5YgzJ
	 TgIXsXjQ7/upQc6GEiDRQkv9F5e1uVS49ZDT/O2jjH2+D3a8G3ZDZoFBC8cevEZo/0UBI
	 aXF58T1EfKZ2aGGdkhoUJJpIi7gbei2tqdFlvwUFAciON/zZZ8kzruQFL0HlqQn5UqY4H
	 Kk2eVp/jDtzUA+TZojSobUJar1EIYkcIZb6fAmZcj9LjvTRTPc35IvGPKe1ynqN11zWyL
	 EcfAN00IdvqPAi9wLPn7gOKbVN+9ZWiIgQ8sLFlmDtGGOi3/nfgkEnwvuJuhlonNmRg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792238121;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=gL5rYqu7cPD1nQWre0lRE8G4PgJH2F4IkE1376Itw4s=;
	b=QaZTa2v32hT4mAArirgipaMSP4VN/UDFjn4vAYTOARq00UQS5ZwlBfuBPA8CdzkR/lUQ
	 DKUri7AfqbR0Zl3RtUR9HBuiFqmiWSyLm3mNsvKfSh3ZFwOea+Mi0xXY/sVNTcLtm9HmM
	 7RixcfGxhuh30/p8ExV9cmZpTIs87pwBZOi+gbGabeOWVPIi9HuJ2imBaEr+0jMiJekEN
	 eWzpWjz3vhsF8WkRDQrnzDvcNX9IqeFsUtYm7cmfWRw8fulKmqk6mctYWQmkF6h8fFsMB
	 HArkDiMgE4P5Jg5EYCUdUZQTTZ88vn4y79JYXBf3Fc9Yqg7ny9pgr6Q5NSxlTIIi7qQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HJbduTO7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792238121;
	bh=gL5rYqu7cPD1nQWre0lRE8G4PgJH2F4IkE1376Itw4s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nh4QkGbB5LSskNzCy/cATxlEriUVCT4NkjHrrM9FeolfR2Ux0phUUeMFKS8xxlovX
	 I/7boL5NY6qwb5rgLjMEUh/iASWe+x+boe9nHVtRx6qzCGenTkoWx1MTSXX2oNMhaA
	 ToHCYetdCocgHn40RNu67AR0EmzJkEPhNXmPIp3iR9kY9RYD5ke42BXTV4k163chWt
	 aZFT4mJ9BxT2H6OhagLbY40L6yeamxsoXjCggqPjqtY8y7AOePG8wBaAZ5zmIQqgFf
	 MpTF1z1gzC2wF5sHg1QD7bI1Lf5BwcRoWzF9LAPWD7ygpgdEGTnpV2cYDTkxvmEwWL
	 IOGhuBIlsRXWg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3EF1F813F9;
	Sat, 17 Oct 2026 11:55:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 192EE61
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 11:55:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0B0D5813F9
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 11:55:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RFDSK1Xx16hD for <u-boot@lists.u-boot-project.org>;
 Sat, 17 Oct 2026 11:55:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5D8BA813F1
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1229"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792238119;
 b=CZ8HaCJGWVJkiWaS3+6Wuoxp1Xyfix35r4Ht6UjmHqWDduaqjSn6/baUP2Fe0NQQS792
 xwS28RNbgHOKC9ZE5C3OFBzD+c20zIVIZUn6+wJ3kpXhOWgScfn4T663F7Ad1jYcIZFRP
 7JgHUgDytHveDnvsNjKrMSYEWEjY3pN4pWjrWhBHaX7JwGLtPVvrDStMfBVfruNKNldcB
 SYfi7hf0TjLOdoKD4BCBYelydU9ktEKKB7Hh5UCzS5IETPVSEofk6iw3CT5W1soVnbBfN
 B3UPtQdNkapa+qQH1YzJ9ZLBQ7Xv57WMyNMKzABvtFD6ULY4qx6PSHD/lRP4OPoJclA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792238119;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=gL5rYqu7cPD1nQWre0lRE8G4PgJH2F4IkE1376Itw4s=;
 b=EdN610QcqB3B/CGiP7wKtR5663RqEC0UZSQ9qYdbQx2pygvqv3RlAmBpTQfMpP+gwAGg
 TJATDbgEHnKEQea9rl7LsG4kGUlrXTSu+qKlsV4oeVrhBSvRJf6BurguiqWuacYeW3fIm
 5LdsV1vR8ZGZTwVHyIPGitfsy5Pc1FtI+Vw6rsR8chM1pyV+rqtEe0vz6JjJ2omsWwsgY
 f2Qg0qDjhwtC7Dw+yYj8qNbqzmEfh5cPAbl2SVb5iBQ3F+yuhTY06mB9E6ffNx0acfEho
 1FZBlDgLnbDJWRuT93e2NDL6xmpwNVlEvDKXk+0UsiW/cXOceTphNLd0qFFPZZpshnw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=HJbduTO7; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1229"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1229; helo=mail-dl1-x1229.google.com;
 envelope-from=alan.tseng.cs@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=HJbduTO7
Received: from mail-dl1-x1229.google.com (mail-dl1-x1229.google.com
 [IPv6:2607:f8b0:4864:20::1229])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5D8BA813F1
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 11:55:19 +0000 (UTC)
Received: by mail-dl1-x1229.google.com with SMTP id
 a92af1059eb24-15756f82e8aso1226346c88.1
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 04:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792238118; x=1792842918;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gL5rYqu7cPD1nQWre0lRE8G4PgJH2F4IkE1376Itw4s=;
 b=HJbduTO7CZk1fWm73w8ZGKL5wisYJEX5HUgd2ttZ09Aem9oA1Vt+995cbWyXY1N8+2
 jIXqDMPx1YIeJg0rEXWyRcBCgnnH32n1KB4NyeRzYJlAfIPsxfCTFI63i7E80VeVl+GK
 LNd7U5B0ProxHUAKUtZu5XyxZrJ4tTgyaORScy4hRlQCzqjnPdqhO7m7+KCYbQYshNFp
 jMUVZykRiD/VmbuBSkQhLpseEobToUDYornKr/4cfvE2WNjF1RYZMe9zM9a5epY1KiX/
 YPAxoBRtT6ar2en3jhqjGRJ9eRkXApcZccI7siyRyQQdOmvO5QxQHMOgnba4Gty2QeEE
 mpJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792238118; x=1792842918;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=gL5rYqu7cPD1nQWre0lRE8G4PgJH2F4IkE1376Itw4s=;
 b=u1eWtMfYf2KBO5fxsIO/5pMgPiGp7vof9RHwsTMZuswkIx8FSH2kuyrkVNUIj7zKN9
 QBaqlM8L8XHbeNXVLSM87Zz/cn4Ig6gDsk8dbjS28n1crU+zgmpS+BrQc9Zar3IqgUww
 loJaDIx/cY6Fat9cgJYF/qgPe8XMDcRWd6oJSpZdJk+uonvyZawlDuRL++LTT0rHCnas
 Rqt9TiavNmvKADUkfYt1vQ5zSctsfRKMbWCq298PRXO45OTK0d8tFKP4XnOJxezGlald
 YXtQvxmY2GesSyCdtfBo6AP5JtQV9Yphg0tuY5MmwJfNE7GwNlS9P811leyqNm8Pt6jo
 dQbg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzxm1Zs/fd6ZYA0xTGiDqVdM0WR8y2ccaeaT7zZ5zu53eCjO5u66TUIU5syer680UDReGZU87w=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIi0T2f+kFRpnyHOLZFIzu6BB53CSrzdTE9p+TNOVhEJgvufLU7
 Aqr8ixeyeugaKn1uUr/PfNDtdInfmmyK/Iif3PBcEmhzLt5cwxyOpfLp
X-Gm-Gg: AYBFou0Rh4n6IkVWW8CubnqzjruNQwgAwgwUu5FzlAiEUcstfAJkWkIHTKSsxbncfli
 CpiZHUGrAPwkgi9uywRsoQC+/J1imH9YAey9Vpb6auvW9saq7TlRad9l6bLqAceowcd8Xdku4nv
 ZS/FVXUz4KrfBpw3t9Hy1KjVk0O69pZX3Pzn5TYr6nBaEsy+/tc4uR+eUNZnD6rAtsWexc0KAj9
 pXQoC7TVTlaJMr9/h0l/ZnlVrGBjrMTaNnsqtfXaIdhIPlxCehZpLBbh5tbN9mG1z6eIMtdohAu
 5pSNy8kJFK7D1IlHC1s0C0ZQ9jrf6bqbY/TKuAFhm19XY45z5FbMkN28Cs5i6F5w0fIGWLsDD5k
 2w1O3l6QUmEYCK2ULOAvp7Otgy8/X2F2pE8iuulhUAP/juUfwfywxhTnzFPcFC+MT8xRNJ3WP8i
 kUXP+UccwJZUrSE7Kk35i7+lVhtKwgEljuxH0IvClAB317DxwfDPrLjtF2C5iTIvPbkEZ7QXB9g
 S2o76aSLCzsoFV3I7kIztZGXwkDHn7r+9oo+cCk0kcAnv3RdjtWP+1ZUqNJLp2jqI//UQ4Fpk63
 q0uyoXdnZD2Y9eVm+iKqIzs5E5U5uNJzybZCy/xrqibVmZK60ZGy6w==
X-Received: by 2002:a05:7022:438d:b0:143:1bb1:3305 with SMTP id
 a92af1059eb24-1825b20a2ddmr10041583c88.22.1792238118101; 
 Sat, 17 Oct 2026 04:55:18 -0700 (PDT)
Received: from alanhc-14700.tailb22ec2.ts.net
 (180-177-138-120.dynamic.kbronet.com.tw. [180.177.138.120])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1831b75be5esm18437239c88.16.2026.10.17.04.55.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2026 04:55:17 -0700 (PDT)
From: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Stefan Roese <stefan.roese@mailbox.org>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Bin Meng <bmeng.cn@gmail.com>,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v3 1/3] watchdog: Add support for i6300esb
Date: Sat, 17 Oct 2026 19:55:14 +0800
Message-ID: <20261017115514.2756324-1-alan.tseng.cs@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <55d5bbcd1c96c861ef3ef86f39312b48e56ce5a1.1792074141.git.jan.kiszka@siemens.com>
References: <cover.1792074141.git.jan.kiszka@siemens.com>
 <55d5bbcd1c96c861ef3ef86f39312b48e56ce5a1.1792074141.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hi Jan,

Two minor things, neither of which needs to block this.

On Thu, Oct 15, 2026 at 04:22:19PM +0200, Jan Kiszka wrote:
> +	val = ms * 1000000ULL / 983040;

On rv32 this is a 64-bit division, so i6300esb-wdt.o ends up with an
undefined __udivdi3 (seen with qemu-riscv32_smode_defconfig plus
WDT_I6300ESB). lldiv() from <div64.h> avoids depending on libgcc for
it (checked that the object then has no __udivdi3 reference):

	val = lldiv(ms * 1000000ULL, 983040);

> +	if (wdt->base == NULL)
> +		return -EINVAL;

checkpatch suggests "if (!wdt->base)" here.

Otherwise this works fine on qemu-riscv64, see my reply to 3/3:

Tested-by: Hung-Chun Tseng <alan.tseng.cs@gmail.com> # qemu-riscv64 S-mode

Thanks,
Hung-Chun
