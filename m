Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64124CD5BB1
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 14:01:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8A9384702;
	Tue, 26 May 2026 16:01:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="U3C615kd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B77F4847AF; Tue, 26 May 2026 16:01:46 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6AEBC846BD
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 16:01:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-bcda7765d64so2085452366b.1
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 07:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779804104; x=1780408904; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xRydU8EMhORDhNpc57XipyqgwwzZAAnUJxqPvF9GYQo=;
 b=U3C615kdf/dr/K95Jy2sDJPDmxffr+NdU4zu3/Sq9vJboLiyBxk3Nj4nmDFGVcrPAY
 pn7P4m7+xirLE4SGnPfTCZxY8jH/V97t2ulE6aiYcnPYa1Ugvvi5Jnz5wuW3Zltit8F4
 H88posSMDxLHEDFCt3+h46hTgZz9rQCPMuQiymc7ASV8SQrgdwV1X+qmHcHnIIwFms3B
 Hmvmpm93VIzZwcz+lL582li0CpHwC1GgzcptTjMajvFJ0007GVzyVkr2cKA0c6mLzg+G
 0nqnQ/hD5wHDYgxfVK4ivI8kxnjsBUE5APOo8tzANIFjoWsIDKbXsF1a4qlJJq5tGtZ7
 cOAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779804104; x=1780408904;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xRydU8EMhORDhNpc57XipyqgwwzZAAnUJxqPvF9GYQo=;
 b=WZyfr5Qn3e9CrJUxixnCNPQ20NEU+C6usfQKY32J1wagjOWchNrvofcPgHJPKzIJ2D
 yvHUZVi31aD8aLKlz3NS9lDSmdIDOuaJS3FEPwF+KF/5HHwyZDS18faQGC0GqCJxO/dk
 6oH0hM87gP1360mcdYb7AYFEN9MlwmQpYqH0Ip9Dz6T7xM4XdvM0CUtYzavP+dvWyVzC
 oXEuJ4mNYURP9R5m18DQQa2318omk6p+i/OkwohpGHqpAAp4Kq8ZPiuTMUIz3IRiBkbr
 7zTQchLzHmAIvndKJAjPVQBrzf0wRUf41/P2+6S9Nzb27gmIQD5myOqKisualqRiAP/w
 8Iig==
X-Forwarded-Encrypted: i=1;
 AFNElJ8Rq0MYcgbuAZ+NmFWpavWxpyE9UEm1JWRQINs81ewxmAb70Qezo1fG3aWL1CDWZ8nsJXo7W3o=@lists.denx.de
X-Gm-Message-State: AOJu0YxOqUZHH9gYoNrIsm58BUlBOE0XWIggTeWQAneS/8XpriaW0Kcn
 deIEOrq7Bx99lMOniqqMgKXO0NLXDVY6y5VO3YMoW27yEUm5yDa/wkeOn+zpocd5KWA=
X-Gm-Gg: Acq92OEfpnVxhi1aCwJL97znmHmJ1JERPGX9yVffwxgNJWnPh5dwJbqxNW4WWKBFS4W
 kapxg0w2Jl2gQoxYEPLz02/wcu+dNl7OaKON1vdxSbdFCGaaKFqQ+cn5gt/zKESlTPq03SPAiEl
 vuwQkJOdhlx+yIeP1IMaylALoo2Gh1oQQUBNP5GTQMEoLxUOg3ZVWiP/EGB5b4+xtizo43VRhv7
 L9Na2DmMvOgP5bcIRc0D8KnCqQyZT286tyJ6IcLFAspphuA2eijXWwAbcM32NMXObA0LuHAQGPd
 eDvxXVp0wH+SJBghI763g9TAlz6AAWJuRQqtGFRuhCLwS97MXF3xXmPlgpB1ZU+uE7Cc9FdW8hU
 LvK/sDVIDMUa2I+dV75lYlR9UpWs6HHn3hI/3qR2apn4s8tZ19ustbD2SyONfmTiPjgv4qwLdQr
 p6eZjMhcTxHY2iW2YROCL4JQ3v3u9usKGglqRYmEmHKHFfNKxe61Pqe5pUV+wM8fY=
X-Received: by 2002:a05:6938:a00c:20b0:bdc:e716:2806 with SMTP id
 a640c23a62f3a-bdce7162a0dmr819239666b.15.1779804102849; 
 Tue, 26 May 2026 07:01:42 -0700 (PDT)
Received: from [192.168.1.36] (p549d4239.dip0.t-ipconnect.de. [84.157.66.57])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6ccd04dsm34752661f8f.9.2026.05.26.07.01.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 May 2026 07:01:41 -0700 (PDT)
Message-ID: <ed4c5917-9f37-43e7-97d8-bb9f9e3af77f@linaro.org>
Date: Tue, 26 May 2026 16:01:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] Add regulator support to qcom-ufs driver
Content-Language: en-US
To: federico@izzo.pro, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Julien Stephan <jstephan@baylibre.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>
References: <20260523-qcom-ufs-regulator-support-v4-0-45639533b06d@izzo.pro>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260523-qcom-ufs-regulator-support-v4-0-45639533b06d@izzo.pro>
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

Hi Federico,

On 23/05/2026 15:04, Federico Amedeo Izzo via B4 Relay wrote:
> This series enables UFS support on SC7280 devices with UFS3.1.
> SC7280 devices with UFS2.2 were already working.
> 
> The root cause was ABL leaving vcc-supply regulator disabled on UFS3.1
> devices, and enabled on UFS2.2 devices that worked fine without
> regulator support.

Thanks a lot for working on this and finding the bug in the regulator
driver!

> 
> Signed-off-by: Federico Amedeo Izzo <federico@izzo.pro>

Reviewed-by: Casey Connolly <casey.connolly@linaro.org>

> ---
> Changes in v4:
> - Improve regulator mode fix: apply current mode during enable
> - Remove regulator mode code from qcom-ufs driver
> - Link to v3: https://patch.msgid.link/20260523-qcom-ufs-regulator-support-v3-0-1be2a80a2577@izzo.pro
> 
> Changes in v3:
> - Fix bug causing HPM mode not being applied. Removed LPM/HPM hack
> - Read regulator mode from dts property instead of hardcoding it
> - Link to v2: https://patch.msgid.link/20260521-qcom-ufs-regulator-support-v2-1-d3ec82ae5dbc@izzo.pro
> 
> Changes in v2:
> - Add vccq2-supply for UFS2.2 devices without internal eLDO regulator
> - Fix wrong topic
> - Link to v1: https://patch.msgid.link/20260521-dpu-add-dspp-gc-driver-v1-1-83372488cdcf@izzo.pro
> 
> To: Sumit Garg <sumit.garg@kernel.org>
> To: u-boot-qcom@groups.io
> To: u-boot@lists.denx.de
> Cc: Jaehoon Chung <jh80.chung@samsung.com>
> Cc: Peng Fan <peng.fan@nxp.com>
> Cc: Casey Connolly <casey.connolly@linaro.org>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Luca Weiss <luca.weiss@fairphone.com>
> Cc: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
> Cc: Federico Amedeo Izzo <federico@izzo.pro>
> Cc: Bhupesh Sharma <bhupesh.linux@gmail.com>
> Cc: Neha Malcom Francis <n-francis@ti.com>
> Cc: Julien Stephan <jstephan@baylibre.com>
> Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
> 
> ---
> Federico Amedeo Izzo (2):
>       regulator: qcom-rpmh-regulator: fix regulator mode mismatch
>       ufs: qcom: add ufs host regulator support
> 
>  drivers/power/regulator/qcom-rpmh-regulator.c | 106 ++++++++++++++------------
>  drivers/ufs/ufs-qcom.c                        |  25 ++++++
>  drivers/ufs/ufs-qcom.h                        |   4 +
>  3 files changed, 85 insertions(+), 50 deletions(-)
> ---
> base-commit: 744cf5d4e398c5f657e5c3eeb44d00fa5175dc85
> change-id: 20260521-qcom-ufs-regulator-support-466ea6ad202a
> 
> Best regards,
> --  
> Federico Amedeo Izzo <federico@izzo.pro>
> 
> 

-- 
// Casey (she/her)

