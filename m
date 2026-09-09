Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2689CC79FB7
	for <u-boot@archiver.kernel.org>; Wed,  9 Sep 2026 19:39:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 225C94083F;
	Wed,  9 Sep 2026 19:39:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FnrJu-9Ms092; Wed,  9 Sep 2026 19:39:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 0DE0740AFC
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788982772;
	b=pfTVUIs07OKb/SepSwnoPBVbzC7H5xugrK93fA2Arg7kdCvAjVpFa+mCjE9oC8yi/PKJ
	 uKxBMsUld37RT3kBL5LZHvCwOQtPqUaVyRALlPFCLgobNE6N+PF5o1imR3r45QjMIthDF
	 VomECY5FZOZaALHj3G+PZbk0JjKLKGNswEAu/z/6GBYvJ1GgapXW3PZZx8nojf1ruKEPn
	 bm5OzYvwkQj3MrK9gkB+swVQUPzx66q3aK3D2ovpy9o4NXZlWjzLN5QwqcBTapWLnXrFj
	 I3YiVMvwxphGgCB6E8nLTKHSYQZBlWCiXUE5v6d5mGLyHSqJsJmFLqdI8jhdgSL/hNg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788982772;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=g0KTkaYczYK2x3whV3VHU3mWMFU5Ad9Xc8lfozgakLo=;
	b=i67c0BfwGbVi2AZw4/gFFyS1HHQu5u6cHDckQ27ipyYNpa67aALFvIQ0NIYm5u+5EbmP
	 yWKYUl+NvomF/hwOn8n02xI8jIjT7FttrONmsQ5lVyc5ySVDNEcD6djEU7zuX7BoLwATq
	 9hw7lUtI2aKfbmMMI54WiVHM/xA1pS5qzJEqZPzi5pdCXFf0t5KDpXXtFJAKWfyBd0467
	 L20UCxGP9d4XMj4tLw0re6OQLzfUN73Vkhb5vQRNtKQA8ZmDveqlw2jNBdT56EzKmr4SU
	 dIWLG/M7l/Ss2RBlnaLzrp+MyTUqf1lfj+CXMMIUNOP9fUfkotQwGsbWNhCrf3nmP9Q==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=CMCwhxAK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788982772;
	bh=g0KTkaYczYK2x3whV3VHU3mWMFU5Ad9Xc8lfozgakLo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qwuPzyWMNgRdZrW5CPEf3ZvVMqkoiUkYFIvibvJjevTcmLi0C4+coj+DFhVSssKMP
	 K014ueacsOd+SQyW5b8YgAw5PUZsvsuNnC2Lcz0OhxxbuI+QkikhKzLOWZLfa6+2Bc
	 7zm9KOS61dqTMEeyH2sw4+bs/SN3zIlTwRFSdTGmGulyRkYLUYmZKqpbQIUa9W+PlL
	 wlJf5/i6tZA52EoyHQTFTz7SKnKM8psu/HQAz2fR4q/oBP4I0tfjk3cwbB1hD9xWU3
	 GMM7N2vUjzSU48VvcsZVfUqFFgGQbKCqjvw484Yvl/YDFxb4vNeObnM5pHyTjjl4Hs
	 pb74hS9+awVxg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0DE0740AFC;
	Wed,  9 Sep 2026 19:39:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id D6A1732F
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 19:39:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BC99B40AFC
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 19:39:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6NF2322eYDOi for <u-boot@lists.u-boot-project.org>;
 Wed,  9 Sep 2026 19:39:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 97C5940AE3
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::21"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788982770;
 b=mV2zlcM6LPRvbfGw8FYJsadTGWwtD+qM0i4vAJsyLKhTW4N0T/lU2gZWGHj2CEACMCAH
 mtd4RKgS0LcUdpTNKZ+SNjHHG+SCHWm6dDWfg1rT1gE3MpSbtRIrDuk33afAHaMQZhTsO
 kbNaBwXZdw3H2FXzPwFiNjMe/k4/n7mp+jW/Aww7KRUVEqLTvco5o7BGDFkm12prtGYzV
 L8NljuSK7e/0auJqZlJgWRm8O9vqyihwst8Xe+00NsYbhHcQfKSFT8mRUqUVYkiI1tdQx
 57aeGjdU96IYKTG41wt0+epI1MhR+eX5CddofUf/SfxXb+goFihRASsjbPCdn4aqutw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788982770;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=g0KTkaYczYK2x3whV3VHU3mWMFU5Ad9Xc8lfozgakLo=;
 b=CacuFfE5Apfv35S4r2ZiAR7XzNEvVrhwlidMm5Fa6QBgbatrULoA/1HTSNKqRplipQya
 M8zNGRMyfJPbtSkUmaRgnSdoiK4/UDRP5eAHJ/gi+ipCsZ/SkAH79WHMy0SENS7GCkRZn
 q2nv2BA26qN2oUTc03uSaGWxnKerGcz8oh+rhuWNAv8LJkZ5ir9oaDrvPLpPgaNtHEabH
 kRFCgXcu6p84F01ytE5pWrQRtCAXbes4v4vqytS9xFyZdr5xSS5WBzLn00r4X8Rc8RDfX
 wKAQI1tRgOlR5RXJ7tpHZBT+7yN6nHmDuu5uZ77Vr0RaVtJFYhxTzrAKnbyildipgzQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=CMCwhxAK; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::21"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:31::21; helo=mail-oo2-x21.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=CMCwhxAK
Received: from mail-oo2-x21.google.com (mail-oo2-x21.google.com
 [IPv6:2607:f8b0:4864:31::21])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 97C5940AE3
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 19:39:29 +0000 (UTC)
Received: by mail-oo2-x21.google.com with SMTP id
 46e09a7af769-7fcc35eeb48so959039a34.1
 for <u-boot@lists.u-boot-project.org>; Wed, 09 Sep 2026 12:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788982768; x=1789587568;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=g0KTkaYczYK2x3whV3VHU3mWMFU5Ad9Xc8lfozgakLo=;
 b=CMCwhxAKRpuLIk7tXFVZfucZQKyrRoj7madwrTyZy4D0k8uPYteT2l4P7UwwZAdpq4
 Pe63+cx7O+pv1LxYa1IgitIysiLo8RqQ8upvyTAE0gucWE2jyhJiZ6o0Yfiy3JCW89/d
 K2JsKPYTJYocsy8WIS34dL5r+/PPRmPurDuvNkBwp156ly4TCpAiKmCtvjYXm8boaCaP
 ozHH4sDS4WRKquY2HL0J0oiAZ1Aslrf0dHRil4pkmbX99xCMVVtzxScEl7tcUEDM7LX7
 NWwJdhckr7136mdEQBW/6TmCcdW3crMU+OKDCR9rXa/4uKAITnbbqKLAJItvYnK7F4rr
 MIDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788982768; x=1789587568;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=g0KTkaYczYK2x3whV3VHU3mWMFU5Ad9Xc8lfozgakLo=;
 b=C1+Mxn1p/2xYwcVdWKnV01Ym17e8h9E7WvAbf+we5BZw1PR3uakLkXB+prgCWQ5ALY
 d12koWRWj4XPrCFMd49bk4BULI8DnsJY4TfDJvVzHX7akG9K3SmiAqgcfplzm+TTVMUi
 uZdzqefNqr0BYfDWCG+EjeWmpcYHpd84OACXMf6WsekMlqPsiLL+VHwBi9Vh+FmlVabz
 +oWN/8/DUT525/y8R8ki2DfE6aQ5s33NlkwPi3UrX9pkObt+Kuz/MimCZExavJaMzbxb
 9Dav92lfwVvekSU1K1KZEF/DvQqo2Lps92fWHWpZfjcxKWHj2QPasdsrNUj2nRVieGOA
 E7/w==
X-Forwarded-Encrypted: i=1;
 AKwUvBxLNYQZ2tZZ1nKy1aFTlKVeXIgDHTnpeVCrCtQ/1MEN6nnh+6zv49PV9VrYz5P/shsdo0AA2Es=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nJ0gH+kwK98S+ab3bjKG5RnyDy5Jt1rCiP0k5aWUlUuK/BINef
 fBakPjSoOHHIbD/Vdo3LLG+vjj34rk3g8ZyyOiaiKoZFeb1kal7XlN6QlFr3nDZTtoY=
X-Gm-Gg: AYBFou1FkBU/gR4tM7rDsNEU5XqYmEOvkcfvavS+7bC98P/wvXkm3z+BwQRFW5sMWQ1
 BMX9UYGbLmt5wskx3EFRn7CrCmOSbvcTWxVe5BTIPhoJJms0p6iSLX/JBEZacf3tYomv59WHB7f
 AE/OkoInbUpGdIYGIfxqniT+TdbopiTqNtQrq44Chlss9aR8d/li8E2s/z2/LJLjCch5FSXXnPo
 6mcjjseZ4Brq6iCPUtvjEmlGBj9KDkWe9PYAaYQF5yHlVWoVXxrzfHsZYxfQBpT9u/eVrIg7ANc
 orVCgU5SxbNSnUxlWoyevWiUgJiS/LpBYKZ04QiYZmkthKEuWMC42PmX56cGq+KFL+VNMEMXIhd
 65y5la3+PzxhSAzbwDauRozKkF82wnJrqoeKAJbkYJns67udgF/dYJk4gZztEQWMvCTd+pkT3Y+
 /ILVOTXMcgPyn376Qp3HoNoR294RpjhQl5DFlPo/RtFCtilheB7oMzGEloRxhrU8AoBkNOispM5
 pfDVwabl0tiGU0VrmYFJCijc0izvy8HDbKLQPjBu/eFWFY=
X-Received: by 2002:a05:6830:3499:b0:7f6:705b:ffe7 with SMTP id
 46e09a7af769-800f1a35138mr9141461a34.14.1788982768056; 
 Wed, 09 Sep 2026 12:39:28 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:a8c5:6332:5ea:5b26?
 ([2600:8803:e7e4:500:a8c5:6332:5ea:5b26])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7fcc45d7852sm12536906a34.20.2026.09.09.12.39.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Sep 2026 12:39:27 -0700 (PDT)
Message-ID: <9671c6b7-9b70-4b7b-9811-7947597b1c0a@baylibre.com>
Date: Wed, 9 Sep 2026 14:39:26 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/6] arm: mediatek: build Genio 510 and 700 boot images
 with binman
To: Carlo Caione <ccaione@baylibre.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 u-boot@lists.u-boot-project.org
Cc: Julien Masson <jmasson@baylibre.com>, Quentin Schulz <u-boot@0leil.net>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Julien Stephan <jstephan@baylibre.com>,
 Macpaul Lin <Macpaul.Lin@mediatek.com>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Vitor Sato Eschholz <vsatoes@baylibre.com>, Johan Jonker
 <jbx6244@gmail.com>, Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Alexey Charkov <alchark@gmail.com>,
 Suhrid Subramaniam <Suhrid.Subramaniam@mediatek.com>,
 Arnaud Ferraris <arnaud.ferraris@collabora.com>,
 =?UTF-8?B?UGFibG8gU3VuICjlravmr5Pnv5Qp?= <pablo.sun@mediatek.com>
References: <20260906-ccaione-upstream-mt8390-spl-v6-0-4d4a11d5741d@baylibre.com>
 <20260906-ccaione-upstream-mt8390-spl-v6-3-4d4a11d5741d@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260906-ccaione-upstream-mt8390-spl-v6-3-4d4a11d5741d@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 9/6/26 10:30 AM, Carlo Caione wrote:
> Genio 510 and Genio 700 use an external DDR loader before SPL, then load
> the remaining firmware from a FIT. Keep packaging optional because this
> platform firmware is built outside U-Boot.
> 
> Separate the container, loader/SPL payload and firmware FIT descriptions
> so their layouts can be reused independently. Generate the loadables list
> to include every OP-TEE segment.
> 
> Request AArch64 BootROM entry for the DDR loader. Disable SPL binman
> symbols since U-Boot proper lives in the separate FIT, not alongside SPL.
> 
> Signed-off-by: Vitor Sato Eschholz <vsatoes@baylibre.com>
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> Signed-off-by: Carlo Caione <ccaione@baylibre.com>
> ---
>  arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi      |  9 ++
>  arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi      |  9 ++
>  arch/arm/dts/mtk-genio-binman-u-boot.dtsi          | 12 +++
>  .../dts/mtk-genio-bootloaders-binman-u-boot.dtsi   | 98 ++++++++++++++++++++++
>  .../dts/mtk-genio-loader-spl-binman-u-boot.dtsi    | 17 ++++
>  arch/arm/dts/mtk-genio-mtk-boot-binman-u-boot.dtsi | 26 ++++++
>  arch/arm/mach-mediatek/Kconfig                     | 41 ++++++++-
>  board/mediatek/MAINTAINERS                         |  2 +
>  common/spl/Kconfig                                 |  1 +
>  9 files changed, 214 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi b/arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi
> index 223f1371b9e..10b9a142f37 100644
> --- a/arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi
> +++ b/arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi
> @@ -4,4 +4,13 @@
>   * Author: Julien Stephan <jstephan@baylibre.com>
>   */
>  
> +#include <config.h>
>  #include "mt8390-genio-common-u-boot.dtsi"
> +
> +#ifdef CONFIG_MTK_GENIO_BOOT_IMAGES
> +#define MTK_BOOTLOADERS_DESCRIPTION "MediaTek Genio 510 bootloaders"
> +#define MTK_BOOT_CHAIN_DESCRIPTION "Genio 510 boot chain"
> +#include "mtk-genio-binman-u-boot.dtsi"
> +#include "mtk-genio-mtk-boot-binman-u-boot.dtsi"
> +#include "mtk-genio-bootloaders-binman-u-boot.dtsi"
> +#endif
> diff --git a/arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi b/arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi
> index 223f1371b9e..6230b016ca0 100644
> --- a/arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi
> +++ b/arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi
> @@ -4,4 +4,13 @@
>   * Author: Julien Stephan <jstephan@baylibre.com>
>   */
>  
> +#include <config.h>
>  #include "mt8390-genio-common-u-boot.dtsi"
> +
> +#ifdef CONFIG_MTK_GENIO_BOOT_IMAGES
> +#define MTK_BOOTLOADERS_DESCRIPTION "MediaTek Genio 700 bootloaders"
> +#define MTK_BOOT_CHAIN_DESCRIPTION "Genio 700 boot chain"
> +#include "mtk-genio-binman-u-boot.dtsi"
> +#include "mtk-genio-mtk-boot-binman-u-boot.dtsi"
> +#include "mtk-genio-bootloaders-binman-u-boot.dtsi"
> +#endif
> diff --git a/arch/arm/dts/mtk-genio-binman-u-boot.dtsi b/arch/arm/dts/mtk-genio-binman-u-boot.dtsi
> new file mode 100644
> index 00000000000..ff4557e5072
> --- /dev/null
> +++ b/arch/arm/dts/mtk-genio-binman-u-boot.dtsi
> @@ -0,0 +1,12 @@
> +// SPDX-License-Identifier: (GPL-2.0-only OR MIT)
> +/*
> + * Copyright (c) 2026 BayLibre SAS
> + * Author: Julien Stephan <jstephan@baylibre.com>
> + * Author: Carlo Caione <ccaione@baylibre.com>
> + */
> +
> +/ {
> +	binman: binman {
> +		multiple-images;
> +	};
> +};
> diff --git a/arch/arm/dts/mtk-genio-bootloaders-binman-u-boot.dtsi b/arch/arm/dts/mtk-genio-bootloaders-binman-u-boot.dtsi
> new file mode 100644
> index 00000000000..d8aea85f47e
> --- /dev/null
> +++ b/arch/arm/dts/mtk-genio-bootloaders-binman-u-boot.dtsi
> @@ -0,0 +1,98 @@
> +// SPDX-License-Identifier: (GPL-2.0-only OR MIT)
> +/*
> + * Copyright (c) 2026 BayLibre SAS
> + * Author: Julien Stephan <jstephan@baylibre.com>
> + * Author: Carlo Caione <ccaione@baylibre.com>
> + */
> +
> +&binman {
> +	bootloaders {
> +		filename = "bootloaders.img";
> +
> +		fit {
> +			description = MTK_BOOTLOADERS_DESCRIPTION;
> +			#address-cells = <1>;
> +			fit,fdt-list-val = "u-boot";
> +
> +			images {
> +				uboot {
> +					description = "U-Boot";
> +					type = "firmware";
> +					os = "u-boot";
> +					arch = "arm64";
> +					compression = "none";
> +					load = <CONFIG_TEXT_BASE>;
> +					entry = <CONFIG_TEXT_BASE>;
> +
> +					u-boot-nodtb {
> +					};
> +
> +					hash {
> +						algo = "sha256";
> +					};
> +				};
> +
> +				atf {
> +					description = "ARM Trusted Firmware BL31";
> +					type = "firmware";
> +					os = "arm-trusted-firmware";
> +					arch = "arm64";
> +					compression = "none";
> +					load = <CONFIG_MTK_GENIO_BL31_LOAD_ADDR>;
> +					entry = <CONFIG_MTK_GENIO_BL31_LOAD_ADDR>;
> +
> +					atf-bl31 {
> +					};
> +
> +					hash {
> +						algo = "sha256";
> +					};
> +				};
> +
> +				@optee-SEQ {
> +					fit,operation = "split-elf";
> +					description = "OP-TEE";
> +					type = "firmware";
> +					os = "tee";
> +					arch = "arm64";
> +					compression = "none";
> +					fit,load;
> +					fit,entry;
> +					fit,data;
> +
> +					tee-os {
> +					};
> +
> +					hash {
> +						algo = "sha256";
> +					};
> +				};
> +
> +				uboot-fdt {
> +					description = "U-Boot control devicetree";
> +					type = "flat_dt";
> +					arch = "arm64";
> +					compression = "none";
> +
> +					u-boot-dtb {
> +					};
> +
> +					hash {
> +						algo = "sha256";
> +					};
> +				};
> +			};
> +
> +			configurations {
> +				default = "conf";
> +
> +				@conf {
> +					description = MTK_BOOT_CHAIN_DESCRIPTION;
> +					fit,firmware = "atf", "uboot";
> +					fit,loadables;
> +					fdt = "uboot-fdt";
> +				};
> +			};
> +		};
> +	};
> +};
> diff --git a/arch/arm/dts/mtk-genio-loader-spl-binman-u-boot.dtsi b/arch/arm/dts/mtk-genio-loader-spl-binman-u-boot.dtsi
> new file mode 100644
> index 00000000000..c97797405b7
> --- /dev/null
> +++ b/arch/arm/dts/mtk-genio-loader-spl-binman-u-boot.dtsi
> @@ -0,0 +1,17 @@
> +// SPDX-License-Identifier: (GPL-2.0-only OR MIT)
> +/*
> + * Copyright (c) 2026 BayLibre SAS
> + * Author: Julien Stephan <jstephan@baylibre.com>
> + * Author: Carlo Caione <ccaione@baylibre.com>
> + */
> +
> +/* Include within a section: the loader and SPL form one contiguous payload. */
> +ddr-loader {
> +	type = "blob-ext";
> +	filename = "ddr-loader.bin";
> +	size = <CONFIG_MTK_GENIO_DDR_LOADER_SIZE>;
> +};
> +
> +u-boot-spl {
> +	size = <CONFIG_SPL_MAX_SIZE>;
> +};
> diff --git a/arch/arm/dts/mtk-genio-mtk-boot-binman-u-boot.dtsi b/arch/arm/dts/mtk-genio-mtk-boot-binman-u-boot.dtsi
> new file mode 100644
> index 00000000000..a7ee09feba0
> --- /dev/null
> +++ b/arch/arm/dts/mtk-genio-mtk-boot-binman-u-boot.dtsi
> @@ -0,0 +1,26 @@
> +// SPDX-License-Identifier: (GPL-2.0-only OR MIT)
> +/*
> + * Copyright (c) 2026 BayLibre SAS
> + * Author: Julien Stephan <jstephan@baylibre.com>
> + * Author: Carlo Caione <ccaione@baylibre.com>
> + */
> +
> +#include <linux/stringify.h>
> +
> +&binman {
> +	mtk-boot {
> +		filename = "mtk-boot.bin";
> +
> +		mkimage {
> +			args = "-T", "mtk_image",
> +			       "-a", __stringify(CONFIG_MTK_GENIO_BROM_LOAD_ADDR),
> +			       "-e", __stringify(CONFIG_MTK_GENIO_BROM_LOAD_ADDR),
> +			       "-n", CONFIG_MTK_BROM_HEADER_INFO;
> +
> +			section {
> +				pad-byte = <0>;
> +#include "mtk-genio-loader-spl-binman-u-boot.dtsi"
> +			};
> +		};
> +	};
> +};
> diff --git a/arch/arm/mach-mediatek/Kconfig b/arch/arm/mach-mediatek/Kconfig
> index 5e6c50ca64d..e572cfe8571 100644
> --- a/arch/arm/mach-mediatek/Kconfig
> +++ b/arch/arm/mach-mediatek/Kconfig
> @@ -207,9 +207,48 @@ config SYS_CONFIG_NAME
>  config MTK_BROM_HEADER_INFO
>  	string
>  	default "media=nor" if TARGET_MT8518 || TARGET_MT8512 || TARGET_MT7629
> -	default "media=emmc" if TARGET_MT8516 || TARGET_MT8365 || TARGET_MT8183 || TARGET_MT8188 || TARGET_MT8189 || TARGET_MT8195
> +	default "media=emmc;arm64=1" if TARGET_MT8188
> +	default "media=emmc" if TARGET_MT8516 || TARGET_MT8365 || TARGET_MT8183 || TARGET_MT8189 || TARGET_MT8195
>  	default "lk=1" if TARGET_MT7623
>  
> +config MTK_GENIO_BOOT_IMAGES
> +	bool "Build MediaTek firmware images"
> +	depends on TARGET_MT8188 && SPL
> +	select BINMAN
> +	select MTK_GENIO_IMAGE_CONTRACT
> +	help
> +	  Enable binman to assemble the MediaTek BootROM image and firmware
> +	  FIT from U-Boot and external platform firmware components.
> +
> +config MTK_GENIO_IMAGE_CONTRACT
> +	bool

Do we actually need this separate option since only MTK_GENIO_BOOT_IMAGES
selects it? Seems like we could just use MTK_GENIO_BOOT_IMAGES instead.

> +
> +if MTK_GENIO_IMAGE_CONTRACT
> +
> +config MTK_GENIO_BROM_LOAD_ADDR
> +	hex "BootROM payload load address"
> +	default 0x201000 if TARGET_MT8188
> +	help
> +	  Address at which the MediaTek BootROM loads and enters the external
> +	  DDR loader.
> +
> +config MTK_GENIO_DDR_LOADER_SIZE
> +	hex "DDR-loader image region size"
> +	default 0x4b000 if TARGET_MT8188
> +	help
> +	  Size reserved for the external DDR loader at the start of the
> +	  BootROM payload. This is also the offset of U-Boot SPL and must match
> +	  the offset used by the loader when copying SPL to DRAM.
> +
> +config MTK_GENIO_BL31_LOAD_ADDR
> +	hex "BL31 load and entry address"
> +	default 0x54601000 if TARGET_MT8188
> +	help
> +	  Address at which SPL loads and enters BL31. This must match the
> +	  platform firmware's link address and secure-memory layout.
> +
> +endif
> +
>  config MTK_TZ_MOVABLE
>  	select ARCH_MISC_INIT
>  	select OF_SYSTEM_SETUP
> diff --git a/board/mediatek/MAINTAINERS b/board/mediatek/MAINTAINERS
> index d0d25b096e5..57bb3095305 100644
> --- a/board/mediatek/MAINTAINERS
> +++ b/board/mediatek/MAINTAINERS
> @@ -24,6 +24,8 @@ S:	Maintained
>  F:	arch/arm/dts/mt8188-u-boot.dtsi
>  F:	arch/arm/dts/mt8390-genio-common-u-boot.dtsi
>  F:	arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi
> +F:	arch/arm/dts/mtk-genio-*-binman-u-boot.dtsi
> +F:	arch/arm/dts/mtk-genio-binman-u-boot.dtsi

These look out of order. I would go with a mechanical sort order here.

>  F:	arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi
>  F:	configs/mt8188.config
>  F:	configs/mt8370_genio_510_evk_defconfig
> diff --git a/common/spl/Kconfig b/common/spl/Kconfig
> index 0618f42c941..f9b453df766 100644
> --- a/common/spl/Kconfig
> +++ b/common/spl/Kconfig
> @@ -194,6 +194,7 @@ config SPL_SHOW_ERRORS
>  config SPL_BINMAN_SYMBOLS
>  	bool "Declare binman symbols in SPL"
>  	depends on SPL_FRAMEWORK && BINMAN
> +	default n if MTK_GENIO_BOOT_IMAGES
>  	default y
>  	help
>  	  This enables use of symbols in SPL which refer to other entries in
> 

