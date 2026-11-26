Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98EDA606A327
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 14:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Qo45e3Db;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=TIEsTpel
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 609ED60A6E;
	Thu, 26 Nov 2026 14:44:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OvY0UOCoVsdD; Thu, 26 Nov 2026 14:44:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org BC38960A87
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795704254;
	b=bpskCcHlQYrvjqCTQv+VQPYIEBAuOnBR8zKB9g8rGx94B8LiM+5VUwWoFaUKMpqFAP/H
	 EQTOHnxYjmfIxfiIaJY9YwWYSKZYrV++SJx8PN91DG3A/5NtHJOXALYOFcyrFMXIoZmMV
	 qGF8MzXTTJGa9bV7KpPlOb+DcNDKVRyawH8NFrfSA1M+uQ3lNFPo02vwD1vAzQuXDPQDN
	 86rk9Y9Fhv0UCsbMREdcx+rY8PIwgxCsHoOmQ8nkOFWwPEIQRbImVErrBMt3ys87nkWvs
	 fCTD7pNl5TERO0GD5yFFtP5HyBCEMkvIULf+jhM1ZD6J8fFxtmJz1ey+daoA1PA7R7Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795704254;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
	 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ulkGEumg/TFczPEe4NoUkv4SpsIzLdeHGfb12k8SBBY=;
	b=IHgrJ7gmrN/8SES0y11UF9XL81T7ptiZr6zY9VP96PHbgisW8f3HqWu1SfcxDMnnpMyb
	 KPzVB7NpvBOcB+roZeNHoO2cE0VmDXoHoL6IsSZbk68cnoCtbY5WyyYedtQHLBrLkQn1k
	 wUjIkcfTQr320gP9ohE3aNu+jcEGKr9UHfaexr2i/K6Wh612BcU3B2XTHny62WB1rwIX0
	 zGurlJJQr7gk6vfGT9etITZwTKHiG6EDmPW9hBNfK6GMl28vfOa2b4uC9oddRqRbxekv8
	 GG8mr5wRVCvA+iViZBcWfA8d3DIRE6Z9rzbbkVcgt4UfvnHuCMadxVz/wYkv8pV6EwA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795704254;
	bh=ulkGEumg/TFczPEe4NoUkv4SpsIzLdeHGfb12k8SBBY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Qo45e3DbDuXc5nkMlEunvEdpZgM3o1pS+CfYRsSjkGHYcaWkY9OGMsA+oqzyWv1Ov
	 iSPTendWyB7BQZQ5GjzY0TBbWNlJKjrjSLdy+BujP6+TBVENIqGq17nPdy0jyPoW0D
	 SCPudfdzUdx0b0OQtxCCGLWxmqrnO2nSvQG74WvRVV0FJKIfTgEuTZgetmcxmp6Ifj
	 xSdfVhmBt1j35nYxFob1JkVbmaWho+PqS967pPYbs2nYw8doZk7Rd46xSNNCwq7EPs
	 1GZNAWoAanjRPryxmr4k6uJXHsoXp84uC1Bs1sxuboUdnCZplMQ2kO/iQ+6teMiZ9n
	 JsGBBhCeILdIQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BC38960A87;
	Thu, 26 Nov 2026 14:44:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 78DFC260
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 14:44:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6A97640503
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 14:44:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id s1_A8WwdQ_E0 for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 14:44:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org A72BE404A4
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::235"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::235; helo=mail-oi1-x235.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=TIEsTpel
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A72BE404A4
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 14:44:12 +0000 (UTC)
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-4b28d9537bcso4603394b6e.0
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 06:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1795704251; x=1796309051;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ulkGEumg/TFczPEe4NoUkv4SpsIzLdeHGfb12k8SBBY=;
 b=TIEsTpelLuDTcBfccbdPtXHDKdcoPE/HjcNXyGk+ORjvGcYG+CVxg4XgySpQAi1h8S
 c4JZa9+TreMrzJE+9S5VNZbRbsR/7D240arp3SIoH4AGooCJ142oDxQ4tEVH0x99BOhj
 c+m9OFE/DEf1BxrGl4wjnOj5Zm0cspM4aTVKI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795704251; x=1796309051;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ulkGEumg/TFczPEe4NoUkv4SpsIzLdeHGfb12k8SBBY=;
 b=lipXGQsIR4HCrVTWLxQJYxBpVuN0F4/0BtE/6Cfe5ua2L9HQb1++qpVtxUxq9kMxEq
 p0m8ontpT9Sxyk1cjuqXMgn1I8N77SctJIz1CodWbO4eWj79gPDHIl+RgyFdPCMWLIKN
 rtVlXXDwhk6frDrChdES4WwcQ4J+ODV79hCzCrm+c03ydcfO36NHOeE2L488X2rkna0l
 FIMhd5elBikgiBB3AwCqCwTfdQueQN2s0OfXCzavcOg6wq09AvywxNJ3So+8IbNbqGnk
 afjb/K4SET/1NS0Kew+WFTwJOLmxzamVdKEyqlditMNt1N1nFi7atzrvej9SdjVOWvPa
 UMzQ==
X-Forwarded-Encrypted: i=1;
 AL+hErHZReOnsFRF84ooE7qLXm25VyWXY7PNXkity9ojKeU5Uj4Hmi3oib8EOUpurjgXNu1wObhg4uk=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+ppPszikiyNpOnmrBxTh1QT7DkOytYe3FKG1U+Oy6BbUgGo0Mw
 8AFfaNCB0BUzdopLG3JdPG3gYO+sPsfsG8V0Jp+zbTc5+f64yG27xn8LeguWDq5G7Ls=
X-Gm-Gg: AZFdTZdvZFGe7YrjFOJR2rmFA0Wc2s7FTxNz9FkszJbU+UJBYLHtKV6W+iVRCRtYNx5
 zzTZyWyGrQVLr0/jZstFYOpx+t520u29GbDOFWVOWUAC/z3M0/dEi5AbOOZviYqItNE0F2oXHXQ
 O1HO6V5ORDYpJvGQWO+wTo2wfLm5cQ+s+LGhWl2ZWYhgykIRmsa6xLNUQ7XuxXSd/LvKlV0OnkO
 37bIfw/avwthNIP0j2F7sm/5TPYfdFmTDTfttvNxI0magDdkFJGD4eib6WlqdBy8KlxnYXa9xT7
 AEIVAWDgYXbU2DNbRRXwpz1LRt9g47wH33IrYRpfnuMvYI1MGWdy0IYnSro20JdhGEHOzM1ej78
 ekJD5q75Ny4e450UA8t2KZ8XNn3gsFecwX+yf727qpyqd6IBpKFnVtnFh9dRJfPPIntv32nd5Hy
 ydjJERl9JekC27PURutN9K5H9z69pFo25S3Lo4lbNdxzlYYyEHTia140C1hPhKRPaU87oW5XnX0
 AA6q4Z//XrsKA9CbbYoKCutN/awyOXmwn8ZGeRRbUe2K3dGBzi5GcvntEBE0qcK/5YULb/bZX5J
 DUW2gy02hQ9h+kno0pGBdFJgwaQ4S2nt4BOI7dLBjZfL9gZgim0zzvc8GY1KlclG9kG/6yCGDaS
 8oS9zBZNy8DeEb5c23MorImC1P/6DYr2qINkLpyVDoRgCyN/IJ3wfQOBOnS02IS3uUsPH0aJd41
 oczpcj7NbRGfK1tJMN4NpNN8ptJifDKQ==
X-Received: by 2002:a05:6808:5198:b0:4d6:9133:cfed with SMTP id
 5614622812f47-5797e69f666mr17213758b6e.50.1795704251284; 
 Thu, 26 Nov 2026 06:44:11 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4bc5ebdc0bbsm18198036fac.6.2026.11.26.06.44.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 06:44:10 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Ian Roberts <ian.roberts@timesys.com>, 
 Greg Malysa <malysagreg@gmail.com>, u-boot@lists.u-boot-project.org, 
 Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>
In-Reply-To: <20261113-ldr2-v1-0-dd7dbf436494@gmail.com>
References: <20261113-ldr2-v1-0-dd7dbf436494@gmail.com>
Subject: Re: [PATCH 0/3] LDR format: Kconfig: fix LDR_CPU and drop HAS_LDR
Message-Id: <179570425002.3223933.2002555926524272923.b4-ty@konsulko.com>
Date: Thu, 26 Nov 2026 08:44:10 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 13 Nov 2026 18:31:39 +0100, Massimo Pegorer wrote:

> LDR_CPU has a prompt but depends on HAS_LDR which is prompt-less and
> never set anywhere. Sounds weird. Instead, make LDR_CPU depend on
> ARCH_SC5XX which is the only architecture using LDR format, and drop
> HAS_LDR.
> 
> 

Applied to u-boot/next, thanks!

[1/3] Kconfig: Make LDR_CPU config option depend on ARCH_SC5XX
      commit: 7f41e94a422a33db6ac40aa290dbe52464e962d0
[2/3] Kconfig: Improve LDR_CPU prompt and help text
      commit: 030d2c23877e6d2111678182dd1847a6e180b8d2
[3/3] Kconfig: Drop HAS_LDR configuration option
      commit: 50b61c50afc10e35a04ff4f72f5bf6f7cbbff511
-- 
Tom


