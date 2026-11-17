Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB86606A31C
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 06:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=UI/R5124;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=lv7TdKS1
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F1E1F4056C;
	Tue, 17 Nov 2026 06:24:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3cIkFYSMfpaU; Tue, 17 Nov 2026 06:24:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5D110405B2
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794896688;
	b=opM2ld5klz9SWFJnAbE2pXGfFBBxQtdJne/VrJ2B29H30MV7qWj4khJ93eHB82vNMZOt
	 YmbHOSd8l9Wk0HxYLqWFMGgz4gHvp4yGZoLHQH4NMyFsbbyHFCPKo5vhgYaJJ4bUXZRPJ
	 Oom2XfEfKmbqzGF6t5W1657jwm+LDOUL3M3nPdkRSJQu/tztKH32RWi1eK4LTGJvYR5E1
	 EH/GSIWmYjzBffNVP7Ys6PQS6BC/KArXtRDQhSiyGp/Y3EQO2UCJslAR0GzhpaMBIXMPq
	 wgxV3voi3H5O4xKFH0HA615jWs1pOeG7WNuGw8QOf9C1WJQZ0Hgyd+NIkW7e/8FACOA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794896688;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=psCMW/eYpsYsHPdnJTPiiuE9wTpxhAW4hdhIl30CUPU=;
	b=hDbAUDRT8N7FdCilXh6s7yZFE8BmkZBarF70x16qNf9rmsyK9FcDTkcHsPoq4+LlASiw
	 /Uwyk2vqkowKUzAzGEqVtCDdA0Baz+v0mp9WqOb65fUgzLY1zpl6DGUGvicGdbB0JhAdg
	 tQb6LQj9Wfo9Eig+GF0ngPeJ77qf44xRVR+QnHwRztteRdz+JwAIDCUn1nmsQfx2z/mVn
	 rYx9BP208Bjc9pJAagzPpxuUwwA6EcYOuRvrj2i238QV4vJJvLTLQaUeStb5JKFGwPDSz
	 kBwsctY1yW2PLy/B9aqUjGzAlPhRg/JVgyZcsiCG8tlQ21NExybctWsqzI3zdIa9tSQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794896688;
	bh=psCMW/eYpsYsHPdnJTPiiuE9wTpxhAW4hdhIl30CUPU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UI/R5124RRXwPAC1e2lthrC9dcGyWz+b+Ytlj+LfTJUIo5YxQT6raFmPQ5l1h2dqv
	 BYmcDQt7JJv8cb37CCRvXWdMO3LKCgA/gWrnfmMY/bw+IgXDR+Uua4tz8Up49yRnVK
	 k+hiT4br+983f9ZLy0UvaQIfLZBQ5smvepzzAeDR4hhe9nKnjXoVF0RzGeZKLCY38a
	 OKWC3afXSqwYbxd4ecqoDdesdzX0Ldmdk69VKohivWJj2hBA2NMKRYes5pyymq7rhW
	 5gBpeZTKgBO4f9iwf7ik+SbqkVMN55rZ8VIe0j90xaJyQBiLk6tRdE90sMA2YLLzGZ
	 OUL+lZecsJroQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5D110405B2;
	Tue, 17 Nov 2026 06:24:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 79D3949B
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 06:24:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 571DA40079
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 06:24:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CgfGKtKdOgVW for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 06:24:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 6C91A40048
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32c; helo=mail-wm1-x32c.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=lv7TdKS1
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6C91A40048
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 06:24:44 +0000 (UTC)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4a1fbd52ab6so32884785e9.0
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 22:24:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794896683; x=1795501483;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=psCMW/eYpsYsHPdnJTPiiuE9wTpxhAW4hdhIl30CUPU=;
 b=lv7TdKS1pGZrwdeeRdpLPUkz4p9SyUNVQtf/MKlter6IV8/aDMQ/Kpi5GAgAegwZaQ
 N++rzLuoP6ly3XCbF2PildIRGsS8Y/Yxcwax+3RWCQemZMftjwfWjEcVqVBPoJbt5Pvs
 k+15C3cbbZ5qy0Irgb7gzRE05rjomA4oI7YYVPHDil2JiWEaZAz+TYJr2cz26PC8ofum
 PvKjDSuM2nzR34xuQUvdIA881brt2+yOMU7D73+weA+GMYyfhNU/bpBJi5bNUZBs5soT
 gi/ISfW49Yp1/hlpqwucw+ybs41Vhd6wRfCtyPWGp+8SYB60lL/SW/KsAWWHFHS9ZJw8
 2uVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794896683; x=1795501483;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=psCMW/eYpsYsHPdnJTPiiuE9wTpxhAW4hdhIl30CUPU=;
 b=RADH5D4dBkZDBnoMo7r4pu4kz5uPvohRNWw1bLm9sevP7Wtw1Ugdk9+igAmoqYtPGr
 BFSiMqp+fdtMeq4LBVE7PYbMbiQjwVB4NlTAJoNIxC6m2CR+FHTUIhFYi1zJ4dTyxqX1
 90DL92sGrU9n0az78d6MP30veNAgUQrIWENuRSmAz/V4ZOKIMKmTPFG29JYcn5KIhxBW
 m0Zj71km6t91RWy4PFPaps4vG6R4rPnufStn9tlttGPbHSBZsow60TEuSZMpLNALJPnN
 0qq6lJfvCYeYsoPZxbPvlLhZs3cNh4VUh7knbMOwU5CsC07Jl3BoHRa4PYRZeGCdpKbK
 tfQA==
X-Forwarded-Encrypted: i=1;
 AL+hErG8GvlN99gRi59sL1b29wsYVcxvXzxfVNgDfGyhhP1QwjUcsLijJ7fEbWvZOvkkOF4o1+lzRaM=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+P89CKo1LYXfNfQbbNUJRoZkjg3rn0/LtR20qciXOjAg5GH5tD
 Z/YrSHdlZvtxOVUa63irvRYeOOO1X4g6bwDff6etV1H6Hjr8ffMD2Cq/2fiLxsFiZ/8=
X-Gm-Gg: AYBFou3tvCfL+kUsfMDFEcRtQ0SPWgX0XAhTO+Km68fGZtwRUay7pVtXaT5nLdTUkt+
 dFjlTkWnUVQxzZN/gUkB6cntLGBY2eFusgrZ91JPNXjtwWF/PfCi6r9914A+MWYJxoWaA/NZyhO
 hh9JJmruoIXp6GxUSb2g893q+z7ju9QiFS1Zn2STnwBD+runVFH2mrm9XlN7Qreew4ybe2kfWaZ
 HcBhcYoliHs7pDTaCg3GgU+v9ob9xURPdZxhYTbmxtdw1o9PJaiOhSratKFgtmYvbRzm2tKikmW
 MosNoynL/bTTU9iB4E9r4YWMGlG0McnK/Q0lJlEIYeFnIb5qBMu7LiMBLTp184E1XxsJLiAtwbf
 dfz9WvF10CAtgv71xNw5oU1vtbG1FIh2ZLj13OCz4A90WfIKeP44RXGhVX1KESTslEXczsB5mO1
 0wJCyCHDU3O4uC/SgnAdIMa/NAnyC/ijIMLqM3yKRW9I2nVH3zqB0JybKM5Wtint3DaemUP3wbi
 oUfFX4/9Fgcux+oAFVfvVBoOaPHNvDhbNcYUdkjW22pvo/PX9lrDSG+NTcoKeyqzM1S2pZin4+c
 ThLI2yeBA9LBGNbTMticV8GkuAJ4PtcA2e30YXagK8V5xwv+rHaQ5cRwTBdH8XzYQbaIfFG+Mxd
 g0ptlbsQbqu+ECZqbrQimeljoGRJH
X-Received: by 2002:a05:600c:3110:b0:4bb:5df4:685b with SMTP id
 5b1f17b1804b1-4bb5df46970mr244555435e9.23.1794896682716; 
 Mon, 16 Nov 2026 22:24:42 -0800 (PST)
Received: from macbook (host-95-246-144-141.retail.telecomitalia.it.
 [95.246.144.141]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb675200e4sm161619845e9.0.2026.11.16.22.24.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 22:24:42 -0800 (PST)
Date: Tue, 17 Nov 2026 07:24:41 +0100
From: Carlo Caione <ccaione@baylibre.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Macpaul Lin <macpaul.lin@mediatek.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH 2/7] ufs: mediatek: skip SiP calls when running at EL3
Message-ID: <avvy2Bm1ckpMBc3y@macbook>
References: <20261106-mtk-genio-720-spl-ufs-v1-0-90c578b6c43b@baylibre.com>
 <20261106-mtk-genio-720-spl-ufs-v1-2-90c578b6c43b@baylibre.com>
 <179442384949.26078.15240674797898354872.b4-review@b4>
 <9f91272a-2f34-4192-b0ae-41320ec552c2@baylibre.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f91272a-2f34-4192-b0ae-41320ec552c2@baylibre.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 16, 2026 at 16:40:05 +0100, David Lechner wrote:
> >> @@ -37,6 +38,10 @@ struct ufs_mtk_smc_arg {
> >>  
> >>  static inline void _ufs_mtk_smc(struct ufs_mtk_smc_arg s)
> >>  {
> >> +	/* No secure monitor to call yet, e.g. in SPL before BL31. */
> >> +	if (current_el() == 3)
> >> +		return;
> > 
> > Can we return an error from here? Otherwise functions like
> > ufs_mtk_device_reset() are going to assume that the function is
> > successful.
> > 
> 
> I don't think we should consider this an error. We return early because
> there is nothing to do, not because we can't do something that is required.

Yes, but for example in ufs_mtk_device_reset_ctrl() we are waiting 26ms
for nothing and printing a now misleading "device reset done".

--
Carlo Caione
