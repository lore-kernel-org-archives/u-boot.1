Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52F6EE88D85
	for <u-boot@archiver.kernel.org>; Sat,  4 Apr 2026 05:52:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B376383C14;
	Sat,  4 Apr 2026 07:52:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.b="GlS74Gjq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E2E0840AA; Sat,  4 Apr 2026 07:52:54 +0200 (CEST)
Received: from sender4-op-o16.zoho.com (sender4-op-o16.zoho.com
 [136.143.188.16])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 320E483642
 for <u-boot@lists.denx.de>; Sat,  4 Apr 2026 07:52:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@ziyao.cc
ARC-Seal: i=1; a=rsa-sha256; t=1775281967; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=AS1UMSztue3woEU+2JgZTPdCmaNOnktnLw965uL/rR7noZ4mxtLKnudYbQhNwgkzXRpdgJTO+IyS61bBy8TKKXUcsNYziUVNDQes7RkRj1sCQ61b9VxJEswSjZ8dvg6iS+MleajU14BVS7kIjDq7GkQzNiGuS8n3aga3wJtT6h0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1775281967;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=SbjGd2Nvn0TtM0wOtRvvLx8r4MY3fUNNiqW1rBpBHPs=; 
 b=hqEmx72mKzyfngBBVhwppOxoXHZXS3Z3cenxh4GE7/l+STgUG9EOTYh584f+6cfdp7gdmOO/CCiSWJNneWMI5ZEEskT8WYutZIo1PUtFFdKU3HBCmDmTJwypU+kblqBnP97VJVtN+8Flcy9XBOuTiSeHEAjPoYNMCArmCP9UziM=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1775281967; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=SbjGd2Nvn0TtM0wOtRvvLx8r4MY3fUNNiqW1rBpBHPs=;
 b=GlS74Gjqry8moIR3AiaQkOKBimcUcehhqWDYVCadKBzUW2CAZigXe44qZfvq71+0
 YyMcePB7/iAzcrRkjq1cpFX+qaU9doCDUaeDVk2G3Uixk8TgtAMumwrQWkC2u90lAIK
 KrHOOewFaehgJFWMPhmXnNBgJ9YGowWtjpdmb6hc=
Received: by mx.zohomail.com with SMTPS id 1775281964441566.2147470795677;
 Fri, 3 Apr 2026 22:52:44 -0700 (PDT)
Date: Sat, 4 Apr 2026 05:52:24 +0000
From: Yao Zi <me@ziyao.cc>
To: Lobanokivan11 <lobanokivan11@gmail.com>, u-boot@lists.denx.de
Cc: u-boot-qcom@groups.io, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, trini@konsulko.com
Subject: Re: [PATCH] xiaomi pad 5 support
Message-ID: <adCnGAUnLRcZExgp@pie>
References: <20260403160127.10605-1-lobanokivan11@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260403160127.10605-1-lobanokivan11@gmail.com>
X-ZohoMailClient: External
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On Fri, Apr 03, 2026 at 07:01:26PM +0300, Lobanokivan11 wrote:
> ---
>  board/qualcomm/xiaomi-nabu.env                |   11 +
>  configs/xiaomi-nabu_defconfig                 |    6 +
>  dts/upstream/src/arm64/qcom/pm8150.dtsi       |   10 +-
>  dts/upstream/src/arm64/qcom/pm8150b.dtsi      |    8 +

Devicetree (and bindings) in dts/ are pulled from devicetree
upstream[1] (i.e., Linux kernel), and you shouldn't directly modify
files in it. If you need a commit in dts upstream that hasn't
synchronized into U-Boot yet, tools/update-subtree.sh might be used for
cherry-picking one commit once it has landed in Linux master.

However, I don't see such changes to pm8150(b).dtsi in Linux 7.0-rc6, so
you might want to push the changes to Linux upstream first.

>  .../src/arm64/qcom/sm8150-oneplus-common.dtsi |  545 ++++++++
>  .../arm64/qcom/sm8150-oneplus-guacamole.dts   |   70 +
>  .../src/arm64/qcom/sm8150-oneplus-hotdogb.dts |   65 +
>  .../src/arm64/qcom/sm8150-wcd9340.dtsi        |   86 ++
>  .../src/arm64/qcom/sm8150-xiaomi-cepheus.dts  |  575 ++++++++
>  .../src/arm64/qcom/sm8150-xiaomi-nabu.dts     | 1175 +++++++++++++++++
>  dts/upstream/src/arm64/qcom/sm8150.dtsi       |  102 ++
>  11 files changed, 2652 insertions(+), 1 deletion(-)
>  create mode 100644 board/qualcomm/xiaomi-nabu.env
>  create mode 100644 configs/xiaomi-nabu_defconfig
>  create mode 100644 dts/upstream/src/arm64/qcom/sm8150-oneplus-common.dtsi
>  create mode 100644 dts/upstream/src/arm64/qcom/sm8150-oneplus-guacamole.dts
>  create mode 100644 dts/upstream/src/arm64/qcom/sm8150-oneplus-hotdogb.dts
>  create mode 100644 dts/upstream/src/arm64/qcom/sm8150-wcd9340.dtsi
>  create mode 100644 dts/upstream/src/arm64/qcom/sm8150-xiaomi-cepheus.dts
>  create mode 100644 dts/upstream/src/arm64/qcom/sm8150-xiaomi-nabu.dts

What's the relationship between Xiaomi Pad 5 and
"oneplus-guacamole/hotdogb"? The latter doesn't seem to match subject of
the patch, which is "xiaomi pad 5 support". You probably want to have a
separate commit for the non-xiaomi stuff.

And, for the same reason as above, you should neither create files in
dts/ manually. I don't think these devicetrees have been in upstream,
either. An alternative is to put them in arch/arm/dts instead, but it'll
still be nice to have them upstreamed first.

...

> diff --git a/dts/upstream/src/arm64/qcom/pm8150.dtsi b/dts/upstream/src/arm64/qcom/pm8150.dtsi
> index d2568686a09..c3411b308e3 100644
> --- a/dts/upstream/src/arm64/qcom/pm8150.dtsi
> +++ b/dts/upstream/src/arm64/qcom/pm8150.dtsi
> @@ -116,13 +116,21 @@
>  			status = "disabled";
>  		};
>  
> -		rtc@6000 {
> +		pm8150_rtc: rtc@6000 {
>  			compatible = "qcom,pm8941-rtc";
>  			reg = <0x6000>, <0x6100>;
>  			reg-names = "rtc", "alarm";
>  			interrupts = <0x0 0x61 0x1 IRQ_TYPE_NONE>;
>  		};

It's possible to refer a devicetree node by using its full path, which
may help if you decide not to upstream changes in pm8150.dtsi first.

> +		pm8150_sdam_2: sdam@b100 {
> +			compatible = "qcom,spmi-sdam";
> +			reg = <0xb100>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			status = "disabled";
> +		};
> +
>  		pm8150_gpios: gpio@c000 {
>  			compatible = "qcom,pm8150-gpio", "qcom,spmi-gpio";
>  			reg = <0xc000>;

Regards,
Yao Zi

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git
