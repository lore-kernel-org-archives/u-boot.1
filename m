Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 549D1C25B75
	for <u-boot@archiver.kernel.org>; Wed, 15 May 2024 20:05:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD696882E5;
	Wed, 15 May 2024 22:05:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1715803531;
	bh=49L2fRL5+Dhg7ZhH72WS7WEYC0DYmIhuv9twjhqVYfQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=F6pHj1sRaCFnine8lHsKRtA61DCpYwmKcbo9nn+0TwHRX6SfUS9Ue1cbY+QXKx8sT
	 G9DWo5OK1rWE6knySxByYe8ZJa/j9N9u1/WI/hheGeF14/DBym2Pcsqc7EonPVemVd
	 tzPwWeaWV2Zl6sd8aS9aXFd6VncNtWWoSvj1EA3fnnNbFwvL2uIkLgCOunUerKWLHT
	 l7fVtaZ2XS82j26L6FtqBvMi7v+tRKSTlDSPHBQAoNzGWBk7XIdF+xeDgYkczubWLd
	 8MCq0wIvMSR6Xn8qfzbPKNu54hKXpCuSgkdnzGRavUu/MwUXuwHb6zIBqS3xB8c5gp
	 B6FZQRKItCPlA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 27A28882D6;
 Wed, 15 May 2024 22:05:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1715803530;
 bh=49L2fRL5+Dhg7ZhH72WS7WEYC0DYmIhuv9twjhqVYfQ=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=L+GAbb0uqvugX8LcvkTBHJFYINDGUJjYGhQ4+ve3AbWOOpG/ijBWxq4RLjUhJVJiE
 VOV7dBlzxpvx2BUvov8uJqr0nXGMjChQmsGvgLRx+DRXs6QMAUNLPrLRvUw5Ypx5jo
 7F2KMLrfwZT6f1ilM0jIR5/ckOFdL6scBu6ZAYnjQEgE8Q3+pFTnwDAo+KgJ3vTXnz
 yZwmdsGlBSpC5Z0p2bRRf0NwbtbH9YAvC+1uTO/6X9dgxay9LDhJesiudfB4iD8ZLz
 HfXYG9I0mrrKe+GaO76H3KaN4knEAmvhIv/rNHnmR7/8lBM5+wBZASM9MznaSt3qAO
 lDHMxAG/Eu60A==
Message-ID: <9d4a93df-0976-44b9-9f5d-6a946aea99a2@denx.de>
Date: Wed, 15 May 2024 22:05:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fdt: add kaslr-seed if DM_RNG is enabled
To: Tim Harvey <tharvey@gateworks.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Devarsh Thakkar <devarsht@ti.com>, Hugo Villeneuve
 <hvilleneuve@dimonoff.com>, Eddie James <eajames@linux.ibm.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>
References: <20240515002248.2920155-1-tharvey@gateworks.com>
 <039c0adc-3014-4ae7-99b3-0df9e5366b79@denx.de>
 <b16b85dc-90bf-463b-a206-06d98c3c1f0e@gmx.de>
 <CAJ+vNU2yjkFpz4-WUDzJtwnsm4yi4mLk3HMK6J7J_Y38c6C2Sw@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAJ+vNU2yjkFpz4-WUDzJtwnsm4yi4mLk3HMK6J7J_Y38c6C2Sw@mail.gmail.com>
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

On 5/15/24 9:57 PM, Tim Harvey wrote:

[...]

>> The kaslrseed command similarly becomes obsolete with your patch and
>> should be removed. 'git grep -n CMD_KASLR' indicates which defconfigs
>> would be impacted.
>>
> 
> There are several users of this command currently:
> $ git grep CMD_KASLR configs/
> configs/evb-rk3308_defconfig:CONFIG_CMD_KASLRSEED=y

These four i.MX8M I can test (and you can drop the kaslrseed command 
from them, no worries).

> configs/imx8mm_data_modul_edm_sbc_defconfig:CONFIG_CMD_KASLRSEED=y
> configs/imx8mp_data_modul_edm_sbc_defconfig:CONFIG_CMD_KASLRSEED=y
> configs/imx8mp_dhcom_pdk2_defconfig:CONFIG_CMD_KASLRSEED=y
> configs/imx8mp_dhcom_pdk3_defconfig:CONFIG_CMD_KASLRSEED=y
> configs/roc-cc-rk3308_defconfig:CONFIG_CMD_KASLRSEED=y
> configs/rock-pi-s-rk3308_defconfig:CONFIG_CMD_KASLRSEED=y
> configs/xilinx_versal_net_virt_defconfig:CONFIG_CMD_KASLRSEED=y
> configs/xilinx_versal_virt_defconfig:CONFIG_CMD_KASLRSEED=y
> configs/xilinx_zynqmp_kria_defconfig:CONFIG_CMD_KASLRSEED=y
> configs/xilinx_zynqmp_virt_defconfig:CONFIG_CMD_KASLRSEED=y
> 
> While I can deduplicate code by calling a shared function in that
> command I don't feel like I should remove that command until the
> maintainers of the boards above agree on removing it from their
> defconfigs as they could have bootscripts that fail with the command
> missing.
> 
> I could add a warning print in the kaslrseed command indicating that
> the use of this command is no longer needed.

That sounds good to me.
