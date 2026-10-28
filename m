Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75CA606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 10:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=dI8vI0xW;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=oQ+16+1C
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1D14180E4C;
	Wed, 28 Oct 2026 10:57:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XbYuU-ZCPPjj; Wed, 28 Oct 2026 10:57:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4F5B680F5C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793185077;
	b=NN0qFZdVs0dVaQOYHxBfUjRiYeEn7IYAGB/oHpTx1YyFJLYhppkwyz6HhTDyGtX43lYa
	 CnCrRE1icT4TOzeoGZbZOyL0RDNVcRUbKaQaPOl5Hp2dUF7N2zv5Tg5r6/Gvp+2qZpQLJ
	 iGC08YX+QwL57yt+W+ScD8ylq3Gb6OHIhdxeiTpGZ1zYmFBrUXRRE0YDtb4L3nm3cpZcB
	 uLHsZOk7KufimY7AN3qvc2R2oab7Y+X7blTYSb6ssmOewsSpCw/kNTqumpuW+olck4vOz
	 v6hj4aidB3A3+//P3X9BZuGCUqoqFepLRNKCS80KkiXG2W7X0sNpE/T+DjwJf276H1w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793185077;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=48VZ5DUmB0THmw7ClPa411/wBheJn1FjNjvnIPDYPcI=;
	b=gSfqqyDSGT6MIIjYD9Mphq0NfvJh6fkVs2fzD3WDzFihKt3O0gwOhg7isq38HfXDuYeo
	 x1i30PoKj+1PSIdQlA+GFvWdmI++iLaJXYoEYEwovh1eY46vta+KHUC/60HI6YVb6KNtI
	 kqh5ttVjG8n+Ru4b0/iurzvYg9Nm2at3kDWOqabh7OEs+yknrQCSj4TnlXTZmmTS9/Sqq
	 Gmi+yddXAhFGRiTeICk73ZYcQQTWJbeaQzzTWDOnt9+Q9wm7B6+ij4cxX8GkDsRxLfWs8
	 6gyISocfeDN5GmUwdDFfdVvCQCYDZKFioRDMZj94fnlZXtfBEVoH1xbrj+5+PO/A7LQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793185077;
	bh=48VZ5DUmB0THmw7ClPa411/wBheJn1FjNjvnIPDYPcI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dI8vI0xWppxDI/j1OxGv1/liborQceqmcZVYlG2nz6HwbCRcKb7IjIwZTzgA5J1MW
	 m91AOZAACAlF/zL+ifHHrrzfGY/2RXM1AJhJOudqLDTU9SQ3qFrO0F6JyctgROT2Ky
	 Uj1H3dBSbYnVzwG8RwpM0aLTP7/6qx97zJyvCNA73h0TF3pkfuPomeGU//Kg+hLfcD
	 Ac4FjYjklrhU6IDf9gu5hOmsBGiurCHuu3/xOR24BMCiNtBFqM/0BBcO6Uyj88/RFj
	 9lBBriZbbVOSSWSVGLoXH+o1uN5uGi1DnACYpFth7ToUFYhZX+fvzScs1jcBZx9j6R
	 fUVAtibX2zoCA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4F5B680F5C;
	Wed, 28 Oct 2026 10:57:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 6DFB4D1
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 10:57:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6B868605EA
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 10:57:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZBUj29rdWj-Q for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 10:57:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 67529605DF
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::333"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793185073;
 b=LMX72lbdFR90MqQxxqqBPgtVA7lRD0ZXvnwSGv5rPGaZ5hkzaAPHTwh91PokW4BAyiaN
 xXXZ+qZoqKU3f3oPBoXXr/oZ7NRwBc2ziH96On4W4XlSPlzQzs0fbMqeRAtm9xJQSyvhs
 XEtZkzUOtC/CX1lhFkcbVaULLuVcSiVGMcCGuNzCFMoWqyne7Q9LMgjDaYXtFHaZZuOXJ
 QcE9zzNXpgDH0Ls91Ub1hvNUZ6X1W1Ihr7s47RrZV3zZJRzV57ErMWrBqxz75GoeGY0BK
 jiatkWvxsq1IgXQPSWBappxav9U/TwzCn6slxVXsstVh+q7eWBuxbjsSG7p0ws3xQyA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793185073;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=48VZ5DUmB0THmw7ClPa411/wBheJn1FjNjvnIPDYPcI=;
 b=NR2vJ0hsqseYrimfZtYfnnVmFoSk250ODgPYcmyO6E+5EmJ40ufk4VUhs+9lm4pkW0FU
 JYFVknb73vpJUkFN3MzGfVNRgCsDNbGikO94ywcKkWgnO25jswyaH0whbo4Dg4eaZqaGp
 ec8utB1gsI6DHdbkRX/ftwiBZVX+mVIQgPEjryhhiPp9uGfrRWj7l6PIAaaJ5eaBG7XQI
 yMC9BXcDeDE0H8hn3vV46YxI+9VplcrfB6Dw0epzhEC9zFWnaTsk2Pl8m2zyBdjqLiQL0
 yJ3rVlFkIdm+3lV+VOICcf3ibuqmuxQkru+A0NHHqALmV8ffOgQl87zOzk//6Ka1J9A==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=oQ+16+1C; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::333"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::333; helo=mail-wm1-x333.google.com;
 envelope-from=casey.connolly@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=oQ+16+1C
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 67529605DF
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 10:57:52 +0000 (UTC)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4a5b2be99a8so6732925e9.2
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 03:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793185071; x=1793789871;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=48VZ5DUmB0THmw7ClPa411/wBheJn1FjNjvnIPDYPcI=;
 b=oQ+16+1C2oFNvDq86kfvgiqGOr4oYbU0oe8saNud5MCPNP82RqP1I1uQWw2MWK/7w2
 Dwp4zsVKix5CV6PmQnohmOXmuf0lhf0rpTwGeo/Nxaq8+PFygYYMtwG48xbl2CPILIxa
 wNgSEbOdi7Q+L+Q/CLLTnNL34q9b1Rdhdipm9gAfzRZc7cqceXWTEZlomdCnkp9PS4sf
 AXWgnGAPaKO37d1kS6/EDb5a7vR3Kxn7g9md6KXOFsYl9URG5uqQ3WYGJ1F2GfTjR0OB
 uC2PT4GgvIqYjOdPUY1JckrYjwp+pTO0AKwLLbXxuoG1VXUKMZF+uFV6Jv56PZKmEG2l
 ET2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793185071; x=1793789871;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=48VZ5DUmB0THmw7ClPa411/wBheJn1FjNjvnIPDYPcI=;
 b=fWJSPuJVDLsGo1XmN0g0/Pa3m01yUnXC2uCMT5ZUm14aRxdvpfoXz+bjyDIlsqwfoU
 S8zkeLzIBdOIqkQgtFnTBRe9kXBuR38zmbpmMhP3YoWTXKcTktlEsnwH2lqd7BOmpyfV
 XWIAawlPWTh1Xu6xZv7qMe0FTGKP8/+fBiwQbWBQZq8HixV2Cqg9vQajn9Ht9+4v9ljp
 WcFCMM+TpzfYXxcicvwloeVuAmscp89VPG4wmN9ecByyU+yOCBGEsuRE8D9ESof0HR48
 Oj4PtQgig9OqC4k0my6EtqBKfo4bma4TbmLIwulvDuXrvTgYLWcsLaz/TikRXXuJVb2w
 KsFA==
X-Gm-Message-State: AFq9FYJ8MEXxrCrdrWmTNNbcxSUHjfb8kf4jQ5ulcHSu6ycrwphrd5+k
 1Gc1qmmQu2idhS5u6m7I42Lrw9sclPpLHoonOomCf6CsHxlTL3YrxZuwe5ZsBrJadydSi8ia1Z0
 G/rAhios=
X-Gm-Gg: AYBFou2oZw3gl7sdhWsD0/lkcizOVr4bmMMRzajTgDfFwHNd9sDvZvm42PT7nRlpLMG
 0IXmww7n833pWVMHy4o4x5Gs6LcXFJVcT4ZawnJr3+fx4swfh0NzGJQFsGc8Gf7+9z0ufFN1lBQ
 8UbPs+h+127oRFRQnrH30mTRpb3NqxYIw476yLVHcLnv6weFL6xkw/Owz9W+WZx/RHcynbdJCZA
 HF0xv9jj+yTbcmWRfELuwTCUwUOac5Ir7GxlMZ6g+Zp2WkIEuorDyTIA70PHwDyqpYJQvYaOyTE
 kzv/wJMchfMMTw2CsM+4Dub3cCZqS8pfATPYs3UhOulJMgYvjg07mtV8jQmjWjYB2ehrL7GnL/+
 hWyz/q2gxL22ik5w375iKeLuKDWtHe4uQUTdKRsJdr+WnXI9p/Fn+bn7gsqCLjm0w4fLuktIVE8
 tXgVtK9Kb2yVxd4PUAqdiYBh2uXzBjdD0kfRN02ZfrygtRPNA2Vu82AXwk91TZ+Sx/rdALfVy7Y
 pul5nfKvd9WPvcxcnuPpjNNNHR5XJ4vuaTodUOHkG/DYqvuJFyCUZwi0k9XOyUjafa0iTTDW/oZ
 wrkIOwv84hTQgif6vf/i+UEbmqNRhLA//ubYDuhMfupI709gKzg8ovbkpN0n4gJZKY/638SD
X-Received: by 2002:a05:600d:4121:b0:4a3:59c9:a758 with SMTP id
 5b1f17b1804b1-4a96836988amr40591865e9.32.1793185071074; 
 Wed, 28 Oct 2026 03:57:51 -0700 (PDT)
Received: from lion.localdomain (p5b29ef1e.dip0.t-ipconnect.de. [91.41.239.30])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ecdfd8dsm26254942f8f.56.2026.10.28.03.57.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 03:57:49 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
To: u-boot@lists.u-boot-project.org, Francois Berder <fberder@outlook.fr>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@nabladev.com>
In-Reply-To: <BESP194MB28058363D3E3AD5E44EB31EBDA0A2@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
References: <BESP194MB28058363D3E3AD5E44EB31EBDA0A2@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
Subject: Re: [PATCH] clk: qcom: Fix invalid usage of dev_read_addr
Message-Id: <179318506945.1103007.4719121157051130887.b4-ty@b4>
Date: Wed, 28 Oct 2026 11:57:49 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On Mon, 25 May 2026 22:46:32 +0200, Francois Berder wrote:
> dev_read_addr returns a fdt_addr_t and not a pointer type.
> Replace dev_read_addr by dev_read_addr_ptr.
> Check that base pointer is valid.

Applied, thanks!

[1/1] clk: qcom: Fix invalid usage of dev_read_addr
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/b6e7ea13ee46

Best regards,
-- 
// Casey (she/they)


