Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F087CEA7943
	for <u-boot@archiver.kernel.org>; Wed,  4 Feb 2026 20:47:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6214983015;
	Wed,  4 Feb 2026 21:47:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="pn3RUgPv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2C15838FA; Wed,  4 Feb 2026 21:47:20 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D61BE800AE
 for <u-boot@lists.denx.de>; Wed,  4 Feb 2026 21:47:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dan.carpenter@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4801ea9bafdso1206395e9.3
 for <u-boot@lists.denx.de>; Wed, 04 Feb 2026 12:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770238037; x=1770842837; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hxPV8j/bs9nxlMhos39KuioGAEsnmau+JQ/TAw/iFlY=;
 b=pn3RUgPvHGLJrUXDV4nG5HoGlR0RYizBjXSG+rnVdgniaqLfi1ptDo6KjPgGMWdJA5
 F+8fXSooR8MzUzRH3mhvtLgotKUBsFvdD/WLxpX5eIRsRMvJnGmdZYQZ7UtWeKaJ4q8j
 11lOerUCfM4lALlhVpMwD8pSxoSxKvlx/WWTAMFeUPJWFVA8s2x/X/FsvaVKRBdIu9Y3
 mxfIMomEBznUUxjy0Duv1/RJSu7t03y7nDNoE4egJitd7gGsfB6GrqgfvKGxkfsCSsI8
 Rf5Y0hPnWMSRY+OmA97DbzNTMlmqkZPVIlJwsEGUspsdOTWPKdt+FMcjMYCRaMpqiQCQ
 4olw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770238037; x=1770842837;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hxPV8j/bs9nxlMhos39KuioGAEsnmau+JQ/TAw/iFlY=;
 b=sv5UUHe3xOaUem/QzaV2dcrldmTx2mJ3e9dfQ7MXWh1FcBqsTdwvteeLQl0Swh+B22
 jgCcCgtoOhSLYUtHQ7AuJgAkb9OWCcLwIAnSGudYKHOR1X3WtDsy50CTkYY7G/IedAHD
 /NZkQbVre7YsNtyLvDGX5xPCkzCWmR4jtTlAlwSG+uX72pxczTffrlMI2M6WcKftytPw
 nydOsS+YbtztpcjQfmkKcFX2fUswvZfK/iHttZX7DVFVxDD1Wg70PDabWbloyc07kUJc
 W690Wf0Z64G5QYToI6jTakcOPjOX0Lmj+S/UzEJ4iTv+8aYF/WrKwK7rnx84dhVaqmI/
 hw0w==
X-Gm-Message-State: AOJu0YzdTmTX00e3oubpnV3vPCYAmDwC+4oDHI4utIvFAgyK5oUciryC
 D5H7CYzYGj90dvVe2DGF2QTAlAQ2HwyJtvauQCHeKjNUTWvGqvTz2dGhpBAIMsnnWzo=
X-Gm-Gg: AZuq6aJuc7LO2mGigCQILXh311sYSpX27rpkZMRza8UNYLk57VWfNqQxU1KZXDPRO4E
 PFs+fv6pwNYKvGKi4ApMfbzKdl+8+ioNqKfojay0SJz/DjLT96TFSVnM8goVbUybcfM3GBX5AyL
 R0mymB7zZbta/Cq0TKGfyCKqaG13fi+MSoDWqZ2bWnbs1Rhk4reWwtE+NPTT3YYEtvQrmyIZkp0
 MelluJOb3UlkolnnK9HydqNHC8L0Nh4kf6xWeo0oLprucBlEiLtWV3ra+c1nvstLvPCOrd7OkjY
 Ojq9oh91s4q2uLIBM97M7Gwryly7R2x2T1pVNL8F+/BQvNy/pL+3fI9RnWDkB11b8kXk6UfrO1x
 LsKjNykTKFQ3va+q5fNonaPggYoqJPrP/Oq0Tz7HpYUB0gecnzN/QKBo7+v6Q8Gji1gANofUivH
 m+yrGZ7cOU2q3FX404
X-Received: by 2002:a05:600c:a088:b0:47e:e4ff:e2ac with SMTP id
 5b1f17b1804b1-4830e982935mr50420665e9.33.1770238037178; 
 Wed, 04 Feb 2026 12:47:17 -0800 (PST)
Received: from localhost ([196.207.164.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48317d3f007sm17945755e9.9.2026.02.04.12.47.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Feb 2026 12:47:16 -0800 (PST)
Date: Wed, 4 Feb 2026 23:47:13 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Jens Wiklander <jens.wiklander@linaro.org>
Subject: Using SCMI under OP-TEE (uboot)
Message-ID: <aYOwUXOXHgaN1Ak8@stanley.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

SCMI over OP-TEE is not working for me on u-boot and I was wondering
how other people use it.

It fails with:
scmi-over-optee scmi0: failed to probe base protocol

It's an ordering problem.  The scmi_optee_probe() function tries to
call open_channel() which tries to tee_find_device() but the
tee_pre_probe() has not been called yet.

regards,
dan carpenter
