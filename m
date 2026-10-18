Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A2B3CCA490
	for <u-boot@archiver.kernel.org>; Sun, 18 Oct 2026 23:33:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4701380E0B;
	Sun, 18 Oct 2026 23:33:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pqg0EwhcFDTc; Sun, 18 Oct 2026 23:33:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A45DD80C6E
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792366424;
	b=CSvQbjnO8oAG/q8F+krBEifac8DGZ7eeq5AIzYes5hmo+iftLFft+1l+hyoHNgBQVazx
	 z3/Uz6Y8YIwe02RhQzegp5HCxuIrXMfzipLjx6vF8PtE5bksgEMDmczr2y+TCi2zK9DVx
	 zqQNJ5KS8EjeKK2bUNQ0cuNKyzNNVHkh6EuVnYUAitcTa7hNXee5ZdrwZxaDQy7m6QEkE
	 /a5rcvCfFqfSEAAT/Pk0z9P3CJna+8e/8JEUE4JXHF98tfqoOTZBt6fkj0QZ7V1K8QABO
	 I0ZUom5j3lT4YyzhQ1T8giXE+zDsryKFlyCf7VqZZULIrJH5XA/xHDZGp/buRiGu4dw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792366424;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=TZUNS/sm4XBQwlKuFg5ey9h5e+WLM/cjyDzIo18rn9c=;
	b=nNbcF6lPNM95DleLVftaLuczgHsXYlkL785M29frvanuXPWdAJxSWnAByNX9jZxRYU3u
	 WDXCbKFz1MH+i67UFwE0Yuwo/MScSudeyNgH6oO9CnsaN52MizX82s9dKTqGFy3WED+0t
	 R54S2W2+Rgr2rA39KT3i6otLgihUKJ11fajAIcR/GuzkQK8jajijaxGCPtsWy4/FnZ+7r
	 sYec76iapM3vfDysKbbaaXXtwhQCKUrJ5ACJPsN5bZJ33PPDE9CmV1Je+nIdk3KDfutKD
	 MmXRJKZdPZxtF59WjqlKLJ9Phxim/8h6ta8zQbk6gDqQ+fy8cxh3+Rzdk0EyGxC3yZg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792366424;
	bh=TZUNS/sm4XBQwlKuFg5ey9h5e+WLM/cjyDzIo18rn9c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gOdnQKwAZdKeDL8R7PyLqn9XiUwuNcazNGk7JEJY7AF72kg9Zo+8ZQYrk6wAEajCU
	 OhknkFnlQLqSgCgp22ysZwq0P0bgrANSKSf1LzBf7pXjnuClQMFO2c4wT+geMxVzFZ
	 RDb9Cyo/T2MaQsb0ZvQj+7mhx+Cwqw2wgK1eZNW0VMayXwJyhIXwTmpJXnT62XgpKj
	 yE3yr8nux7oRSPSrBCSK3TGxVrIrE98/wZtqZu2szoezckxZgAFBY8LBm+BsbuuzjO
	 yTYuMetCAg7gJlYGjkq/IiGV43f3jnRsWSpNPH00xkPUJV4P/t+vOypQ/59J36C5+g
	 2VC/T6hdWALkw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A45DD80C6E;
	Sun, 18 Oct 2026 23:33:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 67D211E9
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 23:33:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5CB8840564
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 23:33:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ajNDvaMvBcPq for <u-boot@lists.u-boot-project.org>;
 Sun, 18 Oct 2026 23:33:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 59CF6406D4
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::52e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792366422;
 b=U5BUqMsSWwsp57UPZBntgdjiSGW0s73sckInyozlUkuddfWJwqx+TwXaCoZaS++2K477
 ADUHaVNroVtmTCUGS9ERUfRM0MmDW2xzeTC8qAMRmHvqSDv0p6V1JtA+vHPVsYetQXKby
 uzBeucB8m1x5TOBNPSZLfr2i0NDpmMCul6YNowlsRaj8itm5XkkWgKDAcGlpGHsqBVXyr
 fmQyODRVIGQnVoCjxqLol6KLsmuo+p4e+X9J3KTSoaC+JE4E++z6DxttgXjntEJOJvSyK
 BZ91vPCsnFbvD7PGFWV2rhn3kaMNfHqSTdFkjy4iv25Oaw3BkCv7iRuF+uvXftrlv/A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792366422;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=TZUNS/sm4XBQwlKuFg5ey9h5e+WLM/cjyDzIo18rn9c=;
 b=QYxurz0QMQRTqj2vE6Z/mHdCQxziiV2wBeZnyGG6EZVoIHgY3Ez6QJ3Ey9X9SNN33N3U
 LYIlzGgzIniegycrxOK9PZDdJYw9KGLntih4XWwRZdRwaLM5xk7s8L1aGe9FiZ73HrlTQ
 wrf6KzhXHhjbPn3nKpgBYiN/Vc/QOVFdRFwe/CEd9XYT8sHDNOWVMFDcpEQrZUtfGjreU
 ubitNik3x2wxnsGxIWlkFvpUNJYLPmZ3bydtnxSs205w28BOcb1u8ha92AG2UwKTTA/xL
 yQfxmaXpmli57EKyffgRUut2EuotdthAlogt10F55t8xbAMjOsgvCVXmWFqkYkFdQqg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=iMkVRCSa; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::52e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::52e; helo=mail-pg1-x52e.google.com;
 envelope-from=alan.tseng.cs@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=iMkVRCSa
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com
 [IPv6:2607:f8b0:4864:20::52e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 59CF6406D4
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 23:33:42 +0000 (UTC)
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-cd61cef87f1so414124a12.0
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 16:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792366421; x=1792971221;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TZUNS/sm4XBQwlKuFg5ey9h5e+WLM/cjyDzIo18rn9c=;
 b=iMkVRCSanpqPu3rZ1+ylktlI9UvgF213S5gj/rk4BcvhrsK5zPX35ig9zFQCC/jzDB
 xmHFe3RfvV4Vv0DLEy1ochtsGRvSUYUdrTFxa+mliD6Vp4/0Z1JmxYnvwFOlVPQs+DZ0
 //WKlmLqUmmfrM1NJWzHrDydwTO17o1IohyCF2ttId0VA2H0+tFL9mX4Ee80YFRHTUwv
 abpuFS5uEIvN5zzFMVQVVbuae2c91qMnq4NDlyCNcTwDWFk8h4BqUCuRmASzrwaAyJhh
 AzOVhndi+NqWhZYi/ICV1fPlYvD5qeDDX5PNMzbGOkg6AYTk7WnYqXy3FJhBjlYzka+R
 +6vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792366421; x=1792971221;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=TZUNS/sm4XBQwlKuFg5ey9h5e+WLM/cjyDzIo18rn9c=;
 b=kKLsinG4WX0TUimTubthtC0nQ+j4aroihlIpSX30DaAfqdLrmrx3AbY5Mi7mpyU6o4
 hIw2WsKvxTNopYM9cxz8dMZK+L/wHCOE1H5DMOl7o3LGcSoSb9k2zH23Q8ycs+m2c23v
 9IiLTheUZ9DYuOz7ljFxT/s3HSKxpw8WwxT5HIu7mpq+SQkpxG3gJihtn3ZGWuLXEG9M
 IgUXWkdiCRfSyLoz45fdwj8IBAC8gepc8k/wKQFqJZPwF9FyDQ5aolBGyim+abbSM2sP
 vIfWR16ZwTUfiHFIBSmQKSUOY+0YjLPAhA3Wu6abrb1GbFTxg4CZyYjX3TMWCfgis8N6
 /Spw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzrjLdhs0gaMucgSdsCsvaaPrxcu2n4K0QAfkejTPIc4m3mSheH61T4sxQC21FKLXAJ3yjbcxY=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJZT+niHfDybHdZwmpz4U1ALwf93agwliSkxsyekQLN4HEcTx6c
 /EXQ0MrhXavByUtFHSJTzF3ennJygxNadsWhMx6HZmupwQnMR5N6kQD2
X-Gm-Gg: AYBFou3cwLpKbhrraHw9YbICcOiGAOHGbEHV862Woghutqz/0G6sIzdvDo0H7ENwdjB
 Kr6IYnuTNlZ8Mg2pAHNzUyKF1yZYtB/K2v069ZaYv5tIv1GYafuNMsHM/yw2t5Obmgn/YS7j+iJ
 2tyr9VNS4Um9gLC18874y4+ww67Jx1rc9RFsl7GA/9AQTzNg03MwEgYSeVSx4UGCEuJH1hKr+vJ
 jrxA4MZZOVc3aA8xIm9Ae8RgIjge6t4LwMun496LPeP8Q5rnDOlX/Sxcmd/z+VTczAcDjTVVlJu
 cjJQgMR7mbShycZGbP7GwgVlbpJsYggkhcTsyqCVkF9kGQx8JD5g1CJfRN1bjwUfU9tZZZ04UIg
 StCKanqDRteyRgk9dh2zpchu79VB9qhvON//Wv11pnFTHRJFc7ZQrbSFn5rljAx9cV9QUKk8ihs
 cfwmp1bqWEw9lHcdT/BRarU+yTdZ5UyuXKiWoQoxreWh6aS/w5NzI4G5hnzFuh0brvWG2y0O9k1
 IEcp6AKLcim3Rv2aFl7h0yajH/s9+RWFXyuP4T0U4XkDdOX4/1mLCXtUw+RfO4o3e/b1AMzKcRA
 1czk/vBR57wyq2o0Xcn72r0Bt4gTFNueoCBu0nzxdkqyzwbewM4EcpL57tSwR6vH
X-Received: by 2002:a17:90b:1f91:b0:3ac:ea3b:f28b with SMTP id
 98e67ed59e1d1-3acef13e530mr4457335a91.24.1792366421280; 
 Sun, 18 Oct 2026 16:33:41 -0700 (PDT)
Received: from alanhc-14700.tailb22ec2.ts.net
 (180-177-138-120.dynamic.kbronet.com.tw. [180.177.138.120])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3acc9e47588sm7606715a91.1.2026.10.18.16.33.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Oct 2026 16:33:41 -0700 (PDT)
From: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
To: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>
Cc: Yixun Lan <dlan@kernel.org>, Dave Klotz <DaveWK225@protonmail.com>,
 Zixian Zeng <sycamoremoon376@gmail.com>,
 Eric Chung <eric.chung@riscstar.com>, Peng Fan <peng.fan@nxp.com>,
 u-boot@lists.u-boot-project.org, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>, u-boot-spacemit@groups.io,
 Anand Moon <linux.amoon@gmail.com>,
 Tanmay Kathpalia <tanmay.kathpalia@gmail.com>
Subject: Re: [PATCH v2 2/3] mmc: k1: let the SPL read SD cards more than one
 block at a time
Date: Mon, 19 Oct 2026 07:33:35 +0800
Message-ID: <20261018233335.1806737-1-alan.tseng.cs@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261018233052.1805865-1-alan.tseng.cs@gmail.com>
References: <20261005T135733-0400.mmc-v2-0002.DaveWK225@protonmail.com>
 <cc682162-56c4-4143-9fbf-a2d3b5dc25ae@altera.com>
 <20261018233052.1805865-1-alan.tseng.cs@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hi Tanmay,

Sorry, a correction: that link now redirects to the SpacemiT home
page, and in the current manual (V6.3) the chapter is 10.5 "SD/eMMC",
with the registers in 10.5.4. The PDF is here:

  https://cdn-resource.spacemit.com/file/chip/K1/K1_User_Manual_en.pdf

Thanks,
Hung-Chun
