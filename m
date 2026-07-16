Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E024C44512
	for <u-boot@archiver.kernel.org>; Thu, 16 Jul 2026 23:25:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95E2D84DB3;
	Fri, 17 Jul 2026 01:25:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PDLhMt1S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 020FB84D9C; Fri, 17 Jul 2026 01:25:11 +0200 (CEST)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB00A84D9C
 for <u-boot@lists.denx.de>; Fri, 17 Jul 2026 01:25:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-44aeefa1c00so1377156fac.0
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 16:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1784244308; x=1784849108; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TJqjKcJagKDdVvj4z+WgyzXOBW8h2Kn48e5dk7r/ze8=;
 b=PDLhMt1SNvxcodfSmyZqG9BrnceJNbYfwcB3S6seIciny+lP7zLYjh1E3//I9Sa5L4
 5B0C+PsdWU5zLIKSIxwjoPkgp7KEeSMSeRoLfMpCRCmkrhu5afX8XTAcR+uVZm5Zq7nc
 PPGDyGk1K6zZRUHfhwHRMSyMOV53JleMp6Du4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784244308; x=1784849108;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TJqjKcJagKDdVvj4z+WgyzXOBW8h2Kn48e5dk7r/ze8=;
 b=TMNlY+og6kFe58FUPeU2hYv5sfJBT7XHVpKMfgYF7qbaAyspvhHdvHA1HoFa4uMdtY
 HT5S3KciIMwQCIfUR5sgJd7/0uXl//9HSHihJqgasexp+iaMEA8uotDGYM1S3C4S9LC5
 tJfgaqLHw/EI1e/C5hIrlQe1h5xoLmP5pYmVIX0Gp8EM5N1rnXA8EAOQu9+hZNhnH9qN
 VpxdTvr9+d0rvyQvF7y8TEZtEIL/HQMm+n4FHk2eNb32gfdKeItWA1SSg5VfUPET7hND
 a6OZN7NxKO0PPq64ZwjIA1dlsgjVqDF86pyHOV0G2MLNNUzGTfTTMSG1xX/Y/Hzvk+Oq
 Wa1Q==
X-Gm-Message-State: AOJu0YwdWr7xTdgDI1O/z4F8EO2oL9yWtR8k1/Hh3kxJTouIV+DMIVDF
 yKjDMDdk/yILlHWvtAQW1o7fBIhr1m7IDfnpJAQa8FefRpdX1DU3vubjDMEi8uteqPY=
X-Gm-Gg: AfdE7clo4Kq4Ve8/6gswZOqh7SF/zAfjxkoyRm+yeY2qaowb2pDiyU5hd1n4rojOoeN
 3AuWbo7B2n+oFwHKvo+8W9BB9k0HFK/L81czqImwZ+4dHiBeFwx1UH+Sd7s+wzomaqyVXg4JBhI
 k3U2xaiQQlCHiDNDUAXrGJL9joFwxYYt2O3HqNVKnQa+nZ02FvM6HeiBAdv3aeIa9XkuheaLe//
 jk0hSs0ex/PpgTB2vD1wmU1sKnUwSnwOVR3RLiuXjr3cW+DLr9xt2aeX6qrHlb5WGpEltDagzZZ
 DZhTpU7vMhSKyd0s22EvL+WvMPgczxW0ZV9AsYTzpmBNHQ9VWg9EdusK4qw8bqRhRJZWG8MvOt4
 aZLA+QYl1GUheSpPq0pHz6p97KdIR7lOs4ZWxtjmzRbNjm+RJzMkNMx5oaamGfDjd8teis3rseo
 iSfML6HyB/Kcs+l8IRhqhiaPilGvHGvn8hXWO/4rcwqbKX1kyxxVAoAXu9dCw5RD88OnxZhDhlK
 rHa3lG9+gN8UvWi8Fg1DQACPg==
X-Received: by 2002:a05:6870:c2a9:b0:42c:552:f70f with SMTP id
 586e51a60fabf-45661021605mr2891595fac.16.1784244308615; 
 Thu, 16 Jul 2026 16:25:08 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4568da4ab47sm27308fac.0.2026.07.16.16.25.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 16:25:07 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Anshul Dalal <anshuld@ti.com>
Cc: Chintan Vankar <c-vankar@ti.com>, T Pratham <t-pratham@ti.com>
In-Reply-To: <20260713-am64x_sw_rst_fix-v2-1-3e0df7c88a96@ti.com>
References: <20260713-am64x_sw_rst_fix-v2-1-3e0df7c88a96@ti.com>
Subject: Re: [PATCH v2] mach-k3: am64x: clear MCU_RST_SRC before reset
Message-Id: <178424430712.1470194.13524890432440651046.b4-ty@konsulko.com>
Date: Thu, 16 Jul 2026 17:25:07 -0600
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

On Mon, 13 Jul 2026 11:07:05 +0530, Anshul Dalal wrote:

> In warm reset, the value of CTRLMMR_MCU_RST_SRC was not being reset.
> 
> This leads to a reset-loop boot failure when a warm reset is triggered
> from the MAIN domain (by writing 0x2006 to MCU_RST_CTRL).
> 
> 

Applied to u-boot/main, thanks!

[1/1] mach-k3: am64x: clear MCU_RST_SRC before reset
      commit: 28d09d6ab68c4a3ac3b95c508a79dabbaa9d3e89
-- 
Tom


