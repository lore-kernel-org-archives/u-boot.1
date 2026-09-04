Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F9BDC61DD6
	for <u-boot@archiver.kernel.org>; Fri,  4 Sep 2026 13:08:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 86D1340BCC;
	Fri,  4 Sep 2026 13:08:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZXXvw7YZxfMZ; Fri,  4 Sep 2026 13:08:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 777AC40BD8
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788527301;
	b=r3/jZZeD06KwmZ3RJ1BC87potN9Mc+iRNHuoxic3OsAqoI1HvToTJEGtEC4juO87yR0W
	 YHt9TxTHntxOG8pePbBEE3qpzaVwoO0WGBVk7WC+7YQzs/KOKoKp2a2eCFQlGKxTdC8mn
	 8A1nM+O7BvsbIJQbX3DLSY7lOu+uAUTSmPiogZyaKwrP4t740d5AokZx+vH930dJCvGJa
	 QLnYvfhPQpOebxeRWnNoThFRQG7ysCH51kCt7HM0AkO/TPyCEAb3CFTOg8muOGhVwP40+
	 LuucKH6eHrtBjzwc5vUEe1TNLYHGKJPIuluHH+QWSFnkFNlr+McfQNdDR7333uYjWCA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788527301;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=j77uisgPySrcXPjt25puujaN/jznKDcb6T12P3Ps6mY=;
	b=Wt97PSRdRrJ3rVzAI+u60Aln7+ew8v6aeMjiH+YaUPQo6YVFPgt8AA4P0BFzvawBrlJ6
	 6DGl1F+DlG1USMtKbuuR3ZxvWV0a/GjdWtrnqCsfY8iYMVKZ5d5Febryqz4S6J87YjfoY
	 p9sMN0KNVVMhkzhYxWZRVbE49dfAswfV2+vmiraShUvcV6cCFqdWAamOOrLtMOe50L2xG
	 ikSiyzp5G6KdR93yuqG9gPVLYsEGgVC+FRczwHes0K11AGtBJj4vKsjbRqxSDrqHXtRyv
	 AmNUbwGjMzdr92sFZkalN3ylPmsx4lw+q34+HVHH6Cf99lbnlkoXZkKb/twh1DuyuzQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788527301;
	bh=j77uisgPySrcXPjt25puujaN/jznKDcb6T12P3Ps6mY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qF6K5s9lcsbWbZxLAgT8ejkbmeRpRJhh8xYMHQqyL1QUjxjBK95F11FXu7XBvfa4s
	 iOnRK3tFTCiukxboQkOGybK02g8QGNeRb4HeAXLfCnME0wrlcnCoWWMkgBuuFL/xMh
	 cRgKuPZAtA6NC4RbvH9tIHtG707VA2Wj40q0nT25MqFRFhqDXraVmK047L+pwhGS7o
	 eXs3xu1jU53LeyMi2b8iBR3cJlvhLwsGA/CiXs7lJWTZ9a7IIopAaZ4FBx9dELXA8T
	 8hE5K/mk+NS1FcE/eRIdxkewdrNfLQ7oUfDrOtpuYpNgwL2M141lf0pWhYQEzcyrZO
	 2kHUVlKJgyBhA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 777AC40BD8;
	Fri,  4 Sep 2026 13:08:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 7818F3AF
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 11:55:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5E6D94031A
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 11:55:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5yp2KZ2DkrFN for <u-boot@lists.u-boot-project.org>;
 Fri,  4 Sep 2026 11:55:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org AE27040080
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788522903;
 b=gpH5fTBl8xZ+OmhaO2IclLC0IZ+P6rm99zhMU8ySVeD9EVDwWClhQJkmOrHy1dGCnlZA
 HXTDCJevV03q10H27v2+aqPs0bRTaBX86mopO4sQHnNCZ9lbbd6dXZl7t/axTHwL0l0Po
 edGOXiv9D+aeDassVjBs34u2g2lDersI2jJKhq5A1ZykT+qpCChMkCXDA8qWzfUAVt+eV
 a8qrWE4hKVC3aA7ZR8M+5Hfok/e0NFyx3BeS6+7bVcaJHHwB0iplnMP2aZYDlh0LAWbxz
 dcqH72QqHSK4ww556Hvzj1l9JqFSHMrbhqpeNC6y1314nVzxBfJd9nmF80pRygw81fQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788522903;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 In-Reply-To:References:Date:Message-ID:MIME-Version:Content-Type;
 bh=j77uisgPySrcXPjt25puujaN/jznKDcb6T12P3Ps6mY=;
 b=FG+poYtZBDfnImZyjpJyuSW/E5yS16l76Kf1PPhc4fHHjJcsdl+h9gFlGIbh7Wz+kY8i
 SxXr0S/6v2y7pl7JhjCWBGNIfMemZVptziCev74+Xftihfnarg6WGpturEipTKfixtL+N
 KyPUWWqivZLHhB0S4KBCR3sdZITmaKPvUdU7NhJwFi5M2tRAOidwzzTGrCsy3pGs/pAVJ
 FDylrIHsc5UFwtJO3rTEr/lh8CT+M4tNT/OtyO4ZKPFpEkDSdDkV1kow6o0Z9yIXS30sY
 K3iMU1p2icY4MtBC2VmNwIirG80dOFaMaKZvN5mzt90h1gE1+e9oeragyuVrx4JMLIQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Ld1+n9tw; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=Ld1+n9tw
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AE27040080
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 11:55:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7DA6D6022B;
 Fri,  4 Sep 2026 11:55:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 692241F00A3F;
 Fri,  4 Sep 2026 11:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788522901;
 bh=j77uisgPySrcXPjt25puujaN/jznKDcb6T12P3Ps6mY=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=Ld1+n9twArIPPDc5UByl1Q0780jxlyv7+83GDV45LqtkOQ+VM6S7yNIM2A6e0uJGM
 FU1DHvUJWdzyQTpFydCK2ArLBwgrA4YSp3+LIW86Be6PEGnXZsnhShTT0pQrH9sAlA
 kvYbxcmbZH6m0SoY0G7do/25dIJSljTXF9/l77MzDZB3vCl9+0+t0Z3r3tguA76g1+
 hDSYSDtDt6mlu2hvf0ZyQSstCBYNOOQixnGxY8TwQItyGAev61hULlyZqAVTQBaO87
 2Vtj0geux3wX6gS6qZVon8wYMM2dJoDVdIDK+j79RxYcOuwK6PKCIk2cwU0Vxrx5RK
 K6JZzfz29nXlg==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: David Lechner <dlechner@baylibre.com>, Jaehoon Chung
 <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, Ryder Lee
 <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, Chunfeng
 Yun <chunfeng.yun@mediatek.com>, Igor Belwon
 <igor.belwon@mentallysanemainliners.org>, Julien Stephan
 <jstephan@baylibre.com>, GSS_MTK_Uboot_upstream
 <GSS_MTK_Uboot_upstream@mediatek.com>, Tom Rini <trini@konsulko.com>,
 Julien Masson <jmasson@baylibre.com>, Bo-Chen Chen
 <rex-bc.chen@mediatek.com>, Jerome Forissier <jerome.forissier@arm.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, Joe Hershberger
 <joe.hershberger@ni.com>, Christian Marangi <ansuelsmth@gmail.com>, Yang
 Xiwen <forbidden405@outlook.com>, Marek Vasut
 <marek.vasut+usb@mailbox.org>, Bin Meng <bmeng.cn@gmail.com>, Sjoerd
 Simons <sjoerd@collabora.com>, Eugen Hristev <ehristev@kernel.org>,
 Claudiu Beznea <claudiu.beznea@microchip.com>, Casey Connolly
 <casey.connolly@linaro.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Quentin Schulz <u-boot@0leil.net>,
 Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Chris Morgan <macromorgan@hotmail.com>, Ryan Chen
 <ryan_chen@aspeedtech.com>, Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Dylan Hung <dylan_hung@aspeedtech.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>
Cc: Macpaul Lin <macpaul.lin@mediatek.com>, u-boot@lists.u-boot-project.org,
 Stefan Roese <sr@denx.de>, Bhupesh Sharma <bhupesh.linux@gmail.com>,
 u-boot-qcom@groups.io, David Lechner <dlechner@baylibre.com>
Subject: Re: [PATCH 07/14] usb: dwc3-am62: check dev_remap_addr_index() for
 NULL
In-Reply-To: <20260903-b4-dm-addr-null-checks-v1-7-db945bd5e712@baylibre.com>
References: <20260903-b4-dm-addr-null-checks-v1-0-db945bd5e712@baylibre.com>
 <20260903-b4-dm-addr-null-checks-v1-7-db945bd5e712@baylibre.com>
Date: Fri, 04 Sep 2026 13:54:58 +0200
Message-ID: <87wlt1qlil.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Mailman-Approved-At: Fri, 04 Sep 2026 13:08:18 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi David,

Thank you for the patch.

On Thu, Sep 03, 2026 at 16:35, David Lechner <dlechner@baylibre.com> wrote:

> Check the return value of dev_remap_addr_index() for NULL instead of
> IS_ERR(). This function only ever returns NULL on failure.
>
> Fixes: 92114d7c0a19 ("usb: dwc3: Add dwc3 glue driver for am62")
> Signed-off-by: David Lechner <dlechner@baylibre.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
>  drivers/usb/dwc3/dwc3-am62.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/usb/dwc3/dwc3-am62.c b/drivers/usb/dwc3/dwc3-am62.c
> index 8cb5796b6ad..57a34d69fbe 100644
> --- a/drivers/usb/dwc3/dwc3-am62.c
> +++ b/drivers/usb/dwc3/dwc3-am62.c
> @@ -46,7 +46,7 @@ static void dwc3_ti_am62_glue_configure(struct udevice *dev, int index,
>  	struct ofnode_phandle_args args;
>  
>  	usbss = dev_remap_addr_index(dev, 0);
> -	if (IS_ERR(usbss)) {
> +	if (!usbss) {
>  		dev_err(dev, "can't map IOMEM resource\n");
>  		return;
>  	}
>
> -- 
> 2.43.0
