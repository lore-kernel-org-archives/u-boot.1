Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADC1606A31C
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 17:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ck7KVe+x;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=shaGJ04u
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C2E7F80EF4;
	Mon, 16 Nov 2026 17:22:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0isF7PpubxIf; Mon, 16 Nov 2026 17:22:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org F172D80F40
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794849740;
	b=c45EjoGhaBnPVj7ueWapppTVqryQ2O3flzcBtVi8pTC0dPf3ClDq9DJ1/m0+LOndXhNm
	 NzEai4cJyrylUHApRfFutSaMjIxlceSWLrM5zBxks2FVSS+v3ALXx2KPuwuXneyi1TV9R
	 2tdwMEWCDn+XW1oFevqb2Bmw9GLiFW88lzWKbTQqckxaye4FErFXah0YWkQYPsrZMQHzK
	 ld/xSNk49twm4UQKaj2AYknqR/EQ+XGwzJswXpMI3nP4zN/nuCSHOQjujVYQIzbtClIcf
	 jqgTndPXYDwcziSu3VxZFDKbdMBwVq3kTkn+Sxhxpe1WGYDYZkFQIDOA7i6buoccB+g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794849740;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=jeCaieS8abGn7BkdWMHLjBZIjFY4KccPx2sJUlHQ/k4=;
	b=i+Lfa/Z7MamnJuEwviGWZy5LgCyAJdPy/09UXVpmYB/tAGJWe3P34MUyyxY7zGENKk72
	 RvaQ9HAmPvXjsN7zOpl+LIIzQ828Pl7e+JCQA7tBNjg7PiwBjAdPpDV5mZIjiEr3SKpN4
	 CGSJ7pKDaaV3+4EZiflzPytBPPdhVqlF+T/s5OWMcbJkzgHL9cY1zIfqqSSsHHhAyVcUH
	 aoYChO1WkxvajddTZfxjYrgkW/nfa05s+YaeFkDpfuJlG7hywgGJk0t+89zP/OuVuYBGQ
	 QTvEvSIl/Y0A33Q/BzS0696MA1JMBYrrfxF67kGWEPUnI33gN8Kw25rOPfA1sXYgJZw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794849740;
	bh=jeCaieS8abGn7BkdWMHLjBZIjFY4KccPx2sJUlHQ/k4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ck7KVe+xEjjGuMoIahUkqEgSo6Z8pgfpY9jHnaFe63uzT/ulrmIa7e4Pbq8AhK/i9
	 vtsIUOjSvvak8cm6ZnBC9QOfaHuhCgT/N5v2tI1rqAfC9qAw2d8QGlOCxzLddsd5ce
	 wW1NdwBLmgEfClqW/L4u5N2QCxuUO6WAxNAv5SLD3AoJXIXHMPPRONAwX21sndqYo7
	 Y0cScaESpTWwAGQ2hZ8y+6GrzIOV/Iy8U2sQWbg/JQx+Y/n4knQMYGOwUPBerorBR2
	 FhG87+ZwVjDJ6j1uvChT9QsM/tekR+++uzV5uLrW8bnyZQZLqlkPVO0D2EfUjSczYB
	 vgZmjQdE3vQZg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id F172D80F40;
	Mon, 16 Nov 2026 17:22:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 80A2B169
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:22:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3D3A240753
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:22:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NzfcCHrYvbIk for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 17:22:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 404CB40737
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::333"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::333; helo=mail-ot1-x333.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=shaGJ04u
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 404CB40737
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:22:13 +0000 (UTC)
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-862d919fb1cso302481a34.0
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 09:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1794849733; x=1795454533;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jeCaieS8abGn7BkdWMHLjBZIjFY4KccPx2sJUlHQ/k4=;
 b=shaGJ04uqJkaDHXAwqSqummp+XCvPb4yHz4IGlU5Sj2AHZy4p3BZFkro4V7dzyHR7d
 UFIR5fTU9frxJzaxX9OXtAEaRFDuRFmZAJF7/BAGObJOYusgg+DU1QMQKl/bnYFQgMja
 48K9KVsAeE78ao2ubx3NzyY+nt5qIkCEEiWG4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794849733; x=1795454533;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jeCaieS8abGn7BkdWMHLjBZIjFY4KccPx2sJUlHQ/k4=;
 b=qqCH8S47357a2xV4WRbzJuVX7FcS2O8ui+D4sJL3upa4EcNjbnjyrJFsRbP5eGOOUV
 YX60T6Kh3ErwrsSNNZ3kArx1++tQ1/IpWQMOEj7PsISN/wJbW6isgMG4eVS+cZ/gGy3f
 D/+b09S/Fv+USyPOvaY1VYsGnJ++8NXFDnvRpCWJtspZPH1Pva5FQCLIGhrBSTwr4MWm
 xUOIb9Mz5SA+nKdJOK9HDR/cxSxghgQBcAfzp5KaomMWz9XjBDfeu+ZkIqezHGVyC/+w
 IO5ztlIbAiXRBhfDGF6XFKQ+Cfli7nCec7nV4mRn5oLPxhglMNrTIlNptUJNuSg+D3ns
 iUAw==
X-Gm-Message-State: APuU4Z8hVh21nxQm5uvZksoGecIERKXdTArDUVkNiPQcieBIuIH61+b8
 8aecYxRndN/G2VTJH9+Ss+8J4FqwAvAdBvrrITSazhwAVUA2BXA1Bzc22pNfqGSeWZQ=
X-Gm-Gg: AYBFou0/JgeHINP2YN78LjMSm7ofmA6t7He8BVbjHV/AJ5NxL3uKa8aWh5UwSwDpCrh
 B/JUdTuYzGwMcOjtXRWzBNjj5mg5mm1Sg5wiUF6dbl1wjF4+qcmtG3zk7R2cL5IqJTcvWO3xe4+
 UpuNENfmGPqfpvJ/UXnNtxb7yyDKUMEG/mrOPeJdsJ1wY+Wz0WPKPt3PRfKmPkpHmE/rgb9LLkh
 BmkMi+RXUIeJSytxAgu1gxy/sDK2/OMjoGGMrjuwjNLGIMzo4blyLFpQqrXtOyp7uhM0UgRImK1
 8PzUmZh5TvZpap9d/hS1Golmc0QbX6A78qRKXUdKF+Bae0r8EI+BEWbFgmSyHs3fB768JmIoLXC
 rHL0QTYofFYnnkCb4bg0BiXATNvLgK8u7OTIHtY8vbD8AnZrn+1FB269F+biQbnvmO3I/NsU+1R
 ilhWeuuzzhmBhaWBxjuLoY0b3alpsglkbxQRMb+eZvdPgn5zFs0WPuUkbmSWlZiaWtCZneleruf
 Um1Xpp0UR263TEKBW+c2Gy1HMMAhPqIMmUaSHjPvtkBBOxyP+qhqxjqndYZka9s1Zum3vI75qJE
 sziY+3Q0Vz+/Xbnmc+N3npb2UsNMrnCeJvqTYq9AQ8OkAq91PZAUa/kruKJEAcZ7uck9FnClfd9
 Ziv7dF4cHdIwyquHeM/necxKuLH3sJJDWl2o072LXBKrN39WGoJRCW9X4PyWBA3jr0+h6QSyPBQ
 go3YC5vc+Mzb4eeTsLk/CNPK0MTCjTzw==
X-Received: by 2002:a05:6830:4c08:b0:862:af57:78d with SMTP id
 46e09a7af769-862af5749aamr7060187a34.15.1794849733036; 
 Mon, 16 Nov 2026 09:22:13 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-862a82c4625sm7191658a34.22.2026.11.16.09.22.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 09:22:11 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: Mehmet Fide <mehmet.fide@screeningeagle.com>, 
 khaliforce <kforce@gmail.com>
In-Reply-To: <20261116032257.3144430-1-marek.vasut+usb@mailbox.org>
References: <20261116032257.3144430-1-marek.vasut+usb@mailbox.org>
Subject: Re: [PULL] u-boot-usb/main
Message-Id: <179484973113.2141271.9489976752593484325.b4-ty@konsulko.com>
Date: Mon, 16 Nov 2026 11:22:11 -0600
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 16 Nov 2026 04:22:25 +0100, Marek Vasut wrote:

> The following changes since commit 6487c50b8a40f2668ab98a892b9300ad5c181f38:
> 
>   .gitlab-ci.yml: remove Simon's lab from CI (2026-11-13 09:09:28 -0600)
> 
> are available in the Git repository at:
> 
>   https://git.u-boot-project.org/u-boot/custodians/u-boot-usb.git main
> 
> [...]

Merged into u-boot/main, thanks!

-- 
Tom


