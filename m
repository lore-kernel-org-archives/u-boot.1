Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8BBF606A31C
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 09:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=EDax5sBF;
	dkim=pass (2048-bit key, unprotected) header.d=dolcini.it header.i=@dolcini.it header.a=rsa-sha256 header.s=default header.b=AsdVMltG
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DD2E4405CF;
	Wed, 18 Nov 2026 09:24:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SWl2jdUu79Di; Wed, 18 Nov 2026 09:24:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8E9F4405D7
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794993862;
	b=LONaKhT3SWsC6+RYWGbtpzDvuboMjZ/UMuKXRBQOv7EQg1aJxWioNj+82Wz4cRrjyAW9
	 DWTXsbXDgxm8iFmgcnXNiElJbxSQn3dMZXZEUCXbyRiBQg5GJXBaj2XGpo2YKDFS9eGd6
	 Mg7Tiz/GQHQBOIlaVu49SEaZmBbG0r42GxEbnIUSX5LKcXIchr+CfWq6hUOs3nEsLaM7V
	 aHaqrF0pTuAtmyCYUeSzCsLlAYIOUjz3L+p6PKL4wczW9I23JTbHE+7QvDv/gZ2mQlMTH
	 1z1PZZz4pye85WxQUWKwdvpOqKp9JHeXhNBOwQ9OmnLZOZOyPUYu0QpXo1GEf6pN6UA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794993862;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=mUbsEpsUFp9bvEpgFOY4YKjCUEeBAiAOSSs5ZYuhVrk=;
	b=ptd7OIFhqN0eyH5dRa2k6mFr8xxmjjeLo1saEz/Ng/jAuoXIC9ICpA1StTl16fTttUqz
	 4ocbFQVpTLSAg3nh4C4qIYAgvNQ73d91NJXAe0ek7m3z05HotwiufspLKx+W68lVWUr8q
	 Jv+ur6ek3Bk+aFKTjUO2Mt1HdtsHAi8EuLKFJDmAL27Tl1wvq9Tvi4vWtZDY1Bs/BGjgG
	 U4cBJIj2jPB6HhFySE3gJHNSQBpBI8DymNViPD4DRQYQ+H8WGRxOhNLyttql4EYmLyAzn
	 d3433a0uAKrxhVSXy0u97jRxhUbDVv/lG9vWpIQE1IQNfBEcSndcbWZaJ44224JFC6A==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794993862;
	bh=mUbsEpsUFp9bvEpgFOY4YKjCUEeBAiAOSSs5ZYuhVrk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EDax5sBFaYT9xZUYiaNPakwwQsC1Ly4/SRCxigDcb92Pdqeziq9WEj9PuEMYvrk7D
	 TQrUtZaTZBUEXXgM5syIlWy5JstTOeLbi44sY9kZaJskt9JWb/ZRGl86skmuXaUULg
	 UdqW1PELHWSfpdejxMMMKCxM1d2DaQtyxYegh1zw8hQeXypmkdxlLtshJXNJ/y7FRF
	 hn2PwGba5dDgKrR3YEeCnxb+ocD1RKPyTjfq7n056jYP01j2k2pReJ7RAQ3MdawZof
	 Qfy+ci0akI6uzK+4vV+/ROxJsvcNoRxqx5tZOzGJXObfugPeHGug/0D9qqLeYpLEcB
	 dfhx7xPyta7Fg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8E9F4405D7;
	Wed, 18 Nov 2026 09:24:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 78DA349B
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 09:24:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5BC3080D52
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 09:24:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ibwN4LNi9ENI for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 09:24:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 905A280D1F
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=217.194.8.81
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.194.8.81;
 helo=mail11.truemail.it; envelope-from=francesco@dolcini.it;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=dolcini.it header.i=@dolcini.it header.a=rsa-sha256
 header.s=default header.b=AsdVMltG
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 905A280D1F
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 09:24:15 +0000 (UTC)
Received: from francesco-nb (93-38-173-255.ip71.fastwebnet.it [93.38.173.255])
 by mail11.truemail.it (Postfix) with ESMTPA id 5A7481FE45;
 Wed, 18 Nov 2026 10:24:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1794993852;
 bh=mUbsEpsUFp9bvEpgFOY4YKjCUEeBAiAOSSs5ZYuhVrk=; h=From:To:Subject;
 b=AsdVMltGPbfC9xoP01dygAFEFwBEmNE9GJVR9eU+dvy1aCirhawRNyNChteyEqK9F
 jVmrykYCmJwRrx8rhgWNt5l9WMBtdnZJiSIkidCpxgaJHXsy5N8WXdoMx7mm2YnhTr
 MCoIHAJMIU7InC8i53OPxXJxYIV3TPAQkmIvU+BqpCxUu3CFXZwQnJb7feDo5uWlI2
 RoYuoxzXXPjuN3BPmRbOHG3+iH3eppjzq5qJ7PzJF5ul4V92VzED9e5n4KgAwp6bqq
 2YoaBPGvBhuKhNA04YA7MqnZA0vN0SzBSXBBl3+sNelqWxyfmob1l0el246jgrH8bk
 yW+rMLKceFiFw==
Date: Wed, 18 Nov 2026 10:24:08 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: Sergio Prado <sergio.prado@e-labworks.com>,
 u-boot@lists.u-boot-project.org, festevam@gmail.com,
 sbabic@nabladev.com, uboot-imx@nxp.com, trini@konsulko.com,
 marex@nabladev.com, o.mandel@menlosystems.com
Subject: Re: [PATCH] board: toradex: verdin-imx8mm: adjust U-Boot proper
 offset for eMMC fastboot
Message-ID: <20261118092408.GB133044@francesco-nb>
References: <20261117101519.3952636-1-sergio.prado@e-labworks.com>
 <avw6QW3OO4Lw0631@francesco-nb>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <avw6QW3OO4Lw0631@francesco-nb>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 17, 2026 at 12:28:01PM +0100, Francesco Dolcini wrote:
> Hello Sergio,
> thanks for the patch.
> 
> On Tue, Nov 17, 2026 at 07:15:19AM -0300, Sergio Prado wrote:
> > The Verdin iMX8MM boots from the eMMC boot partitions with the eMMC
> > fast boot fuse enabled, so the boot ROM loads flash.bin from offset
> > 1 KiB instead of the usual 33 KiB. The SPL loads U-Boot proper from the
> > fixed sector CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR, so the board
> > device tree moved the FIT in flash.bin to 0x5fc00 to compensate.
> > 
> > That override only works while the fit node is placed directly in the
> > binman section. With CONFIG_IMX_HAB, imx8mm-u-boot.dtsi wraps the FIT
> > in an nxp-imx8mcst node with its own offset of 0x57c00, which takes
> > precedence, so a signed flash.bin has the FIT at 0x57c00. When booting
> > from eMMC, the SPL does not find the FIT at the expected sector, treats
> > the data there as a raw U-Boot image and fails to authenticate it:
> > 
> >   Authenticate image from DDR location 0x40200000...
> >   bad magic magic=0x75 length=0x206d version=0x63
> >   bad length magic=0x75 length=0x206d version=0x63
> >   bad version magic=0x75 length=0x206d version=0x63
> >   Error: Invalid IVT structure
> > 
> > Adjust the sector in the SPL instead, as the Kontron SL i.MX8MM does,
> > by checking the fast boot fuse and the boot partition, and drop the
> > FIT offset override. The FIT is then at the default 0x57c00 for every
> > boot medium, with or without HAB. This also applies to the MX8Menlo,
> > which reuses the Verdin SPL code and U-Boot device tree.
> > 
> > Signed-off-by: Sergio Prado <sergio.prado@e-labworks.com>
> 
> ...
> 
> > +unsigned long board_spl_mmc_get_uboot_raw_sector(struct mmc *mmc, unsigned long raw_sect)
> > +{
> > +	/*
> > +	 * The image offset on SD/MMC devices is 33 KiB, except for eMMC boot if
> > +	 * fastboot is enabled. In this case it is 1 KiB. In order to make the
> > +	 * bootloader universal, check the fastboot OTP boot fuse and adjust
> > +	 * the offset.
> > +	 */
> > +	if (!IS_SD(mmc) && (readl(OCOTP_BASE_ADDR + 0x470) & 0x80)) {
> > +		switch (EXT_CSD_EXTRACT_BOOT_PART(mmc->part_config)) {
> > +		case EMMC_BOOT_PART_BOOT1:
> > +		case EMMC_BOOT_PART_BOOT2:
> > +			raw_sect -= 32 * 2;
> > +			break;
> > +		}
> > +	}
> 
> Why do we need the runtime check on the fuses? verdin imx8mm can boot
> only from eMMC and with fastboot enabled, so this runtime check is
> redundant, everything is known at build-time.

Maybe remove the override in the dtsi and set
CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x2c0 (check also menlo)?

Francesco
