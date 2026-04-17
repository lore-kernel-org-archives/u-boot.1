Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18627F433D6
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 08:15:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ADBEF8426E;
	Fri, 17 Apr 2026 10:15:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="N1OPSAO6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07FEF84246; Fri, 17 Apr 2026 10:15:16 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 272EF8422D
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 10:15:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ghidoliemanuele@gmail.com
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-43cfbd17589so275519f8f.0
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 01:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776413713; x=1777018513; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=WhU1KEIUS+xV9lTXK9S2oLxK2bRBJpA7Cutz/RVay38=;
 b=N1OPSAO6Wmx4+Nxn2RLL/5QYG6oujxh7/R7XcOgC5nf17kYcD+w3sBf1oljZF4TjH+
 ZkrypPMzrGfT3wLawD+GLJyRK4eS1QLoRghfXkvJNWbdo9+n9cjrNzna8bSPS/KoIBmb
 NSfk8A2UV9zDn3rtaCOc9+dagmjXUkH48rbF3HXZCmZRmNv+YKH/jlJwzN6N9yvEzBvl
 ou1qZs4VfGGp/heRIWhEdhl1gK46BC1pLORBQNj2CkS54wt/HnnXuYM2ynjiXPQ/n3+1
 E8aMMn4tCN5jcotDU/lnPch11/t0UcmFvHIGJyp2vwco6MxvywD3UXsOHTMeDkTHZkbR
 HCbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776413713; x=1777018513;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WhU1KEIUS+xV9lTXK9S2oLxK2bRBJpA7Cutz/RVay38=;
 b=jCA1netbUMERSORorwl4pg85Glap02Joe6kH+bfzqCOHMfP6dAgk/BIR7Os5PP65Lo
 ctaqzCbKk0lsNLRY9s7fQDLZYLwFDA9mbbDS492DaZlHgxSo/lPkqN+DRK90EVyiS1Sh
 CKvlKz4wJypdeq2xgWD9IpsZ9tuOBiPk8MTe5/W24b3OjkFUTTkH7uS01xYuw7F4V1YH
 DGL6Pu84TTTLBDPDt7j88ElKQWSf0HEw9agw53uwyDISVCa1ta8tQZpMvE+R8DqwsL9j
 KgR5WoXy7DMge15hFqh9mYfskgUDhrfYAM7vlhfooBbvSGeYJWzkCyf+R5aHg26MqKMj
 8T6A==
X-Forwarded-Encrypted: i=1;
 AFNElJ8gsyarBGfFEDyZq9u+3yiAliEDqMFeiZJahs3LPZ76cxmdCW5d3LWcmOMneI4mRyKXZQrpu9M=@lists.denx.de
X-Gm-Message-State: AOJu0Yx2brwRwvBrkOIOw43cO3HBHcNOErZeTCCUybnyXXvykxTTM7/X
 gCjf29HGVHpJeX8j5ye687Hr7s3EXWnrQ5IezBhfSTKez+uVzaEDCSjH
X-Gm-Gg: AeBDieuvHRxwc4GSxEmtGaNbOaP+0wEAlSwlW4lEPfr6RZtjRnncHVsB090eCpIiF2t
 bzV/8xunXvnCwqZT9S7HqLR+Xjn//HrxdaYZ/nGp0ZFRzp1zhFyrj2QqEGp8++BIq8K/9tQdgyP
 xuCCkprtB2DAIEmGQmf1RXqiA+P6G6keKt76WaFLX+baTKLXvhAcLJ4qwoujZlTTgHNQUdRNWuX
 5Z4fUusePLKCme+MvIvfDSXHQpNA1WMMg2Pp09Zcx9aismnpakVIrCFgm4yfIF3fhsw3U/KlKJs
 OfodK4ugYTilUIOZ3w2fUx7/jjUNW/hqCTzsmz2cdJksv8efBg4n1Y4Eq67dtwlFeF41YM2fqPf
 YxaC3HRiRN+3B5+qFLUlhWz3DqL9lAGGsjC6z9TqqDfffWDVUUhXY1YX1xWYg3Ejxh5TNSd3hxE
 UBto01TCjyPCl+P4a1YCiUsuPvINwWALAlWadiYJNKiyK8UdgZ4PdLjEw+6yRWyTMh7GsUUs2aj
 WTfcZU4AyWGBM9G
X-Received: by 2002:a05:6000:144d:b0:43d:7403:4b63 with SMTP id
 ffacd0b85a97d-43fe3e0b862mr2443573f8f.44.1776413713371; 
 Fri, 17 Apr 2026 01:15:13 -0700 (PDT)
Received: from [192.168.1.3] (host-87-2-163-213.retail.telecomitalia.it.
 [87.2.163.213]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e3a7b4sm2537984f8f.22.2026.04.17.01.15.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Apr 2026 01:15:12 -0700 (PDT)
Message-ID: <b9d05cc7-df84-4c6c-b45d-9393d0f3f248@gmail.com>
Date: Fri, 17 Apr 2026 10:15:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] board: toradex: add Toradex Verdin iMX95
From: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
To: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>, "NXP i.MX U-Boot Team"
 <uboot-imx@nxp.com>, Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Peng Fan <peng.fan@nxp.com>, Alice Guo <alice.guo@nxp.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de, Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
References: <20260417071546.1610330-1-ghidoliemanuele@gmail.com>
 <20260417071546.1610330-3-ghidoliemanuele@gmail.com>
Content-Language: en-US
In-Reply-To: <20260417071546.1610330-3-ghidoliemanuele@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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



On 4/17/26 09:13, Emanuele Ghidoli wrote:
> From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
Apologies, I accidentally omitted this Reviewed-by tag.

Reviewed-by: Simon Glass <sjg@chromium.org>

