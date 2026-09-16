Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46CE3C982C4
	for <u-boot@archiver.kernel.org>; Wed, 16 Sep 2026 14:57:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F273380808;
	Wed, 16 Sep 2026 14:57:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id x4tusqs9yno2; Wed, 16 Sep 2026 14:57:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 4F106807D7
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789570640;
	b=UErTgrkUiz+0vnSC2WHGNLSBXHvjE50Ic+NZNzp/1AoO82RjRn5cPvnH24r7xvTuljTU
	 QiRN7aigAc3whU25WvDLRUbx8jBcP63INqQDGgtEDz/2LY1IuxWXK1nXybAb6RUBW3WKd
	 wcaNj2+aviI9iWVkSahyXHlP+4u2Kw1sNetocPrOhQzfPZIZgg/Dtxb4HPQIQLXagbqPu
	 7a4B9eX/Ef/TOM9RIyLCS70mcLCZXG02s+4NydP1Ea6Qpae7uEFBW9de02Mkd5oful339
	 iiFn+mUDm4uH6IwBV7W11sSMhsn6VF2dFpkQGTsUaJ4WKEBGVnphBC+eR3n8CJp/VjQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789570640;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=r5h5OhB0jdYHaRkB1UMlDgLTQWOQw79+lDpALc5xhaU=;
	b=rg9sg9XN0HFJeOM0jqy50rUg8n8JAL8lJ/8UU3JJIxvWdpToBGKLLQcUSsRtJ0rxu1XE
	 Nqv3m0AwfdoH2vNfYLsYz3N3nP2LcwxdtdI5PYxNcx/Iq+ItQOU6MiTz8ols+OXC06QO3
	 IA7czS2ZMtlmMMBYx/xy4c993yclzt3252kLUHn6K2+68L2dC+2EDgWJivORGcad5fbCH
	 r9uNahhApJ6q/137BguxIeVAn2Puz2McX4UqIFOe4RQyCIEd5LaSDgX1k21DX/lHROUL8
	 jd7t4i97wXy+NvEtchcq8hCE/+5AXjZ53jgMk1u2ouWJFPciTrATDJ11YdHw0mQSKdw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789570640;
	bh=r5h5OhB0jdYHaRkB1UMlDgLTQWOQw79+lDpALc5xhaU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=z+96itKzvSurjCKD59jQL8vTKYcFTCQACFfcDYLv11mj5qoDAWWr0foCtdbz7DYt2
	 F7B7wgKLOzUbcTHZH7MnaHaLy+GTPX72Z18lAfdrQ0Ho2wJkxVQT9l+RgGyIO0VjdM
	 Y4L7IGT/emhaQ1qnjk/83MF/uBg4qGyDmkSAapD01OGcINpmcUiCVYUYGsUivsOoql
	 TDx0WAfIzSf74fV8PCDyNRy9d7hXsj63hZ4MO4UJtguW4Abojm1XytBr8Elm2BhRu3
	 nxvDSfoFwnZB953vyBBS8+8V2bYnefZaAFYo5RclMn3NBG+i3sgeNEXvK4SfRiJC0s
	 N6NH4oTo8+fjg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4F106807D7;
	Wed, 16 Sep 2026 14:57:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2F591388
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 14:57:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 162AA40753
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 14:57:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id w2P69YGL33Ib for <u-boot@lists.u-boot-project.org>;
 Wed, 16 Sep 2026 14:57:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 3E66D4074E
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789570636;
 b=QQmF5id3dQ9AYp8hPQFH+7Vk60EXSSesTFduW1BPsIrIaSLX+kSdRpRlcqGuOTjJQamx
 VT1m80r7wplJsnruVuufKkE2N7XZcVBgxEe2802mkirbXuWNSPHs1SgVVJ4erET+avSWX
 c3/ZD9K+FOJvaijVMnWdNKqtN4XM9m+TVTxY0CVYc99g6zC5ud60YnrMVmBtVf3y2zdur
 H/uYFt4FiWiyVkcv4D6Sp/j8IILl/e9Pvnb3p4wg3muLL0CvaoXno99GJa6VvtI0np8ho
 evS3BcLHzEZR+1yOla1J0XnmWucQgHU+eGTxKsGonbbnDBPH0qwTKb699zBts7iUTxQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789570636;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=r5h5OhB0jdYHaRkB1UMlDgLTQWOQw79+lDpALc5xhaU=;
 b=eZSHvOiZ3O7Lj5uSvE38wReVbecY9q6eS0zd/Rduamd/M3z1KdZms8Q+bYP9mh6uhlRe
 NDyuHADn3lh33hI1OMoWd25aWxriOtnW1TQbzmZRGAqd+3FSiiByotPMVsIM45o4F7ErE
 b4x6gKTDbZcwc62yHgrCF+LGdm9+gjZbYMoReTVZRRu0LpswTz+4MB7cWu8qIo/DJUPRB
 nPBE6wTUFx5yl4485d3pS0lPMixAYKW1UCf21XVYedflEkZrFg/808O5Z+xUQWeNGcR8K
 EidVRBqKjct7rh+f0r6XrLqpIMzQEDLHOvDrgquhfJDGsZlz+/2GULe1y+GuZcJi0Kw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=kcxvTonP; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=kcxvTonP
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3E66D4074E
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 14:57:14 +0000 (UTC)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49b912df756so7447235e9.3
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 07:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1789570632; x=1790175432;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=r5h5OhB0jdYHaRkB1UMlDgLTQWOQw79+lDpALc5xhaU=;
 b=kcxvTonP9RjVx4UF3U7o7fx8ZA+R7I1XfQCOIKnVuc7ZBNMaGjGf4M3frwODW5GPCc
 i19gM1TpSGg09K7c57NWs5spLi50enySe5QFaaD/sl2mIQqrEeSoDh72tjN9KGsvp88x
 hmUiezMmJ0AjE3Itci790Nasa+21xST6TZ4mXAu1vjW9ymM6XQYr7TkwZTWhI4se468R
 3qBdGF5oiGR0+NEx9tmre8XApcZuwKFkL2kpKmKLgLIuHvPDx26gMQ+HT4E6eF8kIhIT
 yhxeK0zifb+nTARI2rQ1vXinbRg+lHra75Y7SL0jJjGNAYXuF9b2scfGO8MxYyXAEsfv
 lgHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789570632; x=1790175432;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=r5h5OhB0jdYHaRkB1UMlDgLTQWOQw79+lDpALc5xhaU=;
 b=pF/VNA5HrmdoGbyKYw12F/4ckxb8TpMJgEonStN5DeyRWBSCSVma19tRpSVbAfnSjU
 6NlFHqnMo26sdICy4eX8iXUBWckTv0jFz24DG5zCXF18aYKtu5FxjtcOy534gOp2gbXf
 SM01hOUlcvrxJXJtZk9m1TBGdXB7v7X3F4BsgX7VhiNHMUECOkT/83M/axXbjBMcvr6h
 Izg+3kEbGsck8rfQh0UOG2zhxObyCJGNIy45MbM2JkOvq5kv0uBbpLLQ6p82H3oCJ3Om
 sqEoNN1GFBZpEnjBArXi7G8uOSUEe8wUKjANEeJWjvcdHc5zKZqaoqbZOVEkzyGmdf3C
 RzaA==
X-Forwarded-Encrypted: i=1;
 AKwUvBx0k1pBpwDD9n0xBn02sdOYYicF5vkXe1+pLok7xiRtTAQLqTywvsE657oBk4E+0Wp2jFzRgAs=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++luq9ThjomdUbzDhRB16s1a011X8bu3S73lgdeUitqoOK0jYwUg
 X1DpaTEMg8/srdKpa0JSQLt++ELTt1w4y+8dDEjNy2xrnxzWBvQQkcaJ6sHs0VOTZjA=
X-Gm-Gg: AYBFou1gnmIYdxEuP9ILPmnGP0WVxuQniJGg2qOZC+2kgxn7b7T2Jmov6Cy9T2yVxtK
 fjt3AjUAi2jGdugbs9iAiwd9nXxcWTNN/jaKD8zp1IcyuiVORLK6pLoteomnCVtcomnOi9TtWzX
 XzdDV+mJ5IhcpZNv2P4ieVh4FMrxg4rzUy4oqoIMrRQYXiJCADxoSh3Kg27uYHIBpR+E8f0RRG+
 ISy2dew2GTI4Qdhb1ix9gmlUNumkJ4pKCp/hjbuc+c/v+f9opuhNV0VstG5aM5g6ZNa4KswGSuf
 s8Kmr8bPiFy8rO/+PzV6GtgKpNoSiBhchkhEkoXu9BG5d4YYIFCYMP4i72q52UZRmIY11UL8KfU
 u2j7SA7B80zdcIdpxhg30JsBp0wA1RSschoErfHMu088c2LdTVil7IsROVwJBieIH7vS+xzXqB+
 y409Y51PDMWtKjMCB2KDk3MBgpjXhjbAHNssZGpnvbQaSmiXdPdqGmXqNpMQEFprCKNzbJAXCgg
 ZIL1jq8YxX9cGvBEYh67vVbk3kva05FyFXB4ktUNsveNI7cV6hC3TeQzxTPOZ8jNdGFg5J4x4fx
 wvaEuj1FiwEUhjrQvl/dFi803TQvZwOzLUmhp4jgiZfwa6gRgtJgNhA=
X-Received: by 2002:a05:600c:468a:b0:49e:7cff:f8ca with SMTP id
 5b1f17b1804b1-49ec053a73dmr34150575e9.29.1789570632128; 
 Wed, 16 Sep 2026 07:57:12 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fbd0a4e68sm122355e9.2.2026.09.16.07.57.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 07:57:11 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 16 Sep 2026 16:58:10 +0200
Subject: [PATCH 3/3] configs: mt8365: enable the power domain driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-mt8365-add-power-domain-v1-3-b768d71b895c@baylibre.com>
References: <20260916-mt8365-add-power-domain-v1-0-b768d71b895c@baylibre.com>
In-Reply-To: <20260916-mt8365-add-power-domain-v1-0-b768d71b895c@baylibre.com>
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org
Cc: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Tom Rini <trini@konsulko.com>, Irving-ch Lin <irving-ch.lin@mediatek.com>, 
 Julien Masson <jmasson@baylibre.com>, Carlo Caione <ccaione@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.15.2
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

Enable CONFIG_POWER_DOMAIN on the MT8365 EVK so the scpsys power domain
driver is built in for the SoC.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 configs/mt8365_evk_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/mt8365_evk_defconfig b/configs/mt8365_evk_defconfig
index b3dcc5cc5b4..cc01dcf434c 100644
--- a/configs/mt8365_evk_defconfig
+++ b/configs/mt8365_evk_defconfig
@@ -22,6 +22,7 @@ CONFIG_OF_UPSTREAM=y
 CONFIG_CLK=y
 CONFIG_MMC_MTK=y
 CONFIG_PINCTRL=y
+CONFIG_POWER_DOMAIN=y
 CONFIG_DM_PMIC=y
 CONFIG_DM_PMIC_MTK_PWRAP=y
 CONFIG_DM_REGULATOR=y

-- 
2.55.0

