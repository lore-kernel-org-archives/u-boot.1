Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D59606A321
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 12:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=fvWgG3Bu;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GOGWNAqD
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E618F60A63;
	Thu, 26 Nov 2026 12:32:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Hg6VFyJSYB4Z; Thu, 26 Nov 2026 12:32:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 048CB60A54
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795696329;
	b=ISNGaVdHLHOmVJ7uZSAgKrpnhJKX27NPAbT1Ut5J/FzFriaHK1YBMNrnYqrlOj4kcUhd
	 SHDLbHh38fx0rc1fBBzLc/T9B05An6PINJx6PUq6q4l6HuZqauW+yg/KUU4is6NdgdOjF
	 6P5ecse7CCTm6XAamZR3rq5eSLTv5YX/oEz4Q/obgwB9CApVBdxumnPWPBnxwPU03GxdJ
	 rtRnios+tKbUkEVq9fWStZFyC0LvXHwDAISe7DZVCS8fR2fdmd14N9EeKXoywMr394KiY
	 ZROmQ/4rZM6u3P1227TUdMErVlO0sWh5t8B7Oid2/Uh+KkeDtFXU2+r73UTTMg/JjIQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795696329;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=CGCcXK+e4Np0Fjtb9XOCXfmS3L/Q//3WAhUNMYCCNpk=;
	b=imZZgOqkZXJTbNjMQqPQ5btUcRrSH2IgCF2FkIjycCSTG1c0S7Ncg+8TIs93+imtgDTE
	 921ckOl54YGmEf2JbSCvhO96aYIZjgUgJnvKkIJaSwXVcbWYglUXGEsylDhmH1iAFEEvM
	 8sw+QBbBmyVjfoRBCTbJXy1c/YMEBFP3jyKuy/bVP9kcS6vXJObSoUZdURQ1OkO8ogTqK
	 uLiADi2nqrdJK2cuKdAC79n1+UzZp8X22d98+W9+YYNFCCeeYuz+jWwjNiK+gLWPrilLf
	 bRVlf2AMyuC9RMjG2mBPgC8BUU+W6Pk7iurExG/RSR6Faa1wtIwVRwKupFh+QgicszQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795696329;
	bh=CGCcXK+e4Np0Fjtb9XOCXfmS3L/Q//3WAhUNMYCCNpk=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fvWgG3BuyUpEGOyRBAbdbeHpSBgVC3tuX0dSLE+isLASzH8CoIziXxl059wX1NoQl
	 kXG0PaFeXWsXM55HwGaaIRp42OQVKapp70ZZvEOhVW5XJxqrJQZBbXSSn80qljWB2i
	 FwTAr7dsV13w3vI+SNJNsQGbqffH7+f72nqCBbwfhfhDX5RDMIk5eWhy6yoW61C7/s
	 4aQOUSwX0UuzSgoV/1K7xsu8HaSumjxml/D/bdqKi5UUUYE2iPBN49yQveZIlhne+r
	 P/g0D7A5+iXW4HWIhyTYbApsqzLuHL/DyFEO0hHwUCYws8Aen0MWcjYq6EnQvPjnJi
	 V6B2/IoNhkKtw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 048CB60A54;
	Thu, 26 Nov 2026 12:32:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3769F1AB
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 12:32:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1D9AB40897
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 12:32:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DtKdTYjTLGfC for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 12:32:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 37C5840816
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=sumit.garg@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=GOGWNAqD
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 37C5840816
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 12:32:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E4D3262FB1;
 Thu, 26 Nov 2026 12:32:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 773A31F000D1;
 Thu, 26 Nov 2026 12:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795696322;
 bh=CGCcXK+e4Np0Fjtb9XOCXfmS3L/Q//3WAhUNMYCCNpk=;
 h=Subject:From:To:Cc:In-Reply-To:References:Date;
 b=GOGWNAqD9tksmzW75YUdY060ucO4X0TALT4MY22Wff6XfnCKk6uA90PSP6wNyNPag
 /E7tKi07Phmtc9V2qNtzScBGwA/4lx7JFETHJTuPOQiWV/2s/qmPzm3njTNnqRV9pp
 uNJlYdeLLQyIOs7QeBfW3jCmc26ImWJXjF//+nmHT/+XHALCJc617F/Pfof83iBo+9
 AixbIZs4CW1Huv3uS0HkVsNkoHI2atj9EBlFWZrV8uoSUq6G1iIo1raZZ4H4UA5t0o
 nM20DtZ+IsTXfj06HfSycipjOyhG7mAls7mtOGjticR7p3PZa976K+4WkZVrcQgHBy
 uzpiY9xcS6atQ==
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] configs: Rename qcs9100 defconfig to lemans defconfig
From: Sumit Garg <sumit.garg@kernel.org>
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Cc: casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, trini@konsulko.com, quic_varada@quicinc.com, 
 balaji.selvanathan@oss.qualcomm.com, u-boot-qcom@groups.io, 
 u-boot@lists.u-boot-project.org
In-Reply-To: <20261009115920.2021086-1-aswin.murugan@oss.qualcomm.com>
References: <20261009115920.2021086-1-aswin.murugan@oss.qualcomm.com>
Date: Thu, 26 Nov 2026 18:01:57 +0530
Message-Id: <179569631710.130558.3000273272438928435.b4-reply@b4>
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

On 2026-10-09 17:29 +0530, Aswin Murugan wrote:
> Lemans EVK is an open evaluation board based on the QCS9100 SoC and
> serves as the default reference platform for the QCS9100 family.
> 
> The existing qcom_qcs9100_defconfig currently targets the
> qcs9100-ride-r3 board. Rename it to qcom_lemans_defconfig and update
> it to select the lemans-evk device tree instead.
> 
> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
> ---
> Change in v2:
> 	Updated the commit msg
> 
> Link to v1 - https://lore.kernel.org/u-boot/20260417093924.3357296-1-aswin.murugan@oss.qualcomm.com/
> ---
>  configs/{qcom_qcs9100_defconfig => qcom_lemans_defconfig} | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>  rename configs/{qcom_qcs9100_defconfig => qcom_lemans_defconfig} (91%)

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

> 
> diff --git a/configs/qcom_qcs9100_defconfig b/configs/qcom_lemans_defconfig
> similarity index 91%
> rename from configs/qcom_qcs9100_defconfig
> rename to configs/qcom_lemans_defconfig
> index 1cc04cb96bd..1710e317fc0 100644
> --- a/configs/qcom_qcs9100_defconfig
> +++ b/configs/qcom_lemans_defconfig
> @@ -9,7 +9,7 @@
>  CONFIG_TEXT_BASE=0xaf000000
>  CONFIG_QCOM_GENERATE_MBN=y
>  CONFIG_FASTBOOT_BUF_ADDR=0xdb300000
> -CONFIG_DEFAULT_DEVICE_TREE="qcom/qcs9100-ride-r3"
> +CONFIG_DEFAULT_DEVICE_TREE="qcom/lemans-evk"
>  CONFIG_ENV_IS_IN_SCSI=y
>  CONFIG_ENV_SCSI_PART_UUID="71cb9cd0-acf1-b6cb-ad91-be9572fe11a9"
>  # CONFIG_ENV_IS_DEFAULT is not set
> -- 
> 2.34.1
> 
> 


