Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A75606A31B
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 11:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=vzqokoGe;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=IfQ2EpxQ
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 93D01811DC;
	Fri, 23 Oct 2026 11:32:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id i9Iwhhqx-4kp; Fri, 23 Oct 2026 11:32:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E774680FFD
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792755132;
	b=UMWvsxneX+Q76dlGPw2b9nDqV078FlqvfuDXu8MFCj4KinFlWj8f0Q2o3q5F00aPra07
	 Rrfw4Oh7IV2ns9N5/r+BDoQUiNOLO/MImsCyfrvCPZhvwDXD3bAjpXjYcaj+6ZHjCCJ9W
	 XtiGJEp/BrBYyiAxeHYwJoQEOfdZuuoc3p2mbkPVO7qUP44sOMD68QFCptZKqVUx1mbAU
	 GaKsbEnXisJnsaO8EmlB6clIsB15Iywg8PiMu696kTjxVgU0oox6J/Z9drJGqnzTjCeBe
	 2ublcVKnSYN4ODePL16Zqq/43IscTO2SYnNIXoM6J/Wsc3uJzMin1U8NUlsOs+jkbkw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792755132;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=OR7ROjQjwg4S2EW3NLhrG0ZvpokQ+ftdlBeydwNaOAw=;
	b=KFI8b/dSGbxsO4sUs6J+yLsHHmSfg0GbysYQJ/IMPUPb1YP+Q8XMkeeRCoCFDtk+AcMm
	 A+DpWs+suHwCpPpIpyc75uzUage2kBbAE4iCzQTUzwaHB9Qy02VgLqshAMMRaV7bJPQT2
	 4fk0htr0J13yfF3NJM3nBBfRL+GA68ChhWnTqfD4K54rXNjXc2F93nsNldOkMCIvHhqC+
	 FjfmBDb0MQ+a8bx1oN8DHYj5zGArKKun0zrx9lBFbfevDzFonoG8uCrEm7Mq0PnbvqN+1
	 MIDt0nGXSPgLbOpC0T1ojO27feHKxKFx9TyYpx99XXCjMypIpjM6Ms1EhGkWtKuugPQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=IfQ2EpxQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792755132;
	bh=OR7ROjQjwg4S2EW3NLhrG0ZvpokQ+ftdlBeydwNaOAw=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vzqokoGeTTqZ2grZNzpiMYxOY5dCIz7hK19ygzjdbWUL8jqFrd3SbbWt2rlCD1vvw
	 KuE+M09Z5cNNsanzbvveAKx3QJn2pgWsI76X0+9lCuZAVbNsU/tpjXtTgxqmZDEUOd
	 NTcmsVM9c4fndtQU+e1mX0MTeEhbI0PFsbLyzH5r25f+thga0/sVlydaQTaS4NV7Q+
	 umi05AWxIDEfJCdDgnq8rMy1c9mazH+SAy5MoCBANG/m9uWWSMLHLh8NJfG88//k+L
	 eTZ8kHQWGRzPrjMzPxwPE39A+a9qfx0Lme/inbkI8Mg8PkwzWL915SnmoN1m5/NVJR
	 FpOG0oydPKbPQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E774680FFD;
	Fri, 23 Oct 2026 11:32:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1468A380
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 11:32:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EE8ED80FFD
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 11:32:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jrnQhgmAmJHh for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 11:32:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 820F480FA3
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792755130;
 b=bEBqZ/wqBFIvi7Q9GVJttnXS9xWs2ZJKZu0QrjDQdKtd6IwjJVYiqx9ih6X/lwDbMkuo
 hShOsqBxOuJVTsgV+iUo/6opPZvWPiyMmy5YWE2yxy87GbpqhkRtLavY9onkSgnY5k3aL
 rdngOqVYJ70RnJk8fh9FSHXxYKnRMaVIOmiu3aGvjnLKdYia3mdrI2jGqxLF5EVzPmc0f
 auoUoC033SB1B6IezwLM4nGmSDyC3SAnchneZNWEXK542+pwaTExM1iQ46ev4fhL/eTnS
 41o9XQndt7LO+eFZnK7Hd9CZq7TDSMR/W3dVwbPKxsrxX75sYvGhOEiVu8gO5C8G4zw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792755130;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=OR7ROjQjwg4S2EW3NLhrG0ZvpokQ+ftdlBeydwNaOAw=;
 b=k0SYdfE4Vdv8cwQGVOyTm6fayCP2mj6RQYwSidfda1A4HjqrLOcZujweHmyb5u8WHGkZ
 O457Lk6cQhN9JR+cKcnb4uHEUVx0uvQz8vrCREQX4CccrO7nXhrasI02ZGog1pptl8Q0h
 /mRZ7wKB2ySyAofDa9UiicM29qa0tfzcpgmV/vtD1zTCC5iWOvL/O2+zLWnkIjRK5lepu
 oTQ0vitzHXphHLWI7orOsFDKsGC+GvG1a6RYXOnuHzHijw1YCf/I2jeyE2wWZ8PgB8Cir
 P4H/NI8CQhdlVJWOhlZPxmCdHUUX/F90Qy/BR+/i27WBYvo2k0/GuwfsNoHpFS+5MaA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=IfQ2EpxQ; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::42b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42b; helo=mail-wr1-x42b.google.com;
 envelope-from=glaroque@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=IfQ2EpxQ
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 820F480FA3
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 11:32:08 +0000 (UTC)
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-48e20ed3b9dso639711f8f.2
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 04:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1792755127; x=1793359927;
 darn=lists.u-boot-project.org; 
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=OR7ROjQjwg4S2EW3NLhrG0ZvpokQ+ftdlBeydwNaOAw=;
 b=IfQ2EpxQ4ePchuAx0zRZ4T4UCG+c4oqYNe8XGYvuC7Q0mgpX5xN8gAyon6sjy0KOBV
 f8Evjbe8bAAqcoDan+UWmLXQZWm35cHCjlSJStf1obPloqhURQHHvXsSuAqEtIxjbyxX
 7EcsWuoj/1FPrGY/bKYeui9fBHhPqeD30JC45s3rYjkaKmaeJpKx7ajsTdN4kImW543R
 5b1HfO+VSWFa3SRs1FXeRI78M6rI4ySGRR/3sA75zZSoGXa8naENyqKzqLUqjmbixEoH
 qSp3vUxlQjfeKmVFrJibTP0edC5dKcDiyJB9qpZDyWZB6cSHdY8XOqVOlPVoh/FstBIq
 FH3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792755127; x=1793359927;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OR7ROjQjwg4S2EW3NLhrG0ZvpokQ+ftdlBeydwNaOAw=;
 b=tVgNt8rAAR8T+ize8GFp5qOyGImx7znbGTLPsbMo6qBo2TbiuKC8nbXEvp3vSRRW87
 W3V8C7S48fuBvdtv4dtjTQGNXavqgYpIlP/CYVE9RXkZcTQH+URu1ZqQgYmgxXr+8QfF
 TmRjN185l/2HZWA5+QFMMcqPPDH7XY3FXO3TpRC9e0mRiTNEhKB/eRwFlM7t1LDz66fF
 TrzwWZQAdHjG08Ui/a04fltM4r4ca54YCuUFiT1/1ZeFTMj9XUCgN/evRHb2Qz2xhzRF
 DncGOuxLKTPRZpt8Y9/AcWFUcq5Y8P9vDg+cvCAOmoEbfg3oe4DK7U+3Xlf+JlJkM1u5
 vQ5w==
X-Forwarded-Encrypted: i=1;
 AKwUvBx2OclUTwgyHuNmdAdXn2ZS7gx3uMZQngxafa0gyQ/Sc/YoXEMiOjtz3n2CCftj1j3/pp53DzU=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJDiv521YuNXPia/oposmfKke6z5YzlUDdqkiFbHb/3MUu2S4or
 rQVEQavqd+miSm8eXloiuuDwDNt++ifl5R68NBjy7YT6H7P6GI3S320BVS9CrsHW8RFJESigQUO
 X7m8g
X-Gm-Gg: AYBFou3UF7chHQLo5P4fWrfx2Py/7PhG3/AqyuXu7zdW0szRWWCdxBT+rbrSYKcN3Y1
 o/LkuAGhCgNnHe6Ar1gRWEZsuO00JasYDKgr0CmywohG19DWMv5CW3dbSasrvGxLOK7/b3tJFvK
 dijqQDlXKefuBEZsExP444XT8lePc8yh3VSZTeWZ1y8FspJjl7qpClZ02a4WvN2vvZj0ajAnfLo
 lXgJBe8/UIVry/h4tftbDDXnYQs/Ah82w0eqC++035Pl2BLBw72eFv2xpTEE1Iv6shDhUCs2wyH
 +G5i80Vo3ST0uMUp0ryKbEuBzEqCi+KWG7dk7zbWJIzvIaGiAOK0+I8BwSkm/pwf8En4dR2H7fa
 KEHA7mwkEHJ0Y4/5vhuqVt9QOMtNmuhcwTsY7OFaqFYlS30bHag8kAbNKV3i3vzia1MwM47gE+Z
 T/1Ktd6WfEEYRGN+rSH4atrtKfGfZa/B8neBAkDx20JCCRhpGbs8A/Q4D/imbXpH3dRV8w3KIIh
 JPu1jDEqHkCSo49NogyQtpNnjZyDPTrQoDSkW9bMUGZjM/P3hlNpV3cziCjBx80Fb9O0iQsl+Mn
 yQ==
X-Received: by 2002:a05:6000:1623:b0:48e:412:3813 with SMTP id
 ffacd0b85a97d-48e3859f6cbmr1871448f8f.20.1792755126885; 
 Fri, 23 Oct 2026 04:32:06 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:e0a:e50:3860::e1d1:d182])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3805d708sm4733201f8f.50.2026.10.23.04.32.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 04:32:06 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] net: fastboot_tcp: implement the download data phase
From: Guillaume La Roque <glaroque@baylibre.com>
To: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Dmitrii Merkurev <dimorinny@google.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
In-Reply-To: <20261022-upstream-fastboot_tcp_b4-v1-1-466a9f181ac1@oss.qualcomm.com>
References: <20261022-upstream-fastboot_tcp_b4-v1-1-466a9f181ac1@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 13:32:03 +0200
Message-Id: <179275512301.1510420.5223585191999112458.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792755126; l=982;
 i=glaroque@baylibre.com; s=20261019; h=from:subject:message-id;
 bh=e+4nTEyWwrawk+pK25NdJxZruKDcZlqGfrYqz3epDNs=;
 b=87K90LhnsRtHLBTGTaM8tuVyyjfbELzNncpJ/IqItiSfZnxn7SB1CDX7u+zv/hig1Ja4DTKM7
 oicOE18BkvwDzAok8/N6mO+LyHkRadlgOqKW4LLRDKXk5SjlHjHsjfS
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 22 Oct 2026 14:17:00 +0200, Igor Opaniuk <igor.opaniuk@oss.qualcomm.com> wrote:

Hi Igor,

Thanks for your multiple fix in fastboot.

>
> diff --git a/net/fastboot_tcp.c b/net/fastboot_tcp.c
> index 3ea25c997fcc..ed32e5311b45 100644
> --- a/net/fastboot_tcp.c
> +++ b/net/fastboot_tcp.c
> @@ -16,17 +17,95 @@ static const uchar *handshake = "FB01";
> [ ... skip 37 lines ... ]
> + */
> +static int dl_consume(const char *buf, int len)
> +{
> +	int left = len;
> +
> +	while (left && fastboot_data_remaining()) {

varaible use in fastboot_data_remaining was properly reset after a succefull 
download(fastboot_data_complete) but if download stop in middle or error 
i don't see any reset, do you test this scenario ? 
initiate download , stop it from host or unplug cable , relaunch a
download, if i understand properly while loop still use in
fastboot_data_remaining value from previous download.

-- 
Guillaume La Roque <glaroque@baylibre.com>
