Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E776C606A31C
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 16:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=t+gIRnTL;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=REYDyaSS
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BCC7A80DD3;
	Mon, 16 Nov 2026 16:17:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RVb1-LnXSMKL; Mon, 16 Nov 2026 16:17:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1DE8D80F56
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794845856;
	b=Qcbij1cpro4DNdfQsz1u7RhZdEUihJ975JxzUe5Bu2QmKgrCAAMG62EP5fmuaxkCsGMs
	 Rd1PHld6TmFVIsZMZIeWNV6KIpsAFyvP/pP8qOpDwZ00aX9q+4/te3aDdHV51jtkuucyy
	 3oT0OMOieP0rDnxZKzrARa2nXISGzvbQb4xaUywYWfUOzCigA1GjWyHKWs0QfPJnaSgwV
	 mGaZro4j9voM+MPjQ3KwLkps3iBpoaf+HR0ROeIQ+RTy1/Yo/7rhR8KiR9YZJ8nIb2C1E
	 Pz0KhG2RydMNMfX5TVFUGFWH2ASNqb8FyoRUy0WnrWL1B5uQG27YnbnJebTrFQwN3GA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794845856;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Kiuy3wMuHBKhYMkH7k9d9DHdLvkKyX4FX4yp1yVKx/4=;
	b=YzXJZVyBoRost8tCURXD/T8vAephqvkbzLJMlWFZnN6PDcn9HZXKzMDkPGwDtCrKF1QE
	 cPc0HWD+0XaZwOcPaJC9f05vq43puWc0a8kUDxTzWMpGKOpA2XQ5egCLhZU0Xs5+uoSvg
	 Xb7W4jYdEnqydEmuzncodLg0t5mv7Dc45xIS2dwhXeSjfeUPnFbajNeu2VHyg8rP6e4H0
	 ++0xbAD4DWoAVDcei2PvU61hBgTAcR0W3yQybkM4DWeLTrlvlfSbcSJrEmGqPyHLdK+Mr
	 S0pE2eOPmW2danY1FWn5pkjkPqajfkBuwHBdj/zwst3n5BLBfwBjRYEUvscTFSEI6Bg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794845856;
	bh=Kiuy3wMuHBKhYMkH7k9d9DHdLvkKyX4FX4yp1yVKx/4=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=t+gIRnTLHDXKdtgTBEg5bqXfMM8+fQA0DdUV5Uu2aCCTm7lE5UISbEmpk0WeCa8SM
	 zv1aWJ+mNXOSMQKTEJf5cPcW4eTtTFdHmf6TAVEF43CCzqyYXM6zERTs5GPCUmsWXo
	 oq74xex0rOD3Js4eIorWwTQuxiaiwAN4biET0tsf/RC5y2FPI6xnOMD5AV8VM9BA8E
	 g2rhvQr5ke8uVg/JU1PWZVF4+0+ZTmx5c/eA7LwzicBaQuDmMeSPdnGckDuzPXF3LI
	 df7Z8xi1Od6HZRNJ3XPt8k3Pdo3PqNGs1kd483nbakyhsqOqjuNQEttr2WJnNALx5Z
	 et3pcBu16lnJw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1DE8D80F56;
	Mon, 16 Nov 2026 16:17:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 366DF169
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 16:17:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1C6E040282
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 16:17:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qnQUYR0OmJQF for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 16:17:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 6B35A4009E
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=sumit.garg@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=REYDyaSS
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6B35A4009E
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 16:17:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3068962E9B;
 Mon, 16 Nov 2026 16:17:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF3BF1F000C4;
 Mon, 16 Nov 2026 16:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794845851;
 bh=Kiuy3wMuHBKhYMkH7k9d9DHdLvkKyX4FX4yp1yVKx/4=;
 h=Subject:From:To:Cc:In-Reply-To:References:Date;
 b=REYDyaSSB9dCs5Vex2LRRhteUzAvl3yNUZwf4Kt5Ja51wFS9z8Y2ogyDNP8WunJzh
 UB3FIGjIKkNB5buu0ghkpxczca3kGSJEa3ejpsszH8eEDHJa0eNEdlWZfp08Qt0RbI
 fn6PkQsLvtEXtVI8sqzrTvBSNxfMMHnQeCVrICVLNoZ41R/k3xS3UVzADYAIMzSDl7
 8eLk1qim1+wS+muVUsSEdq30Mr+MkcOY6R1gX18YC2jQGvhWWZByGCj+4zY469fxTG
 32olcMjTTpHXKPHf4b0aQH7mhmb/CXybU178hMBSSEajyc0RDDeasPcnMHSl+fx2aD
 /IyB30UbPC7MA==
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v1] Revert "configs: qcs615/qcs9100: Enable watchdog
 autostart"
From: Sumit Garg <sumit.garg@kernel.org>
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Cc: casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, trini@konsulko.com, quic_varada@quicinc.com, 
 balaji.selvanathan@oss.qualcomm.com, dlechner@baylibre.com, 
 u-boot-qcom@groups.io, u-boot@lists.u-boot-project.org
In-Reply-To: <20260911093210.1351573-1-aswin.murugan@oss.qualcomm.com>
References: <20260911093210.1351573-1-aswin.murugan@oss.qualcomm.com>
Date: Mon, 16 Nov 2026 21:47:28 +0530
Message-Id: <179484584836.21534.11587452169906378214.b4-reply@b4>
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

On 2026-09-11 15:02 +0530, Aswin Murugan wrote:
> This reverts commit a50e32bae6abc8d86d4fa6fff9a1c8f5c88baa4f.
> 
> The watchdog is not required during normal U-Boot operation on
> these platforms and can be enabled by users if needed.
> 
> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
> ---
>  configs/qcom_qcs615_defconfig  | 2 --
>  configs/qcom_qcs9100_defconfig | 2 --
>  2 files changed, 4 deletions(-)

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

> 
> diff --git a/configs/qcom_qcs615_defconfig b/configs/qcom_qcs615_defconfig
> index e060fac3726..27666a8129d 100644
> --- a/configs/qcom_qcs615_defconfig
> +++ b/configs/qcom_qcs615_defconfig
> @@ -22,5 +22,3 @@ CONFIG_REMAKE_ELF=y
>  CONFIG_TEXT_BASE=0x9fc00000
>  
>  CONFIG_FASTBOOT_BUF_ADDR=0xa1600000
> -
> -CONFIG_WATCHDOG_AUTOSTART=y
> diff --git a/configs/qcom_qcs9100_defconfig b/configs/qcom_qcs9100_defconfig
> index efd6c63f212..082106157bb 100644
> --- a/configs/qcom_qcs9100_defconfig
> +++ b/configs/qcom_qcs9100_defconfig
> @@ -14,5 +14,3 @@ CONFIG_ENV_IS_IN_SCSI=y
>  CONFIG_ENV_SCSI_PART_UUID="71cb9cd0-acf1-b6cb-ad91-be9572fe11a9"
>  # CONFIG_ENV_IS_DEFAULT is not set
>  # CONFIG_ENV_IS_NOWHERE is not set
> -
> -CONFIG_WATCHDOG_AUTOSTART=y
> -- 
> 2.34.1
> 
> 


