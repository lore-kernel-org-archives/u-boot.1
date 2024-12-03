Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FC09E6C5EA
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 02:30:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51EEC895D0;
	Tue,  3 Dec 2024 03:30:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1733193030;
	bh=Whyv2yVNfVDKQyKFan7bgqcv7dfKFWt2DrYh+B+W0vw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=k3tKBlNs7KLdOf4yyeTa9YolIEdcoGEUCMWvH3BRGzhZLXeqQ+njpQvRSSWA/Bdyt
	 +OZgIRekvidIihWEb2Q0s7UgJROzY7CJdpiKtZbCVK1cIhM3xpdul72L14Zh+Kem0i
	 aQP67L/rNJBrw2KiAd+8S1SRD8j3dKNGariwGUBFT+iz9D0IhT/OeId4Tt3tq6+gSL
	 qLEkZxfEV4dpEY9+A0W6HJs2MKScHV7gxBYNMbCSu8u3AuIcC+J0fVq6PvVdi+1vr0
	 wARHkvT0mXwxErxoQH37v0Y+J/FAn7h0g3w9yECZM+FFctTl2LvFklFaF9ZNi2FvUH
	 P/iVovSvAruZg==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 6E2C788815;
 Tue,  3 Dec 2024 03:30:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1733193029;
 bh=Whyv2yVNfVDKQyKFan7bgqcv7dfKFWt2DrYh+B+W0vw=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=y/NfvyP8g4lF5W+wLWmsoTIQPvkffjLXzIL+ZqAqUDJVl1PY5zEiawAGukd0yvFtM
 Phqx+HTRBatoW2fJd9RUA9BrQDCCLHw+pxQGuKVl2x+e55BKOtQhyQa6d0WK+ngEtb
 FV8X0Kt7l0B/cs2gK1zFXzRjbFCSf7LSfIKnSYQLf3RWKbZQIfmMts5+IqMV//twL2
 U/O3roQeAvYaXhh6v7gXGCSOj03Rqd1ia05N5vuJkL/fbYgJEdGHcgifrgS8YTVm3n
 ipdfZhHW7qIpLyR58pi1DKxT3GSJMNxvzMpLieE3FRJwbn7g0qmsV8yrP0GZmJiLym
 isJe+6XHx37+A==
Message-ID: <7e22db87-96bd-4046-b08b-070e8be00624@denx.de>
Date: Tue, 3 Dec 2024 02:02:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] usb: gadget: f_mass_storage: Add schedule() in
 sleep_thread()
To: Patrice Chotard <patrice.chotard@foss.st.com>, u-boot@lists.denx.de
Cc: Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>
References: <20241202074644.5380-1-patrice.chotard@foss.st.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20241202074644.5380-1-patrice.chotard@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 12/2/24 8:46 AM, Patrice Chotard wrote:
> In case "ums" command is used on platforms which don't implement
> g_dnl_board_usb_cable_connected() and USB cable is not connected,
> we stay inside sleep_thread() forever and watchdog is triggered.
> 
> Add schedule() call to avoid this issue.
> 
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
Reviewed-by: Marek Vasut <marex@denx.de>

Is this a bugfix for 2025.01 ?
