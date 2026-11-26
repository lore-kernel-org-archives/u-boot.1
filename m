Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE497606A31E
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 13:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=vCH0kdLI;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f/KZdcoZ
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 34CE160A83;
	Thu, 26 Nov 2026 13:43:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9LX2pbzqW2OX; Thu, 26 Nov 2026 13:43:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 70B4D60A67
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795700617;
	b=V8O6EMJlGuGoQdJ0j0RGuIwaqgeln71Cej1UlFw6MSQNPvy5b5aIU0g4Mj3VMXIfxjH/
	 vC1csyvzUNubYYo6IuXq+UNy0YjREfZva6afbmLxoNy7XyajucHvkB4eszAJxXBsMQzkh
	 dRWVL6m9k7yPDCo1sc2lys0XxwWQL7flf9h8wffu91M4+5jlax0dGIO8YQmRCbzwlFKsY
	 PzhOJwHS8kOVBK/A5g5nMl2dR3tKWadgegvw5WwjhrCVnRPbJUw7Soio4xCMUNCysoa98
	 VJ1QN1SSFTDSyfcVBwd9C3pnY64tN8DUlvaqeNpO3h4bpq0iRSN1B8BMD3aVL/Ra01Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795700617;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=JRHzGdSAZgs8OytZP26BTSpopwnQw/0kDD4DAbGKXpg=;
	b=qDGcIffonNdtWHf0K4tWNAyNM0TZinL0325GFhKB/TxiYgJP5aVHzEclnu/kJhBSqxhu
	 +6xh4RPRU8aIZ7hWoF3I5esug/dOsoesVOe7uKsvrUmvqa2lSW4CnPYM3WM+rWkoSOmZg
	 RmAplsW5p+d3aqo74UmjHz+pggPXyuUiI2+ez4J7k8tJm+E3WdhlfJfLsjbe1R4l+77yZ
	 Qn9BhUXA0W1WAV923ntjKcDA13DXhbOB/8c8wMFMsT0dV0zsvAbQA/hENn4tDwvLGNblg
	 7k58hC3+XafYmm2DsBLrS5Dvs0p3CW9Jr30JM2L+TMxaZM5OTmnQUCpwTZQtqXhg03g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="f/KZdcoZ";
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795700617;
	bh=JRHzGdSAZgs8OytZP26BTSpopwnQw/0kDD4DAbGKXpg=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vCH0kdLIocct6XNtygMqM+LuUuVCf3knVx3AVH4VRXUSEExmwXPJzlWE2iaow2mKo
	 Ju0tmnQsMl6K22kgXX/bJ047BE9fXUqyLgCo13RLq4qnFzlfeOVSqgeCCSywlTIJ9e
	 XAwi2u0jYNhP3UooHVc4bSPb37gRc9dAcbN1Mj7qzVrEjkR77C0JyGlTF48dvY1cnu
	 wOoMal1wdiT+2waDXoHA5//zUguEvHwf/1jDusNai9IYTTd+c3YIheFvoqjfVKuM7X
	 cUXqNkn7XJrQ5ZP+ivD7AVfSUKt+SNYemcYXE0E13GSnU2e3bw19J9x2kDKUOeSXv1
	 VOqXKTBQRz2Pw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 70B4D60A67;
	Thu, 26 Nov 2026 13:43:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0941D260
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 13:43:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E3B2F60A67
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 13:43:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KCkQNtEUFTZQ for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 13:43:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 39BD960A55
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=sumit.garg@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=f/KZdcoZ
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 39BD960A55
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 13:43:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id EBD20625EE;
 Thu, 26 Nov 2026 13:43:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2B091F000C0;
 Thu, 26 Nov 2026 13:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795700613;
 bh=JRHzGdSAZgs8OytZP26BTSpopwnQw/0kDD4DAbGKXpg=;
 h=Subject:From:To:Cc:In-Reply-To:References:Date;
 b=f/KZdcoZwAh0T9MBN/na03BOUOMXvOL8x3Ude1s3rYtaRxIpMHCJk5eM/5Gs964fi
 wqcfzyg5Wo9ulBAtF9/LMwRB5MhuXzq8DR5X307pgDFoeZRu0VZQYrnd+tbRlkbfPj
 rUnBgy5v8tkw87aLB1cnPO/i9SpBaQnesJxcsw2fspl7j4nxGcCPgPNJ9TkkD4DS0r
 4MoyiBaklJKOv1WXpDforhrpGIWTUe7rsfz2haEdaN4cgBK/114wDWlyinxjXGL9wM
 oNrn6s5dKEi3cNXEfoxQj6f5DXUWbSRm1+kYSSZ0LgdPThZgX0zyOhAWH9ffM6bZSG
 kxH4ljfgF/FfQ==
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 5/6] arm64: dts: qcom: lemans-evk: complete Ethernet
 configuration
From: Sumit Garg <sumit.garg@kernel.org>
To: Manikanta Mylavarapu <manikanta.mylavarapu@oss.qualcomm.com>
Cc: trini@konsulko.com, lukma@nabladev.com, jerome.forissier@arm.com, 
 casey.connolly@linaro.org, neil.armstrong@linaro.org, sumit.garg@kernel.org, 
 varadarajan.narayanan@oss.qualcomm.com, balaji.selvanathan@oss.qualcomm.com, 
 aswin.murugan@oss.qualcomm.com, deepak.g10@oss.qualcomm.com, 
 dlechner@baylibre.com, 3305708832@qq.com, jstephan@baylibre.com, 
 macpaul.lin@mediatek.com, junhui.liu@pigmoral.tech, 
 quentin.schulz@cherry.de, jbx6244@gmail.com, 
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io, 
 kelam@qti.qualcomm.com, gpotnuru@qti.qualcomm.com
In-Reply-To: <20261115181936.1750625-6-mmanikan@qti.qualcomm.com>
References: <20261115181936.1750625-1-mmanikan@qti.qualcomm.com>
 <20261115181936.1750625-6-mmanikan@qti.qualcomm.com>
Date: Thu, 26 Nov 2026 19:13:22 +0530
Message-Id: <179570060282.130558.8249364064775218347.b4-reply@b4>
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

On 2026-11-15 23:49 +0530, Manikanta Mylavarapu wrote:
> From: Manikanta Mylavarapu <manikanta.mylavarapu@oss.qualcomm.com>
> 
> The Lemans EVK Ethernet port is wired for 2500BASE-X operation and the
> SGMII SerDes requires the L4A regulator for its 0.9 V analog supply.
> 
> Set the maximum Ethernet speed to 2.5Gbps and describe the missing
> SerDes supply.
> 
> Signed-off-by: Manikanta Mylavarapu <manikanta.mylavarapu@oss.qualcomm.com>
> ---
>  dts/upstream/src/arm64/qcom/lemans-evk.dts | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/dts/upstream/src/arm64/qcom/lemans-evk.dts b/dts/upstream/src/arm64/qcom/lemans-evk.dts
> index a45485b54a5..5775e558f11 100644
> --- a/dts/upstream/src/arm64/qcom/lemans-evk.dts
> +++ b/dts/upstream/src/arm64/qcom/lemans-evk.dts

Patching dts/upstream subtree isn't allowed, why can't you adapt driver
to work with upstream kernel DT?

-Sumit

> @@ -522,6 +522,7 @@
>  &ethernet0 {
>  	phy-handle = <&hsgmii_phy0>;
>  	phy-mode = "2500base-x";
> +	max-speed = <2500>;
>  
>  	pinctrl-0 = <&ethernet0_default>;
>  	pinctrl-names = "default";
> @@ -979,6 +980,7 @@
>  
>  &serdes0 {
>  	phy-supply = <&vreg_l5a>;
> +	vdda-0p9-supply = <&vreg_l4a>;
>  
>  	status = "okay";
>  };
> -- 
> 2.34.1
> 
> 


