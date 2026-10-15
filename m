Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF6DFCC6B30
	for <u-boot@archiver.kernel.org>; Thu, 15 Oct 2026 02:36:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4E33E60A3F;
	Thu, 15 Oct 2026 02:36:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id i-ooI0EyMl2j; Thu, 15 Oct 2026 02:36:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A51FD607DB
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792031760;
	b=syNdK5TEvQVbvSYC2juv3qONhvkk0xYl6QJ1HxBrcMWtdLsFjaG35vDujMHdlZoN0zVO
	 nA+qGhKDANo6UL+Cdg+JkJJp7/G9LPxCoEmoWQEMCscWu6Fs2UlQhAFyJ3qvIBKmJpR17
	 E6HmnuTRGWgrJpWelCy5yyVIy82uMi5tnKlfLz5ywPt6jI8hNtdYjFY3TDTebkqwT0FRC
	 bOef69uRAoBZg1rEK918wt8RF/l29hykG71rIwlyD1hz2xiJTzA0CBxLv7UVMLZrlXY3L
	 v1lPMfFpdV7TBQv0abf6hfp8OGWAsll0Dvx+3x8dPymKXTk9ltHgw652UJev9i2MQVQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792031760;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:From:
	 Subject:To:Cc:References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=EIJGRGVR/zVSB+m9kKmX3jE8JO5ALGJTOs8SMwNXsWw=;
	b=OmW1Em6YZDwfC2qL8qzqD7yeR/v3Vk1JB9RmkrkoSLCrLggVi9tVd5O3dJ1YarXZbJgY
	 QhFkHvl1eOx/oT7TrN0GM0x0qSgUpVKmZ7n5d0VvEv7W2X+4CGKjuZyBH9qH7QctKUWPJ
	 zfBszTC6DymWtIRIhfI0k5OJsGKqRp0ScNoZbmfiLhXz+LcBibnZjq0ylC796SryuzNos
	 L7QP+wKpFjbfde0ccuJ1k6tfaohA+JcoUUYrQPb1LiBv8g3EI+82ro2JJ6dVm2nVuyFO/
	 OGn9iJePaBJlJUhR90wwJsJ/CTSjeaCJHwBP9OhjaA6FhK8knybxILa+3QXey7EwNmQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Gj7zf5hJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792031760;
	bh=EIJGRGVR/zVSB+m9kKmX3jE8JO5ALGJTOs8SMwNXsWw=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=brAbkJ57k9VE5mDDCmeOJzJT0/jVqpfu0bEyS39WUhRaBE7GMYh8I+oyVJ6AO0W4k
	 49vZoHiRXbWtxIYIQVbJ0umfvuyQsiIYm7ZjqS6xaLy91PsbGHDQQ8CFNTO8EA8/zI
	 VpV7ujKWmyTghmJNBL5vJlLtIV8Qi9U3BLrpSZO1LpisJJKhhNq9F0G2RYshN8Jvmf
	 18e903ufA45rcvvnV+I+ukFaXdYRskH150BzU9TvMZ76bFEO93B+zKcaDmRPXaa6wP
	 8FTOtITOdiIYn1gOfNmo9LTpQg4b4F2TavFh+muxNxMTkAMYNgx1EQ01vqZOMMU1zc
	 xAmxtV+4dG+Xg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A51FD607DB;
	Thu, 15 Oct 2026 02:36:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id AC750255
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 01:45:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AA0F1607DB
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 01:45:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iUkmJFvOTr04 for <u-boot@lists.u-boot-project.org>;
 Thu, 15 Oct 2026 01:45:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0CD76606A5
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1033"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792028736;
 b=iJTBsdQ+F6kIqHFAfNhM81rlKBJJ7qCbh43yjhI4tAWT3HoOLvUl1Sjuvmb2lISjn59A
 aUJzfqggYSCmvGV49bUJGsYfxFzeOW+QiobG++NcHqa4N6n+Mm3GjWpJ/vHY/G7hJXK30
 tZElfB91mZpXUip/7mYDBz8Ksy4w8/7hweOZhwWka0BqeDMmvKYtGn7Dev2DtUUC1zzlO
 EZeFGFggFlHkCFyZk5QzfAXcfRCHbIgSf2DQed390CnLJLqTj/RU9S1wynBPJyOdAlnLy
 0qvhg5Wvh1aLN88yddBch/8cu+jKiSgHQ22/lNFtwycGtxKv9PZhYl+e0C6owLfgrEA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792028736;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
 MIME-Version:User-Agent:From:Subject:To:Cc:References:
 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
 bh=EIJGRGVR/zVSB+m9kKmX3jE8JO5ALGJTOs8SMwNXsWw=;
 b=Y+ii7/WquA7pdvkvqXIidAdfcjH89xjWutgKPynxKJBrL9xX0Ji6jdHOlzh8GSNvsI2g
 /AOe8cfewDJt03/YarwktJukpAbdvr+OsvrNhJy5VwqRYqF12JRU7fMGCVeOI9ZJAYVyv
 FHV0OhWO1OPF+tso23DFXm8fbUc7El+gwhEtV7/x5ATYJ1RT4B0A/4asTZvSwACohI7l8
 8prmWCCF6B3wKE380TJ9kL4L92v+mOtd1yViOigD8YG9BDRX80GxaZ30NtVqpG5mOpZ5f
 fc6ieWwPFZVaVitrJ03nDqwPcpsgH6nssCCFlKCLGIgtF6MYH2h7Y3s5xCFeulJJHzQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=Gj7zf5hJ; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1033"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1033; helo=mail-pj1-x1033.google.com;
 envelope-from=sycamoremoon376@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=Gj7zf5hJ
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0CD76606A5
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 01:45:35 +0000 (UTC)
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-3ac9f49b984so42288a91.1
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 18:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792028735; x=1792633535;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=EIJGRGVR/zVSB+m9kKmX3jE8JO5ALGJTOs8SMwNXsWw=;
 b=Gj7zf5hJFAwytyiC/TI1/pj3csMjCuv416NascMyXV7wl9V2Atg7BaET2O5DhWW25z
 Y1ZmmkwHG3PA252uB58ARjSBdwdaxbTB36eDg0V7o7Oh7WmrrbR1IB8CpceuHWdTV8vV
 RRdMQ2giguYGiOmaCknU2r/+x283f5SU+pgtwmrc181e554xlfLpmxjOLLndypYirFx/
 zkeS9CuaTMeLxJUX2Wxd4lrTwWzJ/P+zPFBHrF7EeuMxhqrRcH2s2b/yEys7LqR6JcyY
 FNT+f/I/Q5HNJjq/sUND0hBqrGYYyprVfxNeA0XbWwfydTByoyQ2PNdXlLg5QP4TCaNI
 aiyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792028735; x=1792633535;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EIJGRGVR/zVSB+m9kKmX3jE8JO5ALGJTOs8SMwNXsWw=;
 b=fEIp0HIRE4sYRk3q4qivHy8uGHjYKKWaJ3k5isLVrYptPfaUlKS0rvaG/sngYy2/d9
 k/ScRM0TqtCzly73VrOWyw8Lisb3qjdVH8ZXksu6UrGPhCokuUUXhMz7BJfx6Ymp4nBe
 Si7C4hVvC1Gza63ybv1emLmrsr8QEOm9lrk1QeaWOPvkgsk7ykO/p1aFh6sK65PyYEP1
 XecX/lNWE/um0ZligvoViSrcQyftSvMmieqFHJDdGROiRHGVBegj0xzO+5Jhdg64fFVb
 FTDb/gBt42ug8jchIB6tavgnVeh1vOPA0xG4wtuviiV3bTxmgVHq9Ctj26eoZABsNwdq
 CwQw==
X-Gm-Message-State: AFq9FYI3P5HxShmUiycJohSLYNwv3Nj8V4q7zdLU6ZqGoUPI7SAbu8e4
 G9krjqR6a33R1OfVMwmm41EmtTqE9r05mZgV4vTwrUFohROlj7D+VJM8tRy0+wXgZdA=
X-Gm-Gg: AYBFou227skx+yBU9U+bIHvudREptOSLOu6nv9Q0o0/y21jSnIIvTldb5vehpf913ku
 9vaeeLkTcnrhUZmyHA8EZY/CQHiq0CvSpRFuUFlbXggMKKNK1RRDCGrgCYJMvPjXNKjFZwMiCIz
 QRnz1niqsMlNveZs7xyLj4j2y+KW0n4wWS6F/Pd72e7vUFwhtKF01jwgG4+pwgvNoe5dtmZUY3p
 ev3aDQ4fxBCBwn//JhgT2QHr4HCdI+jwQzzl03z/l5WMO15AftVWbbMvZTe4EOeilC7OKY4BLUE
 WD1pUN697rNo2HulVfoXLkPCwaisxuJt+gNQaIaOKxtIyraf3yt18lEvl6QW5+9Aj8t9/IKvIIz
 9d+KuCk7BEvjIA55qgVq4EXMQQiybwhfqnDrRVUlgmHQLlBNMqeoVZzwZla8nZ+5nXmX7SM1VKa
 iesZgLuqNO/Dq2nb26t7jYcEXKySlJ2HdGvhdKL7uFw0+1euyIL2Ulw+OYvj4EIvTNeTyNL7s=
X-Received: by 2002:a17:90a:d49:b0:3ac:1629:4091 with SMTP id
 98e67ed59e1d1-3ac16294264mr4799808a91.45.1792028734969; 
 Wed, 14 Oct 2026 18:45:34 -0700 (PDT)
Received: from [0.0.0.0] ([20.89.104.82]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cd635c2b7cdsm481102a12.7.2026.10.14.18.45.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Oct 2026 18:45:34 -0700 (PDT)
Message-ID: <d1ab0a01-95a9-4b88-b0d4-86a6d3010bc1@gmail.com>
Date: Thu, 15 Oct 2026 09:45:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Zixian Zeng <sycamoremoon376@gmail.com>
Subject: [PATCH v2 2/2] configs: k1: enable Ethernet support
To: u-boot@lists.u-boot-project.org, u-boot-spacemit@groups.io
Cc: Tom Rini <trini@konsulko.com>, Jerome Forissier
 <jerome.forissier@arm.com>, Huan Zhou <pericycle.cc@gmail.com>,
 Guodong Xu <guodong.xu@riscstar.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Julien Stephan <jstephan@baylibre.com>, Johan Jonker <jbx6244@gmail.com>,
 David Lechner <dlechner@baylibre.com>, Raymond Mao
 <raymond.mao@riscstar.com>, Eric Chung <eric.chung@riscstar.com>,
 Yixun Lan <dlan@kernel.org>, James Hilliard <james.hilliard1@gmail.com>,
 Guodong Xu <guodong@riscstar.com>, Zixian Zeng <sycamoremoon376@gmail.com>
References: <20261015-b4-k1-emac-v2-0-41143fc5aaa0@gmail.com>
Content-Language: en-US
In-Reply-To: <20261015-b4-k1-emac-v2-0-41143fc5aaa0@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Thu, 15 Oct 2026 02:35:50 +0000
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

Enable the K1 Ethernet MAC, Realtek PHY driver, and network commands.

Signed-off-by: Zixian Zeng <sycamoremoon376@gmail.com>
---
  configs/spacemit_k1_defconfig | 6 ++++++
  1 file changed, 6 insertions(+)

diff --git a/configs/spacemit_k1_defconfig b/configs/spacemit_k1_defconfig
index 9c15d96eae2..cb04eb694b5 100644
--- a/configs/spacemit_k1_defconfig
+++ b/configs/spacemit_k1_defconfig
@@ -44,6 +44,7 @@ CONFIG_SPL_I2C=y
  CONFIG_SPL_DM_RESET=y
  CONFIG_SPL_POWER=y
  CONFIG_HUSH_PARSER=y
+CONFIG_ID_EEPROM=y
  CONFIG_CMD_TLV_EEPROM=y
  CONFIG_SPL_CMD_TLV_EEPROM=y
  CONFIG_OF_UPSTREAM=y
@@ -115,6 +116,11 @@ CONFIG_PHY=y
  CONFIG_PHY_SPACEMIT_K1_PCIE=y
  CONFIG_CMD_FAT=y
  CONFIG_CMD_EXT4=y
+CONFIG_CMD_DHCP=y
+CONFIG_CMD_MII=y
+CONFIG_CMD_PING=y
+CONFIG_SPACEMIT_K1_EMAC=y
+CONFIG_PHY_REALTEK=y
  CONFIG_SPL_SPI=y
  CONFIG_SPL_DM_SPI=y
  CONFIG_SPL_DM_SPI_FLASH=y

-- 
2.56.0


