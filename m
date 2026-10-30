Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E7C606A322
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 13:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=L8d2xyay;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=fplYtIAG
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 880DB60A86;
	Fri, 30 Oct 2026 13:30:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qh5h7VsBy1s9; Fri, 30 Oct 2026 13:30:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B04FE607B6
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793367028;
	b=WVf9hnH3gNTedf2OGwVAtx42maeVXAKuyUokR7QoN812box7R7K2pCBTR5TWXPxQ1CsD
	 16nYCpZa5tZIp/o3PSfEWF0bEb8ZXohg88NyC61VPyhPOPmdAiQ6TilDWNkqHaiLGYLrM
	 U9NKZjR4n5tcm7nVK1K1P6VKf+tDdZ+mj74aKO4KXtTCq32+FvX2F9CV1Eo+uV/5ZzofH
	 xW2eqLQSogwbZdqyn7ztg68CqAFf1bXpbDcUJZzJHgPvMuuGiuCXNZxlel7X0md8qNew2
	 VZ7jsNWBIhwHJ5tJiaq2euuLDFPYvsh0Y/Qlt7VsLQZNK1HJmG1eVurqMwmoDn3vIFA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793367028;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=A8R5+q+Ss4oLH/OR+Ve5Iw9w+MBk1er06fc2wWzPEWw=;
	b=sfOX4CJOlh4dfYzq6lzg496L1rFtVq5wdRmIbaq7fJzqUVBwX8M7nrW05K0wsokfdq4e
	 69mi4Lis8exBY3bUynvoGlDubAG6iAvBkJIbqb4/n6zLfNCmjEQwOaHcYXQF8Go65eaXI
	 7HD2A2JWnJjLvfLPk9+Jm54phS7paCbpbMQ+U1kNSIIyIzFEvqIeCaNfbfE5HKDyNvw/3
	 QE5hH/CBEpFlwJQGukaKCDWUqjqlT9CSqsf3K5HmpsoesAePmK9ObvuEXH/nQKM+reO8L
	 tmXS5gJJLoPZsmzQ5DVr+6PJ4OTe1Uk/SYEdzDQcl/DB10xnWgebYf36fWwGHCxGUqQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=fplYtIAG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793367028;
	bh=A8R5+q+Ss4oLH/OR+Ve5Iw9w+MBk1er06fc2wWzPEWw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=L8d2xyayNzT+GfQwopPJE1IvOVH3Lyzt7gf9NiYmZ2N71xV+nojAdfvoPtkFHnxe0
	 KPhgBmLcLvfGFi/u9mC9ILnMUm8pe3IuRp1kO8UMrD8CdK5KAfJ1gXdRxl8wAEnaoL
	 KAaNYYBsC0WU6+OssxcjczgoEcWWUA+b99rdoK3JJswnlnet1Wq4Sg7wEDDW+ILBft
	 B1aMxJjE6R55dHGER9jkiqd3Loe+p+v6SupjqA5b1CJwBkeL+10rTCi+Pw4VW5ZeQH
	 jLYzYGC/e9zdGKbx92H3h0Q07j22tkfGL6fahok7OCyRz+ag/9AZnyMfLVKvRlcWfZ
	 ATPYx9UhJjZ2w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B04FE607B6;
	Fri, 30 Oct 2026 13:30:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id B3CAA362
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 13:30:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A4F9B607B6
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 13:30:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0AReNX48P6pd for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 13:30:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7CF27607A0
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793367027;
 b=RymTueGemfwDX5gkhPeMT9y3HChrBqgPe4UxqLSmBKr2yEZvv701Cu8gc53Qua+8JcGv
 sHIjbo9nfCHngdk6BoyJznqvyAqRRDaLNdqmhI63GUGbd3hgYd5WvTqRTsR9m14nFy4EJ
 JHkCq8V+a18+Ratq/1wQHKbl+33sAXJjMthu9ttM9Nw+nzt/vKsXZVLpzScD5Rr89cxmW
 fgupyNAL92cgyDnSkniiex6RGceRrx6i7dA5ENRHWhOU6KybnSVFg1rPTEeHiif2nvwo+
 Ul/EGajH8E/y5j99utH9Au6ucoDVv1dkbnVTnnzuCD8W5SWxgNF+NLBJHYVe2y65dkw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793367027;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To;
 bh=A8R5+q+Ss4oLH/OR+Ve5Iw9w+MBk1er06fc2wWzPEWw=;
 b=o0FTerzkmU7Bpwy54Lj7noGlNrWsAd3oCCuoLdf91L6MoNCk3hN8Y6Bs2+702ETuSSGi
 bHxlNMwm74TUJ8m8nplTvvG9hWXjzfT3DkMZQFS9e8fw3k0vGXPqoSCKLdGhSAsNdiwjo
 ni5TQyXh7Hf+eguT3Ck9GP4FbJPJkog+N0jj59EQi3Dm4+xSFzUTR3iFBIM1FmJlcFvLZ
 lvz+PAvfTuLuAQkuUGaVCdZwmmPXunYHakl1gT3PAOC+pCnl+BiS5DWxsVoFbi3yHLOEs
 /39SjM5SQwiM11WCGyFgjyjbI9L6foXDEpBBQgxz4jhvth0TnhotOHD6KVWDbT22/3g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=fplYtIAG; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32d; helo=mail-wm1-x32d.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=fplYtIAG
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7CF27607A0
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 13:30:25 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4a9a8d6cea8so8765045e9.1
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 06:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793367024; x=1793971824;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=A8R5+q+Ss4oLH/OR+Ve5Iw9w+MBk1er06fc2wWzPEWw=;
 b=fplYtIAG+obZ5iBYlkxBp2RJdNbzlmMRo/bmhgha40L871H8ta3y0oeLKUTI3tV6xT
 c++wDlL4w413No5bKEyyljQWGCieMD6t3mO8AAaQj3H5gDQB/8zxrjpwysBf/2QeQS6u
 D3rPDXf8SoJ8uty/t1JxwiTmZ02bKGVab3rQHPVwi4jQB+ylmSKlgVWG5aKXQwk9RTiP
 w78Kvte6wOR+3yuwr++qKEZIynmoDJDSqZXBd5PYp1ZV5ksVw3mvnLQrI4vVbAGkd3Nf
 JmLwn/D7NmPibyncoiyPNkmdX7LqNtcWw0VAkrtYFXup9KN+ADDW9K4w6XEqV3oIhSIp
 omZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793367024; x=1793971824;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=A8R5+q+Ss4oLH/OR+Ve5Iw9w+MBk1er06fc2wWzPEWw=;
 b=WA0NYax5ZwYiPpqh4Hp58RKHJoYGNPdvgjtmbOHExy+rtbH7M6HCvTLAfj4ifLkKVH
 r2AuME3gHzWgK2iY5q9ojb7eiBdnMQOA0Or1mjC8MRd1ljEXUVzZrAxA9qQBRjkpAEH9
 T7HjkA6q6MvyoGD0H9pjm+MdyzmAPY7EpQz93vrzUq1P6aT/g9HL6jM6M992m/EbJaZY
 V8E7egIsEU+PxLEZD9BZQFA177lF3CdJ5ZbZlvZvxhEGErPDd/wt0o9S522Qy2PBF9YS
 6ix4JrgHxDHW1Q3VBZ+3Aa9ZSxo+i6kQH+QgzcLf7/b30+Wol1450M+lOM9IVXe33+O6
 128g==
X-Forwarded-Encrypted: i=1;
 AKwUvBx220+sggAbrCf3ijZcHOBtvho0sQ0lXP6PnO+wQOsv87WxPuWgXQYcyhDw6lxjXdwdRtuJw0Y=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKAazbC7uU5jFjrFpO3Jl0wSe1I3Dh1RQH+iUzvUZzno2dHoPXg
 O6U1DkqlCkJbhq47F9QG8TTyOFb1OPTx4BA9EGwe+QTqq6fscAEthfKp6vmmFFcx8zw=
X-Gm-Gg: AYBFou0hVy3ofZFf8Iu4UZlutBRXVW47GBfl3UqbYV2HKi6dT9GAxD1zx9OkCuw0Oa0
 V7LkEJ1W6X3pG6GbdXYRTLpYOFEkAwBnvISmENmClf3CDk4R5egSj2D3+oWlHMIPYY2z1O+FWao
 Jd4xAEw2hSXY87IC8L00hLL8cQaScgnpGG87yk6Vz3S3wOoib5CyDkzU2OASyAbHsIIkOV6drxG
 KEoHcOitkq73Yesj6CycXpyg0+NE3zBV4V4NWb9/pxv67VWiDAFKMy5ITqypZ7LsN/p3D61nLO5
 2vIN3EV2YsPqHrVDLAF9OtwMrbzQLqq9OKkqxAznXLaJPnSozyF+1MdW2JgIJQNkEYPC5T+D3XU
 Y0VCYeNU7nBUDTX6wlaG9+63YkKVahMQWb8Lk7rg5ByiXgI7I0oFFLJe3Eqr+5E9/yNlTldNUko
 NVYl05cB+U6JewoD/1UvRn1h/xG8b0oCHtWXdklHVsIBAzJ2h3ZcaIJd4GpP9xLjnxhaln+8iBB
 yNNpOz8xJy5rMzoADrTmjVtHMoyx+ibVYOPTGUmg0T6WQo4ewWO3JTUulG5Ee3Sd1e+V+9XJZkM
 2OeNq2Uc213tpM3ctrnrGVD/7XwLYNs5WRdRQKV2rWZhWmJuZsEIATLF2lCj/5Z0vRGLaSvy1TL
 sKJhZ+0fvzaCFDoUK8TYWGr+D9lsyuMvTLjlSYQQ3yeCugQ==
X-Received: by 2002:a7b:c8c2:0:b0:4a2:1104:7ca7 with SMTP id
 5b1f17b1804b1-4aa8ac7dab1mr109071385e9.11.1793367023838; 
 Fri, 30 Oct 2026 06:30:23 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-95-246-144-141.retail.telecomitalia.it. [95.246.144.141])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b78a4csm3310287f8f.23.2026.10.30.06.30.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 06:30:23 -0700 (PDT)
Date: Fri, 30 Oct 2026 14:30:21 +0100
From: Carlo Caione <ccaione@baylibre.com>
To: Julien Stephan <jstephan@baylibre.com>
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org, Jaehoon Chung <jh80.chung@samsung.com>, 
 Peng Fan <peng.fan@nxp.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 David Lechner <dlechner@baylibre.com>, 
 Tom Rini <trini@konsulko.com>, Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Alexey Charkov <alchark@flipper.net>, Macpaul Lin <Macpaul.Lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Julien Masson <jmasson@baylibre.com>
Subject: Re: [PATCH 1/4] power: pmic: mtk-pwrap: honor fallback compatible
 strings
Message-ID: <auSbsOGZKLsteUCL@macbook.homenet.telecomitalia.it>
References: <20261029-ccaione-upstream-mtk-g700-usb-v1-0-6b0dda25be38@baylibre.com>
 <20261029-ccaione-upstream-mtk-g700-usb-v1-1-6b0dda25be38@baylibre.com>
 <179335677538.4117849.292438249217980426.b4-review@b4>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179335677538.4117849.292438249217980426.b4-review@b4>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 30, 2026 at 11:39:35 +0100, Julien Stephan wrote:

[...]
> >  	while (of_match->compatible) {
> > -		if (!strcmp(of_match->compatible, pmic_name)) {
> > +		if (ofnode_device_is_compatible(pmic_node, of_match->compatible)) {
> >  			*slave = (struct pwrap_slv_type *)of_match->data;
> 
> Hi Carlo,
> 
> With this change, the pmic_name lookup at the top of the function can be
> dropped:
> 
>   pmic_name = ofnode_get_property(pmic_node, "compatible", NULL);
>   if (!pmic_name) {
>         log_err("%s: missing compatible property\n", __func__);
>         return -EINVAL;
>   }
> 
> pmic_name is now only used to check that the compatible property exists,
> and ofnode_device_is_compatible() already handles that case: it returns
> false and we end up returning -ENOENT. The pmic_name declaration can be
> dropped as well.

uh, indeed, missed it.
 
> Also the "REVISIT" comment above the mediatek,mt6366 compatible entry in
> mtk_pmic_ids can be reworded: this patch fixes half of the issue (the
> limitation of ofnode_get_property())

yes, let me fix both in V2.

Thanks,

--
Carlo Caione
