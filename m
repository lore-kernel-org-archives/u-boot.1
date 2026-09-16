Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13F37C88E5C
	for <u-boot@archiver.kernel.org>; Wed, 16 Sep 2026 14:18:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4361240735;
	Wed, 16 Sep 2026 14:18:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kBNNbUQecg3j; Wed, 16 Sep 2026 14:18:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 8CFEF40732
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789568330;
	b=ly3M3k6X61Y5Nfhn5RkFLfILIaPx3JjcECazYEj01raDqMmLgAaSj7qKcbJD8Mk3ssud
	 UkvG98VkyJvmAfjl0wgXDna4PWJimtmzRwEQf3NxGhgzEedQDKPZL8x3Cw9wgnaujC94j
	 2biqJG7STN/X8XO67dWVAj03Q8CYJxkiCmxqGCtjbCcQOUcRdb+94XJqZu671O0PwJkfd
	 jGmgeJL8Qt/0MJ+aVHsI39ZDMU1AUsyWjVH34RiFSSd70myYMcHCegQF0vxK2zaM8Hxxo
	 vuhddwgcXag2IXNTUwxborpM2AzIOqWIo/wj/NT/2S0+vkA2F/QYdXt/DCKB8YqJb1g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789568330;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=JaYv0o7vxEIXbyhzpyVE/TveHg9zej7xwAzKzvCWO94=;
	b=JMODSBH5xIl8LlggQiNTKlrb0/8gq+DvtNJd/+KFSvSUYFdkSBuZkTEzMP/zTreRjg/v
	 KwSSDOxq+D8MRik40B2vdCcit45BHqk2k6Zjhmp2WdylN2pb+IhQ4rL9pqkw/0s8Z/XJ5
	 xBv950wnNy4PPSSe4F3KvQJbQ/OQsRxfWDy6d8YTPh7V2n70XELHN2XuYnNdmAG+19R1r
	 gSGmklrZuLQ/S2mWWf7tDG010ndK43hCih2Tx9h9h1QFSmENARoqG2Vr2yUNB8GxJ9pLK
	 0mg2ZEN1U8L+1eIK2bfNUGcoRFesz3n1xsJOe+2ZLDvLzzSTPcfcqgB9Z+7yD4+eh2Q==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=htMs6w6D;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789568330;
	bh=JaYv0o7vxEIXbyhzpyVE/TveHg9zej7xwAzKzvCWO94=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nZFutj5cYO1ceTzW24b88Y45b0Pks0fD38qsFdUtfSOBD3BQQ0mjvffi4BO1moYJC
	 HxGDFieUqNcQBy3wWTtY/kYwDoGYVQFv8EAqLOF7lcpJnKcMuLEQJOeUOZYgiFP6w1
	 nwYsIoqP8LZnxVfyb/9Kng/mBD1tHxsg8fodf1WCYCFuYVQyPHrq31awo6WYDzj+6S
	 frP2UJJApRDwKcKeDCI43TL4/JZ0G2R/WACAYQLTarsAlDIHtdNqlnFCyZiXMMO9mi
	 A6cfBXRIq7rZ2kH25ZqmxLeHXPQadfjD6/tYFpJiTfMvUwQ8ScrCXbqtSOKR4WH/n1
	 tsqh/MwV4LXCw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8CFEF40732;
	Wed, 16 Sep 2026 14:18:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id E6F22388
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 14:18:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D87924072F
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 14:18:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mLdRbwuQ413h for <u-boot@lists.u-boot-project.org>;
 Wed, 16 Sep 2026 14:18:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org E404040732
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789568326;
 b=pYDDHbya/9Es9IeWgksJ0GpIpesPV+Wm+R+IDz2y0oIkdFhLnVpV88NtF5bT785oiJ6t
 FTY6/HcZ0TmaiZVraPVTQ2adyGkLvEpQWsMaTPSiliJwqfzZ1fWTfx/CmRXNpLEwRiKZ8
 brsDwC+RwcFcigqhKF/JL3Bq7ugqtMhf9vAE0R7bgHpWBYNySbYDvoJHN3pZS8gcy/7hp
 yXMLBvxwu97RgsiU92GIpRWQyvY0d2/bFYtzyv/DLm/WnFqeI1V8jpaYpqWBGCmiXJPA+
 hH9TLurrsHicGPdQwpbNwiQ9UVxRsuXyNnQ6I7h1iOX5vyfpPH6GlI1uw2N137TCg/g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789568326;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=JaYv0o7vxEIXbyhzpyVE/TveHg9zej7xwAzKzvCWO94=;
 b=hb71r1gDM5X3wsI6L9AZvg3l6KXMBeyhnRL7GEM2tVoGKPmQIlrxqJXaJJIYX+Xjh1SL
 UDmo1qYPKDIej+GlCRM9TDCjs1xRkTnaxTErgx215B1eQWy+510hYfVJzVkRz+dZ8G+td
 PfklJkLkJReYFtZIn0YW2VotWXrwi8+rdhKOuLfK4HPiyU3mCNUdtZXZDs5+P7HPDoujf
 wvMu4le7MU0AVWAkjDKavNmRaCDokOYhHuyObX02C511Rt569ni1zjrp7xkBMmgswNPZL
 QDnB6rrV2hrVOMpq9L730sWyy5IVMfDlpSeOUCh/gzLMsVGzTrjONaJlhaJPtM7s5Cg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=htMs6w6D; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::11; helo=mail-wm2-x11.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=htMs6w6D
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com
 [IPv6:2a00:1450:4864:31::11])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E404040732
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 14:18:44 +0000 (UTC)
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49e721b5503so11056805e9.0
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 07:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1789568322; x=1790173122;
 darn=lists.u-boot-project.org; 
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=JaYv0o7vxEIXbyhzpyVE/TveHg9zej7xwAzKzvCWO94=;
 b=htMs6w6DioXBwONcYJrYKMple0sStOa6lELxB2K6NIsZdohaFRZbolV26J3wvw64DG
 Oy+Lq/oAEv+DjrPqv5S0SRzsSWpogELqfNf2/90DSQWdF8+ZxKM1SresD3XlU45/13M1
 DfhkfxfdA4JAiKK4/FtQrPd8SHvq1QXCWaEs5OufOCgXRtn//u+leisKfylMuDLSckVH
 JfLxEe+tq/Qf/XTcK3yrceLvuUNMRvK1PKrmdN13M+Fi0EJwYlxV5TxhiCyXMy2+iog8
 PPB5vo+dnQwVEVfXVOWQVkzTADJbMLpwxx2TdRjI7aZPzv+FBdSJ5xMm70fP3es2nWMD
 5ewQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789568322; x=1790173122;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JaYv0o7vxEIXbyhzpyVE/TveHg9zej7xwAzKzvCWO94=;
 b=oTrlVtno52OI7qwxGP+5ErbNEQDKLcZpxN+5z7J2avD3hPOWB+rxv1YO+nUWQzy5P2
 zDyN5pFkzHjdMd0r7xoyMrVvif33YLvY8aDCaAMiB5j0CVy8CFZODtGbTo9VvTbnSpnP
 9YqDwJ3y0T4ebFI7JdXoLh6j+Yq2OPS4v97IZaSnMDX6m9ya3NiRq2lRlZXRfqK/rzjF
 sR0bghgGb1NDbC297c/ZWJ7jnSY8KKyqvd1ln6dANTs2Q2pJyJtltM+0S1pcsAvoxEnd
 Rr1NXDz2G/OcdkPvXZW4WA7cUNnOUmdXca//17EH6nc9odCWmVMJbLzl1Z3hjc8kywQZ
 VSvA==
X-Forwarded-Encrypted: i=1;
 AKwUvByKz/6ng1EqcYqoyu6FUVpqhmP54OONAmE7u+tkrhkgsXt9cMeiUXyb6KKr+EQ/cAXItMGup24=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lGF7LAhrnqWiqhfe17DC8QeBb9pLz9uwQRd/dN2/CyqLGrO0It
 XtzICYYD2SCEDYXewLsHXQACuAUj9e8S5nTBT8v+Nf1Fnmy5KC33l38MijjeHOEu61k=
X-Gm-Gg: AYBFou0MygQILygAXNvLWYcB6K32ISqTS20/at7JiDMJaX9B3jcg8DtSIGWsQL7HErs
 pNcOLLRYY6/TVRQcvQmYTRnzIRmoRIxRpaxF8xQuBkY9MC1linAJnx44wFNqnLNpcT4fYY/gRTy
 Y0VElDdckHmxVkWu5tjss8xlPiMAAiZHX6vJZcd4yqEb44gCMTioOIo5NT4fIBzVzMCOQe30GC/
 ZjnMbhMDRHyP/vv1qRtHQyymi8gFDMU7/8rGty9LNC1QCe4cRO6fhhLALteDyguV5kfX14uDiD+
 GOyfSeKBh4nVaumPLu4an6segp7Oa/6TNkT0ntcbE5nJpbw7fMdxVlAGERCEwdVthUF4/ILEnYv
 aM5jJnYGKaeTttrBRT8Bj6Jfn3//Xw9CPXAKjOtWp6VQrskwhhUO7FYhWM6agFdpsF/SkH0PaVo
 guhHM/KkfCHR31rujFwRce92lx6olL/MFRefULesDe0yPnSm4oAZ/M5W7MhVNpv7D5riozgwimW
 kpmPjU3OXwpX6l4it8mmYdCnSjacS6yqaO9ij6KsURCJ8pRhnPRSzyxU+qkzsU0hN3jtZcyZuYo
 guZZkTDcdIpNaafTZ6tb21Pku1pfbVBqCni0zE2HlgPefjqtHEby6GzOa2BSShkpwQ==
X-Received: by 2002:a05:600c:19c9:b0:49d:34:420d with SMTP id
 5b1f17b1804b1-49eb732e47fmr31192125e9.20.1789568322201; 
 Wed, 16 Sep 2026 07:18:42 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bef7687sm8575291f8f.1.2026.09.16.07.18.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 07:18:41 -0700 (PDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 5/6] arm: dts: mediatek: mt8189: add the power controller
From: Julien Stephan <jstephan@baylibre.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Tom Rini <trini@konsulko.com>, Sam Shih <sam.shih@mediatek.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, David Woodhouse <dwmw2@infradead.org>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Macpaul Lin <Macpaul.Lin@mediatek.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 u-boot@lists.u-boot-project.org
In-Reply-To: <20260904-mtk-power-domain-mt8189-v1-5-ab9d8cd0f01a@baylibre.com>
References: <20260904-mtk-power-domain-mt8189-v1-0-ab9d8cd0f01a@baylibre.com>
 <20260904-mtk-power-domain-mt8189-v1-5-ab9d8cd0f01a@baylibre.com>
Date: Wed, 16 Sep 2026 16:19:22 +0200
Message-Id: <178956836274.657813.2632019744153964279.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1789568379; l=1255;
 i=jstephan@baylibre.com; h=from:subject:message-id;
 bh=90hE9kOdLe7AWZA5B8fMDf1SCrajUOolpD43t2S/quw=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgphAWFBQbyQxHwqbCvwEwIl9NQxnNa
 Ewt+3w/AUXP10QAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QDXPdEPXZZaR5wOVTTKCKrbkYq0xzXzsbWHdqWkBwBsBAPWy060Dz8Xhx9OeABt6Wv6was5xGY7
 xR1E9C7EM1QQ=
X-Developer-Key: i=jstephan@baylibre.com; a=openssh;
 fpr=SHA256:PPc8djUi3lnQXuiRHH4CZ/icbEYOsksrEsOV7pDEmZg
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

On Fri, 04 Sep 2026 09:46:32 -0500, David Lechner <dlechner@baylibre.com> wrote:
> diff --git a/arch/arm/dts/mt8189.dtsi b/arch/arm/dts/mt8189.dtsi
> index c965b00bb5c..f3a350c51b8 100644
> --- a/arch/arm/dts/mt8189.dtsi
> +++ b/arch/arm/dts/mt8189.dtsi
> @@ -144,6 +145,45 @@
> [ ... skip 14 lines ... ]
> +				power-domain@MT8189_POWER_DOMAIN_MM_INFRA {
> +					reg = <MT8189_POWER_DOMAIN_MM_INFRA>;
> +					clocks = <&topckgen_clk CLK_TOP_MMINFRA_SEL>,
> +						 <&mminfra_config_clk CLK_MMINFRA_SMI>;
> +					clock-names = "mminfra", "ss-mminfra";
> +					mediatek,infracfg = <&infracfg_ao>;

Hello David,

mediatek,infracfg is marked as deprecated in bindings/power/mediatek,power-controller.yaml
so It will probably not be accepted upstream, it should be replaced with
access-controllers.

IMHO the current driver does not support access-controllers, so we
should add support for it.

> @@ -344,13 +387,18 @@
>  			status = "disabled";
>  		};
>  
> +		infracfg_ao: syscon@10001000 {
> +			compatible = "mediatek,mt8189-infra-ao", "syscon";

not used in the codebase right now, but I think it should be
mediatek,mt8189-infracfg-ao to stay consistent with other platform

-- 
Julien Stephan <jstephan@baylibre.com>
