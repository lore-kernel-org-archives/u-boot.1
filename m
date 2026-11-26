Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95895606A323
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 12:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=kW/7G1Iv;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ckrc6K0+
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6FA5660A58;
	Thu, 26 Nov 2026 12:31:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bZFW5nXdi-k1; Thu, 26 Nov 2026 12:31:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A2D9F60A4C
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795696274;
	b=KHUBlUdolniho1Av5+4qQfnT6jFtUCBZyVOabfjlZhZ0UFo+UfLb7493QyKMCj54Y7EJ
	 +OheqBnQhmxD5A7IqN5WQ4QJhxDxURDwwT7JncoWEOCJFReL75mM8PMBKrq4BNFyrfGHs
	 bxOIhRxXzjC/FDg4aP7AZ7+F/G/+/BnQRg18pjIfDF/AOIaOnlIvVdC0QSVtMhaEOuEGj
	 t0CjSZPuYxMZlcxfWlap8tkSy20jN64N8na4cS7QQklIUZ4o7cFPqW/3eJt+fGOLgA9ls
	 EWdGDlI50gpsmTxLzHsieujRvWxxH0qNBRWrQ02ivW6a1FDeMHVfFIfN5lWOllxHdDg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795696274;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=qoDjVOQaUsSyna6RI0mKpnxhVUgydkoymH+BYvl117o=;
	b=AlSnNkgXFDgjZ4hn2hDpNqLyf8PJOSuR0xvX/CTD+n2XJnJp1MUygVeciKURJv2Tx/5e
	 2EpZXhHDs3HMB54yh+WHbirgAREdG3Ha2FVunkBVMVvo4GWyCG3quiUpJKLvNP9jDvcQ3
	 cBfZ588WBuk6pmRVvAkwEpt/NaNynjo+eRYbmxlPUCDvQ1TXc17Dn+5pof2w963je2FSb
	 u6vKq9GpDSsQcXM9VILSIaIxoUXBxGolmQZSpxqA8erP8aj5kP4B1VsKWWXFp0BcJ5ml1
	 MMkWYPgIfsa9e76ayDrdhNXWhdnWovEC+CEJ4iYzc85m2jvsNo+UR+nAACAnTKgwFcw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795696274;
	bh=qoDjVOQaUsSyna6RI0mKpnxhVUgydkoymH+BYvl117o=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kW/7G1IvF03r29OgaoJae3cJfNlh5q2CdveCfFIZ1xs0at1nlOGHnaN++Rn2tkxU7
	 fE0Op2mkgqxYXQX4My7lP2l8YsuXESJPyDezE4gmYPOMAvGRCDR2lk2M0hCxQAaijM
	 LQTll9MpKnCbDkSDsIBK7hzzo6/7M/8+uw2DnGegoqDkTFT70WROgdJEeOwUoo/zWh
	 2nwOVHYEgf8ZEbcaixBkhXNMh0svjmtZqHmuwtwVy9hB0kgAw4eYczt76KeGMDhFcA
	 aJdfI5ssPA+kzMvQG4NBElmAina2Fl35UFIUJbq251/NYupk5qWvaQWRflSZlXiyRq
	 0hHQ0w7I0bBYg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A2D9F60A4C;
	Thu, 26 Nov 2026 12:31:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0941732D
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 12:31:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EF5838112F
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 12:31:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Wpj2wIh4TjKa for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 12:31:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 54EBC81132
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=sumit.garg@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=ckrc6K0+
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 54EBC81132
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 12:31:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0B1E3629A6;
 Thu, 26 Nov 2026 12:31:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B725D1F000D2;
 Thu, 26 Nov 2026 12:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795696270;
 bh=qoDjVOQaUsSyna6RI0mKpnxhVUgydkoymH+BYvl117o=;
 h=Subject:From:To:Cc:In-Reply-To:References:Date;
 b=ckrc6K0+V6UNl7AUCZS1AXv818zMCnsoSQR+y2slTefwtAgLBOJUgiiliSnb+TzxT
 dfIa93+wPox0GmkXCjs2QRNUdAqRQfABwmLGav6oAykFQ+InskIHgTwLghUz4rfW7W
 W8C/59ZauVuiIux0V2BmJD4gK4Wr34Q2mZad9lnRmXcNxfZGOHhu0Nrn2kCuaUhWpT
 mKuE6MuZ3AFx33F65v0bKQdCipXJbg1rdE67uCYILm3nSHnnKDr5reYLvzTjp/P2yf
 P3MxXkvPTugrTS+gdIBZ3cncDzFeAXb3qg6NVfFmS2ScTtSIvl5G7IYuaSbDoWcP2n
 nlAAPnrHOWY1g==
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH RESEND] configs: qcom_defconfig: Enable EFI variable
 runtime storage
From: Sumit Garg <sumit.garg@kernel.org>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io, 
 u-boot@lists.u-boot-project.org, Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Michael Srba <Michael.Srba@seznam.cz>
In-Reply-To: <20261009-efi-runtime-v1-1-6f02220d2020@oss.qualcomm.com>
References: <20261009-efi-runtime-v1-1-6f02220d2020@oss.qualcomm.com>
Date: Thu, 26 Nov 2026 18:01:04 +0530
Message-Id: <179569626470.130558.10794995679096831968.b4-reply@b4>
X-Mailer: b4 0.16.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-09 07:12 +0530, Balaji Selvanathan wrote:
> Allow SetVariable at runtime on U-Boot's in-RAM EFI variable
> store so the OS can write EFI variables via efivarfs. With this
> enabled U-Boot also advertises EFI_RT_SUPPORTED_SET_VARIABLE and
> exposes the RTStorageVolatile and VarToFile variables, which
> userspace tools such as efivar use to persist runtime changes
> back to the ubootefi.var store on the ESP across reboots.
> 
> EFI_RT_VOLATILE_STORE depends on EFI_VARIABLE_FILE_STORE; select
> it explicitly so the option is not silently dropped if that
> default changes.
> 
> Reviewed-by: Casey Connolly <casey.connolly@linaro.org>
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
>  configs/qcom_defconfig | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

> 
> diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
> index 7d4a2b589aa..40ee45e8d42 100644
> --- a/configs/qcom_defconfig
> +++ b/configs/qcom_defconfig
> @@ -10,6 +10,8 @@ CONFIG_SYS_LOAD_ADDR=0xA0000000
>  CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
>  CONFIG_EFI_CAPSULE_ON_DISK=y
>  CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
> +CONFIG_EFI_VARIABLE_FILE_STORE=y
> +CONFIG_EFI_RT_VOLATILE_STORE=y
>  CONFIG_BUTTON_CMD=y
>  CONFIG_FIT=y
>  CONFIG_FIT_VERBOSE=y
> 
> ---
> base-commit: 0a55b098d6f5f6bafa84fc2f18b433dd167bf729
> change-id: 20261009-efi-runtime-b9f07cc48993
> 
> Best regards,
> -- 
> Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> 
> 
> 


