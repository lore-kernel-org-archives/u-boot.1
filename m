Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FE8606A31C
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 12:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=htLpug3G;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lXg9CwGG
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 38E8760A5D;
	Thu, 26 Nov 2026 12:48:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JIGQxAz3_XJK; Thu, 26 Nov 2026 12:48:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9EB7360A54
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795697320;
	b=s4BIvFZ1cTF5qV/4fMzTkNrPmOlQPxBqzWeFhbnwuInJIz8LQMpL78pCQ2MUdH9UhsHR
	 c8QvyTf0bgYcFx3GzrT8goiP264cvcGCZH7hq2YXHzpaCou3FKQBojp2yQvCnJnIAY2NZ
	 fJ3HPLA2pR13MAhDON/4IWxn32buzSEsgMU7U/poZrNbWxueO7Fol7l8PiimxaZVgQC4o
	 6SesM2R93KDwzV/Fq+jtuhmkiI0JngWHLtbTmtJESvV8DA2ooLTemdYCRZGevvzJRR6I0
	 /GSvN6MOZUAQf4ueiMz+p0kYBdfsTd93w63cQlynixpFwipA3rdgp4VJPgvXQqNKcjQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795697320;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=if2SX6ml/uMUnSeqYrSnydH+rqc7drSA49FUhXdJcgs=;
	b=eE7kzp/krSrXJIjZfqNSsSHgIB+DUz72fmrDjfLKS61nMLlg2ZUk7vX6kAu9B1OF+9rt
	 uy9ef80LzYU54gPRF1TJvjZGRMvNwuwps69rKC6CbatOkElKGG7DomP6d8iUCqNSL3nSN
	 Z868SDM+TQeEJm8X7+8l3HY7CUsDzcEd/nnzxZHq8bzOQ70BthDhX2/HUUOSzFGm56jsG
	 3heQvR4T1oSC3kngTcUcRy/NeuS5b8+UY3jARq9ophctMALu8kfDSDQ++Hj/R+JCyewMs
	 gGfPqOrpZeJIzKo9sPFcsUZB1LkMloEb2irawD90VAc1Cv0Nvdgu1WDqR5UcWmmtBYg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795697320;
	bh=if2SX6ml/uMUnSeqYrSnydH+rqc7drSA49FUhXdJcgs=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=htLpug3Gi7JpzM6mXzmX/E24RB/jUbt2K8MSdBzp0hsZEy1cq0hoGDSGLjeh2ml90
	 BrkCSmD3vsfbVUEhT8+b3IAtPeESKBjX4Cakfzb1ixNWLKzfDZZbTv+gWwf5PYe/RL
	 93YgqMtRRGph2nriNnG/pUFR+f0iFRRKaOvR6vmDXDinZb0Mslt8Mr7BYNLD/FcVud
	 YDeQr343+89nuiXxq77TF0zu6VNOwjr2c+W1wPgO1Of9QeDbB2E02M7hQ7bftsQyXi
	 SZdRh3FiAbESb8FKSUJDi3DLFAHPHNpE98RLfkdoaTHYk7MTkALDcWAG61KP3fgX17
	 2rvv6HvzM2ClQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9EB7360A54;
	Thu, 26 Nov 2026 12:48:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 47D4A1AB
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 12:48:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2DA88404B0
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 12:48:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JYmQhr4-9n99 for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 12:48:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 68CD2404A4
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=sumit.garg@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=lXg9CwGG
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 68CD2404A4
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 12:48:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5343F6112A;
 Thu, 26 Nov 2026 12:48:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 315941F000C4;
 Thu, 26 Nov 2026 12:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795697315;
 bh=if2SX6ml/uMUnSeqYrSnydH+rqc7drSA49FUhXdJcgs=;
 h=Subject:From:To:Cc:In-Reply-To:References:Date;
 b=lXg9CwGGJkrOT/Ty/whkSjyfjByNyEusOAeP31+T+xxZ5NiBBtYBRamb+sVJmi/iD
 xMSKleMCox0sSCgx+VXllGdNm8G1JT7rM5saft2sOFieLzOaMLv/S4ppoXKtLMPnkr
 uGG+DSrTvLLc2vL/M7t+GBTQI6UF5VtmcYSq6S6CG40uOUQAm7WMlf9eN10f0F65aV
 FQXCwZhBK6AkWGmIytGfzxoeTvHfoYBz4SNZRI/6SQmBwX3Rl/wEha7UuMOj6M5PpX
 ZFWNTuWxJDmVVGEhi6d80VK4dZUcppe+ELjekMTMfkxW2k9ZpgFrDtn1SiQvyno8uA
 PT235uz2Mm1/w==
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 0/3] configs: qualcomm: Enable Gunyah exit on QCS615,
 QCM6490 and QCS8300
From: Sumit Garg <sumit.garg@kernel.org>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io, 
 u-boot@lists.u-boot-project.org, Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Tom Rini <trini@konsulko.com>
In-Reply-To: <20261020-gunyah-exit-boards-v1-0-39ec03d9e365@oss.qualcomm.com>
References: <20261020-gunyah-exit-boards-v1-0-39ec03d9e365@oss.qualcomm.com>
Date: Thu, 26 Nov 2026 18:18:29 +0530
Message-Id: <179569730965.130558.14330261724469906713.b4-reply@b4>
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-20 08:07 +0530, Balaji Selvanathan wrote:
> Include the exit-gunyah.config fragment in the QCS615, QCM6490 and
> QCS8300 defconfigs so U-Boot leaves the Gunyah hypervisor early and
> runs at EL2 on these boards.
> 
> This series depends on https://lore.kernel.org/u-boot/20261013110525.2465737-1-aswin.murugan@oss.qualcomm.com/

Since this dependency landed upstream, feel free to add:

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

> 
> ---
> Balaji Selvanathan (3):
>       configs: qcom_qcs615: Enable Gunyah exit support
>       configs: qcm6490: Enable Gunyah exit support
>       configs: qcom_qcs8300: Enable Gunyah exit support
> 
>  configs/qcm6490_defconfig      | 1 +
>  configs/qcom_qcs615_defconfig  | 1 +
>  configs/qcom_qcs8300_defconfig | 1 +
>  3 files changed, 3 insertions(+)
> ---
> base-commit: f8443f2c16e020caabba45a2af39c4bf3354533a
> change-id: 20261020-gunyah-exit-boards-8e78b520b72e
> 
> Best regards,
> -- 
> Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> 
> 


