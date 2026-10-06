Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F804CA5FED
	for <u-boot@archiver.kernel.org>; Tue,  6 Oct 2026 06:10:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B35364055C;
	Tue,  6 Oct 2026 06:10:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fXnF7NDIA6ZF; Tue,  6 Oct 2026 06:10:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org AFFCD40554
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791267035;
	b=XyGMbGL44zqld7f/5gabASG1BAZCAtwX3Z6BXBhsDar6tUDMIzAJ+m5Ntm4jTQh1SPO2
	 iLpCVcn39HvEsbOHqipNwinu85OQc2WgWHz87+ViKQPZm4qHxAPv3Jf3+qX5/h8Ut+wpl
	 gKVdSqjPVZQqbLrHdTvR02CQmTYZAi37lP1MtywwsLtfk9Z8hCuxG7tDtJF9DbK4xwJin
	 zM1t0e8ezfpbzoThqD+RGv9+6dI96d0Da5bS9kuppiHL8otzaqy7AMoLGNR70yKiryGRs
	 F9EOwt1N2dss4uD9DOWqrzr9vfQAUqb05JYCDqeZmRL/zrNMmtqVoApVZOZL2dzjDuw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791267035;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=e9fizxQseaWjdw4hSFtKkeXWCdljbl/btmdWlR/bRBI=;
	b=SaIqr5fsbwZLSGDQH2SjD+tkw9tYTbk7qeesyqOJCQKmGSB49I8CL0OA48liGuuoY/Ll
	 bifbfBdGkdmYgpZXl/2LAyzkB6UiW2Nj/4qcYxsFe3uNq1lG5sLQrrULsGUIJwuXX55wy
	 qgRzbJu6q9YDPe/R11aJq9vQZmusUAi3TNo7K1QIjo7lo6rvrqFzMMnxL45I2PPdHtKd/
	 z7vHTFQXJ/OQ8EsQJ+z1Ms0xZGWkfJcFU5amFJ79FZx4tIt4j5Scg6n3ETfeZmZ9pLONI
	 FXkZwBe5Xf1vKIJO1365bcH1jwQ2T33k+prrFeiusXtyqDYXg3ZUlZ76uUdelkKUbGg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791267035;
	bh=e9fizxQseaWjdw4hSFtKkeXWCdljbl/btmdWlR/bRBI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JliJw38KLTH7tsG85gF7ienT1YitQaaj4mw/P4k0AnftrEMcabcDm91GSPHKzY/Ly
	 T/pDk6CY6KzfzhAW+ULcrGm177tiHPeVVFJNm3Pax5GrhTr5mefH6e0YJG233APrYx
	 15FE79XQc54+zPD3qg3J8kvIxMakruuBxt66pxR77f1tsP+6nc5l3xgwy2gYvydHbe
	 BULmoEbg6aBI3JJyVwVhr+Jc5Qzoe8dYoorRq+cnB5Xp5NAUqKqpzNNGC3TGWfAE2e
	 wQ+0uPRZ74zDtDa6hDZ0OboWLxs57HZ9qsNlAZBP63lXg8ybErmVrfJl0qZKs3sSlZ
	 Igw0Kn38QF6Sw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id AFFCD40554;
	Tue,  6 Oct 2026 06:10:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 23C7432F
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 05:48:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 095AC808AD
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 05:48:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YU2jnrJh-dXn for <u-boot@lists.u-boot-project.org>;
 Tue,  6 Oct 2026 05:48:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 028FB808A0
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=80.241.56.171
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791265705;
 b=NcGODA3xSAhe6aCZm1xtOWI+IJ7ZcSHI4X56vaXy0shm1I/Vnjq3RAVZnTs+YeB81rsK
 lHK/51meIflqcKFw3ytEY75ahLwHNUFMYcyn+fS5bX5pjnazOEsM48yR3521BARDlwKEP
 G0FsMJHYH/obioYvtiDkjvbbOvluN7sjWFAsLvPKWfkHQry0TSOx03DAyxT/3p2iGYwj5
 QKGUMEyi12jU1zRoGNwbLOWsbcET1kkx5CDAtAyGljJlB/ooqFIMGYIhKO77KidKxOFRS
 k9WCsGoKtNRsUID961uSoZkIuElvIcoPG3HLHRhJ/KmqAKnrnC5GEMa0gMBJbLTTkJg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791265705;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META;
 bh=e9fizxQseaWjdw4hSFtKkeXWCdljbl/btmdWlR/bRBI=;
 b=okO+hiLUSKMOH+n0CA8HQB7wBJtC1qAHHCIawgObxDvV4f37b+r0zHG61wwo3IZSVCpg
 GMLoOpXgFc35bpTQx0gUoGhN56XB98dR8zLBOskRY318h2QnkAbDKT8nJMXoKkomDiASd
 N/xuC/uJ2wrNGGaxZSxMbiVtENUOst3KR2r5ioYxnjMU9nP75V2Q7rm1AcG5WqoDFxGOF
 tTHbqwXChm3FBsAYAwHV5OHoKLbtwogy6M0aG0pOtvTeoUH6d8PdkGkakBDyPR4s42jQp
 jvr+Km8OyG9IqMsotmuAKb46ce9MHTsiI1g86/p/CtWpY3i55gZVkTGDb3QWLePSYIA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=mailbox.org; 
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=Ae+XS0QE; 
 arc=none smtp.remote-ip=80.241.56.171
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.171;
 helo=mout-p-201.mailbox.org; envelope-from=marek.vasut@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=Ae+XS0QE
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 028FB808A0
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 05:48:22 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4hzQKH0n9rzMlM4;
 Tue, 06 Oct 2026 07:48:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1791265699;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e9fizxQseaWjdw4hSFtKkeXWCdljbl/btmdWlR/bRBI=;
 b=Ae+XS0QE+4Wh7FwpxdmxvCm3rbhzd9fKYPNx3Pm1V2qW3XSIUhn6xQH2WNfirfo6Ef7LWx
 LxMYIjqMjbIkPkPn1ji8LuYQpfwd4OEH9tn1yzz/2TGBjy41TMIkqw4YOUErXpw9EZEdPT
 tT6woEgZJysMk3b3lxmoWdcw48namVMdcf6TTxIC43uBwjFNaBP3lG9mVb1GTQXK8EUia+
 0mURYf9YFZm4zWF+R5Sc2eybsgHvpCUvo21EPNeh4faHBK8rnJsSCzG5oL+RL+Leuwonr8
 rIAPZInPkxCtSr0pnn8BieY654gnzO9gIxk42oC/00gncFohwpFXmSyO7dYmkA==
Message-ID: <3b564282-02f9-4037-ada1-853d658beca4@mailbox.org>
Date: Tue, 6 Oct 2026 07:15:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] usb: dwc3: generic: add SpacemiT K1 support
To: Dave Klotz <DaveWK225@protonmail.com>, Yixun Lan <dlan@kernel.org>,
 Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: u-boot@lists.u-boot-project.org, Quentin Schulz
 <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 u-boot-spacemit@groups.io
References: <20261006T002406-0400.uboot-k1-usb-cover.DaveWK225@protonmail.com>
 <20261006T002406-0400.uboot-k1-usb-0002.DaveWK225@protonmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20261006T002406-0400.uboot-k1-usb-0002.DaveWK225@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: b91cd1c13f9be4ac03a
X-MBO-RS-META: e5jzgixypw8h85eby6wr5ude5ypxarx6
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

On 10/6/26 6:28 AM, Dave Klotz wrote:
> The K1 describes its DWC3 controller as one flat device-tree node with
> the controller registers, clocks, resets and PHYs. It has no separate
> wrapper registers or controller subnode.
> 
> Use the existing flat-node callback so that the generic wrapper binds
> its host or peripheral child to the same node. Rename the Rockchip
> flat-node ops to reflect that the callback is shared; keep the existing
> Rockchip matches on the same callback.
> 
> The generic glue handles the K1 controller clocks, resets and USB 3 PHY,
> while the child uses the existing generic DWC3 host/peripheral path.
> 
> Signed-off-by: Dave Klotz <DaveWK225@protonmail.com>
> ---
>   drivers/usb/dwc3/dwc3-generic.c | 13 +++++++------
>   1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/dwc3-generic.c b/drivers/usb/dwc3/dwc3-generic.c
> index 2356b3bc0a..489bc8347a 100644
> --- a/drivers/usb/dwc3/dwc3-generic.c
> +++ b/drivers/usb/dwc3/dwc3-generic.c
> @@ -515,7 +515,7 @@ static const struct dwc3_glue_ops qcom_flat_dt_ops = {
>   	.glue_get_ctrl_dev = dwc3_flat_dt_get_ctrl_dev,
>   };
>   
> -static const struct dwc3_glue_ops rk_ops = {
> +static const struct dwc3_glue_ops flat_dt_ops = {
>   	.glue_get_ctrl_dev = dwc3_flat_dt_get_ctrl_dev,
>   };
>   
> @@ -718,12 +718,13 @@ static const struct udevice_id dwc3_glue_ids[] = {
>   	{ .compatible = "ti,dwc3", .data = (ulong)&ti_ops },
>   	{ .compatible = "ti,am437x-dwc3", .data = (ulong)&ti_ops },
>   	{ .compatible = "ti,am654-dwc3" },
> -	{ .compatible = "rockchip,rk3328-dwc3", .data = (ulong)&rk_ops },
> +	{ .compatible = "rockchip,rk3328-dwc3", .data = (ulong)&flat_dt_ops },
>   	{ .compatible = "rockchip,rk3399-dwc3" },
> -	{ .compatible = "rockchip,rk3528-dwc3", .data = (ulong)&rk_ops },
> -	{ .compatible = "rockchip,rk3568-dwc3", .data = (ulong)&rk_ops },
> -	{ .compatible = "rockchip,rk3576-dwc3", .data = (ulong)&rk_ops },
> -	{ .compatible = "rockchip,rk3588-dwc3", .data = (ulong)&rk_ops },
> +	{ .compatible = "rockchip,rk3528-dwc3", .data = (ulong)&flat_dt_ops },
> +	{ .compatible = "rockchip,rk3568-dwc3", .data = (ulong)&flat_dt_ops },
> +	{ .compatible = "rockchip,rk3576-dwc3", .data = (ulong)&flat_dt_ops },
> +	{ .compatible = "rockchip,rk3588-dwc3", .data = (ulong)&flat_dt_ops },
> +	{ .compatible = "spacemit,k1-dwc3", .data = (ulong)&flat_dt_ops },
The variable rename is unnecessary and makes the change harder to review.
