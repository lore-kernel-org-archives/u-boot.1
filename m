Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32322606A327
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 12:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=d7BAKLnL;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SidjO64E
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0765B608F5;
	Thu, 26 Nov 2026 12:52:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Grgaw8MHUJ4A; Thu, 26 Nov 2026 12:52:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 51B2E60A3C
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795697528;
	b=Q0xLpogOplb0D8MlTQy94c5xB2zbmbtda4dfxugk9xfktck+XewIklL4d6PCRsEc6vGF
	 tLOZr7DsMDf02dGylK0pqvWDMcsa1FH20QXY91UbCNx2E8T3p46tcRuEzz9ji5cOYwgQq
	 1+cLDouo739n09JyLx998RAh3W9DY9FR0y7I/Sx56ovRe6Z6dDQM+nixAmv83kF6QA9RD
	 msxFqmUfcDAXpNht9YKltQcFVmmPQI1VcOmX/vvPcHhwTUrpegqkX5Q+wFMDNbUSDxB+9
	 NcGU49a5dl4F9T7PuHHRM3KOejdV/Ru2kOH6o+bM/HX0vlqCyxlGCPnHt2KsiuBK0hQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795697528;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=JdHhIUPAjyIprsjPtxpFUQZNI9Eqzux1yZvkOinODGs=;
	b=QSzwjEtKPusmvXZVaEzY7g/Ea8FcxVNRLckN1FmVAJHIgJgT4AYuraKXqssDYrP65ub2
	 wJ90X5kgeZ4g04D1Jnu5RDd4Vem2WSMlznT83VnyQnB9RwVRdeIkkIxemShFNUZx+mBbR
	 4w7PxEfL7LaXIA95MgGBelbAKNQuqHPvUjrhOQqsISACAhlwlZSbVo8mYh09864xGZ5si
	 OnQz0LlQqSf/mjUeLNZkcyRu6kc+EilJMz+gUURiVsExzC9kmBnAtQYEuxsdsklnZKYZm
	 TXLQPO31bIP6yGMcVf3JAoLYf4ds9560OV8B0PpVKmw+tsUaRrT/a4rGJks1nJ6oAvA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SidjO64E;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795697528;
	bh=JdHhIUPAjyIprsjPtxpFUQZNI9Eqzux1yZvkOinODGs=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=d7BAKLnLSCAEeX4zwyqKjUbvj7j5419cexkf8FxzPphA6ktUPQuyGsspO33c4X6hR
	 wgF3pb86XNaTMs01EbeJ1iMBjUq1ayJzv6UMIInE3Ec3LstAJj7kXmc9dTkFuOt/t6
	 qCyd/ANB84jYz2QRcGgfJeI0y0bLB1Osxc4ZJ5VxVzGoHzO7xw4y38htjLvw5t7TRb
	 rrz25qfkkTlXyj6yfQQ955559dbKKcgtUOb7uATF3PwHIDVuBe8uzLias2ojdpehFK
	 DZBeYLS7bgcqjkl8wdZBK/eRN7AQpOTW9yhmfmcuPCjxOpYoK+hHX+Z+hMjaimOaSQ
	 KbeOA3J6YsGJQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 51B2E60A3C;
	Thu, 26 Nov 2026 12:52:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 162F01AB
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 12:52:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1353E60A3C
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 12:52:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xsWJbYcyeE8i for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 12:52:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 56CE4608F5
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=sumit.garg@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=SidjO64E
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 56CE4608F5
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 12:52:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AC26D4246F;
 Thu, 26 Nov 2026 12:52:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7C6F1F000C4;
 Thu, 26 Nov 2026 12:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795697525;
 bh=JdHhIUPAjyIprsjPtxpFUQZNI9Eqzux1yZvkOinODGs=;
 h=Subject:From:To:Cc:In-Reply-To:References:Date;
 b=SidjO64ENcPmwqlO40Tx/aDchsecSMl0Eb+bi4PWe1ezT+UA/KgUDC/AfV+JcJaFD
 jxNM4miBnvEsR8E5jf5rWCoIUk4Pdbflnp3BOh7z6lcG4jhJ0SUXmmi1ToizRlQ/2o
 EJuZePZg1NI/mZJu/xEO1a69bp0uJNjanV7sRiAaxsy020GHQ13dd1U2TDkkOgBAdI
 elo95JfBgC0wgdPBcYQ+aGOearOwY0hAAFp0vke0dBLcWqg/q2kZofNqjlgTcMQ8dT
 PJhAKAUfQKt8/TSQtrP3Jqb2HceVgOiFMkZNHTXLXqd9yKtEp9r6TYkFS2i10sd7pD
 UAyw2GO/y9gcg==
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] configs: qcom_qcs615: use talos-evk as default device tree
From: Sumit Garg <sumit.garg@kernel.org>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io, 
 u-boot@lists.u-boot-project.org, Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Tom Rini <trini@konsulko.com>
In-Reply-To: <20261020-qcom615-talos-evk-dtb-v1-1-ae2d2b48b0c7@oss.qualcomm.com>
References: <20261020-qcom615-talos-evk-dtb-v1-1-ae2d2b48b0c7@oss.qualcomm.com>
Date: Thu, 26 Nov 2026 18:22:00 +0530
Message-Id: <179569752009.130558.9912187373937215410.b4-reply@b4>
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

On 2026-10-20 15:52 +0530, Balaji Selvanathan wrote:
> From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
> 
> Switch CONFIG_DEFAULT_DEVICE_TREE from qcs615-ride to talos-evk so the
> defconfig builds for the Talos EVK board.
> 
> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
>  configs/qcom_qcs615_defconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

> 
> diff --git a/configs/qcom_qcs615_defconfig b/configs/qcom_qcs615_defconfig
> index ccc3bf24ab1..4e3e97e6efa 100644
> --- a/configs/qcom_qcs615_defconfig
> +++ b/configs/qcom_qcs615_defconfig
> @@ -14,7 +14,7 @@ CONFIG_DEBUG_UART_BASE=0x880000
>  CONFIG_DEBUG_UART_MSM_GENI=y
>  CONFIG_DEBUG_UART_CLOCK=7372800
>  
> -CONFIG_DEFAULT_DEVICE_TREE="qcom/qcs615-ride"
> +CONFIG_DEFAULT_DEVICE_TREE="qcom/talos-evk"
>  
>  CONFIG_QCOM_GENERATE_MBN=y
>  
> 
> ---
> base-commit: e36b675ebc4c41f1f4187c46d363d581c371d538
> change-id: 20261020-qcom615-talos-evk-dtb-ce2eb9b54bcf
> 
> Best regards,
> -- 
> Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> 
> 
> 


