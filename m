Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDB7DC531D0
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 06:35:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6F7E0605FA;
	Mon, 27 Jul 2026 06:35:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OKWt-rH1jymP; Mon, 27 Jul 2026 06:35:22 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CD982605EA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785134121;
	bh=mcPDoK12uo5TedNluqaYEDOI313yrrG3UmagGNWEt78=;
	h=Date:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=QW1Q0/wFMcCSWwKtyX63tNURiYx9ywAyRBuxufd3fr1a83KqEo3USetEEmU/Zu1jh
	 sWF8hEaNJRWn+bOEH2g82RiKm+3WHW8AwnCY8iX+OyRGk0PoTwaQHEE1kWd2QsQ3qk
	 BdSAwIIC7nOZweRCuINvsiq47aeLLtajCNUcoDyub0vqp47x7+M0th3N5zmN4tg10s
	 lwaY7I7CLxYmZVWXlX7kj0t1J6cJ+IHj/cyZJmes362po02XX0sHE1iId8FAMMoeE5
	 eaHDHM2HFdoHJpPS76kRZDNMX5t42xw0qRbUvtSiDhi08b2g1ziv1D7kNBNJvWhYW5
	 m5FWZLKAp5tPg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CD982605EA;
	Mon, 27 Jul 2026 06:35:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3A6F069
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 06:35:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 22F6A405DE
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 06:35:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wP2bG1jLnl2I for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 06:35:20 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::42c; helo=mail-pf1-x42c.google.com;
 envelope-from=leo.liang@sifive.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 59798405D6
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 59798405D6
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com
 [IPv6:2607:f8b0:4864:20::42c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 59798405D6
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 06:35:19 +0000 (UTC)
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-8485b358552so2428734b3a.2
 for <u-boot@lists.u-boot-project.org>; Sun, 26 Jul 2026 23:35:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785134119; x=1785738919;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mcPDoK12uo5TedNluqaYEDOI313yrrG3UmagGNWEt78=;
 b=l2voIauQDF7z9VKTu3pXQ+hAaJ08X1eiqSEY1szRGdmvm5hsfOKVECxcoHN4EjyifB
 nUjPKlhyugp1/1+TW/m2OoFLO2G6Fi7w+7W7poxPasX0MAownt6KiZ83aDDi7Dgj/2Ib
 8PDdHaBQab+FXp2f7Rk2LP5eBZsNYUqC7BqHZWNjnygz+/O0k++M70qdC1yiITD5L/uV
 U36h8h7JX+9vOjgLungEVib+BzQJeNKxjLgSjO5rCM0iFVOgw0USE04B9CI3Yauw/lnM
 h1tCjY2lrF8bVz5IvVRnyIlw19YnZGAeZwrJeHaj+EO+bcOVh3ZG+5pi00pIb3zCq1ap
 PKOw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq+f9Y4wEvnHJ4kNMqgVny0k+xO1qkTXhMhj50a5fdMBx684z3Rx0te0KDJgjVFhTWVNdL/S00=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yw7/NNwiZEpd5PYUhsPekWtTxCxV3q+wRnEoN0EgJWJle1i7nuP
 TR0rWLie7fAtNVtqSG1NgHhff4EkDx5qGk5LxwtFmTFlFOvkCgGnp1ra6DBgGbWjt3k=
X-Gm-Gg: AR+sD13kehnrm/cF1Iugd1ldupi3j3cJz/Mo3D70VKhXSiu3QiBZT5uLk/MyM7ufwrc
 j6YopyBnJ2QSYX+2u6IvqM77oGUqH2u+b+PlO4aK3HBRmmH1KlhlOoD5/GWmCxLb9y8XSaV6wtU
 FDDtJaPChHH5U57DhjCVaJ+HLKQndmkLuZLL0NGqZnhAtTH+EiqfpRYZYa8Mw85A0qvx0utVcSW
 nbPi6udO2MPixzWgRe9EcGZTpVtHhm6eR6xVEjwhS/CDvC0bkoTN/V+RVdmJubqsWOnCI5m7bJV
 8EUQGJqai5aMvV12I0LlnzHX3zaiadpydfpIJslwwvEzoegL3LjIX5SR136tgNVXDzszdkwgBa6
 Rt1O9UJ8x4aJCSRItczKBjK8sqzXNsGcbgisXHgkvhDCx0LurxGWswJTZzga5beJPnCn3SkU3lD
 GwGdai/9/447PQkY8zXrKnlhzGxEt2U80=
X-Received: by 2002:a05:6a00:1f12:b0:848:2d1d:836f with SMTP id
 d2e1a72fcca58-84e59449d00mr5765212b3a.28.1785134119512; 
 Sun, 26 Jul 2026 23:35:19 -0700 (PDT)
Received: from lliang-1876.localdomain ([136.226.240.171])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84e53418f58sm2537526b3a.40.2026.07.26.23.33.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Jul 2026 23:35:06 -0700 (PDT)
Date: Mon, 27 Jul 2026 14:33:05 +0800
To: Zhuxu Ran <zhuxu_ran@zohomail.com>
Cc: u-boot@lists.denx.de, Lukasz Majewski <lukma@denx.de>,
 Tom Rini <trini@konsulko.com>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Kongyang Liu <seashell11234455@gmail.com>,
 Martin Herren <sputnik@on-the-web.ch>, Michal Simek <michal.simek@amd.com>,
 Randolph Sheng-Kai Lin <randolph@andestech.com>,
 Yao Zi <me@ziyao.cc>, Andreas Schwab <schwab@suse.de>,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH 2/3] riscv: milkv_duo: Use upstream devicetree
Message-ID: <amb7oTq0QIfLzA5c@lliang-1876.localdomain>
References: <20260706-milkv-duo-upstream-dts-v1-0-8d010ddda7ca@zohomail.com>
 <20260706-milkv-duo-upstream-dts-v1-2-8d010ddda7ca@zohomail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260706-milkv-duo-upstream-dts-v1-2-8d010ddda7ca@zohomail.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1785134119; x=1785738919;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mcPDoK12uo5TedNluqaYEDOI313yrrG3UmagGNWEt78=;
 b=QjMT42Q3h5wm/aNvFmM/veg7FPPcEBm1jzvg3mBUAIWN4c4BOwGtCNT5Sq4EOemaf3
 WPJRI65VO3zrGUh8JTfP3o8GEppAwqaDBlaJa3SLJVSbJfP109thopgwBIAWoV4tSdYY
 62OdUJQMGlYkwGNCtGCcNv7IAndnvTIwo5hhEntrstgThzMuxZmsT/vAJGl7KHt01ZQL
 VAV/EvtArkkE3DQ4qDEtMictSKI09oD8cK8kLNy8KHiPXttKF03lOUi+AttnMJaDVlJz
 pdL+YnzdR7mW0Ca6G1ZYUkwig9H75xaU5v02icY03SX6EXxVKK+2kDo+Jmjzbnf6mv3U
 H4RA==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=sifive.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256
 header.s=google header.b=QjMT42Q3
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
From: Leo Liang via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Leo Liang <leo.liang@sifive.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Mon, Jul 06, 2026 at 09:43:42AM +0800, Zhuxu Ran wrote:
> Switch Milk-V Duo to the upstream CV1800B devicetree by enabling
> CONFIG_OF_UPSTREAM and selecting sophgo/cv1800b-milkv-duo.
> 
> The upstream devicetree keeps the Ethernet MAC disabled. Add a
> small U-Boot override to keep the existing U-Boot networking
> support enabled.
> 
> Signed-off-by: Zhuxu Ran <zhuxu_ran@zohomail.com>
> ---
>  arch/riscv/dts/cv1800b-milkv-duo-u-boot.dtsi | 12 ++++++++++++
>  configs/milkv_duo_defconfig                  |  3 ++-
>  2 files changed, 14 insertions(+), 1 deletion(-)

Hi Zhuxu,

I have noticed that the upstream dts does not have a "sophgo,cv1800b-spif" compatible string for spi node.
Is that an issue when switching to use OF_UPSTREAM?

Otherwise, LGTM.

Reviewed-by: Leo Yu-Chi Liang <leo.liang@sifive.com>

Best regards,
Leo
