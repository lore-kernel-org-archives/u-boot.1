Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5059DCA5FC4
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 09:26:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B953481102;
	Fri,  2 Oct 2026 09:26:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JbA-EDRT-QNk; Fri,  2 Oct 2026 09:26:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 0A70E81108
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790933209;
	b=gJlzFo+WbXFe1rtVyuQKoblE8pKD8hMyawmQ2nyWOcnZQc+GOKLvkjLW0E+gtS8yG4ty
	 YiCV9buZ6IJEXclPgFGLy27poKK1GR2+aVSaycmADkjNORaSnEBAdZFTpC53NgkXWuhns
	 DH088yymnfpt1wLI3caG2SX+p2mZGHiqg7ROqaJFSLHl5EFOnTwjrGd1uhlCkFGUtrj6n
	 0YTpWwHt7dxQZnB2LteIiPncSK1O1oAbqGgmN/u21RY6btxWW1tTJRgtBBE4c4mdDytiq
	 y+2CR+wjAjhqkqnc5/RIoApFi8nicSqXci2+uiOsG2r+OtFRbebCz8gn9zc32dSMbIw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790933209;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=sJDgq7xjB1PjfPZkrkIDqvuiZUrJA67RFGg8nx6txL0=;
	b=N+o9AjRKilgNbA7Wb0WYR1AmuvEl7nR45GUwIVfykBj+u450M537iOcRH/qdhNJJqP+k
	 731y1gb6GTXeo+i+f0UX6yIK8q2vuJrM70Q0ubS2wBu+bsKfDa+vK3ylvhdEoPWg5NMz7
	 pyuNdi/HnR43oev9DmNul1En1OzvEkkeKtDXPvJ/SBy9GMND0DJL3y2CjwLeXa/cjRRrs
	 KP6slQA0kAjTldTd5K5znlIMAGBtXQb3aSkIJJpwJqeLmJWUSoWh+t2v2Zd4rm2vJPtSm
	 sgNbmkEpmtjDorOUsRZN02M2h6Sv2DBVXqMkw6LMekORAYdzW/cQk7W8uQaQFAMOAfg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790933209;
	bh=sJDgq7xjB1PjfPZkrkIDqvuiZUrJA67RFGg8nx6txL0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=f7owjP/RlMMfkMvmWqR0PlClhXuhkqyQcrBnndXINA+3JGu5p+UrgCdkDkLTFsbn6
	 H5yhx3N1AxpMrVtb+ZLo0teixfimN8uKA7xJx1sm+dRrou6ULSGsNGTB2MEaGK+p3s
	 jKGUcX5NKnVplwRIdyxSKF3WkW+lR2amuOtEcW5Y7/Nsa5ACaPyDmXhrrCDkEqXwjJ
	 l9rWFXIHCwRHQadq2G6vtwA02+8TlpHhU7AjsQn2ysSI0bK6HK02W/GrvD2vHXOHOI
	 3PwkpzvtuYd0LIHyNakxYGyMGotDisOC8bNn6BWXjPuNFP3YkLCLvtNQh4vJ5cGt+/
	 giUMtdaMeaiNA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0A70E81108;
	Fri,  2 Oct 2026 09:26:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id A269F3AC
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 09:26:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8821F6080A
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 09:26:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7xVdPk_JOV24 for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 09:26:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 911186066D
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790933207;
 b=TF+NdKgJWK/NKGabztSL6ezHTYbZzioGAxB2a8EUsSlP4foj8zr5LUyn5WVSfDH2yj11
 SLz52Qdm2T74aX0fCOb112H8/1ytM2zcDyreGcO7pPI1t8q7P/9nv4LPd0tcBYQ6z7pg9
 i1z86XnHPAWj19iu/zUmiFLyfsgNNcjZPjDES+XCtydq0Y1D2QMcI+YgtDNaVQjVBgQUz
 dUSAHSHtJBMURat/Csotr6ECPo/Bkw3FiPIWoWevuFDhV9Tp7Oe2d7RVSifIITz3QGJXC
 Yh7WXqlyRFyLd3szJRgwN0msPlYmXx4PB1uXOE5ggX/WsGT/Gpw6BgOHAAtHdR9uD+A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790933207;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
 bh=sJDgq7xjB1PjfPZkrkIDqvuiZUrJA67RFGg8nx6txL0=;
 b=m3f0FMdm8Ng+8WQLf+KiKUascECVHB4Rgzuxdqj6xSCrs9EpFbFoP/B0NjEbV76updIb
 Z4cIBzCb7OtNtlOYapuflOxnyIThlWYeRy/yNQN4iuLRnIhub6eCBEimEzylCuxyirszB
 xZRxALbtUiIsogj+dJwoBC6PvKxIMCxrpBHFmp71Lvs0tAZEGRq9lQJUcrZhSKTicl9lW
 Ei4G6wQTEjc3sLYUz/WXAyZ0rbFhJ+KbcL3hLvRSg0voX27G7WpZKQi1rvA23WN4p0xR+
 3rRK9n9UVoI1tz4VVbBSgmd1ajHwiexKLPx7jKo1Q7UOw2jVdLLxc/BrHKJ8yvMc5fQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=arm.com; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss
 header.b=T7d1z5ES; 
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=vincent.stehle@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=foss header.b=T7d1z5ES
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id 911186066D
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 09:26:46 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 17E8D497;
 Fri,  2 Oct 2026 02:26:42 -0700 (PDT)
Received: from debian (unknown [10.57.11.46])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 237A43F86F;
 Fri,  2 Oct 2026 02:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1790933205; bh=AhZZoolECQumdW8AbWJLJyvNekXP1oAhsO6PlGJAlkw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=T7d1z5ES066VhBdSxgGp0KmUXU/l6/NkdPLjtjt4Gran4NDCI5yY/NDykub+vv2up
 T+v7utUmcT0iObHnQHmIkfJEUDWyqeFH/occWF/QexzqiZFzWjy6+yvsC3ffdfQiwL
 xsfTvmKFoS1s/z0x0/0q4L5AIDVIdLP4t5V/ocV0=
Date: Fri, 2 Oct 2026 11:26:38 +0200
From: Vincent =?utf-8?Q?Stehl=C3=A9?= <vincent.stehle@arm.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Udit Kumar <u-kumar1@ti.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH 2/2] efi_selftest: add minimal fmp test
Message-ID: <ar94zly0zywmoZn2@debian>
References: <20260922-authi-v1-0-e943530349bb@arm.com>
 <20260922-authi-v1-2-e943530349bb@arm.com>
 <79ac74ea-390e-409e-bfcf-033357832d71@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <79ac74ea-390e-409e-bfcf-033357832d71@gmx.de>
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

On Thu, Oct 01, 2026 at 03:55:10PM +0200, Heinrich Schuchardt wrote:
> On 9/22/26 16:58, Vincent Stehlé wrote:
> > Add a minimal test for the UEFI Firmware Management Protocol.
(..)
> > +	/* Determine buffer size */
> > +	img_info_size = 0;
> > +	ret = fmp->get_image_info(fmp, &img_info_size, NULL, NULL, NULL, NULL,
> > +				  NULL, NULL);
> > +	if (ret != EFI_BUFFER_TOO_SMALL) {
> > +		efi_st_error("GetImageInfo returned %u\n", (unsigned int)ret);
> > +		goto out;
> > +	}
> 
> This fails if the number of images is 0.
> 
> ERROR: GetImageInfo returned 2 (EFI_INVALID_PARAMETER)
> 
> +struct efi_fw_image fw_images[] = {
> +};
> +
> +struct efi_capsule_update_info update_info = {
> +       .dfu_string = NULL,
> +       .num_images = ARRAY_SIZE(fw_images),
> +       .images = fw_images,
> +};
> 
> This looks like a bug in efi_fill_image_desc_array((). Why does it return
> EFI_INVALID_PARAMETER if the number of images is 0?
> 
> We should just return *img_info_size = 0 and EFI_SUCCESS instead.
> 
> The test should return EFI_ST_SUCCESS in this case.

Hi Heinrich,

Thank you very much for reviewing.

I confirm that I could reproduce this corner case with your changes.

In the end I think the test (v2) itself is fine, as it does pass when I
replace the calls to get_image_info() by the following code:

+       img_info = NULL;
+       desc_ver = EFI_FIRMWARE_IMAGE_DESCRIPTOR_VERSION;
+       desc_cnt = 0;
+       desc_size = sizeof(struct efi_firmware_image_descriptor);
+       pkg_ver = 0;
+       pkg_ver_name = NULL;

I will try to send a fix for efi_fill_image_desc_array() as you
mentioned, but if you agree that will be separated from this series.

Best regards,
Vincent.

> 
> Best regards
> 
> Heinrich
