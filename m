Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E2A6E7B5F5
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 11:50:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BCE0B86D77;
	Wed,  4 Oct 2023 13:50:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=lexina.in
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=lexina.in header.i=@lexina.in header.b="BPcaLNr/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 700CF874CC; Wed,  4 Oct 2023 13:50:14 +0200 (CEST)
Received: from mx.msync.work (mx.msync.work [62.182.159.68])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B73CE86940
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 13:50:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=lexina.in
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=adeep@lexina.in
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 766E3FE4D7; Wed,  4 Oct 2023 11:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
 t=1696420210; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=XxUVsJJIJc1rvpKl2Qlby4KqXmIuq9s5BvqtsFO8Aec=;
 b=BPcaLNr/VC98tA+CXGuwo6yJZdAaqa031z49psX2SoX0SH4ITRFhtzGeZwBhs1pliY15Rz
 tYdMwtvvb9DXDBT763G+H9WFHWRj320Go7v9w2aNfmRcjkNh1kDTn9sNxEFsb5So8Yy02k
 LHlDeG70o2ypVIGFTr4YESKy9HOwCWAKE4i7VKtPO/1+CXIPah/IXRHyQ+ZH7R73pcgu2e
 DtMDD/9MeRhQpnzu9GwkIQqf/gRIkQg+HuUHhBtjXuZHenNq2SntWkFz9etUev7oHHUtMK
 ERbVSguLA9Zp7PmNVKQzsaL9vKhfiVdPziQR42JmlADoDUSAVPVH//h/esYmeg==
Message-ID: <92db249a-435d-483a-aeaa-50cd3a0c1adc@lexina.in>
Date: Wed, 4 Oct 2023 14:50:05 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFT PATCH 0/2] mmc: meson-gx: improve MMC reliabilty
To: Jerome Brunet <jbrunet@baylibre.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
References: <20230915160130.352099-1-jbrunet@baylibre.com>
Content-Language: en-US
From: Viacheslav <adeep@lexina.in>
In-Reply-To: <20230915160130.352099-1-jbrunet@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
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

Hi, Jerome!

Seems works for me. Tested on axg (A113X) and gxl (S905W).

Tested-by: Viacheslav Bocharov <adeep@lexina.in>

On 15/09/2023 19.01, Jerome Brunet wrote:
> Amlogic MMC on the GX (and later) SoCs has been problematic for years,
> especially with u-boot.
> 
> Linux has been fairly stable for a few years. It is using a fixed phase
> setting with Core = 180, Tx = 0 and Rx = 0 (the latter cannot be set
> starting from the v3 MMC IPs)
> 
> Still the results were not good with those settings with u-boot, on some
> sm1 based platforms. U-boot then started using a 270 core phase for sm1
> only.  This worked for most sm1 platforms but problems persist on others.
> 
> The proposal with this patchset is to use 270 for the ID phase, 180
> otherwise.  This works well on the platforms I have tested (Libretech's
> boards and VIM3L)
> 
> It would be great if others could test this and report whether this work
> for them or not.
> 
> If the results are good, this might be ported to Linux as well (... but the
> situation is less critical there)
> 
> Jerome Brunet (2):
>    mmc: meson-gx: clean up and align on Linux settings
>    mmc: meson-gx: set 270 core phase during the identification
> 
>   drivers/mmc/meson_gx_mmc.c | 50 ++++++++++++++++++--------------------
>   drivers/mmc/meson_gx_mmc.h |  9 +++++--
>   2 files changed, 31 insertions(+), 28 deletions(-)
> 
