Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01BE0C79F9F
	for <u-boot@archiver.kernel.org>; Mon,  5 Jan 2026 14:51:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A3C28399B;
	Mon,  5 Jan 2026 15:51:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="pzPViJNW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DDE0B8399B; Mon,  5 Jan 2026 15:51:40 +0100 (CET)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B97BD83D8A
 for <u-boot@lists.denx.de>; Mon,  5 Jan 2026 15:51:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-3e3dac349easo15530485fac.2
 for <u-boot@lists.denx.de>; Mon, 05 Jan 2026 06:51:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1767624692; x=1768229492; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CL520vPS2yLS8tn8RvYcg3Hc4I0AIJBmWlu9T0ItVg4=;
 b=pzPViJNWkLFS54kS8N9ELnypfV5EFT/uYqKXObBTVpxkedNM1eghdfFMTwj5n4YVH4
 Dk8MQMkOdS2i1lxbMPTymZstSnxxqWqlV1iu4RL5XrLMlkl930trdKJxfWYf7BG2EUYw
 WM3R+MqBEvfus9vCi3XmM7DWw6sHAxVM0HW7E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767624692; x=1768229492;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CL520vPS2yLS8tn8RvYcg3Hc4I0AIJBmWlu9T0ItVg4=;
 b=fczes/dupDs5EBSOtlh3CErjCPm7ei0g5Ezs9HILL+9B5dYbl0JqmzkTpOEblqxpCJ
 ZsIUllcsEUgGkEVYLtO281/PAW7QP68GXFc2lNYQgcxb6qB9rhkNTf8zz6y1jgFh+Rld
 bBTAZOO0R6+TmgA8f9xSH4nIzvKBtYLt2WOU+vLIPhHWiSIYnNx84EiaHRQusesb7U/P
 2c1SRcaHZ3EiWkDXHSTJixw4p2Uy5j9mo9YKWQwiSkgZMOBIvKu5QJQw/7tuTWmY0a9h
 FpLEYZtZdx1dCZJPDQxgu425Gy2sOfoDyDtBIakRX+P2hvjsUTkeJtXpKkC/9Eo/wC5Z
 VYWA==
X-Gm-Message-State: AOJu0Ywj7UZKfMzdEjL8T4LJ0/G3pNXT8uDPfeDRXwZHgD4V3Il2/ZlG
 YI/+cfbprrYlbD6pLdzNQpsM8vgg51q45v+UIVN3NO4e3o3lUBKG9qh7eSbifxoVBsGR/oUdII3
 PyCPgL+4=
X-Gm-Gg: AY/fxX46FW/jjmamr/ta0ebiy3+IBtDvCC8JJr3aZyT17K4ZNcsTpcf9vtt6GY6i0ke
 EBmG34u3rAB4TgxgjaMzJHD6N8hR/OnoLrkkDI4DvwWPmET58b/qVauKHisLFxESvGUWAfhC+FD
 JqgowDV3USiWhtWKL8qQ1ljo+bnmE01buMX9qWXE1dzHH+NEIQDmC4w9pvJjxg4+++I9OQ7K/7m
 MJiRFZwzpKNU82J3IfCjn45vdSqpnDlP2ljhLfhTCR1tcQ01n4GqCOWpDh6yip7fqQfmMVpyg9S
 2SDQZ3j7MMKO13alCDQFNeD2Mssn1lQW22aMrNWsI5on4A0sDWa7D9jteH5w+2/IqgPQDnV7zc0
 DQxeVyjQuRufVoiS+HOlHHX0bJV7qpPebwdWruBhqg7YoCN+OdMDxSIIPFbLVFCdKbthGOo8ziX
 Gn75chXvZBcm4+KKyfiKpP7bge8WuYCvYQ2XTYMD5gVcMfCRV308DV43XEQDoLszXfHGsFM9udL
 TOPtUfZFOEjgdC0x0jhgpn9Xlh3V6KThNazDQ==
X-Google-Smtp-Source: AGHT+IFGll+u2L+MqrGNuYx7BXKddklAKbPpmfR5ityH+c+L3XXUvy0rpl7hh61+lpBDqrcNLeQd6A==
X-Received: by 2002:a4a:dc4c:0:b0:65d:d0b:fd26 with SMTP id
 006d021491bc7-65d0eb72f9fmr15047334eaf.61.1767624692390; 
 Mon, 05 Jan 2026 06:51:32 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-65d0f69ba9bsm29664806eaf.10.2026.01.05.06.51.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jan 2026 06:51:32 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: u-boot@lists.denx.de, Patrice Chotard <patrice.chotard@foss.st.com>
In-Reply-To: <aVs1BjbeFktmzmPi@nxa18884-linux.ap.freescale.net>
References: <aVs1BjbeFktmzmPi@nxa18884-linux.ap.freescale.net>
Subject: Re: [GIT PULL] please pull scmi-master-2026-1-5
Message-Id: <176762469178.3193712.7842315368846944961.b4-ty@konsulko.com>
Date: Mon, 05 Jan 2026 08:51:31 -0600
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

On Mon, 05 Jan 2026 11:50:30 +0800, Peng Fan wrote:

> Sorry for late for this updated PR regarding Patrice's fixes.
> 
> Please pull scmi-master-2026-1-5
> 
> -----------------------------------------------------------
> - Fix non-CCF priv initialization in scmi_clk_gate()
> - Fix typo in scmi_clk_get_attibute()
> - Remove duplicated scmi_generic_protocol_version() request
> -----------------------------------------------------------
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


