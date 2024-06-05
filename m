Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C4E8C25B75
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 05:58:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8FC388842A;
	Thu,  6 Jun 2024 07:58:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1717653493;
	bh=ZrGP8t5uOZO3L2+sP7eXQ8irLZdrNwJQtV8VZ4tXa28=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ELjU7FvSTh5WGtbQvKnrEBS+Y49wchmEhJDVW0OJyIqrG5RCofso+juhlY64jii3H
	 FjYeehDcBwvliefSQCA5Qi6DlUdPzbSZpqdkA2FduAic5tsprg6sLmC1gwTXC7wVci
	 c4Q5s49n73NBvygfVA+HCSmtO8XYljmL+zFrHB1d0mPPjQsuoQQNz9Y4GIPnNEvBSd
	 jsGylT2FSQeCV2TvrcsgdfImGeX+g5TyLmMHBpwUsaNKETh/4zb/+DBOGpboGzGkMc
	 H1j2f7tvCLjZWgCWft9BxS0N9uI9I94SKj31JxK8X3ibE07Tc3sIeBUGgmDn25Gt0b
	 VTmZyq2LZ2W4g==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 39EEC88258;
 Thu,  6 Jun 2024 01:57:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1717631839;
 bh=ZrGP8t5uOZO3L2+sP7eXQ8irLZdrNwJQtV8VZ4tXa28=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=SqGKZArETKq2i/h8OKkSRaspNbrMrlB8hSSmjK1VeWFGVv6wgc7D7oIrL6D/n3w4f
 db3pmEjEb1IEYJRkZasl6gxFEPXZ/WBIEDHhEgCL8ka5y6K/i6jkGndgnswzLDVkD8
 Wr4wT6Dm7+cqyg68ZZpiWl+re84FfazNsr/43Cm7Zr9nVCJMfWIRfcndO0MpUBx13K
 X5esFtAlk88AIGwSmAm4CHDuMkmUynG/m1w2PmMAkLg4wbrcbY9KmHsuTCPshuHCmb
 opVE9p9j5eDvAK4vTSLwVxEVOjtI1ieF4b+IUt3cWXWiCbCMyVosr1qil3DqCeztWG
 OyBGl30oWa5sQ==
Message-ID: <1226f84c-7edd-4447-969c-ac3a955a4547@denx.de>
Date: Thu, 6 Jun 2024 01:57:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] usb: Assimilate usb_get_descriptor() to linux
To: Philip Oberfichtner <pro@denx.de>, u-boot@lists.denx.de
Cc: trini@konsulko.com, patrice.chotard@foss.st.com,
 caleb.connolly@linaro.org, neil.armstrong@linaro.org, sumit.garg@linaro.org,
 michal.simek@amd.com, bmeng.cn@gmail.com, ryder.lee@mediatek.com,
 weijie.gao@mediatek.com, chunfeng.yun@mediatek.com,
 GSS_MTK_Uboot_upstream@mediatek.com, iwamatsu@nigauri.org, lukma@denx.de,
 mkorpershoek@baylibre.com, eddie.cai.linux@gmail.com, neal@gompa.dev,
 j@jannau.net, sjg@chromium.org, teik.heng.chong@intel.com, jonas@kwiboo.se,
 nm@ti.com, seanga2@gmail.com, festevam@gmail.com, tharvey@gateworks.com,
 othacehe@gnu.org, fabrice.gasnier@foss.st.com, xdrudis@tinet.cat,
 marcan@marcan.st, richard.habeeb@gmail.com, artur@conclusive.pl,
 simon@holesch.de, clamor95@gmail.com, ion@agorria.com,
 miquel.raynal@bootlin.com
References: <20240604101811.76112-1-pro@denx.de>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240604101811.76112-1-pro@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Thu, 06 Jun 2024 07:58:11 +0200
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

On 6/4/24 12:18 PM, Philip Oberfichtner wrote:
> Before this commit, usb_get_descriptor() failed for some flakey USB
> devices. We hereby adopt the more robust linux implementation [1].
> 
> For instance, for the "Alcor Micro Corp. Flash Drive" (VID 0x058f, PID
> 0x6387), the following behavior occurs from time to time:
> 
> => usb start
> starting USB...
> Bus xhci_pci: Register 10000840 NbrPorts 16
> Starting the controller
> USB XHCI 1.20
> scanning bus xhci_pci for devices... usb_new_device: Cannot read configuration, skipping device 058f:6387
> 
> Signed-off-by: Philip Oberfichtner <pro@denx.de>
> 
> [1] From a38297e3fb012 (Linux 6.9), see
>      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/drivers/usb/core/message.c?h=v6.9#n781

Reviewed-by: Marek Vasut <marex@denx.de>

Thanks
