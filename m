Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D7EEC44536
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 21:01:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CD92980AE8;
	Wed, 22 Jul 2026 21:01:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yuxh9trPbsYe; Wed, 22 Jul 2026 21:01:44 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 04EE680F68
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784754104;
	bh=ONs1IHAZVbhyW1tZWbikxpwesRMjvsU9ODCNuaggmRA=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=GnMAxLTYKvFw4FMYS0L19WPI09txMGUk2Iq8/MJSbKzfc+iP+guXANaTY/QlFJX37
	 Ujic40ZmtEh5yXYBHwl7nb83n7VZA0xjGc1WdGIMJO8QE4JRNpVrmuTSmvSXgALsAj
	 I8kbyFP2Q5eWbbAD77u26amf86v/1MiGjkcON0wMj9IKnbBv1cxku6Qhhp1nmZ40WO
	 rwK9HuGtmFuxFlcPnc2/KfSR1cPAd34JMyC92W09u68MUM2b07jlSX9QH1HzOK8kV3
	 5n5tPssJ+aO9huoNOwddHTAyaIzss3fBoygOOmhxXomT2/DMAVf0UHAUSlPWq7RFqS
	 KwMRRQ4XEt9dw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 04EE680F68;
	Wed, 22 Jul 2026 21:01:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 780B9347
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 21:01:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5DD5C80F68
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 21:01:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dwMIjVNeLxKE for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 21:01:41 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 14D4780AE8
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 14D4780AE8
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 14D4780AE8
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 21:01:40 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA9F4848BA; Wed, 22 Jul 2026 23:01:38 +0200 (CEST)
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0BA6D83E76
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 23:01:36 +0200 (CEST)
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-6aac3dd65cbso612483eaf.3
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 14:01:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784754094; x=1785358894;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ONs1IHAZVbhyW1tZWbikxpwesRMjvsU9ODCNuaggmRA=;
 b=Zu0f3D3k0DI1AVrxB9iYf4agZp1Gt9n7u9q0nQ7FL6Ug9xj3nyjXfpYTW9a4JbgScB
 bmD72BQXrOwy922m4mPz0rGgCysDG4UOsw7wudh32K0fAltsBYFQ+Doy+uWIhiu1lcQM
 5+CivSadTq1OooW2Hm2EJ/C54iVEOnkPlrwIAQV2lFyw4xloSnHz+h8H0DR7DIPh0ISz
 MNsDhS26LFWlr7qDeC5b+9LsFRVwkMM0CiRQ1K28xjwVEI3IvnU3j/1K5YZvLcscqdgx
 VP99ajGKYTcjaE+i+e9TdXLEQ0Vr7qSRTbqkdfOrmDE98jQnfzrd1v+YVa/7Sah+k4Oj
 tKJw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqr6V2cgbX0lwVzkYnQxM52vd1ECJnulHz9eeLqsD/qxz54Eb04sWDFA70QR+6xkhWPNvnspNU=@lists.denx.de
X-Gm-Message-State: AOJu0YxwMeAFKBkXWpPKAAN3iJnQunUAKc1M3LxmfiwWbYun2uUg3gtR
 JdNUMy/U9bAvtIuHTkT0Rvnma+0kSEluqAAj6RXURiPr4QFSqWurJs2yeH0bKwdxBDU=
X-Gm-Gg: AR+sD117OKTnAhvf31NsGxJBQP4pjV+SzU/iieI8IW54XHKlfq1JeiW0l8RztJ7XM/Q
 xpkv9VPH86kSS58odxTphJwLVG32Ik5EdKQvZT9AozM7kcHgHMAsNcdTweJb5LtFEI8JvBzn6WH
 jIEr4kXfs9jyr4GEoURDJQnNtEh7UUrKXIgFTyfd4N5jnv7MpXPWyYadiXWm4xZTQsH9UMsNx2O
 vTXeBOf7tKSCJ/j8R95lQ96YKFJO5GZxW6Hv7IkPtak5Yil+vj7Wmybr5Yq7jEJWynGUT9xqVv5
 vRgHDily+Q4L8oOxG9rrJH4BZin1uy8VSCr93TTsK2nWSKZq1exYPs7wCcM8/SHcdrF1jMN+Ect
 htste/m+EuIcyKNifyxLVTvdLcRlgaMqljLLa7Htzsf5MC1nHKPBDIQlRqHgaUIKSdXcw7aN9t8
 vv3IDVy8g4Rb1F0i91auu70RtNE6c2nwGwZ45HeM+8rfy1gj5gCw==
X-Received: by 2002:a05:6820:220e:b0:69e:31fc:d134 with SMTP id
 006d021491bc7-6aad4163558mr33646eaf.49.1784754094551; 
 Wed, 22 Jul 2026 14:01:34 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:d067:7d1:556a:2be5?
 ([2600:8803:e7e4:500:d067:7d1:556a:2be5])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6aa79301fe8sm2200349eaf.10.2026.07.22.14.01.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Jul 2026 14:01:33 -0700 (PDT)
Message-ID: <69cf70cd-2eb9-4e97-aea0-fd95200204ec@baylibre.com>
Date: Wed, 22 Jul 2026 16:01:33 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] arm: dts: mediatek: prepare Genio 700 devices for SPL
To: Carlo Caione <ccaione@baylibre.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 u-boot@lists.denx.de
Cc: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Julien Stephan <jstephan@baylibre.com>,
 Macpaul Lin <Macpaul.Lin@mediatek.com>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Julien Masson <jmasson@baylibre.com>, Johan Jonker <jbx6244@gmail.com>,
 Quentin Schulz <u-boot@0leil.net>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Vitor Sato Eschholz <vsatoes@baylibre.com>
References: <20260718-ccaione-upstream-mt8390-spl-v1-0-1256b6dfda3f@baylibre.com>
 <20260718-ccaione-upstream-mt8390-spl-v1-1-1256b6dfda3f@baylibre.com>
Content-Language: en-US
In-Reply-To: <20260718-ccaione-upstream-mt8390-spl-v1-1-1256b6dfda3f@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1784754094; x=1785358894; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ONs1IHAZVbhyW1tZWbikxpwesRMjvsU9ODCNuaggmRA=;
 b=OGpZLJNVWo7hHkD8gXu6LLCG8hswh6W4idlf0GrJBSitGAo2/ckcYU0FojkpXMPBj4
 RG2i0MxZBaNG1Uq6Lc4JeOjfmnDnI5ZizYFNo4VWFrSYjrFxjlZH1k2rpY68kv2p1UaK
 3jwAgeFVUisXT7AXsEL58t4ZHwgQoe2H/sE8bXoXZsrrT2SFrbEZfHU7n7tlFFVTv3fb
 mE3raSJp20BYtTpkWDxV9dNSMbRyJRLlolf11e18VVsyaM3s2EmvPyXkHUN7CrzO8LYi
 zgumNi1/XLVD/lKYeg5TlCgF7t7u2d+MOkCbQUNWzrndHH1C0zmgrBM0h+24se90bftk
 4rSA==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=OGpZLJNV
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dlechner@baylibre.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 secure) header.d=baylibre.com header.i=@baylibre.com header.b="OGpZLJNV"; 
 dkim-atps=neutral
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
From: David Lechner via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: David Lechner <dlechner@baylibre.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 7/18/26 11:16 AM, Carlo Caione wrote:
> The Genio 700 boot flow enters U-Boot SPL after an external DDR loader
> has initialized DRAM. SPL then needs the debug UART and eMMC controller,
> together with their clock, syscon, pinctrl and watchdog providers, to
> load the firmware FIT.
> 
FYI, this patch has some merge conflicts with some changes that I have
already picked up in [1].

[1]: https://patchwork.ozlabs.org/project/uboot/patch/20260722201522.3930921-1-dlechner@baylibre.com/

