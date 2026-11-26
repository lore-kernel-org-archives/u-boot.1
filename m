Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3979606A31E
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 13:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=UJsB8Xk5;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JxxMelVr
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4F64060A8B;
	Thu, 26 Nov 2026 13:57:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qok2kzgI2MjR; Thu, 26 Nov 2026 13:56:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6CA62608E6
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795701419;
	b=j4xWa0cieYijWo8fqw4cJMoznjAIYrvwAwe2ABnt3ww/6ZvFFUb6zhLZG4iXOihQrx0D
	 +XdoF7OK1vIp94sYh6Zk2n7BIgTjexlvykmf0GW/NzhtotpDTAcgjoVBYQstmSP8H4T+u
	 Nm93mMXG0se0/DBexIyce5FY8ZGqIkAZCJG2bzFmhio3C8gJ01IFS63eFTbYFKjtQhrkn
	 oskRCiBkUVPfBKDzgvB6wkjGtk/wNiamjabqhJVPACZvh6W+86ygcXn1NisFxH2SdcB2m
	 358Wbix+L8lqXsH6xdhQF1/SLAU7QGi/NooE2HkTehN46QVzFDEgyx/uWbIiX5Ytv3A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795701419;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=YN95CLBTECgmyCx8XU5zybaSagGzezPXH2AFM0uOMBU=;
	b=CNkjFJ97LmrL12fD1JF1JDbJJWG8iXfrtAG3kLf0FvTsn/wwzTAwsa9/0dcJKXQNdgI/
	 RU2cOR4PtxcYgJC4bxbYyJwVMBoEMjozZ1rx9AF1RP186hLPwpVXYScivm21JQ0rhBb2g
	 kn4D7iyWYMRtM6ujuL6Cw+S8It/yxhm5c7mCgmhB1a1DvfpPG+sW9xw6tu4YSzEf8iHto
	 Y3DVcz6SId1BuLrKkU48cZR4fRfM610j+/lFNLR5xSycaJFOdhlnFRf60aGDoRkdYjGbU
	 H0aiVdTUwWEd50x7eAZYDh8UfCRIzgStjuBYorsodpKRKmbLJpXKyeL0FLNv0Yi5z0Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795701419;
	bh=YN95CLBTECgmyCx8XU5zybaSagGzezPXH2AFM0uOMBU=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UJsB8Xk5LM0w0ab4R93klCGnwlrZSYUcX+xeyqj9YK9ss+c0zIRPUxmvA/L/oVUxM
	 4YWxMgTuc0dodX8sqj7Q8lBgAw62dJSMYRTTpz6H8aKPnp1W/G2mK1TWocTO3CB01D
	 7U26liLLAOh09NKeNuXq6CYnvuM0psiSQWhEMg00IYrlHHq6GiwdccvFTbufmd8bRv
	 DXpTV5ZLIAYwK0svOSYNcj5QLmQilci1707JKgrVybn0+XDozIMvOXUhMu2Rq8Y/kk
	 1NfeIA9Px89WoBNklXdfvvO0lOItRGBtQRdWt/fseOJ/I9O5hH30rLopUxWgafJBcl
	 PXrC0TmftICNg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6CA62608E6;
	Thu, 26 Nov 2026 13:56:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id C855622B
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 13:56:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AE7DE404A4
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 13:56:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cL14VJMV3pgb for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 13:56:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org D300440111
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=sumit.garg@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=JxxMelVr
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D300440111
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 13:56:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CBB3C44206;
 Thu, 26 Nov 2026 13:56:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 198BB1F000C4;
 Thu, 26 Nov 2026 13:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795701415;
 bh=YN95CLBTECgmyCx8XU5zybaSagGzezPXH2AFM0uOMBU=;
 h=Subject:From:To:Cc:In-Reply-To:References:Date;
 b=JxxMelVrc8GybkKrFHjA6UnOu/O1rJBeaPpboi9XKH9IlHt+5unIyWNaZjr0Qp5aH
 Ahli4O3mmv4uTKmYmsyYtCu2wLAZuD457BR1wz5hgu3O3zse5c6FbBuZ4YB0wWs27d
 hD2e6nDe95S1sfpQPTl4G4kXQ5RdITcjuCwPct+h0vwI6Sj/7CBEjMwqvbDIn5C9wt
 X7TVRf3ykj6V7ynHqBJLktfSbNoQZFYWnpn0cvOu7XJ2EHTE+JMAAc3VnKvK4mStNK
 bekv1mo9eb1ChByJdrx0mNkCb+iLfi3ElbzZNmLIKZs+oePhHPORdBrrj2ra1VlH+3
 v2oanejwLC+HA==
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 0/5] net: add Qualcomm SA8775P EQOS support
From: Sumit Garg <sumit.garg@kernel.org>
To: Manikanta Mylavarapu <manikanta.mylavarapu@oss.qualcomm.com>
Cc: trini@konsulko.com, lukma@nabladev.com, jerome.forissier@arm.com, 
 casey.connolly@linaro.org, neil.armstrong@linaro.org, sumit.garg@kernel.org, 
 varadarajan.narayanan@oss.qualcomm.com, balaji.selvanathan@oss.qualcomm.com, 
 aswin.murugan@oss.qualcomm.com, royzah@gmail.com, 
 deepak.g10@oss.qualcomm.com, dlechner@baylibre.com, 3305708832@qq.com, 
 macpaul.lin@mediatek.com, jstephan@baylibre.com, jbx6244@gmail.com, 
 dlan@kernel.org, anshuld@ti.com, u-boot@lists.u-boot-project.org, 
 u-boot-qcom@groups.io, kelam@qti.qualcomm.com, gpotnuru@qti.qualcomm.com
In-Reply-To: <20261124090210.2560500-1-mmanikan@qti.qualcomm.com>
References: <20261124090210.2560500-1-mmanikan@qti.qualcomm.com>
Date: Thu, 26 Nov 2026 19:26:45 +0530
Message-Id: <179570140529.130558.4031608193267654959.b4-reply@b4>
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
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-11-24 14:32 +0530, Manikanta Mylavarapu wrote:
> From: Manikanta Mylavarapu <manikanta.mylavarapu@oss.qualcomm.com>
> 
> Add support for the DWMAC Ethernet controller and QMP SGMII
> SerDes used on Qualcomm SA8775P based lemans platforms.
> 
> The series adds the required DWMAC EQOS support, including
> platform-specific DMA channel and MTL register offsets and
> 2.5 Gbps link speed support. It also adds the QMP SGMII
> SerDes driver and completes the Ethernet configuration for
> the SA8775P-based Lemans EVK.
> 
> Dependencies:
> https://lore.kernel.org/all/20261103-emac_clock-v1-1-357a9291d35d@oss.qualcomm.com/
> https://lore.kernel.org/all/20261104-gpio-qcom_spmi-v1-1-2e430ec0843d@oss.qualcomm.com/
> https://lore.kernel.org/all/20261103-lemans-ethernet-v1-1-cb7c648e5c78@oss.qualcomm.com/
> 
> V2:
> https://lore.kernel.org/u-boot/20261121063919.3313168-1-mmanikan@qti.qualcomm.com/
> 
> V1:
> https://lore.kernel.org/u-boot/20261115181936.1750625-1-mmanikan@qti.qualcomm.com/
> 
> Changes in v3:
> - Let SPEED_2500 fall through to the SPEED_1000 GMII handling.

Please keep the entire changelog in the cover letter. What changed in v2
is all missing here.

-Sumit

> 
> Manikanta Mylavarapu (5):
>   net: dwc_eth_qos: allow platform-specific DMA channel and MTL offsets
>   net: dwc_eth_qos: support 2.5Gbps link speed
>   phy: qcom: add SA8775P DWMAC SGMII SerDes driver
>   net: dwc_eth_qos: qcom: add SA8775P support
>   clk: qcom: sa8775p: add SGMI reference clock
> 
>  configs/qcom_qcs9100_defconfig            |   1 +
>  drivers/clk/qcom/clock-sa8775p.c          |   3 +-
>  drivers/net/dwc_eth_qos.c                 |  48 ++-
>  drivers/net/dwc_eth_qos.h                 |  41 +-
>  drivers/net/dwc_eth_qos_qcom.c            | 276 ++++++++++++
>  drivers/phy/qcom/Kconfig                  |   8 +
>  drivers/phy/qcom/Makefile                 |   1 +
>  drivers/phy/qcom/phy-qcom-qmp-pcs-sgmii.h |  21 +
>  drivers/phy/qcom/phy-qcom-sgmii-eth.c     | 486 ++++++++++++++++++++++
>  9 files changed, 850 insertions(+), 35 deletions(-)
>  create mode 100644 drivers/phy/qcom/phy-qcom-qmp-pcs-sgmii.h
>  create mode 100644 drivers/phy/qcom/phy-qcom-sgmii-eth.c
> 
> 
> base-commit: 990319a87e60fbc2ac26a386f2ec940e4f97978f
> -- 
> 2.34.1
> 


