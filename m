Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93799606A323
	for <u-boot@archiver.kernel.org>; Fri, 13 Nov 2026 06:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=DRXG1t01;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cWL+m0+6
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6779A81A15;
	Fri, 13 Nov 2026 06:15:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ex19MPGOJOdJ; Fri, 13 Nov 2026 06:15:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org BECF581A1C
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794550535;
	b=P0Y302OGpVn0YUfGkkBmKRqwUAL9GFOd0l8bsGLMPM5z0jGrsTfxdMi89EuHeM3ZMciJ
	 dBhCwH0/MWRht5PU0zirjPMK9d6sBxROFaUUE0Y/36EXrOi6BnMcHd99c8WtwmeKc4UeN
	 tY3xE8AMBYnr1ngsZz7ZXybf8ydkDxlHN1Y0S6xglVaVqLKsIctlf322tvxNCawQo/TgG
	 ElNTwjEKeBMfayeEJabDhb8WXhipKh1tJgzEL7oYwoKbUYEfz9X1p+4cWscdgrlsinVHd
	 y4eRflujocTUWGJQmeJSj/Lkd+0kwKTB7FTk6qb2wYNoXP77aZv5hi8vL7JLng/YU2A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794550535;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=6WXiEcPO+PsH5pSBcOnSvRTCr5X5jTrEEGrz/VCY+nQ=;
	b=BNZk9GwOK1jnV4WMURe3z0vDFPVRqmOV8XYpAsqCEMW5fOdUlskuT5qSPYUkZA5KFixJ
	 ImlgwIrW/d4ojiKL0qOgSdrs63/CQtlQzMyXt4MS04/OfDGhafJEseXCOykzBP9lDu1CP
	 gLObQUAA1L8MxgYOUHz8PyAfBSRq3Uw9MiH7NfuWwSIdGtouqshXIao1qMgWXbVjzPV8i
	 oa5VvxWE3ul4jYJDVcnh91cAbPoRsoqLDnRULCccNVCfdJsE5VgmjXRuTzMOYSzHvlrs/
	 865nCSvnNZGrvQN2KaNIVEQcBI2U436Mq5bY9o+FqluUrcuMCWo2hw13XAT9lF+jlnw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794550535;
	bh=6WXiEcPO+PsH5pSBcOnSvRTCr5X5jTrEEGrz/VCY+nQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DRXG1t01tx5wUEsi1g0bCFA0eBXN8rmerf1BhLhUD2DmRAgGAraym1NYKld4wGhYo
	 rjG7MIccy8L4B5NfRDU+OMRiyymAMK83Bl9Ma8GHfRJsYVYWU540moiCL5vc78s/uc
	 5SPDtKufPOGNnTn+YBAJ0bcAUzX/AuMtjaAXWp8mURWvW76RGyAEAlB786Hjem9b/Z
	 /lr5XH3D+WGrYoPcbWw7LbTFg0vHJ/4xZk5HbG2ySNhZCGDnxVtuXamzLOtN7sPzIG
	 IROzXUx0xXeTOq18SD8P9EWwHVETRQlDS1QqmHPoxZrnvfEHIoHEXLnuGGQFPClOxf
	 tp+GBWwG5QUkQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BECF581A1C;
	Fri, 13 Nov 2026 06:15:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 10E33AF8
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 06:15:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EB1C460DF7
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 06:15:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3O1sFDrVfJoH for <u-boot@lists.u-boot-project.org>;
 Fri, 13 Nov 2026 06:15:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4070C60DAB
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=cWL+m0+6
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4070C60DAB
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 06:15:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E2BFD43A20;
 Fri, 13 Nov 2026 06:15:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F06DA1F000C4;
 Fri, 13 Nov 2026 06:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794550531;
 bh=6WXiEcPO+PsH5pSBcOnSvRTCr5X5jTrEEGrz/VCY+nQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=cWL+m0+6Jn9zk2l5kgM6FncGPiO7vRojIcrzbBQKL/IIq241zv4oeEqIb7n2sg6iP
 6B2YsS7BMhrmNglOZA4y+veR5quG1rFDuQBNPc4zUeQ5kqaebe20cSP0eG50HJ/0NT
 GGTVopVfHZcrYR580tVtpDUmsaQiGfBIqfiX1HRheoGDs0TeUZAgbplJNrske5f3XS
 LbcgwhA4s8I0n11ir8CnW/R5d6/9gK5OlK8dLDHzD1XYUTx5Tx9+B8XjhPm3A5s96S
 nktFE2vv2/GyA552C/WycBv545pI0SURnXZ1c+ctYR0IBiL7L6ie+7Isnsi9WqwNAa
 6CjXeNi6B1i+A==
Date: Fri, 13 Nov 2026 06:15:28 +0000
From: Yixun Lan <dlan@kernel.org>
To: Marek Vasut <marek.vasut+usb@mailbox.org>,
 Hung-Chun Tseng <alan.tseng.cs@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Huan Zhou <pericycle.cc@gmail.com>,
 Eric Chung <eric.chung@riscstar.com>, Alexey Charkov <alchark@flipper.net>,
 Guodong Xu <docular.xu@gmail.com>, Raymond Mao <raymond.mao@riscstar.com>,
 Zixian Zeng <sycamoremoon376@gmail.com>, u-boot-spacemit@groups.io,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v2 1/2] usb: onboard-hub: Add support for VIA Labs VL817
Message-ID: <20261113061528-GKA73509@kernel.org>
References: <20261113031613.435429-1-alan.tseng.cs@gmail.com>
 <20261113031613.435429-2-alan.tseng.cs@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261113031613.435429-2-alan.tseng.cs@gmail.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Marek,

On 11:16 Fri 13 Nov     , Hung-Chun Tseng wrote:
> The VL817 is a USB 3.1 Gen 1 hub controller with one supply and a reset
> pin. Use the same reset time as Linux.
> 
> The Milk-V Jupiter and the Banana Pi BPI-F3 have one in front of all
> their USB ports. Without this, U-Boot leaves the hub unpowered and in
> reset, so no USB device is found.
> 
> Signed-off-by: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
> Tested-by: Zixian Zeng <sycamoremoon376@gmail.com> # Babanapi-F3
> ---
>  common/usb_onboard_hub.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)

would you prefer to take this patch via usb tree?
or I could queue it in spacemit custodian tree,
either way works for me, just let me know

-- 
Yixun Lan (dlan)
