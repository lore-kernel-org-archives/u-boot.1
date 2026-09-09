Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8077C79FB6
	for <u-boot@archiver.kernel.org>; Wed,  9 Sep 2026 16:50:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 738EC406A3;
	Wed,  9 Sep 2026 16:50:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Gb6YlGq0PYbw; Wed,  9 Sep 2026 16:50:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org CD1BE40711
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788972657;
	b=CRehCVWtGWbt1QuslAT1qmvMxczJ35pEkWOkecp8xl4UryiOwIQ33Cxp+VD59Vrb4HEJ
	 nuT38rXmUeEXGmCw0O8darnWOVX0va1wBV70y/yP1/6Fz6BSzuQKzCxBkGSRNn3w+Mmde
	 YM+jYI/BgWIVRN/Tg4RMRvayLWggYn7mYN3dKPzOhHRa6sgmBvss2IZL3FjgA4SCDli3p
	 VMMMdWeuLy3CIKEUVfsq6XOkwjfLsfQrHNfTKlY3Jb+iytYga9utK98AxUDeOYRyjaVz2
	 pjgaHpjNYf2gVFLIuia56t3VrVdscYHsdT44gMUqHR9n66I0TjqV4tFz3DxK9WgfZqg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788972657;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=PAdtBIAZTdbduam2ktNMjKxBJ/C39lDFCbU/3h0jxbI=;
	b=akEtNZs++H9a4W/+RRLCimFufZoIkgjyptwQMNWihULzYPFJUfxCHyJ+5VT7mrIpf8bg
	 SzcEeWXyn45RjI4djpekQxGhOodDHX+GN11IMChFtEADbQzA6DVeeUivOZApqzKJSXb0o
	 3fiy/lVHVBooSgt7uxydPc5+Nl/aa5vEGhNqjntLUaS4CgrAqXxXtSpOYK70iZl7T7gnQ
	 zTylfZJz6GlIgGm01KzwRMvVJDW2/2P3qNfn6cG+Eq0WhA/Xnla0WIoSD6lFZtZbmrURg
	 iL1yKKEt7rY5x6swK8RxthQaz4i52Ja1P6fspaHr0TP7PjqDNGkTeiZDUy41CFyXR8A==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788972656;
	bh=PAdtBIAZTdbduam2ktNMjKxBJ/C39lDFCbU/3h0jxbI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ArPCZHnfOM26f3x1VMV2fdVfznesG7gxZHFS/vj5OuzrnWn7MXasu0dVb66uppfv6
	 nb1CgTUDVFxcjOwOVKljmS6Lo56i6d5jIevTrBzxTvPYEdL5v3R+5m/Avq/Jei/Da/
	 SvDSSbJ6FEUgtOxYtrNmLZd76xqbUxrXCdSCgU10b+8aBCPO/O8fl3dkln7G2oZfOw
	 MpfxfqcU+IRQ3KipTdNumrLXCALEdkmBxYN55TQAQDz24aDQBMhWF9mc0kSWevPEvL
	 leSWoHWWkoB4X1NlOSNoZJQ2rMJP5/FD+Ig0GyheyWLjAOdTj8YIZlXwRt19FwcXqs
	 WsA5fQ0wX/aiA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id CD1BE40711;
	Wed,  9 Sep 2026 16:50:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0B431432
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 16:50:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F108D80DF5
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 16:50:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id it-eARSqrunu for <u-boot@lists.u-boot-project.org>;
 Wed,  9 Sep 2026 16:50:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 9FB3780DDD
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788972654;
 b=SDTwnfNL7g9XgLS9tqtWuJwpDbxXvrm/SSNRxK4FfB7grEyeawfCRM1qJJ3yy7jadX80
 /p9NSHLJBXe8h8gk3farYL+1mS/Nh+7ZUNsQtuu5hMeRGxzh/z5gBd6KiO0mXyJI4pg1L
 abZJX9Cpx0SW5GjbAo+SulW7CBV60wMnRuwiUyxwC6j2Mx02Yc0DO1OIhXzoYj70rUlcN
 Hx86SYyz84p66XDuwUQorSES2e+it5Y+YMPnSlYGzxzTP+9oyFLASpYqSJrQe2XV5mlQ/
 MlWgf7JgGHpun5CAUirmhvDBjU0VOrWVEObDH96q6nJKo2SKCZnkui9ENRM48lZPMxw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788972654;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=PAdtBIAZTdbduam2ktNMjKxBJ/C39lDFCbU/3h0jxbI=;
 b=mCfAqPWinuJhkAnC66rm3H7TEe4qNdeNB3H0e9qk8BkpZpHW53nZFT4tiurmWjRVTQkb
 XGmWXcgO+A9/tR2XUaMt0HyhoQ1GSifZyDnXFgeENGdxx4k/C+EeVXhlU3lL5bkVfnjjL
 sZ+CG/Rmzn3bDbSyY65ZkX/uAQuSitK2+zcOorb8A+WlBdDoCvDBL60inwYJLYeaIu5cM
 pt9H/eVBC0nYRvIesMPLU1kKclozQWMmF4wL5ytAPi869JmTvcykelHK9My5GteLoPEqo
 70jShwrMrnqynyBV2MfkQZrx6TccYaj/+3UqAsznNWA6qxr8w6BDkagprHJG3EkAhAg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b="bp0J75A/"; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::e"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::e;
 helo=mail-oo2-x0e.google.com; envelope-from=dlechner@baylibre.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=bp0J75A/
Received: from mail-oo2-x0e.google.com (mail-oo2-x0e.google.com
 [IPv6:2607:f8b0:4864:31::e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9FB3780DDD
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 16:50:52 +0000 (UTC)
Received: by mail-oo2-x0e.google.com with SMTP id
 46e09a7af769-7fcb425fb6bso306889a34.2
 for <u-boot@lists.u-boot-project.org>; Wed, 09 Sep 2026 09:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788972652; x=1789577452;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=PAdtBIAZTdbduam2ktNMjKxBJ/C39lDFCbU/3h0jxbI=;
 b=bp0J75A/guSbcbbta3MQSHFRnrYI2Ep/RYGkIlfwAA4JLcdKXG8Qj0RkB7u9rVb64U
 ra3y+P1FQ5H0/YzGYvi1M2Zo/+jvM4UpkJJNBIRD3h5VFRN1jF8pf6Gc00EaVeZaXqd2
 zAIKE+iXBVTxb0tMS1plR1Hx8XPpCsKZndhs1Ob/0/DJCLPOsidw0yt1Tmhk8oi7KS1t
 9+FDiEZoF1ESujANeTIHw/Ok78IJBuu1DsvaKd7q2b4hblW20oWHKKhEYR0JilnZQntt
 lflZYFUTI3u3uMqb2Ut2CVGVFW3fDgqB1XpVWu2DvUTUu/LsZaJ1SLake0c3SFhvjHRX
 DRgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788972652; x=1789577452;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PAdtBIAZTdbduam2ktNMjKxBJ/C39lDFCbU/3h0jxbI=;
 b=lc3QAiX7zi5iGYueUGivH3kA1Vbp0Jwu5nFLlWLiEidNd9IKvKF6e6ZcjHe2y2B0sQ
 cYstZ8GnmeZbH5M2kSPVrF3zkeMI0eVISC533keqYw87ZM1/VNjuXexUy5FN/tWCtSUh
 AvcR0A62ug/36Y2dkdn2dvCoPKRH8waQWsgt/sTLBf5aASPEVn9QDWmzmPsH7bDcw48t
 EmpVkn4BdreH4LoFhQeILsGEvTxRqk+I5h9XdN8a3DT2sxfG89sg7LmrhUeCb0sv6Bcp
 XKHCuRg06SwNYwlrjzS2q9pV20svvwPM4wiTsWRATsEvIiMcWlvWe2iufIoGyj29FYW9
 64YA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzputKAR5kFP8HL52hlZ5Dhe8PA7/KL2Igymv8GLaLZTt7B4BIID0UMO854ddS9W8T8xnES1FM=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kExEC44x/ZdMJN1/gnlBlEzq647rkCAFSpZwo/EmrKZ4dJrS60
 37PF6htyo8i0lfCNnUFVDQdhbK1f269mpd6+Wa+uTaD8D5b2Rp70decOMsfTnGZODDM=
X-Gm-Gg: AYBFou1w7u78Rh4Vry2eZ4JamPrRXkKxIuAmkDCeTpEq0NSzfvtWBlDwbMsah6iWm+x
 +Z1NmOkH9oXAXhW9v8hqtDJNtLlw+VrtLAWuCIF7G6PPfZwFmXpZuvhz1ZN6XHpQC07TRu1NdTi
 CLgfuUkOTBMyyteczirnocwdlinRMPc/xS7slj3h2N9IONFdbSbOwKmr+SFClXWxzhH97xncTjC
 r8lIgX0djWRu5XSCmCf4crkEGIwsYhU5YWx3bLv1+ih0lIOmBaTgqOQgmCgyletGmbpJMzCCGKb
 kjils/UMOLUJMEsmWBQeJJK9lzrpcDhShh1gj45vlSCiuVGO/Hk3kunAeujWEM2AIKzUeVQhFyp
 Nmb4jvB/GYLCQSf126XUluVhVLXYAXpZq3pi4gPvcjgr5/wYaDssXai1oWNux4IL+XviSKcWH9c
 nEMZYGQFV9fp2jdxXxqvXNI/8YUHNjRMd7rf5u8ba5iGhHLFu83cWq4YvITevXGPpMmt9zG0Bfq
 g9VVOy73cQxNG/XqOdRFHZcCF8SdL1flijbMD9ypihY0EsZAw==
X-Received: by 2002:a05:6820:1689:b0:6b3:5741:591f with SMTP id
 006d021491bc7-6bee53a56ffmr1961245eaf.26.1788972651766; 
 Wed, 09 Sep 2026 09:50:51 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:ef9f:81b6:a41e:b9b3?
 ([2600:8803:e7e4:500:ef9f:81b6:a41e:b9b3])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6b6dbedc6fasm19763437eaf.3.2026.09.09.09.50.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Sep 2026 09:50:51 -0700 (PDT)
Message-ID: <f332a00e-d6cf-4f51-952a-218e734fbea8@baylibre.com>
Date: Wed, 9 Sep 2026 11:50:50 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] arm: mediatek: add BPi-R3 Mini eMMC board support
To: Frank Wunderlich <frank-w@public-files.de>,
 "Lucien.Jheng" <lucienzx159@gmail.com>, weijie.gao@mediatek.com,
 chunfeng.yun@mediatek.com, igor.belwon@mentallysanemainliners.org,
 jstephan@baylibre.com, GSS_MTK_Uboot_upstream@mediatek.com,
 peng.fan@nxp.com, jh80.chung@samsung.com, jbx6244@gmail.com,
 msp@baylibre.com, u-boot@lists.u-boot-project.org
Cc: daniel@makrotopia.org, skylake.huang@mediatek.com
References: <20260906120756.8290-1-lucienzx159@gmail.com>
 <4c03ad9a-1314-4cae-b2ff-bbf84a6f4b4e@public-files.de>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <4c03ad9a-1314-4cae-b2ff-bbf84a6f4b4e@public-files.de>
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

On 9/6/26 7:59 AM, Frank Wunderlich wrote:
> Hi Lucien,
> 
> it seems you try to upstream the DTS from my repo [1] (i did not do it because of OF_UPSTREAM discussion/requirement) only with minor cleanup (e.g. dropped my attempt to define regulators as such - was not working in my tests but imho more logical).
> 
Yes, let's try to make this work with OF_UPSTREAM.


