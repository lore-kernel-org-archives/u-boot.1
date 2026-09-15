Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 675C7C88E7D
	for <u-boot@archiver.kernel.org>; Tue, 15 Sep 2026 20:35:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 25FBD406CB;
	Tue, 15 Sep 2026 20:35:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mOo7LGJQ6Nmm; Tue, 15 Sep 2026 20:35:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 5D9E6406C5
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789504530;
	b=V+vNsxvHEBNEU5g6xUPaGMpYLOt/8wVNTvYtKIrJUU8iZyRcfw+jNvka+IWtaJ4JeBgo
	 K0I+dJoWP+PHczVAWUybwDbZzAktU2pjyOzlNHQZJgNQdXHl09ll3YnKDY5H1q0bMxe5d
	 /G/ikuLVVbV0mx3MmVdSFxFuX+irt/LS3fGpr96/ZtKdQC1FMg98Rkvzzh7b/XfbqNmYV
	 5SioZ+vKX4ZnKjj7liCppitmQkVVVn7Zaqxdx53B7IgjEPz0rNGnZ6h3kx5ELn+NulxH3
	 2gC/UzhmG/AJVb93Dlcm41G8tY1A24VUY1gJ7KarbwGzRUgxhXUQKIwVMFTT94u04cw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789504530;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
	 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=2ztc/mA3ZjRLt97iowKv7C5N+AnjzkHXJ1OEu4kaGlg=;
	b=NWE2Y06fPOe8hYRPV17CsdMxF1Bs3l4E5nzzvs+8RhuUP0yLr3cASo7UZkxzNJE/MWqZ
	 S6MQQYV/bCn1Hkz/4R+dZ1ZEf4avJL+5Xg19Rg2kId/oKVFE6isayZ9a0SRbbIbJEpm4w
	 tcRx7oM3YPrRlJDeE0ZP6msa27U2RvNbKvy97mLc0/W3qAID48/WH6sYzY6Zp97CYnTED
	 hLTL+C8unqaDrkGrxq/UsqLB3lyJgt3FY3vIFY+2IXpkq+Mvb6ba14aFwhl493n5Tu0Dt
	 brq3y0vZ/nZWvAS6iH1UPN6Dxh8enUxYyVtQIUmPa17Q3Jsoy8h/I6JAwhXPPmPY4mQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789504530;
	bh=2ztc/mA3ZjRLt97iowKv7C5N+AnjzkHXJ1OEu4kaGlg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MANBMAXziK7VcML6TrOKeu0CouS0cA312w+lrdavfl8QMUVKQgPv2iyF4XFPAw2XU
	 /1gHrgapFuqjCyyr7Axw45V+rJQvE/jGfW+fjXgzf+PB3YSEvfM+3ZDJybzEA+ypRr
	 C5Ar7HjRvM5Xkm0sjjuHW6auV9XLuXutGavWZdHFAV28/Va/bhXtje1LN8h/lYMcFs
	 WG1Dm6ypa7vnedBI+ftplaRBzmYpRO150njqPx9MWiZQ/y9HDe7XtLPId7yTq6vB+s
	 Jh5s/QGmHYXtpTt+oJAOkEFno6wClPDU+56ooaDExvak+aeb9MRWSMirIP2nVq7iiw
	 ocKpBuZi90atA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5D9E6406C5;
	Tue, 15 Sep 2026 20:35:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 09C1A788
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 20:35:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EBCAE6061B
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 20:35:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Y3lwtSo3EhqC for <u-boot@lists.u-boot-project.org>;
 Tue, 15 Sep 2026 20:35:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 4D6176060D
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:32::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789504523;
 b=SRDCv6FnrH54pzXi33CzmqvBnI8VUwp6axOoRHjKOK0cFvZMtRuT7CRb4UTTtyGra+yW
 77M/nUD8BvmVHim0rYt8bLVY45s6DoCOrfK748u+TB4o40gowSBrCqypoPF3rM3pCO9u7
 nw6KMuLa/A6nHOwgifjINkut4nRuc8eQE389kae8GOeyxNkVb27VnJCyZOoyAkkDvBVwZ
 DKKCLX5GNwVuz2Dbtgx4d41ANFBF6EtCabGGKYTruZTd7cjm5MY+yk/PVN/GRhaWKjSdT
 TCGVSJH6l4P8BroS6WZNI21aRaa/wKw8V/8uhkLHdQmEg6X28IVbfWQMC5+Wpoe0wRQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789504523;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer;
 bh=2ztc/mA3ZjRLt97iowKv7C5N+AnjzkHXJ1OEu4kaGlg=;
 b=Tzg99BVwYEHm++XHDftMQnk5il6MBuncXmYJe0eEHHfFbBJpGj2aAhCJftdYpBkEZeM4
 xt6NZSFom7rm9erqmqUx8tru+Tit5juhg+zryxksaXXLAEQ+TKvmtfUs62j6w6deULNjE
 jYHxDz8uKYhB1Z0y2BLtg/FwWH26oQSNctHtt+3X+G+Y+R7dRj0Kt7UyraSyVYsc5iPlJ
 5rpOCf5YGVa3r2RR4b/UmKdBpI6ov6Aw8aRnAvc0v6a+T6bcvxGquqbuLgQRMT1ABeJBJ
 whKfCrxl/0cdKie8vwGIlTlng1wr0Ph68mOW86QXsETDdDXAqJD95MKapONUCaYCWXg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=be+AJ1Ut; 
 arc=none smtp.remote-ip="2607:f8b0:4864:32::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:32::11; helo=mail-oi2-x11.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=be+AJ1Ut
Received: from mail-oi2-x11.google.com (mail-oi2-x11.google.com
 [IPv6:2607:f8b0:4864:32::11])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4D6176060D
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 20:35:22 +0000 (UTC)
Received: by mail-oi2-x11.google.com with SMTP id
 5614622812f47-4b37a30eb3bso186865b6e.1
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 13:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1789504522; x=1790109322;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2ztc/mA3ZjRLt97iowKv7C5N+AnjzkHXJ1OEu4kaGlg=;
 b=be+AJ1Ut/fu6/MMa9SCDfSQ1eezjpe/kbscO3sghCJjk2p3oqPFAZsUbwzzkUOSoKc
 dJ6SdBnc+ePLEYH8AGf7NtUzJ72vCBfRZBmGm+H9vAvJDTr/d17pyx7/1UJlmdSYODSf
 gDYAW9PYw6A5VckKsGSjudm59NAs/74EbcNrs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789504522; x=1790109322;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2ztc/mA3ZjRLt97iowKv7C5N+AnjzkHXJ1OEu4kaGlg=;
 b=mV/AuaFBKuTYCK3LrZbKFTUOQKBFrF/zy+QE323OgXho423+MOJsSxu9TQKBnu4ixN
 dG6rBl5TDfyqFJ1WBzpwYFTh2wuM1cleCRI1vnE6ZYVs1ATk5FJer4Mwcv/KoNOfb4P7
 /ZzBtEEBIp2NMiRXWx0DEkcqxtaVq1syt/o7Yn2BVLfIxqhOM0wjQ7MfHGqLwoGk6Cct
 /vg7ltVuGH/MPklBmNBv5kG3pr8lnH5D5YYPRmH5hvv3i6/1awvI5jN7onRFaclZ8Vca
 ttIAZgwpDECVWgQnm5o3a8pHVqK16Q34LLZTkmc520hYSdag89ChrM2eZmHZU0BwWNh1
 Es3w==
X-Forwarded-Encrypted: i=1;
 AKwUvBxSVzpft8xgHX9rBceog8T0oaVu+A470sQlvdcUWfViF53BuFZJw44a/Ird8kMtdLiYZuA5bwY=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lw8bdHnmCWhhmmk26ukihNkDRoICJwlxpa3CF6LjBhiH+sqAHE
 QrxcD/FmkaVdIfNcoG1p6LHvtOsVkLZcXckcQ52fLq93joYKHuei8V0C80i2h+kznkE=
X-Gm-Gg: AYBFou0rKxyh+uUy7g1F6vd/DjHAJP2yLSNYCjBO3xNCSNd4ZxeBNN3LG2FZqcTQTcz
 J3pIlHIre928YIElaltQWsCR8DUm0vSuxyP3qF4vxO79AEJKNxGRhzQ+EzxPUVsEKwSQquN5qUO
 BFk9pH23DLRgyeUsvbOlFGLdmRqhjPzWhLrVK+QGz8cmMiGdnb8WlejYD03jpdUHhd53jjStaAd
 oRJ+Iv73+3p76vpLp91uI/zJ8a0O3rBywrbm8y0P9qypmE6FH+tgwaWZDcKmbeyHYWp6rG6m2Kx
 W8OPy9DstyOPibiC0u9QOUrsa6bWPieq+260cdqcntk2BndAuqdysoAL1IHHY76E+c3+zqNHRTd
 Eh0x9He44Wf6B05kKBavzKwhh7eU58lH32t97mQ9fsbJVd6QPB130Od9/ymDnnaQgIHQBJQhieb
 G5J9kv1QSv6ILRjjTlflNnQqBSqFQgs64FOZnS+Wy1aKQUxEcjTNxZWEYQEKRhVfTBGmiOXj6r1
 Zd4jOnEkYzn4VuEnumFtOIGOckZraEKv7Ma9v9zWa/AmP0SdaAtv8UNqfFbGy8oKJGePuMN7Jml
 qqfAKytzxsZMTHhnsTc=
X-Received: by 2002:a05:6808:c412:b0:4b2:8d9e:de11 with SMTP id
 5614622812f47-4ca4dc219f6mr21347b6e.19.1789504521846; 
 Tue, 15 Sep 2026 13:35:21 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4ca20e54317sm486511b6e.2.2026.09.15.13.35.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 13:35:21 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: "Omar A ." <gizardglazeman@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>, u-boot@lists.u-boot-project.org, 
 Omar Almahri <284399732+Cyberpsych0s1s@users.noreply.github.com>
In-Reply-To: <20260830074038.187514-1-heinrich.schuchardt@canonical.com>
References: <20260830074038.187514-1-heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH 1/1] lib: rsa: reject oversized public exponent in
 rsa_gen_key_prop()
Message-Id: <178950452090.931545.15166708913529482486.b4-ty@konsulko.com>
Date: Tue, 15 Sep 2026 14:35:20 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Sun, 30 Aug 2026 09:40:38 +0200, Heinrich Schuchardt wrote:

> rsa_gen_key_prop() copies the DER public exponent into a fixed 8 byte
> buffer with memcpy(pub_exp + sizeof(uint64_t) - e_sz, e, e_sz). e_sz
> comes from the key and is only bounded by e_sz <= n_sz in rsa_get_e(),
> nothing limits it to 8 bytes. Since e_sz is a size_t, an exponent larger
> than 8 bytes underflows the destination to pub_exp - (e_sz - 8) and
> writes attacker-controlled bytes below the allocation. A 256 byte
> exponent gives a 248 byte heap underflow of controlled content.
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] lib: rsa: reject oversized public exponent in rsa_gen_key_prop()
      commit: a5c62c87ecb1a0741891eb7d2abfb6429bc62a46
-- 
Tom


