Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6685A606A325
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 22:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=cq7tfTsg;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=Wefvs0RF
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 44D4D40B3A;
	Wed, 21 Oct 2026 22:15:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5LpJajrt5Xy6; Wed, 21 Oct 2026 22:15:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8CA2640B4A
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792620910;
	b=BIcCQyT+MUAHlb+CV18cJSR3p2pzXIhXcO0+44g6yEdAaP/H2IjkKPgvWkS6vJ3wv+zR
	 RSyzpbQkGPwAyH9ZjT6SL7x9T3aSe7qEoWGXWqiU7YF3mntfauolIWxAFJ92A48JCfOlh
	 rPe8ycWvs5LmnJbOQuTgXcsyQqrqu6j76OhV45japeikYpq15YeApqLkv5saCoI900e9q
	 0jlNkDhJRH9r68KS/4ht7RUNWo9EjT+9PJUqVWdKcKJBfhim/gO1/OwBh1/Y8No8lqQdk
	 87/WSneyR+RXJpJgzP/Tx0UxunwJ+Ftf050o0s2P+AvgMpyQwTKTu+VkkAVVOVofA1A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792620910;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=fArobE3cgEtdU0RsHwOKckWj9pi1ICmwnYd3G/OsGZc=;
	b=Ho5PasRyTp3Rruu0ymwjAOmFysLj/LsSMZ0VON3Lp6tWCuAg3eH5eAZxEh7To+7Doc6h
	 9LzlBvz7tGZjD5S02NiKdsrf5L7Ky+n1AF52ONm/xp1rOYYCho1FSXp/idM9GnYFVSv70
	 d0P5ol3v04nzAEEZoKnjuBWnovJzoj4LU8uNmAz3jkb131GNn4hwLngkaink6CyZFOYDp
	 o7E3vmlTTP6owfWYODIpF/uGzeX6ntLiPg3GXuhDiDawhWty3ewtDmKVD9SlkfUcofOlR
	 zyvZP3r7vqVVYOFhNz5qZC0lNwct4mlPRQjvBUu8ujfUbg7zXq+MLwiGuNaSguR7oiA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792620910;
	bh=fArobE3cgEtdU0RsHwOKckWj9pi1ICmwnYd3G/OsGZc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cq7tfTsgqHHnis7uiX5tQs0C5SM+Y1sKHsRXwNOaHGoKJD5BJHHXIQJaZ1zSv0+Rp
	 fpijrkwNhaOJmwJ/WswrxjKrevOPxxbGVI43RIYMOUx+Tq9xCiZXtDZKinBJbVeWTA
	 by5iEerdyBnQOOYXeNm/Ey+nlduw5EH6LE6yDbAsu5aOxhc7JiH2ZbsPqfmHB26XsK
	 6K2jftCMTL6e5WybtoMC6G3Hatii7nQOwVtLOdGvkLWjIOC3q1LG3Idt8+A58iM7k3
	 KW/O/ioF9xGvKheVQOFLdN3ljqNd95+WHzl4icHX9b8uwMYrCYiJzHFgzAelk+BHR2
	 1ZCbn0lQqRcwg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8CA2640B4A;
	Wed, 21 Oct 2026 22:15:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 110021AB
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 22:15:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EB0B1816A3
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 22:15:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SdE7hcC-ZlZH for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 22:15:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4E23A81699
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::30"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792620904;
 b=WX/ZcNgs2ZsxdgZKzJMck/epalDcJxsvk5II/vH0kQ86VKGu0oVKDtaxTnhrsOdLBGnq
 m+EY9xlJXaNFiueuGyrnUFwVhTm919pTi66NsXyTdPCMOMlYt2VAPnAS7ahp9RUYxstS1
 tgK6RDnhGalJ88WdDB8stXnyMoZJvdYlPo2762OtC5jsn2AtLfiV3vRyCypxash9adyhi
 a+F1wSkWhrF2N49vfVpZv/ayUBQg4eYPb61SQO24+o8C1jgrmF477H8PUtOJDLUv/Y/h+
 gr9rvII2rEBsOy6GzlJ9yfPXkzI6ZuebbP3Zi/nHLOZ0+Pu22nxGbE/VAFpdlIGbyag==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792620904;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=fArobE3cgEtdU0RsHwOKckWj9pi1ICmwnYd3G/OsGZc=;
 b=n6pBXDaemRn04gcN0x7+3pSDhElu+eU9btDTJqnNWzQT0ZDiBs2cF6Ncynrodv2PGdlA
 QosBKoEvCR++O9jt1VSwfQmv9TlvC2p0RqxhjejibBEDRSA1qT1GcEmehSmXeoQxKENBW
 AkSvOecd1cl/KX9hqpIr6KULo5utnt6JYDpRYzEcC9+eoEgu62kNGes8/yhPlK+ICiC3Y
 3kA9Ra0XqEJQSBLV+YRc2OOHzwjaGDwp7SSDAcjbM9l0bf8lYhM4Td7DSZaokB3IRqoRM
 AARAL27aTrfnmORVuQbp1O89cMCtKVKOmXTjFKtlSC3uo03DX63p7sQBjXLrNsbnyeQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=Wefvs0RF; 
 arc=none smtp.remote-ip="2001:4860:4864:20::30"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::30; helo=mail-oa1-x30.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=Wefvs0RF
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4E23A81699
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 22:15:03 +0000 (UTC)
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-4a77761ff8aso615291fac.2
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 15:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1792620902; x=1793225702;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fArobE3cgEtdU0RsHwOKckWj9pi1ICmwnYd3G/OsGZc=;
 b=Wefvs0RF1gVb2TkRT5BQqlktVB1qgThc7UU12zvVWu65vN5jC/G8QUvpxfQmFR8Emb
 7O7mtAq9QmXQK0iv1LPpdUqM+MemcUxHKfo03fBkrbSvZokLtOHY0HPRUZ7ObMrXsYpm
 3YH0Fp8QhSquVvf/cvEOSgeFXGfhqjaMjrlh0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792620902; x=1793225702;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fArobE3cgEtdU0RsHwOKckWj9pi1ICmwnYd3G/OsGZc=;
 b=GCK03O497DZ5u9I/CDN/19xSbtIW8HXHAGNhK5NEh2yo1HHGx1dlKNVGEqw6vmVo5L
 +tzsEFNQbza8uLq1yS+H3ZOdazLgW6FZeCSmhDmae0w7ak7McaHxisYtkU9lksPrP2aE
 AyuKDi9BvtUaWTjiJ6mtpI+Se0aOLXZyUn1SEqHcoMfLlwmty5Wy4v+MasWaTM3Vczwk
 B4en8lgVzp2dm2VPQlLk0LN+57PGRMhJiAqpenJGtkE44YzmGr3NoBD+0cDGFskgqjTI
 kTkeUKdBwVU8bNOVSdsCguF123B+VW+A0bAGs0jFWv7T+Pg+l78fslCqsqmHj/oy7CPF
 sEfw==
X-Gm-Message-State: AFq9FYIGsp0Q6sL9bKNLImhV7s7ng+htkWh96QocxYNELmuy40Lu8W7y
 /hpDQnOp6q4fcH84ouNfedha/pADWChRaA+4pvz67XJRC+nEHQG01fWl7Hpq6nssu60=
X-Gm-Gg: AYBFou1lvaAnfw1wR6dMPP1q0VS0vzEIK/nip/Munyo6eRai3Qwca4kpP3MJY+Rq6IF
 yrzx2A3vQjzTUUAYLc6xM6SN1lG1UC/Nxx5p+T/IF5xqqDwFng3bzQ+26K5151v4dV1MXpZ71mg
 kK0/d7RwzQObWqzDsYj11Myqi0XkgC6pZ+M7hYazXEaWWj3cCpTmj3AwQYWWj+l4r2ejUDF8Yu+
 ozfoJyWEotWACCwgDK8Pvw0ubmf6hbrertCAhzNkyHJ5z6QOE3FnNMpHUYVAiSF8KK8DqTZuumo
 e/mAIYTRWPuJIO1Vktxnu/7W02hybU/uzYGODa/94PfYVvZH1wq17agNAvxNheXlJXRMj9jpHTl
 AjK8YzMWnept0iYEjydFIJZGFh6dl7P/zklDaROOn8GpC210WLLxV1/RC5f76O+T7MqZtfkb7pT
 EgImuDolrZn3jCGDKIRPY9OgBQi5jLVyzmTBWZ3Zr7zOh8fIqz75dXRswQVpNN88H2TmHW2SDDA
 QPmMjK0b+Div++tkZ3MOvU4GzHFTRA4PvEseMWj3uyzK9hvJ+0YNnV5W1pXedm575Z78HwZ1kmS
 B+gQLQ1J+MM6xxpEdIptwfbCzokuU+dDLVecZB79U8w2pQciQpkLcYGHL3Weg7PC+HXhNyVrTOg
 Ntkf1KEnUEHqG1xV554Vx
X-Received: by 2002:a05:6870:c274:b0:47d:a38a:6218 with SMTP id
 586e51a60fabf-4a7dc1bdb93mr2377757fac.25.1792620902236; 
 Wed, 21 Oct 2026 15:15:02 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a7d5ebc240sm2956084fac.2.2026.10.21.15.15.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 15:15:01 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, 
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Cc: Aristo Chen <aristo.chen@canonical.com>, Simon Glass <sjg@chromium.org>, 
 Nora Schiffer <nora.schiffer@ew.tq-group.com>, 
 Daniel Golle <daniel@makrotopia.org>
In-Reply-To: <20261012-upstream-bootm_android_b4-v2-1-4c18a34550a1@oss.qualcomm.com>
References: <20261012-upstream-bootm_android_b4-v2-1-4c18a34550a1@oss.qualcomm.com>
Subject: Re: [PATCH v2] bootm: set os.arch for Android boot images
Message-Id: <179262090096.3382776.17548196865564032633.b4-ty@konsulko.com>
Date: Wed, 21 Oct 2026 16:15:00 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 12 Oct 2026 22:43:39 +0200, Igor Opaniuk wrote:

> bootm_find_os() leaves images.os.arch at IH_ARCH_INVALID for Android boot
> images: unlike the legacy and FIT headers, the Android boot image header
> carries no architecture field. The arm64 Image relocation in
> bootm_load_os() (booti_setup()) is therefore skipped, and a kernel that
> is executed in place, which android_image_get_kernel_addr() arranges for
> any uncompressed kernel whose header holds the default kernel address
> (or with ANDROID_BOOT_IMAGE_IGNORE_BLOB_ADDR), whatever the header
> version, runs from boot.img + page size, which is not 2 MiB aligned. The
> kernel reports "Kernel image misaligned at boot, please fix your
> bootloader!" and dies early (observed as a stack overflow in
> start_kernel() with a GKI 6.12 kernel on QEMU virt).
> 
> [...]

Applied to u-boot/main, thanks!

[1/1] bootm: set os.arch for Android boot images
      commit: 686e847b6c1462213ef2c414f1b070c45b6452d6
-- 
Tom


