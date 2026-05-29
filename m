Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48B9CCD6E49
	for <u-boot@archiver.kernel.org>; Fri, 29 May 2026 22:47:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DA3B847C4;
	Sat, 30 May 2026 00:46:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="I7oNWNYA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F31A2846FA; Sat, 30 May 2026 00:46:55 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E1266846A5
 for <u-boot@lists.denx.de>; Sat, 30 May 2026 00:46:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7e6a306fec0so203436a34.0
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 15:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1780094812; x=1780699612; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HUf7HwXBR3+G5ddcTO+g08aQs4vSzCHex5uzPQuXAX4=;
 b=I7oNWNYAdFZO35INZPPxmP2SvOH+dlz6s3YSUywFQBoKmGRCN/I7Q3owd+3KJKJ7mC
 KBTBQpQ0Q74X0Ac9LEaZCpFRfbo55wRt3vwKMRSeqihu0SkG4jJ9iR1Wo7ETiBPyuOZB
 gFL/F2+Iv4yaz0O50dmu5Kagzw4wJrBHzIbKQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780094812; x=1780699612;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HUf7HwXBR3+G5ddcTO+g08aQs4vSzCHex5uzPQuXAX4=;
 b=S25+fy+xysDLKO7xy1Ua1imxJKeI9hewxsvHridymJLlf3+JOX+dFjwZgPZtmet6ke
 +PQmo5BmLvKhhO0GYskkcIb0shY4WXjxHxIpNHo+zOtzGfTmHzrDH3uUH7Cwr7qGZaD7
 puafGmWuyErekK4f4fSKxJuLjdBAgHPx/jZ1pH6Rsi5Ypzma9TpaOSAAcc1rz0QJR7p9
 kq7bimLq+7Fxhv7RHE4jxmQjkj3pISjRgRYJm2EQ3B+LAdEwJ8MG8DjgrwfEIPS9SGkL
 9ZO/28GOF4RYJTijkrHVrft98vjH19+L5igNNz87ZSqdqlCUpEmmIqexn2tnWEsYnQy+
 i9Tw==
X-Gm-Message-State: AOJu0YzapYZRC21pQJOdtjbFzaqUR4ULlh9tQJP+bVG8EJ6DhmOiwoKJ
 Coq9qndxrP1mdvkhmnr8xjHBaAoHPxheCWs0RkF8wYQDWynMpnt4oQ2mC0C5B4vq4rnYpnjGH1z
 TUdzknjA=
X-Gm-Gg: Acq92OFkwi8KyE3kLgO2aGSinCjWh2+Y7CQtcDkox0bwyszhbUiuMdIENC2wta9+c+z
 7GeKX9McaH8wXozLtZUhoVQGNwtUe5uP/gpCo05Lj+blq31+lFXuK4Qc2P00gIsYJJk2iIb4IBg
 y+V6yFfuxUoGPRhtvFRw/oGuD06fwZgUrZ2aSpo7kKoTk8St68Q2VlOAVpGvleuxJrRYwJA+gjU
 zhbvvxXmonVV5nnAYOhq1wqxu/IIz+4eXFJwddHthv3ILjIOJw2cNb26tDSoRKrn/xrqJJobgtW
 tREq4dVYQ7X5Z90NbqX8D8YS43D3XbZXsKTqaUj02Rtw6D7c2An8GL9qr+4PN2epknwEbDrarxa
 hE2y+7qO7lCOqR8+hdjKwaEj2bWwFXc0btqQCpSfM759aCCkaMF+t9d9BQeELFLkhaitWzMMG3f
 SDgiA12MxINmRRSpBFsz4GF6DWAwTMxR+X/yd0AqU+MktHewH0dc4kFrP6fze35TiC0m3Mj96iG
 3oPkDPHe5bDgOJQ6nLKFyRQqipHxnY/e/I+mBlLY7A1alEl/adqbvk=
X-Received: by 2002:a4a:ee12:0:b0:694:9910:f78f with SMTP id
 006d021491bc7-69e0fe38428mr668649eaf.3.1780094811847; 
 Fri, 29 May 2026 15:46:51 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-191-8-235.totalplay.net. [187.191.8.235])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69e0696923bsm2112441eaf.11.2026.05.29.15.46.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 15:46:51 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>, Adam Lackorzynski <adam@l4re.org>
Cc: u-boot@lists.denx.de
In-Reply-To: <ageGYp5K7a2hanTC@os.inf.tu-dresden.de>
References: <ageGYp5K7a2hanTC@os.inf.tu-dresden.de>
Subject: Re: [PATCH v2] common/command.c: Avoid NULL pointer use in
 cmd_auto_complete
Message-Id: <178009481126.728062.12396001976923194637.b4-ty@konsulko.com>
Date: Fri, 29 May 2026 16:46:51 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On Fri, 15 May 2026 22:47:30 +0200, Adam Lackorzynski wrote:

> Avoid using ps_prompt having a NULL pointer. For that, use the same
> approach as in uboot_cli_readline().
> 
> 

Applied to u-boot/next, thanks!

[1/1] common/command.c: Avoid NULL pointer use in cmd_auto_complete
      commit: 8429766a7f08ebbc0e4bdd8bcc8939a6b3ebf251
-- 
Tom


