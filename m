Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8EA606A31B
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 09:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=aWCp9qO8;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=Cqj4S42g
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 26AE76080B;
	Wed,  4 Nov 2026 09:37:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9DxTIFnZzLGs; Wed,  4 Nov 2026 09:37:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 67DEB6074A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793785070;
	b=FPrtPy+gqTEsIpR5VJzzUxlgkKcGr95pZPt8kMk8EC+YTl1Zdp2Jo00sd4EZDoCVd0M1
	 FznUwp0wVSIFjb5aRrGsBJ8wMuiHtexwWJpp9vKxWPamdTEH9ecjHM0rE1cvt4BnDtzna
	 blbP/Fv+Mj32VD5bBXRmKzj+Q8HCIFsh/V7+SahU+n0mbU3S/KtZCqKEOQa7lsINwpbJe
	 rmeQU1ZrHVLwZRmjtraPjas9L1TSZ779m2PPP+1xj026/pUYg7nB6DmpSOQNTimo9ZeQO
	 IDYuRLAmsA7gEI6pio+E/Zm3dQ3QGicKOl2aiHNs4H1E24T2Rx2DKSjseTHtWDjLwsA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793785070;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=efIOgZ+vxadVYwsjKKc406AJ6LMkZgMS5uKko4OIId0=;
	b=C0gDVEMyDc2/P8iXiO7U4fIdCAcCwzzGpzubWAX0IsTgF2hWuN6chkIZQFL+LyTDOg86
	 zomB5v71xCpMozjBqXoESzZJofek8Yt//+DGLmfUtst7q+lOYyXg5K6uGQvHlGj30uStf
	 iHpBm5VB7BOw25xPLRMhQyTiKbh/qdeD7pF9C+TdJdrXhMYgByoJmiMOmVaCD4ccVJSFq
	 eG8yQVK443OgbArnwzJ5FmWMaLS8cn2htDbyCeGkSra7viQM+/UXC9nfBoMBkLSFFkm3f
	 7s3+Oa+GFI+tOtZSOcJcwwtOnVoO46unMVanvSAyk4eIp8/E5pzZRKaBWUsq3YNwUfg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793785070;
	bh=efIOgZ+vxadVYwsjKKc406AJ6LMkZgMS5uKko4OIId0=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aWCp9qO8ETJIwsKlqpOB/6akvdtag41Ws0za/0IQsv4Vf1rx4dJJ5gtwYU0yY7hPu
	 QZsGdM3YiXvox7TeSCV6Al3hOnQPVMgdN5NOf3QZdWsbLpOm7nX9PG/bqqaANgJXK6
	 eVqJ2I8cuyrKpMLB0Iy6mUZS7siAcZ0vEs/OrhmAT14A8i8eArRKUfGaKgHGZJpv1O
	 gzp7BZo7ALyJr6pRgWIeDBAWtmkpANCq/UlZOWk53yO+YaMKJtgqVAog4NStpn2Abh
	 ZRp8L/zQ948i6/vsGQrJhxWRGf8dJ/H0hx9QGwoXFGVmNQ4ET/wVjAjG5gVri+O1Rq
	 Uy8tRkgGuMprQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 67DEB6074A;
	Wed,  4 Nov 2026 09:37:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id CE2EB37B
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 09:37:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BF8C940743
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 09:37:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JvMm9m04bsgr for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 09:37:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4767940652
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793785069;
 b=BEQ0MPk84xwdNwtE7GC4GFaXX+SgYreAOimUrtHEgt4+QXMm0yv9XwgvrY6p0WElbnQe
 pnnA/9NHWs9a8zlwa+ofY+kREVYrmh3/GmEYgSRtcuHyvFbUxWu+NHGtAbEVDmam0cH12
 JcrnikRH+1AzwezKnYFoFuwwbAtzM9AgalgDKHfyiiD29anC9u7jGA802787elSgFVAOK
 nPoSNoc2hM21N4yXv4KZkd1JxqdrAR8fuyK3bBfvHR8Wy+SRM+tRvd5JKxbRKOtLyYdp9
 oAE++l3BjU1qkBxAy4Sf7WU+7GUlxa+cwlgVixuBgr7oB9Rabx4BNtxXctyEDBnONnA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793785069;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=efIOgZ+vxadVYwsjKKc406AJ6LMkZgMS5uKko4OIId0=;
 b=rzSYGZn4unjtABMxaLg9s+4L0rfftx+dryR3s1DF2MGzqafSAx8bj0Qwd2a2UNDoxxk3
 j7Y/JoqE5VA8fFtLDSTnIQKOr3Q21uoaB2dLFSTzNQn3NDeFRVX/K+6Q3oFx0HZHzFAe0
 eKBGaNqQtcNC7y9S0/khCR5QTdhg5FAMzpRAAkikbJTAkicYZtqL8wMVFFJRAUbyzU3Qw
 zQ0xeGiTVy6V0SyjepzVWIF3+9DewJyWZwICSUUMwN4ldY3dsXx7Tgy+aTJX70rDamny+
 IHBYHM28lGIJmRiDd1MBDJqCmnuNJBPSTj9HeuoiBZIbVZbrfV8XzpwWG0w7OZ5HPfQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=Cqj4S42g; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32f; helo=mail-wm1-x32f.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=Cqj4S42g
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4767940652
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 09:37:47 +0000 (UTC)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4a20bde60a0so3460535e9.3
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 01:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793785065; x=1794389865;
 darn=lists.u-boot-project.org; 
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=efIOgZ+vxadVYwsjKKc406AJ6LMkZgMS5uKko4OIId0=;
 b=Cqj4S42gv0iDT6Z4MOMvMULFX9TNwS8GOhWBvypzXovauTPHEMLBuUqAn7nvoCMiYo
 fq/adzds7eNak0tHeYZJisEJ9G5DZvHW0JLJ+NzPhLsh+tBlcTGtB9/wsoBxzoPHjE+k
 hY4WVOHKyUqwU2IrT9sWANgicERVTT3Mh96wsaWViDu4A+xY+kuO5rjiSbcLlMwp+3Bi
 xTfAa9aYeNK+aVw9m5XGqhGSsS2AoIJm1Thx6j1Q7yq3cD6Iju2mvoX2Tim/YtjHl31L
 J84aFeJJbEoPGr+Nrf7D19swfGkzWBNTtNkHBlvGvIxYjfAZFAqEJCWT5eNe9oKDvsF9
 oPRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793785065; x=1794389865;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=efIOgZ+vxadVYwsjKKc406AJ6LMkZgMS5uKko4OIId0=;
 b=kqL54p/4qi6A0VIlMQWq6np44GeQNcCim4Gaf4OWSaXDA/Uduqy+YN0/swZp26no43
 lvZunEy+exN8mOo9HftMZTYdaoy8O9cYwDulap15g9dRvSH2an9Ovrarsazt8SMCWGme
 P5U0rv2OGZa5aolU1eLH8fybWc5Cyb0pWqXBOmJvieQtz+8Q8gXUwTwr3VrqKrYrqSAw
 +Tpol6vC2Y6cUGizN4/kCrp5VyKFsvScu2RwKFXB02fzFt0T6GKLQeTuGhreG2d6t25+
 Fc04TvkkBKei/W50sjsBhJ+qf6eiOBZacDKPh7ywi3b5z5xjxoZoQhpuh0ydGfBX7mgM
 0cjQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzX80NQrPEU8ncSaiBHSTdgKzBvuvfssralzfsuaxHkLrr84mMgYP3vL5lPX2VJ/7TswWCLvFU=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+S4LF1skiHn993hlOW47dw9zmpWCA7gMUwcPjB9JqW5NZcXx48
 Qv59QNW0ipB164RK7UpUayWgQP8ZEfgDafZ4V5JV/IQtUEydrfq3vzvOlfye8VFjqEVeVz5F6BE
 t8qtw
X-Gm-Gg: AYBFou3eDCq4Yo5ncF2mu4Upsyi4K02n8I831ZUReK3z8UCgItPMO3mQsBLoOYpvXdK
 ycXWYRlNC75UW4aBFZfqQ93ozEV02KdnjF3ShF6SLVGICGZYEgg00OQRRKu4+44FUx9GrimMH2i
 cx4DIYNOppYQLk8ujyOaeHUtOsdySMf69mZMoZovH7sXXufmCvnT5q2vJfmQtBP+zpcnubds8nC
 T0lqodb6CjmskhepV7rjApHmLW/eqhzjo+nGwGfZQu0rYBXkwb0p1X0b8drvusfjTUqhtivHGS+
 C2XKPrszro/rjyq2OZNVDTAsYQhFU9OWG7D+zDba69++0CKHNFFG8FIzb79wDq0i5VNu+skGcoe
 Lw9fLKX0bPqrL1Nt/20bxNCVIvVo4Cv6EntxPRNDflg/Q6lfACAp4cu+7C430ibPEpfOFd3swWT
 XEzxFqXbjV+ihljVwORFgQba4cQ4mCQhBKEgGpqoG+Z1pfRYwRuvwtldCxvgFWtvI6ZzIKIttRi
 PzXdB/lMDExFtb+nlTcK/MpRYADAYh4EE6SxdU5n3TwMF7ir+XPJAD6DhvnqomPLaM1isZ27yxV
 I3ly8FqR8udGodh0jArPH/0oU7sH/zXmmvH5KVUfFq3Ac4NQAJxmEPYxEDo9t4vUZypR8AW8JBk
 mLzlbbC4nKkp53ba9+95pYQpqhzjR/dMdR+z89kZvuVi7Bz2m+TNTj2W5IRNqAZYtsCE3D9Ql4r
 9Ugb3z9qajoAw=
X-Received: by 2002:a05:600c:8483:b0:4a1:dda8:eb73 with SMTP id
 5b1f17b1804b1-4ac1889d4b5mr342804895e9.27.1793785065641; 
 Wed, 04 Nov 2026 01:37:45 -0800 (PST)
Received: from [192.168.1.100]
 (2a02-8434-7c41-c701-8278-849f-666b-c282.rev.sfr.net.
 [2a02:8434:7c41:c701:8278:849f:666b:c282])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48fed08536dsm2563303f8f.32.2026.11.04.01.37.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 01:37:45 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 0/4] Enable USB host support on the Genio 510 and
 700 EVKs
From: Julien Stephan <jstephan@baylibre.com>
To: Carlo Caione <ccaione@baylibre.com>
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org, Jaehoon Chung <jh80.chung@samsung.com>, 
 Peng Fan <peng.fan@nxp.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Alexey Charkov <alchark@flipper.net>, 
 Macpaul Lin <Macpaul.Lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
In-Reply-To: <20261104-ccaione-upstream-mtk-g700-usb-v2-0-b8dc65b47373@baylibre.com>
References: <20261104-ccaione-upstream-mtk-g700-usb-v2-0-b8dc65b47373@baylibre.com>
Date: Wed, 04 Nov 2026 10:38:01 +0100
Message-Id: <179378508144.1254735.792762241008455656.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openssh-sha256; t=1793785089; l=875;
 i=jstephan@baylibre.com; h=from:subject:message-id;
 bh=f6LhM6Tciyd+uG5ys76KXCItSb96cNQe/GTr5A1XJb4=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgphAWFBQbyQxHwqbCvwEwIl9NQxnNa
 Ewt+3w/AUXP10QAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QJKYriEc9EAcepvKpZV4r7JAsRDkMCp4u99j5H6t+eI5VS2zp1t2OSfN9qKsiDRdMBU7oUzonK9
 nDIZ7hkwJRwk=
X-Developer-Key: i=jstephan@baylibre.com; a=openssh;
 fpr=SHA256:PPc8djUi3lnQXuiRHH4CZ/icbEYOsksrEsOV7pDEmZg
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 04 Nov 2026 09:50:28 +0100, Carlo Caione <ccaione@baylibre.com> wrote:
> Enable USB host support on the Genio 510 and 700 EVKs
> 
> Enable the USB-C PD host port on the MediaTek Genio 510 and 700 EVKs
> using the existing MTU3, xHCI and T-PHY drivers. Both boards share the
> same USB controller, PHY, onboard hub and connector wiring.
> 
> Two supporting changes are needed before enabling the boards: the PMIC
> wrapper must recognize fallback compatible strings, and the onboard-hub
> driver must initialize the TI TUSB8020B hub's power and reset controls.
> The remaining patches provide fixed-host settings in the shared U-Boot
> device tree and enable the required drivers in the MT8188 configuration
> fragment used by both boards.
> 
> [...]

Reviewed-by: Julien Stephan <jstephan@baylibre.com>

-- 
Julien Stephan <jstephan@baylibre.com>
