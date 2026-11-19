Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B12606A320
	for <u-boot@archiver.kernel.org>; Thu, 19 Nov 2026 23:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=bHKTZ5/c;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=RYIVxAcx
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 68D4260D8E;
	Thu, 19 Nov 2026 23:51:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id K_CCM5wsmW54; Thu, 19 Nov 2026 23:51:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B334560E02
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795132316;
	b=nxSrX0zF7kOLin+kESfdzwk5EZIp8ElcPCw55YjpyXgnuxY+P9M1vmKz3AiCYHAdRDGK
	 uYX0Ae6zv6X7YgE4Fs1bHnmaCPIK/QUnnXhxz90SO22yQZyw1tqJLSeAY/vOshSREhKfC
	 pynr001BRDELEYHzT2HxYS8fPYw7ZVeDHE1xO1U2aCaBC9gIpaPSuRCt4Y7hIrUPXOMcC
	 lmuLKcXI3kDAQ6+mfw5YM8Z/sVq/2iXI12xkBlFSgZxdtNUV+h9JYju69YNX+m51smM2a
	 irolixo2UbWNWoirsSFVUk/J587k4puZQj6a1gTDMi9zewCVwZHmEa3yePPxLA6XtDQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795132316;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=cnLWP2KnWVpzJ2xNxnRyxxvWLVc9dXMQ9waqomITYKk=;
	b=OIJwqYIloyoqjAzsanUv+gqc6a6rq0+fA9iJQJ1o/rr3GttsiiqbtitJGEuDiXi0QEv2
	 SWDZNNMqyX/e+bxOL2Y8E7IZYEiWYpRt0CIFw2ZzJ+ycO4jD8/b2l7NeLT4y/97bOt+HZ
	 IO2EH974AhHy0/KuiQj9DT6omfd+DDrqYklwRYIHcF4iqwI15+mknLUd9EQYGeeQdrYCN
	 YoFPe9vgDjyk4sL+QU/7uDNlgsBx0ol07cY2I0ysbwNXRj2D5bHcCl5KXztQ6c21HR7cU
	 +hQ1ewquYZuFuucbfvU8dBSdc7LhAV8tAb39ZdnO2eRPSeFH/0rklvGVcP5suL6E56g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795132316;
	bh=cnLWP2KnWVpzJ2xNxnRyxxvWLVc9dXMQ9waqomITYKk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bHKTZ5/cJj/rhio9EfWc++IB/K/hCunQfRgA+UKHf4wZP0nZdmR30DyYToqctjXjc
	 gq81dqVqBS4CuoIlJyHpgHNUvQ3Eypho6lYXs/wBBbGURb17XuGjjB2QT2+b/wVDhA
	 wNXJiCK3gkjLpFa9qwLWKigDLhy+SI05K7Ak20GAeU2/Y6YMmD4uF3kPfFcl0EZTGW
	 N8vHYueAQDV6K4KUJSSSPZIsWjVTRX8dtemy//rXsjLsjjZlYrP4XREz+VcFiy85ys
	 LsWoKYvaeRVyrHhQQKJRNGRDplmWiHGlZFARReEXAmvkdpUiL0jw2tKusQG9wQtDn/
	 EAdVMkOqB15vA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B334560E02;
	Thu, 19 Nov 2026 23:51:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 9069A260
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 23:51:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7694440E05
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 23:51:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hY8SdQ7PAjBs for <u-boot@lists.u-boot-project.org>;
 Thu, 19 Nov 2026 23:51:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A320240DF5
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32b; helo=mail-ot1-x32b.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=RYIVxAcx
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A320240DF5
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 23:51:52 +0000 (UTC)
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7f84a55e31aso237852a34.2
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 15:51:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795132312; x=1795737112;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=cnLWP2KnWVpzJ2xNxnRyxxvWLVc9dXMQ9waqomITYKk=;
 b=RYIVxAcxBHpfpZnDrNxhf2H7+vo8RPAJOL5sD9zRRCZERmFML2puEotZTecaee0ZKv
 oV9bj1CMutUippmIkA1wqEqIelRTp76JUVAalOKKKChCNs8+hPCi2yqnP5LwqZ6tmV4i
 LNsrNtqI9y4dUiefy89RXfJlDe5lLSo0/xox4G0aZPUWA4dhUt2MGDCMKSeGnNW3zw9V
 7EzyBGa1NP/D3a9657QrfVHWBjXmPaikrMVmQgxN6/mB8NSa7wyJ/CzynA2+gDAFWnxR
 AP49iWO6QGojjubbx42751Nc2wO2flwyhlyYIYu/pyKNRQ62Fm8kojSezNVbf3WfWGYN
 kWcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795132312; x=1795737112;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cnLWP2KnWVpzJ2xNxnRyxxvWLVc9dXMQ9waqomITYKk=;
 b=ANf84TtJulmN4ADkbvBgQJPTUsTrSZrwWxowCZznOYnzfivpnR79jzddw6jLFoGY9Z
 RrEbIGq9MYYTl1FY+uqunf/mp8irIE1BJKcWLzXdDXfsqmVXqiwclGFZvvo7EUrR0zYW
 D0sqHbCeyRzCpCizg7FHs/tcpQtBs95/T4MGMUHH1xquyo85P89vBLJGoupe1z90uyUt
 /GDco8DR5QtXnm1x8UnTvI8/9uM8/PrduF+wnCPP2wuiad/raoQvUhXP7+RjsoZJjUrs
 vNU1zFOFgLcRCyJQ9TG4QG6QhEPusNKVGWlyGPNVev5lXOTFz2ZewI7zU4o/mVqJWaN3
 t3aQ==
X-Forwarded-Encrypted: i=1;
 AL+hErFM0bn5XJQvRvyLER+KUoOGEqZDWgPwT+9sA4XbCwkMNWZwOALXgMQZ5vhOHaCqFY/+LLwHEmY=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z90D00n1KNYdi9R9sqjINbGr7t1bQ/OiLZhJO7hTNvNftc3V0ja
 RJIHXRgsCWX1JK+O3UWyRT1G4hA6eeIO2fKcKL8tF22h7qbtueGmP7nfbaj2kUq0W6M=
X-Gm-Gg: AYBFou3yU9ke+Y6hfJl+1UzseBdSrxO5cZcOLDVJ5rit/7EdTsY6BYW3qXegW5PpOmF
 uRe42IzJq4kj7DpH+44GHzp3QVXxuccTVDdDRS/nUQrddlaFvkYSdG4KY/IOeCeMkQfSEr37aGD
 a3ogtclfBLYLFTHQN+QffFC9OYHyW0BouhQqIrY5GuXr9IDyuzY7IsEpQFJNYj4peCuooeQBiQD
 Wl3bwUkc6Rkkpa0gwxbmPKGIeGwpXAJk531RUXeD9MIBRy89ePr6JfAvVY7qaOxVWNKDPSxYdss
 emegnCr9kaUBYm9x8NmxU1YDVwr4sbGtB8nHoLMfepU5LyyCXRi7uD4Da+HbmegaUkrzQ87DRUX
 nWQcjsf3BFIVoSuDeQrXlNCdXZZJzprsUOFVPy0AVmtheXtgw88k2Rg6nm3Pn/gj8A8hF6NHxbS
 qvA/kc4Cl8VZlan5Npvhuxht5FS1pb/XHV+5miJPoWXcb8XQ6HzP3JpkN/370KKEYqdXc8OPNZd
 Z04/HFUCuev3+JnUFSV6BTqcA5GNW92rfrhP11LqT8VzzBujEnjOX6FhCAuSvqE/888kEr+CIih
 YKYxsOF1VkbSmailrJwqOV9go6vA36PBwmaTaLH9dyuynk1OCYUQtyTjakEW4Zn5a8NYvGiQd+9
 ZhQkZA/ojRC6/5x+OQ7nq0HV6
X-Received: by 2002:a05:6830:640e:b0:862:c172:769c with SMTP id
 46e09a7af769-86315ab1b56mr2039544a34.29.1795132311896; 
 Thu, 19 Nov 2026 15:51:51 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:43e1:bc37:7497:58db?
 ([2600:8803:e7e4:500:43e1:bc37:7497:58db])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-863168f3964sm812847a34.14.2026.11.19.15.51.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Nov 2026 15:51:50 -0800 (PST)
Message-ID: <9e662c2f-eab2-486e-9fba-9d0679bf3c8f@baylibre.com>
Date: Thu, 19 Nov 2026 17:51:48 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/7] configs: mediatek: add a UFS RPMB fragment
To: Carlo Caione <ccaione@baylibre.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
 u-boot@lists.u-boot-project.org,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>,
 Jens Wiklander <jenswi@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jan Kiszka <jan.kiszka@siemens.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Jerome Forissier <jerome.forissier@arm.com>, Johan Jonker
 <jbx6244@gmail.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Julien Stephan <jstephan@baylibre.com>,
 Macpaul Lin <macpaul.lin@mediatek.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Quentin Schulz <quentin.schulz@cherry.de>
References: <20261116-genio720-ufs-rpmb-minimal-v2-0-b64eefcfb0f6@baylibre.com>
 <20261116-genio720-ufs-rpmb-minimal-v2-6-b64eefcfb0f6@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20261116-genio720-ufs-rpmb-minimal-v2-6-b64eefcfb0f6@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/16/26 2:45 PM, Carlo Caione wrote:
> RPMB-backed services need provisioned storage and matching secure
> firmware. Keep them optional so the Genio 520 and 720 can use their
> existing defconfigs for both eMMC and UFS. Share the OP-TEE client
> configuration and select the UFS device tree with DEVICE_TREE.
> 
> Signed-off-by: Carlo Caione <ccaione@baylibre.com>
> ---
>  board/mediatek/MAINTAINERS         | 1 +
>  board/mediatek/mtk-ufs-rpmb.config | 3 +++
>  configs/mt8189.config              | 2 ++
>  3 files changed, 6 insertions(+)
> 
> diff --git a/board/mediatek/MAINTAINERS b/board/mediatek/MAINTAINERS
> index eaf645086f6..8159cdbaf5f 100644
> --- a/board/mediatek/MAINTAINERS
> +++ b/board/mediatek/MAINTAINERS
> @@ -4,6 +4,7 @@ S:	Maintained
>  F:	arch/arm/dts/mt8189*
>  F:	arch/arm/dts/mt8371-genio-*
>  F:	arch/arm/dts/mt8391-genio-*
> +F:	board/mediatek/mtk-ufs-rpmb.config
>  F:	configs/mt8189.config
>  F:	configs/mt8371_genio_*
>  F:	configs/mt8391_genio_*
> diff --git a/board/mediatek/mtk-ufs-rpmb.config b/board/mediatek/mtk-ufs-rpmb.config
> new file mode 100644
> index 00000000000..dcb59e6ce18
> --- /dev/null
> +++ b/board/mediatek/mtk-ufs-rpmb.config
> @@ -0,0 +1,3 @@
> +CONFIG_CMD_OPTEE_RPMB=y
> +CONFIG_SUPPORT_UFS_RPMB=y
> +CONFIG_EFI_MM_COMM_TEE=y
> diff --git a/configs/mt8189.config b/configs/mt8189.config
> index a60f67bd7cb..54de8d94861 100644
> --- a/configs/mt8189.config
> +++ b/configs/mt8189.config
> @@ -51,6 +51,8 @@ CONFIG_MTK_SERIAL=y
>  CONFIG_SPI=y
>  CONFIG_DM_SPI=y
>  CONFIG_MTK_SNOR=y
> +CONFIG_TEE=y
> +CONFIG_OPTEE=y
>  CONFIG_USB=y
>  CONFIG_USB_XHCI_HCD=y
>  CONFIG_USB_XHCI_MTK=y
> 

FYI, we have some other changes in-flight that might cause merge conflict
with this. So I can take this patch through the Mediatek tree after the
rest of it lands if we want.

Otherwise,

Reviewed-by: David Lechner <dlechner@baylibre.com>

