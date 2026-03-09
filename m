Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18399FCA19A
	for <u-boot@archiver.kernel.org>; Mon,  9 Mar 2026 22:14:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 88FAF83F98;
	Mon,  9 Mar 2026 23:14:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CpzB/n8t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BF4283CF3; Mon,  9 Mar 2026 23:05:54 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B6EF839DF
 for <u-boot@lists.denx.de>; Mon,  9 Mar 2026 23:05:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rgallaispou@gmail.com
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-48334ee0aeaso98632565e9.1
 for <u-boot@lists.denx.de>; Mon, 09 Mar 2026 15:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773093952; x=1773698752; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:cc:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Eg1TvUks9dYCwpHy/xBWCzC1jcwKu/aQs7H98FKB40E=;
 b=CpzB/n8tJ2q3Ba+KF+CnSp329ThZvDkSI2ZdnGMhGUFe5R46s37pnuBvLEymNRfieg
 XzzpkxK927lLB+qa8IlIZVFnqsxQtdKtlGhh4ANHnklF31/BJ0Xxo1VJyhoB2k0VMNmR
 N+loR3inG2LlLpedoJ82LirNVhGYFNXwBWSLLBekHtrd4D/GRVAD9kqwrkRvlbVt8h2h
 iMleMNynQ3WMWxQgfunycHw8oOfIuUJM8HFac2WsusyNms6pVdshvPW09+V4yCqVdbGF
 VPnPZsCFI5X7V+Jk2rta2jWdsDTR+u2zt9hs0OAmvUKr/p9ZpN0rEa+gWgYLdAmiU4pU
 JY5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773093952; x=1773698752;
 h=content-transfer-encoding:in-reply-to:cc:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Eg1TvUks9dYCwpHy/xBWCzC1jcwKu/aQs7H98FKB40E=;
 b=FeN7j2vDA3QqpH5XZoFIYuo15984w2PeV/AHR0VCOMVF2yL6zgF6IfV6mHWVBQVkRj
 3pQvi/tvj1vrEqPiA/iY0nM029V/jg69Y8u3u9awpmMi+SauuHtOshMiUFBC8ZjyR0yU
 UCkNYivcJWCjYESZrgQAtJk+tcXbaA9VzIUXNw85meralQ6y8hRK5kJBHTssYfksYJVb
 OPqNrQK6ccvd3zOcoSzoEXkf7ZexCoxztVBWgyr6aAopf8MgmRx/0VTuc2naXjY8lkZl
 Jpiy2PvuA9TRvUMCEdBqMjBz1U6ajtaaWzsXWQcAsbT9eVzoYdGF8bcBKttDhmycyWKe
 3ZHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdqXzHGhO2ZSWhMoiX09yYAdaQg61/MGnaT5xVuvvWBf2sx8emF0qmdFLUT7s6a8lo4N0bGxg=@lists.denx.de
X-Gm-Message-State: AOJu0Yy8yenIJS/LzY252Vg7X6BOKjbr+I/O+kwM8olIXGQO87SQin61
 reXDF82FcdY4tQ/sHx7u+Putr6ouspuTb0OUSfLtgoybsXdAdELMPqOK
X-Gm-Gg: ATEYQzyqiL77ZfSOkZD8QCQO7v14n2iNiycfFWRhrRT4KXY3TKeI3ovteg96iA1Zz7e
 Istidi+H5IFBL21fb3y8yEIXhhSqDehowCATdFLFY4JUhaAuLlejoNMu8l67HQtC11gGnIw6gb+
 tyF8cl9QLgW3+oTQNgGoq1i+HyxIulRz0iOOGZnz4Vu2MAu/XwWh3nxovnUHyBAFgQ5zSStTBN0
 VX1L1f3mvvFWJFcs7rliw2hpzI8z1OJUJXsHLjnAGgBLkE1Ty4y+yHhc8zGx3o4126uoyCVst1p
 pUdz8gXBgqmxZ/einpSwP/fpRXMGBj4Ho4VCmx41VMCfrQUxDdBWcrumm8oGdeHvj2iAL3FkfFH
 WlMXktkSLnFrqUaaXzzBdmNSjy03wMuW2PMZxdsByStBMb3fQXIZU16nr/27bvIxxHXyAEO8BkH
 rRIy7qn3FHh4mvRYQ1bMNcMJrGnJiUF5C+bbGiIIHtFGS9k2OnrSYuBLgjo7V+jPplStevcvY=
X-Received: by 2002:a05:600c:4445:b0:483:6a8d:b2f9 with SMTP id
 5b1f17b1804b1-4852690febamr231893515e9.5.1773093951481; 
 Mon, 09 Mar 2026 15:05:51 -0700 (PDT)
Received: from ?IPV6:2001:861:3385:e20:f99c:d6cf:27e6:2b03?
 ([2001:861:3385:e20:f99c:d6cf:27e6:2b03])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4853616a085sm76010235e9.3.2026.03.09.15.05.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Mar 2026 15:05:51 -0700 (PDT)
Message-ID: <22806ad3-cdc4-4f5b-94e7-21e541abf9cb@gmail.com>
Date: Mon, 9 Mar 2026 23:05:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Fwd: New Defects reported by Coverity Scan for Das U-Boot
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Simon Glass <sjg@chromium.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>
References: <20260309212331.GF1388590@bill-the-cat>
Content-Language: en-US
From: =?UTF-8?Q?Rapha=C3=ABl_Gallais-Pou?= <rgallaispou@gmail.com>
Cc: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
In-Reply-To: <20260309212331.GF1388590@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 09 Mar 2026 23:14:36 +0100
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

Hi Tom,

Regarding both stm32_dsi errors:

It seems those errors are not linked to the patch you merged recently, 
because it does not change the lines mentioned by Coverity.

Calls to device_chld_{remove, unbind} are introduced by commit 
a6d047c0a86b ("video: stm32: remove all child of DSI bridge when its 
probe failed").

My guess is that since my patch changed the file, it triggered the 
Coverity Scan for the whole file.

Regardless, ret is overwritten right after the calls, so I don't think 
checking the return value matters here except if there is a log information.

Tell me if you want me to provide a fix, but in this case I'm not sure 
to see the point.

Best regards,
Raphaël

On 3/9/26 22:23, Tom Rini wrote:
> Hey all,
> 
> Unfortunately for such a small set of changes (rc3 to rc4) a lot of new
> Coverity scan issues have popped up. Please let me know if these appear
> to be real issues or something that we can mark as intentional / false
> positive. Thanks!
> 
> ---------- Forwarded message ---------
> From: <scan-admin@coverity.com>
> Date: Mon, Mar 9, 2026, 2:11 PM
> Subject: New Defects reported by Coverity Scan for Das U-Boot
> To: <tom.rini@gmail.com>
> 
> 
> Hi,
> 
> Please find the latest report on new defect(s) introduced to *Das U-Boot*
> found with Coverity Scan.
> 
>     - *New Defects Found:* 4
>     - *Defects Shown:* Showing 4 of 4 defect(s)
> 
> Defect Details
> 
> 
> ** CID 644836:       Error handling issues  (CHECKED_RETURN)
> /drivers/video/stm32/stm32_dsi.c: 497           in stm32_dsi_probe()
> 
> 
> _____________________________________________________________________________________________
> *** CID 644836:         Error handling issues  (CHECKED_RETURN)
> /drivers/video/stm32/stm32_dsi.c: 497             in stm32_dsi_probe()
> 491     	priv->hw_version = dsi_read(plat->base, DSI_VERSION) & VERSION;
> 492     	if (priv->hw_version != HWVER_130 &&
> 493     	    priv->hw_version != HWVER_131) {
> 494     		dev_err(dev, "DSI version 0x%x not supported\n", priv->hw_version);
> 495     		dev_dbg(dev, "remove and unbind all DSI child\n");
> 496     		device_chld_remove(dev, NULL, DM_REMOVE_NORMAL);
>>>>      CID 644836:         Error handling issues  (CHECKED_RETURN)
>>>>      Calling "device_chld_unbind" without checking return value (as is done elsewhere 6 out of 7 times).
> 497     		device_chld_unbind(dev, NULL);
> 498     		ret = -ENODEV;
> 499     		goto err_clk;
> 500     	}
> 501
> 502     	return 0;
> 
> ** CID 644835:         (TAINTED_SCALAR)
> /common/menu.c: 589           in bootmenu_loop()
> /common/menu.c: 589           in bootmenu_loop()
> 
> 
> _____________________________________________________________________________________________
> *** CID 644835:           (TAINTED_SCALAR)
> /common/menu.c: 589             in bootmenu_loop()
> 583     			c = cli_ch_process(cch, c);
> 584     		}
> 585     	}
> 586
> 587     	key = bootmenu_conv_key(c);
> 588
>>>>      CID 644835:           (TAINTED_SCALAR)
>>>>      Using tainted variable "(int)(unsigned char)c" as an index into an array "_ctype".
> 589     	if (key == BKEY_NONE && isalnum(c)) {
> 590     		key = BKEY_SHORTCUT;
> 591     		cch->shortcut_key = bootmenu_conv_shortcut_key(menu, c);
> 592     	}
> 593
> 594     	return key;
> /common/menu.c: 589             in bootmenu_loop()
> 583     			c = cli_ch_process(cch, c);
> 584     		}
> 585     	}
> 586
> 587     	key = bootmenu_conv_key(c);
> 588
>>>>      CID 644835:           (TAINTED_SCALAR)
>>>>      Using tainted variable "(int)(unsigned char)c" as an index into an array "_ctype".
> 589     	if (key == BKEY_NONE && isalnum(c)) {
> 590     		key = BKEY_SHORTCUT;
> 591     		cch->shortcut_key = bootmenu_conv_shortcut_key(menu, c);
> 592     	}
> 593
> 594     	return key;
> 
> ** CID 644834:       Error handling issues  (CHECKED_RETURN)
> /drivers/video/stm32/stm32_dsi.c: 496           in stm32_dsi_probe()
> 
> 
> _____________________________________________________________________________________________
> *** CID 644834:         Error handling issues  (CHECKED_RETURN)
> /drivers/video/stm32/stm32_dsi.c: 496             in stm32_dsi_probe()
> 490     	/* check hardware version */
> 491     	priv->hw_version = dsi_read(plat->base, DSI_VERSION) & VERSION;
> 492     	if (priv->hw_version != HWVER_130 &&
> 493     	    priv->hw_version != HWVER_131) {
> 494     		dev_err(dev, "DSI version 0x%x not supported\n", priv->hw_version);
> 495     		dev_dbg(dev, "remove and unbind all DSI child\n");
>>>>      CID 644834:         Error handling issues  (CHECKED_RETURN)
>>>>      Calling "device_chld_remove" without checking return value (as is done elsewhere 4 out of 5 times).
> 496     		device_chld_remove(dev, NULL, DM_REMOVE_NORMAL);
> 497     		device_chld_unbind(dev, NULL);
> 498     		ret = -ENODEV;
> 499     		goto err_clk;
> 500     	}
> 501
> 
> ** CID 644833:       Memory - illegal accesses  (NEGATIVE_RETURNS)
> /common/menu.c: 589           in bootmenu_loop()
> 
> 
> _____________________________________________________________________________________________
> *** CID 644833:         Memory - illegal accesses  (NEGATIVE_RETURNS)
> /common/menu.c: 589             in bootmenu_loop()
> 583     			c = cli_ch_process(cch, c);
> 584     		}
> 585     	}
> 586
> 587     	key = bootmenu_conv_key(c);
> 588
>>>>      CID 644833:         Memory - illegal accesses  (NEGATIVE_RETURNS)
>>>>      Using variable "c" as an index to array "_ctype".
> 589     	if (key == BKEY_NONE && isalnum(c)) {
> 590     		key = BKEY_SHORTCUT;
> 591     		cch->shortcut_key = bootmenu_conv_shortcut_key(menu, c);
> 592     	}
> 593
> 594     	return key;
> 
> 
> 
> View Defects in Coverity Scan
> <https://scan.coverity.com/projects/das-u-boot?tab=overview>
> 
> Best regards,
> 
> The Coverity Scan Admin Team
> 
> ----- End forwarded message -----
> 

