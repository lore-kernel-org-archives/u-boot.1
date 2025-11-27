Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18B2FCFD2F6
	for <u-boot@archiver.kernel.org>; Thu, 27 Nov 2025 18:40:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 57BF48430C;
	Thu, 27 Nov 2025 19:40:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="x6lXjwNp";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="xD5A05xw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76918844AE; Thu, 27 Nov 2025 19:40:29 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59505842A7
 for <u-boot@lists.denx.de>; Thu, 27 Nov 2025 19:40:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4dHQGg0mWfz9scY;
 Thu, 27 Nov 2025 19:40:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1764268827;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P/aNbC1YP94TLpnBwQ0ic36ulr4ymb/eeCXHL3OtXW0=;
 b=x6lXjwNpkZPLzl8hFHPzPFtPpl/ej6SJJ1j1DjE2Uu8tcxiL/EWKNT9p2dVE95wCluo4Fz
 Ue0yJtuS/TpnYHEyOxJ/4qDEyNFF2T8DmYTLMzIK2Q5O8xh/Ze+91UNUjwxTRFDbY6lFVM
 lGVIWSruhCZw+WpZZp6mAtkmi5HNh3xtj7m6fnm7/enRkx3CvF881tnQbwL7StdPb+6CMy
 VO7TrosKOuiUpW4BMHA5P2Q9eaOOJ5WKjJnBL/lyQAwj98O/m+jpRcm1hnb/BkrnZwuQme
 PY6m7LUzEvxKvJfgDDPwgGhAgm3HDsh1dIQPvyXo95//I0oIhGP57Vy3qGGTJA==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=xD5A05xw;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <d4b29293-3858-4168-b964-90421f98e9d4@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1764268825;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P/aNbC1YP94TLpnBwQ0ic36ulr4ymb/eeCXHL3OtXW0=;
 b=xD5A05xwvgjyGNprN5lQNjIny4HRHnU+z1/5S/Y/QCzv31ltZcatqruLULjklxkfqLSHlG
 DVSRi9qSWbhm5nFEKnlLL4woaL5u2M/WCQ7oOiE3s2YkvaHOT0QDSWqyEMKxGnZ1HI1t3B
 62HNW4fa+dVdfkqYNvcEd4oz9aJ7tjXg38mTY3lEdtU2MWFH2+YGvOcLzCozDqibgIH8Xq
 80eHzmrJzOLZd7xZ0YGuKZZqlQnTCFkqrmttlk2iPYDYlxvuzvA4JD1Y79pHLuzILzS7mF
 3eV9tQEzeMMM4GlttvVgiwMI0ONjKjFbcXGz0X08g8B5c7hq7KyIBjsqyDoBvw==
Date: Thu, 27 Nov 2025 19:40:21 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] imx9: scmi: soc: USB instance number change for silicon
 revision B0
To: Fedor Ross <fedor.ross@ifm.com>, "NXP i.MX U-Boot Team"
 <uboot-imx@nxp.com>, u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Ye Li <ye.li@nxp.com>, Alice Guo <alice.guo@nxp.com>,
 Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>,
 =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Rasmus Villemoes <ravi@prevas.dk>
References: <20251127-imx95_b0-v1-1-fc3bd2ba1b56@ifm.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20251127-imx95_b0-v1-1-fc3bd2ba1b56@ifm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: b7426b9c129562624ed
X-MBO-RS-META: ufrnp4n7b9um99tsmnr4nuct1sc164z4
X-Rspamd-Queue-Id: 4dHQGg0mWfz9scY
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

On 11/27/25 6:50 PM, Fedor Ross wrote:
> For silicon revision A1, the USB instance number for USB1 is 3 and for
> USB2 it is 4. This changed for revision B0 where the USB instance number
> for USB1 is 0 and for USB2 it is 1, which is the intended instance
> number. Select the correct numbering according to the selected revision
> in the defconfig. The config for the B0 revision is IMX95 and for A1 it
> is IMX95_A0.
> 
> This patch is based on the information provided by:
> "AN14750 Migration Guide from i.MX 95 A1 to B0; Rev. 1.0" .
> 
> Signed-off-by: Fedor Ross <fedor.ross@ifm.com>
> ---
>   arch/arm/mach-imx/imx9/scmi/soc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-imx/imx9/scmi/soc.c b/arch/arm/mach-imx/imx9/scmi/soc.c
> index dbaa19a9e6e..354df7d88a4 100644
> --- a/arch/arm/mach-imx/imx9/scmi/soc.c
> +++ b/arch/arm/mach-imx/imx9/scmi/soc.c
> @@ -921,7 +921,7 @@ enum boot_device get_boot_device(void)
>   		break;
>   	case BT_DEV_TYPE_USB:
>   		boot_dev = boot_instance + USB_BOOT;
> -		if (IS_ENABLED(CONFIG_IMX95))
> +		if (IS_ENABLED(CONFIG_IMX95_A0))

It seems this can also be made even more generic:

-if (IS_ENABLED(CONFIG_IMX95))
+if (is_imx95() && (soc_rev() < CHIP_REV_2_0))
