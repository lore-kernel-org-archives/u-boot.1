Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0F0606A334
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 14:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=J6v0ieo1;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=G0PXbOtb
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E0BCF80F76;
	Thu, 26 Nov 2026 14:22:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id U7H5RCwf5IK1; Thu, 26 Nov 2026 14:22:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3D85A811A2
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795702926;
	b=MP2V8CNNlhJvTKSIH3gXqNyhk7wJAdEXmIHJNUYeRcsSFrTeu77C5CCNl/++5EQxiOwQ
	 OvT+YeXWxEE0BtxWZ4iSQuG2Gc4SbVnS8A7DQOcDoEAuGt71R10ERYe9PIqFLIrS9FT5x
	 dED/jl39LO2SbDLnlZ57cXM0GM0MVleCRWRpcctir2YMMnLhXcnYDbNNv0GTAB52MlpGe
	 LYAxVgwVJN8jKI+UTu0B4poIOFZ80naloP63iIo4AVuv+j94MN5QOEQbZk32ZGBNcHjCD
	 /KWkB4gISuid8lEwuC1P6Eu+5/f777mrw2Jtw+2Bnvny5PINhGK/ojgQnpqRZwvZrPA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795702926;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=abxTeueoQx+Ed4cACCZh9uWCAAhHvuDT+q8ti2T+1t4=;
	b=dg3qRO8NULSK9bOaoJjOwsLDNNctc9lsSZsz3xkUraHGXh4cCULGaOkSCw9dLmtd+Gsx
	 wbfkYArP8XPR0RJbn0f35RmbOlZuktger5qZ8bisV5zzbbcUT60mD7Q/mmEsWMu1ixsFg
	 Zq/e99HdH7C8s6SRMDp/rZBu27ZMtAHnvCipqNXsnqJwJMnfam7ES1+2FuhEu6iLRdyNm
	 f/7CX2QCZ807n0X8MCxzQIyXZUg0lq4wUVmtHqiXFzUnR1Zf10T5/5C+vdxnF+Z6FoVck
	 kXzldVbXgIplP/i2Sv20q+weiHBcC5H+um5lXr0BFXt2KNZyAjP4w7Rtgs5Q8Ld7DTA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795702926;
	bh=abxTeueoQx+Ed4cACCZh9uWCAAhHvuDT+q8ti2T+1t4=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=J6v0ieo1BLtHtLI6+dRvD55Oqp9P8CGBGAqvthtTUwrnXn8bdSeZ7C7G5C5YnqREA
	 AycZXtUfccX05doAH/H5/JzqAmA/+aNtv7ArNIN7iU4Gr4TdbY62jaje7QGFYWCmzB
	 tEtLptoWZIEf4kboVch+w+wdx7mNFsL9lHh+L6hkzrVNHQ7a7luC1MkKANazQwxuKo
	 tdvoQ3hKe39/eVPWXc5HTpTSewtteoyQAy2lrRAAM7cqKvoEg2U3PDlmVbtoN5iOmv
	 Cf/sTUuCMGt7xprdyEssI+scQvzhEuVeXx4kLEI5TntDVTxpW4lg3P+JAxM/4ww2ZQ
	 cuVfkt+550A3w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3D85A811A2;
	Thu, 26 Nov 2026 14:22:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id A5A861AB
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 14:22:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A23CB4099E
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 14:22:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id q5wnLhlEdaWy for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 14:22:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A42784099C
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32d; helo=mail-wm1-x32d.google.com;
 envelope-from=glaroque@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=G0PXbOtb
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A42784099C
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 14:21:59 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4bb55cda775so44108535e9.0
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 06:21:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795702917; x=1796307717;
 darn=lists.u-boot-project.org; 
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=abxTeueoQx+Ed4cACCZh9uWCAAhHvuDT+q8ti2T+1t4=;
 b=G0PXbOtbg26sH5kWO46bq8UaEFRfGIf122ftUlDvHFI67sapVqKnOemz2fIdtDl/Ej
 uVJORk6xjmcWYp5b/101CXjhmFLvgv1Kr7eBQp4mZSWpmEST6aUodo4ahCOJpTxhpIpQ
 UAXuvoYZeBFJHwU+dj21tc2J08pf/HImVYpBZZDwDE6cOFDZKWqsK1zRmxmBPfTRihQr
 SgytdOSbKRu5mtq3jSHQ4p/F/jLZJ23mgNh+tzvzRXZ8xLaOdHqGWwapUk8BvdCQq40w
 cVezOtB3eV4eiFbIlWjOibyqjdC9pn5p5NmsLPP//GZzwHJ7fcP6Bw2bquMQCHhjusb8
 wedw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795702917; x=1796307717;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=abxTeueoQx+Ed4cACCZh9uWCAAhHvuDT+q8ti2T+1t4=;
 b=kxsrUR/bc1CZX/euRP2+2h6XrBj8inR28ac/kVYHNz9XxcpWPHXtOHsN2281ONNbBW
 cx1j24rgE7RZzvJD4g+2XGUEauUJDnkk/Ir+sNWhzNwzBXOimQlx79nhD5pF6gOlAZT6
 R0aGg785oRAkExaCJQVDdpOp9t15cSxioRekrlIsQBlvzbj27TrCJTICjCipoiZXfMNv
 IQldJOWDZWv0Gy19tWJUktI3Pmw3+R/hL83ChZFyWb1WCNoWERNlzHhUhV68RZXo5zv8
 48qwkeR3el4L6alHyZQtB5FdWkPlGrVtcZZAfpFXXEQNjJ0j0MFebhEuS1HOip7j3BL7
 Dpcw==
X-Gm-Message-State: APuU4Z/9s0Re2ZZQ5X3/08G+N+37x+gMgxqYfKHMT+BW0fbE7U4TEHZp
 aGB/CBh3abkvXuTYumRLtnRJ29qiUxsIzRcAOHBqVVXjEHQLhB3muEKlTEc+085JZBxV6O2lm2y
 Rp/qDAZc=
X-Gm-Gg: AZFdTZehTxYTP+1bYSuy8I0a5kSwEatYnTNwp6Bsotits/PEHZ+m6VisplLZZ/q9J/x
 PD99NxU2QpbHVdnR6CS3bAhicT2t6iebtLcrvjzg0WpMEjrjiXRTxz8pwwHaHC7GC20hOQPzxAG
 5jQWHXc/c5AXwS4Yo0mecjqvNClxjgOVB/eeV5tnZRdBItjtKQJs8FnYTmPGLFZqM6laeKFKpFK
 6n1f4Av8ZI3r0LEG7WTJXVcDV7SG6/fD0mKbnE9ITxiLM4ljUvxbFcGcAgsLwt7wYHjdKTo+wLZ
 JCoB60LOG9SgNBWAAfT+MD4uXnuJbevf/Yc/xBAs20Hpdn6i1E9aUF6EcZWzfAZodlMILqHC9yC
 Lqjtwwm9Sv28wRm681QIaJGXTNlEf5xd3nbEE5HQ7BRPk8ykAk6ZEYspulpCBpjg7znuU7IFfm3
 jwwmSFAUu6JpltFFunftTMas6srMz2Jo2KZf8+HqoHauWjNmKQr4NX8P5+QDCm52mcrxs8PhpXQ
 KIxU5wIS0PRBy1H+eWg4w+KEd5OmabJjmgDcGX7yRyBvVAhQ9seaUmRYQXsPl0hKHGSGIWtFLC/
 MRaVkOgwpzzBGMSL+hNF0jhglzjYWv1uKQoZxsBz2o9Ehi0Y7Ng=
X-Received: by 2002:a05:600c:468b:b0:4bb:5fd1:92aa with SMTP id
 5b1f17b1804b1-4bb888160c2mr448624315e9.15.1795702917386; 
 Thu, 26 Nov 2026 06:21:57 -0800 (PST)
Received: from [127.0.1.1] ([2a01:e0a:e50:3860::e1d1:d182])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb90655f5asm387647325e9.1.2026.11.26.06.21.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 06:21:57 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 4/5] configs: spacemit: k3: spl: Enable pinctrl
From: Guillaume La Roque <glaroque@baylibre.com>
To: Yixun Lan <dlan@kernel.org>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Yao Zi <me@ziyao.cc>, Junhui Liu <junhui.liu@pigmoral.tech>, 
 Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>, 
 E Shattow <e@freeshell.de>, Guillaume La Roque <glaroque@baylibre.com>
In-Reply-To: <20261122-06-spacemit-k3-spl-nor-v1-4-33beb921011d@kernel.org>
References: <20261122-06-spacemit-k3-spl-nor-v1-0-33beb921011d@kernel.org>
 <20261122-06-spacemit-k3-spl-nor-v1-4-33beb921011d@kernel.org>
Date: Thu, 26 Nov 2026 15:21:50 +0100
Message-Id: <179570291086.2502540.6255025386026248558.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795702912; l=247;
 i=glaroque@baylibre.com; s=20261019; h=from:subject:message-id;
 bh=Neehxpgne2sEtk04SI34iN3O2z/oLHd2uMiUagJCkp8=;
 b=CRevbhtZe/mAe0uY4N7f/lS3l3Zh+vH2N95+b0HfnQxHJqvX1Xs6tVYZkbWjSnqEq4zglYvR/
 oSrDD5aWVZvA+kGhWEliqeYkcmtpZr2cbF2OvRlwldNxUsjL5ZKROOF
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
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, 22 Nov 2026 02:34:12 +0000, Yixun Lan <dlan@kernel.org> wrote:
> Enable SPL pinmux and pin configuration support in SPL phase.

Reviewed-by: Guillaume La Roque <glaroque@baylibre.com>

-- 
Guillaume La Roque <glaroque@baylibre.com>
