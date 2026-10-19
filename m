Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9446ECCF2D6
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 12:08:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B50304078E;
	Mon, 19 Oct 2026 12:08:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NcaR2ooWYFQW; Mon, 19 Oct 2026 12:08:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 17ACE405A9
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792411695;
	b=bFfDs+c/lcaduEi2xQ2JCcmadR/V3CBMdQELG50blaJNl04J3Er5Au6T9CW/TlqBtGwd
	 +YVaer8vCbb2RP9Pr5UNg79fMjtnEqZQbzkvXcOjTsebol3iHfrm1gNU7rQHSWEcvcAqD
	 uBDAUWZAImkIgFSBj1aoKFCcQKhILzLqwVJL6TIL7eldeFIKJSsSqePYJODhr2gqBJJPP
	 h2skQRDS4NKcA/54KmrUyJ32EG5TwPBFl1b1wGnGjlXjIGvwz/a7hqR5jYSojdQiB5Lua
	 D63xA8jdz+YbhbfKEumgMmBvepQ0BP9o55J1yS/lWyLuuWs69aNKLTS8Im4Y3o1ddmA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792411695;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Wvn04IitRQ2xOhOFB0dcl8ZXfrTXUuXblHbukw6MVjs=;
	b=SUY0VT3Ou4xUpdRCOKGsxzGJX8WFvO0o6Yp8bV33lofWAz3DyDS6pvtWN1zO+yPtIazP
	 o2s01b/1GE38zL/4ekhJrjXnIbkGSC2flAETo3F6g6lF32ZLHWeXiCe44NMMi2qqMwbrF
	 q7EgVlHThB09P0K228w9kaeJtbfTSGHRRl63Q3btixu59mPhG2fKD71Eajz7U531heIiE
	 1efg35P+ad8OS06rf1S4MRhjlVooOlQXFhlx/berK1fx69D5HwsXi43GmGkhrYJtQJnle
	 Dj19/se2czviVfC3vwPHER32ZAoQJqs3Y0tPmwv8H03VkmFh3ulVkcVN5ta+Z8N2bMg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792411695;
	bh=Wvn04IitRQ2xOhOFB0dcl8ZXfrTXUuXblHbukw6MVjs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=t0ydB5G1y8rtaGXY1vQXVQfpP14hL2Ywn9rIYPgsdwykWP0S5FMruXf0ux+iuRFkq
	 ehMsghsh9Nz/3dgY/SMAX13evZ1fLsMeC8o8PiTZH5hEKwQSurz/IL3wOE8MzRtlt4
	 8YqJ2IczMmDJzwgWqRrmLouJ61UswNbvjwuc+LQatYdK5WaGTwMtbk9WE9TIgBHVOs
	 p6e/r278VOPQvFPYBSVz6BjdZuMhDunlVFEY6WDhxkj2iPFXf8d32qhOb12D0Kso8v
	 Ab1K/ecaYrVV0KZ17vigkOni3V275BI6KFrNt2vUcb5GXMmi2DVy9VIyGtDQ7e/p9s
	 HK7maw3ENYgpQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 17ACE405A9;
	Mon, 19 Oct 2026 12:08:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id B2C001E9
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 12:08:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9888F80F90
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 12:08:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id B2ABYjl28wBN for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 12:08:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org CFB7C80F8C
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792411693;
 b=E6kX6bmJbpXSwA3dzM9tkgVvLEB0p4OvJg2Ze7+5+Z1f2I1BEJpQvINR6pq5g5U03Lv5
 K7aHZGLKnywONMKtjzcUW8xXszWrI0SkzmyGFXid3TaKYyMjiVxVsAxVbXpWa9y3fnphg
 DKUHQgAhruJL66rsesYVfUwg7hoDG6IgVrq8/uoQpdLFtqCu5LXv7rG9uXWmd9o8Mx18M
 LL6rmmrA+3xxjVzEt8nI76SFdbnMEKSdH7BRlYhBi2b+QbAIs0/QWdj6nnBJMPnzH+rtF
 KP9od0UcLoHYP2KwwPVr3cbc9VEETBpMRIEvP51EDkkj606P7XrF+a0r/uVy1+I4VZA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792411693;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=Wvn04IitRQ2xOhOFB0dcl8ZXfrTXUuXblHbukw6MVjs=;
 b=SdKG6z35u4uvKS/yDXaT9648rF0XnokgaYbq/CreI64S2b6BGyvI9gsz2CsuNwdwb709
 Aegmxwf6Rhvy/XaliLiMckRjTCMCUUbXbd9XSTu8hOt1t9Dd4iYMTW2sBOEFwp2KFDwdO
 Z9L4NExXOY69sPD2BteQ4feEcvk4BMCjv6+hmZkM7rx400z4LVooGllc+9fKO/rg1KKCR
 rsvMbe/GQ2PDY7gVzcBfqysdScAdvmQUs+BPt0WItBLcrs2nkO3pU0t8MMDrbjE8Nxnb0
 06IqA++yikQO2fKET44ZK6yTbpJ5VybespWZThHjXW8wxR3HErkihzNNiLyuXMaVZtA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=bd0vJmd+; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=sumit.garg@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=bd0vJmd+
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CFB7C80F8C
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 12:08:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4E4E860136;
 Mon, 19 Oct 2026 12:08:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 977291F000C5;
 Mon, 19 Oct 2026 12:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792411691;
 bh=Wvn04IitRQ2xOhOFB0dcl8ZXfrTXUuXblHbukw6MVjs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=bd0vJmd+ooYUN2SUozcrQ7T8zEX+v7uxtc6uBYp3X/rb84eEAB5+HQf70SlGWhFpR
 Z/dYsuMHl4XRWyyRr/RVWHLMdqFY7ZMIFsdyS0Lb+9nwbWGMunoXH+MwIK7ar8+b09
 RZ5Ui0EGssbr1sZhM/l+ImCkliaQmAGu/KD4tgH5V7pi7EJZo+DVumI5HhFS80GWFX
 /vReYiiuyFXpAf1et6dBGnTP/agYJgcMpmCDE6DLnBdYzrBMYfWd17zkjMYwt+zQNH
 /2NIk011h6pMw9vuS8zuHeysHK/LxQ9HDEe072IGxBZE5mMiE3/IGuwbfluRRB8MTQ
 +gq1iEkamWW4Q==
Date: Mon, 19 Oct 2026 17:38:04 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Cc: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com, quic_varada@quicinc.com,
 balaji.selvanathan@oss.qualcomm.com, dlechner@baylibre.com,
 u-boot-qcom@groups.io, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH RESEND v1] Revert "configs: qcs615/qcs9100: Enable
 watchdog autostart"
Message-ID: <atYIJAuvYTaxYn9R@sumit-xelite>
References: <20261008103308.707564-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20261008103308.707564-1-aswin.murugan@oss.qualcomm.com>
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

On Thu, 08 Oct 2026 at 16:03:08 +0530, Aswin Murugan wrote:
>This reverts commit a50e32bae6abc8d86d4fa6fff9a1c8f5c88baa4f.
>
>The watchdog is not required during normal U-Boot operation on
>these platforms and can be enabled by users if needed.
>
>Reviewed-by: Casey Connolly <casey.connolly@linaro.org>
>Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
>---
> configs/qcom_qcs615_defconfig  | 2 --
> configs/qcom_qcs9100_defconfig | 2 --
> 2 files changed, 4 deletions(-)

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

>
>diff --git a/configs/qcom_qcs615_defconfig b/configs/qcom_qcs615_defconfig
>index ccc3bf24ab1..f4760703c94 100644
>--- a/configs/qcom_qcs615_defconfig
>+++ b/configs/qcom_qcs615_defconfig
>@@ -22,5 +22,3 @@ CONFIG_QCOM_GENERATE_MBN=y
> CONFIG_TEXT_BASE=0x9fc00000
>
> CONFIG_FASTBOOT_BUF_ADDR=0xa1600000
>-
>-CONFIG_WATCHDOG_AUTOSTART=y
>diff --git a/configs/qcom_qcs9100_defconfig b/configs/qcom_qcs9100_defconfig
>index 1cc04cb96bd..84b2b9a1bd1 100644
>--- a/configs/qcom_qcs9100_defconfig
>+++ b/configs/qcom_qcs9100_defconfig
>@@ -14,5 +14,3 @@ CONFIG_ENV_IS_IN_SCSI=y
> CONFIG_ENV_SCSI_PART_UUID="71cb9cd0-acf1-b6cb-ad91-be9572fe11a9"
> # CONFIG_ENV_IS_DEFAULT is not set
> # CONFIG_ENV_IS_NOWHERE is not set
>-
>-CONFIG_WATCHDOG_AUTOSTART=y
>-- 
>2.34.1
>
