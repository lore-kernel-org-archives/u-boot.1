Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64BB6CEF17A
	for <u-boot@archiver.kernel.org>; Tue,  8 Oct 2024 14:29:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D121788D5C;
	Tue,  8 Oct 2024 16:29:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1728397782;
	bh=az1pLypc5txBLkKV6ZCr4JZemDuLyuxHuBoUehvYb50=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gcS4188kvOJWqJbliYfqzP4CKPs1YrH76wtNlNJQNVQ1kCpSoo0Ahv90oto+49QPj
	 P+eXOltLqmVjmEVLqYPSsaZhlDPXe03awfoDeJpPgOlYnVmhMRD3MhlfOaIZfx5XG1
	 TPzT2oR+WS8NrqwMQq55wsuYe6KWkKjlV22yejzV901mU+9/W/acBffNHA6TZuEYTZ
	 xcIMh1Cj7yFqkso9P5roFRet4+lvnWRCr5rHzbFEKQ+5bdHlSVLNTzshENjTUxrO0C
	 aMyAcf7ylS2W6H4wyKhEvAdDv11DRNQijYCzcYN8yGsXyPo/+cUYWR5cgZBOpXIaNt
	 uIQYs8GOEF/1A==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id EB2FA88B8F;
 Tue,  8 Oct 2024 16:29:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1728397781;
 bh=az1pLypc5txBLkKV6ZCr4JZemDuLyuxHuBoUehvYb50=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Yu20jGKPvHcRzQTnh/LLt9frGLWME747krEz914XVPXNZgFfTztunfVzWe9pLglER
 HJ7ehsn11ElKCOFtgHkMZdJ9iiqwpbVz0Vmn6KBaf85G9QUdZgNClIQr/2FnOWTWZu
 X96ELSep7Xxr0tHB93a8sr0+SwPGNryuhrxAM30YZ3Yh+gUJA/OzWhOakiDQDPbOEI
 CBFY20zjlRcflGSZLawWUIW3nNW2L7IEiegrssorS7PqEGQAnwZxPqquBAWDoU+ARN
 zW95eHpIKzZMroDr2H1TfGJfNgB/zc9WDefozxVVbgBzeOTlIbzv53NolPvVceCgkF
 SgZXe92IWwL7w==
Message-ID: <647d622e-c99e-42fd-8b39-2c69db029cb1@denx.de>
Date: Tue, 8 Oct 2024 16:29:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] dts: Add ability to build fallback DTBOs from
 arch/$(ARCH)/dts
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de, Sumit Garg <sumit.garg@linaro.org>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Jonas Karlman <jonas@kwiboo.se>,
 Lothar Rubusch <l.rubusch@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Simon Glass
 <sjg@chromium.org>, Stefano Babic <sbabic@denx.de>,
 Tom Rini <trini@konsulko.com>, u-boot@dh-electronics.com
References: <20241007120002.25690-1-marex@denx.de>
 <CAOMZO5BX3EvcGAJjKNt-vX9+9se9nzmf19_-4f4gfS59C9Q8Sg@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAOMZO5BX3EvcGAJjKNt-vX9+9se9nzmf19_-4f4gfS59C9Q8Sg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 10/8/24 4:16 PM, Fabio Estevam wrote:
> Hi Marek,

Hi,

> On Mon, Oct 7, 2024 at 9:00 AM Marek Vasut <marex@denx.de> wrote:
>>
>> Currently the enablement of OF_UPSTREAM results on the build system
>> searching for DTs only in dts/upstream/ . There are platforms which
>> use U-Boot specific DTBOs applied on top of U-Boot control DT during
>> SPL stage, and source DTs for these are located in arch/$(ARCH)/dtb.
>>
>> Add dedicated 'dtbos' target which builds only .dtbos and not .dtbs and
>> in case CONFIG_OF_UPSTREAM_INCLUDE_LOCAL_FALLBACK_DTBOS is enabled, build
>> this target for arch/$(ARCH)/dtb to generate local U-Boot specific DTBOs.
>>
>> Adjust top level Makefile so binman would search for .dtb and .dtbo in
>> both OF_UPSTREAM specific paths and arch/$(ARCH)/dtb for the .dtbo case
>> in case CONFIG_OF_UPSTREAM_INCLUDE_LOCAL_FALLBACK_DTBOS is enabled.
>>
>> Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
>> Signed-off-by: Marek Vasut <marex@denx.de>
> 
> This one no longer applies against the current u-boot/master.
> 
> Please rebase and resubmit.

Wait until "[PATCH v2] dts: Deduplicate dtbs target" lands, then this 
should apply too.
