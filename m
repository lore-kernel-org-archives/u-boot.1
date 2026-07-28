Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3503FC53219
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 06:54:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EC9F060831;
	Tue, 28 Jul 2026 06:54:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id J8gMWc2au5sI; Tue, 28 Jul 2026 06:54:48 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 71D406081F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785221688;
	bh=wW9NDLZgz5x60Jc5O3mqTHfqCbCYrw6L6CGFXq7dQ1Q=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=olgf3MuzIrVew+z8oHqOdrniYG0c8AVQbe2IFKDwTenDRP3xgSetBLWI/TqA+o/md
	 OqxP5gglC8o0p3NbuQ058ut0GB8wAjU5RuydQdLe/9eE0P5E5zH/brxlVG0sIOw7B1
	 as4he3ZIfwLGU2Uq3mlVHjHSe8N8fvrWW9KZrlcADZUr9zib9QsyCpqMad+sTpPmH7
	 QGtMSgT8Oe0YfQLOHC6qmGj8qVgEpuZqKcoTY0QTHxuCupUZGjgvRYVIYEygOndH3S
	 l0bj/PasX1rEiKYaFAzxfX8kLyEMBim5ngaVis+tsfVb91NInx2iT3tyFl6JnCIuOT
	 YJlgDsecCM3hQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 71D406081F;
	Tue, 28 Jul 2026 06:54:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 79B1C26C
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 06:54:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5FFEF40042
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 06:54:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 77UD2UvjJjFm for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 06:54:46 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52e; helo=mail-ed1-x52e.google.com;
 envelope-from=jbx6244@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 6C98140245
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6C98140245
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6C98140245
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 06:54:46 +0000 (UTC)
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-69fdfd98eb8so105194a12.0
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 23:54:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785221684; x=1785826484;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wW9NDLZgz5x60Jc5O3mqTHfqCbCYrw6L6CGFXq7dQ1Q=;
 b=pFykm+FcpQZNEovPdS+/8sDoufbo5P4J4qXFQd6qAwFGuwyhrwIJuSA2oaj8Bh/GNu
 AkD2qa7TqgLwd6WpxL4cKOjqpu7IIRWdgCQ4lXUWtbLlE5P3X/z/auLAYWCV9yRSb3ki
 lD32YFWr9YtovLxAwJlgrAHQTGGQzF2DG/E+V/ulW9jybYmbRGQon3mY6oPDvwApMoso
 ukTbsRQOHV4KpduxLwGbFtPz17MQnXZsrb+Q//RYegPOXeliXXwDdX3pQm/klfv+3Xt3
 Rv2QspzDPjeK75uL5C7ict+3oFTOIpW//UBNSSyv7hWBR0tpvAA+NF5ettKmD/jBfsSq
 rwgA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqBlBkzpfPY+hoLo9GP+OCIoa44ZLKvGtMfygVhKgE2E8EotY77yj6LqOXkSEP/gjwmq6H7e74=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YyETF+bwy4n2PhIHLcpcTM7qj6MsjXC48dq5Ipgz1q9Yn8BtN/K
 Skqgzxn+RQV9vTT8lNgcC6R1lqnmc9Cd4K2UktL8hpREDKf1pLf5G5MiQWg9jg==
X-Gm-Gg: AR+sD100FtHKpF+1k631l7wK+XRwHKa9hEu10FmZcaUxsdvNMz0z6AYO+hJhvSzXtpD
 SX8VyIEd7200apL8wZt2VxmllPTWoOFhTrRKG+D0OrN03WmpnGgrr38zqeyrHcQ0o53dM4Vp4uW
 gw2X8zeB+GhtCaHSQoP47rCAPXMNRUxihXGcTtxTfZ943GTtfQn6w+DcueHR9XvTZ69Z0vnCAQ2
 eitGFXoACXxTQjW/Yy0MbhmuGXouBm9USpBZ65WqWtnqq0W69hWO7sVEf0Vhxn1kMGyP27XJqUc
 fSKqD9xUdB+rxHtS5KteuSP+RNg4IHYIyIik54ALjN15c4dUpSLqTXuOsE3EbKjmppiUOPZPMkz
 t3zGOv78RSmlopqvcD2qlRAQfaDqGGQa8Tu3LOpyiRpdsV3LnTBu+68PbrHVc/ItX0fCNUG5Uk0
 yBLMfT/71PH4cI/RRa66VlNuxpqGAGByZ3EzWOxtjG
X-Received: by 2002:a17:907:3f04:b0:c15:ccda:26d5 with SMTP id
 a640c23a62f3a-c1f71eaf6efmr44172366b.4.1785221684242; 
 Mon, 27 Jul 2026 23:54:44 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1c4ec7849fsm585096966b.5.2026.07.27.23.54.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jul 2026 23:54:42 -0700 (PDT)
Message-ID: <a0bbdb53-d3d6-4f2a-9a18-5502dbb1c571@gmail.com>
Date: Tue, 28 Jul 2026 08:54:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v2 04/11] rockchip: doc: remove TODO
To: u-boot@0leil.net
Cc: kever.yang@rock-chips.com, sjg@chromium.org, trini@konsulko.com,
 u-boot@lists.u-boot-project.org
References: <734d54aa-6523-4c2b-ba3a-a51b063a340e@gmail.com>
Content-Language: en-US, ar-EG
In-Reply-To: <734d54aa-6523-4c2b-ba3a-a51b063a340e@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785221684; x=1785826484;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=wW9NDLZgz5x60Jc5O3mqTHfqCbCYrw6L6CGFXq7dQ1Q=;
 b=ssb/ZVrbGF/3frVsCudAjnoQ5jf+GpyHEw3xOcLA0BCuBa1PicqocPGe26VdOs/Fv9
 SR7V0MMDfF94V+WC2zYhho3mRh6d+KQ6yEfQEv2xPJzRAbb+WN2Y/5dFXjzevO71V2Np
 V8a9t0ZHswW5Ealosv4vunGcx+W5GBELu3goVRzpBVVHwS8Nc+jgOrIqsyxt5fZ/KyZ6
 30CgpLQR7wxNULgSsIRLzaMUX6HWxWViH7Ac/sC1XBRMc2QrN9fsUNe04UsXeklCj+TF
 ATLWexXtF0z9i62ucgdt9Y0Nai2MkWlNXqPm+5TVPLOI87OnY84SstJntFIPbvZQw2Bu
 tFlQ==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=ssb/ZVrb
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Don't try to guess the future consensus. And don't add
a TODO if you don't have the intent to send an immediate
follow up. Remove the TODO in a constantly changing document.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 doc/board/rockchip/rockchip.rst | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
index 4ebe20d81324..3a190d6905f6 100644
--- a/doc/board/rockchip/rockchip.rst
+++ b/doc/board/rockchip/rockchip.rst
@@ -553,13 +553,6 @@ config-flash.ini:
         [OUTPUT]
         PATH=RK30xxLoader_uboot.bin

-TODO
-----
-
-- Add Rockchip idbloader image building
-- Add Rockchip TPL image building
-- Document SPI flash boot
-- Add missing SoC's with it boards list

 .. Jagan Teki <jagan@amarulasolutions.com>
 .. Wednesday 28 October 2020 06:47:26 PM IST
--
2.39.5

