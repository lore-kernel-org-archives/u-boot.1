Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13F8ACD3447
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 12:58:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B45F84A48;
	Fri,  8 May 2026 14:58:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="ekcMjUMx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79F8A84A49; Fri,  8 May 2026 14:58:09 +0200 (CEST)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45B3584A44
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 14:58:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-4232323a7daso1074407fac.1
 for <u-boot@lists.denx.de>; Fri, 08 May 2026 05:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1778245086; x=1778849886;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UZocgYiwXqesNfFlVPLHv+8VJgR1y/jvNlH6EodRy5k=;
 b=ekcMjUMxV1Lrt+jqTac2CTz6bqUleSrrGyyI8z8uzKl1oXUeofkh8X4Cr4X/cT4xYM
 YO5djC4B1vj34oNFiqVYH710HC9+pQ46aZJF56WWq+6kqGkN7KuwPL++zPDnVSu4pZjF
 ihGWI1+dwMtefJcmLhcn1riXHJY+Q3XPDR8dOAMJASZGvsw7jB295z7BuglimHuG0sxG
 voCadZNxeaYqha0XuR+YCZxhOLw0NA2/JOvheXvutyiQNVCqfWLEUuhvzfZ5oaeq9rnf
 wlThY+TKGkCyqqyJUiAermgXsFmZDncxxGZ8B7qZI7Djsq02dQL+G2AQtixLZjznjMR3
 CJtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778245086; x=1778849886;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UZocgYiwXqesNfFlVPLHv+8VJgR1y/jvNlH6EodRy5k=;
 b=GkvD+bPb3oNGpf1Ck4lbWFIBfM6gZIT1JNZoULXn8/5mGwhnEMmmHvcYP1qeCoTRKs
 aSpPI2VL4FuHdkp2evUmVS5G1wcEQ55NxJ0B/bbVPXJoKFIhq6rEtIhBNNpKNSEoi6m/
 PYgKIlkWdObSJOIgHeqoX3a5ATRyborKZEZCzSLZmOqquzP6q+in76Dijkk9yy0Nc2UM
 IwyxAbp2qEzzKRvUVx92DQWIBo0MUXXufrtI5UUycDL7B3h+anGlX/+WQ1g5PYgt4xl9
 FKTmP8Gn0C75DrE+BREv9fAJZgETwgFCrs425e29paGKOCzBjvMT6Qls19dZFKHk53+o
 b84Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ+eRkJUMM9PVD88+uaVzdhsbmslRYTCNqw/gEYb9/YO8aq5zBQouNFBKVN2OJuBb4PhBCJUjFs=@lists.denx.de
X-Gm-Message-State: AOJu0Yz7AgQUABtrECDbn6cZNFTunmv5fcJAbeIT9YrRJ+b96ZRtljrp
 pcvqEQ1+vWdCG6wYPiwCRhun12liAMXGfp7/NE4eGcDf7aLrSwpNVw7TGhyqSXNfGBg=
X-Gm-Gg: Acq92OGfOcYcbGDrs9Fo0a9XNE0fo3AHJsxPqbQRQyBfm4N9/mWJyUipQrWxKl15Oeg
 DjIY/bOV3C/hZhYKjHBPTALSBAZauUh6DZSoMqHhgoVxFgOrL1I/6vsRKNCGt84xT1Czl2FmZEX
 N8RSWaYb+x0CwoQwkbFYYihier6zz2Ensf9vfniUymHlxvnjyj3utz7A6FC4hEQPetu9s0y/eUE
 Wi1IO5OzPejxv8xRteb78K0rZr1h9q17GS+QTIRtJq4gUFsUKfS6cxOM4sI3kk0XGi3kBR4Z6dA
 QSfv3GxoEFHkwLWhkpDRzxmxZgUAskmgN1qumH4veq8zyMJ1nBUjq1o+uPlhbEt3qOYMruSUPwj
 18iko//Liz8VU34Tc5R3QPpshEENgWFRpRXuHpq8Kbxi6/B2rpmE1VjW8aDUVo6prEw2F2BeX/6
 i/g57bg4nZwk9EAj5glFJ57jSArhILsg5dgQUW7R3hg2palIBIYT4PjOBVeNcd9ds1rZr2No9RI
 naAcDeyt9gy
X-Received: by 2002:a05:6870:4687:b0:42c:13f4:d4d0 with SMTP id
 586e51a60fabf-434f57e735amr7788810fac.1.1778245086007; 
 Fri, 08 May 2026 05:58:06 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:a816:aa5a:646e:34b8?
 ([2600:8803:e7e4:500:a816:aa5a:646e:34b8])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-43557109b7dsm1657601fac.5.2026.05.08.05.58.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 May 2026 05:58:05 -0700 (PDT)
Message-ID: <37b691a6-49b0-4bba-9249-544f368edaa3@baylibre.com>
Date: Fri, 8 May 2026 07:58:04 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/14] power: domain: mtk: Staticize and constify driver
 ops
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Julien Stephan <jstephan@baylibre.com>, Peng Fan <peng.fan@nxp.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Tom Rini <trini@konsulko.com>,
 Weijie Gao <weijie.gao@mediatek.com>
References: <20260508122247.512862-1-marek.vasut+renesas@mailbox.org>
 <20260508122247.512862-10-marek.vasut+renesas@mailbox.org>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260508122247.512862-10-marek.vasut+renesas@mailbox.org>
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

On 5/8/26 7:22 AM, Marek Vasut wrote:
> Set the ops structure as static const. The structure is not accessible
> from outside of this driver and is not going to be modified at runtime.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---

Reviewed-by: David Lechner <dlechner@baylibre.com>
